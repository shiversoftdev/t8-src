// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_score;

/*
	Name: function_89f2df9
	Namespace: zm_score
	Checksum: 0xBF4B91A
	Offset: 0x130
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_score", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_score
	Checksum: 0x239CDC73
	Offset: 0x178
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_697c8943 = array(90, 80, 70, 60, 50, 40, 30, 20, 10);
	foreach(subdivision in level.var_697c8943)
	{
		score_cf_register_info("damage" + subdivision, 1, 7);
	}
	score_cf_register_info("death_head", 1, 3, undefined);
	score_cf_register_info("death_melee", 1, 3, undefined);
	score_cf_register_info("transform_kill", 1, 3, undefined);
	clientfield::register("clientuimodel", "hudItems.doublePointsActive", 1, 1, "int", undefined, 0, 0);
}

/*
	Name: score_cf_register_info
	Namespace: zm_score
	Checksum: 0x4710D02B
	Offset: 0x2F0
	Size: 0xA6
	Parameters: 4
	Flags: Linked
*/
function score_cf_register_info(name, version, max_count, func_callback)
{
	for(i = 0; i < 4; i++)
	{
		clientfield::register("worlduimodel", (("PlayerList.client" + i) + ".score_cf_") + name, version, getminbitcountfornum(max_count), "counter", func_callback, 0, 0);
	}
}

