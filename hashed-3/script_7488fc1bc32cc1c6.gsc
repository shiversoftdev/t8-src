// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace wasp;

/*
	Name: function_89f2df9
	Namespace: wasp
	Checksum: 0xA99098A9
	Offset: 0x280
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"wasp", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wasp
	Checksum: 0x8D4F78E2
	Offset: 0x2C8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_main_callback("wasp", &wasp_initialize);
	clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int");
	level thread wasp_towers_on_load();
}

/*
	Name: wasp_initialize
	Namespace: wasp
	Checksum: 0xD11DCC2A
	Offset: 0x348
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function wasp_initialize()
{
	self useanimtree("generic");
	vehicle::make_targetable(self);
	self.health = self.healthdefault;
	self vehicle::friendly_fire_shield();
	self enableaimassist();
	self setneargoalnotifydist(40);
	self sethoverparams(50, 100, 100);
	self.fovcosine = 0;
	self.fovcosinebusy = 0;
	self.vehaircraftcollisionenabled = 1;
	/#
		assert(isdefined(self.scriptbundlesettings));
	#/
	self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	self.goalradius = 999999;
	self.goalheight = 999999;
	if(issentient(self) && ispathfinder(self))
	{
		self setgoal(self.origin, 0, self.goalradius, self.goalheight);
	}
	else
	{
		self setgoal(self.origin, 1, 0);
	}
	self.variant = "mg";
	if(issubstr(self.scriptvehicletype, "rocket"))
	{
		self.variant = "rocket";
	}
	self.overridevehicledamage = &drone_callback_damage;
	self.allowfriendlyfiredamageoverride = &drone_allowfriendlyfiredamage;
	self thread vehicle_ai::nudge_collision();
	if(isdefined(level.vehicle_initializer_cb))
	{
		[[level.vehicle_initializer_cb]](self);
	}
	init_guard_points();
	defaultrole();
}

/*
	Name: defaultrole
	Namespace: wasp
	Checksum: 0x1EF630B3
	Offset: 0x5D8
	Size: 0x2D4
	Parameters: 0
	Flags: Linked
*/
function defaultrole()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
	if(ispathfinder(self))
	{
		self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
		self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
		self vehicle_ai::get_state_callbacks("driving").update_func = &wasp_driving;
		self vehicle_ai::get_state_callbacks("emped").update_func = &state_emped_update;
		self vehicle_ai::add_state("guard", &state_guard_enter, &state_guard_update, &state_guard_exit);
		vehicle_ai::add_utility_connection("combat", "guard", &state_guard_can_enter);
		vehicle_ai::add_utility_connection("guard", "combat");
		vehicle_ai::add_interrupt_connection("guard", "emped", "emped");
		vehicle_ai::add_interrupt_connection("guard", "off", "shut_off");
		vehicle_ai::add_interrupt_connection("guard", "pain", "pain");
		vehicle_ai::add_interrupt_connection("guard", "driving", "enter_vehicle");
	}
	else
	{
		self vehicle_ai::get_state_callbacks("combat").update_func = &function_739ac4a0;
		self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
	}
	vehicle_ai::startinitialstate("combat");
}

/*
	Name: state_death_update
	Namespace: wasp
	Checksum: 0x6B0DEC7E
	Offset: 0x8B8
	Size: 0x3AC
	Parameters: 1
	Flags: Linked
*/
function state_death_update(params)
{
	self endon(#"death");
	if(isarray(self.followers))
	{
		foreach(follower in self.followers)
		{
			if(isdefined(follower))
			{
				follower.leader = undefined;
			}
		}
	}
	death_type = vehicle_ai::get_death_type(params);
	if(!isdefined(death_type) && isdefined(params))
	{
		if(isdefined(params.weapon))
		{
			if(params.weapon.doannihilate)
			{
				death_type = "gibbed";
			}
			else if(params.weapon.dogibbing && isdefined(params.attacker))
			{
				dist = distance(self.origin, params.attacker.origin);
				if(dist < params.weapon.maxgibdistance)
				{
					gib_chance = 1 - (dist / params.weapon.maxgibdistance);
					if(randomfloatrange(0, 2) < gib_chance)
					{
						death_type = "gibbed";
					}
				}
			}
		}
		if(isdefined(params.meansofdeath))
		{
			meansofdeath = params.meansofdeath;
			if(meansofdeath === "MOD_EXPLOSIVE" || meansofdeath === "MOD_GRENADE_SPLASH" || meansofdeath === "MOD_PROJECTILE_SPLASH" || meansofdeath === "MOD_PROJECTILE")
			{
				death_type = "gibbed";
			}
		}
	}
	if(!isdefined(death_type))
	{
		crash_style = randomint(3);
		switch(crash_style)
		{
			case 0:
			{
				if(self.hijacked === 1)
				{
					params.death_type = "gibbed";
					vehicle_ai::defaultstate_death_update(params);
				}
				else
				{
					vehicle_death::barrel_rolling_crash();
				}
				break;
			}
			case 1:
			{
				vehicle_death::plane_crash();
				break;
			}
			default:
			{
				vehicle_death::random_crash(params.vdir);
			}
		}
		self vehicle_death::deletewhensafe();
	}
	else
	{
		params.death_type = death_type;
		vehicle_ai::defaultstate_death_update(params);
	}
}

/*
	Name: state_emped_update
	Namespace: wasp
	Checksum: 0x655C1C3D
	Offset: 0xC70
	Size: 0x66C
	Parameters: 1
	Flags: Linked
*/
function state_emped_update(params)
{
	self endon(#"death", #"change_state");
	waitframe(1);
	gravity = 400;
	self notify(#"end_nudge_collision");
	empdowntime = params.param0;
	/#
		assert(isdefined(empdowntime));
	#/
	util::cooldown("emped_timer", empdowntime);
	wait(randomfloat(0.2));
	ang_vel = self getangularvelocity();
	pitch_vel = math::randomsign() * randomfloatrange(200, 250);
	yaw_vel = math::randomsign() * randomfloatrange(200, 250);
	roll_vel = math::randomsign() * randomfloatrange(200, 250);
	ang_vel = ang_vel + (pitch_vel, yaw_vel, roll_vel);
	self setangularvelocity(ang_vel);
	if(ispointinnavvolume(self.origin, "navvolume_small"))
	{
		self.position_before_fall = self.origin;
	}
	self cancelaimove();
	self setphysacceleration((0, 0, gravity * -1));
	killonimpact_speed = self.settings.killonimpact_speed;
	if(self.health <= 20)
	{
		killonimpact_speed = 1;
	}
	self fall_and_bounce(killonimpact_speed, self.settings.killonimpact_time, 1);
	self notify(#"landed");
	self setvehvelocity((0, 0, 0));
	self setphysacceleration((0, 0, (gravity * -1) * 0.1));
	self setangularvelocity((0, 0, 0));
	while(!util::iscooldownready("emped_timer"))
	{
		timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
		wait(timeleft);
	}
	self.abnormal_status.emped = 0;
	self vehicle::toggle_emp_fx(0);
	self vehicle_ai::emp_startup_fx();
	bootup_timer = 1.6;
	while(bootup_timer > 0)
	{
		self vehicle::lights_on();
		wait(0.4);
		self vehicle::lights_off();
		wait(0.4);
		bootup_timer = bootup_timer - 0.8;
	}
	self vehicle::lights_on();
	if(isdefined(self.position_before_fall))
	{
		originoffset = vectorscale((0, 0, 1), 5);
		goalpoint = self getclosestpointonnavvolume(self.origin + originoffset, 50);
		if(isdefined(goalpoint) && sighttracepassed(self.origin + originoffset, goalpoint, 0, self))
		{
			self function_a57c34b7(goalpoint, 0, 0);
			self waittilltimeout(0.3, #"near_goal", #"goal");
			if(isdefined(self.enemy) && isalive(self))
			{
				self vehlookat(self.enemy);
			}
			starttime = gettime();
			self.current_pathto_pos = self.position_before_fall;
			foundgoal = self function_a57c34b7(self.current_pathto_pos, 1, 1);
			while(!foundgoal && util::timesince(starttime) < 3)
			{
				foundgoal = self function_a57c34b7(self.current_pathto_pos, 1, 1);
				wait(0.3);
			}
			if(foundgoal)
			{
				self waittilltimeout(1, #"near_goal", #"goal");
			}
			else
			{
				self function_a57c34b7(self.origin, 1, 0);
			}
			wait(1);
			self.position_before_fall = undefined;
			self vehicle_ai::evaluate_connections();
		}
	}
	self vehicle::lights_off();
	self thread function_d34735d1();
}

/*
	Name: function_d34735d1
	Namespace: wasp
	Checksum: 0xEBFDC373
	Offset: 0x12E8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_d34735d1()
{
	self notify("5070a0b250851eba");
	self endon("5070a0b250851eba");
	self endon(#"death");
	wait(3);
	self kill();
}

/*
	Name: fall_and_bounce
	Namespace: wasp
	Checksum: 0x121B6536
	Offset: 0x1340
	Size: 0x5AE
	Parameters: 3
	Flags: Linked
*/
function fall_and_bounce(killonimpact_speed, killonimpact_time, var_666e0401 = 0)
{
	self endon(#"death", #"change_state");
	maxbouncetime = 3;
	bouncescale = 0.3;
	velocityloss = 0.3;
	maxangle = 12;
	bouncedtime = 0;
	angularvelstablizeparams = (0.3, 0.5, 0.2);
	anglesstablizeinitialscale = 0.6;
	anglesstablizeincrement = 0.2;
	fallstart = gettime();
	while(bouncedtime < maxbouncetime && lengthsquared(self.velocity) > (10 * 10))
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_collision");
		impact_vel = waitresult.velocity;
		normal = waitresult.normal;
		if(var_666e0401)
		{
			self kill();
		}
		else
		{
			if(lengthsquared(impact_vel) > (killonimpact_speed * killonimpact_speed) || (util::timesince(fallstart) > killonimpact_time && lengthsquared(impact_vel) > (killonimpact_speed * 0.8) * (killonimpact_speed * 0.8)))
			{
				self kill();
			}
			else
			{
				if(!isdefined(self.position_before_fall))
				{
					self kill();
				}
				else
				{
					fallstart = gettime();
				}
			}
		}
		oldvelocity = self.velocity;
		vel_hitdir = vectorprojection(impact_vel, normal) * -1;
		vel_hitdirup = vectorprojection(vel_hitdir, (0, 0, 1));
		velscale = min(bouncescale * (bouncedtime + 1), 0.9);
		newvelocity = (oldvelocity - vectorprojection(oldvelocity, vel_hitdir)) * (1 - velocityloss);
		newvelocity = newvelocity + (vel_hitdir * velscale);
		shouldbounce = vectordot(normal, (0, 0, 1)) > 0.76;
		if(shouldbounce)
		{
			velocitylengthsqr = lengthsquared(newvelocity);
			stablizescale = mapfloat(5 * 5, 60 * 60, 0.1, 1, velocitylengthsqr);
			ang_vel = self getangularvelocity();
			ang_vel = ang_vel * (angularvelstablizeparams * stablizescale);
			self setangularvelocity(ang_vel);
			angles = self.angles;
			anglesstablizescale = min(anglesstablizeinitialscale - (bouncedtime * anglesstablizeincrement), 0.1);
			pitch = angles[0];
			yaw = angles[1];
			roll = angles[2];
			surfaceangles = vectortoangles(normal);
			surfaceroll = surfaceangles[2];
			if(pitch < (maxangle * -1) || pitch > maxangle)
			{
				pitch = pitch * anglesstablizescale;
			}
			if(roll < (surfaceroll - maxangle) || roll > (surfaceroll + maxangle))
			{
				roll = lerpfloat(surfaceroll, roll, anglesstablizescale);
			}
			self.angles = (pitch, yaw, roll);
		}
		self setvehvelocity(newvelocity);
		self vehicle_ai::collision_fx(normal);
		if(shouldbounce)
		{
			bouncedtime++;
		}
	}
}

/*
	Name: init_guard_points
	Namespace: wasp
	Checksum: 0xDEAD018A
	Offset: 0x18F8
	Size: 0x266
	Parameters: 0
	Flags: Linked
*/
function init_guard_points()
{
	self._guard_points = [];
	if(!isdefined(self._guard_points))
	{
		self._guard_points = [];
	}
	else if(!isarray(self._guard_points))
	{
		self._guard_points = array(self._guard_points);
	}
	self._guard_points[self._guard_points.size] = (150, -110, 110);
	if(!isdefined(self._guard_points))
	{
		self._guard_points = [];
	}
	else if(!isarray(self._guard_points))
	{
		self._guard_points = array(self._guard_points);
	}
	self._guard_points[self._guard_points.size] = (150, 110, 110);
	if(!isdefined(self._guard_points))
	{
		self._guard_points = [];
	}
	else if(!isarray(self._guard_points))
	{
		self._guard_points = array(self._guard_points);
	}
	self._guard_points[self._guard_points.size] = (120, -110, 80);
	if(!isdefined(self._guard_points))
	{
		self._guard_points = [];
	}
	else if(!isarray(self._guard_points))
	{
		self._guard_points = array(self._guard_points);
	}
	self._guard_points[self._guard_points.size] = (120, 110, 80);
	if(!isdefined(self._guard_points))
	{
		self._guard_points = [];
	}
	else if(!isarray(self._guard_points))
	{
		self._guard_points = array(self._guard_points);
	}
	self._guard_points[self._guard_points.size] = (180, 0, 140);
}

/*
	Name: guard_points_debug
	Namespace: wasp
	Checksum: 0x5D00295E
	Offset: 0x1B68
	Size: 0x102
	Parameters: 0
	Flags: None
*/
function guard_points_debug()
{
	/#
		self endon(#"death");
		if(self.isdebugdrawing === 1)
		{
			return;
		}
		self.isdebugdrawing = 1;
		while(true)
		{
			foreach(point in self.debugpointsarray)
			{
				color = (1, 0, 0);
				if(ispointinnavvolume(point, ""))
				{
					color = (0, 1, 0);
				}
				debugstar(point, 5, color);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: get_guard_points
	Namespace: wasp
	Checksum: 0x93DEF103
	Offset: 0x1C78
	Size: 0x330
	Parameters: 1
	Flags: Linked
*/
function get_guard_points(owner)
{
	/#
		assert(self._guard_points.size > 0, "");
	#/
	points_array = [];
	foreach(point in self._guard_points)
	{
		offset = rotatepoint(point, owner.angles);
		worldpoint = (offset + owner.origin) + (owner getvelocity() * 0.5);
		if(ispointinnavvolume(worldpoint, "navvolume_small"))
		{
			if(!isdefined(points_array))
			{
				points_array = [];
			}
			else if(!isarray(points_array))
			{
				points_array = array(points_array);
			}
			points_array[points_array.size] = worldpoint;
		}
	}
	if(points_array.size < 1)
	{
		queryresult = positionquery_source_navigation(owner.origin + vectorscale((0, 0, 1), 50), 25, 200, 100, 1.2 * self.radius, self);
		positionquery_filter_sight(queryresult, owner.origin + vectorscale((0, 0, 1), 10), (0, 0, 0), self, 3);
		foreach(point in queryresult.data)
		{
			if(point.visibility === 1 && bullettracepassed(owner.origin + vectorscale((0, 0, 1), 10), point.origin, 0, self, self, 0, 1))
			{
				if(!isdefined(points_array))
				{
					points_array = [];
				}
				else if(!isarray(points_array))
				{
					points_array = array(points_array);
				}
				points_array[points_array.size] = point.origin;
			}
		}
	}
	return points_array;
}

/*
	Name: state_guard_can_enter
	Namespace: wasp
	Checksum: 0x158D0B9B
	Offset: 0x1FB0
	Size: 0x126
	Parameters: 3
	Flags: Linked
*/
function state_guard_can_enter(from_state, to_state, connection)
{
	if(self.enable_guard !== 1 || !isdefined(self.owner))
	{
		return false;
	}
	if(!isdefined(self.enemy) || !self seerecently(self.enemy, 3))
	{
		return true;
	}
	if(distancesquared(self.owner.origin, self.enemy.origin) > (1200 * 1200) && distancesquared(self.origin, self.enemy.origin) > (300 * 300))
	{
		return true;
	}
	if(!ispointinnavvolume(self.origin, "navvolume_small"))
	{
		return true;
	}
	return false;
}

/*
	Name: state_guard_enter
	Namespace: wasp
	Checksum: 0x9A88BC48
	Offset: 0x20E0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function state_guard_enter(params)
{
	if(self.enable_target_laser === 1)
	{
		self laseroff();
	}
	self update_main_guard();
}

/*
	Name: update_main_guard
	Namespace: wasp
	Checksum: 0x460F89A3
	Offset: 0x2138
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function update_main_guard()
{
	if(isdefined(self.owner) && !isalive(self.owner.main_guard) || self.owner.main_guard.owner !== self.owner)
	{
		self.owner.main_guard = self;
	}
}

/*
	Name: state_guard_exit
	Namespace: wasp
	Checksum: 0x7F737520
	Offset: 0x21B8
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function state_guard_exit(params)
{
	if(isdefined(self.owner) && self.owner.main_guard === self)
	{
		self.owner.main_guard = undefined;
	}
}

/*
	Name: test_get_back_point
	Namespace: wasp
	Checksum: 0xBE54CAD2
	Offset: 0x2200
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function test_get_back_point(point)
{
	if(sighttracepassed(self.origin, point, 0, self))
	{
		if(bullettracepassed(self.origin, point, 0, self, self, 0, 1))
		{
			return 1;
		}
		return 0;
	}
	return -1;
}

/*
	Name: test_get_back_queryresult
	Namespace: wasp
	Checksum: 0xB901FA0E
	Offset: 0x2270
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function test_get_back_queryresult(queryresult)
{
	getbackpoint = undefined;
	foreach(point in queryresult.data)
	{
		testresult = test_get_back_point(point.origin);
		if(testresult == 1)
		{
			return point.origin;
		}
		if(testresult == 0)
		{
			waitframe(1);
		}
	}
	return undefined;
}

/*
	Name: state_guard_update
	Namespace: wasp
	Checksum: 0x3CA0CC9
	Offset: 0x2350
	Size: 0x848
	Parameters: 1
	Flags: Linked
*/
function state_guard_update(params)
{
	self endon(#"death", #"change_state");
	self sethoverparams(20, 40, 30);
	timenotatgoal = gettime();
	pointindex = 0;
	stuckcount = 0;
	while(true)
	{
		if(isdefined(self.enemy) && distancesquared(self.owner.origin, self.enemy.origin) < (1000 * 1000) && self seerecently(self.enemy, 1) && ispointinnavvolume(self.origin, "navvolume_small"))
		{
			self vehicle_ai::evaluate_connections();
			wait(1);
		}
		else
		{
			owner = self.owner;
			if(!isdefined(owner))
			{
				wait(1);
				continue;
			}
			usepathfinding = 1;
			onnavvolume = ispointinnavvolume(self.origin, "navvolume_small");
			if(!onnavvolume)
			{
				getbackpoint = undefined;
				pointonnavvolume = self getclosestpointonnavvolume(self.origin, 500);
				if(isdefined(pointonnavvolume))
				{
					if(test_get_back_point(pointonnavvolume) == 1)
					{
						getbackpoint = pointonnavvolume;
					}
				}
				if(!isdefined(getbackpoint))
				{
					queryresult = positionquery_source_navigation(self.origin, 0, 1500, 200, 80, self);
					getbackpoint = test_get_back_queryresult(queryresult);
				}
				if(!isdefined(getbackpoint))
				{
					queryresult = positionquery_source_navigation(self.origin, 0, 300, 700, 30, self);
					getbackpoint = test_get_back_queryresult(queryresult);
				}
				if(isdefined(getbackpoint))
				{
					if(distancesquared(getbackpoint, self.origin) > 20 * 20)
					{
						self.current_pathto_pos = getbackpoint;
						usepathfinding = 0;
						self.vehaircraftcollisionenabled = 0;
					}
					else
					{
						onnavvolume = 1;
					}
				}
				else
				{
					stuckcount++;
					if(stuckcount == 1)
					{
						stucklocation = self.origin;
					}
					else if(stuckcount > 10)
					{
						/#
							/#
								assert(0, "" + self.origin);
							#/
							v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
							v_box_max = (self.radius, self.radius, self.radius);
							box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
							if(isdefined(stucklocation))
							{
								line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
							}
						#/
						self kill();
					}
				}
			}
			if(onnavvolume)
			{
				self update_main_guard();
				if(owner.main_guard === self)
				{
					guardpoints = get_guard_points(owner);
					if(guardpoints.size < 1)
					{
						wait(1);
						continue;
					}
					stuckcount = 0;
					self.vehaircraftcollisionenabled = 1;
					if(guardpoints.size <= pointindex)
					{
						pointindex = randomint(int(min(self._guard_points.size, guardpoints.size)));
						timenotatgoal = gettime();
					}
					self.current_pathto_pos = guardpoints[pointindex];
				}
				else
				{
					main_guard = owner.main_guard;
					if(isalive(main_guard) && isdefined(main_guard.current_pathto_pos))
					{
						query_position = main_guard.current_pathto_pos;
						queryresult = positionquery_source_navigation(query_position, 20, 140, 100, 20, self, 15);
						if(queryresult.data.size > 0)
						{
							self.current_pathto_pos = queryresult.data[queryresult.data.size - 1].origin;
						}
					}
				}
			}
			if(isdefined(self.current_pathto_pos))
			{
				distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
				if(!onnavvolume || distancetogoalsq > (60 * 60))
				{
					if(distancetogoalsq > 600 * 600)
					{
						self setspeed(self.settings.defaultmovespeed * 2);
					}
					else
					{
						if(distancetogoalsq < 100 * 100)
						{
							self setspeed(self.settings.defaultmovespeed * 0.3);
						}
						else
						{
							self setspeed(self.settings.defaultmovespeed);
						}
					}
					timenotatgoal = gettime();
				}
				else
				{
					if(util::timesince(timenotatgoal) > 4)
					{
						pointindex = randomint(self._guard_points.size);
						timenotatgoal = gettime();
					}
					wait(0.2);
					continue;
				}
				if(self function_a57c34b7(self.current_pathto_pos, 1, usepathfinding))
				{
					self playsound(#"veh_wasp_direction");
					self vehclearlookat();
					self notify(#"fire_stop");
					self thread path_update_interrupt();
					if(onnavvolume)
					{
						self vehicle_ai::waittill_pathing_done(1);
					}
					else
					{
						self vehicle_ai::waittill_pathing_done();
					}
				}
				else
				{
					wait(0.5);
				}
			}
			else
			{
				wait(0.5);
			}
		}
	}
}

/*
	Name: state_combat_enter
	Namespace: wasp
	Checksum: 0x6AB3363F
	Offset: 0x2BA0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function state_combat_enter(params)
{
	if(self.enable_target_laser === 1)
	{
		self laseron();
	}
	if(isdefined(self.owner) && isdefined(self.owner.enemy))
	{
		self.favoriteenemy = self.owner.enemy;
	}
	self thread turretfireupdate();
}

/*
	Name: turretfireupdate
	Namespace: wasp
	Checksum: 0x60CC05A5
	Offset: 0x2C30
	Size: 0x53C
	Parameters: 0
	Flags: Linked
*/
function turretfireupdate()
{
	self endon(#"death", #"change_state");
	isrockettype = self.variant === "rocket";
	while(true)
	{
		if(isdefined(self.enemy) && self cansee(self.enemy) && isalive(self))
		{
			if(isdefined(self.wing_drone))
			{
				foreach(drone in self.wing_drone)
				{
					drone.favoriteenemy = self.enemy;
				}
			}
			if(distancesquared(self.enemy.origin, self.origin) < ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3) * ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3))
			{
				self vehlookat(self.enemy);
				if(isrockettype)
				{
					self turretsettarget(0, self.enemy, (self.enemy getvelocity() * 0.3) - (vehicle_ai::gettargeteyeoffset(self.enemy) * 0.3));
				}
				else
				{
					self turretsettarget(0, self.enemy, (vehicle_ai::gettargeteyeoffset(self.enemy) * -1) * 0.3);
				}
				startaim = gettime();
				while(!self.turretontarget && util::timesince(startaim) < 3)
				{
					wait(0.2);
				}
				if(isdefined(self.enemy) && self.turretontarget && self.noshoot !== 1)
				{
					if(isrockettype)
					{
						for(i = 0; i < 2 && isdefined(self.enemy); i++)
						{
							self fireweapon(0, self.enemy);
							fired = 1;
							wait(0.25);
						}
					}
					else
					{
						self vehicle_ai::fire_for_time(randomfloatrange(self.settings.turret_fire_burst_min, self.settings.turret_fire_burst_max), 0, self.enemy);
					}
					if(isdefined(self.settings.turret_cooldown_max))
					{
						if(!isdefined(self.settings.turret_cooldown_min))
						{
							self.settings.turret_cooldown_min = 0;
						}
						wait(randomfloatrange(self.settings.turret_cooldown_min, self.settings.turret_cooldown_max));
					}
				}
				else if(isdefined(self.settings.turret_enemy_detect_freq))
				{
					wait(self.settings.turret_enemy_detect_freq);
				}
				self turretsettargetangles(0, vectorscale((1, 0, 0), 15));
			}
			if(isrockettype)
			{
				if(isdefined(self.enemy) && isai(self.enemy))
				{
					wait(randomfloatrange(4, 7));
				}
				else
				{
					wait(randomfloatrange(3, 5));
				}
			}
			else
			{
				if(isdefined(self.enemy) && isai(self.enemy))
				{
					wait(randomfloatrange(2, 2.5));
				}
				else
				{
					wait(randomfloatrange(0.5, 1.5));
				}
			}
		}
		else
		{
			wait(0.4);
		}
	}
}

/*
	Name: path_update_interrupt
	Namespace: wasp
	Checksum: 0xA56CC5D2
	Offset: 0x3178
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function path_update_interrupt()
{
	self endon(#"death", #"change_state", #"near_goal", #"reached_end_node");
	self notify(#"path_update_interrupt");
	self endon(#"path_update_interrupt");
	old_enemy = self.enemy;
	wait(1);
	while(true)
	{
		if(isdefined(self.current_pathto_pos))
		{
			if(distance2dsquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius)
			{
				wait(0.2);
				self notify(#"near_goal");
			}
		}
		if(isdefined(self.enemy) && isalive(self))
		{
			if(self.noshoot !== 1 && self cansee(self.enemy))
			{
				self turretsettarget(0, self.enemy);
				self vehlookat(self.enemy);
			}
			if(!isdefined(old_enemy))
			{
				self notify(#"near_goal");
			}
			else if(self.enemy != old_enemy)
			{
				self notify(#"near_goal");
			}
			if(self cansee(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < (250 * 250))
			{
				self notify(#"near_goal");
			}
		}
		wait(0.2);
	}
}

/*
	Name: wait_till_something_happens
	Namespace: wasp
	Checksum: 0x2481772F
	Offset: 0x33C0
	Size: 0x2B8
	Parameters: 1
	Flags: Linked
*/
function wait_till_something_happens(timeout)
{
	self endon(#"change_state", #"death");
	wait(0.1);
	time = timeout;
	cant_see_count = 0;
	while(time > 0)
	{
		if(isdefined(self.current_pathto_pos))
		{
			if(distancesquared(self.current_pathto_pos, self.goalpos) > self.goalradius * self.goalradius)
			{
				break;
			}
		}
		if(isdefined(self.enemy))
		{
			if(!self cansee(self.enemy))
			{
				cant_see_count++;
				if(cant_see_count >= 3)
				{
					break;
				}
			}
			else
			{
				cant_see_count = 0;
			}
			if(distance2dsquared(self.origin, self.enemy.origin) < 250 * 250)
			{
				break;
			}
			goalheight = self.enemy.origin[2] + (0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax));
			distfrompreferredheight = abs(self.origin[2] - goalheight);
			if(distfrompreferredheight > 100)
			{
				break;
			}
			if(isplayer(self.enemy) && self.enemy islookingat(self))
			{
				if(math::cointoss())
				{
					wait(randomfloatrange(0.1, 0.5));
				}
				self drop_leader();
				break;
			}
		}
		if(isdefined(self.leader) && isdefined(self.leader.current_pathto_pos))
		{
			if(distancesquared(self.origin, self.leader.current_pathto_pos) > 165 * 165)
			{
				break;
			}
		}
		wait(0.3);
		time = time - 0.3;
	}
}

/*
	Name: drop_leader
	Namespace: wasp
	Checksum: 0xD696C95E
	Offset: 0x3680
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function drop_leader()
{
	if(isdefined(self.leader))
	{
		arrayremovevalue(self.leader.followers, self);
		self.leader = undefined;
	}
}

/*
	Name: update_leader
	Namespace: wasp
	Checksum: 0xFC2E5A67
	Offset: 0x36C8
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function update_leader()
{
	if(isdefined(self.no_group) && self.no_group == 1)
	{
		return;
	}
	if(isdefined(self.leader))
	{
		return;
	}
	if(isdefined(self.followers))
	{
		self.followers = array::remove_dead(self.followers, 0);
		if(self.followers.size > 0)
		{
			return;
		}
	}
	team_mates = getaiteamarray(self.team);
	foreach(guy in team_mates)
	{
		if(isdefined(guy.archetype) && guy.archetype == "wasp")
		{
			if(isdefined(guy.leader))
			{
				continue;
			}
			if(guy == self)
			{
				continue;
			}
			if(distancesquared(self.origin, guy.origin) > 700 * 700)
			{
				continue;
			}
			if(!isdefined(guy.followers))
			{
				guy.followers = [];
			}
			if(guy.followers.size >= 2)
			{
				continue;
			}
			guy.followers[guy.followers.size] = self;
			self.leader = guy;
			break;
		}
	}
}

/*
	Name: should_fly_forward
	Namespace: wasp
	Checksum: 0xDE755E27
	Offset: 0x38B0
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function should_fly_forward(distancetogoalsq)
{
	if(self.always_face_enemy === 1)
	{
		return 0;
	}
	if(distancetogoalsq < 250 * 250)
	{
		return 0;
	}
	if(isdefined(self.enemy))
	{
		to_goal = vectornormalize(self.current_pathto_pos - self.origin);
		to_enemy = vectornormalize(self.enemy.origin - self.origin);
		dot = vectordot(to_goal, to_enemy);
		if(abs(dot) > 0.7)
		{
			return 0;
		}
	}
	if(distancetogoalsq > 400 * 400)
	{
		return randomint(100) > 25;
	}
	return randomint(100) > 50;
}

/*
	Name: function_739ac4a0
	Namespace: wasp
	Checksum: 0x1E36CDD
	Offset: 0x39F8
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function function_739ac4a0(params)
{
	self endon(#"change_state", #"death");
	self setspeed(self.settings.defaultmovespeed);
	for(;;)
	{
		var_1f2328d0 = self function_4794d6a3();
		newpos = undefined;
		isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal || (isdefined(self.overridegoalpos) && self isapproachinggoal());
		if(!isatgoal)
		{
			goalpos = var_1f2328d0.goalpos;
		}
		if(isdefined(goalpos))
		{
			self setgoal(goalpos, 1, 0);
			self.current_pathto_pos = goalpos;
		}
		wait(1);
	}
}

/*
	Name: state_combat_update
	Namespace: wasp
	Checksum: 0x114E98CB
	Offset: 0x3B38
	Size: 0x842
	Parameters: 1
	Flags: Linked
*/
function state_combat_update(params)
{
	self endon(#"change_state", #"death");
	wait(0.1);
	stuckcount = 0;
	for(;;)
	{
		self setspeed(self.settings.defaultmovespeed);
		self update_leader();
		if(isdefined(self.inpain) && self.inpain || (isdefined(self.isstunned) && self.isstunned))
		{
			wait(0.1);
			continue;
		}
		if(self.enable_guard === 1)
		{
			self vehicle_ai::evaluate_connections();
		}
		if(isdefined(self.enemy) && isalive(self))
		{
			self turretsettarget(0, self.enemy);
			self vehlookat(self.enemy);
			self wait_till_something_happens(randomfloatrange(2, 5));
		}
		if(!isdefined(self.enemy))
		{
			self vehclearlookat();
			aiarray = getaiteamarray("all");
			foreach(ai in aiarray)
			{
				self getperfectinfo(ai);
			}
			players = getplayers("all");
			foreach(player in players)
			{
				self getperfectinfo(player);
			}
			wait(1);
		}
		usepathfinding = 1;
		onnavvolume = ispointinnavvolume(self.origin, "navvolume_small");
		if(!onnavvolume)
		{
			getbackpoint = undefined;
			if(self.aggresive_navvolume_recover === 1)
			{
				self vehicle_ai::evaluate_connections();
			}
			pointonnavvolume = self getclosestpointonnavvolume(self.origin, 100);
			if(isdefined(pointonnavvolume))
			{
				if(sighttracepassed(self.origin, pointonnavvolume, 0, self))
				{
					getbackpoint = pointonnavvolume;
				}
			}
			if(!isdefined(getbackpoint))
			{
				queryresult = positionquery_source_navigation(self.origin, 0, 200, 100, 2 * self.radius, self);
				positionquery_filter_sight(queryresult, self.origin, (0, 0, 0), self, 1);
				getbackpoint = undefined;
				foreach(point in queryresult.data)
				{
					if(point.visibility === 1)
					{
						getbackpoint = point.origin;
						break;
					}
				}
			}
			if(isdefined(getbackpoint))
			{
				self.current_pathto_pos = getbackpoint;
				usepathfinding = 0;
			}
			else
			{
				stuckcount++;
				if(stuckcount == 1)
				{
					stucklocation = self.origin;
				}
				else if(stuckcount > 10)
				{
					/#
						v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
						v_box_max = (self.radius, self.radius, self.radius);
						box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
						if(isdefined(stucklocation))
						{
							line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
						}
					#/
					self kill();
				}
			}
		}
		else
		{
			stuckcount = 0;
			if(self.goalforced)
			{
				goalpos = self getclosestpointonnavvolume(self.goalpos, 100);
				if(isdefined(goalpos))
				{
					self.current_pathto_pos = goalpos;
					usepathfinding = 1;
				}
				else
				{
					self.current_pathto_pos = self.goalpos;
					usepathfinding = 0;
				}
			}
			else
			{
				if(isdefined(self.enemy))
				{
					self.current_pathto_pos = getnextmoveposition_tactical();
					usepathfinding = 1;
				}
				else
				{
					self.current_pathto_pos = getnextmoveposition_wander();
					usepathfinding = 1;
				}
			}
		}
		if(isdefined(self.current_pathto_pos))
		{
			distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
			if(!onnavvolume || distancetogoalsq > (75 * 75))
			{
				if(distancetogoalsq > 2000 * 2000)
				{
					self setspeed(self.settings.defaultmovespeed * 2);
				}
				if(self function_a57c34b7(self.current_pathto_pos, 1, usepathfinding))
				{
					if(isdefined(self.enemy))
					{
						self playsound(#"veh_wasp_direction");
					}
					else
					{
						self playsound(#"veh_wasp_vox");
					}
					if(should_fly_forward(distancetogoalsq))
					{
						self vehclearlookat();
						self notify(#"fire_stop");
						self.noshoot = 1;
					}
					self thread path_update_interrupt();
					self vehicle_ai::waittill_pathing_done();
					self.noshoot = undefined;
				}
			}
		}
	}
}

/*
	Name: getnextmoveposition_wander
	Namespace: wasp
	Checksum: 0xA3C03C07
	Offset: 0x4388
	Size: 0x2E2
	Parameters: 0
	Flags: Linked
*/
function getnextmoveposition_wander()
{
	querymultiplier = 1;
	queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 130, (3 * self.radius) * querymultiplier, self, self.radius * querymultiplier);
	positionquery_filter_distancetogoal(queryresult, self);
	vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
	self.isonnav = queryresult.centeronnav;
	best_point = undefined;
	best_score = 999999;
	foreach(point in queryresult.data)
	{
		randomscore = randomfloatrange(0, 100);
		disttooriginscore = point.disttoorigin2d * 0.2;
		point.score = point.score + (randomscore + disttooriginscore);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"disttoorigin"]))
			{
				point._scoredebug[#"disttoorigin"] = spawnstruct();
			}
			point._scoredebug[#"disttoorigin"].score = disttooriginscore;
			point._scoredebug[#"disttoorigin"].scorename = "";
		#/
		point.score = point.score + disttooriginscore;
		if(point.score > best_score)
		{
			best_score = point.score;
			best_point = point;
		}
	}
	self vehicle_ai::positionquery_debugscores(queryresult);
	if(!isdefined(best_point))
	{
		return undefined;
	}
	return best_point.origin;
}

/*
	Name: getnextmoveposition_tactical
	Namespace: wasp
	Checksum: 0x30D86FB0
	Offset: 0x4678
	Size: 0x107E
	Parameters: 0
	Flags: Linked
*/
function getnextmoveposition_tactical()
{
	if(!isdefined(self.enemy))
	{
		return self getnextmoveposition_wander();
	}
	selfdisttotarget = distance2d(self.origin, self.enemy.origin);
	gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
	closedist = 1.2 * gooddist;
	fardist = 3 * gooddist;
	querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
	preferedheightrange = 35;
	randomness = 30;
	avoid_locations = [];
	avoid_radius = 50;
	if(isalive(self.leader) && isdefined(self.leader.current_pathto_pos))
	{
		query_position = self.leader.current_pathto_pos;
		queryresult = positionquery_source_navigation(query_position, 0, 140, 100, 35, self, 25);
	}
	else
	{
		if(isalive(self.owner) && self.enable_guard === 1)
		{
			ownerorigin = self getclosestpointonnavvolume(self.owner.origin + vectorscale((0, 0, 1), 40), 50);
			if(isdefined(ownerorigin))
			{
				queryresult = positionquery_source_navigation(ownerorigin, 0, 500 * min(querymultiplier, 1.5), 130, 3 * self.radius, self);
				if(isdefined(queryresult) && isdefined(queryresult.data))
				{
					positionquery_filter_sight(queryresult, self.owner geteye(), (0, 0, 0), self, 5, self, "visowner");
					positionquery_filter_sight(queryresult, self.enemy geteye(), (0, 0, 0), self, 5, self, "visenemy");
					foreach(point in queryresult.data)
					{
						if(point.visowner === 1)
						{
							/#
								if(!isdefined(point._scoredebug))
								{
									point._scoredebug = [];
								}
								if(!isdefined(point._scoredebug[#"visowner"]))
								{
									point._scoredebug[#"visowner"] = spawnstruct();
								}
								point._scoredebug[#"visowner"].score = 300;
								point._scoredebug[#"visowner"].scorename = "";
							#/
							point.score = point.score + 300;
						}
						if(point.visenemy === 1)
						{
							/#
								if(!isdefined(point._scoredebug))
								{
									point._scoredebug = [];
								}
								if(!isdefined(point._scoredebug[#"visenemy"]))
								{
									point._scoredebug[#"visenemy"] = spawnstruct();
								}
								point._scoredebug[#"visenemy"].score = 300;
								point._scoredebug[#"visenemy"].scorename = "";
							#/
							point.score = point.score + 300;
						}
					}
				}
			}
		}
		else
		{
			queryresult = positionquery_source_navigation(self.origin, 0, 500 * min(querymultiplier, 2), 130, (3 * self.radius) * querymultiplier, self, (2.2 * self.radius) * querymultiplier);
			team_mates = getaiteamarray(self.team);
			avoid_radius = 140;
			foreach(guy in team_mates)
			{
				if(isdefined(guy.archetype) && guy.archetype == "wasp")
				{
					if(isdefined(guy.followers) && guy.followers.size > 0 && guy != self)
					{
						if(isdefined(guy.current_pathto_pos))
						{
							avoid_locations[avoid_locations.size] = guy.current_pathto_pos;
						}
					}
				}
			}
		}
	}
	if(!isdefined(queryresult) || !isdefined(queryresult.data) || queryresult.data.size == 0)
	{
		return undefined;
	}
	positionquery_filter_distancetogoal(queryresult, self);
	positionquery_filter_inclaimedlocation(queryresult, self);
	self vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
	self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
	self vehicle_ai::positionquery_filter_engagementheight(queryresult, self.enemy, self.settings.engagementheightmin, self.settings.engagementheightmax);
	best_point = undefined;
	best_score = 999999;
	foreach(point in queryresult.data)
	{
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = randomfloatrange(0, randomness);
			point._scoredebug[#"random"].scorename = "";
		#/
		point.score = point.score + randomfloatrange(0, randomness);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"engagementdist"]))
			{
				point._scoredebug[#"engagementdist"] = spawnstruct();
			}
			point._scoredebug[#"engagementdist"].score = point.distawayfromengagementarea * -1;
			point._scoredebug[#"engagementdist"].scorename = "";
		#/
		point.score = point.score + (point.distawayfromengagementarea * -1);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"height"]))
			{
				point._scoredebug[#"height"] = spawnstruct();
			}
			point._scoredebug[#"height"].score = (point.distengagementheight * -1) * 1.4;
			point._scoredebug[#"height"].scorename = "";
		#/
		point.score = point.score + ((point.distengagementheight * -1) * 1.4);
		if(point.disttoorigin2d < 120)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"tooclosetoself"]))
				{
					point._scoredebug[#"tooclosetoself"] = spawnstruct();
				}
				point._scoredebug[#"tooclosetoself"].score = (120 - point.disttoorigin2d) * -1.5;
				point._scoredebug[#"tooclosetoself"].scorename = "";
			#/
			point.score = point.score + ((120 - point.disttoorigin2d) * -1.5);
		}
		foreach(location in avoid_locations)
		{
			if(distancesquared(point.origin, location) < avoid_radius * avoid_radius)
			{
				/#
					if(!isdefined(point._scoredebug))
					{
						point._scoredebug = [];
					}
					if(!isdefined(point._scoredebug[#"tooclosetoothers"]))
					{
						point._scoredebug[#"tooclosetoothers"] = spawnstruct();
					}
					point._scoredebug[#"tooclosetoothers"].score = avoid_radius * -1;
					point._scoredebug[#"tooclosetoothers"].scorename = "";
				#/
				point.score = point.score + (avoid_radius * -1);
			}
		}
		if(point.inclaimedlocation)
		{
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"inclaimedlocation"]))
				{
					point._scoredebug[#"inclaimedlocation"] = spawnstruct();
				}
				point._scoredebug[#"inclaimedlocation"].score = -500;
				point._scoredebug[#"inclaimedlocation"].scorename = "";
			#/
			point.score = point.score + -500;
		}
		if(point.score > best_score)
		{
			best_score = point.score;
			best_point = point;
		}
	}
	self vehicle_ai::positionquery_debugscores(queryresult);
	if(!isdefined(best_point))
	{
		return undefined;
	}
	/#
		if(isdefined(getdvarint(#"hkai_debugpositionquery", 0)) && getdvarint(#"hkai_debugpositionquery", 0))
		{
			recordline(self.origin, best_point.origin, (0.3, 1, 0));
			recordline(self.origin, self.enemy.origin, (1, 0, 0.4));
		}
	#/
	return best_point.origin;
}

/*
	Name: drone_callback_damage
	Namespace: wasp
	Checksum: 0x51B46B07
	Offset: 0x5700
	Size: 0xD2
	Parameters: 15
	Flags: Linked
*/
function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
	return idamage;
}

/*
	Name: drone_allowfriendlyfiredamage
	Namespace: wasp
	Checksum: 0xC6B1C6F5
	Offset: 0x57E0
	Size: 0x86
	Parameters: 4
	Flags: Linked
*/
function drone_allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)
{
	if(isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && eattacker.archetype == #"wasp" && smeansofdeath == "MOD_EXPLOSIVE")
	{
		return true;
	}
	return false;
}

/*
	Name: wasp_driving
	Namespace: wasp
	Checksum: 0xE8A3CD7D
	Offset: 0x5870
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function wasp_driving(params)
{
	self endon(#"change_state");
	driver = self getseatoccupant(0);
	if(isplayer(driver))
	{
		clientfield::set("rocket_wasp_hijacked", 1);
	}
	if(isplayer(driver) && isdefined(self.playerdrivenversion))
	{
		self thread wasp_manage_camera_swaps();
	}
}

/*
	Name: wasp_manage_camera_swaps
	Namespace: wasp
	Checksum: 0xDF35CC82
	Offset: 0x5930
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function wasp_manage_camera_swaps()
{
	self endon(#"death", #"change_state");
	driver = self getseatoccupant(0);
	driver endon(#"disconnect");
	cam_low_type = self.vehicletype;
	cam_high_type = self.playerdrivenversion;
}

/*
	Name: wasp_towers_on_load
	Namespace: wasp
	Checksum: 0xC8D8692E
	Offset: 0x59C0
	Size: 0x150
	Parameters: 0
	Flags: Linked
*/
function wasp_towers_on_load()
{
	if(!isdefined(level.flag) || (!(isdefined(level.flag[#"load_main_complete"]) && level.flag[#"load_main_complete"])))
	{
		level waittill(#"load_main_complete");
	}
	a_wasp_towers = getentarray("all_wasp_towers", "script_noteworthy");
	foreach(wasp_tower in a_wasp_towers)
	{
		if(isdefined(wasp_tower.script_init_wasp_tower_on_load) && wasp_tower.script_init_wasp_tower_on_load && (!(isdefined(wasp_tower.b_wasp_tower_init) && wasp_tower.b_wasp_tower_init)))
		{
			_wasp_tower_init(wasp_tower);
		}
	}
}

/*
	Name: wasp_tower_init
	Namespace: wasp
	Checksum: 0x53DA738A
	Offset: 0x5B18
	Size: 0x100
	Parameters: 2
	Flags: None
*/
function wasp_tower_init(str_tower_targetnames, n_spawn_count)
{
	a_sp_wasp_towers = getentarray(str_tower_targetnames, "targetname");
	foreach(wasp_tower in a_sp_wasp_towers)
	{
		if(!(isdefined(wasp_tower.script_init_wasp_tower_on_load) && wasp_tower.script_init_wasp_tower_on_load) && (!(isdefined(wasp_tower.b_wasp_tower_init) && wasp_tower.b_wasp_tower_init)))
		{
			_wasp_tower_init(wasp_tower, n_spawn_count);
		}
	}
}

/*
	Name: _wasp_tower_init
	Namespace: wasp
	Checksum: 0xF7EEEBEE
	Offset: 0x5C20
	Size: 0x14E
	Parameters: 2
	Flags: Linked, Private
*/
function private _wasp_tower_init(wasp_tower, n_spawn_count)
{
	if(!isspawner(wasp_tower) || wasp_tower.script_noteworthy !== "all_wasp_towers")
	{
		return;
	}
	if(isdefined(n_spawn_count))
	{
		wasp_tower.script_wasp_tower_spawn_count = n_spawn_count;
	}
	wasp_tower.a_fxanims = struct::get_array(wasp_tower.target, "targetname");
	foreach(s_fxanim in wasp_tower.a_fxanims)
	{
		scene::add_scene_func(s_fxanim.scriptbundlename, &function_bbe2568c, "done");
		s_fxanim scene::init();
	}
	wasp_tower.b_wasp_tower_init = 1;
}

/*
	Name: wasp_tower_spawn
	Namespace: wasp
	Checksum: 0x7BDBA76F
	Offset: 0x5D78
	Size: 0x156
	Parameters: 2
	Flags: Linked, Private
*/
function private wasp_tower_spawn(sp_wasp, n_spawn_count)
{
	a_wasps = [];
	for(i = 0; i < sp_wasp.script_wasp_tower_spawn_count; i++)
	{
		vh_wasp = sp_wasp spawner::spawn(1);
		vh_wasp val::set(#"wasp_tower", "ignoreme", 1);
		vh_wasp val::set(#"wasp_tower", "ignoreall", 1);
		vh_wasp vehicle_ai::start_scripted();
		vh_wasp dontinterpolate();
		if(!isdefined(a_wasps))
		{
			a_wasps = [];
		}
		else if(!isarray(a_wasps))
		{
			a_wasps = array(a_wasps);
		}
		a_wasps[a_wasps.size] = vh_wasp;
	}
	return a_wasps;
}

/*
	Name: wasp_tower_launch
	Namespace: wasp
	Checksum: 0xF4D5279C
	Offset: 0x5ED8
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function wasp_tower_launch(str_tower_targetnames, n_spawn_count)
{
	a_sp_wasp_towers = getentarray(str_tower_targetnames, "targetname");
	foreach(wasp_tower in a_sp_wasp_towers)
	{
		if(!(isdefined(wasp_tower.b_wasp_tower_init) && wasp_tower.b_wasp_tower_init))
		{
			_wasp_tower_init(wasp_tower, n_spawn_count);
		}
		_wasp_tower_launch(wasp_tower);
	}
}

/*
	Name: _wasp_tower_launch
	Namespace: wasp
	Checksum: 0x1EA6DDD
	Offset: 0x5FD0
	Size: 0x1B8
	Parameters: 1
	Flags: Linked, Private
*/
function private _wasp_tower_launch(wasp_tower)
{
	wasp_tower playsound(#"veh_wasp_tower_flaps");
	foreach(s_fxanim in wasp_tower.a_fxanims)
	{
		if(isdefined(wasp_tower.script_wasp_tower_launch_delay_min) && isdefined(wasp_tower.script_wasp_tower_launch_delay_max) && wasp_tower.script_wasp_tower_launch_delay_max > wasp_tower.script_wasp_tower_launch_delay_min)
		{
			n_delay = randomfloatrange(wasp_tower.script_wasp_tower_launch_delay_min, wasp_tower.script_wasp_tower_launch_delay_max);
		}
		else
		{
			if(isdefined(wasp_tower.script_wasp_tower_launch_delay_min))
			{
				n_delay = wasp_tower.script_wasp_tower_launch_delay_min;
			}
			else
			{
				n_delay = randomfloatrange(0, 1);
			}
		}
		wait(n_delay);
		a_wasps = wasp_tower_spawn(wasp_tower, wasp_tower.var_ea0f728d);
		if(a_wasps.size)
		{
			array::thread_all(a_wasps, &wasp_tower_wakeup);
			s_fxanim thread scene::play(a_wasps);
		}
	}
}

/*
	Name: function_bbe2568c
	Namespace: wasp
	Checksum: 0xF1EEF697
	Offset: 0x6190
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_bbe2568c(a_ents)
{
	foreach(ent in a_ents)
	{
		if(ent.archetype === "wasp")
		{
			v_pos = ent getclosestpointonnavvolume(ent.origin, 128);
			if(isdefined(v_pos))
			{
				ent.origin = v_pos;
			}
		}
	}
}

/*
	Name: wasp_tower_wakeup
	Namespace: wasp
	Checksum: 0xD7F928D
	Offset: 0x6268
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private wasp_tower_wakeup()
{
	self endon(#"death");
	self notify(#"wasp_launched_from_tower");
	self vehicle_ai::stop_scripted();
	wait(3);
	self val::reset(#"wasp_tower", "ignoreme");
	self val::reset(#"wasp_tower", "ignoreall");
}

/*
	Name: wasp_tower_launch_single
	Namespace: wasp
	Checksum: 0xD03DFB1A
	Offset: 0x6310
	Size: 0x58
	Parameters: 0
	Flags: None
*/
function wasp_tower_launch_single()
{
	if(!(isdefined(self.b_wasp_tower_init) && self.b_wasp_tower_init))
	{
		_wasp_tower_init(self, 1);
	}
	_wasp_tower_launch(self);
	return self.a_wasps[0];
}

/*
	Name: wasp_tower_destroy
	Namespace: wasp
	Checksum: 0x9DA8B310
	Offset: 0x6370
	Size: 0x278
	Parameters: 2
	Flags: None
*/
function wasp_tower_destroy(str_targetname, str_fxanim_destruction)
{
	a_sp_wasp_towers = getentarray(str_targetname, "targetname");
	foreach(sp_wasp_tower in a_sp_wasp_towers)
	{
		if(isdefined(sp_wasp_tower.b_wasp_tower_init) && sp_wasp_tower.b_wasp_tower_init && (!(isdefined(sp_wasp_tower.b_is_destroyed) && sp_wasp_tower.b_is_destroyed)))
		{
			a_mdl_tower_parts = getentarray(sp_wasp_tower.target, "targetname");
			array::delete_all(a_mdl_tower_parts);
			foreach(fxanim in sp_wasp_tower.a_fxanims)
			{
				if(isdefined(fxanim.scene_ents))
				{
					foreach(ent in fxanim.scene_ents)
					{
						if(isentity(ent) && !isai(ent))
						{
							ent delete();
						}
					}
				}
			}
			sp_wasp_tower.b_is_destroyed = 1;
			if(isdefined(str_fxanim_destruction))
			{
				level scene::play(str_fxanim_destruction);
			}
		}
	}
}

