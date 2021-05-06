// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace multi_stage_target_lockon;

/*
	Name: register
	Namespace: multi_stage_target_lockon
	Checksum: 0xC1CD047
	Offset: 0xB8
	Size: 0x58
	Parameters: 3
	Flags: None
*/
function register(uid, var_5a7b4b38, var_29786c92)
{
	object = new var_1233e6c8();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_5a7b4b38, var_29786c92);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: multi_stage_target_lockon
	Checksum: 0x3BC24DE7
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_1233e6c8();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: multi_stage_target_lockon
	Checksum: 0x805FD78F
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
	Namespace: multi_stage_target_lockon
	Checksum: 0xDF513089
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
	Namespace: multi_stage_target_lockon
	Checksum: 0x357536BC
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
	Name: function_c8350e33
	Namespace: multi_stage_target_lockon
	Checksum: 0x625B55E
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c8350e33(localclientnum, value)
{
	[[ self ]]->function_c8350e33(localclientnum, value);
}

/*
	Name: function_f1e8a488
	Namespace: multi_stage_target_lockon
	Checksum: 0x5CBB75D1
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f1e8a488(localclientnum, value)
{
	[[ self ]]->function_f1e8a488(localclientnum, value);
}

#namespace namespace_1233e6c8;

/*
	Name: __constructor
	Namespace: namespace_1233e6c8
	Checksum: 0x5568C6BD
	Offset: 0x238
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
	Namespace: namespace_1233e6c8
	Checksum: 0xFC42BA4
	Offset: 0x258
	Size: 0x84
	Parameters: 3
	Flags: None
*/
function setup_clientfields(uid, var_5a7b4b38, var_29786c92)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("entNum", 1, 6, "int", var_5a7b4b38);
	namespace_6aaccc24::function_da693cbe("targetState", 1, 3, "int", var_29786c92);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_1233e6c8
	Checksum: 0x38C59015
	Offset: 0x2E8
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
	Namespace: namespace_1233e6c8
	Checksum: 0x1EF80C26
	Offset: 0x318
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "entNum", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "targetState", 0);
}

/*
	Name: open
	Namespace: namespace_1233e6c8
	Checksum: 0xC565287E
	Offset: 0x380
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"multi_stage_target_lockon");
}

/*
	Name: function_c8350e33
	Namespace: namespace_1233e6c8
	Checksum: 0x685D4A5E
	Offset: 0x3B8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_c8350e33(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "entNum", value);
}

/*
	Name: function_f1e8a488
	Namespace: namespace_1233e6c8
	Checksum: 0x5F71E01D
	Offset: 0x3F0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_f1e8a488(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "targetState", value);
}

/*
	Name: __destructor
	Namespace: namespace_1233e6c8
	Checksum: 0x968B1252
	Offset: 0x428
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace multi_stage_target_lockon;

/*
	Name: function_1233e6c8
	Namespace: multi_stage_target_lockon
	Checksum: 0x3F706AA0
	Offset: 0x448
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_1233e6c8()
{
	classes.var_1233e6c8[0] = spawnstruct();
	classes.var_1233e6c8[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_1233e6c8[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_1233e6c8[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_1233e6c8[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_1233e6c8[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_1233e6c8[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_1233e6c8[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_1233e6c8[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_1233e6c8[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_1233e6c8[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_1233e6c8[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_1233e6c8[0].__vtable[913321084] = &namespace_1233e6c8::__destructor;
	classes.var_1233e6c8[0].__vtable[236411768] = &namespace_1233e6c8::function_f1e8a488;
	classes.var_1233e6c8[0].__vtable[936047053] = &namespace_1233e6c8::function_c8350e33;
	classes.var_1233e6c8[0].__vtable[250899321] = &namespace_1233e6c8::open;
	classes.var_1233e6c8[0].__vtable[94887662] = &namespace_1233e6c8::function_fa582112;
	classes.var_1233e6c8[0].__vtable[1545318712] = &namespace_1233e6c8::function_5c1bb138;
	classes.var_1233e6c8[0].__vtable[1855416484] = &namespace_1233e6c8::setup_clientfields;
	classes.var_1233e6c8[0].__vtable[674154906] = &namespace_1233e6c8::__constructor;
}

