// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d1a97b78f64bfd;
#using script_2eeea8e6fc9ffec5;
#using script_6c8abe14025b47c4;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace wing_drone;

/*
	Name: function_89f2df9
	Namespace: wing_drone
	Checksum: 0xA4B982F6
	Offset: 0x1B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"wing_drone", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wing_drone
	Checksum: 0xBF609C50
	Offset: 0x1F8
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!isdefined(level.var_c23a525e))
	{
		level.var_c23a525e = {};
		vehicle::add_main_callback("wing_drone", &function_7a81018e);
		clientfield::register("vehicle", "wing_drone_reload", 1, 1, "int");
	}
}

/*
	Name: function_7a81018e
	Namespace: wing_drone
	Checksum: 0xEA24DE0C
	Offset: 0x280
	Size: 0x1CC
	Parameters: 0
	Flags: None
*/
function function_7a81018e()
{
	self endon(#"death");
	self useanimtree("generic");
	vehicle::make_targetable(self, (0, 0, 0));
	self.health = self.healthdefault;
	self vehicle::friendly_fire_shield();
	self setneargoalnotifydist(40);
	self.damagetaken = 0;
	self.fovcosine = 0;
	self.fovcosinebusy = 0.574;
	self.vehaircraftcollisionenabled = 1;
	self.var_94e2cf87 = 1;
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.var_ec0d66ce = 0.5 * self.settings.engagementdistmin + self.settings.engagementdistmax;
	self.var_ff6d7c88 = self.var_ec0d66ce * self.var_ec0d66ce;
	self.vehaircraftcollisionenabled = 0;
	self.ai.var_88b0fd29 = gettime();
	self.ai.var_54b19f55 = 1;
	self.ai.clipsize = 40;
	self.ai.bulletsinclip = 40;
	defaultrole();
	self.overridevehicledamage = &function_9bbb40ab;
	self thread function_df5b4652();
}

/*
	Name: defaultrole
	Namespace: wing_drone
	Checksum: 0xD6C647D9
	Offset: 0x458
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
	self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
	self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	self vehicle_ai::add_state("malfunction", &function_39029b1a, &function_9664709f, &function_36201a5c);
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: function_39029b1a
	Namespace: wing_drone
	Checksum: 0xD6AEB756
	Offset: 0x5A8
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_39029b1a(params)
{
}

/*
	Name: function_9664709f
	Namespace: wing_drone
	Checksum: 0xE9DD6E1F
	Offset: 0x5C0
	Size: 0x1BC
	Parameters: 1
	Flags: None
*/
function function_9664709f(params)
{
	self endon(#"death");
	ang_vel = self getangularvelocity();
	pitch_vel = math::randomsign() * randomfloatrange(200, 250);
	yaw_vel = math::randomsign() * randomfloatrange(200, 250);
	roll_vel = math::randomsign() * randomfloatrange(200, 250);
	ang_vel = ang_vel + (pitch_vel, yaw_vel, roll_vel);
	self setangularvelocity(ang_vel);
	self cancelaimove();
	self setphysacceleration((0, 0, 100 * -1));
	waitresult = undefined;
	waitresult = self waittill_timeout(randomintrange(4, 6), #"veh_collision");
	self vehicle_ai::set_state("death");
}

/*
	Name: function_36201a5c
	Namespace: wing_drone
	Checksum: 0xCA955905
	Offset: 0x788
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_36201a5c(params)
{
}

/*
	Name: function_df5b4652
	Namespace: wing_drone
	Checksum: 0x64E816A0
	Offset: 0x7A0
	Size: 0x9A
	Parameters: 0
	Flags: None
*/
function function_df5b4652()
{
	self endon(#"death");
	self endon(#"change_state");
	for(;;)
	{
		if(isdefined(self.leader))
		{
			break;
		}
		waitframe(1);
	}
	for(;;)
	{
		if(!isdefined(self.leader) || !isalive(self.leader))
		{
			self vehicle_ai::set_state("malfunction");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: state_death_update
	Namespace: wing_drone
	Checksum: 0xF121B1E6
	Offset: 0x848
	Size: 0x124
	Parameters: 1
	Flags: None
*/
function state_death_update(params)
{
	self endon(#"death");
	death_type = vehicle_ai::get_death_type(params);
	if(!isdefined(death_type))
	{
		params.death_type = "gibbed";
		death_type = params.death_type;
	}
	self vehicle_ai::clearalllookingandtargeting();
	self vehicle_ai::clearallmovement();
	self cancelaimove();
	self setspeedimmediate(0);
	self setvehvelocity((0, 0, 0));
	self setphysacceleration((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self vehicle_ai::defaultstate_death_update(params);
}

/*
	Name: state_combat_enter
	Namespace: wing_drone
	Checksum: 0x7B74233E
	Offset: 0x978
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function state_combat_enter(params)
{
	self.protectdest = self.origin;
	self function_a57c34b7(self.origin, 1, 1);
	self thread lead_drone::function_f358791();
}

/*
	Name: reload
	Namespace: wing_drone
	Checksum: 0x2B49B088
	Offset: 0x9D8
	Size: 0x7A
	Parameters: 0
	Flags: None
*/
function reload()
{
	self laseroff();
	clientfield::set("wing_drone_reload", 1);
	wait(2);
	clientfield::set("wing_drone_reload", 0);
	self.ai.bulletsinclip = self.ai.clipsize;
}

/*
	Name: function_a205de0d
	Namespace: wing_drone
	Checksum: 0x1420025C
	Offset: 0xA60
	Size: 0x1A6
	Parameters: 0
	Flags: None
*/
function function_a205de0d()
{
	self endon(#"death");
	self endon(#"change_state");
	self endon(#"end_attack_thread");
	while(true)
	{
		if(isdefined(self.leader))
		{
			enemy = self.leader.favoriteenemy;
			if(isdefined(enemy))
			{
				self laseron();
				self vehlookat(enemy);
				if(self cansee(enemy))
				{
					self turretsettarget(0, enemy);
					while(!self.turretontarget)
					{
						waitframe(1);
					}
					if(isdefined(enemy))
					{
						if(self.ai.bulletsinclip > 0)
						{
							s_turret = self turret::_get_turret_data(0);
							if(isdefined(s_turret))
							{
								minigun = self fireweapon(0, enemy, s_turret.v_offset);
								self.ai.bulletsinclip--;
							}
						}
						else
						{
							reload();
						}
					}
				}
			}
			if(!isdefined(self.favoriteenemy))
			{
				self laseroff();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_789652f2
	Namespace: wing_drone
	Checksum: 0x6F89CE5E
	Offset: 0xC10
	Size: 0x2D6
	Parameters: 6
	Flags: None
*/
function function_789652f2(origin, owner, innerradius, outerradius, halfheight, spacing)
{
	queryresult = positionquery_source_navigation(origin, innerradius, outerradius, halfheight, spacing, "navvolume_small", spacing);
	positionquery_filter_sight(queryresult, origin, self geteye() - self.origin, self, 0, owner);
	foreach(point in queryresult.data)
	{
		if(!point.visibility)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"hash_3f8a9579ce4600de"]))
				{
					point._scoredebug[#"hash_3f8a9579ce4600de"] = spawnstruct();
				}
				point._scoredebug[#"hash_3f8a9579ce4600de"].score = -5000;
				point._scoredebug[#"hash_3f8a9579ce4600de"].var_4b5e0304 = "";
			#/
			point.score = point.score + -5000;
		}
	}
	if(queryresult.data.size > 0)
	{
		vehicle_ai::positionquery_postprocess_sortscore(queryresult);
		self vehicle_ai::positionquery_debugscores(queryresult);
		foreach(point in queryresult.data)
		{
			if(isdefined(point.origin))
			{
				goal = point.origin;
				break;
			}
		}
	}
	return goal;
}

/*
	Name: function_ede09a4e
	Namespace: wing_drone
	Checksum: 0x7AA22C9E
	Offset: 0xEF0
	Size: 0x1EE
	Parameters: 1
	Flags: None
*/
function function_ede09a4e(leader)
{
	protectdest = undefined;
	var_8c46694c = anglestoforward(leader.angles) * -1 * 125;
	if(self.formation == "right")
	{
		var_7a1bb341 = anglestoright(leader.angles) * 125;
	}
	else
	{
		var_7a1bb341 = anglestoright(leader.angles) * -1 * 125;
	}
	var_b4debf4a = leader.origin + var_8c46694c + var_7a1bb341;
	goalpos = self getclosestpointonnavvolume(var_b4debf4a, 2000);
	if(!isdefined(goalpos))
	{
		goalpos = leader.origin;
	}
	pos = goalpos + (0, 0, randomintrange(30, 70));
	pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);
	if(isdefined(pos))
	{
		var_3a364b6c = distance(self.protectdest, pos);
		if(var_3a364b6c > 125)
		{
			protectdest = function_789652f2(pos, leader, 48, 96, 10, 20);
			if(isdefined(protectdest))
			{
				self.protectdest = protectdest;
			}
		}
	}
	return protectdest;
}

/*
	Name: function_b0c75ada
	Namespace: wing_drone
	Checksum: 0x76A3B765
	Offset: 0x10E8
	Size: 0x47A
	Parameters: 1
	Flags: None
*/
function function_b0c75ada(leader)
{
	/#
		assert(isdefined(leader));
	#/
	distsq = distancesquared(self.origin, self.leader.origin);
	if(distsq <= 125 * 125)
	{
		return undefined;
	}
	protectdest = undefined;
	var_8c46694c = anglestoforward(leader.angles) * -1 * 125;
	if(self.formation == "right")
	{
		var_7a1bb341 = anglestoright(leader.angles) * 125;
	}
	else
	{
		var_7a1bb341 = anglestoright(leader.angles) * -1 * 125;
	}
	var_b4debf4a = leader.origin + var_8c46694c + var_7a1bb341;
	groundpos = getclosestpointonnavmesh(var_b4debf4a, 10000);
	if(isdefined(groundpos))
	{
		self.var_d6acaac4 = groundpos;
		groundpos = groundpos + (0, 0, randomintrange(30, 70));
		goalpos = getclosestpointonnavvolume(groundpos, "navvolume_small", 2000);
	}
	if(isdefined(goalpos))
	{
		queryresult = positionquery_source_navigation(goalpos, 48, 96, 10, 20, "navvolume_small", 20);
		positionquery_filter_sight(queryresult, goalpos, self geteye() - self.origin, self, 0, leader);
		foreach(point in queryresult.data)
		{
			if(!point.visibility)
			{
				/#
					if(!isdefined(point._scoredebug))
					{
						point._scoredebug = [];
					}
					if(!isdefined(point._scoredebug[#"hash_3f8a9579ce4600de"]))
					{
						point._scoredebug[#"hash_3f8a9579ce4600de"] = spawnstruct();
					}
					point._scoredebug[#"hash_3f8a9579ce4600de"].score = -5000;
					point._scoredebug[#"hash_3f8a9579ce4600de"].var_4b5e0304 = "";
				#/
				point.score = point.score + -5000;
			}
		}
		if(queryresult.data.size > 0)
		{
			vehicle_ai::positionquery_postprocess_sortscore(queryresult);
			self vehicle_ai::positionquery_debugscores(queryresult);
			foreach(point in queryresult.data)
			{
				if(isdefined(point.origin))
				{
					protectdest = point.origin;
					break;
				}
			}
		}
	}
	self.protectdest = protectdest;
	return protectdest;
}

/*
	Name: function_5ebe7443
	Namespace: wing_drone
	Checksum: 0x164B4A8B
	Offset: 0x1570
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function function_5ebe7443()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.protectdest))
		{
			/#
				recordsphere(self.protectdest, 8, (0, 1, 1), "");
			#/
			if(isdefined(self.var_d6acaac4))
			{
				/#
					recordsphere(self.protectdest, 8, (1, 1, 0), "");
					recordline(self.protectdest, self.var_d6acaac4, (0, 1, 0), "");
				#/
			}
		}
		waitframe(1);
	}
}

/*
	Name: state_combat_update
	Namespace: wing_drone
	Checksum: 0x7C7A0B10
	Offset: 0x1650
	Size: 0x1AE
	Parameters: 1
	Flags: None
*/
function state_combat_update(params)
{
	self endon(#"change_state");
	self endon(#"death");
	self thread function_5ebe7443();
	self thread function_a205de0d();
	for(;;)
	{
		if(isdefined(self.ignoreall) && self.ignoreall)
		{
			wait(1);
			continue;
		}
		if(!ispointinnavvolume(self.origin, "navvolume_small"))
		{
			var_f524eafc = getclosestpointonnavvolume(self.origin, "navvolume_small", 2000);
			if(isdefined(var_f524eafc))
			{
				self.origin = var_f524eafc;
			}
		}
		if(!isdefined(self.leader))
		{
			wait(1);
			continue;
		}
		if(isdefined(self.leader) && isdefined(self.leader.owner) && isdefined(level.var_fdf0dff2) && ![[level.var_fdf0dff2]](self.leader.owner))
		{
			wait(1);
			continue;
		}
		protectdest = function_ede09a4e(self.leader);
		if(isdefined(protectdest))
		{
			self function_a57c34b7(protectdest, 1, 1);
		}
		wait(1);
	}
}

/*
	Name: state_combat_exit
	Namespace: wing_drone
	Checksum: 0x1F203F79
	Offset: 0x1808
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function state_combat_exit(params)
{
	self notify(#"end_attack_thread");
	self notify(#"end_movement_thread");
	self turretcleartarget(0);
}

/*
	Name: function_9bbb40ab
	Namespace: wing_drone
	Checksum: 0x42CEE508
	Offset: 0x1858
	Size: 0x30A
	Parameters: 15
	Flags: None
*/
function function_9bbb40ab(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(smeansofdeath == "MOD_TRIGGER_HURT")
	{
		return 0;
	}
	idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
	if(isdefined(weapon))
	{
		if(weapon.dostun && smeansofdeath == "MOD_GRENADE_SPLASH" || weapon.var_8456d4d === #"hash_290c55f046707b38")
		{
			minempdowntime = 0.8 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 0);
			maxempdowntime = 1.2 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 1);
			self notify(#"emped", {#param2:einflictor, #param1:eattacker, #param0:randomfloatrange(minempdowntime, maxempdowntime)});
		}
	}
	emp_damage = self.healthdefault * 0.5 + 0.5;
	idamage = killstreaks::ondamageperweapon("drone_squadron", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, &destroyed_cb, self.maxhealth * 0.4, &low_health_cb, emp_damage, undefined, 1, 1);
	if(isdefined(weapon))
	{
		if(weapon.name == #"hatchet" && smeansofdeath == "MOD_IMPACT")
		{
			idamage = self.maxhealth;
		}
	}
	self.damagetaken = self.damagetaken + idamage;
	return idamage;
}

/*
	Name: destroyed_cb
	Namespace: wing_drone
	Checksum: 0xE87232C5
	Offset: 0x1B70
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function destroyed_cb(attacker, weapon)
{
}

/*
	Name: low_health_cb
	Namespace: wing_drone
	Checksum: 0x72E90B5D
	Offset: 0x1B90
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function low_health_cb(attacker, weapon)
{
}

