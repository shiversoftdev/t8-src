// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;

class czm_red_challenges_hud : cluielem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_red_challenges_hud
		Checksum: 0x924A4A5F
		Offset: 0x398
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_red_challenges_hud
		Checksum: 0x91B99D56
		Offset: 0x8E0
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_challengefailing
		Namespace: czm_red_challenges_hud
		Checksum: 0x868E354E
		Offset: 0x898
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_challengefailing(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "challengeFailing", value);
	}

	/*
		Name: set_rewardhidden
		Namespace: czm_red_challenges_hud
		Checksum: 0xBC9CE00
		Offset: 0x850
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_rewardhidden(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "rewardHidden", value);
	}

	/*
		Name: set_tributeavailable
		Namespace: czm_red_challenges_hud
		Checksum: 0x88B7C0A8
		Offset: 0x808
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_tributeavailable(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "tributeAvailable", value);
	}

	/*
		Name: increment_progress
		Namespace: czm_red_challenges_hud
		Checksum: 0x4BA442A0
		Offset: 0x7C8
		Size: 0x34
		Parameters: 1
		Flags: None
	*/
	function increment_progress(player)
	{
		player clientfield::function_bb878fc3(var_47e79fc, "progress");
	}

	/*
		Name: set_binlocation
		Namespace: czm_red_challenges_hud
		Checksum: 0xAA45B088
		Offset: 0x780
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_binlocation(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bInLocation", value);
	}

	/*
		Name: set_bottomtext
		Namespace: czm_red_challenges_hud
		Checksum: 0xA4E318FC
		Offset: 0x738
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_bottomtext(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "bottomText", value);
	}

	/*
		Name: set_challengetext
		Namespace: czm_red_challenges_hud
		Checksum: 0xA114966D
		Offset: 0x6F0
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_challengetext(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "challengeText", value);
	}

	/*
		Name: set_state
		Namespace: czm_red_challenges_hud
		Checksum: 0x2FCB7E1F
		Offset: 0x5A8
		Size: 0x13C
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
			if(#"visible" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
			}
			else
			{
				if(#"visiblepc" == state_name)
				{
					player clientfield::function_9bf78ef8(var_47e79fc, "_state", 2);
				}
				else
				{
					if(#"trials" == state_name)
					{
						player clientfield::function_9bf78ef8(var_47e79fc, "_state", 3);
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

	/*
		Name: close
		Namespace: czm_red_challenges_hud
		Checksum: 0xF5F8599F
		Offset: 0x578
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
		Namespace: czm_red_challenges_hud
		Checksum: 0x4F9A2773
		Offset: 0x528
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cluielem::open_luielem(player, "zm_red_challenges_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_red_challenges_hud
		Checksum: 0x150703C5
		Offset: 0x3B8
		Size: 0x164
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cluielem::setup_clientfields(uid);
		cluielem::add_clientfield("_state", 1, 2, "int");
		cluielem::function_dcb34c80("string", "challengeText", 13000);
		cluielem::function_dcb34c80("string", "bottomText", 13000);
		cluielem::add_clientfield("bInLocation", 13000, 1, "int");
		cluielem::add_clientfield("progress", 13000, 1, "counter");
		cluielem::add_clientfield("tributeAvailable", 13000, 3, "int");
		cluielem::add_clientfield("rewardHidden", 15000, 1, "int");
		cluielem::add_clientfield("challengeFailing", 15000, 1, "int");
	}

}

#namespace zm_red_challenges_hud;

/*
	Name: register
	Namespace: zm_red_challenges_hud
	Checksum: 0x26119C0
	Offset: 0x148
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new czm_red_challenges_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_red_challenges_hud
	Checksum: 0x6BF68E62
	Offset: 0x190
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
	Namespace: zm_red_challenges_hud
	Checksum: 0x20B05506
	Offset: 0x1D0
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
	Namespace: zm_red_challenges_hud
	Checksum: 0x12DEBB97
	Offset: 0x1F8
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
	Namespace: zm_red_challenges_hud
	Checksum: 0xA0929FD0
	Offset: 0x220
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_challengetext
	Namespace: zm_red_challenges_hud
	Checksum: 0xC6F3F65E
	Offset: 0x250
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengetext(player, value)
{
	[[ self ]]->set_challengetext(player, value);
}

/*
	Name: set_bottomtext
	Namespace: zm_red_challenges_hud
	Checksum: 0x22E08F7C
	Offset: 0x280
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_bottomtext(player, value)
{
	[[ self ]]->set_bottomtext(player, value);
}

/*
	Name: set_binlocation
	Namespace: zm_red_challenges_hud
	Checksum: 0x25504718
	Offset: 0x2B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_binlocation(player, value)
{
	[[ self ]]->set_binlocation(player, value);
}

/*
	Name: increment_progress
	Namespace: zm_red_challenges_hud
	Checksum: 0x641D0716
	Offset: 0x2E0
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function increment_progress(player)
{
	[[ self ]]->increment_progress(player);
}

/*
	Name: set_tributeavailable
	Namespace: zm_red_challenges_hud
	Checksum: 0xCE045DE2
	Offset: 0x308
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_tributeavailable(player, value)
{
	[[ self ]]->set_tributeavailable(player, value);
}

/*
	Name: set_rewardhidden
	Namespace: zm_red_challenges_hud
	Checksum: 0xAFA89D48
	Offset: 0x338
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_rewardhidden(player, value)
{
	[[ self ]]->set_rewardhidden(player, value);
}

/*
	Name: set_challengefailing
	Namespace: zm_red_challenges_hud
	Checksum: 0xFB8BFC8B
	Offset: 0x368
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challengefailing(player, value)
{
	[[ self ]]->set_challengefailing(player, value);
}

