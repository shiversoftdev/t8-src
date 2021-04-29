// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace contracts;

/*
	Name: function_89f2df9
	Namespace: contracts
	Checksum: 0x70A48F56
	Offset: 0x98
	Size: 0x2C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_411235ee3f5d491c", undefined, undefined, undefined);
}

/*
	Name: init_player_contract_events
	Namespace: contracts
	Checksum: 0xB77BF8AF
	Offset: 0xD0
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function init_player_contract_events()
{
	if(!isdefined(level.player_contract_events))
	{
		level.player_contract_events = [];
	}
	if(!isdefined(level.var_90031a39))
	{
		level.var_90031a39 = [];
	}
}

/*
	Name: register_player_contract_event
	Namespace: contracts
	Checksum: 0xEC03448B
	Offset: 0x118
	Size: 0x106
	Parameters: 3
	Flags: None
*/
function register_player_contract_event(event_name, event_func, max_param_count = 0)
{
	if(!isdefined(level.player_contract_events[event_name]))
	{
		level.player_contract_events[event_name] = spawnstruct();
		level.player_contract_events[event_name].param_count = max_param_count;
		level.player_contract_events[event_name].events = [];
	}
	/#
		assert(max_param_count == level.player_contract_events[event_name].param_count);
	#/
	level.player_contract_events[event_name].events[level.player_contract_events[event_name].events.size] = event_func;
}

/*
	Name: player_contract_event
	Namespace: contracts
	Checksum: 0xD85C9C3E
	Offset: 0x228
	Size: 0x32A
	Parameters: 4
	Flags: None
*/
function player_contract_event(event_name, param1 = undefined, param2 = undefined, param3 = undefined)
{
	if(!isdefined(level.player_contract_events[event_name]))
	{
		return;
	}
	param_count = (isdefined(level.player_contract_events[event_name].param_count) ? level.player_contract_events[event_name].param_count : 0);
	switch(param_count)
	{
		case 0:
		default:
		{
			foreach(event_func in level.player_contract_events[event_name].events)
			{
				if(isdefined(event_func))
				{
					self [[event_func]]();
				}
			}
			break;
		}
		case 1:
		{
			foreach(event_func in level.player_contract_events[event_name].events)
			{
				if(isdefined(event_func))
				{
					self [[event_func]](param1);
				}
			}
			break;
		}
		case 2:
		{
			foreach(event_func in level.player_contract_events[event_name].events)
			{
				if(isdefined(event_func))
				{
					self [[event_func]](param1, param2);
				}
			}
			break;
		}
		case 3:
		{
			foreach(event_func in level.player_contract_events[event_name].events)
			{
				if(isdefined(event_func))
				{
					self [[event_func]](param1, param2, param3);
				}
			}
			break;
		}
	}
}

/*
	Name: get_contract_stat
	Namespace: contracts
	Checksum: 0xB8A0FCF2
	Offset: 0x560
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function get_contract_stat(slot, stat_name)
{
	return self stats::get_stat(#"contracts", slot, stat_name);
}

/*
	Name: function_d17bcd3c
	Namespace: contracts
	Checksum: 0x7E52E851
	Offset: 0x5A8
	Size: 0x22A
	Parameters: 1
	Flags: Linked
*/
function function_d17bcd3c(slot)
{
	player = self;
	var_5ceb23d0 = spawnstruct();
	var_5ceb23d0.var_38280f2f = #"hash_6a1133003efe7380";
	var_5ceb23d0.var_59cb904f = 0;
	var_5ceb23d0.var_c3e2bb05 = 0;
	var_38280f2f = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"hash_55345949dcdaa243");
	if(!getdvarint(#"hash_d233413e805fbd0", 0))
	{
		var_38280f2f = hash(var_38280f2f);
	}
	if(var_38280f2f != #"")
	{
		var_5ceb23d0.var_38280f2f = var_38280f2f;
		var_5ceb23d0.target_value = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"target");
		var_5ceb23d0.var_59cb904f = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"progress");
		var_5ceb23d0.var_c3e2bb05 = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"hash_71e9be4174b5740e");
		var_5ceb23d0.xp = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"xp");
		level.var_90031a39[var_38280f2f] = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"contractid");
	}
	return var_5ceb23d0;
}

/*
	Name: function_de4ff5a
	Namespace: contracts
	Checksum: 0x9B7360C
	Offset: 0x7E0
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_de4ff5a(slot)
{
	player = self;
	var_38280f2f = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"hash_55345949dcdaa243");
	if(!getdvarint(#"hash_d233413e805fbd0", 0))
	{
		var_38280f2f = hash(var_38280f2f);
	}
	if(var_38280f2f != #"")
	{
		level.var_90031a39[var_38280f2f] = player stats::function_ff8f4f17(#"hash_35951a0a644a98fb", slot, #"contractid");
	}
}

/*
	Name: setup_player_contracts
	Namespace: contracts
	Checksum: 0x65CD4FAB
	Offset: 0x8E0
	Size: 0x25E
	Parameters: 2
	Flags: Linked
*/
function setup_player_contracts(max_contract_slots, var_1b3f5772)
{
	player = self;
	if(isdefined(player.pers[#"contracts"]))
	{
		for(slot = 0; slot < max_contract_slots; slot++)
		{
			player function_de4ff5a(slot);
		}
		return;
	}
	if(isbot(player))
	{
		return;
	}
	if(!isdefined(var_1b3f5772))
	{
		var_1b3f5772 = &function_d17bcd3c;
	}
	if(!isdefined(player.pers[#"contracts"]))
	{
		player.pers[#"contracts"] = [];
	}
	player.pers[#"hash_5651f00c6c1790a4"] = self stats::function_441050ca(#"time_played_total");
	for(slot = 0; slot < max_contract_slots; slot++)
	{
		var_5ceb23d0 = player [[var_1b3f5772]](slot);
		if(!isdefined(var_5ceb23d0))
		{
			continue;
		}
		if(!isstruct(var_5ceb23d0))
		{
			continue;
		}
		var_38280f2f = var_5ceb23d0.var_38280f2f;
		if(var_38280f2f == #"hash_6a1133003efe7380")
		{
			continue;
		}
		if(isdefined(level.var_c3e2bb05) && isdefined(var_5ceb23d0.var_c3e2bb05) && level.var_c3e2bb05 != var_5ceb23d0.var_c3e2bb05 && var_5ceb23d0.var_c3e2bb05 != 5)
		{
			continue;
		}
		var_5ceb23d0.var_38280f2f = undefined;
		var_5ceb23d0.var_c3e2bb05 = undefined;
		player.pers[#"contracts"][var_38280f2f] = var_5ceb23d0;
	}
}

/*
	Name: is_contract_active
	Namespace: contracts
	Checksum: 0xFF40B7B2
	Offset: 0xB48
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function is_contract_active(var_38280f2f)
{
	if(!isdefined(var_38280f2f))
	{
		return 0;
	}
	if(!isplayer(self))
	{
		return 0;
	}
	if(!isdefined(self.pers[#"contracts"]))
	{
		return 0;
	}
	if(!isdefined(self.pers[#"contracts"][var_38280f2f]))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_a54e2068
	Namespace: contracts
	Checksum: 0xD8C90982
	Offset: 0xBD8
	Size: 0x58
	Parameters: 2
	Flags: Linked
*/
function function_a54e2068(var_38280f2f, delta = 1)
{
	if(self is_contract_active(var_38280f2f))
	{
		self [[level.var_79a93566]](var_38280f2f, delta);
	}
}

/*
	Name: function_5e1c4d33
	Namespace: contracts
	Checksum: 0xEFBFD675
	Offset: 0xC38
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function function_5e1c4d33(var_5ceb23d0)
{
	/#
		player = self;
		if(isbot(player))
		{
			return;
		}
		if(!isdefined(player.pers[#"contracts"]))
		{
			player.pers[#"contracts"] = [];
		}
		if(!isstruct(var_5ceb23d0))
		{
			return;
		}
		var_38280f2f = var_5ceb23d0.var_38280f2f;
		if(var_38280f2f == #"hash_6a1133003efe7380")
		{
			player.pers[#"contracts"][var_38280f2f] = undefined;
			return;
		}
		var_5ceb23d0.var_38280f2f = undefined;
		player.pers[#"contracts"][var_38280f2f] = var_5ceb23d0;
	#/
}

/*
	Name: function_e07e542b
	Namespace: contracts
	Checksum: 0x307F32D5
	Offset: 0xD50
	Size: 0xEC
	Parameters: 2
	Flags: None
*/
function function_e07e542b(var_1d89ece6, var_300afbc8)
{
	/#
		level thread watch_contract_debug(var_300afbc8);
		function_a781ee84(var_1d89ece6);
		util::function_3f749abc(var_1d89ece6 + "", "");
		util::function_3f749abc(var_1d89ece6 + "", "");
		util::function_3f749abc(var_1d89ece6 + "", "");
		util::function_3f749abc(var_1d89ece6 + "", "");
	#/
}

/*
	Name: function_a781ee84
	Namespace: contracts
	Checksum: 0x9DCD1575
	Offset: 0xE48
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function function_a781ee84(var_1d89ece6)
{
	/#
		var_78a6fb52 = var_1d89ece6 + "";
		var_c8d599b5 = "";
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 2);
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 5);
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 10);
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 100);
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 1000);
		util::function_3f749abc(var_78a6fb52 + "", var_c8d599b5 + 0);
	#/
}

/*
	Name: watch_contract_debug
	Namespace: contracts
	Checksum: 0xC8C4E1B3
	Offset: 0xF80
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function watch_contract_debug(var_300afbc8)
{
	/#
		level notify(#"watch_contract_debug_singleton");
		level endon(#"watch_contract_debug_singleton", #"game_ended");
		while(true)
		{
			function_33bab9aa();
			if(isdefined(var_300afbc8))
			{
				[[var_300afbc8]]();
			}
			wait(0.5);
		}
	#/
}

/*
	Name: function_33bab9aa
	Namespace: contracts
	Checksum: 0x4ACB1DC1
	Offset: 0x1010
	Size: 0x554
	Parameters: 0
	Flags: None
*/
function function_33bab9aa()
{
	/#
		if(getdvarint(#"hash_7c0db43f4c0bff69", 0) > 0)
		{
			if(isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(!isdefined(player))
					{
						continue;
					}
					if(isbot(player))
					{
						continue;
					}
					if(isdefined(player.pers) && isdefined(player.pers[#"contracts"]))
					{
						player.pers[#"contracts"] = undefined;
					}
					iprintln("" + player.name);
				}
			}
			setdvar(#"hash_7c0db43f4c0bff69", 0);
		}
		if(getdvarint(#"hash_23bd356dbd92a9e2", 0) > 0)
		{
			if(isdefined(level.players))
			{
				foreach(player in level.players)
				{
					if(!isdefined(player))
					{
						continue;
					}
					if(isbot(player))
					{
						continue;
					}
					if(isdefined(player.pers) && isdefined(player.pers[#"contracts"]))
					{
						player function_78083139();
					}
					iprintln("" + player.name);
				}
			}
			setdvar(#"hash_23bd356dbd92a9e2", 0);
		}
		if(getdvarstring(#"hash_4e7103a8bd2b97f6", "") != "")
		{
			if(isdefined(level.players))
			{
				var_f029d0d7 = getdvarstring(#"hash_4e7103a8bd2b97f6", "");
				foreach(player in level.players)
				{
					if(!isdefined(player))
					{
						continue;
					}
					if(isbot(player))
					{
						continue;
					}
					var_61525c00 = spawnstruct();
					var_61525c00.var_38280f2f = hash(var_f029d0d7);
					var_61525c00.target_value = 8;
					var_61525c00.var_59cb904f = 0;
					player function_5e1c4d33(var_61525c00);
					iprintln("" + var_f029d0d7 + "" + player.name + "");
				}
			}
			setdvar(#"hash_4e7103a8bd2b97f6", "");
		}
		if(getdvarint(#"scr_contract_msg_front_end_only", 0) > 0)
		{
			iprintln("");
			setdvar(#"scr_contract_msg_front_end_only", 0);
		}
		if(getdvarint(#"scr_contract_msg_debug_on", 0) > 0)
		{
			iprintln("");
			setdvar(#"scr_contract_msg_debug_on", 0);
		}
	#/
}

/*
	Name: function_d589391f
	Namespace: contracts
	Checksum: 0x9B7A1123
	Offset: 0x1570
	Size: 0x330
	Parameters: 0
	Flags: None
*/
function function_d589391f()
{
	wait(1);
	if(!isdefined(level.var_43a0c4a2))
	{
		return;
	}
	if(!isdefined(level.var_959f44cf))
	{
		return;
	}
	if(!isdefined(level.var_a89923e8))
	{
		return;
	}
	if(!isdefined(level.var_107734a6))
	{
		return;
	}
	if(getdvarint(#"hash_3b8a673f8fcff50d", 0) > 0)
	{
		return;
	}
	if(!isdefined(level.var_e054dd5c))
	{
		level.var_e054dd5c = 0;
	}
	level endon(#"game_ended");
	while(players.size == 0 || gamestate::function_4c5eea28("pregame"))
	{
		wait(1);
		players = getplayers();
	}
	while(true)
	{
		wait(0.1);
		players = getplayers();
		if(players.size == 0)
		{
			continue;
		}
		level.var_e054dd5c++;
		if(level.var_e054dd5c >= players.size)
		{
			level.var_e054dd5c = 0;
		}
		player = players[level.var_e054dd5c];
		if(!isdefined(player))
		{
			continue;
		}
		if(player.var_8dd4afe6 === 1)
		{
			continue;
		}
		if(!isdefined(player.pers))
		{
			continue;
		}
		if(!isdefined(player.pers[#"contracts"]))
		{
			continue;
		}
		if(!isdefined(player.var_8dd4afe6))
		{
			var_8dd4afe6 = 1;
			var_eec87ecc = getarraykeys(player.pers[#"contracts"]);
			foreach(var_39dce575 in var_eec87ecc)
			{
				if([[level.var_43a0c4a2]](var_39dce575))
				{
					if([[level.var_107734a6]](var_39dce575))
					{
						var_8dd4afe6 = 0;
					}
					break;
				}
			}
			player.var_8dd4afe6 = var_8dd4afe6;
			if(player.var_8dd4afe6)
			{
				continue;
			}
		}
		var_1ef5a3ba = player [[level.var_959f44cf]]();
		player [[level.var_a89923e8]](var_1ef5a3ba);
	}
}

/*
	Name: function_d3fba20e
	Namespace: contracts
	Checksum: 0xCAD9CC20
	Offset: 0x18A8
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_d3fba20e()
{
	players = getplayers();
	foreach(player in players)
	{
		player function_78083139();
	}
}

/*
	Name: function_78083139
	Namespace: contracts
	Checksum: 0x54896836
	Offset: 0x1940
	Size: 0x5E6
	Parameters: 0
	Flags: Linked
*/
function function_78083139()
{
	player = self;
	if(!isplayer(player))
	{
		return;
	}
	if(isbot(player))
	{
		return;
	}
	if(!isdefined(player.pers))
	{
		return;
	}
	if(!isdefined(player.pers[#"contracts"]))
	{
		return;
	}
	foreach(var_38280f2f, var_5ceb23d0 in player.pers[#"contracts"])
	{
		if(isdefined(var_5ceb23d0.current_value))
		{
			delta = var_5ceb23d0.current_value - var_5ceb23d0.var_59cb904f;
		}
		else
		{
			delta = 0;
		}
		var_4b67585c = 0;
		var_2de8a050 = 0;
		if(!isdefined(var_5ceb23d0.var_1bd1ecbb))
		{
			var_5ceb23d0.var_1bd1ecbb = 0;
		}
		if(!isdefined(var_5ceb23d0.var_c7d05ecd))
		{
			var_5ceb23d0.var_c7d05ecd = 0;
		}
		if(isdefined(var_5ceb23d0.var_be5bf249))
		{
			var_4b67585c = var_5ceb23d0.var_be5bf249 - var_5ceb23d0.var_1bd1ecbb;
			var_2de8a050 = var_5ceb23d0.var_be5bf249 - var_5ceb23d0.var_c7d05ecd;
		}
		else if(sessionmodeiszombiesgame())
		{
			var_ad6e6421 = player.pers[#"time_played_total"];
			var_5463bb33 = var_ad6e6421;
		}
		else
		{
			var_ad6e6421 = undefined;
			if(isdefined(level.var_f202fa67) && [[level.var_f202fa67]](var_38280f2f))
			{
				if(isdefined(player.var_c619a827))
				{
					var_ad6e6421 = player.var_c619a827 - player.pers[#"hash_5651f00c6c1790a4"];
				}
			}
			else if(!isdefined(level.var_e3551fe4) || ![[level.var_e3551fe4]](var_38280f2f))
			{
				if(isdefined(player.var_56bd2c02))
				{
					var_ad6e6421 = player.var_56bd2c02 - player.pers[#"hash_5651f00c6c1790a4"];
				}
			}
			time_played_total = player stats::function_441050ca(#"time_played_total");
			var_9d12108c = 0;
			if(isdefined(player) && isdefined(player.team) && isdefined(player.timeplayed) && isdefined(player.timeplayed[player.team]))
			{
				var_9d12108c = player.timeplayed[player.team];
			}
			var_5463bb33 = time_played_total - player.pers[#"hash_5651f00c6c1790a4"] + var_9d12108c;
			if(!isdefined(var_ad6e6421))
			{
				var_ad6e6421 = var_5463bb33;
			}
		}
		var_4b67585c = var_ad6e6421 - var_5ceb23d0.var_1bd1ecbb;
		var_2de8a050 = var_5463bb33 - var_5ceb23d0.var_c7d05ecd;
		if(delta <= 0 && var_4b67585c <= 0 && var_2de8a050 <= 0)
		{
			continue;
		}
		if(var_4b67585c < 0)
		{
			var_4b67585c = 0;
		}
		if(var_2de8a050 < 0)
		{
			var_2de8a050 = 0;
		}
		var_9224acc = 0;
		if(isdefined(var_5ceb23d0.current_value))
		{
			if(var_5ceb23d0.current_value >= var_5ceb23d0.target_value)
			{
				var_9224acc = 1;
			}
		}
		/#
			if(getdvarint(#"scr_contract_debug", 0) > 0)
			{
				var_7b6acdb1 = (var_9224acc ? "" : "");
				iprintln("" + function_9e72a96(var_38280f2f) + "" + delta + "" + var_4b67585c + "" + var_2de8a050 + var_7b6acdb1);
			}
		#/
		flags = player function_507247e8(var_9224acc);
		function_d8c98325(var_38280f2f, delta, flags, var_4b67585c, var_2de8a050);
		if(isdefined(var_5ceb23d0.current_value))
		{
			var_5ceb23d0.var_59cb904f = var_5ceb23d0.current_value;
		}
		var_5ceb23d0.var_1bd1ecbb = var_5ceb23d0.var_1bd1ecbb + var_4b67585c;
		var_5ceb23d0.var_c7d05ecd = var_5ceb23d0.var_c7d05ecd + var_2de8a050;
	}
}

/*
	Name: function_d8c98325
	Namespace: contracts
	Checksum: 0xF5B74031
	Offset: 0x1F30
	Size: 0xBC
	Parameters: 5
	Flags: Linked
*/
function function_d8c98325(var_38280f2f, delta, flags, var_4b67585c, var_2de8a050)
{
	player = self;
	if(var_38280f2f != #"")
	{
		var_ae857992 = getdvarint(#"hash_60d812bef0f782fb", 4);
		player function_cce105c8(var_38280f2f, 1, delta, 2, var_ae857992, 3, flags, 4, var_4b67585c, 5, var_2de8a050);
	}
}

/*
	Name: function_507247e8
	Namespace: contracts
	Checksum: 0x31AFC7B5
	Offset: 0x1FF8
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function function_507247e8(var_9224acc)
{
	player = self;
	flags = 0;
	xpscale = player getxpscale();
	if(xpscale > 1)
	{
		flags = flags | 1;
	}
	lootxpscale = player function_c52bcf79();
	if(sessionmodeiszombiesgame())
	{
		if(max(lootxpscale, float(getdvarint(#"hash_1624faaee3c04f09", 1))) > 1)
		{
			flags = flags | 2;
		}
	}
	else if(lootxpscale > 1)
	{
		flags = flags | 2;
	}
	if(var_9224acc)
	{
		flags = flags | 8;
	}
	if(getdvarint(#"hash_21ab8e9a7fb70179", 0) != 0)
	{
		flags = flags | 16;
	}
	return flags;
}

