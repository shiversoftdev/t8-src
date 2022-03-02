// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1f2f7ef27f2aabba;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_75be2950b381443;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\rank_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\util.gsc;

#namespace globallogic_defaults;

/*
	Name: getwinningteamfromloser
	Namespace: globallogic_defaults
	Checksum: 0xDEF64724
	Offset: 0x140
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function getwinningteamfromloser(losing_team)
{
	if(level.multiteam)
	{
		return undefined;
	}
	return util::getotherteam(losing_team);
}

/*
	Name: default_onforfeit
	Namespace: globallogic_defaults
	Checksum: 0x5B0F49E
	Offset: 0x180
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function default_onforfeit(params)
{
	level.gameforfeited = 1;
	level notify(#"hash_7c63ed1f465e8e8e");
	level endon(#"hash_7c63ed1f465e8e8e", #"hash_39a00a79045884ca");
	forfeit_delay = 20;
	announcement(game.strings[#"opponent_forfeiting_in"], forfeit_delay, 0);
	wait(10);
	announcement(game.strings[#"opponent_forfeiting_in"], 10, 0);
	wait(10);
	if(!isdefined(params))
	{
		round::function_d1e740f6(level.players[0]);
	}
	else
	{
		if(platoons::function_382a49e0() && params.var_b2ee6c67.size)
		{
			round::function_35702443(params.var_b2ee6c67[0]);
		}
		if(params.var_6eb69269.size)
		{
			round::function_d1e740f6(params.var_6eb69269[0]);
		}
	}
	level.forcedend = 1;
	round::set_flag("force_end");
	thread globallogic::end_round(7);
}

/*
	Name: default_ondeadevent
	Namespace: globallogic_defaults
	Checksum: 0xFC770032
	Offset: 0x348
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function default_ondeadevent(team)
{
	var_2e0d5506 = round::function_9b24638f();
	if(isdefined(var_2e0d5506) && var_2e0d5506 != #"free")
	{
		return;
	}
	if(isdefined(level.teams[team]))
	{
		round::function_d1e740f6(getwinningteamfromloser(team));
		thread globallogic::end_round(6);
	}
	else
	{
		round::set_flag("tie");
		thread globallogic::end_round(6);
	}
}

/*
	Name: function_dcf41142
	Namespace: globallogic_defaults
	Checksum: 0x7EA93F66
	Offset: 0x430
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_dcf41142(params)
{
	if(gamestate::is_game_over())
	{
		return;
	}
	if(infection::function_74650d7() && platoons::function_382a49e0() && params.var_dfa2cc2c.size)
	{
		round::function_af2e264f(params.var_dfa2cc2c[0]);
	}
	else
	{
		if(platoons::function_382a49e0() && params.platoons_alive.size)
		{
			round::function_35702443(params.platoons_alive[0]);
		}
		else
		{
			if(params.teams_alive.size && isdefined(level.teams[params.teams_alive[0]]))
			{
				round::function_af2e264f(params.teams_alive[0]);
			}
			else
			{
				round::set_flag("tie");
			}
		}
	}
	thread globallogic::end_round(6);
}

/*
	Name: function_daa7e9d5
	Namespace: globallogic_defaults
	Checksum: 0x571EE84B
	Offset: 0x5A0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_daa7e9d5()
{
	level callback::remove_callback(#"hash_84d8c1164d90313", &function_dcf41142);
}

/*
	Name: default_onalivecountchange
	Namespace: globallogic_defaults
	Checksum: 0x2B6C3193
	Offset: 0x5E0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function default_onalivecountchange(team)
{
}

/*
	Name: onendgame
	Namespace: globallogic_defaults
	Checksum: 0x4DBB18B5
	Offset: 0x5F8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function onendgame(var_c1e98979)
{
	if(level.scoreroundwinbased)
	{
		globallogic_score::updateteamscorebyroundswon();
	}
	match::function_af2e264f(match::function_6d0354e3());
}

/*
	Name: default_ononeleftevent
	Namespace: globallogic_defaults
	Checksum: 0x9E9371C0
	Offset: 0x658
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function default_ononeleftevent(team)
{
	if(!level.teambased)
	{
		round::function_d1e740f6(globallogic_score::gethighestscoringplayer());
		thread globallogic::end_round(6);
	}
	else
	{
		foreach(player in level.players)
		{
			if(!isalive(player))
			{
				continue;
			}
			if(!isdefined(player.pers[#"team"]) || player.pers[#"team"] != team)
			{
				continue;
			}
			player globallogic_audio::leader_dialog_on_player("sudden_death");
		}
	}
}

/*
	Name: default_ontimelimit
	Namespace: globallogic_defaults
	Checksum: 0xD1678E43
	Offset: 0x7A0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function default_ontimelimit()
{
	round::function_870759fb();
	thread globallogic::end_round(2);
}

/*
	Name: default_onscorelimit
	Namespace: globallogic_defaults
	Checksum: 0x6DC02C2A
	Offset: 0x7D8
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function default_onscorelimit()
{
	if(!level.endgameonscorelimit)
	{
		return false;
	}
	round::function_870759fb();
	thread globallogic::end_round(3);
	return true;
}

/*
	Name: default_onroundscorelimit
	Namespace: globallogic_defaults
	Checksum: 0xB0F5B1B7
	Offset: 0x828
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function default_onroundscorelimit()
{
	round::function_870759fb();
	param1 = 4;
	thread globallogic::end_round(param1);
	return true;
}

/*
	Name: default_onspawnspectator
	Namespace: globallogic_defaults
	Checksum: 0x79C854DD
	Offset: 0x870
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function default_onspawnspectator(origin, angles)
{
	if(isdefined(origin) && isdefined(angles))
	{
		self spawn(origin, angles);
		return;
	}
	spawnpoints = spawning::get_spawnpoint_array("mp_global_intermission");
	/#
		assert(spawnpoints.size, "");
	#/
	spawnpoint = spawning::get_spawnpoint_random(spawnpoints);
	self spawn(spawnpoint.origin, spawnpoint.angles);
}

/*
	Name: default_onspawnintermission
	Namespace: globallogic_defaults
	Checksum: 0x8B9B417F
	Offset: 0x958
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function default_onspawnintermission(endgame)
{
	if(isdefined(endgame) && endgame)
	{
		return;
	}
	spawnpoint = spawning::get_random_intermission_point();
	if(isdefined(spawnpoint))
	{
		self spawn(spawnpoint.origin, spawnpoint.angles);
	}
	else
	{
		/#
			util::error("");
		#/
	}
}

/*
	Name: default_gettimelimit
	Namespace: globallogic_defaults
	Checksum: 0xA8B7C23C
	Offset: 0x9F8
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function default_gettimelimit()
{
	/#
		if((getdvarfloat(#"hash_5424bc2a81bcb188", -1)) != -1)
		{
			return math::clamp(getdvarfloat(#"hash_5424bc2a81bcb188", -1), level.timelimitmin, level.timelimitmax);
		}
	#/
	return math::clamp(getgametypesetting(#"timelimit"), level.timelimitmin, level.timelimitmax);
}

/*
	Name: default_getteamkillpenalty
	Namespace: globallogic_defaults
	Checksum: 0x1EC67370
	Offset: 0xAC0
	Size: 0x6C
	Parameters: 4
	Flags: Linked
*/
function default_getteamkillpenalty(einflictor, attacker, smeansofdeath, weapon)
{
	teamkill_penalty = 1;
	if(killstreaks::is_killstreak_weapon(weapon))
	{
		teamkill_penalty = teamkill_penalty * killstreaks::get_killstreak_team_kill_penalty_scale(weapon);
	}
	return teamkill_penalty;
}

/*
	Name: default_getteamkillscore
	Namespace: globallogic_defaults
	Checksum: 0x6210232E
	Offset: 0xB38
	Size: 0x42
	Parameters: 4
	Flags: Linked
*/
function default_getteamkillscore(einflictor, attacker, smeansofdeath, weapon)
{
	return attacker rank::getscoreinfovalue("team_kill");
}

/*
	Name: get_alive_players
	Namespace: globallogic_defaults
	Checksum: 0x8DD910AE
	Offset: 0xB88
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function get_alive_players(players)
{
	alive_players = [];
	foreach(player in players)
	{
		if(player == self)
		{
			continue;
		}
		if(!isalive(player))
		{
			continue;
		}
		if(!isdefined(alive_players))
		{
			alive_players = [];
		}
		else if(!isarray(alive_players))
		{
			alive_players = array(alive_players);
		}
		alive_players[alive_players.size] = player;
	}
	return alive_players;
}

/*
	Name: function_108c4b65
	Namespace: globallogic_defaults
	Checksum: 0xFE56083F
	Offset: 0xC90
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_108c4b65()
{
	if(platoons::function_382a49e0())
	{
		teammates = getplayers(self.team);
		var_2927adba = get_alive_players(teammates);
		if(var_2927adba.size)
		{
			return var_2927adba[0];
		}
		platoon = function_22448d6c(self.team);
		var_bf97e486 = platoons::function_a214d798(platoon);
		return spectating::function_18b8b7e4(var_bf97e486, self.origin);
	}
}

