// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace namespace_2dadcb58;

/*
	Name: function_89f2df9
	Namespace: namespace_2dadcb58
	Checksum: 0xE0BDC005
	Offset: 0xB0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_242c2a18cea5e1", &__init__, undefined, "bgb");
}

/*
	Name: __init__
	Namespace: namespace_2dadcb58
	Checksum: 0xEBB22844
	Offset: 0xF8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"hash_242c2a18cea5e1", "activated", 1, undefined, undefined, undefined, &activation);
}

/*
	Name: activation
	Namespace: namespace_2dadcb58
	Checksum: 0x75455573
	Offset: 0x168
	Size: 0x21A
	Parameters: 0
	Flags: Linked
*/
function activation()
{
	a_players = util::get_players();
	foreach(player in a_players)
	{
		var_ac6ee9a0 = player zm_loadout::get_player_lethal_grenade();
		if(var_ac6ee9a0.isgadget)
		{
			n_slot = player gadgetgetslot(var_ac6ee9a0);
			if(var_ac6ee9a0 == getweapon(#"tomahawk_t8") || var_ac6ee9a0 == getweapon(#"tomahawk_t8_upgraded"))
			{
				if(!player function_36dfc05f(n_slot))
				{
					player notify(#"hash_3d73720d4588203c");
					player gadgetpowerset(n_slot, 100);
				}
			}
			else
			{
				player gadgetpowerreset(n_slot, 0);
			}
		}
		player thread function_556e219();
		for(i = 0; i < 4; i++)
		{
			player zm_perks::function_9b641809(i);
		}
		for(i = 0; i < player.var_67ba1237.size; i++)
		{
			player zm_perks::function_9829d4a9(i);
		}
	}
}

/*
	Name: function_556e219
	Namespace: namespace_2dadcb58
	Checksum: 0xE4F7B404
	Offset: 0x390
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_556e219()
{
	self endon(#"death");
	if(isdefined(self.var_1f23fe79) && self.var_1f23fe79)
	{
		self waittill(#"hash_3eaa776332738598");
	}
	self gadgetpowerset(level.var_a53a05b5, 100);
}

