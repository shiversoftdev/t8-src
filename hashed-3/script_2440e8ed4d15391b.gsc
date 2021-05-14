// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_256b8879317373de;
#using script_3819e7a1427df6d2;
#using script_57f7003580bb15e0;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\damage.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace arc;

/*
	Name: function_4e219272
	Namespace: arc
	Checksum: 0xC7FD1335
	Offset: 0x98
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_4e219272(weapon, var_26b2b1bb)
{
	/#
		level thread update_dvars();
	#/
	if(!setup_arc(weapon, var_26b2b1bb))
	{
		return;
	}
	var_26b2b1bb = level.var_8a74f7fc[weapon];
	if(!isdefined(var_26b2b1bb.var_874bd25a))
	{
		var_26b2b1bb.var_874bd25a = &function_874bd25a;
	}
	function_8d134256(var_26b2b1bb);
}

/*
	Name: update_dvars
	Namespace: arc
	Checksum: 0xCFB4EDA1
	Offset: 0x140
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function update_dvars()
{
	/#
		while(true)
		{
			wait(1);
			level.var_6d3af47 = getdvarint(#"hash_6e465f7410cc100f", 0);
		}
	#/
}

/*
	Name: setup_arc
	Namespace: arc
	Checksum: 0x9A5BB72E
	Offset: 0x198
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function setup_arc(weapon, var_26b2b1bb)
{
	/#
		assert(isdefined(weapon));
	#/
	if(!isdefined(level.var_8a74f7fc))
	{
		level.var_8a74f7fc = [];
	}
	if(!isdefined(var_26b2b1bb))
	{
		var_26b2b1bb = spawnstruct();
	}
	if(isdefined(level.var_8a74f7fc[weapon]))
	{
		return 0;
	}
	level.var_8a74f7fc[weapon] = var_26b2b1bb;
	var_26b2b1bb.weapon = weapon;
	return 1;
}

/*
	Name: function_8d134256
	Namespace: arc
	Checksum: 0xE6190043
	Offset: 0x250
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function function_8d134256(var_26b2b1bb)
{
	var_26b2b1bb.var_34afccf5 = var_26b2b1bb.range * var_26b2b1bb.range;
	var_26b2b1bb.var_1c1be14 = var_26b2b1bb.max_range * var_26b2b1bb.max_range;
	callback::add_weapon_damage(var_26b2b1bb.weapon, var_26b2b1bb.var_874bd25a);
}

/*
	Name: function_874bd25a
	Namespace: arc
	Checksum: 0xFC41FFF4
	Offset: 0x2D8
	Size: 0x8C
	Parameters: 5
	Flags: None
*/
function function_874bd25a(eattacker, einflictor, weapon, meansofdeath, damage)
{
	var_26b2b1bb = level.var_8a74f7fc[weapon];
	/#
		assert(isdefined(var_26b2b1bb));
	#/
	self thread function_9b14bec4(eattacker, einflictor, weapon, meansofdeath, damage, var_26b2b1bb);
}

/*
	Name: function_9b14bec4
	Namespace: arc
	Checksum: 0x127C7D09
	Offset: 0x370
	Size: 0x114
	Parameters: 6
	Flags: None
*/
function function_9b14bec4(eattacker, einflictor, weapon, meansofdeath, damage, var_26b2b1bb)
{
	arc_source = self;
	arc_source_origin = self.origin;
	arc_source_pos = self gettagorigin(var_26b2b1bb.fx_tag);
	if(isdefined(self.var_f5037060))
	{
		self [[self.var_f5037060]](var_26b2b1bb, arc_source, 0);
	}
	if(isdefined(self.body))
	{
		arc_source_origin = self.body.origin;
		arc_source_pos = self.body gettagorigin(var_26b2b1bb.fx_tag);
	}
	self function_5272e51b(var_26b2b1bb, eattacker, arc_source, arc_source_origin, 0);
}

/*
	Name: function_bf7d5b02
	Namespace: arc
	Checksum: 0xA11234AE
	Offset: 0x490
	Size: 0x4C
	Parameters: 2
	Flags: None
*/
function function_bf7d5b02(arc_source_origin, max_range)
{
	/#
		circle(arc_source_origin, max_range, (1, 0.5, 0), 0, 1, 2);
	#/
}

/*
	Name: function_7a0599d
	Namespace: arc
	Checksum: 0xEB651A1D
	Offset: 0x4E8
	Size: 0x7C
	Parameters: 4
	Flags: None
*/
function function_7a0599d(var_955a2e18, range, depth, var_94a1d56d)
{
	/#
		var_227ac3be = depth / var_94a1d56d - 1;
		circle(var_955a2e18, range, (0, 1 - var_227ac3be, var_227ac3be), 0, 1, 500);
	#/
}

/*
	Name: distancecheck
	Namespace: arc
	Checksum: 0xC8E1660F
	Offset: 0x570
	Size: 0xA2
	Parameters: 4
	Flags: None
*/
function distancecheck(var_26b2b1bb, target, arc_source_pos, arc_source_origin)
{
	distancesq = distancesquared(target.origin, arc_source_pos);
	if(distancesq > var_26b2b1bb.var_34afccf5)
	{
		return 0;
	}
	distancesq = distancesquared(target.origin, arc_source_origin);
	if(distancesq > var_26b2b1bb.var_1c1be14)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_33d5b9a6
	Namespace: arc
	Checksum: 0x66C5146A
	Offset: 0x620
	Size: 0x2B2
	Parameters: 7
	Flags: None
*/
function function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, target, var_4d3cc1a7 = 1)
{
	if(target player::is_spawn_protected())
	{
		return 0;
	}
	if(!isalive(target))
	{
		return 0;
	}
	if(isdefined(arc_source) && isdefined(arc_source.var_69ea963))
	{
		if(![[arc_source.var_69ea963]](target))
		{
			return 0;
		}
	}
	if(isdefined(arc_source) && target == arc_source)
	{
		return 0;
	}
	if(eattacker == target)
	{
		return 0;
	}
	if(isdefined(target.arc_source) && target.arc_source == arc_source)
	{
		return 0;
	}
	if(isdefined(arc_source.var_d8d780c1) && arc_source.var_d8d780c1.size >= level.var_8a74f7fc[arc_source.var_c43010fc].var_755593b1)
	{
		return 0;
	}
	if(target function_db12bbd1(arc_source))
	{
		return 0;
	}
	if(var_4d3cc1a7 && !distancecheck(var_26b2b1bb, target, self.origin, arc_source_origin))
	{
		/#
			record3dtext("", self.origin - vectorscale((0, 0, 1), 20), (1, 0, 0), "", undefined, 0.4);
		#/
		return 0;
	}
	if(!damage::friendlyfirecheck(eattacker, target))
	{
		return 0;
	}
	if(!target damageconetrace(self.origin + vectorscale((0, 0, 1), 10), self) && (isdefined(var_26b2b1bb.var_8ce60046) && var_26b2b1bb.var_8ce60046))
	{
		return 0;
	}
	if(isdefined(self.var_101a013c) && self.var_101a013c && (isdefined(target.var_4233f7e5) && target.var_4233f7e5))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_5272e51b
	Namespace: arc
	Checksum: 0x70132C1
	Offset: 0x8E0
	Size: 0x206
	Parameters: 6
	Flags: None
*/
function function_5272e51b(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, var_4d3cc1a7 = 1)
{
	/#
		if(level.var_6d3af47)
		{
			function_bf7d5b02(arc_source_origin, var_26b2b1bb.max_range);
			function_7a0599d(self.origin, var_26b2b1bb.range, depth, var_26b2b1bb.depth);
		}
	#/
	delay = var_26b2b1bb.delay;
	if(!isdefined(delay))
	{
		delay = 0;
	}
	allplayers = util::get_active_players();
	var_67dd5161 = arraysort(allplayers, arc_source_origin, 1);
	validtargets = 0;
	for(i = 0; validtargets < var_26b2b1bb.var_755593b1 && i < var_67dd5161.size; i++)
	{
		target = var_67dd5161[i];
		if(!function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, target, var_4d3cc1a7))
		{
			continue;
		}
		validtargets++;
		level thread function_30a9a6c1(var_26b2b1bb, delay, eattacker, arc_source, self, arc_source_origin, self.origin, target, target gettagorigin(var_26b2b1bb.fx_tag), depth);
	}
}

/*
	Name: function_30a9a6c1
	Namespace: arc
	Checksum: 0x7BCB0A19
	Offset: 0xAF0
	Size: 0x1F6
	Parameters: 11
	Flags: None
*/
function function_30a9a6c1(var_26b2b1bb, delay, eattacker, arc_source, var_9a099e60, arc_source_origin, arc_source_pos, arc_target, arc_target_pos, depth, var_4d3cc1a7 = 1)
{
	if(delay)
	{
		wait(float(delay) / 1000);
		if(!function_33d5b9a6(var_26b2b1bb, eattacker, arc_source, arc_source_origin, depth, arc_target, var_4d3cc1a7))
		{
			return;
		}
	}
	function_41827934(arc_source, arc_target);
	if(depth < (isdefined(var_26b2b1bb.depth) ? var_26b2b1bb.depth : 0) && isdefined(arc_source))
	{
		arc_target function_5272e51b(level.var_8a74f7fc[arc_source.var_c43010fc], arc_source.owner, arc_source, arc_source_origin, depth + 1, var_4d3cc1a7);
	}
	if(isdefined(arc_source) && isdefined(arc_source.var_16d479de))
	{
		arc_source [[arc_source.var_16d479de]](arc_target);
	}
	if(isdefined(arc_source))
	{
		var_ac6e1436 = 0;
		if(isdefined(arc_source.var_f5037060))
		{
			var_ac6e1436 = arc_target [[arc_source.var_f5037060]](var_26b2b1bb, arc_source, depth);
		}
		arc_source.var_290ed3ab = gettime() + var_ac6e1436;
	}
}

/*
	Name: function_db12bbd1
	Namespace: arc
	Checksum: 0x2480E92B
	Offset: 0xCF0
	Size: 0xA4
	Parameters: 1
	Flags: None
*/
function function_db12bbd1(arc_source)
{
	if(isdefined(self.var_671951da) && isdefined(arc_source))
	{
		foreach(source in self.var_671951da)
		{
			if(isdefined(source) && source == arc_source)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_41827934
	Namespace: arc
	Checksum: 0x46C509D9
	Offset: 0xDA0
	Size: 0xAA
	Parameters: 2
	Flags: None
*/
function function_41827934(arc_source, arc_target)
{
	arc_target.arc_source = arc_source;
	if(!isdefined(arc_target.var_671951da))
	{
		arc_target.var_671951da = [];
	}
	arc_target.var_671951da[arc_target.var_671951da.size] = arc_source;
	if(isdefined(arc_source))
	{
		if(!isdefined(arc_source.var_d8d780c1))
		{
			arc_source.var_d8d780c1 = [];
		}
		arc_source.var_d8d780c1[arc_source.var_d8d780c1.size] = arc_target;
	}
}

/*
	Name: function_936e96aa
	Namespace: arc
	Checksum: 0x8B05538B
	Offset: 0xE58
	Size: 0xE8
	Parameters: 1
	Flags: None
*/
function function_936e96aa(var_26b2b1bb)
{
	if(isdefined(self.var_d8d780c1))
	{
		foreach(target in self.var_d8d780c1)
		{
			if(isdefined(target) && isalive(target) && isdefined(target.arc_source) && target.arc_source == self)
			{
				if(isdefined(self.var_8a41c722))
				{
					self [[self.var_8a41c722]](target, var_26b2b1bb);
				}
			}
		}
	}
}

