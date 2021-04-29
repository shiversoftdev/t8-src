// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_actor_shared.gsc;
#using scripts\core_common\scene_objects_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace csceneactor;

/*
	Name: __constructor
	Namespace: csceneactor
	Checksum: 0x57D8BE3A
	Offset: 0x198
	Size: 0x22
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	csceneobject::__constructor();
	self._b_set_goal = 1;
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
	if(isdefined(self._s.model))
	{
		if(isassetloaded("aitype", self._s.model))
		{
			function_bc340efa(self._s.model);
		}
	}
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
	if(!isdefined(self._e))
	{
		return;
	}
	self._str_team = self._e getteam();
	self._e setteam(self._str_team);
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
	if(isactor(self._e))
	{
		thread track_goal();
		if(isdefined(self._s.lookatplayer) && self._s.lookatplayer)
		{
			self._e lookatentity(level.activeplayers[0]);
		}
		if(isdefined(self._s.skipdeathanim) && self._s.skipdeathanim)
		{
			self._e.var_67d418 = 1;
		}
		self._str_team = self._e getteam();
	}
	csceneobject::_prepare();
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
	if(isactor(self._e) && isalive(self._e))
	{
		if(isdefined(self._s.delaymovementatend) && self._s.delaymovementatend)
		{
			self._e pathmode("move delayed", 1, randomfloatrange(2, 3));
		}
		else
		{
			self._e pathmode("move allowed");
		}
		if(isdefined(self._s.lookatplayer) && self._s.lookatplayer)
		{
			self._e lookatentity();
		}
		self._e.var_67d418 = undefined;
		set_goal();
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
	self endon(self._str_shot + "active");
	self._e endon(#"death");
	self._e waittill(#"goal_changed");
	self._b_set_goal = 0;
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
	if(!(self._e.scene_spawned === self._o_scene._s.name && isdefined(self._e.target)))
	{
		if(!isdefined(self._e.script_forcecolor))
		{
			if(!self._e flagsys::get(#"anim_reach"))
			{
				if(isdefined(self._e.scenegoal))
				{
					self._e setgoal(self._e.scenegoal);
					self._e.scenegoal = undefined;
				}
				else if(self._b_set_goal)
				{
					self._e setgoal(self._e.origin);
				}
			}
		}
	}
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
	self._o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
	var_be17187b = undefined;
	var_be17187b = self._e waittill(#"death");
	self.var_1f97724a = 1;
	self._e notify(#"hash_6e7fd8207fd988c6", {#str_scene:self._o_scene._str_name});
	if(isdefined(self._e) && (!(isdefined(self._e.skipscenedeath) && self._e.skipscenedeath)))
	{
		self thread do_death_anims();
	}
	else
	{
		csceneobject::function_1e19d813();
	}
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
function _set_values(ent = self._e)
{
	if(!(isdefined(self._s.takedamage) && self._s.takedamage))
	{
		csceneobject::set_ent_val("takedamage", 0, ent);
	}
	csceneobject::set_ent_val("ignoreme", !(isdefined(self._s.var_c732c237) && self._s.var_c732c237), ent);
	csceneobject::set_ent_val("allowdeath", isdefined(self._s.allowdeath) && self._s.allowdeath, ent);
	csceneobject::set_ent_val("take_weapons", isdefined(self._s.removeweapon) && self._s.removeweapon, ent);
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
	ent = self._e;
	if(isdefined(self.var_55b4f21e.deathanim) && (!(isdefined(ent.var_67d418) && ent.var_67d418)))
	{
		ent.skipdeath = 1;
		ent animation::play(self.var_55b4f21e.deathanim, ent, undefined, 1, 0.2, 0);
	}
	else
	{
		ent animation::stop();
		ent startragdoll();
	}
	csceneobject::function_1e19d813();
}

/*
	Name: __destructor
	Namespace: csceneactor
	Checksum: 0x8B428900
	Offset: 0x9F0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	csceneobject::__destructor();
}

#namespace scene;

/*
	Name: csceneactor
	Namespace: scene
	Checksum: 0x781E112C
	Offset: 0xA10
	Size: 0x15B6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function csceneactor()
{
	classes.csceneactor[0] = spawnstruct();
	classes.csceneactor[0].__vtable[2140141178] = &csceneobject::warning;
	classes.csceneactor[0].__vtable[365768300] = &csceneobject::error;
	classes.csceneactor[0].__vtable[766440049] = &csceneobject::log;
	classes.csceneactor[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.csceneactor[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.csceneactor[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.csceneactor[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.csceneactor[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.csceneactor[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.csceneactor[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.csceneactor[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.csceneactor[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.csceneactor[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.csceneactor[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.csceneactor[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.csceneactor[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.csceneactor[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.csceneactor[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.csceneactor[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.csceneactor[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.csceneactor[0].__vtable[722055235] = &csceneobject::is_player;
	classes.csceneactor[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.csceneactor[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.csceneactor[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.csceneactor[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.csceneactor[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.csceneactor[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.csceneactor[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.csceneactor[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.csceneactor[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.csceneactor[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.csceneactor[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.csceneactor[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.csceneactor[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.csceneactor[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.csceneactor[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.csceneactor[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.csceneactor[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.csceneactor[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.csceneactor[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.csceneactor[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.csceneactor[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.csceneactor[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.csceneactor[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.csceneactor[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.csceneactor[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.csceneactor[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.csceneactor[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.csceneactor[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.csceneactor[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.csceneactor[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.csceneactor[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.csceneactor[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.csceneactor[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.csceneactor[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.csceneactor[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.csceneactor[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.csceneactor[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.csceneactor[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.csceneactor[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.csceneactor[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.csceneactor[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.csceneactor[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.csceneactor[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.csceneactor[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.csceneactor[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.csceneactor[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.csceneactor[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.csceneactor[0].__vtable[1959331961] = &csceneobject::stop;
	classes.csceneactor[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.csceneactor[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.csceneactor[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.csceneactor[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.csceneactor[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.csceneactor[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.csceneactor[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.csceneactor[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.csceneactor[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.csceneactor[0].__vtable[881215179] = &csceneobject::play;
	classes.csceneactor[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.csceneactor[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.csceneactor[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.csceneactor[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.csceneactor[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.csceneactor[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.csceneactor[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.csceneactor[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.csceneactor[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.csceneactor[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.csceneactor[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.csceneactor[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.csceneactor[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.csceneactor[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.csceneactor[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.csceneactor[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.csceneactor[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.csceneactor[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.csceneactor[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.csceneactor[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.csceneactor[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.csceneactor[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.csceneactor[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.csceneactor[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.csceneactor[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.csceneactor[0].__vtable[913321084] = &csceneactor::__destructor;
	classes.csceneactor[0].__vtable[110027328] = &csceneactor::do_death_anims;
	classes.csceneactor[0].__vtable[1422992797] = &csceneactor::_set_values;
	classes.csceneactor[0].__vtable[218738755] = &csceneactor::function_d09b043;
	classes.csceneactor[0].__vtable[1084594300] = &csceneactor::set_goal;
	classes.csceneactor[0].__vtable[68865451] = &csceneactor::track_goal;
	classes.csceneactor[0].__vtable[549459069] = &csceneactor::_cleanup;
	classes.csceneactor[0].__vtable[1985603041] = &csceneactor::_prepare;
	classes.csceneactor[0].__vtable[1137438982] = &csceneactor::function_bc340efa;
	classes.csceneactor[0].__vtable[365418333] = &csceneactor::_spawn_ent;
	classes.csceneactor[0].__vtable[674154906] = &csceneactor::__constructor;
}

#namespace cscenefakeactor;

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
	if(isspawner(self._e))
	{
		csceneactor::function_bc340efa(self._e.aitype);
		if(isdefined(self._e) && !isspawner(self._e))
		{
			str_model = self._e.aitype;
			self._str_team = self._e getteam();
			weapon = self._e.weapon;
			self._e delete();
		}
	}
	else if(isdefined(self._s.model))
	{
		if(isassetloaded("aitype", self._s.model))
		{
			csceneactor::function_bc340efa(self._s.model);
			if(isdefined(self._e))
			{
				str_model = self._e.aitype;
				self._str_team = self._e getteam();
				weapon = self._e.weapon;
				self._e delete();
			}
		}
		else
		{
			str_model = self._s.model;
		}
	}
	if(isdefined(str_model))
	{
		self._e = util::spawn_anim_model(str_model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
		self._e makefakeai();
		if(!(isdefined(self._s.removeweapon) && self._s.removeweapon))
		{
			if(isdefined(weapon))
			{
				self._e animation::attach_weapon(weapon);
			}
			else
			{
				self._e animation::attach_weapon(getweapon(#"ar_accurate_t8"));
			}
		}
	}
}

/*
	Name: __constructor
	Namespace: cscenefakeactor
	Checksum: 0xB9729667
	Offset: 0x2270
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
	csceneactor::__constructor();
}

/*
	Name: __destructor
	Namespace: cscenefakeactor
	Checksum: 0x4EAE6CCF
	Offset: 0x2290
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	csceneactor::__destructor();
}

#namespace scene;

/*
	Name: cscenefakeactor
	Namespace: scene
	Checksum: 0xA4C2D7CF
	Offset: 0x22B0
	Size: 0x1646
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscenefakeactor()
{
	classes.cscenefakeactor[0] = spawnstruct();
	classes.cscenefakeactor[0].__vtable[2140141178] = &csceneobject::warning;
	classes.cscenefakeactor[0].__vtable[365768300] = &csceneobject::error;
	classes.cscenefakeactor[0].__vtable[766440049] = &csceneobject::log;
	classes.cscenefakeactor[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.cscenefakeactor[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.cscenefakeactor[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.cscenefakeactor[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.cscenefakeactor[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.cscenefakeactor[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.cscenefakeactor[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.cscenefakeactor[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.cscenefakeactor[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.cscenefakeactor[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.cscenefakeactor[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.cscenefakeactor[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.cscenefakeactor[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.cscenefakeactor[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.cscenefakeactor[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.cscenefakeactor[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.cscenefakeactor[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.cscenefakeactor[0].__vtable[722055235] = &csceneobject::is_player;
	classes.cscenefakeactor[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.cscenefakeactor[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.cscenefakeactor[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.cscenefakeactor[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.cscenefakeactor[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.cscenefakeactor[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.cscenefakeactor[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.cscenefakeactor[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.cscenefakeactor[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.cscenefakeactor[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.cscenefakeactor[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.cscenefakeactor[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.cscenefakeactor[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.cscenefakeactor[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.cscenefakeactor[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.cscenefakeactor[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.cscenefakeactor[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.cscenefakeactor[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.cscenefakeactor[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.cscenefakeactor[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.cscenefakeactor[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.cscenefakeactor[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.cscenefakeactor[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.cscenefakeactor[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.cscenefakeactor[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.cscenefakeactor[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.cscenefakeactor[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.cscenefakeactor[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.cscenefakeactor[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.cscenefakeactor[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.cscenefakeactor[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.cscenefakeactor[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.cscenefakeactor[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.cscenefakeactor[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.cscenefakeactor[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.cscenefakeactor[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.cscenefakeactor[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.cscenefakeactor[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.cscenefakeactor[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.cscenefakeactor[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.cscenefakeactor[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.cscenefakeactor[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.cscenefakeactor[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.cscenefakeactor[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.cscenefakeactor[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.cscenefakeactor[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.cscenefakeactor[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.cscenefakeactor[0].__vtable[1959331961] = &csceneobject::stop;
	classes.cscenefakeactor[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.cscenefakeactor[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.cscenefakeactor[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.cscenefakeactor[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.cscenefakeactor[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.cscenefakeactor[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.cscenefakeactor[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.cscenefakeactor[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.cscenefakeactor[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.cscenefakeactor[0].__vtable[881215179] = &csceneobject::play;
	classes.cscenefakeactor[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.cscenefakeactor[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.cscenefakeactor[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.cscenefakeactor[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.cscenefakeactor[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.cscenefakeactor[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.cscenefakeactor[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.cscenefakeactor[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.cscenefakeactor[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.cscenefakeactor[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.cscenefakeactor[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.cscenefakeactor[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.cscenefakeactor[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.cscenefakeactor[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.cscenefakeactor[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.cscenefakeactor[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.cscenefakeactor[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.cscenefakeactor[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.cscenefakeactor[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.cscenefakeactor[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.cscenefakeactor[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.cscenefakeactor[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.cscenefakeactor[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.cscenefakeactor[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.cscenefakeactor[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.cscenefakeactor[0].__vtable[913321084] = &csceneactor::__destructor;
	classes.cscenefakeactor[0].__vtable[110027328] = &csceneactor::do_death_anims;
	classes.cscenefakeactor[0].__vtable[1422992797] = &csceneactor::_set_values;
	classes.cscenefakeactor[0].__vtable[218738755] = &csceneactor::function_d09b043;
	classes.cscenefakeactor[0].__vtable[1084594300] = &csceneactor::set_goal;
	classes.cscenefakeactor[0].__vtable[68865451] = &csceneactor::track_goal;
	classes.cscenefakeactor[0].__vtable[549459069] = &csceneactor::_cleanup;
	classes.cscenefakeactor[0].__vtable[1985603041] = &csceneactor::_prepare;
	classes.cscenefakeactor[0].__vtable[1137438982] = &csceneactor::function_bc340efa;
	classes.cscenefakeactor[0].__vtable[365418333] = &csceneactor::_spawn_ent;
	classes.cscenefakeactor[0].__vtable[674154906] = &csceneactor::__constructor;
	classes.cscenefakeactor[0].__vtable[913321084] = &cscenefakeactor::__destructor;
	classes.cscenefakeactor[0].__vtable[674154906] = &cscenefakeactor::__constructor;
	classes.cscenefakeactor[0].__vtable[365418333] = &cscenefakeactor::_spawn_ent;
}

#namespace cscenecompanion;

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
	if(isspawner(self._e))
	{
		if(!csceneobject::error(self._e.count < 1, "Trying to spawn AI for scene with spawner count < 1"))
		{
			self._e = self._e spawner::spawn(1);
		}
	}
	else if(isassetloaded("aitype", self._s.model))
	{
		self._e = spawnactor(self._s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53(), self._s.name, 1);
	}
	if(!isdefined(self._e))
	{
		return;
	}
	self._str_team = self._e getteam();
	if(!isdefined(level.heroes))
	{
		level.heroes = [];
	}
	level.heroes[self._s.name] = self._e;
	self._s.(self._s.name) = self._e;
	self._e.animname = self._s.name;
	self._e.is_hero = 1;
	self._e.enableterrainik = 1;
	self._e util::magic_bullet_shield();
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
	if(!([[ self._o_scene ]]->function_19015532(self._str_shot)) || self._o_scene._str_mode === "single")
	{
		self._e thread scene::function_37592f67(self._o_scene._e_root, self._o_scene._s);
	}
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
	if(isalive(self._e))
	{
		self._e notify(#"scene_stop");
		if(!b_dont_clear_anim)
		{
			self._e animation::stop(0.2);
		}
		self._e thread scene::function_37592f67(self._o_scene._e_root, self._o_scene._s);
	}
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
function animation_lookup(animation, ent = self._e, b_camera = 0)
{
	if(isdefined(self._s.var_2df1a365))
	{
		n_shot = csceneobject::get_shot(self._str_shot);
		var_d57bf586 = ent.animname;
		if(isdefined(n_shot) && isdefined(self._s.var_2df1a365[n_shot]) && isdefined(self._s.var_2df1a365[n_shot][var_d57bf586]))
		{
			return self._s.var_2df1a365[n_shot][var_d57bf586].var_554345e4;
		}
	}
	return animation;
}

/*
	Name: __constructor
	Namespace: cscenecompanion
	Checksum: 0x5AE86D33
	Offset: 0x3DF8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
	csceneactor::__constructor();
}

/*
	Name: __destructor
	Namespace: cscenecompanion
	Checksum: 0x55D9AC4F
	Offset: 0x3E18
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	csceneactor::__destructor();
}

#namespace scene;

/*
	Name: cscenecompanion
	Namespace: scene
	Checksum: 0x31CE2CFD
	Offset: 0x3E38
	Size: 0x1706
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscenecompanion()
{
	classes.cscenecompanion[0] = spawnstruct();
	classes.cscenecompanion[0].__vtable[2140141178] = &csceneobject::warning;
	classes.cscenecompanion[0].__vtable[365768300] = &csceneobject::error;
	classes.cscenecompanion[0].__vtable[766440049] = &csceneobject::log;
	classes.cscenecompanion[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.cscenecompanion[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.cscenecompanion[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.cscenecompanion[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.cscenecompanion[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.cscenecompanion[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.cscenecompanion[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.cscenecompanion[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.cscenecompanion[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.cscenecompanion[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.cscenecompanion[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.cscenecompanion[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.cscenecompanion[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.cscenecompanion[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.cscenecompanion[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.cscenecompanion[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.cscenecompanion[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.cscenecompanion[0].__vtable[722055235] = &csceneobject::is_player;
	classes.cscenecompanion[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.cscenecompanion[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.cscenecompanion[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.cscenecompanion[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.cscenecompanion[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.cscenecompanion[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.cscenecompanion[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.cscenecompanion[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.cscenecompanion[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.cscenecompanion[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.cscenecompanion[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.cscenecompanion[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.cscenecompanion[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.cscenecompanion[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.cscenecompanion[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.cscenecompanion[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.cscenecompanion[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.cscenecompanion[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.cscenecompanion[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.cscenecompanion[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.cscenecompanion[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.cscenecompanion[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.cscenecompanion[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.cscenecompanion[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.cscenecompanion[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.cscenecompanion[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.cscenecompanion[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.cscenecompanion[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.cscenecompanion[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.cscenecompanion[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.cscenecompanion[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.cscenecompanion[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.cscenecompanion[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.cscenecompanion[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.cscenecompanion[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.cscenecompanion[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.cscenecompanion[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.cscenecompanion[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.cscenecompanion[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.cscenecompanion[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.cscenecompanion[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.cscenecompanion[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.cscenecompanion[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.cscenecompanion[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.cscenecompanion[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.cscenecompanion[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.cscenecompanion[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.cscenecompanion[0].__vtable[1959331961] = &csceneobject::stop;
	classes.cscenecompanion[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.cscenecompanion[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.cscenecompanion[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.cscenecompanion[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.cscenecompanion[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.cscenecompanion[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.cscenecompanion[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.cscenecompanion[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.cscenecompanion[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.cscenecompanion[0].__vtable[881215179] = &csceneobject::play;
	classes.cscenecompanion[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.cscenecompanion[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.cscenecompanion[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.cscenecompanion[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.cscenecompanion[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.cscenecompanion[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.cscenecompanion[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.cscenecompanion[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.cscenecompanion[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.cscenecompanion[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.cscenecompanion[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.cscenecompanion[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.cscenecompanion[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.cscenecompanion[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.cscenecompanion[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.cscenecompanion[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.cscenecompanion[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.cscenecompanion[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.cscenecompanion[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.cscenecompanion[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.cscenecompanion[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.cscenecompanion[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.cscenecompanion[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.cscenecompanion[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.cscenecompanion[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.cscenecompanion[0].__vtable[913321084] = &csceneactor::__destructor;
	classes.cscenecompanion[0].__vtable[110027328] = &csceneactor::do_death_anims;
	classes.cscenecompanion[0].__vtable[1422992797] = &csceneactor::_set_values;
	classes.cscenecompanion[0].__vtable[218738755] = &csceneactor::function_d09b043;
	classes.cscenecompanion[0].__vtable[1084594300] = &csceneactor::set_goal;
	classes.cscenecompanion[0].__vtable[68865451] = &csceneactor::track_goal;
	classes.cscenecompanion[0].__vtable[549459069] = &csceneactor::_cleanup;
	classes.cscenecompanion[0].__vtable[1985603041] = &csceneactor::_prepare;
	classes.cscenecompanion[0].__vtable[1137438982] = &csceneactor::function_bc340efa;
	classes.cscenecompanion[0].__vtable[365418333] = &csceneactor::_spawn_ent;
	classes.cscenecompanion[0].__vtable[674154906] = &csceneactor::__constructor;
	classes.cscenecompanion[0].__vtable[913321084] = &cscenecompanion::__destructor;
	classes.cscenecompanion[0].__vtable[674154906] = &cscenecompanion::__constructor;
	classes.cscenecompanion[0].__vtable[1033579854] = &cscenecompanion::animation_lookup;
	classes.cscenecompanion[0].__vtable[2075964294] = &cscenecompanion::_stop;
	classes.cscenecompanion[0].__vtable[549459069] = &cscenecompanion::_cleanup;
	classes.cscenecompanion[0].__vtable[365418333] = &cscenecompanion::_spawn_ent;
	classes.cscenecompanion[0].__vtable[362767597] = &cscenecompanion::_spawn;
}

#namespace cscenesharedcompanion;

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
	Name: __constructor
	Namespace: cscenesharedcompanion
	Checksum: 0x51F1D872
	Offset: 0x56B8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
	cscenecompanion::__constructor();
}

/*
	Name: __destructor
	Namespace: cscenesharedcompanion
	Checksum: 0x184C3499
	Offset: 0x56D8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	cscenecompanion::__destructor();
}

#namespace scene;

/*
	Name: cscenesharedcompanion
	Namespace: scene
	Checksum: 0x6E90F3AD
	Offset: 0x56F8
	Size: 0x17C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscenesharedcompanion()
{
	classes.cscenesharedcompanion[0] = spawnstruct();
	classes.cscenesharedcompanion[0].__vtable[2140141178] = &csceneobject::warning;
	classes.cscenesharedcompanion[0].__vtable[365768300] = &csceneobject::error;
	classes.cscenesharedcompanion[0].__vtable[766440049] = &csceneobject::log;
	classes.cscenesharedcompanion[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.cscenesharedcompanion[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.cscenesharedcompanion[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.cscenesharedcompanion[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.cscenesharedcompanion[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.cscenesharedcompanion[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.cscenesharedcompanion[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.cscenesharedcompanion[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.cscenesharedcompanion[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.cscenesharedcompanion[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.cscenesharedcompanion[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.cscenesharedcompanion[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.cscenesharedcompanion[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.cscenesharedcompanion[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.cscenesharedcompanion[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.cscenesharedcompanion[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.cscenesharedcompanion[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.cscenesharedcompanion[0].__vtable[722055235] = &csceneobject::is_player;
	classes.cscenesharedcompanion[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.cscenesharedcompanion[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.cscenesharedcompanion[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.cscenesharedcompanion[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.cscenesharedcompanion[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.cscenesharedcompanion[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.cscenesharedcompanion[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.cscenesharedcompanion[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.cscenesharedcompanion[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.cscenesharedcompanion[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.cscenesharedcompanion[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.cscenesharedcompanion[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.cscenesharedcompanion[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.cscenesharedcompanion[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.cscenesharedcompanion[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.cscenesharedcompanion[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.cscenesharedcompanion[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.cscenesharedcompanion[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.cscenesharedcompanion[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.cscenesharedcompanion[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.cscenesharedcompanion[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.cscenesharedcompanion[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.cscenesharedcompanion[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.cscenesharedcompanion[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.cscenesharedcompanion[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.cscenesharedcompanion[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.cscenesharedcompanion[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.cscenesharedcompanion[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.cscenesharedcompanion[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.cscenesharedcompanion[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.cscenesharedcompanion[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.cscenesharedcompanion[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.cscenesharedcompanion[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.cscenesharedcompanion[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.cscenesharedcompanion[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.cscenesharedcompanion[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.cscenesharedcompanion[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.cscenesharedcompanion[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.cscenesharedcompanion[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.cscenesharedcompanion[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.cscenesharedcompanion[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.cscenesharedcompanion[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.cscenesharedcompanion[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.cscenesharedcompanion[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.cscenesharedcompanion[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.cscenesharedcompanion[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.cscenesharedcompanion[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.cscenesharedcompanion[0].__vtable[1959331961] = &csceneobject::stop;
	classes.cscenesharedcompanion[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.cscenesharedcompanion[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.cscenesharedcompanion[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.cscenesharedcompanion[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.cscenesharedcompanion[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.cscenesharedcompanion[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.cscenesharedcompanion[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.cscenesharedcompanion[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.cscenesharedcompanion[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.cscenesharedcompanion[0].__vtable[881215179] = &csceneobject::play;
	classes.cscenesharedcompanion[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.cscenesharedcompanion[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.cscenesharedcompanion[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.cscenesharedcompanion[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.cscenesharedcompanion[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.cscenesharedcompanion[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.cscenesharedcompanion[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.cscenesharedcompanion[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.cscenesharedcompanion[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.cscenesharedcompanion[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.cscenesharedcompanion[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.cscenesharedcompanion[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.cscenesharedcompanion[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.cscenesharedcompanion[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.cscenesharedcompanion[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.cscenesharedcompanion[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.cscenesharedcompanion[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.cscenesharedcompanion[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.cscenesharedcompanion[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.cscenesharedcompanion[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.cscenesharedcompanion[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.cscenesharedcompanion[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.cscenesharedcompanion[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.cscenesharedcompanion[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.cscenesharedcompanion[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.cscenesharedcompanion[0].__vtable[913321084] = &csceneactor::__destructor;
	classes.cscenesharedcompanion[0].__vtable[110027328] = &csceneactor::do_death_anims;
	classes.cscenesharedcompanion[0].__vtable[1422992797] = &csceneactor::_set_values;
	classes.cscenesharedcompanion[0].__vtable[218738755] = &csceneactor::function_d09b043;
	classes.cscenesharedcompanion[0].__vtable[1084594300] = &csceneactor::set_goal;
	classes.cscenesharedcompanion[0].__vtable[68865451] = &csceneactor::track_goal;
	classes.cscenesharedcompanion[0].__vtable[549459069] = &csceneactor::_cleanup;
	classes.cscenesharedcompanion[0].__vtable[1985603041] = &csceneactor::_prepare;
	classes.cscenesharedcompanion[0].__vtable[1137438982] = &csceneactor::function_bc340efa;
	classes.cscenesharedcompanion[0].__vtable[365418333] = &csceneactor::_spawn_ent;
	classes.cscenesharedcompanion[0].__vtable[674154906] = &csceneactor::__constructor;
	classes.cscenesharedcompanion[0].__vtable[913321084] = &cscenecompanion::__destructor;
	classes.cscenesharedcompanion[0].__vtable[674154906] = &cscenecompanion::__constructor;
	classes.cscenesharedcompanion[0].__vtable[1033579854] = &cscenecompanion::animation_lookup;
	classes.cscenesharedcompanion[0].__vtable[2075964294] = &cscenecompanion::_stop;
	classes.cscenesharedcompanion[0].__vtable[549459069] = &cscenecompanion::_cleanup;
	classes.cscenesharedcompanion[0].__vtable[365418333] = &cscenecompanion::_spawn_ent;
	classes.cscenesharedcompanion[0].__vtable[362767597] = &cscenecompanion::_spawn;
	classes.cscenesharedcompanion[0].__vtable[913321084] = &cscenesharedcompanion::__destructor;
	classes.cscenesharedcompanion[0].__vtable[674154906] = &cscenesharedcompanion::__constructor;
	classes.cscenesharedcompanion[0].__vtable[549459069] = &cscenesharedcompanion::_cleanup;
	classes.cscenesharedcompanion[0].__vtable[1985603041] = &cscenesharedcompanion::_prepare;
}

