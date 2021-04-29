// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_trial_timer;

/*
	Name: register
	Namespace: zm_trial_timer
	Checksum: 0x1B5E4684
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_3df1eeda();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_timer
	Checksum: 0x313ECA49
	Offset: 0x130
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_trial_timer
	Checksum: 0xF9250091
	Offset: 0x170
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: zm_trial_timer
	Checksum: 0xC5809CA1
	Offset: 0x198
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_8ede8e82
	Namespace: zm_trial_timer
	Checksum: 0xD4255224
	Offset: 0x1C0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_8ede8e82(player, value)
{
	[[ self ]]->function_8ede8e82(player, value);
}

/*
	Name: function_6ad54036
	Namespace: zm_trial_timer
	Checksum: 0x8CF695
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_6ad54036(player, value)
{
	[[ self ]]->function_6ad54036(player, value);
}

#namespace namespace_3df1eeda;

/*
	Name: __constructor
	Namespace: namespace_3df1eeda
	Checksum: 0x3F78A266
	Offset: 0x220
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
	Checksum: 0x1405EF7
	Offset: 0x240
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "timer_text", 1);
	namespace_6aaccc24::function_da693cbe("under_round_rules", 5000, 1, "int");
}

/*
	Name: open
	Namespace: namespace_3df1eeda
	Checksum: 0x879C2E53
	Offset: 0x2C0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_trial_timer", persistent);
}

/*
	Name: close
	Namespace: namespace_3df1eeda
	Checksum: 0x58B8363D
	Offset: 0x310
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_8ede8e82
	Namespace: namespace_3df1eeda
	Checksum: 0xE2B92088
	Offset: 0x340
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_8ede8e82(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "timer_text", value);
}

/*
	Name: function_6ad54036
	Namespace: namespace_3df1eeda
	Checksum: 0xB293F207
	Offset: 0x388
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_6ad54036(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "under_round_rules", value);
}

/*
	Name: __destructor
	Namespace: namespace_3df1eeda
	Checksum: 0xCE7AB3BE
	Offset: 0x3D0
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
	Checksum: 0xA0D1787F
	Offset: 0x3F0
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_3df1eeda()
{
	classes.var_3df1eeda[0] = spawnstruct();
	classes.var_3df1eeda[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_3df1eeda[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_3df1eeda[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_3df1eeda[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_3df1eeda[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_3df1eeda[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_3df1eeda[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_3df1eeda[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_3df1eeda[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_3df1eeda[0].__vtable[913321084] = &namespace_3df1eeda::__destructor;
	classes.var_3df1eeda[0].__vtable[1792360502] = &namespace_3df1eeda::function_6ad54036;
	classes.var_3df1eeda[0].__vtable[1898017150] = &namespace_3df1eeda::function_8ede8e82;
	classes.var_3df1eeda[0].__vtable[1516492343] = &namespace_3df1eeda::close;
	classes.var_3df1eeda[0].__vtable[250899321] = &namespace_3df1eeda::open;
	classes.var_3df1eeda[0].__vtable[1855416484] = &namespace_3df1eeda::setup_clientfields;
	classes.var_3df1eeda[0].__vtable[674154906] = &namespace_3df1eeda::__constructor;
}

