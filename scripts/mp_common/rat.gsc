// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2255a7ad3edc838f;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\rat_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\dev.gsc;
#using scripts\mp_common\util.gsc;

#namespace rat;

/*
	Name: function_89f2df9
	Namespace: rat
	Checksum: 0x4631C421
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	/#
		system::register(#"rat", &__init__, undefined, undefined);
	#/
}

/*
	Name: __init__
	Namespace: rat
	Checksum: 0xEACFF6BE
	Offset: 0xE8
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function __init__()
{
	/#
		init();
		level.rat.common.gethostplayer = &util::gethostplayer;
		level.rat.deathcount = 0;
		addratscriptcmd("", &rscaddenemy);
		addratscriptcmd("", &function_50634409);
		setdvar(#"rat_death_count", 0);
	#/
}

/*
	Name: function_50634409
	Namespace: rat
	Checksum: 0xA1A21985
	Offset: 0x1B8
	Size: 0x11E
	Parameters: 1
	Flags: None
*/
function function_50634409(params)
{
	/#
		player = util::gethostplayerforbots();
		setdvar(#"bot_allowmovement", 0);
		setdvar(#"bot_pressattackbtn", 0);
		setdvar(#"bot_pressmeleebtn", 0);
		setdvar(#"scr_botsallowkillstreaks", 0);
		setdvar(#"bot_allowgrenades", 0);
		team = bot::devgui_relative_team(player, "");
		bot = level bot::add_bot(team);
	#/
}

/*
	Name: rscaddenemy
	Namespace: rat
	Checksum: 0xCAE1A9F7
	Offset: 0x2E0
	Size: 0x254
	Parameters: 1
	Flags: None
*/
function rscaddenemy(params)
{
	/#
		player = [[level.rat.common.gethostplayer]]();
		team = #"axis";
		if(isdefined(player.pers[#"team"]))
		{
			team = util::getotherteam(player.pers[#"team"]);
		}
		bot = dev::getormakebot(team);
		if(!isdefined(bot))
		{
			println("");
			ratreportcommandresult(params._id, 0, "");
			return;
		}
		bot thread testenemy(team);
		bot thread deathcounter();
		wait(2);
		pos = (float(params.x), float(params.y), float(params.z));
		bot setorigin(pos);
		if(isdefined(params.ax))
		{
			angles = (float(params.ax), float(params.ay), float(params.az));
			bot setplayerangles(angles);
		}
		ratreportcommandresult(params._id, 1);
	#/
}

/*
	Name: testenemy
	Namespace: rat
	Checksum: 0x436AB6BA
	Offset: 0x540
	Size: 0xF4
	Parameters: 1
	Flags: None
*/
function testenemy(team)
{
	/#
		self endon(#"disconnect");
		while(!isdefined(self.pers[#"team"]))
		{
			waitframe(1);
		}
		if(level.teambased)
		{
			params = {#intpayload:0, #response:level.teams[team], #menu:game.menu[#"menu_team"]};
			self notify(#"menuresponse", params);
			self callback::callback(#"hash_4e1a50a35ec44bcc", params);
		}
	#/
}

/*
	Name: deathcounter
	Namespace: rat
	Checksum: 0xF387974B
	Offset: 0x640
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function deathcounter()
{
	/#
		self waittill(#"death");
		level.rat.deathcount++;
		setdvar(#"rat_death_count", level.rat.deathcount);
	#/
}

