// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class ccp_skip_scene_menu : cluielem
{

	/*
		Name: constructor
		Namespace: ccp_skip_scene_menu
		Checksum: 0xD1BD8FA3
		Offset: 0x2E0
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
		Checksum: 0x70B5E9E7
		Offset: 0x5D8
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
		Checksum: 0x6EA23EF9
		Offset: 0x5A0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_sceneskipendtime(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "sceneSkipEndTime", value);
	}

	/*
		Name: set_votedtoskip
		Namespace: ccp_skip_scene_menu
		Checksum: 0x53C891D3
		Offset: 0x568
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_votedtoskip(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "votedToSkip", value);
	}

	/*
		Name: set_hostisskipping
		Namespace: ccp_skip_scene_menu
		Checksum: 0x75F74E29
		Offset: 0x530
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_hostisskipping(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "hostIsSkipping", value);
	}

	/*
		Name: set_showskipbutton
		Namespace: ccp_skip_scene_menu
		Checksum: 0xF627E7DE
		Offset: 0x4F8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_showskipbutton(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "showSkipButton", value);
	}

	/*
		Name: open
		Namespace: ccp_skip_scene_menu
		Checksum: 0xFEBCD382
		Offset: 0x4C0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"cp_skip_scene_menu");
	}

	/*
		Name: function_fa582112
		Namespace: ccp_skip_scene_menu
		Checksum: 0xC0500E7B
		Offset: 0x420
		Size: 0x94
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "showSkipButton", 0);
		[[ self ]]->set_data(localclientnum, "hostIsSkipping", 0);
		[[ self ]]->set_data(localclientnum, "votedToSkip", 0);
		[[ self ]]->set_data(localclientnum, "sceneSkipEndTime", 0);
	}

	/*
		Name: register_clientside
		Namespace: ccp_skip_scene_menu
		Checksum: 0x175A237A
		Offset: 0x3F0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: ccp_skip_scene_menu
		Checksum: 0xA8BEA594
		Offset: 0x300
		Size: 0xE4
		Parameters: 5
		Flags: Linked
	*/
	function setup_clientfields(uid, var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("showSkipButton", 1, 2, "int", var_792f3702);
		cluielem::add_clientfield("hostIsSkipping", 1, 1, "int", var_69bfc3be);
		cluielem::add_clientfield("votedToSkip", 1, 1, "int", var_b2a12719);
		cluielem::add_clientfield("sceneSkipEndTime", 1, 3, "int", var_266fe805);
	}

}

#namespace cp_skip_scene_menu;

/*
	Name: register
	Namespace: cp_skip_scene_menu
	Checksum: 0xE217BA1F
	Offset: 0xE8
	Size: 0x70
	Parameters: 5
	Flags: Linked
*/
function register(uid, var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805)
{
	elem = new ccp_skip_scene_menu();
	[[ elem ]]->setup_clientfields(uid, var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805);
	return elem;
}

/*
	Name: register_clientside
	Namespace: cp_skip_scene_menu
	Checksum: 0x1D5DFDBE
	Offset: 0x160
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register_clientside(uid)
{
	elem = new ccp_skip_scene_menu();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: cp_skip_scene_menu
	Checksum: 0x6D31B745
	Offset: 0x1A8
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: cp_skip_scene_menu
	Checksum: 0xFCA6A545
	Offset: 0x1D0
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
	Namespace: cp_skip_scene_menu
	Checksum: 0xAA8C5706
	Offset: 0x1F8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_showskipbutton
	Namespace: cp_skip_scene_menu
	Checksum: 0x7370161
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_showskipbutton(localclientnum, value)
{
	[[ self ]]->set_showskipbutton(localclientnum, value);
}

/*
	Name: set_hostisskipping
	Namespace: cp_skip_scene_menu
	Checksum: 0x7089A29C
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_hostisskipping(localclientnum, value)
{
	[[ self ]]->set_hostisskipping(localclientnum, value);
}

/*
	Name: set_votedtoskip
	Namespace: cp_skip_scene_menu
	Checksum: 0x1FBA3A56
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_votedtoskip(localclientnum, value)
{
	[[ self ]]->set_votedtoskip(localclientnum, value);
}

/*
	Name: set_sceneskipendtime
	Namespace: cp_skip_scene_menu
	Checksum: 0xB3872FFB
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_sceneskipendtime(localclientnum, value)
{
	[[ self ]]->set_sceneskipendtime(localclientnum, value);
}

