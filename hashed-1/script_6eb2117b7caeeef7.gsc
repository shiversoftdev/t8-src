// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2c74a7b5eea1ec89;
#using script_47fb62300ac0bd60;
#using script_56d425496a225a1b;
#using script_6c8abe14025b47c4;
#using script_751513c609504a42;
#using script_79a7e1c31a3e8cc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\turret_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;

#namespace ultimate_turret;

/*
	Name: function_89f2df9
	Namespace: ultimate_turret
	Checksum: 0x4FD35E6E
	Offset: 0x220
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("ultimate_turret_wz", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: ultimate_turret
	Checksum: 0x2FDF1DA5
	Offset: 0x260
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_7048dda4 = getweapon("ultimate_turret");
	deployable::function_2e088f73(level.var_7048dda4, undefined, &function_b02e4a26);
	callback::function_955a779c(&function_955a779c);
}

/*
	Name: function_955a779c
	Namespace: ultimate_turret
	Checksum: 0x89A454BC
	Offset: 0x2D8
	Size: 0x124
	Parameters: 1
	Flags: Linked, Private
*/
private function function_955a779c(params)
{
	self endon(#"death", #"disconnect", #"begin_grenade_tracking", #"grenade_throw_cancelled");
	var_d0931295 = function_b02e4a26(self);
	if(!isdefined(params.item) || !isdefined(params.item.var_a6762160) || !isdefined(params.item.var_a6762160.weapon) || params.item.var_a6762160.weapon.name != "ultimate_turret")
	{
		return;
	}
	self thread function_6c288c45(var_d0931295.origin, var_d0931295.angles);
}

/*
	Name: function_6c288c45
	Namespace: ultimate_turret
	Checksum: 0xEDF370D7
	Offset: 0x408
	Size: 0x5F4
	Parameters: 2
	Flags: Linked
*/
function function_6c288c45(spawnorigin, spawnangles)
{
	self endon(#"death", #"disconnect");
	self stats::function_e24eec31(level.var_7048dda4, #"used", 1);
	turretvehicle = spawnvehicle("veh_ultimate_turret_wz", spawnorigin, spawnangles);
	if(!isdefined(turretvehicle))
	{
		return;
	}
	turretvehicle.team = self.team;
	turretvehicle.owner = self;
	if(isdefined(self.var_486ad7a4) && self.var_486ad7a4.owner === self)
	{
		self.var_486ad7a4 function_21f16a35();
	}
	self.var_486ad7a4 = turretvehicle;
	if(isdefined(turretvehicle.scriptbundlesettings))
	{
		turretvehicle.settings = struct::get_script_bundle("vehiclecustomsettings", turretvehicle.scriptbundlesettings);
	}
	if(isdefined(turretvehicle.killstreaksettings))
	{
		level.killstreakbundle[#"ultimate_turret"] = struct::get_script_bundle("killstreak", turretvehicle.killstreaksettings);
	}
	bundle = get_killstreak_bundle();
	/#
		assert(isdefined(bundle));
	#/
	turretvehicle solid();
	turretvehicle.overridevehicledamage = &onturretdamage;
	turretvehicle.overridevehiclekilled = &onturretdeath;
	turretvehicle.allowfriendlyfiredamageoverride = &turretallowfriendlyfiredamage;
	turretvehicle.var_54b19f55 = 1;
	turretvehicle.var_1ee03b04 = [];
	turretvehicle.var_1ee03b04[0] = turretvehicle createturretinfluencer("turret");
	turretvehicle.var_1ee03b04[1] = turretvehicle createturretinfluencer("turret_close");
	turretvehicle.maxhealth = (isdefined(bundle.kshealth) ? bundle.kshealth : turretvehicle.healthdefault);
	turretvehicle.health = turretvehicle.maxhealth;
	turretvehicle.controlled = 0;
	turretvehicle.damagetaken = 0;
	turretvehicle.dontfreeme = 1;
	turretvehicle.damage_on_death = 0;
	turretvehicle.delete_on_death = undefined;
	turretvehicle.use_non_teambased_enemy_selection = 1;
	turretvehicle.waittill_turret_on_target_delay = 0.25;
	turretvehicle.ignore_vehicle_underneath_splash_scalar = 1;
	turretvehicle.killstreak_duration = float((isdefined(bundle.ksduration) ? bundle.ksduration : int(120 * 1000))) / 1000;
	turretvehicle.killstreak_end_time = gettime() + int(turretvehicle.killstreak_duration * 1000);
	turretvehicle turretsetontargettolerance(0, 15);
	turretvehicle.soundmod = "mini_turret";
	turretvehicle.var_63d65a8d = "circle";
	turretvehicle.var_aac73d6c = 1;
	turretvehicle.var_7eb3ebd5 = [];
	turretvehicle.var_4ab08c1d = 1;
	turretvehicle.var_ed35eeb2 = 1;
	turretvehicle vehicle::disconnect_paths(0, 0);
	turretvehicle function_bc7568f1();
	turretvehicle thread function_d4f9ecb(turretvehicle.killstreak_duration);
	turretvehicle.var_54ebfda9 = &function_54ebfda9;
	turretvehicle util::function_c596f193();
	turretvehicle thread turretscanning();
	turretvehicle thread function_fefefcc4();
	turretvehicle turret::set_torso_targetting(0);
	turretvehicle turret::set_target_leading(0);
	turretvehicle thread turret_laser_watch();
	turretvehicle thread setup_death_watch_for_new_targets();
	turretvehicle thread namespace_14c38db0::function_7e1a12ce(bundle.var_2aeadfa0);
	callback::callback(#"hash_6d9bdacc6c29cfa5", {#owner:self, #turret:turretvehicle});
}

/*
	Name: function_b02e4a26
	Namespace: ultimate_turret
	Checksum: 0xC5717257
	Offset: 0xA08
	Size: 0x1A8
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b02e4a26(player)
{
	var_b43e8dc2 = player function_287dcf4b(35, 115, 0, 0, level.var_7048dda4);
	if(!var_b43e8dc2.isvalid)
	{
		player function_bf191832(0, (0, 0, 0), (0, 0, 0));
		return var_b43e8dc2;
	}
	if(function_54267517(var_b43e8dc2.origin))
	{
		var_b43e8dc2.isvalid = 0;
		player function_bf191832(0, (0, 0, 0), (0, 0, 0));
		return var_b43e8dc2;
	}
	if(isdefined(var_b43e8dc2.hitent))
	{
		if(isvehicle(var_b43e8dc2.hitent) || isai(var_b43e8dc2.hitent) || var_b43e8dc2.hitent ismovingplatform())
		{
			var_b43e8dc2.isvalid = 0;
			player function_bf191832(0, (0, 0, 0), (0, 0, 0));
			return var_b43e8dc2;
		}
	}
	player function_bf191832(1, var_b43e8dc2.origin, var_b43e8dc2.angles);
	return var_b43e8dc2;
}

/*
	Name: function_d4f9ecb
	Namespace: ultimate_turret
	Checksum: 0x255B5FB
	Offset: 0xBB8
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_d4f9ecb(duration)
{
	turretvehicle = self;
	turretvehicle endon(#"death", #"delete");
	wait(duration);
	turretvehicle function_21f16a35();
}

/*
	Name: function_1c601b99
	Namespace: ultimate_turret
	Checksum: 0x109B92A
	Offset: 0xC20
	Size: 0x70
	Parameters: 0
	Flags: None
*/
function function_1c601b99()
{
	if(isdefined(level.var_1b900c1d))
	{
		[[level.var_1b900c1d]](level.var_7048dda4, &function_bff5c062);
	}
	if(isdefined(level.var_a5dacbea))
	{
		[[level.var_a5dacbea]](level.var_7048dda4, &function_127fb8f3);
	}
}

/*
	Name: onturretdamage
	Namespace: ultimate_turret
	Checksum: 0x42833144
	Offset: 0xC98
	Size: 0x300
	Parameters: 15
	Flags: Linked
*/
function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	turretvehicle = self;
	empdamage = int(idamage + turretvehicle.maxhealth * 1 + 0.5);
	idamage = turretvehicle killstreaks::ondamageperweapon("ultimate_turret", eattacker, idamage, idflags, smeansofdeath, weapon, turretvehicle.maxhealth, undefined, turretvehicle.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1, 1);
	turretvehicle.damagetaken = turretvehicle.damagetaken + idamage;
	if(isdefined(einflictor) && isvehicle(einflictor) && issentient(einflictor))
	{
		if(is_valid_target(einflictor, turretvehicle.team))
		{
			turretvehicle.favoriteenemy = einflictor;
			turretvehicle.var_c8072bcc = gettime();
			turretvehicle.var_7eb3ebd5[einflictor getentitynumber()] = #"damage";
			turretvehicle namespace_14c38db0::function_a4d6d6d8(einflictor);
		}
	}
	else if(isalive(eattacker) && issentient(eattacker) && (!(isplayer(eattacker) && eattacker isremotecontrolling())) && is_valid_target(eattacker, turretvehicle.team))
	{
		turretvehicle.favoriteenemy = eattacker;
		turretvehicle.var_c8072bcc = gettime();
		turretvehicle.var_7eb3ebd5[eattacker getentitynumber()] = #"damage";
		turretvehicle namespace_14c38db0::function_a4d6d6d8(eattacker);
	}
	return idamage;
}

/*
	Name: onturretdeath
	Namespace: ultimate_turret
	Checksum: 0xCC99D64A
	Offset: 0xFA0
	Size: 0x264
	Parameters: 8
	Flags: Linked
*/
function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	turretvehicle = self;
	if(turretvehicle.dead === 1)
	{
		return;
	}
	turretvehicle notify(#"hash_6f331ac7d2a40217");
	turretvehicle.dead = 1;
	eattacker = turretvehicle [[level.figure_out_attacker]](eattacker);
	if(isdefined(eattacker) && isplayer(eattacker))
	{
		if(isdefined(level.var_bbc796bf) && isdefined(turretvehicle.owner) && turretvehicle.owner != eattacker)
		{
			turretvehicle [[level.var_bbc796bf]](eattacker, weapon);
		}
		if(!isdefined(turretvehicle.owner) || turretvehicle.owner util::isenemyplayer(eattacker))
		{
			eattacker stats::function_dad108fa(#"destroy_turret", 1);
			eattacker stats::function_e24eec31(weapon, #"destroy_turret", 1);
		}
	}
	turretvehicle playsound("mpl_turret_exp");
	if(isdefined(turretvehicle.owner) && isdefined(level.playequipmentdestroyedonplayer))
	{
		turretvehicle.owner [[level.playequipmentdestroyedonplayer]]();
	}
	turretvehicle function_9101e29a();
	callback::callback(#"hash_782232ec47cbd89b", {#owner:turretvehicle.owner, #turret:turretvehicle});
}

/*
	Name: function_54ebfda9
	Namespace: ultimate_turret
	Checksum: 0x117C0DC2
	Offset: 0x1210
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_54ebfda9(params)
{
	turretvehicle = self;
	turretvehicle function_21f16a35();
}

/*
	Name: function_9101e29a
	Namespace: ultimate_turret
	Checksum: 0x6DB13B97
	Offset: 0x1248
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_9101e29a()
{
	turretvehicle = self;
	turretvehicle stoploopsound(0.5);
	turretvehicle vehicle::connect_paths();
	turretvehicle function_3a9dddac();
	turret = turretvehicle.turret;
	waitframe(1);
	if(isdefined(turretvehicle))
	{
		turretvehicle delete();
		waittillframeend();
	}
	if(isdefined(turret))
	{
		turret delete();
	}
}

/*
	Name: get_killstreak_bundle
	Namespace: ultimate_turret
	Checksum: 0x6F3F5FAD
	Offset: 0x1308
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function get_killstreak_bundle()
{
	return level.killstreakbundle[#"ultimate_turret"];
}

/*
	Name: is_valid_target
	Namespace: ultimate_turret
	Checksum: 0xFAD406C9
	Offset: 0x1330
	Size: 0xD6
	Parameters: 2
	Flags: Linked
*/
function is_valid_target(potential_target, var_db0d39fa)
{
	if(isdefined(potential_target))
	{
		if(isplayer(potential_target) && (isdefined(potential_target.laststand) && potential_target.laststand))
		{
			return 0;
		}
		if(issentient(potential_target) && potential_target.var_d600e174 === 1)
		{
			return 0;
		}
		if(!isdefined(potential_target.team) || !util::function_fbce7263(potential_target.team, var_db0d39fa))
		{
			return 0;
		}
		return 1;
	}
	return 0;
}

/*
	Name: function_fefefcc4
	Namespace: ultimate_turret
	Checksum: 0x67CA67C7
	Offset: 0x1410
	Size: 0x348
	Parameters: 0
	Flags: Linked
*/
function function_fefefcc4()
{
	turretvehicle = self;
	turret_index = 0;
	turretvehicle endon(#"death", #"hash_6f331ac7d2a40217", #"end_turret_scanning");
	wait(0.8);
	bundle = get_killstreak_bundle();
	var_beeadda8 = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300);
	while(true)
	{
		if(!isdefined(turretvehicle.enemy) && (!(isdefined(turretvehicle.isstunned) && turretvehicle.isstunned)) && (!(isdefined(turretvehicle.isjammed) && turretvehicle.isjammed)))
		{
			/#
				var_beeadda8 = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300);
			#/
			var_c9b6d0a7 = getplayers(util::getotherteam(turretvehicle.team), turretvehicle.origin, var_beeadda8);
			if(var_c9b6d0a7.size > 0)
			{
				if(turretvehicle.var_3413afc5 != #"hash_2d94a5f22d36fc73")
				{
					turretvehicle function_c524c4c8();
				}
				else
				{
					foreach(nearby_enemy in var_c9b6d0a7)
					{
						if(turretvehicle cansee(nearby_enemy) == 0)
						{
							continue;
						}
						if(turretvehicle namespace_14c38db0::function_1c169b3a(nearby_enemy) == 0)
						{
							continue;
						}
						if(turretvehicle function_9d86d74c(nearby_enemy))
						{
							continue;
						}
						turretvehicle.favoriteenemy = nearby_enemy;
						turretvehicle.var_c8072bcc = gettime();
						turretvehicle.var_7eb3ebd5[nearby_enemy getentitynumber()] = #"hash_47697c94ffb4a5bd";
						break;
					}
				}
			}
			else if(turretvehicle.var_3413afc5 != #"hash_3cf9b05c0d2cb80e")
			{
				turretvehicle function_bc7568f1();
			}
		}
		wait_time = (turretvehicle.var_3413afc5 == #"hash_3cf9b05c0d2cb80e" ? 0.25 : 0.1);
		wait(wait_time);
	}
}

/*
	Name: function_9d86d74c
	Namespace: ultimate_turret
	Checksum: 0x7386EC8
	Offset: 0x1760
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_9d86d74c(enemy)
{
	fire_origin = self getseatfiringorigin(0);
	fire_angles = self getseatfiringangles(0);
	shoot_at_pos = enemy getshootatpos(self);
	var_6551f24e = anglestoforward(fire_angles);
	target_offset = shoot_at_pos - fire_origin;
	if(lengthsquared(target_offset) < 22 * 22 && vectordot(var_6551f24e, target_offset) < 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_2034705c
	Namespace: ultimate_turret
	Checksum: 0x9B5A9584
	Offset: 0x1870
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_2034705c(bundle)
{
	var_351b3c55 = (isdefined(self.enemy) ? 0 : max((isdefined(self.enemylastseentime) ? self.enemylastseentime : 0), (isdefined(self.var_c8072bcc) ? self.var_c8072bcc : 0)));
	var_c112caa0 = int((isdefined(bundle.var_fa38350a) ? bundle.var_fa38350a : 1) * 1000);
	if(isdefined(self.enemy) && self.var_7eb3ebd5[self.enemy getentitynumber()] === #"damage")
	{
		var_c112caa0 = int((isdefined(bundle.var_33561c46) ? bundle.var_33561c46 : 3) * 1000);
	}
	return gettime() < var_351b3c55 + var_c112caa0;
}

/*
	Name: function_fc58f46f
	Namespace: ultimate_turret
	Checksum: 0x1C1A2D87
	Offset: 0x19D0
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_fc58f46f()
{
	turretvehicle = self;
	if(!isdefined(turretvehicle))
	{
		return;
	}
	if(isdefined(turretvehicle.enemy))
	{
		turretvehicle.var_c8072bcc = undefined;
		turretvehicle.var_7eb3ebd5[turretvehicle.enemy getentitynumber()] = undefined;
	}
	turretvehicle clearenemy();
	turretvehicle.favoriteenemy = undefined;
	turretvehicle.turret_target = undefined;
}

/*
	Name: function_4bbdb418
	Namespace: ultimate_turret
	Checksum: 0xDE4E2E04
	Offset: 0x1A68
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function function_4bbdb418(target)
{
	var_8134d046 = -12;
	stance = target getstance();
	if(stance == "prone")
	{
		var_8134d046 = -2;
	}
	return (0, 0, var_8134d046);
}

/*
	Name: turretscanning
	Namespace: ultimate_turret
	Checksum: 0x6A443FF3
	Offset: 0x1AD8
	Size: 0xE74
	Parameters: 0
	Flags: Linked
*/
function turretscanning()
{
	turretvehicle = self;
	turretvehicle endon(#"death", #"hash_6f331ac7d2a40217", #"end_turret_scanning");
	turretvehicle.turret_target = undefined;
	turretvehicle.do_not_clear_targets_during_think = 1;
	wait(0.8);
	turretvehicle playsound(#"mpl_turret_startup");
	turretvehicle playloopsound(#"hash_69240c6db92da5bf");
	bundle = get_killstreak_bundle();
	min_burst_time = bundle.ksburstfiremintime;
	max_burst_time = bundle.ksburstfiremaxtime;
	min_pause_time = bundle.ksburstfiredelaymintime;
	max_pause_time = bundle.ksburstfiredelaymaxtime;
	burst_fire_enabled = bundle.ksburstfireenabled;
	loc_00001C98:
	turretvehicle.maxsightdistsqrd = (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
	loc_00001CEC:
	turretvehicle.var_e812cbe7 = (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
	loc_00001D40:
	turretvehicle.var_38e6355c = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);
	while(isdefined(turretvehicle))
	{
		/#
			loc_00001DA0:
			turretvehicle.maxsightdistsqrd = (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isdefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
			loc_00001DF4:
			turretvehicle.var_e812cbe7 = (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isdefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
			loc_00001E48:
			turretvehicle.var_38e6355c = (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isdefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);
		#/
		if(isdefined(turretvehicle.isstunned) && turretvehicle.isstunned || (isdefined(turretvehicle.isjammed) && turretvehicle.isjammed))
		{
			turretvehicle function_fc58f46f();
			wait(0.5);
			continue;
		}
		if(isdefined(turretvehicle.enemy))
		{
			if(!is_valid_target(turretvehicle.enemy, turretvehicle.team))
			{
				turretvehicle setignoreent(turretvehicle.enemy, 1);
				turretvehicle function_fc58f46f();
				wait(0.1);
				continue;
			}
			var_2aa33bf1 = 0;
			if(distancesquared(turretvehicle.enemy.origin, turretvehicle.origin) > turretvehicle.var_38e6355c && turretvehicle.var_7eb3ebd5[turretvehicle.enemy getentitynumber()] === #"hash_704614cf51e8952f")
			{
				var_2aa33bf1 = 1;
			}
			else if(turretvehicle function_9d86d74c(turretvehicle.enemy))
			{
				var_2aa33bf1 = 1;
			}
			if(var_2aa33bf1)
			{
				turretvehicle setpersonalignore(turretvehicle.enemy, 1);
				turretvehicle function_fc58f46f();
				wait(0.1);
				continue;
			}
			if(!isdefined(turretvehicle.var_7eb3ebd5[turretvehicle.enemy getentitynumber()]) && turretvehicle namespace_14c38db0::function_1c169b3a(turretvehicle.enemy))
			{
				turretvehicle.var_c8072bcc = gettime();
				turretvehicle.var_7eb3ebd5[turretvehicle.enemy getentitynumber()] = #"hash_704614cf51e8952f";
			}
		}
		if(turretvehicle has_active_enemy(bundle) && isdefined(turretvehicle.enemy) && isalive(turretvehicle.enemy))
		{
			turretvehicle.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);
			if(!isdefined(turretvehicle.turret_target) || turretvehicle.turret_target != turretvehicle.enemy)
			{
				turretvehicle.turret_target = turretvehicle.enemy;
				if(!isdefined(turretvehicle.var_2b8e6720) || turretvehicle.var_2b8e6720 + 5000 < gettime())
				{
					turretvehicle playsoundtoteam("mpl_ultimate_turret_lockon", turretvehicle.team);
					turretvehicle playsoundtoteam("mpl_ultimate_turret_lockon_enemy", util::getotherteam(turretvehicle.team));
					turretvehicle.var_2b8e6720 = gettime();
				}
				turretvehicle thread function_b8952a40(0);
			}
			if(turretvehicle.turretontarget && turretvehicle function_2034705c(bundle) && turretvehicle cansee(turretvehicle.enemy))
			{
				if(burst_fire_enabled)
				{
					fire_time = (min_burst_time < max_burst_time ? randomfloatrange(min_burst_time, max_burst_time) : min_burst_time);
					var_fc9f290e = turretvehicle.enemy;
					turretvehicle vehicle_ai::fire_for_time(fire_time, 0, turretvehicle.enemy);
					var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
					if(min_pause_time > 0 && !var_afae28e0)
					{
						pause_time = (min_pause_time < max_pause_time ? randomfloatrange(min_pause_time, max_pause_time) : min_pause_time);
						waitresult = undefined;
						waitresult = turretvehicle.turret_target waittill_timeout(pause_time, #"death", #"disconnect");
						var_afae28e0 = waitresult._notify === "death";
					}
				}
				else
				{
					var_fc9f290e = turretvehicle.enemy;
					turretvehicle vehicle_ai::fire_for_rounds(10, 0, turretvehicle.enemy);
					var_afae28e0 = !isdefined(var_fc9f290e) || !isalive(var_fc9f290e);
				}
				if(var_afae28e0 && isdefined(turretvehicle.turret_target) && isdefined(turretvehicle.turret_target.var_e78602fc) && turretvehicle.turret_target.var_e78602fc == turretvehicle)
				{
					if(isdefined(turretvehicle.owner))
					{
						turretvehicle.owner luinotifyevent(#"mini_turret_kill");
						turretvehicle.owner playsoundtoplayer(#"hash_7ea486136cd776c", turretvehicle.owner);
					}
					turretvehicle.turretrotscale = 1;
					wait(randomfloatrange(0.05, 0.2));
				}
			}
			else
			{
				wait(0.25);
			}
			continue;
		}
		var_4ec572ee = isdefined(turretvehicle.turret_target);
		var_bb861d93 = 0;
		if(var_4ec572ee && issentient(turretvehicle.turret_target))
		{
			var_bb861d93 = isalive(turretvehicle.turret_target);
			turretvehicle setpersonalignore(turretvehicle.turret_target, 1.5);
		}
		turretvehicle function_fc58f46f();
		turretvehicle.turretrotscale = 1;
		if(var_4ec572ee && var_bb861d93)
		{
			turretvehicle playsoundtoteam("mpl_turret_lost", turretvehicle.team);
			turretvehicle playsoundtoteam("mpl_turret_lost_enemy", util::getotherteam(turretvehicle.team));
		}
		if(turretvehicle.var_63d65a8d == "arc")
		{
			if(turretvehicle.scanpos === "left")
			{
				turretvehicle turretsettargetangles(0, (-10, 40, 0));
				turretvehicle.scanpos = "right";
			}
			else
			{
				turretvehicle turretsettargetangles(0, (-10, -40, 0));
				turretvehicle.scanpos = "left";
			}
		}
		else if(turretvehicle.scanpos === "left")
		{
			turretvehicle turretsettargetangles(0, (-10, 180, 0));
			turretvehicle.scanpos = "left2";
		}
		else if(turretvehicle.scanpos === "left2")
		{
			turretvehicle turretsettargetangles(0, (-10, 360, 0));
			turretvehicle.scanpos = "right";
		}
		else if(turretvehicle.scanpos === "right")
		{
			turretvehicle turretsettargetangles(0, (-10, -180, 0));
			turretvehicle.scanpos = "right2";
		}
		else
		{
			turretvehicle turretsettargetangles(0, (-10, -360, 0));
			turretvehicle.scanpos = "left";
		}
		waitresult = undefined;
		waitresult = turretvehicle waittill_timeout(3.5, #"enemy");
		if(waitresult._notify == #"enemy" && isdefined(turretvehicle.enemy))
		{
			if(turretvehicle.var_aac73d6c && !isdefined(turretvehicle.enemylastseentime))
			{
				attempts = 0;
				max_tries = 10;
				while(attempts < max_tries && !isdefined(turretvehicle.enemylastseentime) && isdefined(turretvehicle.enemy))
				{
					turretvehicle getperfectinfo(self.enemy, 0);
					attempts++;
					wait(0.1);
				}
			}
		}
	}
}

/*
	Name: turretallowfriendlyfiredamage
	Namespace: ultimate_turret
	Checksum: 0x263AA743
	Offset: 0x2958
	Size: 0x3A
	Parameters: 4
	Flags: Linked
*/
function turretallowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon)
{
	return !(isdefined(self.var_54b19f55) && self.var_54b19f55);
}

