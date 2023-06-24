// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\wz_common\character_unlock.csc;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_menendez;

/*
	Name: __init__system__
	Namespace: character_unlock_menendez
	Checksum: 0xE9D54012
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_menendez", &__init__, undefined, #"character_unlock_menendez_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_menendez
	Checksum: 0x95BFB057
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"menendez_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_menendez
	Checksum: 0x3D1101AD
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_2b254f3a3ccabfaf", 2, 3);
	}
}

