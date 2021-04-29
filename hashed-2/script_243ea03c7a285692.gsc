// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace revive_hud;

/*
	Name: register
	Namespace: revive_hud
	Checksum: 0xC88C96A8
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_135e8f9a();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: revive_hud
	Checksum: 0x7FBCBDAC
	Offset: 0x128
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
	Namespace: revive_hud
	Checksum: 0xF65DD395
	Offset: 0x168
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
	Namespace: revive_hud
	Checksum: 0x42C392A4
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_d5ea17f0
	Namespace: revive_hud
	Checksum: 0xA25A0F67
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	[[ self ]]->function_d5ea17f0(player, value);
}

/*
	Name: function_3b7b386a
	Namespace: revive_hud
	Checksum: 0x12EBF496
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: function_28ebf0f1
	Namespace: revive_hud
	Checksum: 0x9930F51F
	Offset: 0x218
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_28ebf0f1(player, value)
{
	[[ self ]]->function_28ebf0f1(player, value);
}

#namespace namespace_135e8f9a;

/*
	Name: __constructor
	Namespace: namespace_135e8f9a
	Checksum: 0x5094C0B9
	Offset: 0x248
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
	Namespace: namespace_135e8f9a
	Checksum: 0xC7F4ECA2
	Offset: 0x268
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_dcb34c80("string", "text", 1);
	namespace_6aaccc24::function_da693cbe("clientNum", 1, 6, "int");
	namespace_6aaccc24::function_da693cbe("fadeTime", 1, 5, "int");
}

/*
	Name: open
	Namespace: namespace_135e8f9a
	Checksum: 0xCA70395A
	Offset: 0x310
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "revive_hud", persistent);
}

/*
	Name: close
	Namespace: namespace_135e8f9a
	Checksum: 0xA06177E0
	Offset: 0x360
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_d5ea17f0
	Namespace: namespace_135e8f9a
	Checksum: 0xE48CC578
	Offset: 0x390
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d5ea17f0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "text", value);
}

/*
	Name: function_3b7b386a
	Namespace: namespace_135e8f9a
	Checksum: 0x4EEF2D1
	Offset: 0x3D8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "clientNum", value);
}

/*
	Name: function_28ebf0f1
	Namespace: namespace_135e8f9a
	Checksum: 0xEF18594C
	Offset: 0x420
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_28ebf0f1(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "fadeTime", value);
}

/*
	Name: __destructor
	Namespace: namespace_135e8f9a
	Checksum: 0x6A4B80D2
	Offset: 0x468
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace revive_hud;

/*
	Name: function_135e8f9a
	Namespace: revive_hud
	Checksum: 0x8CD6D2C7
	Offset: 0x488
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_135e8f9a()
{
	classes.var_135e8f9a[0] = spawnstruct();
	classes.var_135e8f9a[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_135e8f9a[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_135e8f9a[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_135e8f9a[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_135e8f9a[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_135e8f9a[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_135e8f9a[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_135e8f9a[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_135e8f9a[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_135e8f9a[0].__vtable[913321084] = &namespace_135e8f9a::__destructor;
	classes.var_135e8f9a[0].__vtable[686551281] = &namespace_135e8f9a::function_28ebf0f1;
	classes.var_135e8f9a[0].__vtable[997931114] = &namespace_135e8f9a::function_3b7b386a;
	classes.var_135e8f9a[0].__vtable[706078736] = &namespace_135e8f9a::function_d5ea17f0;
	classes.var_135e8f9a[0].__vtable[1516492343] = &namespace_135e8f9a::close;
	classes.var_135e8f9a[0].__vtable[250899321] = &namespace_135e8f9a::open;
	classes.var_135e8f9a[0].__vtable[1855416484] = &namespace_135e8f9a::setup_clientfields;
	classes.var_135e8f9a[0].__vtable[674154906] = &namespace_135e8f9a::__constructor;
}

