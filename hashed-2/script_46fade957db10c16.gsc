// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cmulti_stage_target_lockon : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x3FC03C28
		Offset: 0x218
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xD21E4499
		Offset: 0x3C8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_targetState
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x4866878C
		Offset: 0x380
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_targetState(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "targetState", value);
	}

	/*
		Name: set_entNum
		Namespace: cmulti_stage_target_lockon
		Checksum: 0x2BA01BA
		Offset: 0x338
		Size: 0x3C
		Parameters: 2
		Flags: Linked
	*/
	function set_entNum(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "entNum", value);
	}

	/*
		Name: close
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xA9385B01
		Offset: 0x308
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function close(player)
	{
		cLUIelem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xA4592743
		Offset: 0x2B8
		Size: 0x44
		Parameters: 2
		Flags: Linked
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "multi_stage_target_lockon", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cmulti_stage_target_lockon
		Checksum: 0xF53B3506
		Offset: 0x238
		Size: 0x74
		Parameters: 1
		Flags: Linked
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("entNum", 1, 6, "int");
		cLUIelem::function_da693cbe("targetState", 1, 3, "int");
	}

}

#namespace multi_stage_target_lockon;

/*
	Name: register
	Namespace: multi_stage_target_lockon
	Checksum: 0xAB55F47D
	Offset: 0xE0
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function register(uid)
{
	elem = new cmulti_stage_target_lockon();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: multi_stage_target_lockon
	Checksum: 0x9614F25
	Offset: 0x128
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
	Namespace: multi_stage_target_lockon
	Checksum: 0xB4A25293
	Offset: 0x168
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
	Namespace: multi_stage_target_lockon
	Checksum: 0x981C3CDB
	Offset: 0x190
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: set_entNum
	Namespace: multi_stage_target_lockon
	Checksum: 0xB1A39DE0
	Offset: 0x1B8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_entNum(player, value)
{
	[[ self ]]->set_entNum(player, value);
}

/*
	Name: set_targetState
	Namespace: multi_stage_target_lockon
	Checksum: 0xDA55D0C1
	Offset: 0x1E8
	Size: 0x28
	Parameters: 2
	Flags: Linked
*/
function set_targetState(player, value)
{
	[[ self ]]->set_targetState(player, value);
}

