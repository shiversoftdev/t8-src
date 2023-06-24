// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\statemachine_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace vehicle_ai;

/*
	Name: __init__system__
	Namespace: vehicle_ai
	Checksum: 0x68A0FBD6
	Offset: 0x290
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"vehicle_ai", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: vehicle_ai
	Checksum: 0x8C7FC716
	Offset: 0x2D8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	animation::add_notetrack_func("vehicle_ai::SetRotorSpeedCallback", &function_7ae52016);
}

/*
	Name: entityisarchetype
	Namespace: vehicle_ai
	Checksum: 0x909BBA52
	Offset: 0x310
	Size: 0xB6
	Parameters: 2
	Flags: None
*/
function entityisarchetype(entity, archetype)
{
	if(!isdefined(entity))
	{
		return false;
	}
	if(isplayer(entity) && entity.usingvehicle && isdefined(entity.viewlockedentity) && entity.viewlockedentity.archetype === archetype)
	{
		return true;
	}
	if(isvehicle(entity) && entity.archetype === archetype)
	{
		return true;
	}
	return false;
}

/*
	Name: getenemytarget
	Namespace: vehicle_ai
	Checksum: 0x8DD49E0C
	Offset: 0x3D0
	Size: 0x52
	Parameters: 0
	Flags: None
*/
function getenemytarget()
{
	if(isdefined(self.enemy) && self cansee(self.enemy))
	{
		return self.enemy;
	}
	if(isdefined(self.enemylastseenpos))
	{
		return self.enemylastseenpos;
	}
	return undefined;
}

/*
	Name: gettargetpos
	Namespace: vehicle_ai
	Checksum: 0x4CEE4CBD
	Offset: 0x430
	Size: 0xFA
	Parameters: 2
	Flags: None
*/
function gettargetpos(target, geteye)
{
	pos = undefined;
	if(isdefined(target))
	{
		if(isvec(target))
		{
			pos = target;
		}
		else
		{
			if(isdefined(geteye) && geteye && issentient(target))
			{
				pos = target geteye();
			}
			else
			{
				if(isentity(target))
				{
					pos = target.origin;
				}
				else if(isdefined(target.origin) && isvec(target.origin))
				{
					pos = target.origin;
				}
			}
		}
	}
	return pos;
}

/*
	Name: gettargeteyeoffset
	Namespace: vehicle_ai
	Checksum: 0x2A5EA19A
	Offset: 0x538
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function gettargeteyeoffset(target)
{
	offset = (0, 0, 0);
	if(isdefined(target) && issentient(target))
	{
		offset = target geteye() - target.origin;
	}
	return offset;
}

/*
	Name: fire_for_time
	Namespace: vehicle_ai
	Checksum: 0x54E71CFA
	Offset: 0x5A8
	Size: 0x1C4
	Parameters: 4
	Flags: Linked
*/
function fire_for_time(totalfiretime, turretidx = 0, target, intervalscale = 1)
{
	self endon(#"death", #"change_state");
	self notify("fire_stop" + turretidx);
	self endon("fire_stop" + turretidx);
	weapon = self seatgetweapon(turretidx);
	if(!isdefined(weapon) || weapon.name == #"none" || weapon.firetime <= 0)
	{
		/#
			println(((("" + turretidx) + "") + self getentnum() + "") + self.model);
		#/
		return;
	}
	firetime = weapon.firetime * intervalscale;
	firecount = (int(floor(totalfiretime / firetime))) + 1;
	__fire_for_rounds_internal(firecount, firetime, turretidx, target);
}

/*
	Name: fire_for_rounds
	Namespace: vehicle_ai
	Checksum: 0x4A24BF69
	Offset: 0x778
	Size: 0x13C
	Parameters: 3
	Flags: Linked
*/
function fire_for_rounds(firecount, turretidx, target)
{
	self endon(#"death", #"fire_stop", #"change_state");
	if(!isdefined(turretidx))
	{
		turretidx = 0;
	}
	weapon = self seatgetweapon(turretidx);
	if(!isdefined(weapon) || weapon.name == #"none" || weapon.firetime <= 0)
	{
		/#
			println(((("" + turretidx) + "") + self getentnum() + "") + self.model);
		#/
		return;
	}
	__fire_for_rounds_internal(firecount, weapon.firetime, turretidx, target);
}

/*
	Name: __fire_for_rounds_internal
	Namespace: vehicle_ai
	Checksum: 0xF783ABA3
	Offset: 0x8C0
	Size: 0x10C
	Parameters: 4
	Flags: Linked
*/
function __fire_for_rounds_internal(firecount, fireinterval, turretidx, target)
{
	self endon(#"death", #"fire_stop", #"change_state");
	/#
		assert(isdefined(turretidx));
	#/
	if(isdefined(target))
	{
		target endon(#"death");
	}
	counter = 0;
	while(counter < firecount)
	{
		if(self.avoid_shooting_owner === 1 && self owner_in_line_of_fire())
		{
			wait(fireinterval);
			continue;
		}
		self fireturret(turretidx, target);
		counter++;
		wait(fireinterval);
	}
}

/*
	Name: owner_in_line_of_fire
	Namespace: vehicle_ai
	Checksum: 0x169EA843
	Offset: 0x9D8
	Size: 0x128
	Parameters: 0
	Flags: Linked
*/
function owner_in_line_of_fire()
{
	if(!isdefined(self.owner))
	{
		return 0;
	}
	dist_squared_to_owner = distancesquared(self.owner.origin, self.origin);
	line_of_fire_dot = (dist_squared_to_owner < 9216 ? 0.866 : 0.9848);
	gun_angles = self gettagangles((isdefined(self.avoid_shooting_owner_ref_tag) ? self.avoid_shooting_owner_ref_tag : "tag_flash"));
	if(!isdefined(gun_angles))
	{
		return 0;
	}
	gun_forward = anglestoforward(gun_angles);
	dot = vectordot(gun_forward, vectornormalize(self.owner.origin - self.origin));
	return dot > line_of_fire_dot;
}

/*
	Name: setturrettarget
	Namespace: vehicle_ai
	Checksum: 0xDF148B49
	Offset: 0xB08
	Size: 0x5C
	Parameters: 3
	Flags: Linked
*/
function setturrettarget(target, turretidx = 0, offset = (0, 0, 0))
{
	self turretsettarget(turretidx, target, offset);
}

/*
	Name: fireturret
	Namespace: vehicle_ai
	Checksum: 0x35BF9929
	Offset: 0xB70
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function fireturret(turretidx, target, offset = (0, 0, 0))
{
	self fireweapon(turretidx, target, offset, self);
}

/*
	Name: airfollow
	Namespace: vehicle_ai
	Checksum: 0x758F0656
	Offset: 0xBC8
	Size: 0x122
	Parameters: 1
	Flags: None
*/
function airfollow(target)
{
	/#
		assert(isairborne(self));
	#/
	if(!isdefined(target))
	{
		return;
	}
	if(isdefined(self.host))
	{
		arrayremovevalue(self.host.airfollowers, self);
	}
	self.host = target;
	if(!isdefined(target.airfollowers))
	{
		target.airfollowers = [];
	}
	if(!isdefined(target.airfollowers))
	{
		target.airfollowers = [];
	}
	else if(!isarray(target.airfollowers))
	{
		target.airfollowers = array(target.airfollowers);
	}
	target.airfollowers[target.airfollowers.size] = self;
}

/*
	Name: getairfollowindex
	Namespace: vehicle_ai
	Checksum: 0xD5073183
	Offset: 0xCF8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function getairfollowindex()
{
	/#
		assert(isairborne(self));
	#/
	if(!isdefined(self.host))
	{
		return undefined;
	}
	for(i = 0; i < self.host.airfollowers.size; i++)
	{
		if(self === self.host.airfollowers[i])
		{
			return i;
		}
	}
	return undefined;
}

/*
	Name: getairfollowingposition
	Namespace: vehicle_ai
	Checksum: 0xA4A4614A
	Offset: 0xD98
	Size: 0x1D8
	Parameters: 1
	Flags: None
*/
function getairfollowingposition(userelativeangletohost)
{
	/#
		assert(isairborne(self));
	#/
	index = self getairfollowindex();
	if(!isdefined(index))
	{
		return undefined;
	}
	offset = getairfollowingoffset(self.host, index);
	if(!isdefined(offset))
	{
		return undefined;
	}
	origin = getairfollowingorigin();
	if(!userelativeangletohost)
	{
		return origin + offset;
	}
	angles = undefined;
	if(isdefined(self.host.airfollowconfig) && self.host.airfollowconfig.tag !== "")
	{
		angles = self.host gettagangles(self.host.airfollowconfig.tag);
	}
	else
	{
		if(isplayer(self.host))
		{
			angles = self.host getplayerangles();
		}
		else
		{
			angles = self.host.angles;
		}
	}
	yawangles = (0, angles[1], 0);
	newoffset = rotatepoint(offset, yawangles);
	return origin + newoffset;
}

/*
	Name: getairfollowingorigin
	Namespace: vehicle_ai
	Checksum: 0x2F5CDF8A
	Offset: 0xF78
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function getairfollowingorigin()
{
	/#
		assert(isairborne(self));
	#/
	origin = (self.host.origin + self.host.mins) + self.host.maxs;
	if(isdefined(self.host.airfollowconfig) && self.host.airfollowconfig.tag !== "")
	{
		origin = self.host gettagorigin(self.host.airfollowconfig.tag);
	}
	return origin;
}

/*
	Name: getairfollowinglength
	Namespace: vehicle_ai
	Checksum: 0x631AA9CA
	Offset: 0x1060
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function getairfollowinglength(targetent)
{
	distance = undefined;
	if(isdefined(targetent) && isdefined(targetent.airfollowconfig))
	{
		distance = targetent.airfollowconfig.distance;
	}
	else
	{
		size = self.host.maxs - self.host.mins;
		distance = 0.5 * length(size);
		distance = 0.5 * (distance + size[2]);
	}
	return distance;
}

/*
	Name: getairfollowingoffset
	Namespace: vehicle_ai
	Checksum: 0x843B4FBD
	Offset: 0x1128
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function getairfollowingoffset(targetent, index)
{
	numberofpoints = 8;
	pitchrange = 90;
	if(isdefined(targetent) && isdefined(targetent.airfollowconfig))
	{
		numberofpoints = targetent.airfollowconfig.numberofpoints;
		pitchrange = targetent.airfollowconfig.pitchrange;
	}
	distance = getairfollowinglength(targetent);
	if(index >= numberofpoints)
	{
		return undefined;
	}
	dir = math::point_on_sphere_even_distribution(pitchrange, index, numberofpoints);
	return dir * distance;
}

/*
	Name: javelin_losetargetatrighttime
	Namespace: vehicle_ai
	Checksum: 0x86726EF
	Offset: 0x1210
	Size: 0x150
	Parameters: 2
	Flags: None
*/
function javelin_losetargetatrighttime(target, gunnerindex)
{
	self endon(#"death");
	if(isdefined(gunnerindex))
	{
		firedgunnerindex = -1;
		while(firedgunnerindex != gunnerindex)
		{
			waitresult = undefined;
			waitresult = self waittill(#"gunner_weapon_fired");
			firedgunnerindex = waitresult.gunner_index;
			projarray = waitresult.projectile;
		}
	}
	else
	{
		waitresult = undefined;
		waitresult = self waittill(#"weapon_fired");
		projarray = waitresult.projectile;
	}
	if(!isdefined(projarray))
	{
		return;
	}
	foreach(proj in projarray)
	{
		self thread javelin_losetargetatrighttimeprojectile(proj, target);
	}
}

/*
	Name: javelin_losetargetatrighttimeprojectile
	Namespace: vehicle_ai
	Checksum: 0x50164E28
	Offset: 0x1368
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function javelin_losetargetatrighttimeprojectile(proj, target)
{
	self endon(#"death");
	proj endon(#"death");
	wait(2);
	sound_played = undefined;
	while(isdefined(target))
	{
		if(proj getvelocity()[2] < -150)
		{
			distsq = distancesquared(proj.origin, target.origin);
			if(!isdefined(sound_played) && distsq <= (1400 * 1400))
			{
				proj playsound(#"prj_quadtank_javelin_incoming");
				sound_played = 1;
			}
			if(distsq < 1200 * 1200)
			{
				proj missile_settarget(undefined);
				break;
			}
		}
		wait(0.1);
	}
}

/*
	Name: waittill_pathing_done
	Namespace: vehicle_ai
	Checksum: 0x5A366B70
	Offset: 0x1498
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function waittill_pathing_done(maxtime = 15)
{
	self endon(#"change_state");
	result = undefined;
	result = self waittilltimeout(maxtime, #"near_goal", #"force_goal", #"reached_end_node", #"pathfind_failed");
}

/*
	Name: waittill_pathresult
	Namespace: vehicle_ai
	Checksum: 0x9F7CE979
	Offset: 0x1528
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function waittill_pathresult(maxtime = 0.5)
{
	self endon(#"change_state");
	result = undefined;
	result = self waittilltimeout(maxtime, #"pathfind_failed", #"pathfind_succeeded", #"change_state");
	succeeded = result === "pathfind_succeeded";
	return succeeded;
}

/*
	Name: waittill_asm_terminated
	Namespace: vehicle_ai
	Checksum: 0x3463B408
	Offset: 0x15C8
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function waittill_asm_terminated()
{
	self endon(#"death");
	self notify(#"end_asm_terminated_thread");
	self endon(#"end_asm_terminated_thread");
	self waittill(#"asm_terminated");
	self notify(#"asm_complete", {#substate:"__terminated__"});
}

/*
	Name: waittill_asm_timeout
	Namespace: vehicle_ai
	Checksum: 0xABB4BBA
	Offset: 0x1650
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function waittill_asm_timeout(timeout)
{
	self endon(#"death");
	self notify(#"end_asm_timeout_thread");
	self endon(#"end_asm_timeout_thread");
	wait(timeout);
	self notify(#"asm_complete", {#substate:"__timeout__"});
}

/*
	Name: waittill_asm_complete
	Namespace: vehicle_ai
	Checksum: 0x1FEA4B30
	Offset: 0x16D8
	Size: 0x10E
	Parameters: 2
	Flags: None
*/
function waittill_asm_complete(substate_to_wait, timeout = 10)
{
	self endon(#"death");
	self thread waittill_asm_terminated();
	self thread waittill_asm_timeout(timeout);
	substate = undefined;
	while(!isdefined(substate) || (substate != substate_to_wait && substate != "__terminated__" && substate != "__timeout__"))
	{
		waitresult = undefined;
		waitresult = self waittill(#"asm_complete");
		substate = waitresult.substate;
	}
	self notify(#"end_asm_terminated_thread");
	self notify(#"end_asm_timeout_thread");
}

/*
	Name: throw_off_balance
	Namespace: vehicle_ai
	Checksum: 0x6ADCD001
	Offset: 0x17F0
	Size: 0x1DC
	Parameters: 4
	Flags: None
*/
function throw_off_balance(damagetype, hitpoint, hitdirection, hitlocationinfo)
{
	if(damagetype == "MOD_EXPLOSIVE" || damagetype == "MOD_GRENADE_SPLASH" || damagetype == "MOD_PROJECTILE_SPLASH")
	{
		self setvehvelocity(self.velocity + (vectornormalize(hitdirection) * 300));
		ang_vel = self getangularvelocity();
		ang_vel = ang_vel + (randomfloatrange(-300, 300), randomfloatrange(-300, 300), randomfloatrange(-300, 300));
		self setangularvelocity(ang_vel);
	}
	else
	{
		ang_vel = self getangularvelocity();
		yaw_vel = randomfloatrange(-320, 320);
		yaw_vel = yaw_vel + (math::sign(yaw_vel) * 150);
		ang_vel = ang_vel + (randomfloatrange(-150, 150), yaw_vel, randomfloatrange(-150, 150));
		self setangularvelocity(ang_vel);
	}
}

/*
	Name: predicted_collision
	Namespace: vehicle_ai
	Checksum: 0xA5C1CD41
	Offset: 0x19D8
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function predicted_collision()
{
	self endon(#"crash_done", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_predictedcollision");
		if(waitresult.normal[2] >= 0.6)
		{
			self notify(#"veh_collision", waitresult);
			callback::callback(#"veh_collision", waitresult);
		}
	}
}

/*
	Name: collision_fx
	Namespace: vehicle_ai
	Checksum: 0x9B1D8570
	Offset: 0x1A90
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function collision_fx(normal)
{
	tilted = normal[2] < 0.6;
	fx_origin = self.origin - (normal * (tilted ? 28 : 10));
	self playsound(#"veh_wasp_wall_imp");
}

/*
	Name: nudge_collision
	Namespace: vehicle_ai
	Checksum: 0xAB5FC523
	Offset: 0x1B18
	Size: 0x422
	Parameters: 0
	Flags: Linked
*/
function nudge_collision()
{
	self endon(#"crash_done", #"power_off_done", #"death");
	self notify(#"end_nudge_collision");
	self endon(#"end_nudge_collision");
	if(self.notsolid === 1)
	{
		return;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_collision");
		velocity = waitresult.velocity;
		normal = waitresult.normal;
		ang_vel = self getangularvelocity() * 0.5;
		self setangularvelocity(ang_vel);
		empedoroff = self get_current_state() === "emped" || self get_current_state() === "off";
		if(isalive(self) && (normal[2] < 0.6 || !empedoroff))
		{
			self setvehvelocity(self.velocity + (normal * 90));
			self collision_fx(normal);
		}
		else
		{
			if(empedoroff)
			{
				if(isdefined(self.bounced))
				{
					self playsound(#"veh_wasp_wall_imp");
					self setvehvelocity((0, 0, 0));
					self setangularvelocity((0, 0, 0));
					pitch = self.angles[0];
					pitch = math::sign(pitch) * math::clamp(abs(pitch), 10, 15);
					self.angles = (pitch, self.angles[1], self.angles[2]);
					self.bounced = undefined;
					self notify(#"landed");
					return;
				}
				self.bounced = 1;
				self setvehvelocity(self.velocity + (normal * 30));
				self collision_fx(normal);
			}
			else
			{
				impact_vel = abs(vectordot(velocity, normal));
				if(normal[2] < 0.6 && impact_vel < 100)
				{
					self setvehvelocity(self.velocity + (normal * 90));
					self collision_fx(normal);
				}
				else
				{
					self playsound(#"veh_wasp_ground_death");
					self thread vehicle_death::death_fire_loop_audio();
					self notify(#"crash_done");
				}
			}
		}
	}
}

/*
	Name: level_out_for_landing
	Namespace: vehicle_ai
	Checksum: 0x65F7CE
	Offset: 0x1F48
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function level_out_for_landing()
{
	self endon(#"death", #"change_state", #"landed");
	while(true)
	{
		velocity = self.velocity;
		self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
		ang_vel = self getangularvelocity() * 0.85;
		self setangularvelocity(ang_vel);
		self setvehvelocity(velocity + (vectorscale((0, 0, -1), 60)));
		waitframe(1);
	}
}

/*
	Name: immolate
	Namespace: vehicle_ai
	Checksum: 0x32E8A3BD
	Offset: 0x2050
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function immolate(attacker)
{
	self endon(#"death");
	self thread burning_thread(attacker, attacker);
}

/*
	Name: burning_thread
	Namespace: vehicle_ai
	Checksum: 0xBEF56D87
	Offset: 0x2098
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function burning_thread(attacker, inflictor)
{
	self endon(#"death");
	self notify(#"end_immolating_thread");
	self endon(#"end_immolating_thread");
	damagepersecond = self.settings.burn_damagepersecond;
	if(!isdefined(damagepersecond) || damagepersecond <= 0)
	{
		return;
	}
	secondsperonedamage = 1 / float(damagepersecond);
	if(!isdefined(self.abnormal_status))
	{
		self.abnormal_status = spawnstruct();
	}
	if(self.abnormal_status.burning !== 1)
	{
		self vehicle::toggle_burn_fx(1);
	}
	self.abnormal_status.burning = 1;
	self.abnormal_status.attacker = attacker;
	self.abnormal_status.inflictor = inflictor;
	lastingtime = self.settings.burn_lastingtime;
	if(!isdefined(lastingtime))
	{
		lastingtime = 999999;
	}
	starttime = gettime();
	interval = max(secondsperonedamage, 0.5);
	damage = 0;
	while(util::timesince(starttime) < lastingtime)
	{
		previoustime = gettime();
		wait(interval);
		damage = damage + (util::timesince(previoustime) * damagepersecond);
		damageint = int(damage);
		self dodamage(damageint, self.origin, attacker, self, "none", "MOD_BURNED");
		damage = damage - damageint;
	}
	self.abnormal_status.burning = 0;
	self vehicle::toggle_burn_fx(0);
}

/*
	Name: iff_notifymeinnsec
	Namespace: vehicle_ai
	Checksum: 0xB07686C8
	Offset: 0x2330
	Size: 0x36
	Parameters: 2
	Flags: Linked
*/
function iff_notifymeinnsec(time, note)
{
	self endon(#"death");
	wait(time);
	self notify(note);
}

/*
	Name: iff_override
	Namespace: vehicle_ai
	Checksum: 0xC5AAD546
	Offset: 0x2370
	Size: 0x1E4
	Parameters: 2
	Flags: None
*/
function iff_override(owner, time = 60)
{
	self endon(#"death");
	self._iffoverride_oldteam = self.team;
	self iff_override_team_switch_behavior(owner.team);
	if(isdefined(self.iff_override_cb))
	{
		self [[self.iff_override_cb]](1);
	}
	if(isdefined(self.settings) && (!(isdefined(self.settings.iffshouldrevertteam) && self.settings.iffshouldrevertteam)))
	{
		return;
	}
	timeout = (isdefined(self.settings) ? self.settings.ifftimetillrevert : time);
	/#
		assert(timeout > 10);
	#/
	self thread iff_notifymeinnsec(timeout - 10, "iff_override_revert_warn");
	msg = undefined;
	msg = self waittilltimeout(timeout, #"iff_override_reverted");
	if(msg == "timeout")
	{
		self notify(#"iff_override_reverted");
	}
	self playsound(#"gdt_iff_deactivate");
	self iff_override_team_switch_behavior(self._iffoverride_oldteam);
	if(isdefined(self.iff_override_cb))
	{
		self [[self.iff_override_cb]](0);
	}
}

/*
	Name: iff_override_team_switch_behavior
	Namespace: vehicle_ai
	Checksum: 0xEE2052D8
	Offset: 0x2560
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function iff_override_team_switch_behavior(team)
{
	self endon(#"death");
	self val::set(#"iff_override", "ignoreme", 1);
	self start_scripted();
	self vehicle::lights_off();
	wait(0.1);
	wait(1);
	self setteam(team);
	self blink_lights_for_time(1);
	self stop_scripted();
	wait(1);
	self val::reset(#"iff_override", "ignoreme");
}

/*
	Name: blink_lights_for_time
	Namespace: vehicle_ai
	Checksum: 0x6380B819
	Offset: 0x2670
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function blink_lights_for_time(time)
{
	self endon(#"death");
	starttime = gettime();
	self vehicle::lights_off();
	wait(0.1);
	while(gettime() < starttime + (int(time * 1000)))
	{
		self vehicle::lights_off();
		wait(0.2);
		self vehicle::lights_on();
		wait(0.2);
	}
	self vehicle::lights_on();
}

/*
	Name: turnoff
	Namespace: vehicle_ai
	Checksum: 0xC6A4C5D2
	Offset: 0x2748
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function turnoff()
{
	self notify(#"shut_off");
}

/*
	Name: turnon
	Namespace: vehicle_ai
	Checksum: 0x484B2CFD
	Offset: 0x2768
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function turnon()
{
	self notify(#"start_up");
}

/*
	Name: turnoffalllightsandlaser
	Namespace: vehicle_ai
	Checksum: 0x1B884A26
	Offset: 0x2788
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function turnoffalllightsandlaser()
{
	self laseroff();
	self vehicle::lights_off();
	self vehicle::toggle_lights_group(1, 0);
	self vehicle::toggle_lights_group(2, 0);
	self vehicle::toggle_lights_group(3, 0);
	self vehicle::toggle_lights_group(4, 0);
	self vehicle::toggle_force_driver_taillights(0);
	self vehicle::toggle_burn_fx(0);
	self vehicle::toggle_emp_fx(0);
}

/*
	Name: turnoffallambientanims
	Namespace: vehicle_ai
	Checksum: 0x6391889
	Offset: 0x2870
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function turnoffallambientanims()
{
	self vehicle::toggle_ambient_anim_group(1, 0);
	self vehicle::toggle_ambient_anim_group(2, 0);
	self vehicle::toggle_ambient_anim_group(3, 0);
}

/*
	Name: clearalllookingandtargeting
	Namespace: vehicle_ai
	Checksum: 0x4E10B83E
	Offset: 0x28C8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function clearalllookingandtargeting()
{
	self turretcleartarget(0);
	self turretcleartarget(1);
	self turretcleartarget(2);
	self turretcleartarget(3);
	self turretcleartarget(4);
	self vehclearlookat();
}

/*
	Name: clearallmovement
	Namespace: vehicle_ai
	Checksum: 0x1BEC1D1F
	Offset: 0x2968
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function clearallmovement(zerooutspeed = 0)
{
	self cancelaimove();
	self function_d4c687c9();
	self pathvariableoffsetclear();
	self pathfixedoffsetclear();
	if(zerooutspeed === 1)
	{
		self notify(#"landed");
		self setvehvelocity((0, 0, 0));
		self setphysacceleration((0, 0, 0));
		self setangularvelocity((0, 0, 0));
	}
}

/*
	Name: update_damage_fx_level
	Namespace: vehicle_ai
	Checksum: 0x15275932
	Offset: 0x2A50
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function update_damage_fx_level(idamage)
{
	if(!isdefined(self.damagelevel))
	{
		self.damagelevel = 0;
		self.newdamagelevel = self.damagelevel;
	}
	newdamagelevel = vehicle::should_update_damage_fx_level(self.health, idamage, self.healthdefault);
	if(newdamagelevel > self.damagelevel)
	{
		self.newdamagelevel = newdamagelevel;
	}
	if(self.newdamagelevel > self.damagelevel)
	{
		self.damagelevel = self.newdamagelevel;
		self notify(#"pain");
		vehicle::set_damage_fx_level(self.damagelevel);
	}
}

/*
	Name: shared_callback_damage
	Namespace: vehicle_ai
	Checksum: 0xDCB55A76
	Offset: 0x2B20
	Size: 0x1E0
	Parameters: 15
	Flags: None
*/
function shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(should_emp(self, weapon, smeansofdeath, einflictor, eattacker))
	{
		minempdowntime = 0.8 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 0);
		maxempdowntime = 1.2 * (isdefined(self.settings.empdowntime) ? self.settings.empdowntime : 1);
		self notify(#"emped", {#param2:einflictor, #param1:eattacker, #param0:randomfloatrange(minempdowntime, maxempdowntime)});
	}
	if(should_burn(self, weapon, smeansofdeath, einflictor, eattacker))
	{
		self thread burning_thread(eattacker, einflictor);
	}
	self update_damage_fx_level(idamage);
	return idamage;
}

/*
	Name: should_emp
	Namespace: vehicle_ai
	Checksum: 0x15DDAC1C
	Offset: 0x2D08
	Size: 0x158
	Parameters: 5
	Flags: Linked
*/
function should_emp(vehicle, weapon, meansofdeath, einflictor, eattacker)
{
	if(!isdefined(vehicle) || meansofdeath === "MOD_IMPACT" || vehicle.disableelectrodamage === 1)
	{
		return 0;
	}
	if(!(isdefined(weapon) && weapon.isemp || meansofdeath === "MOD_ELECTROCUTED"))
	{
		return 0;
	}
	causer = (isdefined(eattacker) ? eattacker : einflictor);
	if(!isdefined(causer))
	{
		return 1;
	}
	if(isai(causer) && isvehicle(causer))
	{
		return 0;
	}
	if(level.teambased)
	{
		return vehicle.team != causer.team;
	}
	if(isdefined(vehicle.owner))
	{
		return vehicle.owner != causer;
	}
	return vehicle != causer;
}

/*
	Name: should_burn
	Namespace: vehicle_ai
	Checksum: 0x43F3812C
	Offset: 0x2E70
	Size: 0x150
	Parameters: 5
	Flags: Linked
*/
function should_burn(vehicle, weapon, meansofdeath, einflictor, eattacker)
{
	if(level.disablevehicleburndamage === 1 || vehicle.disableburndamage === 1)
	{
		return 0;
	}
	if(!isdefined(vehicle))
	{
		return 0;
	}
	if(meansofdeath !== "MOD_BURNED")
	{
		return 0;
	}
	if(vehicle === einflictor)
	{
		return 0;
	}
	causer = (isdefined(eattacker) ? eattacker : einflictor);
	if(!isdefined(causer))
	{
		return 1;
	}
	if(isai(causer) && isvehicle(causer))
	{
		return 0;
	}
	if(level.teambased)
	{
		return vehicle.team != causer.team;
	}
	if(isdefined(vehicle.owner))
	{
		return vehicle.owner != causer;
	}
	return vehicle != causer;
}

/*
	Name: startinitialstate
	Namespace: vehicle_ai
	Checksum: 0x21BEE183
	Offset: 0x2FD0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function startinitialstate(defaultstate = "combat")
{
	params = spawnstruct();
	params.isinitialstate = 1;
	if(isdefined(self.script_startstate))
	{
		self set_state(self.script_startstate, params);
	}
	else
	{
		self set_state(defaultstate, params);
	}
}

/*
	Name: start_scripted
	Namespace: vehicle_ai
	Checksum: 0x87BE41B
	Offset: 0x3078
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function start_scripted(disable_death_state, no_clear_movement)
{
	params = spawnstruct();
	params.no_clear_movement = no_clear_movement;
	self set_state("scripted", params);
	self._no_death_state = disable_death_state;
}

/*
	Name: stop_scripted
	Namespace: vehicle_ai
	Checksum: 0xB06F2BC9
	Offset: 0x30F0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function stop_scripted(statename)
{
	if(isalive(self) && is_instate("scripted"))
	{
		if(isdefined(statename))
		{
			self set_state(statename);
		}
		else
		{
			self set_state("combat");
		}
	}
}

/*
	Name: set_role
	Namespace: vehicle_ai
	Checksum: 0x9E930943
	Offset: 0x3178
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function set_role(rolename)
{
	self.current_role = rolename;
}

/*
	Name: has_state
	Namespace: vehicle_ai
	Checksum: 0xD962EFBC
	Offset: 0x31A0
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function has_state(name)
{
	/#
		assert(isdefined(self), "");
	#/
	return isdefined(self.state_machines) && isdefined(self.current_role) && isdefined(self.state_machines[self.current_role]) && self.state_machines[self.current_role] statemachine::has_state(name);
}

/*
	Name: set_state
	Namespace: vehicle_ai
	Checksum: 0xE5A19684
	Offset: 0x3230
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function set_state(name, params)
{
	if(isdefined(self.state_machines) && isdefined(self.current_role))
	{
		self.state_machines[self.current_role] thread statemachine::set_state(name, params);
	}
}

/*
	Name: evaluate_connections
	Namespace: vehicle_ai
	Checksum: 0x4BECC733
	Offset: 0x3298
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function evaluate_connections(eval_func, params)
{
	if(isdefined(self.state_machines) && isdefined(self.current_role))
	{
		self.state_machines[self.current_role] statemachine::evaluate_connections(eval_func, params);
	}
}

/*
	Name: get_state_callbacks
	Namespace: vehicle_ai
	Checksum: 0x207A1315
	Offset: 0x3300
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function get_state_callbacks(statename)
{
	rolename = "default";
	if(isdefined(self.current_role))
	{
		rolename = self.current_role;
	}
	if(isdefined(self.state_machines[rolename]))
	{
		return self.state_machines[rolename].states[statename];
	}
	return undefined;
}

/*
	Name: get_state_callbacks_for_role
	Namespace: vehicle_ai
	Checksum: 0x1E6E6A84
	Offset: 0x3370
	Size: 0x58
	Parameters: 2
	Flags: None
*/
function get_state_callbacks_for_role(rolename = "default", statename)
{
	if(isdefined(self.state_machines[rolename]))
	{
		return self.state_machines[rolename].states[statename];
	}
	return undefined;
}

/*
	Name: get_current_state
	Namespace: vehicle_ai
	Checksum: 0xCBCFB1A9
	Offset: 0x33D0
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function get_current_state()
{
	if(isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state))
	{
		return self.state_machines[self.current_role].current_state.name;
	}
	return undefined;
}

/*
	Name: get_previous_state
	Namespace: vehicle_ai
	Checksum: 0x2F670ECA
	Offset: 0x3430
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function get_previous_state()
{
	if(isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].previous_state))
	{
		return self.state_machines[self.current_role].previous_state.name;
	}
	return undefined;
}

/*
	Name: get_next_state
	Namespace: vehicle_ai
	Checksum: 0xB99CF0DE
	Offset: 0x3490
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function get_next_state()
{
	if(isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].next_state))
	{
		return self.state_machines[self.current_role].next_state.name;
	}
	return undefined;
}

/*
	Name: is_instate
	Namespace: vehicle_ai
	Checksum: 0x673E79F1
	Offset: 0x34F0
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function is_instate(statename)
{
	if(isdefined(self.current_role) && isdefined(self.state_machines[self.current_role].current_state))
	{
		return self.state_machines[self.current_role].current_state.name === statename;
	}
	return 0;
}

/*
	Name: add_state
	Namespace: vehicle_ai
	Checksum: 0x3A2E2AEF
	Offset: 0x3558
	Size: 0x8E
	Parameters: 4
	Flags: None
*/
function add_state(name, enter_func, update_func, exit_func)
{
	if(isdefined(self.current_role))
	{
		statemachine = self.state_machines[self.current_role];
		if(isdefined(statemachine))
		{
			state = statemachine statemachine::add_state(name, enter_func, update_func, exit_func);
			return state;
		}
	}
	return undefined;
}

/*
	Name: add_interrupt_connection
	Namespace: vehicle_ai
	Checksum: 0x2BC546DD
	Offset: 0x35F0
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc)
{
	self.state_machines[self.current_role] statemachine::add_interrupt_connection(from_state_name, to_state_name, on_notify, checkfunc);
}

/*
	Name: add_utility_connection
	Namespace: vehicle_ai
	Checksum: 0x2195E1DB
	Offset: 0x3650
	Size: 0x54
	Parameters: 4
	Flags: None
*/
function add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore)
{
	self.state_machines[self.current_role] statemachine::add_utility_connection(from_state_name, to_state_name, checkfunc, defaultscore);
}

/*
	Name: function_b94a7666
	Namespace: vehicle_ai
	Checksum: 0x11EB22E5
	Offset: 0x36B0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b94a7666(from_state_name, on_notify)
{
	self.state_machines[self.current_role] statemachine::function_b94a7666(from_state_name, on_notify);
}

/*
	Name: function_6c17ee49
	Namespace: vehicle_ai
	Checksum: 0x4817ED04
	Offset: 0x36F8
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_6c17ee49()
{
	if(isdefined(self.current_role))
	{
		if(isdefined(self.state_machines[self.current_role]))
		{
			return self.state_machines[self.current_role] statemachine::has_state("death");
		}
	}
	return 0;
}

/*
	Name: init_state_machine_for_role
	Namespace: vehicle_ai
	Checksum: 0xE91B9F19
	Offset: 0x3758
	Size: 0x650
	Parameters: 1
	Flags: Linked
*/
function init_state_machine_for_role(rolename = "default")
{
	statemachine = statemachine::create(rolename, self);
	statemachine.isrole = 1;
	if(!isdefined(self.current_role))
	{
		set_role(rolename);
	}
	statemachine statemachine::add_state("suspend", undefined, undefined, undefined);
	statemachine statemachine::add_state("death", &defaultstate_death_enter, &defaultstate_death_update, undefined);
	statemachine statemachine::add_state("scripted", &defaultstate_scripted_enter, undefined, &defaultstate_scripted_exit);
	statemachine statemachine::add_state("spline", undefined, undefined, &function_e0887c67);
	statemachine statemachine::add_state("combat", &defaultstate_combat_enter, undefined, &defaultstate_combat_exit);
	statemachine statemachine::add_state("emped", &defaultstate_emped_enter, &defaultstate_emped_update, &defaultstate_emped_exit, &defaultstate_emped_reenter);
	statemachine statemachine::add_state("off", &defaultstate_off_enter, undefined, &defaultstate_off_exit);
	statemachine statemachine::add_state("driving", &defaultstate_driving_enter, undefined, &defaultstate_driving_exit);
	statemachine statemachine::add_state("pain", &defaultstate_pain_enter, &function_97e9de18, &defaultstate_pain_exit);
	statemachine statemachine::add_interrupt_connection("off", "combat", "start_up");
	statemachine statemachine::add_interrupt_connection("driving", "combat", "exit_vehicle");
	statemachine statemachine::add_utility_connection("emped", "combat");
	statemachine statemachine::add_utility_connection("pain", "combat");
	statemachine statemachine::add_interrupt_connection("combat", "emped", "emped");
	statemachine statemachine::add_interrupt_connection("pain", "emped", "emped");
	statemachine statemachine::add_interrupt_connection("emped", "emped", "emped");
	statemachine statemachine::add_interrupt_connection("combat", "off", "shut_off");
	statemachine statemachine::add_interrupt_connection("emped", "off", "shut_off");
	statemachine statemachine::add_interrupt_connection("pain", "off", "shut_off");
	statemachine statemachine::add_interrupt_connection("combat", "driving", "enter_vehicle", &function_329f45a4);
	statemachine statemachine::add_interrupt_connection("emped", "driving", "enter_vehicle", &function_329f45a4);
	statemachine statemachine::add_interrupt_connection("off", "driving", "enter_vehicle", &function_329f45a4);
	statemachine statemachine::add_interrupt_connection("pain", "driving", "enter_vehicle", &function_329f45a4);
	statemachine statemachine::add_interrupt_connection("combat", "pain", "pain");
	statemachine statemachine::add_interrupt_connection("emped", "pain", "pain");
	statemachine statemachine::add_interrupt_connection("off", "pain", "pain");
	statemachine statemachine::add_interrupt_connection("driving", "pain", "pain");
	self.overridevehiclekilled = &callback_vehiclekilled;
	self.overridevehicledeathpostgame = &callback_vehiclekilled;
	statemachine thread statemachine::set_state("suspend");
	self thread on_death_cleanup();
	return statemachine;
}

/*
	Name: register_custom_add_state_callback
	Namespace: vehicle_ai
	Checksum: 0xEC3A6089
	Offset: 0x3DB0
	Size: 0x46
	Parameters: 1
	Flags: None
*/
function register_custom_add_state_callback(func)
{
	if(!isdefined(level.level_specific_add_state_callbacks))
	{
		level.level_specific_add_state_callbacks = [];
	}
	level.level_specific_add_state_callbacks[level.level_specific_add_state_callbacks.size] = func;
}

/*
	Name: call_custom_add_state_callbacks
	Namespace: vehicle_ai
	Checksum: 0x49152E99
	Offset: 0x3E00
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function call_custom_add_state_callbacks()
{
	if(isdefined(level.level_specific_add_state_callbacks))
	{
		for(i = 0; i < level.level_specific_add_state_callbacks.size; i++)
		{
			self [[level.level_specific_add_state_callbacks[i]]]();
		}
	}
}

/*
	Name: callback_vehiclekilled
	Namespace: vehicle_ai
	Checksum: 0xA78CD867
	Offset: 0x3E60
	Size: 0x11C
	Parameters: 8
	Flags: Linked
*/
function callback_vehiclekilled(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(isdefined(self._no_death_state) && self._no_death_state)
	{
		return;
	}
	death_info = spawnstruct();
	death_info.inflictor = einflictor;
	death_info.attacker = eattacker;
	death_info.damage = idamage;
	death_info.meansofdeath = smeansofdeath;
	death_info.weapon = weapon;
	death_info.dir = vdir;
	death_info.hitloc = shitloc;
	death_info.timeoffset = psoffsettime;
	self set_state("death", death_info);
}

/*
	Name: on_death_cleanup
	Namespace: vehicle_ai
	Checksum: 0x8FC8D6D7
	Offset: 0x3F88
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function on_death_cleanup()
{
	state_machines = self.state_machines;
	self waittill(#"free_vehicle");
	foreach(statemachine in state_machines)
	{
		statemachine statemachine::clear();
	}
}

/*
	Name: defaultstate_death_enter
	Namespace: vehicle_ai
	Checksum: 0xEDF391EB
	Offset: 0x4030
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function defaultstate_death_enter(params)
{
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self disableaimassist();
	turnoffalllightsandlaser();
	turnoffallambientanims();
	clearalllookingandtargeting();
	clearallmovement();
	self cancelaimove();
	self val::set(#"defaultstate_death_enter", "takedamage", 0);
	self vehicle_death::death_cleanup_level_variables();
}

/*
	Name: burning_death_fx
	Namespace: vehicle_ai
	Checksum: 0x7860DA40
	Offset: 0x4140
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function burning_death_fx()
{
	if(isdefined(self.settings.burn_death_fx_1) && isdefined(self.settings.burn_death_tag_1))
	{
		playfxontag(self.settings.burn_death_fx_1, self, self.settings.burn_death_tag_1);
	}
	if(isdefined(self.settings.burn_death_sound_1))
	{
		self playsound(self.settings.burn_death_sound_1);
	}
}

/*
	Name: emp_death_fx
	Namespace: vehicle_ai
	Checksum: 0x6D3C84CC
	Offset: 0x41E0
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function emp_death_fx()
{
	if(isdefined(self.settings.emp_death_fx_1) && isdefined(self.settings.emp_death_tag_1))
	{
		playfxontag(self.settings.emp_death_fx_1, self, self.settings.emp_death_tag_1);
	}
	if(isdefined(self.settings.emp_death_sound_1))
	{
		self playsound(self.settings.emp_death_sound_1);
	}
}

/*
	Name: death_radius_damage_special
	Namespace: vehicle_ai
	Checksum: 0x1A5D52DA
	Offset: 0x4280
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function death_radius_damage_special(radiusscale, meansofdamage)
{
	self endon(#"death");
	if(!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0)
	{
		return;
	}
	position = self.origin + vectorscale((0, 0, 1), 15);
	radius = self.radiusdamageradius * radiusscale;
	damagemax = self.radiusdamagemax;
	damagemin = self.radiusdamagemin;
	waitframe(1);
	if(isdefined(self))
	{
		self radiusdamage(position, radius, damagemax, damagemin, undefined, meansofdamage);
	}
}

/*
	Name: burning_death
	Namespace: vehicle_ai
	Checksum: 0x474C2A59
	Offset: 0x4390
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function burning_death(params)
{
	self endon(#"death");
	self burning_death_fx();
	self.skipfriendlyfirecheck = 1;
	self thread death_radius_damage_special(2, "MOD_BURNED");
	self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
	self vehicle::do_death_dynents(3);
	self vehicle_death::deletewhensafe(10);
}

/*
	Name: emped_death
	Namespace: vehicle_ai
	Checksum: 0xF2708701
	Offset: 0x4458
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function emped_death(params)
{
	self endon(#"death");
	self emp_death_fx();
	self.skipfriendlyfirecheck = 1;
	self thread death_radius_damage_special(2, "MOD_ELECTROCUTED");
	self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
	self vehicle::do_death_dynents(2);
	self vehicle_death::deletewhensafe();
}

/*
	Name: gibbed_death
	Namespace: vehicle_ai
	Checksum: 0xD569FFEA
	Offset: 0x4520
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function gibbed_death(params)
{
	self endon(#"death");
	self vehicle_death::death_fx();
	self thread vehicle_death::death_radius_damage();
	self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
	self vehicle::do_death_dynents();
	self vehicle_death::deletewhensafe();
}

/*
	Name: default_death
	Namespace: vehicle_ai
	Checksum: 0x6DFE638A
	Offset: 0x45D0
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function default_death(params)
{
	self endon(#"death");
	self vehicle_death::death_fx();
	self thread vehicle_death::death_radius_damage();
	self vehicle_death::set_death_model(self.deathmodel, self.modelswapdelay);
	if(self.classname == "script_vehicle")
	{
		self thread vehicle_death::death_jolt(self.vehicletype);
	}
	if(isdefined(level.disable_thermal))
	{
		[[level.disable_thermal]]();
	}
	waittime = (isdefined(self.waittime_before_delete) ? self.waittime_before_delete : 0);
	owner = self getvehicleowner();
	if(isdefined(owner) && self isremotecontrol())
	{
		waittime = max(waittime, 4);
	}
	util::waitfortime(waittime);
	vehicle_death::freewhensafe();
}

/*
	Name: get_death_type
	Namespace: vehicle_ai
	Checksum: 0x611F99EE
	Offset: 0x4748
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function get_death_type(params)
{
	if(self.delete_on_death === 1)
	{
		death_type = "default";
	}
	else
	{
		death_type = self.death_type;
	}
	if(!isdefined(death_type))
	{
		death_type = params.death_type;
	}
	if(!isdefined(death_type) && isdefined(self.abnormal_status) && self.abnormal_status.burning === 1)
	{
		death_type = "burning";
	}
	if(!isdefined(death_type) && (isdefined(self.abnormal_status) && self.abnormal_status.emped === 1) || (isdefined(params.weapon) && params.weapon.isemp))
	{
		death_type = "emped";
	}
	return death_type;
}

/*
	Name: defaultstate_death_update
	Namespace: vehicle_ai
	Checksum: 0x89868E58
	Offset: 0x4858
	Size: 0x182
	Parameters: 1
	Flags: Linked
*/
function defaultstate_death_update(params)
{
	self endon(#"death");
	if(isdefined(level.vehicle_destructer_cb))
	{
		[[level.vehicle_destructer_cb]](self);
	}
	if(self.delete_on_death === 1)
	{
		default_death(params);
		vehicle_death::deletewhensafe(0.25);
	}
	else
	{
		death_type = (isdefined(get_death_type(params)) ? get_death_type(params) : "default");
		switch(death_type)
		{
			case "burning":
			{
				burning_death(params);
				break;
			}
			case "emped":
			{
				emped_death(params);
				break;
			}
			case "gibbed":
			{
				gibbed_death(params);
				break;
			}
			default:
			{
				default_death(params);
				break;
			}
		}
	}
}

/*
	Name: defaultstate_scripted_enter
	Namespace: vehicle_ai
	Checksum: 0xE2C906AF
	Offset: 0x49E8
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function defaultstate_scripted_enter(params)
{
	if(params.no_clear_movement !== 1)
	{
		clearalllookingandtargeting();
		clearallmovement();
		if(hasasm(self))
		{
			self asmrequestsubstate(#"locomotion@movement");
		}
		self resumespeed();
	}
}

/*
	Name: defaultstate_scripted_exit
	Namespace: vehicle_ai
	Checksum: 0x68029277
	Offset: 0x4A88
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function defaultstate_scripted_exit(params)
{
	if(params.no_clear_movement !== 1)
	{
		clearalllookingandtargeting();
		clearallmovement();
	}
}

/*
	Name: function_e0887c67
	Namespace: vehicle_ai
	Checksum: 0x8A0DA593
	Offset: 0x4AD8
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function function_e0887c67(params)
{
	self notify(#"endpath");
	self.attachedpath = undefined;
}

/*
	Name: defaultstate_combat_enter
	Namespace: vehicle_ai
	Checksum: 0xB617588C
	Offset: 0x4B08
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function defaultstate_combat_enter(params)
{
}

/*
	Name: defaultstate_combat_exit
	Namespace: vehicle_ai
	Checksum: 0x9ED5450A
	Offset: 0x4B20
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function defaultstate_combat_exit(params)
{
}

/*
	Name: defaultstate_emped_enter
	Namespace: vehicle_ai
	Checksum: 0xDC5510F9
	Offset: 0x4B38
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function defaultstate_emped_enter(params)
{
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	params.laseron = islaseron(self);
	self laseroff();
	self vehicle::lights_off();
	clearalllookingandtargeting();
	if(!(isdefined(self.var_94e2cf87) && self.var_94e2cf87))
	{
		clearallmovement();
	}
	if(isairborne(self))
	{
		self setrotorspeed(0);
	}
	if(!isdefined(self.abnormal_status))
	{
		self.abnormal_status = spawnstruct();
	}
	self.abnormal_status.emped = 1;
	self.abnormal_status.attacker = params.param1;
	self.abnormal_status.inflictor = params.param2;
	self vehicle::toggle_emp_fx(1);
}

/*
	Name: emp_startup_fx
	Namespace: vehicle_ai
	Checksum: 0xDB3F97FC
	Offset: 0x4CD8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function emp_startup_fx()
{
	if(isdefined(self) && isdefined(self.settings) && isdefined(self.settings.emp_startup_fx_1) && isdefined(self.settings.emp_startup_tag_1))
	{
		playfxontag(self.settings.emp_startup_fx_1, self, self.settings.emp_startup_tag_1);
	}
}

/*
	Name: defaultstate_emped_update
	Namespace: vehicle_ai
	Checksum: 0x681AABC2
	Offset: 0x4D60
	Size: 0x134
	Parameters: 1
	Flags: Linked
*/
function defaultstate_emped_update(params)
{
	self endon(#"death", #"change_state");
	time = params.param0;
	/#
		assert(isdefined(time));
	#/
	util::cooldown("emped_timer", time);
	while(!util::iscooldownready("emped_timer"))
	{
		timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
		wait(timeleft);
	}
	self.abnormal_status.emped = 0;
	self vehicle::toggle_emp_fx(0);
	self emp_startup_fx();
	wait(1);
	self evaluate_connections();
}

/*
	Name: defaultstate_emped_exit
	Namespace: vehicle_ai
	Checksum: 0xC15CF893
	Offset: 0x4EA0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function defaultstate_emped_exit(params)
{
	self vehicle::toggle_tread_fx(1);
	self vehicle::toggle_exhaust_fx(1);
	self vehicle::toggle_sounds(1);
	if(params.laseron === 1)
	{
		self laseron();
	}
	self vehicle::lights_on();
}

/*
	Name: defaultstate_emped_reenter
	Namespace: vehicle_ai
	Checksum: 0xFA8CC92B
	Offset: 0x4F40
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function defaultstate_emped_reenter(params)
{
	return true;
}

/*
	Name: defaultstate_off_enter
	Namespace: vehicle_ai
	Checksum: 0xDB7D497C
	Offset: 0x4F58
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function defaultstate_off_enter(params)
{
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self vehicle::function_bbc1d940(0);
	self disableaimassist();
	params.laseron = islaseron(self);
	turnoffalllightsandlaser();
	turnoffallambientanims();
	clearalllookingandtargeting();
	clearallmovement();
	if(isdefined(level.disable_thermal))
	{
		[[level.disable_thermal]]();
	}
	if(isairborne(self))
	{
		if(params.isinitialstate !== 1 && params.no_falling !== 1)
		{
			self setphysacceleration(vectorscale((0, 0, -1), 300));
			self thread level_out_for_landing();
		}
		self setrotorspeed(0);
	}
	if(!(isdefined(params.isinitialstate) && params.isinitialstate) && (self get_previous_state() === "driving" || (isdefined(params.var_c1273f91) && params.var_c1273f91)))
	{
		self vehicle::function_7f0bbde3();
	}
}

/*
	Name: defaultstate_off_exit
	Namespace: vehicle_ai
	Checksum: 0x42624D88
	Offset: 0x5188
	Size: 0x204
	Parameters: 1
	Flags: Linked
*/
function defaultstate_off_exit(params)
{
	self vehicle::toggle_tread_fx(1);
	self vehicle::toggle_exhaust_fx(1);
	if(self get_next_state() === "driving" || (isdefined(params.var_da88902a) && params.var_da88902a))
	{
		self thread vehicle::function_fa4236af(params);
	}
	else
	{
		self vehicle::toggle_sounds(1);
	}
	self enableaimassist();
	if(isairborne(self))
	{
		self setphysacceleration((0, 0, 0));
		if(!(isdefined(params.var_1751c737) && params.var_1751c737))
		{
			self thread nudge_collision();
		}
		self setrotorspeed(1);
	}
	if(params.laseron === 1)
	{
		self laseron();
	}
	if(isdefined(level.enable_thermal))
	{
		if(self get_next_state() !== "death")
		{
			[[level.enable_thermal]]();
		}
	}
	if(!(isdefined(self.nolights) && self.nolights))
	{
		self vehicle::lights_on();
	}
	self vehicle::toggle_force_driver_taillights(0);
}

/*
	Name: function_329f45a4
	Namespace: vehicle_ai
	Checksum: 0x8A4B0E27
	Offset: 0x5398
	Size: 0xA6
	Parameters: 4
	Flags: Linked
*/
function function_329f45a4(current_state, to_state, connection, params)
{
	if(!isdefined(self))
	{
		return false;
	}
	if(isdefined(self.emped) && self.emped || (isdefined(self.jammed) && self.jammed))
	{
		return false;
	}
	driver = self getseatoccupant(0);
	if(isplayer(driver))
	{
		return true;
	}
	return false;
}

/*
	Name: function_6664e3af
	Namespace: vehicle_ai
	Checksum: 0x83E4756C
	Offset: 0x5448
	Size: 0x6E
	Parameters: 4
	Flags: None
*/
function function_6664e3af(current_state, to_state_name, connection, params)
{
	if(isalive(self))
	{
		driver = self getseatoccupant(0);
		if(!isdefined(driver))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: defaultstate_driving_enter
	Namespace: vehicle_ai
	Checksum: 0xC1620F94
	Offset: 0x54C0
	Size: 0x18C
	Parameters: 1
	Flags: Linked
*/
function defaultstate_driving_enter(params)
{
	params.driver = self getseatoccupant(0);
	if(!isdefined(params.driver))
	{
		if(isdefined(params.turn_off))
		{
			self [[params.turn_off]]();
			return;
		}
	}
	/#
		assert(isdefined(params.driver));
	#/
	self disableaimassist();
	self.turretrotscale = 1;
	if(!(isdefined(params.var_c2e048f9) && params.var_c2e048f9))
	{
		self.team = params.driver.team;
	}
	if(hasasm(self))
	{
		self asmrequestsubstate(#"locomotion@movement");
	}
	clearalllookingandtargeting();
	clearallmovement();
	self cancelaimove();
	self returnplayercontrol();
	self setheliheightcap(1);
}

/*
	Name: defaultstate_driving_exit
	Namespace: vehicle_ai
	Checksum: 0x940A2400
	Offset: 0x5658
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function defaultstate_driving_exit(params)
{
	self enableaimassist();
	self.turretrotscale = 1;
	self setheliheightcap(0);
	self takeplayercontrol();
	clearalllookingandtargeting();
	clearallmovement();
}

/*
	Name: defaultstate_pain_enter
	Namespace: vehicle_ai
	Checksum: 0x285A7465
	Offset: 0x56E8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function defaultstate_pain_enter(params)
{
	clearalllookingandtargeting();
	clearallmovement();
}

/*
	Name: defaultstate_pain_exit
	Namespace: vehicle_ai
	Checksum: 0xF8E1148B
	Offset: 0x5720
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function defaultstate_pain_exit(params)
{
	clearalllookingandtargeting();
	clearallmovement();
}

/*
	Name: function_97e9de18
	Namespace: vehicle_ai
	Checksum: 0x1BEEFDD5
	Offset: 0x5758
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_97e9de18(params)
{
	self endon(#"death", #"change_state");
	wait(0.2);
	self evaluate_connections();
}

/*
	Name: canseeenemyfromposition
	Namespace: vehicle_ai
	Checksum: 0x75C87C90
	Offset: 0x57B0
	Size: 0x6A
	Parameters: 3
	Flags: None
*/
function canseeenemyfromposition(position, enemy, sight_check_height)
{
	sightcheckorigin = position + (0, 0, sight_check_height);
	return sighttracepassed(sightcheckorigin, enemy.origin + vectorscale((0, 0, 1), 30), 0, self);
}

/*
	Name: positionquery_debugscores
	Namespace: vehicle_ai
	Checksum: 0x38DE09D6
	Offset: 0x5828
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function positionquery_debugscores(queryresult)
{
	if(!(isdefined(getdvarint(#"hkai_debugpositionquery", 0)) && getdvarint(#"hkai_debugpositionquery", 0)))
	{
		return;
	}
	i = 1;
	foreach(point in queryresult.data)
	{
		point debugscore(self, i, queryresult.sorted);
		i++;
	}
}

/*
	Name: debugscore
	Namespace: vehicle_ai
	Checksum: 0x3DD99FD9
	Offset: 0x5930
	Size: 0x260
	Parameters: 3
	Flags: Linked
*/
function debugscore(entity, num, sorted)
{
	/#
		if(!isdefined(self._scoredebug))
		{
			return;
		}
		if(!(isdefined(getdvarint(#"hkai_debugpositionquery", 0)) && getdvarint(#"hkai_debugpositionquery", 0)))
		{
			return;
		}
		count = 1;
		color = (1, 0, 0);
		if(self.score >= 0 || (isdefined(sorted) && sorted && num == 1))
		{
			color = (0, 1, 0);
		}
		recordstar(self.origin, color);
		if(isdefined(sorted) && sorted)
		{
			record3dtext(((("" + num) + "") + self.score) + "", self.origin - (0, 0, 10 * count), color);
		}
		else
		{
			record3dtext(("" + self.score) + "", self.origin - (0, 0, 10 * count), color);
		}
		foreach(score in self._scoredebug)
		{
			count++;
			record3dtext((score.scorename + "") + score.score, self.origin - (0, 0, 10 * count), color);
		}
	#/
}

/*
	Name: _less_than_val
	Namespace: vehicle_ai
	Checksum: 0x1B080E6
	Offset: 0x5B98
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function _less_than_val(left, right)
{
	if(!isdefined(left))
	{
		return 0;
	}
	if(!isdefined(right))
	{
		return 1;
	}
	return left < right;
}

/*
	Name: _cmp_val
	Namespace: vehicle_ai
	Checksum: 0x64239936
	Offset: 0x5BE0
	Size: 0x5A
	Parameters: 3
	Flags: Linked
*/
function _cmp_val(left, right, descending)
{
	if(descending)
	{
		return _less_than_val(right, left);
	}
	return _less_than_val(left, right);
}

/*
	Name: _sort_by_score
	Namespace: vehicle_ai
	Checksum: 0xD70779DF
	Offset: 0x5C48
	Size: 0x42
	Parameters: 3
	Flags: Linked
*/
function _sort_by_score(left, right, descending)
{
	return _cmp_val(left.score, right.score, descending);
}

/*
	Name: positionquery_filter_random
	Namespace: vehicle_ai
	Checksum: 0x4718EE5F
	Offset: 0x5C98
	Size: 0x192
	Parameters: 3
	Flags: None
*/
function positionquery_filter_random(queryresult, min, max)
{
	foreach(point in queryresult.data)
	{
		score = randomfloatrange(min, max);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = score;
			point._scoredebug[#"random"].scorename = "";
		#/
		point.score = point.score + score;
	}
}

/*
	Name: positionquery_postprocess_sortscore
	Namespace: vehicle_ai
	Checksum: 0x94EDE6A9
	Offset: 0x5E38
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function positionquery_postprocess_sortscore(queryresult, descending = 1)
{
	sorted = array::merge_sort(queryresult.data, &_sort_by_score, descending);
	queryresult.data = sorted;
	queryresult.sorted = 1;
}

/*
	Name: positionquery_filter_outofgoalanchor
	Namespace: vehicle_ai
	Checksum: 0x845D8ED7
	Offset: 0x5EB8
	Size: 0x1AA
	Parameters: 2
	Flags: None
*/
function positionquery_filter_outofgoalanchor(queryresult, tolerance = 1)
{
	foreach(point in queryresult.data)
	{
		if(point.disttogoal > tolerance)
		{
			score = -10000 - (point.disttogoal * 10);
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"outofgoalanchor"]))
				{
					point._scoredebug[#"outofgoalanchor"] = spawnstruct();
				}
				point._scoredebug[#"outofgoalanchor"].score = score;
				point._scoredebug[#"outofgoalanchor"].scorename = "";
			#/
			point.score = point.score + score;
		}
	}
}

/*
	Name: positionquery_filter_engagementdist
	Namespace: vehicle_ai
	Checksum: 0x3C5D0139
	Offset: 0x6070
	Size: 0x2EA
	Parameters: 5
	Flags: Linked
*/
function positionquery_filter_engagementdist(queryresult, enemy, engagementdistancemin, engagementdistancemax, engagementdistance)
{
	if(!isdefined(enemy))
	{
		return;
	}
	if(!isdefined(engagementdistance))
	{
		engagementdistance = (engagementdistancemin + engagementdistancemax) * 0.5;
	}
	half_engagement_width = abs(engagementdistancemax - engagementdistance);
	enemy_origin = (enemy.origin[0], enemy.origin[1], 0);
	vec_enemy_to_self = vectornormalize((self.origin[0], self.origin[1], 0) - enemy_origin);
	foreach(point in queryresult.data)
	{
		point.distawayfromengagementarea = 0;
		vec_enemy_to_point = (point.origin[0], point.origin[1], 0) - enemy_origin;
		dist_in_front_of_enemy = vectordot(vec_enemy_to_point, vec_enemy_to_self);
		if(abs(dist_in_front_of_enemy) < engagementdistancemin)
		{
			dist_in_front_of_enemy = engagementdistancemin * -1;
		}
		dist_away_from_sweet_line = abs(dist_in_front_of_enemy - engagementdistance);
		if(dist_away_from_sweet_line > half_engagement_width)
		{
			point.distawayfromengagementarea = dist_away_from_sweet_line - half_engagement_width;
		}
		too_far_dist = engagementdistancemax * 1.1;
		too_far_dist_sq = too_far_dist * too_far_dist;
		dist_from_enemy_sq = distance2dsquared(point.origin, enemy_origin);
		if(dist_from_enemy_sq > too_far_dist_sq)
		{
			ratiosq = dist_from_enemy_sq / too_far_dist_sq;
			dist = ratiosq * too_far_dist;
			dist_outside = dist - too_far_dist;
			if(dist_outside > point.distawayfromengagementarea)
			{
				point.distawayfromengagementarea = dist_outside;
			}
		}
	}
}

/*
	Name: positionquery_filter_distawayfromtarget
	Namespace: vehicle_ai
	Checksum: 0x1F99B204
	Offset: 0x6368
	Size: 0x2E2
	Parameters: 4
	Flags: None
*/
function positionquery_filter_distawayfromtarget(queryresult, targetarray, distance, tooclosepenalty)
{
	if(!isdefined(targetarray) || !isarray(targetarray))
	{
		return;
	}
	foreach(point in queryresult.data)
	{
		tooclose = 0;
		foreach(target in targetarray)
		{
			origin = undefined;
			if(isvec(target))
			{
				origin = target;
			}
			else
			{
				if(issentient(target) && isalive(target))
				{
					origin = target.origin;
				}
				else if(isentity(target))
				{
					origin = target.origin;
				}
			}
			if(isdefined(origin) && distance2dsquared(point.origin, origin) < (distance * distance))
			{
				tooclose = 1;
				break;
			}
		}
		if(tooclose)
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
				point._scoredebug[#"tooclosetoothers"].score = tooclosepenalty;
				point._scoredebug[#"tooclosetoothers"].scorename = "";
			#/
			point.score = point.score + tooclosepenalty;
		}
	}
}

/*
	Name: distancepointtoengagementheight
	Namespace: vehicle_ai
	Checksum: 0xF08E41C9
	Offset: 0x6658
	Size: 0x10C
	Parameters: 4
	Flags: None
*/
function distancepointtoengagementheight(origin, enemy, engagementheightmin, engagementheightmax)
{
	if(!isdefined(enemy))
	{
		return undefined;
	}
	result = 0;
	engagementheight = 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);
	half_height = abs(engagementheightmax - engagementheight);
	targetheight = enemy.origin[2] + engagementheight;
	distfromengagementheight = abs(origin[2] - targetheight);
	if(distfromengagementheight > half_height)
	{
		result = distfromengagementheight - half_height;
	}
	return result;
}

/*
	Name: positionquery_filter_engagementheight
	Namespace: vehicle_ai
	Checksum: 0x9EE841FA
	Offset: 0x6770
	Size: 0x162
	Parameters: 4
	Flags: None
*/
function positionquery_filter_engagementheight(queryresult, enemy, engagementheightmin, engagementheightmax)
{
	if(!isdefined(enemy))
	{
		return;
	}
	engagementheight = 0.5 * (engagementheightmin + engagementheightmax);
	half_height = abs(engagementheightmax - engagementheight);
	foreach(point in queryresult.data)
	{
		point.distengagementheight = 0;
		targetheight = enemy.origin[2] + engagementheight;
		distfromengagementheight = abs(point.origin[2] - targetheight);
		if(distfromengagementheight > half_height)
		{
			point.distengagementheight = distfromengagementheight - half_height;
		}
	}
}

/*
	Name: positionquery_postprocess_removeoutofgoalradius
	Namespace: vehicle_ai
	Checksum: 0xD9096097
	Offset: 0x68E0
	Size: 0xA4
	Parameters: 2
	Flags: None
*/
function positionquery_postprocess_removeoutofgoalradius(queryresult, tolerance = 1)
{
	for(i = 0; i < queryresult.data.size; i++)
	{
		point = queryresult.data[i];
		if(point.disttogoal > tolerance)
		{
			arrayremoveindex(queryresult.data, i);
			i--;
		}
	}
}

/*
	Name: target_hijackers
	Namespace: vehicle_ai
	Checksum: 0x65147DE
	Offset: 0x6990
	Size: 0xB8
	Parameters: 0
	Flags: None
*/
function target_hijackers()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"ccom_lock_being_targeted");
		hijackingplayer = waitresult.hijacking_player;
		self getperfectinfo(hijackingplayer, 1);
		if(isplayer(hijackingplayer))
		{
			self setpersonalthreatbias(hijackingplayer, 1500, 4);
		}
	}
}

/*
	Name: function_f2964e93
	Namespace: vehicle_ai
	Checksum: 0xDBD37B3
	Offset: 0x6A50
	Size: 0x28
	Parameters: 1
	Flags: Event
*/
event function_f2964e93(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
}

/*
	Name: function_b7880090
	Namespace: vehicle_ai
	Checksum: 0x5680AC50
	Offset: 0x6A80
	Size: 0x28
	Parameters: 1
	Flags: Event
*/
event function_b7880090(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
}

/*
	Name: function_7ae52016
	Namespace: vehicle_ai
	Checksum: 0x283892F3
	Offset: 0x6AB0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_7ae52016(val)
{
	if(isairborne(self))
	{
		self setrotorspeed(float(val));
	}
}

/*
	Name: function_e057db25
	Namespace: vehicle_ai
	Checksum: 0x7B0C2379
	Offset: 0x6B08
	Size: 0x33C
	Parameters: 3
	Flags: Linked, Private
*/
function private function_e057db25(var_2d1cbdd9, goalpos, vararg)
{
	switch(vararg.size)
	{
		case 8:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2], vararg[3], vararg[4], vararg[5], vararg[6], vararg[7]);
		}
		case 7:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2], vararg[3], vararg[4], vararg[5], vararg[6]);
		}
		case 6:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2], vararg[3], vararg[4], vararg[5]);
		}
		case 5:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2], vararg[3], vararg[4]);
		}
		case 4:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2], vararg[3]);
		}
		case 3:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1], vararg[2]);
		}
		case 2:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0], vararg[1]);
		}
		case 1:
		{
			return tacticalquery(var_2d1cbdd9, goalpos, vararg[0]);
		}
		case 0:
		{
			return tacticalquery(var_2d1cbdd9, goalpos);
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
	return undefined;
}

/*
	Name: function_1d436633
	Namespace: vehicle_ai
	Checksum: 0x11ACE4ED
	Offset: 0x6E50
	Size: 0x526
	Parameters: 1
	Flags: Variadic
*/
function function_1d436633(vararg)
{
	/#
		assert(isdefined(self.ai));
	#/
	if(!isdefined(self.ai.var_88b0fd29))
	{
		self.ai.var_88b0fd29 = gettime();
	}
	var_12cb92c6 = 0;
	var_1f2328d0 = self function_4794d6a3();
	newpos = undefined;
	forcedgoal = isdefined(var_1f2328d0.goalforced) && var_1f2328d0.goalforced;
	isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal || (self isapproachinggoal() && isdefined(self.overridegoalpos));
	itsbeenawhile = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal && gettime() > self.ai.var_88b0fd29;
	var_48ea0381 = 0;
	var_2a8c95a5 = forcedgoal && isdefined(self.overridegoalpos) && distancesquared(self.overridegoalpos, var_1f2328d0.goalpos) < (self.radius * self.radius);
	if(isdefined(self.enemy) && !self haspath())
	{
		var_48ea0381 = !self seerecently(self.enemy, randomintrange(3, 5));
		if(issentient(self.enemy) || function_ffa5b184(self.enemy))
		{
			var_48ea0381 = var_48ea0381 && !self attackedrecently(self.enemy, randomintrange(5, 7));
		}
	}
	var_12cb92c6 = !isatgoal || var_48ea0381 || itsbeenawhile;
	var_12cb92c6 = var_12cb92c6 && !var_2a8c95a5;
	if(var_12cb92c6)
	{
		if(forcedgoal)
		{
			newpos = getclosestpointonnavmesh(var_1f2328d0.goalpos, self.radius * 2, self.radius);
		}
		else
		{
			/#
				assert(isdefined(self.settings.tacbundle) && self.settings.tacbundle != "", "");
			#/
			goalarray = function_e057db25(self.settings.tacbundle, var_1f2328d0.goalpos, vararg);
			var_817e8fd0 = [];
			if(isdefined(goalarray) && goalarray.size)
			{
				foreach(goal in goalarray)
				{
					if(!self isingoal(goal.origin))
					{
						continue;
					}
					if(isdefined(self.overridegoalpos) && distancesquared(self.overridegoalpos, goal.origin) < (self.radius * self.radius))
					{
						continue;
					}
					var_817e8fd0[var_817e8fd0.size] = goal;
				}
				if(var_817e8fd0.size)
				{
					goal = array::random(var_817e8fd0);
					newpos = goal.origin;
				}
			}
		}
		if(!isdefined(newpos))
		{
			newpos = getclosestpointonnavmesh(var_1f2328d0.goalpos, self.radius * 2, self.radius);
		}
		self.ai.var_88b0fd29 = gettime() + randomintrange(3500, 5000);
	}
	return newpos;
}

/*
	Name: function_4ab1a63a
	Namespace: vehicle_ai
	Checksum: 0x8119D574
	Offset: 0x7380
	Size: 0x4EA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4ab1a63a(goal)
{
	if(isdefined(self.settings.engagementheightmax) && isdefined(self.settings.engagementheightmin))
	{
		var_20b5eeff = 0.5 * (self.settings.engagementheightmax + self.settings.engagementheightmin);
	}
	else
	{
		var_20b5eeff = 150;
	}
	var_3069c020 = (isdefined(self.settings.var_2ade16ee) ? self.settings.var_2ade16ee : 450);
	maxradius = goal.goalradius;
	minradius = min(self.radius * 2, maxradius / 3);
	innerspacing = mapfloat(1000, 3000, self.radius, self.radius * 3, goal.goalradius);
	outerspacing = innerspacing * 1.5;
	queryresult = positionquery_source_navigation(goal.goalpos, minradius, maxradius, goal.goalheight, innerspacing, self, outerspacing);
	positionquery_filter_inclaimedlocation(queryresult, self);
	foreach(point in queryresult.data)
	{
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
				point._scoredebug[#"inclaimedlocation"].score = -5000;
				point._scoredebug[#"inclaimedlocation"].scorename = "";
			#/
			point.score = point.score + -5000;
		}
		score = randomfloatrange(0, 80);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = score;
			point._scoredebug[#"random"].scorename = "";
		#/
		point.score = point.score + score;
	}
	if(queryresult.data.size > 0)
	{
		positionquery_postprocess_sortscore(queryresult);
		self positionquery_debugscores(queryresult);
		foreach(point in queryresult.data)
		{
			if(self isingoal(point.origin))
			{
				return point;
			}
		}
	}
	return undefined;
}

/*
	Name: function_1e0d693b
	Namespace: vehicle_ai
	Checksum: 0x37516AA1
	Offset: 0x7878
	Size: 0xD5A
	Parameters: 2
	Flags: Linked
*/
function function_1e0d693b(goal, enemy)
{
	prefereddistawayfromorigin = (isdefined(self.settings.var_99955aeb) ? self.settings.var_99955aeb : 150);
	if(isdefined(self.settings.engagementheightmax) && isdefined(self.settings.engagementheightmin))
	{
		var_20b5eeff = 0.5 * (self.settings.engagementheightmax + self.settings.engagementheightmin);
	}
	else
	{
		var_20b5eeff = 150;
	}
	var_3069c020 = (isdefined(self.settings.var_2ade16ee) ? self.settings.var_2ade16ee : 450);
	enemypos = enemy.origin;
	if(function_ffa5b184(enemy))
	{
		enemypos = enemy.var_88f8feeb;
	}
	var_caa2a43c = max(prefereddistawayfromorigin, goal.goalradius + distance2d(self.origin, goal.goalpos));
	var_a51de54a = goal.goalheight + (abs(self.origin[2] - goal.goalpos[2]));
	closedist = 1.2 * self.var_ec0d66ce;
	fardist = 3 * self.var_ec0d66ce;
	selfdisttoenemy = distance2d(self.origin, enemypos);
	querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttoenemy);
	maxsearchradius = min(var_caa2a43c, (isdefined(self.settings.var_3285f09a) ? self.settings.var_3285f09a : 1000) * querymultiplier);
	halfheight = min(var_a51de54a / 2, (isdefined(self.settings.var_e1d36c37) ? self.settings.var_e1d36c37 : 300) * querymultiplier);
	innerspacing = maxsearchradius / 10;
	outerspacing = innerspacing;
	queryresult = positionquery_source_navigation(self.origin, (isdefined(self.settings.var_99955aeb) ? self.settings.var_99955aeb : 0), maxsearchradius, halfheight, innerspacing, self, outerspacing);
	positionquery_filter_distancetogoal(queryresult, self);
	positionquery_filter_inclaimedlocation(queryresult, self);
	positionquery_filter_sight(queryresult, enemypos, self geteye() - self.origin, self, 0, enemy);
	self positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax, var_3069c020);
	goalheight = enemypos[2] + (0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax));
	foreach(point in queryresult.data)
	{
		if(point.disttogoal > 0)
		{
			score = -5000 - (point.disttogoal * 2);
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"outofgoalanchor"]))
				{
					point._scoredebug[#"outofgoalanchor"] = spawnstruct();
				}
				point._scoredebug[#"outofgoalanchor"].score = score;
				point._scoredebug[#"outofgoalanchor"].scorename = "";
			#/
			point.score = point.score + score;
		}
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
				point._scoredebug[#"hash_3f8a9579ce4600de"].scorename = "";
			#/
			point.score = point.score + -5000;
		}
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
			if(!isdefined(point._scoredebug[#"hash_6c444b535ec20313"]))
			{
				point._scoredebug[#"hash_6c444b535ec20313"] = spawnstruct();
			}
			point._scoredebug[#"hash_6c444b535ec20313"].score = mapfloat(0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d);
			point._scoredebug[#"hash_6c444b535ec20313"].scorename = "";
		#/
		point.score = point.score + (mapfloat(0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d));
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
				point._scoredebug[#"inclaimedlocation"].score = -5000;
				point._scoredebug[#"inclaimedlocation"].scorename = "";
			#/
			point.score = point.score + -5000;
		}
		distfrompreferredheight = abs(point.origin[2] - goalheight);
		if(distfrompreferredheight > var_20b5eeff)
		{
			heightscore = mapfloat(var_20b5eeff, 10000, 0, 2500, distfrompreferredheight) * -1;
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"height"]))
				{
					point._scoredebug[#"height"] = spawnstruct();
				}
				point._scoredebug[#"height"].score = heightscore;
				point._scoredebug[#"height"].scorename = "";
			#/
			point.score = point.score + heightscore;
		}
		score = randomfloatrange(0, 80);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = score;
			point._scoredebug[#"random"].scorename = "";
		#/
		point.score = point.score + score;
	}
	if(queryresult.data.size > 0)
	{
		positionquery_postprocess_sortscore(queryresult);
		self positionquery_debugscores(queryresult);
		foreach(point in queryresult.data)
		{
			if(self isingoal(point.origin))
			{
				return point;
			}
		}
	}
	return undefined;
}

/*
	Name: function_4646fb11
	Namespace: vehicle_ai
	Checksum: 0x81C716D3
	Offset: 0x85E0
	Size: 0x55A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4646fb11(goal)
{
	minsearchradius = math::clamp(120, 0, goal.goalradius);
	maxsearchradius = math::clamp(800, 120, goal.goalradius);
	queryresult = positionquery_source_navigation(self.origin, minsearchradius, maxsearchradius, 400, 80, self, 50);
	positionquery_filter_distancetogoal(queryresult, self);
	positionquery_filter_inclaimedlocation(queryresult, self);
	foreach(point in queryresult.data)
	{
		if(point.disttogoal > 0)
		{
			score = -5000 - (point.disttogoal * 2);
			/#
				if(!isdefined(point._scoredebug))
				{
					point._scoredebug = [];
				}
				if(!isdefined(point._scoredebug[#"outofgoalanchor"]))
				{
					point._scoredebug[#"outofgoalanchor"] = spawnstruct();
				}
				point._scoredebug[#"outofgoalanchor"].score = score;
				point._scoredebug[#"outofgoalanchor"].scorename = "";
			#/
			point.score = point.score + score;
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
				point._scoredebug[#"inclaimedlocation"].score = -5000;
				point._scoredebug[#"inclaimedlocation"].scorename = "";
			#/
			point.score = point.score + -5000;
		}
		score = randomfloatrange(0, 80);
		/#
			if(!isdefined(point._scoredebug))
			{
				point._scoredebug = [];
			}
			if(!isdefined(point._scoredebug[#"random"]))
			{
				point._scoredebug[#"random"] = spawnstruct();
			}
			point._scoredebug[#"random"].score = score;
			point._scoredebug[#"random"].scorename = "";
		#/
		point.score = point.score + score;
	}
	if(queryresult.data.size > 0)
	{
		positionquery_postprocess_sortscore(queryresult);
		self positionquery_debugscores(queryresult);
		foreach(point in queryresult.data)
		{
			if(self isingoal(point.origin))
			{
				return point;
			}
		}
	}
	return undefined;
}

/*
	Name: function_b1bd875a
	Namespace: vehicle_ai
	Checksum: 0xFC271C8C
	Offset: 0x8B48
	Size: 0x680
	Parameters: 0
	Flags: None
*/
function function_b1bd875a()
{
	/#
		assert(isdefined(self.ai));
	#/
	if(!isdefined(self.ai.var_88b0fd29))
	{
		self.ai.var_88b0fd29 = gettime() + 1000;
		return;
	}
	var_1f2328d0 = self function_4794d6a3();
	/#
		assert(isdefined(var_1f2328d0.goalpos));
	#/
	var_12cb92c6 = 0;
	newpos = undefined;
	point = undefined;
	enemy = self.enemy;
	currenttime = gettime();
	forcedgoal = isdefined(var_1f2328d0.goalforced) && var_1f2328d0.goalforced;
	isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal;
	haspath = self haspath();
	isapproachinggoal = !isatgoal && haspath && self isapproachinggoal();
	itsbeenawhile = currenttime >= self.ai.var_88b0fd29;
	var_ed3f071f = currenttime >= (self.ai.var_88b0fd29 + 5000);
	var_48ea0381 = 0;
	if(issentient(enemy) && !haspath)
	{
		var_48ea0381 = !self seerecently(enemy, randomintrange(3, 5));
		if(var_48ea0381 && issentient(enemy))
		{
			var_48ea0381 = !self attackedrecently(enemy, randomintrange(5, 7));
		}
	}
	var_3e782e85 = forcedgoal || (var_1f2328d0.goalradius < (2 * self.radius) && var_1f2328d0.goalheight < (2 * self.radius));
	var_f5ae7ee0 = isatgoal && !var_3e782e85 && (itsbeenawhile || var_48ea0381);
	var_633ff15a = !isatgoal && (!isapproachinggoal || var_ed3f071f);
	var_12cb92c6 = var_f5ae7ee0 || var_633ff15a;
	if(var_12cb92c6)
	{
		if(!isatgoal || !var_3e782e85)
		{
			if(var_3e782e85)
			{
				newpos = self getclosestpointonnavvolume(var_1f2328d0.goalpos, self.radius * 2);
			}
			else
			{
				if(!isatgoal)
				{
					point = function_4ab1a63a(var_1f2328d0);
				}
				else
				{
					if(isdefined(enemy))
					{
						point = function_1e0d693b(var_1f2328d0, enemy);
					}
					else
					{
						point = function_4646fb11(var_1f2328d0);
					}
				}
			}
			if(isdefined(point))
			{
				newpos = point.origin;
			}
			if(!isdefined(newpos))
			{
				newpos = self getclosestpointonnavvolume(var_1f2328d0.goalpos, self.radius * 2);
			}
			if(!isdefined(newpos))
			{
				/#
					record3dtext((((("" + var_1f2328d0.goalpos) + "") + var_1f2328d0.goalradius) + "") + var_1f2328d0.goalheight, self.origin + vectorscale((0, 0, 1), 8), (1, 0, 0));
					recordline(self.origin, var_1f2328d0.goalpos, (1, 0, 0));
				#/
				newpos = var_1f2328d0.goalpos;
			}
			else if(!self isingoal(newpos))
			{
				/#
					record3dtext((((((("" + newpos) + "") + var_1f2328d0.goalpos) + "") + var_1f2328d0.goalradius) + "") + var_1f2328d0.goalheight, self.origin + vectorscale((0, 0, 1), 8), (1, 0, 0));
					recordline(self.origin, newpos, (1, 0, 0));
				#/
				newpos = var_1f2328d0.goalpos;
			}
			if(distancesquared(self.origin, newpos) < (self.radius * 2) * (self.radius * 2))
			{
				newpos = undefined;
			}
			self.ai.var_88b0fd29 = currenttime + randomintrange(1000, 2000);
		}
	}
	else if(isatgoal && var_3e782e85)
	{
		self setspeedimmediate(0);
		self setvehvelocity((0, 0, 0));
		self setphysacceleration((0, 0, 0));
	}
	return newpos;
}

