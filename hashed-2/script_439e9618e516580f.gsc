// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_94abfc09 : class_6aaccc24
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: namespace_94abfc09
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
		Namespace: namespace_94abfc09
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
		Name: function_dad9a8ef
		Namespace: namespace_94abfc09
		Checksum: 0xF75FEB76
		Offset: 0x4E0
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_dad9a8ef(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "sceneSkipEndTime", value);
	}

	/*
		Name: function_5d0d17fd
		Namespace: namespace_94abfc09
		Checksum: 0x2C8AF207
		Offset: 0x498
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_5d0d17fd(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "votedToSkip", value);
	}

	/*
		Name: function_300eba00
		Namespace: namespace_94abfc09
		Checksum: 0x92E3EB95
		Offset: 0x450
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_300eba00(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "hostIsSkipping", value);
	}

	/*
		Name: function_6c680730
		Namespace: namespace_94abfc09
		Checksum: 0x81DD097F
		Offset: 0x408
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function function_6c680730(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "showSkipButton", value);
	}

	/*
		Name: close
		Namespace: namespace_94abfc09
		Checksum: 0xD548BD5C
		Offset: 0x3D8
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_94abfc09
		Checksum: 0xA5ECDF73
		Offset: 0x388
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "cp_skip_scene_menu", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_94abfc09
		Checksum: 0x3395831A
		Offset: 0x2B8
		Size: 0xC4
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("showSkipButton", 1, 2, "int");
		namespace_6aaccc24::function_da693cbe("hostIsSkipping", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("votedToSkip", 1, 1, "int");
		namespace_6aaccc24::function_da693cbe("sceneSkipEndTime", 1, 3, "int");
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
	elem = new class_94abfc09();
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
	Name: function_6c680730
	Namespace: cp_skip_scene_menu
	Checksum: 0x1C0C8CDC
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_6c680730(player, value)
{
	[[ self ]]->function_6c680730(player, value);
}

/*
	Name: function_300eba00
	Namespace: cp_skip_scene_menu
	Checksum: 0x8237D3B3
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_300eba00(player, value)
{
	[[ self ]]->function_300eba00(player, value);
}

/*
	Name: function_5d0d17fd
	Namespace: cp_skip_scene_menu
	Checksum: 0xEAD7B66B
	Offset: 0x238
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_5d0d17fd(player, value)
{
	[[ self ]]->function_5d0d17fd(player, value);
}

/*
	Name: function_dad9a8ef
	Namespace: cp_skip_scene_menu
	Checksum: 0x5A2D00CB
	Offset: 0x268
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_dad9a8ef(player, value)
{
	[[ self ]]->function_dad9a8ef(player, value);
}

