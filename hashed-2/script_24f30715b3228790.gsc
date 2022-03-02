// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_e3447716;

/*
	Name: function_89f2df9
	Namespace: namespace_e3447716
	Checksum: 0x85A5D5A7
	Offset: 0x78
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_6d08a8a99b71d29e", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e3447716
	Checksum: 0x4CF7F062
	Offset: 0xC0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"survive", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_e3447716
	Checksum: 0x80F724D1
	Offset: 0x128
	Size: 0x4
	Parameters: 0
	Flags: Private
*/
function private function_d1de6a85()
{
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_e3447716
	Checksum: 0x7A8F865E
	Offset: 0x138
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
}

