// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1d29de500c266470;
#using script_348ce871561476c9;
#using script_4bf0b8603057e5ac;
#using script_55e622b35104ba68;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\match_record.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\mp_common\gametypes\spawning.gsc;

#namespace spawn;

/*
	Name: function_f468d9a5
	Namespace: spawn
	Checksum: 0xD2122EFE
	Offset: 0x1F8
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_f468d9a5(spawnpoint)
{
	distance = getdvarfloat(#"hash_69b296d9dc607a9a", 4350);
	height = getdvarfloat(#"hash_73c6222ce96fa34a", 5000);
	velocity = getdvarfloat(#"hash_ae6b05a24ae0d2a", 1760);
	dir = anglestoforward(spawnpoint.angles);
	pos = spawnpoint.origin - (dir * distance);
	hold_origin = (pos[0], pos[1], spawnpoint.origin[2] + height);
	hold_angles = vectortoangles(vectornormalize(spawnpoint.origin - pos));
	vec = anglestoforward(hold_angles);
	vec = vectornormalize(vec);
	vec = vec * velocity;
	return {#freefall:vec, #angles:hold_angles, #origin:hold_origin};
}

/*
	Name: function_e93291ff
	Namespace: spawn
	Checksum: 0x940329BB
	Offset: 0x3E0
	Size: 0x438
	Parameters: 0
	Flags: Linked
*/
function function_e93291ff()
{
	if(isdefined(level.var_1710ced9))
	{
		destinations = [[level.var_1710ced9]]();
	}
	else
	{
		destinations = struct::get_array("destination_influencer");
	}
	if(destinations.size <= 0)
	{
		return;
	}
	destinations = arraysortclosest(destinations, (0, 0, 0));
	for(var_bae3dcae = 0; var_bae3dcae < destinations.size; var_bae3dcae++)
	{
		destinations[var_bae3dcae].var_343828ba = var_bae3dcae;
	}
	level.var_7767cea8 = [];
	/#
		if(getdvarint(#"hash_270a21a654a1a79f", 0))
		{
			level.var_94cbd997 = [];
			foreach(destination in destinations)
			{
				level.var_94cbd997 = arraycombine(level.var_94cbd997, struct::get_array(destination.target, ""), 0, 0);
			}
		}
	#/
	foreach(dest in destinations)
	{
		if(dest.target === "hijacked")
		{
			arrayremovevalue(destinations, dest);
			break;
		}
	}
	var_137456fd = getdvarint(#"hash_400f07203191574f", -1);
	if(var_137456fd >= 0 && var_137456fd < destinations.size)
	{
		level.var_7767cea8[0] = destinations[var_137456fd];
		arrayremoveindex(destinations, var_137456fd);
	}
	else
	{
		while(destinations.size > 0 && level.var_7767cea8.size < 5)
		{
			var_bae3dcae = randomint(destinations.size);
			level.var_7767cea8[level.var_7767cea8.size] = destinations[var_bae3dcae];
			arrayremoveindex(destinations, var_bae3dcae);
		}
	}
	foreach(dest in level.var_7767cea8)
	{
		dest.spawns = struct::get_array(dest.target, "targetname");
	}
	foreach(dest in destinations)
	{
		function_3b1d0553(dest);
	}
}

/*
	Name: function_cb5864fc
	Namespace: spawn
	Checksum: 0x12D33907
	Offset: 0x820
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_cb5864fc()
{
	if(isdefined(level.var_7767cea8))
	{
		foreach(dest in level.var_7767cea8)
		{
			function_3b1d0553(dest);
		}
	}
}

/*
	Name: function_b76a2e3f
	Namespace: spawn
	Checksum: 0xB366675E
	Offset: 0x8B8
	Size: 0x4C8
	Parameters: 1
	Flags: Linked
*/
function function_b76a2e3f(ispredictedspawn)
{
	self.var_7070a94c = 0;
	if(infection::function_74650d7() && self infection::is_infected())
	{
		self infection::function_f488681f();
		return true;
	}
	if(!isdefined(level.var_7767cea8))
	{
		self function_8cef1872();
		return false;
	}
	if(level.var_7767cea8.size < 1)
	{
		self.resurrect_origin = (0, 0, 0);
		self.resurrect_angles = (0, 0, 0);
		self function_8cef1872();
		return true;
	}
	teammask = getteammask(self.team);
	teamindex = 0;
	while(teammask > 1)
	{
		teammask = teammask >> 1;
		teamindex++;
	}
	var_bae3dcae = teamindex % level.var_7767cea8.size;
	dest = level.var_7767cea8[var_bae3dcae];
	var_c1a973a4 = int(teamindex / level.var_7767cea8.size);
	var_92438b9c = (var_c1a973a4 * level.maxteamplayers) % dest.spawns.size;
	self.var_25fe2d03 = dest.var_343828ba;
	spawn = undefined;
	spawntime = gettime();
	if(ispredictedspawn)
	{
		spawn = dest.spawns[var_92438b9c];
	}
	else
	{
		if(!isdefined(dest.spawns[var_92438b9c].spawntime))
		{
			dest.spawns[var_92438b9c].spawntime = spawntime;
			spawn = dest.spawns[var_92438b9c];
		}
		else
		{
			var_f5bb80c2 = var_92438b9c;
			var_e34bb789 = dest.spawns[var_f5bb80c2].spawntime;
			for(idx = 0; idx < level.maxteamplayers; idx++)
			{
				spawnindex = (idx + var_92438b9c) % dest.spawns.size;
				if(!isdefined(dest.spawns[spawnindex].spawntime))
				{
					dest.spawns[spawnindex].spawntime = spawntime;
					spawn = dest.spawns[spawnindex];
					break;
					continue;
				}
				if(dest.spawns[spawnindex].spawntime < var_e34bb789)
				{
					var_f5bb80c2 = spawnindex;
					var_e34bb789 = dest.spawns[spawnindex].spawntime;
				}
			}
			if(!isdefined(spawn))
			{
				dest.spawns[var_f5bb80c2].spawntime = spawntime;
				spawn = dest.spawns[var_f5bb80c2];
			}
		}
	}
	if(getdvarint(#"hash_3d461f9c27bd2450", 1) > 0 && !isbot(self))
	{
		info = function_f468d9a5(spawn);
		self.resurrect_origin = info.origin;
		self.resurrect_angles = info.angles;
		self.var_df8c6469 = info.freefall;
		self.var_7070a94c = 1;
	}
	else
	{
		self.resurrect_origin = spawn.origin;
		self.resurrect_angles = spawn.angles;
		self.var_7070a94c = 0;
		self function_8cef1872();
		self thread function_bb9099b9();
	}
	return true;
}

/*
	Name: function_bb9099b9
	Namespace: spawn
	Checksum: 0x7B997133
	Offset: 0xD88
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_bb9099b9()
{
	self endon(#"disconnect");
	while(!self isstreamerready())
	{
		wait(0.5);
	}
	if(game.state == "pregame")
	{
		if(isdefined(level.var_fd167bf6))
		{
			self luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, level.var_5654073f);
		}
		else
		{
			self luinotifyevent(#"hash_2a9f7ecda8e925f6", 0);
		}
	}
}

/*
	Name: on_spawn_player
	Namespace: spawn
	Checksum: 0xFFD58764
	Offset: 0xE58
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function on_spawn_player(predictedspawn)
{
	self.usingobj = undefined;
	if(!isdefined(self.var_63af7f75))
	{
		self.var_63af7f75 = -1;
	}
	if(isdefined(level.var_52b56362))
	{
		self.var_63af7f75 = level.var_52b56362;
	}
	if(level.usestartspawns && !level.ingraceperiod && !level.playerqueuedrespawn)
	{
		level.usestartspawns = 0;
	}
	self.var_c5134737 = 0;
	spawning::onspawnplayer(predictedspawn);
	if(isdefined(self.var_25fe2d03))
	{
		self clientfield::set("StreamerSetSpawnHintIndex", self.var_25fe2d03);
	}
	if(self.pers[#"spawns"] == 1)
	{
		if(isdefined(self.var_7070a94c) && self.var_7070a94c && !namespace_67838d10::function_e5d4df1c())
		{
			self thread function_c263fd97();
		}
		else
		{
			self function_8cef1872();
		}
	}
	self function_ea62f5af();
}

/*
	Name: function_ea62f5af
	Namespace: spawn
	Checksum: 0x2B163D49
	Offset: 0xFD8
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_ea62f5af()
{
	var_a56604c5 = namespace_eb06e24d::function_4a22ec61().lootid;
	var_c9b1d229 = namespace_eb06e24d::function_4a39b434().lootid;
	var_42b02106 = namespace_eb06e24d::function_3c54cdb1().lootid;
	var_f8e6b703 = self match_record::get_player_stat(#"hash_ec4aea1a8bbd82");
	if(isdefined(var_f8e6b703))
	{
		self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4f557c87c0538129", var_a56604c5);
		self match_record::set_stat(#"lives", var_f8e6b703, #"hash_4b4bd85ab964d386", var_c9b1d229);
		self match_record::set_stat(#"lives", var_f8e6b703, #"hash_63862160f8335af2", var_42b02106);
	}
}

/*
	Name: function_8cef1872
	Namespace: spawn
	Checksum: 0x86C7F388
	Offset: 0x1120
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_8cef1872()
{
	if(isdefined(self.var_283bf712))
	{
		self.var_283bf712 delete();
		self.var_283bf712 = undefined;
	}
	self clientfield::set_player_uimodel("hudItems.wzLoadFinished", 1);
	self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", 1);
	self clientfield::set("ClearStreamerLoadingHints", 1);
	self val::reset(#"hash_5bb0dd6b277fc20c", "freezecontrols");
	self val::reset(#"hash_5bb0dd6b277fc20c", "disablegadgets");
	self callback::callback(#"hash_4fca7a48128c4741");
}

/*
	Name: function_c263fd97
	Namespace: spawn
	Checksum: 0x9331F3B
	Offset: 0x1230
	Size: 0x564
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c263fd97()
{
	level endon(#"hash_1c605a92cc507414");
	self endon(#"disconnect");
	self unlink();
	self.var_283bf712 = spawn("script_origin", self.resurrect_origin);
	self playerlinkto(self.var_283bf712);
	self setplayerangles(self.resurrect_angles);
	self setclientuivisibilityflag("weapon_hud_visible", 0);
	self ghost();
	self val::set(#"hash_5bb0dd6b277fc20c", "freezecontrols", 1);
	self val::set(#"hash_5bb0dd6b277fc20c", "disablegadgets", 1);
	var_80e2abb1 = getdvarfloat(#"hash_78198bd3a356f650", 0.5);
	starttime = gettime();
	var_ffa47239 = getdvarint(#"hash_24ce936622303dc1", 4000);
	var_2ee361bf = getdvarint(#"hash_6e24885f4fa8a2a2", 10000);
	/#
		println("");
	#/
	while(gettime() < starttime + var_ffa47239)
	{
		wait(0.5);
		now = gettime();
		self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", (now - starttime) / (var_ffa47239 + var_2ee361bf));
	}
	/#
		println("");
	#/
	var_4fcc3493 = (starttime + var_ffa47239) + var_2ee361bf;
	var_8cd82180 = getdvarint(#"hash_723f28907e9e4cd0", 3);
	var_45d7d746 = 0;
	var_ccb4a8be = namespace_4b76712::function_d2a1520c();
	streamermodelhint(var_ccb4a8be, (float(var_ffa47239 + var_2ee361bf)) / 1000);
	while(true)
	{
		wait(0.5);
		now = gettime();
		self clientfield::set_player_uimodel("hudItems.streamerLoadFraction", (now - starttime) / (var_ffa47239 + var_2ee361bf));
		if(now > var_4fcc3493)
		{
			/#
				println("");
			#/
			break;
		}
		stability = 1;
		if(isdefined(self.var_72d32640))
		{
			stability = self.var_72d32640;
		}
		if(self isstreamerready() && stability > var_80e2abb1)
		{
			var_45d7d746++;
		}
		else
		{
			var_45d7d746 = 0;
		}
		/#
			println("" + var_45d7d746);
		#/
		if(var_45d7d746 >= var_8cd82180)
		{
			/#
				println("");
			#/
			break;
		}
	}
	self unlink();
	self function_8cef1872();
	self setorigin(self.resurrect_origin);
	self show();
	self function_2ffa8aaf(1, self.var_df8c6469, 0);
	self.var_df8c6469 = undefined;
	if(game.state == "pregame")
	{
		if(isdefined(level.var_fd167bf6))
		{
			self luinotifyevent(#"create_prematch_timer", 2, level.var_fd167bf6, level.var_5654073f);
		}
		else
		{
			self luinotifyevent(#"hash_2a9f7ecda8e925f6", 0);
		}
	}
}

/*
	Name: function_3b1d0553
	Namespace: spawn
	Checksum: 0xE04F7D11
	Offset: 0x17A0
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3b1d0553(dest)
{
	targets = struct::get_array(dest.target, "targetname");
	foreach(target in targets)
	{
		function_178abfd(target);
	}
	function_178abfd(dest);
}

/*
	Name: function_178abfd
	Namespace: spawn
	Checksum: 0x75CB4D3B
	Offset: 0x1870
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_178abfd(struct)
{
	if(!isarray(level.struct))
	{
		return;
	}
	foreach(i, val in level.struct)
	{
		if(val === struct)
		{
			level.struct[i] = undefined;
			return;
		}
	}
}

/*
	Name: function_1390f875
	Namespace: spawn
	Checksum: 0x9CD465A0
	Offset: 0x1928
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_1390f875(num_lives)
{
	var_c6328f73 = self.pers[#"lives"] - 1;
	if(var_c6328f73 < 0)
	{
		var_c6328f73 = 0;
	}
	self clientfield::set_player_uimodel("hudItems.playerLivesRemaining", var_c6328f73);
}

