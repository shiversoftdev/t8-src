// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_ab890501c40b73c;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_140c66e4;

/*
	Name: init
	Namespace: namespace_140c66e4
	Checksum: 0x65C0DE5
	Offset: 0x210
	Size: 0x136
	Parameters: 0
	Flags: Linked
*/
function init()
{
	zm_traps::register_trap_basic_info("boiling_bath", &trap_activate, &trap_audio);
	zm_traps::register_trap_damage("boiling_bath", &function_c7393b8d, &trap_damage);
	var_9bda8088 = getent("boiling_bath", "script_noteworthy");
	var_9bda8088._trap_duration = 20;
	var_9bda8088._trap_cooldown_time = 30;
	clientfield::register("actor", "boiling_trap_death_fx", 16000, 1, "int");
	level.var_4a0ddedd = 0;
	level.var_30ec2c9a = 0;
	level.var_d6ef5bfd = spawn("script_origin", (-2847, -1960, -20));
}

/*
	Name: trap_activate
	Namespace: namespace_140c66e4
	Checksum: 0xF2F6BC18
	Offset: 0x350
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function trap_activate()
{
	level notify(#"hash_e2465be027280d7");
	level exploder::exploder("fxexp_trap_bath_switch");
	playsoundatposition("zmb_water_activate", level.var_d6ef5bfd.origin);
	level.var_d6ef5bfd playloopsound(#"hash_7aab9873087e7a2d");
	level.var_c33299e2 = 0;
	level.var_bae901ce = 1;
	level function_922c05f();
	self thread zm_traps::trap_damage();
	wait(self._trap_duration);
	playsoundatposition("zmb_water_deactivate", level.var_d6ef5bfd.origin);
	level.var_d6ef5bfd stoploopsound(0.5);
	level notify(#"hash_36bc97f51bb2bc8");
	level function_5bf5b467();
	self notify(#"trap_done");
	self thread trap_cooldown();
}

/*
	Name: trap_cooldown
	Namespace: namespace_140c66e4
	Checksum: 0xC338AFDD
	Offset: 0x4D0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function trap_cooldown()
{
	self endon(#"death");
	self waittill(#"available");
	level exploder::stop_exploder("fxexp_trap_bath_switch");
}

/*
	Name: trap_audio
	Namespace: namespace_140c66e4
	Checksum: 0x80F724D1
	Offset: 0x520
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function trap_audio()
{
}

/*
	Name: function_c7393b8d
	Namespace: namespace_140c66e4
	Checksum: 0x4D7F9148
	Offset: 0x530
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_c7393b8d(var_9bda8088)
{
	if(isplayer(self) && zm_utility::is_player_valid(self, 0, 0, 0) && (!(isdefined(self.var_99557baf) && self.var_99557baf)))
	{
		self.var_99557baf = 1;
		level thread trap_damage_cooldown(self);
		self dodamage(25, self.origin);
	}
}

/*
	Name: trap_damage
	Namespace: namespace_140c66e4
	Checksum: 0x210BEEB4
	Offset: 0x5E8
	Size: 0x444
	Parameters: 1
	Flags: Linked
*/
function trap_damage(var_9bda8088)
{
	if(!isalive(self) || (isdefined(self.var_99557baf) && self.var_99557baf) || (isdefined(self.var_a1050f1) && self.var_a1050f1))
	{
		return;
	}
	self.var_99557baf = 1;
	level thread trap_damage_cooldown(self);
	switch(self.archetype)
	{
		case "zombie":
		{
			n_percent = 35;
			break;
		}
		case "hash_1bab8a0ba811401e":
		{
			n_percent = 35;
			break;
		}
		case "gegenees":
		{
			n_percent = 5;
			break;
		}
		case "blight_father":
		{
			n_percent = 5;
			break;
		}
		default:
		{
			n_percent = 35;
			break;
		}
	}
	if(isdefined(self.var_5c8ac43e) && self.var_5c8ac43e)
	{
		n_percent = 100;
	}
	n_percent = n_percent / 100;
	n_damage = int(self.maxhealth * n_percent);
	if(n_damage >= self.health)
	{
		level notify(#"trap_kill", {#e_trap:var_9bda8088, #e_victim:self});
		if(self.archetype === #"zombie")
		{
			level.var_c33299e2++;
			level function_922c05f();
			self clientfield::set("boiling_trap_death_fx", 1);
			if(randomint(100) < 50 && (!(isdefined(level.var_9b2dd86) && level.var_9b2dd86)))
			{
				level.var_9b2dd86 = 1;
				level thread function_49d1db63();
				self thread scene::play(#"hash_5fafdc05e3d99ac8", "Shot 1", self);
			}
			else
			{
				self dodamage(n_damage, var_9bda8088.origin);
			}
		}
		else
		{
			self dodamage(n_damage, var_9bda8088.origin);
		}
		if(isdefined(level.var_bae901ce) && level.var_bae901ce)
		{
			if(isdefined(var_9bda8088) && isplayer(var_9bda8088.activated_by_player))
			{
				var_9bda8088.activated_by_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_150ed78f0557df5f", 0.5, 1, 0, 1);
				level.var_bae901ce = undefined;
			}
		}
		if(isplayer(var_9bda8088.activated_by_player))
		{
			var_9bda8088.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
			var_9bda8088.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
		}
		self.var_a1050f1 = 1;
	}
	else
	{
		self dodamage(n_damage, var_9bda8088.origin);
	}
}

/*
	Name: trap_damage_cooldown
	Namespace: namespace_140c66e4
	Checksum: 0x7884C8FB
	Offset: 0xA38
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function trap_damage_cooldown(e_victim)
{
	wait(0.5);
	if(isdefined(e_victim))
	{
		e_victim.var_99557baf = undefined;
	}
}

/*
	Name: function_49d1db63
	Namespace: namespace_140c66e4
	Checksum: 0x3E9B762B
	Offset: 0xA68
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function function_49d1db63()
{
	wait(0.5);
	level.var_9b2dd86 = undefined;
}

/*
	Name: function_922c05f
	Namespace: namespace_140c66e4
	Checksum: 0x6EB2DCBE
	Offset: 0xA88
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_922c05f()
{
	if(level.var_c33299e2 < 4 && !level.var_30ec2c9a && !level.var_4a0ddedd)
	{
		level exploder::exploder("fxexp_trap_bath");
	}
	else if(level.var_c33299e2 == 4 && !level.var_30ec2c9a || level.var_4a0ddedd)
	{
		level function_2b2e6b4();
		level exploder::exploder("fxexp_trap_bath_bloody_lvl1");
		level exploder::exploder("exp_lgt_bath_trap");
		level exploder::stop_exploder("fxexp_trap_bath");
		level thread function_3a067395("fxexp_trap_bath_bloody_lvl1");
	}
	else if(level.var_c33299e2 == 10 || level.var_30ec2c9a)
	{
		level function_2b2e6b4();
		level exploder::exploder("fxexp_trap_bath_bloody_lvl2");
		level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1");
		level thread function_3a067395("fxexp_trap_bath_bloody_lvl2");
	}
}

/*
	Name: function_3a067395
	Namespace: namespace_140c66e4
	Checksum: 0xB50368BC
	Offset: 0xC58
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function function_3a067395(str_exploder)
{
	self notify("5a3476fe6548df85");
	self endon("5a3476fe6548df85");
	level endon(#"end_game", #"hash_e2465be027280d7");
	level waittill(#"hash_36bc97f51bb2bc8");
	if(str_exploder == "fxexp_trap_bath_bloody_lvl1")
	{
		level.var_4a0ddedd = 1;
		level exploder::exploder("fxexp_trap_bath_bloody_lvl1_linger");
		wait(30);
		level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
		level.var_4a0ddedd = 0;
		level exploder::stop_exploder("exp_lgt_bath_trap");
	}
	else
	{
		level.var_30ec2c9a = 1;
		level exploder::exploder("fxexp_trap_bath_bloody_lvl2_linger");
		wait(30);
		level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2_linger");
		level.var_30ec2c9a = 0;
		level.var_4a0ddedd = 1;
		level exploder::exploder("fxexp_trap_bath_bloody_lvl1_linger");
		wait(30);
		level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
		level.var_4a0ddedd = 0;
		level exploder::stop_exploder("exp_lgt_bath_trap");
	}
}

/*
	Name: function_2b2e6b4
	Namespace: namespace_140c66e4
	Checksum: 0xC50B49B8
	Offset: 0xE18
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_2b2e6b4()
{
	level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1_linger");
	level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2_linger");
	level.var_4a0ddedd = 0;
	level.var_30ec2c9a = 0;
}

/*
	Name: function_5bf5b467
	Namespace: namespace_140c66e4
	Checksum: 0x684485CA
	Offset: 0xE80
	Size: 0x64
	Parameters: 0
	Flags: Linked
*/
function function_5bf5b467()
{
	level exploder::stop_exploder("fxexp_trap_bath");
	level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl1");
	level exploder::stop_exploder("fxexp_trap_bath_bloody_lvl2");
}

