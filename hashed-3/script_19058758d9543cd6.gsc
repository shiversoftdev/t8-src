// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm\zm_lightning_chain.gsc;
#using scripts\zm_common\zm.gsc;

#namespace namespace_56e9194e;

/*
	Name: function_89f2df9
	Namespace: namespace_56e9194e
	Checksum: 0xAD1D1458
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"tesla_gun", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_56e9194e
	Checksum: 0x4C1CE5CA
	Offset: 0x120
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_35abdd52 = getweapon(#"hash_13a204ba6887b18f");
	level.var_669e5aa1 = getweapon(#"hash_491ff8e9d1af03a8");
	level.var_275acc95 = spawnstruct();
	level.var_275acc95.base = spawnstruct();
	level.var_275acc95.upgraded = spawnstruct();
	level.var_275acc95.base.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	level.var_275acc95.upgraded.var_38cd3d0e = lightning_chain::create_lightning_chain_params();
	zm::function_84d343d(#"hash_13a204ba6887b18f", &function_5ff12a45);
	zm::function_84d343d(#"hash_491ff8e9d1af03a8", &function_52d66433);
	callback::function_f77ced93(&function_f77ced93);
	clientfield::register("toplayer", "" + #"hash_611f27e5d51d036f", 28000, 1, "int");
}

/*
	Name: function_5ff12a45
	Namespace: namespace_56e9194e
	Checksum: 0x6286CAFE
	Offset: 0x2F8
	Size: 0xA0
	Parameters: 12
	Flags: Linked
*/
function function_5ff12a45(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	self function_de59b16a(attacker, meansofdeath, level.var_275acc95.base.var_38cd3d0e);
	return damage;
}

/*
	Name: function_52d66433
	Namespace: namespace_56e9194e
	Checksum: 0x20E9EBCE
	Offset: 0x3A0
	Size: 0xA0
	Parameters: 12
	Flags: Linked
*/
function function_52d66433(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	self function_de59b16a(attacker, meansofdeath, level.var_275acc95.upgraded.var_38cd3d0e);
	return damage;
}

/*
	Name: function_f77ced93
	Namespace: namespace_56e9194e
	Checksum: 0xF11A83A2
	Offset: 0x448
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_f77ced93(s_params)
{
	if(function_90c3317(s_params.weapon))
	{
		clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 1);
	}
	else if(function_90c3317(s_params.last_weapon))
	{
		clientfield::set_to_player("" + #"hash_611f27e5d51d036f", 0);
	}
}

/*
	Name: function_de59b16a
	Namespace: namespace_56e9194e
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
	Name: function_90c3317
	Namespace: namespace_56e9194e
	Checksum: 0x39A4D06A
	Offset: 0x5B0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_90c3317(w_weapon)
{
	return isdefined(w_weapon) && (w_weapon == level.var_35abdd52 || w_weapon == level.var_669e5aa1);
}

