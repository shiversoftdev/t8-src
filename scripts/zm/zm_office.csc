// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1611421ee9b880d3;
#using script_1de1583a62cc580f;
#using script_23037fdea02db280;
#using script_2c454d63a96d2d0b;
#using script_356ad5dd4af06a33;
#using script_3619535866efa23a;
#using script_3a10f19f96036e97;
#using script_578af034e151f03e;
#using script_67051bc8c81031aa;
#using script_784bc1aee23dbf1f;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\exploder_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_office_gamemodes.csc;
#using scripts\zm\zm_office_sound.csc;
#using scripts\zm\zm_office_ww_quest.csc;
#using scripts\zm_common\load.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_office;

/*
	Name: opt_in
	Namespace: zm_office
	Checksum: 0xE40D77A7
	Offset: 0x498
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
	Namespace: zm_office
	Checksum: 0x5A74D6EE
	Offset: 0x4C8
	Size: 0x2DC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	clientfield::register("clientuimodel", "player_lives", 1, 2, "int", undefined, 0, 0);
	clientfield::register("world", "flicker_function_controller", 1, 1, "int", &function_1ed795b7, 0, 0);
	clientfield::register("world", "flicker_function_controller_persistant", 1, 1, "int", &function_93f4e0e6, 0, 0);
	level._effect[#"headshot"] = "zombie/fx_bul_flesh_head_fatal_zmb";
	level._effect[#"headshot_nochunks"] = "zombie/fx_bul_flesh_head_nochunks_zmb";
	level._effect[#"bloodspurt"] = "zombie/fx_bul_flesh_neck_spurt_zmb";
	level._effect[#"animscript_gib_fx"] = "zombie/fx_blood_torso_explo_zmb";
	level._effect[#"animscript_gibtrail_fx"] = "blood/fx_blood_gib_limb_trail";
	level._uses_default_wallbuy_fx = 1;
	level._uses_sticky_grenades = 1;
	level._uses_taser_knuckles = 1;
	level._power_on = 0;
	level.var_d0ab70a2 = #"hash_2ed6ad41883dc026";
	level.var_4016a739 = vectorscale((0, 1, 0), 90);
	load::main();
	level thread namespace_fada3c80::main();
	level thread setup_personality_character_exerts();
	exploder::exploder("lgt_vending_mulekick_on");
	util::waitforclient(0);
	level namespace_6a81d072::init_pentagon_box_screens();
	level thread pentagon_zpo_listener();
	level thread pentagon_tlo_listener();
	level thread function_b8da6f44();
}

/*
	Name: pbg_init
	Namespace: zm_office
	Checksum: 0xA0438288
	Offset: 0x7B0
	Size: 0x3C
	Parameters: 7
	Flags: None
*/
function pbg_init(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_63a0685c
	Namespace: zm_office
	Checksum: 0x135100B1
	Offset: 0x7F8
	Size: 0x3C
	Parameters: 7
	Flags: None
*/
function function_63a0685c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: function_1ed795b7
	Namespace: zm_office
	Checksum: 0x8D14CE26
	Offset: 0x840
	Size: 0xF4
	Parameters: 7
	Flags: Linked
*/
function function_1ed795b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(level._power_on == 0)
	{
		while(true)
		{
			exploder::stop_exploder("fxexp_script_boardroom_flicker");
			waitframe(1);
			exploder::exploder("fxexp_script_boardroom_flicker");
			wait(randomfloatrange(0.1, 0.5));
			exploder::stop_exploder("fxexp_script_boardroom_flicker");
			wait(randomfloatrange(0.025, 0.125));
		}
		wait(0.3);
	}
}

/*
	Name: function_93f4e0e6
	Namespace: zm_office
	Checksum: 0xB496561A
	Offset: 0x940
	Size: 0xF8
	Parameters: 7
	Flags: Linked
*/
function function_93f4e0e6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	while(true)
	{
		exploder::stop_exploder("fxexp_script_flicker_dim");
		waitframe(1);
		exploder::exploder("fxexp_script_flicker_always");
		wait(randomfloatrange(0.1, 0.5));
		exploder::exploder("fxexp_script_flicker_dim");
		waitframe(1);
		exploder::stop_exploder("fxexp_script_flicker_always");
		wait(randomfloatrange(0.025, 0.125));
	}
}

/*
	Name: pentagon_zpo_listener
	Namespace: zm_office
	Checksum: 0x5277A3D0
	Offset: 0xA40
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function pentagon_zpo_listener()
{
	while(true)
	{
		level waittill(#"zpo");
		level._power_on = 1;
		level notify(#"tlo");
	}
}

/*
	Name: pentagon_tlo_listener
	Namespace: zm_office
	Checksum: 0xE87C363E
	Offset: 0xA98
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function pentagon_tlo_listener()
{
	while(true)
	{
		level waittill(#"tlo");
		level notify(#"por0");
		level notify(#"por1");
		level notify(#"por2");
		level notify(#"por3");
		level notify(#"por4");
		level waittill(#"tlf");
		level notify(#"por0");
		level notify(#"por1");
		level notify(#"por2");
		level notify(#"por3");
		level notify(#"por4");
	}
}

/*
	Name: function_b8da6f44
	Namespace: zm_office
	Checksum: 0xA462C275
	Offset: 0xBC8
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
	Name: setup_personality_character_exerts
	Namespace: zm_office
	Checksum: 0x8E7D5F03
	Offset: 0xD28
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[5][#"playerbreathinsound"] = "vox_plr_5_exert_sniper_hold";
	level.exert_sounds[6][#"playerbreathinsound"] = "vox_plr_6_exert_sniper_hold";
	level.exert_sounds[7][#"playerbreathinsound"] = "vox_plr_7_exert_sniper_hold";
	level.exert_sounds[8][#"playerbreathinsound"] = "vox_plr_8_exert_sniper_hold";
	level.exert_sounds[5][#"playerbreathoutsound"] = "vox_plr_5_exert_sniper_exhale";
	level.exert_sounds[6][#"playerbreathoutsound"] = "vox_plr_6_exert_sniper_exhale";
	level.exert_sounds[7][#"playerbreathoutsound"] = "vox_plr_7_exert_sniper_exhale";
	level.exert_sounds[8][#"playerbreathoutsound"] = "vox_plr_8_exert_sniper_exhale";
	level.exert_sounds[5][#"playerbreathgaspsound"] = "vox_plr_5_exert_sniper_gasp";
	level.exert_sounds[6][#"playerbreathgaspsound"] = "vox_plr_6_exert_sniper_gasp";
	level.exert_sounds[7][#"playerbreathgaspsound"] = "vox_plr_7_exert_sniper_gasp";
	level.exert_sounds[8][#"playerbreathgaspsound"] = "vox_plr_8_exert_sniper_gasp";
	level.exert_sounds[5][#"meleeswipesoundplayer"] = "vox_plr_5_exert_punch_give";
	level.exert_sounds[6][#"meleeswipesoundplayer"] = "vox_plr_6_exert_punch_give";
	level.exert_sounds[7][#"meleeswipesoundplayer"] = "vox_plr_7_exert_punch_give";
	level.exert_sounds[8][#"meleeswipesoundplayer"] = "vox_plr_8_exert_punch_give";
}

