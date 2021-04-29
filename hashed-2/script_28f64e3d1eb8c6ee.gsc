// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_464d16d046aa6b7f;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace namespace_e044deca;

/*
	Name: function_89f2df9
	Namespace: namespace_e044deca
	Checksum: 0x61063EEF
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_5c6b0ba6c540d07d", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_e044deca
	Checksum: 0x1209DC81
	Offset: 0xF8
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_8afdc221();
}

/*
	Name: __main__
	Namespace: namespace_e044deca
	Checksum: 0x80F724D1
	Offset: 0x118
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_8afdc221
	Namespace: namespace_e044deca
	Checksum: 0xBE4EBFF9
	Offset: 0x128
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_8afdc221()
{
	zm_perks::function_7f42e14e(#"hash_cd6e82bd4ce7abf", "mod_stronghold", #"hash_452086e4c25a6fe4", #"hash_34c7d1e8a059f87e", 3000);
	zm_perks::register_perk_threads(#"hash_cd6e82bd4ce7abf", &function_1076eef9, &function_20b5dc19);
}

/*
	Name: function_1076eef9
	Namespace: namespace_e044deca
	Checksum: 0x4CCF5211
	Offset: 0x1C8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_1076eef9()
{
	level callback::on_ai_killed(&function_1c4f9c3f);
}

/*
	Name: function_20b5dc19
	Namespace: namespace_e044deca
	Checksum: 0xB14D15B0
	Offset: 0x1F8
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_20b5dc19(b_pause, str_perk, str_result, var_bcd1c2ff)
{
	level callback::remove_on_ai_killed(&function_1c4f9c3f);
}

/*
	Name: function_1c4f9c3f
	Namespace: namespace_e044deca
	Checksum: 0x8A1837CB
	Offset: 0x248
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_1c4f9c3f(s_params)
{
	player = s_params.eattacker;
	if(isplayer(player) && player hasperk(#"hash_cd6e82bd4ce7abf"))
	{
		if(!(isdefined(player.var_7d0e99f3) && player.var_7d0e99f3))
		{
			return;
		}
		n_dist = distance(player.var_3748ec02, self.origin);
		if(n_dist <= 130)
		{
			player namespace_ca7bef86::function_7e0559c1();
			player namespace_ca7bef86::function_c25b980c();
		}
	}
}

