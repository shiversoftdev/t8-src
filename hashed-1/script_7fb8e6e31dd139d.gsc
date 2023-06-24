// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cmp_prop_controls : cLUIelem
{

	/*
		Name: constructor
		Namespace: cmp_prop_controls
		Checksum: 0xF50F004E
		Offset: 0x190
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cmp_prop_controls
		Checksum: 0xB028C754
		Offset: 0x260
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: close
		Namespace: cmp_prop_controls
		Checksum: 0xA516B94D
		Offset: 0x230
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cmp_prop_controls
		Checksum: 0x8561CBD3
		Offset: 0x1E0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "mp_prop_controls", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cmp_prop_controls
		Checksum: 0x614CC737
		Offset: 0x1B0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
	}

}

#namespace mp_prop_controls;

/*
	Name: register
	Namespace: mp_prop_controls
	Checksum: 0x6C8CD372
	Offset: 0xB8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cmp_prop_controls();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: mp_prop_controls
	Checksum: 0xD85FCBD3
	Offset: 0x100
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
	Namespace: mp_prop_controls
	Checksum: 0xE16A8476
	Offset: 0x140
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
	Namespace: mp_prop_controls
	Checksum: 0x9B8D57CD
	Offset: 0x168
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

