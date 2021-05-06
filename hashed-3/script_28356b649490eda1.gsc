// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace vehicleturretoverheat;

/*
	Name: register
	Namespace: vehicleturretoverheat
	Checksum: 0x262673DA
	Offset: 0xC0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_661989d5)
{
	object = new var_ad2941a0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_661989d5);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: vehicleturretoverheat
	Checksum: 0x3A57C5B5
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_ad2941a0();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: vehicleturretoverheat
	Checksum: 0xDB3BDBDD
	Offset: 0x160
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
	Namespace: vehicleturretoverheat
	Checksum: 0xEBCEA365
	Offset: 0x188
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
	Namespace: vehicleturretoverheat
	Checksum: 0xB3EEBC47
	Offset: 0x1B0
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
	Namespace: vehicleturretoverheat
	Checksum: 0x6CC4F1FB
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: function_fd8c13fb
	Namespace: vehicleturretoverheat
	Checksum: 0x6B997AD2
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_fd8c13fb(localclientnum, value)
{
	[[ self ]]->function_fd8c13fb(localclientnum, value);
}

#namespace namespace_ad2941a0;

/*
	Name: __constructor
	Namespace: namespace_ad2941a0
	Checksum: 0xB0D92252
	Offset: 0x238
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
	Namespace: namespace_ad2941a0
	Checksum: 0xCDCD568A
	Offset: 0x258
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_661989d5)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("bar_percent", 4000, 6, "float", var_661989d5);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_ad2941a0
	Checksum: 0xA474A7F8
	Offset: 0x2E0
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
	Namespace: namespace_ad2941a0
	Checksum: 0x21811193
	Offset: 0x310
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
	[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", 0);
}

/*
	Name: open
	Namespace: namespace_ad2941a0
	Checksum: 0xAB228B31
	Offset: 0x380
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"vehicleturretoverheat");
}

/*
	Name: set_state
	Namespace: namespace_ad2941a0
	Checksum: 0xB0B459A4
	Offset: 0x3B8
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"overheat" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_fd8c13fb
	Namespace: namespace_ad2941a0
	Checksum: 0x38F34591
	Offset: 0x470
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_fd8c13fb(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "bar_percent", value);
}

/*
	Name: __destructor
	Namespace: namespace_ad2941a0
	Checksum: 0x5A7082D3
	Offset: 0x4A8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace vehicleturretoverheat;

/*
	Name: function_ad2941a0
	Namespace: vehicleturretoverheat
	Checksum: 0x7DCC0F3
	Offset: 0x4C8
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ad2941a0()
{
	classes.var_ad2941a0[0] = spawnstruct();
	classes.var_ad2941a0[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_ad2941a0[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_ad2941a0[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_ad2941a0[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_ad2941a0[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_ad2941a0[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_ad2941a0[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_ad2941a0[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ad2941a0[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ad2941a0[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ad2941a0[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ad2941a0[0].__vtable[913321084] = &namespace_ad2941a0::__destructor;
	classes.var_ad2941a0[0].__vtable[41151493] = &namespace_ad2941a0::function_fd8c13fb;
	classes.var_ad2941a0[0].__vtable[655560998] = &namespace_ad2941a0::set_state;
	classes.var_ad2941a0[0].__vtable[250899321] = &namespace_ad2941a0::open;
	classes.var_ad2941a0[0].__vtable[94887662] = &namespace_ad2941a0::function_fa582112;
	classes.var_ad2941a0[0].__vtable[1545318712] = &namespace_ad2941a0::function_5c1bb138;
	classes.var_ad2941a0[0].__vtable[1855416484] = &namespace_ad2941a0::setup_clientfields;
	classes.var_ad2941a0[0].__vtable[674154906] = &namespace_ad2941a0::__constructor;
}

