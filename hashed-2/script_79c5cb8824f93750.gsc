// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_171437aa8f3ddc24;
#using script_731df012f3a3c2fc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_1ce5fc27;

/*
	Name: function_89f2df9
	Namespace: namespace_1ce5fc27
	Checksum: 0xD8A57928
	Offset: 0x80
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1f2b90c8b7f6a12e", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: function_f031a77f
	Namespace: namespace_1ce5fc27
	Checksum: 0xB7AC7368
	Offset: 0xD0
	Size: 0x1C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_f031a77f()
{
	waitframe(1);
	function_f5a58e15();
}

/*
	Name: __init__
	Namespace: namespace_1ce5fc27
	Checksum: 0xBC2C44C9
	Offset: 0xF8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_82330491(#"hash_d8437030e2d8dc1", #"hash_17c02481305f0e24", #"hash_347dc9157efc6a42", &function_d95e620c, #"hash_633d185cd2140f1a", #"hash_633d175cd2140d67");
}

/*
	Name: function_d95e620c
	Namespace: namespace_1ce5fc27
	Checksum: 0xC45016EB
	Offset: 0x178
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_d95e620c()
{
	var_e02cd092 = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_183bcc0f6737224a")) ? getgametypesetting(#"hash_183bcc0f6737224a") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isdefined(getgametypesetting(#"hash_4a035e3775089f40")) ? getgametypesetting(#"hash_4a035e3775089f40") : 0);
	return var_e02cd092;
}

/*
	Name: function_f5a58e15
	Namespace: namespace_1ce5fc27
	Checksum: 0x4613421F
	Offset: 0x2D8
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f5a58e15()
{
	var_a6762160 = getscriptbundle(#"hash_347dc9157efc6a42");
	if(isdefined(var_a6762160))
	{
		namespace_b0722f43::function_96ff7b88(#"hash_347dc9157efc6a42");
	}
}

