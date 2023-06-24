// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3bf78bb3042fc0e2;
#using script_429c7c5a289f2b25;
#using scripts\abilities\gadgets\gadget_health_regen.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\bots\bot_insertion.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\death_circle.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_audio.gsc;

#namespace player_insertion;

/*
	Name: __init__system__
	Namespace: player_insertion
	Checksum: 0x450A1EF3
	Offset: 0x638
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"player_insertion", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player_insertion
	Checksum: 0xCBEA1FA5
	Offset: 0x680
	Size: 0x4FC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	var_1194a9a5 = struct::get_array("infil_spawn", "targetname");
	/#
		if(var_1194a9a5.size == 0)
		{
			var_1194a9a5 = struct::get_array("", "");
		}
	#/
	level.insertions = [];
	var_3bc28449 = max((isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1), 1);
	/#
		assert(var_3bc28449 > 0 && var_3bc28449 <= 2);
	#/
	for(index = 0; index < var_3bc28449; index++)
	{
		insertion = {#players:[], #spawnpoints:var_1194a9a5, #allowed:1, #index:index};
		level.insertions[level.insertions.size] = insertion;
		callback::on_finalize_initialization(&on_finalize_initialization, insertion);
	}
	level.insertion = level.insertions[0];
	clientfield::register("vehicle", "infiltration_transport", 1, 1, "int");
	clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int");
	clientfield::register("toplayer", "infiltration_jump_warning", 1, 1, "int");
	clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int");
	clientfield::register("toplayer", "inside_infiltration_vehicle", 1, 1, "int");
	clientfield::register("world", "infiltration_compass", 16000, 2, "int");
	clientfield::register("scriptmover", "infiltration_ent", 16000, 2, "int");
	clientfield::register("scriptmover", "infiltration_plane", 16000, 2, "int");
	clientfield::register("scriptmover", "infiltration_camera", 16000, 3, "int");
	clientfield::register("scriptmover", "infiltration_jump_point", 16000, 2, "int");
	clientfield::register("scriptmover", "infiltration_force_drop_point", 16000, 2, "int");
	clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int");
	clientfield::register("vehicle", "warpportalfx", 15000, 1, "int");
	clientfield::register("vehicle", "warpportalfx_launch", 15000, 1, "counter");
	clientfield::register("toplayer", "warpportal_fx_wormhole", 1, 1, "int");
	level.wingsuit_hud = wz_wingsuit_hud::register("wz_wingsuit_hud");
	/#
		level thread function_943c98fb(level.insertion);
	#/
}

/*
	Name: function_1e4302d0
	Namespace: player_insertion
	Checksum: 0x4C22AD63
	Offset: 0xB88
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function function_1e4302d0(value, index)
{
	/#
		assert(index < 2);
	#/
	newvalue = (value << 1) | (index & 1);
	return newvalue;
}

/*
	Name: function_3ca86964
	Namespace: player_insertion
	Checksum: 0xCC6C4D5B
	Offset: 0xBF0
	Size: 0x17A
	Parameters: 1
	Flags: Linked
*/
function function_3ca86964(var_1d83d08d)
{
	var_6024133d = getentarray("map_corner", "targetname");
	if(var_6024133d.size == 0)
	{
		return;
	}
	mins = vectorscale((-1, -1, 0), 150000);
	maxs = vectorscale((1, 1, 0), 150000);
	o_a = var_6024133d[0].origin;
	o_b = var_6024133d[1].origin;
	mins = (min(o_a[0], o_b[0]), min(o_a[1], o_b[1]), 150000);
	maxs = (max(o_a[0], o_b[0]), max(o_a[1], o_b[1]), 150000);
	return function_24531a26(var_1d83d08d.start, var_1d83d08d.end, mins, maxs);
}

/*
	Name: on_finalize_initialization
	Namespace: player_insertion
	Checksum: 0x2E2EB5E1
	Offset: 0xD78
	Size: 0x23C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_finalize_initialization()
{
	level flagsys::wait_till(#"hash_43bac6444a9b65f3");
	insertion = self;
	/#
		assert(isstruct(insertion));
	#/
	waitframe(1);
	/#
		if(getdvarint(#"scr_disable_infiltration", 0))
		{
			return;
		}
		var_6024133d = getentarray("", "");
		if(var_6024133d.size == 0)
		{
			return;
		}
	#/
	var_3bc28449 = (isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1);
	offsetdistance = (isdefined(getgametypesetting(#"hash_75a36f7e4a81c93")) ? getgametypesetting(#"hash_75a36f7e4a81c93") : 0);
	if(var_3bc28449 > 0 && insertion.index > 0)
	{
		var_df4f7099 = level.insertions[0];
		var_df4f7099 flagsys::wait_till(#"hash_4e5fc66b9144a5c8");
		function_d53a8c5b(insertion, var_df4f7099.fly_over_point, var_df4f7099.var_59526dd5 - 180, offsetdistance);
	}
	else
	{
		function_d53a8c5b(insertion, function_6671872c(), function_45644b08(), offsetdistance);
	}
}

/*
	Name: function_fd3c1bcc
	Namespace: player_insertion
	Checksum: 0xE78994B8
	Offset: 0xFC0
	Size: 0x7A
	Parameters: 3
	Flags: Linked, Private
*/
function private function_fd3c1bcc(start, end, default_val)
{
	trace = worldtrace(start, end);
	if(trace[#"fraction"] < 1)
	{
		return trace[#"position"];
	}
	return default_val;
}

/*
	Name: function_d53a8c5b
	Namespace: player_insertion
	Checksum: 0xA10DE5FA
	Offset: 0x1048
	Size: 0x28C
	Parameters: 4
	Flags: Linked
*/
function function_d53a8c5b(insertion, fly_over_point, var_59526dd5, offset)
{
	/#
		assert(isstruct(insertion));
	#/
	/#
		assert(isvec(fly_over_point));
	#/
	/#
		assert(isint(var_59526dd5) || isfloat(var_59526dd5));
	#/
	insertion.fly_over_point = fly_over_point;
	insertion.var_59526dd5 = var_59526dd5;
	var_872f085f = (0, var_59526dd5, 0);
	direction = anglestoforward(var_872f085f);
	direction = vectornormalize(direction);
	var_7c712437 = fly_over_point + (anglestoright(var_872f085f) * offset);
	var_1d83d08d = {#end:var_7c712437 + (direction * 150000), #start:var_7c712437 + (direction * 150000)};
	result = function_3ca86964(var_1d83d08d);
	midpoint = (result.start + result.end) / 2;
	var_1d83d08d.start = function_fd3c1bcc(midpoint, var_1d83d08d.start, result.start);
	var_1d83d08d.end = function_fd3c1bcc(midpoint, var_1d83d08d.end, result.end);
	fly_path(insertion, var_1d83d08d, var_7c712437, var_59526dd5);
	insertion flagsys::set(#"hash_4e5fc66b9144a5c8");
}

/*
	Name: function_9ddb4115
	Namespace: player_insertion
	Checksum: 0xE790E68E
	Offset: 0x12E0
	Size: 0x28A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9ddb4115(var_1d83d08d)
{
	/#
		assert(isstruct(var_1d83d08d));
	#/
	/#
		assert(isdefined(var_1d83d08d.start));
	#/
	/#
		assert(isdefined(var_1d83d08d.end));
	#/
	if(isdefined(level.deathcircles) && level.deathcircles.size > 0)
	{
		initcircle = level.deathcircles[0];
		var_ddab8e6c = var_1d83d08d.start;
		var_dd00b78e = vectornormalize(var_1d83d08d.end - var_1d83d08d.start);
		var_164fe5c9 = distance2dsquared(var_ddab8e6c, initcircle.origin);
		while(var_164fe5c9 > initcircle.radius * initcircle.radius)
		{
			var_ddab8e6c = var_ddab8e6c + (var_dd00b78e * 1000);
			var_c820832 = distance2dsquared(var_ddab8e6c, initcircle.origin);
			if(var_c820832 > var_164fe5c9)
			{
				break;
			}
			var_164fe5c9 = var_c820832;
		}
		var_1d83d08d.start = var_ddab8e6c;
		var_1b8e09d2 = var_1d83d08d.end;
		var_6d773f9e = var_dd00b78e * -1;
		var_164fe5c9 = distance2dsquared(var_1b8e09d2, initcircle.origin);
		while(var_164fe5c9 > initcircle.radius * initcircle.radius)
		{
			var_1b8e09d2 = var_1b8e09d2 + (var_6d773f9e * 1000);
			var_c820832 = distance2dsquared(var_1b8e09d2, initcircle.origin);
			if(var_c820832 > var_164fe5c9)
			{
				break;
			}
			var_164fe5c9 = var_c820832;
		}
		var_1d83d08d.end = var_1b8e09d2;
	}
}

/*
	Name: fly_path
	Namespace: player_insertion
	Checksum: 0xF54D3E4B
	Offset: 0x1578
	Size: 0x74C
	Parameters: 4
	Flags: Linked
*/
function fly_path(insertion, var_1d83d08d, fly_over_point, var_59526dd5)
{
	/#
		assert(isstruct(insertion));
	#/
	var_872f085f = (0, var_59526dd5, 0);
	direction = anglestoforward(var_872f085f);
	direction = vectornormalize(direction);
	if(isdefined(getgametypesetting(#"hash_82c01ef004ff0a3")) && getgametypesetting(#"hash_82c01ef004ff0a3"))
	{
		function_9ddb4115(var_1d83d08d);
	}
	var_72a7a8ee = function_ea1ad421(insertion, var_1d83d08d.end, var_1d83d08d.start);
	var_309554a1 = function_ea1ad421(insertion, var_1d83d08d.start, var_1d83d08d.end);
	var_7dea5d79 = (isdefined(getgametypesetting(#"wzplayerinsertionstartoffset")) ? getgametypesetting(#"wzplayerinsertionstartoffset") : 5000);
	var_c7ac9056 = (isdefined(getgametypesetting(#"hash_3e8ed24e99b27614")) ? getgametypesetting(#"hash_3e8ed24e99b27614") : 15000);
	var_4c8131f2 = var_72a7a8ee + (var_7dea5d79 * direction);
	var_e0079ca5 = var_309554a1 - (var_c7ac9056 * direction);
	var_5d59bc67 = 2640;
	var_16de3dbd = 10 * var_5d59bc67;
	startpoint = var_4c8131f2 - (var_16de3dbd * direction);
	endpoint = var_e0079ca5 + (100000 * direction);
	/#
		if(getdvarint(#"scr_insertion_debug", 0) == 1)
		{
			offset = vectorscale((0, 0, 1), 300);
			debug_sphere(var_1d83d08d.start + (2 * offset), 45, (0, 1, 1));
			debug_sphere(var_1d83d08d.end + (2 * offset), 45, (1, 1, 0));
			debug_sphere(fly_over_point, 75, (1, 1, 1));
			debug_sphere(var_72a7a8ee, 75, (1, 0, 1));
			debug_sphere(var_309554a1, 75, (0, 1, 0));
			debug_sphere(var_4c8131f2, 75, (1, 0, 0));
			debug_sphere(var_e0079ca5, 75, (0, 0, 0));
			debug_sphere(startpoint, 75, (1, 0.5, 0));
			debug_sphere(endpoint, 75, (1, 0.5, 0));
			debug_line(startpoint, endpoint, (0, 1, 0));
		}
	#/
	var_742f9da2 = distance(startpoint, var_4c8131f2);
	var_f69b665b = distance(startpoint, var_e0079ca5);
	insertion thread function_e04b0ea8(insertion, startpoint, var_872f085f, var_742f9da2, var_f69b665b);
	currentvalue = level clientfield::get("infiltration_compass");
	newvalue = (1 << insertion.index) | currentvalue;
	level clientfield::set("infiltration_compass", newvalue);
	insertion.start_point = startpoint;
	insertion.end_point = endpoint;
	insertion.var_f253731f = var_872f085f;
	insertion.var_37362e08 = var_742f9da2;
	insertion.var_7743b329 = var_f69b665b;
	if(max((isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1), 1) > 1)
	{
		util::wait_network_frame();
		insertion.infilteament = spawn("script_model", (0, 0, 0));
		insertion.infilteament.targetname = "infil_team_ent";
		insertion.infilteament setinvisibletoall();
		activeplayers = util::get_active_players();
		foreach(player in activeplayers)
		{
			if(function_20cba65e(player) == insertion.index)
			{
				function_9368af66(insertion, player);
			}
		}
		callback::on_spawned(&function_1db63266);
	}
}

/*
	Name: function_1db63266
	Namespace: player_insertion
	Checksum: 0x22479F3A
	Offset: 0x1CD0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_1db63266()
{
	/#
		assert(isplayer(self));
	#/
	var_5ed0195b = function_20cba65e(self);
	insertion = level.insertions[var_5ed0195b];
	if(isdefined(insertion) && isdefined(insertion.infilteament))
	{
		function_9368af66(insertion, self);
	}
}

/*
	Name: function_9368af66
	Namespace: player_insertion
	Checksum: 0x7A3A349B
	Offset: 0x1D78
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function function_9368af66(insertion, player)
{
	/#
		assert(isstruct(insertion));
	#/
	/#
		assert(isplayer(player));
	#/
	insertion.infilteament setvisibletoplayer(player);
	insertion.infilteament clientfield::set("infiltration_ent", function_1e4302d0(1, insertion.index));
}

/*
	Name: function_20cba65e
	Namespace: player_insertion
	Checksum: 0xC78CB01B
	Offset: 0x1E48
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function function_20cba65e(player)
{
	/#
		assert(isplayer(player));
	#/
	if(!isdefined(player))
	{
		return 0;
	}
	platoons = array(#"platoon_1", #"platoon_2", #"platoon_3", #"platoon_4", #"platoon_5");
	var_9257bec = [];
	for(index = 0; index < platoons.size; index++)
	{
		var_9257bec[platoons[index]] = index;
	}
	platoon = getteamplatoon(player.team);
	for(index = 0; index < level.insertions.size; index++)
	{
		if(isdefined(var_9257bec[platoon]) && var_9257bec[platoon] == (index % (platoons.size - 1)))
		{
			return index;
		}
	}
	return 0;
}

/*
	Name: function_ea1ad421
	Namespace: player_insertion
	Checksum: 0x4C5BE4FD
	Offset: 0x1FD0
	Size: 0xC0
	Parameters: 3
	Flags: Linked
*/
function function_ea1ad421(insertion, start, end)
{
	/#
		assert(isstruct(insertion));
	#/
	direction = end - start;
	direction = vectornormalize(direction);
	if(oob::chr_party(end))
	{
		point = function_bb2c2f4d(end, direction, 5000, 0);
	}
	if(!isdefined(point))
	{
		return end;
	}
	return point;
}

/*
	Name: function_f31cf3bb
	Namespace: player_insertion
	Checksum: 0x7E5E517E
	Offset: 0x2098
	Size: 0xE8
	Parameters: 5
	Flags: Linked
*/
function function_f31cf3bb(point, direction, step, depth, var_94a1d56d = 10)
{
	var_23685c5 = point;
	while(true)
	{
		if(depth > var_94a1d56d)
		{
			return var_23685c5;
		}
		new_point = var_23685c5 + (direction * step);
		touching = oob::chr_party(new_point);
		/#
		#/
		depth++;
		if(touching)
		{
			return function_f31cf3bb(var_23685c5, direction, step / 2, depth, var_94a1d56d);
		}
		var_23685c5 = new_point;
	}
}

/*
	Name: function_bb2c2f4d
	Namespace: player_insertion
	Checksum: 0x8A34174
	Offset: 0x2188
	Size: 0x108
	Parameters: 4
	Flags: Linked
*/
function function_bb2c2f4d(point, direction, step, depth)
{
	var_6b1f4b9c = point;
	while(true)
	{
		if(depth > 10)
		{
			return undefined;
		}
		new_point = var_6b1f4b9c - (direction * step);
		touching = oob::chr_party(new_point);
		/#
			debug_sphere(new_point - vectorscale((0, 0, 1), 300), 45, (touching ? (1, 0, 0) : (0, 1, 0)));
		#/
		depth++;
		if(!touching)
		{
			return function_f31cf3bb(new_point, direction, step / 2, depth, 10);
		}
		var_6b1f4b9c = new_point;
	}
}

/*
	Name: function_abd3bc1a
	Namespace: player_insertion
	Checksum: 0xCFA861A1
	Offset: 0x2298
	Size: 0x1BC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_abd3bc1a()
{
	if(!isalive(self))
	{
		return;
	}
	self setactionslot(3, "");
	self setactionslot(4, "");
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	self flagsys::clear(#"hash_224cb97b8f682317");
	self flagsys::clear(#"hash_287397edba8966f9");
	self val::set(#"player_insertion", "freezecontrols", 1);
	self val::set(#"player_insertion", "disablegadgets", 1);
	self val::set(#"hash_37b74f87edd2df20", "show_hud", 0);
	self val::set(#"hash_ce6d3e6ece6e18d", "show_weapon_hud", 0);
	self death_circle::function_b57e3cde(1);
	if(isbot(self))
	{
		self bot_insertion::function_9699dc95();
	}
}

/*
	Name: function_baf204f5
	Namespace: player_insertion
	Checksum: 0x7B47CA23
	Offset: 0x2460
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_baf204f5()
{
	self endon(#"death");
	if((isdefined(getgametypesetting(#"wzheavymetalheroes")) ? getgametypesetting(#"wzheavymetalheroes") : 0))
	{
		if(isdefined(level.var_618194f7))
		{
			self thread [[level.var_618194f7]]();
		}
		self setperk(#"specialty_doublejump");
		self setperk(#"specialty_fallheight");
	}
}

/*
	Name: function_7a4c1517
	Namespace: player_insertion
	Checksum: 0x25299E6F
	Offset: 0x2540
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_7a4c1517()
{
	self val::reset(#"player_insertion", "freezecontrols");
	self val::reset(#"player_insertion", "disablegadgets");
	self val::reset(#"hash_37b74f87edd2df20", "show_hud");
	self val::reset(#"hash_ce6d3e6ece6e18d", "show_weapon_hud");
}

/*
	Name: function_b9a53f50
	Namespace: player_insertion
	Checksum: 0xC6E7A6DF
	Offset: 0x25F0
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_b9a53f50()
{
	if(!function_8b1a219a())
	{
		self val::set(#"player_insertion", "freezecontrols_allowlook", 1);
	}
	self disableweapons();
}

/*
	Name: function_3354a054
	Namespace: player_insertion
	Checksum: 0x3A3A59CD
	Offset: 0x2658
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_3354a054()
{
	if(!function_8b1a219a())
	{
		self val::reset(#"player_insertion", "freezecontrols_allowlook");
	}
	self enableweapons();
}

/*
	Name: function_bc824660
	Namespace: player_insertion
	Checksum: 0x7D7C2052
	Offset: 0x26B8
	Size: 0x138
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bc824660(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	foreach(heli in insertion.var_41091905)
	{
		if(isdefined(heli))
		{
			heli setspeedimmediate(170);
		}
	}
	foreach(heli in insertion.var_dfaba736)
	{
		if(isdefined(heli))
		{
			heli setspeedimmediate(170);
		}
	}
}

/*
	Name: function_948ac812
	Namespace: player_insertion
	Checksum: 0xF8F1ADC5
	Offset: 0x27F8
	Size: 0xC8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_948ac812(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player function_abd3bc1a();
	}
}

/*
	Name: function_ff107056
	Namespace: player_insertion
	Checksum: 0x9EC8A7E1
	Offset: 0x28C8
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_ff107056(insertion)
{
	insertion flagsys::clear(#"hash_5a3e17fbc33cdc86");
	insertion flagsys::clear(#"hash_3dc9cb68998d9dfd");
}

/*
	Name: function_8dcd8623
	Namespace: player_insertion
	Checksum: 0x7741E86E
	Offset: 0x2920
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function function_8dcd8623()
{
	/#
		assert(isarray(level.insertions));
	#/
	/#
		if(getdvarint(#"scr_disable_infiltration", 0))
		{
			return;
		}
	#/
	level flagsys::clear(#"hash_60fcdd11812a0134");
	level flagsys::clear(#"hash_5a3e17fbc33cdc86");
	level flagsys::clear(#"hash_605a9ce4fc2912ae");
	for(index = 0; index < level.insertions.size; index++)
	{
		insertion = level.insertions[index];
		if(!(isdefined(insertion.allowed) && insertion.allowed))
		{
			return;
		}
		var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
		switch(var_7eb8f61a)
		{
			case 0:
			{
				level thread function_82c73974(insertion);
				break;
			}
			case 1:
			{
				function_51c5f95f(insertion);
				break;
			}
			case 2:
			{
				function_35742117(insertion);
				break;
			}
		}
	}
	level flagsys::wait_till(#"hash_605a9ce4fc2912ae");
}

/*
	Name: function_82c73974
	Namespace: player_insertion
	Checksum: 0xFC9F5302
	Offset: 0x2B60
	Size: 0x3D4
	Parameters: 1
	Flags: Linked
*/
function function_82c73974(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	insertion flagsys::clear(#"hash_60fcdd11812a0134");
	insertion flagsys::clear(#"hash_122f326d72f4c884");
	function_ff107056(insertion);
	insertioncount = (isdefined(getgametypesetting(#"hash_731988b03dc6ee17")) ? getgametypesetting(#"hash_731988b03dc6ee17") : 1);
	if(insertioncount > 0)
	{
		activeplayers = util::get_active_players();
		var_2c34761b = [];
		otherplayers = [];
		foreach(player in activeplayers)
		{
			if(function_20cba65e(player) == insertion.index)
			{
				var_2c34761b[var_2c34761b.size] = player;
				continue;
			}
			otherplayers[otherplayers.size] = player;
		}
		insertion.players = var_2c34761b;
		insertion.otherplayers = otherplayers;
	}
	else
	{
		insertion.players = arraycopy(util::get_active_players());
		insertion.otherplayers = [];
	}
	insertion thread function_c71552d0(insertion, 2, 2, 5, 1);
	wait(2 + 0.1);
	level callback::add_callback(#"hash_774be40ec06d5212", &function_bcde1e07, insertion);
	insertion thread globallogic_audio::function_85818e24("matchstart");
	insertion thread function_a4deb676();
	insertion flagsys::set(#"hash_122f326d72f4c884");
	level function_e59d879f(insertion, function_d9dfa25(), 1);
	function_dd34168c(insertion, #"hash_5a3e17fbc33cdc86");
	insertion flagsys::wait_till_timeout((2 + 5) + 0.5, #"hash_3dc9cb68998d9dfd");
	function_dd34168c(insertion, #"hash_605a9ce4fc2912ae");
}

/*
	Name: function_dd34168c
	Namespace: player_insertion
	Checksum: 0x2C963DBD
	Offset: 0x2F40
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_dd34168c(insertion, flag)
{
	insertion flagsys::set(flag);
	if(function_df47b31b(flag))
	{
		level flagsys::set(flag);
	}
}

/*
	Name: function_df47b31b
	Namespace: player_insertion
	Checksum: 0x28885463
	Offset: 0x2FA8
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function function_df47b31b(flag)
{
	for(index = 0; index < level.insertions.size; index++)
	{
		insertion = level.insertions[index];
		if(!insertion flagsys::get(flag))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_35742117
	Namespace: player_insertion
	Checksum: 0x6B91B748
	Offset: 0x3028
	Size: 0x4E0
	Parameters: 1
	Flags: Linked
*/
function function_35742117(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	insertion flagsys::clear(#"hash_60fcdd11812a0134");
	insertion flagsys::clear(#"hash_122f326d72f4c884");
	function_ff107056(insertion);
	insertion.players = arraycopy(util::get_active_players());
	foreach(player in insertion.players)
	{
		player val::set(#"player_insertion", "freezecontrols", 1);
		player val::set(#"player_insertion", "disablegadgets", 1);
	}
	insertion thread function_c71552d0(insertion, 2, 5, 5, 0);
	wait(2 + 0.1);
	insertion thread globallogic_audio::function_85818e24("matchstart");
	level thread function_a4deb676();
	insertion flagsys::set(#"hash_122f326d72f4c884");
	function_dd34168c(insertion, #"hash_60fcdd11812a0134");
	function_dd34168c(insertion, #"hash_5a3e17fbc33cdc86");
	level callback::callback(#"hash_774be40ec06d5212");
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		player setorigin(player.resurrect_origin);
		player setplayerangles(player.resurrect_angles);
		level callback::callback(#"hash_74b19f5972b0ee52", {#player:player});
	}
	function_dd34168c(insertion, #"hash_605a9ce4fc2912ae");
	wait(5 + (5 / 3));
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		player val::reset(#"player_insertion", "freezecontrols");
		player val::reset(#"player_insertion", "disablegadgets");
		player clientfield::set_to_player("realtime_multiplay", 1);
	}
}

/*
	Name: function_51c5f95f
	Namespace: player_insertion
	Checksum: 0xAAFD4F49
	Offset: 0x3510
	Size: 0x3A4
	Parameters: 1
	Flags: Linked
*/
function function_51c5f95f(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	insertion flagsys::clear(#"hash_60fcdd11812a0134");
	insertion flagsys::clear(#"hash_122f326d72f4c884");
	function_ff107056(insertion);
	insertion.players = arraycopy(util::get_active_players());
	level function_948ac812(insertion);
	insertion thread function_c71552d0(insertion, 2, 2, 5, 1);
	wait(2 + 0.1);
	insertion thread globallogic_audio::function_85818e24("matchstart");
	level thread function_a4deb676();
	insertion flagsys::set(#"hash_122f326d72f4c884");
	function_dd34168c(insertion, #"hash_60fcdd11812a0134");
	function_dd34168c(insertion, #"hash_5a3e17fbc33cdc86");
	level function_57d4a011(insertion);
	insertion flagsys::wait_till_timeout(0.5, #"hash_3dc9cb68998d9dfd");
	function_26fbfab4(insertion);
	var_990e3011 = 3;
	/#
		if(getdvarint(#"hash_96d977cb1cf39f8", 0) != 0)
		{
			var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
		}
	#/
	wait(var_990e3011);
	level callback::callback(#"hash_774be40ec06d5212");
	callback::remove_on_spawned(&function_aa3a20fb);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		player thread function_adc8cff4();
	}
	function_dd34168c(insertion, #"hash_605a9ce4fc2912ae");
}

/*
	Name: function_26fbfab4
	Namespace: player_insertion
	Checksum: 0xEEF33C8F
	Offset: 0x38C0
	Size: 0x15E
	Parameters: 1
	Flags: Linked
*/
function function_26fbfab4(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	level endon(#"game_ended");
	var_850118f3 = 5;
	/#
		if(getdvarint(#"hash_7f8ced042799da77", 0) != 0)
		{
			var_850118f3 = getdvarint(#"hash_7f8ced042799da77", 2);
		}
	#/
	foreach(player in insertion.players)
	{
		player function_abd3bc1a();
		if(!isalive(player))
		{
			continue;
		}
		player thread function_135ed50e();
	}
	wait(var_850118f3);
}

/*
	Name: function_135ed50e
	Namespace: player_insertion
	Checksum: 0xAACD85F3
	Offset: 0x3A28
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_135ed50e()
{
	self endon(#"disconnect", #"death");
	var_850118f3 = 5;
	/#
		if(getdvarint(#"hash_7f8ced042799da77", 0) != 0)
		{
			var_850118f3 = getdvarint(#"hash_7f8ced042799da77", 2);
		}
	#/
	self function_75488834();
	wait(var_850118f3);
	self function_3a77bd05();
}

/*
	Name: function_57d4a011
	Namespace: player_insertion
	Checksum: 0x6F07E215
	Offset: 0x3AF0
	Size: 0x6C4
	Parameters: 1
	Flags: Linked
*/
function function_57d4a011(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	function_a5fd9aa8(insertion);
	bot_insertion::function_24ca8ecf(insertion);
	var_719e741e = getentarray("camera_vehicle", "targetname");
	if(isdefined(var_719e741e))
	{
		numplayers = insertion.players.size;
		numteams = 1;
		/#
			assert(numplayers > 0, "");
		#/
		foreach(team in level.teams)
		{
			if(isdefined(level.everexisted[team]) && level.everexisted[team])
			{
				numteams++;
			}
		}
		level.warp_portal_vehicles = [];
		count = 1;
		foreach(var_e1dd0f66 in var_719e741e)
		{
			var_b06f2346 = "warp_portal_vehicle_spawn_" + count;
			var_7cac53bf = var_e1dd0f66 spawnfromspawner(var_b06f2346, 1, 1);
			var_7cac53bf.takedamage = 0;
			var_7cac53bf ghost();
			if(!isdefined(level.warp_portal_vehicles))
			{
				level.warp_portal_vehicles = [];
			}
			else if(!isarray(level.warp_portal_vehicles))
			{
				level.warp_portal_vehicles = array(level.warp_portal_vehicles);
			}
			level.warp_portal_vehicles[level.warp_portal_vehicles.size] = var_7cac53bf;
			if(count >= numteams)
			{
				break;
			}
			count++;
		}
		var_8a2c40d0 = struct::get("warp_zone_look_at", "targetname");
		step_size = 360 / numteams;
		if(isdefined(var_8a2c40d0))
		{
			if(level.warp_portal_vehicles.size > 0)
			{
				insertion.start_point = level.warp_portal_vehicles[0].origin;
				insertion.end_point = var_8a2c40d0.origin;
			}
			center = var_8a2c40d0.origin;
			radius = 9000;
			angle = 0;
			foreach(portal_vehicle in level.warp_portal_vehicles)
			{
				x_pos = center[0] + (radius * cos(angle));
				y_pos = center[1] + (radius * sin(angle));
				z_pos = 20000;
				portal_vehicle.origin = (x_pos, y_pos, z_pos);
				portal_vehicle.angle_step = angle;
				angle = angle + step_size;
				target = var_8a2c40d0.origin - portal_vehicle.origin;
				target = vectornormalize(target);
				angles = vectortoangles(target);
				portal_vehicle.angles = angles;
			}
		}
		var_30fc202f = 0;
		foreach(team in level.teams)
		{
			if(isdefined(level.everexisted[team]) && level.everexisted[team])
			{
				players = getplayers(team);
				foreach(player in players)
				{
					if(isalive(player))
					{
						player.var_30fc202f = var_30fc202f;
						player thread function_a25e421c();
					}
				}
				var_30fc202f++;
				if(var_30fc202f > numteams - 1)
				{
					var_30fc202f = numteams - 1;
					break;
				}
			}
		}
	}
	callback::on_spawned(&function_aa3a20fb);
}

/*
	Name: function_adc8cff4
	Namespace: player_insertion
	Checksum: 0x603CBE84
	Offset: 0x41C0
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_adc8cff4(var_107b6cf5 = 0)
{
	self endon(#"disconnect", #"death");
	self startcameratween(0.5);
	util::wait_network_frame();
	self show();
	self solid();
	self setclientthirdperson(0);
	self death_circle::function_b57e3cde(0);
	self val::set(#"player_insertion", "disable_oob", 0);
	self clientfield::set_to_player("realtime_multiplay", 1);
	self thread function_7bf9c38f(var_107b6cf5);
	level callback::callback(#"hash_74b19f5972b0ee52", {#player:self});
}

/*
	Name: getmapcenter
	Namespace: player_insertion
	Checksum: 0xD2F65B78
	Offset: 0x4330
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function getmapcenter()
{
	minimaporigins = getentarray("minimap_corner", "targetname");
	if(minimaporigins.size)
	{
		return math::find_box_center(minimaporigins[0].origin, minimaporigins[1].origin);
	}
	return (0, 0, 0);
}

/*
	Name: function_7bf9c38f
	Namespace: player_insertion
	Checksum: 0x8904D435
	Offset: 0x43A8
	Size: 0x31C
	Parameters: 1
	Flags: Linked
*/
function function_7bf9c38f(var_107b6cf5)
{
	self endon(#"disconnect", #"death");
	self flagsys::set(#"hash_224cb97b8f682317");
	self flagsys::set(#"hash_287397edba8966f9");
	speed = 4400;
	circleindex = 1;
	if(isdefined(level.var_52b56362))
	{
		circleindex = level.var_52b56362 + 2;
	}
	speed = speed / circleindex;
	self unlink();
	var_180a7b48 = self function_ec7cfdb();
	/#
		if(getdvarint(#"hash_37b6eccbe31b5875", 0) != 0)
		{
			var_180a7b48 = getdvarint(#"hash_37b6eccbe31b5875", 1);
		}
	#/
	/#
		assert(isdefined(var_180a7b48), "");
	#/
	if(!isdefined(var_180a7b48))
	{
		var_180a7b48 = 0;
	}
	if(!isdefined(level.warp_portal_vehicles))
	{
		level.warp_portal_vehicles = [];
	}
	if(level.warp_portal_vehicles.size)
	{
		portal = level.warp_portal_vehicles[var_180a7b48];
	}
	/#
		assert(isdefined(portal), "");
	#/
	if(isdefined(portal))
	{
		self setorigin(portal.origin);
	}
	else
	{
		center = getmapcenter();
		center = (center[0], center[1], 20000);
		self setorigin(center);
	}
	velocity = anglestoforward(self getplayerangles()) * speed;
	if(isdefined(var_107b6cf5) && var_107b6cf5)
	{
		start_freefall(velocity, 0);
	}
	else
	{
		start_freefall(velocity, 1);
	}
	if(isdefined(portal))
	{
		portal function_723d686d();
	}
	self thread function_2b276ae0();
}

/*
	Name: function_a25e421c
	Namespace: player_insertion
	Checksum: 0x960901FF
	Offset: 0x46D0
	Size: 0x424
	Parameters: 0
	Flags: Linked
*/
function function_a25e421c()
{
	self endon(#"disconnect", #"death");
	if(isalive(self))
	{
		self thread status_effect::function_6519f95f();
		self death_circle::function_b57e3cde(1);
		self val::set(#"player_insertion", "disable_oob", 1);
		self stopanimscripted();
		self unlink();
		self setstance("stand");
		var_180a7b48 = self function_ec7cfdb();
		/#
			if(getdvarint(#"hash_37b6eccbe31b5875", 0) != 0)
			{
				var_180a7b48 = getdvarint(#"hash_37b6eccbe31b5875", 1);
			}
		#/
		if(isdefined(level.warp_portal_vehicles))
		{
			portal = level.warp_portal_vehicles[var_180a7b48];
			if(isdefined(portal))
			{
				self setorigin(level.warp_portal_vehicles[var_180a7b48].origin);
				self function_648c1f6(level.warp_portal_vehicles[var_180a7b48], undefined, 0, 180, 180, 180, 180, 0);
				if(isdefined(level.deathcircle) && isdefined(level.var_52b56362) && isdefined(level.deathcircles))
				{
					target = level.deathcircle.origin;
					target = (target[0], target[1], -4000);
					currentindex = level.var_52b56362 + 1;
					if(currentindex >= level.deathcircles.size)
					{
						currentindex = level.deathcircles.size - 1;
					}
					target = level.deathcircles[currentindex].origin - self.origin;
					target = vectornormalize(target);
					angles = vectortoangles(target);
					self setplayerangles(angles);
				}
				else
				{
					var_8a2c40d0 = struct::get("warp_zone_look_at", "targetname");
					target = var_8a2c40d0.origin - self.origin;
					target = vectornormalize(target);
					angles = vectortoangles(target);
					self setplayerangles(angles);
				}
			}
		}
		self gadget_health_regen::function_7993d50e();
		self.health = self.spawnhealth;
		self ghost();
		self notsolid();
		self setclientthirdperson(1);
		self dontinterpolate();
	}
}

/*
	Name: function_f2867466
	Namespace: player_insertion
	Checksum: 0x7EF0AE2
	Offset: 0x4B00
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_f2867466()
{
	self notify("490996308f66dcbd");
	self endon("490996308f66dcbd");
	self endon(#"disconnect");
	level endon(#"game_ended");
	self flagsys::clear(#"hash_224cb97b8f682317");
	self flagsys::clear(#"hash_287397edba8966f9");
	waitframe(1);
	self function_a25e421c();
	self function_abd3bc1a();
	self function_135ed50e();
	var_990e3011 = 3;
	/#
		if(getdvarint(#"hash_96d977cb1cf39f8", 0) != 0)
		{
			var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
		}
	#/
	wait(var_990e3011);
	self function_adc8cff4(1);
}

/*
	Name: function_a5fd9aa8
	Namespace: player_insertion
	Checksum: 0xE35009BD
	Offset: 0x4C58
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_a5fd9aa8(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	arrayremovevalue(insertion.players, undefined, 0);
	if(isdefined(insertion.otherplayers))
	{
		arrayremovevalue(insertion.otherplayers, undefined, 0);
	}
}

/*
	Name: function_bcde1e07
	Namespace: player_insertion
	Checksum: 0x2467F1B2
	Offset: 0x4CE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_bcde1e07()
{
	insertion = self;
	callback::remove_on_spawned(&function_80c60f66, insertion);
}

/*
	Name: function_c62b5591
	Namespace: player_insertion
	Checksum: 0x38017CF7
	Offset: 0x4D28
	Size: 0x194
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c62b5591(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	if(!isdefined(insertion.cameraent))
	{
		insertion.cameraent = [];
	}
	var_163b0077 = 0;
	foreach(i, plane in insertion.var_41091905)
	{
		if(self islinkedto(plane))
		{
			if(isdefined(insertion.cameraent[i]))
			{
				insertion.cameraent[i] setvisibletoplayer(self);
			}
			var_163b0077 = 1;
			break;
		}
	}
	if(!var_163b0077 && insertion.var_41091905.size > 0)
	{
		if(isdefined(insertion.cameraent[insertion.var_41091905.size]))
		{
			insertion.cameraent[insertion.var_41091905.size] setvisibletoplayer(self);
		}
	}
}

/*
	Name: function_57fe9b21
	Namespace: player_insertion
	Checksum: 0xB51FBADB
	Offset: 0x4EC8
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function function_57fe9b21(insertion, origin)
{
	camera = spawn("script_model", origin);
	camera.targetname = "insertion_camera";
	camera setinvisibletoall();
	return camera;
}

/*
	Name: function_ca5b6591
	Namespace: player_insertion
	Checksum: 0x5FF5376A
	Offset: 0x4F30
	Size: 0xDE8
	Parameters: 4
	Flags: Linked
*/
function function_ca5b6591(insertion, startorigin, endorigin, var_872f085f)
{
	/#
		assert(isstruct(insertion));
	#/
	self notify("4bbabb1345724826");
	self endon("4bbabb1345724826");
	insertion.cameraent = [];
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(isdefined(insertion.cameraent[index]))
		{
			insertion.cameraent[index] delete();
		}
		insertion.cameraent[index] = function_57fe9b21(insertion, startorigin);
		insertion.cameraent[index].origin = startorigin + rotatepoint((8000, 0, 100), var_872f085f);
		insertion.cameraent[index].angles = (20, var_872f085f[1], var_872f085f[2]);
	}
	for(index = 0; index < insertion.var_41091905.size; index++)
	{
		camera = insertion.cameraent[index];
		camera clientfield::set("infiltration_camera", function_1e4302d0(1, insertion.index));
	}
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player function_c62b5591(insertion);
		player function_aa4e9db8();
	}
	foreach(player in insertion.otherplayers)
	{
		player function_c62b5591(insertion);
	}
	offset = vectorscale((1, 0, 0), 50000);
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		insertion.cameraent[index] moveto(insertion.cameraent[index].origin + rotatepoint(offset, var_872f085f), 50, 0, 0);
	}
	wait(3.75);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player playrumbleonentity(#"infiltration_rumble");
	}
	wait(1);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player playrumbleonentity(#"hash_233b436a07cd091a");
	}
	wait(0.2);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player playrumbleonentity(#"infiltration_rumble");
	}
	wait(2);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		player playrumbleonentity(#"hash_62ba49f452a20378");
	}
	wait(2);
	var_31a37076 = [];
	for(index = 0; index < insertion.players.size; index++)
	{
		player = insertion.players[index];
		if(!isdefined(player) || isdefined(var_31a37076[player.team]))
		{
			continue;
		}
		var_31a37076[player.team] = 1;
		if(isdefined(getgametypesetting(#"wzspectrerising")) && getgametypesetting(#"wzspectrerising"))
		{
			voiceevent("warSpectreRisingInfiltration", undefined, {#team:player.team});
			continue;
		}
		if(isdefined(getgametypesetting(#"wzhardcore")) && getgametypesetting(#"wzhardcore"))
		{
			voiceevent("hcWarBoostInfiltration", undefined, {#team:player.team});
			continue;
		}
		voiceevent("warBoostInfiltration", undefined, {#team:player.team});
	}
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(!isdefined(insertion.cameraent[index]))
		{
			continue;
		}
		plane = insertion.var_41091905[index];
		if(!isdefined(plane))
		{
			plane = insertion.var_41091905[0];
		}
		var_f945990b = plane.origin + vectorscale((0, 0, 1), 250);
		var_21e6b5ae = anglestoforward(var_872f085f);
		targetpos = var_f945990b + (((var_21e6b5ae * 150) * 17.6) * 4);
		insertion.cameraent[index] moveto(targetpos, 4, 1, 0);
		insertion.cameraent[index] rotateto((var_872f085f[0] + 15, var_872f085f[1], var_872f085f[2]), 4, 1, 1);
	}
	wait(4);
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(!isdefined(insertion.cameraent[index]))
		{
			continue;
		}
		var_f3d7d863 = endorigin + rotatepoint(vectorscale((0, 0, 1), 250), var_872f085f);
		timetotarget = distance(var_f3d7d863, targetpos) / 2640;
		insertion.cameraent[index] moveto(var_f3d7d863, timetotarget);
	}
	insertion flagsys::wait_till_timeout(0.05, #"hash_3dc9cb68998d9dfd");
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isdefined(player))
		{
			continue;
		}
		player setplayerangles((var_872f085f[0] + 15, var_872f085f[1], var_872f085f[2]));
	}
	waitframe(2);
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(!isdefined(insertion.cameraent[index]))
		{
			continue;
		}
		insertion.cameraent[index] clientfield::set("infiltration_plane", function_1e4302d0(1, insertion.index));
	}
	for(index = 0; index < insertion.var_41091905.size; index++)
	{
		if(!isdefined(insertion.cameraent[index]))
		{
			continue;
		}
		insertion.cameraent[index] clientfield::set("infiltration_camera", function_1e4302d0(2, insertion.index));
	}
	insertion thread function_bc824660(insertion);
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(!isdefined(insertion.cameraent[index]))
		{
			continue;
		}
		var_f3d7d863 = endorigin + rotatepoint(vectorscale((0, 0, 1), 250), var_872f085f);
		timetotarget = distance(var_f3d7d863, targetpos) / 2992;
		insertion.cameraent[index] moveto(var_f3d7d863, timetotarget);
	}
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		player function_7a4c1517();
	}
}

/*
	Name: function_77132caf
	Namespace: player_insertion
	Checksum: 0xE7304C61
	Offset: 0x5D20
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_77132caf()
{
	self unlink();
	self setstance("stand");
	self function_4feecc32();
	center = (0, 0, 0);
	radius = 500;
	if(isdefined(level.deathcircle))
	{
		center = level.deathcircle.origin;
		radius = level.deathcircle.radius * 0.85;
	}
	spawn_point = rotatepoint((radius, 0, 0), (0, randomint(360), 0));
	self setorigin((center + spawn_point) + vectorscale((0, 0, 1), 30000));
	self start_freefall((0, 0, 0), 0);
}

/*
	Name: function_ec7cfdb
	Namespace: player_insertion
	Checksum: 0x1BD2606
	Offset: 0x5E70
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function function_ec7cfdb()
{
	if(isdefined(self.var_30fc202f))
	{
		return self.var_30fc202f;
	}
	return 0;
}

/*
	Name: function_c4f5c468
	Namespace: player_insertion
	Checksum: 0xEB79DF59
	Offset: 0x5E98
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_c4f5c468(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	teammask = getteammask(self.team);
	teamindex = 0;
	while(teammask > 1)
	{
		teammask = teammask >> 1;
		teamindex++;
	}
	planeindex = teamindex % insertion.var_41091905.size;
	return insertion.var_41091905[planeindex];
}

/*
	Name: function_f795bf83
	Namespace: player_insertion
	Checksum: 0x630861F6
	Offset: 0x5F58
	Size: 0x2DC
	Parameters: 3
	Flags: Linked
*/
function function_f795bf83(insertion, vehicle, yaw)
{
	/#
		assert(isstruct(insertion));
	#/
	if(!isdefined(self) || !isentity(self))
	{
		return;
	}
	self endon(#"disconnect");
	if(!isdefined(vehicle))
	{
		self function_77132caf();
		return;
	}
	self notify(#"insertion_starting");
	if(!isdefined(insertion.passengercount))
	{
		insertion.passengercount = 0;
	}
	insertion.passengercount++;
	self stopanimscripted();
	self unlink();
	self setstance("stand");
	self function_648c1f6(vehicle, undefined, 0, 180, 180, 85, 85);
	self gadget_health_regen::function_7993d50e();
	self.health = self.spawnhealth;
	self cameraactivate(1);
	self setclientthirdperson(1);
	self setplayerangles((0, yaw, 0));
	self dontinterpolate();
	self ghost();
	self notsolid();
	self thread status_effect::function_6519f95f();
	self val::set(#"player_insertion", "disable_oob", 1);
	self clientfield::set_to_player("inside_infiltration_vehicle", 1);
	self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 0);
	level thread function_2e54d73e(insertion, self, vehicle);
	self thread function_2d683dc2(vehicle);
}

/*
	Name: function_e3f18577
	Namespace: player_insertion
	Checksum: 0xF2FA1D28
	Offset: 0x6240
	Size: 0x76
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e3f18577()
{
	height = 0;
	/#
		height = getdvarint(#"hash_37d751a610a5c2fc", 0);
	#/
	if(height == 0)
	{
		height = (isdefined(level.var_405a6738) ? level.var_405a6738 : 36000);
	}
	return height;
}

/*
	Name: function_7d880672
	Namespace: player_insertion
	Checksum: 0xA99F6571
	Offset: 0x62C0
	Size: 0x30A
	Parameters: 3
	Flags: None
*/
function function_7d880672(original_origin, var_9f8395cb, var_6a19d5de)
{
	/#
		self notify("");
		self endon("");
		self endon(#"disconnect");
		origin = self.origin;
		origin = (original_origin[0], original_origin[1], function_e3f18577());
		self setorigin(origin);
		var_cc56f8da = 0;
		var_cc56f8da = getdvarint(#"hash_380d8ae5bfc8f45b", 1);
		switch(var_cc56f8da)
		{
			case 0:
			default:
			{
				var_59526dd5 = 0;
				break;
			}
			case 1:
			{
				var_59526dd5 = var_9f8395cb;
				break;
			}
			case 2:
			{
				var_59526dd5 = randomint(360);
				break;
			}
		}
		var_872f085f = (0, var_59526dd5, 0);
		self setplayerangles(var_872f085f);
		direction = anglestoforward(var_872f085f);
		vectornormalize(direction);
		if(var_6a19d5de > 2)
		{
			speed = 1000;
			velocity = direction * speed;
			self function_2ffa8aaf(1, velocity, 0);
		}
		else
		{
			velocity = function_ba904ee2(direction * 2640);
			self function_2ffa8aaf(1, velocity, 1);
		}
		if((var_6a19d5de % 2) == 0)
		{
			while(true)
			{
				waitframe(1);
				if(self isonground() || self.origin[2] < -5000)
				{
					while(self isonground() && self.origin[2] > -5000)
					{
						waitframe(1);
					}
					self thread function_7d880672(original_origin, var_9f8395cb, var_6a19d5de);
					return;
				}
			}
		}
	#/
}

/*
	Name: function_aa3a20fb
	Namespace: player_insertion
	Checksum: 0x691768D1
	Offset: 0x65D8
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_aa3a20fb()
{
	if(!isdefined(level.warp_portal_vehicles))
	{
		self thread function_77132caf();
		return;
	}
	self thread function_f2867466();
}

/*
	Name: function_80c60f66
	Namespace: player_insertion
	Checksum: 0xA7A82A26
	Offset: 0x6628
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function function_80c60f66(player)
{
	if(player infection::is_infected())
	{
		return;
	}
	insertion = self;
	/#
		assert(isstruct(insertion));
	#/
	for(index = 0; index < level.insertions.size; index++)
	{
		var_18310f7e = level.insertions[index];
		if(insertion == var_18310f7e)
		{
			var_18310f7e.players[var_18310f7e.players.size] = player;
			continue;
		}
		var_18310f7e.otherplayers[var_18310f7e.otherplayers.size] = player;
		player function_c62b5591(var_18310f7e);
	}
	player function_abd3bc1a();
	plane = player function_c4f5c468(insertion);
	player function_f795bf83(insertion, plane, insertion.leadplane.angles[1]);
	player function_c62b5591(insertion);
	player function_aa4e9db8();
}

/*
	Name: function_e59d879f
	Namespace: player_insertion
	Checksum: 0x381AEC57
	Offset: 0x67E8
	Size: 0xBA0
	Parameters: 3
	Flags: Linked, Private
*/
function private function_e59d879f(insertion, var_6ad01bed, var_cf46aa72)
{
	/#
		assert(isstruct(insertion));
	#/
	/#
		var_6a19d5de = getdvarint(#"hash_1632f4021ab7a921", 0);
		if(var_6a19d5de)
		{
			if(1)
			{
				players = getplayers();
				foreach(player in players)
				{
					player thread function_7d880672(player.origin, player.angles[1], var_6a19d5de);
				}
				return;
			}
		}
	#/
	function_948ac812(insertion);
	bot_insertion::function_24ca8ecf(insertion);
	vehiclespawners = [];
	vehiclespawners[#"c130_spawner"] = getent("c130_spawner", "targetname");
	vehiclespawners[#"chinook_spawner"] = getent("chinook_spawner", "targetname");
	vehiclespawners[#"gunship_spawner"] = getent("gunship_spawner", "targetname");
	vehiclespawners[#"heli_infil_spawner"] = getent("heli_infil_spawner", "targetname");
	if(vehiclespawners.size == 0)
	{
		return false;
	}
	spawner::global_spawn_throttle(1);
	if(1)
	{
		var_69f4f44c = vehiclespawners[#"chinook_spawner"];
	}
	else
	{
		var_69f4f44c = vehiclespawners[#"c130_spawner"];
	}
	startpoint = insertion.start_point;
	endpoint = insertion.end_point;
	var_872f085f = insertion.var_f253731f;
	var_37362e08 = insertion.var_37362e08;
	var_7743b329 = insertion.var_7743b329;
	insertion.leadplane = var_69f4f44c spawnfromspawner("insertion_plane", 1, 1);
	insertion.leadplane.takedamage = 0;
	insertion.leadplane.origin = startpoint;
	insertion.leadplane.angles = var_872f085f;
	insertion.passengercount = 0;
	insertion.var_ef5094f9 = undefined;
	insertion.var_dfaba736 = [];
	insertion.var_27d17f06 = [];
	insertion.var_41091905 = [];
	if(!isdefined(insertion.var_41091905))
	{
		insertion.var_41091905 = [];
	}
	else if(!isarray(insertion.var_41091905))
	{
		insertion.var_41091905 = array(insertion.var_41091905);
	}
	insertion.var_41091905[insertion.var_41091905.size] = insertion.leadplane;
	if(1)
	{
		insertion.var_dfaba736 = [];
		insertion thread function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawners);
		if(var_cf46aa72)
		{
			insertion thread function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawners);
		}
		for(i = 0; i < var_6ad01bed.var_c85ebc15; i++)
		{
			spawner::global_spawn_throttle(1);
			var_61b1034d = startpoint + rotatepoint(var_6ad01bed.var_86cb4eb8[i], var_872f085f);
			var_4875d958 = vehiclespawners[var_6ad01bed.var_f5cff63[i]];
			vehicle = var_4875d958 spawnfromspawner("insertion_secondary");
			if(isdefined(vehicle))
			{
				vehicle notsolid();
				vehicle.takedamage = 0;
				vehicle.origin = var_61b1034d;
				vehicle.angles = var_872f085f;
				vehicle.startorigin = var_61b1034d;
				if(!isdefined(insertion.var_dfaba736))
				{
					insertion.var_dfaba736 = [];
				}
				else if(!isarray(insertion.var_dfaba736))
				{
					insertion.var_dfaba736 = array(insertion.var_dfaba736);
				}
				insertion.var_dfaba736[insertion.var_dfaba736.size] = vehicle;
				if(var_6ad01bed.var_f5cff63[i] == "chinook_spawner")
				{
					if(!isdefined(insertion.var_41091905))
					{
						insertion.var_41091905 = [];
					}
					else if(!isarray(insertion.var_41091905))
					{
						insertion.var_41091905 = array(insertion.var_41091905);
					}
					insertion.var_41091905[insertion.var_41091905.size] = vehicle;
				}
				if(i == var_6ad01bed.var_84f704f)
				{
					insertion.var_ef5094f9 = vehicle;
					vehicle.forwardoffset = var_6ad01bed.var_86cb4eb8[i][0];
				}
			}
		}
		if(!isdefined(insertion.var_ef5094f9))
		{
			insertion.var_ef5094f9 = insertion.leadplane;
			insertion.var_ef5094f9.startorigin = startpoint;
			insertion.var_ef5094f9.endorigin = endpoint;
			insertion.var_ef5094f9.forwardoffset = 0;
		}
		for(i = 0; i < var_6ad01bed.var_c85ebc15; i++)
		{
			if(!isdefined(insertion.var_dfaba736[i]))
			{
				continue;
			}
			var_45a4b34b = endpoint + rotatepoint(var_6ad01bed.var_86cb4eb8[i], var_872f085f);
			insertion.var_dfaba736[i].endorigin = var_45a4b34b;
			insertion.var_dfaba736[i] setneargoalnotifydist(512);
			insertion.var_dfaba736[i] thread function_ea6a4f96(insertion.var_dfaba736[i].startorigin, var_45a4b34b, var_872f085f, var_6ad01bed.hoverparams[i], var_6ad01bed.var_86255b48[i]);
		}
	}
	else
	{
		insertion.var_ef5094f9 = insertion.leadplane;
		insertion.var_ef5094f9.startorigin = startpoint;
		insertion.var_ef5094f9.endorigin = endpoint;
		insertion.var_ef5094f9.forwardoffset = 0;
	}
	insertion.leadplane setneargoalnotifydist(512);
	var_913594d7 = (0, 16, 16);
	insertion.leadplane thread function_ea6a4f96(startpoint, endpoint, var_872f085f, var_913594d7, 2);
	callback::on_spawned(&function_80c60f66, insertion);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(isalive(player))
		{
			plane = player function_c4f5c468(insertion);
			player function_f795bf83(insertion, plane, var_872f085f[1]);
		}
	}
	insertion thread function_afdad0c8(insertion, insertion.leadplane, startpoint, endpoint, var_7743b329);
	insertion thread function_6da3daa0(insertion, insertion.var_ef5094f9, insertion.var_ef5094f9.startorigin, insertion.var_ef5094f9.endorigin, var_37362e08 + insertion.var_ef5094f9.forwardoffset);
	insertion thread function_ca5b6591(insertion, startpoint, endpoint, var_872f085f);
	function_948ac812(insertion);
	return true;
}

/*
	Name: function_e04b0ea8
	Namespace: player_insertion
	Checksum: 0x4FF3EDE4
	Offset: 0x7390
	Size: 0x1CC
	Parameters: 5
	Flags: Linked
*/
function function_e04b0ea8(insertion, start_point, var_872f085f, var_37362e08, var_f69b665b)
{
	/#
		assert(isstruct(insertion));
	#/
	direction = anglestoforward(var_872f085f);
	insertion.var_b686c9d = spawn("script_model", start_point + (direction * var_37362e08));
	insertion.var_b686c9d.targetname = "insertion_jump";
	insertion.var_b686c9d.angles = var_872f085f;
	insertion.var_d908905e = spawn("script_model", start_point + (direction * var_f69b665b));
	insertion.var_d908905e.targetname = "insertion_force";
	insertion.var_d908905e.angles = var_872f085f;
	waitframe(1);
	insertion.var_b686c9d clientfield::set("infiltration_jump_point", function_1e4302d0(1, insertion.index));
	insertion.var_d908905e clientfield::set("infiltration_force_drop_point", function_1e4302d0(1, insertion.index));
}

/*
	Name: function_43cc81fc
	Namespace: player_insertion
	Checksum: 0xD2B2D9D4
	Offset: 0x7568
	Size: 0x8C
	Parameters: 0
	Flags: None
*/
function function_43cc81fc()
{
	var_6ad01bed = {#alignment:"center", #hash_84f704f:0, #hash_86255b48:[], #hash_3f37a51:[], #hash_86cb4eb8:[], #hash_f5cff63:[], #hash_c85ebc15:0};
	return var_6ad01bed;
}

/*
	Name: function_d9dfa25
	Namespace: player_insertion
	Checksum: 0x7D79D737
	Offset: 0x7600
	Size: 0xAD2
	Parameters: 0
	Flags: Linked
*/
function function_d9dfa25()
{
	var_815cd2d4 = [];
	var_6ad01bed = {#alignment:"left", #hash_84f704f:4, #hash_86255b48:array(2, 2, 2, 2, 2), #hash_3f37a51:array(vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), (0, 24, 128)), #hash_86cb4eb8:array((2750, -550, 0), (2000, -1200, 0), (1500, 750, 0), (500, 1500, 0), (-900, -700, 0)), #hash_f5cff63:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #hash_c85ebc15:5};
	if(!isdefined(var_815cd2d4))
	{
		var_815cd2d4 = [];
	}
	else if(!isarray(var_815cd2d4))
	{
		var_815cd2d4 = array(var_815cd2d4);
	}
	var_815cd2d4[var_815cd2d4.size] = var_6ad01bed;
	var_6ad01bed = {#alignment:"right", #hash_84f704f:4, #hash_86255b48:array(2, 2, 2, 2, 2), #hash_3f37a51:array(vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), (0, 24, 128)), #hash_86cb4eb8:array((2750, 550, 0), (2000, 1200, 0), (1500, -750, 0), (500, -1500, 0), (-900, 700, 0)), #hash_f5cff63:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #hash_c85ebc15:5};
	if(!isdefined(var_815cd2d4))
	{
		var_815cd2d4 = [];
	}
	else if(!isarray(var_815cd2d4))
	{
		var_815cd2d4 = array(var_815cd2d4);
	}
	var_815cd2d4[var_815cd2d4.size] = var_6ad01bed;
	var_6ad01bed = {#alignment:"left", #hash_84f704f:4, #hash_86255b48:array(2, 2, 2, 2, 2), #hash_3f37a51:array(vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), (0, 24, 128)), #hash_86cb4eb8:array((2750, -900, 0), (2000, 100, 0), (1250, 1100, 0), (500, 2100, 0), (-900, -700, 0)), #hash_f5cff63:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #hash_c85ebc15:5};
	if(!isdefined(var_815cd2d4))
	{
		var_815cd2d4 = [];
	}
	else if(!isarray(var_815cd2d4))
	{
		var_815cd2d4 = array(var_815cd2d4);
	}
	var_815cd2d4[var_815cd2d4.size] = var_6ad01bed;
	var_6ad01bed = {#alignment:"right", #hash_84f704f:4, #hash_86255b48:array(2, 2, 2, 2, 2), #hash_3f37a51:array(vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), (0, 24, 128)), #hash_86cb4eb8:array((2750, 900, 0), (2000, -100, 0), (1500, -1100, 0), (500, -2100, 0), (-900, 700, 0)), #hash_f5cff63:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner", "chinook_spawner"), #hash_c85ebc15:5};
	if(!isdefined(var_815cd2d4))
	{
		var_815cd2d4 = [];
	}
	else if(!isarray(var_815cd2d4))
	{
		var_815cd2d4 = array(var_815cd2d4);
	}
	var_815cd2d4[var_815cd2d4.size] = var_6ad01bed;
	/#
		index = getdvarint(#"hash_5293cadde39a7ceb", -1);
		if(index > -1)
		{
			if(isdefined(var_815cd2d4[index]))
			{
				return var_815cd2d4[index];
			}
		}
	#/
	var_86cb4eb8[#"left"] = array((1200, -2300, 0), (-200, -2300, 0), (-1600, -2300, 0), (-3000, -2300, 0));
	var_86cb4eb8[#"right"] = array((1200, 2300, 0), (-200, 2300, 0), (-1600, 2300, 0), (-3000, 2300, 0));
	var_5637e595 = {#hash_86255b48:array(2, 2, 2, 2), #hash_3f37a51:array(vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192), vectorscale((1, 1, 1), 192)), #hash_f5cff63:array("gunship_spawner", "gunship_spawner", "gunship_spawner", "gunship_spawner"), #hash_c85ebc15:4};
	var_6ad01bed = array::random(var_815cd2d4);
	var_6ad01bed.var_c85ebc15 = var_6ad01bed.var_c85ebc15 + var_5637e595.var_c85ebc15;
	var_6ad01bed.var_f5cff63 = arraycombine(var_6ad01bed.var_f5cff63, var_5637e595.var_f5cff63, 1, 0);
	var_6ad01bed.var_86cb4eb8 = arraycombine(var_6ad01bed.var_86cb4eb8, var_86cb4eb8[var_6ad01bed.alignment], 1, 0);
	var_6ad01bed.hoverparams = arraycombine(var_6ad01bed.hoverparams, var_5637e595.hoverparams, 1, 0);
	var_6ad01bed.var_86255b48 = arraycombine(var_6ad01bed.var_86255b48, var_5637e595.var_86255b48, 1, 0);
	return var_6ad01bed;
}

/*
	Name: function_45b56b0a
	Namespace: player_insertion
	Checksum: 0x83498796
	Offset: 0x80E0
	Size: 0x25A
	Parameters: 5
	Flags: Linked
*/
function function_45b56b0a(insertion, startpoint, endpoint, var_872f085f, vehiclespawners)
{
	offset = (500, -50, 600);
	goaloffset = vectorscale((0, 0, -1), 400);
	var_61b1034d = startpoint + rotatepoint(offset, var_872f085f);
	var_31e5487a = vehiclespawners[#"heli_infil_spawner"];
	insertion.var_933bdcf2 = var_31e5487a spawnfromspawner("insertion_presentation");
	if(!isdefined(insertion.var_933bdcf2))
	{
		/#
			assert(0);
		#/
		return;
	}
	insertion.var_933bdcf2.origin = var_61b1034d;
	insertion.var_933bdcf2.angles = var_872f085f;
	insertion.var_933bdcf2.startorigin = var_61b1034d;
	var_45a4b34b = endpoint + rotatepoint(goaloffset, var_872f085f);
	insertion.var_933bdcf2.endorigin = var_45a4b34b;
	wait(0.5);
	insertion.var_933bdcf2 setrotorspeed(1);
	insertion.var_933bdcf2 setspeedimmediate(175);
	insertion.var_933bdcf2 setneargoalnotifydist(512);
	insertion.var_933bdcf2 vehlookat(var_45a4b34b);
	insertion.var_933bdcf2 function_a57c34b7(var_45a4b34b, 0, 0);
	insertion.var_933bdcf2.takedamage = 0;
}

/*
	Name: function_f87ddcf0
	Namespace: player_insertion
	Checksum: 0xB47EDF97
	Offset: 0x8348
	Size: 0x38E
	Parameters: 5
	Flags: Linked
*/
function function_f87ddcf0(insertion, startpoint, endpoint, var_872f085f, vehiclespawners)
{
	offset = array((500, -100, 800), (500, 100, 800));
	goaloffset = array((0, 60000, -10000), (0, -60000, -10000));
	var_5b967418 = array("heli_infil_spawner", "heli_infil_spawner");
	insertion.var_27d17f06 = [];
	for(i = 0; i < 2; i++)
	{
		waitframe(1);
		var_61b1034d = startpoint + rotatepoint(offset[i], var_872f085f);
		var_31e5487a = vehiclespawners[var_5b967418[i]];
		vehicle = var_31e5487a spawnfromspawner("insertion_presentation");
		vehicle.origin = var_61b1034d;
		vehicle.angles = var_872f085f;
		vehicle.startorigin = var_61b1034d;
		if(!isdefined(insertion.var_27d17f06))
		{
			insertion.var_27d17f06 = [];
		}
		else if(!isarray(insertion.var_27d17f06))
		{
			insertion.var_27d17f06 = array(insertion.var_27d17f06);
		}
		insertion.var_27d17f06[insertion.var_27d17f06.size] = vehicle;
		waitframe(1);
	}
	for(i = 0; i < 2; i++)
	{
		var_45a4b34b = endpoint + rotatepoint(goaloffset[i], var_872f085f);
		insertion.var_27d17f06[i].endorigin = var_45a4b34b;
		insertion.var_27d17f06[i] setrotorspeed(1);
		insertion.var_27d17f06[i] setspeedimmediate(2);
		insertion.var_27d17f06[i] setneargoalnotifydist(512);
		insertion.var_27d17f06[i].takedamage = 0;
		insertion.var_27d17f06[i] thread function_700e474f(insertion.var_27d17f06[i].startorigin, var_45a4b34b, var_872f085f, goaloffset[i][1], i);
	}
}

/*
	Name: function_700e474f
	Namespace: player_insertion
	Checksum: 0x8A49F5A3
	Offset: 0x86E0
	Size: 0x33C
	Parameters: 5
	Flags: Linked
*/
function function_700e474f(startorigin, endorigin, var_872f085f, goal, index)
{
	self endon(#"death");
	dist = distance2d(endorigin, startorigin) / 3;
	offset = (dist / 2, math::sign(goal) * 1000, -1000);
	var_e8ab2c6b = startorigin + rotatepoint(offset, var_872f085f);
	offset = (dist / 2, math::sign(goal) * 1000, -1000);
	var_9fa20618 = var_e8ab2c6b + rotatepoint(offset, var_872f085f);
	/#
		if(getdvarint(#"hash_5bbd3d044e1ec1b8", 0))
		{
			self thread function_84898b3f(var_e8ab2c6b, var_9fa20618, endorigin, index);
		}
	#/
	wait(0.25);
	self setrotorspeed(1);
	self setspeedimmediate(2);
	self vehlookat(var_e8ab2c6b);
	self function_a57c34b7(var_e8ab2c6b, 0, 0);
	if(index > 0)
	{
		wait(0.75);
	}
	self setspeedimmediate(120);
	self thread function_71da60d1();
	self waittill(#"goal", #"near_goal");
	self vehlookat(var_9fa20618);
	self function_a57c34b7(var_9fa20618, 0, 0);
	self waittill(#"goal", #"near_goal");
	self vehlookat(endorigin);
	self function_a57c34b7(endorigin, 0, 0);
	self setspeed(250);
	self waittill(#"goal", #"near_goal");
	self delete();
}

/*
	Name: function_71da60d1
	Namespace: player_insertion
	Checksum: 0xBF88D4A5
	Offset: 0x8A28
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_71da60d1()
{
	wait(4);
	level notify(#"formation_start");
	self setspeed(150);
}

/*
	Name: function_84898b3f
	Namespace: player_insertion
	Checksum: 0x703C60D7
	Offset: 0x8A70
	Size: 0x126
	Parameters: 4
	Flags: None
*/
function function_84898b3f(var_e8ab2c6b, var_9fa20618, endorigin, index)
{
	/#
		self endon(#"death");
		while(getdvarint(#"hash_5bbd3d044e1ec1b8", 0))
		{
			color = (index > 0 ? (1, 0, 0) : (0, 0, 1));
			sphere(var_e8ab2c6b, 700, color);
			sphere(var_9fa20618, 700, color);
			sphere(endorigin, 700, color);
			line(var_e8ab2c6b, var_9fa20618, color);
			line(var_9fa20618, endorigin, color);
			waitframe(1);
		}
	#/
}

/*
	Name: function_ea6a4f96
	Namespace: player_insertion
	Checksum: 0x7E65D99F
	Offset: 0x8BA0
	Size: 0x244
	Parameters: 5
	Flags: Linked
*/
function function_ea6a4f96(startorigin, endorigin, var_872f085f, offsetvec, var_35c96bb3)
{
	self endon(#"death");
	self setspeedimmediate(5);
	self setrotorspeed(1);
	self function_a57c34b7(endorigin, 0, 0);
	level waittill(#"formation_start");
	self setspeedimmediate(150);
	if(1)
	{
		direction = anglestoforward(var_872f085f);
		distance = distance(endorigin, startorigin);
		var_27dfb385 = int(distance) / 5000;
		remainingdist = int(distance) % 5000;
		for(i = 1; i <= var_27dfb385; i++)
		{
			self pathvariableoffset(offsetvec * ((var_27dfb385 - i) + 1), var_35c96bb3);
			self function_85635daf(startorigin, distance, (i * 5000) / distance);
		}
		if(remainingdist > 0)
		{
			self pathvariableoffset(offsetvec, var_35c96bb3);
		}
	}
	self waittill(#"goal", #"near_goal");
	self delete();
}

/*
	Name: function_15945f95
	Namespace: player_insertion
	Checksum: 0xE581E7F0
	Offset: 0x8DF0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_15945f95()
{
	var_6024133d = getentarray("map_corner", "targetname");
	if(var_6024133d.size)
	{
		return math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
	}
	return (0, 0, 0);
}

/*
	Name: function_ab6af198
	Namespace: player_insertion
	Checksum: 0x686981F2
	Offset: 0x8E68
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_ab6af198()
{
	var_6024133d = getentarray("map_corner", "targetname");
	if(var_6024133d.size)
	{
		x = abs(var_6024133d[0].origin[0] - var_6024133d[1].origin[0]);
		y = abs(var_6024133d[0].origin[1] - var_6024133d[1].origin[1]);
		var_e39b9b61 = max(x, y);
		var_e39b9b61 = var_e39b9b61 * 0.75;
		return math::clamp(var_e39b9b61, 10000, var_e39b9b61);
	}
	return 10000;
}

/*
	Name: function_6671872c
	Namespace: player_insertion
	Checksum: 0xC6D24649
	Offset: 0x8F88
	Size: 0x46E
	Parameters: 0
	Flags: Linked
*/
function function_6671872c()
{
	if(isdefined(getgametypesetting(#"wzintersectdeathcircle")) && getgametypesetting(#"wzintersectdeathcircle"))
	{
		circleindex = (isdefined(getgametypesetting(#"hash_567a288b2ca685f3")) ? getgametypesetting(#"hash_567a288b2ca685f3") : 0);
		if(isdefined(level.deathcircles) && level.deathcircles.size > 0 && circleindex < level.deathcircles.size)
		{
			center = level.deathcircles[circleindex].origin;
			return (center[0], center[1], function_e3f18577());
		}
	}
	var_6024133d = getentarray("map_corner", "targetname");
	if(var_6024133d.size == 0)
	{
		return (0, 0, 0);
	}
	map_center = math::find_box_center(var_6024133d[0].origin, var_6024133d[1].origin);
	map_center = (map_center[0], map_center[1], 0);
	ratio_max = math::clamp(getdvarfloat(#"hash_730281ef3488a206", 0.6), 0, 1);
	var_40f8484d = math::clamp(getdvarfloat(#"hash_e3bea7572da5785", 0.3), 0, ratio_max);
	x = (abs(var_6024133d[0].origin[0] - var_6024133d[1].origin[0])) * 0.5;
	y = (abs(var_6024133d[0].origin[1] - var_6024133d[1].origin[1])) * 0.5;
	var_5017ad06 = (x * (ratio_max - var_40f8484d), y * (ratio_max - var_40f8484d), 0);
	random_point = (randomfloatrange(var_5017ad06[0] * -1, var_5017ad06[0]), randomfloatrange(var_5017ad06[1] * -1, var_5017ad06[1]), 0);
	if(var_40f8484d > 0)
	{
		random_point = (random_point[0] + (math::sign(random_point[0]) * (x * var_40f8484d)), random_point[1] + (math::sign(random_point[1]) * (y * var_40f8484d)), 0);
	}
	fly_over_point = map_center + random_point;
	height = function_e3f18577();
	fly_over_point = (fly_over_point[0], fly_over_point[1], height);
	return fly_over_point;
}

/*
	Name: function_45644b08
	Namespace: player_insertion
	Checksum: 0xC49ECF50
	Offset: 0x9400
	Size: 0x1C2
	Parameters: 0
	Flags: Linked
*/
function function_45644b08()
{
	if(isdefined(getgametypesetting(#"wzintersectdeathcircle")) && getgametypesetting(#"wzintersectdeathcircle"))
	{
		circleindex = (isdefined(getgametypesetting(#"hash_567a288b2ca685f3")) ? getgametypesetting(#"hash_567a288b2ca685f3") : 0);
		if(isdefined(level.deathcircles) && level.deathcircles.size > 0 && circleindex < level.deathcircles.size)
		{
			center = level.deathcircles[circleindex].origin;
			if(circleindex > 0)
			{
				var_6bf489f1 = level.deathcircles[0].origin;
				var_1ce870a0 = vectornormalize(center - var_6bf489f1);
				var_6e3e0ad7 = vectortoangles(var_1ce870a0);
				if(math::cointoss())
				{
					return var_6e3e0ad7[1];
				}
				return var_6e3e0ad7[1] - 180;
			}
		}
	}
	return randomint(360);
}

/*
	Name: function_63793dbe
	Namespace: player_insertion
	Checksum: 0xE01DC168
	Offset: 0x95D0
	Size: 0xC8
	Parameters: 0
	Flags: Private
*/
function private function_63793dbe()
{
	/#
		time = getdvarfloat(#"hash_102dc944a54c88d9", 0);
		if(time)
		{
			wait(time);
			foreach(player in level.activeplayers)
			{
				player flagsys::set(#"hash_224cb97b8f682317");
			}
		}
	#/
}

/*
	Name: function_85635daf
	Namespace: player_insertion
	Checksum: 0x5ED11290
	Offset: 0x96A0
	Size: 0x7C
	Parameters: 3
	Flags: Linked
*/
function function_85635daf(startpoint, total_distance, delta_t)
{
	while(true)
	{
		current_distance = distance(startpoint, self.origin);
		current_t = current_distance / total_distance;
		if(current_t > delta_t)
		{
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_afdad0c8
	Namespace: player_insertion
	Checksum: 0x13363648
	Offset: 0x9728
	Size: 0x63C
	Parameters: 5
	Flags: Linked, Private
*/
function private function_afdad0c8(insertion, plane, startpoint, endpoint, var_671fc488)
{
	/#
		assert(isstruct(insertion));
	#/
	self notify("4c45db4da3fff0be");
	self endon("4c45db4da3fff0be");
	plane endon(#"death");
	foreach(vehicle in insertion.var_41091905)
	{
		vehicle clientfield::set("infiltration_landing_gear", 1);
		vehicle setrotorspeed(1);
	}
	var_5e24c814 = 5 * 2640;
	total_distance = distance(startpoint, endpoint);
	/#
		assert(total_distance > var_671fc488);
	#/
	/#
		assert((var_671fc488 - var_5e24c814) > 0);
	#/
	/#
		assert(total_distance > (var_671fc488 - var_5e24c814));
	#/
	var_f26cf241 = (var_671fc488 - var_5e24c814) / total_distance;
	end_t = var_671fc488 / total_distance;
	/#
		level thread function_63793dbe();
	#/
	plane function_85635daf(startpoint, total_distance, var_f26cf241);
	/#
		debug_sphere(plane.origin, 75, (0, 1, 1));
	#/
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(isdefined(player.var_97b0977) && player.var_97b0977)
		{
			continue;
		}
		player clientfield::set_to_player("infiltration_final_warning", 1);
	}
	plane function_85635daf(startpoint, total_distance, end_t);
	/#
		debug_sphere(plane.origin, 75, (0, 1, 1));
	#/
	level callback::callback(#"hash_774be40ec06d5212");
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player flagsys::set(#"hash_224cb97b8f682317");
	}
	function_dd34168c(insertion, #"hash_60fcdd11812a0134");
	wait(1);
	foreach(vehicle in insertion.var_41091905)
	{
		vehicle clientfield::set("infiltration_transport", 0);
	}
	for(index = 0; index <= insertion.var_41091905.size; index++)
	{
		if(isdefined(insertion.cameraent[index]))
		{
			insertion.cameraent[index] delete();
		}
	}
	if(isdefined(insertion.var_b686c9d))
	{
		insertion.var_b686c9d delete();
	}
	if(isdefined(insertion.var_d908905e))
	{
		insertion.var_d908905e delete();
	}
	if(isdefined(insertion.infilteament))
	{
		insertion.infilteament delete();
	}
	wait(5);
	currentvalue = level clientfield::get("infiltration_compass");
	newvalue = (~(1 << insertion.index)) & currentvalue;
	level clientfield::set("infiltration_compass", newvalue);
}

/*
	Name: function_6da3daa0
	Namespace: player_insertion
	Checksum: 0x9F7B6C0A
	Offset: 0x9D70
	Size: 0x2EC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_6da3daa0(insertion, plane, startpoint, endpoint, var_6a694ed8)
{
	/#
		assert(isstruct(insertion));
	#/
	self notify("36dbf01cb1e95a6b");
	self endon("36dbf01cb1e95a6b");
	plane endon(#"death");
	var_7cd0d619 = 0.6 * 2640;
	total_distance = distance(startpoint, endpoint);
	/#
		assert(total_distance > var_6a694ed8);
	#/
	/#
		assert((var_6a694ed8 - var_7cd0d619) > 0);
	#/
	/#
		assert(total_distance > (var_6a694ed8 - var_7cd0d619));
	#/
	cargo_t = (var_6a694ed8 - var_7cd0d619) / total_distance;
	start_t = var_6a694ed8 / total_distance;
	plane function_85635daf(startpoint, total_distance, cargo_t);
	/#
		debug_sphere(plane.origin, 75, (0, 1, 1));
	#/
	insertion thread function_d11a5f0c(insertion);
	plane function_85635daf(startpoint, total_distance, start_t);
	/#
		debug_sphere(plane.origin, 75, (0, 1, 1));
	#/
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player flagsys::set(#"hash_287397edba8966f9");
	}
	wait(2);
	voiceevent("warPilotBail", undefined, {#insertion:insertion});
}

/*
	Name: function_bc16f3b4
	Namespace: player_insertion
	Checksum: 0xC44B1B49
	Offset: 0xA068
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function function_bc16f3b4(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	self clientfield::set("infiltration_transport", 1);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(player islinkedto(self))
		{
			player clientfield::set_to_player("infiltration_jump_warning", 1);
		}
	}
}

/*
	Name: function_d11a5f0c
	Namespace: player_insertion
	Checksum: 0xE61D99DE
	Offset: 0xA178
	Size: 0x1F8
	Parameters: 1
	Flags: Linked
*/
function function_d11a5f0c(insertion)
{
	/#
		assert(isstruct(insertion));
	#/
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		player.var_97b0977 = 0;
	}
	foreach(vehicle in insertion.var_41091905)
	{
		vehicle function_bc16f3b4(insertion);
		wait(randomfloatrange(0.5, 1));
	}
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(isdefined(player))
		{
			player clientfield::set_to_player("realtime_multiplay", 1);
		}
	}
}

/*
	Name: function_b80277f7
	Namespace: player_insertion
	Checksum: 0xA41B72CB
	Offset: 0xA378
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_b80277f7()
{
	if(isbot(self))
	{
		self bot_insertion::function_a4f516ef();
		return;
	}
	while(true)
	{
		waitframe(1);
		if(self flagsys::get(#"hash_287397edba8966f9") && isdefined(level.insertionpassenger) && isdefined(level.var_f3320ad2) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9) && !level.insertionpassenger [[level.var_a3c0d635]](self))
		{
			level.insertionpassenger [[level.var_f3320ad2]](self, 0);
			level.insertionpassenger [[level.var_ce84dde9]](self, level.insertion.passengercount);
		}
		if(self flagsys::get(#"hash_224cb97b8f682317") || (self flagsys::get(#"hash_287397edba8966f9") && self usebuttonpressed()))
		{
			return;
		}
	}
}

/*
	Name: function_1c06c249
	Namespace: player_insertion
	Checksum: 0x9ECFB394
	Offset: 0xA4F8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_1c06c249(plane)
{
	if(isplayer(self) && isdefined(plane))
	{
		self match_record::function_ded5f5b6(#"hash_1657e02fb5073e4a", plane.origin);
		self match_record::set_player_stat(#"hash_16618233fdac5c29", gettime());
		self match_record::set_player_stat(#"hash_63b95d780b2bd355", self flagsys::get(#"hash_224cb97b8f682317"));
	}
}

/*
	Name: function_25facefd
	Namespace: player_insertion
	Checksum: 0xC440CBB8
	Offset: 0xA5C0
	Size: 0xF0
	Parameters: 2
	Flags: Linked
*/
function function_25facefd(count, ignore_player)
{
	if(isdefined(level.insertionpassenger) && isdefined(level.var_a3c0d635) && isdefined(level.var_ce84dde9))
	{
		foreach(player in getplayers())
		{
			if(level.insertionpassenger [[level.var_a3c0d635]](player))
			{
				level.insertionpassenger [[level.var_ce84dde9]](player, count);
			}
		}
	}
}

/*
	Name: function_2e54d73e
	Namespace: player_insertion
	Checksum: 0x7538F8CA
	Offset: 0xA6B8
	Size: 0xCC
	Parameters: 3
	Flags: Linked
*/
function function_2e54d73e(insertion, passenger, vehicle)
{
	/#
		assert(isstruct(insertion));
	#/
	if(isdefined(vehicle))
	{
		vehicle endon(#"death");
	}
	waitresult = undefined;
	waitresult = passenger waittill(#"disconnect", #"player_jumped");
	if(isdefined(insertion.passengercount))
	{
		insertion.passengercount--;
		function_25facefd(insertion.passengercount);
	}
}

/*
	Name: function_ced05c63
	Namespace: player_insertion
	Checksum: 0x79820C09
	Offset: 0xA790
	Size: 0xB2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ced05c63(note, payload)
{
	teammates = getplayers(self.team);
	foreach(player in teammates)
	{
		if(player == self)
		{
			continue;
		}
		player notify(note, payload);
	}
}

/*
	Name: function_2d683dc2
	Namespace: player_insertion
	Checksum: 0xADAE5F56
	Offset: 0xA850
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function function_2d683dc2(aircraft)
{
	self notify("2c6c5668dc17cb7b");
	self endon("2c6c5668dc17cb7b");
	self endon(#"disconnect", #"death");
	self function_b9a53f50();
	self function_b80277f7();
	self function_ced05c63(#"hash_3a41cbe85bdb81e1", {#player:self});
	self function_1c06c249(aircraft);
	self startcameratween(0.5);
	util::wait_network_frame();
	self cameraactivate(0);
	self setclientthirdperson(0);
	self show();
	self solid();
	self death_circle::function_b57e3cde(0);
	self clientfield::set_to_player("inside_infiltration_vehicle", 0);
	if(isdefined(level.insertionpassenger) && isdefined(level.var_81b39a59))
	{
		level.insertionpassenger [[level.var_81b39a59]](self);
	}
	self thread player_freefall(aircraft);
	self function_af096637();
	self stoprumble(#"hash_233b436a07cd091a");
	level callback::callback(#"hash_74b19f5972b0ee52", {#player:self});
}

/*
	Name: function_ba904ee2
	Namespace: player_insertion
	Checksum: 0x1A41CD22
	Offset: 0xAAA8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function function_ba904ee2(velocity)
{
	speed = 1584;
	var_4626a28f = (10, self.angles[1], 0);
	return anglestoforward(var_4626a28f) * speed;
}

/*
	Name: player_freefall
	Namespace: player_insertion
	Checksum: 0x1D80D2E6
	Offset: 0xAB08
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function player_freefall(aircraft)
{
	self notify("23caea5eda85f40b");
	self endon("23caea5eda85f40b");
	self endon(#"disconnect");
	self notify(#"player_jumped");
	lateraloffset = (0, 0, 0);
	forward = anglestoforward(self.angles);
	origin = (self.origin + (forward * 512)) - (0, 0, 542);
	origin = (origin[0] + (randomfloatrange(-300, 300)), origin[1] + (randomfloatrange(-300, 300)), origin[2] + (randomfloatrange(-300, 300)));
	self unlink();
	self setorigin(origin);
	velocity = function_ba904ee2(aircraft getvelocity());
	self start_freefall(velocity, 1);
	self thread function_712f9f52();
}

/*
	Name: start_freefall
	Namespace: player_insertion
	Checksum: 0x9EA06C28
	Offset: 0xACD8
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function start_freefall(velocity, parachute)
{
	self callback::function_d8abfc3d(#"freefall", &function_3b9bcf85);
	self function_2ffa8aaf(1, velocity, parachute);
	self.var_97b0977 = 1;
	self hud_message::clearlowermessage();
	self val::set(#"player_insertion", "disable_oob", 0);
	self function_3354a054();
	if(isdefined(level.var_ec375172))
	{
		level thread [[level.var_ec375172]](self);
	}
	self thread function_baf204f5();
}

/*
	Name: function_4630bf0a
	Namespace: player_insertion
	Checksum: 0x1109508
	Offset: 0xADE8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_4630bf0a()
{
	if(isplayer(self))
	{
		self match_record::function_ded5f5b6(#"hash_7d9d379ecba10793", self.origin);
		self match_record::set_player_stat(#"hash_1469faf3180d8b7a", gettime());
		self.var_37ef8626 = gettime();
	}
}

/*
	Name: function_4eb0c560
	Namespace: player_insertion
	Checksum: 0xAA1E575B
	Offset: 0xAE60
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_4eb0c560()
{
	[[ level.wingsuit_hud ]]->close(self);
	self val::reset(#"player_insertion", "disablegadgets");
	self val::reset(#"hash_37b74f87edd2df20", "show_hud");
	self val::reset(#"hash_ce6d3e6ece6e18d", "show_weapon_hud");
	self setclientuivisibilityflag("weapon_hud_visible", 1);
	if(isdefined(level.deathcirclerespawn) && level.deathcirclerespawn || (isdefined(level.waverespawndelay) && level.waverespawndelay > 0))
	{
		self clientfield::set_player_uimodel("hudItems.showReinsertionPassengerCount", 1);
	}
}

/*
	Name: function_3b9bcf85
	Namespace: player_insertion
	Checksum: 0x7F5F48C5
	Offset: 0xAF88
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_3b9bcf85(args)
{
	if(!(isdefined(args.freefall) && args.freefall) && (!(isdefined(args.var_695a7111) && args.var_695a7111)))
	{
		function_4eb0c560();
	}
}

/*
	Name: function_916470ec
	Namespace: player_insertion
	Checksum: 0xB7062CE2
	Offset: 0xAFF8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_916470ec(args)
{
	function_4eb0c560();
}

/*
	Name: function_4feecc32
	Namespace: player_insertion
	Checksum: 0x652FCC6B
	Offset: 0xB020
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_4feecc32()
{
	self setclientthirdperson(0);
	self show();
	self solid();
	self val::reset(#"player_insertion", "takedamage");
	self val::reset(#"warzonestaging", "takedamage");
	self death_circle::function_b57e3cde(0);
	self val::set(#"player_insertion", "disable_oob", 0);
	self clientfield::set_to_player("realtime_multiplay", 1);
}

/*
	Name: function_2b276ae0
	Namespace: player_insertion
	Checksum: 0x5CC10BEA
	Offset: 0xB128
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_2b276ae0()
{
	self endon(#"disconnect", #"death");
	wait(1);
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	self val::reset(#"player_insertion", "freezecontrols");
	self function_4feecc32();
	[[ level.wingsuit_hud ]]->open(self);
	callback::function_d8abfc3d(#"parachute", &function_66c91693);
	callback::on_death(&function_916470ec);
	self thread function_7a4c1517();
}

/*
	Name: function_712f9f52
	Namespace: player_insertion
	Checksum: 0x45A3E9FD
	Offset: 0xB240
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_712f9f52()
{
	self endon(#"disconnect", #"death");
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	[[ level.wingsuit_hud ]]->open(self);
	callback::function_d8abfc3d(#"parachute", &function_66c91693);
	callback::on_death(&function_916470ec);
}

/*
	Name: function_66c91693
	Namespace: player_insertion
	Checksum: 0x7AD298D1
	Offset: 0xB2F8
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private function_66c91693(eventstruct)
{
	if(!eventstruct.parachute)
	{
		self function_4630bf0a();
		function_916470ec(self);
		self callback::function_52ac9652(#"parachute", &function_66c91693);
		self callback::remove_on_death(&function_916470ec);
	}
}

/*
	Name: function_c71552d0
	Namespace: player_insertion
	Checksum: 0xB54EE925
	Offset: 0xB398
	Size: 0x3A4
	Parameters: 5
	Flags: Linked
*/
function function_c71552d0(insertion, fadeouttime, blacktime, fadeintime, rumble)
{
	/#
		assert(isstruct(insertion));
	#/
	if(isdefined(lui::get_luimenu("FullScreenBlack")))
	{
		lui_menu = lui::get_luimenu("FullScreenBlack");
	}
	else
	{
		insertion flagsys::set(#"hash_3dc9cb68998d9dfd");
		return;
	}
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(isdefined(player))
		{
			[[ lui_menu ]]->open(player);
			[[ lui_menu ]]->set_startAlpha(player, 0);
			[[ lui_menu ]]->set_endAlpha(player, 1);
			[[ lui_menu ]]->set_fadeOverTime(player, int(fadeouttime * 1000));
		}
	}
	wait(fadeouttime + blacktime);
	insertion flagsys::wait_till_timeout(2, #"hash_5a3e17fbc33cdc86");
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		if(rumble)
		{
			player playrumbleonentity(#"infiltration_rumble");
		}
		[[ lui_menu ]]->open(player);
		[[ lui_menu ]]->set_startAlpha(player, 1);
		[[ lui_menu ]]->set_endAlpha(player, 0);
		[[ lui_menu ]]->set_fadeOverTime(player, int(fadeintime * 1000));
	}
	wait(fadeintime);
	function_a5fd9aa8(insertion);
	foreach(player in insertion.players)
	{
		[[ lui_menu ]]->close(player);
	}
	insertion flagsys::set(#"hash_3dc9cb68998d9dfd");
}

/*
	Name: function_d7f18e8f
	Namespace: player_insertion
	Checksum: 0x1F4105B0
	Offset: 0xB748
	Size: 0x88
	Parameters: 1
	Flags: Private
*/
function private function_d7f18e8f(players)
{
	foreach(player in players)
	{
		if(!isbot(player))
		{
			return player;
		}
	}
}

/*
	Name: function_6660c1f
	Namespace: player_insertion
	Checksum: 0x8E8F9FED
	Offset: 0xB7D8
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_6660c1f()
{
	for(index = 0; index < level.insertions.size; index++)
	{
		insertion = level.insertions[index];
		if(insertion flagsys::get(#"hash_60fcdd11812a0134"))
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_e5d4df1c
	Namespace: player_insertion
	Checksum: 0xDB02C9F3
	Offset: 0xB858
	Size: 0x78
	Parameters: 0
	Flags: Linked
*/
function function_e5d4df1c()
{
	for(index = 0; index < level.insertions.size; index++)
	{
		insertion = level.insertions[index];
		if(insertion flagsys::get(#"hash_122f326d72f4c884"))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_a4deb676
	Namespace: player_insertion
	Checksum: 0x4F9CC16F
	Offset: 0xB8D8
	Size: 0xDA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a4deb676()
{
	var_d9bf1973 = getentarray("game_start_button", "script_noteworthy");
	array::delete_all(var_d9bf1973);
	if(isdefined(level.var_63460f40))
	{
		foreach(object in level.var_63460f40)
		{
			object gameobjects::destroy_object(1);
		}
		level.var_63460f40 = undefined;
	}
}

/*
	Name: function_aa4e9db8
	Namespace: player_insertion
	Checksum: 0x6FF9E827
	Offset: 0xB9C0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_aa4e9db8()
{
	self clientfield::set_to_player("heatblurpostfx", 1);
}

/*
	Name: function_af096637
	Namespace: player_insertion
	Checksum: 0x752B264B
	Offset: 0xB9F0
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_af096637()
{
	self clientfield::set_to_player("heatblurpostfx", 0);
}

/*
	Name: function_75488834
	Namespace: player_insertion
	Checksum: 0x7EC62520
	Offset: 0xBA20
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_75488834()
{
	self clientfield::set_to_player("warpportal_fx_wormhole", 1);
}

/*
	Name: function_3a77bd05
	Namespace: player_insertion
	Checksum: 0xB800A808
	Offset: 0xBA50
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_3a77bd05()
{
	self clientfield::set_to_player("warpportal_fx_wormhole", 0);
}

/*
	Name: function_723d686d
	Namespace: player_insertion
	Checksum: 0x59B6A128
	Offset: 0xBA80
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_723d686d()
{
	self clientfield::increment("warpportalfx_launch");
}

/*
	Name: function_808b3790
	Namespace: player_insertion
	Checksum: 0x3C4310BF
	Offset: 0xBAB0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_808b3790()
{
	self clientfield::set("warpportalfx", 1);
}

/*
	Name: function_8fc2a69e
	Namespace: player_insertion
	Checksum: 0xB9E7680D
	Offset: 0xBAE0
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_8fc2a69e()
{
	self clientfield::set("warpportalfx", 0);
}

/*
	Name: debug_sphere
	Namespace: player_insertion
	Checksum: 0x95507272
	Offset: 0xBB10
	Size: 0xFC
	Parameters: 5
	Flags: Private
*/
function private debug_sphere(origin, radius, color, alpha, time)
{
	/#
		if(!isdefined(alpha))
		{
			alpha = 1;
		}
		if(!isdefined(time))
		{
			time = 5000;
		}
		if(getdvarint(#"scr_insertion_debug", 0) == 1)
		{
			if(!isdefined(color))
			{
				color = (1, 1, 1);
			}
			sides = int(10 * (1 + (int(radius / 100))));
			sphere(origin, radius, color, alpha, 1, sides, time);
		}
	#/
}

/*
	Name: debug_line
	Namespace: player_insertion
	Checksum: 0x1FF7128F
	Offset: 0xBC18
	Size: 0xCC
	Parameters: 5
	Flags: None
*/
function debug_line(from, to, color, time, depthtest)
{
	/#
		if(!isdefined(time))
		{
			time = 5000;
		}
		if(!isdefined(depthtest))
		{
			depthtest = 1;
		}
		if(getdvarint(#"scr_insertion_debug", 0) == 1)
		{
			if(distancesquared(from, to) < 0.01)
			{
				return;
			}
			line(from, to, color, 1, depthtest, time);
		}
	#/
}

/*
	Name: function_943c98fb
	Namespace: player_insertion
	Checksum: 0xE982E5C4
	Offset: 0xBCF0
	Size: 0x2A0
	Parameters: 1
	Flags: Private
*/
function private function_943c98fb(insertion)
{
	/#
		/#
			assert(isstruct(insertion));
		#/
		mapname = util::get_map_name();
		adddebugcommand(("" + mapname) + "");
		waitframe(1);
		adddebugcommand(("" + mapname) + "");
		waitframe(1);
		adddebugcommand(("" + mapname) + "");
		waitframe(1);
		adddebugcommand(("" + mapname) + "");
		waitframe(1);
		adddebugcommand(("" + mapname) + "");
		while(true)
		{
			waitframe(1);
			string = getdvarstring(#"hash_683dafe2da41b42e", "");
			start_insertion = 0;
			switch(string)
			{
				case "start_insertion":
				{
					start_insertion = 1;
					break;
				}
				case "repath_flight":
				{
					insertion on_finalize_initialization();
				}
				default:
				{
					break;
				}
			}
			if(start_insertion)
			{
				level function_8dcd8623();
			}
			setdvar(#"hash_683dafe2da41b42e", "");
			if(getdvarint(#"hash_5566ccc7de522a4a", 0))
			{
				setdvar(#"hash_5566ccc7de522a4a", 0);
				level thread function_4910c182(insertion);
			}
		}
	#/
}

/*
	Name: function_4910c182
	Namespace: player_insertion
	Checksum: 0x5FA0AB53
	Offset: 0xBF98
	Size: 0x31C
	Parameters: 1
	Flags: None
*/
function function_4910c182(insertion)
{
	/#
		/#
			assert(isdefined(insertion));
		#/
		insertion flagsys::clear(#"hash_60fcdd11812a0134");
		insertion flagsys::clear(#"hash_122f326d72f4c884");
		function_ff107056();
		insertion.players = arraycopy(util::get_active_players());
		level function_948ac812(insertion);
		level thread function_c71552d0(insertion, 2, 2, 5, 1);
		wait(2 + 0.1);
		level thread globallogic_audio::function_85818e24("");
		level thread function_a4deb676();
		insertion flagsys::set(#"hash_122f326d72f4c884");
		insertion flagsys::set(#"hash_60fcdd11812a0134");
		insertion flagsys::set(#"hash_5a3e17fbc33cdc86");
		foreach(player in insertion.players)
		{
			player function_a25e421c();
		}
		level flagsys::wait_till_timeout(0.5, #"hash_3dc9cb68998d9dfd");
		function_26fbfab4();
		var_990e3011 = 3;
		/#
			if(getdvarint(#"hash_96d977cb1cf39f8", 0) != 0)
			{
				var_990e3011 = getdvarint(#"hash_96d977cb1cf39f8", 2);
			}
		#/
		wait(var_990e3011);
		players = getplayers();
		players[0] function_adc8cff4();
	#/
}

