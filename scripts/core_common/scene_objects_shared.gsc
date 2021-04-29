// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3b7405881c081f6;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\scene_actor_shared.gsc;
#using scripts\core_common\scene_model_shared.gsc;
#using scripts\core_common\scene_player_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\scene_vehicle_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\teleport_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace scene;

/*
	Name: prepare_player_model_anim
	Namespace: scene
	Checksum: 0x625D3F1
	Offset: 0x7B8
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function prepare_player_model_anim(ent)
{
	if(!ent.animtree === "all_player")
	{
		ent useanimtree("all_player");
		ent.animtree = "all_player";
	}
}

/*
	Name: prepare_generic_model_anim
	Namespace: scene
	Checksum: 0x907FDFDA
	Offset: 0x818
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function prepare_generic_model_anim(ent)
{
	if(!ent.animtree === "generic")
	{
		ent useanimtree("generic");
		ent.animtree = "generic";
	}
}

#namespace csceneobject;

/*
	Name: __constructor
	Namespace: csceneobject
	Checksum: 0x7FDFF29E
	Offset: 0x878
	Size: 0x26
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self._b_first_frame = 0;
	self._b_active_anim = 0;
	self._n_blend = 0;
}

/*
	Name: __destructor
	Namespace: csceneobject
	Checksum: 0x35082C65
	Offset: 0x8A8
	Size: 0x24
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
	/#
		log("");
	#/
}

/*
	Name: set_ent_val
	Namespace: csceneobject
	Checksum: 0x630975EC
	Offset: 0x8D8
	Size: 0x74
	Parameters: 3
	Flags: Linked
*/
function set_ent_val(str_key, value, ent = self._e)
{
	if(isdefined(ent))
	{
		ent val::set(self._o_scene._str_name + ":" + self._str_shot, str_key, value);
	}
}

/*
	Name: reset_ent_val
	Namespace: csceneobject
	Checksum: 0x6669143E
	Offset: 0x958
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function reset_ent_val(str_key, ent = self._e)
{
	if(isdefined(ent))
	{
		ent val::reset(self._o_scene._str_name + ":" + self._str_shot, str_key);
	}
}

/*
	Name: _set_values
	Namespace: csceneobject
	Checksum: 0x9D5E039E
	Offset: 0x9D0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function _set_values(ent = self._e)
{
	set_ent_val("takedamage", isdefined(self._s.takedamage) && self._s.takedamage, ent);
	set_ent_val("allowdeath", isdefined(self._s.allowdeath) && self._s.allowdeath, ent);
}

/*
	Name: _reset_values
	Namespace: csceneobject
	Checksum: 0x65E0D411
	Offset: 0xA78
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function _reset_values(ent = self._e)
{
	reset_ent_val("takedamage", ent);
	reset_ent_val("ignoreme", ent);
	reset_ent_val("allowdeath", ent);
	reset_ent_val("take_weapons", ent);
}

/*
	Name: first_init
	Namespace: csceneobject
	Checksum: 0x5CF5835F
	Offset: 0xB08
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function first_init(s_objdef, o_scene)
{
	self._s = s_objdef;
	self._o_scene = o_scene;
	_assign_unique_name();
	if(isdefined(self._s.team))
	{
		self._str_team = util::get_team_mapping(self._s.team);
	}
	return self;
}

/*
	Name: spawn
	Namespace: csceneobject
	Checksum: 0x28F6730E
	Offset: 0xB98
	Size: 0x234
	Parameters: 0
	Flags: Linked
*/
function spawn()
{
	self endon(#"new_shot");
	b_skip = !function_e0df299e(self._str_shot) && self._o_scene._str_mode !== "init" && !issubstr(self._o_scene._str_mode, "single") && self._str_shot !== "init" && !is_player() && !function_48382a1c();
	b_skip = b_skip || function_3919a776();
	b_skip = b_skip || (isdefined(self.var_1f97724a) && self.var_1f97724a);
	if(!b_skip)
	{
		[[ self ]]->_spawn();
		error(!(isdefined(self._s.nospawn) && self._s.nospawn) && (!isdefined(self._e) || isspawner(self._e)), "Object failed to spawn or doesn't exist.");
		[[ self._o_scene ]]->assign_ent(self, self._e);
		if(isdefined(self._e))
		{
			prepare();
		}
		else if(isdefined(self._s.nospawn) && self._s.nospawn)
		{
			flagsys::set(self._str_shot + "stopped");
		}
	}
	else
	{
		cleanup();
	}
}

/*
	Name: _spawn
	Namespace: csceneobject
	Checksum: 0x678635A2
	Offset: 0xDD8
	Size: 0x1AA
	Parameters: 0
	Flags: Linked
*/
function _spawn()
{
	restore_saved_ent();
	if(!isdefined(self._e))
	{
		if(isdefined(self._s.name))
		{
			self._e = scene::get_existing_ent(self._s.name, undefined, undefined, self._o_scene._str_name);
		}
	}
	if(isdefined(self._e))
	{
		if(isdefined(self._e.isdying) && self._e.isdying)
		{
			self._e delete();
		}
	}
	if(!isdefined(self._e) && (!(isdefined(self._s.nospawn) && self._s.nospawn) || (isdefined(self._o_scene._b_testing) && self._o_scene._b_testing)) || isspawner(self._e))
	{
		spawn_ent();
		if(isdefined(self._e))
		{
			self._e dontinterpolate();
			self._e.scene_spawned = self._o_scene._s.name;
		}
	}
}

/*
	Name: prepare
	Namespace: csceneobject
	Checksum: 0x96A9D433
	Offset: 0xF90
	Size: 0x770
	Parameters: 0
	Flags: Linked
*/
function prepare()
{
	self._e endon(#"death");
	if(isdefined(self._e._scene_object) && self._e._scene_object != self)
	{
		[[ self._e._scene_object ]]->cleanup();
	}
	if(!is_alive())
	{
		return;
	}
	self._n_ent_num = self._e getentitynumber();
	if(self._e.health < 1)
	{
		self._e.health = 1;
	}
	/#
		log(self._str_shot);
	#/
	self._e._scene_object = self;
	self.var_55b4f21e = function_730a4c60(self._str_shot);
	if(isdefined(self._s.dynamicpaths) && self._s.dynamicpaths && self._str_shot != "init")
	{
		self._e.scene_orig_origin = self._e.origin;
		self._e connectpaths();
	}
	if(!isai(self._e) && !isplayer(self._e))
	{
		if(!is_player())
		{
			if(isdefined(self.var_55b4f21e))
			{
				self.var_55b4f21e.devstate = undefined;
			}
			if(is_player_model())
			{
				scene::prepare_player_model_anim(self._e);
			}
			else
			{
				scene::prepare_generic_model_anim(self._e);
			}
		}
	}
	if(!is_player())
	{
		[[ self ]]->_set_values();
		self._e.anim_debug_name = self._s.name;
		self._e.current_scene = self._o_scene._str_name;
		self._e flagsys::set(#"scene");
	}
	if(self._e.classname == "script_model")
	{
		if(isdefined(self._o_scene._e_root.modelscale))
		{
			self._e setscale(self._o_scene._e_root.modelscale);
		}
	}
	if(isdefined(self._s.takedamage) && self._s.takedamage)
	{
		foreach(s_shot in self._s.shots)
		{
			if(function_f12c5e67(s_shot) && !function_b52254e6())
			{
				self.var_2a306f8a = 1;
				self._e.var_2a306f8a = 1;
				thread function_14f96d6b();
				break;
			}
		}
	}
	if(self._o_scene._s scene::is_igc() || [[ self._o_scene ]]->has_player())
	{
		if(!isplayer(self._e))
		{
			self._e sethighdetail(1);
		}
	}
	[[ self ]]->_prepare();
	if(isdefined(self._s.allowdeath) && self._s.allowdeath)
	{
		thread [[ self ]]->function_d09b043();
	}
	if(function_5c2a9efa())
	{
		s_start_spot = function_3e22944e();
		if(isplayer(self._e))
		{
			self._e setorigin(s_start_spot.origin);
			self._e setplayerangles(s_start_spot.angles);
		}
		else if(isactor(self._e))
		{
			self._e forceteleport(s_start_spot.origin, s_start_spot.angles);
		}
		else
		{
			self._e.origin = s_start_spot.origin;
			self._e.angles = s_start_spot.angles;
		}
	}
	function_4b3d4226();
	scene_reach();
	if(isdefined(self.var_55b4f21e.var_67f013e3) && self.var_55b4f21e.var_67f013e3)
	{
		self._e flagsys::set(#"hash_2f30b24ec0e23830");
	}
	if(isdefined(self.var_55b4f21e.var_1f99c1f2))
	{
		if(self.var_55b4f21e.var_1f99c1f2 == "friendly")
		{
			self._e flagsys::set(#"hash_e2ce599b208682a");
		}
		else if(self.var_55b4f21e.var_1f99c1f2 == "enemy")
		{
			self._e flagsys::set(#"hash_f21f320f68c0457");
		}
	}
	flagsys::set(self._str_shot + "ready");
	flagsys::clear(self._str_shot + "finished");
	return 1;
}

/*
	Name: function_4b3d4226
	Namespace: csceneobject
	Checksum: 0x613A85DE
	Offset: 0x1708
	Size: 0x3B4
	Parameters: 0
	Flags: Linked
*/
function function_4b3d4226()
{
	if(!isdefined(self.var_55b4f21e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_3cd248f5))
	{
		a_ents = getentarray(self.var_55b4f21e.var_3cd248f5, "targetname", 1);
		array::thread_all(a_ents, &val::set, #"hash_231dddc2afe6275f", "hide", 1);
	}
	else if(isdefined(self.var_55b4f21e.var_b94164e))
	{
		a_ents = getentarray(self.var_55b4f21e.var_b94164e, "targetname", 1);
		array::thread_all(a_ents, &val::reset, #"hash_231dddc2afe6275f", "hide");
	}
	if(!isdefined(self._e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_a4b8685d) && self.var_55b4f21e.var_a4b8685d && !isplayer(self._e))
	{
		self._e notify(#"hash_770bf84f62435a17");
		self._e scene::synced_delete(self._o_scene._str_name);
		return;
	}
	if(isdefined(self.var_55b4f21e.var_7e4647c3) && self.var_55b4f21e.var_7e4647c3 && self._str_shot != "init")
	{
		self._e.scene_orig_origin = self._e.origin;
		self._e connectpaths();
	}
	else if(isdefined(self.var_55b4f21e.var_6d2f3193) && self.var_55b4f21e.var_6d2f3193)
	{
		self._e disconnectpaths(2, 1);
	}
	if(isdefined(self.var_55b4f21e.var_562f4281) && self.var_55b4f21e.var_562f4281)
	{
		self._e notify(#"hash_2d5f4b208c6322bc");
		self._e val::set(#"scene", "hide", 2);
	}
	else if(isdefined(self.var_55b4f21e.var_4f4c4730) && self.var_55b4f21e.var_4f4c4730 || (isdefined(self._o_scene._b_testing) && self._o_scene._b_testing && self._o_scene._str_mode === "single"))
	{
		self._e notify(#"hash_4ab65f6d84f4135");
		self._e val::reset(#"scene", "hide");
	}
}

/*
	Name: _prepare
	Namespace: csceneobject
	Checksum: 0xBCE5F40E
	Offset: 0x1AC8
	Size: 0x1B4
	Parameters: 0
	Flags: Linked
*/
function _prepare()
{
	if(issentient(self._e))
	{
		if(isdefined(self._s.overrideaicharacter) && self._s.overrideaicharacter)
		{
			self._e detachall();
			self._e setmodel(self._s.model);
		}
	}
	else if(self._s.type === "actor")
	{
		if(!error(self._e.classname !== "script_model", "makeFakeAI must be applied to a script_model"))
		{
			self._e makefakeai();
		}
		if(!(isdefined(self._s.removeweapon) && self._s.removeweapon))
		{
			self._e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
		}
	}
	set_objective();
	if(isdefined(self._s.dynamicpaths) && self._s.dynamicpaths)
	{
		self._e disconnectpaths(2);
	}
}

/*
	Name: function_d09b043
	Namespace: csceneobject
	Checksum: 0x80F724D1
	Offset: 0x1C88
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_d09b043()
{
}

/*
	Name: get_animation_name
	Namespace: csceneobject
	Checksum: 0x4A239485
	Offset: 0x1C98
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function get_animation_name(_str_shot)
{
	n_shot = get_shot(_str_shot);
	if(isdefined(n_shot) && isdefined(self._s.shots[n_shot].entry))
	{
		foreach(s_entry in self._s.shots[n_shot].entry)
		{
			if(isdefined(s_entry.animation))
			{
				str_animation = [[ self ]]->animation_lookup(s_entry.animation, undefined, 0);
				return str_animation;
			}
			if(isdefined(s_entry.("anim")))
			{
				str_animation = [[ self ]]->animation_lookup(s_entry.("anim"), undefined, 0);
				return str_animation;
			}
		}
	}
}

/*
	Name: function_e0df299e
	Namespace: csceneobject
	Checksum: 0xBEEA71CD
	Offset: 0x1DF8
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function function_e0df299e(_str_shot)
{
	n_shot = get_shot(_str_shot);
	if(isdefined(n_shot) && isdefined(self._s.shots[n_shot].entry))
	{
		foreach(s_entry in self._s.shots[n_shot].entry)
		{
			if(isdefined(s_entry.("anim")) || isdefined(s_entry.cameraswitcher))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: function_24f8cfb5
	Namespace: csceneobject
	Checksum: 0x27B28931
	Offset: 0x1F00
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_24f8cfb5(str_shot)
{
	return str_shot === self._o_scene.var_232738b3 && self._o_scene._str_mode !== "init";
}

/*
	Name: function_b260bdcc
	Namespace: csceneobject
	Checksum: 0xBC225C9F
	Offset: 0x1F48
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_b260bdcc(str_shot)
{
	return str_shot === self._o_scene.var_355308d8 && self._o_scene._str_mode !== "init";
}

/*
	Name: get_shot
	Namespace: csceneobject
	Checksum: 0x85A27DEB
	Offset: 0x1F90
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function get_shot(str_shot)
{
	foreach(n_shot, s_shot in self._s.shots)
	{
		if(str_shot === s_shot.name)
		{
			return n_shot;
		}
	}
	return undefined;
}

/*
	Name: function_730a4c60
	Namespace: csceneobject
	Checksum: 0x5EA45D74
	Offset: 0x2028
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_730a4c60(str_shot)
{
	foreach(s_shot in self._s.shots)
	{
		if(str_shot === s_shot.name)
		{
			return s_shot;
		}
	}
	return undefined;
}

/*
	Name: function_f0e3e344
	Namespace: csceneobject
	Checksum: 0xDD4027CC
	Offset: 0x20C0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_f0e3e344()
{
	if(isdefined(self.var_55b4f21e.var_1c7fbd6b) && isdefined(self._e))
	{
		self._e setmodel(self.var_55b4f21e.var_1c7fbd6b);
	}
}

/*
	Name: function_9ec459a2
	Namespace: csceneobject
	Checksum: 0xB5FE6898
	Offset: 0x2118
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_9ec459a2()
{
	if(isdefined(self.var_55b4f21e.var_64c0ee5a) && isdefined(self._e))
	{
		self._e setmodel(self.var_55b4f21e.var_64c0ee5a);
	}
}

/*
	Name: function_e91c94b9
	Namespace: csceneobject
	Checksum: 0x52F50404
	Offset: 0x2170
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_e91c94b9(n_shot)
{
	if(isdefined(n_shot))
	{
		if(isdefined(self._s.shots[n_shot].var_1bc28a87) && self._s.shots[n_shot].var_1bc28a87)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: has_streamer_hint
	Namespace: csceneobject
	Checksum: 0x9C3DE6C
	Offset: 0x21D8
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function has_streamer_hint()
{
	if(is_player() && isdefined(self._o_scene._a_streamer_hint) && isdefined(self._o_scene._a_streamer_hint[self._str_team]))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_1e19d813
	Namespace: csceneobject
	Checksum: 0xFA52C2F9
	Offset: 0x2238
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_1e19d813()
{
	if(isdefined(self._o_scene._e_root))
	{
		self._o_scene._e_root notify(#"hash_4e8860ad89fcf927", {#str_scene:self._o_scene._str_name, #hash_fbd6d50c:self._e});
	}
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.target))
	{
		var_c17a3b30 = getnode(self._o_scene._e_root.target, "targetname");
		if(isdefined(var_c17a3b30) && (isdefined(var_c17a3b30.var_514e7397) && var_c17a3b30.var_514e7397))
		{
			var_c17a3b30.var_31c05612 = 1;
		}
	}
	if(isdefined(self._s.var_d318cc2c) && self._s.var_d318cc2c)
	{
		if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.scene_played))
		{
			foreach(str_shot in self._o_scene.var_5a2219f0)
			{
				self._o_scene._e_root.scene_played[str_shot] = 1;
			}
		}
		if(isdefined(self._o_scene._a_objects))
		{
			foreach(obj in self._o_scene._a_objects)
			{
				if(isdefined(obj._e) && obj._s.type === "prop")
				{
					obj._e stopanimscripted();
					obj._e physicslaunch();
				}
			}
		}
		thread [[ self._o_scene ]]->stop();
	}
}

/*
	Name: function_638ad737
	Namespace: csceneobject
	Checksum: 0xA4F205CA
	Offset: 0x2540
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_638ad737(str_shot)
{
	if(isdefined(self._e) && !isplayer(self._e) && (!(isdefined(self._e.isdying) && self._e.isdying)) && (isdefined(self._s.deletewhenfinished) && self._s.deletewhenfinished))
	{
		if(str_shot != "init" && function_b260bdcc(str_shot) && !function_b52254e6())
		{
			self._e thread scene::synced_delete(self._o_scene._str_name);
		}
		else if(str_shot != "init" && function_b52254e6() && (isdefined(self._o_scene.var_d84cc502) && self._o_scene.var_d84cc502))
		{
			self._e thread scene::synced_delete(self._o_scene._str_name);
		}
	}
}

/*
	Name: play
	Namespace: csceneobject
	Checksum: 0xFE68D28B
	Offset: 0x26D0
	Size: 0xA6C
	Parameters: 2
	Flags: Linked
*/
function play(str_shot = "play", n_start_time)
{
	n_shot = get_shot(str_shot);
	if(!isdefined(n_shot) && !has_streamer_hint())
	{
		flagsys::set(str_shot + "ready");
		flagsys::set(str_shot + "finished");
		function_638ad737(str_shot);
		return;
	}
	self notify(#"new_shot");
	self endon(#"new_shot");
	flagsys::set(str_shot + "active");
	if(!isdefined(self._o_scene._a_active_shots))
	{
		self._o_scene._a_active_shots = [];
	}
	else if(!isarray(self._o_scene._a_active_shots))
	{
		self._o_scene._a_active_shots = array(self._o_scene._a_active_shots);
	}
	if(!isinarray(self._o_scene._a_active_shots, str_shot))
	{
		self._o_scene._a_active_shots[self._o_scene._a_active_shots.size] = str_shot;
	}
	if(isdefined(self._str_shot))
	{
		cleanup();
	}
	self._str_shot = str_shot;
	self.var_55b4f21e = self._s.shots[n_shot];
	flagsys::clear(self._str_shot + "stopped");
	flagsys::clear(self._str_shot + "finished");
	flagsys::clear(self._str_shot + "ready");
	flagsys::set(self._str_shot + "active");
	spawn();
	function_f0e3e344();
	if(isdefined(self.var_55b4f21e.var_51093f2d) && self.var_55b4f21e.var_51093f2d)
	{
		waitframe(1);
	}
	else if(function_5c2a9efa())
	{
		function_ee94f77();
		play_anim("chicken_dance_placeholder_loop", 0, undefined, n_start_time);
	}
	else
	{
		var_e1c809d = self.var_55b4f21e.entry;
		function_ee94f77();
		if(is_player())
		{
			var_3f83c458 = array("cameraswitcher", "anim");
		}
		else
		{
			var_3f83c458 = array("anim");
		}
		foreach(str_entry_type in var_3f83c458)
		{
			if(!is_alive() || function_3919a776() || !isarray(var_e1c809d))
			{
				break;
			}
			foreach(s_entry in var_e1c809d)
			{
				entry = s_entry.(str_entry_type);
				if(isdefined(entry))
				{
					switch(str_entry_type)
					{
						case "cameraswitcher":
						{
							/#
								if(function_7a600918(entry))
								{
									error(!isassetloaded("", entry), "" + function_9e72a96(entry) + "");
								}
								else
								{
									error(!isassetloaded("", entry), "" + entry + "");
								}
							#/
							var_aa49b05f = 1;
							play_anim(entry, 1, undefined, n_start_time);
							break;
						}
						case "anim":
						{
							/#
								if(isdefined(self._s.issiege) && self._s.issiege)
								{
									if(function_7a600918(entry))
									{
										error(!isassetloaded("", entry), "" + function_9e72a96(entry) + "");
									}
									else
									{
										error(!isassetloaded("", entry), "" + entry + "");
									}
								}
								else if(function_7a600918(entry))
								{
									error(!isassetloaded("", entry), "" + function_9e72a96(entry) + "");
								}
								else
								{
									error(!isassetloaded("", entry), "" + entry + "");
								}
							#/
							var_aa49b05f = 1;
							play_anim(entry, 0, isdefined(self.var_55b4f21e.var_1bc28a87) && self.var_55b4f21e.var_1bc28a87, n_start_time);
							break;
						}
						default:
						{
							/#
								error(1, "" + str_entry_type + "");
							#/
						}
					}
				}
			}
		}
		if(!(isdefined(var_aa49b05f) && var_aa49b05f))
		{
			waitframe(1);
			if(function_b260bdcc(self._str_shot))
			{
				self._b_active_anim = 0;
			}
		}
		var_aa49b05f = 0;
	}
	function_9ec459a2();
	if(is_player())
	{
		function_37c00617();
	}
	flagsys::wait_till_clear("scene_interactive_shot_active");
	if(!self._o_scene._b_testing)
	{
		flagsys::wait_till_clear("waiting_for_damage");
	}
	if(isdefined(self._o_scene.var_2bc31f02) && self._o_scene.var_2bc31f02 && (isdefined(self._o_scene.var_d84cc502) && self._o_scene.var_d84cc502))
	{
		self._o_scene flagsys::set(#"hash_42da41892ac54794");
	}
	if(is_alive())
	{
		flagsys::set(self._str_shot + "finished");
		if(isdefined(self._s.diewhenfinished) && self._s.diewhenfinished && function_b260bdcc(self._str_shot) || (isdefined(self.var_55b4f21e.diewhenfinished) && self.var_55b4f21e.diewhenfinished))
		{
			kill_ent();
		}
	}
	else
	{
		flagsys::set(self._str_shot + "stopped");
	}
	if(!self._b_active_anim)
	{
		cleanup();
	}
}

/*
	Name: function_ee94f77
	Namespace: csceneobject
	Checksum: 0xC1CE502A
	Offset: 0x3148
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_ee94f77()
{
	function_dd4f74e1();
	function_587971b6();
	function_ebbbd00d();
}

/*
	Name: function_dd4f74e1
	Namespace: csceneobject
	Checksum: 0x45D74D8B
	Offset: 0x3188
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_dd4f74e1()
{
	if(isdefined(self._s.firstframe) && self._s.firstframe && self._o_scene._str_mode == "init" && isdefined(self._e) && (!(isdefined(self._e.var_68ade67d) && self._e.var_68ade67d)))
	{
		self._b_first_frame = 1;
	}
	else
	{
		self._b_first_frame = 0;
	}
}

/*
	Name: function_587971b6
	Namespace: csceneobject
	Checksum: 0xA906115E
	Offset: 0x3238
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_587971b6()
{
	self._n_blend = (isdefined(self.var_55b4f21e.blend) ? self.var_55b4f21e.blend : 0);
}

/*
	Name: function_ebbbd00d
	Namespace: csceneobject
	Checksum: 0x17CEB1C3
	Offset: 0x3278
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_ebbbd00d()
{
	if(self._b_first_frame)
	{
		return;
	}
	n_spacer_min = self.var_55b4f21e.spacermin;
	n_spacer_max = self.var_55b4f21e.spacermax;
	if(isdefined(n_spacer_min) || isdefined(n_spacer_max) && !is_skipping_scene())
	{
		if(isdefined(n_spacer_min) && isdefined(n_spacer_max))
		{
			if(!error(n_spacer_min >= n_spacer_max, "Spacer Min value must be less than Spacer Max value!"))
			{
				run_wait(randomfloatrange(n_spacer_min, n_spacer_max));
			}
		}
		else if(isdefined(n_spacer_min))
		{
			run_wait(n_spacer_min);
		}
		else if(isdefined(n_spacer_max))
		{
			run_wait(n_spacer_max);
		}
	}
}

/*
	Name: function_37c00617
	Namespace: csceneobject
	Checksum: 0xF94D9388
	Offset: 0x33A0
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_37c00617()
{
	if(isdefined(self._o_scene._a_objects))
	{
		foreach(obj in self._o_scene._a_objects)
		{
			if(isdefined(obj) && [[ obj ]]->is_player())
			{
				obj flagsys::wait_till_clear("camera_playing");
			}
		}
	}
}

/*
	Name: _dynamic_paths
	Namespace: csceneobject
	Checksum: 0x28D27C9C
	Offset: 0x3460
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function _dynamic_paths()
{
	if(isdefined(self._e) && (isdefined(self._s.dynamicpaths) && self._s.dynamicpaths))
	{
		if(distance2dsquared(self._e.origin, self._e.scene_orig_origin) > 4)
		{
			self._e disconnectpaths(2, 0);
		}
	}
}

/*
	Name: run_wait
	Namespace: csceneobject
	Checksum: 0x734A2F5D
	Offset: 0x3500
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function run_wait(wait_time)
{
	while(wait_start_time < wait_time && !is_skipping_scene())
	{
		wait_start_time = wait_start_time + float(function_60d95f53()) / 1000;
		waitframe(1);
	}
}

/*
	Name: scene_reach
	Namespace: csceneobject
	Checksum: 0x87D3795
	Offset: 0x3590
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function scene_reach()
{
	if(!isactor(self._e) && !isbot(self._e))
	{
		return;
	}
	b_do_reach = isdefined(self._s.doreach) && self._s.doreach || (isdefined(self.var_55b4f21e.var_a8e01b92) && self.var_55b4f21e.var_a8e01b92) || (isdefined(self.var_55b4f21e.var_1956ecbb) && self.var_55b4f21e.var_1956ecbb) && (!(isdefined(self._o_scene._b_testing) && self._o_scene._b_testing) || getdvarint(#"scene_test_with_reach", 0));
	if(b_do_reach)
	{
		str_animation = get_animation_name(self._str_shot);
		self._e val::reset(#"scene", "hide");
		if(isdefined(self._s.disablearrivalinreach) && self._s.disablearrivalinreach || (isdefined(self.var_55b4f21e.var_1956ecbb) && self.var_55b4f21e.var_1956ecbb))
		{
			self._e animation::reach(str_animation, get_align_ent(), get_align_tag(), 1);
		}
		else
		{
			self._e animation::reach(str_animation, get_align_ent(), get_align_tag());
		}
		function_9e4b3920();
	}
	flagsys::set(self._str_shot + "ready");
}

/*
	Name: function_9e4b3920
	Namespace: csceneobject
	Checksum: 0xFA3C3E0D
	Offset: 0x3820
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_9e4b3920()
{
	if(isdefined(self._e) && (isbot(self._e) || isai(self._e)))
	{
		if(isbot(self._e))
		{
			self._e namespace_87f62ea8::function_23cbc6c1(self._e.origin, 1);
		}
		else
		{
			self._e setgoal(self._e.origin, 1);
		}
	}
}

/*
	Name: stop
	Namespace: csceneobject
	Checksum: 0x84CF24D9
	Offset: 0x38F0
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function stop(b_clear = 0, b_dont_clear_anim = 0)
{
	self notify(#"new_shot");
	if(isdefined(self._str_shot))
	{
		flagsys::set(self._str_shot + "stopped");
		if(b_clear)
		{
			if(isdefined(self._e))
			{
				self._e notify(#"scene_stop");
				if(isplayer(self._e))
				{
					[[ self ]]->_stop(b_dont_clear_anim);
				}
				else
				{
					self._e delete();
				}
			}
		}
		else
		{
			[[ self ]]->_stop(b_dont_clear_anim);
		}
		cleanup();
	}
}

/*
	Name: _stop
	Namespace: csceneobject
	Checksum: 0x751BA5
	Offset: 0x3A18
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function _stop(b_dont_clear_anim = 0)
{
	if(isalive(self._e))
	{
		self._e notify(#"scene_stop");
		if(!b_dont_clear_anim)
		{
			self._e animation::stop(0.2);
		}
	}
}

/*
	Name: cleanup
	Namespace: csceneobject
	Checksum: 0x12668F3D
	Offset: 0x3A98
	Size: 0x324
	Parameters: 0
	Flags: Linked
*/
function cleanup()
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + (isdefined(self._s.name) ? self._s.name : self._s.model));
		}
	#/
	function_fda037ff();
	if(flagsys::get(self._str_shot + "active") && !flagsys::get(#"waiting_for_damage"))
	{
		b_finished = flagsys::get(self._str_shot + "finished");
		b_stopped = flagsys::get(self._str_shot + "stopped");
		if(isdefined(self._e) && !isplayer(self._e))
		{
			self._e sethighdetail(0);
			function_638ad737(self._str_shot);
		}
		[[ self ]]->_cleanup();
		if(isdefined(self._e) && !isplayer(self._e))
		{
			self._e._scene_object = undefined;
			self._e.current_scene = undefined;
			self._e.anim_debug_name = undefined;
			self._e flagsys::clear(#"scene");
		}
		if(is_alive())
		{
			[[ self ]]->_reset_values();
		}
	}
	if(isdefined(self._e) && !isplayer(self._e))
	{
		self._e flagsys::clear(#"hash_2f30b24ec0e23830");
		self._e flagsys::clear(#"hash_e2ce599b208682a");
		self._e flagsys::clear(#"hash_f21f320f68c0457");
	}
	flagsys::clear(self._str_shot + "active");
}

/*
	Name: function_fda037ff
	Namespace: csceneobject
	Checksum: 0x49F0834C
	Offset: 0x3DC8
	Size: 0x2EC
	Parameters: 0
	Flags: Linked
*/
function function_fda037ff()
{
	if(!isdefined(self.var_55b4f21e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_39fd697b))
	{
		a_ents = getentarray(self.var_55b4f21e.var_39fd697b, "targetname", 1);
		array::thread_all(a_ents, &val::set, #"hash_231dddc2afe6275f", "hide", 1);
	}
	else if(isdefined(self.var_55b4f21e.var_4ceff7a6))
	{
		a_ents = getentarray(self.var_55b4f21e.var_4ceff7a6, "targetname", 1);
		array::thread_all(a_ents, &val::reset, #"hash_231dddc2afe6275f", "hide");
	}
	if(!isdefined(self._e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_71ce74a1) && self.var_55b4f21e.var_71ce74a1 && !isplayer(self._e))
	{
		thread function_2035b6d6(self._e);
		return;
	}
	if(isdefined(self.var_55b4f21e.var_3ea5d95f) && self.var_55b4f21e.var_3ea5d95f && self._str_shot != "init")
	{
		self._e connectpaths();
	}
	else if(isdefined(self.var_55b4f21e.var_8645db22) && self.var_55b4f21e.var_8645db22)
	{
		self._e disconnectpaths(2, 1);
	}
	if(isdefined(self.var_55b4f21e.var_6d848d4b) && self.var_55b4f21e.var_6d848d4b)
	{
		thread function_9960f8f0(self._e);
	}
	else if(isdefined(self.var_55b4f21e.var_78089fee) && self.var_55b4f21e.var_78089fee)
	{
		self._e notify(#"hash_13ba40790581c706");
		self._e val::reset(#"scene", "hide");
	}
}

/*
	Name: function_9960f8f0
	Namespace: csceneobject
	Checksum: 0x1553AE11
	Offset: 0x40C0
	Size: 0xFC
	Parameters: 1
	Flags: Linked
*/
function function_9960f8f0(_e)
{
	_e notify(#"hash_15c9785b530a6563");
	_e endon(#"death", #"hash_4ab65f6d84f4135", #"hash_2d5f4b208c6322bc", #"hash_15c9785b530a6563");
	if(self._o_scene._str_mode !== "init")
	{
		self._o_scene waittill_timeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
	}
	_e val::set(#"scene", "hide", 2);
}

/*
	Name: function_2035b6d6
	Namespace: csceneobject
	Checksum: 0x2BBDDFAF
	Offset: 0x41C8
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_2035b6d6(_e)
{
	_e notify(#"hash_496cf5ea51dbf90");
	_e endon(#"death", #"hash_770bf84f62435a17", #"hash_496cf5ea51dbf90");
	var_be17187b = undefined;
	var_be17187b = self._o_scene waittill_timeout(0.15, #"hash_60adeaccbb565546", #"scene_stop", #"scene_done", #"scene_skip_completed");
	_e thread scene::synced_delete(self._o_scene._str_name);
}

/*
	Name: _cleanup
	Namespace: csceneobject
	Checksum: 0x80F724D1
	Offset: 0x42A8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function _cleanup()
{
}

/*
	Name: get_align_ent
	Namespace: csceneobject
	Checksum: 0xB897057
	Offset: 0x42B8
	Size: 0x256
	Parameters: 0
	Flags: Linked
*/
function get_align_ent()
{
	e_align = undefined;
	if(isdefined(self.var_55b4f21e.aligntarget) && (!(isdefined(self.var_55b4f21e.var_ab59a015) && self.var_55b4f21e.var_ab59a015)))
	{
		var_690ec5fb = self.var_55b4f21e.aligntarget;
	}
	else if(isdefined(self._s.aligntarget) && !self._s.aligntarget === self._o_scene._s.aligntarget)
	{
		var_690ec5fb = self._s.aligntarget;
	}
	if(isdefined(var_690ec5fb))
	{
		a_scene_ents = [[ self._o_scene ]]->get_ents();
		if(isdefined(a_scene_ents[var_690ec5fb]))
		{
			e_align = a_scene_ents[var_690ec5fb];
		}
		else
		{
			e_align = scene::get_existing_ent(var_690ec5fb, 0, 1, self._o_scene._str_name);
		}
		if(!isdefined(e_align))
		{
			loc_0000442C:
			loc_0000445C:
			str_msg = "Align target '" + (isdefined(var_690ec5fb) ? "" + var_690ec5fb : "") + "' doesn't exist for scene object " + (isdefined(self._str_name) ? "" + self._str_name : "") + " in shot named " + (isdefined(self._str_shot) ? "" + self._str_shot : "");
			if(!warning(self._o_scene._b_testing, str_msg))
			{
				error(getdvarint(#"scene_align_errors", 1), str_msg);
			}
		}
	}
	if(!isdefined(e_align))
	{
		e_align = [[ self._o_scene ]]->get_align_ent();
	}
	return e_align;
}

/*
	Name: get_align_tag
	Namespace: csceneobject
	Checksum: 0x580EEB9F
	Offset: 0x4518
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function get_align_tag()
{
	n_shot = get_shot(self._str_shot);
	if(isdefined(n_shot) && isdefined(self._s.shots[n_shot].aligntargettag))
	{
		return self._s.shots[n_shot].aligntargettag;
	}
	if(isdefined(self._s.aligntargettag))
	{
		return self._s.aligntargettag;
	}
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.e_scene_link))
	{
		return "tag_origin";
	}
	return self._o_scene._s.aligntargettag;
}

/*
	Name: function_14f96d6b
	Namespace: csceneobject
	Checksum: 0x3CD45F6B
	Offset: 0x4618
	Size: 0x31E
	Parameters: 0
	Flags: Linked
*/
function function_14f96d6b()
{
	self._e endon_callback(&function_20f309bf, #"delete", #"scene_stop", #"stop_tracking_damage_scene_ent");
	self._o_scene endon(#"scene_done", #"scene_stop", #"hash_42da41892ac54794");
	self._e setcandamage(1);
	function_23575fad();
	self._o_scene.var_2bc31f02 = 1;
	foreach(s_shot in self._s.shots)
	{
		if(s_shot.name === "init")
		{
			self._e.var_5b7900ec[s_shot.name] = 1;
			continue;
		}
		if(function_f12c5e67(s_shot))
		{
			self._e.var_5b7900ec[s_shot.name] = 0;
		}
	}
	if(isdefined(self._s.var_2baad8fc) && self._s.var_2baad8fc)
	{
		self._e util::function_5d36c37a();
	}
	while(true)
	{
		flagsys::set(#"waiting_for_damage");
		var_37fa9b04 = undefined;
		var_37fa9b04 = self._e waittill(#"damage", #"death");
		if(!isdefined(self._e))
		{
			return;
		}
		if(isdefined(self._e.n_health))
		{
			waittillframeend();
		}
		foreach(s_shot in self._s.shots)
		{
			function_72f549e0(s_shot, var_37fa9b04);
		}
		if(isdefined(self._e.var_4819ae76) && self._e.var_4819ae76)
		{
			return;
		}
	}
}

/*
	Name: function_20f309bf
	Namespace: csceneobject
	Checksum: 0x19F8AA50
	Offset: 0x4940
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_20f309bf(str_notify)
{
	if(str_notify == "stop_tracking_damage_scene_ent" || str_notify == "delete")
	{
		if(isdefined(self._scene_object))
		{
			self.var_4819ae76 = 1;
			self.health = 0;
			self._scene_object thread function_ea176ba9();
		}
	}
}

/*
	Name: function_72f549e0
	Namespace: csceneobject
	Checksum: 0xBA5F1B4B
	Offset: 0x49B8
	Size: 0x4E4
	Parameters: 2
	Flags: Linked
*/
function function_72f549e0(s_shot, var_37fa9b04)
{
	if(!isdefined(self._e))
	{
		return 0;
	}
	if(isdefined(self._e.var_5b7900ec[s_shot.name]) && self._e.var_5b7900ec[s_shot.name])
	{
		return 0;
	}
	if(!function_128f0294(s_shot, var_37fa9b04))
	{
		return 0;
	}
	var_f506eca3 = 0;
	if(!isdefined(s_shot.damagethreshold) && (!(isdefined(s_shot.var_132c9791) && s_shot.var_132c9791)))
	{
		var_f506eca3 = 1;
	}
	if(var_f506eca3)
	{
		var_f2059ab8 = 0;
		var_520e99b5 = 0;
	}
	else if(isdefined(s_shot.var_132c9791) && s_shot.var_132c9791)
	{
		s_shot.damagethreshold = 0;
	}
	if(isdefined(self._e.n_health))
	{
		n_current_health = self._e.n_health;
	}
	else
	{
		n_current_health = self._e.health;
	}
	if(n_current_health <= 0)
	{
		n_current_health = 0;
	}
	if(isdefined(self._e.var_f2ca854b))
	{
		var_f2ca854b = self._e.var_f2ca854b;
	}
	else
	{
		var_f2ca854b = self._e.maxhealth;
	}
	var_f2059ab8 = n_current_health / var_f2ca854b;
	var_520e99b5 = s_shot.damagethreshold;
	if(!(isdefined(self._s.var_a1c5c678) && self._s.var_a1c5c678))
	{
		var_f61b965e = var_f2059ab8 <= 0;
		var_37fa9b04.attacker util::show_hit_marker(var_f61b965e);
	}
	if(var_f2059ab8 <= var_520e99b5)
	{
		self._e.var_68ade67d = 1;
		self._e notify(#"hash_4d265bbfcf0b6b4b", {#hash_d2b5cb6a:var_520e99b5, #hash_859dbb7c:var_f2059ab8, #hash_37fa9b04:var_37fa9b04, #str_scene:self._o_scene._str_name, #str_shot:s_shot.name});
		level notify(#"hash_4d265bbfcf0b6b4b", {#hash_d2b5cb6a:var_520e99b5, #hash_859dbb7c:var_f2059ab8, #hash_37fa9b04:var_37fa9b04, #str_scene:self._o_scene._str_name, #str_shot:s_shot.name, #hash_f2dfc31f:self._e});
		if(isdefined(self._o_scene._e_root))
		{
			self._o_scene._e_root notify(#"hash_4d265bbfcf0b6b4b", {#hash_d2b5cb6a:var_520e99b5, #hash_859dbb7c:var_f2059ab8, #hash_37fa9b04:var_37fa9b04, #str_scene:self._o_scene._str_name, #str_shot:s_shot.name, #hash_f2dfc31f:self._e});
		}
		self._e.var_5b7900ec[s_shot.name] = 1;
		thread [[ self._o_scene ]]->play(s_shot.name, undefined, undefined, "single");
		if(function_1205d1f0())
		{
			self._e setcandamage(0);
			thread function_b485ee21(s_shot, var_37fa9b04);
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_1205d1f0
	Namespace: csceneobject
	Checksum: 0x8F52B266
	Offset: 0x4EA8
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_1205d1f0()
{
	if(isdefined(self._e.var_5b7900ec))
	{
		var_50b24637 = 0;
		foreach(var_74f5d118 in self._e.var_5b7900ec)
		{
			if(var_74f5d118)
			{
				var_50b24637++;
				if(var_50b24637 == self._e.var_5b7900ec.size)
				{
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
	Name: function_ea176ba9
	Namespace: csceneobject
	Checksum: 0x3B83DD39
	Offset: 0x4F78
	Size: 0x19C
	Parameters: 0
	Flags: Linked
*/
function function_ea176ba9()
{
	var_d705d1a8 = 1;
	foreach(o_obj in self._o_scene._a_objects)
	{
		if(isdefined(o_obj._e) && (!(isdefined(o_obj._e.var_4819ae76) && o_obj._e.var_4819ae76)))
		{
			var_d705d1a8 = 0;
			break;
		}
	}
	if(var_d705d1a8)
	{
		self._o_scene.var_d84cc502 = 1;
		foreach(o_obj in self._o_scene._a_objects)
		{
			o_obj flagsys::clear(#"waiting_for_damage");
		}
		if(isdefined(self._o_scene._e_root))
		{
			self._o_scene._e_root notify(#"hash_18be12558bc58fe");
		}
	}
}

/*
	Name: function_b485ee21
	Namespace: csceneobject
	Checksum: 0xB443282E
	Offset: 0x5120
	Size: 0x298
	Parameters: 2
	Flags: Linked
*/
function function_b485ee21(s_shot, var_37fa9b04)
{
	self._e notify(#"hash_b02076d93b34558");
	self._e endon(#"hash_b02076d93b34558", #"delete", #"scene_stop");
	var_5b7900ec = self._e.var_5b7900ec;
	foreach(var_74f5d118 in var_5b7900ec)
	{
		while(!var_74f5d118)
		{
			waitframe(1);
		}
	}
	self._e.var_4819ae76 = 1;
	thread function_ea176ba9();
	if(isdefined(self._e))
	{
		self._e notify(#"hash_18be12558bc58fe", {#hash_5cd2f3ce:self._str_name, #hash_37fa9b04:var_37fa9b04, #str_scene:self._o_scene._str_name, #str_shot:s_shot.name});
		self._e.health = 0;
	}
	if(isdefined(self._o_scene._e_root))
	{
		self._o_scene._e_root notify(#"hash_5bb6862842cacfe8", {#hash_37fa9b04:var_37fa9b04, #str_shot:s_shot.name, #hash_5cd2f3ce:self._str_name, #hash_b551c535:self._e});
	}
	level notify(#"hash_4d265bbfcf0b6b4b", {#str_scene:self._o_scene._str_name, #str_shot:s_shot.name});
}

/*
	Name: function_23575fad
	Namespace: csceneobject
	Checksum: 0xC474AB5A
	Offset: 0x53C0
	Size: 0x25E
	Parameters: 0
	Flags: Linked
*/
function function_23575fad()
{
	if(isdefined(self._s.var_873368a8))
	{
		self._e.script_health = self._s.var_873368a8;
		if(isdefined(self._e.n_health))
		{
			self._e.n_health = self._s.var_873368a8;
			self._e.var_f2ca854b = self._e.n_health;
			if(!isdefined(self._e.maxhealth))
			{
				self._e.maxhealth = self._e.n_health;
			}
		}
		else
		{
			self._e.health = self._s.var_873368a8;
			if(!isdefined(self._e.maxhealth))
			{
				self._e.maxhealth = self._e.health;
			}
		}
	}
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.script_health))
	{
		self._e.script_health = self._o_scene._e_root.script_health;
		if(isdefined(self._e.n_health))
		{
			self._e.n_health = self._e.script_health;
			self._e.var_f2ca854b = self._e.script_health;
			self._e.maxhealth = self._e.n_health;
		}
		else
		{
			self._e.health = self._e.script_health;
			self._e.maxhealth = self._e.health;
		}
	}
	if(!isdefined(self._e.maxhealth))
	{
		self._e.maxhealth = self._e.health;
	}
}

/*
	Name: function_b52254e6
	Namespace: csceneobject
	Checksum: 0xC9620A8A
	Offset: 0x5628
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_b52254e6()
{
	if(isdefined(self.var_2a306f8a) && self.var_2a306f8a)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f12c5e67
	Namespace: csceneobject
	Checksum: 0xF5CC831C
	Offset: 0x5658
	Size: 0x13A
	Parameters: 1
	Flags: Linked
*/
function function_f12c5e67(s_shot)
{
	if(isdefined(self._s.runsceneondmg0) || isdefined(self._s.runsceneondmg1) || isdefined(self._s.runsceneondmg2) || isdefined(self._s.runsceneondmg3) || isdefined(self._s.runsceneondmg4))
	{
		return 1;
	}
	if(isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3 || (isdefined(s_shot.var_163ca9fa) && s_shot.var_163ca9fa) || (isdefined(s_shot.var_dbd0fa6f) && s_shot.var_dbd0fa6f) || (isdefined(s_shot.var_650063ca) && s_shot.var_650063ca) || (isdefined(s_shot.var_efd784b6) && s_shot.var_efd784b6))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_128f0294
	Namespace: csceneobject
	Checksum: 0x3A593BAC
	Offset: 0x57A0
	Size: 0x49C
	Parameters: 2
	Flags: Linked
*/
function function_128f0294(s_shot, var_37fa9b04)
{
	str_mod = var_37fa9b04.mod;
	loc_00005878:
	loc_000058CC:
	loc_00005920:
	str_damage_types = (self._s.runsceneondmg0 == "none" ? "" : self._s.runsceneondmg0) + (self._s.runsceneondmg1 == "none" ? "" : self._s.runsceneondmg1) + (self._s.runsceneondmg2 == "none" ? "" : self._s.runsceneondmg2) + (self._s.runsceneondmg3 == "none" ? "" : self._s.runsceneondmg3) + (self._s.runsceneondmg4 == "none" ? "" : self._s.runsceneondmg4);
	switch(str_mod)
	{
		case "mod_rifle_bullet":
		case "mod_pistol_bullet":
		{
			if(issubstr(str_damage_types, "bullet") || (isdefined(s_shot.var_163ca9fa) && s_shot.var_163ca9fa) || (isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3))
			{
				return 1;
			}
			break;
		}
		case "mod_explosive":
		case "mod_grenade":
		case "mod_grenade_splash":
		{
			if(issubstr(str_damage_types, "explosive") || (isdefined(s_shot.var_dbd0fa6f) && s_shot.var_dbd0fa6f) || (isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3))
			{
				return 1;
			}
			break;
		}
		case "mod_projectile":
		case "mod_projectile_splash":
		{
			if(issubstr(str_damage_types, "projectile") || (isdefined(s_shot.var_650063ca) && s_shot.var_650063ca) || (isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3))
			{
				return 1;
			}
			break;
		}
		case "mod_melee_weapon_butt":
		case "mod_melee":
		{
			if(issubstr(str_damage_types, "melee") || (isdefined(s_shot.var_efd784b6) && s_shot.var_efd784b6) || (isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3))
			{
				return 1;
			}
			break;
		}
		default:
		{
			if(issubstr(str_damage_types, "all") || (isdefined(s_shot.var_b3dddfd3) && s_shot.var_b3dddfd3))
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: _assign_unique_name
	Namespace: csceneobject
	Checksum: 0xDD3F4DCD
	Offset: 0x5C48
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function _assign_unique_name()
{
	if(isdefined(self._s.name))
	{
		self._str_name = self._s.name;
	}
	else
	{
		self._str_name = self._o_scene._str_name + "_noname" + [[ self._o_scene ]]->get_object_id();
	}
}

/*
	Name: get_orig_name
	Namespace: csceneobject
	Checksum: 0x8A2E080C
	Offset: 0x5CC0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_orig_name()
{
	return self._s.name;
}

/*
	Name: restore_saved_ent
	Namespace: csceneobject
	Checksum: 0x5ADDD9BC
	Offset: 0x5CE0
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function restore_saved_ent()
{
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.scene_ents) && (!(isdefined(self._o_scene._e_root.var_146935c1) && self._o_scene._e_root.var_146935c1)))
	{
		if(isdefined(self._o_scene._e_root.scene_ents[self._str_name]))
		{
			self._e = self._o_scene._e_root.scene_ents[self._str_name];
		}
	}
}

/*
	Name: set_objective
	Namespace: csceneobject
	Checksum: 0xABFB9AF0
	Offset: 0x5DB0
	Size: 0xBA
	Parameters: 0
	Flags: Linked
*/
function set_objective()
{
	if(!isdefined(self._e.script_objective))
	{
		if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.script_objective))
		{
			self._e.script_objective = self._o_scene._e_root.script_objective;
		}
		else if(isdefined(self._o_scene._s.script_objective))
		{
			self._e.script_objective = self._o_scene._s.script_objective;
		}
	}
}

/*
	Name: function_376c9d87
	Namespace: csceneobject
	Checksum: 0xE4B6D0C
	Offset: 0x5E78
	Size: 0x102
	Parameters: 3
	Flags: Linked
*/
function function_376c9d87(var_ec50a0d3, var_823c6db2, player)
{
	if(player adsbuttonpressed())
	{
		return self._str_current_anim;
	}
	if(var_ec50a0d3.var_9532f6db == "move_up" || var_ec50a0d3.var_9532f6db == "move_right")
	{
		if(var_823c6db2 >= 0)
		{
			return self._str_current_anim;
		}
		return self.var_55b4f21e.var_33a3e73c;
	}
	if(var_ec50a0d3.var_9532f6db == "move_down" || var_ec50a0d3.var_9532f6db == "move_left")
	{
		if(var_823c6db2 <= 0)
		{
			return self._str_current_anim;
		}
		return self.var_55b4f21e.var_33a3e73c;
	}
	return self._str_current_anim;
}

/*
	Name: function_a808aac7
	Namespace: csceneobject
	Checksum: 0x7E67D346
	Offset: 0x5F88
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_a808aac7()
{
	if(isdefined(self.var_55b4f21e.var_33a3e73c) && self.var_efc540b6 === self.var_55b4f21e.var_33a3e73c)
	{
		return 1;
	}
	return 0;
}

/*
	Name: animation_lookup
	Namespace: csceneobject
	Checksum: 0x33CD8632
	Offset: 0x5FD8
	Size: 0x40
	Parameters: 3
	Flags: Linked
*/
function animation_lookup(animation, ent = self._e, b_camera = 0)
{
	return animation;
}

/*
	Name: play_anim
	Namespace: csceneobject
	Checksum: 0x76AD3621
	Offset: 0x6020
	Size: 0x55A
	Parameters: 4
	Flags: Linked
*/
function play_anim(animation, b_camera_anim = 0, var_e052b59a = 0, n_start_time = 0)
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			if(isdefined(self._s.name))
			{
				printtoprightln("" + self._s.name);
			}
			else
			{
				printtoprightln("" + self._s.model);
			}
		}
	#/
	if(!is_shared_player())
	{
		animation = [[ self ]]->animation_lookup(animation, undefined, b_camera_anim);
	}
	self._str_current_anim = animation;
	if(_should_skip_anim(animation))
	{
		return;
	}
	if(self._b_first_frame || var_e052b59a)
	{
		n_rate = 0;
	}
	else
	{
		n_rate = 1;
	}
	if(n_rate > 0)
	{
		self._o_scene flagsys::wait_till(self._str_shot + "go");
	}
	if(function_b52254e6() && !function_f12c5e67(self.var_55b4f21e) && self._o_scene._str_mode !== "init")
	{
		self._e notify(#"stop_tracking_damage_scene_ent");
	}
	if(is_alive())
	{
		update_alignment();
		n_time = n_start_time;
		if(n_time != 0)
		{
			n_time = [[ self._o_scene ]]->get_anim_relative_start_time(animation, n_time, b_camera_anim);
		}
		if(scene::function_a63b9bca(self._o_scene._str_name))
		{
			n_time = 0.99;
			self._o_scene.n_start_time = 0.99;
		}
		if(function_5c2a9efa())
		{
			[[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
			self._b_active_anim = 0;
			_dynamic_paths();
		}
		else if(var_e052b59a)
		{
			flagsys::set(#"scene_interactive_shot_active");
			n_rate = 0;
			n_time = 0;
			thread [[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
			self._b_active_anim = 1;
		}
		else if(b_camera_anim)
		{
			thread [[ self ]]->play_camera(self._str_current_anim, n_time);
		}
		else if(self._b_first_frame)
		{
			thread [[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
			self._b_first_frame = 0;
			self._b_active_anim = 1;
		}
		else if(isanimlooping(animation))
		{
			if(self._str_shot === "init")
			{
				thread [[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
				self._b_active_anim = 1;
			}
			else if(function_b260bdcc(self._str_shot))
			{
				if(isdefined(self._o_scene._e_root))
				{
					self._o_scene._e_root notify(#"scene_done", {#str_scenedef:self._o_scene._str_name});
				}
				self._e notify(#"scene_done", {#str_scenedef:self._o_scene._str_name});
			}
			[[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
			self._b_active_anim = 0;
		}
		else
		{
			[[ self ]]->_play_anim(animation, n_rate, self._n_blend, n_time);
			self._b_active_anim = 0;
			_dynamic_paths();
		}
		_blend = 0;
	}
}

/*
	Name: update_alignment
	Namespace: csceneobject
	Checksum: 0xFCDBA9AC
	Offset: 0x6588
	Size: 0x596
	Parameters: 0
	Flags: Linked
*/
function update_alignment()
{
	self.m_align = get_align_ent();
	self.m_tag = get_align_tag();
	var_2dd2901f = ((isdefined(self._o_scene._s.var_922b4fc5) ? self._o_scene._s.var_922b4fc5 : 0), (isdefined(self._o_scene._s.var_3e692842) ? self._o_scene._s.var_3e692842 : 0), (isdefined(self._o_scene._s.var_be60a82b) ? self._o_scene._s.var_be60a82b : 0));
	var_acf1be3a = ((isdefined(self._o_scene._s.var_16999a5d) ? self._o_scene._s.var_16999a5d : 0), (isdefined(self._o_scene._s.var_29563fd6) ? self._o_scene._s.var_29563fd6 : 0), (isdefined(self._o_scene._s.var_eb00c330) ? self._o_scene._s.var_eb00c330 : 0));
	var_24a7cd13 = ((isdefined(self._s.var_922b4fc5) ? self._s.var_922b4fc5 : 0), (isdefined(self._s.var_3e692842) ? self._s.var_3e692842 : 0), (isdefined(self._s.var_be60a82b) ? self._s.var_be60a82b : 0));
	var_75cdf4bd = ((isdefined(self._s.var_16999a5d) ? self._s.var_16999a5d : 0), (isdefined(self._s.var_29563fd6) ? self._s.var_29563fd6 : 0), (isdefined(self._s.var_eb00c330) ? self._s.var_eb00c330 : 0));
	var_2a3b0294 = ((isdefined(self.var_55b4f21e.var_922b4fc5) ? self.var_55b4f21e.var_922b4fc5 : 0), (isdefined(self.var_55b4f21e.var_3e692842) ? self.var_55b4f21e.var_3e692842 : 0), (isdefined(self.var_55b4f21e.var_be60a82b) ? self.var_55b4f21e.var_be60a82b : 0));
	var_f3bd6699 = ((isdefined(self.var_55b4f21e.var_16999a5d) ? self.var_55b4f21e.var_16999a5d : 0), (isdefined(self.var_55b4f21e.var_29563fd6) ? self.var_55b4f21e.var_29563fd6 : 0), (isdefined(self.var_55b4f21e.var_eb00c330) ? self.var_55b4f21e.var_eb00c330 : 0));
	if(isdefined(self._o_scene._s.var_6a17a93d) && self._o_scene._s.var_6a17a93d)
	{
		var_d3c21d73 = var_2dd2901f + var_2a3b0294 + var_24a7cd13;
		v_ang_offset = var_acf1be3a + var_f3bd6699 + var_75cdf4bd;
	}
	else if(var_2a3b0294 != (0, 0, 0))
	{
		var_d3c21d73 = var_2a3b0294;
	}
	else if(var_24a7cd13 != (0, 0, 0))
	{
		var_d3c21d73 = var_24a7cd13;
	}
	else
	{
		var_d3c21d73 = var_2dd2901f;
	}
	if(var_f3bd6699 != (0, 0, 0))
	{
		v_ang_offset = var_f3bd6699;
	}
	else if(var_75cdf4bd != (0, 0, 0))
	{
		v_ang_offset = var_75cdf4bd;
	}
	else
	{
		v_ang_offset = var_acf1be3a;
	}
	if(self.m_align == level)
	{
		self.m_align = (0, 0, 0) + var_d3c21d73;
		self.m_tag = (0, 0, 0) + v_ang_offset;
	}
	else if(!isentity(self.m_align) && (var_d3c21d73 != (0, 0, 0) || v_ang_offset != (0, 0, 0)))
	{
		v_pos = self.m_align.origin + var_d3c21d73;
		v_ang = self.m_align.angles + v_ang_offset;
		self.m_align = {#angles:v_ang, #origin:v_pos};
	}
}

/*
	Name: function_a04fb5f4
	Namespace: csceneobject
	Checksum: 0x8234F93E
	Offset: 0x6B28
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_a04fb5f4()
{
	if(self._o_scene._s scene::is_igc() || [[ self._o_scene ]]->has_player() && (!(isdefined(self._o_scene._b_testing) && self._o_scene._b_testing)))
	{
		if(function_527113ae())
		{
			self._e setvisibletoall();
		}
		else if(!isplayer(self._e))
		{
			self._e setinvisibletoall();
			if(self._o_scene._str_team === "any")
			{
				self._e setvisibletoall();
			}
			else if(self._o_scene._str_team === "allies")
			{
				self._e setvisibletoallexceptteam("axis");
			}
			else if(self._o_scene._str_team === "axis")
			{
				self._e setvisibletoallexceptteam("allies");
			}
			else
			{
				self._e setvisibletoall();
			}
		}
	}
}

/*
	Name: _play_anim
	Namespace: csceneobject
	Checksum: 0xD08C21D2
	Offset: 0x6CD8
	Size: 0x894
	Parameters: 6
	Flags: Linked
*/
function _play_anim(animation, n_rate, n_blend, n_time, var_7d32b2c6, paused)
{
	if(self._e.scene_spawned === self._o_scene._s.name || function_527113ae() || self._o_scene._s scene::is_igc())
	{
		if(!isdefined(n_blend) || (isdefined(n_blend) && n_blend == 0))
		{
			self._e dontinterpolate();
		}
		self._e flagsys::set(#"hash_7cddd51e45d3ff3e");
	}
	function_a04fb5f4();
	n_lerp = (isdefined(var_7d32b2c6) ? var_7d32b2c6 : get_lerp_time());
	if(is_player() && !([[ self ]]->function_6c1c67c1()))
	{
		endcamanimscripted(self._e);
		n_camera_tween = get_camera_tween();
		if(n_camera_tween > 0)
		{
			self._e startcameratween(n_camera_tween);
		}
	}
	if(![[ self._o_scene ]]->function_19015532())
	{
		n_blend_out = (isai(self._e) ? 0.2 : 0);
	}
	else
	{
		n_blend_out = 0;
	}
	if(isdefined(self._s.diewhenfinished) && self._s.diewhenfinished || (isdefined(self.var_55b4f21e.diewhenfinished) && self.var_55b4f21e.diewhenfinished))
	{
		n_blend_out = 0;
	}
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + (isdefined(self._s.name) ? self._s.name : self._s.model) + "" + animation);
		}
	#/
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			if(!isdefined(level.animation_played))
			{
				level.animation_played = [];
				animation_played_name = (isdefined(self._s.name) ? self._s.name : self._s.model) + "" + animation;
				if(!isdefined(level.animation_played))
				{
					level.animation_played = [];
				}
				else if(!isarray(level.animation_played))
				{
					level.animation_played = array(level.animation_played);
				}
				level.animation_played[level.animation_played.size] = animation_played_name;
			}
		}
	#/
	self.current_playing_anim[self._n_ent_num] = animation;
	if(is_skipping_scene() && n_rate != 0)
	{
		thread skip_scene_shot_animations();
	}
	[[ self ]]->on_play_anim(self._e);
	if(isdefined(self._s.var_69aabff2) && self._s.var_69aabff2)
	{
		b_unlink_after_completed = 0;
	}
	if(function_5c2a9efa())
	{
		if(isactor(self._e) && isassetloaded("xanim", "chicken_dance_placeholder_loop"))
		{
			self._e thread animation::play(animation, self._e, self.m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, self._s.showweaponinfirstperson);
		}
		function_5c082667();
	}
	else if(isdefined(self._s.issiege) && self._s.issiege)
	{
		self._e animation::play_siege(animation, n_rate);
	}
	else
	{
		self._e animation::play(animation, self.m_align, self.m_tag, n_rate, n_blend, n_blend_out, n_lerp, n_time, self._s.showweaponinfirstperson, b_unlink_after_completed, undefined, paused);
	}
	if(isplayer(self._e))
	{
		self._e flagsys::clear(#"hash_7cddd51e45d3ff3e");
	}
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			log(toupper(self._s.type) + "" + function_9e72a96(animation) + "");
		}
	#/
	if(!isdefined(self._e) || !self._e isplayinganimscripted())
	{
		self.current_playing_anim[self._n_ent_num] = undefined;
	}
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			if(isdefined(level.animation_played))
			{
				for(i = 0; i < level.animation_played.size; i++)
				{
					animation_played_name = (isdefined(self._s.name) ? self._s.name : self._s.model) + "" + animation;
					if(level.animation_played[i] == animation_played_name)
					{
						arrayremovevalue(level.animation_played, animation_played_name);
						i--;
						continue;
					}
				}
			}
		}
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + (isdefined(self._s.name) ? self._s.name : self._s.model) + "" + animation);
		}
	#/
}

/*
	Name: function_5c082667
	Namespace: csceneobject
	Checksum: 0x833B1548
	Offset: 0x7578
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_5c082667()
{
	s_start_spot = function_3e22944e();
	if(!isdefined(s_start_spot.target))
	{
		self._e waittill(#"player_downed", #"death", #"scene_stop");
		return;
	}
	self._e endon(#"death", #"scene_stop");
	s_current_struct = struct::get(s_start_spot.target);
	while(isdefined(s_current_struct))
	{
		if(!isdefined(self._e.var_645ab05a))
		{
			self._e.var_acbd43ee = util::spawn_model("tag_origin", self._e.origin, self._e.angles);
			self._e linkto(self._e.var_acbd43ee);
			self._e thread function_98561e95();
		}
		self._e.var_acbd43ee moveto(s_current_struct.origin, n_move_time);
		self._e.var_acbd43ee rotateto(s_current_struct.angles, n_move_time);
		self._e.var_acbd43ee waittill(#"movedone");
		if(isdefined(s_current_struct.script_float))
		{
			n_move_time = s_current_struct.script_float;
		}
		else
		{
			n_move_time = 1;
		}
		if(isdefined(s_current_struct.target))
		{
			s_current_struct = struct::get(s_current_struct.target);
		}
		else
		{
			s_current_struct = undefined;
		}
	}
	if(isdefined(self._e.var_acbd43ee))
	{
		self._e.var_acbd43ee delete();
	}
	self._e unlink();
	self._e animation::stop();
	self._e notify(#"hash_456b12fb28128d17", (isdefined(s_start_spot.script_float) ? s_start_spot.script_float : 1));
}

/*
	Name: function_98561e95
	Namespace: csceneobject
	Checksum: 0xAE515D8F
	Offset: 0x7880
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_98561e95()
{
	self endon(#"hash_456b12fb28128d17");
	var_9f5994d7 = self.var_acbd43ee;
	self waittill(#"death", #"scene_stop");
	if(isdefined(var_9f5994d7))
	{
		var_9f5994d7 delete();
	}
}

/*
	Name: on_play_anim
	Namespace: csceneobject
	Checksum: 0x655C6AF1
	Offset: 0x78F8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_play_anim(ent)
{
}

/*
	Name: function_d2039b28
	Namespace: csceneobject
	Checksum: 0xE1586A13
	Offset: 0x7910
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_d2039b28()
{
	return (isdefined(self._o_scene._e_root.origin) ? self._o_scene._e_root.origin : (0, 0, 0));
}

/*
	Name: function_f9936b53
	Namespace: csceneobject
	Checksum: 0x529D96B6
	Offset: 0x7958
	Size: 0x3E
	Parameters: 0
	Flags: Linked
*/
function function_f9936b53()
{
	return (isdefined(self._o_scene._e_root.angles) ? self._o_scene._e_root.angles : (0, 0, 0));
}

/*
	Name: spawn_ent
	Namespace: csceneobject
	Checksum: 0xF241674A
	Offset: 0x79A0
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function spawn_ent()
{
	flagsys::set(#"spawning");
	b_disable_throttle = isdefined(self._o_scene._s.dontthrottle) && self._o_scene._s.dontthrottle;
	if(!b_disable_throttle)
	{
		spawner::global_spawn_throttle();
	}
	if(isspawner(self._e) && (function_19ddfa5() || is_vehicle()))
	{
		/#
			if(self._o_scene._b_testing)
			{
				self._e.count++;
			}
		#/
		if(!error(self._e.count < 1, "Trying to spawn AI for scene with spawner count < 1"))
		{
			self._e = self._e spawner::spawn(1);
		}
	}
	else
	{
		[[ self ]]->_spawn_ent();
	}
	if(!isdefined(self._e))
	{
		if(isdefined(self._s.model) && isdefined(self._o_scene._e_root))
		{
			if(is_player_model())
			{
				self._e = util::spawn_anim_player_model(self._s.model, function_d2039b28(), function_f9936b53());
			}
			else
			{
				self._e = util::spawn_anim_model(self._s.model, function_d2039b28(), function_f9936b53());
			}
		}
	}
	function_a04fb5f4();
	flagsys::clear(#"spawning");
}

/*
	Name: _spawn_ent
	Namespace: csceneobject
	Checksum: 0x80F724D1
	Offset: 0x7C20
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function _spawn_ent()
{
}

/*
	Name: kill_ent
	Namespace: csceneobject
	Checksum: 0x4EE4FE56
	Offset: 0x7C30
	Size: 0x14A
	Parameters: 0
	Flags: Linked
*/
function kill_ent()
{
	if(isarray(level.heroes) && isinarray(level.heroes, self._e))
	{
		arrayremovevalue(level.heroes, self._e, 1);
		self._e notify(#"unmake_hero");
	}
	self._e util::stop_magic_bullet_shield();
	self._e.var_7136e83 = 1;
	self._e.skipdeath = 1;
	self._e.allowdeath = 1;
	self._e.skipscenedeath = 1;
	self._e._scene_object = undefined;
	if(isplayer(self._e))
	{
		self._e disableinvulnerability();
	}
	self._e kill();
	self._e.var_7136e83 = undefined;
}

/*
	Name: play_regroup_fx_for_scene
	Namespace: csceneobject
	Checksum: 0x49394B61
	Offset: 0x7D88
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function play_regroup_fx_for_scene(e_player)
{
	align = get_align_ent();
	v_origin = align.origin;
	v_angles = align.angles;
	tag = get_align_tag();
	if(isdefined(tag))
	{
		v_origin = align gettagorigin(tag);
		v_angles = align gettagangles(tag);
	}
	v_start = getstartorigin(v_origin, v_angles, self._s.mainanim);
	n_dist_sq = distancesquared(e_player.origin, v_start);
	if(n_dist_sq > 250000 || isdefined(e_player.hijacked_vehicle_entity) && (!(isdefined(e_player.force_short_scene_transition_effect) && e_player.force_short_scene_transition_effect)))
	{
		self thread regroup_invulnerability(e_player);
		e_player clientfield::increment_to_player("postfx_igc", 1);
	}
	else
	{
		e_player clientfield::increment_to_player("postfx_igc", 3);
	}
	util::wait_network_frame();
}

/*
	Name: regroup_invulnerability
	Namespace: csceneobject
	Checksum: 0xFB8A9920
	Offset: 0x7F50
	Size: 0xAE
	Parameters: 1
	Flags: Linked
*/
function regroup_invulnerability(e_player)
{
	e_player endon(#"disconnect");
	e_player val::set(#"regroup", "ignoreme", 1);
	e_player.b_teleport_invulnerability = 1;
	e_player util::streamer_wait(undefined, 0, 7);
	e_player val::reset(#"regroup", "ignoreme");
	e_player.b_teleport_invulnerability = undefined;
}

/*
	Name: get_lerp_time
	Namespace: csceneobject
	Checksum: 0x4371A9BF
	Offset: 0x8008
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function get_lerp_time()
{
	return (isdefined(self._s.lerptime) ? self._s.lerptime : 0);
}

/*
	Name: get_camera_tween
	Namespace: csceneobject
	Checksum: 0xD782878B
	Offset: 0x8040
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function get_camera_tween()
{
	n_camera_tween = (isdefined(self.var_55b4f21e.cameratween) ? self.var_55b4f21e.cameratween : self._s.cameratween);
	return (isdefined(n_camera_tween) ? n_camera_tween : 0);
}

/*
	Name: get_camera_tween_out
	Namespace: csceneobject
	Checksum: 0x71A91717
	Offset: 0x80A0
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function get_camera_tween_out()
{
	n_camera_tween_out = (isdefined(self.var_55b4f21e.cameratween) ? self.var_55b4f21e.cameratween : self._s.cameratweenout);
	return (isdefined(n_camera_tween_out) ? n_camera_tween_out : 0);
}

/*
	Name: function_5c2a9efa
	Namespace: csceneobject
	Checksum: 0x8DDE89F8
	Offset: 0x8100
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_5c2a9efa()
{
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.var_1505fed6))
	{
		a_str_keys = getarraykeys(self._o_scene._e_root.var_1505fed6);
		if(isdefined(self._s.name) && isinarray(a_str_keys, hash(self._s.name)))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_48382a1c
	Namespace: csceneobject
	Checksum: 0x57A72E52
	Offset: 0x81C0
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function function_48382a1c()
{
	return isdefined(self._s.var_50f52c5b) && self._s.var_50f52c5b;
}

/*
	Name: function_3e22944e
	Namespace: csceneobject
	Checksum: 0x253C7342
	Offset: 0x81F0
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_3e22944e()
{
	return self._o_scene._e_root.var_1505fed6[self._s.name];
}

/*
	Name: is_alive
	Namespace: csceneobject
	Checksum: 0xF856DDCE
	Offset: 0x8228
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function is_alive()
{
	return isdefined(self._e) && (!isai(self._e) || isalive(self._e)) && (!(isdefined(self._e.isdying) && self._e.isdying));
}

/*
	Name: function_3919a776
	Namespace: csceneobject
	Checksum: 0xD69AD800
	Offset: 0x82B0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_3919a776()
{
	if(self._o_scene._str_mode === "init" && (isdefined(self._s.var_686939) && self._s.var_686939 || (isdefined(self._s.var_f9a5853f) && self._s.var_f9a5853f)))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_player
	Namespace: csceneobject
	Checksum: 0x7D93773B
	Offset: 0x8338
	Size: 0x5A
	Parameters: 0
	Flags: Linked
*/
function is_player()
{
	return self._s.type === "player" || self._s.type === "sharedplayer" || self._s.type === "playeroutfit";
}

/*
	Name: is_player_model
	Namespace: csceneobject
	Checksum: 0x933B64B7
	Offset: 0x83A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_player_model()
{
	return self._s.type === "fakeplayer";
}

/*
	Name: function_209522a0
	Namespace: csceneobject
	Checksum: 0xA278A76F
	Offset: 0x83C8
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_209522a0()
{
	return self._s.type === "playeroutfit";
}

/*
	Name: is_shared_player
	Namespace: csceneobject
	Checksum: 0x1B7CB7E5
	Offset: 0x83F0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_shared_player()
{
	return self._s.type === "sharedplayer";
}

/*
	Name: function_527113ae
	Namespace: csceneobject
	Checksum: 0x34580015
	Offset: 0x8418
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_527113ae()
{
	return is_player() && !is_shared_player();
}

/*
	Name: function_71b7c9e3
	Namespace: csceneobject
	Checksum: 0xED35F32C
	Offset: 0x8450
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_71b7c9e3(player)
{
	foreach(obj in self._o_scene._a_objects)
	{
		if(obj._e === player && [[ obj ]]->function_527113ae())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_19ddfa5
	Namespace: csceneobject
	Checksum: 0x5A146ED5
	Offset: 0x8500
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_19ddfa5()
{
	return self._s.type === "actor" && (!(isdefined(self._s.var_615b1f16) && self._s.var_615b1f16));
}

/*
	Name: is_vehicle
	Namespace: csceneobject
	Checksum: 0x948064AE
	Offset: 0x8550
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function is_vehicle()
{
	return self._s.type === "vehicle";
}

/*
	Name: in_this_scene
	Namespace: csceneobject
	Checksum: 0x2851D456
	Offset: 0x8578
	Size: 0x118
	Parameters: 1
	Flags: Linked
*/
function in_this_scene(ent)
{
	foreach(obj in self._o_scene._a_objects)
	{
		if(isplayer(ent))
		{
			if(is_shared_player())
			{
				return 0;
			}
			if(function_527113ae() && !function_71b7c9e3(ent))
			{
				return 0;
			}
			if(obj._e === ent)
			{
				return 1;
			}
			continue;
		}
		if(obj._e === ent)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: in_a_different_scene
	Namespace: csceneobject
	Checksum: 0xF488C428
	Offset: 0x8698
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function in_a_different_scene()
{
	return isdefined(self._e) && isdefined(self._e.current_scene) && self._e.current_scene != self._o_scene._str_name;
}

/*
	Name: _should_skip_anim
	Namespace: csceneobject
	Checksum: 0x44479FAC
	Offset: 0x86F0
	Size: 0x10A
	Parameters: 1
	Flags: Linked
*/
function _should_skip_anim(animation)
{
	if(isdefined(self._s.deletewhenfinished) && self._s.deletewhenfinished && is_skipping_scene() && !is_player() && (!(isdefined(self._s.keepwhileskipping) && self._s.keepwhileskipping)))
	{
		if(!animhasimportantnotifies(animation))
		{
			if(!isspawner(self._e))
			{
				e = scene::get_existing_ent(self._str_name, undefined, undefined, self._o_scene._str_name);
				if(isdefined(e))
				{
					return 0;
				}
			}
			return 1;
		}
	}
	return 0;
}

/*
	Name: skip_anim_on_client
	Namespace: csceneobject
	Checksum: 0xD7A94502
	Offset: 0x8808
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function skip_anim_on_client(entity, anim_name)
{
	if(!isdefined(anim_name))
	{
		return;
	}
	if(!isdefined(entity))
	{
		return;
	}
	if(!entity isplayinganimscripted())
	{
		return;
	}
	if(isanimlooping(anim_name))
	{
		return;
	}
	entity clientfield::increment("player_scene_animation_skip");
}

/*
	Name: skip_anim_on_server
	Namespace: csceneobject
	Checksum: 0xBE132DAA
	Offset: 0x8888
	Size: 0xBC
	Parameters: 2
	Flags: Linked
*/
function skip_anim_on_server(entity, anim_name)
{
	if(!isdefined(anim_name))
	{
		return;
	}
	if(!isdefined(entity))
	{
		return;
	}
	if(!entity isplayinganimscripted() || self._str_current_anim !== anim_name)
	{
		return;
	}
	if(isanimlooping(anim_name))
	{
		entity animation::stop();
	}
	else
	{
		entity setanimtimebyname(anim_name, 1);
	}
	entity stopsounds();
}

/*
	Name: skip_animation_on_client
	Namespace: csceneobject
	Checksum: 0x31C93F1E
	Offset: 0x8950
	Size: 0x1FC
	Parameters: 0
	Flags: Linked
*/
function skip_animation_on_client()
{
	if(isdefined(self.current_playing_anim[self._n_ent_num]))
	{
		if(is_shared_player())
		{
			foreach(player in [[self._func_get]](self._str_team))
			{
				/#
					if(getdvarint(#"debug_scene_skip", 0) > 0)
					{
						printtoprightln("" + self.current_playing_anim[player getentitynumber()] + "" + gettime(), vectorscale((1, 1, 1), 0.8));
					}
				#/
				skip_anim_on_client(player, self.current_playing_anim[player getentitynumber()]);
			}
		}
		else
		{
			/#
				if(getdvarint(#"debug_scene_skip", 0) > 0)
				{
					printtoprightln("" + self.current_playing_anim[self._n_ent_num] + "" + gettime(), vectorscale((1, 1, 1), 0.8));
				}
			#/
			skip_anim_on_client(self._e, self.current_playing_anim[self._n_ent_num]);
		}
		return 1;
	}
	return 0;
}

/*
	Name: skip_animation_on_server
	Namespace: csceneobject
	Checksum: 0x2AAB459
	Offset: 0x8B58
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function skip_animation_on_server()
{
	if(isdefined(self.current_playing_anim[self._n_ent_num]))
	{
		if(is_shared_player())
		{
			foreach(player in [[self._func_get]](self._str_team))
			{
				/#
					if(getdvarint(#"debug_scene_skip", 0) > 0)
					{
						printtoprightln("" + self.current_playing_anim[player getentitynumber()] + "" + gettime(), vectorscale((1, 1, 1), 0.8));
					}
				#/
				skip_anim_on_server(player, self.current_playing_anim[player getentitynumber()]);
			}
		}
		else
		{
			/#
				if(getdvarint(#"debug_scene_skip", 0) > 0)
				{
					printtoprightln("" + self.current_playing_anim[self._n_ent_num] + "" + gettime(), vectorscale((1, 1, 1), 0.8));
				}
			#/
			skip_anim_on_server(self._e, self.current_playing_anim[self._n_ent_num]);
		}
	}
}

/*
	Name: skip_scene_shot_animations
	Namespace: csceneobject
	Checksum: 0x8ABA385A
	Offset: 0x8D58
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function skip_scene_shot_animations()
{
	if(isdefined(self.current_playing_anim) && isdefined(self.current_playing_anim[self._n_ent_num]))
	{
		if(skip_animation_on_client())
		{
			waitframe(1);
		}
		skip_animation_on_server();
	}
	self notify(#"skip_camera_anims");
}

/*
	Name: skip_scene
	Namespace: csceneobject
	Checksum: 0x92B6A6B9
	Offset: 0x8DC8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function skip_scene(b_wait_one_frame)
{
	if(isdefined(b_wait_one_frame))
	{
		waitframe(1);
	}
	skip_scene_shot_animations();
}

/*
	Name: is_skipping_scene
	Namespace: csceneobject
	Checksum: 0x7295DD9A
	Offset: 0x8E00
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function is_skipping_scene()
{
	return isdefined([[ self._o_scene ]]->is_skipping_scene()) && [[ self._o_scene ]]->is_skipping_scene();
}

/*
	Name: log
	Namespace: csceneobject
	Checksum: 0x56FE1CB3
	Offset: 0x8E38
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function log(str_msg)
{
	/#
		println(self._o_scene._s.type + "" + function_9e72a96(self._o_scene._str_name) + "" + (isdefined(self._s.name) ? "" + self._s.name : (isdefined("") ? "" + "" : "")) + "" + str_msg);
	#/
}

/*
	Name: error
	Namespace: csceneobject
	Checksum: 0xA1207E7E
	Offset: 0x8F18
	Size: 0x178
	Parameters: 2
	Flags: Linked
*/
function error(condition, str_msg)
{
	if(condition)
	{
		loc_00008F98:
		str_msg = "[ " + self._o_scene._str_name + " ][ " + (isdefined(self._str_shot) ? "" + self._str_shot : (isdefined("unknown shot") ? "" + "unknown shot" : "")) + " ] " + (isdefined(self._s.name) ? "" + self._s.name : (isdefined("no name") ? "" + "no name" : "")) + ": " + str_msg;
		if(isdefined(self._o_scene._b_testing) && self._o_scene._b_testing)
		{
			/#
				scene::error_on_screen(str_msg);
			#/
		}
		assertmsg(str_msg);
		thread [[ self._o_scene ]]->on_error();
		return 1;
	}
	return 0;
}

/*
	Name: warning
	Namespace: csceneobject
	Checksum: 0x41CE3F8E
	Offset: 0x9098
	Size: 0xC4
	Parameters: 2
	Flags: Linked
*/
function warning(condition, str_msg)
{
	if(condition)
	{
		str_msg = "[ " + self._o_scene._str_name + " ] " + (isdefined(self._s.name) ? "" + self._s.name : (isdefined("no name") ? "" + "no name" : "")) + ": " + str_msg;
		/#
			scene::warning_on_screen(str_msg);
		#/
		return 1;
	}
	return 0;
}

#namespace scene;

/*
	Name: csceneobject
	Namespace: scene
	Checksum: 0xC60E44C5
	Offset: 0x9168
	Size: 0x13A6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function csceneobject()
{
	classes.csceneobject[0] = spawnstruct();
	classes.csceneobject[0].__vtable[2140141178] = &csceneobject::warning;
	classes.csceneobject[0].__vtable[365768300] = &csceneobject::error;
	classes.csceneobject[0].__vtable[766440049] = &csceneobject::log;
	classes.csceneobject[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.csceneobject[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.csceneobject[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.csceneobject[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.csceneobject[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.csceneobject[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.csceneobject[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.csceneobject[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.csceneobject[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.csceneobject[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.csceneobject[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.csceneobject[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.csceneobject[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.csceneobject[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.csceneobject[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.csceneobject[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.csceneobject[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.csceneobject[0].__vtable[722055235] = &csceneobject::is_player;
	classes.csceneobject[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.csceneobject[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.csceneobject[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.csceneobject[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.csceneobject[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.csceneobject[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.csceneobject[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.csceneobject[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.csceneobject[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.csceneobject[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.csceneobject[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.csceneobject[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.csceneobject[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.csceneobject[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.csceneobject[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.csceneobject[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.csceneobject[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.csceneobject[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.csceneobject[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.csceneobject[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.csceneobject[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.csceneobject[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.csceneobject[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.csceneobject[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.csceneobject[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.csceneobject[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.csceneobject[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.csceneobject[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.csceneobject[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.csceneobject[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.csceneobject[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.csceneobject[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.csceneobject[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.csceneobject[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.csceneobject[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.csceneobject[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.csceneobject[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.csceneobject[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.csceneobject[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.csceneobject[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.csceneobject[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.csceneobject[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.csceneobject[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.csceneobject[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.csceneobject[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.csceneobject[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.csceneobject[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.csceneobject[0].__vtable[1959331961] = &csceneobject::stop;
	classes.csceneobject[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.csceneobject[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.csceneobject[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.csceneobject[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.csceneobject[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.csceneobject[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.csceneobject[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.csceneobject[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.csceneobject[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.csceneobject[0].__vtable[881215179] = &csceneobject::play;
	classes.csceneobject[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.csceneobject[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.csceneobject[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.csceneobject[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.csceneobject[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.csceneobject[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.csceneobject[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.csceneobject[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.csceneobject[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.csceneobject[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.csceneobject[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.csceneobject[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.csceneobject[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.csceneobject[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.csceneobject[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.csceneobject[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.csceneobject[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.csceneobject[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.csceneobject[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.csceneobject[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.csceneobject[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.csceneobject[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.csceneobject[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.csceneobject[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.csceneobject[0].__vtable[674154906] = &csceneobject::__constructor;
}

#namespace cscene;

/*
	Name: __constructor
	Namespace: cscene
	Checksum: 0x611860F3
	Offset: 0xA518
	Size: 0x66
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self._a_objects = [];
	self._b_testing = 0;
	self._n_object_id = 0;
	self._str_mode = "";
	self._a_streamer_hint = [];
	self._a_active_shots = [];
	self._a_request_times = [];
	self._b_stopped = 0;
}

/*
	Name: __destructor
	Namespace: cscene
	Checksum: 0x8FB0CDE7
	Offset: 0xA588
	Size: 0x24
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
	/#
		log("");
	#/
}

/*
	Name: function_4412dc65
	Namespace: cscene
	Checksum: 0xED512F22
	Offset: 0xA5B8
	Size: 0x5B4
	Parameters: 1
	Flags: Linked
*/
function function_4412dc65(str_shot)
{
	/#
		self notify(#"hash_763a7354c3aaff58");
		self endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_763a7354c3aaff58");
		if(self._b_testing)
		{
			var_82bbc872 = 0;
			var_9d90ef8b = scene::function_12479eba(self._str_name);
			a_shots = scene::get_all_shot_names(self._str_name, 1);
			foreach(str_shot_name in self._s.var_b5d05f70)
			{
				if(str_shot_name != str_shot)
				{
					var_82bbc872 = var_82bbc872 + ceil(scene::function_8582657c(self._s, str_shot_name) * 30);
					continue;
				}
				break;
			}
			self.n_frame_counter = var_82bbc872;
			while(true)
			{
				if(getdvarint(#"hash_67caa056eba27a53", 0) == 0 || !isdefined(self._a_objects))
				{
					waitframe(1);
					continue;
				}
				v_pos = (1350, 195, 0);
				var_204b44d3 = var_9d90ef8b * self.n_frame_counter / ceil(var_9d90ef8b * 30);
				var_962ef8af = "" + self.n_frame_counter + "" + ceil(var_9d90ef8b * 30) + "" + var_204b44d3 + "" + var_9d90ef8b + "";
				debug2dtext(v_pos, var_962ef8af, undefined, undefined, undefined, 1, 0.8);
				v_pos = v_pos + vectorscale((0, 1, 0), 20) * 2;
				foreach(obj in self._a_objects)
				{
					if(!isdefined(obj._e) || !isdefined(obj._str_current_anim))
					{
						continue;
					}
					if(str_shot !== obj._str_shot)
					{
						continue;
					}
					animation = obj._str_current_anim;
					if(!isdefined(animation) || !isassetloaded("", animation))
					{
						continue;
					}
					var_13edeb1f = getanimframecount(animation);
					var_7b160393 = ceil(obj._e getanimtime(animation) * var_13edeb1f);
					var_958054e5 = getanimlength(animation);
					var_f667af2f = obj._e getanimtime(animation) * var_958054e5;
					var_2e63fccd = obj._str_name + "" + function_9e72a96(animation);
					var_1cae5962 = "" + str_shot + "" + var_7b160393 + "" + var_13edeb1f + "" + var_f667af2f + "" + var_958054e5 + "";
					debug2dtext(v_pos, var_2e63fccd, undefined, undefined, undefined, 1, 0.8);
					v_pos = v_pos + vectorscale((0, 1, 0), 20);
					debug2dtext(v_pos, var_1cae5962, undefined, undefined, undefined, 1, 0.8);
					v_pos = v_pos + vectorscale((0, 1, 0), 20) * 1.25;
					self.n_frame_counter = var_82bbc872 + var_7b160393;
				}
				waitframe(1);
			}
		}
	#/
}

/*
	Name: init
	Namespace: cscene
	Checksum: 0xBCF7B8AA
	Offset: 0xAB78
	Size: 0x576
	Parameters: 5
	Flags: Linked
*/
function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run)
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + str_scenedef);
		}
	#/
	s_scenedef scene::function_585fb738();
	s_scenedef.var_418c40ac = scene::function_c9770402(str_scenedef);
	self.var_355308d8 = s_scenedef.var_418c40ac;
	self.var_232738b3 = scene::function_c3a1b36a(str_scenedef);
	self.var_5a2219f0 = scene::get_all_shot_names(str_scenedef);
	self._s = s_scenedef;
	self._str_name = str_scenedef;
	self._b_testing = b_test_run;
	self._str_team = util::get_team_mapping(self._s.team);
	self._a_streamer_hint[#"allies"] = (isdefined(self._s.var_a6da2039) ? self._s.var_a6da2039 : self._s.streamerhintteama);
	self._a_streamer_hint[#"axis"] = (isdefined(self._s.var_991a84ba) ? self._s.var_991a84ba : self._s.streamerhintteamb);
	self._str_notify_name = isstring(self._s.malebundle) || (function_7a600918(self._s.malebundle) ? self._s.malebundle : self._str_name);
	if(!isdefined(a_ents))
	{
		a_ents = [];
	}
	else if(!isarray(a_ents))
	{
		a_ents = array(a_ents);
	}
	var_87439bc3 = scene::function_c8fb67e5(self._s);
	if(!error(a_ents.size > self._s.objects.size, "Trying to use more entities than scene supports."))
	{
		self._e_root = e_align;
		a_objs = get_valid_object_defs();
		foreach(s_obj in a_objs)
		{
			s_obj.type = function_85ed339(s_obj);
			if(isdefined(s_obj.name) && (self._e_root.classname === "scriptbundle_scene" || self._e_root.classname === "scriptbundle_fxanim") && isdefined(self._e_root.target))
			{
				if(!isdefined(self._e_root.var_1505fed6))
				{
					self._e_root.var_1505fed6 = [];
				}
				self._e_root.var_1505fed6[s_obj.name] = function_558aaa66(self._e_root, s_obj);
			}
			function_73fcc32b(s_obj, var_87439bc3);
			function_4f12fd77(s_obj);
			add_object([[ [[ self ]]->new_object(s_obj.type) ]]->first_init(s_obj, self));
		}
		/#
			if(!isdefined(level.last_scene_state))
			{
				level.last_scene_state = [];
			}
			if(!isdefined(self._e_root.last_scene_state_instance))
			{
				self._e_root.last_scene_state_instance = [];
			}
			if(!isdefined(level.last_scene_state[self._str_name]))
			{
				level.last_scene_state[self._str_name] = "";
			}
			if(!isdefined(self._e_root.last_scene_state_instance[self._str_name]))
			{
				self._e_root.last_scene_state_instance[self._str_name] = "";
			}
		#/
	}
}

/*
	Name: function_73fcc32b
	Namespace: cscene
	Checksum: 0x1504D521
	Offset: 0xB0F8
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function function_73fcc32b(obj, var_87439bc3)
{
	if(isarray(var_87439bc3) && var_87439bc3.size)
	{
		foreach(var_cdd7dee0 in var_87439bc3)
		{
			foreach(var_90acec35 in var_cdd7dee0.objects)
			{
				function_ff8b808(obj, var_90acec35);
			}
		}
	}
}

/*
	Name: function_ff8b808
	Namespace: cscene
	Checksum: 0x3CF5436B
	Offset: 0xB218
	Size: 0x34A
	Parameters: 2
	Flags: Linked
*/
function function_ff8b808(obj, var_90acec35)
{
	if(!isdefined(var_90acec35.var_93145ec8))
	{
		return;
	}
	var_4dc7222b = array("vehicle", "prop", "actor");
	if(!isinarray(var_4dc7222b, obj.type) && obj.type === var_90acec35.type || (isinarray(var_4dc7222b, obj.type) && obj.name === var_90acec35.name))
	{
		foreach(n_shot, var_f4348b83 in var_90acec35.shots)
		{
			var_d57bf586 = var_90acec35.var_93145ec8;
			if(!isdefined(obj.var_2df1a365))
			{
				obj.var_2df1a365 = [];
			}
			var_554345e4 = function_eb2133a3(var_f4348b83, obj.shots[n_shot]);
			if(var_90acec35.type == "sharedplayer" || var_90acec35.type == "player")
			{
				var_e6b1664b = function_f9ac3929(var_f4348b83, obj.shots[n_shot]);
			}
			if(isdefined(var_554345e4))
			{
				if(!isdefined(obj.var_2df1a365[n_shot]))
				{
					obj.var_2df1a365[n_shot] = [];
				}
				if(!isdefined(obj.var_2df1a365[n_shot][var_d57bf586]))
				{
					obj.var_2df1a365[n_shot][var_d57bf586] = spawnstruct();
				}
				obj.var_2df1a365[n_shot][var_d57bf586].var_554345e4 = var_554345e4;
			}
			if(isdefined(var_e6b1664b))
			{
				if(!isdefined(obj.var_2df1a365[n_shot]))
				{
					obj.var_2df1a365[n_shot] = [];
				}
				if(!isdefined(obj.var_2df1a365[n_shot][var_d57bf586]))
				{
					obj.var_2df1a365[n_shot][var_d57bf586] = spawnstruct();
				}
				obj.var_2df1a365[n_shot][var_d57bf586].var_e6b1664b = var_e6b1664b;
			}
		}
	}
}

/*
	Name: function_eb2133a3
	Namespace: cscene
	Checksum: 0xBCB8DDA8
	Offset: 0xB570
	Size: 0x19A
	Parameters: 2
	Flags: Linked
*/
function function_eb2133a3(var_f4348b83, s_shot)
{
	if(!isdefined(s_shot))
	{
		return undefined;
	}
	if(isarray(s_shot.entry))
	{
		foreach(s_entry in s_shot.entry)
		{
			if(isdefined(s_entry.("anim")))
			{
				var_3e5565ed = s_entry.("anim");
			}
		}
	}
	if(isarray(var_f4348b83.entry))
	{
		foreach(s_entry in var_f4348b83.entry)
		{
			if(isdefined(s_entry.("anim")))
			{
				var_554345e4 = s_entry.("anim");
			}
		}
	}
	if(isdefined(var_554345e4) && var_554345e4 !== var_3e5565ed)
	{
		return var_554345e4;
	}
	return undefined;
}

/*
	Name: function_f9ac3929
	Namespace: cscene
	Checksum: 0x219E51B8
	Offset: 0xB718
	Size: 0x18A
	Parameters: 2
	Flags: Linked
*/
function function_f9ac3929(var_f4348b83, s_shot)
{
	if(!isdefined(s_shot))
	{
		return undefined;
	}
	if(isarray(s_shot.entry))
	{
		foreach(s_entry in s_shot.entry)
		{
			if(isdefined(s_entry.cameraswitcher))
			{
				var_64a319f6 = s_entry.cameraswitcher;
			}
		}
	}
	if(isarray(var_f4348b83.entry))
	{
		foreach(s_entry in var_f4348b83.entry)
		{
			if(isdefined(s_entry.cameraswitcher))
			{
				var_e6b1664b = s_entry.cameraswitcher;
			}
		}
	}
	if(isdefined(var_e6b1664b) && var_e6b1664b !== var_64a319f6)
	{
		return var_e6b1664b;
	}
	return undefined;
}

/*
	Name: function_24f8cfb5
	Namespace: cscene
	Checksum: 0xED853958
	Offset: 0xB8B0
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_24f8cfb5(str_shot)
{
	return str_shot === self.var_232738b3;
}

/*
	Name: function_b260bdcc
	Namespace: cscene
	Checksum: 0x1930D641
	Offset: 0xB8D0
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function function_b260bdcc(str_shot)
{
	return str_shot === self.var_355308d8;
}

/*
	Name: function_4f12fd77
	Namespace: cscene
	Checksum: 0x194E2D6D
	Offset: 0xB8F0
	Size: 0x1A0
	Parameters: 1
	Flags: Linked
*/
function function_4f12fd77(s_obj)
{
	if(is_player(s_obj) || (isdefined(s_obj.var_50f52c5b) && s_obj.var_50f52c5b))
	{
		return;
	}
	if(isdefined(s_obj.shots))
	{
		foreach(s_shot in s_obj.shots)
		{
			if(s_shot.name === "init")
			{
				continue;
			}
			if(!isdefined(s_shot.entry) && !isdefined(s_shot.var_1c7fbd6b) && !isdefined(s_shot.var_64c0ee5a) && !isdefined(s_shot.var_6d848d4b) && !isdefined(s_shot.var_78089fee) && !isdefined(s_shot.var_71ce74a1) && !isdefined(s_shot.var_3ea5d95f) && !isdefined(s_shot.var_8645db22))
			{
				arrayremovevalue(s_obj.shots, s_shot, 1);
			}
		}
	}
}

/*
	Name: is_player
	Namespace: cscene
	Checksum: 0x56C59A4C
	Offset: 0xBA98
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function is_player(s_obj)
{
	if(s_obj.type === "player" || s_obj.type === "sharedplayer")
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_85ed339
	Namespace: cscene
	Checksum: 0xDCD12FC4
	Offset: 0xBAE8
	Size: 0xCA
	Parameters: 1
	Flags: Linked
*/
function function_85ed339(s_obj)
{
	str_type = tolower(s_obj.type);
	switch(str_type)
	{
		case "specialist":
		{
			str_type = "companion";
			break;
		}
		case "hash_70382e82d185bbfd":
		{
			str_type = "sharedcompanion";
			break;
		}
		default:
		{
			break;
		}
	}
	if(isdefined(s_obj.var_615b1f16) && s_obj.var_615b1f16)
	{
		str_type = "fakeactor";
	}
	return str_type;
}

/*
	Name: function_558aaa66
	Namespace: cscene
	Checksum: 0x6F4CD3FC
	Offset: 0xBBC0
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_558aaa66(s_instance, s_obj)
{
	if(self._s.devstate === "placeholder" && isdefined(s_instance.target))
	{
		var_1bdb1cc6 = struct::get_array(s_instance.target, "targetname");
		foreach(struct in var_1bdb1cc6)
		{
			if(isdefined(struct.script_animname) && tolower(struct.script_animname) === tolower(s_obj.name))
			{
				s_obj.var_50f52c5b = 1;
				return struct;
			}
		}
	}
}

/*
	Name: set_request_time
	Namespace: cscene
	Checksum: 0x7AD9AA8C
	Offset: 0xBCF8
	Size: 0x1E
	Parameters: 1
	Flags: Linked
*/
function set_request_time(str_shot)
{
	self._a_request_times[str_shot] = gettime();
}

/*
	Name: get_request_time
	Namespace: cscene
	Checksum: 0x3AD533D1
	Offset: 0xBD20
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function get_request_time(str_shot)
{
	return self._a_request_times[str_shot];
}

/*
	Name: add_to_sync_list
	Namespace: cscene
	Checksum: 0xB752BB54
	Offset: 0xBD40
	Size: 0x186
	Parameters: 1
	Flags: Linked
*/
function add_to_sync_list(str_shot)
{
	if(!isdefined(level.scene_sync_list))
	{
		level.scene_sync_list = [];
	}
	remove_from_sync_list(str_shot);
	s_scene_request = spawnstruct();
	s_scene_request.o_scene = self;
	s_scene_request.str_shot = str_shot;
	if(!isdefined(level.scene_sync_list[get_request_time(str_shot)]))
	{
		level.scene_sync_list[get_request_time(str_shot)] = [];
	}
	else if(!isarray(level.scene_sync_list[get_request_time(str_shot)]))
	{
		level.scene_sync_list[get_request_time(str_shot)] = array(level.scene_sync_list[get_request_time(str_shot)]);
	}
	level.scene_sync_list[get_request_time(str_shot)][level.scene_sync_list[get_request_time(str_shot)].size] = s_scene_request;
	waittillframeend();
}

/*
	Name: remove_from_sync_list
	Namespace: cscene
	Checksum: 0x24A9B299
	Offset: 0xBED0
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function remove_from_sync_list(str_shot)
{
	n_request_time = get_request_time(str_shot);
	if(isdefined(level.scene_sync_list) && isdefined(level.scene_sync_list[n_request_time]))
	{
		for(i = level.scene_sync_list[n_request_time].size - 1; i >= 0; i--)
		{
			s_scene_request = level.scene_sync_list[n_request_time][i];
			if(s_scene_request.o_scene == self && s_scene_request.str_shot == str_shot)
			{
				arrayremoveindex(level.scene_sync_list[n_request_time], i);
			}
		}
		if(!level.scene_sync_list[n_request_time].size)
		{
			level.scene_sync_list[n_request_time] = undefined;
		}
	}
}

/*
	Name: new_object
	Namespace: cscene
	Checksum: 0x7DABB86A
	Offset: 0xC000
	Size: 0x20A
	Parameters: 1
	Flags: Linked
*/
function new_object(str_type)
{
	switch(str_type)
	{
		case "prop":
		{
			object = new cscenemodel();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "model":
		{
			object = new cscenemodel();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "vehicle":
		{
			object = new cscenevehicle();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "actor":
		{
			object = new csceneactor();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "fakeactor":
		{
			object = new cscenefakeactor();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "playeroutfit":
		{
			object = new var_6572d7cd();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "player":
		{
			object = new csceneplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "sharedplayer":
		{
			object = new cscenesharedplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "fakeplayer":
		{
			object = new cscenefakeplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "companion":
		{
			object = new cscenecompanion();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "sharedcompanion":
		{
			object = new cscenesharedcompanion();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		default:
		{
			error(0, "Unsupported object type '" + str_type + "'.");
		}
	}
}

/*
	Name: get_valid_object_defs
	Namespace: cscene
	Checksum: 0x73D66B7C
	Offset: 0xC218
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function get_valid_object_defs()
{
	a_obj_defs = [];
	foreach(s_obj in self._s.objects)
	{
		if(self._s.vmtype !== "client" && s_obj.vmtype !== "client")
		{
			if(isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim))
			{
				if(!(isdefined(s_obj.disabled) && s_obj.disabled) && scene::function_6f382548(s_obj, self._s.name))
				{
					if(!isdefined(a_obj_defs))
					{
						a_obj_defs = [];
					}
					else if(!isarray(a_obj_defs))
					{
						a_obj_defs = array(a_obj_defs);
					}
					a_obj_defs[a_obj_defs.size] = s_obj;
				}
			}
		}
	}
	return a_obj_defs;
}

/*
	Name: get_object_id
	Namespace: cscene
	Checksum: 0x4A3B5722
	Offset: 0xC3C0
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function get_object_id()
{
	self._n_object_id++;
	return self._n_object_id;
}

/*
	Name: sync_with_client_scene
	Namespace: cscene
	Checksum: 0x36297BB9
	Offset: 0xC3E0
	Size: 0x1A4
	Parameters: 2
	Flags: Linked
*/
function sync_with_client_scene(str_shot, b_test_run = 0)
{
	if(self._s.vmtype === "both" && !self._s scene::is_igc())
	{
		self endon(str_shot + "finished");
		flagsys::wait_till(str_shot + "go");
		n_val = undefined;
		if(b_test_run)
		{
			switch(str_shot)
			{
				case "stop":
				{
					n_val = 3;
					break;
				}
				case "init":
				{
					n_val = 4;
					break;
				}
				default:
				{
					n_val = 5;
					break;
				}
			}
		}
		else
		{
			switch(str_shot)
			{
				case "stop":
				{
					n_val = 0;
					break;
				}
				case "init":
				{
					n_val = 1;
					break;
				}
				default:
				{
					n_val = 2;
					break;
				}
			}
		}
		level clientfield::set(self._s.name, n_val);
	}
}

/*
	Name: assign_ents
	Namespace: cscene
	Checksum: 0x47DA61E6
	Offset: 0xC590
	Size: 0x468
	Parameters: 1
	Flags: Linked
*/
function assign_ents(a_ents)
{
	if(!isdefined(a_ents))
	{
		a_ents = [];
	}
	else if(!isarray(a_ents))
	{
		a_ents = array(a_ents);
	}
	a_objects = arraycopy(self._a_objects);
	if(_assign_ents_by_name(a_objects, a_ents))
	{
		if(_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "teama"))
		{
			if(_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, "teamb"))
			{
				if(_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player, #"team3"))
				{
					if(_assign_ents_by_type(a_objects, a_ents, array("player", "sharedplayer"), &_is_ent_player))
					{
						if(_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teama"))
						{
							if(_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, "teamb"))
							{
								if(_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion, #"team3"))
								{
									if(_assign_ents_by_type(a_objects, a_ents, array("companion", "sharedcompanion"), &_is_ent_companion))
									{
										if(_assign_ents_by_type(a_objects, a_ents, "actor", &_is_ent_actor))
										{
											if(_assign_ents_by_type(a_objects, a_ents, "fakeactor", &_is_ent_actor))
											{
												if(_assign_ents_by_type(a_objects, a_ents, "vehicle", &_is_ent_vehicle))
												{
													if(_assign_ents_by_type(a_objects, a_ents, "model"))
													{
														foreach(e_ent in a_ents)
														{
															o_obj = array::pop(a_objects);
															if(!error(!isdefined(o_obj), "No scene object to assign entity too.  You might have passed in more than the scene supports."))
															{
																assign_ent(o_obj, e_ent);
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: assign_ent
	Namespace: cscene
	Checksum: 0xECE41692
	Offset: 0xCA00
	Size: 0x82
	Parameters: 2
	Flags: Linked
*/
function assign_ent(o_obj, ent)
{
	o_obj._e = ent;
	if(isdefined(self._e_root))
	{
		if(!isdefined(self._e_root.scene_ents))
		{
			self._e_root.scene_ents = [];
		}
		self._e_root.scene_ents[o_obj._str_name] = o_obj._e;
	}
}

/*
	Name: _assign_ents_by_name
	Namespace: cscene
	Checksum: 0x39B81E86
	Offset: 0xCA90
	Size: 0x3D6
	Parameters: 2
	Flags: Linked
*/
function _assign_ents_by_name(a_objects, a_ents)
{
	if(a_ents.size)
	{
		foreach(str_name, e_ent in arraycopy(a_ents))
		{
			foreach(i, o_obj in arraycopy(a_objects))
			{
				if(isdefined(o_obj._s.name))
				{
					if(isint(str_name) && (isdefined(o_obj._s._s.name) ? "" + o_obj._s.name : "") == (isdefined(str_name) ? "" + str_name : "") || (!isint(str_name) && hash(o_obj._s.name) == str_name) || e_ent.script_animname === (isdefined(o_obj._s._s.name) ? "" + o_obj._s.name : "") || e_ent.animname === (isdefined(o_obj._s._s.name) ? "" + o_obj._s.name : "") || e_ent.targetname === (isdefined(o_obj._s._s.name) ? "" + o_obj._s.name : ""))
					{
						assign_ent(o_obj, e_ent);
						arrayremovevalue(a_ents, e_ent, 1);
						arrayremoveindex(a_objects, i);
						break;
					}
				}
			}
		}
		/#
			foreach(i, ent in a_ents)
			{
				error(isstring(i) || function_7a600918(i), "" + i + "");
			}
		#/
	}
	return a_ents.size;
}

/*
	Name: _assign_ents_by_type
	Namespace: cscene
	Checksum: 0xA0427D37
	Offset: 0xCE70
	Size: 0x16E
	Parameters: 5
	Flags: Linked
*/
function _assign_ents_by_type(a_objects, a_ents, str_type, func_test, str_team)
{
	if(a_ents.size)
	{
		a_objects_of_type = get_objects(str_type, str_team);
		if(a_objects_of_type.size)
		{
			foreach(ent in arraycopy(a_ents))
			{
				if(isdefined(func_test) && [[func_test]](ent, str_team))
				{
					obj = array::pop_front(a_objects_of_type);
					if(isdefined(obj))
					{
						assign_ent(obj, ent);
						arrayremovevalue(a_ents, ent, 1);
						arrayremovevalue(a_objects, obj);
						continue;
					}
					break;
				}
			}
		}
	}
	return a_ents.size;
}

/*
	Name: _is_ent_player
	Namespace: cscene
	Checksum: 0xA45EB2B6
	Offset: 0xCFE8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function _is_ent_player(ent, str_team)
{
	return isplayer(ent) && scene::check_team(ent.team, str_team);
}

/*
	Name: _is_ent_companion
	Namespace: cscene
	Checksum: 0x4738DCDC
	Offset: 0xD040
	Size: 0x78
	Parameters: 2
	Flags: Linked
*/
function _is_ent_companion(ent, str_team)
{
	if(isarray(level.heroes) && isinarray(level.heroes, ent) && scene::check_team(ent.team, str_team))
	{
		return 1;
	}
	return 0;
}

/*
	Name: _is_ent_actor
	Namespace: cscene
	Checksum: 0x741BB90
	Offset: 0xD0C0
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function _is_ent_actor(ent, str_team)
{
	return isactor(ent) || isactorspawner(ent);
}

/*
	Name: _is_ent_vehicle
	Namespace: cscene
	Checksum: 0xF663A15B
	Offset: 0xD110
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function _is_ent_vehicle(ent, str_team)
{
	return isvehicle(ent) || isvehiclespawner(ent);
}

/*
	Name: get_objects
	Namespace: cscene
	Checksum: 0x43CD70EC
	Offset: 0xD160
	Size: 0x1D8
	Parameters: 2
	Flags: Linked
*/
function get_objects(type, str_team)
{
	a_ret = [];
	foreach(obj in self._a_objects)
	{
		if(isarray(type))
		{
			if(isinarray(type, obj._s.type))
			{
				if(scene::check_team(obj._s.team, str_team))
				{
					if(!isdefined(a_ret))
					{
						a_ret = [];
					}
					else if(!isarray(a_ret))
					{
						a_ret = array(a_ret);
					}
					a_ret[a_ret.size] = obj;
				}
			}
			continue;
		}
		if(obj._s.type == type)
		{
			if(scene::check_team(obj._s.team, str_team))
			{
				if(!isdefined(a_ret))
				{
					a_ret = [];
				}
				else if(!isarray(a_ret))
				{
					a_ret = array(a_ret);
				}
				a_ret[a_ret.size] = obj;
			}
		}
	}
	return a_ret;
}

/*
	Name: get_anim_relative_start_time
	Namespace: cscene
	Checksum: 0xF8A2E612
	Offset: 0xD340
	Size: 0x136
	Parameters: 3
	Flags: Linked
*/
function get_anim_relative_start_time(animation, n_start_time, b_camera_anim = 0)
{
	if(!isdefined(self.var_a0c66830))
	{
		return n_start_time;
	}
	if(b_camera_anim)
	{
		n_anim_length = float(getcamanimtime(animation)) / 1000;
		var_e2483c7 = iscamanimlooping(animation);
	}
	else
	{
		n_anim_length = getanimlength(animation);
		var_e2483c7 = isanimlooping(animation);
	}
	var_68219fcf = self.var_a0c66830 / n_anim_length * n_start_time;
	if(var_e2483c7)
	{
		if(var_68219fcf > 0.95)
		{
			var_68219fcf = 0.95;
		}
	}
	else if(var_68219fcf > 0.99)
	{
		var_68219fcf = 0.99;
	}
	return var_68219fcf;
}

/*
	Name: play
	Namespace: cscene
	Checksum: 0x924FEB9
	Offset: 0xD480
	Size: 0x1756
	Parameters: 4
	Flags: Linked
*/
function play(str_shot = "play", a_ents, b_testing = 0, str_mode = "")
{
	function_2ddeb362("cScene::play : " + self._s.name);
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + self._s.name);
		}
	#/
	if(str_mode == "single_loop")
	{
		self notify(#"hash_27297a73bc597607");
	}
	self notify(str_shot + "start");
	self endon(str_shot + "start", #"hash_27297a73bc597607");
	if(self._s scene::is_igc())
	{
		function_f4b4e39f(1);
	}
	if(isdefined(self._e_root) && isdefined(self._e_root.script_teleport_location))
	{
		self._e_root teleport::function_ff8a7a3();
	}
	if(str_mode == "skip_scene")
	{
		thread skip_scene(1, str_shot);
	}
	else if(str_mode == "skip_scene_player")
	{
		self.b_player_scene = 1;
		thread skip_scene(1, str_shot);
	}
	self._b_testing = b_testing;
	self._str_mode = str_mode;
	if(function_b260bdcc(str_shot))
	{
		self notify(#"hash_63783193d9ac5bfc");
	}
	if(isdefined(self._s.spectateonjoin) && self._s.spectateonjoin)
	{
		level.scene_should_spectate_on_hot_join = 1;
	}
	assign_ents(a_ents);
	self thread sync_with_client_scene(str_shot, b_testing);
	if(issubstr(self._str_mode, "play_from_time"))
	{
		args = strtok(self._str_mode, ":");
		if(isdefined(args[1]))
		{
			var_79584e08 = float(args[1]);
			self.var_a0c66830 = scene::function_8582657c(self._s, str_shot);
		}
		self.var_fb968c80 = 1;
		self._str_mode = "";
		if(issubstr(args[0], "noai"))
		{
			self._str_mode = self._str_mode + "noai";
		}
		if(issubstr(args[0], "noplayers"))
		{
			self._str_mode = self._str_mode + "noplayers";
		}
	}
	if(!isdefined(level.active_scenes[self._str_name]))
	{
		level.active_scenes[self._str_name] = [];
	}
	else if(!isarray(level.active_scenes[self._str_name]))
	{
		level.active_scenes[self._str_name] = array(level.active_scenes[self._str_name]);
	}
	if(!isinarray(level.active_scenes[self._str_name], self._e_root))
	{
		level.active_scenes[self._str_name][level.active_scenes[self._str_name].size] = self._e_root;
	}
	level.active_scenes[self._str_name] = array::remove_undefined(level.active_scenes[self._str_name]);
	if(!isdefined(self._a_active_shots))
	{
		self._a_active_shots = [];
	}
	else if(!isarray(self._a_active_shots))
	{
		self._a_active_shots = array(self._a_active_shots);
	}
	if(!isinarray(self._a_active_shots, str_shot))
	{
		self._a_active_shots[self._a_active_shots.size] = str_shot;
	}
	if(isdefined(self._e_root))
	{
		if(!isdefined(self._e_root.scenes))
		{
			self._e_root.scenes = [];
		}
		else if(!isarray(self._e_root.scenes))
		{
			self._e_root.scenes = array(self._e_root.scenes);
		}
		if(!isinarray(self._e_root.scenes, self))
		{
			self._e_root.scenes[self._e_root.scenes.size] = self;
		}
	}
	flagsys::clear(str_shot + "ready");
	flagsys::clear(str_shot + "go");
	flagsys::clear(str_shot + "finished");
	set_request_time(str_shot);
	if(!(isdefined(self._s.dontsync) && self._s.dontsync) && !is_skipping_scene())
	{
		add_to_sync_list(str_shot);
	}
	foreach(o_obj in self._a_objects)
	{
		thread [[ o_obj ]]->play(str_shot, var_79584e08);
	}
	/#
		thread function_4412dc65(str_shot);
		level.last_scene_state[self._str_name] = str_shot;
		if(isdefined(self._e_root) && isdefined(self._e_root.last_scene_state_instance))
		{
			self._e_root.last_scene_state_instance[self._str_name] = str_shot;
			if(!isdefined(level.scene_roots))
			{
				level.scene_roots = [];
			}
			else if(!isarray(level.scene_roots))
			{
				level.scene_roots = array(level.scene_roots);
			}
			if(!isinarray(level.scene_roots, self._e_root))
			{
				level.scene_roots[level.scene_roots.size] = self._e_root;
			}
		}
	#/
	wait_till_shot_ready(str_shot);
	self thread function_ab0c6edb();
	remove_from_sync_list(str_shot);
	level flagsys::set(self._str_notify_name + "_ready");
	if(isdefined(self._e_root))
	{
		self._e_root flagsys::set(#"scene_ents_ready");
	}
	if(strstartswith(self._str_mode, "capture") || (self._s scene::is_igc() && scene::function_a4dedc63(1)))
	{
		/#
			depth = getdvarstring(#"hash_3018c0b9207d1c", "");
			fps = getdvarstring(#"hash_51617678bebb961a", "");
			var_6d1932c7 = getdvarstring(#"hash_4bf15ae7a6fbf73c", "");
			if(issubstr(self._str_mode, "") || getdvarint(#"hash_6a54249f0cc48945", 0) == 2 || scene::function_24f8cfb5(self._str_name, str_shot))
			{
				if(issubstr(self._str_mode, "") || getdvarint(#"hash_6a54249f0cc48945", 0) == 2)
				{
					var_3a6bcf6e = self._str_name + "" + str_shot;
				}
				else
				{
					var_3a6bcf6e = self._str_name;
				}
				level flagsys::set(#"hash_20a4053fe3e70f8");
				str_command = "" + depth + "" + fps + "" + var_6d1932c7 + "" + self._str_name + "" + var_3a6bcf6e;
				adddebugcommand("");
				adddebugcommand(str_command);
			}
		#/
	}
	if(var_79584e08 === 0)
	{
		self thread _play_camera_anims();
	}
	if(isdefined(self._s.var_e3b54868) && self._s.var_e3b54868 && function_b260bdcc(str_shot) && !scene::function_46546b5c(self._str_name))
	{
		if(!is_skipping_scene())
		{
			thread _call_shot_funcs(str_shot, 1);
			self.var_b0ff34ce = undefined;
		}
	}
	else
	{
		thread _call_shot_funcs(str_shot, 1);
	}
	if(self._s scene::is_igc())
	{
		if(isstring(self._s.cameraswitcher) || function_7a600918(self._s.cameraswitcher))
		{
			_wait_for_camera_animation(self._s.cameraswitcher, var_79584e08);
		}
	}
	wait_till_shot_finished(str_shot);
	self.var_fb968c80 = undefined;
	if(isdefined(self._s.spectateonjoin) && self._s.spectateonjoin)
	{
		level.scene_should_spectate_on_hot_join = undefined;
	}
	if(!(isdefined(self.var_b0ff34ce) && self.var_b0ff34ce) && (self._str_mode != "init" && (!(isdefined(self.var_2bc31f02) && self.var_2bc31f02) && function_b260bdcc(str_shot)) || (isdefined(self.var_2bc31f02) && self.var_2bc31f02 && flagsys::get(#"hash_42da41892ac54794"))))
	{
		if(!is_skipping_scene())
		{
			thread _call_shot_funcs("done");
		}
		self.var_b0ff34ce = 1;
		if(isdefined(self.var_753367d) && self.var_753367d)
		{
			self flagsys::set(#"scene_skip_completed");
		}
		if(isdefined(self._e_root))
		{
			self._e_root notify(#"scene_done", {#scenedef:self._str_notify_name});
			self._e_root scene::function_6f9a9e07();
		}
	}
	self notify(str_shot);
	if(issubstr(self._str_mode, "single"))
	{
		self notify(#"hash_3168dab591a18b9b");
	}
	if(str_shot != "init" && self._str_mode != "init" && !self._b_stopped)
	{
		if(is_looping() || self._str_mode === "loop" && (isdefined(self.var_b0ff34ce) && self.var_b0ff34ce) || self._str_mode === "single_loop")
		{
			self.var_b0ff34ce = undefined;
			if(has_init_state())
			{
				thread play("init", undefined, b_testing, str_mode);
			}
			else if(get_request_time(str_shot) < gettime())
			{
				if(self._str_mode === "single_loop")
				{
					var_689ecfec = str_shot;
				}
				else
				{
					var_689ecfec = scene::function_de6a7579(self._str_name, str_mode);
				}
				thread play(var_689ecfec, undefined, b_testing, str_mode);
			}
		}
		else if(!issubstr(self._str_mode, "single"))
		{
			thread run_next(str_shot);
		}
	}
	if(isdefined(self._s.spectateonjoin) && self._s.spectateonjoin)
	{
		level.scene_should_spectate_on_hot_join = undefined;
	}
	array::flagsys_wait_clear(self._a_objects, str_shot + "active");
	if(!is_skipping_scene() || (is_skipping_scene() && scene_skip_completed()))
	{
		arrayremovevalue(self._a_active_shots, str_shot);
	}
	if(!self._a_active_shots.size || (is_skipping_scene() && scene_skip_completed()))
	{
		if(isdefined(level.active_scenes[self._str_name]))
		{
			arrayremovevalue(level.active_scenes[self._str_name], self._e_root);
			arrayremovevalue(level.active_scenes[self._str_name], undefined);
			if(level.active_scenes[self._str_name].size == 0)
			{
				level.active_scenes[self._str_name] = undefined;
			}
			arrayremovevalue(level.active_scenes, undefined, 1);
		}
		if(!isdefined(level.inactive_scenes[self._str_name]))
		{
			level.inactive_scenes[self._str_name] = [];
		}
		else if(!isarray(level.inactive_scenes[self._str_name]))
		{
			level.inactive_scenes[self._str_name] = array(level.inactive_scenes[self._str_name]);
		}
		if(!isinarray(level.inactive_scenes[self._str_name], self._e_root))
		{
			level.inactive_scenes[self._str_name][level.inactive_scenes[self._str_name].size] = self._e_root;
		}
		arrayremovevalue(level.inactive_scenes[self._str_name], undefined);
		arrayremovevalue(level.inactive_scenes, undefined, 1);
		if(isdefined(self._e_root))
		{
			arrayremovevalue(self._e_root.scenes, self);
			if(self._e_root.scenes.size == 0)
			{
				self._e_root.scenes = undefined;
				/#
					arrayremovevalue(level.scene_roots, self._e_root);
				#/
			}
			if(isstruct(self._e_root) && !isdefined(self._e_root.scriptbundlename) && isarray(level.inactive_scenes[self._str_name]))
			{
				arrayremovevalue(level.inactive_scenes[self._str_name], self._e_root);
				if(level.inactive_scenes[self._str_name].size == 0)
				{
					level.inactive_scenes[self._str_name] = undefined;
				}
			}
		}
		/#
			level.scene_roots = array::remove_undefined(level.scene_roots);
		#/
		foreach(obj in self._a_objects)
		{
			obj notify(#"death");
		}
		self._a_objects = undefined;
		if(isdefined(self._s) && self._s scene::is_igc())
		{
			function_f4b4e39f(0);
		}
	}
	/#
		if(strstartswith(self._str_mode, "") || (self._s scene::is_igc() && scene::function_a4dedc63(1)))
		{
			conv = getdvarstring(#"hash_7b946c8966b56a8e", "");
			if(issubstr(self._str_mode, "") || function_b260bdcc(str_shot) || getdvarint(#"hash_6a54249f0cc48945", 0) == 2)
			{
				level flagsys::clear(#"hash_20a4053fe3e70f8");
				adddebugcommand("" + conv);
			}
		}
	#/
	self notify(#"remove_callbacks");
}

/*
	Name: function_ab0c6edb
	Namespace: cscene
	Checksum: 0x803E07C8
	Offset: 0xEBE0
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_ab0c6edb()
{
	self endon(#"death", #"scene_stop", #"scene_done", #"scene_skip_completed");
	waitframe(1);
	self notify(#"hash_60adeaccbb565546");
}

/*
	Name: function_3e22b6ac
	Namespace: cscene
	Checksum: 0xFDA9D9B
	Offset: 0xEC48
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_3e22b6ac()
{
	if(isdefined(self._a_objects))
	{
		foreach(obj in self._a_objects)
		{
			if(isdefined(obj._e) && isbot(obj._e))
			{
				obj._e botreleasemanualcontrol();
			}
		}
	}
}

/*
	Name: _wait_for_camera_animation
	Namespace: cscene
	Checksum: 0xDCEFE10E
	Offset: 0xED08
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function _wait_for_camera_animation(str_cam, n_start_time)
{
	self endon(#"skip_camera_anims");
	if(iscamanimlooping(str_cam))
	{
		level waittill(#"forever");
	}
	else
	{
		scene::wait_server_time(float(getcamanimtime(str_cam)) / 1000, n_start_time);
	}
}

/*
	Name: _play_camera_anims
	Namespace: cscene
	Checksum: 0xF914160F
	Offset: 0xEDB0
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function _play_camera_anims()
{
	level endon(#"stop_camera_anims");
	e_align = get_align_ent();
	if(!isdefined(e_align))
	{
		return;
	}
	v_origin = (isdefined(e_align.origin) ? e_align.origin : (0, 0, 0));
	v_angles = (isdefined(e_align.angles) ? e_align.angles : (0, 0, 0));
	if(isstring(self._s.cameraswitcher) || function_7a600918(self._s.cameraswitcher))
	{
		callback::on_loadout(&_play_camera_anim_on_player_callback, self);
		self.camera_v_origin = v_origin;
		self.camera_v_angles = v_angles;
		self.camera_start_time = gettime();
		array::thread_all_ents(level.players, &_play_camera_anim_on_player, v_origin, v_angles, 0);
	}
}

/*
	Name: _play_camera_anim_on_player_callback
	Namespace: cscene
	Checksum: 0x12B1F780
	Offset: 0xEF18
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function _play_camera_anim_on_player_callback(player)
{
	self thread _play_camera_anim_on_player(player, self.camera_v_origin, self.camera_v_angles, 1);
}

/*
	Name: _play_camera_anim_on_player
	Namespace: cscene
	Checksum: 0xA69BF137
	Offset: 0xEF60
	Size: 0x11C
	Parameters: 4
	Flags: Linked
*/
function _play_camera_anim_on_player(player, v_origin, v_angles, ignore_initial_notetracks)
{
	player notify(#"new_camera_switcher");
	player dontinterpolate();
	player thread scene::scene_disable_player_stuff(self._s);
	self.played_camera_anims = 1;
	n_start_time = self.camera_start_time;
	if(!isdefined(self._s.cameraswitchergraphiccontents) || ismature(player))
	{
		camanimscripted(player, self._s.cameraswitcher, n_start_time, v_origin, v_angles);
	}
	else
	{
		camanimscripted(player, self._s.cameraswitchergraphiccontents, n_start_time, v_origin, v_angles);
	}
}

/*
	Name: loop_camera_anim_to_set_up_for_capture
	Namespace: cscene
	Checksum: 0x7EA3522F
	Offset: 0xF088
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function loop_camera_anim_to_set_up_for_capture()
{
	level endon(#"stop_camera_anims");
	while(true)
	{
		_play_camera_anims();
		_wait_for_camera_animation(self._s.cameraswitcher);
	}
}

/*
	Name: _stop_camera_anims
	Namespace: cscene
	Checksum: 0x2F737350
	Offset: 0xF0E8
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function _stop_camera_anims()
{
	if(!(isdefined(self.played_camera_anims) && self.played_camera_anims))
	{
		return;
	}
	level notify(#"stop_camera_anims");
	foreach(player in getplayers())
	{
		self thread _stop_camera_anim_on_player(player);
	}
}

/*
	Name: _stop_camera_anim_on_player
	Namespace: cscene
	Checksum: 0xE810E667
	Offset: 0xF1A0
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function _stop_camera_anim_on_player(player)
{
	player endon(#"disconnect");
	if(isstring(self._s.cameraswitcher) || function_7a600918(self._s.cameraswitcher))
	{
		player endon(#"new_camera_switcher");
		player dontinterpolate();
		endcamanimscripted(player);
		player thread scene::scene_enable_player_stuff(self._s, undefined, self._e_root);
		callback::remove_on_loadout(&_play_camera_anim_on_player_callback, self);
	}
}

/*
	Name: is_skipping_scene
	Namespace: cscene
	Checksum: 0xBF4A5E16
	Offset: 0xF298
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function is_skipping_scene()
{
	return isdefined(self.skipping_scene) && self.skipping_scene || self._str_mode == "skip_scene" || self._str_mode == "skip_scene_player" && (!(isdefined(self._s.disablesceneskipping) && self._s.disablesceneskipping));
}

/*
	Name: is_skipping_player_scene
	Namespace: cscene
	Checksum: 0x672785B6
	Offset: 0xF318
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function is_skipping_player_scene()
{
	return isdefined(self.b_player_scene) && self.b_player_scene || self._str_mode == "skip_scene_player";
}

/*
	Name: scene_skip_completed
	Namespace: cscene
	Checksum: 0x86996438
	Offset: 0xF350
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function scene_skip_completed()
{
	return isdefined(self.scene_skip_completed) && self.scene_skip_completed;
}

/*
	Name: function_19015532
	Namespace: cscene
	Checksum: 0xF0F9781D
	Offset: 0xF370
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_19015532(str_current_shot = self._a_active_shots[0])
{
	if(isdefined(self.var_2e9fdf35))
	{
		return 1;
	}
	if(str_current_shot === "init")
	{
		return 0;
	}
	if(isdefined(self._s.nextscenebundle))
	{
		return 1;
	}
	foreach(i, str_shot in self.var_5a2219f0)
	{
		if(str_shot === str_current_shot && isdefined(self.var_5a2219f0[i + 1]) && self.var_5a2219f0[i + 1] !== "init")
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_c9f40212
	Namespace: cscene
	Checksum: 0x3503A512
	Offset: 0xF498
	Size: 0xDA
	Parameters: 1
	Flags: Linked
*/
function function_c9f40212(str_current_shot)
{
	if(isdefined(self.var_2e9fdf35))
	{
		var_1a15e649 = self.var_2e9fdf35;
		self.var_2e9fdf35 = undefined;
		return var_1a15e649;
	}
	foreach(i, str_shot in self.var_5a2219f0)
	{
		if(str_shot === str_current_shot && isdefined(self.var_5a2219f0[i + 1]))
		{
			return self.var_5a2219f0[i + 1];
		}
	}
}

/*
	Name: run_next
	Namespace: cscene
	Checksum: 0xCD83C25D
	Offset: 0xF580
	Size: 0x3F4
	Parameters: 1
	Flags: Linked
*/
function run_next(str_current_shot)
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + gettime());
		}
	#/
	b_run_next_scene = 0;
	if(function_19015532(str_current_shot))
	{
		if(!self._b_stopped)
		{
			var_8b188654 = is_skipping_scene();
			if(var_8b188654)
			{
				while(!flagsys::get(#"hash_5a8a0284760e5913") || var_43cf9254 > 5)
				{
					var_43cf9254 = var_43cf9254 + float(function_60d95f53()) / 1000;
					waitframe(1);
				}
				flagsys::clear(#"hash_5a8a0284760e5913");
			}
			if(self._s.scenetype == "fxanim" && self._s.nextscenemode === "init")
			{
				if(!error(!has_init_state(), "Scene can't init next scene '" + self._s.nextscenebundle + "' because it doesn't have an init state."))
				{
					self._e_root thread scene::init(self._s.nextscenebundle);
				}
			}
			else if(var_8b188654)
			{
				if(is_skipping_player_scene())
				{
					self._str_mode = "skip_scene_player";
				}
				else
				{
					self._str_mode = "skip_scene";
				}
			}
			else
			{
				b_run_next_scene = 1;
			}
			if(function_19015532(str_current_shot))
			{
				if(isdefined(self._s.nextscenebundle))
				{
					self._e_root thread scene::play(self._s.nextscenebundle, undefined, undefined, self._b_testing, self._str_mode);
				}
				else
				{
					var_1a15e649 = function_c9f40212(str_current_shot);
					/#
						if(getdvarint(#"debug_scene_skip", 0) > 0 && is_skipping_scene())
						{
							printtoprightln("" + str_current_shot + "" + gettime(), (1, 1, 0));
						}
					#/
					switch(self._s.scenetype)
					{
						case "scene":
						{
							thread [[ self ]]->play(var_1a15e649, undefined, self._b_testing, self._str_mode);
							break;
						}
						default:
						{
							thread [[ self ]]->play(var_1a15e649, undefined, self._b_testing, self._str_mode);
						}
					}
				}
			}
		}
	}
	else
	{
		_call_shot_funcs("sequence_done");
	}
}

/*
	Name: has_init_state
	Namespace: cscene
	Checksum: 0xB5FB9BE2
	Offset: 0xF980
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function has_init_state()
{
	return scene::has_init_state(self._str_name);
}

/*
	Name: stop
	Namespace: cscene
	Checksum: 0x56DD2DA3
	Offset: 0xF9A8
	Size: 0x28A
	Parameters: 2
	Flags: Linked
*/
function stop(b_clear = 0, b_finished = 0)
{
	if(self._b_stopped || is_skipping_scene())
	{
		return;
	}
	/#
	#/
	self thread sync_with_client_scene("stop", b_clear);
	thread _call_shot_funcs("stop");
	self.scene_stopping = 1;
	if(isdefined(self._a_objects) && !b_finished)
	{
		foreach(o_obj in self._a_objects)
		{
			if(isdefined(o_obj) && !([[ o_obj ]]->in_a_different_scene()))
			{
				thread [[ o_obj ]]->stop(b_clear);
			}
		}
	}
	self thread _stop_camera_anims();
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("" + self._s.name);
		}
		if(isdefined(self._e_root) && isdefined(self._e_root.last_scene_state_instance))
		{
			if(!b_finished)
			{
				level.last_scene_state[self._str_name] = level.last_scene_state[self._str_name] + "";
				self._e_root.last_scene_state_instance[self._str_name] = self._e_root.last_scene_state_instance[self._str_name] + "";
			}
			if(!isdefined(self._e_root.scriptbundlename))
			{
				self._e_root notify(#"stop_debug_display");
			}
		}
	#/
	self._b_stopped = 1;
}

/*
	Name: _call_shot_funcs
	Namespace: cscene
	Checksum: 0xD8B8BF6B
	Offset: 0xFC40
	Size: 0x3B0
	Parameters: 2
	Flags: Linked
*/
function _call_shot_funcs(str_shot, b_waittill_go = 0)
{
	self endon(str_shot);
	if(b_waittill_go)
	{
		flagsys::wait_till(str_shot + "go");
	}
	if(str_shot == "done")
	{
		level notify(self._str_notify_name + "_done");
		self notify(#"scene_done");
		function_3e22b6ac();
	}
	if(str_shot == "stop")
	{
		self notify(#"scene_stop");
		function_3e22b6ac();
	}
	level notify(self._str_notify_name + "_" + str_shot);
	if(str_shot == "sequence_done")
	{
		if(isdefined(level.scene_sequence_names[self._s.name]))
		{
			level notify(level.scene_sequence_names[self._s.name] + "_sequence_done");
		}
	}
	if(isdefined(level.scene_funcs) && isdefined(level.scene_funcs[self._str_notify_name]) && isdefined(level.scene_funcs[self._str_notify_name][str_shot]))
	{
		a_ents = get_ents();
		foreach(handler in level.scene_funcs[self._str_notify_name][str_shot])
		{
			if(self._str_mode === "init" && handler.size > 2)
			{
				continue;
			}
			func = handler[0];
			args = handler[1];
			util::function_50f54b6f(self._e_root, func, a_ents, args);
		}
	}
	if(isdefined(level.var_4247a0d6) && isdefined(level.var_4247a0d6[self._str_notify_name]) && isdefined(level.var_4247a0d6[self._str_notify_name][str_shot]))
	{
		foreach(handler in level.var_4247a0d6[self._str_notify_name][str_shot])
		{
			if(self._str_mode === "init" && handler.size > 2)
			{
				continue;
			}
			func = handler[0];
			args = handler[1];
			util::single_thread_argarray(self._e_root, func, args);
		}
	}
}

/*
	Name: get_ents
	Namespace: cscene
	Checksum: 0xE99D0C64
	Offset: 0xFFF8
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function get_ents()
{
	a_ents = [];
	if(isdefined(self._a_objects))
	{
		foreach(o_obj in self._a_objects)
		{
			if(isdefined(o_obj._s.name))
			{
				a_ents[o_obj._s.name] = o_obj._e;
				continue;
			}
			if(!isdefined(a_ents))
			{
				a_ents = [];
			}
			else if(!isarray(a_ents))
			{
				a_ents = array(a_ents);
			}
			a_ents[a_ents.size] = o_obj._e;
		}
	}
	return a_ents;
}

/*
	Name: get_root
	Namespace: cscene
	Checksum: 0xAC93F0F4
	Offset: 0x10120
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_root()
{
	return self._e_root;
}

/*
	Name: get_align_ent
	Namespace: cscene
	Checksum: 0x1248134F
	Offset: 0x10138
	Size: 0x162
	Parameters: 0
	Flags: Linked
*/
function get_align_ent()
{
	e_align = self._e_root;
	if(isdefined(self._s.aligntarget))
	{
		e_gdt_align = scene::get_existing_ent(self._s.aligntarget, 0, 1, self._str_name);
		if(isdefined(e_gdt_align))
		{
			e_align = e_gdt_align;
		}
		if(!isdefined(e_gdt_align))
		{
			str_msg = "Align target '" + (isdefined(self._s.aligntarget) ? "" + self._s.aligntarget : "") + "' doesn't exist for scene.";
			if(!warning(self._b_testing, str_msg))
			{
				error(getdvarint(#"scene_align_errors", 1), str_msg);
			}
		}
	}
	else if(isdefined(self._e_root) && isdefined(self._e_root.e_scene_link))
	{
		e_align = self._e_root.e_scene_link;
	}
	return e_align;
}

/*
	Name: is_looping
	Namespace: cscene
	Checksum: 0xCC753EEA
	Offset: 0x102A8
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function is_looping()
{
	return isdefined(self._s.looping) && self._s.looping;
}

/*
	Name: wait_till_shot_ready
	Namespace: cscene
	Checksum: 0xC15A2E1A
	Offset: 0x102D8
	Size: 0x164
	Parameters: 2
	Flags: Linked
*/
function wait_till_shot_ready(str_shot, o_exclude)
{
	a_objects = [];
	if(isdefined(o_exclude))
	{
		a_objects = array::exclude(self._a_objects, o_exclude);
	}
	else
	{
		a_objects = self._a_objects;
	}
	if(isdefined(self._s.igc) && self._s.igc)
	{
		level flagsys::increment("waitting_for_igc_ready");
	}
	wait_till_objects_ready(str_shot, a_objects);
	flagsys::set(str_shot + "ready");
	sync_with_other_scenes(str_shot);
	flagsys::set(str_shot + "go");
	function_9a5f92e7();
	if(isdefined(self._s.igc) && self._s.igc)
	{
		level flagsys::decrement("waitting_for_igc_ready");
	}
}

/*
	Name: function_9a5f92e7
	Namespace: cscene
	Checksum: 0x2C6464D7
	Offset: 0x10448
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_9a5f92e7()
{
	foreach(obj in self._a_objects)
	{
		if(isdefined(obj._e) && (isbot(obj._e) || isai(obj._e)))
		{
			if(isbot(obj._e))
			{
				obj._e namespace_87f62ea8::function_33834a13();
				obj._e bottakemanualcontrol();
				continue;
			}
			if(issentient(obj._e))
			{
				obj._e clearforcedgoal();
			}
		}
	}
}

/*
	Name: wait_till_objects_ready
	Namespace: cscene
	Checksum: 0x32143448
	Offset: 0x10598
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function wait_till_objects_ready(str_shot, array)
{
	for(i = 0; i < array.size; i++)
	{
		obj = array[i];
		if(isdefined(obj) && !obj flagsys::get(str_shot + "ready") && obj flagsys::get(str_shot + "active") && !obj flagsys::get(str_shot + "stopped"))
		{
			obj waittill(str_shot + "ready", str_shot + "active", str_shot + "stopped");
			i = -1;
		}
	}
}

/*
	Name: wait_till_shot_finished
	Namespace: cscene
	Checksum: 0xDA421C95
	Offset: 0x106B0
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function wait_till_shot_finished(str_shot)
{
	wait_till_objects_finished(str_shot, self._a_objects);
}

/*
	Name: wait_till_objects_finished
	Namespace: cscene
	Checksum: 0x1066B3FF
	Offset: 0x106E8
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function wait_till_objects_finished(str_shot, array)
{
	for(i = 0; i < array.size; i++)
	{
		obj = array[i];
		if(isdefined(obj) && !obj flagsys::get(str_shot + "finished") && obj flagsys::get(str_shot + "active") && !obj flagsys::get(str_shot + "stopped"))
		{
			obj waittill(str_shot + "finished", str_shot + "active", str_shot + "stopped");
			i = -1;
		}
	}
}

/*
	Name: sync_with_other_scenes
	Namespace: cscene
	Checksum: 0x57E919D5
	Offset: 0x10800
	Size: 0x1AE
	Parameters: 1
	Flags: Linked
*/
function sync_with_other_scenes(str_shot)
{
	if(!(isdefined(self._s.dontsync) && self._s.dontsync) && !is_skipping_scene())
	{
		n_request_time = get_request_time(str_shot);
		if(isdefined(level.scene_sync_list) && isarray(level.scene_sync_list[n_request_time]))
		{
			a_scene_requests = level.scene_sync_list[n_request_time];
			for(i = 0; i < a_scene_requests.size; i++)
			{
				a_scene_request = a_scene_requests[i];
				o_scene = a_scene_request.o_scene;
				str_flag = a_scene_request.str_shot + "ready";
				if(isdefined(a_scene_request) && (!(isdefined(o_scene._s.dontsync) && o_scene._s.dontsync)) && !o_scene flagsys::get(str_flag))
				{
					o_scene flagsys::wait_till(str_flag);
					i = -1;
				}
			}
		}
	}
}

/*
	Name: get_valid_objects
	Namespace: cscene
	Checksum: 0xC4586996
	Offset: 0x109B8
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function get_valid_objects()
{
	a_obj = [];
	foreach(obj in self._a_objects)
	{
		if([[ obj ]]->is_alive())
		{
			if(!isdefined(a_obj))
			{
				a_obj = [];
			}
			else if(!isarray(a_obj))
			{
				a_obj = array(a_obj);
			}
			a_obj[a_obj.size] = obj;
		}
	}
	return a_obj;
}

/*
	Name: on_error
	Namespace: cscene
	Checksum: 0x8A6DF063
	Offset: 0x10AA0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function on_error()
{
	stop();
}

/*
	Name: is_scene_shared
	Namespace: cscene
	Checksum: 0x6F080FE7
	Offset: 0x10AC0
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function is_scene_shared()
{
	if(self._s scene::is_igc())
	{
		return 1;
	}
	return 0;
}

/*
	Name: skip_scene
	Namespace: cscene
	Checksum: 0x8FC52138
	Offset: 0x10AF0
	Size: 0x7E8
	Parameters: 2
	Flags: Linked
*/
function skip_scene(var_11843b70, str_shot = self._a_active_shots[0])
{
	if(!(isdefined(var_11843b70) && var_11843b70) && (isdefined(self._s.disablesceneskipping) && self._s.disablesceneskipping))
	{
		/#
			if(getdvarint(#"debug_scene_skip", 0) > 0)
			{
				printtoprightln("" + self._s.name + "" + gettime(), (1, 0, 0));
			}
		#/
		finish_scene_skipping();
		return;
	}
	if(!(isdefined(self.var_486885a7) && self.var_486885a7))
	{
		self.var_486885a7 = 1;
		_call_shot_funcs("skip_started");
	}
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			printtoprightln("" + self._s.name + "" + gettime(), (0, 1, 0));
		}
	#/
	if(!(isdefined(var_11843b70) && var_11843b70))
	{
		if(is_skipping_player_scene())
		{
			/#
				if(getdvarint(#"debug_scene_skip", 0) > 0)
				{
					printtoprightln("" + gettime());
				}
			#/
			if(getdvarint(#"scene_skip_no_fade", 0) == 0)
			{
				b_skip_fading = 0;
			}
			else
			{
				b_skip_fading = 1;
			}
			foreach(player in util::get_players(self._str_team))
			{
				player val::set(#"scene_skip", "freezecontrols", 1);
				player val::set(#"scene_skip", "takedamage", 0);
				player val::set(#"scene_skip", "ignoreme", 1);
				player val::set(#"scene_skip", "ignoreall", 1);
				if(!(isdefined(b_skip_fading) && b_skip_fading))
				{
					player thread lui::screen_fade_out(0, "black", "scene_system");
				}
			}
			setpauseworld(0);
		}
	}
	if(!function_b260bdcc(str_shot))
	{
		var_f6688aea = 1;
	}
	else
	{
		var_f6688aea = 0;
	}
	flagsys::wait_till(str_shot + "go");
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			printtoprightln("" + self._s.name + "" + gettime(), (0, 0, 1));
		}
	#/
	thread _skip_scene();
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			printtoprightln("" + gettime(), (0, 1, 0));
		}
	#/
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			if(isdefined(level.animation_played))
			{
				for(i = 0; i < level.animation_played.size; i++)
				{
					printtoprightln("" + level.animation_played[i], (1, 0, 0), -1);
				}
			}
		}
	#/
	wait_till_shot_finished(str_shot);
	self flagsys::set(#"hash_5a8a0284760e5913");
	if(!var_f6688aea)
	{
		if(is_skipping_scene())
		{
			finish_scene_skipping();
		}
		else if(isdefined(self.skipping_scene) && self.skipping_scene)
		{
			self.skipping_scene = undefined;
		}
		/#
			if(getdvarint(#"debug_scene_skip", 0) > 0)
			{
				printtoprightln("" + self._s.name + "" + gettime(), (1, 0.5, 0));
			}
		#/
		_call_shot_funcs("skip_completed");
		if(isdefined(self._s.var_e3b54868) && self._s.var_e3b54868 && !scene::function_46546b5c(self._str_name))
		{
			self.var_753367d = 1;
			self notify(#"hash_63783193d9ac5bfc");
			thread play(self.var_355308d8, undefined, undefined, "single");
		}
		else
		{
			_call_shot_funcs("done");
			flagsys::set(#"scene_skip_completed");
		}
	}
	else if(is_skipping_player_scene())
	{
		if(self._s scene::is_igc())
		{
			foreach(player in util::get_players(self._str_team))
			{
				player stopsounds();
			}
		}
	}
}

/*
	Name: finish_scene_skipping
	Namespace: cscene
	Checksum: 0xEE1D6FEC
	Offset: 0x112E0
	Size: 0x366
	Parameters: 0
	Flags: Linked
*/
function finish_scene_skipping()
{
	/#
		if(getdvarint(#"debug_scene_skip", 0) > 0)
		{
			printtoprightln("" + gettime(), (1, 0, 0));
		}
	#/
	if(is_skipping_scene())
	{
		/#
			if(getdvarint(#"debug_scene_skip", 0) > 0)
			{
				printtoprightln("" + gettime());
			}
		#/
		if(getdvarint(#"scene_skip_no_fade", 0) == 0)
		{
			b_skip_fading = 0;
		}
		else
		{
			b_skip_fading = 1;
		}
		function_f4b4e39f(0);
		level util::streamer_wait(undefined, undefined, 10);
		foreach(player in util::get_players(self._str_team))
		{
			player clientfield::increment_to_player("player_scene_skip_completed");
			player val::reset(#"scene_skip", "freezecontrols");
			player val::reset(#"scene_skip", "takedamage");
			player val::reset(#"scene_skip", "ignoreme");
			player val::reset(#"scene_skip", "ignoreall");
			player stopsounds();
		}
		if(!(isdefined(b_skip_fading) && b_skip_fading))
		{
			if(!(isdefined(level.level_ending) && level.level_ending) && is_skipping_player_scene())
			{
				foreach(player in util::get_players(self._str_team))
				{
					player thread lui::screen_fade_in(1, "black", "scene_system");
				}
			}
		}
		self.b_player_scene = undefined;
		self.skipping_scene = undefined;
		self.scene_skip_completed = 1;
	}
}

/*
	Name: _skip_scene
	Namespace: cscene
	Checksum: 0xE404E8D7
	Offset: 0x11650
	Size: 0xAE
	Parameters: 0
	Flags: Linked
*/
function _skip_scene()
{
	self endon(#"stopped");
	if(isdefined(self._a_objects))
	{
		foreach(o_scene_object in self._a_objects)
		{
			[[ o_scene_object ]]->skip_scene(1);
		}
	}
	self notify(#"skip_camera_anims");
}

/*
	Name: has_player
	Namespace: cscene
	Checksum: 0xB8FB543A
	Offset: 0x11708
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function has_player()
{
	if(!isdefined(self._a_objects))
	{
		return 0;
	}
	foreach(obj in self._a_objects)
	{
		if([[ obj ]]->is_player())
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: add_object
	Namespace: cscene
	Checksum: 0x2C938E15
	Offset: 0x117A0
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function add_object(o_object)
{
	if(!isdefined(self._a_objects))
	{
		self._a_objects = [];
	}
	else if(!isarray(self._a_objects))
	{
		self._a_objects = array(self._a_objects);
	}
	self._a_objects[self._a_objects.size] = o_object;
}

/*
	Name: remove_object
	Namespace: cscene
	Checksum: 0xB29793A2
	Offset: 0x11820
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function remove_object(o_object)
{
	arrayremovevalue(self._a_objects, o_object);
}

/*
	Name: log
	Namespace: cscene
	Checksum: 0x2A4A642A
	Offset: 0x11850
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function log(str_msg)
{
	/#
		println(self._s.type + "" + function_9e72a96(self._str_name) + "" + str_msg);
	#/
}

/*
	Name: error
	Namespace: cscene
	Checksum: 0x2C1C7BD8
	Offset: 0x118C0
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function error(condition, str_msg)
{
	if(condition)
	{
		if(self._b_testing)
		{
			/#
				scene::error_on_screen(str_msg);
			#/
		}
		assertmsg(self._s.type + "" + function_9e72a96(self._str_name) + "" + str_msg);
		thread [[ self ]]->on_error();
		return 1;
	}
	return 0;
}

/*
	Name: warning
	Namespace: cscene
	Checksum: 0x27379345
	Offset: 0x11980
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function warning(condition, str_msg)
{
	if(condition)
	{
		if(self._b_testing)
		{
			/#
				scene::warning_on_screen("" + self._str_name + "" + str_msg);
			#/
		}
		return 1;
	}
	return 0;
}

#namespace scene;

/*
	Name: cscene
	Namespace: scene
	Checksum: 0x275DF354
	Offset: 0x119F0
	Size: 0xDD6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscene()
{
	classes.cscene[0] = spawnstruct();
	classes.cscene[0].__vtable[2140141178] = &cscene::warning;
	classes.cscene[0].__vtable[365768300] = &cscene::error;
	classes.cscene[0].__vtable[766440049] = &cscene::log;
	classes.cscene[0].__vtable[1946041604] = &cscene::remove_object;
	classes.cscene[0].__vtable[1475690061] = &cscene::add_object;
	classes.cscene[0].__vtable[725425285] = &cscene::has_player;
	classes.cscene[0].__vtable[1444355453] = &cscene::_skip_scene;
	classes.cscene[0].__vtable[1551228089] = &cscene::finish_scene_skipping;
	classes.cscene[0].__vtable[2021069790] = &cscene::skip_scene;
	classes.cscene[0].__vtable[1785438775] = &cscene::is_scene_shared;
	classes.cscene[0].__vtable[1570676452] = &cscene::on_error;
	classes.cscene[0].__vtable[1533509286] = &cscene::get_valid_objects;
	classes.cscene[0].__vtable[1156799476] = &cscene::sync_with_other_scenes;
	classes.cscene[0].__vtable[1098731505] = &cscene::wait_till_objects_finished;
	classes.cscene[0].__vtable[2143554397] = &cscene::wait_till_shot_finished;
	classes.cscene[0].__vtable[287720518] = &cscene::wait_till_objects_ready;
	classes.cscene[0].__vtable[1705012505] = &cscene::function_9a5f92e7;
	classes.cscene[0].__vtable[1582596] = &cscene::wait_till_shot_ready;
	classes.cscene[0].__vtable[2103736659] = &cscene::is_looping;
	classes.cscene[0].__vtable[1997194878] = &cscene::get_align_ent;
	classes.cscene[0].__vtable[1722290389] = &cscene::get_root;
	classes.cscene[0].__vtable[215327320] = &cscene::get_ents;
	classes.cscene[0].__vtable[392345334] = &cscene::_call_shot_funcs;
	classes.cscene[0].__vtable[1959331961] = &cscene::stop;
	classes.cscene[0].__vtable[1343842804] = &cscene::has_init_state;
	classes.cscene[0].__vtable[782090682] = &cscene::run_next;
	classes.cscene[0].__vtable[906755566] = &cscene::function_c9f40212;
	classes.cscene[0].__vtable[419517746] = &cscene::function_19015532;
	classes.cscene[0].__vtable[1109405156] = &cscene::scene_skip_completed;
	classes.cscene[0].__vtable[1291990191] = &cscene::is_skipping_player_scene;
	classes.cscene[0].__vtable[20115966] = &cscene::is_skipping_scene;
	classes.cscene[0].__vtable[1163210911] = &cscene::_stop_camera_anim_on_player;
	classes.cscene[0].__vtable[1082987699] = &cscene::_stop_camera_anims;
	classes.cscene[0].__vtable[1618762684] = &cscene::loop_camera_anim_to_set_up_for_capture;
	classes.cscene[0].__vtable[1999484790] = &cscene::_play_camera_anim_on_player;
	classes.cscene[0].__vtable[324337726] = &cscene::_play_camera_anim_on_player_callback;
	classes.cscene[0].__vtable[1601132871] = &cscene::_play_camera_anims;
	classes.cscene[0].__vtable[1918250903] = &cscene::_wait_for_camera_animation;
	classes.cscene[0].__vtable[1042462380] = &cscene::function_3e22b6ac;
	classes.cscene[0].__vtable[1425248549] = &cscene::function_ab0c6edb;
	classes.cscene[0].__vtable[881215179] = &cscene::play;
	classes.cscene[0].__vtable[1442319802] = &cscene::get_anim_relative_start_time;
	classes.cscene[0].__vtable[1297640942] = &cscene::get_objects;
	classes.cscene[0].__vtable[188405038] = &cscene::_is_ent_vehicle;
	classes.cscene[0].__vtable[327455400] = &cscene::_is_ent_actor;
	classes.cscene[0].__vtable[1477387044] = &cscene::_is_ent_companion;
	classes.cscene[0].__vtable[104020580] = &cscene::_is_ent_player;
	classes.cscene[0].__vtable[2043898469] = &cscene::_assign_ents_by_type;
	classes.cscene[0].__vtable[986715319] = &cscene::_assign_ents_by_name;
	classes.cscene[0].__vtable[327919019] = &cscene::assign_ent;
	classes.cscene[0].__vtable[1574780223] = &cscene::assign_ents;
	classes.cscene[0].__vtable[1545341188] = &cscene::sync_with_client_scene;
	classes.cscene[0].__vtable[1226873752] = &cscene::get_object_id;
	classes.cscene[0].__vtable[1299358145] = &cscene::get_valid_object_defs;
	classes.cscene[0].__vtable[648642868] = &cscene::new_object;
	classes.cscene[0].__vtable[787185780] = &cscene::remove_from_sync_list;
	classes.cscene[0].__vtable[258976881] = &cscene::add_to_sync_list;
	classes.cscene[0].__vtable[1164783371] = &cscene::get_request_time;
	classes.cscene[0].__vtable[1232929113] = &cscene::set_request_time;
	classes.cscene[0].__vtable[1435150950] = &cscene::function_558aaa66;
	classes.cscene[0].__vtable[140432185] = &cscene::function_85ed339;
	classes.cscene[0].__vtable[722055235] = &cscene::is_player;
	classes.cscene[0].__vtable[1326644599] = &cscene::function_4f12fd77;
	classes.cscene[0].__vtable[1302282804] = &cscene::function_b260bdcc;
	classes.cscene[0].__vtable[620285877] = &cscene::function_24f8cfb5;
	classes.cscene[0].__vtable[106153687] = &cscene::function_f9ac3929;
	classes.cscene[0].__vtable[350145629] = &cscene::function_eb2133a3;
	classes.cscene[0].__vtable[267958280] = &cscene::function_ff8b808;
	classes.cscene[0].__vtable[1945944875] = &cscene::function_73fcc32b;
	classes.cscene[0].__vtable[1836838051] = &cscene::init;
	classes.cscene[0].__vtable[1142086757] = &cscene::function_4412dc65;
	classes.cscene[0].__vtable[913321084] = &cscene::__destructor;
	classes.cscene[0].__vtable[674154906] = &cscene::__constructor;
}

