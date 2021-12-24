// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1c72973fb240f263;
#using script_57f7003580bb15e0;
#using script_6a3f43063dfd1bdc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_cc08081f;

/*
	Name: init
	Namespace: namespace_cc08081f
	Checksum: 0xEC44B9A
	Offset: 0x3B0
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level flag::init(#"hash_398e4b1e72edb4ee");
	if(zm_utility::function_e51dc2d8())
	{
		level thread function_f0e98e5f();
		level thread function_ac06ab3a();
		level thread function_9e497c58();
		level thread function_f339b159();
		level thread function_d38b59bb();
	}
}

/*
	Name: function_f339b159
	Namespace: namespace_cc08081f
	Checksum: 0x5FCB4735
	Offset: 0x468
	Size: 0x1EC
	Parameters: 0
	Flags: Linked
*/
function function_f339b159()
{
	level.var_389d1b12 = 0;
	level.var_5a599dbf = struct::get_array("punch_card_trigger", "targetname");
	foreach(var_4239616e in level.var_5a599dbf)
	{
		var_4239616e.is_collected = 0;
		var_4239616e.var_453ce50f = getent(var_4239616e.target, "targetname");
		s_unitrigger = var_4239616e zm_unitrigger::create("", 64);
		var_4239616e thread function_c7d4845();
	}
	level.var_b53764f7 = 0;
	level.var_af224340 = getent("punch_card_screen", "targetname");
	level.var_af224340 hide();
	level thread function_19daa1b1();
	level flag::init(#"hash_7b2be1fafb5f35c7");
	level.var_da4b53f8 = getent("punch_card_anim", "targetname");
	level.var_da4b53f8 hide();
}

/*
	Name: function_c7d4845
	Namespace: namespace_cc08081f
	Checksum: 0x1931D415
	Offset: 0x660
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_c7d4845()
{
	while(!self.is_collected)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		e_who playsound("evt_punch_card_pickup");
		if(math::cointoss())
		{
			e_who thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
		}
		level.var_389d1b12 = level.var_389d1b12 + 1;
		self.is_collected = 1;
		self.var_453ce50f delete();
	}
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
}

/*
	Name: function_445e3d3d
	Namespace: namespace_cc08081f
	Checksum: 0xABA2BE94
	Offset: 0x770
	Size: 0x120
	Parameters: 0
	Flags: Linked
*/
function function_445e3d3d()
{
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		if(level.var_b53764f7 < level.var_389d1b12)
		{
			level.var_da4b53f8 function_7a70f281();
			wait(3);
			level.var_b53764f7 = level.var_b53764f7 + 1;
			/#
				iprintlnbold("" + level.var_b53764f7);
			#/
			namespace_509a75d1::function_e308175e((#"hash_6b6fadebd260d209" + level.var_b53764f7) + "_sfx", self.origin);
			/#
				iprintlnbold("");
			#/
		}
	}
}

/*
	Name: function_19daa1b1
	Namespace: namespace_cc08081f
	Checksum: 0x7129EECB
	Offset: 0x898
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_19daa1b1()
{
	level flag::wait_till("power_on1");
	level.var_af224340 show();
	var_acb5313f = struct::get("punch_card_computer_trigger", "targetname");
	s_unitrigger = var_acb5313f zm_unitrigger::create("", 64);
	var_acb5313f thread function_445e3d3d();
}

/*
	Name: function_7a70f281
	Namespace: namespace_cc08081f
	Checksum: 0x5CF27C20
	Offset: 0x948
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function function_7a70f281()
{
	self show();
	v_starting_origin = self.origin;
	var_5287d229 = self.angles;
	v_forward = anglestoforward(self.angles);
	wait(0.5);
	self playsound("evt_punch_card_insert");
	self moveto(self.origin + (v_forward * -14), 3);
	wait(1);
	level flag::set(#"hash_7b2be1fafb5f35c7");
	self waittill(#"movedone");
	self hide();
	self.origin = v_starting_origin;
	self.angles = var_5287d229;
	level flag::clear(#"hash_7b2be1fafb5f35c7");
}

/*
	Name: function_9e497c58
	Namespace: namespace_cc08081f
	Checksum: 0x4B918C1C
	Offset: 0xA98
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_9e497c58()
{
	var_96fdae0e = struct::get_array("hail_base", "targetname");
	level.var_bcc5a3a8 = [];
	foreach(var_f711229a in var_96fdae0e)
	{
		var_f711229a.var_8dd6242b = randomintrange(0, 5);
		var_f711229a.n_station = randomintrange(0, 5);
		while(var_f711229a.var_8dd6242b == var_f711229a.n_station)
		{
			var_f711229a.n_station = randomintrange(0, 5);
		}
		var_f711229a.is_active = 0;
		var_f711229a.is_complete = 0;
		var_f711229a.scene = struct::get(var_f711229a.target, "targetname");
		var_f711229a.var_808cd5ad = var_f711229a.n_station;
		var_f711229a.scene scene::play("idle_off_" + var_f711229a.n_station);
		var_f711229a.scene flagsys::wait_till(#"scene_ents_ready");
		var_f711229a.var_21da1bbc = var_f711229a.scene.scene_ents[#"hash_7aff0ee60ddd937b"];
		var_f711229a.scene.var_eb397f67 = var_f711229a.var_21da1bbc gettagorigin("tag_tuner_knob");
		level.var_96fdae0e[var_f711229a.script_int] = var_f711229a;
	}
	level function_a7f8aee6();
}

/*
	Name: function_a7f8aee6
	Namespace: namespace_cc08081f
	Checksum: 0xB8991D2E
	Offset: 0xD10
	Size: 0x146
	Parameters: 0
	Flags: Linked
*/
function function_a7f8aee6()
{
	for(i = 0; i < level.var_96fdae0e.size; i++)
	{
		level.var_96fdae0e[i].is_active = 1;
		level.var_96fdae0e[i].scene scene::play("idle_on_" + string(level.var_96fdae0e[i].n_station));
		s_unitrigger = level.var_96fdae0e[i] zm_unitrigger::create("", 96);
		level.var_96fdae0e[i] thread function_22393009();
		while(!level.var_96fdae0e[i].is_complete)
		{
			wait(1);
		}
		/#
			iprintlnbold("" + i);
		#/
	}
}

/*
	Name: function_22393009
	Namespace: namespace_cc08081f
	Checksum: 0xAF66E64B
	Offset: 0xE60
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_22393009()
{
	while(self.is_active && !self.is_complete)
	{
		var_2dc7965c = self.n_station;
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger_activated");
		e_who = var_be17187b.e_who;
		b_using = 1;
		var_ee23f17d = 1;
		if(self.n_station == 5)
		{
			var_ee23f17d = 0;
		}
		var_5f67ea2f = 0;
		if(e_who function_626095c1(self.scene))
		{
			if(self.n_station > 0)
			{
				self.n_station = self.n_station - 1;
				self.scene thread scene::play("backward_to_" + string(self.n_station));
			}
		}
		else if(self.n_station < 5)
		{
			self.n_station = self.n_station + 1;
			self.scene thread scene::play("forward_to_" + string(self.n_station));
		}
		self.scene.var_a64d570 = self.n_station;
		if(self.n_station === self.var_8dd6242b)
		{
			self.is_complete = 1;
		}
	}
	namespace_509a75d1::function_e308175e((#"hash_418aee32f9446941" + (self.script_int + 1)) + "_sfx", self.origin);
}

/*
	Name: function_626095c1
	Namespace: namespace_cc08081f
	Checksum: 0xDCCEC05B
	Offset: 0x1078
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_626095c1(object)
{
	v_origin = object.origin;
	if(isdefined(object.var_eb397f67))
	{
		v_origin = object.var_eb397f67;
	}
	v_delta = vectornormalize(self geteye() - v_origin);
	v_view = anglestoforward(self getplayerangles());
	v_cross = vectorcross(v_view, v_delta);
	var_35b81369 = vectordot(v_cross, anglestoup(object.angles));
	if(var_35b81369 >= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_f0e98e5f
	Namespace: namespace_cc08081f
	Checksum: 0xADD96B09
	Offset: 0x11A8
	Size: 0x1F0
	Parameters: 0
	Flags: Linked
*/
function function_f0e98e5f()
{
	level.var_65d94f2 = struct::get_array(#"hash_508091eba85fdf0a");
	foreach(var_9b5d57b6 in level.var_65d94f2)
	{
		var_9b5d57b6 function_488e39dc();
	}
	level.var_cb8f67c9 = struct::get_array(#"hash_550885c44d3cde5e");
	foreach(var_9b5d57b6 in level.var_cb8f67c9)
	{
		var_9b5d57b6 function_4306cc3f();
	}
	level.var_6db2e9b7 = struct::get_array(#"hash_2a97322faea2f000");
	foreach(var_506f913 in level.var_6db2e9b7)
	{
		var_506f913 function_462cd7c0();
	}
}

/*
	Name: function_4306cc3f
	Namespace: namespace_cc08081f
	Checksum: 0x80967388
	Offset: 0x13A0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_4306cc3f()
{
	self thread function_938d4207();
}

/*
	Name: function_488e39dc
	Namespace: namespace_cc08081f
	Checksum: 0xE47E25A1
	Offset: 0x13C8
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_488e39dc()
{
	self.unitrigger_stub = self zm_unitrigger::create("", vectorscale((1, 1, 1), 32));
	self thread function_6ef57d1f();
	zm_unitrigger::function_89380dda(self.unitrigger_stub, 1);
}

/*
	Name: function_462cd7c0
	Namespace: namespace_cc08081f
	Checksum: 0x791CEBD7
	Offset: 0x1438
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_462cd7c0()
{
	self.device = getent(self.target, "targetname");
	self.unitrigger_stub = self zm_unitrigger::create("", vectorscale((1, 1, 1), 32));
	self thread function_b4dbbdd1();
	zm_unitrigger::function_89380dda(self.unitrigger_stub, 1);
	self.device function_74174ce1("screen_off");
}

/*
	Name: function_938d4207
	Namespace: namespace_cc08081f
	Checksum: 0x3054779B
	Offset: 0x14F0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_938d4207()
{
	self endon(#"death");
	level endon(#"insanity_mode_triggered");
	pixbeginevent(#"hash_12312acd8fd62f9e");
	e_trigger = getent(self.target, "targetname");
	s_result = undefined;
	s_result = e_trigger waittill(#"damage");
	self thread function_8c80503();
	pixendevent();
}

/*
	Name: function_6ef57d1f
	Namespace: namespace_cc08081f
	Checksum: 0xE730F632
	Offset: 0x15C0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_6ef57d1f()
{
	self endon(#"death");
	level endon(#"insanity_mode_triggered");
	s_notify = undefined;
	s_notify = self waittill(#"trigger_activated");
	self.stub.related_parent thread function_8c80503();
}

/*
	Name: function_b4dbbdd1
	Namespace: namespace_cc08081f
	Checksum: 0x3AC83375
	Offset: 0x1638
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_b4dbbdd1()
{
	self endon(#"death");
	level endon(#"insanity_mode_triggered");
	s_notify = undefined;
	s_notify = self waittill(#"trigger_activated");
	self thread uin_kls_counteruavdefeated();
	self.device function_74174ce1("screen_on");
}

/*
	Name: function_8c80503
	Namespace: namespace_cc08081f
	Checksum: 0x9B69ADF9
	Offset: 0x16C8
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_8c80503()
{
	if(isdefined(self.unitrigger_stub))
	{
		zm_unitrigger::unregister_unitrigger(self.unitrigger_stub);
	}
	self thread function_d4c6dc0d();
	wait(2);
	namespace_509a75d1::function_e308175e((#"hash_2d0c86fd62ab3853" + (self.var_614bfc5c + 1)) + "_sfx", self.origin);
	/#
		iprintlnbold("" + self.var_614bfc5c);
	#/
	self.is_playing_audio = 0;
}

/*
	Name: function_d4c6dc0d
	Namespace: namespace_cc08081f
	Checksum: 0x28DCD7BB
	Offset: 0x1790
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_d4c6dc0d()
{
	self.is_playing_audio = 1;
	var_df4e73a7 = getentarray(self.target2, "targetname");
	var_df4e73a7[0] playsound(#"hash_3cca3c060dacc7de");
	var_df4e73a7[0] playloopsound(#"hash_14cf26f9ee5a9962");
	while(self.is_playing_audio && var_df4e73a7.size > 0)
	{
		var_df4e73a7[0] rotatepitch(45, 1);
		wait(0.1);
		var_df4e73a7[1] rotatepitch(60, 1);
		wait(0.9);
	}
	var_df4e73a7[0] stoploopsound(0.5);
	playsoundatposition(#"hash_1f7edbf8f3a60766", self.origin);
}

/*
	Name: uin_kls_counteruavdefeated
	Namespace: namespace_cc08081f
	Checksum: 0xE6F1B50D
	Offset: 0x18F0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function uin_kls_counteruavdefeated()
{
	namespace_509a75d1::function_e308175e((#"hash_d065c4529d709fe" + (self.var_614bfc5c + 1)) + "_sfx", self.origin);
	/#
		iprintlnbold("" + self.var_614bfc5c);
	#/
}

/*
	Name: function_ac06ab3a
	Namespace: namespace_cc08081f
	Checksum: 0x30B89BD5
	Offset: 0x1968
	Size: 0x3DC
	Parameters: 0
	Flags: Linked
*/
function function_ac06ab3a()
{
	level.var_ea514bc4 = [];
	var_1c8e90b4 = array(#"hash_6fce75e5c4fe6210");
	var_ab6a16ff = array(#"hash_172aa60779a37741");
	var_e6c1fe70 = array(#"hash_511e79ef416368e2");
	var_51ba7b4a = array(#"hash_1a1854072d6b2453");
	var_68e586cf = array(#"hash_39204e32adbe7694");
	level.var_ea514bc4[0] = {#vo_line:var_1c8e90b4, #hash_85f707f6:0, #play_order:0};
	level.var_ea514bc4[1] = {#vo_line:var_ab6a16ff, #hash_85f707f6:0, #play_order:1};
	level.var_ea514bc4[2] = {#hash_46db68fd:1, #vo_line:var_e6c1fe70, #hash_85f707f6:0, #play_order:2};
	level.var_ea514bc4[3] = {#vo_line:var_51ba7b4a, #hash_85f707f6:0, #play_order:3};
	level.var_ea514bc4[4] = {#vo_line:var_68e586cf, #hash_85f707f6:0, #play_order:4};
	level.var_804a56e3 = 0;
	level.var_ba07f1de = namespace_509a75d1::function_bffcedde("white_audio_reel", "targetname", "script_int");
	foreach(var_2e2b46e8 in level.var_ba07f1de)
	{
		var_2e2b46e8 namespace_2e9c09b3::function_e8661563(&function_1792ae3, 1);
	}
	level.var_e046b238 = struct::get(#"hash_5201d44a6f57e32a");
	level.var_94b00cff = spawn("script_model", level.var_e046b238.origin);
	s_unitrigger = level.var_e046b238 zm_unitrigger::create(&function_6fb01110, 64, &function_aa07edab);
	s_unitrigger thread function_8352562a();
}

/*
	Name: function_1792ae3
	Namespace: namespace_cc08081f
	Checksum: 0xFE2F824E
	Offset: 0x1D50
	Size: 0xC8
	Parameters: 1
	Flags: Linked
*/
function function_1792ae3(var_2e1f34dd)
{
	s_reel = level.var_ea514bc4[level.var_804a56e3];
	if(isdefined(s_reel))
	{
		s_reel.var_85f707f6 = 1;
		if(math::cointoss())
		{
			self thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
		}
		if(isdefined(var_2e1f34dd))
		{
			var_2e1f34dd playsound(#"hash_760800881cd94dd1");
		}
		function_de798ee4();
		level.var_804a56e3++;
	}
}

/*
	Name: function_6fb01110
	Namespace: namespace_cc08081f
	Checksum: 0x8332659F
	Offset: 0x1E20
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_6fb01110(player)
{
	if(self.stub.in_use === 1)
	{
		return 0;
	}
	if(!isdefined(level.var_19e44f3d))
	{
		return 0;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_4a6b20a71fb9496b");
	}
	else
	{
		self sethintstring(#"hash_68d7ac4aedcba8f5");
	}
	return 1;
}

/*
	Name: function_aa07edab
	Namespace: namespace_cc08081f
	Checksum: 0x6F552ECD
	Offset: 0x1EC0
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_aa07edab()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self.stub notify(#"play_audio");
	}
}

/*
	Name: function_8352562a
	Namespace: namespace_cc08081f
	Checksum: 0xAC79D226
	Offset: 0x1F18
	Size: 0x2AC
	Parameters: 0
	Flags: Linked
*/
function function_8352562a()
{
	self endon(#"death");
	var_e578920c = 0;
	while(true)
	{
		self waittill(#"play_audio");
		exploder::exploder("fxexp_script_projector_off");
		exploder::exploder("fxexp_script_projector_on");
		level.var_94b00cff playsound(#"hash_7f70f5f71963f7f2");
		if(isdefined(level.var_19e44f3d))
		{
			s_reel = level.var_19e44f3d;
			self.in_use = 1;
			s_reel.var_85f707f6 = 0;
			function_de798ee4();
			level.var_94b00cff playsound(#"hash_50cae5e74f332b7c");
			if(s_reel.var_46db68fd === 1)
			{
				level.var_94b00cff playloopsound(#"hash_1e451b58f18190b4");
			}
			else
			{
				level.var_94b00cff playloopsound(#"hash_48cebe2e9cc70ddc");
			}
			wait(2);
			namespace_509a75d1::function_52c3fe8d(s_reel.vo_line, level.var_94b00cff.origin);
			/#
				iprintlnbold(("" + s_reel.play_order) + "");
			#/
			var_e578920c++;
			level.var_94b00cff stoploopsound();
			level.var_94b00cff playsound(#"hash_1f5fc24563134758");
			exploder::stop_exploder("fxexp_script_projector_on");
			exploder::stop_exploder("fxexp_script_projector_off");
			if(var_e578920c < 6)
			{
				self.in_use = 0;
			}
			else
			{
				wait(0.1);
				break;
			}
		}
	}
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_de798ee4
	Namespace: namespace_cc08081f
	Checksum: 0xBCD694E8
	Offset: 0x21D0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_de798ee4()
{
	level.var_19e44f3d = undefined;
	for(i = 0; i < level.var_ea514bc4.size; i++)
	{
		if(level.var_ea514bc4[i].var_85f707f6)
		{
			level.var_19e44f3d = level.var_ea514bc4[i];
			break;
		}
	}
}

/*
	Name: function_d38b59bb
	Namespace: namespace_cc08081f
	Checksum: 0x39773E5
	Offset: 0x2248
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_d38b59bb()
{
	level waittill(#"pap_power_ready");
	ee_av_tv = struct::get("ee_av_tv", "targetname");
	s_unitrigger = ee_av_tv zm_unitrigger::create("", 64, &function_82c13fa8);
	s_unitrigger thread function_6b2499f9();
}

/*
	Name: function_82c13fa8
	Namespace: namespace_cc08081f
	Checksum: 0x3CB70593
	Offset: 0x22E8
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_82c13fa8()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self.stub notify(#"play_audio");
	}
}

/*
	Name: function_6b2499f9
	Namespace: namespace_cc08081f
	Checksum: 0x7BA9B199
	Offset: 0x2340
	Size: 0x194
	Parameters: 0
	Flags: Linked
*/
function function_6b2499f9()
{
	self endon(#"death");
	var_a5e8d5c7 = [];
	for(i = 0; i < 15; i++)
	{
		if(!isdefined(var_a5e8d5c7))
		{
			var_a5e8d5c7 = [];
		}
		else if(!isarray(var_a5e8d5c7))
		{
			var_a5e8d5c7 = array(var_a5e8d5c7);
		}
		var_a5e8d5c7[var_a5e8d5c7.size] = i;
	}
	n_index = 0;
	while(n_index < var_a5e8d5c7.size)
	{
		self waittill(#"play_audio");
		foreach(player in getplayers())
		{
			namespace_509a75d1::function_e308175e("vox_tv_message_avog_" + var_a5e8d5c7[n_index], self.origin, player);
		}
		n_index++;
		level waittill(#"zombie_total_set");
	}
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_a0b040d4
	Namespace: namespace_cc08081f
	Checksum: 0x1F63A08
	Offset: 0x24E0
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_a0b040d4()
{
	level endon(#"hash_48039f3a4c1a3248");
	level.s_tedd = struct::get(#"hash_17790fb78d228f05", "targetname");
	s_unitrigger = level.s_tedd zm_unitrigger::create(&function_c9271718, 64, &function_ee32c750);
	s_unitrigger thread function_4bda6193();
	level waittill(#"hash_398e4b1e72edb4ee");
	vol = getent("vol_soul_lounge", "targetname");
	exploder::exploder("fxexp_elec_lounge");
	vol thread function_cf1b4a16();
	wait(60);
	level flag::clear(#"hash_398e4b1e72edb4ee");
	exploder::stop_exploder("fxexp_elec_lounge");
}

/*
	Name: function_c9271718
	Namespace: namespace_cc08081f
	Checksum: 0xB5C20A0C
	Offset: 0x2640
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function function_c9271718(player)
{
	if(level.s_tedd.in_use === 1)
	{
		return 0;
	}
	if(level.s_tedd.is_on === 1)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_5da008b5fb1b3d");
		}
		else
		{
			self sethintstring(#"hash_57516d7d358e63df");
		}
	}
	else if(function_8b1a219a())
	{
		self sethintstring(#"hash_5678e908d228814e");
	}
	else
	{
		self sethintstring(#"hash_7dca7ee995ad3d4a");
	}
	return 1;
}

/*
	Name: function_ee32c750
	Namespace: namespace_cc08081f
	Checksum: 0x197F876F
	Offset: 0x2750
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_ee32c750()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self playsound(#"hash_342cdac10639915e");
		self.stub notify(#"play_audio");
	}
}

/*
	Name: function_93040a5d
	Namespace: namespace_cc08081f
	Checksum: 0x90EFFB45
	Offset: 0x27C8
	Size: 0x2C6
	Parameters: 0
	Flags: Linked
*/
function function_93040a5d()
{
	self setcandamage(1);
	self val::set("quest_mee", "allowDeath", 0);
	var_28999578 = array::randomize(array(0, 1, 2, 3, 4, 5, 6, 7, 8));
	var_4854a91b = "vox_tedd_melee_tedd_";
	self endon(#"death");
	level.var_5da5aff4 = 0;
	while(!level.var_5da5aff4)
	{
		b_player_damaged = 0;
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		b_player_damaged = waitresult function_ce7e594b();
		if(!b_player_damaged || (isdefined(level.s_tedd.in_use) && level.s_tedd.in_use))
		{
			wait(1);
		}
		else
		{
			level.s_tedd.in_use = 1;
			if(var_28999578.size > 0)
			{
				alias = var_4854a91b + var_28999578[0];
				arrayremoveindex(var_28999578, 0);
			}
			else
			{
				alias = "vox_tedd_melee_final_tedd_0";
				level.var_5da5aff4 = 1;
			}
			foreach(player in getplayers())
			{
				namespace_509a75d1::function_e308175e(alias, level.s_tedd.origin, player);
				if(level.var_5da5aff4)
				{
					level flag::set(#"hash_398e4b1e72edb4ee");
				}
			}
			wait(2);
			level.s_tedd.in_use = 0;
		}
	}
}

/*
	Name: function_ce7e594b
	Namespace: namespace_cc08081f
	Checksum: 0x68776C81
	Offset: 0x2A98
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_ce7e594b()
{
	foreach(player in level.players)
	{
		if(isplayer(self.attacker) && !isbot(self.attacker))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_cf1b4a16
	Namespace: namespace_cc08081f
	Checksum: 0xAF5A1479
	Offset: 0x2B48
	Size: 0x142
	Parameters: 0
	Flags: Linked
*/
function function_cf1b4a16()
{
	var_5b857980 = function_4d1e7b48(#"hash_320c81d91eb89d73");
	while(level flag::get(#"hash_398e4b1e72edb4ee"))
	{
		foreach(player in getplayers())
		{
			if(player istouching(self))
			{
				player playrumbleonentity("damage_heavy");
				player playsound(#"hash_5af2a9d11f007b9");
				player status_effect::status_effect_apply(var_5b857980, undefined, self, 1);
			}
		}
		wait(1);
	}
}

/*
	Name: function_4bda6193
	Namespace: namespace_cc08081f
	Checksum: 0xEE4C0F21
	Offset: 0x2C98
	Size: 0x384
	Parameters: 0
	Flags: Linked
*/
function function_4bda6193()
{
	self endon(#"death");
	level.s_tedd.in_use = 0;
	var_a5e8d5c7 = [];
	for(i = 0; i < 26; i++)
	{
		if(!isdefined(var_a5e8d5c7))
		{
			var_a5e8d5c7 = [];
		}
		else if(!isarray(var_a5e8d5c7))
		{
			var_a5e8d5c7 = array(var_a5e8d5c7);
		}
		var_a5e8d5c7[var_a5e8d5c7.size] = i;
	}
	var_a5e8d5c7 = array::randomize(var_a5e8d5c7);
	n_index = 0;
	while(true)
	{
		self waittill(#"play_audio");
		if(isdefined(level.s_tedd.in_use) && !level.s_tedd.in_use)
		{
			level.s_tedd.in_use = 1;
			if(!(isdefined(level.s_tedd.is_on) && level.s_tedd.is_on))
			{
				exploder::exploder("fxexp_script_bus_driver_on");
				wait(1);
				level.s_tedd.is_on = 1;
				foreach(player in getplayers())
				{
					namespace_509a75d1::function_e308175e("vox_tedd_interact_first_tedd_0", level.s_tedd.origin, player);
				}
				level.s_tedd.body = getent("ee_tedd", "targetname");
				level.s_tedd.body thread function_93040a5d();
			}
			else
			{
				foreach(player in getplayers())
				{
					namespace_509a75d1::function_e308175e("vox_tedd_interact_tedd_" + var_a5e8d5c7[n_index], level.s_tedd.origin, player);
				}
				n_index++;
				if(n_index >= var_a5e8d5c7.size)
				{
					n_index = 0;
					var_a5e8d5c7 = array::randomize(var_a5e8d5c7);
				}
			}
			wait(2);
			level.s_tedd.in_use = 0;
		}
		else
		{
			wait(1);
		}
	}
}

/*
	Name: function_35e95fba
	Namespace: namespace_cc08081f
	Checksum: 0x5220ABB1
	Offset: 0x3028
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_35e95fba()
{
	self hidepart("tag_screen_off");
	self hidepart("tag_screen_on_play");
	self hidepart("tag_screen_on_noise");
	self hidepart("tag_screen_on_tone");
}

/*
	Name: function_74174ce1
	Namespace: namespace_cc08081f
	Checksum: 0x2033272A
	Offset: 0x30B8
	Size: 0x1C2
	Parameters: 1
	Flags: Linked
*/
function function_74174ce1(str_state)
{
	switch(str_state)
	{
		case "screen_off":
		{
			self function_35e95fba();
			self showpart("tag_screen_on_play");
			break;
		}
		case "screen_on":
		{
			self function_35e95fba();
			self showpart("tag_screen_on_noise");
			wait(30);
			self hidepart("tag_screen_on_noise");
			self showpart("tag_screen_on_tone");
			wait(30);
			self hidepart("tag_screen_on_tone");
			self showpart("tag_screen_off");
			break;
		}
		case "hash_4f0b13362f02aa46":
		{
			self function_35e95fba();
			self showpart("tag_screen_on_noise");
			break;
		}
		case "hash_31366a4d9da7d1a4":
		{
			self function_35e95fba();
			self showpart("tag_screen_on_tone");
			break;
		}
	}
}

