// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_weap_homunculus;

/*
	Name: __init__system__
	Namespace: zm_weap_homunculus
	Checksum: 0xCE489FC7
	Offset: 0x118
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_homunculus", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_homunculus
	Checksum: 0xFC01387F
	Offset: 0x168
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "" + #"hash_2d49d2cf3d339e18", 1, 1, "int", &function_6fcc4908, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_32c5838be960cfee", 1, 1, "int", &function_3e362ad8, 0, 0);
}

/*
	Name: __main__
	Namespace: zm_weap_homunculus
	Checksum: 0x12668483
	Offset: 0x228
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!zm_weapons::is_weapon_included(getweapon(#"homunculus")))
	{
		return;
	}
}

/*
	Name: function_6fcc4908
	Namespace: zm_weap_homunculus
	Checksum: 0xAB5E8C2B
	Offset: 0x268
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_6fcc4908(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval && isdefined(self))
	{
		v_up = vectorscale((1, 0, 0), 360);
		v_forward = vectorscale((0, 0, 1), 360);
		origin = self gettagorigin("j_spinelower");
		if(!isdefined(origin))
		{
			origin = self.origin;
		}
		playfx(localclientnum, "zm_weapons/fx8_equip_homunc_death_exp", origin, v_forward, v_up);
	}
}

/*
	Name: function_3e362ad8
	Namespace: zm_weap_homunculus
	Checksum: 0xD1BF28AF
	Offset: 0x358
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function function_3e362ad8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		v_up = vectorscale((1, 0, 0), 360);
		v_forward = vectorscale((0, 0, 1), 360);
		playfx(localclientnum, "zm_weapons/fx8_equip_homunc_spawn", self.origin, v_forward, v_up);
		self playsound(localclientnum, #"hash_21206f1b7fb27f81");
	}
}

