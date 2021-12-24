// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;

#namespace zm_aoe;

/*
	Name: function_89f2df9
	Namespace: zm_aoe
	Checksum: 0xB0187EA4
	Offset: 0x178
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_aoe", &__init__, &__main__, undefined);
}

#namespace namespace_8d574d24;

/*
	Name: __constructor
	Namespace: namespace_8d574d24
	Checksum: 0xB9AE6375
	Offset: 0x1C8
	Size: 0x2A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.spawntime = gettime();
	self.state = 0;
	self.var_be1913ae = gettime() + 100;
}

/*
	Name: __destructor
	Namespace: namespace_8d574d24
	Checksum: 0x80F724D1
	Offset: 0x200
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

#namespace zm_aoe;

/*
	Name: function_8d574d24
	Namespace: zm_aoe
	Checksum: 0x37EA2DDB
	Offset: 0x210
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_8d574d24()
{
	classes.var_8d574d24[0] = spawnstruct();
	classes.var_8d574d24[0].__vtable[913321084] = &namespace_8d574d24::__destructor;
	classes.var_8d574d24[0].__vtable[674154906] = &namespace_8d574d24::__constructor;
}

#namespace namespace_698343df;

/*
	Name: __constructor
	Namespace: namespace_698343df
	Checksum: 0xC9DDEA3
	Offset: 0x2A0
	Size: 0xE
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_9a08bb02 = [];
}

/*
	Name: __destructor
	Namespace: namespace_698343df
	Checksum: 0x80F724D1
	Offset: 0x2B8
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

#namespace zm_aoe;

/*
	Name: function_698343df
	Namespace: zm_aoe
	Checksum: 0x18106E7C
	Offset: 0x2C8
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_698343df()
{
	classes.var_698343df[0] = spawnstruct();
	classes.var_698343df[0].__vtable[913321084] = &namespace_698343df::__destructor;
	classes.var_698343df[0].__vtable[674154906] = &namespace_698343df::__constructor;
}

/*
	Name: __init__
	Namespace: zm_aoe
	Checksum: 0x73727CB6
	Offset: 0x358
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "aoe_state", 1, getminbitcountfornum(4), "int");
	clientfield::register("scriptmover", "aoe_id", 1, getminbitcountfornum(8), "int");
}

/*
	Name: __main__
	Namespace: zm_aoe
	Checksum: 0xBF51508
	Offset: 0x3E8
	Size: 0x18C
	Parameters: 0
	Flags: Linked, Private
*/
private function __main__()
{
	function_15dea507(1, "zm_aoe_spear", 15, 60000, 2000, 5, 15, 40, 80);
	function_15dea507(2, "zm_aoe_spear_small", 15, 60000, 2000, 5, 15, 20, 80);
	function_15dea507(3, "zm_aoe_spear_big", 15, 60000, 2000, 5, 15, 60, 80);
	function_15dea507(4, "zm_aoe_strafe_storm", 15, 45000, 2000, 3, 5, 80, 80);
	function_15dea507(5, "zm_aoe_chaos_bolt", 10, 30000, 2000, 3, 5, 40, 80);
	function_15dea507(6, "zm_aoe_chaos_bolt_2", 10, 60000, 2000, 3, 5, 60, 80);
	function_15dea507(7, "zm_aoe_chaos_bolt_annihilate", 10, 5000, 2000, 3, 5, 20, 80);
}

/*
	Name: function_e969e75
	Namespace: zm_aoe
	Checksum: 0x480FE14E
	Offset: 0x580
	Size: 0x98
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e969e75(type)
{
	/#
		assert(isdefined(level.var_400ae143));
	#/
	arraykeys = getarraykeys(level.var_400ae143);
	if(isinarray(arraykeys, hash(type)))
	{
		return level.var_400ae143[hash(type)];
	}
	return undefined;
}

/*
	Name: function_15dea507
	Namespace: zm_aoe
	Checksum: 0x903EC8FD
	Offset: 0x620
	Size: 0x1EC
	Parameters: 9
	Flags: Linked
*/
function function_15dea507(var_2fb5df20, type, var_3a11a165, lifetime, var_f2cd3aad, damagemin, damagemax, radius, height)
{
	if(!isdefined(level.var_400ae143))
	{
		level.var_400ae143 = [];
	}
	arraykeys = getarraykeys(level.var_400ae143);
	/#
		assert(!isinarray(arraykeys, hash(type)));
	#/
	object = new var_698343df();
	[[ object ]]->__constructor();
	var_508aaded = object;
	level.var_400ae143[type] = var_508aaded;
	/#
		assert(damagemin <= damagemax, "");
	#/
	var_508aaded.type = type;
	var_508aaded.var_3a11a165 = var_3a11a165;
	var_508aaded.lifetime = lifetime;
	var_508aaded.damagemin = damagemin;
	var_508aaded.damagemax = damagemax;
	var_508aaded.var_f2cd3aad = var_f2cd3aad;
	var_508aaded.radius = radius;
	var_508aaded.height = height;
	var_508aaded.var_2fb5df20 = var_2fb5df20;
	level thread function_60bb02f3(type);
	/#
		level thread function_e39c0be4(var_508aaded);
	#/
}

/*
	Name: function_371b4147
	Namespace: zm_aoe
	Checksum: 0x9021B121
	Offset: 0x818
	Size: 0x192
	Parameters: 4
	Flags: Linked
*/
function function_371b4147(var_2fb5df20, type, position, userdata)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb), "");
	#/
	if(var_46f1b5eb.var_9a08bb02.size >= var_46f1b5eb.var_3a11a165)
	{
		function_2c33d107(type);
	}
	/#
		assert(var_46f1b5eb.var_9a08bb02.size < var_46f1b5eb.var_3a11a165);
	#/
	object = new var_8d574d24();
	[[ object ]]->__constructor();
	aoe = object;
	aoe.position = position;
	aoe.endtime = gettime() + var_46f1b5eb.lifetime;
	aoe.entity = spawn("script_model", position);
	aoe.type = type;
	aoe.entity clientfield::set("aoe_id", var_2fb5df20);
	function_668a9b2d(aoe, type);
	if(isdefined(userdata))
	{
		aoe.userdata = userdata;
	}
}

/*
	Name: function_668a9b2d
	Namespace: zm_aoe
	Checksum: 0xCD6BEE08
	Offset: 0x9B8
	Size: 0xA4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_668a9b2d(aoe, type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb), "");
	#/
	array::add(var_46f1b5eb.var_9a08bb02, aoe);
	/#
		assert(var_46f1b5eb.var_9a08bb02.size <= var_46f1b5eb.var_3a11a165);
	#/
}

/*
	Name: function_87bbe4fc
	Namespace: zm_aoe
	Checksum: 0x14BEE4D
	Offset: 0xA68
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
private function function_87bbe4fc(type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb), "");
	#/
	if(var_46f1b5eb.var_9a08bb02.size)
	{
		oldest = var_46f1b5eb.var_9a08bb02[0];
		foreach(aoe in var_46f1b5eb.var_9a08bb02)
		{
			if(aoe.spawntime < oldest.spawntime)
			{
				oldest = aoe;
			}
		}
		return oldest;
	}
}

/*
	Name: function_fa03204a
	Namespace: zm_aoe
	Checksum: 0xF72F73CC
	Offset: 0xB78
	Size: 0x104
	Parameters: 2
	Flags: Linked, Private
*/
private function function_fa03204a(aoe, type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isinarray(var_46f1b5eb.var_9a08bb02, aoe));
	#/
	if(isdefined(aoe.userdata) && isdefined(level.var_6efc944c))
	{
		[[level.var_6efc944c]](aoe);
	}
	arrayremovevalue(var_46f1b5eb.var_9a08bb02, aoe);
	/#
		assert(var_46f1b5eb.var_9a08bb02.size < var_46f1b5eb.var_3a11a165);
	#/
	thread function_4f0db8cf(aoe.entity);
}

/*
	Name: function_4f0db8cf
	Namespace: zm_aoe
	Checksum: 0xC6CD8CA6
	Offset: 0xC88
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4f0db8cf(entity)
{
	waitframe(2);
	entity delete();
}

/*
	Name: function_2c33d107
	Namespace: zm_aoe
	Checksum: 0xF7B8040A
	Offset: 0xCB8
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2c33d107(type)
{
	var_46f1b5eb = function_e969e75(type);
	var_528d5f55 = function_87bbe4fc(type);
	function_ccf8f659(var_528d5f55, 1);
	thread function_fa03204a(var_528d5f55, type);
}

/*
	Name: function_ccf8f659
	Namespace: zm_aoe
	Checksum: 0xFE9A93AE
	Offset: 0xD48
	Size: 0x23A
	Parameters: 2
	Flags: Linked, Private
*/
private function function_ccf8f659(aoe, forceend = 0)
{
	var_46f1b5eb = function_e969e75(aoe.type);
	/#
		assert(isdefined(var_46f1b5eb));
	#/
	if(forceend)
	{
		aoe.entity clientfield::set("aoe_state", 4);
		aoe.state = 4;
		return;
	}
	if(gettime() < aoe.var_be1913ae)
	{
		return;
	}
	if(aoe.state == 0)
	{
		aoe.entity clientfield::set("aoe_state", 1);
		aoe.state = 1;
		aoe.var_be1913ae = gettime() + 100;
	}
	else if(aoe.state == 1)
	{
		aoe.entity clientfield::set("aoe_state", 2);
		aoe.state = 2;
		aoe.var_be1913ae = aoe.endtime;
	}
	else if(aoe.state == 2)
	{
		aoe.entity clientfield::set("aoe_state", 3);
		aoe.state = 3;
		aoe.var_be1913ae = gettime() + var_46f1b5eb.var_f2cd3aad;
	}
	else if(aoe.state == 3)
	{
		aoe.entity clientfield::set("aoe_state", 4);
		aoe.state = 4;
	}
}

/*
	Name: function_3690781e
	Namespace: zm_aoe
	Checksum: 0xF3631297
	Offset: 0xF90
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_3690781e()
{
	foreach(var_eb93f0b0 in level.var_400ae143)
	{
		if(isarray(var_eb93f0b0.var_9a08bb02))
		{
			var_4df07587 = arraycopy(var_eb93f0b0.var_9a08bb02);
			foreach(var_3e8795ff in var_4df07587)
			{
				function_ccf8f659(var_3e8795ff, 1);
				level thread function_fa03204a(var_3e8795ff, var_3e8795ff.type);
			}
		}
	}
}

/*
	Name: function_e5950b1e
	Namespace: zm_aoe
	Checksum: 0x5D678723
	Offset: 0x10E0
	Size: 0x180
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e5950b1e(type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb));
	#/
	var_2aad0cec = [];
	foreach(aoe in var_46f1b5eb.var_9a08bb02)
	{
		function_ccf8f659(aoe);
		if(aoe.state == 4)
		{
			array::add(var_2aad0cec, aoe, 0);
		}
	}
	foreach(aoe in var_2aad0cec)
	{
		function_fa03204a(aoe, aoe.type);
	}
}

/*
	Name: function_bea2e288
	Namespace: zm_aoe
	Checksum: 0xA5902905
	Offset: 0x1268
	Size: 0x300
	Parameters: 1
	Flags: Linked, Private
*/
private function function_bea2e288(type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb));
	#/
	players = getplayers();
	foreach(aoe in var_46f1b5eb.var_9a08bb02)
	{
		foreach(player in players)
		{
			/#
				assert(isdefined(aoe.entity));
			#/
			dist = distance(aoe.entity.origin, player.origin);
			withinrange = dist <= var_46f1b5eb.radius;
			var_c0af03ae = 0;
			if(!withinrange)
			{
				continue;
			}
			heightdiff = abs(aoe.entity.origin[2] - player.origin[2]);
			if(heightdiff <= var_46f1b5eb.height)
			{
				var_c0af03ae = 1;
			}
			if(withinrange && var_c0af03ae)
			{
				damage = mapfloat(0, var_46f1b5eb.radius, var_46f1b5eb.damagemin, var_46f1b5eb.damagemax, dist);
				player dodamage(damage, aoe.entity.origin);
				player notify(#"hash_30e5a6bd41a5917c", {#origin:aoe.entity.origin, #hash_159100b7:aoe.type});
			}
		}
	}
}

/*
	Name: function_60bb02f3
	Namespace: zm_aoe
	Checksum: 0x829AC84
	Offset: 0x1570
	Size: 0xA6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_60bb02f3(type)
{
	var_46f1b5eb = function_e969e75(type);
	/#
		assert(isdefined(var_46f1b5eb));
	#/
	while(true)
	{
		if(!var_46f1b5eb.var_9a08bb02.size)
		{
			waitframe(1);
			continue;
		}
		function_e5950b1e(type);
		function_bea2e288(type);
		waitframe(1);
	}
}

/*
	Name: function_e39c0be4
	Namespace: zm_aoe
	Checksum: 0x6DEA2CC0
	Offset: 0x1620
	Size: 0x2D0
	Parameters: 1
	Flags: Private
*/
private function function_e39c0be4(var_46f1b5eb)
{
	/#
		var_46f1b5eb endon(#"hash_343e166e4aa4288e");
		while(true)
		{
			if(getdvarint(#"hash_423e0fe03fe8ae0c", 0))
			{
				if(var_46f1b5eb.var_9a08bb02.size)
				{
					var_87bbe4fc = function_87bbe4fc(var_46f1b5eb.type);
					i = 0;
					foreach(aoe in var_46f1b5eb.var_9a08bb02)
					{
						circle(aoe.position, var_46f1b5eb.radius, (1, 0.5, 0), 1, 1);
						circle(aoe.position + (0, 0, var_46f1b5eb.height), var_46f1b5eb.radius, (1, 0.5, 0), 1, 1);
						line(aoe.position, aoe.position + (0, 0, var_46f1b5eb.height), (1, 0.5, 0));
						if(aoe == var_87bbe4fc)
						{
							print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), ((("" + var_46f1b5eb.type) + "") + i) + "", (1, 0, 0));
						}
						else
						{
							print3d(aoe.position + (0, 0, var_46f1b5eb.height + 5), ((("" + var_46f1b5eb.type) + "") + i) + "", (1, 0.5, 0));
						}
						i++;
					}
				}
			}
			waitframe(1);
		}
	#/
}

