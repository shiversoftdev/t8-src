// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_objects_shared.gsc;

#namespace cscenevehicle;

/*
	Name: _spawn_ent
	Namespace: cscenevehicle
	Checksum: 0x7C6B206A
	Offset: 0x168
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function _spawn_ent()
{
	if(isdefined(self._s.model))
	{
		if(isassetloaded("vehicle", self._s.model))
		{
			self._e = spawnvehicle(self._s.model, csceneobject::function_d2039b28(), csceneobject::function_f9936b53());
			scene::prepare_generic_model_anim(self._e);
		}
	}
}

/*
	Name: _set_values
	Namespace: cscenevehicle
	Checksum: 0x2DE968BF
	Offset: 0x220
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function _set_values(ent = self._e)
{
	if(!(csceneobject::error(!isvehicle(ent) && ent.classname !== "script_model", "entity is not actually a Vehicle or script_model, but set to Vehicle in scene. Check the GDT to make sure the proper object type is set")))
	{
		scene::prepare_generic_model_anim(ent);
	}
	csceneobject::set_ent_val("takedamage", isdefined(self._s.takedamage) && self._s.takedamage, ent);
	csceneobject::set_ent_val("ignoreme", !(isdefined(self._s.var_c732c237) && self._s.var_c732c237), ent);
	csceneobject::set_ent_val("allowdeath", isdefined(self._s.allowdeath) && self._s.allowdeath, ent);
}

/*
	Name: _prepare
	Namespace: cscenevehicle
	Checksum: 0xDACDA5CE
	Offset: 0x368
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function _prepare()
{
	csceneobject::set_objective();
}

/*
	Name: _cleanup
	Namespace: cscenevehicle
	Checksum: 0x80F724D1
	Offset: 0x388
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function _cleanup()
{
}

/*
	Name: function_d09b043
	Namespace: cscenevehicle
	Checksum: 0x8BF76591
	Offset: 0x398
	Size: 0xF4
	Parameters: 0
	Flags: Linked
*/
function function_d09b043()
{
	self notify(#"hash_3451c0bca5c1ca69");
	self endon(#"hash_3451c0bca5c1ca69");
	self._o_scene endon(#"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_3168dab591a18b9b");
	var_be17187b = undefined;
	var_be17187b = self._e waittill(#"death");
	self.var_1f97724a = 1;
	self._e notify(#"hash_6e7fd8207fd988c6", {#str_scene:self._o_scene._str_name});
	csceneobject::function_1e19d813();
}

/*
	Name: __constructor
	Namespace: cscenevehicle
	Checksum: 0xA2E431A0
	Offset: 0x498
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
	csceneobject::__constructor();
}

/*
	Name: __destructor
	Namespace: cscenevehicle
	Checksum: 0xEA4DC4D0
	Offset: 0x4B8
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
	Name: cscenevehicle
	Namespace: scene
	Checksum: 0x23B2F478
	Offset: 0x4D8
	Size: 0x14F6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscenevehicle()
{
	classes.cscenevehicle[0] = spawnstruct();
	classes.cscenevehicle[0].__vtable[2140141178] = &csceneobject::warning;
	classes.cscenevehicle[0].__vtable[365768300] = &csceneobject::error;
	classes.cscenevehicle[0].__vtable[766440049] = &csceneobject::log;
	classes.cscenevehicle[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.cscenevehicle[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.cscenevehicle[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.cscenevehicle[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.cscenevehicle[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.cscenevehicle[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.cscenevehicle[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.cscenevehicle[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.cscenevehicle[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.cscenevehicle[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.cscenevehicle[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.cscenevehicle[0].__vtable[27123621] = &csceneobject::function_19ddfa5;
	classes.cscenevehicle[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.cscenevehicle[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.cscenevehicle[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.cscenevehicle[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.cscenevehicle[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.cscenevehicle[0].__vtable[722055235] = &csceneobject::is_player;
	classes.cscenevehicle[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.cscenevehicle[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.cscenevehicle[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.cscenevehicle[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.cscenevehicle[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.cscenevehicle[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.cscenevehicle[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.cscenevehicle[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.cscenevehicle[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.cscenevehicle[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.cscenevehicle[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.cscenevehicle[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.cscenevehicle[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.cscenevehicle[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.cscenevehicle[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.cscenevehicle[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.cscenevehicle[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.cscenevehicle[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.cscenevehicle[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.cscenevehicle[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.cscenevehicle[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.cscenevehicle[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.cscenevehicle[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.cscenevehicle[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.cscenevehicle[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.cscenevehicle[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.cscenevehicle[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.cscenevehicle[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.cscenevehicle[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.cscenevehicle[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.cscenevehicle[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.cscenevehicle[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.cscenevehicle[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.cscenevehicle[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.cscenevehicle[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.cscenevehicle[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.cscenevehicle[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.cscenevehicle[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.cscenevehicle[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.cscenevehicle[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.cscenevehicle[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.cscenevehicle[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.cscenevehicle[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.cscenevehicle[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.cscenevehicle[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.cscenevehicle[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.cscenevehicle[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.cscenevehicle[0].__vtable[1959331961] = &csceneobject::stop;
	classes.cscenevehicle[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.cscenevehicle[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.cscenevehicle[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.cscenevehicle[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.cscenevehicle[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.cscenevehicle[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.cscenevehicle[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.cscenevehicle[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.cscenevehicle[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.cscenevehicle[0].__vtable[881215179] = &csceneobject::play;
	classes.cscenevehicle[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.cscenevehicle[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.cscenevehicle[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.cscenevehicle[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.cscenevehicle[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.cscenevehicle[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.cscenevehicle[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.cscenevehicle[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.cscenevehicle[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.cscenevehicle[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.cscenevehicle[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.cscenevehicle[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.cscenevehicle[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.cscenevehicle[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.cscenevehicle[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.cscenevehicle[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.cscenevehicle[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.cscenevehicle[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.cscenevehicle[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.cscenevehicle[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.cscenevehicle[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.cscenevehicle[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.cscenevehicle[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.cscenevehicle[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.cscenevehicle[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.cscenevehicle[0].__vtable[913321084] = &cscenevehicle::__destructor;
	classes.cscenevehicle[0].__vtable[674154906] = &cscenevehicle::__constructor;
	classes.cscenevehicle[0].__vtable[218738755] = &cscenevehicle::function_d09b043;
	classes.cscenevehicle[0].__vtable[549459069] = &cscenevehicle::_cleanup;
	classes.cscenevehicle[0].__vtable[1985603041] = &cscenevehicle::_prepare;
	classes.cscenevehicle[0].__vtable[1422992797] = &cscenevehicle::_set_values;
	classes.cscenevehicle[0].__vtable[365418333] = &cscenevehicle::_spawn_ent;
}

