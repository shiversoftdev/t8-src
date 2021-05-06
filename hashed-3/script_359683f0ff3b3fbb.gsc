// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\lui_shared.csc;

#namespace prototype_hud;

/*
	Name: register
	Namespace: prototype_hud
	Checksum: 0x15F92CE7
	Offset: 0x228
	Size: 0x100
	Parameters: 17
	Flags: None
*/
function register(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258)
{
	object = new var_8a452bea();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->setup_clientfields(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258);
	return elem;
}

/*
	Name: function_5c1bb138
	Namespace: prototype_hud
	Checksum: 0x6ECBA657
	Offset: 0x330
	Size: 0x40
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	object = new var_8a452bea();
	[[ object ]]->__constructor();
	elem = object;
	[[ elem ]]->function_5c1bb138(uid);
	return elem;
}

/*
	Name: open
	Namespace: prototype_hud
	Checksum: 0xFB258825
	Offset: 0x378
	Size: 0x1C
	Parameters: 1
	Flags: None
*/
function open(player)
{
	[[ self ]]->open(player);
}

/*
	Name: close
	Namespace: prototype_hud
	Checksum: 0xD92C2363
	Offset: 0x3A0
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
	Checksum: 0xEE1D3D72
	Offset: 0x3C8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function is_open(localclientnum)
{
	return [[ self ]]->is_open(localclientnum);
}

/*
	Name: function_67cb2b67
	Namespace: prototype_hud
	Checksum: 0xE5752EC5
	Offset: 0x3F0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_67cb2b67(localclientnum, value)
{
	[[ self ]]->function_67cb2b67(localclientnum, value);
}

/*
	Name: function_bf6f7729
	Namespace: prototype_hud
	Checksum: 0xBE7BD400
	Offset: 0x420
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_bf6f7729(localclientnum, value)
{
	[[ self ]]->function_bf6f7729(localclientnum, value);
}

/*
	Name: function_db0a5e97
	Namespace: prototype_hud
	Checksum: 0xA152AB90
	Offset: 0x450
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_db0a5e97(localclientnum, value)
{
	[[ self ]]->function_db0a5e97(localclientnum, value);
}

/*
	Name: function_4d15d40b
	Namespace: prototype_hud
	Checksum: 0x8B5C8FA3
	Offset: 0x480
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4d15d40b(localclientnum, value)
{
	[[ self ]]->function_4d15d40b(localclientnum, value);
}

/*
	Name: function_d0c21ed0
	Namespace: prototype_hud
	Checksum: 0xC34A08C2
	Offset: 0x4B0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_d0c21ed0(localclientnum, value)
{
	[[ self ]]->function_d0c21ed0(localclientnum, value);
}

/*
	Name: function_953da284
	Namespace: prototype_hud
	Checksum: 0x8C5053C2
	Offset: 0x4E0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_953da284(localclientnum, value)
{
	[[ self ]]->function_953da284(localclientnum, value);
}

/*
	Name: function_ad839e96
	Namespace: prototype_hud
	Checksum: 0xBED05BD8
	Offset: 0x510
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_ad839e96(localclientnum, value)
{
	[[ self ]]->function_ad839e96(localclientnum, value);
}

/*
	Name: function_a7596728
	Namespace: prototype_hud
	Checksum: 0xCED478E0
	Offset: 0x540
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_a7596728(localclientnum, value)
{
	[[ self ]]->function_a7596728(localclientnum, value);
}

/*
	Name: function_a18b1c70
	Namespace: prototype_hud
	Checksum: 0x71E995F9
	Offset: 0x570
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_a18b1c70(localclientnum, value)
{
	[[ self ]]->function_a18b1c70(localclientnum, value);
}

/*
	Name: function_4e0e26c8
	Namespace: prototype_hud
	Checksum: 0x6C55145
	Offset: 0x5A0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_4e0e26c8(localclientnum, value)
{
	[[ self ]]->function_4e0e26c8(localclientnum, value);
}

/*
	Name: function_cc538489
	Namespace: prototype_hud
	Checksum: 0xD0218F88
	Offset: 0x5D0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cc538489(localclientnum, value)
{
	[[ self ]]->function_cc538489(localclientnum, value);
}

/*
	Name: function_565d4199
	Namespace: prototype_hud
	Checksum: 0x23A72B1C
	Offset: 0x600
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_565d4199(localclientnum, value)
{
	[[ self ]]->function_565d4199(localclientnum, value);
}

/*
	Name: function_8b286a2f
	Namespace: prototype_hud
	Checksum: 0x3B052135
	Offset: 0x630
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_8b286a2f(localclientnum, value)
{
	[[ self ]]->function_8b286a2f(localclientnum, value);
}

/*
	Name: function_cbcd8e48
	Namespace: prototype_hud
	Checksum: 0x16C785E
	Offset: 0x660
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_cbcd8e48(localclientnum, value)
{
	[[ self ]]->function_cbcd8e48(localclientnum, value);
}

/*
	Name: function_1f1846cf
	Namespace: prototype_hud
	Checksum: 0x16FC2E60
	Offset: 0x690
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_1f1846cf(localclientnum, value)
{
	[[ self ]]->function_1f1846cf(localclientnum, value);
}

/*
	Name: function_19a87901
	Namespace: prototype_hud
	Checksum: 0x412797DB
	Offset: 0x6C0
	Size: 0x28
	Parameters: 2
	Flags: None
*/
function function_19a87901(localclientnum, value)
{
	[[ self ]]->function_19a87901(localclientnum, value);
}

#namespace namespace_8a452bea;

/*
	Name: __constructor
	Namespace: namespace_8a452bea
	Checksum: 0x8AD7FA37
	Offset: 0x6F0
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
	Checksum: 0x14BE2DB8
	Offset: 0x710
	Size: 0x324
	Parameters: 17
	Flags: None
*/
function setup_clientfields(uid, var_fdf544c8, var_33c5c30f, var_96284758, var_bde1ea58, var_9a41cc6b, var_532cdc1a, var_3e5d22, var_61c0f0c1, var_5dd927bd, var_7a99f2e1, var_f3632296, var_d59bef9f, var_be5884c9, var_b5ae72b8, var_2b966169, var_83a9258)
{
	namespace_6aaccc24::setup_clientfields(uid);
	namespace_6aaccc24::function_da693cbe("barrier_prompt_visibility", 4000, 1, "int", var_fdf544c8);
	namespace_6aaccc24::function_da693cbe("upgrade_resource_count", 4000, 8, "int", var_33c5c30f);
	namespace_6aaccc24::function_da693cbe("defense_resource_count", 4000, 8, "int", var_96284758);
	namespace_6aaccc24::function_da693cbe("resource_count_visibility", 4000, 1, "int", var_bde1ea58);
	namespace_6aaccc24::function_da693cbe("craft_progress", 4000, 5, "float", var_9a41cc6b);
	namespace_6aaccc24::function_dcb34c80("string", "active_objective_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective1_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective2_string", 4000);
	namespace_6aaccc24::function_dcb34c80("string", "objective3_string", 4000);
	namespace_6aaccc24::function_da693cbe("objective_prompt_visibility", 4000, 1, "int", var_7a99f2e1);
	namespace_6aaccc24::function_da693cbe("objective1_strike", 4000, 1, "int", var_f3632296);
	namespace_6aaccc24::function_da693cbe("objective2_strike", 4000, 1, "int", var_d59bef9f);
	namespace_6aaccc24::function_da693cbe("objective3_strike", 4000, 1, "int", var_be5884c9);
	namespace_6aaccc24::function_da693cbe("fanfare_visibility", 4000, 1, "int", var_b5ae72b8);
	namespace_6aaccc24::function_da693cbe("fail_fanfare_visibility", 4000, 1, "int", var_2b966169);
	namespace_6aaccc24::function_da693cbe("deploy_prompt_visibility", 4000, 1, "int", var_83a9258);
}

/*
	Name: function_5c1bb138
	Namespace: namespace_8a452bea
	Checksum: 0x9255C0E2
	Offset: 0xA40
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_5c1bb138(uid)
{
	namespace_6aaccc24::function_5c1bb138(uid);
}

/*
	Name: function_fa582112
	Namespace: namespace_8a452bea
	Checksum: 0xA9E2B35C
	Offset: 0xA70
	Size: 0x220
	Parameters: 1
	Flags: None
*/
function function_fa582112(localclientnum)
{
	namespace_6aaccc24::function_fa582112(localclientnum);
	[[ self ]]->function_d7d2fcce(localclientnum, "barrier_prompt_visibility", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "upgrade_resource_count", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "defense_resource_count", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "resource_count_visibility", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "craft_progress", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "active_objective_string", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "objective1_string", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "objective2_string", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "objective3_string", #"");
	[[ self ]]->function_d7d2fcce(localclientnum, "objective_prompt_visibility", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "objective1_strike", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "objective2_strike", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "objective3_strike", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "fanfare_visibility", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "fail_fanfare_visibility", 0);
	[[ self ]]->function_d7d2fcce(localclientnum, "deploy_prompt_visibility", 0);
}

/*
	Name: open
	Namespace: namespace_8a452bea
	Checksum: 0x9ED57063
	Offset: 0xC98
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function open(localclientnum)
{
	namespace_6aaccc24::open(localclientnum, #"prototype_hud");
}

/*
	Name: function_67cb2b67
	Namespace: namespace_8a452bea
	Checksum: 0x345EC1CA
	Offset: 0xCD0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_67cb2b67(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "barrier_prompt_visibility", value);
}

/*
	Name: function_bf6f7729
	Namespace: namespace_8a452bea
	Checksum: 0xB55B386D
	Offset: 0xD08
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_bf6f7729(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "upgrade_resource_count", value);
}

/*
	Name: function_db0a5e97
	Namespace: namespace_8a452bea
	Checksum: 0x36368D7F
	Offset: 0xD40
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_db0a5e97(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "defense_resource_count", value);
}

/*
	Name: function_4d15d40b
	Namespace: namespace_8a452bea
	Checksum: 0x65D5FA3F
	Offset: 0xD78
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_4d15d40b(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "resource_count_visibility", value);
}

/*
	Name: function_d0c21ed0
	Namespace: namespace_8a452bea
	Checksum: 0x575562D
	Offset: 0xDB0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_d0c21ed0(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "craft_progress", value);
}

/*
	Name: function_953da284
	Namespace: namespace_8a452bea
	Checksum: 0xB0024386
	Offset: 0xDE8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_953da284(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "active_objective_string", value);
}

/*
	Name: function_ad839e96
	Namespace: namespace_8a452bea
	Checksum: 0xCC57AED
	Offset: 0xE20
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_ad839e96(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective1_string", value);
}

/*
	Name: function_a7596728
	Namespace: namespace_8a452bea
	Checksum: 0x8382105
	Offset: 0xE58
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_a7596728(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective2_string", value);
}

/*
	Name: function_a18b1c70
	Namespace: namespace_8a452bea
	Checksum: 0xBA28CF0E
	Offset: 0xE90
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_a18b1c70(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective3_string", value);
}

/*
	Name: function_4e0e26c8
	Namespace: namespace_8a452bea
	Checksum: 0xE57D23F1
	Offset: 0xEC8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_4e0e26c8(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective_prompt_visibility", value);
}

/*
	Name: function_cc538489
	Namespace: namespace_8a452bea
	Checksum: 0xC13D27E2
	Offset: 0xF00
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_cc538489(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective1_strike", value);
}

/*
	Name: function_565d4199
	Namespace: namespace_8a452bea
	Checksum: 0xBCF5371D
	Offset: 0xF38
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_565d4199(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective2_strike", value);
}

/*
	Name: function_8b286a2f
	Namespace: namespace_8a452bea
	Checksum: 0x2A074ED0
	Offset: 0xF70
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_8b286a2f(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "objective3_strike", value);
}

/*
	Name: function_cbcd8e48
	Namespace: namespace_8a452bea
	Checksum: 0x63172253
	Offset: 0xFA8
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_cbcd8e48(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "fanfare_visibility", value);
}

/*
	Name: function_1f1846cf
	Namespace: namespace_8a452bea
	Checksum: 0x35F7FED4
	Offset: 0xFE0
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_1f1846cf(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "fail_fanfare_visibility", value);
}

/*
	Name: function_19a87901
	Namespace: namespace_8a452bea
	Checksum: 0x83443C4
	Offset: 0x1018
	Size: 0x30
	Parameters: 2
	Flags: None
*/
function function_19a87901(localclientnum, value)
{
	[[ self ]]->function_d7d2fcce(localclientnum, "deploy_prompt_visibility", value);
}

/*
	Name: __destructor
	Namespace: namespace_8a452bea
	Checksum: 0x6BBACB80
	Offset: 0x1050
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
	Checksum: 0x27207660
	Offset: 0x1070
	Size: 0x656
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8a452bea()
{
	classes.var_8a452bea[0] = spawnstruct();
	classes.var_8a452bea[0].__vtable[1833276934] = &namespace_6aaccc24::function_92ba69fa;
	classes.var_8a452bea[0].__vtable[674038578] = &namespace_6aaccc24::function_d7d2fcce;
	classes.var_8a452bea[0].__vtable[1516492343] = &namespace_6aaccc24::close;
	classes.var_8a452bea[0].__vtable[632663907] = &namespace_6aaccc24::is_open;
	classes.var_8a452bea[0].__vtable[250899321] = &namespace_6aaccc24::open;
	classes.var_8a452bea[0].__vtable[94887662] = &namespace_6aaccc24::function_fa582112;
	classes.var_8a452bea[0].__vtable[1545318712] = &namespace_6aaccc24::function_5c1bb138;
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
	classes.var_8a452bea[0].__vtable[250899321] = &namespace_8a452bea::open;
	classes.var_8a452bea[0].__vtable[94887662] = &namespace_8a452bea::function_fa582112;
	classes.var_8a452bea[0].__vtable[1545318712] = &namespace_8a452bea::function_5c1bb138;
	classes.var_8a452bea[0].__vtable[1855416484] = &namespace_8a452bea::setup_clientfields;
	classes.var_8a452bea[0].__vtable[674154906] = &namespace_8a452bea::__constructor;
}

