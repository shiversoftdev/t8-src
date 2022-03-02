// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace duplicate_render;

/*
	Name: function_89f2df9
	Namespace: duplicate_render
	Checksum: 0x37B13407
	Offset: 0x2F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"duplicate_render", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: duplicate_render
	Checksum: 0x25565447
	Offset: 0x340
	Size: 0x3C6
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.drfilters))
	{
		level.drfilters = [];
	}
	set_dr_filter_framebuffer("none_fb", 0, undefined, undefined, 0, 1, 0);
	set_dr_filter_framebuffer_duplicate("none_fbd", 0, undefined, undefined, 1, 0, 0);
	set_dr_filter_offscreen("none_os", 0, undefined, undefined, 2, 0, 0);
	set_dr_filter_framebuffer("frveh_fb", 8, "friendlyvehicle_fb", undefined, 0, 1, 1);
	set_dr_filter_offscreen("retrv", 5, "retrievable", undefined, 2, "mc/hud_keyline_retrievable", 1);
	set_dr_filter_offscreen("unplc", 7, "unplaceable", undefined, 2, "mc/hud_keyline_unplaceable", 1);
	set_dr_filter_offscreen("eneqp", 8, "enemyequip", undefined, 2, "mc/hud_outline_rim", 1);
	set_dr_filter_offscreen("enexp", 8, "enemyexplo", undefined, 2, "mc/hud_outline_rim", 1);
	set_dr_filter_offscreen("enveh", 8, "enemyvehicle", undefined, 2, "mc/hud_outline_rim", 1);
	set_dr_filter_offscreen("freqp", 8, "friendlyequip", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
	set_dr_filter_offscreen("frexp", 8, "friendlyexplo", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
	set_dr_filter_offscreen("frveh", 8, "friendlyvehicle", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
	set_dr_filter_offscreen("infrared", 9, "infrared_entity", undefined, 2, 2, 1);
	set_dr_filter_offscreen("threat_detector_enemy", 10, "threat_detector_enemy", undefined, 2, "mc/hud_keyline_enemyequip", 1);
	set_dr_filter_offscreen("bcarrier", 9, "ballcarrier", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
	set_dr_filter_offscreen("poption", 9, "passoption", undefined, 2, "mc/hud_keyline_friendlyequip", 1);
	set_dr_filter_offscreen("draft_unselected", 10, "draft_unselected", undefined, 0, "mc/hud_outline_model_z_scriptint", 1);
	level.friendlycontentoutlines = getdvarint(#"friendlycontentoutlines", 0);
}

/*
	Name: on_player_spawned
	Namespace: duplicate_render
	Checksum: 0x437B332F
	Offset: 0x710
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function on_player_spawned(local_client_num)
{
	self.currentdrfilter = [];
	self change_dr_flags(local_client_num);
	if(!level flagsys::get(#"duplicaterender_registry_ready"))
	{
		waitframe(1);
		level flagsys::set(#"duplicaterender_registry_ready");
	}
}

/*
	Name: set_dr_filter
	Namespace: duplicate_render
	Checksum: 0x7BF740C5
	Offset: 0x790
	Size: 0x37C
	Parameters: 14
	Flags: Linked
*/
function set_dr_filter(filterset, name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3)
{
	if(!isdefined(level.drfilters))
	{
		level.drfilters = [];
	}
	if(!isdefined(level.drfilters[filterset]))
	{
		level.drfilters[filterset] = [];
	}
	if(!isdefined(level.drfilters[filterset][name]))
	{
		level.drfilters[filterset][name] = spawnstruct();
	}
	filter = level.drfilters[filterset][name];
	filter.name = name;
	filter.priority = priority * -1;
	if(!isdefined(require_flags))
	{
		filter.require = [];
	}
	else
	{
		if(isarray(require_flags))
		{
			filter.require = require_flags;
		}
		else
		{
			filter.require = strtok(require_flags, ",");
		}
	}
	if(!isdefined(refuse_flags))
	{
		filter.refuse = [];
	}
	else
	{
		if(isarray(refuse_flags))
		{
			filter.refuse = refuse_flags;
		}
		else
		{
			filter.refuse = strtok(refuse_flags, ",");
		}
	}
	filter.types = [];
	filter.values = [];
	filter.culling = [];
	filter.method = [];
	if(isdefined(drtype1))
	{
		idx = filter.types.size;
		filter.types[idx] = drtype1;
		filter.values[idx] = drval1;
		filter.culling[idx] = drcull1;
	}
	if(isdefined(drtype2))
	{
		idx = filter.types.size;
		filter.types[idx] = drtype2;
		filter.values[idx] = drval2;
		filter.culling[idx] = drcull2;
	}
	if(isdefined(drtype3))
	{
		idx = filter.types.size;
		filter.types[idx] = drtype3;
		filter.values[idx] = drval3;
		filter.culling[idx] = drcull3;
	}
	thread register_filter_materials(filter);
}

/*
	Name: set_dr_filter_framebuffer
	Namespace: duplicate_render
	Checksum: 0xED5DFB70
	Offset: 0xB18
	Size: 0xB4
	Parameters: 13
	Flags: Linked
*/
function set_dr_filter_framebuffer(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3)
{
	set_dr_filter("framebuffer", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

/*
	Name: set_dr_filter_framebuffer_duplicate
	Namespace: duplicate_render
	Checksum: 0xD38985FD
	Offset: 0xBD8
	Size: 0xB4
	Parameters: 13
	Flags: Linked
*/
function set_dr_filter_framebuffer_duplicate(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3)
{
	set_dr_filter("framebuffer_duplicate", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

/*
	Name: set_dr_filter_offscreen
	Namespace: duplicate_render
	Checksum: 0x5F9AABBC
	Offset: 0xC98
	Size: 0xB4
	Parameters: 13
	Flags: Linked
*/
function set_dr_filter_offscreen(name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3)
{
	set_dr_filter("offscreen", name, priority, require_flags, refuse_flags, drtype1, drval1, drcull1, drtype2, drval2, drcull2, drtype3, drval3, drcull3);
}

/*
	Name: register_filter_materials
	Namespace: duplicate_render
	Checksum: 0xC16DD3D6
	Offset: 0xD58
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function register_filter_materials(filter)
{
	playercount = undefined;
	opts = filter.types.size;
	for(i = 0; i < opts; i++)
	{
		value = filter.values[i];
		if(isstring(value))
		{
			if(!isdefined(playercount))
			{
				while(!isdefined(level.localplayers) && !isdefined(level.frontendclientconnected))
				{
					waitframe(1);
				}
				if(isdefined(level.frontendclientconnected))
				{
					playercount = 1;
				}
				else
				{
					util::waitforallclients();
					playercount = level.localplayers.size;
				}
			}
			if(!isdefined(filter::mapped_material_id(value)))
			{
				for(localclientnum = 0; localclientnum < playercount; localclientnum++)
				{
					filter::map_material_helper_by_localclientnum(localclientnum, value);
				}
			}
		}
	}
	filter.priority = abs(filter.priority);
}

/*
	Name: update_dr_flag
	Namespace: duplicate_render
	Checksum: 0xEAD80250
	Offset: 0xEE0
	Size: 0x5C
	Parameters: 3
	Flags: Linked
*/
function update_dr_flag(localclientnum, toset, setto = 1)
{
	if(set_dr_flag(toset, setto))
	{
		update_dr_filters(localclientnum);
	}
}

/*
	Name: set_dr_flag_not_array
	Namespace: duplicate_render
	Checksum: 0x90C34392
	Offset: 0xF48
	Size: 0xC0
	Parameters: 2
	Flags: None
*/
function set_dr_flag_not_array(toset, setto = 1)
{
	if(!isdefined(self.flag) || !isdefined(self.flag[toset]))
	{
		self flag::init(toset);
	}
	if(setto == self.flag[toset])
	{
		return false;
	}
	if(isdefined(setto) && setto)
	{
		self flag::set(toset);
	}
	else
	{
		self flag::clear(toset);
	}
	return true;
}

/*
	Name: set_dr_flag
	Namespace: duplicate_render
	Checksum: 0x785FDED0
	Offset: 0x1010
	Size: 0x170
	Parameters: 2
	Flags: Linked
*/
function set_dr_flag(toset, setto = 1)
{
	/#
		assert(isdefined(setto));
	#/
	if(isarray(toset))
	{
		foreach(ts in toset)
		{
			set_dr_flag(ts, setto);
		}
		return;
	}
	if(!isdefined(self.flag) || !isdefined(self.flag[toset]))
	{
		self flag::init(toset);
	}
	if(setto == self.flag[toset])
	{
		return false;
	}
	if(isdefined(setto) && setto)
	{
		self flag::set(toset);
	}
	else
	{
		self flag::clear(toset);
	}
	return true;
}

/*
	Name: clear_dr_flag
	Namespace: duplicate_render
	Checksum: 0xDBC722DF
	Offset: 0x1188
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function clear_dr_flag(toclear)
{
	set_dr_flag(toclear, 0);
}

/*
	Name: change_dr_flags
	Namespace: duplicate_render
	Checksum: 0x1E84EA47
	Offset: 0x11B8
	Size: 0xE4
	Parameters: 3
	Flags: Linked
*/
function change_dr_flags(localclientnum, toset, toclear)
{
	if(isdefined(toset))
	{
		if(isstring(toset))
		{
			toset = strtok(toset, ",");
		}
		self set_dr_flag(toset);
	}
	if(isdefined(toclear))
	{
		if(isstring(toclear))
		{
			toclear = strtok(toclear, ",");
		}
		self clear_dr_flag(toclear);
	}
	update_dr_filters(localclientnum);
}

/*
	Name: _update_dr_filters
	Namespace: duplicate_render
	Checksum: 0x3C53229A
	Offset: 0x12A8
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function _update_dr_filters(localclientnum)
{
	self notify(#"update_dr_filters");
	self endon(#"update_dr_filters");
	self endon(#"death");
	waittillframeend();
	foreach(key, filterset in level.drfilters)
	{
		filter = self find_dr_filter(filterset);
		if(isdefined(filter) && (!isdefined(self.currentdrfilter) || !self.currentdrfilter[key] === filter.name))
		{
			self apply_filter(localclientnum, filter, key);
		}
	}
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self thread disable_all_filters_on_game_ended();
	}
}

/*
	Name: update_dr_filters
	Namespace: duplicate_render
	Checksum: 0xF1AB1C51
	Offset: 0x1418
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function update_dr_filters(localclientnum)
{
	self thread _update_dr_filters(localclientnum);
}

/*
	Name: find_dr_filter
	Namespace: duplicate_render
	Checksum: 0x1B434C1F
	Offset: 0x1448
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function find_dr_filter(filterset = level.drfilters[#"framebuffer"])
{
	best = undefined;
	foreach(filter in filterset)
	{
		if(self can_use_filter(filter))
		{
			if(!isdefined(best) || filter.priority > best.priority)
			{
				best = filter;
			}
		}
	}
	return best;
}

/*
	Name: can_use_filter
	Namespace: duplicate_render
	Checksum: 0xF10F1278
	Offset: 0x1538
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function can_use_filter(filter)
{
	for(i = 0; i < filter.require.size; i++)
	{
		if(!self flagsys::get(filter.require[i]))
		{
			return false;
		}
	}
	for(i = 0; i < filter.refuse.size; i++)
	{
		if(self flagsys::get(filter.refuse[i]))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: apply_filter
	Namespace: duplicate_render
	Checksum: 0xF997B113
	Offset: 0x15F8
	Size: 0x306
	Parameters: 3
	Flags: Linked
*/
function apply_filter(localclientnum, filter, filterset = "framebuffer")
{
	if(isdefined(level.postgame) && level.postgame && (!(isdefined(level.showedtopthreeplayers) && level.showedtopthreeplayers)))
	{
		if(!function_1cbf351b(localclientnum))
		{
			return;
		}
	}
	/#
		if(getdvarint(#"scr_debug_duplicaterender", 0))
		{
			name = "";
			if(isplayer(self))
			{
				if(isdefined(self.name))
				{
					name = "" + self.name;
				}
			}
			else if(isdefined(self.model))
			{
				name = name + ("" + self.model);
			}
			msg = (((("" + filter.name) + "") + name) + "") + filterset;
			println(msg);
		}
	#/
	if(!isdefined(self.currentdrfilter))
	{
		self.currentdrfilter = [];
	}
	self.currentdrfilter[filterset] = filter.name;
	opts = filter.types.size;
	for(i = 0; i < opts; i++)
	{
		type = filter.types[i];
		value = filter.values[i];
		culling = filter.culling[i];
		var_385a59fa = filter.method[i];
		material = undefined;
		if(isstring(value))
		{
			material = filter::mapped_material_id(value);
			if(!isdefined(var_385a59fa))
			{
				var_385a59fa = 3;
			}
			if(isdefined(material))
			{
				self addduplicaterenderoption(type, var_385a59fa, material, culling);
			}
			else
			{
				self.currentdrfilter[filterset] = undefined;
			}
			continue;
		}
		self addduplicaterenderoption(type, value, -1, culling);
	}
}

/*
	Name: disable_all_filters_on_game_ended
	Namespace: duplicate_render
	Checksum: 0xA55DF227
	Offset: 0x1908
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function disable_all_filters_on_game_ended()
{
	self endon(#"death");
	self notify(#"disable_all_filters_on_game_ended");
	self endon(#"disable_all_filters_on_game_ended");
	level waittill(#"post_game");
	self disableduplicaterendering();
}

/*
	Name: set_item_retrievable
	Namespace: duplicate_render
	Checksum: 0xE2DA1EC8
	Offset: 0x1980
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function set_item_retrievable(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "retrievable", on_off);
}

/*
	Name: set_item_unplaceable
	Namespace: duplicate_render
	Checksum: 0x74606E24
	Offset: 0x19C0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function set_item_unplaceable(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "unplaceable", on_off);
}

/*
	Name: set_item_enemy_equipment
	Namespace: duplicate_render
	Checksum: 0x44AD9803
	Offset: 0x1A00
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function set_item_enemy_equipment(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "enemyequip", on_off);
}

/*
	Name: set_item_friendly_equipment
	Namespace: duplicate_render
	Checksum: 0x1E03F26D
	Offset: 0x1A40
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function set_item_friendly_equipment(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "friendlyequip", on_off);
}

/*
	Name: set_entity_thermal
	Namespace: duplicate_render
	Checksum: 0x1C0BBBC8
	Offset: 0x1A80
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function set_entity_thermal(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "infrared_entity", on_off);
}

/*
	Name: set_player_threat_detected
	Namespace: duplicate_render
	Checksum: 0x83EE9896
	Offset: 0x1AC0
	Size: 0x34
	Parameters: 2
	Flags: None
*/
function set_player_threat_detected(localclientnum, on_off)
{
	self update_dr_flag(localclientnum, "threat_detector_enemy", on_off);
}

/*
	Name: set_hacker_tool_hacked
	Namespace: duplicate_render
	Checksum: 0xCB9120AC
	Offset: 0x1B00
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function set_hacker_tool_hacked(localclientnum, on_off)
{
}

/*
	Name: set_hacker_tool_hacking
	Namespace: duplicate_render
	Checksum: 0x2564DD9E
	Offset: 0x1B20
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function set_hacker_tool_hacking(localclientnum, on_off)
{
}

/*
	Name: set_hacker_tool_breaching
	Namespace: duplicate_render
	Checksum: 0x88415731
	Offset: 0x1B40
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function set_hacker_tool_breaching(localclientnum, on_off)
{
}

/*
	Name: show_friendly_outlines
	Namespace: duplicate_render
	Checksum: 0xB606D635
	Offset: 0x1B60
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function show_friendly_outlines(local_client_num)
{
	if(!(isdefined(level.friendlycontentoutlines) && level.friendlycontentoutlines))
	{
		return false;
	}
	if(shoutcaster::is_shoutcaster(local_client_num))
	{
		return false;
	}
	return true;
}

/*
	Name: set_entity_draft_unselected
	Namespace: duplicate_render
	Checksum: 0xE5682AAA
	Offset: 0x1BB8
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function set_entity_draft_unselected(localclientnum, on_off)
{
	if(util::function_3f165ee8())
	{
		rob = #"hash_79892e1d5a8f9f33";
	}
	else
	{
		if(util::function_26489405())
		{
			rob = #"hash_5418181592b8b61a";
		}
		else
		{
			rob = #"hash_68bd6efcb1324e3";
		}
	}
	if(isdefined(on_off) && on_off)
	{
		self function_bf9d3071(rob);
	}
	else
	{
		self function_5d482e78(rob);
	}
}

