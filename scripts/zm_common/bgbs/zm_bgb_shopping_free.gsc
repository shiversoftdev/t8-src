// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_bgb_shopping_free;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_shopping_free
	Checksum: 0xF9926F0C
	Offset: 0xA0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_shopping_free", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_shopping_free
	Checksum: 0x38554E38
	Offset: 0xF0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_shopping_free", "time", 60, &enable, &disable, undefined, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_shopping_free
	Checksum: 0x4AB8615B
	Offset: 0x170
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
}

/*
	Name: disable
	Namespace: zm_bgb_shopping_free
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

