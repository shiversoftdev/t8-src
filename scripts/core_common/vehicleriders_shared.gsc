// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\hostmigration_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace vehicle;

/*
	Name: init
	Namespace: vehicle
	Checksum: 0xD1A24E75
	Offset: 0x218
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
autoexec function init()
{
	function_d64f1d30();
	callback::on_vehicle_spawned(&on_vehicle_spawned);
	callback::on_vehicle_killed(&on_vehicle_killed);
}

/*
	Name: function_d64f1d30
	Namespace: vehicle
	Checksum: 0x4B46CF70
	Offset: 0x278
	Size: 0x270
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d64f1d30()
{
	a_registered_fields = [];
	foreach(bundle in struct::get_script_bundles("vehicleriders"))
	{
		foreach(object in bundle.objects)
		{
			if(isdefined(object.vehicleenteranim))
			{
				array::add(a_registered_fields, object.position + "_enter", 0);
			}
			if(isdefined(object.vehicleexitanim))
			{
				array::add(a_registered_fields, object.position + "_exit", 0);
			}
			if(isdefined(object.vehiclecloseanim))
			{
				array::add(a_registered_fields, object.position + "_close", 0);
			}
			if(isdefined(object.vehicleriderdeathanim))
			{
				array::add(a_registered_fields, object.position + "_death", 0);
			}
		}
	}
	foreach(str_clientfield in a_registered_fields)
	{
		clientfield::register("vehicle", str_clientfield, 1, 1, "counter");
	}
}

/*
	Name: function_196797c9
	Namespace: vehicle
	Checksum: 0xC606949F
	Offset: 0x4F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_196797c9(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	if(isdefined(vehicle.vehicleridersbundle))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_810a3de5
	Namespace: vehicle
	Checksum: 0xB25143C
	Offset: 0x548
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_810a3de5(vehicle)
{
}

/*
	Name: function_41cf7b1d
	Namespace: vehicle
	Checksum: 0xE5A923DC
	Offset: 0x560
	Size: 0xF0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_41cf7b1d(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	var_4301b21d = function_999240f5(vehicle);
	bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
	for(seat = 0; seat < var_4301b21d; seat++)
	{
		position = bundle.objects[seat].position;
		if(issubstr(position, "driver"))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_f7ce77b
	Namespace: vehicle
	Checksum: 0x664C819
	Offset: 0x658
	Size: 0xE6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f7ce77b(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	var_4301b21d = function_999240f5(vehicle);
	bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
	for(seat = 0; seat < var_4301b21d; seat++)
	{
		position = bundle.objects[seat].position;
		if(position == "passenger1")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_2453a4a2
	Namespace: vehicle
	Checksum: 0x7F9B887E
	Offset: 0x748
	Size: 0xE6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2453a4a2(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	var_4301b21d = function_999240f5(vehicle);
	bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
	for(seat = 0; seat < var_4301b21d; seat++)
	{
		position = bundle.objects[seat].position;
		if(position == "gunner1")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_72b503cc
	Namespace: vehicle
	Checksum: 0x2569E966
	Offset: 0x838
	Size: 0xFA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_72b503cc(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	var_4301b21d = function_999240f5(vehicle);
	var_3acc1a95 = 0;
	bundle = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle);
	for(seat = 0; seat < var_4301b21d; seat++)
	{
		position = bundle.objects[seat].position;
		if(issubstr(position, "crew"))
		{
			var_3acc1a95++;
		}
	}
	return var_3acc1a95;
}

/*
	Name: function_999240f5
	Namespace: vehicle
	Checksum: 0x309B2800
	Offset: 0x940
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_999240f5(vehicle)
{
	/#
		assert(isvehicle(vehicle));
	#/
	if(!function_196797c9(vehicle))
	{
		return 0;
	}
	/#
		assert(isdefined(vehicle.vehicleridersbundle));
	#/
	var_4301b21d = struct::get_script_bundle("vehicleriders", vehicle.vehicleridersbundle).var_4301b21d;
	if(isdefined(var_4301b21d))
	{
		return var_4301b21d;
	}
	return 0;
}

#namespace namespace_358332cc;

/*
	Name: __constructor
	Namespace: namespace_358332cc
	Checksum: 0x96B9AB5E
	Offset: 0xA00
	Size: 0x4A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.riders = [];
	self.var_4301b21d = 0;
	self.var_3acc1a95 = 0;
	self.var_9e2a2132 = 0;
	self.var_709c0a6f = 0;
	self.var_dad0959b = 0;
}

/*
	Name: __destructor
	Namespace: namespace_358332cc
	Checksum: 0x80F724D1
	Offset: 0xA58
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace vehicle;

/*
	Name: function_358332cc
	Namespace: vehicle
	Checksum: 0x9E288A4A
	Offset: 0xA68
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_358332cc()
{
	classes.var_358332cc[0] = spawnstruct();
	classes.var_358332cc[0].__vtable[913321084] = &namespace_358332cc::__destructor;
	classes.var_358332cc[0].__vtable[674154906] = &namespace_358332cc::__constructor;
}

/*
	Name: on_vehicle_spawned
	Namespace: vehicle
	Checksum: 0xA960864C
	Offset: 0xAF8
	Size: 0x448
	Parameters: 0
	Flags: Linked, Private
*/
private function on_vehicle_spawned()
{
	/#
		assert(isvehicle(self));
	#/
	if(!function_196797c9(self))
	{
		return;
	}
	function_810a3de5(self);
	var_4301b21d = function_999240f5(self);
	if(!isdefined(var_4301b21d) || var_4301b21d <= 0)
	{
		return;
	}
	object = new var_358332cc();
	[[ object ]]->__constructor();
	self.var_761c973 = object;
	self.var_761c973.riders = [];
	self.var_761c973.var_4301b21d = var_4301b21d;
	self flag::init("driver_occupied", 0);
	self flag::init("passenger1_occupied", 0);
	self flag::init("gunner1_occupied", 0);
	if(function_41cf7b1d(self))
	{
		self.var_761c973.var_9e2a2132 = 1;
	}
	if(function_f7ce77b(self))
	{
		self.var_761c973.var_709c0a6f = 1;
	}
	if(function_2453a4a2(self))
	{
		self.var_761c973.var_dad0959b = 1;
	}
	var_3acc1a95 = function_72b503cc(self);
	self.var_761c973.var_3acc1a95 = var_3acc1a95;
	for(position = 1; position <= 9; position++)
	{
		flag::init(("crew" + position) + "_occupied", 0);
	}
	if(isdefined(self.script_vehicleride))
	{
		a_spawners = getactorspawnerarray(self.script_vehicleride, "script_vehicleride");
		foreach(sp in a_spawners)
		{
			if(isdefined(sp))
			{
				if(self.spawner !== sp)
				{
					ai_rider = sp spawner::spawn(1);
					if(isdefined(ai_rider))
					{
						seat = undefined;
						if(isdefined(ai_rider.script_startingposition) && ai_rider.script_startingposition != "undefined")
						{
							seat = ai_rider.script_startingposition;
							if(issubstr(seat, "crew"))
							{
								seat = "crew";
							}
							else if(issubstr(seat, "pass"))
							{
								seat = "passenger1";
							}
							else if(issubstr(seat, "driver"))
							{
								seat = "driver";
							}
							else
							{
								seat = undefined;
							}
							if(isdefined(seat))
							{
								ai_rider get_in(ai_rider, self, seat, 1);
							}
							continue;
						}
						ai_rider get_in(ai_rider, self, undefined, 1);
					}
				}
			}
		}
	}
}

/*
	Name: function_e1008fbd
	Namespace: vehicle
	Checksum: 0x82C65603
	Offset: 0xF48
	Size: 0xE6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e1008fbd(vehicle)
{
	/#
		assert(isdefined(vehicle));
	#/
	/#
		assert(isdefined(vehicle.var_761c973));
	#/
	/#
		assert(isdefined(vehicle.var_761c973.var_3acc1a95));
	#/
	for(position = 1; position <= vehicle.var_761c973.var_3acc1a95; position++)
	{
		if(!vehicle flag::get(("crew" + position) + "_occupied"))
		{
			return "crew" + position;
		}
	}
	return "none";
}

/*
	Name: function_2cec1af6
	Namespace: vehicle
	Checksum: 0xF720F08A
	Offset: 0x1038
	Size: 0xA4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2cec1af6(vehicle, seat)
{
	flag = seat + "_occupied";
	/#
		assert(vehicle flag::exists(flag));
	#/
	/#
		assert(!vehicle flag::get(flag));
	#/
	vehicle flag::set(flag);
}

/*
	Name: function_2e28cc0
	Namespace: vehicle
	Checksum: 0x351B14C7
	Offset: 0x10E8
	Size: 0xA4
	Parameters: 2
	Flags: Private
*/
private function function_2e28cc0(vehicle, seat)
{
	flag = seat + "_occupied";
	/#
		assert(vehicle flag::exists(flag));
	#/
	/#
		assert(!vehicle flag::get(flag));
	#/
	vehicle flag::clear(flag);
}

/*
	Name: get_human_bundle
	Namespace: vehicle
	Checksum: 0x64B69C6A
	Offset: 0x1198
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function get_human_bundle(assertifneeded = 1)
{
	if(assertifneeded)
	{
		/#
			assert(isdefined(self.vehicleridersbundle), "");
		#/
	}
	return struct::get_script_bundle("vehicleriders", self.vehicleridersbundle);
}

/*
	Name: get_robot_bundle
	Namespace: vehicle
	Checksum: 0xB0BA09FA
	Offset: 0x1210
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function get_robot_bundle(assertifneeded = 1)
{
	if(assertifneeded)
	{
		/#
			assert(isdefined(self.vehicleridersrobotbundle), "");
		#/
	}
	return struct::get_script_bundle("vehicleriders", self.vehicleridersrobotbundle);
}

/*
	Name: get_warlord_bundle
	Namespace: vehicle
	Checksum: 0xEE3CB2DD
	Offset: 0x1288
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function get_warlord_bundle(assertifneeded = 1)
{
	if(assertifneeded)
	{
		/#
			assert(isdefined(self.vehicleriderswarlordbundle), "");
		#/
	}
	return struct::get_script_bundle("vehicleriders", self.vehicleriderswarlordbundle);
}

/*
	Name: function_e84837df
	Namespace: vehicle
	Checksum: 0x89ED7695
	Offset: 0x1300
	Size: 0x142
	Parameters: 2
	Flags: Linked, Private
*/
private function function_e84837df(ai, vehicle)
{
	/#
		assert(isactor(ai));
	#/
	/#
		assert(isdefined(ai.archetype));
	#/
	/#
		assert(function_196797c9(vehicle));
	#/
	if(ai.archetype == #"robot")
	{
		return vehicle get_robot_bundle();
	}
	if(ai.archetype == #"warlord")
	{
		return vehicle get_warlord_bundle();
	}
	/#
		assert(ai.archetype == #"human", "" + ai.archetype);
	#/
	return vehicle get_human_bundle();
}

/*
	Name: function_b9342b7d
	Namespace: vehicle
	Checksum: 0x1DDEAE75
	Offset: 0x1450
	Size: 0xEE
	Parameters: 3
	Flags: Linked
*/
function function_b9342b7d(ai, vehicle, seat)
{
	/#
		assert(isactor(ai));
	#/
	bundle = undefined;
	bundle = vehicle function_e84837df(ai, vehicle);
	foreach(s_rider in bundle.objects)
	{
		if(s_rider.position == seat)
		{
			return s_rider;
		}
	}
}

/*
	Name: function_3eb6760
	Namespace: vehicle
	Checksum: 0x9DBBAE75
	Offset: 0x1548
	Size: 0x26C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_3eb6760(ai, vehicle, seat)
{
	/#
		assert(isdefined(vehicle));
	#/
	/#
		assert(isactor(ai));
	#/
	/#
		assert(!isdefined(ai.var_ec30f5da));
	#/
	ai.var_ec30f5da = function_b9342b7d(ai, vehicle, seat);
	ai.vehicle = vehicle;
	ai.var_5574287b = seat;
	if(isdefined(ai.var_ec30f5da.rideanim) && !isanimlooping(ai.var_ec30f5da.rideanim))
	{
		/#
			/#
				assertmsg((("" + seat) + "") + function_9e72a96(ai.vehicle.vehicletype) + "");
			#/
		#/
	}
	if(isdefined(ai.var_ec30f5da.aligntag) && !isdefined(ai.vehicle gettagorigin(ai.var_ec30f5da.aligntag)))
	{
		/#
			/#
				assertmsg((((("" + seat) + "") + function_9e72a96(ai.vehicle.vehicletype) + "") + ai.var_ec30f5da.aligntag) + "");
			#/
		#/
	}
	ai flag::init("in_vehicle");
	ai flag::init("riding_vehicle");
}

/*
	Name: fill_riders
	Namespace: vehicle
	Checksum: 0xC552485A
	Offset: 0x17C0
	Size: 0x48E
	Parameters: 3
	Flags: None
*/
function fill_riders(a_ai, vehicle, seat)
{
	/#
		assert(isvehicle(vehicle));
	#/
	if(!function_196797c9(vehicle))
	{
		/#
			/#
				assertmsg(("" + function_9e72a96(vehicle.vehicletype)) + "");
			#/
		#/
		return;
	}
	if(isdefined(seat))
	{
		/#
			assert(seat == "" || seat == "" || seat == "");
		#/
	}
	else
	{
		seat = "all";
	}
	if(!isalive(vehicle))
	{
		return;
	}
	a_ai_remaining = arraycopy(a_ai);
	switch(seat)
	{
		case "driver":
		{
			if(get_in(a_ai[0], vehicle, "driver", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[0]);
			}
			break;
		}
		case "passenger1":
		{
			if(get_in(a_ai[0], vehicle, "passenger1", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[0]);
			}
			break;
		}
		case "gunner1":
		{
			if(get_in(a_ai[0], vehicle, "gunner1", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[0]);
			}
			break;
		}
		case "crew":
		{
			foreach(ai in a_ai)
			{
				if(get_in(ai, vehicle, "crew", 0))
				{
					arrayremovevalue(a_ai_remaining, ai);
				}
			}
			break;
		}
		case "all":
		{
			index = 0;
			if(get_in(a_ai[index], vehicle, "driver", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[index]);
				index++;
			}
			if(get_in(a_ai[index], vehicle, "passenger1", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[index]);
				index++;
			}
			for(i = index; i < a_ai.size; i++)
			{
				if(get_in(a_ai[index], vehicle, "crew", 0))
				{
					arrayremovevalue(a_ai_remaining, a_ai[index]);
					index++;
				}
			}
			if(get_in(a_ai[index], vehicle, "gunner1", 0))
			{
				arrayremovevalue(a_ai_remaining, a_ai[index]);
			}
			break;
		}
	}
	return a_ai_remaining;
}

/*
	Name: unload
	Namespace: vehicle
	Checksum: 0x43EC07A3
	Offset: 0x1C58
	Size: 0x322
	Parameters: 1
	Flags: Linked
*/
function unload(seat)
{
	/#
		assert(isvehicle(self));
	#/
	if(!function_196797c9(self))
	{
		/#
			/#
				assertmsg(("" + function_9e72a96(self.vehicletype)) + "");
			#/
		#/
		return;
	}
	if(isdefined(seat) && seat != "undefined")
	{
		if(seat == "passengers")
		{
			seat = "passenger1";
		}
		else if(seat == "gunners")
		{
			seat = "gunner1";
		}
		/#
			assert(seat == "" || seat == "" || seat == "" || seat == "" || seat == "");
		#/
	}
	else
	{
		seat = "all";
	}
	if(!isdefined(self.var_761c973.riders))
	{
		return;
	}
	self.var_761c973.riders = array::remove_undefined(self.var_761c973.riders, 1);
	if(self.var_761c973.riders.size <= 0)
	{
		return;
	}
	var_4301b21d = self.var_761c973.var_4301b21d;
	/#
		assert(var_4301b21d > 0);
	#/
	switch(seat)
	{
		case "driver":
		{
			function_114d7bd3(self);
			break;
		}
		case "passenger1":
		{
			function_b56639f2(self);
			break;
		}
		case "gunner1":
		{
			function_2ef91b74(self);
			break;
		}
		case "crew":
		{
			function_2ca26543(self);
			break;
		}
		default:
		{
			function_114d7bd3(self);
			function_b56639f2(self);
			function_2ca26543(self);
			function_2ef91b74(self);
			break;
		}
	}
}

/*
	Name: function_114d7bd3
	Namespace: vehicle
	Checksum: 0xB176B39A
	Offset: 0x1F88
	Size: 0x1D4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_114d7bd3(vehicle)
{
	if(!vehicle.var_761c973.var_9e2a2132)
	{
		return;
	}
	if(vehicle flag::get("driver_occupied") && isdefined(vehicle.var_761c973.riders[#"driver"]) && isalive(vehicle.var_761c973.riders[#"driver"]))
	{
		ai = vehicle.var_761c973.riders[#"driver"];
		/#
			assert(ai flag::get(""));
		#/
		var_64bd966f = undefined;
		if(isdefined(ai.var_ec30f5da.vehiclecloseanim))
		{
			var_64bd966f = ai.var_ec30f5da.vehiclecloseanim;
		}
		ai get_out(vehicle, ai, "driver");
		if(isdefined(var_64bd966f) && isdefined(vehicle))
		{
			vehicle clientfield::increment("driver" + "_close", 1);
			vehicle setanim(var_64bd966f, 1, 0, 1);
		}
	}
}

/*
	Name: function_b56639f2
	Namespace: vehicle
	Checksum: 0xA1B7CECA
	Offset: 0x2168
	Size: 0x1D4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b56639f2(vehicle)
{
	if(!vehicle.var_761c973.var_709c0a6f)
	{
		return;
	}
	if(vehicle flag::get("passenger1_occupied") && isdefined(vehicle.var_761c973.riders[#"passenger1"]) && isalive(vehicle.var_761c973.riders[#"passenger1"]))
	{
		ai = vehicle.var_761c973.riders[#"passenger1"];
		/#
			assert(ai flag::get(""));
		#/
		var_64bd966f = undefined;
		if(isdefined(ai.var_ec30f5da.vehiclecloseanim))
		{
			var_64bd966f = ai.var_ec30f5da.vehiclecloseanim;
		}
		ai get_out(vehicle, ai, "passenger1");
		if(isdefined(var_64bd966f) && isdefined(vehicle))
		{
			vehicle clientfield::increment("passenger1" + "_close", 1);
			vehicle setanim(var_64bd966f, 1, 0, 1);
		}
	}
}

/*
	Name: function_2ef91b74
	Namespace: vehicle
	Checksum: 0x76EDBF39
	Offset: 0x2348
	Size: 0x1D4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2ef91b74(vehicle)
{
	if(!vehicle.var_761c973.var_dad0959b)
	{
		return;
	}
	if(vehicle flag::get("gunner1_occupied") && isdefined(vehicle.var_761c973.riders[#"gunner1"]) && isalive(vehicle.var_761c973.riders[#"gunner1"]))
	{
		ai = vehicle.var_761c973.riders[#"gunner1"];
		/#
			assert(ai flag::get(""));
		#/
		var_64bd966f = undefined;
		if(isdefined(ai.var_ec30f5da.vehiclecloseanim))
		{
			var_64bd966f = ai.var_ec30f5da.vehiclecloseanim;
		}
		ai get_out(vehicle, ai, "gunner1");
		if(isdefined(var_64bd966f) && isdefined(vehicle))
		{
			vehicle clientfield::increment("gunner1" + "_close", 1);
			vehicle setanim(var_64bd966f, 1, 0, 1);
		}
	}
}

/*
	Name: function_2ca26543
	Namespace: vehicle
	Checksum: 0x1A61A6F6
	Offset: 0x2528
	Size: 0x374
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2ca26543(vehicle)
{
	/#
		assert(isdefined(vehicle.var_761c973.var_4301b21d) && vehicle.var_761c973.var_4301b21d > 0);
	#/
	if(!isdefined(vehicle.var_761c973.var_3acc1a95))
	{
		return;
	}
	if(vehicle.var_761c973.var_3acc1a95 <= 0)
	{
		return;
	}
	var_681d39ad = [];
	var_91b346cc = undefined;
	n_crew_door_close_position = undefined;
	for(position = 1; position <= vehicle.var_761c973.var_3acc1a95; position++)
	{
		seat = "crew" + position;
		flag = seat + "_occupied";
		if(vehicle flag::get(flag) && isdefined(vehicle.var_761c973.riders[seat]) && isalive(vehicle.var_761c973.riders[seat]))
		{
			ai = vehicle.var_761c973.riders[seat];
			/#
				assert(ai flag::get(""));
			#/
			if(!isdefined(var_91b346cc))
			{
				if(isdefined(ai.var_ec30f5da.vehiclecloseanim))
				{
					n_crew_door_close_position = seat;
					var_91b346cc = ai.var_ec30f5da.vehiclecloseanim;
				}
			}
			ai thread get_out(vehicle, vehicle.var_761c973.riders[seat], seat);
			array::add(var_681d39ad, ai);
		}
	}
	if(var_681d39ad.size > 0)
	{
		timeout = vehicle.unloadtimeout;
		array::wait_till(var_681d39ad, "exited_vehicle");
		array::flagsys_wait_clear(var_681d39ad, "in_vehicle", (isdefined(timeout) ? timeout : 4));
		if(isdefined(vehicle))
		{
			vehicle notify(#"unload", var_681d39ad);
			vehicle remove_riders_after_wait(vehicle, var_681d39ad);
		}
	}
	if(isdefined(var_91b346cc) && isdefined(vehicle))
	{
		vehicle clientfield::increment(n_crew_door_close_position + "_close", 1);
		vehicle setanim(var_91b346cc, 1, 0, 1);
	}
}

/*
	Name: get_out
	Namespace: vehicle
	Checksum: 0x4A16EE5D
	Offset: 0x28A8
	Size: 0x458
	Parameters: 3
	Flags: Linked
*/
function get_out(vehicle, ai, seat)
{
	/#
		assert(isdefined(ai));
	#/
	/#
		assert(isalive(ai), "");
	#/
	/#
		assert(isactor(ai), "");
	#/
	/#
		assert(isdefined(ai.vehicle), "");
	#/
	/#
		assert(isdefined(ai.var_ec30f5da));
	#/
	/#
		assert(seat == "" || seat == "" || issubstr(seat, "") || seat == "");
	#/
	ai notify(#"exiting_vehicle");
	if(isdefined(ai.var_ec30f5da.vehicleexitanim))
	{
		ai.vehicle clientfield::increment(ai.var_ec30f5da.position + "_exit", 1);
		ai.vehicle setanim(ai.var_ec30f5da.vehicleexitanim, 1, 0, 1);
	}
	if(isdefined(vehicle) && isalive(vehicle))
	{
		switch(seat)
		{
			case "driver":
			{
				vehicle flag::clear("driver_occupied");
				break;
			}
			case "passenger1":
			{
				vehicle flag::clear("passenger1_occupied");
				break;
			}
			case "gunner1":
			{
				vehicle flag::clear("gunner1_occupied");
				break;
			}
			case "crew":
			{
				seat = "crew" + seat;
				flag = seat + "_occupied";
				vehicle flag::clear(flag);
				break;
			}
		}
	}
	str_mode = "ground";
	if(vehicle.vehicleclass === "helicopter")
	{
		str_mode = "variable";
	}
	switch(str_mode)
	{
		case "ground":
		{
			exit_ground(ai);
			break;
		}
		case "variable":
		{
			exit_variable(ai);
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
			return;
		}
	}
	if(isdefined(ai))
	{
		ai flag::clear("in_vehicle");
		ai flag::clear("riding_vehicle");
		ai.vehicle = undefined;
		ai.var_ec30f5da = undefined;
		ai animation::set_death_anim(undefined);
		ai notify(#"exited_vehicle");
	}
}

/*
	Name: exit_ground
	Namespace: vehicle
	Checksum: 0xE3348436
	Offset: 0x2D08
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function exit_ground(ai)
{
	/#
		assert(isdefined(ai));
	#/
	ai endon(#"death");
	if(!isdefined(self.var_ec30f5da.exitgrounddeathanim))
	{
		ai thread ragdoll_dead_exit_rider(ai);
	}
	else
	{
		ai animation::set_death_anim(ai.var_ec30f5da.exitgrounddeathanim);
	}
	/#
		assert(isdefined(ai.var_ec30f5da.exitgroundanim), ("" + ai.var_ec30f5da.position) + "");
	#/
	if(isdefined(ai.var_ec30f5da.exitgroundanim))
	{
		animation::play(ai.var_ec30f5da.exitgroundanim, ai.vehicle, ai.var_ec30f5da.aligntag);
	}
}

/*
	Name: remove_riders_after_wait
	Namespace: vehicle
	Checksum: 0x2930376E
	Offset: 0x2E50
	Size: 0xF8
	Parameters: 2
	Flags: Linked
*/
function remove_riders_after_wait(vehicle, a_riders_to_remove)
{
	/#
		assert(isdefined(vehicle) && isdefined(a_riders_to_remove));
	#/
	/#
		assert(isdefined(vehicle.var_761c973.riders));
	#/
	if(isdefined(a_riders_to_remove))
	{
		foreach(ai in a_riders_to_remove)
		{
			arrayremovevalue(vehicle.var_761c973.riders, ai, 1);
		}
	}
}

/*
	Name: handle_falling_death
	Namespace: vehicle
	Checksum: 0x4E3D7B8D
	Offset: 0x2F50
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
private function handle_falling_death()
{
	self endon(#"landed");
	self waittill(#"death");
	if(isactor(self))
	{
		self unlink();
		self startragdoll();
	}
}

/*
	Name: ragdoll_dead_exit_rider
	Namespace: vehicle
	Checksum: 0x60AFAD7E
	Offset: 0x2FC8
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function ragdoll_dead_exit_rider(ai)
{
	/#
		assert(isactor(ai));
	#/
	ai endon(#"exited_vehicle");
	ai waittill(#"death");
	if(isdefined(ai) && !ai isragdoll())
	{
		ai unlink();
		ai startragdoll();
	}
	ai notify(#"exited_vehicle");
}

/*
	Name: forward_euler_integration
	Namespace: vehicle
	Checksum: 0x1ECB034
	Offset: 0x3098
	Size: 0x180
	Parameters: 3
	Flags: Linked, Private
*/
private function forward_euler_integration(e_move, v_target_landing, n_initial_speed)
{
	landed = 0;
	position = self.origin;
	velocity = (0, 0, n_initial_speed * -1);
	gravity = vectorscale((0, 0, -1), 385.8);
	while(!landed)
	{
		previousposition = position;
		velocity = velocity + (gravity * 0.1);
		position = position + (velocity * 0.1);
		if((position[2] + (velocity[2] * 0.1)) <= v_target_landing[2])
		{
			landed = 1;
			position = v_target_landing;
		}
		/#
			recordline(previousposition, position, (1, 0.5, 0), "", self);
		#/
		hostmigration::waittillhostmigrationdone();
		e_move moveto(position, 0.1);
		if(!landed)
		{
			wait(0.1);
		}
	}
}

/*
	Name: exit_variable
	Namespace: vehicle
	Checksum: 0xB1DD1608
	Offset: 0x3220
	Size: 0x540
	Parameters: 1
	Flags: Linked
*/
function exit_variable(ai)
{
	/#
		assert(isdefined(ai));
	#/
	ai endon(#"death");
	ai notify(#"exiting_vehicle");
	ai thread handle_falling_death();
	ai animation::set_death_anim(ai.var_ec30f5da.exithighdeathanim);
	/#
		assert(isdefined(ai.var_ec30f5da.exithighanim), ("" + ai.var_ec30f5da.position) + "");
	#/
	animation::play(ai.var_ec30f5da.exithighanim, ai.vehicle, ai.var_ec30f5da.aligntag, 1, 0, 0);
	ai animation::set_death_anim(ai.var_ec30f5da.exithighloopdeathanim);
	n_cur_height = get_height(ai.vehicle);
	bundle = ai.vehicle function_e84837df(ai, ai.vehicle);
	n_target_height = bundle.highexitlandheight;
	if(isdefined(ai.var_ec30f5da.dropundervehicleorigin) && ai.var_ec30f5da.dropundervehicleorigin || (isdefined(ai.dropundervehicleoriginoverride) && ai.dropundervehicleoriginoverride))
	{
		v_target_landing = (ai.vehicle.origin[0], ai.vehicle.origin[1], (ai.origin[2] - n_cur_height) + n_target_height);
	}
	else
	{
		v_target_landing = (ai.origin[0], ai.origin[1], (ai.origin[2] - n_cur_height) + n_target_height);
	}
	if(isdefined(ai.overridedropposition))
	{
		v_target_landing = (ai.overridedropposition[0], ai.overridedropposition[1], v_target_landing[2]);
	}
	if(isdefined(ai.targetangles))
	{
		angles = ai.targetangles;
	}
	else
	{
		angles = ai.angles;
	}
	e_move = util::spawn_model("tag_origin", ai.origin, angles);
	ai thread exit_high_loop_anim(e_move);
	distance = n_target_height - n_cur_height;
	initialspeed = bundle.dropspeed;
	n_fall_time = (initialspeed * -1) + (sqrt(pow(initialspeed, 2) - ((2 * 385.8) * distance))) / 385.8;
	ai notify(#"falling", {#fall_time:n_fall_time});
	forward_euler_integration(e_move, v_target_landing, bundle.dropspeed);
	e_move waittill(#"movedone");
	ai notify(#"landing");
	ai animation::set_death_anim(ai.var_ec30f5da.exithighlanddeathanim);
	animation::play(ai.var_ec30f5da.exithighlandanim, e_move, "tag_origin");
	ai notify(#"landed");
	ai unlink();
	waitframe(1);
	e_move delete();
	ai notify(#"exited_vehicle");
}

/*
	Name: exit_high_loop_anim
	Namespace: vehicle
	Checksum: 0xFE9CD87E
	Offset: 0x3768
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function exit_high_loop_anim(e_parent)
{
	self endon(#"death", #"landing");
	while(true)
	{
		animation::play(self.var_ec30f5da.exithighloopanim, e_parent, "tag_origin");
	}
}

/*
	Name: get_height
	Namespace: vehicle
	Checksum: 0x503EA0DD
	Offset: 0x37D8
	Size: 0xEA
	Parameters: 1
	Flags: Linked
*/
function get_height(e_ignore = self)
{
	trace = groundtrace(self.origin + (0, 0, 10), self.origin + (vectorscale((0, 0, -1), 10000)), 0, e_ignore, 0);
	/#
		recordline(self.origin + (0, 0, 10), trace[#"position"], (1, 0.5, 0), "", self);
	#/
	return distance(self.origin, trace[#"position"]);
}

/*
	Name: get_in
	Namespace: vehicle
	Checksum: 0x52DE5FF1
	Offset: 0x38D0
	Size: 0x6D8
	Parameters: 4
	Flags: Linked
*/
function get_in(ai, vehicle, seat, var_7c3e4d44 = 1)
{
	vehicle endon(#"death");
	if(!isdefined(ai))
	{
		return 0;
	}
	if(!isdefined(seat) || seat == "undefined")
	{
		if(vehicle.var_761c973.var_9e2a2132 && !vehicle flag::get("driver_occupied"))
		{
			seat = "driver";
		}
		else if(vehicle.var_761c973.var_709c0a6f && !vehicle flag::get("passenger1_occupied"))
		{
			seat = "passenger1";
		}
		else
		{
			seat = "crew";
		}
	}
	/#
		assert(isactor(ai));
	#/
	/#
		assert(isdefined(seat) && (seat == "" || seat == "" || seat == ""));
	#/
	switch(seat)
	{
		case "driver":
		{
			if(vehicle.var_761c973.var_9e2a2132 && vehicle flag::get("driver_occupied"))
			{
				/#
					if(var_7c3e4d44)
					{
						/#
							assertmsg(("" + function_9e72a96(vehicle.vehicletype)) + "");
						#/
					}
				#/
				return 0;
			}
			function_3eb6760(ai, vehicle, "driver");
			break;
		}
		case "passenger1":
		{
			if(vehicle.var_761c973.var_709c0a6f && vehicle flag::get("passenger1_occupied"))
			{
				/#
					if(var_7c3e4d44)
					{
						/#
							assertmsg(("" + function_9e72a96(vehicle.vehicletype)) + "");
						#/
					}
				#/
				return 0;
			}
			function_3eb6760(ai, vehicle, "passenger1");
			break;
		}
		case "gunner1":
		{
			if(vehicle.var_761c973.var_dad0959b && vehicle flag::get("gunner1_occupied"))
			{
				/#
					if(var_7c3e4d44)
					{
						/#
							assertmsg(("" + function_9e72a96(vehicle.vehicletype)) + "");
						#/
					}
				#/
				return 0;
			}
			function_3eb6760(ai, vehicle, "gunner1");
			break;
		}
		default:
		{
			var_b11e7fca = function_e1008fbd(vehicle);
			if(var_b11e7fca == "none")
			{
				/#
					if(var_7c3e4d44)
					{
						/#
							assertmsg(("" + function_9e72a96(vehicle.vehicletype)) + "");
						#/
					}
				#/
				return 0;
			}
			function_3eb6760(ai, vehicle, var_b11e7fca);
			seat = var_b11e7fca;
			break;
		}
	}
	/#
		assert(isdefined(ai.var_ec30f5da));
	#/
	/#
		assert(isdefined(ai.vehicle));
	#/
	if(!isdefined(ai.var_ec30f5da.rideanim))
	{
		/#
			/#
				assertmsg(((("" + seat) + "") + function_9e72a96(vehicle.vehicletype) + "") + function_e84837df(ai, vehicle));
			#/
		#/
		return;
	}
	/#
		assert(isdefined(vehicle.var_761c973.riders));
	#/
	/#
		assert(!isdefined(vehicle.var_761c973.riders[seat]));
	#/
	vehicle.var_761c973.riders[seat] = ai;
	if(seat != "none")
	{
		function_2cec1af6(vehicle, seat);
	}
	ai flag::set("in_vehicle");
	ai flag::set("riding_vehicle");
	ai thread animation::play(ai.var_ec30f5da.rideanim, ai.vehicle, ai.var_ec30f5da.aligntag, 1, 0.2, 0.2, 0, 0, 0, 0);
	ai thread handle_rider_death(ai, vehicle);
	return 1;
}

/*
	Name: handle_rider_death
	Namespace: vehicle
	Checksum: 0x1B3B09F2
	Offset: 0x3FB0
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
private function handle_rider_death(ai, vehicle)
{
	ai endon(#"death", #"exiting_vehicle");
	vehicle endon(#"death");
	/#
		assert(isdefined(ai.var_ec30f5da));
	#/
	if(isdefined(ai.var_ec30f5da.ridedeathanim))
	{
		ai animation::set_death_anim(ai.var_ec30f5da.ridedeathanim);
	}
	callback::on_ai_killed(&function_15dbe5e9);
}

/*
	Name: function_15dbe5e9
	Namespace: vehicle
	Checksum: 0xB51AB4B4
	Offset: 0x4090
	Size: 0xEC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_15dbe5e9(params)
{
	if(self flag::exists("riding_vehicle") && self flag::get("riding_vehicle") && isdefined(self.vehicle) && isdefined(self.var_ec30f5da) && isdefined(self.var_ec30f5da.vehicleriderdeathanim))
	{
		self.vehicle clientfield::increment(self.var_ec30f5da.position + "_death", 1);
		self.vehicle setanimknobrestart(self.var_ec30f5da.vehicleriderdeathanim, 1, 0, 1);
	}
}

/*
	Name: on_vehicle_killed
	Namespace: vehicle
	Checksum: 0x9BF25C82
	Offset: 0x4188
	Size: 0xA8
	Parameters: 0
	Flags: Linked, Private
*/
private function on_vehicle_killed()
{
	if(!isdefined(self.var_761c973))
	{
		return;
	}
	if(!isdefined(self.var_761c973.riders))
	{
		return;
	}
	foreach(rider in self.var_761c973.riders)
	{
		kill_rider(rider);
	}
}

/*
	Name: kill_rider
	Namespace: vehicle
	Checksum: 0xABC1A7B4
	Offset: 0x4238
	Size: 0x17C
	Parameters: 1
	Flags: Linked
*/
function kill_rider(entity)
{
	if(isdefined(entity))
	{
		if(isalive(entity) && !gibserverutils::isgibbed(entity, 2))
		{
			if(entity isplayinganimscripted())
			{
				entity stopanimscripted();
			}
			if(getdvarint(#"tu1_vehicleridersinvincibility", 1))
			{
				util::stop_magic_bullet_shield(entity);
			}
			gibserverutils::gibleftarm(entity);
			gibserverutils::gibrightarm(entity);
			gibserverutils::giblegs(entity);
			gibserverutils::annihilate(entity);
			entity unlink();
			entity kill();
		}
		entity ghost();
		level thread delete_rider_asap(entity);
	}
}

/*
	Name: delete_rider_asap
	Namespace: vehicle
	Checksum: 0x65934EFD
	Offset: 0x43C0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function delete_rider_asap(entity)
{
	waitframe(1);
	if(isdefined(entity))
	{
		entity delete();
	}
}

/*
	Name: function_86c7bebb
	Namespace: vehicle
	Checksum: 0x76704F85
	Offset: 0x43F8
	Size: 0x2DE
	Parameters: 1
	Flags: None
*/
function function_86c7bebb(seat = "all")
{
	/#
		assert(isdefined(self) && isvehicle(self) && isdefined(seat));
	#/
	ais = [];
	if(!isdefined(self.var_761c973))
	{
		return ais;
	}
	if(!isdefined(self.var_761c973.riders))
	{
		return ais;
	}
	if(isdefined(seat))
	{
		if(seat == "passengers")
		{
			seat = "passenger1";
		}
		else if(seat == "gunners")
		{
			seat = "gunner1";
		}
		/#
			assert(seat == "" || seat == "" || seat == "" || seat == "" || seat == "");
		#/
	}
	else
	{
		seat = "all";
	}
	if(isdefined(self.var_761c973.riders))
	{
		if(seat == "all")
		{
			foreach(ai in self.var_761c973.riders)
			{
				if(isdefined(ai) && isalive(ai))
				{
					ais[ais.size] = ai;
				}
			}
			return ais;
		}
		foreach(ai in self.var_761c973.riders)
		{
			if(isdefined(ai) && isalive(ai) && ai.var_5574287b === seat)
			{
				ais[ais.size] = ai;
			}
		}
		return ais;
	}
	return ais;
}

