// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_135d37089bbde4f2;
#using script_18fb8ad2a13d96b;
#using script_2255a7ad3edc838f;
#using script_2c49ae69cd8ce30c;
#using script_2ca4b414b146b498;
#using script_2e694c219a22fb65;
#using script_3819e7a1427df6d2;
#using script_3fda550bc6e1089a;
#using script_490759cf62a1abc8;
#using script_61826ca279ffa0;
#using script_6c8abe14025b47c4;
#using script_788472602edbe3b9;
#using script_7aca7971e9ec6712;
#using script_bb99a1f9be8d0a7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\potm_shared.gsc;
#using scripts\core_common\spawning_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;
#using scripts\core_common\vehicle_death_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\mp_common\gametypes\globallogic_spawn.gsc;

#namespace namespace_a5493032;

/*
	Name: main
	Namespace: namespace_a5493032
	Checksum: 0x86210DF8
	Offset: 0x338
	Size: 0x27C
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	namespace_13777bae::function_46e95cc7();
	level.select_character = namespace_73e1c3e3::function_d153452e(#"hash_6294aa09f1128925");
	level.var_820c5561 = "BATTERY";
	namespace_73e1c3e3::function_be3a76b7(level.var_820c5561);
	level.var_d6d98fbe = 1;
	level.var_5e97302a = 0;
	namespace_13777bae::function_fa03fc55();
	level.var_4c2ecc6f = &function_6db6572b;
	level.var_c01b7f8b = &function_ba542258;
	level.var_49240db3 = &function_b89106ad;
	level.var_8b9d690e = &function_cf3224fe;
	level.onspawnplayer = &function_7c4ef26b;
	player::function_cf3aa03d(&function_9d65db70);
	level.var_cdb8ae2c = &namespace_73e1c3e3::function_a8da260c;
	level.resurrect_override_spawn = &namespace_73e1c3e3::function_78469779;
	level.var_e31c5d7a = &namespace_64a487a9::function_e31c5d7a;
	callback::function_98a0917d(&namespace_13777bae::function_1e84c767);
	globallogic_spawn::addsupportedspawnpointtype("ct");
	level flag::init("combat_training_started");
	namespace_73e1c3e3::function_6046a5e3(#"ar_damage_t8", array(#"ar_damage_t8", "holo", "damage", "damage2"));
	namespace_73e1c3e3::function_c3e647e2(#"pistol_standard_t8");
	if(level.var_cd9d597c == 0)
	{
		level namespace_58d68fd0::init();
	}
}

/*
	Name: function_7c4ef26b
	Namespace: namespace_a5493032
	Checksum: 0xBC2ECD94
	Offset: 0x5C0
	Size: 0x194
	Parameters: 1
	Flags: None
*/
function function_7c4ef26b(predictedspawn)
{
	if(level.var_cd9d597c == 0)
	{
		self namespace_58d68fd0::function_c9ff0dce();
		return;
	}
	setdvar(#"custom_killstreak_mode", 2);
	setdvar(#"hash_26de0c20bc979e24", level.killstreakindices[#"uav"]);
	setdvar(#"hash_26de0f20bc97a33d", level.killstreakindices[#"satellite"]);
	setdvar(#"hash_26de0e20bc97a18a", level.killstreakindices[#"remote_missile"]);
	self thread namespace_13777bae::function_d2845186();
	spawning::onspawnplayer(predictedspawn);
	if(isbot(self))
	{
		if(isdefined(level.var_e31c5d7a))
		{
			self [[level.var_e31c5d7a]]();
		}
	}
	else
	{
		self.var_7f8ce835 = 0;
		self thread function_7dbf5593();
	}
}

/*
	Name: function_9d65db70
	Namespace: namespace_a5493032
	Checksum: 0x5BEC08AB
	Offset: 0x760
	Size: 0x2A4
	Parameters: 9
	Flags: None
*/
function function_9d65db70(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration)
{
	if(level.var_cd9d597c == 0)
	{
		self namespace_58d68fd0::function_72ba0df6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration);
		return;
	}
	if(self.team == #"allies")
	{
		self namespace_73e1c3e3::function_ee4639dd(-5, 1);
		self notify(#"hash_789b40a7845c0591");
		self.var_6b6241ac = self.last_valid_position;
		self.var_45cac770 = self.angles;
	}
	else if(level flag::exists("combat_training_started") && level flag::get("combat_training_started") && self.team == #"axis" && (isdefined(level.var_902e7351) && level.var_902e7351))
	{
		self namespace_64a487a9::function_43df30a8();
		e_player = namespace_73e1c3e3::get_player();
		if(isdefined(level.ct_shared_objcounter.n_count))
		{
			e_player namespace_73e1c3e3::function_785eb2ca();
		}
		e_player thread function_e12a129(self.origin);
		level thread namespace_73e1c3e3::function_bfa522d1();
		if(weapon === getweapon(#"hero_pineapplegun") || weapon === getweapon(#"hero_pineapple_grenade"))
		{
			e_player namespace_73e1c3e3::function_d471f8fa(5, undefined, 1);
		}
		else
		{
			e_player namespace_73e1c3e3::function_d471f8fa(2);
		}
	}
}

/*
	Name: function_6db6572b
	Namespace: namespace_a5493032
	Checksum: 0xE945FC2F
	Offset: 0xA10
	Size: 0x94
	Parameters: 0
	Flags: None
*/
function function_6db6572b()
{
	level.callbackvehiclekilled = &function_4293d37b;
	level.var_d2193160 = util::spawn_model("tag_origin");
	level.var_f3c95b8b = getnodearray("nd_enemy_bot", "targetname");
	level thread namespace_73e1c3e3::function_6b71f442();
	/#
		level thread function_868cd9ac();
	#/
}

/*
	Name: function_ba542258
	Namespace: namespace_a5493032
	Checksum: 0x6A6763AC
	Offset: 0xAB0
	Size: 0xC2
	Parameters: 1
	Flags: None
*/
function function_ba542258(mode)
{
	if(isdefined(level.var_1ecfe3a2))
	{
		self.var_71a70093 = level.var_1ecfe3a2;
	}
	self thread namespace_d82263d5::function_19181566();
	self loadout::function_cdb86a18();
	var_27875ecd = 180000;
	self thread function_9270ab93(0, var_27875ecd);
	level.var_9468071 = [];
	level.var_9468071[#"hash_4d612f606300433a"] = 0;
	level.var_902e7351 = 1;
}

/*
	Name: function_9270ab93
	Namespace: namespace_a5493032
	Checksum: 0x627E85F3
	Offset: 0xB80
	Size: 0x21C
	Parameters: 2
	Flags: None
*/
function function_9270ab93(var_db89c655, var_27875ecd)
{
	var_e7cc5e43 = [];
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][1] = 60000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][2] = 52000;
	var_e7cc5e43[#"hash_6b9fd25bcf5649cb"][3] = 45000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][1] = 60000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][2] = 52000;
	var_e7cc5e43[#"hash_28913deffdfcddf"][3] = 45000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][1] = 60000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][2] = 52000;
	var_e7cc5e43[#"hash_31d29891e0259e47"][3] = 45000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][1] = 60000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][2] = 52000;
	var_e7cc5e43[#"hash_6ccddb822640b098"][3] = 45000;
	var_b1cb18f1 = hash(getrootmapname());
	namespace_73e1c3e3::function_7a21ac57(0, var_27875ecd, var_e7cc5e43[var_b1cb18f1][1], var_e7cc5e43[var_b1cb18f1][2], var_e7cc5e43[var_b1cb18f1][3]);
}

/*
	Name: function_b89106ad
	Namespace: namespace_a5493032
	Checksum: 0x307A130E
	Offset: 0xDA8
	Size: 0xD8
	Parameters: 1
	Flags: None
*/
function function_b89106ad(gamedifficulty)
{
	level endon(#"combattraining_logic_finished");
	level notify(#"hash_2a473e02881ca991");
	level.usingscorestreaks = 0;
	level.var_64ce2685 = 1;
	level.disablemomentum = 1;
	level.var_ebad4ea8 = gettime();
	if(gamedifficulty == 0)
	{
		namespace_58d68fd0::function_9b9525e9();
	}
	else
	{
		function_72e84e64();
	}
	level notify(#"combattraining_logic_finished", {#success:1});
}

/*
	Name: function_9e8fddfe
	Namespace: namespace_a5493032
	Checksum: 0xA17C8377
	Offset: 0xE88
	Size: 0x14C
	Parameters: 0
	Flags: None
*/
function function_9e8fddfe()
{
	level.var_11f15cb8 = [];
	var_4b9c0862 = struct::get_array("s_vh_enemy", "targetname");
	foreach(var_7c73ae03 in var_4b9c0862)
	{
		vh_enemy = function_4b892700(var_7c73ae03);
		vh_enemy clientfield::set("enemy_vehicle_keyline_render", 1);
		level.var_11f15cb8[level.var_11f15cb8.size] = vh_enemy;
	}
	e_player = namespace_73e1c3e3::get_player();
	e_player namespace_73e1c3e3::function_68e9fa9e(#"hash_1b6372a0a5dc0fef", 0, level.var_11f15cb8.size, 1, 1);
}

/*
	Name: function_22c41fdd
	Namespace: namespace_a5493032
	Checksum: 0xD21AFD59
	Offset: 0xFE0
	Size: 0x268
	Parameters: 4
	Flags: None
*/
function function_22c41fdd(n_count, var_2c6e8cfe = 0, var_edf46d6e, var_1b783b8b = 0)
{
	var_d3dc6155 = [];
	var_c580022d = [];
	var_4ea36929[0] = "ct_attack_helicopter";
	var_4ea36929[1] = "ct_mini_quadtank";
	var_a6335767 = struct::get_array(var_4ea36929[var_2c6e8cfe], "script_noteworthy");
	if(n_count > var_a6335767.size)
	{
		var_4f9e00cf = var_a6335767.size;
	}
	else
	{
		var_4f9e00cf = n_count;
	}
	for(i = 0; i < var_4f9e00cf; i++)
	{
		switch(var_1b783b8b)
		{
			case 0:
			{
				var_4879ffaf = arraygetfarthest(self.origin, var_a6335767);
				break;
			}
			case 1:
			{
				var_4879ffaf = arraygetclosest(self.origin, var_a6335767);
				break;
			}
			case 2:
			{
				var_4879ffaf = array::random(var_a6335767);
				break;
			}
		}
		if(var_2c6e8cfe == 0)
		{
			var_d3dc6155[var_d3dc6155.size] = var_4879ffaf function_4bae19cf("enemy_chopper", #"axis", 1, 1, var_edf46d6e);
		}
		else if(var_2c6e8cfe == 1)
		{
			var_d3dc6155[var_d3dc6155.size] = var_4879ffaf function_4c8f915a("enemy_mini_quad_tank", #"axis");
		}
		arrayremovevalue(var_a6335767, var_4879ffaf);
		waitframe(1);
	}
	return var_d3dc6155;
}

/*
	Name: function_4b892700
	Namespace: namespace_a5493032
	Checksum: 0x9F12BD01
	Offset: 0x1250
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function function_4b892700(var_b5c142f0)
{
	switch(var_b5c142f0.script_noteworthy)
	{
		case "ct_mini_quadtank":
		{
			return var_b5c142f0 function_4c8f915a("enemy_mini_quadtank", #"axis");
			break;
		}
		case "ct_attack_helicopter":
		{
			return var_b5c142f0 function_4bae19cf("enemy_attack_chopper", #"axis");
			break;
		}
	}
}

/*
	Name: function_4bae19cf
	Namespace: namespace_a5493032
	Checksum: 0x5002EDCA
	Offset: 0x1300
	Size: 0x608
	Parameters: 5
	Flags: None
*/
function function_4bae19cf(str_targetname, str_team, var_be674792 = 1, b_missiles = 1, var_edf46d6e = [])
{
	chopper = spawnvehicle(#"veh_t8_helicopter_gunship_mp", self.origin, self.angles, str_targetname);
	if(!isdefined(var_edf46d6e[#"hash_340f1ead2b66b1e5"]))
	{
		var_edf46d6e[#"hash_340f1ead2b66b1e5"] = 1200;
	}
	if(!isdefined(var_edf46d6e[#"attack_time"]))
	{
		var_edf46d6e[#"attack_time"] = 5;
	}
	if(!isdefined(var_edf46d6e[#"hash_5ff2a429aff04484"]))
	{
		var_edf46d6e[#"hash_5ff2a429aff04484"] = 3;
	}
	if(!isdefined(var_edf46d6e[#"hash_567524f34ee44d06"]))
	{
		var_edf46d6e[#"hash_567524f34ee44d06"] = 25;
	}
	if(!isdefined(var_edf46d6e[#"speed"]))
	{
		var_edf46d6e[#"speed"] = 30;
	}
	if(!isdefined(var_edf46d6e[#"accel"]))
	{
		var_edf46d6e[#"accel"] = 10;
	}
	chopper.var_6982e1d6 = var_edf46d6e[#"hash_340f1ead2b66b1e5"];
	chopper.var_9d8645cf = var_edf46d6e[#"attack_time"];
	chopper.var_847fac28 = var_edf46d6e[#"hash_5ff2a429aff04484"];
	chopper.var_a2a6e327 = var_edf46d6e[#"hash_567524f34ee44d06"];
	chopper.n_speed = var_edf46d6e[#"speed"];
	chopper.n_accel = var_edf46d6e[#"accel"];
	chopper setteam(str_team);
	chopper.originalteam = str_team;
	chopper.attackers = [];
	chopper.attackerdata = [];
	chopper.attackerdamage = [];
	chopper.flareattackerdamage = [];
	chopper.destroyfunc = &function_64dd0b39;
	chopper.hardpointtype = "attack_helicopter";
	chopper.killstreak_id = -1;
	chopper.lastrocketfiretime = -1;
	chopper.missile_ammo = 100;
	chopper.pilotistalking = 0;
	chopper setdrawinfrared(1);
	chopper.allowcontinuedlockonafterinvis = 1;
	chopper.soundmod = "heli";
	target_offset = vectorscale((0, 0, 1), 100);
	chopper.target_offset = target_offset;
	target_set(chopper, target_offset);
	minigun_snd_ent = spawn("script_origin", chopper gettagorigin("tag_flash"));
	minigun_snd_ent linkto(chopper, "tag_flash", (0, 0, 0), (0, 0, 0));
	chopper.minigun_snd_ent = minigun_snd_ent;
	minigun_snd_ent thread helicopter::autostopsound();
	self.damagetaken = 0;
	aiutility::addaioverridedamagecallback(chopper, &function_4e049216);
	if(randomint(100) > 50)
	{
		chopper.crashtype = "spinOut";
	}
	else
	{
		chopper.crashtype = "crashOnPath";
	}
	chopper.maxhealth = level.heli_amored_maxhealth;
	chopper thread helicopter::heli_health(chopper.hardpointtype);
	e_player = namespace_73e1c3e3::get_player();
	chopper.primarytarget = e_player;
	chopper.secondarytarget = e_player;
	chopper.defaultweapon = getweapon(#"cobra_20mm_comlink");
	if(var_be674792)
	{
		chopper thread function_62449dad();
	}
	chopper thread helicopter::heli_missile_regen();
	level.heli_loopmax = 10000;
	chopper.loopcount = 0;
	chopper.str_path_start = self.target;
	chopper function_5d585945(chopper.hardpointtype);
	return chopper;
}

/*
	Name: function_62449dad
	Namespace: namespace_a5493032
	Checksum: 0x75E5C2E6
	Offset: 0x1910
	Size: 0x548
	Parameters: 0
	Flags: None
*/
function function_62449dad()
{
	self endon(#"death", #"crashing", #"leaving");
	level endon(#"game_ended");
	var_df0dfc2d = self.var_6982e1d6 * self.var_6982e1d6;
	while(true)
	{
		if(isdefined(self.primarytarget))
		{
			self.primarytarget.antithreat = undefined;
			self.turrettarget = self.primarytarget;
			antithreat = 0;
			while(isdefined(self.turrettarget) && isalive(self.turrettarget))
			{
				if(distance2dsquared(self.turrettarget.origin, self.origin) <= var_df0dfc2d)
				{
					self vehlookat(self.turrettarget);
				}
				while(isdefined(self.turrettarget) && isalive(self.turrettarget) && self helicopter::turret_target_check(self.turrettarget, helicopterturretmaxangle) == 0)
				{
					wait(0.1);
				}
				if(!isdefined(self.turrettarget) || !isalive(self.turrettarget))
				{
					break;
				}
				v_offset = function_17786807();
				self turretsettarget(0, self.turrettarget, v_offset);
				self setvehweapon(self.defaultweapon);
				self waittill(#"turret_on_target");
				self notify(#"turret_on_target");
				wait(1);
				wait(level.heli_turret_spinup_delay);
				weaponshoottime = self.defaultweapon.firetime;
				self setvehweapon(self.defaultweapon);
				for(i = 0; i < level.heli_turretclipsize; i++)
				{
					v_offset = function_17786807();
					if(isdefined(self.turrettarget) && isdefined(self.primarytarget))
					{
						if(self.primarytarget != self.turrettarget)
						{
							self turretsettarget(0, self.primarytarget, v_offset);
						}
					}
					var_ff52e201 = self namespace_73e1c3e3::is_facing(self.primarytarget, 0.6, 1);
					if(gettime() != self.lastrocketfiretime && (isdefined(var_ff52e201) && var_ff52e201))
					{
						self setvehweapon(self.defaultweapon);
						if(isdefined(self.primarytarget))
						{
							self turretsettarget(0, self.primarytarget, v_offset);
							minigun = self fireweapon(0, self.primarytarget);
						}
						else
						{
							minigun = self fireweapon();
						}
					}
					if(i < level.heli_turretclipsize - 1)
					{
						wait(weaponshoottime);
					}
				}
				self notify(#"hash_1c98ddac8879f7bc", self.pilotistalking);
				wait(level.heli_turretreloadtime);
				if(isdefined(self.turrettarget) && isalive(self.turrettarget))
				{
					antithreat = antithreat + 100;
					self.turrettarget.antithreat = antithreat;
				}
				if(!isdefined(self.primarytarget) || (isdefined(self.turrettarget) && isdefined(self.primarytarget) && self.primarytarget != self.turrettarget))
				{
					break;
				}
			}
			if(isdefined(self.turrettarget))
			{
				self.turrettarget.antithreat = undefined;
			}
		}
		self function_d9adace1();
		wait(self.var_847fac28);
	}
}

/*
	Name: function_d9adace1
	Namespace: namespace_a5493032
	Checksum: 0x404E3B86
	Offset: 0x1E60
	Size: 0x1A
	Parameters: 0
	Flags: None
*/
function function_d9adace1()
{
	self.primarytarget = namespace_73e1c3e3::get_player();
}

/*
	Name: function_17786807
	Namespace: namespace_a5493032
	Checksum: 0xC9D3ED74
	Offset: 0x1E88
	Size: 0x74
	Parameters: 0
	Flags: None
*/
function function_17786807()
{
	n_spread = self.var_a2a6e327;
	return (randomfloatrange(n_spread * -1, n_spread), randomfloatrange(n_spread * -1, n_spread), randomfloatrange(n_spread * -1, n_spread));
}

/*
	Name: function_303fcbd8
	Namespace: namespace_a5493032
	Checksum: 0xA23621F1
	Offset: 0x1F08
	Size: 0x180
	Parameters: 0
	Flags: None
*/
function function_303fcbd8()
{
	self endon(#"death", #"crashing", #"leaving");
	for(;;)
	{
		if(isdefined(self.secondarytarget))
		{
			self.secondarytarget.antithreat = undefined;
			self.missiletarget = self.secondarytarget;
			while(isdefined(self.missiletarget) && isalive(self.missiletarget))
			{
				if(self helicopter::target_cone_check(self.missiletarget, level.heli_missile_target_cone))
				{
					self thread helicopter::missile_support(self.missiletarget, level.heli_missile_rof, 1, undefined);
				}
				else
				{
					break;
				}
				antithreat = antithreat + 100;
				self.missiletarget.antithreat = antithreat;
				wait(level.heli_missile_rof);
				if(!isdefined(self.secondarytarget) || (isdefined(self.secondarytarget) && self.missiletarget != self.secondarytarget))
				{
					break;
				}
			}
			if(isdefined(self.missiletarget))
			{
				self.missiletarget.antithreat = undefined;
			}
		}
		wait(5);
	}
}

/*
	Name: function_5d585945
	Namespace: namespace_a5493032
	Checksum: 0x7C0C15EA
	Offset: 0x2090
	Size: 0xFC
	Parameters: 1
	Flags: None
*/
function function_5d585945(hardpointtype)
{
	self notify(#"evasive");
	self.evasive = 1;
	var_ca7b2d46 = function_430510ec(self.str_path_start, "targetname");
	if(var_ca7b2d46.size > 1)
	{
		self.nd_path_start = array::random(var_ca7b2d46);
	}
	else
	{
		self.nd_path_start = var_ca7b2d46[0];
	}
	nd_path_start = self.nd_path_start;
	startwait = 2;
	if(isdefined(self.donotstop) && self.donotstop)
	{
		startwait = 0;
	}
	self thread function_560c5174(nd_path_start, startwait, hardpointtype);
}

/*
	Name: function_430510ec
	Namespace: namespace_a5493032
	Checksum: 0xC8E4DDCB
	Offset: 0x2198
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function function_430510ec(str_path_start, key = "targetname")
{
	return getvehiclenodearray(str_path_start, key);
}

/*
	Name: function_560c5174
	Namespace: namespace_a5493032
	Checksum: 0x8A4C24D6
	Offset: 0x21E0
	Size: 0x574
	Parameters: 3
	Flags: None
*/
function function_560c5174(currentnode, startwait, hardpointtype)
{
	self endon(#"death", #"leaving");
	self notify(#"flying");
	self endon(#"flying", #"abandoned");
	self.reached_dest = 0;
	helicopter::heli_reset();
	pos = self.origin;
	wait(startwait);
	while(isdefined(currentnode.target))
	{
		var_e2c8c9b6 = function_430510ec(currentnode.target, "targetname");
		if(var_e2c8c9b6.size > 1)
		{
			if(isdefined(self.primarytarget))
			{
				while(var_e2c8c9b6.size > 0 && (!isdefined(nextnode) || currentnode === nextnode))
				{
					nextnode = arraygetclosest(self.primarytarget.origin, var_e2c8c9b6);
					arrayremovevalue(var_e2c8c9b6, nextnode, 0);
				}
			}
			else
			{
				nextnode = array::random(var_e2c8c9b6);
			}
		}
		else
		{
			nextnode = var_e2c8c9b6[0];
		}
		/#
			assert(isdefined(nextnode), "");
		#/
		pos = nextnode.origin + vectorscale((0, 0, 1), 30);
		if(isdefined(currentnode.script_airspeed) && currentnode.script_airspeed > 0)
		{
			heli_speed = currentnode.script_airspeed;
		}
		else
		{
			heli_speed = self.n_speed + randomint(20);
		}
		if(isdefined(currentnode.script_accel))
		{
			heli_accel = currentnode.script_accel;
		}
		else
		{
			heli_accel = self.n_accel + randomint(5);
		}
		if(isdefined(self.pathspeedscale))
		{
			heli_speed = heli_speed * self.pathspeedscale;
			heli_accel = heli_accel * self.pathspeedscale;
		}
		if(!isdefined(nextnode.target))
		{
			stop = 1;
		}
		else
		{
			stop = 0;
		}
		if(isdefined(nextnode.script_delay) && !isdefined(self.donotstop))
		{
			stop = 1;
		}
		self setspeed(heli_speed, heli_accel);
		self helicopter::set_goal_pos(pos, stop);
		if(!isdefined(nextnode.script_delay) || isdefined(self.donotstop))
		{
			self waittill(#"near_goal");
			self notify(#"hash_69f631648cf75ba");
		}
		else
		{
			self setgoalyaw(nextnode.angles[1]);
			self waittill(#"goal");
			/#
				while(level flag::get(""))
				{
					helicopter::heli_wait(1);
				}
			#/
			n_wait = nextnode.script_delay;
			if(isdefined(self.var_e55eb7b9))
			{
				n_wait = n_wait + self.var_e55eb7b9;
			}
			self function_ab637f96(n_wait);
		}
		for(index = 0; index < level.heli_loop_paths.size; index++)
		{
			if(level.heli_loop_paths[index].origin == nextnode.origin)
			{
				self.loopcount++;
			}
		}
		currentnode = nextnode;
	}
	self setgoalyaw(currentnode.angles[1]);
	self.reached_dest = 1;
	self notify(#"hash_477c371e4f948b01");
	if(isdefined(self.waittime) && self.waittime)
	{
		self function_ab637f96(self.waittime);
	}
	if(isdefined(self))
	{
		self thread function_5d585945(hardpointtype);
	}
}

/*
	Name: function_ab637f96
	Namespace: namespace_a5493032
	Checksum: 0xC379B6FE
	Offset: 0x2760
	Size: 0xE6
	Parameters: 2
	Flags: None
*/
function function_ab637f96(waittime, var_f49cf7e0 = 0)
{
	self endon(#"death", #"crashing", #"evasive");
	self endon_callback(&function_6b4ab31d, #"hash_2fb2657921c7de37", #"damage", #"hash_1ef47c427ec739d7");
	self thread helicopter::heli_hover();
	if(var_f49cf7e0 > 0)
	{
		self thread function_40c7d949(var_f49cf7e0);
	}
	wait(waittime);
	self notify(#"hash_1ef47c427ec739d7");
}

/*
	Name: function_40c7d949
	Namespace: namespace_a5493032
	Checksum: 0x845CB44E
	Offset: 0x2850
	Size: 0xA2
	Parameters: 1
	Flags: None
*/
function function_40c7d949(n_range = 2000)
{
	self endon(#"hash_1ef47c427ec739d7");
	while(true)
	{
		if(isdefined(self.primarytarget) && distance2dsquared(self.origin, self.primarytarget.origin) > var_d6326c12)
		{
			self notify(#"hash_2fb2657921c7de37");
		}
	}
}

/*
	Name: function_6b4ab31d
	Namespace: namespace_a5493032
	Checksum: 0x59E3091D
	Offset: 0x2900
	Size: 0x2E
	Parameters: 1
	Flags: None
*/
function function_6b4ab31d(var_5a5260d8)
{
	helicopter::heli_reset();
	self notify(#"hash_6c89e93b924cbb7f");
}

/*
	Name: function_64dd0b39
	Namespace: namespace_a5493032
	Checksum: 0xFE4F1C00
	Offset: 0x2938
	Size: 0x1E4
	Parameters: 1
	Flags: None
*/
function function_64dd0b39(var_fec7078b)
{
	e_player = namespace_73e1c3e3::get_player();
	e_player thread namespace_73e1c3e3::function_785eb2ca();
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_d004238c40b4d74", 2, "green");
	e_player thread namespace_73e1c3e3::function_39e123a6(self.origin);
	team = self.originalteam;
	if(target_istarget(self))
	{
		target_remove(self);
	}
	if(isdefined(self.interior_model))
	{
		self.interior_model delete();
		self.interior_model = undefined;
	}
	if(isdefined(self.minigun_snd_ent))
	{
		self.minigun_snd_ent stoploopsound();
		self.minigun_snd_ent delete();
		self.minigun_snd_ent = undefined;
	}
	if(isdefined(self.alarm_snd_ent))
	{
		self.alarm_snd_ent delete();
		self.alarm_snd_ent = undefined;
	}
	if(isdefined(self.flare_ent))
	{
		self.flare_ent delete();
		self.flare_ent = undefined;
	}
	if(isdefined(var_fec7078b) && var_fec7078b)
	{
		self helicopter::function_e1058a3e();
	}
	self delete();
}

/*
	Name: function_4e049216
	Namespace: namespace_a5493032
	Checksum: 0x447CA04A
	Offset: 0x2B28
	Size: 0x3F4
	Parameters: 15
	Flags: Private
*/
private function function_4e049216(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(einflictor) && einflictor == self)
	{
		return 0;
	}
	if(isdefined(eattacker) && eattacker == self)
	{
		return 0;
	}
	if(!isdefined(self.damagetaken))
	{
		self.damagetaken = 0;
	}
	if(smeansofdeath === "MOD_PISTOL_BULLET" || smeansofdeath === "MOD_RIFLE_BULLET")
	{
		if(!(isdefined(level.var_9468071[#"hash_4d612f606300433a"]) && level.var_9468071[#"hash_4d612f606300433a"]))
		{
			level.var_9468071[#"hash_4d612f606300433a"] = 1;
			namespace_73e1c3e3::get_player() thread namespace_73e1c3e3::function_329f9ba6(#"hash_70f2d94bae3edef5", 2, "red");
		}
	}
	else if(smeansofdeath === "MOD_IMPACT" && weapon === getweapon(#"hero_pineapplegun"))
	{
		level notify(#"hash_788c0d72802f35af", {#v_loc:vpoint});
		self.damagetaken = self.damagetaken + 751;
	}
	else if(weapon === getweapon(#"eq_cluster_semtex_grenade") && (!(isdefined(self.var_21c8bc5f) && self.var_21c8bc5f)))
	{
		self.var_21c8bc5f = 1;
		level notify(#"hash_18859ff9fe569290", {#v_loc:vpoint});
		namespace_73e1c3e3::get_player() thread namespace_73e1c3e3::function_39e123a6(vpoint);
		if(!isdefined(self.damagetaken))
		{
			self.damagetaken = 0;
		}
		self.damagetaken = self.damagetaken + 1501;
	}
	if(self.damagetaken >= self.maxhealth && !isdefined(self.about_to_die))
	{
		self.about_to_die = 1;
		eattacker notify(#"destroyed_helicopter");
		eattacker potm::bookmark(#"hash_3e2e6a58550ea88c", gettime(), eattacker);
		level notify(#"hash_52fa8babe8d8d2c9");
		if(isdefined(self.waypoint))
		{
			self.waypoint namespace_73e1c3e3::function_f9ed304d();
		}
		if(target_istarget(self))
		{
			target_remove(self);
		}
		if(isdefined(level.var_4d5e1035))
		{
			self [[level.var_4d5e1035]](eattacker, weapon, smeansofdeath, idamage, "attack_chopper_shutdown", 0, self.hardpointtype);
		}
	}
	return idamage;
}

/*
	Name: function_4293d37b
	Namespace: namespace_a5493032
	Checksum: 0xB9FE5A59
	Offset: 0x2F28
	Size: 0x264
	Parameters: 8
	Flags: None
*/
function function_4293d37b(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	self clientfield::set("enemy_vehicle_keyline_render", 0);
	self notify(#"death");
	self namespace_231aa29a::vehicle_death();
	self vehicle::remove_from_target_group(self);
	e_player = namespace_73e1c3e3::get_player();
	if(isdefined(self.waypoint))
	{
		self.waypoint namespace_73e1c3e3::function_f9ed304d();
	}
	if(self.targetname === "enemy_mini_quad_tank" && (!(isdefined(self.var_d11c8572) && self.var_d11c8572)))
	{
		self.var_d11c8572 = 1;
		self cancelaimove();
		self function_d4c687c9();
		e_player thread namespace_73e1c3e3::function_39e123a6(self.origin);
		if(isdefined(self.var_95d9bf2e))
		{
			e_player thread function_e12a129();
			if(self.var_95d9bf2e == getweapon(#"hash_1db9fa8f7231f179") || self.var_95d9bf2e == getweapon(#"eq_cluster_semtex_grenade"))
			{
				n_points = 5;
			}
			else
			{
				n_points = 2;
			}
		}
		e_player thread namespace_73e1c3e3::function_d471f8fa(n_points, undefined, 1);
		self delete();
	}
	if(isdefined(level.ct_shared_objcounter.n_count))
	{
		e_player namespace_73e1c3e3::function_785eb2ca();
	}
}

/*
	Name: function_4c8f915a
	Namespace: namespace_a5493032
	Checksum: 0xFB06B5C2
	Offset: 0x3198
	Size: 0xA0
	Parameters: 2
	Flags: None
*/
function function_4c8f915a(str_targetname, str_team)
{
	drone = namespace_cbd87dc5::function_4c8f915a(self.origin);
	drone.angles = self.angles;
	drone setteam(str_team);
	drone.targetname = str_targetname;
	drone.var_95d9bf2e = undefined;
	aiutility::addaioverridedamagecallback(drone, &function_1f04fda);
	return drone;
}

/*
	Name: function_1f04fda
	Namespace: namespace_a5493032
	Checksum: 0xB6503274
	Offset: 0x3240
	Size: 0x24E
	Parameters: 15
	Flags: Private
*/
private function function_1f04fda(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal)
{
	if(isdefined(einflictor) && einflictor == self)
	{
		return 0;
	}
	if(isdefined(eattacker) && eattacker == self)
	{
		return 0;
	}
	if(!isdefined(self.damagetaken))
	{
		self.damagetaken = 0;
	}
	var_70abea18 = getweapon(#"eq_cluster_semtex_grenade");
	var_60350909 = getweapon(#"hash_66401df7cd6bf292");
	var_7f754220 = getweapon(#"hero_pineapple_grenade");
	if(weapon === var_7f754220)
	{
		level notify(#"hash_788c0d72802f35af", {#v_loc:vpoint});
	}
	else if(smeansofdeath !== "MOD_IMPACT" && weapon === var_70abea18)
	{
		self.damagetaken = self.damagetaken + 1501;
	}
	else if(smeansofdeath !== "MOD_IMPACT" && weapon === var_60350909)
	{
		self.damagetaken = self.damagetaken + 751;
	}
	if(self.damagetaken >= self.maxhealth)
	{
		idamage = self.maxhealth + 1000;
		if(isdefined(self.waypoint))
		{
			self.waypoint namespace_73e1c3e3::function_f9ed304d();
		}
	}
	self.var_95d9bf2e = weapon;
	return idamage;
}

/*
	Name: state_combat_enter
	Namespace: namespace_a5493032
	Checksum: 0xF287EB8F
	Offset: 0x3498
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function state_combat_enter(params)
{
	self thread ai_tank::turretfireupdate();
}

/*
	Name: function_cf3224fe
	Namespace: namespace_a5493032
	Checksum: 0xDF248D84
	Offset: 0x34C8
	Size: 0x22C
	Parameters: 1
	Flags: None
*/
function function_cf3224fe(b_success)
{
	namespace_73e1c3e3::get_player() thread namespace_73e1c3e3::function_c2a10fc();
	if(isdefined(level.var_4d4de8f9))
	{
		foreach(var_74d0673 in level.var_4d4de8f9)
		{
			var_74d0673 namespace_64a487a9::function_43df30a8();
		}
	}
	if(isdefined(level.var_ae0bbaac))
	{
		foreach(var_c361acde in level.var_ae0bbaac)
		{
			if(isalive(var_c361acde))
			{
				var_c361acde delete();
			}
		}
	}
	if(isdefined(level.var_c5d98d25))
	{
		foreach(vh_chopper in level.var_c5d98d25)
		{
			if(isalive(vh_chopper))
			{
				vh_chopper delete();
			}
		}
	}
	level.var_38c87b5 = b_success;
	var_cd803a6b = gettime() - level.var_ebad4ea8;
	return var_cd803a6b;
}

/*
	Name: function_377cd9ae
	Namespace: namespace_a5493032
	Checksum: 0x48C40948
	Offset: 0x3700
	Size: 0xA8
	Parameters: 0
	Flags: None
*/
function function_377cd9ae()
{
	level endon(#"combattraining_logic_finished");
	while(!level.gameended)
	{
		while(!self actionslotfourbuttonpressed())
		{
			waitframe(1);
		}
		if(!self isinmovemode("ufo", "noclip"))
		{
			level.var_105dad71++;
			if(level.var_105dad71 > 17)
			{
				level.var_105dad71 = 17;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_78aff698
	Namespace: namespace_a5493032
	Checksum: 0xD55B852A
	Offset: 0x37B0
	Size: 0xA4
	Parameters: 0
	Flags: None
*/
function function_78aff698()
{
	level endon(#"combattraining_logic_finished");
	while(!level.gameended)
	{
		while(!self actionslotthreebuttonpressed())
		{
			waitframe(1);
		}
		if(!self isinmovemode("ufo", "noclip"))
		{
			level.var_105dad71--;
			if(level.var_105dad71 < 0)
			{
				level.var_105dad71 = 0;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_72e84e64
	Namespace: namespace_a5493032
	Checksum: 0x605E9600
	Offset: 0x3860
	Size: 0x1F4
	Parameters: 0
	Flags: None
*/
function function_72e84e64()
{
	level endon(#"combattraining_logic_finished");
	namespace_73e1c3e3::function_6d7f4ec6(30);
	level.var_105dad71 = 1;
	e_player = getplayers(#"allies")[0];
	e_player thread function_377cd9ae();
	e_player thread function_78aff698();
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_3e63055cff392ca5", 10, "grey", 1);
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_789ced07ae5c9a0b", undefined);
	e_player function_56e0d37e(1);
	wait(1);
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_5949f76edc389803", 4, "red", 1);
	e_player function_56e0d37e(2);
	wait(1);
	e_player thread namespace_73e1c3e3::function_329f9ba6(#"hash_5949f76edc389803", 4, "red", 1);
	e_player function_56e0d37e(3);
	e_player thread function_9be2d75f();
	e_player thread namespace_73e1c3e3::function_61c3d59c(#"hash_233aafc8172fead1", undefined);
	e_player function_701302a8();
}

/*
	Name: function_701302a8
	Namespace: namespace_a5493032
	Checksum: 0xC194EAD2
	Offset: 0x3A60
	Size: 0x1A6
	Parameters: 0
	Flags: None
*/
function function_701302a8()
{
	e_player = self;
	level.var_ae0bbaac = e_player function_22c41fdd(10, 1, undefined, 1);
	foreach(var_c22808fd in level.var_ae0bbaac)
	{
		var_c22808fd.waypoint = var_c22808fd namespace_73e1c3e3::create_waypoint(#"hash_4b08047cf5e74f2e", var_c22808fd.origin, var_c22808fd.angles, #"any", undefined, 0, undefined);
		if(isdefined(level.var_d6d98fbe) && level.var_d6d98fbe)
		{
			var_c22808fd clientfield::set("enemy_vehicle_keyline_render", 1);
		}
	}
	e_player namespace_73e1c3e3::function_68e9fa9e(#"hash_1b6372a0a5dc0fef", 0, level.var_ae0bbaac.size, 1, 1);
	while(level.var_ae0bbaac.size > 0)
	{
		function_1eaaceab(level.var_ae0bbaac);
		wait(1);
	}
}

/*
	Name: function_52d196f2
	Namespace: namespace_a5493032
	Checksum: 0x1DA1EB17
	Offset: 0x3C10
	Size: 0x414
	Parameters: 1
	Flags: None
*/
function function_52d196f2(n_difficulty = 2)
{
	e_player = self;
	var_88e49d60 = array(1, 1, 1);
	var_a7b6c024 = array(0, 0, 0);
	var_89d9697a = array(7, 5, 5);
	var_ed621a12 = array(50, 50, 25);
	var_c52588b6 = array(30, 35, 50);
	var_c005d40b = array(10, 15, 30);
	var_44092575 = 0;
	foreach(n_count in var_88e49d60)
	{
		var_44092575 = var_44092575 + n_count;
	}
	e_player thread function_9be2d75f();
	var_edf46d6e = [];
	var_edf46d6e[#"hash_72de0eaa7f3c7619"] = var_a7b6c024[n_difficulty];
	var_edf46d6e[#"hash_5ff2a429aff04484"] = var_89d9697a[n_difficulty];
	var_edf46d6e[#"hash_567524f34ee44d06"] = var_ed621a12[n_difficulty];
	var_edf46d6e[#"speed"] = var_c52588b6[n_difficulty];
	var_edf46d6e[#"accel"] = var_c005d40b[n_difficulty];
	level.var_c5d98d25 = e_player function_22c41fdd(var_88e49d60[n_difficulty], 0, var_edf46d6e, 2);
	foreach(vh_chopper in level.var_c5d98d25)
	{
		vh_chopper.waypoint = vh_chopper namespace_73e1c3e3::create_waypoint(#"hash_3489718f227fba3", vh_chopper.origin, vh_chopper.angles, #"any", undefined, 0, undefined);
	}
	n_count = 10;
	n_total = 10 + level.var_c5d98d25.size;
	e_player namespace_73e1c3e3::function_68e9fa9e(#"hash_1b6372a0a5dc0fef", n_count, n_total, 1, 1);
	while(level.var_c5d98d25.size > 0 || level.var_ae0bbaac.size > 0)
	{
		function_1eaaceab(level.var_c5d98d25);
		function_1eaaceab(level.var_ae0bbaac);
		wait(0.5);
	}
	e_player namespace_73e1c3e3::function_8b7a2fdd();
}

/*
	Name: function_9be2d75f
	Namespace: namespace_a5493032
	Checksum: 0x908ECF18
	Offset: 0x4030
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_9be2d75f()
{
	self namespace_73e1c3e3::function_329f9ba6(#"hash_5b71b9ee6fbb6a4a", 2, "green", 2);
	self namespace_73e1c3e3::function_329f9ba6(#"hash_2f203cc2de1af314", 5, "red");
}

/*
	Name: function_7dbf5593
	Namespace: namespace_a5493032
	Checksum: 0x2E6587EE
	Offset: 0x40A0
	Size: 0x96
	Parameters: 0
	Flags: None
*/
function function_7dbf5593()
{
	self endon(#"death");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = self waittill(#"grenade_launcher_fire");
		if(self util::gadget_is_in_use(2))
		{
			if(isdefined(var_385703b7.projectile))
			{
				var_385703b7.projectile thread function_4674d2e7();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_4674d2e7
	Namespace: namespace_a5493032
	Checksum: 0xBCB39235
	Offset: 0x4140
	Size: 0xD6
	Parameters: 0
	Flags: None
*/
function function_4674d2e7()
{
	self endon(#"death");
	while(true)
	{
		var_385703b7 = undefined;
		var_385703b7 = level waittill(#"hash_788c0d72802f35af");
		var_1c5e8282 = distance(self.origin, var_385703b7.v_loc);
		if(var_1c5e8282 < 4)
		{
			namespace_73e1c3e3::get_player() thread namespace_73e1c3e3::function_39e123a6(self.origin);
			wait(0.1);
			self delete();
		}
		waitframe(1);
	}
}

/*
	Name: function_56e0d37e
	Namespace: namespace_a5493032
	Checksum: 0x24F9B45E
	Offset: 0x4220
	Size: 0x1F8
	Parameters: 1
	Flags: None
*/
function function_56e0d37e(var_764a1fa0)
{
	level endon(#"combattraining_logic_finished");
	var_5c91700c = [];
	foreach(var_dcf4bc53 in level.var_f3c95b8b)
	{
		if(var_dcf4bc53.script_int == var_764a1fa0)
		{
			var_5c91700c[var_5c91700c.size] = var_dcf4bc53;
		}
	}
	level.var_4d4de8f9 = [];
	foreach(var_dcf4bc53 in var_5c91700c)
	{
		e_enemy = namespace_64a487a9::function_7e8fcca2(var_dcf4bc53);
		if(isalive(e_enemy))
		{
			level.var_4d4de8f9[level.var_4d4de8f9.size] = e_enemy;
		}
		waitframe(1);
	}
	namespace_73e1c3e3::get_player() namespace_73e1c3e3::function_68e9fa9e(#"hash_1b6372a0a5dc0fef", 0, level.var_4d4de8f9.size, 1, 1);
	while(level.var_4d4de8f9.size > 0)
	{
		function_1eaaceab(level.var_4d4de8f9);
		wait(0.1);
	}
}

/*
	Name: function_e12a129
	Namespace: namespace_a5493032
	Checksum: 0x888CCBCA
	Offset: 0x4420
	Size: 0xE4
	Parameters: 1
	Flags: None
*/
function function_e12a129(v_target)
{
	self endon(#"hash_1c78823c90f5a58a");
	if(!(isdefined(self.var_e2ca43cf) && self.var_e2ca43cf) && !isbot(self))
	{
		if(!isdefined(self.var_7f8ce835))
		{
			self.var_7f8ce835 = 0;
		}
		self.var_7f8ce835++;
		if(!(isdefined(self.var_439da772) && self.var_439da772))
		{
			self.var_439da772 = 1;
			wait(2);
			self.var_7f8ce835 = 0;
			self.var_439da772 = 0;
		}
		else if(self.var_7f8ce835 >= 3)
		{
			self thread function_f75c4ec2(v_target);
		}
	}
}

/*
	Name: function_f75c4ec2
	Namespace: namespace_a5493032
	Checksum: 0xCA5B1A7A
	Offset: 0x4510
	Size: 0x11E
	Parameters: 1
	Flags: None
*/
function function_f75c4ec2(v_target)
{
	self notify(#"hash_1c78823c90f5a58a");
	if(isdefined(v_target))
	{
		level.var_d2193160.origin = v_target + vectorscale((0, 0, 1), 48);
		if(!self function_80d68e4d(level.var_d2193160, 0.7, 1))
		{
			self potm::bookmark(#"hash_3e2e6a58550ea88c", gettime(), self);
		}
	}
	self.var_e2ca43cf = 1;
	self thread namespace_73e1c3e3::function_d471f8fa(10, undefined, 1, "_multikill");
	self namespace_73e1c3e3::function_329f9ba6(#"hash_334ffdf56102449f", 2, "green", 1);
	self.var_7f8ce835 = 0;
	self.var_e2ca43cf = 0;
	self.var_439da772 = 0;
}

/*
	Name: function_868cd9ac
	Namespace: namespace_a5493032
	Checksum: 0x10CDAB8D
	Offset: 0x4638
	Size: 0x6F8
	Parameters: 0
	Flags: None
*/
function function_868cd9ac()
{
	/#
		sessionmode = currentsessionmode();
		setdvar(#"hash_16e650a0fe963515", "");
		level flag::init("");
		if(sessionmode != 4)
		{
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
			adddebugcommand("");
		}
		while(true)
		{
			wait(0.25);
			cmd = getdvarstring(#"hash_16e650a0fe963515", "");
			if(cmd == "")
			{
				continue;
			}
			e_player = level.players[0];
			switch(cmd)
			{
				case "hash_3a7f84f30eb3613e":
				{
					if(isdefined(level.var_ae0bbaac) && level.var_ae0bbaac.size > 0)
					{
						while(level.var_ae0bbaac.size > 0)
						{
							var_c95e2891 = level.var_ae0bbaac[0];
							if(isalive(var_c95e2891))
							{
								var_c95e2891 dodamage(100000, var_c95e2891.origin);
								function_1eaaceab(level.var_ae0bbaac, 0);
								wait(0.1);
							}
						}
					}
					break;
				}
				case "spawn_chopper":
				{
					var_1cad30e7 = struct::get_array("", "");
					function_4b892700(var_1cad30e7[0]);
					break;
				}
				case "hash_3336321eb0a42dd":
				{
					var_e62f2b3d = struct::get_array("", "");
					e_player function_22c41fdd(var_e62f2b3d.size, 1);
					break;
				}
				case "hash_20f84a451b85817":
				{
					if(level flag::get(""))
					{
						iprintlnbold("");
						level flag::clear("");
					}
					else
					{
						iprintlnbold("");
						level flag::set("");
					}
					break;
				}
				case "hash_47e019566f91d4d1":
				{
					if(!(isdefined(level.var_d6d98fbe) && level.var_d6d98fbe))
					{
						level.var_d6d98fbe = 1;
						foreach(ai_bot in level.var_4d4de8f9)
						{
							if(isalive(ai_bot))
							{
								ai_bot thread namespace_73e1c3e3::function_8963dae3();
							}
						}
						if(isdefined(level.var_ae0bbaac) && level.var_ae0bbaac.size > 0)
						{
							foreach(var_c22808fd in level.var_ae0bbaac)
							{
								if(isalive(var_c22808fd))
								{
									var_c22808fd clientfield::set("", 1);
								}
							}
						}
					}
					break;
				}
				case "hash_3384d4df94b5c66d":
				{
					if(isdefined(level.var_d6d98fbe) && level.var_d6d98fbe)
					{
						level.var_d6d98fbe = 0;
						foreach(ai_bot in level.var_4d4de8f9)
						{
							if(isalive(ai_bot))
							{
								ai_bot notify(#"hash_17559ffda18178a0");
							}
						}
						if(isdefined(level.var_ae0bbaac) && level.var_ae0bbaac.size > 0)
						{
							foreach(var_c22808fd in level.var_ae0bbaac)
							{
								if(isalive(var_c22808fd))
								{
									var_c22808fd clientfield::set("", 0);
								}
							}
						}
					}
					break;
				}
			}
			setdvar(#"hash_16e650a0fe963515", "");
		}
	#/
}

