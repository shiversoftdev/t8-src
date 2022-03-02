// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_27c22e1d8df4d852;
#using script_3f9e0dc8454d98e1;
#using script_57f7003580bb15e0;
#using script_6021ce59143452c3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_c1466447;

/*
	Name: function_89f2df9
	Namespace: namespace_c1466447
	Checksum: 0xC83FD5C6
	Offset: 0x158
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_2c983afcd92a9970", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_c1466447
	Checksum: 0xC0A41501
	Offset: 0x1A0
	Size: 0x11C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!zm_trial::function_b47f6aba())
	{
		return;
	}
	clientfield::register("toplayer", "" + #"hash_b905d796914b710", 14000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_1b9477ddcf30191f", 16000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_52347bec3f1339fd", 16000, 4, "int");
	zm_trial::register_challenge(#"hash_6c768f3c15d55377", &function_d1de6a85, &function_9e7b3f4d);
}

/*
	Name: function_d1de6a85
	Namespace: namespace_c1466447
	Checksum: 0xC009E6EB
	Offset: 0x2C8
	Size: 0x26C
	Parameters: 1
	Flags: Private
*/
function private function_d1de6a85(var_2a0af02f)
{
	level.var_4ecf5754 = (isdefined(var_2a0af02f) ? var_2a0af02f : #"hash_65cfe78dc61dd3af");
	switch(level.var_4ecf5754)
	{
		case "hash_65cfe78dc61dd3af":
		{
			level thread function_40c7a8fd();
			break;
		}
		case "hash_5a202c5d6f53d672":
		{
			foreach(player in getplayers())
			{
				player thread function_69fa75f8();
			}
			break;
		}
		case "hash_64ad2ae9d7260dbc":
		{
			foreach(player in getplayers())
			{
				player thread function_6d8cf829();
			}
			break;
		}
		case "hash_61b6ca8ab42d9761":
		{
			callback::add_callback(#"hash_137b937fd26992be", &function_604ff1eb);
			foreach(player in getplayers())
			{
				player thread function_ad641569();
			}
			break;
		}
	}
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: function_9e7b3f4d
	Namespace: namespace_c1466447
	Checksum: 0x8AE116C9
	Offset: 0x540
	Size: 0x304
	Parameters: 1
	Flags: Private
*/
function private function_9e7b3f4d(round_reset)
{
	switch(level.var_4ecf5754)
	{
		case "hash_65cfe78dc61dd3af":
		{
			foreach(player in getplayers())
			{
				player thread clientfield::set_to_player("" + #"hash_b905d796914b710", 0);
			}
			setslowmotion(1.25, 1);
			if(isdefined(level.var_79514f31))
			{
				level.var_79514f31 delete();
			}
			break;
		}
		case "hash_5a202c5d6f53d672":
		{
			if(!round_reset)
			{
				foreach(player in getplayers())
				{
					player function_e0c7d69(1);
					player clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 0);
				}
			}
			break;
		}
		case "hash_64ad2ae9d7260dbc":
		{
			foreach(player in getplayers())
			{
				player clientfield::set_to_player("" + #"hash_52347bec3f1339fd", 0);
			}
			break;
		}
		case "hash_61b6ca8ab42d9761":
		{
			callback::remove_callback(#"hash_137b937fd26992be", &function_604ff1eb);
			break;
		}
	}
	level.var_4ecf5754 = undefined;
	callback::remove_on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: namespace_c1466447
	Checksum: 0xAB802AE8
	Offset: 0x850
	Size: 0x4C
	Parameters: 0
	Flags: Private
*/
function private on_player_spawned()
{
	if(level.var_4ecf5754 === #"hash_65cfe78dc61dd3af")
	{
		self clientfield::set_to_player("" + #"hash_b905d796914b710", 1);
	}
}

/*
	Name: function_40c7a8fd
	Namespace: namespace_c1466447
	Checksum: 0x254BE58F
	Offset: 0x8A8
	Size: 0x144
	Parameters: 0
	Flags: None
*/
function function_40c7a8fd()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	wait(3.5);
	foreach(player in getplayers())
	{
		player clientfield::set_to_player("" + #"hash_b905d796914b710", 1);
	}
	wait(2);
	setslowmotion(1, 1.25);
	level.var_79514f31 = spawn("script_origin", (0, 0, 0));
	level.var_79514f31 playloopsound(#"hash_1eafdf46ffbf2308");
}

/*
	Name: function_69fa75f8
	Namespace: namespace_c1466447
	Checksum: 0x7FF411F2
	Offset: 0x9F8
	Size: 0x144
	Parameters: 0
	Flags: Private
*/
function private function_69fa75f8()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656");
	while(true)
	{
		self clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 1);
		self function_e0c7d69(0);
		while(true)
		{
			var_be17187b = undefined;
			var_be17187b = self waittilltimeout(1, #"weapon_fired", #"hash_3e0895cd0cc16d2d", #"lightning_ball_created", #"hash_4d733389a8e35a7c");
			if(var_be17187b._notify != "timeout")
			{
				self clientfield::set_to_player("" + #"hash_1b9477ddcf30191f", 0);
				self function_e0c7d69(1);
			}
			else
			{
				break;
			}
		}
	}
}

/*
	Name: function_6d8cf829
	Namespace: namespace_c1466447
	Checksum: 0x8CEDF99B
	Offset: 0xB48
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function function_6d8cf829()
{
	self endon(#"disconnect");
	level endon(#"hash_7646638df88a3656", #"end_game");
	while(true)
	{
		n_perks = self.var_67ba1237.size + self.var_466b927f.size;
		self clientfield::set_to_player("" + #"hash_52347bec3f1339fd", n_perks);
		wait(1);
	}
}

/*
	Name: function_ad641569
	Namespace: namespace_c1466447
	Checksum: 0x96C59C4
	Offset: 0xBE8
	Size: 0x210
	Parameters: 0
	Flags: Private
*/
function private function_ad641569()
{
	self notify("3d0a827cbf03ae74");
	self endon("3d0a827cbf03ae74");
	self endon(#"disconnect");
	level endoncallback(&function_1a109202, #"hash_7646638df88a3656", #"host_migration_begin");
	while(true)
	{
		wait(function_21a3a673(5, 15));
		var_6eabfd9d = function_4d1e7b48("blind_zm_catalyst");
		n_duration = function_21a3a673(5000, 7500);
		self status_effect::status_effect_apply(var_6eabfd9d, undefined, self, 0, n_duration);
		wait(float(n_duration) / 1000);
		var_3caa2c0f = function_4d1e7b48("deaf_electricity_catalyst");
		self status_effect::status_effect_apply(var_3caa2c0f, undefined, self, 0, n_duration);
		wait(float(n_duration) / 1000);
		if(self status_effect::function_4617032e(var_6eabfd9d.var_67e2281d))
		{
			self status_effect::function_408158ef(var_6eabfd9d.var_67e2281d, var_6eabfd9d.var_18d16a6b);
		}
		if(self status_effect::function_4617032e(var_3caa2c0f.var_67e2281d))
		{
			self status_effect::function_408158ef(var_3caa2c0f.var_67e2281d, var_3caa2c0f.var_18d16a6b);
		}
	}
}

/*
	Name: function_1a109202
	Namespace: namespace_c1466447
	Checksum: 0x7EFF4626
	Offset: 0xE00
	Size: 0x168
	Parameters: 1
	Flags: None
*/
function function_1a109202(str_notify)
{
	if(str_notify === "host_migration_begin")
	{
		var_6eabfd9d = function_4d1e7b48("blind_zm_catalyst");
		var_3caa2c0f = function_4d1e7b48("deaf_electricity_catalyst");
		foreach(player in getplayers())
		{
			if(player status_effect::function_4617032e(var_6eabfd9d.var_67e2281d))
			{
				player status_effect::function_408158ef(var_6eabfd9d.var_67e2281d, var_6eabfd9d.var_18d16a6b);
			}
			if(player status_effect::function_4617032e(var_3caa2c0f.var_67e2281d))
			{
				player status_effect::function_408158ef(var_3caa2c0f.var_67e2281d, var_3caa2c0f.var_18d16a6b);
			}
		}
	}
}

/*
	Name: function_604ff1eb
	Namespace: namespace_c1466447
	Checksum: 0x8F050A61
	Offset: 0xF70
	Size: 0xB0
	Parameters: 0
	Flags: Private
*/
function private function_604ff1eb()
{
	level endon(#"hash_7646638df88a3656", #"end_game");
	wait(5);
	foreach(player in getplayers())
	{
		player thread function_ad641569();
	}
}

