// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\util.gsc;

#namespace contracts;

/*
	Name: __init__system__
	Namespace: contracts
	Checksum: 0x130BDF16
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"cwl_contracts", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: contracts
	Checksum: 0xABF36288
	Offset: 0x108
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.challengescallbacks))
	{
		level.challengescallbacks = [];
	}
	init_player_contract_events();
	callback::on_finalize_initialization(&finalize_init);
}

/*
	Name: finalize_init
	Namespace: contracts
	Checksum: 0x28BA0D70
	Offset: 0x168
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function finalize_init()
{
	callback::on_connect(&on_player_connect);
	if(can_process_contracts())
	{
		challenges::registerchallengescallback("gameEnd", &function_a4c8ce2a);
		globallogic_score::registercontractwinevent(&contract_win);
		register_player_contract_event(#"score", &on_player_score, 2);
		register_player_contract_event(#"ekia", &function_71eb8a5a, 1);
		register_player_contract_event(#"objective_ekia", &function_660b0026);
		register_player_contract_event(#"damagedone", &function_6d90b18a, 1);
		level.var_79a93566 = &function_902ef0de;
		level.var_c3e2bb05 = 2;
		function_7364a587();
		/#
			thread devgui_setup();
		#/
	}
}

/*
	Name: function_7364a587
	Namespace: contracts
	Checksum: 0x2544B69
	Offset: 0x320
	Size: 0x36E
	Parameters: 0
	Flags: Linked
*/
function function_7364a587()
{
	level.var_9d6b3096 = [];
	level.var_9d6b3096[#"koth_cwl"] = spawnstruct();
	level.var_9d6b3096[#"control_cwl"] = spawnstruct();
	level.var_9d6b3096[#"sd_cwl"] = spawnstruct();
	level.var_9d6b3096[#"koth_cwl"].var_9dd75c18 = 3000;
	level.var_9d6b3096[#"control_cwl"].var_9dd75c18 = 2500;
	level.var_9d6b3096[#"sd_cwl"].var_9dd75c18 = 500;
	level.var_9d6b3096[#"koth_cwl"].var_9a5a8dcf = 4000;
	level.var_9d6b3096[#"control_cwl"].var_9a5a8dcf = 3000;
	level.var_9d6b3096[#"sd_cwl"].var_9a5a8dcf = 1000;
	level.var_9d6b3096[#"koth_cwl"].var_f703cb6c = 20;
	level.var_9d6b3096[#"control_cwl"].var_f703cb6c = 15;
	level.var_9d6b3096[#"sd_cwl"].var_f703cb6c = 3;
	level.var_9d6b3096[#"koth_cwl"].var_39027dc7 = 30;
	level.var_9d6b3096[#"control_cwl"].var_39027dc7 = 25;
	level.var_9d6b3096[#"sd_cwl"].var_39027dc7 = 7;
	level.var_9d6b3096[#"koth_cwl"].var_81bbb381 = 3500;
	level.var_9d6b3096[#"control_cwl"].var_81bbb381 = 2500;
	level.var_9d6b3096[#"sd_cwl"].var_81bbb381 = 500;
	level.var_9d6b3096[#"koth_cwl"].var_9037b57b = 15;
	level.var_9d6b3096[#"control_cwl"].var_9037b57b = 10;
	level.var_9d6b3096[#"sd_cwl"].var_9037b57b = 1;
}

/*
	Name: on_player_connect
	Namespace: contracts
	Checksum: 0x54FB4C62
	Offset: 0x698
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	if(can_process_contracts())
	{
		self setup_player_contracts(3, &function_58b2fea4);
	}
}

/*
	Name: can_process_contracts
	Namespace: contracts
	Checksum: 0x71EA6A92
	Offset: 0x6E0
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function can_process_contracts()
{
	if(getdvarint(#"contracts_enabled", 0) == 0)
	{
		return 0;
	}
	if(getdvarint(#"contracts_enabled_cwl", 1) == 0)
	{
		return 0;
	}
	if(!sessionmodeismultiplayergame())
	{
		return 0;
	}
	if(level.var_aa5e6547 !== 1)
	{
		return 0;
	}
	if(level.arenamatch !== 1)
	{
		return 0;
	}
	return challenges::canprocesschallenges();
}

/*
	Name: on_player_score
	Namespace: contracts
	Checksum: 0xCFD2E476
	Offset: 0x7A8
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function on_player_score(new_score, delta_score)
{
	gametype = level.gametype;
	if(!isdefined(level.var_9d6b3096[gametype]))
	{
		return;
	}
	player = self;
	old_score = new_score - delta_score;
	target_value = level.var_9d6b3096[gametype].var_9dd75c18;
	if(old_score < target_value)
	{
		if(new_score >= target_value)
		{
			player function_9defb976(#"hash_78214e78d4159f84");
		}
	}
	else
	{
		var_2c74fba6 = level.var_9d6b3096[gametype].var_9a5a8dcf;
		if(old_score < var_2c74fba6 && new_score >= var_2c74fba6)
		{
			player function_9defb976(#"hash_1075c38287814aa0");
		}
	}
}

/*
	Name: function_71eb8a5a
	Namespace: contracts
	Checksum: 0x791C7497
	Offset: 0x8E0
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_71eb8a5a(weapon)
{
	gametype = level.gametype;
	if(!isdefined(level.var_9d6b3096[gametype]))
	{
		return;
	}
	player = self;
	var_350027d1 = player.pers[#"ekia"];
	if(var_350027d1 == level.var_9d6b3096[gametype].var_f703cb6c)
	{
		player function_9defb976(#"hash_1d1b3fe36f24b6ac");
	}
	else if(var_350027d1 == level.var_9d6b3096[gametype].var_39027dc7)
	{
		player function_9defb976(#"hash_63e1c91ddca36b58");
	}
}

/*
	Name: function_660b0026
	Namespace: contracts
	Checksum: 0x9F01311
	Offset: 0x9E0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_660b0026()
{
	gametype = level.gametype;
	if(!isdefined(level.var_9d6b3096[gametype]))
	{
		return;
	}
	player = self;
	objective_ekia = player.pers[#"objectiveekia"] + 1;
	if(objective_ekia == level.var_9d6b3096[gametype].var_9037b57b)
	{
		player function_9defb976(#"hash_518ce6f8a5567a08");
	}
}

/*
	Name: function_6d90b18a
	Namespace: contracts
	Checksum: 0x2AD03354
	Offset: 0xA98
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_6d90b18a(damagedone)
{
	player = self;
	if(player is_contract_active(#"hash_783240d7e11018c9"))
	{
		gametype = level.gametype;
		if(!isdefined(level.var_9d6b3096[gametype]))
		{
			return;
		}
		var_2e0944a3 = self.pers[#"damagedone"];
		var_5f607191 = var_2e0944a3 - damagedone;
		target_value = level.var_9d6b3096[gametype].var_81bbb381;
		if(var_5f607191 < target_value && var_2e0944a3 >= target_value)
		{
			player function_9defb976(#"hash_783240d7e11018c9");
		}
	}
}

/*
	Name: function_9defb976
	Namespace: contracts
	Checksum: 0xEA5A82D3
	Offset: 0xBA0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_9defb976(var_38280f2f, delta = 1)
{
	if(self is_contract_active(var_38280f2f))
	{
		self function_902ef0de(var_38280f2f, delta);
	}
}

/*
	Name: function_902ef0de
	Namespace: contracts
	Checksum: 0x71136050
	Offset: 0xC08
	Size: 0x3C4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_902ef0de(var_38280f2f, delta)
{
	/#
		if(getdvarint(#"scr_contract_debug_multiplier", 0) > 0)
		{
			delta = delta * getdvarint(#"scr_contract_debug_multiplier", 1);
		}
	#/
	if(delta <= 0)
	{
		return;
	}
	target_value = self.pers[#"contracts"][var_38280f2f].target_value;
	old_progress = (isdefined(self.pers[#"contracts"][var_38280f2f].current_value) ? self.pers[#"contracts"][var_38280f2f].current_value : self.pers[#"contracts"][var_38280f2f].var_59cb904f);
	if(old_progress == target_value)
	{
		return;
	}
	new_progress = int(old_progress + delta);
	if(new_progress > target_value)
	{
		new_progress = target_value;
	}
	if(new_progress != old_progress)
	{
		self.pers[#"contracts"][var_38280f2f].current_value = new_progress;
		if(isdefined(level.contract_ids[var_38280f2f]))
		{
			self luinotifyevent(#"hash_4b04b1cb4b3498d0", 2, level.contract_ids[var_38280f2f], new_progress);
		}
	}
	if(old_progress < target_value && target_value <= new_progress)
	{
		var_9d12108c = (isdefined(self.timeplayed[self.team]) ? self.timeplayed[self.team] : 0);
		self.pers[#"contracts"][var_38280f2f].var_be5bf249 = (self stats::get_stat_global(#"time_played_total") - self.pers[#"hash_5651f00c6c1790a4"]) + var_9d12108c;
		if(isdefined(level.contract_ids[var_38280f2f]))
		{
			self luinotifyevent(#"hash_1739c4bd5baf83bc", 1, level.contract_ids[var_38280f2f]);
		}
	}
	/#
		if(getdvarint(#"scr_contract_debug", 0) > 0)
		{
			iprintln((((function_9e72a96(var_38280f2f) + "") + new_progress) + "") + target_value);
			if(old_progress < target_value && target_value <= new_progress)
			{
				iprintln(function_9e72a96(var_38280f2f) + "");
			}
		}
	#/
}

/*
	Name: function_58b2fea4
	Namespace: contracts
	Checksum: 0x6F169B37
	Offset: 0xFD8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_58b2fea4(slot)
{
	return function_d17bcd3c(slot);
}

/*
	Name: function_a4c8ce2a
	Namespace: contracts
	Checksum: 0x93CC4780
	Offset: 0x1008
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function function_a4c8ce2a(data)
{
	if(!isdefined(data))
	{
		return;
	}
	player = data.player;
	if(!isplayer(player))
	{
		return;
	}
	player function_9defb976(#"hash_5f67f3e8adbeb98a");
	team = player.team;
	if(isdefined(level.placement[team]) && player.score > 0)
	{
		var_414a209b = min(level.placement.size, 3);
		for(i = 0; i < var_414a209b; i++)
		{
			if(level.placement[team][i] == player)
			{
				player function_a54e2068(#"hash_355152b5a8de61ef");
				break;
			}
		}
	}
	var_67d27328 = player stats::get_stat(#"arenastats", 2, #"leagueplaystats", #"hash_36cd820c1ff6c16b");
	if(var_67d27328 > 0)
	{
		player function_a54e2068(#"hash_35e52e40ab6d1223", var_67d27328);
		player function_a54e2068(#"hash_421c3b5196a40f99", var_67d27328);
	}
	player function_78083139();
}

/*
	Name: contract_win
	Namespace: contracts
	Checksum: 0x4EDB9382
	Offset: 0x1208
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function contract_win(winner)
{
	winner function_9defb976(#"hash_d693aab50d25b96");
	winner function_9defb976(#"hash_2809e14b0f3b4c5e");
	var_15b1abd9 = winner stats::get_stat_global(#"hash_a06075423336d9c");
	if(var_15b1abd9 > 0)
	{
		if((var_15b1abd9 % 4) == 0)
		{
			winner function_9defb976(#"hash_40186850547832f7");
		}
		if((var_15b1abd9 % 2) == 0)
		{
			winner function_9defb976(#"hash_4a14b348f01ad76d");
		}
	}
}

/*
	Name: devgui_setup
	Namespace: contracts
	Checksum: 0xAE2DA88E
	Offset: 0x12F8
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function devgui_setup()
{
	/#
		devgui_base = "";
		wait(3);
		function_e07e542b(devgui_base, undefined);
		function_17a92a99(devgui_base);
		function_7f05e018(devgui_base);
		function_ef925b75(devgui_base);
		function_295a8005(devgui_base);
	#/
}

/*
	Name: function_17a92a99
	Namespace: contracts
	Checksum: 0xE8695F22
	Offset: 0x13A0
	Size: 0x1F4
	Parameters: 1
	Flags: None
*/
function function_17a92a99(var_1d89ece6)
{
	/#
		var_78a6fb52 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
	#/
}

/*
	Name: function_7f05e018
	Namespace: contracts
	Checksum: 0xF46B14F1
	Offset: 0x15A0
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function function_7f05e018(var_1d89ece6)
{
	/#
		var_78a6fb52 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
	#/
}

/*
	Name: function_ef925b75
	Namespace: contracts
	Checksum: 0x25CD7FEB
	Offset: 0x16D8
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function function_ef925b75(var_1d89ece6)
{
	/#
		var_78a6fb52 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
	#/
}

/*
	Name: function_295a8005
	Namespace: contracts
	Checksum: 0x42E9F9A5
	Offset: 0x1798
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function function_295a8005(var_1d89ece6)
{
	/#
		var_78a6fb52 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + "");
	#/
}

