// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_68c78107b4aa059c;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\struct.csc;

#namespace namespace_f0884ae5;

/*
	Name: setup
	Namespace: namespace_f0884ae5
	Checksum: 0xACA18E52
	Offset: 0x80
	Size: 0xA4
	Parameters: 3
	Flags: Linked
*/
function setup(localclientnum, var_582cb7bb, reset = 1)
{
	if(!namespace_65181344::is_enabled())
	{
		return;
	}
	level.var_8c615e33 = [];
	function_1f4464c0(var_582cb7bb);
	if(reset)
	{
		level callback::callback(#"hash_11bd48298bde44a4", undefined);
	}
	namespace_65181344::setup_groups(reset);
}

