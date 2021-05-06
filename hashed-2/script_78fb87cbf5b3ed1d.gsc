// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_8abfb58852911dd;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_52f559a;

/*
	Name: function_89f2df9
	Namespace: namespace_52f559a
	Checksum: 0xB4D4A563
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_6111cfdbe7da9cd1", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_52f559a
	Checksum: 0x51E262EE
	Offset: 0xC0
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_dca119c2 = (isdefined(getgametypesetting(#"hash_7c8ad12994670d63")) ? getgametypesetting(#"hash_7c8ad12994670d63") : 0);
	var_3ff328e2 = gamemodeismode(1) || gamemodeismode(7);
	if(var_3ff328e2 || !level.var_dca119c2)
	{
		level thread function_e973becc();
	}
}

/*
	Name: function_e973becc
	Namespace: namespace_52f559a
	Checksum: 0x4372E8E9
	Offset: 0x198
	Size: 0xB0
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e973becc()
{
	item_world::function_4de3ca98();
	var_14957968 = getdynentarray(#"hash_6111cfdbe7da9cd1");
	foreach(var_2e01d28f in var_14957968)
	{
		item_world::function_160294c7(var_2e01d28f);
	}
}

