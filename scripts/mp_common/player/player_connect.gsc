// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gamerep.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\player\player_monitor.gsc;
#using scripts\mp_common\player\player_record.gsc;
#using scripts\mp_common\player\player_killed.gsc;
#using scripts\mp_common\player\player.gsc;
#using scripts\mp_common\gametypes\menus.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\globallogic_ui.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;
#using scripts\mp_common\gametypes\globallogic_score.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\persistence_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\high_value_operative.gsc;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\bb_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace player;

/*
	Name: callback_playerconnect
	Namespace: player
	Checksum: 0x81DEA454
	Offset: 0x240
	Size: 0x12BC
	Parameters: 0
	Flags: Linked
*/
function callback_playerconnect()
{
	thread function_3bd86b5d();
	self.statusicon = "$default";
	self waittill(#"begin");
	if(isdefined(level.reset_clientdvars))
	{
		self [[level.reset_clientdvars]]();
	}
	waittillframeend();
	self.statusicon = "";
	self.guid = self getguid();
	self.killstreak = [];
	self.leaderdialogqueue = [];
	self.killstreakdialogqueue = [];
	self.timeplayed = [];
	self.hits = 0;
	self.var_2641e022 = 0;
	self.var_a7d7e50a = 0;
	if(!isdefined(self.pers[#"roundjoined"]))
	{
		self.pers[#"roundjoined"] = (isdefined(game.roundsplayed) ? game.roundsplayed : 0);
	}
	profilelog_begintiming(4, "ship");
	level notify(#"connected", {#player:self});
	callback::callback(#"on_player_connect");
	if(self ishost())
	{
		self thread globallogic::listenforgameend();
	}
	if(!level.splitscreen && !isdefined(self.pers[#"score"]))
	{
		if(!sessionmodeiswarzonegame())
		{
			iprintln(#"mp/connected", self);
		}
	}
	function_db0c0406();
	self gamerep::gamerepplayerconnected();
	lpselfnum = self getentitynumber();
	lpguid = self getguid();
	lpxuid = self getxuid(1);
	bb::function_afcc007d(self.name, lpselfnum, lpxuid);
	recordplayerstats(self, "code_client_num", lpselfnum);
	if(!sessionmodeiszombiesgame())
	{
		self setclientuivisibilityflag("hud_visible", 1);
		self setclientuivisibilityflag("weapon_hud_visible", 1);
	}
	self setclientplayersprinttime(level.playersprinttime);
	self setclientnumlives(level.numlives);
	if(level.hardcoremode)
	{
		self setclientdrawtalk(3);
	}
	self function_efa6e25f();
	self.teamkillpunish = 0;
	if(level.minimumallowedteamkills >= 0 && self.pers[#"teamkills_nostats"] > level.minimumallowedteamkills)
	{
		self thread function_a932bf9c();
	}
	self.killedplayerscurrent = [];
	if(self.team != #"spectator" && util::isfirstround())
	{
		if(isdefined(level.draftstage) && level.draftstage >= 6)
		{
			self thread globallogic_audio::set_music_on_player("none");
		}
		else
		{
			if(game.state != "playing")
			{
				self thread globallogic_audio::set_music_on_player("spawnPreLoop");
			}
			else
			{
				self thread globallogic_audio::set_music_on_player("none");
			}
		}
	}
	else
	{
		self thread globallogic_audio::set_music_on_player("none");
	}
	self.lastkilltime = 0;
	self.cur_death_streak = 0;
	self disabledeathstreak();
	self.gametype_kill_streak = 0;
	self.var_b6f732c0 = 0;
	self.spawnqueueindex = -1;
	if(!isdefined(self.pers[#"deathtime"]))
	{
		self.pers[#"deathtime"] = 0;
	}
	self.deathtime = self.pers[#"deathtime"];
	self.class_num = 0;
	self.alivetimes = [];
	for(index = 0; index < level.alivetimemaxcount; index++)
	{
		self.alivetimes[index] = 0;
	}
	self.alivetimecurrentindex = 0;
	if(level.onlinegame && (!(isdefined(level.freerun) && level.freerun)))
	{
		self.gametype_kill_streak = self stats::function_ed81f25e(#"kill_streak");
		self.var_b6f732c0 = self stats::get_stat_global(#"longest_killstreak");
		if(!isdefined(self.gametype_kill_streak))
		{
			self.gametype_kill_streak = 0;
		}
		if(!isdefined(self.var_b6f732c0))
		{
			self.var_b6f732c0 = 0;
		}
	}
	self.lastgrenadesuicidetime = -1;
	self.teamkillsthisround = 0;
	if(!isdefined(level.livesdonotreset) || !level.livesdonotreset || !isdefined(self.pers[#"lives"]))
	{
		self.pers[#"lives"] = level.numlives;
	}
	if(!level.teambased)
	{
		self.pers[#"team"] = undefined;
	}
	init_heal(1, 0);
	self.hasspawned = 0;
	self.waitingtospawn = 0;
	self.wantsafespawn = 0;
	self.deathcount = 0;
	self.wasaliveatmatchstart = 0;
	level.players[level.players.size] = self;
	if(level.splitscreen)
	{
		setdvar(#"splitscreen_playernum", level.players.size);
	}
	if(gamestate::is_game_over())
	{
		self.pers[#"needteam"] = 1;
		self.pers[#"team"] = #"spectator";
		self.team = self.sessionteam;
		self setclientuivisibilityflag("hud_visible", 0);
		self [[level.spawnintermission]]();
		self closeingamemenu();
		profilelog_endtiming(4, "gs=" + game.state);
		return;
	}
	if(level.rankedmatch || level.leaguematch && !isdefined(self.pers[#"lossalreadyreported"]))
	{
		globallogic_score::updatelossstats(self);
		self.pers[#"lossalreadyreported"] = 1;
	}
	if(level.rankedmatch || level.leaguematch && !isdefined(self.pers[#"latejoin"]))
	{
		if(game.state == "playing" || self.pers[#"roundjoined"] > 0)
		{
			self.pers[#"latejoin"] = 1;
		}
		else
		{
			self.pers[#"latejoin"] = 0;
		}
	}
	if(!isdefined(self.pers[#"winstreakalreadycleared"]))
	{
		self globallogic_score::backupandclearwinstreaks();
		self.pers[#"winstreakalreadycleared"] = 1;
	}
	if(self istestclient())
	{
		recordplayerstats(self, "is_bot", 1);
	}
	level endon(#"game_ended");
	if(isdefined(level.hostmigrationtimer))
	{
		self thread hostmigration::hostmigrationtimerthink();
	}
	if(isdefined(self.pers[#"team"]))
	{
		self.team = self.pers[#"team"];
	}
	if(isdefined(self.pers[#"class"]))
	{
		self.curclass = self.pers[#"class"];
	}
	if(!isdefined(self.pers[#"team"]) || isdefined(self.pers[#"needteam"]))
	{
		var_4c542e39 = getassignedteamname(self);
		/#
			var_b417b3ee = getdvarstring(#"scr_playerteams", "");
			playerteams = strtok(var_b417b3ee, "");
			if(playerteams.size > 0)
			{
				playerteam = playerteams[self getentitynumber()];
				if(isdefined(playerteam) && isdefined(level.teams[playerteam]))
				{
					var_4c542e39 = playerteam;
				}
			}
		#/
		self.pers[#"needteam"] = undefined;
		self.pers[#"team"] = #"spectator";
		self.team = #"spectator";
		self.sessionteam = #"spectator";
		self.sessionstate = "dead";
		self globallogic_ui::updateobjectivetext();
		[[level.spawnspectator]]();
		[[level.autoassign]](0, var_4c542e39);
		if(level.rankedmatch || level.leaguematch && level.var_30408f96 !== 1)
		{
			self thread globallogic_spawn::kickifdontspawn();
		}
		if(self.pers[#"team"] == #"spectator")
		{
			self.sessionteam = #"spectator";
			self thread spectate_player_watcher();
		}
		if(level.teambased)
		{
			self.sessionteam = self.pers[#"team"];
			if(!isalive(self))
			{
				self.statusicon = "hud_status_dead";
			}
			self thread spectating::set_permissions();
		}
		init_character_index();
	}
	else
	{
		if(self.pers[#"team"] == #"spectator")
		{
			[[level.spawnspectator]]();
			self.sessionteam = #"spectator";
			self.sessionstate = "spectator";
			self thread spectate_player_watcher();
		}
		else
		{
			self.sessionteam = self.pers[#"team"];
			self.sessionstate = "dead";
			self globallogic_ui::updateobjectivetext();
			[[level.spawnspectator]]();
			init_character_index();
			if(!draft::is_draft_this_round())
			{
				if(globallogic_utils::isvalidclass(self.pers[#"class"]) && player_role::is_valid(self player_role::get()))
				{
					self thread [[level.spawnclient]]();
				}
				else
				{
					self globallogic_ui::showmainmenuforteam();
				}
			}
			self thread spectating::set_permissions();
		}
	}
	if(self.sessionteam != #"spectator" && self.sessionstate != "playing" && !isalive(self))
	{
		self thread spawning::onspawnplayer(1);
	}
	if(level.forceradar == 1)
	{
		self.pers[#"hasradar"] = 1;
		self.hasspyplane = 1;
		if(level.teambased)
		{
			if(!isdefined(level.activeuavs[self.team]))
			{
				level.activeuavs[self.team] = 0;
			}
			level.activeuavs[self.team]++;
		}
		else
		{
			level.activeuavs[self getentitynumber()]++;
		}
		level.activeplayeruavs[self getentitynumber()]++;
	}
	if(level.forceradar == 2)
	{
		self setclientuivisibilityflag("g_compassShowEnemies", level.forceradar);
	}
	else
	{
		self setclientuivisibilityflag("g_compassShowEnemies", 0);
	}
	profilelog_endtiming(4, "gs=" + game.state);
	if(isbot(self))
	{
		return;
	}
	if(util::isfirstround())
	{
		self player_record::record_global_mp_stats_for_player_at_match_start();
	}
	self hvo::function_2ce5cb7e();
	num_con = getnumconnectedplayers();
	num_exp = getnumexpectedplayers();
	/#
		println("", num_con, "", num_exp);
	#/
	if(num_con == num_exp && num_exp != 0)
	{
		level flag::set("all_players_connected");
	}
	globallogic_score::updateweaponcontractstart(self);
	if(sessionmodeiswarzonegame())
	{
		self callback::function_d8abfc3d(#"on_end_game", &player_monitor::function_36185795);
	}
}

/*
	Name: function_db0c0406
	Namespace: player
	Checksum: 0x7C63E6C5
	Offset: 0x1508
	Size: 0x786
	Parameters: 0
	Flags: Linked, Private
*/
function private function_db0c0406()
{
	if(!isdefined(self.pers[#"score"]))
	{
		self thread persistence::adjust_recent_stats();
		self stats::function_7a850245(#"valid", 0);
	}
	if(level.rankedmatch || level.leaguematch && !isdefined(self.pers[#"matchesplayedstatstracked"]) && !sessionmodeiswarzonegame())
	{
		gamemode = util::getcurrentgamemode();
		self globallogic::incrementmatchcompletionstat(gamemode, "played", "started");
		if(!isdefined(self.pers[#"matcheshostedstatstracked"]) && self islocaltohost())
		{
			self globallogic::incrementmatchcompletionstat(gamemode, "hosted", "started");
			self.pers[#"matcheshostedstatstracked"] = 1;
		}
		self.pers[#"matchesplayedstatstracked"] = 1;
		self thread persistence::upload_stats_soon();
	}
	if(!isdefined(self.pers[#"totaltimeplayed"]))
	{
		self setentertime(gettime());
		self.pers[#"totaltimeplayed"] = 0;
	}
	if(!isdefined(self.pers[#"totalmatchbonus"]))
	{
		self.pers[#"totalmatchbonus"] = 0;
	}
	if(!isdefined(self.pers[#"spawns"]))
	{
		self.pers[#"spawns"] = 0;
	}
	if(!isdefined(self.pers[#"best_kill_streak"]))
	{
		self.pers[#"killed_players"] = [];
		self.pers[#"killed_by"] = [];
		self.pers[#"nemesis_tracking"] = [];
		self.pers[#"artillery_kills"] = 0;
		self.pers[#"dog_kills"] = 0;
		self.pers[#"nemesis_name"] = "";
		self.pers[#"nemesis_rank"] = 0;
		self.pers[#"nemesis_rankicon"] = 0;
		self.pers[#"nemesis_xp"] = 0;
		self.pers[#"nemesis_xuid"] = "";
		self.pers[#"killed_players_with_specialist"] = [];
		self.pers[#"best_kill_streak"] = 0;
	}
	if(!isdefined(self.pers[#"music"]))
	{
		self.pers[#"music"] = spawnstruct();
		self.pers[#"music"].spawn = 0;
		self.pers[#"music"].inque = 0;
		self.pers[#"music"].currentstate = "SILENT";
		self.pers[#"music"].previousstate = "SILENT";
		self.pers[#"music"].nextstate = "UNDERSCORE";
		self.pers[#"music"].returnstate = "UNDERSCORE";
	}
	if(!isdefined(self.pers[#"cur_kill_streak"]))
	{
		self.pers[#"cur_kill_streak"] = 0;
	}
	if(!isdefined(self.pers[#"cur_total_kill_streak"]))
	{
		self.pers[#"cur_total_kill_streak"] = 0;
		self setplayercurrentstreak(0);
	}
	if(!isdefined(self.pers[#"totalkillstreakcount"]))
	{
		self.pers[#"totalkillstreakcount"] = 0;
	}
	if(!isdefined(self.pers[#"killstreaksearnedthiskillstreak"]))
	{
		self.pers[#"killstreaksearnedthiskillstreak"] = 0;
	}
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"killstreak_quantity"]))
	{
		self.pers[#"killstreak_quantity"] = [];
	}
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"held_killstreak_ammo_count"]))
	{
		self.pers[#"held_killstreak_ammo_count"] = [];
	}
	if(isdefined(level.usingscorestreaks) && level.usingscorestreaks && !isdefined(self.pers[#"held_killstreak_clip_count"]))
	{
		self.pers[#"held_killstreak_clip_count"] = [];
	}
	if(!isdefined(self.pers[#"changed_class"]))
	{
		self.pers[#"changed_class"] = 0;
	}
	if(!isdefined(self.pers[#"changed_specialist"]))
	{
		self.pers[#"changed_specialist"] = 0;
	}
	if(!isdefined(self.pers[#"lastroundscore"]))
	{
		self.pers[#"lastroundscore"] = 0;
	}
}

/*
	Name: init_character_index
	Namespace: player
	Checksum: 0x4F93A0F4
	Offset: 0x1C98
	Size: 0x694
	Parameters: 0
	Flags: Linked, Private
*/
function private init_character_index()
{
	/#
		autoselection = getdvarint(#"auto_select_character", -1);
		if(player_role::is_valid(autoselection))
		{
			draft::select_character(autoselection, 1);
			return;
		}
		autoselection = getdvarstring(#"character");
		if(autoselection != "")
		{
			var_6a3f295d = hash(autoselection);
			playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
			for(i = 0; i < playerroletemplatecount; i++)
			{
				var_3c6fd4f7 = function_b14806c6(i, currentsessionmode());
				if(var_3c6fd4f7 == var_6a3f295d)
				{
					draft::select_character(i, 1);
					return;
				}
			}
		}
	#/
	var_295f639 = 0;
	if(isdefined(self.pers) && isdefined(self.pers[#"characterindex"]) && player_role::is_valid(self.pers[#"characterindex"]))
	{
		var_295f639 = 1;
	}
	if(!getgametypesetting(#"draftenabled") && !var_295f639)
	{
		if(util::function_8570168d())
		{
			if(isdefined(self.var_29b433bd))
			{
				var_72964a59 = self.var_29b433bd;
			}
			else
			{
				var_72964a59 = self function_76785843();
			}
			if(!player_role::is_valid(var_72964a59) && isdefined(level.select_character))
			{
				var_72964a59 = level.select_character;
			}
		}
		else
		{
			if(sessionmodeiswarzonegame())
			{
				var_72964a59 = self stats::function_6d50f14b(#"cacloadouts", #"charactercontext", #"characterindex");
				if(var_72964a59 != 0 && (isdefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising")))
				{
					rf = getplayerrolefields(var_72964a59, currentsessionmode());
					if(isdefined(rf) && rf.unlockableitementry === #"wz_character_spectre")
					{
						var_72964a59 = 0;
					}
				}
				if(var_72964a59 == 0)
				{
					playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
					var_36918d27 = [];
					for(i = 0; i < playerroletemplatecount; i++)
					{
						/#
							if(isbot(self))
							{
								if(function_f4bf7e3f(i, currentsessionmode()))
								{
									if(!isdefined(var_36918d27))
									{
										var_36918d27 = [];
									}
									else if(!isarray(var_36918d27))
									{
										var_36918d27 = array(var_36918d27);
									}
									var_36918d27[var_36918d27.size] = i;
								}
								continue;
							}
						#/
						rf = getplayerrolefields(i, currentsessionmode());
						if(isdefined(rf) && (isdefined(rf.isdefaultcharacter) && rf.isdefaultcharacter))
						{
							if(!isdefined(var_36918d27))
							{
								var_36918d27 = [];
							}
							else if(!isarray(var_36918d27))
							{
								var_36918d27 = array(var_36918d27);
							}
							var_36918d27[var_36918d27.size] = i;
						}
					}
					var_72964a59 = (isdefined(array::random(var_36918d27)) ? array::random(var_36918d27) : 0);
					if(var_72964a59 == 0)
					{
						kick(self getentitynumber());
						return;
					}
				}
			}
			else
			{
				if(sessionmodeismultiplayergame())
				{
					draft::assign_remaining_players(self);
					return;
				}
				var_72964a59 = self function_b3a116a1();
			}
		}
		draft::select_character(var_72964a59, 1);
	}
	if(!draft::is_draft_this_round() && player_role::is_valid(self.pers[#"characterindex"]))
	{
		player_role::set(self.pers[#"characterindex"]);
	}
	self function_427981d0(0);
}

/*
	Name: function_efa6e25f
	Namespace: player
	Checksum: 0x3EC2A503
	Offset: 0x2338
	Size: 0x11BA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_efa6e25f()
{
	self globallogic_score::initpersstat(#"score");
	self globallogic_score::initpersstat(#"rolescore");
	self globallogic_score::initpersstat(#"objscore");
	self globallogic_score::initpersstat(#"damagedone");
	self globallogic_score::initpersstat(#"damagedoneheadshot");
	self globallogic_score::initpersstat(#"downs");
	self globallogic_score::initpersstat(#"revives");
	self globallogic_score::initpersstat(#"cleanups");
	self globallogic_score::initpersstat(#"hash_150795bee4d46ce4");
	if(self.pers[#"hash_150795bee4d46ce4"] === 0)
	{
		self.pers[#"hash_150795bee4d46ce4"] = gettime();
	}
	if(level.resetplayerscoreeveryround)
	{
		self.pers[#"score"] = 0;
		self.pers[#"rolescore"] = 0;
		self.pers[#"objscore"] = 0;
		self.pers[#"downs"] = 0;
		self.pers[#"revives"] = 0;
		self.pers[#"cleanups"] = 0;
	}
	self.score = self.pers[#"score"];
	self.rolescore = self.pers[#"rolescore"];
	self.objscore = self.pers[#"objscore"];
	self.damagedone = self.pers[#"damagedone"];
	self.downs = self.pers[#"downs"];
	self.revives = self.pers[#"revives"];
	self.cleanups = self.pers[#"cleanups"];
	self globallogic_score::initpersstat(#"pointstowin");
	if(level.scoreroundwinbased)
	{
		self.pers[#"pointstowin"] = 0;
	}
	self.pointstowin = self.pers[#"pointstowin"];
	self.pers[#"outcome"] = #"loss";
	self globallogic_score::initpersstat(#"momentum", 0);
	self.momentum = self globallogic_score::getpersstat(#"momentum");
	self globallogic_score::initpersstat(#"suicides");
	self.suicides = self globallogic_score::getpersstat(#"suicides");
	self globallogic_score::initpersstat(#"headshots");
	self.headshots = self globallogic_score::getpersstat(#"headshots");
	self globallogic_score::initpersstat(#"challenges");
	self.challenges = self globallogic_score::getpersstat(#"challenges");
	self globallogic_score::initpersstat(#"ekia");
	self.ekia = self globallogic_score::getpersstat(#"ekia");
	self globallogic_score::initpersstat(#"objectiveekia");
	self.objectiveekia = self globallogic_score::getpersstat(#"objectiveekia");
	self globallogic_score::initpersstat(#"objectivescore", 0);
	self.objectivescore = self globallogic_score::getpersstat(#"objectivescore");
	self globallogic_score::initpersstat(#"objectivedefends", 0);
	self.objectivedefends = self globallogic_score::getpersstat(#"objectivedefends");
	self globallogic_score::initpersstat(#"objectivetime", 0);
	self.objectivetime = self globallogic_score::getpersstat(#"objectivetime");
	self globallogic_score::initpersstat(#"kills");
	self.kills = self globallogic_score::getpersstat(#"kills");
	self globallogic_score::initpersstat(#"deaths");
	self.deaths = self globallogic_score::getpersstat(#"deaths");
	self globallogic_score::initpersstat(#"assists");
	self.assists = self globallogic_score::getpersstat(#"assists");
	self globallogic_score::initpersstat(#"defends", 0);
	self.defends = self globallogic_score::getpersstat(#"defends");
	self globallogic_score::initpersstat(#"offends", 0);
	self.offends = self globallogic_score::getpersstat(#"offends");
	self globallogic_score::initpersstat(#"plants", 0);
	self.plants = self globallogic_score::getpersstat(#"plants");
	self globallogic_score::initpersstat(#"defuses", 0);
	self.defuses = self globallogic_score::getpersstat(#"defuses");
	self globallogic_score::initpersstat(#"returns", 0);
	self.returns = self globallogic_score::getpersstat(#"returns");
	self globallogic_score::initpersstat(#"captures", 0);
	self.captures = self globallogic_score::getpersstat(#"captures");
	self globallogic_score::initpersstat(#"objectives", 0);
	self.objectives = self globallogic_score::getpersstat(#"objectives");
	self globallogic_score::initpersstat(#"objtime", 0);
	self.objtime = self globallogic_score::getpersstat(#"objtime");
	self globallogic_score::initpersstat(#"carries", 0);
	self.carries = self globallogic_score::getpersstat(#"carries");
	self globallogic_score::initpersstat(#"throws", 0);
	self.throws = self globallogic_score::getpersstat(#"throws");
	self globallogic_score::initpersstat(#"destructions", 0);
	self.destructions = self globallogic_score::getpersstat(#"destructions");
	self globallogic_score::initpersstat(#"disables", 0);
	self.disables = self globallogic_score::getpersstat(#"disables");
	self globallogic_score::initpersstat(#"escorts", 0);
	self.escorts = self globallogic_score::getpersstat(#"escorts");
	self globallogic_score::initpersstat(#"sbtimeplayed", 0);
	self.sbtimeplayed = self globallogic_score::getpersstat(#"sbtimeplayed");
	self globallogic_score::initpersstat(#"backstabs", 0);
	self.backstabs = self globallogic_score::getpersstat(#"backstabs");
	self globallogic_score::initpersstat(#"longshots", 0);
	self.longshots = self globallogic_score::getpersstat(#"longshots");
	self globallogic_score::initpersstat(#"survived", 0);
	self.survived = self globallogic_score::getpersstat(#"survived");
	self globallogic_score::initpersstat(#"stabs", 0);
	self.stabs = self globallogic_score::getpersstat(#"stabs");
	self globallogic_score::initpersstat(#"tomahawks", 0);
	self.tomahawks = self globallogic_score::getpersstat(#"tomahawks");
	self globallogic_score::initpersstat(#"humiliated", 0);
	self.humiliated = self globallogic_score::getpersstat(#"humiliated");
	self globallogic_score::initpersstat(#"x2score", 0);
	self.x2score = self globallogic_score::getpersstat(#"x2score");
	self globallogic_score::initpersstat(#"agrkills", 0);
	self.x2score = self globallogic_score::getpersstat(#"agrkills");
	self globallogic_score::initpersstat(#"hacks", 0);
	self.x2score = self globallogic_score::getpersstat(#"hacks");
	self globallogic_score::initpersstat(#"killsconfirmed", 0);
	self.killsconfirmed = self globallogic_score::getpersstat(#"killsconfirmed");
	self globallogic_score::initpersstat(#"killsdenied", 0);
	self.killsdenied = self globallogic_score::getpersstat(#"killsdenied");
	self globallogic_score::initpersstat(#"rescues", 0);
	self.rescues = self globallogic_score::getpersstat(#"rescues");
	self globallogic_score::initpersstat(#"shotsfired", 0);
	self.shotsfired = self globallogic_score::getpersstat(#"shotsfired");
	self globallogic_score::initpersstat(#"shotshit", 0);
	self.shotshit = self globallogic_score::getpersstat(#"shotshit");
	self globallogic_score::initpersstat(#"shotsmissed", 0);
	self.shotsmissed = self globallogic_score::getpersstat(#"shotsmissed");
	self globallogic_score::initpersstat(#"victory", 0);
	self.victory = self globallogic_score::getpersstat(#"victory");
	self globallogic_score::initpersstat(#"sessionbans", 0);
	self.sessionbans = self globallogic_score::getpersstat(#"sessionbans");
	self globallogic_score::initpersstat(#"gametypeban", 0);
	self globallogic_score::initpersstat(#"time_played_total", 0);
	self globallogic_score::initpersstat(#"time_played_alive", 0);
	self globallogic_score::initpersstat(#"participation", 0);
	self globallogic_score::initpersstat(#"teamkills", 0);
	self globallogic_score::initpersstat(#"teamkills_nostats", 0);
	self globallogic_score::initpersstat(#"kill_distances", 0);
	self globallogic_score::initpersstat(#"num_kill_distance_entries", 0);
	self globallogic_score::initpersstat(#"time_played_moving", 0);
	self globallogic_score::initpersstat(#"total_speeds_when_moving", 0);
	self globallogic_score::initpersstat(#"num_speeds_when_moving_entries", 0);
	self globallogic_score::initpersstat(#"total_distance_travelled", 0);
	self globallogic_score::initpersstat(#"movement_update_count", 0);
	self globallogic_score::initpersstat(#"ability_medal_count", 0);
	self.ability_medal_count = self globallogic_score::getpersstat(#"ability_medal_count");
	self globallogic_score::initpersstat(#"equipment_medal_count", 0);
	self.equipment_medal_count = self globallogic_score::getpersstat(#"equipment_medal_count");
}

/*
	Name: function_3bd86b5d
	Namespace: player
	Checksum: 0xA25C3A70
	Offset: 0x3500
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3bd86b5d()
{
	waittillframeend();
	if(isdefined(self))
	{
		level notify(#"connecting", {#player:self});
	}
	callback::callback(#"on_player_connecting");
}

