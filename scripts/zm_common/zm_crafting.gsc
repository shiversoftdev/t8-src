// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\trials\zm_trial_disable_buys.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_progress.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_contracts.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_crafting;

/*
	Name: __init__system__
	Namespace: zm_crafting
	Checksum: 0x1C1A68D7
	Offset: 0x288
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_crafting", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_crafting
	Checksum: 0x8E21F656
	Offset: 0x2D8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_5df2581a = [];
	level.crafting_components = [];
	function_475a63eb();
}

/*
	Name: __main__
	Namespace: zm_crafting
	Checksum: 0x5DFC93AD
	Offset: 0x318
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	function_7a8f3cbd();
	function_60a6c623();
	setup_tables();
	if(zombie_utility::function_d2dfacfd(#"highlight_craftables") || zm_custom::function_901b751c(#"zmcraftingkeyline"))
	{
		level thread function_40f32480();
	}
	/#
		thread devgui_think();
	#/
}

/*
	Name: function_60a6c623
	Namespace: zm_crafting
	Checksum: 0x462B6829
	Offset: 0x3C8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_60a6c623()
{
	foundries = getscriptbundles("craftfoundry");
	foreach(foundry in foundries)
	{
		setup_craftfoundry(foundry);
	}
}

/*
	Name: setup_craftfoundry
	Namespace: zm_crafting
	Checksum: 0x5B10C0C5
	Offset: 0x468
	Size: 0x27C
	Parameters: 1
	Flags: Linked
*/
function setup_craftfoundry(craftfoundry)
{
	if(isdefined(craftfoundry))
	{
		if(!(isdefined(craftfoundry.loaded) && craftfoundry.loaded))
		{
			craftfoundry.loaded = 1;
			craftfoundry.blueprints = [];
			switch(craftfoundry.var_2a2adea3)
			{
				case 8:
				{
					craftfoundry.blueprints[7] = function_b18074d0(craftfoundry.var_b81b4995);
				}
				case 7:
				{
					craftfoundry.blueprints[6] = function_b18074d0(craftfoundry.var_5e039567);
				}
				case 6:
				{
					craftfoundry.blueprints[5] = function_b18074d0(craftfoundry.var_b84049db);
				}
				case 5:
				{
					craftfoundry.blueprints[4] = function_b18074d0(craftfoundry.var_5dee9539);
				}
				case 4:
				{
					craftfoundry.blueprints[3] = function_b18074d0(craftfoundry.var_93b280c0);
				}
				case 3:
				{
					craftfoundry.blueprints[2] = function_b18074d0(craftfoundry.var_a980ac5c);
				}
				case 2:
				{
					craftfoundry.blueprints[1] = function_b18074d0(craftfoundry.var_339dfcd);
				}
				case 1:
				{
					craftfoundry.blueprints[0] = function_b18074d0(craftfoundry.var_110b7b70);
				}
			}
			/#
				function_e197bb07(craftfoundry);
			#/
		}
	}
}

/*
	Name: setup_tables
	Namespace: zm_crafting
	Checksum: 0x1DBB003
	Offset: 0x6F0
	Size: 0x248
	Parameters: 0
	Flags: Linked
*/
function setup_tables()
{
	level.var_4fe2f84d = [];
	var_c443493d = getentarray("crafting_trigger", "targetname");
	foreach(trigger in var_c443493d)
	{
		var_6886faaa = trigger.var_6886faaa;
		if(isdefined(var_6886faaa))
		{
			trigger.craftfoundry = function_c1552513(var_6886faaa);
		}
		else
		{
			/#
				assertmsg("");
			#/
		}
		unitrigger = function_f665fde0(trigger);
		if(!isdefined(level.var_4fe2f84d[var_6886faaa]))
		{
			level.var_4fe2f84d[var_6886faaa] = [];
		}
		if(!isdefined(level.var_4fe2f84d[var_6886faaa]))
		{
			level.var_4fe2f84d[var_6886faaa] = [];
		}
		else if(!isarray(level.var_4fe2f84d[var_6886faaa]))
		{
			level.var_4fe2f84d[var_6886faaa] = array(level.var_4fe2f84d[var_6886faaa]);
		}
		if(!isinarray(level.var_4fe2f84d[var_6886faaa], unitrigger))
		{
			level.var_4fe2f84d[var_6886faaa][level.var_4fe2f84d[var_6886faaa].size] = unitrigger;
		}
		unitrigger thread function_356e77bd();
		/#
			level thread function_3012605d(unitrigger);
		#/
	}
}

/*
	Name: reset_table
	Namespace: zm_crafting
	Checksum: 0x8A225B6A
	Offset: 0x940
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function reset_table()
{
	/#
		assert(!(isdefined(self.registered) && self.registered), "");
	#/
	zm_unitrigger::register_static_unitrigger(self, &crafting_think);
	self function_35f5c90b(#"craft");
	self.crafted = 0;
	self.blueprint.completed = 0;
}

/*
	Name: function_c1552513
	Namespace: zm_crafting
	Checksum: 0x4532F60
	Offset: 0x9E0
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_c1552513(name)
{
	craftfoundry = struct::get_script_bundle("craftfoundry", name);
	if(isdefined(craftfoundry))
	{
		craftfoundry.name = name;
		setup_craftfoundry(craftfoundry);
	}
	else
	{
		/#
			assertmsg("" + name);
		#/
	}
	return craftfoundry;
}

/*
	Name: function_b18074d0
	Namespace: zm_crafting
	Checksum: 0xC458EB91
	Offset: 0xA70
	Size: 0x4E8
	Parameters: 1
	Flags: Linked
*/
function function_b18074d0(name)
{
	blueprint = struct::get_script_bundle("craftblueprint", name);
	if(isdefined(blueprint))
	{
		if(!(isdefined(blueprint.loaded) && blueprint.loaded))
		{
			blueprint.loaded = 1;
			blueprint.name = name;
			blueprint.components = [];
			switch(blueprint.var_f4a82731)
			{
				case 8:
				{
					blueprint.components[7] = get_component(blueprint.var_f4d434cb, blueprint);
				}
				case 7:
				{
					blueprint.components[6] = get_component(blueprint.var_e71f1961, blueprint);
				}
				case 6:
				{
					blueprint.components[5] = get_component(blueprint.registerperk_packa_seepainterminate, blueprint);
				}
				case 5:
				{
					blueprint.components[4] = get_component(blueprint.var_4282502a, blueprint);
				}
				case 4:
				{
					blueprint.components[3] = get_component(blueprint.var_7b8e4241, blueprint);
				}
				case 3:
				{
					blueprint.components[2] = get_component(blueprint.var_2e0a273a, blueprint);
				}
				case 2:
				{
					blueprint.components[1] = get_component(blueprint.var_670f9944, blueprint);
				}
				case 1:
				{
					blueprint.components[0] = get_component(blueprint.var_99577dd3, blueprint);
				}
			}
			blueprint.var_54a97edd = get_component(blueprint.result, blueprint);
			x = (isdefined(blueprint.var_2206e7ed) ? float(blueprint.var_2206e7ed) : 0);
			y = (isdefined(blueprint.var_e414062) ? float(blueprint.var_e414062) : 0);
			z = (isdefined(blueprint.var_3c809ce0) ? float(blueprint.var_3c809ce0) : 0);
			blueprint.v_offset = (x, y, z);
			x = (isdefined(blueprint.prj_scr_round_pause) ? float(blueprint.prj_scr_round_pause) : 0);
			y = (isdefined(blueprint.var_11928e3b) ? float(blueprint.var_11928e3b) : 0);
			z = (isdefined(blueprint.var_71c8b937) ? float(blueprint.var_71c8b937) : 0);
			blueprint.v_angles = (x, y, z);
			if(!isdefined(blueprint.var_4dbc4aee))
			{
				blueprint.var_4dbc4aee = "ERROR: Missing Prompt String";
			}
			function_728a82e0(blueprint);
			/#
				level thread function_e5af6b6e(blueprint);
			#/
		}
	}
	else
	{
		/#
			assertmsg("" + name);
		#/
	}
	return blueprint;
}

/*
	Name: get_component
	Namespace: zm_crafting
	Checksum: 0x281804F0
	Offset: 0xF60
	Size: 0x260
	Parameters: 2
	Flags: Linked
*/
function get_component(component, blueprint)
{
	if(isstring(component) || ishash(component))
	{
		component = getweapon(component);
	}
	if(!isdefined(level.crafting_components[component.name]))
	{
		if(component == level.weaponnone)
		{
			/#
				assertmsg("");
			#/
		}
		/#
			function_4765f5b3(component);
		#/
		level.crafting_components[component.name] = component;
	}
	if(isdefined(blueprint) && isdefined(blueprint.result))
	{
		if(isdefined(blueprint.result.isriotshield) && blueprint.result.isriotshield)
		{
			if(!zm_custom::function_901b751c(#"zmshieldisenabled"))
			{
				a_items = getitemarray();
				foreach(e_item in a_items)
				{
					if(e_item.item == component)
					{
						e_item delete();
					}
				}
			}
			else
			{
				zm_items::function_4d230236(component, &function_86531922);
			}
		}
		else
		{
			zm_items::function_4d230236(component, &function_d56724a6);
		}
	}
	return level.crafting_components[component.name];
}

/*
	Name: function_40f32480
	Namespace: zm_crafting
	Checksum: 0xC96A13FE
	Offset: 0x11C8
	Size: 0xF0
	Parameters: 0
	Flags: Linked, Private
*/
function private function_40f32480()
{
	level waittill(#"all_players_spawned");
	a_items = getitemarray();
	foreach(e_item in a_items)
	{
		if(isdefined(e_item.item) && isinarray(level.crafting_components, e_item.item))
		{
			e_item clientfield::set("highlight_item", 1);
		}
	}
}

/*
	Name: function_728a82e0
	Namespace: zm_crafting
	Checksum: 0xC49F82A7
	Offset: 0x12C0
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_728a82e0(blueprint)
{
	if(!isdefined(level.var_5df2581a[blueprint.name]))
	{
		blueprint.completed = 0;
		blueprint.builder = undefined;
		level.var_5df2581a[blueprint.name] = blueprint;
	}
}

/*
	Name: function_31d883d7
	Namespace: zm_crafting
	Checksum: 0x4321D4A7
	Offset: 0x1328
	Size: 0xD8
	Parameters: 0
	Flags: None
*/
function function_31d883d7()
{
	results = [];
	foreach(blueprint in level.var_5df2581a)
	{
		if(blueprint.completed)
		{
			if(!isdefined(results))
			{
				results = [];
			}
			else if(!isarray(results))
			{
				results = array(results);
			}
			results[results.size] = blueprint;
		}
	}
	return results;
}

/*
	Name: function_4165306b
	Namespace: zm_crafting
	Checksum: 0x778183E7
	Offset: 0x1408
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_4165306b(player)
{
	results = [];
	if(isdefined(self.craftfoundry.blueprints))
	{
		foreach(blueprint in self.craftfoundry.blueprints)
		{
			if(!blueprint.completed && function_6d1e4410(player, blueprint))
			{
				if(!isdefined(results))
				{
					results = [];
				}
				else if(!isarray(results))
				{
					results = array(results);
				}
				results[results.size] = blueprint;
			}
		}
	}
	else
	{
		blueprint = self.craftfoundry;
		if(!blueprint.completed && function_6d1e4410(player, blueprint))
		{
			if(!isdefined(results))
			{
				results = [];
			}
			else if(!isarray(results))
			{
				results = array(results);
			}
			results[results.size] = blueprint;
		}
	}
	return results;
}

/*
	Name: function_6d1e4410
	Namespace: zm_crafting
	Checksum: 0x5C478BD9
	Offset: 0x15B8
	Size: 0x9A
	Parameters: 2
	Flags: Linked
*/
function function_6d1e4410(player, blueprint)
{
	foreach(component in blueprint.components)
	{
		if(!zm_items::player_has(player, component))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_6f635422
	Namespace: zm_crafting
	Checksum: 0x3FF68145
	Offset: 0x1660
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function function_6f635422(player, blueprint)
{
	foreach(component in blueprint.components)
	{
		if(zm_items::player_has(player, component))
		{
			zm_items::player_take(player, component);
		}
	}
}

/*
	Name: function_7a8f3cbd
	Namespace: zm_crafting
	Checksum: 0xE12F4CAA
	Offset: 0x1710
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_7a8f3cbd()
{
	level.var_90237ebd = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
	level.var_98dad84e = zm_progress::function_53a680b8(&function_7362ecc8, &function_8962a3bb, &function_735c3a67, &function_f7dbfdf9, &function_d95a600f, &function_73f3bb03);
	zm_progress::function_163442cb(level.var_98dad84e, level.weaponnone);
}

/*
	Name: function_7362ecc8
	Namespace: zm_crafting
	Checksum: 0xB605EE7E
	Offset: 0x1838
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function function_7362ecc8(player, unitrigger)
{
	if(isdefined(unitrigger.locked) && unitrigger.locked)
	{
		return false;
	}
	blueprints = unitrigger function_4165306b(player);
	if(blueprints.size < 1)
	{
		return false;
	}
	if(isdefined(unitrigger.blueprint.locked) && unitrigger.blueprint.locked)
	{
		return false;
	}
	return true;
}

/*
	Name: function_8962a3bb
	Namespace: zm_crafting
	Checksum: 0xAE9AF54C
	Offset: 0x18E8
	Size: 0x18
	Parameters: 2
	Flags: Linked
*/
function function_8962a3bb(player, unitrigger)
{
	return true;
}

/*
	Name: function_735c3a67
	Namespace: zm_crafting
	Checksum: 0x97BC6341
	Offset: 0x1908
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_735c3a67(player, unitrigger)
{
	if(isdefined(player))
	{
		unitrigger.locked = 1;
		unitrigger.blueprint.locked = 1;
		player playsound(#"hash_1fff2aa71bff91fa");
	}
}

/*
	Name: function_f7dbfdf9
	Namespace: zm_crafting
	Checksum: 0xAC7522F8
	Offset: 0x1978
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_f7dbfdf9(player, unitrigger)
{
	if(isdefined(player))
	{
		player notify(#"crafting_fail");
		player playsound(#"hash_15b7f680d9f65b62");
	}
}

/*
	Name: function_d95a600f
	Namespace: zm_crafting
	Checksum: 0xB7C71F51
	Offset: 0x19D8
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_d95a600f(player, unitrigger)
{
	if(isdefined(player))
	{
		player notify(#"crafting_success");
		player playsound(#"hash_421a00cb329b2a45");
	}
}

/*
	Name: function_73f3bb03
	Namespace: zm_crafting
	Checksum: 0xA2D50ED7
	Offset: 0x1A38
	Size: 0x36
	Parameters: 2
	Flags: Linked
*/
function function_73f3bb03(player, unitrigger)
{
	unitrigger.locked = 0;
	unitrigger.blueprint.locked = 0;
}

/*
	Name: function_7bffa1ac
	Namespace: zm_crafting
	Checksum: 0xCDF1D140
	Offset: 0x1A78
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_7bffa1ac(weapon)
{
	if(zm_equipment::is_equipment(weapon))
	{
		if(zm_equipment::is_limited(weapon) && zm_equipment::limited_in_use(weapon))
		{
			return 1;
		}
		return 0;
	}
	return !zm_weapons::limited_weapon_below_quota(weapon, undefined);
}

/*
	Name: function_2d53738e
	Namespace: zm_crafting
	Checksum: 0xEF2D3B6A
	Offset: 0x1B00
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_2d53738e(weapon)
{
	if(zm_equipment::is_equipment(weapon))
	{
		return zm_equipment::is_player_equipment(weapon);
	}
	return self hasweapon(weapon);
}

/*
	Name: function_48ce9379
	Namespace: zm_crafting
	Checksum: 0x2FFD9D3
	Offset: 0x1B60
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function function_48ce9379(weapon)
{
	if(isdefined(self.var_4e90ce0c))
	{
		return array::contains(self.var_4e90ce0c, weapon);
	}
	return 0;
}

/*
	Name: function_126fc77c
	Namespace: zm_crafting
	Checksum: 0xEA09AB22
	Offset: 0x1BA0
	Size: 0x1B8
	Parameters: 1
	Flags: Linked
*/
function function_126fc77c(player)
{
	if(!isdefined(self.stub))
	{
		/#
			iprintlnbold("");
		#/
		return 0;
	}
	can_use = self.stub function_18f2be60(player);
	if(!isdefined(self.stub.hint_string))
	{
		/#
			iprintlnbold("");
		#/
		return can_use;
	}
	if(isdefined(level.var_a6f62e91) && isdefined(self.stub.cost) && self.stub [[level.var_a6f62e91]](player, #"crafting_table"))
	{
		self sethintstringforplayer(player, self.stub.hint_string, self.stub.cost);
	}
	else
	{
		if(isdefined(self.stub.cost) && self.stub.cost != 0)
		{
			self sethintstring(self.stub.hint_string, self.stub.cost);
		}
		else
		{
			self sethintstring(self.stub.hint_string);
		}
	}
	return can_use;
}

/*
	Name: function_f665fde0
	Namespace: zm_crafting
	Checksum: 0x976DCC53
	Offset: 0x1D60
	Size: 0x8A8
	Parameters: 1
	Flags: Linked
*/
function function_f665fde0(trig)
{
	if(!isdefined(trig))
	{
		return;
	}
	unitrigger_stub = spawnstruct();
	unitrigger_stub.craftfoundry = trig.craftfoundry;
	if(zm_utility::get_story() == 1 && isdefined(trig.target2))
	{
		unitrigger_stub.var_c2f40a58 = getent(trig.target2, "targetname");
		unitrigger_stub.var_c2f40a58 ghost();
	}
	if(zm_utility::get_story() == 1 && isdefined(trig.target3))
	{
		unitrigger_stub.var_4f749ffe = getent(trig.target3, "targetname");
		unitrigger_stub.var_4f749ffe ghost();
	}
	if(zm_utility::get_story() == 1 && isdefined(trig.target4))
	{
		unitrigger_stub.var_4b9b60c7 = getent(trig.target4, "targetname");
		unitrigger_stub.var_4b9b60c7 ghost();
	}
	angles = trig.script_angles;
	if(!isdefined(angles))
	{
		angles = (0, 0, 0);
	}
	unitrigger_stub.origin = trig.origin + (anglestoright(angles) * -6);
	unitrigger_stub.angles = trig.angles;
	if(isdefined(trig.script_angles))
	{
		unitrigger_stub.angles = trig.script_angles;
	}
	unitrigger_stub.delete_trigger = 1;
	unitrigger_stub.crafted = 0;
	unitrigger_stub.usetime = int(3000);
	if(isdefined(self.usetime))
	{
		unitrigger_stub.usetime = self.usetime;
	}
	else if(isdefined(trig.usetime))
	{
		unitrigger_stub.usetime = trig.usetime;
	}
	tmins = trig getmins();
	tmaxs = trig getmaxs();
	tsize = tmaxs - tmins;
	if(isdefined(trig.script_depth))
	{
		unitrigger_stub.script_length = trig.script_depth;
	}
	else
	{
		unitrigger_stub.script_length = tsize[1];
	}
	if(isdefined(trig.script_width))
	{
		unitrigger_stub.script_width = trig.script_width;
	}
	else
	{
		unitrigger_stub.script_width = tsize[0];
	}
	if(isdefined(trig.script_height))
	{
		unitrigger_stub.script_height = trig.script_height;
	}
	else
	{
		unitrigger_stub.script_height = tsize[2];
	}
	unitrigger_stub.target = trig.target;
	unitrigger_stub.targetname = trig.targetname;
	unitrigger_stub.script_noteworthy = trig.script_noteworthy;
	unitrigger_stub.script_parameters = trig.script_parameters;
	unitrigger_stub.script_string = trig.script_string;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	unitrigger_stub.hint_string = #"hash_a502ccb8fec4c7a";
	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.require_look_at = 1;
	unitrigger_stub.require_look_toward = 0;
	unitrigger_stub.var_c060d2c8 = 1;
	zm_unitrigger::unitrigger_force_per_player_triggers(unitrigger_stub, 1);
	unitrigger_stub.prompt_and_visibility_func = &function_126fc77c;
	zm_unitrigger::register_static_unitrigger(unitrigger_stub, &crafting_think);
	unitrigger_stub.piece_trigger = trig;
	trig.trigger_stub = unitrigger_stub;
	if(isdefined(trig.zombie_weapon_upgrade))
	{
		unitrigger_stub.zombie_weapon_upgrade = getweapon(trig.zombie_weapon_upgrade);
	}
	if(isdefined(unitrigger_stub.target))
	{
		m_target = getent(unitrigger_stub.target, "targetname");
		if(isdefined(m_target))
		{
			unitrigger_stub.model = m_target;
			if(isdefined(unitrigger_stub.zombie_weapon_upgrade))
			{
				unitrigger_stub.model useweaponhidetags(unitrigger_stub.zombie_weapon_upgrade);
			}
			if(isdefined(unitrigger_stub.model.script_parameters))
			{
				a_utm_params = strtok(unitrigger_stub.model.script_parameters, " ");
				foreach(param in a_utm_params)
				{
					if(param == "starts_visible")
					{
						b_start_visible = 1;
						continue;
						continue;
					}
					if(param == "starts_empty")
					{
						b_start_empty = 1;
					}
				}
			}
			if(b_start_visible !== 1)
			{
				unitrigger_stub.model ghost();
				unitrigger_stub.model notsolid();
			}
		}
	}
	if(isdefined(unitrigger_stub.model) && b_start_empty === 1)
	{
		for(i = 0; i < unitrigger_stub.craftablespawn.a_piecespawns.size; i++)
		{
			if(isdefined(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name))
			{
				if(unitrigger_stub.craftablespawn.a_piecespawns[i].crafted !== 1)
				{
					unitrigger_stub.model hidepart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
					continue;
				}
				unitrigger_stub.model showpart(unitrigger_stub.craftablespawn.a_piecespawns[i].tag_name);
			}
		}
	}
	if(unitrigger_stub.delete_trigger)
	{
		trig delete();
	}
	unitrigger_stub function_35f5c90b(#"craft");
	return unitrigger_stub;
}

/*
	Name: function_987a472
	Namespace: zm_crafting
	Checksum: 0x95225D8C
	Offset: 0x2610
	Size: 0x22C
	Parameters: 2
	Flags: Linked
*/
function function_987a472(modelname, blueprint)
{
	if(isdefined(self.stub))
	{
		s_crafting = self.stub;
	}
	else
	{
		s_crafting = self;
	}
	if(!isdefined(s_crafting.model))
	{
		s_model = struct::get(s_crafting.target, "targetname");
		if(isdefined(s_model))
		{
			m_spawn = spawn("script_model", s_model.origin);
			m_spawn.origin = m_spawn.origin + blueprint.v_offset;
			if(isdefined(s_crafting.v_origin_offset))
			{
				m_spawn.origin = m_spawn.origin + s_crafting.v_origin_offset;
			}
			m_spawn.angles = s_model.angles;
			m_spawn.angles = m_spawn.angles + blueprint.v_angles;
			if(isdefined(s_crafting.v_angle_offset))
			{
				m_spawn.angles = m_spawn.angles + s_crafting.v_angle_offset;
			}
			m_spawn setmodel(modelname);
			s_crafting.model = m_spawn;
			s_crafting.model notsolid();
			s_crafting.model show();
		}
		else
		{
			/#
				assertmsg("");
			#/
		}
	}
	else
	{
		s_crafting.model notsolid();
		s_crafting.model show();
	}
}

/*
	Name: function_356e77bd
	Namespace: zm_crafting
	Checksum: 0x477BD8B2
	Offset: 0x2848
	Size: 0x78
	Parameters: 0
	Flags: Linked, Private
*/
function private function_356e77bd()
{
	self endon(#"death");
	while(isdefined(self))
	{
		event = undefined;
		event = self waittill(#"unitrigger_activated");
		player = event.player;
		self thread function_514b8f17(player);
	}
}

/*
	Name: function_514b8f17
	Namespace: zm_crafting
	Checksum: 0xE4191AE
	Offset: 0x28C8
	Size: 0x108
	Parameters: 1
	Flags: Linked, Private
*/
function private function_514b8f17(player)
{
	self notify(#"hash_295a022a1c72a359");
	self endon(#"hash_295a022a1c72a359", #"unitrigger_deactivated");
	player endon(#"death");
	player.crafting_melee = 0;
	while(isdefined(player))
	{
		melee_now = player meleebuttonpressed();
		if(melee_now && !player.crafting_melee)
		{
			if(isdefined(self.var_90dfb0bf) && isdefined(level.var_b87dee47[self.var_90dfb0bf].var_cb2020d8))
			{
				self [[level.var_b87dee47[self.var_90dfb0bf].var_cb2020d8]](player);
			}
		}
		player.crafting_melee = melee_now;
		waitframe(1);
	}
}

/*
	Name: function_ca244624
	Namespace: zm_crafting
	Checksum: 0x69041AB7
	Offset: 0x29D8
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_ca244624(var_55426150)
{
	if(!isdefined(level.var_4fe2f84d[var_55426150]))
	{
		return;
	}
	foreach(trigger in level.var_4fe2f84d[var_55426150])
	{
		trigger.locked = 1;
		level thread zm_unitrigger::unregister_unitrigger(trigger);
	}
}

/*
	Name: function_d1f16587
	Namespace: zm_crafting
	Checksum: 0x46E35E1A
	Offset: 0x2A98
	Size: 0x1B2
	Parameters: 2
	Flags: Linked
*/
function function_d1f16587(var_55426150, func)
{
	if(!isdefined(level.var_4fe2f84d[var_55426150]))
	{
		return;
	}
	foreach(trigger in level.var_4fe2f84d[var_55426150])
	{
		if(!isdefined(trigger.craftfoundry.callback_funcs))
		{
			trigger.craftfoundry.callback_funcs = [];
		}
		if(!isdefined(trigger.craftfoundry.callback_funcs))
		{
			trigger.craftfoundry.callback_funcs = [];
		}
		else if(!isarray(trigger.craftfoundry.callback_funcs))
		{
			trigger.craftfoundry.callback_funcs = array(trigger.craftfoundry.callback_funcs);
		}
		if(!isinarray(trigger.craftfoundry.callback_funcs, func))
		{
			trigger.craftfoundry.callback_funcs[trigger.craftfoundry.callback_funcs.size] = func;
		}
	}
}

/*
	Name: function_86531922
	Namespace: zm_crafting
	Checksum: 0x7E3686EA
	Offset: 0x2C58
	Size: 0xEC
	Parameters: 2
	Flags: Linked
*/
function function_86531922(e_holder, w_item)
{
	if(isdefined(w_item.gadgetreadysoundplayer))
	{
		self thread zm_audio::create_and_play_dialog(#"shield_pickup", w_item.gadgetreadysoundplayer);
	}
	else
	{
		self thread zm_audio::create_and_play_dialog(#"shield_piece", #"pickup");
	}
	self playsound(#"hash_230737b2535a3374");
	if(w_item.var_f56ac2bd !== "")
	{
		level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
	}
}

/*
	Name: function_d56724a6
	Namespace: zm_crafting
	Checksum: 0x5796DEB1
	Offset: 0x2D50
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function function_d56724a6(e_holder, w_item)
{
	if(w_item.var_f56ac2bd !== "")
	{
		level zm_ui_inventory::function_7df6bb60(hash(w_item.var_f56ac2bd), 1);
	}
	if(isdefined(w_item.var_25bb96cc))
	{
		self playsound(w_item.var_25bb96cc);
	}
	else
	{
		self playsound(#"hash_230737b2535a3374");
	}
	if(isdefined(w_item.gadgetreadysoundplayer))
	{
		self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.gadgetreadysoundplayer);
	}
	else
	{
		if(isdefined(w_item.var_62a98b13))
		{
			self thread zm_audio::create_and_play_dialog(#"component_pickup", w_item.var_62a98b13);
		}
		else
		{
			self thread zm_audio::create_and_play_dialog(#"component_pickup", #"generic");
		}
	}
}

/*
	Name: function_475a63eb
	Namespace: zm_crafting
	Checksum: 0x8700E8B
	Offset: 0x2EC0
	Size: 0x214
	Parameters: 0
	Flags: Linked, Private
*/
function private function_475a63eb()
{
	if(!isdefined(level.var_b87dee47))
	{
		level.var_b87dee47 = [];
	}
	function_e1eeba22(#"craft", &function_8109ae21, &function_f37c4bb5, &function_b03ccfce, &function_d564a5c0);
	function_e1eeba22(#"persistent_buy", &function_9693e041, &function_df8ce6e2, &function_b03ccfce);
	function_e1eeba22(#"buy_once_then_box", &function_15d10d06, &function_42673a26, &function_6e16f902);
	function_e1eeba22(#"one_time_craft", &function_f189f7f, &function_5a4c40a2, &function_578c67bf);
	function_e1eeba22(#"spawn_as_ingredient", &function_f189f7f, &function_5a4c40a2, &function_3c45b116);
	function_e1eeba22(#"spawn_as_item", &function_f189f7f, &function_5a4c40a2, &function_230f6303);
}

/*
	Name: function_e1eeba22
	Namespace: zm_crafting
	Checksum: 0x39003422
	Offset: 0x30E0
	Size: 0xAE
	Parameters: 5
	Flags: Linked, Private
*/
function private function_e1eeba22(state, var_a3d8c117, var_ea7ebe1f, var_aee03b4c, var_cb2020d8)
{
	var_90dfb0bf = spawnstruct();
	var_90dfb0bf.name = state;
	var_90dfb0bf.var_a3d8c117 = var_a3d8c117;
	var_90dfb0bf.var_ea7ebe1f = var_ea7ebe1f;
	var_90dfb0bf.var_cb2020d8 = var_cb2020d8;
	var_90dfb0bf.var_aee03b4c = var_aee03b4c;
	level.var_b87dee47[state] = var_90dfb0bf;
}

/*
	Name: function_35f5c90b
	Namespace: zm_crafting
	Checksum: 0x2931311D
	Offset: 0x3198
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_35f5c90b(state)
{
	if(!isdefined(state))
	{
		return;
	}
	self.var_90dfb0bf = state;
	if(!isdefined(level.var_b87dee47[self.var_90dfb0bf]))
	{
		/#
			if(ishash(state))
			{
				state = "" + function_9e72a96(state);
			}
			/#
				assertmsg("" + state);
			#/
		#/
		return;
	}
	if(isdefined(level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c))
	{
		self [[level.var_b87dee47[self.var_90dfb0bf].var_aee03b4c]]();
	}
}

/*
	Name: function_18f2be60
	Namespace: zm_crafting
	Checksum: 0xB3DEB050
	Offset: 0x3280
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_18f2be60(player)
{
	if(isdefined(self.locked) && self.locked)
	{
		self.hint_string = "";
		return 0;
	}
	if(player laststand::player_is_in_laststand() || player zm_utility::in_revive_trigger())
	{
		self.hint_string = "";
		return 0;
	}
	if(player zm_utility::is_drinking() && (!(isdefined(player.var_1f8802c9) && player.var_1f8802c9)))
	{
		self.hint_string = "";
		return 0;
	}
	initial_current_weapon = player getcurrentweapon();
	current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
	if(zm_equipment::is_equipment(current_weapon))
	{
		self.hint_string = "";
		return 0;
	}
	if(isdefined(self.var_90dfb0bf))
	{
		return self [[level.var_b87dee47[self.var_90dfb0bf].var_a3d8c117]](player);
	}
	self.hint_string = "";
	return 0;
}

/*
	Name: crafting_think
	Namespace: zm_crafting
	Checksum: 0x8FA00A3E
	Offset: 0x3400
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function crafting_think()
{
	self notify(#"crafting_think");
	self endon(#"crafting_think", #"kill_trigger", #"death");
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		level notify(#"crafting_started", {#activator:player, #unitrigger:self});
		if(isdefined(self.stub.var_90dfb0bf))
		{
			self [[level.var_b87dee47[self.stub.var_90dfb0bf].var_ea7ebe1f]](player);
		}
	}
}

/*
	Name: function_b03ccfce
	Namespace: zm_crafting
	Checksum: 0x80F724D1
	Offset: 0x3518
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b03ccfce()
{
}

/*
	Name: function_f189f7f
	Namespace: zm_crafting
	Checksum: 0xABAE9005
	Offset: 0x3528
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f189f7f(player)
{
	self.hint_string = "";
	return false;
}

/*
	Name: function_5a4c40a2
	Namespace: zm_crafting
	Checksum: 0xE88DA27C
	Offset: 0x3550
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5a4c40a2(player)
{
}

/*
	Name: function_8109ae21
	Namespace: zm_crafting
	Checksum: 0xF27584F5
	Offset: 0x3568
	Size: 0x3BE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8109ae21(player)
{
	blueprints = function_4165306b(player);
	var_9c8338de = blueprints.size;
	if(!isdefined(self.blueprint) || self.var_9c8338de !== var_9c8338de || (isdefined(self.blueprint.completed) && self.blueprint.completed))
	{
		self.blueprint = self.craftfoundry;
		if(blueprints.size)
		{
			if(!isdefined(self.var_c0df4857))
			{
				self.var_c0df4857 = 0;
			}
			if(self.var_c0df4857 >= blueprints.size)
			{
				self.var_c0df4857 = 0;
			}
			self.blueprint = blueprints[self.var_c0df4857];
		}
		self.var_9c8338de = var_9c8338de;
	}
	if(blueprints.size < 1 || !array::contains(blueprints, self.blueprint))
	{
		self.hint_string = #"hash_64cb545dd18c607";
		if(zm_utility::get_story() == 1 && isdefined(self.var_c2f40a58) && (isdefined(self.var_c2f40a58.is_visible) && self.var_c2f40a58.is_visible))
		{
			self.var_c2f40a58 ghost();
			self.var_c2f40a58.is_visible = undefined;
		}
		return true;
	}
	if(isdefined(self.blueprint.locked) && self.blueprint.locked)
	{
		self.hint_string = "";
		return false;
	}
	if(blueprints.size > 1 && isdefined(self.blueprint.var_4050486a))
	{
		self.hint_string = self.blueprint.var_4050486a;
	}
	else
	{
		self.hint_string = self.blueprint.var_4dbc4aee;
	}
	if(zm_utility::get_story() == 1 && isdefined(self.var_c2f40a58))
	{
		if(isdefined(self.blueprint.var_db27a7f7))
		{
			if(self.blueprint.var_db27a7f7 !== self.var_c2f40a58)
			{
				self.var_c2f40a58 setmodel(self.blueprint.var_db27a7f7);
				self.var_c2f40a58 show();
				self.var_c2f40a58.is_visible = 1;
			}
			else if(!(isdefined(self.var_c2f40a58.is_visible) && self.var_c2f40a58.is_visible))
			{
				self.var_c2f40a58 show();
				self.var_c2f40a58.is_visible = 1;
			}
		}
		else if(isdefined(self.var_c2f40a58.is_visible) && self.var_c2f40a58.is_visible)
		{
			self.var_c2f40a58 ghost();
			self.var_c2f40a58.is_visible = undefined;
		}
	}
	return true;
}

/*
	Name: function_d564a5c0
	Namespace: zm_crafting
	Checksum: 0xE4614690
	Offset: 0x3930
	Size: 0x102
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d564a5c0(player)
{
	if(self.crafted)
	{
		return;
	}
	if(!isdefined(self.blueprint))
	{
		return;
	}
	if(isdefined(self.blueprint.locked) && self.blueprint.locked)
	{
		return;
	}
	blueprints = function_4165306b(player);
	var_9c8338de = blueprints.size;
	if(self.var_9c8338de != var_9c8338de)
	{
		return;
	}
	self.blueprint = self.craftfoundry;
	if(blueprints.size)
	{
		if(!isdefined(self.var_c0df4857))
		{
			self.var_c0df4857 = 0;
		}
		self.var_c0df4857++;
		if(self.var_c0df4857 >= blueprints.size)
		{
			self.var_c0df4857 = 0;
		}
		self.blueprint = blueprints[self.var_c0df4857];
	}
}

/*
	Name: function_f37c4bb5
	Namespace: zm_crafting
	Checksum: 0xCBEED9CD
	Offset: 0x3A40
	Size: 0x614
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f37c4bb5(player)
{
	if(self.stub.crafted)
	{
		return;
	}
	if(!isdefined(self.stub.blueprint))
	{
		return;
	}
	var_c060d2c8 = self.stub.var_c060d2c8;
	silent = 0;
	initial_current_weapon = player getcurrentweapon();
	current_weapon = zm_weapons::get_nonalternate_weapon(initial_current_weapon);
	if(current_weapon.isheroweapon || current_weapon.isgadget || current_weapon.isriotshield)
	{
		silent = 1;
	}
	if(silent)
	{
		progress_result = zm_progress::progress_think(player, level.var_98dad84e, var_c060d2c8);
	}
	else
	{
		progress_result = zm_progress::progress_think(player, level.var_90237ebd, var_c060d2c8);
	}
	self notify(#"hash_6db03c91467a21f5", {#b_completed:progress_result});
	if(progress_result)
	{
		self.stub.crafted = 1;
		player_crafted = player;
		self.stub.blueprint.completed = 1;
		if(isdefined(self.stub.blueprint.var_d8967a0c) && self.stub.blueprint.var_d8967a0c)
		{
			function_6f635422(player, self.stub.blueprint);
		}
		level notify(#"blueprint_completed", {#player:player, #produced:self.stub.blueprint.var_54a97edd, #blueprint:self.stub.blueprint});
		player notify(#"blueprint_completed", {#produced:self.stub.blueprint.var_54a97edd, #blueprint:self.stub.blueprint});
		if(self.stub.blueprint.var_46309255 === "persistent_buy" || self.stub.blueprint.var_46309255 === "buy_once_then_box" || self.stub.blueprint.var_46309255 === "spawn_as_ingredient")
		{
			function_987a472(self.stub.blueprint.var_54a97edd.worldmodel, self.stub.blueprint);
		}
		if(isdefined(player_crafted))
		{
			player_crafted playsound(#"zmb_craftable_complete");
			if(isdefined(self.stub.blueprint.name))
			{
				player_crafted thread zm_audio::create_and_play_dialog(#"build_complete", self.stub.blueprint.name);
			}
		}
		if(isdefined(self.stub.craftfoundry.callback_funcs))
		{
			foreach(func in self.stub.craftfoundry.callback_funcs)
			{
				self thread [[func]](player);
			}
		}
		if(isdefined(self.stub.blueprint.var_54a97edd) && (isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield))
		{
			foreach(e_player in getplayers())
			{
				/#
					e_player zm_challenges::debug_print("");
				#/
				e_player zm_stats::increment_challenge_stat(#"shields_built", undefined, 1);
			}
		}
		if(isdefined(self.stub.blueprint.var_46309255))
		{
			self.stub function_35f5c90b(self.stub.blueprint.var_46309255);
		}
	}
}

/*
	Name: function_a187b293
	Namespace: zm_crafting
	Checksum: 0xF8544405
	Offset: 0x4060
	Size: 0x1FC
	Parameters: 1
	Flags: None
*/
function function_a187b293(player)
{
	if(self.crafted)
	{
		return;
	}
	if(!isdefined(player))
	{
		player = array::random(level.players);
	}
	if(!isdefined(self.blueprint))
	{
		self.blueprint = self.craftfoundry;
	}
	a_s_blueprints = function_4165306b(player);
	self.var_9c8338de = a_s_blueprints.size;
	self.crafted = 1;
	self.blueprint.completed = 1;
	if(self.blueprint.var_46309255 === "persistent_buy" || self.blueprint.var_46309255 === "buy_once_then_box" || self.blueprint.var_46309255 === "spawn_as_ingredient")
	{
		function_987a472(self.blueprint.var_54a97edd.worldmodel, self.blueprint);
	}
	if(isdefined(self.craftfoundry.callback_funcs))
	{
		foreach(func in self.craftfoundry.callback_funcs)
		{
			self thread [[func]](player);
		}
	}
	if(isdefined(self.blueprint.var_46309255))
	{
		self function_35f5c90b(self.blueprint.var_46309255);
	}
}

/*
	Name: function_578c67bf
	Namespace: zm_crafting
	Checksum: 0xCEAE0CC2
	Offset: 0x4268
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_578c67bf()
{
	thread zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_3c45b116
	Namespace: zm_crafting
	Checksum: 0x38F2444A
	Offset: 0x4290
	Size: 0x134
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3c45b116()
{
	v_origin = self.origin;
	v_angles = self.angles;
	if(!isdefined(self.model))
	{
		s_model = struct::get(self.target, "targetname");
		if(isdefined(s_model))
		{
			v_origin = s_model.origin;
			if(isdefined(self.v_origin_offset))
			{
				v_origin = v_origin + self.v_origin_offset;
			}
			v_angles = s_model.angles;
			if(isdefined(self.v_angle_offset))
			{
				v_angles = v_angles + self.v_angle_offset;
			}
		}
	}
	else
	{
		v_origin = self.model.origin;
		v_angles = self.model.angles;
	}
	zm_items::spawn_item(self.blueprint.var_54a97edd, v_origin, v_angles);
	thread zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_230f6303
	Namespace: zm_crafting
	Checksum: 0xA920C4CF
	Offset: 0x43D0
	Size: 0x114
	Parameters: 0
	Flags: Linked, Private
*/
function private function_230f6303()
{
	v_origin = self.origin;
	v_angles = self.angles;
	if(!isdefined(self.model))
	{
		s_model = struct::get(self.target, "targetname");
		if(isdefined(s_model))
		{
			v_origin = s_model.origin;
			if(isdefined(self.v_origin_offset))
			{
				v_origin = v_origin + self.v_origin_offset;
			}
			v_angles = s_model.angles;
			if(isdefined(self.v_angle_offset))
			{
				v_angles = v_angles + self.v_angle_offset;
			}
		}
	}
	else
	{
		self.model notsolid();
		self.model show();
	}
	thread zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_9693e041
	Namespace: zm_crafting
	Checksum: 0x882E1E19
	Offset: 0x44F0
	Size: 0x464
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9693e041(player)
{
	if(player function_7bffa1ac(self.blueprint.var_54a97edd))
	{
		self.hint_string = #"hash_718d32f9e8cea17";
		self.cost = undefined;
		return true;
	}
	if(player function_2d53738e(self.blueprint.var_54a97edd))
	{
		if(isdefined(self.var_ad7ae074) && self.var_ad7ae074)
		{
			return true;
		}
		if(isdefined(self.blueprint.var_54a97edd.isriotshield) && self.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			self.cost = function_ceac3bf9(player, 1);
			str = self.blueprint.var_1238231a;
			var_e7ed2264 = function_c9163c5d(str);
			hint_str = zm_utility::function_d6046228(str, var_e7ed2264);
			backup_str = zm_utility::function_d6046228(#"hash_38222048e6736323", #"hash_197687e8f04962c9");
			self.hint_string = (isdefined(hint_str) ? hint_str : backup_str);
			_shad_turret_debug_server = 1;
		}
		else
		{
			self.hint_string = #"hash_53fd856df9288be7";
			self.cost = undefined;
			return true;
		}
	}
	else
	{
		if(!player function_2d53738e(self.blueprint.var_54a97edd) && (isdefined(self.blueprint.var_c028dcfe) && self.blueprint.var_c028dcfe && !player function_48ce9379(self.blueprint.var_54a97edd) || (isdefined(level.var_905507c3) && level.var_905507c3)))
		{
			str = self.blueprint.var_abd9b2d0;
			var_e7ed2264 = function_c9163c5d(str);
			hint_str = zm_utility::function_d6046228(str, var_e7ed2264);
			self.hint_string = (isdefined(hint_str) ? hint_str : "");
			self.cost = undefined;
		}
		else
		{
			if(zm_trial_disable_buys::is_active())
			{
				self.hint_string = #"hash_55d25caf8f7bbb2f";
			}
			else
			{
				if(!(isdefined(_shad_turret_debug_server) && _shad_turret_debug_server))
				{
					str = self.blueprint.var_391591d0;
					var_e7ed2264 = function_c9163c5d(str);
					self.hint_string = zm_utility::function_d6046228(str, var_e7ed2264);
				}
				self.cost = function_ceac3bf9(player);
				if(self.cost == 0)
				{
					str = self.blueprint.var_abd9b2d0;
					var_e7ed2264 = function_c9163c5d(str);
					hint_str = zm_utility::function_d6046228(str, var_e7ed2264);
					self.hint_string = (isdefined(hint_str) ? hint_str : "");
					self.cost = undefined;
				}
			}
		}
	}
	if(isdefined(level.var_932a1afb))
	{
		self [[level.var_932a1afb]](player);
	}
	return true;
}

/*
	Name: function_c9163c5d
	Namespace: zm_crafting
	Checksum: 0xBC258AC3
	Offset: 0x4960
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_c9163c5d(str)
{
	if(isdefined(str) && str != "")
	{
		str = str + "_KEYBOARD";
	}
	return str;
}

/*
	Name: function_ceac3bf9
	Namespace: zm_crafting
	Checksum: 0xD10D50CC
	Offset: 0x49A8
	Size: 0x24A
	Parameters: 2
	Flags: Linked
*/
function function_ceac3bf9(player, b_repaired = 0)
{
	if(!isdefined(player.var_36ea3103))
	{
		player.var_36ea3103 = 0;
	}
	if(isdefined(player.talisman_shield_price) && self.blueprint.var_54a97edd.isriotshield)
	{
		var_a185bd91 = player.talisman_shield_price;
	}
	else
	{
		var_a185bd91 = 0;
	}
	switch(player.var_36ea3103)
	{
		case 0:
		{
			n_cost = 0;
			break;
		}
		case 1:
		{
			n_cost = 250;
			break;
		}
		case 2:
		{
			n_cost = 500;
			break;
		}
		case 3:
		{
			n_cost = 750;
			break;
		}
		case 4:
		{
			n_cost = 1000;
			break;
		}
		case 5:
		{
			n_cost = 1250;
			break;
		}
		case 6:
		{
			n_cost = 1500;
			break;
		}
		case 7:
		{
			n_cost = 2000;
			break;
		}
		default:
		{
			n_cost = player function_86cab486();
			break;
		}
	}
	n_cost = n_cost - var_a185bd91;
	if(n_cost < 100)
	{
		n_cost = 100;
	}
	if(b_repaired)
	{
		if(isdefined(player.talisman_shield_price))
		{
			n_cost = math::clamp(n_cost, 0, 2500 - player.talisman_shield_price);
		}
		else
		{
			n_cost = math::clamp(n_cost, 250, 2500);
		}
	}
	return n_cost;
}

/*
	Name: function_86cab486
	Namespace: zm_crafting
	Checksum: 0x8B445692
	Offset: 0x4C00
	Size: 0xCE
	Parameters: 0
	Flags: Linked, Private
*/
function private function_86cab486()
{
	if(!isdefined(self.var_76a15cfd))
	{
		self.var_76a15cfd = 0;
	}
	if(self.var_3b6a5556 !== level.round_number)
	{
		n_cost = 2500;
	}
	else
	{
		switch(self.var_76a15cfd)
		{
			case 0:
			{
				n_cost = 2500;
				break;
			}
			case 1:
			{
				n_cost = 3000;
				break;
			}
			case 2:
			{
				n_cost = 4000;
				break;
			}
			default:
			{
				n_cost = 5000;
				break;
			}
		}
	}
	return n_cost;
}

/*
	Name: function_fccf9f0d
	Namespace: zm_crafting
	Checksum: 0x83E33362
	Offset: 0x4CD8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_fccf9f0d()
{
	if(self.var_36ea3103 >= 8)
	{
		if(self.var_3b6a5556 !== level.round_number)
		{
			self.var_76a15cfd = 1;
			self.var_3b6a5556 = level.round_number;
		}
		else
		{
			self.var_76a15cfd++;
		}
	}
	self.var_36ea3103++;
}

/*
	Name: function_df8ce6e2
	Namespace: zm_crafting
	Checksum: 0x11EDE08D
	Offset: 0x4D48
	Size: 0x830
	Parameters: 1
	Flags: Linked, Private
*/
function private function_df8ce6e2(player)
{
	if(isdefined(level.var_f7d93c4e))
	{
		if(!(isdefined(self [[level.var_f7d93c4e]](player)) && self [[level.var_f7d93c4e]](player)))
		{
			return;
		}
	}
	if(!(isdefined(self.stub.crafted) && self.stub.crafted))
	{
		self.stub.hint_string = "";
		self sethintstring(self.stub.hint_string);
		return;
	}
	if(player != self.parent_player)
	{
		return;
	}
	if(!zm_utility::is_player_valid(player))
	{
		player thread zm_utility::ignore_triggers(0.5);
		return;
	}
	if(isdefined(level.var_a6f62e91))
	{
		if(self [[level.var_a6f62e91]](player, #"crafting_table"))
		{
			return;
		}
	}
	if(player function_2d53738e(self.stub.blueprint.var_54a97edd))
	{
		if(isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			var_d97673ff = 1;
		}
		else
		{
			return;
		}
	}
	if(player function_7bffa1ac(self.stub.blueprint.var_54a97edd))
	{
		self.stub.hint_string = "";
		self sethintstring(self.stub.hint_string);
	}
	else
	{
		if(isdefined(var_d97673ff) && var_d97673ff)
		{
			var_f66d1847 = self.stub function_ceac3bf9(player, 1);
		}
		else
		{
			var_f66d1847 = self.stub function_ceac3bf9(player);
		}
		if(isdefined(var_f66d1847) && var_f66d1847 > 0)
		{
			if(isdefined(self.stub.blueprint.var_c028dcfe) && self.stub.blueprint.var_c028dcfe && !player function_48ce9379(self.stub.blueprint.var_54a97edd))
			{
				if(!isdefined(player.var_4e90ce0c))
				{
					player.var_4e90ce0c = [];
				}
				array::add(player.var_4e90ce0c, self.stub.blueprint.var_54a97edd, 0);
				player thread function_fccf9f0d();
			}
			else
			{
				if(zm_trial_disable_buys::is_active())
				{
					return;
				}
				if(player zm_score::can_player_purchase(var_f66d1847))
				{
					player thread function_fccf9f0d();
					player zm_score::minus_to_player_score(var_f66d1847);
					player zm_utility::play_sound_on_ent("purchase");
				}
				else
				{
					zm_utility::play_sound_on_ent("no_purchase");
					player zm_audio::create_and_play_dialog(#"general", #"outofmoney");
					return;
				}
			}
		}
		if(isdefined(self.stub.blueprint.var_fe8a5e39))
		{
			if(!isdefined(player.var_2f3339f0))
			{
				player.var_2f3339f0 = [];
			}
			if(!(isdefined(player.var_2f3339f0[self.stub.blueprint.var_54a97edd]) && player.var_2f3339f0[self.stub.blueprint.var_54a97edd]))
			{
				player thread zm_equipment::show_hint_text(self.stub.blueprint.var_fe8a5e39);
				player.var_2f3339f0[self.stub.blueprint.var_54a97edd] = 1;
			}
		}
		if(isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield)
		{
			if(isdefined(var_d97673ff) && var_d97673ff)
			{
				player [[player.player_shield_reset_health]](undefined, 1);
			}
			else if(isdefined(player.hasriotshield) && player.hasriotshield && isdefined(player.weaponriotshield))
			{
				player zm_weapons::weapon_take(player.weaponriotshield);
			}
		}
		if(!(isdefined(var_d97673ff) && var_d97673ff))
		{
			player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
		}
		else
		{
			player playsound(#"hash_230737b2535a3374");
		}
		player notify(#"hash_77d44943fb143b18", {#weapon:self.stub.blueprint.var_54a97edd});
		player zm_stats::function_c0c6ab19(#"weapons_bought", 1, 1);
		player contracts::increment_zm_contract(#"hash_4a8bbc38f59c2743", 1, #"zstandard");
		self.stub.bought = 1;
		self.stub.hint_string = "";
		self.stub.cost = undefined;
		self sethintstring(self.stub.hint_string);
		self.stub.var_ad7ae074 = 1;
		self.stub thread function_d94efa98();
		player zm_stats::track_craftables_pickedup(self.stub.blueprint.var_54a97edd);
		if(isdefined(level.var_8c978b55))
		{
			self [[level.var_8c978b55]](player);
		}
	}
}

/*
	Name: function_d94efa98
	Namespace: zm_crafting
	Checksum: 0x6A63CFA8
	Offset: 0x5580
	Size: 0x46
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d94efa98()
{
	self endon(#"death");
	self notify("7ba5a8cb350587cf");
	self endon("7ba5a8cb350587cf");
	wait(5);
	self.var_ad7ae074 = undefined;
}

/*
	Name: function_6e16f902
	Namespace: zm_crafting
	Checksum: 0xD4F952E7
	Offset: 0x55D0
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_6e16f902()
{
	if(isdefined(self.model))
	{
		self.model notsolid();
		self.model show();
	}
}

/*
	Name: function_15d10d06
	Namespace: zm_crafting
	Checksum: 0x52B851A7
	Offset: 0x5620
	Size: 0xDE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_15d10d06(player)
{
	if(player function_7bffa1ac(self.blueprint.var_54a97edd))
	{
		self.hint_string = #"hash_7b4e31b02c13ed59";
		return true;
	}
	if(isdefined(self.bought) && self.bought)
	{
		self.hint_string = #"hash_48157c44f8771b6c";
		return true;
	}
	str = self.blueprint.var_391591d0;
	var_e7ed2264 = function_c9163c5d(str);
	self.hint_string = zm_utility::function_d6046228(str, var_e7ed2264);
	return true;
}

/*
	Name: function_42673a26
	Namespace: zm_crafting
	Checksum: 0x6C5FB3B9
	Offset: 0x5708
	Size: 0x274
	Parameters: 1
	Flags: Linked, Private
*/
function private function_42673a26(player)
{
	if(isdefined(self.stub.bought) && self.stub.bought)
	{
		return;
	}
	current_weapon = player getcurrentweapon();
	if(zm_loadout::is_placeable_mine(current_weapon) || zm_equipment::is_equipment_that_blocks_purchase(current_weapon))
	{
		return;
	}
	if(!(isdefined(self.stub.crafted) && self.stub.crafted))
	{
		self.stub.hint_string = "";
		self sethintstring(self.stub.hint_string);
		return;
	}
	if(!zm_utility::is_player_valid(player))
	{
		player thread zm_utility::ignore_triggers(0.5);
		return;
	}
	if(player != self.parent_player)
	{
		return;
	}
	if(!player function_7bffa1ac(self.stub.blueprint.var_54a97edd))
	{
		player zm_weapons::weapon_give(self.stub.blueprint.var_54a97edd);
		zm_weapons::function_603af7a8(self.stub.blueprint.var_54a97edd);
		self.stub.bought = 1;
	}
	if(player function_7bffa1ac(self.stub.blueprint.var_54a97edd))
	{
		self.stub.hint_string = #"hash_7b4e31b02c13ed59";
	}
	else
	{
		self.stub.hint_string = #"hash_48157c44f8771b6c";
	}
	self sethintstring(self.stub.hint_string);
}

/*
	Name: function_3012605d
	Namespace: zm_crafting
	Checksum: 0xB1570792
	Offset: 0x5988
	Size: 0x144
	Parameters: 1
	Flags: None
*/
function function_3012605d(unitrigger)
{
	/#
		if(!isdefined(level.var_644b04e2))
		{
			level.var_644b04e2 = [];
		}
		if(!isdefined(level.var_a9839862))
		{
			level.var_a9839862 = 0;
		}
		table_id = level.var_a9839862;
		level.var_a9839862++;
		level.var_644b04e2[table_id] = unitrigger;
		name = unitrigger.craftfoundry.name;
		if(unitrigger.craftfoundry.displayname != "")
		{
			name = unitrigger.craftfoundry.displayname;
		}
		util::waittill_can_add_debug_command();
		str_cmd = ((((("" + table_id) + "") + name) + "") + table_id) + "";
		adddebugcommand(str_cmd);
	#/
}

/*
	Name: function_e197bb07
	Namespace: zm_crafting
	Checksum: 0x2DFEDEA8
	Offset: 0x5AD8
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_e197bb07(foundry)
{
	/#
	#/
}

/*
	Name: function_e5af6b6e
	Namespace: zm_crafting
	Checksum: 0x224D368D
	Offset: 0x5AF0
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_e5af6b6e(blueprint)
{
	/#
		name = blueprint.name;
		if(blueprint.displayname != "")
		{
			name = blueprint.displayname;
		}
		foreach(component in blueprint.components)
		{
			function_e9e4a1d0(name, component);
		}
	#/
}

/*
	Name: function_e9e4a1d0
	Namespace: zm_crafting
	Checksum: 0xF4CD06F3
	Offset: 0x5BC8
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function function_e9e4a1d0(var_a13e8cac, component)
{
	/#
		util::waittill_can_add_debug_command();
		name = function_a16a090d(component);
		str_cmd = ((((("" + var_a13e8cac) + "") + name) + "") + name) + "";
		adddebugcommand(str_cmd);
	#/
}

/*
	Name: function_4765f5b3
	Namespace: zm_crafting
	Checksum: 0x46EE9660
	Offset: 0x5C78
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function function_4765f5b3(component)
{
	/#
	#/
}

/*
	Name: devgui_get_players
	Namespace: zm_crafting
	Checksum: 0x81B388CF
	Offset: 0x5C90
	Size: 0xF2
	Parameters: 0
	Flags: None
*/
function devgui_get_players()
{
	/#
		var_4ab6b47 = getdvarstring(#"hash_7c8c0c3f35357a53");
		if(var_4ab6b47 != "")
		{
			player_id = int(var_4ab6b47);
			if(player_id > 0 && player_id <= 4 && isdefined(getplayers()[player_id - 1]))
			{
				result = [];
				result[player_id - 1] = getplayers()[player_id - 1];
				return result;
			}
		}
		return getplayers();
	#/
}

/*
	Name: devgui_think
	Namespace: zm_crafting
	Checksum: 0xBAE89CA5
	Offset: 0x5D90
	Size: 0x276
	Parameters: 0
	Flags: None
*/
function devgui_think()
{
	/#
		setdvar(#"hash_7c8c0c3f35357a53", "");
		util::waittill_can_add_debug_command();
		str_cmd = "";
		adddebugcommand(str_cmd);
		for(i = 1; i <= 4; i++)
		{
			util::waittill_can_add_debug_command();
			str_cmd = ((((("" + i) + "") + i) + "") + i) + "";
			adddebugcommand(str_cmd);
		}
		while(true)
		{
			var_cf5ebef8 = getdvarstring(#"hash_43086839e587cc6c");
			if(var_cf5ebef8 != "")
			{
				table_id = int(var_cf5ebef8);
				array::thread_all(devgui_get_players(), &function_fe738a08, table_id);
				setdvar(#"hash_43086839e587cc6c", "");
			}
			component = getdvarstring(#"hash_3a357be22156749e");
			if(component != "")
			{
				w_comp = get_component(component);
				array::thread_all(devgui_get_players(), &function_3e29352d, w_comp);
				setdvar(#"hash_3a357be22156749e", "");
			}
			wait(1);
		}
	#/
}

/*
	Name: function_3e29352d
	Namespace: zm_crafting
	Checksum: 0xD2D71EFB
	Offset: 0x6010
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_3e29352d(w_comp)
{
	/#
		self giveweapon(w_comp);
	#/
}

/*
	Name: function_fe738a08
	Namespace: zm_crafting
	Checksum: 0xA1BAD28E
	Offset: 0x6040
	Size: 0x1E4
	Parameters: 1
	Flags: None
*/
function function_fe738a08(table_id)
{
	/#
		unitrigger = level.var_644b04e2[table_id];
		entnum = self getentitynumber();
		origin = unitrigger.origin;
		forward = anglestoforward(unitrigger.angles);
		right = anglestoright(unitrigger.angles);
		var_21f5823e = vectortoangles(forward * -1);
		var_916d3dfe = origin + (48 * forward);
		switch(entnum)
		{
			case 0:
			{
				var_916d3dfe = var_916d3dfe + (16 * right);
				break;
			}
			case 1:
			{
				var_916d3dfe = var_916d3dfe + (16 * forward);
				break;
			}
			case 2:
			{
				var_916d3dfe = var_916d3dfe - (16 * right);
				break;
			}
			case 3:
			{
				var_916d3dfe = var_916d3dfe - (16 * forward);
				break;
			}
		}
		self setorigin(var_916d3dfe);
		self setplayerangles(var_21f5823e);
	#/
}

