// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace zm_vapor_random;

/*
	Name: __init__system__
	Namespace: zm_vapor_random
	Checksum: 0x4C20C84F
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_vapor_random", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_vapor_random
	Checksum: 0x19971E06
	Offset: 0x148
	Size: 0x72
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "random_vapor_altar_available", 1, 1, "int", &random_vapor_altar_available_fx, 0, 0);
	level._effect[#"random_vapor_altar_available"] = "zombie/fx_powerup_on_green_zmb";
}

/*
	Name: random_vapor_altar_available_fx
	Namespace: zm_vapor_random
	Checksum: 0xB478B3A
	Offset: 0x1C8
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function random_vapor_altar_available_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_476bef54))
		{
			self.var_476bef54 = util::playfxontag(localclientnum, level._effect[#"random_vapor_altar_available"], self, "tag_origin");
		}
	}
	else if(isdefined(self.var_476bef54))
	{
		stopfx(localclientnum, self.var_476bef54);
	}
}

