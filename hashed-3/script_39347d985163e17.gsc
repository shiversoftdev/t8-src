// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14af1fd264ffe8cc;
#using script_14f4a3c583c77d4b;
#using script_27c22e1d8df4d852;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_5c5619de;

/*
	Name: function_89f2df9
	Namespace: namespace_5c5619de
	Checksum: 0x407B69A
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1570e320e0161e3d", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_5c5619de
	Checksum: 0xC62EA193
	Offset: 0x160
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
	namespace_f551babc::register_challenge(#"hash_27f8093e2c3d8f82", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_5c5619de
	Checksum: 0xD35ADD89
	Offset: 0x1C8
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d1de6a85(var_264ee2f5)
{
	var_264ee2f5 = namespace_f551babc::function_5769f26a(var_264ee2f5);
	level thread function_cec06121(var_264ee2f5);
	callback::function_f77ced93(&namespace_b22c99a5::function_79518194);
	callback::function_33f0ddd3(&function_68af83a9);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_5c5619de
	Checksum: 0xBE785F41
	Offset: 0x250
	Size: 0x1A2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9e7b3f4d(round_reset)
{
	level.var_388587c6 = undefined;
	level namespace_f551babc::function_25ee130(0);
	callback::function_5a753d97(&namespace_b22c99a5::function_79518194);
	callback::function_824d206(&function_68af83a9);
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_dc0859e();
		if(!round_reset)
		{
			player.var_ad52095e = undefined;
		}
	}
	var_e4ee403e = struct::get_array("trials_oracle_boon_weapon_spawns");
	foreach(var_9a1edfd9 in var_e4ee403e)
	{
		zm_unitrigger::unregister_unitrigger(var_9a1edfd9.s_unitrigger);
		var_9a1edfd9.s_unitrigger = undefined;
	}
}

/*
	Name: function_68af83a9
	Namespace: namespace_5c5619de
	Checksum: 0xFA019B2A
	Offset: 0x400
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_68af83a9(s_event)
{
	w_root = zm_weapons::function_93cd8e76(s_event.weapon);
	if(!namespace_2ba51478::function_2ff6913(w_root) && isarray(level.var_388587c6) && !isinarray(level.var_388587c6, w_root.name))
	{
		self function_28602a03(s_event.weapon);
	}
	else
	{
		self unlockweapon(s_event.weapon);
	}
}

/*
	Name: function_cec06121
	Namespace: namespace_5c5619de
	Checksum: 0xD914D62D
	Offset: 0x4E0
	Size: 0x41A
	Parameters: 1
	Flags: Linked
*/
function function_cec06121(var_264ee2f5)
{
	level endon(#"hash_7646638df88a3656");
	wait(12);
	foreach(player in getplayers())
	{
		player namespace_b22c99a5::function_bf710271();
	}
	level namespace_f551babc::function_25ee130(1);
	level.var_388587c6 = array(#"hash_40788017f1c860f0", #"hash_7dc8f3611c942007", #"hash_6184fe412da2bb57", #"hash_552dc81e8f3ba5bc", #"hash_3041cc761d495272", #"hash_2f4a72ac7be5902e", #"hash_55ab674fdfba3485", #"hash_62c799cc48d4d897", #"hash_e052dd0c54e4a6f", #"hash_24c644460c2b5642", #"hash_65f0a900303f4c55");
	foreach(player in getplayers())
	{
		var_4cd7f83c = player getweaponslistprimaries();
		if(isarray(player.var_ad52095e))
		{
			foreach(var_f20e894b in player.var_ad52095e)
			{
				player unlockweapon(var_f20e894b);
			}
		}
		player namespace_b22c99a5::function_7dbb1712(1);
	}
	while(true)
	{
		var_e4ee403e = struct::get_array("trials_oracle_boon_weapon_spawns");
		var_e4ee403e = array::filter(var_e4ee403e, 0, &function_c55d2b6e);
		var_e4ee403e = array::randomize(var_e4ee403e);
		a_players = util::get_active_players();
		foreach(player in a_players)
		{
			var_9a1edfd9 = var_e4ee403e[player getentitynumber()];
			if(isdefined(var_9a1edfd9))
			{
				var_9a1edfd9 thread spawn_weapon(max(var_264ee2f5 - 10, 10));
			}
		}
		wait(var_264ee2f5);
	}
}

/*
	Name: function_c55d2b6e
	Namespace: namespace_5c5619de
	Checksum: 0x999489B9
	Offset: 0x908
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_c55d2b6e(var_9a1edfd9)
{
	if(isdefined(var_9a1edfd9.var_ff08ccc) && var_9a1edfd9.var_ff08ccc)
	{
		return 0;
	}
	return 1;
}

/*
	Name: spawn_weapon
	Namespace: namespace_5c5619de
	Checksum: 0xD957E5CF
	Offset: 0x948
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function spawn_weapon(var_6d4294b0)
{
	self.var_ff08ccc = 1;
	str_weapon_name = array::random(level.var_388587c6);
	weapon = getweapon(str_weapon_name);
	if(weapon === level.weaponnone)
	{
		return;
	}
	mdl_weapon = zm_utility::spawn_weapon_model(weapon, undefined, self.origin, self.angles);
	mdl_weapon.weapon = weapon;
	self function_33e89162(mdl_weapon, var_6d4294b0);
	self.var_ff08ccc = undefined;
}

/*
	Name: function_33e89162
	Namespace: namespace_5c5619de
	Checksum: 0xB66F95D6
	Offset: 0xA30
	Size: 0x28C
	Parameters: 2
	Flags: Linked
*/
function function_33e89162(mdl_weapon, var_6d4294b0)
{
	self zm_unitrigger::create(&function_c99662e7, 64, &function_ebd0491e);
	mdl_weapon thread clientfield::set("powerup_fx", 2);
	mdl_weapon thread namespace_f8f28e08::function_51fd2597(1);
	mdl_weapon thread namespace_f8f28e08::pickup_timeout(undefined, undefined, max(var_6d4294b0 - 5, 5));
	var_be17187b = undefined;
	var_be17187b = self waittill_timeout(var_6d4294b0, #"boon_weapon_picked_up");
	if(var_be17187b._notify == "boon_weapon_picked_up" && isplayer(var_be17187b.player))
	{
		var_efd38e4b = var_be17187b.player namespace_f8f28e08::function_e2a25377(mdl_weapon.weapon.name);
		var_be17187b.player unlockweapon(var_efd38e4b);
		if(!isdefined(var_be17187b.player.var_ad52095e))
		{
			var_be17187b.player.var_ad52095e = [];
		}
		else if(!isarray(var_be17187b.player.var_ad52095e))
		{
			var_be17187b.player.var_ad52095e = array(var_be17187b.player.var_ad52095e);
		}
		if(!isinarray(var_be17187b.player.var_ad52095e, var_efd38e4b))
		{
			var_be17187b.player.var_ad52095e[var_be17187b.player.var_ad52095e.size] = var_efd38e4b;
		}
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
	mdl_weapon delete();
}

/*
	Name: function_c99662e7
	Namespace: namespace_5c5619de
	Checksum: 0x3682E1B2
	Offset: 0xCC8
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_c99662e7(player)
{
	str_prompt = zm_utility::function_d6046228(#"hash_10c127acbe34c506", #"hash_4597718560da3ea2");
	self sethintstringforplayer(player, str_prompt);
	return 1;
}

/*
	Name: function_ebd0491e
	Namespace: namespace_5c5619de
	Checksum: 0x16AD35F3
	Offset: 0xD38
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function function_ebd0491e()
{
	self endon(#"death");
	if(1)
	{
		for(;;)
		{
			var_be17187b = undefined;
			var_be17187b = self waittill(#"trigger");
			player = var_be17187b.activator;
		}
		if(!zm_utility::can_use(player, 1))
		{
		}
		self.stub.related_parent notify(#"boon_weapon_picked_up", {#player:player});
		return;
	}
}

/*
	Name: is_active
	Namespace: namespace_5c5619de
	Checksum: 0x3DC76FE8
	Offset: 0xE00
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	s_challenge = namespace_f551babc::function_a36e8c38(#"hash_27f8093e2c3d8f82");
	return isdefined(s_challenge);
}

