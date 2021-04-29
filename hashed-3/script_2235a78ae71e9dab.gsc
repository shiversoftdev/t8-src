// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace namespace_bc725b59;

/*
	Name: function_89f2df9
	Namespace: namespace_bc725b59
	Checksum: 0xAF773440
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7c80df83e002a4d6", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: namespace_bc725b59
	Checksum: 0x7C0DF641
	Offset: 0xD0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_7c80df83e002a4d6", "time", 30, &enable, &disable, undefined, undefined);
	bgb::function_1fee6b3(#"hash_7c80df83e002a4d6", 11);
}

/*
	Name: enable
	Namespace: namespace_bc725b59
	Checksum: 0x80F724D1
	Offset: 0x178
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function enable()
{
}

/*
	Name: disable
	Namespace: namespace_bc725b59
	Checksum: 0x80F724D1
	Offset: 0x188
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

