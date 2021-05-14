// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\scene_objects_shared.gsc;

#namespace cscenemodel;

/*
	Name: __constructor
	Namespace: cscenemodel
	Checksum: 0xB325F884
	Offset: 0xA0
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
	Namespace: cscenemodel
	Checksum: 0xBC2FE78D
	Offset: 0xC0
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
	Name: cscenemodel
	Namespace: scene
	Checksum: 0x5EEE36DF
	Offset: 0xE0
	Size: 0x1406
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscenemodel()
{
	classes.cscenemodel[0] = spawnstruct();
	classes.cscenemodel[0].__vtable[2140141178] = &csceneobject::warning;
	classes.cscenemodel[0].__vtable[365768300] = &csceneobject::error;
	classes.cscenemodel[0].__vtable[766440049] = &csceneobject::log;
	classes.cscenemodel[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.cscenemodel[0].__vtable[2021069790] = &csceneobject::skip_scene;
	classes.cscenemodel[0].__vtable[2133661978] = &csceneobject::skip_scene_shot_animations;
	classes.cscenemodel[0].__vtable[675117276] = &csceneobject::skip_animation_on_server;
	classes.cscenemodel[0].__vtable[1743590087] = &csceneobject::skip_animation_on_client;
	classes.cscenemodel[0].__vtable[1303671168] = &csceneobject::skip_anim_on_server;
	classes.cscenemodel[0].__vtable[132279865] = &csceneobject::skip_anim_on_client;
	classes.cscenemodel[0].__vtable[885662003] = &csceneobject::_should_skip_anim;
	classes.cscenemodel[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.cscenemodel[0].__vtable[1688292734] = &csceneobject::in_this_scene;
	classes.cscenemodel[0].__vtable[1408161249] = &csceneobject::is_vehicle;
	classes.cscenemodel[0].__vtable[27123621] = &csceneobject::is_actor;
	classes.cscenemodel[0].__vtable[1907870179] = &csceneobject::function_71b7c9e3;
	classes.cscenemodel[0].__vtable[1383142318] = &csceneobject::function_527113ae;
	classes.cscenemodel[0].__vtable[1695329961] = &csceneobject::is_shared_player;
	classes.cscenemodel[0].__vtable[546644640] = &csceneobject::function_209522a0;
	classes.cscenemodel[0].__vtable[710509369] = &csceneobject::is_player_model;
	classes.cscenemodel[0].__vtable[722055235] = &csceneobject::is_player;
	classes.cscenemodel[0].__vtable[957982582] = &csceneobject::function_3919a776;
	classes.cscenemodel[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.cscenemodel[0].__vtable[1042453582] = &csceneobject::function_3e22944e;
	classes.cscenemodel[0].__vtable[1211640348] = &csceneobject::function_48382a1c;
	classes.cscenemodel[0].__vtable[1546297082] = &csceneobject::function_5c2a9efa;
	classes.cscenemodel[0].__vtable[456427483] = &csceneobject::get_camera_tween_out;
	classes.cscenemodel[0].__vtable[429984512] = &csceneobject::get_camera_tween;
	classes.cscenemodel[0].__vtable[1531985087] = &csceneobject::get_lerp_time;
	classes.cscenemodel[0].__vtable[300881857] = &csceneobject::regroup_invulnerability;
	classes.cscenemodel[0].__vtable[813008673] = &csceneobject::play_regroup_fx_for_scene;
	classes.cscenemodel[0].__vtable[195576674] = &csceneobject::kill_ent;
	classes.cscenemodel[0].__vtable[365418333] = &csceneobject::_spawn_ent;
	classes.cscenemodel[0].__vtable[640744171] = &csceneobject::spawn_ent;
	classes.cscenemodel[0].__vtable[107779245] = &csceneobject::function_f9936b53;
	classes.cscenemodel[0].__vtable[771515608] = &csceneobject::function_d2039b28;
	classes.cscenemodel[0].__vtable[169612278] = &csceneobject::on_play_anim;
	classes.cscenemodel[0].__vtable[1739186539] = &csceneobject::function_98561e95;
	classes.cscenemodel[0].__vtable[1544037991] = &csceneobject::function_5c082667;
	classes.cscenemodel[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.cscenemodel[0].__vtable[1605388812] = &csceneobject::function_a04fb5f4;
	classes.cscenemodel[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.cscenemodel[0].__vtable[2077620912] = &csceneobject::play_anim;
	classes.cscenemodel[0].__vtable[1033579854] = &csceneobject::animation_lookup;
	classes.cscenemodel[0].__vtable[1475827001] = &csceneobject::function_a808aac7;
	classes.cscenemodel[0].__vtable[929865095] = &csceneobject::function_376c9d87;
	classes.cscenemodel[0].__vtable[591349346] = &csceneobject::set_objective;
	classes.cscenemodel[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.cscenemodel[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.cscenemodel[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.cscenemodel[0].__vtable[311362196] = &csceneobject::function_128f0294;
	classes.cscenemodel[0].__vtable[248750489] = &csceneobject::function_f12c5e67;
	classes.cscenemodel[0].__vtable[1256041242] = &csceneobject::function_b52254e6;
	classes.cscenemodel[0].__vtable[592928685] = &csceneobject::function_23575fad;
	classes.cscenemodel[0].__vtable[1266291167] = &csceneobject::function_b485ee21;
	classes.cscenemodel[0].__vtable[367563863] = &csceneobject::function_ea176ba9;
	classes.cscenemodel[0].__vtable[302371312] = &csceneobject::function_1205d1f0;
	classes.cscenemodel[0].__vtable[1928677856] = &csceneobject::function_72f549e0;
	classes.cscenemodel[0].__vtable[552798655] = &csceneobject::function_20f309bf;
	classes.cscenemodel[0].__vtable[351890795] = &csceneobject::function_14f96d6b;
	classes.cscenemodel[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.cscenemodel[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.cscenemodel[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.cscenemodel[0].__vtable[540391126] = &csceneobject::function_2035b6d6;
	classes.cscenemodel[0].__vtable[1721698064] = &csceneobject::function_9960f8f0;
	classes.cscenemodel[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.cscenemodel[0].__vtable[367831362] = &csceneobject::cleanup;
	classes.cscenemodel[0].__vtable[2075964294] = &csceneobject::_stop;
	classes.cscenemodel[0].__vtable[1959331961] = &csceneobject::stop;
	classes.cscenemodel[0].__vtable[1639237344] = &csceneobject::function_9e4b3920;
	classes.cscenemodel[0].__vtable[1547106576] = &csceneobject::scene_reach;
	classes.cscenemodel[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.cscenemodel[0].__vtable[1739499057] = &csceneobject::_dynamic_paths;
	classes.cscenemodel[0].__vtable[935331351] = &csceneobject::function_37c00617;
	classes.cscenemodel[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.cscenemodel[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.cscenemodel[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.cscenemodel[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.cscenemodel[0].__vtable[881215179] = &csceneobject::play;
	classes.cscenemodel[0].__vtable[1670043447] = &csceneobject::function_638ad737;
	classes.cscenemodel[0].__vtable[505010195] = &csceneobject::function_1e19d813;
	classes.cscenemodel[0].__vtable[795049183] = &csceneobject::has_streamer_hint;
	classes.cscenemodel[0].__vtable[384002887] = &csceneobject::function_e91c94b9;
	classes.cscenemodel[0].__vtable[1631299166] = &csceneobject::function_9ec459a2;
	classes.cscenemodel[0].__vtable[253500604] = &csceneobject::function_f0e3e344;
	classes.cscenemodel[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.cscenemodel[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.cscenemodel[0].__vtable[1302282804] = &csceneobject::function_b260bdcc;
	classes.cscenemodel[0].__vtable[620285877] = &csceneobject::function_24f8cfb5;
	classes.cscenemodel[0].__vtable[522245730] = &csceneobject::function_e0df299e;
	classes.cscenemodel[0].__vtable[1249504855] = &csceneobject::get_animation_name;
	classes.cscenemodel[0].__vtable[218738755] = &csceneobject::function_d09b043;
	classes.cscenemodel[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.cscenemodel[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.cscenemodel[0].__vtable[1659348325] = &csceneobject::prepare;
	classes.cscenemodel[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.cscenemodel[0].__vtable[1881963103] = &csceneobject::spawn;
	classes.cscenemodel[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.cscenemodel[0].__vtable[169902701] = &csceneobject::_reset_values;
	classes.cscenemodel[0].__vtable[1422992797] = &csceneobject::_set_values;
	classes.cscenemodel[0].__vtable[52429451] = &csceneobject::reset_ent_val;
	classes.cscenemodel[0].__vtable[1354594573] = &csceneobject::set_ent_val;
	classes.cscenemodel[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.cscenemodel[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.cscenemodel[0].__vtable[913321084] = &cscenemodel::__destructor;
	classes.cscenemodel[0].__vtable[674154906] = &cscenemodel::__constructor;
}

