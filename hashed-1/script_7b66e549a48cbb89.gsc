// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace namespace_b4ded66d;

/*
	Name: function_89f2df9
	Namespace: namespace_b4ded66d
	Checksum: 0x93289060
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_204cd04ef56b01e6", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b4ded66d
	Checksum: 0xD8424E4A
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_4e1190045ef3588b", 0))
	{
		function_27473e44();
	}
}

/*
	Name: function_27473e44
	Namespace: namespace_b4ded66d
	Checksum: 0x43E06B5E
	Offset: 0x160
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"hash_4723e346254cb334", &function_37236662, &function_6705773b);
	zm_perks::register_perk_init_thread(#"hash_4723e346254cb334", &init);
	zm_perks::function_b60f4a9f(#"hash_4723e346254cb334", #"hash_4d317eb82b267b50", "zombie/fx8_perk_altar_symbol_ambient_blood_wolf", #"hash_75ec38c3f3487d5");
	zm_powerups::include_zombie_powerup("wolf_bonus_points");
	zm_powerups::add_zombie_powerup("wolf_bonus_points");
}

/*
	Name: init
	Namespace: namespace_b4ded66d
	Checksum: 0x80F724D1
	Offset: 0x258
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function init()
{
}

/*
	Name: function_37236662
	Namespace: namespace_b4ded66d
	Checksum: 0x80F724D1
	Offset: 0x268
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_37236662()
{
}

/*
	Name: function_6705773b
	Namespace: namespace_b4ded66d
	Checksum: 0x80F724D1
	Offset: 0x278
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_6705773b()
{
}

