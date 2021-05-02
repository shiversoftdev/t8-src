// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_6ad3fda349f49bf9;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_94f334ac;

/*
	Name: init_shared
	Namespace: namespace_94f334ac
	Checksum: 0xE95909AE
	Offset: 0x3C8
	Size: 0x6C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	if(!isdefined(level.var_422c4695))
	{
		level.var_422c4695 = [];
	}
	if(!isdefined(level.var_1a8113a7))
	{
		level.var_1a8113a7 = [];
	}
	if(!isdefined(level.var_11631715))
	{
		level.var_11631715 = [];
	}
	registerclientfields();
}

/*
	Name: function_b53fa4ba
	Namespace: namespace_94f334ac
	Checksum: 0x802BCAD0
	Offset: 0x440
	Size: 0xDA
	Parameters: 1
	Flags: None
*/
function function_b53fa4ba(entity)
{
	if(!isdefined(entity))
	{
		return getweapon(#"none");
	}
	if(isdefined(entity.vehicletype))
	{
		if(entity.vehicletype == #"vehicle_t8_mil_helicopter_swat_transport")
		{
			return getweapon("player_air_vehicle1_main_turret_3rd_person_swat");
		}
		if(entity.vehicletype == #"hash_69af304f79c30059")
		{
			return getweapon("overwatch_helicopter");
		}
	}
	return getweapon(#"none");
}

/*
	Name: function_b2755499
	Namespace: namespace_94f334ac
	Checksum: 0xDD7FB740
	Offset: 0x528
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function function_b2755499(weapon, entity)
{
	var_373a6acd = weapon;
	switch(weapon.name)
	{
		case "cobra_20mm_comlink":
		{
			var_373a6acd = getweapon("helicopter_comlink");
			break;
		}
		case "hash_36a6454f13b54f18":
		{
			var_373a6acd = getweapon("ultimate_turret");
			break;
		}
		case "hash_17df39d53492b0bf":
		{
			var_373a6acd = getweapon("ac130");
			break;
		}
		case "straferun_gun":
		{
			var_373a6acd = getweapon("straferun");
			break;
		}
		case "hash_26ffb92552ae26be":
		{
			var_373a6acd = getweapon("drone_squadron");
			break;
		}
		case "hash_7eca6eae4128f3a0":
		{
			var_373a6acd = function_b53fa4ba(entity);
			break;
		}
		case "hash_61b88900b127386a":
		case "hash_71088fcd3aaa23fb":
		{
			var_373a6acd = getweapon("eq_hawk");
			break;
		}
	}
	return var_373a6acd;
}

/*
	Name: registerclientfields
	Namespace: namespace_94f334ac
	Checksum: 0xEE6BD5A3
	Offset: 0x6C8
	Size: 0x4C4
	Parameters: 0
	Flags: Private
*/
private function registerclientfields()
{
	clientfield::register("toplayer", "gadget_icepick_on", 9000, 1, "int", &function_c6d0809e, 0, 0);
	clientfield::register("toplayer", "currentlyHacking", 9000, 1, "int", &function_d3c5b110, 0, 0);
	clientfield::register("toplayer", "hackedvehpostfx", 9000, 1, "int", &function_4a82368f, 0, 1);
	clientfield::register("toplayer", "currentlybeinghackedplayer", 9000, 4, "int", &function_39f69700, 0, 0);
	clientfield::register("clientuimodel", "IcePickInfo.hackStarted", 9000, 1, "int", &function_fd2904cd, 0, 0);
	clientfield::register("clientuimodel", "IcePickInfo.hackFinished", 9000, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "IcePickInfo.hackEquipFinished", 9000, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "IcePickInfo.hackVehicleFinished", 9000, 1, "int", undefined, 0, 0);
	clientfield::register("clientuimodel", "hudItems.hacked", 9000, 1, "int", &function_868adc20, 0, 0);
	clientfield::register("clientuimodel", "hudItems.hackedRebootProgress", 9000, 5, "float", undefined, 0, 0);
	clientfield::register("clientuimodel", "IcePickInfo.currentHackProgress", 9000, 5, "float", undefined, 0, 0);
	clientfield::register("missile", "cant_be_hacked", 9000, 1, "int", &function_45e26cb2, 0, 0);
	clientfield::register("vehicle", "cant_be_hacked", 9000, 1, "int", &function_45e26cb2, 0, 0);
	clientfield::register("scriptmover", "cant_be_hacked", 9000, 1, "int", &function_45e26cb2, 0, 0);
	clientfield::register("scriptmover", "hackStatus", 9000, 2, "int", &function_1238516b, 0, 0);
	clientfield::register("missile", "hackStatus", 9000, 2, "int", &function_1238516b, 0, 0);
	clientfield::register("vehicle", "hackStatus", 9000, 2, "int", &function_1238516b, 0, 0);
	clientfield::register("allplayers", "hackStatus", 9000, 2, "int", &function_1238516b, 0, 1);
}

/*
	Name: function_45e26cb2
	Namespace: namespace_94f334ac
	Checksum: 0x37AB8D8C
	Offset: 0xB98
	Size: 0x66
	Parameters: 7
	Flags: None
*/
function function_45e26cb2(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_acee3911 = 1;
	}
	else
	{
		self.var_acee3911 = 0;
	}
}

/*
	Name: function_d3c5b110
	Namespace: namespace_94f334ac
	Checksum: 0x58D4C8D7
	Offset: 0xC08
	Size: 0xFC
	Parameters: 7
	Flags: None
*/
function function_d3c5b110(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(level.var_1a8113a7[local_client_num]))
		{
			level.var_1a8113a7[local_client_num] = function_604c9983(local_client_num, #"hash_7c507989ceae567f");
		}
	}
	else if(isdefined(level.var_1a8113a7[local_client_num]))
	{
		function_d48752e(local_client_num, level.var_1a8113a7[local_client_num]);
		level.var_1a8113a7[local_client_num] = undefined;
		playsound(local_client_num, #"hash_1d4f78480965b59d");
	}
}

/*
	Name: function_39f69700
	Namespace: namespace_94f334ac
	Checksum: 0x756D6AA2
	Offset: 0xD10
	Size: 0x2CE
	Parameters: 7
	Flags: None
*/
function function_39f69700(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	parentmodel = getuimodel(getuimodelforcontroller(local_client_num), "IcePickHackables");
	if(!isdefined(parentmodel))
	{
		return;
	}
	totalcount = getuimodelvalue(getuimodel(parentmodel, "hackablesCount"));
	for(index = 0; index < totalcount; index++)
	{
		var_e4130a92 = getuimodel(parentmodel, "item" + index);
		isplayer = getuimodelvalue(getuimodel(var_e4130a92, "hackableCategory")) == 0;
		if(!isplayer)
		{
			continue;
		}
		var_959dd66c = getuimodelvalue(getuimodel(var_e4130a92, "hackableId"));
		if(newval == -1)
		{
			setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), 0);
			continue;
		}
		else if(newval == -2)
		{
			setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), 2);
			continue;
		}
		if(var_959dd66c < newval)
		{
			setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), 2);
			continue;
		}
		if(var_959dd66c == newval)
		{
			setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), 1);
			continue;
		}
		setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), 0);
	}
}

/*
	Name: function_ca096bad
	Namespace: namespace_94f334ac
	Checksum: 0x850008DB
	Offset: 0xFE8
	Size: 0x26C
	Parameters: 7
	Flags: None
*/
function function_ca096bad(model, index, var_3cf2d21, entnum, category, categoryindex, weapon)
{
	var_e4130a92 = createuimodel(model, "item" + index);
	if(isdefined(var_3cf2d21))
	{
		setuimodelvalue(createuimodel(var_e4130a92, "hackableName"), var_3cf2d21);
	}
	var_c097c11c = 0;
	setuimodelvalue(createuimodel(var_e4130a92, "hackableId"), entnum);
	if(isdefined(weapon) && weapon.statname != #"")
	{
		weaponindex = getitemindexfromref(weapon.statname);
		setuimodelvalue(createuimodel(var_e4130a92, "hackableItemIndex"), weaponindex);
		var_c097c11c = weapon.var_df381b5d == 2;
	}
	setuimodelvalue(createuimodel(var_e4130a92, "hackableCategory"), category);
	setuimodelvalue(createuimodel(var_e4130a92, "indexWithinCategory"), categoryindex);
	setuimodelvalue(createuimodel(var_e4130a92, "hackStatus"), 0);
	setuimodelvalue(createuimodel(var_e4130a92, "hackableDoubleWidth"), var_c097c11c);
	setuimodelvalue(createuimodel(var_e4130a92, "hackableFlavorText"), #"");
}

/*
	Name: function_808efdee
	Namespace: namespace_94f334ac
	Checksum: 0xABF87136
	Offset: 0x1260
	Size: 0x162
	Parameters: 3
	Flags: None
*/
function function_808efdee(hacker, entity, weapon)
{
	if(hacker.team == entity.team)
	{
		return 0;
	}
	if(!isdefined(weapon) || !isdefined(weapon.displayname) || weapon.displayname == "")
	{
		return 0;
	}
	if(!weapon.ishackable)
	{
		return 0;
	}
	if(entity.type == "missile" || entity.type == "vehicle" || entity.type == "scriptmover" && entity clientfield::get("cant_be_hacked"))
	{
		return 0;
	}
	if(entity.type == "NA")
	{
		return 0;
	}
	if(weapon == getweapon("gadget_supplypod") && entity.type != "scriptmover")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_8d50c205
	Namespace: namespace_94f334ac
	Checksum: 0x11D6BAE0
	Offset: 0x13D0
	Size: 0xF8
	Parameters: 2
	Flags: None
*/
function function_8d50c205(left, right)
{
	var_93633a81 = function_b2755499(left.weapon, left);
	var_84792f3e = function_b2755499(right.weapon, right);
	if(isplayer(left) || isplayer(right) || var_93633a81.var_8134b209 == var_84792f3e.var_8134b209)
	{
		return left getentitynumber() < right getentitynumber();
	}
	return var_93633a81.var_8134b209 < var_84792f3e.var_8134b209;
}

/*
	Name: function_adceefd
	Namespace: namespace_94f334ac
	Checksum: 0x664225A8
	Offset: 0x14D0
	Size: 0x380
	Parameters: 2
	Flags: None
*/
function function_adceefd(local_client_num, hacker)
{
	var_94e70cdd = [];
	var_94e70cdd[0] = [];
	var_94e70cdd[1] = [];
	var_94e70cdd[2] = [];
	players = getplayers(local_client_num);
	foreach(player in players)
	{
		if(player.team == hacker.team)
		{
			continue;
		}
		if(!isdefined(var_94e70cdd[0]))
		{
			var_94e70cdd[0] = [];
		}
		else if(!isarray(var_94e70cdd[0]))
		{
			var_94e70cdd[0] = array(var_94e70cdd[0]);
		}
		var_94e70cdd[0][var_94e70cdd[0].size] = player;
	}
	var_88d95648 = function_e563a9b(local_client_num);
	foreach(var_20651f4 in var_88d95648)
	{
		if(isplayer(var_20651f4))
		{
			continue;
		}
		var_96cc400c = function_b2755499(var_20651f4.weapon, var_20651f4);
		if(!function_808efdee(self, var_20651f4, var_96cc400c))
		{
			continue;
		}
		if(!isdefined(var_94e70cdd[var_96cc400c.var_a8bd8bb2]))
		{
			var_94e70cdd[var_96cc400c.var_a8bd8bb2] = [];
		}
		else if(!isarray(var_94e70cdd[var_96cc400c.var_a8bd8bb2]))
		{
			var_94e70cdd[var_96cc400c.var_a8bd8bb2] = array(var_94e70cdd[var_96cc400c.var_a8bd8bb2]);
		}
		var_94e70cdd[var_96cc400c.var_a8bd8bb2][var_94e70cdd[var_96cc400c.var_a8bd8bb2].size] = var_20651f4;
	}
	array::function_b63fcb3(var_94e70cdd[0], &function_8d50c205);
	array::function_b63fcb3(var_94e70cdd[1], &function_8d50c205);
	array::function_b63fcb3(var_94e70cdd[2], &function_8d50c205);
	return var_94e70cdd;
}

/*
	Name: watchfordeath
	Namespace: namespace_94f334ac
	Checksum: 0x3130A27D
	Offset: 0x1858
	Size: 0x10C
	Parameters: 3
	Flags: None
*/
function watchfordeath(local_client_num, entity, index)
{
	entity endon(#"hash_321e96994b3767cd");
	while(isdefined(entity) && (!(isdefined(entity.var_acee3911) && entity.var_acee3911)))
	{
		waitframe(1);
	}
	parentmodel = getuimodel(getuimodelforcontroller(local_client_num), "IcePickHackables");
	if(!isdefined(parentmodel))
	{
		return;
	}
	var_e4130a92 = createuimodel(parentmodel, "item" + index);
	setuimodelvalue(createuimodel(var_e4130a92, "hackStatus"), 3);
}

/*
	Name: function_9e88e881
	Namespace: namespace_94f334ac
	Checksum: 0x81AB0D84
	Offset: 0x1970
	Size: 0x58C
	Parameters: 1
	Flags: None
*/
function function_9e88e881(local_client_num)
{
	self endon(#"hash_3eb91a66cb027059");
	self endon(#"death");
	var_e2d02d46 = createuimodel(getuimodelforcontroller(local_client_num), "IcePickHackables");
	var_a9705012 = [];
	var_a9705012[0] = 0;
	var_a9705012[1] = 0;
	var_a9705012[2] = 0;
	var_88d95648 = function_e563a9b(local_client_num);
	var_9411ea0 = 0;
	var_e33ae97c = function_adceefd(local_client_num, self);
	numplayers = getdvarint(#"com_maxclients", 0);
	for(i = 0; i < numplayers; i++)
	{
		function_ca096bad(var_e2d02d46, var_9411ea0, #"", i, 0, var_a9705012[0], undefined);
		var_9411ea0++;
		var_a9705012[0]++;
	}
	var_8b745faa = getweapon(#"gadget_icepick");
	var_a4739e20 = getscriptbundle(var_8b745faa.var_4dd46f8a);
	var_9b81203 = var_a4739e20.var_a65e249e;
	var_f998f517 = 0;
	foreach(var_20651f4 in var_e33ae97c[1])
	{
		var_b095c57b = function_b2755499(var_20651f4.weapon, var_20651f4);
		var_f998f517 = var_f998f517 + var_b095c57b.var_df381b5d;
		if(var_f998f517 > var_9b81203)
		{
			break;
		}
		function_ca096bad(var_e2d02d46, var_9411ea0, var_b095c57b.displayname, var_20651f4 getentitynumber(), var_b095c57b.var_a8bd8bb2, var_a9705012[var_b095c57b.var_a8bd8bb2], var_b095c57b);
		thread watchfordeath(local_client_num, var_20651f4, var_9411ea0);
		var_a9705012[var_b095c57b.var_a8bd8bb2]++;
		var_9411ea0++;
	}
	var_f998f517 = 0;
	foreach(var_20651f4 in var_e33ae97c[2])
	{
		var_b095c57b = function_b2755499(var_20651f4.weapon, var_20651f4);
		var_f998f517 = var_f998f517 + var_b095c57b.var_df381b5d;
		if(var_f998f517 > var_9b81203)
		{
			break;
		}
		function_ca096bad(var_e2d02d46, var_9411ea0, var_b095c57b.displayname, var_20651f4 getentitynumber(), var_b095c57b.var_a8bd8bb2, var_a9705012[var_b095c57b.var_a8bd8bb2], var_b095c57b);
		thread watchfordeath(local_client_num, var_20651f4, var_9411ea0);
		var_a9705012[var_b095c57b.var_a8bd8bb2]++;
		var_9411ea0++;
	}
	setuimodelvalue(createuimodel(var_e2d02d46, "hackablesCount"), var_9411ea0);
	var_d2291427 = createuimodel(var_e2d02d46, "hackablesCategoryCounts");
	setuimodelvalue(createuimodel(var_d2291427, "" + 0), var_a9705012[0]);
	setuimodelvalue(createuimodel(var_d2291427, "" + 1), var_a9705012[1]);
	setuimodelvalue(createuimodel(var_d2291427, "" + 2), var_a9705012[2]);
}

/*
	Name: function_868adc20
	Namespace: namespace_94f334ac
	Checksum: 0x2CDF27E
	Offset: 0x1F08
	Size: 0x124
	Parameters: 7
	Flags: None
*/
function function_868adc20(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1 && oldval != 1)
	{
		if(!isdefined(level.var_422c4695[local_client_num]))
		{
			level.var_422c4695[local_client_num] = function_604c9983(local_client_num, #"hash_48af3a16cdf94e6f");
		}
	}
	else if(newval == 0 && isdefined(level.var_422c4695[local_client_num]))
	{
		function_d48752e(local_client_num, level.var_422c4695[local_client_num]);
		level.var_422c4695[local_client_num] = undefined;
		if(!bwastimejump)
		{
			playsound(local_client_num, #"hash_b5e00bf57762b86");
		}
	}
}

/*
	Name: function_c6d0809e
	Namespace: namespace_94f334ac
	Checksum: 0xF4660742
	Offset: 0x2038
	Size: 0xCE
	Parameters: 7
	Flags: None
*/
function function_c6d0809e(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self thread function_9e88e881(local_client_num);
	}
	else if(newval == 0 && oldval == 1)
	{
		level notify(#"hash_3eb91a66cb027059");
		var_e2d02d46 = createuimodel(getuimodelforcontroller(local_client_num), "IcePickHackables");
	}
}

/*
	Name: function_4a82368f
	Namespace: namespace_94f334ac
	Checksum: 0x4806162E
	Offset: 0x2110
	Size: 0xF4
	Parameters: 7
	Flags: None
*/
function function_4a82368f(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	isplaying = postfx::function_556665f2(#"hash_108c587fdd95588a");
	if(newval == 1)
	{
		if(!isplaying && self isremotecontrolling(local_client_num))
		{
			self postfx::playpostfxbundle(#"hash_108c587fdd95588a");
		}
	}
	else if(newval == 0)
	{
		if(isplaying)
		{
			self postfx::stoppostfxbundle(#"hash_108c587fdd95588a");
		}
	}
}

/*
	Name: function_67b9bc99
	Namespace: namespace_94f334ac
	Checksum: 0x632F7FD5
	Offset: 0x2210
	Size: 0xF0
	Parameters: 2
	Flags: Private
*/
private function function_67b9bc99(player, local_client_num)
{
	entitynumber = player getentitynumber();
	if(isdefined(level.var_11631715[entitynumber]) && isarray(level.var_11631715[entitynumber]))
	{
		foreach(fx in level.var_11631715[entitynumber])
		{
			stopfx(local_client_num, fx);
		}
	}
}

/*
	Name: function_d96f79be
	Namespace: namespace_94f334ac
	Checksum: 0x85F0F988
	Offset: 0x2308
	Size: 0x19C
	Parameters: 4
	Flags: None
*/
function function_d96f79be(local_client_num, oldval, newval, bwastimejump)
{
	if(self function_da43934d() && newval == 2)
	{
		return;
	}
	starttime = gettime();
	while(isdefined(self) && !self hasdobj(local_client_num))
	{
		if(gettime() - starttime > 1000)
		{
			return;
		}
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	entitynumber = self getentitynumber();
	if(!isdefined(level.var_11631715[entitynumber]))
	{
		level.var_11631715[entitynumber] = [];
	}
	if(newval == 2 && !bwastimejump)
	{
		function_67b9bc99(self, local_client_num);
		level.var_11631715[entitynumber] = playtagfxset(local_client_num, "gadget_icepick_hacked_3p", self);
	}
	else if(newval == 0 && oldval == 2 && isdefined(level.var_11631715[entitynumber]))
	{
		function_67b9bc99(self, local_client_num);
	}
}

/*
	Name: function_34aba8d8
	Namespace: namespace_94f334ac
	Checksum: 0x470B181C
	Offset: 0x24B0
	Size: 0x232
	Parameters: 3
	Flags: Private
*/
private function function_34aba8d8(local_client_num, targetid, newval)
{
	parentmodel = getuimodel(getuimodelforcontroller(local_client_num), "IcePickHackables");
	if(!isdefined(parentmodel))
	{
		return;
	}
	totalcount = getuimodelvalue(getuimodel(parentmodel, "hackablesCount"));
	for(index = 0; index < totalcount; index++)
	{
		var_e4130a92 = getuimodel(parentmodel, "item" + index);
		var_959dd66c = getuimodelvalue(getuimodel(var_e4130a92, "hackableId"));
		if(var_959dd66c != targetid)
		{
			continue;
		}
		if(newval == 1)
		{
			if(!isplayer(self))
			{
				var_b095c57b = function_b2755499(self.weapon, self);
				var_cce9de60 = var_b095c57b.var_77b46a8c;
			}
			else
			{
				var_cce9de60 = #"";
			}
			setuimodelvalue(getuimodel(var_e4130a92, "hackableFlavorText"), var_cce9de60);
		}
		else if(newval == 2)
		{
			self notify(#"hash_321e96994b3767cd");
		}
		setuimodelvalue(getuimodel(var_e4130a92, "hackStatus"), newval);
		break;
	}
}

/*
	Name: function_91803954
	Namespace: namespace_94f334ac
	Checksum: 0xEBA9AE7A
	Offset: 0x26F0
	Size: 0x1A8
	Parameters: 3
	Flags: None
*/
function function_91803954(local_client_num, oldval, newval)
{
	starttime = gettime();
	while(isdefined(self) && !self hasdobj(local_client_num))
	{
		if(gettime() - starttime > 1000)
		{
			return;
		}
		waitframe(1);
	}
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(self.weapon))
	{
		return;
	}
	weapon = function_b2755499(self.weapon);
	if(!isdefined(weapon))
	{
		return;
	}
	if(!isdefined(weapon.var_26f68e75))
	{
		return;
	}
	if(newval == 1)
	{
		self.var_2cd459a0 = playtagfxset(local_client_num, weapon.var_26f68e75, self);
	}
	else if(newval != 1 && oldval == 1 && isdefined(self.var_2cd459a0))
	{
		foreach(fx in self.var_2cd459a0)
		{
			stopfx(local_client_num, fx);
		}
	}
}

/*
	Name: function_1238516b
	Namespace: namespace_94f334ac
	Checksum: 0x3A7D9481
	Offset: 0x28A0
	Size: 0x12C
	Parameters: 7
	Flags: None
*/
function function_1238516b(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isplayer(self))
	{
		self killstreak_detect::function_d859c344(local_client_num, newval);
		self thread function_91803954(local_client_num, oldval, newval);
	}
	else
	{
		self thread function_d96f79be(local_client_num, oldval, newval, bwastimejump);
	}
	if(!isdefined(self))
	{
		return;
	}
	targetid = self getentitynumber();
	var_37ceef06 = clientfield::get_to_player("gadget_icepick_on");
	if(var_37ceef06)
	{
		self function_34aba8d8(local_client_num, targetid, newval);
	}
}

/*
	Name: function_fd2904cd
	Namespace: namespace_94f334ac
	Checksum: 0x8CD5640D
	Offset: 0x29D8
	Size: 0x3C
	Parameters: 7
	Flags: None
*/
function function_fd2904cd(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

