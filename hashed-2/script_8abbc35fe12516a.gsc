// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace mp_prop_timer;

/*
	Name: register
	Namespace: mp_prop_timer
	Checksum: 0x83A467A5
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_cf08fa2b();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_prop_timer
	Checksum: 0xA64D052
	Offset: 0x120
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
	Namespace: mp_prop_timer
	Checksum: 0x6A1278B6
	Offset: 0x160
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
	Namespace: mp_prop_timer
	Checksum: 0xBB8ED28B
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_cb4a80b1
	Namespace: mp_prop_timer
	Checksum: 0x4A034187
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cb4a80b1(player, value)
{
	[[ self ]]->function_cb4a80b1(player, value);
}

/*
	Name: function_51883733
	Namespace: mp_prop_timer
	Checksum: 0xBE7D7888
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_51883733(player, value)
{
	[[ self ]]->function_51883733(player, value);
}

#namespace namespace_cf08fa2b;

/*
	Name: __constructor
	Namespace: namespace_cf08fa2b
	Checksum: 0xEF9CBA39
	Offset: 0x210
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
	Namespace: namespace_cf08fa2b
	Checksum: 0xAB4DCEED
	Offset: 0x230
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("timeRemaining", 16000, 5, "int", 0);
	namespace_6aaccc24::function_da693cbe("isProp", 16000, 1, "int");
}

/*
	Name: open
	Namespace: namespace_cf08fa2b
	Checksum: 0xBE5643E
	Offset: 0x2B0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "mp_prop_timer", persistent);
}

/*
	Name: close
	Namespace: namespace_cf08fa2b
	Checksum: 0x4EAAEA3B
	Offset: 0x300
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_cb4a80b1
	Namespace: namespace_cf08fa2b
	Checksum: 0x81CA0D4C
	Offset: 0x330
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_cb4a80b1(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "timeRemaining", value);
}

/*
	Name: function_51883733
	Namespace: namespace_cf08fa2b
	Checksum: 0xE3AE3806
	Offset: 0x378
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_51883733(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "isProp", value);
}

/*
	Name: __destructor
	Namespace: namespace_cf08fa2b
	Checksum: 0x29956F93
	Offset: 0x3C0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace mp_prop_timer;

/*
	Name: function_cf08fa2b
	Namespace: mp_prop_timer
	Checksum: 0xD2A8DBAA
	Offset: 0x3E0
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_cf08fa2b()
{
	classes.var_cf08fa2b[0] = spawnstruct();
	classes.var_cf08fa2b[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_cf08fa2b[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_cf08fa2b[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_cf08fa2b[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_cf08fa2b[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_cf08fa2b[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_cf08fa2b[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_cf08fa2b[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_cf08fa2b[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_cf08fa2b[0].__vtable[913321084] = &namespace_cf08fa2b::__destructor;
	classes.var_cf08fa2b[0].__vtable[1367881523] = &namespace_cf08fa2b::function_51883733;
	classes.var_cf08fa2b[0].__vtable[884309839] = &namespace_cf08fa2b::function_cb4a80b1;
	classes.var_cf08fa2b[0].__vtable[1516492343] = &namespace_cf08fa2b::close;
	classes.var_cf08fa2b[0].__vtable[250899321] = &namespace_cf08fa2b::open;
	classes.var_cf08fa2b[0].__vtable[1855416484] = &namespace_cf08fa2b::setup_clientfields;
	classes.var_cf08fa2b[0].__vtable[674154906] = &namespace_cf08fa2b::__constructor;
}

