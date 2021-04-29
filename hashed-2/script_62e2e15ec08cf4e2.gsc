// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_87e11242;

/*
	Name: function_89f2df9
	Namespace: namespace_87e11242
	Checksum: 0x40397EDF
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_3ee2bcf1f7dc56c8", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_87e11242
	Checksum: 0x362A9190
	Offset: 0x178
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_fx();
	init_clientfields();
	level.var_4a2723a3 = struct::get("server_scene", "script_noteworthy");
	level.var_faee939b = struct::get_array("aat_dmg_fx", "targetname");
	level.var_1d6643ed = 0;
	array::sort_by_script_int(level.var_faee939b, 1);
}

/*
	Name: init_fx
	Namespace: namespace_87e11242
	Checksum: 0x6DB12A52
	Offset: 0x228
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_775554ed8fe225e7"] = #"hash_620a92bcd2225e0f";
	level._effect[#"hash_170e9793dab7aa5b"] = #"hash_14eb4b8e52dfe0bb";
	level._effect[#"hash_78b4a1a435fd8bf7"] = #"hash_62f9570a97e8f893";
}

/*
	Name: init_clientfields
	Namespace: namespace_87e11242
	Checksum: 0x67ADB172
	Offset: 0x2C8
	Size: 0x164
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "" + #"hash_31a98ee76e835504", 1, 1, "int", &function_eae1fc85, 0, 0);
	clientfield::register("world", "" + #"hash_3284b0cf34bfe44e", 1, 1, "int", &function_85c61737, 0, 0);
	clientfield::register("world", "" + #"hash_b143d97bf92fc66", 1, 1, "counter", &function_e322771e, 0, 0);
	clientfield::register("world", "" + #"hash_28f972533bb468fd", 1, 1, "int", &function_d20d32f2, 0, 0);
}

/*
	Name: function_eae1fc85
	Namespace: namespace_87e11242
	Checksum: 0x95D18667
	Offset: 0x438
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_eae1fc85(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_9c56a77 = struct::get("fix_server_spark_fx", "targetname");
	if(newval == 1)
	{
		level.var_6171ce61 = playfx(localclientnum, level._effect[#"hash_775554ed8fe225e7"], var_9c56a77.origin);
	}
	else if(isdefined(level.var_6171ce61))
	{
		deletefx(localclientnum, level.var_6171ce61);
	}
}

/*
	Name: function_85c61737
	Namespace: namespace_87e11242
	Checksum: 0xA3540D02
	Offset: 0x528
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function function_85c61737(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		level.var_4a2723a3 scene::play("state_no_power");
	}
	else if(isdefined(level.var_be3c5a78))
	{
		deletefx(localclientnum, level.var_be3c5a78);
	}
}

/*
	Name: function_e322771e
	Namespace: namespace_87e11242
	Checksum: 0xDB3EFCA6
	Offset: 0x5D0
	Size: 0x90
	Parameters: 7
	Flags: Linked
*/
function function_e322771e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	str_index = "" + level.var_1d6643ed;
	level.var_4a2723a3 scene::play("state_" + level.var_1d6643ed);
	level.var_1d6643ed++;
}

/*
	Name: function_d20d32f2
	Namespace: namespace_87e11242
	Checksum: 0x6400F78
	Offset: 0x668
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function function_d20d32f2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.var_4a2723a3 scene::play("state_15");
}

