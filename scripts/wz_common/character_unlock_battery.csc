// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock.csc;
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_battery;

/*
	Name: __init__system__
	Namespace: character_unlock_battery
	Checksum: 0x25D9EE6B
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_battery", &__init__, undefined, #"character_unlock_battery_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_battery
	Checksum: 0x7188F315
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"battery_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_battery
	Checksum: 0xCCA0D0C0
	Offset: 0x118
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		character_unlock::function_d2294476(#"hash_7f75d13d0c20331e", 2, 3);
	}
}

