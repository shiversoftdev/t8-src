// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\heatseekingmissile.gsc;
#using scripts\killstreaks\killstreakrules_shared.gsc;
#using scripts\mp_common\teams\teams.gsc;
#using scripts\killstreaks\mp\counteruav.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\killstreaks\killstreak_hacking.gsc;
#using scripts\killstreaks\airsupport.gsc;
#using scripts\killstreaks\killstreaks_shared.gsc;
#using scripts\killstreaks\killstreak_detect.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\tweakables_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\util.gsc;

#namespace uav;

/*
	Name: __init__system__
	Namespace: uav
	Checksum: 0x45FC0B84
	Offset: 0x230
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"uav", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: uav
	Checksum: 0x50A4B7AC
	Offset: 0x280
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(level.teambased)
	{
		foreach(team, _ in level.teams)
		{
			level.activeuavs[team] = 0;
		}
	}
	else
	{
		level.activeuavs = [];
	}
	level.activeplayeruavs = [];
	level.spawneduavs = [];
	if(tweakables::gettweakablevalue("killstreak", "allowradar"))
	{
		killstreaks::register_killstreak("killstreak_uav", &activateuav);
	}
	level thread uavtracker();
	callback::on_connect(&onplayerconnect);
	callback::on_spawned(&onplayerspawned);
	callback::on_joined_team(&onplayerjoinedteam);
	callback::on_finalize_initialization(&function_3675de8b);
	callback::add_callback(#"hash_425352b435722271", &fx_flesh_hit_neck_fatal);
	callback::on_finalize_initialization(&function_1c601b99);
	setmatchflag("radar_allies", 0);
	setmatchflag("radar_axis", 0);
}

/*
	Name: function_1c601b99
	Namespace: uav
	Checksum: 0x3579DD06
	Offset: 0x4A0
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon(#"uav"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: uav
	Checksum: 0xD03FA11B
	Offset: 0x4F8
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(uav, attackingplayer)
{
	uav hackedprefunction(attackingplayer);
	uav.owner = attackingplayer;
	uav killstreaks::configure_team_internal(attackingplayer, 1);
	if(isdefined(level.var_f1edf93f))
	{
		uav notify(#"hacked");
		uav notify(#"cancel_timeout");
		var_eb79e7c3 = int([[level.var_f1edf93f]]() * 1000);
		uav thread killstreaks::waitfortimeout("uav", var_eb79e7c3, &ontimeout, "delete", "death", "crashing");
	}
}

/*
	Name: fx_flesh_hit_neck_fatal
	Namespace: uav
	Checksum: 0x91B11521
	Offset: 0x618
	Size: 0x240
	Parameters: 1
	Flags: Linked
*/
function fx_flesh_hit_neck_fatal(params)
{
	enemycuavactive = 0;
	if(params.attacker hasperk(#"specialty_immunecounteruav") == 0)
	{
		foreach(team, _ in level.teams)
		{
			if(team == params.attacker.team)
			{
				continue;
			}
			if(counteruav::teamhasactivecounteruav(team))
			{
				enemycuavactive = 1;
			}
		}
	}
	if(enemycuavactive == 0)
	{
		foreach(player in params.players)
		{
			if(isdefined(level.activeplayeruavs))
			{
				activeuav = level.activeplayeruavs[player.entnum];
				if(level.forceradar == 1)
				{
					activeuav--;
				}
				if(activeuav > 0)
				{
					scoregiven = scoreevents::processscoreevent(#"uav_assist", player, undefined, undefined);
					if(isdefined(scoregiven))
					{
						player challenges::earneduavassistscore(scoregiven);
						killstreakindex = level.killstreakindices[#"uav"];
						killstreaks::killstreak_assist(player, self, killstreakindex);
					}
				}
			}
		}
	}
}

/*
	Name: function_3675de8b
	Namespace: uav
	Checksum: 0xE951B7DD
	Offset: 0x860
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function function_3675de8b()
{
	initrotatingrig();
}

/*
	Name: initrotatingrig
	Namespace: uav
	Checksum: 0xB4BCD714
	Offset: 0x888
	Size: 0x1E4
	Parameters: 0
	Flags: Linked
*/
function initrotatingrig()
{
	if(isdefined(level.var_c6129172))
	{
		map_center = airsupport::getmapcenter();
		rotator_offset = ((isdefined(level.var_c6129172) ? level.var_c6129172 : map_center[0]), (isdefined(level.var_ae8d87c7) ? level.var_ae8d87c7 : map_center[1]), (isdefined(level.var_eb2556e1) ? level.var_eb2556e1 : 1200));
		level.var_b59e7114 = spawn("script_model", rotator_offset);
	}
	else
	{
		map_center = airsupport::getmapcenter();
		rotator_offset = ((isdefined(level.var_778a1b96) ? level.var_778a1b96 : 0), (isdefined(level.var_621e7f72) ? level.var_621e7f72 : 0), 1200);
		level.var_b59e7114 = spawn("script_model", map_center + rotator_offset);
	}
	level.var_b59e7114 setmodel(#"tag_origin");
	level.var_b59e7114.angles = vectorscale((0, 1, 0), 115);
	level.var_b59e7114 hide();
	level.var_b59e7114 thread rotaterig();
	level.var_b59e7114 thread swayrig();
}

/*
	Name: rotaterig
	Namespace: uav
	Checksum: 0x89E60A3D
	Offset: 0xA78
	Size: 0x2E
	Parameters: 0
	Flags: Linked
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
	Namespace: uav
	Checksum: 0x9968DA68
	Offset: 0xAB0
	Size: 0x10E
	Parameters: 0
	Flags: Linked
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
	Name: hackedprefunction
	Namespace: uav
	Checksum: 0xD6105416
	Offset: 0xBC8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function hackedprefunction(hacker)
{
	uav = self;
	uav resetactiveuav();
}

/*
	Name: configureteampost
	Namespace: uav
	Checksum: 0x53B53304
	Offset: 0xC00
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function configureteampost(owner, ishacked)
{
	uav = self;
	uav thread teams::waituntilteamchangesingleton(owner, "UAV_watch_team_change_" + uav getentitynumber(), &onteamchange, owner.entnum, "delete", "death", "leaving");
	if(ishacked == 0)
	{
		uav teams::hidetosameteam();
	}
	else
	{
		uav setvisibletoall();
	}
	owner addactiveuav();
}

/*
	Name: function_f724cfe4
	Namespace: uav
	Checksum: 0x52B54738
	Offset: 0xCE0
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function function_f724cfe4(health)
{
	waitframe(1);
	self.health = health;
}

/*
	Name: activateuav
	Namespace: uav
	Checksum: 0xA6F0A145
	Offset: 0xD08
	Size: 0x6A8
	Parameters: 0
	Flags: Linked
*/
function activateuav()
{
	/#
		assert(isdefined(level.players));
	#/
	if(self killstreakrules::iskillstreakallowed("uav", self.team) == 0)
	{
		return false;
	}
	killstreak_id = self killstreakrules::killstreakstart("uav", self.team);
	if(killstreak_id == -1)
	{
		return false;
	}
	rotator = level.var_b59e7114;
	attach_angle = -90;
	uav = spawn("script_model", rotator gettagorigin("tag_origin"));
	if(!isdefined(level.spawneduavs))
	{
		level.spawneduavs = [];
	}
	else if(!isarray(level.spawneduavs))
	{
		level.spawneduavs = array(level.spawneduavs);
	}
	level.spawneduavs[level.spawneduavs.size] = uav;
	uav setmodel(level.killstreakbundle[#"uav"].var_c6eab8b5);
	uav.weapon = getweapon("uav");
	uav setweapon(uav.weapon);
	uav.targetname = "uav";
	uav util::function_c596f193();
	uav killstreaks::configure_team("uav", killstreak_id, self, undefined, undefined, &configureteampost);
	uav killstreak_hacking::enable_hacking("uav", &hackedprefunction, undefined);
	uav clientfield::set("enemyvehicle", 1);
	killstreak_detect::killstreaktargetset(uav);
	uav setdrawinfrared(1);
	uav.killstreak_id = killstreak_id;
	uav.leaving = 0;
	uav.victimsoundmod = "vehicle";
	uav thread killstreaks::function_2b6aa9e8("uav", &destroyuav, &onlowhealth);
	uav thread function_f724cfe4(100000);
	uav thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("crashing", undefined, 1);
	uav.rocketdamage = uav.maxhealth + 1;
	minflyheight = int(airsupport::getminimumflyheight());
	zoffset = minflyheight + (isdefined(level.uav_z_offset) ? level.uav_z_offset : 2500);
	angle = randomint(360);
	loc_0000114C:
	radiusoffset = (isdefined(level.uav_rotation_radius) ? level.uav_rotation_radius : 4000) + randomint((isdefined(level.uav_rotation_random_offset) ? level.uav_rotation_random_offset : 1000));
	xoffset = cos(angle) * radiusoffset;
	yoffset = sin(angle) * radiusoffset;
	anglevector = vectornormalize((xoffset, yoffset, zoffset));
	anglevector = anglevector * zoffset;
	anglevector = (anglevector[0], anglevector[1], zoffset - rotator.origin[2]);
	uav linkto(rotator, "tag_origin", anglevector, (0, angle + attach_angle, 0));
	self stats::function_e24eec31(getweapon("uav"), #"used", 1);
	uav thread killstreaks::waitfortimeout("uav", 30000, &ontimeout, "delete", "death", "crashing");
	uav thread killstreaks::waitfortimecheck(30000 / 2, &ontimecheck, "delete", "death", "crashing");
	uav thread startuavfx();
	self killstreaks::play_killstreak_start_dialog("uav", self.team, killstreak_id);
	uav killstreaks::play_pilot_dialog_on_owner("arrive", "uav", killstreak_id);
	uav thread killstreaks::player_killstreak_threat_tracking("uav");
	return true;
}

/*
	Name: onlowhealth
	Namespace: uav
	Checksum: 0x6621EBA0
	Offset: 0x13B8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function onlowhealth(attacker, weapon)
{
	self.is_damaged = 1;
	params = level.killstreakbundle[#"uav"];
	if(isdefined(params.fxlowhealth))
	{
		playfxontag(params.fxlowhealth, self, "tag_origin");
	}
}

/*
	Name: onteamchange
	Namespace: uav
	Checksum: 0xAC347EF6
	Offset: 0x1440
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function onteamchange(entnum, event)
{
	destroyuav(undefined, undefined);
}

/*
	Name: destroyuav
	Namespace: uav
	Checksum: 0xC1C71183
	Offset: 0x1478
	Size: 0x30C
	Parameters: 2
	Flags: Linked
*/
function destroyuav(attacker, weapon)
{
	attacker = self [[level.figure_out_attacker]](attacker);
	if(isdefined(attacker) && (!isdefined(self.owner) || self.owner util::isenemyplayer(attacker)))
	{
		attacker battlechatter::function_dd6a6012("uav", weapon);
		challenges::destroyedaircraft(attacker, weapon, 0, 0);
		luinotifyevent(#"player_callout", 2, #"hash_7f902a0b5852fe90", attacker.entnum);
		attacker challenges::addflyswatterstat(weapon, self);
	}
	if(!self.leaving)
	{
		self removeactiveuav();
		self killstreaks::play_destroyed_dialog_on_owner("uav", self.killstreak_id);
	}
	self notify(#"crashing");
	self playsound(#"exp_veh_large");
	params = level.killstreakbundle[#"uav"];
	if(isdefined(params.ksexplosionfx))
	{
		playfxontag(params.ksexplosionfx, self, "tag_origin");
	}
	if(isdefined(params.var_bb6c29b4) && isdefined(weapon) && weapon == getweapon(#"shock_rifle"))
	{
		playfxontag(params.var_bb6c29b4, self, "tag_origin");
	}
	self stoploopsound();
	self setmodel(#"tag_origin");
	if(target_istarget(self))
	{
		target_remove(self);
	}
	self unlink();
	wait(0.5);
	arrayremovevalue(level.spawneduavs, self);
	if(isdefined(self))
	{
		self notify(#"delete");
		self delete();
	}
}

/*
	Name: onplayerconnect
	Namespace: uav
	Checksum: 0x1390EC5A
	Offset: 0x1790
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function onplayerconnect()
{
	self.entnum = self getentitynumber();
	if(!level.teambased)
	{
		level.activeuavs[self.entnum] = 0;
	}
	level.activeplayeruavs[self.entnum] = 0;
}

/*
	Name: onplayerspawned
	Namespace: uav
	Checksum: 0x48151719
	Offset: 0x17F8
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function onplayerspawned()
{
	self endon(#"disconnect");
	if(level.teambased == 0 || level.multiteam == 1 || level.forceradar == 1)
	{
		level notify(#"uav_update");
	}
}

/*
	Name: onplayerjoinedteam
	Namespace: uav
	Checksum: 0x6367B989
	Offset: 0x1868
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function onplayerjoinedteam(params)
{
	hidealluavstosameteam();
}

/*
	Name: ontimeout
	Namespace: uav
	Checksum: 0xED82E224
	Offset: 0x1890
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function ontimeout()
{
	playafterburnerfx();
	if(isdefined(self.is_damaged) && self.is_damaged)
	{
		playfxontag("killstreaks/fx_uav_damage_trail", self, "tag_body");
	}
	self killstreaks::play_pilot_dialog_on_owner("timeout", "uav");
	self.leaving = 1;
	if(isdefined(level.var_14151f16))
	{
		[[level.var_14151f16]](self, 0);
	}
	self removeactiveuav();
	airsupport::leave(10);
	wait(10);
	if(target_istarget(self))
	{
		target_remove(self);
	}
	arrayremovevalue(level.spawneduavs, self);
	self delete();
}

/*
	Name: ontimecheck
	Namespace: uav
	Checksum: 0x2927B357
	Offset: 0x19D8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function ontimecheck()
{
	self killstreaks::play_pilot_dialog_on_owner("timecheck", "uav", self.killstreak_id);
}

/*
	Name: startuavfx
	Namespace: uav
	Checksum: 0x1DB2BC08
	Offset: 0x1A18
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function startuavfx()
{
	self endon(#"death");
	wait(0.1);
	if(isdefined(self))
	{
		playfxontag("killstreaks/fx_uav_lights", self, "tag_origin");
		self playloopsound(#"veh_uav_engine_loop", 1);
	}
}

/*
	Name: playafterburnerfx
	Namespace: uav
	Checksum: 0xB3FC48DC
	Offset: 0x1A98
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function playafterburnerfx()
{
	self endon(#"death");
	wait(0.1);
	if(isdefined(self))
	{
		self stoploopsound();
		team = util::getotherteam(self.team);
		self playsoundtoteam(#"veh_kls_uav_afterburner", team);
	}
}

/*
	Name: hasuav
	Namespace: uav
	Checksum: 0xCDAB9853
	Offset: 0x1B28
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function hasuav(team_or_entnum)
{
	return level.activeuavs[team_or_entnum] > 0;
}

/*
	Name: addactiveuav
	Namespace: uav
	Checksum: 0xAF806063
	Offset: 0x1B50
	Size: 0xD8
	Parameters: 0
	Flags: Linked
*/
function addactiveuav()
{
	if(level.teambased)
	{
		/#
			assert(isdefined(self.team));
		#/
		level.activeuavs[self.team]++;
	}
	else
	{
		/#
			assert(isdefined(self.entnum));
		#/
		if(!isdefined(self.entnum))
		{
			self.entnum = self getentitynumber();
		}
		level.activeuavs[self.entnum]++;
	}
	level.activeplayeruavs[self.entnum]++;
	level notify(#"uav_update");
}

/*
	Name: removeactiveuav
	Namespace: uav
	Checksum: 0xC70C1985
	Offset: 0x1C30
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function removeactiveuav()
{
	uav = self;
	uav resetactiveuav();
	uav killstreakrules::killstreakstop("uav", self.originalteam, self.killstreak_id);
}

/*
	Name: resetactiveuav
	Namespace: uav
	Checksum: 0x2F4FD763
	Offset: 0x1C90
	Size: 0x200
	Parameters: 0
	Flags: Linked
*/
function resetactiveuav()
{
	if(level.teambased)
	{
		level.activeuavs[self.team]--;
		/#
			assert(level.activeuavs[self.team] >= 0);
		#/
		if(level.activeuavs[self.team] < 0)
		{
			level.activeuavs[self.team] = 0;
		}
	}
	else if(isdefined(self.owner))
	{
		/#
			assert(isdefined(self.owner.entnum));
		#/
		if(!isdefined(self.owner.entnum))
		{
			self.owner.entnum = self.owner getentitynumber();
		}
		level.activeuavs[self.owner.entnum]--;
		/#
			assert(level.activeuavs[self.owner.entnum] >= 0);
		#/
		if(level.activeuavs[self.owner.entnum] < 0)
		{
			level.activeuavs[self.owner.entnum] = 0;
		}
	}
	if(isdefined(self.owner))
	{
		level.activeplayeruavs[self.owner.entnum]--;
		/#
			assert(level.activeplayeruavs[self.owner.entnum] >= 0);
		#/
	}
	level notify(#"uav_update");
}

/*
	Name: uavtracker
	Namespace: uav
	Checksum: 0x6539BBD4
	Offset: 0x1E98
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function uavtracker()
{
	level endon(#"game_ended");
	while(true)
	{
		level waittill(#"uav_update");
		if(level.teambased)
		{
			foreach(team, _ in level.teams)
			{
				activeuavs = level.activeuavs[team];
				activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[team] : 0);
				setteamspyplane(team, int(min(activeuavs, 2)));
				util::set_team_radar(team, activeuavsandsatellites > 0);
			}
		}
		else
		{
			for(i = 0; i < level.players.size; i++)
			{
				player = level.players[i];
				/#
					assert(isdefined(player.entnum));
				#/
				if(!isdefined(player.entnum))
				{
					player.entnum = player getentitynumber();
				}
				activeuavs = level.activeuavs[player.entnum];
				activeuavsandsatellites = activeuavs + (isdefined(level.activesatellites) ? level.activesatellites[player.entnum] : 0);
				player setclientuivisibilityflag("radar_client", activeuavsandsatellites > 0);
				player.hasspyplane = int(min(activeuavs, 2));
			}
		}
	}
}

/*
	Name: hidealluavstosameteam
	Namespace: uav
	Checksum: 0x8EAC1635
	Offset: 0x2150
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function hidealluavstosameteam()
{
	foreach(uav in level.spawneduavs)
	{
		if(isdefined(uav))
		{
			uav teams::hidetosameteam();
		}
	}
}

