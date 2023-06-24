// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\trigger_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_white_mee;

/*
	Name: __init__system__
	Namespace: zm_white_mee
	Checksum: 0x58FA338
	Offset: 0x250
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_white_ee", &init, &main, undefined);
}

/*
	Name: init
	Namespace: zm_white_mee
	Checksum: 0x31184C21
	Offset: 0x2A0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_clientfields();
}

/*
	Name: main
	Namespace: zm_white_mee
	Checksum: 0x80F724D1
	Offset: 0x2C0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main()
{
}

/*
	Name: init_clientfields
	Namespace: zm_white_mee
	Checksum: 0x9106A79C
	Offset: 0x2D0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_2a3dbcaa79e8e3d6", 20000, 1, "int", &function_dc6960d, 0, 0);
	clientfield::register("scriptmover", "" + #"hash_5e1264789183cde1", 20000, 1, "int", &play_spark, 0, 0);
	clientfield::register("toplayer", "" + #"hash_72a33f6d2cc925c5", 20000, 1, "int", &function_5850fbee, 0, 0);
	clientfield::register("toplayer", "" + #"hash_1df297369e47699a", 20000, 1, "counter", &function_bb4b8cd2, 0, 0);
	clientfield::register("toplayer", "" + #"hash_7d631c764117de1e", 20000, 1, "counter", &function_670635f5, 0, 0);
	clientfield::register("toplayer", "" + #"hash_f2d0b920043dbbd", 20000, 1, "counter", &function_87d68f99, 0, 0);
	clientfield::register("toplayer", "" + #"delete_model", 20000, 1, "counter", &delete_model, 0, 0);
}

/*
	Name: function_dc6960d
	Namespace: zm_white_mee
	Checksum: 0x765F411F
	Offset: 0x548
	Size: 0xF8
	Parameters: 7
	Flags: Linked
*/
function function_dc6960d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	parts = function_c3d68575(self.origin, (50, 50, 65), "dummy_part");
	if(isdefined(parts))
	{
		foreach(p in parts)
		{
			setdynentenabled(p, 0);
		}
	}
}

/*
	Name: play_spark
	Namespace: zm_white_mee
	Checksum: 0x58A0611F
	Offset: 0x648
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function play_spark(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		playfx(localclientnum, "maps/zm_white/fx8_robot_mannequin_head_sparks_burst", self.origin);
	}
}

/*
	Name: function_5850fbee
	Namespace: zm_white_mee
	Checksum: 0xE94FA9ED
	Offset: 0x6C0
	Size: 0x12C
	Parameters: 7
	Flags: Linked
*/
function function_5850fbee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"disconnect");
	var_17b2e8dd = getent(localclientnum, "mee_3_body", "targetname");
	var_f6289db0 = getent(localclientnum, "mee_3_head", "targetname");
	if(newval == 1 || !zm_utility::is_classic())
	{
		var_17b2e8dd hide();
		var_f6289db0 hide();
	}
	else
	{
		var_17b2e8dd show();
		var_f6289db0 show();
	}
}

/*
	Name: function_bb4b8cd2
	Namespace: zm_white_mee
	Checksum: 0x24A40A0
	Offset: 0x7F8
	Size: 0x1CC
	Parameters: 7
	Flags: Linked
*/
function function_bb4b8cd2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	var_17b2e8dd = getent(localclientnum, "mee_3_body", "targetname");
	var_f6289db0 = getent(localclientnum, "mee_3_head", "targetname");
	if(newval)
	{
		player_pos = (self.origin[0], self.origin[1], 0) + (0, 0, var_f6289db0.origin[2]);
		player_vec = player_pos - var_f6289db0.origin;
		angles = vectortoangles(player_vec);
		var_f6289db0 rotateto(angles, 0.2);
		wait(0.2);
		if(isdefined(self))
		{
			self thread postfx::playpostfxbundle(#"hash_37d0c10f478e0376");
			playsound(localclientnum, #"hash_50a56f17fc412b92", (0, 0, 0));
			waitframe(1);
		}
		var_17b2e8dd hide();
		var_f6289db0 hide();
	}
}

/*
	Name: function_670635f5
	Namespace: zm_white_mee
	Checksum: 0x872EE8D
	Offset: 0x9D0
	Size: 0x224
	Parameters: 7
	Flags: Linked
*/
function function_670635f5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"disconnect");
	if(newval == 1)
	{
		var_2b6bee33 = struct::get("sq_gl_scare_spawn", "targetname");
		n_char_index = self getselectedcharacterindex();
		str_model = "c_zom_dlc_waw_dempsey_fb";
		switch(n_char_index)
		{
			case 5:
			{
				str_model = "c_zom_dlc_richtofen_fb";
				break;
			}
			case 6:
			{
				str_model = "c_zom_dlc_dempsey_fb";
				break;
			}
			case 7:
			{
				str_model = "c_zom_dlc_nikolai_fb";
				break;
			}
			case 8:
			{
				str_model = "c_zom_dlc_takeo_fb";
				break;
			}
			case 21:
			{
				str_model = "c_zom_dlc_waw_dempsey_fb";
				break;
			}
			case 22:
			{
				str_model = "c_zom_dlc_waw_nikolai_fb";
				break;
			}
			case 23:
			{
				str_model = "c_zom_der_richtofen_old_cin_fb";
				break;
			}
			case 24:
			{
				str_model = "c_zom_dlc_waw_takeo_fb";
				break;
			}
		}
		self.var_fcf96ca0 = util::spawn_anim_model(localclientnum, str_model, var_2b6bee33.origin, var_2b6bee33.angles);
		self.var_fcf96ca0 thread function_ce8e5280();
	}
}

/*
	Name: function_ce8e5280
	Namespace: zm_white_mee
	Checksum: 0xF76F31F4
	Offset: 0xC00
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_ce8e5280()
{
	self endon(#"death");
	while(true)
	{
		self animation::play("ai_zombie_base_idle_au_v1");
	}
}

/*
	Name: function_87d68f99
	Namespace: zm_white_mee
	Checksum: 0xFD8B40EC
	Offset: 0xC48
	Size: 0xBC
	Parameters: 7
	Flags: Linked
*/
function function_87d68f99(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval)
	{
		self thread postfx::playpostfxbundle(#"hash_37d0c00f478e01c3");
		playsound(localclientnum, #"hash_750bc40787e0e29f", (0, 0, 0));
		waitframe(1);
		if(isdefined(self.var_fcf96ca0))
		{
			self.var_fcf96ca0 hide();
		}
	}
}

/*
	Name: delete_model
	Namespace: zm_white_mee
	Checksum: 0x4A2C27A7
	Offset: 0xD10
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function delete_model(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_fcf96ca0))
		{
			self.var_fcf96ca0 hide();
		}
	}
}

