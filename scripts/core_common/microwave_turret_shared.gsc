// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\weapons\weaponobjects.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace microwave_turret;

/*
	Name: init_shared
	Namespace: microwave_turret
	Checksum: 0x406023C2
	Offset: 0x130
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	clientfield::register("vehicle", "turret_microwave_open", 1, 1, "int");
	clientfield::register("scriptmover", "turret_microwave_init", 1, 1, "int");
	clientfield::register("scriptmover", "turret_microwave_close", 1, 1, "int");
	callback::on_spawned(&on_player_spawned);
	callback::on_vehicle_spawned(&on_vehicle_spawned);
}

/*
	Name: on_player_spawned
	Namespace: microwave_turret
	Checksum: 0x6EA5F56B
	Offset: 0x210
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_player_spawned()
{
	self reset_being_microwaved();
}

/*
	Name: on_vehicle_spawned
	Namespace: microwave_turret
	Checksum: 0x60574D6B
	Offset: 0x238
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function on_vehicle_spawned()
{
	self reset_being_microwaved();
}

/*
	Name: reset_being_microwaved
	Namespace: microwave_turret
	Checksum: 0xB51580B8
	Offset: 0x260
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function reset_being_microwaved()
{
	self.lastmicrowavedby = undefined;
	self.beingmicrowavedby = undefined;
}

/*
	Name: startmicrowave
	Namespace: microwave_turret
	Checksum: 0x6526CE9D
	Offset: 0x280
	Size: 0xD4
	Parameters: 0
	Flags: None
*/
function startmicrowave()
{
	turret = self;
	if(isdefined(turret.trigger))
	{
		turret.trigger delete();
	}
	turret.trigger = spawn("trigger_radius", turret.origin + (0, 0, 750 * -1), ((4096 | 16384) | level.aitriggerspawnflags) | level.vehicletriggerspawnflags, 750, 750 * 2);
	turret thread turretthink();
	/#
		turret thread turretdebugwatch();
	#/
}

/*
	Name: stopmicrowave
	Namespace: microwave_turret
	Checksum: 0xCAFEEBEA
	Offset: 0x360
	Size: 0x80
	Parameters: 0
	Flags: None
*/
function stopmicrowave()
{
	turret = self;
	if(isdefined(turret))
	{
		turret playsound(#"mpl_microwave_beam_off");
		if(isdefined(turret.trigger))
		{
			turret.trigger delete();
		}
		/#
			turret notify(#"stop_turret_debug");
		#/
	}
}

/*
	Name: turretdebugwatch
	Namespace: microwave_turret
	Checksum: 0xCF2B4F41
	Offset: 0x3E8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function turretdebugwatch()
{
	/#
		turret = self;
		turret endon(#"stop_turret_debug");
		for(;;)
		{
			if(getdvarint(#"scr_microwave_turret_debug", 0) != 0)
			{
				turret turretdebug();
				waitframe(1);
				continue;
			}
			wait(1);
		}
	#/
}

/*
	Name: turretdebug
	Namespace: microwave_turret
	Checksum: 0x38B64F77
	Offset: 0x470
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function turretdebug()
{
	/#
		turret = self;
		angles = turret gettagangles("");
		origin = turret gettagorigin("");
		cone_apex = origin;
		forward = anglestoforward(angles);
		dome_apex = cone_apex + vectorscale(forward, 750);
		/#
			util::debug_spherical_cone(cone_apex, dome_apex, 15, 16, (0.95, 0.1, 0.1), 0.3, 1, 3);
		#/
	#/
}

/*
	Name: turretthink
	Namespace: microwave_turret
	Checksum: 0x5431BD8E
	Offset: 0x588
	Size: 0x140
	Parameters: 0
	Flags: None
*/
function turretthink()
{
	turret = self;
	turret endon(#"microwave_turret_shutdown", #"death");
	turret.trigger endon(#"death", #"delete");
	turret.turret_vehicle_entnum = turret getentitynumber();
	while(true)
	{
		waitresult = undefined;
		waitresult = turret.trigger waittill(#"trigger");
		ent = waitresult.activator;
		if(ent == turret)
		{
			continue;
		}
		if(!isdefined(ent.beingmicrowavedby))
		{
			ent.beingmicrowavedby = [];
		}
		if(!isdefined(ent.beingmicrowavedby[turret.turret_vehicle_entnum]))
		{
			turret thread microwaveentity(ent);
		}
	}
}

/*
	Name: microwaveentitypostshutdowncleanup
	Namespace: microwave_turret
	Checksum: 0x9442E80A
	Offset: 0x6D0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function microwaveentitypostshutdowncleanup(entity)
{
	entity endon(#"disconnect", #"end_microwaveentitypostshutdowncleanup");
	turret = self;
	turret_vehicle_entnum = turret.turret_vehicle_entnum;
	turret waittill(#"microwave_turret_shutdown");
	if(isdefined(entity))
	{
		if(isdefined(entity.beingmicrowavedby) && isdefined(entity.beingmicrowavedby[turret_vehicle_entnum]))
		{
			entity.beingmicrowavedby[turret_vehicle_entnum] = undefined;
		}
	}
}

/*
	Name: microwaveentity
	Namespace: microwave_turret
	Checksum: 0xF2063867
	Offset: 0x788
	Size: 0x6D8
	Parameters: 1
	Flags: None
*/
function microwaveentity(entity)
{
	turret = self;
	turret endon(#"microwave_turret_shutdown", #"death");
	entity endon(#"disconnect", #"death");
	if(isplayer(entity))
	{
		entity endon(#"joined_team", #"joined_spectators");
	}
	turret thread microwaveentitypostshutdowncleanup(entity);
	entity.beingmicrowavedby[turret.turret_vehicle_entnum] = turret.owner;
	entity.microwavedamageinitialdelay = 1;
	entity.microwaveeffect = 0;
	shellshockscalar = 1;
	viewkickscalar = 1;
	damagescalar = 1;
	if(isplayer(entity) && entity hasperk(#"specialty_microwaveprotection"))
	{
		shellshockscalar = getdvarfloat(#"specialty_microwaveprotection_shellshock_scalar", 0.5);
		viewkickscalar = getdvarfloat(#"specialty_microwaveprotection_viewkick_scalar", 0.5);
		damagescalar = getdvarfloat(#"specialty_microwaveprotection_damage_scalar", 0.5);
	}
	turretweapon = getweapon(#"microwave_turret");
	while(true)
	{
		if(!isdefined(turret) || !turret microwaveturretaffectsentity(entity) || !isdefined(turret.trigger))
		{
			if(!isdefined(entity))
			{
				return;
			}
			entity.beingmicrowavedby[turret.turret_vehicle_entnum] = undefined;
			if(isdefined(entity.microwavepoisoning) && entity.microwavepoisoning)
			{
				entity.microwavepoisoning = 0;
			}
			entity notify(#"end_microwaveentitypostshutdowncleanup");
			return;
		}
		damage = 15 * damagescalar;
		if(level.hardcoremode)
		{
			damage = damage / 2;
		}
		if(!isai(entity) && entity util::mayapplyscreeneffect())
		{
			if(!isdefined(entity.microwavepoisoning) || !entity.microwavepoisoning)
			{
				entity.microwavepoisoning = 1;
				entity.microwaveeffect = 0;
			}
		}
		if(isdefined(entity.microwavedamageinitialdelay))
		{
			wait(randomfloatrange(0.1, 0.3));
			entity.microwavedamageinitialdelay = undefined;
		}
		entity dodamage(damage, turret.origin, turret.owner, turret, 0, "MOD_TRIGGER_HURT", 0, turretweapon);
		entity.microwaveeffect++;
		entity.lastmicrowavedby = turret.owner;
		time = gettime();
		if(isplayer(entity) && !entity isremotecontrolling())
		{
			if(time - (isdefined(entity.microwaveshellshockandviewkicktime) ? entity.microwaveshellshockandviewkicktime : 0) > 950)
			{
				if((entity.microwaveeffect % 2) == 1)
				{
					if(distancesquared(entity.origin, turret.origin) > ((750 * 2) / 3) * ((750 * 2) / 3))
					{
						entity shellshock(#"mp_radiation_low", 1.5 * shellshockscalar);
						entity viewkick(int(25 * viewkickscalar), turret.origin);
					}
					else
					{
						if(distancesquared(entity.origin, turret.origin) > ((750 * 1) / 3) * ((750 * 1) / 3))
						{
							entity shellshock(#"mp_radiation_med", 1.5 * shellshockscalar);
							entity viewkick(int(50 * viewkickscalar), turret.origin);
						}
						else
						{
							entity shellshock(#"mp_radiation_high", 1.5 * shellshockscalar);
							entity viewkick(int(75 * viewkickscalar), turret.origin);
						}
					}
					entity.microwaveshellshockandviewkicktime = time;
				}
			}
		}
		if(isplayer(entity) && (entity.microwaveeffect % 3) == 2)
		{
			scoreevents::processscoreevent(#"hpm_suppress", turret.owner, entity, turretweapon);
		}
		wait(0.5);
	}
}

/*
	Name: microwaveturretaffectsentity
	Namespace: microwave_turret
	Checksum: 0x673D2A72
	Offset: 0xE68
	Size: 0x282
	Parameters: 1
	Flags: None
*/
function microwaveturretaffectsentity(entity)
{
	turret = self;
	if(!isalive(entity))
	{
		return false;
	}
	if(!isplayer(entity) && !isai(entity))
	{
		return false;
	}
	if(entity.ignoreme === 1)
	{
		return false;
	}
	if(isdefined(turret.carried) && turret.carried)
	{
		return false;
	}
	if(turret weaponobjects::isstunned())
	{
		return false;
	}
	if(isdefined(turret.owner) && entity == turret.owner)
	{
		return false;
	}
	if(!damage::friendlyfirecheck(turret.owner, entity, 0))
	{
		return false;
	}
	if(distancesquared(entity.origin, turret.origin) > 750 * 750)
	{
		return false;
	}
	angles = turret gettagangles("tag_flash");
	origin = turret gettagorigin("tag_flash");
	shoot_at_pos = entity getshootatpos(turret);
	entdirection = vectornormalize(shoot_at_pos - origin);
	forward = anglestoforward(angles);
	dot = vectordot(entdirection, forward);
	if(dot < cos(15))
	{
		return false;
	}
	if(entity damageconetrace(origin, turret, forward) <= 0)
	{
		return false;
	}
	return true;
}

