// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_bgb_newtonian_negation;

/*
	Name: __init__system__
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xCCD966BF
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_bgb_newtonian_negation", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0x65439E7D
	Offset: 0x108
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	clientfield::register("world", "newtonian_negation", 1, 1, "int");
	bgb::register(#"zm_bgb_newtonian_negation", "time", 1500, &enable, &disable, &validation);
}

/*
	Name: validation
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xF2725CAA
	Offset: 0x1C0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function validation()
{
	if(isdefined(level.var_6bbb45f9) && level.var_6bbb45f9)
	{
		return false;
	}
	return true;
}

/*
	Name: enable
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0x7BF95324
	Offset: 0x1F8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	function_8622e664(1);
	self thread function_4712db36();
}

/*
	Name: function_4712db36
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xDDCAFD10
	Offset: 0x238
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_4712db36()
{
	self endon(#"hash_429f79a1bdb91087");
	self waittill(#"disconnect");
	thread disable();
}

/*
	Name: disable
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xFB45C9CA
	Offset: 0x280
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function disable()
{
	if(isdefined(self))
	{
		self notify(#"hash_429f79a1bdb91087");
	}
	foreach(player in level.players)
	{
		if(player !== self && player bgb::is_enabled(#"zm_bgb_newtonian_negation"))
		{
			return;
		}
	}
	function_8622e664(0);
}

/*
	Name: function_8622e664
	Namespace: zm_bgb_newtonian_negation
	Checksum: 0xFE8293A8
	Offset: 0x358
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_8622e664(var_b4666218)
{
	level clientfield::set("newtonian_negation", var_b4666218);
}

