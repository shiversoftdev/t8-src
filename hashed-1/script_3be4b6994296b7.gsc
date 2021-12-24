// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_135d37089bbde4f2;
#using script_18fb8ad2a13d96b;
#using script_490759cf62a1abc8;
#using script_5b092d41f1ecae8a;
#using script_61826ca279ffa0;
#using script_6c8abe14025b47c4;
#using script_6e26f2d648dc4251;
#using script_7f988b980dd872d4;
#using script_bb99a1f9be8d0a7;
#using script_ee56e8b680377b6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;

#namespace namespace_594230df;

/*
	Name: init
	Namespace: namespace_594230df
	Checksum: 0xDC359B86
	Offset: 0xDB0
	Size: 0x72
	Parameters: 0
	Flags: None
*/
function init()
{
	level.var_ae120f18 = array(#"hash_63c5e2c0cbf46688");
	level.var_6cd64bc3 = 0;
	level.var_2a0adaaa = 1;
	level flag::init("ct_player_success");
	level.var_41259f0d = 1;
}

/*
	Name: function_c9ff0dce
	Namespace: namespace_594230df
	Checksum: 0x2C090C6B
	Offset: 0xE30
	Size: 0x2DA
	Parameters: 0
	Flags: None
*/
function function_c9ff0dce()
{
	if(self.team == #"allies")
	{
		self namespace_73e1c3e3::player_reset();
		self.overrideplayerdamage = &function_6fb4cde7;
		if(!isbot(self))
		{
			namespace_73e1c3e3::function_8f04870f();
			if(isdefined(level.var_ad7c0539))
			{
				switch(level.var_ad7c0539)
				{
					case 2:
					case 3:
					case 5:
					case 7:
					case 8:
					{
						self thread namespace_64a487a9::function_fd2d220e(0);
						break;
					}
					case 9:
					{
						self namespace_13777bae::function_1dd43d36(getweapon(#"ray_gun"));
						self thread namespace_d82263d5::function_1be7e4f(#"ray_gun");
						break;
					}
				}
			}
		}
		else
		{
			self thread namespace_73e1c3e3::function_5149c890(1);
			if(isdefined(level.var_ad7c0539))
			{
				switch(level.var_ad7c0539)
				{
					default:
					{
						self thread function_58c62280(32, 0, 0);
						break;
					}
				}
			}
		}
	}
	else
	{
		self thread namespace_73e1c3e3::function_5149c890(1);
		if(isdefined(level.var_ad7c0539))
		{
			switch(level.var_ad7c0539)
			{
				case 2:
				{
					self thread function_58c62280(32, 0, 0);
					break;
				}
				case 4:
				{
					level.var_2a5b7055 = self;
					break;
				}
				case 5:
				{
					self thread function_bbb1aed5();
					break;
				}
				default:
				{
					self thread function_58c62280(32, 1, 0);
					break;
				}
			}
		}
	}
}

/*
	Name: function_6fb4cde7
	Namespace: namespace_594230df
	Checksum: 0xD9822C18
	Offset: 0x1118
	Size: 0x1D6
	Parameters: 11
	Flags: None
*/
function function_6fb4cde7(e_inflictor, e_attacker, n_damage, n_dflags, str_means_of_death, weapon, v_point, v_dir, str_hit_loc, n_psoffsettime, var_8b69d5cf)
{
	if(!isdefined(level.var_ad7c0539))
	{
		return n_damage;
	}
	if(self.team == #"allies")
	{
		if(isdefined(level.var_ad7c0539))
		{
			switch(level.var_ad7c0539)
			{
				case 7:
				{
					if(!isbot(self))
					{
						n_damage = n_damage * 1.5;
					}
					break;
				}
				case 8:
				case 9:
				{
					if(!isbot(self))
					{
						n_damage = n_damage * 0.8;
					}
					break;
				}
			}
		}
	}
	else if(isdefined(level.var_ad7c0539))
	{
		switch(level.var_ad7c0539)
		{
			case 1:
			case 2:
			{
				n_damage = self.health + 100;
				level notify(#"enemy_kill");
				break;
			}
			default:
			{
				break;
			}
		}
	}
	return n_damage;
}

/*
	Name: function_72ba0df6
	Namespace: namespace_594230df
	Checksum: 0x4FF7AEC7
	Offset: 0x12F8
	Size: 0x21E
	Parameters: 9
	Flags: None
*/
function function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(self.team == #"allies")
	{
		if(!isbot(self))
		{
			if(isdefined(level.var_ad7c0539))
			{
				switch(level.var_ad7c0539)
				{
					case 7:
					{
						level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_18bcfb5b91b80370"), 1);
						break;
					}
					case 8:
					case 9:
					{
						level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_77c6ce9bf6da35f4"), 1);
						break;
					}
					default:
					{
						level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_72daf28dd50991c5"), 1);
						break;
					}
				}
			}
		}
		else if(isdefined(einflictor) && isdefined(level.var_a7530fbc) && einflictor == level.var_a7530fbc)
		{
			level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_5fb571057d1baaaf"), 1);
		}
	}
	else
	{
		level.var_a86320e8 = gettime() / 1000;
	}
	self.isinuse = 0;
}

/*
	Name: function_9b9525e9
	Namespace: namespace_594230df
	Checksum: 0xA725D00B
	Offset: 0x1520
	Size: 0x78C
	Parameters: 0
	Flags: None
*/
function function_9b9525e9()
{
	level endon(#"combattraining_logic_finished");
	level.var_e6db911d = 1;
	level.var_6a0c3e3e = 1;
	level.allowspecialistdialog = 0;
	level.var_4fbc6865 = undefined;
	e_player = namespace_73e1c3e3::get_player();
	e_player thread namespace_73e1c3e3::function_ccd9180e();
	level.var_2e552187 = 216000000;
	level thread namespace_73e1c3e3::function_9ab507a9("opening_collision", "start_opening_collision", "stop_opening_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("opening_temp_collision", "start_opening_temp_collision", "stop_opening_temp_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("opening_collision_exit", "start_opening_collision_exit", "stop_opening_collision_exit", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("vp_collision", "start_vp_collision", "stop_vp_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("courtyard_collision", "start_courtyard_collision", "stop_courtyard_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("courtyard_cellar_collision", "start_courtyard_cellar_collision", "stop_courtyard_cellar_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("execution_collision", "start_execution_collision", "stop_execution_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("execution_exit_collision", "start_execution_exit_collision", "stop_execution_exit_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("church_dart_collision", "start_church_dart_collision", "stop_church_dart_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("inside_church_collision", "start_inside_church_collision", "stop_inside_church_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("inside_church_exit_collision", "start_inside_church_exit_collision", "stop_inside_church_exit_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("enter_church_collision", "start_enter_church_collision", "stop_enter_church_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("enemy_dart_collision", "start_enemy_dart_collision", "stop_enemy_dart_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("enemy_dart_enter_collision", "start_enemy_dart_enter_collision", "stop_enemy_dart_enter_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("enemy_dart_exit_collision", "start_enemy_dart_exit_collision", "stop_enemy_dart_exit_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("two_guys_colision", "start_two_guys_colision", "stop_two_guys_colision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("flanking_collision", "start_flanking_collision", "stop_flanking_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("flanking_exit_collision", "start_flanking_exit_collision", "stop_flanking_exit_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("zombies_collision", "start_zombies_collision", "stop_zombies_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("wine_cellar_collision", "start_wine_cellar_collision", "stop_wine_cellar_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("wine_cellar_exit_collision", "start_wine_cellar_exit_collision", "stop_wine_cellar_exit_collision", 1, 1, 0);
	level thread namespace_73e1c3e3::function_9ab507a9("block_start_collision", "start_block_start_collision", "stop_block_start_collision", 1, 1, 0);
	a_nodes = getnodearray("disable_node", "script_noteworthy");
	foreach(node in a_nodes)
	{
		setenablenode(node, 0);
	}
	level.var_d4668c34 = 1;
	level.zombie_team = #"axis";
	level.var_ad7c0539 = 1;
	function_86c058b();
	level.var_ad7c0539 = 2;
	function_5598747a();
	level.var_ad7c0539 = 3;
	function_8d107060();
	level.var_ad7c0539 = 4;
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	function_6728bf85();
	level.var_ad7c0539 = 5;
	function_1f031934();
	level.var_ad7c0539 = 6;
	function_c962d077();
	level.var_ad7c0539 = 7;
	function_f6c6baf3();
	level.var_ad7c0539 = 8;
	function_39f9d433();
	level.var_ad7c0539 = 9;
	function_79d4c106();
	level.var_2e552187 = undefined;
	namespace_73e1c3e3::function_9f8be64a();
}

/*
	Name: function_86c058b
	Namespace: namespace_594230df
	Checksum: 0xD856A7
	Offset: 0x1CB8
	Size: 0x7B0
	Parameters: 0
	Flags: None
*/
function function_86c058b()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level notify(#"start_opening_collision");
	level notify(#"start_opening_collision_exit");
	level notify(#"start_opening_temp_collision");
	namespace_8c007aa6::function_3ca1b77d();
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_63c5e3c0cbf4683b"));
	e_player = getplayers()[0];
	var_3608d414 = array(#"hash_94c2603d3b522a7");
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_75a61367f89fc81a", var_3608d414);
	s_loc = struct::get("s_recon_vision_pulse_obj", "targetname");
	waypoint = namespace_73e1c3e3::create_waypoint(#"hash_1f1deaa6bff12db8", s_loc.origin, s_loc.angles, #"any", undefined, 40, undefined);
	level.var_e72728b8 = array(#"eq_sensor", #"gadget_vision_pulse");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_d25bd3c9(s_loc.origin, 80, 0);
	level notify(#"stop_nag");
	waypoint namespace_73e1c3e3::function_f9ed304d();
	namespace_73e1c3e3::function_c2a10fc();
	waitframe(1);
	namespace_73e1c3e3::function_e9ab1003("s_recon_vision_pulse_obj");
	level notify(#"start_vp_collision");
	level notify(#"stop_opening_temp_collision");
	level.var_66b3c127 = struct::get_array("s_vision_pulse_allies", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::activate_bots(level.var_66b3c127.size, #"allies");
	if(!(isdefined(level.var_3e17f129) && level.var_3e17f129))
	{
		namespace_8c007aa6::function_3ca1b77d();
	}
	namespace_8c007aa6::function_831e0584(array(#"hash_339eb8312fdc25d4"), 1);
	e_player = getplayers()[0];
	var_fb96a3d0 = (e_player gamepadusedlast() ? #"hash_5fc4460a0ad75031" : #"hash_c06fe0229fb1557");
	e_player thread namespace_73e1c3e3::function_61c3d59c(var_fb96a3d0, undefined);
	level.var_66b3c127 = struct::get_array("s_vision_pulse_axis", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::activate_bots(level.var_66b3c127.size, #"axis");
	wait(0.2);
	level.var_e72728b8 = array(#"eq_sensor");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_dd77a0770d28e66"), "stop_nag");
	e_player = getplayers()[0];
	e_player waittill(#"vision_pulse_on");
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_c2a10fc();
	wait(0.75);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_2a475119c0c9d7db", #"hash_76711f94e9fc32da"), 0);
	level notify(#"hash_3c13162d215d8698");
	level notify(#"stop_opening_collision_exit");
	level notify(#"start_courtyard_collision");
	level notify(#"start_courtyard_cellar_collision");
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_fd2d220e();
	level notify(#"start_execution_collision");
	level notify(#"start_execution_exit_collision");
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_76d83574c8576dcd", undefined);
	level.var_54c1ce00 = level.var_32ae304;
	level.var_32ae304 = undefined;
	wait(3.5);
	level notify(#"hash_60c1587995518e92");
	level waittill(#"hash_18806b37ec38ff49");
	wait(4);
	namespace_8c007aa6::function_831e0584(array(#"hash_76712094e9fc348d"), 1);
	namespace_73e1c3e3::function_d00e0eeb();
	namespace_73e1c3e3::function_c2a10fc();
	level.var_32ae304 = level.var_54c1ce00;
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	level notify(#"hash_15f7db94fb4253cf");
	level notify(#"stop_execution_collision");
	level notify(#"stop_execution_exit_collision");
	wait(0.1);
}

/*
	Name: function_5598747a
	Namespace: namespace_594230df
	Checksum: 0xD4E3F39B
	Offset: 0x2470
	Size: 0x710
	Parameters: 0
	Flags: None
*/
function function_5598747a()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level notify(#"start_church_dart_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_church_sensor_dart_1", array(#"eq_sensor", #"gadget_vision_pulse"), 0, undefined, 50);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_church_sensor_dart_1");
	level notify(#"start_execution_exit_collision");
	level notify(#"start_enter_church_collision");
	level thread function_a71a97eb(undefined, 0.1, undefined, "s_bot_approach_church_loc");
	var_3608d414 = array("vox_tvoi_tutor_reco_sensor_dart_0", "vox_tvoi_tutor_reco_sensor_dart_1");
	namespace_8c007aa6::function_831e0584(var_3608d414, 1);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_a8bcd8c98df0294"), 1);
	wait(1.5);
	level.var_e72728b8 = array(#"gadget_vision_pulse");
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_c71232da049f689", undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_233e42de1d3dc67d"), "stop_nag");
	namespace_73e1c3e3::function_d3bbbf8a("s_sensor_dart_target_1", 1, 40, level.var_e72728b8, undefined);
	level notify(#"stop_nag");
	level.var_e72728b8 = array(#"eq_sensor", #"gadget_vision_pulse");
	namespace_73e1c3e3::function_c2a10fc();
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_2487fc596a57617c"), 1);
	level notify(#"stop_church_dart_collision");
	level notify(#"start_inside_church_collision");
	level notify(#"start_inside_church_exit_collision");
	level.var_28cbbd60 = [];
	level.var_28cbbd60[level.var_28cbbd60.size] = struct::get("s_church_path1", "targetname");
	level.var_28cbbd60[level.var_28cbbd60.size] = struct::get("s_church_path2", "targetname");
	level.var_68629f1 = 0;
	level.var_66b3c127 = struct::get_array("s_enemys_in_church", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::activate_bots(level.var_66b3c127.size, #"axis");
	level thread function_a71a97eb(undefined, 0.1, undefined, "s_bot_approach_tank_loc");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	level.var_3e67eeea = #"hash_2a38a07c2fc52c1f";
	namespace_73e1c3e3::function_93c86846(array(#"hash_36d8331fa342d02a"), "s_sensor_dart_crum_4", array(#"gadget_vision_pulse"), 0, undefined, 50);
	level notify(#"stop_nag");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array(#"hash_37a8de4d53277755"), 0);
	level notify(#"stop_enter_church_collision");
	level thread function_ae2eb600();
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_3d16aaaf27ec6bac", undefined);
	e_player thread namespace_64a487a9::function_fd2d220e(0);
	namespace_73e1c3e3::function_d00e0eeb();
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array(#"hash_6ece745489e4c50a", #"hash_6ece755489e4c6bd"), 1);
	level.var_e72728b8 = undefined;
	wait(0.1);
}

/*
	Name: function_a71a97eb
	Namespace: namespace_594230df
	Checksum: 0x1CEE95D9
	Offset: 0x2B88
	Size: 0x1D0
	Parameters: 4
	Flags: None
*/
function function_a71a97eb(var_25da558a, var_a05aef62, var_6c27391b, var_2cfdf737)
{
	level endon(#"combattraining_logic_finished");
	if(isdefined(var_25da558a))
	{
		level waittill(var_25da558a);
	}
	if(isdefined(var_a05aef62))
	{
		wait(var_a05aef62);
	}
	e_player = getplayers()[0];
	a_bots = e_player namespace_64a487a9::function_71ec2b36();
	var_32055a50 = struct::get_array(var_2cfdf737, "targetname");
	if(isdefined(var_6c27391b))
	{
		var_1aca5aac = struct::get(var_6c27391b, "targetname");
	}
	n_index = 0;
	foreach(bot in a_bots)
	{
		var_bed4bcb2 = [];
		if(isdefined(var_1aca5aac))
		{
			var_bed4bcb2[0] = var_1aca5aac;
		}
		var_bed4bcb2[var_bed4bcb2.size] = var_32055a50[n_index];
		n_index++;
		if(n_index >= var_32055a50.size)
		{
			n_index = 0;
		}
		bot thread namespace_cbd87dc5::function_12f9ed01(var_bed4bcb2);
	}
}

/*
	Name: function_ae2eb600
	Namespace: namespace_594230df
	Checksum: 0x77030EFC
	Offset: 0x2D60
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_ae2eb600()
{
	s_loc = struct::get("s_inside_church", "targetname");
	namespace_73e1c3e3::function_9a4e412e(s_loc, "in_church");
	level notify(#"start_enter_church_collision");
	level notify(#"hash_439e586d5a4210cd");
	namespace_73e1c3e3::function_e9ab1003("s_inside_church");
}

/*
	Name: function_8d107060
	Namespace: namespace_594230df
	Checksum: 0xD1ACF903
	Offset: 0x2E00
	Size: 0x4AC
	Parameters: 0
	Flags: None
*/
function function_8d107060()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_23bd73ced8c3ea9a", undefined);
	e_player callback::function_78ccee50(&function_78ccee50);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_6ece725489e4c1a4"));
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_233e42de1d3dc67d"), "stop_nag");
	namespace_73e1c3e3::function_d3bbbf8a("s_sensor_dart_target_2", 1, 40, undefined, array(#"eq_sensor"));
	level notify(#"stop_nag");
	level notify(#"hash_489196ae3f94aaf8");
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_4846299866b4a63f"));
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_7804ec43ffd16028", undefined);
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	wait(6);
	level thread function_a71a97eb(undefined, 4, undefined, "s_two_guys_friendly_loc");
	namespace_73e1c3e3::function_51c89e00(1, #"allies");
	level.var_271da9fa = [];
	level.var_271da9fa[level.var_271da9fa.size] = struct::get("s_two_guys_path1", "targetname");
	level.var_271da9fa[level.var_271da9fa.size] = struct::get("s_two_guys_path2", "targetname");
	level.var_acc24708 = 0;
	level.var_66b3c127 = struct::get_array("s_dart_walker", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::activate_bots(level.var_66b3c127.size, #"axis");
	level waittill(#"hash_2c306e3ce74261bf");
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_510731dfbe637192"), 1);
	level notify(#"stop_inside_church_exit_collision");
	level notify(#"start_two_guys_colision");
	level notify(#"start_enemy_dart_enter_collision");
	e_player = getplayers()[0];
	e_player thread namespace_64a487a9::function_fd2d220e(0);
	namespace_73e1c3e3::function_51c89e00(0, #"allies");
	while(!(isdefined(level.var_823fa371) && level.var_823fa371))
	{
		waitframe(1);
	}
	level.var_823fa371 = undefined;
	namespace_73e1c3e3::function_d00e0eeb();
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array(#"hash_2ab197f91d18834a"), 1);
}

/*
	Name: function_6728bf85
	Namespace: namespace_594230df
	Checksum: 0xF81D4576
	Offset: 0x32B8
	Size: 0x6C4
	Parameters: 0
	Flags: None
*/
function function_6728bf85()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	var_3608d414 = array(#"hash_2ab198f91d1884fd");
	level thread namespace_8c007aa6::function_831e0584(var_3608d414);
	level notify(#"stop_enemy_dart_enter_collision");
	level notify(#"start_enemy_dart_collision");
	level notify(#"start_enemy_dart_exit_collision");
	level notify(#"start_flanking_collision");
	level notify(#"start_flanking_exit_collision");
	level thread namespace_64a487a9::activate_bots(1, #"axis");
	var_1d00e3e1 = struct::get("s_enemy_sensor_dart_target", "targetname");
	while(!isdefined(level.var_2a5b7055))
	{
		waitframe(1);
	}
	dir = anglestoforward(var_1d00e3e1.angles);
	dir = vectornormalize(dir);
	velocity = vectorscale(dir, 1000);
	var_d81cee52 = level.var_2a5b7055 magicgrenadeplayer(getweapon(#"eq_sensor"), var_1d00e3e1.origin, velocity);
	waitresult = undefined;
	waitresult = var_d81cee52 waittill(#"stationary");
	var_d81cee52.hitnormal = waitresult.normal;
	var_d81cee52.hitpos = waitresult.position;
	var_d81cee52.owner = level.var_2a5b7055;
	var_d81cee52.team = level.var_2a5b7055.team;
	var_d81cee52 setcandamage(1);
	var_d81cee52.maxhealth = 100000;
	var_d81cee52.health = var_d81cee52.maxhealth;
	var_d81cee52 setteam(level.var_2a5b7055.team);
	var_d81cee52.waypoint = undefined;
	playfxontag(#"hash_1307839267d89579", var_d81cee52, "tag_fx");
	var_d81cee52 clientfield::set("sensor_dart_state", 1);
	var_d81cee52 thread function_40e2147a();
	level.var_2a5b7055 namespace_64a487a9::function_991ccf1a();
	level.var_2a5b7055 = undefined;
	level thread function_a71a97eb(undefined, undefined, "s_approach_enemy_dart", "s_bot_enemy_dart_loc");
	waitframe(1);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_enemy_sensor_dart_crum_2", array(#"eq_sensor"), 0, undefined, 35);
	level notify(#"stop_nag");
	level notify(#"start_inside_church_exit_collision");
	level notify(#"stop_courtyard_collision");
	level notify(#"stop_courtyard_cellar_collision");
	waitframe(1);
	level notify(#"start_enemy_dart_enter_collision");
	level notify(#"stop_inside_church_collision");
	level notify(#"stop_inside_church_exit_collision");
	level notify(#"stop_enter_church_collision");
	level notify(#"stop_execution_exit_collision");
	level notify(#"stop_two_guys_colision");
	namespace_8c007aa6::function_41e59aeb(array(#"hash_2ab195f91d187fe4", #"hash_2ab196f91d188197"), 1);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_1c8eae10a9021558", undefined);
	e_player thread namespace_64a487a9::function_fd2d220e(0);
	if(isdefined(var_d81cee52))
	{
		level thread namespace_8c007aa6::function_14b08e49(array(#"hash_8c16ee4aea85f4c"), "stop_nag");
		var_d81cee52 waittill(#"death");
		level notify(#"stop_nag");
	}
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_3ca1b77d();
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	namespace_8c007aa6::function_831e0584(array(#"hash_4a8d1e7e7e423b65"), 0);
	wait(0.1);
}

/*
	Name: function_40e2147a
	Namespace: namespace_594230df
	Checksum: 0x814D924
	Offset: 0x3988
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function function_40e2147a()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		if(isdefined(self.waypoint))
		{
			self.waypoint gameobjects::set_visible_team("none");
			self.waypoint = undefined;
		}
		self namespace_d81cee52::function_4db10465();
	}
}

/*
	Name: function_1f031934
	Namespace: namespace_594230df
	Checksum: 0x38ECF27D
	Offset: 0x3A40
	Size: 0x6A4
	Parameters: 0
	Flags: None
*/
function function_1f031934()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level notify(#"stop_flanking_collision");
	level thread function_a71a97eb(undefined, 3, undefined, "s_bot_flanking_loc1");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_recon_flanking_goto_2", array(#"eq_sensor", #"gadget_vision_pulse"), undefined, undefined, 35);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_recon_flanking_goto_2");
	level.var_e72728b8 = array(#"gadget_vision_pulse");
	level notify(#"start_flanking_collision");
	waitframe(1);
	namespace_8c007aa6::function_831e0584(array(#"hash_4a8d1d7e7e4239b2"), 1);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_4a8d1b7e7e42364c"), 0);
	wait(0.1);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_6e7ef3de4616f397", undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_233e42de1d3dc67d"), "stop_nag");
	namespace_73e1c3e3::function_d3bbbf8a("s_recon_flanking_dark_loc", 1, 25, array(#"gadget_vision_pulse"), undefined);
	level notify(#"stop_nag");
	level.var_e72728b8 = array(#"eq_sensor", #"gadget_vision_pulse");
	namespace_8c007aa6::function_3ca1b77d();
	namespace_8c007aa6::function_831e0584(array(#"hash_43ea8c66f01fbea3"), 1);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_43ea8b66f01fbcf0"), 0);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_7a14b6f139fe708a", undefined);
	e_player thread namespace_64a487a9::function_fd2d220e(0);
	namespace_73e1c3e3::function_9aca2fa0("ct_action2");
	s_pos = struct::get("s_right_flankers", "targetname");
	var_8a7d22ef = namespace_cbd87dc5::function_9ca5c5fc(s_pos.origin, #"allies", 400);
	s_pos = struct::get("s_left_flankers", "targetname");
	var_6fef4c03 = namespace_cbd87dc5::function_9ca5c5fc(s_pos.origin, #"allies", 400);
	level.var_a32f4757 = struct::get_array("s_left_attack_loc", "targetname");
	level.var_1c1866de = 0;
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_41a9b2d29deeeda"), 1);
	level thread function_f8b711ef(2, var_8a7d22ef, "s_defend_left_attackers_loc");
	function_cc52d21a("s_recon_left_side_attackers", 15, 2);
	level.var_e6db911d = 1;
	wait(0.5);
	namespace_73e1c3e3::function_d00e0eeb();
	wait(0.5);
	level.var_a32f4757 = struct::get_array("s_right_attack_loc", "targetname");
	level.var_1c1866de = 0;
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_41a9a2d29deed27"), 1);
	level thread function_f8b711ef(2, var_6fef4c03, "s_defend_left_wave2_loc");
	level thread function_f8b711ef(2, var_8a7d22ef, "s_defend_right_wave2_loc");
	wait(3);
	function_cc52d21a("s_recon_right_side_attackers", 15, 2);
	namespace_73e1c3e3::function_d00e0eeb();
	namespace_73e1c3e3::function_9aca2fa0("ct_action");
	namespace_73e1c3e3::function_c2a10fc();
}

/*
	Name: function_f8b711ef
	Namespace: namespace_594230df
	Checksum: 0x46B4D52E
	Offset: 0x40F0
	Size: 0x140
	Parameters: 3
	Flags: None
*/
function function_f8b711ef(n_delay, a_bots, var_f54eb40a)
{
	level endon(#"combattraining_logic_finished");
	wait(n_delay);
	a_locs = struct::get_array(var_f54eb40a, "targetname");
	n_loc_index = 0;
	foreach(bot in a_bots)
	{
		if(isalive(bot))
		{
			var_4abe70c5 = array(a_locs[n_loc_index]);
			n_loc_index++;
			if(n_loc_index >= a_locs.size)
			{
				n_loc_index = 0;
			}
			bot thread namespace_cbd87dc5::function_12f9ed01(var_4abe70c5);
		}
	}
}

/*
	Name: function_cc52d21a
	Namespace: namespace_594230df
	Checksum: 0x25B13E24
	Offset: 0x4238
	Size: 0x146
	Parameters: 3
	Flags: None
*/
function function_cc52d21a(var_260aad25, var_6f8083d4, var_75efba72)
{
	level endon(#"combattraining_logic_finished");
	level.var_e6db911d = 1;
	level.var_66b3c127 = struct::get_array(var_260aad25, "targetname");
	level.var_9f073b4 = 0;
	var_e8d6f89 = level.var_66b3c127.size;
	if(isdefined(var_75efba72))
	{
		var_e8d6f89 = var_75efba72;
	}
	level thread namespace_64a487a9::activate_bots(var_e8d6f89, #"axis");
	n_start_time = gettime() / 1000;
	wait(1);
	level.var_e6db911d = 0;
	while(true)
	{
		n_time = gettime() / 1000;
		dt = n_time - n_start_time;
		if(dt >= var_6f8083d4)
		{
			break;
		}
		waitframe(1);
	}
	level.var_e6db911d = 1;
}

/*
	Name: function_c962d077
	Namespace: namespace_594230df
	Checksum: 0x9202BBD1
	Offset: 0x4388
	Size: 0x1D4
	Parameters: 0
	Flags: None
*/
function function_c962d077()
{
	level endon(#"combattraining_logic_finished");
	level thread function_9a7c1671();
	namespace_8c007aa6::function_831e0584(array(#"hash_3a29a5f77a7cb68a", #"hash_3a29a6f77a7cb83d"), 1);
	level notify(#"stop_flanking_exit_collision");
	level notify(#"start_wine_cellar_collision");
	level notify(#"start_wine_cellar_exit_collision");
	playsoundatposition(#"hash_4ea3c849271fa11", (-621, -1024, 828));
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_dead_bodies_obj", undefined, undefined, undefined, 35);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_dead_bodies_obj");
	level notify(#"start_flanking_exit_collision");
	namespace_8c007aa6::function_831e0584(array(#"hash_7c8c366945d5ee61", #"hash_7c8c356945d5ecae"), 1);
}

/*
	Name: function_9a7c1671
	Namespace: namespace_594230df
	Checksum: 0x93BD4078
	Offset: 0x4568
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_9a7c1671()
{
	clearplayercorpses();
	level.var_66b3c127 = struct::get_array("s_dead_body_loc", "targetname");
	level.var_9f073b4 = 0;
	level thread namespace_64a487a9::activate_bots(level.var_66b3c127.size, #"axis");
}

/*
	Name: function_f6c6baf3
	Namespace: namespace_594230df
	Checksum: 0x5C34B7B1
	Offset: 0x45F0
	Size: 0x7D4
	Parameters: 0
	Flags: None
*/
function function_f6c6baf3()
{
	level endon(#"combattraining_logic_finished");
	level notify(#"stop_wine_cellar_exit_collision");
	level notify(#"start_courtyard_cellar_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_zomibe_obj_crumb1", array(#"eq_sensor"), undefined, undefined, 35);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_9aca2fa0("ct_wzf");
	namespace_73e1c3e3::function_e9ab1003("s_zomibe_obj_crumb1");
	level notify(#"start_courtyard_collision");
	level notify(#"start_wine_cellar_exit_collision");
	level notify(#"start_enter_church_collision");
	level notify(#"start_block_start_collision");
	level notify(#"start_zombies_collision");
	playsoundatposition(#"hash_e9c6b8a406318e9", (275, -1840, 874));
	wait(3);
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_71c199093aa347bd"), 1);
	level thread function_a71a97eb(undefined, 0.1, undefined, "s_bot_approach_church_loc");
	level notify(#"stop_flanking_exit_collision");
	level notify(#"stop_courtyard_cellar_collision");
	level notify(#"stop_flanking_collision");
	level notify(#"stop_enemy_dart_collision");
	level notify(#"stop_enemy_dart_enter_collision");
	level notify(#"stop_enemy_dart_exit_collision");
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(array(#"hash_71c198093aa3460a"), "s_zomibe_obj_crumb2", array(#"eq_sensor"), undefined, undefined, 35);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_e9ab1003("s_zomibe_obj_crumb2");
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_41df5f0ebdcf8b66", undefined);
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_71c197093aa34457"), 1);
	level thread function_ffd0b345();
	level.var_e72728b8 = array(#"gadget_vision_pulse");
	level.var_5008031d = undefined;
	while(true)
	{
		waitresult = undefined;
		waitresult = e_player waittill(#"hash_70f03cfbb15356c0");
		e_dart = waitresult.dart;
		level.var_5008031d = e_dart;
		var_308b5f44 = struct::get("s_blightfather_dart_loc", "targetname");
		v_forward = anglestoforward(var_308b5f44.angles);
		v_dir = vectornormalize(e_dart.origin - var_308b5f44.origin);
		dp = vectordot(v_forward, v_dir);
		if(dp > 0)
		{
			break;
		}
		waitframe(1);
	}
	level notify(#"stop_nag");
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_6d4bf4b06eb5cef1"), 1);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_7f670c9cab084284", undefined);
	s_loc = struct::get("s_blightfather_loc", "targetname");
	level.var_a7530fbc = spawn_blight_father(s_loc);
	level.var_a7530fbc.overrideactordamage = &function_a5f160e7;
	e_player = getplayers()[0];
	e_player thread namespace_64a487a9::function_fd2d220e(0);
	wait(7);
	level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_75d35181fe648687", #"hash_75d35081fe6484d4"), 1);
	var_6ee32682 = gettime() / 1000;
	while(isalive(level.var_a7530fbc))
	{
		n_time = gettime() / 1000;
		dt = n_time - var_6ee32682;
		if(dt > 20)
		{
			if(namespace_8c007aa6::function_5d127774())
			{
				var_6ee32682 = n_time - 15;
			}
			else
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_5eee0745d94d4b04"), 1);
				var_6ee32682 = n_time;
			}
		}
		waitframe(1);
	}
	namespace_8c007aa6::function_41e59aeb(array(#"hash_75250dd5dd02c873", #"hash_75250cd5dd02c6c0"), 1);
}

/*
	Name: function_ffd0b345
	Namespace: namespace_594230df
	Checksum: 0x4571CB8A
	Offset: 0x4DD0
	Size: 0x160
	Parameters: 0
	Flags: None
*/
function function_ffd0b345()
{
	level endon(#"combattraining_logic_finished", #"stop_nag");
	var_6ee32682 = 0;
	while(true)
	{
		n_time = gettime() / 1000;
		dt = n_time - var_6ee32682;
		if(isdefined(level.var_5008031d))
		{
			level.var_5008031d = undefined;
			while(namespace_8c007aa6::function_5d127774())
			{
				waitframe(1);
			}
			level thread namespace_8c007aa6::function_831e0584(array(#"hash_3da84622f4be7b95"), 1);
			var_6ee32682 = gettime() / 1000;
		}
		else if(dt > 20)
		{
			if(!namespace_8c007aa6::function_5d127774())
			{
				level thread namespace_8c007aa6::function_831e0584(array(#"hash_603d9fbe8af4a8b3"), 1);
				var_6ee32682 = n_time;
			}
			else
			{
				var_6ee32682 = n_time + 15;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_39f9d433
	Namespace: namespace_594230df
	Checksum: 0x8F1C0C2A
	Offset: 0x4F38
	Size: 0x734
	Parameters: 0
	Flags: None
*/
function function_39f9d433()
{
	level endon(#"combattraining_logic_finished");
	level.var_e72728b8 = array(#"gadget_vision_pulse");
	e_player = getplayers()[0];
	e_player namespace_73e1c3e3::function_6ad0c151();
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_46c4843e8f5d2451"), "stop_nag");
	namespace_73e1c3e3::function_93c86846(undefined, "s_zomibe_objective", array(#"eq_sensor"), undefined, undefined, 35);
	level notify(#"stop_nag");
	level notify(#"start_enter_church_collision");
	level notify(#"stop_inside_church_collision");
	level notify(#"stop_inside_church_exit_collision");
	namespace_73e1c3e3::function_e9ab1003(undefined);
	level notify(#"hash_3a0d770bcea202fd");
	level.var_e72728b8 = undefined;
	e_player = getplayers()[0];
	registerhendricks_exited_industrial_zoneteleportinstart = (e_player gamepadusedlast() ? #"hash_42fb522d8067c039" : #"hash_29d476be9b1e85f");
	e_player thread namespace_73e1c3e3::function_61c3d59c(registerhendricks_exited_industrial_zoneteleportinstart, undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_dd77a0770d28e66"), "stop_nag");
	e_player = getplayers()[0];
	e_player waittill(#"vision_pulse_on");
	level notify(#"stop_nag");
	e_player namespace_64a487a9::function_fd2d220e(0);
	waitframe(1);
	namespace_73e1c3e3::function_c2a10fc();
	setdvar(#"hash_3e06b14c41136e95", 0);
	namespace_73e1c3e3::function_e44c5b8e(#"overwatch_helicopter", 25);
	e_player thread namespace_73e1c3e3::function_68848e5("overwatch_helicopter");
	level.var_28cfc859 = 50;
	var_3608d414 = array(#"hash_5b00936def7e0205", #"hash_5b00926def7e0052", #"hash_5b00916def7dfe9f");
	level thread namespace_8c007aa6::function_831e0584(var_3608d414, 1);
	level.var_6cd64bc3 = 0;
	level thread function_94c8f1d8(6);
	e_player waittill(#"vision_pulse_off");
	level.var_79671f89 = 1;
	e_player = namespace_73e1c3e3::get_player();
	e_player thread namespace_73e1c3e3::function_61c3d59c(undefined, undefined, "dynobj_KillZombies");
	e_player namespace_73e1c3e3::function_80bf685b(50 * level.var_6cd64bc3);
	e_player.var_d5d10814 = undefined;
	wait(0.1);
	n_cost = killstreaks::get_killstreak_momentum_cost(e_player, level.var_b4a06c5b);
	n_max_zombies = (n_cost / 50) - 6;
	level thread function_bb44f289(10, n_max_zombies, 1);
	level.var_a86320e8 = gettime() / 1000;
	while(!(isdefined(e_player.var_d5d10814) && e_player.var_d5d10814))
	{
		e_player = getplayers()[0];
		if(!isalive(e_player))
		{
			level notify(#"hash_47c589e3f9abe85");
			while(!isalive(e_player))
			{
				waitframe(1);
			}
			level thread namespace_73e1c3e3::function_79957328(undefined);
			namespace_73e1c3e3::function_e44c5b8e(#"overwatch_helicopter", 25);
			e_player thread namespace_73e1c3e3::function_68848e5("overwatch_helicopter");
			level thread kill_all_zombies();
			wait(1.5);
			e_player = getplayers()[0];
			globallogic_score::_setplayermomentum(e_player, 0);
			e_player thread namespace_73e1c3e3::function_80bf685b(0);
			level thread function_bb44f289(10, 25, 0);
		}
		n_time = gettime() / 1000;
		dt = n_time - level.var_a86320e8;
		if(dt > 15)
		{
			level thread namespace_8c007aa6::function_41e59aeb(array(#"hash_4ec3d082638c7030"), 1);
			level.var_a86320e8 = n_time + 4;
		}
		waitframe(1);
	}
	level notify(#"hash_47c589e3f9abe85");
	waitframe(1);
	level thread kill_all_zombies();
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_41e59aeb(array(#"hash_2216c1d3d66ce"), 1);
}

/*
	Name: function_94c8f1d8
	Namespace: namespace_594230df
	Checksum: 0x6E7C3BA3
	Offset: 0x5678
	Size: 0x258
	Parameters: 1
	Flags: None
*/
function function_94c8f1d8(n_max_zombies)
{
	level endon(#"combattraining_logic_finished");
	var_856f9e3e = struct::get_array("s_vp_zombie_loc", "targetname");
	var_856f9e3e = array::randomize(var_856f9e3e);
	var_4001313 = 0;
	while(true)
	{
		a_ai = getaiarray();
		if(a_ai.size < n_max_zombies)
		{
			s_loc = var_856f9e3e[var_4001313];
			var_4001313++;
			if(var_4001313 >= var_856f9e3e.size)
			{
				var_4001313 = 0;
			}
			zombie = spawn_zombie(s_loc);
			zombie.var_ef59b90 = 6;
			zombie.overrideactordamage = &function_a5f160e7;
			zombie.health = int(zombie.health * 0.5);
			zombie val::set(#"zombie_vp", "ignoreme", 1);
			wait(0.3);
		}
		if(isdefined(level.var_79671f89) && level.var_79671f89)
		{
			break;
		}
		waitframe(1);
	}
	a_ai = getaiarray();
	foreach(ai in a_ai)
	{
		ai.var_ef59b90 = 3;
		ai val::reset(#"zombie_vp", "ignoreme");
	}
}

/*
	Name: function_a5f160e7
	Namespace: namespace_594230df
	Checksum: 0x6F3C7AF3
	Offset: 0x58D8
	Size: 0xDE
	Parameters: 12
	Flags: None
*/
function function_a5f160e7(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex)
{
	if(isdefined(einflictor) && einflictor.team == #"allies" && isbot(einflictor))
	{
		idamage = 1;
		if(randomint(100) < 80)
		{
			self.health = self.health + 1;
		}
	}
	return idamage;
}

/*
	Name: kill_all_zombies
	Namespace: namespace_594230df
	Checksum: 0x96117A01
	Offset: 0x59C0
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function kill_all_zombies()
{
	a_ai = getaiarray();
	foreach(ai in a_ai)
	{
		ai dodamage(ai.health + 100, ai.origin);
	}
}

/*
	Name: function_bb44f289
	Namespace: namespace_594230df
	Checksum: 0x107119F8
	Offset: 0x5A78
	Size: 0x22E
	Parameters: 3
	Flags: None
*/
function function_bb44f289(var_7e6c18d7, var_d8036031, var_8a787b15)
{
	level endon(#"combattraining_logic_finished", #"hash_47c589e3f9abe85");
	level.var_6cd64bc3 = 0;
	var_856f9e3e = struct::get_array("s_zombie_spawn_loc", "targetname");
	var_856f9e3e = array::randomize(var_856f9e3e);
	var_4001313 = 0;
	level.var_6f71c916 = var_d8036031;
	while(true)
	{
		e_player = getplayers()[0];
		a_zombies = function_75c5b3ae();
		var_70ff5c3a = a_zombies.size;
		if(isdefined(var_8a787b15) && var_8a787b15)
		{
			if(isdefined(e_player.var_d5d10814) && e_player.var_d5d10814)
			{
				break;
			}
		}
		if(level.var_6f71c916 == 0 && var_70ff5c3a == 0)
		{
			if(isdefined(var_8a787b15) && var_8a787b15)
			{
				level.var_6f71c916 = level.var_6f71c916 + 1;
			}
			else
			{
				break;
			}
		}
		a_zombies = function_75c5b3ae();
		if(level.var_6f71c916 && a_zombies.size < var_7e6c18d7)
		{
			s_loc = var_856f9e3e[var_4001313];
			var_4001313++;
			if(var_4001313 >= var_856f9e3e.size)
			{
				var_4001313 = 0;
			}
			spawn_zombie(s_loc);
			level.var_6f71c916 = level.var_6f71c916 - 1;
			wait(1);
		}
		waitframe(1);
	}
}

/*
	Name: spawn_zombie
	Namespace: namespace_594230df
	Checksum: 0x7DBA1516
	Offset: 0x5CB0
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function spawn_zombie(s_loc)
{
	zombie = namespace_cbd87dc5::spawn_zombie(s_loc.origin, 0, 1);
	zombie thread zombie_death_watcher();
	e_player = getplayers()[0];
	zombie.favoriteenemy = e_player;
	zombie.var_5a8f690 = 1;
	zombie.var_ea34ab74 = gettime() + 3600000;
	return zombie;
}

/*
	Name: spawn_blight_father
	Namespace: namespace_594230df
	Checksum: 0x9DA5D37
	Offset: 0x5D60
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function spawn_blight_father(s_loc)
{
	zombie = namespace_cbd87dc5::spawn_blight_father(s_loc.origin, 0, 0, 1);
	e_player = getplayers()[0];
	zombie.favoriteenemy = e_player;
	zombie.var_5a8f690 = 1;
	zombie.var_ea34ab74 = gettime() + 3600000;
	return zombie;
}

/*
	Name: zombie_death_watcher
	Namespace: namespace_594230df
	Checksum: 0x2242E6FA
	Offset: 0x5E00
	Size: 0x112
	Parameters: 0
	Flags: None
*/
function zombie_death_watcher()
{
	waitresult = undefined;
	waitresult = self waittill(#"death");
	if(isdefined(waitresult.attacker) && !isbot(waitresult.attacker))
	{
		e_player = namespace_73e1c3e3::get_player();
		if(!(isdefined(e_player.var_d5d10814) && e_player.var_d5d10814))
		{
			namespace_73e1c3e3::function_b3b2c91e();
		}
		e_player thread namespace_73e1c3e3::function_80bf685b(e_player.pers[#"momentum"]);
	}
	else
	{
		level.var_6f71c916 = level.var_6f71c916 + 1;
	}
	level.var_6cd64bc3 = level.var_6cd64bc3 + 1;
}

/*
	Name: function_79d4c106
	Namespace: namespace_594230df
	Checksum: 0x517CA0CE
	Offset: 0x5F20
	Size: 0x5FC
	Parameters: 0
	Flags: None
*/
function function_79d4c106()
{
	level endon(#"combattraining_logic_finished");
	e_player = getplayers()[0];
	var_7d5a0f5e = (e_player gamepadusedlast() ? #"hash_1c41d4b9d00defa5" : #"hash_7a1505df3fd0ed5b");
	e_player thread namespace_73e1c3e3::function_61c3d59c(var_7d5a0f5e, undefined);
	level thread namespace_8c007aa6::function_14b08e49(array(#"hash_2613f24ad4fa5cbc"), "stop_nag");
	setdvar(#"hash_3e06b14c41136e95", 0);
	e_player waittill(#"hash_7b84cc3c326479a6");
	setdvar(#"hash_3e06b14c41136e95", 1);
	level notify(#"stop_nag");
	namespace_73e1c3e3::function_daa27144();
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_831e0584(array(#"hash_373e680ef615b078", #"hash_373e690ef615b22b"), 1);
	e_player = getplayers()[0];
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_32598348d5a31069", undefined);
	e_player namespace_73e1c3e3::give_weapon("ray_gun");
	e_player thread namespace_d82263d5::function_1be7e4f(#"ray_gun");
	level thread function_bb44f289(10, 19, 0);
	wait(0.5);
	var_6256b329 = (gettime() / 1000) + 40;
	while(level.var_6f71c916)
	{
		n_time = gettime() / 1000;
		if(n_time >= var_6256b329)
		{
			level endon(#"hash_47c589e3f9abe85");
			break;
		}
		waitframe(1);
	}
	n_start_time = gettime() / 1000;
	while(true)
	{
		a_zombies = function_75c5b3ae();
		e_player = getplayers()[0];
		n_time = gettime() / 1000;
		dt = n_time - n_start_time;
		if(a_zombies.size == 0)
		{
			break;
		}
		else if(dt >= 30)
		{
			foreach(zombie in a_zombies)
			{
				zombie dodamage(zombie.health + 100, zombie.origin);
			}
			break;
		}
		else
		{
			foreach(zombie in a_zombies)
			{
				n_height_diff = abs(e_player.origin[2] - zombie.origin[2]);
				if(n_height_diff > 500)
				{
					zombie dodamage(zombie.health + 100, zombie.origin);
				}
			}
		}
		waitframe(1);
	}
	e_player = getplayers()[0];
	e_player namespace_64a487a9::function_26d45f32(1, 1, 1);
	level flag::set("ct_player_success");
	level notify(#"hash_47c589e3f9abe85");
	namespace_73e1c3e3::function_9aca2fa0("ct_endgame");
	namespace_73e1c3e3::function_c2a10fc();
	namespace_8c007aa6::function_831e0584(array(#"hash_398e7ff7d4d056d5"), 1);
	waitframe(1);
	level.var_77e9434e = 0;
	level thread namespace_8c007aa6::function_831e0584(array(#"hash_398e7ef7d4d05522"), 1);
	wait(0.1);
	namespace_8c007aa6::function_3ca1b77d();
}

/*
	Name: function_58c62280
	Namespace: namespace_594230df
	Checksum: 0x18723BEC
	Offset: 0x6528
	Size: 0x3A2
	Parameters: 3
	Flags: None
*/
function function_58c62280(n_goal_radius, b_ignoreall, b_keyline)
{
	s_loc = level.var_66b3c127[level.var_9f073b4];
	level.var_9f073b4++;
	if(level.var_9f073b4 >= level.var_66b3c127.size)
	{
		level.var_9f073b4 = 0;
	}
	if(isdefined(s_loc.radius))
	{
		n_goal_radius = s_loc.radius;
	}
	self endon(#"death");
	if(level.var_ad7c0539 == 6)
	{
		self setorigin(s_loc.origin);
		self setplayerangles(s_loc.angles);
	}
	else
	{
		self namespace_73e1c3e3::function_61d750d4(s_loc.origin, s_loc.angles);
	}
	self thread namespace_73e1c3e3::function_5b59f3b7(s_loc.origin, s_loc.angles, n_goal_radius);
	if(isdefined(level.b_hide_ai) && level.b_hide_ai)
	{
		self ghost();
	}
	if(isdefined(b_ignoreall) && b_ignoreall)
	{
		self val::set(#"bot_spawn", "ignoreall", 1);
	}
	if(isdefined(b_keyline) && b_keyline)
	{
		waitframe(1);
		if(self.team == #"allies")
		{
			self clientfield::set("player_keyline_render", 1);
		}
		else
		{
			self clientfield::set("enemy_keyline_render", 1);
		}
	}
	self.overrideplayerdamage = &function_6fb4cde7;
	if(isdefined(s_loc.script_noteworthy))
	{
		self.script_noteworthy = s_loc.script_noteworthy;
	}
	switch(level.var_ad7c0539)
	{
		case 1:
		{
			if(self.team == #"allies")
			{
				self thread function_1d2b336(s_loc);
			}
			else
			{
				self thread function_75345caf(s_loc);
			}
			break;
		}
		case 2:
		{
			self thread function_35bd7aef(s_loc);
			break;
		}
		case 3:
		{
			self val::reset(#"bot_spawn", "ignoreall");
			self thread function_9b0a398a(s_loc);
			break;
		}
		case 6:
		{
			self thread function_b1b0c7e9();
			break;
		}
	}
}

/*
	Name: function_b1b0c7e9
	Namespace: namespace_594230df
	Checksum: 0x7964A51C
	Offset: 0x68D8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function function_b1b0c7e9()
{
	self endon(#"death");
	wait(0.2);
	self namespace_64a487a9::function_991ccf1a();
}

/*
	Name: function_1d2b336
	Namespace: namespace_594230df
	Checksum: 0x71FD264D
	Offset: 0x6918
	Size: 0x306
	Parameters: 1
	Flags: None
*/
function function_1d2b336(s_start_loc)
{
	self endon(#"death");
	self val::set(#"hash_29c66fe4ec4332f6", "ignoreall", 1);
	self.health = 511;
	self namespace_73e1c3e3::give_weapon(#"ar_accurate_t8");
	b_crouched = 0;
	if(isdefined(s_start_loc.script_noteworthy) && s_start_loc.script_noteworthy == "crouch")
	{
		wait(0.5);
		b_crouched = 1;
		self namespace_9c817acd::crouch();
	}
	level waittill(#"hash_60c1587995518e92");
	self val::reset(#"hash_29c66fe4ec4332f6", "ignoreall");
	if(isdefined(b_crouched) && b_crouched)
	{
		self namespace_9c817acd::stand();
	}
	var_f0bbde5 = struct::get(s_start_loc.target, "targetname");
	self thread namespace_73e1c3e3::function_5b59f3b7(var_f0bbde5.origin, var_f0bbde5.angles, 32);
	while(true)
	{
		n_dist = distance(self.origin, var_f0bbde5.origin);
		if(n_dist < 50)
		{
			break;
		}
		waitframe(1);
	}
	level notify(#"hash_18806b37ec38ff49");
	b_crouched = 0;
	if(isdefined(var_f0bbde5.script_noteworthy) && var_f0bbde5.script_noteworthy == "crouch")
	{
		b_crouched = 1;
		self namespace_9c817acd::crouch();
	}
	s_loc = struct::get("s_vp_friendly_look_at_pos", "targetname");
	self.var_2925fedc = s_loc.origin;
	level waittill(#"hash_489196ae3f94aaf8");
	self namespace_ce5eff27::bot_set_difficulty(200, 400, 0.2);
	level waittill(#"hash_3a0d770bcea202fd");
	if(self.health > 150)
	{
		self.health = 150;
	}
}

/*
	Name: function_75345caf
	Namespace: namespace_594230df
	Checksum: 0xEFDD3760
	Offset: 0x6C28
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_75345caf(s_start_loc)
{
	self endon(#"death");
	level waittill(#"hash_3c13162d215d8698");
	wait(1);
	self clientfield::set("enemy_keyline_render", 1);
	s_loc = struct::get("s_enemy_vp_loc", "targetname");
	self thread namespace_73e1c3e3::function_f3b02850(s_loc, 32);
}

/*
	Name: function_bbb1aed5
	Namespace: namespace_594230df
	Checksum: 0x941B2EEF
	Offset: 0x6CD8
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function function_bbb1aed5()
{
	self endon(#"death");
	s_loc = level.var_66b3c127[level.var_9f073b4];
	level.var_9f073b4++;
	if(level.var_9f073b4 >= level.var_66b3c127.size)
	{
		level.var_9f073b4 = 0;
	}
	self setorigin(s_loc.origin);
	self setplayerangles(s_loc.angles);
	self.s_loc = s_loc;
	s_loc = level.var_a32f4757[level.var_1c1866de];
	level.var_1c1866de++;
	if(level.var_1c1866de >= level.var_a32f4757.size)
	{
		level.var_1c1866de = 0;
	}
	self thread namespace_cbd87dc5::function_12f9ed01(array(s_loc));
}

/*
	Name: function_9b0a398a
	Namespace: namespace_594230df
	Checksum: 0x177BC872
	Offset: 0x6E10
	Size: 0x4C4
	Parameters: 1
	Flags: None
*/
function function_9b0a398a(s_loc)
{
	self endon(#"death");
	n_start_health = self.health;
	self val::set(#"bot", "ignoreall", 1);
	self val::set(#"bot", "ignoreme", 1);
	s_path = struct::get(s_loc.target, "targetname");
	self thread namespace_73e1c3e3::function_f3b02850(s_loc, 48);
	self namespace_9c817acd::crouch();
	wait(0.5);
	n_start_time = gettime() / 1000;
	var_3a9de7bb = 0;
	var_e4e157c8 = 0;
	var_49f58f36 = 1;
	while(true)
	{
		n_time = gettime() / 1000;
		e_player = getplayers()[0];
		dt = n_time - n_start_time;
		if(dt > 7)
		{
			if(isdefined(var_49f58f36) && var_49f58f36)
			{
				var_49f58f36 = 0;
				self val::reset(#"bot", "ignoreme");
			}
			var_e4e157c8 = 1;
			if(dt > 11)
			{
				n_dist = distance(e_player.origin, self.origin);
				if(n_dist < 320)
				{
					self notify(#"hash_6874a1e812989791");
					break;
				}
			}
		}
		if(isdefined(self.var_59943abb) && self.var_59943abb && !var_3a9de7bb)
		{
			v_dir = anglestoforward(self.s_path_end.angles);
			v_pos = self.origin + (v_dir * 100);
			self.var_2925fedc = v_pos;
			var_3a9de7bb = 1;
		}
		if(self.health != n_start_health)
		{
			self notify(#"hash_6874a1e812989791");
			break;
		}
		if(isdefined(var_e4e157c8) && var_e4e157c8)
		{
			e_player = getplayers()[0];
			v_eye = e_player util::get_eye();
			if(self namespace_73e1c3e3::can_see(v_eye, 1))
			{
				self notify(#"hash_6874a1e812989791");
				break;
			}
		}
		if(isdefined(level.var_4fbc6865) && level.var_4fbc6865)
		{
			self notify(#"hash_6874a1e812989791");
			break;
		}
		if(isdefined(e_player))
		{
			a_bots = e_player namespace_64a487a9::function_dde6edbd();
			if(a_bots.size < 2)
			{
				self notify(#"hash_6874a1e812989791");
				break;
			}
		}
		else
		{
			self notify(#"hash_6874a1e812989791");
			break;
		}
		waitframe(1);
	}
	level.var_823fa371 = 1;
	self namespace_9c817acd::stand();
	self val::reset(#"bot", "ignoreall");
	self.var_2925fedc = undefined;
	s_path = level.var_271da9fa[level.var_acc24708];
	level.var_acc24708++;
	if(level.var_acc24708 >= level.var_271da9fa.size)
	{
		level.var_acc24708 = 0;
	}
	namespace_73e1c3e3::function_1e7b75f2(s_path);
}

/*
	Name: function_78ccee50
	Namespace: namespace_594230df
	Checksum: 0xC05D38B7
	Offset: 0x72E0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_78ccee50(params)
{
	level.var_4fbc6865 = 1;
}

/*
	Name: function_35bd7aef
	Namespace: namespace_594230df
	Checksum: 0xEBEE712E
	Offset: 0x7308
	Size: 0x22C
	Parameters: 1
	Flags: None
*/
function function_35bd7aef(s_loc)
{
	self endon(#"death");
	self val::set(#"hash_6c6879fd201896d3", "ignoreall", 1);
	self val::set(#"hash_6c6879fd201896d3", "ignoreme", 1);
	self thread namespace_73e1c3e3::function_5b59f3b7(self.origin, self.angles, 32);
	level waittill(#"hash_439e586d5a4210cd");
	self val::reset(#"hash_6c6879fd201896d3", "ignoreme");
	n_delay = randomfloatrange(0.2, 0.8);
	wait(n_delay);
	s_target = struct::get(s_loc.target, "targetname");
	self thread namespace_73e1c3e3::function_5b59f3b7(s_target.origin, s_target.angles, 32);
	self.favoriteenemy = getplayers()[0];
	wait(3);
	self val::reset(#"hash_6c6879fd201896d3", "ignoreall");
	s_path = level.var_28cbbd60[level.var_68629f1];
	level.var_68629f1++;
	if(level.var_68629f1 >= level.var_28cbbd60.size)
	{
		level.var_68629f1 = 0;
	}
	self thread namespace_73e1c3e3::function_1e7b75f2(s_path);
}

/*
	Name: function_75c5b3ae
	Namespace: namespace_594230df
	Checksum: 0xB8DDF32F
	Offset: 0x7540
	Size: 0xD8
	Parameters: 0
	Flags: None
*/
function function_75c5b3ae()
{
	a_zombies = getaiarray();
	foreach(zombie in a_zombies)
	{
		if(isdefined(zombie.weapon) && zombie.weapon.name == #"eq_sensor")
		{
			arrayremovevalue(a_zombies, zombie);
			break;
		}
	}
	return a_zombies;
}

