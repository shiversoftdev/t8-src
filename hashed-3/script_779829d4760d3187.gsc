// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2cd0a997aa904279;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;

#namespace namespace_ba52581a;

/*
	Name: function_89f2df9
	Namespace: namespace_ba52581a
	Checksum: 0xC632D810
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_14819f0ef5a24379", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ba52581a
	Checksum: 0xCB2E5C3F
	Offset: 0x118
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	init_flags();
	init_clientfields();
	function_88d1bd71();
}

/*
	Name: init_flags
	Namespace: namespace_ba52581a
	Checksum: 0xEF85E4B2
	Offset: 0x158
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_67df8b68575ba704");
	level flag::init(#"hash_10d5bcbc42acc9b");
	level flag::init(#"hash_1fa9f2f17d2cb5f9");
	level flag::init(#"hash_36e8f27bbd8b02d5");
	level flag::init(#"hash_1c296f8c578e2659");
}

/*
	Name: init_clientfields
	Namespace: namespace_ba52581a
	Checksum: 0x1E2CC521
	Offset: 0x208
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("toplayer", "" + #"hash_7eefa4acee4c1d55", 1, 1, "counter");
}

/*
	Name: function_88d1bd71
	Namespace: namespace_ba52581a
	Checksum: 0x89075C23
	Offset: 0x258
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_88d1bd71()
{
	level.var_774c21fa = struct::get(#"hash_117cb1e7c329e0ad");
	level.mcnamara = spawn("script_model", level.var_774c21fa.origin);
	level.var_33d3e84a = 0;
	namespace_ee206246::register(#"hash_5a9580406af2d773", #"step_1", #"hash_5cbd9c892dca9e05", &function_4b16859a, &function_53935f3d);
	namespace_ee206246::register(#"hash_5a9580406af2d773", #"step_2", #"hash_5cbd99892dca98ec", &function_9235fc9a, &function_fe3de565);
	namespace_ee206246::register(#"hash_5a9580406af2d773", #"step_3", #"hash_5cbd9a892dca9a9f", &function_2e57632b, &function_3409e90e);
	namespace_ee206246::register(#"hash_5a9580406af2d773", #"step_4", #"hash_5cbd97892dca9586", &function_7991d694, &function_c2bd8b3d);
	namespace_ee206246::register(#"hash_5a9580406af2d773", #"step_5", #"hash_5cbd98892dca9739", &function_8ca22055, &function_d8b688e7);
	namespace_ee206246::start(#"hash_5a9580406af2d773");
}

/*
	Name: function_4b16859a
	Namespace: namespace_ba52581a
	Checksum: 0xEA26FD27
	Offset: 0x4D8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_4b16859a(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
		level flag::wait_till(#"hash_67df8b68575ba704");
	}
}

/*
	Name: function_53935f3d
	Namespace: namespace_ba52581a
	Checksum: 0x8086BFE3
	Offset: 0x548
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_53935f3d(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 1;
		level flag::set(#"hash_67df8b68575ba704");
	}
	else
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 1;
		playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
		level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
		wait(3);
		namespace_509a75d1::function_e308175e(#"hash_40c5232d4f3e85b", level.mcnamara.origin);
	}
}

/*
	Name: function_9235fc9a
	Namespace: namespace_ba52581a
	Checksum: 0x89BAA2D0
	Offset: 0x6A8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_9235fc9a(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
		level flag::wait_till(#"hash_10d5bcbc42acc9b");
	}
}

/*
	Name: function_fe3de565
	Namespace: namespace_ba52581a
	Checksum: 0x39F5226A
	Offset: 0x718
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_fe3de565(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 2;
		level flag::set(#"hash_10d5bcbc42acc9b");
	}
	else
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 2;
		playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
		level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
		wait(3);
		namespace_509a75d1::function_e308175e(#"hash_338550de989ad1a7", level.mcnamara.origin);
	}
}

/*
	Name: function_2e57632b
	Namespace: namespace_ba52581a
	Checksum: 0xA16F4775
	Offset: 0x878
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_2e57632b(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
		level flag::wait_till(#"hash_1fa9f2f17d2cb5f9");
	}
}

/*
	Name: function_3409e90e
	Namespace: namespace_ba52581a
	Checksum: 0xECF9E58E
	Offset: 0x8E8
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_3409e90e(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 3;
		level flag::set(#"hash_1fa9f2f17d2cb5f9");
	}
	else
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 3;
		playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
		level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
		wait(3);
		namespace_509a75d1::function_e308175e(#"hash_182892c4bb99b96a", level.mcnamara.origin);
	}
}

/*
	Name: function_7991d694
	Namespace: namespace_ba52581a
	Checksum: 0x5B37397C
	Offset: 0xA48
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_7991d694(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
		level flag::wait_till(#"hash_36e8f27bbd8b02d5");
	}
}

/*
	Name: function_c2bd8b3d
	Namespace: namespace_ba52581a
	Checksum: 0xD0120CBE
	Offset: 0xAB8
	Size: 0x154
	Parameters: 2
	Flags: Linked
*/
function function_c2bd8b3d(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 4;
		level flag::set(#"hash_36e8f27bbd8b02d5");
	}
	else
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 4;
		playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
		level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
		wait(3);
		namespace_509a75d1::function_e308175e(#"hash_1d3964f5cb0069af", level.mcnamara.origin);
	}
}

/*
	Name: function_8ca22055
	Namespace: namespace_ba52581a
	Checksum: 0x8A7E2D74
	Offset: 0xC18
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_8ca22055(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level.var_774c21fa zm_unitrigger::create("", 64, &function_5ce4f28f);
		level flag::wait_till(#"hash_1c296f8c578e2659");
	}
}

/*
	Name: function_d8b688e7
	Namespace: namespace_ba52581a
	Checksum: 0xECE09876
	Offset: 0xC88
	Size: 0x16C
	Parameters: 2
	Flags: Linked
*/
function function_d8b688e7(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 5;
		level flag::set(#"hash_1c296f8c578e2659");
	}
	else
	{
		zm_unitrigger::unregister_unitrigger(level.var_774c21fa.s_unitrigger);
		level.var_33d3e84a = 5;
		playsoundatposition(#"hash_61901dee5b81dba2", level.var_774c21fa.origin);
		level.var_38ea4233 clientfield::increment_to_player("" + #"hash_7eefa4acee4c1d55", 1);
		wait(3);
		namespace_509a75d1::function_e308175e(#"hash_e51948d3d12b229", level.mcnamara.origin);
	}
	level thread namespace_c71ecd1b::function_6b3512d();
}

/*
	Name: function_5ce4f28f
	Namespace: namespace_ba52581a
	Checksum: 0x14B1A185
	Offset: 0xE00
	Size: 0x22A
	Parameters: 0
	Flags: Linked
*/
function function_5ce4f28f()
{
	switch(level.var_33d3e84a)
	{
		case 0:
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			level.var_38ea4233 = waitresult.activator;
			level flag::set(#"hash_67df8b68575ba704");
		}
		case 1:
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			level.var_38ea4233 = waitresult.activator;
			level flag::set(#"hash_10d5bcbc42acc9b");
		}
		case 2:
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			level.var_38ea4233 = waitresult.activator;
			level flag::set(#"hash_1fa9f2f17d2cb5f9");
		}
		case 3:
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			level.var_38ea4233 = waitresult.activator;
			level flag::set(#"hash_36e8f27bbd8b02d5");
		}
		case 4:
		{
			waitresult = undefined;
			waitresult = self waittill(#"trigger");
			level.var_38ea4233 = waitresult.activator;
			level flag::set(#"hash_1c296f8c578e2659");
		}
	}
}

