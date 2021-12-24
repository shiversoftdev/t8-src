// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2fcb47e3735a6edd;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_52c6c2d1a2ef1b46;
#using script_58c342edd81589fb;
#using script_5e177698fdcdbe2c;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_d19b1fbf1d7cdd6;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_challenges.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_4b68b2b3;

/*
	Name: preload
	Namespace: namespace_4b68b2b3
	Checksum: 0x8817B212
	Offset: 0x280
	Size: 0x214
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_617a54f4::function_d8383812(#"sc_pap_beach", 24000, "sc_pap_beach", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_boathouse", 24000, "sc_pap_boathouse", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_ship", 24000, "sc_pap_ship", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_lagoon", 24000, "sc_pap_lagoon", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"sc_pap_island", 24000, "sc_pap_island", &function_8598f0d4, &function_3bdbb583, 1);
	clientfield::register("scriptmover", "" + #"hash_411947cf11cffb69", 24000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_249c83f6060ea7ba", 24000, 1, "int");
}

/*
	Name: main
	Namespace: namespace_4b68b2b3
	Checksum: 0x7B82BE4D
	Offset: 0x4A0
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"hash_7b6c32b9937aee62");
	level flag::init(#"hash_11d64d1f93c196cc");
	level flag::init(#"hash_4898001eb77cb16f");
	level flag::init(#"hash_5266a594b96823e2");
	level flag::init(#"hash_1d9afa9be4c10160");
	var_dc3827e3 = getentarray("lockdown_lighthouse", "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		e_blocker notsolid();
	}
	level.var_d7374603 = 0;
	level.var_3089454f = getentarray("mq_pap_vessel", "targetname");
	foreach(var_8ac20606 in level.var_3089454f)
	{
		var_8ac20606 hide();
	}
}

/*
	Name: function_1faf4b9
	Namespace: namespace_4b68b2b3
	Checksum: 0x63068BE5
	Offset: 0x698
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_1faf4b9(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		namespace_85e029d3::register_drop_off(15, #"hash_59c4b1052b566fa1", #"hash_28356be4df0c611f", &function_9af4e8bd);
		level.pablo_npc.var_cb3ed98f[15].var_80080852 = 1;
		namespace_85e029d3::function_d83490c5(15);
		level flag::wait_till(#"hash_7b6c32b9937aee62");
		function_a22b0de4();
	}
}

/*
	Name: function_a8748143
	Namespace: namespace_4b68b2b3
	Checksum: 0x46779D03
	Offset: 0x768
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_a8748143(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		function_a37c10dc();
		level flag::set(#"hash_11d64d1f93c196cc");
	}
}

/*
	Name: function_91fbb734
	Namespace: namespace_4b68b2b3
	Checksum: 0xAB0F5917
	Offset: 0x7D0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_91fbb734(var_5ea5c94d)
{
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 6);
	if(!var_5ea5c94d)
	{
		level waittill(#"hash_5266a594b96823e2");
		level waittill(#"hash_11d64d1f93c196cc");
	}
}

/*
	Name: function_c2898bf0
	Namespace: namespace_4b68b2b3
	Checksum: 0x71EFDF3F
	Offset: 0x848
	Size: 0xA4
	Parameters: 2
	Flags: Linked
*/
function function_c2898bf0(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_4898001eb77cb16f");
		level flag::set(#"hash_5266a594b96823e2");
		level flag::set(#"hash_11d64d1f93c196cc");
	}
	level flag::set(#"hash_5266a594b96823e2");
}

/*
	Name: function_816c3132
	Namespace: namespace_4b68b2b3
	Checksum: 0x59E9708D
	Offset: 0x8F8
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_816c3132(var_5ea5c94d)
{
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 9);
	if(!var_5ea5c94d)
	{
		if(!isdefined(level.var_4d8e32c8))
		{
			level.var_4d8e32c8 = [];
		}
		else if(!isarray(level.var_4d8e32c8))
		{
			level.var_4d8e32c8 = array(level.var_4d8e32c8);
		}
		level.var_4d8e32c8[level.var_4d8e32c8.size] = level.var_9d121dce;
		level flag::clear(#"hash_5266a594b96823e2");
		while(level.var_98138d6b < 3)
		{
			wait(1);
		}
		level flag::set(#"hash_3028604821838259");
		level flag::set(#"hash_1d9afa9be4c10160");
		level thread namespace_44916ada::function_56db9cdc();
		level.var_1c53964e thread namespace_509a75d1::function_6a0d675d(#"hash_17b44ac72ae4b92f", -1, 0, 1);
		level thread function_8c273b51();
		while(!namespace_509a75d1::any_player_in_zone(array("ice_floe")))
		{
			waitframe(1);
		}
		level.var_b2b15659 = 1;
		namespace_3263198e::function_fd24e47f(#"hash_56bc0447e6f4c9bf", -1, 1, 1);
		level waittill(#"hash_5266a594b96823e2");
	}
}

/*
	Name: function_e0dfc80f
	Namespace: namespace_4b68b2b3
	Checksum: 0x80F724D1
	Offset: 0xB30
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function function_e0dfc80f()
{
}

/*
	Name: function_3c9be590
	Namespace: namespace_4b68b2b3
	Checksum: 0x18A32317
	Offset: 0xB40
	Size: 0x15C
	Parameters: 2
	Flags: Linked
*/
function function_3c9be590(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level.var_50b3f446 = 1;
		level notify(#"hash_5266a594b96823e2");
		level.var_b2b15659 = 1;
	}
	foreach(s_challenge_station in level.var_23b90682)
	{
		s_challenge_station.var_3c4b2051 = 0;
		s_challenge_station namespace_86eed980::function_fd8a137e();
	}
	level flag::clear(#"hash_3028604821838259");
	namespace_509a75d1::function_314447b(1, 0);
	level flag::set(#"disable_special_rounds");
	namespace_bfc8ee03::spawn_guide();
	namespace_d09ff23c::function_da304f6e(0);
}

/*
	Name: function_9af4e8bd
	Namespace: namespace_4b68b2b3
	Checksum: 0x788413DB
	Offset: 0xCA8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_9af4e8bd()
{
	level flag::set(#"hash_7b6c32b9937aee62");
}

/*
	Name: function_a22b0de4
	Namespace: namespace_4b68b2b3
	Checksum: 0xAD1C8B95
	Offset: 0xCD8
	Size: 0x77C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_a22b0de4()
{
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	namespace_85e029d3::function_b9e15919(1);
	level.musicsystemoverride = 1;
	music::setmusicstate("lighthouse_defend");
	var_d1ec2571 = level.round_number + 1;
	var_898a45da = level.var_45827161[var_d1ec2571];
	if(isdefined(var_898a45da))
	{
		namespace_c3287616::function_43aed0ca(var_d1ec2571);
	}
	level.var_eacf25e4 = level.func_get_delay_between_rounds;
	level.func_get_delay_between_rounds = &function_f85d3d98;
	namespace_509a75d1::function_2ba419ee(0);
	var_dc3827e3 = getentarray("lockdown_lighthouse", "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		e_blocker solid();
	}
	exploder::exploder("fxexp_forcefield_door_lighthouse_lvl_4");
	level flag::set(#"infinite_round_spawning");
	wait(30);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(30);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(30);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(10);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(10);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(10);
	level flag::clear(#"infinite_round_spawning");
	level.func_get_delay_between_rounds = level.var_eacf25e4;
	level.musicsystemoverride = 0;
	music::setmusicstate("none");
	namespace_509a75d1::function_314447b(1, 1);
	var_dc3827e3 = getentarray("lockdown_lighthouse", "targetname");
	foreach(e_blocker in var_dc3827e3)
	{
		e_blocker notsolid();
	}
	exploder::exploder_stop("fxexp_forcefield_door_lighthouse_lvl_4");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	namespace_85e029d3::function_3f9e02b8(8, #"hash_3be823a04b5cca2d", #"hash_25cb84d1af883c53", &function_a37c10dc);
	namespace_85e029d3::function_d83490c5(8);
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	wait(10);
	namespace_509a75d1::function_314447b(0);
}

/*
	Name: function_f85d3d98
	Namespace: namespace_4b68b2b3
	Checksum: 0x7AA36B0F
	Offset: 0x1460
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_f85d3d98()
{
	return 0;
}

/*
	Name: function_a37c10dc
	Namespace: namespace_4b68b2b3
	Checksum: 0x4717C412
	Offset: 0x1470
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_a37c10dc()
{
	level.var_f6f7a368 = 0;
	arrayremoveindex(level.var_4d8e32c8, 4);
	level flag::set(#"hash_4898001eb77cb16f");
	level flag::set(#"hash_11d64d1f93c196cc");
	level notify(#"hash_39b6629ce957cce9");
}

/*
	Name: function_3f15613f
	Namespace: namespace_4b68b2b3
	Checksum: 0xFF1ABB6A
	Offset: 0x1500
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function function_3f15613f()
{
	if(level flag::get(#"hash_11d64d1f93c196cc") && (!(isdefined(self.stub.pap_machine.var_b6d21cc2) && self.stub.pap_machine.var_b6d21cc2)))
	{
		str_prompt = zm_utility::function_d6046228(#"hash_546b9ae85f7a9448", #"hash_38d87fd576702a44");
		self sethintstring(str_prompt);
		return 1;
	}
	str_prompt = "";
	self sethintstring(str_prompt);
	return 0;
}

/*
	Name: function_dc380897
	Namespace: namespace_4b68b2b3
	Checksum: 0xE20BE39
	Offset: 0x15F0
	Size: 0x92C
	Parameters: 0
	Flags: Linked
*/
function function_dc380897()
{
	level endon(#"game_end");
	self flag::clear("pap_waiting_for_user");
	foreach(vessel in level.var_3089454f)
	{
		if(vessel.script_noteworthy === self.script_noteworthy)
		{
			self.vessel = vessel;
		}
	}
	waitresult = undefined;
	waitresult = self waittill(#"trigger_activated");
	player = waitresult.e_who;
	if(level.var_d7374603 == 0)
	{
		player thread namespace_3263198e::function_51b752a9(#"hash_abba1937c744399", -1, 0, 1);
	}
	else if(level.var_d7374603 == 3)
	{
		player thread namespace_3263198e::function_51b752a9(#"hash_549030026224cbce", -1, 0, 1);
	}
	else if(level.var_d7374603 == 4)
	{
		player thread namespace_3263198e::function_51b752a9(#"hash_103075d32e77e799", -1, 0, 1);
	}
	level flag::clear(#"hash_11d64d1f93c196cc");
	self thread function_d584f1a8();
	self.vessel show();
	self.vessel playsound("zmb_vessel_drop");
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", level.var_ed1e7d4d);
	self.vessel.var_b5dea2fc = self.vessel.origin;
	self.vessel playsound(#"hash_8655fa14e357e9a");
	self.vessel playloopsound(#"hash_3c00e3a927df9b2e");
	var_deb6871b = struct::get(self.vessel.target, "targetname");
	self.vessel moveto(var_deb6871b.origin, 1.5);
	self.vessel waittill(#"movedone");
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", 0);
	var_deb6871b.var_7944be4a = 0;
	switch(getplayers().size)
	{
		case 1:
		{
			var_deb6871b.n_souls_required = 20;
			break;
		}
		case 2:
		{
			var_deb6871b.n_souls_required = 40;
			break;
		}
		case 3:
		case 4:
		{
			var_deb6871b.n_souls_required = 80;
			break;
		}
	}
	var_deb6871b.var_b9989e12 = hash(var_deb6871b.script_noteworthy);
	namespace_617a54f4::function_3f808d3d(var_deb6871b.var_b9989e12);
	level flag::set(#"infinite_round_spawning");
	var_deb6871b waittill(#"hash_1f9b852104ab2c13");
	/#
		if(getdvarint(#"hash_11ad6a9695943217", 0))
		{
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	self.var_b6d21cc2 = 1;
	pos = (var_deb6871b.origin + (anglestoforward(var_deb6871b.angles) * 14)) + vectorscale((0, 0, 1), 4);
	self.e_fire = spawn("script_model", pos);
	self.e_fire.angles = var_deb6871b.angles + vectorscale((0, 1, 0), 90);
	self.e_fire setmodel("tag_origin");
	self.e_fire clientfield::set("" + #"hash_249c83f6060ea7ba", 1);
	self.vessel clientfield::set("" + #"hash_411947cf11cffb69", 1);
	self.e_fire playsound(#"hash_49156c17a247721c");
	arrayremovevalue(level.var_4d8e32c8, self);
	if(!level flag::get(#"hash_3028604821838259"))
	{
		wait(1);
		level notify(#"hash_39b6629ce957cce9");
		self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", level.var_ed1e7d4d);
		self.vessel moveto(self.vessel.var_b5dea2fc, 0.5);
		self.vessel playsound(#"hash_1ae6116ea0aa080f");
		self.vessel stoploopsound();
		wait(0.5);
		self.vessel zm_unitrigger::function_fac87205(zm_utility::function_d6046228(#"hash_3be823a04b5cca2d", #"hash_25cb84d1af883c53"), 64);
		self.vessel playsound(#"zmb_vessel_pickup");
		if(level.var_d7374603 == 1)
		{
			player thread namespace_3263198e::function_51b752a9(#"hash_4de6e4f76ebb0c43", -1, 0, 1);
		}
		else if(level.var_d7374603 == 4)
		{
			player thread namespace_3263198e::function_51b752a9(#"hash_2fbc5c784ba782b6", -1, 0, 1);
		}
		arrayremovevalue(level.var_3089454f, self.vessel);
		self.vessel delete();
		level flag::set(#"hash_11d64d1f93c196cc");
	}
	else
	{
		arrayremovevalue(level.var_3089454f, self.vessel);
		self.vessel delete();
	}
}

/*
	Name: function_3177f73c
	Namespace: namespace_4b68b2b3
	Checksum: 0x6D45B9B1
	Offset: 0x1F28
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function function_3177f73c()
{
	if(!isdefined(self.unitrigger_stub.var_b8237333))
	{
		self.unitrigger_stub.var_b8237333 = self.prompt_and_visibility_func;
	}
	if(!isdefined(self.var_5faaa732))
	{
		self.unitrigger_stub.var_5faaa732 = self.trigger_func;
	}
	self.unitrigger_stub.prompt_and_visibility_func = &function_3f15613f;
	self.unitrigger_stub.trigger_func = &zm_unitrigger::function_69168e61;
	zm_unitrigger::reregister_unitrigger(self.unitrigger_stub);
	self.unitrigger_stub.related_parent = self;
	self thread function_dc380897();
}

/*
	Name: function_d584f1a8
	Namespace: namespace_4b68b2b3
	Checksum: 0x18E4CAFB
	Offset: 0x2008
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_d584f1a8()
{
	for(i = 0; i < self getnumzbarrierpieces(); i++)
	{
		self hidezbarrierpiece(i);
	}
	self showzbarrierpiece(1);
	self setzbarrierpiecestate(1, "opening");
	self showzbarrierpiece(2);
	self setzbarrierpiecestate(2, "opening");
}

/*
	Name: function_8598f0d4
	Namespace: namespace_4b68b2b3
	Checksum: 0x98E0687B
	Offset: 0x20D0
	Size: 0xC2
	Parameters: 2
	Flags: Linked
*/
function function_8598f0d4(var_88206a50, ent)
{
	b_killed_by_player = isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor));
	var_a743812b = b_killed_by_player && distance(ent.origin, var_88206a50.origin) < 500;
	return var_a743812b;
}

/*
	Name: function_3bdbb583
	Namespace: namespace_4b68b2b3
	Checksum: 0xC2FA0674
	Offset: 0x21A0
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_3bdbb583(var_f0e6c7a2, ent)
{
	var_f0e6c7a2.var_7944be4a++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			var_f0e6c7a2.var_7944be4a = var_f0e6c7a2.n_souls_required;
		}
	#/
	if(var_f0e6c7a2.var_7944be4a >= var_f0e6c7a2.n_souls_required)
	{
		var_f0e6c7a2 function_a66f0de2();
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_4b68b2b3
	Checksum: 0x2417BEFC
	Offset: 0x2240
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_a66f0de2()
{
	namespace_617a54f4::function_2a94055d(self.var_b9989e12);
	level.var_d7374603++;
	self notify(#"hash_1f9b852104ab2c13");
	level flag::clear(#"infinite_round_spawning");
	if(level.var_d7374603 > 3)
	{
		level flag::set(#"hash_5266a594b96823e2");
		namespace_d09ff23c::function_da304f6e(0);
	}
}

/*
	Name: function_8c273b51
	Namespace: namespace_4b68b2b3
	Checksum: 0x88924818
	Offset: 0x22F0
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_8c273b51()
{
	level endon(#"end_game", #"hash_5266a594b96823e2");
	while(true)
	{
		if(namespace_509a75d1::any_player_in_zone("lighthouse_level_4") && level.pablo_npc zm_audio::function_65e5c19a())
		{
			level namespace_85e029d3::function_e44c7c0c(#"hash_17b44ac72ae4b92f");
			break;
		}
		wait(1);
	}
}

