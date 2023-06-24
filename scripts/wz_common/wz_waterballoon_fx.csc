// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_stats.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace wz_waterballoon_fx;

/*
	Name: __init__system__
	Namespace: wz_waterballoon_fx
	Checksum: 0xAAC75F51
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_waterballoon_fx", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_waterballoon_fx
	Checksum: 0x5C9C10B2
	Offset: 0x130
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "player_hit_water_balloon", 16000, 1, "int", undefined, 0, 0);
	clientfield::register("toplayer", "player_hit_water_balloon_direction", 16000, 4, "int", undefined, 0, 0);
	callback::on_localclient_connect(&on_localclient_connect);
}

/*
	Name: on_localclient_connect
	Namespace: wz_waterballoon_fx
	Checksum: 0x92FDC813
	Offset: 0x1D0
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function on_localclient_connect(localclientnum)
{
	if((isdefined(getgametypesetting(#"hash_33d1ac5e99fb0584")) ? getgametypesetting(#"hash_33d1ac5e99fb0584") : 0) || (isdefined(getgametypesetting(#"hash_3e2d2cf6b1cc6c68")) ? getgametypesetting(#"hash_3e2d2cf6b1cc6c68") : 0))
	{
		level thread function_4433b7ba(localclientnum);
	}
}

/*
	Name: function_4433b7ba
	Namespace: wz_waterballoon_fx
	Checksum: 0x2D8687FA
	Offset: 0x2A0
	Size: 0x5BC
	Parameters: 1
	Flags: Linked
*/
function function_4433b7ba(localclientnum)
{
	var_d5823792 = 0;
	while(true)
	{
		local_player = function_5c10bd79(localclientnum);
		if(isdefined(local_player))
		{
			var_965f0bef = local_player clientfield::get_to_player("player_hit_water_balloon");
			if(var_965f0bef === 1 && !var_d5823792)
			{
				var_d5823792 = 1;
				function_a837926b(localclientnum, #"hash_7deaa6811d695aea");
				waitframe(1);
				if(!isdefined(local_player))
				{
					return;
				}
				var_494e2f9b = local_player clientfield::get_to_player("player_hit_water_balloon_direction");
				switch(var_494e2f9b)
				{
					case 1:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 0);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 0);
						break;
					}
					case 2:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", -1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 0);
						break;
					}
					case 3:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 0);
						break;
					}
					case 4:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 0);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", -1);
						break;
					}
					case 5:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 0);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 1);
						break;
					}
					case 6:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", -1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", -1);
						break;
					}
					case 8:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", -1);
						break;
					}
					case 9:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", -1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 1);
						break;
					}
					case 10:
					{
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed832b7781cf8", 1);
						local_player postfx::function_c8b5f318(#"hash_7deaa6811d695aea", #"hash_638ed932b7781eab", 1);
						break;
					}
				}
			}
			else if(var_965f0bef === 0 && var_d5823792)
			{
				var_d5823792 = 0;
				function_24cd4cfb(localclientnum, #"hash_7deaa6811d695aea");
			}
		}
		else
		{
			return;
		}
		waitframe(1);
	}
}

