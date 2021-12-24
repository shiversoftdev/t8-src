// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_c49f9e2b;

/*
	Name: function_89f2df9
	Namespace: namespace_c49f9e2b
	Checksum: 0x7BC6ED58
	Offset: 0x1D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_770f240f9e25a58d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c49f9e2b
	Checksum: 0xEECC43C5
	Offset: 0x218
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_3a97fe5c4d642a3b"] = "zm_ai/fx8_destroyer_axe_trail";
	level._effect[#"hash_19ff54614b2ce89"] = "zm_ai/fx8_destroyer_arm_spurt";
	footsteps::registeraitypefootstepcb(#"gladiator", &function_918ce680);
	clientfield::register("toplayer", "gladiator_melee_effect", 1, 1, "counter", &function_5dae94f, 0, 0);
	clientfield::register("actor", "gladiator_arm_effect", 1, 2, "int", &function_f5a07d57, 0, 0);
	clientfield::register("scriptmover", "gladiator_axe_effect", 1, 1, "int", &function_49fab171, 0, 0);
}

/*
	Name: function_918ce680
	Namespace: namespace_c49f9e2b
	Checksum: 0x284319B
	Offset: 0x380
	Size: 0x1BC
	Parameters: 5
	Flags: Linked, Private
*/
private function function_918ce680(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	var_dfce5acd = 1000000;
	if(var_dfce5acd > 0)
	{
		n_scale = (var_dfce5acd - n_dist) / var_dfce5acd;
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
		function_36e4ebd4(localclientnum, "anim_med");
	}
	else if(n_scale <= 0.2 && n_scale > 0.1)
	{
		function_36e4ebd4(localclientnum, "damage_light");
	}
	else
	{
		function_36e4ebd4(localclientnum, "damage_light");
	}
}

/*
	Name: function_5dae94f
	Namespace: namespace_c49f9e2b
	Checksum: 0x1394B3F4
	Offset: 0x548
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_5dae94f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	earthquake(localclientnum, 0.3, 1.2, self.origin, 64);
	function_36e4ebd4(localclientnum, "damage_light");
}

/*
	Name: function_f5a07d57
	Namespace: namespace_c49f9e2b
	Checksum: 0xF27044F8
	Offset: 0x5E0
	Size: 0xCC
	Parameters: 7
	Flags: Linked, Private
*/
private function function_f5a07d57(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_19ff54614b2ce89"], self, "j_shouldertwist_le");
	}
	else if(newval == 2)
	{
		util::playfxontag(localclientnum, level._effect[#"hash_19ff54614b2ce89"], self, "tag_shoulder_ri_fx");
	}
}

/*
	Name: function_49fab171
	Namespace: namespace_c49f9e2b
	Checksum: 0xFDC7E784
	Offset: 0x6B8
	Size: 0xB4
	Parameters: 7
	Flags: Linked, Private
*/
private function function_49fab171(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.var_c047d899 = util::playfxontag(localclientnum, level._effect[#"hash_3a97fe5c4d642a3b"], self, "tag_origin");
	}
	else if(isdefined(self.var_c047d899))
	{
		stopfx(localclientnum, self.var_c047d899);
	}
}

