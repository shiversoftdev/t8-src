// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_38669cc2;

/*
	Name: function_89f2df9
	Namespace: namespace_38669cc2
	Checksum: 0x98ED9E2B
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2089e1428d4a6ecf", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_38669cc2
	Checksum: 0xD33AA273
	Offset: 0xE0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_bc420db4();
}

/*
	Name: __main__
	Namespace: namespace_38669cc2
	Checksum: 0x80F724D1
	Offset: 0x100
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_bc420db4
	Namespace: namespace_38669cc2
	Checksum: 0x9987A196
	Offset: 0x110
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_bc420db4()
{
	zm_perks::function_7f42e14e(#"hash_6afc24062d2515a2", "mod_death_perception", #"hash_53548db163b3a77e", #"hash_5706909bc1db0f85", 3500);
	zm_perks::register_perk_threads(#"hash_6afc24062d2515a2", &function_422ccf78, &function_f8f0703b);
}

/*
	Name: function_422ccf78
	Namespace: namespace_38669cc2
	Checksum: 0x80F724D1
	Offset: 0x1B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_422ccf78()
{
}

/*
	Name: function_f8f0703b
	Namespace: namespace_38669cc2
	Checksum: 0x3E7718AD
	Offset: 0x1C0
	Size: 0x24
	Parameters: 4
	Flags: Linked
*/
function function_f8f0703b(b_pause, str_perk, str_result, n_slot)
{
}

