// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class czm_towers_pap_hud : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_towers_pap_hud
		Checksum: 0x58440466
		Offset: 0x298
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_towers_pap_hud
		Checksum: 0xA7CF1CC
		Offset: 0x528
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_odin_acquired
		Namespace: czm_towers_pap_hud
		Checksum: 0x48780F9D
		Offset: 0x4E0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_odin_acquired(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "odin_acquired", value);
	}

	/*
		Name: set_zeus_acquired
		Namespace: czm_towers_pap_hud
		Checksum: 0xB2E3EEFC
		Offset: 0x498
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_zeus_acquired(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "zeus_acquired", value);
	}

	/*
		Name: set_ra_acquired
		Namespace: czm_towers_pap_hud
		Checksum: 0x5BEE22C6
		Offset: 0x450
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_ra_acquired(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "ra_acquired", value);
	}

	/*
		Name: set_danu_acquired
		Namespace: czm_towers_pap_hud
		Checksum: 0x343E20DE
		Offset: 0x408
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_danu_acquired(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "danu_acquired", value);
	}

	/*
		Name: close
		Namespace: czm_towers_pap_hud
		Checksum: 0xFDEFABBE
		Offset: 0x3D8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: czm_towers_pap_hud
		Checksum: 0x6F3BD843
		Offset: 0x388
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "zm_towers_pap_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_towers_pap_hud
		Checksum: 0x8E6378A7
		Offset: 0x2B8
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("danu_acquired", 1, 1, "int");
		cluielem::add_clientfield("ra_acquired", 1, 1, "int");
		cluielem::add_clientfield("zeus_acquired", 1, 1, "int");
		cluielem::add_clientfield("odin_acquired", 1, 1, "int");
	}

}

#namespace zm_towers_pap_hud;

/*
	Name: register
	Namespace: zm_towers_pap_hud
	Checksum: 0x81CC59FD
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new czm_towers_pap_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD5D22E8
	Offset: 0x148
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
	Namespace: zm_towers_pap_hud
	Checksum: 0xA6177E61
	Offset: 0x188
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
	Namespace: zm_towers_pap_hud
	Checksum: 0x2102F99C
	Offset: 0x1B0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_danu_acquired
	Namespace: zm_towers_pap_hud
	Checksum: 0x1DD72F4A
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_danu_acquired(player, value)
{
	[[ self ]]->set_danu_acquired(player, value);
}

/*
	Name: set_ra_acquired
	Namespace: zm_towers_pap_hud
	Checksum: 0xFA5C49A1
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_ra_acquired(player, value)
{
	[[ self ]]->set_ra_acquired(player, value);
}

/*
	Name: set_zeus_acquired
	Namespace: zm_towers_pap_hud
	Checksum: 0xFD216808
	Offset: 0x238
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_zeus_acquired(player, value)
{
	[[ self ]]->set_zeus_acquired(player, value);
}

/*
	Name: set_odin_acquired
	Namespace: zm_towers_pap_hud
	Checksum: 0xBDA447B7
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_odin_acquired(player, value)
{
	[[ self ]]->set_odin_acquired(player, value);
}

