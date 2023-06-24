// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_perks.csc;

#namespace zm_perk_mod_zombshell;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_zombshell
	Checksum: 0xA0AD6E9B
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_zombshell", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_zombshell
	Checksum: 0x6C6294F2
	Offset: 0xC0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	zm_perks::register_perk_clientfields(#"specialty_mod_zombshell", &function_5eadb2fd, &function_fbae967f);
	zm_perks::register_perk_init_thread(#"specialty_mod_zombshell", &function_793d9032);
}

/*
	Name: function_793d9032
	Namespace: zm_perk_mod_zombshell
	Checksum: 0x80F724D1
	Offset: 0x140
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_793d9032()
{
}

/*
	Name: function_5eadb2fd
	Namespace: zm_perk_mod_zombshell
	Checksum: 0x80F724D1
	Offset: 0x150
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_5eadb2fd()
{
}

/*
	Name: function_fbae967f
	Namespace: zm_perk_mod_zombshell
	Checksum: 0x80F724D1
	Offset: 0x160
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_fbae967f()
{
}

