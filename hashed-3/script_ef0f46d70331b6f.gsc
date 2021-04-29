// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace ct_crash_kill_remaining_enemy;

/*
	Name: register
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0xE2AC7855
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_5d432d7d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x2090F0D4
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_5d432d7d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x48A7E7CD
	Offset: 0x130
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
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x468CCC13
	Offset: 0x158
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
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x1ECA2EF1
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

#namespace namespace_5d432d7d;

/*
	Name: __constructor
	Namespace: namespace_5d432d7d
	Checksum: 0x22DA52FC
	Offset: 0x1A8
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
	Namespace: namespace_5d432d7d
	Checksum: 0xECEFDB36
	Offset: 0x1C8
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_5d432d7d
	Checksum: 0x399EE642
	Offset: 0x1F8
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
	Namespace: namespace_5d432d7d
	Checksum: 0xF4B4344A
	Offset: 0x228
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
}

/*
	Name: open
	Namespace: namespace_5d432d7d
	Checksum: 0x886A6BEC
	Offset: 0x258
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"ct_crash_kill_remaining_enemy");
}

/*
	Name: __destructor
	Namespace: namespace_5d432d7d
	Checksum: 0x4C2CBBFD
	Offset: 0x290
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_crash_kill_remaining_enemy;

/*
	Name: function_5d432d7d
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x8EC780ED
	Offset: 0x2B0
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_5d432d7d()
{
	classes.var_5d432d7d[0] = spawnstruct();
	classes.var_5d432d7d[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_5d432d7d[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_5d432d7d[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_5d432d7d[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_5d432d7d[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_5d432d7d[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_5d432d7d[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_5d432d7d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_5d432d7d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_5d432d7d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_5d432d7d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_5d432d7d[0].__vtable[913321084] = &namespace_5d432d7d::__destructor;
	classes.var_5d432d7d[0].__vtable[250899321] = &namespace_5d432d7d::open;
	classes.var_5d432d7d[0].__vtable[94887662] = &namespace_5d432d7d::function_fa582112;
	classes.var_5d432d7d[0].__vtable[1545318712] = &namespace_5d432d7d::function_5c1bb138;
	classes.var_5d432d7d[0].__vtable[1855416484] = &namespace_5d432d7d::setup_clientfields;
	classes.var_5d432d7d[0].__vtable[674154906] = &namespace_5d432d7d::__constructor;
}

