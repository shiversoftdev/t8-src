// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2dc48f46bfeac894;
#using script_47fb62300ac0bd60;
#using script_57f7003580bb15e0;
#using script_6c8abe14025b47c4;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\scoreevents_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_94f334ac;

/*
	Name: init_shared
	Namespace: namespace_94f334ac
	Checksum: 0x2D31390D
	Offset: 0x528
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function init_shared()
{
	ability_player::register_gadget_should_notify(8, 1);
	function_2aec10d2();
	registerclientfields();
	setupcallbacks();
}

/*
	Name: function_2aec10d2
	Namespace: namespace_94f334ac
	Checksum: 0xCCC8148
	Offset: 0x580
	Size: 0x66
	Parameters: 0
	Flags: Private
*/
function private function_2aec10d2()
{
	if(!isdefined(level.var_2790ddf8))
	{
		level.var_2790ddf8 = spawnstruct();
	}
	if(!isdefined(level.var_ff6f539f))
	{
		level.var_ff6f539f = [];
	}
	if(!isdefined(level.var_fdb0a658))
	{
		level.var_fdb0a658 = 0;
	}
}

/*
	Name: setupcallbacks
	Namespace: namespace_94f334ac
	Checksum: 0xEE64BB81
	Offset: 0x5F0
	Size: 0x14C
	Parameters: 0
	Flags: Private
*/
function private setupcallbacks()
{
	level.var_1b900c1d = &function_1b900c1d;
	level.var_14151f16 = &function_14151f16;
	level.var_f1edf93f = &function_3e3330bc;
	callback::on_player_killed_with_params(&on_player_killed);
	callback::on_connect(&onplayerconnect);
	callback::on_spawned(&onplayerspawned);
	callback::on_joined_team(&onplayerjoinedteam);
	callback::on_disconnect(&onplayerdisconnect);
	callback::add_callback(#"hash_4acc79bbf6402a39", &function_d3805306);
	ability_player::register_gadget_activation_callbacks(8, &gadget_icepick_on, &gadget_icepick_off);
}

/*
	Name: registerclientfields
	Namespace: namespace_94f334ac
	Checksum: 0xE49F4AC0
	Offset: 0x748
	Size: 0x32C
	Parameters: 0
	Flags: Private
*/
function private registerclientfields()
{
	clientfield::register("toplayer", "gadget_icepick_on", 9000, 1, "int");
	clientfield::register("toplayer", "currentlyHacking", 9000, 1, "int");
	clientfield::register("toplayer", "hackedvehpostfx", 9000, 1, "int");
	clientfield::register("toplayer", "currentlybeinghackedplayer", 9000, 4, "int");
	clientfield::function_a8bbc967("IcePickInfo.hackStarted", 9000, 1, "int", 0);
	clientfield::function_a8bbc967("IcePickInfo.hackFinished", 9000, 1, "int", 0);
	clientfield::function_a8bbc967("IcePickInfo.hackEquipFinished", 9000, 1, "int", 0);
	clientfield::function_a8bbc967("IcePickInfo.hackVehicleFinished", 9000, 1, "int", 0);
	clientfield::function_a8bbc967("hudItems.hacked", 9000, 1, "int", 0);
	clientfield::function_a8bbc967("hudItems.hackedRebootProgress", 9000, 5, "float", 0);
	clientfield::function_a8bbc967("IcePickInfo.currentHackProgress", 9000, 5, "float", 0);
	clientfield::register("missile", "cant_be_hacked", 9000, 1, "int");
	clientfield::register("vehicle", "cant_be_hacked", 9000, 1, "int");
	clientfield::register("scriptmover", "cant_be_hacked", 9000, 1, "int");
	clientfield::register("scriptmover", "hackStatus", 9000, 2, "int");
	clientfield::register("missile", "hackStatus", 9000, 2, "int");
	clientfield::register("vehicle", "hackStatus", 9000, 2, "int");
	clientfield::register("allplayers", "hackStatus", 9000, 2, "int");
}

/*
	Name: function_3e3330bc
	Namespace: namespace_94f334ac
	Checksum: 0x7EA9B280
	Offset: 0xA80
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function function_3e3330bc()
{
	var_51d5c26f = function_13f4415c();
	return true;
}

/*
	Name: function_9497a4f3
	Namespace: namespace_94f334ac
	Checksum: 0x63166FD
	Offset: 0xAC8
	Size: 0xC
	Parameters: 1
	Flags: Event
*/
event function_9497a4f3(eventstruct)
{
}

/*
	Name: function_c18360f6
	Namespace: namespace_94f334ac
	Checksum: 0xB68F1D3
	Offset: 0xAE0
	Size: 0x2B4
	Parameters: 2
	Flags: Private
*/
function private function_c18360f6(var_11a83c3a, params)
{
	if(!isdefined(params))
	{
		return;
	}
	if(!isdefined(params.eattacker))
	{
		return;
	}
	var_8b745faa = getweapon(#"gadget_icepick");
	if(isdefined(var_11a83c3a.var_e2131267) && var_11a83c3a.var_e2131267 == params.eattacker)
	{
		scoreevents::processscoreevent(#"hash_338be289e9131b56", var_11a83c3a.var_e2131267, undefined, var_8b745faa);
		params.eattacker function_be7a08a8(var_8b745faa, 1);
		time = gettime();
		if(!isdefined(params.eattacker.var_7b9616d6))
		{
			params.eattacker.var_7b9616d6 = time;
		}
		if(!isdefined(params.eattacker.var_bcae5314))
		{
			params.eattacker.var_bcae5314 = 0;
		}
		if(params.eattacker.var_7b9616d6 + 4000 < time)
		{
			params.eattacker.var_bcae5314 = 0;
		}
		params.eattacker.var_bcae5314++;
		params.eattacker.var_7b9616d6 = time;
		if(params.eattacker.var_bcae5314 == 2)
		{
			scoreevents::processscoreevent(#"hash_e18a9f29b8e1132", var_11a83c3a.var_e2131267, undefined, var_8b745faa);
			params.eattacker.var_bcae5314 = 0;
		}
	}
	else if(isdefined(var_11a83c3a.var_e2131267.team) && isdefined(params.eattacker.team) && var_11a83c3a.var_e2131267.team == params.eattacker.team)
	{
		scoreevents::processscoreevent(#"hash_634954a0bb90b72d", var_11a83c3a.var_e2131267, undefined, var_8b745faa);
	}
}

/*
	Name: function_a5b83ede
	Namespace: namespace_94f334ac
	Checksum: 0xF1FC7366
	Offset: 0xDA0
	Size: 0x208
	Parameters: 2
	Flags: Private
*/
function private function_a5b83ede(hacker, var_11a83c3a)
{
	if(!isdefined(hacker) || !isdefined(var_11a83c3a))
	{
		return;
	}
	var_51d5c26f = function_13f4415c();
	var_be75e624 = (isdefined(var_51d5c26f.var_cd8eae22) ? var_51d5c26f.var_cd8eae22 : 0);
	var_696beab8 = (isdefined(var_51d5c26f.var_51593b) ? var_51d5c26f.var_51593b : 0);
	if(!var_be75e624 && !var_696beab8)
	{
		return;
	}
	if((isdefined(var_51d5c26f.var_4ffa4f3c) ? var_51d5c26f.var_4ffa4f3c : 0))
	{
		if((isdefined(hacker.var_c269451a) ? hacker.var_c269451a : 0))
		{
			return;
		}
		hacker.var_c269451a = 1;
	}
	scoreevents::processscoreevent("hacker_shutdown", var_11a83c3a, hacker);
	if(!var_696beab8 || !level.teambased)
	{
		thread function_27c9bfc8(var_11a83c3a, 1);
	}
	else if(var_696beab8)
	{
		foreach(player in getplayers(var_11a83c3a.team))
		{
			thread function_27c9bfc8(player, 1);
		}
	}
}

/*
	Name: function_5e9bb390
	Namespace: namespace_94f334ac
	Checksum: 0xDEC678B4
	Offset: 0xFB0
	Size: 0x62
	Parameters: 2
	Flags: Private
*/
function private function_5e9bb390(hacker, var_11a83c3a)
{
	function_a5b83ede(hacker, var_11a83c3a);
	if(isdefined(hacker.var_e989badb))
	{
		hacker.var_e989badb notify(#"hash_2476803a0d5fa572");
	}
	hacker.var_e989badb = undefined;
}

/*
	Name: on_player_killed
	Namespace: namespace_94f334ac
	Checksum: 0xAC6833C2
	Offset: 0x1020
	Size: 0x15C
	Parameters: 1
	Flags: None
*/
function on_player_killed(params)
{
	if((isdefined(self.ishacked) ? self.ishacked : 0) && isdefined(self.var_e2131267))
	{
		function_c18360f6(self, params);
	}
	if(isdefined(params) && isdefined(params.eattacker) && isdefined(params.eattacker.var_e2131267))
	{
		if(params.eattacker.var_e2131267 == self)
		{
			function_5e9bb390(self, params.eattacker);
		}
	}
	if(isdefined(self.var_c1911c44) && self.var_c1911c44)
	{
		if(isdefined(self.var_982faa7c) && isplayer(self.var_982faa7c))
		{
			self.var_982faa7c clientfield::set_to_player("hackedvehpostfx", 0);
		}
		if(isdefined(params.eattacker))
		{
			scoreevents::processscoreevent("ice_pick_shutdown", params.eattacker, self);
		}
	}
}

/*
	Name: onplayerspawned
	Namespace: namespace_94f334ac
	Checksum: 0x6D7B43CD
	Offset: 0x1188
	Size: 0x3C
	Parameters: 0
	Flags: None
*/
function onplayerspawned()
{
	if((isdefined(self.ishacked) ? self.ishacked : 0))
	{
		thread function_39026c34(self.var_e2131267, self, 0);
	}
}

/*
	Name: onplayerconnect
	Namespace: namespace_94f334ac
	Checksum: 0xDCD8AF2E
	Offset: 0x11D0
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function onplayerconnect()
{
	self thread function_c1d2f9aa();
}

/*
	Name: function_c1d2f9aa
	Namespace: namespace_94f334ac
	Checksum: 0xDF1B4627
	Offset: 0x11F8
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_c1d2f9aa()
{
	self endon(#"death", #"disconnect");
	self flagsys::wait_till(#"loadout_given");
	self ability_player::function_c9b950e3();
}

/*
	Name: function_1b900c1d
	Namespace: namespace_94f334ac
	Checksum: 0x688EC111
	Offset: 0x1268
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function function_1b900c1d(weapon, var_5651313e)
{
	if(!isdefined(level.var_ff6f539f))
	{
		level.var_ff6f539f = [];
	}
	level.var_ff6f539f[weapon.name] = var_5651313e;
}

/*
	Name: function_d3805306
	Namespace: namespace_94f334ac
	Checksum: 0x85FB751E
	Offset: 0x12C8
	Size: 0x82
	Parameters: 1
	Flags: None
*/
function function_d3805306(var_756fda07)
{
	if(!(isdefined(self.var_1f5ab061) && self.var_1f5ab061))
	{
		return;
	}
	if(!isdefined(var_756fda07))
	{
		return;
	}
	switch(var_756fda07.var_67e2281d)
	{
		case 1:
		case 5:
		{
			function_6c031486(self);
			break;
		}
	}
}

/*
	Name: onplayerjoinedteam
	Namespace: namespace_94f334ac
	Checksum: 0x6B70ED34
	Offset: 0x1358
	Size: 0x7C
	Parameters: 1
	Flags: None
*/
function onplayerjoinedteam(params)
{
	if(isdefined(self.ishacked) && self.ishacked)
	{
		if(isdefined(self.var_e2131267) && self.var_e2131267.team == self.team)
		{
			function_27c9bfc8(self, 0);
		}
	}
	function_ea2dfad6(self);
}

/*
	Name: function_92fb8327
	Namespace: namespace_94f334ac
	Checksum: 0xC2D33ADF
	Offset: 0x13E0
	Size: 0x24
	Parameters: 1
	Flags: None
*/
function function_92fb8327(params)
{
	function_ea2dfad6(self);
}

/*
	Name: onplayerdisconnect
	Namespace: namespace_94f334ac
	Checksum: 0xBAA29E8F
	Offset: 0x1410
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function onplayerdisconnect()
{
	function_ea2dfad6(self);
}

/*
	Name: function_70ed4baf
	Namespace: namespace_94f334ac
	Checksum: 0x9997C464
	Offset: 0x1438
	Size: 0xB6
	Parameters: 1
	Flags: Private
*/
function private function_70ed4baf(entity)
{
	if(isdefined(entity.identifier_weapon))
	{
		return entity.identifier_weapon;
	}
	if(isdefined(entity.weapon))
	{
		return entity.weapon;
	}
	if(isdefined(entity.var_22a05c26) && isdefined(entity.var_22a05c26.var_1ab696c6))
	{
		return entity.var_22a05c26.var_1ab696c6;
	}
	if(isdefined(entity.defaultweapon))
	{
		return entity.defaultweapon;
	}
	return level.weaponnone;
}

/*
	Name: function_14151f16
	Namespace: namespace_94f334ac
	Checksum: 0x4F53A847
	Offset: 0x14F8
	Size: 0x46
	Parameters: 2
	Flags: None
*/
function function_14151f16(entity, canhack)
{
	entity clientfield::set("cant_be_hacked", !canhack);
	entity.var_52a68abf = !canhack;
}

/*
	Name: function_808efdee
	Namespace: namespace_94f334ac
	Checksum: 0x478E7B22
	Offset: 0x1548
	Size: 0x152
	Parameters: 2
	Flags: Private
*/
function private function_808efdee(hacker, entity)
{
	var_45b1bb5a = function_70ed4baf(entity);
	if(!isdefined(var_45b1bb5a) || var_45b1bb5a == level.weaponnone && !isplayer(entity))
	{
		return false;
	}
	if(entity.team == hacker.team)
	{
		return false;
	}
	if(entity.team == #"spectator")
	{
		return false;
	}
	if(isdefined(entity.var_52a68abf) && entity.var_52a68abf)
	{
		return false;
	}
	if(!isplayer(entity) && !var_45b1bb5a.ishackable)
	{
		return false;
	}
	if(isdefined(entity.ishacked) && entity.ishacked && !isplayer(entity))
	{
		return false;
	}
	return true;
}

/*
	Name: function_8d50c205
	Namespace: namespace_94f334ac
	Checksum: 0x26723349
	Offset: 0x16A8
	Size: 0xE8
	Parameters: 2
	Flags: None
*/
function function_8d50c205(left, right)
{
	var_93633a81 = function_70ed4baf(left);
	var_84792f3e = function_70ed4baf(right);
	if(isplayer(left) || isplayer(right) || var_93633a81.var_8134b209 == var_84792f3e.var_8134b209)
	{
		return left getentitynumber() < right getentitynumber();
	}
	return var_93633a81.var_8134b209 < var_84792f3e.var_8134b209;
}

/*
	Name: function_ab1f58d0
	Namespace: namespace_94f334ac
	Checksum: 0x508FDFF5
	Offset: 0x1798
	Size: 0x8E
	Parameters: 1
	Flags: None
*/
function function_ab1f58d0(entity)
{
	var_45b1bb5a = function_70ed4baf(entity);
	if(isplayer(entity))
	{
		var_51d5c26f = function_13f4415c();
		return var_51d5c26f.var_4d1cd723;
	}
	if(isdefined(var_45b1bb5a))
	{
		return var_45b1bb5a.var_19f920eb;
	}
	return 0;
}

/*
	Name: function_39d1ce95
	Namespace: namespace_94f334ac
	Checksum: 0xD78E7E55
	Offset: 0x1830
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_39d1ce95(entity, var_45b1bb5a)
{
	if(!isdefined(var_45b1bb5a.name))
	{
		return;
	}
	switch(var_45b1bb5a.name)
	{
		case "supplydrop":
		{
			if(isdefined(level.cratemodelfriendly))
			{
				streamermodelhint(level.cratemodelfriendly, 10);
			}
			if(isdefined(level.cratemodelenemy))
			{
				streamermodelhint(level.cratemodelenemy, 10);
			}
			break;
		}
	}
}

/*
	Name: function_6c031486
	Namespace: namespace_94f334ac
	Checksum: 0x184F8263
	Offset: 0x18F0
	Size: 0xAC
	Parameters: 1
	Flags: None
*/
function function_6c031486(hacker)
{
	if(!isdefined(hacker))
	{
		return;
	}
	var_8b745faa = getweapon(#"gadget_icepick");
	hacker notify(#"hash_7b4714f415b8f49e");
	var_3e361f1a = hacker gadgetgetslot(var_8b745faa);
	hacker gadgetdeactivate(var_3e361f1a, var_8b745faa);
	hacker switchtoweapon();
}

/*
	Name: function_13f4415c
	Namespace: namespace_94f334ac
	Checksum: 0xC799A9DB
	Offset: 0x19A8
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function function_13f4415c()
{
	var_8b745faa = getweapon(#"gadget_icepick");
	return getscriptbundle(var_8b745faa.var_4dd46f8a);
}

/*
	Name: function_73d5db3b
	Namespace: namespace_94f334ac
	Checksum: 0xC41C7A01
	Offset: 0x1A00
	Size: 0x2A4
	Parameters: 1
	Flags: Private
*/
function private function_73d5db3b(player)
{
	player.var_be9a0b4b = [];
	player.var_be9a0b4b[0] = getplayers();
	function_d65b8dbe(player.var_be9a0b4b[0], &function_8d50c205);
	player.var_be9a0b4b[1] = [];
	player.var_be9a0b4b[2] = [];
	foreach(entity in function_c0757a13())
	{
		var_45b1bb5a = function_70ed4baf(entity);
		if(var_45b1bb5a.var_a8bd8bb2 > 0)
		{
			if(!isdefined(player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2]))
			{
				player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2] = [];
			}
			else if(!isarray(player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2]))
			{
				player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2] = array(player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2]);
			}
			player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2][player.var_be9a0b4b[var_45b1bb5a.var_a8bd8bb2].size] = entity;
			function_39d1ce95(entity, var_45b1bb5a);
		}
	}
	function_f1f877e0(player.var_be9a0b4b[1], &function_8d50c205);
	sort_vehicles(player.var_be9a0b4b[2], &function_8d50c205);
}

/*
	Name: function_d65b8dbe
	Namespace: namespace_94f334ac
	Checksum: 0x1F6C0CD6
	Offset: 0x1CB0
	Size: 0x2C
	Parameters: 2
	Flags: Private
*/
function private function_d65b8dbe(array, sort_func)
{
	array::function_b63fcb3(array, sort_func);
}

/*
	Name: function_f1f877e0
	Namespace: namespace_94f334ac
	Checksum: 0x15AAE6FD
	Offset: 0x1CE8
	Size: 0x2C
	Parameters: 2
	Flags: Private
*/
function private function_f1f877e0(array, sort_func)
{
	array::function_b63fcb3(array, sort_func);
}

/*
	Name: sort_vehicles
	Namespace: namespace_94f334ac
	Checksum: 0x60F3B2DB
	Offset: 0x1D20
	Size: 0x2C
	Parameters: 2
	Flags: Private
*/
function private sort_vehicles(array, sort_func)
{
	array::function_b63fcb3(array, sort_func);
}

/*
	Name: function_7f0dadf5
	Namespace: namespace_94f334ac
	Checksum: 0xF06C75C2
	Offset: 0x1D58
	Size: 0x522
	Parameters: 1
	Flags: Private
*/
function private function_7f0dadf5(player)
{
	player endoncallback(&function_4802ca63, #"death", #"hash_7b4714f415b8f49e");
	level.var_fdb0a658 = 1;
	player clientfield::set_player_uimodel("IcePickInfo.hackStarted", 1);
	var_8b745faa = getweapon(#"gadget_icepick");
	var_3e361f1a = player gadgetgetslot(var_8b745faa);
	player gadgetpowerset(var_3e361f1a, 0);
	player.var_c269451a = 0;
	player.var_86f63ff1 = 0;
	player.var_639e4be8 = 0;
	thread function_b76c8353(player);
	player clientfield::set_to_player("currentlyHacking", 1);
	if(isdefined(level.heroplaydialog))
	{
		player thread [[level.heroplaydialog]]("icePickWeaponUse", 2);
		if(isdefined(level.var_9082a3b6))
		{
			player thread [[level.var_9082a3b6]]("icePickWeaponUseFutz");
		}
	}
	if(level.teambased)
	{
		if(isdefined(level.var_57e2bc08))
		{
			thread [[level.var_57e2bc08]]("hackingStarted", util::getotherteam(self.team));
		}
	}
	else if(isdefined(level.playleaderdialogonplayer))
	{
		foreach(enemyplayer in level.players)
		{
			if(enemyplayer == self)
			{
				continue;
			}
			enemyplayer thread [[level.playleaderdialogonplayer]]("hackingStarted");
		}
	}
	player.var_c1911c44 = 1;
	thread function_d1f6e8d0(player);
	var_51d5c26f = function_13f4415c();
	var_891378ce = (isdefined(var_51d5c26f.var_a65e249e) ? var_51d5c26f.var_a65e249e : 0);
	function_aaf0a382(player.var_be9a0b4b[1], player, var_891378ce);
	player clientfield::set_player_uimodel("IcePickInfo.hackEquipFinished", 1);
	function_aaf0a382(player.var_be9a0b4b[2], player, var_891378ce);
	player clientfield::set_player_uimodel("IcePickInfo.hackVehicleFinished", 1);
	function_aaf0a382(player.var_be9a0b4b[0], player);
	player clientfield::set_player_uimodel("IcePickInfo.hackFinished", 1);
	player clientfield::set_to_player("currentlybeinghackedplayer", -2);
	wait(0.75);
	if(!isdefined(player))
	{
		return;
	}
	var_8b745faa = getweapon(#"gadget_icepick");
	var_3e361f1a = player gadgetgetslot(var_8b745faa);
	player gadgetdeactivate(var_3e361f1a, var_8b745faa);
	player switchtoweapon();
	player.var_c1911c44 = 0;
	level.var_fdb0a658 = 0;
	if(isdefined(player.var_86f63ff1) && isdefined(level.playgadgetsuccess) && isdefined(level.var_ac6052e9))
	{
		var_9194a036 = [[level.var_ac6052e9]]("icePickHackSuccessLineCount", 1);
		if(player.var_86f63ff1 >= (isdefined(var_9194a036) ? var_9194a036 : 1))
		{
			player [[level.playgadgetsuccess]](var_8b745faa);
		}
	}
	player.var_86f63ff1 = undefined;
	player.var_639e4be8 = undefined;
}

/*
	Name: function_aaf0a382
	Namespace: namespace_94f334ac
	Checksum: 0xFC59C02C
	Offset: 0x2288
	Size: 0x158
	Parameters: 3
	Flags: Private
*/
function private function_aaf0a382(entities, player, max)
{
	player endon(#"death", #"hash_7b4714f415b8f49e");
	var_e8e3cc00 = 0;
	foreach(entity in entities)
	{
		if(!isdefined(entity))
		{
			continue;
		}
		if(!function_808efdee(player, entity))
		{
			continue;
		}
		if(!isplayer(entity))
		{
			var_45b1bb5a = function_70ed4baf(entity);
			var_e8e3cc00 = var_e8e3cc00 + var_45b1bb5a.var_df381b5d;
		}
		if(isdefined(max) && var_e8e3cc00 > max)
		{
			break;
		}
		function_2b2ed159(entity, player);
	}
}

/*
	Name: function_2b2ed159
	Namespace: namespace_94f334ac
	Checksum: 0xF076C1B5
	Offset: 0x23E8
	Size: 0x65C
	Parameters: 2
	Flags: Private
*/
function private function_2b2ed159(entity, var_dbd1a594)
{
	var_dbd1a594 endon(#"death", #"hash_7b4714f415b8f49e");
	var_87bdc7d3 = int(function_ab1f58d0(entity) * 1000);
	var_7570395 = 0;
	var_dbd1a594.var_e989badb = entity;
	if(isplayer(entity))
	{
		entity clientfield::set("hackStatus", 1);
		var_dbd1a594 clientfield::set_to_player("currentlybeinghackedplayer", entity getentitynumber());
	}
	else
	{
		entity clientfield::set("hackStatus", 1);
		var_45b1bb5a = function_70ed4baf(entity);
		if(!isdefined(var_45b1bb5a))
		{
			return;
		}
		originalowner = entity.owner;
		if(isdefined(originalowner) && var_45b1bb5a.var_775d2aad === 1)
		{
			thread function_4a82368f(entity, originalowner);
			var_dbd1a594.var_982faa7c = originalowner;
			var_7570395 = 1;
		}
	}
	if(randomint(100) <= 50)
	{
		if(isdefined(level.var_e2fff792))
		{
			var_dbd1a594 [[level.var_e2fff792]]("icePickWeaponHackStart", var_dbd1a594);
		}
	}
	var_3d69d460 = 0;
	lasttime = gettime();
	var_9b4cc45c = gettime();
	while(var_3d69d460 < var_87bdc7d3 && var_87bdc7d3 > 0)
	{
		if(!isdefined(entity) || (isdefined(entity.leaving) && entity.leaving))
		{
			if(isdefined(entity))
			{
				function_14151f16(entity, 0);
			}
			break;
		}
		var_50c86c4 = var_3d69d460 / var_87bdc7d3;
		var_dbd1a594 clientfield::set_player_uimodel("IcePickInfo.currentHackProgress", var_50c86c4);
		timediff = gettime() - lasttime;
		var_3d69d460 = var_3d69d460 + (timediff * (isdefined(var_dbd1a594.var_6704e6fa) ? var_dbd1a594.var_6704e6fa : 1));
		lasttime = gettime();
		waitframe(1);
	}
	var_e92132fd = gettime();
	if(!isdefined(entity) || !isdefined(var_dbd1a594) || (isdefined(entity.var_52a68abf) && entity.var_52a68abf))
	{
		if(var_7570395)
		{
			if(isdefined(originalowner) && isplayer(originalowner))
			{
				originalowner clientfield::set_to_player("hackedvehpostfx", 0);
			}
			var_dbd1a594.var_982faa7c = undefined;
		}
		return;
	}
	var_dbd1a594 clientfield::set_player_uimodel("IcePickInfo.currentHackProgress", 1);
	entity clientfield::set("hackStatus", 2);
	var_dbd1a594 playsoundtoplayer(#"hash_fc83e70c477029c", var_dbd1a594);
	entity notify(#"hash_2476803a0d5fa572");
	var_dbd1a594.var_982faa7c = undefined;
	if(!isdefined(var_dbd1a594.var_86f63ff1))
	{
		var_dbd1a594.var_86f63ff1 = 0;
	}
	var_dbd1a594.var_86f63ff1++;
	if(isplayer(entity))
	{
		targetname = #"player";
		playernum = entity.entnum;
		thread function_39026c34(var_dbd1a594, entity, 1);
	}
	else
	{
		var_45b1bb5a = function_70ed4baf(entity);
		if(isdefined(var_45b1bb5a) && isdefined(var_45b1bb5a.name) && isdefined(entity.owner) && entity.owner getentitynumber())
		{
			targetname = var_45b1bb5a.name;
			playernum = entity.owner getentitynumber();
		}
		thread function_29f4ff02(var_dbd1a594, entity);
	}
	var_dbd1a594.var_e989badb = undefined;
	var_46df240b = var_e92132fd - var_9b4cc45c;
	if(isdefined(targetname) && isdefined(playernum))
	{
		var_6c52b424 = {#hack_success:1, #duration:var_46df240b, #hash_e7f6239c:playernum, #hash_ad937df6:targetname, #hash_a9451146:var_dbd1a594.var_c48b30ab, #hash_5f512560:var_dbd1a594 getmatchrecordlifeindex()};
		function_92d1707f(#"hash_3c946cbb149411ad", var_6c52b424);
	}
}

/*
	Name: function_4802ca63
	Namespace: namespace_94f334ac
	Checksum: 0x909A0AA3
	Offset: 0x2A50
	Size: 0x146
	Parameters: 1
	Flags: None
*/
function function_4802ca63(str_notify)
{
	if(str_notify != #"hash_7b4714f415b8f49e" || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	self clientfield::set_player_uimodel("IcePickInfo.hackFinished", 1);
	var_8b745faa = getweapon(#"gadget_icepick");
	var_3e361f1a = self gadgetgetslot(var_8b745faa);
	self gadgetdeactivate(var_3e361f1a, var_8b745faa);
	self.var_c1911c44 = 0;
	level.var_fdb0a658 = 0;
	if(isdefined(self.var_982faa7c) && isplayer(self.var_982faa7c))
	{
		self.var_982faa7c clientfield::set_to_player("hackedvehpostfx", 0);
		self.var_982faa7c = undefined;
	}
}

/*
	Name: function_4a82368f
	Namespace: namespace_94f334ac
	Checksum: 0x6038CEA2
	Offset: 0x2BA0
	Size: 0xDC
	Parameters: 2
	Flags: None
*/
function function_4a82368f(entity, owner)
{
	/#
		assert(isdefined(owner));
	#/
	if(isplayer(owner))
	{
		owner clientfield::set_to_player("hackedvehpostfx", 1);
	}
	entity waittill(#"death", #"remote_weapon_end", #"hash_2476803a0d5fa572");
	if(!isdefined(owner))
	{
		return;
	}
	if(isplayer(owner))
	{
		owner clientfield::set_to_player("hackedvehpostfx", 0);
	}
}

/*
	Name: function_29f4ff02
	Namespace: namespace_94f334ac
	Checksum: 0xC1570D32
	Offset: 0x2C88
	Size: 0x244
	Parameters: 2
	Flags: None
*/
function function_29f4ff02(var_dbd1a594, entity)
{
	if(isplayer(entity))
	{
		return;
	}
	var_45b1bb5a = function_70ed4baf(entity);
	if(!isdefined(var_45b1bb5a))
	{
		return;
	}
	killstreak = killstreaks::get_from_weapon(var_45b1bb5a);
	if(isdefined(killstreak))
	{
		var_dbd1a594.var_639e4be8++;
		if(isdefined(var_dbd1a594.var_639e4be8) && var_dbd1a594.var_639e4be8 == 3)
		{
			scoreevents::processscoreevent(#"hash_232128502a39219d", var_dbd1a594, undefined, getweapon(#"gadget_icepick"));
		}
	}
	originalowner = entity.owner;
	if(isdefined(level.var_ff6f539f[var_45b1bb5a.name]))
	{
		thread [[level.var_ff6f539f[var_45b1bb5a.name]]](entity, var_dbd1a594);
		function_d545fd0a(var_dbd1a594, var_45b1bb5a);
	}
	if(var_45b1bb5a.var_b8a85edd)
	{
		var_8b745faa = getweapon(#"gadget_icepick");
		if(isentity(entity))
		{
			entity kill(entity.origin, var_dbd1a594, self, var_8b745faa);
		}
		function_d545fd0a(var_dbd1a594, var_45b1bb5a);
	}
	else
	{
		if(isdefined(entity.var_6f6b8de5))
		{
			var_9daa805 = 1;
		}
		entity.var_6f6b8de5 = 1;
	}
	function_42bb8ac1(var_45b1bb5a, originalowner, var_dbd1a594, var_9daa805);
}

/*
	Name: function_ea2dfad6
	Namespace: namespace_94f334ac
	Checksum: 0xF60295C7
	Offset: 0x2ED8
	Size: 0xF8
	Parameters: 1
	Flags: None
*/
function function_ea2dfad6(hacker)
{
	if(!isdefined(hacker))
	{
		return;
	}
	foreach(player in getplayers())
	{
		if(!isdefined(player))
		{
			continue;
		}
		if(!isdefined(player.var_e2131267) || (!(isdefined(player.ishacked) && player.ishacked)))
		{
			continue;
		}
		if(player.var_e2131267 == hacker)
		{
			thread function_27c9bfc8(player, 0);
		}
	}
}

/*
	Name: function_27c9bfc8
	Namespace: namespace_94f334ac
	Checksum: 0x63AF6ED0
	Offset: 0x2FD8
	Size: 0x16C
	Parameters: 2
	Flags: None
*/
function function_27c9bfc8(var_11a83c3a, announce)
{
	/#
		assert(isdefined(var_11a83c3a));
	#/
	/#
		assert(isdefined(announce));
	#/
	var_11a83c3a notify(#"hash_18b5dd5fa60e89ba");
	var_11a83c3a.ishacked = 0;
	var_11a83c3a.var_be173895 = 0;
	var_11a83c3a.var_e2131267 = undefined;
	var_11a83c3a clientfield::set_player_uimodel("hudItems.hacked", 0);
	var_11a83c3a clientfield::set("hackStatus", 0);
	var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", 1);
	var_11a83c3a ability_player::function_c9b950e3();
	var_559f4f0a = function_4d1e7b48("hacked");
	var_11a83c3a status_effect::function_408158ef(var_559f4f0a.var_67e2281d, var_559f4f0a.var_18d16a6b);
	if(announce)
	{
		var_11a83c3a thread killstreaks::play_taacom_dialog("specialistHackEnd");
	}
}

/*
	Name: function_aadad2c
	Namespace: namespace_94f334ac
	Checksum: 0x20AAC83D
	Offset: 0x3150
	Size: 0x224
	Parameters: 2
	Flags: Private
*/
function private function_aadad2c(var_dbd1a594, var_11a83c3a)
{
	/#
		assert(isdefined(var_dbd1a594));
	#/
	/#
		assert(isdefined(var_11a83c3a));
	#/
	var_8b745faa = getweapon(#"gadget_icepick");
	scoreevents::processscoreevent(#"hacked_enemy", var_dbd1a594, var_11a83c3a, var_8b745faa);
	var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", 0);
	var_11a83c3a thread killstreaks::play_taacom_dialog("specialistHackBegin", undefined, undefined, undefined, undefined, undefined, 1);
	var_11a83c3a.var_9b4cc45c = gettime();
	var_11a83c3a.ishacked = 1;
	var_11a83c3a.var_e2131267 = var_dbd1a594;
	var_11a83c3a.var_20183706 = var_11a83c3a function_6c32d092(#"talent_resistance");
	var_559f4f0a = function_4d1e7b48("hacked");
	duration = var_559f4f0a.var_77449e9;
	if(var_11a83c3a.var_20183706)
	{
		var_51d5c26f = function_13f4415c();
		duration = duration * (isdefined(var_51d5c26f.var_4624074e) ? var_51d5c26f.var_4624074e : 1);
	}
	var_11a83c3a.var_e92132fd = gettime() + duration;
	if((isdefined(var_11a83c3a.var_1f5ab061) ? var_11a83c3a.var_1f5ab061 : 0))
	{
		function_6c031486(var_11a83c3a);
	}
}

/*
	Name: function_a9987363
	Namespace: namespace_94f334ac
	Checksum: 0xBBE14787
	Offset: 0x3380
	Size: 0x13C
	Parameters: 3
	Flags: Private
*/
function private function_a9987363(var_559f4f0a, var_dbd1a594, var_11a83c3a)
{
	/#
		assert(isdefined(var_559f4f0a));
	#/
	/#
		assert(isdefined(var_dbd1a594));
	#/
	/#
		assert(isdefined(var_11a83c3a));
	#/
	if(!isdefined(var_11a83c3a.var_e92132fd))
	{
		return;
	}
	var_575cc792 = var_11a83c3a.var_e92132fd - gettime();
	var_8b745faa = getweapon(#"gadget_icepick");
	var_11a83c3a status_effect::status_effect_apply(var_559f4f0a, var_8b745faa, var_dbd1a594, 0, var_575cc792);
	var_11a83c3a clientfield::set("hackStatus", 2);
	var_11a83c3a clientfield::set_player_uimodel("hudItems.hacked", 1);
	var_11a83c3a ability_player::function_116ec442();
}

/*
	Name: function_bf744a1e
	Namespace: namespace_94f334ac
	Checksum: 0x639D4CA9
	Offset: 0x34C8
	Size: 0x19C
	Parameters: 2
	Flags: Private
*/
function private function_bf744a1e(var_dbd1a594, var_11a83c3a)
{
	var_11a83c3a.var_e2131267 = var_dbd1a594;
	var_8b745faa = getweapon(#"gadget_icepick");
	scoreevents::processscoreevent(#"hacked_enemy", var_dbd1a594, var_11a83c3a, var_8b745faa);
	var_51d5c26f = function_13f4415c();
	var_e7af1dd4 = (var_11a83c3a function_6c32d092(#"talent_resistance") ? (isdefined(var_51d5c26f.var_4624074e) ? var_51d5c26f.var_4624074e : 1) : 1);
	statuseffect = function_4d1e7b48("hacked");
	var_645d17c2 = (statuseffect.var_77449e9 * var_e7af1dd4) * (isdefined(var_51d5c26f.var_9b5b082d) ? var_51d5c26f.var_9b5b082d : 1);
	var_11a83c3a.var_e92132fd = var_11a83c3a.var_e92132fd + var_645d17c2;
	var_11a83c3a status_effect::status_effect_apply(statuseffect, var_8b745faa, var_dbd1a594, 0, var_645d17c2);
}

/*
	Name: function_f255c737
	Namespace: namespace_94f334ac
	Checksum: 0x1859C81C
	Offset: 0x3670
	Size: 0x15C
	Parameters: 1
	Flags: Private
*/
function private function_f255c737(var_11a83c3a)
{
	/#
		assert(isdefined(var_11a83c3a));
	#/
	var_11a83c3a endon(#"death", #"hash_18b5dd5fa60e89ba");
	var_51d5c26f = function_13f4415c();
	while(gettime() <= var_11a83c3a.var_e92132fd && level.gameended !== 1)
	{
		duration = var_11a83c3a.var_e92132fd - var_11a83c3a.var_9b4cc45c;
		totaltime = gettime() - var_11a83c3a.var_9b4cc45c;
		var_15ab01c8 = totaltime / duration;
		if(totaltime > (isdefined(var_51d5c26f.var_2f2b5447) ? var_51d5c26f.var_2f2b5447 : 0))
		{
			var_11a83c3a clientfield::set_player_uimodel("hudItems.hackedRebootProgress", var_15ab01c8);
		}
		waitframe(1);
	}
	if(!isdefined(var_11a83c3a))
	{
		return;
	}
	thread function_27c9bfc8(var_11a83c3a, 1);
}

/*
	Name: function_39026c34
	Namespace: namespace_94f334ac
	Checksum: 0x6E34C7C4
	Offset: 0x37D8
	Size: 0x144
	Parameters: 3
	Flags: None
*/
function function_39026c34(var_dbd1a594, var_11a83c3a, var_4f6e2cbe)
{
	/#
		assert(isdefined(var_dbd1a594));
	#/
	/#
		assert(isdefined(var_11a83c3a));
	#/
	var_11a83c3a endon(#"death");
	if(var_4f6e2cbe)
	{
		if((isdefined(var_11a83c3a.ishacked) ? var_11a83c3a.ishacked : 0))
		{
			function_bf744a1e(var_dbd1a594, var_11a83c3a);
		}
		else
		{
			function_aadad2c(var_dbd1a594, var_11a83c3a);
		}
	}
	if(gettime() >= var_11a83c3a.var_e92132fd)
	{
		function_27c9bfc8(var_11a83c3a, 0);
		return;
	}
	function_a9987363(function_4d1e7b48("hacked"), var_dbd1a594, var_11a83c3a);
	thread function_f255c737(var_11a83c3a);
}

/*
	Name: function_9a1266be
	Namespace: namespace_94f334ac
	Checksum: 0xB28758B6
	Offset: 0x3928
	Size: 0x5C
	Parameters: 0
	Flags: Private
*/
function private function_9a1266be()
{
	self endon(#"death", #"hash_2945c35e0b146804", #"hash_5e72464fef90323e");
	wait(1);
	self function_de8a54a6(0.01);
}

/*
	Name: gadget_icepick_on
	Namespace: namespace_94f334ac
	Checksum: 0x5AD06B7C
	Offset: 0x3990
	Size: 0x1AC
	Parameters: 2
	Flags: Private
*/
function private gadget_icepick_on(slot, weapon)
{
	self clientfield::set_to_player("gadget_icepick_on", 1);
	self clientfield::set_player_uimodel("IcePickInfo.hackStarted", 0);
	self clientfield::set_player_uimodel("IcePickInfo.hackFinished", 0);
	self clientfield::set_player_uimodel("IcePickInfo.hackEquipFinished", 0);
	self clientfield::set_player_uimodel("IcePickInfo.hackVehicleFinished", 0);
	self clientfield::set_to_player("currentlybeinghackedplayer", -1);
	function_73d5db3b(self);
	self thread function_9a1266be();
	self function_124efc19(1);
	self.var_c1911c44 = 0;
	self.var_1f5ab061 = 1;
	self.var_6704e6fa = 1;
	self.var_c48b30ab = self function_57dfc908();
	if(isbot(self))
	{
		self.var_46fccfba = 1;
		self thread function_f1148c2c(self);
	}
	else
	{
		thread function_6b9d6894(self);
	}
}

/*
	Name: function_30fe16c7
	Namespace: namespace_94f334ac
	Checksum: 0x9F0E2FE5
	Offset: 0x3B48
	Size: 0x4E
	Parameters: 0
	Flags: Private
*/
function private function_30fe16c7()
{
	/#
		self notify("");
		self endon("");
		while(isdefined(self))
		{
			function_73d5db3b(self);
			waitframe(1);
		}
	#/
}

/*
	Name: gadget_icepick_off
	Namespace: namespace_94f334ac
	Checksum: 0xD0DAA5A0
	Offset: 0x3BA0
	Size: 0x14C
	Parameters: 2
	Flags: Private
*/
function private gadget_icepick_off(slot, weapon)
{
	self clientfield::set_to_player("gadget_icepick_on", 0);
	self notify(#"hash_2945c35e0b146804");
	self notify(#"hash_7b4714f415b8f49e");
	self function_124efc19(0);
	self function_de8a54a6(1);
	self.var_6704e6fa = 1;
	self.var_1f5ab061 = 0;
	self.var_c1911c44 = 0;
	self allowjump(1);
	var_559f4f0a = function_4d1e7b48("hacking");
	self status_effect::function_408158ef(var_559f4f0a.var_67e2281d, var_559f4f0a.var_18d16a6b);
	self clientfield::set_to_player("currentlyHacking", 0);
	function_28f0bd8e(self);
}

/*
	Name: function_d1f6e8d0
	Namespace: namespace_94f334ac
	Checksum: 0x31FFEE52
	Offset: 0x3CF8
	Size: 0x29E
	Parameters: 1
	Flags: Private
*/
function private function_d1f6e8d0(player)
{
	player endon(#"hash_2945c35e0b146804", #"death");
	if(!isdefined(player.var_46fccfba))
	{
		player.var_46fccfba = 0;
	}
	var_3e6425fc = 0;
	player function_124efc19(1);
	player function_de8a54a6(1);
	var_559f4f0a = function_4d1e7b48("hacking");
	var_8b745faa = getweapon(#"gadget_icepick");
	var_51d5c26f = function_13f4415c();
	while(true)
	{
		if(player.var_46fccfba && !var_3e6425fc)
		{
			player function_124efc19(0);
			player function_de8a54a6((isdefined(var_51d5c26f.var_3ca119bd) ? var_51d5c26f.var_3ca119bd : 1));
			player allowjump(0);
			player.var_6704e6fa = (isdefined(var_51d5c26f.var_c424ffde) ? var_51d5c26f.var_c424ffde : 1);
			if(isdefined(var_559f4f0a))
			{
				player status_effect::status_effect_apply(var_559f4f0a, var_8b745faa, player, 0);
			}
			var_3e6425fc = 1;
		}
		else if(!player.var_46fccfba && var_3e6425fc)
		{
			player function_124efc19(1);
			player function_de8a54a6(1);
			player.var_6704e6fa = 1;
			var_3e6425fc = 0;
			player allowjump(1);
			player status_effect::function_408158ef(var_559f4f0a.var_67e2281d, var_559f4f0a.var_18d16a6b);
		}
		waitframe(1);
	}
}

/*
	Name: function_f1148c2c
	Namespace: namespace_94f334ac
	Checksum: 0xA72B4024
	Offset: 0x3FA0
	Size: 0xB4
	Parameters: 1
	Flags: None
*/
function function_f1148c2c(player)
{
	player endon(#"death", #"hash_7b4714f415b8f49e");
	player notify(#"hash_5e72464fef90323e");
	if(player isswitchingweapons())
	{
		player waittilltimeout(1, #"weapon_change_complete");
	}
	if(isdefined(player) && isplayer(player))
	{
		function_7f0dadf5(player);
	}
}

/*
	Name: function_6b9d6894
	Namespace: namespace_94f334ac
	Checksum: 0x5D8B6D94
	Offset: 0x4060
	Size: 0x216
	Parameters: 1
	Flags: Private
*/
function private function_6b9d6894(player)
{
	player endon(#"hash_2945c35e0b146804", #"death", #"disconnect");
	if(!isdefined(player.var_3ca20bb9))
	{
		player.var_3ca20bb9 = 0;
	}
	while(true)
	{
		waitresult = undefined;
		waitresult = player waittill(#"menuresponse");
		switch(waitresult.response)
		{
			case "id":
			{
				if(!(isdefined(player.var_c1911c44) ? player.var_c1911c44 : 0) && waitresult.intpayload === 1)
				{
					if(isdefined(level.var_fdb0a658) && level.var_fdb0a658)
					{
						player iprintlnbold(#"hash_77195fae71b9bcdd");
						player switchtoweapon();
						return;
					}
					player thread function_f1148c2c(player);
				}
				switch(waitresult.intpayload)
				{
					case 1:
					{
						player.var_46fccfba = 1;
						break;
					}
					case 0:
					{
						player.var_46fccfba = 0;
						break;
					}
				}
				break;
			}
			case "back":
			{
				if(waitresult.intpayload == 1)
				{
					player switchtoweapon();
				}
				break;
			}
		}
	}
}

/*
	Name: function_28f0bd8e
	Namespace: namespace_94f334ac
	Checksum: 0xD1C58C58
	Offset: 0x4280
	Size: 0xF6
	Parameters: 1
	Flags: Private
*/
function private function_28f0bd8e(hacker)
{
	hacker notify(#"hash_ea5ac4d11419268");
	hacker endon(#"hash_ea5ac4d11419268");
	objectiveid = hacker.var_1d6ad02e;
	var_51d5c26f = function_13f4415c();
	hacker waittilltimeout((isdefined(var_51d5c26f.var_9baf2d44) ? var_51d5c26f.var_9baf2d44 : 0), #"death", #"disconnect");
	if(isdefined(objectiveid))
	{
		gameobjects::release_obj_id(objectiveid);
		objective_delete(objectiveid);
		if(isdefined(hacker))
		{
			hacker.var_1d6ad02e = undefined;
		}
	}
}

/*
	Name: function_b76c8353
	Namespace: namespace_94f334ac
	Checksum: 0x74106BC8
	Offset: 0x4380
	Size: 0x1B4
	Parameters: 1
	Flags: Private
*/
function private function_b76c8353(hacker)
{
	hacker endon(#"death", #"hash_2945c35e0b146804");
	var_51d5c26f = function_13f4415c();
	var_a1a18ce2 = (isdefined(var_51d5c26f.var_679962fc) ? var_51d5c26f.var_679962fc : 1000);
	var_49c01cfb = gettime() + var_a1a18ce2;
	starttime = gettime();
	while(gettime() < var_49c01cfb)
	{
		timeelapsed = gettime() - starttime;
		var_2d62ff4b = timeelapsed / var_a1a18ce2;
		wait(0.1);
	}
	if(!isdefined(hacker.var_1d6ad02e))
	{
		hacker.var_1d6ad02e = gameobjects::get_next_obj_id();
	}
	objective_add(hacker.var_1d6ad02e, "active", hacker, #"hash_70ba99f2044c367e");
	objective_setteam(hacker.var_1d6ad02e, hacker.team);
	function_da7940a3(hacker.var_1d6ad02e, 1);
	function_3ae6fa3(hacker.var_1d6ad02e, hacker.team, 0);
}

/*
	Name: function_42bb8ac1
	Namespace: namespace_94f334ac
	Checksum: 0x404BDE6A
	Offset: 0x4540
	Size: 0x1F8
	Parameters: 4
	Flags: None
*/
function function_42bb8ac1(weapon, originalowner, newowner, var_53c10ed8)
{
	if(!isdefined(weapon) || !isdefined(originalowner))
	{
		return;
	}
	switch(weapon.name)
	{
		case "gadget_spawnbeacon":
		{
			leaderdialog = "enemySpawnBeaconHack";
			break;
		}
		case "cobra_20mm_comlink":
		case "helicopter_comlink":
		case "inventory_helicopter_comlink":
		{
			leaderdialog = "enemyAttackChopperHack";
			break;
		}
		case "counteruav":
		{
			leaderdialog = "enemyCUAVHack";
			break;
		}
		case "drone_squadron":
		case "hash_3447a6457d26a42e":
		{
			leaderdialog = "enemyDroneSquadronHack";
			break;
		}
		case "supplydrop":
		{
			leaderdialog = "enemyCarePackageHack";
			break;
		}
		case "uav":
		{
			leaderdialog = "enemyUAVHack";
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			leaderdialog = "enemySentryHack";
			break;
		}
	}
	if(isdefined(leaderdialog) && isdefined(level.var_57e2bc08))
	{
		if(level.teambased)
		{
			thread [[level.var_57e2bc08]](leaderdialog, originalowner.team, originalowner);
		}
	}
	if(isdefined(level.var_b42019ef))
	{
		originalowner thread [[level.var_b42019ef]](weapon, newowner, var_53c10ed8);
	}
}

/*
	Name: function_d545fd0a
	Namespace: namespace_94f334ac
	Checksum: 0x3F698822
	Offset: 0x4740
	Size: 0x3EC
	Parameters: 2
	Flags: None
*/
function function_d545fd0a(player, weapon)
{
	switch(weapon.name)
	{
		case "supplydrop":
		{
			var_d975dd49 = "hacked_care_package";
			break;
		}
		case "counteruav":
		{
			var_d975dd49 = "hacked_cuav";
			break;
		}
		case "uav":
		{
			var_d975dd49 = "hacked_uav";
			break;
		}
		case "gadget_spawnbeacon":
		{
			var_d975dd49 = "hacked_spawn_beacon";
			break;
		}
		case "inventory_planemortar":
		case "planemortar":
		{
			var_d975dd49 = "hacked_planemortar";
			break;
		}
		case "remote_missile":
		case "inventory_remote_missile":
		{
			var_d975dd49 = "hacked_hellstorm";
			break;
		}
		case "hash_4307d5aaa7ce21d4":
		case "straferun":
		{
			var_d975dd49 = "hacked_warthog";
			break;
		}
		case "dart":
		case "inventory_dart":
		{
			var_d975dd49 = "hacked_dart";
			break;
		}
		case "drone_squadron":
		case "hash_3447a6457d26a42e":
		{
			var_d975dd49 = "hacked_drone_squad";
			break;
		}
		case "cobra_20mm_comlink":
		case "helicopter_comlink":
		case "inventory_helicopter_comlink":
		{
			var_d975dd49 = "hacked_attack_chopper";
			break;
		}
		case "overwatch_helicopter":
		case "hash_74ea4af18853e9af":
		{
			var_d975dd49 = "hacked_sniper_chopper";
			break;
		}
		case "hash_459c0007ec5e2470":
		case "ac130":
		{
			var_d975dd49 = "hacked_ac130";
			break;
		}
		case "tank_robot":
		case "inventory_tank_robot":
		case "ai_tank_marker":
		{
			var_d975dd49 = "hacked_mantis";
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		{
			var_d975dd49 = "hacked_ult_turret";
			break;
		}
		case "recon_car":
		case "inventory_recon_car":
		{
			var_d975dd49 = "hacked_rcxd";
			break;
		}
		case "gadget_supplypod":
		{
			var_d975dd49 = "hacked_supplypod";
			break;
		}
		case "ability_smart_cover":
		case "hash_1fb0b26684caee0f":
		{
			var_d975dd49 = "hacked_barricade";
			break;
		}
		case "eq_sensor":
		{
			var_d975dd49 = "hacked_sensor_dart";
			break;
		}
		case "hash_4a4ba36128b6582f":
		{
			var_d975dd49 = "hacked_seeker";
			break;
		}
		case "trophy_system":
		{
			var_d975dd49 = "hacked_trophy";
			break;
		}
	}
	if(isdefined(var_d975dd49))
	{
		var_8b745faa = getweapon(#"gadget_icepick");
		scoreevents::processscoreevent(var_d975dd49, player, undefined, var_8b745faa);
	}
}

