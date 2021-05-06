// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_342e0d1a78771d3f;
#using script_383a3b1bb18ba876;
#using script_47fb62300ac0bd60;
#using script_4a03c204316cf33;
#using script_57c900a7e39234be;
#using script_5afbda9de6000ad9;
#using script_6c8abe14025b47c4;
#using script_bc6a9a35c229565;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\dialog_shared.gsc;
#using scripts\core_common\hud_shared.gsc;
#using scripts\core_common\influencers_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace remotemissile;

/*
	Name: init_shared
	Namespace: remotemissile
	Checksum: 0xFD366677
	Offset: 0x478
	Size: 0x39C
	Parameters: 1
	Flags: None
*/
function init_shared(bundlename)
{
	if(!(isdefined(level.var_e3049e92) && level.var_e3049e92) && !isdefined(level.var_f80c2e27))
	{
		level.var_f80c2e27 = {};
		airsupport::init_shared();
		level.rockets = [];
		killstreak_detect::init_shared();
		if(!isdefined(bundlename))
		{
			bundlename = "killstreak_remote_missile";
		}
		bundle = struct::get_script_bundle("killstreak", bundlename);
		killstreaks::function_25ce781d(bundle, &tryusepredatormissile);
		killstreaks::set_team_kill_penalty_scale("remote_missile", level.teamkillreducedpenalty);
		clientfield::register("missile", "remote_missile_brakes", 1, 1, "int");
		clientfield::register("missile", "remote_missile_bomblet_fired", 1, 1, "int");
		clientfield::register("missile", "remote_missile_fired", 1, 2, "int");
		clientfield::register("missile", "remote_missile_phase2", 1, 1, "int");
		clientfield::register("toplayer", "remote_missile_screenfx", 1, 1, "int");
		clientfield::register("clientuimodel", "hudItems.remoteMissilePhase2", 1, 1, "int");
		clientfield::register("scriptmover", "hellstorm_camera", 1, 1, "int");
		clientfield::register("scriptmover", "hellstorm_deploy", 1, 1, "int");
		level.missilesforsighttraces = [];
		level.missileremotedeployfx = bundle.var_64cbe61e;
		level.missileremotelaunchvert = 12000;
		level.missileremotelaunchhorz = 7000;
		level.missileremotelaunchtargetdist = 1500;
		level.remote_missile_targets = remote_missile_targets::register("remote_missile_targets");
		level.var_aac98621 = [];
		for(ti = 0; ti < 6; ti++)
		{
			level.var_aac98621[ti] = remote_missile_target_lockon::register("remote_missile_target_lockon" + ti);
		}
		callback::on_spawned(&on_player_spawned);
		callback::on_finalize_initialization(&function_3675de8b);
	}
}

/*
	Name: function_3675de8b
	Namespace: remotemissile
	Checksum: 0x2B42D8DC
	Offset: 0x820
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function function_3675de8b()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon("remote_missile"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: remotemissile
	Checksum: 0xE09158A1
	Offset: 0x870
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function function_bff5c062(remotemissile, var_dbd1a594)
{
	remotemissile dodamage(1000, remotemissile.origin, var_dbd1a594);
	if(isdefined(remotemissile.bomblets))
	{
		foreach(bomblet in remotemissile.bomblets)
		{
			if(!isdefined(bomblet))
			{
				continue;
			}
			bomblet detonate();
			bomblet notify(#"hash_29e967c616cdc4c9");
		}
	}
}

/*
	Name: on_player_spawned
	Namespace: remotemissile
	Checksum: 0x48912EA1
	Offset: 0x960
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self.var_795afb1f = undefined;
	self destroy_missile_hud();
}

/*
	Name: tryusepredatormissile
	Namespace: remotemissile
	Checksum: 0xE98AE99A
	Offset: 0x990
	Size: 0x142
	Parameters: 1
	Flags: None
*/
function tryusepredatormissile(lifeid)
{
	waterdepth = self depthofplayerinwater();
	if(!self isonground() || self util::isusingremote() || waterdepth > 2)
	{
		self iprintlnbold(#"hash_3f750164757cd400");
		return 0;
	}
	team = self.team;
	killstreak_id = self killstreakrules::killstreakstart("remote_missile", team, 0, 1);
	if(killstreak_id == -1)
	{
		return 0;
	}
	self.remotemissilepilotindex = killstreaks::get_random_pilot_index("remote_missile");
	returnvar = _fire(lifeid, self, team, killstreak_id);
	return returnvar;
}

/*
	Name: function_203098f4
	Namespace: remotemissile
	Checksum: 0x1FF47C3E
	Offset: 0xAE0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_203098f4(waittime)
{
	self endon(#"disconnect");
	wait(waittime);
	lui::screen_fade_in(0.1);
}

/*
	Name: _fire
	Namespace: remotemissile
	Checksum: 0xB1CA6AE3
	Offset: 0xB28
	Size: 0x10B8
	Parameters: 4
	Flags: None
*/
function _fire(lifeid, player, team, killstreak_id)
{
	player notify(#"remote_missile_fired");
	weapon = getweapon(#"remote_missile");
	settings = getscriptbundle(weapon.var_4dd46f8a);
	streamermodelhint(weapon.var_22082a57, 7);
	remotemissilespawnarray = getentarray("remoteMissileSpawn", "targetname");
	foreach(spawn in remotemissilespawnarray)
	{
		if(isdefined(spawn.target))
		{
			spawn.targetent = getent(spawn.target, "targetname");
		}
	}
	if(remotemissilespawnarray.size > 0)
	{
		remotemissilespawn = player getbestspawnpoint(remotemissilespawnarray);
	}
	else
	{
		remotemissilespawn = undefined;
	}
	if(isdefined(remotemissilespawn))
	{
		startpos = remotemissilespawn.origin;
		targetpos = airsupport::getmapcenter();
		/#
		#/
		vector = vectornormalize(startpos - targetpos);
		startpos = vector * level.missileremotelaunchvert + targetpos;
	}
	else
	{
		upvector = (0, 0, level.missileremotelaunchvert);
		backdist = level.missileremotelaunchhorz;
		targetdist = level.missileremotelaunchtargetdist;
		forward = anglestoforward(player.angles);
		startpos = player.origin + upvector + forward * backdist * -1;
		targetpos = player.origin + forward * targetdist;
	}
	self util::setusingremote("remote_missile");
	self val::set(#"hash_2eb933ec367f456d", "freezecontrols");
	player disableweaponcycling();
	result = self killstreaks::init_ride_killstreak("remote_missile");
	if(result != "success" || level.gameended)
	{
		if(result != "disconnect")
		{
			player val::reset(#"hash_2eb933ec367f456d", "freezecontrols");
			player killstreaks::clear_using_remote();
			player killstreaks::thermal_glow(0);
			player enableweaponcycling();
			killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
		}
		return 0;
	}
	if(isdefined(player))
	{
		player callback::callback(#"hash_247d67dbf83dbc1a");
	}
	offset = level.var_46c23c0f * 200;
	level.var_46c23c0f++;
	if(level.var_46c23c0f > 3)
	{
		level.var_46c23c0f = 0;
	}
	loc_00001042:
	loc_00001072:
	var_b984f2ed = (level.mapcenter[0] + (isdefined(level.var_5d4b4923) ? level.var_5d4b4923 : 0) + offset, level.mapcenter[1] + (isdefined(level.var_462a6e1e) ? level.var_462a6e1e : 0) + offset, startpos[2] + (isdefined(level.var_654c4b25) ? level.var_654c4b25 : 0));
	startpos = var_b984f2ed - vectorscale((1, 0, 0), 5000);
	fwd = var_b984f2ed - startpos;
	startangles = vectortoangles(fwd);
	veh = spawn("script_model", startpos);
	veh.weapon = weapon;
	veh setweapon(weapon);
	veh.owner = player;
	/#
		recordent(veh);
	#/
	self killstreaks::play_killstreak_start_dialog("remote_missile", self.pers[#"team"], killstreak_id);
	veh setmodel(weapon.var_22082a57);
	veh setenemymodel(weapon.stowedmodel);
	veh playloopsound("veh_hellstorm_dropship_base");
	var_52df21ae = veh gettagorigin("tag_camera");
	cam = spawn("script_model", var_52df21ae);
	cam setmodel(#"tag_origin");
	cam linkto(veh, "tag_camera");
	player clientfield::set_to_player("remote_missile_screenfx", 1);
	cam setowner(player);
	cam clientfield::set("hellstorm_camera", 1);
	player clientfield::set("remote_killstreak_static", 1);
	veh moveto(var_b984f2ed, 2.5);
	player val::set(#"hash_37f3e8e45cfa1e62", "show_hud", 0);
	player camerasetposition(cam.origin);
	player camerasetlookat(cam.angles);
	player cameraactivate(1);
	while(isdefined(level.var_e891c5ba) && level.var_e891c5ba)
	{
		waitframe(1);
	}
	veh clientfield::set("hellstorm_deploy", 1);
	veh useanimtree("generic");
	veh setanim(#"hash_4b6a7686ae8c1f16", 1);
	if(isdefined(level.var_5951cb24))
	{
		self [[level.var_5951cb24]](killstreak_id, team);
	}
	player playsoundtoplayer(#"hash_1f70287e92a32746", player);
	animlen = getanimlength(#"hash_4b6a7686ae8c1f16");
	wait(animlen * 0.7);
	if(!isdefined(player))
	{
		return 0;
	}
	thread function_203098f4(0.3);
	lui::screen_fade_out(0.1);
	startpos = veh.origin - vectorscale((0, 0, 1), 30);
	rocket = magicbullet(getweapon(#"remote_missile_missile"), startpos, targetpos, player);
	rocket.forceonemissile = 1;
	forceanglevector = vectornormalize(targetpos - startpos);
	rocket.angles = vectortoangles(forceanglevector);
	rocket missile_settarget(undefined);
	rocket.targetname = "remote_missile";
	rocket killstreaks::configure_team("remote_missile", killstreak_id, self, undefined, undefined, undefined);
	rocket killstreak_hacking::enable_hacking("remote_missile", undefined, &hackedpostfunction);
	killstreak_detect::killstreaktargetset(rocket);
	rocket.hackedhealthupdatecallback = &hackedhealthupdate;
	rocket clientfield::set("enemyvehicle", 1);
	rocket clientfield::set("remote_missile_phase2", 0);
	rocket.var_817f15dd = getweapon("remote_missile");
	if(!isdefined(rocket.bomblets))
	{
		rocket.bomblets = [];
	}
	player clientfield::set_player_uimodel("hudItems.remoteMissilePhase2", 0);
	self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
	player killstreaks::thermal_glow(1);
	rocket thread handledamage(killstreak_id);
	rocket thread function_dc2222ff(player);
	player linktomissile(rocket, 1, 1);
	player.rocket = rocket;
	rocket.owner = player;
	rocket.killcament = player;
	player val::reset(#"hash_37f3e8e45cfa1e62", "show_hud");
	cam clientfield::set("hellstorm_camera", 0);
	veh clientfield::set("hellstorm_deploy", 0);
	waitframe(1);
	if(!isdefined(player))
	{
		rocket notify(#"hash_2dd8cca4f8f64e9d");
		waitframe(1);
		if(isdefined(rocket))
		{
			rocket notify(#"death");
			rocket delete();
		}
		if(isdefined(veh))
		{
			veh delete();
		}
		return 0;
	}
	cam delete();
	player cameraactivate(0);
	player thread cleanupwaiter(rocket, player.team, killstreak_id);
	player setmodellodbias((isdefined(level.remotemissile_lod_bias) ? level.remotemissile_lod_bias : 12));
	self clientfield::set("operating_predator", 1);
	self stats::function_e24eec31(getweapon(#"remote_missile"), #"used", 1);
	player.var_a8c5fe4e = 1;
	player val::reset(#"hash_2eb933ec367f456d", "freezecontrols");
	player thread create_missile_hud(rocket);
	rocket thread function_9761dd1d();
	rocket function_17485b5(veh, 0, 0);
	veh unlink();
	fwd = anglestoforward(veh.angles);
	endpos = veh.origin + vectorscale(fwd, 20000);
	time = 5;
	rocket notify(#"hash_2dd8cca4f8f64e9d");
	veh moveto(endpos, time);
	veh thread waitthendelete(time);
	rocket thread watch_missile_kill_z();
	rocket missile_sound_play(player);
	rocket playsound("wpn_remote_missile_launch_npc");
	rocket thread missile_brake_timeout_watch();
	rocket thread missile_sound_impact(player, 3800);
	player thread missile_sound_boost(rocket);
	player thread missile_deploy_watch(rocket);
	player thread remote_missile_game_end_think(rocket, player.team, killstreak_id);
	player thread watch_missile_death(rocket, player.team, killstreak_id);
	player thread sndwatchexplo();
	rocket influencers::create_entity_enemy_influencer("small_vehicle", rocket.team);
	player waittill(#"remotemissle_killstreak_done");
	return 1;
}

/*
	Name: remote_missile_game_end_think
	Namespace: remotemissile
	Checksum: 0x4E597BE
	Offset: 0x1BE8
	Size: 0x8E
	Parameters: 3
	Flags: None
*/
function remote_missile_game_end_think(rocket, team, killstreak_id)
{
	self endon(#"remotemissle_killstreak_done");
	level waittill(#"game_ended", #"hash_2f4afe1cb9b6de05");
	self thread function_97f822ec(rocket, 1, 1, team, killstreak_id);
	self notify(#"remotemissle_killstreak_done");
}

/*
	Name: getbestspawnpoint
	Namespace: remotemissile
	Checksum: 0xD506D155
	Offset: 0x1C80
	Size: 0x3FA
	Parameters: 1
	Flags: None
*/
function getbestspawnpoint(remotemissilespawnpoints)
{
	validenemies = [];
	foreach(spawnpoint in remotemissilespawnpoints)
	{
		spawnpoint.validplayers = [];
		spawnpoint.spawnscore = 0;
	}
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(!player util::isenemyteam(self.team))
		{
			continue;
		}
		if(player.team == #"spectator")
		{
			continue;
		}
		bestdistance = 999999999;
		bestspawnpoint = undefined;
		foreach(spawnpoint in remotemissilespawnpoints)
		{
			spawnpoint.validplayers[spawnpoint.validplayers.size] = player;
			potentialbestdistance = distance2dsquared(spawnpoint.targetent.origin, player.origin);
			if(potentialbestdistance <= bestdistance)
			{
				bestdistance = potentialbestdistance;
				bestspawnpoint = spawnpoint;
			}
		}
		bestspawnpoint.spawnscore = bestspawnpoint.spawnscore + 2;
	}
	bestspawn = remotemissilespawnpoints[0];
	foreach(spawnpoint in remotemissilespawnpoints)
	{
		foreach(player in spawnpoint.validplayers)
		{
			spawnpoint.spawnscore = spawnpoint.spawnscore + 1;
			if(bullettracepassed(player.origin + vectorscale((0, 0, 1), 32), spawnpoint.origin, 0, player))
			{
				spawnpoint.spawnscore = spawnpoint.spawnscore + 3;
			}
			if(spawnpoint.spawnscore > bestspawn.spawnscore)
			{
				bestspawn = spawnpoint;
				continue;
			}
			if(spawnpoint.spawnscore == bestspawn.spawnscore)
			{
				if(math::cointoss())
				{
					bestspawn = spawnpoint;
				}
			}
		}
	}
	return bestspawn;
}

/*
	Name: function_9761dd1d
	Namespace: remotemissile
	Checksum: 0x2C384E20
	Offset: 0x2088
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function function_9761dd1d()
{
	self endon(#"death");
	wait(0.1);
	self clientfield::set("remote_missile_fired", 1);
}

/*
	Name: watch_missile_kill_z
	Namespace: remotemissile
	Checksum: 0x51E86526
	Offset: 0x20D8
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function watch_missile_kill_z()
{
	if(!isdefined(level.remotemissile_kill_z))
	{
		return;
	}
	rocket = self;
	kill_z = level.remotemissile_kill_z;
	rocket endon(#"remotemissle_killstreak_done", #"death");
	while(rocket.origin[2] > kill_z)
	{
		wait(0.1);
	}
	rocket detonate();
}

/*
	Name: watch_missile_death
	Namespace: remotemissile
	Checksum: 0xF42D3F7F
	Offset: 0x2180
	Size: 0x96
	Parameters: 3
	Flags: None
*/
function watch_missile_death(rocket, team, killstreak_id)
{
	self endon(#"remotemissle_killstreak_done");
	rocket waittill(#"death");
	self thread function_97f822ec(rocket, 1, 1, team, killstreak_id);
	self thread remotemissile_bda_dialog();
	self notify(#"remotemissle_killstreak_done");
}

/*
	Name: hackedhealthupdate
	Namespace: remotemissile
	Checksum: 0x5035E7C1
	Offset: 0x2220
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function hackedhealthupdate(hacker)
{
}

/*
	Name: hackedpostfunction
	Namespace: remotemissile
	Checksum: 0x424347EF
	Offset: 0x2238
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function hackedpostfunction(hacker)
{
	rocket = self;
	hacker missile_deploy(rocket, 1);
}

/*
	Name: rotaterig
	Namespace: remotemissile
	Checksum: 0xEEC6E25E
	Offset: 0x2280
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function rotaterig()
{
	for(;;)
	{
		self rotateyaw(-360, 60);
		wait(60);
	}
}

/*
	Name: swayrig
	Namespace: remotemissile
	Checksum: 0xB6D29D9E
	Offset: 0x22B8
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function swayrig()
{
	centerorigin = self.origin;
	for(;;)
	{
		z = randomintrange(-200, -100);
		time = randomintrange(3, 6);
		self moveto(centerorigin + (0, 0, z), time, 1, 1);
		wait(time);
		z = randomintrange(100, 200);
		time = randomintrange(3, 6);
		self moveto(centerorigin + (0, 0, z), time, 1, 1);
		wait(time);
	}
}

/*
	Name: waitthendelete
	Namespace: remotemissile
	Checksum: 0x52856FF1
	Offset: 0x23D0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function waitthendelete(waittime)
{
	self endon(#"delete", #"death");
	wait(waittime);
	self delete();
}

/*
	Name: function_71f4cd34
	Namespace: remotemissile
	Checksum: 0xE826BEA2
	Offset: 0x2428
	Size: 0xA6
	Parameters: 0
	Flags: None
*/
function function_71f4cd34()
{
	rocket = self;
	var_d0c52d0b = getweapon(#"hash_33be4792feeabece");
	var_a70219cf = magicbullet(var_d0c52d0b, rocket.origin, rocket.origin + anglestoforward(rocket.angles) * 1000, rocket.owner);
}

/*
	Name: function_17485b5
	Namespace: remotemissile
	Checksum: 0xBC9ACE94
	Offset: 0x24D8
	Size: 0x288
	Parameters: 3
	Flags: None
*/
function function_17485b5(veh, var_7e0e1fa6, var_3d0e8f5b)
{
	rocket = self;
	rocket.descend = 0;
	starttime = gettime();
	fire_time = 0;
	missiles_fired = 0;
	var_ecf86986 = 0;
	if(var_7e0e1fa6 > 0)
	{
		time_threshold = var_7e0e1fa6;
		var_facd4b29 = 0;
		while(isdefined(rocket))
		{
			if(isdefined(rocket.owner) && rocket.owner attackbuttonpressed())
			{
				if(!(isdefined(var_facd4b29) && var_facd4b29))
				{
					if(missiles_fired < var_ecf86986)
					{
						rocket function_71f4cd34();
						missiles_fired++;
					}
					else
					{
						break;
					}
				}
				if(missiles_fired == var_ecf86986)
				{
					fire_time = gettime();
				}
				var_facd4b29 = 1;
			}
			else
			{
				var_facd4b29 = 0;
			}
			rocket.origin = veh.origin;
			elapsedtime = gettime() - starttime;
			if(elapsedtime > time_threshold * 1000)
			{
				break;
			}
			if(fire_time > 0)
			{
				elapsedtime = gettime() - fire_time;
				if(elapsedtime > var_3d0e8f5b * 1000)
				{
					break;
				}
			}
			waitframe(1);
		}
	}
	rocket clientfield::set("remote_missile_phase2", 1);
	rocket.owner clientfield::set_player_uimodel("hudItems.remoteMissilePhase2", 1);
	rocket.owner clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 1);
	earthquake(0.5, 2, rocket.origin, 200);
	rocket.descend = 1;
	rocket.var_b5bcdb0c = gettime();
	if(isdefined(level.var_dab39bb8))
	{
		self thread [[level.var_dab39bb8]](rocket);
	}
}

/*
	Name: function_97f822ec
	Namespace: remotemissile
	Checksum: 0xC3E3727A
	Offset: 0x2768
	Size: 0x364
	Parameters: 5
	Flags: None
*/
function function_97f822ec(rocket, performplayerkillstreakend, unlink, team, killstreak_id)
{
	self notify(#"player_missile_end_singleton");
	self endon(#"player_missile_end_singleton");
	if(isalive(rocket))
	{
		if(!(isdefined(rocket.bomblets_deployed) && rocket.bomblets_deployed))
		{
			params = spawnstruct();
			params.position = rocket.origin;
			params.var_7148a82 = 0;
			self thread callback::callback(#"hash_7e19bff37ddc39e3", params);
		}
		rocket influencers::remove_influencers();
		rocket clientfield::set("remote_missile_fired", 0);
		rocket delete();
	}
	self notify(#"snd1stpersonexplo");
	if(isdefined(self))
	{
		self thread destroy_missile_hud();
		self clientfield::set_to_player("remote_missile_screenfx", 0);
		self clientfield::set("remote_killstreak_static", 0);
		if(isdefined(performplayerkillstreakend) && performplayerkillstreakend)
		{
			self playrumbleonentity("grenade_rumble");
			if(level.gameended == 0)
			{
				self sendkillstreakdamageevent(600);
				self thread hud::fade_to_black_for_x_sec(0, 0.4, 0, 0.1);
			}
			if(isdefined(rocket))
			{
				rocket hide();
			}
		}
		self clientfield::set("operating_predator", 0);
		self setmodellodbias(0);
		if(unlink)
		{
			self unlinkfrommissile();
		}
		self notify(#"remotemissile_done");
		self val::reset(#"hash_2eb933ec367f456d", "freezecontrols");
		self killstreaks::clear_using_remote();
		self killstreaks::thermal_glow(0);
		self enableweaponcycling();
		killstreakrules::killstreakstop("remote_missile", team, killstreak_id);
		self callback::callback(#"hash_72a7670db71677f");
	}
}

/*
	Name: missile_brake_timeout_watch
	Namespace: remotemissile
	Checksum: 0xE890CD42
	Offset: 0x2AD8
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function missile_brake_timeout_watch()
{
	rocket = self;
	player = rocket.owner;
	self endon(#"death");
	self waittill(#"missile_brake");
	rocket clientfield::set("remote_missile_brakes", 1);
	rocket playsound(#"wpn_remote_missile_brake_npc");
	player playlocalsound(#"wpn_remote_missile_brake_plr");
	wait(1.5);
	if(isdefined(self))
	{
		rocket clientfield::set("remote_missile_brakes", 0);
		self setmissilebrake(0);
	}
}

/*
	Name: stopondeath
	Namespace: remotemissile
	Checksum: 0x73EE5B2A
	Offset: 0x2BE0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function stopondeath(snd)
{
	self waittill(#"death");
	if(isdefined(snd))
	{
		snd delete();
	}
}

/*
	Name: cleanupwaiter
	Namespace: remotemissile
	Checksum: 0x86DA65C1
	Offset: 0x2C28
	Size: 0x96
	Parameters: 3
	Flags: None
*/
function cleanupwaiter(rocket, team, killstreak_id)
{
	self endon(#"remotemissle_killstreak_done");
	self waittill(#"joined_team", #"joined_spectators", #"disconnect");
	self thread function_97f822ec(rocket, 0, 0, team, killstreak_id);
	self notify(#"remotemissle_killstreak_done");
}

/*
	Name: handledamage
	Namespace: remotemissile
	Checksum: 0xED477025
	Offset: 0x2CC8
	Size: 0x260
	Parameters: 1
	Flags: None
*/
function handledamage(killstreak_id)
{
	self endon(#"death", #"deleted");
	self setcandamage(1);
	self.health = 99999;
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		damage = waitresult.amount;
		if(isdefined(attacker) && isdefined(self.owner))
		{
			if(attacker == self.owner)
			{
				continue;
			}
			if(self.owner util::isenemyplayer(attacker))
			{
				challenges::destroyedaircraft(attacker, weapon, 1, 1);
				attacker challenges::addflyswatterstat(weapon, self);
				self killstreaks::function_73566ec7(attacker, weapon, self.owner);
				attacker stats::function_e24eec31(weapon, #"destroyed_controlled_killstreak", 1);
				self killstreaks::play_destroyed_dialog_on_owner("remote_missile", killstreak_id);
				if(isdefined(level.var_feddd85a))
				{
					self.owner [[level.var_feddd85a]](attacker, weapon);
				}
			}
			self.owner sendkillstreakdamageevent(int(damage));
		}
		self influencers::remove_influencers();
		self detonate();
	}
}

/*
	Name: rocket_cleanupondeath
	Namespace: remotemissile
	Checksum: 0x647334A3
	Offset: 0x2F30
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function rocket_cleanupondeath()
{
	entitynumber = self getentitynumber();
	level.rockets[entitynumber] = self;
	self waittill(#"death");
	level.rockets[entitynumber] = undefined;
}

/*
	Name: function_dc2222ff
	Namespace: remotemissile
	Checksum: 0x23AD8DEA
	Offset: 0x2FA0
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function function_dc2222ff(player)
{
	self.var_a7a295cf = spawn("script_model", self.origin);
	self.var_a7a295cf setmodel(#"tag_origin");
	self.var_a7a295cf linkto(self);
	self.var_a7a295cf setinvisibletoall();
	self.var_a7a295cf setvisibletoplayer(player);
	self.var_a7a295cf playloopsound(#"hash_1375217a84811e44", 0.5);
	self waittill(#"hash_2dd8cca4f8f64e9d");
	self.var_a7a295cf stoploopsound(0.5);
	self thread stopondeath(self.var_a7a295cf);
}

/*
	Name: missile_sound_play
	Namespace: remotemissile
	Checksum: 0x1AED59C7
	Offset: 0x30D8
	Size: 0x1FC
	Parameters: 1
	Flags: None
*/
function missile_sound_play(player)
{
	self.snd_first = spawn("script_model", self.origin);
	self.snd_first setmodel(#"tag_origin");
	self.snd_first linkto(self);
	self.snd_first setinvisibletoall();
	self.snd_first setvisibletoplayer(player);
	player playlocalsound(#"hash_520c69ce78db3657");
	self.snd_first playloopsound(#"wpn_remote_missile_loop_plr", 0.5);
	self thread stopondeath(self.snd_first);
	self.snd_third = spawn("script_model", self.origin);
	self.snd_third setmodel(#"tag_origin");
	self.snd_third linkto(self);
	self.snd_third setvisibletoall();
	self.snd_third setinvisibletoplayer(player);
	self.snd_third playloopsound(#"wpn_remote_missile_loop_npc", 0.2);
	self thread stopondeath(self.snd_third);
}

/*
	Name: missile_sound_boost
	Namespace: remotemissile
	Checksum: 0x667A3650
	Offset: 0x32E0
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function missile_sound_boost(rocket)
{
	self endon(#"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect");
	self waittill(#"missile_boost");
	if(isdefined(rocket))
	{
		rocket playsound(#"wpn_remote_missile_fire_boost_npc");
		rocket.snd_third playloopsound(#"wpn_remote_missile_boost_npc");
		self playlocalsound(#"wpn_remote_missile_fire_boost_plr");
		rocket.snd_first playloopsound(#"wpn_remote_missile_boost_plr");
		self playrumbleonentity("sniper_fire");
		if(rocket.origin[2] - self.origin[2] > 4000)
		{
			rocket notify(#"stop_impact_sound");
			rocket thread missile_sound_impact(self, 6300);
		}
	}
}

/*
	Name: missile_sound_impact
	Namespace: remotemissile
	Checksum: 0x9462F04F
	Offset: 0x3460
	Size: 0xD8
	Parameters: 2
	Flags: None
*/
function missile_sound_impact(player, distance)
{
	self endon(#"death", #"stop_impact_sound");
	player endon(#"disconnect", #"remotemissile_done", #"joined_team", #"joined_spectators");
	for(;;)
	{
		if(self.origin[2] - player.origin[2] < distance / 0.525)
		{
			self playsound(#"wpn_remote_missile_inc");
			return;
		}
		waitframe(1);
	}
}

/*
	Name: sndwatchexplo
	Namespace: remotemissile
	Checksum: 0x4571791C
	Offset: 0x3540
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function sndwatchexplo()
{
	self endon(#"remotemissle_killstreak_done", #"remotemissile_done", #"joined_team", #"joined_spectators", #"disconnect", #"bomblets_deployed");
	self waittill(#"snd1stpersonexplo");
	self playlocalsound(#"wpn_remote_missile_explode_plr");
}

/*
	Name: missile_sound_deploy_bomblets
	Namespace: remotemissile
	Checksum: 0x1CC66CEB
	Offset: 0x35E8
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function missile_sound_deploy_bomblets()
{
	self.snd_first playloopsound(#"wpn_remote_missile_loop_plr", 0.5);
}

/*
	Name: getvalidtargets
	Namespace: remotemissile
	Checksum: 0xCC978C3C
	Offset: 0x3628
	Size: 0x748
	Parameters: 3
	Flags: None
*/
function getvalidtargets(rocket, trace, max_targets)
{
	pixbeginevent(#"remotemissile_getvts_header");
	targets = [];
	forward = anglestoforward(rocket.angles);
	rocketz = rocket.origin[2];
	mapcenterz = level.mapcenter[2];
	diff = mapcenterz - rocketz;
	ratio = diff / forward[2];
	var_7650a84 = rocket.origin + forward * ratio;
	rocket.var_7650a84 = var_7650a84;
	pixendevent();
	pixbeginevent(#"remotemissile_getvts_enemies");
	enemies = self getenemies();
	foreach(player in enemies)
	{
		if(!isplayer(player))
		{
			continue;
		}
		if(player.ignoreme === 1)
		{
			continue;
		}
		if(distance2dsquared(player.origin, var_7650a84) < 810000 && !player hasperk(#"specialty_nokillstreakreticle"))
		{
			if(trace)
			{
				if(bullettracepassed(player.origin + vectorscale((0, 0, 1), 60), player.origin + vectorscale((0, 0, 1), 1000), 0, player))
				{
					targets[targets.size] = player;
				}
			}
			else
			{
				targets[targets.size] = player;
			}
			if(targets.size >= max_targets)
			{
				return targets;
			}
		}
	}
	dogs = getentarray("attack_dog", "targetname");
	foreach(dog in dogs)
	{
		if(util::function_fbce7263(dog.team, self.team) && distance2dsquared(dog.origin, var_7650a84) < 810000)
		{
			if(trace)
			{
				if(bullettracepassed(dog.origin + vectorscale((0, 0, 1), 60), dog.origin + vectorscale((0, 0, 1), 1000), 0, dog))
				{
					targets[targets.size] = dog;
				}
			}
			else
			{
				targets[targets.size] = dog;
			}
			if(targets.size >= max_targets)
			{
				return targets;
			}
		}
	}
	tanks = getentarray("talon", "targetname");
	foreach(tank in tanks)
	{
		if(util::function_fbce7263(tank.team, self.team) && distance2dsquared(tank.origin, var_7650a84) < 810000)
		{
			if(trace)
			{
				if(bullettracepassed(tank.origin + vectorscale((0, 0, 1), 60), tank.origin + vectorscale((0, 0, 1), 1000), 0, tank))
				{
					targets[targets.size] = tank;
				}
			}
			else
			{
				targets[targets.size] = tank;
			}
			if(targets.size >= max_targets)
			{
				return targets;
			}
		}
	}
	turrets = getentarray("auto_turret", "classname");
	foreach(turret in turrets)
	{
		if(util::function_fbce7263(turret.team, self.team) && distance2dsquared(turret.origin, var_7650a84) < 810000)
		{
			if(trace)
			{
				if(bullettracepassed(turret.origin + vectorscale((0, 0, 1), 60), turret.origin + vectorscale((0, 0, 1), 1000), 0, turret))
				{
					targets[targets.size] = turret;
				}
			}
			else
			{
				targets[targets.size] = turret;
			}
			if(targets.size >= max_targets)
			{
				return targets;
			}
		}
	}
	pixendevent();
	return targets;
}

/*
	Name: getbesttarget
	Namespace: remotemissile
	Checksum: 0x15B455E5
	Offset: 0x3D78
	Size: 0x32E
	Parameters: 2
	Flags: None
*/
function getbesttarget(rocket, trace)
{
	weapon = getweapon(#"remote_missile");
	settings = getscriptbundle(weapon.var_4dd46f8a);
	target_radius = (isdefined(settings.target_radius) ? settings.target_radius : 600);
	best_target = undefined;
	best_dist2 = target_radius * target_radius;
	fwd = anglestoforward(rocket.angles);
	enemies = self getenemies();
	foreach(player in enemies)
	{
		if(!isplayer(player) || (isdefined(player.var_795afb1f) && player.var_795afb1f))
		{
			continue;
		}
		dir = player.origin - rocket.origin;
		dot = vectordot(dir, fwd);
		proj = rocket.origin + vectorscale(fwd, dot);
		dist2 = distancesquared(player.origin, proj);
		if(dist2 < best_dist2)
		{
			if(trace && !bullettracepassed(player.origin + vectorscale((0, 0, 1), 60), player.origin + vectorscale((0, 0, 1), 1000), 0, player))
			{
				continue;
			}
			best_target = player;
			best_dist2 = dist2;
		}
	}
	if(isdefined(best_target))
	{
		rocket.var_7650a84 = best_target.origin;
		rocket.aimtarget = best_target;
	}
	else
	{
		rocket.var_7650a84 = rocket.origin + vectorscale(fwd, 3000);
		rocket.aimtarget = undefined;
	}
	targets = [];
	targets[0] = best_target;
	return targets;
}

/*
	Name: function_8c981143
	Namespace: remotemissile
	Checksum: 0xB49D39C
	Offset: 0x40B0
	Size: 0x25A
	Parameters: 1
	Flags: None
*/
function function_8c981143(rocket)
{
	target = rocket.aimtarget;
	if(isdefined(target) && isalive(target))
	{
		weapon = getweapon(#"remote_missile");
		settings = getscriptbundle(weapon.var_4dd46f8a);
		target_radius = (isdefined(settings.target_radius) ? settings.target_radius : 600);
		var_5667e212 = target_radius * target_radius;
		fwd = anglestoforward(rocket.angles);
		dir = target.origin - rocket.origin;
		dot = vectordot(dir, fwd);
		proj = rocket.origin + vectorscale(fwd, dot);
		dist2 = distancesquared(target.origin, proj);
		if(dist2 < var_5667e212)
		{
			if(!bullettracepassed(target.origin + vectorscale((0, 0, 1), 60), target.origin + vectorscale((0, 0, 1), 1000), 0, target))
			{
				target = undefined;
			}
		}
		else
		{
			target = undefined;
		}
	}
	else
	{
		target = undefined;
	}
	targets = [];
	if(isdefined(target))
	{
		targets[0] = target;
	}
	else
	{
		rocket missile_settarget(undefined);
		rocket.aimtarget = undefined;
	}
	return targets;
}

/*
	Name: create_missile_hud
	Namespace: remotemissile
	Checksum: 0xE3848B76
	Offset: 0x4318
	Size: 0x2E4
	Parameters: 1
	Flags: None
*/
function create_missile_hud(rocket)
{
	player = self;
	if(!level.remote_missile_targets remote_missile_targets::is_open(self))
	{
		level.remote_missile_targets remote_missile_targets::open(self);
	}
	player.var_bbe80eed = [];
	player.var_ebf52bbc = [];
	player_entnum = player getentitynumber();
	for(ti = 0; ti < 6; ti++)
	{
		player.var_bbe80eed[ti] = spawnstruct();
		player.var_bbe80eed[ti].state = 0;
		var_be788bba = level.var_aac98621[ti];
		if(!var_be788bba remote_missile_target_lockon::is_open(player))
		{
			var_be788bba remote_missile_target_lockon::open(player, 1);
		}
		var_be788bba remote_missile_target_lockon::function_3b7b386a(player, player_entnum);
		var_be788bba remote_missile_target_lockon::function_2ecbc83c(player, 0);
		var_be788bba remote_missile_target_lockon::function_505f092a(player, 0);
	}
	enemies = getplayers();
	ti = 0;
	foreach(enemy in enemies)
	{
		if(isplayer(enemy) && util::function_fbce7263(player.team, enemy.team))
		{
			entnum = enemy getentitynumber();
			player.var_ebf52bbc[entnum] = ti;
			ti++;
			if(ti >= 6)
			{
				break;
			}
		}
	}
	if(isdefined(rocket))
	{
		rocket.iconindexother = 0;
	}
	self thread targeting_hud_think(rocket);
}

/*
	Name: destroy_missile_hud
	Namespace: remotemissile
	Checksum: 0x629A6FC
	Offset: 0x4608
	Size: 0xB6
	Parameters: 0
	Flags: None
*/
function destroy_missile_hud()
{
	if(level.remote_missile_targets remote_missile_targets::is_open(self))
	{
		level.remote_missile_targets remote_missile_targets::close(self);
	}
	for(ti = 0; ti < 6; ti++)
	{
		if(level.var_aac98621[ti] remote_missile_target_lockon::is_open(self))
		{
			level.var_aac98621[ti] remote_missile_target_lockon::close(self);
		}
	}
}

/*
	Name: targeting_hud_think
	Namespace: remotemissile
	Checksum: 0x2FBB4B2
	Offset: 0x46C8
	Size: 0x562
	Parameters: 1
	Flags: None
*/
function targeting_hud_think(rocket)
{
	self endon(#"disconnect", #"remotemissile_done");
	rocket endon(#"death");
	level endon(#"game_ended");
	player = self;
	targets = self getvalidtargets(rocket, 1, 6);
	framessincetargetscan = 0;
	while(true)
	{
		framessincetargetscan++;
		if(framessincetargetscan > 5)
		{
			targets = self getvalidtargets(rocket, 1, 6);
			framessincetargetscan = 0;
		}
		enemies = getplayers();
		foreach(target in enemies)
		{
			if(util::function_fbce7263(player.team, target.team))
			{
				var_4ef4e267 = target getentitynumber();
				ti = player.var_ebf52bbc[var_4ef4e267];
				if(isdefined(ti))
				{
					player.var_bbe80eed[ti].state = 0;
				}
			}
		}
		if(targets.size > 0)
		{
			foreach(target in targets)
			{
				if(!isdefined(target))
				{
					continue;
				}
				if(isplayer(target))
				{
					if(isalive(target))
					{
						var_4ef4e267 = target getentitynumber();
						ti = player.var_ebf52bbc[var_4ef4e267];
						if(isdefined(ti))
						{
							player.var_bbe80eed[ti].state = 1;
						}
					}
					continue;
				}
				if(!isdefined(target.missileiconindex))
				{
					target.missileiconindex = rocket.iconindexother;
					rocket.iconindexother = rocket.iconindexother + 1 % 3;
				}
				index = target.missileiconindex;
				if(index == 0)
				{
					level.remote_missile_targets remote_missile_targets::function_d798388d(self, target getentitynumber());
					continue;
				}
				if(index == 1)
				{
					level.remote_missile_targets remote_missile_targets::function_808f0a7c(self, target getentitynumber());
					continue;
				}
				if(index == 2)
				{
					level.remote_missile_targets remote_missile_targets::function_808f0a7c(self, target getentitynumber());
					continue;
				}
				/#
					assertmsg("");
				#/
			}
		}
		enemies = getplayers();
		foreach(target in enemies)
		{
			if(util::function_fbce7263(player.team, target.team))
			{
				var_4ef4e267 = target getentitynumber();
				ti = player.var_ebf52bbc[var_4ef4e267];
				if(isdefined(ti) && isdefined(player.var_bbe80eed[ti]))
				{
					level.var_aac98621[ti] remote_missile_target_lockon::function_3b7b386a(player, var_4ef4e267);
					level.var_aac98621[ti] remote_missile_target_lockon::function_2ecbc83c(player, player.var_bbe80eed[ti].state);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: missile_deploy_watch
	Namespace: remotemissile
	Checksum: 0x24D7128D
	Offset: 0x4C38
	Size: 0x14A
	Parameters: 1
	Flags: None
*/
function missile_deploy_watch(rocket)
{
	self endon(#"disconnect", #"remotemissile_done");
	rocket endon(#"remotemissile_bomblets_launched", #"death");
	level endon(#"game_ended");
	params = level.killstreakbundle[#"remote_missile"];
	var_dc54c0bd = (isdefined(params.var_538e1d5) ? params.var_538e1d5 : 3000);
	wait(0.25);
	while(self attackbuttonpressed())
	{
		waitframe(1);
	}
	while(true)
	{
		if(self attackbuttonpressed() || rocket.origin[2] < var_dc54c0bd)
		{
			self thread missile_deploy(rocket, 0);
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: missile_deploy
	Namespace: remotemissile
	Checksum: 0xD9FF553C
	Offset: 0x4D90
	Size: 0x380
	Parameters: 2
	Flags: None
*/
function missile_deploy(rocket, hacked)
{
	rocket notify(#"remotemissile_bomblets_launched");
	rocket.bomblets_deployed = 1;
	waitframes = 2;
	targets = self getvalidtargets(rocket, 1, 6);
	var_940444a6 = getweapon(#"remote_missile_bomblet");
	if(targets.size > 0)
	{
		foreach(target in targets)
		{
			self thread fire_bomblet(var_940444a6, rocket, target, waitframes);
			waitframes++;
		}
	}
	if(rocket.origin[2] - self.origin[2] > 4000)
	{
		rocket notify(#"stop_impact_sound");
	}
	if(hacked == 1)
	{
		rocket.originalowner thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
		self notify(#"remotemissile_done");
	}
	rocket hidepart("tag_attach_panel_right", "", 1);
	rocket hidepart("tag_attach_panel_left", "", 1);
	rocket clientfield::set("remote_missile_fired", 2);
	for(i = targets.size; i < 6; i++)
	{
		self thread fire_random_bomblet(rocket, i % 6, waitframes);
		waitframes++;
	}
	playfx(level.missileremotedeployfx, rocket.origin, anglestoforward(rocket.angles));
	self playrumbleonentity("sniper_fire");
	earthquake(0.2, 0.2, rocket.origin, 200);
	if(hacked == 0)
	{
		self thread hud::fade_to_black_for_x_sec(0, 0.15, 0, 0, "white");
	}
	rocket missile_sound_deploy_bomblets();
	self notify(#"bomblets_deployed");
	if(hacked == 1)
	{
		rocket notify(#"death");
	}
}

/*
	Name: bomblet_camera_waiter
	Namespace: remotemissile
	Checksum: 0x45DEBD17
	Offset: 0x5120
	Size: 0xD6
	Parameters: 1
	Flags: None
*/
function bomblet_camera_waiter(rocket)
{
	self endon(#"disconnect", #"remotemissile_done");
	rocket endon(#"death");
	level endon(#"game_ended");
	delay = getdvarfloat(#"scr_rmbomblet_camera_delaytime", 1);
	self waittill(#"bomblet_exploded");
	wait(delay);
	rocket notify(#"death");
	self notify(#"remotemissile_done");
}

/*
	Name: setup_bomblet_map_icon
	Namespace: remotemissile
	Checksum: 0x2CE0B53D
	Offset: 0x5200
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function setup_bomblet_map_icon()
{
	self endon(#"death");
	wait(0.1);
	self clientfield::set("remote_missile_bomblet_fired", 1);
	self clientfield::set("enemyvehicle", 1);
}

/*
	Name: setup_bomblet
	Namespace: remotemissile
	Checksum: 0xAA01B69F
	Offset: 0x5270
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function setup_bomblet(bomb)
{
	bomb.team = self.team;
	bomb setteam(self.team);
	bomb thread setup_bomblet_map_icon();
	bomb.killcament = self;
	bomb thread function_22e29ec5(self);
	bomb thread function_4c8c3b0b(self);
}

/*
	Name: fire_bomblet
	Namespace: remotemissile
	Checksum: 0x1E722615
	Offset: 0x5310
	Size: 0x19C
	Parameters: 4
	Flags: None
*/
function fire_bomblet(weapon, rocket, target, waitframes)
{
	origin = rocket.origin;
	targetorigin = target.origin + vectorscale((0, 0, 1), 50);
	waitframe(waitframes);
	if(isdefined(rocket))
	{
		origin = rocket.origin;
	}
	if(!isdefined(self) || !isdefined(target))
	{
		return;
	}
	bomb = magicbullet(weapon, origin, targetorigin, self, target, vectorscale((0, 0, 1), 30));
	if(isdefined(rocket) && isdefined(bomb))
	{
		if(!isdefined(rocket.bomblets))
		{
			rocket.bomblets = [];
		}
		if(!isdefined(rocket.bomblets))
		{
			rocket.bomblets = [];
		}
		else if(!isarray(rocket.bomblets))
		{
			rocket.bomblets = array(rocket.bomblets);
		}
		rocket.bomblets[rocket.bomblets.size] = bomb;
	}
	setup_bomblet(bomb);
}

/*
	Name: function_4c8c3b0b
	Namespace: remotemissile
	Checksum: 0xA3E901C9
	Offset: 0x54B8
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_4c8c3b0b(player)
{
	self endon(#"hash_29e967c616cdc4c9");
	bomblet = self;
	bomblet waittill(#"death");
	if(!isdefined(bomblet))
	{
		return;
	}
	params = spawnstruct();
	params.position = bomblet.origin;
	params.var_7148a82 = 1;
	player thread callback::callback(#"hash_7e19bff37ddc39e3", params);
}

/*
	Name: fire_random_bomblet
	Namespace: remotemissile
	Checksum: 0x77ADE4BA
	Offset: 0x5580
	Size: 0x1FC
	Parameters: 3
	Flags: None
*/
function fire_random_bomblet(rocket, quadrant, waitframes)
{
	origin = rocket.origin;
	angles = rocket.angles;
	owner = rocket.owner;
	fwd = anglestoforward(rocket.angles);
	aimtarget = rocket.origin + vectorscale(fwd, 3000);
	waitframe(waitframes);
	if(!isdefined(self))
	{
		return;
	}
	angle = randomintrange(10 + 60 * quadrant, 50 + 60 * quadrant);
	radius = randomintrange(200, 1000);
	x = min(radius, 850) * cos(angle);
	y = min(radius, 850) * sin(angle);
	bomb = magicbullet(getweapon(#"remote_missile_bomblet"), origin, aimtarget + (x, y, 0), self);
	setup_bomblet(bomb);
}

/*
	Name: cleanup_bombs
	Namespace: remotemissile
	Checksum: 0xC68D3524
	Offset: 0x5788
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function cleanup_bombs(bomb)
{
	player = self;
	bomb endon(#"death");
	player waittill(#"joined_team", #"joined_spectators", #"disconnect", #"delete");
	if(isdefined(bomb))
	{
		bomb clientfield::set("remote_missile_bomblet_fired", 0);
		bomb delete();
	}
}

/*
	Name: function_22e29ec5
	Namespace: remotemissile
	Checksum: 0x830B84EC
	Offset: 0x5850
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_22e29ec5(player)
{
	player thread cleanup_bombs(self);
	player endon(#"disconnect", #"remotemissile_done", #"death");
	level endon(#"game_ended");
	self waittill(#"death");
	player notify(#"bomblet_exploded");
}

/*
	Name: remotemissile_bda_dialog
	Namespace: remotemissile
	Checksum: 0x61B32CDA
	Offset: 0x58F8
	Size: 0x12E
	Parameters: 0
	Flags: None
*/
function remotemissile_bda_dialog()
{
	self endon(#"disconnect");
	if(!(isdefined(self.var_5c0f88a5) && self.var_5c0f88a5))
	{
		if(isdefined(self.remotemissilebda))
		{
			if(self.remotemissilebda === 1)
			{
				bdadialog = "kill1";
			}
			else if(self.remotemissilebda === 2)
			{
				bdadialog = "kill2";
			}
			else if(self.remotemissilebda === 3)
			{
				bdadialog = "kill3";
			}
			else if(self.remotemissilebda > 3)
			{
				bdadialog = "killMultiple";
			}
		}
		else
		{
			bdadialog = "killNone";
		}
		if(!isdefined(bdadialog))
		{
			return;
		}
		wait(dialog_shared::mpdialog_value("remoteMissileResultDelay", 0));
		if(!isdefined(self))
		{
			return;
		}
		self killstreaks::play_taacom_dialog(bdadialog, "remote_missile", undefined);
		self.remotemissilebda = undefined;
	}
}

