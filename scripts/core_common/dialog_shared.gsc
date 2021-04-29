// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace dialog_shared;

/*
	Name: function_89f2df9
	Namespace: dialog_shared
	Checksum: 0x441B026A
	Offset: 0xCB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"dialog_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: dialog_shared
	Checksum: 0xA81AFC2F
	Offset: 0xD00
	Size: 0xB3A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		level thread devgui_think();
	#/
	if(!sessionmodeismultiplayergame() || !function_f99d2668())
	{
		callback::on_joined_team(&on_joined_team);
		callback::on_spawned(&on_player_spawned);
		callback::on_player_damage(&taking_fire_vox);
	}
	level.heroplaydialog = &play_dialog;
	level.playgadgetready = &play_gadget_ready;
	level.playgadgetactivate = &play_gadget_activate;
	level.playgadgetsuccess = &play_gadget_success;
	level.playpromotionreaction = &play_promotion_reaction;
	level.playthrowhatchet = &play_throw_hatchet;
	level.playgadgetoff = &play_gadget_off;
	level.var_da2d586a = &function_78c16252;
	level.bcsounds = [];
	level.bcsounds[#"incoming_alert"] = [];
	level.bcsounds[#"incoming_alert"][#"frag_grenade"] = "incomingFrag";
	level.bcsounds[#"incoming_alert"][#"incendiary_grenade"] = "incomingIncendiary";
	level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "incomingSemtex";
	level.bcsounds[#"incoming_alert"][#"launcher_standard"] = "threatRpg";
	level.bcsounds[#"incoming_delay"] = [];
	level.bcsounds[#"incoming_delay"][#"frag_grenade"] = "fragGrenadeDelay";
	level.bcsounds[#"incoming_delay"][#"incendiary_grenade"] = "incendiaryGrenadeDelay";
	level.bcsounds[#"incoming_alert"][#"sticky_grenade"] = "semtexDelay";
	level.bcsounds[#"incoming_delay"][#"launcher_standard"] = "missileDelay";
	level.bcsounds[#"kill_dialog"] = [];
	level.bcsounds[#"kill_dialog"][#"battery"] = "killBattery";
	level.bcsounds[#"kill_dialog"][#"buffassault"] = "killBuffAssault";
	level.bcsounds[#"kill_dialog"][#"engineer"] = "killEngineer";
	level.bcsounds[#"kill_dialog"][#"firebreak"] = "killFirebreak";
	level.bcsounds[#"kill_dialog"][#"nomad"] = "killNomad";
	level.bcsounds[#"kill_dialog"][#"prophet"] = "killProphet";
	level.bcsounds[#"kill_dialog"][#"recon"] = "killRecon";
	level.bcsounds[#"kill_dialog"][#"ruin"] = "killRuin";
	level.bcsounds[#"kill_dialog"][#"seraph"] = "killSeraph";
	level.bcsounds[#"kill_dialog"][#"swatpolice"] = "killSwatPolice";
	level.bcsounds[#"kill_dialog"][#"outrider"] = "killOutrider";
	level.bcsounds[#"kill_dialog"][#"reaper"] = "killReaper";
	level.bcsounds[#"kill_dialog"][#"spectre"] = "killSpectre";
	if(level.teambased && !isdefined(game.boostplayerspicked))
	{
		game.boostplayerspicked = [];
		foreach(team, _ in level.teams)
		{
			game.boostplayerspicked[team] = 0;
		}
	}
	level.allowbattlechatter[#"bc"] = getgametypesetting(#"allowbattlechatter");
	clientfield::register("world", "boost_number", 1, 2, "int");
	clientfield::register("allplayers", "play_boost", 1, 2, "int");
	level thread pick_boost_number();
	keycounts = [];
	playerdialogbundles = struct::get_script_bundles("mpdialog_player");
	foreach(bundle in playerdialogbundles)
	{
		count_keys(keycounts, bundle, "killGeneric");
		count_keys(keycounts, bundle, "killSniper");
		count_keys(keycounts, bundle, "killBattery");
		count_keys(keycounts, bundle, "killBuffAssault");
		count_keys(keycounts, bundle, "killEngineer");
		count_keys(keycounts, bundle, "killFirebreak");
		count_keys(keycounts, bundle, "killNomad");
		count_keys(keycounts, bundle, "killProphet");
		count_keys(keycounts, bundle, "killRecon");
		count_keys(keycounts, bundle, "killRuin");
		count_keys(keycounts, bundle, "killSeraph");
		count_keys(keycounts, bundle, "killSwatPolice");
		count_keys(keycounts, bundle, "killOutrider");
		count_keys(keycounts, bundle, "killReaper");
		count_keys(keycounts, bundle, "killSpectre");
	}
	level.var_f53efe5c = keycounts;
	if(function_f99d2668())
	{
		level.var_f53efe5c = undefined;
	}
	level.allowspecialistdialog = mpdialog_value("enableHeroDialog", 0) && (isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"]);
	level.playstartconversation = mpdialog_value("enableConversation", 0) && (isdefined(level.allowbattlechatter[#"bc"]) && level.allowbattlechatter[#"bc"]);
}

/*
	Name: flush_dialog
	Namespace: dialog_shared
	Checksum: 0x4582BA1A
	Offset: 0x1848
	Size: 0x80
	Parameters: 0
	Flags: None
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
	Namespace: dialog_shared
	Checksum: 0xF45DFBE9
	Offset: 0x18D0
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function flush_dialog_on_player()
{
	self.leaderdialogqueue = [];
	self.currentleaderdialog = undefined;
	self.killstreakdialogqueue = [];
	self.scorestreakdialogplaying = 0;
	self notify(#"flush_dialog");
}

/*
	Name: get_dialog_bundle_alias
	Namespace: dialog_shared
	Checksum: 0x4447C10
	Offset: 0x1918
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
	Name: pick_boost_number
	Namespace: dialog_shared
	Checksum: 0x36E700DB
	Offset: 0x19A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function pick_boost_number()
{
	wait(5);
	level clientfield::set("boost_number", randomint(4));
}

/*
	Name: on_joined_team
	Namespace: dialog_shared
	Checksum: 0x2896DA77
	Offset: 0x19F0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function on_joined_team(params)
{
	self endon(#"disconnect");
	if(level.teambased)
	{
		if(self.team == #"allies")
		{
			self set_blops_dialog();
		}
		else
		{
			self set_cdp_dialog();
		}
	}
	else if(randomintrange(0, 2))
	{
		self set_blops_dialog();
	}
	else
	{
		self set_cdp_dialog();
	}
	self flush_dialog_on_player();
}

/*
	Name: set_blops_dialog
	Namespace: dialog_shared
	Checksum: 0xB0695C35
	Offset: 0x1AD8
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function set_blops_dialog()
{
	self.pers[#"mptaacom"] = "blops_taacom";
	self.pers[#"mpcommander"] = "blops_commander";
}

/*
	Name: set_cdp_dialog
	Namespace: dialog_shared
	Checksum: 0x322E87C4
	Offset: 0x1B28
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function set_cdp_dialog()
{
	self.pers[#"mptaacom"] = "cdp_taacom";
	self.pers[#"mpcommander"] = "cdp_commander";
}

/*
	Name: on_player_spawned
	Namespace: dialog_shared
	Checksum: 0x51A5AC2C
	Offset: 0x1B78
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self.enemythreattime = 0;
	self.heartbeatsnd = 0;
	self.soundmod = "player";
	self.voxunderwatertime = 0;
	self.voxemergebreath = 0;
	self.voxdrowning = 0;
	self.pilotisspeaking = 0;
	self.playingdialog = 0;
	self.playinggadgetreadydialog = 0;
	self.playedgadgetsuccess = 1;
	if(!level.allowbattlechatter[#"bc"])
	{
		return;
	}
	self thread water_vox();
	if(level.teambased)
	{
		self thread enemy_threat();
		self thread check_boost_start_conversation();
	}
}

/*
	Name: dialog_chance
	Namespace: dialog_shared
	Checksum: 0x621CC427
	Offset: 0x1C68
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function dialog_chance(chancekey)
{
	dialogchance = mpdialog_value(chancekey);
	if(!isdefined(dialogchance) || dialogchance <= 0)
	{
		return 0;
	}
	if(dialogchance >= 100)
	{
		return 1;
	}
	return randomint(100) < dialogchance;
}

/*
	Name: mpdialog_value
	Namespace: dialog_shared
	Checksum: 0xE1671BDF
	Offset: 0x1CF0
	Size: 0x86
	Parameters: 2
	Flags: Linked
*/
function mpdialog_value(mpdialogkey, defaultvalue)
{
	if(!isdefined(mpdialogkey))
	{
		return defaultvalue;
	}
	mpdialog = struct::get_script_bundle("mpdialog", "mpdialog_default");
	if(!isdefined(mpdialog))
	{
		return defaultvalue;
	}
	structvalue = mpdialog.(mpdialogkey);
	if(!isdefined(structvalue))
	{
		return defaultvalue;
	}
	return structvalue;
}

/*
	Name: water_vox
	Namespace: dialog_shared
	Checksum: 0xE79C65F8
	Offset: 0x1D80
	Size: 0x232
	Parameters: 0
	Flags: Linked
*/
function water_vox()
{
	self endon(#"death");
	level endon(#"game_ended");
	interval = mpdialog_value("underwaterInterval", float(function_60d95f53()) / 1000);
	if(interval <= 0)
	{
		/#
			assert(interval > 0, "");
		#/
		return;
	}
	while(true)
	{
		wait(interval);
		if(self isplayerunderwater())
		{
			if(!self.voxunderwatertime && !self.voxemergebreath)
			{
				self stopsounds();
				self.voxunderwatertime = gettime();
			}
			else if(self.voxunderwatertime)
			{
				if(gettime() > self.voxunderwatertime + int(mpdialog_value("underwaterBreathTime", 0) * 1000))
				{
					self.voxunderwatertime = 0;
					self.voxemergebreath = 1;
				}
			}
		}
		else if(self.voxdrowning)
		{
			self thread play_dialog("exertEmergeGasp", 20, mpdialog_value("playerExertBuffer", 0));
			self.voxdrowning = 0;
			self.voxemergebreath = 0;
		}
		else if(self.voxemergebreath)
		{
			self thread play_dialog("exertEmergeBreath", 20, mpdialog_value("playerExertBuffer", 0));
			self.voxemergebreath = 0;
		}
	}
}

/*
	Name: taking_fire_vox
	Namespace: dialog_shared
	Checksum: 0x60F7A11A
	Offset: 0x1FC0
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function taking_fire_vox(params)
{
	if(isdefined(params.eattacker) && (isai(params.eattacker) || isvehicle(params.eattacker) || isplayer(params.eattacker)))
	{
		if(isdefined(params.eattacker.team) && util::function_fbce7263(self.team, params.eattacker.team))
		{
			takingfire_cooldown = "taking_fire_vo_" + string(self.team);
			if(level util::iscooldownready(takingfire_cooldown))
			{
				self play_dialog("takingFire", 1);
				level util::cooldown(takingfire_cooldown, 5);
			}
		}
	}
}

/*
	Name: pain_vox
	Namespace: dialog_shared
	Checksum: 0x9CB4CC96
	Offset: 0x2110
	Size: 0x134
	Parameters: 1
	Flags: None
*/
function pain_vox(meansofdeath)
{
	if(dialog_chance("smallPainChance"))
	{
		if(meansofdeath == "MOD_DROWN")
		{
			dialogkey = "exertPainDrowning";
			self.voxdrowning = 1;
		}
		else if(meansofdeath == "MOD_DOT" || meansofdeath == "MOD_DOT_SELF")
		{
			if(!isdefined(self.var_dbffaa32))
			{
				return;
			}
			dialogkey = "exertPainDamageTick";
		}
		else if(meansofdeath == "MOD_FALLING")
		{
			dialogkey = "exertPainFalling";
		}
		else if(self isplayerunderwater())
		{
			dialogkey = "exertPainUnderwater";
		}
		else
		{
			dialogkey = "exertPain";
		}
		exertbuffer = mpdialog_value("playerExertBuffer", 0);
		self thread play_dialog(dialogkey, 30, exertbuffer);
	}
}

/*
	Name: on_player_suicide_or_team_kill
	Namespace: dialog_shared
	Checksum: 0x85BE4E73
	Offset: 0x2250
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function on_player_suicide_or_team_kill(player, type)
{
	self endon(#"death");
	level endon(#"game_ended");
	waittillframeend();
	if(!level.teambased)
	{
		return;
	}
}

/*
	Name: on_player_near_explodable
	Namespace: dialog_shared
	Checksum: 0x86961E39
	Offset: 0x22A8
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function on_player_near_explodable(object, type)
{
	self endon(#"death");
	level endon(#"game_ended");
}

/*
	Name: enemy_threat
	Namespace: dialog_shared
	Checksum: 0x9CDCA887
	Offset: 0x22F0
	Size: 0x2C6
	Parameters: 0
	Flags: Linked
*/
function enemy_threat()
{
	self endon(#"death");
	level endon(#"game_ended");
	while(true)
	{
		self waittill(#"weapon_ads");
		if(self hasperk(#"specialty_quieter"))
		{
			continue;
		}
		if(self.enemythreattime + int(mpdialog_value("enemyContactInterval", 0) * 1000) >= gettime())
		{
			continue;
		}
		closest_ally = self get_closest_player_ally(1);
		if(!isdefined(closest_ally))
		{
			continue;
		}
		allyradius = mpdialog_value("enemyContactAllyRadius", 0);
		if(distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius)
		{
			eyepoint = self geteye();
			dir = anglestoforward(self getplayerangles());
			dir = dir * mpdialog_value("enemyContactDistance", 0);
			endpoint = eyepoint + dir;
			traceresult = bullettrace(eyepoint, endpoint, 1, self);
			if(isdefined(traceresult[#"entity"]) && traceresult[#"entity"].classname == "player" && util::function_fbce7263(traceresult[#"entity"].team, self.team))
			{
				if(dialog_chance("enemyContactChance"))
				{
					self thread play_dialog("threatInfantry", 1);
					level notify(#"level_enemy_spotted", self.team);
					self.enemythreattime = gettime();
				}
			}
		}
	}
}

/*
	Name: killed_by_sniper
	Namespace: dialog_shared
	Checksum: 0x74CD150F
	Offset: 0x25C0
	Size: 0x25E
	Parameters: 1
	Flags: None
*/
function killed_by_sniper(sniper)
{
	self endon(#"disconnect");
	sniper endon(#"disconnect");
	level endon(#"game_ended");
	if(!level.teambased)
	{
		return 0;
	}
	waittillframeend();
	if(dialog_chance("sniperKillChance"))
	{
		closest_ally = self get_closest_player_ally();
		allyradius = mpdialog_value("sniperKillAllyRadius", 0);
		if(isdefined(closest_ally) && distancesquared(self.origin, closest_ally.origin) < allyradius * allyradius)
		{
			closest_ally thread play_dialog("threatSniper", 1);
			sniper.spottedtime = gettime();
			sniper.spottedby = [];
			players = self get_friendly_players();
			players = arraysort(players, self.origin);
			voiceradius = mpdialog_value("playerVoiceRadius", 0);
			voiceradiussq = voiceradius * voiceradius;
			foreach(player in players)
			{
				if(distancesquared(closest_ally.origin, player.origin) <= voiceradiussq)
				{
					sniper.spottedby[sniper.spottedby.size] = player;
				}
			}
		}
	}
}

/*
	Name: player_killed
	Namespace: dialog_shared
	Checksum: 0x1C70FD50
	Offset: 0x2828
	Size: 0x154
	Parameters: 2
	Flags: None
*/
function player_killed(attacker, killstreaktype)
{
	if(!level.teambased)
	{
		return;
	}
	if(self === attacker)
	{
		return;
	}
	waittillframeend();
	if(isdefined(killstreaktype))
	{
		if(!isdefined(level.killstreaks[killstreaktype]) || !isdefined(level.killstreaks[killstreaktype].threatonkill) || !level.killstreaks[killstreaktype].threatonkill || !dialog_chance("killstreakKillChance"))
		{
			return;
		}
		ally = get_closest_player_ally(1);
		allyradius = mpdialog_value("killstreakKillAllyRadius", 0);
		if(isdefined(ally) && distancesquared(self.origin, ally.origin) < allyradius * allyradius)
		{
			ally play_killstreak_threat(killstreaktype);
		}
	}
}

/*
	Name: heavyweaponkilllogic
	Namespace: dialog_shared
	Checksum: 0x5BA3695A
	Offset: 0x2988
	Size: 0xD4
	Parameters: 3
	Flags: Linked
*/
function heavyweaponkilllogic(attacker, weapon, victim)
{
	if(!isdefined(attacker.heavyweaponkillcount))
	{
		attacker.heavyweaponkillcount = 0;
	}
	attacker.heavyweaponkillcount++;
	if(!(isdefined(attacker.playedgadgetsuccess) && attacker.playedgadgetsuccess) && attacker.heavyweaponkillcount >= mpdialog_value("heroWeaponKillCount", 0))
	{
		attacker thread play_gadget_success(weapon, "enemyKillDelay", victim);
		attacker thread heavy_weapon_success_reaction();
	}
}

/*
	Name: playkillbattlechatter
	Namespace: dialog_shared
	Checksum: 0x3378BFBD
	Offset: 0x2A68
	Size: 0x98
	Parameters: 4
	Flags: None
*/
function playkillbattlechatter(attacker, weapon, victim, einflictor)
{
	if(isplayer(attacker))
	{
		level thread say_kill_battle_chatter(attacker, weapon, victim, einflictor);
	}
	if(isdefined(einflictor))
	{
		einflictor notify(#"bhtn_action_notify", {#action:"attack_kill"});
	}
}

/*
	Name: say_kill_battle_chatter
	Namespace: dialog_shared
	Checksum: 0xFD72BCEF
	Offset: 0x2B08
	Size: 0x3C4
	Parameters: 4
	Flags: Linked
*/
function say_kill_battle_chatter(attacker, weapon, victim, inflictor)
{
	if(weapon.skipbattlechatterkill || !isdefined(attacker) || !isplayer(attacker) || !isalive(attacker) || attacker isremotecontrolling() || attacker isinvehicle() || attacker isweaponviewonlylinked() || !isdefined(victim) || !isplayer(victim))
	{
		return;
	}
	if(isdefined(inflictor) && !isplayer(inflictor) && inflictor.birthtime < attacker.spawntime)
	{
		return;
	}
	if(weapon.isheavyweapon)
	{
		heavyweaponkilllogic(attacker, weapon, victim);
	}
	else if(isdefined(attacker.speedburston) && attacker.speedburston)
	{
		if(!(isdefined(attacker.speedburstkill) && attacker.speedburstkill))
		{
			speedburstkilldist = mpdialog_value("speedBurstKillDistance", 0);
			if(distancesquared(attacker.origin, victim.origin) < speedburstkilldist * speedburstkilldist)
			{
				attacker.speedburstkill = 1;
			}
		}
	}
	else if(dialog_chance("enemyKillChance"))
	{
		if(isdefined(victim.spottedtime) && victim.spottedtime + mpdialog_value("enemySniperKillTime", 0) >= gettime() && array::contains(victim.spottedby, attacker) && dialog_chance("enemySniperKillChance"))
		{
			killdialog = attacker get_random_key("killSniper");
		}
		else if(dialog_chance("enemyHeroKillChance"))
		{
			victimdialogname = victim getmpdialogname();
			killdialog = attacker get_random_key(level.bcsounds[#"kill_dialog"][victimdialogname]);
		}
		else
		{
			killdialog = attacker get_random_key("killGeneric");
		}
	}
	victim.spottedtime = undefined;
	victim.spottedby = undefined;
	if(!isdefined(killdialog))
	{
		return;
	}
	attacker thread wait_play_dialog(mpdialog_value("enemyKillDelay", 0), killdialog, 1, undefined, victim, "cancel_kill_dialog");
}

/*
	Name: function_28a568b9
	Namespace: dialog_shared
	Checksum: 0xA5759B72
	Offset: 0x2ED8
	Size: 0x194
	Parameters: 1
	Flags: Event
*/
event function_28a568b9(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	weapon = eventstruct.weapon;
	if(!isdefined(grenade.weapon) || !isdefined(grenade.weapon.rootweapon) || !dialog_chance("incomingProjectileChance"))
	{
		return;
	}
	dialogkey = level.bcsounds[#"incoming_alert"][grenade.weapon.rootweapon.name];
	if(isdefined(dialogkey))
	{
		waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][grenade.weapon.rootweapon.name], float(function_60d95f53()) / 1000);
		level thread incoming_projectile_alert(self, grenade, dialogkey, waittime);
	}
}

/*
	Name: function_54ca82b9
	Namespace: dialog_shared
	Checksum: 0xB4109534
	Offset: 0x3078
	Size: 0x17C
	Parameters: 1
	Flags: Event
*/
event function_54ca82b9(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	missile = eventstruct.projectile;
	if(!isdefined(missile.item) || !isdefined(missile.item.rootweapon) || !dialog_chance("incomingProjectileChance"))
	{
		return;
	}
	dialogkey = level.bcsounds[#"incoming_alert"][missile.item.rootweapon.name];
	if(isdefined(dialogkey))
	{
		waittime = mpdialog_value(level.bcsounds[#"incoming_delay"][missile.item.rootweapon.name], float(function_60d95f53()) / 1000);
		level thread incoming_projectile_alert(self, missile, dialogkey, waittime);
	}
}

/*
	Name: incoming_projectile_alert
	Namespace: dialog_shared
	Checksum: 0x63DE6CCD
	Offset: 0x3200
	Size: 0x192
	Parameters: 4
	Flags: Linked
*/
function incoming_projectile_alert(thrower, projectile, dialogkey, waittime)
{
	level endon(#"game_ended");
	if(waittime <= 0)
	{
		/#
			assert(waittime > 0, "");
		#/
		return;
	}
	while(true)
	{
		wait(waittime);
		if(waittime > 0.2)
		{
			waittime = waittime / 2;
		}
		if(!isdefined(projectile))
		{
			return;
		}
		if(!isdefined(thrower) || thrower.team == #"spectator")
		{
			return;
		}
		if(level.players.size)
		{
			closest_enemy = thrower get_closest_player_enemy(projectile.origin);
			incomingprojectileradius = mpdialog_value("incomingProjectileRadius", 0);
			if(isdefined(closest_enemy) && distancesquared(projectile.origin, closest_enemy.origin) < incomingprojectileradius * incomingprojectileradius)
			{
				closest_enemy thread play_dialog(dialogkey, 6);
				return;
			}
		}
	}
}

/*
	Name: function_2ad593d8
	Namespace: dialog_shared
	Checksum: 0xF2E24912
	Offset: 0x33A0
	Size: 0xBC
	Parameters: 1
	Flags: Event
*/
event function_2ad593d8(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	grenade = eventstruct.projectile;
	if(isalive(self) && isdefined(grenade) && isdefined(grenade.weapon))
	{
		if(grenade.weapon.rootweapon.name == "sticky_grenade")
		{
			self thread play_dialog("stuckSticky", 6);
		}
	}
}

/*
	Name: heavy_weapon_success_reaction
	Namespace: dialog_shared
	Checksum: 0xB9504A40
	Offset: 0x3468
	Size: 0x35C
	Parameters: 0
	Flags: Linked
*/
function heavy_weapon_success_reaction()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(!level.teambased)
	{
		return;
	}
	allies = [];
	allyradiussq = mpdialog_value("playerVoiceRadius", 0);
	allyradiussq = allyradiussq * allyradiussq;
	foreach(player in level.players)
	{
		if(!isdefined(player) || !isalive(player) || player.sessionstate != "playing" || player == self || util::function_fbce7263(player.team, self.team))
		{
			continue;
		}
		distsq = distancesquared(self.origin, player.origin);
		if(distsq > allyradiussq)
		{
			continue;
		}
		allies[allies.size] = player;
	}
	wait(mpdialog_value("enemyKillDelay", 0) + 0.1);
	while(self.playingdialog)
	{
		wait(0.5);
	}
	allies = arraysort(allies, self.origin);
	foreach(player in allies)
	{
		if(!isalive(player) || player.sessionstate != "playing" || player.playingdialog || player isplayerunderwater() || player isremotecontrolling() || player isinvehicle() || player isweaponviewonlylinked())
		{
			continue;
		}
		distsq = distancesquared(self.origin, player.origin);
		if(distsq > allyradiussq)
		{
			break;
		}
		player play_dialog("heroWeaponSuccessReaction", 1);
		break;
	}
}

/*
	Name: play_promotion_reaction
	Namespace: dialog_shared
	Checksum: 0xE7A79FA4
	Offset: 0x37D0
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function play_promotion_reaction()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(!level.teambased)
	{
		return;
	}
	wait(9);
	players = self get_friendly_players();
	players = arraysort(players, self.origin);
	selfdialog = self getmpdialogname();
	voiceradius = mpdialog_value("playerVoiceRadius", 0);
	voiceradiussq = voiceradius * voiceradius;
	foreach(player in players)
	{
		if(player == self || player getmpdialogname() == selfdialog || !player can_play_dialog(1) || distancesquared(self.origin, player.origin) >= voiceradiussq)
		{
			continue;
		}
		dialogalias = player get_player_dialog_alias("promotionReaction");
		if(!isdefined(dialogalias))
		{
			continue;
		}
		ally = player;
		break;
	}
	if(isdefined(ally))
	{
		ally playsoundontag(dialogalias, "J_Head", undefined, self);
		ally thread wait_dialog_buffer(mpdialog_value("playerDialogBuffer", 0));
	}
}

/*
	Name: gametype_specific_battle_chatter
	Namespace: dialog_shared
	Checksum: 0xE985792D
	Offset: 0x3A30
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function gametype_specific_battle_chatter(event, team)
{
	self endon(#"death");
	level endon(#"game_ended");
}

/*
	Name: play_laststand_vox
	Namespace: dialog_shared
	Checksum: 0xF26DCD42
	Offset: 0x3A78
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function play_laststand_vox()
{
	dialogkey = "laststandDown";
	if(isdefined(dialogkey))
	{
		self play_dialog(dialogkey, 1);
	}
}

/*
	Name: function_78c16252
	Namespace: dialog_shared
	Checksum: 0xEFABCA5A
	Offset: 0x3AC0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_78c16252()
{
	dialogkey = "exertFullyHealedBreath";
	dialogalias = self get_player_dialog_alias(dialogkey);
	if(isdefined(dialogalias))
	{
		self thread play_dialog(dialogkey, 16);
	}
}

/*
	Name: play_death_vox
	Namespace: dialog_shared
	Checksum: 0xE394256
	Offset: 0x3B28
	Size: 0x8C
	Parameters: 4
	Flags: None
*/
function play_death_vox(body, attacker, weapon, meansofdeath)
{
	dialogkey = self get_death_vox(weapon, meansofdeath);
	dialogalias = self get_player_dialog_alias(dialogkey);
	if(isdefined(dialogalias))
	{
		body playsoundontag(dialogalias, "J_Head");
	}
}

/*
	Name: get_death_vox
	Namespace: dialog_shared
	Checksum: 0xB7E5619E
	Offset: 0x3BC0
	Size: 0x152
	Parameters: 2
	Flags: Linked
*/
function get_death_vox(weapon, meansofdeath)
{
	if(self isplayerunderwater())
	{
		return "exertDeathDrowned";
	}
	if(isdefined(meansofdeath))
	{
		switch(meansofdeath)
		{
			case "mod_burned":
			{
				return "exertDeathBurned";
			}
			case "mod_drown":
			{
				return "exertDeathDrowned";
			}
			case "mod_dot":
			{
				return "exertDeathDrowned";
			}
			case "mod_dot_self":
			{
				return "exertDeathDrowned";
			}
		}
	}
	if(isdefined(weapon) && meansofdeath !== "MOD_MELEE_WEAPON_BUTT")
	{
		switch(weapon.rootweapon.name)
		{
			case "knife_loadout":
			case "hatchet":
			{
				return "exertDeathStabbed";
			}
			case "hero_firefly_swarm":
			{
				return "exertDeathBurned";
			}
			case "hero_lightninggun_arc":
			{
				return "exertDeathElectrocuted";
			}
		}
	}
	return "exertDeath";
}

/*
	Name: play_killstreak_threat
	Namespace: dialog_shared
	Checksum: 0xB38628E3
	Offset: 0x3D20
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function play_killstreak_threat(killstreaktype)
{
	if(!isdefined(killstreaktype) || !isdefined(level.killstreaks[killstreaktype]))
	{
		return;
	}
	self thread play_dialog(level.killstreaks[killstreaktype].threatdialogkey, 1);
}

/*
	Name: wait_play_dialog
	Namespace: dialog_shared
	Checksum: 0xE9E4870C
	Offset: 0x3D88
	Size: 0xAC
	Parameters: 6
	Flags: Linked
*/
function wait_play_dialog(waittime, dialogkey, dialogflags, dialogbuffer, enemy, endnotify)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(isdefined(waittime) && waittime > 0)
	{
		if(isdefined(endnotify))
		{
			self endon(endnotify);
		}
		wait(waittime);
	}
	self thread play_dialog(dialogkey, dialogflags, dialogbuffer, enemy);
}

/*
	Name: play_dialog
	Namespace: dialog_shared
	Checksum: 0xC8F5618
	Offset: 0x3E40
	Size: 0x4D4
	Parameters: 4
	Flags: Linked
*/
function play_dialog(dialogkey, dialogflags, dialogbuffer, enemy)
{
	self endon(#"death");
	level endon(#"game_ended");
	if(level flag::exists("intro_igcs_done"))
	{
		if(!level flag::get("intro_igcs_done"))
		{
			return;
		}
	}
	else if(isdefined(mission))
	{
		if(!mission flag::exists("intro_igcs_done") || !mission flag::get("intro_igcs_done"))
		{
			return;
		}
	}
	else
	{
		return;
	}
	if(!isdefined(dialogkey) || !isplayer(self) || !isalive(self) || level.gameended)
	{
		return;
	}
	global_cooldown = "global_" + self.team;
	charactertype_cooldown = "character_" + self getmpdialogname() + self.team;
	if(!level util::iscooldownready(global_cooldown) || !level util::iscooldownready(charactertype_cooldown))
	{
		return;
	}
	level util::cooldown(global_cooldown, 0.9);
	level util::cooldown(charactertype_cooldown, 2.5);
	if(self scene::is_igc_active())
	{
		return;
	}
	if(level flagsys::get(#"chyron_active"))
	{
		return;
	}
	if(isdefined(self.team) && level flagsys::get(#"dialog_mutex_" + self.team))
	{
		return;
	}
	if(!isdefined(dialogflags))
	{
		dialogflags = 0;
	}
	if(!level.allowspecialistdialog && dialogflags & 16 == 0)
	{
		return;
	}
	if(!isdefined(dialogbuffer))
	{
		dialogbuffer = mpdialog_value("playerDialogBuffer", 0);
	}
	dialogalias = self get_player_dialog_alias(dialogkey);
	if(!isdefined(dialogalias))
	{
		return;
	}
	if(self isplayerunderwater() && !dialogflags & 8)
	{
		return;
	}
	if(self.playingdialog)
	{
		if(!dialogflags & 4)
		{
			return;
		}
		self stopsounds();
		waitframe(1);
	}
	if(dialogflags & 32)
	{
		self.playinggadgetreadydialog = 1;
	}
	if(dialogflags & 64)
	{
		if(!isdefined(self.stolendialogindex))
		{
			self.stolendialogindex = 0;
		}
		dialogalias = dialogalias + "_0" + self.stolendialogindex;
		self.stolendialogindex++;
		self.stolendialogindex = self.stolendialogindex % 4;
	}
	if(dialogflags & 2)
	{
		self playsoundontag(dialogalias, "J_Head");
	}
	else if(dialogflags & 1)
	{
		if(isdefined(enemy))
		{
			self playsoundontag(dialogalias, "J_Head", self.team, enemy);
		}
		else
		{
			self playsoundontag(dialogalias, "J_Head", self.team);
		}
	}
	else
	{
		self playlocalsound(dialogalias);
	}
	self notify(#"played_dialog");
	self thread wait_dialog_buffer(dialogbuffer);
}

/*
	Name: wait_dialog_buffer
	Namespace: dialog_shared
	Checksum: 0x808303D4
	Offset: 0x4320
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function wait_dialog_buffer(dialogbuffer)
{
	self endon(#"death", #"played_dialog", #"stop_dialog");
	level endon(#"game_ended");
	self.playingdialog = 1;
	if(isdefined(dialogbuffer) && dialogbuffer > 0)
	{
		wait(dialogbuffer);
	}
	self.playingdialog = 0;
	self.playinggadgetreadydialog = 0;
}

/*
	Name: stop_dialog
	Namespace: dialog_shared
	Checksum: 0x11BCF1C5
	Offset: 0x43C0
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function stop_dialog()
{
	self notify(#"stop_dialog");
	self stopsounds();
	self.playingdialog = 0;
	self.playinggadgetreadydialog = 0;
}

/*
	Name: wait_playback_time
	Namespace: dialog_shared
	Checksum: 0x2A463AAF
	Offset: 0x4410
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function wait_playback_time(soundalias)
{
}

/*
	Name: get_player_dialog_alias
	Namespace: dialog_shared
	Checksum: 0xAFEA31B
	Offset: 0x4428
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function get_player_dialog_alias(dialogkey)
{
	if(!isplayer(self))
	{
		return undefined;
	}
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return undefined;
	}
	playerbundle = struct::get_script_bundle("mpdialog_player", bundlename);
	if(!isdefined(playerbundle))
	{
		return undefined;
	}
	return get_dialog_bundle_alias(playerbundle, dialogkey);
}

/*
	Name: count_keys
	Namespace: dialog_shared
	Checksum: 0x5A03AEDE
	Offset: 0x44D0
	Size: 0xE8
	Parameters: 3
	Flags: Linked
*/
function count_keys(keycounts, bundle, dialogkey)
{
	i = 0;
	field = dialogkey + i;
	while(isdefined(fieldvalue))
	{
		aliasarray[i] = fieldvalue;
		i++;
		field = dialogkey + i;
		fieldvalue = bundle.(field);
	}
	if(!isdefined(keycounts[bundle.name]))
	{
		keycounts[bundle.name] = [];
	}
	keycounts[bundle.name][dialogkey] = i;
}

/*
	Name: get_random_key
	Namespace: dialog_shared
	Checksum: 0x7105EB9E
	Offset: 0x45C0
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function get_random_key(dialogkey)
{
	bundlename = self getmpdialogname();
	if(!isdefined(bundlename))
	{
		return undefined;
	}
	if(!isdefined(level.var_f53efe5c[bundlename]) || !isdefined(level.var_f53efe5c[bundlename][dialogkey]))
	{
		return dialogkey;
	}
	var_4b7f8a7b = level.var_f53efe5c[bundlename][dialogkey];
	if(var_4b7f8a7b > 0)
	{
		return dialogkey + randomint(var_4b7f8a7b);
	}
	return dialogkey + 0;
}

/*
	Name: play_gadget_ready
	Namespace: dialog_shared
	Checksum: 0x8DB9A83
	Offset: 0x4698
	Size: 0x58C
	Parameters: 2
	Flags: Linked
*/
function play_gadget_ready(weapon, userflip = 0)
{
	if(!isdefined(weapon))
	{
		return;
	}
	dialogkey = undefined;
	switch(weapon.name)
	{
		case "hero_gravityspikes":
		{
			dialogkey = "gravspikesWeaponReady";
			break;
		}
		case "gadget_speed_burst":
		{
			dialogkey = "overdriveAbilityReady";
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = "visionpulseAbilityReady";
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			dialogkey = "tempestWeaponReady";
			break;
		}
		case "hero_pineapplegun":
		case "hero_pineapplegun_companion":
		{
			dialogkey = "warmachineWeaponREady";
			break;
		}
		case "gadget_armor":
		{
			dialogkey = "kineticArmorAbilityReady";
			break;
		}
		case "hero_annihilator":
		{
			dialogkey = "annihilatorWeaponReady";
			break;
		}
		case "gadget_combat_efficiency":
		{
			dialogkey = "combatfocusAbilityReady";
			break;
		}
		case "hero_chemicalgelgun":
		{
			dialogkey = "hiveWeaponReady";
			break;
		}
		case "gadget_resurrect":
		{
			dialogkey = "rejackAbilityReady";
			break;
		}
		case "hero_minigun":
		{
			dialogkey = "scytheWeaponReady";
			break;
		}
		case "gadget_clone":
		{
			dialogkey = "psychosisAbilityReady";
			break;
		}
		case "gadget_camo":
		{
			dialogkey = "activeCamoAbilityReady";
			break;
		}
		case "hero_flamethrower":
		{
			dialogkey = "purifierWeaponReady";
			break;
		}
		case "gadget_heat_wave":
		{
			dialogkey = "heatwaveAbilityReady";
			break;
		}
		default:
		{
			return;
		}
	}
	if(!(isdefined(self.isthief) && self.isthief) && (!(isdefined(self.isroulette) && self.isroulette)))
	{
		dialogflags = undefined;
		self thread play_dialog(dialogkey, dialogflags);
		return;
	}
	waittime = 0;
	dialogflags = 32;
	if(userflip)
	{
		minwaittime = 0;
		if(self.playinggadgetreadydialog)
		{
			self stop_dialog();
			minwaittime = float(function_60d95f53()) / 1000;
		}
		if(isdefined(self.isthief) && self.isthief)
		{
			delaykey = "thiefFlipDelay";
		}
		else
		{
			delaykey = "rouletteFlipDelay";
		}
		waittime = mpdialog_value(delaykey, minwaittime);
		dialogflags = dialogflags + 64;
	}
	else if(isdefined(self.isthief) && self.isthief)
	{
		generickey = "thiefWeaponReady";
		repeatkey = "thiefWeaponRepeat";
		repeatthresholdkey = "thiefRepeatThreshold";
		chancekey = "thiefReadyChance";
		delaykey = "thiefRevealDelay";
	}
	else
	{
		generickey = "rouletteAbilityReady";
		repeatkey = "rouletteAbilityRepeat";
		repeatthresholdkey = "rouletteRepeatThreshold";
		chancekey = "rouletteReadyChance";
		delaykey = "rouletteRevealDelay";
	}
	if(randomint(100) < mpdialog_value(chancekey, 0))
	{
		dialogkey = generickey;
	}
	else
	{
		waittime = mpdialog_value(delaykey, 0);
		if(self.laststolengadget === weapon && self.laststolengadgettime + int(mpdialog_value(repeatthresholdkey, 0) * 1000) > gettime())
		{
			dialogkey = repeatkey;
		}
		else
		{
			dialogflags = dialogflags + 64;
		}
	}
	self.laststolengadget = weapon;
	self.laststolengadgettime = gettime();
	if(waittime)
	{
		self notify(#"cancel_kill_dialog");
	}
	self thread wait_play_dialog(waittime, dialogkey, dialogflags);
}

/*
	Name: play_gadget_activate
	Namespace: dialog_shared
	Checksum: 0xCB0FCA6A
	Offset: 0x4C30
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function play_gadget_activate(weapon)
{
	if(!isdefined(weapon))
	{
		return;
	}
	dialogkey = undefined;
	switch(weapon.name)
	{
		case "hero_gravityspikes":
		{
			dialogkey = "gravspikesWeaponUse";
			dialogflags = 22;
			dialogbuffer = 0.05;
			break;
		}
		case "gadget_speed_burst":
		{
			dialogkey = "overdriveAbilityUse";
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = "visionpulseAbilityUse";
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			dialogkey = "tempestWeaponUse";
			break;
		}
		case "hero_pineapplegun":
		case "hero_pineapplegun_companion":
		{
			dialogkey = "warmachineWeaponUse";
			break;
		}
		case "gadget_armor":
		{
			dialogkey = "kineticArmorAbilityUse";
			break;
		}
		case "hero_annihilator":
		{
			dialogkey = "annihilatorWeaponUse";
			break;
		}
		case "gadget_combat_efficiency":
		{
			dialogkey = "combatfocusAbilityUse";
			break;
		}
		case "hero_chemicalgelgun":
		{
			dialogkey = "hiveWeaponUse";
			break;
		}
		case "gadget_resurrect":
		{
			dialogkey = "rejackAbilityUse";
			break;
		}
		case "hero_minigun":
		{
			dialogkey = "scytheWeaponUse";
			break;
		}
		case "gadget_clone":
		{
			dialogkey = "psychosisAbilityUse";
			break;
		}
		case "gadget_camo":
		{
			dialogkey = "activeCamoAbilityUse";
			break;
		}
		case "hero_flamethrower":
		{
			dialogkey = "purifierWeaponUse";
			break;
		}
		case "gadget_heat_wave":
		{
			dialogkey = "heatwaveAbilityUse";
			break;
		}
		default:
		{
			return;
		}
	}
	self thread play_dialog(dialogkey, dialogflags, dialogbuffer);
}

/*
	Name: play_gadget_success
	Namespace: dialog_shared
	Checksum: 0x8558EFE8
	Offset: 0x4ED0
	Size: 0x2D4
	Parameters: 3
	Flags: Linked
*/
function play_gadget_success(weapon, waitkey, victim)
{
	if(!isdefined(weapon))
	{
		return;
	}
	dialogkey = undefined;
	switch(weapon.name)
	{
		case "hero_gravityspikes":
		{
			dialogkey = "gravspikesWeaponSuccess";
			break;
		}
		case "gadget_speed_burst":
		{
			dialogkey = "overdriveAbilitySuccess";
			break;
		}
		case "gadget_vision_pulse":
		{
			dialogkey = "visionpulseAbilitySuccess";
			break;
		}
		case "hero_lightninggun":
		case "hero_lightninggun_arc":
		{
			dialogkey = "tempestWeaponSuccess";
			break;
		}
		case "hero_pineapplegun":
		case "hero_pineapplegun_companion":
		{
			dialogkey = "warmachineWeaponSuccess";
			break;
		}
		case "gadget_armor":
		{
			dialogkey = "kineticArmorAbilitySuccess";
			break;
		}
		case "hero_annihilator":
		{
			dialogkey = "annihilatorWeaponSuccess";
			break;
		}
		case "gadget_combat_efficiency":
		{
			dialogkey = "combatfocusAbilitySuccess";
			break;
		}
		case "hero_chemicalgelgun":
		{
			dialogkey = "hiveWeaponSuccess";
			break;
		}
		case "gadget_resurrect":
		{
			dialogkey = "rejackAbilitySuccess";
			break;
		}
		case "hero_minigun":
		{
			dialogkey = "scytheWeaponSuccess";
			break;
		}
		case "gadget_clone":
		{
			dialogkey = "psychosisAbilitySuccess";
			break;
		}
		case "gadget_camo":
		{
			dialogkey = "activeCamoAbilitySuccess";
			break;
		}
		case "hero_flamethrower":
		{
			dialogkey = "purifierWeaponSuccess";
			break;
		}
		case "gadget_heat_wave":
		{
			dialogkey = "heatwaveAbilitySuccess";
			break;
		}
		default:
		{
			return;
		}
	}
	if(isdefined(waitkey))
	{
		waittime = mpdialog_value(waitkey, 0);
	}
	dialogkey = dialogkey + "0";
	self.playedgadgetsuccess = 1;
	self thread wait_play_dialog(waittime, dialogkey, 1, undefined, victim);
}

/*
	Name: play_gadget_off
	Namespace: dialog_shared
	Checksum: 0x30A19EE8
	Offset: 0x51B0
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function play_gadget_off(weapon)
{
	if(!isdefined(weapon))
	{
		return;
	}
	dialogkey = undefined;
	switch(weapon.name)
	{
		case "gadget_speed_burst":
		{
			dialogkey = "overdriveAbilityOff";
			break;
		}
		case "hero_pineapplegun":
		case "hero_pineapplegun_companion":
		{
			dialogkey = "warmachineWeaponOff";
			break;
		}
		default:
		{
			return;
		}
	}
	self thread play_dialog(dialogkey, 1);
}

/*
	Name: play_throw_hatchet
	Namespace: dialog_shared
	Checksum: 0xD4C55A9A
	Offset: 0x5278
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function play_throw_hatchet()
{
	self thread play_dialog("exertAxeThrow", 21, mpdialog_value("playerExertBuffer", 0));
}

/*
	Name: get_enemy_players
	Namespace: dialog_shared
	Checksum: 0x9623B0C6
	Offset: 0x52C8
	Size: 0x192
	Parameters: 0
	Flags: Linked
*/
function get_enemy_players()
{
	players = [];
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			if(team == self.team)
			{
				continue;
			}
			foreach(player in level.aliveplayers[team])
			{
				players[players.size] = player;
			}
		}
	}
	else
	{
		foreach(player in level.activeplayers)
		{
			if(player != self)
			{
				players[players.size] = player;
			}
		}
	}
	return players;
}

/*
	Name: get_friendly_players
	Namespace: dialog_shared
	Checksum: 0x7D28FFF6
	Offset: 0x5468
	Size: 0xE8
	Parameters: 0
	Flags: Linked
*/
function get_friendly_players()
{
	players = [];
	if(level.teambased && isdefined(self.team) && isdefined(level.aliveplayers) && isdefined(level.aliveplayers[self.team]))
	{
		foreach(player in level.aliveplayers[self.team])
		{
			players[players.size] = player;
		}
	}
	else
	{
		players[0] = self;
	}
	return players;
}

/*
	Name: can_play_dialog
	Namespace: dialog_shared
	Checksum: 0x691E6883
	Offset: 0x5558
	Size: 0x100
	Parameters: 1
	Flags: Linked
*/
function can_play_dialog(teamonly)
{
	if(!isplayer(self) || !isalive(self) || self.playingdialog === 1 || self isplayerunderwater() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked())
	{
		return 0;
	}
	if(isdefined(teamonly) && !teamonly && self hasperk(#"specialty_quieter"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: get_closest_player_enemy
	Namespace: dialog_shared
	Checksum: 0x45CB4281
	Offset: 0x5660
	Size: 0xE6
	Parameters: 2
	Flags: Linked
*/
function get_closest_player_enemy(origin = self.origin, teamonly)
{
	players = self get_enemy_players();
	players = arraysort(players, origin);
	foreach(player in players)
	{
		if(!player can_play_dialog(teamonly))
		{
			continue;
		}
		return player;
	}
	return undefined;
}

/*
	Name: get_closest_player_ally
	Namespace: dialog_shared
	Checksum: 0xB1D42472
	Offset: 0x5750
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function get_closest_player_ally(teamonly)
{
	if(!level.teambased)
	{
		return undefined;
	}
	players = self get_friendly_players();
	players = arraysort(players, self.origin);
	foreach(player in players)
	{
		if(player == self || !player can_play_dialog(teamonly))
		{
			continue;
		}
		return player;
	}
	return undefined;
}

/*
	Name: check_boost_start_conversation
	Namespace: dialog_shared
	Checksum: 0xC42951
	Offset: 0x5850
	Size: 0x202
	Parameters: 0
	Flags: Linked
*/
function check_boost_start_conversation()
{
	if(!level.playstartconversation)
	{
		return;
	}
	if(!level.inprematchperiod || !level.teambased || game.boostplayerspicked[self.team])
	{
		return;
	}
	players = self get_friendly_players();
	array::add(players, self, 0);
	players = array::randomize(players);
	playerindex = 1;
	foreach(player in players)
	{
		if(!isdefined(player) || !isplayer(player))
		{
			continue;
		}
		playerdialog = player getmpdialogname();
		for(i = playerindex; i < players.size; i++)
		{
			playeri = players[i];
			if(!isdefined(playeri) || !isplayer(playeri))
			{
				continue;
			}
			if(playerdialog != playeri getmpdialogname())
			{
				pick_boost_players(player, playeri);
				return;
			}
		}
		playerindex++;
	}
}

/*
	Name: pick_boost_players
	Namespace: dialog_shared
	Checksum: 0x5C7118F2
	Offset: 0x5A60
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function pick_boost_players(player1, player2)
{
	player1 clientfield::set("play_boost", 1);
	player2 clientfield::set("play_boost", 2);
	game.boostplayerspicked[player1.team] = 1;
}

/*
	Name: game_end_vox
	Namespace: dialog_shared
	Checksum: 0x9F593037
	Offset: 0x5AE0
	Size: 0x190
	Parameters: 2
	Flags: None
*/
function game_end_vox(winner, tie)
{
	if(!level.allowspecialistdialog)
	{
		return;
	}
	foreach(player in level.players)
	{
		if(player issplitscreen())
		{
			continue;
		}
		if(tie)
		{
			dialogkey = "boostDraw";
		}
		else if(level.teambased && isdefined(level.teams[winner]) && player.pers[#"team"] == winner || (!level.teambased && player == winner))
		{
			dialogkey = "boostWin";
		}
		else
		{
			dialogkey = "boostLoss";
		}
		dialogalias = player get_player_dialog_alias(dialogkey);
		if(isdefined(dialogalias))
		{
			player playlocalsound(dialogalias);
		}
	}
}

/*
	Name: devgui_think
	Namespace: dialog_shared
	Checksum: 0xCD5C0132
	Offset: 0x5C78
	Size: 0x408
	Parameters: 0
	Flags: None
*/
function devgui_think()
{
	/#
		setdvar(#"devgui_mpdialog", "");
		setdvar(#"testalias_player", "");
		setdvar(#"testalias_taacom", "");
		setdvar(#"testalias_commander", "");
		while(true)
		{
			wait(1);
			player = util::gethostplayer();
			if(!isdefined(player))
			{
				continue;
			}
			spacing = getdvarfloat(#"testdialog_spacing", 0.25);
			switch(getdvarstring(#"devgui_mpdialog", ""))
			{
				case "hash_7912e80189f9c6":
				{
					player thread test_player_dialog(0);
					player thread test_taacom_dialog(spacing);
					player thread test_commander_dialog(2 * spacing);
					break;
				}
				case "hash_69c6be086f76a9d4":
				{
					player thread test_player_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_3af5f0a904b3f8fa":
				{
					player thread test_other_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_32945da5f7ac491":
				{
					player thread test_taacom_dialog(0);
					player thread test_commander_dialog(spacing);
					break;
				}
				case "hash_597b27a5c8857d19":
				{
					player thread test_player_dialog(0);
					player thread test_taacom_dialog(spacing);
					break;
				}
				case "hash_74f798193af006b3":
				{
					player thread test_other_dialog(0);
					player thread test_taacom_dialog(spacing);
					break;
				}
				case "hash_5bd6a2c5d0ff3cb2":
				{
					player thread test_other_dialog(0);
					player thread test_player_dialog(spacing);
					break;
				}
				case "hash_4a5a66c89be92eb":
				{
					player thread play_conv_self_other();
					break;
				}
				case "hash_18683ef7652f40ed":
				{
					player thread play_conv_other_self();
					break;
				}
				case "hash_2b559b1a5e81715f":
				{
					player thread play_conv_other_other();
					break;
				}
			}
			setdvar(#"devgui_mpdialog", "");
		}
	#/
}

/*
	Name: test_other_dialog
	Namespace: dialog_shared
	Checksum: 0xBFE138FD
	Offset: 0x6088
	Size: 0xE2
	Parameters: 1
	Flags: None
*/
function test_other_dialog(delay)
{
	/#
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player thread test_player_dialog(delay);
				return;
			}
		}
	#/
}

/*
	Name: test_player_dialog
	Namespace: dialog_shared
	Checksum: 0x2C3D11ED
	Offset: 0x6178
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function test_player_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playsoundontag(getdvarstring(#"testalias_player", ""), "");
	#/
}

/*
	Name: test_taacom_dialog
	Namespace: dialog_shared
	Checksum: 0xC85B6CA9
	Offset: 0x61E8
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function test_taacom_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playlocalsound(getdvarstring(#"testalias_taacom", ""));
	#/
}

/*
	Name: test_commander_dialog
	Namespace: dialog_shared
	Checksum: 0x28E0C1CE
	Offset: 0x6250
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function test_commander_dialog(delay)
{
	/#
		if(!isdefined(delay))
		{
			delay = 0;
		}
		wait(delay);
		self playlocalsound(getdvarstring(#"testalias_commander", ""));
	#/
}

/*
	Name: play_test_dialog
	Namespace: dialog_shared
	Checksum: 0x58D55E0D
	Offset: 0x62B8
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function play_test_dialog(dialogkey)
{
	/#
		dialogalias = self get_player_dialog_alias(dialogkey);
		self playsoundontag(dialogalias, "");
	#/
}

/*
	Name: response_key
	Namespace: dialog_shared
	Checksum: 0x217B3C1
	Offset: 0x6310
	Size: 0x10A
	Parameters: 0
	Flags: None
*/
function response_key()
{
	/#
		switch(self getmpdialogname())
		{
			case "assassin":
			{
				return "";
			}
			case "grenadier":
			{
				return "";
			}
			case "outrider":
			{
				return "";
			}
			case "prophet":
			{
				return "";
			}
			case "pyro":
			{
				return "";
			}
			case "reaper":
			{
				return "";
			}
			case "ruin":
			{
				return "";
			}
			case "seraph":
			{
				return "";
			}
			case "trapper":
			{
				return "";
			}
		}
		return "";
	#/
}

/*
	Name: play_conv_self_other
	Namespace: dialog_shared
	Checksum: 0x2F8B39F5
	Offset: 0x6428
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function play_conv_self_other()
{
	/#
		num = randomintrange(0, 4);
		self play_test_dialog("" + num);
		wait(4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog("" + self response_key() + num);
				break;
			}
		}
	#/
}

/*
	Name: play_conv_other_self
	Namespace: dialog_shared
	Checksum: 0x8D053330
	Offset: 0x6570
	Size: 0x13C
	Parameters: 0
	Flags: None
*/
function play_conv_other_self()
{
	/#
		num = randomintrange(0, 4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog("" + num);
				break;
			}
		}
		wait(4);
		self play_test_dialog("" + player response_key() + num);
	#/
}

/*
	Name: play_conv_other_other
	Namespace: dialog_shared
	Checksum: 0xF2A03C8
	Offset: 0x66B8
	Size: 0x1DC
	Parameters: 0
	Flags: None
*/
function play_conv_other_other()
{
	/#
		num = randomintrange(0, 4);
		players = arraysort(level.players, self.origin);
		foreach(player in players)
		{
			if(player != self && isalive(player))
			{
				player play_test_dialog("" + num);
				firstplayer = player;
				break;
			}
		}
		wait(4);
		foreach(player in players)
		{
			if(player != self && player !== firstplayer && isalive(player))
			{
				player play_test_dialog("" + firstplayer response_key() + num);
				break;
			}
		}
	#/
}

