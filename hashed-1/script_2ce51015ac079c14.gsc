// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace player_insertion_choice;

/*
	Name: register
	Namespace: player_insertion_choice
	Checksum: 0x25C4ABF7
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_9e6034d2();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: player_insertion_choice
	Checksum: 0xD29C4C4
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_9e6034d2();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: player_insertion_choice
	Checksum: 0x9C60B9EE
	Offset: 0x140
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
	Namespace: player_insertion_choice
	Checksum: 0xD97CEFA7
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
	Namespace: player_insertion_choice
	Checksum: 0xCA8D7C01
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_state
	Namespace: player_insertion_choice
	Checksum: 0xFD3836D5
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

#namespace namespace_9e6034d2;

/*
	Name: __constructor
	Namespace: namespace_9e6034d2
	Checksum: 0x693B4085
	Offset: 0x1E8
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
	Namespace: namespace_9e6034d2
	Checksum: 0xCDD77E2B
	Offset: 0x208
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 2, "int");
}

/*
	Name: function_5c1bb138
	Namespace: namespace_9e6034d2
	Checksum: 0x3EDCE539
	Offset: 0x260
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
	Namespace: namespace_9e6034d2
	Checksum: 0xF5C7A3B6
	Offset: 0x290
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
}

/*
	Name: open
	Namespace: namespace_9e6034d2
	Checksum: 0xA447DE09
	Offset: 0x2E0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"player_insertion_choice");
}

/*
	Name: set_state
	Namespace: namespace_9e6034d2
	Checksum: 0x5AA0A3AD
	Offset: 0x318
	Size: 0x11C
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"hash_bcb68d30ea251e2" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"hash_a9365fdb97f532b" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	else if(#"heli" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 3);
	}
	assertmsg("");
}

/*
	Name: __destructor
	Namespace: namespace_9e6034d2
	Checksum: 0x1A8F02DF
	Offset: 0x440
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace player_insertion_choice;

/*
	Name: function_9e6034d2
	Namespace: player_insertion_choice
	Checksum: 0x8D4EEB12
	Offset: 0x460
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_9e6034d2()
{
	classes.var_9e6034d2[0] = spawnstruct();
	classes.var_9e6034d2[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_9e6034d2[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_9e6034d2[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_9e6034d2[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_9e6034d2[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_9e6034d2[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_9e6034d2[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_9e6034d2[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_9e6034d2[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_9e6034d2[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_9e6034d2[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_9e6034d2[0].__vtable[913321084] = &namespace_9e6034d2::__destructor;
	classes.var_9e6034d2[0].__vtable[655560998] = &namespace_9e6034d2::set_state;
	classes.var_9e6034d2[0].__vtable[250899321] = &namespace_9e6034d2::open;
	classes.var_9e6034d2[0].__vtable[94887662] = &namespace_9e6034d2::function_fa582112;
	classes.var_9e6034d2[0].__vtable[1545318712] = &namespace_9e6034d2::function_5c1bb138;
	classes.var_9e6034d2[0].__vtable[1855416484] = &namespace_9e6034d2::setup_clientfields;
	classes.var_9e6034d2[0].__vtable[674154906] = &namespace_9e6034d2::__constructor;
}

