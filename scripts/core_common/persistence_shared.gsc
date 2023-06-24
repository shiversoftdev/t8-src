// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace persistence;

/*
	Name: __init__system__
	Namespace: persistence
	Checksum: 0x6EFA365E
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"persistence", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: persistence
	Checksum: 0x3CCB8AA6
	Offset: 0xE8
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
	Namespace: persistence
	Checksum: 0x9C4BD248
	Offset: 0x118
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.persistentdatainfo = [];
	level.maxrecentstats = 10;
	level.maxhitlocations = 19;
	level thread initialize_stat_tracking();
}

/*
	Name: initialize_stat_tracking
	Namespace: persistence
	Checksum: 0x3AC2ACF8
	Offset: 0x170
	Size: 0x1F2
	Parameters: 0
	Flags: Linked
*/
function initialize_stat_tracking()
{
	level.globalexecutions = 0;
	level.globalchallenges = 0;
	level.globalsharepackages = 0;
	level.globalcontractsfailed = 0;
	level.globalcontractspassed = 0;
	level.globalcontractscppaid = 0;
	level.globalkillstreakscalled = 0;
	level.globalkillstreaksdestroyed = 0;
	level.globalkillstreaksdeathsfrom = 0;
	level.globallarryskilled = 0;
	level.globalbuzzkills = 0;
	level.globalrevives = 0;
	level.globalafterlifes = 0;
	level.globalcomebacks = 0;
	level.globalpaybacks = 0;
	level.globalbackstabs = 0;
	level.globalbankshots = 0;
	level.globalskewered = 0;
	level.globalteammedals = 0;
	level.globalfeetfallen = 0;
	level.globaldistancesprinted = 0;
	level.globaldembombsprotected = 0;
	level.globaldembombsdestroyed = 0;
	level.globalbombsdestroyed = 0;
	level.globalfraggrenadesfired = 0;
	level.globalsatchelchargefired = 0;
	level.globalshotsfired = 0;
	level.globalcrossbowfired = 0;
	level.globalcarsdestroyed = 0;
	level.globalbarrelsdestroyed = 0;
	level.globalbombsdestroyedbyteam = [];
	foreach(team, _ in level.teams)
	{
		level.globalbombsdestroyedbyteam[team] = 0;
	}
}

/*
	Name: adjust_recent_stats
	Namespace: persistence
	Checksum: 0x204B76D1
	Offset: 0x370
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function adjust_recent_stats()
{
	/#
		if(getdvarint(#"scr_writeconfigstrings", 0) == 1 || getdvarint(#"scr_hostmigrationtest", 0) == 1)
		{
			return;
		}
	#/
	initialize_match_stats();
}

/*
	Name: function_acac764e
	Namespace: persistence
	Checksum: 0xCED6923F
	Offset: 0x3F0
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function function_acac764e()
{
	index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
	if(!isdefined(index))
	{
		return;
	}
	if(index < 0 || index > 9)
	{
		return;
	}
	newindex = (index + 1) % 10;
	self.pers[#"hash_76fbbcf94dab5536"] = newindex;
	self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex", newindex);
}

/*
	Name: get_recent_stat
	Namespace: persistence
	Checksum: 0xBC876921
	Offset: 0x4E0
	Size: 0xBA
	Parameters: 3
	Flags: Linked
*/
function get_recent_stat(isglobal, index, statname)
{
	if(!isdefined(index))
	{
		return;
	}
	if(isglobal)
	{
		modename = level.var_12323003;
		return self stats::get_stat(#"gamehistory", modename, #"matchhistory", index, statname);
	}
	return self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname);
}

/*
	Name: set_recent_stat
	Namespace: persistence
	Checksum: 0x5F24855B
	Offset: 0x5A8
	Size: 0x164
	Parameters: 4
	Flags: Linked
*/
function set_recent_stat(isglobal, index, statname, value)
{
	if(!isglobal)
	{
		index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
		if(!isdefined(index))
		{
			return;
		}
		if(index < 0 || index > 9)
		{
			return;
		}
	}
	if(isdefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}
	if(!isdefined(index))
	{
		return;
	}
	if(isglobal)
	{
		modename = level.var_12323003;
		self stats::set_stat(#"gamehistory", modename, #"matchhistory", "" + index, statname, value);
	}
	else
	{
		self stats::set_stat(#"playerstatsbygametype", level.var_12323003, #"prevscores", index, statname, value);
	}
}

/*
	Name: add_recent_stat
	Namespace: persistence
	Checksum: 0x567DA181
	Offset: 0x718
	Size: 0x10C
	Parameters: 4
	Flags: Linked
*/
function add_recent_stat(isglobal, index, statname, value)
{
	if(isdefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}
	if(!isglobal)
	{
		index = self stats::get_stat(#"playerstatsbygametype", level.var_12323003, #"prevscoreindex");
		if(!isdefined(index))
		{
			return;
		}
		if(index < 0 || index > 9)
		{
			return;
		}
	}
	if(!isdefined(index))
	{
		return;
	}
	currstat = get_recent_stat(isglobal, index, statname);
	if(isdefined(currstat))
	{
		set_recent_stat(isglobal, index, statname, currstat + value);
	}
}

/*
	Name: set_match_history_stat
	Namespace: persistence
	Checksum: 0x6E704388
	Offset: 0x830
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function set_match_history_stat(statname, value)
{
	modename = level.var_12323003;
	historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
	set_recent_stat(1, historyindex, statname, value);
}

/*
	Name: add_match_history_stat
	Namespace: persistence
	Checksum: 0x36FF16EE
	Offset: 0x8C0
	Size: 0x84
	Parameters: 2
	Flags: None
*/
function add_match_history_stat(statname, value)
{
	modename = level.var_12323003;
	historyindex = self stats::get_stat(#"gamehistory", modename, #"currentmatchhistoryindex");
	add_recent_stat(1, historyindex, statname, value);
}

/*
	Name: initialize_match_stats
	Namespace: persistence
	Checksum: 0xE60F948
	Offset: 0x950
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function initialize_match_stats()
{
	self endon(#"disconnect");
	if(isdefined(level.nopersistence) && level.nopersistence)
	{
		return;
	}
	if(!level.onlinegame)
	{
		return;
	}
	if(!(level.rankedmatch || level.leaguematch))
	{
		return;
	}
	if(sessionmodeiswarzonegame())
	{
		level waittill(#"game_playing");
		rankid = getrankforxp(self rank::getrankxp());
		self stats::set_stat_global(#"rank", rankid);
		self stats::set_stat_global(#"minxp", rank::getrankinfominxp(rankid));
		self stats::set_stat_global(#"maxxp", rank::getrankinfomaxxp(rankid));
		self stats::set_stat_global(#"lastxp", rank::getrankxpcapped(self.pers[#"rankxp"]));
	}
	if(sessionmodeiswarzonegame() || sessionmodeismultiplayergame())
	{
		self stats::function_bb7eedf0(#"total_games_played", 1);
		if(isdefined(level.hardcoremode) && level.hardcoremode)
		{
			hc_games_played = self stats::get_stat(#"playerstatslist", #"hc_games_played", #"statvalue") + 1;
			self stats::set_stat(#"playerstatslist", #"hc_games_played", #"statvalue", hc_games_played);
		}
	}
	if(isdefined(level.var_12323003))
	{
		self gamehistorystartmatch(level.var_12323003);
	}
	else
	{
		level.var_12323003 = level.gametype;
		self gamehistorystartmatch(getgametypeenumfromname(level.gametype, level.hardcoremode));
	}
}

/*
	Name: codecallback_challengecomplete
	Namespace: persistence
	Checksum: 0xCE15DBCC
	Offset: 0xC80
	Size: 0xA4
	Parameters: 1
	Flags: Event
*/
event codecallback_challengecomplete(eventstruct)
{
	if(sessionmodeiscampaigngame())
	{
		if(isdefined(self.challenge_callback_cp))
		{
			[[self.challenge_callback_cp]](eventstruct.reward, eventstruct.max, eventstruct.row, eventstruct.table_number, eventstruct.challenge_type, eventstruct.item_index, eventstruct.challenge_index);
		}
		return;
	}
	self thread challenge_complete(eventstruct);
}

/*
	Name: function_6020a116
	Namespace: persistence
	Checksum: 0xC9B32547
	Offset: 0xD30
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function function_6020a116()
{
	if(!isdefined(level.var_697b1d55))
	{
		level.var_697b1d55 = 0;
	}
	if(!isdefined(level.var_445b1bca))
	{
		level.var_445b1bca = 0;
	}
	while(level.var_697b1d55 == gettime() || level.var_445b1bca == gettime())
	{
		waitframe(1);
	}
	level.var_697b1d55 = gettime();
}

/*
	Name: challenge_complete
	Namespace: persistence
	Checksum: 0xA9815A48
	Offset: 0xDB0
	Size: 0x61C
	Parameters: 1
	Flags: Linked
*/
function challenge_complete(eventstruct)
{
	self endon(#"disconnect");
	function_6020a116();
	callback::callback(#"on_challenge_complete", eventstruct);
	rewardxp = eventstruct.reward;
	maxval = eventstruct.max;
	row = eventstruct.row;
	tablenumber = eventstruct.table_number;
	challengetype = eventstruct.challenge_type;
	itemindex = eventstruct.item_index;
	challengeindex = eventstruct.challenge_index;
	var_c4e9517b = tablenumber + 1;
	if(currentsessionmode() == 0)
	{
		tablename = (#"gamedata/stats/zm/statsmilestones" + var_c4e9517b) + ".csv";
		if(var_c4e9517b == 2)
		{
			var_a05af556 = tablelookupcolumnforrow(tablename, row, 9);
			if(var_a05af556 === #"")
			{
				return;
			}
			if(getdvarint(#"hash_730fab929626f598", 0) == 0)
			{
				if(var_a05af556 === #"camo_gold" || var_a05af556 === #"camo_diamond" || var_a05af556 === #"camo_darkmatter")
				{
					return;
				}
			}
		}
	}
	else
	{
		tablename = (#"gamedata/stats/mp/statsmilestones" + var_c4e9517b) + ".csv";
	}
	var_eb67c133 = tablelookupcolumnforrow(tablename, row, 5);
	if(var_eb67c133 === #"hash_4a80d584aac2e7d0")
	{
		return;
	}
	/#
		var_54b50d64 = getdvarstring(#"hash_5f6f875e3935912a", "");
		if(var_54b50d64 != "")
		{
			challengecategory = tablelookupcolumnforrow(tablename, row, 16);
			if(isdefined(challengecategory) && challengecategory != var_54b50d64)
			{
				return;
			}
		}
	#/
	self luinotifyevent(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
	self function_b552ffa9(#"challenge_complete", 7, challengeindex, itemindex, challengetype, tablenumber, row, maxval, rewardxp);
	challengetier = int(tablelookupcolumnforrow(tablename, row, 1));
	matchrecordlogchallengecomplete(self, var_c4e9517b, challengetier, itemindex, var_eb67c133);
	/#
		if(getdvarint(#"scr_debugchallenges", 0) != 0)
		{
			challengestring = function_9e72a96(var_eb67c133);
			challengedescstring = challengestring + "";
			challengetiernext = int(tablelookupcolumnforrow(tablename, row + 1, 1));
			tiertext = "" + challengetier;
			herostring = "";
			heroinfo = getunlockableiteminfofromindex(itemindex, 1);
			if(isdefined(heroinfo))
			{
				herostring = heroinfo.displayname;
			}
			if(getdvarint(#"scr_debugchallenges", 0) == 1)
			{
				iprintlnbold((((challengestring + "") + maxval) + "") + herostring);
			}
			else
			{
				if(getdvarint(#"scr_debugchallenges", 0) == 2)
				{
					self iprintlnbold((((challengestring + "") + maxval) + "") + herostring);
				}
				else if(getdvarint(#"scr_debugchallenges", 0) == 3)
				{
					iprintln((((challengestring + "") + maxval) + "") + herostring);
				}
			}
		}
	#/
}

/*
	Name: codecallback_gunchallengecomplete
	Namespace: persistence
	Checksum: 0x882E0FA4
	Offset: 0x13D8
	Size: 0x164
	Parameters: 1
	Flags: Event
*/
event codecallback_gunchallengecomplete(eventstruct)
{
	rewardxp = eventstruct.reward;
	attachmentindex = eventstruct.attachment_index;
	itemindex = eventstruct.item_index;
	rankid = eventstruct.rank_id;
	islastrank = eventstruct.is_lastrank;
	if(sessionmodeiscampaigngame())
	{
		self notify(#"gun_level_complete", {#is_last_rank:islastrank, #rank:rankid, #item_index:itemindex, #attachment_index:attachmentindex, #reward_xp:rewardxp});
		return;
	}
	self luinotifyevent(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
	self function_b552ffa9(#"gun_level_complete", 4, rankid, itemindex, attachmentindex, rewardxp);
}

/*
	Name: upload_stats_soon
	Namespace: persistence
	Checksum: 0x6EA6BE66
	Offset: 0x1548
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function upload_stats_soon()
{
	self notify(#"upload_stats_soon");
	self endon(#"upload_stats_soon", #"disconnect");
	wait(1);
	uploadstats(self);
}

