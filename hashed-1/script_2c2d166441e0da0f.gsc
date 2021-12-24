// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_38755604e51a604e;
#using script_5b1c3d314b9c88fb;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\struct.gsc;

#namespace namespace_51010f55;

/*
	Name: init
	Namespace: namespace_51010f55
	Checksum: 0x516E5A91
	Offset: 0xC0
	Size: 0x5EC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_dc16557c = 1;
	level.var_c64b3b46 = 1;
	level.var_754d756 = (isdefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) ? getgametypesetting(#"hash_3e2d2cf6b1cc6c68") : 0) || (isdefined(getgametypesetting(#"hash_1b4a66a008f60927")) ? getgametypesetting(#"hash_1b4a66a008f60927") : 0);
	level.var_fd7ef894 = (isdefined(getgametypesetting(#"hash_3624143624604b4c")) ? getgametypesetting(#"hash_3624143624604b4c") : 0);
	level.var_6da69360 = (isdefined(getgametypesetting(#"hash_1bcb7e5d76212b76")) ? getgametypesetting(#"hash_1bcb7e5d76212b76") : 0);
	level.var_f8f715a7 = (isdefined(getgametypesetting(#"hash_76fb3219916a09f2")) ? getgametypesetting(#"hash_76fb3219916a09f2") : 0);
	level.var_81d13d70 = (isdefined(getgametypesetting(#"hash_44c7473eab6e5459")) ? getgametypesetting(#"hash_44c7473eab6e5459") : 0);
	level.var_c62c0fea = (isdefined(getgametypesetting(#"hash_4d6cfd0b3ee4cc7d")) ? getgametypesetting(#"hash_4d6cfd0b3ee4cc7d") : 0);
	level.var_3195c89b = (isdefined(getgametypesetting(#"hash_3624143624604b4c")) ? getgametypesetting(#"hash_3624143624604b4c") : 0);
	level.var_6df0d3b6 = &function_6df0d3b6;
	if(isdefined(level.var_4774c9e9) && level.var_4774c9e9 && (isdefined(level.var_d33a57a) && level.var_d33a57a))
	{
		function_36cc50(#"hash_50c4ae7eab84983b", 1, 1);
	}
	else if(isdefined(level.var_2e681d63) && level.var_2e681d63 && (isdefined(level.var_6b59ac2c) && level.var_6b59ac2c))
	{
		function_36cc50(#"hash_70f16a3fe6713fa0", 4, 2);
	}
	else if(isdefined(level.var_bf864abf) && level.var_bf864abf && (isdefined(level.var_4f7f5c18) && level.var_4f7f5c18))
	{
		function_36cc50(#"hash_2d45c1aaf7808b60", 4, 2);
	}
	else if(isdefined(level.var_e7cfbb8e) && level.var_e7cfbb8e && (isdefined(level.var_b6e30614) && level.var_b6e30614))
	{
		function_36cc50(#"hash_7905cf70902495a2", 10, 4);
	}
	else if(isdefined(level.var_fa831ab8) && level.var_fa831ab8 && (isdefined(level.var_9196aafd) && level.var_9196aafd))
	{
		function_36cc50(#"hash_78b8c004294d69fe", 4, 2);
	}
	else if(isdefined(level.var_d373b4e4) && level.var_d373b4e4)
	{
		function_f910ed8a();
	}
	else if(isdefined(level.var_fd7ef894) && level.var_fd7ef894)
	{
		function_f0b2e300();
	}
	else
	{
		function_c41ad9f9();
	}
	level notify(#"hash_7f7eec328c07606d");
	if(isdefined(level.var_bbad516a) && level.var_bbad516a)
	{
		level thread spawn_special_ai();
	}
}

/*
	Name: spawn_special_ai
	Namespace: namespace_51010f55
	Checksum: 0x67F7DD21
	Offset: 0x6B8
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function spawn_special_ai()
{
	level waittill(#"hash_54391c26dfd50b8a");
	var_f71adb48 = struct::get_array("special_ai", "script_noteworthy");
	var_f71adb48 = array::randomize(var_f71adb48);
	num_to_spawn = min(var_f71adb48.size, 5);
	for(i = 0; i < num_to_spawn; i++)
	{
		var_eb5de65e = var_f71adb48[i];
		namespace_b912c30b::function_ac114e1f(var_eb5de65e, #"hash_618248fca82d83a6", #"hash_c6197358856090b");
		wait(0.1);
	}
}

/*
	Name: function_6df0d3b6
	Namespace: namespace_51010f55
	Checksum: 0xA5AA1790
	Offset: 0x7C0
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_6df0d3b6(zone_name)
{
	switch(zone_name)
	{
		case "hash_56936f5946d31e10":
		{
			if(isdefined(level.var_f8f715a7) && level.var_f8f715a7)
			{
				return 1;
			}
			break;
		}
		case "hash_c6197358856090b":
		{
			if(isdefined(level.var_81d13d70) && level.var_81d13d70)
			{
				return 1;
			}
			break;
		}
		case "hash_6a63c77e32735ddb":
		{
			if(isdefined(level.var_c62c0fea) && level.var_c62c0fea)
			{
				return 1;
			}
			break;
		}
		case "global":
		{
			if(isdefined(level.var_3195c89b) && level.var_3195c89b)
			{
				return 1;
			}
			break;
		}
	}
	return 0;
}

/*
	Name: function_6e9af98a
	Namespace: namespace_51010f55
	Checksum: 0x30B82B31
	Offset: 0x8D0
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_6e9af98a(var_2799920d, var_d6d494ab)
{
	if(isdefined(level.var_fd6c6b69) && level.var_fd6c6b69)
	{
		return var_d6d494ab;
	}
	return var_2799920d;
}

/*
	Name: function_bb7cbe85
	Namespace: namespace_51010f55
	Checksum: 0x9FA0D604
	Offset: 0x918
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_bb7cbe85(var_2799920d, var_d6d494ab)
{
	if(isdefined(level.var_3fecd9c2) && level.var_3fecd9c2)
	{
		return var_d6d494ab;
	}
	return var_2799920d;
}

/*
	Name: function_5f1710a5
	Namespace: namespace_51010f55
	Checksum: 0x2C5E50A2
	Offset: 0x960
	Size: 0x3E
	Parameters: 2
	Flags: Linked
*/
function function_5f1710a5(var_2799920d, var_d6d494ab)
{
	if(isdefined(level.var_3fecd9c2) && level.var_3fecd9c2)
	{
		return var_d6d494ab;
	}
	return var_2799920d;
}

/*
	Name: function_8854d951
	Namespace: namespace_51010f55
	Checksum: 0x9B38A5F9
	Offset: 0x9A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function function_8854d951()
{
	namespace_bf3feaf0::function_3a69e98c(#"global", #"hash_618248fca82d83a6", 12);
}

/*
	Name: function_f0b2e300
	Namespace: namespace_51010f55
	Checksum: 0x74E93648
	Offset: 0x9F0
	Size: 0x71C
	Parameters: 0
	Flags: Linked
*/
function function_f0b2e300()
{
	level.var_86c18344 = 0;
	if(isdefined(level.var_6da69360) && level.var_6da69360)
	{
		level.var_ff8e9324 = 20;
	}
	level.var_45e13026 = 1;
	level.var_8854d951 = &function_8854d951;
	var_34a27e6c = (24, 5, 1);
	var_5af62480 = getdvarint(#"hash_78162e99d6e60377", 0);
	if(isdefined(var_5af62480) && var_5af62480)
	{
		var_34a27e6c = getdvarvector(#"hash_7b235a13caefcdba", (24, 5, 1));
	}
	var_ecf3ab7f = 240;
	var_8a0a1dec = var_34a27e6c[0];
	var_5b2d986e = 10;
	namespace_bf3feaf0::function_5f0d105a(0, #"global", #"hash_618248fca82d83a6", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_321414a(#"global", #"hash_618248fca82d83a6", #"hash_56936f5946d31e10");
	namespace_bf3feaf0::function_321414a(#"global", #"hash_618248fca82d83a6", #"hash_6a63c77e32735ddb");
	namespace_bf3feaf0::function_321414a(#"global", #"hash_618248fca82d83a6", #"hash_c6197358856090b");
	namespace_bf3feaf0::function_8e672218(#"global", #"hash_618248fca82d83a6", 1);
	namespace_bf3feaf0::function_c3bb62c1(#"global", #"hash_618248fca82d83a6", 0);
	var_ecf3ab7f = 10;
	var_8a0a1dec = var_34a27e6c[1];
	var_5b2d986e = 3;
	namespace_bf3feaf0::function_5f0d105a(1, #"hash_56936f5946d31e10", #"hash_7905cf70902495a2", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_5f0d105a(1, #"hash_6a63c77e32735ddb", #"hash_7905cf70902495a2", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_6c75dee3(#"hash_56936f5946d31e10", #"hash_7905cf70902495a2", 5);
	namespace_bf3feaf0::function_6c75dee3(#"hash_6a63c77e32735ddb", #"hash_7905cf70902495a2", 5);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_56936f5946d31e10", #"hash_7905cf70902495a2", 0);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_6a63c77e32735ddb", #"hash_7905cf70902495a2", 0);
	var_ecf3ab7f = 1;
	var_8a0a1dec = var_34a27e6c[2];
	var_5b2d986e = 1;
	namespace_bf3feaf0::function_5f0d105a(2, #"hash_56936f5946d31e10", #"hash_70f16a3fe6713fa0", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_5f0d105a(2, #"hash_c6197358856090b", #"hash_70f16a3fe6713fa0", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_5f0d105a(2, #"hash_6a63c77e32735ddb", #"hash_70f16a3fe6713fa0", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_6c75dee3(#"hash_56936f5946d31e10", #"hash_70f16a3fe6713fa0", 3);
	namespace_bf3feaf0::function_6c75dee3(#"hash_c6197358856090b", #"hash_70f16a3fe6713fa0", 3);
	namespace_bf3feaf0::function_6c75dee3(#"hash_6a63c77e32735ddb", #"hash_70f16a3fe6713fa0", 3);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_56936f5946d31e10", #"hash_70f16a3fe6713fa0", 2);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_c6197358856090b", #"hash_70f16a3fe6713fa0", 2);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_6a63c77e32735ddb", #"hash_70f16a3fe6713fa0", 2);
	namespace_bf3feaf0::function_462b41e2(#"hash_56936f5946d31e10", #"hash_70f16a3fe6713fa0", #"hash_3e4109550d98219f", #"hash_43b30c7ff9b4f4c2", #"hash_3c449d1a7a0cd70e");
	namespace_bf3feaf0::function_462b41e2(#"hash_c6197358856090b", #"hash_70f16a3fe6713fa0", #"hash_3e410a550d982352", #"hash_367f5a5f344dcda7", #"hash_6a498d20dd284089");
	namespace_bf3feaf0::function_462b41e2(#"hash_6a63c77e32735ddb", #"hash_70f16a3fe6713fa0", #"hash_3e410b550d982505", #"hash_451e5522eeb07ee8", #"hash_3db2892c24c8a1bc");
}

/*
	Name: function_c41ad9f9
	Namespace: namespace_51010f55
	Checksum: 0x51D6C25A
	Offset: 0x1118
	Size: 0x37C
	Parameters: 0
	Flags: Linked
*/
function function_c41ad9f9()
{
	var_ce0426e0 = (function_6e9af98a(7, 10), function_bb7cbe85(5, 7), function_5f1710a5(0, 0));
	var_b0befc80 = getdvar(#"hash_15fba4abe8704cb8", 0);
	if(isdefined(var_b0befc80) && var_b0befc80)
	{
		var_ce0426e0 = getdvarvector(#"hash_cbccd885e75d219", (10, 5, 2));
	}
	var_ecf3ab7f = var_ce0426e0[0];
	var_8a0a1dec = var_ce0426e0[1];
	var_5b2d986e = var_ce0426e0[2];
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_56936f5946d31e10", #"hash_618248fca82d83a6", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_6c75dee3(#"hash_56936f5946d31e10", #"hash_618248fca82d83a6", 1);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_c6197358856090b", #"hash_618248fca82d83a6", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_6c75dee3(#"hash_c6197358856090b", #"hash_618248fca82d83a6", 1);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_6a63c77e32735ddb", #"hash_618248fca82d83a6", var_ecf3ab7f, var_8a0a1dec, var_5b2d986e);
	namespace_bf3feaf0::function_6c75dee3(#"hash_6a63c77e32735ddb", #"hash_618248fca82d83a6", 1);
	namespace_bf3feaf0::function_462b41e2(#"hash_56936f5946d31e10", #"hash_618248fca82d83a6", #"hash_3e4109550d98219f", #"hash_43b30c7ff9b4f4c2", #"hash_3c449d1a7a0cd70e");
	namespace_bf3feaf0::function_462b41e2(#"hash_c6197358856090b", #"hash_618248fca82d83a6", #"hash_3e410a550d982352", #"hash_367f5a5f344dcda7", #"hash_6a498d20dd284089");
	namespace_bf3feaf0::function_462b41e2(#"hash_6a63c77e32735ddb", #"hash_618248fca82d83a6", #"hash_3e410b550d982505", #"hash_451e5522eeb07ee8", #"hash_3db2892c24c8a1bc");
}

/*
	Name: function_4cfa640c
	Namespace: namespace_51010f55
	Checksum: 0xF34CC511
	Offset: 0x14A0
	Size: 0x1E4
	Parameters: 0
	Flags: None
*/
function function_4cfa640c()
{
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_56936f5946d31e10", #"hash_7905cf70902495a2", 10, 4, 4);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_c6197358856090b", #"hash_7905cf70902495a2", 10, 4, 4);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_6a63c77e32735ddb", #"hash_7905cf70902495a2", 10, 4, 4);
	namespace_bf3feaf0::function_462b41e2(#"hash_56936f5946d31e10", #"hash_7905cf70902495a2", #"hash_3e4109550d98219f", #"hash_43b30c7ff9b4f4c2", #"hash_3c449d1a7a0cd70e");
	namespace_bf3feaf0::function_462b41e2(#"hash_c6197358856090b", #"hash_7905cf70902495a2", #"hash_3e410a550d982352", #"hash_367f5a5f344dcda7", #"hash_6a498d20dd284089");
	namespace_bf3feaf0::function_462b41e2(#"hash_6a63c77e32735ddb", #"hash_7905cf70902495a2", #"hash_3e410b550d982505", #"hash_451e5522eeb07ee8", #"hash_3db2892c24c8a1bc");
}

/*
	Name: function_36cc50
	Namespace: namespace_51010f55
	Checksum: 0x92C9C3BC
	Offset: 0x1690
	Size: 0x214
	Parameters: 3
	Flags: Linked
*/
function function_36cc50(var_8667e69, maxcount, var_8a14a619)
{
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_56936f5946d31e10", var_8667e69, maxcount, var_8a14a619, 0);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_56936f5946d31e10", var_8667e69, 2);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_c6197358856090b", var_8667e69, maxcount, var_8a14a619, 0);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_c6197358856090b", var_8667e69, 2);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_6a63c77e32735ddb", var_8667e69, maxcount, var_8a14a619, 0);
	namespace_bf3feaf0::function_c3bb62c1(#"hash_6a63c77e32735ddb", var_8667e69, 2);
	namespace_bf3feaf0::function_462b41e2(#"hash_56936f5946d31e10", var_8667e69, #"hash_3e4109550d98219f", #"hash_43b30c7ff9b4f4c2", #"hash_3c449d1a7a0cd70e");
	namespace_bf3feaf0::function_462b41e2(#"hash_c6197358856090b", var_8667e69, #"hash_3e410a550d982352", #"hash_367f5a5f344dcda7", #"hash_6a498d20dd284089");
	namespace_bf3feaf0::function_462b41e2(#"hash_6a63c77e32735ddb", var_8667e69, #"hash_3e410b550d982505", #"hash_451e5522eeb07ee8", #"hash_3db2892c24c8a1bc");
}

/*
	Name: function_f910ed8a
	Namespace: namespace_51010f55
	Checksum: 0x27010866
	Offset: 0x18B0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_f910ed8a()
{
	zombie_count = max(level.var_aad912ad, 1);
	if(isdedicated())
	{
		iprintlnbold(("Zombie count is " + zombie_count) + "\n");
	}
	var_c3bb4e09 = zombie_count;
	var_f1fbce84 = zombie_count;
	var_aeae9f59 = var_f1fbce84 + var_f1fbce84;
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_56936f5946d31e10", #"hash_618248fca82d83a6", var_aeae9f59, var_f1fbce84, var_c3bb4e09);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_c6197358856090b", #"hash_618248fca82d83a6", var_aeae9f59, var_f1fbce84, var_c3bb4e09);
	namespace_bf3feaf0::function_5f0d105a(0, #"hash_6a63c77e32735ddb", #"hash_618248fca82d83a6", var_aeae9f59, var_f1fbce84, var_c3bb4e09);
	namespace_bf3feaf0::function_462b41e2(#"hash_56936f5946d31e10", #"hash_618248fca82d83a6", #"hash_3e4109550d98219f", #"hash_43b30c7ff9b4f4c2", #"hash_3c449d1a7a0cd70e");
	namespace_bf3feaf0::function_462b41e2(#"hash_c6197358856090b", #"hash_618248fca82d83a6", #"hash_3e410a550d982352", #"hash_367f5a5f344dcda7", #"hash_6a498d20dd284089");
	namespace_bf3feaf0::function_462b41e2(#"hash_6a63c77e32735ddb", #"hash_618248fca82d83a6", #"hash_3e410b550d982505", #"hash_451e5522eeb07ee8", #"hash_3db2892c24c8a1bc");
}

