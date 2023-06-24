// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1e43d05a138e08b9;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace player_insertion;

/*
	Name: __init__system__
	Namespace: player_insertion
	Checksum: 0x8997D7B0
	Offset: 0x3D8
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
	Checksum: 0x626FDFA3
	Offset: 0x420
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.playerinsertion = 1;
	spawnpoints = struct::get_array("infil_spawn", "targetname");
	/#
		if(spawnpoints.size == 0)
		{
			spawnpoints = struct::get_array("", "");
		}
	#/
	if(spawnpoints.size != 0)
	{
		level.var_1194a9a5 = spawnpoints;
	}
	init_clientfields();
	wz_wingsuit_hud::register("wz_wingsuit_hud");
	level.deathcirclerespawn = getgametypesetting(#"deathcirclerespawn");
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: init_clientfields
	Namespace: player_insertion
	Checksum: 0x4E939638
	Offset: 0x530
	Size: 0x54C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("vehicle", "infiltration_transport", 1, 1, "int", &function_ed1567cc, 0, 0);
	clientfield::register("vehicle", "infiltration_landing_gear", 1, 1, "int", &function_ba7d9848, 0, 0);
	clientfield::register("toplayer", "infiltration_jump_warning", 1, 1, "int", &function_ded53cc6, 0, 0);
	clientfield::register("toplayer", "infiltration_final_warning", 1, 1, "int", &function_ea3cc318, 0, 0);
	clientfield::register("toplayer", "inside_infiltration_vehicle", 1, 1, "int", &inside_infiltration_vehicle, 0, 0);
	clientfield::register("world", "infiltration_compass", 1, 1, "int", &function_2d2fc272, 0, 0);
	clientfield::register("world", "infiltration_compass", 16000, 2, "int", &function_4da7bee9, 0, 0);
	clientfield::register("scriptmover", "infiltration_camera", 1, 2, "int", &function_a67b1f40, 0, 0);
	clientfield::register("scriptmover", "infiltration_camera", 16000, 3, "int", &function_7bac6764, 0, 0);
	clientfield::register("scriptmover", "infiltration_plane", 16000, 2, "int", &function_1f7ab61a, 0, 0);
	clientfield::register("scriptmover", "infiltration_ent", 16000, 2, "int", &infil_ent, 0, 0);
	clientfield::register("scriptmover", "infiltration_jump_point", 1, 1, "int", &function_81ac0c1, 0, 0);
	clientfield::register("scriptmover", "infiltration_jump_point", 16000, 2, "int", &function_73a03a18, 0, 0);
	clientfield::register("scriptmover", "infiltration_force_drop_point", 1, 1, "int", &function_35aed89d, 0, 0);
	clientfield::register("scriptmover", "infiltration_force_drop_point", 16000, 2, "int", &function_f1c37912, 0, 0);
	clientfield::register("toplayer", "heatblurpostfx", 1, 1, "int", &function_c9851cb, 0, 0);
	clientfield::register("vehicle", "warpportalfx", 15000, 1, "int", &function_c0c7c219, 0, 0);
	clientfield::register("vehicle", "warpportalfx_launch", 15000, 1, "counter", &function_9767bbd8, 0, 0);
	clientfield::register("toplayer", "warpportal_fx_wormhole", 15000, 1, "int", undefined, 0, 0);
}

/*
	Name: on_localclient_connect
	Namespace: player_insertion
	Checksum: 0xCDA4CE1D
	Offset: 0xA88
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
	if(var_7eb8f61a == 1)
	{
		level thread function_6c4ae982(localclientnum);
	}
}

/*
	Name: function_a4c14f8c
	Namespace: player_insertion
	Checksum: 0x7F1ACB3E
	Offset: 0xB20
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a4c14f8c(value)
{
	return value & 1;
}

/*
	Name: function_ff16ec5f
	Namespace: player_insertion
	Checksum: 0x93A1FDDD
	Offset: 0xB40
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ff16ec5f(value)
{
	return (~value) & 1;
}

/*
	Name: function_76a4b21e
	Namespace: player_insertion
	Checksum: 0x222E4C4B
	Offset: 0xB60
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_76a4b21e(value)
{
	return value >> 1;
}

/*
	Name: function_6c4ae982
	Namespace: player_insertion
	Checksum: 0x3C8B53CB
	Offset: 0xB80
	Size: 0x1AC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6c4ae982(localclientnum)
{
	var_d5823792 = 0;
	var_b9d612e8 = 0;
	var_a106daf5 = 0;
	while(true)
	{
		local_player = function_5c10bd79(localclientnum);
		if(isdefined(local_player))
		{
			if(!local_player hasdobj(localclientnum))
			{
				waitframe(1);
				continue;
			}
		}
		if(isdefined(local_player))
		{
			wormhole_fx = local_player clientfield::get_to_player("warpportal_fx_wormhole");
			if(wormhole_fx === 1 && !var_d5823792)
			{
				var_d5823792 = 1;
				playsound(localclientnum, #"hash_37244e4f8de40dd5");
				local_player codeplaypostfxbundle("pstfx_wz_esc_tele_reveal");
				local_player codeplaypostfxbundle("pstfx_wz_esc_tele_sprites");
			}
			else if(wormhole_fx === 0 && var_d5823792)
			{
				var_d5823792 = 0;
				local_player function_3f145588("pstfx_wz_esc_tele_reveal");
				local_player function_3f145588("pstfx_wz_esc_tele_sprites");
			}
		}
		else
		{
			return;
		}
		waitframe(1);
	}
}

/*
	Name: function_ed1567cc
	Namespace: player_insertion
	Checksum: 0x8C78CCDA
	Offset: 0xD38
	Size: 0x19C
	Parameters: 7
	Flags: Linked
*/
function function_ed1567cc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(1)
		{
			self function_d309e55a("tag_cargo_ramp_control_animate", 1);
			self function_d309e55a("tag_door_left_control_animate", 1);
			self function_d309e55a("tag_door_right_control_animate", 1);
		}
		else
		{
			self function_d309e55a("tag_ramp_control_animate", 1);
		}
		self playsound(0, #"hash_329be5a324e42ee1");
		level notify(#"hash_5975d5f569535c41");
	}
	else
	{
		if(1)
		{
			self function_d309e55a("tag_cargo_ramp_control_animate", 0);
			self function_d309e55a("tag_door_left_control_animate", 0);
			self function_d309e55a("tag_door_right_control_animate", 0);
		}
		else
		{
			self function_d309e55a("tag_ramp_control_animate", 0);
		}
	}
}

/*
	Name: function_ba7d9848
	Namespace: player_insertion
	Checksum: 0x2C27231D
	Offset: 0xEE0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_ba7d9848(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(1)
	{
		if(newval)
		{
			self function_d309e55a("tag_landing_gear_control_animate", 1);
		}
		else
		{
			self function_d309e55a("tag_landing_gear_control_animate", 0);
		}
	}
}

/*
	Name: function_ded53cc6
	Namespace: player_insertion
	Checksum: 0xC0882FE7
	Offset: 0xF78
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_ded53cc6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1 && oldval != newval)
	{
		self playsound(0, #"hash_7ba1b4b83540b238");
	}
}

/*
	Name: function_ea3cc318
	Namespace: player_insertion
	Checksum: 0xA4660A0B
	Offset: 0x1000
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function function_ea3cc318(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self function_da43934d())
	{
		if(newval == 1 && oldval != newval)
		{
			self playsound(0, #"hash_783bdfd900c11eed");
		}
	}
}

/*
	Name: function_8c515e6
	Namespace: player_insertion
	Checksum: 0xEEED1FD6
	Offset: 0x10A0
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8c515e6(player)
{
	self notify("23c1f5278d3016e8");
	self endon("23c1f5278d3016e8");
	self waittill(#"death");
	if(isdefined(player) && player isplayer())
	{
		player camerasetupdatecallback();
	}
}

/*
	Name: function_a67b1f40
	Namespace: player_insertion
	Checksum: 0xE2C4DD3B
	Offset: 0x1118
	Size: 0x17C
	Parameters: 7
	Flags: Linked
*/
function function_a67b1f40(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.var_88a92c26 = self;
	function_1b88c5(localclientnum, 0, self);
	self setcompassicon("t8_hud_waypoints_drone_hunter_scaled_down");
	player = function_5c10bd79(localclientnum);
	if(!isdefined(player))
	{
		return;
	}
	if(newval == 0)
	{
		player camerasetupdatecallback();
	}
	else
	{
		if(newval == 1)
		{
			self camerasetupdatecallback(&function_cbe63de1);
			self thread function_8c515e6(player);
			player function_ec94346();
		}
		else if(newval == 2)
		{
			self camerasetupdatecallback(&function_c8ea4bcc);
			self thread function_8c515e6(player);
		}
	}
}

/*
	Name: function_7bac6764
	Namespace: player_insertion
	Checksum: 0x4D7CE365
	Offset: 0x12A0
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_7bac6764(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.var_88a92c26 = self;
	player = function_5c10bd79(localclientnum);
	if(!isdefined(player))
	{
		return;
	}
	value = function_76a4b21e(newval);
	if(value == 0)
	{
		player camerasetupdatecallback();
	}
	else
	{
		if(value == 1)
		{
			self camerasetupdatecallback(&function_cbe63de1);
			self thread function_8c515e6(player);
			player function_ec94346();
		}
		else if(value == 2)
		{
			self camerasetupdatecallback(&function_c8ea4bcc);
			self thread function_8c515e6(player);
		}
	}
}

/*
	Name: function_1f7ab61a
	Namespace: player_insertion
	Checksum: 0x8CE427D6
	Offset: 0x1400
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_1f7ab61a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	function_1b88c5(localclientnum, function_a4c14f8c(newval), self);
	self setcompassicon("t8_hud_waypoints_drone_hunter_scaled_down");
}

/*
	Name: infil_ent
	Namespace: player_insertion
	Checksum: 0xACFC63CE
	Offset: 0x1490
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function infil_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_1e7db62f = function_a4c14f8c(newval);
	var_36f945fe = function_ff16ec5f(newval);
	function_c8ae746a(localclientnum, var_1e7db62f, 1);
	function_c8ae746a(localclientnum, var_36f945fe, 0);
}

/*
	Name: function_cbe63de1
	Namespace: player_insertion
	Checksum: 0x27856247
	Offset: 0x1558
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function function_cbe63de1(localclientnum, delta_t)
{
	player = function_5c10bd79(localclientnum);
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(level.var_88a92c26))
	{
		player camerasetposition(player.origin);
		player camerasetlookat(player.angles);
		return;
	}
	var_c9c16c96 = level.var_88a92c26.origin;
	var_6775ae79 = level.var_88a92c26.angles;
	/#
		assert(isdefined(var_6775ae79), "");
	#/
	if(!isdefined(var_6775ae79))
	{
		var_6775ae79 = player getcamangles();
		if(!isdefined(var_6775ae79))
		{
			var_6775ae79 = (isdefined(player.angles) ? player.angles : (0, 0, 0));
		}
	}
	cameravec = anglestoforward(var_6775ae79);
	camerapos = var_c9c16c96 - (1600 * cameravec);
	player camerasetposition(camerapos);
	player camerasetlookat(var_6775ae79);
}

/*
	Name: function_c8ea4bcc
	Namespace: player_insertion
	Checksum: 0xDF7937FB
	Offset: 0x1708
	Size: 0x21C
	Parameters: 2
	Flags: Linked
*/
function function_c8ea4bcc(localclientnum, delta_t)
{
	player = function_5c10bd79(localclientnum);
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(level.var_88a92c26))
	{
		player camerasetposition(player.origin);
		player camerasetlookat(player.angles);
		return;
	}
	var_c9c16c96 = level.var_88a92c26.origin;
	var_6775ae79 = player getcamangles();
	if(!isdefined(var_6775ae79))
	{
		player camerasetlookat(player.angles);
		var_6775ae79 = player getcamangles();
		if(!isdefined(var_6775ae79))
		{
			var_6775ae79 = (isdefined(player.angles) ? player.angles : (0, 0, 0));
		}
	}
	cameravec = anglestoforward(var_6775ae79);
	camerapos = var_c9c16c96 - (1600 * cameravec);
	player camerasetposition(camerapos);
	player camerasetlookat(var_6775ae79);
	player function_36b630a3(0);
	player callback::add_entity_callback(#"freefall", &function_c9a18304);
	player callback::add_entity_callback(#"on_start_gametype", &function_c9a18304);
}

/*
	Name: function_84ba1c41
	Namespace: player_insertion
	Checksum: 0x33444006
	Offset: 0x1930
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_84ba1c41(local_client_num, eventstruct)
{
	if(!eventstruct.parachute)
	{
		function_f9e5d4d3(local_client_num, eventstruct);
	}
}

/*
	Name: function_f9e5d4d3
	Namespace: player_insertion
	Checksum: 0x8AD0A71F
	Offset: 0x1978
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_f9e5d4d3(local_client_num, eventstruct)
{
	if(isdefined(self.var_13a5716d) && self.var_13a5716d)
	{
		self.var_13a5716d = undefined;
		self callback::function_52ac9652(#"parachute", &function_84ba1c41);
		self callback::function_52ac9652(#"death", &function_f9e5d4d3);
	}
}

/*
	Name: function_ec94346
	Namespace: player_insertion
	Checksum: 0xB410683F
	Offset: 0x1A18
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_ec94346()
{
	self.var_13a5716d = 1;
	self callback::add_entity_callback(#"parachute", &function_84ba1c41);
	self callback::add_entity_callback(#"death", &function_f9e5d4d3);
}

/*
	Name: function_c9a18304
	Namespace: player_insertion
	Checksum: 0xECB9981
	Offset: 0x1A98
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function function_c9a18304(local_client_num, eventstruct)
{
	if(eventstruct.freefall)
	{
		self callback::remove_callback(#"freefall", &function_c9a18304);
		self function_36b630a3(1);
	}
}

/*
	Name: function_81ac0c1
	Namespace: player_insertion
	Checksum: 0x8A4109DB
	Offset: 0x1B10
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_81ac0c1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_a3ede655))
	{
		level.var_a3ede655 = [];
	}
	else if(!isarray(level.var_a3ede655))
	{
		level.var_a3ede655 = array(level.var_a3ede655);
	}
	level.var_a3ede655[0] = self;
}

/*
	Name: function_73a03a18
	Namespace: player_insertion
	Checksum: 0xB92CC1D0
	Offset: 0x1BD8
	Size: 0xDA
	Parameters: 7
	Flags: Linked
*/
function function_73a03a18(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_1e7db62f = function_a4c14f8c(newval);
	if(!isdefined(level.var_a3ede655))
	{
		level.var_a3ede655 = [];
	}
	else if(!isarray(level.var_a3ede655))
	{
		level.var_a3ede655 = array(level.var_a3ede655);
	}
	level.var_a3ede655[var_1e7db62f] = self;
}

/*
	Name: function_35aed89d
	Namespace: player_insertion
	Checksum: 0xBBF34631
	Offset: 0x1CC0
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_35aed89d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_697988b1))
	{
		level.var_697988b1 = [];
	}
	else if(!isarray(level.var_697988b1))
	{
		level.var_697988b1 = array(level.var_697988b1);
	}
	level.var_697988b1[0] = self;
}

/*
	Name: function_f1c37912
	Namespace: player_insertion
	Checksum: 0x19AD8DD3
	Offset: 0x1D88
	Size: 0xDA
	Parameters: 7
	Flags: Linked
*/
function function_f1c37912(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_1e7db62f = function_a4c14f8c(newval);
	if(!isdefined(level.var_697988b1))
	{
		level.var_697988b1 = [];
	}
	else if(!isarray(level.var_697988b1))
	{
		level.var_697988b1 = array(level.var_697988b1);
	}
	level.var_697988b1[var_1e7db62f] = self;
}

/*
	Name: function_65cca2e1
	Namespace: player_insertion
	Checksum: 0xB289453A
	Offset: 0x1E70
	Size: 0x23C
	Parameters: 2
	Flags: Linked
*/
function function_65cca2e1(localclientnum, var_1e7db62f)
{
	self notify(#"hash_503cb9224ca331c" + var_1e7db62f);
	self endon(#"hash_503cb9224ca331c" + var_1e7db62f);
	while(true)
	{
		if(isdefined(level.var_a3ede655) && isdefined(level.var_a3ede655[var_1e7db62f]) && isdefined(level.var_697988b1) && isdefined(level.var_697988b1[var_1e7db62f]))
		{
			break;
		}
		waitframe(1);
	}
	jump_point = level.var_a3ede655[var_1e7db62f].origin;
	force_drop_point = level.var_697988b1[var_1e7db62f].origin;
	direction = anglestoforward(level.var_a3ede655[var_1e7db62f].angles);
	start_point = jump_point - (direction * 150000);
	end_point = force_drop_point + (direction * 150000);
	var_5a20cc9d = createuimodel(getuimodelforcontroller(localclientnum), "hudItems.freeFallStartAltitude");
	setuimodelvalue(var_5a20cc9d, jump_point[2]);
	var_7eb8f61a = (isdefined(getgametypesetting(#"hash_648fb3af9bc11566")) ? getgametypesetting(#"hash_648fb3af9bc11566") : 0);
	if(var_7eb8f61a == 0)
	{
		function_4dfe3112(localclientnum, var_1e7db62f, start_point, end_point, jump_point, force_drop_point);
	}
}

/*
	Name: function_2d2fc272
	Namespace: player_insertion
	Checksum: 0x9249D699
	Offset: 0x20B8
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_2d2fc272(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		level thread function_65cca2e1(localclientnum, 0);
		function_c8ae746a(localclientnum, 0, 1);
	}
	else
	{
		self notify(#"hash_503cb9224ca331c" + 0);
		function_c8ae746a(localclientnum, 0, 0);
		function_71fec565(localclientnum, 0);
	}
}

/*
	Name: function_4da7bee9
	Namespace: player_insertion
	Checksum: 0xFF9152FC
	Offset: 0x2198
	Size: 0x14E
	Parameters: 7
	Flags: Linked
*/
function function_4da7bee9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	for(var_1e7db62f = 0; var_1e7db62f < 2; var_1e7db62f++)
	{
		oldvalue = oldval & 1;
		value = newval & 1;
		newval = newval >> 1;
		oldval = oldval >> 1;
		if(oldvalue == value && !binitialsnap)
		{
			continue;
		}
		if(value)
		{
			level thread function_65cca2e1(localclientnum, var_1e7db62f);
			continue;
		}
		self notify(#"hash_503cb9224ca331c" + var_1e7db62f);
		function_c8ae746a(localclientnum, var_1e7db62f, 0);
		function_71fec565(localclientnum, var_1e7db62f);
	}
}

/*
	Name: inside_infiltration_vehicle
	Namespace: player_insertion
	Checksum: 0x754EF2E8
	Offset: 0x22F0
	Size: 0xF8
	Parameters: 7
	Flags: Linked
*/
function inside_infiltration_vehicle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "hudItems.infiltrationVehicle"), newval);
	if(newval)
	{
		self function_811196d1(1);
	}
	else
	{
		self notify(#"hash_70483f3d5a2f87f0");
		self function_811196d1(0);
		self camerasetupdatecallback();
		level notify(#"hash_413d64e47311dcf8");
	}
}

/*
	Name: function_c9851cb
	Namespace: player_insertion
	Checksum: 0xAA5F99EF
	Offset: 0x23F0
	Size: 0x84
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c9851cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self codeplaypostfxbundle("pstfx_heat_distortion");
	}
	else
	{
		self codestoppostfxbundle("pstfx_heat_distortion");
	}
}

/*
	Name: function_9767bbd8
	Namespace: player_insertion
	Checksum: 0xB0E7AED2
	Offset: 0x2480
	Size: 0x64
	Parameters: 7
	Flags: Linked, Private
*/
function private function_9767bbd8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, #"hash_3697b0b0d7cd6874", self.origin);
}

/*
	Name: function_c0c7c219
	Namespace: player_insertion
	Checksum: 0x698CC300
	Offset: 0x24F0
	Size: 0x132
	Parameters: 7
	Flags: Linked, Private
*/
function private function_c0c7c219(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		player = function_5c10bd79(localclientnum);
		player function_ec94346();
		if(isdefined(self.var_227361c6))
		{
			stopfx(localclientnum, self.var_227361c6);
		}
		self.var_227361c6 = playfx(localclientnum, #"hash_28b5c6ccaabb4afe", self.origin);
	}
	else
	{
		if(isdefined(self.var_227361c6))
		{
			stopfx(localclientnum, self.var_227361c6);
		}
		self.var_227361c6 = playfx(localclientnum, #"hash_45086f1ffcabbf47", self.origin);
	}
}

