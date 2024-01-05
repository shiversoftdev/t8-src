// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\ai\zm_ai_utility.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using script_522aeb6ae906391e;
#using script_3aa0f32b70d4f7cb;
#using script_4d85e8de54b02198;
#using script_caf007e2a98afa2;
#using script_59f07c660e6710a5;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_3819e7a1427df6d2;
#using scripts\core_common\ai\archetype_avogadro.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\aat_shared.gsc;

#namespace zm_ai_avogadro;

/*
	Name: __init__system__
	Namespace: zm_ai_avogadro
	Checksum: 0xC43B5C31
	Offset: 0x4D0
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_avogadro", &__init__, &__main__, #"archetype_avogadro");
}

/*
	Name: __init__
	Namespace: zm_ai_avogadro
	Checksum: 0xF5EFF805
	Offset: 0x530
	Size: 0x1074
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.avogadro_spawner = getent("avogadro_spawner", "script_noteworthy", 0);
	level.avogadro_intro_location = struct::get("avogadro_intro_location", "script_noteworthy");
	level.avogadro_outro_location = struct::get("avogadro_outro_location", "script_noteworthy");
	level.var_8791f7c5 = &function_ef12dc20;
	level.var_7b63b4a2 = array(getweapon("ray_gun_upgraded"), getweapon("ray_gun_mk2_upgraded"), getweapon("ray_gun_mk2v_upgraded"), getweapon("ray_gun_mk2x_upgraded"), getweapon("ray_gun_mk2y_upgraded"), getweapon("ray_gun_mk2z_upgraded"));
	/#
		assert(isscriptfunctionptr(&function_7715bf68));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4421d0044d5918f8", &function_7715bf68);
	/#
		assert(isscriptfunctionptr(&function_cb8cef0b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1fbe81521f605b64", &function_cb8cef0b);
	/#
		assert(isscriptfunctionptr(&function_4d1543a2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_18535e8ef22307f1", &function_4d1543a2);
	/#
		assert(isscriptfunctionptr(&function_77d6d1fa));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1b624c3c0070a016", &function_77d6d1fa);
	/#
		assert(isscriptfunctionptr(&function_226216d5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4d2c9562863d1fa1", &function_226216d5);
	/#
		assert(isscriptfunctionptr(&function_bc881c2d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_c82a930b4ed7740", &function_bc881c2d);
	/#
		assert(isscriptfunctionptr(&function_df65f7b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2a435fb4db6e15cd", &function_df65f7b);
	/#
		assert(isscriptfunctionptr(&function_4b206a3b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_10ef9c37385e879b", &function_4b206a3b);
	/#
		assert(isscriptfunctionptr(&function_1661ef70));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_351b76eba2d0c20", &function_1661ef70);
	/#
		assert(isscriptfunctionptr(&function_3c40dfbf));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_960eb43361412b6", &function_3c40dfbf);
	/#
		assert(isscriptfunctionptr(&function_ad642b3a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6948b59f70fd02c8", &function_ad642b3a);
	/#
		assert(isscriptfunctionptr(&function_bca96fd7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_12c32e605923240", &function_bca96fd7);
	/#
		assert(isscriptfunctionptr(&function_195b7ea1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73e6bb33d685cfdd", &function_195b7ea1);
	/#
		assert(isscriptfunctionptr(&function_c96c9ef8));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3c50a5420776fe03", &function_c96c9ef8);
	/#
		assert(!isdefined(&function_315c9db0) || isscriptfunctionptr(&function_315c9db0));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2729d76f883a43c0", &function_315c9db0, undefined, undefined);
	/#
		assert(!isdefined(&function_e805c4d0) || isscriptfunctionptr(&function_e805c4d0));
	#/
	/#
		assert(!isdefined(&function_292adb83) || isscriptfunctionptr(&function_292adb83));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2d1ff1ea49da0aec", &function_e805c4d0, &function_292adb83, undefined);
	/#
		assert(!isdefined(&function_eb3d0647) || isscriptfunctionptr(&function_eb3d0647));
	#/
	/#
		assert(!isdefined(&function_1786d14c) || isscriptfunctionptr(&function_1786d14c));
	#/
	/#
		assert(!isdefined(&function_982c84e7) || isscriptfunctionptr(&function_982c84e7));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_135e5fdb832c6157", &function_eb3d0647, &function_1786d14c, &function_982c84e7);
	/#
		assert(!isdefined(&function_65a26b34) || isscriptfunctionptr(&function_65a26b34));
	#/
	/#
		assert(!isdefined(&function_23f14b08) || isscriptfunctionptr(&function_23f14b08));
	#/
	/#
		assert(!isdefined(&function_38c9c3b5) || isscriptfunctionptr(&function_38c9c3b5));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_1133c134bc50151b", &function_65a26b34, &function_23f14b08, &function_38c9c3b5);
	/#
		assert(!isdefined(&function_d1f4d90a) || isscriptfunctionptr(&function_d1f4d90a));
	#/
	/#
		assert(!isdefined(&function_66b243ac) || isscriptfunctionptr(&function_66b243ac));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_7f582f64fbd0af93", &function_d1f4d90a, &function_66b243ac, undefined);
	/#
		assert(isscriptfunctionptr(&function_f4fc9e92));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_51de767b6b86bfb4", &function_f4fc9e92, 1);
	/#
		assert(isscriptfunctionptr(&function_f1d5bfef));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3c3a7c0b6984cf3a", &function_f1d5bfef, 1);
	/#
		assert(isscriptfunctionptr(&function_7615515e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_bde03533a88e4c9", &function_7615515e, 1);
	/#
		assert(isscriptfunctionptr(&function_5aceb20c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_79d41d44e4545a45", &function_5aceb20c, 1);
	/#
		assert(isscriptfunctionptr(&function_a9be3eba));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_38673b28082a9bce", &function_a9be3eba, 1);
	animationstatenetwork::registernotetrackhandlerfunction("aoe_attack", &function_be9ade6d);
	animationstatenetwork::registernotetrackhandlerfunction("charge_attack", &function_9c41ab55);
	spawner::add_archetype_spawn_function(#"avogadro", &function_f34df3c);
	spawner::function_89a2cd87(#"avogadro", &function_c41e67c);
	/#
		function_22006009();
	#/
	level thread aat::register_immunity("zm_aat_brain_decay", #"avogadro", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_frostbite", #"avogadro", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_kill_o_watt", #"avogadro", 1, 1, 1);
	level thread aat::register_immunity("zm_aat_plasmatic_burst", #"avogadro", 1, 1, 1);
}

/*
	Name: __main__
	Namespace: zm_ai_avogadro
	Checksum: 0x80F724D1
	Offset: 0x15B0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_f34df3c
	Namespace: zm_ai_avogadro
	Checksum: 0x74FD9488
	Offset: 0x15C0
	Size: 0x2CC
	Parameters: 0
	Flags: Linked, Private
*/
function private function_f34df3c()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	aiutility::addaioverridedamagecallback(self, &function_8f7ba033);
	self setmodel("c_t8_c_zom_avagadro_fb_scaled_1_point_5");
	self.is_zombie = 1;
	self.zombie_think_done = 1;
	self.var_1731eda3 = 1;
	self.var_2c628c0f = 1;
	self.completed_emerging_into_playable_area = 1;
	self.var_d45ca662 = 1;
	self.b_ignore_cleanup = 1;
	self.ignoreme = 1;
	self.ignore_nuke = 1;
	self.ignore_all_poi = 1;
	self.var_38255de6 = 1;
	self.instakill_func = &zm_powerups::function_16c2586a;
	self.var_fffac33 = &function_fffac33;
	self.var_f3bbe853 = 0;
	self.can_see_enemy = 0;
	self.var_6ed00311 = 0;
	self.var_d307828d = 0;
	self.var_cace91f9 = 0;
	self.var_3f536874 = 0;
	self.var_4ee74b24 = 0;
	self.var_6d5a7a2d = 0;
	self.next_move_time = 0;
	function_ed39491e(0);
	self zombie_utility::set_zombie_run_cycle("walk");
	function_c8179930();
	function_fceafc5f();
	function_11d4db33();
	function_1d5cd5c8();
	if(!isdefined(self._effect))
	{
		self._effect = [];
		self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_elec_aura";
		self._effect[#"hash_571a3bab8b805854"] = "zm_ai/fx8_avo_elec_teleport_flash";
		self._effect[#"nova_crawler_phase_teleport_end_fx"] = "zm_ai/fx8_avo_elec_teleport_appear";
	}
	if(isdefined(level.avogadro_intro_location))
	{
		self thread function_16179477(level.avogadro_intro_location.origin, level.avogadro_intro_location.angles);
	}
}

/*
	Name: function_c41e67c
	Namespace: zm_ai_avogadro
	Checksum: 0xA8BCFE92
	Offset: 0x1898
	Size: 0x9C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c41e67c()
{
	self.maxhealth = self zm_ai_utility::function_8d44707e(1, self._starting_round_number);
	self.health = self.maxhealth;
	self.deathfunction = &zm_spawner::zombie_death_animscript;
	level thread zm_spawner::zombie_death_event(self);
	/#
		self thread function_d60f39c2();
	#/
	self thread function_44ac30aa();
}

/*
	Name: function_22006009
	Namespace: zm_ai_avogadro
	Checksum: 0xAC4DA66C
	Offset: 0x1940
	Size: 0x8C
	Parameters: 1
	Flags: Private
*/
function private function_22006009(cmd)
{
	/#
		zm_devgui::function_c7dd7a17("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_d60f39c2
	Namespace: zm_ai_avogadro
	Checksum: 0xADA3E75E
	Offset: 0x19D8
	Size: 0x358
	Parameters: 4
	Flags: Private
*/
function private function_d60f39c2(entity, player, duration, color)
{
	self endon(#"death");
	while(true)
	{
		waitframe(1);
		enabled = getdvarint(#"hash_5810c8643adc3e7c", 0);
		var_b90a4dc9 = getdvarint(#"hash_4fad1b23f14d5bc4", 0);
		if(enabled)
		{
			end = self getcentroid();
			if(isdefined(self.favoriteenemy))
			{
				start = self.favoriteenemy getcentroid();
				color = (1, 0, 0);
				if(self function_cace91f9())
				{
					color = (0, 1, 0);
				}
				retreat = "";
				if(function_ad642b3a(self))
				{
					retreat = " retreat";
					/#
						line(level.e_avogadro.var_77ef4a35.origin, end, (1, 1, 0));
					#/
				}
				var_1fee3f71 = "";
				if(function_5f4c1c68(self))
				{
					var_1fee3f71 = " no_charge_atk";
				}
				/#
					line(start, end, color);
					sphere(end, 2, color, 1, 0, 4, 1);
					distance = distance(start, end);
					print3d(end + vectorscale((0, 0, 1), 30), (("" + distance) + retreat) + var_1fee3f71, color, 1, 1, 1);
				#/
			}
			if(var_b90a4dc9 == 4 && isdefined(level.avogadro_outro_location))
			{
				/#
					line(level.avogadro_outro_location.origin, end, (1, 0, 0));
					sphere(level.avogadro_outro_location.origin, sqrt(10000), (1, 0, 0), 0.4, 0, 8, 1);
				#/
			}
		}
		if(self.var_b90a4dc9 != var_b90a4dc9)
		{
			function_ed39491e(var_b90a4dc9);
		}
	}
}

/*
	Name: function_ed39491e
	Namespace: zm_ai_avogadro
	Checksum: 0xF8EBC9DE
	Offset: 0x1D38
	Size: 0x1FC
	Parameters: 1
	Flags: Linked
*/
function function_ed39491e(var_b90a4dc9)
{
	self.var_b90a4dc9 = var_b90a4dc9;
	/#
		setdvar(#"hash_4fad1b23f14d5bc4", var_b90a4dc9);
	#/
	switch(self.var_b90a4dc9)
	{
		case 0:
		{
			self.var_355757c0 = 0;
			self.var_e85deff3 = 0;
			break;
		}
		case 1:
		case 2:
		{
			self.var_355757c0 = 0;
			self.var_e85deff3 = 1;
			break;
		}
		case 3:
		case 4:
		{
			self.var_355757c0 = 1;
			self.var_e85deff3 = 1;
			break;
		}
		default:
		{
			break;
		}
	}
	if(self.var_b90a4dc9 == 4 && self.model != "c_t8_c_zom_avagadro_fb")
	{
		self setmodel("c_t8_c_zom_avagadro_fb");
		self.health = int(self.maxhealth * 0.3);
		archetype_avogadro::function_dbc638a8(self);
	}
	else if(self.var_b90a4dc9 < 4 && self.model != "c_t8_c_zom_avagadro_fb_scaled_1_point_5")
	{
		self setmodel("c_t8_c_zom_avagadro_fb_scaled_1_point_5");
		self.health = self.maxhealth;
		archetype_avogadro::function_dbc638a8(self);
	}
}

/*
	Name: function_16179477
	Namespace: zm_ai_avogadro
	Checksum: 0xFBEC456D
	Offset: 0x1F40
	Size: 0xD4
	Parameters: 2
	Flags: Linked
*/
function function_16179477(origin, angles)
{
	self endon(#"death");
	self forceteleport(origin, angles);
	self orientmode("face default");
	self animation::play("ai_t8_zm_avogadro_intro");
	self thread animation::play("ai_t8_zm_avogadro_intro_idle");
	self waittill(#"intro_done");
	self animation::play("ai_t8_zm_avogadro_intro_idle_to_combat");
}

/*
	Name: function_44ac30aa
	Namespace: zm_ai_avogadro
	Checksum: 0x66010DB9
	Offset: 0x2020
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_44ac30aa()
{
	self endon(#"death");
	self waittill(#"hash_3f3656d2f44adc64");
	self delete();
}

/*
	Name: function_8f7ba033
	Namespace: zm_ai_avogadro
	Checksum: 0x98AB0A4
	Offset: 0x2068
	Size: 0x154
	Parameters: 12
	Flags: Linked, Private
*/
function private function_8f7ba033(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	var_7aa37d9f = 0;
	if(self.var_b90a4dc9 == 4 && gettime() > self.var_adf3e655 && !isdefined(self.var_8c6c9045))
	{
		self.var_8c6c9045 = dir * -1;
	}
	else
	{
		if(gettime() > self.var_a8669c90 && function_dbe3b78a(meansofdamage, weapon))
		{
			self.var_fad7a0b8 = 1;
			level notify(#"hash_3a603bc69204f012");
		}
		else if(!function_dbe3b78a(meansofdamage, weapon))
		{
			level notify(#"hash_7edbeeb2b6f53bfe", {#e_player:attacker});
		}
	}
	return var_7aa37d9f;
}

/*
	Name: function_dbe3b78a
	Namespace: zm_ai_avogadro
	Checksum: 0xFBAFFA0
	Offset: 0x21C8
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
function private function_dbe3b78a(meansofdeath, weapon)
{
	result = 0;
	if(meansofdeath == "MOD_MELEE" || isinarray(level.var_7b63b4a2, weapon))
	{
		result = 1;
	}
	return result;
}

/*
	Name: can_see_enemy
	Namespace: zm_ai_avogadro
	Checksum: 0xC8B57141
	Offset: 0x2238
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
function private can_see_enemy()
{
	if(isdefined(self.favoriteenemy) && self.var_6ed00311 < gettime())
	{
		if(self cansee(self.favoriteenemy))
		{
			self.can_see_enemy = 1;
			self.var_d307828d = gettime();
		}
		else
		{
			self.can_see_enemy = 0;
		}
		self.var_6ed00311 = gettime() + 50;
	}
	return self.can_see_enemy;
}

/*
	Name: function_cace91f9
	Namespace: zm_ai_avogadro
	Checksum: 0x20FABEA5
	Offset: 0x22C0
	Size: 0x162
	Parameters: 0
	Flags: Linked, Private
*/
function private function_cace91f9()
{
	var_e22f98ec = undefined;
	if(isdefined(self.favoriteenemy) && self.var_3f536874 < gettime())
	{
		var_e22f98ec = getclosestpointonnavmesh(self.origin, 64, self getpathfindingradius());
	}
	if(isdefined(var_e22f98ec))
	{
		var_5e1a56a9 = distance2d(var_e22f98ec, self.favoriteenemy.origin);
		var_e5fbbfea = 0;
		if(var_5e1a56a9 <= 1000)
		{
			var_4bd2cffc = self.favoriteenemy.origin - var_e22f98ec;
			var_648a4b29 = checknavmeshdirection(var_e22f98ec, var_4bd2cffc, var_5e1a56a9, 0);
			var_398f9190 = distance(var_e22f98ec, var_648a4b29);
			self.var_3f536874 = gettime() + 50;
			if((var_398f9190 + 0.1) >= var_5e1a56a9)
			{
				var_e5fbbfea = 1;
			}
		}
		self.var_cace91f9 = var_e5fbbfea;
	}
	return self.var_cace91f9;
}

/*
	Name: function_4ee74b24
	Namespace: zm_ai_avogadro
	Checksum: 0xCE1D3A2D
	Offset: 0x2430
	Size: 0x12A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4ee74b24()
{
	if(isdefined(self.favoriteenemy) && self.var_6d5a7a2d < gettime())
	{
		var_4bd2cffc = self.favoriteenemy.origin - self.origin;
		var_7453ab4f = anglestoforward(self.angles);
		var_4bd2cffc = vectornormalize(var_4bd2cffc * (1, 1, 0));
		var_7453ab4f = vectornormalize(var_7453ab4f * (1, 1, 0));
		dot = vectordot(var_7453ab4f, var_4bd2cffc);
		cosine_angle = cos(3);
		self.var_6d5a7a2d = gettime() + 50;
		if(dot >= cosine_angle)
		{
			self.var_4ee74b24 = 1;
		}
		else
		{
			self.var_4ee74b24 = 0;
		}
	}
	return self.var_4ee74b24;
}

/*
	Name: function_ef12dc20
	Namespace: zm_ai_avogadro
	Checksum: 0x9D05EAA3
	Offset: 0x2568
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ef12dc20(entity)
{
	result = 0;
	if(can_see_enemy())
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_fffac33
	Namespace: zm_ai_avogadro
	Checksum: 0x3CC007B6
	Offset: 0x25B0
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fffac33(entity)
{
	return randomintrange(2000, 3000);
}

/*
	Name: function_7715bf68
	Namespace: zm_ai_avogadro
	Checksum: 0xDBF14EAA
	Offset: 0x25E0
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7715bf68(entity)
{
	result = 0;
	if(isdefined(entity.var_355757c0) && entity.var_355757c0 && self function_e67ef3bc() && isdefined(entity.favoriteenemy) && entity function_986045a5() && entity can_see_enemy())
	{
		result = 1;
		level notify(#"hash_4cbbb6dfc789393f");
	}
	return result;
}

/*
	Name: function_cb8cef0b
	Namespace: zm_ai_avogadro
	Checksum: 0x52A6747D
	Offset: 0x26A8
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_cb8cef0b(entity)
{
	entity.var_52a38d7d = 0;
	function_c8179930();
}

/*
	Name: function_e67ef3bc
	Namespace: zm_ai_avogadro
	Checksum: 0xF52286B0
	Offset: 0x26E0
	Size: 0x10
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e67ef3bc()
{
	return gettime() > self.var_afeae4f4;
}

/*
	Name: function_c8179930
	Namespace: zm_ai_avogadro
	Checksum: 0xCC857E6D
	Offset: 0x26F8
	Size: 0x3E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c8179930()
{
	random_delay = randomfloatrange(5, 8) * 1000;
	self.var_afeae4f4 = gettime() + random_delay;
}

/*
	Name: function_be9ade6d
	Namespace: zm_ai_avogadro
	Checksum: 0x7C2FA7B
	Offset: 0x2740
	Size: 0x166
	Parameters: 1
	Flags: Linked, Private
*/
function private function_be9ade6d(entity)
{
	var_e98404d8 = entity getcentroid();
	players = getplayers();
	/#
		enabled = getdvarint(#"hash_5810c8643adc3e7c", 0);
		if(enabled)
		{
			sphere(var_e98404d8, sqrt(102400), (0, 0, 1), 0.1, 0, 8, 60);
		}
	#/
	for(player_index = 0; player_index < players.size; player_index++)
	{
		player_centroid = players[player_index] getcentroid();
		distance_sq = distancesquared(var_e98404d8, player_centroid);
		if(distance_sq <= 102400)
		{
			players[player_index] thread function_15b528d9(3.5, player_index);
		}
	}
}

/*
	Name: function_15b528d9
	Namespace: zm_ai_avogadro
	Checksum: 0x77E7B97D
	Offset: 0x28B0
	Size: 0x114
	Parameters: 2
	Flags: Linked, Private
*/
function private function_15b528d9(duration, var_2610777)
{
	self endoncallback(&function_866bf053, #"death", #"disconnect");
	wait((float(function_60d95f53()) / 1000) * var_2610777);
	if(zm_utility::is_player_valid(self))
	{
		self val::set(#"avogadro_aoe", "disable_weapons", 1);
		self status_effect::status_effect_apply(getstatuseffect(#"zm_white_nova_gas"), undefined, self, 1);
		wait(duration);
		function_866bf053();
	}
}

/*
	Name: function_866bf053
	Namespace: zm_ai_avogadro
	Checksum: 0xE7574DF
	Offset: 0x29D0
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_866bf053(notifyhash)
{
	self val::reset(#"avogadro_aoe", "disable_weapons");
}

/*
	Name: function_4d1543a2
	Namespace: zm_ai_avogadro
	Checksum: 0x8ABC0BF9
	Offset: 0x2A10
	Size: 0x134
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4d1543a2(entity)
{
	result = 0;
	if(isdefined(entity.var_e85deff3) && entity.var_e85deff3 && function_93916bd3(entity) && isdefined(entity.favoriteenemy) && !function_5f4c1c68(entity))
	{
		var_eab3f54a = distance2dsquared(entity.origin, entity.favoriteenemy.origin);
		if(var_eab3f54a >= 62500 && function_4ee74b24() && function_cace91f9() && can_see_enemy())
		{
			result = 1;
			level notify(#"hash_498ebb296003fd76");
		}
	}
	return result;
}

/*
	Name: function_77d6d1fa
	Namespace: zm_ai_avogadro
	Checksum: 0x17BDF114
	Offset: 0x2B50
	Size: 0x11E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_77d6d1fa(entity)
{
	if(!isdefined(entity.var_952f8260))
	{
		entity.var_952f8260 = (0, 0, 0);
	}
	if(!isdefined(entity.var_a0c65fba))
	{
		entity.var_a0c65fba = (0, 0, 0);
	}
	_attack_barrier_sprint = anglestoforward(self.angles);
	if(isdefined(self.favoriteenemy))
	{
		_attack_barrier_sprint = self.favoriteenemy.origin - self.origin;
	}
	entity.var_a0c65fba = _attack_barrier_sprint;
	var_afa8e25c = checknavmeshdirection(self.origin, _attack_barrier_sprint, 1000, self getpathfindingradius());
	if(isdefined(var_afa8e25c))
	{
		entity.var_952f8260 = var_afa8e25c;
	}
	else
	{
		entity.var_952f8260 = entity.origin + _attack_barrier_sprint;
	}
}

/*
	Name: function_d59c4b07
	Namespace: zm_ai_avogadro
	Checksum: 0x75CCB6EA
	Offset: 0x2C78
	Size: 0x1E0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d59c4b07(entity)
{
	zombies = getaiteamarray(level.zombie_team);
	zombies = arraysortclosest(zombies, entity.origin, undefined, 0, entity getpathfindingradius() + 50);
	var_31a419e0 = [];
	foreach(zombie in zombies)
	{
		if(zombie.var_6f84b820 === #"basic" || zombie.var_6f84b820 === #"popcorn")
		{
			if(!isdefined(var_31a419e0))
			{
				var_31a419e0 = [];
			}
			else if(!isarray(var_31a419e0))
			{
				var_31a419e0 = array(var_31a419e0);
			}
			var_31a419e0[var_31a419e0.size] = zombie;
		}
	}
	foreach(zombie in var_31a419e0)
	{
		zombie zombie_utility::setup_zombie_knockdown(entity);
	}
}

/*
	Name: function_96e43661
	Namespace: zm_ai_avogadro
	Checksum: 0x35FB51D6
	Offset: 0x2E60
	Size: 0x1B6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_96e43661(entity)
{
	var_c89fc811 = entity getangles();
	registernotice_walla = anglestoforward(var_c89fc811);
	var_e98404d8 = entity getcentroid();
	var_9a123fd6 = var_e98404d8 + (registernotice_walla * 30);
	players = getplayers();
	result = 0;
	/#
		enabled = getdvarint(#"hash_5810c8643adc3e7c", 0);
		if(enabled)
		{
			sphere(var_9a123fd6, sqrt(22500), (1, 0, 0), 0.1, 0, 8, 60);
		}
	#/
	for(i = 0; i < players.size; i++)
	{
		player_centroid = players[i] getcentroid();
		distance_sq = distancesquared(var_9a123fd6, player_centroid);
		if(distance_sq <= 22500)
		{
			result = 1;
			break;
		}
	}
	return result;
}

/*
	Name: function_e805c4d0
	Namespace: zm_ai_avogadro
	Checksum: 0xB0D6C880
	Offset: 0x3020
	Size: 0x52
	Parameters: 2
	Flags: Linked, Private
*/
function private function_e805c4d0(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	entity.previous_origin = entity.origin;
	entity.var_faaea04c = gettime();
	return 5;
}

/*
	Name: function_292adb83
	Namespace: zm_ai_avogadro
	Checksum: 0x336513B8
	Offset: 0x3080
	Size: 0x1CC
	Parameters: 2
	Flags: Linked, Private
*/
function private function_292adb83(entity, asmstatename)
{
	result = 5;
	function_d59c4b07(entity);
	if(gettime() - entity.var_faaea04c > int(1 * 1000))
	{
		if(distance2dsquared(entity.origin, entity.previous_origin) < 25)
		{
			result = 4;
		}
		else
		{
			entity.previous_origin = entity.origin;
			entity.var_faaea04c = gettime();
		}
	}
	if(result == 5 && isdefined(self.favoriteenemy))
	{
		var_4bd2cffc = self.favoriteenemy.origin - self.origin;
		var_88761dde = vectordot(var_4bd2cffc, entity.var_a0c65fba);
		if(var_88761dde < 0)
		{
			result = 4;
		}
	}
	if(result == 5)
	{
		_attack_barrier_sprint = entity.var_952f8260 - self.origin;
		var_a4d89907 = vectordot(entity.var_a0c65fba, _attack_barrier_sprint);
		if(var_a4d89907 < 0 || function_96e43661(entity))
		{
			result = 4;
		}
	}
	return result;
}

/*
	Name: function_226216d5
	Namespace: zm_ai_avogadro
	Checksum: 0x8BB2C3C8
	Offset: 0x3258
	Size: 0x34
	Parameters: 1
	Flags: Linked, Private
*/
function private function_226216d5(entity)
{
	function_fceafc5f();
	archetype_avogadro::function_36f6a838(entity);
}

/*
	Name: function_93916bd3
	Namespace: zm_ai_avogadro
	Checksum: 0x87B54922
	Offset: 0x3298
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_93916bd3(entity)
{
	return gettime() > entity.var_7c4c892a;
}

/*
	Name: function_fceafc5f
	Namespace: zm_ai_avogadro
	Checksum: 0x48CB35CB
	Offset: 0x32C0
	Size: 0x3E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_fceafc5f()
{
	random_delay = randomfloatrange(8, 10) * 1000;
	self.var_7c4c892a = gettime() + random_delay;
}

/*
	Name: function_9c41ab55
	Namespace: zm_ai_avogadro
	Checksum: 0xE15EFCA6
	Offset: 0x3308
	Size: 0x20E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9c41ab55(entity)
{
	var_e98404d8 = entity getcentroid();
	players = getplayers();
	/#
		enabled = getdvarint(#"hash_5810c8643adc3e7c", 0);
		if(enabled)
		{
			sphere(var_e98404d8, sqrt(129600), (0, 0, 1), 0.1, 0, 8, 60);
			sphere(var_e98404d8, sqrt(32400), (0, 0, 1), 0.5, 0, 8, 60);
		}
	#/
	for(i = 0; i < players.size; i++)
	{
		player_centroid = players[i] getcentroid();
		distance_sq = distancesquared(var_e98404d8, player_centroid);
		if(distance_sq <= 32400)
		{
			players[i] dodamage(150, var_e98404d8, entity, entity, "none", "MOD_MELEE");
			continue;
		}
		if(distance_sq <= 129600)
		{
			players[i] dodamage(100, var_e98404d8, entity, entity, "none", "MOD_MELEE");
		}
	}
}

/*
	Name: function_c96c9ef8
	Namespace: zm_ai_avogadro
	Checksum: 0xFE5DAD93
	Offset: 0x3520
	Size: 0xE2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c96c9ef8(entity)
{
	result = 0;
	var_61835cce = 0;
	if(isdefined(entity.var_885c1824))
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(entity.var_885c1824))
			{
				var_61835cce = 1;
				break;
			}
		}
		if(!entity istouching(entity.var_885c1824))
		{
			result = 1;
		}
	}
	return result;
}

/*
	Name: function_28df3aca
	Namespace: zm_ai_avogadro
	Checksum: 0x4216C233
	Offset: 0x3610
	Size: 0x7A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_28df3aca(entity)
{
	var_764cc1f9 = undefined;
	if(isdefined(entity.var_885c1824.var_72f7bafe) && entity.var_885c1824.var_72f7bafe.size > 0)
	{
		var_764cc1f9 = array::random(entity.var_885c1824.var_72f7bafe);
	}
	return var_764cc1f9;
}

/*
	Name: function_315c9db0
	Namespace: zm_ai_avogadro
	Checksum: 0x917DA22
	Offset: 0x3698
	Size: 0x130
	Parameters: 2
	Flags: Linked, Private
*/
function private function_315c9db0(entity, asmstatename)
{
	if(isdefined(entity.var_885c1824))
	{
		var_45be44a6 = function_28df3aca(entity);
		fx_origin = entity gettagorigin("j_spine4");
		playfx(entity._effect[#"hash_571a3bab8b805854"], fx_origin);
		entity forceteleport(var_45be44a6.origin, var_45be44a6.angles);
		zm_net::network_safe_play_fx_on_tag("nova_crawler_phase_teleport_end_fx", 2, entity._effect[#"nova_crawler_phase_teleport_end_fx"], entity, "j_spine4");
	}
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: function_f4fc9e92
	Namespace: zm_ai_avogadro
	Checksum: 0x376980CA
	Offset: 0x37D0
	Size: 0xBC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f4fc9e92(entity)
{
	if(isdefined(entity.favoriteenemy) && isplayer(entity.favoriteenemy) && !zm_utility::is_player_valid(entity.favoriteenemy, 1))
	{
		entity.favoriteenemy = undefined;
	}
	if(isdefined(entity.var_93a62fe))
	{
		zm_behavior::zombiefindflesh(entity);
	}
	else if(gettime() > entity.next_move_time)
	{
		entity pick_new_movement_point();
	}
}

/*
	Name: function_f1d5bfef
	Namespace: zm_ai_avogadro
	Checksum: 0xF8B46AFD
	Offset: 0x3898
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f1d5bfef(entity)
{
	var_9c273f20 = [];
	if(isdefined(entity.var_885c1824))
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(entity.var_885c1824))
			{
				var_9c273f20[var_9c273f20.size] = players[i];
			}
		}
	}
	if(var_9c273f20.size > 0)
	{
		var_9c273f20 = arraysortclosest(var_9c273f20, entity.origin);
		entity.var_93a62fe = var_9c273f20[0];
	}
	else
	{
		zm_behavior::function_f637b05d(entity);
	}
}

/*
	Name: function_7615515e
	Namespace: zm_ai_avogadro
	Checksum: 0x8B8118AB
	Offset: 0x39B0
	Size: 0x1E6
	Parameters: 1
	Flags: Linked, Private
*/
function private function_7615515e(entity)
{
	if(!isdefined(entity.var_52a38d7d))
	{
		entity.var_52a38d7d = 0;
	}
	if(!isdefined(entity.var_8db49d5e))
	{
		entity.var_8db49d5e = 0;
	}
	var_e98404d8 = entity getcentroid();
	players = getplayers();
	player_in_range = 0;
	for(i = 0; i < players.size; i++)
	{
		player_centroid = players[i] getcentroid();
		distance_sq = distancesquared(var_e98404d8, player_centroid);
		if(distance_sq <= 78400)
		{
			player_in_range = 1;
			break;
		}
	}
	if(player_in_range)
	{
		entity.var_52a38d7d = entity.var_52a38d7d + (float(function_60d95f53()) / 1000);
		entity.var_8db49d5e = 0;
	}
	else
	{
		entity.var_8db49d5e = entity.var_8db49d5e + (float(function_60d95f53()) / 1000);
		if(entity.var_8db49d5e >= 1)
		{
			entity.var_52a38d7d = 0;
		}
	}
}

/*
	Name: function_5aceb20c
	Namespace: zm_ai_avogadro
	Checksum: 0x3F164071
	Offset: 0x3BA0
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5aceb20c(entity)
{
	if(!can_see_enemy() && gettime() > (entity.var_d307828d + 1000))
	{
		if(gettime() > entity.var_d307828d + 5000)
		{
			entity zombie_utility::set_zombie_run_cycle("sprint");
		}
		else
		{
			entity zombie_utility::set_zombie_run_cycle("run");
		}
	}
	else
	{
		entity zombie_utility::set_zombie_run_cycle("walk");
	}
}

/*
	Name: function_986045a5
	Namespace: zm_ai_avogadro
	Checksum: 0xB6B4ABDE
	Offset: 0x3C60
	Size: 0x22
	Parameters: 0
	Flags: Linked, Private
*/
function private function_986045a5()
{
	return isdefined(self.var_52a38d7d) && self.var_52a38d7d >= 2.5;
}

/*
	Name: function_df65f7b
	Namespace: zm_ai_avogadro
	Checksum: 0xFC0C25D5
	Offset: 0x3C90
	Size: 0x5A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_df65f7b(entity)
{
	result = 0;
	if(self.var_b90a4dc9 < 4 && (isdefined(entity.var_fad7a0b8) && entity.var_fad7a0b8))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_11d4db33
	Namespace: zm_ai_avogadro
	Checksum: 0x953617F2
	Offset: 0x3CF8
	Size: 0x16
	Parameters: 0
	Flags: Linked, Private
*/
function private function_11d4db33()
{
	self.var_a8669c90 = gettime() + 10000;
}

/*
	Name: function_4b206a3b
	Namespace: zm_ai_avogadro
	Checksum: 0x5BAFF560
	Offset: 0x3D18
	Size: 0x3C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4b206a3b(entity)
{
	entity clientfield::set("" + #"hash_2eec8fc21495a18c", 0);
}

/*
	Name: function_1661ef70
	Namespace: zm_ai_avogadro
	Checksum: 0xB20BA0D8
	Offset: 0x3D60
	Size: 0x52
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1661ef70(entity)
{
	archetype_avogadro::function_dbc638a8(entity);
	function_11d4db33();
	entity.var_fad7a0b8 = 0;
	self.phase_time = gettime() - 1;
}

/*
	Name: function_3c40dfbf
	Namespace: zm_ai_avogadro
	Checksum: 0x797F4293
	Offset: 0x3DC0
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3c40dfbf(entity)
{
	entity.var_fad7a0b8 = 0;
}

/*
	Name: function_a9be3eba
	Namespace: zm_ai_avogadro
	Checksum: 0x5B5A604A
	Offset: 0x3DE8
	Size: 0x462
	Parameters: 1
	Flags: Linked
*/
function function_a9be3eba(entity)
{
	var_2d734075 = !isdefined(level.var_8791f7c5) || [[level.var_8791f7c5]](entity);
	if(gettime() > entity.phase_time && var_2d734075)
	{
		if(entity function_dd070839() || isdefined(entity.traversestartnode))
		{
			entity.phase_time = gettime() + self.var_15aa1ae0;
			entity.var_1ce249af = 0;
			return;
		}
		var_cfa253f9 = array("left", "right", "back", "forward");
		if(0.5 < randomfloat(1))
		{
			var_cfa253f9 = array("right", "left", "back", "forward");
		}
		var_160337aa = array("long", "medium", "short");
		foreach(distance in var_160337aa)
		{
			foreach(direction in var_cfa253f9)
			{
				entity setblackboardattribute("_phase_direction", direction);
				entity setblackboardattribute("_phase_distance", distance);
				result = entity astsearch("phase@avogadro");
				animation = animationstatenetworkutility::searchanimationmap(entity, result[#"animation"]);
				if(isdefined(animation))
				{
					localdeltavector = getmovedelta(animation, 0, 1, entity);
					endpoint = entity localtoworldcoords(localdeltavector);
					var_de1e565c = ispointonnavmesh(endpoint, entity);
					var_9d872a34 = self maymovefrompointtopoint(entity.origin, endpoint, 1, 1);
					if(ispointonnavmesh(endpoint, entity) && self maymovefrompointtopoint(entity.origin, endpoint, 1, 1))
					{
						/#
							recordline(entity.origin, endpoint, (0, 1, 0));
							recordsphere(endpoint, 15, (0, 1, 0));
						#/
						entity.var_1ce249af = 1;
						return true;
					}
					/#
						recordline(entity.origin, endpoint, (1, 0, 0));
						recordsphere(endpoint, 15, (1, 0, 0));
					#/
				}
			}
		}
	}
	entity.var_1ce249af = 0;
}

/*
	Name: function_195b7ea1
	Namespace: zm_ai_avogadro
	Checksum: 0x3DA0B640
	Offset: 0x4258
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_195b7ea1(entity)
{
	result = 0;
	if(isdefined(entity.favoriteenemy))
	{
		var_eab3f54a = distance2dsquared(entity.origin, entity.favoriteenemy.origin);
		if(var_eab3f54a >= 90000)
		{
			result = 1;
		}
	}
	return result;
}

/*
	Name: function_1d5cd5c8
	Namespace: zm_ai_avogadro
	Checksum: 0x37BFE7A1
	Offset: 0x42E8
	Size: 0x1A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1d5cd5c8()
{
	self.var_adf3e655 = gettime() + 200;
}

/*
	Name: function_bc881c2d
	Namespace: zm_ai_avogadro
	Checksum: 0x1B3CC343
	Offset: 0x4310
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bc881c2d(entity)
{
	result = 0;
	if(self.var_b90a4dc9 == 4 && isdefined(entity.var_8c6c9045))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_eb3d0647
	Namespace: zm_ai_avogadro
	Checksum: 0x37E562BC
	Offset: 0x4368
	Size: 0xA2
	Parameters: 2
	Flags: Linked, Private
*/
function private function_eb3d0647(entity, asmstatename)
{
	var_ba10a63 = vectortoangles((entity.var_8c6c9045[0], entity.var_8c6c9045[1], 0));
	entity forceteleport(entity.origin, var_ba10a63);
	animationstatenetworkutility::requeststate(entity, asmstatename);
	entity.var_8c6c9045 = undefined;
	return 5;
}

/*
	Name: function_1786d14c
	Namespace: zm_ai_avogadro
	Checksum: 0x3EA4F100
	Offset: 0x4418
	Size: 0x66
	Parameters: 2
	Flags: Linked, Private
*/
function private function_1786d14c(entity, asmstatename)
{
	result = 5;
	if(isdefined(entity.var_8c6c9045) || entity asmgetstatus() == "asm_status_complete")
	{
		result = 4;
	}
	return result;
}

/*
	Name: function_982c84e7
	Namespace: zm_ai_avogadro
	Checksum: 0x7BFE60E6
	Offset: 0x4488
	Size: 0x28
	Parameters: 2
	Flags: Linked, Private
*/
function private function_982c84e7(entity, asmstatename)
{
	function_1d5cd5c8();
	return 4;
}

/*
	Name: function_bca96fd7
	Namespace: zm_ai_avogadro
	Checksum: 0x6C4CBD7D
	Offset: 0x44B8
	Size: 0x8A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_bca96fd7(entity)
{
	result = 0;
	if(entity.var_b90a4dc9 == 4 && isdefined(level.avogadro_outro_location) && distance2dsquared(entity.origin, level.avogadro_outro_location.origin) < 10000)
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_d1f4d90a
	Namespace: zm_ai_avogadro
	Checksum: 0xA2DDCA1F
	Offset: 0x4550
	Size: 0x68
	Parameters: 2
	Flags: Linked, Private
*/
function private function_d1f4d90a(entity, asmstatename)
{
	entity forceteleport(level.avogadro_outro_location.origin, level.avogadro_outro_location.angles);
	animationstatenetworkutility::requeststate(entity, asmstatename);
	return 5;
}

/*
	Name: function_66b243ac
	Namespace: zm_ai_avogadro
	Checksum: 0xB54FD1BD
	Offset: 0x45C0
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
function private function_66b243ac(entity, asmstatename)
{
	result = 5;
	if(entity asmgetstatus() == "asm_status_complete")
	{
		result = 4;
	}
	return result;
}

/*
	Name: function_5f4c1c68
	Namespace: zm_ai_avogadro
	Checksum: 0x3085FAFD
	Offset: 0x4620
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5f4c1c68(entity)
{
	result = 0;
	if(self.var_b90a4dc9 == 4 && isdefined(level.e_avogadro) && isdefined(level.e_avogadro.vol_no_charge) && entity istouching(entity.vol_no_charge))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_ad642b3a
	Namespace: zm_ai_avogadro
	Checksum: 0x491F3E14
	Offset: 0x46B0
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_ad642b3a(entity)
{
	result = 0;
	if(self.var_b90a4dc9 == 4 && isdefined(level.e_avogadro) && isdefined(level.e_avogadro.vol_retreat) && isdefined(level.e_avogadro.var_77ef4a35) && entity istouching(entity.vol_retreat))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_65a26b34
	Namespace: zm_ai_avogadro
	Checksum: 0x16E81B8
	Offset: 0x4758
	Size: 0xBE
	Parameters: 2
	Flags: Linked, Private
*/
function private function_65a26b34(entity, asmstatename)
{
	entity zombie_utility::set_zombie_run_cycle("run");
	animationstatenetworkutility::requeststate(entity, asmstatename);
	var_e22f98ec = getclosestpointonnavmesh(level.e_avogadro.var_77ef4a35.origin, 100, entity getpathfindingradius());
	entity setgoal(var_e22f98ec);
	entity.var_f10dd7ca = gettime();
	return 5;
}

/*
	Name: function_23f14b08
	Namespace: zm_ai_avogadro
	Checksum: 0x5BD46DFE
	Offset: 0x4820
	Size: 0x19E
	Parameters: 2
	Flags: Linked, Private
*/
function private function_23f14b08(entity, asmstatename)
{
	result = 5;
	if(isdefined(entity.var_f10dd7ca) && isdefined(entity.zombie_move_speed))
	{
		if(entity.zombie_move_speed == "run" && gettime() > (entity.var_f10dd7ca + (int(1.5 * 1000))))
		{
			entity zombie_utility::set_zombie_run_cycle("sprint");
		}
		else if(entity.zombie_move_speed == "sprint" && gettime() > (entity.var_f10dd7ca + (int(4 * 1000))))
		{
			entity zombie_utility::set_zombie_run_cycle("super_sprint");
		}
	}
	var_1f2328d0 = entity function_4794d6a3();
	isatgoal = isdefined(var_1f2328d0.isatgoal) && var_1f2328d0.isatgoal;
	if(isatgoal || isdefined(entity.var_8c6c9045))
	{
		result = 4;
	}
	return result;
}

/*
	Name: function_38c9c3b5
	Namespace: zm_ai_avogadro
	Checksum: 0xDB47F80C
	Offset: 0x49C8
	Size: 0x42
	Parameters: 2
	Flags: Linked, Private
*/
function private function_38c9c3b5(entity, asmstatename)
{
	entity zombie_utility::set_zombie_run_cycle("walk");
	entity.var_f10dd7ca = undefined;
	return 4;
}

/*
	Name: pick_new_movement_point
	Namespace: zm_ai_avogadro
	Checksum: 0xD6E6AAC8
	Offset: 0x4A18
	Size: 0x156
	Parameters: 0
	Flags: Linked, Private
*/
function private pick_new_movement_point()
{
	queryresult = positionquery_source_navigation(self.origin, 96, 256, 128, 20, self);
	if(queryresult.data.size)
	{
		point = queryresult.data[randomint(queryresult.data.size)];
		pathsuccess = self findpath(self.origin, point.origin, 1, 0);
		if(pathsuccess)
		{
			self.companion_destination = point.origin;
		}
		else
		{
			self.next_move_time = gettime() + randomintrange(500, 1500);
			return;
		}
	}
	if(isdefined(self.companion_destination))
	{
		self setgoal(self.companion_destination);
	}
	self.next_move_time = gettime() + randomintrange(3000, 8000);
}

