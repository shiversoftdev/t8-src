// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class ccp_skip_scene_menu : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: ccp_skip_scene_menu
		Checksum: 0xDE9109B5
		Offset: 0x298
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: ccp_skip_scene_menu
		Checksum: 0xB8872D06
		Offset: 0x528
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_sceneskipendtime
		Namespace: ccp_skip_scene_menu
		Checksum: 0xF75FEB76
		Offset: 0x4E0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_sceneskipendtime(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "sceneSkipEndTime", value);
	}

	/*
		Name: set_votedtoskip
		Namespace: ccp_skip_scene_menu
		Checksum: 0x2C8AF207
		Offset: 0x498
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_votedtoskip(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "votedToSkip", value);
	}

	/*
		Name: set_hostisskipping
		Namespace: ccp_skip_scene_menu
		Checksum: 0x92E3EB95
		Offset: 0x450
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_hostisskipping(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "hostIsSkipping", value);
	}

	/*
		Name: set_showskipbutton
		Namespace: ccp_skip_scene_menu
		Checksum: 0x81DD097F
		Offset: 0x408
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_showskipbutton(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "showSkipButton", value);
	}

	/*
		Name: close
		Namespace: ccp_skip_scene_menu
		Checksum: 0xD548BD5C
		Offset: 0x3D8
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
		Namespace: ccp_skip_scene_menu
		Checksum: 0xA5ECDF73
		Offset: 0x388
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "cp_skip_scene_menu", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: ccp_skip_scene_menu
		Checksum: 0x3395831A
		Offset: 0x2B8
		Size: 0xC4
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("showSkipButton", 1, 2, "int");
		cluielem::add_clientfield("hostIsSkipping", 1, 1, "int");
		cluielem::add_clientfield("votedToSkip", 1, 1, "int");
		cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int");
	}

}

#namespace cp_skip_scene_menu;

/*
	Name: register
	Namespace: cp_skip_scene_menu
	Checksum: 0x74FB03A9
	Offset: 0x100
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new ccp_skip_scene_menu();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: cp_skip_scene_menu
	Checksum: 0x9ADFA183
	Offset: 0x148
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
	Namespace: cp_skip_scene_menu
	Checksum: 0xFABEB683
	Offset: 0x188
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
	Namespace: cp_skip_scene_menu
	Checksum: 0xB1E41488
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
	Name: set_showskipbutton
	Namespace: cp_skip_scene_menu
	Checksum: 0x1C0C8CDC
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_showskipbutton(player, value)
{
	[[ self ]]->set_showskipbutton(player, value);
}

/*
	Name: set_hostisskipping
	Namespace: cp_skip_scene_menu
	Checksum: 0x8237D3B3
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_hostisskipping(player, value)
{
	[[ self ]]->set_hostisskipping(player, value);
}

/*
	Name: set_votedtoskip
	Namespace: cp_skip_scene_menu
	Checksum: 0xEAD7B66B
	Offset: 0x238
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_votedtoskip(player, value)
{
	[[ self ]]->set_votedtoskip(player, value);
}

/*
	Name: set_sceneskipendtime
	Namespace: cp_skip_scene_menu
	Checksum: 0x5A2D00CB
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_sceneskipendtime(player, value)
{
	[[ self ]]->set_sceneskipendtime(player, value);
}

