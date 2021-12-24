// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_460f2e04fb3cff8a;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_aat_brain_decay;

/*
	Name: function_89f2df9
	Namespace: zm_aat_brain_decay
	Checksum: 0xEE22878F
	Offset: 0x178
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("zm_aat_brain_decay", &__init__, undefined, #"aat");
}

/*
	Name: __init__
	Namespace: zm_aat_brain_decay
	Checksum: 0x705A4883
	Offset: 0x1C0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.aat_in_use) && level.aat_in_use))
	{
		return;
	}
	aat::register("zm_aat_brain_decay", 0.25, 0, 48, 5, 0, &result, "t7_hud_zm_aat_turned", "wpn_aat_turned_plr", &function_682e5375, 1);
	clientfield::register("actor", "zm_aat_brain_decay", 1, 1, "int");
	clientfield::register("vehicle", "zm_aat_brain_decay", 1, 1, "int");
	clientfield::register("actor", "zm_aat_brain_decay_exp", 1, 1, "counter");
	clientfield::register("vehicle", "zm_aat_brain_decay_exp", 1, 1, "counter");
}

/*
	Name: result
	Namespace: zm_aat_brain_decay
	Checksum: 0xB4573EFD
	Offset: 0x310
	Size: 0x1EC
	Parameters: 4
	Flags: Linked
*/
function result(death, attacker, mod, weapon)
{
	self thread clientfield::set("zm_aat_brain_decay", 1);
	self thread zombie_death_time_limit(attacker, weapon);
	self.team = #"allies";
	self.aat_turned = 1;
	self.n_aat_turned_zombie_kills = 0;
	self.var_16d0eb06 = 20000;
	self.takedamage = 0;
	self.allowdeath = 0;
	self.allowpain = 0;
	self.b_ignore_cleanup = 1;
	if(self.archetype === #"zombie")
	{
		self zombie_utility::set_zombie_run_cycle("super_sprint");
		if(math::cointoss())
		{
			if(self.zombie_arms_position == "up")
			{
				self.variant_type = 6;
			}
			else
			{
				self.variant_type = 7;
			}
		}
		else if(self.zombie_arms_position == "up")
		{
			self.variant_type = 7;
		}
		else
		{
			self.variant_type = 8;
		}
	}
	if(isplayer(attacker))
	{
		attacker zm_stats::increment_challenge_stat(#"hash_6196f68daba14ab0");
		self.var_443d78cc = attacker;
	}
	self thread function_8e97a3a4(attacker, weapon);
	self thread zombie_kill_tracker(attacker);
}

/*
	Name: function_8e97a3a4
	Namespace: zm_aat_brain_decay
	Checksum: 0xD9DAECFB
	Offset: 0x508
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function function_8e97a3a4(attacker, weapon)
{
	var_3c9de13d = self.origin;
	a_ai_zombies = array::get_all_closest(var_3c9de13d, getaiteamarray(#"axis"), undefined, undefined, 90);
	if(!isdefined(a_ai_zombies))
	{
		return;
	}
	var_2cc3b86b = 8100;
	n_flung_zombies = 0;
	for(i = 0; i < a_ai_zombies.size; i++)
	{
		if(!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i]))
		{
			continue;
		}
		if(isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype])
		{
			continue;
		}
		if(a_ai_zombies[i] == self)
		{
			continue;
		}
		v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
		if(distancesquared(var_3c9de13d, v_curr_zombie_origin) > var_2cc3b86b)
		{
			continue;
		}
		a_ai_zombies[i] function_fef86dd4(var_3c9de13d, 20000, attacker, weapon);
		n_flung_zombies++;
		if(-1 && n_flung_zombies >= 3)
		{
			break;
		}
	}
}

/*
	Name: function_fef86dd4
	Namespace: zm_aat_brain_decay
	Checksum: 0x4BE31D57
	Offset: 0x718
	Size: 0x164
	Parameters: 4
	Flags: Linked, Private
*/
private function function_fef86dd4(var_c5ad44f1, n_damage, e_attacker, weapon)
{
	if(namespace_25f0796c::is_active())
	{
		return;
	}
	v_curr_zombie_origin = self getcentroid();
	self dodamage(n_damage, v_curr_zombie_origin, e_attacker, e_attacker, undefined, "MOD_AAT", 0, weapon);
	if(isalive(self))
	{
		self zombie_utility::setup_zombie_knockdown(var_c5ad44f1);
	}
	else
	{
		n_random_x = randomfloatrange(-3, 3);
		n_random_y = randomfloatrange(-3, 3);
		self startragdoll(1);
		self launchragdoll(60 * (vectornormalize((v_curr_zombie_origin - var_c5ad44f1) + (n_random_x, n_random_y, 10))), "torso_lower");
	}
}

/*
	Name: function_682e5375
	Namespace: zm_aat_brain_decay
	Checksum: 0x8566CAC5
	Offset: 0x888
	Size: 0x126
	Parameters: 0
	Flags: Linked
*/
function function_682e5375()
{
	if(isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_direct[self.archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_direct[self.archetype])
	{
		return 0;
	}
	if(isdefined(self.barricade_enter) && self.barricade_enter)
	{
		return 0;
	}
	if(isdefined(self.is_traversing) && self.is_traversing)
	{
		return 0;
	}
	if(isdefined(self.var_69a981e6) && self.var_69a981e6)
	{
		return 0;
	}
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		return 0;
	}
	if(isdefined(self.is_leaping) && self.is_leaping)
	{
		return 0;
	}
	if(isdefined(level.var_b897ed83) && !self [[level.var_b897ed83]]())
	{
		return 0;
	}
	return 1;
}

/*
	Name: zombie_death_time_limit
	Namespace: zm_aat_brain_decay
	Checksum: 0x2D809D31
	Offset: 0x9B8
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function zombie_death_time_limit(e_attacker, weapon)
{
	self endon(#"death");
	level endon_callback(&function_a22e41ec, #"end_game", #"restart_round");
	self waittill_timeout(8, #"hash_1bbb03bd582e937f");
	var_8651a024 = self getcentroid();
	self clientfield::set("zm_aat_brain_decay", 0);
	self clientfield::increment("zm_aat_brain_decay_exp", 1);
	waitframe(1);
	self.takedamage = 1;
	self.allowdeath = 1;
	self zombie_death_explosion(var_8651a024, e_attacker, weapon);
	self zombie_death_gib(e_attacker, weapon);
}

/*
	Name: function_a22e41ec
	Namespace: zm_aat_brain_decay
	Checksum: 0x45850472
	Offset: 0xAF0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_a22e41ec(var_5a5260d8)
{
	if(!isdefined(level.ai))
	{
		return;
	}
	self notify("dad16f153c7d14b");
	self endon("dad16f153c7d14b");
	ai_zombies = getaiteamarray(#"axis", #"allies");
	foreach(ai in ai_zombies)
	{
		if(isalive(ai) && (isdefined(ai.aat_turned) && ai.aat_turned))
		{
			ai.takedamage = 1;
			ai.allowdeath = 1;
			waitframe(1);
			if(isalive(ai))
			{
				ai kill();
			}
		}
	}
}

/*
	Name: zombie_death_explosion
	Namespace: zm_aat_brain_decay
	Checksum: 0xFC2F5FF2
	Offset: 0xC58
	Size: 0x206
	Parameters: 3
	Flags: Linked
*/
function zombie_death_explosion(var_58928a4b, e_attacker, weapon)
{
	a_ai_zombies = array::get_all_closest(var_58928a4b, getaiteamarray(#"axis"), undefined, undefined, 160);
	if(!isdefined(a_ai_zombies))
	{
		return;
	}
	var_2cc3b86b = 25600;
	n_flung_zombies = 0;
	for(i = 0; i < a_ai_zombies.size; i++)
	{
		if(!isdefined(a_ai_zombies[i]) || !isalive(a_ai_zombies[i]))
		{
			continue;
		}
		if(isdefined(level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype]) && level.aat[#"zm_aat_brain_decay"].immune_result_indirect[a_ai_zombies[i].archetype])
		{
			continue;
		}
		if(a_ai_zombies[i] == self)
		{
			continue;
		}
		v_curr_zombie_origin = a_ai_zombies[i] getcentroid();
		if(distancesquared(var_58928a4b, v_curr_zombie_origin) > var_2cc3b86b)
		{
			continue;
		}
		a_ai_zombies[i] function_fef86dd4(var_58928a4b, 20000, e_attacker, weapon);
		util::wait_network_frame(randomintrange(1, 3));
	}
}

/*
	Name: zombie_kill_tracker
	Namespace: zm_aat_brain_decay
	Checksum: 0xDDF69AD2
	Offset: 0xE68
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function zombie_kill_tracker(e_attacker)
{
	self endon(#"death");
	var_a57adbdc = 1;
	while(self.n_aat_turned_zombie_kills < 6)
	{
		if(!isdefined(self.favoriteenemy))
		{
			if(!var_a57adbdc)
			{
				break;
			}
			var_a57adbdc = 0;
		}
		else
		{
			var_a57adbdc = 1;
		}
		wait(1);
	}
	self notify(#"hash_1bbb03bd582e937f");
}

/*
	Name: zombie_death_gib
	Namespace: zm_aat_brain_decay
	Checksum: 0xEAB78241
	Offset: 0xEF8
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function zombie_death_gib(e_attacker, weapon)
{
	gibserverutils::gibhead(self);
	if(math::cointoss())
	{
		gibserverutils::gibleftarm(self);
	}
	else
	{
		gibserverutils::gibrightarm(self);
	}
	gibserverutils::giblegs(self);
	if(isdefined(level.headshots_only) && level.headshots_only || namespace_25f0796c::is_active())
	{
		self kill();
	}
	else
	{
		self dodamage(self.health, self.origin, e_attacker, undefined, undefined, "MOD_AAT", 0, weapon);
	}
}

