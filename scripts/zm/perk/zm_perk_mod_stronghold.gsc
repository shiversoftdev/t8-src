// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\perk\zm_perk_stronghold.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_perks.gsc;

#namespace zm_perk_mod_stronghold;

/*
	Name: __init__system__
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x61063EEF
	Offset: 0xA8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_mod_stronghold", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_mod_stronghold
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
	Namespace: zm_perk_mod_stronghold
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
	Namespace: zm_perk_mod_stronghold
	Checksum: 0xBE4EBFF9
	Offset: 0x128
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_8afdc221()
{
	zm_perks::register_perk_mod_basic_info(#"specialty_mod_camper", "mod_stronghold", #"perk_stronghold", #"specialty_camper", 3000);
	zm_perks::register_perk_threads(#"specialty_mod_camper", &function_1076eef9, &function_20b5dc19);
}

/*
	Name: function_1076eef9
	Namespace: zm_perk_mod_stronghold
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
	Namespace: zm_perk_mod_stronghold
	Checksum: 0xB14D15B0
	Offset: 0x1F8
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function function_20b5dc19(b_pause, str_perk, str_result, n_slot)
{
	level callback::remove_on_ai_killed(&function_1c4f9c3f);
}

/*
	Name: function_1c4f9c3f
	Namespace: zm_perk_mod_stronghold
	Checksum: 0x8A1837CB
	Offset: 0x248
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_1c4f9c3f(s_params)
{
	player = s_params.eattacker;
	if(isplayer(player) && player hasperk(#"specialty_mod_camper"))
	{
		if(!(isdefined(player.var_7d0e99f3) && player.var_7d0e99f3))
		{
			return;
		}
		n_dist = distance(player.var_3748ec02, self.origin);
		if(n_dist <= 130)
		{
			player zm_perk_stronghold::function_7e0559c1();
			player zm_perk_stronghold::function_c25b980c();
		}
	}
}

