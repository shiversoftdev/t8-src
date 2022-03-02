// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_ac6a30f1991e105;
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_a5d36e4;

/*
	Name: function_89f2df9
	Namespace: namespace_a5d36e4
	Checksum: 0x69E0B7A5
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"stoker", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a5d36e4
	Checksum: 0x7F6EB78
	Offset: 0xF0
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	footsteps::registeraitypefootstepcb(#"stoker", &function_7188417c);
	ai::add_archetype_spawn_function(#"stoker", &function_580b77a2);
}

/*
	Name: function_7188417c
	Namespace: namespace_a5d36e4
	Checksum: 0xA4A9E242
	Offset: 0x160
	Size: 0x1BC
	Parameters: 5
	Flags: Linked
*/
function function_7188417c(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	var_166f3552 = 1000000;
	if(var_166f3552 > 0)
	{
		n_scale = (var_166f3552 - n_dist) / var_166f3552;
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
	Name: function_580b77a2
	Namespace: namespace_a5d36e4
	Checksum: 0x4819EB45
	Offset: 0x328
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_580b77a2(localclientnum)
{
	fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
}

