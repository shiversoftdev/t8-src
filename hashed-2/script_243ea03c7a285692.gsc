// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class crevive_hud : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: crevive_hud
		Checksum: 0x5094C0B9
		Offset: 0x248
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: crevive_hud
		Checksum: 0x6A4B80D2
		Offset: 0x468
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_fadeTime
		Namespace: crevive_hud
		Checksum: 0xEF18594C
		Offset: 0x420
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_fadeTime(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "fadeTime", value);
	}

	/*
		Name: set_clientnum
		Namespace: crevive_hud
		Checksum: 0x4EEF2D1
		Offset: 0x3D8
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_clientnum(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "clientNum", value);
	}

	/*
		Name: set_text
		Namespace: crevive_hud
		Checksum: 0xE48CC578
		Offset: 0x390
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_text(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "text", value);
	}

	/*
		Name: close
		Namespace: crevive_hud
		Checksum: 0xA06177E0
		Offset: 0x360
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
		Namespace: crevive_hud
		Checksum: 0xCA70395A
		Offset: 0x310
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "revive_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: crevive_hud
		Checksum: 0xC7F4ECA2
		Offset: 0x268
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_dcb34c80("string", "text", 1);
		cLUIelem::function_da693cbe("clientNum", 1, 6, "int");
		cLUIelem::function_da693cbe("fadeTime", 1, 5, "int");
	}

}

#namespace revive_hud;

/*
	Name: register
	Namespace: revive_hud
	Checksum: 0xC88C96A8
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new crevive_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: revive_hud
	Checksum: 0x7FBCBDAC
	Offset: 0x128
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
	Namespace: revive_hud
	Checksum: 0xF65DD395
	Offset: 0x168
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
	Namespace: revive_hud
	Checksum: 0x42C392A4
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_text
	Namespace: revive_hud
	Checksum: 0xA25A0F67
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_text(player, value)
{
	[[ self ]]->set_text(player, value);
}

/*
	Name: set_clientnum
	Namespace: revive_hud
	Checksum: 0x12EBF496
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_clientnum(player, value)
{
	[[ self ]]->set_clientnum(player, value);
}

/*
	Name: set_fadeTime
	Namespace: revive_hud
	Checksum: 0x9930F51F
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_fadeTime(player, value)
{
	[[ self ]]->set_fadeTime(player, value);
}

