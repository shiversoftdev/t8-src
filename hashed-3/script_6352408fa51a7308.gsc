// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_44257f94fbb49121;
#using script_5da9076b8e4f6d28;
#using script_68264f587357ea51;
#using script_c1eebdc8cad5d78;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace item_drop;

/*
	Name: function_89f2df9
	Namespace: item_drop
	Checksum: 0xFCC7187E
	Offset: 0x118
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
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
	level.var_a4a4012e = [];
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
private function function_b8f6e02f()
{
	while(true)
	{
		item_world::function_1b11e73c();
		reset = isdefined(level flagsys::get(#"hash_38a387462f3a9ad")) && level flagsys::get(#"hash_38a387462f3a9ad");
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
private function function_67189b6b(localclientnum, newval)
{
	var_be90d3da = newval & 4 != 0;
	newval = newval & -5;
	if(newval == 0)
	{
		if(isdefined(self) && isdefined(self.var_bd027dd9) && isdefined(level.var_a4a4012e[self.var_bd027dd9]))
		{
			arrayremoveindex(level.var_a4a4012e, self.var_bd027dd9, 1);
		}
		if(isdefined(self) && isdefined(self.var_bd027dd9) && isdefined(level.var_5b2a8d88[self.var_bd027dd9]))
		{
			level.var_5b2a8d88[self.var_bd027dd9] = 0;
		}
	}
	else if(newval == 1)
	{
		/#
			assert(self.id < 1024);
		#/
		if(self.id >= 1024)
		{
			return;
		}
		self.var_bd027dd9 = namespace_ad5a0cd6::function_1f0def85(self);
		self.var_8e092725 = 0;
		if(var_be90d3da)
		{
			self.var_8e092725 = -1;
		}
		if(self.id != 32767 && self.id < function_8322cf16())
		{
			self.var_a6762160 = function_b1702735(self.id).var_a6762160;
			self function_1fe1281(localclientnum, clientfield::get("dynamic_item_drop_count"));
			if(self.var_a6762160.name == #"hash_43aca7fcfd3e5949" && isdefined(level.var_5b2a8d88))
			{
				level.var_5b2a8d88[self.var_bd027dd9] = 1;
			}
		}
		arrayremovevalue(level.var_a4a4012e, undefined, 1);
		level.var_a4a4012e[self.var_bd027dd9] = self;
		item_world::function_b78a9820(localclientnum);
		player = function_5c10bd79(localclientnum);
		if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= 1350 * 1350)
		{
			player.var_506495f9 = 1;
		}
		namespace_b376ff3f::function_b1136fc8(localclientnum, self);
		player item_world::show_item(localclientnum, self.var_bd027dd9, !var_be90d3da);
	}
	else if(newval == 2)
	{
		self.var_8e092725 = gettime();
		self.var_bd027dd9 = namespace_ad5a0cd6::function_1f0def85(self);
		namespace_b376ff3f::function_31868137(localclientnum, self);
		item_world::function_b78a9820(localclientnum);
		item_world::function_2990e5f(localclientnum, self);
		if(isdefined(self.var_bd027dd9) && getdvarint(#"hash_99bb0233e482c77", 0))
		{
			level.var_a4a4012e[self.var_bd027dd9] = undefined;
		}
		player = function_5c10bd79(localclientnum);
		player item_world::function_222205a3(localclientnum, self.var_bd027dd9);
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
private function function_1a45bc2a(item)
{
	if(!isdefined(item))
	{
		return 0;
	}
	if(!isdefined(item.type) || (item.type != #"scriptmover" && item.type != #"missile"))
	{
		return 0;
	}
	return 1;
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
			namespace_b376ff3f::function_31868137(localclientnum, self);
		}
		self.amount = newval;
		self.count = 1;
	}
	else if(isdefined(self.count) && newval !== self.count)
	{
		namespace_b376ff3f::function_31868137(localclientnum, self);
	}
	self.amount = 0;
	self.count = newval;
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
	if(isplayer(player) && distance2dsquared(self.origin, player.origin) <= 1350 * 1350)
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
		self.var_ed175c5 = 0;
	}
	else if(newval == 1)
	{
		self.var_ed175c5 = 1;
	}
	else if(newval == 2)
	{
		self.var_ed175c5 = 2;
	}
}

