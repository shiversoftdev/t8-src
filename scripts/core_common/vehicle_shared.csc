// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicleriders_shared.csc;

#namespace vehicle;

/*
	Name: __init__system__
	Namespace: vehicle
	Checksum: 0xB48782F3
	Offset: 0x9B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"vehicle_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: vehicle
	Checksum: 0x94F91AFF
	Offset: 0x9F8
	Size: 0xF5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._customvehiclecbfunc = &spawned_callback;
	level.var_e583fd9b = &function_2f2a656a;
	level.var_8e36d09b = &function_cc71cf1a;
	level.allvehicles = [];
	clientfield::register("vehicle", "toggle_lockon", 1, 1, "int", &field_toggle_lockon_handler, 0, 0);
	clientfield::register("vehicle", "toggle_sounds", 1, 1, "int", &field_toggle_sounds, 0, 0);
	clientfield::register("vehicle", "use_engine_damage_sounds", 1, 2, "int", &field_use_engine_damage_sounds, 0, 0);
	clientfield::register("vehicle", "toggle_treadfx", 1, 1, "int", &field_toggle_treadfx, 0, 0);
	clientfield::register("vehicle", "toggle_exhaustfx", 1, 1, "int", &field_toggle_exhaustfx_handler, 0, 0);
	clientfield::register("vehicle", "toggle_lights", 1, 2, "int", &field_toggle_lights_handler, 0, 0);
	clientfield::register("vehicle", "toggle_lights_group1", 1, 1, "int", &field_toggle_lights_group_handler1, 0, 0);
	clientfield::register("vehicle", "toggle_lights_group2", 1, 1, "int", &field_toggle_lights_group_handler2, 0, 0);
	clientfield::register("vehicle", "toggle_lights_group3", 1, 1, "int", &field_toggle_lights_group_handler3, 0, 0);
	clientfield::register("vehicle", "toggle_lights_group4", 1, 1, "int", &field_toggle_lights_group_handler4, 0, 0);
	clientfield::register("vehicle", "toggle_force_driver_taillights", 1, 1, "int", &function_7baff7f6, 0, 0);
	clientfield::register("vehicle", "toggle_ambient_anim_group1", 1, 1, "int", &field_toggle_ambient_anim_handler1, 0, 0);
	clientfield::register("vehicle", "toggle_ambient_anim_group2", 1, 1, "int", &field_toggle_ambient_anim_handler2, 0, 0);
	clientfield::register("vehicle", "toggle_ambient_anim_group3", 1, 1, "int", &field_toggle_ambient_anim_handler3, 0, 0);
	clientfield::register("vehicle", "toggle_control_bone_group1", 1, 1, "int", &function_d427b534, 0, 0);
	clientfield::register("vehicle", "toggle_control_bone_group2", 1, 1, "int", &nova_crawler_spawnerbamfterminate, 0, 0);
	clientfield::register("vehicle", "toggle_control_bone_group3", 1, 1, "int", &function_48a01e23, 0, 0);
	clientfield::register("vehicle", "toggle_control_bone_group4", 1, 1, "int", &function_6ad96295, 0, 0);
	clientfield::register("vehicle", "toggle_emp_fx", 1, 1, "int", &field_toggle_emp, 0, 0);
	clientfield::register("vehicle", "toggle_burn_fx", 1, 1, "int", &field_toggle_burn, 0, 0);
	clientfield::register("vehicle", "deathfx", 1, 2, "int", &field_do_deathfx, 0, 1);
	clientfield::register("vehicle", "stopallfx", 1, 1, "int", &function_1ea3bdef, 0, 0);
	clientfield::register("vehicle", "flickerlights", 1, 2, "int", &flicker_lights, 0, 0);
	clientfield::register("vehicle", "alert_level", 1, 2, "int", &field_update_alert_level, 0, 0);
	clientfield::register("vehicle", "set_lighting_ent", 1, 1, "int", &util::field_set_lighting_ent, 0, 0);
	clientfield::register("vehicle", "stun", 1, 1, "int", &function_d7a2c2f, 0, 0);
	clientfield::register("vehicle", "use_lighting_ent", 1, 1, "int", &util::field_use_lighting_ent, 0, 0);
	clientfield::register("vehicle", "damage_level", 1, 3, "int", &field_update_damage_state, 0, 0);
	clientfield::register("vehicle", "spawn_death_dynents", 1, 2, "int", &field_death_spawn_dynents, 0, 0);
	clientfield::register("vehicle", "spawn_gib_dynents", 1, 1, "int", &field_gib_spawn_dynents, 0, 0);
	clientfield::register("vehicle", "toggle_horn_sound", 1, 1, "int", &function_2d24296, 0, 0);
	clientfield::register("vehicle", "update_malfunction", 1, 2, "int", &function_7d1d0e65, 0, 0);
	if(!sessionmodeiszombiesgame() && (!(isdefined(level.var_7b05c4b5) && level.var_7b05c4b5)))
	{
		clientfield::register("clientuimodel", "vehicle.ammoCount", 1, 10, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.ammoReloading", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.ammoLow", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.rocketAmmo", 1, 2, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.ammo2Count", 1, 10, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.ammo2Reloading", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.ammo2Low", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.collisionWarning", 1, 2, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.enemyInReticle", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.missileRepulsed", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.incomingMissile", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.missileLock", 1, 2, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.malfunction", 1, 2, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.showHoldToExitPrompt", 1, 1, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.holdToExitProgress", 1, 5, "float", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.vehicleAttackMode", 1, 3, "int", undefined, 0, 0);
		clientfield::register("clientuimodel", "vehicle.invalidLanding", 1, 1, "int", undefined, 0, 0);
		for(i = 0; i < 3; i++)
		{
			clientfield::register("clientuimodel", ("vehicle.bindingCooldown" + i) + ".cooldown", 1, 5, "float", undefined, 0, 0);
		}
	}
	clientfield::register("toplayer", "toggle_dnidamagefx", 1, 1, "int", &field_toggle_dnidamagefx, 0, 0);
	clientfield::register("toplayer", "toggle_flir_postfx", 1, 2, "int", &toggle_flir_postfxbundle, 0, 0);
	clientfield::register("toplayer", "static_postfx", 1, 1, "int", &set_static_postfxbundle, 0, 1);
	clientfield::register("vehicle", "vehUseMaterialPhysics", 1, 1, "int", &function_9facca21, 0, 0);
	clientfield::register("scriptmover", "play_flare_fx", 1, 1, "int", &play_flare_fx, 0, 0);
	clientfield::register("scriptmover", "play_flare_hit_fx", 1, 1, "int", &play_flare_hit_fx, 0, 0);
}

/*
	Name: add_vehicletype_callback
	Namespace: vehicle
	Checksum: 0x5454140
	Offset: 0x1960
	Size: 0x92
	Parameters: 3
	Flags: None
*/
function add_vehicletype_callback(vehicletype, callback, data = undefined)
{
	if(!isdefined(level.vehicletypecallbackarray))
	{
		level.vehicletypecallbackarray = [];
	}
	if(!isdefined(level.var_1ac8f820))
	{
		level.var_1ac8f820 = [];
	}
	level.vehicletypecallbackarray[vehicletype] = callback;
	level.var_1ac8f820[vehicletype] = data;
}

/*
	Name: function_dd27aacd
	Namespace: vehicle
	Checksum: 0xA3F9EE6C
	Offset: 0x1A00
	Size: 0x9A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_dd27aacd(localclientnum, vehicletype)
{
	if(isdefined(vehicletype) && isdefined(level.vehicletypecallbackarray[vehicletype]))
	{
		if(isdefined(level.var_1ac8f820[vehicletype]))
		{
			self thread [[level.vehicletypecallbackarray[vehicletype]]](localclientnum, level.var_1ac8f820[vehicletype]);
		}
		else
		{
			self thread [[level.vehicletypecallbackarray[vehicletype]]](localclientnum);
		}
		return true;
	}
	return false;
}

/*
	Name: spawned_callback
	Namespace: vehicle
	Checksum: 0x31B6CE14
	Offset: 0x1AA8
	Size: 0x11C
	Parameters: 1
	Flags: Linked
*/
function spawned_callback(localclientnum)
{
	if(isdefined(self.vehicleridersbundle))
	{
		set_vehicleriders_bundle(self.vehicleridersbundle);
	}
	self callback::callback(#"on_vehicle_spawned", localclientnum);
	vehicletype = self.vehicletype;
	if(isdefined(level.vehicletypecallbackarray))
	{
		if(!function_dd27aacd(localclientnum, vehicletype))
		{
			function_dd27aacd(localclientnum, self.scriptvehicletype);
		}
	}
	if(self usessubtargets())
	{
		self thread function_529fa01();
	}
	array::add(level.allvehicles, self, 0);
	self callback::on_shutdown(&on_shutdown);
}

/*
	Name: function_2f97bc52
	Namespace: vehicle
	Checksum: 0xD4268362
	Offset: 0x1BD0
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_2f97bc52(vehicletype, callback)
{
	if(!isdefined(level.var_fedb0575))
	{
		level.var_fedb0575 = [];
	}
	level.var_fedb0575[vehicletype] = callback;
}

/*
	Name: function_2f2a656a
	Namespace: vehicle
	Checksum: 0x741984CD
	Offset: 0x1C28
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function function_2f2a656a(localclientnum, vehicle)
{
	if(isdefined(vehicle))
	{
		vehicletype = vehicle.vehicletype;
		if(isdefined(vehicletype) && isdefined(level.var_fedb0575) && isdefined(level.var_fedb0575[vehicletype]))
		{
			self thread [[level.var_fedb0575[vehicletype]]](localclientnum, vehicle);
		}
	}
}

/*
	Name: function_cd2ede5
	Namespace: vehicle
	Checksum: 0x3E188584
	Offset: 0x1CB0
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_cd2ede5(vehicletype, callback)
{
	if(!isdefined(level.var_9b02f595))
	{
		level.var_9b02f595 = [];
	}
	level.var_9b02f595[vehicletype] = callback;
}

/*
	Name: function_cc71cf1a
	Namespace: vehicle
	Checksum: 0xE6131AD3
	Offset: 0x1D08
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function function_cc71cf1a(localclientnum, vehicle)
{
	if(isdefined(vehicle))
	{
		vehicletype = vehicle.vehicletype;
		if(isdefined(vehicletype) && isdefined(level.var_9b02f595) && isdefined(level.var_9b02f595[vehicletype]))
		{
			self thread [[level.var_9b02f595[vehicletype]]](localclientnum, vehicle);
		}
	}
}

/*
	Name: on_shutdown
	Namespace: vehicle
	Checksum: 0xC1F106B7
	Offset: 0x1D90
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function on_shutdown(localclientnum)
{
	self function_dcec5385();
	arrayremovevalue(level.allvehicles, self);
}

/*
	Name: function_529fa01
	Namespace: vehicle
	Checksum: 0x8B8B7A44
	Offset: 0x1DE0
	Size: 0xC8
	Parameters: 0
	Flags: Linked
*/
function function_529fa01()
{
	self endon(#"death");
	self.notifyonbulletimpact = 1;
	while(isdefined(self))
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		subtarget = waitresult.subtarget;
		attacker = waitresult.attacker;
		if(attacker function_21c0fa55() && isdefined(subtarget) && subtarget > 0)
		{
			self thread function_a87e7c22(subtarget);
		}
	}
}

/*
	Name: function_a87e7c22
	Namespace: vehicle
	Checksum: 0xF7B43DC4
	Offset: 0x1EB0
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_a87e7c22(subtarget)
{
	self endon(#"death");
	time = gettime();
	if(isdefined(subtarget))
	{
		if(!isdefined(self.var_d2c05029))
		{
			self.var_d2c05029 = [];
		}
		if(!isdefined(self.var_d2c05029[subtarget]) || self.var_d2c05029[subtarget] <= time)
		{
			self.var_d2c05029[subtarget] = time + 150;
			bone = self submodelboneforsubtarget(subtarget);
			self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
			wait(0.1);
			self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d", bone);
		}
	}
	else
	{
		self playrenderoverridebundle(#"hash_20bdbaa0db5eb57d");
		wait(0.15);
		self stoprenderoverridebundle(#"hash_20bdbaa0db5eb57d");
	}
}

/*
	Name: rumble
	Namespace: vehicle
	Checksum: 0x36DAE123
	Offset: 0x2010
	Size: 0x2B6
	Parameters: 1
	Flags: None
*/
function rumble(localclientnum)
{
	self endon(#"death");
	if(!isdefined(self.rumbletype) || self.rumbleradius == 0)
	{
		return;
	}
	if(!isdefined(self.rumbleon))
	{
		self.rumbleon = 1;
	}
	height = self.rumbleradius * 2;
	zoffset = -1 * self.rumbleradius;
	self.player_touching = 0;
	radius_squared = self.rumbleradius * self.rumbleradius;
	wait(2);
	while(true)
	{
		if(!isdefined(level.localplayers[localclientnum]) || distancesquared(self.origin, level.localplayers[localclientnum].origin) > radius_squared || self getspeed() == 0)
		{
			wait(0.2);
			continue;
		}
		if(isdefined(self.rumbleon) && !self.rumbleon)
		{
			wait(0.2);
			continue;
		}
		self playrumblelooponentity(localclientnum, self.rumbletype);
		while(isdefined(level.localplayers[localclientnum]) && distancesquared(self.origin, level.localplayers[localclientnum].origin) < radius_squared && self getspeed() > 0)
		{
			earthquake(localclientnum, self.rumblescale, self.rumbleduration, self.origin, self.rumbleradius);
			time_to_wait = self.rumblebasetime + randomfloat(self.rumbleadditionaltime);
			if(time_to_wait <= 0)
			{
				time_to_wait = 0.05;
			}
			wait(time_to_wait);
		}
		if(isdefined(level.localplayers[localclientnum]))
		{
			self stoprumble(localclientnum, self.rumbletype);
		}
		waitframe(1);
	}
}

/*
	Name: kill_treads_forever
	Namespace: vehicle
	Checksum: 0xBBE0392B
	Offset: 0x22D0
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function kill_treads_forever()
{
	self notify(#"kill_treads_forever");
}

/*
	Name: play_exhaust
	Namespace: vehicle
	Checksum: 0x74B17B7A
	Offset: 0x22F0
	Size: 0x1C2
	Parameters: 1
	Flags: Linked
*/
function play_exhaust(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.csf_no_exhaust) && self.csf_no_exhaust)
	{
		return;
	}
	if(!isdefined(self.exhaust_fx) && isdefined(self.exhaustfxname))
	{
		if(!isdefined(level._effect))
		{
			level._effect = [];
		}
		if(!isdefined(level._effect[self.exhaustfxname]))
		{
			level._effect[self.exhaustfxname] = self.exhaustfxname;
		}
		self.exhaust_fx = level._effect[self.exhaustfxname];
	}
	if(isdefined(self.exhaust_fx) && isdefined(self.exhaustfxtag1))
	{
		if(isalive(self))
		{
			/#
				assert(isdefined(self.exhaustfxtag1), self.vehicletype + "");
			#/
			self endon(#"death");
			self util::waittill_dobj(localclientnum);
			self.exhaust_id_left = util::playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag1);
			if(!isdefined(self.exhaust_id_right) && isdefined(self.exhaustfxtag2))
			{
				self.exhaust_id_right = util::playfxontag(localclientnum, self.exhaust_fx, self, self.exhaustfxtag2);
			}
		}
	}
}

/*
	Name: stop_exhaust
	Namespace: vehicle
	Checksum: 0x497B10DC
	Offset: 0x24C0
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function stop_exhaust(localclientnum)
{
	self util::waittill_dobj(localclientnum);
	waitframe(1);
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.exhaust_id_left))
	{
		stopfx(localclientnum, self.exhaust_id_left);
		self.exhaust_id_left = undefined;
	}
	if(isdefined(self.exhaust_id_right))
	{
		stopfx(localclientnum, self.exhaust_id_right);
		self.exhaust_id_right = undefined;
	}
}

/*
	Name: boost_think
	Namespace: vehicle
	Checksum: 0x5EC2D3C3
	Offset: 0x2568
	Size: 0x88
	Parameters: 1
	Flags: None
*/
function boost_think(localclientnum)
{
	self endon(#"death");
	for(;;)
	{
		self waittill(#"veh_boost");
		self play_boost(localclientnum, 0);
		if(isinvehicle(localclientnum, self))
		{
			self play_boost(localclientnum, 1);
		}
	}
}

/*
	Name: play_boost
	Namespace: vehicle
	Checksum: 0xE24E34B6
	Offset: 0x25F8
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function play_boost(localclientnum, var_a7ba3864)
{
	if(var_a7ba3864)
	{
		var_121afd6f = self.var_9ded117e;
		var_c1da0b13 = self.var_8559c35b;
		var_74ceb128 = undefined;
	}
	else
	{
		var_121afd6f = self.var_82ecf3f7;
		var_c1da0b13 = self.var_41882855;
		var_74ceb128 = self.var_a75cf435;
	}
	if(isdefined(var_121afd6f))
	{
		if(isalive(self))
		{
			/#
				assert(isdefined(var_c1da0b13), self.vehicletype + "");
			#/
			self endon(#"death");
			self util::waittill_dobj(localclientnum);
			var_1ca9b241 = util::playfxontag(localclientnum, var_121afd6f, self, var_c1da0b13);
			if(isdefined(var_74ceb128))
			{
				var_4dfb2154 = util::playfxontag(localclientnum, var_121afd6f, self, var_74ceb128);
			}
			if(var_a7ba3864)
			{
				self thread function_5ce3e74e(localclientnum, var_1ca9b241);
			}
			self thread kill_boost(localclientnum, var_1ca9b241);
			if(isdefined(var_4dfb2154))
			{
				self thread kill_boost(localclientnum, var_4dfb2154);
			}
		}
	}
}

/*
	Name: kill_boost
	Namespace: vehicle
	Checksum: 0xCCF76029
	Offset: 0x27A8
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function kill_boost(localclientnum, var_1ca9b241)
{
	self endon(#"death");
	wait(self.boostduration + 0.5);
	self notify(#"end_boost");
	if(isdefined(var_1ca9b241))
	{
		stopfx(localclientnum, var_1ca9b241);
	}
}

/*
	Name: function_5ce3e74e
	Namespace: vehicle
	Checksum: 0x5B1F9AA8
	Offset: 0x2820
	Size: 0x9E
	Parameters: 2
	Flags: Linked
*/
function function_5ce3e74e(localclientnum, var_1ca9b241)
{
	self endon(#"end_boost");
	self endon(#"veh_boost");
	self endon(#"death");
	while(true)
	{
		if(!isinvehicle(localclientnum, self))
		{
			if(isdefined(var_1ca9b241))
			{
				stopfx(localclientnum, var_1ca9b241);
			}
			break;
		}
		else
		{
			waitframe(1);
		}
	}
}

/*
	Name: aircraft_dustkick
	Namespace: vehicle
	Checksum: 0x1B234609
	Offset: 0x28C8
	Size: 0x310
	Parameters: 0
	Flags: Linked
*/
function aircraft_dustkick()
{
	self endon(#"death");
	waittillframeend();
	self endon(#"kill_treads_forever");
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.treadfxnamearray))
	{
		return;
	}
	if(isdefined(self.csf_no_tread) && self.csf_no_tread)
	{
		return;
	}
	while(isdefined(self))
	{
		fxarray = self.treadfxnamearray;
		if(!isdefined(fxarray))
		{
			wait(1);
			continue;
		}
		trace = bullettrace(self.origin, self.origin - (0, 0, 700 * 2), 0, self, 1);
		distsqr = distancesquared(self.origin, trace[#"position"]);
		if(trace[#"fraction"] < 0.01 || distsqr < (0 * 0))
		{
			wait(0.2);
			continue;
		}
		else if(trace[#"fraction"] >= 1 || distsqr > (700 * 700))
		{
			wait(1);
			continue;
		}
		if((0 * 0) < distsqr && distsqr < (700 * 700))
		{
			surfacetype = trace[#"surfacetype"];
			if(!isdefined(surfacetype))
			{
				surfacetype = "dirt";
			}
			if(isdefined(fxarray[surfacetype]))
			{
				forward = anglestoforward(self.angles);
				playfx(0, fxarray[surfacetype], trace[#"position"], (0, 0, 1), forward);
			}
			velocity = self getvelocity();
			speed = length(velocity);
			waittime = mapfloat(10, 100, 1, 0.2, speed);
			wait(waittime);
		}
		else
		{
			wait(1);
			continue;
		}
	}
}

/*
	Name: lights_on
	Namespace: vehicle
	Checksum: 0xD1BF1BCD
	Offset: 0x2BE0
	Size: 0x14E
	Parameters: 2
	Flags: Linked
*/
function lights_on(localclientnum, team)
{
	lights_off(localclientnum);
	if(!isalive(self))
	{
		return;
	}
	self endon(#"death");
	util::waittill_dobj(localclientnum);
	if(isdefined(self.lightfxnamearray))
	{
		if(!isdefined(self.light_fx_handles))
		{
			self.light_fx_handles = [];
		}
		for(i = 0; i < self.lightfxnamearray.size; i++)
		{
			self.light_fx_handles[i] = util::playfxontag(localclientnum, self.lightfxnamearray[i], self, self.lightfxtagarray[i]);
			setfxignorepause(localclientnum, self.light_fx_handles[i], 1);
			if(isdefined(team))
			{
				setfxteam(localclientnum, self.light_fx_handles[i], team);
			}
		}
	}
}

/*
	Name: addanimtolist
	Namespace: vehicle
	Checksum: 0xE61807D7
	Offset: 0x2D38
	Size: 0x108
	Parameters: 6
	Flags: Linked
*/
function addanimtolist(animitem, liston, listoff, playwhenoff, id, maxid)
{
	if(isdefined(animitem) && id <= maxid)
	{
		if(playwhenoff === 1)
		{
			if(!isdefined(listoff))
			{
				listoff = [];
			}
			else if(!isarray(listoff))
			{
				listoff = array(listoff);
			}
			listoff[listoff.size] = animitem;
		}
		else
		{
			if(!isdefined(liston))
			{
				liston = [];
			}
			else if(!isarray(liston))
			{
				liston = array(liston);
			}
			liston[liston.size] = animitem;
		}
	}
}

/*
	Name: ambient_anim_toggle
	Namespace: vehicle
	Checksum: 0xDABB94F4
	Offset: 0x2E48
	Size: 0x5EE
	Parameters: 3
	Flags: Linked
*/
function ambient_anim_toggle(localclientnum, groupid, ison)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings))
	{
		return;
	}
	self endon(#"death");
	util::waittill_dobj(localclientnum);
	liston = [];
	listoff = [];
	switch(groupid)
	{
		case 1:
		{
			addanimtolist(settings.ambient_group1_anim1, liston, listoff, settings.ambient_group1_off1, 1, settings.ambient_group1_numslots);
			addanimtolist(settings.ambient_group1_anim2, liston, listoff, settings.ambient_group1_off2, 2, settings.ambient_group1_numslots);
			addanimtolist(settings.ambient_group1_anim3, liston, listoff, settings.ambient_group1_off3, 3, settings.ambient_group1_numslots);
			addanimtolist(settings.ambient_group1_anim4, liston, listoff, settings.ambient_group1_off4, 4, settings.ambient_group1_numslots);
			break;
		}
		case 2:
		{
			addanimtolist(settings.ambient_group2_anim1, liston, listoff, settings.ambient_group2_off1, 1, settings.ambient_group2_numslots);
			addanimtolist(settings.ambient_group2_anim2, liston, listoff, settings.ambient_group2_off2, 2, settings.ambient_group2_numslots);
			addanimtolist(settings.ambient_group2_anim3, liston, listoff, settings.ambient_group2_off3, 3, settings.ambient_group2_numslots);
			addanimtolist(settings.ambient_group2_anim4, liston, listoff, settings.ambient_group2_off4, 4, settings.ambient_group2_numslots);
			break;
		}
		case 3:
		{
			addanimtolist(settings.ambient_group3_anim1, liston, listoff, settings.ambient_group3_off1, 1, settings.ambient_group3_numslots);
			addanimtolist(settings.ambient_group3_anim2, liston, listoff, settings.ambient_group3_off2, 2, settings.ambient_group3_numslots);
			addanimtolist(settings.ambient_group3_anim3, liston, listoff, settings.ambient_group3_off3, 3, settings.ambient_group3_numslots);
			addanimtolist(settings.ambient_group3_anim4, liston, listoff, settings.ambient_group3_off4, 4, settings.ambient_group3_numslots);
			break;
		}
		case 4:
		{
			addanimtolist(settings.ambient_group4_anim1, liston, listoff, settings.ambient_group4_off1, 1, settings.ambient_group4_numslots);
			addanimtolist(settings.ambient_group4_anim2, liston, listoff, settings.ambient_group4_off2, 2, settings.ambient_group4_numslots);
			addanimtolist(settings.ambient_group4_anim3, liston, listoff, settings.ambient_group4_off3, 3, settings.ambient_group4_numslots);
			addanimtolist(settings.ambient_group4_anim4, liston, listoff, settings.ambient_group4_off4, 4, settings.ambient_group4_numslots);
			break;
		}
	}
	if(ison)
	{
		weighton = 1;
		weightoff = 0;
	}
	else
	{
		weighton = 0;
		weightoff = 1;
	}
	for(i = 0; i < liston.size; i++)
	{
		self setanim(liston[i], weighton, 0.2, 1);
	}
	for(i = 0; i < listoff.size; i++)
	{
		self setanim(listoff[i], weightoff, 0.2, 1);
	}
}

/*
	Name: field_toggle_ambient_anim_handler1
	Namespace: vehicle
	Checksum: 0x507F7D1E
	Offset: 0x3440
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_ambient_anim_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self ambient_anim_toggle(localclientnum, 1, newval);
}

/*
	Name: field_toggle_ambient_anim_handler2
	Namespace: vehicle
	Checksum: 0xAA5122F6
	Offset: 0x34A8
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_ambient_anim_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self ambient_anim_toggle(localclientnum, 2, newval);
}

/*
	Name: field_toggle_ambient_anim_handler3
	Namespace: vehicle
	Checksum: 0xDF16C948
	Offset: 0x3510
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_ambient_anim_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self ambient_anim_toggle(localclientnum, 3, newval);
}

/*
	Name: field_toggle_ambient_anim_handler4
	Namespace: vehicle
	Checksum: 0x552C715C
	Offset: 0x3578
	Size: 0x5C
	Parameters: 7
	Flags: None
*/
function field_toggle_ambient_anim_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self ambient_anim_toggle(localclientnum, 4, newval);
}

/*
	Name: function_7927d9b1
	Namespace: vehicle
	Checksum: 0xA90E570D
	Offset: 0x35E0
	Size: 0x9A
	Parameters: 2
	Flags: Linked
*/
function function_7927d9b1(settings, groupid)
{
	switch(groupid)
	{
		case 1:
		{
			return settings.setup_lgt_glowyriver;
		}
		case 2:
		{
			return settings.var_aaf4ef8c;
		}
		case 3:
		{
			return settings.var_98404a23;
		}
		case 4:
		{
			return settings.var_8e9936d5;
		}
	}
}

/*
	Name: function_34105b89
	Namespace: vehicle
	Checksum: 0x52249C12
	Offset: 0x3688
	Size: 0x190
	Parameters: 3
	Flags: Linked
*/
function function_34105b89(localclientnum, groupid, ison)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings))
	{
		return;
	}
	var_fbd7b872 = settings.var_e08bc957;
	if(isdefined(var_fbd7b872) && groupid > var_fbd7b872)
	{
		return;
	}
	self endon(#"death");
	util::waittill_dobj(localclientnum);
	bone_group = function_7927d9b1(settings, groupid);
	if(!isarray(bone_group))
	{
		return;
	}
	foreach(var_b969bea7 in bone_group)
	{
		if(isdefined(var_b969bea7) && isdefined(var_b969bea7.var_f08513a))
		{
			self function_d309e55a(var_b969bea7.var_f08513a, ison);
		}
	}
}

/*
	Name: function_d427b534
	Namespace: vehicle
	Checksum: 0xB6A19365
	Offset: 0x3820
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_d427b534(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34105b89(localclientnum, 1, newval);
}

/*
	Name: nova_crawler_spawnerbamfterminate
	Namespace: vehicle
	Checksum: 0x3114172F
	Offset: 0x3888
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function nova_crawler_spawnerbamfterminate(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34105b89(localclientnum, 2, newval);
}

/*
	Name: function_48a01e23
	Namespace: vehicle
	Checksum: 0x77D0E1BD
	Offset: 0x38F0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_48a01e23(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34105b89(localclientnum, 3, newval);
}

/*
	Name: function_6ad96295
	Namespace: vehicle
	Checksum: 0x3B4416C6
	Offset: 0x3958
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_6ad96295(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self function_34105b89(localclientnum, 4, newval);
}

/*
	Name: function_ca9b286c
	Namespace: vehicle
	Checksum: 0x6A0E27D7
	Offset: 0x39C0
	Size: 0x1CC
	Parameters: 1
	Flags: Event
*/
event function_ca9b286c(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	localclientnum = eventstruct.localclientnum;
	if(vehicle isvehicle())
	{
		seatindex = vehicle getoccupantseat(localclientnum, self);
		if(!isdefined(seatindex))
		{
			return;
		}
		var_fd110a27 = vehicle function_a3f90231(seatindex);
		if(!isdefined(var_fd110a27))
		{
			return;
		}
		var_8730ee3e = getscriptbundle(var_fd110a27);
		if(isdefined(var_8730ee3e))
		{
			if(isdefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit)
			{
				if(!isdefined(vehicle.t_sarah_foy_objective__indicator_))
				{
					vehicle.t_sarah_foy_objective__indicator_ = [];
				}
				if(isdefined(vehicle.t_sarah_foy_objective__indicator_[seatindex]) && vehicle.t_sarah_foy_objective__indicator_[seatindex])
				{
					return;
				}
				vehicle.t_sarah_foy_objective__indicator_[seatindex] = 1;
			}
			animation = var_8730ee3e.vehicleenteranim;
			if(isdefined(animation))
			{
				vehicle setanimrestart(animation, 1, 0, 1);
			}
		}
	}
}

/*
	Name: function_124469f4
	Namespace: vehicle
	Checksum: 0xA9BF24C9
	Offset: 0x3B98
	Size: 0x1F4
	Parameters: 1
	Flags: Event
*/
event function_124469f4(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	localclientnum = eventstruct.localclientnum;
	if(vehicle isvehicle())
	{
		seatindex = vehicle getoccupantseat(localclientnum, self);
		if(!isdefined(seatindex))
		{
			return;
		}
		var_fd110a27 = vehicle function_a3f90231(seatindex);
		if(!isdefined(var_fd110a27))
		{
			return;
		}
		var_8730ee3e = getscriptbundle(var_fd110a27);
		if(isdefined(var_8730ee3e))
		{
			if(!(isdefined(var_8730ee3e.var_8d496bb1) && var_8730ee3e.var_8d496bb1))
			{
				return;
			}
			if(isdefined(var_8730ee3e.zmenhancedstatejukeinit) && var_8730ee3e.zmenhancedstatejukeinit)
			{
				if(!isdefined(vehicle.t_sarah_foy_objective__indicator_))
				{
					vehicle.t_sarah_foy_objective__indicator_ = [];
				}
				if(isdefined(vehicle.t_sarah_foy_objective__indicator_[seatindex]) && vehicle.t_sarah_foy_objective__indicator_[seatindex])
				{
					return;
				}
				vehicle.t_sarah_foy_objective__indicator_[seatindex] = 1;
			}
			animation = var_8730ee3e.vehicleenteranim;
			if(isdefined(animation))
			{
				vehicle setanimrestart(animation, 1, 0, 1);
			}
		}
	}
}

/*
	Name: lights_group_toggle
	Namespace: vehicle
	Checksum: 0xE6EFD700
	Offset: 0x3D98
	Size: 0x392
	Parameters: 3
	Flags: Linked
*/
function lights_group_toggle(localclientnum, groupid, ison)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings) || !isdefined(settings.lightgroups_numgroups))
	{
		return;
	}
	self endon(#"death");
	if(isdefined(self.lightfxgroups) && isdefined(self.lightfxgroups[groupid]))
	{
		foreach(fx_handle in self.lightfxgroups[groupid])
		{
			if(isdefined(fx_handle))
			{
				stopfx(localclientnum, fx_handle);
			}
		}
	}
	if(!ison)
	{
		return;
	}
	util::waittill_dobj(localclientnum);
	if(!isdefined(self.lightfxgroups))
	{
		self.lightfxgroups = [];
	}
	if(!isdefined(self.lightfxgroups[groupid]))
	{
		self.lightfxgroups[groupid] = [];
	}
	fxlist = [];
	taglist = [];
	switch(groupid)
	{
		case 0:
		{
			function_670a62e7(settings.var_3d203f52, fxlist, taglist);
			break;
		}
		case 1:
		{
			function_670a62e7(settings.var_ee802f44, fxlist, taglist);
			break;
		}
		case 2:
		{
			function_670a62e7(settings.var_7d2275f6, fxlist, taglist);
			break;
		}
		case 3:
		{
			function_670a62e7(settings.var_f92d18eb, fxlist, taglist);
			break;
		}
	}
	for(i = 0; i < fxlist.size; i++)
	{
		fx_handle = util::playfxontag(localclientnum, fxlist[i], self, taglist[i]);
		if(!isdefined(self.lightfxgroups[groupid]))
		{
			self.lightfxgroups[groupid] = [];
		}
		else if(!isarray(self.lightfxgroups[groupid]))
		{
			self.lightfxgroups[groupid] = array(self.lightfxgroups[groupid]);
		}
		self.lightfxgroups[groupid][self.lightfxgroups[groupid].size] = fx_handle;
	}
}

/*
	Name: field_toggle_lights_group_handler1
	Namespace: vehicle
	Checksum: 0xD71B4AE7
	Offset: 0x4138
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lights_group_handler1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self lights_group_toggle(localclientnum, 0, newval);
}

/*
	Name: field_toggle_lights_group_handler2
	Namespace: vehicle
	Checksum: 0xC307B127
	Offset: 0x41A0
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lights_group_handler2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self lights_group_toggle(localclientnum, 1, newval);
}

/*
	Name: field_toggle_lights_group_handler3
	Namespace: vehicle
	Checksum: 0xEC992EEA
	Offset: 0x4208
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lights_group_handler3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self lights_group_toggle(localclientnum, 2, newval);
}

/*
	Name: field_toggle_lights_group_handler4
	Namespace: vehicle
	Checksum: 0x22294D1B
	Offset: 0x4270
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lights_group_handler4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self lights_group_toggle(localclientnum, 3, newval);
}

/*
	Name: function_7baff7f6
	Namespace: vehicle
	Checksum: 0x8ED33CC3
	Offset: 0x42D8
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_7baff7f6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_e1a2a256(1);
	}
	else
	{
		self function_e1a2a256(0);
	}
}

/*
	Name: delete_alert_lights
	Namespace: vehicle
	Checksum: 0x65E8BC25
	Offset: 0x4358
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function delete_alert_lights(localclientnum)
{
	if(isdefined(self.alert_light_fx_handles))
	{
		for(i = 0; i < self.alert_light_fx_handles.size; i++)
		{
			if(isdefined(self.alert_light_fx_handles[i]))
			{
				stopfx(localclientnum, self.alert_light_fx_handles[i]);
			}
		}
	}
	self.alert_light_fx_handles = undefined;
}

/*
	Name: lights_off
	Namespace: vehicle
	Checksum: 0xD8F885B1
	Offset: 0x43E0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function lights_off(localclientnum)
{
	if(isdefined(self.light_fx_handles))
	{
		for(i = 0; i < self.light_fx_handles.size; i++)
		{
			if(isdefined(self.light_fx_handles[i]))
			{
				stopfx(localclientnum, self.light_fx_handles[i]);
			}
		}
	}
	self.light_fx_handles = undefined;
	delete_alert_lights(localclientnum);
}

/*
	Name: lights_flicker
	Namespace: vehicle
	Checksum: 0xD72702C7
	Offset: 0x4480
	Size: 0x31E
	Parameters: 3
	Flags: Linked
*/
function lights_flicker(localclientnum, duration = 8, var_5db078ba = 1)
{
	self notify("15457a87e1f08c8e");
	self endon("15457a87e1f08c8e");
	self endon(#"cancel_flicker");
	self endon(#"death");
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	state = 1;
	durationleft = gettime() + (int(duration * 1000));
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(!isdefined(settings) || !isdefined(settings.lightgroups_numgroups))
	{
		while(durationleft > gettime())
		{
			if(randomint(4) == 0)
			{
				state = !state;
				if(state)
				{
					self lights_on(localclientnum);
				}
				else
				{
					self lights_off(localclientnum);
				}
			}
			waitframe(1);
		}
	}
	else
	{
		while(durationleft > gettime())
		{
			state = !state;
			self lights_group_toggle(localclientnum, randomint(settings.lightgroups_numgroups), state);
			waitframe(1);
		}
		if(var_5db078ba)
		{
			for(i = 0; i < settings.lightgroups_numgroups; i++)
			{
				self lights_group_toggle(localclientnum, i, 0);
			}
		}
	}
	if(var_5db078ba)
	{
		self lights_off(localclientnum);
		if(isdefined(settings) && isdefined(settings.lightgroups_numgroups))
		{
			for(i = 0; i < settings.lightgroups_numgroups; i++)
			{
				self lights_group_toggle(localclientnum, i, 0);
			}
		}
	}
	else if(!state)
	{
		self lights_on(localclientnum);
		if(isdefined(settings) && isdefined(settings.lightgroups_numgroups))
		{
			for(i = 0; i < settings.lightgroups_numgroups; i++)
			{
				self lights_group_toggle(localclientnum, i, 1);
			}
		}
	}
}

/*
	Name: field_toggle_emp
	Namespace: vehicle
	Checksum: 0x49335293
	Offset: 0x47A8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function field_toggle_emp(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread toggle_fx_bundle(localclientnum, "emp_base", newval == 1);
}

/*
	Name: field_toggle_burn
	Namespace: vehicle
	Checksum: 0x9F5CFC53
	Offset: 0x4818
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function field_toggle_burn(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self thread toggle_fx_bundle(localclientnum, "burn_base", newval == 1);
}

/*
	Name: flicker_lights
	Namespace: vehicle
	Checksum: 0x53CD633C
	Offset: 0x4888
	Size: 0xEE
	Parameters: 7
	Flags: Linked
*/
function flicker_lights(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 0)
	{
		self notify(#"cancel_flicker");
		self lights_off(localclientnum);
	}
	else
	{
		if(newval == 1)
		{
			self thread lights_flicker(localclientnum);
		}
		else
		{
			if(newval == 2)
			{
				self thread lights_flicker(localclientnum, 20);
			}
			else if(newval == 3)
			{
				self notify(#"cancel_flicker");
			}
		}
	}
}

/*
	Name: function_1ea3bdef
	Namespace: vehicle
	Checksum: 0xD08D5395
	Offset: 0x4980
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_1ea3bdef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	if(isdefined(self))
	{
		function_c45d231e(localclientnum, self, 1);
		self thread function_e5f88559(localclientnum, "emp_base");
		self thread function_e5f88559(localclientnum, "burn_base");
		self thread function_e5f88559(localclientnum, "smolder");
		self thread function_e5f88559(localclientnum, "death");
		self thread function_e5f88559(localclientnum, "empdeath");
		if(newval)
		{
			self lights_off(localclientnum);
		}
		self thread stop_exhaust(localclientnum);
	}
}

/*
	Name: function_e5f88559
	Namespace: vehicle
	Checksum: 0x82BEEC37
	Offset: 0x4AE0
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_e5f88559(localclientnum, name)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.fx_handles))
	{
		self.fx_handles = [];
	}
	if(isdefined(self.fx_handles[name]))
	{
		handle = self.fx_handles[name];
		if(isdefined(handle))
		{
			if(isarray(handle))
			{
				foreach(handleelement in handle)
				{
					stopfx(localclientnum, handleelement);
				}
			}
			else
			{
				stopfx(localclientnum, handle);
			}
		}
	}
}

/*
	Name: toggle_fx_bundle
	Namespace: vehicle
	Checksum: 0xB546FA01
	Offset: 0x4C08
	Size: 0x1AE
	Parameters: 3
	Flags: Linked
*/
function toggle_fx_bundle(localclientnum, name, turnon)
{
	if(!isdefined(self.settings) && isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	if(!isdefined(self.settings))
	{
		return;
	}
	self endon(#"death");
	self notify("end_toggle_field_fx_" + name);
	self endon("end_toggle_field_fx_" + name);
	util::waittill_dobj(localclientnum);
	self function_e5f88559(localclientnum, name);
	if(turnon)
	{
		i = 1;
		for(;;)
		{
			fx = self.settings.((name + "_fx_") + i);
			if(!isdefined(fx))
			{
				return;
			}
			tag = self.settings.((name + "_tag_") + i);
			delay = self.settings.((name + "_delay_") + i);
			self thread delayed_fx_thread(localclientnum, name, fx, tag, delay);
			i++;
		}
	}
}

/*
	Name: delayed_fx_thread
	Namespace: vehicle
	Checksum: 0xA4BC63D7
	Offset: 0x4DC0
	Size: 0x140
	Parameters: 5
	Flags: Linked
*/
function delayed_fx_thread(localclientnum, name, fx, tag, delay)
{
	self endon(#"death");
	self endon("end_toggle_field_fx_" + name);
	if(!isdefined(tag))
	{
		return;
	}
	if(isdefined(delay) && delay > 0)
	{
		wait(delay);
	}
	fx_handle = util::playfxontag(localclientnum, fx, self, tag);
	if(!isdefined(self.fx_handles[name]))
	{
		self.fx_handles[name] = [];
	}
	else if(!isarray(self.fx_handles[name]))
	{
		self.fx_handles[name] = array(self.fx_handles[name]);
	}
	self.fx_handles[name][self.fx_handles[name].size] = fx_handle;
}

/*
	Name: field_toggle_sounds
	Namespace: vehicle
	Checksum: 0x177D605A
	Offset: 0x4F08
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function field_toggle_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self.vehicleclass === "helicopter")
	{
		if(newval)
		{
			self notify(#"stop_heli_sounds");
			self.should_not_play_sounds = 1;
		}
		else
		{
			self notify(#"play_heli_sounds");
			self.should_not_play_sounds = 0;
		}
	}
	if(newval)
	{
		self disablevehiclesounds();
		self function_dcec5385();
	}
	else
	{
		self enablevehiclesounds();
	}
}

/*
	Name: function_dcec5385
	Namespace: vehicle
	Checksum: 0x76AD46B3
	Offset: 0x4FF8
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_dcec5385()
{
	self function_f753359a();
}

/*
	Name: field_toggle_dnidamagefx
	Namespace: vehicle
	Checksum: 0x97983E0
	Offset: 0x5020
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function field_toggle_dnidamagefx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"pstfx_dni_vehicle_dmg");
	}
}

/*
	Name: toggle_flir_postfxbundle
	Namespace: vehicle
	Checksum: 0x44FD7B63
	Offset: 0x5090
	Size: 0x1D4
	Parameters: 7
	Flags: Linked
*/
function toggle_flir_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = self;
	if(newval == oldval)
	{
		return;
	}
	if(!isdefined(player) || !player function_21c0fa55())
	{
		return;
	}
	if(newval == 0)
	{
		if(oldval == 1)
		{
			player thread postfx::stoppostfxbundle("pstfx_infrared");
		}
		else if(oldval == 2)
		{
			player thread postfx::stoppostfxbundle("pstfx_flir");
		}
		update_ui_fullscreen_filter_model(localclientnum, 0);
	}
	else
	{
		if(newval == 1)
		{
			if(player shouldchangescreenpostfx(localclientnum))
			{
				player thread postfx::playpostfxbundle(#"pstfx_infrared");
				update_ui_fullscreen_filter_model(localclientnum, 2);
			}
		}
		else if(newval == 2)
		{
			should_change = 1;
			if(player shouldchangescreenpostfx(localclientnum))
			{
				player thread postfx::playpostfxbundle(#"pstfx_flir");
				update_ui_fullscreen_filter_model(localclientnum, 1);
			}
		}
	}
}

/*
	Name: shouldchangescreenpostfx
	Namespace: vehicle
	Checksum: 0x2D5EE3E8
	Offset: 0x5270
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function shouldchangescreenpostfx(localclientnum)
{
	player = self;
	/#
		assert(isdefined(player));
	#/
	if(function_1cbf351b(localclientnum))
	{
		killcamentity = function_93e0f729(localclientnum);
		if(isdefined(killcamentity) && killcamentity != player)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: set_static_postfxbundle
	Namespace: vehicle
	Checksum: 0x5538125E
	Offset: 0x5308
	Size: 0x284
	Parameters: 7
	Flags: Linked
*/
function set_static_postfxbundle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = self;
	if(newval == oldval)
	{
		return;
	}
	if(!isdefined(player) || !player function_21c0fa55())
	{
		return;
	}
	if(newval == 0)
	{
		if(player postfx::function_556665f2(#"pstfx_static"))
		{
			player thread postfx::stoppostfxbundle(#"pstfx_static");
		}
		if(player postfx::function_556665f2(#"hash_15d46f4ad6539103"))
		{
			player thread postfx::stoppostfxbundle(#"hash_15d46f4ad6539103");
		}
	}
	else if(newval == 1)
	{
		var_8efa62c3 = 1;
		vehicle = getplayervehicle(player);
		if(isdefined(vehicle))
		{
			if(vehicle.vehicletype == #"veh_hawk_player_mp" || vehicle.vehicletype == #"veh_hawk_player_far_range_mp" || vehicle.vehicletype == #"veh_hawk_player_wz" || vehicle.vehicletype == #"veh_hawk_player_far_range_wz")
			{
				if(player postfx::function_556665f2(#"hash_15d46f4ad6539103") == 0)
				{
					player thread postfx::playpostfxbundle(#"hash_15d46f4ad6539103");
				}
				var_8efa62c3 = 0;
			}
		}
		if(var_8efa62c3 && player postfx::function_556665f2(#"pstfx_static") == 0)
		{
			player thread postfx::playpostfxbundle(#"pstfx_static");
		}
	}
}

/*
	Name: update_ui_fullscreen_filter_model
	Namespace: vehicle
	Checksum: 0xA8063396
	Offset: 0x5598
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function update_ui_fullscreen_filter_model(localclientnum, vision_set_value)
{
	controllermodel = getuimodelforcontroller(localclientnum);
	model = getuimodel(controllermodel, "vehicle.fullscreenFilter");
	if(isdefined(model))
	{
		setuimodelvalue(model, vision_set_value);
	}
}

/*
	Name: field_toggle_treadfx
	Namespace: vehicle
	Checksum: 0xB8B8A8FD
	Offset: 0x5620
	Size: 0x20C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_treadfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self.vehicleclass === "helicopter" || self.vehicleclass === "plane")
	{
		/#
			println("");
		#/
		if(newval)
		{
			if(isdefined(self.csf_no_tread))
			{
				self.csf_no_tread = 0;
			}
			self kill_treads_forever();
			self thread aircraft_dustkick();
		}
		else
		{
			if(isdefined(bnewent) && bnewent)
			{
				self.csf_no_tread = 1;
			}
			else
			{
				self kill_treads_forever();
			}
		}
	}
	else
	{
		if(newval)
		{
			/#
				println("");
			#/
			if(isdefined(bnewent) && bnewent)
			{
				/#
					println("" + self getentitynumber());
				#/
				self.csf_no_tread = 1;
			}
			else
			{
				/#
					println("" + self getentitynumber());
				#/
				self kill_treads_forever();
			}
		}
		else
		{
			/#
				println("");
			#/
			if(isdefined(self.csf_no_tread))
			{
				self.csf_no_tread = 0;
			}
			self kill_treads_forever();
		}
	}
}

/*
	Name: field_use_engine_damage_sounds
	Namespace: vehicle
	Checksum: 0x9F72BBD0
	Offset: 0x5838
	Size: 0xEA
	Parameters: 7
	Flags: Linked
*/
function field_use_engine_damage_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self.vehicleclass === "helicopter")
	{
		switch(newval)
		{
			case 0:
			{
				self.engine_damage_low = 0;
				self.engine_damage_high = 0;
				break;
			}
			case 1:
			{
				self.engine_damage_low = 1;
				self.engine_damage_high = 0;
				break;
			}
			case 1:
			{
				self.engine_damage_low = 0;
				self.engine_damage_high = 1;
				break;
			}
		}
	}
}

/*
	Name: function_a29f490a
	Namespace: vehicle
	Checksum: 0xFA2AB979
	Offset: 0x5930
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a29f490a()
{
	self.var_76660b3a = self playloopsound(self.hornsound);
}

/*
	Name: function_f753359a
	Namespace: vehicle
	Checksum: 0xAED32A0F
	Offset: 0x5968
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f753359a()
{
	if(isdefined(self.var_76660b3a))
	{
		self stoploopsound(self.var_76660b3a);
		self.var_76660b3a = undefined;
	}
}

/*
	Name: function_27b19317
	Namespace: vehicle
	Checksum: 0x72A227D2
	Offset: 0x59A8
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_27b19317(localclientnum)
{
	if(!self function_4add50a7())
	{
		return false;
	}
	if(function_65b9eb0f(localclientnum))
	{
		return false;
	}
	if(self.vehicleclass === "helicopter")
	{
		return false;
	}
	if(isdefined(self.var_304cf9da) && self.var_304cf9da)
	{
		return false;
	}
	return true;
}

/*
	Name: function_2d24296
	Namespace: vehicle
	Checksum: 0x8D42E672
	Offset: 0x5A30
	Size: 0xF4
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2d24296(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self function_27b19317(localclientnum))
	{
		return;
	}
	if(!isdefined(self.hornsound))
	{
		return;
	}
	if(newval)
	{
		if(self.vehicleclass === "helicopter" && (!(isdefined(self.var_304cf9da) && self.var_304cf9da)))
		{
			self playsound(localclientnum, self.hornsound);
		}
		else
		{
			self function_a29f490a();
		}
	}
	else
	{
		self function_f753359a();
	}
}

/*
	Name: function_7d1d0e65
	Namespace: vehicle
	Checksum: 0xF13FAB98
	Offset: 0x5B30
	Size: 0x872
	Parameters: 7
	Flags: Linked
*/
function function_7d1d0e65(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.settings) && isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	if(!isdefined(self.settings) || !isdefined(self.settings.var_64a3b723))
	{
		return;
	}
	if(!isdefined(self.fx_handles))
	{
		self.fx_handles = [];
	}
	if(!isdefined(self.fx_handles[#"malfunction"]))
	{
		self.fx_handles[#"malfunction"] = [];
	}
	foreach(handle in self.fx_handles[#"malfunction"])
	{
		stopfx(localclientnum, handle);
	}
	self.fx_handles[#"malfunction"] = [];
	if(newval)
	{
		foreach(var_b5ddf091 in self.settings.var_64a3b723)
		{
			tag = var_b5ddf091.var_454a4e08;
			effect = var_b5ddf091.transition;
			if(isdefined(var_b5ddf091.transition) && isdefined(var_b5ddf091.var_454a4e08))
			{
				util::playfxontag(localclientnum, var_b5ddf091.transition, self, var_b5ddf091.var_454a4e08);
			}
			switch(newval)
			{
				case 0:
				{
					break;
				}
				case 1:
				{
					if(isdefined(var_b5ddf091.warning) && isdefined(var_b5ddf091.tag_warning))
					{
						handle = util::playfxontag(localclientnum, var_b5ddf091.warning, self, var_b5ddf091.tag_warning);
						if(!isdefined(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = [];
						}
						else if(!isarray(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
						}
						self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
					}
					break;
				}
				case 2:
				{
					if(isdefined(var_b5ddf091.active) && isdefined(var_b5ddf091.var_2f451e59))
					{
						handle = util::playfxontag(localclientnum, var_b5ddf091.active, self, var_b5ddf091.var_2f451e59);
						if(!isdefined(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = [];
						}
						else if(!isarray(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
						}
						self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
					}
					break;
				}
				case 3:
				{
					if(isdefined(var_b5ddf091.fatal) && isdefined(var_b5ddf091.var_ceeccc7a))
					{
						handle = util::playfxontag(localclientnum, var_b5ddf091.fatal, self, var_b5ddf091.var_ceeccc7a);
						if(!isdefined(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = [];
						}
						else if(!isarray(self.fx_handles[#"malfunction"]))
						{
							self.fx_handles[#"malfunction"] = array(self.fx_handles[#"malfunction"]);
						}
						self.fx_handles[#"malfunction"][self.fx_handles[#"malfunction"].size] = handle;
					}
					break;
				}
			}
		}
	}
	if(newval != oldval)
	{
		var_ca456b21 = "uin_chopper_alarm_warning";
		var_b10574a9 = "uin_chopper_alarm_critical";
		switch(oldval)
		{
			case 0:
			case 1:
			{
				if(isdefined(self.var_30141f5c))
				{
					self stoploopsound(self.var_30141f5c);
					self.var_30141f5c = undefined;
				}
				break;
			}
			case 2:
			case 3:
			{
				if(newval != 2 && newval != 3 && isdefined(self.var_30141f5c))
				{
					self stoploopsound(self.var_30141f5c);
					self.var_30141f5c = undefined;
				}
				break;
			}
		}
		switch(newval)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				self.var_30141f5c = self playloopsound(var_ca456b21);
				break;
			}
			case 2:
			case 3:
			{
				if(oldval != 2 && oldval != 3)
				{
					self.var_30141f5c = self playloopsound(var_b10574a9);
				}
				break;
			}
		}
	}
}

/*
	Name: field_do_deathfx
	Namespace: vehicle
	Checksum: 0x5E968951
	Offset: 0x63B0
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		self stop_stun_fx(localclientnum);
	}
	if(newval == 2)
	{
		self field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
	else
	{
		self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
	if(isdefined(self.var_8a037014))
	{
		self thread function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
}

/*
	Name: function_18758bfa
	Namespace: vehicle
	Checksum: 0xB9D4B0AE
	Offset: 0x64D0
	Size: 0x41E
	Parameters: 7
	Flags: Linked
*/
function function_18758bfa(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval && !binitialsnap)
	{
		self endon(#"death");
		if(isdefined(self.var_6e8da11c) && self.var_6e8da11c > 0)
		{
			wait(self.var_6e8da11c);
		}
		if(!isdefined(self.fx_handles))
		{
			self.fx_handles = [];
		}
		if(!isdefined(self.fx_handles[#"smolder"]))
		{
			self.fx_handles[#"smolder"] = [];
		}
		if(isdefined(self.var_8a037014) && self.var_8a037014 != "")
		{
			if(isdefined(self.var_20eae439) && self.var_20eae439 != "")
			{
				handle = util::playfxontag(localclientnum, self.var_8a037014, self, self.var_20eae439);
			}
			else
			{
				handle = playfx(localclientnum, self.var_8a037014, self.origin);
			}
			setfxignorepause(localclientnum, handle, 1);
			if(!isdefined(self.fx_handles[#"smolder"]))
			{
				self.fx_handles[#"smolder"] = [];
			}
			else if(!isarray(self.fx_handles[#"smolder"]))
			{
				self.fx_handles[#"smolder"] = array(self.fx_handles[#"smolder"]);
			}
			self.fx_handles[#"smolder"][self.fx_handles[#"smolder"].size] = handle;
		}
		if(isdefined(self.var_68f20b20) && self.var_68f20b20 != "")
		{
			self playsound(localclientnum, self.var_68f20b20);
		}
		if(isdefined(handle) && isdefined(self.var_b321fcb3) && self.var_b321fcb3 > 0)
		{
			wait(self.var_b321fcb3);
			if(isfxplaying(localclientnum, handle))
			{
				stopfx(localclientnum, handle);
				arrayremovevalue(self.fx_handles[#"smolder"], handle, 0);
			}
		}
	}
	else if(isdefined(self.fx_handles) && isdefined(self.fx_handles[#"smolder"]))
	{
		foreach(handle in self.fx_handles[#"smolder"])
		{
			stopfx(localclientnum, handle);
		}
		self.fx_handles[#"smolder"] = [];
	}
}

/*
	Name: field_do_standarddeathfx
	Namespace: vehicle
	Checksum: 0x3D30FD4
	Offset: 0x68F8
	Size: 0x304
	Parameters: 7
	Flags: Linked
*/
function field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval && !binitialsnap)
	{
		self endon(#"death");
		util::waittill_dobj(localclientnum);
		if(!isdefined(self.fx_handles))
		{
			self.fx_handles = [];
		}
		if(!isdefined(self.fx_handles[#"death"]))
		{
			self.fx_handles[#"death"] = [];
		}
		if(isdefined(self.deathfxname))
		{
			if(isdefined(self.deathfxtag) && self.deathfxtag != "")
			{
				handle = util::playfxontag(localclientnum, self.deathfxname, self, self.deathfxtag);
			}
			else
			{
				handle = playfx(localclientnum, self.deathfxname, self.origin);
			}
			setfxignorepause(localclientnum, handle, 1);
			if(!isdefined(self.fx_handles[#"death"]))
			{
				self.fx_handles[#"death"] = [];
			}
			else if(!isarray(self.fx_handles[#"death"]))
			{
				self.fx_handles[#"death"] = array(self.fx_handles[#"death"]);
			}
			self.fx_handles[#"death"][self.fx_handles[#"death"].size] = handle;
		}
		self playsound(localclientnum, self.deathfxsound);
		if(isdefined(self.deathquakescale) && self.deathquakescale > 0)
		{
			earthquake(localclientnum, self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);
		}
		if(isdefined(self.var_d0569e25) && self.var_d0569e25 != "")
		{
			self playrumbleonentity(localclientnum, self.var_d0569e25);
		}
	}
}

/*
	Name: field_do_empdeathfx
	Namespace: vehicle
	Checksum: 0x29E01445
	Offset: 0x6C08
	Size: 0x394
	Parameters: 7
	Flags: Linked
*/
function field_do_empdeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.settings) && isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	if(!isdefined(self.settings))
	{
		self field_do_standarddeathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
		return;
	}
	if(newval && !binitialsnap)
	{
		self endon(#"death");
		util::waittill_dobj(localclientnum);
		if(!isdefined(self.fx_handles))
		{
			self.fx_handles = [];
		}
		if(!isdefined(self.fx_handles[#"empdeath"]))
		{
			self.fx_handles[#"empdeath"] = [];
		}
		s = self.settings;
		if(isdefined(s.emp_death_fx_1))
		{
			if(isdefined(s.emp_death_tag_1) && s.emp_death_tag_1 != "")
			{
				handle = util::playfxontag(localclientnum, s.emp_death_fx_1, self, s.emp_death_tag_1);
			}
			else
			{
				handle = playfx(localclientnum, s.emp_death_tag_1, self.origin);
			}
			setfxignorepause(localclientnum, handle, 1);
			if(!isdefined(self.fx_handles[#"empdeath"]))
			{
				self.fx_handles[#"empdeath"] = [];
			}
			else if(!isarray(self.fx_handles[#"empdeath"]))
			{
				self.fx_handles[#"empdeath"] = array(self.fx_handles[#"empdeath"]);
			}
			self.fx_handles[#"empdeath"][self.fx_handles[#"empdeath"].size] = handle;
		}
		self playsound(localclientnum, s.emp_death_sound_1);
		if(isdefined(self.deathquakescale) && self.deathquakescale > 0)
		{
			earthquake(localclientnum, self.deathquakescale * 0.25, self.deathquakeduration * 2, self.origin, self.deathquakeradius);
		}
	}
}

/*
	Name: field_update_alert_level
	Namespace: vehicle
	Checksum: 0xE4FEF153
	Offset: 0x6FA8
	Size: 0x1F2
	Parameters: 7
	Flags: Linked
*/
function field_update_alert_level(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	delete_alert_lights(localclientnum);
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	if(!isdefined(self.alert_light_fx_handles))
	{
		self.alert_light_fx_handles = [];
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	switch(newval)
	{
		case 0:
		{
			break;
		}
		case 1:
		{
			if(isdefined(settings.unawarelightfx1))
			{
				self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.unawarelightfx1, self, settings.lighttag1);
			}
			break;
		}
		case 2:
		{
			if(isdefined(settings.alertlightfx1))
			{
				self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.alertlightfx1, self, settings.lighttag1);
			}
			break;
		}
		case 3:
		{
			if(isdefined(settings.combatlightfx1))
			{
				self.alert_light_fx_handles[0] = util::playfxontag(localclientnum, settings.combatlightfx1, self, settings.lighttag1);
			}
			break;
		}
	}
}

/*
	Name: field_toggle_exhaustfx_handler
	Namespace: vehicle
	Checksum: 0xD817B390
	Offset: 0x71A8
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function field_toggle_exhaustfx_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(bnewent) && bnewent)
		{
			self.csf_no_exhaust = 1;
		}
		else
		{
			self stop_exhaust(localclientnum);
		}
	}
	else
	{
		if(isdefined(self.csf_no_exhaust))
		{
			self.csf_no_exhaust = 0;
		}
		self stop_exhaust(localclientnum);
		self play_exhaust(localclientnum);
	}
}

/*
	Name: field_toggle_lights_handler
	Namespace: vehicle
	Checksum: 0xB8EE7491
	Offset: 0x7278
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lights_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self lights_off(localclientnum);
	}
	else
	{
		if(newval == 2)
		{
			self lights_on(localclientnum, #"allies");
		}
		else
		{
			if(newval == 3)
			{
				self lights_on(localclientnum, #"axis");
			}
			else
			{
				self lights_on(localclientnum);
			}
		}
	}
}

/*
	Name: field_toggle_lockon_handler
	Namespace: vehicle
	Checksum: 0x4137A455
	Offset: 0x7370
	Size: 0x3C
	Parameters: 7
	Flags: Linked
*/
function field_toggle_lockon_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_670a62e7
	Namespace: vehicle
	Checksum: 0x8A30A4EF
	Offset: 0x73B8
	Size: 0xAE
	Parameters: 3
	Flags: Linked
*/
function function_670a62e7(var_96ceb3eb, fxlist, taglist)
{
	if(isdefined(var_96ceb3eb) && isarray(var_96ceb3eb))
	{
		for(i = 0; i < var_96ceb3eb.size; i++)
		{
			addfxandtagtolists(var_96ceb3eb[i].fx, var_96ceb3eb[i].tag, fxlist, taglist, i, var_96ceb3eb.size - 1);
		}
	}
}

/*
	Name: addfxandtagtolists
	Namespace: vehicle
	Checksum: 0x454384F6
	Offset: 0x7470
	Size: 0x128
	Parameters: 6
	Flags: Linked
*/
function addfxandtagtolists(fx, tag, fxlist, taglist, id, maxid)
{
	if(isdefined(fx) && isdefined(tag) && isint(id) && isint(maxid) && id <= maxid)
	{
		if(!isdefined(fxlist))
		{
			fxlist = [];
		}
		else if(!isarray(fxlist))
		{
			fxlist = array(fxlist);
		}
		fxlist[fxlist.size] = fx;
		if(!isdefined(taglist))
		{
			taglist = [];
		}
		else if(!isarray(taglist))
		{
			taglist = array(taglist);
		}
		taglist[taglist.size] = tag;
	}
}

/*
	Name: function_d7a2c2f
	Namespace: vehicle
	Checksum: 0x293718A8
	Offset: 0x75A0
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_d7a2c2f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(newval)
	{
		self notify(#"light_disable");
		self stop_stun_fx(localclientnum);
		self start_stun_fx(localclientnum);
	}
	else
	{
		self stop_stun_fx(localclientnum);
	}
}

/*
	Name: start_stun_fx
	Namespace: vehicle
	Checksum: 0x894D759
	Offset: 0x7660
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function start_stun_fx(localclientnum)
{
	stunfx = (isdefined(self.global_zm_specialty_staminup_drankdie) ? self.global_zm_specialty_staminup_drankdie : #"killstreaks/fx_agr_emp_stun");
	_exp_special_web_dissolve = (isdefined(self.stunfxtag) ? self.stunfxtag : "tag_origin");
	var_6dc7131c = (isdefined(self.var_c254489e) ? self.var_c254489e : #"veh_talon_shutdown");
	self.stun_fx = util::playfxontag(localclientnum, stunfx, self, _exp_special_web_dissolve);
	playsound(localclientnum, var_6dc7131c, self.origin);
}

/*
	Name: stop_stun_fx
	Namespace: vehicle
	Checksum: 0xEFC75882
	Offset: 0x7750
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function stop_stun_fx(localclientnum)
{
	if(isdefined(self.stun_fx))
	{
		stopfx(localclientnum, self.stun_fx);
		self.stun_fx = undefined;
	}
}

/*
	Name: field_update_damage_state
	Namespace: vehicle
	Checksum: 0x61038BFB
	Offset: 0x7798
	Size: 0x30C
	Parameters: 7
	Flags: Linked
*/
function field_update_damage_state(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(isdefined(self.damage_state_fx_handles))
	{
		foreach(fx_handle in self.damage_state_fx_handles)
		{
			if(isdefined(fx_handle))
			{
				stopfx(localclientnum, fx_handle);
			}
		}
	}
	self.damage_state_fx_handles = [];
	fxlist = [];
	taglist = [];
	sound = undefined;
	if(newval > 0)
	{
		var_c0e21df2 = "damagestate_lv" + newval;
		numslots = settings.(var_c0e21df2 + "_numslots");
		for(fxindex = 1; isdefined(numslots) && fxindex <= numslots; fxindex++)
		{
			addfxandtagtolists(settings.((var_c0e21df2 + "_fx") + fxindex), settings.((var_c0e21df2 + "_tag") + fxindex), fxlist, taglist, fxindex, numslots);
		}
		sound = settings.(var_c0e21df2 + "_sound");
	}
	for(i = 0; i < fxlist.size; i++)
	{
		fx_handle = util::playfxontag(localclientnum, fxlist[i], self, taglist[i]);
		if(!isdefined(self.damage_state_fx_handles))
		{
			self.damage_state_fx_handles = [];
		}
		else if(!isarray(self.damage_state_fx_handles))
		{
			self.damage_state_fx_handles = array(self.damage_state_fx_handles);
		}
		self.damage_state_fx_handles[self.damage_state_fx_handles.size] = fx_handle;
	}
	if(isdefined(self) && isdefined(sound))
	{
		self playsound(localclientnum, sound);
	}
}

/*
	Name: field_death_spawn_dynents
	Namespace: vehicle
	Checksum: 0xA19BD8BD
	Offset: 0x7AB0
	Size: 0x646
	Parameters: 7
	Flags: Linked
*/
function field_death_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(localclientnum == 0)
	{
		velocity = self getvelocity();
		numdynents = (isdefined(settings.death_dynent_count) ? settings.death_dynent_count : 0);
		for(i = 0; i < numdynents; i++)
		{
			model = settings.("death_dynmodel" + i);
			if(!isdefined(model))
			{
				continue;
			}
			gibpart = settings.("death_dynent_gib" + i);
			if(self.gibbed === 1 && gibpart === 1)
			{
				continue;
			}
			pitch = (isdefined(settings.("death_dynent_force_pitch" + i)) ? settings.("death_dynent_force_pitch" + i) : 0);
			yaw = (isdefined(settings.("death_dynent_force_yaw" + i)) ? settings.("death_dynent_force_yaw" + i) : 0);
			angles = (randomfloatrange(pitch - 15, pitch + 15), randomfloatrange(yaw - 20, yaw + 20), randomfloatrange(-20, 20));
			direction = anglestoforward(self.angles + angles);
			minscale = (isdefined(settings.("death_dynent_force_minscale" + i)) ? settings.("death_dynent_force_minscale" + i) : 0);
			maxscale = (isdefined(settings.("death_dynent_force_maxscale" + i)) ? settings.("death_dynent_force_maxscale" + i) : 0);
			force = direction * randomfloatrange(minscale, maxscale);
			loc_00007E2C:
			loc_00007E64:
			offset = ((isdefined(settings.("death_dynent_offsetX" + i)) ? settings.("death_dynent_offsetX" + i) : 0), (isdefined(settings.("death_dynent_offsetY" + i)) ? settings.("death_dynent_offsetY" + i) : 0), (isdefined(settings.("death_dynent_offsetZ" + i)) ? settings.("death_dynent_offsetZ" + i) : 0));
			switch(newval)
			{
				case 0:
				{
					break;
				}
				case 1:
				{
					fx = settings.("death_dynent_fx" + i);
					break;
				}
				case 2:
				{
					fx = settings.("death_dynent_elec_fx" + i);
					break;
				}
				case 3:
				{
					fx = settings.("death_dynent_fire_fx" + i);
					break;
				}
			}
			offset = rotatepoint(offset, self.angles);
			if(newval > 1 && isdefined(fx))
			{
				dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
			}
			else
			{
				if(newval == 1 && isdefined(fx))
				{
					dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8, fx);
				}
				else
				{
					dynent = createdynentandlaunch(localclientnum, model, self.origin + offset, self.angles, (0, 0, 0), velocity * 0.8);
				}
			}
			if(isdefined(dynent))
			{
				hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
				launchdynent(dynent, force, hitoffset);
			}
		}
	}
}

/*
	Name: field_gib_spawn_dynents
	Namespace: vehicle
	Checksum: 0x6DE2272D
	Offset: 0x8100
	Size: 0x54E
	Parameters: 7
	Flags: Linked
*/
function field_gib_spawn_dynents(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.scriptbundlesettings))
	{
		return;
	}
	settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	if(localclientnum == 0)
	{
		velocity = self getvelocity();
		numdynents = 2;
		for(i = 0; i < numdynents; i++)
		{
			model = settings.("servo_gib_model" + i);
			if(!isdefined(model))
			{
				return;
			}
			self.gibbed = 1;
			origin = self.origin;
			angles = self.angles;
			hidetag = settings.("servo_gib_tag" + i);
			if(isdefined(hidetag))
			{
				origin = self gettagorigin(hidetag);
				angles = self gettagangles(hidetag);
			}
			pitch = (isdefined(settings.("servo_gib_force_pitch" + i)) ? settings.("servo_gib_force_pitch" + i) : 0);
			yaw = (isdefined(settings.("servo_gib_force_yaw" + i)) ? settings.("servo_gib_force_yaw" + i) : 0);
			relative_angles = (randomfloatrange(pitch - 5, pitch + 5), randomfloatrange(yaw - 5, yaw + 5), randomfloatrange(-5, 5));
			direction = anglestoforward(angles + relative_angles);
			minscale = (isdefined(settings.("servo_gib_force_minscale" + i)) ? settings.("servo_gib_force_minscale" + i) : 0);
			maxscale = (isdefined(settings.("servo_gib_force_maxscale" + i)) ? settings.("servo_gib_force_maxscale" + i) : 0);
			force = direction * randomfloatrange(minscale, maxscale);
			loc_0000849C:
			loc_000084D4:
			offset = ((isdefined(settings.("servo_gib_offsetX" + i)) ? settings.("servo_gib_offsetX" + i) : 0), (isdefined(settings.("servo_gib_offsetY" + i)) ? settings.("servo_gib_offsetY" + i) : 0), (isdefined(settings.("servo_gib_offsetZ" + i)) ? settings.("servo_gib_offsetZ" + i) : 0));
			fx = settings.("servo_gib_fx" + i);
			offset = rotatepoint(offset, angles);
			if(isdefined(fx))
			{
				dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8, fx);
			}
			else
			{
				dynent = createdynentandlaunch(localclientnum, model, origin + offset, angles, (0, 0, 0), velocity * 0.8);
			}
			if(isdefined(dynent))
			{
				hitoffset = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));
				launchdynent(dynent, force, hitoffset);
			}
		}
	}
}

/*
	Name: build_damage_filter_list
	Namespace: vehicle
	Checksum: 0x976754D9
	Offset: 0x8658
	Size: 0xAA
	Parameters: 0
	Flags: AutoExec
*/
function autoexec build_damage_filter_list()
{
	if(!isdefined(level.vehicle_damage_filters))
	{
		level.vehicle_damage_filters = [];
	}
	level.vehicle_damage_filters[0] = "generic_filter_vehicle_damage";
	level.vehicle_damage_filters[1] = "generic_filter_sam_damage";
	level.vehicle_damage_filters[2] = "generic_filter_f35_damage";
	level.vehicle_damage_filters[3] = "generic_filter_vehicle_damage_sonar";
	level.vehicle_damage_filters[4] = "generic_filter_rts_vehicle_damage";
}

/*
	Name: init_damage_filter
	Namespace: vehicle
	Checksum: 0xC3C3A6C4
	Offset: 0x8710
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function init_damage_filter(materialid)
{
	level.localplayers[0].damage_filter_intensity = 0;
	materialname = level.vehicle_damage_filters[materialid];
	filter::init_filter_vehicle_damage(level.localplayers[0], materialname);
	filter::enable_filter_vehicle_damage(level.localplayers[0], 3, materialname);
	filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, 0);
	filter::set_filter_vehicle_sun_position(level.localplayers[0], 3, 0, 0);
}

/*
	Name: damage_filter_enable
	Namespace: vehicle
	Checksum: 0xE0BFC090
	Offset: 0x87F8
	Size: 0x94
	Parameters: 2
	Flags: None
*/
function damage_filter_enable(localclientnum, materialid)
{
	filter::enable_filter_vehicle_damage(level.localplayers[0], 3, level.vehicle_damage_filters[materialid]);
	level.localplayers[0].damage_filter_intensity = 0;
	filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
}

/*
	Name: damage_filter_disable
	Namespace: vehicle
	Checksum: 0xB710356C
	Offset: 0x8898
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function damage_filter_disable(localclientnum)
{
	level notify(#"damage_filter_off");
	level.localplayers[0].damage_filter_intensity = 0;
	filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
	filter::disable_filter_vehicle_damage(level.localplayers[0], 3);
}

/*
	Name: damage_filter_off
	Namespace: vehicle
	Checksum: 0xC6F31C2B
	Offset: 0x8940
	Size: 0x130
	Parameters: 1
	Flags: None
*/
function damage_filter_off(localclientnum)
{
	level endon(#"damage_filter");
	level endon(#"damage_filter_off");
	level endon(#"damage_filter_heavy");
	if(!isdefined(level.localplayers[0].damage_filter_intensity))
	{
		return;
	}
	while(level.localplayers[0].damage_filter_intensity > 0)
	{
		level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity - 0.05050606;
		if(level.localplayers[0].damage_filter_intensity < 0)
		{
			level.localplayers[0].damage_filter_intensity = 0;
		}
		filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
		wait(0.016667);
	}
}

/*
	Name: damage_filter_light
	Namespace: vehicle
	Checksum: 0x96BB3F2
	Offset: 0x8A78
	Size: 0x128
	Parameters: 1
	Flags: None
*/
function damage_filter_light(localclientnum)
{
	level endon(#"damage_filter_off");
	level endon(#"damage_filter_heavy");
	level notify(#"damage_filter");
	while(level.localplayers[0].damage_filter_intensity < 0.5)
	{
		level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
		if(level.localplayers[0].damage_filter_intensity > 0.5)
		{
			level.localplayers[0].damage_filter_intensity = 0.5;
		}
		filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
		wait(0.016667);
	}
}

/*
	Name: damage_filter_heavy
	Namespace: vehicle
	Checksum: 0x62DEB766
	Offset: 0x8BA8
	Size: 0x100
	Parameters: 1
	Flags: None
*/
function damage_filter_heavy(localclientnum)
{
	level endon(#"damage_filter_off");
	level notify(#"damage_filter_heavy");
	while(level.localplayers[0].damage_filter_intensity < 1)
	{
		level.localplayers[0].damage_filter_intensity = level.localplayers[0].damage_filter_intensity + 0.083335;
		if(level.localplayers[0].damage_filter_intensity > 1)
		{
			level.localplayers[0].damage_filter_intensity = 1;
		}
		filter::set_filter_vehicle_damage_amount(level.localplayers[0], 3, level.localplayers[0].damage_filter_intensity);
		wait(0.016667);
	}
}

/*
	Name: function_9facca21
	Namespace: vehicle
	Checksum: 0xDA32CC31
	Offset: 0x8CB0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function function_9facca21(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_3f24c5a(newval);
	}
}

/*
	Name: play_flare_fx
	Namespace: vehicle
	Checksum: 0xB463BAC6
	Offset: 0x8D20
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function play_flare_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_26fb93b4 = util::playfxontag(localclientnum, #"hash_3905863dd0908e4a", self, "tag_origin");
	}
	if(newval == 0)
	{
		if(isdefined(self.var_26fb93b4))
		{
			stopfx(localclientnum, self.var_26fb93b4);
			self.var_26fb93b4 = undefined;
		}
	}
}

/*
	Name: play_flare_hit_fx
	Namespace: vehicle
	Checksum: 0x770F1E0D
	Offset: 0x8DE8
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function play_flare_hit_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_b4178826 = util::playfxontag(localclientnum, #"hash_1e747bdc27127b91", self, "tag_origin");
	}
	if(newval == 0)
	{
		if(isdefined(self.var_b4178826))
		{
			stopfx(localclientnum, self.var_b4178826);
			self.var_b4178826 = undefined;
		}
	}
}

/*
	Name: set_static_amount
	Namespace: vehicle
	Checksum: 0x1CC99B9F
	Offset: 0x8EB0
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function set_static_amount(staticamount)
{
	driverlocalclient = self getlocalclientdriver();
	if(isdefined(driverlocalclient))
	{
		setfilterpassconstant(driverlocalclient, 4, 0, 1, staticamount);
	}
}

