// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1e72c148eb0b32d2;
#using script_20d7669868834bae;
#using script_24c32478acf44108;
#using script_2c5daa95f8fec03c;
#using script_317aa6153a75c589;
#using script_35598499769dbb3d;
#using script_3657077a08b7f19e;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_4711d838e4b8678c;
#using script_489b835a247c990e;
#using script_4d7a011c72096fc2;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_57f7003580bb15e0;
#using script_58c342edd81589fb;
#using script_59f07c660e6710a5;
#using script_6809bf766eba194a;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
#using script_7e59d7bba853fe4b;
#using script_bd2b8aaa388dcce;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\burnplayer.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\gameobjects_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

class class_264486ac 
{

	/*
		Name: constructor
		Namespace: namespace_264486ac
		Checksum: 0x82352AA7
		Offset: 0x1560
		Size: 0x4C
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self.active = 1;
		self.health = 0;
		self.hitloc = "";
		self.var_f16c2276 = "";
		var_934afb38 = 0;
	}

	/*
		Name: destructor
		Namespace: namespace_264486ac
		Checksum: 0x80F724D1
		Offset: 0x15B8
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16, 128
	*/
	destructor()
	{
	}

}

#namespace namespace_823c357e;

/*
	Name: function_89f2df9
	Namespace: namespace_823c357e
	Checksum: 0x6C889681
	Offset: 0x610
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_794b9e68193e343a", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_823c357e
	Checksum: 0x7987F90
	Offset: 0x660
	Size: 0x3C4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_b48fed60 = 0;
	zm_player::register_player_damage_callback(&function_6da30402);
	registerbehaviorscriptfunctions();
	init();
	/#
		execdevgui("");
		level thread function_a92dac75();
	#/
	spawner::add_archetype_spawn_function(#"stoker", &function_580b77a2);
	zm_utility::function_d0f02e71(#"stoker");
	/#
		spawner::add_archetype_spawn_function(#"stoker", &zombie_utility::function_27ba8249);
	#/
	animationstatenetwork::registernotetrackhandlerfunction("coals_fire", &function_b2602782);
	animationstatenetwork::registernotetrackhandlerfunction("stoker_death_gib", &function_eb4e0ec3);
	animationstatenetwork::registernotetrackhandlerfunction("coal_charge_stop", &function_717a6538);
	if(ai::shouldregisterclientfieldforarchetype(#"stoker"))
	{
		clientfield::register("actor", "crit_spot_reveal_clientfield", 1, getminbitcountfornum(4), "int");
		clientfield::register("actor", "stoker_fx_start_clientfield", 1, 3, "int");
		clientfield::register("actor", "stoker_fx_stop_clientfield", 1, 3, "int");
		clientfield::register("actor", "stoker_death_explosion", 1, 2, "int");
	}
	function_983f7ff1();
	zm::register_actor_damage_callback(&function_fa8be26d);
	zm_spawner::register_zombie_death_event_callback(&killed_callback);
	namespace_32192f7::function_95c1dd81(#"stoker", &function_f5f699aa);
	namespace_9ff9f642::register_slowdown("stoker_undewater_slow_type", 0.8);
	namespace_c3287616::register_archetype(#"stoker", &function_b381320, &round_spawn, undefined, 100);
	namespace_c3287616::function_306ce518(#"stoker", &function_cf5ef033);
	zm_cleanup::function_cdf5a512(#"stoker", &function_3049b317);
}

/*
	Name: __main__
	Namespace: namespace_823c357e
	Checksum: 0x80F724D1
	Offset: 0xA30
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init
	Namespace: namespace_823c357e
	Checksum: 0x7002156C
	Offset: 0xA40
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_411746bd = [];
	level thread aat::register_immunity("zm_aat_brain_decay", #"stoker", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"stoker", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"stoker", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"stoker", 1, 1, 1);
	function_2170ee7a();
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_823c357e
	Checksum: 0x3C9AB0AF
	Offset: 0xB48
	Size: 0x9E4
	Parameters: 0
	Flags: Linked
*/
function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_253c9e38));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_11342039e49bb092", &function_253c9e38);
	/#
		assert(isscriptfunctionptr(&function_6d817d57));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_64bb85f17c6f0c26", &function_6d817d57);
	/#
		assert(isscriptfunctionptr(&function_31f887b5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7abf56a70eea8824", &function_31f887b5);
	/#
		assert(isscriptfunctionptr(&function_6cd91a4d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7914389e526099c3", &function_6cd91a4d);
	/#
		assert(isscriptfunctionptr(&function_d47e273b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_69d99c802f94a161", &function_d47e273b);
	/#
		assert(isscriptfunctionptr(&function_65d23c4f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_34979234c577e020", &function_65d23c4f);
	/#
		assert(isscriptfunctionptr(&function_fb220c8c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2eda816d46284ecf", &function_fb220c8c);
	/#
		assert(isscriptfunctionptr(&function_53d1998d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_62e8ff16b0eb8a2e", &function_53d1998d);
	/#
		assert(isscriptfunctionptr(&function_765f06f9));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_e3d43dd957e7586", &function_765f06f9);
	/#
		assert(isscriptfunctionptr(&function_60951874));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2d05a32b52fcaafd", &function_60951874);
	/#
		assert(isscriptfunctionptr(&function_8ef6771f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ed50d08e0e9bcfa", &function_8ef6771f);
	/#
		assert(isscriptfunctionptr(&function_e2e5eebf));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ce6baf23499b6f", &function_e2e5eebf);
	/#
		assert(isscriptfunctionptr(&function_7cd52d88));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3993bf34ab2531f0", &function_7cd52d88);
	/#
		assert(isscriptfunctionptr(&function_a2d1d120));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_25c4de2eb81f27cb", &function_a2d1d120);
	/#
		assert(isscriptfunctionptr(&function_b7fe306e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_389c07d3893e660", &function_b7fe306e);
	/#
		assert(isscriptfunctionptr(&function_36903815));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1607f20e814fb19b", &function_36903815);
	/#
		assert(isscriptfunctionptr(&function_f01e64d6));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_173e1c9378200965", &function_f01e64d6);
	/#
		assert(isscriptfunctionptr(&function_dee90338));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3e875851311be4e8", &function_dee90338);
	/#
		assert(isscriptfunctionptr(&function_b6e7676d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4fe0c56f8cd42ad1", &function_b6e7676d);
	/#
		assert(isscriptfunctionptr(&function_20a3d8f6));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21f1387075571547", &function_20a3d8f6);
	/#
		assert(isscriptfunctionptr(&function_efbd6650));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_771bfe8686d806d6", &function_efbd6650);
	/#
		assert(isscriptfunctionptr(&function_399815b2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_138db5b46aeab153", &function_399815b2);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_b4ecc051) || isscriptfunctionptr(&function_b4ecc051));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_4778faf1d75cc885", undefined, &function_b4ecc051, undefined);
}

/*
	Name: function_983f7ff1
	Namespace: namespace_823c357e
	Checksum: 0xEFC9FEA2
	Offset: 0x1538
	Size: 0x1E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_983f7ff1()
{
	level.var_71be6cf4 = 0;
	level.var_fb6dfb50 = 0;
}

/*
	Name: function_580b77a2
	Namespace: namespace_823c357e
	Checksum: 0x897BAFD2
	Offset: 0x1658
	Size: 0x5D8
	Parameters: 0
	Flags: Linked
*/
function function_580b77a2()
{
	zm_score::function_e5d6e6dd(#"stoker", self ai::function_9139c839().var_87e1e74d);
	aiutility::addaioverridedamagecallback(self, &function_a96d8bd7);
	self attach("c_t8_zmb_titanic_stoker_larm1");
	self attach("c_t8_zmb_titanic_stoker_lshoulder_cap1");
	self attach("c_t8_zmb_titanic_stoker_rshoulder_cap1");
	self attach("c_t8_zmb_titanic_stoker_head_cap1");
	self attach("c_t8_zmb_titanic_stoker_shovel1", "tag_weapon_right");
	self.var_1861eb5b = [];
	self.var_1861eb5b[#"left_arm_upper"] = new class_264486ac();
	self.var_1861eb5b[#"left_arm_upper"].var_fbff893 = 4;
	self.var_1861eb5b[#"left_arm_upper"].fxindex = 3;
	self.var_1861eb5b[#"right_arm_upper"] = new class_264486ac();
	self.var_1861eb5b[#"right_arm_upper"].var_fbff893 = 1;
	self.var_1861eb5b[#"right_arm_upper"].fxindex = 4;
	self.var_1861eb5b[#"head"] = new class_264486ac();
	self.var_1861eb5b[#"head"].var_fbff893 = 3;
	self.var_1861eb5b[#"head"].fxindex = 5;
	self.var_1861eb5b[#"left_arm_lower"] = new class_264486ac();
	self.var_1861eb5b[#"left_arm_lower"].var_6d7b8c32 = 1;
	self.var_1861eb5b[#"left_arm_lower"].var_a222368f = "j_wrist_le";
	self.var_1861eb5b[#"left_arm_lower"].fxindex = 6;
	self.var_19f48bbe = [];
	self.var_19f48bbe[0] = "left_arm_upper";
	self.var_19f48bbe[1] = "right_arm_upper";
	self.var_19f48bbe[2] = "head";
	if(!isdefined(level.var_a64fa07c))
	{
		level.var_a64fa07c = 0;
	}
	self.var_a056e24 = self.var_19f48bbe[level.var_a64fa07c];
	level.var_a64fa07c = (level.var_a64fa07c + 1) % self.var_19f48bbe.size;
	self.var_dc32e381 = 0;
	self.var_81d3587d = 0;
	self.var_ce5d8e8f = "locomotion_speed_run";
	if(level.var_fb6dfb50)
	{
		self.var_ce5d8e8f = "locomotion_speed_walk";
	}
	self setblackboardattribute("_locomotion_speed", self.var_ce5d8e8f);
	self.lastattacktime = (gettime() + self ai::function_9139c839().var_1d505f4d) - getdvarint(#"hash_3dfb66f92268c90f", self ai::function_9139c839().var_d33d95d0);
	self.var_41f51cb4 = "stoker_charge_attack";
	self.var_5274eb5f = 0;
	self.var_86f9cdcd = 0;
	self.var_aca87abc = 0;
	self.var_d691409c = 0;
	self.var_ccb2e201 = 0;
	self.var_1db5ef71 = 0;
	self.should_zigzag = 0;
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.var_f46fbf3f = 1;
	self.actor_killed_override = &function_cf402986;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self.var_80cf70fb = &function_e4ef4e27;
	self.cant_move_cb = &zombiebehavior::function_79fe956f;
	self zm_powerup_nuke::function_9a79647b(0.5);
	self thread zm_audio::play_ambient_zombie_vocals();
	target_set(self);
	level.var_b48fed60++;
}

/*
	Name: function_2df052bb
	Namespace: namespace_823c357e
	Checksum: 0x8C551A11
	Offset: 0x1C38
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_2df052bb()
{
	self.maxhealth = int(self namespace_e0710ee6::function_8d44707e(1, self._starting_round_number) * (isdefined(level.var_1b0cc4f5) ? level.var_1b0cc4f5 : 1));
	self.health = self.maxhealth;
	namespace_81245006::initweakpoints(self, #"hash_3d1befac390ef735");
}

/*
	Name: function_3049b317
	Namespace: namespace_823c357e
	Checksum: 0x40788122
	Offset: 0x1CD0
	Size: 0x118
	Parameters: 0
	Flags: Linked
*/
function function_3049b317()
{
	if(!(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
	{
		return true;
	}
	if(isdefined(level.stoker_spawn_func))
	{
		s_spawn_loc = [[level.stoker_spawn_func]]();
	}
	else if(level.zm_loc_types[#"stoker_location"].size > 0)
	{
		s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
	}
	if(!isdefined(s_spawn_loc))
	{
		return true;
	}
	self namespace_e0710ee6::function_a8dc3363(s_spawn_loc);
	if(isalive(self))
	{
		self playsound(#"hash_63299a75a97f9678");
		function_6eac4ca1(self, "spawn");
	}
	return true;
}

/*
	Name: function_eb4e0ec3
	Namespace: namespace_823c357e
	Checksum: 0xB5434291
	Offset: 0x1DF0
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_eb4e0ec3(entity)
{
	entity setmodel("c_t8_zmb_titanic_stoker_body1_gibbed");
	entity clientfield::set("stoker_death_explosion", 2);
}

/*
	Name: function_cf402986
	Namespace: namespace_823c357e
	Checksum: 0xEA2D1EAE
	Offset: 0x1E48
	Size: 0x9C
	Parameters: 8
	Flags: Linked, Private
*/
function private function_cf402986(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	self clientfield::set("stoker_fx_start_clientfield", 1);
	destructserverutils::destructnumberrandompieces(self);
	self clientfield::set("stoker_death_explosion", 1);
}

/*
	Name: function_e4ef4e27
	Namespace: namespace_823c357e
	Checksum: 0x8AF6282
	Offset: 0x1EF0
	Size: 0x74
	Parameters: 4
	Flags: Linked, Private
*/
function private function_e4ef4e27(entity, attribute, oldvalue, value)
{
	if(value == "low")
	{
		entity thread namespace_9ff9f642::slowdown("stoker_undewater_slow_type");
	}
	else
	{
		entity thread namespace_9ff9f642::function_520f4da5("stoker_undewater_slow_type");
	}
}

/*
	Name: function_a96d8bd7
	Namespace: namespace_823c357e
	Checksum: 0xBF7421B8
	Offset: 0x1F70
	Size: 0x6E0
	Parameters: 12
	Flags: Linked
*/
function function_a96d8bd7(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, boneindex, modelindex)
{
	if(self.archetype != #"stoker")
	{
		return;
	}
	if(eattacker.archetype === #"stoker")
	{
		return 0;
	}
	if(namespace_3a56904b::is_active() && !self namespace_3a56904b::function_23d15bf3(eattacker))
	{
		return 0;
	}
	var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, shitloc, 1);
	if(!isdefined(var_dd54fdb1))
	{
		var_dd54fdb1 = namespace_81245006::function_73ab4754(self, vpoint, 1);
	}
	var_786d7e06 = namespace_e0710ee6::function_422fdfd4(self, eattacker, sweapon, boneindex, shitloc, vpoint, var_dd54fdb1);
	damagedone = int(max(1, idamage * var_786d7e06.damage_scale));
	var_fe16adf4 = 0;
	var_88e794fb = 0;
	var_ae30c5b0 = 0;
	if(zm_loadout::is_hero_weapon(sweapon))
	{
		var_ae30c5b0 = 1;
		if(!isdefined(self.var_5dc26e42) || self.var_5dc26e42 >= 1000)
		{
			self.var_5dc26e42 = 0;
		}
		self.var_5dc26e42 = self.var_5dc26e42 + damagedone;
	}
	if(smeansofdeath != "MOD_PROJECTILE_SPLASH")
	{
		if(!var_ae30c5b0)
		{
			var_dd54fdb1 = var_786d7e06.var_84ed9a13;
			var_88e794fb = var_786d7e06.registerzombie_bgb_used_reinforce;
		}
		else
		{
			weakpoints = namespace_81245006::function_fab3ee3e(self);
			if(isdefined(weakpoints))
			{
				foreach(var_3a1904d3 in weakpoints)
				{
					if(namespace_81245006::function_f29756fe(var_3a1904d3) === 1 && var_3a1904d3.type === #"armor" && var_3a1904d3.hitloc !== "left_arm_lower")
					{
						var_dd54fdb1 = var_3a1904d3;
						var_88e794fb = 1;
						break;
					}
				}
			}
		}
		if(isdefined(var_dd54fdb1))
		{
			if(var_dd54fdb1.type == #"armor")
			{
				if(isdefined(var_88e794fb) && var_88e794fb)
				{
					if(isdefined(var_dd54fdb1.hitloc))
					{
						var_1861eb5b = self.var_1861eb5b[var_dd54fdb1.hitloc];
					}
					if(isdefined(var_1861eb5b))
					{
						self clientfield::set("stoker_fx_start_clientfield", var_1861eb5b.fxindex);
					}
					namespace_81245006::function_ef87b7e8(var_dd54fdb1, damagedone);
					var_fe16adf4 = 1;
					function_6eac4ca1(self, "pain");
					if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3 || (var_ae30c5b0 && self.var_5dc26e42 >= 1000))
					{
						if(var_dd54fdb1.var_641ce20e)
						{
							namespace_81245006::function_6742b846(self, var_dd54fdb1);
						}
						if(isdefined(var_1861eb5b.var_6d7b8c32) && var_1861eb5b.var_6d7b8c32)
						{
							self.var_81d3587d = 1;
							self.var_86f9cdcd = 1;
						}
						if(isdefined(var_1861eb5b.var_a222368f))
						{
							physicsexplosionsphere(self gettagorigin(var_1861eb5b.var_a222368f), 600, 0, 80, 1, 1);
							self.var_ccb2e201 = 1;
						}
						self destructserverutils::handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, var_dd54fdb1.hitloc, psoffsettime, boneindex, modelindex);
						if(var_dd54fdb1.hitloc === self.var_a056e24)
						{
							if(isdefined(var_1861eb5b.var_fbff893))
							{
								self clientfield::set("crit_spot_reveal_clientfield", var_1861eb5b.var_fbff893);
							}
							var_add9b529 = namespace_81245006::function_3131f5dd(self, self.var_a056e24);
							if(isdefined(var_add9b529))
							{
								namespace_81245006::function_6c64ebd3(var_add9b529, 1);
							}
						}
					}
				}
			}
			else if(var_dd54fdb1.hitloc === self.var_a056e24)
			{
				if(self.var_5274eb5f)
				{
					self.var_dc32e381 = self.var_dc32e381 + damagedone;
				}
				if(damagedone >= self.health)
				{
					self.var_6f3ba226 = 1;
					self notify(#"hash_4651621237a54fc7");
				}
			}
		}
	}
	if(var_fe16adf4 && !var_ae30c5b0)
	{
		damagedone = 1;
	}
	/#
		function_752a64b8((("" + damagedone) + "") + self.health);
	#/
	return damagedone;
}

/*
	Name: function_1bf5272c
	Namespace: namespace_823c357e
	Checksum: 0x766309AC
	Offset: 0x2658
	Size: 0xC0
	Parameters: 5
	Flags: Private
*/
function private function_1bf5272c(hitloc, point, location, var_934afb38, tag)
{
	var_99f08950 = 0;
	if(isdefined(hitloc) && hitloc != "none" && hitloc == location)
	{
		var_99f08950 = 1;
	}
	else
	{
		distsq = distancesquared(point, self gettagorigin(tag));
		if(distsq <= var_934afb38)
		{
			var_99f08950 = 1;
		}
	}
	return var_99f08950;
}

/*
	Name: function_c9116e0f
	Namespace: namespace_823c357e
	Checksum: 0x58D2D4EC
	Offset: 0x2720
	Size: 0x86
	Parameters: 2
	Flags: Private
*/
function private function_c9116e0f(var_1861eb5b, damage)
{
	/#
		function_752a64b8((("" + damage) + "") + var_1861eb5b.position);
	#/
	var_1861eb5b.health = var_1861eb5b.health - damage;
	if(var_1861eb5b.health <= 0)
	{
		var_1861eb5b.active = 0;
	}
}

/*
	Name: function_31f887b5
	Namespace: namespace_823c357e
	Checksum: 0xEF63F9CB
	Offset: 0x27B0
	Size: 0x2B6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_31f887b5(behaviortreeentity)
{
	if(behaviortreeentity getblackboardattribute("_locomotion_speed") === "locomotion_speed_sprint" || behaviortreeentity.var_ccb2e201)
	{
		var_bd66486b = "knockdown";
	}
	else
	{
		var_bd66486b = "push";
	}
	var_92cf09df = behaviortreeentity ai::function_9139c839().var_a22e6e32;
	if(behaviortreeentity.var_ccb2e201)
	{
		var_92cf09df = behaviortreeentity ai::function_9139c839().var_159f74bb;
	}
	velocity = behaviortreeentity getvelocity();
	velocitymag = length(velocity);
	predicttime = 0.2;
	movevector = velocity * predicttime;
	predictedpos = behaviortreeentity.origin + movevector;
	var_a5a1f99c = getaiarchetypearray(#"zombie");
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"catalyst"), 0, 0);
	var_86476d47 = array::filter(var_a5a1f99c, 0, &namespace_9ff9f642::function_865a83f8, behaviortreeentity, predictedpos, var_92cf09df);
	if(var_86476d47.size > 0)
	{
		foreach(zombie in var_86476d47)
		{
			if(var_bd66486b == "knockdown")
			{
				zombie zombie_utility::setup_zombie_knockdown(behaviortreeentity);
				zombie.knockdown_type = "knockdown_shoved";
				continue;
			}
			zombie zombie_utility::function_fc0cb93d(behaviortreeentity);
		}
	}
	behaviortreeentity.var_ccb2e201 = 0;
}

/*
	Name: function_6cd91a4d
	Namespace: namespace_823c357e
	Checksum: 0xC455A378
	Offset: 0x2A70
	Size: 0x130
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6cd91a4d(entity)
{
	if(!isdefined(entity.enemy))
	{
		return false;
	}
	if(entity.var_1db5ef71 > gettime())
	{
		return false;
	}
	meleedistsq = 4096;
	if(isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone)
	{
		meleedistsq = entity.meleeweapon.var_d3cafde6 * entity.meleeweapon.var_d3cafde6;
	}
	var_e9677328 = distancesquared(entity.origin, entity.enemy.origin);
	if(var_e9677328 <= meleedistsq)
	{
		return false;
	}
	if(var_e9677328 > entity ai::function_9139c839().var_b7a8163d * entity ai::function_9139c839().var_b7a8163d)
	{
		return false;
	}
	return true;
}

/*
	Name: function_d4e03577
	Namespace: namespace_823c357e
	Checksum: 0x713991D0
	Offset: 0x2BA8
	Size: 0x52
	Parameters: 1
	Flags: Private
*/
function private function_d4e03577(distance)
{
	if(isdefined(self.enemy))
	{
		return distancesquared(self.origin, self.enemy.origin) > (distance * distance);
	}
	return 0;
}

/*
	Name: function_d47e273b
	Namespace: namespace_823c357e
	Checksum: 0x9971B7AA
	Offset: 0x2C08
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d47e273b(entity)
{
	return entity.var_86f9cdcd;
}

/*
	Name: function_65d23c4f
	Namespace: namespace_823c357e
	Checksum: 0xB411457E
	Offset: 0x2C28
	Size: 0x3E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_65d23c4f(entity)
{
	/#
		if(entity.var_907e6060)
		{
			function_752a64b8("");
		}
	#/
	return entity.var_907e6060;
}

/*
	Name: function_fb220c8c
	Namespace: namespace_823c357e
	Checksum: 0x26F54C0B
	Offset: 0x2C70
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fb220c8c(entity)
{
	return entity.var_aca87abc && function_ac53cb4e(entity);
}

/*
	Name: function_53d1998d
	Namespace: namespace_823c357e
	Checksum: 0x8487ABE7
	Offset: 0x2CA8
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_53d1998d(entity)
{
	return !entity.var_907e6060 && entity.var_aca87abc && function_ac53cb4e(entity);
}

/*
	Name: function_765f06f9
	Namespace: namespace_823c357e
	Checksum: 0xD5DA2761
	Offset: 0x2CF8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_765f06f9(entity)
{
	return entity.var_aca87abc && function_ac53cb4e(entity);
}

/*
	Name: function_7cd52d88
	Namespace: namespace_823c357e
	Checksum: 0x8787047E
	Offset: 0x2D30
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7cd52d88(entity)
{
	/#
		function_752a64b8("");
	#/
}

/*
	Name: function_b7fe306e
	Namespace: namespace_823c357e
	Checksum: 0xD865F33
	Offset: 0x2D68
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b7fe306e(entity)
{
	/#
		function_752a64b8("");
	#/
	entity.var_86f9cdcd = 0;
	function_645a432b(entity);
}

/*
	Name: function_f01e64d6
	Namespace: namespace_823c357e
	Checksum: 0xCF232741
	Offset: 0x2DC0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f01e64d6(entity)
{
	/#
		function_752a64b8("");
	#/
}

/*
	Name: function_36903815
	Namespace: namespace_823c357e
	Checksum: 0xE1397770
	Offset: 0x2DF8
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_36903815(entity)
{
	/#
		function_752a64b8("");
	#/
	entity clientfield::set("stoker_fx_start_clientfield", 7);
}

/*
	Name: function_aae7916a
	Namespace: namespace_823c357e
	Checksum: 0x442F8148
	Offset: 0x2E50
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_aae7916a(entity)
{
	if(zm_behavior::zombieshouldstun(entity))
	{
		return true;
	}
	if(zm_behavior::zombieshouldknockdown(entity))
	{
		return true;
	}
	return false;
}

/*
	Name: function_dee90338
	Namespace: namespace_823c357e
	Checksum: 0xA0E41721
	Offset: 0x2EA8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_dee90338(entity)
{
	/#
		function_752a64b8("");
	#/
}

/*
	Name: function_b6e7676d
	Namespace: namespace_823c357e
	Checksum: 0x2E5BA2A3
	Offset: 0x2EE0
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b6e7676d(entity)
{
	/#
		function_752a64b8("");
	#/
	entity.var_aca87abc = 0;
	if(function_aae7916a(entity))
	{
		entity clientfield::set("stoker_fx_stop_clientfield", 7);
	}
}

/*
	Name: function_20a3d8f6
	Namespace: namespace_823c357e
	Checksum: 0xEC255BB1
	Offset: 0x2F58
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_20a3d8f6(entity)
{
	/#
		function_752a64b8("");
	#/
	entity.var_907e6060 = 0;
	if(function_aae7916a(entity))
	{
		entity clientfield::set("stoker_fx_stop_clientfield", 7);
	}
}

/*
	Name: function_efbd6650
	Namespace: namespace_823c357e
	Checksum: 0xDB9DA606
	Offset: 0x2FD0
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_efbd6650(entity)
{
	entity.cp_level_blackstation_goto_centerbreadcrumb = 1;
}

/*
	Name: function_399815b2
	Namespace: namespace_823c357e
	Checksum: 0x53F00603
	Offset: 0x2FF8
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_399815b2(entity)
{
	entity.cp_level_blackstation_goto_centerbreadcrumb = undefined;
}

/*
	Name: function_60951874
	Namespace: namespace_823c357e
	Checksum: 0x3C2C6B95
	Offset: 0x3018
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_60951874(entity)
{
	if(self.var_dc32e381 >= entity ai::function_9139c839().var_20dea374)
	{
		/#
			function_752a64b8("");
		#/
		return true;
	}
	return false;
}

/*
	Name: function_b4ecc051
	Namespace: namespace_823c357e
	Checksum: 0xE8268EE
	Offset: 0x3078
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b4ecc051(entity, asmstatename)
{
	if(entity ai::is_stunned())
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_a2d1d120
	Namespace: namespace_823c357e
	Checksum: 0x86C23914
	Offset: 0x30B8
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a2d1d120(entity)
{
	/#
		function_752a64b8("");
	#/
	function_394c6870(entity);
}

/*
	Name: function_394c6870
	Namespace: namespace_823c357e
	Checksum: 0xCCF88022
	Offset: 0x3108
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_394c6870(entity)
{
	entity.var_5274eb5f = 0;
	entity.var_86f9cdcd = 0;
	entity.var_dc32e381 = 0;
	entity setblackboardattribute("_locomotion_speed", self.var_ce5d8e8f);
	entity clientfield::set("stoker_fx_stop_clientfield", 2);
}

/*
	Name: function_645a432b
	Namespace: namespace_823c357e
	Checksum: 0xE3BC8FE5
	Offset: 0x3188
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_645a432b(entity)
{
	entity.var_5274eb5f = 1;
	if(entity.var_d691409c)
	{
		entity.var_d691409c = 0;
	}
	else
	{
		entity.var_41f51cb4 = "stoker_charge_attack";
	}
	entity.lastattacktime = gettime();
	entity setblackboardattribute("_locomotion_speed", "locomotion_speed_sprint");
	entity clientfield::set("stoker_fx_start_clientfield", 2);
}

/*
	Name: function_f40b4833
	Namespace: namespace_823c357e
	Checksum: 0xE90F6AC2
	Offset: 0x3230
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f40b4833(entity)
{
	entity.var_907e6060 = 1;
	entity.var_aca87abc = 1;
	self.var_41f51cb4 = "stoker_ranged_attack";
	entity.lastattacktime = gettime();
}

/*
	Name: function_5878b360
	Namespace: namespace_823c357e
	Checksum: 0x666975E3
	Offset: 0x3280
	Size: 0x7E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5878b360(entity)
{
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	return distancesquared(entity.origin, entity.enemy.origin) <= (entity ai::function_9139c839().var_2512cf3b * entity ai::function_9139c839().var_2512cf3b);
}

/*
	Name: function_ac53cb4e
	Namespace: namespace_823c357e
	Checksum: 0x894927E2
	Offset: 0x3308
	Size: 0x82
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ac53cb4e(entity)
{
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	can_see = bullettracepassed(entity.origin + vectorscale((0, 0, 1), 36), entity.enemy.origin + vectorscale((0, 0, 1), 36), 0, undefined);
	return can_see;
}

/*
	Name: function_6d817d57
	Namespace: namespace_823c357e
	Checksum: 0xD8DACC2D
	Offset: 0x3398
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6d817d57(entity)
{
	if(isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area)
	{
		return 1;
	}
	return zm_behavior::zombieenteredplayable(entity);
}

/*
	Name: function_253c9e38
	Namespace: namespace_823c357e
	Checksum: 0x28C10500
	Offset: 0x33E0
	Size: 0x28C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_253c9e38(entity)
{
	timeelapsed = gettime() - entity.lastattacktime;
	if(entity.var_5274eb5f && timeelapsed > entity ai::function_9139c839().var_287805eb)
	{
		/#
			function_752a64b8("");
		#/
		function_394c6870(entity);
	}
	if(entity.var_d691409c)
	{
		/#
			function_752a64b8("");
		#/
		entity.var_86f9cdcd = 1;
		return;
	}
	if(timeelapsed > getdvarint(#"hash_3dfb66f92268c90f", entity ai::function_9139c839().var_d33d95d0))
	{
		if(timeelapsed > entity ai::function_9139c839().var_73070557 && entity.var_41f51cb4 == "stoker_ranged_attack" && isdefined(entity.var_c6e0686b) && entity.var_c6e0686b <= (entity ai::function_9139c839().var_20266c0d * entity ai::function_9139c839().var_20266c0d))
		{
			entity.var_86f9cdcd = 1;
		}
		else if(!entity.var_aca87abc && !entity.var_86f9cdcd && isdefined(entity getblackboardattribute("_locomotion_speed")) && entity getblackboardattribute("_locomotion_speed") != "locomotion_speed_sprint" && function_ac53cb4e(entity) && !entity.var_81d3587d && function_5878b360(entity))
		{
			/#
				function_752a64b8("");
			#/
			function_f40b4833(entity);
		}
	}
}

/*
	Name: function_b2602782
	Namespace: namespace_823c357e
	Checksum: 0xAEE20965
	Offset: 0x3678
	Size: 0x466
	Parameters: 1
	Flags: Linked
*/
function function_b2602782(entity)
{
	if(!isactor(entity) || !isdefined(entity.enemy))
	{
		return;
	}
	targetpos = entity.enemy.origin;
	launchpos = entity gettagorigin("j_wrist_le");
	var_ad804014 = entity ai::function_9139c839().var_accd767d;
	if(distancesquared(targetpos, entity.origin) > entity ai::function_9139c839().var_bf28a226 * entity ai::function_9139c839().var_bf28a226)
	{
		velocity = entity.enemy getvelocity();
		targetpos = targetpos + (velocity * entity ai::function_9139c839().var_10a1d059);
		var_a76a363d = math::randomsign() * randomint(var_ad804014);
		var_9b241db1 = math::randomsign() * randomint(var_ad804014);
		targetpos = targetpos + (var_a76a363d, var_9b241db1, 0);
		speed = length(velocity);
		if(speed > 0)
		{
			var_7ee6937e = vectornormalize((targetpos[0], targetpos[1], 0) - (launchpos[0], launchpos[1], 0));
			dot = vectordot(-1 * var_7ee6937e, velocity / speed);
			if(dot >= entity ai::function_9139c839().var_cd8b7a6c)
			{
				targetpos = targetpos + (((var_7ee6937e * dot) * speed) * entity ai::function_9139c839().var_322773b9);
			}
		}
	}
	targetpos = targetpos + (0, 0, entity ai::function_9139c839().var_f227d0d0);
	var_872c6826 = vectortoangles(targetpos - launchpos);
	angles = function_cc68801f(launchpos, targetpos, entity ai::function_9139c839().var_81da787, getdvarfloat(#"bg_lowgravity", 0));
	if(isdefined(angles) && angles[#"hash_1d5798eaa3bed36c"] > 0)
	{
		dir = anglestoforward((-1 * angles[#"hash_1d5798eaa3bed36c"], var_872c6826[1], var_872c6826[2]));
	}
	else
	{
		dir = anglestoforward(var_872c6826);
	}
	velocity = dir * entity ai::function_9139c839().var_81da787;
	grenade = entity magicgrenadetype(getweapon("stoker_coal_bomb"), launchpos, velocity);
}

/*
	Name: function_717a6538
	Namespace: namespace_823c357e
	Checksum: 0x2E6821B9
	Offset: 0x3AE8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_717a6538(entity)
{
	entity clientfield::set("stoker_fx_stop_clientfield", 7);
}

/*
	Name: function_6da30402
	Namespace: namespace_823c357e
	Checksum: 0xCC663295
	Offset: 0x3B20
	Size: 0x1A6
	Parameters: 10
	Flags: Linked
*/
function function_6da30402(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(isdefined(eattacker) && (isai(eattacker) && eattacker.archetype == #"stoker" && eattacker.team != self.team))
	{
		if(smeansofdeath == "MOD_GRENADE" || smeansofdeath == "MOD_GRENADE_SPLASH" || smeansofdeath == "MOD_BURNED")
		{
			eattacker.var_d691409c = 1;
		}
		if(weapon == getweapon(#"hash_758c92f7249cd780") && (isdefined(einflictor.cp_level_blackstation_goto_centerbreadcrumb) && einflictor.cp_level_blackstation_goto_centerbreadcrumb))
		{
			idamage = 150;
		}
		if(weapon == getweapon(#"stoker_coal_bomb"))
		{
			burnplayer::setplayerburning(1, 1, 1, eattacker, weapon);
		}
		return idamage;
	}
	return -1;
}

/*
	Name: function_8ef6771f
	Namespace: namespace_823c357e
	Checksum: 0xC634AC9E
	Offset: 0x3CD0
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8ef6771f(entity)
{
	entity.var_dc89435f = 1;
}

/*
	Name: function_e2e5eebf
	Namespace: namespace_823c357e
	Checksum: 0xFFA30AD0
	Offset: 0x3CF8
	Size: 0x3E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e2e5eebf(entity)
{
	entity.var_dc89435f = undefined;
	entity.var_1db5ef71 = gettime() + entity ai::function_9139c839().var_10d707f8;
}

/*
	Name: function_72339619
	Namespace: namespace_823c357e
	Checksum: 0xA99D61C7
	Offset: 0x3D40
	Size: 0xA8
	Parameters: 3
	Flags: Linked
*/
function function_72339619(spawner, s_spot, var_bc66d64b)
{
	var_9cc45d9e = zombie_utility::spawn_zombie(level.var_411746bd[0], "stoker", s_spot, var_bc66d64b);
	if(isdefined(var_9cc45d9e))
	{
		var_9cc45d9e.check_point_in_enabled_zone = &zm_utility::check_point_in_playable_area;
		var_9cc45d9e thread zombie_utility::round_spawn_failsafe();
		var_9cc45d9e thread function_4c2cb763(s_spot);
	}
	return var_9cc45d9e;
}

/*
	Name: function_4c2cb763
	Namespace: namespace_823c357e
	Checksum: 0x373A26AA
	Offset: 0x3DF0
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_4c2cb763(s_spot)
{
	if(isdefined(level.var_9fb8585a))
	{
		self thread [[level.var_9fb8585a]](s_spot);
	}
	if(isdefined(level.var_1ab8872e))
	{
		self thread [[level.var_1ab8872e]]();
	}
}

/*
	Name: function_2170ee7a
	Namespace: namespace_823c357e
	Checksum: 0x333A6821
	Offset: 0x3E50
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_2170ee7a()
{
	level.var_411746bd = getentarray("zombie_stoker_spawner", "script_noteworthy");
	if(level.var_411746bd.size == 0)
	{
		/#
			assertmsg("");
		#/
		return;
	}
	foreach(var_493d9bf8 in level.var_411746bd)
	{
		var_493d9bf8.is_enabled = 1;
		var_493d9bf8.script_forcespawn = 1;
		var_493d9bf8 spawner::add_spawn_function(&stoker_init);
	}
}

/*
	Name: stoker_init
	Namespace: namespace_823c357e
	Checksum: 0x75F8CC80
	Offset: 0x3F58
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function stoker_init()
{
	self function_2df052bb();
	self zm_score::function_82732ced();
	self.var_ab8f2b90 = 3;
	level thread zm_spawner::zombie_death_event(self);
}

/*
	Name: function_fa8be26d
	Namespace: namespace_823c357e
	Checksum: 0xC2E08B0E
	Offset: 0x3FC0
	Size: 0xAE
	Parameters: 12
	Flags: Linked, Private
*/
function private function_fa8be26d(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(attacker) && attacker.archetype === #"stoker" && self.team === attacker.team)
	{
		return 0;
	}
	return -1;
}

/*
	Name: killed_callback
	Namespace: namespace_823c357e
	Checksum: 0xBD01198A
	Offset: 0x4078
	Size: 0xC4
	Parameters: 1
	Flags: Linked, Private
*/
function private killed_callback(e_attacker)
{
	if(self.archetype != #"stoker")
	{
		return;
	}
	self val::set(#"stoker_death", "takedamage", 0);
	if(!isplayer(e_attacker))
	{
		return;
	}
	e_attacker util::delay(1.5, "death", &zm_audio::create_and_play_dialog, #"kill", #"stoker");
}

/*
	Name: spawn_single
	Namespace: namespace_823c357e
	Checksum: 0x756CFDFE
	Offset: 0x4148
	Size: 0x230
	Parameters: 3
	Flags: Linked
*/
function spawn_single(b_force_spawn = 0, var_eb3a8721, var_bc66d64b)
{
	if(!b_force_spawn && !function_30509b8c())
	{
		return undefined;
	}
	if(isdefined(var_eb3a8721))
	{
		s_spawn_loc = var_eb3a8721;
	}
	else
	{
		if(isdefined(level.stoker_spawn_func))
		{
			s_spawn_loc = [[level.stoker_spawn_func]]();
		}
		else if(level.zm_loc_types[#"stoker_location"].size > 0)
		{
			s_spawn_loc = array::random(level.zm_loc_types[#"stoker_location"]);
		}
	}
	if(!isdefined(s_spawn_loc))
	{
		/#
			if(getdvarint(#"hash_1f8efa579fee787c", 0))
			{
				iprintlnbold("");
			}
		#/
		return undefined;
	}
	ai = function_72339619(level.var_411746bd[0], undefined, var_bc66d64b);
	if(isdefined(ai))
	{
		ai forceteleport(s_spawn_loc.origin, s_spawn_loc.angles);
		if(isdefined(level.var_9e197b6))
		{
			ai thread [[level.var_9e197b6]](s_spawn_loc);
		}
		ai playsound(#"hash_63299a75a97f9678");
		function_6eac4ca1(ai, "spawn");
		self util::delay(3, "death", &zm_audio::function_bca32e49, "stoker", "cue_react");
	}
	return ai;
}

/*
	Name: function_30509b8c
	Namespace: namespace_823c357e
	Checksum: 0xC10086DF
	Offset: 0x4380
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_30509b8c()
{
	var_cd35bb62 = function_9d74a83a();
	var_74f3a5af = function_6dd277e7();
	if(!(isdefined(level.var_76934955) && level.var_76934955) && (isdefined(level.var_fe2bb2ac) && level.var_fe2bb2ac || var_cd35bb62 >= var_74f3a5af || !level flag::get("spawn_zombies")))
	{
		return false;
	}
	return true;
}

/*
	Name: function_6dd277e7
	Namespace: namespace_823c357e
	Checksum: 0xF187F03A
	Offset: 0x4448
	Size: 0xAA
	Parameters: 0
	Flags: Linked
*/
function function_6dd277e7()
{
	n_player_count = zm_utility::function_a2541519(level.players.size);
	switch(n_player_count)
	{
		case 1:
		{
			return 1;
			break;
		}
		case 2:
		{
			return 2;
			break;
		}
		case 3:
		{
			return 2;
			break;
		}
		case 4:
		{
			return 3;
			break;
		}
	}
}

/*
	Name: function_cf5ef033
	Namespace: namespace_823c357e
	Checksum: 0x9A1D2009
	Offset: 0x4500
	Size: 0x1B2
	Parameters: 1
	Flags: Linked
*/
function function_cf5ef033(n_round_number)
{
	level endon(#"end_game");
	if(!isdefined(level.var_ac8e1955))
	{
		level.var_ac8e1955 = 0;
	}
	/#
		switch(level.round_number - n_round_number)
		{
			case 0:
			{
				break;
			}
			case 1:
			case 2:
			{
				level.var_ac8e1955++;
				break;
			}
			case 3:
			case 4:
			{
				level.var_ac8e1955 = level.var_ac8e1955 + 2;
				break;
			}
			default:
			{
				level.var_ac8e1955 = undefined;
				return;
			}
		}
	#/
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(namespace_c3287616::function_d0db51fc(#"stoker"))
		{
			level.var_ac8e1955++;
			if(level.var_ac8e1955 == 3)
			{
				level.var_ac8e1955 = undefined;
				level.var_a21ee6fc = undefined;
				return;
			}
			level.var_a21ee6fc = level.round_number + function_21a3a673(1, 2);
		}
	}
}

/*
	Name: function_b381320
	Namespace: namespace_823c357e
	Checksum: 0x95D53FC3
	Offset: 0x46C0
	Size: 0x1DA
	Parameters: 1
	Flags: Linked
*/
function function_b381320(var_dbce0c44)
{
	var_8cf00d40 = int(floor(var_dbce0c44 / 100));
	if(isdefined(level.var_a21ee6fc) && level.round_number < level.var_a21ee6fc)
	{
		return 0;
	}
	if(level.players.size == 1)
	{
		var_1797c23a = 1 + (max(0, floor((level.round_number - zombie_utility::function_d2dfacfd(#"hash_2374f3ef775ac2c3")) / 4)));
	}
	else
	{
		var_1797c23a = 1 + (max(0, floor((level.round_number - zombie_utility::function_d2dfacfd(#"hash_3b4ad7449c039d1b")) / 3)));
	}
	var_2506688 = (var_1797c23a > 8 ? var_1797c23a * 0.75 : max(var_1797c23a - 3, 0));
	return function_21a3a673(int(var_2506688), int(min(var_8cf00d40, var_1797c23a)));
}

/*
	Name: round_spawn
	Namespace: namespace_823c357e
	Checksum: 0xBECFDAA9
	Offset: 0x48A8
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	ai = spawn_single();
	if(isdefined(ai))
	{
		level.zombie_total--;
		return true;
	}
	return false;
}

/*
	Name: function_9d74a83a
	Namespace: namespace_823c357e
	Checksum: 0x2BEA6AB8
	Offset: 0x48F0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_9d74a83a()
{
	var_35576160 = getaiarchetypearray(#"stoker");
	var_cd35bb62 = var_35576160.size;
	foreach(var_9cc45d9e in var_35576160)
	{
		if(!isalive(var_9cc45d9e))
		{
			var_cd35bb62--;
		}
	}
	return var_cd35bb62;
}

/*
	Name: function_f5f699aa
	Namespace: namespace_823c357e
	Checksum: 0x95F389A4
	Offset: 0x49B8
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f5f699aa()
{
	var_16049422 = spawn_single(1);
	return isdefined(var_16049422);
}

/*
	Name: function_a92dac75
	Namespace: namespace_823c357e
	Checksum: 0x796D938B
	Offset: 0x49F0
	Size: 0x74
	Parameters: 0
	Flags: Private
*/
function private function_a92dac75()
{
	/#
		level flagsys::wait_till("");
		zm_devgui::add_custom_devgui_callback(&function_963e8ce);
		spawner::add_archetype_spawn_function(#"stoker", &function_16c9b795);
	#/
}

/*
	Name: function_16c9b795
	Namespace: namespace_823c357e
	Checksum: 0x44EE94F8
	Offset: 0x4A70
	Size: 0xB2
	Parameters: 0
	Flags: Private
*/
function private function_16c9b795()
{
	/#
		if(isdefined(level.var_910d20f6) && level.var_910d20f6)
		{
			return;
		}
		adddebugcommand(("" + getdvarint(#"hash_3dfb66f92268c90f", self ai::function_9139c839().var_d33d95d0)) + "");
		adddebugcommand("");
		level.var_910d20f6 = 1;
	#/
}

/*
	Name: function_963e8ce
	Namespace: namespace_823c357e
	Checksum: 0xA28D5337
	Offset: 0x4B30
	Size: 0x278
	Parameters: 1
	Flags: Private
*/
function private function_963e8ce(cmd)
{
	/#
		if(cmd == "")
		{
			player = level.players[0];
			v_direction = player getplayerangles();
			v_direction = anglestoforward(v_direction) * 8000;
			eye = player geteye();
			trace = bullettrace(eye, eye + v_direction, 0, undefined);
			var_380c580a = positionquery_source_navigation(trace[#"position"], 128, 256, 128, 20);
			s_spot = spawnstruct();
			if(isdefined(var_380c580a) && var_380c580a.data.size > 0)
			{
				s_spot.origin = var_380c580a.data[0].origin;
			}
			else
			{
				s_spot.origin = player.origin;
			}
			s_spot.angles = (0, player.angles[1] - 180, 0);
			spawn_single(1, s_spot);
			return true;
		}
		if(cmd == "")
		{
			stokers = getaiarchetypearray(#"stoker");
			foreach(stoker in stokers)
			{
				stoker kill();
			}
		}
	#/
}

/*
	Name: update_dvars
	Namespace: namespace_823c357e
	Checksum: 0xE8E74C19
	Offset: 0x4DB0
	Size: 0x48
	Parameters: 0
	Flags: None
*/
function update_dvars()
{
	/#
		while(true)
		{
			level.var_71be6cf4 = getdvarint(#"hash_6eb238066515a9c9", 0);
			wait(1);
		}
	#/
}

/*
	Name: function_752a64b8
	Namespace: namespace_823c357e
	Checksum: 0x40C531C7
	Offset: 0x4E00
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function function_752a64b8(message)
{
	/#
		if(isdefined(level.var_71be6cf4))
		{
			println("" + message);
		}
	#/
}

