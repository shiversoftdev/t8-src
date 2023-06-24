// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class cct_shared_warning : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cct_shared_warning
		Checksum: 0x1E73E7AE
		Offset: 0x210
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_warning
		Checksum: 0x795C67D6
		Offset: 0x600
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_objpoints
		Namespace: cct_shared_warning
		Checksum: 0x1B30B476
		Offset: 0x5B8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_objpoints(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "objpoints", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_warning
		Checksum: 0x3D7C9C39
		Offset: 0x330
		Size: 0x27C
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
			if(#"warnheal_fadeout" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				if(#"hash_5e59fb81ffd2fd6b" == state_name)
				{
					player clientfield::function_9bf78ef8(var_47e79fc, "_state", 2);
				}
				else
				{
					if(#"hash_4d78e6d4caf789ce" == state_name)
					{
						player clientfield::function_9bf78ef8(var_47e79fc, "_state", 3);
					}
					else
					{
						if(#"warnheal" == state_name)
						{
							player clientfield::function_9bf78ef8(var_47e79fc, "_state", 4);
						}
						else
						{
							if(#"warnheal_cycle1" == state_name)
							{
								player clientfield::function_9bf78ef8(var_47e79fc, "_state", 5);
							}
							else
							{
								if(#"warnheal_cycle2" == state_name)
								{
									player clientfield::function_9bf78ef8(var_47e79fc, "_state", 6);
								}
								else
								{
									if(#"hash_5ae2f5a909a5efa9" == state_name)
									{
										player clientfield::function_9bf78ef8(var_47e79fc, "_state", 7);
									}
									else
									{
										if(#"hash_5ae2f2a909a5ea90" == state_name)
										{
											player clientfield::function_9bf78ef8(var_47e79fc, "_state", 8);
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
		}
	}

	/*
		Name: close
		Namespace: cct_shared_warning
		Checksum: 0xE1166FEF
		Offset: 0x300
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
		Namespace: cct_shared_warning
		Checksum: 0x1F41C5D5
		Offset: 0x2B0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "ct_shared_warning", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cct_shared_warning
		Checksum: 0xD81D1597
		Offset: 0x230
		Size: 0x74
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 4, "int");
		cLUIelem::function_da693cbe("objpoints", 1, 11, "int");
	}

}

#namespace ct_shared_warning;

/*
	Name: register
	Namespace: ct_shared_warning
	Checksum: 0x286440CE
	Offset: 0xD8
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_shared_warning();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_warning
	Checksum: 0xD80B734E
	Offset: 0x120
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
	Namespace: ct_shared_warning
	Checksum: 0xFC080168
	Offset: 0x160
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
	Namespace: ct_shared_warning
	Checksum: 0x8BD26E7F
	Offset: 0x188
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
	Namespace: ct_shared_warning
	Checksum: 0x3B095EBB
	Offset: 0x1B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_objpoints
	Namespace: ct_shared_warning
	Checksum: 0x9892ACD0
	Offset: 0x1E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_objpoints(player, value)
{
	[[ self ]]->set_objpoints(player, value);
}

