// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cself_revive_visuals_rush : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cself_revive_visuals_rush
		Checksum: 0x86EC5C37
		Offset: 0x1E0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cself_revive_visuals_rush
		Checksum: 0xC1B63A66
		Offset: 0x320
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_revive_time
		Namespace: cself_revive_visuals_rush
		Checksum: 0x21211EA8
		Offset: 0x2D8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_revive_time(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "revive_time", value);
	}

	/*
		Name: close
		Namespace: cself_revive_visuals_rush
		Checksum: 0xAC716876
		Offset: 0x2A8
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
		Namespace: cself_revive_visuals_rush
		Checksum: 0x3E68A457
		Offset: 0x258
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "self_revive_visuals_rush", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cself_revive_visuals_rush
		Checksum: 0x85661467
		Offset: 0x200
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("revive_time", 1, 4, "int");
	}

}

#namespace self_revive_visuals_rush;

/*
	Name: register
	Namespace: self_revive_visuals_rush
	Checksum: 0x2A5EED24
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cself_revive_visuals_rush();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals_rush
	Checksum: 0xE930F7D7
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
	Namespace: self_revive_visuals_rush
	Checksum: 0xADEDFF66
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
	Namespace: self_revive_visuals_rush
	Checksum: 0x549CFF49
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
	Name: set_revive_time
	Namespace: self_revive_visuals_rush
	Checksum: 0xDFB17AF3
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_revive_time(player, value)
{
	[[ self ]]->set_revive_time(player, value);
}

