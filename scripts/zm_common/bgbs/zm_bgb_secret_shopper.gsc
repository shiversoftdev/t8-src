// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace zm_bgb_secret_shopper;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_secret_shopper
	Checksum: 0x2563FB1
	Offset: 0xB8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_bgb_secret_shopper", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_secret_shopper
	Checksum: 0x394F93DE
	Offset: 0x108
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_secret_shopper", "time", 600, &enable, &disable, undefined, undefined);
}

/*
	Name: enable
	Namespace: zm_bgb_secret_shopper
	Checksum: 0xE284E212
	Offset: 0x188
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function enable()
{
	self endon(#"disconnect", #"bled_out", #"bgb_update");
	level thread function_bdbf3da2(self);
}

/*
	Name: disable
	Namespace: zm_bgb_secret_shopper
	Checksum: 0x80F724D1
	Offset: 0x1E8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function disable()
{
}

/*
	Name: function_bdbf3da2
	Namespace: zm_bgb_secret_shopper
	Checksum: 0x5459ABFC
	Offset: 0x1F8
	Size: 0x20E
	Parameters: 1
	Flags: Linked
*/
function function_bdbf3da2(player)
{
	self notify("6daba2448119ac03");
	self endon("6daba2448119ac03");
	player endon(#"bgb_update", #"disconnect");
	while(true)
	{
		is_melee = player meleebuttonpressed();
		if(!is_melee)
		{
			waitframe(1);
			continue;
		}
		if(!isdefined(player.useholdent))
		{
			waitframe(1);
			continue;
		}
		if(player.useholdent.targetname !== "weapon_upgrade")
		{
			waitframe(1);
			continue;
		}
		if(!player bgb::is_enabled(#"zm_bgb_secret_shopper"))
		{
			waitframe(1);
			continue;
		}
		if(player isswitchingweapons())
		{
			waitframe(1);
			continue;
		}
		w_current = player.currentweapon;
		if(isdefined(w_current.var_94d4849) && w_current.var_94d4849)
		{
			waitframe(1);
			continue;
		}
		n_ammo_cost = player zm_weapons::get_ammo_cost_for_weapon(w_current);
		var_67807dc5 = 0;
		if(player zm_score::can_player_purchase(n_ammo_cost))
		{
			var_67807dc5 = player zm_weapons::ammo_give(w_current);
		}
		if(var_67807dc5)
		{
			player zm_score::minus_to_player_score(n_ammo_cost);
			player bgb::do_one_shot_use(1);
		}
		else
		{
			player bgb::function_b57e693f();
		}
		waitframe(1);
	}
}

