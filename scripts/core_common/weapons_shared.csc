// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\vehicle_shared.csc;

#namespace weapons_shared;

/*
	Name: __init__system__
	Namespace: weapons_shared
	Checksum: 0xFEE13C20
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"weapon_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: weapons_shared
	Checksum: 0xD516ACCD
	Offset: 0x140
	Size: 0x9C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	callback::on_spawned(&on_player_spawned);
	level.weaponnone = getweapon(#"none");
	level.weapon_sig_minigun = getweapon(#"sig_minigun");
	vehicle::add_vehicletype_callback("swivel_mount", &function_5e4b481b);
}

/*
	Name: on_player_spawned
	Namespace: weapons_shared
	Checksum: 0xA0FA1EB2
	Offset: 0x1E8
	Size: 0x54
	Parameters: 1
	Flags: None
*/
function on_player_spawned(local_client_num)
{
	if(self function_21c0fa55())
	{
		self thread function_ec73770b(local_client_num);
		self thread function_903d2d4c(local_client_num);
	}
}

/*
	Name: function_5e4b481b
	Namespace: weapons_shared
	Checksum: 0x1B7CC1BB
	Offset: 0x248
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_5e4b481b(local_client_num)
{
	self thread function_ca6a6ea8(local_client_num);
}

/*
	Name: function_ca6a6ea8
	Namespace: weapons_shared
	Checksum: 0x1222EA2
	Offset: 0x278
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_ca6a6ea8(local_client_num)
{
	if(self function_4add50a7() && !isthirdperson(local_client_num))
	{
		self sethighdetail(1);
	}
}

/*
	Name: function_1c61050d
	Namespace: weapons_shared
	Checksum: 0x1A2379BD
	Offset: 0x2E0
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function function_1c61050d(local_client_num, objective_id)
{
	self waittill(#"death", #"disconnect", #"team_changed");
	if(isdefined(objective_id))
	{
		objective_delete(local_client_num, objective_id);
	}
}

/*
	Name: function_7a677105
	Namespace: weapons_shared
	Checksum: 0x8D9D5281
	Offset: 0x358
	Size: 0xD4
	Parameters: 1
	Flags: None
*/
function function_7a677105(weapon)
{
	/#
		assert(isdefined(weapon.customsettings), "" + weapon.name);
	#/
	if(!isdefined(level.var_825acea))
	{
		level.var_825acea = [];
	}
	var_f0bf9259 = hash(weapon.name);
	if(!isdefined(level.var_825acea[var_f0bf9259]))
	{
		level.var_825acea[var_f0bf9259] = getscriptbundle(weapon.customsettings);
	}
	return level.var_825acea[var_f0bf9259];
}

/*
	Name: function_903d2d4c
	Namespace: weapons_shared
	Checksum: 0x429F2E88
	Offset: 0x438
	Size: 0x150
	Parameters: 1
	Flags: None
*/
function function_903d2d4c(local_client_num)
{
	if(level.weapon_sig_minigun == level.weaponnone)
	{
		return;
	}
	level notify("sig_minigun_force_stream_watcher_singleton" + local_client_num);
	level endon("sig_minigun_force_stream_watcher_singleton" + local_client_num);
	local_player = self;
	if(!isdefined(level.var_644fb9ec))
	{
		level.var_644fb9ec = 0;
	}
	while(true)
	{
		var_8cf0e703 = function_4878c786(local_client_num, level.weapon_sig_minigun);
		if(!var_8cf0e703 && level.var_644fb9ec)
		{
			stopforcestreamingxmodel(#"hash_253fe56e77e698b3");
			level.var_644fb9ec = 0;
		}
		else if(var_8cf0e703 && !level.var_644fb9ec)
		{
			forcestreamxmodel(#"hash_253fe56e77e698b3");
			level.var_644fb9ec = 1;
		}
		wait(0.1);
	}
}

/*
	Name: function_ec73770b
	Namespace: weapons_shared
	Checksum: 0xC57F3D13
	Offset: 0x590
	Size: 0x850
	Parameters: 1
	Flags: None
*/
function function_ec73770b(local_client_num)
{
	player = self;
	player endon(#"death", #"disconnect");
	wait(randomfloatrange(0.1, 0.5));
	var_935615f7 = #"mountable_point";
	obj_id = undefined;
	var_8e35a928 = 0;
	var_4798772a = 0;
	mountable_point = (0, 0, 0);
	var_982f06c8 = 0;
	var_5a5b4ff7 = 0;
	while(true)
	{
		if(isdefined(player.var_6b0fde88) && isdefined(obj_id) && getdvarint(#"hash_2281c2e9e7f377ec", 0))
		{
			if(!var_5a5b4ff7 && var_8e35a928)
			{
				objective_add(local_client_num, obj_id, "active", var_935615f7, mountable_point);
				objective_setgamemodeflags(local_client_num, obj_id, var_982f06c8);
				/#
					if(getdvarint(#"hash_45f38774fd8ac214", 0) > 0)
					{
						sphere(mountable_point, 2, (0.1, 0.9, 0.1), 0.8, 1, 16, 1);
					}
				#/
			}
			else if(objective_state(local_client_num, obj_id) != "invisible")
			{
				objective_setstate(local_client_num, obj_id, "invisible");
			}
		}
		if(!var_4798772a)
		{
			wait(0.5);
		}
		wait(0.016);
		if(0)
		{
			start_time = util::get_start_time();
		}
		var_8e35a928 = 0;
		var_4798772a = 0;
		var_982f06c8 = 0;
		var_5a5b4ff7 = 0;
		current_weapon = getcurrentweapon(local_client_num);
		if(current_weapon == level.weaponnone)
		{
			continue;
		}
		if(!current_weapon.mountable)
		{
			continue;
		}
		var_4798772a = 1;
		if(!isdefined(player.var_6b0fde88))
		{
			player.var_6b0fde88 = util::getnextobjid(local_client_num);
			player thread function_1c61050d(local_client_num, player.var_6b0fde88);
		}
		obj_id = player.var_6b0fde88;
		var_9cfaf8a4 = isads(local_client_num);
		if(var_9cfaf8a4)
		{
			var_8e35a928 = 1;
			var_982f06c8 = 1;
			var_5a5b4ff7 = 1;
			continue;
		}
		origin = getlocalclientpos(local_client_num);
		mountable_point = origin;
		cam_angles = getcamanglesbylocalclientnum(local_client_num);
		forward = anglestoforward(cam_angles);
		forward = vectornormalize((forward[0], forward[1], 0));
		height_offset = 24;
		trace_distance = getdvarint(#"hash_25637aefbe36f6f5", 300);
		forward_vector = vectorscale(forward, trace_distance);
		trace_start = origin + (0, 0, height_offset);
		trace_end = trace_start + forward_vector;
		trace_result = bullettrace(trace_start, trace_end, 0, player);
		if(trace_result[#"fraction"] < 1 && trace_result[#"normal"][2] < 0.7)
		{
			hit_distance = trace_result[#"fraction"] * trace_distance;
			player_radius = 15;
			var_91900283 = 100;
			var_3083dd99 = trace_start + (vectorscale(forward, hit_distance - player_radius));
			var_1ddb7a9a = var_3083dd99 + (0, 0, var_91900283 * -1);
			ground_trace = bullettrace(var_3083dd99, var_1ddb7a9a, 0, player);
			if(ground_trace[#"fraction"] < 1)
			{
				var_a9f17307 = var_3083dd99 + (vectorscale((0, 0, -1), ground_trace[#"fraction"] * var_91900283));
				var_8e35a928 = function_6bee89e8(local_client_num, current_weapon, var_a9f17307, trace_result[#"normal"] * -1);
				var_1b1c8c9f = trace_result[#"position"][2];
				min_height = 30;
				max_height = 50;
				var_3ee12918 = max_height - min_height;
				var_d914c241 = vectorscale(forward, 3);
				var_dd4ed37 = trace_result[#"position"] + var_d914c241;
				var_8c2f90f2 = (var_dd4ed37[0], var_dd4ed37[1], var_a9f17307[2] + min_height);
				var_dd4ed37 = (var_dd4ed37[0], var_dd4ed37[1], var_a9f17307[2] + max_height);
				var_8e88861f = bullettrace(var_dd4ed37, var_8c2f90f2, 0, player);
				if(var_8e88861f[#"fraction"] < 1)
				{
					var_f7fa6d81 = var_dd4ed37 + (vectorscale((0, 0, -1), var_8e88861f[#"fraction"] * var_3ee12918));
					var_1b1c8c9f = var_f7fa6d81[2];
				}
				mountable_point = (trace_result[#"position"][0], trace_result[#"position"][1], var_1b1c8c9f);
				if(var_8e35a928)
				{
					if(hit_distance < current_weapon.var_cddb5cd0 + player_radius)
					{
						var_982f06c8 = 1;
					}
				}
			}
		}
		if(0)
		{
			util::note_elapsed_time(start_time, "mountable previs time: ");
		}
	}
}

