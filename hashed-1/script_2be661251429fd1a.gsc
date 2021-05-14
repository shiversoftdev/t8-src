// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1650e0411c055aa7;
#using script_2255a7ad3edc838f;
#using script_383a3b1bb18ba876;
#using script_3f9e54c7a9a7e1e2;
#using script_47f5b3a23db10e76;
#using script_4bfa1380a94b068b;
#using script_6158278c8647d8a9;
#using script_68d2ee1489345a1d;
#using script_6c8abe14025b47c4;
#using script_7347471e195b15da;
#using script_79a7e1c31a3e8cc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\bots\bot_action.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_104c3c75;

/*
	Name: function_89f2df9
	Namespace: namespace_104c3c75
	Checksum: 0xB67A7EAB
	Offset: 0x130
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_67d1c49d4f76fc41", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_104c3c75
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
}

/*
	Name: __main__
	Namespace: namespace_104c3c75
	Checksum: 0xF3E287EE
	Offset: 0x190
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level bot_action::function_66dacac1();
	level bot_action::register_weapons();
	level bot_action::function_25f1e3c1();
	level function_66dacac1();
	level register_weapons();
	level function_25f1e3c1();
}

/*
	Name: function_66dacac1
	Namespace: namespace_104c3c75
	Checksum: 0xAB322BCC
	Offset: 0x230
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_66dacac1()
{
	bot_action::register_action(#"hash_43618a52a3bededc", &bot_action::weapon_rank, &function_bcb5ef11, &bot_action::function_c27fa689);
	bot_action::register_action(#"throw_molotov", &bot_action::weapon_rank, &function_1275c409, &bot_action::function_90c011d5);
	bot_action::register_action(#"throw_grenade", &bot_action::weapon_rank, &function_32e8b358, &bot_action::function_90c011d5);
	bot_action::register_action(#"hash_207275481ec8c22b", &bot_action::weapon_rank, &function_369cb1a5, &bot_action::function_94f96101);
	bot_action::register_action(#"hash_63c5000998c406e2", &bot_action::weapon_rank, &bot_action::function_39317d6e, &bot_action::test_gadget);
	bot_action::register_action(#"hash_7f17997c50415cb7", &bot_action::weapon_rank, &bot_action::function_30636b1c, &bot_action::test_gadget);
	bot_action::register_action(#"hash_291f02a64600bb72", &bot_action::weapon_rank, &bot_action::function_38d0d1df, &bot_action::test_gadget);
	if(!function_f99d2668())
	{
		self function_938667bd();
		self function_d47799c8();
	}
}

/*
	Name: register_weapons
	Namespace: namespace_104c3c75
	Checksum: 0x516F33BD
	Offset: 0x4B0
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function register_weapons()
{
	bot_action::register_weapon(#"knife_held", &bot_action::function_d31777fa);
	bot_action::register_weapon(#"bare_hands", &bot_action::function_d31777fa);
	bot_action::function_f4302f2a(#"gadget_health_regen", &bot_action::function_2c39b990, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"gadget_medicalinjectiongun", &bot_action::function_2c39b990, &bot_action::function_a9847723);
	self function_b7cdffc();
	self function_d5ef6ef3();
	self function_c2e797aa();
}

/*
	Name: function_25f1e3c1
	Namespace: namespace_104c3c75
	Checksum: 0x184A97B1
	Offset: 0x5E8
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_25f1e3c1()
{
	bot_action::function_a2c83569(#"knife_held", #"melee_enemy");
	bot_action::function_a2c83569(#"bare_hands", #"melee_enemy");
	bot_action::function_7e847a84(#"gadget_health_regen", #"hash_43618a52a3bededc");
	bot_action::function_7e847a84(#"gadget_medicalinjectiongun", #"hash_43618a52a3bededc");
	self function_aaede90c();
	self function_aa5475f();
	self function_865733c1();
}

/*
	Name: function_938667bd
	Namespace: namespace_104c3c75
	Checksum: 0x751E4CAA
	Offset: 0x700
	Size: 0x464
	Parameters: 0
	Flags: Linked
*/
function function_938667bd()
{
	bot_action::register_action(#"hash_5397239dd3c8da8d", &bot_action::weapon_rank, &function_c98fad6b, &function_74ab5468);
	bot_action::register_action(#"hash_6fbd1b1c42e3a0c5", &bot_action::weapon_rank, &function_1c7ea685, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_506cd36e6a959fa", &bot_action::weapon_rank, &function_7fa22be8, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_49634476519ac7ef", &bot_action::weapon_rank, &function_65b9c7c2, &function_8a5ad584);
	bot_action::register_action(#"hash_608f00ec5bc65e5b", &bot_action::weapon_rank, &function_d18123f8, &function_d2f7890);
	bot_action::register_action(#"hash_be5c1efd10adca1", &bot_action::weapon_rank, &bot_action::function_38d0d1df, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_4600e058d958fc21", &bot_action::weapon_rank, &function_17a8721f, &function_76c8b8e8);
	bot_action::register_action(#"hash_2ca8b8806f95285b", &bot_action::weapon_rank, &bot_action::function_38d0d1df, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_79f1bffaa4e2fbd8", &bot_action::weapon_rank, &function_554a6177, &function_65bade);
	bot_action::register_action(#"hash_6b075b8b88b1cef", &bot_action::weapon_rank, &function_97e7772c, &bot_action::function_94f96101);
	bot_action::register_action(#"hash_43d2b48fb33f50f2", &bot_action::weapon_rank, &function_9a0eb4f0, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_17f1a25f8c10e1cd", &bot_action::weapon_rank, &function_4a95cdaf, &bot_action::function_49161e05);
	bot_action::register_action(#"hash_5d6b13cfb592ee04", &bot_action::weapon_rank, &function_e43892c4, &function_79988b4b);
	bot_action::register_action(#"hash_7d4b6d8a21219335", &bot_action::weapon_rank, &bot_action::function_38d0d1df, &function_9553fd90);
}

/*
	Name: function_d47799c8
	Namespace: namespace_104c3c75
	Checksum: 0x8D17A214
	Offset: 0xB70
	Size: 0x4B4
	Parameters: 0
	Flags: Linked
*/
function function_d47799c8()
{
	bot_action::register_action(#"ac130", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"tank_robot", &bot_action::function_3df363bf, &function_d2107b, &function_8f5d7136);
	bot_action::register_action(#"counteruav", &bot_action::function_3df363bf, &function_6f232284, &function_39c29cdd);
	bot_action::register_action(#"dart", &bot_action::function_3df363bf, &function_85f39927, &function_7d799351);
	bot_action::register_action(#"drone_squadron", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"helicopter_comlink", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"overwatch_helicopter", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"planemortar", &bot_action::function_3df363bf, &function_66e1a1ca, &function_942b5513);
	bot_action::register_action(#"recon_car", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"remote_missile", &bot_action::function_3df363bf, &function_66e1a1ca, &function_27f291e1);
	bot_action::register_action(#"straferun", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"supply_drop", &bot_action::function_3df363bf, &function_d2107b, &function_8f5d7136);
	bot_action::register_action(#"swat_team", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"uav", &bot_action::function_3df363bf, &function_66e1a1ca, &function_39c29cdd);
	bot_action::register_action(#"ultimate_turret", &bot_action::function_3df363bf, &function_f90909b9, &function_883edf75);
}

/*
	Name: function_b7cdffc
	Namespace: namespace_104c3c75
	Checksum: 0x87AE50CF
	Offset: 0x1030
	Size: 0x684
	Parameters: 0
	Flags: Linked
*/
function function_b7cdffc()
{
	bot_action::function_f4302f2a(#"eq_swat_grenade", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"sig_buckler_dw", &bot_action::function_1879a202, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"eq_cluster_semtex_grenade", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hero_pineapplegun", &bot_action::function_1879a202, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"gadget_supplypod", &bot_action::function_1879a202, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"eq_localheal", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"gadget_radiation_field", &bot_action::function_1879a202, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hero_flamethrower", &bot_action::function_2c39b990, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"eq_tripwire", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"ability_dog", &bot_action::function_1879a202, &bot_action::function_8171a298);
	bot_action::function_f4302f2a(#"eq_hawk", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hash_40380537847df901", &bot_action::function_1879a202, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"hash_4a4ba36128b6582f", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"shock_rifle", &bot_action::function_1879a202, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"eq_sensor", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"gadget_vision_pulse", &bot_action::function_1879a202, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hash_3a19c6a9c8caef33", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hash_4bb2d7f789b561eb", &bot_action::function_1879a202, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"gadget_spawnbeacon", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hero_annihilator", &bot_action::function_2c39b990, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"eq_smoke", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"sig_blade", &bot_action::function_1879a202, &bot_action::function_ec16df22);
	bot_action::function_f4302f2a(#"eq_concertina_wire", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"ability_smart_cover", &bot_action::function_1879a202, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hash_21b346649d376bf3", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"gadget_icepick", &bot_action::function_1879a202, &bot_action::function_ec16df22);
}

/*
	Name: function_d5ef6ef3
	Namespace: namespace_104c3c75
	Checksum: 0x8E1AF72F
	Offset: 0x16C0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_d5ef6ef3()
{
	bot_action::function_f4302f2a(#"eq_molotov", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"eq_sticky_grenade", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"eq_slow_grenade", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"frag_grenade", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"hatchet", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
	bot_action::function_f4302f2a(#"trophy_system", &bot_action::registermus_gramophone_electricreactidgunterminate, &bot_action::function_a9847723);
}

/*
	Name: function_c2e797aa
	Namespace: namespace_104c3c75
	Checksum: 0x2460E7C6
	Offset: 0x1850
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function function_c2e797aa()
{
	bot_action::function_c67ea19e(#"ac130", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"ai_tank_marker", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"counteruav", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"dart", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"drone_squadron", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"helicopter_comlink", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"overwatch_helicopter", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"planemortar", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"recon_car", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"remote_missile", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"straferun", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"supplydrop_marker", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"swat_team", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"uav", &bot_action::function_791f5097, &bot_action::function_29163ca5);
	bot_action::function_c67ea19e(#"ultimate_turret", &bot_action::function_791f5097, &bot_action::function_29163ca5);
}

/*
	Name: function_aaede90c
	Namespace: namespace_104c3c75
	Checksum: 0x1649F8FF
	Offset: 0x1C20
	Size: 0x754
	Parameters: 0
	Flags: Linked
*/
function function_aaede90c()
{
	bot_action::function_7e847a84(#"eq_swat_grenade", #"throw_grenade");
	bot_action::function_7e847a84(#"sig_buckler_dw", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"sig_buckler_dw", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"sig_buckler_dw", #"hash_3d7dd2878425bcce");
	bot_action::function_7e847a84(#"eq_cluster_semtex_grenade", #"throw_grenade");
	bot_action::function_7e847a84(#"hero_pineapplegun", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"hero_pineapplegun", #"fire_grenade");
	bot_action::function_7e847a84(#"gadget_supplypod", #"hash_6fbd1b1c42e3a0c5");
	bot_action::function_7e847a84(#"eq_localheal", #"hash_506cd36e6a959fa");
	bot_action::function_7e847a84(#"gadget_radiation_field", #"hash_49634476519ac7ef");
	bot_action::function_7e847a84(#"hero_flamethrower", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"hero_flamethrower", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"hero_flamethrower", #"hash_434716893aa869f3");
	bot_action::function_7e847a84(#"eq_tripwire", #"hash_608f00ec5bc65e5b");
	bot_action::function_7e847a84(#"ability_dog", #"hash_be5c1efd10adca1");
	bot_action::function_7e847a84(#"eq_hawk", #"throw_grenade");
	bot_action::function_7e847a84(#"hash_40380537847df901", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"hash_40380537847df901", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"hash_40380537847df901", #"hash_434716893aa869f3");
	bot_action::function_7e847a84(#"hash_4a4ba36128b6582f", #"hash_207275481ec8c22b");
	bot_action::function_7e847a84(#"shock_rifle", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"shock_rifle", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"shock_rifle", #"hash_434716893aa869f3");
	bot_action::function_7e847a84(#"eq_sensor", #"hash_4600e058d958fc21");
	bot_action::function_7e847a84(#"gadget_vision_pulse", #"hash_2ca8b8806f95285b");
	bot_action::function_7e847a84(#"hash_3a19c6a9c8caef33", #"hash_79f1bffaa4e2fbd8");
	bot_action::function_7e847a84(#"hash_4bb2d7f789b561eb", #"hash_6b075b8b88b1cef");
	bot_action::function_7e847a84(#"gadget_spawnbeacon", #"hash_43d2b48fb33f50f2");
	bot_action::function_7e847a84(#"hero_annihilator", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"hero_annihilator", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"hero_annihilator", #"hash_434716893aa869f3");
	bot_action::function_7e847a84(#"eq_smoke", #"throw_grenade");
	bot_action::function_7e847a84(#"sig_blade", #"hash_5397239dd3c8da8d");
	bot_action::function_a2c83569(#"sig_blade", #"hash_7aaeac32a4e1bf84");
	bot_action::function_a2c83569(#"sig_blade", #"hash_434716893aa869f3");
	bot_action::function_7e847a84(#"eq_concertina_wire", #"hash_17f1a25f8c10e1cd");
	bot_action::function_7e847a84(#"ability_smart_cover", #"hash_5d6b13cfb592ee04");
	bot_action::function_7e847a84(#"hash_21b346649d376bf3", #"hash_207275481ec8c22b");
	bot_action::function_7e847a84(#"gadget_icepick", #"hash_7d4b6d8a21219335");
}

/*
	Name: function_aa5475f
	Namespace: namespace_104c3c75
	Checksum: 0xA1CC272F
	Offset: 0x2380
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_aa5475f()
{
	bot_action::function_7e847a84(#"eq_molotov", #"throw_molotov");
	bot_action::function_7e847a84(#"eq_sticky_grenade", #"throw_grenade");
	bot_action::function_7e847a84(#"eq_slow_grenade", #"throw_grenade");
	bot_action::function_7e847a84(#"frag_grenade", #"throw_grenade");
	bot_action::function_7e847a84(#"hatchet", #"throw_grenade");
	bot_action::function_7e847a84(#"trophy_system", #"hash_207275481ec8c22b");
}

/*
	Name: function_865733c1
	Namespace: namespace_104c3c75
	Checksum: 0x5AFB6FEE
	Offset: 0x24B0
	Size: 0x2D4
	Parameters: 0
	Flags: Linked
*/
function function_865733c1()
{
	bot_action::function_7e847a84(#"ac130", #"ac130");
	bot_action::function_7e847a84(#"ai_tank_marker", #"tank_robot");
	bot_action::function_7e847a84(#"counteruav", #"counteruav");
	bot_action::function_7e847a84(#"dart", #"dart");
	bot_action::function_7e847a84(#"drone_squadron", #"drone_squadron");
	bot_action::function_7e847a84(#"helicopter_comlink", #"helicopter_comlink");
	bot_action::function_7e847a84(#"overwatch_helicopter", #"overwatch_helicopter");
	bot_action::function_7e847a84(#"planemortar", #"planemortar");
	bot_action::function_7e847a84(#"recon_car", #"recon_car");
	bot_action::function_7e847a84(#"remote_missile", #"remote_missile");
	bot_action::function_7e847a84(#"straferun", #"straferun");
	bot_action::function_7e847a84(#"supplydrop_marker", #"supply_drop");
	bot_action::function_7e847a84(#"swat_team", #"swat_team");
	bot_action::function_7e847a84(#"uav", #"uav");
	bot_action::function_7e847a84(#"ultimate_turret", #"ultimate_turret");
}

/*
	Name: function_c98fad6b
	Namespace: namespace_104c3c75
	Checksum: 0xEC8DE589
	Offset: 0x2790
	Size: 0x23A
	Parameters: 1
	Flags: Linked
*/
function function_c98fad6b(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(!self bot::in_combat())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!isalive(self.enemy))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(self bot_action::function_b70a8fcf(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_74ab5468
	Namespace: namespace_104c3c75
	Checksum: 0x1E17AAE1
	Offset: 0x29D8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_74ab5468(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self bot_action::function_ccdcc5d9(weapon);
	while(self isswitchingweapons())
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_bcb5ef11
	Namespace: namespace_104c3c75
	Checksum: 0x41FAC79F
	Offset: 0x2A50
	Size: 0x3FA
	Parameters: 1
	Flags: Linked
*/
function function_bcb5ef11(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(isdefined(self.heal.enabled) && self.heal.enabled)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	pathenemyfightdist = self.bot.tacbundle.pathenemyfightdist;
	if(!self ai::get_behavior_attribute("ignorepathenemyfightdist") && isdefined(self.enemy) && isdefined(pathenemyfightdist) && pathenemyfightdist > 0 && distance2dsquared(self.origin, self.enemy.origin) < pathenemyfightdist * pathenemyfightdist)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + self.health + "" + self.maxhealth;
	#/
	healthratio = self.health / self.maxhealth;
	if(healthratio > self.bot.tacbundle.var_ac1c818f)
	{
		return undefined;
	}
	weapon = var_b594a2cd.weapon;
	slot = self gadgetgetslot(weapon);
	power = self gadgetpowerget(slot);
	/#
		if(!isdefined(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = [];
		}
		else if(!isarray(var_b594a2cd.debug))
		{
			var_b594a2cd.debug = array(var_b594a2cd.debug);
		}
		var_b594a2cd.debug[var_b594a2cd.debug.size] = "" + power;
	#/
	return 100;
}

/*
	Name: function_daa183ff
	Namespace: namespace_104c3c75
	Checksum: 0xDE935E02
	Offset: 0x2E58
	Size: 0x3AA
	Parameters: 3
	Flags: Linked
*/
function function_daa183ff(var_b594a2cd, var_2a213a99, var_b5aae32c)
{
	var_b594a2cd.target = self.enemy;
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(!self bot_action::function_ecf6dc7a(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot_action::function_b70a8fcf(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(var_2a213a99)
	{
		self bot_action::function_26c2bce7(var_b594a2cd, "tag_origin");
	}
	self bot_action::function_8a2b82ad(var_b594a2cd);
	if(isdefined(var_b5aae32c) && distancesquared(self.origin, var_b594a2cd.aimpoint) <= var_b5aae32c)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self bot_action::function_a3dfc4aa(var_b594a2cd);
	if(!isdefined(var_b594a2cd.var_cb785841))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	self bot_action::function_9004d3ca(var_b594a2cd);
	if(!self bot_action::function_ade341c(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_1275c409
	Namespace: namespace_104c3c75
	Checksum: 0x6CB8FDCF
	Offset: 0x3210
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_1275c409(var_b594a2cd)
{
	return self function_daa183ff(var_b594a2cd, 1, 250000);
}

/*
	Name: function_32e8b358
	Namespace: namespace_104c3c75
	Checksum: 0x88F1C7A6
	Offset: 0x3250
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_32e8b358(var_b594a2cd)
{
	return self function_daa183ff(var_b594a2cd, 0);
}

/*
	Name: function_369cb1a5
	Namespace: namespace_104c3c75
	Checksum: 0xBF18A92E
	Offset: 0x3280
	Size: 0x28A
	Parameters: 1
	Flags: Linked
*/
function function_369cb1a5(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = var_2b3b4fb.var_2cfdc66d + vectorscale((0, 0, 1), 55);
	if(distance2dsquared(target, self.origin) < 62500)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = target;
	return 100;
}

/*
	Name: function_65b9c7c2
	Namespace: namespace_104c3c75
	Checksum: 0x9B867FED
	Offset: 0x3518
	Size: 0x36A
	Parameters: 1
	Flags: Linked
*/
function function_65b9c7c2(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(!self bot_action::function_ecf6dc7a(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot_action::function_b70a8fcf(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(distance2dsquared(self.origin, self.enemy.origin) > 90000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(isdefined(self.heal.enabled) && self.heal.enabled)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	healthratio = self.health / self.maxhealth;
	if(healthratio <= self.bot.tacbundle.var_ac1c818f)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_8a5ad584
	Namespace: namespace_104c3c75
	Checksum: 0x98994A8D
	Offset: 0x3890
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function function_8a5ad584(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self bot_action::function_ccdcc5d9(weapon);
	slot = self gadgetgetslot(weapon);
	button = self function_c6e02c38(weapon);
	while(!self gadgetisactive(slot))
	{
		self bottapbutton(button);
		self waittill(#"hash_347a612b61067eb3");
	}
	while(self gadgetisactive(slot) && self.health > 20)
	{
		self bottapbutton(button);
		self waittill(#"hash_347a612b61067eb3");
	}
	while(self isthrowinggrenade() || !self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_97e7772c
	Namespace: namespace_104c3c75
	Checksum: 0x6D44FA6D
	Offset: 0x3A30
	Size: 0x1D2
	Parameters: 1
	Flags: Linked
*/
function function_97e7772c(var_b594a2cd)
{
	var_b594a2cd.target = self.enemy;
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(!self bot_action::function_ecf6dc7a(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot_action::function_b70a8fcf(var_b594a2cd))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(distance2dsquared(self.origin, self.enemy.origin) > 40000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_554a6177
	Namespace: namespace_104c3c75
	Checksum: 0x9CD1330E
	Offset: 0x3C10
	Size: 0x3DE
	Parameters: 1
	Flags: Linked
*/
function function_554a6177(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = var_2b3b4fb.var_2cfdc66d + vectorscale((0, 0, 1), 100);
	if(distance2dsquared(target, self.origin) < 40000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	eye = self geteye();
	vectotarget = vectornormalize(target - eye);
	traceend = eye + vectotarget * 2000;
	trace = bullettrace(eye, traceend, 0, self);
	if(trace[#"fraction"] >= 1)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = trace[#"position"];
	var_b594a2cd.target = target;
	return 100;
}

/*
	Name: function_65bade
	Namespace: namespace_104c3c75
	Checksum: 0x34B4C308
	Offset: 0x3FF8
	Size: 0x258
	Parameters: 1
	Flags: Linked
*/
function function_65bade(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	self waittill(#"hash_347a612b61067eb3");
	while(self botgetlookdot() < 0.99 || self istraversing())
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	self bot_action::function_ccdcc5d9(weapon);
	self waittill(#"hash_347a612b61067eb3");
	while(!self isgrappling() && self getcurrentoffhand() == weapon)
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	while(self isgrappling() && self getcurrentoffhand() == weapon)
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
}

/*
	Name: function_9a0eb4f0
	Namespace: namespace_104c3c75
	Checksum: 0x969640FC
	Offset: 0x4258
	Size: 0x2C6
	Parameters: 1
	Flags: Linked
*/
function function_9a0eb4f0(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	timesincespawn = gettime() - self.spawntime;
	if(timesincespawn < 10000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_775fe08e = getarraykeys(level.spawnbeaconsettings.userspawnbeacons);
	foreach(var_2e194e82 in var_775fe08e)
	{
		if(var_2e194e82 == self.clientid)
		{
			/#
				if(!isdefined(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = [];
				}
				else if(!isarray(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = array(var_b594a2cd.debug);
				}
				var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
			#/
			return undefined;
		}
	}
	return 100;
}

/*
	Name: function_4a95cdaf
	Namespace: namespace_104c3c75
	Checksum: 0xC8AFE69A
	Offset: 0x4528
	Size: 0x322
	Parameters: 1
	Flags: Linked
*/
function function_4a95cdaf(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = var_2b3b4fb.var_2cfdc66d;
	if(distance2dsquared(target, self.origin) > 10000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	if(!concertina_wire::function_6fe5a945(self).isvalid)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_e43892c4
	Namespace: namespace_104c3c75
	Checksum: 0x834B761C
	Offset: 0x4858
	Size: 0x28A
	Parameters: 1
	Flags: Linked
*/
function function_e43892c4(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = var_2b3b4fb.var_2cfdc66d + vectorscale((0, 0, 1), 55);
	if(distance2dsquared(target, self.origin) < 40000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = target;
	return 100;
}

/*
	Name: function_79988b4b
	Namespace: namespace_104c3c75
	Checksum: 0x24DEC538
	Offset: 0x4AF0
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_79988b4b(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	while(self botgetlookdot() < 0.999 || self istraversing())
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	self bot_action::function_ccdcc5d9(weapon);
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	self function_d4c687c9();
}

/*
	Name: function_17a8721f
	Namespace: namespace_104c3c75
	Checksum: 0x9AA64756
	Offset: 0x4CD8
	Size: 0x3CA
	Parameters: 1
	Flags: Linked
*/
function function_17a8721f(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	timesincespawn = gettime() - self.spawntime;
	if(timesincespawn < 5000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	eye = self geteye();
	forwarddir = anglestoforward(self getplayerangles());
	traceend = eye + forwarddir * 1000;
	trace = bullettrace(eye, traceend, 0, self);
	if(trace[#"fraction"] >= 1)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = trace[#"position"];
	navmeshpoint = getclosestpointonnavmesh(target, 150);
	if(!isdefined(navmeshpoint))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = target;
	return 100;
}

/*
	Name: function_76c8b8e8
	Namespace: namespace_104c3c75
	Checksum: 0x1CB5EC2E
	Offset: 0x50B0
	Size: 0x17E
	Parameters: 1
	Flags: Linked
*/
function function_76c8b8e8(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	self bot_action::function_ccdcc5d9(weapon);
	starttime = gettime();
	while(gettime() - starttime < 1000)
	{
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
		self waittill(#"hash_347a612b61067eb3");
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_7fa22be8
	Namespace: namespace_104c3c75
	Checksum: 0x2DDA49E5
	Offset: 0x5238
	Size: 0x2EA
	Parameters: 1
	Flags: Linked
*/
function function_7fa22be8(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_660b71a5 = self namespace_b5dd0093::function_45fd00c6();
	if(!isdefined(var_660b71a5))
	{
		var_660b71a5 = [];
	}
	else if(!isarray(var_660b71a5))
	{
		var_660b71a5 = array(var_660b71a5);
	}
	var_660b71a5[var_660b71a5.size] = self;
	var_7f6f772c = [];
	foreach(player in var_660b71a5)
	{
		if(isalive(player))
		{
			if(!isdefined(var_7f6f772c))
			{
				var_7f6f772c = [];
			}
			else if(!isarray(var_7f6f772c))
			{
				var_7f6f772c = array(var_7f6f772c);
			}
			var_7f6f772c[var_7f6f772c.size] = player;
		}
	}
	var_92330a71 = var_7f6f772c.size / 1 * var_660b71a5.size;
	if(var_92330a71 < 0.66)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_1c7ea685
	Namespace: namespace_104c3c75
	Checksum: 0xB3861BC8
	Offset: 0x5530
	Size: 0x3EA
	Parameters: 1
	Flags: Linked
*/
function function_1c7ea685(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_9f517317 = 0;
	primaryweapons = self getweaponslistprimaries();
	foreach(primaryweapon in primaryweapons)
	{
		ammo = self getammocount(primaryweapon);
		startammo = primaryweapon.startammo;
		var_82117cc3 = startammo - ammo;
		if(var_82117cc3 >= primaryweapon.clipsize)
		{
			var_9f517317 = 1;
			break;
		}
	}
	if(!var_9f517317)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	player_pos = self.origin;
	player_angles = self getplayerangles();
	player_eye_pos = self geteye();
	ignore_entity = undefined;
	weapon = var_b594a2cd.weapon;
	results = deployable::function_54d27855(player_pos, player_angles, player_eye_pos, weapon, ignore_entity);
	gameplay_allows_deploy = supplypod::function_1f8cd247(results.origin, results.angles, self);
	if(!gameplay_allows_deploy)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	return 100;
}

/*
	Name: function_d18123f8
	Namespace: namespace_104c3c75
	Checksum: 0x68AD225A
	Offset: 0x5928
	Size: 0x422
	Parameters: 1
	Flags: Linked
*/
function function_d18123f8(var_b594a2cd)
{
	if(!self bot_action::function_5de4c088(var_b594a2cd))
	{
		return undefined;
	}
	if(self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = vectorlerp(var_2b3b4fb.var_2cfdc66d, var_2b3b4fb.var_c78b4464, 0.5) + vectorscale((0, 0, 1), 50);
	eye = self geteye();
	trace = bullettrace(eye, target, 0, self);
	target = trace[#"position"];
	if(distance2dsquared(target, self.origin) > 10000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_f52a3a89 = vectorcross(var_2b3b4fb.var_c78b4464 - self.origin, var_2b3b4fb.var_2cfdc66d - self.origin);
	direction = self getplayerangles();
	offsetvec = vectorcross(var_2b3b4fb.var_2cfdc66d - self.origin, anglestoup(direction));
	if(var_f52a3a89[2] < 0)
	{
		offsetvec = vectorscale(offsetvec, -1);
	}
	offsetvec = vectornormalize(offsetvec);
	offsetvec = vectorscale(offsetvec, 200) + vectorscale((0, 0, 1), 25);
	var_b594a2cd.target = target;
	var_b594a2cd.target2 = target + offsetvec;
	return 100;
}

/*
	Name: function_d2f7890
	Namespace: namespace_104c3c75
	Checksum: 0x74B7318A
	Offset: 0x5D58
	Size: 0x35E
	Parameters: 1
	Flags: Linked
*/
function function_d2f7890(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	button = self function_c6e02c38(weapon);
	if(!isdefined(weapon))
	{
		/#
			self botprinterror("" + "");
		#/
		self waittill(#"hash_347a612b61067eb3");
		return;
	}
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	self waittill(#"hash_347a612b61067eb3");
	while(self botgetlookdot() < 0.99 || self istraversing())
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	self bot_action::function_ccdcc5d9(weapon);
	self waittill(#"tripwire_spawn");
	var_c7b51a54 = gettime();
	var_b594a2cd.target = var_b594a2cd.target2;
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	self waittill(#"hash_347a612b61067eb3");
	while(self botgetlookdot() < 0.99 || self istraversing() || gettime() - var_c7b51a54 < 1000)
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	self bottapbutton(button);
	self waittill(#"hash_347a612b61067eb3");
	if(!self isswitchingweapons())
	{
		self bottapbutton(71);
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_9553fd90
	Namespace: namespace_104c3c75
	Checksum: 0x2A23CC31
	Offset: 0x60C0
	Size: 0x13E
	Parameters: 1
	Flags: Linked
*/
function function_9553fd90(var_b594a2cd)
{
	weapon = var_b594a2cd.weapon;
	self bot_action::function_ccdcc5d9(weapon);
	while(self isswitchingweapons() || !self function_a39f313c())
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	while(self getcurrentweapon() == weapon && !self isswitchingweapons())
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_9c943ad6
	Namespace: namespace_104c3c75
	Checksum: 0x92DF4316
	Offset: 0x6208
	Size: 0x362
	Parameters: 2
	Flags: Linked
*/
function function_9c943ad6(var_b594a2cd, var_af50df89)
{
	if(!self bot_action::function_e7fa3d0())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 0;
	}
	var_87b53013 = var_b594a2cd.action.name;
	scorestreakweapon = var_b594a2cd.weapon;
	haskillstreak = self killstreaks::has_killstreak(var_87b53013);
	var_96648639 = self killstreaks::get_killstreak_quantity(scorestreakweapon) > 0;
	var_e8992218 = haskillstreak || var_96648639;
	if(!var_e8992218)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 0;
	}
	if(self killstreakrules::iskillstreakallowed(var_87b53013, self.team) == 0)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 0;
	}
	if(var_af50df89 == self bot::has_visible_enemy())
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_66e1a1ca
	Namespace: namespace_104c3c75
	Checksum: 0x3F252350
	Offset: 0x6578
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_66e1a1ca(var_b594a2cd)
{
	if(!function_9c943ad6(var_b594a2cd, 1))
	{
		return undefined;
	}
	return 100;
}

/*
	Name: function_85f39927
	Namespace: namespace_104c3c75
	Checksum: 0xAA516245
	Offset: 0x65B0
	Size: 0x2E
	Parameters: 1
	Flags: Linked
*/
function function_85f39927(var_b594a2cd)
{
	if(!function_9c943ad6(var_b594a2cd, 0))
	{
		return undefined;
	}
	return 100;
}

/*
	Name: function_6f232284
	Namespace: namespace_104c3c75
	Checksum: 0xE16BC175
	Offset: 0x65E8
	Size: 0x2CA
	Parameters: 1
	Flags: Linked
*/
function function_6f232284(var_b594a2cd)
{
	if(!function_9c943ad6(var_b594a2cd, 1))
	{
		return undefined;
	}
	if(level.teambased)
	{
		var_e2448ab6 = 0;
		foreach(team in level.teams)
		{
			if(isdefined(self.team) && util::function_fbce7263(self.team, team) && killstreaks::hasuav(team))
			{
				var_e2448ab6 = 1;
			}
		}
		if(!var_e2448ab6)
		{
			/#
				if(!isdefined(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = [];
				}
				else if(!isarray(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = array(var_b594a2cd.debug);
				}
				var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
			#/
			return undefined;
		}
	}
	else
	{
		foreach(enabled, var_c63b8638 in level.activeuavs)
		{
			var_1836afa = 0;
			if(enabled && var_c63b8638 != self.entnum)
			{
				var_1836afa = 1;
			}
		}
		if(!var_1836afa)
		{
			/#
				if(!isdefined(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = [];
				}
				else if(!isarray(var_b594a2cd.debug))
				{
					var_b594a2cd.debug = array(var_b594a2cd.debug);
				}
				var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
			#/
			return undefined;
		}
	}
	return 100;
}

/*
	Name: function_d2107b
	Namespace: namespace_104c3c75
	Checksum: 0xD5A8BBE1
	Offset: 0x68C0
	Size: 0x592
	Parameters: 1
	Flags: Linked
*/
function function_d2107b(var_b594a2cd)
{
	if(!function_9c943ad6(var_b594a2cd, 1))
	{
		return undefined;
	}
	if(isdefined(self.var_3f8901ac) && gettime() - self.var_3f8901ac < 5000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_7607a546 = function_ad6356f5(self.origin);
	if(!isdefined(var_7607a546))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	cylinder = ai::t_cylinder(self.origin, 512, 512);
	var_e50a845c = tacticalquery("stratcom_tacquery_position", cylinder);
	var_6fa334a7 = array::randomize(var_e50a845c);
	botdir = anglestoforward(self getplayerangles());
	var_ff975a6 = vectornormalize(botdir * (1, 1, 0));
	var_c375900c = undefined;
	foreach(point in var_6fa334a7)
	{
		if(function_96c81b85(var_7607a546, point.origin))
		{
			var_4102ab31 = vectornormalize(point.origin - self.origin * (1, 1, 0));
			dot = vectordot(var_4102ab31, var_ff975a6);
			if(dot > 0.707)
			{
				var_c375900c = point;
				break;
			}
		}
	}
	if(!isdefined(var_c375900c))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	mask = 1;
	from = var_c375900c.origin + vectorscale((0, 0, 1), 10);
	to = var_c375900c.origin + vectorscale((0, 0, 1), 2000);
	trace = physicstrace(from, to, vectorscale((-1, -1, 0), 50), (50, 50, 100), undefined, mask);
	if(trace[#"fraction"] < 1)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = var_c375900c.origin + vectorscale((0, 0, 1), 20);
	return 100;
}

/*
	Name: function_f90909b9
	Namespace: namespace_104c3c75
	Checksum: 0x78A79772
	Offset: 0x6E60
	Size: 0x1DA
	Parameters: 1
	Flags: Linked
*/
function function_f90909b9(var_b594a2cd)
{
	if(!function_9c943ad6(var_b594a2cd, 1))
	{
		return undefined;
	}
	var_2b3b4fb = self function_f04bd922();
	if(!isdefined(var_2b3b4fb))
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	target = var_2b3b4fb.var_2cfdc66d + vectorscale((0, 0, 1), 55);
	if(distance2dsquared(target, self.origin) < 40000)
	{
		/#
			if(!isdefined(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = [];
			}
			else if(!isarray(var_b594a2cd.debug))
			{
				var_b594a2cd.debug = array(var_b594a2cd.debug);
			}
			var_b594a2cd.debug[var_b594a2cd.debug.size] = "";
		#/
		return undefined;
	}
	var_b594a2cd.target = target;
	return 100;
}

/*
	Name: function_39c29cdd
	Namespace: namespace_104c3c75
	Checksum: 0x728C933
	Offset: 0x7048
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function function_39c29cdd(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self bot_action::function_11c3d810(scorestreakweapon);
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_8f5d7136
	Namespace: namespace_104c3c75
	Checksum: 0x11F61C9E
	Offset: 0x70E8
	Size: 0x224
	Parameters: 1
	Flags: Linked
*/
function function_8f5d7136(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	self bot_action::function_11c3d810(scorestreakweapon);
	while(!self function_a39f313c() || self getcurrentweapon() != scorestreakweapon)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	wait(0.5);
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	while(self botgetlookdot() < 0.999 || self istraversing())
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	self bottapbutton(0);
	self.var_3f8901ac = gettime();
	while(!self function_a39f313c() || self getcurrentweapon() == scorestreakweapon || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	self function_d4c687c9();
}

/*
	Name: function_942b5513
	Namespace: namespace_104c3c75
	Checksum: 0x1E96F80E
	Offset: 0x7318
	Size: 0x31E
	Parameters: 1
	Flags: Linked
*/
function function_942b5513(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self bot_action::function_11c3d810(scorestreakweapon);
	while(!self function_a39f313c() || self getcurrentweapon() != scorestreakweapon)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	shots_fired = 0;
	enemies = self teams::getenemyplayers();
	var_8f5e3947 = [];
	foreach(enemy in enemies)
	{
		if(isalive(enemy))
		{
			var_8f5e3947[var_8f5e3947.size] = enemy;
		}
	}
	var_4e2b3e3a = [];
	for(i = 0; i < var_8f5e3947.size; i++)
	{
		var_4e2b3e3a[i] = var_8f5e3947[i].origin;
	}
	if(var_4e2b3e3a.size > 0)
	{
		while(shots_fired < 3)
		{
			location = array::random(var_4e2b3e3a) + (randomfloatrange(0, 200), randomfloatrange(0, 200), 0);
			self notify(#"confirm_location", {#yaw:0, #position:location});
			shots_fired++;
			if(shots_fired == 3)
			{
				break;
			}
			else
			{
				self waittill(#"hash_347a612b61067eb3");
			}
		}
	}
	else
	{
		while(shots_fired < 3)
		{
			self botpressbutton(16);
			self waittill(#"hash_347a612b61067eb3");
			shots_fired++;
		}
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_883edf75
	Namespace: namespace_104c3c75
	Checksum: 0xB5BF6644
	Offset: 0x7640
	Size: 0x24C
	Parameters: 1
	Flags: Linked
*/
function function_883edf75(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self bot_action::function_11c3d810(scorestreakweapon);
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	while(self getcurrentweapon() != scorestreakweapon)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	self bot_action::function_8a2b82ad(var_b594a2cd);
	self bot_action::aim_at_target(var_b594a2cd);
	while(self botgetlookdot() < 0.999 || self istraversing())
	{
		self waittill(#"hash_347a612b61067eb3");
		self bot_action::function_8a2b82ad(var_b594a2cd);
		self bot_action::aim_at_target(var_b594a2cd);
	}
	wait(0.5);
	starttime = gettime();
	while(self getcurrentweapon() == scorestreakweapon && gettime() - starttime < 1000)
	{
		self bottapbutton(0);
		self waittill(#"hash_347a612b61067eb3");
	}
	wait(1);
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	self function_d4c687c9();
}

/*
	Name: function_27f291e1
	Namespace: namespace_104c3c75
	Checksum: 0x9AEBCEB8
	Offset: 0x7898
	Size: 0x3CE
	Parameters: 1
	Flags: Linked
*/
function function_27f291e1(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self bot_action::function_11c3d810(scorestreakweapon);
	starttime = gettime();
	while(!isdefined(self.rocket) && gettime() - starttime < 4000)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	wait(1);
	starttime = gettime();
	boosted = 0;
	while(isdefined(self.rocket))
	{
		outsidetargets = [];
		foreach(player in level.players)
		{
			if(isalive(player) && util::function_fbce7263(player.team, self.team))
			{
				var_c36ae55a = function_ad6356f5(player.origin);
				if(isdefined(var_c36ae55a))
				{
					if(var_c36ae55a.var_eadc2c7d > 4000)
					{
						if(!isdefined(outsidetargets))
						{
							outsidetargets = [];
						}
						else if(!isarray(outsidetargets))
						{
							outsidetargets = array(outsidetargets);
						}
						outsidetargets[outsidetargets.size] = player;
					}
				}
			}
		}
		var_ea2231ab = undefined;
		var_914420bb = -1;
		foreach(target in outsidetargets)
		{
			var_6800dff4 = distance2dsquared(target.origin, self.rocket.origin);
			if(var_914420bb < 0 || var_6800dff4 < var_914420bb)
			{
				var_ea2231ab = target;
				var_914420bb = var_6800dff4;
			}
		}
		self.rocket missile_settarget(var_ea2231ab);
		if(!boosted && isdefined(var_ea2231ab))
		{
			var_3268fa4b = self.rocket.origin[2] - var_ea2231ab.origin[2];
			if(var_3268fa4b < 4000)
			{
				self bottapbutton(0);
				boosted = 1;
			}
		}
		wait(0.25);
	}
	while(!self function_a39f313c() || self getcurrentweapon() == level.weaponnone)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
}

/*
	Name: function_7d799351
	Namespace: namespace_104c3c75
	Checksum: 0x1A1B7D02
	Offset: 0x7C70
	Size: 0x198
	Parameters: 1
	Flags: Linked
*/
function function_7d799351(var_b594a2cd)
{
	scorestreakweapon = var_b594a2cd.weapon;
	self bot_action::function_11c3d810(scorestreakweapon);
	self namespace_b20b4885::stop();
	self function_a57c34b7(self.origin);
	while(!self function_a39f313c() || self getcurrentweapon() != scorestreakweapon)
	{
		self waittill(#"hash_347a612b61067eb3");
	}
	while(!self isinvehicle() && self getcurrentweapon() == scorestreakweapon)
	{
		if(isdefined(self.enemy))
		{
			var_b594a2cd.target = self.enemy.origin + vectorscale((0, 0, 1), 45);
		}
		if(isdefined(var_b594a2cd.target))
		{
			self bot_action::function_8a2b82ad(var_b594a2cd);
			self bot_action::aim_at_target(var_b594a2cd);
		}
		self bottapbutton(0);
		wait(0.5);
	}
}

