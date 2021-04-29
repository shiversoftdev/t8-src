// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_hint_text;

/*
	Name: register
	Namespace: zm_hint_text
	Checksum: 0x204AD7B4
	Offset: 0xD0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_cd621025();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_hint_text
	Checksum: 0x3EAC8F23
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
	Namespace: zm_hint_text
	Checksum: 0xA0CDC4BA
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
	Namespace: zm_hint_text
	Checksum: 0x1CF802C2
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
	Namespace: zm_hint_text
	Checksum: 0x7674D3EA
	Offset: 0x1A8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_d5ea17f0
	Namespace: zm_hint_text
	Checksum: 0xC8F53F0D
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

#namespace namespace_cd621025;

/*
	Name: __constructor
	Namespace: namespace_cd621025
	Checksum: 0xF06BEBF1
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
	Namespace: namespace_cd621025
	Checksum: 0x3FECF46B
	Offset: 0x228
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 1, "int");
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
}

/*
	Name: open
	Namespace: namespace_cd621025
	Checksum: 0x3C71C8E0
	Offset: 0x2A8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_hint_text", persistent);
}

/*
	Name: close
	Namespace: namespace_cd621025
	Checksum: 0x52E0C176
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
	Namespace: namespace_cd621025
	Checksum: 0x72955B7B
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
	else if(#"visible" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	assertmsg("");
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_cd621025
	Checksum: 0xF4F330C9
	Offset: 0x3F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "text", value);
}

/*
	Name: __destructor
	Namespace: namespace_cd621025
	Checksum: 0xA37C67BB
	Offset: 0x438
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_hint_text;

/*
	Name: function_cd621025
	Namespace: zm_hint_text
	Checksum: 0x3EF74799
	Offset: 0x458
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_cd621025()
{
	classes.var_cd621025[0] = spawnstruct();
	classes.var_cd621025[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_cd621025[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_cd621025[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_cd621025[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_cd621025[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_cd621025[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_cd621025[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_cd621025[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_cd621025[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_cd621025[0].__vtable[913321084] = &namespace_cd621025::__destructor;
	classes.var_cd621025[0].__vtable[706078736] = &namespace_cd621025::function_d5ea17f0;
	classes.var_cd621025[0].__vtable[655560998] = &namespace_cd621025::set_state;
	classes.var_cd621025[0].__vtable[1516492343] = &namespace_cd621025::close;
	classes.var_cd621025[0].__vtable[250899321] = &namespace_cd621025::open;
	classes.var_cd621025[0].__vtable[1855416484] = &namespace_cd621025::setup_clientfields;
	classes.var_cd621025[0].__vtable[674154906] = &namespace_cd621025::__constructor;
}

