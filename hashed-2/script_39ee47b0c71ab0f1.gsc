// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace zm_trial_weapon_locked;

/*
	Name: register
	Namespace: zm_trial_weapon_locked
	Checksum: 0xAB62E2F1
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_18c795d0)
{
	object = new var_12bf89f7();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_18c795d0);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_trial_weapon_locked
	Checksum: 0x96BECB73
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_5c1bb138(uid)
{
	object = new var_12bf89f7();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_weapon_locked
	Checksum: 0x68A9790A
	Offset: 0x150
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: zm_trial_weapon_locked
	Checksum: 0xC911088B
	Offset: 0x178
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0xE0B7306D
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_1e74977
	Namespace: zm_trial_weapon_locked
	Checksum: 0x8DA03CCC
	Offset: 0x1C8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_1e74977(localclientnum)
{
	[[ self ]]->function_1e74977(localclientnum);
}

#namespace namespace_12bf89f7;

/*
	Name: __constructor
	Namespace: namespace_12bf89f7
	Checksum: 0xB462A51B
	Offset: 0x1F0
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
	Namespace: namespace_12bf89f7
	Checksum: 0x56AE2337
	Offset: 0x210
	Size: 0x54
	Parameters: 2
	Flags: Linked
*/
function setup_clientfields(uid, var_18c795d0)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("show_icon", 1, 1, "counter", var_18c795d0);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_12bf89f7
	Checksum: 0xBE497453
	Offset: 0x270
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
	Namespace: namespace_12bf89f7
	Checksum: 0x70E2304
	Offset: 0x2A0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "show_icon", 0);
}

/*
	Name: open
	Namespace: namespace_12bf89f7
	Checksum: 0x1B4521DF
	Offset: 0x2E8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"zm_trial_weapon_locked");
}

/*
	Name: function_1e74977
	Namespace: namespace_12bf89f7
	Checksum: 0x526A0CD
	Offset: 0x320
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_1e74977(localclientnum)
{
	current_val = [[ self ]]->function_92ba69fa(localclientnum, "show_icon");
	new_val = current_val + 1 % 2;
	[[ self ]]->function_d7d2fcce(localclientnum, "show_icon", new_val);
}

/*
	Name: __destructor
	Namespace: namespace_12bf89f7
	Checksum: 0x42851BF2
	Offset: 0x398
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_trial_weapon_locked;

/*
	Name: function_12bf89f7
	Namespace: zm_trial_weapon_locked
	Checksum: 0x88580C99
	Offset: 0x3B8
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_12bf89f7()
{
	classes.var_12bf89f7[0] = spawnstruct();
	classes.var_12bf89f7[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_12bf89f7[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_12bf89f7[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_12bf89f7[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_12bf89f7[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_12bf89f7[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_12bf89f7[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_12bf89f7[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_12bf89f7[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_12bf89f7[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_12bf89f7[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_12bf89f7[0].__vtable[913321084] = &namespace_12bf89f7::__destructor;
	classes.var_12bf89f7[0].__vtable[31934839] = &namespace_12bf89f7::function_1e74977;
	classes.var_12bf89f7[0].__vtable[250899321] = &namespace_12bf89f7::open;
	classes.var_12bf89f7[0].__vtable[94887662] = &namespace_12bf89f7::function_fa582112;
	classes.var_12bf89f7[0].__vtable[1545318712] = &namespace_12bf89f7::function_5c1bb138;
	classes.var_12bf89f7[0].__vtable[1855416484] = &namespace_12bf89f7::setup_clientfields;
	classes.var_12bf89f7[0].__vtable[674154906] = &namespace_12bf89f7::__constructor;
}

