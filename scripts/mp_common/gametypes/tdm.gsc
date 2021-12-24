// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_229f24b1662651c4;
#using script_2c49ae69cd8ce30c;
#using script_3f27a7b2232674db;
#using script_4c8dba49908aecc2;
#using script_6c8abe14025b47c4;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\bb.gsc;
#using scripts\mp_common\gametypes\dogtags.gsc;
#using scripts\mp_common\gametypes\gametype.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;
#using scripts\mp_common\util.gsc;

#namespace tdm;

/*
	Name: main
	Namespace: tdm
	Checksum: 0xD124A8FE
	Offset: 0x1D0
	Size: 0x35E
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	globallogic::init();
	util::registerroundswitch(0, 9);
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundscorelimit(0, 10000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	globallogic::registerfriendlyfiredelay(level.gametype, 15, 0, 1440);
	level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
	level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
	level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
	level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
	level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
	level.overrideteamscore = 1;
	level.takelivesondeath = 1;
	level.onstartgametype = &onstartgametype;
	level.onspawnplayer = &onspawnplayer;
	level.onroundswitch = &onroundswitch;
	level.var_f6d301b = &function_f6d301b;
	level.var_cdb8ae2c = &function_a8da260c;
	player::function_cf3aa03d(&onplayerkilled);
	globallogic_audio::set_leader_gametype_dialog("startTeamDeathmatch", "hcStartTeamDeathmatch", "gameBoost", "gameBoost", "bbStartTeamDeathmatch", "hcbbStartTeamDeathmatch");
	globallogic_spawn::addsupportedspawnpointtype("tdm");
	if(util::function_8570168d())
	{
		namespace_9096c917::init();
	}
	if(getdvarint(#"hash_5795d85dc4b1b0d9", 0))
	{
		level.var_49a15413 = getdvarint(#"hash_5795d85dc4b1b0d9", 0);
		level.scoremodifiercallback = &function_f9df98d3;
	}
}

/*
	Name: function_a8da260c
	Namespace: tdm
	Checksum: 0xDD03835C
	Offset: 0x538
	Size: 0xEC
	Parameters: 0
	Flags: None
*/
function function_a8da260c()
{
	foreach(team, _ in level.teams)
	{
		spawning::add_spawn_points(team, "mp_tdm_spawn");
		spawning::place_spawn_points(spawning::gettdmstartspawnname(team));
		spawning::add_start_spawn_points(team, spawning::gettdmstartspawnname(team));
	}
	spawning::updateallspawnpoints();
}

/*
	Name: onstartgametype
	Namespace: tdm
	Checksum: 0x99D016F8
	Offset: 0x630
	Size: 0xBA
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
	level.displayroundendtext = 0;
	level thread onscoreclosemusic();
	if(!util::isoneround())
	{
		level.displayroundendtext = 1;
		if(level.scoreroundwinbased)
		{
			globallogic_score::resetteamscores();
		}
	}
	if(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn)
	{
		level.numlives = 1;
	}
	if(util::function_8570168d())
	{
		level.playgadgetready = undefined;
	}
}

/*
	Name: onspawnplayer
	Namespace: tdm
	Checksum: 0x52E1D7FE
	Offset: 0x6F8
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function onspawnplayer(predictedspawn)
{
	self.usingobj = undefined;
	if(level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn)
	{
		level.usestartspawns = 0;
	}
	spawning::onspawnplayer(predictedspawn);
}

/*
	Name: onroundswitch
	Namespace: tdm
	Checksum: 0x594955FF
	Offset: 0x768
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function onroundswitch()
{
	gametype::on_round_switch();
	globallogic_score::updateteamscorebyroundswon();
}

/*
	Name: function_f6d301b
	Namespace: tdm
	Checksum: 0x73B850F6
	Offset: 0x798
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_f6d301b(var_c1e98979)
{
	function_e596b745(var_c1e98979);
}

/*
	Name: onscoreclosemusic
	Namespace: tdm
	Checksum: 0x22F27D4
	Offset: 0x7C8
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function onscoreclosemusic()
{
	teamscores = [];
	while(!level.gameended)
	{
		scorelimit = level.scorelimit;
		scorethreshold = scorelimit * 0.1;
		scorethresholdstart = abs(scorelimit - scorethreshold);
		scorelimitcheck = scorelimit - 10;
		topscore = 0;
		runnerupscore = 0;
		foreach(team, _ in level.teams)
		{
			score = [[level._getteamscore]](team);
			if(score > topscore)
			{
				runnerupscore = topscore;
				topscore = score;
				continue;
			}
			if(score > runnerupscore)
			{
				runnerupscore = score;
			}
		}
		scoredif = topscore - runnerupscore;
		if(topscore >= (scorelimit * 0.5))
		{
			level notify(#"sndmusichalfway");
			return;
		}
		wait(1);
	}
}

/*
	Name: onplayerkilled
	Namespace: tdm
	Checksum: 0x3D8BB1CF
	Offset: 0x978
	Size: 0x224
	Parameters: 9
	Flags: None
*/
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(smeansofdeath == "MOD_META")
	{
		return;
	}
	if(isdefined(level.droppedtagrespawn) && level.droppedtagrespawn)
	{
		thread dogtags::checkallowspectating();
		should_spawn_tags = self dogtags::should_spawn_tags(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		should_spawn_tags = should_spawn_tags && !globallogic_spawn::mayspawn();
		if(should_spawn_tags)
		{
			level thread dogtags::spawn_dog_tag(self, attacker, &dogtags::onusedogtag, 0);
		}
	}
	if(isplayer(attacker) == 0 || attacker.team == self.team)
	{
		return;
	}
	if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
	{
		attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperkill);
		self globallogic_score::giveteamscoreforobjective(self.team, level.teamscoreperdeath * -1);
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			attacker globallogic_score::giveteamscoreforobjective(attacker.team, level.teamscoreperheadshot);
		}
	}
}

/*
	Name: function_e596b745
	Namespace: tdm
	Checksum: 0x6539D9E3
	Offset: 0xBA8
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function function_e596b745(var_c1e98979)
{
	var_1e866967 = spawnstruct();
	var_1e866967.remainingtime = max(0, globallogic_utils::gettimeremaining());
	switch(var_c1e98979)
	{
		case 2:
		{
			var_1e866967.wintype = "time_limit_reached";
			break;
		}
		case 3:
		{
			var_1e866967.wintype = "score_limit_reached";
			break;
		}
		case 9:
		case 10:
		default:
		{
			var_1e866967.wintype = "NA";
			break;
		}
	}
	bb::function_bf5cad4e(var_1e866967);
}

/*
	Name: function_f9df98d3
	Namespace: tdm
	Checksum: 0x89C887C7
	Offset: 0xCC8
	Size: 0x3E
	Parameters: 2
	Flags: None
*/
function function_f9df98d3(type, value)
{
	if(type === #"ekia")
	{
		return value + level.var_49a15413;
	}
	return value;
}

