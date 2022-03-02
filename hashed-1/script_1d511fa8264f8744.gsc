// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_d596aaaa : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_d596aaaa
		Checksum: 0xA551E872
		Offset: 0x1F8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_d596aaaa
		Checksum: 0xAAA138DF
		Offset: 0x360
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_3684f146
		Namespace: namespace_d596aaaa
		Checksum: 0x6D6B9620
		Offset: 0x328
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_3684f146(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "key_count", value);
	}

	/*
		Name: open
		Namespace: namespace_d596aaaa
		Checksum: 0xA90E618E
		Offset: 0x2F0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"zm_arcade_keys");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_d596aaaa
		Checksum: 0x24775388
		Offset: 0x2A8
		Size: 0x40
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "key_count", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_d596aaaa
		Checksum: 0x25D01136
		Offset: 0x278
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		namespace_6aaccc24::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: namespace_d596aaaa
		Checksum: 0x35C4422B
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_dddbc7e5)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_da693cbe("key_count", 1, 4, "int", var_dddbc7e5);
	}

}

#namespace zm_arcade_keys;

/*
	Name: register
	Namespace: zm_arcade_keys
	Checksum: 0xB16CFB60
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_dddbc7e5)
{
	elem = new class_d596aaaa();
	[[ elem ]]->setup_clientfields(uid, var_dddbc7e5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_arcade_keys
	Checksum: 0xE2E883FB
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_d596aaaa();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_arcade_keys
	Checksum: 0x870FB7B
	Offset: 0x150
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
	Namespace: zm_arcade_keys
	Checksum: 0x1D472012
	Offset: 0x178
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
	Namespace: zm_arcade_keys
	Checksum: 0x7BEFF18
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_3684f146
	Namespace: zm_arcade_keys
	Checksum: 0x75B41968
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3684f146(localclientnum, value)
{
	[[ self ]]->function_3684f146(localclientnum, value);
}

