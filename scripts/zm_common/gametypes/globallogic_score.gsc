// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\bb.gsc;
#using scripts\zm_common\gametypes\globallogic.gsc;
#using scripts\zm_common\gametypes\globallogic_audio.gsc;
#using scripts\zm_common\gametypes\globallogic_utils.gsc;
#using scripts\zm_common\util.gsc;

#namespace globallogic_score;

/*
	Name: gethighestscoringplayer
	Namespace: globallogic_score
	Checksum: 0xAD015F8F
	Offset: 0x190
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function gethighestscoringplayer()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0; i < players.size; i++)
	{
		if(!isdefined(players[i].score))
		{
			continue;
		}
		if(players[i].score < 1)
		{
			continue;
		}
		if(!isdefined(winner) || players[i].score > winner.score)
		{
			winner = players[i];
			tie = 0;
			continue;
		}
		if(players[i].score == winner.score)
		{
			tie = 1;
		}
	}
	if(tie || !isdefined(winner))
	{
		return undefined;
	}
	return winner;
}

/*
	Name: resetscorechain
	Namespace: globallogic_score
	Checksum: 0x3513DD1B
	Offset: 0x2C0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function resetscorechain()
{
	self notify(#"reset_score_chain");
	self.scorechain = 0;
	self.rankupdatetotal = 0;
}

/*
	Name: scorechaintimer
	Namespace: globallogic_score
	Checksum: 0x4F76D058
	Offset: 0x2F8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function scorechaintimer()
{
	self notify(#"score_chain_timer");
	self endon(#"reset_score_chain", #"score_chain_timer", #"death", #"disconnect");
	wait(20);
	self thread resetscorechain();
}

/*
	Name: roundtonearestfive
	Namespace: globallogic_score
	Checksum: 0x37137667
	Offset: 0x378
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function roundtonearestfive(score)
{
	rounding = score % 5;
	if(rounding <= 2)
	{
		return score - rounding;
	}
	return score + 5 - rounding;
}

/*
	Name: giveplayermomentumnotification
	Namespace: globallogic_score
	Checksum: 0xEF55E45
	Offset: 0x3D8
	Size: 0x1F4
	Parameters: 4
	Flags: None
*/
function giveplayermomentumnotification(score, label, descvalue, countstowardrampage)
{
	rampagebonus = 0;
	if(isdefined(level.usingrampage) && level.usingrampage)
	{
		if(countstowardrampage)
		{
			if(!isdefined(self.scorechain))
			{
				self.scorechain = 0;
			}
			self.scorechain++;
			self thread scorechaintimer();
		}
		if(isdefined(self.scorechain) && self.scorechain >= 999)
		{
			rampagebonus = roundtonearestfive(int(score * level.rampagebonusscale + 0.5));
		}
	}
	combat_efficiency_factor = 0;
	if(score != 0)
	{
		self luinotifyevent(#"score_event", 4, label, score, rampagebonus, combat_efficiency_factor);
	}
	score = score + rampagebonus;
	if(score > 0 && self hasperk(#"specialty_earnmoremomentum"))
	{
		score = roundtonearestfive(int(score * getdvarfloat(#"perk_killstreakmomentummultiplier", 0) + 0.5));
	}
	_setplayermomentum(self, self.pers[#"momentum"] + score);
}

/*
	Name: resetplayermomentumondeath
	Namespace: globallogic_score
	Checksum: 0xB82B24D5
	Offset: 0x5D8
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function resetplayermomentumondeath()
{
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks)
	{
		_setplayermomentum(self, 0);
		self thread resetscorechain();
	}
}

/*
	Name: giveplayerxpdisplay
	Namespace: globallogic_score
	Checksum: 0x40561CF1
	Offset: 0x638
	Size: 0x170
	Parameters: 4
	Flags: Linked
*/
function giveplayerxpdisplay(event, player, victim, descvalue)
{
	score = player rank::getscoreinfovalue(event);
	/#
		assert(isdefined(score));
	#/
	xp = player rank::getscoreinfoxp(event);
	/#
		assert(isdefined(xp));
	#/
	label = rank::getscoreinfolabel(event);
	if(xp && !level.gameended && isdefined(label))
	{
		xpscale = player getxpscale();
		if(1 != xpscale)
		{
			xp = int(xp * xpscale + 0.5);
		}
		player luinotifyevent(#"score_event", 2, label, xp);
	}
	return score;
}

/*
	Name: giveplayerscore
	Namespace: globallogic_score
	Checksum: 0x9C7E2620
	Offset: 0x7B0
	Size: 0x52
	Parameters: 6
	Flags: Linked
*/
function giveplayerscore(event, player, victim, descvalue, weapon, var_36f23f1f)
{
	return giveplayerxpdisplay(event, player, victim, descvalue);
}

/*
	Name: default_onplayerscore
	Namespace: globallogic_score
	Checksum: 0x9D941782
	Offset: 0x810
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function default_onplayerscore(event, player, victim)
{
}

/*
	Name: _setplayerscore
	Namespace: globallogic_score
	Checksum: 0x2133FA99
	Offset: 0x838
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function _setplayerscore(player, score)
{
}

/*
	Name: _getplayerscore
	Namespace: globallogic_score
	Checksum: 0x6E8134A0
	Offset: 0x858
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function _getplayerscore(player)
{
	return player.pers[#"score"];
}

/*
	Name: _setplayermomentum
	Namespace: globallogic_score
	Checksum: 0x23196879
	Offset: 0x888
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function _setplayermomentum(player, momentum)
{
	momentum = math::clamp(momentum, 0, 2000);
	oldmomentum = player.pers[#"momentum"];
	if(momentum == oldmomentum)
	{
		return;
	}
	player bb::add_to_stat("momentum", momentum - oldmomentum);
	if(momentum > oldmomentum)
	{
		highestmomentumcost = 0;
		numkillstreaks = player.killstreak.size;
		killstreaktypearray = [];
	}
	player.pers[#"momentum"] = momentum;
	player.momentum = player.pers[#"momentum"];
}

/*
	Name: _giveplayerkillstreakinternal
	Namespace: globallogic_score
	Checksum: 0xBB668E19
	Offset: 0x9B8
	Size: 0x24
	Parameters: 4
	Flags: None
*/
function _giveplayerkillstreakinternal(player, momentum, oldmomentum, killstreaktypearray)
{
}

/*
	Name: setplayermomentumdebug
	Namespace: globallogic_score
	Checksum: 0x73D1AF9B
	Offset: 0x9E8
	Size: 0xF8
	Parameters: 0
	Flags: None
*/
function setplayermomentumdebug()
{
	/#
		setdvar(#"sv_momentumpercent", 0);
		while(true)
		{
			wait(1);
			momentumpercent = getdvarfloat(#"sv_momentumpercent", 0);
			if(momentumpercent != 0)
			{
				player = util::gethostplayer();
				if(!isdefined(player))
				{
					return;
				}
				if(isdefined(player.killstreak))
				{
					_setplayermomentum(player, int(2000 * momentumpercent / 100));
				}
			}
		}
	#/
}

/*
	Name: giveteamscore
	Namespace: globallogic_score
	Checksum: 0xDAF76DAC
	Offset: 0xAE8
	Size: 0x19C
	Parameters: 4
	Flags: Linked
*/
function giveteamscore(event, team, player, victim)
{
	if(level.overrideteamscore)
	{
		return;
	}
	pixbeginevent(#"hash_66d4a941ef078585");
	teamscore = game.stat[#"teamscores"][team];
	[[level.onteamscore]](event, team);
	pixendevent();
	newscore = game.stat[#"teamscores"][team];
	var_c5fef2b3 = {#score:newscore, #diff:newscore - teamscore, #team:team, #event:event, #gametime:function_f8d53445()};
	function_92d1707f(#"hash_6823717ff11a304a", var_c5fef2b3);
	if(teamscore == newscore)
	{
		return;
	}
	updateteamscores(team);
	thread globallogic::checkscorelimit();
}

/*
	Name: giveteamscoreforobjective
	Namespace: globallogic_score
	Checksum: 0x9ED5F53D
	Offset: 0xC90
	Size: 0xAC
	Parameters: 2
	Flags: None
*/
function giveteamscoreforobjective(team, score)
{
	teamscore = game.stat[#"teamscores"][team];
	onteamscore(score, team);
	newscore = game.stat[#"teamscores"][team];
	if(teamscore == newscore)
	{
		return;
	}
	updateteamscores(team);
	thread globallogic::checkscorelimit();
}

/*
	Name: _setteamscore
	Namespace: globallogic_score
	Checksum: 0x83493861
	Offset: 0xD48
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function _setteamscore(team, teamscore)
{
	if(teamscore == game.stat[#"teamscores"][team])
	{
		return;
	}
	game.stat[#"teamscores"][team] = teamscore;
	updateteamscores(team);
	thread globallogic::checkscorelimit();
}

/*
	Name: resetteamscores
	Namespace: globallogic_score
	Checksum: 0x3C9E524E
	Offset: 0xDE0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function resetteamscores()
{
	if(level.scoreroundwinbased || util::isfirstround())
	{
		foreach(team, _ in level.teams)
		{
			game.stat[#"teamscores"][team] = 0;
		}
	}
	updateallteamscores();
}

/*
	Name: resetallscores
	Namespace: globallogic_score
	Checksum: 0xFEE44B8F
	Offset: 0xEB0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function resetallscores()
{
	resetteamscores();
	resetplayerscores();
}

/*
	Name: resetplayerscores
	Namespace: globallogic_score
	Checksum: 0x16776DD4
	Offset: 0xEE0
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function resetplayerscores()
{
	players = level.players;
	winner = undefined;
	tie = 0;
	for(i = 0; i < players.size; i++)
	{
		if(isdefined(players[i].pers[#"score"]))
		{
			_setplayerscore(players[i], 0);
		}
	}
}

/*
	Name: updateteamscores
	Namespace: globallogic_score
	Checksum: 0x7DAF9532
	Offset: 0xF90
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function updateteamscores(team)
{
	setteamscore(team, game.stat[#"teamscores"][team]);
	level thread globallogic::checkteamscorelimitsoon(team);
}

/*
	Name: updateallteamscores
	Namespace: globallogic_score
	Checksum: 0xAFCAB97A
	Offset: 0xFF0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function updateallteamscores()
{
	foreach(team, _ in level.teams)
	{
		updateteamscores(team);
	}
}

/*
	Name: _getteamscore
	Namespace: globallogic_score
	Checksum: 0xF845CC76
	Offset: 0x1078
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function _getteamscore(team)
{
	return game.stat[#"teamscores"][team];
}

/*
	Name: gethighestteamscoreteam
	Namespace: globallogic_score
	Checksum: 0x73B5827F
	Offset: 0x10A8
	Size: 0xEA
	Parameters: 0
	Flags: Linked
*/
function gethighestteamscoreteam()
{
	score = 0;
	winning_teams = [];
	foreach(team, _ in level.teams)
	{
		team_score = game.stat[#"teamscores"][team];
		if(team_score > score)
		{
			score = team_score;
			winning_teams = [];
		}
		if(team_score == score)
		{
			winning_teams[team] = team;
		}
	}
	return winning_teams;
}

/*
	Name: areteamarraysequal
	Namespace: globallogic_score
	Checksum: 0x679B0601
	Offset: 0x11A0
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function areteamarraysequal(teamsa, teamsb)
{
	if(teamsa.size != teamsb.size)
	{
		return 0;
	}
	foreach(team in teamsa)
	{
		if(!isdefined(teamsb[team]))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: onteamscore
	Namespace: globallogic_score
	Checksum: 0x665CB0BF
	Offset: 0x1248
	Size: 0x2A2
	Parameters: 2
	Flags: Linked
*/
function onteamscore(score, team)
{
	game.stat[#"teamscores"][team] = game.stat[#"teamscores"][team] + score;
	if(level.scorelimit && game.stat[#"teamscores"][team] > level.scorelimit)
	{
		game.stat[#"teamscores"][team] = level.scorelimit;
	}
	if(level.splitscreen)
	{
		return;
	}
	if(level.scorelimit == 1)
	{
		return;
	}
	iswinning = gethighestteamscoreteam();
	if(iswinning.size == 0)
	{
		return;
	}
	if(gettime() - level.laststatustime < 5000)
	{
		return;
	}
	if(areteamarraysequal(iswinning, level.waswinning))
	{
		return;
	}
	level.laststatustime = gettime();
	if(iswinning.size == 1)
	{
		foreach(team in iswinning)
		{
			if(isdefined(level.waswinning[team]))
			{
				if(level.waswinning.size == 1)
				{
					continue;
				}
			}
		}
	}
	if(level.waswinning.size == 1)
	{
		foreach(team in level.waswinning)
		{
			if(isdefined(iswinning[team]))
			{
				if(iswinning.size == 1)
				{
					continue;
				}
				if(level.waswinning.size > 1)
				{
					continue;
				}
			}
		}
	}
	level.waswinning = iswinning;
}

/*
	Name: initpersstat
	Namespace: globallogic_score
	Checksum: 0xDFFB3809
	Offset: 0x14F8
	Size: 0xEA
	Parameters: 3
	Flags: Linked
*/
function initpersstat(dataname, record_stats, init_to_stat_value)
{
	if(!isdefined(self.pers[dataname]))
	{
		self.pers[dataname] = 0;
	}
	if(!isdefined(record_stats) || record_stats == 1)
	{
		recordplayerstats(self, dataname, int(self.pers[dataname]));
	}
	if(isdefined(init_to_stat_value) && init_to_stat_value == 1)
	{
		self.pers[dataname] = self stats::get_stat(#"playerstatslist", dataname, #"statvalue");
	}
}

/*
	Name: getpersstat
	Namespace: globallogic_score
	Checksum: 0x243DD70A
	Offset: 0x15F0
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function getpersstat(dataname)
{
	return self.pers[dataname];
}

/*
	Name: incpersstat
	Namespace: globallogic_score
	Checksum: 0x50F49DD8
	Offset: 0x1610
	Size: 0xF4
	Parameters: 4
	Flags: Linked
*/
function incpersstat(dataname, increment, record_stats, includegametype)
{
	pixbeginevent(#"incpersstat");
	/#
		/#
			assert(isdefined(self.pers[dataname]), dataname + "");
		#/
	#/
	self.pers[dataname] = self.pers[dataname] + increment;
	self stats::function_dad108fa(dataname, increment);
	if(!isdefined(record_stats) || record_stats == 1)
	{
		self thread threadedrecordplayerstats(dataname);
	}
	pixendevent();
}

/*
	Name: threadedrecordplayerstats
	Namespace: globallogic_score
	Checksum: 0x562A1D96
	Offset: 0x1710
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function threadedrecordplayerstats(dataname)
{
	self endon(#"disconnect");
	waittillframeend();
	recordplayerstats(self, dataname, self.pers[dataname]);
}

/*
	Name: inckillstreaktracker
	Namespace: globallogic_score
	Checksum: 0xCBD068
	Offset: 0x1760
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function inckillstreaktracker(weapon)
{
	self endon(#"disconnect");
	waittillframeend();
	if(weapon.name == #"artillery")
	{
		self.pers[#"artillery_kills"]++;
	}
	if(weapon.name == #"dog_bite")
	{
		self.pers[#"dog_kills"]++;
	}
}

/*
	Name: trackattackerkill
	Namespace: globallogic_score
	Checksum: 0x8202B116
	Offset: 0x17F8
	Size: 0x3AC
	Parameters: 5
	Flags: None
*/
function trackattackerkill(name, rank, xp, prestige, xuid)
{
	self endon(#"disconnect");
	attacker = self;
	waittillframeend();
	pixbeginevent(#"trackattackerkill");
	if(!isdefined(attacker.pers[#"killed_players"][name]))
	{
		attacker.pers[#"killed_players"][name] = 0;
	}
	if(!isdefined(attacker.killedplayerscurrent[name]))
	{
		attacker.killedplayerscurrent[name] = 0;
	}
	if(!isdefined(attacker.pers[#"nemesis_tracking"][name]))
	{
		attacker.pers[#"nemesis_tracking"][name] = 0;
	}
	attacker.pers[#"killed_players"][name]++;
	attacker.killedplayerscurrent[name]++;
	attacker.pers[#"nemesis_tracking"][name] = attacker.pers[#"nemesis_tracking"][name] + 1;
	if(attacker.pers[#"nemesis_name"] == name)
	{
		attacker challenges::killednemesis();
	}
	if(attacker.pers[#"nemesis_name"] == "" || attacker.pers[#"nemesis_tracking"][name] > attacker.pers[#"nemesis_tracking"][attacker.pers[#"nemesis_name"]])
	{
		attacker.pers[#"nemesis_name"] = name;
		attacker.pers[#"nemesis_rank"] = rank;
		attacker.pers[#"nemesis_rankicon"] = prestige;
		attacker.pers[#"nemesis_xp"] = xp;
		attacker.pers[#"nemesis_xuid"] = xuid;
	}
	else if(isdefined(attacker.pers[#"nemesis_name"]) && attacker.pers[#"nemesis_name"] == name)
	{
		attacker.pers[#"nemesis_rank"] = rank;
		attacker.pers[#"nemesis_xp"] = xp;
	}
	pixendevent();
}

/*
	Name: trackattackeedeath
	Namespace: globallogic_score
	Checksum: 0x9CFCA01D
	Offset: 0x1BB0
	Size: 0x394
	Parameters: 5
	Flags: None
*/
function trackattackeedeath(attackername, rank, xp, prestige, xuid)
{
	self endon(#"disconnect");
	waittillframeend();
	pixbeginevent(#"trackattackeedeath");
	if(!isdefined(self.pers[#"killed_by"][attackername]))
	{
		self.pers[#"killed_by"][attackername] = 0;
	}
	self.pers[#"killed_by"][attackername]++;
	if(!isdefined(self.pers[#"nemesis_tracking"][attackername]))
	{
		self.pers[#"nemesis_tracking"][attackername] = 0;
	}
	self.pers[#"nemesis_tracking"][attackername] = self.pers[#"nemesis_tracking"][attackername] + 1.5;
	if(self.pers[#"nemesis_name"] == "" || self.pers[#"nemesis_tracking"][attackername] > self.pers[#"nemesis_tracking"][self.pers[#"nemesis_name"]])
	{
		self.pers[#"nemesis_name"] = attackername;
		self.pers[#"nemesis_rank"] = rank;
		self.pers[#"nemesis_rankicon"] = prestige;
		self.pers[#"nemesis_xp"] = xp;
		self.pers[#"nemesis_xuid"] = xuid;
	}
	else if(isdefined(self.pers[#"nemesis_name"]) && self.pers[#"nemesis_name"] == attackername)
	{
		self.pers[#"nemesis_rank"] = rank;
		self.pers[#"nemesis_xp"] = xp;
	}
	if(self.pers[#"nemesis_name"] == attackername && self.pers[#"nemesis_tracking"][attackername] >= 2)
	{
		self setclientuivisibilityflag("killcam_nemesis", 1);
	}
	else
	{
		self setclientuivisibilityflag("killcam_nemesis", 0);
	}
	pixendevent();
}

/*
	Name: default_iskillboosting
	Namespace: globallogic_score
	Checksum: 0xD2CD2965
	Offset: 0x1F50
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function default_iskillboosting()
{
	return 0;
}

/*
	Name: givekillstats
	Namespace: globallogic_score
	Checksum: 0xACFC716B
	Offset: 0x1F60
	Size: 0x1AC
	Parameters: 3
	Flags: None
*/
function givekillstats(smeansofdeath, weapon, evictim)
{
	self endon(#"disconnect");
	waittillframeend();
	if(level.rankedmatch && self [[level.iskillboosting]]())
	{
		/#
			self iprintlnbold("");
		#/
		return;
	}
	pixbeginevent(#"givekillstats");
	self incpersstat(#"kills", 1, 1, 1);
	self.kills = self getpersstat(#"kills");
	self updatestatratio("kdratio", "kills", "deaths");
	attacker = self;
	if(smeansofdeath == "MOD_HEAD_SHOT")
	{
		attacker thread incpersstat(#"headshots", 1, 1, 0);
		attacker.headshots = attacker.pers[#"headshots"];
		evictim recordkillmodifier("headshot");
	}
	pixendevent();
}

/*
	Name: inctotalkills
	Namespace: globallogic_score
	Checksum: 0xDC74FB1E
	Offset: 0x2118
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function inctotalkills(team)
{
	if(level.teambased && isdefined(level.teams[team]))
	{
		game.totalkillsteam[team]++;
	}
	game.totalkills++;
}

/*
	Name: setinflictorstat
	Namespace: globallogic_score
	Checksum: 0x5C0BFF0D
	Offset: 0x2170
	Size: 0x184
	Parameters: 3
	Flags: None
*/
function setinflictorstat(einflictor, eattacker, weapon)
{
	if(!isdefined(eattacker))
	{
		return;
	}
	if(!isdefined(einflictor))
	{
		eattacker stats::function_e24eec31(weapon, #"hits", 1);
		return;
	}
	if(!isdefined(einflictor.playeraffectedarray))
	{
		einflictor.playeraffectedarray = [];
	}
	foundnewplayer = 1;
	for(i = 0; i < einflictor.playeraffectedarray.size; i++)
	{
		if(einflictor.playeraffectedarray[i] == self)
		{
			foundnewplayer = 0;
			break;
		}
	}
	if(foundnewplayer)
	{
		einflictor.playeraffectedarray[einflictor.playeraffectedarray.size] = self;
		if(weapon == "concussion_grenade" || weapon == "tabun_gas")
		{
			eattacker stats::function_e24eec31(weapon, #"used", 1);
		}
		eattacker stats::function_e24eec31(weapon, #"hits", 1);
	}
}

/*
	Name: processshieldassist
	Namespace: globallogic_score
	Checksum: 0xBC132548
	Offset: 0x2300
	Size: 0x112
	Parameters: 1
	Flags: None
*/
function processshieldassist(killedplayer)
{
	self endon(#"disconnect");
	killedplayer endon(#"disconnect");
	waitframe(1);
	util::waittillslowprocessallowed();
	if(!isdefined(level.teams[self.pers[#"team"]]))
	{
		return;
	}
	if(self.pers[#"team"] == killedplayer.pers[#"team"])
	{
		return;
	}
	if(!level.teambased)
	{
		return;
	}
	self incpersstat(#"assists", 1, 1, 1);
	self.assists = self getpersstat(#"assists");
}

/*
	Name: processassist
	Namespace: globallogic_score
	Checksum: 0xA852E6A6
	Offset: 0x2420
	Size: 0x284
	Parameters: 4
	Flags: None
*/
function processassist(killedplayer, damagedone, weapon, assist_level = undefined)
{
	self endon(#"disconnect");
	killedplayer endon(#"disconnect");
	waitframe(1);
	util::waittillslowprocessallowed();
	if(!isdefined(level.teams[self.pers[#"team"]]))
	{
		return;
	}
	if(self.pers[#"team"] == killedplayer.pers[#"team"])
	{
		return;
	}
	if(!level.teambased)
	{
		return;
	}
	assist_level = "assist";
	assist_level_value = int(ceil(damagedone / 25));
	if(assist_level_value < 1)
	{
		assist_level_value = 1;
	}
	else if(assist_level_value > 3)
	{
		assist_level_value = 3;
	}
	assist_level = assist_level + "_" + assist_level_value * 25;
	self incpersstat(#"assists", 1, 1, 1);
	self.assists = self getpersstat(#"assists");
	switch(weapon.name)
	{
		case "concussion_grenade":
		{
			assist_level = "assist_concussion";
			break;
		}
		case "flash_grenade":
		{
			assist_level = "assist_flash";
			break;
		}
		case "emp_grenade":
		{
			assist_level = "assist_emp";
			break;
		}
		case "proximity_grenade":
		case "proximity_grenade_aoe":
		{
			assist_level = "assist_proximity";
			break;
		}
	}
	self challenges::assisted();
}

