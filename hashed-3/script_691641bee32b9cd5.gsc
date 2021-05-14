// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_582ea754d1948f83;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_96ff9fb2;

/*
	Name: function_89f2df9
	Namespace: namespace_96ff9fb2
	Checksum: 0x592F3965
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("wave_manager", &__init__, &__main__, undefined);
}

#namespace namespace_e72c95;

/*
	Name: __constructor
	Namespace: namespace_e72c95
	Checksum: 0x14029FC
	Offset: 0x228
	Size: 0x4A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_376c2c29 = [];
	self.var_4417045b = 1;
	self.var_23802722 = [];
	self.var_246fb97f = [];
	self.var_a709a080 = 0;
	self.var_6da7cde5 = 1;
}

/*
	Name: __destructor
	Namespace: namespace_e72c95
	Checksum: 0x80F724D1
	Offset: 0x280
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_96ff9fb2;

/*
	Name: function_e72c95
	Namespace: namespace_96ff9fb2
	Checksum: 0x6172D0DC
	Offset: 0x290
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_e72c95()
{
	classes.var_e72c95[0] = spawnstruct();
	classes.var_e72c95[0].__vtable[913321084] = &namespace_e72c95::__destructor;
	classes.var_e72c95[0].__vtable[674154906] = &namespace_e72c95::__constructor;
}

#namespace namespace_2443998c;

/*
	Name: __constructor
	Namespace: namespace_2443998c
	Checksum: 0xD007D7D2
	Offset: 0x320
	Size: 0x1A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_bcd4e683 = 0;
	self.var_bb290b79 = [];
}

/*
	Name: __destructor
	Namespace: namespace_2443998c
	Checksum: 0x80F724D1
	Offset: 0x348
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_96ff9fb2;

/*
	Name: function_2443998c
	Namespace: namespace_96ff9fb2
	Checksum: 0x3D223421
	Offset: 0x358
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_2443998c()
{
	classes.var_2443998c[0] = spawnstruct();
	classes.var_2443998c[0].__vtable[913321084] = &namespace_2443998c::__destructor;
	classes.var_2443998c[0].__vtable[674154906] = &namespace_2443998c::__constructor;
}

/*
	Name: __init__
	Namespace: namespace_96ff9fb2
	Checksum: 0x4331BCFC
	Offset: 0x3E8
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
private function __init__()
{
	level.var_ca74a4bc = [];
	level.var_a3688653 = [];
	/#
		setdvar(#"hash_1feb7de8a9fa6573", -1);
		level thread function_c4c03054();
	#/
}

/*
	Name: __main__
	Namespace: namespace_96ff9fb2
	Checksum: 0x8DC2FCE5
	Offset: 0x450
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	level.var_a3688653 = struct::get_script_bundle_instances("wave_manager");
	foreach(s_wave_manager in level.var_a3688653)
	{
		s_wave_manager flag::init("wave_manager_started");
		s_wave_manager function_51ce850d();
	}
	level function_374e4d47();
	level function_ad40f5b3();
}

/*
	Name: function_b14456ef
	Namespace: namespace_96ff9fb2
	Checksum: 0x156E9F5D
	Offset: 0x548
	Size: 0x1A4
	Parameters: 0
	Flags: Private
*/
private function function_b14456ef()
{
	/#
		if(!isdefined(level.var_a44d1e7))
		{
			level.var_a44d1e7 = 0;
		}
		level.var_a44d1e7++;
		str_map_name = util::function_53bbf9d2();
		foreach(var_dcd6c23 in level.var_ca74a4bc)
		{
			var_29b80910 = var_dcd6c23.var_cf3bea8a;
			str_team = var_dcd6c23.m_str_team;
			str_name = var_dcd6c23.var_556afb3d;
			cmd = "" + str_map_name + "" + str_team + "" + "" + var_29b80910 + "" + str_name + "" + var_29b80910 + "";
			adddebugcommand(cmd);
		}
		cmd = "" + str_map_name + "";
		adddebugcommand(cmd);
	#/
}

/*
	Name: function_c4c03054
	Namespace: namespace_96ff9fb2
	Checksum: 0xF00141FC
	Offset: 0x6F8
	Size: 0xE5A
	Parameters: 0
	Flags: Private
*/
private function function_c4c03054()
{
	/#
		while(true)
		{
			n_wave_manager_id = getdvarint(#"hash_1feb7de8a9fa6573", 0);
			if(n_wave_manager_id != -1)
			{
				if(isdefined(level.var_ca74a4bc[n_wave_manager_id]))
				{
					n_y_offset = 22;
					var_90fbd845 = 22;
					var_c708e6e1 = 120;
					var_dcd6c23 = level.var_ca74a4bc[n_wave_manager_id];
					var_29b80910 = var_dcd6c23.var_cf3bea8a;
					str_name = var_dcd6c23.var_556afb3d;
					if(var_dcd6c23 flag::get(""))
					{
						/#
							var_c708e6e1 = var_c708e6e1 + n_y_offset;
							str_text = str_name + "";
							debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
							var_c708e6e1 = var_c708e6e1 + n_y_offset;
							debug2dtext((800, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
						#/
						waitframe(1);
						continue;
					}
					if(isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980 && var_dcd6c23.var_4417045b > var_dcd6c23.var_592f8f7f)
					{
						waitframe(1);
						continue;
					}
					str_team = var_dcd6c23.m_str_team;
					/#
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						debug2dtext((800, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					#/
					if(isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980)
					{
						str_status = "";
					}
					else if(function_e43e16d2(var_dcd6c23))
					{
						str_status = "";
					}
					else
					{
						str_status = "";
					}
					/#
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						str_text = str_name + "" + str_status + "";
						debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						debug2dtext((800, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					#/
					if(function_a2115dc4(var_dcd6c23, var_dcd6c23.var_4417045b))
					{
						str_status = "";
					}
					else if(function_e43e16d2(var_dcd6c23, var_dcd6c23.var_4417045b))
					{
						str_status = "";
					}
					else
					{
						str_status = "";
					}
					/#
						str_text = "" + var_dcd6c23.var_4417045b + "" + var_dcd6c23.var_592f8f7f + "" + str_status + "";
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						debug2dtext((800, var_c708e6e1, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
					#/
					n_total_count = 0;
					var_a549e716 = 0;
					foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
					{
						n_total_count = n_total_count + var_c21b798e.var_23791f08;
						var_a549e716 = var_a549e716 + var_c21b798e.var_a4202481;
					}
					/#
						str_text = "" + n_total_count + "" + var_a549e716 + "";
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						debug2dtext((800, var_c708e6e1, 0), str_text, (0, 1, 0), 1, (0, 0, 0), 0.9, 1, 1);
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						debug2dtext((800, var_c708e6e1, 0), "", (0, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
					#/
					if(isdefined(var_dcd6c23.var_376c2c29))
					{
						var_c708e6e1 = var_c708e6e1 + n_y_offset;
						var_1d3b29d6 = 1;
						foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
						{
							if(function_f77ad8a3(var_c21b798e))
							{
								str_status = "";
							}
							else if(function_9e2b33f4(var_c21b798e))
							{
								str_status = "";
							}
							else
							{
								str_status = "";
							}
							/#
								str_text = "" + var_1d3b29d6 + "" + var_c21b798e.var_bcd4e683 + "" + var_c21b798e.var_23791f08 + "" + str_status + "";
								debug2dtext((800, var_c708e6e1, 0), str_text, (1, 1, 1), 1, (0, 0, 0), 0.9, 1, 1);
								var_c708e6e1 = var_c708e6e1 + var_90fbd845;
							#/
							var_1d3b29d6++;
						}
					}
					if(isdefined(var_dcd6c23.var_376c2c29))
					{
						var_1d3b29d6 = 1;
						foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
						{
							foreach(ai in var_c21b798e.var_bb290b79)
							{
								if(isdefined(ai))
								{
									/#
										sphere(ai.origin, 4, (0, 0, 1), 1, 0, 8, 1);
										print3d(ai.origin + vectorscale((0, 0, 1), 10), "" + var_dcd6c23.var_4417045b + "" + var_1d3b29d6, (0, 0, 1), 1, 0.5, 1);
									#/
									if(isdefined(var_dcd6c23.var_3844e966))
									{
										/#
											line(ai.origin + vectorscale((0, 0, 1), 30), var_dcd6c23.var_3844e966.origin, (0, 0, 1), 1, 0, 1);
										#/
										continue;
									}
									if(isdefined(level.players[0]))
									{
										/#
											origin = level.players[0].origin + vectorscale(anglestoforward(level.players[0].angles), 100);
											line(ai.origin + vectorscale((0, 0, 1), 30), origin, (0, 0, 1), 1, 0, 1);
										#/
									}
								}
							}
							var_1d3b29d6++;
						}
					}
					if(isdefined(var_dcd6c23.var_419edb9f))
					{
						foreach(var_c082553f, v in var_dcd6c23.var_419edb9f)
						{
							foreach(ai in v)
							{
								if(isdefined(ai))
								{
									/#
										sphere(ai.origin, 4, (1, 0, 0), 1, 0, 8, 1);
										print3d(ai.origin + vectorscale((0, 0, 1), 10), "" + var_c082553f, (1, 0, 0), 1, 0.5, 1);
									#/
									if(isdefined(var_dcd6c23.var_3844e966))
									{
										/#
											line(ai.origin + vectorscale((0, 0, 1), 30), var_dcd6c23.var_3844e966.origin, (1, 0, 0), 1, 0, 1);
										#/
										continue;
									}
									if(isdefined(level.players[0]))
									{
										/#
											origin = level.players[0].origin + vectorscale(anglestoforward(level.players[0].angles), 100);
											line(ai.origin + vectorscale((0, 0, 1), 30), origin, (1, 0, 0), 1, 0, 1);
										#/
									}
								}
							}
						}
					}
					if(isdefined(var_dcd6c23.var_3844e966))
					{
						/#
							sphere(var_dcd6c23.var_3844e966.origin, 30, (0, 0, 1), 1, 0, 20, 1);
						#/
					}
					if(isdefined(var_dcd6c23.var_246fb97f) && isarray(var_dcd6c23.var_246fb97f))
					{
						foreach(var_fa24a14b in var_dcd6c23.var_246fb97f)
						{
							/#
								sphere(var_fa24a14b.origin, 4, (0, 1, 0), 1, 0, 8, 1);
								print3d(var_fa24a14b.origin + vectorscale((0, 0, 1), 10), function_9e72a96(var_fa24a14b.archetype), (0, 1, 0), 1, 0.5, 1);
								line(var_fa24a14b.origin, var_fa24a14b.origin + vectorscale((0, 0, 1), 45), (0, 1, 0), 1, 0, 1);
							#/
						}
					}
				}
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_51ce850d
	Namespace: namespace_96ff9fb2
	Checksum: 0x80D5FD94
	Offset: 0x1560
	Size: 0x15C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_51ce850d()
{
	self namespace_2e6206f9::function_278f9455("script_enable_on_success", &wave_manager::start);
	self namespace_2e6206f9::function_278f9455("script_enable_on_failure", &wave_manager::start);
	self namespace_2e6206f9::function_278f9455("script_enable_no_specialist", &wave_manager::start);
	self namespace_2e6206f9::function_278f9455("script_disable_on_success", &wave_manager::stop);
	self namespace_2e6206f9::function_278f9455("script_disable_on_failure", &wave_manager::stop);
	self namespace_2e6206f9::function_c6dbc898("breadcrumb", "script_enable_on_success", &function_710cbc75);
	self namespace_2e6206f9::function_c6dbc898("breadcrumb", "script_enable_on_failure", &function_710cbc75);
	self namespace_2e6206f9::function_c6dbc898("breadcrumb", "script_enable_no_specialist", &function_710cbc75);
}

/*
	Name: function_374e4d47
	Namespace: namespace_96ff9fb2
	Checksum: 0x74C3A017
	Offset: 0x16C8
	Size: 0x148
	Parameters: 0
	Flags: Linked, Private
*/
private function function_374e4d47()
{
	foreach(var_7418aa09 in trigger::get_all())
	{
		var_a40eadd = [];
		foreach(s_wave_manager in level.var_a3688653)
		{
			if(isdefined(var_7418aa09.target) && var_7418aa09.target === s_wave_manager.targetname)
			{
				array::add(var_a40eadd, s_wave_manager);
			}
		}
		if(var_a40eadd.size)
		{
			var_7418aa09 thread function_be478e08(var_a40eadd);
		}
	}
}

/*
	Name: function_be478e08
	Namespace: namespace_96ff9fb2
	Checksum: 0x5217E063
	Offset: 0x1818
	Size: 0xA8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_be478e08(var_a40eadd)
{
	self endon(#"death");
	self trigger::wait_till();
	foreach(s_wave_manager in var_a40eadd)
	{
		s_wave_manager wave_manager::start();
	}
}

/*
	Name: function_ad40f5b3
	Namespace: namespace_96ff9fb2
	Checksum: 0xA5AAD17C
	Offset: 0x18C8
	Size: 0x1D8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ad40f5b3()
{
	foreach(s_wave_manager in level.var_a3688653)
	{
		if(isdefined(level.skipto_current_objective) && isdefined(s_wave_manager.var_4053bf4d))
		{
			foreach(str_skipto in level.skipto_current_objective)
			{
				if(str_skipto == s_wave_manager.var_4053bf4d)
				{
					s_wave_manager wave_manager::start();
					s_wave_manager.var_f50b617f = 1;
				}
			}
		}
	}
	foreach(s_wave_manager in level.var_a3688653)
	{
		if(isdefined(s_wave_manager.script_enable_on_start) && s_wave_manager.script_enable_on_start && (!(isdefined(s_wave_manager.var_f50b617f) && s_wave_manager.var_f50b617f)))
		{
			s_wave_manager wave_manager::start();
		}
	}
}

/*
	Name: function_710cbc75
	Namespace: namespace_96ff9fb2
	Checksum: 0xBF532DC8
	Offset: 0x1AA8
	Size: 0x34
	Parameters: 3
	Flags: Linked, Private
*/
private function function_710cbc75(e_player, var_1ad9db60, b_branch)
{
	function_3ff920ca(self);
}

/*
	Name: init_flags
	Namespace: namespace_96ff9fb2
	Checksum: 0xFC13E085
	Offset: 0x1AE8
	Size: 0x14E
	Parameters: 1
	Flags: Linked, Private
*/
private function init_flags(var_dcd6c23)
{
	/#
		assert(isdefined(var_dcd6c23));
	#/
	var_dcd6c23 flag::init("complete");
	var_dcd6c23 flag::init("cleared");
	var_dcd6c23 flag::init("paused");
	var_dcd6c23 flag::init("stopped");
	var_dcd6c23 flag::init("all_dead");
	for(n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++)
	{
		var_dcd6c23 flag::init("wave" + n_wave + "_complete");
		var_dcd6c23 flag::init("wave" + n_wave + "_cleared");
	}
}

/*
	Name: reset
	Namespace: namespace_96ff9fb2
	Checksum: 0x69C615BD
	Offset: 0x1C40
	Size: 0xFE
	Parameters: 1
	Flags: Linked, Private
*/
private function reset(var_dcd6c23)
{
	/#
		assert(isdefined(var_dcd6c23));
	#/
	var_dcd6c23 flag::clear("complete");
	var_dcd6c23 flag::clear("cleared");
	for(n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++)
	{
		var_dcd6c23 flag::clear("wave" + n_wave + "_complete");
		var_dcd6c23 flag::clear("wave" + n_wave + "_cleared");
	}
	var_dcd6c23.var_4417045b = 1;
}

/*
	Name: function_68766ec1
	Namespace: namespace_96ff9fb2
	Checksum: 0xFA97935
	Offset: 0x1D48
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_68766ec1(var_dcd6c23)
{
	var_dcd6c23 flag::set("wave" + var_dcd6c23.var_4417045b + "_complete");
	if(var_dcd6c23.var_4417045b == var_dcd6c23.var_592f8f7f)
	{
		var_dcd6c23 flag::set("complete");
	}
}

/*
	Name: function_e43e16d2
	Namespace: namespace_96ff9fb2
	Checksum: 0xF63ECC6A
	Offset: 0x1DD0
	Size: 0x6A
	Parameters: 2
	Flags: Private
*/
private function function_e43e16d2(var_dcd6c23, n_wave)
{
	if(isdefined(n_wave))
	{
		return var_dcd6c23 flag::get("wave" + n_wave + "_complete");
	}
	return var_dcd6c23 flag::get("complete");
}

/*
	Name: function_aa6a8e4a
	Namespace: namespace_96ff9fb2
	Checksum: 0xFF528571
	Offset: 0x1E48
	Size: 0x6C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_aa6a8e4a(var_dcd6c23, n_wave)
{
	if(isdefined(n_wave))
	{
		var_dcd6c23 flag::wait_till("wave" + n_wave + "_complete");
	}
	else
	{
		var_dcd6c23 flag::wait_till("complete");
	}
}

/*
	Name: function_2bba6468
	Namespace: namespace_96ff9fb2
	Checksum: 0x57B887
	Offset: 0x1EC0
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2bba6468(var_dcd6c23)
{
	var_dcd6c23 flag::set("wave" + var_dcd6c23.var_4417045b + "_cleared");
	if(var_dcd6c23.var_4417045b == var_dcd6c23.var_592f8f7f)
	{
		function_d9af887b(var_dcd6c23);
	}
}

/*
	Name: function_a2115dc4
	Namespace: namespace_96ff9fb2
	Checksum: 0x60A25C29
	Offset: 0x1F40
	Size: 0x6A
	Parameters: 2
	Flags: Private
*/
private function function_a2115dc4(var_dcd6c23, n_wave)
{
	if(isdefined(n_wave))
	{
		return var_dcd6c23 flag::get("wave" + n_wave + "_cleared");
	}
	return var_dcd6c23 flag::get("cleared");
}

/*
	Name: function_55525f13
	Namespace: namespace_96ff9fb2
	Checksum: 0x1E6E1F0
	Offset: 0x1FB8
	Size: 0x9C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_55525f13(var_dcd6c23, n_wave, var_b8b3e39d)
{
	if(isdefined(n_wave))
	{
		var_dcd6c23 flag::wait_till("wave" + n_wave + "_cleared");
	}
	else if(var_b8b3e39d)
	{
		var_dcd6c23 flag::wait_till("all_dead");
	}
	else
	{
		var_dcd6c23 flag::wait_till("cleared");
	}
}

/*
	Name: function_d9af887b
	Namespace: namespace_96ff9fb2
	Checksum: 0x8DE3E2C4
	Offset: 0x2060
	Size: 0x258
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d9af887b(var_dcd6c23)
{
	var_dcd6c23 flag::set("cleared");
	if(isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980)
	{
		return;
	}
	var_dcd6c23 flag::set("stopped");
	var_dcd6c23.var_3844e966 = undefined;
	var_dcd6c23.m_s_bundle = undefined;
	var_dcd6c23.var_376c2c29 = undefined;
	var_dcd6c23.var_4417045b = undefined;
	var_dcd6c23.var_592f8f7f = undefined;
	var_dcd6c23.var_23802722 = undefined;
	var_dcd6c23.var_246fb97f = undefined;
	if(isdefined(var_dcd6c23.var_419edb9f))
	{
		if(var_dcd6c23.var_a709a080)
		{
			foreach(var_13528014 in var_dcd6c23.var_419edb9f)
			{
				var_13528014 = array::remove_dead(var_13528014);
				array::thread_all(var_13528014, &util::auto_delete);
			}
		}
		thread function_30956db0(var_dcd6c23);
		if(var_dcd6c23.var_6da7cde5)
		{
			a_spawners = getspawnerarray(var_dcd6c23.var_27eacb34, "targetname");
			if(isdefined(a_spawners) && a_spawners.size)
			{
				foreach(spawner in a_spawners)
				{
					if(isdefined(spawner))
					{
						spawner delete();
					}
				}
			}
		}
	}
}

/*
	Name: function_4810b274
	Namespace: namespace_96ff9fb2
	Checksum: 0x9661876E
	Offset: 0x22C0
	Size: 0x19E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4810b274(var_dcd6c23, b_auto_delete)
{
	if(var_dcd6c23 flag::get("stopped") || (var_dcd6c23 flag::get("cleared") && (!(isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980))))
	{
		return;
	}
	if(b_auto_delete)
	{
		var_dcd6c23.var_a709a080 = 1;
	}
	function_68ed489(var_dcd6c23);
	var_dcd6c23 flag::set("stopped");
	var_dcd6c23 flag::set("complete");
	for(n_wave = 1; n_wave <= var_dcd6c23.var_592f8f7f; n_wave++)
	{
		var_dcd6c23 flag::set("wave" + n_wave + "_complete");
		if(var_dcd6c23.var_4417045b < n_wave)
		{
			var_dcd6c23 flag::set("wave" + n_wave + "_cleared");
		}
	}
	var_dcd6c23.var_592f8f7f = var_dcd6c23.var_4417045b;
}

/*
	Name: function_3ff920ca
	Namespace: namespace_96ff9fb2
	Checksum: 0x8CB860AD
	Offset: 0x2468
	Size: 0x450
	Parameters: 6
	Flags: Linked, Private
*/
private function function_3ff920ca(s_wave_manager_struct, str_team, b_looping, str_wavemanager, str_spawner_targets, var_e8332bc1)
{
	object = new var_e72c95();
	[[ object ]]->__constructor();
	var_dcd6c23 = object;
	var_dcd6c23.m_s_bundle = struct::get_script_bundle("wave_manager", (isdefined(str_wavemanager) ? str_wavemanager : s_wave_manager_struct.scriptbundlename));
	var_dcd6c23.var_cf3bea8a = get_unique_id();
	var_dcd6c23.var_556afb3d = var_dcd6c23.m_s_bundle.name;
	if(isdefined(s_wave_manager_struct))
	{
		var_dcd6c23.var_3844e966 = s_wave_manager_struct;
		s_wave_manager_struct.var_dcd6c23 = var_dcd6c23;
		if(isdefined(s_wave_manager_struct.target))
		{
			var_dcd6c23.var_27eacb34 = s_wave_manager_struct.target;
		}
		var_dcd6c23.m_str_team = util::get_team_mapping(s_wave_manager_struct.script_team);
		var_dcd6c23.var_f68bc980 = isdefined(s_wave_manager_struct.script_looping) && s_wave_manager_struct.script_looping;
		var_dcd6c23.var_a709a080 = isdefined(s_wave_manager_struct.var_8e0ed81f) && s_wave_manager_struct.var_8e0ed81f;
		if(isdefined(s_wave_manager_struct.var_a69f424f))
		{
			foreach(var_7635207b in s_wave_manager_struct.var_a69f424f)
			{
				if(!isdefined(var_dcd6c23.var_23802722))
				{
					var_dcd6c23.var_23802722 = [];
				}
				else if(!isarray(var_dcd6c23.var_23802722))
				{
					var_dcd6c23.var_23802722 = array(var_dcd6c23.var_23802722);
				}
				if(!isinarray(var_dcd6c23.var_23802722, var_7635207b))
				{
					var_dcd6c23.var_23802722[var_dcd6c23.var_23802722.size] = var_7635207b;
				}
			}
		}
	}
	else
	{
		var_dcd6c23.m_str_team = str_team;
		var_dcd6c23.var_f68bc980 = b_looping;
		if(isdefined(str_spawner_targets))
		{
			var_dcd6c23.var_27eacb34 = str_spawner_targets;
		}
	}
	var_dcd6c23.var_592f8f7f = var_dcd6c23.m_s_bundle.wavecount;
	if(isdefined(var_e8332bc1))
	{
		if(!isdefined(var_dcd6c23.var_23802722))
		{
			var_dcd6c23.var_23802722 = [];
		}
		else if(!isarray(var_dcd6c23.var_23802722))
		{
			var_dcd6c23.var_23802722 = array(var_dcd6c23.var_23802722);
		}
		if(!isinarray(var_dcd6c23.var_23802722, var_e8332bc1))
		{
			var_dcd6c23.var_23802722[var_dcd6c23.var_23802722.size] = var_e8332bc1;
		}
	}
	level.var_ca74a4bc[var_dcd6c23.var_cf3bea8a] = var_dcd6c23;
	init_flags(var_dcd6c23);
	thread think(var_dcd6c23);
	/#
		function_b14456ef();
	#/
	if(isdefined(s_wave_manager_struct))
	{
		s_wave_manager_struct flag::set("wave_manager_started");
	}
	return var_dcd6c23;
}

/*
	Name: think
	Namespace: namespace_96ff9fb2
	Checksum: 0x517E104B
	Offset: 0x28C0
	Size: 0x662
	Parameters: 1
	Flags: Linked, Private
*/
private function think(var_dcd6c23)
{
	while(true)
	{
		if(var_dcd6c23 flag::get("stopped"))
		{
			break;
		}
		if(var_dcd6c23.var_4417045b > var_dcd6c23.var_592f8f7f)
		{
			if(isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980)
			{
				reset(var_dcd6c23);
			}
			else
			{
				break;
			}
		}
		var_ed407c11 = var_dcd6c23.m_s_bundle.waves[var_dcd6c23.var_4417045b - 1];
		var_4e56e285 = (isdefined(var_ed407c11.transitioncount) ? var_ed407c11.transitioncount : 0);
		var_b7681e7b = (isdefined(var_ed407c11.transitiondelaymin) ? var_ed407c11.transitiondelaymin : 0);
		var_711b891b = (isdefined(var_ed407c11.transitiondelaymax) ? var_ed407c11.transitiondelaymax : 0);
		if(var_b7681e7b < var_711b891b)
		{
			var_791750f5 = randomfloatrange(var_b7681e7b, var_711b891b);
		}
		else
		{
			var_791750f5 = var_b7681e7b;
		}
		var_dcd6c23.var_376c2c29 = [];
		for(var_f5d6a44e = 0; var_f5d6a44e < var_ed407c11.spawns.size; var_f5d6a44e++)
		{
			var_a2b4b991 = var_ed407c11.spawns[var_f5d6a44e];
			if(function_d081cf72(var_a2b4b991))
			{
				object = new var_2443998c();
				[[ object ]]->__constructor();
				var_c21b798e = object;
				var_c21b798e.var_4fb3156c = var_a2b4b991;
				var_c21b798e.m_n_index = var_f5d6a44e;
				if(!isdefined(var_dcd6c23.var_376c2c29))
				{
					var_dcd6c23.var_376c2c29 = [];
				}
				else if(!isarray(var_dcd6c23.var_376c2c29))
				{
					var_dcd6c23.var_376c2c29 = array(var_dcd6c23.var_376c2c29);
				}
				var_dcd6c23.var_376c2c29[var_dcd6c23.var_376c2c29.size] = var_c21b798e;
				thread function_8f5ed189(var_dcd6c23, var_c21b798e);
				continue;
			}
			/#
				println("" + var_f5d6a44e + 1 + "");
				iprintln("" + var_f5d6a44e + 1 + "");
			#/
		}
		while(true)
		{
			b_transition_into_next_wave = 1;
			b_wave_complete = 1;
			b_wave_cleared = 1;
			foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
			{
				if(!function_9e2b33f4(var_c21b798e))
				{
					b_wave_complete = 0;
					break;
				}
			}
			if(!isdefined(var_4e56e285) || var_4e56e285 == 0)
			{
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					if(!function_f77ad8a3(var_c21b798e))
					{
						b_wave_cleared = 0;
						b_transition_into_next_wave = 0;
						break;
					}
				}
			}
			else if(b_wave_complete)
			{
				var_179ea866 = 0;
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					if(isdefined(var_c21b798e.var_bb290b79))
					{
						var_179ea866 = var_179ea866 + var_c21b798e.var_bb290b79.size;
					}
				}
				if(var_179ea866 > var_4e56e285)
				{
					b_wave_cleared = 0;
					b_transition_into_next_wave = 0;
				}
			}
			else
			{
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					if(!function_f77ad8a3(var_c21b798e))
					{
						b_wave_cleared = 0;
						b_transition_into_next_wave = 0;
						break;
					}
				}
			}
			if(b_wave_complete)
			{
				function_68766ec1(var_dcd6c23);
			}
			if(b_wave_cleared)
			{
				function_68ed489(var_dcd6c23);
				function_2bba6468(var_dcd6c23);
			}
			if(b_transition_into_next_wave)
			{
				break;
			}
			wait(0.1);
		}
		if(isdefined(var_dcd6c23.var_4417045b))
		{
			var_dcd6c23.var_4417045b++;
		}
		wait(var_791750f5 + 0.1);
	}
}

/*
	Name: function_ff49692b
	Namespace: namespace_96ff9fb2
	Checksum: 0x81F29AEC
	Offset: 0x2F30
	Size: 0x100
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ff49692b(var_dcd6c23, ai)
{
	/#
		assert(isdefined(var_dcd6c23), "");
	#/
	/#
		assert(isdefined(ai), "");
	#/
	if(isdefined(var_dcd6c23.var_23802722))
	{
		foreach(var_e8332bc1 in var_dcd6c23.var_23802722)
		{
			if(isdefined(var_e8332bc1.var_964c77e1))
			{
				util::single_thread_argarray(ai, var_e8332bc1.var_964c77e1, var_e8332bc1.a_params);
			}
		}
	}
}

/*
	Name: function_68ed489
	Namespace: namespace_96ff9fb2
	Checksum: 0x2BA55A6E
	Offset: 0x3038
	Size: 0x284
	Parameters: 1
	Flags: Linked, Private
*/
private function function_68ed489(var_dcd6c23)
{
	if(!isdefined(var_dcd6c23.var_419edb9f))
	{
		var_dcd6c23.var_419edb9f = [];
	}
	foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
	{
		var_c21b798e.var_bb290b79 = array::remove_dead(var_c21b798e.var_bb290b79);
		if(var_c21b798e.var_bb290b79.size)
		{
			if(!isdefined(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b]))
			{
				var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = [];
			}
			foreach(ai in var_c21b798e.var_bb290b79)
			{
				if(!isdefined(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b]))
				{
					var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = [];
				}
				else if(!isarray(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b]))
				{
					var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b] = array(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b]);
				}
				if(!isinarray(var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b], ai))
				{
					var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b][var_dcd6c23.var_419edb9f[var_dcd6c23.var_4417045b].size] = ai;
				}
			}
		}
	}
}

/*
	Name: function_30956db0
	Namespace: namespace_96ff9fb2
	Checksum: 0x5B62B84
	Offset: 0x32C8
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_30956db0(var_dcd6c23)
{
	while(function_4b7647f(var_dcd6c23))
	{
		wait(1);
	}
	var_dcd6c23 flag::set("all_dead");
	var_dcd6c23.var_419edb9f = undefined;
}

/*
	Name: function_4b7647f
	Namespace: namespace_96ff9fb2
	Checksum: 0x9B30EC52
	Offset: 0x3328
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4b7647f(var_dcd6c23)
{
	foreach(a_ai in var_dcd6c23.var_419edb9f)
	{
		a_ai = array::remove_dead(a_ai);
		if(a_ai.size)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_7909260f
	Namespace: namespace_96ff9fb2
	Checksum: 0xB618D0DB
	Offset: 0x33D0
	Size: 0x55A
	Parameters: 3
	Flags: Linked, Private
*/
private function function_7909260f(var_dcd6c23, n_wave, var_bced2a83)
{
	n_spawns = 0;
	if(var_dcd6c23 flag::get("stopped"))
	{
		if(var_bced2a83)
		{
			if(isdefined(var_dcd6c23.var_419edb9f))
			{
				if(isdefined(n_wave))
				{
					if(isdefined(var_dcd6c23.var_419edb9f[n_wave]))
					{
						var_dcd6c23.var_419edb9f[n_wave] = array::remove_dead(var_dcd6c23.var_419edb9f[n_wave]);
						foreach(ai in var_dcd6c23.var_419edb9f[n_wave])
						{
							n_spawns++;
						}
					}
				}
				else
				{
					foreach(var_13528014 in var_dcd6c23.var_419edb9f)
					{
						var_13528014 = array::remove_dead(var_13528014);
						foreach(ai in var_13528014)
						{
							n_spawns++;
						}
					}
				}
			}
		}
	}
	else
	{
		for(i = 1; i <= var_dcd6c23.var_592f8f7f; i++)
		{
			if(isdefined(n_wave))
			{
				if(i < n_wave)
				{
					continue;
				}
				else if(i > n_wave)
				{
					break;
				}
			}
			if(i < var_dcd6c23.var_4417045b)
			{
				if(var_bced2a83)
				{
					if(isdefined(var_dcd6c23.var_419edb9f))
					{
						if(isdefined(var_dcd6c23.var_419edb9f[i]))
						{
							var_dcd6c23.var_419edb9f[i] = array::remove_dead(var_dcd6c23.var_419edb9f[i]);
							foreach(ai in var_dcd6c23.var_419edb9f[i])
							{
								n_spawns++;
							}
						}
					}
				}
				continue;
			}
			if(i == var_dcd6c23.var_4417045b)
			{
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					var_1c88138f = var_c21b798e.var_23791f08 - var_c21b798e.var_bcd4e683;
					if(isdefined(var_c21b798e.var_bb290b79))
					{
						var_c21b798e.var_bb290b79 = array::remove_dead(var_c21b798e.var_bb290b79);
						var_1c88138f = var_1c88138f + var_c21b798e.var_bb290b79.size;
					}
					n_spawns = n_spawns + var_1c88138f;
				}
			}
			else
			{
				foreach(var_a2b4b991 in var_dcd6c23.m_s_bundle.waves[i - 1].spawns)
				{
					n_spawns = n_spawns + (isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1);
				}
			}
			if(!var_bced2a83)
			{
				if(isdefined(var_dcd6c23.m_s_bundle.waves[i - 1].transitioncount))
				{
					n_spawns = n_spawns - var_dcd6c23.m_s_bundle.waves[i - 1].transitioncount;
				}
			}
		}
	}
	return n_spawns;
}

/*
	Name: function_60fa5e02
	Namespace: namespace_96ff9fb2
	Checksum: 0x9A55866C
	Offset: 0x3938
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_60fa5e02(var_c21b798e)
{
	/#
		assert(isdefined(var_c21b798e), "");
	#/
	var_c21b798e flag::init("spawn_set_" + var_c21b798e.m_n_index + "_complete");
	var_c21b798e flag::init("spawn_set_" + var_c21b798e.m_n_index + "_cleared");
}

/*
	Name: function_8726b97d
	Namespace: namespace_96ff9fb2
	Checksum: 0x9E26B265
	Offset: 0x39E0
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8726b97d(var_c21b798e)
{
	var_c21b798e flag::set("spawn_set_" + var_c21b798e.m_n_index + "_complete");
}

/*
	Name: function_9e2b33f4
	Namespace: namespace_96ff9fb2
	Checksum: 0x50C451A8
	Offset: 0x3A30
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e2b33f4(var_c21b798e)
{
	return var_c21b798e flag::get("spawn_set_" + var_c21b798e.m_n_index + "_complete");
}

/*
	Name: function_d652a051
	Namespace: namespace_96ff9fb2
	Checksum: 0x201764B5
	Offset: 0x3A80
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d652a051(var_c21b798e)
{
	var_c21b798e flag::set("spawn_set_" + var_c21b798e.m_n_index + "_cleared");
}

/*
	Name: function_f77ad8a3
	Namespace: namespace_96ff9fb2
	Checksum: 0x9CED449F
	Offset: 0x3AD0
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f77ad8a3(var_c21b798e)
{
	return var_c21b798e flag::get("spawn_set_" + var_c21b798e.m_n_index + "_cleared");
}

/*
	Name: function_8f5ed189
	Namespace: namespace_96ff9fb2
	Checksum: 0xD66B703F
	Offset: 0x3B20
	Size: 0x1024
	Parameters: 2
	Flags: Linked, Private
*/
private function function_8f5ed189(var_dcd6c23, var_c21b798e)
{
	function_60fa5e02(var_c21b798e);
	var_a2b4b991 = var_c21b798e.var_4fb3156c;
	var_c165240a = function_ed819a97(var_a2b4b991);
	var_c21b798e.var_a4202481 = (isdefined(var_a2b4b991.activecount) ? var_a2b4b991.activecount : 1);
	var_c21b798e.var_23791f08 = (isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1);
	var_ac751707 = (isdefined(var_a2b4b991.groupsizemin) ? var_a2b4b991.groupsizemin : 1);
	var_777f23ac = (isdefined(var_a2b4b991.groupsizemax) ? var_a2b4b991.groupsizemax : 1);
	if(var_ac751707 < var_777f23ac)
	{
		var_ff8eea0d = 1;
	}
	else
	{
		var_ff8eea0d = 0;
		n_group_size = var_ac751707;
	}
	var_393f60f2 = (isdefined(var_a2b4b991.var_5794c814) ? var_a2b4b991.var_5794c814 : 1);
	var_58b22097 = (isdefined(var_a2b4b991.var_455e5daf) ? var_a2b4b991.var_455e5daf : 0);
	var_685248c4 = (isdefined(var_a2b4b991.var_6d514904) ? var_a2b4b991.var_6d514904 : 0);
	if(var_58b22097 < var_685248c4)
	{
		n_start_delay = randomfloatrange(var_58b22097, var_685248c4);
	}
	else
	{
		n_start_delay = var_58b22097;
	}
	var_4e06036b = (isdefined(var_a2b4b991.spawndelaymin) ? var_a2b4b991.spawndelaymin : 0);
	var_d18f896 = (isdefined(var_a2b4b991.spawndelaymax) ? var_a2b4b991.spawndelaymax : 0);
	if(var_4e06036b < var_d18f896)
	{
		var_178b2076 = 1;
	}
	else
	{
		var_178b2076 = 0;
		n_spawn_delay = var_4e06036b;
	}
	var_88f8dfe3 = gettime();
	var_e7bc5a90 = 1;
	var_a9e6e26a = 1;
	while(true)
	{
		if(var_dcd6c23 flag::get("stopped"))
		{
			break;
		}
		if(var_dcd6c23 flag::get("paused"))
		{
			wait(0.1);
			continue;
		}
		if(var_c165240a.size == 0)
		{
			break;
		}
		if(var_c21b798e.var_bcd4e683 >= var_c21b798e.var_23791f08)
		{
			break;
		}
		var_a9dc13fe = 0;
		var_a5f569fc = undefined;
		if(isdefined(var_c21b798e.var_bb290b79))
		{
			var_c21b798e.var_bb290b79 = array::remove_dead(var_c21b798e.var_bb290b79);
		}
		foreach(var_40b0c36 in var_c165240a)
		{
			var_40b0c36.var_a33f2319 = array::remove_dead(var_40b0c36.var_a33f2319);
		}
		var_303d0ec5 = var_c21b798e.var_23791f08 - var_c21b798e.var_bcd4e683;
		if(var_e7bc5a90)
		{
			if(var_ff8eea0d)
			{
				var_ac751707 = math::clamp(var_ac751707, 1, var_303d0ec5);
				var_777f23ac = math::clamp(var_777f23ac, 1, var_303d0ec5);
				if(var_ac751707 == var_777f23ac)
				{
					n_group_size = var_ac751707;
				}
				else
				{
					n_group_size = randomintrange(var_ac751707, var_777f23ac + 1);
				}
			}
			else
			{
				n_group_size = math::clamp(n_group_size, 1, var_303d0ec5);
			}
			if(var_a9e6e26a)
			{
				var_cfe8c244 = n_start_delay;
				var_a9e6e26a = 0;
			}
			else if(var_178b2076)
			{
				n_spawn_delay = randomfloatrange(var_4e06036b, var_d18f896);
			}
			var_cfe8c244 = n_spawn_delay;
		}
		var_e7bc5a90 = 0;
		if(!isdefined(var_c21b798e.var_bb290b79) || var_c21b798e.var_bb290b79.size < var_c21b798e.var_a4202481)
		{
			var_a5f569fc = var_c21b798e.var_a4202481 - var_c21b798e.var_bb290b79.size;
			var_db4208eb = function_d8cca6d5(var_c165240a);
			if(var_a5f569fc >= n_group_size && var_db4208eb.size)
			{
				var_7c275302 = gettime() - var_88f8dfe3;
				var_1b5feb05 = float(var_7c275302);
				if(var_1b5feb05 >= int(var_cfe8c244 * 1000))
				{
					var_a9dc13fe = 1;
				}
			}
		}
		if(!var_a9dc13fe)
		{
			wait(0.1);
			continue;
		}
		var_6a60a2e6 = 0;
		/#
			assert(isdefined(var_a5f569fc), "");
		#/
		var_13027679 = undefined;
		var_26413beb = undefined;
		var_549391b8 = undefined;
		while(var_6a60a2e6 < n_group_size)
		{
			if(n_group_size <= 1)
			{
				var_549391b8 = undefined;
			}
			if(var_dcd6c23 flag::get("stopped"))
			{
				break;
			}
			if(var_dcd6c23 flag::get("paused"))
			{
				wait(0.1);
				continue;
			}
			var_db4208eb = function_d8cca6d5(var_c165240a);
			if(!var_db4208eb.size)
			{
				/#
					println("" + var_dcd6c23.var_556afb3d + "" + var_c21b798e.m_n_index + 1 + "");
					iprintln("" + var_dcd6c23.var_556afb3d + "" + var_c21b798e.m_n_index + 1 + "");
				#/
				break;
			}
			if(!(isdefined(var_393f60f2) && var_393f60f2) && isdefined(var_13027679))
			{
				if(!isinarray(var_db4208eb, var_26413beb))
				{
					/#
						println("" + var_26413beb + "" + var_dcd6c23.var_556afb3d + "" + var_c21b798e.m_n_index + 1 + "");
						iprintln("" + var_26413beb + "" + var_dcd6c23.var_556afb3d + "" + var_c21b798e.m_n_index + 1 + "");
					#/
					break;
				}
				var_aea390b6 = var_13027679;
				var_82706add = var_26413beb;
			}
			else
			{
				var_82706add = var_db4208eb[randomint(var_db4208eb.size)];
			}
			spawner::global_spawn_throttle();
			if(!isdefined(var_549391b8) || !isdefined(var_549391b8[#"spawner"]) || (var_549391b8[#"spawner"].count < 1 && (!(isdefined(var_549391b8[#"spawner"].spawnflags) && var_549391b8[#"spawner"].spawnflags & 64 == 64))))
			{
				s_spawn_point = aispawningutility::function_e312ad4d(var_dcd6c23.m_str_team, var_dcd6c23.var_27eacb34, var_82706add);
				if(!isdefined(s_spawn_point))
				{
					/#
						println("" + var_82706add + "" + var_dcd6c23.var_556afb3d + "");
						iprintln("" + var_82706add + "" + var_dcd6c23.var_556afb3d + "");
					#/
					arrayremoveindex(var_c165240a, var_82706add, 1);
					if(var_c165240a.size > 0 && (isdefined(var_393f60f2) && var_393f60f2))
					{
						continue;
					}
					break;
				}
			}
			v_origin = (isdefined(s_spawn_point) ? s_spawn_point[#"origin"] : (0, 0, 0));
			v_angles = (isdefined(s_spawn_point) ? s_spawn_point[#"angles"] : (0, 0, 0));
			var_c8fa21da = (isdefined(s_spawn_point) ? s_spawn_point[#"spawner"] : undefined);
			if(n_group_size > 1)
			{
				var_549391b8 = s_spawn_point;
			}
			if(isdefined(var_c8fa21da))
			{
				b_infinite_spawn = isdefined(var_c8fa21da.spawnflags) && var_c8fa21da.spawnflags & 64 == 64;
				b_force_spawn = isdefined(var_c8fa21da.spawnflags) && var_c8fa21da.spawnflags & 16 == 16;
			}
			var_ae2df0a1 = isdefined(var_c8fa21da.aitype) && function_e949cfd7(var_c8fa21da.aitype);
			if(var_ae2df0a1)
			{
				if(isdefined(var_c8fa21da))
				{
					ai = var_c8fa21da spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
					if(!isdefined(var_dcd6c23.var_246fb97f))
					{
						var_dcd6c23.var_246fb97f = [];
					}
					else if(!isarray(var_dcd6c23.var_246fb97f))
					{
						var_dcd6c23.var_246fb97f = array(var_dcd6c23.var_246fb97f);
					}
					if(!isinarray(var_dcd6c23.var_246fb97f, var_c8fa21da))
					{
						var_dcd6c23.var_246fb97f[var_dcd6c23.var_246fb97f.size] = var_c8fa21da;
					}
				}
			}
			else if(isdefined(var_c8fa21da))
			{
				ai = var_c8fa21da spawnfromspawner(s_spawn_point[#"spawner"].targetname, b_force_spawn, 0, b_infinite_spawn);
				if(!isdefined(var_dcd6c23.var_246fb97f))
				{
					var_dcd6c23.var_246fb97f = [];
				}
				else if(!isarray(var_dcd6c23.var_246fb97f))
				{
					var_dcd6c23.var_246fb97f = array(var_dcd6c23.var_246fb97f);
				}
				if(!isinarray(var_dcd6c23.var_246fb97f, var_c8fa21da))
				{
					var_dcd6c23.var_246fb97f[var_dcd6c23.var_246fb97f.size] = var_c8fa21da;
				}
			}
			if(isdefined(ai))
			{
				function_ff49692b(var_dcd6c23, ai);
				if(!isdefined(var_c21b798e.var_bb290b79))
				{
					var_c21b798e.var_bb290b79 = [];
				}
				else if(!isarray(var_c21b798e.var_bb290b79))
				{
					var_c21b798e.var_bb290b79 = array(var_c21b798e.var_bb290b79);
				}
				var_c21b798e.var_bb290b79[var_c21b798e.var_bb290b79.size] = ai;
				if(!isdefined(var_c165240a[var_82706add].var_a33f2319))
				{
					var_c165240a[var_82706add].var_a33f2319 = [];
				}
				else if(!isarray(var_c165240a[var_82706add].var_a33f2319))
				{
					var_c165240a[var_82706add].var_a33f2319 = array(var_c165240a[var_82706add].var_a33f2319);
				}
				var_c165240a[var_82706add].var_a33f2319[var_c165240a[var_82706add].var_a33f2319.size] = ai;
				var_88f8dfe3 = gettime();
				var_e7bc5a90 = 1;
				var_c21b798e.var_bcd4e683++;
				var_6a60a2e6++;
			}
			var_13027679 = var_aea390b6;
			var_26413beb = var_82706add;
			wait(0.1);
		}
		wait(0.1);
	}
	function_8726b97d(var_c21b798e);
	while(true)
	{
		var_c21b798e.var_bb290b79 = array::remove_dead(var_c21b798e.var_bb290b79);
		if(!var_c21b798e.var_bb290b79.size)
		{
			function_d652a051(var_c21b798e);
			return;
		}
		wait(0.1);
	}
}

/*
	Name: get_unique_id
	Namespace: namespace_96ff9fb2
	Checksum: 0x57D41BA2
	Offset: 0x4B50
	Size: 0x48
	Parameters: 0
	Flags: Linked, Private
*/
private function get_unique_id()
{
	if(!isdefined(level.n_wave_manager_id))
	{
		level.n_wave_manager_id = 0;
	}
	id = level.n_wave_manager_id;
	level.n_wave_manager_id++;
	return id;
}

/*
	Name: function_d081cf72
	Namespace: namespace_96ff9fb2
	Checksum: 0xB836BA97
	Offset: 0x4BA0
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d081cf72(var_a2b4b991)
{
	if(isdefined(var_a2b4b991.var_28184dd8))
	{
		foreach(var_3abe2668 in var_a2b4b991.var_28184dd8)
		{
			if(isdefined(var_3abe2668.variant))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_ed819a97
	Namespace: namespace_96ff9fb2
	Checksum: 0xB9B7BDC5
	Offset: 0x4C40
	Size: 0x12E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ed819a97(var_a2b4b991)
{
	var_c165240a = [];
	if(isdefined(var_a2b4b991.var_28184dd8))
	{
		foreach(var_3abe2668 in var_a2b4b991.var_28184dd8)
		{
			if(isdefined(var_3abe2668.variant))
			{
				var_2f2d7675 = (isdefined(var_3abe2668.var_34ceb858) ? var_3abe2668.var_34ceb858 : 0);
				var_40b0c36 = {#name:var_3abe2668.variant, #hash_a33f2319:[], #hash_2f2d7675:var_2f2d7675};
				var_c165240a[var_3abe2668.variant] = var_40b0c36;
			}
		}
	}
	return var_c165240a;
}

/*
	Name: function_d8cca6d5
	Namespace: namespace_96ff9fb2
	Checksum: 0x6EC003D2
	Offset: 0x4D78
	Size: 0x130
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d8cca6d5(var_c165240a)
{
	var_db4208eb = [];
	foreach(v in var_c165240a)
	{
		var_2f2d7675 = v.var_2f2d7675;
		if(var_2f2d7675 == 0 || v.var_a33f2319.size < var_2f2d7675)
		{
			if(!isdefined(var_db4208eb))
			{
				var_db4208eb = [];
			}
			else if(!isarray(var_db4208eb))
			{
				var_db4208eb = array(var_db4208eb);
			}
			if(!isinarray(var_db4208eb, v.name))
			{
				var_db4208eb[var_db4208eb.size] = v.name;
			}
		}
	}
	return var_db4208eb;
}

/*
	Name: function_32b947df
	Namespace: namespace_96ff9fb2
	Checksum: 0x125F8E84
	Offset: 0x4EB0
	Size: 0x318
	Parameters: 1
	Flags: Linked, Private
*/
private function function_32b947df(kvp)
{
	var_fed53aae = [];
	if(isdefined(kvp))
	{
		str_key = "targetname";
		str_value = kvp;
		if(isarray(kvp))
		{
			str_key = kvp[0];
			str_value = kvp[1];
		}
		var_a3688653 = struct::get_array(str_value, str_key);
		var_a3688653 = array::filter(var_a3688653, 0, &function_5b3b889f);
		foreach(s_wave_manager in var_a3688653)
		{
			if(isdefined(s_wave_manager.var_dcd6c23))
			{
				if(!isdefined(var_fed53aae))
				{
					var_fed53aae = [];
				}
				else if(!isarray(var_fed53aae))
				{
					var_fed53aae = array(var_fed53aae);
				}
				if(!isinarray(var_fed53aae, s_wave_manager.var_dcd6c23))
				{
					var_fed53aae[var_fed53aae.size] = s_wave_manager.var_dcd6c23;
				}
			}
		}
		/#
			assert(var_a3688653.size, "" + str_key + "" + str_value + "");
		#/
	}
	else
	{
		var_666d249b = self;
		if(!isdefined(var_666d249b))
		{
			var_666d249b = [];
		}
		else if(!isarray(var_666d249b))
		{
			var_666d249b = array(var_666d249b);
		}
		foreach(var_989041ce in var_666d249b)
		{
			var_dcd6c23 = var_989041ce function_fa056daa();
			if(isdefined(var_dcd6c23))
			{
				if(!isdefined(var_fed53aae))
				{
					var_fed53aae = [];
				}
				else if(!isarray(var_fed53aae))
				{
					var_fed53aae = array(var_fed53aae);
				}
				var_fed53aae[var_fed53aae.size] = var_dcd6c23;
			}
		}
	}
	return var_fed53aae;
}

/*
	Name: function_63e08195
	Namespace: namespace_96ff9fb2
	Checksum: 0x742A2024
	Offset: 0x51D0
	Size: 0x178
	Parameters: 2
	Flags: Linked, Private
*/
private function function_63e08195(kvp, b_assert = 1)
{
	var_a3688653 = [];
	if(isdefined(kvp))
	{
		if(isarray(kvp))
		{
			str_value = kvp[0];
			str_key = kvp[1];
		}
		else
		{
			str_value = kvp;
			str_key = "targetname";
		}
		var_a3688653 = struct::get_array(str_value, str_key);
	}
	else
	{
		var_a3688653 = self;
		if(!isdefined(var_a3688653))
		{
			var_a3688653 = [];
		}
		else if(!isarray(var_a3688653))
		{
			var_a3688653 = array(var_a3688653);
		}
	}
	var_a3688653 = array::filter(var_a3688653, 0, &function_5b3b889f);
	if(b_assert)
	{
		/#
			assert(var_a3688653.size, (isdefined(kvp) ? "" + str_key + "" + str_value + "" : ""));
		#/
	}
	return var_a3688653;
}

/*
	Name: function_fa056daa
	Namespace: namespace_96ff9fb2
	Checksum: 0x7A4AFF75
	Offset: 0x5350
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fa056daa()
{
	if(isinarray(level.var_a3688653, self))
	{
		if(isdefined(self.var_dcd6c23))
		{
			return self.var_dcd6c23;
		}
		return undefined;
	}
	if(self function_e0bfee59())
	{
		return self;
	}
	/#
		assertmsg("");
	#/
	return undefined;
}

/*
	Name: function_e0bfee59
	Namespace: namespace_96ff9fb2
	Checksum: 0xF16A66CC
	Offset: 0x53D8
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e0bfee59()
{
	if(isdefined(self.var_cf3bea8a) && level.var_ca74a4bc[self.var_cf3bea8a] == self)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_5b3b889f
	Namespace: namespace_96ff9fb2
	Checksum: 0x169C6DE5
	Offset: 0x5418
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5b3b889f(var_ac1d69cd)
{
	return isinarray(level.var_a3688653, var_ac1d69cd);
}

/*
	Name: function_bf55c711
	Namespace: namespace_96ff9fb2
	Checksum: 0xC46706C3
	Offset: 0x5450
	Size: 0x1CE
	Parameters: 2
	Flags: Linked, Private
*/
private function function_bf55c711(n_wave, var_bced2a83)
{
	s_bundle = struct::get_script_bundle("wave_manager", self.scriptbundlename);
	n_ai_count = 0;
	foreach(n_index, s_wave in s_bundle.waves)
	{
		if(isdefined(n_wave))
		{
			if(n_index < n_wave - 1)
			{
				continue;
			}
			else if(n_index > n_wave - 1)
			{
				break;
			}
		}
		var_b4d30f09 = 0;
		foreach(var_a2b4b991 in s_wave.spawns)
		{
			var_b4d30f09 = var_b4d30f09 + (isdefined(var_a2b4b991.totalcount) ? var_a2b4b991.totalcount : 1);
		}
		if(!var_bced2a83 && isdefined(s_wave.transitioncount))
		{
			var_b4d30f09 = var_b4d30f09 - s_wave.transitioncount;
		}
		n_ai_count = n_ai_count + var_b4d30f09;
	}
	return n_ai_count;
}

#namespace namespace_8e39177;

/*
	Name: __constructor
	Namespace: namespace_8e39177
	Checksum: 0xAE6E3E41
	Offset: 0x5628
	Size: 0xE
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.a_params = [];
}

/*
	Name: __destructor
	Namespace: namespace_8e39177
	Checksum: 0x80F724D1
	Offset: 0x5640
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace wave_manager;

/*
	Name: function_8e39177
	Namespace: wave_manager
	Checksum: 0xC1CEFF9C
	Offset: 0x5650
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8e39177()
{
	classes.var_8e39177[0] = spawnstruct();
	classes.var_8e39177[0].__vtable[913321084] = &namespace_8e39177::__destructor;
	classes.var_8e39177[0].__vtable[674154906] = &namespace_8e39177::__constructor;
}

/*
	Name: start
	Namespace: wave_manager
	Checksum: 0xEFCA3A76
	Offset: 0x56E0
	Size: 0xF8
	Parameters: 3
	Flags: Linked, Variadic
*/
function start(kvp, var_964c77e1, vararg)
{
	var_a3688653 = self namespace_96ff9fb2::function_63e08195(kvp);
	foreach(s_wave_manager in var_a3688653)
	{
		object = new var_8e39177();
		[[ object ]]->__constructor();
		var_e8332bc1 = object;
		var_e8332bc1.var_964c77e1 = var_964c77e1;
		var_e8332bc1.a_params = vararg;
		namespace_96ff9fb2::function_3ff920ca(s_wave_manager, undefined, undefined, undefined, undefined, var_e8332bc1);
	}
}

/*
	Name: function_be3a34f
	Namespace: wave_manager
	Checksum: 0x33D4FD6B
	Offset: 0x57E0
	Size: 0xA2
	Parameters: 6
	Flags: Variadic
*/
function function_be3a34f(var_b6ee6116, str_team, b_looping = 0, str_spawner_targets, var_964c77e1, vararg)
{
	object = new var_8e39177();
	[[ object ]]->__constructor();
	var_e8332bc1 = object;
	var_e8332bc1.var_964c77e1 = var_964c77e1;
	var_e8332bc1.a_params = vararg;
	return namespace_96ff9fb2::function_3ff920ca(undefined, str_team, b_looping, var_b6ee6116, str_spawner_targets, var_e8332bc1);
}

/*
	Name: wait_till_complete
	Namespace: wave_manager
	Checksum: 0x8AB95BE7
	Offset: 0x5890
	Size: 0x130
	Parameters: 1
	Flags: None
*/
function wait_till_complete(n_wave)
{
	var_666d249b = self;
	if(!isdefined(var_666d249b))
	{
		var_666d249b = [];
	}
	else if(!isarray(var_666d249b))
	{
		var_666d249b = array(var_666d249b);
	}
	foreach(var_989041ce in var_666d249b)
	{
		if(namespace_96ff9fb2::function_5b3b889f(var_989041ce))
		{
			var_989041ce flag::wait_till("wave_manager_started");
		}
		var_dcd6c23 = var_989041ce namespace_96ff9fb2::function_fa056daa();
		if(isdefined(var_dcd6c23))
		{
			namespace_96ff9fb2::function_aa6a8e4a(var_dcd6c23, n_wave);
		}
	}
}

/*
	Name: wait_till_cleared
	Namespace: wave_manager
	Checksum: 0xEB2EF546
	Offset: 0x59C8
	Size: 0x148
	Parameters: 2
	Flags: None
*/
function wait_till_cleared(n_wave, var_b8b3e39d = 0)
{
	var_666d249b = self;
	if(!isdefined(var_666d249b))
	{
		var_666d249b = [];
	}
	else if(!isarray(var_666d249b))
	{
		var_666d249b = array(var_666d249b);
	}
	foreach(var_989041ce in var_666d249b)
	{
		if(namespace_96ff9fb2::function_5b3b889f(var_989041ce))
		{
			var_989041ce flag::wait_till("wave_manager_started");
		}
		var_dcd6c23 = var_989041ce namespace_96ff9fb2::function_fa056daa();
		if(isdefined(var_dcd6c23))
		{
			namespace_96ff9fb2::function_55525f13(var_dcd6c23, n_wave, var_b8b3e39d);
		}
	}
}

/*
	Name: function_fa5a19de
	Namespace: wave_manager
	Checksum: 0x1F533558
	Offset: 0x5B18
	Size: 0x130
	Parameters: 0
	Flags: None
*/
function function_fa5a19de()
{
	var_666d249b = self;
	if(!isdefined(var_666d249b))
	{
		var_666d249b = [];
	}
	else if(!isarray(var_666d249b))
	{
		var_666d249b = array(var_666d249b);
	}
	foreach(var_989041ce in var_666d249b)
	{
		if(namespace_96ff9fb2::function_5b3b889f(var_989041ce))
		{
			var_989041ce flag::wait_till("wave_manager_started");
		}
		var_dcd6c23 = var_989041ce namespace_96ff9fb2::function_fa056daa();
		if(isdefined(var_dcd6c23))
		{
			var_dcd6c23 flag::wait_till("stopped");
		}
	}
}

/*
	Name: is_looping
	Namespace: wave_manager
	Checksum: 0xD6B7CD0B
	Offset: 0x5C50
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function is_looping()
{
	var_dcd6c23 = self namespace_96ff9fb2::function_fa056daa();
	if(isdefined(var_dcd6c23))
	{
		return isdefined(var_dcd6c23.var_f68bc980) && var_dcd6c23.var_f68bc980;
	}
	if(namespace_96ff9fb2::function_5b3b889f(self))
	{
		return isdefined(self.script_looping) && self.script_looping;
	}
	return 0;
}

/*
	Name: function_1c556906
	Namespace: wave_manager
	Checksum: 0xA294A82D
	Offset: 0x5CD8
	Size: 0x1C6
	Parameters: 2
	Flags: None
*/
function function_1c556906(kvp, str_spawner_targetname)
{
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	foreach(var_dcd6c23 in var_fed53aae)
	{
		/#
			assert(isdefined(str_spawner_targetname));
		#/
		var_ea2315c9 = getspawnerteamarray(var_dcd6c23.m_str_team);
		var_91504a05 = 0;
		if(isdefined(var_ea2315c9) && isarray(var_ea2315c9) && var_ea2315c9.size)
		{
			foreach(var_301a68ab in var_ea2315c9)
			{
				if(var_301a68ab.targetname === str_spawner_targetname)
				{
					var_91504a05 = 1;
					break;
				}
			}
		}
		/#
			assert(var_91504a05, "" + str_spawner_targetname);
		#/
		var_dcd6c23.var_27eacb34 = str_spawner_targetname;
	}
}

/*
	Name: function_a3469200
	Namespace: wave_manager
	Checksum: 0x4D14ABD4
	Offset: 0x5EA8
	Size: 0x206
	Parameters: 2
	Flags: None
*/
function function_a3469200(kvp, var_4b054c7f)
{
	a_ai = [];
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	if(isdefined(var_4b054c7f))
	{
		var_4b054c7f--;
	}
	foreach(var_dcd6c23 in var_fed53aae)
	{
		if(isdefined(var_dcd6c23.var_376c2c29))
		{
			if(isdefined(var_4b054c7f) && var_4b054c7f > 0)
			{
				if(isdefined(var_dcd6c23.var_376c2c29[var_4b054c7f]))
				{
					a_ai = var_dcd6c23.var_376c2c29[var_4b054c7f].var_bb290b79;
				}
			}
			else
			{
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					foreach(ai in var_c21b798e.var_bb290b79)
					{
						a_ai[a_ai.size] = ai;
					}
				}
			}
			a_ai = array::remove_dead(a_ai);
		}
	}
	return a_ai;
}

/*
	Name: function_77941ace
	Namespace: wave_manager
	Checksum: 0x53EE9915
	Offset: 0x60B8
	Size: 0x3F6
	Parameters: 2
	Flags: None
*/
function function_77941ace(kvp, n_wave)
{
	a_ai = [];
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	foreach(var_dcd6c23 in var_fed53aae)
	{
		if(isdefined(var_dcd6c23.var_376c2c29))
		{
			if(!isdefined(n_wave) || n_wave === var_dcd6c23.var_4417045b)
			{
				foreach(var_c21b798e in var_dcd6c23.var_376c2c29)
				{
					foreach(ai in var_c21b798e.var_bb290b79)
					{
						a_ai[a_ai.size] = ai;
					}
				}
			}
		}
		if(isdefined(var_dcd6c23.var_419edb9f))
		{
			if(isdefined(n_wave))
			{
				if(isdefined(var_dcd6c23.var_419edb9f[n_wave]))
				{
					foreach(ai in var_dcd6c23.var_419edb9f[n_wave])
					{
						if(!isdefined(a_ai))
						{
							a_ai = [];
						}
						else if(!isarray(a_ai))
						{
							a_ai = array(a_ai);
						}
						if(!isinarray(a_ai, ai))
						{
							a_ai[a_ai.size] = ai;
						}
					}
				}
			}
			else
			{
				foreach(var_13528014 in var_dcd6c23.var_419edb9f)
				{
					foreach(ai in var_13528014)
					{
						if(!isdefined(a_ai))
						{
							a_ai = [];
						}
						else if(!isarray(a_ai))
						{
							a_ai = array(a_ai);
						}
						if(!isinarray(a_ai, ai))
						{
							a_ai[a_ai.size] = ai;
						}
					}
				}
			}
		}
		a_ai = array::remove_dead(a_ai);
	}
	return a_ai;
}

/*
	Name: function_6893f05b
	Namespace: wave_manager
	Checksum: 0x9F6C380B
	Offset: 0x64B8
	Size: 0x128
	Parameters: 3
	Flags: None
*/
function function_6893f05b(kvp, n_wave, var_bced2a83 = 1)
{
	var_a3688653 = [];
	var_a3688653 = self namespace_96ff9fb2::function_63e08195(kvp);
	var_a1f4e09d = 0;
	foreach(s_wave_manager in var_a3688653)
	{
		if(isdefined(s_wave_manager.var_dcd6c23))
		{
			var_a1f4e09d = var_a1f4e09d + namespace_96ff9fb2::function_7909260f(s_wave_manager.var_dcd6c23, n_wave, var_bced2a83);
			continue;
		}
		var_a1f4e09d = var_a1f4e09d + s_wave_manager namespace_96ff9fb2::function_bf55c711(n_wave, var_bced2a83);
	}
	return var_a1f4e09d;
}

/*
	Name: add_spawn_function
	Namespace: wave_manager
	Checksum: 0x1F3A5052
	Offset: 0x65E8
	Size: 0x37A
	Parameters: 3
	Flags: Variadic
*/
function add_spawn_function(kvp, var_964c77e1, vararg)
{
	/#
		assert(isdefined(var_964c77e1));
	#/
	var_a3688653 = self namespace_96ff9fb2::function_63e08195(kvp, 0);
	if(var_a3688653.size)
	{
		foreach(s_wave_manager in var_a3688653)
		{
			object = new var_8e39177();
			[[ object ]]->__constructor();
			var_e8332bc1 = object;
			var_e8332bc1.var_964c77e1 = var_964c77e1;
			var_e8332bc1.a_params = vararg;
			if(isdefined(s_wave_manager.var_dcd6c23))
			{
				if(!isdefined(s_wave_manager.var_dcd6c23.var_23802722))
				{
					s_wave_manager.var_dcd6c23.var_23802722 = [];
				}
				else if(!isarray(s_wave_manager.var_dcd6c23.var_23802722))
				{
					s_wave_manager.var_dcd6c23.var_23802722 = array(s_wave_manager.var_dcd6c23.var_23802722);
				}
				if(!isinarray(s_wave_manager.var_dcd6c23.var_23802722, var_e8332bc1))
				{
					s_wave_manager.var_dcd6c23.var_23802722[s_wave_manager.var_dcd6c23.var_23802722.size] = var_e8332bc1;
				}
				continue;
			}
			if(!isdefined(s_wave_manager.var_a69f424f))
			{
				s_wave_manager.var_a69f424f = [];
			}
			else if(!isarray(s_wave_manager.var_a69f424f))
			{
				s_wave_manager.var_a69f424f = array(s_wave_manager.var_a69f424f);
			}
			if(!isinarray(s_wave_manager.var_a69f424f, var_e8332bc1))
			{
				s_wave_manager.var_a69f424f[s_wave_manager.var_a69f424f.size] = var_e8332bc1;
			}
		}
	}
	else if(self namespace_96ff9fb2::function_e0bfee59())
	{
		object = new var_8e39177();
		[[ object ]]->__constructor();
		var_e8332bc1 = object;
		var_e8332bc1.var_964c77e1 = var_964c77e1;
		var_e8332bc1.a_params = vararg;
		if(!isdefined(self.var_23802722))
		{
			self.var_23802722 = [];
		}
		else if(!isarray(self.var_23802722))
		{
			self.var_23802722 = array(self.var_23802722);
		}
		if(!isinarray(self.var_23802722, var_e8332bc1))
		{
			self.var_23802722[self.var_23802722.size] = var_e8332bc1;
		}
	}
}

/*
	Name: remove_spawn_function
	Namespace: wave_manager
	Checksum: 0x89B7330F
	Offset: 0x6970
	Size: 0x2EE
	Parameters: 2
	Flags: None
*/
function remove_spawn_function(kvp, var_964c77e1)
{
	/#
		assert(isdefined(var_964c77e1));
	#/
	var_a3688653 = self namespace_96ff9fb2::function_63e08195(kvp, 0);
	if(var_a3688653.size)
	{
		foreach(s_wave_manager in var_a3688653)
		{
			if(isdefined(s_wave_manager.var_dcd6c23))
			{
				var_dcd6c23 = s_wave_manager.var_dcd6c23;
				foreach(var_e8332bc1 in var_dcd6c23.var_23802722)
				{
					if(var_e8332bc1.var_964c77e1 === var_964c77e1)
					{
						var_dcd6c23.var_23802722 = array::exclude(var_dcd6c23.var_23802722, var_e8332bc1);
					}
				}
			}
			if(isdefined(s_wave_manager.var_a69f424f))
			{
				foreach(var_e8332bc1 in s_wave_manager.var_a69f424f)
				{
					if(var_e8332bc1.var_964c77e1 === var_964c77e1)
					{
						s_wave_manager.var_a69f424f = array::exclude(s_wave_manager.var_a69f424f, var_e8332bc1);
						if(!s_wave_manager.var_a69f424f.size)
						{
							s_wave_manager.var_a69f424f = undefined;
						}
					}
				}
			}
		}
	}
	else if(self namespace_96ff9fb2::function_e0bfee59())
	{
		foreach(var_e8332bc1 in self.var_23802722)
		{
			if(var_e8332bc1.var_964c77e1 === var_964c77e1)
			{
				self.var_23802722 = array::exclude(self.var_23802722, var_e8332bc1);
			}
		}
	}
}

/*
	Name: stop
	Namespace: wave_manager
	Checksum: 0xF1720192
	Offset: 0x6C68
	Size: 0xC0
	Parameters: 2
	Flags: Linked
*/
function stop(kvp, b_auto_delete = 0)
{
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	foreach(var_dcd6c23 in var_fed53aae)
	{
		namespace_96ff9fb2::function_4810b274(var_dcd6c23, b_auto_delete);
	}
}

/*
	Name: pause
	Namespace: wave_manager
	Checksum: 0x26287926
	Offset: 0x6D30
	Size: 0xC0
	Parameters: 2
	Flags: None
*/
function pause(kvp, b_auto_delete = 0)
{
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	foreach(var_dcd6c23 in var_fed53aae)
	{
		var_dcd6c23 flag::set("paused");
	}
}

/*
	Name: resume
	Namespace: wave_manager
	Checksum: 0xE1AE538F
	Offset: 0x6DF8
	Size: 0xC0
	Parameters: 2
	Flags: None
*/
function resume(kvp, b_auto_delete = 0)
{
	var_fed53aae = self namespace_96ff9fb2::function_32b947df(kvp);
	foreach(var_dcd6c23 in var_fed53aae)
	{
		var_dcd6c23 flag::clear("paused");
	}
}

