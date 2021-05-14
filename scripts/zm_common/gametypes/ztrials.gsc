// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_10034e69dca1cdbd;
#using script_1254ac024174d9c0;
#using script_1402fb2f7b0ede8b;
#using script_1496ada77dc2f2e2;
#using script_1827ef4caab1c237;
#using script_1ac263b07ef50ab6;
#using script_225941405db7c1fd;
#using script_27c22e1d8df4d852;
#using script_27d214e32f50853d;
#using script_35d3717bf2cbee8f;
#using script_3657077a08b7f19e;
#using script_460f2e04fb3cff8a;
#using script_4aeb3279b6b23a91;
#using script_512d27609721ec85;
#using script_536485e2fdf72e34;
#using script_559aef57a0fe3c60;
#using script_6021ce59143452c3;
#using script_660b0ec6a2295085;
#using script_6951ea86fdae9ae0;
#using script_6ce38ab036223e6e;
#using script_6d813fcbc979603a;
#using script_7299aefe4149ed5d;
#using script_770e34dfe9b07f3c;
#using script_7828033bc0ecda72;
#using script_7b843bf90a032750;
#using script_e56ea76d6c36d39;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\gametypes\zm_gametype.gsc;
#using scripts\zm_common\zm_game_module.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace ztrials;

/*
	Name: main
	Namespace: ztrials
	Checksum: 0x4BD7697E
	Offset: 0x238
	Size: 0x19C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	zm_gametype::main();
	level.onprecachegametype = &onprecachegametype;
	level.onstartgametype = &onstartgametype;
	level._game_module_custom_spawn_init_func = &zm_gametype::custom_spawn_init_func;
	level._game_module_stat_update_func = &zm_stats::survival_classic_custom_stat_update;
	level._round_start_func = &namespace_a28acff3::round_start;
	level.var_57cc29f3 = &function_491101ba;
	level.var_d0b54199 = &function_b8839207;
	level.var_9093a47e = &function_b8839207;
	level.round_end_custom_logic = &function_61fd0e87;
	level.round_number = 0;
	level.var_df8480a0 = 0;
	level flag::init(#"ztrial", 1);
	callback::on_connect(&function_8277ff43);
	level._supress_survived_screen = 1;
	setscoreboardcolumns("score", "kills", "headshots", "revives", "downs");
}

/*
	Name: function_a97958c3
	Namespace: ztrials
	Checksum: 0x3077CB36
	Offset: 0x3E0
	Size: 0x164
	Parameters: 1
	Flags: Event
*/
event function_a97958c3(eventstruct)
{
	var_189d26ca = "";
	/#
		var_189d26ca = getdvarstring(#"hash_14ee5e66e7bb1ed7");
	#/
	var_3b363b7a = getgametypesetting(#"zmtrialsvariant");
	if(isdefined(var_3b363b7a) && var_3b363b7a > 0)
	{
		var_189d26ca = util::function_53bbf9d2() + "_variant_" + var_3b363b7a;
	}
	else if(var_189d26ca == "")
	{
		var_189d26ca = util::function_53bbf9d2() + "_default";
	}
	/#
		assert(var_189d26ca != "", "");
	#/
	level.var_6d87ac05 = zm_trial::function_d02ffd(var_189d26ca);
	/#
		assert(isdefined(level.var_6d87ac05), "");
	#/
	/#
		function_9a6b2309();
	#/
}

/*
	Name: onprecachegametype
	Namespace: ztrials
	Checksum: 0xB3266A59
	Offset: 0x550
	Size: 0x1E
	Parameters: 0
	Flags: None
*/
function onprecachegametype()
{
	level.canplayersuicide = &zm_gametype::canplayersuicide;
}

/*
	Name: onstartgametype
	Namespace: ztrials
	Checksum: 0x90D95AF8
	Offset: 0x578
	Size: 0x16C
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	level.spawnmins = (0, 0, 0);
	level.spawnmaxs = (0, 0, 0);
	structs = struct::get_array("player_respawn_point", "targetname");
	foreach(struct in structs)
	{
		level.spawnmins = math::expand_mins(level.spawnmins, struct.origin);
		level.spawnmaxs = math::expand_maxs(level.spawnmaxs, struct.origin);
	}
	level.mapcenter = math::find_box_center(level.spawnmins, level.spawnmaxs);
	setmapcenter(level.mapcenter);
	changeadvertisedstatus(0);
}

/*
	Name: function_8277ff43
	Namespace: ztrials
	Checksum: 0xBCD3266
	Offset: 0x6F0
	Size: 0x54
	Parameters: 0
	Flags: Private
*/
private function function_8277ff43()
{
	self endon(#"disconnect");
	level flag::wait_till("start_zombie_round_logic");
	waitframe(1);
	self zm_laststand::function_3d685b5f(0);
}

/*
	Name: function_491101ba
	Namespace: ztrials
	Checksum: 0x994821FC
	Offset: 0x750
	Size: 0x2AE
	Parameters: 1
	Flags: Private
*/
private function function_491101ba(player)
{
	if(player hasperk(#"hash_5b141f82a55645a9") && (!(isdefined(player.var_a4630f64) && player.var_a4630f64)))
	{
		return 1;
	}
	if(level flag::get("round_reset"))
	{
		return 1;
	}
	var_57807cdc = [];
	foreach(player in getplayers())
	{
		if(!isdefined(var_57807cdc))
		{
			var_57807cdc = [];
		}
		else if(!isarray(var_57807cdc))
		{
			var_57807cdc = array(var_57807cdc);
		}
		if(!isinarray(var_57807cdc, player))
		{
			var_57807cdc[var_57807cdc.size] = player;
		}
	}
	if(var_57807cdc.size > 1)
	{
		zm_trial::fail(#"hash_60e5e8df8709ad64", var_57807cdc);
	}
	else if(var_57807cdc.size == 1)
	{
		zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
	}
	else if(!isdefined(var_57807cdc))
	{
		var_57807cdc = [];
	}
	else if(!isarray(var_57807cdc))
	{
		var_57807cdc = array(var_57807cdc);
	}
	if(!isinarray(var_57807cdc, player))
	{
		var_57807cdc[var_57807cdc.size] = player;
	}
	zm_trial::fail(#"hash_272fae998263208b", var_57807cdc);
	if(level flag::get("round_reset"))
	{
		return 1;
	}
	/#
		assert(level flag::get(#"hash_6acab8bde7078239"));
	#/
	return 0;
}

/*
	Name: function_61fd0e87
	Namespace: ztrials
	Checksum: 0xCA0D96D1
	Offset: 0xA08
	Size: 0xF4
	Parameters: 0
	Flags: Private
*/
private function function_61fd0e87()
{
	/#
		assert(isdefined(level.var_6d87ac05));
	#/
	if(!level flag::get("round_reset") && level.round_number >= level.var_6d87ac05.rounds.size)
	{
		level thread zm_trial::function_361e2cb0();
	}
	if(!level flag::get("round_reset") && !level flag::get(#"hash_6acab8bde7078239"))
	{
		namespace_b22c99a5::function_96e10d88(1);
		wait(3);
	}
}

/*
	Name: function_b8839207
	Namespace: ztrials
	Checksum: 0x229530F1
	Offset: 0xB08
	Size: 0xEE
	Parameters: 2
	Flags: Private
*/
private function function_b8839207(e_door, n_cost)
{
	level flag::wait_till("start_zombie_round_logic");
	e_door notify(#"hash_42c191c31ed08a4");
	e_door endon(#"hash_42c191c31ed08a4", #"death");
	while(true)
	{
		if(n_cost > 0 && namespace_497ab7da::is_active())
		{
			e_door sethintstring(#"hash_55d25caf8f7bbb2f");
		}
		else
		{
			e_door zm_utility::set_hint_string(self, "default_buy_door", n_cost);
		}
		wait(1);
	}
}

/*
	Name: complete_current_round
	Namespace: ztrials
	Checksum: 0x15FB6CAF
	Offset: 0xC00
	Size: 0x106
	Parameters: 0
	Flags: Private
*/
private function complete_current_round()
{
	/#
		level.devcheater = 1;
		level.zombie_total = 0;
		level notify(#"kill_round");
		wait(1);
		zombies = getaiteamarray(level.zombie_team);
		if(isdefined(zombies))
		{
			for(i = 0; i < zombies.size; i++)
			{
				if(isdefined(zombies[i].ignore_devgui_death) && zombies[i].ignore_devgui_death)
				{
					continue;
				}
				zombies[i] dodamage(zombies[i].health + 666, zombies[i].origin);
			}
		}
	#/
}

/*
	Name: function_1201b5da
	Namespace: ztrials
	Checksum: 0xDF5FD088
	Offset: 0xD10
	Size: 0x196
	Parameters: 1
	Flags: Private
*/
private function function_1201b5da(medal)
{
	/#
		round = undefined;
		switch(medal)
		{
			case "gold":
			{
				round = 30;
				break;
			}
			case "silver":
			{
				round = 20;
				break;
			}
			case "hash_5a4a42ab8880ab1":
			{
				round = 10;
				break;
			}
			default:
			{
				/#
					assert(0);
				#/
				break;
			}
		}
		/#
			assert(isdefined(round));
		#/
		var_48c6ec2e = level.var_6d87ac05.rounds[round - 1];
		/#
			assert(isdefined(var_48c6ec2e));
		#/
		for(i = 0; i < var_48c6ec2e.challenges.size; i++)
		{
			challenge = var_48c6ec2e.challenges[i];
			if(challenge.name == #"give_reward")
			{
				return challenge;
			}
		}
		/#
			assert(0);
		#/
		return undefined;
	#/
}

/*
	Name: function_9a6b2309
	Namespace: ztrials
	Checksum: 0x339880FE
	Offset: 0xEB0
	Size: 0x85E
	Parameters: 0
	Flags: Private
*/
private function function_9a6b2309()
{
	/#
		/#
			assert(isdefined(level.var_6d87ac05));
		#/
		foreach(var_48c6ec2e in level.var_6d87ac05.rounds)
		{
			adddebugcommand("" + var_48c6ec2e.round + "" + function_9e72a96(var_48c6ec2e.name) + "" + var_48c6ec2e.round + "" + var_48c6ec2e.round + "");
		}
		for(i = 0; i <= 3; i++)
		{
			adddebugcommand("" + i + "" + i + "");
		}
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			string = getdvarstring(#"hash_57e97658cd1d89e2", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				round_number = int(cmd[0]);
				if(isdefined(level.var_b9714a5d))
				{
					[[level.var_b9714a5d]](round_number);
				}
				level thread zm_game_module::zombie_goto_round(round_number);
				setdvar(#"hash_57e97658cd1d89e2", "");
			}
			string = getdvarstring(#"hash_25a4cfc19b09ae41", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				strikes = int(cmd[0]);
				if(strikes == 3)
				{
					zm_trial::function_fe2ecb6(strikes - 1);
					zm_trial::fail();
				}
				else
				{
					zm_trial::function_fe2ecb6(strikes);
				}
				setdvar(#"hash_25a4cfc19b09ae41", "");
			}
			string = getdvarstring(#"hash_2446ebd1d15f0dab", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				complete_current_round();
				setdvar(#"hash_2446ebd1d15f0dab", "");
			}
			string = getdvarstring(#"hash_5a32209acb1f54a0", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				zm_trial::fail(undefined, getplayers());
				setdvar(#"hash_5a32209acb1f54a0", "");
			}
			string = getdvarstring(#"hash_1576c65ebdf43de0", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				foreach(player in getplayers())
				{
					player zm_stats::function_49469f35("", 0);
					player zm_stats::function_49469f35("", 0);
					player zm_stats::function_49469f35("", 0);
				}
				level.var_ee7ca64 = [];
				setdvar(#"hash_1576c65ebdf43de0", "");
			}
			string = getdvarstring(#"hash_2f6ef50454652bf2", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				challenge = function_1201b5da(cmd[0]);
				foreach(player in getplayers())
				{
					player luinotifyevent(#"hash_8d33c3be569f08", 1, challenge.row);
					stat_name = challenge.params[1];
					curr_time = gettime();
					player zm_stats::function_49469f35(stat_name, curr_time);
				}
				setdvar(#"hash_2f6ef50454652bf2", "");
			}
			if(getdvarint(#"hash_145033f5271f2651", 0) == 1)
			{
				namespace_b22c99a5::function_9c1092f6();
				setdvar(#"hash_145033f5271f2651", 0);
			}
			waitframe(1);
		}
	#/
}

