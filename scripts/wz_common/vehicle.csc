// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_28356b649490eda1;
#using script_38dc72b5220a1a67;
#using script_40e017336a087343;
#using script_45e0fb7326469ccf;
#using script_7814d07c54641f82;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace namespace_964fbfb5;

/*
	Name: function_89f2df9
	Namespace: namespace_964fbfb5
	Checksum: 0xB3526EB
	Offset: 0x348
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_efc308ec898ff43", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_964fbfb5
	Checksum: 0x5C247086
	Offset: 0x390
	Size: 0x35C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	vehicle::add_vehicletype_callback("player_atv", &function_500291c4);
	vehicle::add_vehicletype_callback("player_suv", &function_79500af5);
	vehicle::add_vehicletype_callback("player_fav", &function_bd3b5229);
	vehicle::add_vehicletype_callback("player_muscle", &function_fb9c790a);
	vehicle::add_vehicletype_callback("cargo_truck_wz", &function_8278ed00);
	vehicle::add_vehicletype_callback("tactical_raft_wz", &function_6b617752);
	vehicle::add_vehicletype_callback("pbr_boat_wz", &function_cc0af45d);
	vehicle::add_vehicletype_callback("helicopter_light", &function_a01726dd);
	vehicle::add_vehicletype_callback("player_motorcycle", &function_cb575bc3);
	vehicle::add_vehicletype_callback("player_tank", &function_c0f1d81b);
	clientfield::register("scriptmover", "deathfx", 1, 1, "int", &field_do_deathfx, 0, 0);
	clientfield::register("vehicle", "overheat_fx", 9000, 1, "int", &function_b4806ee, 0, 0);
	clientfield::register("vehicle", "replacer_fx", 1, 1, "int", &function_a998aede, 0, 0);
	clientfield::register("toplayer", "toggle_vehicle_sensor", 1, 1, "int", &function_12d038ac, 0, 0);
	clientfield::register("scriptmover", "tank_deathfx", 22000, 1, "int", &function_de69d, 0, 0);
	level.var_e5010085 = vehicleturretoverheat::register("vehicleTurretOverheat");
	level.var_b5add14a = vehicleturretdurability::register("vehicleTurretDurability");
	callback::on_localplayer_spawned(&on_localplayer_spawned);
}

/*
	Name: on_localplayer_spawned
	Namespace: namespace_964fbfb5
	Checksum: 0x16A7200E
	Offset: 0x6F8
	Size: 0xA4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_localplayer_spawned(localclientnum)
{
	if(self function_21c0fa55())
	{
		self.var_53204996 = &function_3ec2efae;
		if(isdefined(getgametypesetting(#"hash_78bfea2b72e79da3")) && getgametypesetting(#"hash_78bfea2b72e79da3"))
		{
			level thread function_8fd2e04f(localclientnum);
		}
	}
}

/*
	Name: function_12d038ac
	Namespace: namespace_964fbfb5
	Checksum: 0xB1AC2D79
	Offset: 0x7A8
	Size: 0xAC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_12d038ac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.var_e29b96d2))
		{
			self.var_e29b96d2 delete();
		}
		self thread function_54e9d3c4(localclientnum);
	}
	else if(isdefined(self.var_e29b96d2))
	{
		self.var_e29b96d2 delete();
	}
}

/*
	Name: function_54e9d3c4
	Namespace: namespace_964fbfb5
	Checksum: 0x29878F81
	Offset: 0x860
	Size: 0x22C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_54e9d3c4(localclientnum)
{
	self notify("34f17bedff89ee31");
	self endon("34f17bedff89ee31");
	self endon(#"death");
	self endon(#"exit_vehicle");
	vehicle = undefined;
	while(true)
	{
		vehicle = getplayervehicle(self);
		if(isdefined(vehicle))
		{
			break;
		}
		waitframe(1);
	}
	driver = vehicle.owner;
	if(!isdefined(driver) || !isplayer(driver))
	{
		return;
	}
	self.var_e29b96d2 = spawn(localclientnum, vehicle.origin, "script_model", vehicle getentitynumber(), driver.team);
	if(isdefined(self.var_e29b96d2))
	{
		self.var_e29b96d2 setmodel(#"tag_origin");
		self.var_e29b96d2 linkto(vehicle);
		self.var_e29b96d2 setcompassicon("minimap_sensor_dart");
		self.var_e29b96d2 function_811196d1(0);
		self.var_e29b96d2 function_a5edb367(#"neutral");
		self.var_e29b96d2 function_8e04481f();
		self.var_e29b96d2 function_5e00861(0.62);
		self.var_e29b96d2 function_5db470de(localclientnum, 2400, 1);
	}
}

/*
	Name: function_3ec2efae
	Namespace: namespace_964fbfb5
	Checksum: 0xA22E339B
	Offset: 0xA98
	Size: 0x178
	Parameters: 1
	Flags: Linked
*/
function function_3ec2efae(localclientnum)
{
	vehicle = getplayervehicle(self);
	if(!isdefined(vehicle) || !vehicle isvehicle())
	{
		return false;
	}
	if(!isdefined(vehicle.owner))
	{
		return false;
	}
	if(util::function_fbce7263(vehicle.owner.team, self.team))
	{
		return false;
	}
	if(!isdefined(vehicle.scriptbundlesettings))
	{
		return false;
	}
	if(!isdefined(vehicle.settings))
	{
		vehicle.settings = struct::get_script_bundle("vehiclecustomsettings", vehicle.scriptbundlesettings);
	}
	if(isdefined(vehicle.settings) && (isdefined(vehicle.settings.var_6754976b) && vehicle.settings.var_6754976b))
	{
		var_1861e0b1 = vehicle clientfield::get("toggle_horn_sound");
		if(isdefined(var_1861e0b1) && var_1861e0b1)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_ba36f5d
	Namespace: namespace_964fbfb5
	Checksum: 0xC124A17E
	Offset: 0xC18
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_ba36f5d(localclientnum, val)
{
	self setstunned(val);
}

/*
	Name: function_79500af5
	Namespace: namespace_964fbfb5
	Checksum: 0x5DF0791F
	Offset: 0xC50
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_79500af5(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_fb9c790a
	Namespace: namespace_964fbfb5
	Checksum: 0xCF3B331D
	Offset: 0xCA0
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fb9c790a(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_bd3b5229
	Namespace: namespace_964fbfb5
	Checksum: 0x57669517
	Offset: 0xCF0
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_bd3b5229(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
	if(isdefined(self.scriptbundlesettings))
	{
		if(!isdefined(self.settings))
		{
			self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
		}
		if(isdefined(self.settings) && (isdefined(self.settings.var_74701269) && self.settings.var_74701269))
		{
			self thread vehicle::boost_think(localclientnum);
		}
	}
}

/*
	Name: function_500291c4
	Namespace: namespace_964fbfb5
	Checksum: 0x6D4222F8
	Offset: 0xDD0
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_500291c4(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_8278ed00
	Namespace: namespace_964fbfb5
	Checksum: 0xB510415C
	Offset: 0xE20
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8278ed00(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_6b617752
	Namespace: namespace_964fbfb5
	Checksum: 0xFC0BB653
	Offset: 0xE70
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_6b617752(localclientnum, data)
{
	self.var_917cf8e3 = &function_b0d51c9;
	self.var_1a6ef836 = 0;
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_cc0af45d
	Namespace: namespace_964fbfb5
	Checksum: 0x74C42F54
	Offset: 0xEC8
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_cc0af45d(localclientnum, data)
{
	self.var_917cf8e3 = &function_b0d51c9;
	self.var_1a6ef836 = 0;
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_a01726dd
	Namespace: namespace_964fbfb5
	Checksum: 0x96174A5C
	Offset: 0xF20
	Size: 0xEC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a01726dd(localclientnum, data)
{
	self.var_41860110 = &function_74272495;
	self.var_c6a9216 = &function_8411122e;
	self thread function_69fda304(localclientnum);
	if(isdefined(self.scriptbundlesettings))
	{
		if(!isdefined(self.settings))
		{
			self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
		}
		if(isdefined(self.settings) && (isdefined(self.settings.var_74701269) && self.settings.var_74701269))
		{
			self thread vehicle::boost_think(localclientnum);
		}
	}
}

/*
	Name: function_cb575bc3
	Namespace: namespace_964fbfb5
	Checksum: 0x71C8CCC0
	Offset: 0x1018
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
function private function_cb575bc3(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
	if(isdefined(self.scriptbundlesettings))
	{
		if(!isdefined(self.settings))
		{
			self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
		}
		if(isdefined(self.settings) && (isdefined(self.settings.var_74701269) && self.settings.var_74701269))
		{
			self thread vehicle::boost_think(localclientnum);
		}
	}
}

/*
	Name: function_c0f1d81b
	Namespace: namespace_964fbfb5
	Checksum: 0x423D1970
	Offset: 0x10F8
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c0f1d81b(localclientnum, data)
{
	self function_3f24c5a(1);
	self.var_ba36f5d = &function_ba36f5d;
}

/*
	Name: function_8411122e
	Namespace: namespace_964fbfb5
	Checksum: 0x8E64FD02
	Offset: 0x1148
	Size: 0x104
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8411122e(localclientnum, owner)
{
	surfaces = [];
	if(isdefined(self.trace))
	{
		if(self.trace[#"fraction"] != 1)
		{
			if(!isdefined(surfaces))
			{
				surfaces = [];
			}
			else if(!isarray(surfaces))
			{
				surfaces = array(surfaces);
			}
			if(!isinarray(surfaces, driving_fx::function_73e08cca(self.trace[#"surfacetype"])))
			{
				surfaces[surfaces.size] = driving_fx::function_73e08cca(self.trace[#"surfacetype"]);
			}
		}
	}
	return surfaces;
}

/*
	Name: function_b0d51c9
	Namespace: namespace_964fbfb5
	Checksum: 0xA5F80DC7
	Offset: 0x1258
	Size: 0x10A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b0d51c9(localclientnum, owner)
{
	curtime = gettime();
	if(curtime < self.var_1a6ef836)
	{
		return self.var_ed40ad25;
	}
	self.var_ed40ad25 = 0;
	if(isdefined(owner))
	{
		self.var_1a6ef836 = curtime + 500;
		cameraangles = owner getcamangles();
		if(isdefined(cameraangles))
		{
			var_742173a2 = anglestoforward(cameraangles);
			var_a181fdc8 = anglestoforward(self.angles);
			dot = vectordot(var_742173a2, var_a181fdc8);
			if(dot > 0.993)
			{
				self.var_ed40ad25 = 1;
			}
		}
	}
	return self.var_ed40ad25;
}

/*
	Name: function_74272495
	Namespace: namespace_964fbfb5
	Checksum: 0x76BA0F69
	Offset: 0x1370
	Size: 0x18
	Parameters: 2
	Flags: Linked, Private
*/
function private function_74272495(localclientnum, owner)
{
	return true;
}

/*
	Name: function_69fda304
	Namespace: namespace_964fbfb5
	Checksum: 0x20E6397
	Offset: 0x1390
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_69fda304(localclientnum)
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"enter_vehicle");
		if(isdefined(waitresult.player))
		{
			if(waitresult.player function_21c0fa55())
			{
				waitresult.player thread function_732976d8(localclientnum, self);
			}
		}
	}
}

/*
	Name: heli_exit
	Namespace: namespace_964fbfb5
	Checksum: 0x6102C0EC
	Offset: 0x1438
	Size: 0x5C
	Parameters: 1
	Flags: Private
*/
function private heli_exit(localclientnum)
{
	self endon(#"death");
	self endon(#"disconnect");
	self waittill(#"exit_vehicle");
	self function_d1731820(localclientnum);
}

/*
	Name: function_d1731820
	Namespace: namespace_964fbfb5
	Checksum: 0x298E221D
	Offset: 0x14A0
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d1731820(localclientnum)
{
	if(isdefined(self) && isdefined(self.var_a9757792))
	{
		self stoprumble(localclientnum, self.var_a9757792);
		self.var_a9757792 = undefined;
	}
}

/*
	Name: function_ff8d2820
	Namespace: namespace_964fbfb5
	Checksum: 0xC7918B
	Offset: 0x14F8
	Size: 0x84
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ff8d2820(localclientnum, rumble)
{
	if(!isdefined(self))
	{
		return;
	}
	if(self.var_a9757792 === rumble)
	{
		return;
	}
	if(isdefined(self.var_a9757792))
	{
		self function_d1731820(localclientnum);
	}
	self.var_a9757792 = rumble;
	self playrumblelooponentity(localclientnum, self.var_a9757792);
}

/*
	Name: function_732976d8
	Namespace: namespace_964fbfb5
	Checksum: 0x9F48FB87
	Offset: 0x1588
	Size: 0x24C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_732976d8(localclientnum, vehicle)
{
	self notify("45998e3f5e44c183");
	self endon("45998e3f5e44c183");
	self endon(#"death");
	self endon(#"disconnect");
	var_26408b5d = 210 * 210;
	offsetorigin = (0, 0, 210 * 2);
	while(true)
	{
		if(!isdefined(vehicle) || !isinvehicle(localclientnum, vehicle))
		{
			break;
		}
		if(!vehicle function_973c841f(self) && self function_21c0fa55())
		{
			self function_d1731820(localclientnum);
			wait(1);
			continue;
		}
		trace = bullettrace(vehicle.origin, vehicle.origin - offsetorigin, 0, vehicle, 1);
		distsqr = distancesquared(vehicle.origin, trace[#"position"]);
		if(trace[#"fraction"] == 1)
		{
			self function_d1731820(localclientnum);
			wait(1);
			continue;
		}
		if(distsqr > var_26408b5d)
		{
			self function_d1731820(localclientnum);
			wait(0.2);
			continue;
		}
		self function_ff8d2820(localclientnum, "fallwind_loop_slow");
		wait(0.2);
	}
	self function_d1731820(localclientnum);
}

/*
	Name: field_do_deathfx
	Namespace: namespace_964fbfb5
	Checksum: 0xB3C5CA80
	Offset: 0x17E0
	Size: 0x6C
	Parameters: 7
	Flags: Linked, Private
*/
function private field_do_deathfx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self util::playfxontag(localclientnum, "vehicle/fx8_vdest_heli_fuselage_destroyed", self, "tag_origin");
	}
}

/*
	Name: function_de69d
	Namespace: namespace_964fbfb5
	Checksum: 0x4E684A1D
	Offset: 0x1858
	Size: 0x6C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_de69d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self util::playfxontag(localclientnum, "vehicle/fx8_vdest_mil_tank_turret_destroyed", self, "tag_turret_animate");
	}
}

/*
	Name: function_b4806ee
	Namespace: namespace_964fbfb5
	Checksum: 0x46C66858
	Offset: 0x18D0
	Size: 0x11A
	Parameters: 7
	Flags: Linked, Private
*/
function private function_b4806ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.settings) && isdefined(self.scriptbundlesettings))
	{
		self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
	}
	if(isdefined(self.var_ec515b18))
	{
		stopfx(localclientnum, self.var_ec515b18);
		self.var_ec515b18 = undefined;
	}
	if(newval == 1)
	{
		if(isdefined(self.settings) && isdefined(self.settings.var_e90e82ca))
		{
			self.var_ec515b18 = self util::playfxontag(localclientnum, self.settings.var_e90e82ca, self, "tag_gunner_flash1");
		}
	}
}

/*
	Name: function_a998aede
	Namespace: namespace_964fbfb5
	Checksum: 0x1F75ED9E
	Offset: 0x19F8
	Size: 0xB2
	Parameters: 7
	Flags: Linked, Private
*/
function private function_a998aede(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_a9203a35))
		{
			stopfx(localclientnum, self.var_a9203a35);
			self.var_a9203a35 = undefined;
		}
		if(isdefined(self))
		{
			self.var_a9203a35 = self util::playfxontag(localclientnum, "vehicle/fx8_replacer_car_spawn", self, "tag_origin");
		}
	}
}

/*
	Name: function_8fd2e04f
	Namespace: namespace_964fbfb5
	Checksum: 0xF7BD962F
	Offset: 0x1AB8
	Size: 0x278
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8fd2e04f(localclientnum)
{
	while(true)
	{
		if(isarray(level.allvehicles))
		{
			player = function_5c10bd79(localclientnum);
			playfx = isdefined(player) && isalive(player) && player function_3ec2efae(localclientnum);
			foreach(vehicle in level.allvehicles)
			{
				var_5d188f8a = 0;
				foreach(occupant in vehicle getvehoccupants(localclientnum))
				{
					if(util::function_fbce7263(occupant.team, player.team))
					{
						var_5d188f8a = 1;
						break;
					}
				}
				if(playfx && vehicle.scriptvehicletype === "player_muscle" && var_5d188f8a)
				{
					if(!isdefined(vehicle.var_2dc49011))
					{
						vehicle.var_2dc49011 = vehicle util::playfxontag(localclientnum, #"hash_77086882cbd57674", vehicle, "tag_origin");
					}
					continue;
				}
				if(isdefined(vehicle.var_2dc49011))
				{
					stopfx(localclientnum, vehicle.var_2dc49011);
					vehicle.var_2dc49011 = undefined;
				}
			}
		}
		wait(0.2);
	}
}

