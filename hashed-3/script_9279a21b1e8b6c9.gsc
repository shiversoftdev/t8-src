// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_55e622b35104ba68;
#using script_d43f0658aa1a5e5;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_c2bb938a;

/*
	Name: function_89f2df9
	Namespace: namespace_c2bb938a
	Checksum: 0xA14848F7
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_258dcc370de6f9c5", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c2bb938a
	Checksum: 0x1B328FBD
	Offset: 0x218
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::function_98a0917d(&function_98a0917d);
	level.var_30813b9c = spawnstruct();
}

/*
	Name: function_98a0917d
	Namespace: namespace_c2bb938a
	Checksum: 0xBF1C3FA7
	Offset: 0x260
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_98a0917d()
{
	level thread function_3d39c260();
	/#
		level thread function_a6eac3b7();
	#/
}

/*
	Name: function_3d39c260
	Namespace: namespace_c2bb938a
	Checksum: 0x239FB679
	Offset: 0x2A0
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_3d39c260()
{
	if(level.numlives == 1)
	{
		return;
	}
	var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
	if(var_7eb8f61a != 0)
	{
		return;
	}
	if(infection::function_74650d7())
	{
		return;
	}
	var_f8d960b2 = 0.6;
	height = 30000;
	center = (0, 0, height);
	radius = function_cf96c89c() * var_f8d960b2;
	vehicle = function_d5d96302(center, radius);
	if(!isdefined(vehicle))
	{
		return;
	}
	level.var_30813b9c.vehicle = vehicle;
	vehicle thread function_14f79b33(center, radius, height, var_f8d960b2);
	level.var_30813b9c.cameraent = function_15e6e9ae(vehicle);
	level thread function_eb815c5();
}

/*
	Name: function_a20b914d
	Namespace: namespace_c2bb938a
	Checksum: 0xC1816E70
	Offset: 0x448
	Size: 0x76
	Parameters: 2
	Flags: Linked
*/
function function_a20b914d(var_c164cd96, circle_radius)
{
	angles = (0, randomint(360), 0);
	direction = anglestoforward(angles);
	spawn_origin = var_c164cd96 - (direction * circle_radius);
	return spawn_origin;
}

/*
	Name: function_cf96c89c
	Namespace: namespace_c2bb938a
	Checksum: 0xF42BD201
	Offset: 0x4C8
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function function_cf96c89c()
{
	minimaporigins = getentarray("map_corner", "targetname");
	if(minimaporigins.size)
	{
		x = abs(minimaporigins[0].origin[0] - minimaporigins[1].origin[0]);
		y = abs(minimaporigins[0].origin[1] - minimaporigins[1].origin[1]);
		return min(x, y);
	}
	return 0;
}

/*
	Name: function_ab9a60c8
	Namespace: namespace_c2bb938a
	Checksum: 0x8AADD829
	Offset: 0x5B0
	Size: 0xBE
	Parameters: 2
	Flags: Linked
*/
function function_ab9a60c8(center, radius)
{
	origin = function_a20b914d(center, radius);
	left = vectornormalize(origin - center);
	forward = vectorcross(left, (0, 0, 1));
	angles = vectortoangles(forward);
	self.origin = origin;
	self.angles = angles;
}

/*
	Name: function_d5d96302
	Namespace: namespace_c2bb938a
	Checksum: 0x35F9828
	Offset: 0x678
	Size: 0x140
	Parameters: 2
	Flags: Linked
*/
function function_d5d96302(center, radius)
{
	spawner = getent("chinook_spawner", "targetname");
	if(!isdefined(spawner))
	{
		return;
	}
	/#
		while(getplayers().size == 0)
		{
			wait(0.5);
		}
	#/
	vehicle = spawner spawnfromspawner("insertion_plane", 1, 1);
	vehicle.takedamage = 0;
	vehicle setneargoalnotifydist(512);
	vehicle clientfield::set("infiltration_landing_gear", 1);
	vehicle setrotorspeed(1);
	vehicle setspeedimmediate(100);
	vehicle function_ab9a60c8(center, radius);
	return vehicle;
}

/*
	Name: function_15e6e9ae
	Namespace: namespace_c2bb938a
	Checksum: 0x49F21B55
	Offset: 0x7C0
	Size: 0x80
	Parameters: 1
	Flags: Linked
*/
function function_15e6e9ae(vehicle)
{
	camera = namespace_67838d10::function_57fe9b21(level.insertion, vehicle.origin);
	camera.origin = vehicle.origin;
	camera.angles = vehicle.angles;
	camera linkto(vehicle);
	return camera;
}

/*
	Name: function_521bff14
	Namespace: namespace_c2bb938a
	Checksum: 0x679FF605
	Offset: 0x848
	Size: 0x250
	Parameters: 3
	Flags: Linked, Private
*/
function private function_521bff14(center, goal, var_e294ac7d)
{
	direction = goal - center;
	steps = int(length(direction) / 5000);
	direction = vectornormalize(direction);
	var_3d4c4e94 = namespace_67838d10::function_f31cf3bb(center, direction, 5000, 0, steps);
	if(!isdefined(var_3d4c4e94))
	{
		var_3d4c4e94 = center;
	}
	if(distance2dsquared(goal, var_3d4c4e94) > 0.01 * 0.01)
	{
		delta = var_3d4c4e94 - center;
		length = length(delta);
		direction = vectornormalize(delta);
		new_point = center + (direction * (length * var_e294ac7d));
		/#
			var_ced865d2 = center + (direction * length);
			thread namespace_67838d10::debug_line(center, new_point, (1, 0, 0), level.var_30813b9c.debug_duration);
			thread namespace_67838d10::debug_line(new_point, var_ced865d2, (0, 1, 1), level.var_30813b9c.debug_duration);
			thread namespace_67838d10::debug_line(var_ced865d2, goal, (1, 0, 1), level.var_30813b9c.debug_duration);
		#/
		return new_point;
	}
	/#
		thread namespace_67838d10::debug_line(center, goal, (1, 0, 0), level.var_30813b9c.debug_duration);
	#/
	return goal;
}

/*
	Name: function_8ea9be1c
	Namespace: namespace_c2bb938a
	Checksum: 0xD9B829B6
	Offset: 0xAA0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_8ea9be1c()
{
	if(!isdefined(level.var_30813b9c.vehicle))
	{
		return;
	}
	level.var_30813b9c.vehicle function_beba57b9(30000);
}

/*
	Name: function_beba57b9
	Namespace: namespace_c2bb938a
	Checksum: 0x851E7854
	Offset: 0xAF0
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_beba57b9(height)
{
	var_e8a39fb = function_cf96c89c();
	goal = (rotatepoint((1, 0, 0), (0, randomint(360), 0)) * var_e8a39fb) * 2;
	goal = (goal[0], goal[1], height);
	self function_a57c34b7(goal, 0, 0);
}

/*
	Name: function_14f79b33
	Namespace: namespace_c2bb938a
	Checksum: 0x9C8D0DC6
	Offset: 0xBA8
	Size: 0x306
	Parameters: 4
	Flags: Linked, Private
*/
function private function_14f79b33(center, radius, height, var_e294ac7d)
{
	self endon(#"death");
	var_5d59bc67 = 1760;
	time_step = 5;
	while(true)
	{
		if(!isdefined(level.deathcircle))
		{
			var_c164cd96 = center;
			circle_radius = radius;
		}
		else
		{
			var_c164cd96 = (level.deathcircle.origin[0], level.deathcircle.origin[1], height);
			circle_radius = level.deathcircle.radius * var_e294ac7d;
		}
		if(circle_radius < 0.01)
		{
			self function_beba57b9(height);
			return;
		}
		/#
			level.var_30813b9c.debug_duration = 1000;
			thread namespace_67838d10::debug_line(var_c164cd96, level.var_30813b9c.vehicle.origin, (0, 0, 1), level.var_30813b9c.debug_duration);
		#/
		var_9c068ab1 = vectornormalize(level.var_30813b9c.vehicle.origin - var_c164cd96);
		var_c40f2e06 = vectortoangles(var_9c068ab1);
		var_1288d4ef = var_c40f2e06[1];
		var_c5a2c1c9 = (var_5d59bc67 / circle_radius) * 57.29578;
		new_yaw = var_1288d4ef + (time_step * var_c5a2c1c9);
		new_angles = (0, new_yaw, 0);
		goal = var_c164cd96 + (anglestoforward(new_angles) * circle_radius);
		goal = function_521bff14(var_c164cd96, goal, var_e294ac7d);
		/#
			thread namespace_67838d10::debug_line(level.var_30813b9c.vehicle.origin, goal, (0, 1, 0), level.var_30813b9c.debug_duration);
		#/
		self function_a57c34b7(goal, 0, 0);
		self waittill(#"goal", #"near_goal");
	}
}

/*
	Name: function_4f356be
	Namespace: namespace_c2bb938a
	Checksum: 0x6E81239A
	Offset: 0xEB8
	Size: 0x1AA
	Parameters: 4
	Flags: Private
*/
function private function_4f356be(start, end, offset, var_3a5f8906)
{
	self endon(#"death");
	self function_a57c34b7(end, 0, 0);
	distance = distance(end, start);
	var_27dfb385 = int(distance / 5000);
	remainingdist = int(distance) % 5000;
	for(i = 1; i <= var_27dfb385; i++)
	{
		self pathvariableoffset((offset, offset, offset) * ((var_27dfb385 - i) + 1), var_3a5f8906);
		self namespace_67838d10::function_85635daf(start, distance, (i * 5000) / distance);
	}
	if(remainingdist > 0)
	{
		self pathvariableoffset((offset, offset, offset), var_3a5f8906);
	}
	self waittill(#"goal", #"near_goal");
}

/*
	Name: function_b24f3a72
	Namespace: namespace_c2bb938a
	Checksum: 0xA7F0244A
	Offset: 0x1070
	Size: 0xF4
	Parameters: 3
	Flags: Linked
*/
function function_b24f3a72(origin, radius, height)
{
	point = self.origin;
	distance = distance2d(point, origin);
	if(distance == 0)
	{
		return origin;
	}
	angle = cos(radius / distance);
	vec = vectornormalize(point - origin);
	goal = rotatepoint(vec, (0, angle, 0)) * radius;
	return (goal[0], goal[1], height);
}

/*
	Name: function_8655661f
	Namespace: namespace_c2bb938a
	Checksum: 0xA19D72A0
	Offset: 0x1170
	Size: 0xCA
	Parameters: 2
	Flags: None
*/
function function_8655661f(var_555c9c6, height)
{
	if(!isdefined(level.deathcircle))
	{
		return self function_b24f3a72((0, 0, height), 50000 * var_555c9c6, height);
	}
	origin = (level.deathcircle.origin[0], level.deathcircle.origin[1], height);
	goal = self function_b24f3a72(origin, level.deathcircle.radius * var_555c9c6, height);
	return goal;
}

/*
	Name: function_b2df2693
	Namespace: namespace_c2bb938a
	Checksum: 0xD9B84E83
	Offset: 0x1248
	Size: 0x230
	Parameters: 0
	Flags: Linked
*/
function function_b2df2693()
{
	var_48bc2733 = [];
	foreach(team in level.teams)
	{
		if(isdefined(level.alivecount) && isdefined(level.alivecount[team]) && level.alivecount[team] > 0)
		{
			players = getplayers(team);
			var_2a8c2091 = 0;
			foreach(player in players)
			{
				if(isalive(player) && player.sessionstate == "playing")
				{
					var_2a8c2091 = 1;
					break;
				}
			}
			if(var_2a8c2091 == 0)
			{
				continue;
			}
			foreach(player in players)
			{
				if(!isalive(player) || player.sessionstate != "playing")
				{
					var_48bc2733[var_48bc2733.size] = player;
				}
			}
		}
	}
	return var_48bc2733;
}

/*
	Name: function_c3ab4925
	Namespace: namespace_c2bb938a
	Checksum: 0x7D7E69FF
	Offset: 0x1480
	Size: 0xF4
	Parameters: 0
	Flags: Private
*/
function private function_c3ab4925()
{
	self.var_97b0977 = 0;
	self setactionslot(3, "");
	self setactionslot(4, "");
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	self flagsys::clear(#"hash_224cb97b8f682317");
	self flagsys::clear(#"hash_287397edba8966f9");
	self function_c62b5591();
	if(isbot(self))
	{
		self namespace_dec014ed::function_d7ba3d0b();
	}
}

/*
	Name: function_564e0871
	Namespace: namespace_c2bb938a
	Checksum: 0x87063971
	Offset: 0x1580
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_564e0871()
{
	self.var_97b0977 = 0;
	self setactionslot(3, "");
	self setactionslot(4, "");
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	self flagsys::clear(#"hash_224cb97b8f682317");
	self flagsys::set(#"hash_287397edba8966f9");
	self function_c62b5591();
	if(isbot(self))
	{
		self namespace_dec014ed::function_d7ba3d0b();
	}
}

/*
	Name: function_acdf637e
	Namespace: namespace_c2bb938a
	Checksum: 0xAB1DB769
	Offset: 0x1680
	Size: 0xC8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_acdf637e()
{
	if((isdefined(getgametypesetting(#"hash_4149d5d65eb07138")) ? getgametypesetting(#"hash_4149d5d65eb07138") : 0) || (isdefined(getgametypesetting(#"hash_24918193d72a5866")) ? getgametypesetting(#"hash_24918193d72a5866") : 0))
	{
		if(isdefined(level.var_317fb13c))
		{
			self thread [[level.var_317fb13c]]();
		}
	}
}

/*
	Name: function_c62b5591
	Namespace: namespace_c2bb938a
	Checksum: 0xE155C26E
	Offset: 0x1750
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c62b5591()
{
	if(isdefined(level.var_30813b9c) && isdefined(level.var_30813b9c.cameraent))
	{
		level.var_30813b9c.cameraent clientfield::set("infiltration_plane", namespace_67838d10::function_1e4302d0(1, level.insertion.index));
		level.var_30813b9c.cameraent clientfield::set("infiltration_ent", namespace_67838d10::function_1e4302d0(1, level.insertion.index));
		level.var_30813b9c.cameraent setvisibletoplayer(self);
	}
	self namespace_67838d10::function_aa4e9db8();
}

/*
	Name: function_402101af
	Namespace: namespace_c2bb938a
	Checksum: 0xA2A0C9FC
	Offset: 0x1868
	Size: 0x6C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_402101af()
{
	if(isdefined(level.var_30813b9c) && isdefined(level.var_30813b9c.cameraent))
	{
		level.var_30813b9c.cameraent setinvisibletoplayer(self);
	}
	self namespace_67838d10::function_af096637();
}

/*
	Name: function_eb815c5
	Namespace: namespace_c2bb938a
	Checksum: 0xCF8B7F0B
	Offset: 0x18E0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_eb815c5()
{
	if(isdefined(level.var_30813b9c) && isdefined(level.var_30813b9c.cameraent))
	{
		level.var_30813b9c.cameraent clientfield::set("infiltration_camera", namespace_67838d10::function_1e4302d0(2, level.insertion.index));
	}
	level callback::add_callback(#"hash_74b19f5972b0ee52", &function_6198f712);
}

/*
	Name: function_6198f712
	Namespace: namespace_c2bb938a
	Checksum: 0x7E004278
	Offset: 0x1998
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6198f712(eventstruct)
{
	if(isdefined(eventstruct.player))
	{
		eventstruct.player function_402101af();
	}
}

/*
	Name: function_218283c4
	Namespace: namespace_c2bb938a
	Checksum: 0x6C0D7C89
	Offset: 0x19D8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_218283c4()
{
	self luinotifyevent(#"hash_175f8739ed7a932", 0);
}

/*
	Name: function_de24c569
	Namespace: namespace_c2bb938a
	Checksum: 0x350FA098
	Offset: 0x1A08
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_de24c569()
{
	namespace_67838d10::function_a5fd9aa8(level.insertion);
	foreach(player in level.insertion.players)
	{
		player function_218283c4();
	}
}

/*
	Name: function_f9348c1d
	Namespace: namespace_c2bb938a
	Checksum: 0xBF7E9E5F
	Offset: 0x1AB0
	Size: 0xCA
	Parameters: 0
	Flags: Linked
*/
function function_f9348c1d()
{
	var_483315f7 = (0, 0, 0);
	if(isdefined(level.deathcircle))
	{
		var_483315f7 = level.deathcircle.origin;
	}
	angles = (0, 0, 0);
	if(isdefined(level.var_30813b9c) && isdefined(level.var_30813b9c.vehicle))
	{
		var_9c068ab1 = vectornormalize(var_483315f7 - level.var_30813b9c.vehicle.origin);
		angles = vectortoangles(var_9c068ab1);
	}
	return angles;
}

/*
	Name: function_39a51e47
	Namespace: namespace_c2bb938a
	Checksum: 0x1A118C1E
	Offset: 0x1B88
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_39a51e47()
{
	self endon(#"disconnect");
	if(!isdefined(level.var_fc14f773))
	{
		self thread namespace_67838d10::function_77132caf();
		self function_acdf637e();
		return;
	}
	var_8c305d53 = self function_5425f45d();
	if(var_8c305d53)
	{
		self function_acdf637e();
		self thread namespace_67838d10::function_f2867466();
	}
	else
	{
		self thread namespace_67838d10::function_77132caf();
		self function_acdf637e();
	}
}

/*
	Name: function_3c4884f1
	Namespace: namespace_c2bb938a
	Checksum: 0x6CB3857C
	Offset: 0x1C70
	Size: 0x25C
	Parameters: 1
	Flags: Linked
*/
function function_3c4884f1(var_819e1b79)
{
	self endon(#"disconnect");
	targetorigin = self.lastdeathpos;
	angles = undefined;
	players = [];
	foreach(player in getplayers(self.team))
	{
		if(player != self && isalive(player))
		{
			players[players.size] = player;
		}
	}
	if(players.size > 0)
	{
		targetplayer = players[randomint(players.size)];
		targetorigin = player.origin;
		targetangles = player.angles;
	}
	else if(isdefined(self.lastdeathpos))
	{
		targetorigin = self.lastdeathpos;
		if(isdefined(level.deathcircle))
		{
			targetangles = vectortoangles(level.deathcircle.origin - targetorigin);
		}
		else
		{
			targetangles = self.angles;
		}
	}
	if(isdefined(targetorigin))
	{
		fwd = anglestoforward(targetangles);
		spawnorigin = (targetorigin - (fwd * 1000)) + vectorscale((0, 0, 1), 500);
		self setorigin(spawnorigin);
		self namespace_67838d10::start_freefall(fwd * 1000, 0);
	}
	self function_acdf637e();
}

/*
	Name: function_584c9f1
	Namespace: namespace_c2bb938a
	Checksum: 0x2EA005A5
	Offset: 0x1ED8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_584c9f1()
{
	self endon(#"disconnect");
	/#
		while(!isdefined(level.var_30813b9c.vehicle))
		{
			waitframe(1);
		}
	#/
	if(!isdefined(level.var_30813b9c.vehicle))
	{
		self thread namespace_67838d10::function_77132caf();
		return;
	}
	var_c40f2e06 = function_f9348c1d();
	self function_564e0871();
	self namespace_67838d10::function_f795bf83(level.insertion, level.var_30813b9c.vehicle, var_c40f2e06[1]);
	self setplayerangles(var_c40f2e06);
	self function_acdf637e();
}

/*
	Name: function_836fe662
	Namespace: namespace_c2bb938a
	Checksum: 0x1A05E14F
	Offset: 0x1FF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_836fe662()
{
	wait(1);
	if(isdefined(level.var_52b56362))
	{
		level clientfield::set_world_uimodel("hudItems.warzone.reinsertionIndex", level.var_52b56362 + 1);
	}
	else
	{
		level clientfield::set_world_uimodel("hudItems.warzone.reinsertionIndex", 0);
	}
}

/*
	Name: function_fec68e5c
	Namespace: namespace_c2bb938a
	Checksum: 0xF7EC324E
	Offset: 0x2060
	Size: 0x5BC
	Parameters: 0
	Flags: Linked
*/
function function_fec68e5c()
{
	var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
	/#
		if(getdvarint(#"hash_6fd0fd3292f07618", 0))
		{
			level.insertion.players = arraycopy(function_b2df2693());
			foreach(player in level.insertion.players)
			{
				player.var_c5134737 = 1;
				player thread [[level.spawnclient]]();
				if(isdefined(player.lastdeathpos))
				{
					player setorigin(player.lastdeathpos);
				}
			}
			return;
		}
	#/
	if(!isdefined(level.insertion) || (!(isdefined(level.insertion.allowed) && level.insertion.allowed)))
	{
		return;
	}
	level thread function_836fe662();
	namespace_67838d10::function_ff107056(level.insertion);
	level.insertion.players = arraycopy(function_b2df2693());
	level thread function_de24c569();
	wait(0.5 + 0.1);
	namespace_67838d10::function_a5fd9aa8(level.insertion);
	foreach(player in level.insertion.players)
	{
		player.var_c5134737 = 1;
		player thread [[level.spawnclient]]();
		player namespace_67838d10::function_b9a53f50();
	}
	level.insertion flagsys::set(#"hash_5a3e17fbc33cdc86");
	level.insertion flagsys::wait_till_timeout((1 + 2.5) + 0.5, #"hash_3dc9cb68998d9dfd");
	level.var_30813b9c.vehicle namespace_67838d10::function_bc16f3b4(level.insertion);
	/#
		assert(10 > 0);
	#/
	wait(10);
	foreach(player in level.insertion.players)
	{
		if(!isdefined(player) || (isdefined(player.var_97b0977) && player.var_97b0977))
		{
			continue;
		}
		player clientfield::set_to_player("infiltration_final_warning", 1);
	}
	wait(5);
	namespace_67838d10::function_a5fd9aa8(level.insertion);
	foreach(player in level.insertion.players)
	{
		if(!isdefined(player) || (isdefined(player.var_97b0977) && player.var_97b0977))
		{
			continue;
		}
		player flagsys::set(#"hash_224cb97b8f682317");
		player flagsys::set(#"hash_287397edba8966f9");
	}
	wait(1);
	level.var_30813b9c.vehicle clientfield::set("infiltration_transport", 0);
}

/*
	Name: function_5425f45d
	Namespace: namespace_c2bb938a
	Checksum: 0xB72829F3
	Offset: 0x2628
	Size: 0x302
	Parameters: 0
	Flags: Linked
*/
function function_5425f45d()
{
	if(isdefined(level.deathcircle) && isdefined(level.var_fb91af8) && isdefined(level.var_52b56362))
	{
		var_d89a84b0 = level.var_fb91af8.size - 1;
		step_height = 20000 / var_d89a84b0;
		height_diff = level.var_52b56362 * step_height;
		center = level.deathcircle.origin;
		radius = level.deathcircle.radius * 0.5;
		angle = 0;
		var_180a7b48 = self namespace_67838d10::function_ec7cfdb();
		portal = level.var_fc14f773[var_180a7b48];
		if(isdefined(portal) && isdefined(portal.var_8c9cad0b))
		{
			angle = (isdefined(portal.var_8c9cad0b) ? portal.var_8c9cad0b : 0);
			x_pos = center[0] + (radius * cos(angle));
			y_pos = center[1] + (radius * sin(angle));
			height = 20000 - height_diff;
			var_636e904a = math::clamp(height, 12000, 20000);
			if(level.var_52b56362 == var_d89a84b0)
			{
				height = 12000;
			}
			portal.origin = (x_pos, y_pos, var_636e904a);
			var_10fdb78b = level.var_52b56362 + 1;
			var_b0221a68 = math::clamp(var_10fdb78b, 0, var_d89a84b0);
			var_7aec140c = level.var_fb91af8[var_b0221a68];
			if(isdefined(var_7aec140c))
			{
				target = var_7aec140c.origin - portal.origin;
				target = vectornormalize(target);
				angles = vectortoangles(target);
				portal.angles = angles;
			}
			return true;
		}
		return false;
	}
	return false;
}

/*
	Name: function_a6eac3b7
	Namespace: namespace_c2bb938a
	Checksum: 0x57AD3E39
	Offset: 0x2938
	Size: 0x7E
	Parameters: 0
	Flags: Private
*/
function private function_a6eac3b7()
{
	/#
		while(true)
		{
			if(getdvar(#"hash_3fb4a63926f3fa15", 0) > 0)
			{
				function_9536aa3d();
				setdvar(#"hash_3fb4a63926f3fa15", "");
			}
			waitframe(1);
		}
	#/
}

/*
	Name: function_9536aa3d
	Namespace: namespace_c2bb938a
	Checksum: 0xA4778DEC
	Offset: 0x29C0
	Size: 0x3A8
	Parameters: 0
	Flags: None
*/
function function_9536aa3d()
{
	/#
		var_269add6e = [];
		var_ef4e0b0 = [];
		foreach(team in level.teams)
		{
			var_d3934390 = 0;
			players_on_team = array::randomize(getplayers(team));
			foreach(person in players_on_team)
			{
				if(!isalive(person) || person laststand::player_is_in_laststand())
				{
					continue;
				}
				if(var_d3934390 == 0)
				{
					var_d3934390 = 1;
					var_269add6e[var_269add6e.size] = person;
					continue;
				}
				var_ef4e0b0[var_ef4e0b0.size] = person;
			}
		}
		foreach(not in var_ef4e0b0)
		{
			if(var_269add6e.size)
			{
				killer = var_269add6e[randomint(var_269add6e.size)];
			}
			else
			{
				killer = not;
			}
			not thread function_c833e81f(killer);
		}
		center = (0, 0, 0);
		radius = 500;
		if(isdefined(level.deathcircle))
		{
			center = level.deathcircle.origin;
			radius = level.deathcircle.radius * 0.5;
		}
		foreach(lucky in var_269add6e)
		{
			spawn_point = rotatepoint((radius, 0, 0), (0, randomint(360), 0));
			lucky setorigin((center + spawn_point) + vectorscale((0, 0, 1), 20000));
			lucky function_2ffa8aaf(1, (0, 0, 0), 0);
		}
	#/
}

/*
	Name: function_c833e81f
	Namespace: namespace_c2bb938a
	Checksum: 0x2ED98599
	Offset: 0x2D70
	Size: 0x84
	Parameters: 1
	Flags: Private
*/
function private function_c833e81f(killer)
{
	/#
		self endon(#"disconnect");
		self dodamage(self.health + 10000, self.origin + (0, 0, 1), killer);
		wait(1);
		self dodamage(self.health + 10000, self.origin + (0, 0, 1), killer);
	#/
}

