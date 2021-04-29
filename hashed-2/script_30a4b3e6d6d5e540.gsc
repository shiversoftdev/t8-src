// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace self_revive_visuals;

/*
	Name: register
	Namespace: self_revive_visuals
	Checksum: 0xDF881CA3
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_1e6cb1a9();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals
	Checksum: 0x4A4E4B04
	Offset: 0x140
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
	Namespace: self_revive_visuals
	Checksum: 0x90839ABF
	Offset: 0x180
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
	Namespace: self_revive_visuals
	Checksum: 0x941631A6
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_7a5768aa
	Namespace: self_revive_visuals
	Checksum: 0x2E311F5
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7a5768aa(player, value)
{
	[[ self ]]->function_7a5768aa(player, value);
}

/*
	Name: function_d50fdde9
	Namespace: self_revive_visuals
	Checksum: 0xBC271F56
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	[[ self ]]->function_d50fdde9(player, value);
}

#namespace namespace_1e6cb1a9;

/*
	Name: __constructor
	Namespace: namespace_1e6cb1a9
	Checksum: 0x1A335DFD
	Offset: 0x230
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	namespace_6aaccc24::__constructor();
}

/*
	Name: setup_clientfields
	Namespace: namespace_1e6cb1a9
	Checksum: 0xA6D220AB
	Offset: 0x250
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("self_revive_progress_bar_fill", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float");
}

/*
	Name: open
	Namespace: namespace_1e6cb1a9
	Checksum: 0x49A803CC
	Offset: 0x2D0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "self_revive_visuals", persistent);
}

/*
	Name: close
	Namespace: namespace_1e6cb1a9
	Checksum: 0xBCF2A8D
	Offset: 0x320
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_7a5768aa
	Namespace: namespace_1e6cb1a9
	Checksum: 0x33F62F01
	Offset: 0x350
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_7a5768aa(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "self_revive_progress_bar_fill", value);
}

/*
	Name: function_d50fdde9
	Namespace: namespace_1e6cb1a9
	Checksum: 0x23EB0ACD
	Offset: 0x398
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "revive_progress", value);
}

/*
	Name: __destructor
	Namespace: namespace_1e6cb1a9
	Checksum: 0x2D057D23
	Offset: 0x3E0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace self_revive_visuals;

/*
	Name: function_1e6cb1a9
	Namespace: self_revive_visuals
	Checksum: 0x4B978C7A
	Offset: 0x400
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1e6cb1a9()
{
	classes.var_1e6cb1a9[0] = spawnstruct();
	classes.var_1e6cb1a9[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_1e6cb1a9[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_1e6cb1a9[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_1e6cb1a9[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_1e6cb1a9[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_1e6cb1a9[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1e6cb1a9[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1e6cb1a9[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1e6cb1a9[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1e6cb1a9[0].__vtable[913321084] = &namespace_1e6cb1a9::__destructor;
	classes.var_1e6cb1a9[0].__vtable[720380439] = &namespace_1e6cb1a9::function_d50fdde9;
	classes.var_1e6cb1a9[0].__vtable[2052548778] = &namespace_1e6cb1a9::function_7a5768aa;
	classes.var_1e6cb1a9[0].__vtable[1516492343] = &namespace_1e6cb1a9::close;
	classes.var_1e6cb1a9[0].__vtable[250899321] = &namespace_1e6cb1a9::open;
	classes.var_1e6cb1a9[0].__vtable[1855416484] = &namespace_1e6cb1a9::setup_clientfields;
	classes.var_1e6cb1a9[0].__vtable[674154906] = &namespace_1e6cb1a9::__constructor;
}

