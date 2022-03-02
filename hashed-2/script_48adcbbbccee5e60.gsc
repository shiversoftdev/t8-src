// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class class_849c5d15 : class_6aaccc24
{

	/*
		Name: constructor
		Namespace: namespace_849c5d15
		Checksum: 0x340CDAD8
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
		Namespace: namespace_849c5d15
		Checksum: 0x863349DE
		Offset: 0x370
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_d5ea17f0
		Namespace: namespace_849c5d15
		Checksum: 0xE9B23DE4
		Offset: 0x338
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function function_d5ea17f0(localclientnum, value)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "text", value);
	}

	/*
		Name: open
		Namespace: namespace_849c5d15
		Checksum: 0x7DF4F754
		Offset: 0x300
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		namespace_6aaccc24::open(localclientnum, #"interactive_shot");
	}

	/*
		Name: function_fa582112
		Namespace: namespace_849c5d15
		Checksum: 0x2DD4505B
		Offset: 0x2A8
		Size: 0x4C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		namespace_6aaccc24::function_fa582112(localclientnum);
		[[ self ]]->function_d7d2fcce(localclientnum, "text", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: namespace_849c5d15
		Checksum: 0xF9634FF2
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
		Namespace: namespace_849c5d15
		Checksum: 0x50EDB24E
		Offset: 0x218
		Size: 0x54
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_f5852d69)
	{
		namespace_6aaccc24::setup_clientfields(uid);
		namespace_6aaccc24::function_dcb34c80("string", "text", 1);
	}

}

#namespace interactive_shot;

/*
	Name: register
	Namespace: interactive_shot
	Checksum: 0x30B9AC25
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_f5852d69)
{
	elem = new class_849c5d15();
	[[ elem ]]->setup_clientfields(uid, var_f5852d69);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: interactive_shot
	Checksum: 0x6CC23690
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new class_849c5d15();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: interactive_shot
	Checksum: 0x602C561
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
	Namespace: interactive_shot
	Checksum: 0x1A05F74F
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
	Namespace: interactive_shot
	Checksum: 0x86A869F8
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
	Name: function_d5ea17f0
	Namespace: interactive_shot
	Checksum: 0x2AC5D9C1
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d5ea17f0(localclientnum, value);
}

