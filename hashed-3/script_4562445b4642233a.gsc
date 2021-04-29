// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_510a7c58311cd7b5;
#using script_6021ce59143452c3;
#using script_61a734c95edc17aa;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;

#namespace namespace_da8b7efe;

/*
	Name: function_89f2df9
	Namespace: namespace_da8b7efe
	Checksum: 0xB40910A
	Offset: 0xA0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3b839a6472377a68", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_da8b7efe
	Checksum: 0x2D12D7DE
	Offset: 0xE8
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!namespace_f551babc::function_b47f6aba())
	{
		return;
	}
	namespace_f551babc::register_challenge(#"hash_69330ea47008c27f", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_da8b7efe
	Checksum: 0x44092883
	Offset: 0x150
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d1de6a85()
{
	level thread function_b7bc0616();
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_da8b7efe
	Checksum: 0x60519E41
	Offset: 0x178
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	namespace_b22c99a5::function_f3dbeda7();
	if(!round_reset && !level flag::get(#"hash_4207012c64662b4d"))
	{
		namespace_f551babc::fail(#"hash_2c061f4e3509c0f4");
	}
	function_63ec8741();
}

/*
	Name: function_b7bc0616
	Namespace: namespace_da8b7efe
	Checksum: 0x2EA5AE66
	Offset: 0x200
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b7bc0616()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	namespace_b22c99a5::function_7d32b7d0(0);
	function_f5ad51bd();
	level flag::wait_till(#"hash_4207012c64662b4d");
	waitframe(1);
	namespace_b22c99a5::function_7d32b7d0(1);
	function_63ec8741();
}

/*
	Name: function_f5ad51bd
	Namespace: namespace_da8b7efe
	Checksum: 0xF46D3F03
	Offset: 0x2A8
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f5ad51bd()
{
	foreach(player in getplayers())
	{
		if(player bgb::is_enabled(#"zm_bgb_newtonian_negation"))
		{
			player.var_30ee603f = 1;
			player.var_4b0fb2fb = 1;
		}
		player namespace_7d0afffb::function_59004002(#"zm_bgb_newtonian_negation", 1);
	}
	level.var_6bbb45f9 = 1;
	zm_bgb_newtonian_negation::function_8622e664(0);
}

/*
	Name: function_63ec8741
	Namespace: namespace_da8b7efe
	Checksum: 0xC10BAF82
	Offset: 0x3B0
	Size: 0xE2
	Parameters: 0
	Flags: Linked, Private
*/
private function function_63ec8741()
{
	foreach(player in getplayers())
	{
		if(isdefined(player.var_30ee603f) && player.var_30ee603f)
		{
			zm_bgb_newtonian_negation::function_8622e664(1);
			player.var_30ee603f = undefined;
			player.var_4b0fb2fb = undefined;
		}
		player namespace_7d0afffb::function_59004002(#"zm_bgb_newtonian_negation", 0);
	}
	level.var_6bbb45f9 = undefined;
}

