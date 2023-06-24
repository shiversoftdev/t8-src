// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cself_revive_visuals : cLUIelem
{

	/*
		Name: constructor
		Namespace: cself_revive_visuals
		Checksum: 0xD21DFA36
		Offset: 0x258
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cself_revive_visuals
		Checksum: 0x803C3979
		Offset: 0x458
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_revive_progress
		Namespace: cself_revive_visuals
		Checksum: 0x4BCA128
		Offset: 0x420
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_revive_progress(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "revive_progress", value);
	}

	/*
		Name: set_self_revive_progress_bar_fill
		Namespace: cself_revive_visuals
		Checksum: 0x3A66E582
		Offset: 0x3E8
		Size: 0x30
		Parameters: 2
		Flags: Linked
	*/
	function set_self_revive_progress_bar_fill(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "self_revive_progress_bar_fill", value);
	}

	/*
		Name: open
		Namespace: cself_revive_visuals
		Checksum: 0xED042215
		Offset: 0x3B0
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"self_revive_visuals");
	}

	/*
		Name: function_fa582112
		Namespace: cself_revive_visuals
		Checksum: 0xDBD7F457
		Offset: 0x338
		Size: 0x6C
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "self_revive_progress_bar_fill", 0);
		[[ self ]]->set_data(localclientnum, "revive_progress", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: cself_revive_visuals
		Checksum: 0x6C77A4AD
		Offset: 0x308
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5c1bb138(uid)
	{
		cLUIelem::function_5c1bb138(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: cself_revive_visuals
		Checksum: 0xDEBC5CE4
		Offset: 0x278
		Size: 0x84
		Parameters: 3
		Flags: Linked
	*/
	function setup_clientfields(uid, var_967a63df, var_e97e7153)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("self_revive_progress_bar_fill", 1, 5, "float", var_967a63df);
		cLUIelem::function_da693cbe("revive_progress", 1, 5, "float", var_e97e7153);
	}

}

#namespace self_revive_visuals;

/*
	Name: register
	Namespace: self_revive_visuals
	Checksum: 0x5F21748C
	Offset: 0xD8
	Size: 0x58
	Parameters: 3
	Flags: Linked
*/
function register(uid, var_967a63df, var_e97e7153)
{
	elem = new cself_revive_visuals();
	[[ elem ]]->setup_clientfields(uid, var_967a63df, var_e97e7153);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: self_revive_visuals
	Checksum: 0xB6DB94E9
	Offset: 0x138
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cself_revive_visuals();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: self_revive_visuals
	Checksum: 0x94D21A1F
	Offset: 0x180
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
	Namespace: self_revive_visuals
	Checksum: 0xF452D859
	Offset: 0x1A8
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
	Namespace: self_revive_visuals
	Checksum: 0x23D218AB
	Offset: 0x1D0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_self_revive_progress_bar_fill
	Namespace: self_revive_visuals
	Checksum: 0x1D4F4618
	Offset: 0x1F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_self_revive_progress_bar_fill(localclientnum, value)
{
	[[ self ]]->set_self_revive_progress_bar_fill(localclientnum, value);
}

/*
	Name: set_revive_progress
	Namespace: self_revive_visuals
	Checksum: 0x704BA2A5
	Offset: 0x228
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_revive_progress(localclientnum, value)
{
	[[ self ]]->set_revive_progress(localclientnum, value);
}

