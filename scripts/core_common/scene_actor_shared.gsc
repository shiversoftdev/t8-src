// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_actor_shared.gsc;
#using scripts\core_common\scene_objects_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\util_shared.gsc;

class csceneactor : csceneobject
{
	var _e;
	var var_55b4f21e;
	var _s;
	var _o_scene;
	var _b_set_goal;
	var _str_shot;
	var _str_team;

	/*
		Name: constructor
		Namespace: csceneactor
		Checksum: 0x57D8BE3A
		Offset: 0x198
		Size: 0x22
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self._b_set_goal = 1;
	}

	/*
		Name: destructor
		Namespace: csceneactor
		Checksum: 0x8B428900
		Offset: 0x9F0
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: do_death_anims
		Namespace: csceneactor
		Checksum: 0x43CDA14E
		Offset: 0x910
		Size: 0xD4
		Parameters: 0
		Flags: Linked
	*/
	function do_death_anims()
	{
		ent = _e;
		if(isdefined(var_55b4f21e.deathanim) && (!(isdefined(ent.var_67d418) && ent.var_67d418)))
		{
			ent.skipdeath = 1;
			ent animation::play(var_55b4f21e.deathanim, ent, undefined, 1, 0.2, 0);
		}
		else
		{
			ent animation::stop();
			ent startragdoll();
		}
		csceneobject::function_1e19d813();
	}

	/*
		Name: _set_values
		Namespace: csceneactor
		Checksum: 0x6375B46
		Offset: 0x7E0
		Size: 0x124
		Parameters: 1
		Flags: Linked
	*/
	function _set_values(ent = _e)
	{
		if(!(isdefined(_s.takedamage) && _s.takedamage))
		{
			csceneobject::set_ent_val("takedamage", 0, ent);
		}
		csceneobject::set_ent_val("ignoreme", !(isdefined(_s.var_c732c237) && _s.var_c732c237), ent);
		csceneobject::set_ent_val("allowdeath", isdefined(_s.allowdeath) && _s.allowdeath, ent);
		csceneobject::set_ent_val("take_weapons", isdefined(_s.removeweapon) && _s.removeweapon, ent);
	}

	/*
		Name: function_d09b043
		Namespace: csceneactor
		Checksum: 0x60F82AC0
		Offset: 0x688
		Size: 0x14C
		Parameters: 0
		Flags: Linked
	*/
	function function_d09b043()
	{
		self notify(#"hash_74f6d3a1ddcff42");
		self endon(#"hash_74f6d3a1ddcff42");
		_o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
		var_be17187b = undefined;
		var_be17187b = _e waittill(#"death");
		self.var_1f97724a = 1;
		_e notify(#"hash_6e7fd8207fd988c6", {#str_scene:_o_scene._str_name});
		if(isdefined(_e) && (!(isdefined(_e.skipscenedeath) && _e.skipscenedeath)))
		{
			self thread do_death_anims();
		}
		else
		{
			csceneobject::function_1e19d813();
		}
	}

	/*
		Name: set_goal
		Namespace: csceneactor
		Checksum: 0xB5B55206
		Offset: 0x570
		Size: 0x10C
		Parameters: 0
		Flags: Linked
	*/
	function set_goal()
	{
		if(!(_e.scene_spawned === _o_scene._s.name && isdefined(_e.target)))
		{
			if(!isdefined(_e.script_forcecolor))
			{
				if(!_e flagsys::get(#"anim_reach"))
				{
					if(isdefined(_e.scenegoal))
					{
						_e setgoal(_e.scenegoal);
						_e.scenegoal = undefined;
					}
					else if(_b_set_goal)
					{
						_e setgoal(_e.origin);
					}
				}
			}
		}
	}

	/*
		Name: track_goal
		Namespace: csceneactor
		Checksum: 0x8DA457F8
		Offset: 0x508
		Size: 0x5A
		Parameters: 0
		Flags: Linked
	*/
	function track_goal()
	{
		self endon(_str_shot + "active");
		_e endon(#"death");
		_e waittill(#"goal_changed");
		self._b_set_goal = 0;
	}

	/*
		Name: _cleanup
		Namespace: csceneactor
		Checksum: 0xBF179C3C
		Offset: 0x3D8
		Size: 0x124
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
		if(isactor(_e) && isalive(_e))
		{
			if(isdefined(_s.delaymovementatend) && _s.delaymovementatend)
			{
				_e pathmode("move delayed", 1, randomfloatrange(2, 3));
			}
			else
			{
				_e pathmode("move allowed");
			}
			if(isdefined(_s.lookatplayer) && _s.lookatplayer)
			{
				_e lookatentity();
			}
			_e.var_67d418 = undefined;
			set_goal();
		}
	}

	/*
		Name: _prepare
		Namespace: csceneactor
		Checksum: 0x60A8F21E
		Offset: 0x2E0
		Size: 0xEC
		Parameters: 0
		Flags: Linked
	*/
	function _prepare()
	{
		if(isactor(_e))
		{
			thread track_goal();
			if(isdefined(_s.lookatplayer) && _s.lookatplayer)
			{
				_e lookatentity(level.activeplayers[0]);
			}
			if(isdefined(_s.skipdeathanim) && _s.skipdeathanim)
			{
				_e.var_67d418 = 1;
			}
			self._str_team = _e getteam();
		}
		csceneobject::_prepare();
	}

	/*
		Name: function_bc340efa
		Namespace: csceneactor
		Checksum: 0x16B276B6
		Offset: 0x238
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function function_bc340efa(str_model)
	{
		self._e = spawnactor(str_model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), undefined, 1);
		if(!isdefined(_e))
		{
			return;
		}
		self._str_team = _e getteam();
		_e setteam(_str_team);
	}

	/*
		Name: _spawn_ent
		Namespace: csceneactor
		Checksum: 0x61EC3A4
		Offset: 0x1C8
		Size: 0x64
		Parameters: 0
		Flags: Linked
	*/
	function _spawn_ent()
	{
		if(isdefined(_s.model))
		{
			if(isassetloaded("aitype", _s.model))
			{
				function_bc340efa(_s.model);
			}
		}
	}

}

class cscenefakeactor : csceneobject, csceneactor
{
	var _e;
	var _s;

	/*
		Name: constructor
		Namespace: cscenefakeactor
		Checksum: 0xB9729667
		Offset: 0x2270
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenefakeactor
		Checksum: 0x4EAE6CCF
		Offset: 0x2290
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: _spawn_ent
		Namespace: cscenefakeactor
		Checksum: 0x97A6BE8
		Offset: 0x1FD0
		Size: 0x294
		Parameters: 0
		Flags: Linked
	*/
	function _spawn_ent()
	{
		if(isspawner(_e))
		{
			csceneactor::function_bc340efa(_e.aitype);
			if(isdefined(_e) && !isspawner(_e))
			{
				str_model = _e.aitype;
				self._str_team = _e getteam();
				weapon = _e.weapon;
				_e delete();
			}
		}
		else if(isdefined(_s.model))
		{
			if(isassetloaded("aitype", _s.model))
			{
				csceneactor::function_bc340efa(_s.model);
				if(isdefined(_e))
				{
					str_model = _e.aitype;
					self._str_team = _e getteam();
					weapon = _e.weapon;
					_e delete();
				}
			}
			else
			{
				str_model = _s.model;
			}
		}
		if(isdefined(str_model))
		{
			self._e = util::spawn_anim_model(str_model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
			_e makefakeai();
			if(!(isdefined(_s.removeweapon) && _s.removeweapon))
			{
				if(isdefined(weapon))
				{
					_e animation::attach_weapon(weapon);
				}
				else
				{
					_e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
				}
			}
		}
	}

}

class cscenecompanion : csceneobject, csceneactor
{
	var _e;
	var _s;
	var _str_shot;
	var _o_scene;

	/*
		Name: constructor
		Namespace: cscenecompanion
		Checksum: 0x5AE86D33
		Offset: 0x3DF8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenecompanion
		Checksum: 0x55D9AC4F
		Offset: 0x3E18
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: animation_lookup
		Namespace: cscenecompanion
		Checksum: 0x39B7AACB
		Offset: 0x3CF0
		Size: 0x100
		Parameters: 3
		Flags: Linked
	*/
	function animation_lookup(animation, ent = _e, b_camera = 0)
	{
		if(isdefined(_s.var_2df1a365))
		{
			n_shot = csceneobject::get_shot(_str_shot);
			var_d57bf586 = ent.animname;
			if(isdefined(n_shot) && isdefined(_s.var_2df1a365[n_shot]) && isdefined(_s.var_2df1a365[n_shot][var_d57bf586]))
			{
				return _s.var_2df1a365[n_shot][var_d57bf586].var_554345e4;
			}
		}
		return animation;
	}

	/*
		Name: _stop
		Namespace: cscenecompanion
		Checksum: 0xBB3F2B17
		Offset: 0x3C48
		Size: 0x9C
		Parameters: 1
		Flags: Linked
	*/
	function _stop(b_dont_clear_anim)
	{
		if(isalive(_e))
		{
			_e notify(#"scene_stop");
			if(!b_dont_clear_anim)
			{
				_e animation::stop(0.2);
			}
			_e thread scene::function_37592f67(_o_scene._e_root, _o_scene._s);
		}
	}

	/*
		Name: _cleanup
		Namespace: cscenecompanion
		Checksum: 0x74EC898E
		Offset: 0x3BC0
		Size: 0x7C
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
		if(!([[ _o_scene ]]->function_19015532(_str_shot)) || _o_scene._str_mode === "single")
		{
			_e thread scene::function_37592f67(_o_scene._e_root, _o_scene._s);
		}
	}

	/*
		Name: _spawn_ent
		Namespace: cscenecompanion
		Checksum: 0x7D46233C
		Offset: 0x39C8
		Size: 0x1EC
		Parameters: 0
		Flags: Linked
	*/
	function _spawn_ent()
	{
		if(isspawner(_e))
		{
			if(!csceneobject::error(_e.count < 1, "Trying to spawn AI for scene with spawner count < 1"))
			{
				self._e = _e spawner::spawn(1);
			}
		}
		else if(isassetloaded("aitype", _s.model))
		{
			self._e = spawnactor(_s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), _s.name, 1);
		}
		if(!isdefined(_e))
		{
			return;
		}
		self._str_team = _e getteam();
		if(!isdefined(level.heroes))
		{
			level.heroes = [];
		}
		level.heroes[_s.name] = _e;
		_s.(_s.name) = _e;
		_e.animname = _s.name;
		_e.is_hero = 1;
		_e.enableterrainik = 1;
		_e util::magic_bullet_shield();
	}

	/*
		Name: _spawn
		Namespace: cscenecompanion
		Checksum: 0x7AC42C63
		Offset: 0x3900
		Size: 0xBC
		Parameters: 0
		Flags: Linked
	*/
	function _spawn()
	{
		if(!isdefined(level.heroes))
		{
			level.heroes = [];
		}
		foreach(ent in level.heroes)
		{
			if(!csceneobject::in_this_scene(ent))
			{
				self._e = ent;
				return;
			}
		}
		csceneobject::_spawn();
	}

}

class cscenesharedcompanion : csceneobject, csceneactor, cscenecompanion
{

	/*
		Name: constructor
		Namespace: cscenesharedcompanion
		Checksum: 0x51F1D872
		Offset: 0x56B8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 8, 128
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscenesharedcompanion
		Checksum: 0x184C3499
		Offset: 0x56D8
		Size: 0x14
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

	/*
		Name: _cleanup
		Namespace: cscenesharedcompanion
		Checksum: 0x2FC37166
		Offset: 0x5600
		Size: 0xAC
		Parameters: 0
		Flags: Linked
	*/
	function _cleanup()
	{
		if(!isdefined(level.heroes))
		{
			level.heroes = [];
		}
		foreach(ent in level.heroes)
		{
			ent setvisibletoall();
		}
		cscenecompanion::_cleanup();
	}

	/*
		Name: _prepare
		Namespace: cscenesharedcompanion
		Checksum: 0x26BAE570
		Offset: 0x5548
		Size: 0xB0
		Parameters: 0
		Flags: Linked
	*/
	function _prepare()
	{
		if(!isdefined(level.heroes))
		{
			level.heroes = [];
		}
		foreach(ent in level.heroes)
		{
			ent setinvisibletoall();
			ent setvisibletoall();
		}
	}

}

