// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace namespace_4719c045;

/*
	Name: function_89f2df9
	Namespace: namespace_4719c045
	Checksum: 0xA6D18658
	Offset: 0x240
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6e8654cf5bb63c35", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_4719c045
	Checksum: 0x6D76280E
	Offset: 0x288
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "wrwlf_silver_death_fx", 8000, 1, "int", &function_c65ce64a, 0, 0);
	clientfield::register("actor", "wrwlf_weakpoint_fx", 8000, 2, "counter", &function_3f3f0d8, 0, 0);
	clientfield::register("actor", "wrwlf_silver_hit_fx", 8000, 1, "counter", &function_39053880, 0, 0);
	clientfield::register("actor", "wrwlf_leap_attack_rumble", 8000, 1, "counter", &function_e980911c, 0, 0);
	ai::add_archetype_spawn_function(#"werewolf", &function_d45ef8ea);
	footsteps::registeraitypefootstepcb(#"werewolf", &function_f4b140ab);
}

/*
	Name: function_d45ef8ea
	Namespace: namespace_4719c045
	Checksum: 0x505D6A89
	Offset: 0x418
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_d45ef8ea(localclientnum)
{
	self.breath_fx = util::playfxontag(localclientnum, "zm_ai/fx8_werewolf_breath", self, "j_head");
	self.var_f87f8fa0 = "tag_eye";
	self zm_utility::function_3a020b0f(localclientnum, "rob_zm_eyes_orange", #"hash_524decea28717b7c");
	self callback::on_shutdown(&on_entity_shutdown);
	self function_bf9d3071("rob_zm_man_werewolf_nonboss_weakpoint");
}

/*
	Name: on_entity_shutdown
	Namespace: namespace_4719c045
	Checksum: 0x720D7403
	Offset: 0x4E0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function on_entity_shutdown(localclientnum)
{
	if(isdefined(self))
	{
		if(isdefined(self.breath_fx))
		{
			stopfx(localclientnum, self.breath_fx);
		}
		self zm_utility::good_barricade_damaged(localclientnum);
	}
	self function_5d482e78("rob_zm_man_werewolf_nonboss_weakpoint");
}

/*
	Name: function_c65ce64a
	Namespace: namespace_4719c045
	Checksum: 0x70DF5FD2
	Offset: 0x560
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_c65ce64a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self thread function_815cc85c(localclientnum);
	}
}

/*
	Name: function_815cc85c
	Namespace: namespace_4719c045
	Checksum: 0x6DC30090
	Offset: 0x5C8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_815cc85c(localclientnum)
{
	self zm_utility::good_barricade_damaged(localclientnum);
	self function_5d482e78("rob_zm_man_werewolf_nonboss_weakpoint");
	self function_bf9d3071("rob_zm_werewolf_dust");
}

/*
	Name: function_3f3f0d8
	Namespace: namespace_4719c045
	Checksum: 0xFA479459
	Offset: 0x638
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_3f3f0d8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_chest_ws");
	}
	else if(newval == 2)
	{
		util::playfxontag(localclientnum, "zm_ai/fx8_werewolf_dmg_weakspot", self, "tag_back_ws");
	}
}

/*
	Name: function_39053880
	Namespace: namespace_4719c045
	Checksum: 0x48B728DE
	Offset: 0x6E8
	Size: 0x6C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_39053880(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		util::playfxontag(localclientnum, "maps/zm_mansion/fx8_silver_hit_werewolf", self, "j_spine4");
	}
}

/*
	Name: function_f4b140ab
	Namespace: namespace_4719c045
	Checksum: 0x9F838F74
	Offset: 0x760
	Size: 0x194
	Parameters: 5
	Flags: Linked, Private
*/
function private function_f4b140ab(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	var_107019dc = 1000 * 1000;
	n_scale = (var_107019dc - n_dist) / var_107019dc;
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
	Name: function_e980911c
	Namespace: namespace_4719c045
	Checksum: 0xB0900FB4
	Offset: 0x900
	Size: 0x174
	Parameters: 7
	Flags: Linked, Private
*/
function private function_e980911c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(self.origin, e_player.origin);
	var_107019dc = 500 * 500;
	n_scale = (var_107019dc - n_dist) / var_107019dc;
	n_scale = min(n_scale, 0.75);
	if(n_scale <= 0.01)
	{
		return;
	}
	earthquake(localclientnum, n_scale, 0.5, self.origin, n_dist, 1);
	if(n_scale >= 0.5)
	{
		function_36e4ebd4(localclientnum, "zm_shield_break");
	}
	else
	{
		function_36e4ebd4(localclientnum, "damage_light");
	}
}

