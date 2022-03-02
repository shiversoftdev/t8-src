// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_94abfc09 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_94abfc09
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
		Namespace: namespace_94abfc09
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
		Name: function_dad9a8ef
		Namespace: namespace_94abfc09
		Checksum: 0x6EA23EF9
		Offset: 0x5A0
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_dad9a8ef(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "sceneSkipEndTime", value);
	}

	/*
		Name: function_5d0d17fd
		Namespace: namespace_94abfc09
		Checksum: 0x53C891D3
		Offset: 0x568
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_5d0d17fd(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "votedToSkip", value);
	}

	/*
		Name: function_300eba00
		Namespace: namespace_94abfc09
		Checksum: 0x75F74E29
		Offset: 0x530
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_300eba00(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "hostIsSkipping", value);
	}

	/*
		Name: function_6c680730
		Namespace: namespace_94abfc09
		Checksum: 0xF627E7DE
		Offset: 0x4F8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function function_6c680730(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "showSkipButton", value);
	}

	/*
		Name: open
		Namespace: namespace_94abfc09
		Checksum: 0xFEBCD382
		Offset: 0x4C0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"cp_skip_scene_menu");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_94abfc09
		Checksum: 0xC0500E7B
		Offset: 0x420
		Size: 0x94
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "showSkipButton", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "hostIsSkipping", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "votedToSkip", 0);
		[[ self ]]->function_d7d2fcce(localclientnum, "sceneSkipEndTime", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_94abfc09
		Checksum: 0x175A237A
		Offset: 0x3F0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_94abfc09
		Checksum: 0xA8BEA594
		Offset: 0x300
		Size: 0xE4
		Parameters: 5
		Flags: Linked
	*/
	function setup_clientfields(uid, var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("showSkipButton", 1, 2, "int", var_792f3702);
		namespace_6aaccc24::function_da693cbe("hostIsSkipping", 1, 1, "int", var_69bfc3be);
		namespace_6aaccc24::function_da693cbe("votedToSkip", 1, 1, "int", var_b2a12719);
		namespace_6aaccc24::function_da693cbe("sceneSkipEndTime", 1, 3, "int", var_266fe805);
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
	elem = new class_94abfc09();
	[[ elem ]]->setup_clientfields(uid, var_792f3702, var_69bfc3be, var_b2a12719, var_266fe805);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: cp_skip_scene_menu
	Checksum: 0x1D5DFDBE
	Offset: 0x160
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_94abfc09();
	[[ elem ]]->function_5c1bb138(uid);
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
	Name: function_6c680730
	Namespace: cp_skip_scene_menu
	Checksum: 0x7370161
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_6c680730(localclientnum, value)
{
	[[ self ]]->function_6c680730(localclientnum, value);
}

/*
	Name: function_300eba00
	Namespace: cp_skip_scene_menu
	Checksum: 0x7089A29C
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_300eba00(localclientnum, value)
{
	[[ self ]]->function_300eba00(localclientnum, value);
}

/*
	Name: function_5d0d17fd
	Namespace: cp_skip_scene_menu
	Checksum: 0x1FBA3A56
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5d0d17fd(localclientnum, value)
{
	[[ self ]]->function_5d0d17fd(localclientnum, value);
}

/*
	Name: function_dad9a8ef
	Namespace: cp_skip_scene_menu
	Checksum: 0xB3872FFB
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_dad9a8ef(localclientnum, value)
{
	[[ self ]]->function_dad9a8ef(localclientnum, value);
}

