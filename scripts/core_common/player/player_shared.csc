// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace player;

/*
	Name: __init__system__
	Namespace: player
	Checksum: 0xFECF46BA
	Offset: 0x100
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"player", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: player
	Checksum: 0x69B3BF19
	Offset: 0x148
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("world", "gameplay_started", 1, 1, "int", &gameplay_started_callback, 0, 1);
	clientfield::register("toplayer", "gameplay_allows_deploy", 1, 1, "int", undefined, 0, 0);
	clientfield::register("toplayer", "player_dof_settings", 1, 2, "int", &function_f9e445ee, 0, 0);
	callback::on_localplayer_spawned(&local_player_spawn);
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: gameplay_started_callback
	Namespace: player
	Checksum: 0x92AA9EDC
	Offset: 0x260
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function gameplay_started_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	setdvar(#"cg_isgameplayactive", newval);
	if(newval)
	{
		level callback::callback(#"hash_53992479a389b987", localclientnum);
	}
}

/*
	Name: local_player_spawn
	Namespace: player
	Checksum: 0xDC69F84F
	Offset: 0x2F0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function local_player_spawn(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	setdepthoffield(localclientnum, 0, 0, 0, 0, 6, 1.8);
}

/*
	Name: on_player_spawned
	Namespace: player
	Checksum: 0x19568085
	Offset: 0x350
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function on_player_spawned(localclientnum)
{
	if(sessionmodeiswarzonegame())
	{
		return;
	}
	var_87e3f0d8 = function_27673a7(localclientnum);
	if(level.var_7315d934 === 1)
	{
		if(var_87e3f0d8 == self)
		{
			var_87e3f0d8 thread function_c98e67ae(localclientnum);
		}
		return;
	}
	players = getplayers(localclientnum);
	foreach(player in players)
	{
		player function_8656d7d1(localclientnum);
	}
}

/*
	Name: function_f22aa227
	Namespace: player
	Checksum: 0xD83851FB
	Offset: 0x468
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_f22aa227(localclientnum)
{
	if(level.var_7315d934 === 1)
	{
		self function_9f517895(localclientnum);
	}
	else
	{
		self function_8656d7d1(localclientnum);
	}
}

/*
	Name: function_8656d7d1
	Namespace: player
	Checksum: 0x5D2D833D
	Offset: 0x4C0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8656d7d1(localclientnum)
{
	player = self;
	if(!isdefined(player))
	{
		return;
	}
	if(!isalive(player))
	{
		return;
	}
	var_87e3f0d8 = function_27673a7(localclientnum);
	if(player.team !== var_87e3f0d8.team)
	{
		player function_e2d964e8();
	}
	else
	{
		player function_f71119e0(0);
	}
}

/*
	Name: function_c98e67ae
	Namespace: player
	Checksum: 0x800AEA6E
	Offset: 0x580
	Size: 0x10C
	Parameters: 1
	Flags: Linked
*/
function function_c98e67ae(localclientnum)
{
	self notify("3ae575e255539f29");
	self endon("3ae575e255539f29");
	wait(10);
	while(true)
	{
		wait(0.2);
		players = getplayers(localclientnum);
		var_f3108b8 = function_5c10bd79(localclientnum);
		foreach(player in players)
		{
			if(player == var_f3108b8)
			{
				continue;
			}
			player function_9f517895(localclientnum);
		}
	}
}

/*
	Name: function_9f517895
	Namespace: player
	Checksum: 0x54AB5C92
	Offset: 0x698
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9f517895(localclientnum)
{
	player = self;
	if(!isdefined(player))
	{
		return;
	}
	if(!isalive(player))
	{
		return;
	}
	var_87e3f0d8 = function_27673a7(localclientnum);
	var_f3108b8 = function_5c10bd79(localclientnum);
	if(player.team !== var_87e3f0d8.team && !player isplayerswimmingunderwater() && !var_f3108b8 isplayerswimmingunderwater())
	{
		player function_e2d964e8();
	}
	else
	{
		player function_f71119e0(0);
	}
}

/*
	Name: function_e2d964e8
	Namespace: player
	Checksum: 0x8FA4CC8D
	Offset: 0x7A8
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e2d964e8()
{
	if(self.visionpulsereveal === 1)
	{
		return;
	}
	if(isdefined(level.var_20369084))
	{
		self function_9535c165(level.var_20369084, "cold_blooded");
	}
	else
	{
		self function_bd70f43d();
	}
}

/*
	Name: function_9535c165
	Namespace: player
	Checksum: 0x7CAD9197
	Offset: 0x818
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_9535c165(var_2af183d0, clientfield)
{
	if(self clientfield::get(clientfield) > 0)
	{
		self function_994b4121();
		self enable_rob(var_2af183d0);
	}
	else
	{
		self function_5da42cd4(var_2af183d0);
		self function_bd70f43d();
	}
}

/*
	Name: function_f2ba057
	Namespace: player
	Checksum: 0x63EFA6B2
	Offset: 0x8B0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_f2ba057()
{
	function_f71119e0(1);
}

/*
	Name: function_f71119e0
	Namespace: player
	Checksum: 0x9932A564
	Offset: 0x8D8
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f71119e0(var_c8db7193)
{
	if(self.visionpulsereveal === 1)
	{
		return;
	}
	if(isdefined(level.var_20369084))
	{
		self function_5da42cd4(level.var_20369084);
	}
	self function_994b4121();
}

/*
	Name: enable_rob
	Namespace: player
	Checksum: 0x6F506BA1
	Offset: 0x948
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function enable_rob(var_6560376a)
{
	if(!self function_d2503806(var_6560376a))
	{
		self playrenderoverridebundle(var_6560376a);
	}
}

/*
	Name: function_5da42cd4
	Namespace: player
	Checksum: 0x48637069
	Offset: 0x990
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_5da42cd4(var_6560376a)
{
	if(self function_d2503806(var_6560376a))
	{
		self stoprenderoverridebundle(var_6560376a);
	}
}

/*
	Name: function_bd70f43d
	Namespace: player
	Checksum: 0x9DE69F4C
	Offset: 0x9D8
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_bd70f43d()
{
	if(!self function_d2503806(#"rob_sonar_set_enemy"))
	{
		self playrenderoverridebundle(#"rob_sonar_set_enemy");
	}
}

/*
	Name: function_994b4121
	Namespace: player
	Checksum: 0x215926C4
	Offset: 0xA28
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_994b4121()
{
	if(self function_d2503806(#"rob_sonar_set_enemy"))
	{
		self stoprenderoverridebundle(#"rob_sonar_set_enemy");
	}
}

/*
	Name: function_f9e445ee
	Namespace: player
	Checksum: 0xE90769E2
	Offset: 0xA78
	Size: 0x122
	Parameters: 7
	Flags: Linked
*/
function function_f9e445ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			setdepthoffield(localclientnum, 0, 0, 512, 512, 4, 0);
			break;
		}
		case 1:
		{
			setdepthoffield(localclientnum, 0, 0, 512, 4000, 4, 0);
			break;
		}
		case 2:
		{
			setdepthoffield(localclientnum, 0, 128, 512, 4000, 6, 1.8);
			break;
		}
		default:
		{
			break;
		}
	}
}

