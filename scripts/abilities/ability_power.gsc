// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\abilities\ability_util.gsc;
#using scripts\abilities\ability_gadgets.gsc;

#namespace ability_power;

/*
	Name: cpower_print
	Namespace: ability_power
	Checksum: 0xBDDBC568
	Offset: 0xD8
	Size: 0x104
	Parameters: 2
	Flags: None
*/
function cpower_print(slot, str)
{
	/#
		color = "";
		toprint = (color + "") + str;
		weaponname = "";
		if(isdefined(self._gadgets_player[slot]))
		{
			weaponname = self._gadgets_player[slot].name;
		}
		if(getdvarint(#"scr_cpower_debug_prints", 0) > 0)
		{
			self iprintlnbold(toprint);
		}
		else
		{
			println((((self.playername + "") + weaponname) + "") + toprint);
		}
	#/
}

/*
	Name: power_is_hero_ability
	Namespace: ability_power
	Checksum: 0x638E5356
	Offset: 0x1E8
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function power_is_hero_ability(gadget)
{
	return gadget.gadget_type != 0;
}

/*
	Name: function_9d78823f
	Namespace: ability_power
	Checksum: 0x53372255
	Offset: 0x210
	Size: 0x4A
	Parameters: 2
	Flags: None
*/
function function_9d78823f(gadget, weapon)
{
	if(!isdefined(level.var_d0b212bd))
	{
		level.var_d0b212bd = [];
	}
	level.var_d0b212bd[weapon] = gadget;
}

/*
	Name: is_weapon_or_variant_same_as_gadget
	Namespace: ability_power
	Checksum: 0xCE767C7B
	Offset: 0x268
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function is_weapon_or_variant_same_as_gadget(weapon, gadget)
{
	if(weapon == gadget)
	{
		return true;
	}
	if(isdefined(level.var_d0b212bd))
	{
		if(level.var_d0b212bd[weapon] === gadget)
		{
			return true;
		}
	}
	return false;
}

/*
	Name: power_gain_event_score
	Namespace: ability_power
	Checksum: 0x3EF1D7A5
	Offset: 0x2D0
	Size: 0x386
	Parameters: 4
	Flags: Linked
*/
function power_gain_event_score(event, eattacker, score, weapon)
{
	if(!isplayer(self))
	{
		return;
	}
	if(score <= 0)
	{
		return;
	}
	if(self.gadgetthiefactive === 1)
	{
		return;
	}
	var_f1ee6456 = 1;
	/#
		var_f1ee6456 = var_f1ee6456 * getdvarfloat(#"hash_eae9a8ee387705d", 1);
	#/
	if(!isdefined(level.var_607bc6e7))
	{
		level.var_607bc6e7 = getgametypesetting(#"scoreheropowergainfactor");
		if(level.var_aa5e6547 === 1)
		{
			var_ec084a7a = getdvarfloat(#"hash_1cfb84145f54fa01", 0.59);
			if(var_ec084a7a > 0)
			{
				level.var_607bc6e7 = var_ec084a7a;
			}
		}
	}
	gametypefactor = level.var_607bc6e7;
	perkfactor = 1;
	if(self hasperk(#"specialty_overcharge"))
	{
		perkfactor = getdvarfloat(#"gadgetpoweroverchargeperkscorefactor", 0);
	}
	var_ec6ee937 = ((score * gametypefactor) * perkfactor) * var_f1ee6456;
	if(var_ec6ee937 <= 0)
	{
		return;
	}
	var_18fc605 = getdvarint(#"hash_74d01f2fd0317f08", 0) || (isdefined(weapon) && weapon.var_f23e9d19);
	for(slot = 0; slot < 3; slot++)
	{
		gadget = self._gadgets_player[slot];
		if(isdefined(gadget))
		{
			ignoreself = gadget.gadget_powergainscoreignoreself;
			var_503ccf9e = isdefined(weapon) && is_weapon_or_variant_same_as_gadget(weapon, gadget);
			if(ignoreself && var_503ccf9e || (var_18fc605 && !var_503ccf9e))
			{
				continue;
			}
			ignorewhenactive = gadget.gadget_powergainscoreignorewhenactive;
			if(ignorewhenactive && self gadgetisactive(slot))
			{
				continue;
			}
			scorefactor = gadget.gadget_powergainscorefactor;
			if(scorefactor > 0)
			{
				gaintoadd = scorefactor * var_ec6ee937;
				self power_gain_event(slot, eattacker, gaintoadd, "score");
			}
		}
	}
}

/*
	Name: power_gain_event_damage_actor
	Namespace: ability_power
	Checksum: 0x628847FF
	Offset: 0x660
	Size: 0x86
	Parameters: 1
	Flags: None
*/
function power_gain_event_damage_actor(eattacker)
{
	basegain = 0;
	if(basegain > 0)
	{
		for(slot = 0; slot < 3; slot++)
		{
			if(isdefined(self._gadgets_player[slot]))
			{
				self power_gain_event(slot, eattacker, basegain, "damaged actor");
			}
		}
	}
}

/*
	Name: power_gain_event_killed_actor
	Namespace: ability_power
	Checksum: 0x26150DD8
	Offset: 0x6F0
	Size: 0xDE
	Parameters: 2
	Flags: None
*/
function power_gain_event_killed_actor(eattacker, meansofdeath)
{
	basegain = 5;
	for(slot = 0; slot < 3; slot++)
	{
		if(isdefined(self._gadgets_player[slot]))
		{
			if(self._gadgets_player[slot].gadget_powerreplenishfactor > 0)
			{
				gaintoadd = basegain * self._gadgets_player[slot].gadget_powerreplenishfactor;
				if(gaintoadd > 0)
				{
					source = "killed actor";
					self power_gain_event(slot, eattacker, gaintoadd, source);
				}
			}
		}
	}
}

/*
	Name: power_gain_event
	Namespace: ability_power
	Checksum: 0x3D1A1E0A
	Offset: 0x7D8
	Size: 0x18C
	Parameters: 4
	Flags: Linked
*/
function power_gain_event(slot, eattacker, val, source)
{
	if(!isdefined(self) || !isalive(self))
	{
		return;
	}
	powertoadd = val;
	if(abs(powertoadd) > 0.0001)
	{
		maxscore = self._gadgets_player[slot].var_1e89f40;
		if(maxscore && 0 < powertoadd)
		{
			if(powertoadd + self.var_aec4af05[slot] > maxscore)
			{
				powertoadd = maxscore - self.var_aec4af05[slot];
				if(0 >= powertoadd)
				{
					return;
				}
			}
		}
		powerleft = self gadgetpowerchange(slot, powertoadd);
		if(0 < powertoadd)
		{
			self.var_aec4af05[slot] = self.var_aec4af05[slot] + powertoadd;
		}
		/#
			self cpower_print(slot, (((("" + powertoadd) + "") + source) + "") + powerleft);
		#/
	}
}

/*
	Name: power_loss_event_took_damage
	Namespace: ability_power
	Checksum: 0xE393B7B9
	Offset: 0x970
	Size: 0x17E
	Parameters: 5
	Flags: None
*/
function power_loss_event_took_damage(eattacker, einflictor, weapon, smeansofdeath, idamage)
{
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	baseloss = idamage;
	for(slot = 0; slot < 3; slot++)
	{
		if(isdefined(self._gadgets_player[slot]))
		{
			if(self gadgetisactive(slot))
			{
				powerloss = baseloss * self._gadgets_player[slot].gadget_poweronlossondamage;
				if(powerloss > 0)
				{
					self power_loss_event(slot, eattacker, powerloss, "took damage with power on");
				}
				if(self._gadgets_player[slot].gadget_flickerondamage > 0)
				{
					self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickerondamage);
				}
				continue;
			}
			powerloss = baseloss * self._gadgets_player[slot].gadget_powerofflossondamage;
			if(powerloss > 0)
			{
				self power_loss_event(slot, eattacker, powerloss, "took damage");
			}
		}
	}
}

/*
	Name: power_loss_event
	Namespace: ability_power
	Checksum: 0xA1B523F4
	Offset: 0xAF8
	Size: 0xCC
	Parameters: 4
	Flags: Linked
*/
function power_loss_event(slot, eattacker, val, source)
{
	powertoremove = val * -1;
	if(powertoremove > 0.1 || powertoremove < -0.1)
	{
		powerleft = self gadgetpowerchange(slot, powertoremove);
		/#
			self cpower_print(slot, (((("" + powertoremove) + "") + source) + "") + powerleft);
		#/
	}
}

/*
	Name: power_drain_completely
	Namespace: ability_power
	Checksum: 0xD4D180E3
	Offset: 0xBD0
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function power_drain_completely(slot)
{
	powerleft = self gadgetpowerchange(slot, 0);
	powerleft = self gadgetpowerchange(slot, powerleft * -1);
}

/*
	Name: ismovingpowerloss
	Namespace: ability_power
	Checksum: 0xB2D93029
	Offset: 0xC28
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function ismovingpowerloss()
{
	velocity = self getvelocity();
	speedsq = lengthsquared(velocity);
	return speedsq > (self._gadgets_player.gadget_powermovespeed * self._gadgets_player.gadget_powermovespeed);
}

/*
	Name: power_consume_timer_think
	Namespace: ability_power
	Checksum: 0xD40BB2CB
	Offset: 0xCA0
	Size: 0x240
	Parameters: 2
	Flags: Linked
*/
function power_consume_timer_think(slot, weapon)
{
	self endon(#"disconnect", #"death");
	if(!isdefined(self._gadgets_player))
	{
		return;
	}
	time = gettime();
	while(true)
	{
		wait(0.1);
		if(!isdefined(self._gadgets_player[slot]))
		{
			return;
		}
		if(!self gadgetisactive(slot))
		{
			return;
		}
		currenttime = gettime();
		interval = currenttime - time;
		time = currenttime;
		powerconsumpted = 0;
		if(self isonground())
		{
			if(self._gadgets_player[slot].gadget_powersprintloss > 0 && self issprinting())
			{
				powerconsumpted = powerconsumpted + ((1 * (float(interval) / 1000)) * self._gadgets_player[slot].gadget_powersprintloss);
			}
			else if(self._gadgets_player[slot].gadget_powermoveloss && self ismovingpowerloss())
			{
				powerconsumpted = powerconsumpted + ((1 * (float(interval) / 1000)) * self._gadgets_player[slot].gadget_powermoveloss);
			}
		}
		if(powerconsumpted > 0.1)
		{
			self power_loss_event(slot, self, powerconsumpted, "consume");
			if(self._gadgets_player[slot].gadget_flickeronpowerloss > 0)
			{
				self ability_gadgets::setflickering(slot, self._gadgets_player[slot].gadget_flickeronpowerloss);
			}
		}
	}
}

