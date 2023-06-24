// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\globallogic\globallogic_score.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\damagefeedback_shared.gsc;
#using scripts\core_common\gestures.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace status_effect;

/*
	Name: register_status_effect
	Namespace: status_effect
	Checksum: 0xCFAD524E
	Offset: 0xE8
	Size: 0x66
	Parameters: 1
	Flags: Linked, Private
*/
function private register_status_effect(status_effect_type)
{
	if(!isdefined(level._status_effects))
	{
		level._status_effects = [];
	}
	if(!isdefined(level._status_effects[status_effect_type]))
	{
		level._status_effects[status_effect_type] = spawnstruct();
	}
}

/*
	Name: function_6f4eaf88
	Namespace: status_effect
	Checksum: 0xC83D8710
	Offset: 0x158
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_6f4eaf88(var_756fda07)
{
	if(!isdefined(var_756fda07))
	{
		/#
			println("");
		#/
		return;
	}
	if(!isdefined(var_756fda07.setype))
	{
		var_756fda07.setype = 0;
	}
	register_status_effect(var_756fda07.setype);
	level.var_233471d2[var_756fda07.setype] = var_756fda07;
}

/*
	Name: register_status_effect_callback_apply
	Namespace: status_effect
	Checksum: 0x48032C9E
	Offset: 0x1F8
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function register_status_effect_callback_apply(status_effect, apply_func)
{
	register_status_effect(status_effect);
	if(isdefined(apply_func))
	{
		level._status_effects[status_effect].apply = apply_func;
	}
}

/*
	Name: function_b24f18a1
	Namespace: status_effect
	Checksum: 0x2A9A145C
	Offset: 0x258
	Size: 0x146
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b24f18a1()
{
	if(isdefined(self.owner))
	{
		if(function_7d17822(self.setype))
		{
			self.owner function_89ae38c1(self.namehash);
		}
		if(isdefined(self.var_36c77790))
		{
			if(isplayer(self.owner))
			{
				self.owner playlocalsound(self.var_36c77790);
			}
		}
		if(isdefined(self.var_801118b0))
		{
			if(isplayer(self.owner))
			{
				self.owner stoploopsound(0.5);
			}
		}
		self.owner function_14fdd7e2(self.var_4f6b79a4);
		self [[level._status_effects[self.setype].var_a4c649a2]]();
		self.owner.var_121392a1[self.var_18d16a6b] = undefined;
		self notify(#"endstatuseffect");
	}
}

/*
	Name: function_5bae5120
	Namespace: status_effect
	Checksum: 0xB661C2B3
	Offset: 0x3A8
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function function_5bae5120(status_effect, end_func)
{
	register_status_effect(status_effect);
	if(isdefined(end_func))
	{
		level._status_effects[status_effect].end = &function_b24f18a1;
		level._status_effects[status_effect].var_a4c649a2 = end_func;
		level._status_effects[status_effect].death = level._status_effects[status_effect].end;
	}
}

/*
	Name: function_6d888241
	Namespace: status_effect
	Checksum: 0x7C3425DE
	Offset: 0x458
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function function_6d888241(status_effect, death_func)
{
	register_status_effect(status_effect);
	if(isdefined(death_func))
	{
		level._status_effects[status_effect].death = death_func;
	}
}

/*
	Name: function_e2bff3ce
	Namespace: status_effect
	Checksum: 0x7C348F82
	Offset: 0x4B8
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function function_e2bff3ce(status_effect_type, weapon, var_84171a6c)
{
	if(isdefined(level.var_233471d2[status_effect_type]))
	{
		self status_effect_apply(level.var_233471d2[status_effect_type], weapon, var_84171a6c);
	}
}

/*
	Name: function_91a9db75
	Namespace: status_effect
	Checksum: 0x966A1798
	Offset: 0x520
	Size: 0x15A
	Parameters: 3
	Flags: Linked, Private
*/
function private function_91a9db75(sourcetype, setype, namehash)
{
	if(!isdefined(self.var_121392a1))
	{
		self.var_121392a1 = [];
	}
	if(!isdefined(self.var_121392a1[sourcetype]))
	{
		self.var_121392a1[sourcetype] = spawnstruct();
	}
	if(!isdefined(self.var_121392a1[sourcetype].duration))
	{
		self.var_121392a1[sourcetype].duration = 0;
	}
	if(!isdefined(self.var_121392a1[sourcetype].endtime))
	{
		self.var_121392a1[sourcetype].endtime = 0;
	}
	if(!isdefined(self.var_121392a1[sourcetype].owner))
	{
		self.var_121392a1[sourcetype].owner = self;
	}
	self.var_121392a1[sourcetype].setype = setype;
	self.var_121392a1[sourcetype].namehash = namehash;
	self.var_121392a1[sourcetype].var_18d16a6b = sourcetype;
}

/*
	Name: status_effect_apply
	Namespace: status_effect
	Checksum: 0x9C6A35EB
	Offset: 0x688
	Size: 0x83C
	Parameters: 7
	Flags: Linked
*/
function status_effect_apply(var_756fda07, weapon, var_84171a6c, var_80e47495, var_ab5b905e, var_894859a2, location)
{
	/#
		assert(isdefined(var_756fda07.setype));
	#/
	/#
		assert(isdefined(var_756fda07.var_18d16a6b));
	#/
	if(isdefined(self.registerpreparing_time_) && self.registerpreparing_time_)
	{
		return;
	}
	if(isdefined(var_894859a2))
	{
		var_756fda07.var_77449e9 = var_756fda07.var_77449e9 * var_894859a2;
		if(isdefined(var_ab5b905e))
		{
			var_ab5b905e = var_ab5b905e * var_894859a2;
		}
	}
	register_status_effect(var_756fda07.setype);
	var_f8f8abaa = 0;
	if(isdefined(var_84171a6c) && var_84171a6c != self && !self function_4aac137f(var_84171a6c, var_756fda07.var_18d16a6b))
	{
		var_b7a9b136 = 1;
		if(isdefined(var_756fda07.var_2e4a8800))
		{
			var_8725a10d = globallogic_score::function_3cbc4c6c(var_756fda07.var_2e4a8800);
		}
		if(isdefined(var_8725a10d) && isdefined(var_8725a10d.var_3e3b11a9))
		{
			resistance = function_3c54ae98(var_756fda07.setype);
			if(var_8725a10d.var_3e3b11a9 < resistance)
			{
				var_b7a9b136 = 0;
			}
		}
		if(var_b7a9b136 && util::function_fbce7263(self.team, var_84171a6c.team))
		{
			var_84171a6c thread globallogic_score::function_969ea48d(var_756fda07, weapon);
		}
		var_f8f8abaa = 1;
	}
	self function_91a9db75(var_756fda07.var_18d16a6b, var_756fda07.setype, var_756fda07.namehash);
	self function_52969ffe(var_756fda07);
	self callback::callback(#"hash_4acc79bbf6402a39", var_756fda07);
	var_275b5e13 = function_2ba2756c(var_756fda07.var_18d16a6b) > level.time;
	var_b0144580 = var_84171a6c === self;
	if(!isdefined(var_80e47495))
	{
		var_80e47495 = getdvarint(#"hash_6ce4aefbba354e2d", 0);
	}
	effect = self.var_121392a1[var_756fda07.var_18d16a6b];
	effect.var_4f6b79a4 = var_756fda07;
	if(isdefined(location))
	{
		effect.location = location;
	}
	else if(isdefined(var_84171a6c))
	{
		effect.location = var_84171a6c.origin;
	}
	effect handle_sounds(var_756fda07);
	var_4df0ea83 = 1;
	if(isdefined(var_756fda07.var_4df0ea83))
	{
		var_4df0ea83 = var_756fda07.var_4df0ea83;
	}
	if(var_4df0ea83)
	{
		if(var_80e47495 && var_756fda07.setype != 4)
		{
			effect function_57f33b96(var_756fda07, var_b0144580, var_ab5b905e, var_84171a6c, var_f8f8abaa, weapon);
		}
		else
		{
			effect function_cc42cac2(var_756fda07, var_b0144580, var_ab5b905e, var_84171a6c, var_f8f8abaa, weapon);
		}
	}
	maxduration = effect function_f9ca1b6a(var_756fda07);
	if(maxduration > 0 && self.var_121392a1[var_756fda07.var_18d16a6b].duration > maxduration)
	{
		self.var_121392a1[var_756fda07.var_18d16a6b].duration = maxduration;
	}
	else if(self.var_121392a1[var_756fda07.var_18d16a6b].duration > 65536 - 1)
	{
		self.var_121392a1[var_756fda07.var_18d16a6b].duration = 65536 - 1;
	}
	if(isdefined(weapon) && weapon.doesfiredamage)
	{
		if(isplayer(self))
		{
			self clientfield::set("burn", 1);
		}
	}
	if(!var_275b5e13)
	{
		effect function_5d973c5f();
	}
	if(isdefined(level._status_effects[var_756fda07.setype].apply))
	{
		effect.var_4b22e697 = var_84171a6c;
		effect.var_3d1ed4bd = weapon;
		effect thread [[level._status_effects[var_756fda07.setype].apply]](var_756fda07, weapon, var_84171a6c);
		thread function_86c0eb67(effect, "begin");
	}
	var_1d673e46 = !isplayer(self) || (self function_6c32d092(#"talent_resistance") && (!(isdefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae)));
	if(!var_1d673e46 && !isdefined(effect.var_b5207a36))
	{
		if(isdefined(var_756fda07.var_208fb7da))
		{
			effect.var_b5207a36 = self gestures::function_c77349d4(var_756fda07.var_208fb7da);
		}
		if(!isdefined(effect.var_b5207a36))
		{
			if(isdefined(var_756fda07.var_b5207a36))
			{
				effect.var_b5207a36 = var_756fda07.var_b5207a36;
			}
		}
		if(isdefined(effect.var_b5207a36))
		{
			self thread function_35d7925d(effect);
		}
	}
	if(function_7d17822(var_756fda07.setype))
	{
		self thread function_47cad1aa(var_756fda07, var_80e47495);
	}
	if(isdefined(weapon) && isdefined(var_84171a6c) && var_84171a6c != self && (isdefined(var_756fda07.var_3469b797) && var_756fda07.var_3469b797))
	{
		var_594a2d34 = isdefined(weapon) && isdefined(weapon.var_965cc0b3) && weapon.var_965cc0b3;
		var_84171a6c util::show_hit_marker(0, var_594a2d34);
	}
	if(isdefined(level._status_effects[var_756fda07.setype].end))
	{
		effect thread wait_for_end();
	}
}

/*
	Name: function_35d7925d
	Namespace: status_effect
	Checksum: 0x91F0E46F
	Offset: 0xED0
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_35d7925d(effect)
{
	effect endon(#"endstatuseffect");
	self endon(#"death");
	while(isdefined(effect.var_b5207a36) && isalive(self))
	{
		if(isdefined(level.var_d0ad09c5))
		{
			self [[level.var_d0ad09c5]](effect);
		}
		if(self gestures::function_b204f6e3(effect.var_b5207a36, undefined, 0))
		{
			return;
		}
		wait(0.5);
	}
}

/*
	Name: function_47cad1aa
	Namespace: status_effect
	Checksum: 0xEA5B0724
	Offset: 0xF98
	Size: 0x10C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_47cad1aa(var_756fda07, var_80e47495)
{
	var_18d16a6b = var_756fda07.var_18d16a6b;
	setype = var_756fda07.setype;
	if(isdefined(self.var_121392a1[var_18d16a6b]) && isdefined(self.var_121392a1[var_18d16a6b].duration))
	{
		if(setype != 4)
		{
			if(isplayer(self))
			{
				/#
					assert(!isfloat(self.var_121392a1[var_18d16a6b].duration), "");
				#/
				self applystatuseffect(var_756fda07.namehash, self.var_121392a1[var_18d16a6b].duration, var_80e47495);
			}
		}
	}
}

/*
	Name: function_89ae38c1
	Namespace: status_effect
	Checksum: 0xF1440187
	Offset: 0x10B0
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_89ae38c1(sename)
{
	if(isplayer(self))
	{
		self endstatuseffect(sename);
	}
}

/*
	Name: function_52969ffe
	Namespace: status_effect
	Checksum: 0xB92747E8
	Offset: 0x10F8
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_52969ffe(var_756fda07)
{
	player = self;
	if(isdefined(var_756fda07.var_3edb6e25) && var_756fda07.var_3edb6e25 && isplayer(player))
	{
		player disableoffhandspecial();
		player disableoffhandweapons();
	}
}

/*
	Name: function_14fdd7e2
	Namespace: status_effect
	Checksum: 0xAF448EF3
	Offset: 0x1188
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_14fdd7e2(var_756fda07)
{
	player = self;
	if(isdefined(var_756fda07.var_3edb6e25) && var_756fda07.var_3edb6e25 && isplayer(player))
	{
		player enableoffhandspecial();
		player enableoffhandweapons();
	}
}

/*
	Name: function_6bf7c434
	Namespace: status_effect
	Checksum: 0x66AE9AD0
	Offset: 0x1218
	Size: 0x17E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6bf7c434(status_effect_type)
{
	if(isdefined(self.var_b5207a36))
	{
		self.owner stopgestureviewmodel(self.var_b5207a36, 1, 0);
		self.var_b5207a36 = undefined;
	}
	if(isdefined(self.var_4b22e697))
	{
		self.var_4b22e697 globallogic_score::function_4842d1f6(self.var_4f6b79a4);
	}
	if(isdefined(level._status_effects) && isdefined(level._status_effects[status_effect_type]) && isdefined(level._status_effects[status_effect_type].end))
	{
		self thread [[level._status_effects[status_effect_type].end]]();
	}
	thread function_86c0eb67(self, "end");
	if(isdefined(self.var_3d1ed4bd) && isdefined(self.owner) && self.var_3d1ed4bd.doesfiredamage)
	{
		if(isplayer(self.owner))
		{
			self.owner clientfield::set("burn", 0);
		}
	}
	self.var_4b22e697 = undefined;
	self notify(#"endstatuseffect");
}

/*
	Name: wait_for_end
	Namespace: status_effect
	Checksum: 0x938724A7
	Offset: 0x13A0
	Size: 0xB4
	Parameters: 0
	Flags: Linked, Private
*/
function private wait_for_end()
{
	if(0 && self.setype == 6)
	{
		return;
	}
	self notify(#"endwaiter");
	self endon(#"endwaiter", #"endstatuseffect");
	self.owner endon(#"disconnect");
	while(self.endtime > level.time)
	{
		waitframe(1);
	}
	if(isdefined(self))
	{
		self thread function_6bf7c434(self.setype);
	}
}

/*
	Name: function_408158ef
	Namespace: status_effect
	Checksum: 0x166F6ECA
	Offset: 0x1460
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function function_408158ef(setype, var_18d16a6b)
{
	if(isdefined(self.var_121392a1))
	{
		if(isdefined(level._status_effects[setype].end))
		{
			effect = self.var_121392a1[var_18d16a6b];
			if(isdefined(effect))
			{
				effect function_6bf7c434(setype);
			}
		}
	}
}

/*
	Name: function_6519f95f
	Namespace: status_effect
	Checksum: 0xF7683C2B
	Offset: 0x14E0
	Size: 0xB0
	Parameters: 0
	Flags: Linked
*/
function function_6519f95f()
{
	if(isdefined(self.var_121392a1))
	{
		foreach(effect in self.var_121392a1)
		{
			if(isdefined(level._status_effects[effect.setype].end))
			{
				effect function_6bf7c434(effect.setype);
			}
		}
	}
}

/*
	Name: handle_sounds
	Namespace: status_effect
	Checksum: 0xB623A84A
	Offset: 0x1598
	Size: 0x122
	Parameters: 1
	Flags: Linked, Private
*/
function private handle_sounds(var_756fda07)
{
	endtime = self.endtime;
	if(isdefined(var_756fda07.var_b86e9a5e))
	{
		if(level.time > endtime && isplayer(self.owner))
		{
			self.owner playlocalsound(var_756fda07.var_b86e9a5e);
		}
	}
	if(isdefined(var_756fda07.var_801118b0))
	{
		if(level.time > endtime && isplayer(self.owner))
		{
			self.owner playloopsound(var_756fda07.var_801118b0);
		}
		self.var_801118b0 = var_756fda07.var_801118b0;
	}
	if(isdefined(var_756fda07.var_36c77790))
	{
		self.var_36c77790 = var_756fda07.var_36c77790;
	}
}

/*
	Name: status_effect_get_duration
	Namespace: status_effect
	Checksum: 0xE2F5E3E1
	Offset: 0x16C8
	Size: 0x50
	Parameters: 1
	Flags: None
*/
function status_effect_get_duration(var_eeb47fb8)
{
	if(!isdefined(self.var_121392a1))
	{
		self.var_121392a1 = [];
	}
	return true;
}

/*
	Name: function_2ba2756c
	Namespace: status_effect
	Checksum: 0xF6148F14
	Offset: 0x1720
	Size: 0x50
	Parameters: 1
	Flags: Linked
*/
function function_2ba2756c(var_eeb47fb8)
{
	if(!isdefined(self.var_121392a1))
	{
		self.var_121392a1 = [];
	}
	return true;
}

/*
	Name: function_7f14a56f
	Namespace: status_effect
	Checksum: 0x320EB5BB
	Offset: 0x1778
	Size: 0xD0
	Parameters: 1
	Flags: None
*/
function function_7f14a56f(status_effect_type)
{
	if(!isdefined(self.var_121392a1))
	{
		self.var_121392a1 = [];
	}
	var_e2997f02 = 0;
	foreach(effect in self.var_121392a1)
	{
		if(effect.setype == 7)
		{
			var_e2997f02 = var_e2997f02 + ((effect.var_adb1692a * effect.var_5cf129b8) / 1000);
		}
	}
	return var_e2997f02;
}

/*
	Name: function_4617032e
	Namespace: status_effect
	Checksum: 0x6C90C152
	Offset: 0x1850
	Size: 0xA0
	Parameters: 1
	Flags: Linked
*/
function function_4617032e(status_effect_type)
{
	if(!isdefined(self.var_121392a1))
	{
		self.var_121392a1 = [];
	}
	foreach(effect in self.var_121392a1)
	{
		if(effect.setype == status_effect_type)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_40293e80
	Namespace: status_effect
	Checksum: 0x3C26EC11
	Offset: 0x18F8
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_40293e80(status_effect_type)
{
	if(status_effect_type == 3)
	{
		return "flakjacket";
	}
	return "resistance";
}

/*
	Name: function_cc42cac2
	Namespace: status_effect
	Checksum: 0x65202781
	Offset: 0x1930
	Size: 0x316
	Parameters: 6
	Flags: Linked, Private
*/
function private function_cc42cac2(var_756fda07, var_b0144580, var_ab5b905e, var_84171a6c, var_f8f8abaa, weapon)
{
	setype = var_756fda07.setype;
	resistance = self function_a6613b51(var_756fda07);
	var_fb887b00 = (var_b0144580 ? self.owner function_37683813() : 1);
	if(var_b0144580 && isdefined(weapon) && (isdefined(weapon.var_83b1dc1) && weapon.var_83b1dc1))
	{
		var_fb887b00 = 1;
	}
	if(getgametypesetting(#"competitivesettings") !== 1 || weapon !== getweapon("eq_concertina_wire"))
	{
		if(resistance > 0 && isdefined(var_84171a6c) && var_f8f8abaa && var_756fda07.var_42c00474 === 1 && !var_b0144580 && setype !== 0)
		{
			var_84171a6c damagefeedback::update(undefined, undefined, function_40293e80(setype));
		}
	}
	var_7a1fa72a = 0;
	if(isdefined(var_ab5b905e))
	{
		var_7a1fa72a = var_ab5b905e;
	}
	else
	{
		var_7a1fa72a = var_756fda07.var_77449e9;
	}
	var_7a1fa72a = int((var_7a1fa72a * (1 - resistance)) * var_fb887b00);
	var_2226e3f0 = self.endtime;
	time = level.time;
	maxduration = self function_f9ca1b6a(var_756fda07);
	if(isdefined(var_2226e3f0))
	{
		var_b5051685 = var_2226e3f0 - time;
		if(var_b5051685 < var_7a1fa72a)
		{
			self.duration = var_7a1fa72a;
			if(maxduration && self.duration > maxduration)
			{
				self.duration = maxduration;
			}
			self.endtime = time + self.duration;
		}
	}
	else
	{
		self.duration = var_7a1fa72a;
		if(maxduration && self.duration > maxduration)
		{
			self.duration = maxduration;
		}
		self.endtime = time + self.duration;
	}
}

/*
	Name: function_57f33b96
	Namespace: status_effect
	Checksum: 0xB5A7B7DF
	Offset: 0x1C50
	Size: 0x38A
	Parameters: 6
	Flags: Linked, Private
*/
function private function_57f33b96(var_756fda07, var_b0144580, var_ab5b905e, var_84171a6c, var_f8f8abaa, weapon)
{
	setype = var_756fda07.setype;
	resistance = self function_a6613b51(var_756fda07);
	if(isdefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae)
	{
		resistance = 0;
	}
	var_fb887b00 = (var_b0144580 ? self.owner function_37683813() : 1);
	if(var_b0144580 && isdefined(weapon) && (isdefined(weapon.var_83b1dc1) && weapon.var_83b1dc1))
	{
		var_fb887b00 = 1;
	}
	if(getgametypesetting(#"competitivesettings") !== 1 || weapon !== getweapon("eq_concertina_wire"))
	{
		if(resistance > 0 && setype != 0 && setype != 3 && isdefined(var_84171a6c) && var_f8f8abaa && var_756fda07.var_42c00474 === 1 && !var_b0144580)
		{
			var_84171a6c damagefeedback::update(undefined, undefined, function_40293e80(setype), weapon, self.owner);
		}
	}
	var_7a1fa72a = 0;
	if(isdefined(var_ab5b905e))
	{
		var_7a1fa72a = var_ab5b905e;
	}
	else
	{
		var_7a1fa72a = var_756fda07.var_77449e9;
	}
	var_7a1fa72a = int((var_7a1fa72a * (1 - resistance)) * var_fb887b00);
	time = level.time;
	maxduration = self function_f9ca1b6a(var_756fda07);
	if(isdefined(self.duration))
	{
		if(isdefined(self.endtime) && self.endtime > time)
		{
			if(maxduration && var_7a1fa72a > maxduration)
			{
				var_7a1fa72a = maxduration;
			}
			self.duration = self.duration + var_7a1fa72a;
			self.endtime = gettime() + var_7a1fa72a;
		}
		else
		{
			self.duration = var_7a1fa72a;
			if(maxduration && self.duration > maxduration)
			{
				self.duration = maxduration;
			}
			self.endtime = time + var_7a1fa72a;
		}
	}
	else
	{
		self.duration = var_7a1fa72a;
		if(maxduration && self.duration > maxduration)
		{
			self.duration = maxduration;
		}
		self.endtime = time + var_7a1fa72a;
	}
}

/*
	Name: function_5d973c5f
	Namespace: status_effect
	Checksum: 0xD79E06E9
	Offset: 0x1FE8
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5d973c5f()
{
	self thread function_72886b31();
	self thread function_150a8541();
}

/*
	Name: function_150a8541
	Namespace: status_effect
	Checksum: 0x44F8EAC3
	Offset: 0x2028
	Size: 0x15E
	Parameters: 0
	Flags: Linked
*/
function function_150a8541()
{
	self notify(#"loadoutwatcher");
	self endon(#"loadoutwatcher", #"endstatuseffect");
	self.owner endon(#"death", #"disconnect");
	var_eff9d37f = self.owner function_3c54ae98(self.setype);
	while(true)
	{
		self.owner waittill(#"loadout_given");
		newres = self.owner function_3c54ae98(self.setype);
		currtime = level.time;
		if(newres != var_eff9d37f)
		{
			timeremaining = self.endtime - currtime;
			timeremaining = timeremaining * newres;
			self.endtime = int(currtime + timeremaining);
			self.duration = int(timeremaining);
		}
	}
}

/*
	Name: function_72886b31
	Namespace: status_effect
	Checksum: 0x127BC81E
	Offset: 0x2190
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_72886b31()
{
	self notify(#"deathwatcher");
	self endon(#"deathwatcher", #"endstatuseffect");
	self.owner waittill(#"death");
	if(isdefined(self.var_4b22e697))
	{
		self.var_4b22e697 thread globallogic_score::function_fc47f2ff(self.var_4f6b79a4);
	}
	if(isdefined(self) && isdefined(level._status_effects[self.setype].death))
	{
		self [[level._status_effects[self.setype].death]]();
	}
}

/*
	Name: function_3c54ae98
	Namespace: status_effect
	Checksum: 0x7D86228E
	Offset: 0x2260
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_3c54ae98(status_effect_type)
{
	if(!isplayer(self))
	{
		return 0;
	}
	if(sessionmodeiszombiesgame())
	{
		if(!player_role::is_valid(self player_role::get()))
		{
			return 0;
		}
	}
	resistance = self getplayerresistance(status_effect_type);
	return resistance;
}

/*
	Name: function_37683813
	Namespace: status_effect
	Checksum: 0xEFB4FFF8
	Offset: 0x2300
	Size: 0x4A
	Parameters: 0
	Flags: Linked
*/
function function_37683813()
{
	if(!isplayer(self))
	{
		return 1;
	}
	scalar = self function_9049b079();
	return scalar;
}

/*
	Name: function_a6613b51
	Namespace: status_effect
	Checksum: 0xAFB10B2C
	Offset: 0x2358
	Size: 0x9E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a6613b51(var_756fda07)
{
	effect = self;
	setype = var_756fda07.setype;
	resistance = effect.owner function_3c54ae98(setype);
	if(isdefined(var_756fda07.var_857e12ae) && var_756fda07.var_857e12ae)
	{
		resistance = 0;
	}
	if(setype == 7)
	{
		resistance = 0;
	}
	return resistance;
}

/*
	Name: function_f9ca1b6a
	Namespace: status_effect
	Checksum: 0x48A7E771
	Offset: 0x2400
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f9ca1b6a(var_756fda07)
{
	effect = self;
	resistance = effect function_a6613b51(var_756fda07);
	maxduration = int(var_756fda07.var_ca171ecc * (1 - resistance));
	return maxduration;
}

/*
	Name: function_7d17822
	Namespace: status_effect
	Checksum: 0xD29FB894
	Offset: 0x2480
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7d17822(status_effect_type)
{
	return status_effect_type < 9;
}

/*
	Name: function_7505baeb
	Namespace: status_effect
	Checksum: 0xE42684D2
	Offset: 0x24A0
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function function_7505baeb(var_5c980521)
{
	level.var_90391bcc = var_5c980521;
}

/*
	Name: function_86c0eb67
	Namespace: status_effect
	Checksum: 0x5A70FAB1
	Offset: 0x24C8
	Size: 0x3C
	Parameters: 2
	Flags: Linked
*/
function function_86c0eb67(status_effect, var_3bc85d80)
{
	if(!isdefined(level.var_90391bcc))
	{
		return;
	}
	[[level.var_90391bcc]](status_effect, var_3bc85d80);
}

/*
	Name: function_4aac137f
	Namespace: status_effect
	Checksum: 0xEA1255B9
	Offset: 0x2510
	Size: 0xD0
	Parameters: 2
	Flags: Linked, Private
*/
function private function_4aac137f(var_19201a97, sourcetype)
{
	gametime = level.time;
	endtime = function_2ba2756c(sourcetype);
	isactive = function_2ba2756c(sourcetype) > gametime;
	if(!isactive)
	{
		return 0;
	}
	if(!isdefined(self.var_121392a1[sourcetype]) || !isdefined(self.var_121392a1[sourcetype].var_4b22e697) || !isdefined(var_19201a97))
	{
		return 0;
	}
	return self.var_121392a1[sourcetype].var_4b22e697 == var_19201a97;
}

