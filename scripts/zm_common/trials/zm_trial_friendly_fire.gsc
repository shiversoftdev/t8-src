// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_weapons.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\bots\bot_util.gsc;
#using scripts\core_common\bots\bot.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace zm_trial_friendly_fire;

/*
	Name: __init__system__
	Namespace: zm_trial_friendly_fire
	Checksum: 0x8A42E52
	Offset: 0x150
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_trial_friendly_fire", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_trial_friendly_fire
	Checksum: 0x533D41F1
	Offset: 0x1A0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	zm_trial::register_challenge(#"friendly_fire", &on_begin, &on_end);
}

/*
	Name: __main__
	Namespace: zm_trial_friendly_fire
	Checksum: 0xDFA61850
	Offset: 0x208
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function __main__()
{
	if(!zm_trial::is_trial_mode())
	{
		return;
	}
	register_bot_weapons();
}

/*
	Name: register_bot_weapons
	Namespace: zm_trial_friendly_fire
	Checksum: 0xC8826201
	Offset: 0x240
	Size: 0xC4
	Parameters: 0
	Flags: None
*/
function register_bot_weapons()
{
	bot_action::register_bulletweapon(#"ar_accurate_t8_upgraded");
	bot_action::register_bulletweapon(#"ar_fastfire_t8_upgraded");
	bot_action::register_bulletweapon(#"ar_stealth_t8_upgraded");
	bot_action::register_bulletweapon(#"ar_modular_t8_upgraded");
	bot_action::register_bulletweapon(#"smg_capacity_t8_upgraded");
	bot_action::register_bulletweapon(#"tr_powersemi_t8_upgraded");
}

/*
	Name: on_begin
	Namespace: zm_trial_friendly_fire
	Checksum: 0x2A4D080D
	Offset: 0x310
	Size: 0x2A4
	Parameters: 1
	Flags: Private
*/
function private on_begin(var_9e0a2a85 = 1)
{
	level endon(#"hash_7646638df88a3656");
	if(ishash(var_9e0a2a85))
	{
		var_9e0a2a85 = zm_trial::function_5769f26a(var_9e0a2a85);
	}
	level.var_3c2226ce = zm_custom::function_901b751c(#"zmfriendlyfiretype");
	zm_custom::function_928be07c(var_9e0a2a85);
	callback::on_player_damage(&on_player_damage);
	level.var_edae191d = 1;
	var_6a94fd5e = 4 - getplayers().size;
	var_be33ceec = #"allies";
	level notify(#"hash_d3e36871aa6829f");
	for(i = 0; i < var_6a94fd5e; i++)
	{
		do
		{
			bot = bot::add_bot(var_be33ceec);
		}
		while(!isdefined(bot));
		bot.var_247fdf5 = 1;
		wait(1);
		if(bot util::is_spectating())
		{
			bot zm_player::spectator_respawn_player();
		}
	}
	foreach(player in getplayers())
	{
		if(isbot(player))
		{
			player thread function_e2c5e34c();
			player thread function_6aa8dd73();
		}
	}
	level.var_cd0fc105 = level.zm_bots_scale;
	level.zm_bots_scale = 0;
	zm::register_actor_damage_callback(&function_c4e6367a);
}

/*
	Name: on_end
	Namespace: zm_trial_friendly_fire
	Checksum: 0xBFAA496F
	Offset: 0x5C0
	Size: 0x1EE
	Parameters: 1
	Flags: Private
*/
function private on_end(round_reset)
{
	zm_custom::function_928be07c(level.var_3c2226ce);
	level.var_3c2226ce = undefined;
	callback::remove_on_player_damage(&on_player_damage);
	level.var_edae191d = undefined;
	foreach(player in getplayers())
	{
		if(isbot(player))
		{
			player val::reset("zm_trial_friendly_fire", "ignoreall");
			player val::reset("zm_trial_friendly_fire", "ignoreme");
		}
		if(isdefined(player.var_247fdf5) && player.var_247fdf5)
		{
			bot::remove_bot(player);
		}
	}
	level thread bot::populate_bots();
	if(isinarray(level.actor_damage_callbacks, &function_c4e6367a))
	{
		arrayremovevalue(level.actor_damage_callbacks, &function_c4e6367a, 0);
	}
	level.zm_bots_scale = level.var_cd0fc105;
	level.var_cd0fc105 = undefined;
}

/*
	Name: on_player_damage
	Namespace: zm_trial_friendly_fire
	Checksum: 0x6E69FAF9
	Offset: 0x7B8
	Size: 0x19E
	Parameters: 1
	Flags: Private
*/
function private on_player_damage(params)
{
	if(isplayer(params.eattacker) && !isbot(params.eattacker) && params.idamage >= self.health && params.eattacker != self)
	{
		zm_trial::fail(#"hash_6e2a00b7d2d6e510", array(params.eattacker));
		return;
	}
	if(isbot(self) && isdefined(params.einflictor) && isplayer(params.einflictor.activated_by_player) && !isbot(params.einflictor.activated_by_player) && params.idamage >= self.health)
	{
		zm_trial::fail(#"hash_6e2a00b7d2d6e510", array(params.einflictor.activated_by_player));
		return;
	}
}

/*
	Name: function_e2c5e34c
	Namespace: zm_trial_friendly_fire
	Checksum: 0xB21E1757
	Offset: 0x960
	Size: 0xC0
	Parameters: 0
	Flags: Private
*/
function private function_e2c5e34c()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		self val::reset("zm_trial_friendly_fire", "ignoreme");
		wait(randomintrange(3, 5));
		if(function_e1378d07())
		{
			self val::set("zm_trial_friendly_fire", "ignoreme", 1);
		}
		wait(randomintrange(5, 10));
	}
}

/*
	Name: function_e1378d07
	Namespace: zm_trial_friendly_fire
	Checksum: 0xD920EDFE
	Offset: 0xA28
	Size: 0xBE
	Parameters: 0
	Flags: Private
*/
function private function_e1378d07()
{
	foreach(player in getplayers())
	{
		if(isalive(player) && !isbot(player) && !player laststand::player_is_in_laststand())
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_c4e6367a
	Namespace: zm_trial_friendly_fire
	Checksum: 0xF941FCDA
	Offset: 0xAF0
	Size: 0xD2
	Parameters: 12
	Flags: Private
*/
function private function_c4e6367a(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && isbot(attacker) && level.round_number <= 20)
	{
		damage = int(damage * 0.5);
	}
	return damage;
}

/*
	Name: function_6aa8dd73
	Namespace: zm_trial_friendly_fire
	Checksum: 0xF5CBC1D7
	Offset: 0xBD0
	Size: 0x434
	Parameters: 0
	Flags: None
*/
function function_6aa8dd73()
{
	self endon(#"disconnect");
	if(self laststand::player_is_in_laststand() || !isalive(self) || self util::is_spectating())
	{
		self waittill(#"player_revived", #"spawned");
	}
	if(level.round_number >= 20)
	{
		self zm_hero_weapon::function_1bb7f7b1(3);
		var_98cb6e9 = array::randomize(array(#"ar_accurate_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_stealth_t8_upgraded", #"ar_modular_t8_upgraded", #"smg_capacity_t8_upgraded", #"tr_powersemi_t8_upgraded"));
		n_repacks = 4;
		self zm_perks::function_cc24f525();
	}
	else
	{
		if(level.round_number >= 10)
		{
			self zm_hero_weapon::function_1bb7f7b1(2);
			var_98cb6e9 = array::randomize(array(#"ar_accurate_t8_upgraded", #"ar_fastfire_t8_upgraded", #"ar_stealth_t8_upgraded", #"ar_modular_t8_upgraded", #"smg_capacity_t8_upgraded", #"tr_powersemi_t8_upgraded"));
			n_repacks = 2;
		}
		else
		{
			self zm_hero_weapon::function_1bb7f7b1(1);
			var_98cb6e9 = array::randomize(array(#"ar_accurate_t8", #"ar_fastfire_t8", #"ar_stealth_t8", #"ar_modular_t8", #"smg_capacity_t8", #"tr_powersemi_t8"));
		}
	}
	foreach(w_primary in self getweaponslistprimaries())
	{
		self takeweapon(w_primary);
	}
	for(i = 0; i < zm_utility::get_player_weapon_limit(self); i++)
	{
		weapon = getweapon(var_98cb6e9[i]);
		weapon = self zm_weapons::give_build_kit_weapon(weapon);
		if(isdefined(level.aat_in_use) && level.aat_in_use && zm_weapons::weapon_supports_aat(weapon) && isdefined(n_repacks))
		{
			self thread aat::acquire(weapon);
			self zm_pap_util::repack_weapon(weapon, n_repacks);
		}
	}
	self switchtoweapon(weapon);
}

