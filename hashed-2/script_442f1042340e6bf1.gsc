// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_zod_wonderweapon_quest;

/*
	Name: register
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xFEDB0E50
	Offset: 0xC8
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b)
{
	object = new var_5563abae();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xC77E6931
	Offset: 0x140
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_5563abae();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xE2A2D486
	Offset: 0x188
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x68EEF353
	Offset: 0x1B0
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x28CD2CBC
	Offset: 0x1D8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_e5c37a19
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xD6569038
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_e5c37a19(localclientnum, value)
{
	[[ self ]]->function_e5c37a19(localclientnum, value);
}

/*
	Name: function_5c237e79
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xBE223F5B
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5c237e79(localclientnum, value)
{
	[[ self ]]->function_5c237e79(localclientnum, value);
}

/*
	Name: function_52773fa9
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x8A405C92
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_52773fa9(localclientnum, value)
{
	[[ self ]]->function_52773fa9(localclientnum, value);
}

/*
	Name: function_940bbc52
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x79B4923F
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_940bbc52(localclientnum, value)
{
	[[ self ]]->function_940bbc52(localclientnum, value);
}

#namespace namespace_5563abae;

/*
	Name: __constructor
	Namespace: namespace_5563abae
	Checksum: 0x5060E464
	Offset: 0x2C0
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
	Namespace: namespace_5563abae
	Checksum: 0x198C67C4
	Offset: 0x2E0
	Size: 0xE4
	Parameters: 5
	Flags: None
*/
function setup_clientfields(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("radiance", 1, 1, "int", var_89b4773e);
	namespace_6aaccc24::function_da693cbe("plasma", 1, 1, "int", var_703a7074);
	namespace_6aaccc24::function_da693cbe("purity", 1, 1, "int", var_599a1ebc);
	namespace_6aaccc24::function_da693cbe("decay", 1, 1, "int", var_c47850b);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_5563abae
	Checksum: 0x58321293
	Offset: 0x3D0
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
	Namespace: namespace_5563abae
	Checksum: 0x57114EA3
	Offset: 0x400
	Size: 0x94
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "radiance", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "plasma", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "purity", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "decay", 0);
}

/*
	Name: open
	Namespace: namespace_5563abae
	Checksum: 0x87A220AE
	Offset: 0x4A0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_zod_wonderweapon_quest");
}

/*
	Name: function_e5c37a19
	Namespace: namespace_5563abae
	Checksum: 0x642752F1
	Offset: 0x4D8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_e5c37a19(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "radiance", value);
}

/*
	Name: function_5c237e79
	Namespace: namespace_5563abae
	Checksum: 0x1ABC56F0
	Offset: 0x510
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_5c237e79(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "plasma", value);
}

/*
	Name: function_52773fa9
	Namespace: namespace_5563abae
	Checksum: 0x3D73EEA
	Offset: 0x548
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_52773fa9(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "purity", value);
}

/*
	Name: function_940bbc52
	Namespace: namespace_5563abae
	Checksum: 0x7D953140
	Offset: 0x580
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_940bbc52(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "decay", value);
}

/*
	Name: __destructor
	Namespace: namespace_5563abae
	Checksum: 0x69472C9C
	Offset: 0x5B8
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_zod_wonderweapon_quest;

/*
	Name: function_5563abae
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xE114C6A7
	Offset: 0x5D8
	Size: 0x416
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_5563abae()
{
	classes.var_5563abae[0] = spawnstruct();
	classes.var_5563abae[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_5563abae[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_5563abae[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_5563abae[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_5563abae[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_5563abae[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_5563abae[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_5563abae[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_5563abae[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_5563abae[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_5563abae[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_5563abae[0].__vtable[913321084] = &namespace_5563abae::__destructor;
	classes.var_5563abae[0].__vtable[1811170222] = &namespace_5563abae::function_940bbc52;
	classes.var_5563abae[0].__vtable[1383546793] = &namespace_5563abae::function_52773fa9;
	classes.var_5563abae[0].__vtable[1545830009] = &namespace_5563abae::function_5c237e79;
	classes.var_5563abae[0].__vtable[440174055] = &namespace_5563abae::function_e5c37a19;
	classes.var_5563abae[0].__vtable[250899321] = &namespace_5563abae::open;
	classes.var_5563abae[0].__vtable[94887662] = &namespace_5563abae::function_fa582112;
	classes.var_5563abae[0].__vtable[1545318712] = &namespace_5563abae::function_5c1bb138;
	classes.var_5563abae[0].__vtable[1855416484] = &namespace_5563abae::setup_clientfields;
	classes.var_5563abae[0].__vtable[674154906] = &namespace_5563abae::__constructor;
}

