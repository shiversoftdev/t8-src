// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14af1fd264ffe8cc;
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_5c5619de;

/*
	Name: __init__system__
	Namespace: namespace_5c5619de
	Checksum: 0x407B69A
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
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
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_27f8093e2c3d8f82", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_5c5619de
	Checksum: 0xD35ADD89
	Offset: 0x1C8
	Size: 0x7C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(var_264ee2f5)
{
	var_264ee2f5 = zm_trial::function_5769f26a(var_264ee2f5);
	level thread function_cec06121(var_264ee2f5);
	callback::on_weapon_change(&zm_trial_util::function_79518194);
	callback::function_33f0ddd3(&function_68af83a9);
}

/*
	Name: on_end
	Namespace: namespace_5c5619de
	Checksum: 0xBE785F41
	Offset: 0x250
	Size: 0x1A2
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	level.var_388587c6 = undefined;
	level zm_trial::function_25ee130(0);
	callback::remove_on_weapon_change(&zm_trial_util::function_79518194);
	callback::function_824d206(&function_68af83a9);
	foreach(player in getplayers())
	{
		player zm_trial_util::function_dc0859e();
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
function private function_68af83a9(s_event)
{
	w_root = zm_weapons::function_93cd8e76(s_event.weapon);
	if(!zm_loadout::function_2ff6913(w_root) && isarray(level.var_388587c6) && !isinarray(level.var_388587c6, w_root.name))
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
		player zm_trial_util::function_bf710271();
	}
	level zm_trial::function_25ee130(1);
	level.var_388587c6 = array(#"ar_standard_t8_upgraded", #"pistol_fullauto_t8_upgraded", #"smg_fastburst_t8_upgraded", #"smg_mp40_t8_upgraded", #"smg_folding_t8_upgraded", #"shotgun_fullauto_t8_upgraded", #"lmg_stealth_t8_upgraded", #"sniper_mini14_t8_upgraded", #"ar_peacekeeper_t8_upgraded", #"tr_flechette_t8_upgraded", #"sniper_locus_t8_upgraded");
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
		player zm_trial_util::function_7dbb1712(1);
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
		return false;
	}
	return true;
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
	s_waitresult = undefined;
	s_waitresult = self waittilltimeout(var_6d4294b0, #"boon_weapon_picked_up");
	if(s_waitresult._notify == "boon_weapon_picked_up" && isplayer(s_waitresult.player))
	{
		weapon_reward = s_waitresult.player namespace_f8f28e08::function_e2a25377(mdl_weapon.weapon.name);
		s_waitresult.player unlockweapon(weapon_reward);
		if(!isdefined(s_waitresult.player.var_ad52095e))
		{
			s_waitresult.player.var_ad52095e = [];
		}
		else if(!isarray(s_waitresult.player.var_ad52095e))
		{
			s_waitresult.player.var_ad52095e = array(s_waitresult.player.var_ad52095e);
		}
		if(!isinarray(s_waitresult.player.var_ad52095e, weapon_reward))
		{
			s_waitresult.player.var_ad52095e[s_waitresult.player.var_ad52095e.size] = weapon_reward;
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
	return true;
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
			s_waitresult = undefined;
			s_waitresult = self waittill(#"trigger");
			player = s_waitresult.activator;
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
	s_challenge = zm_trial::function_a36e8c38(#"hash_27f8093e2c3d8f82");
	return isdefined(s_challenge);
}

