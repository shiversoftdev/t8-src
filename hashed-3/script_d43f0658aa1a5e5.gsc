// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_55e622b35104ba68;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_dec014ed;

/*
	Name: function_89f2df9
	Namespace: namespace_dec014ed
	Checksum: 0x18E12932
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_9ecdbde5a95aedc", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_dec014ed
	Checksum: 0x55A6953F
	Offset: 0xF0
	Size: 0x34
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::add_callback(#"freefall", &function_c9a18304);
}

/*
	Name: function_b7de760d
	Namespace: namespace_dec014ed
	Checksum: 0x31DAD41A
	Offset: 0x130
	Size: 0xF8
	Parameters: 0
	Flags: Private
*/
private function function_b7de760d()
{
	foreach(insertion in level.insertions)
	{
		namespace_67838d10::function_a5fd9aa8(insertion);
		foreach(player in insertion.players)
		{
			if(player == self)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_58a44f22
	Namespace: namespace_dec014ed
	Checksum: 0xA8BD51CF
	Offset: 0x230
	Size: 0xD4
	Parameters: 0
	Flags: Private
*/
private function function_58a44f22()
{
	teammates = getplayers(self.team);
	foreach(player in teammates)
	{
		if(isplayer(player) && !isbot(player) && player function_b7de760d())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_9ea8f9d6
	Namespace: namespace_dec014ed
	Checksum: 0x816C810D
	Offset: 0x310
	Size: 0xD4
	Parameters: 0
	Flags: Private
*/
private function function_9ea8f9d6()
{
	teammates = getplayers(self.team);
	foreach(player in teammates)
	{
		if(isplayer(player) && !isbot(player) && player function_b7de760d())
		{
			return player;
		}
	}
	return undefined;
}

/*
	Name: function_a4f516ef
	Namespace: namespace_dec014ed
	Checksum: 0xA241D258
	Offset: 0x3F0
	Size: 0x1A4
	Parameters: 0
	Flags: None
*/
function function_a4f516ef()
{
	self endon(#"death", #"disconnect");
	/#
		if(getdvarint(#"hash_6fd0fd3292f07618", 0))
		{
			return;
		}
	#/
	if(!self flagsys::get(#"hash_287397edba8966f9"))
	{
		var_f9664338 = [1:#"hash_224cb97b8f682317", 0:#"hash_287397edba8966f9"];
		self flagsys::wait_till_any(var_f9664338);
	}
	if(function_58a44f22())
	{
		waitresult = undefined;
		waitresult = self waittill(#"hash_3a41cbe85bdb81e1", #"hash_224cb97b8f682317");
		if(waitresult._notify != #"hash_224cb97b8f682317")
		{
			self flagsys::wait_till_timeout(function_8ed212d(), #"hash_224cb97b8f682317");
		}
	}
	else
	{
		/#
			assert(isdefined(self.var_33a2e995));
		#/
		self flagsys::wait_till_timeout(self.var_33a2e995, #"hash_224cb97b8f682317");
	}
}

/*
	Name: function_2ed2a1bb
	Namespace: namespace_dec014ed
	Checksum: 0xD902E9A
	Offset: 0x5A0
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_2ed2a1bb(max)
{
	random = randomfloat(1);
	return ((random * random) * random) * max;
}

/*
	Name: function_9526ce62
	Namespace: namespace_dec014ed
	Checksum: 0xB2D175BC
	Offset: 0x5F0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_9526ce62(max)
{
	return function_2ed2a1bb(max);
}

/*
	Name: function_8ed212d
	Namespace: namespace_dec014ed
	Checksum: 0xE81AA300
	Offset: 0x620
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_8ed212d()
{
	return 1 + function_2ed2a1bb(3);
}

/*
	Name: function_24ca8ecf
	Namespace: namespace_dec014ed
	Checksum: 0xBF32F833
	Offset: 0x650
	Size: 0x326
	Parameters: 1
	Flags: None
*/
function function_24ca8ecf(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	bots = [];
	foreach(player in insertion.players)
	{
		if(isbot(player))
		{
			if(!isdefined(bots[player.team]))
			{
				bots[player.team] = [];
			}
			if(!isdefined(bots[player.team]))
			{
				bots[player.team] = [];
			}
			else if(!isarray(bots[player.team]))
			{
				bots[player.team] = array(bots[player.team]);
			}
			bots[player.team][bots[player.team].size] = player;
		}
	}
	if(!isdefined(insertion.start_point) || !isdefined(insertion.end_point))
	{
		return;
	}
	distance = distance2d(insertion.start_point, insertion.end_point);
	var_5d59bc67 = 2640;
	var_ef4bfcd8 = distance / var_5d59bc67;
	foreach(team in bots)
	{
		var_28cd9792 = function_9526ce62(var_ef4bfcd8);
		foreach(bot in team)
		{
			bot.var_33a2e995 = var_28cd9792 + function_8ed212d();
		}
	}
}

/*
	Name: function_d7ba3d0b
	Namespace: namespace_dec014ed
	Checksum: 0xAB291806
	Offset: 0x980
	Size: 0x32
	Parameters: 0
	Flags: None
*/
function function_d7ba3d0b()
{
	self thread function_39c5371e();
	return function_9526ce62(5);
}

/*
	Name: function_9699dc95
	Namespace: namespace_dec014ed
	Checksum: 0x73E37188
	Offset: 0x9C0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function function_9699dc95()
{
	self thread function_39c5371e();
}

/*
	Name: function_39c5371e
	Namespace: namespace_dec014ed
	Checksum: 0x80F724D1
	Offset: 0x9E8
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_39c5371e()
{
}

/*
	Name: function_8f2f3bcd
	Namespace: namespace_dec014ed
	Checksum: 0xCD1E4FD5
	Offset: 0x9F8
	Size: 0xAA
	Parameters: 0
	Flags: Private
*/
private function function_8f2f3bcd()
{
	center = (0, 0, 0);
	radius = 0;
	if(isdefined(level.deathcircle))
	{
		center = level.deathcircle.origin;
		radius = level.deathcircle.radius * 0.75;
	}
	goal = center + (anglestoforward((0, randomint(360), 0)) * radius);
	return goal;
}

/*
	Name: function_d26744ff
	Namespace: namespace_dec014ed
	Checksum: 0xAC0D3B02
	Offset: 0xAB0
	Size: 0xC4
	Parameters: 2
	Flags: None
*/
function function_d26744ff(target_point, lead_player)
{
	direction = vectornormalize(target_point - self.origin);
	goal_angles = vectortoangles(direction);
	if(goal_angles[0] < 45)
	{
		distance = distance(target_point, self.origin);
		if(distance > 20000)
		{
			goal_angles = (0, goal_angles[1], 0);
		}
	}
	return goal_angles;
}

/*
	Name: function_233a1027
	Namespace: namespace_dec014ed
	Checksum: 0xB8CE5F8E
	Offset: 0xB80
	Size: 0x8E
	Parameters: 2
	Flags: None
*/
function function_233a1027(target_point, lead_player)
{
	if(!isplayer(lead_player))
	{
		return (0, 0, 0);
	}
	if(lead_player isonground())
	{
		return self function_d26744ff(lead_player.origin, lead_player);
	}
	goal_angles = lead_player.angles;
	return goal_angles;
}

/*
	Name: function_13ba9cec
	Namespace: namespace_dec014ed
	Checksum: 0x1356FC0F
	Offset: 0xC18
	Size: 0x1D8
	Parameters: 3
	Flags: None
*/
function function_13ba9cec(target_point, lead_player, var_282c0a8e)
{
	/#
		assert(isdefined(var_282c0a8e));
	#/
	if(self isonground())
	{
		return 0;
	}
	goal_angles = [[var_282c0a8e]](target_point, lead_player);
	var_8fbb46cd = vectornormalize(self getvelocity());
	var_e0db94ca = vectortoangles(var_8fbb46cd);
	angle_delta = goal_angles - var_e0db94ca;
	var_ce2f4ce0 = function_dac81c9a(angleclamp180(angle_delta[0]));
	var_7be00d5e = function_dac81c9a(angleclamp180(angle_delta[1]));
	angles = var_e0db94ca + (var_ce2f4ce0, var_7be00d5e, 0);
	angles = (angleclamp180(angles[0]), angleclamp180(angles[1]), 0);
	self function_c3d37a6d(angles);
	self botsetlookangles(angles);
	return 1;
}

/*
	Name: function_c9a18304
	Namespace: namespace_dec014ed
	Checksum: 0xF7CB0DE4
	Offset: 0xDF8
	Size: 0x244
	Parameters: 1
	Flags: None
*/
function function_c9a18304(params)
{
	if(!isbot(self))
	{
		return;
	}
	if(params.freefall === 1)
	{
		self notify("262092a28e60152c");
		self endon("262092a28e60152c");
		self endon(#"death", #"disconnect");
		waitframe(1);
		self botsetmovemagnitude(1);
		target_point = function_8f2f3bcd();
		direction = vectornormalize(target_point - self.origin);
		angles = vectortoangles(direction);
		angles = (90, angles[1], 0);
		self function_c3d37a6d(angles);
		self botsetlookangles(angles);
		while(true)
		{
			if(length(self getvelocity()) * 0.05681818 > 110)
			{
				break;
			}
			wait(1);
		}
		var_26a66f9d = &function_d26744ff;
		var_2706b530 = function_9ea8f9d6();
		if(isdefined(var_2706b530))
		{
			var_26a66f9d = &function_233a1027;
		}
		while(true)
		{
			if(!self function_13ba9cec(target_point, var_2706b530, var_26a66f9d))
			{
				return;
			}
			waitframe(1);
		}
	}
	else
	{
		self botsetmovemagnitude(0);
	}
}

/*
	Name: function_dac81c9a
	Namespace: namespace_dec014ed
	Checksum: 0x402270FA
	Offset: 0x1048
	Size: 0x92
	Parameters: 1
	Flags: Private
*/
private function function_dac81c9a(angle_delta)
{
	max_delta = getdvarint(#"hash_11e45cd7d81b76c", 30);
	if(angle_delta > 0)
	{
		return math::clamp(max_delta, angle_delta * -1, angle_delta);
	}
	return math::clamp(max_delta * -1, angle_delta, angle_delta * -1);
}

