// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\hud_message_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\gametypes\globallogic_audio.gsc;
#using scripts\zm_common\util.gsc;

#namespace hud_message;

/*
	Name: init
	Namespace: hud_message
	Checksum: 0xB482748E
	Offset: 0xA8
	Size: 0x272
	Parameters: 0
	Flags: Linked
*/
function init()
{
	game.strings[#"draw"] = #"hash_18114ebf7e352c55";
	game.strings[#"round_draw"] = #"hash_68d9a667406d9e2e";
	game.strings[#"round_win"] = #"hash_3f72c8cf61961fb2";
	game.strings[#"round_loss"] = #"hash_70e6b03f0ea9b11d";
	game.strings[#"victory"] = #"hash_31e1e88e88ba263f";
	game.strings[#"defeat"] = #"hash_141c79e0a2e1383e";
	game.strings[#"game_over"] = #"hash_ddc319addc8bcb2";
	game.strings[#"halftime"] = #"hash_4403919077b48aaf";
	game.strings[#"overtime"] = #"hash_19d325d8d1bfd3de";
	game.strings[#"roundend"] = #"hash_62af47ae5592dbf8";
	game.strings[#"intermission"] = #"hash_24bb668f17a9cc67";
	game.strings[#"side_switch"] = #"hash_54b0f0ec952ddba8";
	game.strings[#"match_bonus"] = #"mp/match_bonus_is";
}

