// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;

#namespace namespace_87f097c4;

/*
	Name: function_89f2df9
	Namespace: namespace_87f097c4
	Checksum: 0x626E0AA8
	Offset: 0xD8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7551e984c9a42af9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_87f097c4
	Checksum: 0xF982F793
	Offset: 0x120
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_6e0c26c7 = (isdefined(getgametypesetting(#"hash_30b11d064f146fcc")) ? getgametypesetting(#"hash_30b11d064f146fcc") : 0) || (isdefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0);
	if(level.var_6e0c26c7)
	{
		clientfield::register("world", "zombie_arm_blood_splash", 20000, 1, "counter", &function_548630a, 0, 0);
		clientfield::register("world", "bathtub_fake_soul_sfx", 20000, 1, "counter", &function_11111d4c, 0, 0);
	}
}

/*
	Name: function_548630a
	Namespace: namespace_87f097c4
	Checksum: 0xA8C607B5
	Offset: 0x270
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_548630a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_2bfb4416 = struct::get(#"hash_53bbab305c87572a", "targetname");
	if(isdefined(var_2bfb4416))
	{
		playfx(localclientnum, #"hash_6e2b2bcea07134d1", var_2bfb4416.origin, (0, 0, 1));
	}
}

/*
	Name: function_11111d4c
	Namespace: namespace_87f097c4
	Checksum: 0xA322312B
	Offset: 0x320
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_11111d4c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	wait(0.2);
	var_2bfb4416 = struct::get(#"hash_53bbab305c87572a", "targetname");
	if(isdefined(var_2bfb4416))
	{
		playsound(localclientnum, #"zmb_sq_souls_impact", var_2bfb4416.origin);
	}
}

