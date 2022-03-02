// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class class_e9d01e1c : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_e9d01e1c
		Checksum: 0x1895A1AA
		Offset: 0x190
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_e9d01e1c
		Checksum: 0x37BBB31B
		Offset: 0x260
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: close
		Namespace: namespace_e9d01e1c
		Checksum: 0x147A73A7
		Offset: 0x230
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		namespace_6aaccc24::function_a68f6e20(player);
	}

	/*
		Name: open
		Namespace: namespace_e9d01e1c
		Checksum: 0x79DA4E5C
		Offset: 0x1E0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		namespace_6aaccc24::function_8b8089ba(player, "debug_center_screen", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_e9d01e1c
		Checksum: 0xDA6394BE
		Offset: 0x1B0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		namespace_6aaccc24::setup_clientfields(uid);
	}

}

#namespace debug_center_screen;

/*
	Name: register
	Namespace: debug_center_screen
	Checksum: 0x9F298373
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new class_e9d01e1c();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: debug_center_screen
	Checksum: 0x5BCA4E14
	Offset: 0x100
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
	Namespace: debug_center_screen
	Checksum: 0xFCA7BC00
	Offset: 0x140
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
	Namespace: debug_center_screen
	Checksum: 0x60346C09
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

