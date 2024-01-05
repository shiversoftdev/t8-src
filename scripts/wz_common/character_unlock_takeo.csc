// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\callbacks_shared.csc;

#namespace character_unlock_takeo;

/*
	Name: __init__system__
	Namespace: character_unlock_takeo
	Checksum: 0x13E3C2CB
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_takeo", &__init__, undefined, #"character_unlock_takeo_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_takeo
	Checksum: 0x11AD2D43
	Offset: 0xD8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"takeo_unlock", &function_2613aeec);
	callback::on_finalize_initialization(&on_finalize_initialization);
}

/*
	Name: on_finalize_initialization
	Namespace: character_unlock_takeo
	Checksum: 0x5EE6137B
	Offset: 0x138
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function on_finalize_initialization(localclientnum)
{
	waitframe(1);
	level function_552910e9();
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_takeo
	Checksum: 0x5358DBE4
	Offset: 0x170
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(!enabled)
	{
		level thread function_279880b1();
	}
}

/*
	Name: function_279880b1
	Namespace: character_unlock_takeo
	Checksum: 0x3E61455A
	Offset: 0x1A8
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_279880b1()
{
	item_world::function_4de3ca98();
	level function_552910e9();
}

/*
	Name: function_552910e9
	Namespace: character_unlock_takeo
	Checksum: 0x78B71ED0
	Offset: 0x1E0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_552910e9()
{
	dynent = getdynent(#"hash_7b220e1de3a2000d");
	if(isdefined(dynent))
	{
		setdynentenabled(dynent, 0);
	}
}

