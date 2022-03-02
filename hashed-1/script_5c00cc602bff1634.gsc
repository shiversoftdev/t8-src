// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_bd668ff;

/*
	Name: function_89f2df9
	Namespace: namespace_bd668ff
	Checksum: 0x99DF9906
	Offset: 0x300
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_5ecf1967e7cb0189", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_bd668ff
	Checksum: 0x3FFE1557
	Offset: 0x348
	Size: 0x2F4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_35b000ce20f352c4"] = "zm_ai/fx8_gegenees_shield_blast";
	level._effect[#"hash_1d5fb38898d7b977"] = "zm_ai/fx8_gegenees_shield_guard";
	level._effect[#"hash_4797d76df83752cb"] = "zm_ai/fx8_gegenees_spear_tip_flame";
	level._effect[#"hash_1591eb84f9cddd23"] = "zm_ai/fx8_gegenees_spear_tip_tell";
	level._effect[#"hash_4713a53b947f1e25"] = "zm_ai/fx8_stoker_dest_weak_point_exp_generic";
	footsteps::registeraitypefootstepcb(#"gegenees", &function_d00809d8);
	clientfield::register("actor", "gegenees_shield_blast_effect", 16000, 1, "counter", &function_8745f9df, 0, 0);
	clientfield::register("actor", "gegenees_shield_guard_effect", 16000, 1, "int", &function_ae96bf9a, 0, 0);
	clientfield::register("actor", "gegenees_spear_tip_effect", 16000, 1, "int", &function_33dedae1, 0, 0);
	clientfield::register("actor", "gegenees_spear_tip_tell_effect", 16000, 1, "int", &function_421757ab, 0, 0);
	clientfield::register("toplayer", "gegenees_damage_cf", 16000, 1, "counter", &function_2ee4a6b6, 0, 0);
	clientfield::register("scriptmover", "gegenees_spear_miss_cf", 16000, 1, "counter", &function_ce49549a, 0, 0);
	clientfield::register("actor", "gegenees_helmet_explosion_cf", 16000, 1, "int", &function_d54aae3e, 0, 0);
}

/*
	Name: function_d00809d8
	Namespace: namespace_bd668ff
	Checksum: 0x38ECB63D
	Offset: 0x648
	Size: 0x25C
	Parameters: 5
	Flags: Linked, Private
*/
function private function_d00809d8(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	is_large = 0;
	if(notetrack == "footstep_left_large" || notetrack == "footstep_right_large")
	{
		is_large = 1;
	}
	var_a34b4731 = 1000000;
	if(is_large)
	{
		var_a34b4731 = 4000000;
	}
	if(var_a34b4731 > 0)
	{
		n_scale = (var_a34b4731 - n_dist) / var_a34b4731;
	}
	else
	{
		return;
	}
	if(n_scale > 1 || n_scale < 0)
	{
		return;
	}
	n_scale = n_scale * 0.25;
	if(n_scale <= 0.01)
	{
		return;
	}
	earthquake(localclientnum, n_scale, 0.1, pos, n_dist);
	if(n_scale <= 0.25 && n_scale > 0.2)
	{
		if(is_large)
		{
			function_36e4ebd4(localclientnum, "damage_heavy");
		}
		else
		{
			function_36e4ebd4(localclientnum, "anim_med");
		}
	}
	else
	{
		if(n_scale <= 0.2 && n_scale > 0.1)
		{
			if(is_large)
			{
				function_36e4ebd4(localclientnum, "anim_med");
			}
			else
			{
				function_36e4ebd4(localclientnum, "damage_light");
			}
		}
		else
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
	}
}

/*
	Name: function_8745f9df
	Namespace: namespace_bd668ff
	Checksum: 0x5596D14C
	Offset: 0x8B0
	Size: 0x7A
	Parameters: 7
	Flags: Linked, Private
*/
function private function_8745f9df(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self.var_cafcaa0a = util::playfxontag(localclientnum, level._effect[#"hash_35b000ce20f352c4"], self, "tag_shield_fx");
}

/*
	Name: function_ae96bf9a
	Namespace: namespace_bd668ff
	Checksum: 0x75630506
	Offset: 0x938
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_ae96bf9a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_7c984f = util::playfxontag(localclientnum, level._effect[#"hash_1d5fb38898d7b977"], self, "tag_shield_fx");
	}
	else if(isdefined(self.var_7c984f))
	{
		stopfx(localclientnum, self.var_7c984f);
		self.var_7c984f = undefined;
	}
}

/*
	Name: function_33dedae1
	Namespace: namespace_bd668ff
	Checksum: 0x6DC5371F
	Offset: 0xA00
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_33dedae1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_645626ad = util::playfxontag(localclientnum, level._effect[#"hash_4797d76df83752cb"], self, "tag_spear_tip_fx");
	}
	else if(isdefined(self.var_645626ad))
	{
		killfx(localclientnum, self.var_645626ad);
		self.var_645626ad = undefined;
	}
}

/*
	Name: function_421757ab
	Namespace: namespace_bd668ff
	Checksum: 0xE57BDDFF
	Offset: 0xAC8
	Size: 0xBE
	Parameters: 7
	Flags: Linked, Private
*/
function private function_421757ab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_55203ff4 = util::playfxontag(localclientnum, level._effect[#"hash_1591eb84f9cddd23"], self, "tag_spear_tip_fx");
	}
	else if(isdefined(self.var_55203ff4))
	{
		stopfx(localclientnum, self.var_55203ff4);
		self.var_55203ff4 = undefined;
	}
}

/*
	Name: function_2ee4a6b6
	Namespace: namespace_bd668ff
	Checksum: 0x90590F38
	Offset: 0xB90
	Size: 0xCC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_2ee4a6b6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isalive(self) || self !== function_5c10bd79(localclientnum))
	{
		return;
	}
	earthquake(localclientnum, 0.5, 0.1, self.origin, 40);
	function_36e4ebd4(localclientnum, "damage_heavy");
}

/*
	Name: function_ce49549a
	Namespace: namespace_bd668ff
	Checksum: 0xEF653793
	Offset: 0xC68
	Size: 0x1DC
	Parameters: 7
	Flags: Linked, Private
*/
function private function_ce49549a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(self.origin, e_player.origin);
	var_a34b4731 = 1000000;
	if(var_a34b4731 > 0)
	{
		n_scale = (var_a34b4731 - n_dist) / var_a34b4731;
	}
	else
	{
		return;
	}
	if(n_scale > 1 || n_scale < 0)
	{
		return;
	}
	n_scale = n_scale * 0.25;
	if(n_scale <= 0.01)
	{
		return;
	}
	earthquake(localclientnum, n_scale, 0.1, self.origin, n_dist);
	if(n_scale <= 0.25 && n_scale > 0.2)
	{
		function_36e4ebd4(localclientnum, "anim_med");
	}
	else
	{
		if(n_scale <= 0.2 && n_scale > 0.1)
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
		else
		{
			function_36e4ebd4(localclientnum, "damage_light");
		}
	}
}

/*
	Name: function_d54aae3e
	Namespace: namespace_bd668ff
	Checksum: 0xF4F6566
	Offset: 0xE50
	Size: 0x82
	Parameters: 7
	Flags: Linked, Private
*/
function private function_d54aae3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx_helmet = util::playfxontag(localclientnum, level._effect[#"hash_4713a53b947f1e25"], self, "j_head");
	}
}

