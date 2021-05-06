// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_16cb0a6a492a6a4f;
#using script_18f0d22c75b141a7;
#using script_1bd0552c85e48ebe;
#using script_1f2f7ef27f2aabba;
#using script_256b8879317373de;
#using script_2dc48f46bfeac894;
#using script_3f27a7b2232674db;
#using script_6c8abe14025b47c4;
#using script_788472602edbe3b9;
#using scripts\core_common\gamestate.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\spectating.gsc;
#using scripts\core_common\teams.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\draft.gsc;
#using scripts\mp_common\gametypes\globallogic.gsc;
#using scripts\mp_common\userspawnselection.gsc;
#using scripts\mp_common\util.gsc;

#namespace globallogic_ui;

/*
	Name: init
	Namespace: globallogic_ui
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: setupcallbacks
	Namespace: globallogic_ui
	Checksum: 0xCB400193
	Offset: 0x1B0
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function setupcallbacks()
{
	level.autoassign = &menuautoassign;
	level.spectator = &menuspectator;
	level.curclass = &menuclass;
	level.var_2a43ad89 = &function_9ed118fe;
	level.teammenu = &menuteam;
	level.draftmenu = &menupositiondraft;
	level.autocontrolplayer = &menuautocontrolplayer;
}

/*
	Name: freegameplayhudelems
	Namespace: globallogic_ui
	Checksum: 0x5F5ECE10
	Offset: 0x268
	Size: 0x284
	Parameters: 0
	Flags: None
*/
function freegameplayhudelems()
{
	/#
		/#
			if(isdefined(self.perkicon))
			{
				for(numspecialties = 0; numspecialties < level.maxspecialties; numspecialties++)
				{
					if(isdefined(self.perkicon[numspecialties]))
					{
						self.perkicon[numspecialties] hud::destroyelem();
						self.perkname[numspecialties] hud::destroyelem();
					}
				}
			}
			if(isdefined(self.perkhudelem))
			{
				self.perkhudelem hud::destroyelem();
			}
		#/
		if(isdefined(self.killstreakicon))
		{
			if(isdefined(self.killstreakicon[0]))
			{
				self.killstreakicon[0] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[1]))
			{
				self.killstreakicon[1] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[2]))
			{
				self.killstreakicon[2] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[3]))
			{
				self.killstreakicon[3] hud::destroyelem();
			}
			if(isdefined(self.killstreakicon[4]))
			{
				self.killstreakicon[4] hud::destroyelem();
			}
		}
		if(isdefined(self.lowermessage))
		{
			self.lowermessage hud::destroyelem();
		}
		if(isdefined(self.lowertimer))
		{
			self.lowertimer hud::destroyelem();
		}
		if(isdefined(self.proxbar))
		{
			self.proxbar hud::destroyelem();
		}
		if(isdefined(self.proxbartext))
		{
			self.proxbartext hud::destroyelem();
		}
		if(isdefined(self.carryicon))
		{
			self.carryicon hud::destroyelem();
		}
	#/
}

/*
	Name: function_34a60b2f
	Namespace: globallogic_ui
	Checksum: 0x8B3AC9CB
	Offset: 0x4F8
	Size: 0xC6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_34a60b2f(original_team, var_5002c793)
{
	if(!isdefined(original_team) || original_team == #"spectator" || !isdefined(var_5002c793))
	{
		return;
	}
	if(game.everexisted[original_team] && !game.everexisted[var_5002c793] && level.playerlives[original_team])
	{
		game.everexisted[original_team] = 0;
		level.everexisted[original_team] = 0;
		level.teameliminated[original_team] = 0;
	}
}

/*
	Name: menuautoassign
	Namespace: globallogic_ui
	Checksum: 0xFDB0C944
	Offset: 0x5C8
	Size: 0x464
	Parameters: 2
	Flags: Linked
*/
function menuautoassign(comingfrommenu, var_4c542e39)
{
	original_team = self.pers[#"team"];
	self luinotifyevent(#"clear_notification_queue");
	if(level.teambased)
	{
		assignment = teams::function_d22a4fbb(comingfrommenu, var_4c542e39);
		if(assignment === self.pers[#"team"] && (self.sessionstate === "playing" || self.sessionstate === "dead"))
		{
			self beginclasschoice(0);
			return;
		}
	}
	else if(self.sessionstate == "playing" || self.sessionstate == "dead")
	{
		return;
	}
	assignment = teams::function_b55ab4b3(comingfrommenu, var_4c542e39);
	/#
		assignmentoverride = getdvarstring(#"autoassignteam");
		if(assignmentoverride != "" && (assignmentoverride != #"spectator" || !isbot(self)))
		{
			assignment = assignmentoverride;
		}
	#/
	if(!isdefined(assignment))
	{
		assignment = var_4c542e39;
	}
	/#
		assert(isdefined(assignment));
	#/
	if(assignment === #"spectator" && !level.forceautoassign)
	{
		self teams::function_dc7eaabd(assignment);
		return;
	}
	if(assignment !== self.pers[#"team"] && (self.sessionstate == "playing" || self.sessionstate == "dead"))
	{
		self.switching_teams = 1;
		self.switchedteamsresetgadgets = 1;
		self.joining_team = assignment;
		self.leaving_team = self.pers[#"team"];
		self suicide();
	}
	self.pers[#"class"] = "";
	self.curclass = "";
	self.pers[#"weapon"] = undefined;
	self.pers[#"savedmodel"] = undefined;
	self teams::function_dc7eaabd(assignment);
	self namespace_aa9b5883::function_4b016b57();
	distribution = teams::function_7d93567f();
	self updateobjectivetext();
	if(!isalive(self))
	{
		self.statusicon = "hud_status_dead";
	}
	function_34a60b2f(original_team, assignment);
	self player::function_466d8a4b(comingfrommenu, assignment);
	if(level.var_b3c4b7b7 === 1)
	{
		draft::assign_remaining_players(self);
	}
	else
	{
		self notify(#"end_respawn");
		self beginclasschoice(comingfrommenu);
	}
	/#
		self teams::function_58b6d2c9();
	#/
}

/*
	Name: updateobjectivetext
	Namespace: globallogic_ui
	Checksum: 0x23302EC8
	Offset: 0xA38
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function updateobjectivetext()
{
	if(self.pers[#"team"] == #"spectator")
	{
		self setclientcgobjectivetext("");
		return;
	}
	if(level.scorelimit > 0 || level.roundscorelimit > 0)
	{
		self setclientcgobjectivetext(util::getobjectivescoretext(self.pers[#"team"]));
	}
	else
	{
		self setclientcgobjectivetext(util::getobjectivetext(self.pers[#"team"]));
	}
}

/*
	Name: closemenus
	Namespace: globallogic_ui
	Checksum: 0x66615A8A
	Offset: 0xB30
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function closemenus()
{
	self closeingamemenu();
}

/*
	Name: beginclasschoice
	Namespace: globallogic_ui
	Checksum: 0x55DBB3B9
	Offset: 0xB58
	Size: 0x2F4
	Parameters: 1
	Flags: Linked
*/
function beginclasschoice(comingfrommenu)
{
	if(isbot(self))
	{
		return;
	}
	/#
		assert(isdefined(level.teams[self.pers[#"team"]]));
	#/
	team = self.pers[#"team"];
	if(level.disableclassselection == 1 || getdvarint(#"migration_soak", 0) == 1)
	{
		self player_role::set(getdvarint(#"auto_select_character", 1));
		started_waiting = gettime();
		while(!self isstreamerready(-1, 1) && started_waiting + 90000 > gettime())
		{
			waitframe(1);
		}
		self.pers[#"class"] = level.defaultclass;
		self.curclass = level.defaultclass;
		if(self.sessionstate != "playing" && (game.state == "playing" || game.state == "pregame"))
		{
			self thread [[level.spawnclient]]();
		}
		level thread globallogic::updateteamstatus();
		self thread spectating::set_permissions_for_machine();
		return;
	}
	util::wait_network_frame();
	if(!draft::is_enabled() || comingfrommenu || !level.inprematchperiod)
	{
		[[level.spawnspectator]]();
		self userspawnselection::closespawnselect();
		self userspawnselection::clearcacheforplayer();
		self draft::function_2427a351();
		if(comingfrommenu || !player_role::is_valid(player_role::get()))
		{
			self draft::open();
		}
	}
}

/*
	Name: showmainmenuforteam
	Namespace: globallogic_ui
	Checksum: 0xFC7358AD
	Offset: 0xE58
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function showmainmenuforteam()
{
	/#
		assert(isdefined(level.teams[self.pers[#"team"]]));
	#/
	team = self.pers[#"team"];
	[[level.spawnspectator]]();
	self draft::open();
}

/*
	Name: menuteam
	Namespace: globallogic_ui
	Checksum: 0xABE7A0CE
	Offset: 0xEF0
	Size: 0x2BC
	Parameters: 1
	Flags: Linked
*/
function menuteam(team)
{
	if(!level.console && !level.allow_teamchange && (isdefined(self.hasdonecombat) && self.hasdonecombat))
	{
		return;
	}
	if(self.pers[#"team"] != team)
	{
		function_34a60b2f(self.pers[#"team"], team);
		if(level.ingraceperiod && (!isdefined(self.hasdonecombat) || !self.hasdonecombat))
		{
			self.hasspawned = 0;
		}
		if(self.sessionstate == "playing")
		{
			self.switchedteamsresetgadgets = 1;
			self.joining_team = team;
			self.leaving_team = self.pers[#"team"];
			self suicide();
		}
		self userspawnselection::closespawnselect();
		self userspawnselection::clearcacheforplayer();
		self luinotifyevent(#"clear_notification_queue");
		self.switching_teams = 1;
		self.pers[#"team"] = team;
		self.team = team;
		self.pers[#"class"] = "";
		self.curclass = "";
		self.pers[#"weapon"] = undefined;
		self.pers[#"savedmodel"] = undefined;
		self updateobjectivetext();
		if(!level.rankedmatch && !level.leaguematch)
		{
			self.sessionstate = "spectator";
		}
		self.sessionteam = team;
		self player::function_466d8a4b(1, team);
		self notify(#"end_respawn");
	}
	self beginclasschoice(1);
}

/*
	Name: menuspectator
	Namespace: globallogic_ui
	Checksum: 0x602BE0A1
	Offset: 0x11B8
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function menuspectator()
{
	self closemenus();
	if(self.pers[#"team"] != #"spectator")
	{
		if(isalive(self))
		{
			self.switching_teams = 1;
			self.switchedteamsresetgadgets = 1;
			self.joining_team = #"spectator";
			self.leaving_team = self.pers[#"team"];
			self suicide();
		}
		self.pers[#"team"] = #"spectator";
		self.team = #"spectator";
		self.pers[#"class"] = "";
		self.curclass = "";
		self.pers[#"weapon"] = undefined;
		self.pers[#"savedmodel"] = undefined;
		self updateobjectivetext();
		self.sessionteam = #"spectator";
		[[level.spawnspectator]]();
		self thread player::spectate_player_watcher();
		self player::function_6f6c29e(1);
	}
}

/*
	Name: menuclass
	Namespace: globallogic_ui
	Checksum: 0x551A46AE
	Offset: 0x1398
	Size: 0x6C0
	Parameters: 4
	Flags: Linked
*/
function menuclass(response, forcedclass, updatecharacterindex, closemenus)
{
	if(!isdefined(self.pers[#"team"]) || !isdefined(level.teams[self.pers[#"team"]]))
	{
		return 0;
	}
	if(!loadout::function_87bcb1b())
	{
		if(game.state == "pregame" || game.state == "playing" && self.sessionstate != "playing")
		{
			self thread [[level.spawnclient]](0);
		}
		return;
	}
	if(!isdefined(forcedclass))
	{
		playerclass = self loadout::function_97d216fa(response);
	}
	else
	{
		playerclass = forcedclass;
	}
	if(isdefined(level.disablecac) && level.disablecac && issubstr(playerclass, "CLASS_CUSTOM") && isarray(level.classtoclassnum) && level.classtoclassnum.size > 0)
	{
		defaultclasses = getarraykeys(level.var_8e1db8ee);
		playerclass = level.var_8e1db8ee[defaultclasses[randomint(defaultclasses.size)]];
	}
	self loadout::function_d7c205b9(playerclass);
	if(!player_role::is_valid(self player_role::get()))
	{
		return 0;
	}
	if(isdefined(self.pers[#"class"]) && self.pers[#"class"] == playerclass)
	{
		return 1;
	}
	self.pers[#"changed_class"] = 1;
	self notify(#"changed_class");
	if(isdefined(self.curclass) && self.curclass == playerclass)
	{
		self.pers[#"changed_class"] = 0;
	}
	var_8d7a946 = !isdefined(self.curclass) || self.curclass == "";
	self.pers[#"class"] = playerclass;
	self.curclass = playerclass;
	self loadout::function_d7c205b9(playerclass);
	self.pers[#"weapon"] = undefined;
	if(gamestate::function_674fd868())
	{
		return 0;
	}
	if(self.sessionstate != "playing")
	{
		if(self.sessionstate != "spectator")
		{
			if(self isinvehicle())
			{
				return 0;
			}
			if(self isremotecontrolling())
			{
				return 0;
			}
			if(self isweaponviewonlylinked())
			{
				return 0;
			}
		}
		if(self.sessionstate != "dead")
		{
			timepassed = undefined;
			if(isdefined(self.respawntimerstarttime))
			{
				timepassed = float(gettime() - self.respawntimerstarttime) / 1000;
			}
			self thread [[level.spawnclient]](timepassed);
			self.respawntimerstarttime = undefined;
		}
	}
	if(self.sessionstate == "playing")
	{
		supplystationclasschange = isdefined(self.usingsupplystation) && self.usingsupplystation;
		self.usingsupplystation = 0;
		if(isdefined(level.ingraceperiod) && level.ingraceperiod && (!(isdefined(self.hasdonecombat) && self.hasdonecombat)) || (isdefined(supplystationclasschange) && supplystationclasschange) || (self.pers[#"latejoin"] === 1 && self.pers[#"time_played_alive"] < level.graceperiod && (!(isdefined(self.hasdonecombat) && self.hasdonecombat))))
		{
			self loadout::function_53b62db1(self.pers[#"class"]);
			self.tag_stowed_back = undefined;
			self.tag_stowed_hip = undefined;
			self ability_player::gadgets_save_power(0);
			self loadout::give_loadout(self.pers[#"team"], self.pers[#"class"]);
			self killstreaks::give_owned();
		}
		else if(!var_8d7a946 && self.pers[#"changed_class"] && (!(isdefined(level.var_f46d16f0) && level.var_f46d16f0)))
		{
			self luinotifyevent(#"hash_6b67aa04e378d681", 1, 6);
		}
	}
	level thread globallogic::updateteamstatus();
	self thread spectating::set_permissions_for_machine();
	return 1;
}

/*
	Name: function_9ed118fe
	Namespace: globallogic_ui
	Checksum: 0x21AFC0C9
	Offset: 0x1A60
	Size: 0x2FC
	Parameters: 1
	Flags: Linked
*/
function function_9ed118fe(characterindex)
{
	self endon(#"disconnect");
	if(!isdefined(characterindex))
	{
		/#
			println("");
		#/
		return;
	}
	if(!draft::can_select_character(characterindex))
	{
		return 0;
	}
	if(player_role::get() != characterindex)
	{
		self.pers[#"changed_specialist"] = 1;
		self.var_89c4a60f = self getmpdialogname();
		self.pers[#"hash_1b145cf9f0673e9"] = function_b14806c6(self player_role::get(), currentsessionmode());
	}
	else
	{
		self.pers[#"changed_specialist"] = 0;
	}
	spawns = self.pers[#"spawns"];
	self draft::select_character(characterindex, 0);
	var_2488d780 = getcharacterdisplayname(characterindex, currentsessionmode());
	iprintln(#"hash_52f20b5836b29e3", self, var_2488d780);
	if(isdefined(self.pers[#"changed_specialist"]) && self.pers[#"changed_specialist"])
	{
		self notify(#"hash_6729adcb68ec7ffc");
	}
	if(game.state == "playing" && !userspawnselection::function_fed7687f() && spawns != 0 && (!(isdefined(level.var_324e2795) && level.var_324e2795)))
	{
		self suicide("MOD_META");
		waitframe(1);
	}
	else if(game.state == "pregame")
	{
		self loadout::give_loadout(self.team, self.curclass);
	}
	if(isdefined(self))
	{
		self luinotifyevent(#"hash_2dddf8559f5b304d", 1, 1);
	}
}

/*
	Name: menuautocontrolplayer
	Namespace: globallogic_ui
	Checksum: 0xEC720F87
	Offset: 0x1D68
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function menuautocontrolplayer()
{
	self closemenus();
	if(self.pers[#"team"] != #"spectator")
	{
		toggleplayercontrol(self);
	}
}

/*
	Name: menupositiondraft
	Namespace: globallogic_ui
	Checksum: 0xA38E33CD
	Offset: 0x1DD0
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function menupositiondraft(response, intpayload)
{
	if(response == "changecharacter")
	{
		if(self draft::function_904deeb2())
		{
			self player_role::clear();
		}
	}
	else if(response == "randomcharacter")
	{
		self player_role::clear();
		draft::assign_remaining_players(self);
		if(!(isdefined(level.inprematchperiod) && level.inprematchperiod))
		{
			self draft::close();
			if(!function_8b1a219a())
			{
				self closeingamemenu();
			}
		}
	}
	else if(response == "ready")
	{
		self draft::function_3e46326b();
	}
	else if(response == "opendraft")
	{
		self draft::open();
	}
	else if(response == "closedraft")
	{
		self draft::close();
	}
}

/*
	Name: removespawnmessageshortly
	Namespace: globallogic_ui
	Checksum: 0x8B0E94D4
	Offset: 0x1F48
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function removespawnmessageshortly(delay)
{
	self endon(#"disconnect");
	waittillframeend();
	self endon(#"end_respawn");
	wait(delay);
	self hud_message::clearlowermessage();
}

