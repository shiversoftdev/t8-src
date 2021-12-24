// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_19c1c62e80201e14;
#using script_2c5daa95f8fec03c;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_41fe08c37d53a635;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_57f7003580bb15e0;
#using script_bd2b8aaa388dcce;
#using script_caf007e2a98afa2;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace namespace_ebc3fc57;

/*
	Name: function_89f2df9
	Namespace: namespace_ebc3fc57
	Checksum: 0x1A6601EB
	Offset: 0x670
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_7f418a238d76b74f", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_ebc3fc57
	Checksum: 0xF4195535
	Offset: 0x6B8
	Size: 0x4DE
	Parameters: 0
	Flags: None
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"blight_father", &function_7c52f40);
	spawner::function_89a2cd87(#"blight_father", &function_95a6fbef);
	callback::on_spawned(&on_player_spawned);
	clientfield::register("actor", "blight_father_amb_sac_clientfield", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_l_elbow_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_r_elbow_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_l_maggot_sac_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_r_maggot_sac_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_weakpoint_jaw_fx", 1, 1, "int");
	clientfield::register("actor", "blight_father_spawn_maggot_fx_left", 1, 1, "counter");
	clientfield::register("actor", "blight_father_spawn_maggot_fx_right", 1, 1, "counter");
	clientfield::register("actor", "mtl_blight_father_clientfield", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_maggot_trail_fx", 1, 1, "int");
	clientfield::register("scriptmover", "blight_father_chaos_missile_explosion_clientfield", 1, 1, "int");
	clientfield::register("toplayer", "blight_father_chaos_missile_rumble_clientfield", 1, 1, "counter");
	clientfield::register("scriptmover", "blight_father_gib_explosion", 1, 1, "int");
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
	level.var_c2981ce9 = [#"hash_741c87a90c4ecc58":&function_33b2c99e, #"hash_73d1b7a90c0f326e":&function_40034805, #"tag_elbow_weakspot_ri":&function_5a1a4ad, #"tag_elbow_weakspot_le":&function_9bbe631c, #"hash_44497a6311259d30":&function_fa7c080];
}

/*
	Name: on_player_spawned
	Namespace: namespace_ebc3fc57
	Checksum: 0x1247DADA
	Offset: 0xBA0
	Size: 0x12
	Parameters: 0
	Flags: Private
*/
private function on_player_spawned()
{
	self.var_9319fd9 = "j_mainroot";
}

/*
	Name: function_7c52f40
	Namespace: namespace_ebc3fc57
	Checksum: 0x5E127F86
	Offset: 0xBC0
	Size: 0x464
	Parameters: 0
	Flags: Private
*/
private function function_7c52f40()
{
	self endon(#"death");
	self.var_ef46cd4 = #"hash_462c11ee0f1f9550";
	self.clamptonavmesh = 0;
	self.ignorepathenemyfightdist = 1;
	self.var_bb185cc5 = 0;
	self.var_1c0eb62a = 180;
	self.var_737e8510 = 128;
	self namespace_b4c4089b::function_9758722("walk");
	self thread namespace_b4c4089b::function_6c308e81();
	self thread namespace_b4c4089b::function_e261b81d();
	self.maxhealth = level.startinghealth;
	self.health = self.maxhealth;
	self.var_5ee91cf = gettime() + 10000;
	self.zombie_move_speed = "sprint";
	self.var_f46fbf3f = 1;
	self.var_2703428f = self ai::function_9139c839().var_fc5eff78;
	self attach("c_t8_zmb_blightfather_mouth_noreveal");
	self attach("c_t8_zmb_blightfather_elbow1_le_noreveal");
	self attach("c_t8_zmb_blightfather_elbow1_ri_noreveal");
	self attach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
	aiutility::addaioverridedamagecallback(self, &function_afce1cf);
	self.var_c8088bcb = {#timestamp:gettime(), #traces:[]};
	self.var_b2a80abc = gettime() + self ai::function_9139c839().var_f246f6de;
	self.ignorepathenemyfightdist = 1;
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
	self collidewithactors(1);
	if(!isdefined(level.var_6213dc32))
	{
		level.var_6213dc32 = getweapon("zombie_ai_defaultmelee");
	}
	self callback::function_d8abfc3d(#"hash_45b50cc48ee7f9d8", &function_4b103bc4);
	self hide();
	self.var_8ba6ede3 = 1;
	util::wait_network_frame();
	self clientfield::set("blight_father_weakpoint_l_elbow_fx", 1);
	self clientfield::set("blight_father_weakpoint_r_elbow_fx", 1);
	self clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 1);
	self clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 1);
	self clientfield::set("blight_father_weakpoint_jaw_fx", 1);
	self clientfield::set("blight_father_amb_sac_clientfield", 1);
	target_set(self);
}

/*
	Name: function_95a6fbef
	Namespace: namespace_ebc3fc57
	Checksum: 0x3E5AED12
	Offset: 0x1030
	Size: 0x74
	Parameters: 0
	Flags: Private
*/
private function function_95a6fbef()
{
	self.maxhealth = 900;
	self.health = self.maxhealth;
	namespace_81245006::initweakpoints(self, #"hash_4b85d1f08e4e34cb");
	self show();
	self showallparts();
}

/*
	Name: function_36b05ed0
	Namespace: namespace_ebc3fc57
	Checksum: 0x376422D2
	Offset: 0x10B0
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
private function function_36b05ed0(entity)
{
	entity.var_fbec06fa = undefined;
	entity.knockdown = undefined;
}

/*
	Name: killed_callback
	Namespace: namespace_ebc3fc57
	Checksum: 0x35BB63F9
	Offset: 0x10E0
	Size: 0x4C
	Parameters: 1
	Flags: Private
*/
private function killed_callback(e_attacker)
{
	if(self.archetype != #"blight_father")
	{
		return;
	}
	self clientfield::set("blight_father_amb_sac_clientfield", 0);
}

/*
	Name: function_ee833cd6
	Namespace: namespace_ebc3fc57
	Checksum: 0x2CC9DB36
	Offset: 0x1138
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_ee833cd6()
{
	self.completed_emerging_into_playable_area = 1;
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_ebc3fc57
	Checksum: 0xB1B7A5E8
	Offset: 0x1158
	Size: 0xB5C
	Parameters: 0
	Flags: Private
*/
private function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_8383fdf9));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_73649a2d01c11f41", &function_8383fdf9);
	/#
		assert(isscriptfunctionptr(&blightfathershouldshowpain));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldshowpain", &blightfathershouldshowpain);
	/#
		assert(isscriptfunctionptr(&function_3515ad4b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_41aa80b14334caac", &function_3515ad4b);
	/#
		assert(isscriptfunctionptr(&function_abfcd61e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40ced68ca68094d7", &function_abfcd61e);
	/#
		assert(isscriptfunctionptr(&function_30f3bb2c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7767c66e27990a60", &function_30f3bb2c);
	/#
		assert(isscriptfunctionptr(&blightfathershouldspawn));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfathershouldspawn", &blightfathershouldspawn);
	/#
		assert(isscriptfunctionptr(&function_a2155a63));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d6c2aa71a2d55cf", &function_a2155a63);
	/#
		assert(isscriptfunctionptr(&blightfatherdeathstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherdeathstart", &blightfatherdeathstart);
	/#
		assert(isscriptfunctionptr(&function_d5a0a1eb));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1db7e3af327c9b04", &function_d5a0a1eb);
	/#
		assert(isscriptfunctionptr(&function_e0d8f770));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7817d265f22976fd", &function_e0d8f770);
	/#
		assert(isscriptfunctionptr(&function_283b9654));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3598ca6c9a0b1b1", &function_283b9654);
	/#
		assert(isscriptfunctionptr(&function_173d7fb2));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4913708f18cd3e3e", &function_173d7fb2);
	/#
		assert(isscriptfunctionptr(&function_8d9b9683));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_77b88d91d0990898", &function_8d9b9683);
	/#
		assert(isscriptfunctionptr(&function_d83ac1e7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e5059e0839da879", &function_d83ac1e7);
	/#
		assert(isscriptfunctionptr(&blightfatherspawnstart));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"blightfatherspawnstart", &blightfatherspawnstart);
	/#
		assert(isscriptfunctionptr(&function_819f6f9d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_71909144f263d807", &function_819f6f9d);
	/#
		assert(isscriptfunctionptr(&function_87d42d96));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5906b38f80513efb", &function_87d42d96);
	/#
		assert(isscriptfunctionptr(&function_af7555b9));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7429af10c7fbf280", &function_af7555b9);
	/#
		assert(isscriptfunctionptr(&function_2e8ab165));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2be380c82a777611", &function_2e8ab165);
	/#
		assert(isscriptfunctionptr(&function_8c813f66));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3a311ecee563e7b8", &function_8c813f66);
	/#
		assert(isscriptfunctionptr(&zombieshouldstun));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldstun", &zombieshouldstun);
	/#
		assert(isscriptfunctionptr(&zombieshouldknockdown));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"zombieshouldknockdown", &zombieshouldknockdown);
	/#
		assert(isscriptfunctionptr(&function_c3116eee));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5a914a87313bbbee", &function_c3116eee, 1);
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
	animationstatenetwork::registernotetrackhandlerfunction("fire_left", &function_d2b91209);
	animationstatenetwork::registernotetrackhandlerfunction("fire_right", &function_78f5c48e);
	animationstatenetwork::registernotetrackhandlerfunction("blight_father_melee", &function_ac921de9);
	animationstatenetwork::registernotetrackhandlerfunction("blightfather_explode", &function_b78adc65);
	/#
		assert(isscriptfunctionptr(&function_f2914d65));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_116b298d64ab0478", &function_f2914d65);
}

/*
	Name: function_30f3bb2c
	Namespace: namespace_ebc3fc57
	Checksum: 0x1A44AD31
	Offset: 0x1CC0
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function function_30f3bb2c(entity)
{
	return isdefined(entity.var_8a96267d) && entity.var_8a96267d;
}

/*
	Name: function_87d42d96
	Namespace: namespace_ebc3fc57
	Checksum: 0x251520C0
	Offset: 0x1CF0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function function_87d42d96(entity)
{
	entity.var_8a96267d = undefined;
	entity pathmode("dont move", 1);
}

/*
	Name: function_af7555b9
	Namespace: namespace_ebc3fc57
	Checksum: 0x797D18F
	Offset: 0x1D30
	Size: 0x74
	Parameters: 1
	Flags: None
*/
function function_af7555b9(entity)
{
	entity ghost();
	entity notsolid();
	entity clientfield::set("zombie_riser_fx", 0);
	entity notify(#"is_screamed");
	return 1;
}

/*
	Name: blightfathershouldspawn
	Namespace: namespace_ebc3fc57
	Checksum: 0x924FE0C3
	Offset: 0x1DB0
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function blightfathershouldspawn(entity)
{
	return isdefined(entity.var_8ba6ede3) && entity.var_8ba6ede3;
}

/*
	Name: blightfatherspawnstart
	Namespace: namespace_ebc3fc57
	Checksum: 0xBF44FF6A
	Offset: 0x1DE0
	Size: 0x4E
	Parameters: 1
	Flags: None
*/
function blightfatherspawnstart(entity)
{
	entity solid();
	entity clientfield::set("zombie_riser_fx", 1);
	entity.var_8ba6ede3 = undefined;
}

/*
	Name: function_819f6f9d
	Namespace: namespace_ebc3fc57
	Checksum: 0x439F977E
	Offset: 0x1E38
	Size: 0x60
	Parameters: 1
	Flags: None
*/
function function_819f6f9d(entity)
{
	entity clientfield::set("zombie_riser_fx", 0);
	entity pathmode("move allowed");
	entity notify(#"hash_661885e7a60ccf04");
}

/*
	Name: function_a2155a63
	Namespace: namespace_ebc3fc57
	Checksum: 0xAAABD11F
	Offset: 0x1EA0
	Size: 0xE
	Parameters: 1
	Flags: None
*/
function function_a2155a63(entity)
{
	return 0;
}

/*
	Name: zombieshouldstun
	Namespace: namespace_ebc3fc57
	Checksum: 0xA90FC38E
	Offset: 0x1EB8
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function zombieshouldstun(behaviortreeentity)
{
	return behaviortreeentity ai::is_stunned();
}

/*
	Name: zombieshouldknockdown
	Namespace: namespace_ebc3fc57
	Checksum: 0x8809B641
	Offset: 0x1EE8
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function zombieshouldknockdown(behaviortreeentity)
{
	if(isdefined(behaviortreeentity.knockdown) && behaviortreeentity.knockdown)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b78adc65
	Namespace: namespace_ebc3fc57
	Checksum: 0x9B213C74
	Offset: 0x1F28
	Size: 0x174
	Parameters: 1
	Flags: None
*/
function function_b78adc65(entity)
{
	if(entity isragdoll())
	{
		if(entity isattached("c_t8_zmb_blightfather_eggsack1_both_noreveal"))
		{
			entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
		}
		else if(entity isattached("c_t8_zmb_blightfather_eggsack1_le_noreveal"))
		{
			entity detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
		}
		else if(entity isattached("c_t8_zmb_blightfather_eggsack1_ri_noreveal"))
		{
			entity detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
		}
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x25B25F23
	Offset: 0x20A8
	Size: 0x4C
	Parameters: 0
	Flags: Private
*/
private function function_529b7fb9()
{
	self endon(#"death");
	level waittill_timeout(300, #"clear_all_corpses");
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_4589bd24
	Namespace: namespace_ebc3fc57
	Checksum: 0x2078A0F4
	Offset: 0x2100
	Size: 0x8E
	Parameters: 0
	Flags: None
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x8543F872
	Offset: 0x2198
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function function_753b4884()
{
	return undefined;
}

/*
	Name: function_f2914d65
	Namespace: namespace_ebc3fc57
	Checksum: 0x1AC3D92C
	Offset: 0x21A8
	Size: 0x10E
	Parameters: 1
	Flags: Private
*/
private function function_f2914d65(entity)
{
	enemies = getaiarchetypearray(#"zombie");
	enemies = arraycombine(enemies, getaiarchetypearray(#"catalyst"), 0, 0);
	enemies = array::filter(enemies, 0, &function_3d752709, entity);
	foreach(enemy in enemies)
	{
		enemy.knockdown_type = "knockdown_shoved";
	}
}

/*
	Name: function_3d752709
	Namespace: namespace_ebc3fc57
	Checksum: 0x2645ED27
	Offset: 0x22C0
	Size: 0x1A8
	Parameters: 2
	Flags: Private
*/
private function function_3d752709(enemy, target)
{
	if(isdefined(enemy.knockdown) && enemy.knockdown)
	{
		return 0;
	}
	if(gibserverutils::isgibbed(enemy, 384))
	{
		return 0;
	}
	if(distancesquared(enemy.origin, target.origin) > self ai::function_9139c839().var_2e53b0a6 * self ai::function_9139c839().var_2e53b0a6)
	{
		return 0;
	}
	var_f2fb414f = anglestoforward(target.angles);
	var_9349139f = enemy.origin - target.origin;
	var_3e3c8075 = (var_9349139f[0], var_9349139f[1], 0);
	var_c2ee8451 = (var_f2fb414f[0], var_f2fb414f[1], 0);
	var_3e3c8075 = vectornormalize(var_3e3c8075);
	var_c2ee8451 = vectornormalize(var_c2ee8451);
	var_34e02165 = vectordot(var_c2ee8451, var_3e3c8075);
	if(var_34e02165 < 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: blightfathershouldshowpain
	Namespace: namespace_ebc3fc57
	Checksum: 0x3E6F99B6
	Offset: 0x2470
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function blightfathershouldshowpain(entity)
{
	if(isdefined(entity.var_fbec06fa))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_8d9b9683
	Namespace: namespace_ebc3fc57
	Checksum: 0x805F4A4F
	Offset: 0x24A0
	Size: 0x24
	Parameters: 1
	Flags: Private
*/
private function function_8d9b9683(entity)
{
	function_173d7fb2(entity);
}

/*
	Name: function_3515ad4b
	Namespace: namespace_ebc3fc57
	Checksum: 0xB67B9194
	Offset: 0x24D0
	Size: 0x22
	Parameters: 1
	Flags: Private
*/
private function function_3515ad4b(entity)
{
	return blightfathershouldshowpain(entity);
}

/*
	Name: function_173d7fb2
	Namespace: namespace_ebc3fc57
	Checksum: 0x59C3C38D
	Offset: 0x2500
	Size: 0x16
	Parameters: 1
	Flags: Private
*/
private function function_173d7fb2(entity)
{
	entity.var_fbec06fa = undefined;
}

/*
	Name: blightfatherdeathstart
	Namespace: namespace_ebc3fc57
	Checksum: 0x6644D3C8
	Offset: 0x2520
	Size: 0x122
	Parameters: 1
	Flags: Private
*/
private function blightfatherdeathstart(entity)
{
	entity val::set(#"blight_father_death", "takedamage", 0);
	if(level.var_79b2615b === entity)
	{
		level.var_79b2615b = undefined;
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
}

/*
	Name: function_ac921de9
	Namespace: namespace_ebc3fc57
	Checksum: 0xAB6DD560
	Offset: 0x2650
	Size: 0x3B0
	Parameters: 1
	Flags: Private
*/
private function function_ac921de9(entity)
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
	if(isdefined(entity.attackable) && (isdefined(entity.attackable.is_active) && entity.attackable.is_active))
	{
		if(isdefined(entity.is_at_attackable) && entity.is_at_attackable)
		{
			if(isdefined(level.attackablecallback))
			{
				entity.attackable [[level.attackablecallback]](entity);
			}
		}
	}
}

/*
	Name: function_283b9654
	Namespace: namespace_ebc3fc57
	Checksum: 0x24F864B1
	Offset: 0x2A08
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
private function function_283b9654(entity)
{
}

/*
	Name: function_fa33f4aa
	Namespace: namespace_ebc3fc57
	Checksum: 0x30C29FF2
	Offset: 0x2A20
	Size: 0x38
	Parameters: 2
	Flags: Private
*/
private function function_fa33f4aa(entity, asmstatename)
{
	if(entity ai::is_stunned())
	{
		return 5;
	}
	return 4;
}

/*
	Name: function_4b103bc4
	Namespace: namespace_ebc3fc57
	Checksum: 0xA68AFFF3
	Offset: 0x2A60
	Size: 0x1C
	Parameters: 0
	Flags: Private
*/
private function function_4b103bc4()
{
	function_2e8ab165(self);
}

/*
	Name: function_abfcd61e
	Namespace: namespace_ebc3fc57
	Checksum: 0x3F502E6A
	Offset: 0x2A88
	Size: 0x6C
	Parameters: 1
	Flags: Private
*/
private function function_abfcd61e(entity)
{
	return entity.var_5ee91cf < gettime() && (isdefined(self.var_37f16e2e) && self.var_37f16e2e) && isdefined(self.favoriteenemy) && (!(isdefined(entity.var_c8f98f87) && entity.var_c8f98f87));
}

/*
	Name: function_2e8ab165
	Namespace: namespace_ebc3fc57
	Checksum: 0x269654C6
	Offset: 0x2B00
	Size: 0x1E
	Parameters: 1
	Flags: Private
*/
private function function_2e8ab165(entity)
{
	entity.var_5ee91cf = gettime() + 10000;
}

/*
	Name: function_8c813f66
	Namespace: namespace_ebc3fc57
	Checksum: 0xBEA63219
	Offset: 0x2B28
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
private function function_8c813f66(entity)
{
}

/*
	Name: function_d83ac1e7
	Namespace: namespace_ebc3fc57
	Checksum: 0x4522660F
	Offset: 0x2B40
	Size: 0xC
	Parameters: 1
	Flags: Private
*/
private function function_d83ac1e7(entity)
{
}

/*
	Name: function_775f8cf2
	Namespace: namespace_ebc3fc57
	Checksum: 0xE1BA904E
	Offset: 0x2B58
	Size: 0x4E
	Parameters: 0
	Flags: Private
*/
private function function_775f8cf2()
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
	Namespace: namespace_ebc3fc57
	Checksum: 0xF00EC9AA
	Offset: 0x2BB0
	Size: 0xBC
	Parameters: 13
	Flags: Private
*/
private function function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_2703428f--;
	entity destructserverutils::handledamage(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
}

/*
	Name: function_fa7c080
	Namespace: namespace_ebc3fc57
	Checksum: 0x84A64143
	Offset: 0x2C78
	Size: 0xD6
	Parameters: 13
	Flags: Private
*/
private function function_fa7c080(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_c8f98f87 = 1;
	entity.var_6ee32f47 = 1;
	entity clientfield::set("blight_father_weakpoint_jaw_fx", 0);
	entity attach("c_t8_zmb_blightfather_mouth_dmg1");
	entity.var_3acacb18 = undefined;
}

/*
	Name: function_9bbe631c
	Namespace: namespace_ebc3fc57
	Checksum: 0xCA274AA6
	Offset: 0x2D58
	Size: 0x8C
	Parameters: 13
	Flags: Private
*/
private function function_9bbe631c(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity clientfield::set("blight_father_weakpoint_l_elbow_fx", 0);
}

/*
	Name: function_5a1a4ad
	Namespace: namespace_ebc3fc57
	Checksum: 0xAC1DF7FF
	Offset: 0x2DF0
	Size: 0x8C
	Parameters: 13
	Flags: Private
*/
private function function_5a1a4ad(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity clientfield::set("blight_father_weakpoint_r_elbow_fx", 0);
}

/*
	Name: function_40034805
	Namespace: namespace_ebc3fc57
	Checksum: 0x1CD1C2C8
	Offset: 0x2E88
	Size: 0x11C
	Parameters: 13
	Flags: Private
*/
private function function_40034805(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_177b7a47 = 1;
	entity clientfield::set("blight_father_weakpoint_l_maggot_sac_fx", 0);
	if(isdefined(entity.var_7c54fb46) && entity.var_7c54fb46)
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
	}
	else
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
		entity attach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
	}
}

/*
	Name: function_33b2c99e
	Namespace: namespace_ebc3fc57
	Checksum: 0x26B255F8
	Offset: 0x2FB0
	Size: 0x11C
	Parameters: 13
	Flags: Private
*/
private function function_33b2c99e(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity.var_7c54fb46 = 1;
	entity clientfield::set("blight_father_weakpoint_r_maggot_sac_fx", 0);
	if(isdefined(entity.var_177b7a47) && entity.var_177b7a47)
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_ri_noreveal");
	}
	else
	{
		entity detach("c_t8_zmb_blightfather_eggsack1_both_noreveal");
		entity attach("c_t8_zmb_blightfather_eggsack1_le_noreveal");
	}
}

/*
	Name: function_cacd1506
	Namespace: namespace_ebc3fc57
	Checksum: 0xD09927EA
	Offset: 0x30D8
	Size: 0x214
	Parameters: 14
	Flags: Private
*/
private function function_cacd1506(var_84ed9a13, entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(namespace_81245006::function_f29756fe(var_84ed9a13) != 1)
	{
		return;
	}
	namespace_81245006::function_ef87b7e8(var_84ed9a13, damage);
	inflictor thread function_6f109d76(self);
	if(namespace_81245006::function_f29756fe(var_84ed9a13) == 3)
	{
		if(isdefined(level.var_c2981ce9[var_84ed9a13.var_51e8b151]))
		{
			entity [[level.var_c2981ce9[var_84ed9a13.var_51e8b151]]](entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
		}
		if(!entity isplayinganimscripted() && !entity.blockingpain)
		{
			entity.var_fbec06fa = var_84ed9a13.var_51e8b151;
			entity setblackboardattribute("_blight_father_weak_point", var_84ed9a13.var_51e8b151);
		}
		bone = boneindex;
		function_3df61a1a(entity, inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, bone, modelindex);
	}
}

/*
	Name: function_6f109d76
	Namespace: namespace_ebc3fc57
	Checksum: 0xABE12A48
	Offset: 0x32F8
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_6f109d76(ai)
{
}

/*
	Name: function_422fdfd4
	Namespace: namespace_ebc3fc57
	Checksum: 0x7C9C37F8
	Offset: 0x3310
	Size: 0x26C
	Parameters: 11
	Flags: None
*/
function function_422fdfd4(entity, attacker, weapon, var_5457dc44, hitloc, point, var_ebcb86d6, var_b85996d4, var_159ce525, var_ddd319d6, var_d2314927)
{
	var_8d3f5b7d = isalive(attacker) && isplayer(attacker);
	if(isdefined(var_ebcb86d6))
	{
		var_84ed9a13 = var_ebcb86d6;
	}
	else
	{
		var_84ed9a13 = namespace_81245006::function_3131f5dd(self, hitloc, 1);
		if(!isdefined(var_84ed9a13))
		{
			var_84ed9a13 = namespace_81245006::function_37e3f011(entity, var_5457dc44);
		}
		if(!isdefined(var_84ed9a13))
		{
			var_84ed9a13 = namespace_81245006::function_73ab4754(self, point, 1);
		}
	}
	registerzombie_bgb_used_reinforce = isdefined(var_84ed9a13) && namespace_81245006::function_f29756fe(var_84ed9a13) == 1;
	var_30362eca = registerzombie_bgb_used_reinforce && var_84ed9a13.type !== #"armor";
	var_c6cc6205 = var_b85996d4;
	var_fff93f95 = var_159ce525;
	var_cee56a92 = var_ddd319d6;
	var_e008ecea = var_d2314927;
	if(!var_30362eca)
	{
		var_b1c1c5cf = (isdefined(var_c6cc6205) ? var_c6cc6205 : entity ai::function_9139c839().var_54c33ecd);
	}
	else if(var_30362eca)
	{
		var_b1c1c5cf = (isdefined(var_fff93f95) ? var_fff93f95 : entity ai::function_9139c839().var_628192b0);
	}
	return {#registerzombie_bgb_used_reinforce:registerzombie_bgb_used_reinforce, #hash_84ed9a13:var_84ed9a13, #damage_scale:var_b1c1c5cf};
}

/*
	Name: function_afce1cf
	Namespace: namespace_ebc3fc57
	Checksum: 0x128187FD
	Offset: 0x3588
	Size: 0x272
	Parameters: 12
	Flags: Private
*/
private function function_afce1cf(inflictor, attacker, damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	entity = self;
	if(damage > 40)
	{
		damage = 40;
	}
	if(isdefined(entity.enemy) && (isdefined(entity.enemy.usingvehicle) && entity.enemy.usingvehicle))
	{
		return 10;
	}
	var_786d7e06 = function_422fdfd4(entity, attacker, weapon, boneindex);
	damage_scale = var_786d7e06.damage_scale;
	var_84ed9a13 = var_786d7e06.var_84ed9a13;
	registerzombie_bgb_used_reinforce = var_786d7e06.registerzombie_bgb_used_reinforce;
	final_damage = int(damage * damage_scale);
	if(isdefined(var_84ed9a13) && registerzombie_bgb_used_reinforce)
	{
		function_cacd1506(var_84ed9a13, entity, inflictor, attacker, final_damage, flags, meansofdamage, weapon, point, dir, hitloc, offsettime, boneindex, modelindex);
	}
	if(entity.var_2703428f <= 0)
	{
		origin = entity.origin;
		if(isdefined(inflictor))
		{
			origin = inflictor.origin;
		}
		entity kill(origin, attacker, inflictor, weapon, 0, 1);
		final_damage = 0;
	}
	else
	{
		final_damage = final_damage * (1 / entity.var_2703428f);
	}
	return final_damage;
}

/*
	Name: function_f9d9f198
	Namespace: namespace_ebc3fc57
	Checksum: 0xF9B5C9A2
	Offset: 0x3808
	Size: 0xE8
	Parameters: 1
	Flags: Private
*/
private function function_f9d9f198(entity)
{
	var_bee929e7 = entity astsearch("grapple_attack_vomit@blight_father");
	animname = animationstatenetworkutility::searchanimationmap(entity, var_bee929e7[#"animation"]);
	tag_pos = getanimtagorigin(animname, 0, "tag_tongue");
	var_2db07c66 = rotatepoint(tag_pos, entity gettagangles("tag_origin"));
	var_2db07c66 = var_2db07c66 + entity.origin;
	return var_2db07c66;
}

/*
	Name: function_5d7f8057
	Namespace: namespace_ebc3fc57
	Checksum: 0x935444AB
	Offset: 0x38F8
	Size: 0x1E6
	Parameters: 2
	Flags: Private
*/
private function function_5d7f8057(entity, player)
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
	Name: function_c3116eee
	Namespace: namespace_ebc3fc57
	Checksum: 0x47E4CB44
	Offset: 0x3AE8
	Size: 0x36
	Parameters: 1
	Flags: Private
*/
private function function_c3116eee(entity)
{
	if(function_8fe8a946(entity))
	{
		entity.var_4678c6fa = 1;
	}
}

/*
	Name: function_37d1a803
	Namespace: namespace_ebc3fc57
	Checksum: 0xEAF3F317
	Offset: 0x3B28
	Size: 0x2A
	Parameters: 1
	Flags: Private
*/
private function function_37d1a803(entity)
{
	return entity ai::function_9139c839().var_f246f6de;
}

/*
	Name: function_71b8279d
	Namespace: namespace_ebc3fc57
	Checksum: 0x3ADA31C
	Offset: 0x3B60
	Size: 0x28
	Parameters: 1
	Flags: Private
*/
private function function_71b8279d(entity)
{
	return isdefined(entity.var_6ee32f47) && entity.var_6ee32f47;
}

/*
	Name: function_63b7576d
	Namespace: namespace_ebc3fc57
	Checksum: 0x9B02E7F1
	Offset: 0x3B90
	Size: 0x8C
	Parameters: 0
	Flags: Private
*/
private function function_63b7576d()
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x28DDC4C5
	Offset: 0x3C28
	Size: 0xA8
	Parameters: 0
	Flags: Private
*/
private function function_c48604c0()
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x42A99B47
	Offset: 0x3CD8
	Size: 0x42
	Parameters: 1
	Flags: Private
*/
private function function_da2c4ce9(trigger)
{
	trigger.inuse = 0;
	trigger triggerenable(0);
	trigger.origin = (0, 0, 0);
}

/*
	Name: function_8383fdf9
	Namespace: namespace_ebc3fc57
	Checksum: 0xBD669BAE
	Offset: 0x3D28
	Size: 0x28
	Parameters: 1
	Flags: Private
*/
private function function_8383fdf9(entity)
{
	return isdefined(entity.var_4678c6fa) && entity.var_4678c6fa;
}

/*
	Name: function_8fe8a946
	Namespace: namespace_ebc3fc57
	Checksum: 0xB2A93C42
	Offset: 0x3D58
	Size: 0x534
	Parameters: 1
	Flags: Private
*/
private function function_8fe8a946(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(!isplayer(entity.favoriteenemy))
	{
		return 0;
	}
	if(isdefined(entity.var_177b7a47) && entity.var_177b7a47 && (isdefined(entity.var_7c54fb46) && entity.var_7c54fb46))
	{
		return 0;
	}
	if(isdefined(level.var_79b2615b) && level.var_79b2615b != entity && isalive(level.var_79b2615b))
	{
		return 0;
	}
	if(!function_71b8279d(entity) && entity.var_b2a80abc > gettime())
	{
		return 0;
	}
	var_d0651e10 = function_63b7576d();
	if(var_d0651e10 <= 0)
	{
		return 0;
	}
	if(!(isdefined(entity.var_177b7a47) && entity.var_177b7a47) && (!(isdefined(entity.var_7c54fb46) && entity.var_7c54fb46)) && var_d0651e10 < 3)
	{
		return 0;
	}
	forward = anglestoforward(entity.angles);
	var_7af8b86b = vectornormalize((forward[0], forward[1], 0));
	dirtotarget = entity.favoriteenemy.origin - entity.origin;
	var_854904a = vectornormalize((dirtotarget[0], dirtotarget[1], 0));
	dot = vectordot(var_7af8b86b, var_854904a);
	if(dot < entity ai::function_9139c839().var_aa503e5a)
	{
		return 0;
	}
	if(!(isdefined(entity.var_177b7a47) && entity.var_177b7a47))
	{
		tracestart = entity gettagorigin("tag_sac_fx_le");
	}
	else
	{
		tracestart = entity gettagorigin("tag_sac_fx_ri");
	}
	if(!bullettracepassed(tracestart, self.favoriteenemy.origin + vectorscale((0, 0, 1), 35), 0, self))
	{
		return 0;
	}
	height = self.maxs[2] - self.mins[2];
	forward = anglestoforward(self.angles);
	var_725b8fb5 = forward * entity ai::function_9139c839().var_167cbf22;
	var_edabd3cd = bullettracepassed(self.origin + (0, 0, height), (self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), 0, self);
	/#
		recordline(self.origin + (0, 0, height), (self.origin + var_725b8fb5) + (0, 0, height + entity ai::function_9139c839().var_73212b51), (0, 1, 0));
	#/
	if(!var_edabd3cd)
	{
		return 0;
	}
	var_9c2b856b = distancesquared(entity.origin, entity.favoriteenemy.origin);
	if(var_9c2b856b < (entity ai::function_9139c839().var_cdf6b76d * entity ai::function_9139c839().var_cdf6b76d) || var_9c2b856b > (entity ai::function_9139c839().var_652a36f2 * entity ai::function_9139c839().var_652a36f2))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_d5a0a1eb
	Namespace: namespace_ebc3fc57
	Checksum: 0xDA716084
	Offset: 0x4298
	Size: 0x36
	Parameters: 1
	Flags: Private
*/
private function function_d5a0a1eb(entity)
{
	entity clientfield::set("blight_father_amb_sac_clientfield", 0);
	entity.var_4678c6fa = undefined;
}

/*
	Name: function_e0d8f770
	Namespace: namespace_ebc3fc57
	Checksum: 0x949D1A7D
	Offset: 0x42D8
	Size: 0x5C
	Parameters: 1
	Flags: Private
*/
private function function_e0d8f770(entity)
{
	entity.var_b2a80abc = gettime() + function_37d1a803(entity);
	level.var_79b2615b = undefined;
	entity clientfield::set("blight_father_amb_sac_clientfield", 1);
}

/*
	Name: function_d2b91209
	Namespace: namespace_ebc3fc57
	Checksum: 0xEFA3F591
	Offset: 0x4340
	Size: 0x94
	Parameters: 1
	Flags: Private
*/
private function function_d2b91209(entity)
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
	Namespace: namespace_ebc3fc57
	Checksum: 0xA625109
	Offset: 0x43E0
	Size: 0x94
	Parameters: 1
	Flags: Private
*/
private function function_78f5c48e(entity)
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x43A71D33
	Offset: 0x4480
	Size: 0x4C
	Parameters: 0
	Flags: Private
*/
private function function_ebd22bba()
{
	self endon(#"death");
	util::wait_network_frame();
	self clientfield::set("blight_father_maggot_trail_fx", 1);
}

/*
	Name: blightfatherlaunchchaosmissile
	Namespace: namespace_ebc3fc57
	Checksum: 0x9B9BADFD
	Offset: 0x44D8
	Size: 0x448
	Parameters: 3
	Flags: Private
*/
private function blightfatherlaunchchaosmissile(var_f794172e, var_61622673, var_f3486358)
{
	var_ced3ec54 = self gettagorigin(var_f3486358);
	var_27e1ee12 = var_f794172e.origin + var_61622673;
	if(isdefined(self.var_6ee32f47) && self.var_6ee32f47)
	{
		self.var_6ee32f47 = 0;
	}
	var_892397fd = util::spawn_model(#"tag_origin", var_ced3ec54);
	var_a9494306 = function_c48604c0();
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
	var_892397fd thread function_5f3390fd(var_61622673, 60);
	var_892397fd playloopsound(#"hash_5b21b7c645692f8", 0.1);
	var_892397fd moveto(self gettagorigin(var_f3486358) + var_61622673, self ai::function_9139c839().var_20c6e4ca);
	var_eb325a79 = self ai::function_9139c839().var_9e5ebf3c;
	var_b446b077 = self ai::function_9139c839().var_94fefe66;
	var_3fa92868 = self ai::function_9139c839().var_52bddd4;
	wait(self ai::function_9139c839().var_20c6e4ca);
	while(isdefined(var_892397fd))
	{
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x652413D0
	Offset: 0x4928
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function function_a6a20b2c(var_3797b49d)
{
	self waittill(#"death");
	var_3797b49d unlink();
	function_da2c4ce9(var_3797b49d);
}

/*
	Name: function_b2be1340
	Namespace: namespace_ebc3fc57
	Checksum: 0x7E119863
	Offset: 0x4980
	Size: 0xE4
	Parameters: 1
	Flags: None
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
	Namespace: namespace_ebc3fc57
	Checksum: 0xAA15F9E6
	Offset: 0x4A70
	Size: 0x10E
	Parameters: 4
	Flags: Private
*/
private function function_581a06c7(forward_dir, var_ced3ec54, var_27e1ee12, max_angle)
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x9487803B
	Offset: 0x4B88
	Size: 0x18E
	Parameters: 2
	Flags: Private
*/
private function function_5f3390fd(var_61622673, var_4fee43d4)
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
			player_origins[player_origins.size] = player.origin + var_61622673;
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
	Namespace: namespace_ebc3fc57
	Checksum: 0x52BE9D15
	Offset: 0x4D20
	Size: 0x41C
	Parameters: 3
	Flags: Private
*/
private function function_1974d26f(var_3fa92868, var_10ed5867, var_eb325a79)
{
	self endon(#"detonated", #"death");
	if(!isdefined(self.var_3b8e09f5))
	{
		self.var_3b8e09f5 = cos(var_10ed5867 * var_eb325a79);
	}
	if(isdefined(self.missile_target) && isdefined(self.var_209ff2fa))
	{
		if(isplayer(self.missile_target) && (isdefined(self.missile_target.usingvehicle) && self.missile_target.usingvehicle))
		{
			vehicle = self.missile_target getvehicleoccupied();
			var_6d0a510 = vehicle.origin;
		}
		else if(isplayer(self.missile_target))
		{
			var_6d0a510 = self.missile_target getplayercamerapos();
		}
		else
		{
			var_6d0a510 = self.missile_target getcentroid();
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
	Namespace: namespace_ebc3fc57
	Checksum: 0xA0FE4191
	Offset: 0x5148
	Size: 0x234
	Parameters: 1
	Flags: Private
*/
private function function_124486ee(delay)
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_892397fd = self;
	var_e9f94272 = var_892397fd.var_52334e8c;
	blast_radius = 128;
	var_83f35abe = 45;
	var_6927cfa0 = 40;
	var_c45ef84c = 60 * 60;
	if(delay > 0)
	{
		wait(delay);
	}
	if(isdefined(var_892397fd))
	{
		var_892397fd notify(#"detonated");
		var_892397fd moveto(var_892397fd.origin, 0.05);
		var_892397fd clientfield::set("blight_father_chaos_missile_explosion_clientfield", 1);
		var_a7530fbc = var_892397fd.var_52334e8c;
		w_weapon = getweapon(#"none");
		var_892397fd function_8e8b1dfc(var_c45ef84c, var_a7530fbc, w_weapon);
		explosion_point = var_892397fd.origin;
		function_44e3e0d1(explosion_point + vectorscale((0, 0, 1), 18));
		util::wait_network_frame();
		radiusdamage(explosion_point + vectorscale((0, 0, 1), 18), blast_radius, var_83f35abe, var_6927cfa0, var_a7530fbc, "MOD_UNKNOWN", w_weapon);
		if(isdefined(var_892397fd))
		{
			var_892397fd clientfield::set("blight_father_maggot_trail_fx", 0);
			var_892397fd delete();
		}
	}
}

/*
	Name: function_44e3e0d1
	Namespace: namespace_ebc3fc57
	Checksum: 0x415948AA
	Offset: 0x5388
	Size: 0x23E
	Parameters: 1
	Flags: Private
*/
private function function_44e3e0d1(var_51a7ab9c)
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
		n_distance = distance2dsquared(var_51a7ab9c, player.origin);
		if(n_distance < 0.01)
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
	Namespace: namespace_ebc3fc57
	Checksum: 0xD392F887
	Offset: 0x55D0
	Size: 0x13E
	Parameters: 3
	Flags: Private
*/
private function function_8e8b1dfc(var_c45ef84c, blight_father, weapon)
{
	for(i = 0; i < level.activeplayers.size; i++)
	{
		if(!isdefined(level.activeplayers[i]))
		{
			continue;
		}
		distancesq = distancesquared(self.origin, level.activeplayers[i].origin + vectorscale((0, 0, 1), 5));
		if(distancesq > var_c45ef84c)
		{
			continue;
		}
		status_effect = function_4d1e7b48(#"hash_7867f8f9aaaa0c40");
		level.activeplayers[i] status_effect::status_effect_apply(status_effect, weapon, blight_father);
		level.activeplayers[i] clientfield::increment_to_player("blight_father_chaos_missile_rumble_clientfield", 1);
	}
}

