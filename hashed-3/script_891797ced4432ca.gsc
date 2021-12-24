// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2d756999;

/*
	Name: init
	Namespace: namespace_2d756999
	Checksum: 0x1A2BBEAD
	Offset: 0x4E8
	Size: 0x594
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"hash_64e187377acec152");
	level flag::init(#"hash_61f2d2e8517e7f57");
	level flag::init(#"hash_407e0345ce2708de");
	level flag::init(#"hash_3eea1302aae8fea1");
	level flag::init(#"hash_3bdb012f2eaac96");
	level flag::init(#"hash_506f1fac74cfdd86");
	level flag::init(#"hash_4ea18d3d5847ab0c");
	level flag::init(#"hash_aab8ed14df98649");
	level flag::init(#"hash_3af375942a1c2785");
	level flag::init(#"hash_7b6594521dfb7bb1");
	level flag::init(#"hash_3e90f82a2802b3");
	level flag::init(#"hash_26c9e53e0e558572");
	level flag::init(#"hash_4863d7214aa660e2");
	level flag::init(#"hash_5ee1f3505b34a52d");
	if(!zm_utility::function_e51dc2d8())
	{
		hidemiscmodels("mdl_narrative_ix");
		hidemiscmodels("mdl_narrative_ink");
		hidemiscmodels("mdl_narrative_egg");
	}
	var_dd3ac19c = getent("narsho", "targetname");
	var_dd3ac19c hide();
	var_551e1d09 = struct::get_array(#"hash_4ff4d74fc1ff150d");
	array::thread_all(var_551e1d09, &function_58c9a8b3, 1);
	var_73aee06c = struct::get_array(#"hash_70b8946b02777c1d");
	array::thread_all(var_73aee06c, &function_58c9a8b3);
	level thread function_c2e32573("narrative_whispers", array(#"hash_609c2bdb6def129f", #"hash_4af81ddd4ad3f4d1", #"hash_23a8e8f61c4fc32c", #"hash_7f6bf79b60f1e8d4"), 1, #"hash_46aec984fab973b8", #"hash_46ddcfa7b8081e89", 1.5);
	level thread function_c2e32573("narrative_warning", array(#"hash_5c9150da16c41e10", #"hash_66dd1564ba1e9474", #"hash_4489363f604b439c", #"hash_4e2811c0bd19be20", #"hash_7101f8d31ad66888"), 1);
	level thread function_a38e222b();
	level thread function_831dcf3e();
	level thread function_7c66ee1b();
	level thread function_1d63d95a();
	level thread function_e0f3a28d();
	level thread function_bf573b44();
	level thread acid_trap_think();
	level thread function_81c8a125();
	level thread function_a533efc0();
	level thread function_cb2c487d();
	level thread function_c8230683();
	if(zm_utility::function_e51dc2d8())
	{
		var_9ce1269a = getent("mdl_narrative_lead", "targetname");
		var_9ce1269a clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	}
	level thread function_b315d709();
}

/*
	Name: function_58c9a8b3
	Namespace: namespace_2d756999
	Checksum: 0x43E467D9
	Offset: 0xA88
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_58c9a8b3(var_c1146e81 = 0)
{
	level endon(#"end_game");
	if(!zm_utility::function_e51dc2d8())
	{
		if(var_c1146e81)
		{
			hidemiscmodels(self.target);
		}
		self struct::delete();
		return;
	}
	e_player = self zm_unitrigger::function_fac87205(&function_77467f4d);
	if(var_c1146e81)
	{
		hidemiscmodels(self.target);
	}
	if(isdefined(self.script_notify))
	{
		level notify(self.script_notify, {#v_origin:self.origin, #e_player:e_player}, isdefined(self.var_b35b6be6));
	}
	self struct::delete();
}

/*
	Name: function_77467f4d
	Namespace: namespace_2d756999
	Checksum: 0x60C2D1B1
	Offset: 0xBB8
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_77467f4d(e_player)
{
	var_5168e40f = e_player zm_utility::is_player_looking_at(self.stub.related_parent.origin, 0.99, 0);
	var_2d08c5b3 = level flag::get(#"hash_64e187377acec152");
	return !var_2d08c5b3 && var_5168e40f;
}

/*
	Name: function_c2e32573
	Namespace: namespace_2d756999
	Checksum: 0x75B01A04
	Offset: 0xC48
	Size: 0x298
	Parameters: 6
	Flags: Linked
*/
function function_c2e32573(str_notify, var_3608d414, var_4bb99e1c = 1, var_763c80f1, var_109c646f, var_e688ce8f = 0)
{
	level endon(#"end_game");
	if(!zm_utility::function_e51dc2d8())
	{
		return;
	}
	if(!isdefined(var_3608d414))
	{
		var_3608d414 = [];
	}
	else if(!isarray(var_3608d414))
	{
		var_3608d414 = array(var_3608d414);
	}
	foreach(str_vo in var_3608d414)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(str_notify);
		level flag::set(#"hash_64e187377acec152");
		v_origin = var_be17187b.v_origin;
		if(isdefined(var_763c80f1))
		{
			playsoundatposition(var_763c80f1, v_origin);
			wait(1.5);
		}
		if(var_4bb99e1c)
		{
			playsoundatposition(str_vo, v_origin);
		}
		else
		{
			foreach(e_player in level.players)
			{
				e_player playsoundtoplayer(str_vo, e_player);
			}
		}
		function_d24a0f09(str_vo, var_e688ce8f);
		if(isdefined(var_109c646f))
		{
			playsoundatposition(var_109c646f, v_origin);
		}
		level flag::clear(#"hash_64e187377acec152");
	}
}

/*
	Name: function_d24a0f09
	Namespace: namespace_2d756999
	Checksum: 0xCA2002C0
	Offset: 0xEE8
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function function_d24a0f09(str_vo, var_e688ce8f = 0)
{
	n_duration = soundgetplaybacktime(str_vo);
	n_duration = float(n_duration) / 1000;
	n_duration = n_duration - var_e688ce8f;
	if(n_duration > 0)
	{
		wait(n_duration);
	}
}

/*
	Name: function_a38e222b
	Namespace: namespace_2d756999
	Checksum: 0xBCFCF9E
	Offset: 0xF70
	Size: 0x5B6
	Parameters: 0
	Flags: Linked
*/
function function_a38e222b()
{
	level endon(#"end_game");
	if(!zm_utility::function_e51dc2d8())
	{
		return;
	}
	for(i = 0; i < 4; i++)
	{
		waitresult = undefined;
		waitresult = level waittill(#"hash_19e3162adf6caf91");
		level flag::set(#"hash_64e187377acec152");
		var_e25ba3b3 = spawn("script_origin", waitresult.v_origin);
		var_e25ba3b3 playsound(#"hash_d4b330503498b0f");
		var_e25ba3b3 playloopsound(#"hash_1da1dccdd4a06b31");
		wait(2);
		switch(i)
		{
			case 0:
			{
				var_3608d414 = array(#"hash_4e3fb2f478282bfd", #"hash_4e3fb1f478282a4a", #"hash_29468385390c3a5", #"hash_4e3faff4782826e4", #"hash_29462385390b973");
				break;
			}
			case 1:
			{
				var_3608d414 = array(#"hash_68fa60075be1fd59", #"hash_5838015b257fcbb8", #"hash_68fa5e075be1f9f3", #"hash_5838035b257fcf1e", #"hash_68fa64075be20425", #"hash_5838055b257fd284", #"hash_68fa62075be200bf", #"hash_5838075b257fd5ea", #"hash_68fa68075be20af1", #"hash_5837f95b257fbe20", #"hash_436b0f8120fe7fe2", #"hash_66f5d6e0b826d9cb", #"hash_436b0d8120fe7c7c");
				break;
			}
			case 2:
			{
				var_3608d414 = array(#"hash_4170147034d51e4c", #"hash_4769619b76b935b9", #"hash_4170167034d521b2", #"hash_47695f9b76b93253", #"hash_4170107034d51780", #"hash_4769659b76b93c85", #"hash_4170127034d51ae6", #"hash_4769639b76b9391f", #"hash_41701c7034d52be4", #"hash_4769699b76b94351", #"hash_1146642abcb5f7cb", #"hash_1146632abcb5f618", #"hash_6943aa9c6250957", #"hash_1146652abcb5f97e", #"hash_69438a9c62505f1", #"hash_69437a9c625043e", #"hash_69436a9c625028b");
				break;
			}
			case 3:
			{
				var_3608d414 = array(#"hash_56a6dd4f9ee2ba10", #"hash_56a6de4f9ee2bbc3", #"hash_56a6df4f9ee2bd76", #"hash_56a6e04f9ee2bf29");
				break;
			}
		}
		for(a = 0; a < var_3608d414.size; a++)
		{
			var_d34b6d2b = function_b116e882(i, a, 1);
			if(isdefined(var_d34b6d2b))
			{
				playsoundatposition(var_d34b6d2b, waitresult.v_origin);
			}
			playsoundatposition(var_3608d414[a], waitresult.v_origin);
			function_d24a0f09(var_3608d414[a]);
			var_d34b6d2b = function_b116e882(i, a, 0);
			if(isdefined(var_d34b6d2b))
			{
				playsoundatposition(var_d34b6d2b, waitresult.v_origin);
			}
			function_cfb5afb3(i, a);
		}
		var_e25ba3b3 stoploopsound();
		var_e25ba3b3 playsound(#"hash_4242c92643cc6775");
		waitframe(1);
		var_e25ba3b3 delete();
		level flag::clear(#"hash_64e187377acec152");
	}
}

/*
	Name: function_cfb5afb3
	Namespace: namespace_2d756999
	Checksum: 0x836F7B92
	Offset: 0x1530
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function function_cfb5afb3(var_237f80b0, var_54bb7f87)
{
	n_waittime = undefined;
	switch(var_237f80b0)
	{
		case 2:
		{
			if(var_54bb7f87 == 9)
			{
				n_waittime = 0.35;
			}
			if(var_54bb7f87 == 10)
			{
				n_waittime = 2.23;
			}
			if(var_54bb7f87 == 13)
			{
				n_waittime = 0.54;
			}
			if(var_54bb7f87 == 14)
			{
				n_waittime = 5.8;
			}
			if(var_54bb7f87 == 15)
			{
				n_waittime = 1.6;
			}
			break;
		}
	}
	if(isdefined(n_waittime))
	{
		wait(n_waittime);
	}
	else
	{
		waitframe(1);
	}
}

/*
	Name: function_b116e882
	Namespace: namespace_2d756999
	Checksum: 0x412050A
	Offset: 0x1618
	Size: 0x1EE
	Parameters: 3
	Flags: Linked
*/
function function_b116e882(var_237f80b0, var_54bb7f87, var_5876458)
{
	var_d34b6d2b = undefined;
	if(var_5876458)
	{
		switch(var_237f80b0)
		{
			case 0:
			{
				if(var_54bb7f87 == 0)
				{
					var_d34b6d2b = #"hash_1ac8c014caa1f64d";
				}
				if(var_54bb7f87 == 1)
				{
					var_d34b6d2b = #"hash_4e8555d4b9f67fb5";
				}
				if(var_54bb7f87 == 3)
				{
					var_d34b6d2b = #"hash_4e8552d4b9f67a9c";
				}
				if(var_54bb7f87 == 4)
				{
					var_d34b6d2b = #"hash_4e8553d4b9f67c4f";
				}
				break;
			}
			case 2:
			{
				if(var_54bb7f87 == 9)
				{
					var_d34b6d2b = #"hash_70155a583c7b3ae2";
				}
				if(var_54bb7f87 == 11)
				{
					var_d34b6d2b = #"hash_701559583c7b392f";
				}
				if(var_54bb7f87 == 12)
				{
					var_d34b6d2b = #"hash_701558583c7b377c";
				}
				if(var_54bb7f87 == 13)
				{
					var_d34b6d2b = #"hash_701557583c7b35c9";
				}
				if(var_54bb7f87 == 14)
				{
					var_d34b6d2b = #"hash_701556583c7b3416";
				}
				break;
			}
			case 3:
			{
				if(var_54bb7f87 == 2)
				{
					var_d34b6d2b = #"hash_481d86c03825cd82";
				}
				break;
			}
		}
	}
	else
	{
		switch(var_237f80b0)
		{
			default:
			{
				var_d34b6d2b = undefined;
				break;
			}
		}
	}
	return var_d34b6d2b;
}

/*
	Name: function_831dcf3e
	Namespace: namespace_2d756999
	Checksum: 0xB0B6B1C
	Offset: 0x1810
	Size: 0x34C
	Parameters: 0
	Flags: Linked
*/
function function_831dcf3e()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_dirt", "targetname");
	var_d65b49c5 = getentarray("t_narrative_hoop", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
	}
	else
	{
		level.var_75fb83c = 0;
		level.var_3d8b20c0 = var_d65b49c5.size;
		foreach(var_2f1adb8e in var_d65b49c5)
		{
			var_2f1adb8e flag::init(#"hash_6e4b1162d4626a6e");
			var_2f1adb8e thread function_51f7da68();
		}
		level flag::wait_till(#"hash_61f2d2e8517e7f57");
		callback::on_connect(&function_da2c37fc);
		array::thread_all(level.players, &function_da2c37fc);
		level flag::wait_till(#"hash_407e0345ce2708de");
		callback::remove_on_connect(&function_da2c37fc);
	}
	foreach(var_2f1adb8e in var_d65b49c5)
	{
		mdl_fx = getent(var_2f1adb8e.target, "targetname");
		if(zm_utility::function_e51dc2d8())
		{
			mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 0);
		}
		mdl_fx delete();
		var_2f1adb8e delete();
	}
	vol_pedestal = getent("vol_narrative_smash", "targetname");
	vol_pedestal delete();
}

/*
	Name: function_51f7da68
	Namespace: namespace_2d756999
	Checksum: 0x627D4094
	Offset: 0x1B68
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function function_51f7da68()
{
	self notify("1a5e7df7e5c92d42");
	self endon("1a5e7df7e5c92d42");
	level endon(#"end_game");
	self endon(#"death");
	mdl_fx = getent(self.target, "targetname");
	if(self flag::get(#"hash_6e4b1162d4626a6e"))
	{
		mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 0);
		self flag::clear(#"hash_6e4b1162d4626a6e");
	}
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = level waittill(#"hash_3042a9bf2f57ea0a");
		v_origin = var_be17187b.var_814c9389;
		if(istouching(v_origin, self))
		{
			break;
		}
	}
	var_d34eaa6e = level.var_75fb83c + 1;
	if(var_d34eaa6e == self.script_int)
	{
		level.var_75fb83c = var_d34eaa6e;
		self flag::set(#"hash_6e4b1162d4626a6e");
		mdl_fx clientfield::set("" + #"hash_5afda864f8b64f5c", 1);
		if(level.var_75fb83c >= level.var_3d8b20c0)
		{
			level flag::set(#"hash_61f2d2e8517e7f57");
		}
	}
	else
	{
		level.var_75fb83c = 0;
		var_d65b49c5 = getentarray("t_narrative_hoop", "targetname");
		arrayremovevalue(var_d65b49c5, self);
		array::thread_all(var_d65b49c5, &function_51f7da68);
		self thread function_51f7da68();
	}
}

/*
	Name: function_da2c37fc
	Namespace: namespace_2d756999
	Checksum: 0x4F23F18C
	Offset: 0x1E18
	Size: 0x11A
	Parameters: 0
	Flags: Linked
*/
function function_da2c37fc()
{
	self notify("49bddca4a088db84");
	self endon("49bddca4a088db84");
	level endon(#"end_game", #"hash_407e0345ce2708de");
	self endon(#"disconnect");
	vol_pedestal = getent("vol_narrative_smash", "targetname");
	while(true)
	{
		var_4618dc52 = self.var_4618dc52;
		while(!isdefined(var_4618dc52))
		{
			waitframe(1);
			var_4618dc52 = self.var_4618dc52;
		}
		if(var_4618dc52 istouching(vol_pedestal))
		{
			self thread function_2160d544();
			level flag::set(#"hash_407e0345ce2708de");
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_2160d544
	Namespace: namespace_2d756999
	Checksum: 0xFBB11084
	Offset: 0x1F40
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_2160d544()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_dirt", "targetname");
	var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	self function_964ec142();
	if(!level flag::get(#"hash_3eea1302aae8fea1"))
	{
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
	}
}

/*
	Name: function_964ec142
	Namespace: namespace_2d756999
	Checksum: 0x4F29D76B
	Offset: 0x2038
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function function_964ec142()
{
	level endon(#"end_game");
	self endon(#"death", #"weapon_change");
	vol_cipher = getent("vol_narrative_dirt", "targetname");
	while(true)
	{
		self waittill(#"weapon_melee");
		if(self getcurrentweapon() == level.hero_weapon[#"hammer"][2])
		{
			v_origin = self getweaponmuzzlepoint();
			v_dir = self getweaponforwarddir();
			v_end = v_origin + vectorscale(v_dir, 20000);
			a_trace = beamtrace(v_origin, v_end, 0, self);
			v_hit = a_trace[#"position"];
			if(isdefined(v_hit) && istouching(v_hit, vol_cipher))
			{
				level flag::set(#"hash_3eea1302aae8fea1");
				break;
			}
		}
	}
}

/*
	Name: function_7c66ee1b
	Namespace: namespace_2d756999
	Checksum: 0xD79DDCBF
	Offset: 0x21F8
	Size: 0x1CC
	Parameters: 0
	Flags: Linked
*/
function function_7c66ee1b()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_flop", "targetname");
	s_loc = struct::get(#"hash_41008b60aedc6f40");
	s_hand = struct::get(#"hash_723303fe45c13f65");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
		s_loc struct::delete();
		scene::add_scene_func(s_hand.var_450f5117, &function_f3c29d33, "init");
		s_hand struct::delete();
		return;
	}
	s_loc zm_unitrigger::function_fac87205(&function_bc24a9ea);
	level thread scene::play(s_hand.var_450f5117);
	s_loc struct::delete();
	s_hand struct::delete();
	var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

/*
	Name: function_f3c29d33
	Namespace: namespace_2d756999
	Checksum: 0xAFE1B52E
	Offset: 0x23D0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_f3c29d33(a_ents)
{
	level scene::remove_scene_func(self.scriptbundlename, &function_f3c29d33, "init");
	self scene::stop();
	var_1ab50f4 = a_ents[#"hash_7aff0ee60ddd937b"];
	var_1ab50f4 delete();
}

/*
	Name: function_bc24a9ea
	Namespace: namespace_2d756999
	Checksum: 0xEB33D078
	Offset: 0x2468
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function function_bc24a9ea(e_player)
{
	s_hand = struct::get(#"hash_723303fe45c13f65");
	str_stance = e_player getstance();
	var_39b20ef6 = e_player zm_utility::is_player_looking_at(s_hand.origin, 0.99, 0);
	var_4e28e4e2 = str_stance == "crouch" || str_stance == "prone";
	return var_39b20ef6 && var_4e28e4e2;
}

/*
	Name: function_1d63d95a
	Namespace: namespace_2d756999
	Checksum: 0x1832FEE5
	Offset: 0x2538
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_1d63d95a()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_crawl", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
		return;
	}
	while(true)
	{
		level flag::wait_till("special_round");
		level thread function_1614d162();
		level thread function_ce1c5cac();
		level flag::wait_till_any(array(#"hash_3bdb012f2eaac96", #"hash_506f1fac74cfdd86"));
		if(level flag::get(#"hash_3bdb012f2eaac96"))
		{
			break;
		}
		level flag::clear(#"hash_506f1fac74cfdd86");
	}
	t_trigger = getent("t_narrative_crawl", "targetname");
	t_trigger delete();
	var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

/*
	Name: function_1614d162
	Namespace: namespace_2d756999
	Checksum: 0x1FB1C5F6
	Offset: 0x2718
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_1614d162()
{
	level endon(#"end_game", #"hash_506f1fac74cfdd86");
	trigger::wait_till("t_narrative_crawl");
	level flag::set(#"hash_3bdb012f2eaac96");
}

/*
	Name: function_ce1c5cac
	Namespace: namespace_2d756999
	Checksum: 0x3E632C72
	Offset: 0x2788
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_ce1c5cac()
{
	level endon(#"end_game", #"hash_3bdb012f2eaac96");
	level flag::wait_till_clear("special_round");
	level flag::set(#"hash_506f1fac74cfdd86");
}

/*
	Name: function_e0f3a28d
	Namespace: namespace_2d756999
	Checksum: 0x3E055F10
	Offset: 0x27F8
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_e0f3a28d()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_soak", "targetname");
	var_86e77481 = getentarray("t_narrative_soak", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
	}
	else
	{
		level.var_c51a5ce0 = 0;
		level.var_98d9a07c = var_86e77481.size;
		array::thread_all(var_86e77481, &function_341bdf82);
		level flag::wait_till(#"hash_4ea18d3d5847ab0c");
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	}
	array::delete_all(var_86e77481);
}

/*
	Name: function_341bdf82
	Namespace: namespace_2d756999
	Checksum: 0x4EA9719E
	Offset: 0x2950
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_341bdf82()
{
	self notify("45a4563ed2519f47");
	self endon("45a4563ed2519f47");
	level endon(#"end_game");
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"damage");
		w_weapon = var_be17187b.weapon;
		v_origin = var_be17187b.position;
		if(istouching(v_origin, self) && zm_utility::is_frag_grenade(w_weapon))
		{
			break;
		}
	}
	var_8bcd06a0 = level.var_c51a5ce0 + 1;
	if(var_8bcd06a0 == self.script_int)
	{
		level.var_c51a5ce0 = var_8bcd06a0;
		if(level.var_c51a5ce0 >= level.var_98d9a07c)
		{
			level flag::set(#"hash_4ea18d3d5847ab0c");
		}
	}
	else
	{
		level.var_c51a5ce0 = 0;
		var_86e77481 = getentarray("t_narrative_soak", "targetname");
		arrayremovevalue(var_86e77481, self);
		array::thread_all(var_86e77481, &function_341bdf82);
		self thread function_341bdf82();
	}
}

/*
	Name: function_bf573b44
	Namespace: namespace_2d756999
	Checksum: 0xAAE7CEB4
	Offset: 0x2B38
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_bf573b44()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_payback", "targetname");
	var_946f7f31 = getentarray("vol_narrative_payback", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
	}
	else
	{
		level.var_1a87adb6 = 0;
		level.var_4cc66ca4 = var_946f7f31.size;
		callback::on_connect(&function_ca4e26c3);
		array::thread_all(level.players, &function_ca4e26c3);
		level flag::wait_till(#"hash_aab8ed14df98649");
		callback::remove_on_connect(&function_ca4e26c3);
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	}
	array::delete_all(var_946f7f31);
}

/*
	Name: function_ca4e26c3
	Namespace: namespace_2d756999
	Checksum: 0x56099F6C
	Offset: 0x2CD8
	Size: 0x35A
	Parameters: 0
	Flags: Linked
*/
function function_ca4e26c3()
{
	self notify("45c9a4f55b11e032");
	self endon("45c9a4f55b11e032");
	level endon(#"end_game", #"hash_aab8ed14df98649");
	self endon(#"disconnect");
	var_59795ba5 = array(level.hero_weapon[#"sword_pistol"][0].dualwieldweapon, level.hero_weapon[#"sword_pistol"][1].dualwieldweapon, level.hero_weapon[#"sword_pistol"][2].dualwieldweapon);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_fired");
		w_weapon = var_be17187b.weapon;
		if(isdefined(w_weapon) && isinarray(var_59795ba5, w_weapon))
		{
			v_origin = self getweaponmuzzlepoint();
			v_dir = self getweaponforwarddir();
			n_range = level.var_30d2c56e[#"sword_pistol"][#"hash_579056d441d637d"];
			v_end = v_origin + vectorscale(v_dir, n_range);
			a_trace = beamtrace(v_origin, v_end, 0, self);
			v_hit = a_trace[#"position"];
			if(isdefined(v_hit))
			{
				var_946f7f31 = getentarray("vol_narrative_payback", "targetname");
				foreach(vol_statue in var_946f7f31)
				{
					if(istouching(v_hit, vol_statue))
					{
						var_1044cdc7 = level.var_1a87adb6 + 1;
						if(var_1044cdc7 == vol_statue.script_int)
						{
							level.var_1a87adb6 = var_1044cdc7;
							if(level.var_1a87adb6 >= level.var_4cc66ca4)
							{
								level flag::set(#"hash_aab8ed14df98649");
							}
						}
						else
						{
							level.var_1a87adb6 = 0;
						}
						break;
					}
				}
			}
		}
	}
}

/*
	Name: acid_trap_think
	Namespace: namespace_2d756999
	Checksum: 0x60F238C
	Offset: 0x3040
	Size: 0x210
	Parameters: 0
	Flags: Linked
*/
function acid_trap_think()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_burn", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
		return;
	}
	scene::add_scene_func(#"p8_fxanim_zm_towers_trap_acid_02_bundle", &function_89add587, "play");
	var_74331c2 = level.var_482bcfef;
	var_4d42c97f = arraygetclosest(var_8a88c4c8.origin, var_74331c2);
	var_4d42c97f thread function_e6f26f04();
	var_4d42c97f thread function_ffc6c45f();
	while(true)
	{
		level flag::wait_till_all(array(#"hash_3e90f82a2802b3", #"hash_26c9e53e0e558572"));
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
		level flag::wait_till_clear_any(array(#"hash_3e90f82a2802b3", #"hash_26c9e53e0e558572"));
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
	}
}

/*
	Name: function_89add587
	Namespace: namespace_2d756999
	Checksum: 0x8F805727
	Offset: 0x3258
	Size: 0x104
	Parameters: 1
	Flags: Linked
*/
function function_89add587(a_ents)
{
	var_8a88c4c8 = getent("mdl_narrative_burn", "targetname");
	a_s_scenes = struct::get_array(self.scriptbundlename, "scriptbundlename");
	s_closest = arraygetclosest(var_8a88c4c8.origin, a_s_scenes);
	if(s_closest == self)
	{
		level scene::remove_scene_func(self.scriptbundlename, &function_89add587, "play");
		var_110cafc1 = a_ents[#"hash_7aff0ee60ddd937b"];
		var_8a88c4c8 linkto(var_110cafc1, var_8a88c4c8.var_ab585079);
	}
}

/*
	Name: function_e6f26f04
	Namespace: namespace_2d756999
	Checksum: 0xAB2EE7D3
	Offset: 0x3368
	Size: 0x110
	Parameters: 0
	Flags: Linked
*/
function function_e6f26f04()
{
	level endon(#"end_game");
	self endon(#"death");
	str_id = self.script_string;
	while(true)
	{
		var_33f252eb = undefined;
		var_33f252eb = level waittill(#"trap_activate");
		if(var_33f252eb === self)
		{
			level flag::set(#"hash_3e90f82a2802b3");
			var_be17187b = undefined;
			var_be17187b = level waittill(#"hash_3c662e7b29cfc3dd");
			str_off = var_be17187b.var_be3f58a;
			if(str_off === str_id)
			{
				level flag::clear(#"hash_3e90f82a2802b3");
			}
		}
	}
}

/*
	Name: function_ffc6c45f
	Namespace: namespace_2d756999
	Checksum: 0xAAECA792
	Offset: 0x3480
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_ffc6c45f()
{
	level endon(#"end_game");
	self endon(#"death");
	while(true)
	{
		wait(1);
		var_89a92e6f = 0;
		foreach(e_player in level.players)
		{
			if(zm_utility::is_player_valid(e_player, 0, 0) && e_player istouching(self))
			{
				var_89a92e6f = 1;
				break;
			}
		}
		if(var_89a92e6f)
		{
			level flag::set(#"hash_26c9e53e0e558572");
		}
		else
		{
			level flag::clear(#"hash_26c9e53e0e558572");
		}
	}
}

/*
	Name: function_81c8a125
	Namespace: namespace_2d756999
	Checksum: 0xA844A5F6
	Offset: 0x35D0
	Size: 0x22C
	Parameters: 0
	Flags: Linked
*/
function function_81c8a125()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_destiny", "targetname");
	var_4fa6e6eb = getentarray("t_narrative_destiny", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
	}
	else
	{
		var_8b789c96 = 0;
		var_63e5fc38 = var_4fa6e6eb.size;
		while(true)
		{
			var_357aadcd = trigger::wait_till("t_narrative_destiny");
			if(var_8b789c96 != var_357aadcd.script_int)
			{
				var_7ef1d61 = var_8b789c96 + 1;
				if(var_7ef1d61 == var_357aadcd.script_int)
				{
					var_8b789c96 = var_7ef1d61;
					if(var_8b789c96 >= var_63e5fc38)
					{
						break;
					}
				}
				else
				{
					var_8b789c96 = 0;
				}
			}
		}
		var_e9e88745 = getent("mdl_narrative_bash", "targetname");
		var_e9e88745 movex(-2, 0.5);
		var_e9e88745 rotatepitch(15, 0.5);
		var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	}
	array::delete_all(var_4fa6e6eb);
}

/*
	Name: function_a533efc0
	Namespace: namespace_2d756999
	Checksum: 0x41DEE0D
	Offset: 0x3808
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function function_a533efc0()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_slash", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
		return;
	}
	callback::on_ai_killed(&function_d6357bd4);
	level flag::wait_till(#"hash_7b6594521dfb7bb1");
	callback::remove_on_ai_killed(&function_d6357bd4);
	var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
}

/*
	Name: function_d6357bd4
	Namespace: namespace_2d756999
	Checksum: 0x90AE0862
	Offset: 0x3920
	Size: 0x15C
	Parameters: 1
	Flags: Linked
*/
function function_d6357bd4(s_params)
{
	level endon(#"end_game");
	e_player = s_params.eattacker;
	str_mod = s_params.smeansofdeath;
	var_10280e3c = getent("e_challenge_center_stage", "targetname");
	if(self.archetype == #"blight_father" && (isdefined(self.var_2c2980d3) && self.var_2c2980d3) && self istouching(var_10280e3c) && isplayer(e_player) && e_player istouching(var_10280e3c) && str_mod === "MOD_UNKNOWN" && (isdefined(e_player.var_a70d2cfe) && e_player.var_a70d2cfe))
	{
		level flag::set(#"hash_7b6594521dfb7bb1");
	}
}

/*
	Name: function_cb2c487d
	Namespace: namespace_2d756999
	Checksum: 0xDC0FB91A
	Offset: 0x3A88
	Size: 0x318
	Parameters: 0
	Flags: Linked
*/
function function_cb2c487d()
{
	level endon(#"end_game");
	var_8a88c4c8 = getent("mdl_narrative_death", "targetname");
	vol_grate = getent("vol_narrative_death", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		var_8a88c4c8 delete();
		vol_grate delete();
		return;
	}
	level flag::wait_till(#"hash_1dedcdbd1e528077");
	s_trap = level.var_abf198ff[3];
	var_9f02e39c = s_trap.var_1171b93e[0];
	var_f9b9263d = 0;
	while(true)
	{
		while(!(isdefined(var_9f02e39c.var_94de9684) && var_9f02e39c.var_94de9684))
		{
			waitframe(1);
		}
		while(var_9f02e39c.var_94de9684)
		{
			b_show = 0;
			foreach(e_player in level.players)
			{
				if(zm_utility::is_player_valid(e_player, 0, 0) && (isdefined(e_player.var_eb319d10) && e_player.var_eb319d10) && e_player istouching(vol_grate))
				{
					b_show = 1;
					break;
				}
			}
			if(b_show)
			{
				if(!var_f9b9263d)
				{
					var_f9b9263d = 1;
					var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 1);
				}
			}
			else if(var_f9b9263d)
			{
				var_f9b9263d = 0;
				var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
			}
			waitframe(1);
		}
		if(var_f9b9263d)
		{
			var_f9b9263d = 0;
			var_8a88c4c8 clientfield::set("" + #"hash_2407f687f7d24a83", 0);
		}
	}
}

/*
	Name: function_c8230683
	Namespace: namespace_2d756999
	Checksum: 0x7C83C1F0
	Offset: 0x3DA8
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_c8230683()
{
	level endon(#"end_game");
	if(zm_utility::function_e51dc2d8())
	{
		callback::on_connect(&function_cab1990a);
		array::thread_all(level.players, &function_cab1990a);
		level flag::wait_till(#"hash_4863d7214aa660e2");
		callback::remove_on_connect(&function_cab1990a);
		var_656fdc6c = getent("nardel", "targetname");
		var_656fdc6c delete();
		var_dd3ac19c = getent("narsho", "targetname");
		var_dd3ac19c show();
	}
	vol_roof = getent("vol_narrative_wipe", "targetname");
	vol_roof delete();
}

/*
	Name: function_cab1990a
	Namespace: namespace_2d756999
	Checksum: 0x85BBD781
	Offset: 0x3F28
	Size: 0x23E
	Parameters: 0
	Flags: Linked
*/
function function_cab1990a()
{
	self notify("68d0201c4315e715");
	self endon("68d0201c4315e715");
	level endon(#"end_game", #"hash_4863d7214aa660e2");
	self endon(#"disconnect");
	vol_roof = getent("vol_narrative_wipe", "targetname");
	while(true)
	{
		while(!(isdefined(self.var_1de56cc8) && self.var_1de56cc8))
		{
			waitframe(1);
		}
		b_tracking = 0;
		while(isdefined(self.var_1de56cc8) && self.var_1de56cc8)
		{
			v_origin = self getweaponmuzzlepoint();
			v_dir = self getweaponforwarddir();
			a_trace = beamtrace(v_origin, v_origin + (v_dir * 20000), 1, self);
			v_hit = a_trace[#"position"];
			if(isdefined(v_hit) && istouching(v_hit, vol_roof))
			{
				if(!b_tracking)
				{
					b_tracking = 1;
					n_start_time = gettime();
				}
				n_current_time = gettime();
				n_time_passed = n_current_time - n_start_time;
				n_time_passed = float(n_time_passed) / 1000;
				if(n_time_passed >= 6)
				{
					level flag::set(#"hash_4863d7214aa660e2");
					return;
				}
			}
			else
			{
				b_tracking = 0;
			}
			waitframe(1);
		}
	}
}

/*
	Name: function_b315d709
	Namespace: namespace_2d756999
	Checksum: 0x480A893B
	Offset: 0x4170
	Size: 0x43C
	Parameters: 0
	Flags: Linked
*/
function function_b315d709()
{
	level.var_f2dc2287 = spawnstruct();
	level.var_f2dc2287.var_12b6c455 = 1;
	level.var_f2dc2287.a_objects = [];
	level.var_f2dc2287.a_objects[1] = getent("t_narrative_25", "targetname");
	level.var_f2dc2287.a_objects[2] = getent("mdl_note_2", "targetname");
	level.var_f2dc2287.a_objects[3] = getent("mdl_blade_traps", "targetname");
	level.var_f2dc2287.a_objects[4] = getent("mdl_tattle_tale", "targetname");
	level.var_f2dc2287.a_objects[5] = struct::get("s_note_wall_1");
	level.var_f2dc2287.a_objects[6] = struct::get("s_note_wall_2");
	level.var_f2dc2287.a_objects[7] = struct::get("s_note_wall_3");
	level.var_f2dc2287.a_objects[8] = struct::get("s_note_wall_4");
	level.var_f2dc2287.a_objects[9] = struct::get("s_note_serpent");
	level.var_f2dc2287.a_objects[10] = struct::get("s_note_blood");
	level.var_f2dc2287.a_objects[11] = struct::get("s_note_steel");
	level.var_f2dc2287.a_objects[12] = struct::get("s_note_observe");
	level.var_f2dc2287.a_objects[13] = struct::get("s_note_reveal");
	level.var_f2dc2287.a_objects[14] = getent("reveal_blocker", "targetname");
	if(!zm_utility::function_e51dc2d8())
	{
		for(i = 2; i < 14; i++)
		{
			e_object = level.var_f2dc2287.a_objects[i];
			if(isentity(e_object))
			{
				e_object delete();
			}
		}
		level.var_f2dc2287.a_objects = undefined;
		return;
	}
	level.var_f2dc2287.a_objects[2] hide();
	level.var_f2dc2287.a_objects[3] hide();
	level.var_f2dc2287.a_objects[4] hide();
	level thread function_98d6ce32();
}

/*
	Name: function_98d6ce32
	Namespace: namespace_2d756999
	Checksum: 0xBD5BF489
	Offset: 0x45B8
	Size: 0x4B2
	Parameters: 0
	Flags: Linked
*/
function function_98d6ce32()
{
	trigger::wait_till("t_narrative_25", "targetname");
	function_801b77c0();
	trigger::wait_till("t_rempar_2", "targetname");
	function_801b77c0();
	trigger::wait_till("bladrem", "targetname");
	function_801b77c0();
	trigger::wait_till("remled", "targetname");
	function_2cb83322(#"hash_1404102ec1359017", #"hash_71fcbb6090ff031e");
	function_2cb83322(#"hash_1736e8c7a79a7db8", #"hash_2251bd5cecd3ebdb");
	function_2cb83322(#"hash_642834b4c1587ac9", #"hash_6b02638730f2f88c");
	function_2cb83322(#"hash_4ccddcb7cba5b2d2", #"hash_2897f70604cc0fb6");
	level.var_b2b15659 = 1;
	var_f2dc2287 = level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455];
	playsoundatposition(#"hash_2897f80604cc1169", var_f2dc2287.origin);
	function_d24a0f09(#"hash_2897f80604cc1169");
	playsoundatposition(#"hash_2897f50604cc0c50", var_f2dc2287.origin);
	function_d24a0f09(#"hash_2897f50604cc0c50");
	level.var_b2b15659 = 0;
	function_d6e81c01(#"hash_4832047b1941ace1", #"hash_3501eab062d8e553");
	function_d6e81c01(#"hash_2ee2e728ad3b547e", #"hash_4aca0608bf4fa64e");
	function_d6e81c01(#"hash_48477035102bb86f", #"hash_38bae751fa353d99");
	function_d6e81c01(#"hash_49fb781467abd24c", #"hash_634818c98eff6728");
	var_2cff1c1e = getent("mdl_massage_wall", "targetname");
	var_2cff1c1e clientfield::set("" + #"hash_2407f687f7d24a83", 1);
	level.var_f2dc2287.var_12b6c455++;
	level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455] zm_unitrigger::function_fac87205("");
	level.var_f2dc2287.var_12b6c455++;
	level.var_b2b15659 = 1;
	s_skull = struct::get("s_remvox");
	playsoundatposition(#"hash_46233f5f75541000", s_skull.origin);
	function_d24a0f09(#"hash_46233f5f75541000");
	mdl_wall = level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455];
	mdl_wall scene::play(#"p8_fxanim_zm_towers_wall_2_bundle", mdl_wall);
	level.var_b2b15659 = 0;
}

/*
	Name: function_801b77c0
	Namespace: namespace_2d756999
	Checksum: 0x6BE4C38C
	Offset: 0x4A78
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_801b77c0()
{
	level.var_f2dc2287.var_12b6c455++;
	level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455] show();
}

/*
	Name: function_2cb83322
	Namespace: namespace_2d756999
	Checksum: 0xFE4C542A
	Offset: 0x4AD0
	Size: 0x18A
	Parameters: 2
	Flags: Linked
*/
function function_2cb83322(var_1600546f, var_759598cf)
{
	level.var_f2dc2287.var_12b6c455++;
	s_crying = level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455];
	var_9185084 = spawn("script_origin", s_crying.origin);
	level thread function_415b58b1(var_1600546f, s_crying, var_9185084);
	s_crying zm_unitrigger::function_fac87205("");
	level notify(#"hash_53319c10defe971b");
	var_9185084 stopsounds();
	playsoundatposition(#"hash_70d9fd993e01154d", s_crying.origin);
	wait(0.75);
	level.var_b2b15659 = 1;
	playsoundatposition(var_759598cf, s_crying.origin);
	function_d24a0f09(var_759598cf);
	var_9185084 delete();
	level.var_b2b15659 = 0;
}

/*
	Name: function_415b58b1
	Namespace: namespace_2d756999
	Checksum: 0x7048A09A
	Offset: 0x4C68
	Size: 0x6E
	Parameters: 3
	Flags: Linked
*/
function function_415b58b1(var_1600546f, s_crying, var_9185084)
{
	level endon(#"game_end", #"hash_53319c10defe971b");
	while(true)
	{
		var_9185084 playsound(var_1600546f);
		wait(12);
	}
}

/*
	Name: function_d6e81c01
	Namespace: namespace_2d756999
	Checksum: 0x1C623421
	Offset: 0x4CE0
	Size: 0x192
	Parameters: 2
	Flags: Linked
*/
function function_d6e81c01(var_cc9813c7, var_e504825e)
{
	level.var_b2b15659 = 1;
	playsoundatposition(var_cc9813c7, level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455].origin);
	function_d24a0f09(var_cc9813c7);
	level.var_b2b15659 = 0;
	level.var_f2dc2287.var_12b6c455++;
	var_64c09f7f = level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455] zm_unitrigger::function_fac87205("");
	var_64c09f7f playsoundtoplayer(#"hash_cfcdb12c4cc0476", var_64c09f7f);
	wait(4);
	if(isdefined(var_e504825e))
	{
		level.var_b2b15659 = 1;
		playsoundatposition(var_e504825e, level.var_f2dc2287.a_objects[level.var_f2dc2287.var_12b6c455].origin);
		function_d24a0f09(var_e504825e);
		level.var_b2b15659 = 0;
	}
}

