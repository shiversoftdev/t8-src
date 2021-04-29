// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace multi_stage_friendly_lockon;

/*
	Name: register
	Namespace: multi_stage_friendly_lockon
	Checksum: 0xFC82B5A
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_2347be59();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: multi_stage_friendly_lockon
	Checksum: 0x1066BC3D
	Offset: 0x128
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
	Namespace: multi_stage_friendly_lockon
	Checksum: 0xD008E743
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
	Namespace: multi_stage_friendly_lockon
	Checksum: 0xEA2C7EA3
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_c8350e33
	Namespace: multi_stage_friendly_lockon
	Checksum: 0xA06364F2
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c8350e33(player, value)
{
	[[ self ]]->function_c8350e33(player, value);
}

/*
	Name: function_f1e8a488
	Namespace: multi_stage_friendly_lockon
	Checksum: 0x9BDB8BAD
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_f1e8a488(player, value)
{
	[[ self ]]->function_f1e8a488(player, value);
}

#namespace namespace_2347be59;

/*
	Name: __constructor
	Namespace: namespace_2347be59
	Checksum: 0xF76C25B6
	Offset: 0x218
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
	Namespace: namespace_2347be59
	Checksum: 0x6EF53E34
	Offset: 0x238
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("entNum", 1, 10, "int");
	namespace_6aaccc24::function_da693cbe("targetState", 1, 3, "int");
}

/*
	Name: open
	Namespace: namespace_2347be59
	Checksum: 0xC1E1978E
	Offset: 0x2B8
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "multi_stage_friendly_lockon", persistent);
}

/*
	Name: close
	Namespace: namespace_2347be59
	Checksum: 0x90A4B56E
	Offset: 0x308
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_c8350e33
	Namespace: namespace_2347be59
	Checksum: 0xDA6B036
	Offset: 0x338
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_c8350e33(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "entNum", value);
}

/*
	Name: function_f1e8a488
	Namespace: namespace_2347be59
	Checksum: 0xDC029789
	Offset: 0x380
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_f1e8a488(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "targetState", value);
}

/*
	Name: __destructor
	Namespace: namespace_2347be59
	Checksum: 0xA199B85D
	Offset: 0x3C8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace multi_stage_friendly_lockon;

/*
	Name: function_2347be59
	Namespace: multi_stage_friendly_lockon
	Checksum: 0xB987075C
	Offset: 0x3E8
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_2347be59()
{
	classes.var_2347be59[0] = spawnstruct();
	classes.var_2347be59[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_2347be59[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_2347be59[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_2347be59[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_2347be59[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_2347be59[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_2347be59[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_2347be59[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_2347be59[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_2347be59[0].__vtable[913321084] = &namespace_2347be59::__destructor;
	classes.var_2347be59[0].__vtable[236411768] = &namespace_2347be59::function_f1e8a488;
	classes.var_2347be59[0].__vtable[936047053] = &namespace_2347be59::function_c8350e33;
	classes.var_2347be59[0].__vtable[1516492343] = &namespace_2347be59::close;
	classes.var_2347be59[0].__vtable[250899321] = &namespace_2347be59::open;
	classes.var_2347be59[0].__vtable[1855416484] = &namespace_2347be59::setup_clientfields;
	classes.var_2347be59[0].__vtable[674154906] = &namespace_2347be59::__constructor;
}

