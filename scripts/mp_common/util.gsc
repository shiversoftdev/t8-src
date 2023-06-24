// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace util;

/*
	Name: within_fov
	Namespace: util
	Checksum: 0x5883DAA4
	Offset: 0x188
	Size: 0x90
	Parameters: 4
	Flags: Linked
*/
function within_fov(start_origin, start_angles, end_origin, fov)
{
	normal = vectornormalize(end_origin - start_origin);
	forward = anglestoforward(start_angles);
	dot = vectordot(forward, normal);
	return dot >= fov;
}

/*
	Name: get_player_height
	Namespace: util
	Checksum: 0xC6611DD2
	Offset: 0x220
	Size: 0xA
	Parameters: 0
	Flags: None
*/
function get_player_height()
{
	return 70;
}

/*
	Name: isbulletimpactmod
	Namespace: util
	Checksum: 0xA1D23C94
	Offset: 0x238
	Size: 0x3E
	Parameters: 1
	Flags: None
*/
function isbulletimpactmod(smeansofdeath)
{
	return issubstr(smeansofdeath, "BULLET") || smeansofdeath == "MOD_HEAD_SHOT";
}

/*
	Name: waitrespawnbutton
	Namespace: util
	Checksum: 0xB1402018
	Offset: 0x280
	Size: 0x4E
	Parameters: 0
	Flags: None
*/
function waitrespawnbutton()
{
	self endon(#"disconnect", #"end_respawn");
	while(self usebuttonpressed() != 1)
	{
		waitframe(1);
	}
}

/*
	Name: printonteam
	Namespace: util
	Checksum: 0xC58E3FCC
	Offset: 0x2D8
	Size: 0xD6
	Parameters: 2
	Flags: None
*/
function printonteam(text, team)
{
	/#
		assert(isdefined(level.players));
	#/
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
		{
			player iprintln(text);
		}
	}
}

/*
	Name: printboldonteam
	Namespace: util
	Checksum: 0x774B5DF5
	Offset: 0x3B8
	Size: 0xD6
	Parameters: 2
	Flags: None
*/
function printboldonteam(text, team)
{
	/#
		assert(isdefined(level.players));
	#/
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
		{
			player iprintlnbold(text);
		}
	}
}

/*
	Name: printboldonteamarg
	Namespace: util
	Checksum: 0xCB1301D0
	Offset: 0x498
	Size: 0xE6
	Parameters: 3
	Flags: None
*/
function printboldonteamarg(text, team, arg)
{
	/#
		assert(isdefined(level.players));
	#/
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
		{
			player iprintlnbold(text, arg);
		}
	}
}

/*
	Name: printonteamarg
	Namespace: util
	Checksum: 0xE2768F2C
	Offset: 0x588
	Size: 0x1C
	Parameters: 3
	Flags: None
*/
function printonteamarg(text, team, arg)
{
}

/*
	Name: printonplayers
	Namespace: util
	Checksum: 0xF8779B4F
	Offset: 0x5B0
	Size: 0xE6
	Parameters: 2
	Flags: None
*/
function printonplayers(text, team)
{
	players = level.players;
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(team))
		{
			if(isdefined(players[i].pers[#"team"]) && players[i].pers[#"team"] == team)
			{
				players[i] iprintln(text);
			}
			continue;
		}
		players[i] iprintln(text);
	}
}

/*
	Name: printandsoundoneveryone
	Namespace: util
	Checksum: 0x644BB4EE
	Offset: 0x6A0
	Size: 0x4FE
	Parameters: 7
	Flags: None
*/
function printandsoundoneveryone(team, enemyteam, printfriendly, printenemy, soundfriendly, soundenemy, printarg)
{
	shoulddosounds = isdefined(soundfriendly);
	shoulddoenemysounds = 0;
	if(isdefined(soundenemy))
	{
		/#
			assert(shoulddosounds);
		#/
		shoulddoenemysounds = 1;
	}
	if(!isdefined(printarg))
	{
		printarg = "";
	}
	if(level.splitscreen || !shoulddosounds)
	{
		for(i = 0; i < level.players.size; i++)
		{
			player = level.players[i];
			playerteam = player.pers[#"team"];
			if(isdefined(playerteam))
			{
				if(playerteam == team && isdefined(printfriendly) && printfriendly != #"")
				{
					player iprintln(printfriendly, printarg);
					continue;
				}
				if(isdefined(printenemy) && printenemy != #"")
				{
					if(isdefined(enemyteam) && playerteam == enemyteam)
					{
						player iprintln(printenemy, printarg);
						continue;
					}
					if(!isdefined(enemyteam) && playerteam != team)
					{
						player iprintln(printenemy, printarg);
					}
				}
			}
		}
		if(shoulddosounds)
		{
			/#
				assert(level.splitscreen);
			#/
			level.players[0] playlocalsound(soundfriendly);
		}
	}
	else
	{
		/#
			assert(shoulddosounds);
		#/
		if(shoulddoenemysounds)
		{
			for(i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				playerteam = player.pers[#"team"];
				if(isdefined(playerteam))
				{
					if(playerteam == team)
					{
						if(isdefined(printfriendly) && printfriendly != #"")
						{
							player iprintln(printfriendly, printarg);
						}
						player playlocalsound(soundfriendly);
						continue;
					}
					if(isdefined(enemyteam) && playerteam == enemyteam || (!isdefined(enemyteam) && playerteam != team))
					{
						if(isdefined(printenemy) && printenemy != #"")
						{
							player iprintln(printenemy, printarg);
						}
						player playlocalsound(soundenemy);
					}
				}
			}
		}
		else
		{
			for(i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				playerteam = player.pers[#"team"];
				if(isdefined(playerteam))
				{
					if(playerteam == team)
					{
						if(isdefined(printfriendly) && printfriendly != #"")
						{
							player iprintln(printfriendly, printarg);
						}
						player playlocalsound(soundfriendly);
						continue;
					}
					if(isdefined(printenemy) && printenemy != #"")
					{
						if(isdefined(enemyteam) && playerteam == enemyteam)
						{
							player iprintln(printenemy, printarg);
							continue;
						}
						if(!isdefined(enemyteam) && playerteam != team)
						{
							player iprintln(printenemy, printarg);
						}
					}
				}
			}
		}
	}
}

/*
	Name: _playlocalsound
	Namespace: util
	Checksum: 0xC63F146D
	Offset: 0xBA8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function _playlocalsound(soundalias)
{
	if(level.splitscreen && !self ishost())
	{
		return;
	}
	self playlocalsound(soundalias);
}

/*
	Name: getotherteam
	Namespace: util
	Checksum: 0x42D2E35A
	Offset: 0xC00
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function getotherteam(team)
{
	if(team == #"allies")
	{
		return #"axis";
	}
	if(team == #"axis")
	{
		return #"allies";
	}
	return #"allies";
}

/*
	Name: getteamenum
	Namespace: util
	Checksum: 0x4FDC285F
	Offset: 0xC98
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function getteamenum(team)
{
	if(team == #"allies")
	{
		return 1;
	}
	if(team == #"axis")
	{
		return 2;
	}
	/#
		assertmsg("" + team);
	#/
}

/*
	Name: getteammask
	Namespace: util
	Checksum: 0x7D0B987B
	Offset: 0xD10
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function getteammask(team)
{
	if(!level.teambased || !isdefined(team) || !isdefined(level.spawnsystem.ispawn_teammask[team]))
	{
		return level.spawnsystem.ispawn_teammask_free;
	}
	return level.spawnsystem.ispawn_teammask[team];
}

/*
	Name: getotherteamsmask
	Namespace: util
	Checksum: 0x666B4E4B
	Offset: 0xD90
	Size: 0xB0
	Parameters: 1
	Flags: None
*/
function getotherteamsmask(skip_team)
{
	mask = 0;
	foreach(team, _ in level.teams)
	{
		if(team == skip_team)
		{
			continue;
		}
		mask = mask | getteammask(team);
	}
	return mask;
}

/*
	Name: wait_endon
	Namespace: util
	Checksum: 0xC7CB1A03
	Offset: 0xE48
	Size: 0x76
	Parameters: 5
	Flags: None
*/
function wait_endon(waittime, endonstring, endonstring2, endonstring3, endonstring4)
{
	self endon(endonstring);
	if(isdefined(endonstring2))
	{
		self endon(endonstring2);
	}
	if(isdefined(endonstring3))
	{
		self endon(endonstring3);
	}
	if(isdefined(endonstring4))
	{
		self endon(endonstring4);
	}
	wait(waittime);
	return true;
}

/*
	Name: getfx
	Namespace: util
	Checksum: 0x74761C02
	Offset: 0xEC8
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function getfx(fx)
{
	/#
		assert(isdefined(level._effect[fx]), ("" + fx) + "");
	#/
	return level._effect[fx];
}

/*
	Name: add_trigger_to_ent
	Namespace: util
	Checksum: 0x7EF6AF5
	Offset: 0xF30
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function add_trigger_to_ent(ent)
{
	if(!isdefined(ent._triggers))
	{
		ent._triggers = [];
	}
	ent._triggers[self getentitynumber()] = 1;
}

/*
	Name: remove_trigger_from_ent
	Namespace: util
	Checksum: 0x308AECAD
	Offset: 0xF90
	Size: 0x72
	Parameters: 1
	Flags: Linked
*/
function remove_trigger_from_ent(ent)
{
	if(!isdefined(ent))
	{
		return;
	}
	if(!isdefined(ent._triggers))
	{
		return;
	}
	if(!isdefined(ent._triggers[self getentitynumber()]))
	{
		return;
	}
	ent._triggers[self getentitynumber()] = 0;
}

/*
	Name: ent_already_in_trigger
	Namespace: util
	Checksum: 0x1AAD6D12
	Offset: 0x1010
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function ent_already_in_trigger(trig)
{
	if(!isdefined(self._triggers))
	{
		return false;
	}
	if(!isdefined(self._triggers[trig getentitynumber()]))
	{
		return false;
	}
	if(!self._triggers[trig getentitynumber()])
	{
		return false;
	}
	return true;
}

/*
	Name: trigger_thread_death_monitor
	Namespace: util
	Checksum: 0xDDAF38FD
	Offset: 0x1088
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function trigger_thread_death_monitor(ent, ender)
{
	ent waittill(#"death");
	self endon(ender);
	self remove_trigger_from_ent(ent);
}

/*
	Name: trigger_thread
	Namespace: util
	Checksum: 0xE098A3FD
	Offset: 0x10E0
	Size: 0x184
	Parameters: 3
	Flags: None
*/
function trigger_thread(ent, on_enter_payload, on_exit_payload)
{
	ent endon(#"death");
	if(ent ent_already_in_trigger(self))
	{
		return;
	}
	self add_trigger_to_ent(ent);
	ender = (("end_trig_death_monitor" + self getentitynumber()) + " ") + ent getentitynumber();
	self thread trigger_thread_death_monitor(ent, ender);
	endon_condition = "leave_trigger_" + self getentitynumber();
	if(isdefined(on_enter_payload))
	{
		self thread [[on_enter_payload]](ent, endon_condition);
	}
	while(isdefined(ent) && ent istouching(self))
	{
		wait(0.01);
	}
	ent notify(endon_condition);
	if(isdefined(ent) && isdefined(on_exit_payload))
	{
		self thread [[on_exit_payload]](ent);
	}
	if(isdefined(ent))
	{
		self remove_trigger_from_ent(ent);
	}
	self notify(ender);
}

/*
	Name: isstrstart
	Namespace: util
	Checksum: 0x49CD553E
	Offset: 0x1270
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function isstrstart(string1, substr)
{
	return getsubstr(string1, 0, substr.size) == substr;
}

/*
	Name: iskillstreaksenabled
	Namespace: util
	Checksum: 0xF0287D03
	Offset: 0x12B0
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function iskillstreaksenabled()
{
	return isdefined(level.killstreaksenabled) && level.killstreaksenabled;
}

/*
	Name: function_78e3e07b
	Namespace: util
	Checksum: 0x964F2D33
	Offset: 0x12D8
	Size: 0xA4
	Parameters: 3
	Flags: Linked, Private
*/
function private function_78e3e07b(team, index, var_6d8f07f6)
{
	setobjectivetext(team, var_6d8f07f6.text);
	if(level.splitscreen)
	{
		setobjectivescoretext(team, var_6d8f07f6.var_27a7a289);
	}
	else
	{
		setobjectivescoretext(team, var_6d8f07f6.var_4687634f);
	}
	function_db4846b(team, index);
}

/*
	Name: function_e17a230f
	Namespace: util
	Checksum: 0x89012573
	Offset: 0x1388
	Size: 0x23A
	Parameters: 1
	Flags: Linked
*/
function function_e17a230f(team)
{
	if(!isdefined(level.var_d1455682))
	{
		return;
	}
	var_6d8f07f6 = level.var_d1455682.var_6d8f07f6;
	foreach(index, var_53c9b682 in var_6d8f07f6)
	{
		if(isdefined(var_53c9b682.attacker) && var_53c9b682.attacker && team != game.attackers)
		{
			continue;
		}
		if(isdefined(var_53c9b682.defender) && var_53c9b682.defender && team != game.defenders)
		{
			continue;
		}
		if(isdefined(var_53c9b682.overtime) && var_53c9b682.overtime)
		{
			if(!game.overtime_round)
			{
				continue;
			}
			if(isdefined(var_53c9b682.overtime_round) && var_53c9b682.overtime_round && var_53c9b682.overtime_round != game.overtime_round)
			{
				continue;
			}
			if(isdefined(var_53c9b682.var_47177317) && var_53c9b682.var_47177317 && isdefined(game.overtime_first_winner) && team != game.overtime_first_winner)
			{
				continue;
			}
			if(isdefined(var_53c9b682.var_76fa703c) && var_53c9b682.var_76fa703c && isdefined(game.overtime_first_winner) && team == game.overtime_first_winner)
			{
				continue;
			}
		}
		function_78e3e07b(team, index, var_53c9b682);
		return;
	}
}

/*
	Name: function_9540d9b6
	Namespace: util
	Checksum: 0x89473FA5
	Offset: 0x15D0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_9540d9b6()
{
	if(!isdefined(level.var_d1455682))
	{
		return;
	}
	foreach(team, _ in level.teams)
	{
		function_e17a230f(team);
	}
}

/*
	Name: setobjectivetext
	Namespace: util
	Checksum: 0x6B4BD86F
	Offset: 0x1668
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function setobjectivetext(team, text)
{
	game.strings["objective_" + level.teams[team]] = text;
}

/*
	Name: setobjectivescoretext
	Namespace: util
	Checksum: 0x46A70C5D
	Offset: 0x16B0
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function setobjectivescoretext(team, text)
{
	game.strings["objective_score_" + level.teams[team]] = text;
}

/*
	Name: function_db4846b
	Namespace: util
	Checksum: 0xA6BD59D2
	Offset: 0x16F8
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_db4846b(team, text)
{
	game.strings["objective_first_spawn_hint_" + level.teams[team]] = text;
}

/*
	Name: getobjectivetext
	Namespace: util
	Checksum: 0x6AFC51A5
	Offset: 0x1740
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function getobjectivetext(team)
{
	return game.strings["objective_" + level.teams[team]];
}

/*
	Name: getobjectivescoretext
	Namespace: util
	Checksum: 0x9738A88D
	Offset: 0x1778
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function getobjectivescoretext(team)
{
	return game.strings["objective_score_" + level.teams[team]];
}

/*
	Name: function_4a118b30
	Namespace: util
	Checksum: 0xD0DA889D
	Offset: 0x17B0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_4a118b30(team)
{
	return game.strings["objective_first_spawn_hint_" + level.teams[team]];
}

/*
	Name: registerroundswitch
	Namespace: util
	Checksum: 0xCF84B607
	Offset: 0x17E8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function registerroundswitch(minvalue, maxvalue)
{
	level.roundswitch = math::clamp(getgametypesetting(#"roundswitch"), minvalue, maxvalue);
	level.roundswitchmin = minvalue;
	level.roundswitchmax = maxvalue;
}

/*
	Name: registerroundlimit
	Namespace: util
	Checksum: 0x14ED0F00
	Offset: 0x1868
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function registerroundlimit(minvalue, maxvalue)
{
	level.roundlimit = math::clamp(getgametypesetting(#"roundlimit"), minvalue, maxvalue);
	level.roundlimitmin = minvalue;
	level.roundlimitmax = maxvalue;
}

/*
	Name: registerroundwinlimit
	Namespace: util
	Checksum: 0x55670A7F
	Offset: 0x18E8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function registerroundwinlimit(minvalue, maxvalue)
{
	level.roundwinlimit = math::clamp(getgametypesetting(#"roundwinlimit"), minvalue, maxvalue);
	level.roundwinlimitmin = minvalue;
	level.roundwinlimitmax = maxvalue;
}

/*
	Name: registerscorelimit
	Namespace: util
	Checksum: 0x6305E3B8
	Offset: 0x1968
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function registerscorelimit(minvalue, maxvalue)
{
	level.scorelimit = math::clamp(getgametypesetting(#"scorelimit"), minvalue, maxvalue);
	level.scorelimitmin = minvalue;
	level.scorelimitmax = maxvalue;
}

/*
	Name: registerroundscorelimit
	Namespace: util
	Checksum: 0x107CF3E8
	Offset: 0x19E8
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function registerroundscorelimit(minvalue, maxvalue)
{
	level.roundscorelimit = math::clamp(getgametypesetting(#"roundscorelimit"), minvalue, maxvalue);
	level.roundscorelimitmin = minvalue;
	level.roundscorelimitmax = maxvalue;
}

/*
	Name: registertimelimit
	Namespace: util
	Checksum: 0x55895FF2
	Offset: 0x1A68
	Size: 0x8A
	Parameters: 2
	Flags: Linked
*/
function registertimelimit(minvalue, maxvalue)
{
	level.timelimit = math::clamp(getgametypesetting(#"timelimit"), minvalue, maxvalue);
	/#
		override_gts_timelimit();
	#/
	level.timelimitmin = minvalue;
	level.timelimitmax = maxvalue;
}

/*
	Name: registernumlives
	Namespace: util
	Checksum: 0xD52BDEFA
	Offset: 0x1B00
	Size: 0x12E
	Parameters: 4
	Flags: Linked
*/
function registernumlives(minvalue, maxvalue, teamlivesminvalue = minvalue, teamlivesmaxvalue = maxvalue)
{
	level.numlives = math::clamp(getgametypesetting(#"playernumlives"), minvalue, maxvalue);
	level.numlivesmin = minvalue;
	level.numlivesmax = maxvalue;
	level.numteamlives = math::clamp(getgametypesetting(#"teamnumlives"), teamlivesminvalue, teamlivesmaxvalue);
	level.numteamlivesmin = (isdefined(teamlivesminvalue) ? teamlivesminvalue : level.numlivesmin);
	level.numteamlivesmax = (isdefined(teamlivesmaxvalue) ? teamlivesmaxvalue : level.numlivesmax);
}

/*
	Name: getplayerfromclientnum
	Namespace: util
	Checksum: 0xCDB53BDC
	Offset: 0x1C38
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function getplayerfromclientnum(clientnum)
{
	if(clientnum < 0)
	{
		return undefined;
	}
	for(i = 0; i < level.players.size; i++)
	{
		if(level.players[i] getentitynumber() == clientnum)
		{
			return level.players[i];
		}
	}
	return undefined;
}

/*
	Name: ispressbuild
	Namespace: util
	Checksum: 0x21DDABD7
	Offset: 0x1CC8
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function ispressbuild()
{
	buildtype = getdvarstring(#"buildtype");
	if(isdefined(buildtype) && buildtype == "press")
	{
		return true;
	}
	return false;
}

/*
	Name: isflashbanged
	Namespace: util
	Checksum: 0x72AB00DB
	Offset: 0x1D28
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function isflashbanged()
{
	return isdefined(self.flashendtime) && gettime() < self.flashendtime;
}

/*
	Name: domaxdamage
	Namespace: util
	Checksum: 0x786B1B7F
	Offset: 0x1D50
	Size: 0xBC
	Parameters: 5
	Flags: None
*/
function domaxdamage(origin, attacker, inflictor, headshot, mod)
{
	if(isdefined(self.damagedtodeath) && self.damagedtodeath)
	{
		return;
	}
	if(isdefined(self.maxhealth))
	{
		damage = self.maxhealth + 1;
	}
	else
	{
		damage = self.health + 1;
	}
	self.damagedtodeath = 1;
	self dodamage(damage, origin, attacker, inflictor, headshot, mod);
}

/*
	Name: self_delete
	Namespace: util
	Checksum: 0x55C2B6E0
	Offset: 0x1E18
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function self_delete()
{
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: use_button_pressed
	Namespace: util
	Checksum: 0x4BD7875D
	Offset: 0x1E48
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function use_button_pressed()
{
	/#
		assert(isplayer(self), "");
	#/
	return self usebuttonpressed();
}

/*
	Name: waittill_use_button_pressed
	Namespace: util
	Checksum: 0xBD69374F
	Offset: 0x1EA0
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_use_button_pressed()
{
	while(!self use_button_pressed())
	{
		waitframe(1);
	}
}

/*
	Name: show_hint_text
	Namespace: util
	Checksum: 0xA37CEC13
	Offset: 0x1ED0
	Size: 0x184
	Parameters: 4
	Flags: None
*/
function show_hint_text(str_text_to_show, b_should_blink = 0, str_turn_off_notify = "notify_turn_off_hint_text", n_display_time = 4)
{
	self endon(#"notify_turn_off_hint_text", #"hint_text_removed");
	if(isdefined(self.hint_menu_handle))
	{
		hide_hint_text(0);
	}
	self.hint_menu_handle = self openluimenu("MPHintText");
	self setluimenudata(self.hint_menu_handle, #"hint_text_line", str_text_to_show);
	if(b_should_blink)
	{
		lui::play_animation(self.hint_menu_handle, "blinking");
	}
	else
	{
		lui::play_animation(self.hint_menu_handle, "display_noblink");
	}
	if(n_display_time != -1)
	{
		self thread hide_hint_text_listener(n_display_time);
		self thread fade_hint_text_after_time(n_display_time, str_turn_off_notify);
	}
}

/*
	Name: hide_hint_text
	Namespace: util
	Checksum: 0x1D568F28
	Offset: 0x2060
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function hide_hint_text(b_fade_before_hiding = 1)
{
	self endon(#"hint_text_removed");
	if(isdefined(self.hint_menu_handle))
	{
		if(b_fade_before_hiding)
		{
			lui::play_animation(self.hint_menu_handle, "fadeout");
			self waittilltimeout(0.75, #"kill_hint_text", #"death", #"hint_text_removed");
		}
		self closeluimenu(self.hint_menu_handle);
		self.hint_menu_handle = undefined;
	}
	self notify(#"hint_text_removed");
}

/*
	Name: fade_hint_text_after_time
	Namespace: util
	Checksum: 0x3D84E9AE
	Offset: 0x2140
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function fade_hint_text_after_time(n_display_time, str_turn_off_notify)
{
	self endon(#"hint_text_removed", #"death", #"kill_hint_text");
	self waittilltimeout(n_display_time - 0.75, str_turn_off_notify, #"hint_text_removed", #"kill_hint_text");
	hide_hint_text(1);
}

/*
	Name: hide_hint_text_listener
	Namespace: util
	Checksum: 0xA83199E5
	Offset: 0x21E0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function hide_hint_text_listener(n_time)
{
	self endon(#"hint_text_removed", #"disconnect");
	self waittilltimeout(n_time, #"kill_hint_text", #"death", #"hint_text_removed", #"disconnect");
	hide_hint_text(0);
}

/*
	Name: set_team_radar
	Namespace: util
	Checksum: 0x7F3DF9A
	Offset: 0x2278
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function set_team_radar(team, value)
{
	if(team == #"allies")
	{
		setmatchflag("radar_allies", value);
	}
	else if(team == #"axis")
	{
		setmatchflag("radar_axis", value);
	}
}

/*
	Name: is_objective_game
	Namespace: util
	Checksum: 0x28E81586
	Offset: 0x2300
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function is_objective_game(game_type)
{
	switch(game_type)
	{
		case "dm":
		case "conf":
		case "gun":
		case "tdm":
		case "clean":
		{
			return false;
			break;
		}
		default:
		{
			return true;
		}
	}
}

/*
	Name: isprophuntgametype
	Namespace: util
	Checksum: 0xD6F5F398
	Offset: 0x2398
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function isprophuntgametype()
{
	return isdefined(level.isprophunt) && level.isprophunt;
}

/*
	Name: isprop
	Namespace: util
	Checksum: 0x2712048E
	Offset: 0x23C0
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function isprop()
{
	return isdefined(self.pers[#"team"]) && self.pers[#"team"] == game.defenders;
}

/*
	Name: function_6f4ff113
	Namespace: util
	Checksum: 0xF2B78747
	Offset: 0x2418
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function function_6f4ff113(team)
{
	if(game.switchedsides)
	{
		return getotherteam(team);
	}
	return team;
}

/*
	Name: function_920dcdbf
	Namespace: util
	Checksum: 0x6A1BFB77
	Offset: 0x2450
	Size: 0x2C
	Parameters: 2
	Flags: None
*/
function function_920dcdbf(item, var_3ec5ff40)
{
	if(game.switchedsides)
	{
		return var_3ec5ff40;
	}
	return item;
}

/*
	Name: function_ff74bf7
	Namespace: util
	Checksum: 0xA1C56E65
	Offset: 0x2488
	Size: 0x100
	Parameters: 1
	Flags: None
*/
function function_ff74bf7(team)
{
	players = level.players;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team && isdefined(player.pers[#"class"]))
		{
			if(player.sessionstate == "playing" && !player.afk)
			{
				return i;
			}
		}
	}
	return players.size;
}

/*
	Name: function_5a68c330
	Namespace: util
	Checksum: 0x7199E2E7
	Offset: 0x2590
	Size: 0x168
	Parameters: 4
	Flags: Linked
*/
function function_5a68c330(var_e0dd85aa, s_team, n_clientnum, extradata = 0)
{
	if(!isdefined(var_e0dd85aa))
	{
		return;
	}
	switch(s_team)
	{
		case "axis":
		{
			var_dfc4aab4 = 2;
			break;
		}
		case "allies":
		{
			var_dfc4aab4 = 1;
			break;
		}
		default:
		{
			var_dfc4aab4 = 0;
		}
	}
	if(!isdefined(n_clientnum))
	{
		n_clientnum = -1;
	}
	players = get_players();
	foreach(player in players)
	{
		player luinotifyevent(#"announcement_event", 4, var_e0dd85aa, var_dfc4aab4, n_clientnum, extradata);
	}
}

/*
	Name: function_94a3be2
	Namespace: util
	Checksum: 0x1B586F69
	Offset: 0x2700
	Size: 0xD8
	Parameters: 0
	Flags: None
*/
function function_94a3be2()
{
	if(isdefined(level.var_903e2252) && level.var_903e2252)
	{
		return true;
	}
	if((isdefined(getgametypesetting(#"drafttime")) ? getgametypesetting(#"drafttime") : 0) < 30)
	{
		return true;
	}
	if(!(isdefined(getgametypesetting(#"draftenabled")) && getgametypesetting(#"draftenabled")))
	{
		return true;
	}
	return false;
}

/*
	Name: check_art_mode
	Namespace: util
	Checksum: 0x834D28F2
	Offset: 0x27E0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function check_art_mode()
{
	/#
		if(getdvarint(#"art_mode", 0) > 0)
		{
			init_map_art_dev();
		}
	#/
}

/*
	Name: apply_dev_overrides
	Namespace: util
	Checksum: 0x7F90F6CA
	Offset: 0x2830
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function apply_dev_overrides()
{
	/#
		override_gts_timelimit();
	#/
}

/*
	Name: init_map_art_dev
	Namespace: util
	Checksum: 0xD23B21F1
	Offset: 0x2858
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function init_map_art_dev()
{
	/#
		disable_gameplay_timers();
		disable_draft();
		disable_ui();
		enable_art_fps();
	#/
}

/*
	Name: disable_gameplay_timers
	Namespace: util
	Checksum: 0x8A8333A0
	Offset: 0x28B0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function disable_gameplay_timers()
{
	/#
		setdvar(#"timelimitoverride", 0);
		setdvar(#"prematchperiodoverride", 0);
		setdvar(#"preroundperiodoverride", 0);
	#/
}

/*
	Name: disable_draft
	Namespace: util
	Checksum: 0x155C5809
	Offset: 0x2928
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function disable_draft()
{
	/#
		setdvar(#"draftenabled", 0);
		setdvar(#"auto_select_character", 1);
	#/
}

/*
	Name: disable_ui
	Namespace: util
	Checksum: 0x12DF9479
	Offset: 0x2988
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function disable_ui()
{
	/#
		setdvar(#"ui_enabled", 0);
	#/
}

/*
	Name: override_gts_timelimit
	Namespace: util
	Checksum: 0xB17DB74A
	Offset: 0x29C0
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function override_gts_timelimit()
{
	/#
		timelimitoverride = getdvarint(#"timelimitoverride", -1);
		if(timelimitoverride >= 0)
		{
			if(level.timelimit != timelimitoverride)
			{
				level.timelimit = timelimitoverride;
				setgametypesetting("", timelimitoverride);
			}
		}
	#/
}

/*
	Name: enable_art_fps
	Namespace: util
	Checksum: 0x8D2A2D36
	Offset: 0x2A48
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function enable_art_fps()
{
	/#
		setdvar(#"cg_drawfps", 0);
		setdvar(#"cg_drawartfps", 1);
	#/
}

