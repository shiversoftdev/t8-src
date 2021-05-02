// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_3728b3b9606c4299;
#using script_3819e7a1427df6d2;
#using script_383a3b1bb18ba876;
#using script_47fb62300ac0bd60;
#using script_57c900a7e39234be;
#using script_57f7003580bb15e0;
#using script_6c8abe14025b47c4;
#using script_751513c609504a42;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\killcam_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\gametypes\battlechatter.gsc;
#using scripts\mp_common\util.gsc;

#namespace straferun;

/*
	Name: function_89f2df9
	Namespace: straferun
	Checksum: 0xC5E8B3E0
	Offset: 0x440
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"straferun", &__init__, undefined, #"killstreaks");
}

/*
	Name: __init__
	Namespace: straferun
	Checksum: 0xB6EB0548
	Offset: 0x490
	Size: 0x314
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.straferunnumrockets = 8;
	level.straferunrocketdelay = 0.35;
	level.straferungunlookahead = 4000;
	level.straferungunoffset = -800;
	level.straferungunradius = 500;
	level.straferunexitunits = 20000;
	level.straferunmaxstrafes = 6;
	level.straferunflaredelay = 2;
	level.straferunshellshockduration = 2.5;
	level.straferunshellshockradius = 512;
	level.straferunkillsbeforeexit = 10;
	level.straferunnumkillcams = 5;
	level.straferunmodel = "veh_t6_air_a10f";
	level.straferunmodelenemy = "veh_t6_air_a10f_alt";
	level.straferunvehicle = "vehicle_straferun_mp";
	level.straferungunweapon = getweapon(#"straferun_gun");
	level.straferungunsound = "wpn_a10_shot_loop_npc";
	level.straferunrocketweapon = getweapon(#"straferun_rockets");
	level.straferunrockettags = [];
	level.straferunrockettags[0] = "tag_attach_hardpoint_1";
	level.straferunrockettags[1] = "tag_attach_hardpoint_9";
	level.straferunrockettags[2] = "tag_attach_hardpoint_2";
	level.straferunrockettags[3] = "tag_attach_hardpoint_8";
	level.straferuncontrailfx = "_t7/killstreaks/fx_wh_contrail";
	level.straferunchafffx = "killstreaks/fx_wh_chaff_trail";
	level.straferunexplodefx = "destruct/fx8_atk_chppr_exp";
	level.straferunexplodesound = "evt_helicopter_midair_exp";
	level.straferunshellshock = "straferun";
	killstreaks::function_e4ef8390("killstreak_straferun", &usekillstreakstraferun);
	killstreaks::register_alt_weapon("straferun", level.straferungunweapon);
	killstreaks::register_alt_weapon("straferun", level.straferunrocketweapon);
	createkillcams(level.straferunnumkillcams, level.straferunnumrockets);
	callback::on_finalize_initialization(&function_3675de8b);
	killcam::function_2f7579f(#"straferun_gun");
}

/*
	Name: function_3675de8b
	Namespace: straferun
	Checksum: 0x2C208604
	Offset: 0x7B0
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_3675de8b()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](getweapon("straferun"), &function_bff5c062);
	}
}

/*
	Name: function_bff5c062
	Namespace: straferun
	Checksum: 0x30033B0
	Offset: 0x800
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_bff5c062(var_c4b91241, var_dbd1a594)
{
	var_c4b91241 killstreaks::function_73566ec7(var_dbd1a594, getweapon(#"gadget_icepick"), var_c4b91241.owner);
	var_c4b91241 thread explode();
}

/*
	Name: usekillstreakstraferun
	Namespace: straferun
	Checksum: 0x4349AD1D
	Offset: 0x878
	Size: 0x6E0
	Parameters: 1
	Flags: Linked
*/
function usekillstreakstraferun(hardpointtype)
{
	startnode = getvehiclenode("warthog_start", "targetname");
	if(!isdefined(startnode))
	{
		/#
			println("");
		#/
		return 0;
	}
	killstreak_id = self killstreakrules::killstreakstart("straferun", self.team, 0, 1);
	if(killstreak_id == -1)
	{
		return 0;
	}
	plane = spawnvehicle(level.straferunvehicle, startnode.origin, (0, 0, 0), "straferun");
	plane.attackers = [];
	plane.attackerdata = [];
	plane.attackerdamage = [];
	plane.flareattackerdamage = [];
	plane killstreaks::configure_team("straferun", killstreak_id, self);
	plane setenemymodel(level.straferunmodelenemy);
	plane makevehicleunusable();
	plane thread cleanupondeath(plane.team);
	plane.health = 999999;
	plane.maxhealth = 999999;
	plane clientfield::set("enemyvehicle", 1);
	plane.targetname = "strafePlane";
	plane.var_817f15dd = getweapon("straferun");
	plane.numstrafes = 0;
	plane.numflares = 1;
	plane.soundmod = "straferun";
	plane setdrawinfrared(1);
	self.straferunkills = 0;
	self.straferunbda = 0;
	self killstreaks::play_killstreak_start_dialog("straferun", self.pers[#"team"], killstreak_id);
	self stats::function_e24eec31(getweapon(#"straferun"), #"used", 1);
	plane thread function_d4896942();
	target_set(plane, (0, 0, 0));
	plane.gunsoundentity = spawn("script_model", plane gettagorigin("tag_flash"));
	plane.gunsoundentity linkto(plane, "tag_flash", (0, 0, 0), (0, 0, 0));
	if(!issentient(plane))
	{
		plane util::function_c596f193();
		plane.ignoreme = 1;
	}
	plane.killcament = spawn("script_model", plane.origin + vectorscale((0, 0, 1), 700));
	plane.killcament setfovforkillcam(25);
	plane.killcament.angles = vectorscale((1, 0, 0), 15);
	plane.killcament.starttime = gettime();
	offset_x = getdvarint(#"hash_6354a081bacd5b72", -2500);
	offset_y = getdvarint(#"hash_6354a181bacd5d25", 0);
	offset_z = getdvarint(#"hash_63549e81bacd580c", -150);
	var_3a08eecc = getdvarint(#"hash_53fdb5b01cf6f7dc", 2);
	plane.killcament linkto(plane, "tag_origin", (offset_x, offset_y, offset_z), (var_3a08eecc, 0, 0));
	plane.killcament setweapon(level.straferungunweapon);
	plane resetkillcams();
	plane thread watchforotherkillstreaks();
	plane thread watchforkills();
	plane thread watchdamage();
	plane thread dostraferuns();
	plane thread vehicle::get_on_and_go_path(startnode);
	plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile("death");
	plane thread watchforownerexit(self);
	plane thread namespace_14c38db0::function_7e1a12ce(12000);
	plane thread function_c24cc26a();
	util::function_5a68c330(21, self.team, self getentitynumber(), level.killstreaks[#"straferun"].uiname);
	aiutility::addaioverridedamagecallback(plane, &function_16abaea4);
	return 1;
}

/*
	Name: function_16abaea4
	Namespace: straferun
	Checksum: 0x5E114A44
	Offset: 0xF60
	Size: 0x102
	Parameters: 15
	Flags: Linked
*/
function function_16abaea4(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	chargelevel = 0;
	weapon_damage = killstreak_bundles::get_weapon_damage("straferun", self.maxhealth, attacker, weapon, meansofdeath, damage, idflags, chargelevel);
	if(!isdefined(weapon_damage))
	{
		weapon_damage = killstreaks::get_old_damage(attacker, weapon, meansofdeath, damage, 1);
	}
	return weapon_damage;
}

/*
	Name: function_c24cc26a
	Namespace: straferun
	Checksum: 0xE5B8C3A1
	Offset: 0x1070
	Size: 0x326
	Parameters: 0
	Flags: Linked
*/
function function_c24cc26a()
{
	self endon(#"death");
	level endon(#"game_ended");
	if(isdefined(level.var_ac6052e9))
	{
		var_2974acb8 = [[level.var_ac6052e9]]("taacomPilotWarnDistanceWarthog", 5000);
	}
	else
	{
		var_2974acb8 = 1;
	}
	var_13d70215 = var_2974acb8 * var_2974acb8;
	while(true)
	{
		wait(0.1);
		if(!isdefined(self))
		{
			return;
		}
		if(!isdefined(self.currentnode))
		{
			continue;
		}
		if((isdefined(self.var_90110858) ? self.var_90110858 : 0))
		{
			continue;
		}
		var_19d3cc8e = 0;
		currentnode = getvehiclenode(self.currentnode.target, "targetname");
		if(!isdefined(currentnode))
		{
			return;
		}
		var_661ad37a = distancesquared(currentnode.origin, self.origin);
		var_4c8f226e = 0;
		while(true)
		{
			if(!isdefined(currentnode.target))
			{
				continue;
			}
			if(var_661ad37a > var_13d70215)
			{
				var_4c8f226e = 1;
				break;
			}
			nextnode = getvehiclenode(currentnode.target, "targetname");
			if(!isdefined(nextnode))
			{
				continue;
			}
			if(isdefined(nextnode.script_noteworthy) && nextnode.script_noteworthy == "strafe_start")
			{
				break;
			}
			var_50eb39dc = distancesquared(currentnode.origin, nextnode.origin);
			var_661ad37a = var_661ad37a + var_50eb39dc;
			currentnode = nextnode;
		}
		if(var_4c8f226e)
		{
			continue;
		}
		if(!(isdefined(self.leavenexttime) && self.leavenexttime))
		{
			if(self.numstrafes == 0)
			{
				self killstreaks::play_pilot_dialog_on_owner("arrive", "straferun", self.killstreak_id);
			}
			else if(self.numstrafes == level.straferunmaxstrafes - 1)
			{
				self killstreaks::play_pilot_dialog_on_owner("waveStartFinal", "straferun", self.killstreakid);
			}
			else
			{
				self killstreaks::play_pilot_dialog_on_owner("waveStart", "straferun", self.killstreakid);
			}
		}
		self.var_90110858 = 1;
	}
}

/*
	Name: playcontrail
	Namespace: straferun
	Checksum: 0x257C3E8A
	Offset: 0x13A0
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function playcontrail()
{
	self endon(#"death");
	wait(0.1);
	playfxontag(level.straferuncontrailfx, self, "tag_origin");
	self playloopsound(#"veh_a10_engine_loop", 1);
}

/*
	Name: cleanupondeath
	Namespace: straferun
	Checksum: 0xB5BBD72D
	Offset: 0x1418
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function cleanupondeath(team)
{
	self waittill(#"death");
	killstreakrules::killstreakstop("straferun", team, self.killstreakid);
	if(isdefined(self.gunsoundentity))
	{
		self.gunsoundentity stoploopsound();
		self.gunsoundentity delete();
		self.gunsoundentity = undefined;
	}
}

/*
	Name: watchdamage
	Namespace: straferun
	Checksum: 0xE802BDD7
	Offset: 0x14B0
	Size: 0x2E2
	Parameters: 0
	Flags: Linked
*/
function watchdamage()
{
	self endon(#"death");
	self.maxhealth = 999999;
	self.health = self.maxhealth;
	self.maxhealth = 5400;
	low_health = 0;
	damage_taken = 0;
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		attacker = waitresult.attacker;
		mod = waitresult.mod;
		damage = waitresult.amount;
		weapon = waitresult.weapon;
		if(!isdefined(attacker) || !isplayer(attacker))
		{
			continue;
		}
		/#
			self.damage_debug = damage + "" + weapon.name + "";
		#/
		if(!isdefined(weapon) || weapons::getbaseweapon(weapon) != level.var_9e188c0b)
		{
			if(mod == "MOD_PROJECTILE" || mod == "MOD_PROJECTILE_SPLASH" || mod == "MOD_EXPLOSIVE")
			{
				damage = damage + 5400;
			}
		}
		if(!issentient(self) && damage > 0)
		{
			self.attacker = attacker;
		}
		damage_taken = damage_taken + damage;
		if(damage_taken >= 5400)
		{
			self thread explode();
			if(self.owner util::isenemyplayer(attacker))
			{
				attacker battlechatter::function_dd6a6012("straferun", weapon);
				self killstreaks::play_destroyed_dialog_on_owner("straferun", self.killstreak_id);
				self killstreaks::function_73566ec7(attacker, weapon, self.owner);
				challenges::destroyedaircraft(attacker, weapon, 0, 1);
				attacker challenges::addflyswatterstat(weapon, self);
			}
			return;
		}
	}
}

/*
	Name: watchforotherkillstreaks
	Namespace: straferun
	Checksum: 0x903C8B61
	Offset: 0x17A0
	Size: 0x156
	Parameters: 0
	Flags: Linked
*/
function watchforotherkillstreaks()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = level waittill(#"killstreak_started");
		hardpointtype = waitresult.hardpoint_type;
		teamname = waitresult.team;
		attacker = waitresult.attacker;
		if(!isdefined(self.owner))
		{
			self thread explode();
			return;
		}
		if(hardpointtype == "emp")
		{
			if(self.owner util::isenemyplayer(attacker))
			{
				self thread explode();
				attacker challenges::addflyswatterstat(hardpointtype, self);
				return;
			}
			continue;
		}
		if(hardpointtype == "missile_swarm")
		{
			if(self.owner util::isenemyplayer(attacker))
			{
				self.leavenexttime = 1;
			}
		}
	}
}

/*
	Name: watchforkills
	Namespace: straferun
	Checksum: 0xAFCA5EEB
	Offset: 0x1900
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function watchforkills()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"killed");
		if(isplayer(waitresult.victim))
		{
			continue;
		}
	}
}

/*
	Name: watchforownerexit
	Namespace: straferun
	Checksum: 0x87490D5B
	Offset: 0x1968
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function watchforownerexit(owner)
{
	self endon(#"death");
	owner waittill(#"disconnect", #"joined_team", #"joined_spectators");
	self.leavenexttime = 1;
}

/*
	Name: addstraferunkill
	Namespace: straferun
	Checksum: 0x684B8986
	Offset: 0x19D8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function addstraferunkill()
{
	if(!isdefined(self.straferunkills))
	{
		self.straferunkills = 0;
	}
	self.straferunkills++;
}

/*
	Name: dostraferuns
	Namespace: straferun
	Checksum: 0x22863223
	Offset: 0x1A08
	Size: 0x2C0
	Parameters: 0
	Flags: Linked
*/
function dostraferuns()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"noteworthy");
		noteworthy = waitresult.noteworthy;
		noteworthynode = waitresult.noteworthy_node;
		if(noteworthy == "strafe_start")
		{
			self.straferungunlookahead = level.straferungunlookahead;
			self.straferungunradius = level.straferungunradius;
			self.straferungunoffset = level.straferungunoffset;
			self.var_90110858 = 0;
			/#
				self.straferungunlookahead = getdvarint(#"scr_straferunlookahead", level.straferungunlookahead);
				self.straferungunradius = getdvarint(#"scr_straferunradius", level.straferungunradius);
				self.straferungunoffset = getdvarint(#"scr_straferunoffset", level.straferungunoffset);
			#/
			if(isdefined(noteworthynode))
			{
				if(isdefined(noteworthynode.script_parameters))
				{
					self.straferungunlookahead = float(noteworthynode.script_parameters);
				}
				if(isdefined(noteworthynode.script_radius))
				{
					self.straferungunradius = float(noteworthynode.script_radius);
				}
				if(isdefined(noteworthynode.script_float))
				{
					self.straferungunoffset = float(noteworthynode.script_float);
				}
			}
			if(isdefined(self.owner))
			{
				self thread startstrafe();
			}
			continue;
		}
		if(noteworthy == "strafe_stop")
		{
			self stopstrafe();
			continue;
		}
		if(noteworthy == "strafe_leave")
		{
			if(self shouldleavemap())
			{
				if(!(isdefined(self.leavenexttime) && self.leavenexttime))
				{
					self killstreaks::play_taacom_dialog_response_on_owner("timeoutConfirmed", "straferun", self.killstreakid);
				}
				self thread leavemap();
			}
		}
	}
}

/*
	Name: function_d4896942
	Namespace: straferun
	Checksum: 0xA107572E
	Offset: 0x1CD0
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_d4896942()
{
	self endon(#"death", #"strafe_stop");
	while(true)
	{
		self waittill(#"hash_63404ad70a51f8ca");
		if(!(isdefined(self.leavenexttime) && self.leavenexttime))
		{
			self killstreaks::play_pilot_dialog_on_owner("damageEvaded", "straferun", self.killstreakid);
		}
	}
}

/*
	Name: startstrafe
	Namespace: straferun
	Checksum: 0xACF10232
	Offset: 0x1D68
	Size: 0x38C
	Parameters: 0
	Flags: Linked
*/
function startstrafe()
{
	self endon(#"death", #"strafe_stop");
	if(isdefined(self.strafing))
	{
		iprintlnbold("TRYING TO STRAFE WHEN ALREADY STRAFING!\n");
		return;
	}
	self.strafing = 1;
	self thread firerockets();
	count = 0;
	weaponshoottime = level.straferungunweapon.firetime;
	for(;;)
	{
		gunorigin = self gettagorigin("tag_flash");
		gunorigin = gunorigin + (0, 0, self.straferungunoffset);
		forward = anglestoforward(self.angles);
		forwardnoz = vectornormalize((forward[0], forward[1], 0));
		right = vectorcross(forwardnoz, (0, 0, 1));
		perfectattackstartvector = gunorigin + vectorscale(forwardnoz, self.straferungunlookahead);
		attackstartvector = perfectattackstartvector + vectorscale(right, randomfloatrange(0 - self.straferungunradius, self.straferungunradius));
		trace = bullettrace(attackstartvector, (attackstartvector[0], attackstartvector[1], -500), 0, self, 0);
		self turretsettarget(0, trace[#"position"]);
		self fireweapon();
		self shellshockplayers(trace[#"position"]);
		/#
			if(getdvarint(#"scr_devstraferunbulletsdebugdraw", 0))
			{
				time = 300;
				airsupport::debug_line(attackstartvector, trace[#"position"] - vectorscale((0, 0, 1), 20), (1, 0, 0), time, 0);
				if(count % 30 == 0)
				{
					trace = bullettrace(perfectattackstartvector, (perfectattackstartvector[0], perfectattackstartvector[1], 100000), 0, self, 0, 1);
					airsupport::debug_line(trace[#"position"] + vectorscale((0, 0, 1), 20), trace[#"position"] - vectorscale((0, 0, 1), 20), (0, 0, 1), time, 0);
				}
			}
		#/
		count++;
		wait(weaponshoottime);
	}
}

/*
	Name: firststrafe
	Namespace: straferun
	Checksum: 0x80F724D1
	Offset: 0x2100
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function firststrafe()
{
}

/*
	Name: firerockets
	Namespace: straferun
	Checksum: 0xDA15B011
	Offset: 0x2110
	Size: 0x3A2
	Parameters: 0
	Flags: Linked
*/
function firerockets()
{
	self notify(#"firing_rockets");
	self endon(#"death", #"strafe_stop", #"firing_rockets");
	self.owner endon(#"disconnect");
	forward = anglestoforward(self.angles);
	self.firedrockettargets = [];
	for(rocketindex = 0; rocketindex < level.straferunnumrockets; rocketindex++)
	{
		rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
		targets = getvalidtargets();
		rocketorigin = self gettagorigin(rockettag);
		targetorigin = rocketorigin + forward * 10000;
		if(targets.size > 0)
		{
			selectedtarget = undefined;
			foreach(target in targets)
			{
				alreadyattacked = 0;
				foreach(oldtarget in self.firedrockettargets)
				{
					if(oldtarget == target)
					{
						alreadyattacked = 1;
						break;
					}
				}
				if(!alreadyattacked)
				{
					selectedtarget = target;
					break;
				}
			}
			if(isdefined(selectedtarget))
			{
				self.firedrockettargets[self.firedrockettargets.size] = selectedtarget;
				targetorigin = deadrecontargetorigin(rocketorigin, selectedtarget);
			}
		}
		rocketorigin = self gettagorigin(rockettag);
		rocket = magicbullet(level.straferunrocketweapon, rocketorigin, rocketorigin + forward, self);
		if(isdefined(selectedtarget))
		{
			rocket missile_settarget(selectedtarget, (0, 0, 0));
		}
		rocket.soundmod = "straferun";
		rocket attachkillcamtorocket(level.straferunkillcams.rockets[rocketindex], selectedtarget, targetorigin);
		/#
			if(getdvarint(#"scr_devstraferunkillcamsdebugdraw", 0))
			{
				rocket thread airsupport::debug_draw_bomb_path(undefined, vectorscale((0, 1, 0), 0.5), 400);
			}
		#/
		wait(level.straferunrocketdelay);
	}
}

/*
	Name: stopstrafe
	Namespace: straferun
	Checksum: 0xDE970AD9
	Offset: 0x24C0
	Size: 0x1C8
	Parameters: 0
	Flags: Linked
*/
function stopstrafe()
{
	self notify(#"strafe_stop");
	self.strafing = undefined;
	self thread resetkillcams(3);
	self turretcleartarget(0);
	owner = self.owner;
	if(!isdefined(owner))
	{
		return;
	}
	if(owner.straferunbda == 0)
	{
		bdadialog = "killNone";
	}
	else if(owner.straferunbda == 1)
	{
		bdadialog = "kill1";
	}
	else if(owner.straferunbda == 2)
	{
		bdadialog = "kill2";
	}
	else if(owner.straferunbda == 3)
	{
		bdadialog = "kill3";
	}
	else if(owner.straferunbda > 3)
	{
		bdadialog = "killMultiple";
	}
	if(isdefined(bdadialog) && (!(isdefined(self.leavenexttime) && self.leavenexttime)))
	{
		self killstreaks::play_pilot_dialog_on_owner(bdadialog, "straferun", self.killstreakid);
	}
	owner.straferunbda = 0;
	self.gunsoundentity stoploopsound();
	self.gunsoundentity playsound(#"wpn_a10_shot_decay_npc");
	self.numstrafes++;
}

/*
	Name: shouldleavemap
	Namespace: straferun
	Checksum: 0xFF608A
	Offset: 0x2690
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function shouldleavemap()
{
	if(isdefined(self.leavenexttime) && self.leavenexttime)
	{
		return 1;
	}
	if(self.numstrafes >= level.straferunmaxstrafes)
	{
		return 1;
	}
	if(self.owner.straferunkills >= level.straferunkillsbeforeexit)
	{
		return 1;
	}
	return 0;
}

/*
	Name: leavemap
	Namespace: straferun
	Checksum: 0xB38751E6
	Offset: 0x2700
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function leavemap()
{
	self unlinkkillcams();
	exitorigin = self.origin + vectorscale(anglestoforward(self.angles), level.straferunexitunits);
	self setyawspeed(5, 999, 999);
	self setgoal(exitorigin, 1);
	if(isdefined(self.killcament))
	{
		self.killcament unlink();
	}
	wait(5);
	if(isdefined(self))
	{
		if(isdefined(self.killcament))
		{
			self.killcament delete();
			self.killcament = undefined;
		}
		self delete();
	}
}

/*
	Name: explode
	Namespace: straferun
	Checksum: 0x5ECE48C
	Offset: 0x2820
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function explode()
{
	self endon(#"delete");
	forward = self.origin + vectorscale((0, 0, 1), 100) - self.origin;
	playfx(level.straferunexplodefx, self.origin, forward);
	self playsound(level.straferunexplodesound);
	if(isdefined(self.killcament))
	{
		self.killcament unlink();
	}
	wait(0.1);
	if(isdefined(self))
	{
		if(isdefined(self.killcament))
		{
			self.killcament delete();
			self.killcament = undefined;
		}
		self delete();
	}
}

/*
	Name: cantargetentity
	Namespace: straferun
	Checksum: 0x46787E13
	Offset: 0x2930
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function cantargetentity(entity)
{
	heli_centroid = self.origin + vectorscale((0, 0, -1), 160);
	heli_forward_norm = anglestoforward(self.angles);
	heli_turret_point = heli_centroid + 144 * heli_forward_norm;
	visible_amount = entity sightconetrace(heli_turret_point, self);
	if(visible_amount < level.heli_target_recognition)
	{
		return 0;
	}
	return 1;
}

/*
	Name: cantargetplayer
	Namespace: straferun
	Checksum: 0xE9767664
	Offset: 0x29E0
	Size: 0x202
	Parameters: 1
	Flags: Linked
*/
function cantargetplayer(player)
{
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(player == self.owner)
	{
		return 0;
	}
	if(player airsupport::cantargetplayerwithspecialty() == 0)
	{
		return 0;
	}
	if(!isdefined(player.team))
	{
		return 0;
	}
	if(level.teambased && player.team == self.team)
	{
		return 0;
	}
	if(player.team == #"spectator")
	{
		return 0;
	}
	if(isdefined(player.spawntime) && float(gettime() - player.spawntime) / 1000 <= level.heli_target_spawnprotection)
	{
		return 0;
	}
	if(!targetinfrontofplane(player))
	{
		return 0;
	}
	if(player isinmovemode("noclip"))
	{
		return 0;
	}
	var_2910def0 = self namespace_14c38db0::function_1c169b3a(player);
	self namespace_14c38db0::function_a4d6d6d8(player, int((isdefined(level.straferunrocketdelay) ? level.straferunrocketdelay : 0.35) * 1000));
	if(!var_2910def0)
	{
		return 0;
	}
	return cantargetentity(player);
}

/*
	Name: cantargetactor
	Namespace: straferun
	Checksum: 0xBFF68864
	Offset: 0x2BF0
	Size: 0x8A
	Parameters: 1
	Flags: Linked
*/
function cantargetactor(actor)
{
	if(!isdefined(actor))
	{
		return 0;
	}
	if(actor.team == self.team)
	{
		return 0;
	}
	if(isdefined(actor.script_owner) && self.owner == actor.script_owner)
	{
		return 0;
	}
	if(!targetinfrontofplane(actor))
	{
		return 0;
	}
	return cantargetentity(actor);
}

/*
	Name: targetinfrontofplane
	Namespace: straferun
	Checksum: 0x2F8C821A
	Offset: 0x2C88
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function targetinfrontofplane(target)
{
	forward_dir = anglestoforward(self.angles);
	target_delta = vectornormalize(target.origin - self.origin);
	dot = vectordot(forward_dir, target_delta);
	if(dot < 0.5)
	{
		return 1;
	}
	return 1;
}

/*
	Name: getvalidtargets
	Namespace: straferun
	Checksum: 0x90F696B1
	Offset: 0x2D28
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function getvalidtargets()
{
	targets = [];
	foreach(player in level.players)
	{
		if(self cantargetplayer(player))
		{
			if(isdefined(player))
			{
				targets[targets.size] = player;
			}
		}
	}
	tanks = getentarray("talon", "targetname");
	foreach(tank in tanks)
	{
		if(self cantargetactor(tank))
		{
			targets[targets.size] = tank;
		}
	}
	return targets;
}

/*
	Name: deadrecontargetorigin
	Namespace: straferun
	Checksum: 0xFBB483FD
	Offset: 0x2E88
	Size: 0xB2
	Parameters: 2
	Flags: Linked
*/
function deadrecontargetorigin(rocket_start, target)
{
	target_velocity = target getvelocity();
	missile_speed = 7000;
	target_delta = target.origin - rocket_start;
	target_dist = length(target_delta);
	time_to_target = target_dist / missile_speed;
	return target.origin + target_velocity * time_to_target;
}

/*
	Name: shellshockplayers
	Namespace: straferun
	Checksum: 0x96D6367E
	Offset: 0x2F48
	Size: 0x138
	Parameters: 1
	Flags: Linked
*/
function shellshockplayers(origin)
{
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(player == self.owner)
		{
			continue;
		}
		if(!isdefined(player.team))
		{
			continue;
		}
		if(level.teambased && player.team == self.team)
		{
			continue;
		}
		if(distancesquared(player.origin, origin) <= level.straferunshellshockradius * level.straferunshellshockradius)
		{
			player thread straferunshellshock(self);
		}
	}
}

/*
	Name: straferunshellshock
	Namespace: straferun
	Checksum: 0xA69C615C
	Offset: 0x3088
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function straferunshellshock(straferun)
{
	self endon(#"disconnect");
	if(isdefined(self.beingstraferunshellshocked) && self.beingstraferunshellshocked)
	{
		return;
	}
	self.beingstraferunshellshocked = 1;
	params = function_4d1e7b48("deaf_straferun");
	self status_effect::status_effect_apply(params, level.straferunrocketweapon, straferun.owner, 0, int(level.straferunshellshockduration * 1000));
	wait(level.straferunshellshockduration + 1);
	self.beingstraferunshellshocked = 0;
}

/*
	Name: createkillcams
	Namespace: straferun
	Checksum: 0x47B57D18
	Offset: 0x3168
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function createkillcams(numkillcams, numrockets)
{
	if(!isdefined(level.straferunkillcams))
	{
		level.straferunkillcams = spawnstruct();
		level.straferunkillcams.rockets = [];
		for(i = 0; i < numrockets; i++)
		{
			level.straferunkillcams.rockets[level.straferunkillcams.rockets.size] = createkillcament();
		}
	}
}

/*
	Name: resetkillcams
	Namespace: straferun
	Checksum: 0xC42CA020
	Offset: 0x3220
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function resetkillcams(time)
{
	self endon(#"death");
	if(isdefined(time))
	{
		wait(time);
	}
	for(i = 0; i < level.straferunkillcams.rockets.size; i++)
	{
		level.straferunkillcams.rockets[i] resetrocketkillcament(self, i);
	}
}

/*
	Name: unlinkkillcams
	Namespace: straferun
	Checksum: 0xF6F4B8D7
	Offset: 0x32B8
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function unlinkkillcams()
{
	for(i = 0; i < level.straferunkillcams.rockets.size; i++)
	{
		level.straferunkillcams.rockets[i] unlink();
	}
}

/*
	Name: createkillcament
	Namespace: straferun
	Checksum: 0x4E8DA510
	Offset: 0x3320
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function createkillcament()
{
	killcament = spawn("script_model", (0, 0, 0));
	killcament setfovforkillcam(25);
	return killcament;
}

/*
	Name: resetkillcament
	Namespace: straferun
	Checksum: 0xE1F3EAC4
	Offset: 0x3378
	Size: 0x114
	Parameters: 1
	Flags: None
*/
function resetkillcament(parent)
{
	self notify(#"reset");
	parent endon(#"death");
	offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
	offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
	offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
	self linkto(parent, "tag_origin", (offset_x, offset_y, offset_z), vectorscale((1, 0, 0), 10));
	self thread unlinkwhenparentdies(parent);
}

/*
	Name: resetrocketkillcament
	Namespace: straferun
	Checksum: 0x9EB81F10
	Offset: 0x3498
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function resetrocketkillcament(parent, rocketindex)
{
	self notify(#"reset");
	parent endon(#"death");
	offset_x = getdvarint(#"scr_killcamplaneoffsetx", -3000);
	offset_y = getdvarint(#"scr_killcamplaneoffsety", 0);
	offset_z = getdvarint(#"scr_killcamplaneoffsetz", 740);
	rockettag = level.straferunrockettags[rocketindex % level.straferunrockettags.size];
	self linkto(parent, rockettag, (offset_x, offset_y, offset_z), vectorscale((1, 0, 0), 10));
	self thread unlinkwhenparentdies(parent);
}

/*
	Name: deletewhenparentdies
	Namespace: straferun
	Checksum: 0x4CD5AACE
	Offset: 0x35E0
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function deletewhenparentdies(parent)
{
	parent waittill(#"death");
	self delete();
}

/*
	Name: unlinkwhenparentdies
	Namespace: straferun
	Checksum: 0x6CDDE1FB
	Offset: 0x3628
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function unlinkwhenparentdies(parent)
{
	self endon(#"reset", #"unlink");
	parent waittill(#"death");
	self unlink();
}

/*
	Name: attachkillcamtorocket
	Namespace: straferun
	Checksum: 0x55408940
	Offset: 0x3690
	Size: 0x1C4
	Parameters: 3
	Flags: Linked
*/
function attachkillcamtorocket(killcament, selectedtarget, targetorigin)
{
	offset_x = getdvarint(#"scr_killcamrocketoffsetx", -400);
	offset_y = getdvarint(#"scr_killcamrocketoffsety", 0);
	offset_z = getdvarint(#"scr_killcamrocketoffsetz", 110);
	self.killcament = killcament;
	forward = vectorscale(anglestoforward(self.angles), offset_x);
	right = vectorscale(anglestoright(self.angles), offset_y);
	up = vectorscale(anglestoup(self.angles), offset_z);
	killcament unlink();
	killcament.angles = (0, 0, 0);
	killcament.origin = self.origin;
	killcament linkto(self, "", (offset_x, offset_y, offset_z), vectorscale((1, 0, 0), 9));
	killcament thread unlinkwhenclose(selectedtarget, targetorigin, self);
}

/*
	Name: unlinkwhenclose
	Namespace: straferun
	Checksum: 0xF889EA9C
	Offset: 0x3860
	Size: 0x118
	Parameters: 3
	Flags: Linked
*/
function unlinkwhenclose(selectedtarget, targetorigin, plane)
{
	plane endon(#"death");
	self notify(#"unlink_when_close");
	self endon(#"unlink_when_close");
	distsqr = 1000000;
	while(true)
	{
		if(isdefined(selectedtarget))
		{
			if(distancesquared(self.origin, selectedtarget.origin) < distsqr)
			{
				self unlink();
				self.angles = (0, 0, 0);
				return;
			}
		}
		else if(distancesquared(self.origin, targetorigin) < distsqr)
		{
			self unlink();
			self.angles = (0, 0, 0);
			return;
		}
		wait(0.1);
	}
}

