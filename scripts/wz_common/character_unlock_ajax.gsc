// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.gsc;
#using scripts\wz_common\character_unlock.gsc;
#using scripts\mp_common\item_drop.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace character_unlock_ajax;

/*
	Name: __init__system__
	Namespace: character_unlock_ajax
	Checksum: 0xD33B04A3
	Offset: 0x90
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_ajax", &__init__, undefined, #"character_unlock_ajax_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_ajax
	Checksum: 0xBAE04BDE
	Offset: 0xE0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	character_unlock_fixup::function_90ee7a97(#"ajax_unlock", &function_2613aeec);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_ajax
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
		callback::add_callback(#"on_drop_item", &on_drop_item);
		callback::on_item_use(&on_item_use);
		item_drop::function_f3f9788a(#"cu01_item", 0.35);
	}
}

/*
	Name: function_1c4b5097
	Namespace: character_unlock_ajax
	Checksum: 0xAF5F3103
	Offset: 0x1E8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_1c4b5097(item)
{
	var_a6762160 = item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"cu01_item")
	{
		var_b6015a5d = self function_b854ffba();
		if(var_b6015a5d >= 3 && self character_unlock::function_f0406288(#"ajax_unlock"))
		{
			self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 1);
		}
	}
}

/*
	Name: on_drop_item
	Namespace: character_unlock_ajax
	Checksum: 0x666A84FA
	Offset: 0x2C0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function on_drop_item(params)
{
	if(!isplayer(self))
	{
		return;
	}
	var_a6762160 = params.item.var_a6762160;
	deathstash = params.item.deathstash;
	if(isdefined(deathstash) && deathstash)
	{
		return;
	}
	if(isdefined(var_a6762160) && var_a6762160.name === #"cu01_item")
	{
		var_b6015a5d = self function_b854ffba();
		if(var_b6015a5d < 3 && self character_unlock::function_c70bcc7a(#"ajax_unlock"))
		{
			self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 0);
		}
	}
}

/*
	Name: on_item_use
	Namespace: character_unlock_ajax
	Checksum: 0xDF581E33
	Offset: 0x3F0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function on_item_use(params)
{
	var_a6762160 = params.item.var_a6762160;
	if(isdefined(var_a6762160) && var_a6762160.name === #"cu01_item")
	{
		if(self character_unlock::function_c70bcc7a(#"ajax_unlock"))
		{
			var_b6015a5d = self function_b854ffba();
			if(var_b6015a5d < 3)
			{
				self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 0);
			}
		}
	}
}

/*
	Name: function_b854ffba
	Namespace: character_unlock_ajax
	Checksum: 0x547D726C
	Offset: 0x4D0
	Size: 0xF8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b854ffba()
{
	var_b6015a5d = 0;
	if(isdefined(self.inventory) && isdefined(self.inventory.items))
	{
		foreach(item in self.inventory.items)
		{
			var_a6762160 = item.var_a6762160;
			if(isdefined(var_a6762160) && var_a6762160.name === #"cu01_item")
			{
				var_b6015a5d = var_b6015a5d + item.count;
			}
		}
	}
	return var_b6015a5d;
}

