// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace seeker_mine_prompt;

/*
	Name: register
	Namespace: seeker_mine_prompt
	Checksum: 0xD0638E0C
	Offset: 0xC8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_afaddf7a, var_ca3086f0)
{
	object = new var_8c34ca59();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_afaddf7a, var_ca3086f0);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: seeker_mine_prompt
	Checksum: 0x845BDBA5
	Offset: 0x128
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_8c34ca59();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: seeker_mine_prompt
	Checksum: 0xED78596A
	Offset: 0x170
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
	Namespace: seeker_mine_prompt
	Checksum: 0x1052FB7F
	Offset: 0x198
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
	Namespace: seeker_mine_prompt
	Checksum: 0xF9ED2318
	Offset: 0x1C0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_affe8f61
	Namespace: seeker_mine_prompt
	Checksum: 0x43A19034
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(localclientnum, value)
{
	[[ self ]]->function_affe8f61(localclientnum, value);
}

/*
	Name: function_c719cfea
	Namespace: seeker_mine_prompt
	Checksum: 0x4A520742
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c719cfea(localclientnum, value)
{
	[[ self ]]->function_c719cfea(localclientnum, value);
}

#namespace namespace_8c34ca59;

/*
	Name: __constructor
	Namespace: namespace_8c34ca59
	Checksum: 0x3D026716
	Offset: 0x248
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
	Namespace: namespace_8c34ca59
	Checksum: 0x6363C40F
	Offset: 0x268
	Size: 0x84
	Parameters: 3
	Flags: None
*/
function setup_clientfields(uid, var_afaddf7a, var_ca3086f0)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("progress", 1, 5, "float", var_afaddf7a);
	namespace_6aaccc24::function_da693cbe("promptState", 1, 2, "int", var_ca3086f0);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_8c34ca59
	Checksum: 0x92C22D06
	Offset: 0x2F8
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
	Namespace: namespace_8c34ca59
	Checksum: 0x9F597F96
	Offset: 0x328
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "promptState", 0);
}

/*
	Name: open
	Namespace: namespace_8c34ca59
	Checksum: 0xADC7A8E0
	Offset: 0x398
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"seeker_mine_prompt");
}

/*
	Name: function_affe8f61
	Namespace: namespace_8c34ca59
	Checksum: 0x25D3D40
	Offset: 0x3D0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_affe8f61(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "progress", value);
}

/*
	Name: function_c719cfea
	Namespace: namespace_8c34ca59
	Checksum: 0x71F37FE4
	Offset: 0x408
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_c719cfea(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "promptState", value);
}

/*
	Name: __destructor
	Namespace: namespace_8c34ca59
	Checksum: 0x3B4F958B
	Offset: 0x440
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace seeker_mine_prompt;

/*
	Name: function_8c34ca59
	Namespace: seeker_mine_prompt
	Checksum: 0x997B6461
	Offset: 0x460
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8c34ca59()
{
	classes.var_8c34ca59[0] = spawnstruct();
	classes.var_8c34ca59[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_8c34ca59[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_8c34ca59[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_8c34ca59[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_8c34ca59[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_8c34ca59[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_8c34ca59[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_8c34ca59[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_8c34ca59[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_8c34ca59[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_8c34ca59[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_8c34ca59[0].__vtable[913321084] = &namespace_8c34ca59::__destructor;
	classes.var_8c34ca59[0].__vtable[954609686] = &namespace_8c34ca59::function_c719cfea;
	classes.var_8c34ca59[0].__vtable[1342271647] = &namespace_8c34ca59::function_affe8f61;
	classes.var_8c34ca59[0].__vtable[250899321] = &namespace_8c34ca59::open;
	classes.var_8c34ca59[0].__vtable[94887662] = &namespace_8c34ca59::function_fa582112;
	classes.var_8c34ca59[0].__vtable[1545318712] = &namespace_8c34ca59::function_5c1bb138;
	classes.var_8c34ca59[0].__vtable[1855416484] = &namespace_8c34ca59::setup_clientfields;
	classes.var_8c34ca59[0].__vtable[674154906] = &namespace_8c34ca59::__constructor;
}

