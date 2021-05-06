// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace spectrerisingindicator;

/*
	Name: register
	Namespace: spectrerisingindicator
	Checksum: 0xB86BBF16
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	object = new var_b7f44132();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: spectrerisingindicator
	Checksum: 0x4C7439EB
	Offset: 0x120
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
	Namespace: spectrerisingindicator
	Checksum: 0xD19B3746
	Offset: 0x160
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
	Namespace: spectrerisingindicator
	Checksum: 0x1A0B48DB
	Offset: 0x188
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_3b7b386a
	Namespace: spectrerisingindicator
	Checksum: 0xF82BBD76
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	[[ self ]]->function_3b7b386a(player, value);
}

/*
	Name: function_7f5a9fed
	Namespace: spectrerisingindicator
	Checksum: 0x9A235B41
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function function_7f5a9fed(player, value)
{
	[[ self ]]->function_7f5a9fed(player, value);
}

#namespace namespace_b7f44132;

/*
	Name: __constructor
	Namespace: namespace_b7f44132
	Checksum: 0xF992259F
	Offset: 0x210
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
	Namespace: namespace_b7f44132
	Checksum: 0x1B16609F
	Offset: 0x230
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("clientnum", 1, 7, "int");
	namespace_6aaccc24::function_da693cbe("isAlive", 1, 1, "int");
}

/*
	Name: open
	Namespace: namespace_b7f44132
	Checksum: 0x53F7AD35
	Offset: 0x2B0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "SpectreRisingIndicator", persistent);
}

/*
	Name: close
	Namespace: namespace_b7f44132
	Checksum: 0x9E112E61
	Offset: 0x300
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_3b7b386a
	Namespace: namespace_b7f44132
	Checksum: 0x1DD15873
	Offset: 0x330
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3b7b386a(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "clientnum", value);
}

/*
	Name: function_7f5a9fed
	Namespace: namespace_b7f44132
	Checksum: 0x1C0D9C0F
	Offset: 0x378
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_7f5a9fed(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "isAlive", value);
}

/*
	Name: __destructor
	Namespace: namespace_b7f44132
	Checksum: 0xE9A390EA
	Offset: 0x3C0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace spectrerisingindicator;

/*
	Name: function_b7f44132
	Namespace: spectrerisingindicator
	Checksum: 0xFE7A4AED
	Offset: 0x3E0
	Size: 0x326
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_b7f44132()
{
	classes.var_b7f44132[0] = spawnstruct();
	classes.var_b7f44132[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_b7f44132[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_b7f44132[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_b7f44132[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_b7f44132[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_b7f44132[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_b7f44132[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_b7f44132[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_b7f44132[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_b7f44132[0].__vtable[913321084] = &namespace_b7f44132::__destructor;
	classes.var_b7f44132[0].__vtable[2136645613] = &namespace_b7f44132::function_7f5a9fed;
	classes.var_b7f44132[0].__vtable[997931114] = &namespace_b7f44132::function_3b7b386a;
	classes.var_b7f44132[0].__vtable[1516492343] = &namespace_b7f44132::close;
	classes.var_b7f44132[0].__vtable[250899321] = &namespace_b7f44132::open;
	classes.var_b7f44132[0].__vtable[1855416484] = &namespace_b7f44132::setup_clientfields;
	classes.var_b7f44132[0].__vtable[674154906] = &namespace_b7f44132::__constructor;
}

