// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_loadout.gsc;
#using script_178024232e91b0a1;
#using scripts\zm_common\zm_transformation.gsc;
#using script_24c32478acf44108;
#using script_2c5daa95f8fec03c;
#using scripts\core_common\ai\archetype_mocomps_utility.gsc;
#using script_35598499769dbb3d;
#using scripts\zm_common\trials\zm_trial_special_enemy.gsc;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_41fe08c37d53a635;
#using scripts\zm\weapons\zm_weap_riotshield.gsc;
#using script_489b835a247c990e;
#using scripts\core_common\ai\archetype_blight_father.gsc;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using scripts\zm_common\zm_lockdown_util.gsc;
#using script_522aeb6ae906391e;
#using scripts\zm_common\trials\zm_trial_force_archetypes.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\zm_common\zm_round_spawning.gsc;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\archetype_blight_father_interface.gsc;
#using scripts\core_common\ai\archetype_utility.gsc;
#using scripts\zm_common\zm_round_logic.gsc;
#using script_71dfbfdfba4489a0;
#using script_7b7ed6e4bc963a51;
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\core_common\ai\zombie.gsc;
#using script_caf007e2a98afa2;
#using script_db06eb511bd9b36;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_grappler.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_ai_blight_father;

/*
	Name: __init__system__
	Namespace: zm_ai_blight_father
	Checksum: 0x3623997B
	Offset: 0xBC8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_blight_father", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_ai_blight_father
	Checksum: 0xF7A8FA31
	Offset: 0xC10
	Size: 0x9CA
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"blight_father", &function_7c52f40);
	spawner::function_89a2cd87(#"blight_father", &function_95a6fbef);
	zm_utility::function_d0f02e71(#"blight_father");
	callback::on_spawned(&on_player_spawned);
	function_ce1b7f67();
	clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_purchase_lockdown_vomit_fx", 1, 3, "int");
	clientfield::register("toplayer", "tongueGrabPostFx", 1, 1, "int");
	clientfield::register("toplayer", "tongueGrabRumble", 1, 1, "int");
	clientfield::register("actor", "blight_father_vomit_fx", 1, 2, "int");
	clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter");
	clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter");
	clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int");
	clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter");
	clientfield::register("toplayer", "blight_father_vomit_postfx_clientfield", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int");
	clientfield::register("actor", "blight_father_death_fx", 17000, 6, "int");
	level thread aat::register_immunity("zm_aat_brain_decay", #"blight_father", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"blight_father", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"blight_father", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"blight_father", 1, 1, 1);
	blight_father_spawner = getent("zombie_spawner_blight_father", "targetname");
	zm_transform::function_cfca77a7(blight_father_spawner, #"blight_father", &function_39212989, 10, &function_3a0cdf7f, &function_8e4c43d3, "aib_vign_zm_zod_bltfthr_spawn_pre_split", "aib_vign_zm_zod_bltfthr_spawn_post_split");
	zm_spawner::register_zombie_death_event_callback(&killed_callback);
	callback::on_ai_killed(&function_7bef9c3c);
	zm_round_spawning::register_archetype(#"blight_father", &function_633d7436, &round_spawn, undefined, 300);
	zm_round_spawning::function_306ce518(#"blight_father", &function_fa00e485);
	zm_cleanup::function_cdf5a512(#"blight_father", &function_2628e1c2);
	if(-1)
	{
		level.var_445e24c8 = [];
		for(i = 0; i < 12; i++)
		{
			trigger = spawn("trigger_damage", (0, 0, 0), 0, 40, 40);
			trigger enablelinkto();
			trigger.inuse = 0;
			trigger triggerenable(0);
			if(!isdefined(level.var_445e24c8))
			{
				level.var_445e24c8 = [];
			}
			else if(!isarray(level.var_445e24c8))
			{
				level.var_445e24c8 = array(level.var_445e24c8);
			}
			level.var_445e24c8[level.var_445e24c8.size] = trigger;
		}
	}
	level.var_c2981ce9 = [#"tag_eggsack_weakspot_ri":&function_33b2c99e, #"tag_eggsack_weakspot_le":&function_40034805, #"tag_elbow_weakspot_ri":&function_5a1a4ad, #"tag_elbow_weakspot_le":&function_9bbe631c, #"tag_mouth_weakspot":&function_fa7c080];
	zm_ai_utility::function_2ad308c4(#"blight_father", &function_744be31d);
	zm_trial_special_enemy::function_95c1dd81(#"blight_father", &function_2315440d);
	namespace_9ff9f642::register_slowdown(#"hash_2fd5f5f16583a427", 0.8);
	callback::add_callback(#"hash_4d2043b190b84792", &function_ef860973);
	callback::add_callback(#"hash_137b937fd26992be", &function_6fa41b21);
	level.var_fcb96175 = 0;
	/#
		spawner::add_archetype_spawn_function(#"blight_father", &zombie_utility::updateanimationrate);
		level thread function_a2751530();
	#/
	level.var_a51ca41a = 0;
}

/*
	Name: function_3e8300e9
	Namespace: zm_ai_blight_father
	Checksum: 0xE81B0E3C
	Offset: 0x15E8
	Size: 0x7C
	Parameters: 4
	Flags: Linked, Private
*/
function private function_3e8300e9(entity, attribute, oldvalue, value)
{
	if(value == "low")
	{
		entity thread namespace_9ff9f642::slowdown(#"hash_2fd5f5f16583a427");
	}
	else
	{
		entity thread namespace_9ff9f642::function_520f4da5(#"hash_2fd5f5f16583a427");
	}
}

/*
	Name: on_player_spawned
	Namespace: zm_ai_blight_father
	Checksum: 0x7AF46FBC
	Offset: 0x1670
	Size: 0x12
	Parameters: 0
	Flags: Linked, Private
*/
function private on_player_spawned()
{
	self.grapple_tag = "j_mainroot";
}

/*
	Name: function_ce1b7f67
	Namespace: zm_ai_blight_father
	Checksum: 0x80F724D1
	Offset: 0x1690
	Size: 0x4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ce1b7f67()
{
}

/*
	Name: function_7c52f40
	Namespace: zm_ai_blight_father
	Checksum: 0x1C1858B
	Offset: 0x16A0
	Size: 0x668
	Parameters: 0
	Flags: Linked, Private
*/
function private function_7c52f40()
{
	self endon(#"death");
	self.zombie_move_speed = "sprint";
	self zombie_utility::function_df5afb5e(0);
	if(!(isdefined(level.var_a2831281) && level.var_a2831281) && !zm_trial_special_enemy::is_active() && !zm_trial_force_archetypes::function_ff2a74e7(#"blight_father") && (!(isdefined(level.var_f300b600) && level.var_f300b600)))
	{
		self.ignore_enemy_count = 1;
	}
	self.var_77f481e1 = 1;
	self.var_126d7bef = 1;
	self.ignore_nuke = 1;
	self.lightning_chain_immune = 1;
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.var_f46fbf3f = 1;
	self.no_powerups = 1;
	self.var_2703428f = self ai::function_9139c839().var_fc5eff78;
	self attach("c_t8_zmb_blightfather_mouth");
	self attach("c_t8_zmb_blightfather_elbow1_le");
	self attach("c_t8_zmb_blightfather_elbow1_ri");
	self attach("c_t8_zmb_blightfather_eggsack1_both");
	self attach("c_t8_zmb_blightfather_tongue2");
	self hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	aiutility::addaioverridedamagecallback(self, &function_afce1cf);
	aiutility::addaioverridedamagecallback(self, &function_515b4a87);
	self.var_f7c29bc4 = gettime() + self ai::function_9139c839().var_eed65399;
	self.var_e6c8672d = 1;
	self.grapple_tag = "tag_jaw";
	self.var_c8088bcb = {#timestamp:gettime(), #traces:[]};
	self.var_b2a80abc = gettime() + self ai::function_9139c839().var_f246f6de;
	self.var_acfc1c7c = &function_76c1f56f;
	self.var_80cf70fb = &function_3e8300e9;
	self.var_11a49434 = &function_c90a5ebb;
	self.closest_player_override = &zm_utility::function_c52e1749;
	self.var_72411ccf = &function_911c3934;
	self.var_ee833cd6 = &function_ee833cd6;
	self.cant_move_cb = &zombiebehavior::function_79fe956f;
	self.should_zigzag = 0;
	self.var_ab8f2b90 = 5;
	self.completed_emerging_into_playable_area = 1;
	self.ignorepathenemyfightdist = 1;
	self.var_81eb8127 = &function_babdb8e7;
	self.var_a4a10040 = &function_cf18d183;
	self.var_e38eaee5 = gettime();
	if(!isdefined(self.var_506922ab))
	{
		self.var_506922ab = [];
	}
	if(!isdefined(self.var_506922ab))
	{
		self.var_506922ab = [];
	}
	else if(!isarray(self.var_506922ab))
	{
		self.var_506922ab = array(self.var_506922ab);
	}
	self.var_506922ab[self.var_506922ab.size] = &function_36b05ed0;
	self allowpitchangle(1);
	self setpitchorient();
	level thread zm_spawner::zombie_death_event(self);
	self thread zm_utility::update_zone_name();
	self thread zm_audio::play_ambient_zombie_vocals();
	self collidewithactors(1);
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	if(!isdefined(level.var_6213dc32))
	{
		level.var_6213dc32 = getweapon("zombie_ai_defaultmelee");
	}
	util::wait_network_frame();
	self clientfield::set("blight_father_weakpoint_l_elbow_fx", 1);
	self clientfield::set("blight_father_weakpoint_r_elbow_fx", 1);
	self clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 1);
	self clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 1);
	self clientfield::set("blight_father_weakpoint_jaw_fx", 1);
	self clientfield::set("blight_father_amb_sac_clientfield", 1);
	target_set(self);
	level.var_a51ca41a++;
}

/*
	Name: function_95a6fbef
	Namespace: zm_ai_blight_father
	Checksum: 0x9BE1C24D
	Offset: 0x1D10
	Size: 0xFC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_95a6fbef()
{
	self.maxhealth = int(self zm_ai_utility::function_8d44707e(1, self._starting_round_number) * (isdefined(level.var_9503486c) ? level.var_9503486c : 1));
	self.health = self.maxhealth;
	namespace_81245006::initweakpoints(self, #"c_t8_zmb_blightfather_weakpoint_def");
	zm_score::function_e5d6e6dd(#"blight_father", self ai::function_9139c839().var_bd058b07);
	self zm_score::function_82732ced();
	/#
		function_f8411b4d(self);
	#/
}

/*
	Name: function_36b05ed0
	Namespace: zm_ai_blight_father
	Checksum: 0xEA51D29E
	Offset: 0x1E18
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_36b05ed0(entity)
{
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	entity.var_fbec06fa = undefined;
	entity.knockdown = undefined;
	var_65ba9602 = zm_lockdown_util::function_87c1193e(entity);
	if(isdefined(var_65ba9602))
	{
		zm_lockdown_util::function_77caff8b(var_65ba9602);
		entity.var_3acacb18 = undefined;
		entity.b_ignore_cleanup = entity.var_ca0d8389;
		entity.var_ca0d8389 = undefined;
	}
	entity thread function_d67c455e();
	function_c526065b(entity);
}

/*
	Name: killed_callback
	Namespace: zm_ai_blight_father
	Checksum: 0xE63508DE
	Offset: 0x1F00
	Size: 0xDC
	Parameters: 1
	Flags: Linked, Private
*/
function private killed_callback(e_attacker)
{
	if(self.archetype != #"blight_father")
	{
		return;
	}
	self clientfield::set("blight_father_amb_sac_clientfield", 0);
	if(!isplayer(e_attacker))
	{
		return;
	}
	if(level flag::get("zombie_drop_powerups") && !zm_utility::is_standard())
	{
		self thread zm_powerups::specific_powerup_drop(self.var_d0686fde, self.origin, undefined, undefined, undefined, undefined, undefined, undefined, 0, 1);
	}
}

/*
	Name: function_7bef9c3c
	Namespace: zm_ai_blight_father
	Checksum: 0x225B8235
	Offset: 0x1FE8
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7bef9c3c(params)
{
	if(self.archetype !== #"blight_father")
	{
		return;
	}
	self function_76c1f56f();
}

/*
	Name: function_ee833cd6
	Namespace: zm_ai_blight_father
	Checksum: 0x72C13D87
	Offset: 0x2030
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_ee833cd6()
{
	self.completed_emerging_into_playable_area = 1;
}

/*
	Name: function_2628e1c2
	Namespace: zm_ai_blight_father
	Checksum: 0xF0DDEDC8
	Offset: 0x2050
	Size: 0x288
	Parameters: 0
	Flags: Linked
*/
function function_2628e1c2()
{
	if(!isdefined(level.var_801efcc7))
	{
		level.var_801efcc7 = struct::get_array("blight_father_location", "script_noteworthy");
	}
	if(level.var_801efcc7.size < 1)
	{
		self.b_ignore_cleanup = 1;
		return true;
	}
	if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area"))
	{
		self.b_ignore_cleanup = 1;
		return true;
	}
	var_31f7011a = arraycopy(level.players);
	var_31f7011a = arraysortclosest(var_31f7011a, self.origin);
	i = 0;
	var_b2aa54a9 = level.var_801efcc7[0];
	var_56feeec4 = distancesquared(var_31f7011a[0].origin, var_b2aa54a9.origin);
	foreach(var_d7eff26a in level.var_801efcc7)
	{
		if(!zm_utility::is_player_valid(var_31f7011a[i]))
		{
			i++;
			if(i >= var_31f7011a.size)
			{
				i = 0;
				util::wait_network_frame();
			}
			continue;
		}
		var_e8ab126e = distancesquared(var_31f7011a[i].origin, var_d7eff26a.origin);
		if(var_e8ab126e < var_56feeec4)
		{
			var_56feeec4 = var_e8ab126e;
			var_b2aa54a9 = var_d7eff26a;
		}
	}
	if(!isdefined(self))
	{
		return;
	}
	self zm_ai_utility::function_a8dc3363(var_b2aa54a9);
	return true;
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: zm_ai_blight_father
	Checksum: 0xA4A1B41
	Offset: 0x22E0
	Size: 0x1174
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_2784f3ff));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_148b4066ca34ac7d", &function_2784f3ff);
	/#
		assert(isscriptfunctionptr(&function_d6ded650));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5c96eb204e351d55", &function_d6ded650);
	/#
		assert(isscriptfunctionptr(&function_d6fbf1b7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7121da36951eb072", &function_d6fbf1b7);
	/#
		assert(isscriptfunctionptr(&function_1d9f449a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_32703c2c1d28f6f8", &function_1d9f449a);
	/#
		assert(isscriptfunctionptr(&function_2ed4a174));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_68ad8f05c187147e", &function_2ed4a174);
	/#
		assert(isscriptfunctionptr(&function_e1ba6416));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2fa134b71f113f7a", &function_e1ba6416);
	/#
		assert(isscriptfunctionptr(&function_8383fdf9));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73649a2d01c11f41", &function_8383fdf9);
	/#
		assert(isscriptfunctionptr(&blightfathershouldmelee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldmelee", &blightfathershouldmelee);
	/#
		assert(isscriptfunctionptr(&blightfathershouldshowpain));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldshowpain", &blightfathershouldshowpain);
	/#
		assert(isscriptfunctionptr(&function_3515ad4b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_41aa80b14334caac", &function_3515ad4b);
	/#
		assert(isscriptfunctionptr(&function_aaad8487));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_124ccb4b34a00c0f", &function_aaad8487);
	/#
		assert(isscriptfunctionptr(&function_4bd1c37e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_667d737e6c9aba40", &function_4bd1c37e);
	/#
		assert(isscriptfunctionptr(&blightfatherdeathstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherdeathstart", &blightfatherdeathstart);
	/#
		assert(isscriptfunctionptr(&function_1177eb85));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7ef0bb5832b7989d", &function_1177eb85);
	/#
		assert(isscriptfunctionptr(&function_d5a0a1eb));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1db7e3af327c9b04", &function_d5a0a1eb);
	/#
		assert(isscriptfunctionptr(&function_e0d8f770));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7817d265f22976fd", &function_e0d8f770);
	/#
		assert(isscriptfunctionptr(&function_f108c0ea));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_21c5672c06f01755", &function_f108c0ea);
	/#
		assert(isscriptfunctionptr(&function_b5b42347));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45f5d3d442f48795", &function_b5b42347);
	/#
		assert(isscriptfunctionptr(&function_283b9654));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3598ca6c9a0b1b1", &function_283b9654);
	/#
		assert(isscriptfunctionptr(&function_173d7fb2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4913708f18cd3e3e", &function_173d7fb2);
	/#
		assert(isscriptfunctionptr(&function_bc3eb15a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6a7eedc191a3f371", &function_bc3eb15a);
	/#
		assert(isscriptfunctionptr(&function_1dac0714));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_ae71931f5fb12d8", &function_1dac0714);
	/#
		assert(isscriptfunctionptr(&function_fc84db95));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_23b3b2b5a3230cc5", &function_fc84db95);
	/#
		assert(isscriptfunctionptr(&function_8d9b9683));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77b88d91d0990898", &function_8d9b9683);
	/#
		assert(isscriptfunctionptr(&function_d83ac1e7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e5059e0839da879", &function_d83ac1e7);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_b62014ac) || isscriptfunctionptr(&function_b62014ac));
	#/
	/#
		assert(!isdefined(&function_928e66ad) || isscriptfunctionptr(&function_928e66ad));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7ebcf0c2d647b3a2", undefined, &function_b62014ac, &function_928e66ad);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_8cbef8fd) || isscriptfunctionptr(&function_8cbef8fd));
	#/
	/#
		assert(!isdefined(&function_928e66ad) || isscriptfunctionptr(&function_928e66ad));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_efb5b2c25a5b7cb", undefined, &function_8cbef8fd, &function_928e66ad);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_fa33f4aa) || isscriptfunctionptr(&function_fa33f4aa));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7b6603199659e6ff", undefined, &function_fa33f4aa, undefined);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_tongue_grab_launch", &function_28dddd64);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_vomit_start", &function_7a634eaa);
	animationstatenetwork::registernotetrackhandlerfunction("fire_left", &function_d2b91209);
	animationstatenetwork::registernotetrackhandlerfunction("fire_right", &function_78f5c48e);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_melee", &function_ac921de9);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_show_tongue", &function_51ead3e8);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_hide_tongue", &function_bb6aa70c);
	animationstatenetwork::registernotetrackhandlerfunction("blightfather_explode", &function_b78adc65);
	animationstatenetwork::registeranimationmocomp("mocomp_purchase_lockdown_vomit@blight_father", &function_6ab8460f, undefined, undefined);
	animationstatenetwork::registeranimationmocomp("mocomp_grapple_attack_launch@blight_father", &function_299dd40e, &function_689831cf, &function_42de48fb);
	/#
		assert(isscriptfunctionptr(&function_7055b26));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3ab9ffa56496f9a1", &function_7055b26);
	/#
		assert(isscriptfunctionptr(&function_f2914d65));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_116b298d64ab0478", &function_f2914d65);
	/#
		assert(isscriptfunctionptr(&function_563d56de));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7156796e4e9cd68", &function_563d56de);
	/#
		assert(isscriptfunctionptr(&function_b3f66ac3));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7a04596792c5199d", &function_b3f66ac3);
	/#
		assert(isscriptfunctionptr(&function_1d2646));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_435c602040220705", &function_1d2646);
	/#
		assert(isscriptfunctionptr(&function_62b3b7a3));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_483c1950bc1df07f", &function_62b3b7a3);
}

/*
	Name: function_b78adc65
	Namespace: zm_ai_blight_father
	Checksum: 0x86A99AB2
	Offset: 0x3460
	Size: 0x1C4
	Parameters: 1
	Flags: Linked
*/
function function_b78adc65(entity)
{
	if(entity isragdoll())
	{
		entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
		if(entity isattached("c_t8_zmb_blightfather_eggsack1_both"))
		{
			entity detach("c_t8_zmb_blightfather_eggsack1_both");
		}
		else
		{
			if(entity isattached("c_t8_zmb_blightfather_eggsack1_le"))
			{
				entity detach("c_t8_zmb_blightfather_eggsack1_le");
			}
			else if(entity isattached("c_t8_zmb_blightfather_eggsack1_ri"))
			{
				entity detach("c_t8_zmb_blightfather_eggsack1_ri");
			}
		}
		entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
		return;
	}
	if(isdefined(entity.gib_model))
	{
		entity.gib_model clientfield::set("blight_father_gib_explosion", 1);
		entity.gib_model stopanimscripted(0, 1);
		entity.gib_model startragdoll();
	}
	entity delete();
}

/*
	Name: function_529b7fb9
	Namespace: zm_ai_blight_father
	Checksum: 0xB8D9CDF0
	Offset: 0x3630
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_529b7fb9()
{
	self endon(#"death");
	level waittilltimeout(300, #"clear_all_corpses");
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_4589bd24
	Namespace: zm_ai_blight_father
	Checksum: 0x94A8661C
	Offset: 0x3688
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function function_4589bd24()
{
	if(isdefined(self.favoriteenemy))
	{
		predictedpos = self lastknownpos(self.favoriteenemy);
		if(isdefined(predictedpos))
		{
			turnyaw = absangleclamp360(self.angles[1] - (vectortoangles(predictedpos - self.origin)[1]));
			return turnyaw;
		}
	}
	return undefined;
}

/*
	Name: function_753b4884
	Namespace: zm_ai_blight_father
	Checksum: 0x5D9214B
	Offset: 0x3720
	Size: 0x18E
	Parameters: 0
	Flags: Linked
*/
function function_753b4884()
{
	if(zm_lockdown_util::function_7bfa8895(self))
	{
		stub = zm_lockdown_util::function_87c1193e(self);
		var_4afb24b6 = zm_lockdown_util::function_dab6d796(self, stub);
		if(isdefined(var_4afb24b6))
		{
			turnyaw = absangleclamp360(self.angles[1] - (vectortoangles(var_4afb24b6.origin - self.origin)[1]));
		}
		else
		{
			/#
				println(((((((("" + self getentitynumber()) + "") + self.origin[0]) + "") + self.origin[1]) + "") + self.origin[2]) + "");
			#/
			turnyaw = absangleclamp360(self.angles[1] - (vectortoangles(stub.origin - self.origin)[1]));
		}
		return turnyaw;
	}
	return undefined;
}

/*
	Name: function_f2914d65
	Namespace: zm_ai_blight_father
	Checksum: 0x23E62144
	Offset: 0x38B8
	Size: 0x12A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f2914d65(entity)
{
	enemies = getaiarchetypearray(#"zombie");
	enemies = arraycombine(enemies, getaiarchetypearray(#"catalyst"), 0, 0);
	enemies = array::filter(enemies, 0, &function_3d752709, entity);
	foreach(enemy in enemies)
	{
		enemy zombie_utility::setup_zombie_knockdown(entity);
		enemy.knockdown_type = "knockdown_shoved";
	}
}

/*
	Name: function_3d752709
	Namespace: zm_ai_blight_father
	Checksum: 0x3E2D4713
	Offset: 0x39F0
	Size: 0x1A8
	Parameters: 2
	Flags: Linked, Private
*/
function private function_3d752709(enemy, target)
{
	if(isdefined(enemy.knockdown) && enemy.knockdown)
	{
		return false;
	}
	if(gibserverutils::isgibbed(enemy, 384))
	{
		return false;
	}
	if(distancesquared(enemy.origin, target.origin) > self ai::function_9139c839().var_2e53b0a6 * self ai::function_9139c839().var_2e53b0a6)
	{
		return false;
	}
	facingvec = anglestoforward(target.angles);
	enemyvec = enemy.origin - target.origin;
	var_3e3c8075 = (enemyvec[0], enemyvec[1], 0);
	var_c2ee8451 = (facingvec[0], facingvec[1], 0);
	var_3e3c8075 = vectornormalize(var_3e3c8075);
	var_c2ee8451 = vectornormalize(var_c2ee8451);
	var_34e02165 = vectordot(var_c2ee8451, var_3e3c8075);
	if(var_34e02165 < 0)
	{
		return false;
	}
	return true;
}

/*
	Name: function_69b8daf
	Namespace: zm_ai_blight_father
	Checksum: 0x1FA84BA7
	Offset: 0x3BA0
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_69b8daf(origin, angles)
{
	fx_model = util::spawn_model(#"tag_origin", origin, angles);
	return fx_model;
}

/*
	Name: blightfathershouldshowpain
	Namespace: zm_ai_blight_father
	Checksum: 0xBA25FC73
	Offset: 0x3BF8
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private blightfathershouldshowpain(entity)
{
	if(isdefined(entity.var_fbec06fa))
	{
		return true;
	}
	return false;
}

/*
	Name: function_8d9b9683
	Namespace: zm_ai_blight_father
	Checksum: 0xDD19BD4C
	Offset: 0x3C28
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8d9b9683(entity)
{
	function_173d7fb2(entity);
	entity thread function_d67c455e();
	function_c526065b(entity);
}

/*
	Name: function_3515ad4b
	Namespace: zm_ai_blight_father
	Checksum: 0xC58C1B9F
	Offset: 0x3C88
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3515ad4b(entity)
{
	return blightfathershouldshowpain(entity) || zm_behavior::zombieshouldstun(entity) || function_2ed4a174(entity) || zm_behavior::zombieshouldknockdown(entity);
}

/*
	Name: function_173d7fb2
	Namespace: zm_ai_blight_father
	Checksum: 0x8B008E4E
	Offset: 0x3D00
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
function private function_173d7fb2(entity)
{
	entity.var_fbec06fa = undefined;
	entity.var_cdc2bec8 = undefined;
}

/*
	Name: function_515b4a87
	Namespace: zm_ai_blight_father
	Checksum: 0xFBC25E61
	Offset: 0x3D30
	Size: 0x178
	Parameters: 12
	Flags: Linked, Private
*/
function private function_515b4a87(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(!(isdefined(self.var_c8f98f87) && self.var_c8f98f87) && isdefined(self.e_grapplee) && (hitloc == "head" || attacker === self.e_grapplee))
	{
		if(!isdefined(self.var_cdc2bec8))
		{
			self.var_cdc2bec8 = 0;
		}
		self.var_cdc2bec8 = self.var_cdc2bec8 + damage;
		if(function_2ed4a174(self))
		{
			self.var_eb3ff149 = inflictor;
		}
	}
	if(!(isdefined(self.var_c8f98f87) && self.var_c8f98f87) && isdefined(self.e_grapplee) && (zm_loadout::is_hero_weapon(weapon) || meansofdamage === "MOD_PROJECTILE"))
	{
		self ai::stun();
	}
	return damage;
}

/*
	Name: function_76c1f56f
	Namespace: zm_ai_blight_father
	Checksum: 0x6A7CB883
	Offset: 0x3EB0
	Size: 0x34
	Parameters: 0
	Flags: Linked, Private
*/
function private function_76c1f56f()
{
	function_c526065b(self);
	self thread function_d67c455e();
}

/*
	Name: function_cf18d183
	Namespace: zm_ai_blight_father
	Checksum: 0xE3322AD9
	Offset: 0x3EF0
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cf18d183(grapplee)
{
	if(isdefined(grapplee) && isplayer(grapplee))
	{
		grapplee clientfield::set_to_player("tongueGrabPostFx", 0);
		grapplee clientfield::set_to_player("tongueGrabRumble", 0);
	}
}

/*
	Name: blightfatherdeathstart
	Namespace: zm_ai_blight_father
	Checksum: 0xF63CA62E
	Offset: 0x3F68
	Size: 0x214
	Parameters: 1
	Flags: Linked, Private
*/
function private blightfatherdeathstart(entity)
{
	entity val::set(#"blight_father_death", "takedamage", 0);
	if(level.var_79b2615b === entity)
	{
		level.var_79b2615b = undefined;
	}
	if(entity isattached("c_t8_zmb_blightfather_tongue2", "tag_tongue_grab"))
	{
		entity detach("c_t8_zmb_blightfather_tongue2");
	}
	if(!entity isragdoll())
	{
		gib_model = util::spawn_anim_model("c_t8_zmb_blightfather_body1_gib", entity.origin, entity.angles);
		if(!isdefined(gib_model))
		{
			return;
		}
		gib_model animscripted(#"hash_56a346d1e0dd61cd", gib_model.origin, gib_model.angles, #"hash_3e937fff0e0a4362", "normal");
		gib_model thread function_529b7fb9();
		entity.gib_model = gib_model;
	}
	attacker = entity.attacker;
	if(isdefined(attacker) && isplayer(attacker))
	{
		weapon = attacker getcurrentweapon();
		if(attacker hasweapon(weapon))
		{
			var_81316a8a = attacker function_b1298bfb(weapon);
			entity clientfield::set("blight_father_death_fx", var_81316a8a);
		}
	}
}

/*
	Name: blightfathershouldmelee
	Namespace: zm_ai_blight_father
	Checksum: 0x2D3F6CE5
	Offset: 0x4188
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private blightfathershouldmelee(entity)
{
	if(function_66e66814(entity))
	{
		return 1;
	}
	return zombiebehavior::zombieshouldmeleecondition(entity);
}

/*
	Name: function_66e66814
	Namespace: zm_ai_blight_father
	Checksum: 0x6FDEB740
	Offset: 0x41D8
	Size: 0x142
	Parameters: 1
	Flags: Linked, Private
*/
function private function_66e66814(entity)
{
	if(!isdefined(entity.var_81ce9fcd))
	{
		return false;
	}
	if(entity istouching(entity.var_81ce9fcd))
	{
		return true;
	}
	var_e3df303a = zombiebehavior::function_997f1224(entity);
	if(distancesquared(entity.origin, entity.var_81ce9fcd.origin) > var_e3df303a)
	{
		return false;
	}
	var_838fd1c7 = angleclamp180(entity.angles[1] - (vectortoangles(entity.var_81ce9fcd.origin - entity.origin)[1]));
	if(abs(var_838fd1c7) > (isdefined(entity.var_1c0eb62a) ? entity.var_1c0eb62a : 60))
	{
		return false;
	}
	return true;
}

/*
	Name: function_ac921de9
	Namespace: zm_ai_blight_father
	Checksum: 0xFD68BFE7
	Offset: 0x4328
	Size: 0x408
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ac921de9(entity)
{
	meleerange = entity ai::function_9139c839().var_558fb394;
	meleerangesq = meleerange * meleerange;
	var_5c2f5f9a = [];
	foreach(player in getplayers())
	{
		if(meleerangesq < distancesquared(entity.origin, player.origin))
		{
			continue;
		}
		if(!isdefined(var_5c2f5f9a))
		{
			var_5c2f5f9a = [];
		}
		else if(!isarray(var_5c2f5f9a))
		{
			var_5c2f5f9a = array(var_5c2f5f9a);
		}
		if(!isinarray(var_5c2f5f9a, player))
		{
			var_5c2f5f9a[var_5c2f5f9a.size] = player;
		}
	}
	function_6eac4ca1(entity, "attack_melee");
	registernotice_walla = anglestoforward(entity.angles);
	var_2f706708 = entity gettagorigin("j_spine4");
	var_9b246038 = entity ai::function_9139c839().var_4e8d4c24;
	if(isdefined(entity.var_81ce9fcd))
	{
		var_e3df303a = zombiebehavior::function_997f1224(entity);
		if(distancesquared(entity.var_81ce9fcd.origin, entity.origin) < var_e3df303a && bullettracepassed(var_2f706708, entity.var_81ce9fcd getcentroid(), 0, entity, entity.var_81ce9fcd, 0, 1))
		{
			entity.var_81ce9fcd notify(#"hash_90cfd38343f41f2", {#hash_8413ff14:var_2f706708, #hash_b736806d:entity});
		}
	}
	foreach(player in var_5c2f5f9a)
	{
		vec_to_player = vectornormalize(player.origin - entity.origin);
		if(vectordot(vec_to_player, registernotice_walla) < var_9b246038)
		{
			continue;
		}
		if(bullettracepassed(var_2f706708, player geteye(), 0, entity))
		{
			player dodamage(entity.meleeweapon.playerdamage, entity.origin, entity, entity, "none", "MOD_MELEE");
		}
	}
}

/*
	Name: function_911c3934
	Namespace: zm_ai_blight_father
	Checksum: 0x613892CD
	Offset: 0x4738
	Size: 0x462
	Parameters: 1
	Flags: Linked, Private
*/
function private function_911c3934(entity)
{
	/#
		if(isdefined(entity.ispuppet) && entity.ispuppet)
		{
			return;
		}
	#/
	if(!isdefined(entity.var_93a62fe))
	{
		if(isdefined(self.ignore_player))
		{
			if(isdefined(level._should_skip_ignore_player_logic) && [[level._should_skip_ignore_player_logic]]())
			{
				return;
			}
			self.ignore_player = [];
		}
		if(!isdefined(entity.var_9ba20329))
		{
			entity.var_9ba20329 = entity zm_cleanup::get_escape_position();
		}
		if(isdefined(entity.var_9ba20329))
		{
			entity setgoal(entity.var_9ba20329.origin);
		}
		else
		{
			entity setgoal(entity.origin);
		}
		return false;
	}
	entity.var_9ba20329 = undefined;
	if(isdefined(entity.var_81ce9fcd))
	{
		v_goal = getclosestpointonnavmesh(entity.var_81ce9fcd.origin, 24, entity getpathfindingradius());
		if(isdefined(v_goal))
		{
			entity.var_c52d968a = v_goal;
		}
	}
	else if(!isdefined(entity.var_81ce9fcd))
	{
		entity.var_c52d968a = undefined;
		a_poi = entity zm_utility::get_zombie_point_of_interest(entity.origin);
		if(isarray(a_poi) && a_poi.size > 0)
		{
			foreach(poi in a_poi)
			{
				if(isentity(poi) && (!(isdefined(poi.var_27b86a5a) && poi.var_27b86a5a)) && function_51dbdb8f(poi.weapon) && isdefined(poi.birthtime) && (level.time - poi.birthtime) >= 5000)
				{
					v_goal = getclosestpointonnavmesh(poi.origin, 24, entity getpathfindingradius());
					if(isdefined(v_goal))
					{
						/#
							iprintlnbold((("" + entity getentitynumber()) + "") + poi getentitynumber());
						#/
						entity.var_81ce9fcd = poi;
						entity.var_c52d968a = v_goal;
						poi.var_27b86a5a = 1;
					}
				}
			}
		}
	}
	if(isdefined(entity.var_c52d968a) && entity zm_utility::function_64259898(entity.var_c52d968a))
	{
		return true;
	}
	if(isdefined(entity.var_3acacb18))
	{
		targetpos = entity.var_3acacb18;
		self function_a57c34b7(targetpos);
	}
	else
	{
		targetpos = entity.var_93a62fe.origin;
		zm_utility::function_64259898(targetpos);
	}
	entity.favoriteenemy = entity.var_93a62fe;
}

/*
	Name: function_51dbdb8f
	Namespace: zm_ai_blight_father
	Checksum: 0xBD052D21
	Offset: 0x4BA8
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function function_51dbdb8f(var_9cb85074)
{
	if(!isdefined(var_9cb85074) || !isarray(level.var_fe96a4c4))
	{
		return false;
	}
	if(isinarray(level.var_fe96a4c4, var_9cb85074))
	{
		return true;
	}
	return false;
}

/*
	Name: function_283b9654
	Namespace: zm_ai_blight_father
	Checksum: 0xE750F6AF
	Offset: 0x4C18
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_283b9654(entity)
{
	function_25f9cc48(entity);
	function_c526065b(entity);
	zm_behavior::zombiestunstart(entity);
}

/*
	Name: function_fa33f4aa
	Namespace: zm_ai_blight_father
	Checksum: 0xFAEC8911
	Offset: 0x4C78
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
function private function_fa33f4aa(entity, asmstatename)
{
	if(zm_behavior::zombieshouldstun(entity))
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_d83ac1e7
	Namespace: zm_ai_blight_father
	Checksum: 0x2AB3ABBB
	Offset: 0x4CB8
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d83ac1e7(entity)
{
	function_25f9cc48(entity);
	function_c526065b(entity);
	zm_behavior::zombieknockdownactionstart(entity);
}

/*
	Name: function_928e66ad
	Namespace: zm_ai_blight_father
	Checksum: 0x324F58B6
	Offset: 0x4D18
	Size: 0x30
	Parameters: 2
	Flags: Linked, Private
*/
function private function_928e66ad(entity, asmstatename)
{
	function_f108c0ea(entity);
	return 4;
}

/*
	Name: function_f108c0ea
	Namespace: zm_ai_blight_father
	Checksum: 0xEB593096
	Offset: 0x4D50
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f108c0ea(entity)
{
	if(function_3515ad4b(entity))
	{
		function_25f9cc48(entity);
		function_c526065b(entity);
	}
}

/*
	Name: function_775f8cf2
	Namespace: zm_ai_blight_father
	Checksum: 0x35ED78F7
	Offset: 0x4DB0
	Size: 0x4E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_775f8cf2()
{
	if(isdefined(self.var_177b7a47) && self.var_177b7a47)
	{
		return "left_sac_destroyed";
	}
	if(isdefined(self.var_7c54fb46) && self.var_7c54fb46)
	{
		return "right_sac_destroyed";
	}
	return undefined;
}

/*
	Name: function_3df61a1a
	Namespace: zm_ai_blight_father
	Checksum: 0xCE9EB311
	Offset: 0x4E08
	Size: 0x114
	Parameters: 13
	Flags: Linked, Private
*/
function private function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_2703428f--;
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	entity destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_fa7c080
	Namespace: zm_ai_blight_father
	Checksum: 0x9C3EDDC3
	Offset: 0x4F28
	Size: 0x156
	Parameters: 13
	Flags: Linked, Private
*/
function private function_fa7c080(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_c8f98f87 = 1;
	entity.var_6ee32f47 = 1;
	entity clientfield::set("blight_father_weakpoint_jaw_fx", 0);
	entity attach("c_t8_zmb_blightfather_mouth_dmg1");
	if(entity isattached("c_t8_zmb_blightfather_tongue2", "tag_tongue_grab"))
	{
		entity detach("c_t8_zmb_blightfather_tongue2");
	}
	stub = zm_lockdown_util::function_87c1193e(entity);
	zm_lockdown_util::function_77caff8b(stub);
	entity.var_3acacb18 = undefined;
}

/*
	Name: function_9bbe631c
	Namespace: zm_ai_blight_father
	Checksum: 0x79D0B65A
	Offset: 0x5088
	Size: 0x8C
	Parameters: 13
	Flags: Linked, Private
*/
function private function_9bbe631c(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity clientfield::set("blight_father_weakpoint_l_elbow_fx", 0);
}

/*
	Name: function_5a1a4ad
	Namespace: zm_ai_blight_father
	Checksum: 0x3FA9F741
	Offset: 0x5120
	Size: 0x8C
	Parameters: 13
	Flags: Linked, Private
*/
function private function_5a1a4ad(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity clientfield::set("blight_father_weakpoint_r_elbow_fx", 0);
}

/*
	Name: function_40034805
	Namespace: zm_ai_blight_father
	Checksum: 0xECFA137E
	Offset: 0x51B8
	Size: 0x16C
	Parameters: 13
	Flags: Linked, Private
*/
function private function_40034805(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_177b7a47 = 1;
	entity clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 0);
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	if(isdefined(entity.var_7c54fb46) && entity.var_7c54fb46)
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_le");
	}
	else
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_both");
		entity attach("c_t8_zmb_blightfather_eggsack1_ri");
	}
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_33b2c99e
	Namespace: zm_ai_blight_father
	Checksum: 0xB74B14CB
	Offset: 0x5330
	Size: 0x16C
	Parameters: 13
	Flags: Linked, Private
*/
function private function_33b2c99e(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_7c54fb46 = 1;
	entity clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 0);
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	if(isdefined(entity.var_177b7a47) && entity.var_177b7a47)
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_ri");
	}
	else
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_both");
		entity attach("c_t8_zmb_blightfather_eggsack1_le");
	}
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_cacd1506
	Namespace: zm_ai_blight_father
	Checksum: 0xC5CD9EBB
	Offset: 0x54A8
	Size: 0x22C
	Parameters: 14
	Flags: Linked, Private
*/
function private function_cacd1506(var_84ed9a13, entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(namespace_81245006::function_f29756fe(var_84ed9a13) != 1)
	{
		return;
	}
	namespace_81245006::function_ef87b7e8(var_84ed9a13, damage);
	if(isdefined(inflictor))
	{
		inflictor thread function_6f109d76(self);
	}
	if(namespace_81245006::function_f29756fe(var_84ed9a13) == 3)
	{
		if(isdefined(level.var_c2981ce9[var_84ed9a13.var_51e8b151]))
		{
			entity [[level.var_c2981ce9[var_84ed9a13.var_51e8b151]]](entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
		}
		if(!entity isplayinganimscripted())
		{
			entity.var_fbec06fa = var_84ed9a13.var_51e8b151;
			entity setblackboardattribute("_blight_father_weak_point", var_84ed9a13.var_51e8b151);
		}
		bone = boneindex;
		if(zm_utility::is_explosive_damage(meansofdamage))
		{
			bone = var_84ed9a13.var_51e8b151;
		}
		function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, bone, modelindex);
	}
}

/*
	Name: function_6f109d76
	Namespace: zm_ai_blight_father
	Checksum: 0xC0194187
	Offset: 0x56E0
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function function_6f109d76(ai)
{
	if(level.var_a51ca41a <= 2)
	{
		if(level.time - ai.birthtime > 3000)
		{
			self thread zm_audio::create_and_play_dialog(#"blight_father", #"weak_points");
		}
	}
}

/*
	Name: function_afce1cf
	Namespace: zm_ai_blight_father
	Checksum: 0x2F42BBC
	Offset: 0x5760
	Size: 0x3C6
	Parameters: 12
	Flags: Linked, Private
*/
function private function_afce1cf(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity = self;
	var_dd54fdb1 = namespace_81245006::function_3131f5dd(self, hitloc, 1);
	if(!isdefined(var_dd54fdb1))
	{
		var_dd54fdb1 = namespace_81245006::function_73ab4754(self, point, 1);
	}
	var_786d7e06 = zm_ai_utility::function_422fdfd4(self, attacker, weapon, boneindex, hitloc, point, var_dd54fdb1);
	damage_scale = var_786d7e06.damage_scale;
	var_84ed9a13 = var_786d7e06.var_84ed9a13;
	registerzombie_bgb_used_reinforce = var_786d7e06.registerzombie_bgb_used_reinforce;
	if(zm_utility::is_explosive_damage(meansofdamage))
	{
		damage_scale = max(damage_scale, entity ai::function_9139c839().explosivedamagescale);
		final_damage = int(damage * damage_scale);
		if(meansofdamage === "MOD_PROJECTILE" && isdefined(var_84ed9a13) && registerzombie_bgb_used_reinforce)
		{
			function_cacd1506(var_84ed9a13, entity, inflictor, attacker, var_84ed9a13.health, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
		}
	}
	else
	{
		final_damage = int(damage * damage_scale);
		if(isdefined(var_84ed9a13) && registerzombie_bgb_used_reinforce)
		{
			function_cacd1506(var_84ed9a13, entity, inflictor, attacker, final_damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
		}
	}
	/#
		if(isdefined(level.var_482766d7) && level.var_482766d7)
		{
			iprintlnbold(((((("" + damage_scale) + "") + final_damage) + "") + (entity.health - final_damage) + "") + entity.var_2703428f);
		}
	#/
	if(entity.var_2703428f <= 0)
	{
		origin = entity.origin;
		if(isdefined(inflictor))
		{
			origin = inflictor.origin;
		}
		attacker util::show_hit_marker(1);
		entity kill(origin, attacker, inflictor, weapon, 0, 1);
		final_damage = 0;
	}
	return final_damage;
}

/*
	Name: function_f9d9f198
	Namespace: zm_ai_blight_father
	Checksum: 0xB9D7DD43
	Offset: 0x5B30
	Size: 0xE8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f9d9f198(entity)
{
	var_bee929e7 = entity astsearch("grapple_attack_vomit@blight_father");
	animname = animationstatenetworkutility::searchanimationmap(entity, var_bee929e7[#"animation"]);
	tag_pos = getanimtagorigin(animname, 0, "tag_tongue");
	var_2db07c66 = rotatepoint(tag_pos, entity gettagangles("tag_origin"));
	var_2db07c66 = var_2db07c66 + entity.origin;
	return var_2db07c66;
}

/*
	Name: function_35edac9c
	Namespace: zm_ai_blight_father
	Checksum: 0x551DF698
	Offset: 0x5C20
	Size: 0x36
	Parameters: 1
	Flags: Linked, Private
*/
function private function_35edac9c(entity)
{
	entity.var_f7c29bc4 = gettime() + entity ai::function_9139c839().var_eed65399;
}

/*
	Name: function_5d7f8057
	Namespace: zm_ai_blight_father
	Checksum: 0xD98202D4
	Offset: 0x5C60
	Size: 0x1E6
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5d7f8057(entity, player)
{
	if(entity.var_c8088bcb.timestamp !== gettime())
	{
		entity.var_c8088bcb.traces = [];
		entity.var_c8088bcb.timestamp = gettime();
	}
	else if(isdefined(entity.var_c8088bcb.traces[player getentitynumber()]))
	{
		return entity.var_c8088bcb.traces[player getentitynumber()];
	}
	clip_mask = 1 | 8;
	if(player haspart("j_mainroot"))
	{
		trace = physicstrace(entity.origin + vectorscale((0, 0, 1), 35), player gettagorigin("j_mainroot"), (-15, -15, -20), (15, 15, 40), entity, clip_mask);
	}
	else
	{
		trace = physicstrace(entity.origin + vectorscale((0, 0, 1), 35), player.origin, (-15, -15, -20), (15, 15, 40), entity, clip_mask);
	}
	entity.var_c8088bcb.traces[player getentitynumber()] = trace;
	return trace;
}

/*
	Name: function_aaad8487
	Namespace: zm_ai_blight_father
	Checksum: 0xEA9DC57C
	Offset: 0x5E50
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_aaad8487(entity)
{
	if(!isdefined(level.var_e82b911f) || level.var_e82b911f === entity)
	{
		level.var_e82b911f = entity;
		return true;
	}
	return false;
}

/*
	Name: function_3782350
	Namespace: zm_ai_blight_father
	Checksum: 0x5BCC37DC
	Offset: 0x5EA8
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3782350(entity)
{
	level.var_e82b911f = undefined;
}

/*
	Name: function_4bd1c37e
	Namespace: zm_ai_blight_father
	Checksum: 0xFE66DD7C
	Offset: 0x5EC8
	Size: 0x76
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4bd1c37e(entity)
{
	if(function_aaad8487(entity))
	{
		if(function_2784f3ff(entity))
		{
			function_3782350(entity);
			return true;
		}
		if(function_8383fdf9(entity))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: function_2784f3ff
	Namespace: zm_ai_blight_father
	Checksum: 0xFA2F764B
	Offset: 0x5F48
	Size: 0x346
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2784f3ff(entity)
{
	if(isdefined(level.var_9cfa4efd) && level.var_9cfa4efd)
	{
		return false;
	}
	if(level.var_fcb96175 > gettime())
	{
		return false;
	}
	if(!ai::get_behavior_attribute("tongue_grab_enabled"))
	{
		return false;
	}
	if(isdefined(entity.var_81ce9fcd))
	{
		return false;
	}
	if(entity.var_f7c29bc4 > gettime())
	{
		return false;
	}
	if(zm_grappler::function_56813755())
	{
		return false;
	}
	var_490cb97a = function_ef973b70(entity);
	if(isdefined(var_490cb97a) && var_490cb97a != 4)
	{
		return false;
	}
	if(isdefined(entity.var_c8f98f87) && entity.var_c8f98f87)
	{
		return false;
	}
	if(abs(entity aiutility::function_6f949118()) > 5)
	{
		return false;
	}
	foreach(player in level.players)
	{
		/#
			if(player isinmovemode("", ""))
			{
				continue;
			}
		#/
		if(!zombie_utility::is_player_valid(player, 1, undefined, 0))
		{
			continue;
		}
		var_c7af7c08 = distancesquared(player.origin, entity.origin);
		if(var_c7af7c08 > entity ai::function_9139c839().var_b30a945 * entity ai::function_9139c839().var_b30a945)
		{
			continue;
		}
		if(vectordot(vectornormalize(player.origin - entity.origin), anglestoforward(entity.angles)) < entity ai::function_9139c839().var_b2656f44)
		{
			continue;
		}
		test_trace = function_5d7f8057(entity, player);
		if(test_trace[#"fraction"] == 1 || test_trace[#"entity"] === player)
		{
			entity.var_bef7624d = player;
			return true;
		}
	}
	return false;
}

/*
	Name: function_d6ded650
	Namespace: zm_ai_blight_father
	Checksum: 0xD09227F4
	Offset: 0x6298
	Size: 0x18
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d6ded650(entity)
{
	return isdefined(entity.e_grapplee);
}

/*
	Name: function_e0b3baff
	Namespace: zm_ai_blight_father
	Checksum: 0xA139790E
	Offset: 0x62B8
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e0b3baff(notifyhash)
{
	function_c526065b(self);
	function_d67c455e(notifyhash);
}

/*
	Name: function_96f5d05a
	Namespace: zm_ai_blight_father
	Checksum: 0x504E5E5E
	Offset: 0x6300
	Size: 0x66C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_96f5d05a(entity, var_4c0587b)
{
	if(!isdefined(entity))
	{
		return;
	}
	if(!isalive(entity))
	{
		entity function_e0b3baff();
		return;
	}
	entity endoncallback(&function_e0b3baff, #"death", #"hash_2fb2eddfa6a0ef3f");
	grapple_start = zm_grappler::function_6be863a(entity gettagorigin("tag_jaw"), entity.angles);
	grapple_end = zm_grappler::function_6be863a(entity gettagorigin("tag_jaw"), entity.angles * -1);
	grapple_end.prone_2_run_roll = entity;
	grapple_start linkto(entity, "tag_jaw");
	entity.var_54c1950f = {#hash_5273e1a0:[], #status:0, #hash_65bf647c:grapple_end, #hash_a733d0aa:grapple_start};
	thread zm_grappler::function_30a5f5c1(grapple_start, grapple_end);
	util::wait_network_frame();
	n_time = distance(grapple_end.origin, var_4c0587b) / entity ai::function_9139c839().var_4a5ffac;
	n_time = max(0.1, n_time);
	entity.var_54c1950f.status = 1;
	grapple_end playsound(#"zmb_grapple_start");
	grapple_end moveto(var_4c0587b, n_time, 0, n_time * 0.1);
	grapple_end.return_pos = entity zm_grappler::function_f21c3519();
	thread function_9d1a26f1(entity, entity ai::function_9139c839().var_23426e9a * entity ai::function_9139c839().var_23426e9a, level.players);
	grapple_end flagsys::wait_till("grapple_moveto_done");
	grapple_end flagsys::clear("grapple_moveto_done");
	entity.var_54c1950f.status = 2;
	n_time = distance(grapple_end.origin, grapple_end.return_pos) / entity ai::function_9139c839().var_4a5ffac;
	grapple_end moveto(grapple_end.return_pos, n_time, n_time * 0.1, 0);
	var_51c441a4 = entity.e_grapplee;
	grapple_end playsound(#"zmb_grapple_pull");
	thread function_9d1a26f1(entity, entity ai::function_9139c839().var_23426e9a * entity ai::function_9139c839().var_23426e9a, level.players);
	grapple_end flagsys::wait_till("grapple_moveto_done");
	grapple_end flagsys::clear("grapple_moveto_done");
	if(!isdefined(var_51c441a4) && isdefined(entity.e_grapplee))
	{
		n_time = distance(grapple_end.origin, grapple_end.return_pos) / entity ai::function_9139c839().var_4a5ffac;
		grapple_end moveto(grapple_end.return_pos, n_time, 0, 0);
		grapple_end waittill(#"movedone");
	}
	if(isdefined(entity.e_grapplee))
	{
		var_148b92ae = function_f9d9f198(entity);
		var_1b40c6fd = entity.origin - var_148b92ae;
		angles = vectortoangles(var_1b40c6fd);
		grapple_end.angles = (grapple_end.angles[0], angles[1], grapple_end.angles[2]);
		entity.e_grapplee util::delay(0.5, undefined, &zm_audio::create_and_play_dialog, #"blight_father", #"vomit", undefined, 2);
	}
	entity.var_54c1950f.status = 4;
	if(!isdefined(entity.e_grapplee))
	{
		entity thread function_d67c455e();
	}
}

/*
	Name: function_55cba1f3
	Namespace: zm_ai_blight_father
	Checksum: 0x8863A1A4
	Offset: 0x6978
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_55cba1f3(prone_2_run_roll)
{
	self endon(#"death", #"hash_46064b6c2cb5cf20");
	wait(15);
	if(isdefined(prone_2_run_roll))
	{
		function_25f9cc48(prone_2_run_roll);
	}
	self thread function_c526065b(prone_2_run_roll, self);
}

/*
	Name: function_28dddd64
	Namespace: zm_ai_blight_father
	Checksum: 0x98DF185B
	Offset: 0x69F0
	Size: 0x1E4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_28dddd64(entity)
{
	entity.var_cdc2bec8 = 0;
	if(zombie_utility::is_player_valid(entity.var_bef7624d, 1, 1, 0))
	{
		dir = entity.var_bef7624d zm_grappler::function_f21c3519() - entity zm_grappler::function_f21c3519();
		dir_norm = vectornormalize(dir);
		if(vectordot(dir_norm, anglestoforward(entity.angles)) < entity ai::function_9139c839().var_b2656f44)
		{
			dir_norm = anglestoforward(entity.angles);
		}
		var_4c0587b = entity zm_grappler::function_f21c3519() + (dir_norm * entity ai::function_9139c839().var_b30a945);
		test_trace = worldtrace(entity zm_grappler::function_f21c3519(), var_4c0587b);
		if(test_trace[#"fraction"] < 1)
		{
			var_4c0587b = test_trace[#"position"];
		}
		thread function_96f5d05a(entity, var_4c0587b);
	}
	function_3782350(entity);
}

/*
	Name: function_ef973b70
	Namespace: zm_ai_blight_father
	Checksum: 0x5B5D5E88
	Offset: 0x6BE0
	Size: 0x32
	Parameters: 1
	Flags: Linked
*/
function function_ef973b70(entity)
{
	if(isdefined(entity.var_54c1950f))
	{
		return entity.var_54c1950f.status;
	}
	return undefined;
}

/*
	Name: function_31963d63
	Namespace: zm_ai_blight_father
	Checksum: 0x9E9202C5
	Offset: 0x6C20
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_31963d63(notifyhash)
{
	if(notifyhash === #"movedone")
	{
		self flagsys::set("grapple_moveto_done");
	}
}

/*
	Name: function_9d1a26f1
	Namespace: zm_ai_blight_father
	Checksum: 0x27CA1AE5
	Offset: 0x6C68
	Size: 0x560
	Parameters: 3
	Flags: Linked
*/
function function_9d1a26f1(entity, var_8a713db5, var_3e06882e)
{
	entity endon(#"death", #"hash_2fb2eddfa6a0ef3f");
	entity.var_54c1950f.beamend endoncallback(&function_31963d63, #"death", #"movedone");
	/#
		if(getdvarint(#"hash_692fb9cc4cff6541", 0))
		{
			var_1b97aa47 = sqrt(var_8a713db5);
			var_e41cb172 = [];
		}
	#/
	while(true)
	{
		if(!isdefined(entity.e_grapplee))
		{
			/#
				if(getdvarint(#"hash_692fb9cc4cff6541", 0))
				{
					if(!isdefined(var_e41cb172))
					{
						var_e41cb172 = [];
					}
					else if(!isarray(var_e41cb172))
					{
						var_e41cb172 = array(var_e41cb172);
					}
					if(!isinarray(var_e41cb172, entity.var_54c1950f.beamend.origin))
					{
						var_e41cb172[var_e41cb172.size] = entity.var_54c1950f.beamend.origin;
					}
					foreach(origin in var_e41cb172)
					{
						recordcircle(origin, var_1b97aa47, (1, 0, 0));
						recordstar(origin, (0, 1, 0));
					}
				}
			#/
			e_grapplee = function_5afb347c(entity, entity.var_54c1950f.beamend.origin, var_8a713db5, var_3e06882e);
			if(isdefined(e_grapplee))
			{
				entity.var_54c1950f.beamend.return_pos = entity gettagorigin("tag_jaw");
				if(isdefined(e_grapplee.hasriotshieldequipped) && e_grapplee.hasriotshieldequipped)
				{
					if(!isdefined(entity.var_54c1950f.var_5273e1a0))
					{
						entity.var_54c1950f.var_5273e1a0 = [];
					}
					else if(!isarray(entity.var_54c1950f.var_5273e1a0))
					{
						entity.var_54c1950f.var_5273e1a0 = array(entity.var_54c1950f.var_5273e1a0);
					}
					if(!isinarray(entity.var_54c1950f.var_5273e1a0, e_grapplee))
					{
						entity.var_54c1950f.var_5273e1a0[entity.var_54c1950f.var_5273e1a0.size] = e_grapplee;
					}
					e_grapplee thread riotshield::player_take_riotshield();
				}
				else
				{
					if(e_grapplee function_61efcfe5())
					{
						if(!isdefined(entity.var_54c1950f.var_5273e1a0))
						{
							entity.var_54c1950f.var_5273e1a0 = [];
						}
						else if(!isarray(entity.var_54c1950f.var_5273e1a0))
						{
							entity.var_54c1950f.var_5273e1a0 = array(entity.var_54c1950f.var_5273e1a0);
						}
						if(!isinarray(entity.var_54c1950f.var_5273e1a0, e_grapplee))
						{
							entity.var_54c1950f.var_5273e1a0[entity.var_54c1950f.var_5273e1a0.size] = e_grapplee;
						}
					}
					else
					{
						function_91dcbd1c(entity, entity.var_54c1950f.beamend, e_grapplee);
					}
				}
				entity.var_54c1950f.beamend flagsys::set("grapple_moveto_done");
				return;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_5afb347c
	Namespace: zm_ai_blight_father
	Checksum: 0xF34D0881
	Offset: 0x71D0
	Size: 0x254
	Parameters: 4
	Flags: Linked, Private
*/
function private function_5afb347c(entity, var_6aab4b, var_8a713db5, var_3e06882e)
{
	foreach(var_cf12838e in var_3e06882e)
	{
		if(!zombie_utility::is_player_valid(var_cf12838e, 1, 1) || (isdefined(var_cf12838e.var_564dec14) && var_cf12838e.var_564dec14) || (isdefined(var_cf12838e.var_e75517b1) && var_cf12838e.var_e75517b1) || var_cf12838e issliding() || var_cf12838e getstance() == "prone" || isinarray(entity.var_54c1950f.var_5273e1a0, var_cf12838e) || !isdefined(var_cf12838e gettagorigin("j_mainroot")))
		{
			continue;
		}
		if(distancesquared(var_cf12838e gettagorigin("j_mainroot"), var_6aab4b) < var_8a713db5)
		{
			var_148b92ae = function_f9d9f198(entity);
			var_36282543 = var_cf12838e geteye() - var_148b92ae;
			var_b842eb80 = (var_36282543[0], var_36282543[1], 0);
			if(vectordot(var_b842eb80, anglestoforward(entity.angles)) > 0)
			{
				return var_cf12838e;
			}
		}
	}
	return undefined;
}

/*
	Name: function_c1b0cbda
	Namespace: zm_ai_blight_father
	Checksum: 0xF4D9F5B5
	Offset: 0x7430
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c1b0cbda()
{
	self endon(#"death");
	while(self isswitchingweapons())
	{
		waitframe(1);
	}
	self thread riotshield::function_a9109d26();
}

/*
	Name: function_91dcbd1c
	Namespace: zm_ai_blight_father
	Checksum: 0xAA89821E
	Offset: 0x7488
	Size: 0x384
	Parameters: 3
	Flags: Linked, Private
*/
function private function_91dcbd1c(prone_2_run_roll, var_a424c06a, e_grapplee)
{
	if(!isdefined(var_a424c06a))
	{
		return;
	}
	prone_2_run_roll.e_grapplee = e_grapplee;
	e_grapplee zm_grappler::function_a60cb756(1, 0);
	if(isplayer(e_grapplee))
	{
		e_grapplee thread function_c1b0cbda();
		e_grapplee function_5d851a4e();
	}
	var_148b92ae = function_f9d9f198(prone_2_run_roll);
	/#
		recordstar(var_148b92ae, (1, 0.5, 0));
		recordcircle(var_148b92ae, 10, (0, 0, 1));
	#/
	var_a424c06a.return_pos = var_148b92ae;
	var_ca015b6f = util::spawn_model("tag_origin", e_grapplee.origin, e_grapplee.angles);
	var_ca015b6f linkto(var_a424c06a, "tag_origin", vectorscale((0, 0, 1), 35) * -1);
	e_grapplee.var_ca015b6f = var_ca015b6f;
	if(isplayer(e_grapplee))
	{
		e_grapplee playerlinkto(var_ca015b6f, "tag_origin", 1, 40, 40, 80, 15);
		/#
			recordstar(var_148b92ae, (1, 0, 0));
			recordstar(e_grapplee geteye(), (0, 0, 1));
		#/
		angles = vectortoangles(var_148b92ae - e_grapplee geteye());
		var_a424c06a.angles = (0, angles[1], 0);
		e_grapplee setplayerangles(angles);
		e_grapplee setstance("stand");
		e_grapplee allowcrouch(0);
		e_grapplee allowprone(0);
		e_grapplee function_babdb8e7();
	}
	else
	{
		e_grapplee linkto(var_a424c06a);
	}
	if(isdefined(prone_2_run_roll) && isdefined(e_grapplee) && isplayer(e_grapplee))
	{
		e_grapplee thread function_55cba1f3(prone_2_run_roll);
	}
	e_grapplee playsound(#"zmb_grapple_grab");
}

/*
	Name: function_c526065b
	Namespace: zm_ai_blight_father
	Checksum: 0x2516B09F
	Offset: 0x7818
	Size: 0x2CE
	Parameters: 2
	Flags: Linked
*/
function function_c526065b(entity, var_e0ef3075)
{
	grapplee = var_e0ef3075;
	if(isdefined(entity))
	{
		entity.var_eb3ff149 = undefined;
		grapplee = entity.e_grapplee;
	}
	if(!isdefined(grapplee) || (!(isdefined(grapplee.var_564dec14) && grapplee.var_564dec14)))
	{
		return;
	}
	if(isdefined(entity))
	{
		grapplee notify(#"hash_46064b6c2cb5cf20", {#blight_father:entity});
	}
	function_cf18d183(grapplee);
	grapplee unlink();
	if(isdefined(grapplee.var_ca015b6f))
	{
		grapplee.var_ca015b6f delete();
		grapplee.var_ca015b6f = undefined;
	}
	grapplee zm_grappler::function_a60cb756(0, 0);
	if(isplayer(grapplee))
	{
		grapplee function_1fd426b6();
		grapplee allowcrouch(1);
		grapplee allowprone(1);
	}
	droppoint = getclosestpointonnavmesh(grapplee.origin, 64, 24);
	if(isdefined(droppoint))
	{
		v_ground_pos = groundtrace(droppoint + vectorscale((0, 0, 1), 50), droppoint, 0, entity)[#"position"];
		if(isdefined(v_ground_pos))
		{
			droppoint = v_ground_pos;
		}
		if(isplayer(grapplee))
		{
			grapplee setorigin(droppoint);
		}
		else
		{
			grapplee forceteleport(droppoint);
		}
	}
	else if(isplayer(grapplee))
	{
		if(isdefined(grapplee.last_valid_position))
		{
			grapplee setorigin(grapplee.last_valid_position);
		}
	}
	grapplee function_def41e89();
	if(isdefined(entity))
	{
		entity.e_grapplee = undefined;
	}
}

/*
	Name: function_def41e89
	Namespace: zm_ai_blight_father
	Checksum: 0x32ED17F2
	Offset: 0x7AF0
	Size: 0x1BC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_def41e89()
{
	enemies = getaispeciesarray(level.zombie_team, "all");
	enemies = arraysortclosest(enemies, self.origin, undefined, 0, self getpathfindingradius() + 100);
	foreach(enemy in enemies)
	{
		if(self istouching(enemy))
		{
			if(isdefined(enemy.allowdeath) && enemy.allowdeath && (enemy.var_6f84b820 === #"basic" || enemy.var_6f84b820 === #"popcorn"))
			{
				enemy zm_cleanup::function_23621259();
				enemy kill();
				continue;
			}
			self dodamage(self.health + 1000, self.origin, enemy, enemy, "none", "MOD_RIFLE_BULLET");
			break;
		}
	}
}

/*
	Name: function_d67c455e
	Namespace: zm_ai_blight_father
	Checksum: 0xF192E6BB
	Offset: 0x7CB8
	Size: 0x122
	Parameters: 1
	Flags: Linked
*/
function function_d67c455e(notifyhash)
{
	if(isdefined(self.prone_2_run_roll))
	{
		entity = self.prone_2_run_roll;
	}
	else
	{
		entity = self;
	}
	if(!isdefined(entity.var_54c1950f))
	{
		return;
	}
	e_source = entity.var_54c1950f.beamstart;
	var_28ac1348 = entity.var_54c1950f.beamend;
	entity.var_54c1950f = undefined;
	zm_grappler::function_c43e7cab();
	level.var_acec7a44 = 1;
	if(isdefined(e_source))
	{
		e_source unlink();
		zm_grappler::function_a8e7b940(e_source);
	}
	if(isdefined(var_28ac1348))
	{
		zm_grappler::function_a8e7b940(var_28ac1348);
	}
	util::wait_network_frame();
	level.var_acec7a44 = 0;
}

/*
	Name: function_babdb8e7
	Namespace: zm_ai_blight_father
	Checksum: 0xF371502B
	Offset: 0x7DE8
	Size: 0x44
	Parameters: 0
	Flags: Linked, Private
*/
function private function_babdb8e7()
{
	self clientfield::set_to_player("tongueGrabRumble", 1);
	self clientfield::set_to_player("tongueGrabPostFx", 1);
}

/*
	Name: function_299dd40e
	Namespace: zm_ai_blight_father
	Checksum: 0xD34402C6
	Offset: 0x7E38
	Size: 0xDC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_299dd40e(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(zm_utility::is_player_valid(entity.var_bef7624d))
	{
		to_player = entity.var_bef7624d.origin - entity.origin;
		var_47d9e0ed = vectortoangles(to_player);
		entity orientmode("face angle", var_47d9e0ed[1]);
	}
	entity animmode("zonly_physics", 0);
}

/*
	Name: function_689831cf
	Namespace: zm_ai_blight_father
	Checksum: 0xBEAE2761
	Offset: 0x7F20
	Size: 0x1AC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_689831cf(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	if(function_ef973b70(entity) === 0 && zm_utility::is_player_valid(entity.var_bef7624d) && !isdefined(entity.e_grapplee))
	{
		/#
			record3dtext("", entity.origin + vectorscale((0, 0, 1), 16), (0, 0, 1));
		#/
		to_player = entity.var_bef7624d.origin - entity.origin;
		var_47d9e0ed = vectortoangles(to_player);
		entity orientmode("face angle", var_47d9e0ed[1]);
	}
	else
	{
		/#
			record3dtext("", entity.origin + vectorscale((0, 0, 1), 16), (0, 1, 0));
		#/
		entity orientmode("face current");
	}
	entity animmode("zonly_physics", 0);
}

/*
	Name: function_42de48fb
	Namespace: zm_ai_blight_father
	Checksum: 0x41772807
	Offset: 0x80D8
	Size: 0x4C
	Parameters: 5
	Flags: Linked, Private
*/
function private function_42de48fb(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity orientmode("face default");
}

/*
	Name: function_b62014ac
	Namespace: zm_ai_blight_father
	Checksum: 0x65E0F9B8
	Offset: 0x8130
	Size: 0x58
	Parameters: 2
	Flags: Linked, Private
*/
function private function_b62014ac(entity, asmstatename)
{
	if(function_ef973b70(entity) === 0 || function_ef973b70(entity) === 1)
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_8cbef8fd
	Namespace: zm_ai_blight_father
	Checksum: 0x7775667B
	Offset: 0x8190
	Size: 0x3E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_8cbef8fd(entity, asmstatename)
{
	if(function_ef973b70(entity) === 2)
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_b5b42347
	Namespace: zm_ai_blight_father
	Checksum: 0xCE5391DF
	Offset: 0x81D8
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_b5b42347(entity)
{
	entity.var_bef7624d = undefined;
	function_f108c0ea(entity);
}

/*
	Name: function_c0ea1203
	Namespace: zm_ai_blight_father
	Checksum: 0xDCD1F57E
	Offset: 0x8210
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c0ea1203(grappler)
{
	grappler endon(#"death", #"hash_2fb2eddfa6a0ef3f");
	self waittill(#"disconnect");
	thread function_25f9cc48(grappler);
}

/*
	Name: function_5e853c85
	Namespace: zm_ai_blight_father
	Checksum: 0x1164BF72
	Offset: 0x8278
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5e853c85(grappler)
{
	self endon(#"disconnect");
	grappler waittill(#"death", #"hash_2fb2eddfa6a0ef3f");
	self.var_f4e33249 = 0;
}

/*
	Name: function_e989972e
	Namespace: zm_ai_blight_father
	Checksum: 0xF9FEBEB8
	Offset: 0x82D0
	Size: 0xA8
	Parameters: 1
	Flags: Private
*/
function private function_e989972e(grappler)
{
	/#
		self endon(#"disconnect");
		grappler endon(#"death", #"hash_2fb2eddfa6a0ef3f");
		while(true)
		{
			if(self isinmovemode("", ""))
			{
				grappler function_76c1f56f();
				function_c526065b(grappler);
			}
			wait(0.1);
		}
	#/
}

/*
	Name: function_62b3b7a3
	Namespace: zm_ai_blight_father
	Checksum: 0xB723756B
	Offset: 0x8380
	Size: 0x1D0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_62b3b7a3(entity)
{
	grapplee = entity.e_grapplee;
	if(isdefined(grapplee))
	{
		entity thread function_d67c455e();
		if(isdefined(grapplee.var_ca015b6f))
		{
			grapplee.var_ca015b6f unlink();
			var_938dbbaa = vectortoangles(entity.origin - grapplee.var_ca015b6f.origin);
			var_7e28b231 = entity gettagangles("tag_tongue");
			grapplee.var_ca015b6f linkto(entity, "tag_tongue", vectorscale((0, 0, 1), 35) * -1, (var_7e28b231[0] * -1, var_938dbbaa[1] - var_7e28b231[1], var_7e28b231[2] * -1));
			grapplee setplayercollision(1);
		}
		else
		{
			function_c526065b(entity);
		}
		/#
			println("" + (distance(function_f9d9f198(entity), grapplee.origin + vectorscale((0, 0, 1), 35))));
		#/
	}
	return true;
}

/*
	Name: function_1d2646
	Namespace: zm_ai_blight_father
	Checksum: 0x1271F3DA
	Offset: 0x8558
	Size: 0x25C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1d2646(entity)
{
	var_78a5a6c3 = 0;
	grapplee = entity.e_grapplee;
	if(isdefined(grapplee) && isplayer(grapplee) && (!(isdefined(grapplee.var_16735873) && grapplee.var_16735873)) && (!(isdefined(grapplee.var_77f481e1) && grapplee.var_77f481e1)))
	{
		grapplee.var_f4e33249 = 1;
		var_78a5a6c3 = 1;
		var_8aa5bbfb = entity gettagorigin("tag_jaw") - grapplee geteye();
		angles = vectortoangles(var_8aa5bbfb);
		grapplee setplayerangles((angles[0], angles[1], grapplee.angles[2]));
		grapplee thread function_c0ea1203(entity);
		grapplee thread function_5e853c85(entity);
		/#
			grapplee thread function_e989972e(entity);
		#/
	}
	if(!var_78a5a6c3 && entity.var_e6c8672d < ai::function_9139c839().var_4afa14d6)
	{
		if(math::cointoss())
		{
			entity.var_e6c8672d = entity.var_e6c8672d + 2;
		}
		else
		{
			entity.var_e6c8672d++;
		}
	}
	else
	{
		entity.var_e6c8672d = 1;
		function_35edac9c(entity);
	}
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_563d56de
	Namespace: zm_ai_blight_father
	Checksum: 0x8B7DAA8D
	Offset: 0x87C0
	Size: 0x48
	Parameters: 1
	Flags: Linked, Private
*/
function private function_563d56de(entity)
{
	if(isdefined(entity.var_e6c8672d))
	{
		return entity.var_e6c8672d < entity ai::function_9139c839().var_4afa14d6;
	}
	return 0;
}

/*
	Name: function_d6fbf1b7
	Namespace: zm_ai_blight_father
	Checksum: 0x3189BD18
	Offset: 0x8810
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d6fbf1b7(entity)
{
	return zombie_utility::is_player_valid(entity.e_grapplee, undefined, undefined, 0);
}

/*
	Name: function_bc3eb15a
	Namespace: zm_ai_blight_father
	Checksum: 0xFD00467E
	Offset: 0x8848
	Size: 0x174
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bc3eb15a(entity)
{
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
	if(isdefined(entity.e_grapplee))
	{
		grapplee = entity.e_grapplee;
		var_7981cbb7 = angleclamp180(vectortoangles(entity gettagorigin("j_head") - grapplee geteye())[0]);
		var_495f8389 = abs(var_7981cbb7 - 10);
		var_6f2b0bce = max(var_7981cbb7 + 10, 0);
		if(isplayer(grapplee) && grapplee islinkedto(grapplee.var_ca015b6f))
		{
			grapplee lerpviewangleclamp(0, 0, 0, 20, 20, var_495f8389, var_6f2b0bce);
		}
	}
}

/*
	Name: function_1d9f449a
	Namespace: zm_ai_blight_father
	Checksum: 0x2CE63045
	Offset: 0x89C8
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1d9f449a(entity)
{
	grapplee = entity.e_grapplee;
	return isdefined(grapplee) && !zombie_utility::is_player_valid(grapplee, undefined, undefined, 0);
}

/*
	Name: function_25f9cc48
	Namespace: zm_ai_blight_father
	Checksum: 0xB20230CD
	Offset: 0x8A18
	Size: 0x6C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_25f9cc48(entity)
{
	entity notify(#"hash_2fb2eddfa6a0ef3f");
	entity clientfield::set("blight_father_vomit_fx", 0);
	function_35edac9c(entity);
	entity thread function_d67c455e();
}

/*
	Name: function_1177eb85
	Namespace: zm_ai_blight_father
	Checksum: 0x320ED2EB
	Offset: 0x8A90
	Size: 0x4C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1177eb85(entity)
{
	function_25f9cc48(entity);
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_1dac0714
	Namespace: zm_ai_blight_father
	Checksum: 0xCA1A55B5
	Offset: 0x8AE8
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1dac0714(entity)
{
	function_25f9cc48(entity);
	function_c526065b(entity);
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_fc84db95
	Namespace: zm_ai_blight_father
	Checksum: 0xA523D268
	Offset: 0x8B58
	Size: 0x24
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fc84db95(entity)
{
	function_1dac0714(entity);
}

/*
	Name: function_2ed4a174
	Namespace: zm_ai_blight_father
	Checksum: 0x86D9BB96
	Offset: 0x8B88
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2ed4a174(entity)
{
	if(isdefined(entity.var_cdc2bec8) && entity.var_cdc2bec8 > entity ai::function_9139c839().var_2c6cfada)
	{
		return true;
	}
	return false;
}

/*
	Name: function_744be31d
	Namespace: zm_ai_blight_father
	Checksum: 0x7C00F3CA
	Offset: 0x8BE8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_744be31d(player)
{
	if(self.e_grapplee !== player)
	{
		return;
	}
	self ai::stun();
}

/*
	Name: function_7a634eaa
	Namespace: zm_ai_blight_father
	Checksum: 0x5C7BAAB
	Offset: 0x8C28
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7a634eaa(entity)
{
	grapplee = entity.e_grapplee;
	if(isdefined(grapplee))
	{
		entity clientfield::set("blight_father_vomit_fx", 1);
		grapplee thread function_d5ba6cc6(entity, grapplee);
	}
	else
	{
		entity clientfield::set("blight_father_vomit_fx", 2);
		function_a0edafd0(entity);
	}
}

/*
	Name: function_d5ba6cc6
	Namespace: zm_ai_blight_father
	Checksum: 0xF3931D59
	Offset: 0x8CE0
	Size: 0x144
	Parameters: 2
	Flags: Linked, Private
*/
function private function_d5ba6cc6(blight_father, player)
{
	player endon(#"death", #"disconnect");
	player clientfield::set_to_player("blight_father_vomit_postfx_clientfield", 1);
	while(isdefined(blight_father) && isalive(blight_father) && zm_utility::is_player_valid(blight_father.e_grapplee, undefined, undefined, undefined, 0) && blight_father.e_grapplee === player)
	{
		player dodamage(blight_father ai::function_9139c839().var_b995c667, blight_father.origin, blight_father, blight_father);
		wait(blight_father ai::function_9139c839().var_7334215);
	}
	if(isdefined(player))
	{
		player clientfield::set_to_player("blight_father_vomit_postfx_clientfield", 0);
	}
}

/*
	Name: function_b3f66ac3
	Namespace: zm_ai_blight_father
	Checksum: 0xC6D546F1
	Offset: 0x8E30
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b3f66ac3(entity)
{
	entity clientfield::set("blight_father_vomit_fx", 0);
	function_f108c0ea(entity);
}

/*
	Name: function_51ead3e8
	Namespace: zm_ai_blight_father
	Checksum: 0xF895D2C9
	Offset: 0x8E80
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_51ead3e8(entity)
{
	entity showpart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_bb6aa70c
	Namespace: zm_ai_blight_father
	Checksum: 0x88766D4A
	Offset: 0x8EC0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bb6aa70c(entity)
{
	entity hidepart("tag_tongue_grab", "c_t8_zmb_blightfather_tongue2", 1);
}

/*
	Name: function_7fe36aac
	Namespace: zm_ai_blight_father
	Checksum: 0x70CDDE14
	Offset: 0x8F00
	Size: 0x1FA
	Parameters: 2
	Flags: Linked, Private
*/
function private function_7fe36aac(entity, minplayerdist)
{
	playerpositions = [];
	foreach(player in getplayers())
	{
		if(!isdefined(playerpositions))
		{
			playerpositions = [];
		}
		else if(!isarray(playerpositions))
		{
			playerpositions = array(playerpositions);
		}
		if(!isinarray(playerpositions, (isdefined(player.last_valid_position) ? player.last_valid_position : player.origin)))
		{
			playerpositions[playerpositions.size] = (isdefined(player.last_valid_position) ? player.last_valid_position : player.origin);
		}
	}
	position = getclosestpointonnavmesh(entity.origin, 128, entity getpathfindingradius());
	if(!isdefined(position))
	{
		return false;
	}
	pathdata = generatenavmeshpath(position, playerpositions, entity);
	if(isdefined(pathdata) && pathdata.status === "succeeded" && pathdata.pathdistance < minplayerdist)
	{
		return false;
	}
	return true;
}

/*
	Name: function_c90a5ebb
	Namespace: zm_ai_blight_father
	Checksum: 0xB438CED8
	Offset: 0x9108
	Size: 0x9A
	Parameters: 4
	Flags: Linked, Private
*/
function private function_c90a5ebb(entity, attribute, oldvalue, value)
{
	if(!value)
	{
		var_65ba9602 = zm_lockdown_util::function_87c1193e(entity);
		if(isdefined(var_65ba9602))
		{
			zm_lockdown_util::function_77caff8b(var_65ba9602);
			entity.var_3acacb18 = undefined;
			entity.b_ignore_cleanup = entity.var_ca0d8389;
			entity.var_ca0d8389 = undefined;
		}
	}
}

/*
	Name: function_7055b26
	Namespace: zm_ai_blight_father
	Checksum: 0x8335A118
	Offset: 0x91B0
	Size: 0x752
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7055b26(entity)
{
	/#
		zm_lockdown_util::function_f3cff6ff(entity);
	#/
	if(zm_utility::is_standard() && level flag::exists("started_defend_area") && level flag::get("started_defend_area"))
	{
		entity.var_3acacb18 = undefined;
		return;
	}
	if(entity clientfield::get("blight_father_vomit_fx"))
	{
		return;
	}
	if(!entity ai::get_behavior_attribute("lockdown_enabled"))
	{
		return;
	}
	if(isdefined(entity.var_c8f98f87) && entity.var_c8f98f87 || zombiebehavior::zombieshouldmeleecondition(entity) || function_4bd1c37e(entity))
	{
		return;
	}
	var_65ba9602 = zm_lockdown_util::function_87c1193e(entity);
	if(isdefined(var_65ba9602))
	{
		if(!zm_lockdown_util::function_c9105448(entity, var_65ba9602))
		{
			zm_lockdown_util::function_77caff8b(var_65ba9602);
			entity.var_3acacb18 = undefined;
			entity.b_ignore_cleanup = entity.var_ca0d8389;
			entity.var_ca0d8389 = undefined;
		}
		return;
	}
	entity.var_3acacb18 = undefined;
	if(self.var_e38eaee5 > gettime())
	{
		return;
	}
	stub_types = [];
	if(!isdefined(stub_types))
	{
		stub_types = [];
	}
	else if(!isarray(stub_types))
	{
		stub_types = array(stub_types);
	}
	stub_types[stub_types.size] = "lockdown_stub_type_wallbuys";
	if(!isdefined(stub_types))
	{
		stub_types = [];
	}
	else if(!isarray(stub_types))
	{
		stub_types = array(stub_types);
	}
	stub_types[stub_types.size] = "lockdown_stub_type_crafting_tables";
	if(!isdefined(stub_types))
	{
		stub_types = [];
	}
	else if(!isarray(stub_types))
	{
		stub_types = array(stub_types);
	}
	stub_types[stub_types.size] = "lockdown_stub_type_perks";
	if(!isdefined(stub_types))
	{
		stub_types = [];
	}
	else if(!isarray(stub_types))
	{
		stub_types = array(stub_types);
	}
	stub_types[stub_types.size] = "lockdown_stub_type_pap";
	if(!isdefined(stub_types))
	{
		stub_types = [];
	}
	else if(!isarray(stub_types))
	{
		stub_types = array(stub_types);
	}
	stub_types[stub_types.size] = "lockdown_stub_type_magic_box";
	max_height = entity ai::function_9139c839().var_ee9586a9;
	if(isdefined(level.var_1c666963))
	{
		max_height = level.var_1c666963;
	}
	registerlotus_right = zm_lockdown_util::function_9b84bb88(entity, stub_types, entity ai::function_9139c839().var_8ae9a3a7, max_height);
	entity.var_e38eaee5 = gettime() + 500;
	if(registerlotus_right.size == 0)
	{
		return;
	}
	stub = registerlotus_right[0];
	if(!function_7fe36aac(entity, entity ai::function_9139c839().var_182ee089))
	{
		return;
	}
	var_4afb24b6 = zm_lockdown_util::function_dab6d796(entity, stub);
	if(!isdefined(var_4afb24b6))
	{
		/#
			println(((("" + entity getentitynumber()) + "") + stub.origin) + "");
		#/
		var_7162cf15 = zm_utility::function_b0eeaada(stub.origin);
		halfheight = 32;
		if(!isdefined(var_7162cf15))
		{
			var_7162cf15 = [];
			var_7162cf15[#"point"] = stub.origin;
			halfheight = (stub.origin - zm_utility::groundpos(stub.origin)[2]) + 1;
		}
		var_239124a9 = positionquery_source_navigation(var_7162cf15[#"point"], 0, 256, halfheight, 20, 1);
		if(var_239124a9.data.size == 0)
		{
			return;
		}
		start_origin = var_239124a9.data[0].origin;
	}
	else
	{
		var_adac1439 = entity astsearch("purchase_lockdown_vomit@blight_father");
		animname = animationstatenetworkutility::searchanimationmap(entity, var_adac1439[#"animation"]);
		start_origin = getstartorigin(var_4afb24b6.origin, var_4afb24b6.angles, animname);
	}
	if(!ispointonnavmesh(start_origin, entity))
	{
		/#
			if(isdefined(var_4afb24b6))
			{
				zm_lockdown_util::function_78eae22a(entity, stub, 14, start_origin, var_4afb24b6);
			}
		#/
		return;
	}
	zm_lockdown_util::function_50ba1eb0(entity, stub);
	entity setblackboardattribute("_lockdown_type", zm_lockdown_util::function_22aeb4e9(stub.lockdowntype));
	entity.var_ca0d8389 = entity.b_ignore_cleanup;
	entity.b_ignore_cleanup = 1;
	entity.var_3acacb18 = start_origin;
}

/*
	Name: function_b57f31b6
	Namespace: zm_ai_blight_father
	Checksum: 0xBDDC4FEC
	Offset: 0x9910
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_b57f31b6(player)
{
	if(isdefined(level.var_3e10516a) && level.var_3e10516a)
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_1fa0254afe1fa66");
		}
		else
		{
			self sethintstring(#"hash_3aa47b7b8258ebd2");
		}
	}
	else
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_76208e521ab783c1", 500);
		}
		else
		{
			self sethintstring(#"hash_5ef6d21d81a0250b", 500);
		}
	}
	return zm_lockdown_util::function_b5dd9241(self.stub);
}

/*
	Name: function_158a1b7e
	Namespace: zm_ai_blight_father
	Checksum: 0x2FD017F5
	Offset: 0x9A20
	Size: 0x140
	Parameters: 0
	Flags: Linked, Private
*/
function private function_158a1b7e()
{
	self endon(#"death");
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(!isdefined(waitresult.activator) || !zm_utility::is_player_valid(waitresult.activator) || (isdefined(self.stub) && (isdefined(self.stub.var_6156031a) && self.stub.var_6156031a)))
		{
			continue;
		}
		player = waitresult.activator;
		if(!player zm_score::can_player_purchase(500))
		{
			continue;
		}
		player zm_score::minus_to_player_score(500);
		self.stub thread zm_lockdown_util::function_61a9bc58();
		player playsoundtoplayer(#"hash_4d5ca6fb8f2395de", player);
	}
}

/*
	Name: function_d6e82d62
	Namespace: zm_ai_blight_father
	Checksum: 0xD87B1680
	Offset: 0x9B68
	Size: 0x64
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d6e82d62(stub)
{
	if(isdefined(stub.var_bebc05f5))
	{
		stub thread function_b9a828e1(stub.var_bebc05f5);
	}
	wait(getdvarfloat(#"hash_2f19f037c4f8ddc9", 2));
}

/*
	Name: function_b9a828e1
	Namespace: zm_ai_blight_father
	Checksum: 0xEDC8F2E5
	Offset: 0x9BD8
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_b9a828e1(model)
{
	model clientfield::set("blight_father_purchase_lockdown_vomit_fx", 0);
	util::wait_network_frame();
	if(isentity(model) && isdefined(model))
	{
		model delete();
	}
}

/*
	Name: function_e1ba6416
	Namespace: zm_ai_blight_father
	Checksum: 0xE2A1A1B1
	Offset: 0x9C58
	Size: 0xC0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e1ba6416(entity)
{
	if(isdefined(entity.var_c8f98f87) && entity.var_c8f98f87)
	{
		return false;
	}
	if(!zm_lockdown_util::function_7bfa8895(entity))
	{
		return false;
	}
	if(!isdefined(entity.var_3acacb18))
	{
		return false;
	}
	if(distance2dsquared(entity.var_3acacb18, entity.origin) > entity ai::function_9139c839().var_6b3398a5 * entity ai::function_9139c839().var_6b3398a5)
	{
		return false;
	}
	return true;
}

/*
	Name: function_a0edafd0
	Namespace: zm_ai_blight_father
	Checksum: 0x66197FBD
	Offset: 0x9D20
	Size: 0x292
	Parameters: 1
	Flags: Linked, Private
*/
function private function_a0edafd0(entity)
{
	if(zm_lockdown_util::function_7bfa8895(entity))
	{
		stub = zm_lockdown_util::function_7258b5cc(entity, &function_b57f31b6, &function_158a1b7e, &function_d6e82d62);
		if(!isdefined(stub))
		{
			return;
		}
		switch(stub.lockdowntype)
		{
			case "lockdown_stub_type_perks":
			{
				var_680c2eca = 2;
				var_8354cf7d = zm_lockdown_util::function_da72073(stub);
				break;
			}
			case "lockdown_stub_type_magic_box":
			{
				var_680c2eca = 3;
				var_8354cf7d = zm_lockdown_util::function_da72073(stub);
				break;
			}
			case "lockdown_stub_type_crafting_tables":
			{
				var_680c2eca = 4;
				var_8354cf7d = zm_lockdown_util::function_da72073(stub);
				break;
			}
			case "lockdown_stub_type_pap":
			case "lockdown_stub_type_wallbuys":
			{
				var_8354cf7d = zm_lockdown_util::function_da72073(stub);
			}
			var_680c2eca = 1;
			break;
		}
		if(stub.lockdowntype === "lockdown_stub_type_crafting_tables" && stub.script_string === "its_a_trap")
		{
			var_680c2eca = 3;
		}
		if(!isdefined(var_8354cf7d))
		{
			v_origin = stub.origin;
			v_angles = stub.angles;
		}
		else
		{
			v_origin = var_8354cf7d.origin;
			v_angles = var_8354cf7d.angles;
		}
		stub.var_bebc05f5 = function_69b8daf(v_origin, v_angles);
		stub.var_bebc05f5 clientfield::set("blight_father_purchase_lockdown_vomit_fx", var_680c2eca);
		entity.var_3acacb18 = undefined;
		entity.b_ignore_cleanup = entity.var_ca0d8389;
		entity.var_ca0d8389 = undefined;
	}
}

/*
	Name: function_6ab8460f
	Namespace: zm_ai_blight_father
	Checksum: 0xEB8D6574
	Offset: 0x9FC0
	Size: 0x1FC
	Parameters: 5
	Flags: Linked, Private
*/
function private function_6ab8460f(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	stub = zm_lockdown_util::function_87c1193e(entity);
	var_4afb24b6 = zm_lockdown_util::function_dab6d796(entity, stub);
	if(isdefined(var_4afb24b6))
	{
		start_origin = getstartorigin(var_4afb24b6.origin, var_4afb24b6.angles, mocompanim);
		start_angles = getstartangles(var_4afb24b6.origin, var_4afb24b6.angles, mocompanim);
	}
	else
	{
		/#
			println(((((((("" + entity getentitynumber()) + "") + entity.origin[0]) + "") + entity.origin[1]) + "") + entity.origin[2]) + "");
		#/
		start_origin = entity.origin;
		start_angles = entity.angles;
	}
	entity forceteleport(start_origin, start_angles);
	entity animmode("noclip", 1);
	entity orientmode("face angle", start_angles[1]);
}

/*
	Name: function_37d1a803
	Namespace: zm_ai_blight_father
	Checksum: 0x841BFA01
	Offset: 0xA1C8
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_37d1a803(entity)
{
	return entity ai::function_9139c839().var_f246f6de;
}

/*
	Name: function_71b8279d
	Namespace: zm_ai_blight_father
	Checksum: 0xD4CAAB45
	Offset: 0xA200
	Size: 0x28
	Parameters: 1
	Flags: Linked, Private
*/
function private function_71b8279d(entity)
{
	return isdefined(entity.var_6ee32f47) && entity.var_6ee32f47;
}

/*
	Name: function_63b7576d
	Namespace: zm_ai_blight_father
	Checksum: 0xBBA1F731
	Offset: 0xA230
	Size: 0x8C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_63b7576d()
{
	var_3c533fa2 = 0;
	foreach(trigger in level.var_445e24c8)
	{
		if(!trigger.inuse)
		{
			var_3c533fa2++;
		}
	}
	return var_3c533fa2;
}

/*
	Name: function_c48604c0
	Namespace: zm_ai_blight_father
	Checksum: 0x3B6B5EFE
	Offset: 0xA2C8
	Size: 0xA8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c48604c0()
{
	foreach(trigger in level.var_445e24c8)
	{
		if(!trigger.inuse)
		{
			trigger.inuse = 1;
			trigger triggerenable(1);
			return trigger;
		}
	}
	return undefined;
}

/*
	Name: function_da2c4ce9
	Namespace: zm_ai_blight_father
	Checksum: 0x35034631
	Offset: 0xA378
	Size: 0x42
	Parameters: 1
	Flags: Linked, Private
*/
function private function_da2c4ce9(trigger)
{
	trigger.inuse = 0;
	trigger triggerenable(0);
	trigger.origin = (0, 0, 0);
}

/*
	Name: function_8383fdf9
	Namespace: zm_ai_blight_father
	Checksum: 0xC6E2940E
	Offset: 0xA3C8
	Size: 0x48
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8383fdf9(entity)
{
	var_329b1080 = function_19249d10(entity);
	function_3782350(entity);
	return var_329b1080;
}

/*
	Name: function_19249d10
	Namespace: zm_ai_blight_father
	Checksum: 0x6DE195F8
	Offset: 0xA418
	Size: 0x684
	Parameters: 1
	Flags: Linked, Private
*/
function private function_19249d10(entity)
{
	if(isdefined(level.var_9cfa4efd) && level.var_9cfa4efd)
	{
		return false;
	}
	if(level.var_fcb96175 > gettime())
	{
		return false;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return false;
	}
	if(!isplayer(entity.favoriteenemy))
	{
		return false;
	}
	if(isdefined(entity.var_81ce9fcd))
	{
		return false;
	}
	if(isdefined(entity.var_177b7a47) && entity.var_177b7a47 && (isdefined(entity.var_7c54fb46) && entity.var_7c54fb46))
	{
		return false;
	}
	if(isdefined(level.var_79b2615b) && level.var_79b2615b != entity && isalive(level.var_79b2615b))
	{
		return false;
	}
	if(!function_71b8279d(entity) && entity.var_b2a80abc > gettime())
	{
		return false;
	}
	var_d0651e10 = function_63b7576d();
	if(var_d0651e10 <= 0)
	{
		return false;
	}
	if(!(isdefined(entity.var_177b7a47) && entity.var_177b7a47) && (!(isdefined(entity.var_7c54fb46) && entity.var_7c54fb46)) && var_d0651e10 < 3)
	{
		return false;
	}
	forward = anglestoforward(entity.angles);
	forward2d = vectornormalize((forward[0], forward[1], 0));
	dirtotarget = entity.favoriteenemy.origin - entity.origin;
	var_854904a = vectornormalize((dirtotarget[0], dirtotarget[1], 0));
	dot = vectordot(forward2d, var_854904a);
	if(dot < entity ai::function_9139c839().var_aa503e5a)
	{
		return false;
	}
	test_trace = function_5d7f8057(entity, entity.favoriteenemy);
	if(test_trace[#"fraction"] < 1 && test_trace[#"entity"] !== entity.favoriteenemy)
	{
		return false;
	}
	height = self.maxs[2] - self.mins[2];
	forward = anglestoforward(self.angles);
	var_725b8fb5 = forward * entity ai::function_9139c839().var_167cbf22;
	var_edabd3cd = bullettracepassed(self.origin + (0, 0, height), (self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);
	/#
		recordline(self.origin + (0, 0, height), (self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));
	#/
	if(var_edabd3cd)
	{
		var_c46a2de3 = forward * entity ai::function_9139c839().var_baa42d79;
		var_edabd3cd = bullettracepassed((self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), (self.origin + var_c46a2de3) + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);
		/#
			recordline((self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), (self.origin + var_c46a2de3) + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));
		#/
	}
	if(!var_edabd3cd)
	{
		return false;
	}
	var_9c2b856b = distancesquared(entity.origin, entity.favoriteenemy.origin);
	if(var_9c2b856b < (entity ai::function_9139c839().var_cdf6b76d * entity ai::function_9139c839().var_cdf6b76d) || var_9c2b856b > (entity ai::function_9139c839().var_652a36f2 * entity ai::function_9139c839().var_652a36f2))
	{
		return false;
	}
	return true;
}

/*
	Name: function_d5a0a1eb
	Namespace: zm_ai_blight_father
	Checksum: 0x9AD1523F
	Offset: 0xAAA8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d5a0a1eb(entity)
{
	entity clientfield::set("blight_father_amb_sac_clientfield", 0);
}

/*
	Name: function_e0d8f770
	Namespace: zm_ai_blight_father
	Checksum: 0xCD9C412F
	Offset: 0xAAE0
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e0d8f770(entity)
{
	entity.var_b2a80abc = gettime() + function_37d1a803(entity);
	level.var_79b2615b = undefined;
	entity clientfield::set("blight_father_amb_sac_clientfield", 1);
}

/*
	Name: function_d2b91209
	Namespace: zm_ai_blight_father
	Checksum: 0x98D80C85
	Offset: 0xAB48
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d2b91209(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		/#
			println("");
		#/
		return;
	}
	entity clientfield::increment("blight_father_spawn_maggot_fx_left");
	entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, vectorscale((0, 0, 1), 5), "tag_sac_fx_le");
}

/*
	Name: function_78f5c48e
	Namespace: zm_ai_blight_father
	Checksum: 0x171AA134
	Offset: 0xABE8
	Size: 0x94
	Parameters: 1
	Flags: Linked, Private
*/
function private function_78f5c48e(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		/#
			println("");
		#/
		return;
	}
	entity clientfield::increment("blight_father_spawn_maggot_fx_right");
	entity thread blightfatherlaunchchaosmissile(entity.favoriteenemy, vectorscale((0, 0, 1), 5), "tag_sac_fx_ri");
}

/*
	Name: function_ebd22bba
	Namespace: zm_ai_blight_father
	Checksum: 0xC9469F84
	Offset: 0xAC88
	Size: 0x4C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ebd22bba()
{
	self endon(#"death");
	util::wait_network_frame();
	self clientfield::set("blight_father_maggot_trail_fx", 1);
}

/*
	Name: blightfatherlaunchchaosmissile
	Namespace: zm_ai_blight_father
	Checksum: 0x449A7532
	Offset: 0xACE0
	Size: 0x568
	Parameters: 3
	Flags: Linked, Private
*/
function private blightfatherlaunchchaosmissile(var_f794172e, var_61622673, var_f3486358)
{
	var_ced3ec54 = self gettagorigin(var_f3486358);
	var_27e1ee12 = var_f794172e.origin + var_61622673;
	if(isdefined(self.var_6ee32f47) && self.var_6ee32f47)
	{
		self.var_6ee32f47 = 0;
	}
	var_892397fd = util::spawn_model(#"tag_origin", var_ced3ec54);
	if(!isdefined(var_892397fd))
	{
		return;
	}
	var_a9494306 = function_c48604c0();
	if(!isdefined(var_a9494306))
	{
		var_892397fd delete();
		return;
	}
	var_a9494306.origin = var_892397fd.origin;
	var_a9494306.angles = var_892397fd.angles;
	var_a9494306 linkto(var_892397fd, "tag_origin");
	var_892397fd.trigger = var_a9494306;
	var_892397fd thread function_b2be1340(self ai::function_9139c839().var_a2519bb8);
	var_892397fd thread function_ebd22bba();
	var_892397fd thread function_a6a20b2c(var_a9494306);
	var_892397fd.var_f3d1c928 = 0;
	var_892397fd.var_52334e8c = self;
	angles_to_enemy = self gettagangles(var_f3486358);
	normal_vector = anglestoforward(angles_to_enemy);
	var_892397fd.angles = angles_to_enemy;
	var_892397fd.var_209ff2fa = normal_vector * self ai::function_9139c839().var_f988064f;
	max_trail_iterations = int(self ai::function_9139c839().var_652a36f2 / (self ai::function_9139c839().var_52bddd4 * self ai::function_9139c839().var_9e5ebf3c));
	var_892397fd.missile_target = var_f794172e;
	var_892397fd thread function_5f3390fd(var_61622673, 40);
	var_892397fd playloopsound(#"hash_5b21b7c645692f8", 0.1);
	var_892397fd moveto(self gettagorigin(var_f3486358) + var_61622673, self ai::function_9139c839().var_20c6e4ca);
	var_eb325a79 = self ai::function_9139c839().var_9e5ebf3c;
	var_b446b077 = self ai::function_9139c839().var_94fefe66;
	var_3fa92868 = self ai::function_9139c839().var_52bddd4;
	wait(self ai::function_9139c839().var_20c6e4ca);
	while(isdefined(var_892397fd))
	{
		if(!zombie_utility::is_player_valid(var_892397fd.missile_target, 1))
		{
			var_892397fd.missile_target = undefined;
			players = getplayers();
			players = arraysortclosest(players, var_892397fd.origin);
			foreach(player in players)
			{
				if(zombie_utility::is_player_valid(player, 1))
				{
					var_892397fd.missile_target = player;
					break;
				}
			}
		}
		if(var_892397fd.var_f3d1c928 >= max_trail_iterations)
		{
			var_892397fd thread function_124486ee(0);
		}
		else
		{
			var_892397fd function_1974d26f(var_3fa92868, var_b446b077, var_eb325a79);
			var_892397fd.var_f3d1c928 = var_892397fd.var_f3d1c928 + 1;
		}
		wait(var_eb325a79);
	}
}

/*
	Name: function_a6a20b2c
	Namespace: zm_ai_blight_father
	Checksum: 0x67FAA8C0
	Offset: 0xB250
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_a6a20b2c(var_3797b49d)
{
	self waittill(#"death");
	var_3797b49d unlink();
	function_da2c4ce9(var_3797b49d);
}

/*
	Name: function_b2be1340
	Namespace: zm_ai_blight_father
	Checksum: 0x4458453F
	Offset: 0xB2A8
	Size: 0xE4
	Parameters: 1
	Flags: Linked
*/
function function_b2be1340(starting_health)
{
	self endon(#"detonated");
	self.n_health = starting_health;
	while(self.n_health > 0)
	{
		s_notify = undefined;
		s_notify = self.trigger waittill(#"damage");
		if(isdefined(s_notify.attacker) && isplayer(s_notify.attacker) && s_notify.amount > 0)
		{
			self.n_health = self.n_health - s_notify.amount;
		}
	}
	self thread function_124486ee(0);
}

/*
	Name: function_581a06c7
	Namespace: zm_ai_blight_father
	Checksum: 0xA11BEB78
	Offset: 0xB398
	Size: 0x10E
	Parameters: 4
	Flags: Private
*/
function private function_581a06c7(forward_dir, var_ced3ec54, var_27e1ee12, max_angle)
{
	vec_to_enemy = var_27e1ee12 - var_ced3ec54;
	vec_to_enemy_normal = vectornormalize(vec_to_enemy);
	angle_to_enemy = vectordot(forward_dir, vec_to_enemy_normal);
	if(angle_to_enemy >= max_angle)
	{
		return vec_to_enemy_normal;
	}
	plane_normal = vectorcross(forward_dir, vec_to_enemy_normal);
	perpendicular_normal = vectorcross(plane_normal, forward_dir);
	var_21f9edfd = (forward_dir * cos(max_angle)) + (perpendicular_normal * sin(max_angle));
	return var_21f9edfd;
}

/*
	Name: function_5f3390fd
	Namespace: zm_ai_blight_father
	Checksum: 0x29D9A8AB
	Offset: 0xB4B0
	Size: 0x18E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5f3390fd(var_61622673, var_4fee43d4)
{
	self endon(#"death", #"detonated");
	var_892397fd = self;
	while(isdefined(var_892397fd))
	{
		player_origins = [];
		players = getplayers();
		foreach(player in players)
		{
			if(!isdefined(player_origins))
			{
				player_origins = [];
			}
			else if(!isarray(player_origins))
			{
				player_origins = array(player_origins);
			}
			player_origins[player_origins.size] = player getplayercamerapos();
		}
		players = arraysortclosest(player_origins, var_892397fd.origin, undefined, 0, var_4fee43d4);
		if(players.size > 0)
		{
			var_892397fd thread function_124486ee(0);
		}
		waitframe(1);
	}
}

/*
	Name: function_1974d26f
	Namespace: zm_ai_blight_father
	Checksum: 0x72042078
	Offset: 0xB648
	Size: 0x394
	Parameters: 3
	Flags: Linked, Private
*/
function private function_1974d26f(var_3fa92868, var_10ed5867, var_eb325a79)
{
	self endon(#"detonated", #"death");
	if(!isdefined(self.var_3b8e09f5))
	{
		self.var_3b8e09f5 = cos(var_10ed5867 * var_eb325a79);
	}
	if(isdefined(self.missile_target) && isdefined(self.var_209ff2fa))
	{
		var_6d0a510 = self.missile_target getcentroid();
		if(isplayer(self.missile_target))
		{
			var_6d0a510 = self.missile_target getplayercamerapos();
		}
		vector_to_target = var_6d0a510 - self.origin;
		normal_vector = vectornormalize(vector_to_target);
		dot = vectordot(normal_vector, self.var_209ff2fa);
		if(dot >= 1)
		{
			dot = 1;
		}
		else if(dot <= -1)
		{
			dot = -1;
		}
		new_vector = normal_vector - self.var_209ff2fa;
		angle_between_vectors = acos(dot);
		if(!isdefined(angle_between_vectors))
		{
			angle_between_vectors = 180;
		}
		if(angle_between_vectors == 0)
		{
			angle_between_vectors = 0.0001;
		}
		ratio = (var_10ed5867 * var_eb325a79) / angle_between_vectors;
		if(ratio > 1)
		{
			ratio = 1;
		}
		new_vector = new_vector * ratio;
		new_vector = new_vector + self.var_209ff2fa;
		normal_vector = vectornormalize(new_vector);
	}
	else
	{
		normal_vector = self.var_209ff2fa;
	}
	move_distance = var_3fa92868 * var_eb325a79;
	move_vector = (var_3fa92868 * var_eb325a79) * normal_vector;
	move_to_point = self.origin + move_vector;
	trace = bullettrace(self.origin, move_to_point, 0, self);
	if(trace[#"surfacetype"] !== "none")
	{
		detonate_point = trace[#"position"];
		dist_sq = distancesquared(detonate_point, self.origin);
		move_dist_sq = move_distance * move_distance;
		ratio = dist_sq / move_dist_sq;
		delay = ratio * var_eb325a79;
		self thread function_124486ee(delay);
	}
	self.var_209ff2fa = normal_vector;
	self moveto(move_to_point, var_eb325a79);
}

/*
	Name: function_124486ee
	Namespace: zm_ai_blight_father
	Checksum: 0x9F7C90C2
	Offset: 0xB9E8
	Size: 0x304
	Parameters: 1
	Flags: Linked, Private
*/
function private function_124486ee(delay)
{
	if(!isdefined(self))
	{
		return;
	}
	var_892397fd = self;
	missile_owner = var_892397fd.var_52334e8c;
	blast_radius = 128;
	var_83f35abe = 45;
	var_6927cfa0 = 40;
	var_c45ef84c = 40 * 40;
	if(delay > 0)
	{
		wait(delay);
	}
	if(isdefined(var_892397fd))
	{
		var_892397fd notify(#"detonated");
		var_892397fd moveto(var_892397fd.origin, 0.05);
		var_892397fd clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
		e_blightfather = var_892397fd.var_52334e8c;
		w_weapon = getweapon(#"none");
		var_892397fd function_8e8b1dfc(var_c45ef84c, e_blightfather, w_weapon);
		offset = vectorscale((0, 0, 1), 18);
		if(bullettracepassed(var_892397fd.origin, var_892397fd.origin + offset, 0, 1))
		{
			explosion_point = var_892397fd.origin + offset;
		}
		else
		{
			explosion_point = var_892397fd.origin;
		}
		util::wait_network_frame();
		players = getplayers();
		foreach(player in players)
		{
			player.var_c29c44ca = player.health;
		}
		radiusdamage(explosion_point, blast_radius, var_83f35abe, var_6927cfa0, e_blightfather, "MOD_UNKNOWN", w_weapon);
		function_44e3e0d1(explosion_point);
		if(isdefined(var_892397fd))
		{
			var_892397fd clientfield::set("blight_father_maggot_trail_fx", 0);
			var_892397fd delete();
		}
	}
}

/*
	Name: function_44e3e0d1
	Namespace: zm_ai_blight_father
	Checksum: 0x5B7BE4A3
	Offset: 0xBCF8
	Size: 0x29E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_44e3e0d1(var_51a7ab9c)
{
	players = getplayers();
	v_length = 100 * 100;
	for(i = 0; i < players.size; i++)
	{
		player = players[i];
		if(!isalive(player))
		{
			continue;
		}
		if(player.sessionstate == "spectator")
		{
			continue;
		}
		if(player.sessionstate == "intermission")
		{
			continue;
		}
		if(isdefined(player.ignoreme) && player.ignoreme)
		{
			continue;
		}
		if(player isnotarget())
		{
			continue;
		}
		if(isdefined(player.var_c29c44ca) && player.health >= player.var_c29c44ca)
		{
			continue;
		}
		n_distance = distance2dsquared(var_51a7ab9c, player.origin);
		if(n_distance < 0.01)
		{
			continue;
		}
		if(!bullettracepassed(var_51a7ab9c, player.origin, 0, 1))
		{
			continue;
		}
		if(n_distance < v_length)
		{
			v_dir = player.origin - var_51a7ab9c;
			v_dir = (v_dir[0], v_dir[1], 0.1);
			v_dir = vectornormalize(v_dir);
			n_push_strength = getdvarint(#"hash_708ca0a943843f57", 500);
			n_push_strength = 200 + (randomint(n_push_strength - 200));
			v_player_velocity = player getvelocity();
			player setvelocity(v_player_velocity + (v_dir * n_push_strength));
		}
	}
}

/*
	Name: function_8e8b1dfc
	Namespace: zm_ai_blight_father
	Checksum: 0xFC9B24DF
	Offset: 0xBFA0
	Size: 0x140
	Parameters: 3
	Flags: Linked, Private
*/
function private function_8e8b1dfc(var_c45ef84c, blight_father, weapon)
{
	foreach(player in level.activeplayers)
	{
		if(!isdefined(player))
		{
			continue;
		}
		distancesq = distancesquared(self.origin, player.origin + vectorscale((0, 0, 1), 48));
		if(distancesq > var_c45ef84c)
		{
			continue;
		}
		status_effect = getstatuseffect(#"hash_7867f8f9aaaa0c40");
		player status_effect::status_effect_apply(status_effect, weapon, blight_father);
		player clientfield::increment_to_player("blight_father_chaos_missile_rumble_clientfield", 1);
	}
}

/*
	Name: function_3dbdca02
	Namespace: zm_ai_blight_father
	Checksum: 0x885AF146
	Offset: 0xC0E8
	Size: 0x60
	Parameters: 0
	Flags: None
*/
function function_3dbdca02()
{
	level.var_1b8dabf3++;
	level.zombie_ai_limit--;
	self waittill(#"death");
	level.var_1b8dabf3--;
	level.zombie_ai_limit++;
	level notify(#"hash_5fb3aa7a0745af2c");
}

/*
	Name: function_39212989
	Namespace: zm_ai_blight_father
	Checksum: 0xD07EAA6C
	Offset: 0xC150
	Size: 0x20A
	Parameters: 0
	Flags: Linked
*/
function function_39212989()
{
	if(!self zm_ai_utility::function_db610082())
	{
		return 0;
	}
	if(isdefined(level.var_153e9058) && level.var_153e9058)
	{
		return 0;
	}
	if(isdefined(level.var_a2831281) && level.var_a2831281)
	{
		return 1;
	}
	if(isdefined(self.var_641025d6) && self.var_641025d6 > gettime())
	{
		return 0;
	}
	var_57bb4de2 = 0;
	foreach(player in level.players)
	{
		if(!isalive(player))
		{
			continue;
		}
		if(distancesquared(player.origin, self.origin) < 16384)
		{
			continue;
		}
		if(distancesquared(player.origin, self.origin) > 102400)
		{
			continue;
		}
		var_57bb4de2 = self sightconetrace(player.origin, player, anglestoforward(player.angles));
		var_2ade806 = 1;
		if(isdefined(level.var_d975e8e6))
		{
			var_2ade806 = self [[level.var_d975e8e6]]();
		}
		if(var_57bb4de2 && var_2ade806)
		{
			break;
		}
	}
	return var_57bb4de2 && var_2ade806;
}

/*
	Name: function_3a0cdf7f
	Namespace: zm_ai_blight_father
	Checksum: 0xCABCDA1A
	Offset: 0xC368
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_3a0cdf7f()
{
	self.b_ignore_cleanup = 1;
}

/*
	Name: function_8e4c43d3
	Namespace: zm_ai_blight_father
	Checksum: 0xBDB5FB3A
	Offset: 0xC388
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_8e4c43d3(n_health_percent)
{
}

/*
	Name: function_fa00e485
	Namespace: zm_ai_blight_father
	Checksum: 0x4E3B8419
	Offset: 0xC3A0
	Size: 0xE2
	Parameters: 1
	Flags: Linked
*/
function function_fa00e485(n_round_number)
{
	level endon(#"end_game");
	if(!isdefined(level.var_d47205b))
	{
		level.var_d47205b = 0;
	}
	while(true)
	{
		level waittill(#"hash_5d3012139f083ccb");
		if(zm_round_spawning::function_d0db51fc(#"blight_father") && (!(isdefined(level.var_153e9058) && level.var_153e9058)))
		{
			level.var_d47205b++;
			level.var_bd626b54 = level.round_number + function_21a3a673(3, 5);
		}
	}
}

/*
	Name: function_633d7436
	Namespace: zm_ai_blight_father
	Checksum: 0x65AC27C8
	Offset: 0xC490
	Size: 0x27A
	Parameters: 1
	Flags: Linked
*/
function function_633d7436(var_dbce0c44)
{
	forced = zm_trial_force_archetypes::function_ff2a74e7(#"blight_father");
	var_8cf00d40 = int(floor(var_dbce0c44 / 300));
	if(isdefined(level.var_bd626b54) && level.round_number < level.var_bd626b54 && !forced)
	{
		return 0;
	}
	var_2506688 = 0;
	var_1797c23a = 1;
	if(forced)
	{
		var_2506688 = 1;
	}
	n_player_count = zm_utility::function_a2541519(level.players.size);
	if(n_player_count == 1)
	{
		switch(level.var_d47205b)
		{
			case 0:
			case 1:
			case 2:
			{
				break;
			}
			default:
			{
				var_2506688 = 1;
			}
		}
	}
	else
	{
		switch(level.var_d47205b)
		{
			case 0:
			{
				break;
			}
			case 1:
			{
				var_1797c23a = 2;
				break;
			}
			case 2:
			{
				var_1797c23a = 3;
				break;
			}
			case 3:
			{
				var_2506688 = 1;
				var_1797c23a = 3;
				break;
			}
			case 4:
			{
				var_2506688 = 2;
				var_1797c23a = 3;
				break;
			}
			default:
			{
				var_2506688 = 3;
				var_1797c23a = 3;
			}
		}
	}
	return function_21a3a673(var_2506688, int(min(var_8cf00d40, var_1797c23a)));
}

/*
	Name: function_858c7fa5
	Namespace: zm_ai_blight_father
	Checksum: 0xD81B3F24
	Offset: 0xC718
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_858c7fa5()
{
	var_c64622d1 = function_a24ee603();
	var_3b01e91c = function_2f701be7();
	if(!(isdefined(level.var_a2831281) && level.var_a2831281) && (isdefined(level.var_153e9058) && level.var_153e9058 || var_c64622d1 >= var_3b01e91c || !level flag::get("spawn_zombies")))
	{
		return false;
	}
	return true;
}

/*
	Name: function_a24ee603
	Namespace: zm_ai_blight_father
	Checksum: 0x429AB1E4
	Offset: 0xC7E0
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_a24ee603()
{
	if(isdefined(level.var_95c10956))
	{
		return [[level.var_95c10956]]();
	}
	a_ai_blight_father = getaiarchetypearray(#"blight_father");
	a_ai_blight_father = array::remove_dead(a_ai_blight_father);
	var_8e350fd9 = a_ai_blight_father.size;
	if(isarray(level.var_b175714d) && isdefined(level.var_b175714d[#"blight_father"]) && isdefined(level.var_b175714d[#"blight_father"].var_33e393a7))
	{
		var_8e350fd9 = var_8e350fd9 + level.var_b175714d[#"blight_father"].var_33e393a7;
	}
	return var_8e350fd9;
}

/*
	Name: function_2f701be7
	Namespace: zm_ai_blight_father
	Checksum: 0x9EF5A2C
	Offset: 0xC8F0
	Size: 0xC2
	Parameters: 0
	Flags: Linked
*/
function function_2f701be7()
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
			return 3;
			break;
		}
		case 3:
		{
			return 3;
			break;
		}
		case 4:
		{
			return 3;
			break;
		}
		default:
		{
			return 3;
		}
	}
}

/*
	Name: round_spawn
	Namespace: zm_ai_blight_father
	Checksum: 0x33EBA9F0
	Offset: 0xC9C0
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function round_spawn()
{
	/#
		blight_father_spawners = getspawnerarray("", "");
		if(blight_father_spawners.size == 0)
		{
			iprintln("");
			return;
		}
	#/
	if(function_858c7fa5())
	{
		zm_transform::function_bdd8aba6(#"blight_father");
	}
	return false;
}

/*
	Name: function_2315440d
	Namespace: zm_ai_blight_father
	Checksum: 0xB7FC8321
	Offset: 0xCA60
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2315440d()
{
	spawners = getspawnerarray("zombie_blight_father_spawner", "script_noteworthy");
	/#
		assert(spawners.size > 0);
	#/
	var_944250d2 = spawners[0] spawnfromspawner(0, 1);
	var_944250d2 zm_transform::function_bbaec2fd();
	return true;
}

/*
	Name: function_ef860973
	Namespace: zm_ai_blight_father
	Checksum: 0x19360B23
	Offset: 0xCAF8
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ef860973(params)
{
	level.var_9cfa4efd = 1;
}

/*
	Name: function_6fa41b21
	Namespace: zm_ai_blight_father
	Checksum: 0xD76E6559
	Offset: 0xCB20
	Size: 0x46
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6fa41b21(params)
{
	level.var_9cfa4efd = undefined;
	level.var_fcb96175 = gettime() + (int(30 * 1000));
}

/*
	Name: function_ebc88dbd
	Namespace: zm_ai_blight_father
	Checksum: 0xE250183F
	Offset: 0xCB70
	Size: 0x8A
	Parameters: 1
	Flags: Private
*/
function private function_ebc88dbd(part_name)
{
	/#
		foreach(weakpoint in self.var_d88561ed)
		{
			if(weakpoint.var_19e7c1c4 == part_name)
			{
				return weakpoint;
			}
		}
	#/
}

/*
	Name: function_cab68577
	Namespace: zm_ai_blight_father
	Checksum: 0x9EDB8A18
	Offset: 0xCC08
	Size: 0x180
	Parameters: 1
	Flags: Private
*/
function private function_cab68577(hittag)
{
	/#
		enemies = getaiarchetypearray(#"blight_father");
		foreach(enemy in enemies)
		{
			if(isalive(enemy))
			{
				var_84ed9a13 = namespace_81245006::function_37e3f011(enemy, hittag);
				if(!isdefined(var_84ed9a13))
				{
					return;
				}
				if(namespace_81245006::function_f29756fe(var_84ed9a13) != 1)
				{
					continue;
				}
				enemy function_afce1cf(level.players[0], level.players[0], var_84ed9a13.maxhealth, undefined, undefined, level.players[0] getcurrentweapon(), level.players[0].origin, undefined, undefined, 0, hittag);
			}
		}
	#/
}

/*
	Name: function_f8411b4d
	Namespace: zm_ai_blight_father
	Checksum: 0xB062AE48
	Offset: 0xCD90
	Size: 0xDE
	Parameters: 1
	Flags: Private
*/
function private function_f8411b4d(blight_father)
{
	/#
		if(isdefined(level.var_d4c91513))
		{
			return;
		}
		foreach(var_84ed9a13 in namespace_81245006::function_fab3ee3e(blight_father))
		{
			adddebugcommand(((("" + var_84ed9a13.var_51e8b151) + "") + var_84ed9a13.var_51e8b151) + "");
		}
		level.var_d4c91513 = 1;
	#/
}

/*
	Name: function_a2751530
	Namespace: zm_ai_blight_father
	Checksum: 0x2D9D845E
	Offset: 0xCE78
	Size: 0x430
	Parameters: 0
	Flags: Private
*/
function private function_a2751530()
{
	/#
		mapname = util::get_map_name();
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			waitframe(1);
			string = getdvarstring(#"hash_1999cec56042c9de", "");
			cmd = strtok(string, "");
			if(cmd.size > 0)
			{
				switch(cmd[0])
				{
					case "spawn":
					{
						function_4d72a4a6();
						break;
					}
					case "kill":
					{
						function_d420b133();
						break;
					}
					case "destroy_weakpoint":
					{
						function_cab68577(cmd[1]);
						break;
					}
					case "hash_396b84907b30a71c":
					{
						setdvar(#"hash_3ec02cda135af40f", !getdvarint(#"hash_3ec02cda135af40f", 0));
						break;
					}
					case "debug_dmg":
					{
						level.var_482766d7 = !(isdefined(level.var_482766d7) && level.var_482766d7);
						break;
					}
					case "hash_3170107749934609":
					{
						foreach(blight_father in getaiarchetypearray(#"blight_father"))
						{
							blight_father ai::set_behavior_attribute("", !blight_father ai::get_behavior_attribute(""));
						}
						break;
					}
					case "toggle_lockdown":
					{
						foreach(blight_father in getaiarchetypearray(#"blight_father"))
						{
							blight_father ai::set_behavior_attribute("", !blight_father ai::get_behavior_attribute(""));
						}
						break;
					}
					default:
					{
						if(isdefined(level.var_c81a4e00))
						{
							[[level.var_c81a4e00]](cmd);
						}
						break;
					}
				}
			}
			setdvar(#"hash_1999cec56042c9de", "");
		}
	#/
}

/*
	Name: function_255c7194
	Namespace: zm_ai_blight_father
	Checksum: 0xDE609785
	Offset: 0xD2B0
	Size: 0xAC
	Parameters: 0
	Flags: Private
*/
function private function_255c7194()
{
	/#
		player = getplayers()[0];
		queryresult = positionquery_source_navigation(player.origin, 128, 256, 128, 20);
		if(isdefined(queryresult) && queryresult.data.size > 0)
		{
			return queryresult.data[0];
		}
		return {#origin:player.origin};
	#/
}

/*
	Name: function_4d72a4a6
	Namespace: zm_ai_blight_father
	Checksum: 0x1744E592
	Offset: 0xD368
	Size: 0x12C
	Parameters: 0
	Flags: Private
*/
function private function_4d72a4a6()
{
	/#
		blight_father_spawners = getspawnerarray("", "");
		spawn_point = function_255c7194();
		if(blight_father_spawners.size == 0)
		{
			iprintln("");
			return;
		}
		blight_father_spawners[0].script_forcespawn = 1;
		entity = zombie_utility::spawn_zombie(blight_father_spawners[0], undefined, spawn_point);
		if(!isdefined(entity))
		{
			return;
		}
		if(!isdefined(spawn_point.angles))
		{
			angles = (0, 0, 0);
		}
		else
		{
			angles = spawn_point.angles;
		}
		entity zm_transform::function_bbaec2fd();
		entity forceteleport(spawn_point.origin, angles);
	#/
}

/*
	Name: function_d420b133
	Namespace: zm_ai_blight_father
	Checksum: 0xCA69CDEF
	Offset: 0xD4A0
	Size: 0xC0
	Parameters: 0
	Flags: Private
*/
function private function_d420b133()
{
	/#
		enemies = getaiarchetypearray(#"blight_father");
		foreach(enemy in enemies)
		{
			if(isalive(enemy))
			{
				enemy kill();
			}
		}
	#/
}

