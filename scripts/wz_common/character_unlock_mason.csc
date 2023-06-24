// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\wz_common\character_unlock_fixup.csc;
#using script_731df012f3a3c2fc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace character_unlock_mason;

/*
	Name: __init__system__
	Namespace: character_unlock_mason
	Checksum: 0xF3D35EBA
	Offset: 0x118
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"character_unlock_mason", &__init__, undefined, #"character_unlock_mason_fixup");
}

/*
	Name: __init__
	Namespace: character_unlock_mason
	Checksum: 0xED85136E
	Offset: 0x168
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "array_broadcast", 1, 1, "int", undefined, 1, 0);
	clientfield::register("toplayer", "array_effects", 1, 1, "int", undefined, 0, 1);
	character_unlock_fixup::function_90ee7a97(#"mason_unlock", &function_2613aeec);
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: function_2613aeec
	Namespace: character_unlock_mason
	Checksum: 0xDB357237
	Offset: 0x238
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_2613aeec(enabled)
{
	if(enabled)
	{
		if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
		{
			namespace_b0722f43::function_e70fa91c(#"hash_2e8c8c85b6034ab3", #"hash_d215d711186a8db", 1);
		}
		else
		{
			namespace_b0722f43::function_e70fa91c(#"hash_4bfbb656e63b17ae", #"hash_d215d711186a8db", 6);
		}
	}
}

/*
	Name: on_localclient_connect
	Namespace: character_unlock_mason
	Checksum: 0xEB86E553
	Offset: 0x310
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	var_2fcdec4f = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 0) && (isdefined(getgametypesetting(#"hash_20f3ff8fbb8d8295")) ? getgametypesetting(#"hash_20f3ff8fbb8d8295") : 0) && (isdefined(getgametypesetting(#"hash_3778ec3bd924f17c")) ? getgametypesetting(#"hash_3778ec3bd924f17c") : 0) && (isdefined(getgametypesetting(#"hash_24e281e778894ac9")) ? getgametypesetting(#"hash_24e281e778894ac9") : 0);
	if(var_2fcdec4f)
	{
		level thread function_6a0a79cf(localclientnum);
	}
}

/*
	Name: function_6a0a79cf
	Namespace: character_unlock_mason
	Checksum: 0xF9A23F1E
	Offset: 0x490
	Size: 0x18C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6a0a79cf(localclientnum)
{
	var_d5823792 = 0;
	var_b9d612e8 = 0;
	var_a106daf5 = 0;
	while(true)
	{
		local_player = function_5c10bd79(localclientnum);
		if(isdefined(local_player))
		{
			if(!local_player hasdobj(localclientnum))
			{
				waitframe(1);
				continue;
			}
		}
		if(isdefined(local_player))
		{
			array_effects = local_player clientfield::get_to_player("array_effects");
			if(array_effects === 1 && !var_d5823792)
			{
				var_d5823792 = 1;
				var_b9d612e8 = playfxoncamera(localclientnum, "wz/fx8_plyr_pstfx_numbers", (0, 0, 0), (1, 0, 0), (0, 0, 1));
				var_a106daf5 = function_239993de(localclientnum, "wz/fx8_plyr_numbers", local_player, "tag_origin");
			}
			else if(array_effects === 0 && var_d5823792)
			{
				var_d5823792 = 0;
				stopfx(localclientnum, var_b9d612e8);
				stopfx(localclientnum, var_a106daf5);
			}
		}
		else
		{
			return;
		}
		waitframe(1);
	}
}

