// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_57f7003580bb15e0;
#using script_71dfbfdfba4489a0;
#using script_bd2b8aaa388dcce;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_cb42c6c0;

/*
	Name: function_89f2df9
	Namespace: namespace_cb42c6c0
	Checksum: 0x3311AE7D
	Offset: 0x388
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_32b5086207157433", &__init__, undefined, undefined);
}

#namespace namespace_6fde4e6;

/*
	Name: __constructor
	Namespace: namespace_6fde4e6
	Checksum: 0xBC861248
	Offset: 0x3D0
	Size: 0x32
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.claimed = 0;
	self.var_4f0ea1b5 = 0;
	self.owner = undefined;
	self.var_6f08706b = undefined;
}

/*
	Name: __destructor
	Namespace: namespace_6fde4e6
	Checksum: 0x80F724D1
	Offset: 0x410
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_cb42c6c0;

/*
	Name: function_6fde4e6
	Namespace: namespace_cb42c6c0
	Checksum: 0xC4B9A197
	Offset: 0x420
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_6fde4e6()
{
	classes.var_6fde4e6[0] = spawnstruct();
	classes.var_6fde4e6[0].__vtable[913321084] = &namespace_6fde4e6::__destructor;
	classes.var_6fde4e6[0].__vtable[674154906] = &namespace_6fde4e6::__constructor;
}

#namespace namespace_b599a4bc;

/*
	Name: __constructor
	Namespace: namespace_b599a4bc
	Checksum: 0x13A80887
	Offset: 0x4B0
	Size: 0x1A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_f6d13e1b = [];
	self.entity = undefined;
}

/*
	Name: __destructor
	Namespace: namespace_b599a4bc
	Checksum: 0x80F724D1
	Offset: 0x4D8
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_cb42c6c0;

/*
	Name: function_b599a4bc
	Namespace: namespace_cb42c6c0
	Checksum: 0xC0383FF7
	Offset: 0x4E8
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_b599a4bc()
{
	classes.var_b599a4bc[0] = spawnstruct();
	classes.var_b599a4bc[0].__vtable[913321084] = &namespace_b599a4bc::__destructor;
	classes.var_b599a4bc[0].__vtable[674154906] = &namespace_b599a4bc::__constructor;
}

/*
	Name: __init__
	Namespace: namespace_cb42c6c0
	Checksum: 0x3D6D07E7
	Offset: 0x578
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_b595044c();
	level thread function_ccf7ac87();
	level.var_492142a5 = [#"lockdown_stub_type_wallbuys":&function_9c7d5271, #"lockdown_stub_type_traps":&function_d2ce5ac1, #"lockdown_stub_type_perks":&function_db989a2a, #"lockdown_stub_type_pap":&function_165e2bd6, #"lockdown_stub_type_magic_box":&function_e6761711, #"lockdown_stub_type_crafting_tables":&function_d0e1d38c, #"lockdown_stub_type_boards":&function_8850974b];
	level.var_85c076ab = [];
	/#
		level function_946bb116();
	#/
}

/*
	Name: function_b595044c
	Namespace: namespace_cb42c6c0
	Checksum: 0xA05953AB
	Offset: 0x6C8
	Size: 0x104
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b595044c()
{
	level endon(#"end_game");
	if(!isdefined(level.var_f17bdf53))
	{
		level.var_f17bdf53 = [];
	}
	if(!isdefined(level.var_9eb62765))
	{
		level.var_9eb62765 = [];
	}
	if(!isdefined(level.var_9235b607))
	{
		level.var_9235b607 = [];
	}
	if(!isdefined(level.var_16cfe3ef))
	{
		level.var_16cfe3ef = [];
	}
	level flagsys::wait_till("start_zombie_round_logic");
	function_eeeb30d7();
	function_9559446b();
	function_f7bd473a();
	level flag::wait_till("pap_machine_active");
	function_2bdb235d();
}

/*
	Name: function_ccf7ac87
	Namespace: namespace_cb42c6c0
	Checksum: 0x8905857D
	Offset: 0x7D8
	Size: 0x1EA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ccf7ac87()
{
	level endon(#"end_game");
	if(!isdefined(level.var_2510f3e4))
	{
		level.var_2510f3e4 = [];
	}
	level flagsys::wait_till("start_zombie_round_logic");
	traps = getentarray("zombie_trap", "targetname");
	foreach(trap in traps)
	{
		if(!isdefined(trap._trap_use_trigs))
		{
			continue;
		}
		foreach(var_d59d25cc in trap._trap_use_trigs)
		{
			if(!isdefined(var_d59d25cc._trap))
			{
				continue;
			}
			if(!isdefined(level.var_2510f3e4))
			{
				level.var_2510f3e4 = [];
			}
			else if(!isarray(level.var_2510f3e4))
			{
				level.var_2510f3e4 = array(level.var_2510f3e4);
			}
			level.var_2510f3e4[level.var_2510f3e4.size] = var_d59d25cc;
		}
	}
}

/*
	Name: function_d67bafb5
	Namespace: namespace_cb42c6c0
	Checksum: 0xD330AD11
	Offset: 0x9D0
	Size: 0x382
	Parameters: 2
	Flags: Linked
*/
function function_d67bafb5(stub, category)
{
	if(!isdefined(stub) || !isdefined(category))
	{
		return;
	}
	switch(category)
	{
		case "lockdown_stub_type_wallbuys":
		{
			if(!isdefined(level.var_f17bdf53))
			{
				level.var_f17bdf53 = [];
			}
			if(!isinarray(level.var_f17bdf53, stub))
			{
				if(!isdefined(level.var_f17bdf53))
				{
					level.var_f17bdf53 = [];
				}
				else if(!isarray(level.var_f17bdf53))
				{
					level.var_f17bdf53 = array(level.var_f17bdf53);
				}
				level.var_f17bdf53[level.var_f17bdf53.size] = stub;
			}
			break;
		}
		case "lockdown_stub_type_pap":
		{
			if(!isdefined(level.var_9eb62765))
			{
				level.var_9eb62765 = [];
			}
			if(!isinarray(level.var_9eb62765, stub))
			{
				if(!isdefined(level.var_9eb62765))
				{
					level.var_9eb62765 = [];
				}
				else if(!isarray(level.var_9eb62765))
				{
					level.var_9eb62765 = array(level.var_9eb62765);
				}
				level.var_9eb62765[level.var_9eb62765.size] = stub;
			}
			break;
		}
		case "lockdown_stub_type_perks":
		{
			if(!isdefined(level.var_9235b607))
			{
				level.var_9235b607 = [];
			}
			if(!isinarray(level.var_9235b607, stub))
			{
				if(!isdefined(level.var_9235b607))
				{
					level.var_9235b607 = [];
				}
				else if(!isarray(level.var_9235b607))
				{
					level.var_9235b607 = array(level.var_9235b607);
				}
				level.var_9235b607[level.var_9235b607.size] = stub;
			}
			break;
		}
		case "lockdown_stub_type_crafting_tables":
		{
			if(!isdefined(level.var_16cfe3ef))
			{
				level.var_16cfe3ef = [];
			}
			if(!isinarray(level.var_16cfe3ef, stub))
			{
				if(!isdefined(level.var_16cfe3ef))
				{
					level.var_16cfe3ef = [];
				}
				else if(!isarray(level.var_16cfe3ef))
				{
					level.var_16cfe3ef = array(level.var_16cfe3ef);
				}
				level.var_16cfe3ef[level.var_16cfe3ef.size] = stub;
			}
			break;
		}
	}
}

/*
	Name: function_6b9e848
	Namespace: namespace_cb42c6c0
	Checksum: 0xC494E410
	Offset: 0xD60
	Size: 0x164
	Parameters: 1
	Flags: Linked
*/
function function_6b9e848(stub)
{
	function_77caff8b(stub);
	if(isdefined(level.var_f17bdf53) && isinarray(level.var_f17bdf53, stub))
	{
		arrayremovevalue(level.var_f17bdf53, stub);
	}
	if(isdefined(level.var_9eb62765) && isinarray(level.var_9eb62765, stub))
	{
		arrayremovevalue(level.var_9eb62765, stub);
	}
	if(isdefined(level.var_9235b607) && isinarray(level.var_9235b607, stub))
	{
		arrayremovevalue(level.var_9235b607, stub);
	}
	if(isdefined(level.var_16cfe3ef) && isinarray(level.var_16cfe3ef, stub))
	{
		arrayremovevalue(level.var_16cfe3ef, stub);
	}
}

/*
	Name: function_b913ec1b
	Namespace: namespace_cb42c6c0
	Checksum: 0xFD75716F
	Offset: 0xED0
	Size: 0xC0
	Parameters: 2
	Flags: Linked, Private
*/
private function function_b913ec1b(targetname, category)
{
	foreach(stub in level._unitriggers.trigger_stubs)
	{
		if(isdefined(stub.targetname) && stub.targetname == targetname)
		{
			function_d67bafb5(stub, category);
		}
	}
}

/*
	Name: function_eeeb30d7
	Namespace: namespace_cb42c6c0
	Checksum: 0x91706612
	Offset: 0xF98
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
private function function_eeeb30d7()
{
	function_b913ec1b("weapon_upgrade", "lockdown_stub_type_wallbuys");
	function_b913ec1b("bowie_upgrade", "lockdown_stub_type_wallbuys");
}

/*
	Name: function_9559446b
	Namespace: namespace_cb42c6c0
	Checksum: 0xE5A171A7
	Offset: 0xFE8
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function function_9559446b()
{
	function_b913ec1b("perk_vapor_altar_stub", "lockdown_stub_type_perks");
}

/*
	Name: function_f7bd473a
	Namespace: namespace_cb42c6c0
	Checksum: 0x90865364
	Offset: 0x1018
	Size: 0x24
	Parameters: 0
	Flags: Linked, Private
*/
private function function_f7bd473a()
{
	function_b913ec1b("crafting_trigger", "lockdown_stub_type_crafting_tables");
}

/*
	Name: function_2bdb235d
	Namespace: namespace_cb42c6c0
	Checksum: 0x75C4012F
	Offset: 0x1048
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_2bdb235d()
{
	function_b913ec1b("pap_machine_stub", "lockdown_stub_type_pap");
}

/*
	Name: function_2bdff7e1
	Namespace: namespace_cb42c6c0
	Checksum: 0xDDDAC90A
	Offset: 0x1078
	Size: 0xEA
	Parameters: 3
	Flags: Linked, Private
*/
private function function_2bdff7e1(entity, stub, node)
{
	var_5bd89846 = groundtrace(node.origin + vectorscale((0, 0, 1), 8), node.origin + vectorscale((0, 0, -1), 100000), 0, entity)[#"position"];
	var_66694b96 = {#angles:node.angles, #origin:var_5bd89846};
	if(!(isdefined(stub.var_7c2f9a8b) && stub.var_7c2f9a8b))
	{
		stub.var_66694b96 = var_66694b96;
	}
	return var_66694b96;
}

/*
	Name: function_dab6d796
	Namespace: namespace_cb42c6c0
	Checksum: 0x30C29BAC
	Offset: 0x1170
	Size: 0x394
	Parameters: 2
	Flags: Linked
*/
function function_dab6d796(entity, stub)
{
	if(!isdefined(stub))
	{
		return undefined;
	}
	if(isdefined(stub.var_66694b96))
	{
		return stub.var_66694b96;
	}
	if(isdefined(stub.target))
	{
		node = getnode(stub.target, "targetname");
		if(isdefined(node))
		{
			return function_2bdff7e1(entity, stub, node);
		}
	}
	radius = entity getpathfindingradius();
	height = entity function_6a9ae71();
	heightoffset = (0, 0, height * -1 / 2);
	var_e790dc87 = (radius, radius, height / 2);
	if(isentity(stub))
	{
		maxs = stub.maxs;
	}
	else
	{
		switch(stub.script_unitrigger_type)
		{
			case "unitrigger_box_use":
			{
				maxs = (stub.script_width / 2, stub.script_height / 2, stub.script_length / 2);
				break;
			}
			case "unitrigger_radius_use":
			{
				maxs = (stub.radius, stub.script_height / 2, stub.radius);
				break;
			}
		}
	}
	search_radius = max(max(maxs[0] + var_e790dc87[0], maxs[1] + var_e790dc87[1]), maxs[2] + var_e790dc87[2]);
	nodes = getnodearray("lockdown_alignment_node", "script_noteworthy");
	nodes = arraysortclosest(nodes, stub.origin + heightoffset, 1, 0, search_radius);
	fallback_node = undefined;
	foreach(node in nodes)
	{
		if(!isdefined(fallback_node))
		{
			fallback_node = node;
		}
		if(node.script_noteworthy === "lockdown_alignment_node")
		{
			return function_2bdff7e1(entity, stub, node);
		}
	}
	if(isdefined(fallback_node))
	{
		return function_2bdff7e1(entity, stub, fallback_node);
	}
}

/*
	Name: function_da72073
	Namespace: namespace_cb42c6c0
	Checksum: 0xF1EB681
	Offset: 0x1510
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_da72073(stub)
{
	if(!isdefined(stub))
	{
		return undefined;
	}
	if(isdefined(stub.fxnode))
	{
		return stub.fxnode;
	}
	if(isdefined(stub.script_height))
	{
		n_radius = stub.script_height;
	}
	else
	{
		n_radius = 64;
	}
	a_structs = struct::get_array("lockdown_fx", "targetname");
	fxnode = arraygetclosest(stub.origin, a_structs, n_radius);
	if(isdefined(fxnode) && (!(isdefined(stub.var_7e4bc0a2) && stub.var_7e4bc0a2)))
	{
		stub.fxnode = fxnode;
	}
	return fxnode;
}

/*
	Name: function_9f952db3
	Namespace: namespace_cb42c6c0
	Checksum: 0x7D38200C
	Offset: 0x1618
	Size: 0x184
	Parameters: 3
	Flags: Linked, Private
*/
private function function_9f952db3(stub, entity, maxheight)
{
	if(entity.origin[2] > stub.origin[2])
	{
		/#
			if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)
			{
				function_78eae22a(entity, stub, 7);
			}
		#/
		return 0;
	}
	if(stub.origin[2] - entity.origin[2] > maxheight)
	{
		/#
			if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)
			{
				function_78eae22a(entity, stub, 11, stub.origin[2] - entity.origin[2]);
			}
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_adb36e84
	Namespace: namespace_cb42c6c0
	Checksum: 0x4973A32
	Offset: 0x17A8
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
private function function_adb36e84(stub)
{
	self waittill(#"death");
	function_77caff8b(stub);
}

/*
	Name: function_77caff8b
	Namespace: namespace_cb42c6c0
	Checksum: 0xDBACEA3B
	Offset: 0x17E8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_77caff8b(stub)
{
	if(!isdefined(stub))
	{
		return;
	}
	var_a0692a89 = function_fd31eb92(stub);
	if(isdefined(var_a0692a89) && var_a0692a89.claimed)
	{
		function_66941fc3(stub);
	}
}

/*
	Name: function_66941fc3
	Namespace: namespace_cb42c6c0
	Checksum: 0xFDC77137
	Offset: 0x1858
	Size: 0x108
	Parameters: 1
	Flags: Linked, Private
*/
private function function_66941fc3(stub)
{
	for(var_77f297ef = 0; var_77f297ef < level.var_85c076ab.size; var_77f297ef++)
	{
		var_2943f1ec = level.var_85c076ab[var_77f297ef];
		for(index = 0; index < var_2943f1ec.var_f6d13e1b.size; index++)
		{
			if(var_2943f1ec.var_f6d13e1b[index].stub == stub)
			{
				var_2943f1ec.var_f6d13e1b = array::remove_index(var_2943f1ec.var_f6d13e1b, index);
				break;
			}
		}
		if(var_2943f1ec.var_f6d13e1b.size == 0)
		{
			level.var_85c076ab = array::remove_index(level.var_85c076ab, var_77f297ef);
		}
	}
}

/*
	Name: function_fd31eb92
	Namespace: namespace_cb42c6c0
	Checksum: 0x2AF1B7C7
	Offset: 0x1968
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
private function function_fd31eb92(stub)
{
	foreach(var_2943f1ec in level.var_85c076ab)
	{
		foreach(var_f1e20c7f in var_2943f1ec.var_f6d13e1b)
		{
			if(var_f1e20c7f.stub === stub || var_f1e20c7f.var_6f08706b === stub)
			{
				return var_f1e20c7f;
			}
		}
	}
}

/*
	Name: function_f7315b07
	Namespace: namespace_cb42c6c0
	Checksum: 0xC81BDAF1
	Offset: 0x1A78
	Size: 0x8A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f7315b07(entity)
{
	foreach(var_2943f1ec in level.var_85c076ab)
	{
		if(var_2943f1ec.entity === entity)
		{
			return var_2943f1ec;
		}
	}
}

/*
	Name: function_4ad92a9a
	Namespace: namespace_cb42c6c0
	Checksum: 0xE1CC281D
	Offset: 0x1B10
	Size: 0x10E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4ad92a9a(entity)
{
	foreach(var_2943f1ec in level.var_85c076ab)
	{
		if(var_2943f1ec.entity === entity)
		{
			foreach(var_f1e20c7f in var_2943f1ec.var_f6d13e1b)
			{
				if(isdefined(var_f1e20c7f.claimed) && var_f1e20c7f.claimed)
				{
					return var_f1e20c7f;
				}
			}
		}
	}
}

/*
	Name: function_e1f6d06a
	Namespace: namespace_cb42c6c0
	Checksum: 0x2519F1DE
	Offset: 0x1C28
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e1f6d06a(stub)
{
	var_f1e20c7f = function_fd31eb92(stub);
	return isdefined(var_f1e20c7f) && (isdefined(var_f1e20c7f.var_4f0ea1b5) && var_f1e20c7f.var_4f0ea1b5);
}

/*
	Name: function_55d2ad24
	Namespace: namespace_cb42c6c0
	Checksum: 0xE84C703A
	Offset: 0x1C88
	Size: 0x76
	Parameters: 2
	Flags: Linked, Private
*/
private function function_55d2ad24(stub, entity)
{
	var_f1e20c7f = function_fd31eb92(stub);
	return isdefined(var_f1e20c7f) && (isdefined(var_f1e20c7f.claimed) && var_f1e20c7f.claimed) && entity !== var_f1e20c7f.owner;
}

/*
	Name: function_d3fbb5ec
	Namespace: namespace_cb42c6c0
	Checksum: 0x39B3B545
	Offset: 0x1D08
	Size: 0x7C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_d3fbb5ec(entity, stub, current_zone)
{
	if(isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone)
	{
		/#
			function_78eae22a(entity, stub, 2);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_9c7d5271
	Namespace: namespace_cb42c6c0
	Checksum: 0x2BD74456
	Offset: 0x1D90
	Size: 0x1F4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_9c7d5271(entity, var_9c3aab26, range)
{
	current_zone = entity zm_utility::get_current_zone();
	stubs = arraysortclosest(level.var_f17bdf53, entity.origin, undefined, 0, range);
	foreach(stub in stubs)
	{
		if(function_e1f6d06a(stub))
		{
			/#
				function_78eae22a(entity, stub, 0);
			#/
			continue;
		}
		if(function_55d2ad24(stub, entity))
		{
			/#
				function_78eae22a(entity, stub, 1);
			#/
			continue;
		}
		if(!function_d3fbb5ec(entity, stub, current_zone))
		{
			continue;
		}
		stub.var_895b6b = "lockdown_stub_type_wallbuys";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, stub))
		{
			var_9c3aab26[var_9c3aab26.size] = stub;
		}
	}
}

/*
	Name: function_fea6f0c0
	Namespace: namespace_cb42c6c0
	Checksum: 0xAC7A6099
	Offset: 0x1F90
	Size: 0xD4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_fea6f0c0(entity, stub, current_zone)
{
	if(isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone)
	{
		/#
			function_78eae22a(entity, stub, 2);
		#/
		return 0;
	}
	if(isdefined(stub.var_3468124) && stub.var_3468124.var_2977c27 !== "on")
	{
		/#
			function_78eae22a(entity, stub, 17);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_db989a2a
	Namespace: namespace_cb42c6c0
	Checksum: 0x86FB9623
	Offset: 0x2070
	Size: 0x1F4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_db989a2a(entity, var_9c3aab26, range)
{
	current_zone = entity zm_utility::get_current_zone();
	stubs = arraysortclosest(level.var_9235b607, entity.origin, undefined, 0, range);
	foreach(stub in stubs)
	{
		if(function_e1f6d06a(stub))
		{
			/#
				function_78eae22a(entity, stub, 0);
			#/
			continue;
		}
		if(function_55d2ad24(stub, entity))
		{
			/#
				function_78eae22a(entity, stub, 1);
			#/
			continue;
		}
		if(!function_fea6f0c0(entity, stub, current_zone))
		{
			continue;
		}
		stub.var_895b6b = "lockdown_stub_type_perks";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, stub))
		{
			var_9c3aab26[var_9c3aab26.size] = stub;
		}
	}
}

/*
	Name: function_ea677a9a
	Namespace: namespace_cb42c6c0
	Checksum: 0x6E40E5AA
	Offset: 0x2270
	Size: 0x7C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_ea677a9a(entity, stub, current_zone)
{
	if(isdefined(current_zone) && isdefined(stub.in_zone) && stub.in_zone != current_zone)
	{
		/#
			function_78eae22a(entity, stub, 2);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_d0e1d38c
	Namespace: namespace_cb42c6c0
	Checksum: 0xC3A3C6E5
	Offset: 0x22F8
	Size: 0x1F4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_d0e1d38c(entity, var_9c3aab26, range)
{
	current_zone = entity zm_utility::get_current_zone();
	stubs = arraysortclosest(level.var_16cfe3ef, entity.origin, undefined, 0, range);
	foreach(stub in stubs)
	{
		if(function_e1f6d06a(stub))
		{
			/#
				function_78eae22a(entity, stub, 0);
			#/
			continue;
		}
		if(function_55d2ad24(stub, entity))
		{
			/#
				function_78eae22a(entity, stub, 1);
			#/
			continue;
		}
		if(!function_ea677a9a(entity, stub, current_zone))
		{
			continue;
		}
		stub.var_895b6b = "lockdown_stub_type_crafting_tables";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, stub))
		{
			var_9c3aab26[var_9c3aab26.size] = stub;
		}
	}
}

/*
	Name: function_95250640
	Namespace: namespace_cb42c6c0
	Checksum: 0xD0AD8517
	Offset: 0x24F8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_95250640(entity, stub)
{
	if(level flag::get("moving_chest_now"))
	{
		/#
			function_78eae22a(entity, stub.trigger_target, 15);
		#/
		return 0;
	}
	if(isdefined(stub.trigger_target.hidden) && stub.trigger_target.hidden)
	{
		/#
			function_78eae22a(entity, stub.trigger_target, 3);
		#/
		return 0;
	}
	if(isdefined(stub.trigger_target._box_open) && stub.trigger_target._box_open)
	{
		/#
			function_78eae22a(entity, stub.trigger_target, 4);
		#/
		return 0;
	}
	if(isdefined(stub.trigger_target.was_temp) && stub.trigger_target.was_temp || (isdefined(stub.trigger_target.being_removed) && stub.trigger_target.being_removed))
	{
		/#
			function_78eae22a(entity, stub.trigger_target, 13);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_e6761711
	Namespace: namespace_cb42c6c0
	Checksum: 0xABCE0130
	Offset: 0x26B8
	Size: 0x1EC
	Parameters: 3
	Flags: Linked, Private
*/
private function function_e6761711(entity, var_9c3aab26, range)
{
	chests = arraysortclosest(level.chests, entity.origin, undefined, 0, range);
	foreach(chest in chests)
	{
		if(!function_95250640(entity, chest.unitrigger_stub))
		{
			continue;
		}
		if(function_e1f6d06a(chest.unitrigger_stub))
		{
			/#
				function_78eae22a(entity, chest, 0);
			#/
			continue;
		}
		if(function_55d2ad24(chest.unitrigger_stub, entity))
		{
			/#
				function_78eae22a(entity, chest, 1);
			#/
			continue;
		}
		chest.unitrigger_stub.var_895b6b = "lockdown_stub_type_magic_box";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, chest.unitrigger_stub))
		{
			var_9c3aab26[var_9c3aab26.size] = chest.unitrigger_stub;
		}
	}
}

/*
	Name: function_790e3eb0
	Namespace: namespace_cb42c6c0
	Checksum: 0xB38F193D
	Offset: 0x28B0
	Size: 0xAC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_790e3eb0(entity, trigger)
{
	if(trigger.pap_machine.state !== "powered")
	{
		/#
			function_78eae22a(entity, trigger, 5);
		#/
		return 0;
	}
	if(!trigger.pap_machine flag::get("pap_waiting_for_user"))
	{
		/#
			function_78eae22a(entity, trigger, 6);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_165e2bd6
	Namespace: namespace_cb42c6c0
	Checksum: 0x9F1FF51F
	Offset: 0x2968
	Size: 0x1C4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_165e2bd6(entity, var_9c3aab26, range)
{
	if(!level flag::get("pap_machine_active"))
	{
		return;
	}
	foreach(stub in level.var_9eb62765)
	{
		if(function_55d2ad24(stub, entity))
		{
			/#
				function_78eae22a(entity, stub, 1);
			#/
			continue;
		}
		if(!function_790e3eb0(entity, stub))
		{
			continue;
		}
		if(function_e1f6d06a(stub))
		{
			/#
				function_78eae22a(entity, stub, 0);
			#/
			continue;
		}
		stub.var_895b6b = "lockdown_stub_type_pap";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, stub))
		{
			var_9c3aab26[var_9c3aab26.size] = stub;
		}
	}
}

/*
	Name: function_809ae5cb
	Namespace: namespace_cb42c6c0
	Checksum: 0x2C8C510E
	Offset: 0x2B38
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
private function function_809ae5cb(entity, blocker)
{
	if(zm_utility::all_chunks_destroyed(blocker, blocker.barrier_chunks))
	{
		/#
			function_78eae22a(entity, blocker, 12);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_8850974b
	Namespace: namespace_cb42c6c0
	Checksum: 0xCC10C819
	Offset: 0x2BA8
	Size: 0x1F4
	Parameters: 3
	Flags: Linked, Private
*/
private function function_8850974b(entity, var_9c3aab26, range)
{
	blockers = arraysortclosest(level.exterior_goals, entity.origin, undefined, 0, range);
	foreach(blocker in blockers)
	{
		if(function_55d2ad24(blocker, entity))
		{
			/#
				function_78eae22a(entity, blocker, 1);
			#/
			continue;
		}
		if(function_e1f6d06a(blocker))
		{
			/#
				function_78eae22a(entity, blocker, 0);
			#/
			continue;
		}
		if(!function_809ae5cb(entity, blocker))
		{
			/#
				function_78eae22a(entity, blocker, 12);
			#/
			continue;
		}
		blocker.var_895b6b = "lockdown_stub_type_boards";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, blocker))
		{
			var_9c3aab26[var_9c3aab26.size] = blocker;
		}
	}
}

/*
	Name: function_387fd27e
	Namespace: namespace_cb42c6c0
	Checksum: 0xE58B31A8
	Offset: 0x2DA8
	Size: 0x74
	Parameters: 2
	Flags: Linked, Private
*/
private function function_387fd27e(entity, var_d59d25cc)
{
	if(!var_d59d25cc._trap._trap_in_use || !var_d59d25cc._trap istriggerenabled())
	{
		/#
			function_78eae22a(entity, var_d59d25cc, 16);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_d2ce5ac1
	Namespace: namespace_cb42c6c0
	Checksum: 0xBB58E25
	Offset: 0x2E28
	Size: 0x194
	Parameters: 3
	Flags: Linked, Private
*/
private function function_d2ce5ac1(entity, var_9c3aab26, range)
{
	trap_trigs = arraysortclosest(level.var_2510f3e4, entity.origin, undefined, 0, range);
	foreach(var_d59d25cc in trap_trigs)
	{
		if(function_55d2ad24(var_d59d25cc, entity))
		{
			/#
				function_78eae22a(entity, var_d59d25cc, 1);
			#/
			continue;
		}
		if(!function_387fd27e(entity, var_d59d25cc))
		{
			continue;
		}
		var_d59d25cc.var_895b6b = "lockdown_stub_type_traps";
		if(!isdefined(var_9c3aab26))
		{
			var_9c3aab26 = [];
		}
		else if(!isarray(var_9c3aab26))
		{
			var_9c3aab26 = array(var_9c3aab26);
		}
		if(!isinarray(var_9c3aab26, var_d59d25cc))
		{
			var_9c3aab26[var_9c3aab26.size] = var_d59d25cc;
		}
	}
}

/*
	Name: function_22aeb4e9
	Namespace: namespace_cb42c6c0
	Checksum: 0x4F812602
	Offset: 0x2FC8
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function function_22aeb4e9(var_895b6b)
{
	switch(var_895b6b)
	{
		case "lockdown_stub_type_pap":
		{
			return "PAP";
		}
		case "lockdown_stub_type_magic_box":
		{
			return "MAGIC_BOX";
		}
		case "lockdown_stub_type_boards":
		{
			return "BOARDS";
		}
		case "lockdown_stub_type_wallbuys":
		{
			return "WALLBUY";
		}
		case "lockdown_stub_type_crafting_tables":
		{
			return "CRAFTING_TABLE";
		}
		case "lockdown_stub_type_perks":
		{
			return "PERK";
		}
		case "lockdown_stub_type_traps":
		{
			return "TRAP";
		}
	}
	return "INVALID";
}

/*
	Name: function_87c1193e
	Namespace: namespace_cb42c6c0
	Checksum: 0xF0C99577
	Offset: 0x30A8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_87c1193e(entity)
{
	var_a0692a89 = function_4ad92a9a(entity);
	if(isdefined(var_a0692a89))
	{
		return var_a0692a89.stub;
	}
}

/*
	Name: function_50ba1eb0
	Namespace: namespace_cb42c6c0
	Checksum: 0x4A236E4F
	Offset: 0x30F8
	Size: 0x144
	Parameters: 2
	Flags: Linked
*/
function function_50ba1eb0(entity, stub)
{
	var_2943f1ec = function_f7315b07(entity);
	if(!isdefined(var_2943f1ec))
	{
		object = new var_b599a4bc();
		[[ object ]]->__constructor();
		var_2943f1ec = object;
		var_2943f1ec.entity = entity;
		array::add(level.var_85c076ab, var_2943f1ec);
	}
	var_f1e20c7f = function_fd31eb92(stub);
	if(!isdefined(var_f1e20c7f))
	{
		object = new var_6fde4e6();
		[[ object ]]->__constructor();
		var_f1e20c7f = object;
		var_f1e20c7f.stub = stub;
		var_f1e20c7f.owner = entity;
		var_f1e20c7f.claimed = 1;
		array::add(var_2943f1ec.var_f6d13e1b, var_f1e20c7f);
		/#
			function_78eae22a(entity, stub, 10);
		#/
	}
	entity thread function_adb36e84(stub);
}

/*
	Name: function_9b84bb88
	Namespace: namespace_cb42c6c0
	Checksum: 0x4DCDB9E9
	Offset: 0x3248
	Size: 0x1DA
	Parameters: 4
	Flags: Linked
*/
function function_9b84bb88(entity, var_f2b00446, var_d05e79c8, var_c7455683)
{
	/#
		if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)
		{
			entity.var_d187874c = [];
		}
	#/
	var_9c3aab26 = [];
	foreach(var_b7d35f70 in var_f2b00446)
	{
		[[level.var_492142a5[var_b7d35f70]]](entity, var_9c3aab26, var_d05e79c8);
	}
	var_9c3aab26 = array::filter(var_9c3aab26, 0, &function_9f952db3, entity, var_c7455683);
	/#
		if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)
		{
			function_6351d1c3(entity, var_9c3aab26, var_d05e79c8);
		}
	#/
	return arraysortclosest(var_9c3aab26, entity.origin);
}

/*
	Name: function_7258b5cc
	Namespace: namespace_cb42c6c0
	Checksum: 0x79802153
	Offset: 0x3430
	Size: 0x3AA
	Parameters: 4
	Flags: Linked
*/
function function_7258b5cc(entity, var_410a8c7, var_2baba799, var_22c317cc)
{
	var_a0692a89 = function_4ad92a9a(entity);
	if(!isdefined(var_a0692a89) || !isdefined(var_a0692a89.stub))
	{
		return;
	}
	if(!function_c9105448(entity, var_a0692a89.stub))
	{
		function_77caff8b(var_a0692a89.stub);
		return undefined;
	}
	stub = var_a0692a89.stub;
	if(stub.var_895b6b === "lockdown_stub_type_boards")
	{
		zm_blockers::function_b193ea5c(stub);
		function_66941fc3(stub);
		return;
	}
	if(stub.var_895b6b === "lockdown_stub_type_traps")
	{
		stub._trap notify(#"hash_2133afbbd7534561");
		function_66941fc3(stub);
		return;
	}
	if(!isentity(stub))
	{
		if(!isdefined(stub.var_a0fc37f6))
		{
			stub.var_a0fc37f6 = stub.prompt_and_visibility_func;
		}
		stub.prompt_and_visibility_func = var_410a8c7;
		if(!isdefined(stub.var_492080a5))
		{
			stub.var_492080a5 = stub.trigger_func;
		}
		stub.trigger_func = var_2baba799;
		zm_unitrigger::reregister_unitrigger(stub);
	}
	else
	{
		stub triggerenable(0);
		var_f7847972 = stub zm_unitrigger::function_9267812e(stub.maxs[0] - stub.mins[0], stub.maxs[1] - stub.mins[1], stub.maxs[2] - stub.mins[2]);
		var_f7847972.prompt_and_visibility_func = var_410a8c7;
		var_f7847972.var_6f08706b = stub;
		var_f7847972.var_895b6b = stub.var_895b6b;
		var_f7847972.script_string = stub.script_string;
		stub.var_895b6b = undefined;
		stub.var_25df04b4 = var_f7847972;
		var_a0692a89.stub = var_f7847972;
		var_a0692a89.var_6f08706b = stub;
		stub = var_f7847972;
		zm_unitrigger::register_unitrigger(var_f7847972, var_2baba799);
	}
	if(stub.var_895b6b === "lockdown_stub_type_perks")
	{
		stub.var_3468124 zm_perks::function_efd2c9e6();
	}
	stub.var_22c317cc = var_22c317cc;
	var_a0692a89.var_4f0ea1b5 = 1;
	var_a0692a89.claimed = 0;
	return stub;
}

/*
	Name: function_7bfa8895
	Namespace: namespace_cb42c6c0
	Checksum: 0x14BE78CF
	Offset: 0x37E8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_7bfa8895(entity)
{
	return isdefined(function_4ad92a9a(entity));
}

/*
	Name: function_b5dd9241
	Namespace: namespace_cb42c6c0
	Checksum: 0xF074627A
	Offset: 0x3818
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_b5dd9241(stub)
{
	var_a0692a89 = function_fd31eb92(stub);
	if(!isdefined(var_a0692a89))
	{
		return 0;
	}
	return var_a0692a89.var_4f0ea1b5 === 1;
}

/*
	Name: function_c9105448
	Namespace: namespace_cb42c6c0
	Checksum: 0xD68DC43A
	Offset: 0x3870
	Size: 0x1C2
	Parameters: 2
	Flags: Linked
*/
function function_c9105448(entity, stub)
{
	switch(stub.var_895b6b)
	{
		case "lockdown_stub_type_boards":
		{
			return function_809ae5cb(entity, stub);
		}
		case "lockdown_stub_type_crafting_tables":
		{
			current_zone = entity zm_utility::get_current_zone();
			return function_ea677a9a(entity, stub, current_zone);
		}
		case "lockdown_stub_type_magic_box":
		{
			return function_95250640(entity, stub);
		}
		case "lockdown_stub_type_pap":
		{
			return function_790e3eb0(entity, stub);
		}
		case "lockdown_stub_type_perks":
		{
			current_zone = entity zm_utility::get_current_zone();
			return function_fea6f0c0(entity, stub, current_zone);
		}
		case "lockdown_stub_type_wallbuys":
		{
			current_zone = entity zm_utility::get_current_zone();
			return function_d3fbb5ec(entity, stub, current_zone);
		}
		case "lockdown_stub_type_traps":
		{
			return function_387fd27e(entity, stub);
		}
		default:
		{
			return 1;
		}
	}
}

/*
	Name: function_ac6907ec
	Namespace: namespace_cb42c6c0
	Checksum: 0x57D58720
	Offset: 0x3A40
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_ac6907ec()
{
	var_a0692a89 = function_fd31eb92(self);
	if(isdefined(var_a0692a89))
	{
		var_a0692a89.var_4f0ea1b5 = 2;
	}
	if(isdefined(self) && isdefined(self.var_22c317cc))
	{
		[[self.var_22c317cc]](self);
	}
	self.prompt_and_visibility_func = self.var_a0fc37f6;
	self.trigger_func = self.var_492080a5;
	if(self.var_895b6b === "lockdown_stub_type_perks")
	{
		self.var_3468124 zm_perks::function_1e721859();
	}
	self.var_a0fc37f6 = undefined;
	self.var_492080a5 = undefined;
	function_66941fc3(self);
	zm_unitrigger::reregister_unitrigger(self);
}

/*
	Name: function_4de23f77
	Namespace: namespace_cb42c6c0
	Checksum: 0x9792C0E0
	Offset: 0x3B40
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_4de23f77()
{
	var_a0692a89 = function_fd31eb92(self);
	if(isdefined(var_a0692a89))
	{
		var_a0692a89.var_4f0ea1b5 = 2;
	}
	self.var_6f08706b.var_25df04b4 = undefined;
	if(isdefined(self) && isdefined(self.var_22c317cc))
	{
		[[self.var_22c317cc]](self);
	}
	self.var_6f08706b triggerenable(1);
	function_66941fc3(self);
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_61a9bc58
	Namespace: namespace_cb42c6c0
	Checksum: 0x83277D2
	Offset: 0x3C10
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_61a9bc58()
{
	var_a0692a89 = function_fd31eb92(self);
	/#
		assert(isdefined(var_a0692a89));
	#/
	self.var_6156031a = 1;
	if(isdefined(self.var_6f08706b))
	{
		self function_4de23f77();
	}
	else
	{
		self function_ac6907ec();
	}
	self.var_6156031a = undefined;
}

/*
	Name: function_78eae22a
	Namespace: namespace_cb42c6c0
	Checksum: 0xEB0573CB
	Offset: 0x3CB0
	Size: 0x136
	Parameters: 4
	Flags: Variadic
*/
function function_78eae22a(entity, stub, reason, vararg)
{
	/#
		if(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1)
		{
			if(!isdefined(entity.var_d187874c))
			{
				entity.var_d187874c = [];
			}
			else if(!isarray(entity.var_d187874c))
			{
				entity.var_d187874c = array(entity.var_d187874c);
			}
			entity.var_d187874c[entity.var_d187874c.size] = {#args:vararg, #reason:reason, #stub:stub};
		}
	#/
}

/*
	Name: function_f3cff6ff
	Namespace: namespace_cb42c6c0
	Checksum: 0xF74630D8
	Offset: 0x3DF0
	Size: 0x530
	Parameters: 1
	Flags: None
*/
function function_f3cff6ff(entity)
{
	/#
		if(!(getdvarint(#"hash_3ec02cda135af40f", 0) == 1 && getdvarint(#"recorder_enablerec", 0) == 1))
		{
			return;
		}
		if(!isdefined(entity.var_d187874c))
		{
			return;
		}
		if(getdvarint(#"hash_11ff7a9ab79d4434", -1) != entity getentitynumber())
		{
			return;
		}
		foreach(var_ca00d79a in entity.var_d187874c)
		{
			text = entity getentitynumber() + "";
			color = (1, 0, 0);
			switch(var_ca00d79a.reason)
			{
				case 0:
				{
					text = text + "";
					break;
				}
				case 1:
				{
					text = text + "";
					break;
				}
				case 2:
				{
					text = text + "";
					break;
				}
				case 3:
				{
					text = text + "";
					break;
				}
				case 4:
				{
					text = text + "";
					break;
				}
				case 5:
				{
					text = text + "";
					break;
				}
				case 6:
				{
					text = text + "";
					break;
				}
				case 8:
				{
					text = text + "" + var_ca00d79a.args[0];
					break;
				}
				case 9:
				{
					text = text + "";
					break;
				}
				case 7:
				{
					text = text + "";
					break;
				}
				case 11:
				{
					text = text + "" + var_ca00d79a.args[0];
					break;
				}
				case 10:
				{
					text = text + "";
					color = (0, 1, 0);
					break;
				}
				case 13:
				{
					text = text + "";
					break;
				}
				case 14:
				{
					text = text + "";
					recordstar(var_ca00d79a.args[0], (0, 1, 1));
					recordstar(var_ca00d79a.args[1].origin, (1, 0, 1));
					recordline(var_ca00d79a.args[1].origin, var_ca00d79a.args[1].origin + anglestoforward(var_ca00d79a.args[1].angles) * 10, (1, 1, 0));
					break;
				}
				case 15:
				{
					text = text + "";
					break;
				}
				case 16:
				{
					text = text + "";
					break;
				}
				case 17:
				{
					text = text + "";
					break;
				}
			}
			recordstar(var_ca00d79a.stub.origin, (1, 1, 0));
			record3dtext(text, var_ca00d79a.stub.origin + vectorscale((0, 0, 1), 10), color);
		}
	#/
}

/*
	Name: function_6351d1c3
	Namespace: namespace_cb42c6c0
	Checksum: 0x270714C5
	Offset: 0x4328
	Size: 0xF0
	Parameters: 3
	Flags: Private
*/
private function function_6351d1c3(entity, var_9c3aab26, var_d05e79c8)
{
	/#
		foreach(stub in var_9c3aab26)
		{
			dist = distancesquared(entity.origin, stub.origin);
			if(dist > var_d05e79c8 * var_d05e79c8)
			{
				function_78eae22a(entity, stub, 8, sqrt(dist));
			}
		}
	#/
}

/*
	Name: function_946bb116
	Namespace: namespace_cb42c6c0
	Checksum: 0x993CCB4C
	Offset: 0x4420
	Size: 0xA4
	Parameters: 0
	Flags: Private
*/
private function function_946bb116()
{
	/#
		zm_devgui::add_custom_devgui_callback(&function_2765c63);
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_2765c63
	Namespace: namespace_cb42c6c0
	Checksum: 0x553BB578
	Offset: 0x44D0
	Size: 0xAA
	Parameters: 1
	Flags: Private
*/
private function function_2765c63(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_619d20b906a39230":
			{
				level.var_cd20e41b = !(isdefined(level.var_cd20e41b) && level.var_cd20e41b);
				if(isdefined(level.var_cd20e41b) && level.var_cd20e41b)
				{
					level thread function_6e1690d5();
				}
				else
				{
					level notify(#"hash_52b90374b27fcb8a");
				}
				break;
			}
		}
	#/
}

/*
	Name: function_6e1690d5
	Namespace: namespace_cb42c6c0
	Checksum: 0x41D379C4
	Offset: 0x4588
	Size: 0x3B4
	Parameters: 0
	Flags: Private
*/
private function function_6e1690d5()
{
	/#
		self notify("");
		self endon("");
		level endon(#"hash_52b90374b27fcb8a");
		stubs = arraycombine(level.exterior_goals, level.var_16cfe3ef, 0, 0);
		stubs = arraycombine(stubs, level.var_9eb62765, 0, 0);
		stubs = arraycombine(stubs, level.var_9235b607, 0, 0);
		stubs = arraycombine(stubs, level.var_2510f3e4, 0, 0);
		stubs = arraycombine(stubs, level.var_f17bdf53, 0, 0);
		foreach(chest in level.chests)
		{
			if(!isdefined(stubs))
			{
				stubs = [];
			}
			else if(!isarray(stubs))
			{
				stubs = array(stubs);
			}
			stubs[stubs.size] = chest.unitrigger_stub;
		}
		var_3bd3c0c1 = vectorscale((-1, -1, 0), 16);
		var_cbe5413e = (16, 16, 32);
		while(true)
		{
			wait(0.5);
			entity = getentbynum(getdvarint(#"hash_11ff7a9ab79d4434", -1));
			if(!isdefined(entity))
			{
				continue;
			}
			foreach(stub in stubs)
			{
				var_754b10b4 = function_dab6d796(entity, stub);
				if(isdefined(var_754b10b4))
				{
					box(var_754b10b4.origin, var_3bd3c0c1, var_cbe5413e, var_754b10b4.angles[1], (0, 1, 0), 1, 0, 10);
					line(var_754b10b4.origin, var_754b10b4.origin + anglestoforward(var_754b10b4.angles) * 32, (0, 1, 0), 1, 0, 10);
					continue;
				}
				circle(stub.origin, 16, (1, 0, 0), 0, 0, 10);
			}
		}
	#/
}

