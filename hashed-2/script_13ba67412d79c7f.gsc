// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_trial_timer;

/*
	Name: register
	Namespace: zm_trial_timer
	Checksum: 0x6EAB7518
	Offset: 0xD0
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function register(uid, var_96b8e5ea, var_33be6591)
{
	object = new var_3df1eeda();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_96b8e5ea, var_33be6591);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_trial_timer
	Checksum: 0x4B9FFEC3
	Offset: 0x130
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_3df1eeda();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_timer
	Checksum: 0x485BC28C
	Offset: 0x178
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
	Namespace: zm_trial_timer
	Checksum: 0xC6C1FAF3
	Offset: 0x1A0
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
	Namespace: zm_trial_timer
	Checksum: 0x54E77AA0
	Offset: 0x1C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_8ede8e82
	Namespace: zm_trial_timer
	Checksum: 0xE311A4FC
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8ede8e82(localclientnum, value)
{
	[[ self ]]->function_8ede8e82(localclientnum, value);
}

/*
	Name: function_6ad54036
	Namespace: zm_trial_timer
	Checksum: 0xC514C77A
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_6ad54036(localclientnum, value)
{
	[[ self ]]->function_6ad54036(localclientnum, value);
}

#namespace namespace_3df1eeda;

/*
	Name: __constructor
	Namespace: namespace_3df1eeda
	Checksum: 0x14803EF2
	Offset: 0x250
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
	Namespace: namespace_3df1eeda
	Checksum: 0x172B89AD
	Offset: 0x270
	Size: 0x84
	Parameters: 3
	Flags: Linked
*/
function setup_clientfields(uid, var_96b8e5ea, var_33be6591)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "timer_text", 1);
	namespace_6aaccc24::function_da693cbe("under_round_rules", 5000, 1, "int", var_33be6591);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_3df1eeda
	Checksum: 0x688FB4BF
	Offset: 0x300
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
	Namespace: namespace_3df1eeda
	Checksum: 0xA534817C
	Offset: 0x330
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "timer_text", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "under_round_rules", 0);
}

/*
	Name: open
	Namespace: namespace_3df1eeda
	Checksum: 0xACCDE763
	Offset: 0x3A0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_trial_timer");
}

/*
	Name: function_8ede8e82
	Namespace: namespace_3df1eeda
	Checksum: 0x16648483
	Offset: 0x3D8
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_8ede8e82(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "timer_text", value);
}

/*
	Name: function_6ad54036
	Namespace: namespace_3df1eeda
	Checksum: 0x65BE9101
	Offset: 0x410
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function function_6ad54036(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "under_round_rules", value);
}

/*
	Name: __destructor
	Namespace: namespace_3df1eeda
	Checksum: 0xDE887E2C
	Offset: 0x448
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_trial_timer;

/*
	Name: function_3df1eeda
	Namespace: zm_trial_timer
	Checksum: 0xE3A5A1E5
	Offset: 0x468
	Size: 0x3B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_3df1eeda()
{
	classes.var_3df1eeda[0] = spawnstruct();
	classes.var_3df1eeda[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_3df1eeda[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_3df1eeda[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_3df1eeda[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_3df1eeda[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_3df1eeda[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_3df1eeda[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_3df1eeda[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_3df1eeda[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_3df1eeda[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_3df1eeda[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_3df1eeda[0].__vtable[913321084] = &namespace_3df1eeda::__destructor;
	classes.var_3df1eeda[0].__vtable[1792360502] = &namespace_3df1eeda::function_6ad54036;
	classes.var_3df1eeda[0].__vtable[1898017150] = &namespace_3df1eeda::function_8ede8e82;
	classes.var_3df1eeda[0].__vtable[250899321] = &namespace_3df1eeda::open;
	classes.var_3df1eeda[0].__vtable[94887662] = &namespace_3df1eeda::function_fa582112;
	classes.var_3df1eeda[0].__vtable[1545318712] = &namespace_3df1eeda::function_5c1bb138;
	classes.var_3df1eeda[0].__vtable[1855416484] = &namespace_3df1eeda::setup_clientfields;
	classes.var_3df1eeda[0].__vtable[674154906] = &namespace_3df1eeda::__constructor;
}

