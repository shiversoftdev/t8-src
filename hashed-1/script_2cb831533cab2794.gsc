// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_hint_text : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_hint_text
		Checksum: 0xF06BEBF1
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
		Namespace: czm_hint_text
		Checksum: 0xA37C67BB
		Offset: 0x438
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_text
		Namespace: czm_hint_text
		Checksum: 0xF4F330C9
		Offset: 0x3F0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_text(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "text", value);
	}

	/*
		Name: set_state
		Namespace: czm_hint_text
		Checksum: 0x72955B7B
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
		Namespace: czm_hint_text
		Checksum: 0x52E0C176
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
		Namespace: czm_hint_text
		Checksum: 0x3C71C8E0
		Offset: 0x2A8
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_hint_text", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_hint_text
		Checksum: 0x3FECF46B
		Offset: 0x228
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_dcb34c80("string", "text", 1);
	}

}

#namespace zm_hint_text;

/*
	Name: register
	Namespace: zm_hint_text
	Checksum: 0x204AD7B4
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new czm_hint_text();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_hint_text
	Checksum: 0x3EAC8F23
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
	Namespace: zm_hint_text
	Checksum: 0xA0CDC4BA
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
	Namespace: zm_hint_text
	Checksum: 0x1CF802C2
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
	Namespace: zm_hint_text
	Checksum: 0x7674D3EA
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_text
	Namespace: zm_hint_text
	Checksum: 0xC8F53F0D
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_text(player, value)
{
	[[ self ]]->set_text(player, value);
}

