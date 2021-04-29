// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_135d37089bbde4f2;
#using script_18fb8ad2a13d96b;
#using script_2255a7ad3edc838f;
#using script_2ca4b414b146b498;
#using script_2cc4bd7902c3f711;
#using script_3b7405881c081f6;
#using script_3b808b326beb9e55;
#using script_490759cf62a1abc8;
#using script_4a81c26d2ddde9c;
#using script_5b092d41f1ecae8a;
#using script_61826ca279ffa0;
#using script_6c8abe14025b47c4;
#using script_bb99a1f9be8d0a7;
#using script_ee56e8b680377b6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace namespace_58d68fd0;

/*
	Name: init
	Namespace: namespace_58d68fd0
	Checksum: 0xE203FE91
	Offset: 0xD78
	Size: 0x326
	Parameters: 0
	Flags: None
*/
function init()
{
	level.var_d0ad09c5 = &function_d0ad09c5;
	level.var_1bbf6bf1 = 6;
	level flag::init("grenade_rock");
	level flag::init("grenade_stick");
	level flag::init("reset_sticky");
	level flag::init("grenade_room");
	level flag::init("grenade_room_explode");
	level flag::init("boat_enemies_dead");
	level flag::init("feet_dry");
	level flag::init("swim_done");
	level flag::init("war_machine");
	level flag::init("gib_done");
	level flag::init("dock_cleared_1");
	level flag::init("dock_cleared_2");
	level flag::init("wall_target_hit");
	level flag::init("enemy_arrived");
	level flag::init("patrol_dead");
	level flag::init("window_hit");
	level flag::init("mantis_dead_1");
	level flag::init("mantis_dead_2");
	level flag::init("mantis_dead_3");
	level flag::init("stop_reinforce");
	level flag::init("scorestreak_done");
	level flag::init("scorestreak_fail");
	level.var_ae120f18 = array(#"hash_fb7019d42721bca", #"hash_fb7029d42721d7d");
}

/*
	Name: function_d0ad09c5
	Namespace: namespace_58d68fd0
	Checksum: 0x7C9D6817
	Offset: 0x10A8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_d0ad09c5(effect)
{
	wait(randomfloatrange(0, 0.5));
}

/*
	Name: function_c9ff0dce
	Namespace: namespace_58d68fd0
	Checksum: 0x18EA68FD
	Offset: 0x10E0
	Size: 0x48A
	Parameters: 0
	Flags: None
*/
function function_c9ff0dce()
{
	level endon(#"combattraining_logic_finished");
	if(!isbot(self))
	{
		self callback::function_20263b9e(&function_20263b9e);
		self.overrideplayerdamage = &function_6fb4cde7;
		self thread function_8486a84b();
		namespace_73e1c3e3::delete_corpses();
		waitframe(1);
		namespace_73e1c3e3::function_8f04870f();
		self setstance("stand");
		if(level.var_ad7c0539 === 3)
		{
			self thread function_2fb096bf();
		}
		else if(level.var_ad7c0539 === 5 && level flag::get("war_machine") || level.var_ad7c0539 === 6 || level.var_ad7c0539 === 7 || level.var_ad7c0539 === 8 || level.var_ad7c0539 === 9)
		{
			self thread function_fef38fec();
		}
		else if(level.var_ad7c0539 === 10)
		{
			wait(0.5);
			if(isdefined(level.var_2159a10d) && level.var_2159a10d)
			{
				level namespace_8c007aa6::play_vo(#"hash_7dfd3741e740a503", 1);
			}
		}
		if(level.var_ad7c0539 === 5 && !level flag::get("feet_dry"))
		{
			level namespace_8c007aa6::play_vo(#"hash_c003161080d6e26", 1);
		}
		else if(level.var_ad7c0539 === 7)
		{
			self namespace_8c007aa6::play_vo(#"hash_216720671b1b0bd8", 1);
		}
	}
	else if(self.team == #"axis" && isdefined(level.var_ad7c0539))
	{
		if(isdefined(level.var_66b3c127))
		{
			switch(level.var_ad7c0539)
			{
				case 2:
				{
					self thread function_58c62280(0, 1);
					break;
				}
				case 3:
				{
					self thread function_58c62280(1, 1);
					break;
				}
				case 4:
				{
					self thread function_58c62280(1, 0);
					break;
				}
				case 5:
				{
					self thread function_58c62280(0, 1);
					break;
				}
				case 6:
				{
					self thread function_58c62280(0, 0);
					break;
				}
				case 7:
				{
					self thread function_58c62280(1, 1);
					break;
				}
				case 8:
				{
					self thread function_58c62280(1, 0);
					break;
				}
				case 10:
				{
					self thread function_58c62280(1, 0);
					break;
				}
				default:
				{
					self thread function_58c62280(0, 1);
					break;
				}
			}
		}
	}
}

/*
	Name: function_fef38fec
	Namespace: namespace_58d68fd0
	Checksum: 0xC4D065D1
	Offset: 0x1578
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_fef38fec()
{
	self endon(#"death");
	level.givecustomloadout = undefined;
	self switchtoweapon(getweapon(#"hero_pineapplegun"));
}

/*
	Name: function_753148fe
	Namespace: namespace_58d68fd0
	Checksum: 0x4DE0C28A
	Offset: 0x15D8
	Size: 0x1C4
	Parameters: 0
	Flags: None
*/
function function_753148fe()
{
	self endon(#"death");
	self namespace_64a487a9::function_fd2d220e(0);
	self takeweapon(getweapon(#"ar_accurate_t8"));
	self takeweapon(getweapon(#"hash_286a30586a6aed12"));
	self giveweapon(getweapon(#"ar_damage_t8", "holo", "damage", "damage2"));
	self giveweapon(getweapon(#"pistol_standard_t8"));
	var_3ba4bf7d = self getweaponslistprimaries();
	for(i = 0; i < var_3ba4bf7d.size; i++)
	{
		self giveweapon(var_3ba4bf7d[i]);
		self givemaxammo(var_3ba4bf7d[i]);
	}
	self switchtoweapon(var_3ba4bf7d[0]);
	self setspawnweapon(var_3ba4bf7d[0]);
}

/*
	Name: function_6fb4cde7
	Namespace: namespace_58d68fd0
	Checksum: 0xE215EA6F
	Offset: 0x17A8
	Size: 0x18A
	Parameters: 11
	Flags: None
*/
function function_6fb4cde7(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, n_psoffsettime, var_8b69d5cf)
{
	level notify(#"player_damaged");
	if(!(isdefined(level.var_a600ce76) && level.var_a600ce76 && str_means_of_death == "MOD_GRENADE_SPLASH"))
	{
		self.var_147223cf = gettime() / 1000;
	}
	if(!isbot(self))
	{
		if(isdefined(level.var_bf4ff87f))
		{
			n_damage = n_damage * level.var_bf4ff87f;
		}
		if(weapon === getweapon(#"hash_114729f4d5a8d08c"))
		{
			n_damage = n_damage * 0.4;
		}
		if(isdefined(level.var_3a0d2784) && level.var_3a0d2784)
		{
			n_damage = 0;
		}
	}
	if(level.var_ad7c0539 === 7)
	{
		level flag::set("enemy_arrived");
	}
	return int(n_damage);
}

/*
	Name: function_72ba0df6
	Namespace: namespace_58d68fd0
	Checksum: 0xCCC3F7DA
	Offset: 0x1940
	Size: 0x424
	Parameters: 9
	Flags: None
*/
function function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(!isbot(self))
	{
		self.var_1b387958 = 0;
		if(level.var_ad7c0539 === 1)
		{
			level notify(#"stop_target_nag");
		}
		level notify(#"stop_nag");
		namespace_8c007aa6::function_c72e58c1();
		namespace_8c007aa6::function_47ece28d();
		if(level.var_ad7c0539 === 7)
		{
			level flag::clear("wall_target_hit");
			level flag::clear("enemy_arrived");
			level flag::clear("patrol_dead");
		}
		else if(level.var_ad7c0539 === 9)
		{
			var_13dd1b4f = getaiteamarray(#"axis");
			foreach(var_c361acde in var_13dd1b4f)
			{
				level thread function_5a67767d(var_c361acde.origin);
				var_c361acde kill();
			}
		}
	}
	else if(self.team == #"axis")
	{
		self.isinuse = 0;
		if(self.targetname === "war_machine_victim")
		{
			if(weapon === getweapon(#"hero_pineapplegun") || weapon === getweapon(#"hero_pineapple_grenade") || isplayer(attacker))
			{
				level flag::set("gib_done");
			}
		}
		else if(level.var_ad7c0539 === 8)
		{
			if(isdefined(attacker) && isplayer(attacker) && (weapon == getweapon(#"hero_pineapplegun") || weapon == getweapon(#"hero_pineapple_grenade")))
			{
				level flag::set("window_hit");
			}
		}
		else if(level.var_ad7c0539 === 10)
		{
			e_player = namespace_73e1c3e3::get_player();
			if(!(isdefined(e_player.var_51ff7a58) && e_player.var_51ff7a58) && isalive(e_player) && level.var_ff7ed5c8 < 900)
			{
				function_86610592();
			}
		}
	}
}

/*
	Name: function_9b9525e9
	Namespace: namespace_58d68fd0
	Checksum: 0x1F08F03
	Offset: 0x1D70
	Size: 0x49C
	Parameters: 0
	Flags: None
*/
function function_9b9525e9()
{
	level endon(#"combattraining_logic_finished");
	level.var_e6db911d = 1;
	level.allowspecialistdialog = 0;
	level.var_30264985 = 1;
	level thread namespace_73e1c3e3::function_9ab507a9("grenade_room_collision", "start_grenade_room_collision", "stop_grenade_room_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grenade_room_swim_collision", "start_grenade_room_swim_collision", "stop_grenade_room_swim_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("swimming_collision", "start_swimming_collision", "stop_swimming_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_dock_collision", "start_war_machine_dock_collision", "stop_war_machine_dock_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_dock_forward_collision", "start_war_machine_dock_forward_collision", "stop_war_machine_dock_forward_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_dock_sandwich_collision", "start_war_machine_dock_sandwich_collision", "stop_war_machine_dock_sandwich_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_wall_bounce_collision", "start_war_machine_wall_bounce_collision", "stop_war_machine_wall_bounce_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_wall_bounce_forward_collision", "start_war_machine_wall_bounce_forward_collision", "stop_war_machine_wall_bounce_forward_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_arc_window_collision", "start_war_machine_arc_window_collision", "stop_war_machine_arc_window_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("war_machine_mantis_collision", "start_war_machine_mantis_collision", "stop_war_machine_mantis_collision", undefined, 1, 0);
	while(true)
	{
		e_player = namespace_73e1c3e3::get_player();
		if(isdefined(e_player))
		{
			break;
		}
		waitframe(1);
	}
	e_player namespace_64a487a9::function_26d45f32(1);
	level.var_d4668c34 = 1;
	level.var_f9b89e94 = &function_ae3fa0e0;
	level.var_ad7c0539 = 1;
	function_eef19056();
	level.var_ad7c0539 = 2;
	function_2f726e0f();
	level.var_ad7c0539 = 3;
	function_27e2d4aa();
	level.var_ad7c0539 = 4;
	function_a03539a3();
	level.var_ad7c0539 = 5;
	function_bd6468f();
	level.var_ad7c0539 = 6;
	function_bd7019ff();
	level.var_ad7c0539 = 7;
	function_8d7d4d37();
	level.var_ad7c0539 = 8;
	function_de37fc52();
	level.var_ad7c0539 = 9;
	function_18161780();
	level.var_ad7c0539 = 10;
	function_be0b44be();
	function_bb868a62();
	level thread namespace_73e1c3e3::function_26283961();
	level.givecustomloadout = &namespace_13777bae::function_1dd43d36;
	globallogic_score::_setplayermomentum(e_player, 0);
	namespace_73e1c3e3::function_9f8be64a();
}

/*
	Name: function_bb868a62
	Namespace: namespace_58d68fd0
	Checksum: 0x76A9BA09
	Offset: 0x2218
	Size: 0x244
	Parameters: 0
	Flags: None
*/
function function_bb868a62()
{
	level flag::clear("grenade_rock");
	level flag::clear("grenade_stick");
	level flag::clear("reset_sticky");
	level flag::clear("grenade_room");
	level flag::clear("grenade_room_explode");
	level flag::clear("boat_enemies_dead");
	level flag::clear("feet_dry");
	level flag::clear("swim_done");
	level flag::clear("gib_done");
	level flag::clear("dock_cleared_1");
	level flag::clear("dock_cleared_2");
	level flag::clear("wall_target_hit");
	level flag::clear("enemy_arrived");
	level flag::clear("patrol_dead");
	level flag::clear("window_hit");
	level flag::clear("mantis_dead_1");
	level flag::clear("mantis_dead_2");
	level flag::clear("mantis_dead_3");
}

/*
	Name: function_eef19056
	Namespace: namespace_58d68fd0
	Checksum: 0x1797823C
	Offset: 0x2468
	Size: 0x480
	Parameters: 0
	Flags: None
*/
function function_eef19056()
{
	level endon(#"combattraining_logic_finished");
	player = level.players[0];
	player thread namespace_73e1c3e3::function_84181d75(1, player.origin, undefined);
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level.var_e72728b8 = array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun");
	namespace_8c007aa6::function_3ca1b77d();
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	player thread namespace_73e1c3e3::function_84181d75(0, player.origin, undefined);
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_grenade_rock_objective", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 1, 1, 25);
	namespace_73e1c3e3::function_e9ab1003("s_grenade_rock_objective");
	level notify(#"stop_goto_nag");
	namespace_8c007aa6::function_3ca1b77d();
	level namespace_8c007aa6::play_vo(#"hash_70c47bde48968268", 1);
	level.var_e72728b8 = array(#"hero_pineapplegun");
	wait(0.1);
	player thread namespace_73e1c3e3::function_61c3d59c(#"hash_77fa7edf837436cb", undefined);
	level thread namespace_8c007aa6::play_vo(#"hash_14876e22977a8688", 0);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_7b37d7228954ffca"), "stop_target_nag");
	while(!level flag::get("grenade_rock"))
	{
		player = level.players[0];
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", s_loc.origin, s_loc.angles, #"any", undefined, 40, undefined);
		player thread function_ba2e9281(waypoint);
		player thread function_b6f2e73d(s_loc);
		while(isalive(player) && !level flag::get("grenade_rock"))
		{
			waitframe(1);
		}
		waitframe(1);
		if(isdefined(waypoint) && !level flag::get("grenade_rock"))
		{
			waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		wait(0.1);
		level notify(#"stop_target_nag");
		wait(0.5);
		while(!isalive(player))
		{
			waitframe(1);
		}
	}
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	level notify(#"hash_4c9c5fbc89779e64");
}

/*
	Name: function_2f726e0f
	Namespace: namespace_58d68fd0
	Checksum: 0xD8126A13
	Offset: 0x28F0
	Size: 0x3AC
	Parameters: 0
	Flags: None
*/
function function_2f726e0f()
{
	level endon(#"combattraining_logic_finished");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	level thread function_fcfbe225();
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_grenade_enemy_stick_objective", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 1, 1, 50);
	namespace_73e1c3e3::function_e9ab1003("s_grenade_enemy_stick_objective");
	level notify(#"stop_goto_nag");
	while(!level flag::get("grenade_stick"))
	{
		namespace_8c007aa6::function_3ca1b77d();
		level.var_66b3c127 = struct::get_array("s_battery_sticky_grenade_soldiers", "targetname");
		level.var_9f073b4 = 0;
		namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level.players[0] thread function_abd58b32();
		level.players[0] namespace_8c007aa6::play_vo(#"hash_652da47d15a2ff49", 1);
		level.var_e72728b8 = array(#"hero_pineapplegun");
		wait(0.1);
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_15afb4b819807139", undefined);
		level flag::wait_till_any(array("grenade_stick", "reset_sticky"));
		namespace_73e1c3e3::function_c2a10fc();
		if(level flag::get("reset_sticky"))
		{
			level flag::clear("reset_sticky");
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
			wait(1);
		}
		namespace_73e1c3e3::function_654280be();
		namespace_8c007aa6::function_3ca1b77d();
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(1);
	}
	level.players[0] namespace_8c007aa6::play_vo(#"hash_374bbcc2c0a73764", 1);
	level notify(#"hash_4c9c5fbc89779e64");
	namespace_8c007aa6::function_3ca1b77d();
}

/*
	Name: function_27e2d4aa
	Namespace: namespace_58d68fd0
	Checksum: 0xDC212029
	Offset: 0x2CA8
	Size: 0x44C
	Parameters: 0
	Flags: None
*/
function function_27e2d4aa()
{
	level endon(#"combattraining_logic_finished");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	level.players[0] thread function_7810b056();
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_grenade_clear_room_start", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 0, 1, 50);
	namespace_73e1c3e3::function_e9ab1003("s_grenade_clear_room_start");
	level notify(#"stop_goto_nag");
	namespace_8c007aa6::function_3ca1b77d();
	while(!level flag::get("grenade_room"))
	{
		level.var_e72728b8 = array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun");
		wait(0.5);
		level.var_e72728b8 = array(#"hero_pineapplegun");
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_581e7d390944eea6"), "stop_room_nag");
		s_loc = struct::get("s_grenade_room_target", "targetname");
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", s_loc.origin, s_loc.angles, #"any", undefined, 30, undefined);
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_7da128b8b09ee5e3", undefined);
		level.players[0] thread function_5e9629d8(waypoint);
		while(isalive(level.players[0]) && !level flag::get("grenade_room"))
		{
			waitframe(1);
		}
		level notify(#"stop_room_nag");
		if(!level flag::get("grenade_room"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
			if(isdefined(waypoint))
			{
				waypoint namespace_73e1c3e3::function_f9ed304d();
			}
		}
		wait(0.1);
		namespace_73e1c3e3::function_654280be();
		namespace_73e1c3e3::function_c2a10fc();
		wait(0.5);
	}
	namespace_8c007aa6::function_c72e58c1();
	namespace_8c007aa6::function_47ece28d();
	wait(0.1);
	level.players[0] namespace_8c007aa6::play_vo(#"hash_4a3fa914d1ccc37c", 1);
	level notify(#"stop_grenade_room_collision");
	level notify(#"stop_grenade_room_swim_collision");
	namespace_8c007aa6::function_3ca1b77d();
}

/*
	Name: function_a03539a3
	Namespace: namespace_58d68fd0
	Checksum: 0xEC6463A1
	Offset: 0x3100
	Size: 0x48C
	Parameters: 0
	Flags: None
*/
function function_a03539a3()
{
	level endon(#"combattraining_logic_finished");
	level thread function_ad548822();
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_grenade_behind_cover_start", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 1, 0.1, 50);
	namespace_73e1c3e3::function_e9ab1003("s_grenade_behind_cover_start");
	level notify(#"stop_goto_nag");
	level notify(#"start_grenade_room_swim_collision");
	while(!level flag::get("boat_enemies_dead"))
	{
		namespace_8c007aa6::function_3ca1b77d();
		wait(0.5);
		level thread namespace_8c007aa6::play_vo(#"hash_4a3fab14d1ccc6e2");
		level.var_66b3c127 = struct::get_array("s_battery_behind_cover_soldiers", "targetname");
		level.var_9f073b4 = 0;
		namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level.var_e72728b8 = array(#"hero_pineapplegun");
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_5dd04af8bb689afe"), "stop_cover_nag");
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_50137242db8bc97a", undefined);
		s_loc = struct::get("s_grenade_behind_cover_target", "targetname");
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", s_loc.origin, s_loc.angles, #"any", undefined, 20, undefined);
		level.players[0] thread function_31bf458c(waypoint);
		level.players[0] thread function_45f567b0(s_loc, waypoint);
		while(isalive(level.players[0]) && !level flag::get("boat_enemies_dead"))
		{
			waitframe(1);
		}
		if(!level flag::get("boat_enemies_dead"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
		}
		wait(0.1);
		if(isdefined(waypoint))
		{
			waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(0.5);
	}
	level notify(#"hash_4c9c5fbc89779e64");
	namespace_8c007aa6::function_c72e58c1();
	namespace_8c007aa6::function_47ece28d();
	level thread namespace_8c007aa6::play_vo(#"hash_281160c4a36c9dd0", 0);
	namespace_73e1c3e3::function_c2a10fc();
	wait(2);
}

/*
	Name: function_bd6468f
	Namespace: namespace_58d68fd0
	Checksum: 0x2D040D93
	Offset: 0x3598
	Size: 0x87C
	Parameters: 0
	Flags: None
*/
function function_bd6468f()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003("s_swim_restart");
	level.players[0] thread namespace_73e1c3e3::function_84181d75(0);
	level notify(#"start_swimming_collision");
	while(!level flag::get("swim_done"))
	{
		level.players[0] thread function_232a26ae();
		level.var_3e67eeea = #"hash_5d94c1a3e60a6741";
		namespace_73e1c3e3::function_e0d36a2c(undefined, "s_war_machine_swim_goto", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 0, undefined, 25);
		namespace_73e1c3e3::function_e9ab1003("s_war_machine_swim_goto");
		level.var_3e67eeea = undefined;
		trigger::wait_till("trigger_on_dock");
		level notify(#"start_war_machine_dock_collision");
		level notify(#"start_war_machine_dock_forward_collision");
		level notify(#"stop_grenade_room_swim_collision");
		level flag::set("swim_done");
	}
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] thread namespace_8c007aa6::play_vo(#"hash_4ab40574c0003197", 0);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_war_machine_dock_goto", array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun"), 0, undefined, 50);
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_dock_goto");
	level flag::set("feet_dry");
	level notify(#"stop_goto_nag");
	level notify(#"start_war_machine_dock_sandwich_collision");
	level notify(#"stop_war_machine_dock_collision");
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] thread namespace_8c007aa6::play_vo(#"hash_6385b89e518f7792", 0);
	n_len = soundgetplaybacktime(#"hash_6385b89e518f7792") / 1000;
	if(n_len - 2.5 > 0)
	{
		wait(n_len - 2.5);
	}
	else
	{
		wait(2);
	}
	var_1c549f7d = (level.players[0] gamepadusedlast() ? #"hash_ed0eccfd92ed982" : #"hash_5e850d009a2366a2");
	level.players[0] thread namespace_73e1c3e3::function_61c3d59c(var_1c549f7d, undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_707aff02c0ababb9"), "stop_gib_nag");
	level.var_e72728b8 = array(#"eq_cluster_semtex_grenade");
	level.players[0] waittill(#"hash_6706cbd0ce1c0c09");
	level flag::set("war_machine");
	namespace_73e1c3e3::function_c2a10fc();
	level notify(#"stop_gib_nag");
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] namespace_8c007aa6::play_vo(#"hash_6385b99e518f7945", 1);
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(!level flag::get("gib_done"))
	{
		level.var_66b3c127 = struct::get_array("s_war_machine_guys_1", "targetname");
		level.var_9f073b4 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_67563f152ef388bd", undefined);
		namespace_8c007aa6::function_3ca1b77d();
		level.players[0] namespace_8c007aa6::play_vo(#"hash_fbb33cda7463db4", 1);
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_707aff02c0ababb9"), "stop_gib_nag");
		while(isalive(level.players[0]) && !level flag::get("gib_done"))
		{
			wait(1);
			if(isalive(level.players[0]))
			{
				a_enemies = level.players[0] namespace_64a487a9::function_dde6edbd();
				if(!isdefined(a_enemies) || (isdefined(a_enemies) && a_enemies.size < 1))
				{
					break;
				}
			}
		}
		wait(1);
		if(!level flag::get("gib_done"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
		}
		else
		{
			wait(1);
			if(!isalive(level.players[0]))
			{
				level flag::clear("gib_done");
			}
		}
		namespace_73e1c3e3::function_c2a10fc();
		level notify(#"stop_gib_nag");
		wait(1);
	}
	while(!isalive(level.players[0]))
	{
		waitframe(1);
	}
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] namespace_8c007aa6::play_vo(#"hash_5b2fd395bb586baf", 1);
}

/*
	Name: function_bd7019ff
	Namespace: namespace_58d68fd0
	Checksum: 0xE2F68967
	Offset: 0x3E20
	Size: 0x56C
	Parameters: 0
	Flags: None
*/
function function_bd7019ff()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_dock_goto");
	level.players[0] thread namespace_73e1c3e3::function_84181d75(0);
	level.var_e72728b8 = array(#"eq_cluster_semtex_grenade");
	level thread namespace_8c007aa6::play_vo(#"hash_5b2fd495bb586d62", 0);
	while(!level flag::get("dock_cleared_1"))
	{
		level.var_66b3c127 = struct::get_array("s_war_machine_aoe_guy_1");
		level.var_9f073b4 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_2e379a9a40b2463", undefined);
		level.players[0] thread function_c35855fd(1);
		while(isalive(level.players[0]) && !level flag::get("dock_cleared_1"))
		{
			wait(1);
		}
		level notify(#"player_died");
		if(!level flag::get("dock_cleared_1"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(0.5);
	}
	while(!level flag::get("dock_cleared_2"))
	{
		wait(1);
		level.var_66b3c127 = struct::get_array("s_war_machine_aoe_guy_2");
		level.var_9f073b4 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level namespace_8c007aa6::play_vo(#"hash_5b2fd595bb586f15", 1);
		level.players[0] thread function_c35855fd(2);
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_73ed12cc4469c57e"), "stop_area_nag");
		while(isalive(level.players[0]) && !level flag::get("dock_cleared_2"))
		{
			waitframe(1);
		}
		namespace_73e1c3e3::function_c2a10fc();
		level notify(#"player_died");
		if(!level flag::get("dock_cleared_2"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
			while(!isalive(level.players[0]))
			{
				waitframe(1);
			}
			wait(0.5);
			level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_2e379a9a40b2463", undefined);
		}
	}
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	level notify(#"stop_area_nag");
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	wait(0.5);
	level notify(#"stop_war_machine_dock_forward_collision");
	level notify(#"start_war_machine_wall_bounce_collision");
	level notify(#"start_war_machine_wall_bounce_forward_collision");
	level.players[0] namespace_8c007aa6::play_vo(#"hash_4e12d56aa916db41", 1);
}

/*
	Name: function_8d7d4d37
	Namespace: namespace_58d68fd0
	Checksum: 0xEBB62412
	Offset: 0x4398
	Size: 0x598
	Parameters: 0
	Flags: None
*/
function function_8d7d4d37()
{
	level endon(#"combattraining_logic_finished");
	level.players[0] thread namespace_73e1c3e3::function_84181d75(0);
	level notify(#"start_war_machine_wall_bounce_collision");
	level.var_e72728b8 = array(#"eq_cluster_semtex_grenade");
	level notify(#"start_war_machine_wall_bounce_forward_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_war_machine_wall_bounce_goto", array(#"eq_cluster_semtex_grenade"), 0, undefined, 25);
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_wall_bounce_goto");
	level notify(#"stop_goto_nag");
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(!level flag::get("patrol_dead"))
	{
		level.players[0] thread function_2804d387();
		namespace_8c007aa6::function_3ca1b77d();
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_4343701e06ee1033", undefined);
		s_loc = struct::get("s_war_machine_wall_bounce_target");
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", s_loc.origin, s_loc.angles, #"any", undefined, 20, undefined);
		level.players[0] thread function_8e12a34(waypoint);
		level.players[0] thread function_76f5d2dc("s_war_machine_wall_bounce_target");
		level.var_66b3c127 = struct::get_array("s_war_machine_wall_bounce_guys");
		level.var_9f073b4 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		namespace_8c007aa6::function_3ca1b77d();
		level thread namespace_8c007aa6::play_vo(#"hash_4e12d46aa916d98e", 0);
		level.players[0] thread function_f47cc92a();
		level.players[0] thread function_4f228e34();
		while(isalive(level.players[0]) && !level flag::get("patrol_dead"))
		{
			wait(1);
		}
		if(!level flag::get("patrol_dead"))
		{
			level notify(#"hash_1ed85b84698bdac7");
			wait(0.5);
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
			namespace_8c007aa6::function_c72e58c1();
			namespace_8c007aa6::function_47ece28d();
			level flag::clear("enemy_arrived");
			level notify(#"start_war_machine_wall_bounce_forward_collision");
			level notify(#"stop_war_machine_arc_window_collision");
		}
		if(isdefined(waypoint))
		{
			waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		if(level flag::get("patrol_dead"))
		{
			level notify(#"start_war_machine_arc_window_collision");
			namespace_73e1c3e3::function_c2a10fc();
			break;
		}
	}
	level.var_32ae304 = &namespace_64a487a9::function_32ae304;
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] namespace_8c007aa6::play_vo(#"hash_ac50883aac8488", 1);
	level notify(#"stop_war_machine_wall_bounce_forward_collision");
}

/*
	Name: function_de37fc52
	Namespace: namespace_58d68fd0
	Checksum: 0xBA24BAAE
	Offset: 0x4938
	Size: 0x4B0
	Parameters: 0
	Flags: None
*/
function function_de37fc52()
{
	level endon(#"combattraining_logic_finished");
	level notify(#"start_war_machine_arc_window_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_war_machine_wall_target_goto", array(#"eq_cluster_semtex_grenade"), 0, undefined, 25);
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_wall_target_goto");
	level notify(#"stop_goto_nag");
	while(!level flag::get("window_hit"))
	{
		level.var_66b3c127 = struct::get_array("s_war_machine_window_guys", "targetname");
		level.var_9f073b4 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		level thread namespace_8c007aa6::play_vo(#"hash_3dc8e508b25425a5", 0);
		s_loc = struct::get("s_war_machine_window_target");
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", s_loc.origin, s_loc.angles, #"any", undefined, 40, undefined);
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_7b787c42f3808a76", undefined);
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_3a85e22c955daf0b"), "stop_arc_nag");
		level.players[0] thread function_8cff7e18();
		level.players[0] thread function_cc38079e();
		while(isalive(level.players[0]) && !level flag::get("window_hit"))
		{
			wait(1);
		}
		if(!level flag::get("window_hit"))
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0, 0);
			namespace_8c007aa6::function_c72e58c1();
			namespace_8c007aa6::function_47ece28d();
		}
		if(isdefined(waypoint))
		{
			waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		if(level flag::get("window_hit"))
		{
			break;
		}
		wait(1.5);
	}
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	level notify(#"stop_arc_nag");
	namespace_73e1c3e3::function_654280be();
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	level thread namespace_8c007aa6::play_vo(#"hash_6923d897f72b52d4", 0);
	n_len = soundgetplaybacktime(#"hash_6923d897f72b52d4") / 1000;
	wait(n_len - 3.5);
	level notify(#"stop_war_machine_arc_window_collision");
}

/*
	Name: function_18161780
	Namespace: namespace_58d68fd0
	Checksum: 0x61206BB5
	Offset: 0x4DF0
	Size: 0x820
	Parameters: 0
	Flags: None
*/
function function_18161780()
{
	level endon(#"combattraining_logic_finished");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_52d732004d3b4bcc"), "stop_goto_nag");
	level thread function_fcc78b2c();
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_war_machine_mantis_goto", array(#"eq_cluster_semtex_grenade"), 0, undefined, 40);
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_mantis_goto");
	level notify(#"stop_goto_nag");
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(!level flag::get("mantis_dead_1"))
	{
		namespace_8c007aa6::function_3ca1b77d();
		level.players[0] namespace_8c007aa6::play_vo(#"hash_324ec2f3d371715e", 1);
		wait(0.5);
		namespace_8c007aa6::function_3ca1b77d();
		level notify(#"hash_4c9c5fbc89779e64");
		level thread namespace_8c007aa6::play_vo(#"hash_324ec3f3d3717311", 0);
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillMantises");
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
		level.players[0] function_aef4e53f("s_battery_mantis_1", 1);
		if(isalive(level.players[0]))
		{
			level.players[0] thread function_d0bcce1(1);
		}
		while(isalive(level.players[0]) && !level flag::get("mantis_dead_1"))
		{
			waitframe(1);
		}
		if(!level flag::get("mantis_dead_1"))
		{
			function_f06e9a28();
			if(level.var_1bbf6bf1 < 6)
			{
				level.var_1bbf6bf1 = 6;
			}
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(0.5);
	}
	while(!level flag::get("mantis_dead_2"))
	{
		level.players[0] function_aef4e53f("s_battery_mantis_2", 3);
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
		if(isalive(level.players[0]))
		{
			level.players[0] thread function_d0bcce1(2);
		}
		while(isalive(level.players[0]) && !level flag::get("mantis_dead_2"))
		{
			waitframe(1);
		}
		if(!level flag::get("mantis_dead_2"))
		{
			function_f06e9a28();
			if(level.var_1bbf6bf1 < 5)
			{
				level.var_1bbf6bf1 = 5;
				level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
			}
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(0.5);
	}
	while(!level flag::get("mantis_dead_3"))
	{
		level.players[0] function_aef4e53f("s_battery_mantis_3", 2);
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_74ef556ec3948300"), "stop_nag");
		if(isalive(level.players[0]))
		{
			level.players[0] thread function_d0bcce1(3);
		}
		while(isalive(level.players[0]) && !level flag::get("mantis_dead_3"))
		{
			waitframe(1);
		}
		if(!level flag::get("mantis_dead_3"))
		{
			function_f06e9a28();
			if(level.var_1bbf6bf1 < 3)
			{
				level.var_1bbf6bf1 = 3;
				level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
			}
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(0.5);
		level notify(#"stop_nag");
	}
	namespace_73e1c3e3::function_c2a10fc();
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	wait(0.5);
	namespace_8c007aa6::function_3ca1b77d();
	level.players[0] namespace_8c007aa6::function_831e0584(array(#"hash_1e4ccf71b4216e7b", #"hash_1e4cce71b4216cc8", #"hash_1e4cd171b42171e1"), 1);
	namespace_8c007aa6::function_3ca1b77d();
	level notify(#"stop_war_machine_mantis_collision");
}

/*
	Name: function_be0b44be
	Namespace: namespace_58d68fd0
	Checksum: 0xCA2130B5
	Offset: 0x5618
	Size: 0x24C
	Parameters: 0
	Flags: None
*/
function function_be0b44be()
{
	level endon(#"combattraining_logic_finished");
	setdvar(#"hash_48162cd174e3034d", 0);
	level.var_c8f47cbe = 3;
	globallogic_score::_setplayermomentum(level.players[0], 0);
	callback::on_player_killed_with_params(&namespace_73e1c3e3::function_944e4110);
	level.var_e72728b8 = undefined;
	level.var_32ae304 = &namespace_64a487a9::function_32ae304;
	namespace_73e1c3e3::function_e9ab1003("s_war_machine_mantis_goto");
	level.players[0] thread function_753148fe();
	level.players[0] notify(#"hash_526132995cf20df8");
	level notify(#"stop_swimming_collision");
	level.var_d4668c34 = undefined;
	function_8e068518();
	level.var_e72728b8 = array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun");
	level notify(#"hash_539b96e43f1642f7");
	level notify(#"stop_score_nag");
	level thread namespace_8c007aa6::play_vo(#"hash_6ca8fb135975685a", 0);
	function_e17f2b8a();
	callback::function_e2ca0af6(&namespace_73e1c3e3::function_944e4110);
	wait(1);
	namespace_8c007aa6::function_3ca1b77d();
	level namespace_8c007aa6::play_vo("vox_tvoi_tutor_batt_end_0", 1);
	level namespace_8c007aa6::play_vo("vox_tvoi_tutor_batt_end_1", 1);
	wait(1);
}

/*
	Name: function_f69a6b41
	Namespace: namespace_58d68fd0
	Checksum: 0x64BE9DB
	Offset: 0x5870
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function function_f69a6b41()
{
	self notify(#"retry");
	self endon(#"death", #"retry");
	self waittill(#"mortarradarused");
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_224c6765bca56be4", #"hash_224c6865bca56d97"), 1);
	self waittill(#"killstreak_done");
	level notify(#"hash_269c201d6122a737");
	level thread namespace_8c007aa6::play_vo(#"hash_11895f57fb2ed05", 0);
}

/*
	Name: function_30128519
	Namespace: namespace_58d68fd0
	Checksum: 0x6AE21AF3
	Offset: 0x5960
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function function_30128519()
{
	self notify(#"retry");
	self endon(#"death", #"retry");
	while(true)
	{
		while(!isdefined(level.var_ff7ed5c8))
		{
			waitframe(1);
		}
		if(level.var_ff7ed5c8 >= 500)
		{
			break;
		}
		wait(0.1);
	}
	level.players[0] namespace_8c007aa6::play_vo(#"hash_791a82dcb88e4978", 1);
}

/*
	Name: function_f7113889
	Namespace: namespace_58d68fd0
	Checksum: 0xA6021079
	Offset: 0x5A20
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_f7113889()
{
	self endon(#"death");
	level endon(#"hash_539b96e43f1642f7", #"scorestreak_done");
	wait(60);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_417649333d51a8d1"), "stop_score_nag");
}

/*
	Name: function_8e068518
	Namespace: namespace_58d68fd0
	Checksum: 0xF3912E88
	Offset: 0x5AA8
	Size: 0x4A0
	Parameters: 0
	Flags: None
*/
function function_8e068518()
{
	level endon(#"combattraining_logic_finished");
	level.players[0] thread namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillToEarnLightningStrike");
	level.var_2159a10d = 1;
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(level.var_2159a10d)
	{
		namespace_73e1c3e3::function_e44c5b8e(#"planemortar", 9);
		setdvar(#"hash_3e06b14c41136e95", 0);
		level flag::clear("stop_reinforce");
		level.players[0] thread namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillToEarnLightningStrike");
		level.var_ff7ed5c8 = 0;
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_ff7ed5c8);
		level.players[0].momentum = 0;
		globallogic_score::_setplayermomentum(level.players[0], level.var_ff7ed5c8);
		level.players[0] thread function_30128519();
		level.players[0] thread function_f69a6b41();
		level.var_66b3c127 = struct::get_array("s_killstreak_spawn", "targetname");
		level.var_9f073b4 = 0;
		namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
		wait(0.5);
		while(level.var_2159a10d && (!(isdefined(level.var_51ff7a58) && level.var_51ff7a58)) && isalive(level.players[0]))
		{
			waitframe(1);
		}
		if(!isalive(level.players[0]))
		{
			level.players[0] namespace_73e1c3e3::function_1bb93418();
			level.var_ff7ed5c8 = 0;
			level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_ff7ed5c8);
			level.players[0].momentum = 0;
			globallogic_score::_setplayermomentum(level.players[0], level.var_ff7ed5c8);
		}
		level flag::set("stop_reinforce");
		wait(0.1);
		if(!isalive(level.players[0]))
		{
			wait(1);
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(1);
			namespace_73e1c3e3::function_79957328(0.5);
		}
		if(isdefined(level.var_51ff7a58) && level.var_51ff7a58)
		{
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0);
			level.var_2159a10d = 0;
			level notify(#"stop_score_nag");
		}
		while(!isalive(level.players[0]))
		{
			waitframe(1);
		}
		wait(1);
		namespace_73e1c3e3::function_9aca2fa0("ct_action");
	}
}

/*
	Name: function_86610592
	Namespace: namespace_58d68fd0
	Checksum: 0x4819C952
	Offset: 0x5F50
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function function_86610592()
{
	level.var_ff7ed5c8 = level.var_ff7ed5c8 + 100;
	if(level.var_ff7ed5c8 < 900)
	{
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_ff7ed5c8);
	}
	else
	{
		level.var_51ff7a58 = 1;
		level.players[0] namespace_73e1c3e3::function_1bb93418();
		level notify(#"hash_3fcfe72e5a06b79f");
		level.players[0] notify(#"hash_d492b9f291b1e7b");
	}
	if(level.var_ff7ed5c8 > 700)
	{
		level flag::set("stop_reinforce");
	}
}

/*
	Name: function_537c9eea
	Namespace: namespace_58d68fd0
	Checksum: 0x8CBA3B87
	Offset: 0x6048
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_537c9eea()
{
	self endon(#"death");
	self waittill(#"hash_d492b9f291b1e7b");
	self.var_51ff7a58 = 1;
	self namespace_73e1c3e3::function_1bb93418();
}

/*
	Name: function_e17f2b8a
	Namespace: namespace_58d68fd0
	Checksum: 0x51EBA427
	Offset: 0x60A0
	Size: 0x5E8
	Parameters: 0
	Flags: None
*/
function function_e17f2b8a()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(!level flag::get("scorestreak_done"))
	{
		namespace_73e1c3e3::function_fdfeb384();
		while(isalive(level.players[0]))
		{
			var_de7f669b = (level.players[0] gamepadusedlast() ? #"hash_4e288d0b0adc213" : #"hash_5f4c5d85edf703ed");
			level.players[0] thread namespace_73e1c3e3::function_61c3d59c(var_de7f669b, undefined);
			namespace_73e1c3e3::function_e44c5b8e(#"planemortar", 0);
			wait(0.1);
			namespace_73e1c3e3::function_daa27144();
			level thread function_7f8a8489();
			level.players[0] namespace_73e1c3e3::function_49e0c5bc(0);
			level.players[0] thread function_667b9fbc();
			level.players[0] thread function_f7113889();
			var_88706ea7 = undefined;
			var_88706ea7 = level.players[0] waittill(#"mortarradarused", #"death");
			if(var_88706ea7._notify === "mortarRadarUsed")
			{
				namespace_73e1c3e3::function_c2a10fc();
				level notify(#"stop_score_nag");
				level.var_3a0d2784 = 1;
				level.players[0] val::set("scorestreak_protect", "takedamage", 0);
				level.var_66b3c127 = struct::get_array("s_scorestreak_targets");
				level.var_9f073b4 = 0;
				level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
				level.players[0] thread namespace_73e1c3e3::function_61c3d59c(#"hash_2e3f0f83040d38d4", undefined);
				level.players[0] waittill(#"killstreak_done");
				namespace_73e1c3e3::function_c2a10fc();
				a_ai_enemies = level.players[0] namespace_64a487a9::function_dde6edbd();
				n_alive = a_ai_enemies.size;
				wait(5);
				level.var_3a0d2784 = 0;
				level.players[0] val::reset("scorestreak_protect", "takedamage");
				var_3f21ce47 = level.players[0] namespace_64a487a9::function_dde6edbd();
				if(isdefined(var_3f21ce47) && var_3f21ce47.size <= n_alive * 0.5)
				{
					level flag::set("scorestreak_done");
					level.players[0] namespace_73e1c3e3::function_8881abec();
					level notify(#"stop_score_nag");
				}
				else
				{
					level flag::set("scorestreak_fail");
					level.players[0].pers[#"mortarradarused"] = 0;
				}
				namespace_73e1c3e3::function_9aca2fa0("ct_endgame");
				level flag::wait_till_any(array("scorestreak_fail", "scorestreak_done"));
				if(level flag::get("scorestreak_fail"))
				{
					level flag::clear("scorestreak_fail");
					level namespace_8c007aa6::play_vo(#"hash_bebb353e21b47f1", 1);
					level.players[0] namespace_73e1c3e3::function_1bb93418();
				}
				else if(level flag::get("scorestreak_done"))
				{
					break;
				}
			}
			namespace_73e1c3e3::function_c2a10fc();
		}
		wait(0.5);
		level.players[0] namespace_73e1c3e3::function_49e0c5bc(0);
		wait(1);
	}
}

/*
	Name: function_7f8a8489
	Namespace: namespace_58d68fd0
	Checksum: 0x4C79D4FF
	Offset: 0x6690
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_7f8a8489()
{
	setdvar(#"hash_3e06b14c41136e95", 0);
	namespace_d82263d5::function_350dd8ec(#"planemortar");
	setdvar(#"hash_3e06b14c41136e95", 1);
}

/*
	Name: function_667b9fbc
	Namespace: namespace_58d68fd0
	Checksum: 0x129EAAF6
	Offset: 0x6708
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function function_667b9fbc()
{
	var_79f49403 = killstreaks::get_killstreak_momentum_cost(self, #"planemortar");
	if(self.momentum < var_79f49403)
	{
		globallogic_score::_setplayermomentum(self, var_79f49403);
	}
}

/*
	Name: function_fcc78b2c
	Namespace: namespace_58d68fd0
	Checksum: 0xFAB999A4
	Offset: 0x6768
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_fcc78b2c()
{
	trigger::wait_till("trigger_mantis_barriers");
	namespace_73e1c3e3::function_e9ab1003("s_mantis_area");
	level notify(#"start_war_machine_mantis_collision");
	level notify(#"stop_war_machine_wall_bounce_collision");
	level notify(#"stop_war_machine_dock_sandwich_collision");
}

/*
	Name: function_aef4e53f
	Namespace: namespace_58d68fd0
	Checksum: 0x1570EEC5
	Offset: 0x67E8
	Size: 0x11C
	Parameters: 2
	Flags: None
*/
function function_aef4e53f(str_loc, n_wait)
{
	self endon(#"death");
	var_94c758f2 = struct::get_array(str_loc);
	for(i = 0; i < var_94c758f2.size; i++)
	{
		var_c361acde = namespace_cbd87dc5::function_4c8f915a(var_94c758f2[i].origin);
		if(isdefined(var_c361acde))
		{
			var_c361acde thread function_119c4576(var_94c758f2[i]);
			var_c361acde.maxhealth = 150;
			var_c361acde thread ai_tank::setup_gameplay_think("tank_robot");
			var_c361acde.overridevehicledamage = &function_2aab1550;
			level thread function_c8eefe3b(var_c361acde);
		}
		wait(n_wait);
	}
}

/*
	Name: function_c8eefe3b
	Namespace: namespace_58d68fd0
	Checksum: 0x1B655F59
	Offset: 0x6910
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function function_c8eefe3b(var_c361acde)
{
	level endon(#"combattraining_logic_finished");
	var_88706ea7 = undefined;
	var_88706ea7 = var_c361acde waittill(#"death");
	if(var_88706ea7.attacker === level.players[0])
	{
		level.var_1bbf6bf1--;
		level.players[0] namespace_73e1c3e3::function_80bf685b(level.var_1bbf6bf1);
	}
}

/*
	Name: function_2aab1550
	Namespace: namespace_58d68fd0
	Checksum: 0x61934536
	Offset: 0x69B8
	Size: 0x9E
	Parameters: 15
	Flags: None
*/
function function_2aab1550(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(eattacker) && eattacker == self)
	{
		return 0;
	}
	return idamage;
}

/*
	Name: function_119c4576
	Namespace: namespace_58d68fd0
	Checksum: 0x9C2DEC8A
	Offset: 0x6A60
	Size: 0x108
	Parameters: 1
	Flags: None
*/
function function_119c4576(s_loc)
{
	self endon(#"death");
	s_goal = struct::get(s_loc.target);
	self setgoal(s_goal.origin, 1);
	wait(0.2);
	self clientfield::set("enemy_vehicle_keyline_render", 1);
	wait(3);
	while(true)
	{
		if(isalive(level.players[0]))
		{
			self setgoal(level.players[0]);
		}
		wait(randomfloatrange(2, 3));
	}
}

/*
	Name: function_d0bcce1
	Namespace: namespace_58d68fd0
	Checksum: 0x45BE8964
	Offset: 0x6B70
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function function_d0bcce1(n_index)
{
	self endon(#"death");
	level endon(#"combattraining_logic_finished");
	while(true)
	{
		b_all_dead = 1;
		var_13dd1b4f = getaiteamarray(#"axis");
		foreach(var_c361acde in var_13dd1b4f)
		{
			if(isalive(var_c361acde))
			{
				b_all_dead = 0;
			}
		}
		if(b_all_dead)
		{
			break;
		}
		wait(0.1);
	}
	wait(1);
	level flag::set("mantis_dead_" + n_index);
}

/*
	Name: function_20263b9e
	Namespace: namespace_58d68fd0
	Checksum: 0x44AD93A5
	Offset: 0x6CB0
	Size: 0x66
	Parameters: 1
	Flags: None
*/
function function_20263b9e(params)
{
	grenade = params.projectile;
	self notify(#"hash_25cbcadbbeb229d8", {#e_grenade:grenade, #v_pos:grenade.origin});
}

/*
	Name: function_ae3fa0e0
	Namespace: namespace_58d68fd0
	Checksum: 0xF645B24C
	Offset: 0x6D20
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function function_ae3fa0e0()
{
	level endon(#"combattraining_logic_finished");
	self thread function_5346b39d();
	while(isalive(self))
	{
		var_2cad1fb5 = self.origin;
		waitframe(1);
	}
	if(isdefined(level.var_146b6c))
	{
		n_dist = distance(var_2cad1fb5, level.var_146b6c);
		if(n_dist < level.var_32564e34)
		{
			level notify(#"hash_3635e0f04dfda961");
			level.var_146b6c = undefined;
		}
	}
}

/*
	Name: function_5346b39d
	Namespace: namespace_58d68fd0
	Checksum: 0xA4B2794E
	Offset: 0x6E00
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function function_5346b39d()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"stuck_to_player");
	level notify(#"hash_791dd53f2a2f4a6", {#grenade:self, #player:waitresult.player});
}

/*
	Name: function_58c62280
	Namespace: namespace_58d68fd0
	Checksum: 0xC3FB9388
	Offset: 0x6E88
	Size: 0x69C
	Parameters: 2
	Flags: None
*/
function function_58c62280(var_ce4a5fc7, var_d04c7daa)
{
	s_loc = level.var_66b3c127[level.var_9f073b4];
	level.var_9f073b4++;
	if(level.var_9f073b4 >= level.var_66b3c127.size)
	{
		level.var_9f073b4 = 0;
	}
	self endon(#"death");
	if(isdefined(var_d04c7daa) && var_d04c7daa)
	{
		self val::set(#"hash_505a4c7da62f0c37", "ignoreall", 1);
	}
	if(isdefined(var_ce4a5fc7) && var_ce4a5fc7)
	{
		self thread function_25dcfd55();
	}
	self namespace_73e1c3e3::function_61d750d4(s_loc.origin, s_loc.angles);
	self.overrideplayerdamage = &function_6fb4cde7;
	if(isdefined(var_d04c7daa) && var_d04c7daa)
	{
		if(level.var_ad7c0539 != 4 && level.var_ad7c0539 != 6 && level.var_ad7c0539 != 7)
		{
			self thread namespace_73e1c3e3::function_5b59f3b7(s_loc.origin, s_loc.angles, 32);
		}
		self setlowready(1);
	}
	if(isdefined(s_loc.script_noteworthy))
	{
		if(s_loc.script_noteworthy === "assault")
		{
			self thread function_fdf5f193(s_loc);
		}
		else if(s_loc.script_noteworthy === "pistol")
		{
			s_goal = struct::get(s_loc.target);
			self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 32);
			self val::reset(#"hash_505a4c7da62f0c37", "ignoreall");
		}
	}
	wait(0.1);
	if(isdefined(s_loc.script_noteworthy))
	{
		if(s_loc.script_noteworthy == "sticky_grenade_target")
		{
			self thread function_8670e3b1(s_loc);
		}
		else if(s_loc.script_noteworthy == "grenade_room")
		{
			self thread function_c4d7c637(s_loc);
		}
	}
	if(level.var_ad7c0539 == 2 || level.var_ad7c0539 == 3)
	{
		self thread function_f9803d74();
	}
	else if(level.var_ad7c0539 === 5)
	{
		if(s_loc.script_noteworthy === "war_machine_victim")
		{
			self.ignoreall = 1;
			self.targetname = "war_machine_victim";
			self thread function_f9803d74();
			self thread function_a40b5f9c();
		}
	}
	else if(level.var_ad7c0539 === 6)
	{
		if(s_loc.script_noteworthy === "war_machine_aoe_pair")
		{
			self.ignoreme = 0;
			self.ignoreall = 0;
			self thread function_f9803d74();
			s_goal = struct::get(s_loc.target);
			self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 8);
			if(isdefined(s_goal.script_noteworthy))
			{
				self waittill(#"goal");
				self namespace_9c817acd::crouch();
			}
		}
		else
		{
			self.ignoreme = 0;
			self.ignoreall = 0;
			self thread function_f9803d74();
			s_goal = struct::get(s_loc.target);
			self thread namespace_73e1c3e3::function_1e7b75f2(s_goal);
		}
	}
	else if(level.var_ad7c0539 === 7)
	{
		self thread function_f9803d74();
		self thread function_35ea89f8(s_loc);
	}
	else if(level.var_ad7c0539 === 8)
	{
		s_goal = struct::get(s_loc.target);
		self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 16);
	}
	else if(level.var_ad7c0539 === 10)
	{
		if(s_loc.script_noteworthy === "scorestreak_target")
		{
			self thread function_f9803d74();
			s_goal = struct::get(s_loc.target);
			self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 32);
		}
		else
		{
			self.ignoreme = 0;
			self.ignoreall = 0;
			self thread function_f9803d74();
			self thread function_61e49657(s_loc);
			self namespace_73e1c3e3::function_b5e31ad(level.players[0], 150, 250);
		}
	}
}

/*
	Name: function_f9803d74
	Namespace: namespace_58d68fd0
	Checksum: 0xEF9CC911
	Offset: 0x7530
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_f9803d74()
{
	if(math::cointoss())
	{
		self thread namespace_64a487a9::function_35e77034(getweapon(#"ar_accurate_t8"), 1);
	}
	else
	{
		self thread namespace_64a487a9::function_35e77034(getweapon(#"smg_accurate_t8"), 1);
	}
}

/*
	Name: function_25dcfd55
	Namespace: namespace_58d68fd0
	Checksum: 0x6FBAE0A4
	Offset: 0x75C0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_25dcfd55()
{
	self endon(#"death");
	wait(0.1);
	self clientfield::set("enemy_keyline_render", 1);
}

/*
	Name: function_a40b5f9c
	Namespace: namespace_58d68fd0
	Checksum: 0xDB36D449
	Offset: 0x7610
	Size: 0x17E
	Parameters: 0
	Flags: None
*/
function function_a40b5f9c()
{
	self endon(#"death");
	self thread function_807b6bac();
	var_5168e40f = 0;
	wait(3);
	while(true)
	{
		if(isalive(level.players[0]) && !level.players[0] util::is_player_looking_at(self getcentroid(), 0.7) && !var_5168e40f)
		{
			level.waypoint = namespace_73e1c3e3::create_waypoint(#"hash_4c8740a012a13b31", self.origin + vectorscale((0, 0, 1), 32), self.angles + vectorscale((0, 1, 0), 90), #"any", undefined, 20, undefined);
			var_5168e40f = 1;
		}
		else if(var_5168e40f)
		{
			var_5168e40f = 0;
			if(isdefined(level.waypoint))
			{
				level.waypoint namespace_73e1c3e3::function_f9ed304d();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_807b6bac
	Namespace: namespace_58d68fd0
	Checksum: 0xA207DF21
	Offset: 0x7798
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_807b6bac()
{
	self waittill(#"death");
	if(isdefined(level.waypoint))
	{
		level.waypoint namespace_73e1c3e3::function_f9ed304d();
	}
}

/*
	Name: function_35ea89f8
	Namespace: namespace_58d68fd0
	Checksum: 0x36D71860
	Offset: 0x77E8
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function function_35ea89f8(s_loc)
{
	self endon(#"death");
	self thread function_c1c7228f();
	self thread namespace_64a487a9::function_35e77034(getweapon(#"ar_accurate_t8"), 1);
	self setmovespeedscale(0.35);
	s_goal = struct::get(s_loc.target);
	self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 32);
	level flag::wait_till("enemy_arrived");
	self setmovespeedscale(1);
	self setlowready(0);
	self val::reset(#"hash_505a4c7da62f0c37", "ignoreall");
	self namespace_73e1c3e3::function_4caeacf6();
}

/*
	Name: function_c1c7228f
	Namespace: namespace_58d68fd0
	Checksum: 0x59903E13
	Offset: 0x7968
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_c1c7228f()
{
	self endon(#"death", #"enemy_arrived");
	trigger::wait_till("trigger_enemy_patrol_arrive");
	level flag::set("enemy_arrived");
	wait(2.5);
	level namespace_8c007aa6::play_vo(#"hash_6d25f9768578adff", 1);
}

/*
	Name: function_c4d7c637
	Namespace: namespace_58d68fd0
	Checksum: 0xCB2E1C13
	Offset: 0x7A08
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_c4d7c637(s_loc)
{
	self endon(#"death");
	s_goal = struct::get(s_loc.target);
	level flag::wait_till("grenade_room");
	self setlowready(0);
	wait(s_loc.script_wait);
	self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 32);
}

/*
	Name: function_fdf5f193
	Namespace: namespace_58d68fd0
	Checksum: 0xFB5AABDE
	Offset: 0x7AD0
	Size: 0x170
	Parameters: 1
	Flags: None
*/
function function_fdf5f193(s_loc)
{
	self endon(#"death");
	s_target = struct::get("fake_target_ship");
	s_goal = struct::get(s_loc.target);
	self thread namespace_73e1c3e3::function_5b59f3b7(s_goal.origin, s_goal.angles, 32);
	self thread namespace_64a487a9::function_35e77034(getweapon(#"ar_accurate_t8"), 1);
	self val::set(#"hash_505a4c7da62f0c37", "ignoreall", 1);
	wait(4);
	while(isalive(self))
	{
		self bot::function_b78e1ebf();
		wait(randomfloatrange(0.1, 0.3));
	}
}

/*
	Name: function_8670e3b1
	Namespace: namespace_58d68fd0
	Checksum: 0xB4B395AC
	Offset: 0x7C48
	Size: 0x286
	Parameters: 1
	Flags: None
*/
function function_8670e3b1(s_loc)
{
	self endon(#"death");
	level.var_a600ce76 = 1;
	s_goal = struct::get(s_loc.target);
	self setlowready(1);
	self thread function_d91a23c7();
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_791dd53f2a2f4a6");
		e_player = waitresult.player;
		e_grenade = waitresult.grenade;
		if(e_player == self)
		{
			level flag::set("grenade_stick");
			level.var_e72728b8 = array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun");
			break;
		}
	}
	var_3f21ce47 = level.players[0] namespace_64a487a9::function_dde6edbd();
	foreach(bot in var_3f21ce47)
	{
		bot setlowready(0);
	}
	level.var_a600ce76 = 0;
	e_grenade resetmissiledetonationtime(1.5);
	s_loc = struct::get("sticky_run_goal");
	self thread namespace_73e1c3e3::function_5b59f3b7(s_loc.origin, s_loc.angles, 32);
	self notify(#"hash_53dc7cff4c3c5f5c");
	self notify(#"hash_140ce23fccc7b0c");
}

/*
	Name: function_d91a23c7
	Namespace: namespace_58d68fd0
	Checksum: 0x5515CA9D
	Offset: 0x7ED8
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function function_d91a23c7()
{
	self waittill(#"death");
	if(!level flag::get("grenade_stick"))
	{
		level flag::set("reset_sticky");
		namespace_73e1c3e3::function_c561377e(0, 1);
		return;
	}
	wait(0.1);
	var_3f21ce47 = level.players[0] namespace_64a487a9::function_dde6edbd();
	foreach(bot in var_3f21ce47)
	{
		if(isalive(bot))
		{
			bot dodamage(bot.health + 100, bot.origin);
		}
	}
}

/*
	Name: function_8486a84b
	Namespace: namespace_58d68fd0
	Checksum: 0x610A2A28
	Offset: 0x8030
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function function_8486a84b()
{
	self endon(#"death", #"hash_526132995cf20df8");
	if(level.var_ad7c0539 === 10)
	{
		return;
	}
	var_9bc826aa = getweapon(#"hero_pineapplegun");
	while(true)
	{
		w_current = self getcurrentweapon();
		if(w_current == var_9bc826aa)
		{
			n_ammo = self getweaponammoclip(w_current);
			if(n_ammo == 1)
			{
				self setweaponammoclip(w_current, var_333fa936);
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_b6f2e73d
	Namespace: namespace_58d68fd0
	Checksum: 0x8BE69155
	Offset: 0x8148
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_b6f2e73d(s_loc)
{
	self endon(#"death");
	level endon(#"grenade_rock");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(weapon == getweapon(#"eq_cluster_semtex_grenade"))
		{
			grenade thread function_cc0d0e8f(s_loc);
		}
	}
}

/*
	Name: function_ba2e9281
	Namespace: namespace_58d68fd0
	Checksum: 0x8D2D5BCC
	Offset: 0x8220
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_ba2e9281(waypoint)
{
	self endon(#"death");
	level flag::wait_till("grenade_rock");
	if(isdefined(waypoint))
	{
		waypoint namespace_73e1c3e3::function_f9ed304d();
	}
}

/*
	Name: function_cc0d0e8f
	Namespace: namespace_58d68fd0
	Checksum: 0x2759694C
	Offset: 0x8288
	Size: 0x184
	Parameters: 1
	Flags: None
*/
function function_cc0d0e8f(s_loc)
{
	self endon(#"death");
	self waittill(#"stationary");
	n_dist = distance(self.origin, s_loc.origin);
	if(n_dist < 45)
	{
		level flag::set("grenade_rock");
		level notify(#"stop_target_nag");
		level.var_e72728b8 = array(#"eq_cluster_semtex_grenade", #"hero_pineapplegun");
		namespace_8c007aa6::function_3ca1b77d();
		level.players[0] namespace_8c007aa6::play_vo(#"hash_652da27d15a2fbe3", 1);
	}
	else
	{
		namespace_8c007aa6::function_3ca1b77d();
		if(!namespace_8c007aa6::function_5d127774())
		{
			level.players[0] namespace_8c007aa6::play_vo(#"hash_34021a82d739daed", 1);
		}
	}
}

/*
	Name: function_fcfbe225
	Namespace: namespace_58d68fd0
	Checksum: 0xAFD3DB52
	Offset: 0x8418
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_fcfbe225()
{
	level endon(#"combattraining_logic_finished");
	wait(0.25);
	level namespace_8c007aa6::play_vo(#"hash_652da17d15a2fa30", 1);
}

/*
	Name: function_abd58b32
	Namespace: namespace_58d68fd0
	Checksum: 0x9AE06842
	Offset: 0x8470
	Size: 0x168
	Parameters: 0
	Flags: None
*/
function function_abd58b32()
{
	level endon(#"hash_342ec88b8ca82286");
	self endon(#"death");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_6dd8907f24c397a9"), "stop_grenade_nag");
	while(true)
	{
		waitresult = undefined;
		waitresult = level.players[0] waittill(#"grenade_fire");
		level notify(#"stop_grenade_nag");
		wait(1);
		if(!level flag::get("grenade_stick") && !namespace_8c007aa6::function_5d127774() && waitresult.weapon === getweapon(#"eq_cluster_semtex_grenade"))
		{
			level.players[0] namespace_8c007aa6::play_vo(#"hash_6dd8907f24c397a9", 1);
		}
	}
}

/*
	Name: function_5e9629d8
	Namespace: namespace_58d68fd0
	Checksum: 0x696E1554
	Offset: 0x85E0
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function function_5e9629d8(waypoint)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(weapon == getweapon(#"eq_cluster_semtex_grenade"))
		{
			grenade thread function_3c7e2151(var_fae5f77, waypoint);
		}
	}
}

/*
	Name: function_3c7e2151
	Namespace: namespace_58d68fd0
	Checksum: 0x1E80A7E1
	Offset: 0x86D8
	Size: 0x184
	Parameters: 2
	Flags: None
*/
function function_3c7e2151(var_fae5f77, waypoint)
{
	level endon(#"grenade_room_explode");
	level.players[0] endon(#"death");
	self waittill(#"death", #"stationary");
	if(isdefined(self) && self istouching(var_fae5f77))
	{
		if(isdefined(waypoint))
		{
			waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		level flag::set("grenade_room");
		level notify(#"stop_room_nag");
		self waittill(#"explode");
		level flag::set("grenade_room_explode");
		return;
	}
	else if(!namespace_8c007aa6::function_5d127774() && !level flag::get("grenade_room"))
	{
		level.players[0] namespace_8c007aa6::play_vo(#"hash_34021a82d739daed", 1);
	}
}

/*
	Name: function_7810b056
	Namespace: namespace_58d68fd0
	Checksum: 0x20190FBB
	Offset: 0x8868
	Size: 0x1E0
	Parameters: 0
	Flags: None
*/
function function_7810b056()
{
	self endon(#"death");
	trigger::wait_till("trigger_grenade_room");
	level notify(#"start_grenade_room_collision");
	level notify(#"start_grenade_room_swim_collision");
	level thread namespace_8c007aa6::play_vo(#"hash_56aeede2ec363647", 0);
	level.var_66b3c127 = struct::get_array("s_battery_clear_room_soldiers", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
	namespace_8c007aa6::function_3ca1b77d();
	level flag::wait_till("grenade_room_explode");
	wait(1.5);
	var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
	foreach(bot in var_3f21ce47)
	{
		bot dodamage(bot.health + 100, bot.origin, self, undefined, undefined, "MOD_GRENADE_SPLASH");
	}
}

/*
	Name: function_2fb096bf
	Namespace: namespace_58d68fd0
	Checksum: 0x74B48D0A
	Offset: 0x8A50
	Size: 0x198
	Parameters: 0
	Flags: None
*/
function function_2fb096bf()
{
	self endon(#"death");
	level notify(#"start_grenade_room_collision");
	level notify(#"start_grenade_room_swim_collision");
	level.var_66b3c127 = struct::get_array("s_battery_clear_room_soldiers", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_66b3c127.size, #"axis");
	level flag::wait_till("grenade_room_explode");
	wait(1.5);
	var_3f21ce47 = namespace_64a487a9::function_fbe3dcbb();
	foreach(bot in var_3f21ce47)
	{
		bot dodamage(bot.health + 100, bot.origin, self, undefined, undefined, "MOD_GRENADE_SPLASH");
	}
}

/*
	Name: function_ad548822
	Namespace: namespace_58d68fd0
	Checksum: 0x3A3F1437
	Offset: 0x8BF0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_ad548822()
{
	level namespace_8c007aa6::play_vo(#"hash_4a3faa14d1ccc52f");
}

/*
	Name: function_31bf458c
	Namespace: namespace_58d68fd0
	Checksum: 0x8BCD4854
	Offset: 0x8C20
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_31bf458c(waypoint)
{
	self endon(#"death");
	level endon(#"boat_enemies_dead");
	namespace_73e1c3e3::function_654280be();
	if(isdefined(waypoint))
	{
		waypoint namespace_73e1c3e3::function_f9ed304d();
	}
	wait(1);
	level flag::set("boat_enemies_dead");
}

/*
	Name: function_45f567b0
	Namespace: namespace_58d68fd0
	Checksum: 0xEB1EA0A6
	Offset: 0x8CB8
	Size: 0x208
	Parameters: 2
	Flags: None
*/
function function_45f567b0(s_loc, waypoint)
{
	self endon(#"death");
	level endon(#"boat_enemies_dead");
	while(true)
	{
		waitresult = undefined;
		waitresult = level.players[0] waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		level notify(#"stop_cover_nag");
		if(weapon != getweapon(#"eq_cluster_semtex_grenade"))
		{
			continue;
		}
		var_88706ea7 = undefined;
		var_88706ea7 = grenade waittill(#"explode", #"death", #"stationary");
		if(isdefined(grenade))
		{
			n_dist = distance(grenade.origin, s_loc.origin);
			if(n_dist < 40)
			{
				if(isdefined(waypoint))
				{
					waypoint namespace_73e1c3e3::function_f9ed304d();
				}
				grenade waittill(#"explode");
				level thread function_ac588971();
				break;
			}
		}
		else if(!namespace_8c007aa6::function_5d127774())
		{
			level.players[0] namespace_8c007aa6::play_vo(#"hash_34021a82d739daed", 1);
		}
	}
}

/*
	Name: function_ac588971
	Namespace: namespace_58d68fd0
	Checksum: 0xF49DDF75
	Offset: 0x8EC8
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_ac588971()
{
	level endon(#"boat_enemies_dead");
	var_3f21ce47 = level.players[0] namespace_64a487a9::function_dde6edbd();
	foreach(bot in var_3f21ce47)
	{
		bot dodamage(bot.health + 100, bot.origin, level.players[0], undefined, undefined, "MOD_GRENADE_SPLASH");
	}
	level flag::set("boat_enemies_dead");
}

/*
	Name: function_232a26ae
	Namespace: namespace_58d68fd0
	Checksum: 0x4B7F155C
	Offset: 0x8FE0
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function function_232a26ae()
{
	self endon(#"death");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_7a2f183f7483bbe2"), "stop_nag");
	while(!self isplayerswimming())
	{
		wait(0.5);
	}
	self thread function_88761fc8();
	level notify(#"stop_nag");
	wait(1);
	level.players[0] namespace_8c007aa6::play_vo(#"hash_281161c4a36c9f83", 1);
}

/*
	Name: function_88761fc8
	Namespace: namespace_58d68fd0
	Checksum: 0x3B2CC618
	Offset: 0x90D0
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_88761fc8()
{
	self endon(#"death");
	level endon(#"swim_done");
	while(true)
	{
		if(self isplayerswimming() && level.ct_shared_warning ct_shared_warning::is_open(self))
		{
			self namespace_73e1c3e3::function_f272fff4();
			wait(0.1);
		}
		waitframe(1);
	}
}

/*
	Name: function_c35855fd
	Namespace: namespace_58d68fd0
	Checksum: 0x5CF1D045
	Offset: 0x9168
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_c35855fd(n_index)
{
	self endon(#"death");
	level endon(#"player_died");
	namespace_73e1c3e3::function_654280be();
	wait(1);
	level flag::set("dock_cleared_" + n_index);
}

/*
	Name: function_4f228e34
	Namespace: namespace_58d68fd0
	Checksum: 0x18111414
	Offset: 0x91E8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_4f228e34()
{
	self endon(#"death");
	level endon(#"hash_1ed85b84698bdac7");
	namespace_73e1c3e3::function_654280be();
	wait(1);
	level flag::set("patrol_dead");
}

/*
	Name: function_f47cc92a
	Namespace: namespace_58d68fd0
	Checksum: 0x22CCBE2F
	Offset: 0x9258
	Size: 0x90
	Parameters: 0
	Flags: None
*/
function function_f47cc92a()
{
	level endon(#"patrol_dead", #"wall_target_hit");
	self endon(#"death");
	level flag::wait_till("enemy_arrived");
	level.var_54c1ce00 = level.var_32ae304;
	level.var_32ae304 = undefined;
	level notify(#"stop_war_machine_wall_bounce_forward_collision");
}

/*
	Name: function_2804d387
	Namespace: namespace_58d68fd0
	Checksum: 0x15EEB8CD
	Offset: 0x92F0
	Size: 0x78
	Parameters: 0
	Flags: None
*/
function function_2804d387()
{
	self endon(#"death");
	while(true)
	{
		t_trig = trigger::wait_till("trigger_window_barriers");
		if(t_trig.who === self)
		{
			level notify(#"start_war_machine_arc_window_collision");
			break;
		}
	}
}

/*
	Name: function_76f5d2dc
	Namespace: namespace_58d68fd0
	Checksum: 0x2B9BE91E
	Offset: 0x9370
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function function_76f5d2dc(str_s_target)
{
	level endon(#"enemy_arrived");
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = level.players[0] waittill(#"hash_25cbcadbbeb229d8");
		n_dist = distance(s_loc.origin, waitresult.v_pos);
		if(n_dist <= 20)
		{
			level flag::set("wall_target_hit");
			self thread function_abc3a00d();
			break;
		}
	}
}

/*
	Name: function_8e12a34
	Namespace: namespace_58d68fd0
	Checksum: 0x451328EA
	Offset: 0x9490
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_8e12a34(waypoint)
{
	self endon(#"death");
	level flag::wait_till_any(array("wall_target_hit", "enemy_arrived", "patrol_dead"));
	if(isdefined(waypoint))
	{
		waypoint namespace_73e1c3e3::function_f9ed304d();
	}
}

/*
	Name: function_abc3a00d
	Namespace: namespace_58d68fd0
	Checksum: 0xFFE639EA
	Offset: 0x9518
	Size: 0x150
	Parameters: 0
	Flags: None
*/
function function_abc3a00d()
{
	level endon(#"combattraining_logic_finished");
	self endon(#"death");
	wait(0.25);
	var_3f21ce47 = self namespace_64a487a9::function_dde6edbd();
	foreach(bot in var_3f21ce47)
	{
		bot dodamage(bot.health + 100, bot.origin + (0, -100, 40), self, undefined, undefined, "MOD_EXPLOSIVE", 0, getweapon(#"hero_pineapplegun"));
		if(isalive(bot))
		{
			bot kill();
		}
	}
}

/*
	Name: function_8cff7e18
	Namespace: namespace_58d68fd0
	Checksum: 0x1B237127
	Offset: 0x9670
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function function_8cff7e18()
{
	self endon(#"death");
	level flag::wait_till("window_hit");
	self function_abc3a00d();
}

/*
	Name: function_cc38079e
	Namespace: namespace_58d68fd0
	Checksum: 0xC3643859
	Offset: 0x96C8
	Size: 0x88
	Parameters: 0
	Flags: None
*/
function function_cc38079e()
{
	self endon(#"death");
	level endon(#"window_hit");
	while(!level flag::get("window_hit"))
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_25cbcadbbeb229d8");
		waitresult.e_grenade thread function_e7a8d041();
	}
}

/*
	Name: function_e7a8d041
	Namespace: namespace_58d68fd0
	Checksum: 0x98281F78
	Offset: 0x9758
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_e7a8d041()
{
	level.players[0] endon(#"death");
	self endon(#"death", #"explode");
	level endon(#"window_hit");
	while(true)
	{
		if(self istouching(var_e5784d10))
		{
			level flag::set("window_hit");
		}
		waitframe(1);
	}
}

/*
	Name: function_f06e9a28
	Namespace: namespace_58d68fd0
	Checksum: 0x9FD01323
	Offset: 0x9830
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_f06e9a28()
{
	var_13dd1b4f = getaiteamarray(#"axis");
	foreach(var_c361acde in var_13dd1b4f)
	{
		if(isdefined(var_c361acde))
		{
			var_c361acde delete();
		}
	}
}

/*
	Name: function_5a67767d
	Namespace: namespace_58d68fd0
	Checksum: 0x8DF36ECB
	Offset: 0x98E0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_5a67767d(v_org)
{
	e_player = namespace_73e1c3e3::get_player();
	if(isdefined(e_player))
	{
		v_to_player = e_player.origin - v_org;
		var_13bbc909 = vectortoangles(v_to_player);
		playfx("player/fx8_plyr_spawn_distortion", v_org, anglestoforward(var_13bbc909), anglestoup(var_13bbc909));
	}
}

/*
	Name: function_61e49657
	Namespace: namespace_58d68fd0
	Checksum: 0x662AE34B
	Offset: 0x9998
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function function_61e49657(s_loc)
{
	level endon(#"scorestreak_done");
	self waittill(#"death");
	wait(randomfloatrange(0.5, 1.5));
	if(!level flag::get("stop_reinforce"))
	{
		if(level flag::get("scorestreak_done"))
		{
			return;
		}
		level.var_72c3ea74 = array(s_loc);
		level.var_da5432a2 = 0;
		namespace_64a487a9::function_4d9cfd95(level.var_72c3ea74.size, #"axis");
	}
}

