// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_bgb_anywhere_but_here;

/*
	Name: __init__system__
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0x98EE2FA0
	Offset: 0x1C0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_anywhere_but_here", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0x6E971A9A
	Offset: 0x210
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	level._effect[#"teleport_splash"] = "zombie/fx_bgb_anywhere_but_here_teleport_zmb";
	level._effect[#"teleport_aoe"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_zmb";
	level._effect[#"teleport_aoe_kill"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
	bgb::register(#"zm_bgb_anywhere_but_here", "activated", 1, undefined, undefined, &validation, &activation);
	bgb::function_72469efe(#"zm_bgb_anywhere_but_here", 1);
	bgb::function_8a5d8cfb(#"zm_bgb_anywhere_but_here", 1);
}

/*
	Name: activation
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0x655F2E10
	Offset: 0x358
	Size: 0x81E
	Parameters: 1
	Flags: Linked
*/
function activation(var_fad9ed02 = 1)
{
	self endon(#"disconnect");
	self val::set(#"hash_7d2b25df35ca5b3", "ignoreme");
	self.var_ffe2c4d7 = 1;
	zm_ai_utility::function_594bb7bd(self);
	if(self zm_utility::function_ab9a9770())
	{
		self.var_b520496e = 1;
	}
	if(ispointonnavmesh(self.origin))
	{
		playsoundatposition(#"zmb_bgb_abh_teleport_out", self.origin);
	}
	if(isdefined(level.var_f44e37f7))
	{
		s_respawn_point = self [[level.var_f44e37f7]]();
	}
	else
	{
		s_respawn_point = self function_91a62549();
	}
	if(isdefined(level.var_40f4bfe0) && level.var_40f4bfe0 || (!isdefined(s_respawn_point) && !var_fad9ed02))
	{
		s_respawn_point = struct::spawn(self.origin, self.angles);
		var_16d4797c = getclosestpointonnavmesh(self.origin, 128, 24);
		s_respawn_point.origin = (isdefined(var_16d4797c) ? var_16d4797c : s_respawn_point.origin);
	}
	/#
		assert(isdefined(s_respawn_point), "" + self.origin);
	#/
	if(!isdefined(s_respawn_point))
	{
		self val::reset(#"hash_7d2b25df35ca5b3", "ignoreme");
		self.var_ffe2c4d7 = undefined;
		return;
	}
	if(isdefined(self.var_b520496e) && self.var_b520496e)
	{
		e_link = util::spawn_model("tag_origin", s_respawn_point.origin, s_respawn_point.angles);
		self setplayerangles(s_respawn_point.angles);
		self linkto(e_link);
	}
	else
	{
		self setorigin(s_respawn_point.origin);
		self setplayerangles(s_respawn_point.angles);
	}
	self val::set(#"hash_7d2b25df35ca5b3", "freezecontrols", 1);
	v_return_pos = self.origin + vectorscale((0, 0, 1), 60);
	a_ai = getaiteamarray(level.zombie_team);
	a_closest = [];
	ai_closest = undefined;
	if(a_ai.size)
	{
		a_closest = arraysortclosest(a_ai, self.origin);
		foreach(ai in a_closest)
		{
			n_trace_val = ai sightconetrace(v_return_pos, self);
			if(n_trace_val > 0.2)
			{
				ai_closest = ai;
				break;
			}
		}
		if(isdefined(ai_closest))
		{
			self setplayerangles(vectortoangles(ai_closest getcentroid() - v_return_pos));
		}
	}
	self playsound(#"zmb_bgb_abh_teleport_in");
	if(isdefined(level.var_a9c40fde))
	{
		self [[level.var_a9c40fde]]();
	}
	wait(0.5);
	if(isdefined(self.var_b520496e) && self.var_b520496e)
	{
		self unlink();
		self.var_b520496e = undefined;
		e_link delete();
	}
	self show();
	playfx(level._effect[#"teleport_splash"], self.origin);
	playfx(level._effect[#"teleport_aoe"], self.origin);
	a_ai = getaiarray();
	a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);
	foreach(ai in a_aoe_ai)
	{
		if(isactor(ai))
		{
			if(ai.archetype === #"zombie")
			{
				playfx(level._effect[#"teleport_aoe_kill"], ai gettagorigin("j_spineupper"));
			}
			else
			{
				playfx(level._effect[#"teleport_aoe_kill"], ai.origin);
			}
			ai playsound(#"hash_22ff6701cf652785");
			ai.marked_for_recycle = 1;
			ai.has_been_damaged_by_player = 0;
			ai dodamage(ai.health + 1000, self.origin, self);
		}
	}
	wait(0.2);
	self val::reset(#"hash_7d2b25df35ca5b3", "freezecontrols");
	if(var_fad9ed02)
	{
		self zm_stats::increment_challenge_stat(#"gum_gobbler_anywhere_but_here");
	}
	self.var_ffe2c4d7 = undefined;
	wait(3);
	self val::reset(#"hash_7d2b25df35ca5b3", "ignoreme");
	self notify(#"hash_3e4335abc3d58a0b");
}

/*
	Name: validation
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0xAC0DFFDD
	Offset: 0xB80
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(level.var_2439365b === #"turret")
	{
		return 0;
	}
	if(isdefined(level.zm_bgb_anywhere_but_here_validation_override))
	{
		return [[level.zm_bgb_anywhere_but_here_validation_override]]();
	}
	s_point = function_91a62549();
	if(!isdefined(s_point))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_91a62549
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0xEB8B1656
	Offset: 0xBF8
	Size: 0x2A8
	Parameters: 0
	Flags: Linked
*/
function function_91a62549()
{
	var_c73799d9 = zm_zonemgr::get_zone_from_position(self.origin + vectorscale((0, 0, 1), 32), 0);
	if(!isdefined(var_c73799d9))
	{
		var_c73799d9 = self.zone_name;
	}
	if(isdefined(var_c73799d9))
	{
		var_599d66bd = level.zones[var_c73799d9];
	}
	a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
	a_s_valid_respawn_points = [];
	foreach(s_respawn_point in a_s_respawn_points)
	{
		if(zm_utility::is_point_inside_enabled_zone(s_respawn_point.origin, var_599d66bd))
		{
			if(!isdefined(a_s_valid_respawn_points))
			{
				a_s_valid_respawn_points = [];
			}
			else if(!isarray(a_s_valid_respawn_points))
			{
				a_s_valid_respawn_points = array(a_s_valid_respawn_points);
			}
			a_s_valid_respawn_points[a_s_valid_respawn_points.size] = s_respawn_point;
		}
	}
	if(isdefined(level.var_e120ae98))
	{
		a_s_valid_respawn_points = [[level.var_e120ae98]](a_s_valid_respawn_points);
	}
	s_player_respawn = undefined;
	if(a_s_valid_respawn_points.size > 0)
	{
		var_53b1aa43 = array::random(a_s_valid_respawn_points);
		var_5ce8e5f9 = struct::get_array(var_53b1aa43.target, "targetname");
		foreach(var_5aff2c2c in var_5ce8e5f9)
		{
			n_script_int = self getentitynumber() + 1;
			if(var_5aff2c2c.script_int === n_script_int)
			{
				s_player_respawn = var_5aff2c2c;
			}
		}
	}
	return s_player_respawn;
}

/*
	Name: function_886fce8f
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0xF7C437D
	Offset: 0xEA8
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_886fce8f(b_enable = 1)
{
	if(b_enable)
	{
		level.var_e120ae98 = level.var_ddf7e6bc;
		level.var_ddf7e6bc = undefined;
		level.var_40f4bfe0 = undefined;
	}
	else
	{
		level.var_ddf7e6bc = level.var_e120ae98;
		level.var_e120ae98 = &function_a124fd99;
		level.var_40f4bfe0 = 1;
	}
}

/*
	Name: function_a124fd99
	Namespace: zm_bgb_anywhere_but_here
	Checksum: 0xD8DB9D10
	Offset: 0xF48
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_a124fd99(var_6a069cf8)
{
	return [];
}

