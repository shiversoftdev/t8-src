// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\lui_shared.gsc;

#namespace prototype_hud;

/*
	Name: register
	Namespace: prototype_hud
	Checksum: 0xF9BF629C
	Offset: 0x240
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function register(uid)
{
	object = new var_8a452bea();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_hud
	Checksum: 0x8720B9F4
	Offset: 0x288
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	[[ self ]]->open(player, persistent);
}

/*
	Name: close
	Namespace: prototype_hud
	Checksum: 0xA34A2964
	Offset: 0x2C8
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function close(player)
{
	[[ self ]]->close(player);
}

/*
	Name: is_open
	Namespace: prototype_hud
	Checksum: 0xC3F00B51
	Offset: 0x2F0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(player)
{
	return [[ self ]]->function_7bfd10e6(player);
}

/*
	Name: function_67cb2b67
	Namespace: prototype_hud
	Checksum: 0xF5E16B7B
	Offset: 0x318
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_67cb2b67(player, value)
{
	[[ self ]]->function_67cb2b67(player, value);
}

/*
	Name: function_bf6f7729
	Namespace: prototype_hud
	Checksum: 0x37EFDFA4
	Offset: 0x348
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_bf6f7729(player, value)
{
	[[ self ]]->function_bf6f7729(player, value);
}

/*
	Name: function_db0a5e97
	Namespace: prototype_hud
	Checksum: 0x9A52CF9C
	Offset: 0x378
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_db0a5e97(player, value)
{
	[[ self ]]->function_db0a5e97(player, value);
}

/*
	Name: function_4d15d40b
	Namespace: prototype_hud
	Checksum: 0xCD246604
	Offset: 0x3A8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4d15d40b(player, value)
{
	[[ self ]]->function_4d15d40b(player, value);
}

/*
	Name: function_d0c21ed0
	Namespace: prototype_hud
	Checksum: 0x107C6EDF
	Offset: 0x3D8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d0c21ed0(player, value)
{
	[[ self ]]->function_d0c21ed0(player, value);
}

/*
	Name: function_953da284
	Namespace: prototype_hud
	Checksum: 0xEC2383FE
	Offset: 0x408
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_953da284(player, value)
{
	[[ self ]]->function_953da284(player, value);
}

/*
	Name: function_ad839e96
	Namespace: prototype_hud
	Checksum: 0xA21D1015
	Offset: 0x438
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ad839e96(player, value)
{
	[[ self ]]->function_ad839e96(player, value);
}

/*
	Name: function_a7596728
	Namespace: prototype_hud
	Checksum: 0xFE8FA60B
	Offset: 0x468
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_a7596728(player, value)
{
	[[ self ]]->function_a7596728(player, value);
}

/*
	Name: function_a18b1c70
	Namespace: prototype_hud
	Checksum: 0x30E73DB1
	Offset: 0x498
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_a18b1c70(player, value)
{
	[[ self ]]->function_a18b1c70(player, value);
}

/*
	Name: function_4e0e26c8
	Namespace: prototype_hud
	Checksum: 0x90749BB7
	Offset: 0x4C8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4e0e26c8(player, value)
{
	[[ self ]]->function_4e0e26c8(player, value);
}

/*
	Name: function_cc538489
	Namespace: prototype_hud
	Checksum: 0x5195E9EF
	Offset: 0x4F8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cc538489(player, value)
{
	[[ self ]]->function_cc538489(player, value);
}

/*
	Name: function_565d4199
	Namespace: prototype_hud
	Checksum: 0x9B00B84A
	Offset: 0x528
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_565d4199(player, value)
{
	[[ self ]]->function_565d4199(player, value);
}

/*
	Name: function_8b286a2f
	Namespace: prototype_hud
	Checksum: 0xAA6C1924
	Offset: 0x558
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8b286a2f(player, value)
{
	[[ self ]]->function_8b286a2f(player, value);
}

/*
	Name: function_cbcd8e48
	Namespace: prototype_hud
	Checksum: 0xABACBBCA
	Offset: 0x588
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cbcd8e48(player, value)
{
	[[ self ]]->function_cbcd8e48(player, value);
}

/*
	Name: function_1f1846cf
	Namespace: prototype_hud
	Checksum: 0x6A6D29B5
	Offset: 0x5B8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1f1846cf(player, value)
{
	[[ self ]]->function_1f1846cf(player, value);
}

/*
	Name: function_19a87901
	Namespace: prototype_hud
	Checksum: 0xF608C7AB
	Offset: 0x5E8
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_19a87901(player, value)
{
	[[ self ]]->function_19a87901(player, value);
}

#namespace namespace_8a452bea;

/*
	Name: __constructor
	Namespace: namespace_8a452bea
	Checksum: 0xD146032D
	Offset: 0x618
	Size: 0x14
	Parameters: 0
	Flags: 8
*/
function __constructor()
{
	namespace_6aaccc24::__constructor();
}

/*
	Name: setup_clientfields
	Namespace: namespace_8a452bea
	Checksum: 0x900FAA92
	Offset: 0x638
	Size: 0x2A4
	Parameters: 1
	Flags: None
*/
function setup_clientfields(uid)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("barrier_prompt_visibility", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("upgrade_resource_count", 4000, 8, "int");
	namespace_6aaccc24::function_da693cbe("defense_resource_count", 4000, 8, "int");
	namespace_6aaccc24::function_da693cbe("resource_count_visibility", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("craft_progress", 4000, 5, "float");
	namespace_6aaccc24::function_dcb34c80("string", "active_objective_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective1_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective2_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective3_string", 4000);
	namespace_6aaccc24::function_da693cbe("objective_prompt_visibility", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("objective1_strike", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("objective2_strike", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("objective3_strike", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("fanfare_visibility", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("fail_fanfare_visibility", 4000, 1, "int");
	namespace_6aaccc24::function_da693cbe("deploy_prompt_visibility", 4000, 1, "int");
}

/*
	Name: open
	Namespace: namespace_8a452bea
	Checksum: 0xB70060FA
	Offset: 0x8E8
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function open(player, persistent = 0)
{
	namespace_6aaccc24::function_8b8089ba(player, "prototype_hud", persistent);
}

/*
	Name: close
	Namespace: namespace_8a452bea
	Checksum: 0xD42AEE95
	Offset: 0x938
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function close(player)
{
	namespace_6aaccc24::function_a68f6e20(player);
}

/*
	Name: function_67cb2b67
	Namespace: namespace_8a452bea
	Checksum: 0x91AD8421
	Offset: 0x968
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_67cb2b67(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "barrier_prompt_visibility", value);
}

/*
	Name: function_bf6f7729
	Namespace: namespace_8a452bea
	Checksum: 0xB7AEB639
	Offset: 0x9B0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_bf6f7729(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "upgrade_resource_count", value);
}

/*
	Name: function_db0a5e97
	Namespace: namespace_8a452bea
	Checksum: 0xA007F782
	Offset: 0x9F8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_db0a5e97(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "defense_resource_count", value);
}

/*
	Name: function_4d15d40b
	Namespace: namespace_8a452bea
	Checksum: 0x1C66732B
	Offset: 0xA40
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_4d15d40b(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "resource_count_visibility", value);
}

/*
	Name: function_d0c21ed0
	Namespace: namespace_8a452bea
	Checksum: 0xE2C4BF8
	Offset: 0xA88
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_d0c21ed0(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "craft_progress", value);
}

/*
	Name: function_953da284
	Namespace: namespace_8a452bea
	Checksum: 0xBA7A32EB
	Offset: 0xAD0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_953da284(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "active_objective_string", value);
}

/*
	Name: function_ad839e96
	Namespace: namespace_8a452bea
	Checksum: 0x2BECF7C4
	Offset: 0xB18
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_ad839e96(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective1_string", value);
}

/*
	Name: function_a7596728
	Namespace: namespace_8a452bea
	Checksum: 0xCBDAC031
	Offset: 0xB60
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_a7596728(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective2_string", value);
}

/*
	Name: function_a18b1c70
	Namespace: namespace_8a452bea
	Checksum: 0xF6F0374E
	Offset: 0xBA8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_a18b1c70(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective3_string", value);
}

/*
	Name: function_4e0e26c8
	Namespace: namespace_8a452bea
	Checksum: 0x38273724
	Offset: 0xBF0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_4e0e26c8(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective_prompt_visibility", value);
}

/*
	Name: function_cc538489
	Namespace: namespace_8a452bea
	Checksum: 0x7B924F7F
	Offset: 0xC38
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_cc538489(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective1_strike", value);
}

/*
	Name: function_565d4199
	Namespace: namespace_8a452bea
	Checksum: 0xCF9D1BD0
	Offset: 0xC80
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_565d4199(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective2_strike", value);
}

/*
	Name: function_8b286a2f
	Namespace: namespace_8a452bea
	Checksum: 0xFBD1DE33
	Offset: 0xCC8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_8b286a2f(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "objective3_strike", value);
}

/*
	Name: function_cbcd8e48
	Namespace: namespace_8a452bea
	Checksum: 0xCA916871
	Offset: 0xD10
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_cbcd8e48(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "fanfare_visibility", value);
}

/*
	Name: function_1f1846cf
	Namespace: namespace_8a452bea
	Checksum: 0xA9BBFFBD
	Offset: 0xD58
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_1f1846cf(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "fail_fanfare_visibility", value);
}

/*
	Name: function_19a87901
	Namespace: namespace_8a452bea
	Checksum: 0x9BD15039
	Offset: 0xDA0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_19a87901(player, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, "deploy_prompt_visibility", value);
}

/*
	Name: __destructor
	Namespace: namespace_8a452bea
	Checksum: 0xFB3A1CC8
	Offset: 0xDE8
	Size: 0x14
	Parameters: 0
	Flags: 16, 128
*/
function __destructor()
{
	namespace_6aaccc24::__destructor();
}

#namespace prototype_hud;

/*
	Name: function_8a452bea
	Namespace: prototype_hud
	Checksum: 0xD31361D0
	Offset: 0xE08
	Size: 0x5C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8a452bea()
{
	classes.var_8a452bea[0] = spawnstruct();
	classes.var_8a452bea[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_8a452bea[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_8a452bea[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_8a452bea[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_8a452bea[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_8a452bea[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_8a452bea[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_8a452bea[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_8a452bea[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
	classes.var_8a452bea[0].__vtable[913321084] = &namespace_8a452bea::__destructor;
	classes.var_8a452bea[0].__vtable[430471425] = &namespace_8a452bea::function_19a87901;
	classes.var_8a452bea[0].__vtable[521684687] = &namespace_8a452bea::function_1f1846cf;
	classes.var_8a452bea[0].__vtable[875721144] = &namespace_8a452bea::function_cbcd8e48;
	classes.var_8a452bea[0].__vtable[1960285649] = &namespace_8a452bea::function_8b286a2f;
	classes.var_8a452bea[0].__vtable[1448952217] = &namespace_8a452bea::function_565d4199;
	classes.var_8a452bea[0].__vtable[866941815] = &namespace_8a452bea::function_cc538489;
	classes.var_8a452bea[0].__vtable[1309550280] = &namespace_8a452bea::function_4e0e26c8;
	classes.var_8a452bea[0].__vtable[1584718736] = &namespace_8a452bea::function_a18b1c70;
	classes.var_8a452bea[0].__vtable[1487313112] = &namespace_8a452bea::function_a7596728;
	classes.var_8a452bea[0].__vtable[1383883114] = &namespace_8a452bea::function_ad839e96;
	classes.var_8a452bea[0].__vtable[1791122812] = &namespace_8a452bea::function_953da284;
	classes.var_8a452bea[0].__vtable[792584496] = &namespace_8a452bea::function_d0c21ed0;
	classes.var_8a452bea[0].__vtable[1293276171] = &namespace_8a452bea::function_4d15d40b;
	classes.var_8a452bea[0].__vtable[620077417] = &namespace_8a452bea::function_db0a5e97;
	classes.var_8a452bea[0].__vtable[1083214039] = &namespace_8a452bea::function_bf6f7729;
	classes.var_8a452bea[0].__vtable[1741368167] = &namespace_8a452bea::function_67cb2b67;
	classes.var_8a452bea[0].__vtable[1516492343] = &namespace_8a452bea::close;
	classes.var_8a452bea[0].__vtable[250899321] = &namespace_8a452bea::open;
	classes.var_8a452bea[0].__vtable[1855416484] = &namespace_8a452bea::setup_clientfields;
	classes.var_8a452bea[0].__vtable[674154906] = &namespace_8a452bea::__constructor;
}

