// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_tut_hint_text : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_tut_hint_text
		Checksum: 0xB598B50D
		Offset: 0x238
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_tut_hint_text
		Checksum: 0xECA5F4E4
		Offset: 0x4B0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_text
		Namespace: czm_tut_hint_text
		Checksum: 0x1A05BCB
		Offset: 0x478
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_text(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "text", value);
	}

	/*
		Name: set_state
		Namespace: czm_tut_hint_text
		Checksum: 0xDBF84F73
		Offset: 0x3C0
		Size: 0xAC
		Parameters: 2
		Flags: None
	*/
	function set_state(localclientnum, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			[[ self ]]->set_data(localclientnum, "_state", 0);
		}
		else
		{
			if(#"visible" == state_name)
			{
				[[ self ]]->set_data(localclientnum, "_state", 1);
			}
			else
			{
				/#
					assertmsg("");
				#/
				/#
				#/
			}
		}
	}

	/*
		Name: open
		Namespace: czm_tut_hint_text
		Checksum: 0x2A57E68F
		Offset: 0x388
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_tut_hint_text");
	}

	/*
		Name: function_fa582112
		Namespace: czm_tut_hint_text
		Checksum: 0x655A5C6F
		Offset: 0x310
		Size: 0x6C
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_state(localclientnum, #"defaultstate");
		[[ self ]]->set_data(localclientnum, "text", #"");
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_tut_hint_text
		Checksum: 0xBB97785A
		Offset: 0x2E0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_tut_hint_text
		Checksum: 0x47FA5E35
		Offset: 0x258
		Size: 0x7C
		Parameters: 2
		Flags: None
	*/
	function setup_clientfields(uid, var_f5852d69)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_dcb34c80("string", "text", 1);
	}

}

#namespace zm_tut_hint_text;

/*
	Name: register
	Namespace: zm_tut_hint_text
	Checksum: 0x273F94FA
	Offset: 0xC0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_f5852d69)
{
	elem = new czm_tut_hint_text();
	[[ elem ]]->setup_clientfields(uid, var_f5852d69);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_tut_hint_text
	Checksum: 0x241FE201
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_tut_hint_text();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_tut_hint_text
	Checksum: 0x849F970A
	Offset: 0x160
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
	Namespace: zm_tut_hint_text
	Checksum: 0xC2A5A3F4
	Offset: 0x188
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
	Checksum: 0x17B35EC0
	Offset: 0x1B0
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
	Namespace: zm_tut_hint_text
	Checksum: 0x7A56BD73
	Offset: 0x1D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(localclientnum, state_name)
{
	[[ self ]]->set_state(localclientnum, state_name);
}

/*
	Name: set_text
	Namespace: zm_tut_hint_text
	Checksum: 0x285228DD
	Offset: 0x208
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_text(localclientnum, value)
{
	[[ self ]]->set_text(localclientnum, value);
}

