// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_db48768d;

/*
	Name: function_89f2df9
	Namespace: namespace_db48768d
	Checksum: 0x2EC65E46
	Offset: 0x190
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2d11bcef9355cc81", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_db48768d
	Checksum: 0x9532A65
	Offset: 0x1E0
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_clientfields();
	level thread function_3d4e24ea();
	level.var_13a6af33 = &function_35b30784;
}

/*
	Name: __main__
	Namespace: namespace_db48768d
	Checksum: 0x8036CBF6
	Offset: 0x230
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread ship_lights_control();
	level thread lighthouse_lights_control();
	level thread facility_lights_control();
	level thread infusion_lights_hot();
	level thread infusion_lights_cold();
}

/*
	Name: init_clientfields
	Namespace: namespace_db48768d
	Checksum: 0x8EFC9850
	Offset: 0x2B8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("world", "ship_lights_control", 24000, 1, "int");
	clientfield::register("world", "lighthouse_lights_control", 24000, 1, "int");
	clientfield::register("world", "facility_lights_control", 24000, 1, "int");
	clientfield::register("world", "infusion_lights_hot", 24000, 1, "int");
	clientfield::register("world", "infusion_lights_cold", 24000, 1, "int");
	clientfield::register("world", "orange_deactivate_radiant_exploders_client", 24000, 1, "counter");
}

/*
	Name: function_3d4e24ea
	Namespace: namespace_db48768d
	Checksum: 0x49667EAB
	Offset: 0x3E8
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_3d4e24ea()
{
	level._effect[#"hash_723a7c4a495d1008"] = #"hash_17207501ee73a374";
}

/*
	Name: ship_lights_control
	Namespace: namespace_db48768d
	Checksum: 0xFEC67597
	Offset: 0x428
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function ship_lights_control()
{
	level waittill(#"power_on2");
	level clientfield::set("ship_lights_control", 1);
}

/*
	Name: lighthouse_lights_control
	Namespace: namespace_db48768d
	Checksum: 0xF2134B0E
	Offset: 0x470
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function lighthouse_lights_control()
{
	level waittill(#"power_on1");
	level clientfield::set("lighthouse_lights_control", 1);
}

/*
	Name: facility_lights_control
	Namespace: namespace_db48768d
	Checksum: 0x120A031A
	Offset: 0x4B8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function facility_lights_control()
{
	level waittill(#"power_on3");
	level clientfield::set("facility_lights_control", 1);
}

/*
	Name: infusion_lights_hot
	Namespace: namespace_db48768d
	Checksum: 0x4E59D0DD
	Offset: 0x500
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function infusion_lights_hot()
{
	level flag::wait_till(#"hash_57d2cbf7d6c2035a");
	level clientfield::set("infusion_lights_hot", 1);
	level flag::wait_till_clear(#"hash_57d2cbf7d6c2035a");
	level clientfield::set("infusion_lights_hot", 0);
}

/*
	Name: infusion_lights_cold
	Namespace: namespace_db48768d
	Checksum: 0x628FC982
	Offset: 0x590
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function infusion_lights_cold()
{
	level flag::wait_till(#"hash_238e5c8b416f855");
	level clientfield::set("infusion_lights_cold", 1);
	level flag::wait_till_clear(#"hash_238e5c8b416f855");
	level clientfield::set("infusion_lights_cold", 0);
}

/*
	Name: function_e9f6e0f7
	Namespace: namespace_db48768d
	Checksum: 0xF9779F80
	Offset: 0x620
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_e9f6e0f7()
{
	var_a6323eb5 = getent("sam", "targetname");
	s_lgt_spawner = struct::get("s_lgt_spawner", "targetname");
	var_a6323eb5.tag = util::spawn_model("tag_origin", s_lgt_spawner.origin);
	var_a6323eb5.tag.angles = s_lgt_spawner.angles;
	level.registerglass_railing_kickedleader = level._effect[#"hash_723a7c4a495d1008"];
	var_a6323eb5.var_82acd734 = playfxontag(level.registerglass_railing_kickedleader, var_a6323eb5.tag, "tag_origin");
	var_a6323eb5.var_82acd734 linkto(var_a6323eb5);
}

/*
	Name: function_35b30784
	Namespace: namespace_db48768d
	Checksum: 0x79CD4D52
	Offset: 0x748
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_35b30784(string)
{
	if(!isdefined(level.var_7b4e19aa))
	{
		level.var_7b4e19aa = [];
	}
	array::add(level.var_7b4e19aa, string, 0);
}

/*
	Name: function_b1c6d4f2
	Namespace: namespace_db48768d
	Checksum: 0xDDB108E9
	Offset: 0x7A0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_b1c6d4f2()
{
	if(isdefined(level.var_7b4e19aa))
	{
		foreach(exploder_id in level.var_7b4e19aa)
		{
			exploder::kill_exploder(exploder_id);
			wait(0.3);
		}
		level.var_7b4e19aa = undefined;
	}
	level clientfield::increment("orange_deactivate_radiant_exploders_client", 1);
}

