// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;

#namespace bouncingbetty;

/*
	Name: init_shared
	Namespace: bouncingbetty
	Checksum: 0xA6E9EFFE
	Offset: 0x150
	Size: 0x374
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	level.bettydestroyedfx = #"weapon/fx_betty_exp_destroyed";
	level._effect[#"fx_betty_friendly_light"] = #"hash_5f76ecd582d98e38";
	level._effect[#"fx_betty_enemy_light"] = #"hash_330682ff4f12f646";
	level.bettymindist = 20;
	level.bettystuntime = 1;
	bettyexplodeanim = "o_spider_mine_detonate";
	bettydeployanim = "o_spider_mine_deploy";
	level.bettyradius = getdvarint(#"betty_detect_radius", 180);
	level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", 1);
	level.bettygraceperiod = getdvarfloat(#"betty_grace_period", 0);
	level.bettydamageradius = getdvarint(#"betty_damage_radius", 180);
	level.bettydamagemax = getdvarint(#"betty_damage_max", 180);
	level.bettydamagemin = getdvarint(#"betty_damage_min", 70);
	level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", 200);
	level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", 55);
	level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", 20);
	level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", 30);
	level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
	level.bettyjumptime = getdvarfloat(#"betty_jump_time", 0.7);
	level.bettybombletspawndistance = 20;
	level.bettybombletcount = 4;
	level thread register();
	/#
		level thread bouncingbettydvarupdate();
	#/
	weaponobjects::function_e6400478(#"bouncingbetty", &createbouncingbettywatcher, 0);
}

/*
	Name: register
	Namespace: bouncingbetty
	Checksum: 0xDF43ADC3
	Offset: 0x4D0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function register()
{
	clientfield::register("missile", "bouncingbetty_state", 1, 2, "int");
	clientfield::register("scriptmover", "bouncingbetty_state", 1, 2, "int");
}

/*
	Name: bouncingbettydvarupdate
	Namespace: bouncingbetty
	Checksum: 0xD1D7279C
	Offset: 0x540
	Size: 0x2A0
	Parameters: 0
	Flags: None
*/
function bouncingbettydvarupdate()
{
	/#
		for(;;)
		{
			level.bettyradius = getdvarint(#"betty_detect_radius", level.bettyradius);
			level.bettyactivationdelay = getdvarfloat(#"betty_activation_delay", level.bettyactivationdelay);
			level.bettygraceperiod = getdvarfloat(#"betty_grace_period", level.bettygraceperiod);
			level.bettydamageradius = getdvarint(#"betty_damage_radius", level.bettydamageradius);
			level.bettydamagemax = getdvarint(#"betty_damage_max", level.bettydamagemax);
			level.bettydamagemin = getdvarint(#"betty_damage_min", level.bettydamagemin);
			level.bettydamageheight = getdvarint(#"betty_damage_cylinder_height", level.bettydamageheight);
			level.bettyjumpheight = getdvarint(#"betty_jump_height_onground", level.bettyjumpheight);
			level.bettyjumpheightwall = getdvarint(#"betty_jump_height_wall", level.bettyjumpheightwall);
			level.bettyjumpheightwallangle = getdvarint(#"betty_onground_angle_threshold", level.bettyjumpheightwallangle);
			level.bettyjumpheightwallanglecos = cos(level.bettyjumpheightwallangle);
			level.bettyjumptime = getdvarfloat(#"betty_jump_time", level.bettyjumptime);
			wait(3);
		}
	#/
}

/*
	Name: createbouncingbettywatcher
	Namespace: bouncingbetty
	Checksum: 0xAB9CD39E
	Offset: 0x7E8
	Size: 0x176
	Parameters: 1
	Flags: None
*/
function createbouncingbettywatcher(watcher)
{
	watcher.onspawn = &onspawnbouncingbetty;
	watcher.watchforfire = 1;
	watcher.ondetonatecallback = &bouncingbettydetonate;
	watcher.activatesound = #"wpn_betty_alert";
	watcher.hackable = 1;
	watcher.hackertoolradius = level.equipmenthackertoolradius;
	watcher.hackertooltimems = level.equipmenthackertooltimems;
	watcher.ownergetsassist = 1;
	watcher.ignoredirection = 1;
	watcher.immediatedetonation = 1;
	watcher.immunespecialty = "specialty_immunetriggerbetty";
	watcher.detectionmindist = level.bettymindist;
	watcher.detectiongraceperiod = level.bettygraceperiod;
	watcher.detonateradius = level.bettyradius;
	watcher.onfizzleout = &onbouncingbettyfizzleout;
	watcher.stun = &weaponobjects::weaponstun;
	watcher.stuntime = level.bettystuntime;
	watcher.activationdelay = level.bettyactivationdelay;
}

/*
	Name: onbouncingbettyfizzleout
	Namespace: bouncingbetty
	Checksum: 0x2DE4E08F
	Offset: 0x968
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function onbouncingbettyfizzleout()
{
	if(isdefined(self.minemover))
	{
		if(isdefined(self.minemover.killcament))
		{
			self.minemover.killcament delete();
		}
		self.minemover delete();
	}
	self delete();
}

/*
	Name: onspawnbouncingbetty
	Namespace: bouncingbetty
	Checksum: 0x9296D9B4
	Offset: 0x9E8
	Size: 0xAC
	Parameters: 2
	Flags: None
*/
function onspawnbouncingbetty(watcher, owner)
{
	weaponobjects::onspawnproximityweaponobject(watcher, owner);
	self.originalowner = owner;
	self thread spawnminemover();
	self trackonowner(owner);
	self thread trackusedstatondeath();
	self thread donotrackusedstatonpickup();
	self thread trackusedonhack();
}

/*
	Name: trackusedstatondeath
	Namespace: bouncingbetty
	Checksum: 0x8CBBC8A7
	Offset: 0xAA0
	Size: 0x66
	Parameters: 0
	Flags: None
*/
function trackusedstatondeath()
{
	self endon(#"do_not_track_used");
	self waittill(#"death");
	waittillframeend();
	self.owner trackbouncingbettyasused();
	self notify(#"end_donotrackusedonpickup");
	self notify(#"end_donotrackusedonhacked");
}

/*
	Name: donotrackusedstatonpickup
	Namespace: bouncingbetty
	Checksum: 0xCEB54864
	Offset: 0xB10
	Size: 0x3E
	Parameters: 0
	Flags: None
*/
function donotrackusedstatonpickup()
{
	self endon(#"end_donotrackusedonpickup");
	self waittill(#"picked_up");
	self notify(#"do_not_track_used");
}

/*
	Name: trackusedonhack
	Namespace: bouncingbetty
	Checksum: 0xC1098234
	Offset: 0xB58
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function trackusedonhack()
{
	self endon(#"end_donotrackusedonhacked");
	self waittill(#"hacked");
	self.originalowner trackbouncingbettyasused();
	self notify(#"do_not_track_used");
}

/*
	Name: trackbouncingbettyasused
	Namespace: bouncingbetty
	Checksum: 0x3F94DA74
	Offset: 0xBB8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function trackbouncingbettyasused()
{
	if(isplayer(self))
	{
		self stats::function_e24eec31(getweapon(#"bouncingbetty"), #"used", 1);
	}
}

/*
	Name: trackonowner
	Namespace: bouncingbetty
	Checksum: 0x94708ABE
	Offset: 0xC28
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function trackonowner(owner)
{
	if(level.trackbouncingbettiesonowner === 1)
	{
		if(!isdefined(owner))
		{
			return;
		}
		if(!isdefined(owner.activebouncingbetties))
		{
			owner.activebouncingbetties = [];
		}
		else
		{
			arrayremovevalue(owner.activebouncingbetties, undefined);
		}
		owner.activebouncingbetties[owner.activebouncingbetties.size] = self;
	}
}

/*
	Name: spawnminemover
	Namespace: bouncingbetty
	Checksum: 0x52120927
	Offset: 0xCC0
	Size: 0x29C
	Parameters: 0
	Flags: None
*/
function spawnminemover()
{
	self endon(#"death");
	self util::waittillnotmoving();
	self clientfield::set("bouncingbetty_state", 2);
	self useanimtree("generic");
	self setanim(#"o_spider_mine_deploy", 1, 0, 1);
	minemover = spawn("script_model", self.origin);
	minemover.angles = self.angles;
	minemover setmodel(#"tag_origin");
	minemover.owner = self.owner;
	mineup = anglestoup(minemover.angles);
	z_offset = getdvarfloat(#"scr_bouncing_betty_killcam_offset", 18);
	minemover enablelinkto();
	minemover linkto(self);
	minemover.killcamoffset = vectorscale(mineup, z_offset);
	minemover.weapon = self.weapon;
	minemover playsound(#"wpn_betty_arm");
	killcament = spawn("script_model", minemover.origin + minemover.killcamoffset);
	killcament.angles = (0, 0, 0);
	killcament setmodel(#"tag_origin");
	killcament setweapon(self.weapon);
	minemover.killcament = killcament;
	self.minemover = minemover;
	self thread killminemoveronpickup();
}

/*
	Name: killminemoveronpickup
	Namespace: bouncingbetty
	Checksum: 0xDFED91E0
	Offset: 0xF68
	Size: 0x54
	Parameters: 0
	Flags: None
*/
function killminemoveronpickup()
{
	self.minemover endon(#"death");
	self waittill(#"picked_up", #"hacked");
	self killminemover();
}

/*
	Name: killminemover
	Namespace: bouncingbetty
	Checksum: 0xAFCFD739
	Offset: 0xFC8
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function killminemover()
{
	if(isdefined(self.minemover))
	{
		if(isdefined(self.minemover.killcament))
		{
			self.minemover.killcament delete();
		}
		self.minemover delete();
	}
}

/*
	Name: bouncingbettydetonate
	Namespace: bouncingbetty
	Checksum: 0xE111D62F
	Offset: 0x1030
	Size: 0x14C
	Parameters: 3
	Flags: None
*/
function bouncingbettydetonate(attacker, weapon, target)
{
	if(isdefined(weapon) && weapon.isvalid)
	{
		self.destroyedby = attacker;
		if(isdefined(attacker))
		{
			if(self.owner util::isenemyplayer(attacker))
			{
				attacker challenges::destroyedexplosive(weapon);
				scoreevents::processscoreevent(#"destroyed_bouncingbetty", attacker, self.owner, weapon);
			}
		}
		self bouncingbettydestroyed();
	}
	else
	{
		if(isdefined(self.minemover))
		{
			self.minemover.ignore_team_kills = 1;
			self.minemover setmodel(self.model);
			self.minemover thread bouncingbettyjumpandexplode();
			self delete();
		}
		else
		{
			self bouncingbettydestroyed();
		}
	}
}

/*
	Name: bouncingbettydestroyed
	Namespace: bouncingbetty
	Checksum: 0xB9CAD3D7
	Offset: 0x1188
	Size: 0xE4
	Parameters: 0
	Flags: None
*/
function bouncingbettydestroyed()
{
	playfx(level.bettydestroyedfx, self.origin);
	playsoundatposition(#"dst_equipment_destroy", self.origin);
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}
	self killminemover();
	self radiusdamage(self.origin, 128, 110, 10, self.owner, "MOD_EXPLOSIVE", self.weapon);
	self delete();
}

/*
	Name: bouncingbettyjumpandexplode
	Namespace: bouncingbetty
	Checksum: 0x8CB1DF24
	Offset: 0x1278
	Size: 0x114
	Parameters: 0
	Flags: None
*/
function bouncingbettyjumpandexplode()
{
	jumpdir = vectornormalize(anglestoup(self.angles));
	if(jumpdir[2] > level.bettyjumpheightwallanglecos)
	{
		jumpheight = level.bettyjumpheight;
	}
	else
	{
		jumpheight = level.bettyjumpheightwall;
	}
	explodepos = self.origin + (jumpdir * jumpheight);
	self.killcament moveto(explodepos + self.killcamoffset, level.bettyjumptime, 0, level.bettyjumptime);
	self clientfield::set("bouncingbetty_state", 1);
	wait(level.bettyjumptime);
	self thread mineexplode(jumpdir, explodepos);
}

/*
	Name: mineexplode
	Namespace: bouncingbetty
	Checksum: 0x5B48408A
	Offset: 0x1398
	Size: 0x18C
	Parameters: 2
	Flags: None
*/
function mineexplode(explosiondir, explodepos)
{
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}
	self playsound(#"wpn_betty_explo");
	self clientfield::increment("sndRattle", 1);
	waitframe(1);
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}
	self cylinderdamage(explosiondir * level.bettydamageheight, explodepos, level.bettydamageradius, level.bettydamageradius, level.bettydamagemax, level.bettydamagemin, self.owner, "MOD_EXPLOSIVE", self.weapon);
	self ghost();
	wait(0.1);
	if(!isdefined(self) || !isdefined(self.owner))
	{
		return;
	}
	if(isdefined(self.trigger))
	{
		self.trigger delete();
	}
	self.killcament delete();
	self delete();
}

