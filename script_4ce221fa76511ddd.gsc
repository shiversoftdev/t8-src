// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_mansion_ww_lvl2_quest.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm\zm_trap_electric.gsc;
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using script_387eab232fe22983;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_contracts.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\ai\zombie_death.gsc;

#namespace zm_trap_werewolfer;

/*
	Name: __init__system__
	Namespace: zm_trap_werewolfer
	Checksum: 0x6B45D01B
	Offset: 0x248
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trap_werewolfer", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_trap_werewolfer
	Checksum: 0xF6159C7A
	Offset: 0x298
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_custom::function_901b751c(#"zmtrapsenabled"))
	{
		return;
	}
	level._effect[#"werewolfer_impact"] = #"hash_6e44fde5d49cfc9b";
	zm_traps::register_trap_basic_info("werewolfer", &function_670dda89, &zm_trap_electric::trap_audio);
	zm_traps::register_trap_damage("werewolfer", &function_436d9a24, &ai_damage);
	level flag::init(#"hash_2287cf5d6310237e");
	level flag::init(#"hash_6f483dda6f8ab19d");
	if(!isdefined(level.var_7aa02c24))
	{
		level.var_7aa02c24 = new throttle();
		[[ level.var_7aa02c24 ]]->initialize(2, 0.1);
	}
}

/*
	Name: __main__
	Namespace: zm_trap_werewolfer
	Checksum: 0xACEB6748
	Offset: 0x3F0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!zm_custom::function_901b751c(#"zmtrapsenabled"))
	{
		return;
	}
	level flag::wait_till("all_players_spawned");
	level.var_4cca20a9 = getent("mdl_ww_trap_machine", "targetname");
	level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 1);
}

/*
	Name: function_670dda89
	Namespace: zm_trap_werewolfer
	Checksum: 0xB4374097
	Offset: 0x4A0
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_670dda89()
{
	level.var_4fe07a = self;
	self._trap_duration = 10;
	self._trap_cooldown_time = 30;
	if(isdefined(level.sndtrapfunc))
	{
		level thread [[level.sndtrapfunc]](self, 1);
	}
	level notify(#"traps_activated", {#hash_be3f58a:self.script_string});
	level flag::set(#"hash_6f483dda6f8ab19d");
	level thread function_408fcb87();
	level exploder::exploder("fxexp_ele_trap_activate");
	if(!isdefined(self.var_fe043be4))
	{
		self.var_fe043be4 = getent("mdl_ww_trap_lever", "targetname");
	}
	self.var_fe043be4 rotatepitch(90, 0.5);
	level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 2);
	fx_points = struct::get_array(self.target, "targetname");
	for(i = 0; i < fx_points.size; i++)
	{
		util::wait_network_frame();
		fx_points[i] thread zm_trap_electric::trap_audio(self);
	}
	self thread zm_traps::trap_damage();
	self waittilltimeout(self._trap_duration, #"trap_deactivate");
	self notify(#"trap_done");
	level exploder::stop_exploder("fxexp_ele_trap_activate");
	level flag::clear(#"hash_6f483dda6f8ab19d");
	self thread function_38b44aab();
}

/*
	Name: function_408fcb87
	Namespace: zm_trap_werewolfer
	Checksum: 0xF1F6C815
	Offset: 0x738
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_408fcb87()
{
	t_trap = getent("werewolfer", "script_noteworthy");
	while(level flag::get(#"hash_6f483dda6f8ab19d"))
	{
		foreach(player in getplayers())
		{
			if(isdefined(player) && player istouching(t_trap) && player.currentweapon === getweapon(#"zhield_dw"))
			{
				player riotshield::player_damage_shield(5);
			}
		}
		wait(0.25);
	}
}

/*
	Name: function_38b44aab
	Namespace: zm_trap_werewolfer
	Checksum: 0x483FEDCD
	Offset: 0x880
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_38b44aab()
{
	level notify(#"traps_cooldown", {#hash_be3f58a:self.script_string});
	n_cooldown = zm_traps::function_da13db45(self._trap_cooldown_time, self.activated_by_player);
	wait(n_cooldown);
	self.var_fe043be4 rotatepitch(-90, 0.5);
	wait(0.5);
	level.var_4cca20a9 clientfield::set("" + #"hash_17df66ef5f71c0de", 1);
	level notify(#"traps_available", {#hash_be3f58a:self.script_string});
}

/*
	Name: function_436d9a24
	Namespace: zm_trap_werewolfer
	Checksum: 0xBAB7483C
	Offset: 0x980
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_436d9a24(t_damage)
{
	shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");
	if(!(isdefined(self.b_no_trap_damage) && self.b_no_trap_damage))
	{
		self thread zm_traps::player_elec_damage(t_damage);
		status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
	}
}

/*
	Name: ai_damage
	Namespace: zm_trap_werewolfer
	Checksum: 0x7FE5958A
	Offset: 0xA10
	Size: 0x3FA
	Parameters: 1
	Flags: Linked
*/
function ai_damage(e_trap)
{
	self endon(#"death");
	if(self.var_9fde8624 === #"catalyst_electric")
	{
		return;
	}
	if(self.team === #"allies")
	{
		return;
	}
	if(self.archetype === #"blight_father")
	{
		e_trap notify(#"trap_deactivate");
	}
	else
	{
		if(isdefined(self.var_3e60a85e) && self.var_3e60a85e)
		{
			return;
		}
		self.var_3e60a85e = 1;
		if(isdefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player))
		{
			e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			e_trap.activated_by_player contracts::increment_zm_contract(#"hash_1f11b620a6de486b");
			if(isdefined(e_trap.activated_by_player.zapped_zombies))
			{
				e_trap.activated_by_player.zapped_zombies++;
				e_trap.activated_by_player notify(#"zombie_zapped");
			}
		}
		self fx::play("werewolfer_impact", self.origin, self.angles, "death");
		playsoundatposition(#"wpn_zmb_electrap_zap", self.origin);
		if(self.archetype === #"werewolf")
		{
			self thread zm_traps::electroctute_death_fx();
			self thread zm_traps::play_elec_vocals();
			self function_a3059f6(e_trap);
		}
		else
		{
			if(self.archetype === #"zombie")
			{
				refs[0] = "guts";
				refs[1] = "right_arm";
				refs[2] = "left_arm";
				refs[3] = "right_leg";
				refs[4] = "left_leg";
				refs[5] = "no_legs";
				refs[6] = "head";
				self.a.gib_ref = refs[randomint(refs.size)];
				if(randomint(100) > 50)
				{
					self thread zm_traps::electroctute_death_fx();
					self thread zm_traps::play_elec_vocals();
				}
				function_6eac4ca1(self, "electrocute");
				self notify(#"bhtn_action_notify", {#action:"electrocute"});
				wait(randomfloat(1.25));
				self function_a3059f6(e_trap);
			}
			else
			{
				self function_a3059f6(e_trap);
			}
		}
		wait(2);
		self.var_3e60a85e = undefined;
	}
}

/*
	Name: function_a3059f6
	Namespace: zm_trap_werewolfer
	Checksum: 0x42D20A1B
	Offset: 0xE18
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_a3059f6(e_trap)
{
	self endon(#"death");
	[[ level.var_7aa02c24 ]]->waitinqueue(self);
	if(isdefined(self.fire_damage_func))
	{
		self [[self.fire_damage_func]](e_trap);
	}
	else
	{
		if(self.archetype === #"werewolf")
		{
			n_damage = self.health + 100;
		}
		else
		{
			n_damage = 20000;
		}
		if(self.health < n_damage)
		{
			level notify(#"trap_kill", {#e_trap:e_trap, #victim:self});
			if(self.archetype === #"werewolf" && isdefined(e_trap.activated_by_player))
			{
				e_trap.activated_by_player notify(#"hash_510f9114e7a6300c");
			}
		}
		self dodamage(n_damage, e_trap.origin, undefined, e_trap, undefined, "MOD_ELECTROCUTED", 0, undefined);
	}
}

/*
	Name: function_2b9a3abe
	Namespace: zm_trap_werewolfer
	Checksum: 0xFDB703D1
	Offset: 0xF90
	Size: 0x118
	Parameters: 0
	Flags: None
*/
function function_2b9a3abe()
{
	if(isdefined(level.var_4fe07a))
	{
		if(level.var_4fe07a._trap_in_use)
		{
			level.var_4fe07a notify(#"trap_done");
			level.var_4fe07a._trap_cooldown_time = 0.05;
			level.var_4fe07a waittill(#"available");
		}
		if(level.var_4fe07a._trap_use_trigs.size > 0)
		{
			foreach(trig in level.var_4fe07a._trap_use_trigs)
			{
				trig triggerenable(0);
			}
		}
	}
}

