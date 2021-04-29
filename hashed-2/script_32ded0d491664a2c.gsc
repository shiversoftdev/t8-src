// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_18fb8ad2a13d96b;
#using script_2255a7ad3edc838f;
#using script_2ca4b414b146b498;
#using script_3819e7a1427df6d2;
#using script_383a3b1bb18ba876;
#using script_3b7405881c081f6;
#using script_3f27a7b2232674db;
#using script_490759cf62a1abc8;
#using script_5b092d41f1ecae8a;
#using script_61826ca279ffa0;
#using script_6c8abe14025b47c4;
#using script_788472602edbe3b9;
#using script_7dd6557e89e9840b;
#using script_bb99a1f9be8d0a7;
#using script_bc6a9a35c229565;
#using script_ee56e8b680377b6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace namespace_2885895d;

/*
	Name: init
	Namespace: namespace_2885895d
	Checksum: 0x3361A6F6
	Offset: 0x12B8
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function init()
{
	level.var_29a4ccd4 = 10;
	level.var_7b05c4b5 = 0;
	level.var_ae120f18 = array(#"hash_13ff54f31624000a");
	callback::add_callback(#"hash_42aa89b2a0951308", &function_cd74cce0);
	level flag::init("killstreak_earned");
	level flag::init("mission_complete");
	var_88546af8 = soundgetplaybacktime(#"hash_6923615495bbfbcf");
	level.var_53f396c6 = var_88546af8 * 0.05 / 1000;
	/#
		level thread function_421135df();
	#/
}

/*
	Name: function_c9ff0dce
	Namespace: namespace_2885895d
	Checksum: 0x26A8AB13
	Offset: 0x13E0
	Size: 0x392
	Parameters: 0
	Flags: None
*/
function function_c9ff0dce()
{
	if(self.team == #"allies")
	{
		self.overrideplayerdamage = &function_6fb4cde7;
		self namespace_73e1c3e3::function_876eadbc();
		self thread function_523dd7be();
		if(isdefined(level.var_ad7c0539))
		{
			if(level.var_ad7c0539 >= 6)
			{
				var_bcd1c2ff = self namespace_d82263d5::function_fe5bfd29(#"hash_4bb2d7f789b561eb");
				self.var_f3d589a1[var_bcd1c2ff] = 3;
			}
			switch(level.var_ad7c0539)
			{
				case 6:
				case 9:
				case 10:
				{
					self thread namespace_64a487a9::function_fd2d220e();
					break;
				}
				case 8:
				{
					setdvar(#"hash_3fb2952874e511c2", #"hash_5811622173a6e63a");
					break;
				}
				default:
				{
					self thread namespace_64a487a9::function_aa870283(0, 1, 1, 1);
					break;
				}
			}
			waitframe(1);
			namespace_73e1c3e3::function_8f04870f();
		}
	}
	else if(self.team == #"axis")
	{
		if(isdefined(level.var_7b46025))
		{
			switch(level.var_ad7c0539)
			{
				case 5:
				case 7:
				{
					self thread function_4150d677(32, 1, 0, 0);
					break;
				}
				case 6:
				{
					self thread function_4150d677(800, 0, 0, 0);
					break;
				}
				case 8:
				{
					self thread function_4150d677(32, 1, 0, 0);
					level.var_6b1458ad = self;
					break;
				}
				case 9:
				{
					self thread namespace_73e1c3e3::function_5149c890(1, 0.1);
					self thread function_4150d677(400, 0, 1, 0);
					break;
				}
				case 10:
				{
					self thread namespace_73e1c3e3::function_5149c890(1, 0.1);
					self thread function_4150d677(100, 0, 0, 0);
					break;
				}
				case 11:
				{
					self thread function_17ab2327();
					break;
				}
			}
		}
	}
}

/*
	Name: function_6fb4cde7
	Namespace: namespace_2885895d
	Checksum: 0x89B3851C
	Offset: 0x1780
	Size: 0x1C8
	Parameters: 11
	Flags: None
*/
function function_6fb4cde7(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, n_psoffsettime, var_8b69d5cf)
{
	if(!isdefined(level.var_ad7c0539))
	{
		return n_damage;
	}
	if(!isbot(self))
	{
		if(isdefined(level.var_e70f7774) && level.var_e70f7774)
		{
			self.health = self.health + 1;
			n_damage = 1;
		}
		switch(level.var_ad7c0539)
		{
			case 6:
			{
				if(isdefined(e_attacker) && isbot(e_attacker))
				{
					n_damage = n_damage * 0.75;
				}
				break;
			}
			case 9:
			{
				n_damage = n_damage * 0.5;
				break;
			}
		}
	}
	if(isdefined(level.var_eb5015e6) && level.var_eb5015e6)
	{
		if(isdefined(weapon) && (weapon.name == #"hash_4bb2d7f789b561eb" || weapon.name == #"hash_6a54f2cec31d71b"))
		{
			return n_damage;
		}
		self.health++;
		return 0;
	}
	return n_damage;
}

/*
	Name: function_72ba0df6
	Namespace: namespace_2885895d
	Checksum: 0xC8F97E9B
	Offset: 0x1950
	Size: 0x12C
	Parameters: 9
	Flags: None
*/
function function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	self.var_6b6241ac = self.origin;
	self.var_45cac770 = self.angles;
	if(self.team == #"axis")
	{
		if(level.var_ad7c0539 === 10)
		{
			e_player = namespace_73e1c3e3::get_player();
			if(isalive(e_player) && e_player killstreaks::get_killstreak_quantity(getweapon(#"remote_missile")) == 0)
			{
				e_player namespace_73e1c3e3::function_80bf685b(e_player.momentum);
			}
		}
	}
}

/*
	Name: function_9b9525e9
	Namespace: namespace_2885895d
	Checksum: 0x6B4C46A9
	Offset: 0x1A88
	Size: 0x764
	Parameters: 0
	Flags: None
*/
function function_9b9525e9()
{
	level endon(#"combattraining_logic_finished");
	if(!isdefined(level.var_9863df4b))
	{
		level.var_9863df4b = level.var_228e8cd6;
		level.var_228e8cd6 = &function_228e8cd6;
	}
	level.allowspecialistdialog = 0;
	level.var_e6db911d = 1;
	level.var_e70f7774 = undefined;
	level thread namespace_73e1c3e3::function_9ab507a9("beginning_area_collision", "start_beginning_area_collision", "stop_beginning_area_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("beginning_area_ajax_collision", "start_beginning_area_ajax_collision", "stop_beginning_area_ajax_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("beginning_area_collision_exit_door", "start_beginning_area_collision_exit_door", "stop_beginning_area_collision_exit_door", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("beginning_part2_area_collision", "start_beginning_part2_area_collision", "stop_beginning_part2_area_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_fail_collision", "start_grapple_fail_collision", "stop_grapple_fail_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_fail_door_collision", "start_grapple_fail_door_collision", "stop_grapple_fail_door_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_fail_door2_collision", "start_grapple_fail_door2_collision", "stop_grapple_fail_door2_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_ledgel_collision", "start_grapple_ledgel_collision", "stop_grapple_ledgel_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_ledgel_door_collision", "start_grapple_ledgel_door_collision", "stop_grapple_ledgel_door_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_ledgel_exit_collision", "start_grapple_ledgel_exit_collision", "stop_grapple_ledgel_exit_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_high_ledge_collision", "start_grapple_high_ledge_collision", "stop_grapple_high_ledge_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_high_ledge2_collision", "start_grapple_high_ledge2_collision", "stop_grapple_high_ledge2_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("grapple_fail_complete_collision", "start_grapple_fail_complete_collision", "stop_grapple_fail_complete_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("ajax_area_door_collision", "start_ajax_area_door_collision", "stop_ajax_area_door_complete_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("ajax_area_collision", "start_ajax_area_collision", "stop_ajax_area_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("ajax_area_back_collision", "start_ajax_area_back_collision", "stop_ajax_area_back_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("earn_hellstorm_collision", "start_earn_hellstorm_collision", "stop_earn_hellstorm_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("earn_hellstorm_enter_collision", "start_earn_hellstorm_enter_collision", "stop_earn_hellstorm_enter_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("killstreak_collision", "start_killstreak_collision", "stop_killstreak_collision", undefined, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("permanent_collision", "start_permanent_collision", "stop_permanent_collision", undefined, 1, 0);
	level notify(#"start_permanent_collision");
	level.var_d4668c34 = 1;
	level thread namespace_d82263d5::function_c3e3d15();
	e_player = namespace_73e1c3e3::get_player();
	e_player namespace_64a487a9::function_26d45f32(1);
	level flag::clear("mission_complete");
	a_nodes = getnodearray("disable_node", "script_noteworthy");
	foreach(node in a_nodes)
	{
		setenablenode(node, 0);
	}
	level.var_ad7c0539 = 1;
	function_627221cf();
	level.var_ad7c0539 = 2;
	function_bc194310();
	level.var_ad7c0539 = 3;
	function_34a100e1();
	level.var_ad7c0539 = 4;
	function_d08e9d7f();
	level.var_ad7c0539 = 5;
	function_fecd2528();
	level.var_ad7c0539 = 6;
	function_baae9a51();
	level.var_ad7c0539 = 8;
	function_8678055f();
	level.var_ad7c0539 = 9;
	function_e340db61();
	level.var_ad7c0539 = 10;
	earn_the_hellstorm_objective();
	level.var_ad7c0539 = 11;
	function_bbdd4fa9();
	namespace_73e1c3e3::function_9f8be64a();
}

/*
	Name: function_627221cf
	Namespace: namespace_2885895d
	Checksum: 0x229D3739
	Offset: 0x21F8
	Size: 0x448
	Parameters: 0
	Flags: None
*/
function function_627221cf()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level notify(#"start_beginning_area_collision");
	level notify(#"start_beginning_area_ajax_collision");
	level notify(#"start_beginning_area_collision_exit_door");
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb", #"hash_3a19c6a9c8caef33");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_grapple_first"), 1);
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level thread namespace_8c007aa6::function_14b08e49(array(#"vox_tvoi_tutor_ruin_slide_3_nag"), "grapple_complete");
	var_cf79f45b = array(#"stop_beginning_area_collision", #"stop_beginning_area_ajax_collision", #"stop_beginning_area_collision_exit_door");
	var_112238a4 = array(#"start_beginning_area_collision", #"start_beginning_area_ajax_collision", #"start_beginning_area_collision_exit_door");
	function_53ef16ed("s_grapple_hook_start_target", var_cf79f45b, "start_beginning_part2_area_collision", var_112238a4, "vox_tvoi_tutor_ruin_slide_3_miss_nag", 80, #"hash_69584b2f0f4ad5ca");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_73e1c3e3::function_e9ab1003("s_high_grapple_loc");
	namespace_73e1c3e3::function_c2a10fc();
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb", #"hash_3a19c6a9c8caef33");
	waitframe(1);
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_grapple_ground"), 1);
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level thread namespace_8c007aa6::function_14b08e49(array(#"vox_tvoi_tutor_ruin_slide_3_nag"), "grapple_complete");
	function_53ef16ed("s_grapple_hook_ground_target", array(#"stop_beginning_part2_area_collision"), "start_beginning_area_collision", array("start_beginning_part2_area_collision"), "vox_tvoi_tutor_ruin_slide_3_miss_nag", 150, #"hash_708c1ff90fbb88bd");
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
	level notify(#"start_grapple_fail_door_collision");
	namespace_8c007aa6::function_831e0584(array(#"hash_da9bc97f42c491f"));
	wait(0.1);
	namespace_8c007aa6::function_3ca1b77d();
	level notify(#"start_beginning_area_collision");
	level notify(#"start_beginning_area_ajax_collision");
	wait(0.1);
}

/*
	Name: function_53ef16ed
	Namespace: namespace_2885895d
	Checksum: 0xF46459EE
	Offset: 0x2648
	Size: 0x272
	Parameters: 7
	Flags: None
*/
function function_53ef16ed(var_b6acc0c9, var_5563d1e7, var_8b1294a8, var_20d50849, var_4dc9e63c, var_6ff1bf88, str_objective)
{
	level endon(#"combattraining_logic_finished");
	if(isdefined(str_objective))
	{
		e_player = getplayers()[0];
		e_player thread namespace_73e1c3e3::function_61c3d59c(str_objective, undefined);
	}
	while(true)
	{
		s_loc = struct::get(var_b6acc0c9, "targetname");
		b_success = namespace_73e1c3e3::function_15e01238(s_loc, var_6ff1bf88, 35, var_5563d1e7, 1);
		if(b_success)
		{
			level notify(#"grapple_complete");
			break;
		}
		else if(isdefined(var_4dc9e63c))
		{
			level thread namespace_8c007aa6::function_831e0584(array(var_4dc9e63c));
		}
		namespace_73e1c3e3::function_a61ebb46((function_8b1a219a() ? #"hash_43778cd6dfd4c233" : #"hash_142e78a1bcbd104d"));
		namespace_73e1c3e3::function_79957328(undefined);
		if(isdefined(str_objective))
		{
			e_player = getplayers()[0];
			e_player thread namespace_73e1c3e3::function_61c3d59c(str_objective, undefined);
		}
		if(isdefined(var_20d50849))
		{
			foreach(str_notify in var_20d50849)
			{
				level notify(str_notify);
			}
		}
	}
	if(isdefined(var_8b1294a8))
	{
		wait(0.3);
		level notify(var_8b1294a8);
	}
}

/*
	Name: function_bc194310
	Namespace: namespace_2885895d
	Checksum: 0x4AFB6E19
	Offset: 0x28C8
	Size: 0x5A0
	Parameters: 0
	Flags: None
*/
function function_bc194310()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003();
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_4256405c5f6bfc9e"), "stop_nag");
	namespace_73e1c3e3::function_e0d36a2c(#"hash_1140443e1b7ab267", "s_grapple_fail_obj", array(#"hash_4bb2d7f789b561eb"), 0, undefined, 35);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_grapple_fail_obj");
	level notify(#"start_grapple_fail_collision");
	var_3608d414 = array("vox_tvoi_tutor_ruin_slide_3_nag");
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_61e22ffdad8a6ee4", var_3608d414);
	waitframe(1);
	s_loc = struct::get("s_grapple_hook_dist_fail", "targetname");
	level thread namespace_73e1c3e3::function_c444a920(s_loc, 35);
	level.var_464c2ccd = 1;
	level thread function_cc2f8b4();
	level thread namespace_8c007aa6::function_14b08e49(array(#"vox_tvoi_tutor_ruin_slide_3_nag"), "grapple_fail_complete");
	level thread namespace_73e1c3e3::function_821edb7e("grapple_fail_complete");
	while(true)
	{
		if(isdefined(level.var_7deb7684) && level.var_7deb7684)
		{
			level.var_7deb7684 = undefined;
			level notify(#"stop_grapple_fail_collision");
			level notify(#"stop_grapple_fail_door_collision");
			level waittill(#"hash_48e959cf81e020f3");
			level notify(#"start_grapple_fail_collision");
			level notify(#"start_grapple_fail_door_collision");
			level thread namespace_8c007aa6::function_831e0584(array(#"vox_tvoi_tutor_ruin_slide_3_miss_nag"));
			var_d21ccff6 = 1;
			while(true)
			{
				e_player = getplayers()[0];
				if(!isalive(e_player))
				{
					while(true)
					{
						e_player = getplayers()[0];
						if(isalive(e_player))
						{
							var_d21ccff6 = 0;
							break;
						}
						waitframe(1);
					}
				}
				n_time = gettime() / 1000;
				dt = n_time - n_start_time;
				if(dt > 1.5)
				{
					break;
				}
				waitframe(1);
			}
			namespace_73e1c3e3::function_a61ebb46((function_8b1a219a() ? #"hash_71cd040e856d2d69" : #"hash_4e50694e1653efaf"));
			if(var_d21ccff6)
			{
				namespace_73e1c3e3::function_79957328();
			}
			level thread namespace_73e1c3e3::function_821edb7e("grapple_fail_complete");
		}
		else if(isdefined(level.var_9d2a5e6d) && level.var_9d2a5e6d)
		{
			level.var_9d2a5e6d = undefined;
			e_player = getplayers()[0];
			v_dir = vectornormalize(s_loc.origin - e_player.origin);
			v_forward = anglestoforward(e_player.angles);
			dp = vectordot(v_dir, v_forward);
			if(dp > 0.96)
			{
				break;
			}
		}
		waitframe(1);
	}
	level.var_20fb90aa = 1;
	namespace_73e1c3e3::function_c2a10fc();
	level notify(#"grapple_fail_complete");
	wait(0.4);
	level.var_464c2ccd = 0;
	wait(0.1);
}

/*
	Name: function_cc2f8b4
	Namespace: namespace_2885895d
	Checksum: 0xA5626973
	Offset: 0x2E70
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function function_cc2f8b4()
{
	level endon(#"combattraining_logic_finished", #"grapple_fail_complete");
	while(true)
	{
		e_player = getplayers()[0];
		waitresult = undefined;
		waitresult = e_player waittill(#"hash_7550ae00cd28adcb");
		level.var_9d2a5e6d = 1;
	}
}

/*
	Name: function_34a100e1
	Namespace: namespace_2885895d
	Checksum: 0x1ECAF350
	Offset: 0x2F18
	Size: 0x228
	Parameters: 0
	Flags: None
*/
function function_34a100e1()
{
	level endon(#"combattraining_logic_finished");
	level notify(#"stop_grapple_fail_door_collision");
	level notify(#"start_grapple_ledgel_collision");
	namespace_73e1c3e3::function_e9ab1003("s_grapple_start_ledge_respawn_pos");
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level thread function_6eaaed7b();
	level thread function_8d8bad52();
	level thread function_af9bb307();
	level notify(#"start_grapple_fail_complete_collision");
	level notify(#"start_grapple_fail_door_collision");
	function_53ef16ed("s_grapple_hook_dist_fail", undefined, undefined, undefined, #"vox_tvoi_tutor_ruin_slide_3_miss_nag", 250, undefined);
	level notify(#"hash_7923e27639ea0134");
	level notify(#"start_grapple_fail_door2_collision");
	level notify(#"stop_grapple_ledgel_collision");
	level notify(#"stop_grapple_fail_collision");
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
	level notify(#"start_grapple_ledgel_exit_collision");
	level.var_801f2e81 = 1;
	wait(0.1);
	level.var_801f2e81 = undefined;
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_da9bb97f42c476c"), 1);
	level notify(#"stop_grapple_ledgel_exit_collision");
}

/*
	Name: function_af9bb307
	Namespace: namespace_2885895d
	Checksum: 0xF980D4B6
	Offset: 0x3148
	Size: 0x334
	Parameters: 0
	Flags: None
*/
function function_af9bb307()
{
	level endon(#"combattraining_logic_finished");
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_46099ddc56532a3", undefined);
	s_loc = struct::get("s_grapple_available_loc", "targetname");
	var_56b89658 = 3;
	while(!(isdefined(level.var_801f2e81) && level.var_801f2e81))
	{
		if(isdefined(level.var_97aaa7c6) && level.var_97aaa7c6)
		{
			while(isdefined(level.var_97aaa7c6) && level.var_97aaa7c6)
			{
				waitframe(1);
			}
			wait(1.5);
		}
		e_player = getplayers()[0];
		if(e_player isgrappling())
		{
			break;
		}
		v_forward = anglestoforward(s_loc.angles);
		v_dir = vectornormalize(s_loc.origin - e_player.origin);
		dp = vectordot(v_forward, v_dir);
		if(dp > 0 && var_56b89658 != 0)
		{
			e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_46099ddc56532a3", undefined);
			var_56b89658 = 0;
		}
		else if(dp <= 0)
		{
			if(!vo_played)
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_5ce2ded871c29779"), 1);
				vo_played = 1;
			}
			var_a447797f = e_player fragbuttonpressed();
			if(var_56b89658 != 1 && var_a447797f)
			{
				var_56b89658 = 1;
				e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_64a5750e28b0dafd", undefined);
			}
			else if(var_56b89658 != 2 && !var_a447797f)
			{
				var_56b89658 = 2;
				e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_f4e5967478f35b7", undefined);
			}
		}
		waitframe(1);
	}
	namespace_73e1c3e3::function_c2a10fc();
}

/*
	Name: function_8d8bad52
	Namespace: namespace_2885895d
	Checksum: 0x5248119E
	Offset: 0x3488
	Size: 0x226
	Parameters: 0
	Flags: None
*/
function function_8d8bad52()
{
	level endon(#"combattraining_logic_finished", #"hash_7923e27639ea0134");
	var_6ee32682 = gettime() / 1000;
	level.var_3a8650d5 = 0;
	n_start_time = gettime() / 1000;
	var_c6f9dd1f = gettime() / 1000;
	while(true)
	{
		if(isdefined(level.b_player_in_range) && level.b_player_in_range)
		{
			break;
		}
		n_time = gettime() / 1000;
		var_965b7e01 = n_time - n_start_time;
		e_player = getplayers()[0];
		if(e_player fragbuttonpressed())
		{
			if(!var_2d3e1b92)
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_6923605495bbfa1c"));
				var_2d3e1b92 = 1;
			}
			level.var_3a8650d5 = 1;
			var_c6f9dd1f = n_time;
		}
		else
		{
			level.var_3a8650d5 = 0;
		}
		if(!namespace_8c007aa6::function_5d127774() && var_965b7e01 > 3)
		{
			dt = n_time - var_c6f9dd1f;
			if(dt > 20)
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_4256405c5f6bfc9e"), 1);
				var_c6f9dd1f = n_time;
			}
		}
		waitframe(1);
	}
	level.var_3a8650d5 = 0;
	level.b_player_in_range = undefined;
}

/*
	Name: function_6eaaed7b
	Namespace: namespace_2885895d
	Checksum: 0x20E29894
	Offset: 0x36B8
	Size: 0x1F0
	Parameters: 0
	Flags: None
*/
function function_6eaaed7b()
{
	level endon(#"combattraining_logic_finished");
	var_f2bddc06 = 1;
	level notify(#"start_grapple_ledgel_door_collision");
	while(!(isdefined(level.var_801f2e81) && level.var_801f2e81))
	{
		e_player = getplayers()[0];
		if(!isalive(e_player))
		{
			while(true)
			{
				e_player = getplayers()[0];
				if(isalive(e_player))
				{
					break;
				}
				waitframe(1);
			}
		}
		if(!(isdefined(level.b_player_in_range) && level.b_player_in_range))
		{
			if(isdefined(level.var_3a8650d5) && level.var_3a8650d5 || e_player isgrappling() && var_f2bddc06)
			{
				level notify(#"stop_grapple_ledgel_door_collision");
				var_f2bddc06 = 0;
			}
			else if(!(isdefined(level.var_3a8650d5) && level.var_3a8650d5) && !var_f2bddc06 && !e_player isgrappling())
			{
				level notify(#"start_grapple_ledgel_door_collision");
				var_f2bddc06 = 1;
			}
		}
		waitframe(1);
	}
	if(var_f2bddc06)
	{
		level notify(#"stop_grapple_ledgel_door_collision");
	}
}

/*
	Name: function_acfa05d1
	Namespace: namespace_2885895d
	Checksum: 0xAC9EF160
	Offset: 0x38B0
	Size: 0x23E
	Parameters: 1
	Flags: None
*/
function function_acfa05d1(var_4b28bc8)
{
	level endon(#"combattraining_logic_finished");
	s_target = struct::get("s_grapple_hook_dist_fail", "targetname");
	while(!(isdefined(level.var_801f2e81) && level.var_801f2e81))
	{
		e_player = getplayers()[0];
		v_forward = anglestoforward(var_4b28bc8.angles);
		v_dir = vectornormalize(var_4b28bc8.origin - e_player.origin);
		dp = vectordot(v_forward, v_dir);
		if(dp < 0)
		{
			if(isdefined(level.var_3a8650d5) && level.var_3a8650d5)
			{
				v_dir = vectornormalize(s_target.origin - e_player.origin);
				v_forward = anglestoforward(e_player.angles);
				dp = vectordot(v_dir, v_forward);
				if(dp > 0.9)
				{
					level.b_player_in_range = 1;
					if(!b_played_vo)
					{
						while(namespace_8c007aa6::function_5d127774())
						{
							waitframe(1);
						}
						b_played_vo = 1;
						level thread namespace_8c007aa6::function_831e0584(array(#"hash_5ce2ded871c29779"), 1);
					}
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_d08e9d7f
	Namespace: namespace_2885895d
	Checksum: 0xB37EC0F0
	Offset: 0x3AF8
	Size: 0x502
	Parameters: 0
	Flags: None
*/
function function_d08e9d7f()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003();
	level notify(#"start_grapple_high_ledge_collision");
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(array(#"s_grapple_hook_chasm_start_1_obj"), "s_grapple_hook_chasm_start_1_obj", array(#"hash_4bb2d7f789b561eb"), 0, undefined, 35);
	level notify(#"stop_nag");
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_da9be97f42c4c85"), 1);
	namespace_73e1c3e3::function_e9ab1003("s_grapple_hook_chasm_start_1_obj");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_grapple_hook_chasm_start_2_obj", array(#"hash_4bb2d7f789b561eb"), 0, undefined, 25);
	level notify(#"stop_nag");
	level notify(#"stop_grapple_fail_complete_collision");
	level notify(#"start_grapple_high_ledge2_collision");
	namespace_73e1c3e3::function_e9ab1003("s_grapple_hook_chasm_start_2_obj");
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_da9bd97f42c4ad2"), 1);
	level thread namespace_8c007aa6::function_5172b052(#"hash_6f4e6b000c475a08", "stop_nag");
	while(true)
	{
		e_player = getplayers()[0];
		e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_1a96b4c95e637091", undefined);
		level thread function_c4629797();
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
		s_loc = struct::get("s_grapple_hook_chasm_end_obj", "targetname");
		b_success = namespace_73e1c3e3::function_15e01238(s_loc, 150, 50, undefined, 1);
		if(b_success)
		{
			namespace_73e1c3e3::function_e9ab1003("s_grapple_hook_chasm_end_obj");
			break;
		}
		level notify(#"stop_nag");
		namespace_73e1c3e3::function_e9ab1003("s_grapple_hook_chasm_start_2_obj");
		namespace_73e1c3e3::function_79957328();
		namespace_73e1c3e3::function_a61ebb46((function_8b1a219a() ? #"hash_43778cd6dfd4c233" : #"hash_142e78a1bcbd104d"));
	}
	level notify(#"stop_nag");
	level notify(#"hash_c6d4041766f9315");
	level notify(#"start_grapple_ledgel_collision");
	level notify(#"stop_grapple_high_ledge_collision");
	level notify(#"start_grapple_ledgel_door_collision");
	level notify(#"start_grapple_fail_complete_collision");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
}

/*
	Name: function_c4629797
	Namespace: namespace_2885895d
	Checksum: 0xBCE96522
	Offset: 0x4008
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_c4629797()
{
	level endon(#"combattraining_logic_finished", #"hash_c6d4041766f9315");
	level.var_8d109684 = undefined;
	while(true)
	{
		e_player = getplayers()[0];
		if(e_player istouching(var_f5552ee9))
		{
			if(e_player isgrappling())
			{
				level.var_8d109684 = undefined;
				return;
			}
			level.var_8d109684 = 1;
			wait(0.1);
			level notify(#"hash_48e959cf81e020f3");
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_fecd2528
	Namespace: namespace_2885895d
	Checksum: 0x128D9CA5
	Offset: 0x4120
	Size: 0x3F0
	Parameters: 0
	Flags: None
*/
function function_fecd2528()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003("s_grapple_hook_chasm_end_obj");
	namespace_8c007aa6::function_831e0584(array(#"hash_2559f228a22744de"), 1);
	level notify(#"stop_grapple_fail_door_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_grav_slam_start", array(#"hash_4bb2d7f789b561eb"), 1, undefined, 40);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_grav_slam_start");
	level.var_e72728b8 = array(#"hash_3a19c6a9c8caef33");
	level notify(#"start_beginning_area_collision");
	level notify(#"start_beginning_area_ajax_collision");
	level notify(#"start_grapple_fail_door_collision");
	level notify(#"stop_grapple_ledgel_door_collision");
	level.var_7b46025 = struct::get_array("s_ruin_grav_slam_dude_loc", "targetname");
	level.var_47cd3e56 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
	wait(2);
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	namespace_8c007aa6::function_831e0584(array(#"hash_2559f328a2274691"), 1);
	level.var_eb5015e6 = 1;
	e_player = getplayers()[0];
	var_8e5c536e = (function_8b1a219a() ? #"hash_75c2aca845270377" : #"hash_4fb346435e061201");
	e_player thread namespace_73e1c3e3::function_61c3d59c(var_8e5c536e, undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_7e4f395a02d8ed35"), "grav_slam_complete");
	namespace_73e1c3e3::function_654280be();
	level notify(#"grav_slam_complete");
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	level.var_eb5015e6 = undefined;
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array(#"hash_1222e3a3c005f251"));
	level.var_e72728b8 = undefined;
	wait(0.1);
}

/*
	Name: function_baae9a51
	Namespace: namespace_2885895d
	Checksum: 0xCB02E59A
	Offset: 0x4518
	Size: 0x72A
	Parameters: 0
	Flags: None
*/
function function_baae9a51()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003("s_grav_slam_start");
	e_player = getplayers()[0];
	var_bcd1c2ff = e_player namespace_d82263d5::function_fe5bfd29(#"hash_4bb2d7f789b561eb");
	e_player.var_f3d589a1[var_bcd1c2ff] = 3;
	level.var_d4668c34 = undefined;
	level.var_209e2e90 = [];
	var_94c758f2 = struct::get_array("s_ruin_spawn_beacon_loc", "targetname");
	foreach(s_loc in var_94c758f2)
	{
		e_beacon = spawn("script_model", s_loc.origin);
		e_beacon setmodel("wpn_t8_eqp_spawnbeacon_world");
		e_beacon clientfield::set("animate_spawn_beacon", 1);
		e_beacon setcandamage(1);
		e_beacon.health = 400;
		e_beacon.team = #"axis";
		e_beacon thread function_ffdd31e0();
		e_beacon.s_loc = s_loc;
		level.var_209e2e90[level.var_209e2e90.size] = e_beacon;
	}
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillSpawnBeacons");
	e_player namespace_73e1c3e3::function_80bf685b(2);
	namespace_8c007aa6::function_831e0584(array(#"hash_1222e2a3c005f09e", #"hash_1222e1a3c005eeeb"), 1);
	level notify(#"hash_4c9c5fbc89779e64");
	level.var_e72728b8 = undefined;
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	e_player namespace_64a487a9::function_fd2d220e();
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_3c9d4e83f2a8c9cd"), "stop_nag");
	level thread function_96e7c232();
	while(level.var_209e2e90.size > 0)
	{
		if(level.var_209e2e90.size == 1)
		{
			e_player namespace_73e1c3e3::function_80bf685b(1);
		}
		e_player = getplayers()[0];
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		if(var_3f21ce47.size < 5)
		{
			if(var_24593a52 >= level.var_209e2e90.size)
			{
				var_24593a52 = 0;
			}
			e_beacon = level.var_209e2e90[var_24593a52];
			var_24593a52++;
			if(var_24593a52 >= level.var_209e2e90.size)
			{
				var_24593a52 = 0;
			}
			a_locs = struct::get_array(e_beacon.s_loc.target);
			a_locs = array::randomize(a_locs);
			level.var_7b46025 = array(a_locs[0]);
			level.var_47cd3e56 = 0;
			level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
			wait(randomfloatrange(1, 2));
		}
		waitframe(1);
	}
	level notify(#"stop_nag");
	e_player namespace_73e1c3e3::function_80bf685b(0);
	wait(2.5);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_299761fcf7f3a316", undefined);
	namespace_73e1c3e3::function_654280be();
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	while(true)
	{
		weapon = e_player getcurrentweapon();
		if(!(isdefined(weapon) && weapon.name == #"none"))
		{
			level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
			wait(0.1);
			break;
		}
		waitframe(1);
	}
	setdvar(#"hash_3fb2952874e511c2", #"hash_5811622173a6e63a");
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	e_player namespace_d82263d5::function_b81240c1();
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_625ae794a1d19842"), 0);
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
}

/*
	Name: function_96e7c232
	Namespace: namespace_2885895d
	Checksum: 0x9733DD31
	Offset: 0x4C50
	Size: 0x1B6
	Parameters: 0
	Flags: None
*/
function function_96e7c232()
{
	level endon(#"combattraining_logic_finished");
	while(!b_vo_played)
	{
		foreach(beacon in level.var_209e2e90)
		{
			e_player = getplayers()[0];
			n_dist = distance(e_player.origin, beacon.origin);
			if(n_dist < 700)
			{
				v_dir = vectornormalize(e_player.origin - beacon.origin);
				v_pos = beacon.origin + v_dir * 50;
				if(e_player namespace_73e1c3e3::can_see(v_pos, 1))
				{
					wait(1);
					namespace_8c007aa6::function_831e0584(array(#"hash_490033933ad1f12f"));
					b_vo_played = 1;
					break;
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_ffdd31e0
	Namespace: namespace_2885895d
	Checksum: 0x3F697EC0
	Offset: 0x4E10
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function function_ffdd31e0()
{
	self waittill(#"death");
	arrayremovevalue(level.var_209e2e90, self);
	level thread function_364de682(self.origin);
	self delete();
}

/*
	Name: function_364de682
	Namespace: namespace_2885895d
	Checksum: 0x8FB001D1
	Offset: 0x4E88
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_364de682(v_origin)
{
	playfx(#"explosions/fx_exp_robot_stage3_evb", v_origin);
	if(level.var_209e2e90.size == 1)
	{
		level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_1bd285662c47cf8d"));
	}
	else if(level.var_209e2e90.size == 0)
	{
		level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_145cdf2b6c7929f7"));
	}
}

/*
	Name: function_8678055f
	Namespace: namespace_2885895d
	Checksum: 0x6D73B050
	Offset: 0x4F50
	Size: 0xACA
	Parameters: 0
	Flags: None
*/
function function_8678055f()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003();
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level notify(#"start_ajax_area_back_collision");
	level notify(#"stop_beginning_area_ajax_collision");
	level notify(#"start_ajax_area_collision");
	var_d1eb86be = 0;
	while(var_dbddceb5 == 0)
	{
		var_9e9cfef1 = level.var_7cab580;
		level.var_7cab580 = 2;
		if(!isalive(level.var_6b1458ad))
		{
			level.var_7b46025 = struct::get_array("s_ruin_enemy_ajax_spawn_loc", "targetname");
			level.var_47cd3e56 = 0;
			var_3d11a5cb = namespace_73e1c3e3::function_d153452e(#"hash_3e52518ec3ffd40d");
			level thread namespace_64a487a9::function_263aa67d(#"axis", undefined, 0, var_3d11a5cb);
			level.var_6b1458ad notsolid();
			level.var_6b1458ad.var_b1fd680c = 1;
			level.var_6b1458ad thread function_1d1bfd1d(level.var_7b46025[0]);
			waitframe(1);
		}
		waitframe(1);
		level.var_6b1458ad namespace_9c817acd::stand();
		level.var_6b1458ad thread function_cf09b04d();
		level.var_eb5015e6 = 1;
		level.var_7cab580 = var_9e9cfef1;
		if(!(isdefined(var_d1eb86be) && var_d1eb86be))
		{
			level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
			var_3608d414 = array(#"hash_145cde2b6c792844");
			namespace_73e1c3e3::function_93c86846(var_3608d414, "s_grav_slam_ajax_obj", array(#"hash_4bb2d7f789b561eb"), undefined, undefined, 50);
			level notify(#"start_ajax_area_door_collision");
			level notify(#"stop_nag");
			namespace_8c007aa6::function_831e0584(array(#"hash_145ce12b6c792d5d", #"hash_145ce02b6c792baa"), 1);
			namespace_73e1c3e3::function_e9ab1003("s_ajax_player_respawn_loc");
		}
		namespace_8c007aa6::function_3ca1b77d();
		level thread namespace_8c007aa6::function_14b08e49(array(#"vox_tvoi_tutor_ruin_slide_3_nag"), "slam_started");
		e_player = getplayers()[0];
		e_player.var_657a47ca = undefined;
		level thread function_5de4ec62();
		var_3608d414 = array("vox_tvoi_tutor_ruin_slide_10_0", "vox_tvoi_tutor_ruin_slide_10_1", "vox_tvoi_tutor_ruin_slide_10_2");
		e_player = getplayers()[0];
		e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_2f23ec2a153dce52", var_3608d414);
		s_loc = struct::get("s_ruin_jump_over_ajax_obj", "targetname");
		waypoint = namespace_73e1c3e3::create_waypoint(#"hash_43f27b76957da4d2", s_loc.origin, s_loc.angles, #"any", undefined, 30, undefined);
		while(true)
		{
			e_player = getplayers()[0];
			if(e_player isgrappling())
			{
				level notify(#"stop_ajax_area_collision");
				e_player.var_5c88ac33 = undefined;
				level.var_5bed374e = undefined;
				v_dir = anglestoforward(e_player.angles);
				v_forward = vectornormalize(level.var_6b1458ad.origin - e_player.origin);
				dp = vectordot(v_dir, v_forward);
				if(dp < 0.9)
				{
					var_6a9e5fbd = 0;
				}
				break;
			}
			waitframe(1);
		}
		level notify(#"slam_started", var_6a9e5fbd);
		level.var_e72728b8 = undefined;
		e_player = getplayers()[0];
		var_bcd1c2ff = e_player namespace_d82263d5::function_fe5bfd29(#"hash_4bb2d7f789b561eb");
		level thread namespace_d82263d5::function_144e61da(var_bcd1c2ff, "stop_grav_slam_charge");
		var_5c76e8d = (e_player gamepadusedlast() ? #"hash_69996f3f10b734ca" : #"hash_94c2bd8b788ebca");
		e_player thread namespace_73e1c3e3::function_61c3d59c(var_5c76e8d, array(#"hash_73601b890c77f89c"));
		e_player = getplayers()[0];
		e_player thread function_5df282fc();
		n_start_time = gettime() / 1000;
		b_timeout = 0;
		level thread namespace_d82263d5::function_aedf2680();
		while(true)
		{
			if(isdefined(level.var_5bed374e) && level.var_5bed374e)
			{
				level.var_5bed374e = undefined;
				break;
			}
			if(!isalive(level.var_6b1458ad))
			{
				break;
			}
			n_time = gettime() / 1000;
			dt = n_time - n_start_time;
			if(dt > 4)
			{
				b_timeout = 1;
				break;
			}
			waitframe(1);
		}
		if(var_6a9e5fbd)
		{
			setslowmotion(1, 1, 0);
		}
		waypoint namespace_73e1c3e3::function_f9ed304d();
		level notify(#"stop_grav_slam_charge", var_6a9e5fbd);
		if(!b_timeout)
		{
			while(true)
			{
				n_time = gettime() / 1000;
				dt = n_time - n_start_time;
				if(dt > 1.6)
				{
					b_timeout = 1;
					break;
				}
				if(!isalive(level.var_6b1458ad))
				{
					break;
				}
				waitframe(1);
			}
		}
		e_player notify(#"hash_4e44b123804ed647");
		if(isdefined(b_timeout) && b_timeout)
		{
			level notify(#"start_ajax_area_collision");
			level thread namespace_8c007aa6::function_831e0584(array(#"hash_145ce02b6c792baa"), 1);
			var_582efb48 = (e_player gamepadusedlast() ? #"hash_46f0440233c88e09" : #"hash_308fca0b5c54c70f");
			namespace_73e1c3e3::function_a61ebb46(var_582efb48);
			level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
			namespace_73e1c3e3::function_79957328(undefined);
			namespace_8c007aa6::function_3ca1b77d();
			var_d1eb86be = 1;
		}
		else
		{
			namespace_73e1c3e3::function_c2a10fc();
			namespace_73e1c3e3::function_654280be();
			namespace_8c007aa6::function_41e59aeb(array(#"hash_4e33f0298dd7ed69"), 1);
			level.var_eb5015e6 = undefined;
			var_dbddceb5 = 1;
		}
	}
	level notify(#"hash_af88f301d383cc9");
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
}

/*
	Name: function_5de4ec62
	Namespace: namespace_2885895d
	Checksum: 0x6299F57A
	Offset: 0x5A28
	Size: 0x1EA
	Parameters: 0
	Flags: None
*/
function function_5de4ec62()
{
	level endon(#"combattraining_logic_finished");
	self notify("4192ae070f807dc6");
	self endon("4192ae070f807dc6");
	level endon(#"hash_af88f301d383cc9");
	level.var_5bed374e = undefined;
	e_player = getplayers()[0];
	e_player endon(#"death");
	while(true)
	{
		e_player = getplayers()[0];
		if(isalive(e_player) && e_player isgrappling())
		{
			break;
		}
		waitframe(1);
	}
	while(true)
	{
		e_player = getplayers()[0];
		if(isdefined(e_player.var_657a47ca) && (e_player.var_657a47ca == #"hash_4bb2d7f789b561eb" || e_player.var_657a47ca == #"hash_6a54f2cec31d71b"))
		{
			break;
		}
		if(isdefined(e_player.var_c70a4cbc) && e_player.var_c70a4cbc)
		{
			break;
		}
		if(!e_player isgrappling())
		{
			break;
		}
		if(isdefined(e_player.var_5c88ac33) && e_player.var_5c88ac33)
		{
			e_player.var_5c88ac33 = undefined;
			break;
		}
		waitframe(1);
	}
	level.var_5bed374e = 1;
}

/*
	Name: function_1d1bfd1d
	Namespace: namespace_2885895d
	Checksum: 0x4E7A580D
	Offset: 0x5C20
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function function_1d1bfd1d(s_loc)
{
	self endon(#"death");
	while(true)
	{
		self setplayerangles(s_loc.angles);
		waitframe(1);
	}
}

/*
	Name: function_cf09b04d
	Namespace: namespace_2885895d
	Checksum: 0xC92BF73F
	Offset: 0x5C78
	Size: 0x1EE
	Parameters: 0
	Flags: None
*/
function function_cf09b04d()
{
	self endon(#"death");
	self notify("52d7ee70f32ef8e3");
	self endon("52d7ee70f32ef8e3");
	var_d766cb31 = getweapon(#"sig_buckler_dw");
	var_1addc95c = getweapon(#"hash_17f9f60ce4ea5074");
	var_5a984899 = getweapon(#"sig_buckler_turret");
	if(!level.var_6b1458ad hasweapon(var_d766cb31))
	{
		self bot::function_35e77034(var_d766cb31);
		waitframe(1);
		self giveweapon(var_1addc95c);
		self giveweapon(var_5a984899);
		while(!level.var_6b1458ad hasweapon(var_d766cb31))
		{
			waitframe(1);
		}
	}
	self seteverhadweaponall(1);
	var_bcd1c2ff = self gadgetgetslot(var_d766cb31);
	self thread bot_action::function_ee2eaccc(var_bcd1c2ff);
	wait(1);
	while(true)
	{
		if(self gadgetpowerget(var_bcd1c2ff) < 10)
		{
			self gadgetpowerset(var_bcd1c2ff, 100);
		}
		waitframe(1);
	}
}

/*
	Name: function_5df282fc
	Namespace: namespace_2885895d
	Checksum: 0xCCC1D955
	Offset: 0x5E70
	Size: 0x46
	Parameters: 0
	Flags: None
*/
function function_5df282fc()
{
	self endon(#"hash_4e44b123804ed647", #"death");
	self waittill(#"grapple_cancel");
	self.var_5c88ac33 = 1;
}

/*
	Name: function_e340db61
	Namespace: namespace_2885895d
	Checksum: 0xC36D17C6
	Offset: 0x5EC0
	Size: 0x416
	Parameters: 0
	Flags: None
*/
function function_e340db61()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003();
	level.var_e72728b8 = undefined;
	level.var_6dc9075f = 0;
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2774943be9e5dbd9"), "stop_nag");
	e_player = namespace_73e1c3e3::get_player();
	e_player thread namespace_73e1c3e3::function_b375ee89("s_hellstorm_start_obj", undefined, 2);
	namespace_73e1c3e3::function_e0d36a2c(undefined, "s_hellstorm_start_obj", undefined, 0, undefined, 40);
	level notify(#"stop_nag");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_73e1c3e3::function_e9ab1003("s_hellstorm_start_obj");
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_1_hell_0"), 0);
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	namespace_8c007aa6::function_3ca1b77d();
	while(true)
	{
		e_player = namespace_73e1c3e3::get_player();
		setmatchflag("bomb_timer_a", 0);
		setbombtimer("A", 0);
		level thread function_3857a1fb();
		if(isdefined(b_first_time) && b_first_time)
		{
			e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_508f1a5bc110c570");
			namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_1_hell_1"), 1);
			e_player thread namespace_73e1c3e3::function_1bb93418();
		}
		level notify(#"hash_4c9c5fbc89779e64");
		b_first_time = 0;
		level.var_54c1ce00 = level.var_32ae304;
		level.var_32ae304 = undefined;
		level thread function_1c78b967();
		result = undefined;
		result = level waittill(#"hash_6308f4ed0b129e5d", #"dodge_the_hellstorm_objective_success");
		level.var_32ae304 = level.var_54c1ce00;
		if(result._notify == "dodge_the_hellstorm_objective_success")
		{
			break;
		}
		while(!isalive(e_player))
		{
			waitframe(1);
		}
		e_player val::set(#"hash_5d3a6408f6507701", "freezecontrols", 1);
		wait(1);
		e_player val::reset(#"hash_5d3a6408f6507701", "freezecontrols");
	}
	namespace_8c007aa6::function_3ca1b77d();
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	level thread namespace_73e1c3e3::function_c561377e();
	e_player thread namespace_64a487a9::function_26d45f32(1);
	level.var_6dc9075f = undefined;
}

/*
	Name: function_3857a1fb
	Namespace: namespace_2885895d
	Checksum: 0x25C2F024
	Offset: 0x62E0
	Size: 0x70
	Parameters: 0
	Flags: None
*/
function function_3857a1fb()
{
	level endon(#"combattraining_logic_finished");
	level endon_callback(&function_b57b281a, #"hash_56fb6ae4bbd573d9");
	level namespace_73e1c3e3::function_1a3c644e("s_hellstorm_end_obj");
	level notify(#"dodge_the_hellstorm_objective_success");
}

/*
	Name: function_b57b281a
	Namespace: namespace_2885895d
	Checksum: 0x839D0D78
	Offset: 0x6358
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_b57b281a(hash)
{
	e_player = namespace_73e1c3e3::get_player();
	e_player thread namespace_73e1c3e3::function_1bb93418();
}

/*
	Name: function_1c78b967
	Namespace: namespace_2885895d
	Checksum: 0x871FBB19
	Offset: 0x63A0
	Size: 0x5D0
	Parameters: 0
	Flags: None
*/
function function_1c78b967()
{
	level endon(#"combattraining_logic_finished");
	level endon_callback(&function_b8f40318, #"hash_6308f4ed0b129e5d", #"dodge_the_hellstorm_objective_success");
	e_player = namespace_73e1c3e3::get_player();
	e_player namespace_64a487a9::function_fd2d220e();
	setdvar(#"hash_3fb2952874e511c2", #"");
	starttime = gettime();
	var_806acf86 = starttime + int(16 * 1000);
	setmatchflag("bomb_timer_a", 1);
	setbombtimer("A", var_806acf86);
	level thread function_139e074b();
	wait(max(randomfloatrange(1.6, 2) - gettime() - starttime / 1000, 0));
	function_22720795("s_enemy_hardpoint_loc0");
	wait(max(randomfloatrange(3.6, 4) - gettime() - starttime / 1000, 0));
	function_22720795("s_enemy_hardpoint_loc1");
	wait(max(5 - gettime() - starttime / 1000, 0));
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_1_hell_5_sec"), 0);
	while(true)
	{
		var_f08fde43 = function_4c27be22("A");
		currenttime = gettime();
		if(currenttime >= var_f08fde43)
		{
			break;
		}
		if(!isalive(e_player))
		{
			break;
		}
		waitframe(1);
	}
	if(isalive(e_player))
	{
		targetpos = e_player.origin;
		startpos = targetpos + vectorscale((0, 0, 1), 1000);
		rocket = magicbullet(getweapon(#"remote_missile_missile"), startpos, targetpos);
		rocket.forceonemissile = 1;
		forceanglevector = vectornormalize(targetpos - startpos);
		rocket.angles = vectortoangles(forceanglevector);
		rocket missile_settarget(e_player);
		rocket.targetname = "remote_missile";
		rocket thread remotemissile::function_9761dd1d();
		rocket playsound("wpn_remote_missile_launch_npc");
		killstreak_detect::killstreaktargetset(rocket);
		magicbullet(getweapon(#"hash_33be4792feeabece"), rocket.origin, rocket.origin + anglestoforward(rocket.angles + vectorscale((1, 0, 0), 20)) * 1000, rocket.owner);
		magicbullet(getweapon(#"hash_33be4792feeabece"), rocket.origin, rocket.origin + anglestoforward(rocket.angles - vectorscale((1, 0, 0), 20)) * 1000, rocket.owner);
		e_player waittill_timeout(1, #"death");
	}
	level thread namespace_73e1c3e3::function_79957328(undefined);
	level thread namespace_73e1c3e3::function_c561377e(undefined);
	level notify(#"hash_56fb6ae4bbd573d9");
	level thread namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_1_hell_fail"), 0);
	level notify(#"hash_6308f4ed0b129e5d");
}

/*
	Name: function_139e074b
	Namespace: namespace_2885895d
	Checksum: 0xD2D7045D
	Offset: 0x6978
	Size: 0xD2
	Parameters: 0
	Flags: None
*/
function function_139e074b()
{
	level endon(#"combattraining_logic_finished");
	level endon(#"hash_6308f4ed0b129e5d", #"dodge_the_hellstorm_objective_success");
	e_player = namespace_73e1c3e3::get_player();
	e_player endon(#"death");
	while(true)
	{
		result = trigger::wait_till("s_enemy_trigger_loc2");
		if(result.who == e_player)
		{
			function_22720795("s_enemy_hardpoint_loc2");
			return;
		}
	}
}

/*
	Name: function_b8f40318
	Namespace: namespace_2885895d
	Checksum: 0x6E5DA318
	Offset: 0x6A58
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_b8f40318(hash)
{
	setbombtimer("A", 0);
	setmatchflag("bomb_timer_a", 0);
}

/*
	Name: earn_the_hellstorm_objective
	Namespace: namespace_2885895d
	Checksum: 0x4D394169
	Offset: 0x6AA0
	Size: 0x82E
	Parameters: 0
	Flags: None
*/
function earn_the_hellstorm_objective()
{
	level endon(#"combattraining_logic_finished");
	level notify(#"start_earn_hellstorm_collision");
	level notify(#"start_earn_hellstorm_enter_collision");
	level notify(#"start_killstreak_collision");
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_1_comp"), 1);
	namespace_73e1c3e3::function_e9ab1003("s_hellstorm_end_obj");
	namespace_73e1c3e3::function_e44c5b8e(#"remote_missile", 10);
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_0", "vox_tvoi_tutor_ruin_final_2_score_1"), 1);
	level thread namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_3"), 1);
	e_player = namespace_73e1c3e3::get_player();
	e_player namespace_64a487a9::function_fd2d220e();
	e_player thread function_e2a79d4();
	level.var_2b85d59c = 1;
	level.var_e6db911d = 0;
	level.var_d7003c6e = [];
	level.var_d7003c6e[level.var_d7003c6e.size] = struct::get("s_killstreak_path1", "targetname");
	level.var_d7003c6e[level.var_d7003c6e.size] = struct::get("s_killstreak_path2", "targetname");
	level.var_d7003c6e[level.var_d7003c6e.size] = struct::get("s_killstreak_path3", "targetname");
	level.var_d7003c6e[level.var_d7003c6e.size] = struct::get("s_killstreak_path4", "targetname");
	level.var_d7003c6e[level.var_d7003c6e.size] = struct::get("s_killstreak_path5", "targetname");
	level.var_6425ca79 = 0;
	level notify(#"stop_earn_hellstorm_enter_collision");
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(true)
	{
		namespace_73e1c3e3::function_fdfeb384();
		e_player namespace_73e1c3e3::function_8881abec();
		if(!level flag::get("killstreak_earned"))
		{
			globallogic_score::_setplayermomentum(e_player, 0);
			namespace_73e1c3e3::function_e44c5b8e(#"remote_missile", 10);
		}
		else
		{
			namespace_73e1c3e3::function_e44c5b8e(#"remote_missile", 0, 1);
			break;
		}
		callback::on_player_killed_with_params(&function_1f212110);
		level thread function_356af630();
		level.var_7b46025 = struct::get_array("s_enemy_event2", "targetname");
		level.var_47cd3e56 = 0;
		level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
		starttime = gettime();
		var_40b03ff = 61;
		var_806acf86 = starttime + int(var_40b03ff * 1000);
		setmatchflag("bomb_timer_a", 1);
		setbombtimer("A", var_806acf86);
		e_player namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillToEarnHellstorm");
		e_player namespace_73e1c3e3::function_80bf685b(e_player.momentum);
		level thread function_4d656f7f();
		var_ab60380 = "killstreak_quantity_" + #"remote_missile";
		result = undefined;
		result = e_player waittill_timeout(var_40b03ff, #"death", var_ab60380);
		level notify(#"hash_271b3e8ba24ae2e2");
		setbombtimer("A", 0);
		setmatchflag("bomb_timer_a", 0);
		e_player namespace_73e1c3e3::function_1bb93418();
		callback::function_e2ca0af6(&function_1f212110);
		if(result._notify == var_ab60380)
		{
			break;
		}
		else if(result._notify == "death")
		{
			level thread namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_dead"), 0);
		}
		else
		{
			level thread namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_fail"), 0);
			namespace_73e1c3e3::function_79957328(undefined);
		}
		level notify(#"earn_the_hellstorm_objective");
		level thread namespace_73e1c3e3::function_c561377e();
	}
	level.var_e72728b8 = array(#"hash_4bb2d7f789b561eb");
	level notify(#"earn_the_hellstorm_objective");
	level.var_e6db911d = 1;
	waitframe(1);
	level thread namespace_73e1c3e3::function_c561377e();
	level thread namespace_73e1c3e3::function_9aca2fa0("ct_action");
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_68aa241db4edd9fa", undefined);
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_comp"), 1);
	if(isalive(e_player))
	{
		e_player namespace_64a487a9::function_26d45f32(1);
	}
	level.var_2b85d59c = undefined;
}

/*
	Name: function_e2a79d4
	Namespace: namespace_2885895d
	Checksum: 0x148CDDCD
	Offset: 0x72D8
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_e2a79d4()
{
	self waittill("killstreak_quantity_" + #"remote_missile");
	level flag::set("killstreak_earned");
}

/*
	Name: function_4d656f7f
	Namespace: namespace_2885895d
	Checksum: 0xDCA55224
	Offset: 0x7328
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function function_4d656f7f()
{
	level endon(#"combattraining_logic_finished", #"hash_271b3e8ba24ae2e2");
	while(true)
	{
		e_player = getplayers()[0];
		if(isalive(e_player))
		{
			e_player namespace_73e1c3e3::function_80bf685b(e_player.momentum);
		}
		waitframe(1);
	}
}

/*
	Name: function_209f3386
	Namespace: namespace_2885895d
	Checksum: 0x72CA6876
	Offset: 0x73C0
	Size: 0xE8
	Parameters: 0
	Flags: None
*/
function function_209f3386()
{
	level endon(#"combattraining_logic_finished", #"earn_the_hellstorm_objective");
	e_player = namespace_73e1c3e3::get_player();
	kills = e_player.kills;
	while(true)
	{
		var_3f21ce47 = e_player namespace_64a487a9::function_dde6edbd();
		if(var_3f21ce47.size < 0.4 * var_a0aa3390)
		{
			function_22720795("s_enemy_event2");
		}
		wait(1);
	}
}

/*
	Name: function_ca1c7fce
	Namespace: namespace_2885895d
	Checksum: 0x5C9FE059
	Offset: 0x74B0
	Size: 0x6E
	Parameters: 1
	Flags: None
*/
function function_ca1c7fce(str_notify)
{
	level endon(#"combattraining_logic_finished");
	self notify("f2aafa1896996ce");
	self endon("f2aafa1896996ce");
	self endon(#"death");
	level waittill(str_notify);
	self notify(#"death");
}

/*
	Name: function_356af630
	Namespace: namespace_2885895d
	Checksum: 0x88874F9E
	Offset: 0x7528
	Size: 0x378
	Parameters: 0
	Flags: None
*/
function function_356af630()
{
	level endon(#"combattraining_logic_finished", #"earn_the_hellstorm_objective");
	e_player = namespace_73e1c3e3::get_player();
	wait(10);
	while(true)
	{
		otherteam = util::getotherteam(e_player.team);
		newpos = getclosestpointonnavmesh(e_player.origin + vectorscale((-1, -1, 0), 600), 800, 60);
		drone = spawnvehicle(#"hash_153a326c2357a196", newpos + vectorscale((0, 0, 1), 20), (0, 0, 0), "talon", undefined, 1);
		drone.vehicletype = #"hash_153a326c2357a196";
		ai_tank::function_9b13ebf(drone);
		drone.controlled = 0;
		drone.goalradius = 250;
		drone.numberrockets = 1;
		drone.warningshots = 1;
		drone.maxhealth = 200;
		drone makevehicleunusable();
		drone setdrawinfrared(1);
		drone setneargoalnotifydist(35);
		drone setteam(otherteam);
		drone setgoal(e_player);
		if(isdefined(level.var_1dd2fbe1))
		{
			drone [[level.var_1dd2fbe1]]();
		}
		drone vehicle::init_target_group();
		drone vehicle::add_to_target_group(drone);
		drone thread ai_tank::tank_too_far_from_nav_mesh_abort_think();
		drone thread ai_tank::tank_death_think("tank_robot");
		drone thread ai_tank::tank_damage_think();
		drone thread ai_tank::watchwater();
		aiutility::addaioverridedamagecallback(drone, &ai_tank::function_4f8d11b);
		drone thread function_ca1c7fce("earn_the_hellstorm_objective");
		drone waittill(#"death");
		params = {#weapon:e_player.currentweapon, #eattacker:e_player};
		drone function_1f212110(params);
		wait(5);
	}
}

/*
	Name: function_1f212110
	Namespace: namespace_2885895d
	Checksum: 0x502554D9
	Offset: 0x78A8
	Size: 0x23C
	Parameters: 1
	Flags: None
*/
function function_1f212110(params)
{
	eattacker = params.eattacker;
	weapon = params.weapon;
	if(isplayer(eattacker))
	{
		cost = killstreaks::get_killstreak_momentum_cost(eattacker, #"remote_missile");
		var_23efb519 = 10;
		var_595e41ee = 100;
		if(isvehicle(self))
		{
			var_595e41ee = 150;
		}
		event = #"ekia";
		eventindex = level.scoreinfo[event][#"row"];
		var_6a98b865 = eattacker.momentum;
		eattacker globallogic_score::giveplayermomentumnotification(var_595e41ee, #"hash_480234a872bd64ac", undefined, 0, weapon, 0, eventindex, event, undefined);
		if(eattacker.momentum >= cost * 0.6 && var_6a98b865 < cost * 0.6)
		{
			namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_success"), 0);
		}
		else if(eattacker.momentum >= cost * 0.3 && var_6a98b865 < cost * 0.3)
		{
			namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_2_score_success"), 0);
		}
		eattacker namespace_73e1c3e3::function_80bf685b(eattacker.momentum);
	}
}

/*
	Name: function_bbdd4fa9
	Namespace: namespace_2885895d
	Checksum: 0x7D76CE71
	Offset: 0x7AF0
	Size: 0x642
	Parameters: 0
	Flags: None
*/
function function_bbdd4fa9()
{
	level endon(#"combattraining_logic_finished");
	e_player = namespace_73e1c3e3::get_player();
	e_player namespace_73e1c3e3::function_fdfeb384();
	namespace_73e1c3e3::function_e9ab1003();
	var_6a58d9ed = killstreaks::get_killstreak_momentum_cost(e_player, #"remote_missile");
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	while(true)
	{
		level.play_taacom_dialog = level.var_bbd2b179;
		level.var_4b6a7a3a = 0;
		level.var_e891c5ba = 1;
		namespace_73e1c3e3::function_e44c5b8e(#"remote_missile", 0, 1);
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_44a0461092ffb316"), "stop_nag");
		kills = e_player.kills;
		setdvar(#"hash_3e06b14c41136e95", 0);
		var_b8d8ceed = e_player killstreaks::get_killstreak_quantity(getweapon(#"remote_missile"));
		if(var_b8d8ceed == 0)
		{
			weapon = getweapon(#"remote_missile");
			e_player killstreaks::change_killstreak_quantity(weapon, 1);
		}
		else
		{
			e_player killstreaks::add_to_notification_queue(killstreaks::get_menu_name(#"remote_missile"), var_b8d8ceed, #"remote_missile", undefined, 0);
		}
		var_f445a007 = (e_player gamepadusedlast() ? #"hash_5baa07d86c0f300a" : #"hash_3f9bcf3d2fe5da0a");
		e_player thread namespace_73e1c3e3::function_61c3d59c(var_f445a007);
		e_player waittill(#"remote_missile_fired");
		var_991a9552 = struct::get_array("s_player_hellstorm_safe", "targetname");
		s_player_hellstorm_safe = arraygetclosest(e_player.origin, var_991a9552);
		e_player setorigin(s_player_hellstorm_safe.origin);
		if(!(isdefined(e_player.var_48ad58e3) && e_player.var_48ad58e3))
		{
			e_player.var_48ad58e3 = 1;
			util::magic_bullet_shield(e_player);
		}
		function_22720795("s_enemy_event3");
		e_player thread namespace_73e1c3e3::function_1bb93418();
		level thread function_a9e139d7();
		namespace_73e1c3e3::function_a61ebb46((function_8b1a219a() ? #"hash_76bd8e89161df2ad" : #"hash_7bc7eb557d98f163"));
		level.var_e891c5ba = undefined;
		level notify(#"hash_3fdc549e5686cce0");
		namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_3_active"), 0);
		level notify(#"stop_nag");
		e_player = getplayers()[0];
		result = undefined;
		result = e_player waittill(#"stopped_using_remote");
		level.play_taacom_dialog = undefined;
		level.var_4b6a7a3a = 1;
		namespace_73e1c3e3::function_c561377e(undefined, undefined, 0);
		if(!isalive(e_player))
		{
			while(!isalive(e_player))
			{
				waitframe(1);
			}
			namespace_73e1c3e3::function_e44c5b8e(#"remote_missile", 10);
			e_player thread namespace_73e1c3e3::function_68848e5(#"remote_missile");
		}
		else if(e_player.kills > kills)
		{
			wait(2);
			break;
		}
		namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_3_miss_nag"), 1);
	}
	namespace_73e1c3e3::function_c561377e();
	namespace_73e1c3e3::function_9aca2fa0("ct_endgame");
	namespace_8c007aa6::function_831e0584(array("vox_tvoi_tutor_ruin_final_3_comp_0", "vox_tvoi_tutor_ruin_final_3_comp_1"), 1);
	level.play_taacom_dialog = level.var_bbd2b179;
}

/*
	Name: function_a9e139d7
	Namespace: namespace_2885895d
	Checksum: 0x1A5A1D31
	Offset: 0x8140
	Size: 0x142
	Parameters: 0
	Flags: None
*/
function function_a9e139d7()
{
	level endon(#"combattraining_logic_finished");
	level.var_e70f7774 = 1;
	s_loc = struct::get("s_player_hide_loc", "targetname");
	e_player = getplayers()[0];
	e_player endon(#"death");
	v_origin = e_player.origin;
	e_player setorigin(s_loc.origin);
	e_player hide();
	while(!(isdefined(level.var_4b6a7a3a) && level.var_4b6a7a3a))
	{
		waitframe(1);
	}
	e_player setorigin(v_origin);
	e_player show();
	level.var_e70f7774 = 0;
}

/*
	Name: function_22720795
	Namespace: namespace_2885895d
	Checksum: 0xE9B3767D
	Offset: 0x8290
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_22720795(var_3ee0e184)
{
	level.var_7b46025 = struct::get_array(var_3ee0e184, "targetname");
	level.var_47cd3e56 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
}

/*
	Name: function_e43f2419
	Namespace: namespace_2885895d
	Checksum: 0x3238F0B4
	Offset: 0x8310
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_e43f2419(var_3ee0e184)
{
	level.var_7b46025 = struct::get_array(var_3ee0e184, "targetname");
	level.var_47cd3e56 = 0;
	level thread namespace_64a487a9::function_4d9cfd95(level.var_7b46025.size, #"axis");
}

/*
	Name: function_523dd7be
	Namespace: namespace_2885895d
	Checksum: 0xC575D919
	Offset: 0x8390
	Size: 0x92
	Parameters: 0
	Flags: None
*/
function function_523dd7be()
{
	level endon(#"combattraining_logic_finished");
	self endon(#"death");
	while(true)
	{
		if(self isgrappling())
		{
			while(self isgrappling())
			{
				waitframe(1);
			}
			level notify(#"hash_48e959cf81e020f3");
		}
		waitframe(1);
	}
}

/*
	Name: function_4150d677
	Namespace: namespace_2885895d
	Checksum: 0x671B5CEC
	Offset: 0x8430
	Size: 0x37A
	Parameters: 4
	Flags: None
*/
function function_4150d677(n_goal_radius, var_d04c7daa, var_ce4a5fc7, var_4d39247d)
{
	s_loc = level.var_7b46025[level.var_47cd3e56];
	level.var_47cd3e56++;
	if(level.var_47cd3e56 >= level.var_7b46025.size)
	{
		level.var_47cd3e56 = 0;
	}
	if(isdefined(s_loc.radius))
	{
		n_goal_radius = s_loc.radius;
	}
	self endon(#"death");
	if(isdefined(var_4d39247d) && var_4d39247d)
	{
		self setorigin(s_loc.origin);
		self setplayerangles(s_loc.angles);
	}
	else
	{
		self namespace_73e1c3e3::function_61d750d4(s_loc.origin, s_loc.angles);
	}
	self thread namespace_73e1c3e3::function_5b59f3b7(s_loc.origin, s_loc.angles, n_goal_radius);
	self.overrideplayerdamage = &function_6fb4cde7;
	if(isdefined(level.var_b3a96da8) && level.var_b3a96da8)
	{
		self ghost();
	}
	if(isdefined(var_d04c7daa) && var_d04c7daa)
	{
		self val::set(#"hash_3cae4b247bc70a72", "ignoreall", 1);
	}
	if(isdefined(var_ce4a5fc7) && var_ce4a5fc7)
	{
		waitframe(1);
		self clientfield::set("enemy_keyline_render", 1);
	}
	switch(level.var_ad7c0539)
	{
		case 5:
		{
			self thread function_26de1390(s_loc);
			s_target = struct::get(s_loc.target, "targetname");
			self thread namespace_cbd87dc5::function_9313dd47(s_target, 50);
			break;
		}
		case 6:
		{
			self thread function_1cf646fa();
			break;
		}
		case 9:
		{
			self thread function_b3ee6bc1(s_loc);
			break;
		}
		case 10:
		{
			s_loc = level.var_d7003c6e[level.var_6425ca79];
			level.var_6425ca79++;
			if(level.var_6425ca79 >= level.var_d7003c6e.size)
			{
				level.var_6425ca79 = 0;
			}
			self thread namespace_73e1c3e3::function_1e7b75f2(s_loc);
			break;
		}
	}
}

/*
	Name: function_1cf646fa
	Namespace: namespace_2885895d
	Checksum: 0x8DFD555
	Offset: 0x87B8
	Size: 0x34C
	Parameters: 0
	Flags: None
*/
function function_1cf646fa()
{
	if(level.var_209e2e90.size == 0)
	{
		self thread namespace_73e1c3e3::function_5b59f3b7(self.origin, self.angles, 800);
		return;
	}
	n_closest = 9999999;
	foreach(beacon in level.var_209e2e90)
	{
		n_dist = distance(self.origin, beacon.origin);
		if(n_dist < n_closest)
		{
			var_1de166d = beacon;
			n_closest = n_dist;
		}
	}
	str_paths = var_1de166d.script_noteworthy;
	if(!isdefined(var_1de166d.var_6361cc82))
	{
		if(var_1de166d.s_loc.script_noteworthy == #"s_beacon_1_path")
		{
			var_1de166d.var_6361cc82 = [];
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_1_path", "targetname");
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_2_path", "targetname");
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_3_path", "targetname");
		}
		else
		{
			var_1de166d.var_6361cc82 = [];
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_4_path", "targetname");
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_5_path", "targetname");
			var_1de166d.var_6361cc82[var_1de166d.var_6361cc82.size] = struct::get("s_beacon_6_path", "targetname");
		}
		var_1de166d.var_24593a52 = 0;
	}
	s_loc = var_1de166d.var_6361cc82[var_1de166d.var_24593a52];
	var_1de166d.var_24593a52++;
	if(var_1de166d.var_24593a52 >= var_1de166d.var_6361cc82.size)
	{
		var_1de166d.var_24593a52 = 0;
	}
	self thread namespace_73e1c3e3::function_1e7b75f2(s_loc);
}

/*
	Name: function_b3ee6bc1
	Namespace: namespace_2885895d
	Checksum: 0xDE4BFE70
	Offset: 0x8B10
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_b3ee6bc1(s_loc)
{
	self endon(#"death");
	self val::reset(#"hash_6bc9266ffa66387c", "ignoreall");
	var_edbc66b6 = struct::get(s_loc.target, "targetname");
	var_edbc66b6 = (isdefined(var_edbc66b6) ? var_edbc66b6 : s_loc);
	self thread namespace_73e1c3e3::function_5b59f3b7(var_edbc66b6.origin, var_edbc66b6.angles, 64);
}

/*
	Name: function_26de1390
	Namespace: namespace_2885895d
	Checksum: 0xF65EFAC2
	Offset: 0x8BE0
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_26de1390(s_loc)
{
	self endon(#"death");
	waitframe(1);
	s_target = struct::get(s_loc.target, "targetname");
	self thread namespace_73e1c3e3::function_5b59f3b7(s_target.origin, s_target.angles, 32);
}

/*
	Name: function_cd74cce0
	Namespace: namespace_2885895d
	Checksum: 0xC179E727
	Offset: 0x8C70
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_cd74cce0(params)
{
	level notify(#"hash_58a5cb3964c46d00", {#str_reason:params.reason, #hash_57e7c4e:params.targetpos, #player:self});
}

/*
	Name: function_228e8cd6
	Namespace: namespace_2885895d
	Checksum: 0xDE373F6
	Offset: 0x8CE0
	Size: 0x7E
	Parameters: 1
	Flags: None
*/
function function_228e8cd6(weapon)
{
	if(isdefined(level.var_464c2ccd) && level.var_464c2ccd)
	{
		self function_63aa235();
	}
	if(isdefined(level.var_9863df4b))
	{
		self [[level.var_9863df4b]](weapon);
	}
	self notify(#"hash_7550ae00cd28adcb");
}

/*
	Name: function_63aa235
	Namespace: namespace_2885895d
	Checksum: 0x427B80DA
	Offset: 0x8D68
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function function_63aa235()
{
	if(!(isdefined(level.var_86085d04) && level.var_86085d04))
	{
		level.var_86085d04 = 1;
		setslowmotion(0.1, 0.05, 0.1);
		setpauseworld(1);
		self thread namespace_8c007aa6::function_831e0584(array(#"hash_6923615495bbfbcf"));
		wait(level.var_53f396c6);
		setpauseworld(0);
		setslowmotion(0.1, 1, 0.1);
	}
}

/*
	Name: function_17ab2327
	Namespace: namespace_2885895d
	Checksum: 0xC2B4CCA1
	Offset: 0x8E60
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_17ab2327()
{
	self endon(#"death");
	self thread function_4150d677(32, 1, 0, 1);
	waitframe(1);
	self hide();
	level waittill(#"hash_3fdc549e5686cce0");
	self show();
}

/*
	Name: function_421135df
	Namespace: namespace_2885895d
	Checksum: 0x9D120F4E
	Offset: 0x8EF0
	Size: 0x228
	Parameters: 0
	Flags: None
*/
function function_421135df()
{
	/#
		level endon(#"combattraining_logic_finished");
		sessionmode = currentsessionmode();
		setdvar(#"hash_6f59f2ade883b8e2", "");
		if(sessionmode != 4)
		{
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
		}
		while(true)
		{
			wait(0.25);
			cmd = getdvarstring(#"hash_6f59f2ade883b8e2", "");
			if(cmd == "")
			{
				continue;
			}
			e_player = level.players[0];
			switch(cmd)
			{
				case "kill_player":
				{
					e_player dodamage(1000, e_player.origin);
					break;
				}
				case "hash_62a59d8d058615b":
				{
					level notify(#"combattraining_logic_finished", {#success:1});
					break;
				}
				case "hash_47b6ee53b0518710":
				{
					e_player namespace_73e1c3e3::function_5160be8c();
					e_player dodamage(1000, e_player.origin);
					break;
				}
			}
			setdvar(#"hash_6f59f2ade883b8e2", "");
		}
	#/
}

