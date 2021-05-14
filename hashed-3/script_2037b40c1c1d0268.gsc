// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace ct_progressbar_status;

/*
	Name: register
	Namespace: ct_progressbar_status
	Checksum: 0x1C734833
	Offset: 0xB0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_ec15ff6a();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_progressbar_status
	Checksum: 0x32E56F9F
	Offset: 0xF8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_ec15ff6a();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_progressbar_status
	Checksum: 0x8DA41DDF
	Offset: 0x140
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: ct_progressbar_status
	Checksum: 0x5613BD9E
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
	Namespace: ct_progressbar_status
	Checksum: 0x624474F8
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_state
	Namespace: ct_progressbar_status
	Checksum: 0xF2E3859
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

#namespace namespace_ec15ff6a;

/*
	Name: __constructor
	Namespace: namespace_ec15ff6a
	Checksum: 0x1E2FA6C8
	Offset: 0x1E8
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
	Namespace: namespace_ec15ff6a
	Checksum: 0xDD12400F
	Offset: 0x208
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("_state", 1, 4, "int");
}

/*
	Name: function_5c1bb138
	Namespace: namespace_ec15ff6a
	Checksum: 0x6A955C2E
	Offset: 0x260
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_ec15ff6a
	Checksum: 0xFC38863A
	Offset: 0x290
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->set_state(localclientnum, #"defaultstate");
}

/*
	Name: open
	Namespace: namespace_ec15ff6a
	Checksum: 0xC4F2C1E1
	Offset: 0x2E0
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"ct_progressbar_status");
}

/*
	Name: set_state
	Namespace: namespace_ec15ff6a
	Checksum: 0x418B5AD4
	Offset: 0x318
	Size: 0x2A4
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	if(#"defaultstate" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 0);
	}
	else if(#"download_complete" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 1);
	}
	else if(#"hash_4082029e6e323467" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 2);
	}
	else if(#"hash_4730cb5d57cb0f20" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 3);
	}
	else if(#"hash_4f1ec9353f4eee22" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 4);
	}
	else if(#"hash_42f8a09c2e0a99e3" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 5);
	}
	else if(#"hash_af852d7b85b0c03" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 6);
	}
	else if(#"hash_7f00f68e42b5b8f6" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 7);
	}
	else if(#"hash_a890619c656ded5" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 8);
	}
	else if(#"hash_3db441cc059cbd6c" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 9);
	}
	else if(#"hash_7185fe2194047325" == state_name)
	{
		[[ self ]]->function_d7d2fcce(localclientnum, "_state", 10);
	}
	assertmsg("");
}

/*
	Name: __destructor
	Namespace: namespace_ec15ff6a
	Checksum: 0xED15F7F8
	Offset: 0x5C8
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace ct_progressbar_status;

/*
	Name: function_ec15ff6a
	Namespace: ct_progressbar_status
	Checksum: 0x9459A0E7
	Offset: 0x5E8
	Size: 0x386
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_ec15ff6a()
{
	classes.var_ec15ff6a[0] = spawnstruct();
	classes.var_ec15ff6a[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_ec15ff6a[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_ec15ff6a[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_ec15ff6a[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_ec15ff6a[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_ec15ff6a[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_ec15ff6a[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
	classes.var_ec15ff6a[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_ec15ff6a[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_ec15ff6a[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_ec15ff6a[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_ec15ff6a[0].__vtable[913321084] = &namespace_ec15ff6a::__destructor;
	classes.var_ec15ff6a[0].__vtable[655560998] = &namespace_ec15ff6a::set_state;
	classes.var_ec15ff6a[0].__vtable[250899321] = &namespace_ec15ff6a::open;
	classes.var_ec15ff6a[0].__vtable[94887662] = &namespace_ec15ff6a::function_fa582112;
	classes.var_ec15ff6a[0].__vtable[1545318712] = &namespace_ec15ff6a::function_5c1bb138;
	classes.var_ec15ff6a[0].__vtable[1855416484] = &namespace_ec15ff6a::setup_clientfields;
	classes.var_ec15ff6a[0].__vtable[674154906] = &namespace_ec15ff6a::__constructor;
}

