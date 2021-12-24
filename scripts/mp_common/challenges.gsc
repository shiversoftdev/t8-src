// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_18f0d22c75b141a7;
#using script_256b8879317373de;
#using script_2c49ae69cd8ce30c;
#using script_300f815a565e66fb;
#using script_3539cbff3042175f;
#using script_47d248640dc1f97f;
#using script_47fb62300ac0bd60;
#using script_4bfa1380a94b068b;
#using script_5399f402045d7abd;
#using script_545a0bac37bda541;
#using script_6c8abe14025b47c4;
#using script_7133a4d461308099;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\challenges_shared.gsc;
#using scripts\core_common\contracts_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\weapons_shared.gsc;
#using scripts\mp_common\gametypes\match.gsc;
#using scripts\mp_common\scoreevents.gsc;
#using scripts\mp_common\util.gsc;

#namespace challenges;

/*
	Name: function_89f2df9
	Namespace: challenges
	Checksum: 0xAC527100
	Offset: 0x470
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"challenges", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: challenges
	Checksum: 0xB2A24D2E
	Offset: 0x4B8
	Size: 0x18A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(function_f99d2668())
	{
		return;
	}
	if(!isdefined(level.challengescallbacks))
	{
		level.challengescallbacks = [];
	}
	callback::on_start_gametype(&start_gametype);
	callback::on_spawned(&on_player_spawn);
	level.heroabilityactivateneardeath = &heroabilityactivateneardeath;
	level.var_c8de519d = {};
	level.var_c8de519d.multikill = &function_19e8b086;
	level.var_c8de519d.var_ec391d55 = &function_3ee91387;
	level.var_7897141a = [];
	level.var_7897141a[getweapon(#"hash_66401df7cd6bf292")] = 1;
	level.var_7897141a[getweapon(#"hash_3f62a872201cd1ce")] = 1;
	level.var_ca4ce464 = [];
	level.var_ca4ce464[getweapon(#"ability_smart_cover")] = 1;
}

/*
	Name: start_gametype
	Namespace: challenges
	Checksum: 0x5862EBCB
	Offset: 0x650
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function start_gametype()
{
	waittillframeend();
	if(isdefined(level.scoreeventgameendcallback))
	{
		registerchallengescallback("gameEnd", level.scoreeventgameendcallback);
	}
	if(canprocesschallenges())
	{
		registerchallengescallback("playerKilled", &challengekills);
		registerchallengescallback("gameEnd", &challengegameendmp);
		player::function_3c5cc656(&function_a79ea08b);
		self callback::add_callback(#"hash_25663702210244cc", &player_fully_healed);
	}
	callback::on_connect(&on_player_connect);
}

/*
	Name: on_player_connect
	Namespace: challenges
	Checksum: 0x957AAAE
	Offset: 0x760
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	initchallengedata();
	if(level.var_e7c95d09 !== 1)
	{
		self thread monitorreloads();
		self thread monitorgrenadefire();
	}
}

/*
	Name: initchallengedata
	Namespace: challenges
	Checksum: 0x5FBE0734
	Offset: 0x7C8
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function initchallengedata()
{
	self.var_9cd2c51d = {};
	self.pers[#"stickexplosivekill"] = 0;
	self.pers[#"carepackagescalled"] = 0;
	self.pers[#"challenge_destroyed_air"] = 0;
	self.pers[#"challenge_destroyed_ground"] = 0;
	self.pers[#"challenge_anteup_earn"] = 0;
	self.pers[#"specialiststatabilityusage"] = 0;
	self.pers[#"activekillstreaks"] = [];
	self.pers[#"killnemesis"] = 0;
	self.pers[#"killsfastmagext"] = 0;
	self.pers[#"longshotsperlife"] = 0;
	self.pers[#"specialiststatabilityusage"] = 0;
	self.challenge_defenderkillcount = 0;
	self.challenge_offenderkillcount = 0;
	self.challenge_offenderprojectilemultikillcount = 0;
	self.challenge_offendercomlinkkillcount = 0;
	self.challenge_offendersentryturretkillcount = 0;
	self.challenge_objectivedefensivekillcount = 0;
	self.challenge_scavengedcount = 0;
	self.challenge_resuppliednamekills = 0;
	self.challenge_objectivedefensive = undefined;
	self.challenge_objectiveoffensive = undefined;
	self.challenge_lastsurvivewithflakfrom = undefined;
	self.explosiveinfo = [];
	self function_6b34141d();
}

/*
	Name: function_6b34141d
	Namespace: challenges
	Checksum: 0x99C8BCC9
	Offset: 0x980
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_6b34141d()
{
	self.weaponkillsthisspawn = [];
	self.var_93da0d74 = [];
	self.var_c9062c1c = [];
	self.attachmentkillsthisspawn = [];
	self.challenge_hatchettosscount = 0;
	self.challenge_hatchetkills = 0;
	self.challenge_combatrobotattackclientid = [];
}

/*
	Name: function_edc4ebe8
	Namespace: challenges
	Checksum: 0x79E469DA
	Offset: 0x9E0
	Size: 0x132
	Parameters: 1
	Flags: Event
*/
event function_edc4ebe8(eventstruct)
{
	if(!isdefined(self.var_ea1458aa))
	{
		return;
	}
	var_f2b25a4e = (self isusingoffhand() ? self getcurrentoffhand() : eventstruct.weapon);
	if(var_f2b25a4e.var_76ce72e8)
	{
		self.var_ea1458aa.var_59ac2f5 = undefined;
		scoreevents = globallogic_score::function_3cbc4c6c(var_f2b25a4e.var_2e4a8800);
		if(isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1)
		{
			self.var_ea1458aa.var_59ac2f5 = 0;
		}
	}
	else if(!isdefined(level.var_ca4ce464) || level.var_ca4ce464[var_f2b25a4e] !== 1)
	{
		self.var_ea1458aa.var_96d50420 = undefined;
		if(var_f2b25a4e.var_b76e0a09)
		{
			self.var_ea1458aa.var_96d50420 = 0;
		}
	}
}

/*
	Name: function_97023fdf
	Namespace: challenges
	Checksum: 0x8EFA033D
	Offset: 0xB20
	Size: 0x32
	Parameters: 1
	Flags: Event
*/
event function_97023fdf(eventstruct)
{
	if(!isdefined(self.var_ea1458aa))
	{
		return;
	}
	newweapon = eventstruct.weapon;
}

/*
	Name: function_4776caf4
	Namespace: challenges
	Checksum: 0x13ADC00B
	Offset: 0xB60
	Size: 0x146
	Parameters: 1
	Flags: Event
*/
event function_4776caf4(eventstruct)
{
	newweapon = eventstruct.weapon;
	if(isdefined(self.var_9cd2c51d))
	{
		if(isdefined(level.var_ca4ce464) && level.var_ca4ce464[newweapon] === 1)
		{
			self.var_9cd2c51d.var_d298c9a8 = undefined;
			if(newweapon.var_b76e0a09)
			{
				self.var_9cd2c51d.var_d298c9a8 = 0;
			}
		}
	}
	if(isdefined(self.var_ea1458aa))
	{
		if(isdefined(level.var_7897141a) && level.var_7897141a[newweapon] !== 1)
		{
			if(!newweapon.var_b76e0a09)
			{
				self.var_ea1458aa.var_59ac2f5 = undefined;
				if(newweapon.var_76ce72e8)
				{
					scoreevents = globallogic_score::function_3cbc4c6c(newweapon.var_2e4a8800);
					if(isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1)
					{
						self.var_ea1458aa.var_59ac2f5 = 0;
					}
				}
			}
		}
	}
}

/*
	Name: player_fully_healed
	Namespace: challenges
	Checksum: 0x25FCDE64
	Offset: 0xCB0
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function player_fully_healed()
{
	var_c3ade07c = self.var_ea1458aa;
	info = self.var_9cd2c51d;
	if(isdefined(var_c3ade07c) && isdefined(info))
	{
		if(isdefined(info.var_6e219f3c) && info.var_6e219f3c <= 52)
		{
			if(!isdefined(var_c3ade07c.var_8002d34))
			{
				var_c3ade07c.var_8002d34 = 0;
			}
			var_c3ade07c.var_8002d34++;
			if(var_c3ade07c.var_8002d34 >= 3)
			{
				self stats::function_dad108fa(#"hash_7b6b4c15bce1d4a3", 1);
				var_c3ade07c.var_8002d34 = undefined;
			}
			var_c3ade07c.var_55a37dc7 = 1;
		}
		else
		{
			var_c3ade07c.var_55a37dc7 = 0;
		}
		var_c3ade07c.var_a440c10 = gettime();
	}
}

/*
	Name: watchscavengelethal
	Namespace: challenges
	Checksum: 0x3F9B031B
	Offset: 0xDC0
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function watchscavengelethal()
{
	self endon(#"death", #"disconnect");
	self.challenge_scavengedcount = 0;
	for(;;)
	{
		self waittill(#"scavenged_primary_grenade", #"disconnect");
		self.challenge_scavengedcount++;
	}
}

/*
	Name: watchjump
	Namespace: challenges
	Checksum: 0xEA1764DC
	Offset: 0xE30
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function watchjump()
{
	self endon(#"death", #"disconnect");
	self.challenge_jump_begin = 0;
	self.challenge_jump_end = 0;
	for(;;)
	{
		ret = undefined;
		ret = self waittill(#"jump_begin", #"jump_end", #"disconnect");
		switch(ret._notify)
		{
			case "jump_begin":
			{
				self.challenge_jump_begin = gettime();
				break;
			}
			case "jump_end":
			{
				self.challenge_jump_end = gettime();
				break;
			}
		}
	}
}

/*
	Name: watchswimming
	Namespace: challenges
	Checksum: 0xAD82B85D
	Offset: 0xF20
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function watchswimming()
{
	self endon(#"death", #"disconnect");
	self.challenge_swimming_begin = 0;
	self.challenge_swimming_end = 0;
	for(;;)
	{
		ret = undefined;
		ret = self waittill(#"swimming_begin", #"swimming_end", #"disconnect");
		switch(ret._notify)
		{
			case "swimming_begin":
			{
				self.challenge_swimming_begin = gettime();
				break;
			}
			case "swimming_end":
			{
				self.challenge_swimming_end = gettime();
				break;
			}
		}
	}
}

/*
	Name: watchslide
	Namespace: challenges
	Checksum: 0x57EADEFF
	Offset: 0x1010
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function watchslide()
{
	self endon(#"death", #"disconnect");
	self.challenge_slide_begin = 0;
	self.challenge_slide_end = 0;
	for(;;)
	{
		ret = undefined;
		ret = self waittill(#"slide_begin", #"slide_end", #"disconnect");
		switch(ret._notify)
		{
			case "slide_begin":
			{
				self.challenge_slide_begin = gettime();
				break;
			}
			case "slide_end":
			{
				self.challenge_slide_end = gettime();
				break;
			}
		}
	}
}

/*
	Name: watchsprint
	Namespace: challenges
	Checksum: 0x90A5FB46
	Offset: 0x1100
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function watchsprint()
{
	self endon(#"death", #"disconnect");
	self.challenge_sprint_begin = 0;
	self.challenge_sprint_end = 0;
	for(;;)
	{
		ret = undefined;
		ret = self waittill(#"sprint_begin", #"sprint_end", #"disconnect");
		switch(ret._notify)
		{
			case "sprint_begin":
			{
				self.challenge_sprint_begin = gettime();
				break;
			}
			case "sprint_end":
			{
				self.challenge_sprint_end = gettime();
				break;
			}
		}
	}
}

/*
	Name: function_a79ea08b
	Namespace: challenges
	Checksum: 0xCD082119
	Offset: 0x11F0
	Size: 0x2C74
	Parameters: 4
	Flags: Linked
*/
function function_a79ea08b(einflictor, victim, idamage, weapon)
{
	if(!isdefined(self) || !isplayer(self) || !isdefined(victim) || !isplayer(victim))
	{
		return;
	}
	if(!isdefined(weapon) || !isdefined(victim.var_ea1458aa) || !isdefined(victim.var_ea1458aa.attackerdamage))
	{
		return;
	}
	if(level.teambased)
	{
		if(self.team == victim.team)
		{
			return;
		}
	}
	else if(self == victim)
	{
		return;
	}
	time = gettime();
	var_5afc3871 = self function_65776b07();
	killstreak = killstreaks::get_from_weapon(weapon);
	if(!isdefined(killstreak))
	{
		var_6af452fc = function_2e532eed(victim.var_ea1458aa.attackerdamage[self.clientid]);
		var_5018995b = victim.gadget_weapon;
		var_bcbcb4ec = victim supplypod::function_49ef5263();
		var_fff76b4 = victim.var_b6672e47;
		totalenemies = countplayers(victim.team);
		victimentnum = victim getentitynumber();
		var_3cd641b = var_6af452fc.class_num;
		if(!isdefined(self.var_ea1458aa))
		{
			self.var_ea1458aa = {};
		}
		if(!isdefined(self.var_ea1458aa.ekia))
		{
			self.var_ea1458aa.ekia = [];
		}
		if(!isdefined(self.var_ea1458aa.ekia[#"primary"]))
		{
			self.var_ea1458aa.ekia[#"primary"] = 0;
		}
		if(!isdefined(self.var_ea1458aa.ekia[#"secondary"]))
		{
			self.var_ea1458aa.ekia[#"secondary"] = 0;
		}
		isprimaryweapon = weapon.name == self function_b958b70d(var_3cd641b, "primary");
		var_197329e6 = weapon.name == self function_b958b70d(var_3cd641b, "secondary");
		if(isprimaryweapon)
		{
			self.var_ea1458aa.ekia[#"primary"]++;
		}
		else if(var_197329e6)
		{
			self.var_ea1458aa.ekia[#"secondary"]++;
		}
		if(self.var_ea1458aa.ekia[#"primary"] > 0 && self.var_ea1458aa.ekia[#"secondary"] > 0)
		{
			var_95ac2e77 = 1;
			self.var_ea1458aa.ekia[#"primary"]--;
			self.var_ea1458aa.ekia[#"secondary"]--;
		}
		scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
		var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
		if(isdefined(self.var_9cd2c51d))
		{
			if(weapon.var_b76e0a09 && isdefined(level.var_ca4ce464) && level.var_ca4ce464[weapon] === 1)
			{
				if(!isdefined(self.var_9cd2c51d.var_d298c9a8))
				{
					self.var_9cd2c51d.var_d298c9a8 = 0;
				}
				self.var_9cd2c51d.var_d298c9a8++;
				if((self.var_9cd2c51d.var_d298c9a8 % 4) == 0)
				{
					var_828dac8f = 1;
				}
			}
		}
		if(!isdefined(var_828dac8f))
		{
			if(weapon.var_b76e0a09 && isdefined(self.var_ea1458aa.var_96d50420))
			{
				if(!isdefined(self.var_9cd2c51d.var_96d50420))
				{
					self.var_9cd2c51d.var_96d50420 = 0;
				}
				self.var_ea1458aa.var_96d50420++;
				if((self.var_ea1458aa.var_96d50420 % 4) == 0)
				{
					var_828dac8f = 1;
				}
			}
			else if(var_8a4cfbd && isdefined(self.var_ea1458aa.var_59ac2f5))
			{
				if(!isdefined(self.var_9cd2c51d.var_59ac2f5))
				{
					self.var_9cd2c51d.var_59ac2f5 = 0;
				}
				self.var_ea1458aa.var_59ac2f5++;
				if((self.var_ea1458aa.var_59ac2f5 % 4) == 0)
				{
					var_828dac8f = 1;
				}
			}
		}
		var_ffe9dfa5 = self weaponhasattachmentandunlocked(weapon, "extclip");
		if(var_ffe9dfa5)
		{
			if(!isdefined(self.var_ea1458aa.var_23f5861b))
			{
				self.var_ea1458aa.var_23f5861b = 0;
			}
			self.var_ea1458aa.var_23f5861b++;
		}
		if(totalenemies >= 4)
		{
			if(!isdefined(self.var_ea1458aa.var_a3e3c63e))
			{
				self.var_ea1458aa.var_a3e3c63e = [];
			}
			self.var_ea1458aa.var_a3e3c63e[victimentnum] = 1;
			if(self.var_ea1458aa.var_a3e3c63e.size >= totalenemies)
			{
				var_2adaec2f = 1;
				self.var_ea1458aa.var_a3e3c63e = undefined;
			}
		}
		if(isdefined(level.var_1aef539f) && [[level.var_1aef539f]](victim, self))
		{
			var_1f0bdb8f = 1;
		}
		var_70137a58 = function_2e532eed(self.var_ea1458aa);
		if(!isdefined(var_5afc3871[#"talent_resistance"]))
		{
			var_2d4a24ea = self.var_ef9b6f0b === 1;
			var_6c5ba24c = self.lastflashedby === victim;
			if(isdefined(self.var_121392a1) && isdefined(self.var_121392a1[#"hash_4c34823a58987bed"]))
			{
				if(self.var_121392a1[#"hash_4c34823a58987bed"].var_4b22e697 === victim)
				{
					var_ba9c5900 = 1;
				}
			}
		}
		var_30f88120 = scoreevents::function_c28e2c05(victim.origin, var_6af452fc.var_4409f8bd, 0);
	}
	util::waittillslowprocessallowed();
	if(!isdefined(self))
	{
		return;
	}
	if(!isdefined(killstreak))
	{
		weaponclass = util::getweaponclass(weapon);
		if(isdefined(var_3cd641b))
		{
			if(isprimaryweapon)
			{
				self stats::function_dad108fa(#"hash_207964660a784470", 1);
				if(weapon.attachments.size > 2)
				{
					self stats::function_dad108fa(#"hash_6803083fa39064a4", 1);
				}
			}
			else if(var_197329e6)
			{
				self stats::function_dad108fa(#"hash_207964660a784470", 1);
				if(weapon.attachments.size > 2)
				{
					self stats::function_dad108fa(#"hash_7b0b54996f4aafbc", 1);
				}
			}
			if(var_95ac2e77 === 1)
			{
				if(self function_db654c9(var_3cd641b, #"bonuscard_overkill"))
				{
					self stats::function_dad108fa(#"hash_33dd7ef72b15e6ac", 1);
					self contracts::function_a54e2068(#"hash_bda5f100f182228");
				}
				else if(self function_db654c9(var_3cd641b, #"bonuscard_underkill"))
				{
					self stats::function_dad108fa(#"hash_9cb265b8b1483b0", 1);
				}
			}
			talents = self function_4a9f1384(var_3cd641b);
			if(isdefined(talents) && isarray(talents))
			{
				if(self function_db654c9(var_3cd641b, #"bonuscard_perk_1_greed"))
				{
					if(isdefined(talents[0]) && talents[0] != #"weapon_null" && isdefined(talents[3]) && talents[3] != #"weapon_null")
					{
						self stats::function_dad108fa(#"hash_2bd2c0cabe4c6885", 1);
					}
				}
				if(self function_db654c9(var_3cd641b, #"bonuscard_perk_2_greed"))
				{
					if(isdefined(talents[1]) && talents[1] != #"weapon_null" && isdefined(talents[4]) && talents[4] != #"weapon_null")
					{
						self stats::function_dad108fa(#"hash_5e6ce18d4b5b5254", 1);
					}
				}
				if(self function_db654c9(var_3cd641b, #"bonuscard_perk_3_greed"))
				{
					if(isdefined(talents[2]) && talents[2] != #"weapon_null" && isdefined(talents[5]) && talents[5] != #"weapon_null")
					{
						self stats::function_dad108fa(#"hash_6c271157f27f925f", 1);
					}
				}
				arrayremovevalue(talents, #"weapon_null");
				if(talents.size > 2)
				{
					var_ee03db9e = 0;
					if(self function_db654c9(var_3cd641b, #"bonuscard_perk_1_gluttony"))
					{
						self stats::function_dad108fa(#"hash_47ca0bf0dc1c1522", 1);
						var_ee03db9e = 1;
					}
					else if(self function_db654c9(var_3cd641b, #"bonuscard_perk_2_gluttony"))
					{
						self stats::function_dad108fa(#"hash_1fde92ca99c05249", 1);
						var_ee03db9e = 1;
					}
					else if(self function_db654c9(var_3cd641b, #"bonuscard_perk_3_gluttony"))
					{
						self stats::function_dad108fa(#"hash_af94e8f65ee288c", 1);
						var_ee03db9e = 1;
					}
					if(var_ee03db9e)
					{
						self contracts::function_a54e2068(#"hash_29c44b5c02f1674d");
					}
				}
				if(talents.size >= 5)
				{
					self contracts::function_a54e2068(#"hash_1d68713877c674d8");
				}
				if(isdefined(var_5afc3871[#"talent_resistance"]))
				{
					if(var_6af452fc.var_5745c480 === 1)
					{
						self stats::function_dad108fa(#"hash_48da2dd2514d4c6e", 1);
					}
					else if(isdefined(var_6af452fc.var_121392a1) && isarray(var_6af452fc.var_121392a1) && var_6af452fc.var_121392a1.size > 0)
					{
						foreach(effect in var_6af452fc.var_121392a1)
						{
							if(!isdefined(effect.var_4b22e697) || self == effect.var_4b22e697 || !isdefined(effect.var_3d1ed4bd))
							{
								continue;
							}
							switch(effect.var_3d1ed4bd.name)
							{
								case "ability_smart_cover":
								case "eq_swat_grenade":
								case "hash_3f62a872201cd1ce":
								case "hash_4a4ba36128b6582f":
								case "eq_concertina_wire":
								case "eq_slow_grenade":
								case "gadget_radiation_field":
								{
									award = 1;
									break;
								}
								default:
								{
									break;
								}
							}
							if(award === 1)
							{
								self stats::function_dad108fa(#"hash_48da2dd2514d4c6e", 1);
								break;
							}
						}
					}
				}
				if(var_6af452fc.var_53611a9c === 1)
				{
					if(isdefined(var_5afc3871[#"talent_teamlink"]))
					{
						self stats::function_dad108fa(#"hash_2fca45fe2e165b71", 1);
					}
					if(isdefined(var_5afc3871[#"talent_tracker"]))
					{
						self stats::function_dad108fa(#"hash_351e69e1ec82beb0", 1);
					}
				}
				else if(isdefined(var_5afc3871[#"talent_teamlink"]) && var_6af452fc.var_ec93e5f2 === 1)
				{
					self stats::function_dad108fa(#"hash_2fca45fe2e165b71", 1);
				}
				if(isdefined(var_5afc3871[#"talent_deadsilence"]))
				{
					self stats::function_dad108fa(#"hash_434f1790b89a2d65", 1);
				}
				if(isdefined(var_5afc3871[#"talent_ghost"]) && (var_6af452fc.var_8e35fb71 === 1 || var_6af452fc.var_efc9cf4d === 1))
				{
					self stats::function_dad108fa(#"hash_33e2a64b2825c893", 1);
				}
				if(isdefined(var_5afc3871[#"talent_gungho"]) && var_6af452fc.var_e8072c8d === 1)
				{
					self stats::function_dad108fa(#"hash_cdd16b48f26b85f", 1);
				}
				if(isdefined(var_5afc3871[#"talent_dexterity"]))
				{
					if(var_6af452fc.ismantling === 1 || var_6af452fc.var_bd77a1eb === 1 || var_6af452fc.isjumping === 1)
					{
						self stats::function_dad108fa(#"hash_20be2d12bc757e0a", 1);
					}
				}
				if(isdefined(var_5afc3871[#"talent_scavenger"]) && var_6af452fc.var_54433d4b === 1)
				{
					self stats::function_dad108fa(#"hash_6e11e24e9cad97b8", 1);
				}
			}
			wildcards = self function_6f2c0492(var_3cd641b);
			arrayremovevalue(wildcards, #"weapon_null");
			if(wildcards.size > 1)
			{
				self stats::function_dad108fa(#"hash_3c794263f2d7e231", 1);
			}
			gear = self function_b958b70d(var_3cd641b, "tacticalgear");
			if(isdefined(gear))
			{
				switch(gear)
				{
					case "gear_armor":
					{
						if(var_6af452fc.var_d7bd6f9b === 1)
						{
							self stats::function_dad108fa(#"hash_434323084b426f9", 1);
						}
						break;
					}
					case "gear_awareness":
					{
						var_1550b3b2 = function_fd82b127() * 0.5;
						if(var_6af452fc.var_85997af0 < var_1550b3b2 * var_1550b3b2)
						{
							self stats::function_dad108fa(#"hash_6d7a6c847d96d5f9", 1);
							if(isdefined(var_5afc3871[#"talent_tracker"]) && var_6af452fc.var_53611a9c === 1)
							{
								self stats::function_dad108fa(#"hash_71eb2efdbdffb45a", 1);
							}
						}
						break;
					}
					case "gear_equipmentcharge":
					{
						scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
						baseweapon = weapons::getbaseweapon(weapon);
						if(baseweapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1)
						{
							self stats::function_dad108fa(#"hash_73fae8d7de870941", 1);
							if(!isdefined(self.var_9cd2c51d.var_b385927))
							{
								self.var_9cd2c51d.var_b385927 = 0;
							}
							self.var_9cd2c51d.var_b385927++;
							if(self.var_9cd2c51d.var_b385927 == 7)
							{
								self stats::function_dad108fa(#"hash_7db6a4180312b94c", 1);
							}
						}
						break;
					}
					case "gear_medicalinjectiongun":
					{
						if(var_6af452fc.var_46a82df0 === 1)
						{
							self stats::function_dad108fa(#"hash_21b9db5498b4c451", 1);
							if(var_6af452fc.var_69b66e8e === 1)
							{
								self stats::function_dad108fa(#"hash_69d71adbdaedb640", 1);
							}
						}
						break;
					}
					case "weapon_null":
					default:
					{
						break;
					}
				}
			}
		}
		if(isdefined(level.gametype) && (level.gametype == #"tdm" || level.gametype == #"dm"))
		{
			if(level.hardcoremode)
			{
				self stats::function_dad108fa(#"hash_307266bd52a9fc51", 1);
			}
			else if(!level.arenamatch)
			{
				self stats::function_dad108fa(#"hash_74e55d91564b4757", 1);
			}
		}
		if(isdefined(weapon.attachments) && weapon.attachments.size > 0)
		{
			isads = isdefined(var_6af452fc.isads) && var_6af452fc.isads;
			var_95c30fc5 = 0;
			if(self weaponhasattachmentandunlocked(weapon, "grip"))
			{
				if(isads)
				{
					self stats::function_dad108fa(#"hash_397750a1a85e94eb", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "grip2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "quickdraw"))
			{
				if(isads)
				{
					self stats::function_dad108fa(#"hash_4859eebaa0eca480", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "quickdraw2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "stalker"))
			{
				if(isads)
				{
					self stats::function_dad108fa(#"hash_58521f27f2b18579", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "stalker2"))
				{
					var_95c30fc5++;
				}
			}
			if(isads)
			{
				if(self weaponhasattachmentandunlocked(weapon, "swayreduc"))
				{
					self stats::function_dad108fa(#"hash_86e5ece62a4a70e", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "quickdraw", "stalker", "grip"))
				{
					self stats::function_dad108fa(#"hash_6270e744fbf21e68", 1);
				}
			}
			if(var_ffe9dfa5 == 1)
			{
				if((var_70137a58.var_23f5861b % 2) == 0)
				{
					self stats::function_dad108fa(#"hash_779e1fc5021c532c", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "extclip2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "steadyaim"))
			{
				if(var_6af452fc.var_bd77a1eb === 1)
				{
					if(isdefined(var_3cd641b) && isdefined(var_5afc3871[#"talent_dexterity"]) && self function_db654c9(var_3cd641b, #"bonuscard_overkill"))
					{
						if(!isdefined(self.var_9cd2c51d.var_1a72ebf5))
						{
							self.var_9cd2c51d.var_1a72ebf5 = 0;
						}
						self.var_9cd2c51d.var_1a72ebf5++;
						if(self.var_9cd2c51d.var_1a72ebf5 == 5)
						{
							self stats::function_dad108fa(#"hash_6c13ae81deff608b", 1);
						}
					}
				}
				if(!isads && self weaponhasattachmentandunlocked(weapon, "rf"))
				{
					self stats::function_dad108fa(#"hash_7c7d51a39a0f6cc6", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "steadyaim2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "damage"))
			{
				if(weaponclass == #"weapon_launcher")
				{
					self stats::function_dad108fa(#"hash_4ad196e3eaceeb26", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "damage2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "fmj"))
			{
				if(isdefined(var_6af452fc.idflags) && var_6af452fc.idflags & 8)
				{
					self stats::function_dad108fa(#"hash_7540ce5e7458291e", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "fmj2"))
				{
					var_95c30fc5++;
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "fastreload"))
			{
				self stats::function_dad108fa(#"hash_3f378b9a10f47f0", 1);
				if(weaponclass == #"weapon_launcher")
				{
					self stats::function_dad108fa(#"hash_4b19afce40dfc918", 1);
				}
				if(self weaponhasattachmentandunlocked(weapon, "fastreload2"))
				{
					var_95c30fc5++;
					if(isads && var_6af452fc.var_14f058c7 === 1 && self weaponhasattachmentandunlocked(weapon, "quickdraw"))
					{
						self stats::function_dad108fa(#"hash_7e26283d90cb7c88", 1);
					}
				}
			}
			if(self weaponhasattachmentandunlocked(weapon, "mixclip"))
			{
				self stats::function_dad108fa(#"hash_3f378b9a10f47f0", 1);
			}
			if(var_95c30fc5 < 2)
			{
				if(self weaponhasattachmentandunlocked(weapon, "extbarrel", "extbarrel2"))
				{
					var_95c30fc5++;
				}
			}
			if(var_95c30fc5 == 1)
			{
				self stats::function_dad108fa(#"hash_51430fd20ccb2b05", 1);
			}
			else if(var_95c30fc5 > 1)
			{
				self stats::function_dad108fa(#"hash_6c36aa2d7d6f2b4", 1);
			}
			if(weaponclass == #"weapon_launcher")
			{
				if(self weaponhasattachmentandunlocked(weapon, "supply"))
				{
					self stats::function_dad108fa(#"hash_403b2535e53d1991", 1);
				}
			}
			else if(self weaponhasattachmentandunlocked(weapon, "uber"))
			{
				switch(weapon.statname)
				{
					case "smg_capacity_t8":
					case "sniper_quickscope_t8":
					case "lmg_spray_t8":
					{
						self stats::function_dad108fa(#"hash_18544be3ec807d95", 1);
						break;
					}
					case "pistol_revolver_t8":
					case "lmg_heavy_t8":
					case "shotgun_pump_t8":
					{
						self stats::function_dad108fa(#"hash_1dc20f3502e9530", 1);
						break;
					}
					case "tr_midburst_t8":
					case "ar_fastfire_t8":
					case "smg_fastfire_t8":
					{
						if(!isads && var_95c30fc5 > 0 && self weaponhasattachmentandunlocked(weapon, "steadyaim2"))
						{
							velocity = self getvelocity();
							speedsq = lengthsquared(velocity);
							if(speedsq > 100 * 100)
							{
								self stats::function_dad108fa(#"hash_4e5c10f358ec1319", 1);
							}
						}
						self stats::function_dad108fa(#"hash_17d7f3ce4b8d1efe", 1);
						break;
					}
					case "tr_longburst_t8":
					case "tr_powersemi_t8":
					{
						if(self weaponhasattachmentandunlocked(weapon, "extbarrel", "acog"))
						{
							if(var_6af452fc.var_85997af0 > scoreevents::get_distance_for_weapon(weapon, weaponclass))
							{
								self stats::function_dad108fa(#"hash_67c1416f36b6e6db", 1);
							}
						}
					}
					case "smg_accurate_t8":
					case "sniper_fastrechamber_t8":
					{
						self stats::function_dad108fa(#"hash_3e107dcbf6a27d6b", 1);
						break;
					}
					case "lmg_standard_t8":
					case "shotgun_semiauto_t8":
					{
						self stats::function_dad108fa(#"hash_1e8c81be34de26cd", 1);
						break;
					}
				}
			}
		}
		if(weapon.statname == "smg_handling_t8" && (isdefined(weapon.dualwieldweapon) && weapon.dualwieldweapon != level.weaponnone || self weaponhasattachmentandunlocked(weapon, "dw")))
		{
			self stats::function_dad108fa(#"hash_1dc20f3502e9530", 1);
		}
		if(isdefined(var_5018995b) && var_5018995b.statname == #"gadget_radiation_field" && (!isdefined(var_6af452fc.var_75c08813) || var_6af452fc.var_75c08813 < 1))
		{
			self stats::function_dad108fa(#"hash_2e2ced6c3eb284f1", 1);
		}
		if(var_bcbcb4ec === 1)
		{
			self stats::function_dad108fa(#"hash_4336ce626c607a44", 1);
		}
		if(var_fff76b4 === 1)
		{
			self stats::function_dad108fa(#"hash_6e5f0b13a4e75051", 1);
		}
		if(!isdefined(var_5afc3871[#"talent_resistance"]))
		{
			if(var_2d4a24ea)
			{
				if(var_6c5ba24c)
				{
					self stats::function_dad108fa(#"hash_f03c59c6881738c", 1);
				}
			}
			if(var_ba9c5900 === 1)
			{
				self stats::function_dad108fa(#"hash_f03c59c6881738c", 1);
			}
		}
		if(isdefined(var_70137a58.var_64ffda50))
		{
			var_f4917629 = var_70137a58.var_64ffda50[victimentnum];
			if(isdefined(var_f4917629) && (var_f4917629 + 6000) > time)
			{
				self stats::function_dad108fa(#"hash_66e8377fa1876239", 1);
			}
		}
		if(weapon != level.weaponnone)
		{
			if(isdefined(self.pickedupweapons) && isdefined(self.pickedupweapons[weapon]) && isdefined(self.var_c9062c1c))
			{
				var_eef88563 = self.pickedupweapons[weapon];
				if(var_eef88563 >= 0 && var_eef88563 == victimentnum)
				{
					if(!isdefined(self.var_c9062c1c[weapon]))
					{
						self.var_c9062c1c[weapon] = [];
					}
					if(!isdefined(self.var_c9062c1c[weapon][var_eef88563]))
					{
						self.var_c9062c1c[weapon][var_eef88563] = 0;
					}
					self.var_c9062c1c[weapon][var_eef88563]++;
				}
				if(isdefined(self.var_93da0d74[weapon]))
				{
					self.var_93da0d74[weapon]++;
					if(self.var_93da0d74[weapon] >= 5 && isdefined(self.var_c9062c1c[weapon]) && var_eef88563 == victimentnum && self.var_c9062c1c[weapon][var_eef88563] > 0)
					{
						self stats::function_dad108fa(#"killstreak_5_picked_up_weapon", 1);
						self.var_93da0d74[weapon] = self.var_93da0d74[weapon] - 5;
						self.var_c9062c1c[weapon][var_eef88563]--;
					}
				}
				else
				{
					self.var_93da0d74[weapon] = 1;
				}
				self contracts::function_a54e2068(#"hash_4b2b63ef119a97e5");
			}
		}
		if(var_2adaec2f === 1)
		{
			self stats::function_dad108fa(#"hash_c639ebeec696bf1", 1);
		}
		if(var_1f0bdb8f === 1)
		{
			self stats::function_dad108fa(#"hash_3bf4605458c33226", 1);
		}
		if(var_8a4cfbd)
		{
			self stats::function_dad108fa(#"hash_3b27d333dc1a3992", 1);
		}
		else if(weapon.var_b76e0a09)
		{
			self stats::function_dad108fa(#"hash_44671fb9af78d0c3", 1);
		}
		if(var_6af452fc.var_9a5c07a === 1)
		{
			if(var_6af452fc.var_79eb9a59 === self)
			{
				self stats::function_dad108fa(#"hash_44c24161e9b3945c", 1);
				var_38a1a18 = 1;
			}
		}
		if(!var_38a1a18 === 1 && isdefined(var_6af452fc.var_f208fb92))
		{
			if(isdefined(var_30f88120))
			{
				self stats::function_dad108fa(#"hash_44c24161e9b3945c", 1);
				var_38a1a18 = 1;
			}
		}
		if(!var_38a1a18 === 1 && isdefined(var_6af452fc.var_2acdce3e))
		{
			foreach(effect in var_6af452fc.var_2acdce3e)
			{
				if(!isdefined(effect.var_4b22e697) || self != effect.var_4b22e697 || !isdefined(effect.var_3d1ed4bd))
				{
					continue;
				}
				switch(effect.var_3d1ed4bd.name)
				{
					case "shock_rifle":
					case "ability_smart_cover":
					case "eq_swat_grenade":
					case "hash_3f62a872201cd1ce":
					case "hash_4a4ba36128b6582f":
					case "eq_concertina_wire":
					case "hero_flamethrower":
					case "gadget_radiation_field":
					{
						award = 1;
						break;
					}
					default:
					{
						break;
					}
				}
				if(award === 1)
				{
					self stats::function_dad108fa(#"hash_44c24161e9b3945c", 1);
					break;
				}
			}
		}
		if(var_828dac8f === 1)
		{
			self stats::function_dad108fa(#"hash_23d2a4d333f13590", 1);
		}
		if(var_6af452fc.var_b535f1ea === self && isdefined(var_6af452fc.var_2acdce3e))
		{
			if(isdefined(var_6af452fc.var_2acdce3e[#"hash_1527a22d8a6fdc21"]) && var_6af452fc.var_2acdce3e[#"hash_1527a22d8a6fdc21"].endtime > time)
			{
				if(self util::is_item_purchased(#"eq_slow_grenade"))
				{
					self stats::function_dad108fa(#"hash_36a4d25bb12449c0", 1);
				}
			}
		}
	}
	if(isdefined(level.activeplayeruavs) && level.activeplayeruavs[self.entnum] && (!isdefined(level.forceradar) || level.forceradar == 0))
	{
		self stats::function_dad108fa(#"hash_5a544ba1aa27778", 1);
	}
	if(isdefined(level.activeplayercounteruavs) && level.activeplayercounteruavs[self.entnum] > 0)
	{
		self stats::function_dad108fa(#"hash_4ac3550ff8622cb4", 1);
	}
	if(killstreak === #"dog")
	{
		if(weapon.var_b76e0a09)
		{
			self stats::function_dad108fa(#"hash_44671fb9af78d0c3", 1);
		}
	}
}

/*
	Name: challengekills
	Namespace: challenges
	Checksum: 0x6393F415
	Offset: 0x3E70
	Size: 0x3AD4
	Parameters: 1
	Flags: Linked
*/
function challengekills(data)
{
	weapon = data.weapon;
	player = data.attacker;
	victim = data.victim;
	attacker = data.attacker;
	time = data.time;
	attacker.lastkilledplayer = victim;
	attackerheroability = data.attackerheroability;
	attackerheroabilityactive = data.attackerheroabilityactive;
	attackersliding = data.attackersliding;
	attackerspeedburst = data.attackerspeedburst;
	attackertraversing = data.attackertraversing;
	attackervisionpulseactivatetime = data.attackervisionpulseactivatetime;
	attackervisionpulsearray = data.attackervisionpulsearray;
	attackervisionpulseorigin = data.attackervisionpulseorigin;
	attackervisionpulseoriginarray = data.attackervisionpulseoriginarray;
	var_1fa3e8cc = data.var_1fa3e8cc;
	var_8556c722 = data.var_8556c722;
	attackerwasconcussed = data.attackerwasconcussed;
	attackerwasflashed = data.attackerwasflashed;
	attackerwasheatwavestunned = data.attackerwasheatwavestunned;
	attackerwasonground = data.attackeronground;
	attackerwasunderwater = data.attackerwasunderwater;
	var_911b9b40 = data.var_911b9b40;
	attackerlastfastreloadtime = data.attackerlastfastreloadtime;
	lastweaponbeforetoss = data.lastweaponbeforetoss;
	meansofdeath = data.smeansofdeath;
	ownerweaponatlaunch = data.ownerweaponatlaunch;
	victimweapon = data.victimweapon;
	victimbedout = data.bledout;
	victimorigin = data.victimorigin;
	victimforward = data.victimforward;
	victimcombatefficiencylastontime = data.victimcombatefficiencylastontime;
	victimcombatefficieny = data.victimcombatefficieny;
	victimelectrifiedby = data.victimelectrifiedby;
	victimheroability = data.victimheroability;
	victimheroabilityactive = data.victimheroabilityactive;
	victimspeedburst = data.victimspeedburst;
	victimspeedburstlastontime = data.victimspeedburstlastontime;
	victimvisionpulseactivatetime = data.victimvisionpulseactivatetime;
	victimvisionpulsearray = data.victimvisionpulsearray;
	victimvisionpulseorigin = data.victimvisionpulseorigin;
	victimvisionpulseoriginarray = data.victimvisionpulseoriginarray;
	victimattackersthisspawn = data.victimattackersthisspawn;
	victimwasinslamstate = data.victimwasinslamstate;
	victimwaslungingwitharmblades = data.victimwaslungingwitharmblades;
	var_9fb5719b = data.var_9fb5719b;
	victimwasonground = data.victimonground;
	var_59b78db0 = data.var_59b78db0;
	victimwasunderwater = data.wasunderwater;
	var_e828179e = data.var_e828179e;
	victimlaststunnedby = data.victimlaststunnedby;
	var_642d3a64 = data.var_642d3a64;
	victimactiveproximitygrenades = data.victimactiveproximitygrenades;
	victimactivebouncingbetties = data.victimactivebouncingbetties;
	var_f91a4dd6 = data.var_f91a4dd6;
	attackerlastflashedby = data.attackerlastflashedby;
	attackerlaststunnedby = data.attackerlaststunnedby;
	attackerlaststunnedtime = data.attackerlaststunnedtime;
	attackerwassliding = data.attackerwassliding;
	attackerwassprinting = data.attackerwassprinting;
	attackerstance = data.attackerstance;
	wasdefusing = data.wasdefusing;
	wasplanting = data.wasplanting;
	inflictorownerwassprinting = data.inflictorownerwassprinting;
	playerorigin = data.attackerorigin;
	attackerforward = data.attackerforward;
	victim_jump_begin = data.victim_jump_begin;
	victim_jump_end = data.victim_jump_end;
	victim_swimming_begin = data.victim_swimming_begin;
	victim_swimming_end = data.victim_swimming_end;
	victim_slide_begin = data.victim_slide_begin;
	victim_slide_end = data.victim_slide_end;
	var_70763083 = data.var_70763083;
	var_d6553aa9 = data.var_d6553aa9;
	var_d24b8539 = data.var_6799f1da;
	attacker_jump_begin = data.attacker_jump_begin;
	attacker_jump_end = data.attacker_jump_end;
	attacker_swimming_begin = data.attacker_swimming_begin;
	attacker_swimming_end = data.attacker_swimming_end;
	attacker_slide_begin = data.attacker_slide_begin;
	attacker_slide_end = data.attacker_slide_end;
	attacker_sprint_end = data.attacker_sprint_end;
	attacker_sprint_begin = data.attacker_sprint_begin;
	var_e5241328 = data.var_e5241328;
	var_cc8f0762 = data.var_cc8f0762;
	var_58b48038 = data.var_58b48038;
	var_26aed950 = data.var_26aed950;
	inflictoriscooked = data.inflictoriscooked;
	inflictorchallenge_hatchettosscount = data.inflictorchallenge_hatchettosscount;
	inflictorownerwassprinting = data.inflictorownerwassprinting;
	inflictorplayerhasengineerperk = data.inflictorplayerhasengineerperk;
	inflictor = data.einflictor;
	var_937b6de2 = isdefined(victim.challenge_combatrobotattackclientid) && isdefined(victim.challenge_combatrobotattackclientid[player.clientid]);
	weaponclass = util::getweaponclass(weapon);
	baseweapon = getbaseweapon(weapon);
	baseweaponitemindex = getbaseweaponitemindex(baseweapon);
	weaponpurchased = player isitempurchased(baseweaponitemindex);
	victimsupportindex = victim.team;
	playersupportindex = player.team;
	if(!level.teambased)
	{
		playersupportindex = player.entnum;
		victimsupportindex = victim.entnum;
	}
	if(meansofdeath == #"mod_head_shot" || meansofdeath == #"mod_pistol_bullet" || meansofdeath == #"mod_rifle_bullet")
	{
		bulletkill = 1;
	}
	else if(baseweapon == level.var_9e188c0b && (meansofdeath == #"mod_impact" || meansofdeath == #"mod_projectile" || meansofdeath == #"mod_projectile_splash"))
	{
		bulletkill = 1;
	}
	else
	{
		bulletkill = 0;
	}
	if(level.teambased)
	{
		if(player.team == victim.team)
		{
			return;
		}
	}
	else if(player == victim)
	{
		return;
	}
	killstreak = killstreaks::get_from_weapon(weapon);
	if(!isdefined(killstreak))
	{
		if(level.hardcoremode)
		{
			player stats::function_dad108fa(#"hash_2c09ac12bc5011d7", 1);
			if(isdefined(var_e5241328) && (var_e5241328 + 4500) > time)
			{
				player stats::function_dad108fa(#"hash_5870347fe646f35d", 1);
			}
			if(player.health < player.maxhealth)
			{
				player stats::function_dad108fa(#"hash_4df4926dc674bdbb", 1);
			}
			if(weapon_utils::ismeleemod(meansofdeath) && weapon_utils::ispunch(weapon))
			{
				player stats::function_dad108fa(#"hash_3796fb20d85df3ee", 1);
			}
		}
		player processspecialistchallenge("kills");
		if(weapon.isheavyweapon)
		{
			if(!isdefined(player.pers[#"challenge_heroweaponkills"]))
			{
				player.pers[#"challenge_heroweaponkills"] = 0;
			}
			player processspecialistchallenge("kills_weapon");
			player.heavyweaponkillsthisactivation++;
			player.pers[#"challenge_heroweaponkills"]++;
			if(player.pers[#"challenge_heroweaponkills"] >= 6)
			{
				player processspecialistchallenge("kill_one_game_weapon");
				player.pers[#"challenge_heroweaponkills"] = 0;
			}
		}
	}
	else
	{
		player function_ea966b4a(killstreak);
	}
	if(bulletkill && !isdefined(killstreak))
	{
		player genericbulletkill(data, victim, weapon);
		if(weaponpurchased)
		{
			if(weaponclass == #"weapon_sniper")
			{
				if(isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time)
				{
					player stats::function_dad108fa(#"kill_enemy_one_bullet_sniper", 1);
					player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_sniper", 1);
					if(!isdefined(player.pers[#"kill_enemy_one_bullet_sniper"]))
					{
						player.pers[#"kill_enemy_one_bullet_sniper"] = 0;
					}
					player.pers[#"kill_enemy_one_bullet_sniper"]++;
					if((player.pers[#"kill_enemy_one_bullet_sniper"] % 10) == 0)
					{
						player stats::function_dad108fa(#"hash_2ebd387ffb67e1dc", 1);
					}
				}
			}
			else if(weaponclass == "weapon_cqb")
			{
				if(isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time)
				{
					player stats::function_dad108fa(#"kill_enemy_one_bullet_shotgun", 1);
					player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_shotgun", 1);
				}
			}
		}
		checkkillstreak5(baseweapon, player);
		function_b2b18857(player);
		if(meansofdeath == #"mod_head_shot")
		{
			if(isdefined(victim.var_ea1458aa) && isdefined(victim.var_ea1458aa.attackerdamage))
			{
				var_d72bd991 = victim.var_ea1458aa.attackerdamage[player.clientid];
				gear = player function_b958b70d(player.class_num, "tacticalgear");
				if(gear === #"gear_armor" && isdefined(var_d72bd991))
				{
					if(var_d72bd991.var_d7bd6f9b === 1)
					{
						player stats::function_dad108fa(#"hash_2ed3de647f5090f1", 1);
					}
				}
			}
		}
		if(isdefined(var_26aed950[#"talent_lightweight"]))
		{
			player stats::function_dad108fa(#"hash_514b48072f97315e", 1);
		}
		if(weapon.isdualwield && weaponpurchased)
		{
			checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
		}
		if(isdefined(weapon.attachments) && weapon.attachments.size > 0)
		{
			attachmentname = player getweaponoptic(weapon);
			if(isdefined(attachmentname) && attachmentname != "" && player weaponhasattachmentandunlocked(weapon, attachmentname))
			{
				if(weapon.attachments.size > 5 && player allweaponattachmentsunlocked(weapon) && !isdefined(attacker.tookweaponfrom[weapon]))
				{
					player stats::function_dad108fa(#"kill_optic_5_attachments", 1);
				}
				if(isdefined(player.attachmentkillsthisspawn[attachmentname]))
				{
					player.attachmentkillsthisspawn[attachmentname]++;
					if(player.attachmentkillsthisspawn[attachmentname] == 5)
					{
						player stats::function_e24eec31(weapon, #"killstreak_5_attachment", 1);
					}
				}
				else
				{
					player.attachmentkillsthisspawn[attachmentname] = 1;
				}
				if(weapon_utils::ispistol(weapon.rootweapon))
				{
					if(player weaponhasattachmentandunlocked(weapon, "suppressed", "extbarrel"))
					{
						player stats::function_dad108fa(#"kills_pistol_lasersight_suppressor_longbarrel", 1);
					}
				}
			}
			if(player weaponhasattachmentandunlocked(weapon, "suppressed"))
			{
				if(attacker util::has_hard_wired_perk_purchased_and_equipped() && attacker util::has_ghost_perk_purchased_and_equipped() && attacker util::has_jetquiet_perk_purchased_and_equipped())
				{
					player stats::function_dad108fa(#"kills_suppressor_ghost_hardwired_blastsuppressor", 1);
				}
			}
			if(player playerads() == 1)
			{
				if(isdefined(player.smokegrenadetime) && isdefined(player.smokegrenadeposition))
				{
					if(player.smokegrenadetime + 14000 > time)
					{
						if(player util::is_looking_at(player.smokegrenadeposition) || distancesquared(player.origin, player.smokegrenadeposition) < 40000)
						{
							if(player weaponhasattachmentandunlocked(weapon, "ir"))
							{
								player stats::function_dad108fa(#"kill_with_thermal_and_smoke_ads", 1);
								player stats::function_e24eec31(weapon, #"kill_thermal_through_smoke", 1);
							}
						}
					}
				}
			}
			if(weapon.attachments.size > 1)
			{
				if(player playerads() == 1)
				{
					if(player weaponhasattachmentandunlocked(weapon, "grip", "quickdraw"))
					{
						player stats::function_dad108fa(#"kills_ads_quickdraw_and_grip", 1);
					}
					if(player weaponhasattachmentandunlocked(weapon, "swayreduc", "stalker"))
					{
						player stats::function_dad108fa(#"kills_ads_stock_and_cpu", 1);
					}
				}
				else if(player weaponhasattachmentandunlocked(weapon, "rf", "steadyaim"))
				{
					if(attacker util::has_fast_hands_perk_purchased_and_equipped())
					{
						player stats::function_dad108fa(#"kills_hipfire_rapidfire_lasersights_fasthands", 1);
					}
				}
				if(player weaponhasattachmentandunlocked(weapon, "fastreload", "extclip"))
				{
					player.pers[#"killsfastmagext"]++;
					if(player.pers[#"killsfastmagext"] > 4)
					{
						player stats::function_dad108fa(#"kills_one_life_fastmags_and_extclip", 1);
						player.pers[#"killsfastmagext"] = 0;
					}
				}
			}
			if(weapon.attachments.size > 2)
			{
				if(meansofdeath == #"mod_head_shot")
				{
					if(player weaponhasattachmentandunlocked(weapon, "fmj", "damage", "extbarrel"))
					{
						player stats::function_dad108fa(#"headshot_fmj_highcaliber_longbarrel", 1);
					}
					if(weapon.statname == #"pistol_revolver_t8")
					{
						if(player weaponhasattachmentandunlocked(weapon, "uber", "extbarrel", "extbarrel2"))
						{
							player stats::function_dad108fa(#"hash_5465ee91c99dca6c", 1);
						}
					}
				}
			}
			if(weapon.attachments.size > 4)
			{
				if(player weaponhasattachmentandunlocked(weapon, "extclip", "grip", "fastreload", "quickdraw", "stalker"))
				{
					player stats::function_dad108fa(#"kills_extclip_grip_fastmag_quickdraw_stock", 1);
				}
			}
		}
		if(isdefined(attackerlastfastreloadtime) && (time - attackerlastfastreloadtime) <= 5000 && player weaponhasattachmentandunlocked(weapon, "fastreload"))
		{
			player stats::function_dad108fa(#"kills_after_reload_fastreload", 1);
		}
		if(isdefined(victim.idflagstime) && victim.idflagstime == time)
		{
			if(victim.idflags & 8)
			{
				player stats::function_dad108fa(#"kill_enemy_through_wall", 1);
				if(player weaponhasattachmentandunlocked(weapon, "fmj"))
				{
					player stats::function_dad108fa(#"kill_enemy_through_wall_with_fmj", 1);
				}
			}
		}
		if(vectordot(attackerforward, victimforward) < -0.98)
		{
			if(isdefined(var_642d3a64) && (var_642d3a64 + 5500) > time)
			{
				var_141c7081 = victimorigin + vectorscale((0, 0, 1), 31);
				var_2baca0fc = !bullettracepassed(var_141c7081, var_141c7081 + (victimforward * 144), 0, victim);
				if(var_2baca0fc)
				{
					player stats::function_dad108fa(#"hash_4c3088a2e317bb2", 1);
				}
			}
		}
	}
	else if(weapon_utils::ismeleemod(meansofdeath) && !isdefined(killstreak))
	{
		player stats::function_dad108fa(#"melee", 1);
		if(weapon_utils::ispunch(weapon))
		{
			player stats::function_dad108fa(#"kill_enemy_with_fists", 1);
		}
		if(weapon.statname == #"ar_stealth_t8" || weapon.statname == #"pistol_standard_t8")
		{
			if(player weaponhasattachmentandunlocked(weapon, "uber"))
			{
				player stats::function_dad108fa(#"hash_541dc7f1d7d397a", 1);
			}
		}
		checkkillstreak5(baseweapon, player);
	}
	else if(!isdefined(killstreak))
	{
		if(weaponclass == #"weapon_launcher")
		{
			player stats::function_dad108fa(#"hash_be93d1227e6db1", 1);
		}
		if(weaponpurchased)
		{
			var_291c422e = player loadout::function_18a77b37("primarygrenade");
			if(weapon === var_291c422e)
			{
				if(player.challenge_scavengedcount > 0)
				{
					player.challenge_resuppliednamekills++;
					if(player.challenge_resuppliednamekills >= 3)
					{
						player stats::function_dad108fa(#"kills_3_resupplied_nade_one_life", 1);
						player.challenge_resuppliednamekills = 0;
					}
					player.challenge_scavengedcount--;
				}
			}
			if(isdefined(inflictoriscooked))
			{
				if(inflictoriscooked == 1 && weapon.statname == #"frag_grenade")
				{
					player stats::function_dad108fa(#"kill_with_cooked_grenade", 1);
				}
			}
			if(victimlaststunnedby === player)
			{
				if(weaponclass == "weapon_grenade")
				{
					player stats::function_dad108fa(#"kill_stun_lethal", 1);
				}
			}
			if(baseweapon.statname == level.weaponballisticknife.statname)
			{
				player function_80327323(data);
				if(isdefined(var_26aed950[#"talent_lightweight"]))
				{
					player stats::function_dad108fa(#"hash_514b48072f97315e", 1);
				}
			}
			if(baseweapon == level.weaponspecialcrossbow)
			{
				if(weapon.isdualwield)
				{
					checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end);
				}
			}
			if(baseweapon == level.weaponshotgunenergy)
			{
				if(isdefined(victim.firsttimedamaged) && victim.firsttimedamaged == time)
				{
					player stats::function_dad108fa(#"kill_enemy_one_bullet_shotgun", 1);
					player stats::function_e24eec31(weapon, #"kill_enemy_one_bullet_shotgun", 1);
				}
			}
		}
		if(baseweapon.forcedamagehitlocation || baseweapon == level.weaponspecialcrossbow || baseweapon == level.weaponshotgunenergy || baseweapon.statname == level.weaponballisticknife.statname)
		{
			checkkillstreak5(baseweapon, player);
		}
	}
	if(isdefined(attacker) && isdefined(attacker.tookweaponfrom) && isdefined(attacker.tookweaponfrom[weapon]) && isdefined(attacker.tookweaponfrom[weapon].previousowner))
	{
		if(!isdefined(attacker.tookweaponfrom[weapon].previousowner.team) || attacker.tookweaponfrom[weapon].previousowner.team != player.team)
		{
			player stats::function_dad108fa(#"kill_with_pickup", 1);
		}
	}
	awarded_kill_enemy_that_blinded_you = 0;
	playerhastacticalmask = player player::function_14e61d05();
	if(attackerwasflashed)
	{
		if(attackerlastflashedby === victim && !playerhastacticalmask)
		{
			player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
			awarded_kill_enemy_that_blinded_you = 1;
		}
	}
	if(!awarded_kill_enemy_that_blinded_you && isdefined(attackerlaststunnedtime) && (attackerlaststunnedtime + 5000) > time)
	{
		if(attackerlaststunnedby === victim && !playerhastacticalmask)
		{
			player stats::function_dad108fa(#"kill_enemy_that_blinded_you", 1);
			awarded_kill_enemy_that_blinded_you = 1;
		}
	}
	killedstunnedvictim = 0;
	if(isdefined(victim.lastconcussedby) && victim.lastconcussedby == attacker)
	{
		if(victim.concussionendtime > time)
		{
			killedstunnedvictim = 1;
		}
	}
	if(isdefined(victim.lastshockedby) && victim.lastshockedby == attacker)
	{
		if(victim.shockendtime > time)
		{
			if(player util::is_item_purchased(#"proximity_grenade"))
			{
				player stats::function_dad108fa(#"kill_shocked_enemy", 1);
			}
			player function_be7a08a8(getweapon(#"proximity_grenade"), 1);
			killedstunnedvictim = 1;
			if(weapon.rootweapon.name == "bouncingbetty")
			{
				player stats::function_dad108fa(#"kill_trip_mine_shocked", 1);
			}
		}
	}
	if(victim util::isflashbanged())
	{
		if(isdefined(victim.lastflashedby) && victim.lastflashedby == player)
		{
			killedstunnedvictim = 1;
			if(player util::is_item_purchased(#"flash_grenade"))
			{
				player stats::function_dad108fa(#"kill_flashed_enemy", 1);
			}
			player function_be7a08a8(getweapon(#"flash_grenade"), 1);
		}
	}
	if(level.teambased)
	{
		if(!isdefined(player.pers[#"kill_every_enemy_with_specialist"]) && (level.playercount[victim.pers[#"team"]] > 3 && player.pers[#"killed_players_with_specialist"].size >= level.playercount[victim.pers[#"team"]]))
		{
			player stats::function_dad108fa(#"kill_every_enemy", 1);
			player.pers[#"kill_every_enemy_with_specialist"] = 1;
		}
		if(isdefined(victimattackersthisspawn) && isarray(victimattackersthisspawn))
		{
			if(victimattackersthisspawn.size > 5)
			{
				attackercount = 0;
				foreach(attacking_player in victimattackersthisspawn)
				{
					if(!isdefined(attacking_player))
					{
						continue;
					}
					if(attacking_player == attacker)
					{
						continue;
					}
					if(attacking_player.team != attacker.team)
					{
						continue;
					}
					attackercount++;
				}
				if(attackercount > 4)
				{
					player stats::function_dad108fa(#"kill_enemy_5_teammates_assists", 1);
				}
			}
		}
	}
	if(isdefined(killstreak))
	{
		if(killstreak == "ultimate_turret" || killstreak == "inventory_ultimate_turret")
		{
			if(isdefined(inflictor))
			{
				if(!isdefined(inflictor.challenge_killcount))
				{
					inflictor.challenge_killcount = 0;
				}
				inflictor.challenge_killcount++;
				if(inflictor.challenge_killcount == 5)
				{
					player stats::function_dad108fa(#"hash_636e38d21d529ce3", 1);
				}
			}
		}
	}
	if(var_937b6de2)
	{
		if(!isdefined(inflictor) || !isdefined(inflictor.killstreaktype) || !isstring(inflictor.killstreaktype) || inflictor.killstreaktype != "combat_robot")
		{
			player stats::function_dad108fa(#"kill_enemy_who_damaged_robot", 1);
		}
	}
	var_46119dfa = player getloadoutitem(player.class_num, "primarygrenadecount");
	if(var_46119dfa)
	{
		if(weapon.rootweapon.name == "hatchet" && inflictorchallenge_hatchettosscount <= 2)
		{
			player.challenge_hatchetkills++;
			if(player.challenge_hatchetkills == 2)
			{
				player stats::function_dad108fa(#"kills_first_throw_both_hatchets", 1);
			}
		}
	}
	player trackkillstreaksupportkills(victim);
	if(!isdefined(killstreak))
	{
		if(attackerwasunderwater)
		{
			player stats::function_dad108fa(#"kill_while_underwater", 1);
		}
		if(attackerwasunderwater && var_e828179e < 5 && !var_8556c722)
		{
			player stats::function_dad108fa(#"hash_11d3c69f5a54bc66", 1);
		}
		trackedplayer = 0;
		if(player util::has_purchased_perk_equipped(#"specialty_tracker"))
		{
			if(!victim hasperk(#"specialty_trackerjammer"))
			{
				player stats::function_dad108fa(#"kill_detect_tracker", 1);
				trackedplayer = 1;
			}
		}
		if(player util::has_purchased_perk_equipped(#"specialty_detectnearbyenemies"))
		{
			if(!victim hasperk(#"specialty_sixthsensejammer"))
			{
				player stats::function_dad108fa(#"kill_enemy_sixth_sense", 1);
				if(player util::has_purchased_perk_equipped(#"specialty_loudenemies"))
				{
					if(!victim hasperk(#"specialty_quieter"))
					{
						player stats::function_dad108fa(#"kill_sixthsense_awareness", 1);
					}
				}
			}
			if(trackedplayer)
			{
				player stats::function_dad108fa(#"kill_tracker_sixthsense", 1);
			}
		}
		if(weapon.isheavyweapon == 1 || attackerheroabilityactive)
		{
			if(player util::has_purchased_perk_equipped(#"specialty_overcharge"))
			{
				player stats::function_dad108fa(#"kill_with_specialist_overclock", 1);
			}
		}
		if(player util::has_purchased_perk_equipped(#"specialty_gpsjammer"))
		{
			if(uav::hasuav(victimsupportindex))
			{
				player stats::function_dad108fa(#"kill_uav_enemy_with_ghost", 1);
			}
			if(player util::has_blind_eye_perk_purchased_and_equipped())
			{
				activekillstreaks = victim killstreaks::getactivekillstreaks();
				awarded_kill_blindeye_ghost_aircraft = 0;
				foreach(activestreak in activekillstreaks)
				{
					if(awarded_kill_blindeye_ghost_aircraft)
					{
						break;
					}
					switch(activestreak.killstreaktype)
					{
						case "drone_striked":
						case "uav":
						case "helicopter_comlink":
						case "sentinel":
						{
							player stats::function_dad108fa(#"kill_blindeye_ghost_aircraft", 1);
							awarded_kill_blindeye_ghost_aircraft = 1;
							break;
						}
					}
				}
			}
		}
		if(player util::has_purchased_perk_equipped(#"specialty_flakjacket"))
		{
			if(isdefined(player.challenge_lastsurvivewithflakfrom) && player.challenge_lastsurvivewithflakfrom == victim)
			{
				player stats::function_dad108fa(#"kill_enemy_survive_flak", 1);
			}
			if(player util::has_tactical_mask_purchased_and_equipped())
			{
				if(attackerwasflashed || (isdefined(player.challenge_lastsurvivewithflaktime) && (player.challenge_lastsurvivewithflaktime + 3500) > time) || (isdefined(attackerlaststunnedtime) && (attackerlaststunnedtime + 2500) > time))
				{
					player stats::function_dad108fa(#"kill_flak_tac_while_stunned", 1);
				}
			}
		}
		if(player util::has_hard_wired_perk_purchased_and_equipped())
		{
			if(victim counteruav::hasindexactivecounteruav(victimsupportindex))
			{
				player stats::function_dad108fa(#"kills_counteruav_emp_hardline", 1);
			}
		}
		if(player util::has_scavenger_perk_purchased_and_equipped())
		{
			if(player.scavenged)
			{
				player stats::function_dad108fa(#"kill_after_resupply", 1);
				if(trackedplayer)
				{
					player stats::function_dad108fa(#"kill_scavenger_tracker_resupply", 1);
				}
			}
		}
		if(player util::has_fast_hands_perk_purchased_and_equipped())
		{
			if(bulletkill)
			{
				if(attackerwassprinting || (attacker_sprint_end + 3000) > time)
				{
					player stats::function_dad108fa(#"kills_after_sprint_fasthands", 1);
					if(player util::has_gung_ho_perk_purchased_and_equipped())
					{
						player stats::function_dad108fa(#"kill_fasthands_gungho_sprint", 1);
					}
				}
			}
		}
		if(player util::has_hard_wired_perk_purchased_and_equipped())
		{
			if(player util::has_cold_blooded_perk_purchased_and_equipped())
			{
				player stats::function_dad108fa(#"kill_hardwired_coldblooded", 1);
			}
		}
		killedplayerwithgungho = 0;
		if(player util::has_gung_ho_perk_purchased_and_equipped())
		{
			if(bulletkill)
			{
				killedplayerwithgungho = 1;
				if(attackerwassprinting && player playerads() != 1)
				{
					player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
				}
			}
			if(weaponclass == "weapon_grenade")
			{
				if(isdefined(inflictorownerwassprinting) && inflictorownerwassprinting == 1)
				{
					killedplayerwithgungho = 1;
					player stats::function_dad108fa(#"kill_hip_gung_ho", 1);
				}
			}
		}
		if(player util::has_awareness_perk_purchased_and_equipped())
		{
			player stats::function_dad108fa(#"kill_awareness", 1);
		}
		if(killedstunnedvictim)
		{
			if(player util::has_tactical_mask_purchased_and_equipped())
			{
				player stats::function_dad108fa(#"kill_stunned_tacmask", 1);
				if(killedplayerwithgungho == 1)
				{
					player stats::function_dad108fa(#"kill_sprint_stunned_gungho_tac", 1);
				}
			}
		}
		if(player util::has_ninja_perk_purchased_and_equipped())
		{
			player stats::function_dad108fa(#"kill_dead_silence", 1);
			if(distancesquared(playerorigin, victimorigin) < 14400)
			{
				if(player util::has_awareness_perk_purchased_and_equipped())
				{
					player stats::function_dad108fa(#"kill_close_deadsilence_awareness", 1);
				}
				if(player util::has_jetquiet_perk_purchased_and_equipped())
				{
					player stats::function_dad108fa(#"kill_close_blast_deadsilence", 1);
				}
			}
		}
		primary_weapon = player loadout::function_18a77b37("primary");
		if(isdefined(primary_weapon) && weapon == primary_weapon || (isdefined(primary_weapon) && isdefined(primary_weapon.altweapon) && weapon == primary_weapon.altweapon))
		{
			if(player function_861fe993("secondary"))
			{
				player function_7ec2f2c("primary", 0);
				player function_7ec2f2c("secondary", 0);
			}
			else
			{
				player function_7ec2f2c("primary", 1);
			}
		}
		else
		{
			secondary_weapon = player loadout::function_18a77b37("secondary");
			if(isdefined(secondary_weapon) && weapon == secondary_weapon || (isdefined(secondary_weapon) && isdefined(secondary_weapon.altweapon) && weapon == secondary_weapon.altweapon))
			{
				if(player function_861fe993("primary"))
				{
					player function_7ec2f2c("primary", 0);
					player function_7ec2f2c("secondary", 0);
				}
				else
				{
					player function_7ec2f2c("secondary", 1);
				}
			}
		}
		if(player util::has_hacker_perk_purchased_and_equipped() && player util::has_hard_wired_perk_purchased_and_equipped())
		{
			should_award_kill_near_plant_engineer_hardwired = 0;
			if(isdefined(victimactivebouncingbetties))
			{
				foreach(bouncingbettyinfo in victimactivebouncingbetties)
				{
					if(!isdefined(bouncingbettyinfo) || !isdefined(bouncingbettyinfo.origin))
					{
						continue;
					}
					if(distancesquared(bouncingbettyinfo.origin, victimorigin) < 400 * 400)
					{
						should_award_kill_near_plant_engineer_hardwired = 1;
						break;
					}
				}
			}
			if(isdefined(victimactiveproximitygrenades) && should_award_kill_near_plant_engineer_hardwired == 0)
			{
				foreach(proximitygrenadeinfo in victimactiveproximitygrenades)
				{
					if(!isdefined(proximitygrenadeinfo) || !isdefined(proximitygrenadeinfo.origin))
					{
						continue;
					}
					if(distancesquared(proximitygrenadeinfo.origin, victimorigin) < 400 * 400)
					{
						should_award_kill_near_plant_engineer_hardwired = 1;
						break;
					}
				}
			}
			if(should_award_kill_near_plant_engineer_hardwired)
			{
				player stats::function_dad108fa(#"kill_near_plant_engineer_hardwired", 1);
			}
		}
		if(isdefined(var_70763083) && (var_70763083 + 2500) > time)
		{
			player stats::function_dad108fa(#"hash_32fcecc2ce978d75", 1);
		}
		if(isdefined(var_e5241328) && (var_e5241328 + 4500) > time)
		{
			if(isdefined(attacker.health) && isdefined(var_cc8f0762) && (attacker.health - var_cc8f0762) > 40)
			{
				attacker stats::function_dad108fa(#"hash_380aac2b11287e8a", 1);
			}
		}
		if(var_d6553aa9 === 1 && level.teambased)
		{
			attacker stats::function_dad108fa(#"hash_ae06343a118b545", 1);
		}
		if(!victimwasonground && var_e828179e <= 0)
		{
			attacker stats::function_dad108fa(#"hash_5dad79e4cd7ab628", 1);
		}
		if(victimweapon.var_b76e0a09 === 1)
		{
			if(!isdefined(var_f91a4dd6) || var_f91a4dd6 < 1)
			{
				attacker stats::function_dad108fa(#"kill_before_specialist_weapon_use", 1);
			}
			if(victimweapon.statname == #"sig_buckler_dw")
			{
				if(!isdefined(killstreak) && bulletkill && (vectordot(victimforward, playerorigin - victimorigin)) < 0)
				{
					attacker stats::function_dad108fa(#"hash_338dcf397005db6e", 1);
				}
			}
		}
		if(isdefined(level.var_2e3031be) && (isdefined(victimvisionpulseactivatetime) && (victimvisionpulseactivatetime + ((level.var_2e3031be.gadget_pulse_duration / 3) + 500)) > time))
		{
			attacker stats::function_dad108fa(#"hash_7d0936fda6c3d60", 1);
		}
		if(var_1fa3e8cc === 1 && !var_8556c722 && var_911b9b40 !== 1)
		{
			attacker stats::function_dad108fa(#"hash_2b06c2f3dac10099", 1);
		}
		if(isdefined(attacker.attackerdamage) && isdefined(attacker.attackerdamage[victim.clientid]) && (isdefined(attacker.attackerdamage[victim.clientid].lasttimedamaged) && (attacker.attackerdamage[victim.clientid].lasttimedamaged + 1500) > time))
		{
			attacker stats::function_dad108fa(#"hash_40df7b67ff81556e", 1);
		}
		if(!victimwasonground && victimwasinslamstate && var_d24b8539 === 1)
		{
			attacker stats::function_dad108fa(#"hash_50371401f38a92f", 1);
		}
		if(isdefined(var_58b48038))
		{
			attacker stats::function_dad108fa(#"hash_372c6d8c80773a55", 1);
		}
	}
	else if(weapon.name == #"supplydrop")
	{
		if(isdefined(inflictorplayerhasengineerperk))
		{
			player stats::function_dad108fa(#"kill_booby_trap_engineer", 1);
		}
	}
	var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);
	if(victimweapon.var_b76e0a09 === 1 || (isdefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1))
	{
		if(killstreak == #"dart" || killstreak == #"inventory_dart" || killstreak == #"recon_car" || killstreak == #"inventory_recon_car" || (killstreak == #"tank_robot" || killstreak == #"inventory_tank_robot" && var_911b9b40 === 1))
		{
			attacker stats::function_dad108fa(#"hash_7ce97233d9d7e81", 1);
		}
	}
	if(weapon.isheavyweapon == 1 || attackerheroabilityactive || isdefined(killstreak))
	{
		if(player util::has_purchased_perk_equipped(#"specialty_overcharge") && player util::has_purchased_perk_equipped(#"specialty_anteup"))
		{
			player stats::function_dad108fa(#"kill_anteup_overclock_scorestreak_specialist", 1);
		}
	}
	var_eae59bb8 = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
	if(weapon.var_b76e0a09 === 1 || (isdefined(var_eae59bb8) && var_eae59bb8.var_fcd2ff3a === 1))
	{
		if(victimweapon.var_b76e0a09 === 1)
		{
			attacker stats::function_dad108fa(#"kill_specialist_with_specialist", 1);
		}
	}
	if(victimweapon.statname == #"hero_flamethrower" && weapon.statname == #"eq_molotov")
	{
		attacker stats::function_dad108fa(#"hash_629a20c6ee8f4970", 1);
	}
	if(victimweapon.statname == #"hero_annihilator" && (weapon.statname == #"hero_annihilator" || weapon.statname == #"pistol_revolver_t8"))
	{
		attacker stats::function_dad108fa(#"hash_287ebd7fa443018a", 1);
	}
}

/*
	Name: on_player_spawn
	Namespace: challenges
	Checksum: 0xCE6005D6
	Offset: 0x7950
	Size: 0xF6
	Parameters: 0
	Flags: Linked
*/
function on_player_spawn()
{
	if(canprocesschallenges())
	{
		self fix_challenge_stats_on_spawn();
		self function_b6d44fd9();
	}
	self function_6b34141d();
	self thread watchjump();
	self thread watchswimming();
	self thread watchslide();
	self thread watchsprint();
	self thread watchscavengelethal();
	self thread watchweaponchangecomplete();
}

/*
	Name: function_b6d44fd9
	Namespace: challenges
	Checksum: 0xF8AB5095
	Offset: 0x7A50
	Size: 0xE
	Parameters: 0
	Flags: Linked
*/
function function_b6d44fd9()
{
	self.var_ea1458aa = {};
}

/*
	Name: force_challenge_stat
	Namespace: challenges
	Checksum: 0xDD1B36CE
	Offset: 0x7A68
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function force_challenge_stat(stat_name, stat_value)
{
	self stats::function_4db3fba1(stat_name, stat_value);
	self stats::function_efbbc38f(stat_name, stat_value);
}

/*
	Name: get_challenge_group_stat
	Namespace: challenges
	Checksum: 0x9149234
	Offset: 0x7AB8
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function get_challenge_group_stat(group_name, stat_name)
{
	return self stats::get_stat(#"groupstats", group_name, #"stats", stat_name, #"challengevalue");
}

/*
	Name: fix_challenge_stats_on_spawn
	Namespace: challenges
	Checksum: 0xDF86C15F
	Offset: 0x7B18
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function fix_challenge_stats_on_spawn()
{
	player = self;
	if(!isdefined(player))
	{
		return;
	}
	if(player.var_8efcbd6a === 1)
	{
		return;
	}
	player thread function_4039ce49();
	player.var_8efcbd6a = 1;
}

/*
	Name: function_4039ce49
	Namespace: challenges
	Checksum: 0xDBAB0A5A
	Offset: 0x7B78
	Size: 0x9E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4039ce49()
{
	player = self;
	player endon(#"disconnect");
	while(game.state != "playing")
	{
		wait(1);
	}
	wait_time = randomfloatrange(3, 5);
	wait(wait_time);
	if(!isdefined(player))
	{
		return;
	}
	player function_ba57595b();
}

/*
	Name: function_ba57595b
	Namespace: challenges
	Checksum: 0x5239601D
	Offset: 0x7C20
	Size: 0x7C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ba57595b()
{
	player = self;
	player function_223ff464();
	player function_f4106216();
	player function_34364901();
	if(function_8b1a219a())
	{
		player function_bd5db926();
	}
}

/*
	Name: function_223ff464
	Namespace: challenges
	Checksum: 0xF93FB01E
	Offset: 0x7CA8
	Size: 0x274
	Parameters: 0
	Flags: Linked
*/
function function_223ff464()
{
	if(!self stats::get_stat(#"extrabools", 0) === 1)
	{
		self force_challenge_stat(#"hash_3cb957dcdd3bca71", 0);
		var_62fe685a = [];
		array::add(var_62fe685a, #"hash_4075f20007923416");
		array::add(var_62fe685a, #"hash_72d1952fced05f40");
		array::add(var_62fe685a, #"hash_70cd6c54d1c07272");
		array::add(var_62fe685a, #"hash_6b828c2fcb0e8df5");
		array::add(var_62fe685a, #"hash_2ea8a6bab2364c58");
		array::add(var_62fe685a, #"hash_7ecfcae46143397c");
		array::add(var_62fe685a, #"hash_3b30f98820bc20cf");
		array::add(var_62fe685a, #"hash_18816731b999fbfb");
		array::add(var_62fe685a, #"hash_6c1c399dcbe1af97");
		array::add(var_62fe685a, #"hash_5630ec40181e1db3");
		array::add(var_62fe685a, #"hash_354bfe5c140365bf");
		array::add(var_62fe685a, #"hash_51eff59939399dc9");
		for(index = 0; index < var_62fe685a.size; index++)
		{
			if(self stats::function_af5584ca(var_62fe685a[index]) === 1)
			{
				self stats::function_dad108fa(#"hash_3cb957dcdd3bca71", 1);
			}
		}
		self stats::set_stat(#"extrabools", 0, 1);
	}
}

/*
	Name: function_bd5db926
	Namespace: challenges
	Checksum: 0x332B99CB
	Offset: 0x7F28
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_bd5db926()
{
	if(!self stats::get_stat(#"extrabools", 1) === 1)
	{
		var_5d157945 = self stats::function_441050ca(#"hash_521c03035f73600f");
		recon_car = getweapon(#"hash_38ffd09564931482");
		self stats::function_e24eec31(recon_car, #"kills", var_5d157945);
		self stats::set_stat(#"extrabools", 1, 1);
	}
}

/*
	Name: function_f4106216
	Namespace: challenges
	Checksum: 0x996C339D
	Offset: 0x8010
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_f4106216()
{
	if(!self stats::get_stat(#"playerstatslist", #"hash_195a18a5697c5c96") === 1)
	{
		challengetier = self stats::function_af5584ca("shutdown_gravslam_before_impact");
		if(!isdefined(challengetier))
		{
			return;
		}
		if(challengetier > 0)
		{
			self stats::function_8e071909("stats_gravity_slam_shutdown", challengetier);
		}
		challengevalue = self stats::function_222de31d("shutdown_gravslam_before_impact");
		self stats::function_efbbc38f("stats_gravity_slam_shutdown", challengevalue);
		self stats::set_stat(#"playerstatslist", #"hash_195a18a5697c5c96", 1);
	}
}

/*
	Name: function_34364901
	Namespace: challenges
	Checksum: 0x68D8243A
	Offset: 0x8138
	Size: 0x1C4
	Parameters: 0
	Flags: Linked
*/
function function_34364901()
{
	player = self;
	var_fae27922 = player stats::get_stat(#"hash_162f9b6a10fa7d66", #"sniper_locus_t8", #"hash_b7deb436e166ba3", #"challengevalue");
	if(var_fae27922 === 6)
	{
		player stats::set_stat(#"hash_162f9b6a10fa7d66", #"sniper_locus_t8", #"hash_b7deb436e166ba3", #"challengevalue", 5);
		player stats::set_stat(#"hash_162f9b6a10fa7d66", #"sniper_locus_t8", #"hash_b7deb436e166ba3", #"statvalue", 5);
		player stats::set_stat(#"hash_162f9b6a10fa7d66", #"sniper_locus_t8", #"hash_b7deb436e166ba3", #"challengetier", 0);
		player addweaponstat(getweapon(#"sniper_locus_t8"), #"hash_b7deb436e166ba3", 1);
	}
}

/*
	Name: fix_tu6_weapon_for_diamond
	Namespace: challenges
	Checksum: 0x63606CDA
	Offset: 0x8308
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function fix_tu6_weapon_for_diamond(stat_name)
{
	player = self;
	wepaon_for_diamond = player stats::function_222de31d(stat_name);
	if(wepaon_for_diamond == 1)
	{
		secondary_mastery = player stats::function_222de31d("secondary_mastery");
		if(secondary_mastery == 3)
		{
			player force_challenge_stat(stat_name, 2);
		}
		else
		{
			player force_challenge_stat(stat_name, 0);
		}
	}
}

/*
	Name: fix_tu6_ar_garand
	Namespace: challenges
	Checksum: 0x173A4ED2
	Offset: 0x83D8
	Size: 0xCC
	Parameters: 0
	Flags: None
*/
function fix_tu6_ar_garand()
{
	player = self;
	group_weapon_assault = player get_challenge_group_stat("weapon_assault", "challenges");
	weapons_mastery_assault = player stats::function_222de31d("weapons_mastery_assault");
	if(group_weapon_assault >= 49 && weapons_mastery_assault < 1)
	{
		player force_challenge_stat("weapons_mastery_assault", 1);
		player stats::function_dad108fa(#"ar_garand_for_diamond", 1);
	}
}

/*
	Name: fix_tu6_pistol_shotgun
	Namespace: challenges
	Checksum: 0xDF8E2EB1
	Offset: 0x84B0
	Size: 0xCC
	Parameters: 0
	Flags: None
*/
function fix_tu6_pistol_shotgun()
{
	player = self;
	group_weapon_pistol = player get_challenge_group_stat("weapon_pistol", "challenges");
	secondary_mastery_pistol = player stats::function_222de31d("secondary_mastery_pistol");
	if(group_weapon_pistol >= 21 && secondary_mastery_pistol < 1)
	{
		player force_challenge_stat("secondary_mastery_pistol", 1);
		player stats::function_dad108fa(#"pistol_shotgun_for_diamond", 1);
	}
}

/*
	Name: completed_specific_challenge
	Namespace: challenges
	Checksum: 0xAF1A6B34
	Offset: 0x8588
	Size: 0x40
	Parameters: 2
	Flags: Linked
*/
function completed_specific_challenge(target_value, challenge_name)
{
	challenge_count = self stats::function_222de31d(challenge_name);
	return challenge_count >= target_value;
}

/*
	Name: tally_completed_challenge
	Namespace: challenges
	Checksum: 0x147A12A3
	Offset: 0x85D0
	Size: 0x38
	Parameters: 2
	Flags: Linked
*/
function tally_completed_challenge(target_value, challenge_name)
{
	return (self completed_specific_challenge(target_value, challenge_name) ? 1 : 0);
}

/*
	Name: tu7_fix_100_percenter
	Namespace: challenges
	Checksum: 0xF588A504
	Offset: 0x8610
	Size: 0x1C
	Parameters: 0
	Flags: None
*/
function tu7_fix_100_percenter()
{
	self tu7_fix_mastery_perk_2();
}

/*
	Name: tu7_fix_mastery_perk_2
	Namespace: challenges
	Checksum: 0x6CCA6B14
	Offset: 0x8638
	Size: 0x2C4
	Parameters: 0
	Flags: Linked
*/
function tu7_fix_mastery_perk_2()
{
	player = self;
	mastery_perk_2 = player stats::function_222de31d("mastery_perk_2");
	if(mastery_perk_2 >= 12)
	{
		return;
	}
	if(player completed_specific_challenge(200, "earn_scorestreak_anteup") == 0)
	{
		return;
	}
	perk_2_tally = 1;
	perk_2_tally = perk_2_tally + player tally_completed_challenge(100, #"destroy_ai_scorestreak_coldblooded");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(100, #"kills_counteruav_emp_hardline");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(200, #"kill_after_resupply");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(100, #"kills_after_sprint_fasthands");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(200, #"kill_detect_tracker");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(10, #"earn_5_scorestreaks_anteup");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(25, #"kill_scavenger_tracker_resupply");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(25, #"kill_hardwired_coldblooded");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(25, #"kill_anteup_overclock_scorestreak_specialist");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(50, #"kill_fasthands_gungho_sprint");
	perk_2_tally = perk_2_tally + player tally_completed_challenge(50, #"kill_tracker_sixthsense");
	if(mastery_perk_2 < perk_2_tally)
	{
		player stats::function_dad108fa(#"mastery_perk_2", 1);
	}
}

/*
	Name: getbaseweapon
	Namespace: challenges
	Checksum: 0x4703577C
	Offset: 0x8908
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function getbaseweapon(weapon)
{
	rootweapon = weapons::getbaseweapon(weapon);
	baseweapon = getweapon(rootweapon.statname);
	if(level.weaponnone == baseweapon)
	{
		baseweapon = rootweapon;
	}
	return baseweapon.rootweapon;
}

/*
	Name: checkkillstreak5
	Namespace: challenges
	Checksum: 0x10FD53E
	Offset: 0x8990
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function checkkillstreak5(baseweapon, player)
{
	/#
		assert(isdefined(baseweapon));
	#/
	/#
		assert(isdefined(player.weaponkillsthisspawn));
	#/
	if(isdefined(player.weaponkillsthisspawn[baseweapon]))
	{
		player.weaponkillsthisspawn[baseweapon]++;
		if((player.weaponkillsthisspawn[baseweapon] % 5) == 0)
		{
			player stats::function_e24eec31(baseweapon, #"killstreak_5", 1);
		}
	}
	else
	{
		player.weaponkillsthisspawn[baseweapon] = 1;
	}
}

/*
	Name: function_b2b18857
	Namespace: challenges
	Checksum: 0x7F93FC18
	Offset: 0x8A78
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_b2b18857(player)
{
	if(isdefined(player.headshots) && player.headshots > 0)
	{
		if((player.headshots % 5) == 0)
		{
			player stats::function_dad108fa(#"hash_7923fce35e4ba933", 1);
		}
	}
}

/*
	Name: checkdualwield
	Namespace: challenges
	Checksum: 0xFD13F2E9
	Offset: 0x8AF0
	Size: 0x8C
	Parameters: 6
	Flags: Linked
*/
function checkdualwield(baseweapon, player, attacker, time, attackerwassprinting, attacker_sprint_end)
{
	if(attackerwassprinting || (attacker_sprint_end + 1000) > time)
	{
		if(attacker util::has_gung_ho_perk_purchased_and_equipped())
		{
			player stats::function_dad108fa(#"kills_sprinting_dual_wield_and_gung_ho", 1);
		}
	}
}

/*
	Name: challengegameendmp
	Namespace: challenges
	Checksum: 0x8FABA374
	Offset: 0x8B88
	Size: 0x8D2
	Parameters: 1
	Flags: Linked
*/
function challengegameendmp(data)
{
	player = data.player;
	winner = data.winner;
	var_f5d9e583 = data.place;
	if(!isdefined(player))
	{
		return;
	}
	if(endedearly(winner, match::function_5f24faac("tie")))
	{
		return;
	}
	if(level.teambased)
	{
		winnerscore = game.stat[#"teamscores"][winner];
		loserscore = getlosersteamscores(winner);
	}
	var_97e12758 = 1;
	for(index = 0; index < level.placement[#"all"].size; index++)
	{
		if(level.placement[#"all"][index].deaths < player.deaths)
		{
			var_97e12758 = 0;
		}
		if(level.placement[#"all"][index].ekia > player.ekia)
		{
			var_97e12758 = 0;
		}
	}
	if(var_97e12758 && player.ekia > 0 && level.placement[#"all"].size > 3)
	{
		if(level.teambased)
		{
			playeriswinner = player.team === winner;
		}
		else
		{
			playeriswinner = var_f5d9e583 < 3;
		}
		if(playeriswinner)
		{
			player stats::function_dad108fa(#"hash_1ffca5180d4e7b6", 1);
			player contracts::function_a54e2068(#"hash_8f83854f9aa068e");
		}
	}
	if(var_f5d9e583 < 3)
	{
		if(level.hardcoremode)
		{
			player stats::function_dad108fa(#"hash_4551622490fb634f", 1);
		}
		else if(!level.arenamatch)
		{
			player stats::function_dad108fa(#"hash_726639776bb5add", 1);
		}
	}
	switch(level.gametype)
	{
		case "hash_2ad10ed6e94a349c":
		case "tdm":
		{
			if(player.team == winner)
			{
				if(winnerscore >= (loserscore + 25))
				{
					player stats::function_d40764f3(#"crush", 1);
					player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
				}
			}
			break;
		}
		case "dm":
		case "dm_hc":
		{
			if(player == winner)
			{
				if(level.placement[#"all"].size >= 2)
				{
					secondplace = level.placement[#"all"][1];
					if(player.kills >= (secondplace.kills + 7))
					{
						player stats::function_d40764f3(#"crush", 1);
						player stats::function_dad108fa(#"hash_38cf622aaf2ce3d7", 1);
					}
				}
			}
			break;
		}
		case "ctf":
		case "hash_7eee54ba2b077140":
		{
			if(player.team == winner)
			{
				if(loserscore == 0)
				{
					player stats::function_d40764f3(#"shut_out", 1);
				}
			}
			break;
		}
		case "hash_2b1e0466676a9e7d":
		case "dom":
		{
			if(player.team == winner)
			{
				if(winnerscore >= (loserscore + 70))
				{
					player stats::function_d40764f3(#"crush", 1);
					player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
				}
			}
			break;
		}
		case "hq":
		case "hash_3fd30ae55a7e7b6a":
		{
			if(player.team == winner && winnerscore > 0)
			{
				if(winnerscore >= (loserscore + 70))
				{
					player stats::function_d40764f3(#"crush", 1);
				}
			}
			break;
		}
		case "koth":
		case "hash_4d813729d9a4bebd":
		{
			if(player.team == winner && winnerscore > 0)
			{
				if(winnerscore >= (loserscore + 70))
				{
					player stats::function_d40764f3(#"crush", 1);
					player stats::function_dad108fa(#"hash_1b0c06f37648493f", 1);
				}
			}
			if(player.team == winner && winnerscore > 0)
			{
				if(winnerscore >= (loserscore + 110))
				{
					player stats::function_d40764f3(#"annihilation", 1);
				}
			}
			break;
		}
		case "dem":
		case "hash_69f97b66f80cb88b":
		{
			if(player.team == game.defenders && player.team == winner)
			{
				if(loserscore == 0)
				{
					player stats::function_d40764f3(#"shut_out", 1);
				}
			}
			break;
		}
		case "control":
		case "sd":
		case "hash_1acc245ba0adf546":
		case "hash_2f6e1c35e35e3cfe":
		case "bounty":
		case "hash_7a9ce625ed68488a":
		{
			if(player.team == winner)
			{
				if(loserscore == 0)
				{
					player stats::function_d40764f3(#"crush", 1);
					player stats::function_dad108fa(#"hash_644326620d99cbbb", 1);
				}
			}
			break;
		}
		case "conf":
		case "hash_40e7fa1f82c9a9a9":
		{
			if(player.team == winner)
			{
				if(winnerscore >= (loserscore + 25))
				{
					player stats::function_d40764f3(#"crush", 1);
				}
			}
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_ea966b4a
	Namespace: challenges
	Checksum: 0x28FB8BD5
	Offset: 0x9468
	Size: 0x262
	Parameters: 1
	Flags: Linked
*/
function function_ea966b4a(killstreak)
{
	if(!isdefined(killstreak) || !isdefined(self) || !isplayer(self))
	{
		return;
	}
	switch(killstreak)
	{
		case "dart":
		case "remote_missile":
		case "inventory_planemortar":
		case "drone_squadron":
		case "hash_3447a6457d26a42e":
		case "overwatch_helicopter":
		case "inventory_dart":
		case "hash_4307d5aaa7ce21d4":
		case "hash_459c0007ec5e2470":
		case "inventory_remote_missile":
		case "straferun":
		case "ac130":
		case "helicopter_comlink":
		case "planemortar":
		case "hash_74ea4af18853e9af":
		case "inventory_helicopter_comlink":
		{
			self stats::function_dad108fa(#"hash_4b92edc69ea525fc", 1);
			self contracts::player_contract_event(#"hash_4b92edc69ea525fc");
			break;
		}
		case "ultimate_turret":
		case "inventory_ultimate_turret":
		case "tank_robot":
		case "swat_team":
		case "recon_car":
		case "inventory_recon_car":
		case "inventory_tank_robot":
		case "hash_73dc3b42cb4b6869":
		{
			self stats::function_dad108fa(#"hash_10b0c56ae630070d", 1);
			self contracts::player_contract_event(#"hash_10b0c56ae630070d");
			break;
		}
	}
}

/*
	Name: function_2f462ffd
	Namespace: challenges
	Checksum: 0x2930F185
	Offset: 0x96D8
	Size: 0x7F4
	Parameters: 4
	Flags: None
*/
function function_2f462ffd(victim, weapon, inflictor, objective)
{
	if(!isdefined(weapon) || !isdefined(self) || !isplayer(self) || !isdefined(victim) || !isplayer(victim))
	{
		return;
	}
	if(level.teambased)
	{
		if(self.team == victim.team)
		{
			return;
		}
	}
	else if(self == victim)
	{
		return;
	}
	killstreak = killstreaks::get_from_weapon(weapon);
	if(isdefined(killstreak))
	{
		switch(killstreak)
		{
			case "dart":
			case "remote_missile":
			case "inventory_planemortar":
			case "drone_squadron":
			case "hash_3447a6457d26a42e":
			case "overwatch_helicopter":
			case "inventory_dart":
			case "hash_4307d5aaa7ce21d4":
			case "hash_459c0007ec5e2470":
			case "inventory_remote_missile":
			case "straferun":
			case "ac130":
			case "helicopter_comlink":
			case "planemortar":
			case "hash_74ea4af18853e9af":
			case "inventory_helicopter_comlink":
			{
				self stats::function_dad108fa(#"hash_55a5fc51678a4dde", 1);
				break;
			}
			case "recon_car":
			case "inventory_recon_car":
			{
				self stats::function_dad108fa(#"hash_7daf653f5e86b75", 1);
			}
			case "ultimate_turret":
			case "inventory_ultimate_turret":
			case "tank_robot":
			case "swat_team":
			case "inventory_tank_robot":
			case "hash_73dc3b42cb4b6869":
			{
				self stats::function_dad108fa(#"hash_1efa6ab922134e1d", 1);
				break;
			}
		}
	}
	else if(level.hardcoremode)
	{
		self stats::function_dad108fa(#"hash_753f02ea48b19cd", 1);
	}
	else if(!level.arenamatch)
	{
		self stats::function_dad108fa(#"hash_45fca5cee12d8bdb", 1);
	}
	self contracts::player_contract_event(#"objective_ekia");
	scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
	var_8a4cfbd = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
	if(var_8a4cfbd)
	{
		self stats::function_dad108fa(#"hash_d4a989a2da3fa72", 1);
	}
	else if(weapon.var_b76e0a09)
	{
		self stats::function_dad108fa(#"hash_6c3172682467122", 1);
	}
	if(isdefined(weapon.attachments) && weapon.attachments.size > 2)
	{
		if(self weaponhasattachmentandunlocked(weapon, "suppressed", "extbarrel", "damage"))
		{
			if(!isdefined(self.var_953ec9b5))
			{
				self.var_953ec9b5 = [];
			}
			if(!isdefined(self.var_953ec9b5[objective.entnum]))
			{
				self.var_953ec9b5[objective.entnum] = 0;
			}
			self.var_953ec9b5[objective.entnum]++;
			if(self.var_953ec9b5[objective.entnum] == 5)
			{
				self stats::function_dad108fa(#"hash_6f0a5b0f2c1e8ed5", 1);
			}
		}
	}
	if(isdefined(victim.var_ea1458aa))
	{
		var_d72bd991 = victim.var_ea1458aa.attackerdamage[self.clientid];
		gear = self function_b958b70d(var_d72bd991.class_num, "tacticalgear");
		if(gear == #"gear_medicalinjectiongun")
		{
			if(var_d72bd991.var_46a82df0 === 1)
			{
				self stats::function_dad108fa(#"hash_47c5c8af0f105c71", 1);
			}
		}
		else if(gear == #"gear_equipmentcharge")
		{
			if(var_8a4cfbd)
			{
				if(!isdefined(self.var_9cd2c51d.var_17ff6e52))
				{
					self.var_9cd2c51d.var_17ff6e52 = 0;
				}
				self.var_9cd2c51d.var_17ff6e52++;
				if(self.var_9cd2c51d.var_17ff6e52 == 5)
				{
					self stats::function_dad108fa(#"hash_386525eb8f4537c2", 1);
				}
			}
		}
	}
	if(isdefined(victim.lastconcussedby) && victim.lastconcussedby == self && isdefined(victim.var_121392a1))
	{
		if(isdefined(victim.var_121392a1[#"hash_1527a22d8a6fdc21"]) && victim.var_121392a1[#"hash_1527a22d8a6fdc21"].endtime > gettime())
		{
			if(self util::is_item_purchased(#"eq_slow_grenade"))
			{
				self stats::function_dad108fa(#"hash_1a02c128bae3a6a0", 1);
			}
		}
	}
	victimweapon = victim.currentweapon;
	var_2cf35051 = globallogic_score::function_3cbc4c6c(victimweapon.var_2e4a8800);
	if(victimweapon.var_b76e0a09 === 1 || (isdefined(var_2cf35051) && var_2cf35051.var_fcd2ff3a === 1))
	{
		self stats::function_dad108fa(#"hash_2eddb9fd8e3c8c00", 1);
	}
}

/*
	Name: function_82bb78f7
	Namespace: challenges
	Checksum: 0x7592FB
	Offset: 0x9ED8
	Size: 0xFE
	Parameters: 1
	Flags: None
*/
function function_82bb78f7(weapon)
{
	if(!isdefined(self) || !isplayer(self) || !isdefined(weapon) || isdefined(killstreaks::get_from_weapon(weapon)))
	{
		return;
	}
	self activecamo::function_896ac347(weapon, #"vanguard", 1);
	if(isdefined(self.var_aef7ad9) && (self.var_aef7ad9 + (int(5 * 1000))) >= gettime())
	{
		self activecamo::function_896ac347(weapon, #"hash_371b0f2ddd126688", 1);
	}
	self.var_aef7ad9 = gettime();
}

/*
	Name: function_e0f51b6f
	Namespace: challenges
	Checksum: 0xBD238E1B
	Offset: 0x9FE0
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function function_e0f51b6f(weapon)
{
	should_award = 0;
	if(weapon.var_b76e0a09)
	{
		should_award = 1;
	}
	else
	{
		scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
		should_award = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
	}
	if(should_award)
	{
		self stats::function_dad108fa(#"hash_7dfdf288a8fccdb0", 1);
	}
}

/*
	Name: function_57ca42c6
	Namespace: challenges
	Checksum: 0x6DC2AD5F
	Offset: 0xA0A8
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function function_57ca42c6(weapon)
{
	should_award = 0;
	if(weapon.var_b76e0a09)
	{
		should_award = 1;
	}
	else
	{
		scoreevents = globallogic_score::function_3cbc4c6c(weapon.var_2e4a8800);
		should_award = weapon.var_76ce72e8 && isdefined(scoreevents) && scoreevents.var_fcd2ff3a === 1;
	}
	if(should_award)
	{
		self stats::function_dad108fa(#"hash_7ddba69a0de126e5", 1);
	}
}

/*
	Name: killedbaseoffender
	Namespace: challenges
	Checksum: 0x689EC791
	Offset: 0xA170
	Size: 0x4D6
	Parameters: 3
	Flags: None
*/
function killedbaseoffender(objective, weapon, inflictor)
{
	self endon(#"disconnect");
	self stats::function_bb7eedf0(#"defends", 1);
	self.challenge_offenderkillcount++;
	if(isdefined(self.var_ea1458aa) && isdefined(objective))
	{
		if(!isdefined(self.var_ea1458aa.challenge_objectiveoffensive) || !self.var_ea1458aa.challenge_objectiveoffensive === objective)
		{
			self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
		}
		self.var_ea1458aa.challenge_objectiveoffensivekillcount++;
		self.var_ea1458aa.challenge_objectiveoffensive = objective;
		if(self.var_ea1458aa.challenge_objectiveoffensivekillcount > 4)
		{
			self stats::function_dad108fa(#"multikill_5_attackers", 1);
			self.var_ea1458aa.challenge_objectiveoffensivekillcount = 0;
		}
	}
	killstreak = killstreaks::get_from_weapon(weapon);
	if(isdefined(killstreak))
	{
		switch(killstreak)
		{
			case "remote_missile":
			case "inventory_planemortar":
			case "hash_4307d5aaa7ce21d4":
			case "inventory_remote_missile":
			case "straferun":
			case "planemortar":
			{
				self.challenge_offenderprojectilemultikillcount++;
				break;
			}
			case "helicopter_comlink":
			case "inventory_helicopter_comlink":
			{
				self.challenge_offendercomlinkkillcount++;
				break;
			}
			case "combat_robot":
			case "inventory_combat_robot":
			{
				self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
				break;
			}
			case "autoturret":
			case "inventory_autoturret":
			{
				self.challenge_offendersentryturretkillcount++;
				self stats::function_dad108fa(#"kill_attacker_with_robot_or_tank", 1);
				break;
			}
			case "swat_team":
			case "hash_73dc3b42cb4b6869":
			{
				self stats::function_dad108fa(#"hash_103a235d7563069c", 1);
				break;
			}
			case "ultimate_turret":
			case "inventory_ultimate_turret":
			{
				self stats::function_dad108fa(#"hash_103a235d7563069c", 1);
				if(isdefined(inflictor))
				{
					if(!isdefined(inflictor.var_d6489fb6))
					{
						inflictor.var_d6489fb6 = 0;
					}
					inflictor.var_d6489fb6++;
					if(inflictor.var_d6489fb6 == 3)
					{
						self stats::function_dad108fa(#"hash_1379d16cee958f3e", 1);
					}
				}
				break;
			}
		}
	}
	if(self.challenge_offendercomlinkkillcount == 2)
	{
		self stats::function_dad108fa(#"kill_2_attackers_with_comlink", 1);
	}
	if(self.challenge_offendersentryturretkillcount > 2)
	{
		self stats::function_dad108fa(#"multikill_3_attackers_ai_tank", 1);
		self.challenge_offendersentryturretkillcount = 0;
	}
	self contracts::player_contract_event(#"offender_kill");
	self waittilltimeoutordeath(4);
	if(self.challenge_offenderkillcount > 1)
	{
		self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
	}
	self.challenge_offenderkillcount = 0;
	if(self.challenge_offenderprojectilemultikillcount >= 2)
	{
		self stats::function_dad108fa(#"multikill_2_objective_scorestreak_projectile", 1);
	}
	self.challenge_offenderprojectilemultikillcount = 0;
}

/*
	Name: killedbasedefender
	Namespace: challenges
	Checksum: 0xAED728DC
	Offset: 0xA650
	Size: 0x10E
	Parameters: 1
	Flags: None
*/
function killedbasedefender(objective)
{
	self endon(#"disconnect");
	self stats::function_bb7eedf0(#"offends", 1);
	if(!isdefined(self.challenge_objectivedefensive) || self.challenge_objectivedefensive != objective)
	{
		self.challenge_objectivedefensivekillcount = 0;
	}
	self.challenge_objectivedefensivekillcount++;
	self.challenge_objectivedefensive = objective;
	self.challenge_defenderkillcount++;
	self contracts::player_contract_event(#"defender_kill");
	self waittilltimeoutordeath(4);
	if(self.challenge_defenderkillcount > 1)
	{
		self stats::function_dad108fa(#"hash_4b3049ba027dd495", 1);
	}
	self.challenge_defenderkillcount = 0;
}

/*
	Name: waittilltimeoutordeath
	Namespace: challenges
	Checksum: 0x10617A76
	Offset: 0xA768
	Size: 0x26
	Parameters: 1
	Flags: Linked
*/
function waittilltimeoutordeath(timeout)
{
	self endon(#"death");
	wait(timeout);
}

/*
	Name: killstreak_30_noscorestreaks
	Namespace: challenges
	Checksum: 0x4F5B8C26
	Offset: 0xA798
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function killstreak_30_noscorestreaks()
{
	if(level.gametype == "dm" || level.gametype == "dm_hc")
	{
		self stats::function_dad108fa(#"killstreak_30_no_scorestreaks", 1);
	}
}

/*
	Name: heroabilityactivateneardeath
	Namespace: challenges
	Checksum: 0xE1B4378E
	Offset: 0xA800
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function heroabilityactivateneardeath()
{
	if(isdefined(self.heroability))
	{
		switch(self.heroability.name)
		{
			case "gadget_clone":
			case "gadget_vision_pulse":
			case "gadget_heat_wave":
			case "gadget_armor":
			case "gadget_speed_burst":
			case "gadget_camo":
			{
				self thread checkforherosurvival();
				break;
			}
		}
	}
}

/*
	Name: checkforherosurvival
	Namespace: challenges
	Checksum: 0xB699B8C
	Offset: 0xA8B8
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function checkforherosurvival()
{
	self endon(#"death", #"disconnect");
	self waittill_timeout(8, #"challenge_survived_from_death", #"disconnect");
	self stats::function_dad108fa(#"death_dodger", 1);
}

/*
	Name: calledincomlinkchopper
	Namespace: challenges
	Checksum: 0x871D6AA1
	Offset: 0xA938
	Size: 0xE
	Parameters: 0
	Flags: None
*/
function calledincomlinkchopper()
{
	self.challenge_offendercomlinkkillcount = 0;
}

/*
	Name: combat_robot_damage
	Namespace: challenges
	Checksum: 0x6EE1938E
	Offset: 0xA950
	Size: 0x5E
	Parameters: 2
	Flags: None
*/
function combat_robot_damage(eattacker, combatrobotowner)
{
	if(!isdefined(eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid]))
	{
		eattacker.challenge_combatrobotattackclientid[combatrobotowner.clientid] = spawnstruct();
	}
}

/*
	Name: trackkillstreaksupportkills
	Namespace: challenges
	Checksum: 0xFE4F91D7
	Offset: 0xA9B8
	Size: 0x1BC
	Parameters: 1
	Flags: Linked
*/
function trackkillstreaksupportkills(victim)
{
	if(level.activeplayeruavs[self.entnum] > 0 && (!isdefined(level.forceradar) || level.forceradar == 0))
	{
		self stats::function_e24eec31(getweapon(#"uav"), #"kills_while_active", 1);
	}
	if(isdefined(level.activeplayersatellites) && level.activeplayersatellites[self.entnum] > 0)
	{
		self stats::function_e24eec31(getweapon(#"satellite"), #"kills_while_active", 1);
	}
	if(level.activeplayercounteruavs[self.entnum] > 0)
	{
		self stats::function_e24eec31(getweapon(#"counteruav"), #"kills_while_active", 1);
	}
	if(isdefined(victim.lastmicrowavedby) && victim.lastmicrowavedby == self)
	{
		self stats::function_e24eec31(getweapon(#"microwave_turret"), #"kills_while_active", 1);
	}
}

/*
	Name: monitorreloads
	Namespace: challenges
	Checksum: 0x73C0DDA3
	Offset: 0xAB80
	Size: 0xD6
	Parameters: 0
	Flags: Linked
*/
function monitorreloads()
{
	self endon(#"disconnect", #"killmonitorreloads");
	while(true)
	{
		self waittill(#"reload");
		currentweapon = self getcurrentweapon();
		if(currentweapon == level.weaponnone)
		{
			continue;
		}
		time = gettime();
		self.lastreloadtime = time;
		if(isdefined(self.var_ea1458aa))
		{
			self.var_ea1458aa.var_23f5861b = undefined;
		}
		if(weaponhasattachment(currentweapon, "fastreload"))
		{
			self.lastfastreloadtime = time;
		}
	}
}

/*
	Name: monitorgrenadefire
	Namespace: challenges
	Checksum: 0x27C4519E
	Offset: 0xAC60
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function monitorgrenadefire()
{
	self notify(#"grenadetrackingstart");
	self endon(#"grenadetrackingstart", #"disconnect");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"grenade_fire");
		grenade = waitresult.projectile;
		weapon = waitresult.weapon;
		if(!isdefined(grenade))
		{
			continue;
		}
		if(weapon.rootweapon.name == "hatchet")
		{
			self.challenge_hatchettosscount++;
			grenade.challenge_hatchettosscount = self.challenge_hatchettosscount;
		}
		if(self issprinting())
		{
			grenade.ownerwassprinting = 1;
		}
	}
}

/*
	Name: watchweaponchangecomplete
	Namespace: challenges
	Checksum: 0x2E217C71
	Offset: 0xAD70
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function watchweaponchangecomplete()
{
	self endon(#"death", #"disconnect", #"joined_team", #"joined_spectators");
	while(true)
	{
		self.heavyweaponkillsthisactivation = 0;
		self waittill(#"weapon_change_complete", #"disconnect");
	}
}

/*
	Name: longdistancekillmp
	Namespace: challenges
	Checksum: 0xB942A0E9
	Offset: 0xAE00
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function longdistancekillmp(weapon, meansofdeath)
{
	self stats::function_e24eec31(weapon, #"longshot_kill", 1);
	if(isdefined(weapon.attachments) && weapon.attachments.size > 1)
	{
		if(self weaponhasattachmentandunlocked(weapon, "extbarrel", "suppressed"))
		{
			if(self getweaponoptic(weapon) != "")
			{
				self stats::function_dad108fa(#"long_shot_longbarrel_suppressor_optic", 1);
			}
		}
		if(meansofdeath === "MOD_HEAD_SHOT")
		{
			if(self weaponhasattachmentandunlocked(weapon, "damage", "extbarrel"))
			{
				self stats::function_dad108fa(#"hash_52fa8eccf7ee293d", 1);
			}
		}
	}
}

/*
	Name: processspecialistchallenge
	Namespace: challenges
	Checksum: 0x7D7017A4
	Offset: 0xAF48
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function processspecialistchallenge(statname)
{
	self addspecialiststat(statname, 1);
}

/*
	Name: flakjacketprotectedmp
	Namespace: challenges
	Checksum: 0x5F47DD36
	Offset: 0xAF80
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function flakjacketprotectedmp()
{
	self endon(#"death");
	level endon(#"game_ended");
	self notify("5b25fb70ced2b80f");
	self endon("5b25fb70ced2b80f");
	if(!self function_6c32d092(#"talent_flakjacket"))
	{
		return;
	}
	wait(2);
	self stats::function_dad108fa(#"survive_with_flak", 1);
}

/*
	Name: function_7ec2f2c
	Namespace: challenges
	Checksum: 0x9E04CCDC
	Offset: 0xB020
	Size: 0x46
	Parameters: 2
	Flags: Linked, Private
*/
private function function_7ec2f2c(slot_index, killed)
{
	slot = self loadout::function_e27dc453(slot_index);
	slot.killed = killed;
}

/*
	Name: function_861fe993
	Namespace: challenges
	Checksum: 0x8B04BC5B
	Offset: 0xB070
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_861fe993(slot_index)
{
	slot = self loadout::function_e27dc453(slot_index);
	return slot.killed;
}

/*
	Name: function_3ee91387
	Namespace: challenges
	Checksum: 0xA80ABB2E
	Offset: 0xB0B8
	Size: 0x3C
	Parameters: 4
	Flags: Linked
*/
function function_3ee91387(weapon, playercontrolled, groundbased, countaskillstreakvehicle)
{
	self supplypod::function_1e64d41(weapon);
}

/*
	Name: function_19e8b086
	Namespace: challenges
	Checksum: 0x46A86D6A
	Offset: 0xB100
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_19e8b086(killcount, weapon, var_2e4a8800)
{
	self function_780ac329(killcount, weapon, var_2e4a8800);
}

/*
	Name: function_780ac329
	Namespace: challenges
	Checksum: 0x3DF0A358
	Offset: 0xB148
	Size: 0x15C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_780ac329(killcount, weapon, scoreevents)
{
	baseweapon = getweapon(weapon.statname);
	ability = self loadout::function_18a77b37("specialgrenade");
	if(isdefined(ability) && (isdefined(baseweapon.var_b76e0a09) && baseweapon.var_b76e0a09))
	{
		self stats::function_dad108fa(#"hash_41ddd96c4183c46a", 1);
		return;
	}
	equipment = self loadout::function_18a77b37("primarygrenade");
	if(isdefined(equipment) && (isdefined(baseweapon.var_76ce72e8) && baseweapon.var_76ce72e8) && isdefined(scoreevents) && (isdefined(scoreevents.var_fcd2ff3a) && scoreevents.var_fcd2ff3a))
	{
		self stats::function_dad108fa(#"hash_41ddd96c4183c46a", 1);
	}
}

