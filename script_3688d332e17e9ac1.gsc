// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_trial_util.gsc;
#using scripts\zm_common\zm_trial.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace namespace_ae2d0839;

/*
	Name: __init__system__
	Namespace: namespace_ae2d0839
	Checksum: 0xF06E91E2
	Offset: 0xC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_7c9607fd2f57a1c7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ae2d0839
	Checksum: 0x733ADC69
	Offset: 0x110
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
	zm_trial::register_challenge(#"hash_4043192ca121b4d4", &on_begin, &on_end);
}

/*
	Name: on_begin
	Namespace: namespace_ae2d0839
	Checksum: 0x530B07DD
	Offset: 0x178
	Size: 0x344
	Parameters: 1
	Flags: Linked, Private
*/
function private on_begin(var_59803fa8)
{
	callback::on_ai_damage(&on_ai_damage);
	level.var_3c453815 = zm_trial::function_5769f26a(var_59803fa8);
	foreach(player in getplayers())
	{
		player zm_trial_util::function_8677ce00(1);
		player.b_hit = 0;
		player callback::on_weapon_fired(&on_weapon_fired);
		foreach(var_5a1e3e5b in level.hero_weapon)
		{
			foreach(w_hero in var_5a1e3e5b)
			{
				player function_28602a03(w_hero, 1, 1);
			}
		}
		player zm_trial_util::function_9bf8e274();
		foreach(w_equip in level.zombie_weapons)
		{
			if(zm_loadout::is_melee_weapon(w_equip.weapon) || zm_loadout::is_lethal_grenade(w_equip.weapon))
			{
				player function_28602a03(w_equip.weapon, 1, 1);
			}
		}
		player zm_trial_util::function_dc9ab223(1, 1);
	}
	callback::function_33f0ddd3(&function_33f0ddd3);
	level zm_trial::function_44200d07(1);
	level zm_trial::function_cd75b690(1);
}

/*
	Name: on_end
	Namespace: namespace_ae2d0839
	Checksum: 0x906C7059
	Offset: 0x4C8
	Size: 0x30C
	Parameters: 1
	Flags: Linked, Private
*/
function private on_end(round_reset)
{
	callback::remove_on_ai_damage(&on_ai_damage);
	callback::function_824d206(&function_33f0ddd3);
	level.var_3c453815 = undefined;
	foreach(player in getplayers())
	{
		player.var_9979ffd6 = undefined;
		player.b_hit = undefined;
		player callback::remove_on_weapon_fired(&on_weapon_fired);
		foreach(var_5a1e3e5b in level.hero_weapon)
		{
			foreach(w_hero in var_5a1e3e5b)
			{
				player unlockweapon(w_hero);
			}
		}
		player zm_trial_util::function_73ff0096();
		foreach(w_equip in level.zombie_weapons)
		{
			if(zm_loadout::is_melee_weapon(w_equip.weapon) || zm_loadout::is_lethal_grenade(w_equip.weapon))
			{
				player unlockweapon(w_equip.weapon);
			}
		}
		player zm_trial_util::function_dc9ab223(0, 1);
		player zm_trial_util::function_8677ce00(0);
	}
	level zm_trial::function_44200d07(0);
	level zm_trial::function_cd75b690(0);
}

/*
	Name: on_ai_damage
	Namespace: namespace_ae2d0839
	Checksum: 0x52B974F6
	Offset: 0x7E0
	Size: 0xF2
	Parameters: 1
	Flags: Linked, Private
*/
function private on_ai_damage(params)
{
	if(isplayer(params.eattacker) && params.weapon != level.weaponbasemelee && (isdefined(params.weapon.isbulletweapon) && params.weapon.isbulletweapon || (isdefined(params.weapon.isprojectileweapon) && params.weapon.isprojectileweapon) || (isdefined(params.weapon.isburstfire) && params.weapon.isburstfire)))
	{
		params.eattacker.b_hit = 1;
	}
}

/*
	Name: on_weapon_fired
	Namespace: namespace_ae2d0839
	Checksum: 0x85D9B19D
	Offset: 0x8E0
	Size: 0x1A4
	Parameters: 1
	Flags: Linked, Private
*/
function private on_weapon_fired(params)
{
	if(!isdefined(params.weapon))
	{
		return;
	}
	if(isdefined(params.weapon.isprojectileweapon) && params.weapon.isprojectileweapon)
	{
		return;
	}
	if(params.weapon.firetype === "Auto Burst" || params.weapon.firetype === "Burst" || params.weapon.firetype === "Full Auto")
	{
		self notify(#"hash_593afdd4317784a0");
	}
	self endon(#"disconnect", #"hash_593afdd4317784a0");
	level endon(#"hash_7646638df88a3656");
	if(!isdefined(self.var_9979ffd6))
	{
		self.var_9979ffd6 = 0.2;
	}
	while(self isfiring() && self.var_9979ffd6 > 0)
	{
		waitframe(1);
		self.var_9979ffd6 = self.var_9979ffd6 - (float(function_60d95f53()) / 1000);
	}
	self function_b33ed7bd();
}

/*
	Name: function_b33ed7bd
	Namespace: namespace_ae2d0839
	Checksum: 0x32C9E1D8
	Offset: 0xA90
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function function_b33ed7bd()
{
	if(isdefined(level.var_3c453815) && isdefined(self) && isdefined(self.b_hit) && !self.b_hit)
	{
		self dodamage(level.var_3c453815, self.origin);
	}
	self.b_hit = 0;
	self.var_9979ffd6 = 0.2;
}

/*
	Name: is_active
	Namespace: namespace_ae2d0839
	Checksum: 0x1262F4EA
	Offset: 0xB18
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function is_active()
{
	challenge = zm_trial::function_a36e8c38(#"hash_4043192ca121b4d4");
	return isdefined(challenge);
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_ae2d0839
	Checksum: 0xA5498FAE
	Offset: 0xB58
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_33f0ddd3(s_event)
{
	if(s_event.event === "give_weapon")
	{
		if(!self function_635f9c02(s_event.weapon))
		{
			self function_28602a03(s_event.weapon, 0, 1);
		}
		if(zm_loadout::is_melee_weapon(s_event.weapon) || zm_loadout::is_lethal_grenade(s_event.weapon))
		{
			self function_28602a03(s_event.weapon, 1, 1);
		}
	}
}

/*
	Name: function_f8ea644
	Namespace: namespace_ae2d0839
	Checksum: 0xCCBCC7BE
	Offset: 0xC38
	Size: 0xB4
	Parameters: 1
	Flags: Event
*/
event function_f8ea644(eventstruct)
{
	if(is_active() && isdefined(eventstruct.projectile))
	{
		s_waitresult = undefined;
		s_waitresult = eventstruct.projectile waittilltimeout(2, #"death", #"explode", #"projectile_impact_explode", #"stationary", #"grenade_stuck");
		self function_b33ed7bd();
	}
}

