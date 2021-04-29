// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_48607e17;

/*
	Name: main
	Namespace: namespace_48607e17
	Checksum: 0xD001FC13
	Offset: 0x330
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function main()
{
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_96da6081();
		level thread function_9ea70701();
	}
	level thread function_63491fbd();
	level thread function_a3a23636();
	level.var_359223a8 = array(0, 1, 2, 3, 4);
}

/*
	Name: function_96da6081
	Namespace: namespace_48607e17
	Checksum: 0x62A4B74A
	Offset: 0x3E0
	Size: 0x344
	Parameters: 0
	Flags: Linked, Private
*/
private function function_96da6081()
{
	level flag::wait_till_any(array("power_on", "power_on1"));
	level.var_4687b0d0 = [];
	level.var_4687b0d0[0] = array(#"hash_41c5ef88d30a0d04");
	level.var_4687b0d0[1] = array(#"hash_77d26356e7772673");
	level.var_4687b0d0[2] = array(#"hash_5f2672545b99ea1a");
	level.var_4687b0d0[3] = array(#"hash_47c8e68ac1a558b9");
	level.var_4687b0d0[4] = array(#"hash_b75c49e9dcc7900", #"hash_3d4162f1d6598a06", #"hash_38da480a84b97bda", #"hash_21856919a8b0f180", #"hash_3a59c33cb06334", #"hash_27a3a2bb7b9f52c2", #"hash_1448f639d29f413e", #"hash_7e02a393e0c315fc");
	level.var_4687b0d0[5] = array(#"hash_1db1fecdc55a68dd");
	var_765617b7 = struct::get_array("s_roll");
	foreach(s_roll in var_765617b7)
	{
		s_roll.var_255658de = util::spawn_model(#"hash_376a0011f26a90aa", s_roll.origin, s_roll.angles);
		s_roll.s_unitrigger_stub = s_roll zm_unitrigger::create("", 64, &function_aba430c2);
	}
	var_b12143bd = struct::get("s_phono_roll");
	var_b12143bd.s_unitrigger_stub = var_b12143bd zm_unitrigger::create("", 64, &function_63c3fd24);
	level flag::init(#"hash_7ae1182e79a1d06e");
}

/*
	Name: function_aba430c2
	Namespace: namespace_48607e17
	Checksum: 0x4346D985
	Offset: 0x730
	Size: 0x154
	Parameters: 0
	Flags: Linked, Private
*/
private function function_aba430c2()
{
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(isplayer(var_88706ea7.activator) && isalive(var_88706ea7.activator) && !isdefined(var_88706ea7.activator.var_a3f51886))
		{
			break;
		}
	}
	var_88706ea7.activator playsound(#"hash_7e0e4a1fb470d18f");
	var_88706ea7.activator.var_a3f51886 = self.stub.related_parent.script_int;
	if(isdefined(self.stub.related_parent.var_255658de))
	{
		self.stub.related_parent.var_255658de delete();
	}
	zm_unitrigger::unregister_unitrigger(self.stub.related_parent.s_unitrigger_stub);
}

/*
	Name: function_63c3fd24
	Namespace: namespace_48607e17
	Checksum: 0xB7846ACF
	Offset: 0x890
	Size: 0x280
	Parameters: 0
	Flags: Linked, Private
*/
private function function_63c3fd24()
{
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(!isalive(var_88706ea7.activator))
		{
			continue;
		}
		if(level flag::get(#"hash_7ae1182e79a1d06e"))
		{
			continue;
		}
		e_player = var_88706ea7.activator;
		if(!isdefined(self.stub.related_parent.var_255658de) && isdefined(e_player.var_a3f51886))
		{
			self.stub.related_parent.var_255658de = util::spawn_model(#"hash_376a0011f26a90aa", self.stub.related_parent.origin, self.stub.related_parent.angles);
			self.stub.related_parent.var_255658de playsound(#"hash_343bf66b64f5830e");
			self.stub.related_parent.var_255658de thread function_f2d27140(e_player.var_a3f51886);
			self.stub.related_parent.var_255658de.var_a3f51886 = e_player.var_a3f51886;
			e_player.var_a3f51886 = undefined;
		}
		else if(isdefined(self.stub.related_parent.var_255658de))
		{
			self.stub.related_parent.var_255658de thread function_f2d27140(self.stub.related_parent.var_255658de.var_a3f51886);
		}
		else if(!(isdefined(e_player.var_57c1fd86) && e_player.var_57c1fd86))
		{
			self.stub.related_parent thread function_6aad582c(e_player);
		}
	}
}

/*
	Name: function_f2d27140
	Namespace: namespace_48607e17
	Checksum: 0x8345CE46
	Offset: 0xB18
	Size: 0x164
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f2d27140(var_6a87ce6d)
{
	self endon(#"death");
	self thread function_64834acd();
	level flag::set(#"hash_7ae1182e79a1d06e");
	self notify(#"hash_2b02b5a5a9af36e0");
	self notify(#"hash_44144f80f295a13f");
	self playsound(#"hash_7c91fa775c8a0134");
	self playloopsound(#"hash_2367dae4a69a4294");
	wait(1);
	if(isdefined(var_6a87ce6d))
	{
		self namespace_891c9bac::function_cf1e151c(level.var_4687b0d0[var_6a87ce6d]);
	}
	self notify(#"hash_53eb32eaa511640c");
	self stoploopsound();
	self playsound(#"hash_376eaa517cd09530");
	self thread function_ad05f6f3();
	level flag::clear(#"hash_7ae1182e79a1d06e");
}

/*
	Name: function_64834acd
	Namespace: namespace_48607e17
	Checksum: 0x2A186231
	Offset: 0xC88
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function function_64834acd()
{
	self notify("1a9a8d2140387a89");
	self endon("1a9a8d2140387a89");
	self endon(#"death");
	while(true)
	{
		self function_21a979f7();
		self waittill(#"hash_44144f80f295a13f");
	}
}

/*
	Name: function_21a979f7
	Namespace: namespace_48607e17
	Checksum: 0xC5B86A60
	Offset: 0xCF8
	Size: 0x9E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_21a979f7()
{
	self endon(#"hash_53eb32eaa511640c");
	while(true)
	{
		if(self.angles[0] < 360)
		{
			self.angles = self.angles + vectorscale((1, 0, 0), 360);
		}
		self rotatepitch(self.angles[0] + 180 * -1, 2);
		self waittill(#"rotatedone");
	}
}

/*
	Name: function_ad05f6f3
	Namespace: namespace_48607e17
	Checksum: 0xB0E25702
	Offset: 0xDA0
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ad05f6f3()
{
	self notify(#"hash_2b02b5a5a9af36e0");
	self endon(#"hash_2b02b5a5a9af36e0");
	self val::set(#"hash_4a35aca1f4d4f559", "takedamage", 1);
	self val::set(#"hash_4a35aca1f4d4f559", "allowdeath", 0);
	while(isdefined(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		if(isplayer(var_88706ea7.attacker))
		{
			break;
		}
	}
	playsoundatposition(#"hash_2cf59d6222de4f6f", self.origin);
	self delete();
}

/*
	Name: function_6aad582c
	Namespace: namespace_48607e17
	Checksum: 0x1A66D9F
	Offset: 0xEB8
	Size: 0x1E4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6aad582c(e_player)
{
	e_player endon_callback(&function_3741630d, #"disconnect");
	if(e_player namespace_48f3568::function_69e9e553(array(#"hash_3c0932fa55ee6e5b")))
	{
		var_59c8624c = #"hash_24f1e841c9ab0766";
	}
	else if(e_player namespace_48f3568::function_69e9e553(array(#"hash_5ebf024e1559c04a")))
	{
		var_59c8624c = #"hash_680df11406aaad0d";
	}
	else if(e_player namespace_48f3568::function_69e9e553(array(#"hash_4e8f51ec275a4a38")))
	{
		var_59c8624c = #"hash_14367bddc8694d4f";
	}
	else if(e_player namespace_48f3568::function_69e9e553(array(#"hash_515977e191d13967")))
	{
		var_59c8624c = #"hash_53875c52fa6301c0";
	}
	level flag::set(#"hash_7ae1182e79a1d06e");
	e_player playsoundtoplayer(var_59c8624c, e_player);
	wait(soundgetplaybacktime(var_59c8624c) * 0.001);
	e_player.var_57c1fd86 = 1;
	level flag::clear(#"hash_7ae1182e79a1d06e");
}

/*
	Name: function_3741630d
	Namespace: namespace_48607e17
	Checksum: 0x7F4DBC7C
	Offset: 0x10A8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_3741630d(var_c34665fc)
{
	level flag::clear(#"hash_7ae1182e79a1d06e");
}

/*
	Name: function_9ea70701
	Namespace: namespace_48607e17
	Checksum: 0x763EF434
	Offset: 0x10E0
	Size: 0x28E
	Parameters: 0
	Flags: Linked
*/
function function_9ea70701()
{
	var_56980742 = struct::get("s_int_t_c");
	var_56980742.var_690ea031 = array(#"hash_515977e191d13967");
	var_56980742.var_59c8624c = #"hash_4ff92627bab81ee4";
	var_56980742.s_unitrigger_stub = var_56980742 zm_unitrigger::create("", 64, &function_33864e5d);
	var_91f0b44f = struct::get("s_int_amu");
	var_91f0b44f.var_690ea031 = array(#"hash_515977e191d13967");
	var_91f0b44f.var_59c8624c = #"hash_502b8782f8b740c";
	var_91f0b44f.s_unitrigger_stub = var_91f0b44f zm_unitrigger::create("", 64, &function_33864e5d);
	var_fb14f184 = struct::get("s_int_n_p");
	var_fb14f184.var_690ea031 = array(#"hash_5ebf024e1559c04a");
	var_fb14f184.var_59c8624c = #"hash_7172cde1ce628720";
	var_fb14f184.s_unitrigger_stub = var_fb14f184 zm_unitrigger::create("", 64, &function_33864e5d);
	var_64dd4c0d = struct::get("s_int_a_p");
	var_64dd4c0d.var_690ea031 = array(#"hash_3c0932fa55ee6e5b");
	var_64dd4c0d.var_59c8624c = #"hash_26c5ceaa58dd1ddc";
	var_64dd4c0d.s_lookat = struct::get("s_int_a_p_lookat", "targetname");
	var_64dd4c0d.s_unitrigger_stub = var_64dd4c0d zm_unitrigger::create("", 64, &function_33864e5d);
}

/*
	Name: function_33864e5d
	Namespace: namespace_48607e17
	Checksum: 0xD12CD752
	Offset: 0x1378
	Size: 0x15C
	Parameters: 0
	Flags: Linked
*/
function function_33864e5d()
{
	s_interact = self.stub.related_parent;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		if(!isplayer(var_88706ea7.activator) || !isalive(var_88706ea7.activator))
		{
			continue;
		}
		else if(!var_88706ea7.activator namespace_48f3568::function_69e9e553(s_interact.var_690ea031))
		{
			continue;
		}
		else if(!isdefined(s_interact.s_lookat) || var_88706ea7.activator util::is_looking_at(s_interact.s_lookat.origin, 0.7))
		{
			var_88706ea7.activator thread namespace_891c9bac::function_a2bd5a0c(s_interact.var_59c8624c);
			break;
		}
	}
	zm_unitrigger::unregister_unitrigger(s_interact.s_unitrigger_stub);
}

/*
	Name: function_63491fbd
	Namespace: namespace_48607e17
	Checksum: 0x59CBE2FD
	Offset: 0x14E0
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_63491fbd()
{
	level endon(#"end_game");
	while(!(isdefined(level.var_9138a2) && level.var_9138a2))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"hash_356be6a8a0b0668d");
		e_player = var_88706ea7.activator;
		str_zone = e_player zm_zonemgr::get_player_zone();
		if(isdefined(str_zone) && str_zone != "zone_cemetery_path_left")
		{
			level.var_9138a2 = var_88706ea7.activator zm_audio::create_and_play_dialog(#"bench", #"hash_508ab5d518ddf87e", undefined, 1);
		}
	}
	level.var_9138a2 = undefined;
}

/*
	Name: function_a3a23636
	Namespace: namespace_48607e17
	Checksum: 0x991ADC6B
	Offset: 0x15F8
	Size: 0x39A
	Parameters: 0
	Flags: Linked
*/
function function_a3a23636()
{
	level endon(#"end_game");
	level flag::wait_till_any(array(#"power_on", #"power_on1", #"hash_2daf5bdda85cc660"));
	var_79bd8bd4 = getent("knight_model_cemetery", "targetname");
	var_38c25a0c = getent("knight_model_greenhouse", "targetname");
	while(!(isdefined(level.var_d2867f97) && level.var_d2867f97) && !level flag::get_all(array(#"knight_main_hall_stationed", #"knight_cemetery_stationed", #"knight_greenhouse_stationed")))
	{
		b_play_vo = 0;
		foreach(e_player in namespace_891c9bac::function_347f7d34())
		{
			if(!isdefined(e_player))
			{
				continue;
			}
			if(isdefined(var_79bd8bd4) && e_player util::is_player_looking_at(var_79bd8bd4.origin) && distance2dsquared(var_79bd8bd4.origin, e_player.origin) < 65536)
			{
				b_play_vo = 1;
			}
			else if(isdefined(var_38c25a0c) && e_player util::is_player_looking_at(var_38c25a0c.origin) && distance2dsquared(var_38c25a0c.origin, e_player.origin) < 65536)
			{
				b_play_vo = 1;
			}
			else if(isdefined(var_170ef705) && e_player util::is_player_looking_at(var_170ef705.origin) && distance2dsquared(var_170ef705.origin, e_player.origin) < 65536)
			{
				b_play_vo = 1;
			}
			if(b_play_vo && (!(isdefined(level.var_d2867f97) && level.var_d2867f97)))
			{
				level.var_d2867f97 = e_player namespace_891c9bac::function_a2bd5a0c(#"hash_4a084873bbb64d39", 0, 0, 9999);
			}
		}
		wait(1);
	}
	level.var_d2867f97 = undefined;
}

/*
	Name: function_90659e2c
	Namespace: namespace_48607e17
	Checksum: 0xF638E2E7
	Offset: 0x19A0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_90659e2c()
{
	level endon(#"end_game");
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_483503537a553500");
	if(isalive(var_88706ea7.e_player))
	{
		var_88706ea7.e_player zm_audio::create_and_play_dialog(#"hash_1b42d750b0cdab08", #"hash_508ab5d518ddf87e", undefined, 1);
	}
}

/*
	Name: function_eb112701
	Namespace: namespace_48607e17
	Checksum: 0xC80BFE5
	Offset: 0x1A48
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function function_eb112701()
{
	level endon(#"end_game");
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"bedroom_charged", #"library_charged", #"cellar_charged");
	var_65c9997c = undefined;
	switch(var_88706ea7._notify)
	{
		case "bedroom_charged":
		{
			var_65c9997c = getent("gazing_stone_main_hall", "targetname");
			break;
		}
		case "library_charged":
		{
			var_65c9997c = getent("gazing_stone_library", "targetname");
			break;
		}
		case "cellar_charged":
		{
			var_65c9997c = getent("gazing_stone_cellar", "targetname");
			break;
		}
	}
	e_closest_player = arraygetclosest(var_65c9997c.origin, getplayers());
	if(isalive(e_closest_player))
	{
		e_closest_player zm_audio::create_and_play_dialog(#"hash_1b42d750b0cdab08", #"active", undefined, 1);
	}
}

/*
	Name: function_6b5b1780
	Namespace: namespace_48607e17
	Checksum: 0x8060A9DB
	Offset: 0x1C00
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_6b5b1780()
{
	level endon(#"end_game");
	var_88706ea7 = undefined;
	var_88706ea7 = level waittill(#"hash_43aa2c21cf191318");
	if(isalive(var_88706ea7.e_player))
	{
		var_88706ea7.e_player zm_audio::create_and_play_dialog(#"hash_1b42d750b0cdab08", #"location", undefined, 1);
	}
}

/*
	Name: function_70c90053
	Namespace: namespace_48607e17
	Checksum: 0xCD80A98A
	Offset: 0x1CA8
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_70c90053()
{
	level endon(#"end_game");
	self endon(#"death", #"flag_gazing_stone_in_use");
	while(true)
	{
		wait(randomintrange(27, 31));
		e_closest_player = arraygetclosest(var_b5bcbba9, util::get_active_players(), 768);
		if(isalive(e_closest_player) && e_closest_player util::is_player_looking_at(var_b5bcbba9, 0.6, 0))
		{
			e_closest_player zm_audio::create_and_play_dialog(#"hash_1b42d750b0cdab08", #"nag", undefined, 1);
		}
	}
}

/*
	Name: function_e432aeb6
	Namespace: namespace_48607e17
	Checksum: 0x99B9245
	Offset: 0x1DF8
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function function_e432aeb6(str_category, var_39acfdda)
{
	if(level.var_359223a8.size)
	{
		var_a9de111d = array::random(level.var_359223a8);
		arrayremovevalue(level.var_359223a8, var_a9de111d);
		function_2d4ce142(var_a9de111d);
		return 1;
	}
	self.var_631a26f0[str_category][var_39acfdda] = undefined;
	return 0;
}

/*
	Name: function_2d4ce142
	Namespace: namespace_48607e17
	Checksum: 0x3F264D8B
	Offset: 0x1EA0
	Size: 0x1D2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2d4ce142(var_a9de111d)
{
	switch(var_a9de111d)
	{
		case 0:
		{
			zm_audio::play_vo_internal(#"hash_56d727e4dde061ef");
			zm_audio::play_vo_internal(#"hash_73722f29ea1fa41", self);
			break;
		}
		case 1:
		{
			zm_audio::play_vo_internal(#"hash_46c0fcd4eac3143a");
			zm_audio::play_vo_internal(#"hash_2fd88698209e1998", self);
			break;
		}
		case 2:
		{
			zm_audio::play_vo_internal(#"hash_6a18c9d5cea653d4", self);
			zm_audio::play_vo_internal(#"hash_21bcbc16a4e2812a");
			break;
		}
		case 3:
		{
			zm_audio::play_vo_internal(#"hash_19c3a28739527fc8");
			zm_audio::play_vo_internal(#"hash_c3c497c80eba90e", self);
			break;
		}
		case 4:
		{
			zm_audio::play_vo_internal(#"hash_5f99dba5a34a200b");
			zm_audio::play_vo_internal(#"hash_50bc3e7a02399bd5", self);
			break;
		}
	}
}

/*
	Name: function_c8d42aba
	Namespace: namespace_48607e17
	Checksum: 0xD9C6657B
	Offset: 0x2080
	Size: 0x34E
	Parameters: 2
	Flags: Linked
*/
function function_c8d42aba(str_category, var_39acfdda)
{
	a_e_players = util::get_players();
	if(a_e_players.size > 1)
	{
		var_a9de111d = randomint(5);
		switch(var_a9de111d)
		{
			case 0:
			{
				zm_audio::play_vo_internal(#"hash_39ad75c662ff40da");
				zm_audio::play_vo_internal(#"hash_25d195bb73a47af8", self);
				zm_audio::play_vo_internal(#"hash_39ad73c662ff3d74");
				zm_audio::play_vo_internal(#"hash_25d197bb73a47e5e", self);
				break;
			}
			case 1:
			{
				zm_audio::play_vo_internal(#"hash_2c15b9198408b36e", self);
				zm_audio::play_vo_internal(#"hash_559c2e4e451d15dc");
				zm_audio::play_vo_internal(#"hash_2c15b7198408b008", self);
				break;
			}
			case 2:
			{
				zm_audio::play_vo_internal(#"hash_7024e5a861250e68");
				zm_audio::play_vo_internal(#"hash_2d116afa2223e9ee", self);
				zm_audio::play_vo_internal(#"hash_7024e7a8612511ce");
				zm_audio::play_vo_internal(#"hash_2d1168fa2223e688", self);
				break;
			}
			case 3:
			{
				zm_audio::play_vo_internal(#"hash_3682a6259c85c134", self);
				zm_audio::play_vo_internal(#"hash_6dc330df77b075ca");
				zm_audio::play_vo_internal(#"hash_3682a8259c85c49a", self);
				zm_audio::play_vo_internal(#"hash_6dc32edf77b07264");
				break;
			}
			case 4:
			{
				zm_audio::play_vo_internal(#"hash_1f01c37f559d0216");
				zm_audio::play_vo_internal(#"hash_663346a99e3bdffc", self);
				zm_audio::play_vo_internal(#"hash_1f01c17f559cfeb0");
				zm_audio::play_vo_internal(#"hash_663348a99e3be362", self);
				break;
			}
		}
	}
	return 1;
}

/*
	Name: function_4928382a
	Namespace: namespace_48607e17
	Checksum: 0x705C421C
	Offset: 0x23D8
	Size: 0xC0
	Parameters: 2
	Flags: Linked
*/
function function_4928382a(str_category, var_39acfdda)
{
	a_e_players = util::get_players();
	if(a_e_players.size > 1)
	{
		var_e04d003f = self namespace_48f3568::function_d35e4c92();
		str_vo = "vox_revive_down_plr_" + var_e04d003f + "_" + randomint(4);
		self zm_audio::play_vo_internal(hash(str_vo));
	}
	return 1;
}

/*
	Name: function_658ce256
	Namespace: namespace_48607e17
	Checksum: 0x15B8DEF5
	Offset: 0x24A0
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_658ce256(str_category, var_39acfdda)
{
	if(math::cointoss(16))
	{
		zm_audio::play_vo_internal(#"hash_781c84d22590fba6");
		zm_audio::play_vo_internal(#"hash_6a2a0c62daaff8ac", self);
		return 1;
	}
	return 0;
}

/*
	Name: function_df8a01f3
	Namespace: namespace_48607e17
	Checksum: 0x85FE5116
	Offset: 0x2520
	Size: 0x176
	Parameters: 0
	Flags: Linked
*/
function function_df8a01f3()
{
	self endon(#"death");
	if(!level flag::get("boss_fight_started"))
	{
		switch(level.round_number)
		{
			case 1:
			{
				self namespace_891c9bac::function_8e0f4696("vox_solo_game_start_0_butd_0", 0, 1, 9999);
				self namespace_891c9bac::function_8e0f4696("vox_solo_game_start_1_plr_12_0", 0, 1, 9999);
				break;
			}
			case 2:
			{
				self namespace_891c9bac::function_8e0f4696("vox_solo_end_round1_0_plr_12_0", 0, 1, 9999);
				self namespace_891c9bac::function_8e0f4696("vox_solo_end_round1_1_butd_0", 0, 1, 9999);
				break;
			}
			case 3:
			{
				self namespace_891c9bac::function_8e0f4696("vox_solo_end_round2_0_plr_12_0", 0, 1, 9999);
				self namespace_891c9bac::function_8e0f4696("vox_solo_end_round2_1_butd_0", 0, 1, 9999);
				break;
			}
		}
	}
	return 1;
}

/*
	Name: function_edae33b5
	Namespace: namespace_48607e17
	Checksum: 0xDAC4BFAF
	Offset: 0x26A0
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_edae33b5(str_category, var_39acfdda)
{
	if(math::cointoss(16))
	{
		zm_audio::play_vo_internal(#"hash_41b1b4aa63697b30", self);
		return 1;
	}
	return 0;
}

/*
	Name: function_fe8cce7a
	Namespace: namespace_48607e17
	Checksum: 0xBA053010
	Offset: 0x2708
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_fe8cce7a(str_category, var_39acfdda)
{
	if(math::cointoss(16))
	{
		zm_audio::play_vo_internal(#"hash_5356fdb821d6dedd");
		zm_audio::play_vo_internal(#"hash_10335b450c3f5187", self);
		return 1;
	}
	return 0;
}

/*
	Name: function_bb1888fe
	Namespace: namespace_48607e17
	Checksum: 0x749CC7D3
	Offset: 0x2788
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_bb1888fe(str_category, var_39acfdda)
{
	if(math::cointoss(25))
	{
		zm_audio::play_vo_internal(#"hash_f5f0d56fe254796");
		zm_audio::play_vo_internal(#"hash_48710f792a0c297c", self);
		return 1;
	}
	return 0;
}

/*
	Name: function_f26d178f
	Namespace: namespace_48607e17
	Checksum: 0xC028F3C0
	Offset: 0x2808
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_f26d178f(str_category, var_39acfdda)
{
	if(math::cointoss(16))
	{
		zm_audio::play_vo_internal(#"hash_23048fd6c52dd964");
		zm_audio::play_vo_internal(#"hash_5d5ef2b48b533f2", self);
		return 1;
	}
	return 0;
}

/*
	Name: function_1f4ab5ec
	Namespace: namespace_48607e17
	Checksum: 0xF9AA8192
	Offset: 0x2888
	Size: 0xFA
	Parameters: 2
	Flags: Linked
*/
function function_1f4ab5ec(str_category, var_39acfdda)
{
	n_chance = randomint(10);
	if(n_chance == 3 || n_chance == 4)
	{
		switch(n_chance)
		{
			case 3:
			{
				zm_audio::play_vo_internal(#"hash_2b910762865b2884");
				zm_audio::play_vo_internal(#"hash_d705a0e5a2a79d2", self);
				break;
			}
			case 4:
			{
				zm_audio::play_vo_internal(#"hash_c27975b04cf4e48", self);
				break;
			}
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_a3a92098
	Namespace: namespace_48607e17
	Checksum: 0xC234F167
	Offset: 0x2990
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_a3a92098()
{
	level endon(#"hash_5c0a5172c4d5bee7");
	self endon(#"death");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = var_39ef2390 waittill(#"trigger");
		if(isalive(var_88706ea7.activator) && var_88706ea7.activator === self)
		{
			self thread zm_audio::create_and_play_dialog(#"hash_20b463357f4ae8f", #"hash_127ec0f7c94323e");
			level notify(#"hash_5c0a5172c4d5bee7");
			callback::remove_on_spawned(&function_a3a92098);
			return;
		}
		wait(2);
	}
}

