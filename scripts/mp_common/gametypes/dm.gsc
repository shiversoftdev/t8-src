// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c49ae69cd8ce30c;
#using script_4c8dba49908aecc2;
#using script_6c8abe14025b47c4;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\util.gsc;

#namespace dm;

/*
	Name: main
	Namespace: dm
	Checksum: 0xB8D3EF01
	Offset: 0x160
	Size: 0x294
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	globallogic::init();
	util::registertimelimit(0, 1440);
	util::registerscorelimit(0, 50000);
	util::registerroundlimit(0, 10);
	util::registerroundwinlimit(0, 10);
	util::registernumlives(0, 100);
	globallogic::registerfriendlyfiredelay(level.gametype, 0, 0, 1440);
	level.scoreroundwinbased = getgametypesetting(#"cumulativeroundscores") == 0;
	level.teamscoreperkill = getgametypesetting(#"teamscoreperkill");
	level.teamscoreperdeath = getgametypesetting(#"teamscoreperdeath");
	level.teamscoreperheadshot = getgametypesetting(#"teamscoreperheadshot");
	level.killstreaksgivegamescore = getgametypesetting(#"killstreaksgivegamescore");
	level.onstartgametype = &onstartgametype;
	player::function_cf3aa03d(&onplayerkilled);
	level.onspawnplayer = &onspawnplayer;
	level.onendgame = &onendgame;
	level.var_cdb8ae2c = &function_a8da260c;
	globallogic_spawn::addsupportedspawnpointtype("ffa");
	globallogic_audio::set_leader_gametype_dialog("startFreeForAll", "hcStartFreeForAll", "gameBoost", "gameBoost", "bbStartFreeForAll", "hcbbStartFreeForAll");
	if(util::function_8570168d())
	{
		level.var_eedd99ab = 1;
		namespace_9096c917::init();
	}
}

/*
	Name: function_a8da260c
	Namespace: dm
	Checksum: 0x9ECF058C
	Offset: 0x400
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_a8da260c()
{
	foreach(team, _ in level.teams)
	{
		spawning::add_spawn_points(team, "mp_dm_spawn");
	}
	spawning::place_spawn_points("mp_dm_spawn_start");
	spawning::updateallspawnpoints();
}

/*
	Name: setupteam
	Namespace: dm
	Checksum: 0x8D144CDC
	Offset: 0x4C0
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function setupteam(team)
{
}

/*
	Name: onstartgametype
	Namespace: dm
	Checksum: 0x65EDACAE
	Offset: 0x4D8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function onstartgametype()
{
	level.displayroundendtext = 0;
	level thread onscoreclosemusic();
	if(!util::isoneround())
	{
		level.displayroundendtext = 1;
	}
	globallogic_spawn::addspawns();
}

/*
	Name: onendgame
	Namespace: dm
	Checksum: 0xAAC0B90A
	Offset: 0x548
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function onendgame(var_c1e98979)
{
	player = round::function_b5f4c9d8();
	if(isdefined(player))
	{
		[[level._setplayerscore]](player, [[level._getplayerscore]](player) + 1);
	}
	match::function_d1e740f6(player);
}

/*
	Name: onscoreclosemusic
	Namespace: dm
	Checksum: 0x7C88148F
	Offset: 0x5C8
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function onscoreclosemusic()
{
	while(!level.gameended)
	{
		scorelimit = level.scorelimit;
		scorethreshold = scorelimit * 0.9;
		for(i = 0; i < level.players.size; i++)
		{
			scorecheck = [[level._getplayerscore]](level.players[i]);
			if(scorecheck >= scorethreshold)
			{
				return;
			}
		}
		wait(0.5);
	}
}

/*
	Name: onspawnplayer
	Namespace: dm
	Checksum: 0xE9CAB3CF
	Offset: 0x680
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function onspawnplayer(predictedspawn)
{
	if(!level.inprematchperiod)
	{
		level.usestartspawns = 0;
	}
	spawning::onspawnplayer(predictedspawn);
}

/*
	Name: onplayerkilled
	Namespace: dm
	Checksum: 0xA5512857
	Offset: 0x6C8
	Size: 0x124
	Parameters: 9
	Flags: Linked
*/
function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(!isplayer(attacker) || self == attacker)
	{
		return;
	}
	if(!isdefined(killstreaks::get_killstreak_for_weapon(weapon)) || (isdefined(level.killstreaksgivegamescore) && level.killstreaksgivegamescore))
	{
		attacker globallogic_score::givepointstowin(level.teamscoreperkill);
		self globallogic_score::givepointstowin(level.teamscoreperdeath * -1);
		if(smeansofdeath == "MOD_HEAD_SHOT")
		{
			attacker globallogic_score::givepointstowin(level.teamscoreperheadshot);
		}
	}
}

