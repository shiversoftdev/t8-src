// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock.csc;
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_prophet;

/*
	Name: __init__system__
	Namespace: character_unlock_prophet
	Checksum: 0xE0B57CF9
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_prophet", &__init__, undefined, #"character_unlock_prophet_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_prophet
	Checksum: 0x8A29EA4C
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"prophet_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_prophet
	Checksum: 0xB804BEF8
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_2b1b5d3a3cc282f4", 2, 3);
	}
}

