// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_cb32d07c95e5628;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace namespace_f0884ae5;

/*
	Name: setup
	Namespace: namespace_f0884ae5
	Checksum: 0xF7994EFF
	Offset: 0x80
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function setup(var_582cb7bb, reset = 1)
{
	if(!namespace_65181344::is_enabled())
	{
		return;
	}
	function_1f4464c0(var_582cb7bb);
	if(reset)
	{
		level callback::callback(#"hash_11bd48298bde44a4", undefined);
	}
	namespace_65181344::setup_groups(reset);
}

