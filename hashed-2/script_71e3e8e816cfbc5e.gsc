// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3affe3aaa3f22cb0;
#using script_3f65948f90646f7c;
#using script_8210b63db522f15;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace namespace_23f4aa8f;

/*
	Name: function_89f2df9
	Namespace: namespace_23f4aa8f
	Checksum: 0xD33B04A3
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_19b159b284b5bcb4", &__init__, undefined, #"hash_3c913111830b7769");
}

/*
	Name: __init__
	Namespace: namespace_23f4aa8f
	Checksum: 0xBAE04BDE
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	namespace_fa6b9ef8::function_90ee7a97(#"hash_12e67eb801ba2fd0", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: namespace_23f4aa8f
	Checksum: 0x2DC6BE34
	Offset: 0x120
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
		callback::add_callback(#"hash_4d3e34c3c8f8bb2a", &function_155ab49c);
		callback::function_955a779c(&function_955a779c);
		item_drop::function_f3f9788a(#"hash_6677ee7663182fb8", 0.35);
	}
}

/*
	Name: function_1c4b5097
	Namespace: namespace_23f4aa8f
	Checksum: 0xAF5F3103
	Offset: 0x1E8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"hash_6677ee7663182fb8")
	{
		var_b6015a5d = self function_b854ffba();
		if(var_b6015a5d >= 3 && self character_unlock::function_f0406288(#"hash_12e67eb801ba2fd0"))
		{
			self character_unlock::function_c8beca5e(#"hash_12e67eb801ba2fd0", #"hash_6e5a10ffa958d875", 1);
		}
	}
}

/*
	Name: function_155ab49c
	Namespace: namespace_23f4aa8f
	Checksum: 0x666A84FA
	Offset: 0x2C0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_155ab49c(params)
{
	if(!isplayer(self))
	{
		return;
	}
	var_a6762160 = params.item.var_a6762160;
	var_4961f577 = params.item.var_4961f577;
	if(isdefined(var_4961f577) && var_4961f577)
	{
		return;
	}
	if(isdefined(var_a6762160) && var_a6762160.name === #"hash_6677ee7663182fb8")
	{
		var_b6015a5d = self function_b854ffba();
		if(var_b6015a5d < 3 && self character_unlock::function_c70bcc7a(#"hash_12e67eb801ba2fd0"))
		{
			self character_unlock::function_c8beca5e(#"hash_12e67eb801ba2fd0", #"hash_6e5a10ffa958d875", 0);
		}
	}
}

/*
	Name: function_955a779c
	Namespace: namespace_23f4aa8f
	Checksum: 0xDF581E33
	Offset: 0x3F0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_955a779c(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"hash_6677ee7663182fb8")
	{
		if(self character_unlock::function_c70bcc7a(#"hash_12e67eb801ba2fd0"))
		{
			var_b6015a5d = self function_b854ffba();
			if(var_b6015a5d < 3)
			{
				self character_unlock::function_c8beca5e(#"hash_12e67eb801ba2fd0", #"hash_6e5a10ffa958d875", 0);
			}
		}
	}
}

/*
	Name: function_b854ffba
	Namespace: namespace_23f4aa8f
	Checksum: 0x547D726C
	Offset: 0x4D0
	Size: 0xF8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b854ffba()
{
	var_b6015a5d = 0;
	if(isdefined(self.inventory) && isdefined(self.inventory.items))
	{
		foreach(item in self.inventory.items)
		{
			var_a6762160 = item.var_a6762160;
			if(isdefined(var_a6762160) && var_a6762160.name === #"hash_6677ee7663182fb8")
			{
				var_b6015a5d = var_b6015a5d + item.count;
			}
		}
	}
	return var_b6015a5d;
}

