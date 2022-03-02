// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5da9076b8e4f6d28;
#using script_68264f587357ea51;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_3b8b8298;

/*
	Name: function_89f2df9
	Namespace: namespace_3b8b8298
	Checksum: 0xBA11F2FE
	Offset: 0xE0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_4fb1e186fac435f4", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_3b8b8298
	Checksum: 0x4F48BDD1
	Offset: 0x128
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_cee10b49 = [];
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: on_localclient_connect
	Namespace: namespace_3b8b8298
	Checksum: 0x285501C8
	Offset: 0x168
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private on_localclient_connect(localclientnum)
{
	if(isdefined(getgametypesetting(#"hash_2992e3d39d55b312")) && getgametypesetting(#"hash_2992e3d39d55b312"))
	{
		level thread function_53d906fd(localclientnum);
	}
}

/*
	Name: function_53d906fd
	Namespace: namespace_3b8b8298
	Checksum: 0x2C483CFC
	Offset: 0x1E8
	Size: 0x2CC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_53d906fd(localclientnum)
{
	level endon(#"game_ended");
	while(true)
	{
		player = function_5c10bd79(localclientnum);
		show_fx = level clientfield::get("showSpectreSwordBeams");
		if(isdefined(level.var_5b2a8d88) && isdefined(player))
		{
			foreach(i, playfx in level.var_5b2a8d88)
			{
				if(show_fx)
				{
					if(namespace_ad5a0cd6::function_2c7fc531(i))
					{
						point = function_b1702735(i);
						if(isdefined(point) && isdefined(point.var_a6762160) && point.var_a6762160.name === #"hash_43aca7fcfd3e5949")
						{
							point function_6b5dfd6c(localclientnum, playfx, 0, i, player);
						}
						else
						{
							level function_6b5dfd6c(localclientnum, 0, 0, i, player);
						}
					}
					else if(namespace_ad5a0cd6::function_da09de95(i))
					{
						if(isdefined(level.var_a4a4012e[i]) && isdefined(level.var_a4a4012e[i].var_a6762160) && level.var_a4a4012e[i].var_a6762160.name === #"hash_43aca7fcfd3e5949")
						{
							level.var_a4a4012e[i] function_6b5dfd6c(localclientnum, playfx, 1, i);
						}
						else
						{
							level function_6b5dfd6c(localclientnum, 0, 1, i, player);
						}
					}
					continue;
				}
				level function_6b5dfd6c(localclientnum, 0, 0, i, player);
			}
		}
		wait(0.2);
	}
}

/*
	Name: function_6b5dfd6c
	Namespace: namespace_3b8b8298
	Checksum: 0x2BE431FA
	Offset: 0x4C0
	Size: 0x4AC
	Parameters: 5
	Flags: Linked
*/
function function_6b5dfd6c(localclientnum, playfx, var_484cae2, id, player)
{
	if(!isdefined(player))
	{
		return;
	}
	if(!isdefined(player.var_c1c8ef9c))
	{
		player.var_c1c8ef9c = [];
	}
	if(playfx)
	{
		if(!isdefined(player.var_c1c8ef9c[id]))
		{
			player.var_c1c8ef9c[id] = {#fxent:undefined, #fx_id:0, #hash_9d888717:0};
			if(var_484cae2)
			{
				player.var_c1c8ef9c[id].var_9d888717 = 1;
				player.var_c1c8ef9c[id].fxent = spawn(localclientnum, self.origin, "script_model");
				player.var_c1c8ef9c[id].fxent setmodel("tag_origin");
				player.var_c1c8ef9c[id].fxent linkto(self);
				player.var_c1c8ef9c[id].fx_id = function_239993de(localclientnum, #"hash_3235e29f5bf57d5a", player.var_c1c8ef9c[id].fxent, "tag_origin");
			}
			else
			{
				player.var_c1c8ef9c[id].var_9d888717 = 1;
				player.var_c1c8ef9c[id].fx_id = playfx(localclientnum, #"hash_3235e29f5bf57d5a", self.origin);
			}
		}
		else if(!(isdefined(player.var_c1c8ef9c[id].var_9d888717) && player.var_c1c8ef9c[id].var_9d888717))
		{
			if(var_484cae2)
			{
				player.var_c1c8ef9c[id].var_9d888717 = 1;
				player.var_c1c8ef9c[id].fxent = spawn(localclientnum, self.origin, "script_model");
				player.var_c1c8ef9c[id].fxent setmodel("tag_origin");
				player.var_c1c8ef9c[id].fxent linkto(self);
				player.var_c1c8ef9c[id].fx_id = function_239993de(localclientnum, #"hash_3235e29f5bf57d5a", player.var_c1c8ef9c[id].fxent, "tag_origin");
			}
			else
			{
				player.var_c1c8ef9c[id].var_9d888717 = 1;
				player.var_c1c8ef9c[id].fx_id = playfx(localclientnum, #"hash_3235e29f5bf57d5a", self.origin);
			}
		}
	}
	else if(isdefined(player.var_c1c8ef9c[id]) && isdefined(player.var_c1c8ef9c[id].fx_id))
	{
		stopfx(localclientnum, player.var_c1c8ef9c[id].fx_id);
		if(isdefined(player.var_c1c8ef9c[id].fxent))
		{
			player.var_c1c8ef9c[id].fxent delete();
		}
		player.var_c1c8ef9c[id] = undefined;
	}
}

