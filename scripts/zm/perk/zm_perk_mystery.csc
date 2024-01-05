// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace zm_perk_mystery;

/*
	Name: __init__system__
	Namespace: zm_perk_mystery
	Checksum: 0x348704CF
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mystery", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mystery
	Checksum: 0x7DB1DF93
	Offset: 0x100
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_27473e44();
}

/*
	Name: function_27473e44
	Namespace: zm_perk_mystery
	Checksum: 0x6439977B
	Offset: 0x120
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_27473e44()
{
	zm_perks::register_perk_clientfields(#"specialty_mystery", &function_12161a30, &function_b10a7225);
	zm_perks::function_b60f4a9f(#"specialty_mystery", #"p8_zm_vapor_altar_icon_01_secretsauce", "zombie/fx8_perk_altar_symbol_ambient_secret_sauce", #"zmperkssecretsauce");
}

/*
	Name: function_12161a30
	Namespace: zm_perk_mystery
	Checksum: 0x80F724D1
	Offset: 0x1B8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_12161a30()
{
}

/*
	Name: function_b10a7225
	Namespace: zm_perk_mystery
	Checksum: 0x80F724D1
	Offset: 0x1C8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_b10a7225()
{
}

