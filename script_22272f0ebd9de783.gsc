// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_towers_util.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using scripts\zm_common\zm_contracts.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace namespace_a5b1b1d7;

/*
	Name: __init__system__
	Namespace: namespace_a5b1b1d7
	Checksum: 0xDF76DD1C
	Offset: 0x1D8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_55c1d88784016490", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a5b1b1d7
	Checksum: 0x7DF4CF45
	Offset: 0x228
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_286b5fa9();
	callback::on_finalize_initialization(&init);
}

/*
	Name: __main__
	Namespace: namespace_a5b1b1d7
	Checksum: 0x80F724D1
	Offset: 0x270
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_a5b1b1d7
	Checksum: 0xCDE21560
	Offset: 0x280
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&function_96e29e5f);
}

/*
	Name: function_96e29e5f
	Namespace: namespace_a5b1b1d7
	Checksum: 0x80F724D1
	Offset: 0x2B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_96e29e5f()
{
}

/*
	Name: function_286b5fa9
	Namespace: namespace_a5b1b1d7
	Checksum: 0x4503DA3D
	Offset: 0x2C0
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_286b5fa9()
{
	level.var_6024289d = getentarray("trap_blade_pillar", "script_label");
	a_zombie_traps = getentarray("zombie_trap", "targetname");
	level.var_5f47f17d = array::filter(a_zombie_traps, 0, &function_f0f82833);
	foreach(var_dabb9a97 in level.var_5f47f17d)
	{
		var_dabb9a97 function_d8e7a5e6();
	}
	zm_traps::register_trap_basic_info("blade_pillar", &function_8fe2d903, &function_96f77ea4);
	zm_traps::register_trap_damage("blade_pillar", &player_damage, &damage);
}

/*
	Name: function_f0f82833
	Namespace: namespace_a5b1b1d7
	Checksum: 0x83B12EAD
	Offset: 0x440
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function function_f0f82833(e_ent)
{
	return e_ent.script_noteworthy == "blade_pillar";
}

/*
	Name: function_d8e7a5e6
	Namespace: namespace_a5b1b1d7
	Checksum: 0x6E8B8A54
	Offset: 0x468
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_d8e7a5e6()
{
	self flag::init("activated");
	soul_whale = arraygetclosest(self.origin, level.var_6024289d);
	soul_whale flag::init("activated");
	self zm_traps::function_19d61a68();
	soul_whale.var_48698f89 = soul_whale.origin;
	soul_whale.var_ab34489f = soul_whale.angles;
	self.soul_whale = soul_whale;
}

/*
	Name: function_8fe2d903
	Namespace: namespace_a5b1b1d7
	Checksum: 0xB769BE1D
	Offset: 0x530
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function function_8fe2d903()
{
	self._trap_duration = 30;
	self._trap_cooldown_time = 60;
	if(isdefined(level.sndtrapfunc))
	{
		level thread [[level.sndtrapfunc]](self, 1);
	}
	self notify(#"trap_activate");
	level notify(#"trap_activate", self);
	self.activated_by_player thread function_45a2294f(self.script_string);
	foreach(t_trap in level.var_5f47f17d)
	{
		if(t_trap.script_string === self.script_string)
		{
			var_deed061f = getentarray(t_trap.target, "targetname");
			mdl_trap = getent(var_deed061f[0].target, "targetname");
			mdl_trap scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 1", mdl_trap);
			mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 2", mdl_trap);
			t_trap thread zm_traps::trap_damage();
		}
	}
	self waittilltimeout(self._trap_duration, #"trap_deactivate");
	foreach(t_trap in level.var_5f47f17d)
	{
		if(t_trap.script_string === self.script_string)
		{
			var_deed061f = getentarray(t_trap.target, "targetname");
			mdl_trap = getent(var_deed061f[0].target, "targetname");
			mdl_trap thread scene::play("p8_fxanim_zm_towers_trap_blade_01_bundle", "Shot 3", mdl_trap);
			t_trap notify(#"trap_done");
		}
	}
}

/*
	Name: function_96f77ea4
	Namespace: namespace_a5b1b1d7
	Checksum: 0x80F724D1
	Offset: 0x830
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_96f77ea4()
{
}

/*
	Name: function_45a2294f
	Namespace: namespace_a5b1b1d7
	Checksum: 0x566D8889
	Offset: 0x840
	Size: 0x1A0
	Parameters: 1
	Flags: Linked
*/
function function_45a2294f(str_id)
{
	foreach(e_pillar in level.var_6024289d)
	{
		if(e_pillar.script_string === str_id)
		{
			e_pillar thread activate_trap(self);
			level.var_a6b89158 = getent(e_pillar.target, "targetname");
			level.var_a6b89158 thread function_6f34f900();
		}
	}
	level notify(#"traps_activated", {#hash_be3f58a:str_id});
	wait(30);
	level notify(#"traps_cooldown", {#hash_be3f58a:str_id});
	n_cooldown = zm_traps::function_da13db45(60, self);
	wait(n_cooldown);
	level notify(#"traps_available", {#hash_be3f58a:str_id});
}

/*
	Name: function_6f34f900
	Namespace: namespace_a5b1b1d7
	Checksum: 0x702D94DB
	Offset: 0x9E8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_6f34f900()
{
	level endon(#"traps_cooldown");
	while(true)
	{
		s_info = undefined;
		s_info = self waittill(#"trigger");
		e_player = s_info.activator;
		if(!isplayer(e_player))
		{
			continue;
		}
		else
		{
			if(!e_player issliding())
			{
				continue;
			}
			else
			{
				var_82cc90a0 = e_player.health;
				wait(0.85);
				if(isdefined(e_player) && var_82cc90a0 == e_player.health)
				{
					e_player notify(#"hash_731c84be18ae9fa3");
				}
			}
		}
	}
}

/*
	Name: activate_trap
	Namespace: namespace_a5b1b1d7
	Checksum: 0xBB28F6E3
	Offset: 0xAE0
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function activate_trap(e_player)
{
	if(!self flag::get("activated"))
	{
		self flag::set("activated");
		if(isdefined(e_player))
		{
			self.activated_by_player = e_player;
		}
	}
}

/*
	Name: deactivate_trap
	Namespace: namespace_a5b1b1d7
	Checksum: 0x51597EED
	Offset: 0xB50
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function deactivate_trap(e_trap)
{
	e_trap notify(#"trap_deactivate");
	self flag::clear("activated");
	self notify(#"deactivate");
}

/*
	Name: damage
	Namespace: namespace_a5b1b1d7
	Checksum: 0x4F4ECC4D
	Offset: 0xBA8
	Size: 0x28C
	Parameters: 1
	Flags: Linked
*/
function damage(e_trap)
{
	if(!isalive(self) || self.archetype === #"tiger" || isvehicle(self))
	{
		return;
	}
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"heavy")
	{
		e_trap.soul_whale deactivate_trap(e_trap);
		if(isdefined(e_trap.activated_by_player))
		{
			e_trap.activated_by_player notify(#"hash_74fc45698491be88");
		}
	}
	else
	{
		self.marked_for_death = 1;
		if(isdefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player))
		{
			e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			e_trap.activated_by_player contracts::increment_zm_contract(#"hash_1f11b620a6de486b");
		}
		v_away = self.origin - e_trap.origin;
		v_away = vectornormalize((v_away[0], v_away[1], 0)) * 64;
		v_dest = self.origin + v_away;
		level notify(#"trap_kill", {#e_trap:e_trap, #e_victim:self});
		self dodamage(self.health + 666, self.origin, e_trap);
		self thread function_373d49f(v_dest, 0.25, 0, 0.125);
		self thread zm_towers_util::function_ae1b4f5b(90, 75, 25);
	}
}

/*
	Name: player_damage
	Namespace: namespace_a5b1b1d7
	Checksum: 0xC8A62039
	Offset: 0xE40
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function player_damage(t_damage)
{
	self endon(#"death");
	if(self getstance() == "stand" && !self issliding())
	{
		n_damage = 50;
		if(zm_utility::is_standard())
		{
			n_damage = n_damage * 0.5;
		}
		if(zm_utility::is_ee_enabled() && self flag::get(#"hash_6757075afacfc1b4"))
		{
			n_damage = n_damage * 0.5;
		}
		self dodamage(n_damage, self.origin, undefined, t_damage);
		wait(0.1);
		self.is_burning = undefined;
	}
	self setstance("crouch");
}

/*
	Name: function_373d49f
	Namespace: namespace_a5b1b1d7
	Checksum: 0x3F866014
	Offset: 0xF78
	Size: 0x16C
	Parameters: 4
	Flags: Linked
*/
function function_373d49f(v_dest, n_time = 1, n_accel = 0, n_decel = 0)
{
	if(isplayer(self))
	{
		var_3fba37cd = util::spawn_model("tag_origin", self.origin, self.angles);
		self linkto(var_3fba37cd);
		var_3fba37cd moveto(v_dest, n_time, n_accel, n_decel);
		var_3fba37cd waittill(#"movedone");
		var_3fba37cd delete();
	}
	else
	{
		v_direction = vectornormalize(v_dest);
		v_force = v_direction * 64;
		self startragdoll();
		self launchragdoll(v_force);
	}
}

