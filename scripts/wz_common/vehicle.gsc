// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1af22ad25a2111f7;
#using script_1cf46b33555422b7;
#using script_290b3da82a2a68e4;
#using script_47fb62300ac0bd60;
#using script_48bb1764a662152d;
#using script_578e247c429144f6;
#using script_5961deb533dad533;
#using script_7452a079afe69150;
#using script_8abfb58852911dd;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace namespace_964fbfb5;

/*
	Name: function_89f2df9
	Namespace: namespace_964fbfb5
	Checksum: 0x99C1CA19
	Offset: 0x7D8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_efc308ec898ff43", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_964fbfb5
	Checksum: 0x2A682FFE
	Offset: 0x820
	Size: 0x4C4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_9c103fe0 = [10:"player_motorcycle", 9:"player_tank", 8:"player_muscle", 7:"player_suv", 6:"helicopter_utility", 5:"pbr_boat_wz", 4:"player_fav", 3:"tactical_raft_wz", 2:"helicopter_light", 1:"cargo_truck_wz", 0:"player_atv"];
	vehicle::add_main_callback("player_atv", &function_500291c4);
	vehicle::add_main_callback("cargo_truck_wz", &function_8278ed00);
	vehicle::add_main_callback("helicopter_light", &function_b1d54776);
	vehicle::add_main_callback("helicopter_utility", &function_8fb65b2a);
	vehicle::add_main_callback("tactical_raft_wz", &function_6b617752);
	vehicle::add_main_callback("player_fav", &function_bd3b5229);
	vehicle::add_main_callback("pbr_boat_wz", &function_cc0af45d);
	vehicle::add_main_callback("player_suv", &function_79500af5);
	vehicle::add_main_callback("player_muscle", &function_fb9c790a);
	vehicle::add_main_callback("player_tank", &function_c0f1d81b);
	vehicle::add_main_callback("player_motorcycle", &function_cb575bc3);
	callback::on_vehicle_damage(&on_vehicle_damage);
	callback::on_player_damage(&on_player_damage);
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_end_game(&on_end_game);
	callback::on_vehicle_spawned(&vehicle_spawned);
	clientfield::register("scriptmover", "deathfx", 1, 1, "int");
	clientfield::register("vehicle", "overheat_fx", 9000, 1, "int");
	clientfield::register("vehicle", "replacer_fx", 1, 1, "int");
	clientfield::register("toplayer", "toggle_vehicle_sensor", 1, 1, "int");
	clientfield::register("scriptmover", "tank_deathfx", 22000, 1, "int");
	level thread function_69c9e9a0();
	level.var_cd8f416a = [];
	level.var_63e0085 = 0;
	level.var_e5010085 = vehicleturretoverheat::register("vehicleTurretOverheat");
	level.var_b5add14a = vehicleturretdurability::register("vehicleTurretDurability");
	level.var_2513e40c = &function_2513e40c;
	level.is_staircase_up = &is_staircase_up;
	level.var_7c6454 = 1;
	level.var_80d8731e = 0;
	level.var_6ed50229 = 10;
	/#
		level thread function_44b9dd1d();
	#/
}

/*
	Name: function_eaba72c9
	Namespace: namespace_964fbfb5
	Checksum: 0x189C24EE
	Offset: 0xCF0
	Size: 0x8E
	Parameters: 0
	Flags: Private
*/
private function function_eaba72c9()
{
	/#
		self notify("");
		self endon("");
		while(true)
		{
			if(getdvarint(#"hash_7d9fc228773dbb5e", 0) > 0)
			{
				function_40fc185b();
				setdvar(#"hash_7d9fc228773dbb5e", 0);
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_40fc185b
	Namespace: namespace_964fbfb5
	Checksum: 0xB3CA057D
	Offset: 0xD88
	Size: 0x20
	Parameters: 0
	Flags: Private
*/
private function function_40fc185b()
{
	/#
		level notify(#"hash_724a3976e45a71e2");
	#/
}

/*
	Name: function_44b9dd1d
	Namespace: namespace_964fbfb5
	Checksum: 0xF31BAE50
	Offset: 0xDB0
	Size: 0x84
	Parameters: 0
	Flags: Private
*/
private function function_44b9dd1d()
{
	/#
		while(!canadddebugcommand())
		{
			waitframe(1);
		}
		mapname = util::function_53bbf9d2();
		adddebugcommand(("" + mapname) + "");
		level thread function_eaba72c9();
	#/
}

/*
	Name: function_4c6bcfe2
	Namespace: namespace_964fbfb5
	Checksum: 0xAA42B934
	Offset: 0xE40
	Size: 0x18C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4c6bcfe2(var_b42f0937 = 0)
{
	level.var_cd8f416a[level.var_cd8f416a.size] = self;
	if(isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	self.var_ffdf490c = 1;
	self.script_disconnectpaths = 0;
	self.do_scripted_crash = 0;
	self.var_92043a49 = 1;
	self.var_97f1b32a = 1;
	target_set(self, (0, 0, 0));
	self callback::function_d8abfc3d(#"hash_1a32e0fdeb70a76b", &function_c25f7d1);
	if(isdefined(self.settings) && (isdefined(self.settings.var_6754976b) && self.settings.var_6754976b))
	{
		self callback::function_d8abfc3d(#"hash_6e388f6a0df7bdac", &function_ef44d420);
	}
	if(var_b42f0937)
	{
		self function_bc79899e();
	}
	self thread function_e63726f6();
}

/*
	Name: vehicle_spawned
	Namespace: namespace_964fbfb5
	Checksum: 0x3B888A98
	Offset: 0xFD8
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
private function vehicle_spawned()
{
	self.var_32371376 = level.var_80d8731e;
	level.var_80d8731e++;
	self.emped = 0;
	self.vehkilloccupantsondeath = 1;
	/#
		self thread deletemeonnotify(level, "");
	#/
}

/*
	Name: function_bc79899e
	Namespace: namespace_964fbfb5
	Checksum: 0x54275E17
	Offset: 0x1040
	Size: 0xC2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bc79899e()
{
	self vehicle_ai::init_state_machine_for_role("default");
	self vehicle_ai::add_interrupt_connection("driving", "off", "exit_vehicle", &vehicle_ai::function_6664e3af);
	self vehicle_ai::add_interrupt_connection("driving", "off", "emped_vehicle", &vehicle_ai::function_6664e3af);
	self vehicle_ai::get_state_callbacks("driving").enter_func = &function_25b9a9b;
}

/*
	Name: function_7ae07b7
	Namespace: namespace_964fbfb5
	Checksum: 0xDD33B738
	Offset: 0x1110
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7ae07b7()
{
	if(self vehicle_ai::has_state("off"))
	{
		vehicle_ai::startinitialstate("off");
	}
	else
	{
		self function_ed173e0b();
	}
}

/*
	Name: function_e95a0595
	Namespace: namespace_964fbfb5
	Checksum: 0x8C319FBE
	Offset: 0x1170
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e95a0595()
{
	if(self.scriptvehicletype == "helicopter_light" || self.scriptvehicletype == "helicopter_utility")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_25b9a9b
	Namespace: namespace_964fbfb5
	Checksum: 0x809C8470
	Offset: 0x11B0
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
private function function_25b9a9b(params)
{
	params.var_c2e048f9 = 1;
	if(isdefined(self.emped) && self.emped || (isdefined(self.isjammed) && self.isjammed))
	{
		return;
	}
	self vehicle_ai::defaultstate_driving_enter(params);
}

/*
	Name: turn_on
	Namespace: namespace_964fbfb5
	Checksum: 0x4B02629F
	Offset: 0x1220
	Size: 0x122
	Parameters: 0
	Flags: Linked, Private
*/
private function turn_on()
{
	if(isdefined(self.emped) && self.emped || (isdefined(self.isjammed) && self.isjammed))
	{
		if(isairborne(self))
		{
			self takeplayercontrol();
		}
		return;
	}
	if(isdefined(self.state_machines))
	{
		return;
	}
	var_9cd704a7 = spawnstruct();
	var_9cd704a7.var_da88902a = 1;
	self vehicle_ai::defaultstate_off_exit(var_9cd704a7);
	var_a56c96d1 = spawnstruct();
	var_a56c96d1.var_c2e048f9 = 1;
	var_a56c96d1.turn_off = &turn_off;
	self vehicle_ai::defaultstate_driving_enter(var_a56c96d1);
	self.var_52e23e90 = 1;
}

/*
	Name: turn_off
	Namespace: namespace_964fbfb5
	Checksum: 0xA887B32A
	Offset: 0x1350
	Size: 0x236
	Parameters: 0
	Flags: Linked, Private
*/
private function turn_off()
{
	if(isdefined(self.state_machines))
	{
		return;
	}
	if(isdefined(self.var_52e23e90) && self.var_52e23e90)
	{
		self vehicle::function_7f0bbde3();
	}
	self vehicle_ai::defaultstate_driving_exit();
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self vehicle::function_bbc1d940(0);
	self disableaimassist();
	params = spawnstruct();
	params.var_c1273f91 = 1;
	params.laseron = islaseron(self);
	self vehicle::lights_off();
	self vehicle::toggle_lights_group(1, 0);
	self vehicle::toggle_lights_group(2, 0);
	self vehicle::toggle_lights_group(3, 0);
	self vehicle::toggle_lights_group(4, 0);
	self vehicle::toggle_force_driver_taillights(0);
	self vehicle_ai::turnoffallambientanims();
	if(isairborne(self))
	{
		self setphysacceleration(vectorscale((0, 0, -1), 300));
		self thread vehicle_ai::level_out_for_landing();
		self setrotorspeed(0);
	}
	self.var_52e23e90 = undefined;
}

/*
	Name: function_ed173e0b
	Namespace: namespace_964fbfb5
	Checksum: 0x8B422559
	Offset: 0x1590
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ed173e0b()
{
	if(isdefined(self.state_machines))
	{
		return;
	}
	var_9cd704a7 = spawnstruct();
	self vehicle_ai::defaultstate_off_enter(var_9cd704a7);
}

/*
	Name: function_b8c069cc
	Namespace: namespace_964fbfb5
	Checksum: 0x5D5B3994
	Offset: 0x15E0
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_b8c069cc(notifyhash)
{
	if(notifyhash == #"emped_vehicle")
	{
		if(isdefined(self) && isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](self);
		}
	}
}

/*
	Name: is_staircase_up
	Namespace: namespace_964fbfb5
	Checksum: 0x3DED215
	Offset: 0x1638
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function is_staircase_up(var_dbd1a594 = undefined, jammer = undefined)
{
	if(!isvehicle(self))
	{
		return;
	}
	self notify(#"emped_vehicle");
	self endon(#"emped_vehicle", #"death");
	params = spawnstruct();
	emp_duration = 30;
	if(isdefined(level.var_578f7c6d.var_4dd46f8a.var_3bd9b483))
	{
		emp_duration = level.var_578f7c6d.var_4dd46f8a.var_3bd9b483;
	}
	params.param0 = emp_duration;
	params.param1 = var_dbd1a594;
	params.param2 = jammer;
	if(isplayer(var_dbd1a594))
	{
		level callback::callback(#"hash_69ec922777c59153", {#vehicle:self, #attacker:var_dbd1a594});
	}
	if(isdefined(self.is_staircase_up))
	{
		self [[self.is_staircase_up]](params);
	}
	else
	{
		self function_c9620f20(params);
	}
}

/*
	Name: function_d69d0773
	Namespace: namespace_964fbfb5
	Checksum: 0x850176E3
	Offset: 0x17F0
	Size: 0x42
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d69d0773()
{
	if(!isdefined(self.var_d6a1af09))
	{
		self.var_d6a1af09 = 0;
	}
	if((gettime() - self.var_d6a1af09) >= 250)
	{
		self.var_d6a1af09 = gettime();
		return 1;
	}
	return 0;
}

/*
	Name: function_36aab2f3
	Namespace: namespace_964fbfb5
	Checksum: 0xADFC8E92
	Offset: 0x1840
	Size: 0xA74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_36aab2f3(params)
{
	if(!function_d69d0773())
	{
		return;
	}
	switch(self.scriptvehicletype)
	{
		case "player_atv":
		{
			var_1fdf316c = getdvarfloat(#"hash_3c9cb797fd1a7f8b", 30);
			var_a7796a79 = getdvarfloat(#"hash_67059652c5fc1945", 60);
			mindamage = getdvarfloat(#"hash_1f5d38cc94106adf", 50);
			maxdamage = getdvarfloat(#"hash_66a67ad27c3cd339", 200);
			var_1831f049 = 1;
			var_a1805d6e = 0.7;
			break;
		}
		case "cargo_truck_wz":
		{
			var_1fdf316c = getdvarfloat(#"hash_4bbc02727c5ebc00", 30);
			var_a7796a79 = getdvarfloat(#"hash_7d04949e6e62380e", 60);
			mindamage = getdvarfloat(#"hash_52512d74a3eaae58", 30);
			maxdamage = getdvarfloat(#"hash_5702452fcb66d0de", 150);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		case "player_fav":
		{
			var_1fdf316c = getdvarfloat(#"hash_21e0e2bc88bf5eee", 30);
			var_a7796a79 = getdvarfloat(#"hash_7584662ee854d540", 60);
			mindamage = getdvarfloat(#"hash_435111f252ea9cfe", 40);
			maxdamage = getdvarfloat(#"hash_3a9f03cd0d3c6a98", 175);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		case "player_muscle":
		{
			var_1fdf316c = getdvarfloat(#"hash_46ffe025ec0e29a3", 30);
			var_a7796a79 = getdvarfloat(#"hash_1cf739db893af58d", 60);
			mindamage = getdvarfloat(#"hash_75a62632d4824747", 40);
			maxdamage = getdvarfloat(#"hash_46431eb054c6591", 175);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		case "player_suv":
		{
			var_1fdf316c = getdvarfloat(#"hash_31bcf3ba672e011a", 30);
			var_a7796a79 = getdvarfloat(#"hash_6205883210ae5f44", 60);
			mindamage = getdvarfloat(#"hash_299248d6a8cd7aba", 40);
			maxdamage = getdvarfloat(#"hash_64fad23d050b27dc", 175);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		case "player_tank":
		{
			var_1fdf316c = getdvarfloat(#"hash_c5ad19a486bd60a", 30);
			var_a7796a79 = getdvarfloat(#"hash_4f511bbff314c254", 60);
			mindamage = getdvarfloat(#"hash_11000a506eed148a", 0);
			maxdamage = getdvarfloat(#"hash_35d85e4c7595b48c", 0);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		case "player_motorcycle":
		{
			var_1fdf316c = getdvarfloat(#"hash_2b5bc92dcb8ebcf9", 30);
			var_a7796a79 = getdvarfloat(#"hash_201167604d4407b7", 60);
			mindamage = getdvarfloat(#"hash_1ff8cff709af67d", 20);
			maxdamage = getdvarfloat(#"hash_6c1be10e4f16becb", 100);
			var_1831f049 = 2;
			var_a1805d6e = 0.9;
			break;
		}
		default:
		{
			var_1fdf316c = 30;
			var_a7796a79 = 60;
			mindamage = 50;
			maxdamage = 250;
			var_1831f049 = 1;
			var_a1805d6e = 0.9;
			break;
		}
	}
	if(isdefined(params) && isdefined(params.entity) && params.entity.scriptvehicletype === "player_tank")
	{
		tank = params.entity;
		if(isdefined(tank))
		{
			driver = tank getseatoccupant(0);
			if(isdefined(driver))
			{
				if(!isdefined(tank.var_9be5a571))
				{
					tank.var_9be5a571 = [];
				}
				if(isvehicle(self) && isarray(tank.var_9be5a571) && isalive(self) && self.scriptvehicletype !== "player_tank" && !isinarray(tank.var_9be5a571, self))
				{
					if(!isdefined(tank.var_9be5a571))
					{
						tank.var_9be5a571 = [];
					}
					else if(!isarray(tank.var_9be5a571))
					{
						tank.var_9be5a571 = array(tank.var_9be5a571);
					}
					tank.var_9be5a571[tank.var_9be5a571.size] = self;
				}
			}
		}
	}
	var_2ad7f33b = params.intensity;
	if(isdefined(var_2ad7f33b) && var_2ad7f33b > var_1fdf316c)
	{
		var_ae95ae92 = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, var_2ad7f33b);
		if(isdefined(params.normal) && params.normal[2] < -0.5)
		{
			var_d3f8fc8a = vectordot(anglestoup(self.angles), -1 * params.normal);
			if(var_d3f8fc8a > var_a1805d6e)
			{
				var_ae95ae92 = var_ae95ae92 * 0.1;
			}
		}
		if(isdefined(params.entity) && isvehicle(params.entity))
		{
			riders = params.entity getvehoccupants();
			if(isdefined(riders) && isdefined(riders[0]))
			{
				attacker = riders[0];
			}
			else
			{
				attacker = self;
			}
		}
		self dodamage(var_ae95ae92, self.origin, attacker);
	}
	if(isdefined(params.entity) && issentient(params.entity))
	{
		if(isdefined(var_2ad7f33b) && var_2ad7f33b > 12)
		{
			var_ae95ae92 = mapfloat(12, 50, 50, 1000, var_2ad7f33b);
			params.entity dodamage(var_ae95ae92 * var_1831f049, self.origin, self);
		}
	}
}

/*
	Name: function_53f7a11f
	Namespace: namespace_964fbfb5
	Checksum: 0x1AEBFF0F
	Offset: 0x22C0
	Size: 0x1E8
	Parameters: 1
	Flags: Linked
*/
function function_53f7a11f(player)
{
	self notify("7c6b83f347bc4585");
	self endon("7c6b83f347bc4585");
	self endon(#"death");
	player endon(#"death", #"exit_vehicle", #"change_seat");
	var_41f2c809 = 0;
	while(true)
	{
		for(i = 0; i < self.var_9be5a571.size; i++)
		{
			vehicle = self.var_9be5a571[i];
			if(isdefined(vehicle) && isvehicle(vehicle))
			{
				dist = distance2dsquared(self.origin, vehicle.origin);
				if(dist >= 64000)
				{
					arrayremovevalue(self.var_9be5a571, vehicle);
					continue;
				}
				z_dist = self.origin[2] - vehicle.origin[2];
				if(z_dist > 0 && dist <= 9000)
				{
					if(isalive(vehicle))
					{
						vehicle dodamage(vehicle.health, self.origin, self);
					}
					arrayremovevalue(self.var_9be5a571, vehicle);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: on_player_corpse
	Namespace: namespace_964fbfb5
	Checksum: 0x5526F6B
	Offset: 0x24B0
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function on_player_corpse()
{
	foreach(player in getplayers())
	{
		if(isdefined(player.var_2e8665de) && player.var_2e8665de && self === player.body)
		{
			self hide();
			return;
		}
	}
}

/*
	Name: function_69c9e9a0
	Namespace: namespace_964fbfb5
	Checksum: 0x79967A5F
	Offset: 0x2578
	Size: 0x188
	Parameters: 0
	Flags: Linked
*/
function function_69c9e9a0()
{
	level endon(#"game_ended");
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_4aced1739d6627a2");
		vehicle = waitresult.vehicle;
		if(!isvehicle(vehicle))
		{
			continue;
		}
		callback::on_player_corpse(&on_player_corpse);
		occupants = vehicle getvehoccupants();
		foreach(occupant in occupants)
		{
			occupant unlink();
			occupant.var_2e8665de = 1;
			occupant dodamage(occupant.health * 100, occupant.origin);
		}
		vehicle delete();
	}
}

/*
	Name: function_7ed26e27
	Namespace: namespace_964fbfb5
	Checksum: 0x25F642C9
	Offset: 0x2708
	Size: 0x254
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7ed26e27(vehicle)
{
	vehiclespeed = vehicle getspeedmph();
	if(vehiclespeed >= getdvarfloat(#"hash_3be3de0273ba927c", 30))
	{
		trace = groundtrace(self.origin + vectorscale((0, 0, 1), 10), self.origin - vectorscale((0, 0, 1), 235), 0, self, 0, 0);
		if(trace[#"fraction"] == 1 || trace[#"surfacetype"] === "water")
		{
			return;
		}
		var_1fdf316c = getdvarfloat(#"hash_3be3de0273ba927c", 30);
		var_a7796a79 = getdvarfloat(#"hash_142bd8fcb96c015e", 90);
		mindamage = getdvarfloat(#"hash_2fa8ec57d76f1cac", 20);
		maxdamage = getdvarfloat(#"hash_544adad8efeb58b2", 110);
		var_160753fb = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, vehiclespeed);
		if(var_160753fb > self.health)
		{
			if(var_160753fb / 2 < self.health)
			{
				var_160753fb = self.health - 1;
			}
		}
		self dodamage(var_160753fb, self.origin, undefined, undefined, undefined, "MOD_FALLING");
	}
}

/*
	Name: function_e63726f6
	Namespace: namespace_964fbfb5
	Checksum: 0x1F8BF107
	Offset: 0x2968
	Size: 0x17C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e63726f6()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"hash_57887008fa0fd8ad");
		wait(0.75);
		if(self function_2c2c30e0())
		{
			break;
		}
	}
	occupants = self getvehoccupants();
	if(isdefined(occupants) && occupants.size)
	{
		for(i = 0; i < occupants.size; i++)
		{
			seat = self getoccupantseat(occupants[i]);
			if(isdefined(seat))
			{
				self usevehicle(occupants[i], seat);
			}
		}
	}
	self makevehicleunusable();
	self.takedamage = 0;
	self.var_e8ec304d = 1;
	self clientfield::set("stopallfx", 1);
	self clientfield::set("flickerlights", 1);
}

/*
	Name: function_3054737a
	Namespace: namespace_964fbfb5
	Checksum: 0xFBAC594
	Offset: 0x2AF0
	Size: 0x25E
	Parameters: 1
	Flags: Linked
*/
function function_3054737a(vehicle)
{
	if(game.state == "pregame" || !isplayer(self) || self isremotecontrolling() || isdefined(vehicle.session))
	{
		return;
	}
	vehicle.session = {#hash_a1f4ebc0:0, #hash_3893d13e:0, #hash_45bf3627:0, #hash_ffb0c509:0, #hash_865ffc35:0, #hash_ecd1fe60:0, #hash_33f48e5a:0, #hash_770fd50d:0, #hash_5ba0df6e:0, #hash_309ad81f:0, #hash_efe98761:1, #first_player:int(self getxuid(1)), #end_health:vehicle.health, #start_health:vehicle.health, #end_time:0, #start_time:gettime(), #hash_c87538d9:vehicle.var_32371376, #hash_4ba3155:vehicle.origin[1], #hash_16f7d5d0:vehicle.origin[0], #hash_1ff15d37:vehicle.origin[1], #hash_2dbaf8ca:vehicle.origin[0], #vehicle:vehicle.vehicletype};
}

/*
	Name: function_2d00376
	Namespace: namespace_964fbfb5
	Checksum: 0xE3A340A9
	Offset: 0x2D58
	Size: 0x116
	Parameters: 1
	Flags: Linked
*/
function function_2d00376(vehicle)
{
	if(game.state == "pregame")
	{
		return;
	}
	if(isdefined(vehicle.session))
	{
		vehicle.session.end_time = function_f8d53445();
		vehicle.session.end_health = int(max(0, vehicle.health));
		vehicle.session.var_16f7d5d0 = vehicle.origin[0];
		vehicle.session.var_4ba3155 = vehicle.origin[1];
		function_92d1707f(#"hash_4fd470ea26ade803", vehicle.session);
		vehicle.session = undefined;
	}
}

/*
	Name: on_vehicle_damage
	Namespace: namespace_964fbfb5
	Checksum: 0x8BB1B81C
	Offset: 0x2E78
	Size: 0x80C
	Parameters: 1
	Flags: Linked
*/
function on_vehicle_damage(params)
{
	vehicle = self;
	if(isdefined(vehicle.session))
	{
		if(isdefined(params.eattacker) && (isdefined(params.eattacker.var_46439e18) && params.eattacker.var_46439e18))
		{
			var_364c1a03 = params.eattacker;
			if(var_364c1a03 == vehicle)
			{
				vehicle.session.var_309ad81f = vehicle.session.var_309ad81f + params.idamage;
				return;
			}
			if(isdefined(var_364c1a03.session))
			{
				var_364c1a03.session.var_ecd1fe60 = var_364c1a03.session.var_ecd1fe60 + params.idamage;
				vehicle.session.var_770fd50d = vehicle.session.var_770fd50d + params.idamage;
				return;
			}
		}
		vehicle.session.var_5ba0df6e = vehicle.session.var_5ba0df6e + params.idamage;
	}
	if(isdefined(params) && isplayer(params.eattacker) && isdefined(params.idamage))
	{
		params.eattacker stats::function_d40764f3(#"vehicle_damage", int(params.idamage));
		occupants = vehicle getvehoccupants();
		if(isdefined(occupants) && occupants.size > 0)
		{
			params.eattacker stats::function_d40764f3(#"hash_6d5ae3ac5cb7968a", int(params.idamage));
		}
	}
	if(isdefined(params) && isdefined(params.smeansofdeath))
	{
		occupants = vehicle getvehoccupants();
		if(isdefined(occupants) && occupants.size > 0)
		{
			foreach(occupant in occupants)
			{
				switch(params.smeansofdeath)
				{
					case "mod_projectile":
					{
						self playsoundtoplayer(#"hash_4cf0470b5276e61a", occupant);
						break;
					}
					case "mod_rifle_bullet":
					case "mod_pistol_bullet":
					{
						self playsoundtoplayer(#"hash_6dd3a55ee3658ca", occupant);
						break;
					}
				}
			}
		}
	}
	if((isdefined(getgametypesetting(#"hash_464afa49c60793b7")) ? getgametypesetting(#"hash_464afa49c60793b7") : 0))
	{
		if(vehicle.scriptvehicletype == "player_fav")
		{
			if(isdefined(params) && isdefined(params.smeansofdeath))
			{
				if(params.partname === #"tag_gunner_turret1" || params.partname === #"tag_gunner_barrel1")
				{
					var_b522a590 = (isdefined(getgametypesetting(#"hash_3e111be61438fd22")) ? getgametypesetting(#"hash_3e111be61438fd22") : 1);
					var_204c6da4 = (isdefined(getgametypesetting(#"hash_5ba752e23e79af9d")) ? getgametypesetting(#"hash_5ba752e23e79af9d") : 5);
					var_ebe816eb = (isdefined(getgametypesetting(#"hash_36c2eeb3865325f2")) ? getgametypesetting(#"hash_36c2eeb3865325f2") : 0.25);
					if(isdefined(vehicle.var_96c0f900[1]))
					{
						var_251a3d58 = function_41cb03eb(1);
						damageparts = [];
						if(!isdefined(damageparts))
						{
							damageparts = [];
						}
						else if(!isarray(damageparts))
						{
							damageparts = array(damageparts);
						}
						damageparts[damageparts.size] = var_251a3d58;
						switch(params.smeansofdeath)
						{
							case "mod_projectile":
							{
								damage = params.idamage / var_204c6da4;
								if(damage < 0)
								{
									damage = 0;
								}
								else if(damage > 100 * var_ebe816eb)
								{
									damage = 100 * var_ebe816eb;
								}
								vehicle.var_96c0f900[1] = vehicle.var_96c0f900[1] - damage;
								vehicle function_902cf00a(damageparts, int(damage));
								break;
							}
							case "mod_rifle_bullet":
							case "mod_pistol_bullet":
							{
								vehicle.var_96c0f900[1] = vehicle.var_96c0f900[1] - (params.idamage / var_b522a590);
								vehicle function_902cf00a(damageparts, int(params.idamage / var_b522a590));
								break;
							}
						}
						if(vehicle.var_96c0f900[1] < 0)
						{
							vehicle.var_96c0f900[1] = 0;
						}
					}
				}
			}
		}
	}
	vehicle vehicle_ai::update_damage_fx_level(params.idamage);
}

/*
	Name: on_player_damage
	Namespace: namespace_964fbfb5
	Checksum: 0xBC4F3BB5
	Offset: 0x3690
	Size: 0x2E2
	Parameters: 1
	Flags: Linked
*/
function on_player_damage(params)
{
	victim = self;
	attacker = params.eattacker;
	if(isdefined(victim) && (isdefined(victim.usingvehicle) && victim.usingvehicle))
	{
		vehicle = victim getvehicleoccupied();
		if(isdefined(vehicle) && isdefined(vehicle.session))
		{
			vehicle.session.var_ffb0c509 = vehicle.session.var_ffb0c509 + params.idamage;
		}
	}
	if(isdefined(attacker) && (isdefined(attacker.usingvehicle) && attacker.usingvehicle) && isplayer(attacker))
	{
		vehicle = attacker getvehicleoccupied();
		if(isdefined(vehicle))
		{
			if(params.smeansofdeath == "MOD_CRUSH")
			{
				if(isdefined(vehicle.session))
				{
					vehicle.session.var_33f48e5a = vehicle.session.var_33f48e5a + params.idamage;
				}
				if(isdefined(victim))
				{
					victim playsound("veh_body_impact_flesh");
				}
				if(isdefined(vehicle.scriptvehicletype))
				{
					switch(vehicle.scriptvehicletype)
					{
						case "player_atv":
						{
							vehicle playsound("veh_atv_wall_imp");
							break;
						}
						case "cargo_truck_wz":
						{
							vehicle playsound("veh_truck_wall_imp");
							break;
						}
						case "helicopter_light":
						{
							vehicle playsound("veh_heli_wall_imp");
							break;
						}
						case "tactical_raft_wz":
						{
							vehicle playsound("veh_zodiac_wall_imp");
							break;
						}
					}
				}
			}
			else if(isdefined(vehicle.session))
			{
				vehicle.session.var_45bf3627 = vehicle.session.var_45bf3627 + params.idamage;
			}
		}
	}
}

/*
	Name: on_player_killed
	Namespace: namespace_964fbfb5
	Checksum: 0xA547B1C1
	Offset: 0x3980
	Size: 0x140
	Parameters: 1
	Flags: Linked
*/
function on_player_killed(params)
{
	victim = self;
	attacker = params.eattacker;
	if(isdefined(victim.usingvehicle) && victim.usingvehicle)
	{
		vehicle = victim getvehicleoccupied();
		if(isdefined(vehicle) && isdefined(vehicle.session))
		{
			vehicle.session.var_3893d13e++;
		}
	}
	if(isdefined(attacker.usingvehicle) && attacker.usingvehicle)
	{
		vehicle = attacker getvehicleoccupied();
		if(isdefined(vehicle) && isdefined(vehicle.session))
		{
			if(params.smeansofdeath == "MOD_CRUSH")
			{
				vehicle.session.var_865ffc35++;
			}
			else
			{
				vehicle.session.var_a1f4ebc0++;
			}
		}
	}
}

/*
	Name: on_end_game
	Namespace: namespace_964fbfb5
	Checksum: 0xD1A67E8A
	Offset: 0x3AC8
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function on_end_game(params)
{
	vehicles = getvehiclearray();
	for(i = 0; i < vehicles.size; i++)
	{
		function_2d00376(vehicles[i]);
	}
}

/*
	Name: function_df786031
	Namespace: namespace_964fbfb5
	Checksum: 0x1971652F
	Offset: 0x3B38
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_df786031()
{
	return isdefined(self.locking_on) && self.locking_on > 0;
}

/*
	Name: function_ea4291d3
	Namespace: namespace_964fbfb5
	Checksum: 0xBEFE616
	Offset: 0x3B60
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ea4291d3()
{
	return isdefined(self.locked_on) && self.locked_on > 0;
}

/*
	Name: function_b3caeebc
	Namespace: namespace_964fbfb5
	Checksum: 0xC0695A97
	Offset: 0x3B88
	Size: 0x14E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b3caeebc(player)
{
	self endon(#"death");
	player endon(#"exit_vehicle", #"death");
	while(true)
	{
		if(self function_ea4291d3())
		{
			player clientfield::set_player_uimodel("vehicle.missileLock", 2);
			self playsoundtoplayer(#"hash_445c9fb1793c4259", player);
			wait(0.25);
		}
		else if(self function_df786031())
		{
			player clientfield::set_player_uimodel("vehicle.missileLock", 1);
			self playsoundtoplayer(#"hash_107b6827696673cb", player);
			wait(0.25);
		}
		else
		{
			player clientfield::set_player_uimodel("vehicle.missileLock", 0);
			self waittill(#"hash_594587fd1093c3b3");
		}
	}
}

/*
	Name: function_c25f7d1
	Namespace: namespace_964fbfb5
	Checksum: 0x2A265458
	Offset: 0x3CE0
	Size: 0x1D0
	Parameters: 1
	Flags: Linked
*/
function function_c25f7d1(params)
{
	self endon(#"death");
	occupants = self getvehoccupants();
	foreach(occupant in occupants)
	{
		if(!isplayer(occupant))
		{
			continue;
		}
		occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 1);
		occupant thread function_6aa73a2a(params.projectile, self);
	}
	params.projectile waittill(#"projectile_impact_explode", #"death");
	occupants = self getvehoccupants();
	foreach(occupant in occupants)
	{
		if(!isplayer(occupant))
		{
			continue;
		}
		occupant clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
	}
}

/*
	Name: function_6aa73a2a
	Namespace: namespace_964fbfb5
	Checksum: 0xC364B579
	Offset: 0x3EB8
	Size: 0x190
	Parameters: 2
	Flags: Linked, Private
*/
private function function_6aa73a2a(missile, vehicle)
{
	self endon(#"death", #"exit_vehicle");
	missile endon(#"death");
	vehicle endon(#"death");
	range = 8000 - 10;
	dist = undefined;
	while(true)
	{
		old_dist = dist;
		dist = distance(missile.origin, self.origin);
		var_38fa5914 = isdefined(old_dist) && dist < old_dist;
		if(var_38fa5914)
		{
			vehicle playsoundtoplayer(#"uin_ac130_alarm_missile_incoming", self);
		}
		var_6ce65309 = (dist - 10) / range;
		beep_interval = lerpfloat(0.05, 0.2, var_6ce65309);
		wait(beep_interval);
	}
}

/*
	Name: function_adc0649a
	Namespace: namespace_964fbfb5
	Checksum: 0x774FEEC3
	Offset: 0x4050
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function function_adc0649a()
{
	/#
		assert(isvehicle(self));
	#/
	return isdefined(self.emped) && self.emped || (isdefined(self.isjammed) && self.isjammed);
}

/*
	Name: function_ca9b286c
	Namespace: namespace_964fbfb5
	Checksum: 0xB8E70CB0
	Offset: 0x40B8
	Size: 0x3DC
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
	seatindex = eventstruct.seat_index;
	if(!isdefined(vehicle.scriptvehicletype))
	{
		return;
	}
	if(!isinarray(level.var_9c103fe0, vehicle.scriptvehicletype))
	{
		return;
	}
	vehicle.var_4a479473 = gettime();
	if(isdefined(vehicle.isphysicsvehicle) && vehicle.isphysicsvehicle)
	{
		vehicle setbrake(0);
	}
	self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
	if(isdefined(vehicle.var_10206310))
	{
		vehicle thread [[vehicle.var_10206310]](self, eventstruct);
	}
	if(isdefined(level.var_8819644a))
	{
		for(i = 0; i < level.var_8819644a.size; i++)
		{
			if(isdefined(level.var_8819644a[i].vehicle) && level.var_8819644a[i].vehicle == vehicle)
			{
				level.var_8819644a[i].used = 1;
			}
		}
	}
	if(!isdefined(vehicle.session))
	{
		function_3054737a(vehicle);
	}
	else
	{
		occupants = vehicle getvehoccupants();
		vehicle.session.var_efe98761 = int(max(vehicle.session.var_efe98761, occupants.size));
	}
	if(seatindex === 0)
	{
		vehicle turn_on();
		namespace_d3564fd8::function_66fe9481(vehicle, self, seatindex);
		namespace_78a95918::function_66fe9481(vehicle, self, seatindex);
	}
	if(isdefined(vehicle.settings) && (isdefined(vehicle.settings.var_6754976b) && vehicle.settings.var_6754976b))
	{
		if(seatindex === 0)
		{
			if(isdefined(vehicle.var_304cf9da) && vehicle.var_304cf9da)
			{
				vehicle vehicle::function_bbc1d940(1);
			}
		}
		var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");
		if(isdefined(var_1861e0b1) && var_1861e0b1)
		{
			self clientfield::set_to_player("toggle_vehicle_sensor", 1);
		}
	}
	isemped = vehicle function_adc0649a();
	vehicle function_388973e4(isemped);
	vehicle thread function_b3caeebc(self);
}

/*
	Name: function_e011eea6
	Namespace: namespace_964fbfb5
	Checksum: 0x616456CD
	Offset: 0x44A0
	Size: 0x29C
	Parameters: 1
	Flags: Event
*/
event function_e011eea6(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	seatindex = eventstruct.seat_index;
	if(!isdefined(vehicle))
	{
		return;
	}
	if(!isinarray(level.var_9c103fe0, vehicle.scriptvehicletype))
	{
		return;
	}
	vehicle.var_8e382c5f = gettime();
	var_d8bf3ee8 = vehicle getvehoccupants();
	if(var_d8bf3ee8.size == 0)
	{
		function_2d00376(vehicle);
	}
	self function_7ed26e27(vehicle);
	self clientfield::set_player_uimodel("vehicle.incomingMissile", 0);
	self clientfield::set_player_uimodel("vehicle.missileLock", 0);
	if(isdefined(vehicle.var_ed2aaade))
	{
		vehicle thread [[vehicle.var_ed2aaade]](self, eventstruct);
	}
	if(isdefined(vehicle.settings) && (isdefined(vehicle.settings.var_6754976b) && vehicle.settings.var_6754976b))
	{
		self clientfield::set_to_player("toggle_vehicle_sensor", 0);
	}
	if(vehicle function_ea4291d3())
	{
		namespace_d3564fd8::on_exit_locked_on_vehicle(self);
	}
	if(seatindex !== 0)
	{
		return;
	}
	vehicle function_6a65d095();
	if(isdefined(vehicle.var_97f1b32a) && vehicle.var_97f1b32a)
	{
		vehicle.var_735382e = self;
		vehicle.var_a816f2cd = gettime();
	}
	vehicle turn_off();
	if(isdefined(vehicle.var_ffdf490c) && vehicle.var_ffdf490c)
	{
		vehicle thread function_ffdf490c();
	}
}

/*
	Name: function_3a4d53f8
	Namespace: namespace_964fbfb5
	Checksum: 0x71A94ADD
	Offset: 0x4748
	Size: 0x6C
	Parameters: 1
	Flags: Event
*/
event function_3a4d53f8(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	if(isdefined(vehicle.var_bc0ac71f))
	{
		vehicle thread [[vehicle.var_bc0ac71f]](self, eventstruct);
	}
}

/*
	Name: function_2aa4e6cf
	Namespace: namespace_964fbfb5
	Checksum: 0x8969FAB5
	Offset: 0x47C0
	Size: 0x4CC
	Parameters: 1
	Flags: Event
*/
event function_2aa4e6cf(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	vehicle = eventstruct.vehicle;
	seatindex = eventstruct.seat_index;
	var_6747c7b8 = eventstruct.var_21911287;
	if(!isinarray(level.var_9c103fe0, vehicle.scriptvehicletype))
	{
		return;
	}
	if(var_6747c7b8 === 0)
	{
		if(vehicle vehicle_ai::function_6664e3af() && vehicle function_e95a0595())
		{
			if(vehicle vehicle_ai::has_state("off"))
			{
				vehicle vehicle_ai::set_state("off");
			}
			else
			{
				vehicle turn_off();
			}
			if(isdefined(vehicle.var_ffdf490c) && vehicle.var_ffdf490c)
			{
				vehicle thread function_ffdf490c();
			}
			if(isdefined(vehicle.var_97f1b32a) && vehicle.var_97f1b32a)
			{
				vehicle.var_735382e = self;
				vehicle.var_a816f2cd = gettime();
			}
			if(isdefined(vehicle.var_4b0fd2dc) && vehicle.var_4b0fd2dc)
			{
				vehicle function_6a65d095();
			}
			vehicle notify(#"hash_2d45f3f009f1b3b3");
		}
	}
	else if(seatindex === 0)
	{
		if(vehicle vehicle_ai::function_329f45a4() && (!(isdefined(self.var_d271cf82) && self.var_d271cf82)))
		{
			if(vehicle vehicle_ai::has_state("landed") && vehicle vehicle_ai::get_current_state() === "off")
			{
				vehicle vehicle_ai::set_state("landed");
			}
			else if(vehicle vehicle_ai::has_state("recovery") && vehicle vehicle_ai::get_current_state() === "spiral")
			{
				vehicle vehicle_ai::set_state("recovery");
			}
			else if(vehicle vehicle_ai::has_state("driving"))
			{
				vehicle vehicle_ai::set_state("driving");
			}
			else
			{
				vehicle turn_on();
			}
			if(isdefined(vehicle.settings) && (isdefined(vehicle.settings.var_6754976b) && vehicle.settings.var_6754976b))
			{
				if(isdefined(vehicle.var_304cf9da) && vehicle.var_304cf9da)
				{
					vehicle vehicle::function_bbc1d940(1);
				}
				var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");
				if(isdefined(var_1861e0b1) && var_1861e0b1)
				{
					self clientfield::set_to_player("toggle_vehicle_sensor", 1);
				}
			}
		}
		else
		{
			vehicle takeplayercontrol();
		}
		namespace_d3564fd8::function_66fe9481(vehicle, self, seatindex);
		namespace_78a95918::function_66fe9481(vehicle, self, seatindex);
	}
	if(isdefined(vehicle.var_643db19d))
	{
		vehicle thread [[vehicle.var_643db19d]](self, eventstruct);
	}
	isemped = vehicle function_adc0649a();
	vehicle function_388973e4(isemped);
}

/*
	Name: function_2d7f6e48
	Namespace: namespace_964fbfb5
	Checksum: 0x67BA7A40
	Offset: 0x4C98
	Size: 0xBC
	Parameters: 1
	Flags: Event
*/
event function_2d7f6e48(eventstruct)
{
	if(!isplayer(self))
	{
		return;
	}
	if(isdefined(eventstruct.seat_index) && (eventstruct.seat_index >= 5 && eventstruct.seat_index <= 9))
	{
		if(eventstruct.var_e3e139f === 1)
		{
			self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 1);
		}
		else
		{
			self clientfield::set_player_uimodel("vehicle.vehicleAttackMode", 0);
		}
	}
}

/*
	Name: function_22d9386e
	Namespace: namespace_964fbfb5
	Checksum: 0xDC61560C
	Offset: 0x4D60
	Size: 0x15C
	Parameters: 1
	Flags: Event
*/
event function_22d9386e(eventstruct)
{
	occupants = self getvehoccupants();
	if(isdefined(occupants) && occupants.size)
	{
		for(i = 0; i < occupants.size; i++)
		{
			seat = self getoccupantseat(occupants[i]);
			if(isdefined(seat))
			{
				self usevehicle(occupants[i], seat);
			}
		}
	}
	self makevehicleunusable();
	waterheight = getwaterheight(self.origin, 100, -10000);
	if(waterheight != 131072 && self.origin[2] < waterheight)
	{
		self.health = 5;
	}
	else
	{
		self dodamage(self.health - 5, self.origin);
	}
}

/*
	Name: function_ef44d420
	Namespace: namespace_964fbfb5
	Checksum: 0x4A18712E
	Offset: 0x4EC8
	Size: 0x1B0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ef44d420(params)
{
	self vehicle::toggle_lights_group(1, !params.var_d8ceeba3);
	self vehicle::toggle_lights_group(2, !params.var_d8ceeba3);
	self vehicle::toggle_lights_group(3, !params.var_d8ceeba3);
	self vehicle::toggle_lights_group(4, params.var_d8ceeba3);
	occupants = self getvehoccupants();
	if(isdefined(occupants))
	{
		foreach(occupant in occupants)
		{
			if(!isplayer(occupant))
			{
				continue;
			}
			if(isdefined(occupant function_bee2bbc7()) && occupant function_bee2bbc7())
			{
				continue;
			}
			if(params.var_d8ceeba3)
			{
				occupant clientfield::set_to_player("toggle_vehicle_sensor", 1);
				continue;
			}
			occupant clientfield::set_to_player("toggle_vehicle_sensor", 0);
		}
	}
}

/*
	Name: function_f6bb77f1
	Namespace: namespace_964fbfb5
	Checksum: 0xFD97EF19
	Offset: 0x5080
	Size: 0x8C
	Parameters: 1
	Flags: Private
*/
private function function_f6bb77f1(params)
{
	driver = self getseatoccupant(0);
	if(isdefined(driver) && isplayer(driver))
	{
		if(params.var_d8ceeba3)
		{
			self function_ee42a973(driver);
		}
		else
		{
			self function_6a65d095();
		}
	}
}

/*
	Name: function_ffdf490c
	Namespace: namespace_964fbfb5
	Checksum: 0x77EFA055
	Offset: 0x5118
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ffdf490c()
{
	if(!isdefined(self) || self.health < 1)
	{
		return;
	}
	self endon(#"death");
	util::wait_network_frame();
	for(group = 1; group < 4; group++)
	{
		self vehicle::toggle_lights_group(group, 1);
	}
	self vehicle::toggle_force_driver_taillights(1);
}

/*
	Name: function_5bce3f3a
	Namespace: namespace_964fbfb5
	Checksum: 0x4900D098
	Offset: 0x51C8
	Size: 0x166
	Parameters: 3
	Flags: Linked
*/
function function_5bce3f3a(vehicle, seat_index, var_ddd294e3)
{
	self endon(#"death", #"disconnect", #"exit_vehicle", #"change_seat");
	vehicle endon(#"death");
	while(true)
	{
		var_e93c6f3a = vehicle getturretheatvalue(seat_index);
		var_62e4ee3 = var_e93c6f3a / 100;
		if(var_62e4ee3 < 0)
		{
			var_62e4ee3 = 0;
		}
		else if(var_62e4ee3 > 1)
		{
			var_62e4ee3 = 1;
		}
		var_24139930 = vehicle isvehicleturretoverheating(seat_index);
		if(var_24139930)
		{
			vehicle clientfield::set("overheat_fx", 1);
		}
		else
		{
			vehicle clientfield::set("overheat_fx", 0);
		}
		waitframe(1);
	}
}

/*
	Name: function_41cb03eb
	Namespace: namespace_964fbfb5
	Checksum: 0xE97EFB14
	Offset: 0x5338
	Size: 0xAA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_41cb03eb(seat_index)
{
	switch(seat_index)
	{
		case 0:
		{
			return "tag_turret";
		}
		case 1:
		{
			return "tag_gunner_turret1";
		}
		case 2:
		{
			return "tag_gunner_turret2";
		}
		case 3:
		{
			return "tag_gunner_turret3";
		}
		case 4:
		{
			return "tag_gunner_turret4";
		}
		default:
		{
			return undefined;
		}
	}
}

/*
	Name: function_58adb71c
	Namespace: namespace_964fbfb5
	Checksum: 0xF6B0581E
	Offset: 0x53F0
	Size: 0x25C
	Parameters: 3
	Flags: Linked
*/
function function_58adb71c(vehicle, seat_index, var_c269692d)
{
	self endon(#"death", #"disconnect", #"exit_vehicle", #"change_seat");
	vehicle endon(#"death");
	if(vehicle.var_96c0f900[seat_index] == 0)
	{
		vehicle disablegunnerfiring(seat_index - 1, 1);
		return;
	}
	while(true)
	{
		params = undefined;
		params = vehicle waittill(#"gunner_weapon_fired");
		if(params.gunner_index === seat_index)
		{
			vehicle.var_96c0f900[seat_index] = vehicle.var_96c0f900[seat_index] - var_c269692d;
			var_251a3d58 = function_41cb03eb(seat_index);
			if(isdefined(var_251a3d58))
			{
				damageparts = [];
				if(!isdefined(damageparts))
				{
					damageparts = [];
				}
				else if(!isarray(damageparts))
				{
					damageparts = array(damageparts);
				}
				damageparts[damageparts.size] = var_251a3d58;
				vehicle function_902cf00a(damageparts, int(var_c269692d));
			}
			if(vehicle.var_96c0f900[seat_index] < 0)
			{
				vehicle.var_96c0f900[seat_index] = 0;
			}
			if(vehicle.var_96c0f900[seat_index] == 0)
			{
				vehicle disablegunnerfiring(seat_index - 1, 1);
				break;
			}
		}
	}
}

/*
	Name: function_388973e4
	Namespace: namespace_964fbfb5
	Checksum: 0xEBC8D503
	Offset: 0x5658
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_388973e4(disable)
{
	self disabledriverfiring(disable);
	for(gunnerindex = 0; gunnerindex < 4; gunnerindex++)
	{
		self disablegunnerfiring(gunnerindex, disable);
	}
}

/*
	Name: function_6adf512b
	Namespace: namespace_964fbfb5
	Checksum: 0x219CE504
	Offset: 0x56C8
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_6adf512b()
{
	if(level.var_e5010085 vehicleturretoverheat::is_open(self))
	{
		level.var_e5010085 vehicleturretoverheat::close(self);
	}
	if(level.var_b5add14a vehicleturretdurability::is_open(self))
	{
		level.var_b5add14a vehicleturretdurability::close(self);
	}
}

/*
	Name: function_500291c4
	Namespace: namespace_964fbfb5
	Checksum: 0x63C7710E
	Offset: 0x5758
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_500291c4()
{
	self disabledriverfiring(1);
	self disablegunnerfiring(0, 1);
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
}

/*
	Name: function_bd3b5229
	Namespace: namespace_964fbfb5
	Checksum: 0x31402166
	Offset: 0x5808
	Size: 0x106
	Parameters: 0
	Flags: Linked, Private
*/
private function function_bd3b5229()
{
	self disabledriverfiring(1);
	self function_4c6bcfe2();
	self setmovingplatformenabled(1, 0);
	self.var_10206310 = &function_1d4618ca;
	self.var_ed2aaade = &function_c4c18caf;
	self.var_643db19d = &function_79f2b4cf;
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
	self.var_96c0f900 = [];
	self.var_96c0f900[1] = 1000;
}

/*
	Name: function_1d4618ca
	Namespace: namespace_964fbfb5
	Checksum: 0x2474FDEE
	Offset: 0x5918
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function function_1d4618ca(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, 1, 1000);
		player thread function_58adb71c(self, 1, 1);
	}
}

/*
	Name: function_c4c18caf
	Namespace: namespace_964fbfb5
	Checksum: 0xBF13E629
	Offset: 0x59A8
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function function_c4c18caf(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	self clientfield::set("overheat_fx", 0);
	player function_6adf512b();
}

/*
	Name: function_79f2b4cf
	Namespace: namespace_964fbfb5
	Checksum: 0x76ECDA6A
	Offset: 0x5A08
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function function_79f2b4cf(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, 1, 1000);
		player thread function_58adb71c(self, 1, 1);
	}
	else
	{
		self clientfield::set("overheat_fx", 0);
		player function_6adf512b();
	}
}

/*
	Name: function_8278ed00
	Namespace: namespace_964fbfb5
	Checksum: 0xD86A530F
	Offset: 0x5AD0
	Size: 0xBC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8278ed00()
{
	self disabledriverfiring(1);
	self setmovingplatformenabled(1, 0);
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
	self thread function_2ec624a6();
}

/*
	Name: function_2ec624a6
	Namespace: namespace_964fbfb5
	Checksum: 0xE3D39E72
	Offset: 0x5B98
	Size: 0xA0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2ec624a6()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"enter_vehicle");
		playfxontag("vehicle/fx8_exhaust_truck_cargo_startup_os", self, "tag_fx_exhaust");
		if(isdefined(waitresult.player))
		{
			waitresult.player playrumbleonentity("jet_rumble");
		}
	}
}

/*
	Name: function_8778ecd1
	Namespace: namespace_964fbfb5
	Checksum: 0xC3D98EFD
	Offset: 0x5C40
	Size: 0x84
	Parameters: 0
	Flags: Private
*/
private function function_8778ecd1()
{
	self disabledriverfiring(1);
	self setmovingplatformenabled(1, 0);
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
}

/*
	Name: function_5527f9ea
	Namespace: namespace_964fbfb5
	Checksum: 0x8295EAF6
	Offset: 0x5CD0
	Size: 0x6C
	Parameters: 0
	Flags: Private
*/
private function function_5527f9ea()
{
	self disabledriverfiring(1);
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
}

/*
	Name: function_79500af5
	Namespace: namespace_964fbfb5
	Checksum: 0xD708EFE0
	Offset: 0x5D48
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_79500af5()
{
	self setmovingplatformenabled(1, 0);
	self.var_10206310 = &function_1592c29e;
	self.var_ed2aaade = &function_67e1a636;
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
}

/*
	Name: function_1592c29e
	Namespace: namespace_964fbfb5
	Checksum: 0x1F3D2D61
	Offset: 0x5E08
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_1592c29e(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(eventstruct.vehicle))
	{
		return;
	}
	if(function_3238d10d(eventstruct.vehicle.origin))
	{
		playsoundatposition(#"hash_7a0942da55ff521d", eventstruct.vehicle.origin);
	}
	eventstruct.vehicle vehicle::toggle_control_bone_group(1, 1);
}

/*
	Name: function_67e1a636
	Namespace: namespace_964fbfb5
	Checksum: 0xD60300AF
	Offset: 0x5EC8
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function function_67e1a636(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(eventstruct.vehicle))
	{
		return;
	}
	if(!isalive(eventstruct.vehicle))
	{
		return;
	}
	occupants = eventstruct.vehicle getvehoccupants();
	if(!isdefined(occupants) || occupants.size == 0)
	{
		if(function_3238d10d(eventstruct.vehicle.origin))
		{
			playsoundatposition(#"hash_7a0942da55ff521d", eventstruct.vehicle.origin);
		}
		eventstruct.vehicle vehicle::toggle_control_bone_group(1, 0);
	}
}

/*
	Name: function_fb9c790a
	Namespace: namespace_964fbfb5
	Checksum: 0x2A4E47AF
	Offset: 0x5FE0
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_fb9c790a()
{
	self setmovingplatformenabled(1, 0);
	self function_4c6bcfe2();
	self.var_10206310 = &function_b0a62896;
	self.var_643db19d = &function_d949f006;
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
}

/*
	Name: function_b0a62896
	Namespace: namespace_964fbfb5
	Checksum: 0x6AD771DC
	Offset: 0x60A0
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b0a62896(player, eventstruct)
{
	self function_da0c353b(player, eventstruct);
}

/*
	Name: function_d949f006
	Namespace: namespace_964fbfb5
	Checksum: 0x35A7A028
	Offset: 0x60D8
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d949f006(player, eventstruct)
{
	self function_da0c353b(player, eventstruct);
}

/*
	Name: function_da0c353b
	Namespace: namespace_964fbfb5
	Checksum: 0x9942D387
	Offset: 0x6110
	Size: 0x132
	Parameters: 2
	Flags: Linked, Private
*/
private function function_da0c353b(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(!isalive(self))
	{
		return;
	}
	if(eventstruct.seat_index === 0)
	{
		if((isdefined(getgametypesetting(#"hash_7695bdd7b20cdda")) ? getgametypesetting(#"hash_7695bdd7b20cdda") : 0))
		{
			if(isdefined(self.var_8d120ff) && self.var_8d120ff)
			{
				return;
			}
			var_40e2a4c8 = getcharacterassetname(player getcharacterbodytype(), currentsessionmode());
			if(var_40e2a4c8 !== #"hash_15db91b18278dea9")
			{
				return;
			}
			self thread function_782a6e87();
			self.var_8d120ff = 1;
		}
	}
}

/*
	Name: function_782a6e87
	Namespace: namespace_964fbfb5
	Checksum: 0x918A0CBB
	Offset: 0x6250
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_782a6e87()
{
	self endon(#"death");
	oldhealth = self.health;
	self setvehicletype("veh_muscle_car_convertible_player_wz_replacer");
	util::wait_network_frame();
	self function_41b29ff0(#"hash_896eebec81ec647");
	util::wait_network_frame();
	damage = self.healthdefault - oldhealth;
	if(damage > 0)
	{
		self dodamage(damage, self.origin);
	}
}

/*
	Name: function_c0f1d81b
	Namespace: namespace_964fbfb5
	Checksum: 0xE0975AC5
	Offset: 0x6320
	Size: 0x102
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c0f1d81b()
{
	self function_4c6bcfe2();
	self setmovingplatformenabled(1, 0);
	self callback::function_d8abfc3d(#"on_vehicle_killed", &function_4366bf50);
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
	self.var_10206310 = &function_96f5d31b;
	self.var_ed2aaade = &function_cd8db309;
	self.var_f81da9d6 = &function_b8458486;
}

/*
	Name: function_4366bf50
	Namespace: namespace_964fbfb5
	Checksum: 0xB70B3915
	Offset: 0x6430
	Size: 0x1A4
	Parameters: 1
	Flags: Linked
*/
function function_4366bf50(params)
{
	deathmodel = spawn("script_model", self.origin + vectorscale((0, 0, 1), 150));
	deathmodel setmodel(#"hash_4c315b7f2185c393");
	deathmodel.angles = self.angles;
	if(!isdefined(level.var_82eb1dab))
	{
		level.var_82eb1dab = [];
	}
	if(!isdefined(level.var_82eb1dab))
	{
		level.var_82eb1dab = [];
	}
	else if(!isarray(level.var_82eb1dab))
	{
		level.var_82eb1dab = array(level.var_82eb1dab);
	}
	level.var_82eb1dab[level.var_82eb1dab.size] = deathmodel;
	var_b65967e = randomintrange(-10, 10);
	var_9a1e332d = randomintrange(15, 25);
	deathmodel physicslaunch((0, var_b65967e, 0), (0, 0, var_9a1e332d));
	deathmodel clientfield::set("tank_deathfx", 1);
}

/*
	Name: function_96f5d31b
	Namespace: namespace_964fbfb5
	Checksum: 0xE511F5A1
	Offset: 0x65E0
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function function_96f5d31b(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		self function_11397df9(player);
	}
	self thread function_2014e301(player);
}

/*
	Name: function_cd8db309
	Namespace: namespace_964fbfb5
	Checksum: 0x6964AB5E
	Offset: 0x6640
	Size: 0x3C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_cd8db309(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		self function_eba4498a(player);
	}
}

/*
	Name: function_b8458486
	Namespace: namespace_964fbfb5
	Checksum: 0x68A631E1
	Offset: 0x6688
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b8458486(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		self function_11397df9(player);
	}
	else
	{
		self function_eba4498a(player);
	}
}

/*
	Name: function_2014e301
	Namespace: namespace_964fbfb5
	Checksum: 0xA3835970
	Offset: 0x66E8
	Size: 0x120
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2014e301(player)
{
	player endon(#"hash_27646c99772610b4", #"exit_vehicle", #"disconnect", #"death", #"game_ended");
	self endon(#"death");
	while(true)
	{
		self waittill(#"weapon_fired");
		var_3212abd9 = self seatgetweapon(0);
		var_610cfafc = int(var_3212abd9.reloadtime * 1000);
		player setvehicleweaponwaitduration(var_610cfafc);
		player setvehicleweaponwaitendtime(gettime() + var_610cfafc);
	}
}

/*
	Name: function_11397df9
	Namespace: namespace_964fbfb5
	Checksum: 0x30432C2D
	Offset: 0x6810
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_11397df9(player)
{
	if(!isdefined(self.var_9be5a571))
	{
		self.var_9be5a571 = [];
	}
	self.overridevehicledamage = &function_eed77231;
	player.overrideplayerdamage = &function_7daf5af2;
	self thread function_53f7a11f(player);
}

/*
	Name: function_eba4498a
	Namespace: namespace_964fbfb5
	Checksum: 0xEB068B6A
	Offset: 0x6888
	Size: 0x38
	Parameters: 1
	Flags: Linked
*/
function function_eba4498a(player)
{
	self.overridevehicledamage = undefined;
	player.overrideplayerdamage = undefined;
	player notify(#"hash_27646c99772610b4");
}

/*
	Name: function_eed77231
	Namespace: namespace_964fbfb5
	Checksum: 0x8153CD76
	Offset: 0x68C8
	Size: 0xE4
	Parameters: 15
	Flags: Linked, Private
*/
private function function_eed77231(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	damage = idamage;
	if(isdefined(eattacker) && eattacker.scriptvehicletype === "player_tank" && isvehicle(einflictor) && smeansofdeath === "MOD_EXPLOSIVE")
	{
		damage = 0;
	}
	return damage;
}

/*
	Name: function_7daf5af2
	Namespace: namespace_964fbfb5
	Checksum: 0x73CDC4B5
	Offset: 0x69B8
	Size: 0x108
	Parameters: 15
	Flags: Linked, Private
*/
private function function_7daf5af2(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	damage = idamage;
	vehicle = self getvehicleoccupied();
	if(!isvehicle(vehicle) || !isalive(vehicle))
	{
		return damage;
	}
	if(smeansofdeath === "MOD_DEATH_CIRCLE")
	{
		return damage;
	}
	damage = 0;
	return damage;
}

/*
	Name: function_cb575bc3
	Namespace: namespace_964fbfb5
	Checksum: 0xDB451BE6
	Offset: 0x6AC8
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cb575bc3()
{
	self disabledriverfiring(1);
	self disablegunnerfiring(0, 1);
	self function_4c6bcfe2();
	self function_7ae07b7();
	self callback::function_36aab2f3(&function_36aab2f3);
	self.var_bc0ac71f = &function_dde4cb6e;
	self.var_10206310 = &function_d0a9a026;
	self.var_ed2aaade = &function_e1f72671;
	self.var_643db19d = &function_a73c417;
	self.disconnectpathdetail = 0;
	self function_d733412a(1);
}

/*
	Name: function_66eae288
	Namespace: namespace_964fbfb5
	Checksum: 0xB27C5F53
	Offset: 0x6BD8
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_66eae288(player)
{
	if(isalive(self))
	{
		self showpart("tag_handlebars", "", 1);
	}
}

/*
	Name: function_9157fb4f
	Namespace: namespace_964fbfb5
	Checksum: 0xD537D964
	Offset: 0x6C30
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9157fb4f(player)
{
	if(isalive(self))
	{
		self hidepart("tag_handlebars", "", 1);
	}
}

/*
	Name: function_e1f72671
	Namespace: namespace_964fbfb5
	Checksum: 0xDF61B17F
	Offset: 0x6C88
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e1f72671(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		eventstruct.vehicle vehicle::toggle_control_bone_group(1, 0);
		self function_66eae288(player);
	}
}

/*
	Name: function_a73c417
	Namespace: namespace_964fbfb5
	Checksum: 0x1038BCC1
	Offset: 0x6CF8
	Size: 0xA4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a73c417(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		eventstruct.vehicle vehicle::toggle_control_bone_group(1, 1);
		self function_9157fb4f(player);
	}
	else
	{
		eventstruct.vehicle vehicle::toggle_control_bone_group(1, 0);
		self function_66eae288(player);
	}
}

/*
	Name: function_d0a9a026
	Namespace: namespace_964fbfb5
	Checksum: 0xC4E6E9F3
	Offset: 0x6DA8
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d0a9a026(player, eventstruct)
{
	if(eventstruct.seat_index === 0)
	{
		eventstruct.vehicle vehicle::toggle_control_bone_group(1, 1);
		self function_9157fb4f(player);
	}
}

/*
	Name: function_dde4cb6e
	Namespace: namespace_964fbfb5
	Checksum: 0x64D6F6A4
	Offset: 0x6E18
	Size: 0x44
	Parameters: 2
	Flags: Linked, Private
*/
private function function_dde4cb6e(player, eventstruct)
{
	self function_66eae288(player);
	self function_9157fb4f(player);
}

/*
	Name: function_6b617752
	Namespace: namespace_964fbfb5
	Checksum: 0x6AD28D69
	Offset: 0x6E68
	Size: 0xAE
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6b617752()
{
	self function_4c6bcfe2();
	self disabledriverfiring(1);
	self setmovingplatformenabled(1, 0);
	self.var_10206310 = &function_a5838bb7;
	self.var_ed2aaade = &function_6d4de854;
	self.var_bc0ac71f = &function_a41bd019;
	self function_7ae07b7();
	self.var_ffdf490c = undefined;
}

/*
	Name: function_c0c61ba1
	Namespace: namespace_964fbfb5
	Checksum: 0x1C7CE8B5
	Offset: 0x6F20
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c0c61ba1(player)
{
	if(isalive(self))
	{
		self showpart("tag_motor_steer_animate", "", 1);
	}
	player detach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
}

/*
	Name: function_e81bb047
	Namespace: namespace_964fbfb5
	Checksum: 0xDCAB03B9
	Offset: 0x6FA0
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e81bb047(player)
{
	player attach("veh_t8_mil_boat_tactical_raft_outboard_motor_attach", "TAG_WEAPON_LEFT");
	if(isalive(self))
	{
		self hidepart("tag_motor_steer_animate", "", 1);
	}
}

/*
	Name: function_6d4de854
	Namespace: namespace_964fbfb5
	Checksum: 0xAEE4986C
	Offset: 0x7020
	Size: 0x2C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_6d4de854(player, eventstruct)
{
	self function_c0c61ba1(player);
}

/*
	Name: function_a5838bb7
	Namespace: namespace_964fbfb5
	Checksum: 0x80FF2DE2
	Offset: 0x7058
	Size: 0x44
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a5838bb7(player, eventstruct)
{
	self function_e81bb047(player);
	self thread function_e8e41bbb();
}

/*
	Name: function_a41bd019
	Namespace: namespace_964fbfb5
	Checksum: 0x6753B52E
	Offset: 0x70A8
	Size: 0x44
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a41bd019(player, eventstruct)
{
	self function_c0c61ba1(player);
	self function_e81bb047(player);
}

/*
	Name: function_17949e01
	Namespace: namespace_964fbfb5
	Checksum: 0x799133A2
	Offset: 0x70F8
	Size: 0x20A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_17949e01()
{
	self notify("3372ab565790b66e");
	self endon("3372ab565790b66e");
	self endon(#"death");
	mag = getdvarfloat(#"hash_2612e4b1db15d42e", 150);
	height = getdvarfloat(#"hash_57e0d780126c4f57", 100);
	var_80831eb5 = 0;
	while(true)
	{
		self waittill(#"beached");
		while(true)
		{
			waitresult = undefined;
			waitresult = self waittill(#"touch", #"hash_5dd07f78cd8cd3b8");
			if(waitresult._notify == #"touch" && isdefined(waitresult.var_6fc50c7c))
			{
				time = gettime();
				if(time > var_80831eb5 && waitresult.var_6fc50c7c & 128)
				{
					force = anglestoforward(waitresult.entity getplayerangles());
					force = force * mag;
					force = force + (0, 0, height);
					self launchvehicle(force, self.origin);
					var_80831eb5 = time + 1500;
				}
			}
			else if(!self function_7548ecb2())
			{
				break;
			}
		}
	}
}

/*
	Name: deletemeonnotify
	Namespace: namespace_964fbfb5
	Checksum: 0x1D068F01
	Offset: 0x7310
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function deletemeonnotify(enttowatch, note)
{
	self endon(#"death");
	if(!isdefined(enttowatch))
	{
		return;
	}
	enttowatch waittill(note);
	self delete();
}

/*
	Name: function_e8e41bbb
	Namespace: namespace_964fbfb5
	Checksum: 0xEF0949ED
	Offset: 0x7370
	Size: 0x396
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e8e41bbb()
{
	self notify("356ff15b8c3dad3d");
	self endon("356ff15b8c3dad3d");
	self endon(#"death");
	self.var_221879dc = 0;
	if(isdefined(self.settings) && (isdefined(self.settings.var_95ebe8e0) && self.settings.var_95ebe8e0))
	{
		self thread function_17949e01();
	}
	fxorg = undefined;
	while(true)
	{
		speed = length(self getvelocity());
		if(self function_7548ecb2() && speed < 5)
		{
			if(!self.var_221879dc)
			{
				driver = self getseatoccupant(0);
				if(isplayer(driver))
				{
					self usevehicle(driver, 0);
				}
				if(isdefined(self.settings))
				{
					if(isdefined(self.settings.var_b5c8e89a) && isdefined(self.settings.var_95861ca4))
					{
						if(isdefined(fxorg))
						{
							fxorg delete();
						}
						fxorg = spawn("script_model", self gettagorigin(self.settings.var_95861ca4));
						fxorg.targetname = "vehicle_beach_fx";
						if(isdefined(fxorg))
						{
							fxorg setmodel(#"tag_origin");
							fxorg enablelinkto();
							fxorg linkto(self, self.settings.var_95861ca4, (0, 0, 0), (0, 0, 0));
							playfxontag(self.settings.var_b5c8e89a, fxorg, "tag_origin");
							fxorg thread deletemeonnotify(self, "death");
						}
					}
					if(isdefined(self.settings.var_a8fa65d7))
					{
						self playsound(self.settings.var_a8fa65d7);
					}
				}
				self.var_221879dc = 1;
				self notify(#"beached");
			}
		}
		else if(self.var_221879dc && !self function_7548ecb2())
		{
			self.var_221879dc = 0;
			if(isdefined(fxorg))
			{
				fxorg delete();
			}
			self notify(#"hash_5dd07f78cd8cd3b8");
			wait(5);
		}
		waitframe(1);
	}
}

/*
	Name: function_cc0af45d
	Namespace: namespace_964fbfb5
	Checksum: 0xBA1F7DB6
	Offset: 0x7710
	Size: 0xC6
	Parameters: 0
	Flags: Linked, Private
*/
private function function_cc0af45d()
{
	self function_4c6bcfe2();
	self disabledriverfiring(1);
	self setmovingplatformenabled(1, 0);
	self.var_10206310 = &function_b65217f6;
	self.var_ed2aaade = &function_674b9c5b;
	self.var_643db19d = &function_f2626e5f;
	self function_7ae07b7();
	self.var_96c0f900 = [];
	self.var_96c0f900[1] = 1000;
}

/*
	Name: function_b65217f6
	Namespace: namespace_964fbfb5
	Checksum: 0x34464824
	Offset: 0x77E0
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_b65217f6(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, 1, 1000);
		player thread function_58adb71c(self, 1, 1);
	}
	self thread function_e8e41bbb();
}

/*
	Name: function_674b9c5b
	Namespace: namespace_964fbfb5
	Checksum: 0x8D6A09E9
	Offset: 0x7888
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function function_674b9c5b(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	player function_6adf512b();
}

/*
	Name: function_f2626e5f
	Namespace: namespace_964fbfb5
	Checksum: 0x7D39E8D6
	Offset: 0x78C8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_f2626e5f(player, eventstruct)
{
	if(!isdefined(player))
	{
		return;
	}
	if(eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, 1, 1000);
		player thread function_58adb71c(self, 1, 1);
	}
	else
	{
		player function_6adf512b();
	}
}

/*
	Name: function_b1d54776
	Namespace: namespace_964fbfb5
	Checksum: 0xACD3BC39
	Offset: 0x7970
	Size: 0x4A2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b1d54776()
{
	self disabledriverfiring(1);
	self.death_type = "gibbed";
	self.var_18a9fdc = &function_32607cfc;
	self function_4c6bcfe2(1);
	self.var_96c0f900[2] = 1000;
	self.var_96c0f900[1] = 1000;
	if(!isdefined(self) || function_3132f113(self))
	{
		return;
	}
	self.var_643db19d = &function_d7bcab1f;
	self.var_10206310 = &function_5520bbcc;
	self.var_ed2aaade = &function_564c9e78;
	self vehicle_ai::get_state_callbacks("off").enter_func = &function_92270eeb;
	self vehicle_ai::get_state_callbacks("off").exit_func = &function_365e033d;
	self vehicle_ai::get_state_callbacks("death").update_func = &function_4b5646b1;
	self vehicle_ai::add_state("spiral", &function_1f014f43, &function_2e3fb54c, &function_aaa84ac);
	self vehicle_ai::add_state("recovery", &function_d344c3f, &function_e291246d, &function_ad15f5e8);
	self vehicle_ai::add_state("water_landing", &function_976267bc, &function_eadfd579, &function_e13c4d09);
	self vehicle_ai::add_state("landing", &function_200c3bd0, &function_3a7426cf, &function_3b1d3bf1);
	self vehicle_ai::add_state("landed", &function_d39845f, &function_b705c816, &function_7db28345);
	self vehicle_ai::function_b94a7666("driving", "exit_vehicle");
	self vehicle_ai::function_b94a7666("off", "enter_vehicle");
	self vehicle_ai::add_interrupt_connection("landing", "driving", "enter_vehicle", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("off", "landed", "enter_vehicle", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("off", "landed", "heli_emp_done", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("landed", "off", "exit_vehicle", &function_a1fd6110);
	self function_7ae07b7();
	self thread function_b0dd571a();
	self thread function_638d1ade();
	self callback::function_36aab2f3(&function_4885ce1);
	self.is_staircase_up = &function_4e74bed7;
}

/*
	Name: function_8fb65b2a
	Namespace: namespace_964fbfb5
	Checksum: 0xAE664F24
	Offset: 0x7E20
	Size: 0x492
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8fb65b2a()
{
	self.death_type = "gibbed";
	self.var_18a9fdc = &function_32607cfc;
	self.var_96c0f900 = [];
	self.var_96c0f900[1] = 1000;
	self.var_96c0f900[2] = 1000;
	self function_4c6bcfe2(1);
	if(!isdefined(self) || function_3132f113(self))
	{
		return;
	}
	self.var_643db19d = &function_e2d16bde;
	self.var_10206310 = &function_1b957284;
	self.var_ed2aaade = &function_a7401191;
	self vehicle_ai::get_state_callbacks("off").enter_func = &function_92270eeb;
	self vehicle_ai::get_state_callbacks("off").exit_func = &function_365e033d;
	self vehicle_ai::get_state_callbacks("death").update_func = &function_4b5646b1;
	self vehicle_ai::add_state("spiral", &function_1f014f43, &function_2e3fb54c, &function_aaa84ac);
	self vehicle_ai::add_state("recovery", &function_d344c3f, &function_e291246d, &function_ad15f5e8);
	self vehicle_ai::add_state("water_landing", &function_976267bc, &function_eadfd579, &function_e13c4d09);
	self vehicle_ai::add_state("landing", &function_200c3bd0, &function_3a7426cf, &function_3b1d3bf1);
	self vehicle_ai::add_state("landed", &function_d39845f, &function_b705c816, &function_7db28345);
	self vehicle_ai::function_b94a7666("driving", "exit_vehicle");
	self vehicle_ai::function_b94a7666("off", "enter_vehicle");
	self vehicle_ai::add_interrupt_connection("landing", "driving", "enter_vehicle", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("off", "landed", "enter_vehicle", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("off", "landed", "heli_emp_done", &vehicle_ai::function_329f45a4);
	self vehicle_ai::add_interrupt_connection("landed", "off", "exit_vehicle", &function_a1fd6110);
	self function_7ae07b7();
	self thread function_b0dd571a();
	self thread function_638d1ade();
	self callback::function_36aab2f3(&function_4885ce1);
	self.is_staircase_up = &function_4e74bed7;
}

/*
	Name: function_a1fd6110
	Namespace: namespace_964fbfb5
	Checksum: 0x4A6AA329
	Offset: 0x82C0
	Size: 0x44
	Parameters: 4
	Flags: Linked, Private
*/
private function function_a1fd6110(current_state, to_state, connection, params)
{
	return !vehicle_ai::function_329f45a4(current_state, to_state, connection, params);
}

/*
	Name: function_b0dd571a
	Namespace: namespace_964fbfb5
	Checksum: 0x1C8AF075
	Offset: 0x8310
	Size: 0x1BA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b0dd571a()
{
	self endon(#"death");
	self waittill(#"enter_vehicle");
	offset = getdvarint(#"hash_626d3139a5fd29ca", -70);
	while(true)
	{
		waterheight = getwaterheight(self.origin, 100, -10000);
		if(waterheight != 131072)
		{
			var_19dbcac7 = (self.origin[2] + offset) - waterheight;
			if(var_19dbcac7 <= 0)
			{
				if(self getspeedmph() > 40)
				{
					self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
				}
				else
				{
					self vehicle_ai::set_state("water_landing");
				}
			}
			if(var_19dbcac7 < 1000)
			{
				wait(0.25);
			}
			else if(var_19dbcac7 < 2000)
			{
				wait(1);
			}
			else
			{
				time = math::clamp(int(var_19dbcac7 / 1000), 1, 5);
				wait(time);
			}
		}
		else
		{
			wait(2);
		}
	}
}

/*
	Name: function_638d1ade
	Namespace: namespace_964fbfb5
	Checksum: 0x9CFC8D9C
	Offset: 0x84D8
	Size: 0x264
	Parameters: 0
	Flags: Linked, Private
*/
private function function_638d1ade()
{
	self endon(#"death", #"hash_41dbbf5434aab9e0");
	while(true)
	{
		if(isdefined(level.deathcircle) && isdefined(level.var_52b56362))
		{
			radius = level.deathcircle.radius;
			var_b4ed4ca = distance2dsquared(self.origin, level.deathcircle.origin) - (radius * radius);
			if(var_b4ed4ca > 0 || radius <= 4298)
			{
				if(radius <= 4298)
				{
					self.var_1ba362d5 = 1;
					state = self vehicle_ai::get_current_state();
					if(state === "off" || state === "landed")
					{
						self function_41a269b3();
					}
				}
				if(!isdefined(self.var_8382289e))
				{
					self function_b8c2b27d();
				}
			}
			else if(isdefined(self.origin[2]) && self.origin[2] >= 12000)
			{
				self.var_1ba362d5 = 1;
				state = self vehicle_ai::get_current_state();
				if(state === "off" || state === "landed")
				{
					self function_41a269b3();
				}
				if(!isdefined(self.var_8382289e))
				{
					self function_b8c2b27d();
				}
			}
			else if(isdefined(self.var_8382289e) && (!(isdefined(self.var_1ba362d5) && self.var_1ba362d5)))
			{
				self function_f11207a9();
			}
			wait(0.1);
			continue;
		}
		wait(1);
	}
}

/*
	Name: function_b8c2b27d
	Namespace: namespace_964fbfb5
	Checksum: 0xC23E35B1
	Offset: 0x8748
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b8c2b27d()
{
	self function_56ee2902(1);
	self clientfield::set("update_malfunction", 1);
	self clientfield::set("flickerlights", 2);
	self.var_8382289e = gettime();
	self thread function_f46dd7b0();
}

/*
	Name: function_f11207a9
	Namespace: namespace_964fbfb5
	Checksum: 0xE147030E
	Offset: 0x87D0
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f11207a9()
{
	self endon(#"death");
	self.var_8382289e = undefined;
	self notify(#"hash_3a531082a005f542");
	self function_260f32b3(1);
}

/*
	Name: function_dae7aaf3
	Namespace: namespace_964fbfb5
	Checksum: 0x990EF6F0
	Offset: 0x8828
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_dae7aaf3()
{
	self takeplayercontrol();
	self clientfield::set("update_malfunction", 2);
	self thread function_82224f4b(1600);
	self setrotorspeed(0.7);
	if(self vehicle_ai::get_current_state() === "landed")
	{
		self.var_b3e4af16 = 1;
	}
	self clientfield::set("flickerlights", 3);
	self function_a98ae5fe();
	self function_56ee2902(2);
}

/*
	Name: function_260f32b3
	Namespace: namespace_964fbfb5
	Checksum: 0xBCEAF0C5
	Offset: 0x8930
	Size: 0x1B4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_260f32b3(exit = 0)
{
	self notify(#"hash_5945cb8f37c085c0");
	if(!(isdefined(self.emped) && self.emped) && (!(isdefined(self.jammed) && self.jammed)))
	{
		if(self vehicle_ai::get_current_state() === "landed")
		{
			self.var_b3e4af16 = undefined;
		}
		else
		{
			self returnplayercontrol();
		}
		if(self vehicle_ai::function_329f45a4())
		{
			self setrotorspeed(1);
		}
	}
	if(exit)
	{
		self function_56ee2902(0);
		self clientfield::set("update_malfunction", 0);
		self clientfield::set("flickerlights", 3);
		self function_2418736c();
		return;
	}
	self function_56ee2902(1);
	self clientfield::set("update_malfunction", 1);
	self clientfield::set("flickerlights", 2);
}

/*
	Name: function_8bb6a990
	Namespace: namespace_964fbfb5
	Checksum: 0x1BB65760
	Offset: 0x8AF0
	Size: 0x120
	Parameters: 0
	Flags: Linked, Private
*/
private function function_8bb6a990()
{
	self endon(#"death", #"hash_3a531082a005f542", #"hash_3c7ae83e462fe4e2", #"hash_3c9653d2ffd49352", #"hash_41dbbf5434aab9e0");
	wait(5);
	self clientfield::set("flickerlights", 2);
	while(true)
	{
		self function_dae7aaf3();
		wait(randomfloatrange(1, 3));
		self function_260f32b3();
		self clientfield::set("flickerlights", 2);
		wait(randomfloatrange(3, 10));
	}
}

/*
	Name: function_f46dd7b0
	Namespace: namespace_964fbfb5
	Checksum: 0xADC9D9F1
	Offset: 0x8C18
	Size: 0x21C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f46dd7b0()
{
	self notify("7568179a9adfe70f");
	self endon("7568179a9adfe70f");
	self endon(#"death", #"hash_3a531082a005f542", #"hash_41dbbf5434aab9e0");
	if(vehicle_ai::function_329f45a4())
	{
		self thread function_8bb6a990();
	}
	else
	{
		self waittill(#"hash_172a4ff3d058a0cc");
	}
	shutdowntime = gettime() + 30000;
	while(true)
	{
		if(gettime() < shutdowntime)
		{
			wait(0.5);
		}
		else
		{
			self function_a98ae5fe();
			state = self vehicle_ai::get_current_state();
			if(state === "off")
			{
				self function_41a269b3();
			}
			else if(state === "landed")
			{
				params = spawnstruct();
				params.makeunusable = 1;
				self vehicle_ai::set_state("off", params);
			}
			else
			{
				self.var_4e76046a = 1;
				self.var_d271cf82 = 1;
				self function_56ee2902(2);
				params = spawnstruct();
				params.var_52c5850b = 60;
				self vehicle_ai::set_state("spiral", params);
			}
			self notify(#"hash_41dbbf5434aab9e0");
			return;
		}
	}
}

/*
	Name: function_56ee2902
	Namespace: namespace_964fbfb5
	Checksum: 0x59CC227E
	Offset: 0x8E40
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_56ee2902(state)
{
	foreach(occupant in self getvehoccupants())
	{
		if(!isplayer(occupant))
		{
			continue;
		}
		occupant clientfield::set_player_uimodel("vehicle.malfunction", state);
	}
}

/*
	Name: function_82224f4b
	Namespace: namespace_964fbfb5
	Checksum: 0x4EDFF30B
	Offset: 0x8F00
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_82224f4b(scale)
{
	self notify("43958cae29e09bf1");
	self endon("43958cae29e09bf1");
	self endon(#"death", #"hash_3a531082a005f542", #"hash_5945cb8f37c085c0", #"hash_41dbbf5434aab9e0");
	while(true)
	{
		accel = anglestoup(self.angles) * scale;
		self setphysacceleration((accel[0], accel[1], -200));
		waitframe(1);
	}
}

/*
	Name: function_2418736c
	Namespace: namespace_964fbfb5
	Checksum: 0x630108AF
	Offset: 0x8FE0
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2418736c()
{
	groups = 3;
	if(self vehicle_ai::function_329f45a4())
	{
		groups = 4;
	}
	for(group = 1; group <= groups; group++)
	{
		self vehicle::toggle_lights_group(group, 1);
	}
}

/*
	Name: function_a98ae5fe
	Namespace: namespace_964fbfb5
	Checksum: 0x5822E6A4
	Offset: 0x9068
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a98ae5fe()
{
	self clientfield::set("flickerlights", 3);
	for(group = 1; group <= 4; group++)
	{
		self vehicle::toggle_lights_group(group, 0);
	}
}

/*
	Name: function_2ba6be18
	Namespace: namespace_964fbfb5
	Checksum: 0xE5257C2D
	Offset: 0x90D8
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2ba6be18(player, eventstruct)
{
	seatindex = eventstruct.seat_index;
	if(seatindex === 0)
	{
		self function_b985a0f1(player);
	}
	if(isdefined(self.var_8382289e))
	{
		self function_56ee2902(1);
	}
	player setsunshadowsplitdistance(6000);
}

/*
	Name: function_3af01392
	Namespace: namespace_964fbfb5
	Checksum: 0xBB82E73D
	Offset: 0x9170
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_3af01392(player, eventstruct)
{
	seatindex = eventstruct.seat_index;
	var_6747c7b8 = eventstruct.var_21911287;
	if(var_6747c7b8 === 0)
	{
		self function_2205f6bf(player);
	}
	else if(seatindex === 0)
	{
		self function_b985a0f1(player);
	}
}

/*
	Name: function_ff490dad
	Namespace: namespace_964fbfb5
	Checksum: 0xF7D92986
	Offset: 0x9208
	Size: 0x84
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ff490dad(player, eventstruct)
{
	seatindex = eventstruct.seat_index;
	if(seatindex === 0)
	{
		self function_2205f6bf(player);
	}
	player clientfield::set_player_uimodel("vehicle.malfunction", 0);
	player setsunshadowsplitdistance(0);
}

/*
	Name: function_b985a0f1
	Namespace: namespace_964fbfb5
	Checksum: 0xC327BF6F
	Offset: 0x9298
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b985a0f1(player)
{
	self notify(#"hash_172a4ff3d058a0cc");
	self setheliheightcap(1);
	if(isdefined(self.var_8382289e))
	{
		self thread function_8bb6a990();
	}
	self thread function_ab36338c(player);
}

/*
	Name: function_2205f6bf
	Namespace: namespace_964fbfb5
	Checksum: 0x598FDFDB
	Offset: 0x9310
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2205f6bf(player)
{
	state = self vehicle_ai::get_current_state();
	self notify(#"hash_3c7ae83e462fe4e2");
	self notify(#"hash_3c9653d2ffd49352");
	if(state === "landed" || state === "off")
	{
		return;
	}
	if(state === "spiral")
	{
		self.var_4e76046a = 1;
	}
	else
	{
		self function_d929b41();
	}
}

/*
	Name: function_5520bbcc
	Namespace: namespace_964fbfb5
	Checksum: 0x7513F531
	Offset: 0x93C8
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_5520bbcc(player, eventstruct)
{
	self function_2ba6be18(player, eventstruct);
	if(eventstruct.seat_index === 2 || eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, eventstruct.seat_index, 1000);
		player thread function_58adb71c(self, eventstruct.seat_index, 1);
	}
}

/*
	Name: function_564c9e78
	Namespace: namespace_964fbfb5
	Checksum: 0x9135D826
	Offset: 0x9488
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function function_564c9e78(player, eventstruct)
{
	self function_ff490dad(player, eventstruct);
	player function_6adf512b();
}

/*
	Name: function_d7bcab1f
	Namespace: namespace_964fbfb5
	Checksum: 0x420A382B
	Offset: 0x94D8
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_d7bcab1f(player, eventstruct)
{
	self function_3af01392(player, eventstruct);
	if(eventstruct.seat_index === 2 || eventstruct.seat_index === 1)
	{
		player thread function_5bce3f3a(self, eventstruct.seat_index, 1000);
		player thread function_58adb71c(self, eventstruct.seat_index, 1);
	}
	else
	{
		player function_6adf512b();
	}
}

/*
	Name: function_1b957284
	Namespace: namespace_964fbfb5
	Checksum: 0x57EB2772
	Offset: 0x95B0
	Size: 0xB4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1b957284(player, eventstruct)
{
	self function_2ba6be18(player, eventstruct);
	if(eventstruct.seat_index === 1 || eventstruct.seat_index === 2)
	{
		player thread function_5bce3f3a(self, eventstruct.seat_index, 1000);
		player thread function_58adb71c(self, eventstruct.seat_index, 1);
	}
}

/*
	Name: function_a7401191
	Namespace: namespace_964fbfb5
	Checksum: 0x7F869B7E
	Offset: 0x9670
	Size: 0x44
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a7401191(player, eventstruct)
{
	self function_ff490dad(player, eventstruct);
	player function_6adf512b();
}

/*
	Name: function_e2d16bde
	Namespace: namespace_964fbfb5
	Checksum: 0x460B0B08
	Offset: 0x96C0
	Size: 0xCC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e2d16bde(player, eventstruct)
{
	self function_3af01392(player, eventstruct);
	if(eventstruct.seat_index === 1 || eventstruct.seat_index === 2)
	{
		player thread function_5bce3f3a(self, eventstruct.seat_index, 1000);
		player thread function_58adb71c(self, eventstruct.seat_index, 1);
	}
	else
	{
		player function_6adf512b();
	}
}

/*
	Name: function_ab36338c
	Namespace: namespace_964fbfb5
	Checksum: 0x95F2B2C5
	Offset: 0x9798
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ab36338c(player)
{
	self endon(#"death");
	player endon(#"exit_vehicle", #"change_seat");
	player waittill(#"disconnect");
	self function_2205f6bf(player);
}

/*
	Name: function_6c8cff7e
	Namespace: namespace_964fbfb5
	Checksum: 0x39E3E501
	Offset: 0x9818
	Size: 0x2B4
	Parameters: 3
	Flags: Linked
*/
function function_6c8cff7e(normal, origin = self.origin, offset = 0)
{
	self notify("4d0917ba596af416");
	self endon("4d0917ba596af416");
	self endon(#"death", #"hash_7f30c56005fe2b32");
	if(!isdefined(normal))
	{
		return 0;
	}
	if(isdefined(self.var_2390d88))
	{
		self.var_2390d88 delete();
		self.var_2390d88 = undefined;
	}
	self.var_2390d88 = spawn("script_model", origin);
	self.var_2390d88.targetname = "heli_rotatemover";
	if(isdefined(self.var_2390d88))
	{
		self.var_2390d88 thread deletemeonnotify(self, "death");
		self.var_2390d88.angles = self.angles;
		targetangles = function_c1fa62a2(self.var_2390d88.angles, normal);
		self linkto(self.var_2390d88);
		self.var_2390d88 rotateto(targetangles, 0.5, 0, 0.5);
		self.var_2390d88 moveto(origin + (0, 0, offset), 0.5, 0, 0.5);
		self.var_2390d88 waittill(#"rotatedone");
		self.var_2390d88 delete();
		self.var_2390d88 = undefined;
	}
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self setphysacceleration((0, 0, 0));
	self sethoverparams(0);
	self setgoal(self.origin, 1, 0);
}

/*
	Name: function_f4d358df
	Namespace: namespace_964fbfb5
	Checksum: 0x45EDF05D
	Offset: 0x9AD8
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f4d358df()
{
	self.var_c1764af8 = 0;
	self.var_4dab0a63 = 0;
	self.var_67136cb0 = undefined;
	self.var_6fac6f50 = undefined;
}

/*
	Name: function_d929b41
	Namespace: namespace_964fbfb5
	Checksum: 0x84D32843
	Offset: 0x9B10
	Size: 0x194
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d929b41()
{
	self.var_4dab0a63 = 0;
	speed = self getspeedmph();
	var_a01adee8 = physicstrace(self.origin, self.origin - vectorscale((0, 0, 1), 1536), (0, 0, 0), (0, 0, 0), self, 2);
	if(speed < 15 && var_a01adee8[#"fraction"] < 0.2604167)
	{
		self.var_4dab0a63 = 1;
		self.var_c1764af8 = 1;
		self vehicle_ai::set_state("landing");
	}
	else if(speed < 80 && var_a01adee8[#"fraction"] < 1)
	{
		self.var_c1764af8 = 1;
		params = spawnstruct();
		params.var_6249a386 = 1;
		self vehicle_ai::set_state("spiral", params);
	}
	else
	{
		self.var_4e76046a = 1;
		self vehicle_ai::set_state("spiral");
	}
}

/*
	Name: function_3b841f4
	Namespace: namespace_964fbfb5
	Checksum: 0x730854AE
	Offset: 0x9CB0
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_3b841f4()
{
	var_a01adee8 = physicstrace(self.origin, self.origin - vectorscale((0, 0, 1), 1536), (0, 0, 0), (0, 0, 0), self, 2);
	if(var_a01adee8[#"fraction"] >= 1)
	{
		self.var_4e76046a = 1;
		self vehicle_ai::set_state("spiral");
	}
	else if(var_a01adee8[#"fraction"] > 0.2604167)
	{
		self.var_c1764af8 = 1;
		params = spawnstruct();
		params.var_6249a386 = 1;
		self vehicle_ai::set_state("spiral", params);
	}
}

/*
	Name: function_92270eeb
	Namespace: namespace_964fbfb5
	Checksum: 0xD3967D65
	Offset: 0x9DC8
	Size: 0x1DC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_92270eeb(params)
{
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self setphysacceleration((0, 0, 0));
	self sethoverparams(0);
	self setgoal(self.origin, 1, 0);
	self setrotorspeed(0);
	if(isdefined(params.makeunusable) && params.makeunusable || (isdefined(self.var_1ba362d5) && self.var_1ba362d5))
	{
		self function_41a269b3();
	}
	self vehicle::toggle_tread_fx(0);
	self vehicle::toggle_exhaust_fx(0);
	self vehicle::toggle_sounds(0);
	self vehicle::function_bbc1d940(0);
	self disableaimassist();
	vehicle_ai::turnoffallambientanims();
	vehicle_ai::clearalllookingandtargeting();
	vehicle_ai::clearallmovement();
	if(!(isdefined(params.isinitialstate) && params.isinitialstate))
	{
		self vehicle::function_7f0bbde3();
	}
}

/*
	Name: function_365e033d
	Namespace: namespace_964fbfb5
	Checksum: 0x1AC84098
	Offset: 0x9FB0
	Size: 0x164
	Parameters: 1
	Flags: Linked, Private
*/
private function function_365e033d(params)
{
	params.var_32a85fa1 = 2;
	params.var_1751c737 = 1;
	params.var_da88902a = 1;
	params.var_30a04b16 = 1;
	self vehicle::toggle_tread_fx(1);
	self vehicle::toggle_exhaust_fx(1);
	self thread vehicle::function_fa4236af(params);
	self enableaimassist();
	self setphysacceleration((0, 0, 0));
	self thread vehicle_ai::nudge_collision();
	self setrotorspeed(1);
	if(isdefined(level.enable_thermal))
	{
		if(self vehicle_ai::get_next_state() !== "death")
		{
			[[level.enable_thermal]]();
		}
	}
	if(!(isdefined(self.nolights) && self.nolights))
	{
		self vehicle::lights_on();
	}
}

/*
	Name: function_4b5646b1
	Namespace: namespace_964fbfb5
	Checksum: 0x963E3F0C
	Offset: 0xA120
	Size: 0x2B4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4b5646b1(params)
{
	self endon(#"death");
	if(isdefined(level.vehicle_destructer_cb))
	{
		[[level.vehicle_destructer_cb]](self);
	}
	self vehicle_death::death_fx();
	self thread vehicle_death::death_radius_damage("MOD_EXPLOSIVE", params.attacker);
	self vehicle::do_death_dynents();
	self notsolid();
	self ghost();
	if(isdefined(self.deathmodel) && (!(isdefined(getgametypesetting(#"hash_24918193d72a5866")) && getgametypesetting(#"hash_24918193d72a5866"))))
	{
		if(!isdefined(level.var_82eb1dab))
		{
			level.var_82eb1dab = [];
		}
		util::wait_network_frame();
		deathmodel = spawn("script_model", self.origin);
		deathmodel.targetname = "heli_deathmodel";
		deathmodel setmodel(self.deathmodel);
		deathmodel.angles = self.angles;
		deathmodel physicslaunch((0, 0, 0), self getvelocity() * 0.8);
		deathmodel clientfield::set("deathfx", 1);
		if(!isdefined(level.var_82eb1dab))
		{
			level.var_82eb1dab = [];
		}
		else if(!isarray(level.var_82eb1dab))
		{
			level.var_82eb1dab = array(level.var_82eb1dab);
		}
		level.var_82eb1dab[level.var_82eb1dab.size] = deathmodel;
	}
	vehicle_death::deletewhensafe();
}

/*
	Name: function_976267bc
	Namespace: namespace_964fbfb5
	Checksum: 0x9F3BD4C3
	Offset: 0xA3E0
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_976267bc(params)
{
	self takeplayercontrol();
	self setphysacceleration(vectorscale((0, 0, -1), 100));
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self.var_4e76046a = 0;
	self function_41a269b3();
	self.takedamage = 0;
	self setrotorspeed(0);
	self clientfield::set("stopallfx", 1);
	self clientfield::set("flickerlights", 1);
	self vehicle::toggle_sounds(0);
}

/*
	Name: function_eadfd579
	Namespace: namespace_964fbfb5
	Checksum: 0xBED69A67
	Offset: 0xA4F8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_eadfd579(params)
{
}

/*
	Name: function_e13c4d09
	Namespace: namespace_964fbfb5
	Checksum: 0x19CE59B4
	Offset: 0xA510
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_e13c4d09(params)
{
}

/*
	Name: function_1f014f43
	Namespace: namespace_964fbfb5
	Checksum: 0xEDEDAB77
	Offset: 0xA528
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_1f014f43(params)
{
	if(!isdefined(params.var_c1ed6562))
	{
		params.var_c1ed6562 = 0.7;
	}
	occupants = self getvehoccupants();
	if(occupants.size == 0)
	{
		params.var_52c5850b = 60;
	}
	self setrotorspeed(params.var_c1ed6562);
	self takeplayercontrol();
}

/*
	Name: function_2e3fb54c
	Namespace: namespace_964fbfb5
	Checksum: 0x43A379B6
	Offset: 0xA5D8
	Size: 0x376
	Parameters: 1
	Flags: Linked
*/
function function_2e3fb54c(params)
{
	self endon(#"change_state", #"death");
	if(!isdefined(params.var_52c5850b))
	{
		params.var_52c5850b = 25;
	}
	if(isdefined(params.var_6249a386) && params.var_6249a386)
	{
		params.var_746f2b2f = 1;
		params.var_96a3f4c7 = 1;
	}
	targetyaw = randomintrange(50, 150);
	if((targetyaw % 2) == 0)
	{
		targetyaw = targetyaw * -1;
	}
	pitch = 0;
	roll = 0;
	yaw = 0;
	if(!(isdefined(params.var_96a3f4c7) && params.var_96a3f4c7))
	{
		roll = (targetyaw * -1) * randomfloatrange(0.125, 0.25);
	}
	if(!(isdefined(params.var_746f2b2f) && params.var_746f2b2f))
	{
		pitch = abs(targetyaw) * randomfloatrange(0.075, 0.15);
	}
	starttime = gettime();
	while(true)
	{
		if(abs(yaw) < abs(targetyaw))
		{
			yaw = lerpfloat(0, targetyaw, (gettime() - starttime) / 3000);
		}
		if(pitch || roll && asin(anglestoup(self.angles)[2]) < (90 - params.var_52c5850b))
		{
			pitch = 0;
			roll = 0;
		}
		self setangularvelocity((pitch, yaw, roll));
		up = anglestoup(self.angles);
		accel = 1200;
		if(params.var_52c5850b < 45)
		{
			accel = 1600;
		}
		self setphysacceleration((up[0] * accel, up[1] * accel, -386 * (max(0.4, 1.2 - up[2]))));
		waitframe(1);
	}
}

/*
	Name: function_aaa84ac
	Namespace: namespace_964fbfb5
	Checksum: 0xC33AF2C8
	Offset: 0xA958
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_aaa84ac(params)
{
}

/*
	Name: function_d344c3f
	Namespace: namespace_964fbfb5
	Checksum: 0xC59C62F7
	Offset: 0xA970
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_d344c3f(params)
{
	self setrotorspeed(1);
	self takeplayercontrol();
}

/*
	Name: function_e291246d
	Namespace: namespace_964fbfb5
	Checksum: 0x6E23B61A
	Offset: 0xA9C0
	Size: 0x162
	Parameters: 1
	Flags: Linked
*/
function function_e291246d(params)
{
	self endon(#"death", #"change_state");
	while(true)
	{
		pilot = self getseatoccupant(0);
		if(!isdefined(pilot))
		{
			self vehicle_ai::set_state("spiral");
			break;
		}
		move = pilot getnormalizedmovement();
		if(pilot vehiclemoveupbuttonpressed() || (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)))
		{
			self.var_4e76046a = undefined;
			self returnplayercontrol();
			self vehicle_ai::set_state("driving");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_ad15f5e8
	Namespace: namespace_964fbfb5
	Checksum: 0xB5A8F2F0
	Offset: 0xAB30
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_ad15f5e8(params)
{
}

/*
	Name: function_200c3bd0
	Namespace: namespace_964fbfb5
	Checksum: 0x10FB2021
	Offset: 0xAB48
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_200c3bd0(params)
{
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self setphysacceleration(vectorscale((0, 0, -1), 386));
	self setheliheightcap(1);
}

/*
	Name: function_3a7426cf
	Namespace: namespace_964fbfb5
	Checksum: 0x7A8B3A2B
	Offset: 0xABC8
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_3a7426cf(params)
{
	self endon(#"change_state", #"death");
	damagetime = gettime() + 15000;
	while(true)
	{
		wait(0.25);
		if(self function_479389f3())
		{
			self vehicle_ai::set_state("landed");
			return;
		}
		function_3b841f4();
		if(gettime() > damagetime)
		{
			self dodamage(250, self.origin, undefined, undefined, "", "MOD_IMPACT");
		}
	}
}

/*
	Name: function_3b1d3bf1
	Namespace: namespace_964fbfb5
	Checksum: 0x109F4843
	Offset: 0xACB8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_3b1d3bf1(params)
{
}

/*
	Name: function_d39845f
	Namespace: namespace_964fbfb5
	Checksum: 0xDB9B30A2
	Offset: 0xACD0
	Size: 0xDC
	Parameters: 1
	Flags: Linked
*/
function function_d39845f(params)
{
	self takeplayercontrol();
	self setvehvelocity((0, 0, 0));
	self setangularvelocity((0, 0, 0));
	self setphysacceleration((0, 0, 0));
	self sethoverparams(0);
	self setgoal(self.origin, 1, 0);
	self thread function_6c8cff7e(self.var_67136cb0, self.helilandingorigin, self.var_6fac6f50);
}

/*
	Name: function_b705c816
	Namespace: namespace_964fbfb5
	Checksum: 0xE02080D0
	Offset: 0xADB8
	Size: 0x2A2
	Parameters: 1
	Flags: Linked
*/
function function_b705c816(params)
{
	self endon(#"death", #"state_changed");
	if(!isdefined(params))
	{
		params = spawnstruct();
	}
	if(isdefined(self.emped) && self.emped || (isdefined(self.jammed) && self.jammed))
	{
		params.var_c1273f91 = 1;
		self vehicle_ai::set_state("off", params);
		return;
	}
	if(self vehicle_ai::get_previous_state() === "off")
	{
		wait(2);
	}
	while(true)
	{
		if(isdefined(self.emped) && self.emped || (isdefined(self.jammed) && self.jammed))
		{
			params.var_c1273f91 = 1;
			self vehicle_ai::set_state("off", params);
			break;
		}
		if(isdefined(self.var_b3e4af16) && self.var_b3e4af16)
		{
			waitframe(1);
			continue;
		}
		player = self getseatoccupant(0);
		if(!isdefined(player))
		{
			params.no_falling = 1;
			params.var_c1273f91 = 1;
			self vehicle_ai::set_state("off", params);
			break;
		}
		move = player getnormalizedmovement();
		if(player vehiclemoveupbuttonpressed() || (isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2)))
		{
			self vehicle_ai::set_state("driving");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_7db28345
	Namespace: namespace_964fbfb5
	Checksum: 0xC0CBB9EE
	Offset: 0xB068
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_7db28345(params)
{
	if(vehicle_ai::function_329f45a4())
	{
		self notify(#"hash_7f30c56005fe2b32");
		self returnplayercontrol();
		if(isdefined(self.var_2390d88))
		{
			self.var_2390d88 delete();
			self.var_2390d88 = undefined;
		}
	}
	self function_f4d358df();
	self setheliheightcap(1);
}

/*
	Name: function_479389f3
	Namespace: namespace_964fbfb5
	Checksum: 0xD124AB1A
	Offset: 0xB118
	Size: 0x68E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_479389f3()
{
	height = self.height;
	/#
		assert(isdefined(self.radius));
	#/
	/#
		assert(isdefined(self.height));
	#/
	var_33a206d0 = [];
	var_33a206d0[#"hash_64b97ae77785a7ee"] = self gettagorigin("tag_ground_contact_left_rear");
	var_33a206d0[#"hash_349199d2ecdec815"] = self gettagorigin("tag_ground_contact_left_middle");
	var_33a206d0[#"hash_29fc8d2eb0114b77"] = self gettagorigin("tag_ground_contact_left_front");
	var_8fc02d3b = [];
	var_8fc02d3b[#"hash_3e2b39e8efce03e3"] = self gettagorigin("tag_ground_contact_right_rear");
	var_8fc02d3b[#"hash_6d1b048369aa0658"] = self gettagorigin("tag_ground_contact_right_middle");
	var_8fc02d3b[#"hash_3baad632e39e1598"] = self gettagorigin("tag_ground_contact_right_front");
	var_df47b913 = [];
	foreach(tag, origin in var_33a206d0)
	{
		if(!isdefined(origin))
		{
			return 0;
		}
		var_df47b913[tag] = physicstrace(origin + vectorscale((0, 0, 1), 25), origin - vectorscale((0, 0, 1), 75), (0, 0, 0), (0, 0, 0), self, 2);
	}
	var_dc8469e2 = [];
	foreach(tag, origin in var_8fc02d3b)
	{
		if(!isdefined(origin))
		{
			return 0;
		}
		var_dc8469e2[tag] = physicstrace(origin + vectorscale((0, 0, 1), 25), origin - vectorscale((0, 0, 1), 75), (0, 0, 0), (0, 0, 0), self, 2);
	}
	var_d643c4fc = 0;
	var_e10b67f7 = [];
	var_b0e8278f = (0, 0, 0);
	var_683999d6 = (0, 0, 0);
	var_4c962569 = 0;
	foreach(tag, trace in var_df47b913)
	{
		if(isdefined(trace[#"entity"]))
		{
			var_d643c4fc = 1;
			continue;
		}
		if(trace[#"fraction"] < 1)
		{
			var_b0e8278f = var_b0e8278f + var_33a206d0[tag];
			var_4c962569 = var_4c962569 + (trace[#"position"][2] - var_33a206d0[tag][2]);
			var_683999d6 = var_683999d6 + trace[#"normal"];
			var_e10b67f7[tag] = trace;
		}
	}
	var_d3532cfe = [];
	foreach(tag, trace in var_dc8469e2)
	{
		if(isdefined(trace[#"entity"]))
		{
			var_d643c4fc = 1;
			continue;
		}
		if(trace[#"fraction"] < 1)
		{
			var_b0e8278f = var_b0e8278f + var_8fc02d3b[tag];
			var_4c962569 = var_4c962569 + (trace[#"position"][2] - var_8fc02d3b[tag][2]);
			var_683999d6 = var_683999d6 + trace[#"normal"];
			var_d3532cfe[tag] = trace;
		}
	}
	if(var_e10b67f7.size > 0 || var_d3532cfe.size > 0)
	{
		var_683999d6 = var_683999d6 / (var_d3532cfe.size + var_e10b67f7.size);
		self.var_eb4e4182 = var_683999d6;
	}
	if(var_683999d6[2] < 0.94)
	{
		return 0;
	}
	if(var_e10b67f7.size == 0 || var_d3532cfe.size == 0 || (var_d3532cfe.size + var_e10b67f7.size) < 3)
	{
		return 0;
	}
	if(var_d643c4fc)
	{
		return 0;
	}
	var_4c962569 = var_4c962569 / ((var_d3532cfe.size + var_e10b67f7.size) + 1);
	if(var_4c962569 > 20)
	{
		return 0;
	}
	var_b0e8278f = var_b0e8278f / (var_d3532cfe.size + var_e10b67f7.size);
	self.helilandingorigin = var_b0e8278f;
	self.var_6fac6f50 = var_4c962569;
	self.var_67136cb0 = var_683999d6;
	return 1;
}

/*
	Name: function_4885ce1
	Namespace: namespace_964fbfb5
	Checksum: 0x5447B3A3
	Offset: 0xB7B0
	Size: 0x64C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4885ce1(params)
{
	if(params.stype === "player")
	{
		return;
	}
	if(isdefined(params.entity) && isvehicle(params.entity) && params.entity function_dcef0ba1(0) && !params.entity isvehicleseatoccupied(0))
	{
		force = (vectornormalize(params.entity.origin - self.origin)) * 1.2;
		params.entity launchvehicle(force);
	}
	if(isdefined(self.var_4e76046a) && self.var_4e76046a)
	{
		self dodamage(self.health, self.origin, undefined, undefined, "", "MOD_IMPACT");
		return;
	}
	if(!(isdefined(self.var_4dab0a63) && self.var_4dab0a63))
	{
		if(self.scriptvehicletype == "helicopter_utility")
		{
			var_1fdf316c = 25;
			var_a7796a79 = 100;
			mindamage = 150;
			maxdamage = 5000;
		}
		var_1fdf316c = getdvarfloat(#"hash_54a2c2e9555f2e5e", 35);
		var_a7796a79 = getdvarfloat(#"hash_70c1f7e69c442750", 140);
		mindamage = getdvarfloat(#"hash_42dae76d8ea47a8e", 75);
		maxdamage = getdvarfloat(#"hash_55d628640db7ed48", 3000);
		speed = self getspeedmph();
		if(isdefined(params.entity) && isvehicle(params.entity))
		{
			var_b219fafb = params.entity getspeedmph();
			if(var_b219fafb > speed)
			{
				speed = var_b219fafb;
			}
		}
		if(speed > var_1fdf316c)
		{
			var_ae95ae92 = mapfloat(var_1fdf316c, var_a7796a79, mindamage, maxdamage, speed);
			normal = params.normal;
			var_264f4ce2 = self.origin - (100 * normal);
			if(isdefined(params.entity) && isvehicle(params.entity))
			{
				riders = params.entity getvehoccupants();
				if(isdefined(riders) && isdefined(riders[0]))
				{
					attacker = riders[0];
				}
			}
			self dodamage(var_ae95ae92, var_264f4ce2, attacker);
		}
	}
	state = self vehicle_ai::get_current_state();
	if(state === "driving")
	{
		player = self getseatoccupant(0);
		if(!isdefined(player) || !player function_6947dde2())
		{
			return;
		}
		move = player getnormalizedmovement();
		if(isdefined(move) && (abs(move[0]) > 0.2 || abs(move[1]) > 0.2))
		{
			return;
		}
		if(isdefined(params.entity))
		{
			return;
		}
		if(self function_479389f3())
		{
			self vehicle_ai::set_state("landed", params);
		}
		else
		{
			player clientfield::set_player_uimodel("vehicle.invalidLanding", 1);
		}
	}
	else if(state === "landing" || state === "spiral")
	{
		self function_479389f3();
		if(isdefined(self.var_67136cb0))
		{
			self vehicle_ai::set_state("landed");
		}
		else if(isdefined(self.var_eb4e4182))
		{
			if(self vehicle_ai::get_current_state() === "spiral")
			{
				self vehicle_ai::set_state("landing");
			}
			self function_9dd58750();
		}
	}
}

/*
	Name: function_9dd58750
	Namespace: namespace_964fbfb5
	Checksum: 0x2F8EC609
	Offset: 0xBE08
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_9dd58750()
{
	if(!isdefined(self.var_eb4e4182))
	{
		return;
	}
	if(self.var_eb4e4182[2] < 0.99)
	{
		var_352be391 = self getvelocity()[2];
		var_7cec550f = (self.var_eb4e4182[0] * 300, self.var_eb4e4182[1] * 300, var_352be391);
	}
	else
	{
		var_7cec550f = (1, 0, 0) * 300;
	}
	self setvehvelocity(var_7cec550f);
}

/*
	Name: function_2513e40c
	Namespace: namespace_964fbfb5
	Checksum: 0x39AF08D6
	Offset: 0xBEC0
	Size: 0xC6
	Parameters: 3
	Flags: Linked
*/
function function_2513e40c(vehicle, player, seatindex)
{
	if(player infection::is_infected())
	{
		return 0;
	}
	if(player item_world::function_8e0d14c1(1))
	{
		return 0;
	}
	if(vehicle.vehicleclass === "boat")
	{
		if(vehicle function_7548ecb2() && (isdefined(vehicle.var_221879dc) && vehicle.var_221879dc))
		{
			if(seatindex === 0)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_41a269b3
	Namespace: namespace_964fbfb5
	Checksum: 0xEB8E19FB
	Offset: 0xBF90
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_41a269b3()
{
	occupants = self getvehoccupants();
	if(isdefined(occupants) && occupants.size)
	{
		for(i = 0; i < occupants.size; i++)
		{
			if(isdefined(occupants[i]))
			{
				var_5ccabf3e = self getoccupantseat(occupants[i]);
				if(isdefined(var_5ccabf3e))
				{
					self usevehicle(occupants[i], var_5ccabf3e);
				}
			}
		}
	}
	self makevehicleunusable();
}

/*
	Name: function_32607cfc
	Namespace: namespace_964fbfb5
	Checksum: 0x74BFBB2C
	Offset: 0xC070
	Size: 0x128
	Parameters: 1
	Flags: Linked
*/
function function_32607cfc(vehicle)
{
	if(isdefined(vehicle) && isdefined(vehicle.settings) && (isdefined(vehicle.settings.var_6754976b) && vehicle.settings.var_6754976b))
	{
		return 1;
	}
	/#
		if(getdvarint(#"hash_6a34a21ac687e5ce", 0))
		{
			return 1;
		}
	#/
	if(isdefined(getgametypesetting(#"hash_24918193d72a5866")) && getgametypesetting(#"hash_24918193d72a5866"))
	{
		return 1;
	}
	distancetraveled = self stats::function_441050ca(#"hash_539ef3a516f1caba");
	if(!isdefined(distancetraveled))
	{
		return 0;
	}
	return distancetraveled >= 1647360;
}

/*
	Name: heli_emp_done
	Namespace: namespace_964fbfb5
	Checksum: 0x4BF55DD
	Offset: 0xC1A0
	Size: 0x186
	Parameters: 1
	Flags: Linked
*/
function heli_emp_done(params)
{
	if(isdefined(self))
	{
		if(isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](self);
		}
		self.abnormal_status.emped = 0;
		self.var_b3e4af16 = undefined;
		self clientfield::set("flickerlights", 3);
		self function_2418736c();
		self vehicle::toggle_emp_fx(0);
		self vehicle_ai::emp_startup_fx();
		self function_388973e4(0);
		if(vehicle_ai::function_329f45a4())
		{
			currentstate = self vehicle_ai::get_current_state();
			if(currentstate === "spiral")
			{
				if(self vehicle_ai::has_state("recovery"))
				{
					self vehicle_ai::set_state("recovery");
				}
			}
		}
		else
		{
			self vehicle_ai::set_state("off");
		}
		self notify(#"heli_emp_done");
	}
}

/*
	Name: function_4e74bed7
	Namespace: namespace_964fbfb5
	Checksum: 0xE325FC0F
	Offset: 0xC330
	Size: 0x2CC
	Parameters: 1
	Flags: Linked
*/
function function_4e74bed7(params)
{
	self function_a98ae5fe();
	self vehicle::toggle_emp_fx(1);
	self takeplayercontrol();
	self.var_b3e4af16 = 1;
	currentstate = self vehicle_ai::get_current_state();
	if(currentstate === "off")
	{
	}
	else if(currentstate === "landed")
	{
	}
	else if(currentstate === "spiral")
	{
		self.var_4e76046a = 1;
	}
	else
	{
		self function_d929b41();
	}
	self playsound(#"hash_d6643b88d0186ae");
	self function_388973e4(1);
	if(!isdefined(self.abnormal_status))
	{
		self.abnormal_status = spawnstruct();
	}
	self.abnormal_status.emped = 1;
	self.abnormal_status.attacker = params.param1;
	self.abnormal_status.inflictor = params.param2;
	self vehicle::function_bbc1d940(0);
	if(isdefined(self.settings) && (isdefined(self.settings.var_6754976b) && self.settings.var_6754976b))
	{
		params.var_d8ceeba3 = 0;
		self function_ef44d420(params);
	}
	time = params.param0;
	/#
		assert(isdefined(time));
	#/
	util::cooldown("emped_timer", time);
	while(!util::iscooldownready("emped_timer") && isalive(self))
	{
		timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
		wait(timeleft);
	}
	self heli_emp_done(params);
}

/*
	Name: function_9e6e374a
	Namespace: namespace_964fbfb5
	Checksum: 0x6E0EC70D
	Offset: 0xC608
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_9e6e374a(params)
{
	if(isdefined(self))
	{
		if(isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](self);
		}
		self clientfield::set("stunned", 0);
		self vehicle_ai::emp_startup_fx();
		self vehicle::toggle_emp_fx(0);
		if(isdefined(level.var_fc1bbaef))
		{
			[[level.var_fc1bbaef]](self);
		}
		self.abnormal_status.emped = 0;
		if(vehicle_ai::function_329f45a4())
		{
			self turn_on();
		}
		self function_388973e4(0);
	}
}

/*
	Name: function_c9620f20
	Namespace: namespace_964fbfb5
	Checksum: 0x46AAA579
	Offset: 0xC710
	Size: 0x294
	Parameters: 1
	Flags: Linked
*/
function function_c9620f20(params)
{
	self vehicle::toggle_emp_fx(1);
	self vehicle::function_bbc1d940(0);
	self vehicle::toggle_sounds(0);
	if(isdefined(self.var_52e23e90) && self.var_52e23e90)
	{
		self vehicle::function_7f0bbde3();
		self playsound(#"hash_d6643b88d0186ae");
	}
	self function_388973e4(1);
	self.var_52e23e90 = undefined;
	if(isdefined(self.settings) && (isdefined(self.settings.var_6754976b) && self.settings.var_6754976b))
	{
		params.var_d8ceeba3 = 0;
		self function_ef44d420(params);
	}
	if(!isdefined(self.abnormal_status))
	{
		self.abnormal_status = spawnstruct();
	}
	self clientfield::set("stunned", 1);
	self.abnormal_status.emped = 1;
	self.abnormal_status.attacker = params.param1;
	self.abnormal_status.inflictor = params.param2;
	time = params.param0;
	/#
		assert(isdefined(time));
	#/
	util::cooldown("emped_timer", time);
	while(!util::iscooldownready("emped_timer") && isalive(self))
	{
		timeleft = max(util::getcooldownleft("emped_timer"), 0.5);
		wait(timeleft);
	}
	self function_9e6e374a(params);
}

/*
	Name: function_ee42a973
	Namespace: namespace_964fbfb5
	Checksum: 0x6CAD60EC
	Offset: 0xC9B0
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_ee42a973(player)
{
	self.var_4b0fd2dc = 1;
	self thread function_33a25ecf(player);
	self playsound(#"wpn_trophy_deploy_start");
	self playloopsound(#"wpn_trophy_spin", 0.25);
}

/*
	Name: function_33a25ecf
	Namespace: namespace_964fbfb5
	Checksum: 0xAD066A24
	Offset: 0xCA38
	Size: 0x37A
	Parameters: 1
	Flags: Linked
*/
function function_33a25ecf(owner)
{
	owner endon(#"disconnect");
	self endon(#"death", #"hash_23b61069705a7782");
	while(true)
	{
		if(!isdefined(self))
		{
			return;
		}
		if(level.missileentities.size < 1)
		{
			waitframe(1);
			continue;
		}
		waitframe(1);
		missileents = owner getentitiesinrange(level.missileentities, 512, self.origin);
		for(index = 0; index < missileents.size; index++)
		{
			if(!isdefined(self))
			{
				return;
			}
			grenade = missileents[index];
			if(!isdefined(grenade))
			{
				continue;
			}
			if(grenade == self)
			{
				continue;
			}
			if(!grenade.weapon.destroyablebytrophysystem)
			{
				continue;
			}
			if(grenade.destroyablebytrophysystem === 0)
			{
				continue;
			}
			switch(grenade.model)
			{
				case "t6_wpn_grenade_supply_projectile":
				{
					continue;
				}
			}
			if(!isdefined(grenade.owner))
			{
				grenade.owner = getmissileowner(grenade);
			}
			if(isdefined(grenade.owner))
			{
				if(level.teambased)
				{
					if(!grenade.owner util::isenemyteam(owner.team))
					{
						continue;
					}
				}
				else if(grenade.owner == owner)
				{
					continue;
				}
				if(bullettracepassed(grenade.origin, self.origin + vectorscale((0, 0, 1), 29), 0, self, grenade, 0, 1))
				{
					grenade notify(#"death");
					if(isdefined(level.var_ccfcde75))
					{
						owner [[level.var_ccfcde75]](self, grenade);
					}
					var_84c1f04c = grenade.origin - self.origin;
					if(var_84c1f04c == (0, 0, 0))
					{
						var_84c1f04c = (1, 0, 0);
					}
					var_cd148a81 = anglestoup(self.angles);
					if(var_cd148a81 == (0, 0, 0))
					{
						var_cd148a81 = (0, 0, 1);
					}
					playfx("weapon/fx_trophy_flash", self.origin + vectorscale((0, 0, 1), 15), var_84c1f04c, var_cd148a81);
					owner thread function_4885de67(grenade);
					index--;
					self playsound(#"wpn_trophy_alert");
				}
			}
		}
	}
}

/*
	Name: function_4885de67
	Namespace: namespace_964fbfb5
	Checksum: 0x21B06AF8
	Offset: 0xCDC0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_4885de67(projectile)
{
	self endon(#"death");
	projposition = projectile.origin;
	playfx("weapon/fx_trophy_detonation", projposition);
	projectile delete();
}

/*
	Name: function_6a65d095
	Namespace: namespace_964fbfb5
	Checksum: 0x535BDFE5
	Offset: 0xCE38
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_6a65d095()
{
	if(isdefined(self.var_4b0fd2dc) && self.var_4b0fd2dc)
	{
		self notify(#"hash_23b61069705a7782");
		self stoploopsound(0.25);
		self.var_4b0fd2dc = undefined;
	}
}

/*
	Name: function_4ead318d
	Namespace: namespace_964fbfb5
	Checksum: 0xC7EFDBC4
	Offset: 0xCE98
	Size: 0x328
	Parameters: 0
	Flags: None
*/
function function_4ead318d()
{
	/#
		self endon(#"death");
		height = self.height;
		/#
			assert(isdefined(self.radius));
		#/
		/#
			assert(isdefined(self.height));
		#/
		while(true)
		{
			waitframe(1);
			var_9072f5ef = self gettagorigin("");
			var_2ce6c735 = self gettagorigin("");
			var_2704b6f = self gettagorigin("");
			var_dbe8006b = self gettagorigin("");
			var_b74b6469 = self gettagorigin("");
			var_3db5bf71 = self gettagorigin("");
			if(!isdefined(var_9072f5ef))
			{
				break;
			}
			line(var_9072f5ef + vectorscale((0, 0, 1), 25), var_9072f5ef - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
			line(var_2ce6c735 + vectorscale((0, 0, 1), 25), var_2ce6c735 - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
			line(var_2704b6f + vectorscale((0, 0, 1), 25), var_2704b6f - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
			line(var_dbe8006b + vectorscale((0, 0, 1), 25), var_dbe8006b - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
			line(var_b74b6469 + vectorscale((0, 0, 1), 25), var_b74b6469 - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
			line(var_3db5bf71 + vectorscale((0, 0, 1), 25), var_3db5bf71 - vectorscale((0, 0, 1), 75), (1, 1, 0), 1);
		}
	#/
}

