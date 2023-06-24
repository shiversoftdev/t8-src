// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_loadout.gsc;
#using script_24c15fbbb838c794;
#using scripts\core_common\player\player_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_objects_shared.gsc;
#using scripts\core_common\scene_player_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;

class csceneplayer : csceneobject
{
	var _o_scene;
	var _str_shot;
	var var_55b4f21e;
	var _e;
	var _s;
	var _str_camera;
	var _str_team;
	var _func_get;
	var _n_streamer_req;
	var var_a3cc5416;
	var var_efc540b6;
	var _str_current_anim;

	/*
		Name: constructor
		Namespace: csceneplayer
		Checksum: 0xEC9DC3E3
		Offset: 0x328
		Size: 0x4E
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self._func_get = &scene::function_3d35d3ca;
		self._func_get_active = &scene::function_e941ea66;
		self._n_streamer_req = -1;
	}

	/*
		Name: destructor
		Namespace: csceneplayer
		Checksum: 0x72C337E5
		Offset: 0x67E0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: destroy_dev_info
		Namespace: csceneplayer
		Checksum: 0xAC88D01C
		Offset: 0x6750
		Size: 0x84
		Parameters: 0
		Flags: Linked
	*/
	function destroy_dev_info()
	{
		/#
			if(isdefined(level.hud_scene_dev_info1))
			{
				level.hud_scene_dev_info1 destroy();
			}
			if(isdefined(level.hud_scene_dev_info2))
			{
				level.hud_scene_dev_info2 destroy();
			}
			if(isdefined(level.hud_scene_dev_info3))
			{
				level.hud_scene_dev_info3 destroy();
			}
		#/
	}

	/*
		Name: display_dev_info
		Namespace: csceneplayer
		Checksum: 0x311E1151
		Offset: 0x6360
		Size: 0x3E4
		Parameters: 0
		Flags: Linked
	*/
	function display_dev_info()
	{
		/#
			if(isstring(_o_scene._s.devstate) && getdvarint(#"scr_show_shot_info_for_igcs", 0))
			{
				if(!isdefined(level.hud_scene_dev_info1))
				{
					level.hud_scene_dev_info1 = newdebughudelem();
				}
				level.hud_scene_dev_info1.alignx = "";
				level.hud_scene_dev_info1.aligny = "";
				level.hud_scene_dev_info1.horzalign = "";
				level.hud_scene_dev_info1.y = 400;
				level.hud_scene_dev_info1.fontscale = 1.3;
				level.hud_scene_dev_info1.color = (0.4392157, 0.5019608, 0.5647059);
				level.hud_scene_dev_info1 settext("" + toupper(function_9e72a96(_o_scene._str_name)));
				if(!isdefined(level.hud_scene_dev_info2))
				{
					level.hud_scene_dev_info2 = newdebughudelem();
				}
				level.hud_scene_dev_info2.alignx = "";
				level.hud_scene_dev_info2.aligny = "";
				level.hud_scene_dev_info2.horzalign = "";
				level.hud_scene_dev_info2.y = 420;
				level.hud_scene_dev_info2.fontscale = 1.3;
				level.hud_scene_dev_info2.color = (0.4392157, 0.5019608, 0.5647059);
				level.hud_scene_dev_info2 settext("" + function_9e72a96(_str_shot));
				if(!isdefined(level.hud_scene_dev_info3))
				{
					level.hud_scene_dev_info3 = newdebughudelem();
				}
				level.hud_scene_dev_info3.alignx = "";
				level.hud_scene_dev_info3.aligny = "";
				level.hud_scene_dev_info3.horzalign = "";
				level.hud_scene_dev_info3.y = 440;
				level.hud_scene_dev_info3.fontscale = 1.3;
				level.hud_scene_dev_info3.color = (0.4392157, 0.5019608, 0.5647059);
				var_208dd9f0 = (isdefined(var_55b4f21e.devstate) ? var_55b4f21e.devstate : _o_scene._s.devstate);
				level.hud_scene_dev_info3 settext("" + function_9e72a96(var_208dd9f0));
			}
			else
			{
				destroy_dev_info();
			}
		#/
	}

	/*
		Name: animation_lookup
		Namespace: csceneplayer
		Checksum: 0x7F2BFC7D
		Offset: 0x6130
		Size: 0x228
		Parameters: 3
		Flags: Linked
	*/
	function animation_lookup(animation, ent = _e, b_camera = 0)
	{
		if(isdefined(_s.var_2df1a365) && isdefined(level.heroes) && level.heroes.size)
		{
			n_shot = csceneobject::get_shot(_str_shot);
			foreach(e_hero in level.heroes)
			{
				var_c37dad97 = e_hero;
				break;
			}
			var_d57bf586 = var_c37dad97.animname;
			if(isdefined(n_shot) && isdefined(_s.var_2df1a365[n_shot]) && isdefined(_s.var_2df1a365[n_shot][var_d57bf586]))
			{
				if(b_camera && isdefined(_s.var_2df1a365[n_shot][var_d57bf586].var_e6b1664b))
				{
					return _s.var_2df1a365[n_shot][var_d57bf586].var_e6b1664b;
				}
				if(!b_camera && isdefined(_s.var_2df1a365[n_shot][var_d57bf586].var_554345e4))
				{
					return _s.var_2df1a365[n_shot][var_d57bf586].var_554345e4;
				}
			}
		}
		return animation;
	}

	/*
		Name: function_6c1c67c1
		Namespace: csceneplayer
		Checksum: 0xF64BB950
		Offset: 0x6010
		Size: 0x114
		Parameters: 0
		Flags: Linked
	*/
	function function_6c1c67c1()
	{
		if(csceneobject::is_shared_player())
		{
			if(isdefined(_str_camera))
			{
				return true;
			}
		}
		else if(csceneobject::function_527113ae())
		{
			if(isdefined(_str_camera))
			{
				return true;
			}
			if(isdefined(_o_scene._a_objects))
			{
				foreach(obj in _o_scene._a_objects)
				{
					if(obj._s.type === "sharedplayer" && [[ obj ]]->function_6c1c67c1())
					{
						return true;
					}
				}
			}
		}
		return false;
	}

	/*
		Name: stop_camera
		Namespace: csceneplayer
		Checksum: 0x48562CD1
		Offset: 0x5FE0
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function stop_camera(player)
	{
		endcamanimscripted(player);
	}

	/*
		Name: function_f85ac52
		Namespace: csceneplayer
		Checksum: 0x59FE3436
		Offset: 0x5F58
		Size: 0x80
		Parameters: 1
		Flags: Linked
	*/
	function function_f85ac52(player)
	{
		var_82e125b6 = (isdefined(var_55b4f21e.extracamindex) ? var_55b4f21e.extracamindex : _s.extracamindex);
		if(isdefined(var_82e125b6))
		{
			var_e5489dff = int(var_82e125b6) - 1;
		}
		return var_e5489dff;
	}

	/*
		Name: _camanimscripted
		Namespace: csceneplayer
		Checksum: 0x17FFDD08
		Offset: 0x5DD0
		Size: 0x17C
		Parameters: 5
		Flags: Linked
	*/
	function _camanimscripted(player, str_camera, v_origin, v_angles, n_start_time = 0)
	{
		player notify(#"camanimscripted");
		player endon(#"camanimscripted", #"disconnect");
		if(_o_scene._s scene::is_igc())
		{
			player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
		}
		var_57949b2d = getcamanimtime(str_camera) * n_start_time;
		var_41193b94 = int(gettime() - var_57949b2d);
		player dontinterpolate();
		camanimscripted(player, str_camera, var_41193b94, v_origin, v_angles);
		wait_for_camera(str_camera, n_start_time);
		player dontinterpolate();
	}

	/*
		Name: play_camera_on_player
		Namespace: csceneplayer
		Checksum: 0x849A0D7B
		Offset: 0x5CA0
		Size: 0x128
		Parameters: 2
		Flags: Linked
	*/
	function play_camera_on_player(player, n_start_time)
	{
		if(!scene::check_team(player.team, _str_team))
		{
			return;
		}
		e_align = csceneobject::get_align_ent();
		v_origin = (isdefined(e_align.origin) ? e_align.origin : (0, 0, 0));
		v_angles = (isdefined(e_align.angles) ? e_align.angles : (0, 0, 0));
		self thread _camanimscripted(player, (isdefined(player.var_36fa161e) ? player.var_36fa161e : _str_camera), v_origin, v_angles, n_start_time);
		player.var_36fa161e = undefined;
		[[ self ]]->on_play_anim(player);
	}

	/*
		Name: play_camera
		Namespace: csceneplayer
		Checksum: 0xF4229DE6
		Offset: 0x5A38
		Size: 0x25E
		Parameters: 2
		Flags: Linked
	*/
	function play_camera(animation, n_start_time = 0)
	{
		flagsys::set(#"camera_playing");
		if(csceneobject::is_shared_player())
		{
			a_players = [[_func_get]](_o_scene._str_team);
			foreach(player in a_players)
			{
				self._str_camera = [[ self ]]->animation_lookup(animation, player, 1);
				player.var_36fa161e = _str_camera;
				thread play_camera_on_player(player, n_start_time);
			}
			wait_for_camera(_str_camera, n_start_time);
		}
		else
		{
			self._str_camera = [[ self ]]->animation_lookup(animation, _e, 1);
			_e.var_36fa161e = _str_camera;
			thread play_camera_on_player(_e, n_start_time);
			wait_for_camera(_str_camera, n_start_time);
		}
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				csceneobject::log(((toupper(_s.type) + "") + _str_camera) + "");
			}
		#/
		flagsys::clear(#"camera_playing");
		self._str_camera = undefined;
	}

	/*
		Name: wait_for_camera
		Namespace: csceneplayer
		Checksum: 0x230452D9
		Offset: 0x5970
		Size: 0xBC
		Parameters: 2
		Flags: Linked
	*/
	function wait_for_camera(str_cam, n_start_time)
	{
		self endon(#"skip_camera_anims", _str_shot + "active");
		if(iscamanimlooping(str_cam))
		{
			level waittill(#"forever");
		}
		else
		{
			var_d4594f1 = float(getcamanimtime(str_cam)) / 1000;
			scene::wait_server_time(var_d4594f1, n_start_time);
		}
	}

	/*
		Name: function_6e4dc270
		Namespace: csceneplayer
		Checksum: 0xDB58E635
		Offset: 0x5898
		Size: 0xCE
		Parameters: 1
		Flags: Linked
	*/
	function function_6e4dc270(player)
	{
		player endon(#"new_shot", #"disconnect");
		_o_scene waittilltimeout(0.1, #"scene_done", #"scene_stop", #"scene_skip_completed");
		if(_n_streamer_req != -1)
		{
			player playerstreamerrequest("clear", player.var_231881b1[_o_scene._str_name]);
		}
		player.streamer_hint_playing = undefined;
	}

	/*
		Name: function_509b9f47
		Namespace: csceneplayer
		Checksum: 0x6105D395
		Offset: 0x5780
		Size: 0x10C
		Parameters: 1
		Flags: Linked
	*/
	function function_509b9f47(player)
	{
		player notify(#"hash_375ad02201949a8d");
		player endon(#"camanimscripted", #"hash_375ad02201949a8d", #"disconnect");
		_o_scene waittilltimeout(0.1, #"scene_done", #"scene_stop", #"scene_skip_completed");
		stop_camera(player);
		/#
			if(isdefined(_o_scene._b_testing) && _o_scene._b_testing)
			{
				p_host = util::gethostplayer();
				stop_camera(p_host);
			}
		#/
	}

	/*
		Name: function_894716e2
		Namespace: csceneplayer
		Checksum: 0xB25B3173
		Offset: 0x5638
		Size: 0x13A
		Parameters: 1
		Flags: Linked
	*/
	function function_894716e2(player)
	{
		if(isbot(player))
		{
			return;
		}
		if(isdefined(var_55b4f21e.var_6eb7f9a0))
		{
			switch(var_55b4f21e.var_6eb7f9a0)
			{
				case "bank1":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 0);
					break;
				}
				case "bank2":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 1);
					break;
				}
				case "bank3":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 2);
					break;
				}
				case "bank4":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 3);
					break;
				}
			}
		}
	}

	/*
		Name: _cleanup_player
		Namespace: csceneplayer
		Checksum: 0x4DD41A12
		Offset: 0x5150
		Size: 0x4DC
		Parameters: 1
		Flags: Linked
	*/
	function _cleanup_player(player)
	{
		if(!isdefined(player))
		{
			return;
		}
		if(csceneobject::function_527113ae() && player flagsys::get(#"shared_igc"))
		{
			return;
		}
		if(csceneobject::is_shared_player() && player flagsys::get(#"hash_7cddd51e45d3ff3e"))
		{
			return;
		}
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				printtoprightln("");
			}
		#/
		player notify(#"hash_7ba9e3058f933eb");
		player.var_c3a79d20 = undefined;
		player.scene_set_visible_time = level.time;
		player setvisibletoall();
		player val::reset(#"scene", "hide");
		player flagsys::clear(#"shared_igc");
		player flagsys::clear(#"scene");
		player flagsys::clear(#"scene_interactive_shot");
		player flagsys::clear(#"hash_2f30b24ec0e23830");
		player flagsys::clear(#"hash_e2ce599b208682a");
		player flagsys::clear(#"hash_f21f320f68c0457");
		player util::delay(0.1, array("new_shot", "disconnect"), &scene::set_igc_active, 0, _o_scene._str_name);
		player._scene_object = undefined;
		player.anim_debug_name = undefined;
		player.current_scene = undefined;
		player.scene_takedamage = undefined;
		player._scene_old_gun_removed = undefined;
		if(!([[ _o_scene ]]->function_19015532(_str_shot)) || _o_scene._str_mode === "single")
		{
			player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
			var_700fed0d = player getentitynumber() + 2;
			player util::delay_network_frames(var_700fed0d, "disconnect", &clientfield::set_to_player, "postfx_cateye", 0);
		}
		n_camera_tween_out = csceneobject::get_camera_tween_out();
		if(n_camera_tween_out > 0)
		{
			player startcameratween(n_camera_tween_out);
		}
		player allowstand(1);
		player allowcrouch(1);
		player allowprone(1);
		player sethighdetail(0);
		player util::function_7f49ffb7(-1);
		[[ self ]]->_reset_values(player);
		function_d3541c6f(player);
		thread function_6e4dc270(player);
		thread function_509b9f47(player);
		function_894716e2(player);
		/#
			if(player === level.host)
			{
				player util::delay(0.5, "", &destroy_dev_info);
			}
		#/
	}

	/*
		Name: _cleanup
		Namespace: csceneplayer
		Checksum: 0x4962716
		Offset: 0x5128
		Size: 0x1C
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
		_cleanup_player(_e);
	}

	/*
		Name: set_player_stance
		Namespace: csceneplayer
		Checksum: 0xAA85D6BF
		Offset: 0x4FF0
		Size: 0x12C
		Parameters: 1
		Flags: Linked
	*/
	function set_player_stance(player)
	{
		if(_s.playerstance === "crouch")
		{
			player allowstand(0);
			player allowcrouch(1);
			player allowprone(0);
		}
		else
		{
			if(_s.playerstance === "prone")
			{
				player allowstand(0);
				player allowcrouch(0);
				player allowprone(1);
			}
			else
			{
				player allowstand(1);
				player allowcrouch(0);
				player allowprone(0);
			}
		}
	}

	/*
		Name: revive_player
		Namespace: csceneplayer
		Checksum: 0xA82A1156
		Offset: 0x4F70
		Size: 0x78
		Parameters: 1
		Flags: Linked
	*/
	function revive_player(player)
	{
		if(level.gameended)
		{
			return;
		}
		if(player.sessionstate === "spectator")
		{
			player thread [[level.spawnplayer]]();
		}
		else if(player laststand::player_is_in_laststand())
		{
			player notify(#"auto_revive");
		}
	}

	/*
		Name: on_play_anim
		Namespace: csceneplayer
		Checksum: 0x72325974
		Offset: 0x4EC0
		Size: 0xA2
		Parameters: 1
		Flags: Linked
	*/
	function on_play_anim(player)
	{
		if(_n_streamer_req != -1 && !csceneobject::is_skipping_scene() && (!(isdefined(player.streamer_hint_playing) && player.streamer_hint_playing)))
		{
			player playerstreamerrequest("play", player.var_231881b1[_o_scene._str_name]);
			player.streamer_hint_playing = 1;
		}
	}

	/*
		Name: function_9a7dd9f2
		Namespace: csceneplayer
		Checksum: 0x175DA82F
		Offset: 0x4C98
		Size: 0x220
		Parameters: 1
		Flags: Linked
	*/
	function function_9a7dd9f2(player)
	{
		player notify(#"hash_feb654ece8faa3d");
		thread function_31a89cb0(player, 0);
		thread function_d0cf938(player, 0);
		foreach(o_obj in _o_scene._a_objects)
		{
			if(isdefined(o_obj))
			{
				var_17c01da9 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
				if(o_obj != self && isdefined(var_17c01da9.lvlstart_stomach_))
				{
					thread [[ o_obj ]]->_play_anim(var_17c01da9.lvlstart_stomach_, 1, 0.2, 0, 0);
				}
			}
		}
		var_609ac4c9 = _s.shots[csceneobject::get_shot(_str_shot)];
		if(isdefined(var_609ac4c9.lvlstart_stomach_))
		{
			csceneobject::_play_anim(var_609ac4c9.lvlstart_stomach_, 1, 0.2, 0, 0);
		}
		_reset_values();
		player scene::set_igc_active(0, _o_scene._str_name);
		player kill();
		[[ _o_scene ]]->stop();
	}

	/*
		Name: function_ef1eb90b
		Namespace: csceneplayer
		Checksum: 0x6414530E
		Offset: 0x4AE8
		Size: 0x1A4
		Parameters: 1
		Flags: Linked
	*/
	function function_ef1eb90b(player)
	{
		thread function_31a89cb0(player, 0);
		thread function_d0cf938(player, 0);
		foreach(o_obj in _o_scene._a_objects)
		{
			if(isdefined(o_obj))
			{
				var_17c01da9 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
				if(o_obj != self && isdefined(var_17c01da9.var_c474be53))
				{
					thread [[ o_obj ]]->_play_anim(var_17c01da9.var_c474be53, 1, 0.2, 0, 0);
				}
			}
		}
		var_609ac4c9 = _s.shots[csceneobject::get_shot(_str_shot)];
		if(isdefined(var_609ac4c9.var_c474be53))
		{
			csceneobject::_play_anim(var_609ac4c9.var_c474be53, 1, 0.2, 0, 0);
		}
	}

	/*
		Name: function_a27af0ae
		Namespace: csceneplayer
		Checksum: 0x329DFBE5
		Offset: 0x4920
		Size: 0x1BC
		Parameters: 1
		Flags: Linked
	*/
	function function_a27af0ae(player)
	{
		player notify(#"hash_feb654ece8faa3d");
		thread function_31a89cb0(player, 0);
		thread function_d0cf938(player, 0);
		foreach(o_obj in _o_scene._a_objects)
		{
			if(isdefined(o_obj))
			{
				var_17c01da9 = o_obj._s.shots[csceneobject::get_shot(_str_shot)];
				if(o_obj != self && isdefined(var_17c01da9.var_5bb36583))
				{
					thread [[ o_obj ]]->_play_anim(var_17c01da9.var_5bb36583, 1, 0.2, 0, 0);
				}
			}
		}
		var_609ac4c9 = _s.shots[csceneobject::get_shot(_str_shot)];
		if(isdefined(var_609ac4c9.var_5bb36583))
		{
			csceneobject::_play_anim(var_609ac4c9.var_5bb36583, 1, 0.2, 0, 0);
		}
	}

	/*
		Name: function_d0cf938
		Namespace: csceneplayer
		Checksum: 0x54838516
		Offset: 0x4848
		Size: 0xD0
		Parameters: 2
		Flags: Linked
	*/
	function function_d0cf938(player, b_enable = 1)
	{
		player endon(#"hash_1aa7e630a34bee50");
		if(b_enable)
		{
			while(isalive(player))
			{
				player playrumbleonentity("damage_heavy");
				wait(0.1);
			}
			player stoprumble("damage_heavy");
		}
		else
		{
			player stoprumble("damage_heavy");
			player notify(#"hash_1aa7e630a34bee50");
		}
	}

	/*
		Name: function_31a89cb0
		Namespace: csceneplayer
		Checksum: 0x2BE84B7B
		Offset: 0x4770
		Size: 0xD0
		Parameters: 2
		Flags: Linked
	*/
	function function_31a89cb0(player, b_enable = 1)
	{
		player endon(#"hash_3fdc27904c7ef691");
		if(b_enable)
		{
			while(isalive(player))
			{
				player playrumbleonentity("damage_light");
				wait(0.3);
			}
			player stoprumble("damage_light");
		}
		else
		{
			player stoprumble("damage_light");
			player notify(#"hash_3fdc27904c7ef691");
		}
	}

	/*
		Name: function_d4446494
		Namespace: csceneplayer
		Checksum: 0xF28938D
		Offset: 0x4170
		Size: 0x5F6
		Parameters: 1
		Flags: Linked
	*/
	function function_d4446494(player)
	{
		player endon(#"hash_7ba9e3058f933eb", #"hash_feb654ece8faa3d", #"death");
		while(true)
		{
			var_be17187b = undefined;
			var_be17187b = player waittill(#"hash_940a817baf9765e");
			if(!isdefined(var_be17187b.str_input))
			{
				var_be17187b.str_input = "";
			}
			switch(var_be17187b.str_input)
			{
				case "move_up":
				case "move_down":
				{
					if(var_be17187b.str_input == "move_up")
					{
						if(player gamepadusedlast())
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_66ac13c66930481e");
						}
						else
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_2e61b9986055044e");
						}
					}
					else
					{
						if(player gamepadusedlast())
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_f7f3ef0446b4447");
						}
						else
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_63aa233af2b054f1");
						}
					}
					break;
				}
				case "move_right":
				case "move_left":
				{
					if(var_be17187b.str_input == "move_right")
					{
						if(player gamepadusedlast())
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_b89e8fe23b5a6ff");
						}
						else
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_5cafbb3ef224b89");
						}
					}
					else
					{
						if(player gamepadusedlast())
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_43fe6cadb07b27b2");
						}
						else
						{
							level.interactive_shot interactive_shot::set_text(player, #"hash_121d78dfceea3bf2");
						}
					}
					break;
				}
				case "jump":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_5b57ca9476df902b");
					break;
				}
				case "stance":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_30214ec564c2c09b");
					break;
				}
				case "use":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_1c489083f5cdb3f6");
					break;
				}
				case "weapon_switch":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_5d8ce20bafb14fec");
					break;
				}
				case "sprint":
				{
					if(player gamepadusedlast())
					{
						level.interactive_shot interactive_shot::set_text(player, #"hash_6b873520c198df93");
					}
					else
					{
						level.interactive_shot interactive_shot::set_text(player, #"hash_7f72586820c8b86d");
					}
					break;
				}
				case "melee":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_6c4731677fa269b1");
					break;
				}
				case "attack":
				{
					break;
				}
				case "dpad_up":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_327b92f099f4b62e");
					break;
				}
				case "dpad_down":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_51f4288480f483f7");
					break;
				}
				case "dpad_left":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_2f8bb64325eeac62");
					break;
				}
				case "dpad_right":
				{
					level.interactive_shot interactive_shot::set_text(player, #"hash_2c841879f1d933ef");
					break;
				}
				default:
				{
					level.interactive_shot interactive_shot::set_text(player, #"");
					break;
				}
			}
		}
	}

	/*
		Name: function_bd3a7030
		Namespace: csceneplayer
		Checksum: 0x2554F987
		Offset: 0x4018
		Size: 0x150
		Parameters: 2
		Flags: Linked
	*/
	function function_bd3a7030(player, var_a0332034)
	{
		if(!level.interactive_shot interactive_shot::is_open(player))
		{
			level.interactive_shot interactive_shot::open(player);
		}
		thread function_d4446494(player);
		player notify(#"hash_940a817baf9765e", {#str_input:var_a0332034});
		var_be17187b = undefined;
		var_be17187b = player waittill(#"hash_7ba9e3058f933eb", #"hash_feb654ece8faa3d", #"death");
		if(isdefined(player) && level.interactive_shot interactive_shot::is_open(player))
		{
			level.interactive_shot interactive_shot::close(player);
		}
		if(var_be17187b._notify == "death")
		{
			[[ _o_scene ]]->stop();
		}
	}

	/*
		Name: function_762978f8
		Namespace: csceneplayer
		Checksum: 0x8EBD13EB
		Offset: 0x3A30
		Size: 0x5DA
		Parameters: 3
		Flags: Linked
	*/
	function function_762978f8(player, var_ec50a0d3, var_966ea21d)
	{
		if(isbot(player) && function_c503dca9(player, var_ec50a0d3))
		{
			if(player scene::function_268bfc72() && var_966ea21d)
			{
				if(player flagsys::get(#"hash_6ce14241f77af1e7"))
				{
					return "combat";
				}
				if(var_ec50a0d3.var_9532f6db == "move_up" || var_ec50a0d3.var_9532f6db == "move_right")
				{
					if(player scene::function_6d361d2d())
					{
						return -1;
					}
					return 1;
				}
				if(var_ec50a0d3.var_9532f6db == "move_down" || var_ec50a0d3.var_9532f6db == "move_left")
				{
					if(player scene::function_6d361d2d())
					{
						return 1;
					}
					return -1;
				}
				if(player scene::function_6d361d2d())
				{
					return 0;
				}
				return 1;
			}
			if(var_ec50a0d3.var_9532f6db == "move_up" || var_ec50a0d3.var_9532f6db == "move_right" || var_ec50a0d3.var_9532f6db == "move_down" || var_ec50a0d3.var_9532f6db == "move_left")
			{
				return 0;
			}
			return 0;
		}
		if(!level.interactive_shot interactive_shot::is_open(player))
		{
			return 0;
		}
		if(player flagsys::get(#"hash_6ce14241f77af1e7") && (!(isdefined(var_ec50a0d3.var_441cbab8) && var_ec50a0d3.var_441cbab8)) && var_966ea21d)
		{
			return "combat";
		}
		switch(var_ec50a0d3.var_9532f6db)
		{
			case "move_up":
			case "move_down":
			{
				v_movement = player getnormalizedmovement();
				return v_movement[0];
			}
			case "move_right":
			case "move_left":
			{
				v_movement = player getnormalizedmovement();
				return v_movement[1];
			}
			case "jump":
			{
				return (player actionbuttonpressed() ? 1 : 0);
				break;
			}
			case "stance":
			{
				return (player stancebuttonpressed() ? 1 : 0);
				break;
			}
			case "use":
			{
				return (player usebuttonpressed() ? 1 : 0);
				break;
			}
			case "weapon_switch":
			{
				return (player weaponswitchbuttonpressed() ? 1 : 0);
				break;
			}
			case "sprint":
			{
				return (player sprintbuttonpressed() ? 1 : 0);
				break;
			}
			case "melee":
			{
				return (player meleebuttonpressed() ? 1 : 0);
				break;
			}
			case "attack":
			{
				return (var_966ea21d ? 1 : 0);
				break;
			}
			case "dpad_up":
			{
				return (player actionslotonebuttonpressed() ? 1 : 0);
				break;
			}
			case "dpad_down":
			{
				return (player actionslottwobuttonpressed() ? 1 : 0);
				break;
			}
			case "dpad_left":
			{
				return (player actionslotthreebuttonpressed() ? 1 : 0);
				break;
			}
			case "dpad_right":
			{
				return (player actionslotfourbuttonpressed() ? 1 : 0);
				break;
			}
			default:
			{
				v_movement = player getnormalizedmovement();
				return v_movement[0];
			}
		}
	}

	/*
		Name: function_c503dca9
		Namespace: csceneplayer
		Checksum: 0xC19CE402
		Offset: 0x3770
		Size: 0x2B2
		Parameters: 2
		Flags: Linked
	*/
	function function_c503dca9(player, var_ec50a0d3)
	{
		a_players = array::exclude(util::get_players(), player);
		foreach(player_other in a_players)
		{
			n_height_diff = abs(player_other.origin[2] - player.origin[2]);
			if(distancesquared(player.origin, player_other.origin) < 16384)
			{
				if(var_ec50a0d3.var_9532f6db == "move_up" && player.origin[2] < player_other.origin[2])
				{
					return false;
				}
				if(var_ec50a0d3.var_9532f6db == "move_down" && player.origin[2] > player_other.origin[2])
				{
					return false;
				}
				var_b52c361d = 0;
				var_55d77e67 = 0;
				var_9d0b2a04 = vectordot(anglestoright(player.angles), vectornormalize(player.origin - player_other.origin));
				if(var_9d0b2a04 > 0)
				{
					var_b52c361d = 1;
				}
				else
				{
					var_55d77e67 = 1;
				}
				if(var_ec50a0d3.var_9532f6db == "move_left" && var_b52c361d && n_height_diff < 32)
				{
					return false;
				}
				if(var_ec50a0d3.var_9532f6db == "move_right" && var_55d77e67 && n_height_diff < 32)
				{
					return false;
				}
			}
		}
		return true;
	}

	/*
		Name: function_7d761e79
		Namespace: csceneplayer
		Checksum: 0x3ED48067
		Offset: 0x2278
		Size: 0x14F0
		Parameters: 1
		Flags: Linked
	*/
	function function_7d761e79(player)
	{
		player notify(#"hash_7ba9e3058f933eb");
		player endon(#"hash_7ba9e3058f933eb", #"death");
		b_movement = 1;
		var_1c45c7f8 = 0;
		var_966ea21d = 0;
		var_a3cc5416 = (isdefined(var_a3cc5416) ? var_a3cc5416 : 0.0001);
		self.var_a3cc5416 = undefined;
		var_ec50a0d3 = _s.shots[csceneobject::get_shot(_str_shot)];
		player flagsys::set(#"scene_interactive_shot");
		player.player_anim_look_enabled = 1;
		player.player_anim_clamp_right = (isdefined(player.player_anim_clamp_right) ? player.player_anim_clamp_right : 75);
		player.player_anim_clamp_left = (isdefined(player.player_anim_clamp_left) ? player.player_anim_clamp_left : 75);
		player.player_anim_clamp_top = (isdefined(player.player_anim_clamp_top) ? player.player_anim_clamp_top : 180);
		player.player_anim_clamp_bottom = (isdefined(player.player_anim_clamp_bottom) ? player.player_anim_clamp_bottom : 60);
		player.var_c3a79d20 = 1;
		thread function_bd3a7030(player, var_ec50a0d3.var_9532f6db);
		self._str_current_anim = csceneobject::get_animation_name(_str_shot);
		while(true)
		{
			result = function_762978f8(player, var_ec50a0d3, var_966ea21d);
			if(result === "combat")
			{
				n_movement = undefined;
				b_pressed = undefined;
			}
			else
			{
				if(isfloat(result))
				{
					n_movement = result;
					b_pressed = undefined;
					if(abs(n_movement) < 0.5)
					{
						n_movement = 0;
					}
				}
				else
				{
					n_movement = undefined;
					b_pressed = result;
				}
			}
			foreach(o_obj in _o_scene._a_objects)
			{
				o_obj.var_efc540b6 = [[ o_obj ]]->function_376c9d87(var_ec50a0d3, n_movement, player);
				if(!isdefined(o_obj.var_efc540b6))
				{
					o_obj.var_efc540b6 = (isdefined(o_obj._str_current_anim) ? o_obj._str_current_anim : csceneobject::get_animation_name(_str_shot));
					if(o_obj === self)
					{
						var_f2b99dab = 1;
					}
				}
			}
			/#
				assert(isdefined(var_efc540b6), "");
			#/
			if(isdefined(var_ec50a0d3.var_769fadce) && var_ec50a0d3.var_769fadce)
			{
				var_4a92a676 = getanimlength(_str_current_anim);
				var_7a496fd5 = (isdefined(var_ec50a0d3.var_3ee70278) ? var_ec50a0d3.var_3ee70278 : var_4a92a676 / 2);
				var_7a496fd5 = math::clamp(var_7a496fd5, 0, var_4a92a676);
				var_33d5f97d = var_4a92a676;
				var_1d3b9f6c = 0;
				foreach(o_obj in _o_scene._a_objects)
				{
					thread [[ o_obj ]]->_play_anim(o_obj._str_current_anim, 1, 0.2, undefined, 0);
				}
				thread function_31a89cb0(player, 1);
				while(var_7a496fd5 > 0)
				{
					var_7a496fd5 = var_7a496fd5 - (float(function_60d95f53()) / 1000);
					var_33d5f97d = var_33d5f97d - (float(function_60d95f53()) / 1000);
					b_result = function_762978f8(player, var_ec50a0d3, var_966ea21d);
					if(b_result)
					{
						var_1d3b9f6c = 1;
						player notify(#"hash_feb654ece8faa3d");
						while(var_7a496fd5 > 0)
						{
							waitframe(1);
							var_7a496fd5 = var_7a496fd5 - (float(function_60d95f53()) / 1000);
						}
						function_a27af0ae(player);
						var_a3cc5416 = 1;
						break;
					}
					waitframe(1);
				}
				if(!var_1d3b9f6c)
				{
					thread function_31a89cb0(player, 0);
					thread function_d0cf938(player, 1);
					while(var_33d5f97d > 0)
					{
						var_33d5f97d = var_33d5f97d - (float(function_60d95f53()) / 1000);
						b_result = function_762978f8(player, var_ec50a0d3, var_966ea21d);
						if(b_result)
						{
							var_1d3b9f6c = 1;
							player notify(#"hash_feb654ece8faa3d");
							while(var_33d5f97d > 0)
							{
								waitframe(1);
								var_33d5f97d = var_33d5f97d - (float(function_60d95f53()) / 1000);
							}
							function_ef1eb90b(player);
							var_a3cc5416 = 1;
							break;
						}
						waitframe(1);
					}
				}
				if(!var_1d3b9f6c)
				{
					thread function_9a7dd9f2(player);
					return;
				}
			}
			else
			{
				if(result === "combat" && (!(isdefined(var_ec50a0d3.var_441cbab8) && var_ec50a0d3.var_441cbab8)))
				{
					if(isarray(player.var_8826a030) && player.var_8826a030.size)
					{
						var_c09527fe = arraygetclosest(player.origin, player.var_8826a030);
						v_to_target = var_c09527fe.origin - player.origin;
						v_to_target = vectornormalize(v_to_target);
						var_59c304d1 = vectortoangles(v_to_target);
					}
					else
					{
						var_59c304d1 = player getplayerangles();
					}
					var_1cd52bd9 = player.origin;
					player animation::stop(0);
					util::wait_network_frame();
					var_208325df = 0;
					if(isdefined(var_55b4f21e.var_f251a00e))
					{
						/#
							assert(isassetloaded("", var_55b4f21e.var_f251a00e), ("" + var_55b4f21e.var_f251a00e) + "");
						#/
						var_208325df = player gestures::function_b204f6e3(var_55b4f21e.var_f251a00e, undefined, 0, 0);
					}
					e_player_link = util::spawn_model("tag_origin", var_1cd52bd9, var_59c304d1);
					player playerlinktodelta(e_player_link, undefined, 1, player.player_anim_clamp_right, player.player_anim_clamp_left, player.player_anim_clamp_top, player.player_anim_clamp_bottom);
					if(isanimlooping(var_efc540b6))
					{
						var_912e843b = util::spawn_player_clone(player, var_efc540b6, csceneobject::get_align_ent(), 1);
						var_912e843b setinvisibletoplayer(player);
						player setinvisibletoall();
					}
					player notify(#"hash_feb654ece8faa3d");
					while(player flagsys::get(#"hash_6ce14241f77af1e7"))
					{
						waitframe(1);
					}
					if(var_208325df)
					{
						player stopgestureviewmodel(var_55b4f21e.var_f251a00e, 1);
					}
					if(isdefined(e_player_link))
					{
						e_player_link delete();
					}
					if(isdefined(var_912e843b))
					{
						var_912e843b delete();
					}
					player setvisibletoall();
					foreach(o_obj in _o_scene._a_objects)
					{
						thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0.2, var_a3cc5416, 0, 1);
					}
				}
				else
				{
					if(isdefined(b_pressed) && b_pressed && function_c503dca9(player, var_ec50a0d3))
					{
						player notify(#"hash_feb654ece8faa3d");
						foreach(o_obj in _o_scene._a_objects)
						{
							if(isdefined(o_obj) && o_obj != self && isdefined(o_obj.var_efc540b6) && !var_1c45c7f8)
							{
								thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0.2, var_a3cc5416);
							}
						}
						if(!var_1c45c7f8)
						{
							if(isanimlooping(var_efc540b6))
							{
								thread csceneobject::_play_anim(var_efc540b6, 1, 0.2, 0);
							}
							else
							{
								csceneobject::_play_anim(var_efc540b6, 1, 0.2, 0);
							}
						}
						var_a3cc5416 = 1;
					}
					else
					{
						if(isdefined(var_f2b99dab) && var_f2b99dab || (n_movement === 0 && b_movement) || (!isdefined(n_movement) && (!(isdefined(b_pressed) && b_pressed))))
						{
							b_movement = 0;
							var_f2b99dab = undefined;
							foreach(o_obj in _o_scene._a_objects)
							{
								if(isanimlooping(o_obj.var_efc540b6) && !var_1c45c7f8)
								{
									var_1c45c7f8 = 1;
									thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0.2);
									continue;
								}
								if(!isanimlooping(o_obj.var_efc540b6))
								{
									thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0, var_a3cc5416, undefined, 1);
								}
							}
							var_966ea21d = 1;
						}
						else if(isdefined(n_movement) && n_movement != 0)
						{
							b_movement = 1;
							n_anim_length = getanimlength(_str_current_anim);
							var_5df5e79a = abs(n_movement);
							n_update_time = (float(function_60d95f53()) / 1000) / n_anim_length;
							var_ea474464 = math::clamp(var_5df5e79a, 1, 1);
							if(csceneobject::function_a808aac7())
							{
								var_a3cc5416 = var_a3cc5416 - (n_update_time * var_ea474464);
								var_f667af2f = 1 - var_a3cc5416;
							}
							else
							{
								var_a3cc5416 = var_a3cc5416 + (n_update_time * var_ea474464);
								var_f667af2f = var_a3cc5416;
							}
							var_f667af2f = math::clamp(var_f667af2f, 0, 1);
							if(var_a3cc5416 <= 0 && csceneobject::function_a808aac7())
							{
								var_f2b99dab = 1;
							}
							else
							{
								if(animhasnotetrack(var_efc540b6, "interactive_shot_marker"))
								{
									a_n_times = getnotetracktimes(var_efc540b6, "interactive_shot_marker");
									foreach(n_time in a_n_times)
									{
										if(n_time > var_f667af2f)
										{
											var_b97b91e4 = n_time;
											break;
										}
									}
								}
								if(isdefined(var_b97b91e4))
								{
									while(var_f667af2f <= var_b97b91e4)
									{
										foreach(o_obj in _o_scene._a_objects)
										{
											thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0, var_f667af2f);
										}
										waitframe(1);
										var_a3cc5416 = var_a3cc5416 + (n_update_time * var_ea474464);
										var_f667af2f = var_a3cc5416;
									}
									var_b97b91e4 = undefined;
								}
								else
								{
									foreach(o_obj in _o_scene._a_objects)
									{
										thread [[ o_obj ]]->_play_anim(o_obj.var_efc540b6, 1, 0, var_f667af2f);
									}
								}
							}
						}
					}
				}
			}
			if(var_a3cc5416 >= 1 || (var_a3cc5416 <= 0 && csceneobject::function_a808aac7()))
			{
				if(csceneobject::function_a808aac7())
				{
					var_778409ab = csceneobject::get_shot(_str_shot);
					if(var_778409ab > 0 && isdefined(_s.shots[var_778409ab - 1]) && csceneobject::function_e91c94b9(var_778409ab - 1) && (!(isdefined(_s.shots[var_778409ab - 1].var_751fe16b) && _s.shots[var_778409ab - 1].var_751fe16b)))
					{
						self.var_a3cc5416 = 1;
						_o_scene.var_2e9fdf35 = _s.shots[var_778409ab - 1].name;
						waitframe(1);
					}
					else
					{
						var_a3cc5416 = math::clamp(var_a3cc5416, 0, 1);
						waitframe(1);
						continue;
					}
				}
				foreach(o_obj in _o_scene._a_objects)
				{
					o_obj._b_active_anim = 0;
					o_obj flagsys::clear(#"scene_interactive_shot_active");
				}
				return;
			}
			var_a3cc5416 = math::clamp(var_a3cc5416, 0, 1);
			waitframe(1);
		}
	}

	/*
		Name: function_dd8a2de2
		Namespace: csceneplayer
		Checksum: 0x300DAD8A
		Offset: 0x2130
		Size: 0x13A
		Parameters: 1
		Flags: Linked
	*/
	function function_dd8a2de2(player)
	{
		if(isbot(player))
		{
			return;
		}
		if(isdefined(var_55b4f21e.var_143deeac))
		{
			switch(var_55b4f21e.var_143deeac)
			{
				case "bank1":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 0);
					break;
				}
				case "bank2":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 1);
					break;
				}
				case "bank3":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 2);
					break;
				}
				case "bank4":
				{
					player clientfield::set_to_player("player_pbg_bank_scene_system", 3);
					break;
				}
			}
		}
	}

	/*
		Name: function_7efadfe8
		Namespace: csceneplayer
		Checksum: 0xDAF012D4
		Offset: 0x1ED8
		Size: 0x24E
		Parameters: 1
		Flags: Linked
	*/
	function function_7efadfe8(player)
	{
		player.player_anim_look_enabled = !(isdefined(_s.lockview) && _s.lockview);
		player.player_anim_clamp_right = (isdefined((isdefined(var_55b4f21e.viewclampright) ? var_55b4f21e.viewclampright : _s.viewclampright)) ? (isdefined(var_55b4f21e.viewclampright) ? var_55b4f21e.viewclampright : _s.viewclampright) : 0);
		player.player_anim_clamp_left = (isdefined((isdefined(var_55b4f21e.viewclampleft) ? var_55b4f21e.viewclampleft : _s.viewclampleft)) ? (isdefined(var_55b4f21e.viewclampleft) ? var_55b4f21e.viewclampleft : _s.viewclampleft) : 0);
		player.player_anim_clamp_top = (isdefined((isdefined(var_55b4f21e.viewclamptop) ? var_55b4f21e.viewclamptop : _s.viewclamptop)) ? (isdefined(var_55b4f21e.viewclamptop) ? var_55b4f21e.viewclamptop : _s.viewclamptop) : 0);
		player.player_anim_clamp_bottom = (isdefined((isdefined(var_55b4f21e.viewclampbottom) ? var_55b4f21e.viewclampbottom : _s.viewclampbottom)) ? (isdefined(var_55b4f21e.viewclampbottom) ? var_55b4f21e.viewclampbottom : _s.viewclampbottom) : 0);
	}

	/*
		Name: function_c26a4e8b
		Namespace: csceneplayer
		Checksum: 0xFAF0BC42
		Offset: 0x1E48
		Size: 0x84
		Parameters: 2
		Flags: Linked
	*/
	function function_c26a4e8b(player, b_enable)
	{
		if(b_enable)
		{
			if(isdefined(player.var_313437ff) && player.var_313437ff)
			{
				player.var_313437ff = undefined;
				player weapons::force_stowed_weapon_update();
			}
		}
		else
		{
			player.var_313437ff = 1;
			player clearstowedweapon();
		}
	}

	/*
		Name: function_d3541c6f
		Namespace: csceneplayer
		Checksum: 0xFE4B821B
		Offset: 0x1D30
		Size: 0x10C
		Parameters: 1
		Flags: Linked
	*/
	function function_d3541c6f(player)
	{
		if(isdefined(player.var_777951c))
		{
			player takeweapon(player.var_777951c);
			player val::reset(#"hash_42d78b644f22da0b", "take_weapons");
			player player::switch_to_primary_weapon(1);
			player.var_777951c = undefined;
		}
		if(isdefined(var_55b4f21e.hidestowedweapon) && var_55b4f21e.hidestowedweapon)
		{
			function_c26a4e8b(player, 1);
		}
		if(!(isdefined(_s.dontreloadammo) && _s.dontreloadammo))
		{
			player player::fill_current_clip();
		}
	}

	/*
		Name: function_c7246a4a
		Namespace: csceneplayer
		Checksum: 0x213A5F25
		Offset: 0x1C50
		Size: 0xD2
		Parameters: 2
		Flags: Linked
	*/
	function function_c7246a4a(player, var_d4c489c0)
	{
		var_29f79831 = player loadout::function_18a77b37(var_d4c489c0);
		var_e4b15461 = player getcurrentweapon();
		if(var_29f79831 != var_e4b15461)
		{
			player val::set(#"hash_42d78b644f22da0b", "take_weapons", 1);
			player giveweapon(var_29f79831);
			player switchtoweaponimmediate(var_29f79831);
			player.var_777951c = var_29f79831;
		}
	}

	/*
		Name: function_d46ffe56
		Namespace: csceneplayer
		Checksum: 0xA7D9E7B0
		Offset: 0x1760
		Size: 0x4E4
		Parameters: 1
		Flags: Linked
	*/
	function function_d46ffe56(player)
	{
		if(!(isdefined(_s.removeweapon) && _s.removeweapon) || (isdefined(_s.showweaponinfirstperson) && _s.showweaponinfirstperson) && (!(isdefined(_s.disableprimaryweaponswitch) && _s.disableprimaryweaponswitch)))
		{
			player player::switch_to_primary_weapon(1);
		}
		if(isdefined(var_55b4f21e.var_1a95895f) && var_55b4f21e.var_1a95895f)
		{
			w_primary = player loadout::function_18a77b37("primary");
			var_59cf3a45 = w_primary.rootweapon;
			w_secondary = player loadout::function_18a77b37("secondary");
			var_cae8b14d = w_secondary.rootweapon;
			var_a9fd0a0a = array(getweapon(#"ar_accurate_t8"), getweapon(#"ar_fastfire_t8"), getweapon(#"ar_stealth_t8"), getweapon(#"ar_damage_t8"), getweapon(#"ar_modular_t8"), getweapon(#"smg_handling_t8"), getweapon(#"smg_standard_t8"), getweapon(#"smg_accurate_t8"), getweapon(#"smg_fastfire_t8"), getweapon(#"smg_capacity_t8"), getweapon(#"lmg_heavy_t8"), getweapon(#"lmg_standard_t8"), getweapon(#"lmg_spray_t8"));
			arrayremovevalue(var_a9fd0a0a, level.weaponnone);
			if(isinarray(var_a9fd0a0a, var_59cf3a45))
			{
				function_c7246a4a(player, "primary");
			}
			else
			{
				if(isinarray(var_a9fd0a0a, var_cae8b14d))
				{
					function_c7246a4a(player, "secondary");
				}
				else
				{
					var_4e2bf3dc = player getweaponoptions(w_primary);
					player val::set(#"hash_42d78b644f22da0b", "take_weapons", 1);
					player giveweapon(getweapon(#"ar_accurate_t8"), var_4e2bf3dc);
					player switchtoweaponimmediate(getweapon(#"ar_accurate_t8"), 1);
					player.var_777951c = getweapon(#"ar_accurate_t8");
				}
			}
		}
		if(isdefined(var_55b4f21e.hidestowedweapon) && var_55b4f21e.hidestowedweapon)
		{
			function_c26a4e8b(player, 0);
		}
	}

	/*
		Name: _prepare_player
		Namespace: csceneplayer
		Checksum: 0xE59914B
		Offset: 0xA88
		Size: 0xCD0
		Parameters: 1
		Flags: Linked
	*/
	function _prepare_player(player)
	{
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				printtoprightln("");
			}
		#/
		player endon(#"death");
		player notify(#"new_shot");
		var_2bb59a6a = csceneobject::function_24f8cfb5(_str_shot) || (isdefined(_o_scene.b_play_from_time) && _o_scene.b_play_from_time);
		function_dd8a2de2(player);
		if(player.current_scene === _o_scene._str_name)
		{
			return false;
		}
		/#
			if(player === level.host && scene::check_team(player.team, _str_team))
			{
				display_dev_info();
			}
		#/
		if(!(isdefined(_s.showhud) && _s.showhud) && (!(isdefined(_s.allowdeath) && _s.allowdeath)))
		{
			player scene::set_igc_active(1, _o_scene._str_name);
		}
		[[ self ]]->_set_values(player);
		player sethighdetail(1);
		str_streamer_hint = _o_scene._a_streamer_hint[player.team];
		if(isdefined(str_streamer_hint))
		{
			if(!isdefined(player.var_231881b1))
			{
				player.var_231881b1 = [];
			}
			if(!isdefined(player.var_16672042))
			{
				player.var_16672042 = [];
			}
			if(isdefined(player.var_16672042[_o_scene._str_name]) && player.var_16672042[_o_scene._str_name] != -1)
			{
				self._n_streamer_req = player.var_16672042[_o_scene._str_name];
			}
			else if(_n_streamer_req == -1)
			{
				self._n_streamer_req = player playerstreamerrequest("set", str_streamer_hint);
				player.var_231881b1[_o_scene._str_name] = str_streamer_hint;
				player.var_16672042[_o_scene._str_name] = _n_streamer_req;
			}
			if(var_2bb59a6a && _n_streamer_req != -1)
			{
				if(!(isdefined(level.scene_streamer_ignore[_o_scene._s.name]) && level.scene_streamer_ignore[_o_scene._s.name]))
				{
					if(!(isdefined(_o_scene._s.ignorestreamer) && _o_scene._s.ignorestreamer) && (!(isdefined(_o_scene._b_testing) && _o_scene._b_testing)) && !scene::function_46546b5c(_o_scene._s.name))
					{
						self endon(#"new_shot");
						level util::streamer_wait(undefined, 0, getdvarint(#"hash_47b7504d8ac8d477", 30), player.team, _o_scene._str_name);
					}
				}
			}
		}
		if(player flagsys::get(#"mobile_armory_in_use"))
		{
			player flagsys::set(#"cancel_mobile_armory");
			player closemenu("mobile_armory_loadout");
			params = {#intpayload:0, #response:"cancel", #menu:"mobile_armory_loadout"};
			player notify(#"menuresponse", params);
			player callback::callback(#"menu_response", params);
		}
		if(player flagsys::get(#"mobile_armory_begin_use"))
		{
			player val::reset(#"mobile_armory_use", "disable_weapons");
			player flagsys::clear(#"mobile_armory_begin_use");
		}
		if(getdvarint(#"scene_hide_player", 0))
		{
			player val::set(#"scene", "hide");
		}
		player._scene_object = self;
		player.current_scene = _o_scene._str_name;
		player.var_e3d6d713 = player.current_scene;
		player.anim_debug_name = _s.name;
		/#
			if(csceneobject::function_209522a0())
			{
				if(isdefined(_s.model))
				{
					var_be7bc546 = currentsessionmode();
					var_123ebd30 = getallcharacterbodies(var_be7bc546);
					var_ca47355c = 0;
					foreach(var_2074c3ff in var_123ebd30)
					{
						var_b744a7ed = function_d299ef16(var_2074c3ff, var_be7bc546);
						for(var_6e0e2531 = 0; var_6e0e2531 < var_b744a7ed; var_6e0e2531++)
						{
							var_322595c6 = function_d7c3cf6c(var_2074c3ff, var_6e0e2531, var_be7bc546);
							if(var_322595c6.namehash === _s.model)
							{
								player setcharacterbodytype(var_2074c3ff);
								player setcharacteroutfit(var_6e0e2531);
								if(isdefined(_s.var_a5617859) && isarray(var_322595c6.presets))
								{
									var_a919ac81 = strtok(_s.var_a5617859, "");
									foreach(var_a343b02b, var_47fc7c6f in var_322595c6.presets)
									{
										if(!(isdefined(var_47fc7c6f.isvalid) && var_47fc7c6f.isvalid))
										{
											continue;
										}
										if(isdefined(var_a919ac81[1]) && int(var_a919ac81[1]) === var_a343b02b)
										{
											player function_fbc5a093(var_a343b02b);
											break;
										}
									}
								}
								var_ca47355c = 1;
								break;
							}
						}
						if(var_ca47355c)
						{
							break;
						}
					}
				}
			}
		#/
		if([[ _o_scene ]]->is_scene_shared() && (var_2bb59a6a || scene::function_46546b5c(_o_scene._str_name)) && !csceneobject::is_skipping_scene())
		{
			player thread scene::function_a4ad0308(_o_scene);
			if(var_2bb59a6a && getdvarint(#"hash_44f3b54c25dfae3b", 0))
			{
				player clientfield::set_to_player("postfx_cateye", 1);
			}
		}
		revive_player(player);
		player thread util::function_419f0c21();
		if(isdefined(player.hijacked_vehicle_entity))
		{
			player.hijacked_vehicle_entity delete();
		}
		else if(isalive(player) && (!(isdefined(_s.var_5829ce6b) && _s.var_5829ce6b)) && player isinvehicle())
		{
			vh_occupied = player getvehicleoccupied();
			n_seat = vh_occupied getoccupantseat(player);
			vh_occupied usevehicle(player, n_seat);
		}
		if(_o_scene._s scene::is_igc())
		{
			player thread scene::scene_disable_player_stuff(_o_scene._s, _s);
			player util::function_7f49ffb7(6);
		}
		function_7efadfe8(player);
		function_d46ffe56(player);
		set_player_stance(player);
		player flagsys::set(#"scene");
		waitframe(0);
		if(isdefined(var_55b4f21e.interactiveshot) && var_55b4f21e.interactiveshot)
		{
			thread function_7d761e79(player);
		}
		player notify(#"scene_ready");
	}

	/*
		Name: _prepare
		Namespace: csceneplayer
		Checksum: 0x66C25A53
		Offset: 0xA60
		Size: 0x1C
		Parameters: 0
		Flags: Linked
	*/
	function _prepare()
	{
		_prepare_player(_e);
	}

	/*
		Name: _reset_values
		Namespace: csceneplayer
		Checksum: 0x80E2F808
		Offset: 0x938
		Size: 0x11C
		Parameters: 1
		Flags: Linked
	*/
	function _reset_values(ent = _e)
	{
		csceneobject::reset_ent_val("takedamage", ent);
		csceneobject::reset_ent_val("ignoreme", ent);
		csceneobject::reset_ent_val("allowdeath", ent);
		csceneobject::reset_ent_val("take_weapons", ent);
		if(isbot(ent) && (csceneobject::function_b260bdcc(_str_shot) || _o_scene._str_mode === "single" || (isdefined(_o_scene.scene_stopping) && _o_scene.scene_stopping)))
		{
			ent botreleasemanualcontrol();
		}
	}

	/*
		Name: _set_values
		Namespace: csceneplayer
		Checksum: 0xDE0C182F
		Offset: 0x788
		Size: 0x1A4
		Parameters: 1
		Flags: Linked
	*/
	function _set_values(ent = _e)
	{
		if(!(isdefined(_s.takedamage) && _s.takedamage))
		{
			ent setnormalhealth(1);
		}
		if(isdefined(ent.takedamage) && ent.takedamage && !ent getinvulnerability())
		{
			csceneobject::set_ent_val("takedamage", isdefined(_s.takedamage) && _s.takedamage, ent);
		}
		csceneobject::set_ent_val("ignoreme", !(isdefined(_s.takedamage) && _s.takedamage), ent);
		csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
		csceneobject::set_ent_val("take_weapons", isdefined(_s.removeweapon) && _s.removeweapon, ent);
	}

	/*
		Name: function_d09b043
		Namespace: csceneplayer
		Checksum: 0x29FDCE9
		Offset: 0x660
		Size: 0x11C
		Parameters: 0
		Flags: Linked
	*/
	function function_d09b043()
	{
		if(isdefined(var_55b4f21e.interactiveshot) && var_55b4f21e.interactiveshot)
		{
			return;
		}
		self notify(#"hash_30095f69ee804b7e");
		self endon(#"hash_30095f69ee804b7e");
		_o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
		var_be17187b = undefined;
		var_be17187b = _e waittill(#"death");
		self.var_1f97724a = 1;
		_e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
		csceneobject::function_1e19d813();
	}

	/*
		Name: _spawn
		Namespace: csceneplayer
		Checksum: 0xE4C79758
		Offset: 0x518
		Size: 0x140
		Parameters: 0
		Flags: Linked
	*/
	function _spawn()
	{
		/#
			if(isdefined(_o_scene._b_testing) && _o_scene._b_testing && csceneobject::is_player())
			{
				p_host = util::gethostplayer();
				if(!csceneobject::in_this_scene(p_host))
				{
					self._e = p_host;
					return;
				}
			}
		#/
		csceneobject::restore_saved_ent();
		if(!isdefined(_e))
		{
			foreach(ent in [[_func_get]](_str_team))
			{
				if(!csceneobject::in_this_scene(ent))
				{
					self._e = ent;
					return;
				}
			}
		}
	}

	/*
		Name: _stop
		Namespace: csceneplayer
		Checksum: 0x586F4CDC
		Offset: 0x3F0
		Size: 0x11C
		Parameters: 2
		Flags: Linked
	*/
	function _stop(b_dont_clear_anim, b_finished)
	{
		if(isalive(_e))
		{
			_e notify(#"scene_stop");
			stop_camera(_e);
			_e flagsys::clear(#"hash_7cddd51e45d3ff3e");
			if(!(isdefined(_s.diewhenfinished) && _s.diewhenfinished) || !b_finished)
			{
				_e animation::stop(0.2);
			}
			_e thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
		}
	}

	/*
		Name: first_init
		Namespace: csceneplayer
		Checksum: 0xB5404E50
		Offset: 0x380
		Size: 0x62
		Parameters: 2
		Flags: Linked
	*/
	function first_init(s_objdef, o_scene)
	{
		if(isdefined(o_scene._str_team))
		{
			s_objdef.team = o_scene._str_team;
		}
		s_objdef.nospawn = 1;
		return csceneobject::first_init(s_objdef, o_scene);
	}

}

class cscenesharedplayer : csceneobject, csceneplayer
{
	var _str_team;
	var _func_get;
	var _o_scene;
	var _s;
	var player_animation;
	var player_animation_notify;
	var _e;
	var player_start_time;
	var player_time_frac;
	var player_animation_length;
	var current_playing_anim;
	var player_rate;
	var player_tag;
	var player_align;
	var m_align;
	var m_tag;
	var _func_get_active;
	var _str_current_anim;
	var _str_shot;

	/*
		Name: constructor
		Namespace: cscenesharedplayer
		Checksum: 0xA5ABB8DF
		Offset: 0x9250
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenesharedplayer
		Checksum: 0xC9FA5D63
		Offset: 0x9270
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: _cleanup
		Namespace: cscenesharedplayer
		Checksum: 0x13F26B9A
		Offset: 0x91C0
		Size: 0x88
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
		foreach(player in [[_func_get]](_str_team))
		{
			csceneplayer::_cleanup_player(player);
		}
	}

	/*
		Name: _stop
		Namespace: cscenesharedplayer
		Checksum: 0xEF268755
		Offset: 0x90C8
		Size: 0xF0
		Parameters: 2
		Flags: Linked
	*/
	function _stop(b_dont_clear_anim, b_finished)
	{
		foreach(player in [[_func_get]](_str_team))
		{
			csceneplayer::stop_camera(player);
			player animation::stop();
			player thread scene::scene_enable_player_stuff(_o_scene._s, _s, _o_scene._e_root);
		}
	}

	/*
		Name: _set_visibility
		Namespace: cscenesharedplayer
		Checksum: 0xA9F706E7
		Offset: 0x8FF0
		Size: 0xD0
		Parameters: 0
		Flags: Linked
	*/
	function _set_visibility()
	{
		a_players = [[_func_get]](_str_team);
		foreach(player in a_players)
		{
			player show();
			if(!player flagsys::get(#"hash_7cddd51e45d3ff3e"))
			{
				player setinvisibletoall();
			}
		}
	}

	/*
		Name: _play_shared_player_anim_for_player
		Namespace: cscenesharedplayer
		Checksum: 0xB01A2891
		Offset: 0x88C0
		Size: 0x724
		Parameters: 1
		Flags: Linked
	*/
	function _play_shared_player_anim_for_player(player)
	{
		player endon(#"death");
		if(!scene::check_team(player.team, _str_team))
		{
			return;
		}
		str_animation = player_animation;
		str_animation = [[ self ]]->animation_lookup(str_animation, player);
		csceneplayer::on_play_anim(player);
		/#
		#/
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				printtoprightln("" + player_animation);
			}
		#/
		player flagsys::set(#"shared_igc");
		if(player flagsys::get(player_animation_notify))
		{
			player flagsys::set(player_animation_notify + "_skip_init_clear");
		}
		player flagsys::set(player_animation_notify);
		if(isdefined(player getlinkedent()))
		{
			player unlink();
		}
		if(!(isdefined(_s.disabletransitionin) && _s.disabletransitionin))
		{
			if(player != _e || getdvarint(#"scr_player1_postfx", 0))
			{
				if(!isdefined(player.screen_fade_menus))
				{
					if(!(isdefined(level.chyron_text_active) && level.chyron_text_active))
					{
						if(!(isdefined(player.var_8a1a4ba) && player.var_8a1a4ba))
						{
							player.play_scene_transition_effect = 1;
						}
					}
				}
			}
		}
		csceneplayer::_prepare_player(player);
		n_time_passed = (float(gettime() - player_start_time)) / 1000;
		n_start_time = player_time_frac * player_animation_length;
		n_time_left = (player_animation_length - n_time_passed) - n_start_time;
		n_time_frac = 1 - (n_time_left / player_animation_length);
		if(isdefined(_e) && player != _e)
		{
			player dontinterpolate();
			player setorigin(_e.origin);
			if(!isbot(player))
			{
				player setplayerangles(_e getplayerangles());
			}
		}
		n_lerp = csceneobject::get_lerp_time();
		if(!csceneplayer::function_6c1c67c1())
		{
			csceneplayer::stop_camera(player);
			n_camera_tween = csceneobject::get_camera_tween();
			if(n_camera_tween > 0)
			{
				player startcameratween(n_camera_tween);
			}
		}
		if(n_time_frac < 1)
		{
			/#
				if(getdvarint(#"scene_hide_player", 0) > 0)
				{
					player val::set(#"scene", "");
				}
				if(getdvarint(#"debug_scene", 0) > 0)
				{
					printtoprightln((("" + _s.name) + "") + player_animation);
				}
			#/
			player_num = player getentitynumber();
			if(!isdefined(current_playing_anim))
			{
				self.current_playing_anim[player_num] = [];
			}
			self.current_playing_anim[player_num] = str_animation;
			if(csceneobject::is_skipping_scene())
			{
				thread csceneobject::skip_scene(1);
			}
			if(csceneobject::function_5c2a9efa())
			{
				player val::set(#"scene_player", "freezecontrols", 1);
				csceneobject::function_5c082667();
				player val::reset(#"scene_player", "freezecontrols");
			}
			else
			{
				player animation::play(str_animation, player_align, player_tag, player_rate, 0, 0, n_lerp, n_time_frac, _s.showweaponinfirstperson);
			}
			if(!player flagsys::get(player_animation_notify + "_skip_init_clear"))
			{
				player flagsys::clear(player_animation_notify);
			}
			else
			{
				player flagsys::clear(player_animation_notify + "_skip_init_clear");
			}
			if(!player isplayinganimscripted())
			{
				self.current_playing_anim[player_num] = undefined;
			}
			/#
				if(getdvarint(#"debug_scene", 0) > 0)
				{
					printtoprightln((("" + _s.name) + "") + player_animation);
				}
			#/
		}
	}

	/*
		Name: _play_anim
		Namespace: cscenesharedplayer
		Checksum: 0xDB665F21
		Offset: 0x84D8
		Size: 0x3E0
		Parameters: 4
		Flags: Linked
	*/
	function _play_anim(animation, n_rate, n_blend, n_time)
	{
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				printtoprightln("" + animation);
			}
		#/
		self._str_current_anim = animation;
		self.player_animation = animation;
		self.player_animation_notify = animation + "_notify";
		self.player_animation_length = getanimlength(animation);
		self.player_align = m_align;
		self.player_tag = m_tag;
		self.player_rate = n_rate;
		self.player_time_frac = n_time;
		self.player_start_time = gettime();
		a_players = [[_func_get]](_str_team);
		/#
			if(isdefined(_e) && !isinarray(a_players, _e))
			{
				arrayinsert(a_players, _e, 0);
			}
		#/
		foreach(player in a_players)
		{
			if(player flagsys::get(#"loadout_given") && player.sessionstate !== "spectator")
			{
				self thread _play_shared_player_anim_for_player(player);
				continue;
			}
			if(isdefined(player.initialloadoutgiven) && player.initialloadoutgiven)
			{
				csceneplayer::revive_player(player);
			}
		}
		[[ self ]]->_set_visibility();
		waittillframeend();
		do
		{
			b_playing = 0;
			foreach(player in [[_func_get_active]](_str_team))
			{
				if(isdefined(player) && player flagsys::get(player_animation_notify))
				{
					b_playing = 1;
					player flagsys::wait_till_clear(player_animation_notify);
					break;
				}
			}
		}
		while(b_playing);
		/#
			if(getdvarint(#"debug_scene", 0) > 0)
			{
				csceneobject::log(((toupper(_s.type) + "") + _str_current_anim) + "");
			}
		#/
		thread [[ _o_scene ]]->_call_shot_funcs("players_done");
	}

	/*
		Name: _prepare
		Namespace: cscenesharedplayer
		Checksum: 0xF97D91CF
		Offset: 0x83F0
		Size: 0xDC
		Parameters: 0
		Flags: Linked
	*/
	function _prepare()
	{
		if(!csceneobject::function_e0df299e(_str_shot))
		{
			return;
		}
		a_players = [[_func_get]](_str_team);
		foreach(ent in a_players)
		{
			thread [[ self ]]->_prepare_player(ent);
		}
		[[ self ]]->_set_visibility();
		array::wait_till(a_players, "scene_ready");
	}

}

class cscenefakeplayer : csceneobject
{

	/*
		Name: constructor
		Namespace: cscenefakeplayer
		Checksum: 0xCF30AE0C
		Offset: 0xB000
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenefakeplayer
		Checksum: 0x5FDA0571
		Offset: 0xB020
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

}

class class_6572d7cd : csceneobject, csceneplayer
{

	/*
		Name: constructor
		Namespace: namespace_6572d7cd
		Checksum: 0x749432B5
		Offset: 0xC450
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: namespace_6572d7cd
		Checksum: 0xDCABCE1D
		Offset: 0xC470
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

}

