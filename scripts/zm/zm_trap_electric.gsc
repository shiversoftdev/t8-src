// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5660bae5b402a1eb;
#using script_57f7003580bb15e0;
#using script_ab890501c40b73c;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;

#namespace zm_trap_electric;

/*
	Name: function_89f2df9
	Namespace: zm_trap_electric
	Checksum: 0x953042D3
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_trap_electric", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trap_electric
	Checksum: 0xC920CDD
	Offset: 0x1C0
	Size: 0x180
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_traps::register_trap_basic_info("electric", &trap_activate_electric, &trap_audio);
	zm_traps::register_trap_damage("electric", &player_damage, &damage);
	if(!isdefined(level.vsmgr_prio_overlay_zm_trap_electrified))
	{
		level.vsmgr_prio_overlay_zm_trap_electrified = 60;
	}
	clientfield::register("actor", "electrocute_ai_fx", 1, 1, "int");
	a_traps = struct::get_array("trap_electric", "targetname");
	foreach(trap in a_traps)
	{
		clientfield::register("world", trap.script_noteworthy, 1, 1, "int");
	}
}

/*
	Name: trap_activate_electric
	Namespace: zm_trap_electric
	Checksum: 0x539E5A6B
	Offset: 0x348
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function trap_activate_electric()
{
	self._trap_duration = 40;
	self._trap_cooldown_time = 60;
	if(isdefined(level.sndtrapfunc))
	{
		level thread [[level.sndtrapfunc]](self, 1);
	}
	self notify(#"trap_activate");
	level notify(#"trap_activate", self);
	level clientfield::set(self.target, 1);
	fx_points = struct::get_array(self.target, "targetname");
	for(i = 0; i < fx_points.size; i++)
	{
		util::wait_network_frame();
		fx_points[i] thread trap_audio(self);
	}
	self thread zm_traps::trap_damage();
	self waittill_timeout(self._trap_duration, #"trap_deactivate");
	self notify(#"trap_done");
	level clientfield::set(self.target, 0);
}

/*
	Name: trap_audio
	Namespace: zm_trap_electric
	Checksum: 0xB4E515BA
	Offset: 0x4D8
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function trap_audio(trap)
{
	sound_origin = spawn("script_origin", self.origin);
	sound_origin playsound(#"hash_1fb395621513432f");
	sound_origin playloopsound(#"hash_177d7a6df8ed0d7b");
	self thread play_electrical_sound(trap);
	trap waittill_timeout(trap._trap_duration, #"trap_done");
	if(isdefined(sound_origin))
	{
		playsoundatposition(#"hash_3819c6cd06a27f15", sound_origin.origin);
		sound_origin stoploopsound();
		waitframe(1);
		sound_origin delete();
	}
}

/*
	Name: play_electrical_sound
	Namespace: zm_trap_electric
	Checksum: 0xB7591BA1
	Offset: 0x5F8
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function play_electrical_sound(trap)
{
	trap endon(#"trap_done");
	while(true)
	{
		wait(randomfloatrange(0.1, 0.5));
		playsoundatposition(#"hash_6b9160d5f97e5ecb", self.origin);
	}
}

/*
	Name: player_damage
	Namespace: zm_trap_electric
	Checksum: 0x3C953B78
	Offset: 0x678
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function player_damage(trigger)
{
	var_5b857980 = function_4d1e7b48(#"hash_19533caf858a9f3b");
	if(!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage))
	{
		self thread zm_traps::player_elec_damage(trigger);
		status_effect::status_effect_apply(var_5b857980, undefined, self, 0);
	}
}

/*
	Name: damage
	Namespace: zm_trap_electric
	Checksum: 0xF8E84D31
	Offset: 0x708
	Size: 0x474
	Parameters: 1
	Flags: Linked
*/
function damage(trap)
{
	if(isdefined(self.marked_for_death) && self.marked_for_death)
	{
		return;
	}
	self endon(#"death");
	self clientfield::set("electrocute_ai_fx", 1);
	n_param = randomint(100);
	self.marked_for_death = 1;
	if(isdefined(trap.activated_by_player) && isplayer(trap.activated_by_player))
	{
		trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
		trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		if(isdefined(trap.activated_by_player.zapped_zombies))
		{
			trap.activated_by_player.zapped_zombies++;
			trap.activated_by_player notify(#"zombie_zapped");
		}
	}
	if(!self.archetype === #"zombie_dog" && isactor(self))
	{
		if(n_param > 90 && level.burning_zombies.size < 6)
		{
			level.burning_zombies[level.burning_zombies.size] = self;
			self thread zm_traps::zombie_flame_watch();
			self playsound(#"hash_5183b687ad8d715a");
			self thread zombie_death::flame_death_fx();
			playfxontag(level._effect[#"character_fire_death_torso"], self, "J_SpineLower");
			wait(randomfloat(1.25));
		}
		else
		{
			refs[0] = "guts";
			refs[1] = "right_arm";
			refs[2] = "left_arm";
			refs[3] = "right_leg";
			refs[4] = "left_leg";
			refs[5] = "no_legs";
			refs[6] = "head";
			self.a.gib_ref = refs[randomint(refs.size)];
			playsoundatposition(#"hash_5183b687ad8d715a", self.origin);
			if(randomint(100) > 50)
			{
				self thread zm_traps::electroctute_death_fx();
			}
			function_6eac4ca1(self, "electrocute");
			self notify(#"bhtn_action_notify", {#action:"electrocute"});
			wait(randomfloat(1.25));
			self playsound(#"hash_5183b687ad8d715a");
		}
	}
	if(isdefined(self.fire_damage_func))
	{
		self [[self.fire_damage_func]](trap);
	}
	else
	{
		level notify(#"trap_kill", {#trap:trap, #victim:self});
		self dodamage(self.health + 666, self.origin, trap);
	}
}

