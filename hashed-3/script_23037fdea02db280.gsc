// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4b8e80d5d6c93ae1;
#using script_70ab01a7690ea256;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm\zm_lightning_chain.csc;
#using scripts\zm_common\zm_utility.csc;

#namespace zm_weap_gravityspikes;

/*
	Name: function_89f2df9
	Namespace: zm_weap_gravityspikes
	Checksum: 0x56090C3A
	Offset: 0x2F8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_weap_gravityspikes", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_weap_gravityspikes
	Checksum: 0x5A692F25
	Offset: 0x340
	Size: 0x312
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	register_clientfields();
	level._effect[#"gravityspikes_destroy"] = #"hash_2b135053e0f7140";
	level._effect[#"gravityspikes_location"] = #"hash_22bdc8201af7b841";
	level._effect[#"gravityspikes_slam"] = #"hash_2714b949033af35d";
	level._effect[#"gravityspikes_slam_1p"] = #"hash_4e7dd6f6f41ead5f";
	level._effect[#"gravityspikes_trap_start"] = #"hash_779eebf7aed3f4c0";
	level._effect[#"gravityspikes_trap_loop"] = #"hash_7df2dbfda69b0792";
	level._effect[#"gravityspikes_trap_end"] = #"hash_70f0169b86a98ce1";
	level._effect[#"hash_4c08abb54cbb5556"] = #"hash_74ea4245b0e1646d";
	level._effect[#"hash_2c2dcd840a548ef2"] = #"hash_77964e1811bb9a67";
	level._effect[#"hash_1758af99ff212148"] = #"hash_74f12e45b0e7611f";
	level._effect[#"gravity_trap_spike_spark"] = #"hash_34fb31ef6c57f845";
	level._effect[#"zombie_sparky"] = #"hash_751b9a4bf53bfb69";
	level._effect[#"zombie_spark_light"] = #"hash_28908b7bf0b56107";
	level._effect[#"zombie_spark_trail"] = #"hash_5e483d0e64c5d58";
	level._effect[#"gravity_spike_zombie_explode"] = #"hash_62cd02e76c0d3da0";
	level._effect[#"hash_d73bbc3bff0a6f3"] = #"hash_5959ee9eff7b2eac";
}

/*
	Name: register_clientfields
	Namespace: zm_weap_gravityspikes
	Checksum: 0xEA1D32A9
	Offset: 0x660
	Size: 0x43C
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("actor", "gravity_slam_down", 1, 1, "int", &gravity_slam_down, 0, 0);
	clientfield::register("scriptmover", "gravity_trap_fx", 1, 1, "int", &gravity_trap_fx, 0, 0);
	clientfield::register("scriptmover", "gravity_trap_spike_spark", 1, 1, "int", &gravity_trap_spike_spark, 0, 0);
	clientfield::register("scriptmover", "gravity_trap_destroy", 1, 1, "counter", &gravity_trap_destroy, 0, 0);
	clientfield::register("scriptmover", "gravity_trap_location", 1, 1, "int", &gravity_trap_location, 0, 0);
	clientfield::register("scriptmover", "gravity_slam_fx", 1, 1, "int", &gravity_slam_fx, 0, 0);
	clientfield::register("toplayer", "gravity_slam_player_fx", 1, 1, "counter", &gravity_slam_player_fx, 0, 0);
	clientfield::register("actor", "sparky_beam_fx", 1, 1, "int", &play_sparky_beam_fx, 0, 0);
	clientfield::register("actor", "sparky_zombie_fx", 1, 1, "int", &sparky_zombie_fx_cb, 0, 0);
	clientfield::register("actor", "sparky_zombie_trail_fx", 1, 1, "int", &sparky_zombie_trail_fx_cb, 0, 0);
	clientfield::register("actor", "ragdoll_impact_watch", 1, 1, "int", &ragdoll_impact_watch_start, 0, 0);
	clientfield::register("allplayers", "gravity_shock_wave_fx", 1, 1, "int", &gravity_shock_wave_fx, 0, 0);
	clientfield::register("toplayer", "hero_gravityspikes_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
	clientfield::register("actor", "gravity_aoe_impact_fx", -1, 1, "int", &gravity_aoe_impact_fx, 0, 0);
	clientfield::register("actor", "gravity_aoe_impact_tu6", 6000, 1, "counter", &gravity_aoe_impact_fx, 0, 0);
}

/*
	Name: gravity_slam_down
	Namespace: zm_weap_gravityspikes
	Checksum: 0x16A9A3BF
	Offset: 0xAA8
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function gravity_slam_down(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self launchragdoll(vectorscale((0, 0, -1), 200));
	}
}

/*
	Name: gravity_slam_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0x31E74EF
	Offset: 0xB18
	Size: 0xCC
	Parameters: 7
	Flags: Linked
*/
function gravity_slam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.slam_fx))
		{
			deletefx(localclientnum, self.slam_fx, 1);
		}
		util::playfxontag(localclientnum, level._effect[#"gravityspikes_slam"], self, "tag_origin");
		self playsound(0, #"hash_79ac4ef26925a30f");
	}
}

/*
	Name: gravity_slam_player_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0x8F39ED11
	Offset: 0xBF0
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function gravity_slam_player_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfxoncamera(localclientnum, level._effect[#"gravityspikes_slam_1p"]);
}

/*
	Name: gravity_trap_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0xB349C465
	Offset: 0xC68
	Size: 0x31C
	Parameters: 7
	Flags: Linked
*/
function gravity_trap_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.b_gravity_trap_fx = 1;
		self thread gravity_trap_rumble(localclientnum);
		if(!isdefined(level.a_mdl_gravity_traps))
		{
			level.a_mdl_gravity_traps = [];
		}
		if(!isinarray(level.a_mdl_gravity_traps, self))
		{
			if(!isdefined(level.a_mdl_gravity_traps))
			{
				level.a_mdl_gravity_traps = [];
			}
			else if(!isarray(level.a_mdl_gravity_traps))
			{
				level.a_mdl_gravity_traps = array(level.a_mdl_gravity_traps);
			}
			level.a_mdl_gravity_traps[level.a_mdl_gravity_traps.size] = self;
		}
		if(!isdefined(self.var_cacf63a9))
		{
			self playsound(0, #"hash_39e42a22827220d1");
			self.var_cacf63a9 = self playloopsound(#"hash_9c25e71ff13ac77");
		}
		util::playfxontag(localclientnum, level._effect[#"gravityspikes_trap_start"], self, "tag_origin");
		wait(0.5);
		if(isdefined(self) && (isdefined(self.b_gravity_trap_fx) && self.b_gravity_trap_fx))
		{
			self.n_gravity_trap_fx = util::playfxontag(localclientnum, level._effect[#"gravityspikes_trap_loop"], self, "tag_origin");
		}
	}
	else
	{
		self notify(#"vortex_stop");
		self.b_gravity_trap_fx = undefined;
		if(isdefined(self.n_gravity_trap_fx))
		{
			deletefx(localclientnum, self.n_gravity_trap_fx, 1);
			self.n_gravity_trap_fx = undefined;
		}
		if(isdefined(self.var_cacf63a9))
		{
			self playsound(0, #"hash_5d0917b44402f070");
			self stoploopsound(self.var_cacf63a9);
		}
		arrayremovevalue(level.a_mdl_gravity_traps, self);
		util::playfxontag(localclientnum, level._effect[#"gravityspikes_trap_end"], self, "tag_origin");
	}
}

/*
	Name: gravity_trap_spike_spark
	Namespace: zm_weap_gravityspikes
	Checksum: 0x6B60ADFF
	Offset: 0xF90
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function gravity_trap_spike_spark(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.spark_fx_id = util::playfxontag(localclientnum, level._effect[#"gravity_trap_spike_spark"], self, "tag_origin");
	}
	else if(isdefined(self.spark_fx_id))
	{
		deletefx(localclientnum, self.spark_fx_id, 1);
	}
}

/*
	Name: gravity_trap_location
	Namespace: zm_weap_gravityspikes
	Checksum: 0x3E354A9D
	Offset: 0x1050
	Size: 0xC6
	Parameters: 7
	Flags: Linked
*/
function gravity_trap_location(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.fx_id_location = util::playfxontag(localclientnum, level._effect[#"gravityspikes_location"], self, "tag_origin");
	}
	else if(isdefined(self.fx_id_location))
	{
		deletefx(localclientnum, self.fx_id_location, 1);
		self.fx_id_location = undefined;
	}
}

/*
	Name: gravity_trap_rumble
	Namespace: zm_weap_gravityspikes
	Checksum: 0x5C32576B
	Offset: 0x1120
	Size: 0x68
	Parameters: 1
	Flags: Linked, Private
*/
private function gravity_trap_rumble(localclientnum)
{
	self endon(#"vortex_stop", #"death");
	while(isdefined(self))
	{
		self playrumbleonentity(localclientnum, "zm_weap_gravityspikes_vortex");
		wait(0.15);
	}
}

/*
	Name: gravity_trap_destroy
	Namespace: zm_weap_gravityspikes
	Checksum: 0xE9757DD3
	Offset: 0x1190
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function gravity_trap_destroy(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	playfx(localclientnum, level._effect[#"gravityspikes_destroy"], self.origin);
}

/*
	Name: ragdoll_impact_watch_start
	Namespace: zm_weap_gravityspikes
	Checksum: 0x936D230C
	Offset: 0x1210
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function ragdoll_impact_watch_start(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		self thread ragdoll_impact_watch(localclientnum);
	}
}

/*
	Name: ragdoll_impact_watch
	Namespace: zm_weap_gravityspikes
	Checksum: 0x147AF9C0
	Offset: 0x1280
	Size: 0x212
	Parameters: 1
	Flags: Linked
*/
function ragdoll_impact_watch(localclientnum)
{
	self.v_start_pos = self.origin;
	n_gib_speed = 20;
	v_prev_origin = self.origin;
	waitframe(1);
	if(!isdefined(self))
	{
		return;
	}
	v_prev_vel = self.origin - v_prev_origin;
	n_prev_speed = length(v_prev_vel);
	v_prev_origin = self.origin;
	waitframe(1);
	while(true)
	{
		if(!isdefined(self))
		{
			return;
		}
		v_vel = self.origin - v_prev_origin;
		n_speed = length(v_vel);
		if(n_speed < n_prev_speed * 0.5 && n_speed <= n_gib_speed && !b_first_loop)
		{
			if(self.origin[2] > self.v_start_pos[2] + 128)
			{
				if(isdefined(level._effect[#"zombie_guts_explosion"]) && util::is_mature())
				{
					playfx(localclientnum, level._effect[#"zombie_guts_explosion"], self.origin, anglestoforward(self.angles));
				}
				self hide();
			}
			break;
		}
		v_prev_origin = self.origin;
		n_prev_speed = n_speed;
		b_first_loop = 0;
		waitframe(1);
	}
}

/*
	Name: play_sparky_beam_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0x881D3C58
	Offset: 0x14A0
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function play_sparky_beam_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(self.archetype === #"zombie_dog")
		{
			return;
		}
		if(isdefined(level.a_mdl_gravity_traps))
		{
			mdl_gravity_trap = arraygetclosest(self.origin, level.a_mdl_gravity_traps);
		}
		if(isdefined(mdl_gravity_trap))
		{
			self.e_sparky_beam = beamlaunch(localclientnum, mdl_gravity_trap, "tag_origin", self, "j_spineupper", "electric_lightning_dg4_trap");
		}
	}
	else if(isdefined(self.e_sparky_beam))
	{
		beamkill(localclientnum, self.e_sparky_beam);
	}
}

/*
	Name: sparky_zombie_fx_cb
	Namespace: zm_weap_gravityspikes
	Checksum: 0xA617D6ED
	Offset: 0x15C0
	Size: 0x236
	Parameters: 7
	Flags: Linked
*/
function sparky_zombie_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		if(!isdefined(self.sparky_loop_snd))
		{
			self playsound(localclientnum, #"wpn_dg4_electrocution_impact");
			self.sparky_loop_snd = self playloopsound("wpn_dg4_electrocution_loop");
		}
		self.var_16dc5d7c = util::playfxontag(localclientnum, level._effect[#"zombie_sparky"], self, "J_SpineUpper");
		if(isdefined(self.var_16dc5d7c))
		{
			setfxignorepause(localclientnum, self.var_16dc5d7c, 1);
		}
		self.var_499b8f7 = util::playfxontag(localclientnum, level._effect[#"zombie_spark_light"], self, "J_SpineUpper");
		if(isdefined(self.var_499b8f7))
		{
			setfxignorepause(localclientnum, self.var_499b8f7, 1);
		}
	}
	else if(isdefined(self.var_16dc5d7c))
	{
		deletefx(localclientnum, self.var_16dc5d7c, 1);
		self.var_16dc5d7c = undefined;
	}
	if(isdefined(self.var_499b8f7))
	{
		deletefx(localclientnum, self.var_499b8f7, 1);
		self.var_499b8f7 = undefined;
	}
	if(isdefined(self.sparky_loop_snd))
	{
		self stoploopsound(self.sparky_loop_snd);
		self.sparky_loop_snd = undefined;
	}
}

/*
	Name: sparky_zombie_trail_fx_cb
	Namespace: zm_weap_gravityspikes
	Checksum: 0x95B83595
	Offset: 0x1800
	Size: 0xFE
	Parameters: 7
	Flags: Linked
*/
function sparky_zombie_trail_fx_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.n_trail_fx = util::playfxontag(localclientnum, level._effect[#"zombie_spark_trail"], self, "J_SpineUpper");
		if(isdefined(self) && isdefined(self.n_trail_fx))
		{
			setfxignorepause(localclientnum, self.n_trail_fx, 1);
		}
	}
	else if(isdefined(self.n_trail_fx))
	{
		deletefx(localclientnum, self.n_trail_fx, 1);
	}
	self.n_trail_fx = undefined;
}

/*
	Name: gravity_spike_zombie_explode
	Namespace: zm_weap_gravityspikes
	Checksum: 0x885052B
	Offset: 0x1908
	Size: 0x8C
	Parameters: 7
	Flags: None
*/
function gravity_spike_zombie_explode(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self util::waittill_dobj(localclientnum);
	util::playfxontag(localclientnum, level._effect[#"gravity_spike_zombie_explode"], self, "j_spine4");
}

/*
	Name: gravity_shock_wave_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0x724C00D9
	Offset: 0x19A0
	Size: 0x430
	Parameters: 7
	Flags: Linked
*/
function gravity_shock_wave_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(!isdefined(self.var_faf5c3df))
	{
		self.var_faf5c3df = [];
	}
	if(!isdefined(self.var_c145bf0d))
	{
		self.var_c145bf0d = [];
	}
	if(!isdefined(self.var_ededa1))
	{
		self.var_ededa1 = [];
	}
	if(isdefined(self.var_faf5c3df[localclientnum]))
	{
		deletefx(localclientnum, self.var_faf5c3df[localclientnum], 1);
		self.var_faf5c3df[localclientnum] = undefined;
	}
	if(isdefined(self.var_c145bf0d[localclientnum]))
	{
		deletefx(localclientnum, self.var_c145bf0d[localclientnum], 1);
		self.var_c145bf0d[localclientnum] = undefined;
	}
	if(isdefined(self.var_aff8c2c0))
	{
		self playsound(localclientnum, #"hash_4dee0eab8f9ef57");
		self stoploopsound(self.var_aff8c2c0);
		self.var_aff8c2c0 = undefined;
	}
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(!e_player util::function_50ed1561(localclientnum))
		{
			e_player notify(#"hash_5ebde0f1ebad91b3");
		}
	}
	if(newval == 1)
	{
		if(!isdefined(self.var_aff8c2c0))
		{
			self.var_aff8c2c0 = self playloopsound(#"hash_7c8577b82afb225d");
		}
		if(self zm_utility::function_f8796df3(localclientnum))
		{
			self.var_c145bf0d[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_4c08abb54cbb5556"], "tag_weapon");
			self.var_faf5c3df[localclientnum] = playviewmodelfx(localclientnum, level._effect[#"hash_2c2dcd840a548ef2"], "tag_weapon_le");
		}
		else
		{
			self.var_c145bf0d[localclientnum] = util::playfxontag(localclientnum, level._effect[#"hash_1758af99ff212148"], self, "tag_weapon");
		}
		a_e_players = getlocalplayers();
		foreach(e_player in a_e_players)
		{
			if(!e_player util::function_50ed1561(localclientnum))
			{
				e_player thread zm_utility::function_ae3780f1(localclientnum, self.var_c145bf0d[localclientnum], #"hash_5ebde0f1ebad91b3");
			}
		}
	}
}

/*
	Name: function_d05553c6
	Namespace: zm_weap_gravityspikes
	Checksum: 0x2C54C001
	Offset: 0x1DD8
	Size: 0x8C
	Parameters: 7
	Flags: Linked, Private
*/
private function function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue && !namespace_a6aea2c6::is_active(#"hash_65cfe78dc61dd3af"))
	{
		self thread postfx::playpostfxbundle(#"hash_74fd0cf7c91d14d0");
	}
}

/*
	Name: gravity_aoe_impact_fx
	Namespace: zm_weap_gravityspikes
	Checksum: 0x8BBAF362
	Offset: 0x1E70
	Size: 0x1A6
	Parameters: 7
	Flags: Linked
*/
function gravity_aoe_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(isdefined(self.var_a1e2affa))
	{
		return;
	}
	str_tag = self zm_utility::function_467efa7b();
	self.var_a1e2affa = util::playfxontag(localclientnum, level._effect[#"hash_d73bbc3bff0a6f3"], self, str_tag);
	if(!isdefined(self.var_747bc8da))
	{
		self playsound(localclientnum, #"wpn_dg4_electrocution_impact");
		self.var_747bc8da = self playloopsound(#"wpn_dg4_electrocution_loop");
	}
	self waittill_timeout(0.5, #"death");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(self.var_a1e2affa))
	{
		deletefx(localclientnum, self.var_a1e2affa, 1);
		self.var_a1e2affa = undefined;
	}
	if(isdefined(self.var_747bc8da))
	{
		self stoploopsound(self.var_747bc8da);
		self.var_747bc8da = undefined;
	}
}

