// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace zm_laststand_client;

/*
	Name: register
	Namespace: zm_laststand_client
	Checksum: 0x1C64CAF
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_af345a5f();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_laststand_client
	Checksum: 0xD41F7363
	Offset: 0x140
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
	Namespace: zm_laststand_client
	Checksum: 0xE30331E
	Offset: 0x180
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
	Namespace: zm_laststand_client
	Checksum: 0xF9FF5B8A
	Offset: 0x1A8
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_67bdfe40
	Namespace: zm_laststand_client
	Checksum: 0xA6CE9A48
	Offset: 0x1D0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_67bdfe40(player, value)
{
	[[ self ]]->function_67bdfe40(player, value);
}

/*
	Name: function_d50fdde9
	Namespace: zm_laststand_client
	Checksum: 0x2C1A498A
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	[[ self ]]->function_d50fdde9(player, value);
}

/*
	Name: function_65194707
	Namespace: zm_laststand_client
	Checksum: 0x66B06DC2
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_65194707(player, value)
{
	[[ self ]]->function_65194707(player, value);
}

#namespace namespace_af345a5f;

/*
	Name: __constructor
	Namespace: namespace_af345a5f
	Checksum: 0xB4E2EFD1
	Offset: 0x260
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
	Namespace: namespace_af345a5f
	Checksum: 0x23772C
	Offset: 0x280
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("bleedout_progress", 1, 6, "float");
	namespace_6aaccc24::function_da693cbe("revive_progress", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("num_downs", 1, 8, "int");
}

/*
	Name: open
	Namespace: namespace_af345a5f
	Checksum: 0x722B5FF3
	Offset: 0x328
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "zm_laststand_client", persistent);
}

/*
	Name: close
	Namespace: namespace_af345a5f
	Checksum: 0x9CD1480D
	Offset: 0x378
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_67bdfe40
	Namespace: namespace_af345a5f
	Checksum: 0x7F8BCE4F
	Offset: 0x3A8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_67bdfe40(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "bleedout_progress", value);
}

/*
	Name: function_d50fdde9
	Namespace: namespace_af345a5f
	Checksum: 0x31EB79AB
	Offset: 0x3F0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d50fdde9(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "revive_progress", value);
}

/*
	Name: function_65194707
	Namespace: namespace_af345a5f
	Checksum: 0x2AA94CE6
	Offset: 0x438
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_65194707(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "num_downs", value);
}

/*
	Name: __destructor
	Namespace: namespace_af345a5f
	Checksum: 0xA77E0280
	Offset: 0x480
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace zm_laststand_client;

/*
	Name: function_af345a5f
	Namespace: zm_laststand_client
	Checksum: 0xF4724442
	Offset: 0x4A0
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_af345a5f()
{
	classes.var_af345a5f[0] = spawnstruct();
	classes.var_af345a5f[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_af345a5f[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_af345a5f[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_af345a5f[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_af345a5f[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_af345a5f[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_af345a5f[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_af345a5f[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_af345a5f[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_af345a5f[0].__vtable[913321084] = &namespace_af345a5f::__destructor;
	classes.var_af345a5f[0].__vtable[1696155399] = &namespace_af345a5f::function_65194707;
	classes.var_af345a5f[0].__vtable[720380439] = &namespace_af345a5f::function_d50fdde9;
	classes.var_af345a5f[0].__vtable[1740504640] = &namespace_af345a5f::function_67bdfe40;
	classes.var_af345a5f[0].__vtable[1516492343] = &namespace_af345a5f::close;
	classes.var_af345a5f[0].__vtable[250899321] = &namespace_af345a5f::open;
	classes.var_af345a5f[0].__vtable[1855416484] = &namespace_af345a5f::setup_clientfields;
	classes.var_af345a5f[0].__vtable[674154906] = &namespace_af345a5f::__constructor;
}

