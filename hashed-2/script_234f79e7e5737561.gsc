// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4a375dc7d0573a9a;
#using scripts\core_common\audio_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_e204d655;

/*
	Name: main
	Namespace: namespace_e204d655
	Checksum: 0x71B64CCF
	Offset: 0x220
	Size: 0x3DC
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	if(util::function_5df4294() != "ztutorial")
	{
		return;
	}
	clientfield::register("actor", "tutorial_keyline_fx", 1, 2, "int", &function_d1730bd, 0, 0);
	clientfield::register("zbarrier", "tutorial_keyline_fx", 1, 2, "int", &function_a9c8f9d2, 0, 0);
	clientfield::register("item", "tutorial_keyline_fx", 1, 2, "int", &function_d1730bd, 0, 0);
	clientfield::register("scriptmover", "tutorial_keyline_fx", 1, 2, "int", &function_d1730bd, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1b509b0ba634a25a", 1, 1, "int", &function_7c8084eb, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_1390e08de02cbdc7", 1, 1, "int", &function_8057ebca, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showLocation", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showPerks", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showEquipment", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showShield", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showSpecial", 1, 1, "int", undefined, 0, 0);
	clientfield::register("worlduimodel", "hudItems.ztut.showElixirs", 1, 1, "int", undefined, 0, 0);
	level._effect[#"hash_1b509b0ba634a25a"] = #"zombie/fx_ritual_barrier_defend_door_wide_zod_zmb";
	level._effect[#"hash_1390e08de02cbdc7"] = #"hash_5b773dbbac0012ff";
	zm_tut_hint_text::register("zm_tut_hint_text");
	callback::on_localclient_connect(&function_9fc8cc9c);
}

/*
	Name: function_9fc8cc9c
	Namespace: namespace_e204d655
	Checksum: 0x967438FB
	Offset: 0x608
	Size: 0x19C
	Parameters: 1
	Flags: Linked
*/
function function_9fc8cc9c(localclientnum)
{
	do
	{
		wait(1);
	}
	while(!isdefined(getent(localclientnum, "altar_icon_0", "targetname")));
	for(i = 0; i < 4; i++)
	{
		var_dcf4ea85 = getent(localclientnum, "altar_icon_" + i, "targetname");
		if(isdefined(var_dcf4ea85))
		{
			switch(i)
			{
				case 0:
				{
					var_dcf4ea85 setmodel(#"hash_6c0474e5948852cb");
					break;
				}
				case 1:
				{
					var_dcf4ea85 setmodel(#"hash_f19d451775e86");
					break;
				}
				case 2:
				{
					var_dcf4ea85 setmodel(#"hash_7941823894380037");
					break;
				}
				case 3:
				{
					var_dcf4ea85 setmodel(#"hash_3d6bbf11f303d3b6");
					break;
				}
			}
		}
	}
}

/*
	Name: function_d1730bd
	Namespace: namespace_e204d655
	Checksum: 0x58F61CFF
	Offset: 0x7B0
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_d1730bd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_bf9d3071(#"hash_2ef4d8e5fdbc8a08");
		if(self.model == "p8_fxanim_zm_vapor_altar_zeus_mod")
		{
			var_e5c7e01a = getent(0, "zeus_bird_head", "targetname");
			var_e5c7e01a function_bf9d3071(#"hash_2ef4d8e5fdbc8a08");
		}
	}
	else if(newval == 2)
	{
		self function_5d482e78(#"hash_2ef4d8e5fdbc8a08");
		if(self.model == "p8_fxanim_zm_vapor_altar_zeus_mod")
		{
			var_e5c7e01a = getent(0, "zeus_bird_head", "targetname");
			var_e5c7e01a function_5d482e78(#"hash_2ef4d8e5fdbc8a08");
		}
	}
}

/*
	Name: function_a9c8f9d2
	Namespace: namespace_e204d655
	Checksum: 0x5373692A
	Offset: 0x910
	Size: 0x13E
	Parameters: 7
	Flags: Linked
*/
function function_a9c8f9d2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		var_5548b1dc = self getnumzbarrierpieces();
		for(n_index = 0; n_index < var_5548b1dc; n_index++)
		{
			e_piece = self zbarriergetpiece(n_index);
			e_piece function_bf9d3071(#"hash_2ef4d8e5fdbc8a08");
		}
	}
	else if(newval == 2)
	{
		var_5548b1dc = self getnumzbarrierpieces();
		for(n_index = 0; n_index < var_5548b1dc; n_index++)
		{
			e_piece = self zbarriergetpiece(n_index);
			e_piece function_5d482e78(#"hash_2ef4d8e5fdbc8a08");
		}
	}
}

/*
	Name: function_7c8084eb
	Namespace: namespace_e204d655
	Checksum: 0x353E2402
	Offset: 0xA58
	Size: 0xBA
	Parameters: 7
	Flags: Linked
*/
function function_7c8084eb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(isdefined(self.var_293d9904))
	{
		stopfx(localclientnum, self.var_293d9904);
		self.var_293d9904 = undefined;
	}
	if(newval == 1)
	{
		self.var_293d9904 = util::playfxontag(localclientnum, level._effect[#"hash_1b509b0ba634a25a"], self, "tag_origin");
	}
}

/*
	Name: function_8057ebca
	Namespace: namespace_e204d655
	Checksum: 0xE2AA0759
	Offset: 0xB20
	Size: 0x154
	Parameters: 7
	Flags: Linked
*/
function function_8057ebca(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		v_forward = anglestoforward(self.angles);
		self.var_96715094 = playfx(localclientnum, level._effect[#"hash_1390e08de02cbdc7"], self.origin, v_forward);
		audio::playloopat(#"hash_7c4e89429c24b4bd", self.origin);
	}
	else if(isdefined(self.var_96715094))
	{
		stopfx(localclientnum, self.var_96715094);
		audio::stoploopat(#"hash_7c4e89429c24b4bd", self.origin);
		playsound(0, #"hash_2f2d6d08b47e6395", self.origin);
	}
}

