// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_8f0f0dc0;

/*
	Name: __init__system__
	Namespace: namespace_8f0f0dc0
	Checksum: 0x174779B7
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"hash_36f0f2f7d5c7cbfa", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8f0f0dc0
	Checksum: 0x99FD494A
	Offset: 0x118
	Size: 0x32C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_a3e665cc = getweapon(#"hash_166200a2e04510f4");
	level.var_7f6e8568 = getweapon(#"hash_3fec64a2af587850");
	level.var_cf62bc7a = getweapon(#"hash_1b92c0a29a45b07c");
	level.var_e724fe4e = getweapon(#"hash_a2556a2905fd952");
	level.var_b1805d48 = array(getweapon(#"hash_7a42b57be462143f"), getweapon(#"hash_7264d6f24a950a5b"), getweapon(#"hash_291e1c117ebbf5e6"), getweapon(#"hash_579652e2459b8c74"));
	level.var_e027f904 = array(level.var_a3e665cc, level.var_7f6e8568, level.var_cf62bc7a, level.var_e724fe4e);
	callback::function_20263b9e(&function_20263b9e);
	zm_loadout::register_lethal_grenade_for_level(#"hash_7a42b57be462143f");
	zm_loadout::register_lethal_grenade_for_level(#"hash_7264d6f24a950a5b");
	zm_loadout::register_lethal_grenade_for_level(#"hash_291e1c117ebbf5e6");
	zm_loadout::register_lethal_grenade_for_level(#"hash_579652e2459b8c74");
	zm::function_84d343d(#"hash_7a42b57be462143f", &function_23cf8077);
	zm::function_84d343d(#"hash_166200a2e04510f4", &function_23cf8077);
	zm::function_84d343d(#"hash_3fec64a2af587850", &function_23cf8077);
	zm::function_84d343d(#"hash_1b92c0a29a45b07c", &function_23cf8077);
	zm::function_84d343d(#"hash_a2556a2905fd952", &function_23cf8077);
	level thread function_ba2049f5();
}

/*
	Name: function_ba2049f5
	Namespace: namespace_8f0f0dc0
	Checksum: 0x5B963ABA
	Offset: 0x450
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_ba2049f5()
{
	level endon(#"end_game");
	level flag::wait_till("magicbox_initialized");
	w_doll = array::random(level.var_b1805d48);
	zm_weapons::function_603af7a8(w_doll);
}

/*
	Name: function_23cf8077
	Namespace: namespace_8f0f0dc0
	Checksum: 0x7DDCE58A
	Offset: 0x4C8
	Size: 0xEA
	Parameters: 12
	Flags: Linked
*/
function function_23cf8077(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(meansofdeath === "MOD_IMPACT")
	{
		return 0;
	}
	var_b1c1c5cf = zm_equipment::function_7d948481(0.1, 0.25, 1, 1);
	var_5d7b4163 = zm_equipment::function_379f6b5d(damage, var_b1c1c5cf, 1, 4, 40);
	return var_5d7b4163;
}

/*
	Name: function_20263b9e
	Namespace: namespace_8f0f0dc0
	Checksum: 0x6B767185
	Offset: 0x5C0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_20263b9e(s_params)
{
	if(function_4fbe1544(s_params.weapon))
	{
		s_params.projectile thread function_a1b7b263(self);
	}
}

/*
	Name: function_a1b7b263
	Namespace: namespace_8f0f0dc0
	Checksum: 0xA17B4AE
	Offset: 0x610
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_a1b7b263(e_player)
{
	self endon(#"death");
	e_player endon(#"death");
	var_51dacd00 = 0;
	var_4da5977e = (0, randomfloatrange(0, 360), 0);
	var_be17187b = undefined;
	var_be17187b = self waittill(#"stationary");
	wait(1);
	while(var_51dacd00 < 6)
	{
		var_5543f2a9 = array::random(level.var_e027f904);
		e_player magicgrenadetype(var_5543f2a9, self getcentroid(), get_launch_velocity(var_4da5977e), 1);
		self playsound(#"hash_23ebdfd906eaff00");
		var_4da5977e = var_4da5977e + (0, randomfloatrange(60, 180), 0);
		var_51dacd00++;
		wait(0.4);
	}
	wait(1);
	self detonate(e_player);
}

/*
	Name: get_launch_velocity
	Namespace: namespace_8f0f0dc0
	Checksum: 0xADA58355
	Offset: 0x7A0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function get_launch_velocity(var_4da5977e)
{
	v_angles = var_4da5977e + (randomfloatrange(-75, -55), 0, 0);
	v_launch = randomfloatrange(350, 400) * anglestoforward(v_angles);
	return v_launch;
}

/*
	Name: function_4fbe1544
	Namespace: namespace_8f0f0dc0
	Checksum: 0x52720EF6
	Offset: 0x820
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_4fbe1544(w_grenade)
{
	return isinarray(level.var_b1805d48, w_grenade);
}

