// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_towers_challenges_hud;

/*
	Name: function_96a13e5c
	Namespace: zm_towers_challenges_hud
	Checksum: 0x948B7158
	Offset: 0x108
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_96a13e5c(player, value)
{
	value = int(value * 100);
	[[ self ]]->function_affe8f61(player, value);
}

/*
	Name: register
	Namespace: zm_towers_challenges_hud
	Checksum: 0xC18A0693
	Offset: 0x158
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_bff7216d();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_challenges_hud
	Checksum: 0x711EACAB
	Offset: 0x1A0
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: zm_towers_challenges_hud
	Checksum: 0x692D22E2
	Offset: 0x1E0
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0xABC259FA
	Offset: 0x208
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_state
	Namespace: zm_towers_challenges_hud
	Checksum: 0xBF0988E4
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_affe8f61
	Namespace: zm_towers_challenges_hud
	Checksum: 0xFA343D39
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(player, value)
{
	[[ self ]]->function_affe8f61(player, value);
}

/*
	Name: function_7a344bdf
	Namespace: zm_towers_challenges_hud
	Checksum: 0x706C61B3
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_7a344bdf(player, value)
{
	[[ self ]]->function_7a344bdf(player, value);
}

/*
	Name: function_f718efbf
	Namespace: zm_towers_challenges_hud
	Checksum: 0xD6911059
	Offset: 0x2C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f718efbf(player, value)
{
	[[ self ]]->function_f718efbf(player, value);
}

#namespace namespace_bff7216d;

/*
	Name: __constructor
	Namespace: namespace_bff7216d
	Checksum: 0xC511489C
	Offset: 0x2F0
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
	Namespace: namespace_bff7216d
	Checksum: 0x20018BE2
	Offset: 0x310
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_da693cbe("progress", 1, 7, "int");
	namespace_6aaccc24::function_dcb34c80("string", "challenge_text", 1);
	namespace_6aaccc24::function_da693cbe("required_goal", 1, 7, "int");
}

/*
	Name: open
	Namespace: namespace_bff7216d
	Checksum: 0x7013151B
	Offset: 0x3E0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_towers_challenges_hud", persistent);
}

/*
	Name: close
	Namespace: namespace_bff7216d
	Checksum: 0x9281A761
	Offset: 0x430
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: set_state
	Namespace: namespace_bff7216d
	Checksum: 0x64B90745
	Offset: 0x460
	Size: 0xBC
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hidden" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_affe8f61
	Namespace: namespace_bff7216d
	Checksum: 0x167B897B
	Offset: 0x528
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_affe8f61(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "progress", value);
}

/*
	Name: function_7a344bdf
	Namespace: namespace_bff7216d
	Checksum: 0xE6850323
	Offset: 0x570
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_7a344bdf(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "challenge_text", value);
}

/*
	Name: function_f718efbf
	Namespace: namespace_bff7216d
	Checksum: 0x64F2B24F
	Offset: 0x5B8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_f718efbf(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "required_goal", value);
}

/*
	Name: __destructor
	Namespace: namespace_bff7216d
	Checksum: 0x6F2EA176
	Offset: 0x600
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_towers_challenges_hud;

/*
	Name: function_bff7216d
	Namespace: zm_towers_challenges_hud
	Checksum: 0x336F39B3
	Offset: 0x620
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_bff7216d()
{
	classes.var_bff7216d[0] = spawnstruct();
	classes.var_bff7216d[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_bff7216d[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_bff7216d[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_bff7216d[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_bff7216d[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_bff7216d[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_bff7216d[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_bff7216d[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_bff7216d[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_bff7216d[0].__vtable[913321084] = &namespace_bff7216d::__destructor;
	classes.var_bff7216d[0].__vtable[149360705] = &namespace_bff7216d::function_f718efbf;
	classes.var_bff7216d[0].__vtable[2050247647] = &namespace_bff7216d::function_7a344bdf;
	classes.var_bff7216d[0].__vtable[1342271647] = &namespace_bff7216d::function_affe8f61;
	classes.var_bff7216d[0].__vtable[655560998] = &namespace_bff7216d::set_state;
	classes.var_bff7216d[0].__vtable[1516492343] = &namespace_bff7216d::close;
	classes.var_bff7216d[0].__vtable[250899321] = &namespace_bff7216d::open;
	classes.var_bff7216d[0].__vtable[1855416484] = &namespace_bff7216d::setup_clientfields;
	classes.var_bff7216d[0].__vtable[674154906] = &namespace_bff7216d::__constructor;
}

