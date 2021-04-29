// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace ct_shared_desc;

/*
	Name: register
	Namespace: ct_shared_desc
	Checksum: 0xBB4E31E5
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_a7489323();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_shared_desc
	Checksum: 0x3CC1832E
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_a7489323();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_desc
	Checksum: 0x69678B99
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
	Namespace: ct_shared_desc
	Checksum: 0x2FF7B883
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
	Namespace: ct_shared_desc
	Checksum: 0xDF764D0A
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
	Namespace: ct_shared_desc
	Checksum: 0xE3AC16B
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

#namespace namespace_a7489323;

/*
	Name: __constructor
	Namespace: namespace_a7489323
	Checksum: 0x5677727
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
	Namespace: namespace_a7489323
	Checksum: 0x24C04009
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
	Namespace: namespace_a7489323
	Checksum: 0x8F17F6E6
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
	Namespace: namespace_a7489323
	Checksum: 0x8C07D54F
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
	Namespace: namespace_a7489323
	Checksum: 0x74D23105
	Offset: 0x2E0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"ct_shared_desc");
}

/*
	Name: set_state
	Namespace: namespace_a7489323
	Checksum: 0xC39709D1
	Offset: 0x318
	Size: 0xE4
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"hash_3319eaa2c590a2ac" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"hash_2ac3b79c708dcfd5" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	assertmsg("");
}

/*
	Name: __destructor
	Namespace: namespace_a7489323
	Checksum: 0xF6DB3857
	Offset: 0x408
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_desc;

/*
	Name: function_a7489323
	Namespace: ct_shared_desc
	Checksum: 0x455F2F9C
	Offset: 0x428
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_a7489323()
{
	classes.var_a7489323[0] = spawnstruct();
	classes.var_a7489323[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_a7489323[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_a7489323[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_a7489323[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_a7489323[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_a7489323[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_a7489323[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_a7489323[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_a7489323[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_a7489323[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_a7489323[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_a7489323[0].__vtable[913321084] = &namespace_a7489323::__destructor;
	classes.var_a7489323[0].__vtable[655560998] = &namespace_a7489323::set_state;
	classes.var_a7489323[0].__vtable[250899321] = &namespace_a7489323::open;
	classes.var_a7489323[0].__vtable[94887662] = &namespace_a7489323::function_fa582112;
	classes.var_a7489323[0].__vtable[1545318712] = &namespace_a7489323::function_5c1bb138;
	classes.var_a7489323[0].__vtable[1855416484] = &namespace_a7489323::setup_clientfields;
	classes.var_a7489323[0].__vtable[674154906] = &namespace_a7489323::__constructor;
}

