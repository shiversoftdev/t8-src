// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace ct_shared_aar_medals;

/*
	Name: register
	Namespace: ct_shared_aar_medals
	Checksum: 0xA6B936EE
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_6b4dd8d9();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_aar_medals
	Checksum: 0x584C0FA4
	Offset: 0x160
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
	Namespace: ct_shared_aar_medals
	Checksum: 0x61B576B3
	Offset: 0x1A0
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
	Namespace: ct_shared_aar_medals
	Checksum: 0xAD3BB3A
	Offset: 0x1C8
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
	Namespace: ct_shared_aar_medals
	Checksum: 0x37D761FE
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: function_58ed8be2
	Namespace: ct_shared_aar_medals
	Checksum: 0x63952835
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_58ed8be2(player, value)
{
	[[ self ]]->function_58ed8be2(player, value);
}

/*
	Name: function_1037d7e0
	Namespace: ct_shared_aar_medals
	Checksum: 0x90BC229E
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1037d7e0(player, value)
{
	[[ self ]]->function_1037d7e0(player, value);
}

/*
	Name: function_5f4404dc
	Namespace: ct_shared_aar_medals
	Checksum: 0x595B977E
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_5f4404dc(player, value)
{
	[[ self ]]->function_5f4404dc(player, value);
}

#namespace namespace_6b4dd8d9;

/*
	Name: __constructor
	Namespace: namespace_6b4dd8d9
	Checksum: 0x2D9A871B
	Offset: 0x2B0
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
	Namespace: namespace_6b4dd8d9
	Checksum: 0x31DA638E
	Offset: 0x2D0
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 3, "int");
	namespace_6aaccc24::function_dcb34c80("string", "medalGoldThreshold", 1);
	namespace_6aaccc24::function_dcb34c80("string", "medalSilverThreshold", 1);
	namespace_6aaccc24::function_dcb34c80("string", "medalBronzeThreshold", 1);
}

/*
	Name: open
	Namespace: namespace_6b4dd8d9
	Checksum: 0x3BB2C160
	Offset: 0x3A0
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "ct_shared_aar_medals", persistent);
}

/*
	Name: close
	Namespace: namespace_6b4dd8d9
	Checksum: 0xEA417C6F
	Offset: 0x3F0
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
	Namespace: namespace_6b4dd8d9
	Checksum: 0xF05766B1
	Offset: 0x420
	Size: 0x17C
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	if(#"defaultstate" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 0);
	}
	else if(#"hash_6888d33e85daf77" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 1);
	}
	else if(#"hash_2a6082609998ad9c" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 2);
	}
	else if(#"hash_6a156fe8b5495e2d" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 3);
	}
	else if(#"hash_7eee9bfd6e19148f" == state_name)
	{
		player clientfield::function_9bf78ef8(self.var_47e79fc, "_state", 4);
	}
	assertmsg("");
}

/*
	Name: function_58ed8be2
	Namespace: namespace_6b4dd8d9
	Checksum: 0x1ACE2C05
	Offset: 0x5A8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_58ed8be2(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "medalGoldThreshold", value);
}

/*
	Name: function_1037d7e0
	Namespace: namespace_6b4dd8d9
	Checksum: 0x28684AB2
	Offset: 0x5F0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_1037d7e0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "medalSilverThreshold", value);
}

/*
	Name: function_5f4404dc
	Namespace: namespace_6b4dd8d9
	Checksum: 0x4E966A6D
	Offset: 0x638
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_5f4404dc(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "medalBronzeThreshold", value);
}

/*
	Name: __destructor
	Namespace: namespace_6b4dd8d9
	Checksum: 0xBEC018D
	Offset: 0x680
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_shared_aar_medals;

/*
	Name: function_6b4dd8d9
	Namespace: ct_shared_aar_medals
	Checksum: 0x3F0E1E5B
	Offset: 0x6A0
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_6b4dd8d9()
{
	classes.var_6b4dd8d9[0] = spawnstruct();
	classes.var_6b4dd8d9[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_6b4dd8d9[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_6b4dd8d9[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_6b4dd8d9[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_6b4dd8d9[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_6b4dd8d9[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_6b4dd8d9[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_6b4dd8d9[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_6b4dd8d9[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_6b4dd8d9[0].__vtable[913321084] = &namespace_6b4dd8d9::__destructor;
	classes.var_6b4dd8d9[0].__vtable[1598293212] = &namespace_6b4dd8d9::function_5f4404dc;
	classes.var_6b4dd8d9[0].__vtable[272095200] = &namespace_6b4dd8d9::function_1037d7e0;
	classes.var_6b4dd8d9[0].__vtable[1491962850] = &namespace_6b4dd8d9::function_58ed8be2;
	classes.var_6b4dd8d9[0].__vtable[655560998] = &namespace_6b4dd8d9::set_state;
	classes.var_6b4dd8d9[0].__vtable[1516492343] = &namespace_6b4dd8d9::close;
	classes.var_6b4dd8d9[0].__vtable[250899321] = &namespace_6b4dd8d9::open;
	classes.var_6b4dd8d9[0].__vtable[1855416484] = &namespace_6b4dd8d9::setup_clientfields;
	classes.var_6b4dd8d9[0].__vtable[674154906] = &namespace_6b4dd8d9::__constructor;
}

