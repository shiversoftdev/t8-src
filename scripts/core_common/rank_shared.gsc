// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_47fb62300ac0bd60;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace rank;

/*
	Name: function_89f2df9
	Namespace: rank
	Checksum: 0xFB84FD23
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"rank", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: rank
	Checksum: 0xD805E866
	Offset: 0x160
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
}

/*
	Name: init
	Namespace: rank
	Checksum: 0xEE0FF086
	Offset: 0x190
	Size: 0x34C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.scoreinfo = [];
	level.rankxpcap = function_a33811dd();
	level.usingmomentum = 1;
	level.usingscorestreaks = getdvarint(#"scr_scorestreaks", 0) != 0;
	level.scorestreaksmaxstacking = getdvarint(#"scr_scorestreaks_maxstacking", 0);
	level.maxinventoryscorestreaks = getdvarint(#"scr_maxinventory_scorestreaks", 3);
	level.usingrampage = !isdefined(level.usingscorestreaks) || !level.usingscorestreaks;
	level.rampagebonusscale = getdvarfloat(#"scr_rampagebonusscale", 0);
	level.ranktable = [];
	if(sessionmodeiscampaigngame())
	{
		level.xpscale = getdvarfloat(#"scr_xpscalecp", 0);
	}
	else
	{
		if(sessionmodeiszombiesgame())
		{
			level.xpscale = getdvarfloat(#"scr_xpscalezm", 0);
		}
		else
		{
			level.xpscale = getdvarfloat(#"scr_xpscalemp", 0);
		}
	}
	initscoreinfo();
	level.maxrank = int(function_a2f05227());
	level.maxprestige = int(function_29500b6c());
	for(rankid = 0; rankid <= level.maxrank; rankid++)
	{
		level.ranktable[rankid][0] = function_3a2469b8(rankid);
		level.ranktable[rankid][1] = function_a9c3ae72(rankid);
		level.ranktable[rankid][2] = level.ranktable[rankid][1] - level.ranktable[rankid][0];
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: initscoreinfo
	Namespace: rank
	Checksum: 0x91F12470
	Offset: 0x4E8
	Size: 0x656
	Parameters: 0
	Flags: Linked
*/
function initscoreinfo()
{
	scoreinfotablename = scoreevents::getscoreeventtablename(level.gametype);
	var_f0b4da50 = tablelookuprowcount(scoreinfotablename);
	if(sessionmodeismultiplayergame() && var_f0b4da50 === 0)
	{
		scoreinfotablename = #"hash_44588d37c7fe1bf3" + "_base.csv";
		var_f0b4da50 = tablelookuprowcount(scoreinfotablename);
	}
	for(row = 0; row < var_f0b4da50; row++)
	{
		type = tablelookupcolumnforrow(scoreinfotablename, row, 0);
		if(isdefined(type) && type != "")
		{
			labelstring = tablelookupcolumnforrow(scoreinfotablename, row, 9);
			label = undefined;
			if(labelstring != "")
			{
				label = tablelookup(scoreinfotablename, 0, type, 9);
			}
			lp = int(tablelookupcolumnforrow(scoreinfotablename, row, 1));
			xp = int(tablelookupcolumnforrow(scoreinfotablename, row, 2));
			sp = int(tablelookupcolumnforrow(scoreinfotablename, row, 3));
			hs = int(tablelookupcolumnforrow(scoreinfotablename, row, 4));
			res = float(tablelookupcolumnforrow(scoreinfotablename, row, 5));
			var_e775f7ed = tablelookupcolumnforrow(scoreinfotablename, row, 6);
			dp = int(tablelookupcolumnforrow(scoreinfotablename, row, 7));
			is_objective = tablelookupcolumnforrow(scoreinfotablename, row, 8);
			medalname = tablelookupcolumnforrow(scoreinfotablename, row, 11);
			var_812e5448 = tablelookupcolumnforrow(scoreinfotablename, row, 16);
			var_b6593614 = tablelookupcolumnforrow(scoreinfotablename, row, 17);
			var_1a39d14 = tablelookupcolumnforrow(scoreinfotablename, row, 18);
			var_bdbfb0e = tablelookupcolumnforrow(scoreinfotablename, row, 19);
			var_a434fd2d = tablelookupcolumnforrow(scoreinfotablename, row, 20);
			var_f49811d1 = tablelookupcolumnforrow(scoreinfotablename, row, 21);
			var_604c21c7 = tablelookupcolumnforrow(scoreinfotablename, row, 22);
			var_65181181 = int((isdefined(tablelookupcolumnforrow(scoreinfotablename, row, 24)) ? tablelookupcolumnforrow(scoreinfotablename, row, 24) : 0));
			registerscoreinfo(type, row, lp, xp, sp, hs, res, var_e775f7ed, dp, is_objective, label, medalname, var_812e5448, var_b6593614, var_1a39d14, var_bdbfb0e, var_a434fd2d, var_f49811d1, var_604c21c7, var_65181181);
			if(!isdefined(game.scoreinfoinitialized))
			{
				setddlstat = tablelookupcolumnforrow(scoreinfotablename, row, 12);
				addplayerstat = 0;
				if(setddlstat)
				{
					addplayerstat = 1;
				}
				ismedal = 0;
				var_9750677a = tablelookup(scoreinfotablename, 0, type, 10);
				var_9f6af7ed = tablelookup(scoreinfotablename, 0, type, 11);
				if(isdefined(var_9750677a) && var_9750677a != #"" && (isdefined(var_9f6af7ed) && var_9f6af7ed != #""))
				{
					ismedal = 1;
				}
				registerxp(type, xp, addplayerstat, ismedal, dp, row, var_65181181);
			}
		}
	}
	game.scoreinfoinitialized = 1;
}

/*
	Name: getrankxpcapped
	Namespace: rank
	Checksum: 0x83431D00
	Offset: 0xB48
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function getrankxpcapped(inrankxp)
{
	if(isdefined(level.rankxpcap) && level.rankxpcap && level.rankxpcap <= inrankxp)
	{
		return level.rankxpcap;
	}
	return inrankxp;
}

/*
	Name: registerscoreinfo
	Namespace: rank
	Checksum: 0x78CC2557
	Offset: 0xBA0
	Size: 0x748
	Parameters: 20
	Flags: Linked
*/
function registerscoreinfo(type, row, lp, xp, sp, hs, res, var_e775f7ed, dp, is_obj, label, medalname, var_812e5448, var_b6593614, var_1a39d14, var_bdbfb0e, var_a434fd2d, var_f49811d1, var_604c21c7, var_65181181)
{
	overridedvar = (("scr_" + level.gametype) + "_score_") + type;
	if(getdvarstring(overridedvar) != "")
	{
		value = getdvarint(overridedvar, 0);
	}
	if(!sessionmodeismultiplayergame())
	{
		if(isdefined(xp) && xp)
		{
			level.scoreinfo[type][#"xp"] = xp;
		}
	}
	if(isdefined(sp) && sp)
	{
		level.scoreinfo[type][#"sp"] = sp;
	}
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		level.scoreinfo[type][#"row"] = row;
		if(isdefined(lp) && lp)
		{
			level.scoreinfo[type][#"lp"] = lp;
		}
		if(isdefined(hs) && hs)
		{
			level.scoreinfo[type][#"hs"] = hs;
		}
		if(isdefined(res) && res)
		{
			level.scoreinfo[type][#"res"] = res;
		}
		if(isdefined(var_e775f7ed) && var_e775f7ed)
		{
			level.scoreinfo[type][#"hash_4e7be147d773e419"] = var_e775f7ed;
		}
		if(isdefined(dp) && dp)
		{
			level.scoreinfo[type][#"dp"] = dp;
		}
		if(isdefined(is_obj) && is_obj)
		{
			level.scoreinfo[type][#"hash_49b115fae591f06a"] = is_obj;
		}
		if(isdefined(medalname))
		{
			if(type == "kill" || type == "ekia")
			{
				multiplier = getgametypesetting(#"killeventscoremultiplier");
				if(multiplier > 0)
				{
					if(isdefined(level.scoreinfo[type][#"sp"]) && level.scoreinfo[type][#"sp"])
					{
						level.scoreinfo[type][#"sp"] = int(multiplier * level.scoreinfo[type][#"sp"]);
					}
				}
			}
		}
		if(isdefined(label))
		{
			level.scoreinfo[type][#"label"] = label;
		}
		if(isdefined(medalname) && medalname != #"")
		{
			level.scoreinfo[type][#"hash_17ffe407dca54dd7"] = medalname;
		}
		if(var_812e5448 != "")
		{
			level.scoreinfo[type][#"hash_7fe1763a3ac14691"] = var_812e5448;
		}
		if(var_b6593614 != "")
		{
			level.scoreinfo[type][#"hash_401b1493e5188252"] = var_b6593614;
		}
		if(var_1a39d14 != "")
		{
			level.scoreinfo[type][#"hash_251eb53657a5574e"] = var_1a39d14;
		}
		if(var_bdbfb0e != "")
		{
			level.scoreinfo[type][#"hash_294ec6af2b8cb400"] = var_bdbfb0e;
		}
		if(isdefined(var_a434fd2d) && var_a434fd2d)
		{
			level.scoreinfo[type][#"hash_6f22dfa8ea741f95"] = var_a434fd2d;
		}
		if(isdefined(var_f49811d1) && var_f49811d1)
		{
			level.scoreinfo[type][#"hash_7b64eabf26f777c7"] = var_f49811d1;
		}
		if(isdefined(var_604c21c7) && var_604c21c7)
		{
			level.scoreinfo[type][#"hash_505dd55ad702ef6c"] = var_604c21c7;
		}
		if(isdefined(var_65181181) && var_65181181)
		{
			level.scoreinfo[type][#"hash_691aeaca4a1866e3"] = var_65181181;
		}
	}
	else
	{
		if(sessionmodeiscampaigngame())
		{
			if(isdefined(res) && res)
			{
				level.scoreinfo[type][#"res"] = res;
			}
		}
		else if(sessionmodeiszombiesgame())
		{
			if(isdefined(res) && res)
			{
				level.scoreinfo[type][#"res"] = res;
			}
			if(isdefined(label))
			{
				level.scoreinfo[type][#"label"] = label;
			}
		}
	}
}

/*
	Name: function_ca5d4a8
	Namespace: rank
	Checksum: 0xE3CF4583
	Offset: 0x12F0
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_ca5d4a8(type)
{
	return isdefined(level.scoreinfo[type]) && (isdefined(level.scoreinfo[type][#"hash_6f22dfa8ea741f95"]) && level.scoreinfo[type][#"hash_6f22dfa8ea741f95"]);
}

/*
	Name: getscoreinfovalue
	Namespace: rank
	Checksum: 0xE5F320B4
	Offset: 0x1360
	Size: 0x11E
	Parameters: 1
	Flags: Linked
*/
function getscoreinfovalue(type)
{
	playerrole = function_4de41611();
	if(isdefined(level.scoreinfo[type]))
	{
		n_score = (isdefined(level.scoreinfo[type][#"sp"]) ? level.scoreinfo[type][#"sp"] : 0);
		if(isdefined(level.scoremodifiercallback) && isdefined(n_score))
		{
			n_score = [[level.scoremodifiercallback]](type, n_score);
		}
		/#
			var_1eb7c454 = getdvarfloat(#"hash_eae9a8ee387705d", 1);
			n_score = int(n_score * var_1eb7c454);
		#/
		return n_score;
	}
	return 0;
}

/*
	Name: function_4587103
	Namespace: rank
	Checksum: 0x1C77A0B
	Offset: 0x1488
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_4587103(type)
{
	return int(0);
}

/*
	Name: function_4de41611
	Namespace: rank
	Checksum: 0x1B768AAE
	Offset: 0x14B8
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function function_4de41611()
{
	return "prc_mp_slayer";
}

/*
	Name: getscoreinfoposition
	Namespace: rank
	Checksum: 0x586E3D33
	Offset: 0x14D0
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function getscoreinfoposition(type)
{
	playerrole = function_4de41611();
	if(isdefined(level.scoreinfo[type]))
	{
		n_pos = (isdefined(level.scoreinfo[type][#"hash_7c1f7c7897445706"]) ? level.scoreinfo[type][#"hash_7c1f7c7897445706"] : 0);
		if(isdefined(level.scoremodifiercallback) && isdefined(n_pos))
		{
			n_resource = [[level.scoremodifiercallback]](type, n_pos);
		}
		return n_pos;
	}
	return 0;
}

/*
	Name: getscoreinforesource
	Namespace: rank
	Checksum: 0x4646BE7B
	Offset: 0x15A8
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function getscoreinforesource(type)
{
	playerrole = function_4de41611();
	if(isdefined(level.scoreinfo[type]))
	{
		n_resource = (isdefined(level.scoreinfo[type][#"res"]) ? level.scoreinfo[type][#"res"] : 0);
		if(isdefined(level.resourcemodifiercallback) && isdefined(n_resource))
		{
			n_resource = [[level.resourcemodifiercallback]](type, n_resource);
		}
		return n_resource;
	}
	return 0;
}

/*
	Name: getscoreinfoxp
	Namespace: rank
	Checksum: 0xC4B584FF
	Offset: 0x1678
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function getscoreinfoxp(type)
{
	playerrole = function_4de41611();
	if(isdefined(level.scoreinfo[type]))
	{
		n_xp = (isdefined(level.scoreinfo[type][#"xp"]) ? level.scoreinfo[type][#"xp"] : 0);
		if(isdefined(level.xpmodifiercallback) && isdefined(n_xp))
		{
			n_xp = [[level.xpmodifiercallback]](type, n_xp);
		}
		return n_xp;
	}
	return 0;
}

/*
	Name: shouldskipmomentumdisplay
	Namespace: rank
	Checksum: 0x8BF0ADB1
	Offset: 0x1748
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function shouldskipmomentumdisplay(type)
{
	if(isdefined(level.disablemomentum) && level.disablemomentum)
	{
		return true;
	}
	return false;
}

/*
	Name: getscoreinfolabel
	Namespace: rank
	Checksum: 0x39235383
	Offset: 0x1788
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function getscoreinfolabel(type)
{
	return level.scoreinfo[type][#"label"];
}

/*
	Name: getcombatefficiencyevent
	Namespace: rank
	Checksum: 0xA938CAA
	Offset: 0x17C0
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function getcombatefficiencyevent(type)
{
	return level.scoreinfo[type][#"combat_efficiency_event"];
}

/*
	Name: doesscoreinfocounttowardrampage
	Namespace: rank
	Checksum: 0xFACCCA60
	Offset: 0x17F8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function doesscoreinfocounttowardrampage(type)
{
	return isdefined(level.scoreinfo[type][#"rampage"]) && level.scoreinfo[type][#"rampage"];
}

/*
	Name: function_f7b5d9fa
	Namespace: rank
	Checksum: 0x6B83E1C7
	Offset: 0x1850
	Size: 0x84
	Parameters: 1
	Flags: None
*/
function function_f7b5d9fa(type)
{
	playerrole = function_4de41611();
	if(isdefined(level.scoreinfo[type]))
	{
		return true;
	}
	return false;
}

/*
	Name: getrankinfominxp
	Namespace: rank
	Checksum: 0x155E4A72
	Offset: 0x18E0
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function getrankinfominxp(rankid = 0)
{
	rankid = math::clamp(rankid, 0, 54);
	return int(level.ranktable[rankid][0]);
}

/*
	Name: getrankinfomaxxp
	Namespace: rank
	Checksum: 0xAFC815B
	Offset: 0x1948
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function getrankinfomaxxp(rankid = 0)
{
	rankid = math::clamp(rankid, 0, 54);
	return int(level.ranktable[rankid][1]);
}

/*
	Name: getrankinfoxpamt
	Namespace: rank
	Checksum: 0x4E39D3CE
	Offset: 0x19B0
	Size: 0x5A
	Parameters: 1
	Flags: Linked
*/
function getrankinfoxpamt(rankid = 0)
{
	rankid = math::clamp(rankid, 0, 54);
	return int(level.ranktable[rankid][2]);
}

/*
	Name: shouldkickbyrank
	Namespace: rank
	Checksum: 0x3EE29AC6
	Offset: 0x1A18
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function shouldkickbyrank()
{
	if(self ishost())
	{
		return false;
	}
	if(level.rankcap > 0 && self.pers[#"rank"] > level.rankcap)
	{
		return true;
	}
	if(level.rankcap > 0 && level.minprestige == 0 && self.pers[#"plevel"] > 0)
	{
		return true;
	}
	if(level.minprestige > self.pers[#"plevel"])
	{
		return true;
	}
	return false;
}

/*
	Name: getrankxpstat
	Namespace: rank
	Checksum: 0x35501A6F
	Offset: 0x1AF8
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function getrankxpstat()
{
	rankxp = self stats::function_441050ca(#"rankxp", 1);
	if(!isdefined(rankxp))
	{
		return 0;
	}
	rankxpcapped = getrankxpcapped(rankxp);
	if(rankxp > rankxpcapped)
	{
		self stats::function_4db3fba1(#"rankxp", rankxpcapped, 1);
	}
	return rankxpcapped;
}

/*
	Name: getarenapointsstat
	Namespace: rank
	Checksum: 0xB7F553BD
	Offset: 0x1B98
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function getarenapointsstat()
{
	arenaslot = arenagetslot();
	arenapoints = self stats::get_stat(#"arenastats", arenaslot, #"hash_ca4c97bc6c2963b", #"points");
	return arenapoints + 1;
}

/*
	Name: on_player_connect
	Namespace: rank
	Checksum: 0x1FE3EB3E
	Offset: 0x1C10
	Size: 0x94C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self.pers[#"rankxp"] = self getrankxpstat();
	rankid = getrankforxp(self getrankxp());
	self.pers[#"rank"] = rankid;
	self.pers[#"plevel"] = self stats::function_441050ca(#"plevel", 1);
	if(!isdefined(self.pers[#"plevel"]))
	{
		self.pers[#"plevel"] = 0;
	}
	if(self shouldkickbyrank())
	{
		kick(self getentitynumber());
		return;
	}
	if(!isdefined(self.pers[#"participation"]))
	{
		self.pers[#"participation"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipation"]))
	{
		self.pers[#"controllerparticipation"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipationchecks"]))
	{
		self.pers[#"controllerparticipationchecks"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipationchecksskipped"]))
	{
		self.pers[#"controllerparticipationchecksskipped"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipationconsecutivesuccessmax"]))
	{
		self.pers[#"controllerparticipationconsecutivesuccessmax"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipationconsecutivefailuremax"]))
	{
		self.pers[#"controllerparticipationconsecutivefailuremax"] = 0;
	}
	if(!isdefined(self.pers[#"hash_3b7fc8c62a7d4420"]))
	{
		self.pers[#"hash_3b7fc8c62a7d4420"] = 0;
	}
	if(!isdefined(self.pers[#"hash_4a01db5796cf12b1"]))
	{
		self.pers[#"hash_4a01db5796cf12b1"] = #"none";
	}
	if(!isdefined(self.pers[#"controllerparticipationendgameresult"]))
	{
		self.pers[#"controllerparticipationendgameresult"] = -1;
	}
	if(!isdefined(self.pers[#"controllerparticipationinactivitywarnings"]))
	{
		self.pers[#"controllerparticipationinactivitywarnings"] = 0;
	}
	if(!isdefined(self.pers[#"controllerparticipationsuccessafterinactivitywarning"]))
	{
		self.pers[#"controllerparticipationsuccessafterinactivitywarning"] = 0;
	}
	self.rankupdatetotal = 0;
	self.cur_ranknum = rankid;
	/#
		assert(isdefined(self.cur_ranknum), ("" + rankid) + "");
	#/
	prestige = self stats::function_441050ca(#"plevel", 1);
	if(!isdefined(prestige))
	{
		prestige = 0;
	}
	self setrank(rankid, prestige);
	self.pers[#"prestige"] = prestige;
	if(sessionmodeismultiplayergame() && gamemodeisusingstats() || (sessionmodeiszombiesgame() && sessionmodeisonlinegame()))
	{
		paragonrank = self stats::function_441050ca(#"paragon_rank", 1);
		if(!isdefined(paragonrank))
		{
			paragonrank = 0;
		}
		paragonrank = int(min(paragonrank, 1000));
		self setparagonrank(paragonrank);
		self.pers[#"paragonrank"] = paragonrank;
		paragoniconid = self stats::function_441050ca(#"paragon_icon_id", 1);
		if(!isdefined(paragoniconid))
		{
			paragoniconid = 0;
		}
		self setparagoniconid(paragoniconid);
		self.pers[#"paragoniconid"] = paragoniconid;
	}
	if(function_f99d2668())
	{
		self setparagonrank(0);
		self.pers[#"paragonrank"] = 0;
		self setparagoniconid(0);
		self.pers[#"paragoniconid"] = 0;
	}
	if(!isdefined(self.pers[#"summary"]))
	{
		self.pers[#"summary"] = [];
		self.pers[#"summary"][#"xp"] = 0;
		self.pers[#"summary"][#"score"] = 0;
		self.pers[#"summary"][#"challenge"] = 0;
		self.pers[#"summary"][#"match"] = 0;
		self.pers[#"summary"][#"misc"] = 0;
	}
	if(gamemodeismode(6) && !isbot(self))
	{
		arenapoints = self getarenapointsstat();
		arenapoints = int(min(arenapoints, 100));
		self.pers[#"arenapoints"] = arenapoints;
		self setarenapoints(arenapoints);
	}
	self.explosivekills[0] = 0;
	if(level.rankedmatch)
	{
		if(!function_f99d2668())
		{
			self stats::function_4db3fba1(#"rank", rankid, 1);
			self stats::function_4db3fba1(#"minxp", getrankinfominxp(rankid), 1);
			self stats::function_4db3fba1(#"maxxp", getrankinfomaxxp(rankid), 1);
			self stats::function_4db3fba1(#"lastxp", getrankxpcapped(self.pers[#"rankxp"]), 1);
		}
	}
}

/*
	Name: atleastoneplayeroneachteam
	Namespace: rank
	Checksum: 0x4E6A79DA
	Offset: 0x2568
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function atleastoneplayeroneachteam()
{
	foreach(team, _ in level.teams)
	{
		if(!level.playercount[team])
		{
			return false;
		}
	}
	return true;
}

/*
	Name: round_this_number
	Namespace: rank
	Checksum: 0x3C09A6B8
	Offset: 0x25F8
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function round_this_number(value)
{
	value = int(value + 0.5);
	return value;
}

/*
	Name: updaterank
	Namespace: rank
	Checksum: 0x6B23CD8E
	Offset: 0x2638
	Size: 0x208
	Parameters: 0
	Flags: None
*/
function updaterank()
{
	newrankid = self getrank();
	if(newrankid == self.pers[#"rank"])
	{
		return false;
	}
	oldrank = self.pers[#"rank"];
	rankid = self.pers[#"rank"];
	self.pers[#"rank"] = newrankid;
	while(rankid <= newrankid)
	{
		self stats::function_4db3fba1(#"rank", rankid, 1);
		self stats::function_4db3fba1(#"minxp", int(self getrankinfominxp(rankid)), 1);
		self stats::function_4db3fba1(#"maxxp", int(self getrankinfomaxxp(rankid)), 1);
		rankid++;
	}
	/#
		print((((("" + oldrank) + "") + newrankid) + "") + self stats::function_441050ca(#"time_played_total"));
	#/
	self setrank(newrankid);
	return true;
}

/*
	Name: codecallback_rankup
	Namespace: rank
	Checksum: 0xD0F47C62
	Offset: 0x2848
	Size: 0x1D8
	Parameters: 1
	Flags: Event
*/
event codecallback_rankup(eventstruct)
{
	if(sessionmodeismultiplayergame())
	{
		if(eventstruct.rank > 53)
		{
			self giveachievement("mp_trophy_battle_tested");
		}
		if(eventstruct.rank > 8)
		{
			self giveachievement("mp_trophy_welcome_to_the_club");
		}
	}
	self.pers[#"rank"] = eventstruct.rank;
	if(function_f99d2668())
	{
		self stats::function_62b271d8(#"rank", self.pers[#"rank"]);
		self stats::function_62b271d8(#"plevel", self.pers[#"plevel"]);
	}
	else
	{
		self luinotifyevent(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
		self function_b552ffa9(#"rank_up", 3, eventstruct.rank, eventstruct.prestige, eventstruct.unlock_tokens_added);
		if(isdefined(level.playpromotionreaction))
		{
			self thread [[level.playpromotionreaction]]();
		}
	}
}

/*
	Name: getitemindex
	Namespace: rank
	Checksum: 0x5A9DE5E8
	Offset: 0x2A28
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function getitemindex(refstring)
{
	itemindex = getitemindexfromref(refstring);
	/#
		assert(itemindex > 0, (("" + refstring) + "") + itemindex);
	#/
	return itemindex;
}

/*
	Name: endgameupdate
	Namespace: rank
	Checksum: 0x9A3E5AD3
	Offset: 0x2A98
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function endgameupdate()
{
	player = self;
}

/*
	Name: getrank
	Namespace: rank
	Checksum: 0xE37283F3
	Offset: 0x2AB8
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function getrank()
{
	rankxp = getrankxpcapped(self.pers[#"rankxp"]);
	rankid = self.pers[#"rank"];
	if(rankxp < getrankinfominxp(rankid) + getrankinfoxpamt(rankid))
	{
		return rankid;
	}
	return getrankforxp(rankxp);
}

/*
	Name: getspm
	Namespace: rank
	Checksum: 0x61872A64
	Offset: 0x2B68
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function getspm()
{
	if(isarenamode())
	{
		ranklevel = function_a2f05227() + 1;
	}
	else
	{
		ranklevel = self getrank() + 1;
	}
	return (3 + (ranklevel * 0.5)) * 10;
}

/*
	Name: getrankxp
	Namespace: rank
	Checksum: 0x17DB2BBA
	Offset: 0x2BE8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function getrankxp()
{
	return getrankxpcapped(self.pers[#"rankxp"]);
}

/*
	Name: function_bcb5e246
	Namespace: rank
	Checksum: 0xC980AB86
	Offset: 0x2C20
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_bcb5e246(type)
{
	var_920d60e7 = 0;
	if(isdefined(level.scoreinfo[type][#"hash_505dd55ad702ef6c"]))
	{
		var_920d60e7 = level.scoreinfo[type][#"hash_505dd55ad702ef6c"];
	}
	return var_920d60e7;
}

