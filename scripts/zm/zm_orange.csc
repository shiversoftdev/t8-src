// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_wallbuy.csc;
#using scripts\zm\zm_orange_ee_tundragun.csc;
#using scripts\zm\zm_orange_ee_yellow_snow.csc;
#using scripts\zm\weapons\zm_weap_cymbal_monkey.csc;
#using script_1edaf4333ed0bece;
#using scripts\zm\weapons\zm_weap_gravityspikes.csc;
#using scripts\zm\zm_orange_trials.csc;
#using scripts\zm_common\zm_characters.csc;
#using scripts\zm\zm_orange_lighthouse.csc;
#using scripts\zm\weapons\zm_weap_minigun.csc;
#using scripts\zm_common\zm_hud.csc;
#using scripts\zm\weapons\zm_weap_flamethrower.csc;
#using scripts\zm_common\zm_trial.csc;
#using script_4716533215778f7f;
#using scripts\zm\zm_orange_ee_dynamite.csc;
#using scripts\zm\zm_orange_water.csc;
#using script_5fb8da2731850d9e;
#using scripts\zm\zm_orange_freeze_trap.csc;
#using scripts\zm\weapons\zm_weap_riotshield.csc;
#using scripts\zm\zm_orange_mq_soapstone.csc;
#using scripts\zm_common\zm_loadout.csc;
#using script_70e92046734b4a71;
#using scripts\zm_common\zm_ui_inventory.csc;
#using scripts\zm\weapons\zm_weap_katana.csc;
#using scripts\zm\zm_orange_audiologs.csc;
#using scripts\zm\zm_orange_mq_mgr.csc;
#using script_84f5590d2ac48f8;
#using scripts\zm\zm_orange_pap.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\trigger_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_orange_challenges.csc;
#using scripts\zm\zm_orange_fx.csc;
#using scripts\zm\zm_orange_sound.csc;
#using scripts\zm\zm_orange_ww_quest.csc;
#using scripts\zm_common\callbacks.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_audio.csc;
#using scripts\zm_common\zm_magicbox.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_orange;

/*
	Name: opt_in
	Namespace: zm_orange
	Checksum: 0x4FBF7D9A
	Offset: 0x4D8
	Size: 0x22
	Parameters: 0
	Flags: AutoExec
*/
function autoexec opt_in()
{
	level.aat_in_use = 1;
	level.bgb_in_use = 1;
}

/*
	Name: main
	Namespace: zm_orange
	Checksum: 0xB2D20871
	Offset: 0x508
	Size: 0x3FC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	full_screen_movie::register("full_screen_movie");
	clientfield::register("actor", "sndActorUnderwater", 28000, 1, "int", &sndactorunderwater, 0, 1);
	level.setupcustomcharacterexerts = &setup_personality_character_exerts;
	level._effect[#"headshot"] = "_t6/impacts/fx_flesh_hit";
	level._effect[#"headshot_nochunks"] = "_t6/misc/fx_zombie_bloodsplat";
	level._effect[#"bloodspurt"] = "_t6/misc/fx_zombie_bloodspurt";
	level._effect[#"animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = "_t6/trail/fx_trail_blood_streak";
	level thread zm_orange_fx::init();
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level.var_d0ab70a2 = #"hash_544f128e274c84e0";
	level.var_4016a739 = vectorscale((0, 1, 0), 90);
	level zm_orange_challenges::init();
	level namespace_f9df92f::preload();
	level zm_orange_ee_dynamite::init();
	level zm_orange_ee_tundragun::init();
	level zm_orange_ee_yellow_snow::preload();
	level namespace_6036de69::init();
	level namespace_99a6629b::init();
	level zm_orange_freeze_trap::init();
	level zm_orange_mq_mgr::preload();
	level zm_orange_mq_soapstone::preload();
	level zm_orange_pap::init();
	level zm_orange_water::init();
	level zm_orange_ww_quest::init();
	level thread zm_orange_sound::main();
	level zm_orange_audiologs::preload();
	level zm_orange_trials::preload();
	load::main();
	level thread setup_personality_character_exerts();
	level thread zm_orange_challenges::main();
	level thread zm_orange_water::main();
	exploder::exploder("lgt_vending_mulekick_on");
	util::waitforclient(0);
	level thread function_b8da6f44();
	level thread function_72f1cddb();
}

/*
	Name: function_b8da6f44
	Namespace: zm_orange
	Checksum: 0x22A05EEB
	Offset: 0x910
	Size: 0x152
	Parameters: 0
	Flags: Linked
*/
function function_b8da6f44()
{
	level._effect[#"hash_2bba72fdcc5508b5"] = #"hash_1e8cb303d3103833";
	level._effect[#"chest_light_closed"] = #"hash_602f075818a2fb2e";
	level._effect[#"hash_19f4dd97cbb87594"] = #"hash_2f7533f7f5b59f7c";
	level._effect[#"hash_246062f68a34e289"] = #"hash_61b9b9ada5bb46b1";
	level._effect[#"hash_73c11d9bf55cbb6"] = #"hash_71e5e40c76a09b21";
	level._effect[#"hash_5239f7431d4c72ca"] = #"hash_200de2be21c77806";
	level._effect[#"hash_b6e7f724af1ad5b"] = #"hash_6e05ede771d9fb16";
}

/*
	Name: function_72f1cddb
	Namespace: zm_orange
	Checksum: 0x1FFD80
	Offset: 0xA70
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_72f1cddb()
{
	zm_utility::function_beed5764("rob_zm_eyes_red", #"zm_ai/fx8_zombie_eye_glow_red");
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_orange
	Checksum: 0x4FD2633
	Offset: 0xAA8
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[17][#"playerbreathinsound"] = "vox_stuh_exert_sniper_hold";
	level.exert_sounds[18][#"playerbreathinsound"] = "vox_mist_exert_sniper_hold";
	level.exert_sounds[19][#"playerbreathinsound"] = "vox_marl_exert_sniper_hold";
	level.exert_sounds[20][#"playerbreathinsound"] = "vox_russ_exert_sniper_hold";
	level.exert_sounds[17][#"playerbreathoutsound"] = "vox_stuh_exert_sniper_exhale";
	level.exert_sounds[18][#"playerbreathoutsound"] = "vox_mist_exert_sniper_exhale";
	level.exert_sounds[19][#"playerbreathoutsound"] = "vox_marl_exert_sniper_exhale";
	level.exert_sounds[20][#"playerbreathoutsound"] = "vox_russ_exert_sniper_exhale";
	level.exert_sounds[17][#"playerbreathgaspsound"] = "vox_stuh_exert_sniper_gasp";
	level.exert_sounds[18][#"playerbreathgaspsound"] = "vox_mist_exert_sniper_gasp";
	level.exert_sounds[19][#"playerbreathgaspsound"] = "vox_marl_exert_sniper_gasp";
	level.exert_sounds[20][#"playerbreathgaspsound"] = "vox_russ_exert_sniper_gasp";
	level.exert_sounds[17][#"meleeswipesoundplayer"] = "vox_stuh_exert_punch_give";
	level.exert_sounds[18][#"meleeswipesoundplayer"] = "vox_mist_exert_punch_give";
	level.exert_sounds[19][#"meleeswipesoundplayer"] = "vox_marl_exert_punch_give";
	level.exert_sounds[20][#"meleeswipesoundplayer"] = "vox_russ_exert_punch_give";
}

/*
	Name: sndactorunderwater
	Namespace: zm_orange
	Checksum: 0xDA93B0C8
	Offset: 0xD38
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function sndactorunderwater(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self setsoundentcontext("water", "under");
	}
	else
	{
		self setsoundentcontext("water", "over");
	}
}

