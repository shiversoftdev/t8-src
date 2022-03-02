// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_170a9c130859c688;
#using script_47fb62300ac0bd60;
#using script_64ab2b950d85b8ad;
#using script_71e26f08f03b7a7a;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace character_unlock;

/*
	Name: function_89f2df9
	Namespace: character_unlock
	Checksum: 0xD6B9C97D
	Offset: 0x98
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"character_unlock", &__init__, undefined, #"hash_1fd69f0c10bde41c");
}

/*
	Name: __init__
	Namespace: character_unlock
	Checksum: 0xC1C314A8
	Offset: 0xE8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_b3681acb = (isdefined(getgametypesetting(#"hash_50b1121aee76a7e4")) ? getgametypesetting(#"hash_50b1121aee76a7e4") : 1);
	callback::function_10a4dd0a(&function_6e8037ca);
	callback::add_callback(#"hash_27e13b9438e33053", &function_28a6c197);
	callback::add_callback(#"on_end_game", &on_end_game);
	callback::on_disconnect(&on_player_disconnect);
}

/*
	Name: function_b3681acb
	Namespace: character_unlock
	Checksum: 0xD4574436
	Offset: 0x1F0
	Size: 0x82
	Parameters: 0
	Flags: Linked
*/
function function_b3681acb()
{
	/#
		if(getdvar(#"hash_62fbe70d500712c1", 0) == 1)
		{
			return 1;
		}
	#/
	return level.var_b3681acb && (isdefined(level.onlinegame) && level.onlinegame) && (isdefined(level.rankedmatch) && level.rankedmatch);
}

/*
	Name: function_d89ef6af
	Namespace: character_unlock
	Checksum: 0x78F0270F
	Offset: 0x280
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_d89ef6af(var_79cf244b)
{
	switch(var_79cf244b)
	{
		case "hash_178221dd8299137b":
		{
			return true;
		}
		case "hash_8c7045e78561cf4":
		{
			return true;
		}
		case "hash_3532d912b12917c9":
		{
			return true;
		}
		case "hash_517bb26004a9c12b":
		{
			return true;
		}
		case "hash_263de5e9fa6d16ea":
		{
			return true;
		}
		case "hash_74709eb5a08139fb":
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_d7e6fa92
	Namespace: character_unlock
	Checksum: 0xBE17B8BA
	Offset: 0x330
	Size: 0x178
	Parameters: 1
	Flags: Linked
*/
function function_d7e6fa92(var_79cf244b)
{
	var_9ba1646c = level.var_7d8da246[var_79cf244b];
	/#
		/#
			assert(isdefined(var_9ba1646c), ("" + function_9e72a96(var_79cf244b)) + "");
		#/
	#/
	if(!isdefined(var_9ba1646c))
	{
		return false;
	}
	var_2b469a7d = var_9ba1646c.var_2b469a7d;
	if(function_d89ef6af(var_79cf244b))
	{
		if(isdefined(stats::get_stat(#"hash_3ee8b4a6073f7825", var_2b469a7d)) && stats::get_stat(#"hash_3ee8b4a6073f7825", var_2b469a7d))
		{
			return true;
		}
		return false;
	}
	if(isdefined(stats::get_stat(#"characters", var_2b469a7d, #"unlocked")) && stats::get_stat(#"characters", var_2b469a7d, #"unlocked"))
	{
		return true;
	}
	return false;
}

/*
	Name: function_f0406288
	Namespace: character_unlock
	Checksum: 0x5541EE5
	Offset: 0x4B0
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function function_f0406288(var_79cf244b)
{
	if(!level function_b3681acb())
	{
		return false;
	}
	if(self function_d7e6fa92(var_79cf244b))
	{
		return false;
	}
	if(isdefined(self.var_474dff5e) && (isdefined(self.var_474dff5e[var_79cf244b]) && self.var_474dff5e[var_79cf244b]))
	{
		return true;
	}
	var_9ba1646c = level.var_7d8da246[var_79cf244b];
	item_name = var_9ba1646c.var_a531c26d;
	var_a531c26d = self namespace_b376ff3f::function_7fe4ce88(item_name);
	if(isdefined(var_a531c26d))
	{
		return true;
	}
	return false;
}

/*
	Name: function_c70bcc7a
	Namespace: character_unlock
	Checksum: 0x3E1B7301
	Offset: 0x5A0
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function function_c70bcc7a(var_79cf244b)
{
	if(!level function_b3681acb())
	{
		return false;
	}
	if(self function_d7e6fa92(var_79cf244b))
	{
		return false;
	}
	if(!isdefined(self.var_c53589da) || !isdefined(self.var_c53589da[var_79cf244b]))
	{
		return false;
	}
	return true;
}

/*
	Name: function_6e8037ca
	Namespace: character_unlock
	Checksum: 0x69828968
	Offset: 0x628
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function function_6e8037ca(params)
{
	if(!level function_b3681acb())
	{
		return;
	}
	if(level.inprematchperiod)
	{
		return;
	}
	var_a6762160 = params.item.var_a6762160;
	if(!isdefined(var_a6762160))
	{
		return;
	}
	if(!isdefined(var_a6762160.unlockableitemref))
	{
		return;
	}
	foreach(var_79cf244b, var_9ba1646c in level.var_7d8da246)
	{
		if(self function_d7e6fa92(var_79cf244b))
		{
			var_c340dd9f = getscriptbundle(var_9ba1646c.var_a531c26d);
			if(!isdefined(var_c340dd9f) || !isdefined(var_c340dd9f.unlockableitemref))
			{
				continue;
			}
			itemindex = getitemindexfromref(var_c340dd9f.unlockableitemref);
			if(itemindex == 0)
			{
				continue;
			}
			self luinotifyevent(#"hash_4abc0876fc41cc7f", 2, 1, itemindex);
			continue;
		}
		item_name = var_9ba1646c.var_a531c26d;
		if(var_a6762160.name === item_name)
		{
			if(!isdefined(self.var_c53589da))
			{
				self.var_c53589da = [];
			}
			if(!isdefined(self.var_c53589da[var_79cf244b]))
			{
				var_c5c8fd39 = {#hash_e7e238a4:[]};
				foreach(condition in var_9ba1646c.var_3845495)
				{
					var_c5c8fd39.var_e7e238a4[condition] = 0;
				}
				self.var_c53589da[var_79cf244b] = var_c5c8fd39;
			}
			break;
		}
	}
	self callback::callback(#"hash_48bcdfea6f43fecb", params.item);
}

/*
	Name: function_c8beca5e
	Namespace: character_unlock
	Checksum: 0x88DA6D99
	Offset: 0x908
	Size: 0x2B4
	Parameters: 3
	Flags: Linked
*/
function function_c8beca5e(var_79cf244b, var_1d208aea, state)
{
	if(!level function_b3681acb())
	{
		return;
	}
	if(level.inprematchperiod)
	{
		return;
	}
	var_9ba1646c = level.var_7d8da246[var_79cf244b];
	/#
		/#
			assert(isdefined(var_9ba1646c), ("" + function_9e72a96(var_79cf244b)) + "");
		#/
		/#
			assert(isinarray(var_9ba1646c.var_3845495, var_1d208aea), (("" + function_9e72a96(var_1d208aea)) + "") + function_9e72a96(var_79cf244b));
		#/
		/#
			assert(isinarray(array(0, 1, 2), state), (("" + function_9e72a96(var_1d208aea)) + "") + function_9e72a96(var_79cf244b));
		#/
	#/
	if(!self function_c70bcc7a(var_79cf244b))
	{
		/#
			assertmsg(("" + var_79cf244b) + "");
		#/
		return;
	}
	current_state = self.var_c53589da[var_79cf244b].var_e7e238a4[var_1d208aea];
	if(current_state == 2)
	{
		return;
	}
	self.var_c53589da[var_79cf244b].var_e7e238a4[var_1d208aea] = state;
	self function_20b0ca2e(var_79cf244b);
	if(var_1d208aea != #"hash_3f07579f66b464e8")
	{
		if(!isalive(self) || (isdefined(level.gameended) && level.gameended))
		{
			self function_fb689837();
		}
	}
}

/*
	Name: function_20b0ca2e
	Namespace: character_unlock
	Checksum: 0xA4A10712
	Offset: 0xBC8
	Size: 0x462
	Parameters: 1
	Flags: Linked
*/
function function_20b0ca2e(var_79cf244b)
{
	var_9ba1646c = level.var_7d8da246[var_79cf244b];
	/#
		/#
			assert(isdefined(var_9ba1646c), ("" + function_9e72a96(var_79cf244b)) + "");
		#/
	#/
	var_c340dd9f = getscriptbundle(var_9ba1646c.var_a531c26d);
	if(!isdefined(var_c340dd9f.unlockableitemref))
	{
		return;
	}
	itemindex = getitemindexfromref(var_c340dd9f.unlockableitemref);
	if(itemindex == 0)
	{
		return;
	}
	var_93e871fc = var_9ba1646c.var_3845495;
	switch(var_9ba1646c.var_3845495.size)
	{
		case 1:
		{
			self luinotifyevent(#"hash_4abc0876fc41cc7f", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[0]]);
			break;
		}
		case 2:
		{
			self luinotifyevent(#"hash_4abc0876fc41cc7f", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[1]]);
			break;
		}
		case 3:
		{
			self luinotifyevent(#"hash_4abc0876fc41cc7f", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[2]]);
			break;
		}
		case 4:
		{
			self luinotifyevent(#"hash_4abc0876fc41cc7f", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[3]]);
			break;
		}
		case 5:
		{
			self luinotifyevent(#"hash_4abc0876fc41cc7f", var_9ba1646c.var_3845495.size + 2, 0, itemindex, self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[0]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[1]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[2]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[3]], self.var_c53589da[var_79cf244b].var_e7e238a4[var_93e871fc[4]]);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_54fc60f5
	Namespace: character_unlock
	Checksum: 0x859A1F1
	Offset: 0x1038
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_54fc60f5(player, character)
{
	if(isdefined(player) && isplayer(player) && isdefined(character))
	{
		player_xuid = player getxuid(1);
		if(isdefined(player_xuid))
		{
			data = {#character:character, #player_xuid:int(player_xuid), #game_time:function_f8d53445()};
			function_92d1707f(#"hash_17e83c78e2a73ed1", data);
		}
	}
}

/*
	Name: function_fb689837
	Namespace: character_unlock
	Checksum: 0xCED5C2E8
	Offset: 0x1140
	Size: 0x2A8
	Parameters: 0
	Flags: Linked
*/
function function_fb689837()
{
	if(!isdefined(self.var_c53589da))
	{
		return;
	}
	foreach(var_79cf244b, var_c5c8fd39 in self.var_c53589da)
	{
		if(!self function_f0406288(var_79cf244b))
		{
			continue;
		}
		var_b3895a2 = 1;
		foreach(var_1d208aea, var_b7ed23ab in var_c5c8fd39.var_e7e238a4)
		{
			if(var_1d208aea != #"hash_3f07579f66b464e8" && var_b7ed23ab != 1)
			{
				var_b3895a2 = 0;
				break;
			}
		}
		if(!var_b3895a2)
		{
			continue;
		}
		self function_c8beca5e(var_79cf244b, #"hash_3f07579f66b464e8", 1);
		var_9ba1646c = level.var_7d8da246[var_79cf244b];
		if(isdefined(var_9ba1646c))
		{
			var_2b469a7d = var_9ba1646c.var_2b469a7d;
		}
		if(isdefined(var_2b469a7d))
		{
			if(function_d89ef6af(var_79cf244b))
			{
				self stats::set_stat(#"hash_3ee8b4a6073f7825", var_2b469a7d, 1);
			}
			else
			{
				self stats::set_stat(#"characters", var_2b469a7d, #"unlocked", 1);
				self stats::function_d40764f3(#"hash_6a1aa003c5cc9ec0", 1);
			}
			function_54fc60f5(self, var_2b469a7d);
			var_ade8d0e9 = {#character:var_2b469a7d};
			self callback::callback(#"hash_7fc16e58d454945", var_ade8d0e9);
		}
	}
}

/*
	Name: function_28a6c197
	Namespace: character_unlock
	Checksum: 0x587A3808
	Offset: 0x13F0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_28a6c197(player)
{
	if(!isplayer(player))
	{
		return;
	}
	if(!isdefined(player.var_474dff5e))
	{
		player.var_474dff5e = [];
	}
	foreach(var_79cf244b, var_9ba1646c in level.var_7d8da246)
	{
		item_name = var_9ba1646c.var_a531c26d;
		var_a531c26d = player namespace_b376ff3f::function_7fe4ce88(item_name);
		if(isdefined(var_a531c26d))
		{
			player.var_474dff5e[var_79cf244b] = 1;
		}
	}
	if(!isalive(player))
	{
		player function_fb689837();
	}
}

/*
	Name: on_player_disconnect
	Namespace: character_unlock
	Checksum: 0x7AAE97EE
	Offset: 0x1528
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(!isplayer(self))
	{
		return;
	}
	self function_fb689837();
}

/*
	Name: on_end_game
	Namespace: character_unlock
	Checksum: 0x38CF098
	Offset: 0x1568
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function on_end_game()
{
	players = getplayers();
	foreach(player in players)
	{
		player function_fb689837();
	}
}

/*
	Name: function_d2294476
	Namespace: character_unlock
	Checksum: 0xD9DFB244
	Offset: 0x1600
	Size: 0x8C
	Parameters: 3
	Flags: Linked
*/
function function_d2294476(var_2ab9d3bd, var_f532cd9f, var_3afaa57b)
{
	if(isdefined(getgametypesetting(#"hash_17f17e92c2654659")) && getgametypesetting(#"hash_17f17e92c2654659"))
	{
		var_f532cd9f = 1;
	}
	namespace_3d2704b3::function_f0297225(var_2ab9d3bd, var_f532cd9f, var_3afaa57b);
}

