// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using scripts\mp_common\item_world_fixup.csc;
#using scripts\core_common\system_shared.csc;

#namespace character_unlock_stanton;

/*
	Name: __init__system__
	Namespace: character_unlock_stanton
	Checksum: 0x38B4DEA3
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_stanton", &__init__, undefined, #"character_unlock_stanton_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_stanton
	Checksum: 0x580D714
	Offset: 0xD0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"stanton_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_stanton
	Checksum: 0x91E5BCB8
	Offset: 0x110
	Size: 0x254
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		item_world_fixup::function_2749fcc3(#"hash_6a0d13acf3e5687d", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_33f7121f70c3065f", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_2b546c0315159617", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_183c9fe8af52fac7", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_49e8a607ea22e650", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"zombie_stash_graveyard_quest", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_ca8b234ad1fea38", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
		item_world_fixup::function_2749fcc3(#"hash_4ee6deffa30cc6e2", #"hash_5f9831cef8ab9e8d", #"hash_24c9966ffb7a4073", 2);
	}
}

