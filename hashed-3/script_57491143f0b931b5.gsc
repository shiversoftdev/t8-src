// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace seeker_mine_prompt;

/*
	Name: register
	Namespace: seeker_mine_prompt
	Checksum: 0xC7C19110
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_8c34ca59();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: seeker_mine_prompt
	Checksum: 0xE65CB3FE
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
	Namespace: seeker_mine_prompt
	Checksum: 0x7879C02B
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
	Namespace: seeker_mine_prompt
	Checksum: 0x551F3E7E
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
	Name: function_affe8f61
	Namespace: seeker_mine_prompt
	Checksum: 0x22FB9802
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_affe8f61(player, value)
{
	[[ self ]]->function_affe8f61(player, value);
}

/*
	Name: function_c719cfea
	Namespace: seeker_mine_prompt
	Checksum: 0xC2A9EA5B
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_c719cfea(player, value)
{
	[[ self ]]->function_c719cfea(player, value);
}

#namespace namespace_8c34ca59;

/*
	Name: __constructor
	Namespace: namespace_8c34ca59
	Checksum: 0xACB74FC7
	Offset: 0x218
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
	Namespace: namespace_8c34ca59
	Checksum: 0x7AC5DC51
	Offset: 0x238
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("progress", 1, 5, "float");
	namespace_6aaccc24::function_da693cbe("promptState", 1, 2, "int");
}

/*
	Name: open
	Namespace: namespace_8c34ca59
	Checksum: 0x8A312C9C
	Offset: 0x2B8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "seeker_mine_prompt", persistent);
}

/*
	Name: close
	Namespace: namespace_8c34ca59
	Checksum: 0xD31BB692
	Offset: 0x308
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_affe8f61
	Namespace: namespace_8c34ca59
	Checksum: 0x4A765BAE
	Offset: 0x338
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_affe8f61(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "progress", value);
}

/*
	Name: function_c719cfea
	Namespace: namespace_8c34ca59
	Checksum: 0xB72D4E15
	Offset: 0x380
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_c719cfea(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "promptState", value);
}

/*
	Name: __destructor
	Namespace: namespace_8c34ca59
	Checksum: 0x746F1B1B
	Offset: 0x3C8
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace seeker_mine_prompt;

/*
	Name: function_8c34ca59
	Namespace: seeker_mine_prompt
	Checksum: 0xAFE75CBE
	Offset: 0x3E8
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8c34ca59()
{
	classes.var_8c34ca59[0] = spawnstruct();
	classes.var_8c34ca59[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_8c34ca59[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_8c34ca59[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_8c34ca59[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_8c34ca59[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_8c34ca59[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_8c34ca59[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_8c34ca59[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_8c34ca59[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_8c34ca59[0].__vtable[913321084] = &namespace_8c34ca59::__destructor;
	classes.var_8c34ca59[0].__vtable[954609686] = &namespace_8c34ca59::function_c719cfea;
	classes.var_8c34ca59[0].__vtable[1342271647] = &namespace_8c34ca59::function_affe8f61;
	classes.var_8c34ca59[0].__vtable[1516492343] = &namespace_8c34ca59::close;
	classes.var_8c34ca59[0].__vtable[250899321] = &namespace_8c34ca59::open;
	classes.var_8c34ca59[0].__vtable[1855416484] = &namespace_8c34ca59::setup_clientfields;
	classes.var_8c34ca59[0].__vtable[674154906] = &namespace_8c34ca59::__constructor;
}

