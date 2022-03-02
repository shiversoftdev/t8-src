// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\footsteps_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace namespace_713ac4fe;

/*
	Name: init
	Namespace: namespace_713ac4fe
	Checksum: 0x93251D9F
	Offset: 0x298
	Size: 0x2A4
	Parameters: 0
	Flags: AutoExec
*/
function autoexec init()
{
	ai::add_archetype_spawn_function(#"elephant", &function_4c731a08);
	clientfield::register("actor", "towers_boss_melee_effect", 1, 1, "counter", &function_4d07056d, 0, 0);
	clientfield::register("actor", "tower_boss_death_fx", 1, 1, "counter", &function_58e13aab, 0, 0);
	clientfield::register("scriptmover", "entrails_model_cf", 1, 1, "int", &function_e3038292, 0, 0);
	clientfield::register("scriptmover", "towers_boss_head_proj_fx_cf", 1, 1, "int", &function_5f5f6a25, 0, 0);
	clientfield::register("scriptmover", "towers_boss_head_proj_explosion_fx_cf", 1, 1, "int", &function_1308296f, 0, 0);
	clientfield::register("actor", "towers_boss_eye_fx_cf", 1, 2, "int", &function_624041b1, 0, 0);
	clientfield::register("actor", "boss_death_rob", 1, 2, "int", &function_e1fb79d0, 0, 0);
	footsteps::registeraitypefootstepcb(#"elephant", &function_fe0bb012);
	clientfield::register("actor", "sndTowersBossArmor", 1, 1, "int", &sndtowersbossarmor, 0, 0);
}

/*
	Name: function_4c731a08
	Namespace: namespace_713ac4fe
	Checksum: 0x99EE33AE
	Offset: 0x548
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4c731a08(localclientnum)
{
	self function_bf9d3071("rob_zm_eyes_red");
}

/*
	Name: function_624041b1
	Namespace: namespace_713ac4fe
	Checksum: 0xF2E1927
	Offset: 0x580
	Size: 0xE4
	Parameters: 7
	Flags: Linked
*/
function function_624041b1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self.var_d62cdc72 = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_eye_glow", self, "tag_eye");
	}
	else
	{
		if(newval == 2)
		{
			self.var_d62cdc72 = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_eye_glow_alt", self, "tag_eye");
		}
		else if(isdefined(self.var_d62cdc72))
		{
			stopfx(localclientnum, self.var_d62cdc72);
		}
	}
}

/*
	Name: function_e1fb79d0
	Namespace: namespace_713ac4fe
	Checksum: 0xD14E19E7
	Offset: 0x670
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_e1fb79d0(var_99c2529a, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		self function_5d482e78("rob_zm_eyes_red");
		self function_bf9d3071(#"hash_782edffb9e72130");
	}
	else
	{
		self function_5d482e78(#"hash_782edffb9e72130");
	}
}

/*
	Name: function_e3038292
	Namespace: namespace_713ac4fe
	Checksum: 0xB86E2B5C
	Offset: 0x728
	Size: 0x84
	Parameters: 7
	Flags: Linked
*/
function function_e3038292(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!util::is_mature() || util::is_gib_restricted_build())
		{
			self hide();
		}
	}
}

/*
	Name: function_5f5f6a25
	Namespace: namespace_713ac4fe
	Checksum: 0xF1140204
	Offset: 0x7B8
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_5f5f6a25(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_eye_trail", self, "tag_origin");
	}
	else if(isdefined(self.fx))
	{
		stopfx(localclientnum, self.fx);
	}
}

/*
	Name: function_1308296f
	Namespace: namespace_713ac4fe
	Checksum: 0x5631649
	Offset: 0x868
	Size: 0xA4
	Parameters: 7
	Flags: Linked
*/
function function_1308296f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.fx = util::playfxontag(localclientnum, "maps/zm_towers/fx8_boss_attack_eye_trail_split", self, "tag_origin");
	}
	else if(isdefined(self.fx))
	{
		stopfx(localclientnum, self.fx);
	}
}

/*
	Name: function_4d07056d
	Namespace: namespace_713ac4fe
	Checksum: 0xD15A338C
	Offset: 0x918
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function function_4d07056d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(self gettagorigin("j_nose4"), e_player.origin);
	var_b12c8a00 = 1400 * 1400;
	n_scale = (var_b12c8a00 - n_dist) / var_b12c8a00;
	if(n_scale > 0.01)
	{
		earthquake(localclientnum, n_scale, 1, self.origin, n_dist);
		if(n_scale <= 0.25 && n_scale > 0.2)
		{
			function_36e4ebd4(localclientnum, "tank_fire");
		}
		else
		{
			function_36e4ebd4(localclientnum, "damage_heavy");
		}
		physicsexplosionsphere(localclientnum, self.origin, 400, 100, 20);
	}
}

/*
	Name: function_58e13aab
	Namespace: namespace_713ac4fe
	Checksum: 0x9AA739D0
	Offset: 0xAB0
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function function_58e13aab(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	e_player = function_5c10bd79(localclientnum);
	earthquake(localclientnum, 0.6, 1, self.origin, 4000);
	function_36e4ebd4(localclientnum, "tank_fire");
	physicsexplosionsphere(localclientnum, self.origin, 2000, 100, 4);
}

/*
	Name: function_fe0bb012
	Namespace: namespace_713ac4fe
	Checksum: 0x10763C38
	Offset: 0xB90
	Size: 0x134
	Parameters: 5
	Flags: Linked
*/
function function_fe0bb012(localclientnum, pos, surface, notetrack, bone)
{
	e_player = function_5c10bd79(localclientnum);
	n_dist = distancesquared(pos, e_player.origin);
	var_b12c8a00 = 1200 * 1200;
	if(n_dist < var_b12c8a00)
	{
		earthquake(localclientnum, 0.1, 0.5, self.origin, n_dist);
		function_36e4ebd4(localclientnum, "damage_light");
		if(isdefined(bone))
		{
			origin = self gettagorigin(bone);
			physicsexplosionsphere(localclientnum, origin, 200, 20, 20);
		}
	}
}

/*
	Name: sndtowersbossarmor
	Namespace: namespace_713ac4fe
	Checksum: 0x1DB59892
	Offset: 0xCD0
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function sndtowersbossarmor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, var_1e231644)
{
	if(newval == 1)
	{
		setsoundcontext("supernicedude", "armor");
	}
	else
	{
		setsoundcontext("supernicedude", "");
	}
}

