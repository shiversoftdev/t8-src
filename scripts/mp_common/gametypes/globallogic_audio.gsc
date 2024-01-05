// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\gametypes\round.gsc;
#using scripts\mp_common\gametypes\outcome.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\gametypes\globallogic_utils.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\audio_shared.gsc;

#namespace globallogic_audio;

/*
	Name: __init__system__
	Namespace: globallogic_audio
	Checksum: 0x7A15A9B1
	Offset: 0x608
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"globallogic_audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: globallogic_audio
	Checksum: 0x74501F25
	Offset: 0x650
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_start_gametype(&init);
	level.playleaderdialogonplayer = &leader_dialog_on_player;
	level.var_57e2bc08 = &leader_dialog;
	level.playequipmentdestroyedonplayer = &play_equipment_destroyed_on_player;
	level.playequipmenthackedonplayer = &play_equipment_hacked_on_player;
	setdvar(#"hash_2fd9eb199c2ef1cf", 0.4);
}

/*
	Name: init
	Namespace: globallogic_audio
	Checksum: 0xC444DD6C
	Offset: 0x708
	Size: 0x7FA
	Parameters: 0
	Flags: Linked
*/
function init()
{
	game.music[#"defeat"] = "mus_defeat";
	game.music[#"victory_spectator"] = "mus_defeat";
	game.music[#"winning"] = "mus_time_running_out_winning";
	game.music[#"losing"] = "mus_time_running_out_losing";
	game.music[#"match_end"] = "mus_match_end";
	game.music[#"victory_tie"] = "mus_defeat";
	game.music[#"spawn_short"] = "SPAWN_SHORT";
	game.music[#"suspense"] = [];
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_01";
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_02";
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_03";
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_04";
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_05";
	game.music[#"suspense"][game.music[#"suspense"].size] = "mus_suspense_06";
	level callback::function_d8abfc3d(#"on_end_game", &on_end_game);
	level.multipledialogkeys = [];
	level.multipledialogkeys[#"enemyaitank"] = "enemyAiTankMultiple";
	level.multipledialogkeys[#"enemysupplydrop"] = "enemySupplyDropMultiple";
	level.multipledialogkeys[#"enemycombatrobot"] = "enemyCombatRobotMultiple";
	level.multipledialogkeys[#"enemycounteruav"] = "enemyCounterUavMultiple";
	level.multipledialogkeys[#"enemydart"] = "enemyDartMultiple";
	level.multipledialogkeys[#"enemyemp"] = "enemyEmpMultiple";
	level.multipledialogkeys[#"enemymicrowaveturret"] = "enemyMicrowaveTurretMultiple";
	level.multipledialogkeys[#"enemyrcbomb"] = "enemyRcBombMultiple";
	level.multipledialogkeys[#"enemyplanemortar"] = "enemyPlaneMortarMultiple";
	level.multipledialogkeys[#"enemyhelicoptergunner"] = "enemyHelicopterGunnerMultiple";
	level.multipledialogkeys[#"enemyraps"] = "enemyRapsMultiple";
	level.multipledialogkeys[#"enemydronestrike"] = "enemyDroneStrikeMultiple";
	level.multipledialogkeys[#"enemyturret"] = "enemyTurretMultiple";
	level.multipledialogkeys[#"enemyhelicopter"] = "enemyHelicopterMultiple";
	level.multipledialogkeys[#"enemyuav"] = "enemyUavMultiple";
	level.multipledialogkeys[#"enemysatellite"] = "enemySatelliteMultiple";
	level.multipledialogkeys[#"friendlyaitank"] = "";
	level.multipledialogkeys[#"friendlysupplydrop"] = "";
	level.multipledialogkeys[#"friendlycombatrobot"] = "";
	level.multipledialogkeys[#"friendlycounteruav"] = "";
	level.multipledialogkeys[#"friendlydart"] = "";
	level.multipledialogkeys[#"friendlyemp"] = "";
	level.multipledialogkeys[#"friendlymicrowaveturret"] = "";
	level.multipledialogkeys[#"friendlyrcbomb"] = "";
	level.multipledialogkeys[#"friendlyplanemortar"] = "";
	level.multipledialogkeys[#"friendlyhelicoptergunner"] = "";
	level.multipledialogkeys[#"friendlyraps"] = "";
	level.multipledialogkeys[#"friendlydronestrike"] = "";
	level.multipledialogkeys[#"friendlyturret"] = "";
	level.multipledialogkeys[#"friendlyhelicopter"] = "";
	level.multipledialogkeys[#"friendlyuav"] = "";
	level.multipledialogkeys[#"friendlysatellite"] = "";
}

/*
	Name: function_6e084fd3
	Namespace: globallogic_audio
	Checksum: 0x25348645
	Offset: 0xF10
	Size: 0x2BA
	Parameters: 2
	Flags: Linked
*/
function function_6e084fd3(var_37ecca7, taacombundle)
{
	bundlename = undefined;
	switch(var_37ecca7)
	{
		case "tank_robot":
		{
			bundlename = taacombundle.aitankdialogbundle;
			break;
		}
		case "counteruav":
		{
			bundlename = taacombundle.counteruavdialogbundle;
			break;
		}
		case "dart":
		{
			bundlename = taacombundle.dartdialogbundle;
			break;
		}
		case "drone_squadron":
		{
			bundlename = taacombundle.var_69a9ca12;
			break;
		}
		case "ac130":
		{
			bundlename = taacombundle.var_71693229;
			break;
		}
		case "helicopter_comlink":
		{
			bundlename = taacombundle.helicopterdialogbundle;
			break;
		}
		case "overwatch_helicopter":
		{
			bundlename = taacombundle.var_f8bd3ac5;
			break;
		}
		case "hash_59687845e5356ded":
		{
			bundlename = taacombundle.var_4062b33e;
			break;
		}
		case "planemortar":
		{
			bundlename = taacombundle.planemortardialogbundle;
			break;
		}
		case "recon_car":
		{
			bundlename = taacombundle.rcbombdialogbundle;
			break;
		}
		case "remote_missile":
		{
			bundlename = taacombundle.remotemissiledialogbundle;
			break;
		}
		case "straferun":
		{
			bundlename = taacombundle.var_66389705;
			break;
		}
		case "supply_drop":
		{
			bundlename = taacombundle.supplydropdialogbundle;
			break;
		}
		case "swat_team":
		{
			bundlename = taacombundle.var_d93fd150;
			break;
		}
		case "uav":
		{
			bundlename = taacombundle.uavdialogbundle;
			break;
		}
		case "ultimate_turret":
		{
			bundlename = taacombundle.var_c9b104f1;
			break;
		}
		default:
		{
			break;
		}
	}
	if(!isdefined(bundlename))
	{
		return;
	}
	killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", bundlename);
	return killstreakbundle;
}

/*
	Name: set_leader_gametype_dialog
	Namespace: globallogic_audio
	Checksum: 0x23D02350
	Offset: 0x11D8
	Size: 0xC6
	Parameters: 6
	Flags: Linked
*/
function set_leader_gametype_dialog(startgamedialogkey, starthcgamedialogkey, offenseorderdialogkey, defenseorderdialogkey, var_2888cc9d, var_826b3c1a)
{
	level.leaderdialog = spawnstruct();
	level.leaderdialog.startgamedialog = startgamedialogkey;
	level.leaderdialog.var_f6fda321 = var_2888cc9d;
	level.leaderdialog.starthcgamedialog = starthcgamedialogkey;
	level.leaderdialog.var_d04b3734 = var_826b3c1a;
	level.leaderdialog.offenseorderdialog = offenseorderdialogkey;
	level.leaderdialog.defenseorderdialog = defenseorderdialogkey;
}

/*
	Name: function_5e0a6842
	Namespace: globallogic_audio
	Checksum: 0x769DC38A
	Offset: 0x12A8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_5e0a6842()
{
	leader_dialog("roundSwitchSides");
}

/*
	Name: function_dfd17bd3
	Namespace: globallogic_audio
	Checksum: 0x682BD8F0
	Offset: 0x12D0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_dfd17bd3()
{
	leader_dialog("roundHalftime");
}

/*
	Name: announce_round_winner
	Namespace: globallogic_audio
	Checksum: 0xF82BD0F0
	Offset: 0x12F8
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function announce_round_winner(delay)
{
	if(delay > 0)
	{
		wait(delay);
	}
	winner = round::get_winner();
	if(!isdefined(winner) || isplayer(winner))
	{
		return;
	}
	if(isdefined(level.teams[winner]))
	{
		if(level.gametype === "bounty" && round::function_3624d032() === 1)
		{
			leader_dialog("bountyRoundEncourageWon", winner);
			leader_dialog_for_other_teams("bountyRoundEncourageLost", winner);
		}
		else
		{
			leader_dialog("roundEncourageWon", winner);
			leader_dialog_for_other_teams("roundEncourageLost", winner);
		}
	}
	else
	{
		foreach(team, _ in level.teams)
		{
			thread sound::play_on_players(("mus_round_draw" + "_") + level.teampostfix[team]);
		}
		leader_dialog("roundDraw");
	}
}

/*
	Name: announce_game_winner
	Namespace: globallogic_audio
	Checksum: 0xC2366958
	Offset: 0x14C8
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function announce_game_winner(outcome)
{
	wait(battlechatter::mpdialog_value("announceWinnerDelay", 0));
	if(level.teambased)
	{
		if(outcome::get_flag(outcome, "tie") || !match::function_c10174e7())
		{
			leader_dialog("gameDraw");
		}
		else
		{
			leader_dialog("gameWon", outcome::get_winner(outcome));
			leader_dialog_for_other_teams("gameLost", outcome::get_winner(outcome));
		}
	}
}

/*
	Name: function_57678746
	Namespace: globallogic_audio
	Checksum: 0x64764E1D
	Offset: 0x15B8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_57678746(outcome)
{
}

/*
	Name: function_6374b97e
	Namespace: globallogic_audio
	Checksum: 0x466EE563
	Offset: 0x15D0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_6374b97e(tie)
{
	if(tie)
	{
		self set_music_on_player("matchDraw");
	}
	else
	{
		if(match::function_a2b53e17(self))
		{
			self set_music_on_player("matchWin");
		}
		else if(!level.splitscreen)
		{
			self set_music_on_player("matchLose");
		}
	}
}

/*
	Name: flush_dialog
	Namespace: globallogic_audio
	Checksum: 0x6F153A47
	Offset: 0x1678
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function flush_dialog()
{
	foreach(player in level.players)
	{
		player flush_dialog_on_player();
	}
}

/*
	Name: flush_dialog_on_player
	Namespace: globallogic_audio
	Checksum: 0x1C510760
	Offset: 0x1700
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function flush_dialog_on_player()
{
	if(!isdefined(self.leaderdialogqueue))
	{
		self.leaderdialogqueue = [];
	}
	self.currentleaderdialog = undefined;
	if(!isdefined(self.killstreakdialogqueue))
	{
		self.killstreakdialogqueue = [];
	}
	self.scorestreakdialogplaying = 0;
	self notify(#"flush_dialog");
}

/*
	Name: flush_killstreak_dialog_on_player
	Namespace: globallogic_audio
	Checksum: 0xC2B8147F
	Offset: 0x1760
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function flush_killstreak_dialog_on_player(killstreakid)
{
	if(!isdefined(killstreakid) || !isdefined(self.killstreakdialogqueue))
	{
		return;
	}
	for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--)
	{
		if(killstreakid === self.killstreakdialogqueue[i].killstreakid)
		{
			arrayremoveindex(self.killstreakdialogqueue, i);
		}
	}
}

/*
	Name: function_fd32b1bd
	Namespace: globallogic_audio
	Checksum: 0x26F78E22
	Offset: 0x1800
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function function_fd32b1bd(killstreaktype)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(killstreaktype) || !isdefined(self.killstreakdialogqueue))
	{
		return;
	}
	for(i = self.killstreakdialogqueue.size - 1; i >= 0; i--)
	{
		if(killstreaktype === self.killstreakdialogqueue[i].killstreaktype)
		{
			arrayremoveindex(self.killstreakdialogqueue, i);
		}
	}
}

/*
	Name: flush_objective_dialog
	Namespace: globallogic_audio
	Checksum: 0xC745F1D7
	Offset: 0x18A8
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function flush_objective_dialog(objectivekey)
{
	foreach(player in level.players)
	{
		player flush_objective_dialog_on_player(objectivekey);
	}
}

/*
	Name: flush_objective_dialog_on_player
	Namespace: globallogic_audio
	Checksum: 0x506261C5
	Offset: 0x1938
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function flush_objective_dialog_on_player(objectivekey)
{
	if(!isdefined(objectivekey) || !isdefined(self.leaderdialogqueue))
	{
		return;
	}
	for(i = self.leaderdialogqueue.size - 1; i >= 0; i--)
	{
		if(objectivekey === self.leaderdialogqueue[i].objectivekey)
		{
			arrayremoveindex(self.leaderdialogqueue, i);
			break;
		}
	}
}

/*
	Name: flush_leader_dialog_key
	Namespace: globallogic_audio
	Checksum: 0x9C0027EA
	Offset: 0x19E0
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function flush_leader_dialog_key(dialogkey)
{
	foreach(player in level.players)
	{
		player flush_leader_dialog_key_on_player(dialogkey);
	}
}

/*
	Name: flush_leader_dialog_key_on_player
	Namespace: globallogic_audio
	Checksum: 0x5D800DD9
	Offset: 0x1A70
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function flush_leader_dialog_key_on_player(dialogkey)
{
	if(!isdefined(dialogkey))
	{
		return;
	}
	if(!isdefined(self.leaderdialogqueue))
	{
		return;
	}
	for(i = self.leaderdialogqueue.size - 1; i >= 0; i--)
	{
		if(dialogkey === self.leaderdialogqueue[i].dialogkey)
		{
			arrayremoveindex(self.leaderdialogqueue, i);
		}
	}
}

/*
	Name: play_taacom_dialog
	Namespace: globallogic_audio
	Checksum: 0x377CE410
	Offset: 0x1B08
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function play_taacom_dialog(dialogkey, killstreaktype, killstreakid, var_46bd7973, var_8a6b001a, weapon, priority)
{
	self killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, undefined, var_46bd7973, var_8a6b001a, weapon, priority);
}

/*
	Name: killstreak_dialog_on_player
	Namespace: globallogic_audio
	Checksum: 0x351FDE93
	Offset: 0x1B80
	Size: 0x1D4
	Parameters: 8
	Flags: Linked
*/
function killstreak_dialog_on_player(dialogkey, killstreaktype, killstreakid, pilotindex, var_46bd7973, var_8a6b001a, weapon, priority)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.killstreakdialogqueue))
	{
		return;
	}
	if(!isdefined(dialogkey))
	{
		return;
	}
	if(!level.allowannouncer)
	{
		return;
	}
	if(level.gameended)
	{
		return;
	}
	newdialog = spawnstruct();
	newdialog.dialogkey = dialogkey;
	newdialog.killstreaktype = killstreaktype;
	newdialog.pilotindex = pilotindex;
	newdialog.killstreakid = killstreakid;
	newdialog.var_46bd7973 = var_46bd7973;
	newdialog.var_8a6b001a = var_8a6b001a;
	newdialog.weapon = weapon;
	if(priority === 1)
	{
		arrayinsert(self.killstreakdialogqueue, newdialog, 0);
	}
	else
	{
		self.killstreakdialogqueue[self.killstreakdialogqueue.size] = newdialog;
	}
	if(self.killstreakdialogqueue.size > 1 || isdefined(self.currentkillstreakdialog))
	{
		return;
	}
	if(self.playingdialog === 1 && dialogkey == "arrive")
	{
		self thread wait_for_player_dialog();
	}
	else
	{
		self thread play_next_killstreak_dialog();
	}
}

/*
	Name: wait_for_player_dialog
	Namespace: globallogic_audio
	Checksum: 0x5A998354
	Offset: 0x1D60
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function wait_for_player_dialog()
{
	self endon(#"disconnect", #"flush_dialog");
	level endon(#"game_ended");
	while(self.playingdialog)
	{
		wait(0.5);
	}
	self thread play_next_killstreak_dialog();
}

/*
	Name: play_next_killstreak_dialog
	Namespace: globallogic_audio
	Checksum: 0x97F12C48
	Offset: 0x1DD8
	Size: 0x38C
	Parameters: 0
	Flags: Linked
*/
function play_next_killstreak_dialog()
{
	self endon(#"disconnect", #"flush_dialog");
	level endon(#"game_ended");
	if(self.killstreakdialogqueue.size == 0)
	{
		self.currentkillstreakdialog = undefined;
		return;
	}
	if(isdefined(self.pers[#"mptaacom"]))
	{
		taacombundle = struct::get_script_bundle("mpdialog_taacom", self.pers[#"mptaacom"]);
	}
	else
	{
		self.killstreakdialogqueue = [];
		self.currentkillstreakdialog = undefined;
		return;
	}
	dialogalias = undefined;
	while(!isdefined(dialogalias) && self.killstreakdialogqueue.size > 0)
	{
		nextdialog = self.killstreakdialogqueue[0];
		arrayremoveindex(self.killstreakdialogqueue, 0);
		if(isdefined(nextdialog.killstreaktype))
		{
			if(isdefined(nextdialog.pilotindex))
			{
				pilotarray = taacombundle.pilotbundles[nextdialog.killstreaktype];
				if(isdefined(pilotarray) && nextdialog.pilotindex < pilotarray.size)
				{
					killstreakbundle = struct::get_script_bundle("mpdialog_scorestreak", pilotarray[nextdialog.pilotindex]);
					if(isdefined(killstreakbundle))
					{
						dialogalias = get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
					}
				}
			}
			else if(isdefined(nextdialog.killstreaktype))
			{
				killstreakbundle = function_6e084fd3(nextdialog.killstreaktype, taacombundle);
				if(isdefined(killstreakbundle))
				{
					dialogalias = self get_dialog_bundle_alias(killstreakbundle, nextdialog.dialogkey);
				}
			}
		}
		else
		{
			dialogalias = self get_dialog_bundle_alias(taacombundle, nextdialog.dialogkey);
		}
	}
	if(!isdefined(dialogalias))
	{
		self.currentkillstreakdialog = undefined;
		return;
	}
	waittime = 0;
	if(isdefined(nextdialog.var_46bd7973) && isdefined(nextdialog.var_8a6b001a) && isalive(nextdialog.var_8a6b001a))
	{
		waittime = waittime + battlechatter::mpdialog_value("taacomHackAndReplyDialogBuffer", 0);
		self thread function_30f16f29(nextdialog.var_46bd7973, nextdialog.var_8a6b001a, nextdialog.weapon);
	}
	else
	{
		self playlocalsound(dialogalias);
		waittime = waittime + battlechatter::mpdialog_value("killstreakDialogBuffer", 0);
	}
	self.currentkillstreakdialog = nextdialog;
	self thread wait_next_killstreak_dialog(waittime);
}

/*
	Name: wait_next_killstreak_dialog
	Namespace: globallogic_audio
	Checksum: 0xEC603E0
	Offset: 0x2170
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function wait_next_killstreak_dialog(waittime)
{
	self endon(#"disconnect", #"flush_dialog");
	level endon(#"game_ended");
	wait(waittime);
	self thread play_next_killstreak_dialog();
}

/*
	Name: function_30f16f29
	Namespace: globallogic_audio
	Checksum: 0x8DDC32B7
	Offset: 0x21D8
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function function_30f16f29(var_46bd7973, var_8a6b001a, weapon)
{
	if(isdefined(var_8a6b001a) && isalive(var_8a6b001a))
	{
		var_8a6b001a function_18aba49d(var_46bd7973, weapon, self);
	}
}

/*
	Name: leader_dialog_for_other_teams
	Namespace: globallogic_audio
	Checksum: 0x9E958ABD
	Offset: 0x2248
	Size: 0xE0
	Parameters: 5
	Flags: Linked
*/
function leader_dialog_for_other_teams(dialogkey, skipteam, objectivekey, killstreakid, dialogbufferkey)
{
	/#
		assert(isdefined(skipteam));
	#/
	foreach(team, _ in level.teams)
	{
		if(team != skipteam)
		{
			leader_dialog(dialogkey, team, undefined, objectivekey, killstreakid, dialogbufferkey);
		}
	}
}

/*
	Name: leader_dialog
	Namespace: globallogic_audio
	Checksum: 0x98567C30
	Offset: 0x2330
	Size: 0x160
	Parameters: 6
	Flags: Linked
*/
function leader_dialog(dialogkey, team, excludelist, objectivekey, killstreakid, dialogbufferkey)
{
	/#
		assert(isdefined(level.players));
	#/
	foreach(player in level.players)
	{
		if(!isdefined(player.pers[#"team"]))
		{
			continue;
		}
		if(isdefined(team) && team != player.pers[#"team"])
		{
			continue;
		}
		if(isdefined(excludelist) && globallogic_utils::isexcluded(player, excludelist))
		{
			continue;
		}
		player leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey);
	}
}

/*
	Name: leader_dialog_on_player
	Namespace: globallogic_audio
	Checksum: 0xC4548117
	Offset: 0x2498
	Size: 0x3C4
	Parameters: 5
	Flags: Linked
*/
function leader_dialog_on_player(dialogkey, objectivekey, killstreakid, dialogbufferkey, introdialog)
{
	if(!isdefined(dialogkey))
	{
		return;
	}
	if(!level.allowannouncer)
	{
		return;
	}
	if(!(isdefined(self.playleaderdialog) && self.playleaderdialog) && (!(isdefined(introdialog) && introdialog)))
	{
		return;
	}
	self flush_objective_dialog_on_player(objectivekey);
	if(!isdefined(self.leaderdialogqueue))
	{
		self.leaderdialogqueue = [];
	}
	if(self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && isdefined(objectivekey) && self.currentleaderdialog.objectivekey === objectivekey && self.currentleaderdialog.dialogkey == dialogkey)
	{
		return;
	}
	if(isdefined(killstreakid))
	{
		foreach(item in self.leaderdialogqueue)
		{
			if(item.dialogkey == dialogkey)
			{
				item.killstreakids[item.killstreakids.size] = killstreakid;
				return;
			}
		}
		if(self.leaderdialogqueue.size == 0 && isdefined(self.currentleaderdialog) && self.currentleaderdialog.dialogkey == dialogkey)
		{
			if(self.currentleaderdialog.playmultiple === 1)
			{
				return;
			}
			playmultiple = 1;
		}
	}
	newitem = spawnstruct();
	newitem.priority = dialogkey_priority(dialogkey);
	newitem.dialogkey = dialogkey;
	newitem.multipledialogkey = level.multipledialogkeys[dialogkey];
	newitem.playmultiple = playmultiple;
	newitem.objectivekey = objectivekey;
	if(isdefined(killstreakid))
	{
		newitem.killstreakids = [];
		newitem.killstreakids[0] = killstreakid;
	}
	newitem.dialogbufferkey = dialogbufferkey;
	iteminserted = 0;
	if(isdefined(newitem.priority))
	{
		for(i = 0; i < self.leaderdialogqueue.size; i++)
		{
			if(isdefined(self.leaderdialogqueue[i].priority) && self.leaderdialogqueue[i].priority <= newitem.priority)
			{
				continue;
			}
			arrayinsert(self.leaderdialogqueue, newitem, i);
			iteminserted = 1;
			break;
		}
	}
	if(!iteminserted)
	{
		self.leaderdialogqueue[self.leaderdialogqueue.size] = newitem;
	}
	if(isdefined(self.currentleaderdialog))
	{
		return;
	}
	self thread play_next_leader_dialog();
}

/*
	Name: play_next_leader_dialog
	Namespace: globallogic_audio
	Checksum: 0xB3B31B0E
	Offset: 0x2868
	Size: 0x2B4
	Parameters: 0
	Flags: Linked
*/
function play_next_leader_dialog()
{
	self endon(#"disconnect", #"flush_dialog");
	level endon(#"game_ended");
	if(!isdefined(self.leaderdialogqueue) || self.leaderdialogqueue.size == 0)
	{
		self.currentleaderdialog = undefined;
		return;
	}
	nextdialog = self.leaderdialogqueue[0];
	arrayremoveindex(self.leaderdialogqueue, 0);
	dialogkey = nextdialog.dialogkey;
	if(isdefined(nextdialog.killstreakids))
	{
		triggeredcount = 0;
		foreach(killstreakid in nextdialog.killstreakids)
		{
			if(isdefined(level.killstreaks_triggered[killstreakid]))
			{
				triggeredcount++;
			}
		}
		if(triggeredcount == 0)
		{
			self thread play_next_leader_dialog();
			return;
		}
		if(triggeredcount > 1 || nextdialog.playmultiple === 1)
		{
			if(isdefined(level.multipledialogkeys[dialogkey]))
			{
				dialogkey = level.multipledialogkeys[dialogkey];
			}
		}
	}
	if(dialogkey === "gamePlayerKicked")
	{
		self function_18aba49d(2);
	}
	else
	{
		dialogalias = self get_commander_dialog_alias(dialogkey);
		if(!isdefined(dialogalias))
		{
			self thread play_next_leader_dialog();
			return;
		}
		self playlocalsound(dialogalias);
	}
	nextdialog.playtime = gettime();
	self.currentleaderdialog = nextdialog;
	dialogbuffer = battlechatter::mpdialog_value(nextdialog.dialogbufferkey, battlechatter::mpdialog_value("commanderDialogBuffer", 0));
	self thread wait_next_leader_dialog(dialogbuffer);
}

/*
	Name: wait_next_leader_dialog
	Namespace: globallogic_audio
	Checksum: 0xF90BBD5F
	Offset: 0x2B28
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function wait_next_leader_dialog(dialogbuffer)
{
	self endon(#"disconnect", #"flush_dialog");
	level endon(#"game_ended");
	wait(dialogbuffer);
	self thread play_next_leader_dialog();
}

/*
	Name: dialogkey_priority
	Namespace: globallogic_audio
	Checksum: 0x4A98B65
	Offset: 0x2B90
	Size: 0x6A4
	Parameters: 1
	Flags: Linked
*/
function dialogkey_priority(dialogkey)
{
	switch(dialogkey)
	{
		case "enemydartmultiple":
		case "enemyhelicoptergunner":
		case "enemyrcbomb":
		case "enemydronestrikemultiple":
		case "enemyplanemortarmultiple":
		case "enemyaitank":
		case "enemymicrowaveturretmultiple":
		case "enemyplanemortar":
		case "enemyrapsmultiple":
		case "enemycombatrobot":
		case "enemyturretmultiple":
		case "enemydronestrike":
		case "enemyturret":
		case "enemyhelicoptergunnermultiple":
		case "enemyrcbombmultiple":
		case "enemyremotemissilemultiple":
		case "enemyraps":
		case "enemyplanemortarused":
		case "enemyhelicoptermultiple":
		case "enemymicrowaveturret":
		case "enemyaitankmultiple":
		case "enemydart":
		case "enemyremotemissile":
		case "enemycombatrobotmultiple":
		case "enemyhelicopter":
		{
			return 1;
		}
		case "gamelosing":
		case "nearwinning":
		case "nearlosing":
		case "roundencouragelastplayer":
		case "gamewinning":
		case "gameleadtaken":
		case "gameleadlost":
		case "neardrawing":
		{
			return 1;
		}
		case "upltheydrop":
		case "domenemyhasc":
		case "domenemyhasb":
		case "domenemyhasa":
		case "bombenemytaken":
		case "uplwetake":
		case "sfgrobotcloseattacker":
		case "bombdefused":
		case "domenemysecuringc":
		case "domenemysecuringb":
		case "domenemysecuringa":
		case "kothlocated":
		case "upltheyuplink":
		case "uplorders":
		case "sfgrobotneedreboot":
		case "domfriendlysecuredall":
		case "hubsonline":
		case "sfgstarttow":
		case "sfgtheyreturn":
		case "sfgrobotunderfire":
		case "kothonline":
		case "bombfriendlytaken":
		case "ctffriendlyflagcaptured":
		case "sfgrobotrebootedtowdefender":
		case "hubmoved":
		case "sfgrobotrebootedtowattacker":
		case "uplweuplinkremote":
		case "bombplanted":
		case "uplreset":
		case "sfgrobotrebooteddefender":
		case "ctfenemyflagdropped":
		case "sfgrobotunderfireneutral":
		case "ctffriendlyflagdropped":
		case "kothcontested":
		case "ctfenemyflagtaken":
		case "uplwedrop":
		case "uplweuplink":
		case "hubsoffline":
		case "domenemysecureda":
		case "domenemysecuredb":
		case "domenemysecuredc":
		case "upltransferred":
		case "sfgstarthrdefend":
		case "upltheyuplinkremote":
		case "ctfenemyflagreturned":
		case "sfgstarthrattack":
		case "sfgrobotclosedefender":
		case "kothsecured":
		case "sfgwereturn":
		case "hubsmoved":
		case "sfgstartattack":
		case "ctfenemyflagcaptured":
		case "sfgrobotdisabledattacker":
		case "sfgrobotrebootedattacker":
		case "hubonline":
		case "sfgstartdefend":
		case "ctffriendlyflagreturned":
		case "ctffriendlyflagtaken":
		case "upltheytake":
		case "huboffline":
		case "sfgrobotdisableddefender":
		case "domfriendlysecuredc":
		case "domfriendlysecuredb":
		case "domfriendlysecureda":
		case "kothcaptured":
		case "kothlost":
		case "bombfriendlydropped":
		case "domfriendlysecuringb":
		case "domfriendlysecuringc":
		case "domfriendlysecuringa":
		{
			return 1;
		}
	}
	return undefined;
}

/*
	Name: play_equipment_destroyed_on_player
	Namespace: globallogic_audio
	Checksum: 0x4B22E369
	Offset: 0x3240
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function play_equipment_destroyed_on_player()
{
	self play_taacom_dialog("equipmentDestroyed");
}

/*
	Name: play_equipment_hacked_on_player
	Namespace: globallogic_audio
	Checksum: 0xA0A8D6BD
	Offset: 0x3270
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function play_equipment_hacked_on_player()
{
	self play_taacom_dialog("equipmentHacked");
}

/*
	Name: get_commander_dialog_alias
	Namespace: globallogic_audio
	Checksum: 0x385457A3
	Offset: 0x32A0
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function get_commander_dialog_alias(dialogkey)
{
	if(!isdefined(self.pers[#"mpcommander"]))
	{
		return undefined;
	}
	commanderbundle = struct::get_script_bundle("mpdialog_commander", self.pers[#"mpcommander"]);
	return get_dialog_bundle_alias(commanderbundle, dialogkey);
}

/*
	Name: get_dialog_bundle_alias
	Namespace: globallogic_audio
	Checksum: 0x28B0E6C2
	Offset: 0x3328
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function get_dialog_bundle_alias(dialogbundle, dialogkey)
{
	if(!isdefined(dialogbundle) || !isdefined(dialogkey))
	{
		return undefined;
	}
	dialogalias = dialogbundle.(dialogkey);
	if(!isdefined(dialogalias))
	{
		return;
	}
	voiceprefix = dialogbundle.("voiceprefix");
	if(isdefined(voiceprefix))
	{
		dialogalias = voiceprefix + dialogalias;
	}
	return dialogalias;
}

/*
	Name: is_team_winning
	Namespace: globallogic_audio
	Checksum: 0xB92929D0
	Offset: 0x33B8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function is_team_winning(checkteam)
{
	score = game.stat[#"teamscores"][checkteam];
	foreach(team, _ in level.teams)
	{
		if(team != checkteam)
		{
			if(game.stat[#"teamscores"][team] >= score)
			{
				return false;
			}
		}
	}
	return true;
}

/*
	Name: announce_team_is_winning
	Namespace: globallogic_audio
	Checksum: 0x57F6E58A
	Offset: 0x3498
	Size: 0xC0
	Parameters: 0
	Flags: Linked
*/
function announce_team_is_winning()
{
	foreach(team, _ in level.teams)
	{
		if(is_team_winning(team))
		{
			leader_dialog("gameWinning", team);
			leader_dialog_for_other_teams("gameLosing", team);
			return true;
		}
	}
	return false;
}

/*
	Name: play_2d_on_team
	Namespace: globallogic_audio
	Checksum: 0x1CB9C5B5
	Offset: 0x3560
	Size: 0xD6
	Parameters: 2
	Flags: None
*/
function play_2d_on_team(alias, team)
{
	/#
		assert(isdefined(level.players));
	#/
	for(i = 0; i < level.players.size; i++)
	{
		player = level.players[i];
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
		{
			player playlocalsound(alias);
		}
	}
}

/*
	Name: get_round_switch_dialog
	Namespace: globallogic_audio
	Checksum: 0x54E1C77D
	Offset: 0x3640
	Size: 0x6A
	Parameters: 1
	Flags: None
*/
function get_round_switch_dialog(switchtype)
{
	switch(switchtype)
	{
		case 2:
		{
			return "roundHalftime";
		}
		case 4:
		{
			return "roundOvertime";
		}
		default:
		{
			return "roundSwitchSides";
		}
	}
}

/*
	Name: on_end_game
	Namespace: globallogic_audio
	Checksum: 0xAD8ADEE3
	Offset: 0x36B8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	level util::clientnotify("pm");
	level waittill(#"sfade");
	level util::clientnotify("pmf");
}

/*
	Name: announcercontroller
	Namespace: globallogic_audio
	Checksum: 0x6212B761
	Offset: 0x3720
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function announcercontroller()
{
	level endon(#"game_ended");
	level waittill(#"match_ending_soon");
	if(util::islastround() || util::isoneround())
	{
		if(level.teambased)
		{
			if(!announce_team_is_winning())
			{
				leader_dialog("min_draw");
			}
		}
		level waittill(#"match_ending_very_soon");
		foreach(team, _ in level.teams)
		{
			leader_dialog("roundTimeWarning", team, undefined, undefined);
		}
	}
	else
	{
		level waittill(#"match_ending_vox");
		leader_dialog("roundTimeWarning");
	}
}

/*
	Name: sndmusicfunctions
	Namespace: globallogic_audio
	Checksum: 0x2A039BFD
	Offset: 0x3898
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function sndmusicfunctions()
{
	level thread sndmusictimesout();
	level thread sndmusichalfway();
	level thread sndmusictimelimitwatcher();
	level thread sndmusicunlock();
}

/*
	Name: sndmusicsetrandomizer
	Namespace: globallogic_audio
	Checksum: 0x7A0E0DD8
	Offset: 0x3908
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function sndmusicsetrandomizer()
{
	if(isdefined(level.var_30783ca9))
	{
		level thread [[level.var_30783ca9]]();
		return;
	}
	if(game.roundsplayed == 0)
	{
		game.musicset = randomintrange(1, 8);
		if(game.musicset <= 9)
		{
			game.musicset = "0" + game.musicset;
		}
		game.musicset = "_" + game.musicset;
	}
}

/*
	Name: sndmusicunlock
	Namespace: globallogic_audio
	Checksum: 0x4B032DBF
	Offset: 0x39B8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function sndmusicunlock()
{
	level waittill(#"game_ended");
	unlockname = undefined;
	switch(game.musicset)
	{
		case "_01":
		{
			unlockname = "mus_dystopia_intro";
			break;
		}
		case "_02":
		{
			unlockname = "mus_filter_intro";
			break;
		}
		case "_03":
		{
			unlockname = "mus_immersion_intro";
			break;
		}
		case "_04":
		{
			unlockname = "mus_ruin_intro";
			break;
		}
		case "_05":
		{
			unlockname = "mus_cod_bites_intro";
			break;
		}
	}
	if(isdefined(unlockname))
	{
		level thread audio::unlockfrontendmusic(unlockname);
	}
}

/*
	Name: sndmusictimesout
	Namespace: globallogic_audio
	Checksum: 0xBBFC0251
	Offset: 0x3AC8
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function sndmusictimesout()
{
	level endon(#"game_ended", #"musicendingoverride");
	level waittill(#"match_ending_very_soon");
	if(isdefined(level.gametype) && level.gametype == "sd")
	{
		level thread set_music_on_team("timeOutQuiet");
	}
	else
	{
		level thread set_music_on_team("timeOut");
	}
}

/*
	Name: sndmusichalfway
	Namespace: globallogic_audio
	Checksum: 0x777DC260
	Offset: 0x3B80
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function sndmusichalfway()
{
	level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon");
	level waittill(#"sndmusichalfway");
	level thread set_music_on_team("underscore");
}

/*
	Name: sndmusictimelimitwatcher
	Namespace: globallogic_audio
	Checksum: 0xD3DCF8FB
	Offset: 0x3C00
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function sndmusictimelimitwatcher()
{
	level endon(#"game_ended", #"match_ending_soon", #"match_ending_very_soon", #"sndmusichalfway");
	if(!isdefined(level.timelimit) || level.timelimit == 0)
	{
		return;
	}
	halfway = (level.timelimit * 60) * 0.5;
	while(true)
	{
		timeleft = float(globallogic_utils::gettimeremaining()) / 1000;
		if(timeleft <= halfway)
		{
			level notify(#"sndmusichalfway");
			return;
		}
		wait(2);
	}
}

/*
	Name: set_music_on_team
	Namespace: globallogic_audio
	Checksum: 0x3B81E367
	Offset: 0x3D08
	Size: 0x198
	Parameters: 5
	Flags: Linked
*/
function set_music_on_team(state, team = "both", wait_time = 0, save_state = 0, return_state = 0)
{
	/#
		assert(isdefined(level.players));
	#/
	foreach(player in level.players)
	{
		if(team == "both")
		{
			player thread set_music_on_player(state, wait_time, save_state, return_state);
			continue;
		}
		if(isdefined(player.pers[#"team"]) && player.pers[#"team"] == team)
		{
			player thread set_music_on_player(state, wait_time, save_state, return_state);
		}
	}
}

/*
	Name: set_music_on_player
	Namespace: globallogic_audio
	Checksum: 0xB363E462
	Offset: 0x3EA8
	Size: 0x104
	Parameters: 4
	Flags: Linked
*/
function set_music_on_player(state, wait_time = 0, save_state = 0, return_state = 0)
{
	self endon(#"disconnect");
	/#
		assert(isplayer(self));
	#/
	if(!isdefined(state))
	{
		return;
	}
	if(!isdefined(game.musicset))
	{
		return;
	}
	if(sessionmodeiswarzonegame())
	{
		return;
	}
	if(isdefined(level.var_903e2252) && level.var_903e2252)
	{
		return;
	}
	music::setmusicstate(state + game.musicset, self);
}

/*
	Name: set_music_global
	Namespace: globallogic_audio
	Checksum: 0x1CB7FD3E
	Offset: 0x3FB8
	Size: 0xC4
	Parameters: 4
	Flags: None
*/
function set_music_global(state, wait_time = 0, save_state = 0, return_state = 0)
{
	if(!isdefined(state))
	{
		return;
	}
	if(!isdefined(game.musicset))
	{
		return;
	}
	if(isdefined(level.var_903e2252) && level.var_903e2252)
	{
		return;
	}
	if(sessionmodeiswarzonegame())
	{
		return;
	}
	music::setmusicstate(state + game.musicset);
}

/*
	Name: function_85818e24
	Namespace: globallogic_audio
	Checksum: 0xD38EA1F0
	Offset: 0x4088
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_85818e24(var_9c1ed9ea, team)
{
	if(!isdefined(game.musicset))
	{
		return;
	}
	if(!isdefined(var_9c1ed9ea))
	{
		return;
	}
	if(isdefined(team))
	{
		foreach(player in level.players)
		{
			if(!isdefined(player.pers[#"team"]))
			{
				continue;
			}
			if(isdefined(team) && team != player.pers[#"team"])
			{
				continue;
			}
			music::setmusicstate(var_9c1ed9ea + game.musicset, player);
		}
	}
	else
	{
		music::setmusicstate(var_9c1ed9ea + game.musicset);
	}
}

