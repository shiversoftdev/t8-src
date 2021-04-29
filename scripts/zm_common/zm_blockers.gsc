// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1254ac024174d9c0;
#using script_301f64a4090c381a;
#using script_3f9e0dc8454d98e1;
#using script_6e3c826b1814cab6;
#using script_ab890501c40b73c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\demo_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_daily_challenges.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_blockers;

/*
	Name: function_89f2df9
	Namespace: zm_blockers
	Checksum: 0xB5F0BE97
	Offset: 0x878
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_blockers", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_blockers
	Checksum: 0xB7E56E60
	Offset: 0x8C8
	Size: 0x2DC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "doorbuy_ambient_fx", 1, 1, "int");
	clientfield::register("scriptmover", "doorbuy_bought_fx", 1, 1, "int");
	clientfield::register("scriptmover", "debrisbuy_ambient_fx", 1, 1, "int");
	clientfield::register("scriptmover", "debrisbuy_bought_fx", 1, 1, "int");
	clientfield::register("scriptmover", "power_door_ambient_fx", 1, 1, "int");
	clientfield::register("scriptmover", "power_door_bought_fx", 1, 1, "int");
	clientfield::register("scriptmover", "power_debris_ambient_fx", 1, 1, "int");
	clientfield::register("scriptmover", "power_debris_bought_fx", 1, 1, "int");
	if(isdefined(level.var_c621179))
	{
		thread [[level.var_c621179]]();
	}
	else if(function_8b1a219a())
	{
		zm_utility::add_zombie_hint("default_buy_debris", #"hash_4b77c0a6bc72bc31");
	}
	else
	{
		zm_utility::add_zombie_hint("default_buy_debris", #"hash_1595dd9d4d64f37b");
	}
	if(function_8b1a219a())
	{
		zm_utility::add_zombie_hint("default_buy_door", #"hash_5483a959bcbbba41");
		zm_utility::add_zombie_hint("default_buy_door_close", #"hash_4cf42029f734b45b");
	}
	else
	{
		zm_utility::add_zombie_hint("default_buy_door", #"hash_456cd0f0d10be48b");
		zm_utility::add_zombie_hint("default_buy_door_close", #"hash_261288d018c0e7e5");
	}
	init_blockers();
}

/*
	Name: __main__
	Namespace: zm_blockers
	Checksum: 0x115FC31C
	Offset: 0xBB0
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(isdefined(level.quantum_bomb_register_result_func))
	{
		[[level.quantum_bomb_register_result_func]]("open_nearest_door", &quantum_bomb_open_nearest_door_result, 35, &quantum_bomb_open_nearest_door_validation);
	}
}

/*
	Name: init_blockers
	Namespace: zm_blockers
	Checksum: 0xDD5079AC
	Offset: 0xC00
	Size: 0x17C
	Parameters: 0
	Flags: Linked
*/
function init_blockers()
{
	level.exterior_goals = struct::get_array("exterior_goal", "targetname");
	array::thread_all(level.exterior_goals, &blocker_init);
	level.barrier_align = struct::get_array("barrier_align", "targetname");
	zombie_doors = getentarray("zombie_door", "targetname");
	if(isdefined(zombie_doors))
	{
		level flag::init("door_can_close");
		array::thread_all(zombie_doors, &door_init);
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	array::thread_all(zombie_debris, &debris_init);
	flag_blockers = getentarray("flag_blocker", "targetname");
	array::thread_all(flag_blockers, &flag_blocker);
}

/*
	Name: door_init
	Namespace: zm_blockers
	Checksum: 0x3A3E91B1
	Offset: 0xD88
	Size: 0x584
	Parameters: 0
	Flags: Linked
*/
function door_init()
{
	self.type = undefined;
	self.purchaser = undefined;
	self._door_open = 0;
	var_ecc45b8c = struct::get_array(self.target, "targetname");
	foreach(var_c3be418 in var_ecc45b8c)
	{
		if(var_c3be418.model === "p8_zm_door_buy_symbol_01" || var_c3be418.model === "p8_zm_debris_buy_symbol_01" || var_c3be418.model === "p8_zm_power_door_symbol_01")
		{
			var_c3be418 function_23cbcd8();
		}
	}
	ent_targets = getentarray(self.target, "targetname");
	node_targets = getnodearray(self.target, "targetname");
	targets = arraycombine(ent_targets, node_targets, 0, 0);
	if(isdefined(self.script_flag) && !isdefined(level.flag[self.script_flag]))
	{
		if(isdefined(self.script_flag))
		{
			tokens = strtok(self.script_flag, ",");
			for(i = 0; i < tokens.size; i++)
			{
				level flag::init(self.script_flag);
			}
		}
	}
	if(!isdefined(self.script_noteworthy))
	{
		self.script_noteworthy = "default";
	}
	self.doors = [];
	for(i = 0; i < targets.size; i++)
	{
		targets[i] door_classify(self);
		if(!isdefined(targets[i].og_origin))
		{
			targets[i].og_origin = targets[i].origin;
			targets[i].og_angles = targets[i].angles;
		}
	}
	if(namespace_59ff1d6c::function_901b751c(#"hash_2c6b5594940cc305") == 0)
	{
		self setinvisibletoall();
		self.var_1661d836 = 1;
		return;
	}
	cost = function_a9bf8f6c(self);
	self setcursorhint("HINT_NOICON");
	self thread blocker_update_prompt_visibility();
	self thread door_think();
	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "electric_door" || self.script_noteworthy == "electric_buyable_door")
		{
			if(zm_utility::function_3b2b3a2f() || namespace_59ff1d6c::function_901b751c(#"zmpowerstate") == 0)
			{
				self setinvisibletoall();
				return;
			}
			self thread function_dafd2e5a();
			if(isdefined(level.door_dialog_function))
			{
				self thread [[level.door_dialog_function]]();
			}
			return;
		}
		if(self.script_noteworthy == "local_electric_door")
		{
			if(zm_utility::function_3b2b3a2f())
			{
				self setinvisibletoall();
				return;
			}
			self sethintstring(#"hash_671e980430950a22");
			if(isdefined(level.door_dialog_function))
			{
				self thread [[level.door_dialog_function]]();
			}
			return;
		}
		if(self.script_noteworthy == "kill_counter_door")
		{
			self sethintstring(#"hash_25a2adc4e37f3813", cost);
			return;
		}
	}
	if(isdefined(level.var_d0b54199))
	{
		self thread [[level.var_d0b54199]](self, cost);
	}
	else
	{
		self zm_utility::set_hint_string(self, "default_buy_door", cost);
	}
}

/*
	Name: door_classify
	Namespace: zm_blockers
	Checksum: 0x708C1789
	Offset: 0x1318
	Size: 0x21A
	Parameters: 1
	Flags: Linked
*/
function door_classify(parent_trig)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate")
	{
		unlinktraversal(self);
		parent_trig.doors[parent_trig.doors.size] = self;
		return;
	}
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "clip")
	{
		parent_trig.clip = self;
		parent_trig.script_string = "clip";
	}
	else if(!isdefined(self.script_string))
	{
		if(isdefined(self.script_angles))
		{
			self.script_string = "rotate";
		}
		else if(isdefined(self.script_vector))
		{
			self.script_string = "move";
		}
	}
	else if(!isdefined(self.script_string))
	{
		self.script_string = "";
	}
	switch(self.script_string)
	{
		case "anim":
		{
			/#
				assert(isdefined(self.script_animname), "" + self.targetname);
			#/
			/#
				assert(isdefined(level.scr_anim[self.script_animname]), "" + self.script_animname);
			#/
			/#
				assert(isdefined(level.blocker_anim_func), "");
			#/
			break;
		}
	}
	if(self.classname == "script_brushmodel")
	{
		self disconnectpaths();
	}
	parent_trig.doors[parent_trig.doors.size] = self;
}

/*
	Name: door_buy
	Namespace: zm_blockers
	Checksum: 0xD7572BF
	Offset: 0x1540
	Size: 0x4D8
	Parameters: 0
	Flags: Linked
*/
function door_buy()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	who = waitresult.activator;
	force = waitresult.var_3fc8547c;
	if(getdvarint(#"zombie_unlock_all", 0) > 0 || (isdefined(force) && force) || (isdefined(level.var_5791d548) && level.var_5791d548))
	{
		return 1;
	}
	if(!isdefined(who) || !who usebuttonpressed())
	{
		return 0;
	}
	if(isdefined(level.custom_door_buy_check))
	{
		if(!who [[level.custom_door_buy_check]](self))
		{
			return 0;
		}
	}
	if(who zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(who zm_utility::is_drinking())
	{
		return 0;
	}
	if(namespace_497ab7da::is_active())
	{
		return 0;
	}
	cost = 0;
	upgraded = 0;
	if(zm_utility::is_player_valid(who))
	{
		players = getplayers();
		cost = self.zombie_cost;
		if(self._door_open == 1)
		{
			self.purchaser = undefined;
		}
		else if(who zm_score::can_player_purchase(cost))
		{
			who zm_score::minus_to_player_score(cost);
			scoreevents::processscoreevent("open_door", who);
			demo::bookmark(#"zm_player_door", gettime(), who);
			potm::bookmark(#"zm_player_door", gettime(), who);
			who zm_stats::increment_client_stat("doors_purchased");
			who zm_stats::increment_player_stat("doors_purchased");
			who zm_stats::function_2726a7c2("doors_purchased");
			who zm_stats::increment_challenge_stat(#"survivalist_buy_door");
			who zm_stats::function_8f10788e("boas_doors_purchased");
			who zm_stats::function_c0c6ab19(#"hash_4b7ef387cb9982f4", 1, 1);
			who contracts::function_5b88297d(#"hash_1a937aa7eeb3cde3", 1, #"zstandard");
			self.purchaser = who;
			who namespace_e38c57c1::function_c3f3716();
		}
		else
		{
			zm_utility::play_sound_at_pos("no_purchase", self.origin);
			if(isdefined(level.custom_door_deny_vo_func))
			{
				who thread [[level.custom_door_deny_vo_func]]();
			}
			else if(isdefined(level.custom_generic_deny_vo_func))
			{
				who thread [[level.custom_generic_deny_vo_func]](1);
			}
			else
			{
				who zm_audio::create_and_play_dialog(#"general", #"outofmoney");
			}
			return 0;
		}
	}
	if(isdefined(level._door_open_rumble_func))
	{
		who thread [[level._door_open_rumble_func]]();
	}
	who recordmapevent(5, gettime(), who.origin, level.round_number, cost);
	bb::function_ab9bb12c(who, self, cost, self.target, upgraded, "_door", "_purchase");
	return 1;
}

/*
	Name: function_db84b4f4
	Namespace: zm_blockers
	Checksum: 0x25536B08
	Offset: 0x1A20
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function function_db84b4f4()
{
	var_4506f72b = getentarray("zombie_door", "targetname");
	level thread function_5989dd12(var_4506f72b);
	var_38a6b7d0 = getentarray("zombie_airlock_buy", "targetname");
	level thread function_5989dd12(var_38a6b7d0);
	var_ed3ddfdf = getentarray("zombie_debris", "targetname");
	level thread function_5989dd12(var_ed3ddfdf);
}

/*
	Name: function_5989dd12
	Namespace: zm_blockers
	Checksum: 0x69B5946D
	Offset: 0x1AF0
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_5989dd12(a_doors)
{
	foreach(door in a_doors)
	{
		door force_open_door();
		waitframe(1);
	}
}

/*
	Name: force_open_door
	Namespace: zm_blockers
	Checksum: 0xE877FDD7
	Offset: 0x1B80
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function force_open_door(var_64c09f7f)
{
	self notify(#"trigger", {#hash_3fc8547c:1, #activator:var_64c09f7f});
}

/*
	Name: blocker_update_prompt_visibility
	Namespace: zm_blockers
	Checksum: 0x750413F3
	Offset: 0x1BD0
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function blocker_update_prompt_visibility()
{
	self endon(#"kill_door_think", #"kill_debris_prompt_thread", #"death");
	while(true)
	{
		a_players = util::get_active_players();
		for(i = 0; i < a_players.size; i++)
		{
			if(distancesquared(a_players[i].origin, self.origin) < dist)
			{
				if(a_players[i] zm_utility::is_drinking())
				{
					self setinvisibletoplayer(a_players[i], 1);
					continue;
				}
				self setinvisibletoplayer(a_players[i], 0);
			}
		}
		wait(0.25);
	}
}

/*
	Name: door_delay
	Namespace: zm_blockers
	Checksum: 0x11E366B9
	Offset: 0x1D18
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function door_delay()
{
	if(!isdefined(self.script_int))
	{
		self.script_int = 5;
	}
	a_trigs = getentarray(self.target, "target");
	for(i = 0; i < a_trigs.size; i++)
	{
		a_trigs[i] triggerenable(0);
	}
	wait(self.script_int);
	for(i = 0; i < self.script_int; i++)
	{
		/#
			iprintln(self.script_int - i);
		#/
		wait(1);
	}
}

/*
	Name: door_activate
	Namespace: zm_blockers
	Checksum: 0x99B1862E
	Offset: 0x1E08
	Size: 0x5DC
	Parameters: 4
	Flags: Linked
*/
function door_activate(time, open = 1, quick, use_blocker_clip_for_pathing)
{
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "air_buy_gate")
	{
		if(open)
		{
			linktraversal(self);
		}
		else
		{
			unlinktraversal(self);
		}
		return;
	}
	if(!isdefined(time))
	{
		time = 1;
		if(isdefined(self.script_transition_time))
		{
			time = self.script_transition_time;
		}
	}
	if(isdefined(self.door_moving))
	{
		if(isdefined(self.script_noteworthy) && self.script_noteworthy == "clip" || (isdefined(self.script_string) && self.script_string == "clip"))
		{
			if(!(isdefined(use_blocker_clip_for_pathing) && use_blocker_clip_for_pathing))
			{
				if(!open)
				{
					return;
				}
			}
		}
		else
		{
			return;
		}
	}
	self.door_moving = 1;
	level notify(#"snddooropening");
	if(open || (!(isdefined(quick) && quick)))
	{
		self notsolid();
	}
	if(self.classname == "script_brushmodel" || self.classname == "script_model")
	{
		if(open)
		{
			self connectpaths();
		}
	}
	if(isdefined(self.script_noteworthy) && self.script_noteworthy == "clip" || (isdefined(self.script_string) && self.script_string == "clip"))
	{
		if(!open)
		{
			self util::delay(time, undefined, &self_disconnectpaths);
			wait(0.1);
			self solid();
		}
		return;
	}
	if(isdefined(self.script_sound))
	{
		if(open)
		{
			playsoundatposition(self.script_sound, self.origin);
		}
		else
		{
			playsoundatposition(self.script_sound + "_close", self.origin);
		}
	}
	else
	{
		zm_utility::play_sound_at_pos("zmb_heavy_door_open", self.origin);
	}
	scale = 1;
	if(!open)
	{
		scale = -1;
	}
	switch(self.script_string)
	{
		case "rotate":
		{
			if(isdefined(self.script_angles))
			{
				rot_angle = self.script_angles;
				if(!open)
				{
					rot_angle = self.og_angles;
				}
				self rotateto(rot_angle, time, 0, 0);
				self thread door_solid_thread();
				if(!open)
				{
					self thread disconnect_paths_when_done();
				}
			}
			wait(randomfloat(0.15));
			break;
		}
		case "move":
		case "slide_apart":
		{
			if(isdefined(self.script_vector))
			{
				vector = vectorscale(self.script_vector, scale);
				if(time >= 0.5)
				{
					self moveto(self.origin + vector, time, time * 0.25, time * 0.25);
				}
				else
				{
					self moveto(self.origin + vector, time);
				}
				self thread door_solid_thread();
				if(!open)
				{
					self thread disconnect_paths_when_done();
				}
			}
			wait(randomfloat(0.15));
			break;
		}
		case "anim":
		{
			self [[level.blocker_anim_func]](self.script_animname);
			self thread door_solid_thread_anim();
			wait(randomfloat(0.15));
			break;
		}
		case "physics":
		{
			self thread physics_launch_door(self);
			wait(0.1);
			break;
		}
		case "zbarrier":
		{
			self thread door_zbarrier_move();
			break;
		}
	}
	if(isdefined(self.script_firefx))
	{
		playfx(level._effect[self.script_firefx], self.origin);
	}
}

/*
	Name: kill_trapped_zombies
	Namespace: zm_blockers
	Checksum: 0xA0997414
	Offset: 0x23F0
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function kill_trapped_zombies(trigger)
{
	zombies = getaiteamarray(level.zombie_team);
	if(!isdefined(zombies))
	{
		return;
	}
	for(i = 0; i < zombies.size; i++)
	{
		if(!isdefined(zombies[i]))
		{
			continue;
		}
		if(zombies[i] istouching(trigger))
		{
			zombies[i].marked_for_recycle = 1;
			zombies[i] dodamage(zombies[i].health + 666, trigger.origin, self);
			wait(randomfloat(0.15));
			continue;
		}
		if(isdefined(level.custom_trapped_zombies))
		{
			zombies[i] thread [[level.custom_trapped_zombies]]();
			wait(randomfloat(0.15));
		}
	}
}

/*
	Name: any_player_touching
	Namespace: zm_blockers
	Checksum: 0xD4BBCE45
	Offset: 0x2540
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function any_player_touching(trigger)
{
	foreach(player in getplayers())
	{
		if(player istouching(trigger))
		{
			return 1;
		}
		wait(0.01);
	}
	return 0;
}

/*
	Name: any_player_touching_any
	Namespace: zm_blockers
	Checksum: 0x88F752B1
	Offset: 0x25F0
	Size: 0x168
	Parameters: 2
	Flags: Linked
*/
function any_player_touching_any(trigger, more_triggers)
{
	foreach(player in getplayers())
	{
		if(zm_utility::is_player_valid(player, 0, 1))
		{
			if(isdefined(trigger) && player istouching(trigger))
			{
				return 1;
			}
			if(isdefined(more_triggers) && more_triggers.size > 0)
			{
				foreach(trig in more_triggers)
				{
					if(isdefined(trig) && player istouching(trig))
					{
						return 1;
					}
				}
			}
		}
	}
	return 0;
}

/*
	Name: any_zombie_touching_any
	Namespace: zm_blockers
	Checksum: 0xD0973401
	Offset: 0x2760
	Size: 0x168
	Parameters: 2
	Flags: Linked
*/
function any_zombie_touching_any(trigger, more_triggers)
{
	zombies = getaiteamarray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(isdefined(trigger) && zombie istouching(trigger))
		{
			return 1;
		}
		if(isdefined(more_triggers) && more_triggers.size > 0)
		{
			foreach(trig in more_triggers)
			{
				if(isdefined(trig) && zombie istouching(trig))
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: wait_trigger_clear
	Namespace: zm_blockers
	Checksum: 0x9A6C469D
	Offset: 0x28D0
	Size: 0x8E
	Parameters: 3
	Flags: Linked
*/
function wait_trigger_clear(trigger, more_triggers, end_on)
{
	self endon(end_on);
	while(any_player_touching_any(trigger, more_triggers) || any_zombie_touching_any(trigger, more_triggers))
	{
		wait(1);
	}
	/#
		println("");
	#/
	self notify(#"trigger_clear");
}

/*
	Name: waittill_door_trigger_clear_local_power_off
	Namespace: zm_blockers
	Checksum: 0xC33645A1
	Offset: 0x2968
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function waittill_door_trigger_clear_local_power_off(trigger, a_trigs)
{
	self endon(#"trigger_clear");
	while(true)
	{
		if(isdefined(self.local_power_on) && self.local_power_on)
		{
			self waittill(#"local_power_off");
		}
		/#
			println("");
		#/
		self wait_trigger_clear(trigger, a_trigs, "local_power_on");
	}
}

/*
	Name: waittill_door_trigger_clear_global_power_off
	Namespace: zm_blockers
	Checksum: 0x90DB7509
	Offset: 0x2A10
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function waittill_door_trigger_clear_global_power_off(trigger, a_trigs)
{
	self endon(#"trigger_clear");
	while(true)
	{
		if(isdefined(self.power_on) && self.power_on)
		{
			self waittill(#"power_off");
		}
		/#
			println("");
		#/
		self wait_trigger_clear(trigger, a_trigs, "power_on");
	}
}

/*
	Name: waittill_door_can_close
	Namespace: zm_blockers
	Checksum: 0x8BDB524A
	Offset: 0x2AB8
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function waittill_door_can_close()
{
	trigger = undefined;
	if(isdefined(self.door_hold_trigger))
	{
		trigger = getent(self.door_hold_trigger, "targetname");
	}
	a_trigs = getentarray(self.target, "target");
	switch(self.script_noteworthy)
	{
		case "local_electric_door":
		{
			if(isdefined(trigger) || isdefined(a_trigs))
			{
				self waittill_door_trigger_clear_local_power_off(trigger, a_trigs);
				self thread kill_trapped_zombies(trigger);
			}
			else if(isdefined(self.local_power_on) && self.local_power_on)
			{
				self waittill(#"local_power_off");
			}
			return;
		}
		case "electric_door":
		{
			if(isdefined(trigger) || isdefined(a_trigs))
			{
				self waittill_door_trigger_clear_global_power_off(trigger, a_trigs);
				if(isdefined(trigger))
				{
					self thread kill_trapped_zombies(trigger);
				}
			}
			else if(isdefined(self.power_on) && self.power_on)
			{
				self waittill(#"power_off");
			}
			return;
		}
	}
}

/*
	Name: door_think
	Namespace: zm_blockers
	Checksum: 0x8E21F517
	Offset: 0x2C60
	Size: 0x5CE
	Parameters: 0
	Flags: Linked
*/
function door_think()
{
	self endon(#"kill_door_think");
	n_cost = self.zombie_cost;
	self sethintlowpriority(1);
	while(true)
	{
		switch(self.script_noteworthy)
		{
			case "local_electric_door":
			{
				if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 0)
				{
					return;
				}
				if(!(isdefined(self.local_power_on) && self.local_power_on))
				{
					self waittill(#"local_power_on");
				}
				if(!(isdefined(self._door_open) && self._door_open))
				{
					/#
						println("");
					#/
					self door_opened(n_cost, 1);
					if(!isdefined(self.power_cost))
					{
						self.power_cost = 0;
					}
					self.power_cost = self.power_cost + 200;
				}
				self sethintstring("");
				if(isdefined(level.local_doors_stay_open) && level.local_doors_stay_open)
				{
					return;
				}
				wait(3);
				self waittill_door_can_close();
				self door_block();
				if(isdefined(self._door_open) && self._door_open)
				{
					/#
						println("");
					#/
					self door_opened(n_cost, 1);
				}
				self sethintstring(#"hash_671e980430950a22");
				wait(3);
				continue;
			}
			case "electric_door":
			{
				if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 0)
				{
					return;
				}
				if(!(isdefined(self.power_on) && self.power_on))
				{
					self waittill(#"power_on");
				}
				if(isdefined(self.script_flag_wait))
				{
					level flag::wait_till(self.script_flag_wait);
				}
				if(!(isdefined(self._door_open) && self._door_open))
				{
					/#
						println("");
					#/
					self door_opened(n_cost, 1);
					if(!isdefined(self.power_cost))
					{
						self.power_cost = 0;
					}
					self.power_cost = self.power_cost + 200;
				}
				self sethintstring("");
				if(isdefined(level.local_doors_stay_open) && level.local_doors_stay_open)
				{
					return;
				}
				wait(3);
				self waittill_door_can_close();
				self door_block();
				if(isdefined(self._door_open) && self._door_open)
				{
					/#
						println("");
					#/
					self door_opened(n_cost, 1);
				}
				self thread function_dafd2e5a();
				wait(3);
				continue;
			}
			case "electric_buyable_door":
			{
				if(namespace_59ff1d6c::function_901b751c(#"hash_29004a67830922b6") == 0)
				{
					return;
				}
				if(!(isdefined(self.power_on) && self.power_on))
				{
					self waittill(#"power_on");
				}
				self zm_utility::set_hint_string(self, "default_buy_door", n_cost);
				if(!self door_buy())
				{
					continue;
				}
				break;
			}
			case "delay_door":
			{
				if(!self door_buy())
				{
					continue;
				}
				self door_delay();
				break;
			}
			default:
			{
				if(isdefined(level._default_door_custom_logic))
				{
					self [[level._default_door_custom_logic]]();
					break;
				}
				if(!self door_buy())
				{
					continue;
				}
				break;
			}
		}
		self door_opened(n_cost);
		if(!level flag::get("door_can_close"))
		{
			break;
		}
	}
}

/*
	Name: self_and_flag_wait
	Namespace: zm_blockers
	Checksum: 0xD1A2645
	Offset: 0x3238
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function self_and_flag_wait(msg)
{
	self endon(msg);
	if(isdefined(self.power_door_ignore_flag_wait) && self.power_door_ignore_flag_wait)
	{
		level waittill(#"forever");
	}
	else
	{
		level flag::wait_till(msg);
	}
}

/*
	Name: door_block
	Namespace: zm_blockers
	Checksum: 0x4D349426
	Offset: 0x32A8
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function door_block()
{
	if(isdefined(self.doors))
	{
		for(i = 0; i < self.doors.size; i++)
		{
			if(isdefined(self.doors[i].script_noteworthy) && self.doors[i].script_noteworthy == "clip" || (isdefined(self.doors[i].script_string) && self.doors[i].script_string == "clip"))
			{
				self.doors[i] solid();
			}
		}
	}
}

/*
	Name: door_opened
	Namespace: zm_blockers
	Checksum: 0x2B0A341
	Offset: 0x3380
	Size: 0x7E6
	Parameters: 2
	Flags: Linked
*/
function door_opened(cost, quick_close)
{
	if(isdefined(self.door_is_moving) && self.door_is_moving)
	{
		return;
	}
	self thread function_f2f6ce12();
	self.has_been_opened = 1;
	a_trigs = getentarray(self.target, "target");
	self.door_is_moving = 1;
	foreach(trig in a_trigs)
	{
		trig.door_is_moving = 1;
		trig triggerenable(0);
		trig.has_been_opened = 1;
		if(!isdefined(trig._door_open) || trig._door_open == 0)
		{
			trig._door_open = 1;
			trig notify(#"door_opened");
		}
		else
		{
			trig._door_open = 0;
		}
		if(isdefined(trig.script_flag) && trig._door_open == 1)
		{
			tokens = strtok(trig.script_flag, ",");
			for(i = 0; i < tokens.size; i++)
			{
				level flag::set(tokens[i]);
			}
		}
		else if(isdefined(trig.script_flag) && trig._door_open == 0)
		{
			tokens = strtok(trig.script_flag, ",");
			for(i = 0; i < tokens.size; i++)
			{
				level flag::clear(tokens[i]);
			}
		}
		if(isdefined(quick_close) && quick_close)
		{
			trig zm_utility::set_hint_string(trig, "");
			continue;
		}
		if(trig._door_open == 1 && level flag::get("door_can_close"))
		{
			trig zm_utility::set_hint_string(trig, "default_buy_door_close");
			continue;
		}
		if(trig._door_open == 0)
		{
			trig zm_utility::set_hint_string(trig, "default_buy_door", cost);
		}
	}
	level notify(#"door_opened", {#t_blocker:self, #e_player:self.purchaser});
	if(isdefined(self.doors))
	{
		is_script_model_door = 0;
		have_moving_clip_for_door = 0;
		use_blocker_clip_for_pathing = 0;
		self.doors = array::remove_undefined(self.doors);
		foreach(door in self.doors)
		{
			if(isdefined(door.ignore_use_blocker_clip_for_pathing_check) && door.ignore_use_blocker_clip_for_pathing_check)
			{
				continue;
			}
			if(isdefined(door.script_noteworthy) && door.script_noteworthy == "air_buy_gate")
			{
				continue;
			}
			if(door.classname == "script_model")
			{
				is_script_model_door = 1;
				continue;
			}
			if(door.classname == "script_brushmodel" && (!isdefined(door.script_noteworthy) || door.script_noteworthy != "clip") && (!isdefined(door.script_string) || door.script_string != "clip"))
			{
				have_moving_clip_for_door = 1;
			}
		}
		use_blocker_clip_for_pathing = is_script_model_door && !have_moving_clip_for_door;
		for(i = 0; i < self.doors.size; i++)
		{
			if(self.doors[i] zm_utility::function_1a4d2910())
			{
				continue;
			}
			self.doors[i] thread door_activate(self.doors[i].script_transition_time, self._door_open, quick_close, use_blocker_clip_for_pathing);
		}
		if(self.doors.size)
		{
			zm_utility::play_sound_at_pos("purchase", self.origin);
			if(isplayer(self.purchaser))
			{
				self.purchaser util::delay(1.25, "death", &zm_audio::create_and_play_dialog, #"door", #"open");
			}
		}
	}
	level.active_zone_names = zm_zonemgr::get_active_zone_names();
	wait(1);
	self.door_is_moving = 0;
	foreach(trig in a_trigs)
	{
		trig.door_is_moving = 0;
	}
	if(isdefined(quick_close) && quick_close)
	{
		for(i = 0; i < a_trigs.size; i++)
		{
			a_trigs[i] triggerenable(1);
		}
		return;
	}
	if(level flag::get("door_can_close"))
	{
		wait(2);
		for(i = 0; i < a_trigs.size; i++)
		{
			a_trigs[i] triggerenable(1);
		}
	}
}

/*
	Name: physics_launch_door
	Namespace: zm_blockers
	Checksum: 0x43089A85
	Offset: 0x3B70
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function physics_launch_door(door_trig)
{
	vec = vectorscale(vectornormalize(self.script_vector), 10);
	self rotateroll(5, 0.05);
	waitframe(1);
	self moveto(self.origin + vec, 0.1);
	self waittill(#"movedone");
	self physicslaunch(self.origin, self.script_vector * 300);
	wait(60);
	self delete();
}

/*
	Name: door_solid_thread
	Namespace: zm_blockers
	Checksum: 0xBB2D5258
	Offset: 0x3C60
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function door_solid_thread()
{
	self waittill(#"rotatedone", #"movedone", #"death");
	if(isdefined(self))
	{
		self.door_moving = undefined;
	}
	while(isdefined(self))
	{
		players = getplayers();
		player_touching = 0;
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(self))
			{
				player_touching = 1;
				break;
			}
		}
		if(!player_touching)
		{
			self solid();
			return;
		}
		wait(1);
	}
}

/*
	Name: door_solid_thread_anim
	Namespace: zm_blockers
	Checksum: 0x7B870441
	Offset: 0x3D60
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function door_solid_thread_anim()
{
	self waittill_match({#notetrack:"end"}, #"door_anim");
	self.door_moving = undefined;
	while(true)
	{
		players = getplayers();
		player_touching = 0;
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(self))
			{
				player_touching = 1;
				break;
			}
		}
		if(!player_touching)
		{
			self solid();
			return;
		}
		wait(1);
	}
}

/*
	Name: disconnect_paths_when_done
	Namespace: zm_blockers
	Checksum: 0x587D3739
	Offset: 0x3E58
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function disconnect_paths_when_done()
{
	self util::waittill_either("rotatedone", "movedone");
	self disconnectpaths();
}

/*
	Name: self_disconnectpaths
	Namespace: zm_blockers
	Checksum: 0x39ECA19B
	Offset: 0x3EA8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function self_disconnectpaths()
{
	self disconnectpaths();
}

/*
	Name: debris_init
	Namespace: zm_blockers
	Checksum: 0x1071F307
	Offset: 0x3ED0
	Size: 0x3AC
	Parameters: 0
	Flags: Linked
*/
function debris_init()
{
	n_cost = function_a9bf8f6c(self);
	if(isdefined(self.script_flag) && !isdefined(level.flag[self.script_flag]))
	{
		level flag::init(self.script_flag);
	}
	var_ecc45b8c = struct::get_array(self.target, "targetname");
	foreach(var_c3be418 in var_ecc45b8c)
	{
		var_c3be418 function_23cbcd8();
	}
	if(isdefined(level.var_9093a47e))
	{
		self thread [[level.var_9093a47e]](self, n_cost);
	}
	else
	{
		self zm_utility::set_hint_string(self, "default_buy_debris", n_cost);
	}
	self setcursorhint("HINT_NOICON");
	if(namespace_59ff1d6c::function_901b751c(#"hash_2c6b5594940cc305") == 0)
	{
		self setinvisibletoall();
		self.var_1661d836 = 1;
		return;
	}
	if(isdefined(self.target))
	{
		targets = getentarray(self.target, "targetname");
		foreach(target in targets)
		{
			if(target iszbarrier())
			{
				for(i = 0; i < target getnumzbarrierpieces(); i++)
				{
					target setzbarrierpiecestate(i, "closed");
				}
			}
		}
		a_nd_targets = getnodearray(self.target, "targetname");
		foreach(nd_target in a_nd_targets)
		{
			if(isdefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate")
			{
				unlinktraversal(nd_target);
			}
		}
	}
	self thread blocker_update_prompt_visibility();
	self thread debris_think();
}

/*
	Name: debris_think
	Namespace: zm_blockers
	Checksum: 0x4CAEDD91
	Offset: 0x4288
	Size: 0xFD4
	Parameters: 0
	Flags: Linked
*/
function debris_think()
{
	self endon(#"death");
	if(isdefined(level.custom_debris_function))
	{
		self [[level.custom_debris_function]]();
	}
	junk = getentarray(self.target, "targetname");
	for(i = 0; i < junk.size; i++)
	{
		if(isdefined(junk[i].script_noteworthy))
		{
			if(junk[i].script_noteworthy == "clip")
			{
				if(junk[i].script_string !== "skip_disconnectpaths")
				{
					junk[i] disconnectpaths();
				}
			}
		}
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		who = waitresult.activator;
		if(isdefined(who))
		{
			if(isdefined(level.var_2e93df96))
			{
				if(!who [[level.var_2e93df96]](self))
				{
					continue;
				}
			}
			else if(getdvarint(#"zombie_unlock_all", 0) > 0 || (isdefined(waitresult.var_3fc8547c) && waitresult.var_3fc8547c) || (isdefined(level.var_5791d548) && level.var_5791d548))
			{
			}
			else if(!who usebuttonpressed())
			{
				continue;
			}
			if(who zm_utility::is_drinking())
			{
				continue;
			}
			if(who zm_utility::in_revive_trigger())
			{
				continue;
			}
			if(isdefined(level.var_1092025b) && level.var_1092025b)
			{
				zm_utility::play_sound_at_pos("no_purchase", self.origin);
				continue;
			}
			if(namespace_497ab7da::is_active())
			{
				continue;
			}
		}
		if(zm_utility::is_player_valid(who))
		{
			players = getplayers();
			if(getdvarint(#"zombie_unlock_all", 0) > 0 || (isdefined(waitresult.var_3fc8547c) && waitresult.var_3fc8547c) || (isdefined(level.var_5791d548) && level.var_5791d548))
			{
			}
			else if(who zm_score::can_player_purchase(self.zombie_cost))
			{
				who zm_score::minus_to_player_score(self.zombie_cost);
				scoreevents::processscoreevent("open_door", who);
				demo::bookmark(#"zm_player_door", gettime(), who);
				potm::bookmark(#"zm_player_door", gettime(), who);
				who zm_stats::increment_client_stat("doors_purchased");
				who zm_stats::increment_player_stat("doors_purchased");
				who zm_stats::function_2726a7c2("doors_purchased");
				who zm_stats::increment_challenge_stat(#"survivalist_buy_door", undefined, 1);
				who zm_stats::function_8f10788e("boas_doors_purchased");
				who zm_stats::function_c0c6ab19(#"hash_4b7ef387cb9982f4", 1, 1);
				who contracts::function_5b88297d(#"hash_1a937aa7eeb3cde3", 1, #"zstandard");
				who namespace_e38c57c1::function_c3f3716();
			}
			else
			{
				zm_utility::play_sound_at_pos("no_purchase", self.origin);
				who zm_audio::create_and_play_dialog(#"general", #"outofmoney");
				continue;
			}
			self notify(#"kill_debris_prompt_thread");
			self thread function_f2f6ce12();
			junk = getentarray(self.target, "targetname");
			if(isdefined(self.script_flag))
			{
				tokens = strtok(self.script_flag, ",");
				for(i = 0; i < tokens.size; i++)
				{
					level flag::set(tokens[i]);
				}
			}
			zm_utility::play_sound_at_pos("purchase", self.origin);
			level notify(#"hash_6147a4961fd69a6e", {#t_blocker:self, #e_player:who});
			move_ent = undefined;
			a_clip = [];
			for(i = 0; i < junk.size; i++)
			{
				junk[i] connectpaths();
				if(isdefined(junk[i].script_noteworthy))
				{
					if(junk[i].script_noteworthy == "clip")
					{
						a_clip[a_clip.size] = junk[i];
						continue;
					}
				}
				struct = undefined;
				if(junk[i] iszbarrier())
				{
					move_ent = junk[i];
					junk[i] thread debris_zbarrier_move();
					continue;
				}
				if(isdefined(junk[i].script_linkto))
				{
					struct = struct::get(junk[i].script_linkto, "script_linkname");
					if(isdefined(struct))
					{
						move_ent = junk[i];
						junk[i] thread debris_move(struct);
					}
					else
					{
						junk[i] delete();
					}
					continue;
				}
				if(isdefined(junk[i].target))
				{
					struct = struct::get(junk[i].target, "targetname");
					if(isdefined(struct))
					{
						move_ent = junk[i];
						junk[i] thread debris_move(struct);
					}
					else
					{
						junk[i] delete();
					}
					continue;
				}
				if(isdefined(junk[i].objectid) && (junk[i].objectid == "symbol_front_debris" || junk[i].objectid == "symbol_back_debris"))
				{
					move_ent = junk[i];
					junk[i] thread debris_move();
					continue;
				}
				junk[i] delete();
			}
			a_nd_targets = getnodearray(self.target, "targetname");
			foreach(nd_target in a_nd_targets)
			{
				if(isdefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate")
				{
					linktraversal(nd_target);
				}
			}
			a_trigs = getentarray(self.target, "target");
			for(i = 0; i < a_trigs.size; i++)
			{
				if(a_trigs[i] != self)
				{
					a_trigs[i] delete();
				}
			}
			for(i = 0; i < a_clip.size; i++)
			{
				a_clip[i] delete();
			}
			if(isdefined(move_ent))
			{
				move_ent waittill(#"movedone");
			}
			self delete();
			break;
		}
		if(isdefined(waitresult.var_3fc8547c) && waitresult.var_3fc8547c)
		{
			self notify(#"kill_debris_prompt_thread");
			if(isdefined(level.var_a9944fbd))
			{
				self [[level.var_a9944fbd]]();
			}
			var_2b975c1a = getentarray(self.target, "targetname");
			if(isdefined(self.script_flag))
			{
				tokens = strtok(self.script_flag, ",");
				for(i = 0; i < tokens.size; i++)
				{
					level flag::set(tokens[i]);
				}
			}
			move_ent = undefined;
			a_clip = [];
			for(i = 0; i < var_2b975c1a.size; i++)
			{
				var_2b975c1a[i] connectpaths();
				if(isdefined(var_2b975c1a[i].script_noteworthy))
				{
					if(var_2b975c1a[i].script_noteworthy == "clip")
					{
						a_clip[a_clip.size] = var_2b975c1a[i];
						continue;
					}
				}
				struct = undefined;
				if(var_2b975c1a[i] iszbarrier())
				{
					move_ent = var_2b975c1a[i];
					var_2b975c1a[i] thread debris_zbarrier_move();
					continue;
				}
				if(isdefined(var_2b975c1a[i].script_linkto))
				{
					struct = struct::get(var_2b975c1a[i].script_linkto, "script_linkname");
					if(isdefined(struct))
					{
						move_ent = var_2b975c1a[i];
						var_2b975c1a[i] thread debris_move(struct);
					}
					else
					{
						var_2b975c1a[i] delete();
					}
					continue;
				}
				if(isdefined(var_2b975c1a[i].target))
				{
					struct = struct::get(var_2b975c1a[i].target, "targetname");
					if(isdefined(struct))
					{
						move_ent = var_2b975c1a[i];
						var_2b975c1a[i] thread debris_move(struct);
					}
					else
					{
						var_2b975c1a[i] delete();
					}
					continue;
				}
				var_2b975c1a[i] delete();
			}
			a_nd_targets = getnodearray(self.target, "targetname");
			foreach(nd_target in a_nd_targets)
			{
				if(isdefined(nd_target.script_noteworthy) && nd_target.script_noteworthy == "air_buy_gate")
				{
					linktraversal(nd_target);
				}
			}
			a_trigs = getentarray(self.target, "target");
			for(i = 0; i < a_trigs.size; i++)
			{
				if(a_trigs[i] != self)
				{
					a_trigs[i] delete();
				}
			}
			for(i = 0; i < a_clip.size; i++)
			{
				a_clip[i] delete();
			}
			if(isdefined(move_ent))
			{
				move_ent waittill(#"movedone");
			}
			self delete();
			break;
		}
	}
}

/*
	Name: debris_zbarrier_move
	Namespace: zm_blockers
	Checksum: 0xFA6AB107
	Offset: 0x5268
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function debris_zbarrier_move()
{
	if(self.script_noteworthy !== "skip_buy_fx")
	{
		playfx(level._effect[#"poltergeist"], self.origin);
	}
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self thread move_chunk(i, 1);
	}
}

/*
	Name: door_zbarrier_move
	Namespace: zm_blockers
	Checksum: 0xBA6A1AEF
	Offset: 0x5310
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function door_zbarrier_move()
{
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self thread move_chunk(i, 0);
	}
}

/*
	Name: move_chunk
	Namespace: zm_blockers
	Checksum: 0xDB00979C
	Offset: 0x5370
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function move_chunk(index, b_hide)
{
	self setzbarrierpiecestate(index, "opening");
	while(self getzbarrierpiecestate(index) == "opening")
	{
		wait(0.1);
	}
	self notify(#"movedone");
	if(b_hide)
	{
		self hidezbarrierpiece(index);
	}
}

/*
	Name: debris_move
	Namespace: zm_blockers
	Checksum: 0x92790B72
	Offset: 0x5410
	Size: 0x33C
	Parameters: 1
	Flags: Linked
*/
function debris_move(struct)
{
	self util::script_delay();
	self notsolid();
	self zm_utility::play_sound_on_ent("debris_move");
	if(isdefined(self.script_firefx))
	{
		playfx(level._effect[self.script_firefx], self.origin);
	}
	if(isdefined(self.script_noteworthy))
	{
		if(self.script_noteworthy == "jiggle")
		{
			num = randomintrange(3, 5);
			og_angles = self.angles;
			for(i = 0; i < num; i++)
			{
				angles = og_angles + (-5 + randomfloat(10), -5 + randomfloat(10), -5 + randomfloat(10));
				time = randomfloatrange(0.1, 0.4);
				self rotateto(angles, time);
				wait(time - 0.05);
			}
		}
	}
	time = 0.5;
	if(isdefined(self.script_transition_time))
	{
		time = self.script_transition_time;
	}
	if(isdefined(self.script_vector))
	{
		self moveto(self.origin + self.script_vector, time);
	}
	else
	{
		self moveto(struct.origin, time, time * 0.5);
		self rotateto(struct.angles, time * 0.75);
	}
	self waittill(#"movedone");
	if(isdefined(self.script_fxid))
	{
		playfx(level._effect[self.script_fxid], self.origin);
		playsoundatposition(#"zmb_zombie_spawn", self.origin);
	}
	if(!isdefined(self.objectid) || (self.objectid !== "symbol_front_debris" && self.objectid !== "symbol_back_debris"))
	{
		self delete();
	}
}

/*
	Name: function_23cbcd8
	Namespace: zm_blockers
	Checksum: 0x248AAE80
	Offset: 0x5758
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function function_23cbcd8()
{
	if(isdefined(self.var_b4d014cf) && self.var_b4d014cf)
	{
		return;
	}
	self.var_b4d014cf = 1;
	/#
		assert(isdefined(self.model) || isdefined(self.objectid), "" + self.origin);
	#/
	/#
		assert(isdefined(self.script_vector), "");
	#/
	if(isdefined(self.script_noteworthy))
	{
		a_str_tokens = strtok2(self.script_noteworthy, "_");
		if(isinarray(a_str_tokens, "symbol") && (isinarray(a_str_tokens, "front") || isinarray(a_str_tokens, "back")))
		{
			self.objectid = self.script_noteworthy;
		}
	}
	if(!isdefined(self.objectid))
	{
		if(self.model == "p8_zm_door_buy_symbol_01")
		{
			self.objectid = "symbol_front";
		}
		else if(self.model == "p8_zm_debris_buy_symbol_01")
		{
			self.objectid = "symbol_front_debris";
		}
		else if(self.model == "p8_zm_power_door_symbol_01")
		{
			self.objectid = "symbol_front_power";
		}
		assert(0, "" + self.origin);
	}
	var_9e7c3935 = util::spawn_model("tag_origin", self.origin, self.angles, 0, 1);
	var_9e7c3935.targetname = self.targetname;
	var_9e7c3935.objectid = self.objectid;
	var_9e7c3935.script_string = self.script_string;
	var_9e7c3935.script_vector = self.script_vector;
	var_9e7c3935 thread function_bf35870e();
	self struct::delete();
	return var_9e7c3935;
}

/*
	Name: function_bf35870e
	Namespace: zm_blockers
	Checksum: 0x56F07E6A
	Offset: 0x5A00
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function function_bf35870e()
{
	util::wait_network_frame();
	switch(self.objectid)
	{
		case "symbol_front_power":
		case "symbol_back_power":
		{
			self clientfield::set("power_door_ambient_fx", 1);
			return;
		}
		case "hash_345b9631e96a8ba7":
		case "hash_6de30803b49a37a3":
		{
			self clientfield::set("power_debris_ambient_fx", 1);
			return;
		}
		case "symbol_back_debris":
		case "symbol_front_debris":
		{
			self clientfield::set("debrisbuy_ambient_fx", 1);
			return;
		}
		case "symbol_back":
		case "symbol_front":
		{
			self clientfield::set("doorbuy_ambient_fx", 1);
			return;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_f2f6ce12
	Namespace: zm_blockers
	Checksum: 0x4840D79C
	Offset: 0x5B50
	Size: 0x2C6
	Parameters: 0
	Flags: Linked
*/
function function_f2f6ce12()
{
	var_ba3135be = getentarray(self.target, "targetname");
	foreach(var_6c61edec in var_ba3135be)
	{
		if(isdefined(var_6c61edec.objectid) && !var_6c61edec zm_utility::function_1a4d2910())
		{
			switch(var_6c61edec.objectid)
			{
				case "symbol_front_power":
				case "symbol_back_power":
				{
					var_6c61edec clientfield::set("power_door_ambient_fx", 0);
					var_6c61edec clientfield::set("power_door_bought_fx", 1);
					var_6c61edec thread function_f070c4b8();
					break;
				}
				case "hash_345b9631e96a8ba7":
				case "hash_6de30803b49a37a3":
				{
					var_6c61edec clientfield::set("power_debris_ambient_fx", 0);
					var_6c61edec clientfield::set("power_debris_bought_fx", 1);
					var_6c61edec thread function_f070c4b8();
					break;
				}
				case "symbol_back_debris":
				case "symbol_front_debris":
				{
					var_6c61edec clientfield::set("debrisbuy_ambient_fx", 0);
					var_6c61edec clientfield::set("debrisbuy_bought_fx", 1);
					var_6c61edec thread function_f070c4b8();
					break;
				}
				case "symbol_back":
				case "symbol_front":
				{
					var_6c61edec clientfield::set("doorbuy_ambient_fx", 0);
					var_6c61edec clientfield::set("doorbuy_bought_fx", 1);
					var_6c61edec thread function_f070c4b8();
					break;
				}
				default:
				{
					break;
				}
			}
		}
	}
}

/*
	Name: function_f070c4b8
	Namespace: zm_blockers
	Checksum: 0x5DC4A2B5
	Offset: 0x5E20
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_f070c4b8()
{
	self endon(#"death");
	wait(3);
	self delete();
}

/*
	Name: function_a9bf8f6c
	Namespace: zm_blockers
	Checksum: 0x88EB1009
	Offset: 0x5E60
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_a9bf8f6c(t_door)
{
	while(!isdefined(level.is_forever_solo_game))
	{
		wait(0.1);
	}
	cost = 1000;
	if(isdefined(t_door.zombie_cost))
	{
		if(isdefined(level.is_forever_solo_game) && level.is_forever_solo_game)
		{
			if(t_door.zombie_cost >= 750)
			{
				t_door.zombie_cost = t_door.zombie_cost - 250;
			}
		}
		cost = t_door.zombie_cost;
	}
	return cost;
}

/*
	Name: blocker_disconnect_paths
	Namespace: zm_blockers
	Checksum: 0xA0F53CDC
	Offset: 0x5F28
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function blocker_disconnect_paths(start_node, end_node, two_way)
{
}

/*
	Name: blocker_connect_paths
	Namespace: zm_blockers
	Checksum: 0xCC4DCC81
	Offset: 0x5F50
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function blocker_connect_paths(start_node, end_node, two_way)
{
}

/*
	Name: blocker_init
	Namespace: zm_blockers
	Checksum: 0xEFD56A31
	Offset: 0x5F78
	Size: 0x8C4
	Parameters: 0
	Flags: Linked
*/
function blocker_init()
{
	if(!isdefined(self.target))
	{
		return;
	}
	pos = zm_utility::groundpos(self.origin) + vectorscale((0, 0, 1), 8);
	if(isdefined(pos))
	{
		self.origin = pos;
	}
	targets = getentarray(self.target, "targetname");
	self.barrier_chunks = [];
	for(j = 0; j < targets.size; j++)
	{
		if(targets[j] iszbarrier())
		{
			if(isdefined(level.zbarrier_override))
			{
				self thread [[level.zbarrier_override]](targets[j]);
				continue;
			}
			self.zbarrier = targets[j];
			self.zbarrier.chunk_health = [];
			for(i = 0; i < self.zbarrier getnumzbarrierpieces(); i++)
			{
				self.zbarrier.chunk_health[i] = 0;
			}
			continue;
		}
		if(isdefined(targets[j].script_string) && targets[j].script_string == "rock")
		{
			targets[j].material = "rock";
		}
		if(isdefined(targets[j].script_parameters))
		{
			if(targets[j].script_parameters == "grate")
			{
				if(isdefined(targets[j].script_noteworthy))
				{
					if(targets[j].script_noteworthy == "2" || targets[j].script_noteworthy == "3" || targets[j].script_noteworthy == "4" || targets[j].script_noteworthy == "5" || targets[j].script_noteworthy == "6")
					{
						targets[j] hide();
						/#
							iprintlnbold("");
						#/
					}
				}
			}
			else if(targets[j].script_parameters == "repair_board")
			{
				targets[j].unbroken_section = getent(targets[j].target, "targetname");
				if(isdefined(targets[j].unbroken_section))
				{
					targets[j].unbroken_section linkto(targets[j]);
					targets[j] hide();
					targets[j] notsolid();
					targets[j].unbroken = 1;
					if(isdefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "glass")
					{
						targets[j].material = "glass";
						targets[j] thread destructible_glass_barricade(targets[j].unbroken_section, self);
					}
					else if(isdefined(targets[j].unbroken_section.script_noteworthy) && targets[j].unbroken_section.script_noteworthy == "metal")
					{
						targets[j].material = "metal";
					}
				}
			}
			else if(targets[j].script_parameters == "barricade_vents")
			{
				targets[j].material = "metal_vent";
			}
		}
		if(isdefined(targets[j].targetname))
		{
		}
		targets[j] update_states("repaired");
		targets[j].destroyed = 0;
		targets[j] show();
		targets[j].claimed = 0;
		targets[j].anim_grate_index = 0;
		targets[j].og_origin = targets[j].origin;
		targets[j].og_angles = targets[j].angles;
		self.barrier_chunks[self.barrier_chunks.size] = targets[j];
	}
	target_nodes = getnodearray(self.target, "targetname");
	for(j = 0; j < target_nodes.size; j++)
	{
		if(target_nodes[j].type == #"begin")
		{
			self.neg_start = target_nodes[j];
			if(isdefined(self.neg_start.target))
			{
				self.neg_end = getnode(self.neg_start.target, "targetname");
			}
			blocker_disconnect_paths(self.neg_start, self.neg_end);
		}
	}
	if(isdefined(self.zbarrier))
	{
		if(isdefined(self.barrier_chunks))
		{
			for(i = 0; i < self.barrier_chunks.size; i++)
			{
				self.barrier_chunks[i] delete();
			}
			self.barrier_chunks = [];
		}
	}
	self blocker_attack_spots();
	if(isdefined(self.zbarrier) && should_delete_zbarriers())
	{
		self.zbarrier_origin = self.zbarrier.origin;
		self.var_f4b27846 = self.zbarrier.angles;
		self.zbarrier delete();
		return;
	}
	var_575ce9bb = struct::get_array(self.target);
	foreach(var_8f7aca1c in var_575ce9bb)
	{
		if(var_8f7aca1c.script_noteworthy === "trigger_location")
		{
			self.trigger_location = var_8f7aca1c;
			break;
		}
	}
	self thread blocker_think();
}

/*
	Name: should_delete_zbarriers
	Namespace: zm_blockers
	Checksum: 0xAC5AB7C9
	Offset: 0x6848
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function should_delete_zbarriers()
{
	return getdvarint(#"splitscreen_playercount", 1) > 2;
}

/*
	Name: function_22642075
	Namespace: zm_blockers
	Checksum: 0x22121482
	Offset: 0x6880
	Size: 0x276
	Parameters: 0
	Flags: Linked
*/
function function_22642075()
{
	var_734c61ee = struct::get_array("exterior_goal", "targetname");
	if(isdefined(level._additional_carpenter_nodes))
	{
		var_734c61ee = arraycombine(var_734c61ee, level._additional_carpenter_nodes, 0, 0);
	}
	foreach(s_barrier in var_734c61ee)
	{
		if(isdefined(s_barrier.zbarrier))
		{
			a_pieces = s_barrier.zbarrier getzbarrierpieceindicesinstate("open");
			if(isdefined(a_pieces))
			{
				for(xx = 0; xx < a_pieces.size; xx++)
				{
					chunk = a_pieces[xx];
					s_barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
					s_barrier.zbarrier.chunk_health[chunk] = 0;
				}
			}
			for(x = 0; x < s_barrier.zbarrier getnumzbarrierpieces(); x++)
			{
				s_barrier.zbarrier setzbarrierpiecestate(x, "open");
				s_barrier.zbarrier showzbarrierpiece(x);
			}
		}
		if(isdefined(s_barrier.clip))
		{
			s_barrier.clip triggerenable(1);
			s_barrier.clip disconnectpaths();
		}
		else
		{
			blocker_connect_paths(s_barrier.neg_start, s_barrier.neg_end);
		}
		waitframe(1);
	}
}

/*
	Name: destructible_glass_barricade
	Namespace: zm_blockers
	Checksum: 0xAF369EAD
	Offset: 0x6B00
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function destructible_glass_barricade(unbroken_section, node)
{
	unbroken_section setcandamage(1);
	unbroken_section.health = 99999;
	waitresult = undefined;
	waitresult = unbroken_section waittill(#"damage");
	if(zm_utility::is_player_valid(waitresult.attacker) || waitresult.attacker laststand::player_is_in_laststand())
	{
		self thread zm_spawner::zombie_boardtear_offset_fx_horizontle(self, node);
		level thread remove_chunk(self, node, 1);
		self update_states("destroyed");
		self notify(#"destroyed");
		self.unbroken = 0;
	}
}

/*
	Name: blocker_attack_spots
	Namespace: zm_blockers
	Checksum: 0x1A661027
	Offset: 0x6C30
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function blocker_attack_spots()
{
	spots = [];
	var_575ce9bb = struct::get_array(self.target);
	foreach(var_8f7aca1c in var_575ce9bb)
	{
		if(var_8f7aca1c.script_noteworthy === "attack_spots")
		{
			var_65bfc901 = var_8f7aca1c;
			break;
		}
	}
	numslots = self.zbarrier getzbarriernumattackslots();
	numslots = int(max(numslots, 1));
	if(numslots % 2)
	{
		spots[spots.size] = zm_utility::groundpos_ignore_water_new(var_65bfc901.origin + vectorscale((0, 0, 1), 60));
	}
	if(numslots > 1)
	{
		reps = floor(numslots / 2);
		slot = 1;
		for(i = 0; i < reps; i++)
		{
			offset = self.zbarrier getzbarrierattackslothorzoffset() * i + 1;
			spots[spots.size] = zm_utility::groundpos_ignore_water_new(spots[0] + anglestoright(var_65bfc901.angles) * offset + vectorscale((0, 0, 1), 60));
			slot++;
			if(slot < numslots)
			{
				spots[spots.size] = zm_utility::groundpos_ignore_water_new(spots[0] + anglestoright(var_65bfc901.angles) * offset * -1 + vectorscale((0, 0, 1), 60));
				slot++;
			}
		}
	}
	taken = [];
	for(i = 0; i < spots.size; i++)
	{
		taken[i] = 0;
	}
	self.attack_spots_taken = taken;
	self.attack_spots = spots;
	/#
		self thread zm_utility::debug_attack_spots_taken();
	#/
}

/*
	Name: blocker_choke
	Namespace: zm_blockers
	Checksum: 0x5B49862D
	Offset: 0x6F58
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function blocker_choke()
{
	level._blocker_choke = 0;
	level endon(#"stop_blocker_think");
	while(true)
	{
		waitframe(1);
		level._blocker_choke = 0;
	}
}

/*
	Name: blocker_think
	Namespace: zm_blockers
	Checksum: 0x429E9AF8
	Offset: 0x6FB0
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function blocker_think()
{
	level endon(#"stop_blocker_think");
	if(!isdefined(level._blocker_choke))
	{
		level thread blocker_choke();
	}
	use_choke = 0;
	if(isdefined(level._use_choke_blockers) && level._use_choke_blockers == 1)
	{
		use_choke = 1;
	}
	while(true)
	{
		wait(0.5);
		if(use_choke)
		{
			if(level._blocker_choke > 3)
			{
				waitframe(1);
			}
		}
		level._blocker_choke++;
		if(zm_utility::all_chunks_intact(self, self.barrier_chunks))
		{
			continue;
		}
		if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks))
		{
			continue;
		}
		self blocker_trigger_think();
	}
}

/*
	Name: player_fails_blocker_repair_trigger_preamble
	Namespace: zm_blockers
	Checksum: 0x5B38B382
	Offset: 0x70C8
	Size: 0x15E
	Parameters: 4
	Flags: Linked
*/
function player_fails_blocker_repair_trigger_preamble(player, players, trigger, hold_required)
{
	if(!isdefined(trigger))
	{
		return 1;
	}
	if(!player istouching(trigger, vectorscale((1, 1, 1), 10)))
	{
		return 1;
	}
	if(!zm_utility::is_player_valid(player))
	{
		return 1;
	}
	if(players.size == 1 && isdefined(players[0].intermission) && players[0].intermission == 1)
	{
		return 1;
	}
	if(hold_required && !player usebuttonpressed())
	{
		return 1;
	}
	if(!hold_required && !player util::use_button_held())
	{
		return 1;
	}
	if(player zm_utility::in_revive_trigger())
	{
		return 1;
	}
	if(player zm_utility::is_drinking())
	{
		return 1;
	}
	return 0;
}

/*
	Name: has_blocker_affecting_perk
	Namespace: zm_blockers
	Checksum: 0x33EE1ED6
	Offset: 0x7230
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function has_blocker_affecting_perk()
{
	has_perk = undefined;
	if(isdefined(self) && self hasperk(#"specialty_fastreload"))
	{
		has_perk = #"specialty_fastreload";
	}
	return has_perk;
}

/*
	Name: do_post_chunk_repair_delay
	Namespace: zm_blockers
	Checksum: 0xE1792B9E
	Offset: 0x7290
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function do_post_chunk_repair_delay(has_perk)
{
	if(!self util::script_delay())
	{
		wait(1);
	}
}

/*
	Name: handle_post_board_repair_rewards
	Namespace: zm_blockers
	Checksum: 0x125528E0
	Offset: 0x72C8
	Size: 0x18E
	Parameters: 2
	Flags: Linked
*/
function handle_post_board_repair_rewards(cost, zbarrier)
{
	self zm_stats::increment_client_stat("boards");
	self zm_stats::increment_player_stat("boards");
	self zm_stats::function_8f10788e("boas_boards");
	self thread zm_audio::create_and_play_dialog(#"general", #"rebuild_boards");
	if(!isdefined(self.rebuild_barrier_reward))
	{
		self.rebuild_barrier_reward = 0;
	}
	self.rebuild_barrier_reward = self.rebuild_barrier_reward + cost;
	if(self.rebuild_barrier_reward <= zombie_utility::function_d2dfacfd(#"rebuild_barrier_cap_per_round"))
	{
		if(isdefined(self.var_7e008e0c) && self.var_7e008e0c > 0)
		{
			cost = cost * self.var_7e008e0c;
		}
		self zm_score::player_add_points("rebuild_board", cost);
		self zm_utility::play_sound_on_ent("purchase");
	}
	if(isdefined(self.board_repair))
	{
		self.board_repair = self.board_repair + 1;
	}
}

/*
	Name: blocker_unitrigger_think
	Namespace: zm_blockers
	Checksum: 0xA6B698C
	Offset: 0x7460
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function blocker_unitrigger_think()
{
	self endon(#"kill_trigger");
	while(true)
	{
		self.stub.trigger_target notify(#"trigger", self waittill(#"trigger"));
	}
}

/*
	Name: blocker_trigger_think
	Namespace: zm_blockers
	Checksum: 0x207B1117
	Offset: 0x74C0
	Size: 0xAEE
	Parameters: 0
	Flags: Linked
*/
function blocker_trigger_think()
{
	self endon(#"blocker_hacked");
	if(isdefined(level.no_board_repair) && level.no_board_repair)
	{
		return;
	}
	/#
		println("");
	#/
	level endon(#"stop_blocker_think");
	cost = 10;
	if(isdefined(self.zombie_cost))
	{
		cost = self.zombie_cost;
	}
	original_cost = cost;
	if(!isdefined(self.unitrigger_stub))
	{
		radius = 94.21;
		height = 94.21;
		if(isdefined(self.trigger_location))
		{
			trigger_location = self.trigger_location;
		}
		else
		{
			trigger_location = self;
		}
		if(isdefined(trigger_location.radius))
		{
			radius = trigger_location.radius;
		}
		if(isdefined(trigger_location.height))
		{
			height = trigger_location.height;
		}
		trigger_pos = zm_utility::groundpos(trigger_location.origin) + vectorscale((0, 0, 1), 4);
		self.unitrigger_stub = spawnstruct();
		self.unitrigger_stub.origin = trigger_pos;
		self.unitrigger_stub.radius = radius;
		self.unitrigger_stub.height = height;
		self.unitrigger_stub.script_unitrigger_type = "unitrigger_radius";
		self.unitrigger_stub.hint_string = zm_utility::get_hint_string(self, "default_reward_barrier_piece");
		self.unitrigger_stub.cursor_hint = "HINT_NOICON";
		self.unitrigger_stub.trigger_target = self;
		zm_unitrigger::unitrigger_force_per_player_triggers(self.unitrigger_stub, 1);
		self.unitrigger_stub.prompt_and_visibility_func = &blockertrigger_update_prompt;
		zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &blocker_unitrigger_think);
		zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
		if(!isdefined(trigger_location.angles))
		{
			trigger_location.angles = (0, 0, 0);
		}
		self.unitrigger_stub.origin = zm_utility::groundpos(trigger_location.origin) + vectorscale((0, 0, 1), 4) + anglestoforward(trigger_location.angles) * -11;
	}
	self thread trigger_delete_on_repair();
	thread zm_unitrigger::register_static_unitrigger(self.unitrigger_stub, &blocker_unitrigger_think);
	/#
		if(getdvarint(#"zombie_debug", 0) > 0)
		{
			thread zm_utility::debug_blocker(trigger_pos, radius, height);
		}
	#/
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		player = waitresult.activator;
		if(isdefined(level.var_aef7f7d5) && level.var_aef7f7d5)
		{
			if(isdefined(self.unitrigger_stub) && !isdefined(self.unitrigger_stub.var_88312f4))
			{
				self.unitrigger_stub.var_88312f4 = self.unitrigger_stub.hint_string;
				self.unitrigger_stub.hint_string = (isdefined(level.var_b0612462) ? level.var_b0612462 : #"");
			}
			continue;
		}
		else if(isdefined(self.unitrigger_stub) && isdefined(self.unitrigger_stub.var_88312f4))
		{
			self.unitrigger_stub.hint_string = self.unitrigger_stub.var_88312f4;
			self.unitrigger_stub.var_88312f4 = undefined;
		}
		has_perk = player has_blocker_affecting_perk();
		if(zm_utility::all_chunks_intact(self, self.barrier_chunks))
		{
			self notify(#"all_boards_repaired");
			return;
		}
		if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks))
		{
			self notify(#"hash_3562759a2cd48f89");
			return;
		}
		if(isdefined(level._zm_blocker_trigger_think_return_override))
		{
			if(self [[level._zm_blocker_trigger_think_return_override]](player))
			{
				return;
			}
		}
		while(true)
		{
			players = getplayers();
			trigger = self.unitrigger_stub zm_unitrigger::unitrigger_trigger(player);
			if(player_fails_blocker_repair_trigger_preamble(player, players, trigger, 0))
			{
				break;
			}
			player notify(#"boarding_window", self);
			if(isdefined(self.zbarrier))
			{
				chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
				self thread replace_chunk(self, chunk, has_perk);
			}
			else
			{
				chunk = zm_utility::get_random_destroyed_chunk(self, self.barrier_chunks);
				if(isdefined(chunk.script_parameter) && chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
				{
					if(isdefined(chunk.unbroken_section))
					{
						chunk show();
						chunk solid();
						chunk.unbroken_section zm_utility::self_delete();
					}
				}
				else
				{
					chunk show();
				}
				if(!isdefined(chunk.script_parameters) || chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
				{
					if(!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
					{
						if(!isdefined(chunk.material) || (isdefined(chunk.material) && chunk.material != "rock"))
						{
							chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
						}
						playsoundatposition(#"zmb_cha_ching", (0, 0, 0));
					}
				}
				if(chunk.script_parameters == "bar")
				{
					chunk zm_utility::play_sound_on_ent("rebuild_barrier_piece");
					playsoundatposition(#"zmb_cha_ching", (0, 0, 0));
				}
				if(isdefined(chunk.script_parameters))
				{
					if(chunk.script_parameters == "bar")
					{
						if(isdefined(chunk.script_noteworthy))
						{
							if(chunk.script_noteworthy == "5")
							{
								chunk hide();
							}
							else if(chunk.script_noteworthy == "3")
							{
								chunk hide();
							}
						}
					}
				}
				self thread replace_chunk(self, chunk, has_perk);
			}
			if(isdefined(self.clip))
			{
				self.clip triggerenable(1);
				self.clip disconnectpaths();
			}
			else
			{
				blocker_disconnect_paths(self.neg_start, self.neg_end);
			}
			self do_post_chunk_repair_delay(has_perk);
			if(!zm_utility::is_player_valid(player))
			{
				break;
			}
			player handle_post_board_repair_rewards(cost, self);
			level notify(#"hash_747f63d86cb99870", {#s_board:self, #player:player});
			if(zm_utility::all_chunks_intact(self, self.barrier_chunks))
			{
				self notify(#"all_boards_repaired");
				player increment_window_repaired();
				return;
			}
			if(zm_utility::no_valid_repairable_boards(self, self.barrier_chunks))
			{
				self notify(#"hash_3562759a2cd48f89");
				player increment_window_repaired(self);
				return;
			}
		}
	}
}

/*
	Name: increment_window_repaired
	Namespace: zm_blockers
	Checksum: 0x13AFB701
	Offset: 0x7FB8
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function increment_window_repaired(s_barrier)
{
	self zm_stats::increment_challenge_stat(#"survivalist_board");
	self zm_stats::function_8f10788e("boas_windowsBoarded");
	self incrementplayerstat("windowsBoarded", 1);
	self thread zm_daily_challenges::increment_windows_repaired(s_barrier);
}

/*
	Name: blockertrigger_update_prompt
	Namespace: zm_blockers
	Checksum: 0x893F65EB
	Offset: 0x8048
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function blockertrigger_update_prompt(player)
{
	can_use = self.stub blockerstub_update_prompt(player);
	self setinvisibletoplayer(player, !can_use);
	self sethintstring(self.stub.hint_string);
	return can_use;
}

/*
	Name: blockerstub_update_prompt
	Namespace: zm_blockers
	Checksum: 0xB0D7D3FB
	Offset: 0x80C8
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function blockerstub_update_prompt(player)
{
	if(!zm_utility::is_player_valid(player))
	{
		return 0;
	}
	if(player zm_utility::in_revive_trigger())
	{
		return 0;
	}
	if(player zm_utility::is_drinking())
	{
		return 0;
	}
	return 1;
}

/*
	Name: random_destroyed_chunk_show
	Namespace: zm_blockers
	Checksum: 0xE19CB733
	Offset: 0x8130
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function random_destroyed_chunk_show()
{
	wait(0.5);
	self show();
}

/*
	Name: door_repaired_rumble_n_sound
	Namespace: zm_blockers
	Checksum: 0xF1329621
	Offset: 0x8160
	Size: 0xAE
	Parameters: 0
	Flags: None
*/
function door_repaired_rumble_n_sound()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(distance(players[i].origin, self.origin) < 150)
		{
			if(isalive(players[i]))
			{
				players[i] thread board_completion();
			}
		}
	}
}

/*
	Name: board_completion
	Namespace: zm_blockers
	Checksum: 0xF40A3C9A
	Offset: 0x8218
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function board_completion()
{
	self endon(#"disconnect");
}

/*
	Name: trigger_delete_on_repair
	Namespace: zm_blockers
	Checksum: 0x1C4343F1
	Offset: 0x8238
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function trigger_delete_on_repair()
{
	while(true)
	{
		self util::waittill_either("all_boards_repaired", "no valid boards");
		zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
		break;
	}
}

/*
	Name: rebuild_barrier_reward_reset
	Namespace: zm_blockers
	Checksum: 0x79BEEA26
	Offset: 0x8298
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function rebuild_barrier_reward_reset()
{
	self.rebuild_barrier_reward = 0;
}

/*
	Name: remove_chunk
	Namespace: zm_blockers
	Checksum: 0x6379EB8
	Offset: 0x82B0
	Size: 0xDE0
	Parameters: 4
	Flags: Linked
*/
function remove_chunk(chunk, node, destroy_immediately, zomb)
{
	chunk update_states("mid_tear");
	if(isdefined(chunk.script_parameters))
	{
		if(chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
		{
			chunk thread zombie_boardtear_audio_offset(chunk);
		}
	}
	if(isdefined(chunk.script_parameters))
	{
		if(chunk.script_parameters == "bar")
		{
			chunk thread zombie_bartear_audio_offset(chunk);
		}
	}
	chunk notsolid();
	fx = "wood_chunk_destory";
	if(isdefined(self.script_fxid))
	{
		fx = self.script_fxid;
	}
	if(isdefined(chunk.script_moveoverride) && chunk.script_moveoverride)
	{
		chunk hide();
	}
	if(isdefined(chunk.script_parameters) && chunk.script_parameters == "bar")
	{
		if(isdefined(chunk.script_noteworthy) && chunk.script_noteworthy == "4")
		{
			ent = spawn("script_origin", chunk.origin);
			ent.angles = node.angles + vectorscale((0, 1, 0), 180);
			dist = 100;
			if(isdefined(chunk.script_move_dist))
			{
				dist_max = chunk.script_move_dist - 100;
				dist = 100 + randomint(dist_max);
			}
			else
			{
				dist = 100 + randomint(100);
			}
			dest = ent.origin + anglestoforward(ent.angles) * dist;
			trace = bullettrace(dest + vectorscale((0, 0, 1), 16), dest + vectorscale((0, 0, -1), 200), 0, undefined);
			if(trace[#"fraction"] == 1)
			{
				dest = dest + vectorscale((0, 0, -1), 200);
			}
			else
			{
				dest = trace[#"position"];
			}
			chunk linkto(ent);
			time = ent zm_utility::fake_physicslaunch(dest, 300 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180, time * 0.5);
			}
			else
			{
				ent rotatepitch(90, time, time * 0.5);
			}
			wait(time);
			chunk hide();
			wait(0.1);
			ent delete();
		}
		else
		{
			ent = spawn("script_origin", chunk.origin);
			ent.angles = node.angles + vectorscale((0, 1, 0), 180);
			dist = 100;
			if(isdefined(chunk.script_move_dist))
			{
				dist_max = chunk.script_move_dist - 100;
				dist = 100 + randomint(dist_max);
			}
			else
			{
				dist = 100 + randomint(100);
			}
			dest = ent.origin + anglestoforward(ent.angles) * dist;
			trace = bullettrace(dest + vectorscale((0, 0, 1), 16), dest + vectorscale((0, 0, -1), 200), 0, undefined);
			if(trace[#"fraction"] == 1)
			{
				dest = dest + vectorscale((0, 0, -1), 200);
			}
			else
			{
				dest = trace[#"position"];
			}
			chunk linkto(ent);
			time = ent zm_utility::fake_physicslaunch(dest, 260 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180, time * 0.5);
			}
			else
			{
				ent rotatepitch(90, time, time * 0.5);
			}
			wait(time);
			chunk hide();
			wait(0.1);
			ent delete();
		}
		chunk update_states("destroyed");
		chunk notify(#"destroyed");
	}
	if(isdefined(chunk.script_parameters) && chunk.script_parameters == "board" || chunk.script_parameters == "repair_board" || chunk.script_parameters == "barricade_vents")
	{
		ent = spawn("script_origin", chunk.origin);
		ent.angles = node.angles + vectorscale((0, 1, 0), 180);
		dist = 100;
		if(isdefined(chunk.script_move_dist))
		{
			dist_max = chunk.script_move_dist - 100;
			dist = 100 + randomint(dist_max);
		}
		else
		{
			dist = 100 + randomint(100);
		}
		dest = ent.origin + anglestoforward(ent.angles) * dist;
		trace = bullettrace(dest + vectorscale((0, 0, 1), 16), dest + vectorscale((0, 0, -1), 200), 0, undefined);
		if(trace[#"fraction"] == 1)
		{
			dest = dest + vectorscale((0, 0, -1), 200);
		}
		else
		{
			dest = trace[#"position"];
		}
		chunk linkto(ent);
		time = ent zm_utility::fake_physicslaunch(dest, 200 + randomint(100));
		if(isdefined(chunk.unbroken_section))
		{
			if(!isdefined(chunk.material) || chunk.material != "metal")
			{
				chunk.unbroken_section zm_utility::self_delete();
			}
		}
		if(randomint(100) > 40)
		{
			ent rotatepitch(180, time * 0.5);
		}
		else
		{
			ent rotatepitch(90, time, time * 0.5);
		}
		wait(time);
		if(isdefined(chunk.unbroken_section))
		{
			if(isdefined(chunk.material) && chunk.material == "metal")
			{
				chunk.unbroken_section zm_utility::self_delete();
			}
		}
		chunk hide();
		wait(0.1);
		ent delete();
		chunk update_states("destroyed");
		chunk notify(#"destroyed");
	}
	if(isdefined(chunk.script_parameters) && chunk.script_parameters == "grate")
	{
		if(isdefined(chunk.script_noteworthy) && chunk.script_noteworthy == "6")
		{
			ent = spawn("script_origin", chunk.origin);
			ent.angles = node.angles + vectorscale((0, 1, 0), 180);
			dist = 100 + randomint(100);
			dest = ent.origin + anglestoforward(ent.angles) * dist;
			trace = bullettrace(dest + vectorscale((0, 0, 1), 16), dest + vectorscale((0, 0, -1), 200), 0, undefined);
			if(trace[#"fraction"] == 1)
			{
				dest = dest + vectorscale((0, 0, -1), 200);
			}
			else
			{
				dest = trace[#"position"];
			}
			chunk linkto(ent);
			time = ent zm_utility::fake_physicslaunch(dest, 200 + randomint(100));
			if(randomint(100) > 40)
			{
				ent rotatepitch(180, time * 0.5);
			}
			else
			{
				ent rotatepitch(90, time, time * 0.5);
			}
			wait(time);
			chunk hide();
			ent delete();
			chunk update_states("destroyed");
			chunk notify(#"destroyed");
		}
		else
		{
			chunk hide();
			chunk update_states("destroyed");
			chunk notify(#"destroyed");
		}
	}
}

/*
	Name: remove_chunk_rotate_grate
	Namespace: zm_blockers
	Checksum: 0x7B3EDDF3
	Offset: 0x9098
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function remove_chunk_rotate_grate(chunk)
{
	if(isdefined(chunk.script_parameters) && chunk.script_parameters == "grate")
	{
		chunk vibrate(vectorscale((0, 1, 0), 270), 0.2, 0.4, 0.4);
		return;
	}
}

/*
	Name: zombie_boardtear_audio_offset
	Namespace: zm_blockers
	Checksum: 0x7106A80F
	Offset: 0x9118
	Size: 0x36A
	Parameters: 1
	Flags: Linked
*/
function zombie_boardtear_audio_offset(chunk)
{
	if(isdefined(chunk.material) && !isdefined(chunk.already_broken))
	{
		chunk.already_broken = 0;
	}
	if(isdefined(chunk.material) && chunk.material == "glass" && chunk.already_broken == 0)
	{
		chunk playsound(#"zmb_break_glass_barrier");
		wait(randomfloatrange(0.3, 0.6));
		chunk playsound(#"zmb_break_glass_barrier");
		chunk.already_broken = 1;
	}
	else if(isdefined(chunk.material) && chunk.material == "metal" && chunk.already_broken == 0)
	{
		chunk playsound(#"grab_metal_bar");
		wait(randomfloatrange(0.3, 0.6));
		chunk playsound(#"break_metal_bar");
		chunk.already_broken = 1;
	}
	else if(isdefined(chunk.material) && chunk.material == "rock")
	{
		if(!(isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx))
		{
			chunk playsound(#"zmb_break_rock_barrier");
			wait(randomfloatrange(0.3, 0.6));
			chunk playsound(#"zmb_break_rock_barrier");
		}
		chunk.already_broken = 1;
	}
	else if(isdefined(chunk.material) && chunk.material == "metal_vent")
	{
		if(!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
		{
			chunk playsound(#"evt_vent_slat_remove");
		}
	}
	else if(!(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx))
	{
		chunk zm_utility::play_sound_on_ent("break_barrier_piece");
		wait(randomfloatrange(0.3, 0.6));
		chunk zm_utility::play_sound_on_ent("break_barrier_piece");
	}
	chunk.already_broken = 1;
}

/*
	Name: zombie_bartear_audio_offset
	Namespace: zm_blockers
	Checksum: 0x3AA9D4DF
	Offset: 0x9490
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function zombie_bartear_audio_offset(chunk)
{
	chunk zm_utility::play_sound_on_ent("grab_metal_bar");
	wait(randomfloatrange(0.3, 0.6));
	chunk zm_utility::play_sound_on_ent("break_metal_bar");
	wait(randomfloatrange(1, 1.3));
	chunk zm_utility::play_sound_on_ent("drop_metal_bar");
}

/*
	Name: ensure_chunk_is_back_to_origin
	Namespace: zm_blockers
	Checksum: 0xBF3D7304
	Offset: 0x9548
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function ensure_chunk_is_back_to_origin(chunk)
{
	if(chunk.origin != chunk.og_origin)
	{
		chunk notsolid();
		chunk waittill(#"movedone");
	}
}

/*
	Name: replace_chunk
	Namespace: zm_blockers
	Checksum: 0x95BCB26F
	Offset: 0x95A8
	Size: 0x1F4
	Parameters: 4
	Flags: Linked
*/
function replace_chunk(barrier, chunk, has_perk, via_powerup)
{
	if(!isdefined(barrier.zbarrier))
	{
		chunk update_states("mid_repair");
		/#
			assert(isdefined(chunk.og_origin));
		#/
		/#
			assert(isdefined(chunk.og_angles));
		#/
		sound = "rebuild_barrier_hover";
		if(isdefined(chunk.script_presound))
		{
			sound = chunk.script_presound;
		}
	}
	if(!isdefined(via_powerup) && isdefined(sound))
	{
		zm_utility::play_sound_at_pos(sound, chunk.origin);
	}
	barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
	barrier.zbarrier.chunk_health[chunk] = 0;
	scalar = 1;
	if(has_perk === #"specialty_fastreload")
	{
		scalar = 0.31;
	}
	barrier.zbarrier showzbarrierpiece(chunk);
	barrier.zbarrier setzbarrierpiecestate(chunk, "closing", scalar);
	waitduration = barrier.zbarrier getzbarrierpieceanimlengthforstate(chunk, "closing", scalar);
	wait(waitduration);
}

/*
	Name: function_b193ea5c
	Namespace: zm_blockers
	Checksum: 0x214329D3
	Offset: 0x97A8
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_b193ea5c(barrier, var_56646e12 = 0)
{
	if(isdefined(barrier.zbarrier))
	{
		for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
		{
			if(barrier.zbarrier getzbarrierpiecestate(x) == "closed" || barrier.zbarrier getzbarrierpiecestate(x) == "closing")
			{
				if(var_56646e12)
				{
					barrier.zbarrier setzbarrierpiecestate(x, "open");
					continue;
				}
				barrier.zbarrier setzbarrierpiecestate(x, "opening");
			}
		}
	}
	if(isdefined(barrier.clip))
	{
		barrier.clip triggerenable(0);
		barrier.clip connectpaths();
	}
	else
	{
		blocker_connect_paths(barrier.neg_start, barrier.neg_end);
	}
}

/*
	Name: open_all_zbarriers
	Namespace: zm_blockers
	Checksum: 0x9D3A16A9
	Offset: 0x9948
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function open_all_zbarriers()
{
	foreach(barrier in level.exterior_goals)
	{
		function_b193ea5c(barrier);
	}
}

/*
	Name: function_6f01c3cf
	Namespace: zm_blockers
	Checksum: 0xFEA5E35B
	Offset: 0x99D0
	Size: 0x35E
	Parameters: 3
	Flags: Linked
*/
function function_6f01c3cf(str_value, str_key, var_e9e6d25a = 0)
{
	var_734c61ee = [];
	foreach(s_barrier in level.exterior_goals)
	{
		if(s_barrier.(str_key) === str_value && s_barrier.targetname === "exterior_goal")
		{
			if(!isdefined(var_734c61ee))
			{
				var_734c61ee = [];
			}
			else if(!isarray(var_734c61ee))
			{
				var_734c61ee = array(var_734c61ee);
			}
			var_734c61ee[var_734c61ee.size] = s_barrier;
		}
	}
	for(i = 0; i < var_734c61ee.size; i++)
	{
		barrier = var_734c61ee[i];
		if(isdefined(barrier.zbarrier))
		{
			a_pieces = barrier.zbarrier getzbarrierpieceindicesinstate("closed");
			if(isdefined(a_pieces))
			{
				for(xx = 0; xx < a_pieces.size; xx++)
				{
					chunk = a_pieces[xx];
					barrier.zbarrier zbarrierpieceusedefaultmodel(chunk);
					barrier.zbarrier.chunk_health[chunk] = 0;
				}
			}
			for(x = 0; x < barrier.zbarrier getnumzbarrierpieces(); x++)
			{
				barrier.zbarrier setzbarrierpiecestate(x, "open");
				if(var_e9e6d25a)
				{
					barrier.zbarrier hidezbarrierpiece(x);
					continue;
				}
				barrier.zbarrier showzbarrierpiece(x);
			}
		}
		if(isdefined(barrier.clip))
		{
			barrier.clip triggerenable(0);
			barrier.clip connectpaths();
		}
		else
		{
			blocker_connect_paths(barrier.neg_start, barrier.neg_end);
		}
		if(i % 4 == 0)
		{
			util::wait_network_frame();
		}
	}
}

/*
	Name: zombie_boardtear_audio_plus_fx_offset_repair_horizontal
	Namespace: zm_blockers
	Checksum: 0x15BAA9D6
	Offset: 0x9D38
	Size: 0x204
	Parameters: 1
	Flags: None
*/
function zombie_boardtear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	if(isdefined(chunk.material) && chunk.material == "rock")
	{
		if(isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk clientfield::set("tearin_rock_fx", 0);
		}
		else
		{
			earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
			wait(randomfloatrange(0.3, 0.6));
			chunk zm_utility::play_sound_on_ent("break_barrier_piece");
		}
	}
	else if(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		chunk clientfield::set("tearin_board_vertical_fx", 0);
	}
	else
	{
		earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
		wait(randomfloatrange(0.3, 0.6));
		chunk zm_utility::play_sound_on_ent("break_barrier_piece");
	}
}

/*
	Name: zombie_boardtear_audio_plus_fx_offset_repair_verticle
	Namespace: zm_blockers
	Checksum: 0xC9E10666
	Offset: 0x9F48
	Size: 0x204
	Parameters: 1
	Flags: None
*/
function zombie_boardtear_audio_plus_fx_offset_repair_verticle(chunk)
{
	if(isdefined(chunk.material) && chunk.material == "rock")
	{
		if(isdefined(level.use_clientside_rock_tearin_fx) && level.use_clientside_rock_tearin_fx)
		{
			chunk clientfield::set("tearin_rock_fx", 0);
		}
		else
		{
			earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
			wait(randomfloatrange(0.3, 0.6));
			chunk zm_utility::play_sound_on_ent("break_barrier_piece");
		}
	}
	else if(isdefined(level.use_clientside_board_fx) && level.use_clientside_board_fx)
	{
		chunk clientfield::set("tearin_board_horizontal_fx", 0);
	}
	else
	{
		earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
		wait(randomfloatrange(0.3, 0.6));
		chunk zm_utility::play_sound_on_ent("break_barrier_piece");
	}
}

/*
	Name: zombie_gratetear_audio_plus_fx_offset_repair_horizontal
	Namespace: zm_blockers
	Checksum: 0x103ECAA2
	Offset: 0xA158
	Size: 0x5AA
	Parameters: 1
	Flags: None
*/
function zombie_gratetear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
	chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case 0:
		{
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			wait(randomfloatrange(0, 0.3));
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 1:
		{
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			wait(randomfloatrange(0, 0.3));
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 2:
		{
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			wait(randomfloatrange(0, 0.3));
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 3:
		{
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			wait(randomfloatrange(0, 0.3));
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 4:
		{
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			wait(randomfloatrange(0, 0.3));
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 5:
		{
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 6:
		{
			playfx(level._effect[#"fx_zombie_bar_break_lite"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 7:
		{
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
		case 8:
		{
			playfx(level._effect[#"fx_zombie_bar_break"], chunk.origin + vectorscale((-1, 0, 0), 30));
			break;
		}
	}
}

/*
	Name: zombie_bartear_audio_plus_fx_offset_repair_horizontal
	Namespace: zm_blockers
	Checksum: 0x7DF6909B
	Offset: 0xA710
	Size: 0x4F2
	Parameters: 1
	Flags: None
*/
function zombie_bartear_audio_plus_fx_offset_repair_horizontal(chunk)
{
	earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
	chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case 0:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
			break;
		}
		case 1:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
			break;
		}
		case 2:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
			break;
		}
		case 3:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
			break;
		}
		case 4:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
			break;
		}
		case 5:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_left");
			break;
		}
		case 6:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_right");
			break;
		}
		case 7:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_left");
			break;
		}
		case 8:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_right");
			break;
		}
	}
}

/*
	Name: zombie_bartear_audio_plus_fx_offset_repair_verticle
	Namespace: zm_blockers
	Checksum: 0x30C7C91E
	Offset: 0xAC10
	Size: 0x4F2
	Parameters: 1
	Flags: None
*/
function zombie_bartear_audio_plus_fx_offset_repair_verticle(chunk)
{
	earthquake(randomfloatrange(0.3, 0.4), randomfloatrange(0.2, 0.4), chunk.origin, 150);
	chunk zm_utility::play_sound_on_ent("bar_rebuild_slam");
	switch(randomint(9))
	{
		case 0:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
			break;
		}
		case 1:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
			break;
		}
		case 2:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
			break;
		}
		case 3:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
			break;
		}
		case 4:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
			wait(randomfloatrange(0, 0.3));
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
			break;
		}
		case 5:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_top");
			break;
		}
		case 6:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break_lite"], chunk, "Tag_fx_bottom");
			break;
		}
		case 7:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_top");
			break;
		}
		case 8:
		{
			playfxontag(level._effect[#"fx_zombie_bar_break"], chunk, "Tag_fx_bottom");
			break;
		}
	}
}

/*
	Name: flag_blocker
	Namespace: zm_blockers
	Checksum: 0x6EF274CA
	Offset: 0xB110
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function flag_blocker()
{
	if(!isdefined(self.script_flag_wait))
	{
		/#
			assertmsg("" + self.origin + "");
		#/
		return;
	}
	if(!isdefined(level.flag[self.script_flag_wait]))
	{
		level flag::init(self.script_flag_wait);
	}
	type = "connectpaths";
	if(isdefined(self.script_noteworthy))
	{
		type = self.script_noteworthy;
	}
	level flag::wait_till(self.script_flag_wait);
	self util::script_delay();
	if(type == "connectpaths")
	{
		self connectpaths();
		self triggerenable(0);
		return;
	}
	if(type == "disconnectpaths")
	{
		self disconnectpaths();
		self triggerenable(0);
		return;
	}
	/#
		assertmsg("" + self.origin + "" + type + "");
	#/
}

/*
	Name: update_states
	Namespace: zm_blockers
	Checksum: 0x736EC39
	Offset: 0xB2B8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function update_states(states)
{
	/#
		assert(isdefined(states));
	#/
	self.state = states;
}

/*
	Name: quantum_bomb_open_nearest_door_validation
	Namespace: zm_blockers
	Checksum: 0x52E40247
	Offset: 0xB2F8
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function quantum_bomb_open_nearest_door_validation(position)
{
	range_squared = 32400;
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(distancesquared(zombie_doors[i].origin, position) < range_squared)
		{
			return 1;
		}
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		if(distancesquared(zombie_airlock_doors[i].origin, position) < range_squared)
		{
			return 1;
		}
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(distancesquared(zombie_debris[i].origin, position) < range_squared)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: quantum_bomb_open_nearest_door_result
	Namespace: zm_blockers
	Checksum: 0x6C15DAB4
	Offset: 0xB490
	Size: 0x21C
	Parameters: 1
	Flags: Linked
*/
function quantum_bomb_open_nearest_door_result(position)
{
	range_squared = 32400;
	zombie_doors = getentarray("zombie_door", "targetname");
	for(i = 0; i < zombie_doors.size; i++)
	{
		if(distancesquared(zombie_doors[i].origin, position) < range_squared)
		{
			zombie_doors[i] force_open_door(self);
			[[level.quantum_bomb_play_area_effect_func]](position);
			return;
		}
	}
	zombie_airlock_doors = getentarray("zombie_airlock_buy", "targetname");
	for(i = 0; i < zombie_airlock_doors.size; i++)
	{
		if(distancesquared(zombie_airlock_doors[i].origin, position) < range_squared)
		{
			zombie_airlock_doors[i] force_open_door(self);
			[[level.quantum_bomb_play_area_effect_func]](position);
			return;
		}
	}
	zombie_debris = getentarray("zombie_debris", "targetname");
	for(i = 0; i < zombie_debris.size; i++)
	{
		if(distancesquared(zombie_debris[i].origin, position) < range_squared)
		{
			zombie_debris[i] force_open_door(self);
			[[level.quantum_bomb_play_area_effect_func]](position);
			return;
		}
	}
}

/*
	Name: function_dafd2e5a
	Namespace: zm_blockers
	Checksum: 0x541AA7C9
	Offset: 0xB6B8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_dafd2e5a()
{
	level flagsys::wait_till("start_zombie_round_logic");
	if(isdefined(level.var_ddcd74c6))
	{
		thread [[level.var_ddcd74c6]](self);
	}
	else if(isdefined(level.var_d5bd7049))
	{
		self sethintstring(level.var_d5bd7049);
	}
	else
	{
		self sethintstring(#"hash_71158766520dc432");
	}
}

