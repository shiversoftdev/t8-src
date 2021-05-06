// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_8e912f60;

/*
	Name: function_89f2df9
	Namespace: namespace_8e912f60
	Checksum: 0x9ED606B6
	Offset: 0x88
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_663ce00a55bd5472", &__init__, undefined, #"hash_4b2c77bb3aca2def");
}

/*
	Name: __init__
	Namespace: namespace_8e912f60
	Checksum: 0x7F140F0C
	Offset: 0xD8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_2fd1efc569af17b8", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_8e912f60
	Checksum: 0xE90B9813
	Offset: 0x118
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::function_c55a0479(&function_fcd28111);
	}
}

/*
	Name: function_fcd28111
	Namespace: namespace_8e912f60
	Checksum: 0x16AB845A
	Offset: 0x158
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_fcd28111(params)
{
	if(!isdefined(params.activator))
	{
		return;
	}
	activator = params.activator;
	if(!isplayer(activator))
	{
		return;
	}
	if(!activator character_unlock::function_f0406288(#"hash_2fd1efc569af17b8"))
	{
		return;
	}
	if(self.var_ed175c5 === 1)
	{
		activator character_unlock::function_c8beca5e(#"hash_2fd1efc569af17b8", #"hash_74fceff1a255277d", 1);
	}
}

