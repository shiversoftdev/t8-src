// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class cct_shared_aar_medals : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: cct_shared_aar_medals
		Checksum: 0x2D9A871B
		Offset: 0x2B0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cct_shared_aar_medals
		Checksum: 0xBEC018D
		Offset: 0x680
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_medalbronzethreshold
		Namespace: cct_shared_aar_medals
		Checksum: 0x4E966A6D
		Offset: 0x638
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_medalbronzethreshold(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "medalBronzeThreshold", value);
	}

	/*
		Name: set_medalsilverthreshold
		Namespace: cct_shared_aar_medals
		Checksum: 0x28684AB2
		Offset: 0x5F0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_medalsilverthreshold(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "medalSilverThreshold", value);
	}

	/*
		Name: set_medalgoldthreshold
		Namespace: cct_shared_aar_medals
		Checksum: 0x1ACE2C05
		Offset: 0x5A8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_medalgoldthreshold(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "medalGoldThreshold", value);
	}

	/*
		Name: set_state
		Namespace: cct_shared_aar_medals
		Checksum: 0xF05766B1
		Offset: 0x420
		Size: 0x17C
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
			if(#"medal_gold" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				if(#"medal_silver" == state_name)
				{
					player clientfield::function_9bf78ef8(var_47e79fc, "_state", 2);
				}
				else
				{
					if(#"medal_bronze" == state_name)
					{
						player clientfield::function_9bf78ef8(var_47e79fc, "_state", 3);
					}
					else
					{
						if(#"medal_none" == state_name)
						{
							player clientfield::function_9bf78ef8(var_47e79fc, "_state", 4);
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

	/*
		Name: close
		Namespace: cct_shared_aar_medals
		Checksum: 0xEA417C6F
		Offset: 0x3F0
		Size: 0x24
		Parameters: 1
		Flags: None
	*/
	function close(player)
	{
		cluielem::close_luielem(player);
	}

	/*
		Name: open
		Namespace: cct_shared_aar_medals
		Checksum: 0x3BB2C160
		Offset: 0x3A0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "ct_shared_aar_medals", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: cct_shared_aar_medals
		Checksum: 0x31DA638E
		Offset: 0x2D0
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 3, "int");
		cluielem::function_dcb34c80("string", "medalGoldThreshold", 1);
		cluielem::function_dcb34c80("string", "medalSilverThreshold", 1);
		cluielem::function_dcb34c80("string", "medalBronzeThreshold", 1);
	}

}

#namespace ct_shared_aar_medals;

/*
	Name: register
	Namespace: ct_shared_aar_medals
	Checksum: 0xA6B936EE
	Offset: 0x118
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new cct_shared_aar_medals();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: ct_shared_aar_medals
	Checksum: 0x584C0FA4
	Offset: 0x160
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
	Namespace: ct_shared_aar_medals
	Checksum: 0x61B576B3
	Offset: 0x1A0
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
	Namespace: ct_shared_aar_medals
	Checksum: 0xAD3BB3A
	Offset: 0x1C8
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
	Namespace: ct_shared_aar_medals
	Checksum: 0x37D761FE
	Offset: 0x1F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_medalgoldthreshold
	Namespace: ct_shared_aar_medals
	Checksum: 0x63952835
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_medalgoldthreshold(player, value)
{
	[[ self ]]->set_medalgoldthreshold(player, value);
}

/*
	Name: set_medalsilverthreshold
	Namespace: ct_shared_aar_medals
	Checksum: 0x90BC229E
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_medalsilverthreshold(player, value)
{
	[[ self ]]->set_medalsilverthreshold(player, value);
}

/*
	Name: set_medalbronzethreshold
	Namespace: ct_shared_aar_medals
	Checksum: 0x595B977E
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_medalbronzethreshold(player, value)
{
	[[ self ]]->set_medalbronzethreshold(player, value);
}

