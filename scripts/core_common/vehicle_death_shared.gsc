// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace vehicle_death;

/*
	Name: function_89f2df9
	Namespace: vehicle_death
	Checksum: 0x66082730
	Offset: 0x268
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"vehicle_death", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: vehicle_death
	Checksum: 0xFFDC4FA4
	Offset: 0x2B0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	setdvar(#"debug_crash_type", -1);
	callback::on_vehicle_damage(&on_vehicle_damage);
}

/*
	Name: on_vehicle_damage
	Namespace: vehicle_death
	Checksum: 0x6B9D004
	Offset: 0x308
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_vehicle_damage(var_bff7298b)
{
	if(isdefined(self.deathmodel))
	{
		streamermodelhint(self.deathmodel, 5);
	}
}

/*
	Name: main
	Namespace: vehicle_death
	Checksum: 0x68C5F32B
	Offset: 0x350
	Size: 0x7F8
	Parameters: 0
	Flags: Linked
*/
function main()
{
	self endon(#"nodeath_thread", #"delete");
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"death");
		attacker = waitresult.attacker;
		weapon = waitresult.weapon;
		point = waitresult.position;
		dir = waitresult.direction;
		mod = waitresult.mod;
		if(!isdefined(self.delete_on_death))
		{
			self thread play_death_audio();
		}
		if(!isdefined(self))
		{
			return;
		}
		if(self.var_7d4f75e === 1)
		{
			self.delete_on_death = undefined;
			self.var_475b9991 = 1;
			self.var_1b9f096d = 1;
			self.no_free_on_death = 1;
		}
		self death_cleanup_level_variables();
		if(vehicle::is_corpse(self))
		{
			if(!(isdefined(self.dont_kill_riders) && self.dont_kill_riders))
			{
				self death_cleanup_riders();
			}
			self notify(#"delete_destructible");
			return;
		}
		self vehicle::lights_off();
		self vehicle::toggle_lights_group(1, 0);
		self vehicle::toggle_lights_group(2, 0);
		self vehicle::toggle_lights_group(3, 0);
		self vehicle::toggle_lights_group(4, 0);
		self vehicle::toggle_force_driver_taillights(0);
		if(isdefined(level.vehicle_death_thread[self.vehicletype]))
		{
			self thread [[level.vehicle_death_thread[self.vehicletype]]](attacker, weapon, mod);
		}
		if(self.var_1b9f096d === 1)
		{
			self setvehvelocity((0, 0, 0));
			self notsolid();
		}
		if(!isdefined(self.delete_on_death))
		{
			thread death_radius_damage("MOD_EXPLOSIVE", attacker, weapon);
		}
		is_aircraft = self.vehicleclass === "plane" || self.vehicleclass === "helicopter";
		if(!isdefined(self.destructibledef))
		{
			if(!is_aircraft && isdefined(self.deathmodel) && self.deathmodel != "")
			{
				self thread set_death_model(self.deathmodel, self.modelswapdelay);
			}
			if(!(isdefined(self.delete_on_death) && self.delete_on_death) && (!isdefined(self.mantled) || !self.mantled) && !isdefined(self.nodeathfx))
			{
				thread death_fx();
				self vehicle::do_death_dynents();
			}
			if(isdefined(self.delete_on_death) && self.delete_on_death)
			{
				waitframe(1);
				if(self.disconnectpathonstop === 1)
				{
					self vehicle::disconnect_paths();
				}
				if(!(isdefined(self.no_free_on_death) && self.no_free_on_death))
				{
					self takeplayercontrol();
					self freevehicle();
					self.isacorpse = 1;
					waitframe(1);
					if(isdefined(self))
					{
						self notify(#"death_finished");
						self delete();
					}
				}
				continue;
			}
		}
		thread death_make_badplace(self.vehicletype);
		if(isdefined(level.vehicle_deathnotify) && isdefined(level.vehicle_deathnotify[self.vehicletype]))
		{
			level notify(level.vehicle_deathnotify[self.vehicletype], {#attacker:attacker});
		}
		if(target_istarget(self))
		{
			target_remove(self);
		}
		if(self.classname == "script_vehicle")
		{
			self thread death_jolt(self.vehicletype, point, dir);
		}
		if(do_scripted_crash())
		{
			self thread death_update_crash(point, dir);
		}
		if(isdefined(self.turretweapon) && self.turretweapon != level.weaponnone)
		{
			self turretcleartarget(0);
		}
		self waittill_crash_done_or_stopped();
		if(isdefined(self))
		{
			while(isdefined(self) && isdefined(self.dontfreeme))
			{
				wait(0.05);
			}
			if(isdefined(self))
			{
				self notify(#"stop_looping_death_fx");
				self notify(#"death_finished");
			}
			waitframe(1);
			if(isdefined(self))
			{
				if(vehicle::is_corpse(self))
				{
					continue;
				}
				if(!isdefined(self))
				{
					continue;
				}
				occupants = self getvehoccupants();
				if(isdefined(occupants) && occupants.size)
				{
					for(i = 0; i < occupants.size; i++)
					{
						if(occupants[i] isinvehicle())
						{
							self usevehicle(occupants[i], 0);
						}
					}
				}
				if(!(isdefined(self.no_free_on_death) && self.no_free_on_death))
				{
					self takeplayercontrol();
					self freevehicle();
					self.isacorpse = 1;
				}
				if(self.modeldummyon)
				{
					self hide();
				}
				if(self.var_475b9991 === 1)
				{
					wait(5);
					if(isdefined(self))
					{
						self delete();
					}
				}
			}
		}
	}
}

/*
	Name: function_52abcd2e
	Namespace: vehicle_death
	Checksum: 0xD551D906
	Offset: 0xB50
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function function_52abcd2e()
{
	/#
		while(isdefined(self))
		{
			util::debug_sphere(self.origin, 5, vectorscale((1, 0, 0), 0.9), 0.9, 300);
			waitframe(1);
		}
	#/
}

/*
	Name: do_scripted_crash
	Namespace: vehicle_death
	Checksum: 0xA9BFE057
	Offset: 0xBB0
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function do_scripted_crash()
{
	return !isdefined(self.do_scripted_crash) || (isdefined(self.do_scripted_crash) && self.do_scripted_crash);
}

/*
	Name: play_death_audio
	Namespace: vehicle_death
	Checksum: 0x4566DE8
	Offset: 0xBE8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function play_death_audio()
{
	if(isdefined(self) && self.vehicleclass === "helicopter")
	{
		if(!isdefined(self.death_counter))
		{
			self.death_counter = 0;
		}
		if(self.death_counter == 0)
		{
			self.death_counter++;
		}
	}
}

/*
	Name: play_spinning_plane_sound
	Namespace: vehicle_death
	Checksum: 0x51738115
	Offset: 0xC48
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function play_spinning_plane_sound()
{
	if(self.vehicletype == #"hash_4043fb66689f91c8")
	{
		return;
	}
	self playloopsound(#"exp_veh_plane_spinout_lp", 0.05);
	level waittill(#"crash_move_done", #"death");
	self playsound(#"exp_veh_large");
	self stoploopsound(0.02);
}

/*
	Name: set_death_model
	Namespace: vehicle_death
	Checksum: 0xF8766070
	Offset: 0xD08
	Size: 0x124
	Parameters: 2
	Flags: Linked
*/
function set_death_model(smodel, fdelay)
{
	if(!isdefined(smodel))
	{
		return;
	}
	if(isdefined(fdelay) && fdelay > 0)
	{
		streamermodelhint(smodel, 5);
		wait(fdelay);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.deathmodel_attached))
	{
		return;
	}
	emodel = vehicle::get_dummy();
	if(!isdefined(emodel))
	{
		return;
	}
	if(!isdefined(emodel.death_anim) && isdefined(emodel.animtree))
	{
		emodel clearanim(#"root", 0);
	}
	if(smodel != self.vehmodel)
	{
		emodel setmodel(smodel);
		emodel setenemymodel(smodel);
	}
}

/*
	Name: aircraft_crash
	Namespace: vehicle_death
	Checksum: 0x2EDB4893
	Offset: 0xE38
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function aircraft_crash(point, dir)
{
	self.crashing = 1;
	if(isdefined(self.unloading))
	{
		while(isdefined(self.unloading))
		{
			waitframe(1);
		}
	}
	if(!isdefined(self))
	{
		return;
	}
	self thread aircraft_crash_move(point, dir);
	self thread play_spinning_plane_sound();
}

/*
	Name: helicopter_crash
	Namespace: vehicle_death
	Checksum: 0x895D4203
	Offset: 0xEC8
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function helicopter_crash(point, dir)
{
	self.crashing = 1;
	self thread play_crashing_loop();
	if(isdefined(self.unloading))
	{
		while(isdefined(self.unloading))
		{
			waitframe(1);
		}
	}
	if(!isdefined(self))
	{
		return;
	}
	self thread helicopter_crash_movement(point, dir);
}

/*
	Name: helicopter_crash_movement
	Namespace: vehicle_death
	Checksum: 0x5BAC4E0A
	Offset: 0xF50
	Size: 0x3E6
	Parameters: 2
	Flags: Linked
*/
function helicopter_crash_movement(point, dir)
{
	self endon(#"crash_done");
	self cancelaimove();
	self function_d4c687c9();
	crash_zones = struct::get_array("heli_crash_zone", "targetname");
	if(crash_zones.size > 0)
	{
		best_dist = 99999;
		best_idx = -1;
		if(isdefined(self.a_crash_zones))
		{
			crash_zones = self.a_crash_zones;
		}
		for(i = 0; i < crash_zones.size; i++)
		{
			vec_to_crash_zone = crash_zones[i].origin - self.origin;
			vec_to_crash_zone = (vec_to_crash_zone[0], vec_to_crash_zone[1], 0);
			dist = length(vec_to_crash_zone);
			vec_to_crash_zone = vec_to_crash_zone / dist;
			veloctiy_scale = vectordot(self.velocity, vec_to_crash_zone) * -1;
			dist = dist + (500 * veloctiy_scale);
			if(dist < best_dist)
			{
				best_dist = dist;
				best_idx = i;
			}
		}
		if(best_idx != -1)
		{
			self.crash_zone = crash_zones[best_idx];
			self thread helicopter_crash_zone_accel(dir);
		}
	}
	else
	{
		mag = 100;
		if(isdefined(dir))
		{
			dir = vectornormalize(dir);
		}
		else
		{
			dir = (1, 0, 0);
		}
		side_dir = vectorcross(dir, (0, 0, 1));
		side_dir_mag = randomfloatrange(mag * -1, mag);
		side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 60);
		side_dir = side_dir * side_dir_mag;
		side_dir = side_dir + (0, 0, 0);
		self setphysacceleration((randomintrange(mag * -1, mag), randomintrange(mag * -1, mag), -500));
		vel = self.velocity + side_dir;
		self setvehvelocity((vel[0], vel[1], 0));
		self thread helicopter_crash_accel();
		if(isdefined(point))
		{
			self thread helicopter_crash_rotation(point, dir);
		}
		else
		{
			self thread helicopter_crash_rotation(self.origin, dir);
		}
		self thread wait_and_explode();
	}
	self thread crash_collision_test();
	wait(15);
	if(isdefined(self))
	{
		self notify(#"crash_done");
	}
}

/*
	Name: helicopter_crash_accel
	Namespace: vehicle_death
	Checksum: 0x899D126B
	Offset: 0x1340
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function helicopter_crash_accel()
{
	self endon(#"crash_done", #"crash_move_done", #"death");
	if(!isdefined(self.crash_accel))
	{
		self.crash_accel = randomfloatrange(50, 80);
	}
	while(isdefined(self))
	{
		self setvehvelocity(self.velocity + (anglestoup(self.angles) * self.crash_accel));
		wait(0.1);
	}
}

/*
	Name: helicopter_crash_rotation
	Namespace: vehicle_death
	Checksum: 0xA9464DB4
	Offset: 0x1400
	Size: 0x35E
	Parameters: 2
	Flags: Linked
*/
function helicopter_crash_rotation(point, dir)
{
	self endon(#"crash_done", #"crash_move_done", #"death");
	start_angles = self.angles;
	start_angles = (start_angles[0] + 10, start_angles[1], start_angles[2]);
	start_angles = (start_angles[0], start_angles[1], start_angles[2] + 10);
	ang_vel = self getangularvelocity();
	ang_vel = (0, ang_vel[1] * randomfloatrange(2, 3), 0);
	self setangularvelocity(ang_vel);
	point_2d = (point[0], point[1], self.origin[2]);
	torque = (0, randomintrange(90, 180), 0);
	if(self getangularvelocity()[1] < 0)
	{
		torque = torque * -1;
	}
	if(distance(self.origin, point_2d) > 5)
	{
		local_hit_point = point_2d - self.origin;
		dir_2d = (dir[0], dir[1], 0);
		if(length(dir_2d) > 0.01)
		{
			dir_2d = vectornormalize(dir_2d);
			torque = vectorcross(vectornormalize(local_hit_point), dir);
			torque = (0, 0, torque[2]);
			torque = vectornormalize(torque);
			torque = (0, torque[2] * 180, 0);
		}
	}
	while(true)
	{
		ang_vel = self getangularvelocity();
		ang_vel = ang_vel + (torque * 0.05);
		if(ang_vel[1] < 360 * -1)
		{
			ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
		}
		else if(ang_vel[1] > 360)
		{
			ang_vel = (ang_vel[0], 360, ang_vel[2]);
		}
		self setangularvelocity(ang_vel);
		waitframe(1);
	}
}

/*
	Name: helicopter_crash_zone_accel
	Namespace: vehicle_death
	Checksum: 0xF40E4CDC
	Offset: 0x1768
	Size: 0x5D8
	Parameters: 1
	Flags: Linked
*/
function helicopter_crash_zone_accel(dir)
{
	self endon(#"crash_done", #"crash_move_done");
	torque = (0, randomintrange(90, 150), 0);
	ang_vel = self getangularvelocity();
	torque = torque * math::sign(ang_vel[1]);
	/#
		if(isdefined(self.crash_zone.height))
		{
			self.crash_zone.height = 0;
		}
	#/
	if(abs(self.angles[2]) < 3)
	{
		self.angles = (self.angles[0], self.angles[1], randomintrange(3, 6) * math::sign(self.angles[2]));
	}
	if(self.var_71b64420)
	{
		torque = torque * 0.3;
	}
	while(isdefined(self))
	{
		/#
			assert(isdefined(self.crash_zone));
		#/
		dist = distance2d(self.origin, self.crash_zone.origin);
		if(dist < self.crash_zone.radius)
		{
			self setphysacceleration(vectorscale((0, 0, -1), 400));
			/#
				circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (0, 1, 0), 0, 2000);
			#/
			self.crash_accel = 0;
		}
		else
		{
			self setphysacceleration(vectorscale((0, 0, -1), 50));
			/#
				circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (1, 0, 0), 0, 2);
			#/
		}
		self.crash_vel = self.crash_zone.origin - self.origin;
		self.crash_vel = (self.crash_vel[0], self.crash_vel[1], 0);
		self.crash_vel = vectornormalize(self.crash_vel);
		self.crash_vel = self.crash_vel * (self getmaxspeed() * 0.5);
		if(self.var_71b64420)
		{
			self.crash_vel = self.crash_vel * 0.5;
		}
		crash_vel_forward = (anglestoup(self.angles) * self getmaxspeed()) * 2;
		crash_vel_forward = (crash_vel_forward[0], crash_vel_forward[1], 0);
		self.crash_vel = self.crash_vel + crash_vel_forward;
		vel_x = difftrack(self.crash_vel[0], self.velocity[0], 1, 0.1);
		vel_y = difftrack(self.crash_vel[1], self.velocity[1], 1, 0.1);
		vel_z = difftrack(self.crash_vel[2], self.velocity[2], 1, 0.1);
		self setvehvelocity((vel_x, vel_y, vel_z));
		ang_vel = self getangularvelocity();
		ang_vel = (0, ang_vel[1], 0);
		ang_vel = ang_vel + (torque * 0.1);
		max_angluar_vel = 200;
		if(self.var_71b64420)
		{
			max_angluar_vel = 100;
		}
		if(ang_vel[1] < max_angluar_vel * -1)
		{
			ang_vel = (ang_vel[0], max_angluar_vel * -1, ang_vel[2]);
		}
		else if(ang_vel[1] > max_angluar_vel)
		{
			ang_vel = (ang_vel[0], max_angluar_vel, ang_vel[2]);
		}
		self setangularvelocity(ang_vel);
		wait(0.1);
	}
}

/*
	Name: helicopter_collision
	Namespace: vehicle_death
	Checksum: 0xFE9EAB84
	Offset: 0x1D48
	Size: 0xF2
	Parameters: 0
	Flags: None
*/
function helicopter_collision()
{
	self endon(#"crash_done");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_collision");
		normal = waitresult.normal;
		ang_vel = self getangularvelocity() * 0.5;
		self setangularvelocity(ang_vel);
		if(normal[2] < 0.7)
		{
			self setvehvelocity(self.velocity + (normal * 70));
		}
		else
		{
			self notify(#"crash_done");
		}
	}
}

/*
	Name: play_crashing_loop
	Namespace: vehicle_death
	Checksum: 0x2CADD31F
	Offset: 0x1E48
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function play_crashing_loop()
{
	ent = spawn("script_origin", self.origin);
	ent function_6e562a77(self);
	ent linkto(self);
	ent playloopsound(#"exp_veh_plane_spinout_lp");
	self waittill(#"death", #"snd_impact");
	ent playsound(#"exp_veh_large");
	ent delete();
}

/*
	Name: helicopter_explode
	Namespace: vehicle_death
	Checksum: 0x8B75B57F
	Offset: 0x1F30
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function helicopter_explode(delete_me)
{
	self endon(#"death");
	if(isdefined(self.destroyfunc))
	{
		self [[self.destroyfunc]](1);
	}
	self vehicle::do_death_fx();
	if(isdefined(delete_me) && delete_me)
	{
		self delete();
	}
	self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

/*
	Name: aircraft_crash_move
	Namespace: vehicle_death
	Checksum: 0x7D777574
	Offset: 0x1FE0
	Size: 0x56E
	Parameters: 2
	Flags: Linked
*/
function aircraft_crash_move(point, dir)
{
	self endon(#"crash_move_done", #"death");
	self thread crash_collision_test();
	self function_d4c687c9();
	self cancelaimove();
	self setrotorspeed(0.2);
	if(isdefined(self) && isdefined(self.vehicletype))
	{
		b_custom_deathmodel_setup = 1;
		switch(self.vehicletype)
		{
			default:
			{
				b_custom_deathmodel_setup = 0;
				break;
			}
		}
		if(b_custom_deathmodel_setup)
		{
			self.deathmodel_attached = 1;
		}
	}
	ang_vel = self getangularvelocity();
	ang_vel = (0, 0, 0);
	self setangularvelocity(ang_vel);
	nodes = self getvehicleavoidancenodes(10000);
	closest_index = -1;
	best_dist = 999999;
	if(nodes.size > 0)
	{
		for(i = 0; i < nodes.size; i++)
		{
			dir = vectornormalize(nodes[i] - self.origin);
			forward = anglestoforward(self.angles);
			dot = vectordot(dir, forward);
			if(dot < 0)
			{
				continue;
			}
			dist = distance2d(self.origin, nodes[i]);
			if(dist < best_dist)
			{
				best_dist = dist;
				closest_index = i;
			}
		}
		if(closest_index >= 0)
		{
			o = nodes[closest_index];
			o = (o[0], o[1], self.origin[2]);
			dir = vectornormalize(o - self.origin);
			self setvehvelocity(self.velocity + (dir * 2000));
		}
		else
		{
			self setvehvelocity((self.velocity + (anglestoright(self.angles) * (randomintrange(-1000, 1000)))) + (0, 0, randomintrange(0, 1500)));
		}
	}
	else
	{
		self setvehvelocity((self.velocity + (anglestoright(self.angles) * (randomintrange(-1000, 1000)))) + (0, 0, randomintrange(0, 1500)));
	}
	self thread delay_set_gravity(randomfloatrange(1.5, 3));
	torque = (0, randomintrange(-90, 90), randomintrange(90, 720));
	if(randomint(100) < 50)
	{
		torque = (torque[0], torque[1], torque[2] * -1);
	}
	while(isdefined(self))
	{
		ang_vel = self getangularvelocity();
		ang_vel = ang_vel + (torque * 0.05);
		if(ang_vel[2] < 500 * -1)
		{
			ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
		}
		else if(ang_vel[2] > 500)
		{
			ang_vel = (ang_vel[0], ang_vel[1], 500);
		}
		self setangularvelocity(ang_vel);
		waitframe(1);
	}
}

/*
	Name: delay_set_gravity
	Namespace: vehicle_death
	Checksum: 0xC3FAB43E
	Offset: 0x2558
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function delay_set_gravity(delay)
{
	self endon(#"crash_move_done", #"death");
	wait(delay);
	self setphysacceleration((randomintrange(-1600, 1600), randomintrange(-1600, 1600), -1600));
}

/*
	Name: helicopter_crash_move
	Namespace: vehicle_death
	Checksum: 0xC550DD1B
	Offset: 0x25E0
	Size: 0x356
	Parameters: 2
	Flags: None
*/
function helicopter_crash_move(point, dir)
{
	self endon(#"crash_move_done", #"death");
	self thread crash_collision_test();
	self cancelaimove();
	self function_d4c687c9();
	self setturningability(0);
	self setphysacceleration(vectorscale((0, 0, -1), 800));
	vel = self.velocity;
	dir = vectornormalize(dir);
	ang_vel = self getangularvelocity();
	ang_vel = (0, ang_vel[1] * randomfloatrange(1, 3), 0);
	self setangularvelocity(ang_vel);
	point_2d = (point[0], point[1], self.origin[2]);
	torque = vectorscale((0, 1, 0), 720);
	if(distance(self.origin, point_2d) > 5)
	{
		local_hit_point = point_2d - self.origin;
		dir_2d = (dir[0], dir[1], 0);
		if(length(dir_2d) > 0.01)
		{
			dir_2d = vectornormalize(dir_2d);
			torque = vectorcross(vectornormalize(local_hit_point), dir);
			torque = (0, 0, torque[2]);
			torque = vectornormalize(torque);
			torque = (0, torque[2] * 180, 0);
		}
	}
	while(true)
	{
		ang_vel = self getangularvelocity();
		ang_vel = ang_vel + (torque * 0.05);
		if(ang_vel[1] < 360 * -1)
		{
			ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
		}
		else if(ang_vel[1] > 360)
		{
			ang_vel = (ang_vel[0], 360, ang_vel[2]);
		}
		self setangularvelocity(ang_vel);
		waitframe(1);
	}
}

/*
	Name: boat_crash
	Namespace: vehicle_death
	Checksum: 0x1BE02E1E
	Offset: 0x2940
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function boat_crash(point, dir)
{
	self.crashing = 1;
	if(isdefined(self.unloading))
	{
		while(isdefined(self.unloading))
		{
			waitframe(1);
		}
	}
	if(!isdefined(self))
	{
		return;
	}
	self thread boat_crash_movement(point, dir);
}

/*
	Name: boat_crash_movement
	Namespace: vehicle_death
	Checksum: 0xCA657A17
	Offset: 0x29B8
	Size: 0x2B6
	Parameters: 2
	Flags: Linked
*/
function boat_crash_movement(point, dir)
{
	self endon(#"crash_move_done", #"death");
	self cancelaimove();
	self function_d4c687c9();
	self setphysacceleration(vectorscale((0, 0, -1), 50));
	vel = self.velocity;
	dir = vectornormalize(dir);
	ang_vel = self getangularvelocity();
	ang_vel = (0, 0, 0);
	self setangularvelocity(ang_vel);
	torque = (randomintrange(-5, -3), 0, (randomintrange(0, 100) < 50 ? -5 : 5));
	self thread boat_crash_monitor(point, dir, 4);
	while(true)
	{
		ang_vel = self getangularvelocity();
		ang_vel = ang_vel + (torque * 0.05);
		if(ang_vel[1] < 360 * -1)
		{
			ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
		}
		else if(ang_vel[1] > 360)
		{
			ang_vel = (ang_vel[0], 360, ang_vel[2]);
		}
		self setangularvelocity(ang_vel);
		velocity = self.velocity;
		velocity = (velocity[0] * 0.975, velocity[1], velocity[2]);
		velocity = (velocity[0], velocity[1] * 0.975, velocity[2]);
		self setvehvelocity(velocity);
		waitframe(1);
	}
}

/*
	Name: boat_crash_monitor
	Namespace: vehicle_death
	Checksum: 0x89F438F3
	Offset: 0x2C78
	Size: 0x6E
	Parameters: 3
	Flags: Linked
*/
function boat_crash_monitor(point, dir, crash_time)
{
	self endon(#"death");
	wait(crash_time);
	self notify(#"crash_move_done");
	self crash_stop();
	self notify(#"crash_done");
}

/*
	Name: crash_stop
	Namespace: vehicle_death
	Checksum: 0xAEA45FC3
	Offset: 0x2CF0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function crash_stop()
{
	self endon(#"death");
	self setphysacceleration((0, 0, 0));
	self setrotorspeed(0);
	speed = self getspeedmph();
	while(speed > 2)
	{
		velocity = self.velocity;
		velocity = velocity * 0.9;
		self setvehvelocity(velocity);
		angular_velocity = self getangularvelocity();
		angular_velocity = angular_velocity * 0.9;
		self setangularvelocity(angular_velocity);
		speed = self getspeedmph();
		waitframe(1);
	}
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
}

/*
	Name: crash_collision_test
	Namespace: vehicle_death
	Checksum: 0x94D5F216
	Offset: 0x2E98
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function crash_collision_test()
{
	self endon(#"death");
	waitresult = undefined;
	waitresult = self waittill(#"veh_collision");
	normal = waitresult.normal;
	self helicopter_explode();
	self notify(#"crash_move_done");
	if(normal[2] > 0.7)
	{
		forward = anglestoforward(self.angles);
		right = vectorcross(normal, forward);
		desired_forward = vectorcross(right, normal);
		self setphysangles(vectortoangles(desired_forward));
		self crash_stop();
		self notify(#"crash_done");
	}
	else
	{
		waitframe(1);
		self delete();
	}
}

/*
	Name: wait_and_explode
	Namespace: vehicle_death
	Checksum: 0xB4FF33BC
	Offset: 0x3000
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function wait_and_explode()
{
	self endon(#"death");
	wait(2);
	self helicopter_explode();
}

/*
	Name: crash_path_check
	Namespace: vehicle_death
	Checksum: 0x2CD6371F
	Offset: 0x3040
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function crash_path_check(node)
{
	targ = node;
	for(search_depth = 5; isdefined(targ) && search_depth >= 0; search_depth--)
	{
		if(isdefined(targ.detoured) && targ.detoured == 0)
		{
			detourpath = vehicle::path_detour_get_detourpath(getvehiclenodearray(targ.target2, "targetname"));
			if(isdefined(detourpath) && isdefined(detourpath.script_crashtype))
			{
				self.nd_crash_path = detourpath;
				return true;
			}
		}
		if(isdefined(targ.target))
		{
			targ1 = getvehiclenode(targ.target, "targetname");
			if(isdefined(targ1) && isdefined(targ1.target) && isdefined(targ.targetname) && targ1.target == targ.targetname)
			{
				return false;
			}
			if(isdefined(targ1) && targ1 == node)
			{
				return false;
			}
			targ = targ1;
			continue;
		}
		targ = undefined;
	}
	return false;
}

/*
	Name: death_firesound
	Namespace: vehicle_death
	Checksum: 0x83DC3DE2
	Offset: 0x31F8
	Size: 0x70
	Parameters: 1
	Flags: None
*/
function death_firesound(sound)
{
	self thread sound::loop_on_tag(sound, undefined, 0);
	self waittill(#"fire_extinguish", #"stop_crash_loop_sound");
	if(!isdefined(self))
	{
		return;
	}
	self notify("stop sound" + sound);
}

/*
	Name: death_fx
	Namespace: vehicle_death
	Checksum: 0xC93A0B2A
	Offset: 0x3270
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function death_fx()
{
	if(self vehicle::is_destructible())
	{
		return;
	}
	self util::explode_notify_wrapper();
	if(isdefined(self.do_death_fx))
	{
		self [[self.do_death_fx]]();
	}
	else
	{
		self vehicle::do_death_fx();
	}
}

/*
	Name: death_make_badplace
	Namespace: vehicle_death
	Checksum: 0x33188B4
	Offset: 0x32E8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function death_make_badplace(type)
{
	if(!isdefined(level.vehicle_death_badplace[type]))
	{
		return;
	}
	struct = level.vehicle_death_badplace[type];
	if(isdefined(struct.delay))
	{
		wait(struct.delay);
	}
	if(!isdefined(self))
	{
		return;
	}
	badplace_box("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, "all");
}

/*
	Name: death_jolt
	Namespace: vehicle_death
	Checksum: 0x1DFF14AD
	Offset: 0x3398
	Size: 0x1CC
	Parameters: 3
	Flags: Linked
*/
function death_jolt(type, point, dir)
{
	self endon(#"death");
	if(isdefined(self.ignore_death_jolt) && self.ignore_death_jolt)
	{
		return;
	}
	self joltbody(self.origin + (23, 33, 64), 3);
	if(isdefined(self.death_anim))
	{
		self animscripted("death_anim", self.origin, self.angles, self.death_anim, "normal", "root", 1, 0);
		self waittillmatch({#notetrack:"end"}, #"death_anim");
	}
	else if(self.isphysicsvehicle)
	{
		num_launch_multiplier = self.physicslaunchdeathscale;
		var_e8ac46d8 = self.var_46b047ff;
		var_3c985f6 = self.var_263fc892;
		var_9defc7df = self.var_c7029bb1;
		self launchvehicle(vectorscale((0, 0, 1), 180) * num_launch_multiplier, (randomfloatrange(var_e8ac46d8, var_3c985f6), randomfloatrange(var_9defc7df * -1, var_9defc7df), 0), 1, 1);
	}
}

/*
	Name: deathrollon
	Namespace: vehicle_death
	Checksum: 0x80452786
	Offset: 0x3570
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function deathrollon()
{
	if(self.health > 0)
	{
		self.rollingdeath = 1;
	}
}

/*
	Name: deathrolloff
	Namespace: vehicle_death
	Checksum: 0x4721B7E2
	Offset: 0x3598
	Size: 0x1E
	Parameters: 0
	Flags: Linked
*/
function deathrolloff()
{
	self.rollingdeath = undefined;
	self notify(#"deathrolloff");
}

/*
	Name: loop_fx_on_vehicle_tag
	Namespace: vehicle_death
	Checksum: 0xCCF1CEB5
	Offset: 0x35C0
	Size: 0xAE
	Parameters: 3
	Flags: None
*/
function loop_fx_on_vehicle_tag(effect, looptime, tag)
{
	/#
		assert(isdefined(effect));
	#/
	/#
		assert(isdefined(tag));
	#/
	/#
		assert(isdefined(looptime));
	#/
	self endon(#"stop_looping_death_fx");
	while(isdefined(self))
	{
		playfxontag(effect, deathfx_ent(), tag);
		wait(looptime);
	}
}

/*
	Name: deathfx_ent
	Namespace: vehicle_death
	Checksum: 0x662BB99E
	Offset: 0x3678
	Size: 0x12A
	Parameters: 0
	Flags: Linked
*/
function deathfx_ent()
{
	if(!isdefined(self.deathfx_ent))
	{
		ent = spawn("script_model", (0, 0, 0));
		ent.targetname = "vehicle_deathfx";
		emodel = vehicle::get_dummy();
		ent setmodel(self.model);
		ent.origin = emodel.origin;
		ent.angles = emodel.angles;
		ent notsolid();
		ent hide();
		ent linkto(emodel);
		self.deathfx_ent = ent;
	}
	else
	{
		self.deathfx_ent setmodel(self.model);
	}
	return self.deathfx_ent;
}

/*
	Name: death_cleanup_level_variables
	Namespace: vehicle_death
	Checksum: 0x8EF0FFF9
	Offset: 0x37B0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function death_cleanup_level_variables()
{
	script_linkname = self.script_linkname;
	targetname = self.targetname;
	if(isdefined(script_linkname))
	{
		arrayremovevalue(level.vehicle_link[script_linkname], self);
	}
	if(isdefined(self.script_vehiclespawngroup))
	{
		if(isdefined(level.vehicle_spawngroup[self.script_vehiclespawngroup]))
		{
			arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], self);
			arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], undefined);
		}
	}
	if(isdefined(self.script_vehiclestartmove))
	{
		arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
	}
	if(isdefined(self.script_vehiclegroupdelete))
	{
		arrayremovevalue(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
	}
}

/*
	Name: death_cleanup_riders
	Namespace: vehicle_death
	Checksum: 0x1CEA58D3
	Offset: 0x38E0
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function death_cleanup_riders()
{
	if(isdefined(self.riders))
	{
		for(j = 0; j < self.riders.size; j++)
		{
			if(isdefined(self.riders[j]))
			{
				self.riders[j] delete();
			}
		}
	}
	if(vehicle::is_corpse(self))
	{
		self.riders = [];
	}
}

/*
	Name: death_radius_damage
	Namespace: vehicle_death
	Checksum: 0x75E25D76
	Offset: 0x3980
	Size: 0x15C
	Parameters: 3
	Flags: Linked
*/
function death_radius_damage(meansofdamage = "MOD_EXPLOSIVE", attacker, weapon)
{
	self endon(#"death");
	if(!isdefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0 || self.var_9d992ed1 === 1)
	{
		return;
	}
	position = self.origin + vectorscale((0, 0, 1), 15);
	radius = self.radiusdamageradius;
	damagemax = self.radiusdamagemax;
	damagemin = self.radiusdamagemin;
	if(!isdefined(attacker))
	{
		attacker = self;
	}
	waitframe(1);
	if(isdefined(self) && !isdefined(self.var_9d992ed1))
	{
		self.var_9d992ed1 = 1;
		self radiusdamage(position, radius, damagemax, damagemin, attacker, meansofdamage, weapon);
	}
}

/*
	Name: death_update_crash
	Namespace: vehicle_death
	Checksum: 0xC088F644
	Offset: 0x3AE8
	Size: 0x324
	Parameters: 2
	Flags: Linked
*/
function death_update_crash(point, dir)
{
	if(!isdefined(self.destructibledef))
	{
		if(isdefined(self.script_crashtypeoverride))
		{
			crashtype = self.script_crashtypeoverride;
			if(isdefined(self.currentnode))
			{
				crash_path_check(self.currentnode);
			}
		}
		else
		{
			if(self.vehicleclass === "plane")
			{
				crashtype = "aircraft";
			}
			else
			{
				if(self.vehicleclass === "helicopter")
				{
					crashtype = "helicopter";
				}
				else
				{
					if(self.vehicleclass === "boat")
					{
						crashtype = "boat";
					}
					else
					{
						if(isdefined(self.currentnode) && crash_path_check(self.currentnode))
						{
							crashtype = "none";
						}
						else
						{
							crashtype = "tank";
						}
					}
				}
			}
		}
		if(crashtype == "aircraft")
		{
			self thread aircraft_crash(point, dir);
		}
		else
		{
			if(crashtype == "helicopter")
			{
				if(isdefined(self.script_nocorpse))
				{
					self thread helicopter_explode();
				}
				else
				{
					self thread helicopter_crash(point, dir);
				}
			}
			else
			{
				if(crashtype == "boat")
				{
					self thread boat_crash(point, dir);
				}
				else
				{
					if(crashtype == "tank")
					{
						if(!isdefined(self.rollingdeath))
						{
							self vehicle::set_speed(0, 25, "Dead");
						}
						else
						{
							self waittill(#"deathrolloff");
							self vehicle::set_speed(0, 25, "Dead, finished path intersection");
						}
						wait(0.4);
						if(isdefined(self) && !vehicle::is_corpse(self))
						{
							self vehicle::set_speed(0, 10000, "deadstop");
							self notify(#"deadstop");
							if(self.disconnectpathonstop === 1)
							{
								self vehicle::disconnect_paths();
							}
							if(isdefined(self.tankgetout) && self.tankgetout > 0)
							{
								self waittill(#"animsdone");
							}
						}
					}
					else if(crashtype == "ground_vehicle_on_spline")
					{
						self thread ground_vehicle_crash();
					}
				}
			}
		}
	}
}

/*
	Name: ground_vehicle_crash
	Namespace: vehicle_death
	Checksum: 0x60C4C1E8
	Offset: 0x3E18
	Size: 0x3F6
	Parameters: 0
	Flags: Linked
*/
function ground_vehicle_crash()
{
	self endon(#"crash_done", #"crash_move_done", #"death");
	self thread monitor_ground_vehicle_crash_collision();
	self.crashing = 1;
	n_current_speed = self getspeedmph();
	if(n_current_speed > 0 || (isdefined(self.b_stopped_crash) && self.b_stopped_crash))
	{
		if(self is_crash_detour_nearby())
		{
			self notify(#"crashpath", {#path:self.nd_crash_path});
			self.nd_crash_path.derailed = 1;
			self notify(#"newpath");
			nd_switch = self.currentnode get_switch_node(self.nd_crash_path);
			self setswitchnode(nd_switch, self.nd_crash_path);
			self thread watch_for_crash_detour_scene(self.nd_crash_path);
			if(n_current_speed == 0)
			{
				n_current_speed = 5;
				self setbrake(0);
				self vehicle::resume_path();
				self resumespeed(5);
			}
			n_set_speed = n_current_speed * 3;
			self setspeed(n_set_speed, n_set_speed / 2);
			self waittilltimeout(15, #"reached_end_node");
		}
		else
		{
			self vehicle::detach_path();
			if(math::cointoss())
			{
				n_modifier = 1;
			}
			else
			{
				n_modifier = -1;
			}
			if(n_current_speed == 0)
			{
				n_current_speed = 5;
				self setbrake(0);
				self vehicle::resume_path();
				self resumespeed(5);
			}
			v_goal = self.origin + ((anglestoforward(self.angles + (0, n_modifier * 35, 0))) * 600);
			a_trace = physicstraceex(v_goal + vectorscale((0, 0, 1), 200), v_goal - vectorscale((0, 0, 1), 1000));
			n_set_speed = n_current_speed * 3;
			self setspeed(n_set_speed, n_set_speed / 2);
			self function_a57c34b7(a_trace[#"position"], 0);
			self waittilltimeout(15, #"near_goal");
			self vehicle_ai::clearallmovement(1);
			self vehicle_ai::clearalllookingandtargeting();
		}
	}
	self notify(#"crash_done");
}

/*
	Name: get_switch_node
	Namespace: vehicle_death
	Checksum: 0xFE8BBC91
	Offset: 0x4218
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function get_switch_node(nd_crash_path)
{
	nd_switch = self;
	for(n_search_depth = 5; isdefined(nd_switch) && n_search_depth >= 0; n_search_depth--)
	{
		if(isdefined(nd_switch.target2))
		{
			a_nd_crash = getvehiclenodearray(nd_switch.target2, "targetname");
			if(isdefined(a_nd_crash) && isinarray(a_nd_crash, nd_crash_path))
			{
				return nd_switch;
			}
		}
		if(isdefined(nd_switch.target))
		{
			nd_switch = getvehiclenode(nd_switch.target, "targetname");
			continue;
		}
		nd_switch = undefined;
	}
	return self;
}

/*
	Name: watch_for_crash_detour_scene
	Namespace: vehicle_death
	Checksum: 0x610828B0
	Offset: 0x4318
	Size: 0x1BE
	Parameters: 1
	Flags: Linked
*/
function watch_for_crash_detour_scene(nd_crash_path)
{
	self endon(#"delete");
	nd_current = nd_crash_path;
	while(isdefined(nd_current))
	{
		if(isdefined(nd_current.target))
		{
			nd_current = getvehiclenode(nd_current.target, "targetname");
		}
		else
		{
			if(isdefined(nd_current.script_crashpath_scene))
			{
				s_crash_scene = struct::get(nd_current.script_crashpath_scene, "script_crashpath_scene");
				nd_crash = nd_current;
				nd_current = undefined;
			}
			else
			{
				return;
			}
		}
	}
	self.dontfreeme = 1;
	self thread vehicle_stopped_on_crashpath();
	str_result = self util::waittill_either("reached_end_node", "stopped_while_crashing");
	if(str_result === "stopped_while_crashing" && isdefined(nd_crash))
	{
		/#
			iprintln(("" + nd_crash.origin) + "");
		#/
	}
	if(isdefined(s_crash_scene) && isdefined(s_crash_scene.scriptbundlename))
	{
		s_crash_scene scene::play(s_crash_scene.scriptbundlename, self);
	}
	self.dontfreeme = undefined;
}

/*
	Name: vehicle_stopped_on_crashpath
	Namespace: vehicle_death
	Checksum: 0xEA694623
	Offset: 0x44E0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function vehicle_stopped_on_crashpath()
{
	self endon(#"reached_end_node");
	while(isdefined(self) && (isdefined(self.dontfreeme) && self.dontfreeme))
	{
		if(self getspeedmph() == 0)
		{
			self notify(#"stopped_while_crashing");
		}
		waitframe(1);
	}
}

/*
	Name: is_crash_detour_nearby
	Namespace: vehicle_death
	Checksum: 0x3D39EC92
	Offset: 0x4558
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function is_crash_detour_nearby()
{
	if(isdefined(self.nd_crash_path))
	{
		n_dist = distance(self.origin, self.nd_crash_path.origin);
		if(n_dist < 1000 && util::within_fov(self.origin, self.angles, self.nd_crash_path.origin, cos(90)))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: monitor_ground_vehicle_crash_collision
	Namespace: vehicle_death
	Checksum: 0xC5DB724D
	Offset: 0x4610
	Size: 0x1CE
	Parameters: 0
	Flags: Linked
*/
function monitor_ground_vehicle_crash_collision()
{
	self endon(#"death", #"crash_done");
	waitresult = self thread ground_predicted_collision();
	waitresult = undefined;
	waitresult = self waittill(#"veh_collision");
	normal = waitresult.normal;
	ent = waitresult.target;
	if(vehicle::is_corpse(ent))
	{
		ent ground_vehicle_explode(1);
	}
	else
	{
		if(isvehicle(ent))
		{
			self ground_vehicle_explode(1);
		}
		else
		{
			self ground_vehicle_explode();
			self notify(#"crash_move_done");
			forward = anglestoforward(self.angles);
			right = vectorcross(normal, forward);
			desired_forward = vectorcross(right, normal);
			self setphysangles(vectortoangles(desired_forward));
			self crash_stop();
			self notify(#"crash_done");
		}
	}
}

/*
	Name: ground_predicted_collision
	Namespace: vehicle_death
	Checksum: 0x14ECDBDE
	Offset: 0x47E8
	Size: 0xD0
	Parameters: 0
	Flags: Linked
*/
function ground_predicted_collision()
{
	self endon(#"crash_done", #"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_predictedcollision");
		ent = waitresult.target;
		if(isdefined(ent) && self istouching(ent))
		{
			self notify(#"veh_collision", waitresult);
			callback::callback(#"veh_collision", waitresult);
		}
	}
}

/*
	Name: ground_vehicle_explode
	Namespace: vehicle_death
	Checksum: 0xD394D4FA
	Offset: 0x48C0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function ground_vehicle_explode(b_delete_me = 0)
{
	self endon(#"death");
	self vehicle::do_death_fx();
	if(b_delete_me)
	{
		self delete();
	}
	else
	{
		self thread set_death_model(self.deathmodel, self.modelswapdelay);
	}
}

/*
	Name: waittill_crash_done_or_stopped
	Namespace: vehicle_death
	Checksum: 0x3DD7C40C
	Offset: 0x4958
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function waittill_crash_done_or_stopped()
{
	self endon(#"death");
	if(isdefined(self) && (self.vehicleclass === "plane" || self.script_crashtypeoverride === "ground_vehicle_on_spline"))
	{
		if(isdefined(self.crashing) && self.crashing == 1)
		{
			self waittill(#"crash_done");
		}
	}
	else
	{
		wait(0.2);
		if(isdefined(self) && self.isphysicsvehicle)
		{
			self function_d4c687c9();
			self cancelaimove();
			stable_count = 0;
			while(stable_count < 3)
			{
				if(self.var_4217cfcb === 1)
				{
					break;
				}
				if(isdefined(self.velocity) && lengthsquared(self.velocity) > 1)
				{
					stable_count = 0;
				}
				else
				{
					stable_count++;
				}
				wait(0.3);
			}
			self vehicle::disconnect_paths();
		}
		else
		{
			while(isdefined(self) && self getspeedmph() > 0)
			{
				wait(0.3);
			}
		}
	}
}

/*
	Name: vehicle_damage_filter_damage_watcher
	Namespace: vehicle_death
	Checksum: 0xC4E13FA0
	Offset: 0x4B00
	Size: 0x176
	Parameters: 2
	Flags: Linked
*/
function vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold)
{
	self endon(#"death", #"exit_vehicle", #"end_damage_filter");
	if(!isdefined(heavy_damage_threshold))
	{
		heavy_damage_threshold = 100;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		earthquake(0.25, 0.15, self.origin, 512, self);
		driver playrumbleonentity("damage_light");
		time = gettime();
		if(time - level.n_last_damage_time > 500)
		{
			level.n_hud_damage = 1;
			if(waitresult.amount > heavy_damage_threshold)
			{
				driver playsound(#"veh_damage_filter_heavy");
			}
			else
			{
				driver playsound(#"veh_damage_filter_light");
			}
			level.n_last_damage_time = gettime();
		}
	}
}

/*
	Name: vehicle_damage_filter_exit_watcher
	Namespace: vehicle_death
	Checksum: 0x9FA1CA7A
	Offset: 0x4C80
	Size: 0x42
	Parameters: 1
	Flags: Linked
*/
function vehicle_damage_filter_exit_watcher(driver)
{
	self waittill(#"exit_vehicle", #"death", #"end_damage_filter");
}

/*
	Name: vehicle_damage_filter
	Namespace: vehicle_death
	Checksum: 0xA79B078
	Offset: 0x4CD0
	Size: 0x190
	Parameters: 4
	Flags: None
*/
function vehicle_damage_filter(vision_set, heavy_damage_threshold, filterid = 0, b_use_player_damage = 0)
{
	self endon(#"death", #"exit_vehicle", #"end_damage_filter");
	driver = self getseatoccupant(0);
	if(!isdefined(self.damage_filter_init))
	{
		self.damage_filter_init = 1;
	}
	level.n_hud_damage = 0;
	level.n_last_damage_time = gettime();
	damagee = (b_use_player_damage ? driver : self);
	damagee thread vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold);
	damagee thread vehicle_damage_filter_exit_watcher(driver);
	while(true)
	{
		if(isdefined(level.n_hud_damage) && level.n_hud_damage)
		{
			time = gettime();
			if(time - level.n_last_damage_time > 500)
			{
				level.n_hud_damage = 0;
			}
		}
		waitframe(1);
	}
}

/*
	Name: flipping_shooting_death
	Namespace: vehicle_death
	Checksum: 0xBEC1FBCE
	Offset: 0x4E68
	Size: 0x1A4
	Parameters: 2
	Flags: None
*/
function flipping_shooting_death(attacker, hitdir)
{
	if(isdefined(self.delete_on_death))
	{
		if(isdefined(self))
		{
			self delete();
		}
		return;
	}
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self death_cleanup_level_variables();
	self disableaimassist();
	self death_fx();
	self thread death_radius_damage();
	self thread set_death_model(self.deathmodel, self.modelswapdelay);
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self vehicle::lights_off();
	self thread flipping_shooting_crash_movement(attacker, hitdir);
	self waittill(#"crash_done");
	while(isdefined(self.controlled) && self.controlled)
	{
		waitframe(1);
	}
	self delete();
}

/*
	Name: plane_crash
	Namespace: vehicle_death
	Checksum: 0x1C91FDD6
	Offset: 0x5018
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function plane_crash()
{
	self endon(#"death");
	self setphysacceleration(vectorscale((0, 0, -1), 1000));
	self.vehcheckforpredictedcrash = 1;
	forward = anglestoforward(self.angles);
	forward_mag = randomfloatrange(0, 300);
	forward_mag = forward_mag + (math::sign(forward_mag) * 400);
	forward = forward * forward_mag;
	new_vel = forward + (self.velocity * 0.2);
	ang_vel = self getangularvelocity();
	yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
	yaw_vel = yaw_vel + (math::sign(yaw_vel) * 20);
	ang_vel = (randomfloatrange(-1, 1), yaw_vel, 0);
	roll_amount = (abs(ang_vel[1]) / 150) * 30;
	if(ang_vel[1] > 0)
	{
		roll_amount = roll_amount * -1;
	}
	self.angles = (self.angles[0], self.angles[1], roll_amount);
	ang_vel = (ang_vel[0], ang_vel[1], roll_amount * 0.9);
	self.velocity_rotation_frac = 1;
	self.crash_accel = randomfloatrange(65, 90);
	set_movement_and_accel(new_vel, ang_vel);
}

/*
	Name: barrel_rolling_crash
	Namespace: vehicle_death
	Checksum: 0x40101140
	Offset: 0x5290
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function barrel_rolling_crash()
{
	self endon(#"death");
	self setphysacceleration(vectorscale((0, 0, -1), 1000));
	self.vehcheckforpredictedcrash = 1;
	forward = anglestoforward(self.angles);
	forward_mag = randomfloatrange(0, 250);
	forward_mag = forward_mag + (math::sign(forward_mag) * 300);
	forward = forward * forward_mag;
	new_vel = forward + vectorscale((0, 0, 1), 70);
	ang_vel = self getangularvelocity();
	yaw_vel = randomfloatrange(0, 60) * math::sign(ang_vel[1]);
	yaw_vel = yaw_vel + (math::sign(yaw_vel) * 30);
	roll_vel = randomfloatrange(-200, 200);
	roll_vel = roll_vel + (math::sign(roll_vel) * 300);
	ang_vel = (randomfloatrange(-5, 5), yaw_vel, roll_vel);
	self.velocity_rotation_frac = 1;
	self.crash_accel = randomfloatrange(145, 210);
	self setphysacceleration(vectorscale((0, 0, -1), 250));
	set_movement_and_accel(new_vel, ang_vel);
}

/*
	Name: random_crash
	Namespace: vehicle_death
	Checksum: 0x322A1EAA
	Offset: 0x54D0
	Size: 0x2F4
	Parameters: 1
	Flags: Linked
*/
function random_crash(hitdir)
{
	self endon(#"death");
	self setphysacceleration(vectorscale((0, 0, -1), 1000));
	self.vehcheckforpredictedcrash = 1;
	if(!isdefined(hitdir))
	{
		hitdir = (1, 0, 0);
	}
	hitdir = vectornormalize(hitdir);
	side_dir = vectorcross(hitdir, (0, 0, 1));
	side_dir_mag = randomfloatrange(-280, 280);
	side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 150);
	side_dir = side_dir * side_dir_mag;
	forward = anglestoforward(self.angles);
	forward_mag = randomfloatrange(0, 300);
	forward_mag = forward_mag + (math::sign(forward_mag) * 30);
	forward = forward * forward_mag;
	new_vel = (((self.velocity * 1.2) + forward) + side_dir) + vectorscale((0, 0, 1), 50);
	ang_vel = self getangularvelocity();
	ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 1.2);
	yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
	yaw_vel = yaw_vel + (math::sign(yaw_vel) * 50);
	ang_vel = ang_vel + (randomfloatrange(-5, 5), yaw_vel, randomfloatrange(-18, 18));
	self.velocity_rotation_frac = randomfloatrange(0.3, 0.99);
	self.crash_accel = randomfloatrange(65, 90);
	set_movement_and_accel(new_vel, ang_vel);
}

/*
	Name: set_movement_and_accel
	Namespace: vehicle_death
	Checksum: 0x8F1B186A
	Offset: 0x57D0
	Size: 0x21E
	Parameters: 2
	Flags: Linked
*/
function set_movement_and_accel(new_vel, ang_vel)
{
	self death_fx();
	self thread death_radius_damage();
	self setvehvelocity(new_vel);
	self setangularvelocity(ang_vel);
	if(!isdefined(self.off))
	{
		self thread flipping_shooting_crash_accel();
	}
	self thread vehicle_ai::nudge_collision();
	self playsound(#"veh_wasp_dmg_hit");
	self vehicle::toggle_sounds(0);
	if(!isdefined(self.off))
	{
		self thread flipping_shooting_dmg_snd();
	}
	wait(0.1);
	if(randomint(100) < 40 && !isdefined(self.off) && self.variant !== "rocket")
	{
		self thread vehicle_ai::fire_for_time(randomfloatrange(0.7, 2));
	}
	result = undefined;
	result = self waittilltimeout(15, #"crash_done");
	if(result._notify === "crash_done")
	{
		self vehicle::do_death_dynents();
		self set_death_model(self.deathmodel, self.modelswapdelay);
	}
	else
	{
		self notify(#"crash_done");
	}
}

/*
	Name: flipping_shooting_crash_movement
	Namespace: vehicle_death
	Checksum: 0xBE95FA72
	Offset: 0x59F8
	Size: 0x1C2
	Parameters: 2
	Flags: Linked
*/
function flipping_shooting_crash_movement(attacker, hitdir)
{
	self endon(#"crash_done", #"death");
	self cancelaimove();
	self function_d4c687c9();
	self vehclearlookat();
	self setphysacceleration(vectorscale((0, 0, -1), 1000));
	self.vehcheckforpredictedcrash = 1;
	if(!isdefined(hitdir))
	{
		hitdir = (1, 0, 0);
	}
	hitdir = vectornormalize(hitdir);
	new_vel = self.velocity;
	self.crash_style = getdvarint(#"debug_crash_type", 0);
	if(self.crash_style == -1)
	{
		self.crash_style = randomint(3);
	}
	switch(self.crash_style)
	{
		case 0:
		{
			barrel_rolling_crash();
			break;
		}
		case 1:
		{
			plane_crash();
			break;
		}
		default:
		{
			random_crash(hitdir);
		}
	}
}

/*
	Name: flipping_shooting_dmg_snd
	Namespace: vehicle_death
	Checksum: 0x880F3DCA
	Offset: 0x5BC8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function flipping_shooting_dmg_snd()
{
	dmg_ent = spawn("script_origin", self.origin);
	dmg_ent linkto(self);
	dmg_ent playloopsound(#"veh_wasp_dmg_loop");
	self waittill(#"crash_done", #"death");
	dmg_ent stoploopsound(1);
	wait(2);
	dmg_ent delete();
}

/*
	Name: flipping_shooting_crash_accel
	Namespace: vehicle_death
	Checksum: 0x40EC9542
	Offset: 0x5C90
	Size: 0x306
	Parameters: 0
	Flags: Linked
*/
function flipping_shooting_crash_accel()
{
	self endon(#"crash_done", #"death");
	count = 0;
	prev_forward = anglestoforward(self.angles);
	prev_forward_vel = vectordot(self.velocity, prev_forward) * self.velocity_rotation_frac;
	if(prev_forward_vel < 0)
	{
		prev_forward_vel = 0;
	}
	while(true)
	{
		self setvehvelocity(self.velocity + (anglestoup(self.angles) * self.crash_accel));
		self.crash_accel = self.crash_accel * 0.98;
		new_velocity = self.velocity;
		new_velocity = new_velocity - (prev_forward * prev_forward_vel);
		forward = anglestoforward(self.angles);
		new_velocity = new_velocity + (forward * prev_forward_vel);
		prev_forward = forward;
		prev_forward_vel = vectordot(new_velocity, prev_forward) * self.velocity_rotation_frac;
		if(prev_forward_vel < 10)
		{
			new_velocity = new_velocity + (forward * 40);
			prev_forward_vel = 0;
		}
		self setvehvelocity(new_velocity);
		wait(0.1);
		count++;
		if((count % 8) == 0 && randomint(100) > 40)
		{
			if(self.velocity[2] > 130)
			{
				self.crash_accel = self.crash_accel * 0.75;
			}
			else if(self.velocity[2] < 40 && count < 60)
			{
				if(abs(self.angles[0]) > 35 || abs(self.angles[2]) > 35)
				{
					self.crash_accel = randomfloatrange(100, 150);
				}
				else
				{
					self.crash_accel = randomfloatrange(45, 70);
				}
			}
		}
	}
}

/*
	Name: death_fire_loop_audio
	Namespace: vehicle_death
	Checksum: 0x95F7AC1C
	Offset: 0x5FA0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function death_fire_loop_audio()
{
	sound_ent = spawn("script_origin", self.origin);
	sound_ent playloopsound(#"veh_qrdrone_death_fire_loop", 0.1);
	wait(11);
	sound_ent stoploopsound(1);
	sound_ent delete();
}

/*
	Name: freewhensafe
	Namespace: vehicle_death
	Checksum: 0x10278ADB
	Offset: 0x6038
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function freewhensafe(time = 4)
{
	self thread delayedremove_thread(time, 0);
}

/*
	Name: deletewhensafe
	Namespace: vehicle_death
	Checksum: 0xFBD49A3E
	Offset: 0x6078
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function deletewhensafe(time = 4)
{
	self thread delayedremove_thread(time, 1);
}

/*
	Name: delayedremove_thread
	Namespace: vehicle_death
	Checksum: 0xBFD3A22E
	Offset: 0x60C0
	Size: 0x152
	Parameters: 2
	Flags: Linked
*/
function delayedremove_thread(time, shoulddelete)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"free_vehicle");
	if(shoulddelete === 1)
	{
		if(isvehicle(self))
		{
			self setvehvelocity((0, 0, 0));
		}
		if(!(isdefined(self.var_4dba1441) && self.var_4dba1441))
		{
			self ghost();
		}
		self notsolid();
	}
	util::waitfortimeandnetworkframe(time);
	if(shoulddelete === 1)
	{
		self delete();
	}
	else if(!(isdefined(self.no_free_on_death) && self.no_free_on_death))
	{
		self thread cleanup();
		self freevehicle();
		self.isacorpse = 1;
	}
}

/*
	Name: cleanup
	Namespace: vehicle_death
	Checksum: 0xEC0675E6
	Offset: 0x6220
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function cleanup()
{
	if(isdefined(self.cleanup_after_time))
	{
		wait(self.cleanup_after_time);
		if(isdefined(self))
		{
			self delete();
		}
	}
}

/*
	Name: corpse_explode_fx
	Namespace: vehicle_death
	Checksum: 0xDBCDDF2
	Offset: 0x6260
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function corpse_explode_fx()
{
	if(!isdefined(self.settings))
	{
		return;
	}
	if(isdefined(self.settings.var_c38f5e3b) && isdefined(self.settings.var_90c50d1a))
	{
		playfxontag(self.settings.var_c38f5e3b, self, self.settings.var_90c50d1a);
	}
	if(isdefined(self.settings.var_4ae18c9b))
	{
		self playsound(self.settings.var_4ae18c9b);
	}
}

/*
	Name: function_933d48a2
	Namespace: vehicle_death
	Checksum: 0xE21BD5D
	Offset: 0x6310
	Size: 0x1A8
	Parameters: 0
	Flags: None
*/
function function_933d48a2()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"veh_predictedcollision");
		if(isdefined(waitresult.target))
		{
			var_e2031bd1 = waitresult.target;
			if(!vehicle::is_corpse(var_e2031bd1) || (isdefined(var_e2031bd1.var_3acf1c07) && var_e2031bd1.var_3acf1c07))
			{
				continue;
			}
			if(!isdefined(var_e2031bd1.settings) || (!(isdefined(var_e2031bd1.settings.var_3a42a4d9) && var_e2031bd1.settings.var_3a42a4d9)))
			{
				continue;
			}
			speed = self getspeed();
			maxspeed = self getmaxspeed();
			if(speed / maxspeed < 0.75)
			{
				continue;
			}
			var_e2031bd1.var_3acf1c07 = 1;
			var_e2031bd1 corpse_explode_fx();
			var_e2031bd1 vehicle::do_death_dynents();
			var_e2031bd1 deletewhensafe();
		}
	}
}

