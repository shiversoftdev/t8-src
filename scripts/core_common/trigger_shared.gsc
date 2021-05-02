// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\teleport_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace trigger;

/*
	Name: function_89f2df9
	Namespace: trigger
	Checksum: 0xE3E7AA94
	Offset: 0x238
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"trigger", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: trigger
	Checksum: 0xD04DB0D3
	Offset: 0x280
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::function_27d9ab8(&trigger_think);
}

/*
	Name: function_cbf8fb6b
	Namespace: trigger
	Checksum: 0x5956069
	Offset: 0x2B0
	Size: 0xD4
	Parameters: 4
	Flags: Linked
*/
function function_cbf8fb6b(var_60ffbed2, func_handler, func_init, var_114fa26c = 1)
{
	if((isfunctionptr(var_60ffbed2) ? [[var_60ffbed2]]() : isdefined(self.(var_60ffbed2))))
	{
		if(isdefined(func_handler))
		{
			if(var_114fa26c)
			{
				self callback::function_a04381e0(func_handler);
			}
			else
			{
				self callback::function_35a12f19(func_handler);
			}
		}
		if(isfunctionptr(func_init))
		{
			[[func_init]](var_60ffbed2);
		}
	}
}

/*
	Name: init_flags
	Namespace: trigger
	Checksum: 0xA45C4A5F
	Offset: 0x390
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function init_flags(str_kvp)
{
	tokens = util::create_flags_and_return_tokens(self.(str_kvp));
	add_tokens_to_trigger_flags(tokens);
	update_based_on_flags();
}

/*
	Name: trigger_think
	Namespace: trigger
	Checksum: 0xEB99C1B8
	Offset: 0x3F8
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function trigger_think()
{
	self endon(#"death");
	function_cbf8fb6b("target", &trigger_spawner);
	function_cbf8fb6b("script_flag_true", undefined, &init_flags);
	function_cbf8fb6b("script_flag_true_any", undefined, &init_flags);
	function_cbf8fb6b("script_flag_false_any", undefined, &init_flags);
	function_cbf8fb6b("script_flag_false", undefined, &init_flags);
	function_cbf8fb6b("script_flag_set", &flag_set_trigger, &init_flags);
	function_cbf8fb6b("script_flag_clear", &flag_clear_trigger, &init_flags);
	function_cbf8fb6b("script_trigger_group", &trigger_group);
	function_cbf8fb6b("script_notify", &trigger_notify);
	function_cbf8fb6b("script_killspawner", &kill_spawner_trigger);
	function_cbf8fb6b("script_teleport_location", &teleport::team);
	function_cbf8fb6b(&is_trigger_once, &trigger_once);
	if(isdefined(self.script_flag_set_on_touching) || isdefined(self.script_flag_set_on_not_touching))
	{
		level thread script_flag_set_touching(self);
	}
	if(is_look_trigger())
	{
		level thread look_trigger(self);
		s_info = undefined;
		s_info = self waittill(#"trigger_look");
		self thread callback::function_6eb09118(s_info, 1);
	}
}

/*
	Name: function_1792c799
	Namespace: trigger
	Checksum: 0x555C9F92
	Offset: 0x6C8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_1792c799(flags)
{
	trigger_flags = function_27f2ef17(self);
	function_4e3bb793(self, trigger_flags | flags);
}

/*
	Name: get_trigger_look_target
	Namespace: trigger
	Checksum: 0xF418E3E9
	Offset: 0x720
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function get_trigger_look_target()
{
	if(isdefined(self.target))
	{
		a_potential_targets = getentarray(self.target, "targetname");
		a_targets = [];
		foreach(target in a_potential_targets)
		{
			if(target.classname === "script_origin")
			{
				if(!isdefined(a_targets))
				{
					a_targets = [];
				}
				else if(!isarray(a_targets))
				{
					a_targets = array(a_targets);
				}
				a_targets[a_targets.size] = target;
			}
		}
		a_potential_target_structs = struct::get_array(self.target);
		a_targets = arraycombine(a_targets, a_potential_target_structs, 1, 0);
		if(a_targets.size > 0)
		{
			/#
				assert(a_targets.size == 1, "" + self.origin + "");
			#/
			e_target = a_targets[0];
		}
	}
	if(!isdefined(e_target))
	{
		e_target = self;
	}
	return e_target;
}

/*
	Name: look_trigger
	Namespace: trigger
	Checksum: 0x8CAF312D
	Offset: 0x8F0
	Size: 0x228
	Parameters: 1
	Flags: Linked
*/
function look_trigger(trigger)
{
	trigger endon(#"death");
	e_target = trigger get_trigger_look_target();
	if(isdefined(trigger.script_flag) && !isdefined(level.flag[trigger.script_flag]))
	{
		level function_ac2f203a(trigger.script_flag);
	}
	a_parameters = [];
	if(isdefined(trigger.script_parameters))
	{
		a_parameters = strtok(trigger.script_parameters, ",; ");
	}
	b_ads_check = isinarray(a_parameters, "check_ads");
	while(true)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		e_other = waitresult.activator;
		if(isplayer(e_other))
		{
			while(isdefined(e_other) && e_other istouching(trigger))
			{
				if(e_other util::is_looking_at(e_target, trigger.script_dot, isdefined(trigger.script_trace) && trigger.script_trace) && (!b_ads_check || !e_other util::is_ads()))
				{
					trigger notify(#"trigger_look", waitresult);
				}
				waitframe(1);
			}
		}
		assertmsg("");
	}
}

/*
	Name: trigger_spawner
	Namespace: trigger
	Checksum: 0x9839497D
	Offset: 0xB20
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function trigger_spawner(s_info)
{
	a_ai_spawners = getspawnerarray(self.target, "targetname");
	foreach(sp in a_ai_spawners)
	{
		if(isdefined(sp))
		{
			if(isvehiclespawner(sp))
			{
				level thread vehicle::_vehicle_spawn(sp);
				continue;
			}
			/#
				assert(isactorspawner(sp));
			#/
			sp thread trigger_spawner_spawn();
		}
	}
}

/*
	Name: trigger_spawner_spawn
	Namespace: trigger
	Checksum: 0xA50C90F
	Offset: 0xC38
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function trigger_spawner_spawn()
{
	self endon(#"death");
	self flag::script_flag_wait();
	self util::script_delay();
	self spawner::spawn();
}

/*
	Name: trigger_notify
	Namespace: trigger
	Checksum: 0x84F95D06
	Offset: 0xCA0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function trigger_notify(s_info)
{
	if(isdefined(self.target))
	{
		a_target_ents = getentarray(self.target, "targetname");
		foreach(notify_ent in a_target_ents)
		{
			notify_ent notify(self.script_notify, s_info);
		}
	}
	level notify(self.script_notify, s_info);
}

/*
	Name: function_ac2f203a
	Namespace: trigger
	Checksum: 0x90D26588
	Offset: 0xD70
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function function_ac2f203a(str_flag)
{
	if(!level flag::exists(str_flag))
	{
		level flag::init(str_flag);
	}
	if(!isdefined(level.trigger_flags))
	{
		level.trigger_flags = [];
	}
	if(!isdefined(level.trigger_flags[str_flag]))
	{
		level.trigger_flags[str_flag] = [];
	}
}

/*
	Name: flag_set_trigger
	Namespace: trigger
	Checksum: 0x62F4960A
	Offset: 0xE00
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function flag_set_trigger()
{
	var_af1bea51 = util::create_flags_and_return_tokens(self.script_flag_set);
	foreach(str_flag in var_af1bea51)
	{
		level flag::set(str_flag);
	}
}

/*
	Name: flag_clear_trigger
	Namespace: trigger
	Checksum: 0x132BF4B9
	Offset: 0xEA8
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function flag_clear_trigger(s_info)
{
	var_af1bea51 = util::create_flags_and_return_tokens(self.script_flag_clear);
	foreach(str_flag in var_af1bea51)
	{
		level flag::clear(str_flag);
	}
}

/*
	Name: add_tokens_to_trigger_flags
	Namespace: trigger
	Checksum: 0x827B1F05
	Offset: 0xF58
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function add_tokens_to_trigger_flags(tokens)
{
	for(i = 0; i < tokens.size; i++)
	{
		flag = tokens[i];
		if(!isdefined(level.trigger_flags[flag]))
		{
			level.trigger_flags[flag] = [];
		}
		else if(!isarray(level.trigger_flags[flag]))
		{
			level.trigger_flags[flag] = array(level.trigger_flags[flag]);
		}
		if(!isinarray(level.trigger_flags[flag], self))
		{
			level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
		}
	}
}

/*
	Name: friendly_respawn_trigger
	Namespace: trigger
	Checksum: 0xA377D035
	Offset: 0x1080
	Size: 0x190
	Parameters: 1
	Flags: None
*/
function friendly_respawn_trigger(trigger)
{
	trigger endon(#"death");
	spawners = getentarray(trigger.target, "targetname");
	/#
		assert(spawners.size == 1, "" + trigger.target + "");
	#/
	spawner = spawners[0];
	/#
		assert(!isdefined(spawner.script_forcecolor), "" + spawner.origin + "");
	#/
	spawners = undefined;
	spawner endon(#"death");
	while(true)
	{
		trigger waittill(#"trigger");
		if(isdefined(trigger.script_forcecolor))
		{
			level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
		}
		else
		{
			level.respawn_spawner = spawner;
		}
		level flag::set("respawn_friendlies");
		wait(0.5);
	}
}

/*
	Name: friendly_respawn_clear
	Namespace: trigger
	Checksum: 0x25769F29
	Offset: 0x1218
	Size: 0x70
	Parameters: 1
	Flags: None
*/
function friendly_respawn_clear(trigger)
{
	trigger endon(#"death");
	while(true)
	{
		trigger waittill(#"trigger");
		level flag::clear("respawn_friendlies");
		wait(0.5);
	}
}

/*
	Name: script_flag_set_touching
	Namespace: trigger
	Checksum: 0x31333C7
	Offset: 0x1290
	Size: 0x1A8
	Parameters: 1
	Flags: Linked
*/
function script_flag_set_touching(trigger)
{
	trigger endon(#"death");
	if(isdefined(trigger.script_flag_set_on_touching))
	{
		level function_ac2f203a(trigger.script_flag_set_on_touching);
	}
	if(isdefined(trigger.script_flag_set_on_not_touching))
	{
		level function_ac2f203a(trigger.script_flag_set_on_not_touching);
	}
	trigger thread _detect_touched();
	while(true)
	{
		trigger.script_touched = 0;
		waitframe(1);
		waittillframeend();
		if(!trigger.script_touched)
		{
			waitframe(1);
			waittillframeend();
		}
		if(trigger.script_touched)
		{
			if(isdefined(trigger.script_flag_set_on_touching))
			{
				level flag::set(trigger.script_flag_set_on_touching);
			}
			if(isdefined(trigger.script_flag_set_on_not_touching))
			{
				level flag::clear(trigger.script_flag_set_on_not_touching);
			}
		}
		else if(isdefined(trigger.script_flag_set_on_touching))
		{
			level flag::clear(trigger.script_flag_set_on_touching);
		}
		if(isdefined(trigger.script_flag_set_on_not_touching))
		{
			level flag::set(trigger.script_flag_set_on_not_touching);
		}
	}
}

/*
	Name: _detect_touched
	Namespace: trigger
	Checksum: 0x95A6DADE
	Offset: 0x1440
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function _detect_touched()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self.script_touched = 1;
	}
}

/*
	Name: trigger_delete_on_touch
	Namespace: trigger
	Checksum: 0x98D0240F
	Offset: 0x1490
	Size: 0x78
	Parameters: 1
	Flags: None
*/
function trigger_delete_on_touch(trigger)
{
	while(true)
	{
		waitresult = undefined;
		waitresult = trigger waittill(#"trigger");
		other = waitresult.activator;
		if(isdefined(other))
		{
			other delete();
		}
	}
}

/*
	Name: trigger_once
	Namespace: trigger
	Checksum: 0xE45D6F4
	Offset: 0x1510
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function trigger_once(s_info)
{
	waittillframeend();
	waittillframeend();
	if(isdefined(self))
	{
		/#
			println("");
			println("" + self getentitynumber() + "" + self.origin);
			println("");
		#/
		self delete();
	}
}

/*
	Name: get_all
	Namespace: trigger
	Checksum: 0xE3F74422
	Offset: 0x15C0
	Size: 0xF2
	Parameters: 1
	Flags: Linked, Variadic
*/
function get_all(vararg)
{
	if(vararg.size == 1 && isarray(vararg[0]))
	{
		var_b00e97e6 = vararg[0];
	}
	else
	{
		var_b00e97e6 = vararg;
	}
	var_a98c3aa9 = getentarraybytype(20);
	if(var_b00e97e6.size)
	{
		for(i = var_a98c3aa9.size - 1; i >= 0; i--)
		{
			if(!isinarray(var_b00e97e6, var_a98c3aa9[i].classname))
			{
				arrayremoveindex(var_a98c3aa9, i);
			}
		}
	}
	return var_a98c3aa9;
}

/*
	Name: is_trigger_of_type
	Namespace: trigger
	Checksum: 0x2A5CEADC
	Offset: 0x16C0
	Size: 0x72
	Parameters: 1
	Flags: Linked, Variadic
*/
function is_trigger_of_type(vararg)
{
	if(vararg.size == 1 && isarray(vararg[0]))
	{
		var_b00e97e6 = vararg[0];
	}
	else
	{
		var_b00e97e6 = vararg;
	}
	return isinarray(var_b00e97e6, self.classname);
}

/*
	Name: wait_till
	Namespace: trigger
	Checksum: 0xDA7201DD
	Offset: 0x1740
	Size: 0x1B8
	Parameters: 4
	Flags: Linked
*/
function wait_till(str_name, str_key = "targetname", e_entity, b_assert = 1)
{
	if(isdefined(str_name))
	{
		triggers = getentarray(str_name, str_key);
		/#
			assert(!b_assert || triggers.size > 0, "" + str_name + "" + str_key);
		#/
		if(triggers.size > 0)
		{
			if(triggers.size == 1)
			{
				trigger_hit = triggers[0];
				trigger_hit _trigger_wait(e_entity);
			}
			else
			{
				s_tracker = spawnstruct();
				array::thread_all(triggers, &_trigger_wait_think, s_tracker, e_entity);
				waitresult = undefined;
				waitresult = s_tracker waittill(#"trigger");
				trigger_hit = waitresult.trigger;
				trigger_hit.who = waitresult.activator;
			}
			return trigger_hit;
		}
	}
	else
	{
		_trigger_wait(e_entity);
		return self;
	}
}

/*
	Name: _trigger_wait
	Namespace: trigger
	Checksum: 0xA0B28CE4
	Offset: 0x1900
	Size: 0x27E
	Parameters: 1
	Flags: Linked
*/
function _trigger_wait(e_entity)
{
	self endon(#"death");
	if(isdefined(e_entity))
	{
		e_entity endon(#"death");
	}
	if(!isdefined(self.delaynotify))
	{
		self.delaynotify = 0;
	}
	/#
		if(is_look_trigger())
		{
			/#
				assert(!isarray(e_entity), "");
			#/
		}
		else if(self.classname === "")
		{
			/#
				assert(!isarray(e_entity), "");
			#/
		}
	#/
	while(true)
	{
		if(is_look_trigger())
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger_look");
			wait(self.delaynotify);
			e_other = waitresult.activator;
			if(isdefined(e_entity))
			{
				if(e_other !== e_entity)
				{
					continue;
				}
			}
		}
		else if(self.classname === "trigger_damage")
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			wait(self.delaynotify);
			e_other = waitresult.activator;
			if(isdefined(e_entity))
			{
				if(e_other !== e_entity)
				{
					continue;
				}
			}
		}
		else
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			wait(self.delaynotify);
			e_other = waitresult.activator;
			if(isdefined(e_entity))
			{
				if(isarray(e_entity))
				{
					if(!array::is_touching(e_entity, self))
					{
						continue;
					}
				}
				else if(!e_entity istouching(self) && e_entity !== e_other)
				{
					continue;
				}
			}
		}
		break;
	}
	self.who = e_other;
	return e_other;
}

/*
	Name: _trigger_wait_think
	Namespace: trigger
	Checksum: 0x43EE9C06
	Offset: 0x1B88
	Size: 0x90
	Parameters: 2
	Flags: Linked
*/
function _trigger_wait_think(s_tracker, e_entity)
{
	self endon(#"death");
	s_tracker endon(#"trigger");
	e_other = _trigger_wait(e_entity);
	s_tracker notify(#"trigger", {#trigger:self, #activator:e_other});
}

/*
	Name: use
	Namespace: trigger
	Checksum: 0x643F321C
	Offset: 0x1C20
	Size: 0x17C
	Parameters: 4
	Flags: Linked
*/
function use(str_name, str_key = "targetname", ent = getplayers()[0], b_assert = 1)
{
	if(isdefined(str_name))
	{
		e_trig = getent(str_name, str_key);
		if(!isdefined(e_trig))
		{
			if(b_assert)
			{
				/#
					assertmsg("" + str_name + "" + str_key);
				#/
			}
			return;
		}
	}
	else
	{
		e_trig = self;
		str_name = self.targetname;
	}
	if(isdefined(ent))
	{
		e_trig useby(ent);
	}
	else
	{
		e_trig useby(e_trig);
	}
	level notify(str_name, ent);
	if(e_trig is_look_trigger())
	{
		e_trig notify(#"trigger_look", {#entity:ent});
	}
	return e_trig;
}

/*
	Name: set_flag_permissions
	Namespace: trigger
	Checksum: 0xBDB9FFA3
	Offset: 0x1DA8
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function set_flag_permissions(msg)
{
	if(!isdefined(level.trigger_flags) || !isdefined(level.trigger_flags[msg]))
	{
		return;
	}
	level.trigger_flags[msg] = array::remove_undefined(level.trigger_flags[msg]);
	array::thread_all(level.trigger_flags[msg], &update_based_on_flags);
}

/*
	Name: update_based_on_flags
	Namespace: trigger
	Checksum: 0x6D30F197
	Offset: 0x1E50
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function update_based_on_flags()
{
	true_on = 1;
	if(isdefined(self.script_flag_true))
	{
		tokens = util::create_flags_and_return_tokens(self.script_flag_true);
		for(i = 0; i < tokens.size; i++)
		{
			if(!level flag::get(tokens[i]))
			{
				true_on = 0;
				break;
			}
		}
	}
	false_on = 1;
	if(isdefined(self.script_flag_false))
	{
		tokens = util::create_flags_and_return_tokens(self.script_flag_false);
		for(i = 0; i < tokens.size; i++)
		{
			if(level flag::get(tokens[i]))
			{
				false_on = 0;
				break;
			}
		}
	}
	var_369930e5 = 1;
	if(isdefined(self.script_flag_true_any))
	{
		var_369930e5 = 0;
		tokens = util::create_flags_and_return_tokens(self.script_flag_true_any);
		for(i = 0; i < tokens.size; i++)
		{
			if(level flag::get(tokens[i]))
			{
				var_369930e5 = 1;
				break;
			}
		}
	}
	var_95bf6d6c = 1;
	if(isdefined(self.script_flag_false_any))
	{
		var_95bf6d6c = 0;
		tokens = util::create_flags_and_return_tokens(self.script_flag_false_any);
		for(i = 0; i < tokens.size; i++)
		{
			if(!level flag::get(tokens[i]))
			{
				var_95bf6d6c = 1;
				break;
			}
		}
	}
	self triggerenable(true_on && false_on && var_369930e5 && var_95bf6d6c);
}

/*
	Name: is_look_trigger
	Namespace: trigger
	Checksum: 0x7C7694DE
	Offset: 0x20C8
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function is_look_trigger()
{
	return isdefined(self.spawnflags) && self.spawnflags & 256 == 256 && !is_trigger_of_type("trigger_damage") && !is_trigger_of_type("trigger_damage_new");
}

/*
	Name: is_trigger_once
	Namespace: trigger
	Checksum: 0x3DDEEF39
	Offset: 0x2138
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function is_trigger_once()
{
	return isdefined(self.spawnflags) && self.spawnflags & 1024 == 1024 || is_trigger_of_type("trigger_once", "trigger_once_new");
}

/*
	Name: wait_till_any
	Namespace: trigger
	Checksum: 0x696C5E08
	Offset: 0x2190
	Size: 0x1B2
	Parameters: 1
	Flags: Linked, Variadic
*/
function wait_till_any(vararg)
{
	ent = spawnstruct();
	if(isarray(vararg[0]))
	{
		var_6a8e65fd = vararg[0];
	}
	else
	{
		var_6a8e65fd = vararg;
	}
	/#
		assert(var_6a8e65fd.size, "");
	#/
	a_triggers = [];
	a_triggers = arraycombine(a_triggers, getentarray(var_6a8e65fd[0], "targetname"), 1, 0);
	for(i = 1; i < var_6a8e65fd.size; i++)
	{
		a_triggers = arraycombine(a_triggers, getentarray(var_6a8e65fd[i], "targetname"), 1, 0);
	}
	for(i = 0; i < a_triggers.size; i++)
	{
		ent thread _ent_waits_for_trigger(a_triggers[i]);
	}
	waitresult = undefined;
	waitresult = ent waittill(#"done");
	return waitresult.trigger;
}

/*
	Name: wait_for_either
	Namespace: trigger
	Checksum: 0xC565EAF6
	Offset: 0x2350
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function wait_for_either(str_targetname1, str_targetname2)
{
	trigger = wait_till_any(str_targetname1, str_targetname2);
	return trigger;
}

/*
	Name: _ent_waits_for_trigger
	Namespace: trigger
	Checksum: 0xCEAAABF1
	Offset: 0x2398
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function _ent_waits_for_trigger(trigger)
{
	self endon(#"done");
	trigger wait_till();
	self notify(#"done", {#trigger:trigger});
}

/*
	Name: wait_or_timeout
	Namespace: trigger
	Checksum: 0xC791F662
	Offset: 0x2400
	Size: 0x8C
	Parameters: 3
	Flags: None
*/
function wait_or_timeout(n_time, str_name, str_key)
{
	if(isdefined(n_time))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_time, "timeout");
	}
	wait_till(str_name, str_key);
}

/*
	Name: trigger_on_timeout
	Namespace: trigger
	Checksum: 0x34FD6BBD
	Offset: 0x2498
	Size: 0xF4
	Parameters: 4
	Flags: None
*/
function trigger_on_timeout(n_time, b_cancel_on_triggered = 1, str_name, str_key = "targetname")
{
	trig = self;
	if(isdefined(str_name))
	{
		trig = getent(str_name, str_key);
	}
	if(b_cancel_on_triggered)
	{
		if(trig is_look_trigger())
		{
			trig endon(#"trigger_look");
		}
		else
		{
			trig endon(#"trigger");
		}
	}
	trig endon(#"death");
	wait(n_time);
	trig use();
}

/*
	Name: multiple_waits
	Namespace: trigger
	Checksum: 0xF410B8C8
	Offset: 0x2598
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function multiple_waits(str_trigger_name, str_trigger_notify)
{
	foreach(trigger in getentarray(str_trigger_name, "targetname"))
	{
		trigger thread multiple_wait(str_trigger_notify);
	}
}

/*
	Name: multiple_wait
	Namespace: trigger
	Checksum: 0x7F85B482
	Offset: 0x2648
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function multiple_wait(str_trigger_notify)
{
	level endon(str_trigger_notify);
	self waittill(#"trigger");
	level notify(str_trigger_notify);
}

/*
	Name: add_function
	Namespace: trigger
	Checksum: 0x26A3A9F
	Offset: 0x2688
	Size: 0x84
	Parameters: 9
	Flags: Linked
*/
function add_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6)
{
	self thread _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6);
}

/*
	Name: _do_trigger_function
	Namespace: trigger
	Checksum: 0xB5B270AF
	Offset: 0x2718
	Size: 0x108
	Parameters: 9
	Flags: Linked
*/
function _do_trigger_function(trigger, str_remove_on, func, param_1, param_2, param_3, param_4, param_5, param_6)
{
	self endon(#"death");
	trigger endon(#"death");
	if(isdefined(str_remove_on))
	{
		trigger endon(str_remove_on);
	}
	while(true)
	{
		if(isstring(trigger))
		{
			wait_till(trigger);
		}
		else
		{
			trigger wait_till();
		}
		util::single_thread(self, func, param_1, param_2, param_3, param_4, param_5, param_6);
	}
}

/*
	Name: kill_spawner_trigger
	Namespace: trigger
	Checksum: 0xD9E37531
	Offset: 0x2828
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function kill_spawner_trigger(s_info)
{
	a_spawners = getspawnerarray(self.script_killspawner, "script_killspawner");
	foreach(sp in a_spawners)
	{
		sp delete();
	}
	a_ents = getentarray(self.script_killspawner, "script_killspawner");
	foreach(ent in a_ents)
	{
		if(ent.classname === "spawn_manager" && ent != self)
		{
			ent delete();
		}
	}
}

/*
	Name: trigger_group
	Namespace: trigger
	Checksum: 0x561D8177
	Offset: 0x29A0
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function trigger_group(s_info)
{
	foreach(trig in getentarray(self.script_trigger_group, "script_trigger_group"))
	{
		if(trig != self)
		{
			trig delete();
		}
	}
}

/*
	Name: function_521edc64
	Namespace: trigger
	Checksum: 0x463179E0
	Offset: 0x2A50
	Size: 0x11C
	Parameters: 3
	Flags: None
*/
function function_521edc64(ent, on_enter_payload, on_exit_payload)
{
	ent endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_f911c758 = self getentitynumber();
	if(ent ent_already_in(var_f911c758))
	{
		return;
	}
	add_to_ent(ent, var_f911c758);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && isdefined(self) && ent istouching(self))
	{
		waitframe(1);
	}
	if(isdefined(ent))
	{
		if(isdefined(on_exit_payload))
		{
			[[on_exit_payload]](ent);
		}
		remove_from_ent(ent, var_f911c758);
	}
}

/*
	Name: ent_already_in
	Namespace: trigger
	Checksum: 0x67CDDE08
	Offset: 0x2B78
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function ent_already_in(var_d35ff8d8)
{
	if(!isdefined(self._triggers))
	{
		return 0;
	}
	if(!isdefined(self._triggers[var_d35ff8d8]))
	{
		return 0;
	}
	if(!self._triggers[var_d35ff8d8])
	{
		return 0;
	}
	return 1;
}

/*
	Name: add_to_ent
	Namespace: trigger
	Checksum: 0xAEEB2CCA
	Offset: 0x2BD0
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function add_to_ent(ent, var_d35ff8d8)
{
	if(!isdefined(ent._triggers))
	{
		ent._triggers = [];
	}
	ent._triggers[var_d35ff8d8] = 1;
}

/*
	Name: remove_from_ent
	Namespace: trigger
	Checksum: 0xA798F046
	Offset: 0x2C28
	Size: 0x56
	Parameters: 2
	Flags: Linked
*/
function remove_from_ent(ent, var_d35ff8d8)
{
	if(!isdefined(ent._triggers))
	{
		return;
	}
	if(!isdefined(ent._triggers[var_d35ff8d8]))
	{
		return;
	}
	ent._triggers[var_d35ff8d8] = 0;
}

/*
	Name: trigger_wait
	Namespace: trigger
	Checksum: 0x3780D113
	Offset: 0x2C88
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function trigger_wait()
{
	self endon(#"trigger");
	if(isdefined(self.targetname))
	{
		trig = getent(self.targetname, "target");
		if(isdefined(trig))
		{
			trig wait_till();
		}
	}
}

/*
	Name: run
	Namespace: trigger
	Checksum: 0x595C9D20
	Offset: 0x2D00
	Size: 0x10C
	Parameters: 2
	Flags: Variadic
*/
function run(func, vararg)
{
	var_3bdd90c2 = 0;
	if(isdefined(self.targetname))
	{
		foreach(trig in getentarraybytype(20))
		{
			if(trig.target === self.targetname)
			{
				trig callback::function_35a12f19(&function_996dfbe2, undefined, self, func, vararg);
				var_3bdd90c2 = 1;
			}
		}
	}
	if(!var_3bdd90c2)
	{
		util::single_thread_argarray(self, func, vararg);
	}
}

/*
	Name: function_996dfbe2
	Namespace: trigger
	Checksum: 0x5B72F454
	Offset: 0x2E18
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_996dfbe2(s_info, ent, func, a_args)
{
	util::single_func_argarray(ent, func, a_args);
}

