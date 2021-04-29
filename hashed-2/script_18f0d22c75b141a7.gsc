// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace loadout;

/*
	Name: function_87bcb1b
	Namespace: loadout
	Checksum: 0x91265C61
	Offset: 0xC0
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function function_87bcb1b()
{
	if(isdefined(level.var_87bcb1b) && level.var_87bcb1b == 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_c67222df
	Namespace: loadout
	Checksum: 0xC7F26FE4
	Offset: 0xF8
	Size: 0x10C
	Parameters: 0
	Flags: None
*/
function function_c67222df()
{
	if(!isdefined(self.pers[#"loadout"]))
	{
		self.pers[#"loadout"] = spawnstruct();
	}
	self function_8b7ebf9("primary");
	self function_8b7ebf9("secondary");
	self function_8b7ebf9("herogadget");
	self function_8b7ebf9("ultimate");
	self function_8b7ebf9("primarygrenade");
	self function_8b7ebf9("specialgrenade");
}

/*
	Name: function_8b7ebf9
	Namespace: loadout
	Checksum: 0x5BD37F3B
	Offset: 0x210
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_8b7ebf9(slot_index)
{
	self.pers[#"loadout"].slots[slot_index] = {#killed:0, #count:0, #hash_4cfdfa9b:level.weaponnone, #weapon:level.weaponnone, #slot:slot_index};
}

/*
	Name: function_e27dc453
	Namespace: loadout
	Checksum: 0xA6E3DE2B
	Offset: 0x2B0
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function function_e27dc453(slot_index)
{
	if(isdefined(self.pers[#"loadout"]))
	{
		return self.pers[#"loadout"].slots[slot_index];
	}
	return undefined;
}

/*
	Name: function_8435f729
	Namespace: loadout
	Checksum: 0xBC318DCE
	Offset: 0x308
	Size: 0xA0
	Parameters: 1
	Flags: None
*/
function function_8435f729(weapon)
{
	foreach(slot, slot_index in self.pers[#"loadout"].slots)
	{
		if(slot.weapon == weapon)
		{
			return slot_index;
		}
	}
	return undefined;
}

/*
	Name: function_1ee886f7
	Namespace: loadout
	Checksum: 0x89E54DF2
	Offset: 0x3B0
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_1ee886f7(weapon)
{
	if(isdefined(self.pers[#"loadout"]))
	{
		foreach(slot in self.pers[#"loadout"].slots)
		{
			if(slot.weapon == weapon)
			{
				return slot;
			}
		}
	}
	return undefined;
}

/*
	Name: function_18a77b37
	Namespace: loadout
	Checksum: 0x8CC3078A
	Offset: 0x478
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_18a77b37(slot_index)
{
	if(function_87bcb1b() && isdefined(self) && isdefined(self.pers) && isdefined(self.pers[#"loadout"]))
	{
		/#
			assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
		#/
		return self.pers[#"loadout"].slots[slot_index].weapon;
	}
	return undefined;
}

/*
	Name: function_442539
	Namespace: loadout
	Checksum: 0x88AFCE81
	Offset: 0x538
	Size: 0xBE
	Parameters: 2
	Flags: None
*/
function function_442539(slot_index, weapon)
{
	/#
		assert(isdefined(self.pers[#"loadout"].slots[slot_index]));
	#/
	/#
		assert(isplayer(self));
	#/
	/#
		assert(isdefined(weapon));
	#/
	self.pers[#"loadout"].slots[slot_index].weapon = weapon;
}

/*
	Name: gadget_is_in_use
	Namespace: loadout
	Checksum: 0x920F1391
	Offset: 0x600
	Size: 0x8A
	Parameters: 1
	Flags: None
*/
function gadget_is_in_use(slot_index)
{
	player = self;
	weapon = function_18a77b37(slot_index);
	if(!isdefined(weapon))
	{
		return 0;
	}
	slot = player gadgetgetslot(weapon);
	active = player util::gadget_is_in_use(slot);
	return active;
}

