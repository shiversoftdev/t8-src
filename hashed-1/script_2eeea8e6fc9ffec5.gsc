// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d1a97b78f64bfd;
#using script_59f07c660e6710a5;
#using script_6c8abe14025b47c4;
#using script_751513c609504a42;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

#namespace lead_drone;

/*
	Name: function_89f2df9
	Namespace: lead_drone
	Checksum: 0x4F75F9EC
	Offset: 0x1C8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"lead_drone", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lead_drone
	Checksum: 0x2986F048
	Offset: 0x210
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_main_callback("lead_drone", &function_e8549ef6);
	clientfield::register("vehicle", "lead_drone_reload", 1, 1, "int");
}

/*
	Name: function_e8549ef6
	Namespace: lead_drone
	Checksum: 0xC045AB23
	Offset: 0x278
	Size: 0x1EC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e8549ef6()
{
	self endon(#"death");
	self useanimtree("generic");
	vehicle::make_targetable(self, (0, 0, 0));
	ai::createinterfaceforentity(self);
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
	self.ai.clipsize = 60;
	self.ai.bulletsinclip = 60;
	defaultrole();
	self.overridevehicledamage = &function_9bbb40ab;
	self thread namespace_14c38db0::function_7e1a12ce(3500);
}

/*
	Name: side_turrets_forward
	Namespace: lead_drone
	Checksum: 0x22553DC9
	Offset: 0x470
	Size: 0x54
	Parameters: 0
	Flags: Private
*/
private function side_turrets_forward()
{
	self turretsettargetangles(1, (10, -90, 0));
	self turretsettargetangles(2, (10, 90, 0));
}

/*
	Name: defaultrole
	Namespace: lead_drone
	Checksum: 0x30A457D8
	Offset: 0x4D0
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role();
	self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
	self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
	self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
	self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: state_death_update
	Namespace: lead_drone
	Checksum: 0x26B313DC
	Offset: 0x5D0
	Size: 0x124
	Parameters: 1
	Flags: Linked
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
	Name: function_f358791
	Namespace: lead_drone
	Checksum: 0x8FACA29
	Offset: 0x700
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_f358791()
{
	self endon(#"death", #"change_state");
	wait(1);
	for(;;)
	{
		if(isdefined(self.isstunned) && self.isstunned)
		{
			self.favoriteenemy = undefined;
			waitframe(1);
			continue;
		}
		targets = [];
		targetsmissile = [];
		players = level.players;
		foreach(player in players)
		{
			if(self cantargetplayer(player))
			{
				targets[targets.size] = player;
			}
		}
		tanks = getentarray("talon", "targetname");
		foreach(tank in tanks)
		{
			if(self function_932034ba(tank))
			{
				targets[targets.size] = tank;
			}
		}
		actors = getactorarray();
		foreach(actor in actors)
		{
			if(self cantargetactor(actor))
			{
				targets[targets.size] = actor;
			}
		}
		self.var_dac49144 = function_b2cc6703(targets);
		wait(1);
	}
}

/*
	Name: function_b2cc6703
	Namespace: lead_drone
	Checksum: 0xA4384408
	Offset: 0x998
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function function_b2cc6703(targets)
{
	entnum = self getentitynumber();
	for(idx = 0; idx < targets.size; idx++)
	{
		if(!isdefined(targets[idx].var_629a6b13))
		{
			targets[idx].var_629a6b13 = [];
		}
		targets[idx].var_629a6b13[entnum] = 0;
		if(isdefined(targets[idx].type) && targets[idx].type == "dog")
		{
			update_dog_threat(targets[idx]);
			continue;
		}
		if(isactor(targets[idx]))
		{
			update_actor_threat(targets[idx]);
			continue;
		}
		if(isplayer(targets[idx]))
		{
			update_player_threat(targets[idx]);
			continue;
		}
		update_non_player_threat(targets[idx]);
	}
	var_8ec7f501 = undefined;
	highest = -1;
	for(idx = 0; idx < targets.size; idx++)
	{
		/#
			assert(isdefined(targets[idx].var_629a6b13[entnum]), "");
		#/
		if(targets[idx].var_629a6b13[entnum] >= highest)
		{
			highest = targets[idx].var_629a6b13[entnum];
			var_8ec7f501 = targets[idx];
		}
	}
	return var_8ec7f501;
}

/*
	Name: update_player_threat
	Namespace: lead_drone
	Checksum: 0x18B716CD
	Offset: 0xBF0
	Size: 0x29A
	Parameters: 1
	Flags: Linked, Private
*/
private function update_player_threat(player)
{
	entnum = self getentitynumber();
	player.var_629a6b13[entnum] = 0;
	dist = distance(player.origin, self.origin);
	player.var_629a6b13[entnum] = player.var_629a6b13[entnum] - dist;
	if(isdefined(self.attacker) && player == self.attacker)
	{
		player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 100;
	}
	if(isdefined(player.carryobject))
	{
		player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 200;
	}
	if(player weapons::has_launcher())
	{
		if(player weapons::has_lockon(self))
		{
			player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 1000;
		}
		else
		{
			player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 500;
		}
	}
	if(player weapons::has_heavy_weapon())
	{
		player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 300;
	}
	if(player weapons::has_lmg())
	{
		player.var_629a6b13[entnum] = player.var_629a6b13[entnum] + 200;
	}
	if(isdefined(player.antithreat))
	{
		player.var_629a6b13[entnum] = player.var_629a6b13[entnum] - player.antithreat;
	}
	if(player.var_629a6b13[entnum] <= 0)
	{
		player.var_629a6b13[entnum] = 2;
	}
}

/*
	Name: update_non_player_threat
	Namespace: lead_drone
	Checksum: 0xBF72EB90
	Offset: 0xE98
	Size: 0xCA
	Parameters: 1
	Flags: Linked, Private
*/
private function update_non_player_threat(non_player)
{
	entnum = self getentitynumber();
	non_player.var_629a6b13[entnum] = 0;
	dist = distance(non_player.origin, self.origin);
	non_player.var_629a6b13[entnum] = non_player.var_629a6b13[entnum] - dist;
	if(non_player.var_629a6b13[entnum] <= 0)
	{
		non_player.var_629a6b13[entnum] = 1;
	}
}

/*
	Name: update_actor_threat
	Namespace: lead_drone
	Checksum: 0xFB9E061B
	Offset: 0xF70
	Size: 0x1C2
	Parameters: 1
	Flags: Linked, Private
*/
private function update_actor_threat(actor)
{
	entnum = self getentitynumber();
	actor.var_629a6b13[entnum] = 0;
	dist = distance(actor.origin, self.origin);
	actor.var_629a6b13[entnum] = actor.var_629a6b13[entnum] - dist;
	if(isdefined(actor.owner))
	{
		if(isdefined(self.attacker) && actor.owner == self.attacker)
		{
			actor.var_629a6b13[entnum] = actor.var_629a6b13[entnum] + 100;
		}
		if(isdefined(actor.owner.carryobject))
		{
			actor.var_629a6b13[entnum] = actor.var_629a6b13[entnum] + 200;
		}
		if(isdefined(actor.owner.antithreat))
		{
			actor.var_629a6b13[entnum] = actor.var_629a6b13[entnum] - actor.owner.antithreat;
		}
	}
	if(actor.var_629a6b13[entnum] <= 0)
	{
		actor.var_629a6b13[entnum] = 1;
	}
}

/*
	Name: update_dog_threat
	Namespace: lead_drone
	Checksum: 0xF8A48FC9
	Offset: 0x1140
	Size: 0x9A
	Parameters: 1
	Flags: Linked, Private
*/
private function update_dog_threat(dog)
{
	entnum = self getentitynumber();
	dog.var_629a6b13[entnum] = 0;
	dist = distance(dog.origin, self.origin);
	dog.var_629a6b13[entnum] = dog.var_629a6b13[entnum] - dist;
}

/*
	Name: cantargetplayer
	Namespace: lead_drone
	Checksum: 0x359E37B7
	Offset: 0x11E8
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function cantargetplayer(player)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(!isalive(player) || player.sessionstate != "playing")
	{
		return 0;
	}
	if(player.ignoreme === 1)
	{
		return 0;
	}
	if(isdefined(self.owner) && player == self.owner)
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
	if(!self cansee(player, 2))
	{
		return 0;
	}
	if(player depthinwater() >= 30 || player isplayerswimming())
	{
		return 0;
	}
	var_2910def0 = self namespace_14c38db0::function_1c169b3a(player);
	namespace_14c38db0::function_a4d6d6d8(player, int((isdefined(self.targeting_delay) ? self.targeting_delay : 0.05) * 1000));
	if(!var_2910def0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_932034ba
	Namespace: lead_drone
	Checksum: 0x30EF5EB5
	Offset: 0x13C8
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_932034ba(tank)
{
	if(!isdefined(tank))
	{
		return 0;
	}
	if(!isdefined(tank.team))
	{
		return 0;
	}
	if(!util::function_fbce7263(tank.team, self.team))
	{
		return 0;
	}
	if(isdefined(tank.owner) && self.owner == tank.owner)
	{
		return 0;
	}
	return 1;
}

/*
	Name: cantargetactor
	Namespace: lead_drone
	Checksum: 0xB1A16ADC
	Offset: 0x1460
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function cantargetactor(actor)
{
	if(!isdefined(actor))
	{
		return 0;
	}
	if(!isactor(actor))
	{
		return 0;
	}
	if(!isalive(actor))
	{
		return 0;
	}
	if(!isdefined(actor.team))
	{
		return 0;
	}
	if(!util::function_fbce7263(actor.team, self.team))
	{
		return 0;
	}
	return 1;
}

/*
	Name: state_combat_enter
	Namespace: lead_drone
	Checksum: 0x4283156A
	Offset: 0x14F8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function state_combat_enter(params)
{
	self.protectdest = self.origin;
	self function_a57c34b7(self.origin, 1, 1);
	self thread function_f358791();
}

/*
	Name: reload
	Namespace: lead_drone
	Checksum: 0x5666373C
	Offset: 0x1558
	Size: 0x7A
	Parameters: 0
	Flags: Linked
*/
function reload()
{
	self laseroff();
	clientfield::set("lead_drone_reload", 1);
	wait(2);
	clientfield::set("lead_drone_reload", 0);
	self.ai.bulletsinclip = self.ai.clipsize;
}

/*
	Name: function_a205de0d
	Namespace: lead_drone
	Checksum: 0x8F49926
	Offset: 0x15E0
	Size: 0x1C6
	Parameters: 0
	Flags: Linked
*/
function function_a205de0d()
{
	self endon(#"death", #"change_state", #"end_attack_thread");
	while(true)
	{
		enemy = undefined;
		if(isdefined(self.var_dac49144))
		{
			enemy = self.var_dac49144;
			self.favoriteenemy = self.var_dac49144;
		}
		else
		{
			enemy = undefined;
			self.favoriteenemy = undefined;
		}
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
		waitframe(1);
	}
}

/*
	Name: function_1c4cd527
	Namespace: lead_drone
	Checksum: 0x2E1497F8
	Offset: 0x17B0
	Size: 0x2D6
	Parameters: 6
	Flags: Linked
*/
function function_1c4cd527(origin, owner, innerradius, outerradius, halfheight, spacing)
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
	Namespace: lead_drone
	Checksum: 0x210135AB
	Offset: 0x1A90
	Size: 0x16E
	Parameters: 1
	Flags: Linked
*/
function function_ede09a4e(owner)
{
	protectdest = undefined;
	if(isdefined(owner))
	{
		groundpos = getclosestpointonnavmesh(owner.origin, 10000);
		groundpos = groundpos + vectorscale(anglestoforward(owner.angles), randomintrange(100, 200));
		if(isdefined(groundpos))
		{
			self.var_d6acaac4 = groundpos;
			pos = groundpos + (0, 0, randomintrange(150, 300));
			pos = getclosestpointonnavvolume(pos, "navvolume_small", 2000);
			if(isdefined(pos))
			{
				var_3a364b6c = distance(self.protectdest, pos);
				if(var_3a364b6c > 256)
				{
					protectdest = function_1c4cd527(pos, self.owner, 32, 256, 48, 48);
					if(isdefined(protectdest))
					{
						self.protectdest = protectdest;
					}
				}
			}
		}
	}
	return protectdest;
}

/*
	Name: function_5ebe7443
	Namespace: lead_drone
	Checksum: 0xFDDCB625
	Offset: 0x1C08
	Size: 0xCE
	Parameters: 0
	Flags: Linked
*/
function function_5ebe7443()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.protectdest))
		{
			/#
				recordsphere(self.protectdest, 8, (0, 0, 1), "");
			#/
			if(isdefined(self.var_d6acaac4))
			{
				/#
					recordsphere(self.protectdest, 8, (0, 1, 0), "");
					recordline(self.protectdest, self.var_d6acaac4, (0, 1, 0), "");
				#/
			}
		}
		waitframe(1);
	}
}

/*
	Name: state_combat_update
	Namespace: lead_drone
	Checksum: 0xDC1981C3
	Offset: 0x1CE0
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function state_combat_update(params)
{
	self endon(#"change_state", #"death");
	self thread function_5ebe7443();
	self thread function_a205de0d();
	for(;;)
	{
		if(isdefined(self.ignoreall) && self.ignoreall)
		{
			wait(1);
			continue;
		}
		if(isdefined(self.owner) && isdefined(level.var_fdf0dff2) && ![[level.var_fdf0dff2]](self.owner))
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
		protectdest = function_ede09a4e(self.owner);
		if(isdefined(protectdest))
		{
			self function_a57c34b7(protectdest, 1, 1);
		}
		wait(1);
	}
}

/*
	Name: state_combat_exit
	Namespace: lead_drone
	Checksum: 0xC11A1B37
	Offset: 0x1E68
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function state_combat_exit(params)
{
	self notify(#"end_attack_thread");
	self notify(#"end_movement_thread");
	self turretcleartarget(0);
}

/*
	Name: function_9bbb40ab
	Namespace: lead_drone
	Checksum: 0xD88EB316
	Offset: 0x1EB8
	Size: 0x30A
	Parameters: 15
	Flags: Linked
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
	Namespace: lead_drone
	Checksum: 0x5FECCC73
	Offset: 0x21D0
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function destroyed_cb(attacker, weapon)
{
}

/*
	Name: low_health_cb
	Namespace: lead_drone
	Checksum: 0xA25CE08F
	Offset: 0x21F0
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function low_health_cb(attacker, weapon)
{
	if(self.playeddamaged == 0)
	{
		self killstreaks::play_pilot_dialog_on_owner("damaged", "drone_squadron", self.killstreak_id);
		self.playeddamaged = 1;
	}
}

