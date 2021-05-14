// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18fed4d66b0b9c1;
#using script_1d29de500c266470;
#using script_290b3da82a2a68e4;
#using script_39bd5b6b799b1c9c;
#using script_47fb62300ac0bd60;
#using script_51f4cef054ca0f89;
#using script_caab14e8a60767c;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;

#namespace namespace_d3564fd8;

/*
	Name: function_89f2df9
	Namespace: namespace_d3564fd8
	Checksum: 0xC2496F01
	Offset: 0x280
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6a371c43cac9a1c4", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d3564fd8
	Checksum: 0x3076B6B
	Offset: 0x2D0
	Size: 0x832
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_revived(&function_3de8b6e0);
	callback::on_player_damage(&function_36e144fa);
	callback::on_vehicle_killed(&function_8920ad6e);
	callback::function_10a4dd0a(&function_106be0dc);
	callback::function_10a4dd0a(&function_10a4dd0a);
	callback::function_955a779c(&function_393ec79e);
	callback::function_c55a0479(&function_6c478b00);
	callback::add_callback(#"freefall", &function_c9a18304);
	callback::on_challenge_complete(&on_challenge_complete);
	callback::function_ed93a653(&function_ed93a653);
	callback::function_98a0917d(&function_98a0917d);
	callback::function_1475a073(&function_a117c988);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::function_14dae612(&function_14dae612);
	callback::function_1ae8059(&function_1ae8059);
	level.var_c8453874 = &function_35ac33e1;
	level.var_959f44cf = &function_59c85637;
	level.var_db720da1 = {};
	level.var_db720da1.kill = (isdefined(getgametypesetting(#"hash_271f60ded9c53d99")) ? getgametypesetting(#"hash_271f60ded9c53d99") : 0);
	level.var_db720da1.win = (isdefined(getgametypesetting(#"hash_788f9d764901a139")) ? getgametypesetting(#"hash_788f9d764901a139") : 0);
	level.var_db720da1.top5 = (isdefined(getgametypesetting(#"hash_678c85f6f120d34b")) ? getgametypesetting(#"hash_678c85f6f120d34b") : 0);
	level.var_db720da1.top10 = (isdefined(getgametypesetting(#"hash_14a8959bbad2b045")) ? getgametypesetting(#"hash_14a8959bbad2b045") : 0);
	level.var_db720da1.top15 = (isdefined(getgametypesetting(#"hash_14a8909bbad2a7c6")) ? getgametypesetting(#"hash_14a8909bbad2a7c6") : 0);
	level.var_db720da1.top20 = (isdefined(getgametypesetting(#"hash_14ac1b9bbad5c9ce")) ? getgametypesetting(#"hash_14ac1b9bbad5c9ce") : 0);
	level.var_db720da1.top25 = (isdefined(getgametypesetting(#"hash_14ac209bbad5d24d")) ? getgametypesetting(#"hash_14ac209bbad5d24d") : 0);
	level.var_db720da1.top30 = (isdefined(getgametypesetting(#"hash_14af219bbad809d7")) ? getgametypesetting(#"hash_14af219bbad809d7") : 0);
	level.var_db720da1.top50 = (isdefined(getgametypesetting(#"hash_149b1d9bbac75a01")) ? getgametypesetting(#"hash_149b1d9bbac75a01") : 0);
	level.var_db720da1.top60 = (isdefined(getgametypesetting(#"hash_149e239bbac99a0a")) ? getgametypesetting(#"hash_149e239bbac99a0a") : 0);
	level.var_db720da1.top75 = (isdefined(getgametypesetting(#"hash_14a18c9bbacc824c")) ? getgametypesetting(#"hash_14a18c9bbacc824c") : 0);
	level.var_db720da1.lives = (isdefined(getgametypesetting(#"hash_64e698c86ac94f34")) ? getgametypesetting(#"hash_64e698c86ac94f34") : 0);
	level.var_db720da1.var_7751a92c = (isdefined(getgametypesetting(#"hash_6beb27cc6f581f2d")) ? getgametypesetting(#"hash_6beb27cc6f581f2d") : 0);
	level.var_db720da1.var_56dcbb49 = (isdefined(getgametypesetting(#"hash_5596ee09efc44216")) ? getgametypesetting(#"hash_5596ee09efc44216") : 0);
	level.var_db720da1.var_cbafe055 = (isdefined(getgametypesetting(#"hash_6551049476c7127c")) ? getgametypesetting(#"hash_6551049476c7127c") : 0);
	level.var_db720da1.var_878ccaf0 = (isdefined(getgametypesetting(#"hash_709b7e506f5d3775")) ? getgametypesetting(#"hash_709b7e506f5d3775") : 0);
}

/*
	Name: __main__
	Namespace: namespace_d3564fd8
	Checksum: 0x80F724D1
	Offset: 0xB10
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_cfc02934
	Namespace: namespace_d3564fd8
	Checksum: 0xDC93BE09
	Offset: 0xB20
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_cfc02934()
{
	var_88846d2d = getdvar(#"hash_4a5fd7d94cfc9dfd", 0) != 0 || getdvarint(#"hash_4a5fd7d94cfc9dfd", 0) != 0;
	if(isplayer(self) && !isbot(self) && var_88846d2d)
	{
		player = self;
		player giveachievement("wz_specialist_super_fan");
	}
}

/*
	Name: codecallback_medal
	Namespace: namespace_d3564fd8
	Checksum: 0x14EE8894
	Offset: 0xBF0
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event codecallback_medal(eventstruct)
{
	if(isdefined(eventstruct) && isdefined(eventstruct.var_7fcb97e3) && isdefined(level.scoreinfo) && isdefined(level.scoreinfo[eventstruct.var_7fcb97e3]))
	{
		medalinfo = level.scoreinfo[eventstruct.var_7fcb97e3];
		self function_ffda8476("medal", #"medalxp", medalinfo[#"xp"]);
	}
}

/*
	Name: function_1ae8059
	Namespace: namespace_d3564fd8
	Checksum: 0x87622787
	Offset: 0xCA8
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_1ae8059(params)
{
	player = params.player;
	if(isdefined(player) && isdefined(player.pers) && isdefined(player.pers[#"contracts"]) && isdefined(player.pers[#"contracts"][params.var_38280f2f]))
	{
		contract = player.pers[#"contracts"][params.var_38280f2f];
		if(isdefined(contract) && isdefined(contract.xp) && contract.xp > 0)
		{
			player function_ffda8476("contract", #"hash_48abd9fc5ca1d7a3", contract.xp);
		}
	}
}

/*
	Name: function_ffda8476
	Namespace: namespace_d3564fd8
	Checksum: 0x4BD25048
	Offset: 0xDE0
	Size: 0x31A
	Parameters: 3
	Flags: Linked
*/
function function_ffda8476(var_c14ca2e6, var_9522ba0f, amount)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	var_60a35182 = 0;
	if(isdefined(player.pers) && isdefined(player.pers[#"plevel"]) && player.pers[#"plevel"] == level.maxprestige)
	{
		var_60a35182 = 1;
	}
	if(isdefined(var_60a35182) && var_60a35182)
	{
		prevxp = player stats::function_441050ca("PARAGON_RANKXP");
		player addrankxpvalue(var_c14ca2e6, amount);
		curxp = player stats::function_441050ca("PARAGON_RANKXP");
	}
	else
	{
		prevxp = player stats::function_441050ca("RANKXP");
		player addrankxpvalue(var_c14ca2e6, amount);
		curxp = player stats::function_441050ca("RANKXP");
		if(isdefined(player.pers) && isdefined(player.pers[#"plevel"]) && player.pers[#"plevel"] == level.maxprestige - 1)
		{
			if(curxp == level.rankxpcap)
			{
				player.pers[#"plevel"] = level.maxprestige;
				player stats::function_4db3fba1(#"plevel", level.maxprestige);
				player stats::function_4db3fba1(#"paragon_rank", level.maxrank + 1);
				player stats::function_62b271d8(#"plevel", level.maxprestige);
			}
		}
	}
	var_a402c6e3 = curxp - prevxp;
	player stats::function_dad108fa(var_9522ba0f, var_a402c6e3);
	player.pers[#"hash_6344af0b142ed0b6"] = 1;
}

/*
	Name: function_ec3a8858
	Namespace: namespace_d3564fd8
	Checksum: 0x65ED7575
	Offset: 0x1108
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_ec3a8858()
{
	player = self;
	if(!isplayer(player))
	{
		return 0;
	}
	if(isdefined(player.inventory) && isdefined(player.inventory.consumed))
	{
		if((isdefined(player.inventory.inventory.consumed.size) ? player.inventory.consumed.size : 0) > 0)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_f874ca5e
	Namespace: namespace_d3564fd8
	Checksum: 0x7219D7CD
	Offset: 0x11B0
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f874ca5e(var_10e8ffc4)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(!isplayer(player))
	{
		return;
	}
	player.pers[#"hash_50ee08d8d2973448"] = var_10e8ffc4;
	player match_record::set_player_stat(#"hash_346ac0260c42e168", var_10e8ffc4);
	player stats::function_7a850245(#"hash_50ee08d8d2973448", var_10e8ffc4);
}

/*
	Name: function_456aacb1
	Namespace: namespace_d3564fd8
	Checksum: 0x62DF5AB
	Offset: 0x1280
	Size: 0x13A
	Parameters: 0
	Flags: Linked
*/
function function_456aacb1()
{
	/#
		assert(isplayer(self));
	#/
	player = self;
	player.pers[#"hash_57f285fa2d6bfb0"] = gettime();
	player.pers[#"deathtime"] = 0;
	player.pers[#"hash_13cecb90c28e6b25"] = 0;
	player.pers[#"hash_752b6018640efd0f"] = 0;
	player.pers[#"hash_4e1bb8dada2d90f5"] = 0;
	player.pers[#"hash_39220b202c67c56b"] = 0;
	player.pers[#"hash_50ee08d8d2973448"] = 0;
	player.pers[#"hash_95906bc03912ac4"] = 0;
}

/*
	Name: function_2c8aac6
	Namespace: namespace_d3564fd8
	Checksum: 0x9651A89D
	Offset: 0x13C8
	Size: 0x352
	Parameters: 0
	Flags: Linked
*/
function function_2c8aac6()
{
	/#
		assert(isplayer(self));
	#/
	player = self;
	if(!player stats::function_f94325d3() || isbot(player) || !isdefined(player.pers))
	{
		return;
	}
	if(isdefined(player.pers[#"hash_39220b202c67c56b"]) && player.pers[#"hash_39220b202c67c56b"])
	{
		/#
			println("" + (isdefined(player.name) ? player.name : "") + "");
		#/
		return;
	}
	var_87ecbce6 = getdvarfloat(#"hash_138e4c481ef6cfb1", 0);
	var_7f6396f0 = getdvarfloat(#"hash_5bb505659db06d9b", 0);
	if(!isdefined(player.pers[#"hash_13cecb90c28e6b25"]))
	{
		player.pers[#"hash_13cecb90c28e6b25"] = gettime();
	}
	var_1ef5a3ba = player function_59c85637();
	player namespace_78a95918::function_9b431779(var_1ef5a3ba);
	player contracts::function_78083139();
	player challenges::function_659f7dc(var_1ef5a3ba, var_87ecbce6, var_7f6396f0);
	player function_4835d26a();
	/#
		println("" + (isdefined(player.name) ? player.name : "") + "" + player.pers[#"hash_50ee08d8d2973448"] + "" + "" + player.pers[#"hash_95906bc03912ac4"] + "" + "" + player.pers[#"kills"] + "" + "" + player.pers[#"hash_4e1bb8dada2d90f5"] + "");
	#/
	player.pers[#"hash_39220b202c67c56b"] = 1;
}

/*
	Name: function_59c85637
	Namespace: namespace_d3564fd8
	Checksum: 0x821EA0B9
	Offset: 0x1728
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_59c85637()
{
	if(self.pers[#"hash_13cecb90c28e6b25"])
	{
		var_c06441ec = max(gettime() - self.pers[#"hash_13cecb90c28e6b25"], 0);
	}
	else
	{
		var_c06441ec = 0;
	}
	var_1ef5a3ba = 0;
	if(isdefined(self.pers[#"hash_150795bee4d46ce4"]))
	{
		var_1ef5a3ba = max(gettime() - self.pers[#"hash_150795bee4d46ce4"] - var_c06441ec, 0);
	}
	return var_1ef5a3ba;
}

/*
	Name: player_disconnected
	Namespace: namespace_d3564fd8
	Checksum: 0x21DA3B01
	Offset: 0x17F8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function player_disconnected()
{
	self stats::function_b7f80d87(#"died", 1);
	self function_2c8aac6();
}

/*
	Name: function_fb20ad56
	Namespace: namespace_d3564fd8
	Checksum: 0xA0A40B93
	Offset: 0x1848
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fb20ad56()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_6d5e162204f447f4", 1);
}

/*
	Name: function_d61fdbef
	Namespace: namespace_d3564fd8
	Checksum: 0x37972A56
	Offset: 0x18B8
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d61fdbef()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_25f4611fc9d40aa8", 1);
}

/*
	Name: function_67949803
	Namespace: namespace_d3564fd8
	Checksum: 0x46D0955A
	Offset: 0x1928
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_67949803()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_63307a0460c698ac", 1);
}

/*
	Name: function_51cae91b
	Namespace: namespace_d3564fd8
	Checksum: 0x3F69FA02
	Offset: 0x1998
	Size: 0x3BC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_51cae91b(placement)
{
	player = self;
	if(placement <= 5 && level.var_db720da1.top5 > 0)
	{
		player function_ffda8476("top5", #"hash_1c5941725865ae68", level.var_db720da1.top5);
	}
	else if(placement <= 10 && level.var_db720da1.top10 > 0)
	{
		player function_ffda8476("top10", #"hash_1c5941725865ae68", level.var_db720da1.top10);
	}
	else if(placement <= 15 && level.var_db720da1.top15 > 0)
	{
		player function_ffda8476("top15", #"hash_1c5941725865ae68", level.var_db720da1.top15);
	}
	else if(placement <= 20 && level.var_db720da1.top20 > 0)
	{
		player function_ffda8476("top20", #"hash_1c5941725865ae68", level.var_db720da1.top20);
	}
	else if(placement <= 25 && level.var_db720da1.top25 > 0)
	{
		player function_ffda8476("top25", #"hash_1c5941725865ae68", level.var_db720da1.top25);
	}
	else if(placement <= 30 && level.var_db720da1.top30 > 0)
	{
		player function_ffda8476("top30", #"hash_1c5941725865ae68", level.var_db720da1.top30);
	}
	else if(placement <= 50 && level.var_db720da1.top50 > 0)
	{
		player function_ffda8476("top50", #"hash_1c5941725865ae68", level.var_db720da1.top50);
	}
	else if(placement <= 60 && level.var_db720da1.top60 > 0)
	{
		player function_ffda8476("top60", #"hash_1c5941725865ae68", level.var_db720da1.top60);
	}
	else if(placement <= 75 && level.var_db720da1.top75 > 0)
	{
		player function_ffda8476("top75", #"hash_1c5941725865ae68", level.var_db720da1.top75);
	}
}

/*
	Name: function_a0fea1a9
	Namespace: namespace_d3564fd8
	Checksum: 0xA7508084
	Offset: 0x1D60
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a0fea1a9()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_6429d1fccdef2c9", 1);
}

/*
	Name: function_3217b0d2
	Namespace: namespace_d3564fd8
	Checksum: 0xB0A08797
	Offset: 0x1DD0
	Size: 0xEC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3217b0d2()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_7b8d2c77874a1c24", 1);
	if(player function_ec3a8858())
	{
		player stats::function_d40764f3(#"hash_337e05385393e3a6", 1);
	}
	if(!(isdefined(player.var_e4bec3d4) && player.var_e4bec3d4))
	{
		player stats::function_d40764f3(#"hash_702849e1bf1e3915", 1);
	}
}

/*
	Name: function_6a7970fe
	Namespace: namespace_d3564fd8
	Checksum: 0x864C8944
	Offset: 0x1EC8
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6a7970fe()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player stats::function_d40764f3(#"hash_5e9a745460a10f80", 1);
	if(isdefined(player.avenger) && player.avenger)
	{
		player stats::function_d40764f3(#"hash_5387d5e6f15c6b55", 1);
	}
	if(isdefined(player.var_4ceff2bf) && player.var_4ceff2bf.size <= 1)
	{
		player stats::function_d40764f3(#"hash_7158067d85c1402a", 1);
	}
}

/*
	Name: team_eliminated
	Namespace: namespace_d3564fd8
	Checksum: 0x8DB3A2D6
	Offset: 0x1FD0
	Size: 0x2B0
	Parameters: 2
	Flags: Linked
*/
function team_eliminated(team, var_4aee0d2d)
{
	if(!isdefined(team))
	{
		/#
			println("");
		#/
		return;
	}
	a_players = getplayers(team);
	if(isdefined(level.var_29ab88df))
	{
		level [[level.var_29ab88df]](a_players, var_4aee0d2d);
	}
	/#
		println("" + (isdefined(team) ? team : "") + "" + var_4aee0d2d + "");
	#/
	foreach(player in a_players)
	{
		if(!isdefined(player.pers) || (isdefined(player.pers[#"hash_2283e9384383a6e9"]) && player.pers[#"hash_2283e9384383a6e9"]))
		{
			continue;
		}
		player.pers[#"hash_2283e9384383a6e9"] = 1;
		player.pers[#"hash_13cecb90c28e6b25"] = gettime();
		player.pers[#"hash_95906bc03912ac4"] = var_4aee0d2d;
		player match_record::set_player_stat(#"hash_55e183c455a1df4c", var_4aee0d2d);
		player stats::function_7a850245(#"hash_95906bc03912ac4", var_4aee0d2d);
		if(var_4aee0d2d <= 15)
		{
			player function_a0fea1a9();
		}
		if(var_4aee0d2d <= 10)
		{
			player function_3217b0d2();
		}
		if(var_4aee0d2d <= 5)
		{
			player function_6a7970fe();
		}
		player function_51cae91b(var_4aee0d2d);
	}
}

/*
	Name: function_5648f82
	Namespace: namespace_d3564fd8
	Checksum: 0x29961453
	Offset: 0x2288
	Size: 0x5E0
	Parameters: 1
	Flags: Linked
*/
function function_5648f82(team)
{
	/#
		println("" + (isdefined(team) ? team : ""));
	#/
	if(isdefined(team))
	{
		foreach(player in getplayers(team))
		{
			if(!player stats::function_f94325d3())
			{
				continue;
			}
			if(!isdefined(player.pers) || (isdefined(player.pers[#"hash_2283e9384383a6e9"]) && player.pers[#"hash_2283e9384383a6e9"]))
			{
				continue;
			}
			player.pers[#"hash_2283e9384383a6e9"] = 1;
			player.pers[#"hash_95906bc03912ac4"] = 1;
			player.pers[#"hash_50ee08d8d2973448"] = 1;
			player function_a0fea1a9();
			player function_3217b0d2();
			player function_6a7970fe();
			player function_fb20ad56();
			player function_d61fdbef();
			player function_67949803();
			player function_51cae91b(1);
			var_ced14f4b = level.var_db720da1.win;
			if(util::function_5df4294() == "warzone_pandemic_quad")
			{
				if(function_22448d6c(team) == infection::function_76601b7d())
				{
					var_ced14f4b = level.var_db720da1.var_878ccaf0;
				}
			}
			player function_ffda8476("win", #"hash_28fedb9313539419", var_ced14f4b);
			player stats::function_dad108fa(#"hash_5b27060b266954a7", 1);
			player giveachievement("wz_first_win");
			var_4cf27874 = player stats::function_441050ca(#"wins");
			if(var_4cf27874 >= 9)
			{
				player giveachievement("wz_not_a_fluke");
			}
			isinfected = util::function_5df4294() == "warzone_pandemic_quad" && function_22448d6c(team) == infection::function_76601b7d();
			if(!isdefined(player.laststandcount) || player.laststandcount <= 0 && !isinfected)
			{
				player stats::function_d40764f3(#"hash_4344dd4b4bc790fe", 1);
			}
			if(isdefined(player.pers[#"kills"]) && player.pers[#"kills"] == 0)
			{
				player stats::function_d40764f3(#"hash_7dabb8157efae82b", 1);
			}
			player_counts = warzone::function_de15dc32();
			if(isalive(player) && player_counts.alive == 1 && (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1) > 1)
			{
				player stats::function_d40764f3(#"hash_53e5311e0351d945", 1);
			}
			player function_f874ca5e(1);
			player match_record::set_player_stat(#"hash_55e183c455a1df4c", 1);
			player stats::function_7a850245(#"hash_95906bc03912ac4", 1);
			player stats::function_b7f80d87(#"died", 1);
		}
	}
}

/*
	Name: function_66fe9481
	Namespace: namespace_d3564fd8
	Checksum: 0x53EFD407
	Offset: 0x2870
	Size: 0x2AC
	Parameters: 3
	Flags: Linked
*/
function function_66fe9481(vehicle, player, seatindex)
{
	if(level.inprematchperiod)
	{
		return;
	}
	if(seatindex === 0)
	{
		vehicle thread function_f8072c71(player);
		if(!isdefined(player.var_e081a4e5))
		{
			player.var_e081a4e5 = [];
		}
		var_b01d9212 = isairborne(vehicle);
		var_7c6311c4 = vehicle.vehicleclass === "boat";
		var_f03db647 = !var_b01d9212 && !var_7c6311c4;
		if(var_b01d9212 && !isdefined(player.var_e081a4e5[#"air"]))
		{
			player.var_e081a4e5[#"air"] = 1;
		}
		else if(var_7c6311c4 && !isdefined(player.var_e081a4e5[#"sea"]))
		{
			player.var_e081a4e5[#"sea"] = 1;
		}
		else if(var_f03db647 && !isdefined(player.var_e081a4e5[#"land"]))
		{
			player.var_e081a4e5[#"land"] = 1;
		}
		if(player.var_e081a4e5.size == 3)
		{
			if(!(isdefined(player.var_e081a4e5[#"hash_f42169f228206e4"]) && player.var_e081a4e5[#"hash_f42169f228206e4"]))
			{
				player.var_e081a4e5[#"hash_f42169f228206e4"] = 1;
				player stats::function_d40764f3(#"hash_66b1961a8b4d9fcd", 1);
			}
		}
		if(isdefined(player.lastdamagetime))
		{
			time = gettime();
			if(time - player.lastdamagetime <= 3000)
			{
				player thread function_d0c523bf();
			}
		}
	}
}

/*
	Name: function_d0c523bf
	Namespace: namespace_d3564fd8
	Checksum: 0x92A6F697
	Offset: 0x2B28
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_d0c523bf()
{
	self endon(#"death", #"exit_vehicle", #"disconnect");
	wait(5);
	if(self isinvehicle())
	{
		self stats::function_d40764f3(#"hash_68fb4d162b6d7c20", 1);
	}
}

/*
	Name: function_f8072c71
	Namespace: namespace_d3564fd8
	Checksum: 0xF1639481
	Offset: 0x2BB0
	Size: 0x412
	Parameters: 1
	Flags: Linked
*/
function function_f8072c71()
{
System.InvalidOperationException: Stack empty.
   at System.ThrowHelper.ThrowInvalidOperationException(ExceptionResource resource)
   at System.Collections.Generic.Stack`1.Pop()
   at Cerberus.Logic.Decompiler.BuildExpression(ScriptOp startOp) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 1185
   at Cerberus.Logic.Decompiler.ProcessInstruction(ScriptOp operation, DecompilerBlock block) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 2343
   at Cerberus.Logic.Decompiler.DecompileBlock(DecompilerBlock decompilerBlock, Int32 tabs) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 998
   at Cerberus.Logic.Decompiler..ctor(ScriptExport function, ScriptBase script) in D:\Modding\Call of Duty\t89-dec\Cerberus.Logic\Decompiler\Decompiler.cs:line 222
/*
function function_f8072c71(player)
{
	if(!isplayer(player) || !isdefined(self))
	{
		return;
	}
	self endon(#"hash_2d45f3f009f1b3b3", #"death");
	player endon(#"death", #"exit_vehicle", #"disconnect");
	var_d98c5084 = self.origin;
	distancetraveled = 0;
	var_b01d9212 = isairborne(self);
	var_7c6311c4 = self.vehicleclass === "boat";

*/

	/* ======== */

/* 
	Stack: 
*/
	/* ======== */

/* 
	Blocks: 
	Cerberus.Logic.BasicBlock at 0x2BB0, end at 0x2FC3
	Cerberus.Logic.IfBlock at 0x2C0A, end at 0x2C34
	Cerberus.Logic.WhileLoop at 0x2CE0, end at 0x2FBC
	Cerberus.Logic.IfBlock at 0x2CFA, end at 0x2FBC
	Cerberus.Logic.IfBlock at 0x2D48, end at 0x2FBC
	Cerberus.Logic.IfBlock at 0x2D54, end at 0x2E22
	Cerberus.Logic.IfBlock at 0x2DE4, end at 0x2E22
	Cerberus.Logic.IfBlock at 0x2E22, end at 0x2EEA
	Cerberus.Logic.IfBlock at 0x2EAC, end at 0x2EEA
	Cerberus.Logic.IfBlock at 0x2EEA, end at 0x2FB2
	Cerberus.Logic.IfBlock at 0x2F74, end at 0x2FB2
*/
	/* ======== */

}

/*
	Name: on_exit_locked_on_vehicle
	Namespace: namespace_d3564fd8
	Checksum: 0x7A10546B
	Offset: 0x2FD0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function on_exit_locked_on_vehicle(player)
{
	if(isplayer(player))
	{
		player stats::function_d40764f3(#"hash_79c8466e54f49c21", 1);
	}
}

/*
	Name: function_c9a18304
	Namespace: namespace_d3564fd8
	Checksum: 0x7BC0ADE8
	Offset: 0x3028
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_c9a18304(eventstruct)
{
	if(eventstruct.freefall)
	{
		if(isplayer(self))
		{
			self thread function_da21a17c();
		}
	}
	else
	{
		self notify(#"hash_74973f333d2fabfa");
	}
}

/*
	Name: function_da21a17c
	Namespace: namespace_d3564fd8
	Checksum: 0x76F0DD1E
	Offset: 0x3090
	Size: 0x1B8
	Parameters: 0
	Flags: Linked
*/
function function_da21a17c()
{
	self endon(#"hash_74973f333d2fabfa", #"death", #"disconnect");
	var_d98c5084 = self.origin;
	distancetraveled = 0;
	while(isdefined(self))
	{
		wait(1);
		if(isdefined(self))
		{
			distancetraveled = int(distancetraveled + distance2d(self.origin, var_d98c5084));
			var_d98c5084 = self.origin;
			if(distancetraveled > 1000)
			{
				self stats::function_dad108fa(#"hash_9914160f3260c69", distancetraveled);
				distancetraveled = 0;
				var_ae40ba19 = self stats::function_441050ca(#"hash_9914160f3260c69");
				var_7f444a72 = int(var_ae40ba19 / 63360);
				var_a7f485eb = self stats::function_441050ca(#"hash_2534c2d31b841cf4");
				if(var_7f444a72 > var_a7f485eb)
				{
					diff = var_7f444a72 - var_a7f485eb;
					self stats::function_dad108fa(#"hash_2534c2d31b841cf4", diff);
				}
			}
		}
	}
}

/*
	Name: function_3de8b6e0
	Namespace: namespace_d3564fd8
	Checksum: 0x4B740723
	Offset: 0x3250
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_3de8b6e0(params)
{
	if(!gamestate::is_state("playing") || !isdefined(params.reviver))
	{
		return;
	}
}

/*
	Name: function_36e144fa
	Namespace: namespace_d3564fd8
	Checksum: 0xEBA9122C
	Offset: 0x3298
	Size: 0x26A
	Parameters: 1
	Flags: Linked
*/
function function_36e144fa(params)
{
	if(!(isdefined(self.var_e4bec3d4) && self.var_e4bec3d4))
	{
		if(params.smeansofdeath == "MOD_DEATH_CIRCLE")
		{
			self.var_e4bec3d4 = 1;
		}
	}
	if(!isdefined(self.var_9854aa3a))
	{
		self.var_9854aa3a = [];
	}
	attacker = params.eattacker;
	if(isplayer(attacker) && !isinarray(self.var_9854aa3a, attacker))
	{
		if(!isdefined(self.var_9854aa3a))
		{
			self.var_9854aa3a = [];
		}
		else if(!isarray(self.var_9854aa3a))
		{
			self.var_9854aa3a = array(self.var_9854aa3a);
		}
		if(!isinarray(self.var_9854aa3a, attacker))
		{
			self.var_9854aa3a[self.var_9854aa3a.size] = attacker;
		}
	}
	bare_hands = getweapon(#"bare_hands");
	var_c1f166f3 = self hasweapon(bare_hands);
	if(var_c1f166f3)
	{
		if(!isdefined(self.var_91ddc6c5))
		{
			self.var_91ddc6c5 = [];
		}
		if(isplayer(attacker) && !isinarray(self.var_91ddc6c5, attacker))
		{
			if(!isdefined(self.var_91ddc6c5))
			{
				self.var_91ddc6c5 = [];
			}
			else if(!isarray(self.var_91ddc6c5))
			{
				self.var_91ddc6c5 = array(self.var_91ddc6c5);
			}
			if(!isinarray(self.var_91ddc6c5, attacker))
			{
				self.var_91ddc6c5[self.var_91ddc6c5.size] = attacker;
			}
		}
	}
}

/*
	Name: function_a117c988
	Namespace: namespace_d3564fd8
	Checksum: 0x61EFD1A7
	Offset: 0x3510
	Size: 0x19A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a117c988()
{
	if(isdefined(self.laststandparams))
	{
		attacker = self.laststandparams.attacker;
		if(isdefined(attacker) && isdefined(attacker.var_121392a1) && isarray(attacker.var_121392a1))
		{
			if(isdefined(attacker.var_121392a1[#"hash_59395d9b819a557c"]) || isdefined(attacker.var_121392a1[#"hash_120d7ead19a15cbf"]) || isdefined(attacker.var_121392a1[#"hash_1527a22d8a6fdc21"]))
			{
				self.laststandparams.var_6314a3a3 = 1;
			}
		}
		if(isplayer(attacker))
		{
			vehicle = attacker getvehicleoccupied();
			if(isdefined(vehicle) && isvehicle(vehicle))
			{
				seat = vehicle getoccupantseat(attacker);
				if(isdefined(seat))
				{
					if(seat === 0)
					{
						self.laststandparams.var_adb68654 = 1;
					}
					if(seat > 0)
					{
						self.laststandparams.var_69427d4d = 1;
					}
				}
			}
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_d3564fd8
	Checksum: 0xA8537181
	Offset: 0x36B8
	Size: 0x144
	Parameters: 1
	Flags: Linked, Private
*/
private function on_player_killed(params)
{
	victim = self;
	/#
		assert(isplayer(victim));
	#/
	if(isdefined(victim))
	{
		victim.pers[#"deathtime"] = gettime();
		player_counts = warzone::function_de15dc32(victim);
		var_10e8ffc4 = player_counts.alive + 1;
		if(var_10e8ffc4 <= 25)
		{
			victim function_fb20ad56();
		}
		if(var_10e8ffc4 <= 10)
		{
			victim function_d61fdbef();
		}
		if(var_10e8ffc4 <= 5)
		{
			victim function_67949803();
		}
		victim stats::function_b7f80d87(#"died", 1);
		victim function_f874ca5e(var_10e8ffc4);
	}
}

/*
	Name: function_35ac33e1
	Namespace: namespace_d3564fd8
	Checksum: 0x30777106
	Offset: 0x3808
	Size: 0xE4C
	Parameters: 3
	Flags: Linked
*/
function function_35ac33e1(attacker, victim, var_c5948a69 = {})
{
	if(isdefined(attacker))
	{
		var_ced14f4b = level.var_db720da1.kill;
		if(util::function_5df4294() == "warzone_pandemic_quad")
		{
			var_ea0ef21e = (isdefined(attacker) ? attacker clientfield::get_to_player("infected") : 0);
			var_507f7385 = (isdefined(victim) ? victim clientfield::get_to_player("infected") : 0);
			if(isdefined(var_ea0ef21e) && var_ea0ef21e)
			{
				var_ced14f4b = level.var_db720da1.var_7751a92c;
			}
			else if(isdefined(var_507f7385) && var_507f7385)
			{
				var_ced14f4b = level.var_db720da1.var_cbafe055;
			}
			else
			{
				var_ced14f4b = level.var_db720da1.var_56dcbb49;
			}
		}
		attacker function_ffda8476("kill", #"killxp", var_ced14f4b);
		attacker stats::function_b7f80d87(#"kills", 1);
		if(isdefined(attacker.pers[#"timesrevived"]) && attacker.pers[#"timesrevived"] > 0)
		{
			attacker stats::function_d40764f3(#"hash_602e8101bd834f5d", 1);
		}
		var_2fba6abe = attacker.var_37ef8626;
		currenttime = gettime();
		if(isdefined(var_2fba6abe) && currenttime - var_2fba6abe <= 60000)
		{
			attacker stats::function_d40764f3(#"hash_199467721898923a", 1);
			attacker callback::callback(#"hash_22c795c5dddbfc97");
		}
		if(var_c5948a69.sweapon === getweapon(#"bare_hands"))
		{
			attacker stats::function_d40764f3(#"hash_58751d5a37b0dbff", 1);
		}
		if(isdefined(var_c5948a69.var_6314a3a3) && var_c5948a69.var_6314a3a3)
		{
			attacker stats::function_d40764f3(#"hash_474d72467033e2c8", 1);
		}
		if(attacker isplayerunderwater())
		{
			attacker stats::function_d40764f3(#"hash_6f878e8edc2cfac6", 1);
		}
		if(isdefined(victim))
		{
			if(isdefined(victim.var_e53a63ce))
			{
				if(isdefined(victim.var_e53a63ce[attacker.team]) && victim.var_e53a63ce[attacker.team].size > 0)
				{
					attacker.avenger = 1;
				}
			}
			if(isdefined(victim.team))
			{
				maxteamplayers = (isdefined(getgametypesetting(#"maxteamplayers")) ? getgametypesetting(#"maxteamplayers") : 1);
				if(!isdefined(attacker.var_e53a63ce))
				{
					attacker.var_e53a63ce = [];
				}
				if(!isdefined(attacker.var_e53a63ce[victim.team]))
				{
					attacker.var_e53a63ce[victim.team] = [];
				}
				else if(!isarray(attacker.var_e53a63ce[victim.team]))
				{
					attacker.var_e53a63ce[victim.team] = array(attacker.var_e53a63ce[victim.team]);
				}
				if(!isinarray(attacker.var_e53a63ce[victim.team], victim))
				{
					attacker.var_e53a63ce[victim.team][attacker.var_e53a63ce[victim.team].size] = victim;
				}
				if(isdefined(attacker.var_e53a63ce[victim.team]))
				{
					switch(attacker.var_e53a63ce[victim.team].size)
					{
						case 2:
						{
							attacker stats::function_d40764f3(#"hash_46971a941d93cbb4", 1);
							if(maxteamplayers == 2)
							{
								scoreevents::processscoreevent(#"hash_36b13ed6e99e6f06", attacker, undefined, var_c5948a69.sweapon);
							}
							break;
						}
						case 3:
						{
							attacker stats::function_d40764f3(#"hash_1b3182f99881069d", 1);
							break;
						}
						case 4:
						{
							attacker stats::function_d40764f3(#"hash_736fa2bcc0b0bf62", 1);
							attacker stats::function_d40764f3(#"hash_6304d404ce4cc029", 1);
							scoreevents::processscoreevent(#"hash_6f41f79a13199c79", attacker, undefined, var_c5948a69.sweapon);
							break;
						}
						default:
						{
							break;
						}
					}
				}
			}
			if(isdefined(attacker.var_22002c3b))
			{
				if(isinarray(attacker.var_22002c3b, victim))
				{
					attacker stats::function_d40764f3(#"hash_617cbe12c3de6e67", 1);
				}
			}
			if(victim isplayerunderwater())
			{
				attacker stats::function_d40764f3(#"hash_53cbb48f98c0c661", 1);
			}
			if(isdefined(attacker.var_9854aa3a) && isinarray(attacker.var_9854aa3a, victim))
			{
				attacker stats::function_d40764f3(#"hash_235022d04689f60d", 1);
			}
			else
			{
				attacker stats::function_d40764f3(#"hash_465b947cd52b4073", 1);
			}
			if(isdefined(attacker.var_91ddc6c5))
			{
				if(isinarray(attacker.var_91ddc6c5, victim))
				{
					attacker stats::function_d40764f3(#"hash_134e5aebf69e00ec", 1);
				}
			}
			vehicle = victim.var_156bf46e;
			if(isdefined(vehicle) && isvehicle(vehicle))
			{
				var_b01d9212 = isairborne(vehicle);
				var_7c6311c4 = vehicle.vehicleclass === "boat";
				var_f03db647 = !var_b01d9212 && !var_7c6311c4;
				if(var_f03db647)
				{
					attacker stats::function_d40764f3(#"hash_16e2977279643be2", 1);
				}
				if(var_b01d9212)
				{
					attacker stats::function_d40764f3(#"hash_111a62b6ea876e71", 1);
				}
				if(var_7c6311c4)
				{
					attacker stats::function_d40764f3(#"hash_7a4e863a4d6713de", 1);
				}
			}
		}
		if(isdefined(var_c5948a69.var_adb68654) && var_c5948a69.var_adb68654)
		{
			attacker stats::function_d40764f3(#"hash_5e4a783a0ecd18a4", 1);
		}
		if(isdefined(var_c5948a69.var_69427d4d) && var_c5948a69.var_69427d4d)
		{
			attacker stats::function_d40764f3(#"hash_5b470a9caffc584a", 1);
		}
		weapon = var_c5948a69.sweapon;
		if(isdefined(weapon) && weapon != level.weaponnone && isdefined(var_c5948a69.attackerorigin) && isdefined(var_c5948a69.victimorigin) && (isdefined(weapon.isbulletweapon) && weapon.isbulletweapon))
		{
			weaponclass = util::getweaponclass(weapon);
			dist_to_target = distance(var_c5948a69.attackerorigin, var_c5948a69.victimorigin);
			if(dist_to_target >= 13779 && weaponclass == #"weapon_sniper")
			{
				attacker stats::function_d40764f3(#"hash_37bdf169185b564d", 1);
			}
			var_5afc3871 = attacker function_65776b07();
			if(isdefined(var_5afc3871) && isdefined(var_5afc3871[#"talent_deadsilence"]) && weaponhasattachment(weapon, "suppressed"))
			{
				attacker stats::function_dad108fa(#"hash_41f134c3e727d877", 1);
				attacker callback::callback(#"hash_453c77a41df1963c");
			}
			height = var_c5948a69.attackerorigin[2] - var_c5948a69.victimorigin[2];
			if(height >= 240)
			{
				attacker stats::function_dad108fa(#"hash_35020c395a89befb", 1);
				attacker callback::callback(#"hash_7a9bdd3ee0ae95af");
			}
			if(!isdefined(attacker.pers[#"hash_3641ea33357552c6"]) || dist_to_target > attacker.pers[#"hash_3641ea33357552c6"])
			{
				attacker.pers[#"hash_3641ea33357552c6"] = dist_to_target;
				var_c5078529 = dist_to_target * 0.0254;
				attacker.var_c5078529 = int(floor(var_c5078529 + 0.5));
				attacker stats::function_62b271d8(#"hash_7ba73b8bc0fa3932", int(dist_to_target));
				attacker stats::function_7a850245(#"hash_3641ea33357552c6", int(attacker.pers[#"hash_3641ea33357552c6"]));
			}
			var_c2d07ee0 = attacker stats::function_ed81f25e(#"hash_7ba73b8bc0fa3932");
			if(isdefined(var_c2d07ee0))
			{
				if(dist_to_target > var_c2d07ee0)
				{
					attacker stats::function_baa25a23(#"hash_7ba73b8bc0fa3932", int(dist_to_target));
				}
			}
		}
	}
}

/*
	Name: function_c7aa9338
	Namespace: namespace_d3564fd8
	Checksum: 0x83692CB9
	Offset: 0x4660
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_c7aa9338(array)
{
	foreach(ent in array)
	{
		if(util::function_fbce7263(ent.team, self.team))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_8920ad6e
	Namespace: namespace_d3564fd8
	Checksum: 0x56BBEA42
	Offset: 0x4708
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function function_8920ad6e(params)
{
	if(!gamestate::is_state("playing"))
	{
		return;
	}
	if(isplayer(params.eattacker))
	{
		params.eattacker stats::function_d40764f3(#"hash_7c3ae9253d32bc70", 1);
	}
	if(isdefined(params.occupants))
	{
		if(params.occupants.size > 0 && self function_c7aa9338(params.occupants))
		{
			if(isplayer(params.eattacker))
			{
				vehicle = params.eattacker getvehicleoccupied();
				if(isdefined(vehicle) && isvehicle(vehicle))
				{
					seat = vehicle getoccupantseat(params.eattacker);
					if(isdefined(seat))
					{
						if(seat === 0)
						{
							params.eattacker stats::function_d40764f3(#"hash_3272da96f1ec5819", 1);
						}
					}
				}
				params.eattacker stats::function_d40764f3(#"hash_490f26d6a519dca1", 1);
			}
		}
	}
}

/*
	Name: function_106be0dc
	Namespace: namespace_d3564fd8
	Checksum: 0xF11FBDF1
	Offset: 0x48C8
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_106be0dc(params)
{
	if(!gamestate::is_state("playing") || !isdefined(params.item))
	{
		return;
	}
	item = params.item;
	if(isplayer(self))
	{
		self.pers[#"participation"]++;
		if(!isdefined(self.var_4ceff2bf))
		{
			self.var_4ceff2bf = [];
		}
		if(!isdefined(self.var_4ceff2bf[item.id]))
		{
			self.var_4ceff2bf[item.id] = 1;
			self stats::function_d40764f3(#"hash_1949395de6885988", 1);
			self namespace_78a95918::function_cdc4c709();
			if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"armor")
			{
				self stats::function_d40764f3(#"hash_4fe7f855e15bfe3d", 1);
			}
			if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"backpack")
			{
				self stats::function_d40764f3(#"hash_6d4bd5340be109a5", 1);
			}
		}
	}
}

/*
	Name: function_393ec79e
	Namespace: namespace_d3564fd8
	Checksum: 0xEB56F48D
	Offset: 0x4A98
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function function_393ec79e(params)
{
	if(!gamestate::is_state("playing") || !isdefined(params.item))
	{
		return;
	}
	item = params.item;
	if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"health")
	{
		self stats::function_d40764f3(#"hash_31e1282548e2f0aa", 1);
		if(isdefined(self.outsidedeathcircle) && self.outsidedeathcircle)
		{
			self stats::function_d40764f3(#"hash_154d42f200303577", 1);
			self match_record::function_34800eec(#"hash_154d42f200303577", 1);
		}
	}
}

/*
	Name: function_6c478b00
	Namespace: namespace_d3564fd8
	Checksum: 0xCFEC798F
	Offset: 0x4BC0
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_6c478b00(params)
{
	if(!gamestate::is_state("playing") || !isdefined(params.activator))
	{
		return;
	}
	activator = params.activator;
	if(isplayer(activator))
	{
		if(self === getdynent(#"dock_yard_stash_2"))
		{
			activator stats::function_d40764f3(#"hash_62a630870029268d", 1);
		}
	}
}

/*
	Name: function_4776caf4
	Namespace: namespace_d3564fd8
	Checksum: 0x44BD2C0
	Offset: 0x4C88
	Size: 0xE4
	Parameters: 1
	Flags: Private, Event
*/
private event function_4776caf4(eventstruct)
{
	if(level.inprematchperiod)
	{
		return;
	}
	if(function_f99d2668() && isplayer(self) && isalive(self) && isdefined(eventstruct) && isdefined(eventstruct.weapon))
	{
		if(eventstruct.weapon.name === #"hash_7cd9fb78e5309f96")
		{
			if(isdefined(eventstruct.projectile))
			{
				ball = eventstruct.projectile;
				ball thread function_16de96c7(self);
			}
		}
	}
}

/*
	Name: function_16de96c7
	Namespace: namespace_d3564fd8
	Checksum: 0xFD7E0A8D
	Offset: 0x4D78
	Size: 0x270
	Parameters: 1
	Flags: Linked
*/
function function_16de96c7(player)
{
	if(!isdefined(player) || !isdefined(self))
	{
		return;
	}
	level endon(#"game_ended");
	self endon(#"stationary", #"death");
	player endon(#"disconnect", #"death");
	var_299b8419 = getentarray("basketball_hoop", "targetname");
	if(!isdefined(var_299b8419))
	{
		return;
	}
	var_69a93dcf = 0;
	ball_velocity = self getvelocity();
	if(!isdefined(ball_velocity))
	{
		return;
	}
	var_ace707d = 0;
	while(!var_69a93dcf && !var_ace707d)
	{
		ball_velocity = self getvelocity();
		if(ball_velocity[2] < 0)
		{
			var_b4331e2d = 0;
			foreach(basket in var_299b8419)
			{
				if(self.origin[2] < basket.origin[2])
				{
					var_b4331e2d++;
				}
				if(self istouching(basket))
				{
					var_69a93dcf = 1;
					break;
				}
			}
			if(var_b4331e2d === var_299b8419.size)
			{
				var_ace707d = 1;
				break;
			}
			if(var_69a93dcf)
			{
				break;
			}
		}
		waitframe(1);
	}
	if(var_69a93dcf)
	{
		if(isplayer(player))
		{
			player stats::function_d40764f3(#"hash_2b0f45ea73dd16b0", 1);
		}
	}
}

/*
	Name: function_98a0917d
	Namespace: namespace_d3564fd8
	Checksum: 0x93268A2
	Offset: 0x4FF0
	Size: 0x32E
	Parameters: 1
	Flags: Linked
*/
function function_98a0917d(params)
{
	level.var_98df02a8 = gettime();
	foreach(team, _ in level.teams)
	{
		players = getplayers(team);
		foreach(player in players)
		{
			if(isbot(player))
			{
				continue;
			}
			player function_cfc02934();
			player stats::set_stat(#"afteractionreportstats", #"hash_57b65eb93c6dfe20", players.size);
			for(i = 0; i < players.size; i++)
			{
				teammate = players[i];
				player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"name", teammate.name);
				player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"xuid", teammate getxuid(1));
				if(isdefined(teammate.pers) && isdefined(teammate.pers[#"rank"]))
				{
					player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"rank", teammate.pers[#"rank"]);
					player stats::set_stat(#"afteractionreportstats", #"teammates", i, #"plevel", teammate.pers[#"plevel"]);
				}
			}
		}
	}
}

/*
	Name: function_14dae612
	Namespace: namespace_d3564fd8
	Checksum: 0x7C339B0F
	Offset: 0x5328
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_14dae612()
{
	players = getplayers();
	foreach(player in players)
	{
		player function_2c8aac6();
	}
}

/*
	Name: on_challenge_complete
	Namespace: namespace_d3564fd8
	Checksum: 0xDD36CF59
	Offset: 0x53C0
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function on_challenge_complete(params)
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	if(!isplayer(player) || !isdefined(player.pers))
	{
		return;
	}
	if(isdefined(params) && isdefined(params.reward))
	{
		player.pers[#"hash_4e1bb8dada2d90f5"] = player.pers[#"hash_4e1bb8dada2d90f5"] + params.reward;
	}
	player.pers[#"hash_6344af0b142ed0b6"] = 1;
	if(!isdefined(player.pers[#"participation"]))
	{
		player.pers[#"participation"] = 0;
	}
	player.pers[#"participation"]++;
	if(isdefined(params) && isdefined(params.reward))
	{
		xpscale = player getxpscale();
		player stats::function_dad108fa(#"challengexp", int(params.reward * xpscale));
	}
}

/*
	Name: function_ed93a653
	Namespace: namespace_d3564fd8
	Checksum: 0xEBE27BDA
	Offset: 0x55A8
	Size: 0x7A4
	Parameters: 1
	Flags: Linked
*/
function function_ed93a653(params)
{
	if(isplayer(self))
	{
		waitframe(1);
		player = self;
		var_bff5f1d6 = player stats::get_stat(#"characters", #"hash_44599132bf7320e8", #"unlocked");
		var_b88d2887 = player stats::get_stat(#"characters", #"hash_72350169be9133ae", #"unlocked");
		var_4a9b8b0b = player stats::get_stat(#"characters", #"hash_3f01badbd66b2962", #"unlocked");
		var_7052e449 = player stats::get_stat(#"characters", #"hash_77118b5dbb73e0b6", #"unlocked");
		if(var_bff5f1d6 && var_b88d2887 && var_4a9b8b0b && var_7052e449)
		{
			player giveachievement("wz_blackout_historian");
		}
		var_871f238c = player stats::get_stat(#"characters", #"hash_7f410b145dce17bd", #"unlocked");
		var_aa7878e8 = player stats::get_stat(#"characters", #"hash_63b894fa4d634238", #"unlocked");
		var_4e36df97 = player stats::get_stat(#"characters", #"hash_8596bc069593313", #"unlocked");
		var_a71f1b0f = player stats::get_stat(#"characters", #"hash_17c02481305f0e24", #"unlocked");
		var_199c1316 = player stats::get_stat(#"characters", #"hash_4b77f84c47802222", #"unlocked");
		var_6851d31e = player stats::get_stat(#"characters", #"hash_62361c68e083d401", #"unlocked");
		var_f67cceb4 = player stats::get_stat(#"characters", #"hash_69bbe1ec48f79df5", #"unlocked");
		var_7fec1dca = player stats::get_stat(#"characters", #"hash_7a9842f6bec0e568", #"unlocked");
		var_ccc5605d = player stats::get_stat(#"characters", #"hash_6999516e5e35a515", #"unlocked");
		var_620230a2 = player stats::get_stat(#"characters", #"hash_78c357c8a5680d67", #"unlocked");
		if(var_871f238c && var_aa7878e8 && var_4e36df97 && var_a71f1b0f && var_199c1316 && var_6851d31e && var_f67cceb4 && var_7fec1dca && var_ccc5605d && var_620230a2)
		{
			player giveachievement("wz_specialist_super_fan");
		}
		var_bae2998 = player stats::get_stat(#"characters", #"hash_4815f130a1c1d840", #"unlocked");
		var_db2f35af = player stats::get_stat(#"characters", #"hash_6f105a897d64112", #"unlocked");
		var_c7bf8a47 = player stats::get_stat(#"characters", #"hash_7fc15da2c5864d3c", #"unlocked");
		var_c0c6b37a = player stats::get_stat(#"characters", #"hash_4f0c567012b33fd9", #"unlocked");
		var_7434f372 = player stats::get_stat(#"characters", #"hash_23d5f8566508f9f5", #"unlocked");
		var_98f0457e = player stats::get_stat(#"characters", #"hash_36157750ed7c6584", #"unlocked");
		var_a5b8977e = player stats::get_stat(#"characters", #"hash_1d718be46a94371f", #"unlocked");
		var_35efd1cf = player stats::get_stat(#"characters", #"hash_66b69b90a30bcc88", #"unlocked");
		if(var_bae2998 && var_db2f35af && var_c7bf8a47 && var_c0c6b37a && var_7434f372 && var_98f0457e && var_a5b8977e && var_35efd1cf)
		{
			player giveachievement("wz_zombie_fanatic");
		}
	}
}

/*
	Name: function_10a4dd0a
	Namespace: namespace_d3564fd8
	Checksum: 0x97B5FF8B
	Offset: 0x5D58
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_10a4dd0a(params)
{
	if(!gamestate::is_state("playing") || !isdefined(params.item))
	{
		return;
	}
	item = params.item;
	count = params.count;
	if(isplayer(self))
	{
		if(isdefined(item.var_a6762160) && item.var_a6762160.itemtype === #"resource" && namespace_ad5a0cd6::function_41f06d9d(item.var_a6762160) && count > 0)
		{
			self stats::function_dad108fa(#"hash_7bb5510daa652f5e", count);
			self stats::function_b7f80d87("paint_cans_collected", count);
		}
	}
}

/*
	Name: function_209450ae
	Namespace: namespace_d3564fd8
	Checksum: 0xBC6378D5
	Offset: 0x5E98
	Size: 0x204
	Parameters: 1
	Flags: Private, Event
*/
private event function_209450ae(eventstruct)
{
	if(level.inprematchperiod)
	{
		return;
	}
	dynent = eventstruct.ent;
	if(dynent.targetname !== #"firing_range_target_challenge")
	{
		return;
	}
	attacker = eventstruct.attacker;
	weapon = eventstruct.weapon;
	position = eventstruct.position;
	direction = eventstruct.dir;
	if(!isplayer(attacker) || !isdefined(weapon) || !isdefined(position) || !isdefined(direction))
	{
		return;
	}
	dist = distance(attacker.origin, dynent.origin);
	if(dist < 3550)
	{
		return;
	}
	targetangles = dynent.angles + vectorscale((0, 1, 0), 90);
	var_2bbc9717 = anglestoforward(targetangles);
	if(vectordot(var_2bbc9717, direction) >= 0)
	{
		return;
	}
	var_f748425e = dynent.origin + vectorscale((0, 0, 1), 45);
	if(distance2dsquared(var_f748425e, position) > 5 * 5)
	{
		return;
	}
	attacker stats::function_d40764f3(#"hash_6aff274705883e1b", 1);
}

/*
	Name: function_f6dc1aa9
	Namespace: namespace_d3564fd8
	Checksum: 0xEBC4AC4B
	Offset: 0x60A8
	Size: 0x5E
	Parameters: 0
	Flags: None
*/
function function_f6dc1aa9()
{
	/#
		while(true)
		{
			var_f748425e = self.origin + vectorscale((0, 0, 1), 45);
			sphere(var_f748425e, 5, (1, 1, 0));
			waitframe(1);
		}
	#/
}

