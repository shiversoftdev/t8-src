// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_a061685d;

/*
	Name: function_89f2df9
	Namespace: namespace_a061685d
	Checksum: 0xDE7128AB
	Offset: 0x88
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_79ec124ce8380088", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a061685d
	Checksum: 0x75B64FF3
	Offset: 0xD0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_ce65aae8();
}

/*
	Name: function_ce65aae8
	Namespace: namespace_a061685d
	Checksum: 0x77B03C2F
	Offset: 0xF0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_ce65aae8()
{
	zm_perks::function_7f42e14e(#"hash_3e2f955cd85b5532", "mod_marathon", #"perk_staminup", #"specialty_staminup", 2500);
	zm_perks::function_2ae97a14(#"hash_3e2f955cd85b5532", array(#"specialty_unlimitedsprint", #"specialty_sprintfire"));
}

