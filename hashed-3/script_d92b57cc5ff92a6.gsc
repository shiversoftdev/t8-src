// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cct_shared_objcounter : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cct_shared_objcounter
		Checksum: 0xA11B57CF
		Offset: 0x2A0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_objcounter
		Checksum: 0x32C0D918
		Offset: 0x6F0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_objectiveTotal
		Namespace: cct_shared_objcounter
		Checksum: 0xD858D50B
		Offset: 0x6A8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objectiveTotal(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objectiveTotal", value);
	}

	/*
		Name: set_objectiveLabel
		Namespace: cct_shared_objcounter
		Checksum: 0xC46DCDF1
		Offset: 0x660
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objectiveLabel(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objectiveLabel", value);
	}

	/*
		Name: set_objectiveCount
		Namespace: cct_shared_objcounter
		Checksum: 0x7B7A794C
		Offset: 0x618
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objectiveCount(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objectiveCount", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_objcounter
		Checksum: 0x3931B69E
		Offset: 0x410
		Size: 0x1FC
		Parameters: 2
		Flags: None
	*/
	function set_state(player, state_name)
	{
		if(#"defaultstate" == state_name)
		{
			player clientfield::function_9bf78ef8(var_47e79fc, "_state", 0);
		}
		else
		{
			if(#"nototal" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				if(#"hash_1895dd9cec027130" == state_name)
				{
					player clientfield::function_9bf78ef8(var_47e79fc, "_state", 2);
				}
				else
				{
					if(#"total" == state_name)
					{
						player clientfield::function_9bf78ef8(var_47e79fc, "_state", 3);
					}
					else
					{
						if(#"total_update" == state_name)
						{
							player clientfield::function_9bf78ef8(var_47e79fc, "_state", 4);
						}
						else
						{
							if(#"hash_5edcadf19882d66f" == state_name)
							{
								player clientfield::function_9bf78ef8(var_47e79fc, "_state", 5);
							}
							else
							{
								if(#"total_init" == state_name)
								{
									player clientfield::function_9bf78ef8(var_47e79fc, "_state", 6);
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
					}
				}
			}
		}
	}

	/*
		Name: close
		Namespace: cct_shared_objcounter
		Checksum: 0x369BA90F
		Offset: 0x3E0
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
		Namespace: cct_shared_objcounter
		Checksum: 0xF84F6916
		Offset: 0x390
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "ct_shared_objcounter", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cct_shared_objcounter
		Checksum: 0x5CFF223D
		Offset: 0x2C0
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 3, "int");
		cLUIelem::function_da693cbe("objectiveCount", 1, 5, "int");
		cLUIelem::function_dcb34c80("string", "objectiveLabel", 1);
		cLUIelem::function_da693cbe("objectiveTotal", 1, 5, "int");
	}

}

#namespace ct_shared_objcounter;

/*
	Name: register
	Namespace: ct_shared_objcounter
	Checksum: 0x1AC64B9F
	Offset: 0x108
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_shared_objcounter();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_objcounter
	Checksum: 0x4EFA6376
	Offset: 0x150
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
	Namespace: ct_shared_objcounter
	Checksum: 0xC5D0FD9E
	Offset: 0x190
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
	Namespace: ct_shared_objcounter
	Checksum: 0x7083BC09
	Offset: 0x1B8
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
	Namespace: ct_shared_objcounter
	Checksum: 0x8DB3B6E6
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_objectiveCount
	Namespace: ct_shared_objcounter
	Checksum: 0xD36D4652
	Offset: 0x210
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveCount(player, value)
{
	[[ self ]]->set_objectiveCount(player, value);
}

/*
	Name: set_objectiveLabel
	Namespace: ct_shared_objcounter
	Checksum: 0x3A83F056
	Offset: 0x240
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveLabel(player, value)
{
	[[ self ]]->set_objectiveLabel(player, value);
}

/*
	Name: set_objectiveTotal
	Namespace: ct_shared_objcounter
	Checksum: 0x6F552D5C
	Offset: 0x270
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objectiveTotal(player, value)
{
	[[ self ]]->set_objectiveTotal(player, value);
}

