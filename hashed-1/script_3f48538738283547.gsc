// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_towers_crowd_meter;

/*
	Name: register
	Namespace: zm_towers_crowd_meter
	Checksum: 0xF81AB299
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_6ad1a3bb)
{
	object = new var_44e9a2c5();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_6ad1a3bb);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_towers_crowd_meter
	Checksum: 0xECDAC24
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_44e9a2c5();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_crowd_meter
	Checksum: 0xFD22EAE5
	Offset: 0x158
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x57F33C7F
	Offset: 0x180
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x403FE8A
	Offset: 0x1A8
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
	Namespace: zm_towers_crowd_meter
	Checksum: 0x5D4D4467
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_visible
	Namespace: zm_towers_crowd_meter
	Checksum: 0xEF530CC4
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_visible(localclientnum, value)
{
	[[ self ]]->set_visible(localclientnum, value);
}

#namespace namespace_44e9a2c5;

/*
	Name: __constructor
	Namespace: namespace_44e9a2c5
	Checksum: 0x8664627D
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
	Namespace: namespace_44e9a2c5
	Checksum: 0xCE367597
	Offset: 0x250
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_6ad1a3bb)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 4, "int");
	namespace_6aaccc24::function_da693cbe("visible", 1, 1, "int", var_6ad1a3bb);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_44e9a2c5
	Checksum: 0xCD390F97
	Offset: 0x2D8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_44e9a2c5
	Checksum: 0x2A4CBC0B
	Offset: 0x308
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
	[[ self ]]->function_d7d2fcce(localclientnum, "visible", 0);
}

/*
	Name: open
	Namespace: namespace_44e9a2c5
	Checksum: 0x1CC81DB2
	Offset: 0x370
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_towers_crowd_meter");
}

/*
	Name: set_state
	Namespace: namespace_44e9a2c5
	Checksum: 0xE7951BD4
	Offset: 0x3A8
	Size: 0x2DC
	Parameters: 2
	Flags: Linked
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"hash_2b0516887b8c733" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"crowd_loathes" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	else if(#"crowd_hates" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 3);
	}
	else if(#"crowd_no_love" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 4);
	}
	else if(#"crowd_warm_up" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 5);
	}
	else if(#"crowd_likes" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 6);
	}
	else if(#"crowd_loves" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 7);
	}
	else if(#"crowd_power_up_available_good" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 8);
	}
	else if(#"crowd_power_up_available_bad" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 9);
	}
	else if(#"crowd_power_up_available_good_partial" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 10);
	}
	else if(#"crowd_power_up_available_bad_partial" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 11);
	}
	assertmsg("");
}

/*
	Name: set_visible
	Namespace: namespace_44e9a2c5
	Checksum: 0xD6858549
	Offset: 0x690
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function set_visible(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "visible", value);
}

/*
	Name: __destructor
	Namespace: namespace_44e9a2c5
	Checksum: 0x4CE8482B
	Offset: 0x6C8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_towers_crowd_meter;

/*
	Name: function_44e9a2c5
	Namespace: zm_towers_crowd_meter
	Checksum: 0x3D6AC54F
	Offset: 0x6E8
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_44e9a2c5()
{
	classes.var_44e9a2c5[0] = spawnstruct();
	classes.var_44e9a2c5[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_44e9a2c5[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_44e9a2c5[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_44e9a2c5[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_44e9a2c5[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_44e9a2c5[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_44e9a2c5[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_44e9a2c5[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_44e9a2c5[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_44e9a2c5[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_44e9a2c5[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_44e9a2c5[0].__vtable[913321084] = &namespace_44e9a2c5::__destructor;
	classes.var_44e9a2c5[0].__vtable[658471132] = &namespace_44e9a2c5::set_visible;
	classes.var_44e9a2c5[0].__vtable[655560998] = &namespace_44e9a2c5::set_state;
	classes.var_44e9a2c5[0].__vtable[250899321] = &namespace_44e9a2c5::open;
	classes.var_44e9a2c5[0].__vtable[94887662] = &namespace_44e9a2c5::function_fa582112;
	classes.var_44e9a2c5[0].__vtable[1545318712] = &namespace_44e9a2c5::function_5c1bb138;
	classes.var_44e9a2c5[0].__vtable[1855416484] = &namespace_44e9a2c5::setup_clientfields;
	classes.var_44e9a2c5[0].__vtable[674154906] = &namespace_44e9a2c5::__constructor;
}

