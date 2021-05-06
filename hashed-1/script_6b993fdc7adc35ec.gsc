// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39bd5b6b799b1c9c;

#namespace namespace_a0d533d1;

/*
	Name: function_c92543a0
	Namespace: namespace_a0d533d1
	Checksum: 0x297D0EF4
	Offset: 0x218
	Size: 0x8A
	Parameters: 2
	Flags: Private
*/
private function function_c92543a0(var_84704ed7, attachmentname)
{
	attachment = spawnstruct();
	attachment.id = var_84704ed7.id;
	attachment.var_bd027dd9 = var_84704ed7.var_bd027dd9;
	attachment.var_a6762160 = var_84704ed7.var_a6762160;
	attachment.var_4c342187 = attachmentname;
	return attachment;
}

/*
	Name: function_9e9c82a6
	Namespace: namespace_a0d533d1
	Checksum: 0xF23C3DB3
	Offset: 0x2B0
	Size: 0x2D8
	Parameters: 4
	Flags: Linked
*/
function function_9e9c82a6(item, var_84704ed7, var_41a74919 = 1, var_31d2edc5 = 0)
{
	/#
		assert(isstruct(item));
	#/
	/#
		assert(isstruct(var_84704ed7));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != #"weapon")
	{
		return 0;
	}
	if(!isdefined(var_84704ed7) || !isdefined(var_84704ed7.var_a6762160) || !isdefined(var_84704ed7.var_bd027dd9) || var_84704ed7.var_a6762160.itemtype != #"attachment")
	{
		return 0;
	}
	if(isdefined(item.attachments))
	{
		foreach(attachment in item.attachments)
		{
			if(isdefined(attachment) && attachment.var_bd027dd9 == var_84704ed7.var_bd027dd9)
			{
				return 0;
			}
		}
	}
	attachmentname = function_2ced1d34(item, var_84704ed7.var_a6762160, var_31d2edc5);
	if(!isdefined(attachmentname))
	{
		return 0;
	}
	var_84704ed7.var_4c342187 = attachmentname;
	if(!isdefined(item.attachments))
	{
		item.attachments = [];
	}
	else if(!isarray(item.attachments))
	{
		item.attachments = array(item.attachments);
	}
	item.attachments[item.attachments.size] = var_84704ed7;
	if(var_41a74919)
	{
		function_6e9e7169(item);
	}
	return 1;
}

/*
	Name: function_2ced1d34
	Namespace: namespace_a0d533d1
	Checksum: 0x95499D55
	Offset: 0x590
	Size: 0x4F4
	Parameters: 3
	Flags: Linked
*/
function function_2ced1d34(item, var_fe35755b, var_21055e1a = 0)
{
	/#
		assert(isdefined(item));
	#/
	/#
		assert(isdefined(var_fe35755b));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return;
	}
	if(!isdefined(var_fe35755b))
	{
		return;
	}
	if(item.var_a6762160.itemtype != #"weapon")
	{
		/#
			assert(0, "");
		#/
		return;
	}
	if(var_fe35755b.itemtype != #"attachment")
	{
		/#
			assert(0, "");
		#/
		return;
	}
	if(!isdefined(var_fe35755b.attachments) || var_fe35755b.attachments.size <= 0)
	{
		return;
	}
	weapon = namespace_ad5a0cd6::function_35e06774(item.var_a6762160);
	if(isdefined(weapon) && isdefined(weapon.statname) && weapon.statname != #"")
	{
		weapon = getweapon(weapon.statname);
	}
	if(!isdefined(weapon) || !isdefined(weapon.supportedattachments) || weapon.supportedattachments.size <= 0)
	{
		return;
	}
	supportedattachments = weapon.supportedattachments;
	var_a2fe3d54 = undefined;
	foreach(attachment in var_fe35755b.attachments)
	{
		if(!isdefined(attachment))
		{
			continue;
		}
		attachmenttype = attachment.var_6be1bec7;
		if(!isdefined(attachmenttype) || attachmenttype == "")
		{
			continue;
		}
		foreach(var_987851f5 in weapon.supportedattachments)
		{
			if(attachmenttype == var_987851f5)
			{
				var_a2fe3d54 = attachmenttype;
				break;
			}
		}
		if(isdefined(var_a2fe3d54))
		{
			break;
		}
	}
	if(!isdefined(var_a2fe3d54))
	{
		return;
	}
	if(isdefined(item.attachments) && !var_21055e1a)
	{
		foreach(attachment in item.attachments)
		{
			if(!isdefined(attachment))
			{
				continue;
			}
			if(attachment.var_4c342187 === var_a2fe3d54)
			{
				return;
			}
		}
	}
	foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock"))
	{
		if(!isdefined(var_fe35755b.(slot)))
		{
			continue;
		}
		if(var_fe35755b.(slot) && (!(isdefined(item.var_a6762160.(slot)) && item.var_a6762160.(slot))))
		{
			return;
		}
	}
	return var_a2fe3d54;
}

/*
	Name: function_dfaca25e
	Namespace: namespace_a0d533d1
	Checksum: 0x29698CF1
	Offset: 0xA90
	Size: 0x1E
	Parameters: 2
	Flags: Linked
*/
function function_dfaca25e(weaponid, var_259f58f3)
{
	return weaponid + var_259f58f3;
}

/*
	Name: function_837f4a57
	Namespace: namespace_a0d533d1
	Checksum: 0xD1B6285A
	Offset: 0xAB8
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function function_837f4a57(var_fe35755b)
{
	if(!isdefined(var_fe35755b) || var_fe35755b.itemtype != #"attachment")
	{
		return;
	}
	slots = array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock");
	offsets = array(1, 2, 3, 4, 5, 6);
	/#
		assert(slots.size == offsets.size);
	#/
	for(index = 0; index < offsets.size; index++)
	{
		slot = slots[index];
		if(!isdefined(var_fe35755b.(slot)))
		{
			continue;
		}
		return offsets[index];
	}
}

/*
	Name: function_d8cebda3
	Namespace: namespace_a0d533d1
	Checksum: 0x1DC16F0
	Offset: 0xC08
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_d8cebda3(var_a6762160)
{
	/#
		assert(isstruct(var_a6762160));
	#/
	mutators = 0;
	if(isdefined(var_a6762160))
	{
		var_b80d223d = array("doubleinventory", "double9mm", "double45cal", "double556mm", "double762mm", "double338cal", "double50cal", "double12gauge", "doublerocket", "doublesmallhealth", "doublemediumhealth", "doublelargehealth", "doublesquadhealth", "doublelethalgrenades", "doubletacticalgrenades", "doubleequipment", "doubleperk");
		for(index = 0; index < var_b80d223d.size; index++)
		{
			if(isdefined(var_a6762160.(var_b80d223d[index])) && var_a6762160.(var_b80d223d[index]))
			{
				mutators = mutators | 1 << index;
			}
		}
	}
	return mutators;
}

/*
	Name: function_2879cbe0
	Namespace: namespace_a0d533d1
	Checksum: 0xAD743D16
	Offset: 0xD70
	Size: 0x28E
	Parameters: 2
	Flags: Linked
*/
function function_2879cbe0(mutators, var_95162a97)
{
	/#
		assert(isint(mutators));
	#/
	/#
		assert(isweapon(var_95162a97));
	#/
	if(!isdefined(level.var_e2df03ad))
	{
		level.var_98c8f260 = [];
		var_13339abf = array(#"hash_182fdef2ad243e20", #"hash_212b01feaa916a00", #"hash_3bf6ed4e3a22e9f3", #"hash_1f72dec518451f8c", #"hash_3b5119f663e783b1", #"hash_7ebaa4e1e2f5d8a2", #"hash_46dd75a1a3f70780", #"hash_394e9478cf4f8d9d");
		var_c2043143 = array(2, 4, 8, 16, 32, 64, 128, 256);
		for(index = 0; index < var_13339abf.size; index++)
		{
			var_375298f3 = var_13339abf[index];
			var_f415ce36 = getscriptbundle(var_375298f3);
			weapon = var_f415ce36.weapon;
			/#
				assert(isdefined(weapon));
			#/
			if(!isdefined(weapon))
			{
				continue;
			}
			var_3160a910 = weapon.ammoindex;
			level.var_98c8f260[var_3160a910] = var_c2043143[index];
		}
	}
	maxammo = var_95162a97.maxammo;
	var_6f2df38a = level.var_98c8f260[var_95162a97.ammoindex];
	if(isdefined(var_6f2df38a) && mutators & var_6f2df38a)
	{
		maxammo = maxammo * 2;
	}
	return maxammo;
}

/*
	Name: function_cfa794ca
	Namespace: namespace_a0d533d1
	Checksum: 0xD94789BE
	Offset: 0x1008
	Size: 0x572
	Parameters: 2
	Flags: Linked
*/
function function_cfa794ca(mutators, var_a6762160)
{
	/#
		assert(isdefined(var_a6762160));
	#/
	weapon = namespace_ad5a0cd6::function_35e06774(var_a6762160);
	if(isdefined(weapon))
	{
		if(weapon.name == #"eq_tripwire")
		{
			if(mutators & 32768)
			{
				return 8;
			}
			return 4;
		}
		if(var_a6762160.itemtype == #"health")
		{
			var_9b624be0 = array(#"hash_1abfcce0e9955057", #"hash_ff50c93155e445f", #"hash_80292d121740f6f", #"hash_45ced3880667df22");
			var_448bc079 = array(512, 1024, 2048, 4096);
			for(index = 0; index < var_9b624be0.size; index++)
			{
				if(var_a6762160.name != var_9b624be0[index])
				{
					continue;
				}
				if(mutators & var_448bc079[index])
				{
					return (isdefined(var_a6762160.stackcount) ? var_a6762160.stackcount : 1) * 2;
				}
			}
		}
		else if(var_a6762160.itemtype == #"equipment")
		{
			var_3e9ef0a1 = array(array(#"hash_53a2516ec1d3a096", #"hash_3074c41bb205ed8c", #"hash_2b5027622c0b6d07", #"hash_4cec712579f1202f", #"hash_57504010ce1814dc", #"hash_5752a7e130ea202a", #"hash_4edf613e9b9032da", #"hash_28da32d9304b6296", #"hash_4a2739676c12d92a", #"hash_140318e970e711ce", #"hash_50b970644e43947b"), array(#"hash_627144159973c325", #"hash_1a7edb90a484158b", #"hash_745d80b3e4f28da1", #"hash_56e573d15c6402bc", #"hash_213093d947c30be6", #"hash_7e8c84081fafaea4"), array(#"hash_665eccfe5d58f636", #"hash_68b64725de40edae", #"hash_2b06a3f530395182", #"hash_16a1f841da0b877d", #"hash_1242946e889704c7", #"hash_14b578e446580ad5", #"hash_300914db9caf4033", #"hash_3a3d830a9a4559d4", #"hash_743b859c2367ff54", #"hash_5e5f2ed57ac4601f", #"hash_105f32560e2fb0fe", #"hash_18056dab055a44c9", #"hash_2e8b13391f6544", #"hash_735d22a674b7f8c0", #"hash_7f877a112c8c4187", #"hash_7aca06dcd83beef3"));
			var_24e18bcb = array(8192, 16384, 32768);
			for(var_25c45152 = 0; var_25c45152 < var_3e9ef0a1.size; var_25c45152++)
			{
				if(!mutators & var_24e18bcb[var_25c45152])
				{
					continue;
				}
				var_3e45b393 = var_3e9ef0a1[var_25c45152];
				for(index = 0; index < var_3e45b393.size; index++)
				{
					if(var_a6762160.name != var_3e45b393[index])
					{
						continue;
					}
					return (isdefined(var_a6762160.stackcount) ? var_a6762160.stackcount : 1) * 2;
				}
			}
		}
		return (isdefined(var_a6762160.stackcount) ? var_a6762160.stackcount : 1);
	}
	return (isdefined(var_a6762160.stackcount) ? var_a6762160.stackcount : 1);
}

/*
	Name: function_4bd83c04
	Namespace: namespace_a0d533d1
	Checksum: 0xED41F040
	Offset: 0x1588
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_4bd83c04(item)
{
	/#
		assert(isdefined(item));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return 0;
	}
	foreach(slot in array("attachSlotOptics", "attachSlotBarrel", "attachSlotRail", "attachSlotMagazine", "attachSlotBody", "attachSlotStock"))
	{
		if(isdefined(item.var_a6762160.(slot)) && item.var_a6762160.(slot))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_169cea63
	Namespace: namespace_a0d533d1
	Checksum: 0xF786B301
	Offset: 0x16B8
	Size: 0x1A6
	Parameters: 0
	Flags: Linked
*/
function function_169cea63()
{
	/#
		assert(isplayer(self));
	#/
	if(!(isdefined(getgametypesetting(#"hash_7c8ad12994670d63")) ? getgametypesetting(#"hash_7c8ad12994670d63") : 0))
	{
		return array();
	}
	if(!isplayer(self))
	{
		return array();
	}
	var_bcb39afb = self function_cf9658ca();
	var_a448692e = [];
	var_bc8a634e = associativearray(#"ar_galil_t8", 1);
	foreach(weaponname in var_bcb39afb)
	{
		if(isdefined(var_bc8a634e[weaponname]))
		{
			continue;
		}
		var_a448692e[var_a448692e.size] = weaponname;
	}
	return var_a448692e;
}

/*
	Name: function_70b12595
	Namespace: namespace_a0d533d1
	Checksum: 0xA440227C
	Offset: 0x1868
	Size: 0x1D0
	Parameters: 1
	Flags: Linked
*/
function function_70b12595(item)
{
	/#
		assert(isdefined(item));
	#/
	/#
		assert(isdefined(item.var_a6762160));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return 0;
	}
	if(!isdefined(item.attachments) || !isdefined(item.var_a6762160.attachments))
	{
		return 1;
	}
	if(item.attachments.size < item.var_a6762160.attachments.size)
	{
		var_8697fbe7 = 0;
		foreach(attachment in item.var_a6762160.attachments)
		{
			var_fe35755b = getscriptbundle(attachment.var_6be1bec7);
			if(!isdefined(var_fe35755b) || var_fe35755b.type != #"hash_10587321f369e7f3" || !isarray(var_fe35755b.attachments))
			{
				continue;
			}
			var_8697fbe7++;
		}
		return item.attachments.size >= var_8697fbe7;
	}
	return 1;
}

/*
	Name: function_ee669356
	Namespace: namespace_a0d533d1
	Checksum: 0x24471399
	Offset: 0x1A40
	Size: 0x25A
	Parameters: 1
	Flags: Linked
*/
function function_ee669356(item)
{
	/#
		assert(isdefined(item));
	#/
	/#
		assert(isdefined(item.var_a6762160));
	#/
	if(!isdefined(item) || !isdefined(item.var_a6762160))
	{
		return 0;
	}
	if(!isdefined(item.attachments) || !isdefined(item.var_a6762160.attachments))
	{
		return 1;
	}
	foreach(attachment in item.var_a6762160.attachments)
	{
		if(!namespace_ad5a0cd6::function_7363384a(attachment.var_6be1bec7))
		{
			continue;
		}
		var_84704ed7 = function_4ba8fde(attachment.var_6be1bec7);
		if(!isdefined(var_84704ed7) || !isdefined(var_84704ed7.var_a6762160))
		{
			return 0;
		}
		if(!isdefined(item.attachments) || item.attachments.size <= 0)
		{
			return 0;
		}
		hasattachment = 0;
		foreach(var_d7172da7 in item.attachments)
		{
			if(function_73593286(var_d7172da7.var_a6762160, var_84704ed7.var_a6762160))
			{
				hasattachment = 1;
				break;
			}
		}
		if(!hasattachment)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_b6a27222
	Namespace: namespace_a0d533d1
	Checksum: 0x50486E20
	Offset: 0x1CA8
	Size: 0x14C
	Parameters: 1
	Flags: None
*/
function function_b6a27222(slotid)
{
	/#
		assert(isdefined(slotid));
	#/
	foreach(weaponslot in array(16 + 1, 16 + 1 + 6 + 1))
	{
		foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
		{
			if(slotid == weaponslot + var_259f58f3)
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_73593286
	Namespace: namespace_a0d533d1
	Checksum: 0x91E541C0
	Offset: 0x1E00
	Size: 0xA8
	Parameters: 2
	Flags: Linked
*/
function function_73593286(var_2ff7916e, var_21b4f4e9)
{
	if(!isdefined(var_2ff7916e) || !isdefined(var_21b4f4e9))
	{
		return 0;
	}
	var_f9adb977 = (isdefined(var_2ff7916e.parentname) ? var_2ff7916e.parentname : var_2ff7916e.name);
	var_a3508cbe = (isdefined(var_21b4f4e9.parentname) ? var_21b4f4e9.parentname : var_21b4f4e9.name);
	return var_f9adb977 == var_a3508cbe;
}

/*
	Name: function_398b9770
	Namespace: namespace_a0d533d1
	Checksum: 0x2CB2FE4F
	Offset: 0x1EB0
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_398b9770(var_4838b749, var_f9f8c0b5)
{
	/#
		assert(isdefined(var_4838b749));
	#/
	/#
		assert(isdefined(var_f9f8c0b5));
	#/
	foreach(var_259f58f3 in array(1, 2, 3, 4, 5, 6))
	{
		if(var_f9f8c0b5 == var_4838b749 + var_259f58f3)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_31a0b1ef
	Namespace: namespace_a0d533d1
	Checksum: 0xC610AC63
	Offset: 0x1F98
	Size: 0x218
	Parameters: 3
	Flags: Linked
*/
function function_31a0b1ef(item, var_84704ed7, var_41a74919 = 1)
{
	/#
		assert(isstruct(item));
	#/
	/#
		assert(isstruct(var_84704ed7));
	#/
	if(!isdefined(item) || !isdefined(item.attachments) || item.attachments.size <= 0 || !isdefined(item.var_a6762160) || item.var_a6762160.itemtype != #"weapon")
	{
		return 0;
	}
	if(!isdefined(var_84704ed7) || !isdefined(var_84704ed7.var_a6762160) || var_84704ed7.var_a6762160.itemtype != #"attachment")
	{
		return 0;
	}
	var_2496b555 = 0;
	for(index = 0; index < item.attachments.size; index++)
	{
		attachment = item.attachments[index];
		if(isdefined(attachment) && attachment.var_bd027dd9 === var_84704ed7.var_bd027dd9)
		{
			var_2496b555 = 1;
			arrayremoveindex(item.attachments, index, 0);
			break;
		}
	}
	if(var_2496b555 && var_41a74919)
	{
		function_6e9e7169(item);
	}
	return var_2496b555;
}

/*
	Name: function_6e9e7169
	Namespace: namespace_a0d533d1
	Checksum: 0xC2E7F9E5
	Offset: 0x21B8
	Size: 0x18E
	Parameters: 1
	Flags: Linked
*/
function function_6e9e7169(item)
{
	/#
		assert(isdefined(item));
	#/
	weapon = namespace_ad5a0cd6::function_35e06774(item.var_a6762160);
	if(!isdefined(weapon))
	{
		return;
	}
	attachments = weapon.attachments;
	if(isdefined(item.attachments))
	{
		foreach(attachment in item.attachments)
		{
			if(isdefined(attachment))
			{
				attachments[attachments.size] = attachment.var_4c342187;
			}
		}
	}
	if(isdefined(item.var_42caf41a) && item.var_42caf41a)
	{
		attachments[attachments.size] = "null";
	}
	else
	{
		attachments[attachments.size] = "custom2";
	}
	weapon = getweapon(weapon.name, attachments);
	weapon = function_1242e467(weapon);
	item.var_627c698b = weapon;
}

/*
	Name: function_2b83d3ff
	Namespace: namespace_a0d533d1
	Checksum: 0x2F37DE63
	Offset: 0x2350
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function function_2b83d3ff(item)
{
	/#
		assert(isdefined(item));
	#/
	if(!isdefined(item))
	{
		return undefined;
	}
	if(isdefined(item.var_627c698b))
	{
		return item.var_627c698b;
	}
	var_48cfb6ca = 0;
	if(!isdefined(item.attachments) && isdefined(item.var_a6762160) && isdefined(item.var_a6762160.attachments))
	{
		var_48cfb6ca = 1;
	}
	return namespace_ad5a0cd6::function_35e06774(item.var_a6762160, var_48cfb6ca);
}

