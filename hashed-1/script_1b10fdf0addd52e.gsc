// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace namespace_3fffba66;

/*
	Name: function_89f2df9
	Namespace: namespace_3fffba66
	Checksum: 0xEAFBF076
	Offset: 0x148
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4acf2a20bb34dae3", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3fffba66
	Checksum: 0x5F2F0B38
	Offset: 0x190
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_b175714d = [];
	level thread update();
	clientfield::register("actor", "transformation_spawn", 1, 1, "int");
	clientfield::register("actor", "transformation_stream_split", 1, 1, "int");
	level flag::init(#"hash_670ec83e1acfadff");
	level.var_50f7dbd5 = [];
	level.var_ebccd551 = [];
	/#
		level thread devgui();
	#/
}

/*
	Name: function_4da8230b
	Namespace: namespace_3fffba66
	Checksum: 0x79419667
	Offset: 0x280
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function function_4da8230b(var_736940b3)
{
	/#
		assert(function_7a600918(var_736940b3), "");
	#/
	if(!isdefined(level.var_50f7dbd5))
	{
		level.var_50f7dbd5 = [];
	}
	else if(!isarray(level.var_50f7dbd5))
	{
		level.var_50f7dbd5 = array(level.var_50f7dbd5);
	}
	level.var_50f7dbd5[level.var_50f7dbd5.size] = var_736940b3;
	if(level.var_50f7dbd5.size == 1)
	{
		level flag::set(#"hash_670ec83e1acfadff");
		level notify(#"hash_239ebc19aab5a60b");
	}
}

/*
	Name: function_6b183c78
	Namespace: namespace_3fffba66
	Checksum: 0xD86B88C2
	Offset: 0x390
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_6b183c78(var_736940b3)
{
	/#
		assert(function_7a600918(var_736940b3), "");
	#/
	foreach(index, var_8aa9ab80 in level.var_50f7dbd5)
	{
		if(var_8aa9ab80 == var_736940b3)
		{
			var_689205d = index;
			break;
		}
	}
	if(!isdefined(var_689205d))
	{
		return;
	}
	arrayremoveindex(level.var_50f7dbd5, var_689205d);
	if(level.var_50f7dbd5.size == 0)
	{
		level flag::clear(#"hash_670ec83e1acfadff");
	}
}

/*
	Name: function_770908a2
	Namespace: namespace_3fffba66
	Checksum: 0xBCC1C046
	Offset: 0x4C0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_770908a2()
{
	return level flag::get(#"hash_670ec83e1acfadff");
}

/*
	Name: function_cfca77a7
	Namespace: namespace_3fffba66
	Checksum: 0xE4EACB44
	Offset: 0x4F0
	Size: 0x4A6
	Parameters: 9
	Flags: Linked
*/
function function_cfca77a7(var_42de336c, id, var_705257b9, cooldown_time, var_899e4029, var_497b36fd, var_44c5827d, var_99fca475, var_accb1c92)
{
	/#
		assert(!isdefined(level.var_b175714d[id]));
	#/
	/#
		if(!isdefined(var_42de336c))
		{
			println("" + id + "");
			return;
		}
		if(isdefined(var_99fca475) && isentity(var_42de336c))
		{
			spawner = var_42de336c;
			if(!isdefined(spawner.targetname) || spawner.targetname == "")
			{
				println("" + id + "" + var_99fca475 + "");
				return;
			}
			var_de6be79a = 0;
			scenedef = scene::get_scenedef(var_99fca475);
			foreach(object in scenedef.objects)
			{
				if(object.type === "" && object.name === spawner.targetname)
				{
					var_de6be79a = 1;
					break;
				}
			}
			if(!var_de6be79a)
			{
				println("" + id + "" + spawner.targetname);
				return;
			}
		}
		if(isdefined(var_44c5827d) && !isdefined(var_99fca475))
		{
			println("" + id + "");
			return;
		}
		if(!isdefined(var_44c5827d) && isdefined(var_99fca475))
		{
			println("" + id + "");
			return;
		}
		if(!isentity(var_42de336c) && !isassetloaded("", var_42de336c))
		{
			println("" + id + "" + (function_7a600918(var_42de336c) ? function_9e72a96(var_42de336c) : var_42de336c) + "");
			return;
		}
	#/
	level.var_b175714d[id] = {#hash_2939a01a:[], #hash_33e393a7:0, #hash_ebaa8de9:0, #cooldown_time:cooldown_time, #hash_99fca475:var_99fca475, #hash_44c5827d:var_44c5827d, #hash_accb1c92:var_accb1c92, #hash_497b36fd:var_497b36fd, #hash_899e4029:var_899e4029, #condition:var_705257b9};
	if(isentity(var_42de336c))
	{
		level.var_b175714d[id].spawner = var_42de336c;
	}
	else
	{
		level.var_b175714d[id].aitype = var_42de336c;
		if(!isdefined(level.var_170852dc))
		{
			level.var_170852dc = [];
		}
	}
}

/*
	Name: function_abf1dcb4
	Namespace: namespace_3fffba66
	Checksum: 0xE7940957
	Offset: 0x9A0
	Size: 0x106
	Parameters: 1
	Flags: Linked
*/
function function_abf1dcb4(id)
{
	if(level.var_ebccd551.size >= 10)
	{
		return 1;
	}
	if(isdefined(level.var_88de5053) && level.var_ebccd551.size >= level.var_88de5053)
	{
		return 1;
	}
	if(isdefined(level.var_b175714d[id]) && isdefined(level.var_b175714d[id].spawner))
	{
		return isdefined(level.var_b175714d[id].spawner.var_ab46c56);
	}
	if(isdefined(level.var_b175714d[id]) && isdefined(level.var_b175714d[id].aitype))
	{
		return isdefined(level.var_170852dc[level.var_b175714d[id].aitype]);
	}
	return 0;
}

/*
	Name: function_9acf76e6
	Namespace: namespace_3fffba66
	Checksum: 0x7EB48892
	Offset: 0xAB0
	Size: 0x184
	Parameters: 4
	Flags: Linked
*/
function function_9acf76e6(entity, id, var_c2a69066, var_2cf708f4 = 1)
{
	if(!isdefined(level.var_b175714d[id]))
	{
		/#
			iprintlnbold("" + id + "");
		#/
		return;
	}
	if(!isdefined(entity) || (isdefined(entity.var_69a981e6) && entity.var_69a981e6))
	{
		/#
			iprintlnbold("" + id + "");
		#/
		return;
	}
	if(function_abf1dcb4(id))
	{
		/#
			iprintlnbold("" + id + "");
		#/
		return;
	}
	if(function_331869(entity))
	{
		function_1afce5aa(entity);
	}
	var_167b5341 = level.var_b175714d[id];
	entity thread transform(id, var_c2a69066, var_2cf708f4);
}

/*
	Name: function_bdd8aba6
	Namespace: namespace_3fffba66
	Checksum: 0x5EFE24B3
	Offset: 0xC40
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_bdd8aba6(id)
{
	if(!isdefined(level.var_b175714d[id]))
	{
		/#
			iprintlnbold("" + id + "");
		#/
		return;
	}
	level.var_b175714d[id].var_33e393a7++;
}

/*
	Name: function_3f502557
	Namespace: namespace_3fffba66
	Checksum: 0x31561C3
	Offset: 0xCB0
	Size: 0x58
	Parameters: 1
	Flags: None
*/
function function_3f502557(id)
{
	/#
		assert(level.var_b175714d[id].var_33e393a7 > 0);
	#/
	level.var_b175714d[id].var_33e393a7--;
}

/*
	Name: function_d2374144
	Namespace: namespace_3fffba66
	Checksum: 0xB3EF1727
	Offset: 0xD10
	Size: 0x1AC
	Parameters: 2
	Flags: Linked
*/
function function_d2374144(entity, id)
{
	/#
		assert(!(isdefined(entity.var_69a981e6) && entity.var_69a981e6));
	#/
	/#
		assert(!isinarray(level.var_b175714d[id].var_2939a01a, entity));
	#/
	/#
		assert(!(isdefined(entity.var_d41ca76d) && entity.var_d41ca76d));
	#/
	entity.var_d41ca76d = id;
	if(!isdefined(level.var_b175714d[id].var_2939a01a))
	{
		level.var_b175714d[id].var_2939a01a = [];
	}
	else if(!isarray(level.var_b175714d[id].var_2939a01a))
	{
		level.var_b175714d[id].var_2939a01a = array(level.var_b175714d[id].var_2939a01a);
	}
	level.var_b175714d[id].var_2939a01a[level.var_b175714d[id].var_2939a01a.size] = entity;
	entity thread function_525526be(id);
}

/*
	Name: function_1afce5aa
	Namespace: namespace_3fffba66
	Checksum: 0x93176BE8
	Offset: 0xEC8
	Size: 0x88
	Parameters: 1
	Flags: Linked
*/
function function_1afce5aa(entity)
{
	/#
		assert(isdefined(entity.var_d41ca76d));
	#/
	/#
		assert(isinarray(level.var_b175714d[entity.var_d41ca76d].var_2939a01a, entity));
	#/
	entity notify(#"hash_610e5a8c0ec1a4b6");
}

/*
	Name: function_331869
	Namespace: namespace_3fffba66
	Checksum: 0x23CB3E14
	Offset: 0xF58
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_331869(entity)
{
	return isdefined(entity.var_d41ca76d);
}

/*
	Name: function_e95ec8df
	Namespace: namespace_3fffba66
	Checksum: 0x6B9FE301
	Offset: 0xF78
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function function_e95ec8df(var_163b90b4 = 0)
{
	foreach(transformation in level.var_b175714d)
	{
		transformation.var_33e393a7 = 0;
		foreach(var_d41ca76d in transformation.var_2939a01a)
		{
			var_d41ca76d notify(#"hash_610e5a8c0ec1a4b6");
		}
	}
}

/*
	Name: function_fb608075
	Namespace: namespace_3fffba66
	Checksum: 0x6122E64B
	Offset: 0x1088
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_fb608075()
{
	if(!isdefined(level.var_ebccd551) || level.var_ebccd551.size == 0)
	{
		return;
	}
	var_4ff6ca41 = [];
	foreach(transformation in level.var_ebccd551)
	{
		if(isinarray(var_4ff6ca41, transformation.id))
		{
			continue;
		}
		var_167b5341 = level.var_b175714d[transformation.id];
		if(isdefined(transformation.var_ad4fb608) && transformation.var_ad4fb608)
		{
			level scene::function_f81475ae(var_167b5341.var_99fca475);
			transformation.var_ad4fb608 = 0;
		}
		level scene::stop(var_167b5341.var_44c5827d, 1);
		level scene::stop(var_167b5341.var_99fca475, 1);
		if(!isdefined(var_4ff6ca41))
		{
			var_4ff6ca41 = [];
		}
		else if(!isarray(var_4ff6ca41))
		{
			var_4ff6ca41 = array(var_4ff6ca41);
		}
		var_4ff6ca41[var_4ff6ca41.size] = transformation.id;
	}
}

/*
	Name: function_5db4f2f5
	Namespace: namespace_3fffba66
	Checksum: 0x3ED91B56
	Offset: 0x1268
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function function_5db4f2f5(entity, var_8763d10e)
{
	if(!isdefined(entity) || (isdefined(entity.var_69a981e6) && entity.var_69a981e6))
	{
		return 0;
	}
	entity.var_982f937 = 1;
	if(isdefined(var_8763d10e) && var_8763d10e && function_331869(entity))
	{
		function_1afce5aa(entity);
	}
	return 1;
}

/*
	Name: function_1a1cb53
	Namespace: namespace_3fffba66
	Checksum: 0x96200AF8
	Offset: 0x1308
	Size: 0x16
	Parameters: 1
	Flags: None
*/
function function_1a1cb53(entity)
{
	entity.var_982f937 = undefined;
}

/*
	Name: function_a261938f
	Namespace: namespace_3fffba66
	Checksum: 0x9EF3D6F6
	Offset: 0x1328
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_a261938f(entity)
{
	return entity.var_982f937 !== 1;
}

/*
	Name: function_525526be
	Namespace: namespace_3fffba66
	Checksum: 0xBD4AC679
	Offset: 0x1350
	Size: 0xB6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_525526be(id)
{
	waitresult = undefined;
	waitresult = self waittill(#"death", #"hash_673ed086cbd65a06", #"hash_610e5a8c0ec1a4b6");
	if(waitresult._notify != "death")
	{
		self.var_d41ca76d = undefined;
	}
	arrayremovevalue(level.var_b175714d[id].var_2939a01a, self);
	/#
		self notify(#"hash_6e3d9f8c484e3d01");
	#/
}

/*
	Name: function_4e679db4
	Namespace: namespace_3fffba66
	Checksum: 0x83CB06F0
	Offset: 0x1410
	Size: 0x6E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_4e679db4(id, def)
{
	if(isdefined(def.spawner))
	{
		def.spawner.var_ab46c56 = id;
	}
	else if(isdefined(def.aitype))
	{
		level.var_170852dc[def.aitype] = id;
	}
}

/*
	Name: function_c81eb299
	Namespace: namespace_3fffba66
	Checksum: 0x902F46A3
	Offset: 0x1488
	Size: 0xD4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c81eb299(id, def)
{
	if(isdefined(def.spawner))
	{
		/#
			assert(def.spawner.var_ab46c56 == id, "");
		#/
		def.spawner.var_ab46c56 = undefined;
	}
	else if(isdefined(def.aitype))
	{
		/#
			assert(level.var_170852dc[def.aitype] == id, "");
		#/
		level.var_170852dc[def.aitype] = undefined;
	}
}

/*
	Name: function_1050ba72
	Namespace: namespace_3fffba66
	Checksum: 0x51DD923D
	Offset: 0x1568
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1050ba72(def)
{
	if(isdefined(def.spawner))
	{
		return def.spawner spawnfromspawner(0, 1);
	}
	if(isdefined(def.aitype))
	{
		return spawnactor(def.aitype, (0, 0, 0), (0, 0, 0), undefined, 1);
	}
}

/*
	Name: transform
	Namespace: namespace_3fffba66
	Checksum: 0xF1C2E78B
	Offset: 0x15E8
	Size: 0xC16
	Parameters: 3
	Flags: Linked, Private
*/
private function transform(id, var_c2a69066, var_2cf708f4 = 1)
{
	level endon(#"end_game");
	if(function_abf1dcb4(id))
	{
		return;
	}
	var_167b5341 = level.var_b175714d[id];
	function_4e679db4(id, var_167b5341);
	var_e236d061 = {#hash_1a90140:self, #id:id};
	if(!isdefined(level.var_ebccd551))
	{
		level.var_ebccd551 = [];
	}
	else if(!isarray(level.var_ebccd551))
	{
		level.var_ebccd551 = array(level.var_ebccd551);
	}
	level.var_ebccd551[level.var_ebccd551.size] = var_e236d061;
	aitype = (isdefined(var_167b5341.spawner) ? var_167b5341.spawner.aitype : var_167b5341.aitype);
	if(isdefined(aitype))
	{
		var_e236d061.archetype = getarchetypefromclassname(aitype);
	}
	self.var_69a981e6 = 1;
	self.var_e236d061 = var_e236d061;
	var_e3920264 = self.var_e3920264;
	n_health_percent = min(self.health / self.maxhealth, 1);
	self notify(#"hash_673ed086cbd65a06");
	if(isdefined(var_167b5341.var_899e4029))
	{
		self [[var_167b5341.var_899e4029]]();
	}
	if(!isdefined(self) || !isalive(self))
	{
		arrayremovevalue(level.var_ebccd551, var_e236d061);
		function_c81eb299(id, var_167b5341);
		level notify(#"hash_76680411d8295ab9", {#id:id});
		return;
	}
	if(!isdefined(var_167b5341.var_44c5827d))
	{
		var_944250d2 = function_1050ba72(var_167b5341);
		if(!isdefined(var_944250d2) || !isalive(var_944250d2))
		{
			function_c81eb299(id, var_167b5341);
			arrayremovevalue(level.var_ebccd551, var_e236d061);
			level notify(#"hash_76680411d8295ab9", {#id:id});
			return;
		}
		var_e236d061.var_944250d2 = var_944250d2;
		var_944250d2.health = int(max(var_944250d2.health * n_health_percent, 1));
		var_944250d2.var_e236d061 = var_e236d061;
		var_944250d2._starting_round_number = self._starting_round_number;
		function_c81eb299(id, var_167b5341);
		if(isdefined(var_167b5341.var_497b36fd))
		{
			var_944250d2 [[var_167b5341.var_497b36fd]](n_health_percent);
		}
		var_944250d2 forceteleport(self.origin, self.angles);
		self zombie_utility::gib_random_parts();
		gibserverutils::annihilate(self);
		self val::set(#"hash_708b4bc6e9118df8", "hide", 2);
		if(var_2cf708f4)
		{
			self kill();
		}
		if(isdefined(var_c2a69066))
		{
			thread [[var_c2a69066]](var_944250d2);
		}
	}
	else
	{
		script_origin = {#angles:self.angles, #origin:self.origin};
		self val::set(#"hash_708b4bc6e9118df8", "ignoreall");
		a_ents = undefined;
		a_ents = array(self);
		self.animname = "spawner_zm_zombie";
		if(!isdefined(var_167b5341.var_accb1c92))
		{
			self clientfield::set("transformation_stream_split", 1);
		}
		var_e236d061.var_ad4fb608 = 1;
		level scene::function_27f5972e(var_167b5341.var_99fca475);
		script_origin scene::play(var_167b5341.var_44c5827d, a_ents);
		if(!isdefined(self) || !isalive(self))
		{
			if(isdefined(self))
			{
				self clientfield::set("transformation_stream_split", 0);
			}
			var_e236d061.var_ad4fb608 = 0;
			level scene::function_f81475ae(var_167b5341.var_99fca475);
			arrayremovevalue(level.var_ebccd551, var_e236d061);
			function_c81eb299(id, var_167b5341);
			level notify(#"hash_76680411d8295ab9", {#id:id});
			return;
		}
		if(isdefined(var_167b5341.var_accb1c92))
		{
			[[var_167b5341.var_accb1c92]](self, var_167b5341);
		}
		else
		{
			var_51d5c26f = self ai::function_9139c839();
			if(isdefined(var_51d5c26f) && isdefined(var_51d5c26f.var_d354164e))
			{
				foreach(var_127d3a7a in var_51d5c26f.var_d354164e)
				{
					if(self.model === var_127d3a7a.var_a3c9023c)
					{
						self.no_gib = 1;
						self setmodel(var_127d3a7a.var_cdf1f53d);
						break;
					}
				}
			}
		}
		self clientfield::set("transformation_stream_split", 0);
		var_e236d061.var_ad4fb608 = 0;
		level scene::function_f81475ae(var_167b5341.var_99fca475);
		self zombie_utility::zombie_eye_glow_stop();
		var_944250d2 = function_1050ba72(var_167b5341);
		if(!isalive(var_944250d2))
		{
			arrayremovevalue(level.var_ebccd551, var_e236d061);
			function_c81eb299(id, var_167b5341);
			level notify(#"hash_76680411d8295ab9", {#id:id});
			return;
		}
		var_e236d061.var_944250d2 = var_944250d2;
		var_944250d2 function_bbaec2fd();
		var_944250d2.var_e236d061 = var_e236d061;
		var_944250d2._starting_round_number = self._starting_round_number;
		function_c81eb299(id, var_167b5341);
		if(isdefined(var_167b5341.var_497b36fd))
		{
			var_944250d2 [[var_167b5341.var_497b36fd]](n_health_percent);
		}
		if(!isdefined(var_944250d2) || !isalive(var_944250d2))
		{
			arrayremovevalue(level.var_ebccd551, var_e236d061);
			level notify(#"hash_76680411d8295ab9", {#id:id});
			return;
		}
		a_ents = array(var_944250d2, self);
		self callback::function_d8abfc3d(#"on_ai_killed", &function_a51fe6f9, undefined, array(var_944250d2));
		script_origin scene::play(var_167b5341.var_99fca475, a_ents);
		if(isdefined(self))
		{
			self callback::function_52ac9652(#"on_ai_killed", &function_a51fe6f9);
		}
		if(!isdefined(var_944250d2) || !isalive(var_944250d2))
		{
			if(isdefined(self) && isalive(self) && self.allowdeath)
			{
				self kill();
			}
			arrayremovevalue(level.var_ebccd551, var_e236d061);
			level notify(#"hash_76680411d8295ab9", {#id:id});
			return;
		}
	}
	var_944250d2.var_e236d061 = undefined;
	arrayremovevalue(level.var_ebccd551, var_e236d061);
	level notify(#"transformation_complete", {#data:var_e3920264, #id:id, #hash_944250d2:array(var_944250d2)});
	if(isdefined(var_c2a69066))
	{
		thread [[var_c2a69066]](var_944250d2);
	}
}

/*
	Name: function_a51fe6f9
	Namespace: namespace_3fffba66
	Checksum: 0x7FFCAE8A
	Offset: 0x2208
	Size: 0xBC
	Parameters: 2
	Flags: Linked, Private
*/
private function function_a51fe6f9(params, var_944250d2)
{
	if(isdefined(var_944250d2) && isalive(var_944250d2) && var_944250d2.allowdeath && isdefined(params.eattacker) && isplayer(params.eattacker))
	{
		var_944250d2 kill(undefined, params.eattacker, params.einflictor, params.weapon, 0, 1);
	}
}

/*
	Name: function_c3a1379e
	Namespace: namespace_3fffba66
	Checksum: 0x51B38EB9
	Offset: 0x22D0
	Size: 0x96
	Parameters: 0
	Flags: Linked, Private
*/
private function function_c3a1379e()
{
	return !(isdefined(level.var_c9f5947d) && level.var_c9f5947d) && zombie_utility::get_current_zombie_count() + level.zombie_total <= 10 && (!(isdefined(level.var_78acec0a) && level.var_78acec0a)) && !level flag::get(#"infinite_round_spawning");
}

/*
	Name: function_fad54d94
	Namespace: namespace_3fffba66
	Checksum: 0x9C1202BD
	Offset: 0x2370
	Size: 0x2B0
	Parameters: 2
	Flags: Linked, Private
*/
private function function_fad54d94(id, var_167b5341)
{
	level endon(#"hash_670ec83e1acfadff", #"game_ended");
	if(var_167b5341.var_2939a01a.size > 0)
	{
		foreach(zombie in var_167b5341.var_2939a01a)
		{
			if(function_a261938f(zombie) && isdefined(var_167b5341.condition) && zombie [[var_167b5341.condition]]())
			{
				zombie thread transform(id);
				return 1;
			}
		}
	}
	if(var_167b5341.var_33e393a7 > 0)
	{
		zombies = zombie_utility::get_round_enemy_array();
		foreach(zombie in zombies)
		{
			if(!isdefined(zombie) || !isalive(zombie) || function_331869(zombie))
			{
				continue;
			}
			if(function_a261938f(zombie) && isdefined(var_167b5341.condition) && zombie [[var_167b5341.condition]]())
			{
				zombie thread transform(id);
				var_167b5341.var_33e393a7--;
				level.var_138b37c4++;
				if(level.var_138b37c4 >= 6)
				{
					waitframe(1);
					level.var_138b37c4 = 0;
				}
				return 1;
			}
			level.var_138b37c4++;
			if(level.var_138b37c4 >= 6)
			{
				waitframe(1);
				level.var_138b37c4 = 0;
			}
		}
	}
	return 0;
}

/*
	Name: update
	Namespace: namespace_3fffba66
	Checksum: 0x90E3D868
	Offset: 0x2628
	Size: 0x32E
	Parameters: 0
	Flags: Linked, Private
*/
private function update()
{
	level endon_callback(&function_4c0d0d28, #"end_game");
	var_52f926ed = 0;
	level.var_138b37c4 = 0;
	var_f38e5f93 = (isdefined(level.var_f38e5f93) ? level.var_f38e5f93 : 1);
	while(true)
	{
		if(isdefined(var_52f926ed) && var_52f926ed)
		{
			wait(var_f38e5f93);
		}
		else
		{
			wait(0.2);
		}
		level flag::wait_till_clear(#"hash_670ec83e1acfadff");
		if(function_c3a1379e())
		{
			level notify(#"hash_239ebc19aab5a60b");
			function_e95ec8df();
			level waittill(#"start_of_round", #"hash_3c3d24ff76335a0d");
		}
		var_52f926ed = 0;
		time = gettime();
		keys = array::randomize(getarraykeys(level.var_b175714d));
		foreach(id in keys)
		{
			transformation = level.var_b175714d[id];
			if(level flag::get(#"hash_670ec83e1acfadff") || function_c3a1379e())
			{
				break;
			}
			pixbeginevent("zm_transformation_update");
			if(transformation.var_ebaa8de9 > time)
			{
				pixendevent();
				continue;
			}
			if(function_abf1dcb4(id))
			{
				pixendevent();
				continue;
			}
			var_52f926ed = function_fad54d94(id, transformation);
			pixendevent();
			if(isdefined(var_52f926ed) && var_52f926ed)
			{
				transformation.var_ebaa8de9 = (level.var_78acec0a ? gettime() : gettime() + transformation.cooldown_time * 1000);
				break;
			}
		}
	}
}

/*
	Name: function_4c0d0d28
	Namespace: namespace_3fffba66
	Checksum: 0xD4B17DCC
	Offset: 0x2960
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4c0d0d28(var_201c5b1f)
{
	function_e95ec8df();
	function_fb608075();
}

/*
	Name: function_bbaec2fd
	Namespace: namespace_3fffba66
	Checksum: 0x732C7248
	Offset: 0x2998
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_bbaec2fd()
{
	self clientfield::set("transformation_spawn", 1);
}

/*
	Name: devgui
	Namespace: namespace_3fffba66
	Checksum: 0x91F3342D
	Offset: 0x29C8
	Size: 0x4DE
	Parameters: 0
	Flags: Private
*/
private function devgui()
{
	/#
		level waittill(#"start_zombie_round_logic");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		foreach(id, transformation in level.var_b175714d)
		{
			adddebugcommand("" + function_9e72a96(id) + "" + function_9e72a96(id) + "");
			adddebugcommand("" + function_9e72a96(id) + "" + function_9e72a96(id) + "");
			adddebugcommand("" + function_9e72a96(id) + "" + function_9e72a96(id) + "");
		}
		var_c7321e65 = 0;
		while(true)
		{
			wait(0.2);
			cmd = getdvarstring(#"hash_439ed91bbc9ac4c0", "");
			if(cmd == "")
			{
				continue;
			}
			setdvar(#"hash_439ed91bbc9ac4c0", "");
			cmd = strtok(cmd, "");
			switch(cmd[0])
			{
				case "hash_3f209ec6ef19eed0":
				{
					var_c7321e65 = !var_c7321e65;
					if(!var_c7321e65)
					{
						level notify(#"hash_53f34619e212c4cd");
					}
					else
					{
						level thread show_status();
					}
					break;
				}
				case "force":
				{
					var_167b5341 = level.var_b175714d[cmd[1]];
					if(!isdefined(var_167b5341))
					{
						break;
					}
					level thread function_3d080ace(cmd[1]);
					break;
				}
				case "spawn":
				{
					var_167b5341 = level.var_b175714d[cmd[1]];
					if(!isdefined(var_167b5341))
					{
						break;
					}
					level.var_78acec0a = 1;
					level notify(#"hash_3c3d24ff76335a0d");
					level thread function_2f40be20(cmd[1]);
					break;
				}
				case "queue":
				{
					level.var_78acec0a = 1;
					level notify(#"hash_3c3d24ff76335a0d");
					function_bdd8aba6(cmd[1]);
					break;
				}
				case "pause":
				{
					function_4da8230b(#"hash_7a79688cef85b533");
					break;
				}
				case "resume":
				{
					function_6b183c78(#"hash_7a79688cef85b533");
					break;
				}
				case "hash_5893e94d64f92905":
				{
					function_6bcb49b5();
					break;
				}
			}
		}
	#/
}

/*
	Name: function_ece5c99c
	Namespace: namespace_3fffba66
	Checksum: 0xFDEBDDC6
	Offset: 0x2EB0
	Size: 0x22
	Parameters: 0
	Flags: None
*/
function function_ece5c99c()
{
	/#
		self.zombie_think_done = 1;
		self.completed_emerging_into_playable_area = 1;
	#/
}

/*
	Name: function_3f433f41
	Namespace: namespace_3fffba66
	Checksum: 0x21945C2D
	Offset: 0x2EE0
	Size: 0x200
	Parameters: 0
	Flags: None
*/
function function_3f433f41()
{
	/#
		if(!isdefined(level.zombie_spawners))
		{
			return;
		}
		player = level.players[0];
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		scale = 8000;
		direction_vec = (direction_vec[0] * scale, direction_vec[1] * scale, direction_vec[2] * scale);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		if(trace[#"fraction"] >= 1)
		{
			return;
		}
		random_spawner = array::random(level.zombie_spawners);
		zombie = random_spawner spawnfromspawner(random_spawner.targetname, 1, 0, 1);
		zombie.custom_location = &function_ece5c99c;
		zombie.b_ignore_cleanup = 1;
		if(!isdefined(zombie))
		{
			return;
		}
		zombie forceteleport(trace[#"position"], player.angles + vectorscale((0, 1, 0), 180));
		return zombie;
	#/
}

/*
	Name: function_3d080ace
	Namespace: namespace_3fffba66
	Checksum: 0x698E747B
	Offset: 0x30F0
	Size: 0x94
	Parameters: 1
	Flags: Private
*/
private function function_3d080ace(var_70d26bfb)
{
	/#
		zombie = function_3f433f41();
		if(!isdefined(zombie))
		{
			return;
		}
		zombie endon(#"death");
		wait(0.5);
		while(function_abf1dcb4(var_70d26bfb))
		{
			waitframe(1);
		}
		function_9acf76e6(zombie, var_70d26bfb);
	#/
}

/*
	Name: function_2f40be20
	Namespace: namespace_3fffba66
	Checksum: 0xA767BBE0
	Offset: 0x3190
	Size: 0x74
	Parameters: 1
	Flags: Private
*/
private function function_2f40be20(var_70d26bfb)
{
	/#
		zombie = function_3f433f41();
		if(!isdefined(zombie))
		{
			return;
		}
		zombie endon(#"death");
		zombie.var_641025d6 = gettime() + 500;
		function_d2374144(zombie, var_70d26bfb);
	#/
}

/*
	Name: function_4bad29d9
	Namespace: namespace_3fffba66
	Checksum: 0xC73B00B1
	Offset: 0x3210
	Size: 0x108
	Parameters: 1
	Flags: Private
*/
private function function_4bad29d9(notifyhash)
{
	/#
		foreach(var_deb567a8 in level.var_deb567a8)
		{
			if(!isdefined(var_deb567a8.id))
			{
				var_deb567a8.var_735311f0 destroy();
			}
			var_deb567a8.title destroy();
			var_deb567a8.var_d189697d destroy();
			var_deb567a8.var_b99573ec destroy();
		}
		level.var_deb567a8 = undefined;
		level notify(#"hash_6e3d9f8c484e3d01");
	#/
}

/*
	Name: create_hudelem
	Namespace: namespace_3fffba66
	Checksum: 0x18ABCC5D
	Offset: 0x3320
	Size: 0xBA
	Parameters: 2
	Flags: Private
*/
private function create_hudelem(y, x)
{
	/#
		if(!isdefined(x))
		{
			x = 0;
		}
		var_aa917a22 = newdebughudelem();
		var_aa917a22.alignx = "";
		var_aa917a22.horzalign = "";
		var_aa917a22.aligny = "";
		var_aa917a22.vertalign = "";
		var_aa917a22.y = y;
		var_aa917a22.x = x;
		return var_aa917a22;
	#/
}

/*
	Name: function_262ba53f
	Namespace: namespace_3fffba66
	Checksum: 0x8C83FAA3
	Offset: 0x33E8
	Size: 0x4B0
	Parameters: 0
	Flags: Private
*/
private function function_262ba53f()
{
	/#
		level.var_deb567a8 = array();
		y = 10;
		colors = array((1, 1, 1));
		var_e859a426 = create_hudelem(y);
		var_e859a426 settext("");
		y = y + 10;
		var_735311f0 = create_hudelem(y);
		var_af5fbf35 = create_hudelem(y, 160);
		var_af5fbf35 settext("");
		var_f4676cb4 = create_hudelem(y, 220);
		var_f4676cb4 settext("");
		if(!isdefined(level.var_deb567a8))
		{
			level.var_deb567a8 = [];
		}
		else if(!isarray(level.var_deb567a8))
		{
			level.var_deb567a8 = array(level.var_deb567a8);
		}
		level.var_deb567a8[level.var_deb567a8.size] = {#hash_735311f0:var_735311f0, #hash_b99573ec:var_f4676cb4, #hash_d189697d:var_af5fbf35, #title:var_e859a426};
		i = 0;
		foreach(id, transformation in level.var_b175714d)
		{
			y = y + 10;
			var_f225e659 = colors[i % colors.size];
			var_a9a6a9ac = create_hudelem(y);
			var_a9a6a9ac settext(function_9e72a96(id));
			var_a9a6a9ac.color = var_f225e659;
			var_a9a6a9ac.fontscale = 1.2;
			var_83db7237 = create_hudelem(y, 160);
			var_83db7237 settext(0);
			var_83db7237.color = var_f225e659;
			var_83db7237.fontscale = 1.2;
			var_82f71158 = create_hudelem(y, 220);
			var_82f71158 settext(0);
			var_82f71158.color = var_f225e659;
			var_82f71158.fontscale = 1.2;
			if(!isdefined(level.var_deb567a8))
			{
				level.var_deb567a8 = [];
			}
			else if(!isarray(level.var_deb567a8))
			{
				level.var_deb567a8 = array(level.var_deb567a8);
			}
			level.var_deb567a8[level.var_deb567a8.size] = {#color:var_f225e659, #id:id, #hash_b99573ec:var_82f71158, #hash_d189697d:var_83db7237, #title:var_a9a6a9ac};
			i++;
		}
	#/
}

/*
	Name: function_9aa982db
	Namespace: namespace_3fffba66
	Checksum: 0xBBD5B9D5
	Offset: 0x38A0
	Size: 0x1A
	Parameters: 1
	Flags: Private
*/
private function function_9aa982db(notifyhash)
{
	/#
		self.var_30acf8aa = undefined;
	#/
}

/*
	Name: function_4a065e66
	Namespace: namespace_3fffba66
	Checksum: 0x79479171
	Offset: 0x38C8
	Size: 0xCE
	Parameters: 2
	Flags: Private
*/
private function function_4a065e66(id, color)
{
	/#
		self endon_callback(&function_9aa982db, #"death", #"hash_6e3d9f8c484e3d01");
		level endon_callback(&function_9aa982db, #"hash_6e3d9f8c484e3d01");
		self.var_30acf8aa = 1;
		while(true)
		{
			record3dtext(function_9e72a96(id), self.origin + (0, 0, self.maxs[2]), color);
			waitframe(1);
		}
	#/
}

/*
	Name: show_status
	Namespace: namespace_3fffba66
	Checksum: 0xB9CF2A22
	Offset: 0x39A0
	Size: 0x248
	Parameters: 0
	Flags: Private
*/
private function show_status()
{
	/#
		level notify(#"hash_53f34619e212c4cd");
		level endon_callback(&function_4bad29d9, #"hash_53f34619e212c4cd");
		function_262ba53f();
		while(true)
		{
			waitframe(1);
			foreach(var_deb567a8 in level.var_deb567a8)
			{
				if(!isdefined(var_deb567a8.id))
				{
					var_deb567a8.var_735311f0 settext((function_770908a2() ? "" : ""));
					continue;
				}
				var_deb567a8.var_d189697d settext(level.var_b175714d[var_deb567a8.id].var_33e393a7);
				var_deb567a8.var_b99573ec settext(level.var_b175714d[var_deb567a8.id].var_2939a01a.size);
				foreach(ai in level.var_b175714d[var_deb567a8.id].var_2939a01a)
				{
					if(!(isdefined(ai.var_30acf8aa) && ai.var_30acf8aa))
					{
						ai thread function_4a065e66(var_deb567a8.id, var_deb567a8.color);
					}
				}
			}
		}
	#/
}

/*
	Name: function_6bcb49b5
	Namespace: namespace_3fffba66
	Checksum: 0x914DE01
	Offset: 0x3BF0
	Size: 0x54
	Parameters: 0
	Flags: Private
*/
private function function_6bcb49b5()
{
	/#
		level.var_dfd1a1c0 = !(isdefined(level.var_dfd1a1c0) && level.var_dfd1a1c0);
		if(level.var_dfd1a1c0)
		{
			level thread function_dfd1a1c0();
		}
	#/
}

/*
	Name: function_dfd1a1c0
	Namespace: namespace_3fffba66
	Checksum: 0xDB0883D5
	Offset: 0x3C50
	Size: 0x158
	Parameters: 0
	Flags: Private
*/
private function function_dfd1a1c0()
{
	/#
		self notify("");
		self endon("");
		while(level.var_dfd1a1c0)
		{
			var_c2624dfc = 200;
			var_b010a959 = 100;
			debug2dtext((var_c2624dfc, var_b010a959, 0), "", (1, 1, 0), 1, (0, 0, 0), 0.8, 1);
			var_b010a959 = var_b010a959 + 25;
			foreach(var_e2af3c2d in level.var_50f7dbd5)
			{
				debug2dtext((var_c2624dfc, var_b010a959, 0), function_9e72a96(var_e2af3c2d), (1, 1, 1), 1, (0, 0, 0), 0.8, 1);
				var_b010a959 = var_b010a959 + 25;
			}
			waitframe(1);
		}
	#/
}

