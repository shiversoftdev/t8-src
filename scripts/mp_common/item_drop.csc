// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\item_world_util.csc;
#using scripts\mp_common\item_world.csc;
#using script_c1eebdc8cad5d78;
#using scripts\mp_common\item_inventory.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\clientfield_shared.csc;

#namespace item_drop;

/*
	Name: __init__system__
	Namespace: item_drop
	Checksum: 0xFCC7187E
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"item_drop", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: item_drop
	Checksum: 0x89C75BC4
	Offset: 0x160
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getgametypesetting(#"useitemspawns") == 0)
	{
		return;
	}
	clientfield::register("missile", "dynamic_item_drop", 1, 2, "int", &function_a517a859, 0, 0);
	clientfield::register("missile", "dynamic_item_drop_count", 11000, 10, "int", &function_fd47982d, 0, 0);
	clientfield::register("scriptmover", "dynamic_item_drop", 1, 2, "int", &function_a517a859, 0, 0);
	clientfield::register("scriptmover", "dynamic_item_drop_count", 11000, 10, "int", &function_fd47982d, 0, 0);
	clientfield::register("missile", "dynamic_item_drop", 10000, 3, "int", &function_a517a859, 0, 0);
	clientfield::register("scriptmover", "dynamic_item_drop", 10000, 3, "int", &function_a517a859, 0, 0);
	clientfield::register("scriptmover", "dynamic_stash", 1, 2, "int", &function_e7bb925a, 0, 0);
	clientfield::register("scriptmover", "dynamic_stash_type", 1, 2, "int", &function_63226f88, 0, 0);
	level.item_spawn_drops = [];
	level.var_624588d5 = [];
	level.var_d49a1a10 = [];
	level thread function_b8f6e02f();
}

/*
	Name: function_b8f6e02f
	Namespace: item_drop
	Checksum: 0xEA29315E
	Offset: 0x418
	Size: 0x16C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b8f6e02f()
{
	while(true)
	{
		item_world::function_1b11e73c();
		reset = isdefined(level flagsys::get(#"item_world_reset")) && level flagsys::get(#"item_world_reset");
		var_d68d9a4d = level.var_d49a1a10.size;
		for(index = 0; index < var_d68d9a4d; index++)
		{
			var_5c6af5cf = level.var_d49a1a10[index];
			level.var_d49a1a10[index] = undefined;
			if(!isdefined(var_5c6af5cf) || !isdefined(var_5c6af5cf.item))
			{
				continue;
			}
			if(var_5c6af5cf.reset !== reset)
			{
				continue;
			}
			var_5c6af5cf.item function_67189b6b(var_5c6af5cf.localclientnum, var_5c6af5cf.newval);
		}
		level.var_d49a1a10 = [];
		if(reset)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_67189b6b
	Namespace: item_drop
	Checksum: 0x4746C92A
	Offset: 0x590
	Size: 0x454
	Parameters: 2
	Flags: Linked, Private
*/
function private function_67189b6b(localclientnum, newval)
{
	stashitem = (newval & 4) != 0;
	newval = newval & -5;
	if(newval == 0)
	{
		if(isdefined(self) && isdefined(self.var_bd027dd9) && isdefined(level.item_spawn_drops[self.var_bd027dd9]))
		{
			arrayremoveindex(level.item_spawn_drops, self.var_bd027dd9, 1);
		}
		if(isdefined(self) && isdefined(self.var_bd027dd9) && isdefined(level.var_5b2a8d88[self.var_bd027dd9]))
		{
			level.var_5b2a8d88[self.var_bd027dd9] = 0;
		}
	}
	else
	{
		if(newval == 1)
		{
			/#
				assert(self.id < 1024);
			#/
			if(self.id >= 1024)
			{
				return;
			}
			self.var_bd027dd9 = item_world_util::function_1f0def85(self);
			self.hidetime = 0;
			if(stashitem)
			{
				self.hidetime = -1;
			}
			if(self.id != 32767 && self.id < function_8322cf16())
			{
				self.var_a6762160 = function_b1702735(self.id).var_a6762160;
				self function_1fe1281(localclientnum, clientfield::get("dynamic_item_drop_count"));
				if(self.var_a6762160.name == #"sig_blade_wz_item" && isdefined(level.var_5b2a8d88))
				{
					level.var_5b2a8d88[self.var_bd027dd9] = 1;
				}
			}
			arrayremovevalue(level.item_spawn_drops, undefined, 1);
			level.item_spawn_drops[self.var_bd027dd9] = self;
			item_world::function_b78a9820(localclientnum);
			player = function_5c10bd79(localclientnum);
			if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= (1350 * 1350))
			{
				player.var_506495f9 = 1;
			}
			item_inventory::function_b1136fc8(localclientnum, self);
			player item_world::show_item(localclientnum, self.var_bd027dd9, !stashitem);
		}
		else if(newval == 2)
		{
			self.hidetime = gettime();
			self.var_bd027dd9 = item_world_util::function_1f0def85(self);
			item_inventory::function_31868137(localclientnum, self);
			item_world::function_b78a9820(localclientnum);
			item_world::function_2990e5f(localclientnum, self);
			if(isdefined(self.var_bd027dd9) && getdvarint(#"hash_99bb0233e482c77", 0))
			{
				level.item_spawn_drops[self.var_bd027dd9] = undefined;
			}
			player = function_5c10bd79(localclientnum);
			player item_world::hide_item(localclientnum, self.var_bd027dd9);
		}
	}
}

/*
	Name: function_1a45bc2a
	Namespace: item_drop
	Checksum: 0x72E7C542
	Offset: 0x9F0
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1a45bc2a(item)
{
	if(!isdefined(item))
	{
		return false;
	}
	if(!isdefined(item.type) || (item.type != #"scriptmover" && item.type != #"missile"))
	{
		return false;
	}
	return true;
}

/*
	Name: function_fd47982d
	Namespace: item_drop
	Checksum: 0xF26696C7
	Offset: 0xA70
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_fd47982d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.id) || !isdefined(self.var_a6762160))
	{
		return;
	}
	self function_1fe1281(localclientnum, newval);
}

/*
	Name: function_1fe1281
	Namespace: item_drop
	Checksum: 0xFBFAC326
	Offset: 0xAF8
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function function_1fe1281(localclientnum, newval)
{
	if(!isdefined(self))
	{
		return;
	}
	/#
		assert(isdefined(self.id));
	#/
	/#
		assert(isdefined(self.var_a6762160));
	#/
	if(!isdefined(self.id) || !isdefined(self.var_a6762160))
	{
		return;
	}
	if(self.var_a6762160.itemtype === #"ammo" || self.var_a6762160.itemtype === #"armor" || self.var_a6762160.itemtype === #"weapon")
	{
		if(isdefined(self.amount) && newval !== self.amount)
		{
			item_inventory::function_31868137(localclientnum, self);
		}
		self.amount = newval;
		self.count = 1;
	}
	else
	{
		if(isdefined(self.count) && newval !== self.count)
		{
			item_inventory::function_31868137(localclientnum, self);
		}
		self.amount = 0;
		self.count = newval;
	}
	item_world::function_b78a9820(localclientnum);
}

/*
	Name: function_a517a859
	Namespace: item_drop
	Checksum: 0xC59D4C0E
	Offset: 0xCA8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function function_a517a859(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self.id = self getitemindex();
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	if(!function_1a45bc2a(self))
	{
		return;
	}
	self function_67189b6b(localclientnum, newval);
}

/*
	Name: function_e7bb925a
	Namespace: item_drop
	Checksum: 0x2415CC8B
	Offset: 0xD68
	Size: 0x144
	Parameters: 7
	Flags: Linked
*/
function function_e7bb925a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	if(newval == 1)
	{
		self.var_bad13452 = 0;
	}
	else if(newval == 2)
	{
		self.var_bad13452 = 2;
	}
	level.var_624588d5[level.var_624588d5.size] = self;
	player = function_5c10bd79(localclientnum);
	if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= (1350 * 1350))
	{
		item_world::function_a4886b1e(localclientnum, undefined, self);
	}
}

/*
	Name: function_63226f88
	Namespace: item_drop
	Checksum: 0x7EB44006
	Offset: 0xEB8
	Size: 0xBE
	Parameters: 7
	Flags: Linked
*/
function function_63226f88(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!item_world::function_1b11e73c())
	{
		return;
	}
	if(newval == 0)
	{
		self.stash_type = 0;
	}
	else
	{
		if(newval == 1)
		{
			self.stash_type = 1;
		}
		else if(newval == 2)
		{
			self.stash_type = 2;
		}
	}
}

