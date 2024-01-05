// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\gametypes\globallogic.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace namespace_b7ee637a;

/*
	Name: __init__system__
	Namespace: namespace_b7ee637a
	Checksum: 0x5F2F111F
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_7710b10c0110b17", &__init__, undefined, #"hash_5d70c94021e00856");
}

/*
	Name: __init__
	Namespace: namespace_b7ee637a
	Checksum: 0x50DE4111
	Offset: 0xE0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if((isdefined(getgametypesetting(#"hash_6fb11b1e304d533c")) ? getgametypesetting(#"hash_6fb11b1e304d533c") : 0))
	{
		item_world_fixup::function_e70fa91c(#"supply_stash_parent", #"hash_122a0d1e67363704", 3);
	}
}

