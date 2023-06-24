// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_70ab01a7690ea256;
#using scripts\core_common\beam_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_weap_scepter;

/*
	Name: __init__system__
	Namespace: zm_weap_scepter
	Checksum: 0x61ABC2F2
	Offset: 0x288
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_weap_scepter", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_scepter
	Checksum: 0xB891F501
	Offset: 0x2D0
	Size: 0x772
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("allplayers", "" + #"hash_70c8a5d240e431ec", 1, 1, "counter", &function_abff2ba8, 1, 0);
	clientfield::register("allplayers", "" + #"zombie_scepter_melee", 1, 1, "counter", &function_cde26b0e, 1, 0);
	clientfield::register("allplayers", "" + #"zombie_scepter_heal", 1, 1, "counter", &function_3f83a22f, 0, 0);
	clientfield::register("scriptmover", "" + #"beacon_fx", 1, 1, "int", &beacon_fx, 0, 0);
	clientfield::register("allplayers", "" + #"skull_turret_beam_fire", 1, 2, "int", &skull_turret_beam_fire, 0, 1);
	clientfield::register("allplayers", "" + #"hash_6635e6da6fcfe594", 1, 2, "int", &flash_fx, 0, 0);
	clientfield::register("toplayer", "" + #"hash_2964d1cb7c4bd175", 1, 1, "counter", &function_d05553c6, 0, 0);
	clientfield::register("allplayers", "" + #"zombie_scepter_revive", 1, 1, "int", &revive_fx, 0, 0);
	clientfield::register("actor", "" + #"zombie_scepter_stun", 1, 1, "int", &function_f11b8d1d, 0, 0);
	clientfield::register("vehicle", "" + #"zombie_scepter_stun", 1, 1, "int", &function_f11b8d1d, 0, 0);
	clientfield::register("toplayer", "" + #"scepter_rumble", 1, 3, "counter", &scepter_rumble, 0, 0);
	level._effect[#"hash_1c2f974106158a5f"] = #"hash_7c1a6aad09dc0d7a";
	level._effect[#"hash_1c28ab41060f8dad"] = #"hash_7c145ead09d78d68";
	level._effect[#"scepter_bubble"] = #"hash_17756eb35aac3766";
	level._effect[#"hash_4c17911c3aed59ae"] = #"hash_15d8d928da3054a8";
	level._effect[#"hash_47a7d03689c68789"] = #"hash_7bf95975cc22d9e3";
	level._effect[#"scepter_revive"] = #"hash_7247f41820f6a4ac";
	level._effect[#"scepter_heal"] = #"zombie/fx_bgb_near_death_3p";
	level._effect[#"hash_5a1d977ed6c0bfbc"] = #"hash_7e8ecb7f481f27c1";
	level._effect[#"hash_5a24a37ed6c6f2ce"] = #"hash_7e95b77f48252473";
	level._effect[#"hash_1764e15fc9d376eb"] = #"hash_7951bc836b30dd06";
	level._effect[#"hash_175dd55fc9cd43d9"] = #"hash_794ad0836b2ae054";
	level._effect[#"hash_3c7dd8fed636096e"] = #"hash_683f232e39602a5f";
	level._effect[#"hash_3c76ccfed62fd65c"] = #"hash_6838372e395a2dad";
	level._effect[#"hash_143a6ec5331de8ec"] = #"hash_2dfc8a9a16973a20";
	level._effect[#"hash_14407ac5332268fe"] = #"hash_2e02969a169bba32";
	level._effect[#"hash_37498552cad06776"] = #"hash_2bd6cabc06cbf037";
	level._effect[#"hash_37429952caca6ac4"] = #"hash_2bcfbebc06c5bd25";
	level._effect[#"turret_zombie_shock"] = "zm_weapons/fx8_scepter_ray_zmb_hit_shock";
	level._effect[#"turret_zombie_explode"] = "zm_weapons/fx8_scepter_ray_zmb_hit_exp";
	level._effect[#"skull_turret_shock_eyes"] = "zm_weapons/fx8_scepter_ray_zmb_hit_eye";
}

/*
	Name: function_abff2ba8
	Namespace: zm_weap_scepter
	Checksum: 0xA0ACBB96
	Offset: 0xA50
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function function_abff2ba8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_143a6ec5331de8ec"], "tag_flash");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_14407ac5332268fe"], self, "tag_flash");
	}
}

/*
	Name: function_cde26b0e
	Namespace: zm_weap_scepter
	Checksum: 0x4AB71EF0
	Offset: 0xB28
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function function_cde26b0e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(self zm_utility::function_f8796df3(localclientnum))
	{
		playviewmodelfx(localclientnum, level._effect[#"hash_37498552cad06776"], "tag_flash");
	}
	else
	{
		util::playfxontag(localclientnum, level._effect[#"hash_37429952caca6ac4"], self, "tag_flash");
	}
}

/*
	Name: skull_turret_beam_fire
	Namespace: zm_weap_scepter
	Checksum: 0x11D41B58
	Offset: 0xC00
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function skull_turret_beam_fire(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death", #"disconnect");
	self function_69ccb98b(localclientnum);
	if(newval > 0)
	{
		self thread function_da5829be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
	}
}

/*
	Name: function_69ccb98b
	Namespace: zm_weap_scepter
	Checksum: 0x11AB6DC2
	Offset: 0xCB8
	Size: 0xEC
	Parameters: 1
	Flags: Linked
*/
function function_69ccb98b(localclientnum)
{
	if(!isdefined(self))
	{
		return;
	}
	self notify(#"hash_3cbfa1076dfa868b");
	if(isdefined(self.var_d559073))
	{
		beamkill(localclientnum, self.var_d559073);
		self.var_d559073 = undefined;
	}
	if(isdefined(self.var_d1f92a1c))
	{
		self.var_d1f92a1c delete();
		self.var_d1f92a1c = undefined;
	}
	if(isdefined(self.var_4cd8e6cb))
	{
		self stoploopsound(self.var_4cd8e6cb);
		self.var_4cd8e6cb = undefined;
		self playsound(localclientnum, #"hash_3126b098b980b5a3");
	}
}

/*
	Name: function_da5829be
	Namespace: zm_weap_scepter
	Checksum: 0x3558C45D
	Offset: 0xDB0
	Size: 0x1BA
	Parameters: 7
	Flags: Linked
*/
function function_da5829be(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death", #"hash_3cbfa1076dfa868b");
	if(!isdefined(self.var_4cd8e6cb))
	{
		self playsound(localclientnum, #"hash_3765e25049981166");
		self.var_4cd8e6cb = self playloopsound(#"hash_170aa1970243fc4a");
	}
	self.var_d1f92a1c = util::spawn_model(localclientnum, "tag_origin", self.origin + vectorscale((0, 0, 1), 4000));
	switch(newval)
	{
		case 2:
		{
			var_cc6ab1e6 = "beam8_zm_scepter_ray_lvl2";
			break;
		}
		case 3:
		{
			var_cc6ab1e6 = "beam8_zm_scepter_ray_lvl3";
			break;
		}
		default:
		{
			var_cc6ab1e6 = "beam8_zm_scepter_ray_lvl1";
			break;
		}
	}
	self.var_d559073 = level beam::function_cfb2f62a(localclientnum, self, "tag_flash", self.var_d1f92a1c, "tag_origin", var_cc6ab1e6);
}

/*
	Name: flash_fx
	Namespace: zm_weap_scepter
	Checksum: 0xB1E225F1
	Offset: 0xF78
	Size: 0x20A
	Parameters: 7
	Flags: Linked
*/
function flash_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	if(!self hasdobj(localclientnum))
	{
		return;
	}
	if(isdefined(self.fx_muzzle_flash))
	{
		deletefx(localclientnum, self.fx_muzzle_flash);
		self.fx_muzzle_flash = undefined;
	}
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	switch(newval)
	{
		case 1:
		case 2:
		case 3:
		{
			var_27aa6343 = ("scepter" + newval) + "_muzzle_flash1p";
			var_a1f103c8 = ("scepter" + newval) + "_muzzle_flash3p";
			if(self zm_utility::function_f8796df3(localclientnum))
			{
				if(viewmodelhastag(localclientnum, "tag_flash"))
				{
					self.fx_muzzle_flash = playviewmodelfx(localclientnum, level._effect[var_27aa6343], "tag_flash");
				}
			}
			else if(isdefined(self gettagorigin("tag_flash")))
			{
				self.fx_muzzle_flash = util::playfxontag(localclientnum, level._effect[var_a1f103c8], self, "tag_flash");
			}
			break;
		}
	}
}

/*
	Name: render_debug_sphere
	Namespace: zm_weap_scepter
	Checksum: 0x5B7F703A
	Offset: 0x1190
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function render_debug_sphere(origin, color)
{
	if(getdvarint(#"turret_debug", 0))
	{
		/#
			sphere(origin, 2, color, 0.75, 1, 10, 100);
		#/
	}
}

/*
	Name: function_7067b673
	Namespace: zm_weap_scepter
	Checksum: 0x7AD646C9
	Offset: 0x1208
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function function_7067b673(origin1, origin2, color)
{
	if(getdvarint(#"turret_debug", 0))
	{
		/#
			line(origin1, origin2, color, 0.75, 1, 100);
		#/
	}
}

/*
	Name: function_f11b8d1d
	Namespace: zm_weap_scepter
	Checksum: 0x2E158E00
	Offset: 0x1280
	Size: 0x136
	Parameters: 7
	Flags: Linked
*/
function function_f11b8d1d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_ff2eebc7))
		{
			str_tag = self zm_utility::function_467efa7b();
			self.var_ff2eebc7 = util::playfxontag(localclientnum, level._effect[#"hash_47a7d03689c68789"], self, str_tag);
			sndorigin = self gettagorigin(str_tag);
			playsound(0, #"zmb_vocals_zombie_skull_scream", sndorigin);
		}
	}
	else
	{
		if(isdefined(self.var_ff2eebc7))
		{
			deletefx(localclientnum, self.var_ff2eebc7, 1);
		}
		self.var_ff2eebc7 = undefined;
	}
}

/*
	Name: beacon_fx
	Namespace: zm_weap_scepter
	Checksum: 0x1F4D8296
	Offset: 0x13C0
	Size: 0x204
	Parameters: 7
	Flags: Linked
*/
function beacon_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.b_beacon_fx = 1;
		if(!isdefined(level.var_9b66c01))
		{
			level.var_9b66c01 = [];
		}
		if(!isinarray(level.var_9b66c01, self))
		{
			if(!isdefined(level.var_9b66c01))
			{
				level.var_9b66c01 = [];
			}
			else if(!isarray(level.var_9b66c01))
			{
				level.var_9b66c01 = array(level.var_9b66c01);
			}
			level.var_9b66c01[level.var_9b66c01.size] = self;
		}
		if(isdefined(self.b_beacon_fx) && self.b_beacon_fx)
		{
			self.n_beacon_fx = util::playfxontag(localclientnum, level._effect[#"scepter_bubble"], self, "tag_origin");
		}
	}
	else
	{
		self.b_beacon_fx = undefined;
		if(isdefined(self.n_beacon_fx))
		{
			deletefx(localclientnum, self.n_beacon_fx, 1);
			util::playfxontag(localclientnum, level._effect[#"hash_4c17911c3aed59ae"], self, "tag_origin");
			self.n_beacon_fx = undefined;
		}
		arrayremovevalue(level.var_9b66c01, self);
	}
}

/*
	Name: function_d05553c6
	Namespace: zm_weap_scepter
	Checksum: 0x7815ABD0
	Offset: 0x15D0
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
function private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue && !namespace_a6aea2c6::is_active(#"silent_film"))
	{
		self thread postfx::playpostfxbundle(#"hash_28d2c6df1a547302");
	}
}

/*
	Name: function_3f83a22f
	Namespace: zm_weap_scepter
	Checksum: 0xB7580BA9
	Offset: 0x1668
	Size: 0x186
	Parameters: 7
	Flags: Linked
*/
function function_3f83a22f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_local_player = function_5c10bd79(localclientnum);
	if(newval)
	{
		if(e_local_player != self)
		{
			self endon(#"death");
			if(!isdefined(self.var_aa9e07fe))
			{
				self.var_aa9e07fe = [];
			}
			if(isdefined(self.var_aa9e07fe[localclientnum]))
			{
				return;
			}
			if(!(isdefined(self.var_5427d523) && self.var_5427d523))
			{
				self.var_5427d523 = 1;
				self.var_aa9e07fe[localclientnum] = util::playfxontag(localclientnum, level._effect[#"scepter_heal"], self, "j_spine4");
				fxhandle = self.var_aa9e07fe[localclientnum];
				wait(0.5);
				if(isdefined(fxhandle))
				{
					stopfx(localclientnum, fxhandle);
					if(isdefined(self))
					{
						self.var_aa9e07fe[localclientnum] = undefined;
						self.var_5427d523 = undefined;
					}
				}
			}
		}
	}
}

/*
	Name: revive_fx
	Namespace: zm_weap_scepter
	Checksum: 0xDA53D036
	Offset: 0x17F8
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function revive_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.var_a776839a))
		{
			self.var_a776839a = util::playfxontag(localclientnum, level._effect[#"scepter_revive"], self, "tag_eye");
			sndorigin = self gettagorigin("J_Eyeball_LE");
			self playsound(localclientnum, #"hash_29c60da797dd7b3");
		}
	}
	else
	{
		if(isdefined(self.var_a776839a))
		{
			deletefx(localclientnum, self.var_a776839a, 1);
		}
		self.var_a776839a = undefined;
	}
}

/*
	Name: scepter_rumble
	Namespace: zm_weap_scepter
	Checksum: 0xD5FCBC26
	Offset: 0x1920
	Size: 0xFA
	Parameters: 7
	Flags: Linked
*/
function scepter_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		switch(newvalue)
		{
			case 2:
			{
				self playrumbleonentity(localclientnum, "zm_weap_scepter_melee_rumble");
				break;
			}
			case 5:
			{
				self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_rumble");
				break;
			}
			case 6:
			{
				self playrumbleonentity(localclientnum, "zm_weap_scepter_ray_hit_rumble");
				break;
			}
		}
	}
}

