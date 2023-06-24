// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_bgb_pack.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\bgbs\zm_bgb_newtonian_negation.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace zm_trial_mansion_billiards;

/*
	Name: __init__system__
	Namespace: zm_trial_mansion_billiards
	Checksum: 0xB40910A
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_mansion_billiards", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_mansion_billiards
	Checksum: 0x2D12D7DE
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"mansion_billiards", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: zm_trial_mansion_billiards
	Checksum: 0x44092883
	Offset: 0x150
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private on_begin()
{
	level thread function_b7bc0616();
}

/*
	Name: on_end
	Namespace: zm_trial_mansion_billiards
	Checksum: 0x60519E41
	Offset: 0x178
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	zm_trial_util::function_f3dbeda7();
	if(!round_reset && !level flag::get(#"hash_4207012c64662b4d"))
	{
		zm_trial::fail(#"hash_2c061f4e3509c0f4");
	}
	enable_newtonian_negation();
}

/*
	Name: function_b7bc0616
	Namespace: zm_trial_mansion_billiards
	Checksum: 0x2EA5AE66
	Offset: 0x200
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b7bc0616()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	zm_trial_util::function_7d32b7d0(0);
	function_f5ad51bd();
	level flag::wait_till(#"hash_4207012c64662b4d");
	waitframe(1);
	zm_trial_util::function_7d32b7d0(1);
	enable_newtonian_negation();
}

/*
	Name: function_f5ad51bd
	Namespace: zm_trial_mansion_billiards
	Checksum: 0xF46D3F03
	Offset: 0x2A8
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f5ad51bd()
{
	foreach(player in getplayers())
	{
		if(player bgb::is_enabled(#"zm_bgb_newtonian_negation"))
		{
			player.var_30ee603f = 1;
			player.var_4b0fb2fb = 1;
		}
		player bgb_pack::function_59004002(#"zm_bgb_newtonian_negation", 1);
	}
	level.var_6bbb45f9 = 1;
	zm_bgb_newtonian_negation::function_8622e664(0);
}

/*
	Name: enable_newtonian_negation
	Namespace: zm_trial_mansion_billiards
	Checksum: 0xC10BAF82
	Offset: 0x3B0
	Size: 0xE2
	Parameters: 0
	Flags: Linked, Private
*/
function private enable_newtonian_negation()
{
	foreach(player in getplayers())
	{
		if(isdefined(player.var_30ee603f) && player.var_30ee603f)
		{
			zm_bgb_newtonian_negation::function_8622e664(1);
			player.var_30ee603f = undefined;
			player.var_4b0fb2fb = undefined;
		}
		player bgb_pack::function_59004002(#"zm_bgb_newtonian_negation", 0);
	}
	level.var_6bbb45f9 = undefined;
}

