// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace ct_timer_mod_ticks;

/*
	Name: register
	Namespace: ct_timer_mod_ticks
	Checksum: 0x7D853C59
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_2b2f0c89)
{
	object = new var_df6cdb94();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_2b2f0c89);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_timer_mod_ticks
	Checksum: 0xDB8F4D7F
	Offset: 0x110
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_df6cdb94();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_timer_mod_ticks
	Checksum: 0xF00DE01B
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0x82E5F13C
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0x615C3B8D
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
	Namespace: ct_timer_mod_ticks
	Checksum: 0xAFA1A19
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
	Name: function_ab409277
	Namespace: ct_timer_mod_ticks
	Checksum: 0x79C8F290
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ab409277(localclientnum, value)
{
	[[ self ]]->function_ab409277(localclientnum, value);
}

#namespace namespace_df6cdb94;

/*
	Name: __constructor
	Namespace: namespace_df6cdb94
	Checksum: 0x4FFBA72A
	Offset: 0x230
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
	Namespace: namespace_df6cdb94
	Checksum: 0x24B36FF5
	Offset: 0x250
	Size: 0x7C
	Parameters: 2
	Flags: None
*/
function setup_clientfields(uid, var_2b2f0c89)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 3, "int");
	namespace_6aaccc24::function_da693cbe("timeMod", 1, 6, "int", var_2b2f0c89);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_df6cdb94
	Checksum: 0x23DA378C
	Offset: 0x2D8
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
	Namespace: namespace_df6cdb94
	Checksum: 0xE97E35B5
	Offset: 0x308
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
	[[ self ]]->function_d7d2fcce(localclientnum, "timeMod", 0);
}

/*
	Name: open
	Namespace: namespace_df6cdb94
	Checksum: 0x3856A1CD
	Offset: 0x370
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"ct_timer_mod_ticks");
}

/*
	Name: set_state
	Namespace: namespace_df6cdb94
	Checksum: 0x593A9C9E
	Offset: 0x3A8
	Size: 0x1C4
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"plus" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"minus" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	else if(#"hash_7a6dd10b5ae58ff6" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 3);
	}
	else if(#"hash_41b001c31e1930c" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 4);
	}
	else if(#"hash_654551b30d95836c" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 5);
	}
	else if(#"hash_39924d1c5b636e37" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 6);
	}
	assertmsg("");
}

/*
	Name: function_ab409277
	Namespace: namespace_df6cdb94
	Checksum: 0xF44FD624
	Offset: 0x578
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_ab409277(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "timeMod", value);
}

/*
	Name: __destructor
	Namespace: namespace_df6cdb94
	Checksum: 0x4A621EB6
	Offset: 0x5B0
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_timer_mod_ticks;

/*
	Name: function_df6cdb94
	Namespace: ct_timer_mod_ticks
	Checksum: 0x6330CFB2
	Offset: 0x5D0
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_df6cdb94()
{
	classes.var_df6cdb94[0] = spawnstruct();
	classes.var_df6cdb94[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_df6cdb94[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_df6cdb94[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_df6cdb94[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_df6cdb94[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_df6cdb94[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_df6cdb94[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_df6cdb94[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_df6cdb94[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_df6cdb94[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_df6cdb94[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_df6cdb94[0].__vtable[913321084] = &namespace_df6cdb94::__destructor;
	classes.var_df6cdb94[0].__vtable[1421831561] = &namespace_df6cdb94::function_ab409277;
	classes.var_df6cdb94[0].__vtable[655560998] = &namespace_df6cdb94::set_state;
	classes.var_df6cdb94[0].__vtable[250899321] = &namespace_df6cdb94::open;
	classes.var_df6cdb94[0].__vtable[94887662] = &namespace_df6cdb94::function_fa582112;
	classes.var_df6cdb94[0].__vtable[1545318712] = &namespace_df6cdb94::function_5c1bb138;
	classes.var_df6cdb94[0].__vtable[1855416484] = &namespace_df6cdb94::setup_clientfields;
	classes.var_df6cdb94[0].__vtable[674154906] = &namespace_df6cdb94::__constructor;
}

