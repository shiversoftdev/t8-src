// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace mp_revive_prompt;

/*
	Name: register
	Namespace: mp_revive_prompt
	Checksum: 0x30DC56AC
	Offset: 0xF0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_3cdd43e2();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_revive_prompt
	Checksum: 0x26876B00
	Offset: 0x138
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
	Namespace: mp_revive_prompt
	Checksum: 0xE4FD9A76
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
	Namespace: mp_revive_prompt
	Checksum: 0x9EE86B32
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_3b7b386a
	Namespace: mp_revive_prompt
	Checksum: 0x505D0E79
	Offset: 0x1C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: set_health
	Namespace: mp_revive_prompt
	Checksum: 0xF625634F
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_health(player, value)
{
	[[ self ]]->set_health(player, value);
}

/*
	Name: function_4b3fb8b8
	Namespace: mp_revive_prompt
	Checksum: 0xEB3352B2
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(player, value)
{
	[[ self ]]->function_4b3fb8b8(player, value);
}

#namespace namespace_3cdd43e2;

/*
	Name: __constructor
	Namespace: namespace_3cdd43e2
	Checksum: 0xF5FE5705
	Offset: 0x258
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
	Namespace: namespace_3cdd43e2
	Checksum: 0xD2DF4B9F
	Offset: 0x278
	Size: 0x9C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int", 0);
	namespace_6aaccc24::function_da693cbe("health", 1, 5, "float", 0);
	namespace_6aaccc24::function_da693cbe("reviveProgress", 1, 5, "float", 0);
}

/*
	Name: open
	Namespace: namespace_3cdd43e2
	Checksum: 0x368CC272
	Offset: 0x320
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "mp_revive_prompt", persistent);
}

/*
	Name: close
	Namespace: namespace_3cdd43e2
	Checksum: 0x5CE0A74B
	Offset: 0x370
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_3b7b386a
	Namespace: namespace_3cdd43e2
	Checksum: 0xD95B448D
	Offset: 0x3A0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_3b7b386a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "clientnum", value);
}

/*
	Name: set_health
	Namespace: namespace_3cdd43e2
	Checksum: 0x395535FF
	Offset: 0x3E8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function set_health(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "health", value);
}

/*
	Name: function_4b3fb8b8
	Namespace: namespace_3cdd43e2
	Checksum: 0x578D9F07
	Offset: 0x430
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_4b3fb8b8(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "reviveProgress", value);
}

/*
	Name: __destructor
	Namespace: namespace_3cdd43e2
	Checksum: 0xA1D0CDD3
	Offset: 0x478
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace mp_revive_prompt;

/*
	Name: function_3cdd43e2
	Namespace: mp_revive_prompt
	Checksum: 0x923680B2
	Offset: 0x498
	Size: 0x356
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_3cdd43e2()
{
	classes.var_3cdd43e2[0] = spawnstruct();
	classes.var_3cdd43e2[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_3cdd43e2[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_3cdd43e2[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_3cdd43e2[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_3cdd43e2[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_3cdd43e2[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_3cdd43e2[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_3cdd43e2[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_3cdd43e2[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_3cdd43e2[0].__vtable[913321084] = &namespace_3cdd43e2::__destructor;
	classes.var_3cdd43e2[0].__vtable[1262467256] = &namespace_3cdd43e2::function_4b3fb8b8;
	classes.var_3cdd43e2[0].__vtable[181372725] = &namespace_3cdd43e2::set_health;
	classes.var_3cdd43e2[0].__vtable[997931114] = &namespace_3cdd43e2::function_3b7b386a;
	classes.var_3cdd43e2[0].__vtable[1516492343] = &namespace_3cdd43e2::close;
	classes.var_3cdd43e2[0].__vtable[250899321] = &namespace_3cdd43e2::open;
	classes.var_3cdd43e2[0].__vtable[1855416484] = &namespace_3cdd43e2::setup_clientfields;
	classes.var_3cdd43e2[0].__vtable[674154906] = &namespace_3cdd43e2::__constructor;
}

