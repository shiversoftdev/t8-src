// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_perks.csc;
#using scripts\core_common\visionset_mgr_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_perk_deadshot;

/*
	Name: __init__system__
	Namespace: zm_perk_deadshot
	Checksum: 0x1DBEFE40
	Offset: 0x138
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_perk_deadshot", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_perk_deadshot
	Checksum: 0xB50A0D8
	Offset: 0x180
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	enable_deadshot_perk_for_level();
}

/*
	Name: enable_deadshot_perk_for_level
	Namespace: zm_perk_deadshot
	Checksum: 0x7C6EB943
	Offset: 0x1A0
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function enable_deadshot_perk_for_level()
{
	zm_perks::register_perk_clientfields(#"specialty_deadshot", &deadshot_client_field_func, &deadshot_code_callback_func);
	zm_perks::register_perk_effects(#"specialty_deadshot", "deadshot_light");
	zm_perks::register_perk_init_thread(#"specialty_deadshot", &init_deadshot);
	zm_perks::function_b60f4a9f(#"specialty_deadshot", #"p8_zm_vapor_altar_icon_01_deadshot", "zombie/fx8_perk_altar_symbol_ambient_dead_shot", #"zmperksdeadshot");
	zm_perks::function_f3c80d73("zombie_perk_bottle_deadshot", "zombie_perk_totem_deadshot");
}

/*
	Name: init_deadshot
	Namespace: zm_perk_deadshot
	Checksum: 0x89831933
	Offset: 0x2B0
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function init_deadshot()
{
	if(isdefined(level.enable_magic) && level.enable_magic)
	{
		level._effect[#"deadshot_light"] = #"hash_2225287695ddf9c9";
	}
}

/*
	Name: deadshot_client_field_func
	Namespace: zm_perk_deadshot
	Checksum: 0x13302762
	Offset: 0x310
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function deadshot_client_field_func()
{
	clientfield::register("toplayer", "deadshot_perk", 1, 1, "int", &player_deadshot_perk_handler, 0, 1);
}

/*
	Name: deadshot_code_callback_func
	Namespace: zm_perk_deadshot
	Checksum: 0x80F724D1
	Offset: 0x368
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function deadshot_code_callback_func()
{
}

/*
	Name: player_deadshot_perk_handler
	Namespace: zm_perk_deadshot
	Checksum: 0x96A0E80F
	Offset: 0x378
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function player_deadshot_perk_handler(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!is_local_player(self))
	{
		return;
	}
	self endon(#"death");
	if(self util::function_50ed1561(localclientnum))
	{
		if(is_local_player(self))
		{
			if(newval)
			{
				self usealternateaimparams();
			}
			else
			{
				self clearalternateaimparams();
			}
		}
	}
}

/*
	Name: is_local_player
	Namespace: zm_perk_deadshot
	Checksum: 0xCFF8FBB2
	Offset: 0x450
	Size: 0x6A
	Parameters: 1
	Flags: Linked, Private
*/
function private is_local_player(player)
{
	if(!isdefined(player) || !isplayer(player))
	{
		return 0;
	}
	a_players = getlocalplayers();
	return isinarray(a_players, player);
}

