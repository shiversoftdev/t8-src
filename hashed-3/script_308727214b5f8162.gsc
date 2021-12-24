// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d1a97b78f64bfd;
#using script_3728b3b9606c4299;
#using script_383a3b1bb18ba876;
#using script_47fb62300ac0bd60;
#using script_57c900a7e39234be;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_8988fdbc78d6c53;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\popups_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace qrdrone;

/*
	Name: init_shared
	Namespace: qrdrone
	Checksum: 0xE8D852B5
	Offset: 0x408
	Size: 0x6FE
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_c5b27019))
	{
		level.var_c5b27019 = {};
		remote_weapons::init_shared();
		airsupport::init_shared();
		level.qrdrone_vehicle = "qrdrone_mp";
		level.ai_tank_stun_fx = "killstreaks/fx_agr_emp_stun";
		level.qrdrone_minigun_flash = "weapon/fx_muz_md_rifle_3p";
		level.qrdrone_fx[#"explode"] = "_t7/killstreaks/fx_drgnfire_explosion";
		level._effect[#"quadrotor_nudge"] = #"hash_10f127a62acd37ee";
		level._effect[#"quadrotor_damage"] = #"hash_2cf01c21155d889a";
		level.qrdrone_dialog[#"launch"][0] = #"ac130_plt_yeahcleared";
		level.qrdrone_dialog[#"launch"][1] = #"ac130_plt_rollinin";
		level.qrdrone_dialog[#"launch"][2] = #"ac130_plt_scanrange";
		level.qrdrone_dialog[#"out_of_range"][0] = #"ac130_plt_cleanup";
		level.qrdrone_dialog[#"out_of_range"][1] = #"ac130_plt_targetreset";
		level.qrdrone_dialog[#"track"][0] = #"ac130_fco_moreenemy";
		level.qrdrone_dialog[#"track"][1] = #"ac130_fco_getthatguy";
		level.qrdrone_dialog[#"track"][2] = #"ac130_fco_guymovin";
		level.qrdrone_dialog[#"track"][3] = #"ac130_fco_getperson";
		level.qrdrone_dialog[#"track"][4] = #"ac130_fco_guyrunnin";
		level.qrdrone_dialog[#"track"][5] = #"ac130_fco_gotarunner";
		level.qrdrone_dialog[#"track"][6] = #"ac130_fco_backonthose";
		level.qrdrone_dialog[#"track"][7] = #"ac130_fco_gonnagethim";
		level.qrdrone_dialog[#"track"][8] = #"ac130_fco_personnelthere";
		level.qrdrone_dialog[#"track"][9] = #"ac130_fco_rightthere";
		level.qrdrone_dialog[#"track"][10] = #"ac130_fco_tracking";
		level.qrdrone_dialog[#"tag"][0] = #"ac130_fco_nice";
		level.qrdrone_dialog[#"tag"][1] = #"ac130_fco_yougothim";
		level.qrdrone_dialog[#"tag"][2] = #"ac130_fco_yougothim2";
		level.qrdrone_dialog[#"tag"][3] = #"ac130_fco_okyougothim";
		level.qrdrone_dialog[#"assist"][0] = #"ac130_fco_goodkill";
		level.qrdrone_dialog[#"assist"][1] = #"ac130_fco_thatsahit";
		level.qrdrone_dialog[#"assist"][2] = #"ac130_fco_directhit";
		level.qrdrone_dialog[#"assist"][3] = #"ac130_fco_rightontarget";
		level.qrdrone_lastdialogtime = 0;
		level.qrdrone_nodeployzones = getentarray("no_vehicles", "targetname");
		level._effect[#"qrdrone_prop"] = #"hash_5af1c94d2e2bf9f";
		/#
			util::set_dvar_if_unset("", 60);
		#/
		clientfield::register("vehicle", "qrdrone_state", 1, 3, "int");
		clientfield::register("vehicle", "qrdrone_timeout", 1, 1, "int");
		clientfield::register("vehicle", "qrdrone_countdown", 1, 1, "int");
		clientfield::register("vehicle", "qrdrone_out_of_range", 1, 1, "int");
		level.qrdroneonblowup = &qrdrone_blowup;
		level.qrdroneondamage = &qrdrone_damagewatcher;
	}
}

/*
	Name: tryuseqrdrone
	Namespace: qrdrone
	Checksum: 0xE6FEA442
	Offset: 0xB10
	Size: 0xB6
	Parameters: 1
	Flags: None
*/
function tryuseqrdrone(lifeid)
{
	if(self util::isusingremote() || isdefined(level.nukeincoming))
	{
		return 0;
	}
	if(!self isonground())
	{
		self iprintlnbold(#"hash_7602a0cff466eccd");
		return 0;
	}
	streakname = "TODO";
	result = self givecarryqrdrone(lifeid, streakname);
	self.iscarrying = 0;
	return result;
}

/*
	Name: givecarryqrdrone
	Namespace: qrdrone
	Checksum: 0x6AFB0643
	Offset: 0xBD0
	Size: 0x104
	Parameters: 2
	Flags: None
*/
function givecarryqrdrone(lifeid, streakname)
{
	carryqrdrone = createcarryqrdrone(streakname, self);
	self setcarryingqrdrone(carryqrdrone);
	if(isalive(self) && isdefined(carryqrdrone))
	{
		origin = carryqrdrone.origin;
		angles = self.angles;
		carryqrdrone.soundent delete();
		carryqrdrone delete();
		result = self startqrdrone(lifeid, streakname, origin, angles);
	}
	else
	{
		result = 0;
	}
	return result;
}

/*
	Name: createcarryqrdrone
	Namespace: qrdrone
	Checksum: 0xE7D3C020
	Offset: 0xCE0
	Size: 0x288
	Parameters: 2
	Flags: None
*/
function createcarryqrdrone(streakname, owner)
{
	pos = (owner.origin + (anglestoforward(owner.angles) * 4)) + (anglestoup(owner.angles) * 50);
	carryqrdrone.turrettype = "sentry";
	carryqrdrone.origin = pos;
	carryqrdrone.angles = owner.angles;
	carryqrdrone.canbeplaced = 1;
	carryqrdrone makeunusable();
	carryqrdrone.owner = owner;
	carryqrdrone setowner(carryqrdrone.owner);
	carryqrdrone.scale = 3;
	carryqrdrone.inheliproximity = 0;
	carryqrdrone thread carryqrdrone_handleexistence();
	carryqrdrone.rangetrigger = getent("qrdrone_range", "targetname");
	if(!isdefined(carryqrdrone.rangetrigger))
	{
		carryqrdrone.maxheight = int(airsupport::getminimumflyheight());
		carryqrdrone.maxdistance = 3600;
	}
	carryqrdrone.minheight = level.mapcenter[2] - 800;
	carryqrdrone.soundent = spawn("script_origin", carryqrdrone.origin);
	carryqrdrone.soundent.angles = carryqrdrone.angles;
	carryqrdrone.soundent.origin = carryqrdrone.origin;
	carryqrdrone.soundent linkto(carryqrdrone);
	carryqrdrone.soundent playloopsound(#"recondrone_idle_high");
	return carryqrdrone;
}

/*
	Name: watchforattack
	Namespace: qrdrone
	Checksum: 0xAA58BC5
	Offset: 0xF70
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function watchforattack()
{
	self endon(#"death", #"disconnect", #"place_carryqrdrone", #"cancel_carryqrdrone");
	for(;;)
	{
		waitframe(1);
		if(self attackbuttonpressed())
		{
			self notify(#"place_carryqrdrone");
		}
	}
}

/*
	Name: setcarryingqrdrone
	Namespace: qrdrone
	Checksum: 0xAAF27074
	Offset: 0xFF8
	Size: 0x128
	Parameters: 1
	Flags: None
*/
function setcarryingqrdrone(carryqrdrone)
{
	self endon(#"death", #"disconnect");
	carryqrdrone thread carryqrdrone_setcarried(self);
	if(!carryqrdrone.canbeplaced)
	{
		if(self.team != #"spectator")
		{
			self iprintlnbold(#"hash_7602a0cff466eccd");
		}
		if(isdefined(carryqrdrone.soundent))
		{
			carryqrdrone.soundent delete();
		}
		carryqrdrone delete();
		return;
	}
	self.iscarrying = 0;
	carryqrdrone.carriedby = undefined;
	carryqrdrone playsound(#"sentry_gun_plant");
	carryqrdrone notify(#"placed");
}

/*
	Name: carryqrdrone_setcarried
	Namespace: qrdrone
	Checksum: 0x113A6256
	Offset: 0x1128
	Size: 0x86
	Parameters: 1
	Flags: None
*/
function carryqrdrone_setcarried(carrier)
{
	self setcandamage(0);
	self setcontents(0);
	self.carriedby = carrier;
	carrier.iscarrying = 1;
	carrier thread updatecarryqrdroneplacement(self);
	self notify(#"carried");
}

/*
	Name: isinremotenodeploy
	Namespace: qrdrone
	Checksum: 0xE5D4321A
	Offset: 0x11B8
	Size: 0xAA
	Parameters: 0
	Flags: None
*/
function isinremotenodeploy()
{
	if(isdefined(level.qrdrone_nodeployzones) && level.qrdrone_nodeployzones.size)
	{
		foreach(zone in level.qrdrone_nodeployzones)
		{
			if(self istouching(zone))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: updatecarryqrdroneplacement
	Namespace: qrdrone
	Checksum: 0xBC344431
	Offset: 0x1270
	Size: 0x274
	Parameters: 1
	Flags: None
*/
function updatecarryqrdroneplacement(carryqrdrone)
{
	self endon(#"death", #"disconnect");
	level endon(#"game_ended");
	carryqrdrone endon(#"placed", #"death");
	carryqrdrone.canbeplaced = 1;
	lastcanplacecarryqrdrone = -1;
	for(;;)
	{
		heightoffset = 18;
		switch(self getstance())
		{
			case "stand":
			{
				heightoffset = 40;
				break;
			}
			case "crouch":
			{
				heightoffset = 25;
				break;
			}
			case "prone":
			{
				heightoffset = 10;
				break;
			}
		}
		placement = self canplayerplacevehicle(22, 22, 50, heightoffset, 0, 0);
		carryqrdrone.origin = placement[#"origin"] + (anglestoup(self.angles) * 27);
		carryqrdrone.angles = placement[#"angles"];
		carryqrdrone.canbeplaced = self isonground() && placement[#"result"] && carryqrdrone qrdrone_in_range() && !carryqrdrone isinremotenodeploy();
		if(carryqrdrone.canbeplaced != lastcanplacecarryqrdrone)
		{
			if(carryqrdrone.canbeplaced)
			{
				if(self attackbuttonpressed())
				{
					self notify(#"place_carryqrdrone");
				}
			}
		}
		lastcanplacecarryqrdrone = carryqrdrone.canbeplaced;
		waitframe(1);
	}
}

/*
	Name: carryqrdrone_handleexistence
	Namespace: qrdrone
	Checksum: 0xD4B146FD
	Offset: 0x14F0
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function carryqrdrone_handleexistence()
{
	level endon(#"game_ended");
	self endon(#"death");
	self.owner endon(#"place_carryqrdrone", #"cancel_carryqrdrone");
	self.owner waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: removeremoteweapon
	Namespace: qrdrone
	Checksum: 0xBB8B8032
	Offset: 0x15B8
	Size: 0x38
	Parameters: 0
	Flags: None
*/
function removeremoteweapon()
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	wait(0.7);
}

/*
	Name: startqrdrone
	Namespace: qrdrone
	Checksum: 0x42CD60A
	Offset: 0x15F8
	Size: 0x32E
	Parameters: 4
	Flags: None
*/
function startqrdrone(lifeid, streakname, origin, angles)
{
	self lockplayerforqrdronelaunch();
	self util::setusingremote(streakname);
	self val::set(#"startqrdrone", "freezecontrols");
	result = self killstreaks::init_ride_killstreak("qrdrone");
	if(result != "success" || level.gameended)
	{
		if(result != "disconnect")
		{
			self val::reset(#"startqrdrone", "freezecontrols");
			self killstreakrules::iskillstreakallowed("qrdrone", self.team);
			self notify(#"qrdrone_unlock");
			self killstreaks::clear_using_remote();
		}
		return 0;
	}
	team = self.team;
	killstreak_id = self killstreakrules::killstreakstart("qrdrone", team, 0, 1);
	if(killstreak_id == -1)
	{
		self notify(#"qrdrone_unlock");
		self val::reset(#"startqrdrone", "freezecontrols");
		self killstreaks::clear_using_remote();
		return 0;
	}
	self notify(#"qrdrone_unlock");
	qrdrone = createqrdrone(lifeid, self, streakname, origin, angles, killstreak_id);
	self val::reset(#"startqrdrone", "freezecontrols");
	if(isdefined(qrdrone))
	{
		self thread qrdrone_ride(lifeid, qrdrone, streakname);
		qrdrone waittill(#"end_remote");
		killstreakrules::killstreakstop("qrdrone", team, killstreak_id);
		return 1;
	}
	self iprintlnbold(#"mp_too_many_vehicles");
	self killstreaks::clear_using_remote();
	killstreakrules::killstreakstop("qrdrone", team, killstreak_id);
	return 0;
}

/*
	Name: lockplayerforqrdronelaunch
	Namespace: qrdrone
	Checksum: 0x7B29ED0C
	Offset: 0x1930
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function lockplayerforqrdronelaunch()
{
	lockspot = spawn("script_origin", self.origin);
	lockspot hide();
	self playerlinkto(lockspot);
	self thread clearplayerlockfromqrdronelaunch(lockspot);
}

/*
	Name: clearplayerlockfromqrdronelaunch
	Namespace: qrdrone
	Checksum: 0xD8495C5
	Offset: 0x19B0
	Size: 0x6C
	Parameters: 1
	Flags: None
*/
function clearplayerlockfromqrdronelaunch(lockspot)
{
	level endon(#"game_ended");
	self waittill(#"disconnect", #"death", #"qrdrone_unlock");
	lockspot delete();
}

/*
	Name: createqrdrone
	Namespace: qrdrone
	Checksum: 0xBAD0A633
	Offset: 0x1A28
	Size: 0x3D8
	Parameters: 6
	Flags: None
*/
function createqrdrone(lifeid, owner, streakname, origin, angles, killstreak_id)
{
	qrdrone = spawnvehicle(level.qrdrone_vehicle, origin, angles);
	if(!isdefined(qrdrone))
	{
		return undefined;
	}
	qrdrone.lifeid = lifeid;
	qrdrone.team = owner.team;
	qrdrone setowner(owner);
	qrdrone clientfield::set("enemyvehicle", 1);
	qrdrone.health = 999999;
	qrdrone.maxhealth = 250;
	qrdrone.damagetaken = 0;
	qrdrone.destroyed = 0;
	qrdrone setcandamage(1);
	qrdrone enableaimassist();
	qrdrone.smoking = 0;
	qrdrone.inheliproximity = 0;
	qrdrone.helitype = "qrdrone";
	qrdrone.markedplayers = [];
	qrdrone.isstunned = 0;
	qrdrone setdrawinfrared(1);
	qrdrone.killcament = qrdrone.owner;
	owner weaponobjects::addweaponobjecttowatcher("qrdrone", qrdrone);
	qrdrone thread qrdrone_explode_on_notify(killstreak_id);
	qrdrone thread qrdrone_explode_on_game_end();
	qrdrone thread qrdrone_leave_on_timeout(streakname);
	qrdrone thread qrdrone_watch_distance();
	qrdrone thread qrdrone_watch_for_exit();
	qrdrone thread deleteonkillbrush(owner);
	target_set(qrdrone, (0, 0, 0));
	qrdrone.numflares = 0;
	qrdrone.flareoffset = vectorscale((0, 0, -1), 100);
	qrdrone thread heatseekingmissile::missiletarget_lockonmonitor(self, "end_remote");
	qrdrone thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing");
	qrdrone.emp_fx = spawn("script_model", self.origin);
	qrdrone.emp_fx setmodel(#"tag_origin");
	qrdrone.emp_fx linkto(self, "tag_origin", (vectorscale((0, 0, -1), 20)) + (anglestoforward(self.angles) * 6));
	qrdrone influencers::create_entity_enemy_influencer("small_vehicle", qrdrone.team);
	qrdrone influencers::create_entity_enemy_influencer("qrdrone_cylinder", qrdrone.team);
	return qrdrone;
}

/*
	Name: qrdrone_ride
	Namespace: qrdrone
	Checksum: 0xCAFE3C16
	Offset: 0x1E08
	Size: 0x174
	Parameters: 3
	Flags: None
*/
function qrdrone_ride(lifeid, qrdrone, streakname)
{
	qrdrone.playerlinked = 1;
	self.restoreangles = self.angles;
	qrdrone usevehicle(self, 0);
	self util::clientnotify("qrfutz");
	self killstreaks::play_killstreak_start_dialog("qrdrone", self.pers[#"team"]);
	self stats::function_e24eec31(getweapon(#"killstreak_qrdrone"), #"used", 1);
	self.qrdrone_ridelifeid = lifeid;
	self.qrdrone = qrdrone;
	self thread qrdrone_delaylaunchdialog(qrdrone);
	self thread qrdrone_fireguns(qrdrone);
	qrdrone thread play_lockon_sounds(self);
	if(isdefined(level.qrdrone_vision))
	{
		self setvisionsetwaiter();
	}
}

/*
	Name: qrdrone_delaylaunchdialog
	Namespace: qrdrone
	Checksum: 0xFD004946
	Offset: 0x1F88
	Size: 0x8C
	Parameters: 1
	Flags: None
*/
function qrdrone_delaylaunchdialog(qrdrone)
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	qrdrone endon(#"death", #"end_remote", #"end_launch_dialog");
	wait(3);
	self qrdrone_dialog("launch");
}

/*
	Name: qrdrone_unlink
	Namespace: qrdrone
	Checksum: 0xD1AD21F5
	Offset: 0x2020
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function qrdrone_unlink(qrdrone)
{
	if(isdefined(qrdrone))
	{
		qrdrone.playerlinked = 0;
		self destroyhud();
		if(isdefined(self.viewlockedentity))
		{
			self unlink();
			if(isdefined(level.gameended) && level.gameended)
			{
				self val::set(#"game_end", "freezecontrols");
			}
		}
	}
}

/*
	Name: qrdrone_endride
	Namespace: qrdrone
	Checksum: 0x1CB08EF0
	Offset: 0x20C8
	Size: 0xAE
	Parameters: 1
	Flags: None
*/
function qrdrone_endride(qrdrone)
{
	if(isdefined(qrdrone))
	{
		qrdrone notify(#"end_remote");
		self killstreaks::clear_using_remote();
		self setplayerangles(self.restoreangles);
		if(isalive(self))
		{
			self killstreaks::switch_to_last_non_killstreak_weapon();
		}
		self thread qrdrone_freezebuffer();
	}
	self.qrdrone = undefined;
}

/*
	Name: play_lockon_sounds
	Namespace: qrdrone
	Checksum: 0x19800609
	Offset: 0x2180
	Size: 0x1E0
	Parameters: 1
	Flags: None
*/
function play_lockon_sounds(player)
{
	player endon(#"disconnect");
	self endon(#"death", #"blowup", #"crashing");
	level endon(#"game_ended");
	self endon(#"end_remote");
	self.locksounds = spawn("script_model", self.origin);
	wait(0.1);
	self.locksounds linkto(self, "tag_player");
	while(true)
	{
		self waittill(#"hash_594587fd1093c3b3");
		while(true)
		{
			if(enemy_locking())
			{
				self.locksounds playsoundtoplayer(#"uin_alert_lockon", player);
				wait(0.125);
			}
			if(enemy_locked())
			{
				self.locksounds playsoundtoplayer(#"uin_alert_lockon", player);
				wait(0.125);
			}
			if(!enemy_locking() && !enemy_locked())
			{
				self.locksounds stopsounds();
				break;
			}
		}
	}
}

/*
	Name: enemy_locking
	Namespace: qrdrone
	Checksum: 0x89BF73FC
	Offset: 0x2368
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function enemy_locking()
{
	if(isdefined(self.locking_on) && self.locking_on)
	{
		return 1;
	}
	return 0;
}

/*
	Name: enemy_locked
	Namespace: qrdrone
	Checksum: 0x53B6EF0B
	Offset: 0x2398
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function enemy_locked()
{
	if(isdefined(self.locked_on) && self.locked_on)
	{
		return 1;
	}
	return 0;
}

/*
	Name: qrdrone_freezebuffer
	Namespace: qrdrone
	Checksum: 0xD85C6E67
	Offset: 0x23C8
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function qrdrone_freezebuffer()
{
	self endon(#"disconnect", #"death");
	level endon(#"game_ended");
	self val::set(#"qrdrone_freezebuffer", "freezecontrols");
	wait(0.5);
	self val::reset(#"qrdrone_freezebuffer", "freezecontrols");
}

/*
	Name: qrdrone_playerexit
	Namespace: qrdrone
	Checksum: 0xFA20F15A
	Offset: 0x2468
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function qrdrone_playerexit(qrdrone)
{
	level endon(#"game_ended");
	self endon(#"disconnect");
	qrdrone endon(#"death", #"end_remote");
	wait(2);
	while(true)
	{
		timeused = 0;
		while(self usebuttonpressed())
		{
			timeused = timeused + 0.05;
			if(timeused > 0.75)
			{
				qrdrone thread qrdrone_leave();
				return;
			}
			waitframe(1);
		}
		waitframe(1);
	}
}

/*
	Name: touchedkillbrush
	Namespace: qrdrone
	Checksum: 0x8D7F7CCB
	Offset: 0x2550
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function touchedkillbrush()
{
	if(isdefined(self))
	{
		self clientfield::set("qrdrone_state", 3);
		watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
		watcher thread weaponobjects::waitanddetonate(self, 0);
	}
}

/*
	Name: deleteonkillbrush
	Namespace: qrdrone
	Checksum: 0x635EF2D4
	Offset: 0x25D0
	Size: 0x38C
	Parameters: 1
	Flags: None
*/
function deleteonkillbrush(player)
{
	player endon(#"disconnect");
	self endon(#"death");
	killbrushes = [];
	hurt = getentarray("trigger_hurt_new", "classname");
	foreach(trig in hurt)
	{
		if(trig.origin[2] <= player.origin[2] && (!isdefined(trig.script_parameters) || trig.script_parameters != "qrdrone_safe"))
		{
			killbrushes[killbrushes.size] = trig;
		}
	}
	crate_triggers = getentarray("crate_kill_trigger", "targetname");
	while(true)
	{
		for(i = 0; i < killbrushes.size; i++)
		{
			if(self istouching(killbrushes[i]))
			{
				self touchedkillbrush();
				return;
			}
		}
		foreach(trigger in crate_triggers)
		{
			if(trigger.active && self istouching(trigger))
			{
				self touchedkillbrush();
				return;
			}
		}
		if(isdefined(level.levelkillbrushes))
		{
			foreach(trigger in level.levelkillbrushes)
			{
				if(self istouching(trigger))
				{
					self touchedkillbrush();
					return;
				}
			}
		}
		if(level.script == "mp_castaway")
		{
			origin = self.origin - vectorscale((0, 0, 1), 12);
			water = getwaterheight(origin);
			if(water - origin[2] > 0)
			{
				self touchedkillbrush();
				return;
			}
		}
		wait(0.1);
	}
}

/*
	Name: qrdrone_force_destroy
	Namespace: qrdrone
	Checksum: 0xB294B52D
	Offset: 0x2968
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function qrdrone_force_destroy()
{
	self clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher thread weaponobjects::waitanddetonate(self, 0);
}

/*
	Name: qrdrone_get_damage_effect
	Namespace: qrdrone
	Checksum: 0xE0866BAA
	Offset: 0x29E0
	Size: 0x38
	Parameters: 1
	Flags: None
*/
function qrdrone_get_damage_effect(health_pct)
{
	if(health_pct > 0.5)
	{
		return level._effect[#"quadrotor_damage"];
	}
	return undefined;
}

/*
	Name: qrdrone_play_single_fx_on_tag
	Namespace: qrdrone
	Checksum: 0x80A7D4B
	Offset: 0x2A20
	Size: 0x74
	Parameters: 2
	Flags: None
*/
function qrdrone_play_single_fx_on_tag(effect, tag)
{
	if(isdefined(self.damage_fx_ent))
	{
		if(self.damage_fx_ent.effect == effect)
		{
			return;
		}
		self.damage_fx_ent delete();
	}
	playfxontag(effect, self, "tag_origin");
}

/*
	Name: qrdrone_update_damage_fx
	Namespace: qrdrone
	Checksum: 0xBFB97202
	Offset: 0x2AA0
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function qrdrone_update_damage_fx(health_percent)
{
	effect = qrdrone_get_damage_effect(health_percent);
	if(isdefined(effect))
	{
		qrdrone_play_single_fx_on_tag(effect, "tag_origin");
	}
	else if(isdefined(self.damage_fx_ent))
	{
		self.damage_fx_ent delete();
	}
}

/*
	Name: qrdrone_damagewatcher
	Namespace: qrdrone
	Checksum: 0xAF64F994
	Offset: 0x2B28
	Size: 0x390
	Parameters: 0
	Flags: None
*/
function qrdrone_damagewatcher()
{
	self endon(#"death");
	self.maxhealth = 999999;
	self.health = self.maxhealth;
	self.maxhealth = 225;
	low_health = 0;
	damage_taken = 0;
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		damage = waitresult.amount;
		mod = waitresult.mod;
		dir = waitresult.direction;
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			continue;
		}
		self.owner playrumbleonentity("damage_heavy");
		/#
			self.damage_debug = ((damage + "") + weapon.name) + "";
		#/
		if(mod == "MOD_RIFLE_BULLET" || mod == "MOD_PISTOL_BULLET")
		{
			if(isplayer(attacker))
			{
				if(attacker hasperk(#"specialty_armorpiercing"))
				{
					damage = damage + (int(damage * level.cac_armorpiercing_data));
				}
			}
			if(weapon.weapclass == "spread")
			{
				damage = damage * 2;
			}
		}
		if(weapon.isemp && mod == "MOD_GRENADE_SPLASH")
		{
			damage_taken = damage_taken + 225;
			damage = 0;
		}
		if(!self.isstunned)
		{
			if(weapon.isstun && (mod == "MOD_GRENADE_SPLASH" || mod == "MOD_GAS"))
			{
				self.isstunned = 1;
				self qrdrone_stun(2);
			}
		}
		self.attacker = attacker;
		self.owner sendkillstreakdamageevent(int(damage));
		damage_taken = damage_taken + damage;
		if(damage_taken >= 225)
		{
			self.owner sendkillstreakdamageevent(200);
			self qrdrone_death(attacker, weapon, dir, mod);
			return;
		}
		qrdrone_update_damage_fx(float(damage_taken) / 225);
	}
}

/*
	Name: qrdrone_stun
	Namespace: qrdrone
	Checksum: 0xCAA77C75
	Offset: 0x2EC0
	Size: 0xA6
	Parameters: 1
	Flags: None
*/
function qrdrone_stun(duration)
{
	self endon(#"death");
	self notify(#"stunned");
	self.owner val::set(#"qrdrone_stun", "freezecontrols");
	wait(duration);
	self.owner val::reset(#"qrdrone_stun", "freezecontrols");
	self.isstunned = 0;
}

/*
	Name: qrdrone_death
	Namespace: qrdrone
	Checksum: 0xEB4AC4B5
	Offset: 0x2F70
	Size: 0x264
	Parameters: 4
	Flags: None
*/
function qrdrone_death(attacker, weapon, dir, damagetype)
{
	if(isdefined(self.damage_fx_ent))
	{
		self.damage_fx_ent delete();
	}
	if(isdefined(attacker) && isplayer(attacker) && attacker != self.owner)
	{
		level thread popups::displayteammessagetoall(#"hash_1b5291e0c76c5c6d", attacker);
		if(self.owner util::isenemyplayer(attacker))
		{
			attacker challenges::destroyedqrdrone(damagetype, weapon);
			attacker stats::function_e24eec31(weapon, #"destroyed_qrdrone", 1);
			attacker challenges::addflyswatterstat(weapon, self);
			attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
		}
	}
	self thread qrdrone_crash_movement(attacker, dir);
	if(weapon.isemp)
	{
		playfxontag(level.ai_tank_stun_fx, self.emp_fx, "tag_origin");
	}
	self waittill(#"crash_done");
	if(isdefined(self.emp_fx))
	{
		self.emp_fx delete();
	}
	self clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher thread weaponobjects::waitanddetonate(self, 0, attacker, weapon);
}

/*
	Name: death_fx
	Namespace: qrdrone
	Checksum: 0xABBF325E
	Offset: 0x31E0
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function death_fx()
{
	playfxontag(self.deathfx, self, self.deathfxtag);
	self playsound(#"veh_qrdrone_sparks");
}

/*
	Name: qrdrone_crash_movement
	Namespace: qrdrone
	Checksum: 0x115438A
	Offset: 0x3230
	Size: 0x37E
	Parameters: 2
	Flags: None
*/
function qrdrone_crash_movement(attacker, hitdir)
{
	self endon(#"crash_done", #"death");
	self notify(#"crashing");
	self takeplayercontrol();
	self setmaxpitchroll(90, 180);
	self setphysacceleration(vectorscale((0, 0, -1), 800));
	side_dir = vectorcross(hitdir, (0, 0, 1));
	side_dir_mag = randomfloatrange(-100, 100);
	side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 80);
	side_dir = side_dir * side_dir_mag;
	velocity = self getvelocity();
	self setvehvelocity((velocity + vectorscale((0, 0, 1), 100)) + vectornormalize(side_dir));
	ang_vel = self getangularvelocity();
	ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 0.3);
	yaw_vel = randomfloatrange(0, 210) * math::sign(ang_vel[1]);
	yaw_vel = yaw_vel + (math::sign(yaw_vel) * 180);
	ang_vel = ang_vel + (randomfloatrange(-100, 100), yaw_vel, randomfloatrange(-200, 200));
	self setangularvelocity(ang_vel);
	self.crash_accel = randomfloatrange(75, 110);
	self thread qrdrone_crash_accel();
	self thread qrdrone_collision();
	self playsound(#"veh_qrdrone_dmg_hit");
	self thread qrdrone_dmg_snd();
	wait(0.1);
	if(randomint(100) < 40)
	{
		self thread qrdrone_fire_for_time(randomfloatrange(0.7, 2));
	}
	wait(2);
	self notify(#"crash_done");
}

/*
	Name: qrdrone_dmg_snd
	Namespace: qrdrone
	Checksum: 0x40B820DE
	Offset: 0x35B8
	Size: 0xBC
	Parameters: 0
	Flags: None
*/
function qrdrone_dmg_snd()
{
	dmg_ent = spawn("script_origin", self.origin);
	dmg_ent linkto(self);
	dmg_ent playloopsound(#"veh_qrdrone_dmg_loop");
	self waittill(#"crash_done", #"death");
	dmg_ent stoploopsound(0.2);
	wait(2);
	dmg_ent delete();
}

/*
	Name: qrdrone_fire_for_time
	Namespace: qrdrone
	Checksum: 0xDC1617FF
	Offset: 0x3680
	Size: 0xD2
	Parameters: 1
	Flags: None
*/
function qrdrone_fire_for_time(totalfiretime)
{
	self endon(#"crash_done", #"change_state", #"death");
	weapon = self seatgetweapon(0);
	firetime = weapon.firetime;
	time = 0;
	firecount = 1;
	while(time < totalfiretime)
	{
		self fireweapon();
		firecount++;
		wait(firetime);
		time = time + firetime;
	}
}

/*
	Name: qrdrone_crash_accel
	Namespace: qrdrone
	Checksum: 0xBFAE2AEC
	Offset: 0x3760
	Size: 0x1EE
	Parameters: 0
	Flags: None
*/
function qrdrone_crash_accel()
{
	self endon(#"crash_done", #"death");
	count = 0;
	while(true)
	{
		velocity = self getvelocity();
		self setvehvelocity(velocity + (anglestoup(self.angles) * self.crash_accel));
		self.crash_accel = self.crash_accel * 0.98;
		wait(0.1);
		count++;
		if((count % 8) == 0)
		{
			if(randomint(100) > 40)
			{
				if(velocity[2] > 150)
				{
					self.crash_accel = self.crash_accel * 0.75;
				}
				else if(velocity[2] < 40 && count < 60)
				{
					if(abs(self.angles[0]) > 30 || abs(self.angles[2]) > 30)
					{
						self.crash_accel = randomfloatrange(160, 200);
					}
					else
					{
						self.crash_accel = randomfloatrange(85, 120);
					}
				}
			}
		}
	}
}

/*
	Name: qrdrone_collision
	Namespace: qrdrone
	Checksum: 0x44CDEA84
	Offset: 0x3958
	Size: 0x19A
	Parameters: 0
	Flags: None
*/
function qrdrone_collision()
{
	self endon(#"crash_done", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_collision");
		velocity = waitresult.velocity;
		normal = waitresult.normal;
		ang_vel = self getangularvelocity() * 0.5;
		self setangularvelocity(ang_vel);
		velocity = self getvelocity();
		if(normal[2] < 0.7)
		{
			self setvehvelocity(velocity + (normal * 70));
			self playsound(#"veh_qrdrone_wall");
			playfx(level._effect[#"quadrotor_nudge"], self.origin);
		}
		else
		{
			self playsound(#"veh_qrdrone_explo");
			self notify(#"crash_done");
		}
	}
}

/*
	Name: qrdrone_watch_distance
	Namespace: qrdrone
	Checksum: 0xCF0FFFA5
	Offset: 0x3B00
	Size: 0x318
	Parameters: 2
	Flags: None
*/
function qrdrone_watch_distance(zoffset, minheightoverride)
{
	self endon(#"death");
	self clientfield::set("qrdrone_out_of_range", 1);
	waitframe(1);
	self clientfield::set("qrdrone_out_of_range", 0);
	qrdrone_height = struct::get("qrdrone_height", "targetname");
	if(isdefined(qrdrone_height))
	{
		self.maxheight = qrdrone_height.origin[2];
	}
	else
	{
		self.maxheight = int(airsupport::getminimumflyheight());
	}
	if(isdefined(zoffset))
	{
		self.maxheight = self.maxheight + zoffset;
	}
	self.maxdistance = 12800;
	self.minheight = level.mapcenter[2] - 800;
	if(isdefined(minheightoverride))
	{
		self.minheight = minheightoverride;
	}
	self.centerref = spawn("script_model", level.mapcenter);
	inrangepos = self.origin;
	self.rangecountdownactive = 0;
	while(true)
	{
		if(!self qrdrone_in_range())
		{
			staticalpha = 0;
			while(!self qrdrone_in_range())
			{
				if(!self.rangecountdownactive)
				{
					self.rangecountdownactive = 1;
					self thread qrdrone_rangecountdown();
				}
				if(isdefined(self.heliinproximity))
				{
					dist = distance(self.origin, self.heliinproximity.origin);
					staticalpha = 1 - ((dist - 150) / 150);
				}
				else
				{
					dist = distance(self.origin, inrangepos);
					staticalpha = min(0.7, dist / 200);
				}
				self.owner set_static_alpha(staticalpha, self);
				waitframe(1);
			}
			self notify(#"in_range");
			self.rangecountdownactive = 0;
			self thread qrdrone_staticfade(staticalpha);
		}
		inrangepos = self.origin;
		waitframe(1);
	}
}

/*
	Name: qrdrone_in_range
	Namespace: qrdrone
	Checksum: 0xBB88ADC1
	Offset: 0x3E20
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function qrdrone_in_range()
{
	if(self.origin[2] < self.maxheight && self.origin[2] > self.minheight && !self.inheliproximity)
	{
		if(self isinsideheightlock())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: qrdrone_staticfade
	Namespace: qrdrone
	Checksum: 0xAEEF6C29
	Offset: 0x3E90
	Size: 0x9E
	Parameters: 1
	Flags: None
*/
function qrdrone_staticfade(staticalpha)
{
	self endon(#"death");
	while(self qrdrone_in_range())
	{
		staticalpha = staticalpha - 0.05;
		if(staticalpha < 0)
		{
			self.owner set_static_alpha(staticalpha, self);
			break;
		}
		self.owner set_static_alpha(staticalpha, self);
		waitframe(1);
	}
}

/*
	Name: qrdrone_rangecountdown
	Namespace: qrdrone
	Checksum: 0x225F57DA
	Offset: 0x3F38
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function qrdrone_rangecountdown()
{
	self endon(#"death", #"in_range");
	if(isdefined(self.heliinproximity))
	{
		countdown = 6.1;
	}
	else
	{
		countdown = 6.1;
	}
	hostmigration::waitlongdurationwithhostmigrationpause(countdown);
	self.owner notify(#"stop_signal_failure");
	if(isdefined(self.distance_shutdown_override))
	{
		return [[self.distance_shutdown_override]]();
	}
	self clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher thread weaponobjects::waitanddetonate(self, 0);
}

/*
	Name: qrdrone_explode_on_notify
	Namespace: qrdrone
	Checksum: 0xD70BA547
	Offset: 0x4050
	Size: 0x14C
	Parameters: 1
	Flags: None
*/
function qrdrone_explode_on_notify(killstreak_id)
{
	self endon(#"death", #"end_ride");
	self.owner waittill(#"disconnect", #"joined_team", #"joined_spectators");
	if(isdefined(self.owner))
	{
		self.owner killstreaks::clear_using_remote();
		self.owner destroyhud();
		self.owner qrdrone_endride(self);
	}
	else
	{
		killstreakrules::killstreakstop("qrdrone", self.team, killstreak_id);
	}
	self clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher thread weaponobjects::waitanddetonate(self, 0);
}

/*
	Name: qrdrone_explode_on_game_end
	Namespace: qrdrone
	Checksum: 0x8D8AEB94
	Offset: 0x41A8
	Size: 0xAC
	Parameters: 0
	Flags: None
*/
function qrdrone_explode_on_game_end()
{
	self endon(#"death");
	level waittill(#"game_ended");
	self clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher weaponobjects::waitanddetonate(self, 0);
	self.owner qrdrone_endride(self);
}

/*
	Name: qrdrone_leave_on_timeout
	Namespace: qrdrone
	Checksum: 0xC77A4894
	Offset: 0x4260
	Size: 0x18C
	Parameters: 1
	Flags: None
*/
function qrdrone_leave_on_timeout(killstreakname)
{
	qrdrone = self;
	qrdrone endon(#"death");
	if(!level.vehiclestimed)
	{
		return;
	}
	qrdrone.flytime = 60;
	waittime = self.flytime - 10;
	/#
		util::set_dvar_int_if_unset("", qrdrone.flytime);
		qrdrone.flytime = getdvarint(#"scr_qrdroneflytime", 0);
		waittime = self.flytime - 10;
		if(waittime < 0)
		{
			wait(qrdrone.flytime);
			self clientfield::set("", 3);
			watcher = qrdrone.owner weaponobjects::getweaponobjectwatcher("");
			watcher thread weaponobjects::waitanddetonate(qrdrone, 0);
			return;
		}
	#/
	qrdrone thread killstreaks::waitfortimeout(killstreakname, waittime, &qrdrone_leave_on_timeout_callback, "death");
}

/*
	Name: qrdrone_leave_on_timeout_callback
	Namespace: qrdrone
	Checksum: 0x585054EC
	Offset: 0x43F8
	Size: 0x12C
	Parameters: 0
	Flags: None
*/
function qrdrone_leave_on_timeout_callback()
{
	qrdrone = self;
	qrdrone clientfield::set("qrdrone_state", 1);
	qrdrone clientfield::set("qrdrone_countdown", 1);
	hostmigration::waitlongdurationwithhostmigrationpause(6);
	qrdrone clientfield::set("qrdrone_state", 2);
	qrdrone clientfield::set("qrdrone_timeout", 1);
	hostmigration::waitlongdurationwithhostmigrationpause(4);
	qrdrone clientfield::set("qrdrone_state", 3);
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	watcher thread weaponobjects::waitanddetonate(self, 0);
}

/*
	Name: qrdrone_leave
	Namespace: qrdrone
	Checksum: 0x98B2EE1F
	Offset: 0x4530
	Size: 0x8E
	Parameters: 0
	Flags: None
*/
function qrdrone_leave()
{
	level endon(#"game_ended");
	self endon(#"death");
	self notify(#"leaving");
	self.owner qrdrone_unlink(self);
	self.owner qrdrone_endride(self);
	self notify(#"death");
}

/*
	Name: qrdrone_exit_button_pressed
	Namespace: qrdrone
	Checksum: 0x2CA2D4EB
	Offset: 0x45C8
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function qrdrone_exit_button_pressed()
{
	return self usebuttonpressed();
}

/*
	Name: qrdrone_watch_for_exit
	Namespace: qrdrone
	Checksum: 0x7DB01ED3
	Offset: 0x45F0
	Size: 0x122
	Parameters: 0
	Flags: None
*/
function qrdrone_watch_for_exit()
{
	level endon(#"game_ended");
	self endon(#"death");
	self.owner endon(#"disconnect");
	wait(1);
	while(true)
	{
		timeused = 0;
		while(self.owner qrdrone_exit_button_pressed())
		{
			timeused = timeused + 0.05;
			if(timeused > 0.25)
			{
				self clientfield::set("qrdrone_state", 3);
				watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
				watcher thread weaponobjects::waitanddetonate(self, 0, self.owner);
				return;
			}
			waitframe(1);
		}
		waitframe(1);
	}
}

/*
	Name: qrdrone_cleanup
	Namespace: qrdrone
	Checksum: 0x38DFAF89
	Offset: 0x4720
	Size: 0x124
	Parameters: 0
	Flags: None
*/
function qrdrone_cleanup()
{
	if(level.gameended)
	{
		return;
	}
	if(isdefined(self.owner))
	{
		if(self.playerlinked == 1)
		{
			self.owner qrdrone_unlink(self);
		}
		self.owner qrdrone_endride(self);
	}
	if(isdefined(self.scrambler))
	{
		self.scrambler delete();
	}
	if(isdefined(self) && isdefined(self.centerref))
	{
		self.centerref delete();
	}
	if(isdefined(self.damage_fx_ent))
	{
		self.damage_fx_ent delete();
	}
	if(isdefined(self.emp_fx))
	{
		self.emp_fx delete();
	}
	self delete();
}

/*
	Name: qrdrone_light_fx
	Namespace: qrdrone
	Checksum: 0x5417C7C9
	Offset: 0x4850
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function qrdrone_light_fx()
{
	playfxontag(level.chopper_fx[#"light"][#"belly"], self, "tag_light_nose");
	waitframe(1);
	playfxontag(level.chopper_fx[#"light"][#"tail"], self, "tag_light_tail1");
}

/*
	Name: qrdrone_dialog
	Namespace: qrdrone
	Checksum: 0x24A084FF
	Offset: 0x48E8
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function qrdrone_dialog(dialoggroup)
{
	if(dialoggroup == "tag")
	{
		waittime = 1000;
	}
	else
	{
		waittime = 5000;
	}
	if(gettime() - level.qrdrone_lastdialogtime < waittime)
	{
		return;
	}
	level.qrdrone_lastdialogtime = gettime();
	randomindex = randomint(level.qrdrone_dialog[dialoggroup].size);
	soundalias = level.qrdrone_dialog[dialoggroup][randomindex];
	self playlocalsound(soundalias);
}

/*
	Name: qrdrone_watchheliproximity
	Namespace: qrdrone
	Checksum: 0xFB5BA008
	Offset: 0x49B0
	Size: 0xB4
	Parameters: 0
	Flags: None
*/
function qrdrone_watchheliproximity()
{
	level endon(#"game_ended");
	self endon(#"death", #"end_remote");
	while(true)
	{
		inheliproximity = 0;
		if(!self.inheliproximity && inheliproximity)
		{
			self.inheliproximity = 1;
		}
		else if(self.inheliproximity && !inheliproximity)
		{
			self.inheliproximity = 0;
			self.heliinproximity = undefined;
		}
		waitframe(1);
	}
}

/*
	Name: qrdrone_detonatewaiter
	Namespace: qrdrone
	Checksum: 0x68D01908
	Offset: 0x4A70
	Size: 0x184
	Parameters: 0
	Flags: None
*/
function qrdrone_detonatewaiter()
{
	self.owner endon(#"disconnect");
	self endon(#"death");
	while(self.owner attackbuttonpressed())
	{
		waitframe(1);
	}
	watcher = self.owner weaponobjects::getweaponobjectwatcher("qrdrone");
	while(!self.owner attackbuttonpressed())
	{
		waitframe(1);
	}
	self clientfield::set("qrdrone_state", 3);
	watcher thread weaponobjects::waitanddetonate(self, 0);
	self.owner thread hud::fade_to_black_for_x_sec(getdvarfloat(#"scr_rcbomb_fadeout_delay", 0), getdvarfloat(#"scr_rcbomb_fadeout_timein", 0), getdvarfloat(#"scr_rcbomb_fadeout_timeblack", 0), getdvarfloat(#"scr_rcbomb_fadeout_timeout", 0));
}

/*
	Name: qrdrone_fireguns
	Namespace: qrdrone
	Checksum: 0x698051E
	Offset: 0x4C00
	Size: 0x112
	Parameters: 1
	Flags: None
*/
function qrdrone_fireguns(qrdrone)
{
	self endon(#"disconnect");
	qrdrone endon(#"death", #"blowup", #"crashing");
	level endon(#"game_ended");
	qrdrone endon(#"end_remote");
	wait(1);
	while(true)
	{
		if(self attackbuttonpressed())
		{
			qrdrone fireweapon();
			weapon = getweapon(#"qrdrone_turret");
			firetime = weapon.firetime;
			wait(firetime);
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: qrdrone_blowup
	Namespace: qrdrone
	Checksum: 0x6AFB298
	Offset: 0x4D20
	Size: 0x36C
	Parameters: 2
	Flags: None
*/
function qrdrone_blowup(attacker, weapon)
{
	self.owner endon(#"disconnect");
	self endon(#"death");
	self notify(#"blowup");
	explosionorigin = self.origin;
	explosionangles = self.angles;
	if(!isdefined(attacker))
	{
		attacker = self.owner;
	}
	origin = self.origin + vectorscale((0, 0, 1), 10);
	radius = 256;
	min_damage = 10;
	max_damage = 35;
	if(isdefined(attacker))
	{
		self radiusdamage(origin, radius, max_damage, min_damage, attacker, "MOD_EXPLOSIVE", self.weapon);
	}
	physicsexplosionsphere(origin, radius, radius, 1, max_damage, min_damage);
	function_2f95a020(origin);
	playsoundatposition(#"veh_qrdrone_explo", self.origin);
	playfx(level.qrdrone_fx[#"explode"], explosionorigin, (0, 0, 1));
	self hide();
	if(isdefined(self.owner))
	{
		self.owner util::clientnotify("qrdrone_blowup");
		if(attacker != self.owner)
		{
			level.globalkillstreaksdestroyed++;
			attacker stats::function_e24eec31(self.weapon, #"destroyed", 1);
		}
		self.owner remote_weapons::destroyremotehud();
		self.owner val::set(#"qrdrone_blowup", "freezecontrols");
		self.owner sendkillstreakdamageevent(600);
		wait(0.75);
		self.owner thread hud::fade_to_black_for_x_sec(0, 0.25, 0.1, 0.25);
		wait(0.25);
		self.owner qrdrone_unlink(self);
		self.owner val::reset(#"qrdrone_blowup", "freezecontrols");
		if(isdefined(self.neverdelete) && self.neverdelete)
		{
			return;
		}
	}
	qrdrone_cleanup();
}

/*
	Name: function_2f95a020
	Namespace: qrdrone
	Checksum: 0x67AFAED4
	Offset: 0x5098
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function function_2f95a020(position)
{
	playrumbleonposition("grenade_rumble", position);
	earthquake(0.5, 0.5, self.origin, 512);
}

/*
	Name: setvisionsetwaiter
	Namespace: qrdrone
	Checksum: 0xB87B6C47
	Offset: 0x50F8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function setvisionsetwaiter()
{
	self endon(#"disconnect");
	self useservervisionset(1);
	self setvisionsetforplayer(level.qrdrone_vision, 1);
	self.qrdrone waittill(#"end_remote");
	self useservervisionset(0);
}

/*
	Name: destroyhud
	Namespace: qrdrone
	Checksum: 0x9E9F70BB
	Offset: 0x5188
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function destroyhud()
{
	if(isdefined(self))
	{
		self notify(#"stop_signal_failure");
		self.flashingsignalfailure = 0;
		self clientfield::set_to_player("static_postfx", 0);
		self remote_weapons::destroyremotehud();
		self util::clientnotify("nofutz");
	}
}

/*
	Name: set_static_alpha
	Namespace: qrdrone
	Checksum: 0xAC182203
	Offset: 0x5218
	Size: 0xF4
	Parameters: 2
	Flags: None
*/
function set_static_alpha(alpha, drone)
{
	if(alpha > 0)
	{
		if(!isdefined(self.flashingsignalfailure) || !self.flashingsignalfailure)
		{
			self thread flash_signal_failure(drone);
			self.flashingsignalfailure = 1;
			if(self isremotecontrolling())
			{
				self clientfield::set_to_player("static_postfx", 1);
			}
		}
	}
	else
	{
		self notify(#"stop_signal_failure");
		drone clientfield::set("qrdrone_out_of_range", 0);
		self.flashingsignalfailure = 0;
		self clientfield::set_to_player("static_postfx", 0);
	}
}

/*
	Name: flash_signal_failure
	Namespace: qrdrone
	Checksum: 0x2611E2
	Offset: 0x5318
	Size: 0xC6
	Parameters: 1
	Flags: None
*/
function flash_signal_failure(drone)
{
	self endon(#"stop_signal_failure");
	drone endon(#"death");
	drone clientfield::set("qrdrone_out_of_range", 1);
	i = 0;
	for(;;)
	{
		drone playsoundtoplayer(#"uin_alert_lockon", self);
		if(i < 5)
		{
			wait(0.6);
		}
		else if(i < 6)
		{
			wait(0.5);
		}
		else
		{
			wait(0.3);
		}
		i++;
	}
}

