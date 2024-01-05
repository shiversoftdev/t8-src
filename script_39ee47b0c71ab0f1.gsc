// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_trial_weapon_locked : cluielem
{

	/*
		Name: constructor
		Namespace: czm_trial_weapon_locked
		Checksum: 0xB462A51B
		Offset: 0x1F0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_trial_weapon_locked
		Checksum: 0x42851BF2
		Offset: 0x398
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: function_1e74977
		Namespace: czm_trial_weapon_locked
		Checksum: 0x526A0CD
		Offset: 0x320
		Size: 0x6C
		Parameters: 1
		Flags: Linked
	*/
	function function_1e74977(localclientnum)
	{
		current_val = [[ self ]]->get_data(localclientnum, "show_icon");
		new_val = (current_val + 1) % 2;
		[[ self ]]->set_data(localclientnum, "show_icon", new_val);
	}

	/*
		Name: open
		Namespace: czm_trial_weapon_locked
		Checksum: 0x1B4521DF
		Offset: 0x2E8
		Size: 0x2C
		Parameters: 1
		Flags: Linked
	*/
	function open(localclientnum)
	{
		cluielem::open(localclientnum, #"zm_trial_weapon_locked");
	}

	/*
		Name: function_fa582112
		Namespace: czm_trial_weapon_locked
		Checksum: 0x70E2304
		Offset: 0x2A0
		Size: 0x40
		Parameters: 1
		Flags: Linked
	*/
	function function_fa582112(localclientnum)
	{
		cluielem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "show_icon", 0);
	}

	/*
		Name: register_clientside
		Namespace: czm_trial_weapon_locked
		Checksum: 0xBE497453
		Offset: 0x270
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function register_clientside(uid)
	{
		cluielem::register_clientside(uid);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_trial_weapon_locked
		Checksum: 0x56AE2337
		Offset: 0x210
		Size: 0x54
		Parameters: 2
		Flags: Linked
	*/
	function setup_clientfields(uid, var_18c795d0)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("show_icon", 1, 1, "counter", var_18c795d0);
	}

}

#namespace zm_trial_weapon_locked;

/*
	Name: register
	Namespace: zm_trial_weapon_locked
	Checksum: 0xAB62E2F1
	Offset: 0xB0
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function register(uid, var_18c795d0)
{
	elem = new czm_trial_weapon_locked();
	[[ elem ]]->setup_clientfields(uid, var_18c795d0);
	return elem;
}

/*
	Name: register_clientside
	Namespace: zm_trial_weapon_locked
	Checksum: 0x96BECB73
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register_clientside(uid)
{
	elem = new czm_trial_weapon_locked();
	[[ elem ]]->register_clientside(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_trial_weapon_locked
	Checksum: 0x68A9790A
	Offset: 0x150
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: zm_trial_weapon_locked
	Checksum: 0xC911088B
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
	Namespace: zm_trial_weapon_locked
	Checksum: 0xE0B7306D
	Offset: 0x1A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_1e74977
	Namespace: zm_trial_weapon_locked
	Checksum: 0x8DA03CCC
	Offset: 0x1C8
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_1e74977(localclientnum)
{
	[[ self ]]->function_1e74977(localclientnum);
}

