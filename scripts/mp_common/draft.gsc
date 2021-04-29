// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f27a7b2232674db;
#using script_47fb62300ac0bd60;
#using script_788472602edbe3b9;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\serverfield_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace draft;

/*
	Name: function_89f2df9
	Namespace: draft
	Checksum: 0x7C21ECAC
	Offset: 0x240
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"draft", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: draft
	Checksum: 0x3F676D73
	Offset: 0x288
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "draft", 1, 3, "int");
	clientfield::register("clientuimodel", "PositionDraft.stage", 1, 4, "int");
	clientfield::register("clientuimodel", "PositionDraft.autoSelected", 1, 1, "int");
	clientfield::register("clientuimodel", "PositionDraft.cooldown", 1, 5, "int");
	clientfield::register("worlduimodel", "PositionDraft.timeRemaining", 1, 7, "int");
	clientfield::register("worlduimodel", "PositionDraft.waitingForPlayers", 1, 1, "int");
	serverfield::register("PositionDraft.uiLoaded", 1, 1, "int", &function_9f408cf7);
	level.var_5be52892 = 0;
	level.draftstage = 0;
	/#
		level.var_5fa54158 = "";
	#/
	/#
		level thread function_e8a5f9ba();
	#/
}

/*
	Name: function_6bea5139
	Namespace: draft
	Checksum: 0x6D9563AE
	Offset: 0x440
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function function_6bea5139()
{
	/#
		self notify("");
		self endon("");
		wait(5);
		level.var_5fa54158 = "";
	#/
}

/*
	Name: function_95c03d66
	Namespace: draft
	Checksum: 0x16AC83F1
	Offset: 0x488
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_95c03d66(message)
{
	/#
		if(message == level.var_5fa54158)
		{
			return;
		}
		level.var_5fa54158 = message;
		println(message);
		level thread function_6bea5139();
	#/
}

/*
	Name: function_947fe5c4
	Namespace: draft
	Checksum: 0x694C0D29
	Offset: 0x4F8
	Size: 0xF0
	Parameters: 1
	Flags: None
*/
function function_947fe5c4(character)
{
	/#
		if(character != "")
		{
			var_44dd7e5d = hash(character);
			playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
			for(i = 0; i < playerroletemplatecount; i++)
			{
				var_3c6fd4f7 = function_b14806c6(i, currentsessionmode());
				if(var_3c6fd4f7 == var_44dd7e5d)
				{
					self select_character(i, 1);
					return;
				}
			}
		}
	#/
}

/*
	Name: function_e8a5f9ba
	Namespace: draft
	Checksum: 0xAE47DD2
	Offset: 0x5F0
	Size: 0x132
	Parameters: 0
	Flags: None
*/
function function_e8a5f9ba()
{
	/#
		current = getdvarstring(#"character", "");
		if(current != "")
		{
			while(true)
			{
				autoselection = getdvarstring(#"character");
				if(autoselection != "" && autoselection != current)
				{
					foreach(player in level.players)
					{
						player function_947fe5c4(autoselection);
					}
				}
				wait(1);
			}
		}
	#/
}

/*
	Name: is_enabled
	Namespace: draft
	Checksum: 0xA7B2F5B4
	Offset: 0x730
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function is_enabled()
{
	autoselectcharacter = getdvarint(#"auto_select_character", -1);
	if(player_role::is_valid(autoselectcharacter))
	{
		return 0;
	}
	if(level.disableclassselection)
	{
		return 0;
	}
	if(isdefined(level.var_b3c4b7b7) && level.var_b3c4b7b7)
	{
		return 0;
	}
	if(util::function_8570168d())
	{
		return 0;
	}
	return getgametypesetting(#"draftenabled");
}

/*
	Name: is_draft_this_round
	Namespace: draft
	Checksum: 0x26FF0408
	Offset: 0x7F8
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function is_draft_this_round()
{
	if(!is_enabled())
	{
		return 0;
	}
	if(getgametypesetting(#"drafteveryround") == 1)
	{
		return 1;
	}
	if(util::isoneround())
	{
		return 1;
	}
	return util::isfirstround();
}

/*
	Name: function_2c7b2ff
	Namespace: draft
	Checksum: 0x3A40D0C0
	Offset: 0x878
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_2c7b2ff()
{
	player = self;
	return isdefined(player.var_7d68fce3) && player.var_7d68fce3 > 0;
}

/*
	Name: function_693430fa
	Namespace: draft
	Checksum: 0x39CBA811
	Offset: 0x8B8
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_693430fa()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player endon(#"disconnect", #"hash_7fa9c275efb510e2");
	cooldowntime = getgametypesetting(#"hash_2b88c6ac064e9c59");
	while(gettime() < var_e5e81b59)
	{
		timeleft = var_e5e81b59 - gettime() / 1000;
		player clientfield::set_player_uimodel("PositionDraft.cooldown", int(timeleft));
		player.var_7d68fce3 = timeleft;
		wait(1);
	}
	player.var_7d68fce3 = 0;
	player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

/*
	Name: function_2427a351
	Namespace: draft
	Checksum: 0x535FDCBC
	Offset: 0xA08
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_2427a351()
{
	player = self;
	/#
		assert(isplayer(player));
	#/
	player notify(#"hash_7fa9c275efb510e2");
	player.var_7d68fce3 = 0;
	player clientfield::set_player_uimodel("PositionDraft.cooldown", 0);
}

/*
	Name: function_904deeb2
	Namespace: draft
	Checksum: 0x1029A85C
	Offset: 0xA90
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function function_904deeb2()
{
	player = self;
	if(player function_2c7b2ff())
	{
		return 0;
	}
	if(level.draftstage == 0)
	{
		return 1;
	}
	if(level.draftstage == 3 && !player isready())
	{
		return 1;
	}
	return 0;
}

/*
	Name: can_select_character
	Namespace: draft
	Checksum: 0xB5132CD
	Offset: 0xB18
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function can_select_character(characterindex)
{
	if(!function_904deeb2())
	{
		return 0;
	}
	maxuniqueroles = getgametypesetting(#"maxuniquerolesperteam", characterindex);
	if(maxuniqueroles == 0)
	{
		return 0;
	}
	rolecount = 0;
	foreach(player in level.players)
	{
		if(player == self)
		{
			continue;
		}
		playercharacterindex = player player_role::get();
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == self.pers[#"team"] && playercharacterindex == characterindex)
		{
			rolecount++;
			if(rolecount >= maxuniqueroles)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: select_character
	Namespace: draft
	Checksum: 0x88C7C49D
	Offset: 0xCA8
	Size: 0x216
	Parameters: 3
	Flags: Linked
*/
function select_character(characterindex, forceselection, var_8a239568)
{
	if(!player_role::is_valid(characterindex))
	{
		return 0;
	}
	/#
		assert(player_role::is_valid(characterindex));
	#/
	if(!(isdefined(forceselection) && forceselection) && !can_select_character(characterindex))
	{
		return 0;
	}
	if(self player_role::set(characterindex))
	{
		if(level.draftstage == 0)
		{
			self thread function_693430fa();
			self close();
		}
		else if(isdefined(level.var_9205f2e8))
		{
			game_time = gettime();
			var_891e514a = {#hash_b53f57e1:var_8a239568, #hash_6fa2fd60:game_time - level.var_9205f2e8, #game_time:game_time, #character_index:characterindex, #xuid:self getxuid()};
			function_92d1707f(#"hash_3a95edd667fd3e7d", var_891e514a);
		}
		return 1;
	}
	if(!util::function_8570168d())
	{
		self player_role::clear();
		self util::clientnotify("PositionDraft_Reject");
	}
	return 0;
}

/*
	Name: function_ca33311e
	Namespace: draft
	Checksum: 0xCCDA568E
	Offset: 0xEC8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_ca33311e()
{
	level endon(#"game_ended", #"draft_complete");
	while(true)
	{
		foreach(player in level.players)
		{
			player resetinactivitytimer();
		}
		wait(5);
	}
}

/*
	Name: function_9f408cf7
	Namespace: draft
	Checksum: 0x90B3F499
	Offset: 0xF88
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_9f408cf7(oldval, newval)
{
	player = self;
	/#
		function_95c03d66("" + player.name + "");
	#/
	player function_4b8d2217(newval);
}

/*
	Name: function_3e46326b
	Namespace: draft
	Checksum: 0x9B069BE6
	Offset: 0x1000
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_3e46326b()
{
	player = self;
	player function_427981d0(1);
}

/*
	Name: draft_initialize
	Namespace: draft
	Checksum: 0xAC06948F
	Offset: 0x1038
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function draft_initialize()
{
	level.inprematchperiod = 1;
	foreach(player in level.players)
	{
		player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
	}
	level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
	function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

/*
	Name: function_c5394b83
	Namespace: draft
	Checksum: 0xC81163F0
	Offset: 0x1168
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_c5394b83(starttime, seconds)
{
	if(gettime() - starttime > int(seconds * 1000))
	{
		/#
			println("");
		#/
		return 1;
	}
	return 0;
}

/*
	Name: all_players_connected
	Namespace: draft
	Checksum: 0x9DADFE07
	Offset: 0x11D8
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function all_players_connected()
{
	var_5c6783e9 = getnumexpectedplayers(0);
	if(level.players.size < var_5c6783e9)
	{
		/#
			function_95c03d66("" + var_5c6783e9 + "" + level.players.size);
		#/
		return 0;
	}
	foreach(player in level.players)
	{
		if(!player function_9b95ed9f() && !isbot(player))
		{
			/#
				function_95c03d66("" + player.name + "");
			#/
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_d255fb3e
	Namespace: draft
	Checksum: 0x3C83890F
	Offset: 0x1328
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_d255fb3e()
{
	foreach(player in level.players)
	{
		if(player function_9b95ed9f())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_21f5a2c1
	Namespace: draft
	Checksum: 0x7FD21EA4
	Offset: 0x13C0
	Size: 0x1F8
	Parameters: 0
	Flags: None
*/
function function_21f5a2c1()
{
	var_e8cb777 = getgametypesetting(#"draftrequiredclients");
	if(var_e8cb777 <= 0)
	{
		return 1;
	}
	foreach(team, _ in level.teams)
	{
		teamcount[team] = 0;
	}
	foreach(player in level.players)
	{
		if(isdefined(level.teams[player.team]))
		{
			teamcount[player.team]++;
		}
	}
	foreach(team, _ in level.teams)
	{
		if(teamcount[team] < var_e8cb777)
		{
			/#
				function_95c03d66("" + var_e8cb777 + "" + team + "" + teamcount[team]);
			#/
			return 0;
		}
	}
	return 1;
}

/*
	Name: wait_for_players
	Namespace: draft
	Checksum: 0xFA8591C7
	Offset: 0x15C0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function wait_for_players()
{
	while(!function_d255fb3e())
	{
		wait(0.2);
	}
	level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe") + 20;
	function_ee80d2e8(int(max(0, level.var_b318d3d1)));
	while(!all_players_connected())
	{
		wait(0.2);
		if(function_c5394b83(starttime, 20))
		{
			break;
		}
	}
	level.var_b318d3d1 = getgametypesetting(#"drafttime") + getgametypesetting(#"hash_4e4352bd1aaeedfe");
	function_ee80d2e8(int(max(0, level.var_b318d3d1)));
}

/*
	Name: decrement
	Namespace: draft
	Checksum: 0xADA33D26
	Offset: 0x1768
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function decrement(timeremaining)
{
	/#
		if(level.draftstage == 3 && getdvarint(#"draft_pause", 0) != 0)
		{
			return timeremaining;
		}
	#/
	level.var_b318d3d1 = level.var_b318d3d1 - 1;
	function_ee80d2e8(int(max(0, level.var_b318d3d1)));
	return timeremaining - 1;
}

/*
	Name: function_2c9af4b9
	Namespace: draft
	Checksum: 0xDD8FEBCE
	Offset: 0x1828
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_2c9af4b9()
{
	level.var_297320a8 = 1;
}

/*
	Name: function_3e648d9b
	Namespace: draft
	Checksum: 0x7F007F83
	Offset: 0x1848
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_3e648d9b()
{
	level.var_297320a8 = 0;
}

/*
	Name: draft_run
	Namespace: draft
	Checksum: 0xA7C21D0E
	Offset: 0x1868
	Size: 0x550
	Parameters: 0
	Flags: Linked
*/
function draft_run()
{
	/#
		rat::function_b4f2a076();
	#/
	timeremaining = getgametypesetting(#"drafttime");
	function_ee80d2e8(int(max(0, level.var_b318d3d1)));
	foreach(player in level.players)
	{
		if(isbot(player))
		{
			player player_role::clear();
		}
		class_num = player stats::get_stat(#"hash_2a738807be622e31");
		player setplayerstateloadoutweapons(class_num);
	}
	if(timeremaining == 0)
	{
		level.var_9205f2e8 = gettime();
		level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
		while(!ready)
		{
			ready = 1;
			foreach(player in level.players)
			{
				if(player.pers[#"team"] == #"spectator" || isbot(player))
				{
					continue;
				}
				characterindex = player player_role::get();
				if(!player_role::is_valid(characterindex) || !player isready())
				{
					ready = 0;
				}
			}
			wait(1);
		}
	}
	else
	{
		while(!function_d255fb3e())
		{
			wait(1);
		}
		while(timeremaining > 0 && !level.gameended)
		{
			level clientfield::set_world_uimodel("PositionDraft.timeRemaining", timeremaining);
			timeremaining = decrement(timeremaining);
			level.var_5be52892 = 1;
			var_97286e53 = 1;
			foreach(player in level.players)
			{
				if(player.pers[#"team"] == #"spectator")
				{
					continue;
				}
				var_97286e53 = 0;
				if(isbot(player))
				{
					continue;
				}
				if(!player isready())
				{
					level.var_5be52892 = 0;
					break;
				}
			}
			if(level.var_5be52892 && !var_97286e53 && all_players_connected())
			{
				level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
				break;
			}
			else
			{
				wait(1);
			}
		}
		level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
	}
	foreach(player in level.players)
	{
		if(isbot(player))
		{
			assign_remaining_players(player);
		}
		player function_3e46326b();
	}
}

/*
	Name: function_404f08f3
	Namespace: draft
	Checksum: 0x5DB029C6
	Offset: 0x1DC0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_404f08f3()
{
	level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
	wait(2);
}

/*
	Name: sort_categories
	Namespace: draft
	Checksum: 0xC38E7A51
	Offset: 0x1DF8
	Size: 0x2A
	Parameters: 3
	Flags: Linked
*/
function sort_categories(left, right, param)
{
	return left.size > right.size;
}

/*
	Name: assign_remaining_players
	Namespace: draft
	Checksum: 0x7725F94B
	Offset: 0x1E30
	Size: 0xD7A
	Parameters: 1
	Flags: Linked
*/
function assign_remaining_players(only_assign_player)
{
	teams = [];
	characters = [];
	validcharacters = [];
	categorymap = [];
	playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
	for(i = 0; i < playerroletemplatecount; i++)
	{
		var_1404a093 = function_fb05c532(i, currentsessionmode());
		var_bacff7f = getcharacterfields(i, currentsessionmode());
		characters[i] = spawnstruct();
		characters[i].index = i;
		characters[i].available = 0;
		characters[i].enabled = function_f4bf7e3f(i) && (isdefined(var_1404a093.var_422e172f) && var_1404a093.var_422e172f) && (!util::function_8570168d() || (isdefined(var_bacff7f.var_49a55967) && var_bacff7f.var_49a55967)) && !isdefined(var_bacff7f.var_b12a801f);
		characters[i].category = player_role::get_category_for_index(i);
		characters[i].var_9a6db9eb = getgametypesetting(#"maxuniquerolesperteam", i);
		if(characters[i].enabled && player_role::is_valid(i) && characters[i].category != "default" && characters[i].var_9a6db9eb != 0)
		{
			characters[i].available = 1;
			if(!isdefined(validcharacters))
			{
				validcharacters = [];
			}
			else if(!isarray(validcharacters))
			{
				validcharacters = array(validcharacters);
			}
			validcharacters[validcharacters.size] = characters[i];
			if(!isdefined(categorymap[characters[i].category]))
			{
				categorymap[characters[i].category] = categorymap.size;
			}
		}
	}
	if(getdvarint(#"hash_595a93ece672a7da", -1) == 1)
	{
		foreach(player in level.players)
		{
			if(!isdefined(only_assign_player))
			{
				validcharacters = array::randomize(validcharacters);
				player select_character(validcharacters[0].index, 1, 0);
				continue;
			}
			if(only_assign_player == player)
			{
				validcharacters = array::randomize(validcharacters);
				player select_character(validcharacters[0].index, 1, 0);
				break;
			}
		}
		return;
	}
	foreach(player in level.players)
	{
		if(player.pers[#"team"] == #"spectator")
		{
			continue;
		}
		if(!isdefined(teams[player.team]))
		{
			teams[player.team] = [];
		}
		if(!isdefined(teams[player.team]))
		{
			teams[player.team] = [];
		}
		else if(!isarray(teams[player.team]))
		{
			teams[player.team] = array(teams[player.team]);
		}
		teams[player.team][teams[player.team].size] = player;
	}
	foreach(team in teams)
	{
		/#
			println("" + team[0].team);
		#/
		playersneedingassignment = [];
		foreach(character in validcharacters)
		{
			character.available = 0;
			if(character.var_9a6db9eb > 0)
			{
				character.available = 1;
			}
		}
		/#
			println("");
			foreach(player in team)
			{
				characterindex = player player_role::get();
				println("" + player.name + "" + characterindex);
			}
		#/
		foreach(player in team)
		{
			characterindex = player player_role::get();
			if(player_role::is_valid(characterindex))
			{
				characters[characterindex].available = 0;
				continue;
			}
			if(!isdefined(only_assign_player))
			{
				player player_role::clear();
				if(!isdefined(playersneedingassignment))
				{
					playersneedingassignment = [];
				}
				else if(!isarray(playersneedingassignment))
				{
					playersneedingassignment = array(playersneedingassignment);
				}
				playersneedingassignment[playersneedingassignment.size] = player;
				player clientfield::set_player_uimodel("PositionDraft.autoSelected", 1);
				continue;
			}
			if(only_assign_player == player)
			{
				player player_role::clear();
				if(!isdefined(playersneedingassignment))
				{
					playersneedingassignment = [];
				}
				else if(!isarray(playersneedingassignment))
				{
					playersneedingassignment = array(playersneedingassignment);
				}
				playersneedingassignment[playersneedingassignment.size] = player;
			}
		}
		/#
			println("");
		#/
		foreach(player in playersneedingassignment)
		{
			categories = [];
			categorynames = getarraykeys(categorymap);
			for(i = 0; i < categorymap.size; i++)
			{
				categories[i] = [];
			}
			foreach(character in characters)
			{
				if(character.category == "default")
				{
					continue;
				}
				if(character.available == 1)
				{
					categoryindex = categorymap[character.category];
					if(!isdefined(categories[categoryindex]))
					{
						categories[categoryindex] = [];
					}
					else if(!isarray(categories[categoryindex]))
					{
						categories[categoryindex] = array(categories[categoryindex]);
					}
					categories[categoryindex][categories[categoryindex].size] = character.index;
				}
			}
			categories = array::randomize(categories);
			categories = array::merge_sort(categories, &sort_categories);
			selectedcharacter = 0;
			if(categories.size > 0)
			{
				selectedcategory = categories[0];
				selectedcharacter = array::random(selectedcategory);
			}
			if(validcharacters.size == 0)
			{
				/#
					println("");
				#/
				globallogic::exit_level();
				while(true)
				{
					wait(10);
				}
			}
			if(!isdefined(selectedcharacter) || selectedcharacter == 0)
			{
				randomcharacter = array::random(validcharacters);
				selectedcharacter = randomcharacter.index;
			}
			oldspecialistindex = player getspecialistindex();
			if(isdefined(oldspecialistindex) && oldspecialistindex != selectedcharacter)
			{
				player.pers[#"class"] = undefined;
			}
			/#
				println("" + player.name + "" + selectedcharacter);
			#/
			if(player select_character(selectedcharacter, 1, 1))
			{
				characters[selectedcharacter].available = 0;
			}
		}
	}
}

/*
	Name: game_start
	Namespace: draft
	Checksum: 0xFA5EEC9C
	Offset: 0x2BB8
	Size: 0x24C
	Parameters: 0
	Flags: Linked
*/
function game_start()
{
	timeremaining = getgametypesetting(#"hash_4e4352bd1aaeedfe");
	starttime = gettime();
	if(level.var_5be52892 == 1)
	{
		timeremaining++;
	}
	if(level.gametype !== "bounty")
	{
		foreach(player in level.players)
		{
			if(player.hasspawned || player.pers[#"team"] == #"spectator")
			{
				player globallogic_audio::set_music_on_player("spawnPreRise");
			}
		}
	}
	level thread globallogic::sndsetmatchsnapshot(0);
	while(timeremaining > 0 && !level.gameended)
	{
		level clientfield::set_world_uimodel("PositionDraft.timeRemaining", int(timeremaining));
		if(timeremaining == 2)
		{
			globallogic::mpintro_visionset_deactivate_func();
		}
		timeremaining = decrement(timeremaining);
		if(timeremaining == 0)
		{
			wait(0.75);
			luinotifyevent(#"hash_529bc32407856cbf", 0);
			wait(0.25);
		}
		else
		{
			wait(1);
		}
	}
	level notify(#"hash_4c62fe02843b1a98");
	level thread globallogic::sndsetmatchsnapshot(0);
}

/*
	Name: draft_finalize
	Namespace: draft
	Checksum: 0x7B54DE5D
	Offset: 0x2E10
	Size: 0x35C
	Parameters: 0
	Flags: Linked
*/
function draft_finalize()
{
	level.inprematchperiod = 0;
	foreach(player in level.players)
	{
		if(player.sessionstate == "spectator" && player.team != #"spectator")
		{
			assign_remaining_players(player);
		}
		if(player.sessionstate == "playing")
		{
			/#
				println("" + player.name + "" + player.curclass + "" + player getspecialistindex());
			#/
			player loadout::give_loadout(player.team, player.curclass);
			player.pers[#"lastcurclass"] = player.curclass;
			player.pers[#"lastspecialistindex"] = player.curclass;
			player enableweapons();
			player val::reset(#"spawn_player", "freezecontrols");
			player val::reset(#"spawn_player", "disablegadgets");
			player callback::callback(#"hash_1303178bdaf337b5");
		}
	}
	level callback::callback(#"hash_1303178bdaf337b5");
	foreach(player in level.players)
	{
		player clientfield::set_player_uimodel("PositionDraft.autoSelected", 0);
		player clientfield::set_player_uimodel("PositionDraft.stage", 0);
	}
	luinotifyevent(#"draft_complete", 2, 1, 0);
	level notify(#"draft_complete");
	set_draft_stage(0);
	/#
		rat::function_6aa20375();
	#/
}

/*
	Name: set_draft_stage
	Namespace: draft
	Checksum: 0x2D37382
	Offset: 0x3178
	Size: 0x274
	Parameters: 1
	Flags: Linked
*/
function set_draft_stage(draftstage)
{
	level.draftstage = draftstage;
	level clientfield::set("draft", level.draftstage);
	waitframe(1);
	/#
		if(draftstage == 0)
		{
			println("");
		}
		else if(draftstage == 1)
		{
			println("");
		}
		else if(draftstage == 2)
		{
			println("");
		}
		else if(draftstage == 3)
		{
			println("");
		}
		else if(draftstage == 5)
		{
			println("");
		}
		else if(draftstage == 6)
		{
			println("");
		}
		else if(draftstage == 7)
		{
			println("");
		}
	#/
	if(draftstage == 1)
	{
		draft_initialize();
	}
	else if(draftstage == 2)
	{
		wait_for_players();
	}
	else if(draftstage == 3)
	{
		draft_run();
	}
	else if(draftstage == 4)
	{
		function_404f08f3();
	}
	else if(draftstage == 5)
	{
		assign_remaining_players();
	}
	else if(draftstage == 6)
	{
		game_start();
	}
	else if(draftstage == 7)
	{
		draft_finalize();
	}
}

/*
	Name: watch_game_ended
	Namespace: draft
	Checksum: 0x9FBEF5C1
	Offset: 0x33F8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function watch_game_ended()
{
	level waittill(#"game_ended");
	set_draft_stage(0);
}

/*
	Name: start
	Namespace: draft
	Checksum: 0x1D852838
	Offset: 0x3438
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function start()
{
	level endon(#"game_ended");
	level thread watch_game_ended();
	level thread function_ca33311e();
	waitframe(1);
	/#
		println("");
	#/
	set_draft_stage(1);
	set_draft_stage(3);
	if(level.var_5be52892 == 1)
	{
		set_draft_stage(4);
	}
	else
	{
		set_draft_stage(5);
	}
	set_draft_stage(6);
	set_draft_stage(7);
}

/*
	Name: open
	Namespace: draft
	Checksum: 0xEBB2BF01
	Offset: 0x3550
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function open()
{
	player = self;
	/#
		assert(isplayer(self));
	#/
	if(isdefined(level.var_edd52efc))
	{
		self [[level.var_edd52efc]]();
		return;
	}
	/#
		autoselection = getdvarint(#"auto_select_character", -1);
		if(player_role::is_valid(autoselection))
		{
			player player_role::set(autoselection);
			return;
		}
	#/
	player allowspectateallteams(0);
	player allowspectateteam("freelook", 0);
	player allowspectateteam(#"none", 1);
	player allowspectateteam("localplayers", 0);
	player player_role::clear();
	level clientfield::set_world_uimodel("PositionDraft.timeRemaining", 0);
	player clientfield::set_player_uimodel("PositionDraft.stage", 8);
}

/*
	Name: close
	Namespace: draft
	Checksum: 0xF617DBF8
	Offset: 0x36F8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function close()
{
	player = self;
	player spectating::set_permissions();
	self clientfield::set_player_uimodel("PositionDraft.stage", 0);
}

