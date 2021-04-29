// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_158d50d476435605;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\lui_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace callback;

/*
	Name: callback
	Namespace: callback
	Checksum: 0x8B1836
	Offset: 0x120
	Size: 0x144
	Parameters: 3
	Flags: Linked
*/
function callback(event, localclientnum, params)
{
	if(isdefined(level._callbacks) && isdefined(level._callbacks[event]))
	{
		for(i = 0; i < level._callbacks[event].size; i++)
		{
			callback = level._callbacks[event][i][0];
			obj = level._callbacks[event][i][1];
			if(!isdefined(callback))
			{
				continue;
			}
			if(isdefined(obj))
			{
				if(isdefined(params))
				{
					obj thread [[callback]](localclientnum, self, params);
				}
				else
				{
					obj thread [[callback]](localclientnum, self);
				}
				continue;
			}
			if(isdefined(params))
			{
				self thread [[callback]](localclientnum, params);
				continue;
			}
			self thread [[callback]](localclientnum);
		}
	}
}

/*
	Name: entity_callback
	Namespace: callback
	Checksum: 0x6339AFD9
	Offset: 0x270
	Size: 0x134
	Parameters: 3
	Flags: Linked
*/
function entity_callback(event, localclientnum, params)
{
	if(isdefined(self._callbacks) && isdefined(self._callbacks[event]))
	{
		for(i = 0; i < self._callbacks[event].size; i++)
		{
			callback = self._callbacks[event][i][0];
			obj = self._callbacks[event][i][1];
			if(!isdefined(callback))
			{
				continue;
			}
			if(isdefined(obj))
			{
				if(isdefined(params))
				{
					obj thread [[callback]](localclientnum, self, params);
				}
				else
				{
					obj thread [[callback]](localclientnum, self);
				}
				continue;
			}
			if(isdefined(params))
			{
				self thread [[callback]](localclientnum, params);
				continue;
			}
			self thread [[callback]](localclientnum);
		}
	}
}

/*
	Name: add_callback
	Namespace: callback
	Checksum: 0x8514FCE4
	Offset: 0x3B0
	Size: 0x17C
	Parameters: 3
	Flags: Linked
*/
function add_callback(event, func, obj)
{
	/#
		assert(isdefined(event), "");
	#/
	if(!isdefined(level._callbacks) || !isdefined(level._callbacks[event]))
	{
		level._callbacks[event] = [];
	}
	foreach(callback in level._callbacks[event])
	{
		if(callback[0] == func)
		{
			if(!isdefined(obj) || callback[1] == obj)
			{
				return;
			}
		}
	}
	array::add(level._callbacks[event], array(func, obj), 0);
	if(isdefined(obj))
	{
		obj thread remove_callback_on_death(event, func);
	}
}

/*
	Name: add_entity_callback
	Namespace: callback
	Checksum: 0x210FC7F1
	Offset: 0x538
	Size: 0x14C
	Parameters: 3
	Flags: Linked
*/
function add_entity_callback(event, func, obj)
{
	/#
		assert(isdefined(event), "");
	#/
	if(!isdefined(self._callbacks) || !isdefined(self._callbacks[event]))
	{
		self._callbacks[event] = [];
	}
	foreach(callback in self._callbacks[event])
	{
		if(callback[0] == func)
		{
			if(!isdefined(obj) || callback[1] == obj)
			{
				return;
			}
		}
	}
	array::add(self._callbacks[event], array(func, obj), 0);
}

/*
	Name: remove_callback_on_death
	Namespace: callback
	Checksum: 0x8F33204C
	Offset: 0x690
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function remove_callback_on_death(event, func)
{
	self waittill(#"death");
	remove_callback(event, func, self);
}

/*
	Name: function_52ac9652
	Namespace: callback
	Checksum: 0xA61D0707
	Offset: 0x6E0
	Size: 0x11C
	Parameters: 3
	Flags: Linked
*/
function function_52ac9652(event, func, obj)
{
	/#
		assert(isdefined(event), "");
	#/
	if(!isdefined(self._callbacks) || !isdefined(self._callbacks[event]))
	{
		return;
	}
	foreach(index, func_group in self._callbacks[event])
	{
		if(func_group[0] == func)
		{
			if(func_group[1] === obj)
			{
				arrayremoveindex(self._callbacks[event], index, 0);
				break;
			}
		}
	}
}

/*
	Name: remove_callback
	Namespace: callback
	Checksum: 0x57B534D9
	Offset: 0x808
	Size: 0x12C
	Parameters: 3
	Flags: Linked
*/
function remove_callback(event, func, obj)
{
	/#
		assert(isdefined(event), "");
	#/
	/#
		assert(isdefined(level._callbacks[event]), "");
	#/
	foreach(index, func_group in level._callbacks[event])
	{
		if(func_group[0] == func)
		{
			if(func_group[1] === obj)
			{
				arrayremoveindex(level._callbacks[event], index, 0);
				break;
			}
		}
	}
}

/*
	Name: on_localclient_connect
	Namespace: callback
	Checksum: 0x76DBC21A
	Offset: 0x940
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_localclient_connect(func, obj)
{
	add_callback(#"on_localclient_connect", func, obj);
}

/*
	Name: on_localclient_shutdown
	Namespace: callback
	Checksum: 0x1570B72E
	Offset: 0x988
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_localclient_shutdown(func, obj)
{
	add_callback(#"on_localclient_shutdown", func, obj);
}

/*
	Name: on_finalize_initialization
	Namespace: callback
	Checksum: 0x122637EB
	Offset: 0x9D0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_finalize_initialization(func, obj)
{
	add_callback(#"on_finalize_initialization", func, obj);
}

/*
	Name: function_d46d9315
	Namespace: callback
	Checksum: 0xF1F37C6A
	Offset: 0xA18
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_d46d9315(func, obj)
{
	add_callback(#"hash_53992479a389b987", func, obj);
}

/*
	Name: on_localplayer_spawned
	Namespace: callback
	Checksum: 0xE9FC57D2
	Offset: 0xA60
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_localplayer_spawned(func, obj)
{
	add_callback(#"on_localplayer_spawned", func, obj);
}

/*
	Name: remove_on_localplayer_spawned
	Namespace: callback
	Checksum: 0x4C4D7B0A
	Offset: 0xAA8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_localplayer_spawned(func, obj)
{
	remove_callback(#"on_localplayer_spawned", func, obj);
}

/*
	Name: on_spawned
	Namespace: callback
	Checksum: 0x5A900CF2
	Offset: 0xAF0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_spawned(func, obj)
{
	add_callback(#"on_player_spawned", func, obj);
}

/*
	Name: remove_on_spawned
	Namespace: callback
	Checksum: 0x1C84620B
	Offset: 0xB38
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function remove_on_spawned(func, obj)
{
	remove_callback(#"on_player_spawned", func, obj);
}

/*
	Name: on_laststand
	Namespace: callback
	Checksum: 0xE70A2F6C
	Offset: 0xB80
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_laststand(func, obj)
{
	add_callback(#"on_player_laststand", func, obj);
}

/*
	Name: function_53888e7f
	Namespace: callback
	Checksum: 0x9FD810F3
	Offset: 0xBC8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_53888e7f(func, obj)
{
	remove_callback(#"on_player_laststand", func, obj);
}

/*
	Name: on_player_corpse
	Namespace: callback
	Checksum: 0x5F8B0485
	Offset: 0xC10
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_player_corpse(func, obj)
{
	add_callback(#"on_player_corpse", func, obj);
}

/*
	Name: function_930e5d42
	Namespace: callback
	Checksum: 0xF396167
	Offset: 0xC58
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_930e5d42(func, obj)
{
	add_callback(#"hash_781399e15b138a4e", func, obj);
}

/*
	Name: function_f77ced93
	Namespace: callback
	Checksum: 0xB4149076
	Offset: 0xCA0
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_f77ced93(func, obj)
{
	self add_entity_callback(#"weapon_change", func, obj);
}

/*
	Name: function_6231c19
	Namespace: callback
	Checksum: 0x3368201
	Offset: 0xCE8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_6231c19(func, obj)
{
	add_callback(#"weapon_change", func, obj);
}

/*
	Name: function_17381fe
	Namespace: callback
	Checksum: 0xED3915CA
	Offset: 0xD30
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_17381fe(func, obj)
{
	self add_entity_callback(#"hash_12ca6e8bf50f11f5", func, obj);
}

/*
	Name: on_deleted
	Namespace: callback
	Checksum: 0x2A3FC3A0
	Offset: 0xD78
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function on_deleted(func, obj)
{
	add_callback(#"on_entity_deleted", func, obj);
}

/*
	Name: remove_on_deleted
	Namespace: callback
	Checksum: 0xD053F2A7
	Offset: 0xDC0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_deleted(func, obj)
{
	remove_callback(#"on_entity_deleted", func, obj);
}

/*
	Name: on_shutdown
	Namespace: callback
	Checksum: 0xB2A36636
	Offset: 0xE08
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_shutdown(func, obj)
{
	add_entity_callback(#"on_entity_shutdown", func, obj);
}

/*
	Name: on_start_gametype
	Namespace: callback
	Checksum: 0x54DD6396
	Offset: 0xE50
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_start_gametype(func, obj)
{
	add_callback(#"on_start_gametype", func, obj);
}

/*
	Name: on_end_game
	Namespace: callback
	Checksum: 0xBA60719A
	Offset: 0xE98
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_end_game(func, obj)
{
	add_callback(#"on_end_game", func, obj);
}

/*
	Name: function_b195a021
	Namespace: callback
	Checksum: 0x10A71A9
	Offset: 0xEE0
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b195a021(func, obj)
{
	remove_callback(#"on_end_game", func, obj);
}

/*
	Name: function_e9e16e2f
	Namespace: callback
	Checksum: 0xC3BF41A0
	Offset: 0xF28
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_e9e16e2f(func, obj)
{
	add_callback(#"killcam_begin", func, obj);
}

/*
	Name: function_4f6cafea
	Namespace: callback
	Checksum: 0x4AC1D2B9
	Offset: 0xF70
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_4f6cafea(func, obj)
{
	add_callback(#"killcam_end", func, obj);
}

/*
	Name: function_10a8ebd8
	Namespace: callback
	Checksum: 0x3F39F469
	Offset: 0xFB8
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_10a8ebd8(func, obj)
{
	add_callback(#"melee", func, obj);
}

/*
	Name: function_35a12f19
	Namespace: callback
	Checksum: 0x9414E5C5
	Offset: 0x1000
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_35a12f19(func, obj)
{
	add_entity_callback(#"hash_1bd0411eb5169b", func, obj);
}

/*
	Name: function_b74bf3e
	Namespace: callback
	Checksum: 0x9385B436
	Offset: 0x1048
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_b74bf3e(func, obj)
{
	function_52ac9652(#"hash_1bd0411eb5169b", func, obj);
}

/*
	Name: function_a04381e0
	Namespace: callback
	Checksum: 0x1F05E6FB
	Offset: 0x1090
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function function_a04381e0(func, obj)
{
	add_entity_callback(#"hash_46d459e3750a3345", func, obj);
}

/*
	Name: function_3507ed1f
	Namespace: callback
	Checksum: 0x54D46E4
	Offset: 0x10D8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_3507ed1f(func, obj)
{
	function_52ac9652(#"hash_46d459e3750a3345", func, obj);
}

/*
	Name: on_death
	Namespace: callback
	Checksum: 0x878F66C5
	Offset: 0x1120
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function on_death(func, obj)
{
	add_callback(#"death", func, obj);
}

/*
	Name: remove_on_death
	Namespace: callback
	Checksum: 0x266E9880
	Offset: 0x1168
	Size: 0x3C
	Parameters: 2
	Flags: None
*/
function remove_on_death(func, obj)
{
	remove_callback(#"death", func, obj);
}

/*
	Name: codecallback_preinitialization
	Namespace: callback
	Checksum: 0x641D011A
	Offset: 0x11B0
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_preinitialization(eventstruct)
{
	callback(#"on_pre_initialization");
	system::run_pre_systems();
}

/*
	Name: codecallback_finalizeinitialization
	Namespace: callback
	Checksum: 0xF891BCD8
	Offset: 0x11F8
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event codecallback_finalizeinitialization(eventstruct)
{
	system::run_post_systems();
	callback(#"on_finalize_initialization");
}

/*
	Name: codecallback_statechange
	Namespace: callback
	Checksum: 0x29169ED9
	Offset: 0x1240
	Size: 0x134
	Parameters: 1
	Flags: Event
*/
event codecallback_statechange(eventstruct)
{
	if(!isdefined(level._systemstates))
	{
		level._systemstates = [];
	}
	if(!isdefined(level._systemstates[eventstruct.system]))
	{
		level._systemstates[eventstruct.system] = spawnstruct();
	}
	level._systemstates[eventstruct.system].state = eventstruct.state;
	if(isdefined(level._systemstates[eventstruct.system].callback))
	{
		[[level._systemstates[eventstruct.system].callback]](eventstruct.localclientnum, eventstruct.state);
	}
	println("" + eventstruct.system + "");
}

/*
	Name: codecallback_maprestart
	Namespace: callback
	Checksum: 0x22E0ECE7
	Offset: 0x1380
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event codecallback_maprestart(eventstruct)
{
	/#
		println("");
	#/
	util::waitforclient(0);
	level thread util::init_utility();
}

/*
	Name: codecallback_localclientconnect
	Namespace: callback
	Checksum: 0x5D885679
	Offset: 0x13E8
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event codecallback_localclientconnect(eventstruct)
{
	/#
		println("" + eventstruct.localclientnum);
	#/
	[[level.callbacklocalclientconnect]](eventstruct.localclientnum);
}

/*
	Name: codecallback_glasssmash
	Namespace: callback
	Checksum: 0x570D0071
	Offset: 0x1448
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_glasssmash(eventstruct)
{
	/#
		println("");
	#/
}

/*
	Name: codecallback_soundsetambientstate
	Namespace: callback
	Checksum: 0x1D5C13E3
	Offset: 0x1480
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event codecallback_soundsetambientstate(eventstruct)
{
	audio::setcurrentambientstate(eventstruct.ambientroom, eventstruct.ambientpackage, eventstruct.roomcollider, eventstruct.packagecollider, eventstruct.is_defaultroom);
}

/*
	Name: codecallback_soundsetaiambientstate
	Namespace: callback
	Checksum: 0x884F61E6
	Offset: 0x14E0
	Size: 0xC
	Parameters: 1
	Flags: Event
*/
event codecallback_soundsetaiambientstate(eventstruct)
{
}

/*
	Name: function_d3771684
	Namespace: callback
	Checksum: 0x37E2D8FB
	Offset: 0x14F8
	Size: 0x50
	Parameters: 1
	Flags: Event
*/
event function_d3771684(eventstruct)
{
	if(!isdefined(level.var_44e74ef4))
	{
		return;
	}
	/#
		println("");
	#/
	thread [[level.var_44e74ef4]](eventstruct);
}

/*
	Name: codecallback_soundplayuidecodeloop
	Namespace: callback
	Checksum: 0x5BAF923F
	Offset: 0x1550
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event codecallback_soundplayuidecodeloop(eventstruct)
{
	self thread audio::soundplayuidecodeloop(eventstruct.decode_string, eventstruct.play_time_ms);
}

/*
	Name: codecallback_playerspawned
	Namespace: callback
	Checksum: 0xD12BB53B
	Offset: 0x1590
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event codecallback_playerspawned(eventstruct)
{
	[[level.callbackplayerspawned]](eventstruct.localclientnum);
}

/*
	Name: codecallback_playerlaststand
	Namespace: callback
	Checksum: 0x7640CC12
	Offset: 0x15C0
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event codecallback_playerlaststand(eventstruct)
{
	[[level.callbackplayerlaststand]](eventstruct.localclientnum);
}

/*
	Name: function_c1d1f779
	Namespace: callback
	Checksum: 0xE5005F9E
	Offset: 0x15F0
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event function_c1d1f779(eventstruct)
{
	if(!isdefined(level.var_c3e66138))
	{
		return;
	}
	/#
		println("");
	#/
	thread [[level.var_c3e66138]](eventstruct.var_428d0be2);
}

/*
	Name: function_cfcbacb1
	Namespace: callback
	Checksum: 0x68AC9C32
	Offset: 0x1650
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event function_cfcbacb1(eventstruct)
{
	if(isdefined(level.var_beec2b1))
	{
		[[level.var_beec2b1]](eventstruct.localclientnum);
	}
}

/*
	Name: function_46c0443b
	Namespace: callback
	Checksum: 0x1EFC8668
	Offset: 0x1690
	Size: 0x44
	Parameters: 1
	Flags: Event
*/
event function_46c0443b(eventstruct)
{
	if(isdefined(level.var_c442de72))
	{
		[[level.var_c442de72]](self, eventstruct.localclientnum, eventstruct.weapon);
	}
}

/*
	Name: codecallback_gibevent
	Namespace: callback
	Checksum: 0xA1B1B408
	Offset: 0x16E0
	Size: 0x50
	Parameters: 1
	Flags: Event
*/
event codecallback_gibevent(eventstruct)
{
	if(isdefined(level._gibeventcbfunc))
	{
		self thread [[level._gibeventcbfunc]](eventstruct.localclientnum, eventstruct.type, eventstruct.locations);
	}
}

/*
	Name: codecallback_precachegametype
	Namespace: callback
	Checksum: 0x94A9C0F8
	Offset: 0x1738
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event codecallback_precachegametype(eventstruct)
{
	if(isdefined(level.callbackprecachegametype))
	{
		[[level.callbackprecachegametype]]();
	}
}

/*
	Name: codecallback_startgametype
	Namespace: callback
	Checksum: 0x1CC5253F
	Offset: 0x1770
	Size: 0x5E
	Parameters: 1
	Flags: Event
*/
event codecallback_startgametype(eventstruct)
{
	if(isdefined(level.callbackstartgametype) && (!isdefined(level.gametypestarted) || !level.gametypestarted))
	{
		[[level.callbackstartgametype]]();
		level.gametypestarted = 1;
	}
}

/*
	Name: codecallback_entityspawned
	Namespace: callback
	Checksum: 0xCD7589D8
	Offset: 0x17D8
	Size: 0x24
	Parameters: 1
	Flags: Event
*/
event codecallback_entityspawned(eventstruct)
{
	[[level.callbackentityspawned]](eventstruct.localclientnum);
}

/*
	Name: function_de916514
	Namespace: callback
	Checksum: 0xB4F911AF
	Offset: 0x1808
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event function_de916514(eventstruct)
{
	if(isplayer(self))
	{
		if(isdefined(level.var_69b47c50))
		{
			self [[level.var_69b47c50]](eventstruct.localclientnum, eventstruct.vehicle);
		}
	}
	else if(self isvehicle())
	{
		if(isdefined(level.var_93b40f07))
		{
			self [[level.var_93b40f07]](eventstruct.localclientnum, eventstruct.player);
		}
	}
}

/*
	Name: function_feb0a2aa
	Namespace: callback
	Checksum: 0x3FDC7614
	Offset: 0x18C0
	Size: 0xAC
	Parameters: 1
	Flags: Event
*/
event function_feb0a2aa(eventstruct)
{
	if(isplayer(self))
	{
		if(isdefined(level.var_db2ec524))
		{
			self [[level.var_db2ec524]](eventstruct.localclientnum, eventstruct.vehicle);
		}
	}
	else if(self isvehicle())
	{
		if(isdefined(level.var_d4d60480))
		{
			self [[level.var_d4d60480]](eventstruct.localclientnum, eventstruct.player);
		}
	}
}

/*
	Name: codecallback_soundnotify
	Namespace: callback
	Checksum: 0xF79B1840
	Offset: 0x1978
	Size: 0x92
	Parameters: 1
	Flags: Event
*/
event codecallback_soundnotify(eventstruct)
{
	switch(eventstruct.notetrack)
	{
		case "scr_bomb_beep":
		{
			if(getgametypesetting(#"silentplant") == 0)
			{
				self playsound(eventstruct.localclientnum, #"fly_bomb_buttons_npc");
			}
			break;
		}
	}
}

/*
	Name: codecallback_entityshutdown
	Namespace: callback
	Checksum: 0x4F13A14D
	Offset: 0x1A18
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event codecallback_entityshutdown(eventstruct)
{
	if(isdefined(level.callbackentityshutdown))
	{
		[[level.callbackentityshutdown]](eventstruct.localclientnum, eventstruct.entity);
	}
	eventstruct.entity entity_callback(#"on_entity_shutdown", eventstruct.localclientnum);
}

/*
	Name: codecallback_localclientshutdown
	Namespace: callback
	Checksum: 0x2D656B8C
	Offset: 0x1A98
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event codecallback_localclientshutdown(eventstruct)
{
	level.localplayers = getlocalplayers();
	eventstruct.entity callback(#"on_localclient_shutdown", eventstruct.localclientnum);
}

/*
	Name: codecallback_localclientchanged
	Namespace: callback
	Checksum: 0x99099AFE
	Offset: 0x1B00
	Size: 0x26
	Parameters: 1
	Flags: Event
*/
event codecallback_localclientchanged(eventstruct)
{
	level.localplayers = getlocalplayers();
}

/*
	Name: codecallback_airsupport
	Namespace: callback
	Checksum: 0xFC6DC267
	Offset: 0x1B30
	Size: 0xC4
	Parameters: 1
	Flags: Event
*/
event codecallback_airsupport(eventstruct)
{
	if(isdefined(level.callbackairsupport))
	{
		[[level.callbackairsupport]](eventstruct.localclientnum, eventstruct.location[0], eventstruct.location[1], eventstruct.location[2], eventstruct.type, eventstruct.yaw, eventstruct.team, eventstruct.team_faction, eventstruct.owner, eventstruct.exit_type, eventstruct.server_time, eventstruct.height);
	}
}

/*
	Name: codecallback_demojump
	Namespace: callback
	Checksum: 0xF777D5B8
	Offset: 0x1C00
	Size: 0x76
	Parameters: 1
	Flags: Event
*/
event codecallback_demojump(eventstruct)
{
	level notify(#"demo_jump", {#time:eventstruct.time});
	level notify("demo_jump" + eventstruct.localclientnum, {#time:eventstruct.time});
}

/*
	Name: codecallback_demoplayerswitch
	Namespace: callback
	Checksum: 0xC95BBF4C
	Offset: 0x1C80
	Size: 0x36
	Parameters: 1
	Flags: None
*/
function codecallback_demoplayerswitch(localclientnum)
{
	level notify(#"demo_player_switch");
	level notify("demo_player_switch" + localclientnum);
}

/*
	Name: codecallback_playerswitch
	Namespace: callback
	Checksum: 0x35ABBB32
	Offset: 0x1CC0
	Size: 0x3E
	Parameters: 1
	Flags: Event
*/
event codecallback_playerswitch(eventstruct)
{
	level notify(#"player_switch");
	level notify("player_switch" + eventstruct.localclientnum);
}

/*
	Name: codecallback_killcambegin
	Namespace: callback
	Checksum: 0x2DF54B70
	Offset: 0x1D08
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event codecallback_killcambegin(eventstruct)
{
	level notify(#"killcam_begin", {#time:eventstruct.time});
	level notify("killcam_begin" + eventstruct.localclientnum, {#time:eventstruct.time});
	level callback(#"killcam_begin", eventstruct);
}

/*
	Name: codecallback_killcamend
	Namespace: callback
	Checksum: 0x6D0CE8FD
	Offset: 0x1DB0
	Size: 0x9C
	Parameters: 1
	Flags: Event
*/
event codecallback_killcamend(eventstruct)
{
	level notify(#"killcam_end", {#time:eventstruct.time});
	level notify("killcam_end" + eventstruct.localclientnum, {#time:eventstruct.time});
	level callback(#"killcam_end", eventstruct);
}

/*
	Name: codecallback_creatingcorpse
	Namespace: callback
	Checksum: 0x84CB2122
	Offset: 0x1E58
	Size: 0x40
	Parameters: 1
	Flags: Event
*/
event codecallback_creatingcorpse(eventstruct)
{
	if(isdefined(level.callbackcreatingcorpse))
	{
		[[level.callbackcreatingcorpse]](eventstruct.localclientnum, eventstruct.player);
	}
}

/*
	Name: codecallback_activateexploder
	Namespace: callback
	Checksum: 0xD13F394B
	Offset: 0x1EA0
	Size: 0xCC
	Parameters: 1
	Flags: Event
*/
event codecallback_activateexploder(eventstruct)
{
	if(!isdefined(level._exploder_ids))
	{
		return;
	}
	exploder = undefined;
	foreach(k, v in level._exploder_ids)
	{
		if(v == eventstruct.exploder_id)
		{
			exploder = k;
			break;
		}
	}
	if(!isdefined(exploder))
	{
		return;
	}
	exploder::activate_exploder(exploder);
}

/*
	Name: codecallback_deactivateexploder
	Namespace: callback
	Checksum: 0xF64245E1
	Offset: 0x1F78
	Size: 0xCC
	Parameters: 1
	Flags: Event
*/
event codecallback_deactivateexploder(eventstruct)
{
	if(!isdefined(level._exploder_ids))
	{
		return;
	}
	exploder = undefined;
	foreach(k, v in level._exploder_ids)
	{
		if(v == eventstruct.exploder_id)
		{
			exploder = k;
			break;
		}
	}
	if(!isdefined(exploder))
	{
		return;
	}
	exploder::stop_exploder(exploder);
}

/*
	Name: codecallback_chargeshotweaponsoundnotify
	Namespace: callback
	Checksum: 0xA5174EA1
	Offset: 0x2050
	Size: 0x50
	Parameters: 1
	Flags: Event
*/
event codecallback_chargeshotweaponsoundnotify(eventstruct)
{
	if(isdefined(level.sndchargeshot_func))
	{
		self [[level.sndchargeshot_func]](eventstruct.localclientnum, eventstruct.weapon, eventstruct.chargeshotlevel);
	}
}

/*
	Name: codecallback_hostmigration
	Namespace: callback
	Checksum: 0x9D770ECF
	Offset: 0x20A8
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event codecallback_hostmigration(eventstruct)
{
	/#
		println("");
	#/
	if(isdefined(level.callbackhostmigration))
	{
		[[level.callbackhostmigration]](eventstruct.localclientnum);
	}
}

/*
	Name: codecallback_playaifootstep
	Namespace: callback
	Checksum: 0x8CB22230
	Offset: 0x2108
	Size: 0x54
	Parameters: 1
	Flags: Event
*/
event codecallback_playaifootstep(eventstruct)
{
	[[level.callbackplayaifootstep]](eventstruct.localclientnum, eventstruct.location, eventstruct.surface, eventstruct.notetrack, eventstruct.bone);
}

/*
	Name: codecallback_clientflag
	Namespace: callback
	Checksum: 0x466C70D7
	Offset: 0x2168
	Size: 0x48
	Parameters: 3
	Flags: None
*/
function codecallback_clientflag(localclientnum, flag, set)
{
	if(isdefined(level.callbackclientflag))
	{
		[[level.callbackclientflag]](localclientnum, flag, set);
	}
}

/*
	Name: codecallback_clientflagasval
	Namespace: callback
	Checksum: 0x1CBF10A0
	Offset: 0x21B8
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function codecallback_clientflagasval(localclientnum, val)
{
	if(isdefined(level._client_flagasval_callbacks) && isdefined(level._client_flagasval_callbacks[self.type]))
	{
		self thread [[level._client_flagasval_callbacks[self.type]]](localclientnum, val);
	}
}

/*
	Name: codecallback_extracamrendercurrentheroheadshot
	Namespace: callback
	Checksum: 0xAAE8C806
	Offset: 0x2220
	Size: 0x70
	Parameters: 1
	Flags: Event
*/
event codecallback_extracamrendercurrentheroheadshot(eventstruct)
{
	if(isdefined(level.extra_cam_render_current_hero_headshot_func_callback))
	{
		[[level.extra_cam_render_current_hero_headshot_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.is_defaulthero);
	}
}

/*
	Name: function_327732bf
	Namespace: callback
	Checksum: 0x2E5597C
	Offset: 0x2298
	Size: 0x94
	Parameters: 1
	Flags: Event
*/
event function_327732bf(eventstruct)
{
	if(isdefined(level.var_dda8e1d8))
	{
		[[level.var_dda8e1d8]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.character_index, eventstruct.var_7abdc6dd, eventstruct.item_type, eventstruct.item_index, eventstruct.is_defaultrender);
	}
}

/*
	Name: codecallback_extracamrendercharacterheaditem
	Namespace: callback
	Checksum: 0x5480E059
	Offset: 0x2338
	Size: 0x70
	Parameters: 1
	Flags: Event
*/
event codecallback_extracamrendercharacterheaditem(eventstruct)
{
	if(isdefined(level.extra_cam_render_character_head_item_func_callback))
	{
		[[level.extra_cam_render_character_head_item_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.head_index, eventstruct.is_default_render);
	}
}

/*
	Name: codecallback_extracamrendergender
	Namespace: callback
	Checksum: 0x1605FEAD
	Offset: 0x23B0
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event codecallback_extracamrendergender(eventstruct)
{
	if(isdefined(level.extra_cam_render_gender_func_callback))
	{
		[[level.extra_cam_render_gender_func_callback]](eventstruct.localclientnum, eventstruct.job_index, eventstruct.extracam_index, eventstruct.session_mode, eventstruct.gender);
	}
}

/*
	Name: codecallback_extracamrenderwcpaintjobicon
	Namespace: callback
	Checksum: 0x565DF3B7
	Offset: 0x2420
	Size: 0x88
	Parameters: 1
	Flags: Event
*/
event codecallback_extracamrenderwcpaintjobicon(eventstruct)
{
	if(isdefined(level.extra_cam_render_wc_paintjobicon_func_callback))
	{
		[[level.extra_cam_render_wc_paintjobicon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
	}
}

/*
	Name: codecallback_extracamrenderwcvarianticon
	Namespace: callback
	Checksum: 0xBDF8B650
	Offset: 0x24B0
	Size: 0x88
	Parameters: 1
	Flags: Event
*/
event codecallback_extracamrenderwcvarianticon(eventstruct)
{
	if(isdefined(level.extra_cam_render_wc_varianticon_func_callback))
	{
		[[level.extra_cam_render_wc_varianticon_func_callback]](eventstruct.localclientnum, eventstruct.extracam_index, eventstruct.job_index, eventstruct.weapon_options, eventstruct.weapon, eventstruct.loadout_slot, eventstruct.paintjob_slot, eventstruct.is_fileshare_preview);
	}
}

/*
	Name: codecallback_collectibleschanged
	Namespace: callback
	Checksum: 0xB43D8329
	Offset: 0x2540
	Size: 0x4C
	Parameters: 1
	Flags: Event
*/
event codecallback_collectibleschanged(eventstruct)
{
	if(isdefined(level.on_collectibles_change))
	{
		[[level.on_collectibles_change]](eventstruct.clientnum, eventstruct.collectibles, eventstruct.localclientnum);
	}
}

/*
	Name: add_weapon_type
	Namespace: callback
	Checksum: 0xF2510D3
	Offset: 0x2598
	Size: 0x5E
	Parameters: 2
	Flags: Linked
*/
function add_weapon_type(weapontype, callback)
{
	if(!isdefined(level.weapon_type_callback_array))
	{
		level.weapon_type_callback_array = [];
	}
	weapontype = getweapon(weapontype);
	level.weapon_type_callback_array[weapontype] = callback;
}

/*
	Name: spawned_weapon_type
	Namespace: callback
	Checksum: 0xC7E58C5F
	Offset: 0x2600
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function spawned_weapon_type(localclientnum)
{
	weapontype = self.weapon.rootweapon;
	if(isdefined(level.weapon_type_callback_array) && isdefined(level.weapon_type_callback_array[weapontype]))
	{
		self thread [[level.weapon_type_callback_array[weapontype]]](localclientnum);
	}
}

/*
	Name: function_cbfd8fd6
	Namespace: callback
	Checksum: 0x3890395D
	Offset: 0x2670
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_cbfd8fd6(localclientnum)
{
	namespace_bd02cf1::function_cbfd8fd6(localclientnum);
}

/*
	Name: codecallback_callclientscript
	Namespace: callback
	Checksum: 0xCC78FC23
	Offset: 0x26A0
	Size: 0xC6
	Parameters: 1
	Flags: Event
*/
event codecallback_callclientscript(eventstruct)
{
	if(!isdefined(level._animnotifyfuncs))
	{
		return;
	}
	if(isdefined(level._animnotifyfuncs[eventstruct.label]))
	{
		if(isdefined(eventstruct.param3) && eventstruct.param3 != "")
		{
			self [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
		}
		else
		{
			self [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
		}
	}
}

/*
	Name: codecallback_callclientscriptonlevel
	Namespace: callback
	Checksum: 0xA9629C5C
	Offset: 0x2770
	Size: 0xCE
	Parameters: 1
	Flags: Event
*/
event codecallback_callclientscriptonlevel(eventstruct)
{
	if(!isdefined(level._animnotifyfuncs))
	{
		return;
	}
	if(isdefined(level._animnotifyfuncs[eventstruct.label]))
	{
		if(isdefined(eventstruct.param3) && eventstruct.param3 != "")
		{
			level [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param, eventstruct.param3);
		}
		else
		{
			level [[level._animnotifyfuncs[eventstruct.label]]](eventstruct.param);
		}
	}
}

/*
	Name: function_2073f6dc
	Namespace: callback
	Checksum: 0x7A5EE7E0
	Offset: 0x2848
	Size: 0x174
	Parameters: 1
	Flags: Event
*/
event function_2073f6dc(eventstruct)
{
	origin = self.origin;
	magnitude = float(eventstruct.magnitude);
	innerradius = float(eventstruct.innerradius);
	outerradius = float(eventstruct.outerradius);
	var_489a8c6f = (isdefined(self.var_f501d778) ? self.var_f501d778 : 50);
	var_5143872f = (isdefined(self.var_e14c1b5c) ? self.var_e14c1b5c : 25);
	var_a62fd3ab = (isdefined(self.var_abe3f153) ? self.var_abe3f153 : 1);
	var_c1cde02b = (isdefined(self.var_bd0f9401) ? self.var_bd0f9401 : 1);
	physicsexplosionsphere(eventstruct.localclientnum, origin, outerradius, innerradius, magnitude, var_489a8c6f, var_5143872f, var_a62fd3ab, var_c1cde02b);
}

/*
	Name: codecallback_serversceneinit
	Namespace: callback
	Checksum: 0x390F1631
	Offset: 0x29C8
	Size: 0x44
	Parameters: 1
	Flags: Event
*/
event codecallback_serversceneinit(eventstruct)
{
	if(isdefined(level.server_scenes[eventstruct.scene_name]))
	{
		level thread scene::init(eventstruct.scene_name);
	}
}

/*
	Name: codecallback_serversceneplay
	Namespace: callback
	Checksum: 0x64D55DAE
	Offset: 0x2A18
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event codecallback_serversceneplay(eventstruct)
{
	level thread scene_black_screen();
	if(isdefined(level.server_scenes[eventstruct.scene_name]))
	{
		level thread scene::play(eventstruct.scene_name);
	}
}

/*
	Name: codecallback_serverscenestop
	Namespace: callback
	Checksum: 0xC9F4BA0A
	Offset: 0x2A80
	Size: 0x6C
	Parameters: 1
	Flags: Event
*/
event codecallback_serverscenestop(eventstruct)
{
	level thread scene_black_screen();
	if(isdefined(level.server_scenes[eventstruct.scene_name]))
	{
		level thread scene::stop(eventstruct.scene_name, undefined, undefined, undefined, 1);
	}
}

/*
	Name: scene_black_screen
	Namespace: callback
	Checksum: 0x80EC343B
	Offset: 0x2AF8
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function scene_black_screen()
{
	foreach(i, player in level.localplayers)
	{
		if(!isdefined(player.lui_black))
		{
			player.lui_black = createluimenu(i, "FullScreenBlack");
			openluimenu(i, player.lui_black);
		}
	}
	waitframe(1);
	foreach(i, player in level.localplayers)
	{
		if(isdefined(player.lui_black))
		{
			closeluimenu(i, player.lui_black);
			player.lui_black = undefined;
		}
	}
}

/*
	Name: codecallback_gadgetvisionpulse_reveal
	Namespace: callback
	Checksum: 0x5A8A1205
	Offset: 0x2C50
	Size: 0x4C
	Parameters: 1
	Flags: Event
*/
event codecallback_gadgetvisionpulse_reveal(eventstruct)
{
	if(isdefined(level.gadgetvisionpulse_reveal_func))
	{
		eventstruct.entity [[level.gadgetvisionpulse_reveal_func]](eventstruct.localclientnum, eventstruct.enable);
	}
}

/*
	Name: fade_to_black_for_x_sec
	Namespace: callback
	Checksum: 0x23795CD3
	Offset: 0x2CA8
	Size: 0x8C
	Parameters: 5
	Flags: Linked, Private
*/
private function fade_to_black_for_x_sec(startwait, blackscreenwait, fadeintime, fadeouttime, shadername)
{
	self endon(#"disconnect");
	wait(startwait);
	self lui::screen_fade_out(fadeintime, shadername);
	wait(blackscreenwait);
	if(isdefined(self))
	{
		self lui::screen_fade_in(fadeouttime, shadername);
	}
}

/*
	Name: codecallback_fadeblackscreen
	Namespace: callback
	Checksum: 0xD04B833D
	Offset: 0x2D40
	Size: 0x94
	Parameters: 1
	Flags: Event
*/
event codecallback_fadeblackscreen(eventstruct)
{
	if(isdefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55())
	{
		self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend, eventstruct.blend);
	}
}

/*
	Name: function_4b5ab05f
	Namespace: callback
	Checksum: 0xA1B5158F
	Offset: 0x2DE0
	Size: 0x94
	Parameters: 1
	Flags: Event
*/
event function_4b5ab05f(eventstruct)
{
	if(isdefined(self) && isplayer(self) && !isbot(self) && self function_21c0fa55())
	{
		self thread fade_to_black_for_x_sec(0, eventstruct.duration, eventstruct.blend_out, eventstruct.blend_in);
	}
}

/*
	Name: function_5067ee2f
	Namespace: callback
	Checksum: 0xC8D8120F
	Offset: 0x2E80
	Size: 0x4C
	Parameters: 1
	Flags: Event
*/
event function_5067ee2f(eventstruct)
{
	self animation::play_siege(eventstruct.anim_name, eventstruct.shot_name, eventstruct.rate, eventstruct.loop);
}

/*
	Name: function_fa19b45b
	Namespace: callback
	Checksum: 0x6E55CAC1
	Offset: 0x2ED8
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event function_fa19b45b(eventstruct)
{
	forcestreambundle(eventstruct.name, eventstruct.var_3c542760, eventstruct.var_a0e51075);
}

/*
	Name: function_582e112f
	Namespace: callback
	Checksum: 0x2EFD2643
	Offset: 0x2F20
	Size: 0x64
	Parameters: 1
	Flags: Event
*/
event function_582e112f(eventstruct)
{
	if(isdefined(level.var_45ca79e5))
	{
		[[level.var_45ca79e5]](eventstruct.localclientnum, eventstruct.eventtype, eventstruct.var_d8138db2, eventstruct.value, eventstruct.value2);
	}
}

/*
	Name: function_11988454
	Namespace: callback
	Checksum: 0x2E62F8E8
	Offset: 0x2F90
	Size: 0x34
	Parameters: 1
	Flags: Event
*/
event function_11988454(eventstruct)
{
	if(isdefined(level.var_a6c75fcb))
	{
		[[level.var_a6c75fcb]](eventstruct.var_85604f16);
	}
}

/*
	Name: function_6eb09118
	Namespace: callback
	Checksum: 0x8844CFFE
	Offset: 0x2FD0
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event function_6eb09118(eventstruct)
{
	if(isdefined(level.var_a6c75fcb))
	{
		self callback(#"hash_1bd0411eb5169b", eventstruct);
		self callback(#"hash_46d459e3750a3345", eventstruct);
		self function_3507ed1f("all");
	}
}

/*
	Name: function_5019e563
	Namespace: callback
	Checksum: 0x5F625169
	Offset: 0x3058
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event function_5019e563(eventstruct)
{
	self callback(#"freefall", eventstruct);
	self entity_callback(#"freefall", eventstruct.localclientnum, eventstruct);
}

/*
	Name: function_87b05fa3
	Namespace: callback
	Checksum: 0x9594AA6
	Offset: 0x30C0
	Size: 0x5C
	Parameters: 1
	Flags: Event
*/
event function_87b05fa3(eventstruct)
{
	self callback(#"parachute", eventstruct);
	self entity_callback(#"parachute", eventstruct.localclientnum, eventstruct);
}

/*
	Name: function_2eb17944
	Namespace: callback
	Checksum: 0x9C04A217
	Offset: 0x3128
	Size: 0x4C
	Parameters: 1
	Flags: Event
*/
event function_2eb17944(eventstruct)
{
	self callback(#"death", eventstruct);
	self entity_callback(#"death", eventstruct);
}

/*
	Name: function_40d9ce80
	Namespace: callback
	Checksum: 0xC019DDAC
	Offset: 0x3180
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_40d9ce80(eventstruct)
{
	self callback(#"melee", eventstruct);
}

/*
	Name: function_667f84de
	Namespace: callback
	Checksum: 0x65F51BC1
	Offset: 0x31B8
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_667f84de(eventstruct)
{
	self entity_callback(#"culled", eventstruct);
}

/*
	Name: function_6846a2b7
	Namespace: callback
	Checksum: 0xA60652A6
	Offset: 0x31F0
	Size: 0x6C
	Parameters: 1
	Flags: Event
*/
event function_6846a2b7(eventstruct)
{
	if(self function_21c0fa55())
	{
		level callback(#"weapon_change", eventstruct);
	}
	self callback(#"weapon_change", eventstruct);
}

/*
	Name: function_c33f3471
	Namespace: callback
	Checksum: 0xAD15E02C
	Offset: 0x3268
	Size: 0x6C
	Parameters: 1
	Flags: Event
*/
event function_c33f3471(eventstruct)
{
	if(self function_21c0fa55())
	{
		level callback(#"hash_4152cf6a61494581", eventstruct);
	}
	self callback(#"hash_4152cf6a61494581", eventstruct);
}

/*
	Name: function_ff9acfac
	Namespace: callback
	Checksum: 0x9ECC4447
	Offset: 0x32E0
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_ff9acfac(eventstruct)
{
	level callback(#"hash_2fc4cfecaed47583", eventstruct);
}

/*
	Name: function_a1ad9b51
	Namespace: callback
	Checksum: 0x703F9D6
	Offset: 0x3318
	Size: 0x7C
	Parameters: 1
	Flags: Event
*/
event function_a1ad9b51(eventstruct)
{
	if(self function_21c0fa55())
	{
		level callback(#"hash_12ca6e8bf50f11f5", eventstruct.localclientnum);
	}
	self callback(#"hash_12ca6e8bf50f11f5", eventstruct.localclientnum);
}

/*
	Name: function_fbeb26f6
	Namespace: callback
	Checksum: 0xE5CBC7B0
	Offset: 0x33A0
	Size: 0x3C
	Parameters: 1
	Flags: Event
*/
event function_fbeb26f6(eventstruct)
{
	self callback(#"hash_1d3c7b07ff527f3e", eventstruct.localclientnum, eventstruct);
}

/*
	Name: function_bc70e1e4
	Namespace: callback
	Checksum: 0x37CB44B0
	Offset: 0x33E8
	Size: 0x2C
	Parameters: 1
	Flags: Event
*/
event function_bc70e1e4(eventstruct)
{
	self callback(#"hash_6900f4ea0ff32c3e", eventstruct);
}

