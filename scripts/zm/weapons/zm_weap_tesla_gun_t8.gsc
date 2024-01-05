// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace zm_weap_tesla_gun_t8;

/*
	Name: __init__system__
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0xAD1D1458
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"tesla_gun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0x4C1CE5CA
	Offset: 0x120
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.w_tesla_gun_t8 = getweapon(#"ww_tesla_gun_t8");
	level.w_tesla_gun_t8_upgraded = getweapon(#"ww_tesla_gun_t8_upgraded");
	level.s_tesla_gun = spawnstruct();
	level.s_tesla_gun.base = spawnstruct();
	level.s_tesla_gun.upgraded = spawnstruct();
	level.s_tesla_gun.base.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	level.s_tesla_gun.upgraded.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	zm::function_84d343d(#"ww_tesla_gun_t8", &function_5ff12a45);
	zm::function_84d343d(#"ww_tesla_gun_t8_upgraded", &function_52d66433);
	callback::on_weapon_change(&on_weapon_change);
	clientfield::register("toplayer", "" + #"hash_611f27e5d51d036f", 28000, 1, "int");
}

/*
	Name: function_5ff12a45
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0x6286CAFE
	Offset: 0x2F8
	Size: 0xA0
	Parameters: 12
	Flags: Linked
*/
function function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	self function_de59b16a(attacker, meansofdeath, level.s_tesla_gun.base.var_38cd3d0e);
	return damage;
}

/*
	Name: function_52d66433
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0x20E9EBCE
	Offset: 0x3A0
	Size: 0xA0
	Parameters: 12
	Flags: Linked
*/
function function_52d66433(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	self function_de59b16a(attacker, meansofdeath, level.s_tesla_gun.upgraded.var_38cd3d0e);
	return damage;
}

/*
	Name: on_weapon_change
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0xF11A83A2
	Offset: 0x448
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function on_weapon_change(s_params)
{
	if(is_tesla_gun(s_params.weapon))
	{
		clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 1);
	}
	else if(is_tesla_gun(s_params.last_weapon))
	{
		clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 0);
	}
}

/*
	Name: function_de59b16a
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0x892C1FBA
	Offset: 0x4F8
	Size: 0xAC
	Parameters: 3
	Flags: Linked
*/
function function_de59b16a(e_source, str_mod, var_8e05c280)
{
	if(isplayer(e_source) && (str_mod == "MOD_PROJECTILE" || str_mod == "MOD_PROJECTILE_SPLASH") && !self ai::is_stunned())
	{
		e_source.tesla_enemies_hit = 1;
		self lightning_chain::arc_damage(self, e_source, 1, var_8e05c280);
	}
}

/*
	Name: is_tesla_gun
	Namespace: zm_weap_tesla_gun_t8
	Checksum: 0x39A4D06A
	Offset: 0x5B0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function is_tesla_gun(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.w_tesla_gun_t8 || w_weapon == level.w_tesla_gun_t8_upgraded);
}

