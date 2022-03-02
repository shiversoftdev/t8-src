// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_c8e93137 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_c8e93137
		Checksum: 0xF2B79D68
		Offset: 0x210
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_c8e93137
		Checksum: 0x2E7C90FC
		Offset: 0x440
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_d5ea17f0
		Namespace: namespace_c8e93137
		Checksum: 0xE0D368C2
		Offset: 0x3F8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function function_d5ea17f0(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "text", value);
	}

	/*
		Name: set_state
		Namespace: namespace_c8e93137
		Checksum: 0x587CFC0E
		Offset: 0x330
		Size: 0xBC
		Parameters: 2
		Flags: None
	*/
	function set_state(player, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			player clientfield::function_9bf78ef8(var_47e79fc, "_state", 0);
		}
		else
		{
			if(#"visible" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				/#
					assertmsg("");
				#/
				/#
				#/
			}
		}
	}

	/*
		Name: close
		Namespace: namespace_c8e93137
		Checksum: 0x6AF2363F
		Offset: 0x300
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_c8e93137
		Checksum: 0x52408AD9
		Offset: 0x2B0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "zm_tut_hint_text", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_c8e93137
		Checksum: 0xC73B4407
		Offset: 0x230
		Size: 0x74
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
		namespace_6aaccc24::function_dcb34c80("string", "text", 1);
	}

}

#namespace zm_tut_hint_text;

/*
	Name: register
	Namespace: zm_tut_hint_text
	Checksum: 0xFDF849C2
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_c8e93137();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_tut_hint_text
	Checksum: 0x1933F22D
	Offset: 0x120
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_tut_hint_text
	Checksum: 0xB3B9EB07
	Offset: 0x160
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_tut_hint_text
	Checksum: 0xC0DDCEA
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: zm_tut_hint_text
	Checksum: 0xCA048372
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_d5ea17f0
	Namespace: zm_tut_hint_text
	Checksum: 0x5BA9C4D1
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

