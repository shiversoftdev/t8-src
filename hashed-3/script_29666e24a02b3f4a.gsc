// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

class czm_towers_challenges_hud : cLUIelem
{
	var var_47e79fc;

	/*
		Name: constructor
		Namespace: czm_towers_challenges_hud
		Checksum: 0xC511489C
		Offset: 0x2F0
		Size: 0x14
		Parameters: 0
		Flags: 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: czm_towers_challenges_hud
		Checksum: 0x6F2EA176
		Offset: 0x600
		Size: 0x14
		Parameters: 0
		Flags: 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: set_required_goal
		Namespace: czm_towers_challenges_hud
		Checksum: 0x64F2B24F
		Offset: 0x5B8
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_required_goal(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "required_goal", value);
	}

	/*
		Name: set_challenge_text
		Namespace: czm_towers_challenges_hud
		Checksum: 0xE6850323
		Offset: 0x570
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_challenge_text(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "challenge_text", value);
	}

	/*
		Name: set_progress
		Namespace: czm_towers_challenges_hud
		Checksum: 0x167B897B
		Offset: 0x528
		Size: 0x3C
		Parameters: 2
		Flags: None
	*/
	function set_progress(player, value)
	{
		player clientfield::function_9bf78ef8(var_47e79fc, "progress", value);
	}

	/*
		Name: set_state
		Namespace: czm_towers_challenges_hud
		Checksum: 0x64B90745
		Offset: 0x460
		Size: 0xBC
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
			if(#"hidden" == state_name)
			{
				player clientfield::function_9bf78ef8(var_47e79fc, "_state", 1);
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

	/*
		Name: close
		Namespace: czm_towers_challenges_hud
		Checksum: 0x9281A761
		Offset: 0x430
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
		Namespace: czm_towers_challenges_hud
		Checksum: 0x7013151B
		Offset: 0x3E0
		Size: 0x44
		Parameters: 2
		Flags: None
	*/
	function open(player, persistent = 0)
	{
		cLUIelem::open_luielem(player, "zm_towers_challenges_hud", persistent);
	}

	/*
		Name: setup_clientfields
		Namespace: czm_towers_challenges_hud
		Checksum: 0x20018BE2
		Offset: 0x310
		Size: 0xC4
		Parameters: 1
		Flags: None
	*/
	function setup_clientfields(uid)
	{
		cLUIelem::setup_clientfields(uid);
		cLUIelem::function_da693cbe("_state", 1, 1, "int");
		cLUIelem::function_da693cbe("progress", 1, 7, "int");
		cLUIelem::function_dcb34c80("string", "challenge_text", 1);
		cLUIelem::function_da693cbe("required_goal", 1, 7, "int");
	}

}

#namespace zm_towers_challenges_hud;

/*
	Name: set_challenge_progress
	Namespace: zm_towers_challenges_hud
	Checksum: 0x948B7158
	Offset: 0x108
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function set_challenge_progress(player, value)
{
	value = int(value * 100);
	[[ self ]]->set_progress(player, value);
}

/*
	Name: register
	Namespace: zm_towers_challenges_hud
	Checksum: 0xC18A0693
	Offset: 0x158
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	elem = new czm_towers_challenges_hud();
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: zm_towers_challenges_hud
	Checksum: 0x711EACAB
	Offset: 0x1A0
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0x692D22E2
	Offset: 0x1E0
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0xABC259FA
	Offset: 0x208
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
	Namespace: zm_towers_challenges_hud
	Checksum: 0xBF0988E4
	Offset: 0x230
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_state(player, state_name)
{
	[[ self ]]->set_state(player, state_name);
}

/*
	Name: set_progress
	Namespace: zm_towers_challenges_hud
	Checksum: 0xFA343D39
	Offset: 0x260
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_progress(player, value)
{
	[[ self ]]->set_progress(player, value);
}

/*
	Name: set_challenge_text
	Namespace: zm_towers_challenges_hud
	Checksum: 0x706C61B3
	Offset: 0x290
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_challenge_text(player, value)
{
	[[ self ]]->set_challenge_text(player, value);
}

/*
	Name: set_required_goal
	Namespace: zm_towers_challenges_hud
	Checksum: 0xD6911059
	Offset: 0x2C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function set_required_goal(player, value)
{
	[[ self ]]->set_required_goal(player, value);
}

