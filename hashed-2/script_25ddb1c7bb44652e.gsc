// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_tut_hint_text;

/*
	Name: register
	Namespace: zm_tut_hint_text
	Checksum: 0xFDF849C2
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_c8e93137();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_tut_hint_text
	Checksum: 0x1933F22D
	Offset: 0x120
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
	Namespace: zm_tut_hint_text
	Checksum: 0xB3B9EB07
	Offset: 0x160
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
	Namespace: zm_tut_hint_text
	Checksum: 0xC0DDCEA
	Offset: 0x188
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
	Namespace: zm_tut_hint_text
	Checksum: 0xCA048372
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_d5ea17f0
	Namespace: zm_tut_hint_text
	Checksum: 0x5BA9C4D1
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

#namespace namespace_c8e93137;

/*
	Name: __constructor
	Namespace: namespace_c8e93137
	Checksum: 0xF2B79D68
	Offset: 0x210
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
	Namespace: namespace_c8e93137
	Checksum: 0xC73B4407
	Offset: 0x230
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
}

/*
	Name: open
	Namespace: namespace_c8e93137
	Checksum: 0x52408AD9
	Offset: 0x2B0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_tut_hint_text", persistent);
}

/*
	Name: close
	Namespace: namespace_c8e93137
	Checksum: 0x6AF2363F
	Offset: 0x300
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
	Namespace: namespace_c8e93137
	Checksum: 0x587CFC0E
	Offset: 0x330
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
	else if(#"visible" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_c8e93137
	Checksum: 0xE0D368C2
	Offset: 0x3F8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_d5ea17f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "text", value);
}

/*
	Name: __destructor
	Namespace: namespace_c8e93137
	Checksum: 0x2E7C90FC
	Offset: 0x440
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_tut_hint_text;

/*
	Name: function_c8e93137
	Namespace: zm_tut_hint_text
	Checksum: 0xE8C497D4
	Offset: 0x460
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_c8e93137()
{
	classes.var_c8e93137[0] = spawnstruct();
	classes.var_c8e93137[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_c8e93137[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_c8e93137[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_c8e93137[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_c8e93137[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_c8e93137[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_c8e93137[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_c8e93137[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_c8e93137[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_c8e93137[0].__vtable[913321084] = &namespace_c8e93137::__destructor;
	classes.var_c8e93137[0].__vtable[706078736] = &namespace_c8e93137::function_d5ea17f0;
	classes.var_c8e93137[0].__vtable[655560998] = &namespace_c8e93137::set_state;
	classes.var_c8e93137[0].__vtable[1516492343] = &namespace_c8e93137::close;
	classes.var_c8e93137[0].__vtable[250899321] = &namespace_c8e93137::open;
	classes.var_c8e93137[0].__vtable[1855416484] = &namespace_c8e93137::setup_clientfields;
	classes.var_c8e93137[0].__vtable[674154906] = &namespace_c8e93137::__constructor;
}

