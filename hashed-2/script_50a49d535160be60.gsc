// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_hint_text;

/*
	Name: register
	Namespace: zm_hint_text
	Checksum: 0xE5EDE5DA
	Offset: 0xC0
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function register(uid, var_f5852d69)
{
	object = new var_cd621025();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_f5852d69);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_hint_text
	Checksum: 0xAA1958C
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_cd621025();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_hint_text
	Checksum: 0x9C11E507
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
	Namespace: zm_hint_text
	Checksum: 0x66C1BC35
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
	Namespace: zm_hint_text
	Checksum: 0x612C242B
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
	Namespace: zm_hint_text
	Checksum: 0xD6158D1D
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
	Name: function_d5ea17f0
	Namespace: zm_hint_text
	Checksum: 0x2BC07465
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d5ea17f0(localclientnum, value);
}

#namespace namespace_cd621025;

/*
	Name: __constructor
	Namespace: namespace_cd621025
	Checksum: 0x59A48A74
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
	Namespace: namespace_cd621025
	Checksum: 0xF2B1A4B4
	Offset: 0x258
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_f5852d69)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_cd621025
	Checksum: 0x6EA3A43
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
	Namespace: namespace_cd621025
	Checksum: 0xE09D39EF
	Offset: 0x310
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
	[[ self ]]->function_d7d2fcce(localclientnum, "text", #"");
}

/*
	Name: open
	Namespace: namespace_cd621025
	Checksum: 0x3BDDCB8D
	Offset: 0x388
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_hint_text");
}

/*
	Name: set_state
	Namespace: namespace_cd621025
	Checksum: 0xA2162A98
	Offset: 0x3C0
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
	else if(#"visible" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_cd621025
	Checksum: 0xB887F86E
	Offset: 0x478
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "text", value);
}

/*
	Name: __destructor
	Namespace: namespace_cd621025
	Checksum: 0xAED64E4D
	Offset: 0x4B0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_hint_text;

/*
	Name: function_cd621025
	Namespace: zm_hint_text
	Checksum: 0xF56C38DC
	Offset: 0x4D0
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_cd621025()
{
	classes.var_cd621025[0] = spawnstruct();
	classes.var_cd621025[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_cd621025[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_cd621025[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_cd621025[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_cd621025[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_cd621025[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_cd621025[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_cd621025[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_cd621025[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_cd621025[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_cd621025[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_cd621025[0].__vtable[913321084] = &namespace_cd621025::__destructor;
	classes.var_cd621025[0].__vtable[706078736] = &namespace_cd621025::function_d5ea17f0;
	classes.var_cd621025[0].__vtable[655560998] = &namespace_cd621025::set_state;
	classes.var_cd621025[0].__vtable[250899321] = &namespace_cd621025::open;
	classes.var_cd621025[0].__vtable[94887662] = &namespace_cd621025::function_fa582112;
	classes.var_cd621025[0].__vtable[1545318712] = &namespace_cd621025::function_5c1bb138;
	classes.var_cd621025[0].__vtable[1855416484] = &namespace_cd621025::setup_clientfields;
	classes.var_cd621025[0].__vtable[674154906] = &namespace_cd621025::__constructor;
}

