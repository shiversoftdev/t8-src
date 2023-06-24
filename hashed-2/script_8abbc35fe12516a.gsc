// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cmp_prop_timer : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cmp_prop_timer
		Checksum: 0xEF9CBA39
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
		Namespace: cmp_prop_timer
		Checksum: 0x29956F93
		Offset: 0x3C0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_isProp
		Namespace: cmp_prop_timer
		Checksum: 0xE3AE3806
		Offset: 0x378
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_isProp(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "isProp", value);
	}

	/*
		Name: set_timeRemaining
		Namespace: cmp_prop_timer
		Checksum: 0x81CA0D4C
		Offset: 0x330
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_timeRemaining(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "timeRemaining", value);
	}

	/*
		Name: close
		Namespace: cmp_prop_timer
		Checksum: 0x4EAAEA3B
		Offset: 0x300
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cmp_prop_timer
		Checksum: 0xBE5643E
		Offset: 0x2B0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "mp_prop_timer", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cmp_prop_timer
		Checksum: 0xAB4DCEED
		Offset: 0x230
		Size: 0x74
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("timeRemaining", 16000, 5, "int", 0);
		cLUIelem::function_da693cbe("isProp", 16000, 1, "int");
	}

}

#namespace mp_prop_timer;

/*
	Name: register
	Namespace: mp_prop_timer
	Checksum: 0x83A467A5
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cmp_prop_timer();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_prop_timer
	Checksum: 0xA64D052
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
	Namespace: mp_prop_timer
	Checksum: 0x6A1278B6
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
	Namespace: mp_prop_timer
	Checksum: 0xBB8ED28B
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
	Name: set_timeRemaining
	Namespace: mp_prop_timer
	Checksum: 0x4A034187
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_timeRemaining(player, value)
{
	[[ self ]]->set_timeRemaining(player, value);
}

/*
	Name: set_isProp
	Namespace: mp_prop_timer
	Checksum: 0xBE7D7888
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_isProp(player, value)
{
	[[ self ]]->set_isProp(player, value);
}

