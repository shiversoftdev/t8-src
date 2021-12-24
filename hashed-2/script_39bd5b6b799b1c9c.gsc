// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace namespace_ad5a0cd6;

/*
	Name: __init__
	Namespace: namespace_ad5a0cd6
	Checksum: 0x5B751CC3
	Offset: 0x70
	Size: 0x18A
	Parameters: 0
	Flags: AutoExec
*/
autoexec function __init__()
{
	level.var_d8caca76 = function_a3975ce9();
	level.var_3f501cff = function_a04d222e() - 500;
	level.var_d051f0fe = function_d634ed59();
	level.var_8ee4985f = 115 * (((((16 + 1) + 6) + 1) + 6) + 1);
	level.var_c4160ac0 = level.var_d8caca76 - 2;
	/#
		assert((level.var_c4160ac0 + 1) == 32767);
	#/
	level.var_c1fb34bd = level.var_c4160ac0;
	level.var_b52c46a6 = level.var_c1fb34bd - level.var_8ee4985f;
	level.var_7d942c18 = level.var_b52c46a6 - 1;
	level.var_afaaa0ee = level.var_3f501cff;
	/#
		assert((level.var_7d942c18 - level.var_afaaa0ee) > 1024);
	#/
	level.var_b7364e19 = level.var_afaaa0ee - 1;
	level.var_6e47811c = 0;
}

/*
	Name: function_2eb2c17c
	Namespace: namespace_ad5a0cd6
	Checksum: 0x1113F913
	Offset: 0x208
	Size: 0x220
	Parameters: 2
	Flags: Linked
*/
function function_2eb2c17c(origin, item)
{
	traceoffset = vectorscale((0, 0, 1), 4);
	var_5d97fed1 = item.var_8e092725 === -1;
	var_8e2d9611 = item.origin + traceoffset;
	var_b0fbfe59 = bullettrace(origin, var_8e2d9611, 0, self, 0);
	if(var_b0fbfe59[#"fraction"] < 1 && var_b0fbfe59[#"entity"] !== item)
	{
		if(var_5d97fed1)
		{
			var_acdfe076 = isdefined(var_b0fbfe59[#"dynent"]) && distance2dsquared(var_b0fbfe59[#"dynent"].origin, item.origin) <= (12 * 12);
			var_45127074 = isdefined(var_b0fbfe59[#"entity"]) && distance2dsquared(var_b0fbfe59[#"entity"].origin, item.origin) <= (12 * 12);
			if(!var_acdfe076 && !var_45127074)
			{
				return 0;
			}
		}
		else
		{
			var_5408bd2a = physicstraceex(origin, var_8e2d9611, (0, 0, 0), (0, 0, 0), self, 1);
			if(var_5408bd2a[#"fraction"] >= 1)
			{
				return 1;
			}
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_6061a15
	Namespace: namespace_ad5a0cd6
	Checksum: 0xEF674D12
	Offset: 0x430
	Size: 0x792
	Parameters: 7
	Flags: Linked
*/
function function_6061a15(var_f4b807cb, maxdist, origin, angles, forward, var_4bd72bfe = 0, var_82043550 = 0)
{
	var_9b882d22 = undefined;
	bestdot = -1;
	var_1530699e = undefined;
	var_7cd624f6 = 2147483647;
	var_431e5926 = undefined;
	var_548943d3 = 2147483647;
	var_95d4627b = 0;
	var_490fd61a = undefined;
	var_6b7d827a = 2147483647;
	var_404fbede = 0;
	var_ba6bb2bd = undefined;
	var_9fd8216d = -1;
	var_75f6d739 = anglestoforward((0, angles[1], 0));
	var_66347f1f = 115 * 115;
	var_6b35a0b8 = 24 * 24;
	for(itemindex = 0; itemindex < var_f4b807cb.size; itemindex++)
	{
		itemdef = var_f4b807cb[itemindex];
		if(!isdefined(itemdef))
		{
			continue;
		}
		var_47684cd2 = itemdef.origin - origin;
		var_abd887b5 = distance2dsquared(itemdef.origin, origin);
		if(var_abd887b5 < var_66347f1f && (abs(itemdef.origin[2] - origin[2])) < 72)
		{
			dot = vectordot(forward, vectornormalize(var_47684cd2));
			if(dot >= 0.965 && var_abd887b5 < var_66347f1f && dot > var_9fd8216d)
			{
				if(!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef))
				{
					continue;
				}
				var_ba6bb2bd = itemdef;
				var_9fd8216d = dot;
			}
			if(isdefined(var_ba6bb2bd) && var_abd887b5 >= var_66347f1f)
			{
				break;
			}
			var_1777205e = vectordot(var_75f6d739, vectornormalize((var_47684cd2[0], var_47684cd2[1], 0)));
			var_c5722fe1 = 0;
			if(var_4bd72bfe)
			{
				var_c5722fe1 = itemdef.var_a6762160.itemtype == #"weapon";
			}
			if(var_1777205e >= 0.965 && (var_abd887b5 < var_6b7d827a || (!var_c5722fe1 && var_404fbede)) && var_abd887b5 > var_6b35a0b8)
			{
				if(isdefined(var_490fd61a) && var_c5722fe1 && !var_404fbede)
				{
					continue;
				}
				if(!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef))
				{
					continue;
				}
				var_490fd61a = itemdef;
				var_6b7d827a = var_abd887b5;
				var_404fbede = var_c5722fe1;
			}
			if(isdefined(var_490fd61a) && !var_404fbede)
			{
				break;
			}
			var_19b17831 = var_95d4627b || var_404fbede;
			if(var_1777205e >= 0.866 && var_1777205e < 0.965 && (var_abd887b5 < var_548943d3 || (!var_c5722fe1 && var_19b17831)) && var_abd887b5 > var_6b35a0b8)
			{
				if(isdefined(var_490fd61a) || isdefined(var_431e5926) && var_c5722fe1 && !var_19b17831)
				{
					continue;
				}
				if(!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef))
				{
					continue;
				}
				var_431e5926 = itemdef;
				var_548943d3 = var_abd887b5;
				var_95d4627b = var_c5722fe1;
			}
			continue;
		}
		var_7ef7c839 = isdefined(var_ba6bb2bd) || isdefined(var_490fd61a) || isdefined(var_431e5926) || isdefined(var_1530699e);
		if(var_7ef7c839)
		{
			break;
		}
		var_1777205e = vectordot(var_75f6d739, vectornormalize((var_47684cd2[0], var_47684cd2[1], 0)));
		if(var_1777205e >= 0.866 && var_abd887b5 < var_7cd624f6)
		{
			if(!self can_pick_up(itemdef) || !function_2eb2c17c(origin, itemdef))
			{
				continue;
			}
			var_1530699e = itemdef;
			var_7cd624f6 = var_abd887b5;
		}
	}
	if(isdefined(var_ba6bb2bd))
	{
		var_9b882d22 = var_ba6bb2bd;
	}
	else if(isdefined(var_490fd61a) && (!isdefined(var_431e5926) || !var_404fbede))
	{
		var_9b882d22 = var_490fd61a;
	}
	else if(isdefined(var_431e5926))
	{
		var_9b882d22 = var_431e5926;
	}
	else if(isdefined(var_1530699e))
	{
		var_9b882d22 = var_1530699e;
	}
	if(isdefined(var_9b882d22))
	{
		neardist = util::function_4c1656d5();
		var_9b882d22.var_5a15eef2 = neardist < maxdist && distance2dsquared(origin, var_9b882d22.origin) > (neardist * neardist);
		var_9b882d22.var_dae3e8db = distance2dsquared(origin, var_9b882d22.origin) < (128 - 12) * (128 - 12);
		var_9b882d22.var_5d97fed1 = var_9b882d22.var_8e092725 === -1;
	}
	return var_9b882d22;
}

/*
	Name: function_45efe0ab
	Namespace: namespace_ad5a0cd6
	Checksum: 0xD44CB6C5
	Offset: 0xBD0
	Size: 0xFA
	Parameters: 1
	Flags: None
*/
function function_45efe0ab(var_a6762160)
{
	var_caafaa25 = #"";
	if(isdefined(var_a6762160.weapon) && var_a6762160.weapon != level.weaponnone)
	{
		if(var_a6762160.itemtype != #"ammo")
		{
			var_caafaa25 = var_a6762160.weapon.displayname;
		}
		else
		{
			var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"");
		}
	}
	else
	{
		var_caafaa25 = (isdefined(var_a6762160.hintstring) ? var_a6762160.hintstring : #"");
	}
	return var_caafaa25;
}

/*
	Name: function_808be9a3
	Namespace: namespace_ad5a0cd6
	Checksum: 0x35475D85
	Offset: 0xCD8
	Size: 0x148
	Parameters: 2
	Flags: Linked
*/
function function_808be9a3(player, var_bd027dd9)
{
	/#
		assert(isplayer(player));
	#/
	/#
		assert(var_bd027dd9 >= level.var_b52c46a6 && var_bd027dd9 <= level.var_c1fb34bd);
	#/
	entnum = player getentitynumber();
	/#
		assert(entnum < 115);
	#/
	slotid = (var_bd027dd9 - level.var_b52c46a6) - (entnum * (((((16 + 1) + 6) + 1) + 6) + 1));
	/#
		assert(slotid >= 0 && slotid < (((((16 + 1) + 6) + 1) + 6) + 1));
	#/
	return slotid;
}

/*
	Name: function_c094ccd3
	Namespace: namespace_ad5a0cd6
	Checksum: 0xD2AC721F
	Offset: 0xE28
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_c094ccd3(var_bd027dd9)
{
	if(function_da09de95(var_bd027dd9))
	{
		return var_bd027dd9 - level.var_afaaa0ee;
	}
}

/*
	Name: function_1f0def85
	Namespace: namespace_ad5a0cd6
	Checksum: 0x65470300
	Offset: 0xE68
	Size: 0x130
	Parameters: 1
	Flags: Linked
*/
function function_1f0def85(item)
{
	/#
		assert(isdefined(item));
	#/
	if(!isdefined(item))
	{
		return 32767;
	}
	if(isstruct(item))
	{
		/#
			assert(isdefined(item.id));
		#/
		/#
			assert(item.id >= level.var_6e47811c && item.id <= level.var_b7364e19);
		#/
		return item.id;
	}
	entnum = item getentitynumber();
	var_bd027dd9 = entnum + level.var_afaaa0ee;
	/#
		assert(var_bd027dd9 >= level.var_afaaa0ee && var_bd027dd9 <= level.var_7d942c18);
	#/
	return var_bd027dd9;
}

/*
	Name: function_970b8d86
	Namespace: namespace_ad5a0cd6
	Checksum: 0xA6EA58D7
	Offset: 0xFA0
	Size: 0x1A8
	Parameters: 3
	Flags: Linked
*/
function function_970b8d86(player, slotid, var_259f58f3 = undefined)
{
	/#
		assert(isplayer(player));
	#/
	if(isdefined(var_259f58f3))
	{
		/#
			assert(var_259f58f3 <= 6);
		#/
		slotid = slotid + var_259f58f3;
	}
	/#
		assert(slotid >= 0 && slotid < (((((16 + 1) + 6) + 1) + 6) + 1));
	#/
	entnum = player getentitynumber();
	/#
		assert(entnum < 115);
	#/
	var_f5e3c230 = (entnum * (((((16 + 1) + 6) + 1) + 6) + 1)) + slotid;
	var_bd027dd9 = var_f5e3c230 + level.var_b52c46a6;
	/#
		assert(var_bd027dd9 >= level.var_b52c46a6 && var_bd027dd9 <= level.var_c1fb34bd);
	#/
	return var_bd027dd9;
}

/*
	Name: function_6af455de
	Namespace: namespace_ad5a0cd6
	Checksum: 0xD8E7EFFF
	Offset: 0x1150
	Size: 0x24C
	Parameters: 3
	Flags: Linked
*/
function function_6af455de(localclientnum, origin, angles)
{
	forward = anglestoforward(angles);
	vehicles = getentitiesinradius(origin, 1024, 12);
	var_bf3cabc9 = undefined;
	var_e664ecda = undefined;
	var_33b49591 = undefined;
	var_1dd6e163 = undefined;
	foreach(vehicle in vehicles)
	{
		occupied = 0;
		occupied = vehicle getvehoccupants().size > 0;
		if(occupied)
		{
			continue;
		}
		var_f902212b = vectornormalize(vehicle.origin - origin);
		dot = vectordot(forward, var_f902212b);
		var_aba3faed = distance2dsquared(vehicle.origin, origin);
		if(dot >= 0.965 && (!isdefined(var_e664ecda) || var_aba3faed < var_e664ecda))
		{
			var_bf3cabc9 = vehicle;
			var_e664ecda = var_aba3faed;
		}
		if(dot >= 0.5 && var_aba3faed <= (128 * 128) && (!isdefined(var_1dd6e163) || var_aba3faed < var_1dd6e163))
		{
			var_33b49591 = vehicle;
			var_1dd6e163 = var_aba3faed;
		}
	}
	if(isdefined(var_33b49591))
	{
		return var_33b49591;
	}
	return var_bf3cabc9;
}

/*
	Name: function_c62ad9a7
	Namespace: namespace_ad5a0cd6
	Checksum: 0xD6489A63
	Offset: 0x13A8
	Size: 0x1EE
	Parameters: 1
	Flags: Linked
*/
function function_c62ad9a7(vehicle)
{
	hinttext = #"";
	if(isdefined(vehicle) && isdefined(vehicle.scriptvehicletype))
	{
		switch(vehicle.scriptvehicletype)
		{
			case "player_atv":
			{
				hinttext = #"hash_2007e0c3be383f26";
				break;
			}
			case "helicopter_light":
			{
				hinttext = #"hash_8b24b9a8b37cbd4";
				break;
			}
			case "cargo_truck_wz":
			{
				hinttext = #"hash_31aeb0f803285127";
				break;
			}
			case "tactical_raft_wz":
			{
				hinttext = #"hash_602556b5bd4f952d";
				break;
			}
			case "player_fav":
			{
				hinttext = #"hash_d4649719cad3c69";
				break;
			}
			case "player_suv":
			{
				hinttext = #"hash_51759939a9774d6d";
				break;
			}
			case "player_muscle":
			{
				hinttext = #"hash_5057fbcd1ec7a683";
				break;
			}
			case "pbr_boat_wz":
			{
				hinttext = #"hash_4a4c5c39a5d5f303";
				break;
			}
			case "player_motorcycle":
			{
				hinttext = #"hash_27cc3dadf4c042d8";
				break;
			}
			case "player_tank":
			{
				hinttext = #"hash_47934713b29ff6f5";
				break;
			}
		}
	}
	return hinttext;
}

/*
	Name: can_pick_up
	Namespace: namespace_ad5a0cd6
	Checksum: 0xF5BF00AB
	Offset: 0x15A0
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function can_pick_up(item, servertime = undefined)
{
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return 0;
	}
	if(isdefined(servertime))
	{
		if(item.var_8e092725 > 0 && item.var_8e092725 <= servertime)
		{
			return 0;
		}
	}
	else if(item.var_8e092725 > 0 && item.var_8e092725 != -1)
	{
		return 0;
	}
	if(!isstruct(item) && item getitemindex() == 32767)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_4cbb6617
	Namespace: namespace_ad5a0cd6
	Checksum: 0xBB3442CE
	Offset: 0x1698
	Size: 0x2F6
	Parameters: 4
	Flags: None
*/
function function_4cbb6617(inventory, itemtype, var_da328e7b, var_bcc2655a)
{
	/#
		assert(function_7a600918(itemtype));
	#/
	/#
		assert(isarray(var_da328e7b));
	#/
	if(!isdefined(var_bcc2655a))
	{
		return;
	}
	items = [];
	var_c7837092 = function_d73e17cb(var_bcc2655a);
	foreach(item in inventory.items)
	{
		if(!isdefined(item))
		{
			continue;
		}
		if(item.id == 32767)
		{
			continue;
		}
		if(!isdefined(item.var_a6762160))
		{
			continue;
		}
		var_b74300d3 = function_d73e17cb(item.var_a6762160);
		if(item.var_a6762160.itemtype == itemtype)
		{
			if(isdefined(items[var_b74300d3]))
			{
				if(item.count > items[var_b74300d3].count)
				{
					items[var_b74300d3] = item;
				}
				continue;
			}
			items[var_b74300d3] = item;
		}
	}
	var_db14b831 = [];
	for(currentindex = 0; currentindex < var_da328e7b.size; currentindex++)
	{
		if(var_da328e7b[currentindex] == var_c7837092)
		{
			break;
		}
	}
	for(index = currentindex + 1; index < var_da328e7b.size; index++)
	{
		var_b74300d3 = var_da328e7b[index];
		if(isdefined(items[var_b74300d3]))
		{
			var_db14b831[var_db14b831.size] = items[var_b74300d3];
		}
	}
	if(currentindex < var_da328e7b.size)
	{
		for(index = 0; index < currentindex; index++)
		{
			var_b74300d3 = var_da328e7b[index];
			if(isdefined(items[var_b74300d3]))
			{
				var_db14b831[var_db14b831.size] = items[var_b74300d3];
			}
		}
	}
	return var_db14b831;
}

/*
	Name: function_f73bc33
	Namespace: namespace_ad5a0cd6
	Checksum: 0xB3FE4995
	Offset: 0x1998
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function function_f73bc33(item)
{
	return (isdefined(item.var_bd027dd9) ? item.var_bd027dd9 : item.id);
}

/*
	Name: function_d73e17cb
	Namespace: namespace_ad5a0cd6
	Checksum: 0x9E6508A0
	Offset: 0x19D8
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function function_d73e17cb(var_a6762160)
{
	return (isdefined(var_a6762160.var_456aa154) ? getscriptbundle(var_a6762160.var_456aa154).name : var_a6762160.name);
}

/*
	Name: function_31f5aa51
	Namespace: namespace_ad5a0cd6
	Checksum: 0x4C9E891
	Offset: 0x1A30
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function function_31f5aa51(item)
{
	if(!isdefined(item) || (!isdefined(item.targetname) && !isdefined(item.var_67169c0b)))
	{
		return;
	}
	targetname = (isdefined(item.targetname) ? item.targetname : item.var_67169c0b);
	stashes = level.var_93d08989[targetname];
	if(!isdefined(stashes) || stashes.size <= 0)
	{
		return;
	}
	stashes = arraysortclosest(stashes, item.origin, 1, 0, 12);
	if(stashes.size <= 0)
	{
		return;
	}
	return stashes[0];
}

/*
	Name: function_da09de95
	Namespace: namespace_ad5a0cd6
	Checksum: 0xD14EE626
	Offset: 0x1B30
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_da09de95(id)
{
	return id >= level.var_afaaa0ee && id <= level.var_7d942c18;
}

/*
	Name: function_7363384a
	Namespace: namespace_ad5a0cd6
	Checksum: 0xBF15F864
	Offset: 0x1B70
	Size: 0x60
	Parameters: 1
	Flags: Linked
*/
function function_7363384a(name)
{
	bundle = getscriptbundle(name);
	if(!isdefined(bundle))
	{
		return 0;
	}
	if(bundle.type != #"hash_10587321f369e7f3")
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_db35e94f
	Namespace: namespace_ad5a0cd6
	Checksum: 0x9FFDD161
	Offset: 0x1BD8
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_db35e94f(id)
{
	return id >= level.var_b52c46a6 && id <= level.var_c1fb34bd;
}

/*
	Name: function_41f06d9d
	Namespace: namespace_ad5a0cd6
	Checksum: 0xB5BE0787
	Offset: 0x1C18
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_41f06d9d(var_a6762160)
{
	if(!isdefined(var_a6762160) || !isdefined(var_a6762160.name))
	{
		return 0;
	}
	return var_a6762160.name == #"hash_5e9c3f9821e1ee0a" || var_a6762160.name == #"hash_470d57195b2db913";
}

/*
	Name: function_74e1e547
	Namespace: namespace_ad5a0cd6
	Checksum: 0xF5FB9E1A
	Offset: 0x1C90
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_74e1e547(point)
{
	return function_3238d10d(point);
}

/*
	Name: function_2c7fc531
	Namespace: namespace_ad5a0cd6
	Checksum: 0x9319CFC8
	Offset: 0x1CC0
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_2c7fc531(id)
{
	return id >= level.var_6e47811c && id <= level.var_b7364e19;
}

/*
	Name: function_d9648161
	Namespace: namespace_ad5a0cd6
	Checksum: 0x9A0E6EA0
	Offset: 0x1D00
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_d9648161(id)
{
	return id >= level.var_6e47811c && id <= 32767;
}

/*
	Name: function_35e06774
	Namespace: namespace_ad5a0cd6
	Checksum: 0x2876B05C
	Offset: 0x1D38
	Size: 0x2A6
	Parameters: 2
	Flags: Linked
*/
function function_35e06774(var_a6762160, var_48cfb6ca = 0)
{
	if(isdefined(var_a6762160) && isdefined(var_a6762160.weapon) && (isarray(var_a6762160.attachments) || var_48cfb6ca))
	{
		attachments = [];
		foreach(attachment in var_a6762160.attachments)
		{
			attachments[attachments.size] = attachment.var_6be1bec7;
		}
		if(var_48cfb6ca)
		{
			foreach(attachment in var_a6762160.attachments)
			{
				var_fe35755b = getscriptbundle(attachment.var_6be1bec7);
				if(!isdefined(var_fe35755b) || var_fe35755b.type != #"hash_10587321f369e7f3" || !isarray(var_fe35755b.attachments))
				{
					continue;
				}
				foreach(var_a4559ed2 in var_fe35755b.attachments)
				{
					attachments[attachments.size] = var_a4559ed2.var_6be1bec7;
				}
			}
		}
		weapon = getweapon(var_a6762160.weapon.name, attachments);
		return function_1242e467(weapon);
	}
	if(isdefined(var_a6762160))
	{
		return var_a6762160.weapon;
	}
	return undefined;
}

/*
	Name: function_f4a8d375
	Namespace: namespace_ad5a0cd6
	Checksum: 0xCB69AA6C
	Offset: 0x1FE8
	Size: 0x8E
	Parameters: 1
	Flags: Linked
*/
function function_f4a8d375(var_d8138db2)
{
	/#
		assert(function_2c7fc531(var_d8138db2));
	#/
	point = function_b1702735(var_d8138db2);
	if(isdefined(point))
	{
		var_a6762160 = point.var_a6762160;
		return function_35e06774(var_a6762160);
	}
	return undefined;
}

