// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_50a49d535160be60;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;

#namespace zm_equipment;

/*
	Name: __init__system__
	Namespace: zm_equipment
	Checksum: 0xE4216230
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_equipment", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_equipment
	Checksum: 0x8D440130
	Offset: 0x118
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._equip_activated_callbacks = [];
	level.buildable_piece_count = 24;
	if(!(isdefined(level._no_equipment_activated_clientfield) && level._no_equipment_activated_clientfield))
	{
		clientfield::register("scriptmover", "equipment_activated", 1, 4, "int", &equipment_activated_clientfield_cb, 1, 0);
	}
	zm_hint_text::register("zm_hint_text");
}

/*
	Name: add_equip_activated_callback_override
	Namespace: zm_equipment
	Checksum: 0xDEF7E63A
	Offset: 0x1C0
	Size: 0x2A
	Parameters: 2
	Flags: None
*/
function add_equip_activated_callback_override(model, func)
{
	level._equip_activated_callbacks[model] = func;
}

/*
	Name: equipment_activated_clientfield_cb
	Namespace: zm_equipment
	Checksum: 0x89A5B2A0
	Offset: 0x1F8
	Size: 0x132
	Parameters: 7
	Flags: Linked
*/
function equipment_activated_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.model) && isdefined(level._equip_activated_callbacks[self.model]))
	{
		[[level._equip_activated_callbacks[self.model]]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
	if(!newval)
	{
		if(isdefined(self._equipment_activated_fx))
		{
			for(i = 0; i < self._equipment_activated_fx.size; i++)
			{
				for(j = 0; j < self._equipment_activated_fx[i].size; j++)
				{
					deletefx(i, self._equipment_activated_fx[i][j]);
				}
			}
			self._equipment_activated_fx = undefined;
		}
	}
}

/*
	Name: play_fx_for_all_clients
	Namespace: zm_equipment
	Checksum: 0x6E173493
	Offset: 0x338
	Size: 0x27E
	Parameters: 4
	Flags: None
*/
function play_fx_for_all_clients(fx, tag, storehandles = 0, forward = undefined)
{
	numlocalplayers = getlocalplayers().size;
	if(!isdefined(self._equipment_activated_fx))
	{
		self._equipment_activated_fx = [];
		for(i = 0; i < numlocalplayers; i++)
		{
			self._equipment_activated_fx[i] = [];
		}
	}
	if(isdefined(tag))
	{
		for(i = 0; i < numlocalplayers; i++)
		{
			if(storehandles)
			{
				self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = util::playfxontag(i, fx, self, tag);
				continue;
			}
			self_for_client = getentbynum(i, self getentitynumber());
			if(isdefined(self_for_client))
			{
				util::playfxontag(i, fx, self_for_client, tag);
			}
		}
	}
	else
	{
		for(i = 0; i < numlocalplayers; i++)
		{
			if(storehandles)
			{
				if(isdefined(forward))
				{
					self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin, forward);
				}
				else
				{
					self._equipment_activated_fx[i][self._equipment_activated_fx[i].size] = playfx(i, fx, self.origin);
				}
				continue;
			}
			if(isdefined(forward))
			{
				playfx(i, fx, self.origin, forward);
				continue;
			}
			playfx(i, fx, self.origin);
		}
	}
}

/*
	Name: is_included
	Namespace: zm_equipment
	Checksum: 0x52AB8976
	Offset: 0x5C0
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function is_included(equipment)
{
	if(!isdefined(level._included_equipment))
	{
		return 0;
	}
	return isdefined(level._included_equipment[equipment.rootweapon]);
}

/*
	Name: include
	Namespace: zm_equipment
	Checksum: 0xA269B15A
	Offset: 0x600
	Size: 0x5E
	Parameters: 1
	Flags: None
*/
function include(equipment_name)
{
	if(!isdefined(level._included_equipment))
	{
		level._included_equipment = [];
	}
	equipment = getweapon(equipment_name);
	level._included_equipment[equipment] = equipment;
}

