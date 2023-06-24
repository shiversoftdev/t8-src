// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_game_over : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_game_over
		Checksum: 0x24F0633C
		Offset: 0x208
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_game_over
		Checksum: 0xA7C4A749
		Offset: 0x438
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_rounds
		Namespace: czm_game_over
		Checksum: 0x6B7AB323
		Offset: 0x3F0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_rounds(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "rounds", value);
	}

	/*
		Name: set_state
		Namespace: czm_game_over
		Checksum: 0xDC920510
		Offset: 0x328
		Size: 0xBC
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
			if(#"gatewayopened" == state_name)
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
		Namespace: czm_game_over
		Checksum: 0xEF2701E9
		Offset: 0x2F8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: czm_game_over
		Checksum: 0x2C474E6D
		Offset: 0x2A8
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_game_over", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_game_over
		Checksum: 0x4C70E9AF
		Offset: 0x228
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_da693cbe("rounds", 1, 8, "int");
	}

}

#namespace zm_game_over;

/*
	Name: register
	Namespace: zm_game_over
	Checksum: 0x8240444F
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new czm_game_over();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_over
	Checksum: 0x5149B9B
	Offset: 0x118
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
	Namespace: zm_game_over
	Checksum: 0xDF8E2A55
	Offset: 0x158
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_game_over
	Checksum: 0xA507035B
	Offset: 0x180
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
	Namespace: zm_game_over
	Checksum: 0xE3DB5C1
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_rounds
	Namespace: zm_game_over
	Checksum: 0xF8A9F347
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_rounds(player, value)
{
	[[ self ]]->set_rounds(player, value);
}

