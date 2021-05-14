// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6021ce59143452c3;
#using script_6ce38ab036223e6e;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a476311c;

/*
	Name: function_89f2df9
	Namespace: namespace_a476311c
	Checksum: 0x3A4D8821
	Offset: 0xA8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7ceb08aa364e4596", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a476311c
	Checksum: 0xED8D6FEA
	Offset: 0xF0
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	zm_trial::register_challenge(#"hash_250115340b2e27a5", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_a476311c
	Checksum: 0x1C76B340
	Offset: 0x158
	Size: 0x114
	Parameters: 4
	Flags: Private
*/
private function function_d1de6a85(var_b9c6550, var_50d1120, var_43f824d6, var_73d6ae36)
{
	if(isdefined(var_b9c6550))
	{
		self.var_97330ad2 = zm_trial::function_5769f26a(var_b9c6550);
	}
	else
	{
		self.var_97330ad2 = 25;
	}
	if(isdefined(var_50d1120))
	{
		self.var_6633a592 = zm_trial::function_5769f26a(var_50d1120);
	}
	else
	{
		self.var_6633a592 = 8;
	}
	if(isdefined(var_43f824d6))
	{
		self.var_ead3a0f2 = zm_trial::function_5769f26a(var_43f824d6);
	}
	else
	{
		self.var_ead3a0f2 = 1.1;
	}
	if(isdefined(var_73d6ae36))
	{
		var_73d6ae36 = zm_trial::function_5769f26a(var_73d6ae36);
	}
	self thread function_e997bb0b(var_73d6ae36);
	zm_spawner::register_zombie_death_event_callback(&function_138aec8e);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_a476311c
	Checksum: 0xCC5C33B5
	Offset: 0x278
	Size: 0x2C
	Parameters: 1
	Flags: Private
*/
private function function_9e7b3f4d(round_reset)
{
	zm_spawner::deregister_zombie_death_event_callback(&function_138aec8e);
}

/*
	Name: function_e997bb0b
	Namespace: namespace_a476311c
	Checksum: 0xAED53267
	Offset: 0x2B0
	Size: 0x2A4
	Parameters: 1
	Flags: Private
*/
private function function_e997bb0b(var_73d6ae36)
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	if(isdefined(var_73d6ae36))
	{
		wait(var_73d6ae36);
	}
	else
	{
		n_delay = namespace_a28acff3::get_delay_between_rounds();
		wait(n_delay + 0);
	}
	while(true)
	{
		foreach(player in getplayers())
		{
			/#
				if(isgodmode(player) || player isinmovemode("", ""))
				{
					continue;
				}
			#/
			if(player.health > 0 && !player laststand::player_is_in_laststand() && (!(isdefined(player.var_eb319d10) && player.var_eb319d10)) && (!(isdefined(level.intermission) && level.intermission)))
			{
				if(player.health <= self.var_6633a592)
				{
					if(zm_utility::is_magic_bullet_shield_enabled(player))
					{
						player util::stop_magic_bullet_shield();
					}
					player dodamage(player.health + 1000, player.origin);
					continue;
				}
				if(isdefined(player.armor) && player.armor > 0)
				{
					player dodamage(self.var_6633a592 + 5, player.origin);
					continue;
				}
				player dodamage(self.var_6633a592, player.origin);
			}
		}
		wait(self.var_ead3a0f2);
	}
}

/*
	Name: function_49091c27
	Namespace: namespace_a476311c
	Checksum: 0x88D5F565
	Offset: 0x560
	Size: 0xD2
	Parameters: 0
	Flags: Private
*/
private function function_49091c27()
{
	challenge = zm_trial::function_a36e8c38(#"hash_250115340b2e27a5");
	/#
		assert(isdefined(challenge));
	#/
	new_health = self.health + challenge.var_97330ad2;
	self.health = int(math::clamp(floor(new_health), 0, max(self.maxhealth, self.var_66cb03ad)));
}

/*
	Name: function_138aec8e
	Namespace: namespace_a476311c
	Checksum: 0x6A3C5DB9
	Offset: 0x640
	Size: 0xCC
	Parameters: 1
	Flags: Private
*/
private function function_138aec8e(attacker)
{
	if(isdefined(self.nuked) && self.nuked)
	{
		foreach(player in getplayers())
		{
			player function_49091c27();
		}
		return;
	}
	if(isplayer(attacker))
	{
		attacker function_49091c27();
	}
}

