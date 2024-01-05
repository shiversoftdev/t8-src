// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace zm_bgb_nowhere_but_there;

/*
	Name: __init__system__
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0xB2481D58
	Offset: 0x1F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_nowhere_but_there", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x37EF422B
	Offset: 0x240
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	level._effect[#"hash_8393b410b8f909d"] = "zombie/fx_bgb_anywhere_but_here_teleport_zmb";
	level._effect[#"hash_8b86393f63bb1ef"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_zmb";
	level._effect[#"hash_1eae5969d11a8b16"] = "zombie/fx_bgb_anywhere_but_here_teleport_aoe_kill_zmb";
	bgb::register(#"zm_bgb_nowhere_but_there", "activated", 1, undefined, undefined, &validation, &activation);
	bgb::function_72469efe(#"zm_bgb_nowhere_but_there", 1);
	bgb::function_8a5d8cfb(#"zm_bgb_nowhere_but_there", 1);
	bgb::function_1fee6b3(#"zm_bgb_nowhere_but_there", 15);
	callback::on_revived(&on_revived);
}

/*
	Name: activation
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x944C64E5
	Offset: 0x3D0
	Size: 0x604
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	self endon(#"disconnect");
	self val::set(#"zm_bgb_nowhere_but_there", "ignoreme");
	self.var_25c3de32 = 1;
	zm_ai_utility::function_594bb7bd(self);
	if(ispointonnavmesh(self.origin))
	{
		playsoundatposition(#"zmb_bgb_abh_teleport_out", self.origin);
	}
	if(isdefined(level.var_5cfc800b))
	{
		s_respawn_point = self [[level.var_5cfc800b]]();
	}
	else
	{
		s_respawn_point = self function_fdc3c7c4();
	}
	if(!isdefined(s_respawn_point))
	{
		s_respawn_point = spawnstruct();
		s_respawn_point.origin = self.origin;
		s_respawn_point.angles = self.angles;
		self.var_ca944973 = self.origin;
	}
	if(isdefined(self.var_aba36467) && self.var_aba36467)
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
	self val::set(#"zm_bgb_nowhere_but_there", "freezecontrols", 1);
	v_return_pos = self.origin + vectorscale((0, 0, 1), 60);
	self playsound(#"zmb_bgb_abh_teleport_in");
	if(isdefined(level.var_1e480ea7))
	{
		self [[level.var_1e480ea7]]();
	}
	wait(0.5);
	if(isdefined(self.var_aba36467) && self.var_aba36467)
	{
		self unlink();
		self.var_aba36467 = undefined;
		e_link delete();
	}
	self show();
	playfx(level._effect[#"hash_8393b410b8f909d"], self.origin);
	playfx(level._effect[#"hash_8b86393f63bb1ef"], self.origin);
	a_ai = getaiarray();
	a_aoe_ai = arraysortclosest(a_ai, self.origin, a_ai.size, 0, 200);
	foreach(ai in a_aoe_ai)
	{
		if(isactor(ai))
		{
			if(ai.archetype === #"zombie")
			{
				playfx(level._effect[#"hash_1eae5969d11a8b16"], ai gettagorigin("j_spineupper"));
			}
			else
			{
				playfx(level._effect[#"hash_1eae5969d11a8b16"], ai.origin);
			}
			ai.marked_for_recycle = 1;
			ai.has_been_damaged_by_player = 0;
			ai playsound(#"hash_22ff6701cf652785");
			ai dodamage(ai.health + 1000, self.origin, self);
		}
	}
	wait(0.2);
	self val::reset(#"zm_bgb_nowhere_but_there", "freezecontrols");
	self thread function_87fa80cf();
	self.var_25c3de32 = undefined;
	wait(3);
	self val::reset(#"zm_bgb_nowhere_but_there", "ignoreme");
	self.var_ca944973 = undefined;
	self notify(#"hash_55489b8cb6c75352");
	if(isdefined(s_respawn_point.var_72d2300b) && s_respawn_point.var_72d2300b)
	{
		s_respawn_point struct::delete();
	}
}

/*
	Name: is_valid_target
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x7DA8175F
	Offset: 0x9E0
	Size: 0xAA
	Parameters: 1
	Flags: Linked
*/
function is_valid_target(e_player)
{
	if(!isdefined(e_player))
	{
		return 0;
	}
	if(isdefined(level.registerquest_key_pickup_explode))
	{
		return [[level.registerquest_key_pickup_explode]](e_player);
	}
	if(e_player != self && e_player laststand::player_is_in_laststand() && (!(isdefined(e_player.var_16735873) && e_player.var_16735873)) && !e_player zm_utility::function_ab9a9770())
	{
		return 1;
	}
	return 0;
}

/*
	Name: validation
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0xF7FB38E0
	Offset: 0xA98
	Size: 0x108
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(level.var_2439365b === #"turret")
	{
		return 0;
	}
	if(isdefined(level.var_d97d59d7))
	{
		return [[level.var_d97d59d7]]();
	}
	foreach(player in util::get_active_players())
	{
		if(is_valid_target(player))
		{
			s_player_respawn = self get_best_spawnpoint(player);
			if(isdefined(s_player_respawn))
			{
				s_player_respawn struct::delete();
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_fdc3c7c4
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0xA1EB30EE
	Offset: 0xBA8
	Size: 0x1FA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fdc3c7c4()
{
	var_fded3d81 = [];
	foreach(player in level.activeplayers)
	{
		if(is_valid_target(player))
		{
			if(!isdefined(var_fded3d81))
			{
				var_fded3d81 = [];
			}
			else if(!isarray(var_fded3d81))
			{
				var_fded3d81 = array(var_fded3d81);
			}
			var_fded3d81[var_fded3d81.size] = player;
		}
	}
	if(var_fded3d81.size)
	{
		arraysortclosest(var_fded3d81, self.origin);
		var_fded3d81 = array::reverse(var_fded3d81);
	}
	else
	{
		if(!isdefined(var_fded3d81))
		{
			var_fded3d81 = [];
		}
		else if(!isarray(var_fded3d81))
		{
			var_fded3d81 = array(var_fded3d81);
		}
		var_fded3d81[var_fded3d81.size] = self;
	}
	foreach(player in var_fded3d81)
	{
		s_player_respawn = self get_best_spawnpoint(player);
		if(isdefined(s_player_respawn))
		{
			return s_player_respawn;
		}
	}
	return undefined;
}

/*
	Name: get_best_spawnpoint
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x976C288F
	Offset: 0xDB0
	Size: 0x8D6
	Parameters: 1
	Flags: Linked
*/
function get_best_spawnpoint(e_player)
{
	v_forward = anglestoforward(e_player.angles);
	var_8afe96c9 = e_player.origin + (v_forward * 64);
	var_8afe96c9 = getclosestpointonnavmesh(var_8afe96c9, 100, 24);
	var_36bf7c2c = util::spawn_model("tag_origin", var_8afe96c9);
	var_8afe96c9 = var_36bf7c2c.origin;
	var_40b8a6a8 = self function_22e77bc1(var_36bf7c2c, var_8afe96c9, e_player);
	if(!var_40b8a6a8)
	{
		var_8afe96c9 = e_player.origin + ((v_forward * -1) * 64);
		var_8afe96c9 = getclosestpointonnavmesh(var_8afe96c9, 128, 24);
		var_2632943e = util::spawn_model("tag_origin", var_8afe96c9);
		var_40b8a6a8 = self function_22e77bc1(var_36bf7c2c, var_8afe96c9, e_player);
	}
	if(var_40b8a6a8 && isdefined(var_8afe96c9) && !positionwouldtelefrag(var_8afe96c9))
	{
		v_dir = vectornormalize(e_player.origin - var_8afe96c9);
		v_angles = vectortoangles(v_dir);
		var_5aff2c2c = spawnstruct();
		var_5aff2c2c.var_72d2300b = 1;
		var_5aff2c2c.origin = var_8afe96c9;
		var_5aff2c2c.angles = v_angles;
		self.var_ca944973 = var_8afe96c9;
		return var_5aff2c2c;
	}
	var_8666ff27 = e_player zm_zonemgr::get_player_zone();
	if(!isdefined(var_8666ff27))
	{
		return undefined;
	}
	self.var_ca944973 = e_player.origin;
	a_s_respawn_points = struct::get_array("player_respawn_point", "targetname");
	a_s_valid_respawn_points = [];
	var_ed38ae06 = [];
	foreach(s_respawn_point in a_s_respawn_points)
	{
		if(zm_utility::check_point_in_enabled_zone(s_respawn_point.origin, 1))
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
			var_5ce8e5f9 = struct::get_array(s_respawn_point.target, "targetname");
			foreach(var_5aff2c2c in var_5ce8e5f9)
			{
				n_script_int = self getentitynumber() + 1;
				if(var_5aff2c2c.script_int === n_script_int)
				{
					if(!positionwouldtelefrag(var_5aff2c2c.origin))
					{
						if(!isdefined(var_ed38ae06))
						{
							var_ed38ae06 = [];
						}
						else if(!isarray(var_ed38ae06))
						{
							var_ed38ae06 = array(var_ed38ae06);
						}
						var_ed38ae06[var_ed38ae06.size] = var_5aff2c2c.origin;
					}
				}
			}
		}
	}
	foreach(var_e15a68a8 in level.zones[var_8666ff27].a_loc_types[#"wait_location"])
	{
		if(zm_utility::check_point_in_enabled_zone(var_e15a68a8.origin, 1))
		{
			if(!isdefined(a_s_valid_respawn_points))
			{
				a_s_valid_respawn_points = [];
			}
			else if(!isarray(a_s_valid_respawn_points))
			{
				a_s_valid_respawn_points = array(a_s_valid_respawn_points);
			}
			a_s_valid_respawn_points[a_s_valid_respawn_points.size] = var_e15a68a8;
			if(!isdefined(var_ed38ae06))
			{
				var_ed38ae06 = [];
			}
			else if(!isarray(var_ed38ae06))
			{
				var_ed38ae06 = array(var_ed38ae06);
			}
			var_ed38ae06[var_ed38ae06.size] = var_e15a68a8.origin;
		}
	}
	if(isdefined(level.var_eeb98313))
	{
		a_s_valid_respawn_points = [[level.var_eeb98313]](a_s_valid_respawn_points);
	}
	v_target = e_player.origin;
	if(!ispointonnavmesh(v_target))
	{
		v_target = getclosestpointonnavmesh(v_target, 64);
	}
	var_ed38ae06 = arraysortclosest(var_ed38ae06, v_target, 16);
	s_pathdata = generatenavmeshpath(v_target, var_ed38ae06);
	var_bbf0b888 = abs(distance(self.origin, e_player.origin)) + 300;
	var_bbf0b888 = math::clamp(var_bbf0b888, 1, 1000);
	if(isdefined(s_pathdata))
	{
		var_ed38ae06 = s_pathdata.pathpoints;
		var_68eca602 = s_pathdata.pathdistance;
		arrayremoveindex(var_ed38ae06, 0);
		var_ed38ae06 = array::reverse(var_ed38ae06);
		if(var_68eca602 >= var_bbf0b888)
		{
			return undefined;
		}
	}
	else
	{
		var_ed38ae06 = arraysortclosest(var_ed38ae06, e_player.origin, 3, undefined, var_bbf0b888);
	}
	foreach(var_536bc51d in var_ed38ae06)
	{
		if(!positionwouldtelefrag(var_536bc51d))
		{
			v_dir = vectornormalize(e_player.origin - var_536bc51d);
			v_angles = vectortoangles(v_dir);
			var_5aff2c2c = spawnstruct();
			var_5aff2c2c.var_72d2300b = 1;
			var_5aff2c2c.origin = var_536bc51d;
			var_5aff2c2c.angles = v_angles;
			self.var_ca944973 = var_536bc51d;
			return var_5aff2c2c;
		}
	}
	return undefined;
}

/*
	Name: function_22e77bc1
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x40457D
	Offset: 0x1690
	Size: 0x14C
	Parameters: 3
	Flags: Linked
*/
function function_22e77bc1(var_36bf7c2c, var_8afe96c9, e_player)
{
	if(isdefined(var_36bf7c2c) && (!zm_utility::check_point_in_enabled_zone(var_36bf7c2c.origin, 1) && !var_36bf7c2c zm_player::in_life_brush()))
	{
		if(isdefined(var_36bf7c2c))
		{
			var_36bf7c2c delete();
		}
		return false;
	}
	if(!(isdefined(bullettracepassed(e_player geteye() + vectorscale((0, 0, 1), 10), var_8afe96c9, 0, self, e_player, 0, 1)) && bullettracepassed(e_player geteye() + vectorscale((0, 0, 1), 10), var_8afe96c9, 0, self, e_player, 0, 1)))
	{
		if(isdefined(var_36bf7c2c))
		{
			var_36bf7c2c delete();
		}
		return false;
	}
	return true;
}

/*
	Name: function_8bec47d6
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x6CB933E3
	Offset: 0x17E8
	Size: 0x76
	Parameters: 1
	Flags: None
*/
function function_8bec47d6(b_enable = 1)
{
	if(b_enable)
	{
		level.var_eeb98313 = level.var_fcfbf8c6;
		level.var_fcfbf8c6 = undefined;
	}
	else
	{
		level.var_fcfbf8c6 = level.var_eeb98313;
		level.var_eeb98313 = &function_f6d8b425;
	}
}

/*
	Name: function_f6d8b425
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0xF5461C02
	Offset: 0x1868
	Size: 0xE
	Parameters: 1
	Flags: Linked
*/
function function_f6d8b425(var_6a069cf8)
{
	return [];
}

/*
	Name: function_87fa80cf
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x13141352
	Offset: 0x1880
	Size: 0x56
	Parameters: 0
	Flags: Linked, Private
*/
function private function_87fa80cf()
{
	self notify("5a76aace912e2da5");
	self endon("5a76aace912e2da5");
	self endon(#"death");
	self.var_4ed95eb7 = 1;
	wait(15);
	self.var_4ed95eb7 = undefined;
}

/*
	Name: on_revived
	Namespace: zm_bgb_nowhere_but_there
	Checksum: 0x356ADB16
	Offset: 0x18E0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function on_revived(s_params)
{
	e_reviver = s_params.e_reviver;
	if(isdefined(e_reviver))
	{
		if(isdefined(e_reviver.var_4ed95eb7) && e_reviver.var_4ed95eb7)
		{
			e_reviver zm_stats::increment_challenge_stat(#"hash_54f005134489c6d");
		}
	}
}

