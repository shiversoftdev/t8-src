// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace self_revive_visuals;

/*
	Name: register
	Namespace: self_revive_visuals
	Checksum: 0x5F21748C
	Offset: 0xD8
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function register(uid, var_967a63df, var_e97e7153)
{
	object = new var_1e6cb1a9();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_967a63df, var_e97e7153);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: self_revive_visuals
	Checksum: 0xB6DB94E9
	Offset: 0x138
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_1e6cb1a9();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals
	Checksum: 0x94D21A1F
	Offset: 0x180
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
	Namespace: self_revive_visuals
	Checksum: 0xF452D859
	Offset: 0x1A8
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
	Namespace: self_revive_visuals
	Checksum: 0x23D218AB
	Offset: 0x1D0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_7a5768aa
	Namespace: self_revive_visuals
	Checksum: 0x1D4F4618
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7a5768aa(localclientnum, value)
{
	[[ self ]]->function_7a5768aa(localclientnum, value);
}

/*
	Name: function_d50fdde9
	Namespace: self_revive_visuals
	Checksum: 0x704BA2A5
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d50fdde9(localclientnum, value)
{
	[[ self ]]->function_d50fdde9(localclientnum, value);
}

#namespace namespace_1e6cb1a9;

/*
	Name: __constructor
	Namespace: namespace_1e6cb1a9
	Checksum: 0xD21DFA36
	Offset: 0x258
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
	Checksum: 0xDEBC5CE4
	Offset: 0x278
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function setup_clientfields(uid, var_967a63df, var_e97e7153)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("self_revive_progress_bar_fill", 1, 5, "float", var_967a63df);
	namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float", var_e97e7153);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_1e6cb1a9
	Checksum: 0x6C77A4AD
	Offset: 0x308
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
	Namespace: namespace_1e6cb1a9
	Checksum: 0xDBD7F457
	Offset: 0x338
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "self_revive_progress_bar_fill", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "revive_progress", 0);
}

/*
	Name: open
	Namespace: namespace_1e6cb1a9
	Checksum: 0xED042215
	Offset: 0x3B0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"self_revive_visuals");
}

/*
	Name: function_7a5768aa
	Namespace: namespace_1e6cb1a9
	Checksum: 0x3A66E582
	Offset: 0x3E8
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_7a5768aa(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "self_revive_progress_bar_fill", value);
}

/*
	Name: function_d50fdde9
	Namespace: namespace_1e6cb1a9
	Checksum: 0x4BCA128
	Offset: 0x420
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "revive_progress", value);
}

/*
	Name: __destructor
	Namespace: namespace_1e6cb1a9
	Checksum: 0x803C3979
	Offset: 0x458
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
	Checksum: 0x60E34FA9
	Offset: 0x478
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1e6cb1a9()
{
	classes.var_1e6cb1a9[0] = spawnstruct();
	classes.var_1e6cb1a9[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_1e6cb1a9[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_1e6cb1a9[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_1e6cb1a9[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_1e6cb1a9[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_1e6cb1a9[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_1e6cb1a9[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_1e6cb1a9[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1e6cb1a9[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1e6cb1a9[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1e6cb1a9[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1e6cb1a9[0].__vtable[913321084] = &namespace_1e6cb1a9::__destructor;
	classes.var_1e6cb1a9[0].__vtable[720380439] = &namespace_1e6cb1a9::function_d50fdde9;
	classes.var_1e6cb1a9[0].__vtable[2052548778] = &namespace_1e6cb1a9::function_7a5768aa;
	classes.var_1e6cb1a9[0].__vtable[250899321] = &namespace_1e6cb1a9::open;
	classes.var_1e6cb1a9[0].__vtable[94887662] = &namespace_1e6cb1a9::function_fa582112;
	classes.var_1e6cb1a9[0].__vtable[1545318712] = &namespace_1e6cb1a9::function_5c1bb138;
	classes.var_1e6cb1a9[0].__vtable[1855416484] = &namespace_1e6cb1a9::setup_clientfields;
	classes.var_1e6cb1a9[0].__vtable[674154906] = &namespace_1e6cb1a9::__constructor;
}

