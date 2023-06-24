// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

class czm_zod_wonderweapon_quest : cLUIelem
{

	/*
		Name: constructor
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x5060E464
		Offset: 0x2C0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x69472C9C
		Offset: 0x5B8
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_decay
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x7D953140
		Offset: 0x580
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_decay(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "decay", value);
	}

	/*
		Name: set_purity
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x3D73EEA
		Offset: 0x548
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_purity(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "purity", value);
	}

	/*
		Name: set_plasma
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x1ABC56F0
		Offset: 0x510
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_plasma(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "plasma", value);
	}

	/*
		Name: set_radiance
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x642752F1
		Offset: 0x4D8
		Size: 0x30
		Parameters: 2
		Flags: None
	*/
	function set_radiance(localclientnum, value)
	{
		[[ self ]]->set_data(localclientnum, "radiance", value);
	}

	/*
		Name: open
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x87A220AE
		Offset: 0x4A0
		Size: 0x2C
		Parameters: 1
		Flags: None
	*/
	function open(localclientnum)
	{
		cLUIelem::open(localclientnum, #"zm_zod_wonderweapon_quest");
	}

	/*
		Name: function_fa582112
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x57114EA3
		Offset: 0x400
		Size: 0x94
		Parameters: 1
		Flags: None
	*/
	function function_fa582112(localclientnum)
	{
		cLUIelem::function_fa582112(localclientnum);
		[[ self ]]->set_data(localclientnum, "radiance", 0);
		[[ self ]]->set_data(localclientnum, "plasma", 0);
		[[ self ]]->set_data(localclientnum, "purity", 0);
		[[ self ]]->set_data(localclientnum, "decay", 0);
	}

	/*
		Name: function_5c1bb138
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x58321293
		Offset: 0x3D0
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
		Namespace: czm_zod_wonderweapon_quest
		Checksum: 0x198C67C4
		Offset: 0x2E0
		Size: 0xE4
		Parameters: 5
		Flags: None
	*/
	function setup_clientfields(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("radiance", 1, 1, "int", var_89b4773e);
		cLUIelem::function_da693cbe("plasma", 1, 1, "int", var_703a7074);
		cLUIelem::function_da693cbe("purity", 1, 1, "int", var_599a1ebc);
		cLUIelem::function_da693cbe("decay", 1, 1, "int", var_c47850b);
	}

}

#namespace zm_zod_wonderweapon_quest;

/*
	Name: register
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xFEDB0E50
	Offset: 0xC8
	Size: 0x70
	Parameters: 5
	Flags: None
*/
function register(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b)
{
	elem = new czm_zod_wonderweapon_quest();
	[[ elem ]]->setup_clientfields(uid, var_89b4773e, var_703a7074, var_599a1ebc, var_c47850b);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xC77E6931
	Offset: 0x140
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	elem = new czm_zod_wonderweapon_quest();
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xE2A2D486
	Offset: 0x188
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x68EEF353
	Offset: 0x1B0
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
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x28CD2CBC
	Offset: 0x1D8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: set_radiance
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xD6569038
	Offset: 0x200
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_radiance(localclientnum, value)
{
	[[ self ]]->set_radiance(localclientnum, value);
}

/*
	Name: set_plasma
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0xBE223F5B
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_plasma(localclientnum, value)
{
	[[ self ]]->set_plasma(localclientnum, value);
}

/*
	Name: set_purity
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x8A405C92
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_purity(localclientnum, value)
{
	[[ self ]]->set_purity(localclientnum, value);
}

/*
	Name: set_decay
	Namespace: zm_zod_wonderweapon_quest
	Checksum: 0x79B4923F
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_decay(localclientnum, value)
{
	[[ self ]]->set_decay(localclientnum, value);
}

