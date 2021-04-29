// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

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
	object = new var_d596aaaa();
	[[ object ]]->__constructor();
	elem = object;
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
	object = new var_d596aaaa();
	[[ object ]]->__constructor();
	elem = object;
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

#namespace namespace_d596aaaa;

/*
	Name: __constructor
	Namespace: namespace_d596aaaa
	Checksum: 0xA551E872
	Offset: 0x1F8
	Size: 0x14
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	namespace_6aaccc24::__constructor();
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
	Name: __destructor
	Namespace: namespace_d596aaaa
	Checksum: 0xAAA138DF
	Offset: 0x360
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_arcade_keys;

/*
	Name: function_d596aaaa
	Namespace: zm_arcade_keys
	Checksum: 0x4A414728
	Offset: 0x380
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_d596aaaa()
{
	classes.var_d596aaaa[0] = spawnstruct();
	classes.var_d596aaaa[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_d596aaaa[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_d596aaaa[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_d596aaaa[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_d596aaaa[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_d596aaaa[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_d596aaaa[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_d596aaaa[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_d596aaaa[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_d596aaaa[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_d596aaaa[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_d596aaaa[0].__vtable[913321084] = &namespace_d596aaaa::__destructor;
	classes.var_d596aaaa[0].__vtable[914682182] = &namespace_d596aaaa::function_3684f146;
	classes.var_d596aaaa[0].__vtable[250899321] = &namespace_d596aaaa::open;
	classes.var_d596aaaa[0].__vtable[94887662] = &namespace_d596aaaa::function_fa582112;
	classes.var_d596aaaa[0].__vtable[1545318712] = &namespace_d596aaaa::function_5c1bb138;
	classes.var_d596aaaa[0].__vtable[1855416484] = &namespace_d596aaaa::setup_clientfields;
	classes.var_d596aaaa[0].__vtable[674154906] = &namespace_d596aaaa::__constructor;
}

