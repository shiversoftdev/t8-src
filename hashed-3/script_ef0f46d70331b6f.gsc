// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class cct_crash_kill_remaining_enemy : cLUIelem
{

	/*
		Name: constructor
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0x22DA52FC
		Offset: 0x1A8
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0x4C2CBBFD
		Offset: 0x290
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: open
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0x886A6BEC
		Offset: 0x258
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"ct_crash_kill_remaining_enemy");
	}

	/*
		Name: function_fa582112
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0xF4B4344A
		Offset: 0x228
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
	}

	/*
		Name: function_5c1bb138
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0x399EE642
		Offset: 0x1F8
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
		Namespace: cct_crash_kill_remaining_enemy
		Checksum: 0xECEFDB36
		Offset: 0x1C8
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
	}

}

#namespace ct_crash_kill_remaining_enemy;

/*
	Name: register
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0xE2AC7855
	Offset: 0xA0
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_crash_kill_remaining_enemy();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x2090F0D4
	Offset: 0xE8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new cct_crash_kill_remaining_enemy();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x48A7E7CD
	Offset: 0x130
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
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x468CCC13
	Offset: 0x158
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
	Namespace: ct_crash_kill_remaining_enemy
	Checksum: 0x1ECA2EF1
	Offset: 0x180
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

