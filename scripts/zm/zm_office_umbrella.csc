// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_office_umbrella;

/*
	Name: __init__system__
	Namespace: zm_office_umbrella
	Checksum: 0x56D2AC35
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_office_umbrella", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_office_umbrella
	Checksum: 0x4FA0D220
	Offset: 0x100
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 1, 1, "counter", &function_87d68f99, 0, 0);
	clientfield::register("world", "" + #"narrative_room", 1, 1, "int", &narrative_room, 0, 0);
}

/*
	Name: function_87d68f99
	Namespace: zm_office_umbrella
	Checksum: 0x6962C8D7
	Offset: 0x1C0
	Size: 0x8C
	Parameters: 7
	Flags: Linked
*/
function function_87d68f99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_5e9232163a119c6b");
		playsound(localclientnum, #"hash_50a56f17fc412b92", (0, 0, 0));
	}
}

/*
	Name: narrative_room
	Namespace: zm_office_umbrella
	Checksum: 0xF8A11820
	Offset: 0x258
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function narrative_room(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_a5777754(localclientnum, "lab_supply");
	}
	else
	{
		function_73b1f242(localclientnum, "lab_supply");
	}
}

