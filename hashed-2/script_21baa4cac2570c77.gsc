// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_35598499769dbb3d;
#using script_460f2e04fb3cff8a;
#using script_47fb62300ac0bd60;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_stats.gsc;

#namespace zm_bgb_pop_shocks;

/*
	Name: function_89f2df9
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x7F21295E
	Offset: 0xE8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_bgb_pop_shocks", &__init__, undefined, #"bgb");
}

/*
	Name: __init__
	Namespace: zm_bgb_pop_shocks
	Checksum: 0xC87D4DC8
	Offset: 0x138
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(level.bgb_in_use) && level.bgb_in_use))
	{
		return;
	}
	bgb::register(#"zm_bgb_pop_shocks", "event", &event, undefined, undefined, undefined);
	bgb::function_430970f6(#"zm_bgb_pop_shocks", &actor_damage_override);
	bgb::function_cc303f91(#"zm_bgb_pop_shocks", &vehicle_damage_override);
	bgb::function_1fee6b3(#"zm_bgb_pop_shocks", 31);
}

/*
	Name: event
	Namespace: zm_bgb_pop_shocks
	Checksum: 0xC75A02F5
	Offset: 0x230
	Size: 0x60
	Parameters: 0
	Flags: Linked
*/
function event()
{
	self endon(#"disconnect", #"death", #"bgb_update");
	self.var_727695ba = 5;
	while(self.var_727695ba > 0)
	{
		wait(0.1);
	}
}

/*
	Name: actor_damage_override
	Namespace: zm_bgb_pop_shocks
	Checksum: 0xB760C441
	Offset: 0x298
	Size: 0xD0
	Parameters: 12
	Flags: Linked
*/
function actor_damage_override(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_MELEE" && !namespace_25f0796c::is_active() && !namespace_2ba51478::is_hero_weapon(weapon) && weapon != level.weaponnone)
	{
		attacker function_40383770(self);
	}
	return damage;
}

/*
	Name: vehicle_damage_override
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x9671F601
	Offset: 0x370
	Size: 0xC8
	Parameters: 15
	Flags: Linked
*/
function vehicle_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(smeansofdeath === "MOD_MELEE" && !namespace_2ba51478::is_hero_weapon(weapon))
	{
		eattacker function_40383770(self);
	}
	return idamage;
}

/*
	Name: function_40383770
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x96DCAE
	Offset: 0x440
	Size: 0x1A8
	Parameters: 1
	Flags: Linked
*/
function function_40383770(target)
{
	if(isdefined(self.beastmode) && self.beastmode)
	{
		return;
	}
	self bgb::do_one_shot_use();
	self.var_727695ba = self.var_727695ba - 1;
	self bgb::set_timer(self.var_727695ba, 5);
	self playsound(#"zmb_bgb_popshocks_impact");
	zombie_list = getaiteamarray(level.zombie_team);
	foreach(ai in zombie_list)
	{
		if(!isdefined(ai) || !isalive(ai))
		{
			continue;
		}
		test_origin = ai getcentroid();
		dist_sq = distancesquared(target.origin, test_origin);
		if(dist_sq < 16384)
		{
			self thread electrocute_actor(ai);
		}
	}
}

/*
	Name: electrocute_actor
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x554ADE41
	Offset: 0x5F0
	Size: 0x15A
	Parameters: 1
	Flags: Linked
*/
function electrocute_actor(ai)
{
	self endon(#"disconnect");
	if(!isdefined(ai) || !isalive(ai))
	{
		return;
	}
	if(!isdefined(ai.var_6f84b820))
	{
		return;
	}
	function_6eac4ca1(ai, "electrocute");
	ai notify(#"bhtn_action_notify", {#action:"electrocute"});
	if(!isdefined(self.tesla_enemies_hit))
	{
		self.tesla_enemies_hit = 1;
	}
	function_3dfe10bf();
	ai.tesla_death = 0;
	ai thread function_875f5f59(self);
	switch(ai.var_6f84b820)
	{
		case "popcorn":
		case "basic":
		case "enhanced":
		{
			ai thread tesla_death(self);
			break;
		}
	}
}

/*
	Name: function_3dfe10bf
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x16C74E98
	Offset: 0x758
	Size: 0x62
	Parameters: 0
	Flags: Linked
*/
function function_3dfe10bf()
{
	level.var_4f9d934f = lightning_chain::create_lightning_chain_params(5);
	level.var_4f9d934f.head_gib_chance = 100;
	level.var_4f9d934f.network_death_choke = 4;
	level.var_4f9d934f.should_kill_enemies = 0;
}

/*
	Name: function_875f5f59
	Namespace: zm_bgb_pop_shocks
	Checksum: 0xEE100CC6
	Offset: 0x7C8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_875f5f59(player)
{
	player endon(#"disconnect");
	if(self ai::is_stunned())
	{
		return;
	}
	self lightning_chain::arc_damage_ent(player, 1, level.var_4f9d934f);
}

/*
	Name: tesla_death
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x8C53C5D7
	Offset: 0x830
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function tesla_death(player)
{
	self endon(#"death");
	player endon(#"disconnect");
	self thread function_f724a242(1);
	wait(2);
	player zm_stats::increment_challenge_stat(#"hash_133575f669ffc55c");
	foreach(weapon in player getweaponslist())
	{
		if(weapon.statname == #"bowie_knife")
		{
			player stats::function_e24eec31(weapon, #"hash_657e22dcdd18da77", 1);
			player stats::inc_stat(#"hash_162f9b6a10fa7d66", weapon.name, #"hash_657e22dcdd18da77", #"statvalue", 1);
		}
	}
	self dodamage(self.health + 1, self.origin, player, undefined, undefined, "MOD_ELECTROCUTED", 0, level.var_78032351);
}

/*
	Name: function_f724a242
	Namespace: zm_bgb_pop_shocks
	Checksum: 0x8C171E23
	Offset: 0xA00
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_f724a242(random_gibs)
{
	self waittill(#"death");
	if(isdefined(self) && isactor(self))
	{
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibhead(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibleftarm(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::gibrightarm(self);
		}
		if(!random_gibs || randomint(100) < 50)
		{
			gibserverutils::giblegs(self);
		}
	}
}

