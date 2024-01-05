// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\weapons\zm_weap_riotshield.csc;
#using script_54a67b7ed7b385e6;
#using scripts\zm\zm_zodt8_tutorial.csc;
#using script_5504fe574aed77a8;
#using scripts\zm\zm_zodt8_sentinel_trial.csc;
#using scripts\zm\zm_zodt8_eye.csc;
#using scripts\zm\zm_zodt8_sound.csc;
#using scripts\zm\zm_zodt8_gamemodes.csc;
#using scripts\zm_common\zm_characters.csc;
#using scripts\zm_common\zm_weapons.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_pack_a_punch.csc;
#using scripts\zm_common\zm_fasttravel.csc;
#using scripts\zm_common\zm_audio_sq.csc;
#using scripts\zm_common\zm.csc;
#using scripts\zm_common\load.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\audio_shared.csc;

#namespace zodt8_pap_quest;

/*
	Name: init
	Namespace: zodt8_pap_quest
	Checksum: 0x6B9A6CD3
	Offset: 0x328
	Size: 0x1F4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level._effect[#"hash_711cbb6b36694a2a"] = #"hash_76b535da68eacfe5";
	level._effect[#"hash_2ad6c6017f084d7a"] = #"hash_4e58e9dad90ada6d";
	level._effect[#"hash_23bb6df1e8d8a032"] = #"hash_4f8332385445d967";
	level._effect[#"hash_14d2dc2c31e6dab9"] = #"hash_37e114058b86991a";
	level._effect[#"hash_79b06b6af34ac1ab"] = #"hash_1e30126e06b4956";
	clientfield::register("zbarrier", "pap_chunk_small_rune", 1, getminbitcountfornum(16), "int", &pap_chunk_small_rune, 0, 0);
	clientfield::register("zbarrier", "pap_chunk_big_rune", 1, getminbitcountfornum(5), "int", &pap_chunk_big_rune, 0, 0);
	clientfield::register("zbarrier", "pap_machine_rune", 1, getminbitcountfornum(5), "int", &pap_machine_rune, 0, 0);
}

/*
	Name: pap_chunk_big_rune
	Namespace: zodt8_pap_quest
	Checksum: 0xF24E39DD
	Offset: 0x528
	Size: 0x432
	Parameters: 7
	Flags: Linked
*/
function pap_chunk_big_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self.var_86adf17d))
	{
		self.var_86adf17d = [];
	}
	var_d7b20a11 = self zbarriergetpiece(0);
	v_forward = anglestoright(self.angles);
	var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_001");
	var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_003");
	var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_002");
	var_d7b20a11 hidepart(localclientnum, "j_map_rune_loc_004");
	switch(newval)
	{
		case 2:
		{
			self.var_86adf17d[localclientnum] = playfx(localclientnum, level._effect[#"hash_711cbb6b36694a2a"], self.origin, v_forward);
			audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + vectorscale((0, 0, 1), 70));
			break;
		}
		case 3:
		{
			self.var_86adf17d[localclientnum] = playfx(localclientnum, level._effect[#"hash_2ad6c6017f084d7a"], self.origin, v_forward);
			audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + vectorscale((0, 0, 1), 70));
			break;
		}
		case 4:
		{
			self.var_86adf17d[localclientnum] = playfx(localclientnum, level._effect[#"hash_23bb6df1e8d8a032"], self.origin, v_forward);
			audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + vectorscale((0, 0, 1), 70));
			break;
		}
		case 5:
		{
			self.var_86adf17d[localclientnum] = playfx(localclientnum, level._effect[#"hash_14d2dc2c31e6dab9"], self.origin, v_forward);
			audio::playloopat("zmb_pap_plinth_symbol_lp", self.origin + vectorscale((0, 0, 1), 70));
			break;
		}
		case 1:
		{
			audio::stoploopat("zmb_pap_plinth_symbol_lp", self.origin + vectorscale((0, 0, 1), 70));
			if(isdefined(self.var_86adf17d[localclientnum]))
			{
				killfx(localclientnum, self.var_86adf17d[localclientnum]);
				self.var_86adf17d[localclientnum] = undefined;
				playfx(localclientnum, level._effect[#"hash_79b06b6af34ac1ab"], self.origin, v_forward);
			}
			break;
		}
	}
}

/*
	Name: pap_chunk_small_rune
	Namespace: zodt8_pap_quest
	Checksum: 0x6FB42737
	Offset: 0x968
	Size: 0xA4C
	Parameters: 7
	Flags: Linked
*/
function pap_chunk_small_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_d7b20a11 = self zbarriergetpiece(0);
	sndorigin = var_d7b20a11 gettagorigin("j_map_rune_003");
	switch(newval)
	{
		case 1:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			playsound(localclientnum, #"hash_3e22cef1a7b16893", var_d7b20a11 gettagorigin("j_map_rune_004"));
			break;
		}
		case 2:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 3:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 4:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 5:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 6:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 7:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 8:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 9:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 10:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 11:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 12:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 13:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 1);
			break;
		}
		case 14:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 15:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 1);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
		case 16:
		{
			var_d7b20a11 function_a2c01e49(localclientnum, 0, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 1, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 2, 0);
			var_d7b20a11 function_a2c01e49(localclientnum, 3, 0);
			break;
		}
	}
	if(newval != 1)
	{
		playsound(localclientnum, #"hash_291ff1a1ce5cc02f", sndorigin);
	}
}

/*
	Name: function_a2c01e49
	Namespace: zodt8_pap_quest
	Checksum: 0x6C58C952
	Offset: 0x13C0
	Size: 0x19A
	Parameters: 3
	Flags: Linked
*/
function function_a2c01e49(localclientnum, var_705d414e, n_state)
{
	switch(var_705d414e)
	{
		case 0:
		{
			var_73df2d96 = "j_map_rune_003";
			var_f9d2e2e2 = "j_map_rune_off_003";
			break;
		}
		case 1:
		{
			var_73df2d96 = "j_map_rune_004";
			var_f9d2e2e2 = "j_map_rune_off_004";
			break;
		}
		case 2:
		{
			var_73df2d96 = "j_map_rune_001";
			var_f9d2e2e2 = "j_map_rune_off_001";
			break;
		}
		case 3:
		{
			var_73df2d96 = "j_map_rune_002";
			var_f9d2e2e2 = "j_map_rune_off_002";
			break;
		}
	}
	switch(n_state)
	{
		case 0:
		{
			self showpart(localclientnum, var_73df2d96);
			self hidepart(localclientnum, var_f9d2e2e2);
			break;
		}
		case 1:
		{
			self hidepart(localclientnum, var_73df2d96);
			self showpart(localclientnum, var_f9d2e2e2);
			break;
		}
	}
}

/*
	Name: pap_machine_rune
	Namespace: zodt8_pap_quest
	Checksum: 0x28C15984
	Offset: 0x1568
	Size: 0x362
	Parameters: 7
	Flags: Linked
*/
function pap_machine_rune(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_d7b20a11 = self zbarriergetpiece(4);
	switch(newval)
	{
		case 1:
		{
			var_d7b20a11 function_c976f028(localclientnum, 0, 2);
			var_d7b20a11 function_c976f028(localclientnum, 1, 2);
			var_d7b20a11 function_c976f028(localclientnum, 2, 2);
			var_d7b20a11 function_c976f028(localclientnum, 3, 2);
			break;
		}
		case 2:
		{
			var_d7b20a11 function_c976f028(localclientnum, 0, 0);
			var_d7b20a11 function_c976f028(localclientnum, 1, 1);
			var_d7b20a11 function_c976f028(localclientnum, 2, 1);
			var_d7b20a11 function_c976f028(localclientnum, 3, 1);
			break;
		}
		case 3:
		{
			var_d7b20a11 function_c976f028(localclientnum, 0, 1);
			var_d7b20a11 function_c976f028(localclientnum, 1, 0);
			var_d7b20a11 function_c976f028(localclientnum, 2, 1);
			var_d7b20a11 function_c976f028(localclientnum, 3, 1);
			break;
		}
		case 4:
		{
			var_d7b20a11 function_c976f028(localclientnum, 0, 1);
			var_d7b20a11 function_c976f028(localclientnum, 1, 1);
			var_d7b20a11 function_c976f028(localclientnum, 2, 0);
			var_d7b20a11 function_c976f028(localclientnum, 3, 1);
			break;
		}
		case 5:
		{
			var_d7b20a11 function_c976f028(localclientnum, 0, 1);
			var_d7b20a11 function_c976f028(localclientnum, 1, 1);
			var_d7b20a11 function_c976f028(localclientnum, 2, 1);
			var_d7b20a11 function_c976f028(localclientnum, 3, 0);
			break;
		}
	}
}

/*
	Name: function_c976f028
	Namespace: zodt8_pap_quest
	Checksum: 0x894D304F
	Offset: 0x18D8
	Size: 0x1E2
	Parameters: 3
	Flags: Linked
*/
function function_c976f028(localclientnum, var_705d414e, n_state)
{
	switch(var_705d414e)
	{
		case 0:
		{
			var_73df2d96 = "j_machine_rune_003";
			var_f9d2e2e2 = "j_machine_rune_off_003";
			break;
		}
		case 1:
		{
			var_73df2d96 = "j_machine_rune_004";
			var_f9d2e2e2 = "j_machine_rune_off_004";
			break;
		}
		case 2:
		{
			var_73df2d96 = "j_machine_rune_001";
			var_f9d2e2e2 = "j_machine_rune_off_001";
			break;
		}
		case 3:
		{
			var_73df2d96 = "j_machine_rune_002";
			var_f9d2e2e2 = "j_machine_rune_off_002";
			break;
		}
	}
	switch(n_state)
	{
		case 0:
		{
			self showpart(localclientnum, var_73df2d96);
			self hidepart(localclientnum, var_f9d2e2e2);
			break;
		}
		case 1:
		{
			self hidepart(localclientnum, var_73df2d96);
			self showpart(localclientnum, var_f9d2e2e2);
			break;
		}
		case 2:
		{
			self hidepart(localclientnum, var_73df2d96);
			self hidepart(localclientnum, var_f9d2e2e2);
			break;
		}
	}
}

