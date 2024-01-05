// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class clower_message : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: clower_message
		Checksum: 0x32A4ACEE
		Offset: 0x258
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: clower_message
		Checksum: 0x17FF3373
		Offset: 0x538
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_countdowntimeseconds
		Namespace: clower_message
		Checksum: 0x6A3610B0
		Offset: 0x4F0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_countdowntimeseconds(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "countdownTimeSeconds", value);
	}

	/*
		Name: set_message
		Namespace: clower_message
		Checksum: 0x951A891A
		Offset: 0x4A8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_message(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "message", value);
	}

	/*
		Name: set_state
		Namespace: clower_message
		Checksum: 0x6F3DDF00
		Offset: 0x3A0
		Size: 0xFC
		Parameters: 2
		Flags: Linked
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
				if(#"hash_45bfcb1cd8c9b50a" == state_name)
				{
					player clientfield::function_9bf78ef8(var_47e79fc, "_state", 2);
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
	}

	/*
		Name: close
		Namespace: clower_message
		Checksum: 0x722E2ADD
		Offset: 0x370
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: clower_message
		Checksum: 0x31F200AB
		Offset: 0x320
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "lower_message", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: clower_message
		Checksum: 0x9A44BA3E
		Offset: 0x278
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 2, "int");
		cluielem::function_dcb34c80("string", "message", 1);
		cluielem::add_clientfield("countdownTimeSeconds", 1, 5, "int");
	}

}

#namespace lower_message;

/*
	Name: register
	Namespace: lower_message
	Checksum: 0xCFF5F4A4
	Offset: 0xF0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new clower_message();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: lower_message
	Checksum: 0x29BCBF1E
	Offset: 0x138
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: lower_message
	Checksum: 0x318DCEA5
	Offset: 0x178
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
	Namespace: lower_message
	Checksum: 0x865D29B7
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: lower_message
	Checksum: 0x6A1BE3EA
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_message
	Namespace: lower_message
	Checksum: 0xF2DDF70C
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_message(player, value)
{
	[[ self ]]->set_message(player, value);
}

/*
	Name: set_countdowntimeseconds
	Namespace: lower_message
	Checksum: 0xDABCD213
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_countdowntimeseconds(player, value)
{
	[[ self ]]->set_countdowntimeseconds(player, value);
}

