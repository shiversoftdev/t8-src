// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_50c040e371c1c35f;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_unitrigger;

/*
	Name: function_89f2df9
	Namespace: zm_unitrigger
	Checksum: 0xFDFBEBF4
	Offset: 0x1D0
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_unitrigger", &__init__, &__main__, #"zm_zonemgr");
}

/*
	Name: create
	Namespace: zm_unitrigger
	Checksum: 0x7F2908B9
	Offset: 0x230
	Size: 0x258
	Parameters: 5
	Flags: Linked
*/
function create(var_9d80e6ef = "", var_e0bc0661 = 64, func_unitrigger_logic = &function_69168e61, var_4478092b, var_98f0ce74 = 0)
{
	if(isvec(var_e0bc0661) || isarray(var_e0bc0661))
	{
		s_unitrigger = self function_9267812e(var_e0bc0661[0], var_e0bc0661[1], var_e0bc0661[2], var_4478092b);
	}
	else
	{
		s_unitrigger = self function_a7620bfb(var_e0bc0661, var_4478092b);
	}
	function_91a18523(s_unitrigger, &function_699abf2);
	if(var_98f0ce74)
	{
		if(isfunctionptr(var_9d80e6ef))
		{
			function_2547d31f(s_unitrigger, var_9d80e6ef);
		}
		else if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			unitrigger_set_hint_string(s_unitrigger, var_9d80e6ef);
		}
		else
		{
			unitrigger_set_hint_string(s_unitrigger, "");
		}
	}
	else if(isfunctionptr(var_9d80e6ef))
	{
		function_2547d31f(s_unitrigger, var_9d80e6ef);
	}
	else
	{
		unitrigger_set_hint_string(s_unitrigger, var_9d80e6ef);
	}
	s_unitrigger.related_parent = self;
	self.s_unitrigger = s_unitrigger;
	s_unitrigger.in_zone = self.in_zone;
	register_static_unitrigger(s_unitrigger, func_unitrigger_logic);
	return s_unitrigger;
}

/*
	Name: function_fac87205
	Namespace: zm_unitrigger
	Checksum: 0xF35F4D0E
	Offset: 0x490
	Size: 0xF2
	Parameters: 4
	Flags: Linked
*/
function function_fac87205(var_9d80e6ef, var_e0bc0661, var_98f0ce74 = 0, var_85b3bba3 = 0)
{
	s_unitrigger = self create(var_9d80e6ef, var_e0bc0661, undefined, undefined, var_98f0ce74);
	if(isdefined(var_85b3bba3) && var_85b3bba3)
	{
		unitrigger_force_per_player_triggers(s_unitrigger, 1);
	}
	s_notify = undefined;
	s_notify = self waittill(#"trigger_activated");
	unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
	return s_notify.e_who;
}

/*
	Name: function_69168e61
	Namespace: zm_unitrigger
	Checksum: 0x2CAE07D9
	Offset: 0x590
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function function_69168e61()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player))
		{
			continue;
		}
		if(isdefined(self.stub) && isdefined(self.stub.related_parent))
		{
			self.stub.related_parent notify(#"trigger_activated", {#e_who:e_player});
		}
	}
}

/*
	Name: function_cf3f2bd8
	Namespace: zm_unitrigger
	Checksum: 0x10FA545D
	Offset: 0x668
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function function_cf3f2bd8()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(!zm_utility::can_use(e_player, 1))
		{
			continue;
		}
		self.stub.related_parent notify(#"trigger_activated", {#activator:e_player});
	}
}

/*
	Name: __init__
	Namespace: zm_unitrigger
	Checksum: 0xFC9D9639
	Offset: 0x728
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.var_dc25ba05))
	{
		level.var_dc25ba05 = 1;
	}
	level._unitriggers = spawnstruct();
	level._unitriggers._deferredinitlist = [];
	level._unitriggers.trigger_pool = [];
	level._unitriggers.trigger_stubs = [];
	level._unitriggers.dynamic_stubs = [];
	level._unitriggers.largest_radius = 64;
	stubs_keys = array("unitrigger_radius", "unitrigger_radius_use", "unitrigger_box", "unitrigger_box_use");
	stubs = [];
	for(i = 0; i < stubs_keys.size; i++)
	{
		stubs = arraycombine(stubs, struct::get_array(stubs_keys[i], "script_unitrigger_type"), 1, 0);
	}
	for(i = 0; i < stubs.size; i++)
	{
		register_unitrigger(stubs[i]);
	}
	callback::on_spawned(&function_94419264);
}

/*
	Name: __main__
	Namespace: zm_unitrigger
	Checksum: 0x6117EC7E
	Offset: 0x8D8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread function_28304f6a();
	level thread debug_unitriggers();
	level thread function_bb454fe6();
}

/*
	Name: function_28304f6a
	Namespace: zm_unitrigger
	Checksum: 0xADF535CE
	Offset: 0x930
	Size: 0x10A
	Parameters: 0
	Flags: Linked
*/
function function_28304f6a()
{
	level flag::wait_till("start_zombie_round_logic");
	if(level._unitriggers._deferredinitlist.size)
	{
		for(i = 0; i < level._unitriggers._deferredinitlist.size; i++)
		{
			register_static_unitrigger(level._unitriggers._deferredinitlist[i], level._unitriggers._deferredinitlist[i].trigger_func);
		}
		for(i = 0; i < level._unitriggers._deferredinitlist.size; i++)
		{
			level._unitriggers._deferredinitlist[i] = undefined;
		}
		level._unitriggers._deferredinitlist = undefined;
	}
}

/*
	Name: register_unitrigger_internal
	Namespace: zm_unitrigger
	Checksum: 0xA31A514B
	Offset: 0xA48
	Size: 0x442
	Parameters: 2
	Flags: Linked, Private
*/
private function register_unitrigger_internal(unitrigger_stub, trigger_func)
{
	if(!isdefined(unitrigger_stub.script_unitrigger_type))
	{
		/#
			println("");
		#/
		return;
	}
	if(isdefined(trigger_func))
	{
		unitrigger_stub.trigger_func = trigger_func;
	}
	if(!isdefined(unitrigger_stub.trigger_per_player))
	{
		unitrigger_stub.trigger_per_player = 0;
	}
	if(!isdefined(unitrigger_stub.var_8d306e51))
	{
		unitrigger_stub.var_8d306e51 = 0;
	}
	switch(unitrigger_stub.script_unitrigger_type)
	{
		case "unitrigger_radius":
		case "unitrigger_radius_use":
		{
			if(!isdefined(unitrigger_stub.radius))
			{
				unitrigger_stub.radius = 32;
			}
			if(!isdefined(unitrigger_stub.script_height))
			{
				unitrigger_stub.script_height = 64;
			}
			unitrigger_stub.test_radius_sq = (unitrigger_stub.radius + 15) * (unitrigger_stub.radius + 15);
			break;
		}
		case "unitrigger_box_use":
		case "unitrigger_box":
		{
			if(!isdefined(unitrigger_stub.script_width))
			{
				unitrigger_stub.script_width = 64;
			}
			if(!isdefined(unitrigger_stub.script_length))
			{
				unitrigger_stub.script_length = 64;
			}
			if(!isdefined(unitrigger_stub.script_height))
			{
				unitrigger_stub.script_height = 64;
			}
			box_radius = length((unitrigger_stub.script_width / 2, unitrigger_stub.script_length / 2, unitrigger_stub.script_height / 2));
			if(!isdefined(unitrigger_stub.radius) || unitrigger_stub.radius < box_radius)
			{
				unitrigger_stub.radius = box_radius;
			}
			unitrigger_stub.test_radius_sq = (box_radius + 15) * (box_radius + 15);
			break;
		}
		default:
		{
			/#
				println(("" + unitrigger_stub.targetname) + "");
			#/
			return;
		}
	}
	if(unitrigger_stub.radius > level._unitriggers.largest_radius)
	{
		level._unitriggers.largest_radius = min(113, unitrigger_stub.radius);
		if(isdefined(level.fixed_max_player_use_radius))
		{
			if(level.fixed_max_player_use_radius > getdvarfloat(#"player_useradius_zm", 0))
			{
				setdvar(#"player_useradius_zm", level.fixed_max_player_use_radius);
			}
		}
		else if(level._unitriggers.largest_radius > getdvarfloat(#"player_useradius_zm", 0))
		{
			setdvar(#"player_useradius_zm", level._unitriggers.largest_radius);
		}
	}
	level._unitriggers.trigger_stubs[level._unitriggers.trigger_stubs.size] = unitrigger_stub;
	unitrigger_stub.registered = 1;
}

/*
	Name: register_unitrigger
	Namespace: zm_unitrigger
	Checksum: 0x5988E3E1
	Offset: 0xE98
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function register_unitrigger(unitrigger_stub, trigger_func)
{
	register_static_unitrigger(unitrigger_stub, trigger_func, 1);
}

/*
	Name: unregister_unitrigger
	Namespace: zm_unitrigger
	Checksum: 0x805EFDDA
	Offset: 0xED8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function unregister_unitrigger(unitrigger_stub)
{
	thread unregister_unitrigger_internal(unitrigger_stub, 1);
}

/*
	Name: unregister_unitrigger_internal
	Namespace: zm_unitrigger
	Checksum: 0x5291CD64
	Offset: 0xF08
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function unregister_unitrigger_internal(unitrigger_stub, var_a68f8009 = 0)
{
	if(!isdefined(unitrigger_stub))
	{
		return;
	}
	if(var_a68f8009)
	{
		namespace_cb42c6c0::function_6b9e848(unitrigger_stub);
	}
	unitrigger_stub.registered = 0;
	if(isdefined(unitrigger_stub.trigger_per_player) && unitrigger_stub.trigger_per_player)
	{
		if(isdefined(unitrigger_stub.playertrigger) && unitrigger_stub.playertrigger.size > 0)
		{
			keys = getarraykeys(unitrigger_stub.playertrigger);
			foreach(key in keys)
			{
				trigger = unitrigger_stub.playertrigger[key];
				trigger notify(#"kill_trigger");
				if(isdefined(trigger))
				{
					trigger delete();
				}
			}
			unitrigger_stub.playertrigger = [];
		}
	}
	else if(isdefined(unitrigger_stub.trigger))
	{
		trigger = unitrigger_stub.trigger;
		trigger notify(#"kill_trigger");
		trigger.stub.trigger = undefined;
		trigger delete();
	}
	if(isdefined(unitrigger_stub.in_zone))
	{
		arrayremovevalue(level.zones[unitrigger_stub.in_zone].unitrigger_stubs, unitrigger_stub);
		unitrigger_stub.in_zone = undefined;
	}
	arrayremovevalue(level._unitriggers.trigger_stubs, unitrigger_stub);
	arrayremovevalue(level._unitriggers.dynamic_stubs, unitrigger_stub);
	function_f1854fb(unitrigger_stub);
}

/*
	Name: register_static_unitrigger
	Namespace: zm_unitrigger
	Checksum: 0xDCF55A06
	Offset: 0x11A0
	Size: 0x624
	Parameters: 3
	Flags: Linked
*/
function register_static_unitrigger(unitrigger_stub, trigger_func, recalculate_zone)
{
	if(level.zones.size == 0)
	{
		unitrigger_stub.trigger_func = trigger_func;
		level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
		return;
	}
	register_unitrigger_internal(unitrigger_stub, trigger_func);
	if(isdefined(unitrigger_stub.in_zone) && !isdefined(recalculate_zone))
	{
		if(isdefined(level.zones[unitrigger_stub.in_zone].unitrigger_stubs))
		{
			n_index = level.zones[unitrigger_stub.in_zone].unitrigger_stubs.size;
		}
		else
		{
			n_index = 0;
		}
		level.zones[unitrigger_stub.in_zone].unitrigger_stubs[n_index] = unitrigger_stub;
		thread function_3c84a41e(unitrigger_stub, unitrigger_stub.in_zone);
		return;
	}
	heightoffset = vectorscale((0, 0, -1), 35);
	if(unitrigger_stub.script_unitrigger_type == "unitrigger_box_use" || unitrigger_stub.script_unitrigger_type == "unitrigger_box")
	{
		var_e790dc87 = (15, 15, 35);
		maxs = (unitrigger_stub.script_width / 2, unitrigger_stub.script_height / 2, unitrigger_stub.script_length / 2);
		var_e63e6402 = (max(unitrigger_stub.script_width, unitrigger_stub.script_length) / 2) + 15;
		trigger = ai::function_470c0597(unitrigger_stub.origin + heightoffset, maxs + var_e790dc87, unitrigger_stub.angles);
	}
	else if(unitrigger_stub.script_unitrigger_type == "unitrigger_radius" || unitrigger_stub.script_unitrigger_type == "unitrigger_radius_use")
	{
		trigger = ai::t_cylinder(unitrigger_stub.origin + heightoffset, unitrigger_stub.radius + 15, unitrigger_stub.script_height + 35);
		var_e63e6402 = unitrigger_stub.radius + 15;
	}
	if(isdefined(trigger))
	{
		var_e50a845c = tacticalquery("unitrigger_zone_tacquery", trigger, unitrigger_stub.origin);
		if(var_e50a845c.size > 0)
		{
			foreach(tpoint in var_e50a845c)
			{
				if(isdefined(tpoint.node))
				{
					zone = zm_zonemgr::get_zone_from_position(tpoint.node.origin, 1, 1);
				}
				if(isdefined(zone))
				{
					break;
				}
			}
		}
		if(isentity(trigger))
		{
			trigger delete();
		}
		trigger = undefined;
	}
	if(!isdefined(zone))
	{
		v_pos = getclosestpointonnavmesh(unitrigger_stub.origin, var_e63e6402);
		if(isdefined(v_pos))
		{
			zone = zm_zonemgr::get_zone_from_position(v_pos, 1, 1);
		}
	}
	if(isdefined(zone))
	{
		if(!isdefined(level.zones[zone].unitrigger_stubs))
		{
			level.zones[zone].unitrigger_stubs = [];
		}
		if(!isdefined(level.zones[zone].unitrigger_stubs))
		{
			level.zones[zone].unitrigger_stubs = [];
		}
		else if(!isarray(level.zones[zone].unitrigger_stubs))
		{
			level.zones[zone].unitrigger_stubs = array(level.zones[zone].unitrigger_stubs);
		}
		level.zones[zone].unitrigger_stubs[level.zones[zone].unitrigger_stubs.size] = unitrigger_stub;
		unitrigger_stub.in_zone = zone;
		thread function_3c84a41e(unitrigger_stub, zone);
		return;
	}
	level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
	unitrigger_stub.registered = 1;
	thread function_3c84a41e(unitrigger_stub, undefined);
}

/*
	Name: register_dyn_unitrigger
	Namespace: zm_unitrigger
	Checksum: 0x40034147
	Offset: 0x17D0
	Size: 0xDC
	Parameters: 3
	Flags: Linked
*/
function register_dyn_unitrigger(unitrigger_stub, trigger_func, recalculate_zone)
{
	if(level.zones.size == 0)
	{
		unitrigger_stub.trigger_func = trigger_func;
		level._unitriggers._deferredinitlist[level._unitriggers._deferredinitlist.size] = unitrigger_stub;
		return;
	}
	register_unitrigger_internal(unitrigger_stub, trigger_func);
	level._unitriggers.dynamic_stubs[level._unitriggers.dynamic_stubs.size] = unitrigger_stub;
	unitrigger_stub.registered = 1;
	thread function_3c84a41e(unitrigger_stub, undefined);
}

/*
	Name: reregister_unitrigger
	Namespace: zm_unitrigger
	Checksum: 0x88C68893
	Offset: 0x18B8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function reregister_unitrigger(unitrigger_stub)
{
	if(isdefined(unitrigger_stub.registered) && unitrigger_stub.registered)
	{
		zone = unitrigger_stub.in_zone;
		unregister_unitrigger_internal(unitrigger_stub);
		if(isdefined(zone))
		{
			register_static_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func, 1);
		}
		else
		{
			register_dyn_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func);
		}
	}
}

/*
	Name: reregister_unitrigger_as_dynamic
	Namespace: zm_unitrigger
	Checksum: 0xCB837091
	Offset: 0x1968
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function reregister_unitrigger_as_dynamic(unitrigger_stub)
{
	unregister_unitrigger_internal(unitrigger_stub);
	register_dyn_unitrigger(unitrigger_stub, unitrigger_stub.trigger_func);
}

/*
	Name: function_a7620bfb
	Namespace: zm_unitrigger
	Checksum: 0xDDE4FFA2
	Offset: 0x19B8
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function function_a7620bfb(n_radius = 64, var_4478092b = 1)
{
	if(var_4478092b)
	{
		s_trigger_type = "unitrigger_radius_use";
	}
	else
	{
		s_trigger_type = "unitrigger_radius";
	}
	s_unitrigger = spawnstruct();
	s_unitrigger.origin = self.origin;
	s_unitrigger.angles = self.angles;
	s_unitrigger.script_unitrigger_type = s_trigger_type;
	s_unitrigger.cursor_hint = "HINT_NOICON";
	s_unitrigger.radius = n_radius;
	return s_unitrigger;
}

/*
	Name: function_9267812e
	Namespace: zm_unitrigger
	Checksum: 0x8A54B770
	Offset: 0x1AA0
	Size: 0x12E
	Parameters: 4
	Flags: Linked
*/
function function_9267812e(n_width = 64, n_length = 64, n_height = 64, var_4478092b = 1)
{
	if(var_4478092b)
	{
		s_trigger_type = "unitrigger_box_use";
	}
	else
	{
		s_trigger_type = "unitrigger_box";
	}
	s_unitrigger = spawnstruct();
	s_unitrigger.origin = self.origin;
	s_unitrigger.angles = self.angles;
	s_unitrigger.script_unitrigger_type = s_trigger_type;
	s_unitrigger.cursor_hint = "HINT_NOICON";
	s_unitrigger.script_height = n_height;
	s_unitrigger.script_width = n_width;
	s_unitrigger.script_length = n_length;
	return s_unitrigger;
}

/*
	Name: function_3f621bbe
	Namespace: zm_unitrigger
	Checksum: 0xC6E8EA39
	Offset: 0x1BD8
	Size: 0x52
	Parameters: 1
	Flags: None
*/
function function_3f621bbe(s_stub)
{
	if(isdefined(s_stub.originfunc))
	{
		origin = s_stub [[s_stub.originfunc]]();
	}
	else
	{
		origin = s_stub.origin;
	}
	return origin;
}

/*
	Name: unitrigger_origin
	Namespace: zm_unitrigger
	Checksum: 0x22C4879
	Offset: 0x1C38
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function unitrigger_origin()
{
	if(isdefined(self.originfunc))
	{
		origin = self [[self.originfunc]]();
	}
	else
	{
		origin = self.origin;
	}
	return origin;
}

/*
	Name: function_47625e58
	Namespace: zm_unitrigger
	Checksum: 0x538AAB1D
	Offset: 0x1C80
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function function_47625e58(s_stub, origin, v_angles)
{
	if(isfunctionptr(origin))
	{
		s_stub.origin = undefined;
		s_stub.originfunc = origin;
	}
	else
	{
		s_stub.origin = origin;
		if(isdefined(v_angles))
		{
			s_stub.angles = v_angles;
		}
	}
	function_91a18523(s_stub, &function_699abf2);
}

/*
	Name: function_c9e3607c
	Namespace: zm_unitrigger
	Checksum: 0xBD676D62
	Offset: 0x1D28
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function function_c9e3607c(s_stub, str_icon, w_weapon)
{
	if(isdefined(str_icon))
	{
		s_stub.cursor_hint = str_icon;
		s_stub.cursor_hint_weapon = undefined;
		if(function_68f2282d(s_stub.cursor_hint) && isdefined(w_weapon))
		{
			s_stub.cursor_hint_weapon = w_weapon;
		}
	}
	function_91a18523(s_stub, &function_5d7dd248);
}

/*
	Name: unitrigger_set_hint_string
	Namespace: zm_unitrigger
	Checksum: 0x120DDC38
	Offset: 0x1DC8
	Size: 0x7C
	Parameters: 4
	Flags: Linked
*/
function unitrigger_set_hint_string(s_stub, str_hint, param1, param2)
{
	s_stub.hint_string = str_hint;
	s_stub.var_464566e7 = param1;
	s_stub.var_2f7c3955 = param2;
	s_stub.prompt_and_visibility_func = undefined;
	function_91a18523(s_stub, &function_5d7dd248);
}

/*
	Name: function_413f9fcf
	Namespace: zm_unitrigger
	Checksum: 0x76A054D9
	Offset: 0x1E50
	Size: 0x9C
	Parameters: 4
	Flags: Linked
*/
function function_413f9fcf(s_stub, ent, default_ref, cost)
{
	ref = default_ref;
	if(isdefined(ent.script_hint))
	{
		ref = ent.script_hint;
	}
	s_stub.hint_string = zm_utility::get_zombie_hint(ref);
	s_stub.var_464566e7 = cost;
	function_91a18523(s_stub, &function_5d7dd248);
}

/*
	Name: function_2547d31f
	Namespace: zm_unitrigger
	Checksum: 0x4352BC58
	Offset: 0x1EF8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_2547d31f(s_stub, var_404301da)
{
	s_stub.prompt_and_visibility_func = var_404301da;
	function_91a18523(s_stub, &function_5c2f213d);
}

/*
	Name: function_89380dda
	Namespace: zm_unitrigger
	Checksum: 0x7A15B529
	Offset: 0x1F48
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_89380dda(s_stub, var_840cc2c8 = 1)
{
	if(var_840cc2c8 == 2)
	{
		s_stub.require_look_toward = 1;
		s_stub.require_look_at = 0;
	}
	else if(var_840cc2c8 == 0)
	{
		s_stub.require_look_toward = 0;
		s_stub.require_look_at = 0;
	}
	else
	{
		s_stub.require_look_toward = 0;
		s_stub.require_look_at = 1;
	}
	function_91a18523(s_stub, &function_2565f0b0);
}

/*
	Name: unitrigger_force_per_player_triggers
	Namespace: zm_unitrigger
	Checksum: 0x1C6D9CD
	Offset: 0x2008
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function unitrigger_force_per_player_triggers(s_stub, opt_on_off = 1)
{
	s_stub.trigger_per_player = opt_on_off;
	s_stub.var_8d306e51 = 0;
	reregister_unitrigger(s_stub);
}

/*
	Name: function_c4a5fdf5
	Namespace: zm_unitrigger
	Checksum: 0x8B542D2D
	Offset: 0x2068
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_c4a5fdf5(s_stub, opt_on_off = 1)
{
	s_stub.trigger_per_player = opt_on_off;
	s_stub.var_8d306e51 = 0;
	reregister_unitrigger(s_stub);
}

/*
	Name: function_f1794fbf
	Namespace: zm_unitrigger
	Checksum: 0x5B932936
	Offset: 0x20C8
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function function_f1794fbf(s_stub, player)
{
	if(s_stub.trigger_per_player)
	{
		return s_stub.playertrigger[player getentitynumber()];
	}
	return s_stub.trigger;
}

/*
	Name: unitrigger_trigger
	Namespace: zm_unitrigger
	Checksum: 0xB24FFA3E
	Offset: 0x2128
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function unitrigger_trigger(player)
{
	if(self.trigger_per_player)
	{
		return self.playertrigger[player getentitynumber()];
	}
	return self.trigger;
}

/*
	Name: function_91a18523
	Namespace: zm_unitrigger
	Checksum: 0xF9294395
	Offset: 0x2178
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function function_91a18523(s_stub, var_a6b7a40d)
{
	if(isdefined(s_stub.trigger_per_player) && s_stub.trigger_per_player)
	{
		if(isdefined(s_stub.playertrigger))
		{
			foreach(trigger in s_stub.playertrigger)
			{
				trigger [[var_a6b7a40d]](s_stub, trigger);
			}
		}
	}
	else if(isdefined(s_stub.trigger))
	{
		s_stub.trigger [[var_a6b7a40d]](s_stub, trigger);
	}
}

/*
	Name: function_699abf2
	Namespace: zm_unitrigger
	Checksum: 0x813B1CBE
	Offset: 0x2270
	Size: 0x5E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_699abf2(s_stub, trigger)
{
	trigger.origin = s_stub unitrigger_origin();
	if(isdefined(s_stub.angles))
	{
		trigger.angles = s_stub.angles;
	}
}

/*
	Name: function_5d7dd248
	Namespace: zm_unitrigger
	Checksum: 0xFB7685DC
	Offset: 0x22D8
	Size: 0xDC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_5d7dd248(s_stub, trigger)
{
	if(isdefined(s_stub.var_8d306e51) && s_stub.var_8d306e51)
	{
		foreach(player in level.players)
		{
			function_d0676c62(s_stub, trigger, player);
		}
	}
	else
	{
		function_d0676c62(s_stub, trigger, trigger.player);
	}
}

/*
	Name: function_d0676c62
	Namespace: zm_unitrigger
	Checksum: 0xF702A2C8
	Offset: 0x23C0
	Size: 0x24C
	Parameters: 3
	Flags: Linked
*/
function function_d0676c62(s_stub, trigger, player)
{
	if(isdefined(s_stub.cursor_hint))
	{
		if(function_68f2282d(s_stub.cursor_hint) && isdefined(s_stub.cursor_hint_weapon))
		{
			trigger setcursorhint(s_stub.cursor_hint, s_stub.cursor_hint_weapon);
		}
		else
		{
			trigger setcursorhint(s_stub.cursor_hint);
		}
	}
	if(isdefined(s_stub.hint_string))
	{
		if(isdefined(s_stub.hint_parm2))
		{
			if(isdefined(s_stub.var_8d306e51) && s_stub.var_8d306e51)
			{
				trigger sethintstringforplayer(player, s_stub.hint_string, s_stub.hint_parm1, s_stub.hint_parm2);
			}
			else
			{
				trigger sethintstring(s_stub.hint_string, s_stub.hint_parm1, s_stub.hint_parm2);
			}
		}
		else if(isdefined(s_stub.hint_parm1))
		{
			if(isdefined(s_stub.var_8d306e51) && s_stub.var_8d306e51)
			{
				trigger sethintstringforplayer(player, s_stub.hint_string, s_stub.hint_parm1);
			}
			else
			{
				trigger sethintstring(s_stub.hint_string, s_stub.hint_parm1);
			}
		}
		else if(isdefined(s_stub.var_8d306e51) && s_stub.var_8d306e51)
		{
			trigger sethintstringforplayer(player, s_stub.hint_string);
		}
		else
		{
			trigger sethintstring(s_stub.hint_string);
		}
	}
}

/*
	Name: function_5c2f213d
	Namespace: zm_unitrigger
	Checksum: 0x875771B2
	Offset: 0x2618
	Size: 0xDC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_5c2f213d(s_stub, trigger)
{
	if(isdefined(s_stub.var_8d306e51) && s_stub.var_8d306e51)
	{
		foreach(player in level.players)
		{
			function_933f3bf3(s_stub, trigger, player);
		}
	}
	else
	{
		function_933f3bf3(s_stub, trigger, trigger.player);
	}
}

/*
	Name: function_933f3bf3
	Namespace: zm_unitrigger
	Checksum: 0xE791C1E1
	Offset: 0x2700
	Size: 0x114
	Parameters: 3
	Flags: Linked, Private
*/
private function function_933f3bf3(s_stub, trigger, player)
{
	if(isdefined(s_stub.prompt_and_visibility_func))
	{
		usable = trigger [[s_stub.prompt_and_visibility_func]](player);
		if(!isdefined(usable))
		{
			/#
				/#
					loc_0000278C:
					assertmsg((("" + (isdefined(s_stub.targetname) ? s_stub.targetname : "")) + "") + (isdefined(s_stub.origin) ? s_stub.origin : (0, 0, 0)) + "");
				#/
			#/
			usable = 0;
		}
		trigger triggerenable(usable);
	}
	else
	{
		function_d0676c62(s_stub, trigger, player);
	}
}

/*
	Name: function_2565f0b0
	Namespace: zm_unitrigger
	Checksum: 0x8BF10CA3
	Offset: 0x2820
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2565f0b0(s_stub, trigger)
{
	if(!isdefined(trigger) || !isdefined(s_stub))
	{
		return;
	}
	trigger usetriggerrequirelookat(isdefined(s_stub.require_look_at) && s_stub.require_look_at);
	trigger usetriggerrequirelooktoward(isdefined(s_stub.require_look_toward) && s_stub.require_look_toward);
}

/*
	Name: function_94419264
	Namespace: zm_unitrigger
	Checksum: 0x7097A3C4
	Offset: 0x28B8
	Size: 0x16E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_94419264()
{
	if(!isdefined(self.var_13a302d2))
	{
		self.var_13a302d2 = [];
	}
	waitframe(1);
	if(isdefined(self) && (isdefined(level.var_dc25ba05) && level.var_dc25ba05))
	{
		self thread function_358a2fc7();
	}
	while(isdefined(self))
	{
		trigger = self.useholdent;
		if(isdefined(trigger))
		{
			self function_71b67b2a(trigger);
		}
		else
		{
			self.var_13a302d2 = array::remove_undefined(self.var_13a302d2, 0);
			if(!isdefined(self.var_9de1a3d2))
			{
				self.var_9de1a3d2 = 0;
			}
			if(self.var_9de1a3d2 >= self.var_13a302d2.size)
			{
				self.var_9de1a3d2 = 0;
			}
			if(self.var_9de1a3d2 < self.var_13a302d2.size)
			{
				if(isdefined(self.var_13a302d2[self.var_9de1a3d2]))
				{
					self function_71b67b2a(self.var_13a302d2[self.var_9de1a3d2]);
				}
				self.var_9de1a3d2++;
			}
		}
		function_ba088f52(trigger);
		waitframe(1);
	}
}

/*
	Name: function_ba088f52
	Namespace: zm_unitrigger
	Checksum: 0x1C4FEB41
	Offset: 0x2A30
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ba088f52(trigger)
{
	if(self.current_trigger !== trigger)
	{
		if(isdefined(self.current_trigger))
		{
			if(isdefined(self.current_trigger.stub))
			{
				self.current_trigger.stub notify(#"hash_d0ee404fc39206", {#player:self});
			}
		}
		self.current_trigger = trigger;
		if(isdefined(self.current_trigger))
		{
			if(isdefined(self.current_trigger.stub))
			{
				self.current_trigger.stub notify(#"hash_396aa901be0c0eaf", {#player:self});
			}
		}
	}
}

/*
	Name: function_71b67b2a
	Namespace: zm_unitrigger
	Checksum: 0x1A500299
	Offset: 0x2B18
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_71b67b2a(trigger)
{
	if(!isdefined(trigger.stub) || distancesquared(self.origin, trigger.stub unitrigger_origin()) > 65536)
	{
		return;
	}
	trigger function_4bb09c8f(trigger.stub, self);
}

/*
	Name: function_358a2fc7
	Namespace: zm_unitrigger
	Checksum: 0x36482214
	Offset: 0x2BA8
	Size: 0x1A8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_358a2fc7()
{
	self notify(#"hash_4a86a63120e0d3d9");
	self endon(#"hash_4a86a63120e0d3d9", #"disconnect");
	if(isdefined(level._unitriggers) && isarray(level._unitriggers.dynamic_stubs))
	{
		arrayremovevalue(level._unitriggers.dynamic_stubs, undefined);
		foreach(stub in level._unitriggers.dynamic_stubs)
		{
			self thread function_522794c2(stub);
		}
	}
	if(isdefined(self.cached_zone))
	{
		self thread function_d7eef1bc(self.cached_zone, self.cached_zone_name);
	}
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_2d4daa9e80b86b60");
		self thread function_d7eef1bc(waitresult.zone, waitresult.zone_name);
	}
}

/*
	Name: function_5b353bb7
	Namespace: zm_unitrigger
	Checksum: 0xC5AB7162
	Offset: 0x2D58
	Size: 0x13A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_5b353bb7()
{
	if(!isdefined(self.var_13a302d2))
	{
		self.var_13a302d2 = [];
	}
	foreach(trigger in self.var_13a302d2)
	{
		if(isdefined(trigger) && isdefined(trigger.stub) && isdefined(trigger.stub.in_zone) && (trigger.stub.trigger_per_player || !level.zones[trigger.stub.in_zone].is_occupied))
		{
			cleanup_trigger(trigger, self);
		}
	}
	self.var_50a1b1f6 = undefined;
	self.var_13a302d2 = array::remove_undefined(self.var_13a302d2, 0);
}

/*
	Name: function_d7eef1bc
	Namespace: zm_unitrigger
	Checksum: 0xE7750EE7
	Offset: 0x2EA0
	Size: 0x10E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d7eef1bc(zone, zone_name)
{
	self endon(#"hash_2d4daa9e80b86b60");
	function_5b353bb7();
	candidate_list = level.zones[zone_name].unitrigger_stubs;
	if(isarray(candidate_list))
	{
		candidate_list = array::remove_undefined(candidate_list);
		foreach(stub in candidate_list)
		{
			self thread function_522794c2(stub);
		}
	}
	self.var_50a1b1f6 = zone_name;
}

/*
	Name: function_3c84a41e
	Namespace: zm_unitrigger
	Checksum: 0x2B6E790A
	Offset: 0x2FB8
	Size: 0xC8
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3c84a41e(stub, zone_name)
{
	waitframe(1);
	foreach(player in util::get_players())
	{
		if(isdefined(player) && (!isdefined(zone_name) || player.var_50a1b1f6 === zone_name))
		{
			player function_522794c2(stub);
		}
	}
}

/*
	Name: function_f1854fb
	Namespace: zm_unitrigger
	Checksum: 0x58FA7E8B
	Offset: 0x3088
	Size: 0xBA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f1854fb(stub)
{
	foreach(player in getplayers())
	{
		if(isarray(player.var_13a302d2))
		{
			player.var_13a302d2 = array::remove_undefined(player.var_13a302d2, 0);
		}
	}
}

/*
	Name: function_ba39b142
	Namespace: zm_unitrigger
	Checksum: 0xB3DBCC8D
	Offset: 0x3150
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ba39b142()
{
	if(!isdefined(level.var_9d46713))
	{
		level.var_9d46713 = 0;
	}
	if(!isdefined(level.var_9bb1f3e7))
	{
		level.var_9bb1f3e7 = 0;
	}
	while(level.var_9bb1f3e7 == gettime() && level.var_9d46713 >= 2)
	{
		waitframe(1);
	}
	if(level.var_9bb1f3e7 != gettime())
	{
		level.var_9d46713 = 0;
		level.var_9bb1f3e7 = gettime();
	}
	level.var_9d46713++;
}

/*
	Name: function_522794c2
	Namespace: zm_unitrigger
	Checksum: 0xBB9E6C33
	Offset: 0x3200
	Size: 0x194
	Parameters: 1
	Flags: Linked, Private
*/
private function function_522794c2(stub)
{
	function_ba39b142();
	if(isdefined(level.var_dc25ba05) && level.var_dc25ba05)
	{
		if(!isalive(self))
		{
			return;
		}
		trigger = check_and_build_trigger_from_unitrigger_stub(stub, self);
		trigger.parent_player = self;
		trigger.stub = stub;
		if(!isdefined(self.var_13a302d2))
		{
			self.var_13a302d2 = [];
		}
		if(!isinarray(self.var_13a302d2, trigger))
		{
			if(!isdefined(self.var_13a302d2))
			{
				self.var_13a302d2 = [];
			}
			else if(!isarray(self.var_13a302d2))
			{
				self.var_13a302d2 = array(self.var_13a302d2);
			}
			self.var_13a302d2[self.var_13a302d2.size] = trigger;
		}
		usable = assess_and_apply_visibility(trigger, stub, self, 1);
		trigger triggerenable(usable);
		function_71b67b2a(trigger);
	}
}

/*
	Name: cleanup_trigger
	Namespace: zm_unitrigger
	Checksum: 0xAAA28A9E
	Offset: 0x33A0
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function cleanup_trigger(trigger, player)
{
	trigger notify(#"kill_trigger");
	if(isdefined(trigger.stub.trigger_per_player) && trigger.stub.trigger_per_player)
	{
		if(isdefined(trigger.stub.playertrigger) && isarray(trigger.stub.playertrigger))
		{
			trigger.stub.playertrigger[player getentitynumber()] = undefined;
		}
	}
	else
	{
		trigger.stub.trigger = undefined;
	}
	trigger delete();
	level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
}

/*
	Name: assess_and_apply_visibility
	Namespace: zm_unitrigger
	Checksum: 0xB2B5219A
	Offset: 0x34C0
	Size: 0x1B6
	Parameters: 4
	Flags: Linked
*/
function assess_and_apply_visibility(trigger, stub, player, default_keep)
{
	if(!isdefined(trigger) || !isdefined(stub))
	{
		return 0;
	}
	keep_thread = default_keep;
	if(!isdefined(stub.prompt_and_visibility_func) || trigger [[stub.prompt_and_visibility_func]](player) || (isdefined(level.var_dc25ba05) && level.var_dc25ba05))
	{
		keep_thread = 1;
		if(!(isdefined(trigger.thread_running) && trigger.thread_running))
		{
			trigger thread trigger_thread(trigger.stub.trigger_func);
		}
		trigger.thread_running = 1;
		if(isdefined(trigger.reassess_time) && trigger.reassess_time <= 0)
		{
			trigger.reassess_time = undefined;
		}
	}
	else if(isdefined(trigger.thread_running) && trigger.thread_running)
	{
		keep_thread = 0;
	}
	trigger.thread_running = 0;
	if(isdefined(stub.inactive_reassess_time))
	{
		trigger.reassess_time = stub.inactive_reassess_time;
	}
	else
	{
		trigger.reassess_time = 1;
	}
	return keep_thread;
}

/*
	Name: is_same_trigger
	Namespace: zm_unitrigger
	Checksum: 0xA1F75257
	Offset: 0x3680
	Size: 0x46
	Parameters: 2
	Flags: Linked, Private
*/
private function is_same_trigger(old_trigger, trigger)
{
	return isdefined(old_trigger) && old_trigger == trigger && trigger.parent_player == old_trigger.parent_player;
}

/*
	Name: check_and_build_trigger_from_unitrigger_stub
	Namespace: zm_unitrigger
	Checksum: 0xC834608A
	Offset: 0x36D0
	Size: 0x1B8
	Parameters: 2
	Flags: Linked, Private
*/
private function check_and_build_trigger_from_unitrigger_stub(stub, player)
{
	if(!isdefined(stub))
	{
		return undefined;
	}
	if(isdefined(stub.trigger_per_player) && stub.trigger_per_player)
	{
		if(!isdefined(stub.playertrigger))
		{
			stub.playertrigger = [];
		}
		if(!isdefined(stub.playertrigger[player getentitynumber()]))
		{
			trigger = build_trigger_from_unitrigger_stub(stub, player);
			level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
		}
		else
		{
			trigger = stub.playertrigger[player getentitynumber()];
			trigger function_4bb09c8f(stub, player);
		}
		if(isdefined(trigger))
		{
			trigger.player = player;
		}
	}
	else if(!isdefined(stub.trigger))
	{
		trigger = build_trigger_from_unitrigger_stub(stub, player);
		level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
	}
	else
	{
		trigger = stub.trigger;
		trigger function_4bb09c8f(stub, player);
	}
	return trigger;
}

/*
	Name: function_68f2282d
	Namespace: zm_unitrigger
	Checksum: 0xC05DE8A2
	Offset: 0x3890
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_68f2282d(var_e7d50e88)
{
	return var_e7d50e88 == "HINT_WEAPON" || var_e7d50e88 == "HINT_BGB";
}

/*
	Name: build_trigger_from_unitrigger_stub
	Namespace: zm_unitrigger
	Checksum: 0x4D7C408A
	Offset: 0x38C8
	Size: 0x3D6
	Parameters: 2
	Flags: Linked, Private
*/
private function build_trigger_from_unitrigger_stub(s_stub, player)
{
	radius = (isdefined(s_stub.radius) ? s_stub.radius : 64);
	script_height = (isdefined(s_stub.script_height) ? s_stub.script_height : 64);
	script_width = (isdefined(s_stub.script_width) ? s_stub.script_width : 64);
	script_length = (isdefined(s_stub.script_length) ? s_stub.script_length : 64);
	trigger = undefined;
	origin = s_stub unitrigger_origin();
	if(!isdefined(s_stub.script_unitrigger_type))
	{
		s_stub.script_unitrigger_type = "unitrigger_radius_use";
	}
	switch(s_stub.script_unitrigger_type)
	{
		case "unitrigger_radius":
		{
			trigger = spawn("trigger_radius", origin, 0, radius, script_height);
			break;
		}
		case "unitrigger_radius_use":
		{
			trigger = spawn("trigger_radius_use", origin, 0, radius, script_height);
			break;
		}
		case "unitrigger_box":
		{
			trigger = spawn("trigger_box", origin, 0, script_width, script_length, script_height);
			break;
		}
		case "unitrigger_box_use":
		{
			trigger = spawn("trigger_box_use", origin, 0, script_width, script_length, script_height);
			break;
		}
	}
	if(isdefined(trigger))
	{
		trigger.stub = s_stub;
		trigger.player = player;
		function_699abf2(s_stub, trigger);
		if(isdefined(s_stub.onspawnfunc))
		{
			s_stub [[s_stub.onspawnfunc]](trigger);
		}
		function_d0676c62(s_stub, trigger, player);
		trigger triggerignoreteam();
		function_2565f0b0(s_stub, trigger);
		copy_zombie_keys_onto_trigger(trigger, s_stub);
		if(isdefined(s_stub.trigger_per_player) && s_stub.trigger_per_player)
		{
			trigger setinvisibletoall();
			trigger setvisibletoplayer(player);
			if(!isdefined(s_stub.playertrigger))
			{
				s_stub.playertrigger = [];
			}
			s_stub.playertrigger[player getentitynumber()] = trigger;
		}
		else
		{
			s_stub.trigger = trigger;
		}
		trigger.player = player;
		trigger.thread_running = 0;
	}
	return trigger;
}

/*
	Name: copy_zombie_keys_onto_trigger
	Namespace: zm_unitrigger
	Checksum: 0xA9F0B22C
	Offset: 0x3CA8
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
private function copy_zombie_keys_onto_trigger(trigger, s_stub)
{
	trigger.script_noteworthy = s_stub.script_noteworthy;
	trigger.targetname = s_stub.targetname;
	trigger.target = s_stub.target;
	trigger.weapon = s_stub.weapon;
	trigger.clientfieldname = s_stub.clientfieldname;
	trigger.usetime = s_stub.usetime;
}

/*
	Name: function_4bb09c8f
	Namespace: zm_unitrigger
	Checksum: 0xA5C48C14
	Offset: 0x3D58
	Size: 0x66
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4bb09c8f(s_stub, player)
{
	if(isdefined(self))
	{
		function_699abf2(s_stub, self);
		function_933f3bf3(s_stub, self, player);
		if(!isdefined(self.stub))
		{
			self.stub = s_stub;
		}
	}
}

/*
	Name: trigger_thread
	Namespace: zm_unitrigger
	Checksum: 0x6360C289
	Offset: 0x3DC8
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
private function trigger_thread(trigger_func)
{
	self endon(#"kill_trigger");
	if(isdefined(trigger_func))
	{
		self [[trigger_func]]();
	}
}

/*
	Name: debug_unitriggers
	Namespace: zm_unitrigger
	Checksum: 0x2DA20189
	Offset: 0x3E08
	Size: 0x47E
	Parameters: 0
	Flags: Linked
*/
function debug_unitriggers()
{
	/#
		while(true)
		{
			if(getdvarint(#"debug_unitrigger", 0) > 0)
			{
				for(i = 0; i < level._unitriggers.trigger_stubs.size; i++)
				{
					triggerstub = level._unitriggers.trigger_stubs[i];
					color = vectorscale((1, 0, 0), 0.75);
					if(!isdefined(triggerstub.in_zone))
					{
						color = vectorscale((1, 1, 0), 0.65);
					}
					else if(level.zones[triggerstub.in_zone].is_active)
					{
						color = (1, 1, 0);
					}
					if(isdefined(triggerstub.trigger) || (isdefined(triggerstub.playertrigger) && triggerstub.playertrigger.size > 0))
					{
						color = (0, 1, 0);
						if(isdefined(triggerstub.playertrigger) && triggerstub.playertrigger.size > 0)
						{
							print3d(triggerstub.origin, triggerstub.playertrigger.size, color, 1, 1, 1);
						}
					}
					origin = triggerstub unitrigger_origin();
					if(isdefined(triggerstub.in_zone))
					{
						print3d(origin, level.zones[triggerstub.in_zone].name, color, 1, 0.25, 1);
					}
					if(getdvarint(#"debug_unitrigger", 0) > 1)
					{
						if(isdefined(triggerstub.trigger_per_player) && triggerstub.trigger_per_player)
						{
							if(isdefined(triggerstub.playertrigger))
							{
								foreach(var_becdb9c in triggerstub.playertrigger)
								{
									function_3fdbe6d3(var_becdb9c, origin, color);
								}
							}
						}
						else
						{
							function_3fdbe6d3(triggerstub.trigger, origin, color);
						}
						continue;
					}
					switch(triggerstub.script_unitrigger_type)
					{
						case "unitrigger_radius":
						case "unitrigger_radius_use":
						{
							if(triggerstub.radius)
							{
								circle(origin, triggerstub.radius, color, 0, 0, 1);
							}
							if(triggerstub.script_height)
							{
								line(origin, origin + (0, 0, triggerstub.script_height), color, 0, 1);
							}
							break;
						}
						case "unitrigger_box_use":
						case "unitrigger_box":
						{
							vec = (triggerstub.script_width / 2, triggerstub.script_length / 2, triggerstub.script_height / 2);
							box(origin, vec * -1, vec, triggerstub.angles[1], color, 1, 0, 1);
							break;
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_3fdbe6d3
	Namespace: zm_unitrigger
	Checksum: 0xF20FEF69
	Offset: 0x4290
	Size: 0x21A
	Parameters: 3
	Flags: None
*/
function function_3fdbe6d3(trigger, var_5ca10e3c, color)
{
	if(isdefined(trigger))
	{
		torigin = trigger getorigin();
		tangles = trigger getangles();
		tmins = trigger getmins();
		tmaxs = trigger getmaxs();
		if(distancesquared(var_5ca10e3c, trigger.origin) > 16)
		{
			/#
				line(var_5ca10e3c, torigin, color, 0, 1);
			#/
		}
		sphere(var_5ca10e3c, 4, color, 1, 1, 10, 1);
		/#
			forward = anglestoforward(tangles);
			line(torigin, torigin + (12 * forward), color, 0, 1);
			box(torigin, tmins, tmaxs, tangles[1], color, 1, 0, 1);
		#/
		switch(trigger.classname)
		{
			case "trigger_radius":
			case "trigger_radius_use":
			{
				break;
			}
			case "trigger_box_use":
			case "trigger_box":
			{
				break;
			}
		}
	}
}

/*
	Name: function_bb454fe6
	Namespace: zm_unitrigger
	Checksum: 0x5B1733FA
	Offset: 0x44B8
	Size: 0x858
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bb454fe6()
{
	level flag::wait_till("start_zombie_round_logic");
	valid_range = level._unitriggers.largest_radius + 15;
	valid_range_sq = valid_range * valid_range;
	while(!isdefined(level.active_zone_names))
	{
		wait(0.1);
	}
	while(true)
	{
		if(isdefined(level.var_dc25ba05) && level.var_dc25ba05)
		{
			wait(2);
			continue;
		}
		waited = 0;
		active_zone_names = level.active_zone_names;
		candidate_list = [];
		for(j = 0; j < active_zone_names.size; j++)
		{
			if(isdefined(level.zones[active_zone_names[j]].unitrigger_stubs))
			{
				candidate_list = arraycombine(candidate_list, level.zones[active_zone_names[j]].unitrigger_stubs, 1, 0);
			}
		}
		candidate_list = arraycombine(candidate_list, level._unitriggers.dynamic_stubs, 1, 0);
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			player = players[i];
			if(!isdefined(player))
			{
				continue;
			}
			player_origin = player.origin + vectorscale((0, 0, 1), 35);
			trigger = level._unitriggers.trigger_pool[player getentitynumber()];
			old_trigger = undefined;
			closest = [];
			if(isdefined(trigger))
			{
				dst = valid_range_sq;
				origin = trigger unitrigger_origin();
				dst = trigger.stub.test_radius_sq;
				time_to_ressess = 0;
				trigger_still_valid = 0;
				if(distance2dsquared(player_origin, origin) < dst)
				{
					if(isdefined(trigger.reassess_time))
					{
						trigger.reassess_time = trigger.reassess_time - 0.05;
						if(trigger.reassess_time > 0)
						{
							continue;
						}
						time_to_ressess = 1;
					}
					trigger_still_valid = 1;
				}
				closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
				if(isdefined(trigger) && time_to_ressess && (closest.size < 2 || (isdefined(trigger.thread_running) && trigger.thread_running)))
				{
					if(assess_and_apply_visibility(trigger, trigger.stub, player, 1))
					{
						continue;
					}
				}
				if(trigger_still_valid && closest.size < 2)
				{
					if(assess_and_apply_visibility(trigger, trigger.stub, player, 1))
					{
						continue;
					}
				}
				if(trigger_still_valid)
				{
					old_trigger = trigger;
					trigger = undefined;
					level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
				}
				else if(isdefined(trigger))
				{
					cleanup_trigger(trigger, player);
				}
			}
			else
			{
				closest = get_closest_unitriggers(player_origin, candidate_list, valid_range);
			}
			index = 0;
			first_usable = undefined;
			first_visible = undefined;
			trigger_found = 0;
			while(index < closest.size)
			{
				if(!zm_utility::is_player_valid(player) && (!(isdefined(closest[index].ignore_player_valid) && closest[index].ignore_player_valid)))
				{
					index++;
					continue;
				}
				if(!(isdefined(closest[index].registered) && closest[index].registered))
				{
					index++;
					continue;
				}
				trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
				if(isdefined(trigger))
				{
					trigger.parent_player = player;
					if(assess_and_apply_visibility(trigger, closest[index], player, 0))
					{
						if(player zm_utility::is_player_looking_at(closest[index].origin, 0.9, 0))
						{
							if(!is_same_trigger(old_trigger, trigger) && isdefined(old_trigger))
							{
								cleanup_trigger(old_trigger, player);
							}
							level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
							trigger_found = 1;
							break;
						}
						if(!isdefined(first_usable))
						{
							first_usable = index;
						}
					}
					if(!isdefined(first_visible))
					{
						first_visible = index;
					}
					if(isdefined(trigger))
					{
						if(is_same_trigger(old_trigger, trigger))
						{
							level._unitriggers.trigger_pool[player getentitynumber()] = undefined;
						}
						else
						{
							cleanup_trigger(trigger, player);
						}
					}
					last_trigger = trigger;
				}
				index++;
				waited = 1;
				waitframe(1);
			}
			if(!isdefined(player))
			{
				continue;
			}
			if(trigger_found)
			{
				continue;
			}
			if(isdefined(first_usable))
			{
				index = first_usable;
			}
			else if(isdefined(first_visible))
			{
				index = first_visible;
			}
			trigger = check_and_build_trigger_from_unitrigger_stub(closest[index], player);
			if(isdefined(trigger))
			{
				trigger.parent_player = player;
				level._unitriggers.trigger_pool[player getentitynumber()] = trigger;
				if(is_same_trigger(old_trigger, trigger))
				{
					continue;
				}
				if(isdefined(old_trigger))
				{
					cleanup_trigger(old_trigger, player);
				}
				if(isdefined(trigger))
				{
					assess_and_apply_visibility(trigger, trigger.stub, player, 0);
				}
			}
		}
		if(!waited)
		{
			waitframe(1);
		}
	}
}

/*
	Name: run_visibility_function_for_all_triggers
	Namespace: zm_unitrigger
	Checksum: 0x216F630A
	Offset: 0x4D18
	Size: 0x118
	Parameters: 0
	Flags: Private
*/
private function run_visibility_function_for_all_triggers()
{
	if(!isdefined(self.prompt_and_visibility_func))
	{
		return;
	}
	if(isdefined(self.trigger_per_player) && self.trigger_per_player)
	{
		if(!isdefined(self.playertrigger))
		{
			return;
		}
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(isdefined(self.playertrigger[players[i] getentitynumber()]))
			{
				self.playertrigger[players[i] getentitynumber()] [[self.prompt_and_visibility_func]](players[i]);
			}
		}
	}
	else if(isdefined(self.trigger))
	{
		self.trigger [[self.prompt_and_visibility_func]](getplayers()[0]);
	}
}

/*
	Name: get_closest_unitriggers
	Namespace: zm_unitrigger
	Checksum: 0x968A6D95
	Offset: 0x4E38
	Size: 0x1D2
	Parameters: 3
	Flags: Linked, Private
*/
private function get_closest_unitriggers(org, array, dist = 9999999)
{
	triggers = [];
	if(array.size < 1)
	{
		return triggers;
	}
	distsq = dist * dist;
	for(i = 0; i < array.size; i++)
	{
		if(!isdefined(array[i]))
		{
			continue;
		}
		origin = array[i] unitrigger_origin();
		radius_sq = array[i].test_radius_sq;
		newdistsq = distance2dsquared(origin, org);
		if(newdistsq >= radius_sq)
		{
			continue;
		}
		if(abs(origin[2] - org[2]) > 42)
		{
			continue;
		}
		array[i].dsquared = newdistsq;
		for(j = 0; j < triggers.size && newdistsq > triggers[j].dsquared; j++)
		{
		}
		arrayinsert(triggers, array[i], j);
	}
	return triggers;
}

