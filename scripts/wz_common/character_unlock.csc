// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_inventory.csc;
#using script_731df012f3a3c2fc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock;

/*
	Name: __init__system__
	Namespace: character_unlock
	Checksum: 0x54F24694
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock", &__init__, undefined, #"character_unlock_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock
	Checksum: 0x80F724D1
	Offset: 0xD8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: function_d2294476
	Namespace: character_unlock
	Checksum: 0xD695A62E
	Offset: 0xE8
	Size: 0x1C
	Parameters: 3
	Flags: Linked
*/
function function_d2294476(var_2ab9d3bd, var_f532cd9f, var_3afaa57b)
{
}

