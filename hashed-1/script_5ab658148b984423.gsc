// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_build_progress : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_build_progress
		Checksum: 0x5AA9760A
		Offset: 0x1D8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_build_progress
		Checksum: 0x36376EA9
		Offset: 0x318
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_progress
		Namespace: czm_build_progress
		Checksum: 0x36F7B894
		Offset: 0x2D0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_progress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "progress", value);
	}

	/*
		Name: close
		Namespace: czm_build_progress
		Checksum: 0xB597955B
		Offset: 0x2A0
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
		Namespace: czm_build_progress
		Checksum: 0x53BB0713
		Offset: 0x250
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_build_progress", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_build_progress
		Checksum: 0x2FD8A6C1
		Offset: 0x1F8
		Size: 0x4C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("progress", 1, 6, "float");
	}

}

#namespace zm_build_progress;

/*
	Name: register
	Namespace: zm_build_progress
	Checksum: 0x26DE4028
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new czm_build_progress();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_build_progress
	Checksum: 0x41E23B41
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
	Namespace: zm_build_progress
	Checksum: 0xCEC74DF9
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
	Namespace: zm_build_progress
	Checksum: 0xA5FB3282
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
	Name: set_progress
	Namespace: zm_build_progress
	Checksum: 0xAFFBC2BA
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_progress(player, value)
{
	[[ self ]]->set_progress(player, value);
}

