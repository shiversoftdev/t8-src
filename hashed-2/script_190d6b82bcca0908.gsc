// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_game_over;

/*
	Name: register
	Namespace: zm_game_over
	Checksum: 0x8240444F
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_d1b6325c();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_game_over
	Checksum: 0x5149B9B
	Offset: 0x118
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
	Namespace: zm_game_over
	Checksum: 0xDF8E2A55
	Offset: 0x158
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
	Namespace: zm_game_over
	Checksum: 0xA507035B
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: zm_game_over
	Checksum: 0xE3DB5C1
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_b1ff84a2
	Namespace: zm_game_over
	Checksum: 0xF8A9F347
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_b1ff84a2(player, value)
{
	[[ self ]]->function_b1ff84a2(player, value);
}

#namespace namespace_d1b6325c;

/*
	Name: __constructor
	Namespace: namespace_d1b6325c
	Checksum: 0x24F0633C
	Offset: 0x208
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
	Namespace: namespace_d1b6325c
	Checksum: 0x4C70E9AF
	Offset: 0x228
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("rounds", 1, 8, "int");
}

/*
	Name: open
	Namespace: namespace_d1b6325c
	Checksum: 0x2C474E6D
	Offset: 0x2A8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_game_over", persistent);
}

/*
	Name: close
	Namespace: namespace_d1b6325c
	Checksum: 0xEF2701E9
	Offset: 0x2F8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_state
	Namespace: namespace_d1b6325c
	Checksum: 0xDC920510
	Offset: 0x328
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_6a6a4ebfc877658c" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_b1ff84a2
	Namespace: namespace_d1b6325c
	Checksum: 0x6B7AB323
	Offset: 0x3F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_b1ff84a2(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "rounds", value);
}

/*
	Name: __destructor
	Namespace: namespace_d1b6325c
	Checksum: 0xA7C4A749
	Offset: 0x438
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_game_over;

/*
	Name: function_d1b6325c
	Namespace: zm_game_over
	Checksum: 0x2FA19B7
	Offset: 0x458
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_d1b6325c()
{
	classes.var_d1b6325c[0] = spawnstruct();
	classes.var_d1b6325c[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_d1b6325c[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_d1b6325c[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_d1b6325c[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_d1b6325c[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_d1b6325c[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_d1b6325c[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_d1b6325c[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_d1b6325c[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_d1b6325c[0].__vtable[913321084] = &namespace_d1b6325c::__destructor;
	classes.var_d1b6325c[0].__vtable[1308654430] = &namespace_d1b6325c::function_b1ff84a2;
	classes.var_d1b6325c[0].__vtable[655560998] = &namespace_d1b6325c::set_state;
	classes.var_d1b6325c[0].__vtable[1516492343] = &namespace_d1b6325c::close;
	classes.var_d1b6325c[0].__vtable[250899321] = &namespace_d1b6325c::open;
	classes.var_d1b6325c[0].__vtable[1855416484] = &namespace_d1b6325c::setup_clientfields;
	classes.var_d1b6325c[0].__vtable[674154906] = &namespace_d1b6325c::__constructor;
}

