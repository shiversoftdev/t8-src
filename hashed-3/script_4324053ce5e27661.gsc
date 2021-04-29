// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_178024232e91b0a1;
#using script_2c5daa95f8fec03c;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using script_57f7003580bb15e0;
#using script_59f07c660e6710a5;
#using script_67e37e63e177f107;
#using script_7b7ed6e4bc963a51;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\statemachine_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_ai_shared.gsc;

#namespace namespace_d2f65e05;

/*
	Name: main
	Namespace: namespace_d2f65e05
	Checksum: 0x4099533
	Offset: 0x8A8
	Size: 0x20C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function main()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"elephant", &function_e8525036);
	spawner::add_archetype_spawn_function(#"elephant", &function_4c731a08);
	clientfield::register("actor", "towers_boss_melee_effect", 1, 1, "counter");
	clientfield::register("actor", "tower_boss_death_fx", 1, 1, "counter");
	clientfield::register("actor", "towers_boss_eye_fx_cf", 1, 2, "int");
	clientfield::register("actor", "boss_death_rob", 1, 2, "int");
	clientfield::register("scriptmover", "entrails_model_cf", 1, 1, "int");
	clientfield::register("scriptmover", "towers_boss_head_proj_fx_cf", 1, 1, "int");
	clientfield::register("scriptmover", "towers_boss_head_proj_explosion_fx_cf", 1, 1, "int");
	clientfield::register("actor", "sndTowersBossArmor", 1, 1, "int");
	/#
		level thread setup_devgui();
	#/
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: namespace_d2f65e05
	Checksum: 0x4EFCBF10
	Offset: 0xAC0
	Size: 0x7BE
	Parameters: 0
	Flags: Linked, Private
*/
private function registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_2c58bc39));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2f6e4a95b8974fcd", &function_2c58bc39);
	/#
		assert(isscriptfunctionptr(&function_10a75bb7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_40d6b5994b49d7aa", &function_10a75bb7);
	/#
		assert(isscriptfunctionptr(&function_d3d560e9));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_9188ed9ed594c69", &function_d3d560e9);
	/#
		assert(isscriptfunctionptr(&function_8c203da0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7cfb2cad33c8b157", &function_8c203da0);
	/#
		assert(isscriptfunctionptr(&function_5db0f49a));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_7aace3e67f786b19", &function_5db0f49a);
	/#
		assert(isscriptfunctionptr(&function_1c0db2ec));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_a14b98894f1d688", &function_1c0db2ec);
	/#
		assert(isscriptfunctionptr(&function_18e1bf30));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4b225936ae91a204", &function_18e1bf30);
	/#
		assert(isscriptfunctionptr(&function_e5afc75c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_363e4a2f3208311", &function_e5afc75c);
	/#
		assert(isscriptfunctionptr(&function_e5afc75c));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_363e4a2f3208311", &function_e5afc75c);
	/#
		assert(isscriptfunctionptr(&function_9c076ff9));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_2cab44d162eb9a83", &function_9c076ff9);
	/#
		assert(isscriptfunctionptr(&function_69faa74));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_597ef06035bca069", &function_69faa74);
	/#
		assert(isscriptfunctionptr(&function_cd472d5));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4e7335c0f98549c3", &function_cd472d5);
	/#
		assert(isscriptfunctionptr(&function_f2c697c7));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_4fbf554dacfacc1f", &function_f2c697c7);
	/#
		assert(isscriptfunctionptr(&function_f8145b00));
	#/
	behaviorstatemachine::registerbsmscriptapiinternal(#"hash_67699fc0b32fc954", &function_f8145b00);
	/#
		assert(isscriptfunctionptr(&function_2bfd3841));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72b216f44f66e0ca", &function_2bfd3841);
	animationstatenetwork::registeranimationmocomp("mocomp_melee@towers_boss", &function_5e17ac7a, &function_e88518a1, &function_10296bfa);
	animationstatenetwork::registernotetrackhandlerfunction("towersboss_melee", &function_2328518e);
	animationstatenetwork::registernotetrackhandlerfunction("towersboss_melee_big", &function_df15eebf);
	animationstatenetwork::registernotetrackhandlerfunction("launch_head_proj", &function_4b28fc8c);
	animationstatenetwork::registernotetrackhandlerfunction("launch_head_proj2", &function_4b28fc8c);
	animationstatenetwork::registernotetrackhandlerfunction("towers_boss_ground_attack", &function_ce8fe2b0);
	animation::add_global_notetrack_handler("carriage_explode", &function_91bee4fc, 0);
	animation::add_global_notetrack_handler("tower_boss_death_effects", &function_afc99f32, 0);
	animation::add_global_notetrack_handler("tower_boss_entrace_effects", &function_35130a59, 0);
	level.var_c6001986 = &function_67525edc;
}

/*
	Name: function_67525edc
	Namespace: namespace_d2f65e05
	Checksum: 0xF4583FF0
	Offset: 0x1288
	Size: 0x170
	Parameters: 1
	Flags: Linked
*/
function function_67525edc(var_3f1f1429)
{
	enemies = util::function_81ccf6d3(self.team);
	foreach(target in enemies)
	{
		if(isplayer(target))
		{
			distsq = distancesquared(var_3f1f1429.origin, target.origin);
			if(distsq <= 150 * 150)
			{
				params = function_4d1e7b48(#"hash_12a64221f4d27f9b");
				weapon = getweapon(#"eq_molotov");
				target status_effect::status_effect_apply(params, weapon, var_3f1f1429, 0, 3000, undefined, var_3f1f1429.origin);
			}
		}
	}
}

/*
	Name: function_35130a59
	Namespace: namespace_d2f65e05
	Checksum: 0x12432A2D
	Offset: 0x1400
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_35130a59()
{
	self clientfield::increment("tower_boss_death_fx");
}

/*
	Name: function_e1df3626
	Namespace: namespace_d2f65e05
	Checksum: 0x6F5B2F5F
	Offset: 0x1430
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function function_e1df3626(phase)
{
	if(phase == #"hash_266f56fb994e6639")
	{
		self setmodel(#"hash_fa17b711ee009bb");
		return;
	}
	self setmodel(#"hash_3221e8b3c0c61381");
	self clientfield::set("boss_death_rob", 1);
	self thread function_7f012c08();
}

/*
	Name: function_7f012c08
	Namespace: namespace_d2f65e05
	Checksum: 0x8C53977A
	Offset: 0x14D8
	Size: 0x3C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7f012c08()
{
	self endon(#"death");
	wait(1);
	self clientfield::set("boss_death_rob", 0);
}

/*
	Name: function_afc99f32
	Namespace: namespace_d2f65e05
	Checksum: 0x4CF5D519
	Offset: 0x1520
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_afc99f32()
{
	self clientfield::increment("tower_boss_death_fx");
}

/*
	Name: function_452a76a8
	Namespace: namespace_d2f65e05
	Checksum: 0x2BBA2D89
	Offset: 0x1550
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_452a76a8(elephant)
{
	elephant endon(#"death");
	while(isdefined(1))
	{
		var_f9086199 = elephant animmappingsearch(#"hash_45e1ac151f9ea53c");
		elephant animation::play(var_f9086199, elephant.origin, elephant.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	}
}

/*
	Name: function_42b6d3a3
	Namespace: namespace_d2f65e05
	Checksum: 0x173D4186
	Offset: 0x1600
	Size: 0x51A
	Parameters: 1
	Flags: Linked
*/
function function_42b6d3a3(elephant)
{
	model = "p8_fxanim_zm_towers_boss_death_01_mod";
	animname = "p8_fxanim_zm_towers_boss_death_01_anim";
	deathanim = elephant animmappingsearch(#"hash_3af6e4606cafd1ed");
	if(elephant.ai.phase == #"hash_266f56fb994e6639")
	{
		model = "p8_fxanim_zm_towers_boss_death_02_mod";
		animname = "p8_fxanim_zm_towers_boss_death_02_anim";
		deathanim = elephant animmappingsearch(#"hash_2ca88c72c7b85749");
	}
	phase = elephant.ai.phase;
	elephant.skipdeath = 1;
	elephant.diedinscriptedanim = 1;
	elephant.var_8cf9d4df = spawn("script_model", elephant.origin);
	elephant.var_8cf9d4df setmodel(model);
	elephant.var_8cf9d4df useanimtree("generic");
	elephant.var_8cf9d4df thread animation::play(animname, elephant.origin, elephant.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	elephant.var_8cf9d4df clientfield::set("entrails_model_cf", 1);
	var_8cf9d4df = elephant.var_8cf9d4df;
	origin = elephant.origin;
	angles = elephant.angles;
	var_55ec4bbf = elephant.ai.phase == #"hash_266f53fb994e6120";
	elephant clientfield::set("towers_boss_eye_fx_cf", 0);
	elephant.skipdeath = 1;
	elephant thread animation::play(deathanim, elephant.origin, elephant.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	wait(10);
	if(isdefined(elephant))
	{
		elephant function_e1df3626(phase);
		wait(2.7);
		if(isdefined(elephant))
		{
			if(phase == #"hash_266f56fb994e6639")
			{
				elephant thread function_452a76a8(elephant);
			}
			else
			{
				elephant.allowdeath = 1;
				elephant kill();
			}
		}
	}
	if(phase == #"hash_266f56fb994e6639" && level flag::exists("both_towers_bosses_killed"))
	{
		level flag::set("both_towers_bosses_killed");
	}
	var_8cf9d4df thread function_78f4a0d1();
	level thread function_106b6b29();
	if(var_55ec4bbf)
	{
		var_88b1c7ca = spawnvehicle(#"hash_2db015dc967ccf56", origin, angles, "soul_ball_ai");
		if(isdefined(var_88b1c7ca))
		{
			var_88b1c7ca.var_6353e3f1 = 1;
			var_88b1c7ca.b_ignore_cleanup = 1;
			var_88b1c7ca.ignore_nuke = 1;
			var_88b1c7ca.lightning_chain_immune = 1;
			var_88b1c7ca.var_dd6fe31f = 1;
			var_1801a239 = struct::get("soul_exit", "targetname");
			pos = getclosestpointonnavmesh(var_1801a239.origin, 500, 30);
			wait(1);
			var_88b1c7ca vehicle_ai::set_state("soul");
			var_88b1c7ca.ai.var_a38db64f = pos;
		}
	}
}

/*
	Name: function_78f4a0d1
	Namespace: namespace_d2f65e05
	Checksum: 0x9C73CFB3
	Offset: 0x1B28
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_78f4a0d1()
{
	wait(20);
	if(isdefined(self))
	{
		self delete();
	}
}

/*
	Name: function_106b6b29
	Namespace: namespace_d2f65e05
	Checksum: 0x1BCB7144
	Offset: 0x1B58
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_106b6b29()
{
	wait(4.5);
	playsoundatposition(#"hash_4cf49c7c9533b539", (0, 0, 0));
}

/*
	Name: function_8d7ad318
	Namespace: namespace_d2f65e05
	Checksum: 0x517D8FE4
	Offset: 0x1B98
	Size: 0x21E
	Parameters: 3
	Flags: None
*/
function function_8d7ad318(launchpos, trajectory, targetpos)
{
	self endon(#"hash_79e095919e415a70", #"death");
	/#
		/#
			assert(trajectory.size);
		#/
		recordsphere(targetpos, 3, (0, 1, 1), "");
		recordline(launchpos, trajectory[0], (0, 1, 1), "");
		while(true)
		{
			i = 0;
			foreach(point in trajectory)
			{
				recordsphere(point, 3, (0, 1, 1), "");
				if(isdefined(trajectory[i + 1]))
				{
					recordline(point, trajectory[i + 1], (0, 1, 1), "");
				}
				i++;
			}
			recordsphere(targetpos, 3, (0, 1, 1), "");
			recordline(point, targetpos, (0, 1, 1), "");
			waitframe(1);
		}
	#/
}

/*
	Name: function_4b28fc8c
	Namespace: namespace_d2f65e05
	Checksum: 0x1AA22383
	Offset: 0x1DC0
	Size: 0x3C0
	Parameters: 1
	Flags: Linked
*/
function function_4b28fc8c(entity)
{
	/#
		assert(isdefined(entity.ai.var_a05929e4));
	#/
	launchpos = entity gettagorigin("j_head");
	var_d82e1fd1 = entity gettagangles("j_head");
	/#
		recordsphere(launchpos, 3, (0, 0, 1), "");
	#/
	landpos = entity.var_f6ea2286;
	if(!isdefined(landpos))
	{
		landpos = entity.favoriteenemy.origin;
	}
	var_f5022ab9 = spawn("script_model", launchpos);
	var_f5022ab9 setmodel("tag_origin");
	vectorfromenemy = vectornormalize(entity.origin - landpos);
	vectorfromenemy = vectorscale(vectorfromenemy, 250);
	targetpos = landpos + vectorfromenemy + vectorscale((0, 0, 1), 200);
	var_f5022ab9 clientfield::set("towers_boss_head_proj_fx_cf", 1);
	trajectory = [];
	dirtotarget = targetpos - launchpos;
	var_f1c85329 = vectorscale((0, 0, 1), 30);
	var_62e75be4 = vectorscale((0, 0, 1), 200);
	trajectory[trajectory.size] = launchpos + dirtotarget * 0.85 + var_f1c85329;
	trajectory[trajectory.size] = launchpos + dirtotarget * 0.5 + var_62e75be4;
	trajectory[trajectory.size] = launchpos + dirtotarget * 0.15 + var_f1c85329;
	trajectory = array::reverse(trajectory);
	/#
		self thread function_8d7ad318(launchpos, trajectory, targetpos);
	#/
	var_10b732dc = 0.3;
	foreach(point in trajectory)
	{
		var_f5022ab9 moveto(point, var_10b732dc);
		var_f5022ab9 waittill(#"movedone");
	}
	self playsound(#"hash_62894125ab280b62");
	self notify(#"hash_79e095919e415a70");
	if(isdefined(entity.ai.var_502d9d0d))
	{
		[[entity.ai.var_502d9d0d]](entity, var_f5022ab9);
	}
}

/*
	Name: function_df15eebf
	Namespace: namespace_d2f65e05
	Checksum: 0xC6BE828C
	Offset: 0x2188
	Size: 0x4E4
	Parameters: 1
	Flags: Linked, Private
*/
private function function_df15eebf(entity)
{
	origin = entity gettagorigin("j_nose4");
	radiusdamage(origin, 600, 70, 30, entity);
	enemies = util::function_81ccf6d3(self.team);
	foreach(target in enemies)
	{
		dist = distance(self.origin, target.origin);
		if(isplayer(target) && dist < 600)
		{
			params = function_4d1e7b48(#"hash_2c80515d8ac9f1b4");
			weapon = getweapon(#"zombie_ai_defaultmelee");
			target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
			var_95fca4e5 = (target.origin[0], target.origin[1], self.origin[2]);
			var_7d97040b = vectornormalize(var_95fca4e5 - self.origin);
			target playerknockback(1);
			knockback = mapfloat(0, 600, 100, 1000, dist);
			target applyknockback(int(knockback), var_7d97040b);
			target playerknockback(0);
		}
	}
	entity clientfield::increment("towers_boss_melee_effect");
	var_a5a1f99c = getaiarchetypearray(#"zombie");
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"hash_1bab8a0ba811401e"), 0, 0);
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"tiger"), 0, 0);
	var_a5a1f99c = array::filter(var_a5a1f99c, 0, &function_1d65bc12, entity);
	[[self.ai.var_64eb729e]](var_a5a1f99c, entity);
	var_bfd0a84a = getentarray("towers_boss_tower_trigger", "targetname");
	foreach(var_e220a902 in var_bfd0a84a)
	{
		if(!(isdefined(var_e220a902.b_exploded) && var_e220a902.b_exploded))
		{
			distsq = distancesquared(entity.origin, var_e220a902.origin);
			if(distsq < 300 * 300)
			{
				continue;
			}
			if(!util::within_fov(entity.origin, entity.angles, var_e220a902.origin, cos(90)))
			{
				continue;
			}
			var_e220a902 notify(#"tower_boss_scripted_trigger_tower");
		}
	}
}

/*
	Name: function_2328518e
	Namespace: namespace_d2f65e05
	Checksum: 0x47B312E4
	Offset: 0x2678
	Size: 0x284
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2328518e(entity)
{
	origin = entity gettagorigin("j_nose4");
	radiusdamage(origin, 450, 70, 30, entity);
	enemies = util::function_81ccf6d3(self.team);
	foreach(target in enemies)
	{
		dist = distance(self.origin, target.origin);
		if(isplayer(target) && dist < 450)
		{
			params = function_4d1e7b48(#"hash_2c80515d8ac9f1b4");
			weapon = getweapon("zombie_ai_defaultmelee");
			target status_effect::status_effect_apply(params, weapon, entity, 0, 500);
			var_7d97040b = vectornormalize(anglestoforward(target.origin - self.origin));
			target playerknockback(1);
			knockback = mapfloat(0, 450, 100, 500, dist);
			target applyknockback(int(knockback), var_7d97040b);
			target playerknockback(0);
		}
	}
	entity clientfield::increment("towers_boss_melee_effect");
}

/*
	Name: function_9d14fcee
	Namespace: namespace_d2f65e05
	Checksum: 0xBEF3FB6F
	Offset: 0x2908
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_9d14fcee()
{
	if(isdefined(self.enemy))
	{
		predictedpos = self.enemy.origin;
		if(isdefined(predictedpos))
		{
			turnyaw = absangleclamp360(self.angles[1] - vectortoangles(predictedpos - self.origin)[1]);
			return turnyaw;
		}
	}
	return undefined;
}

/*
	Name: function_48f6761d
	Namespace: namespace_d2f65e05
	Checksum: 0xA0D7A4D0
	Offset: 0x2998
	Size: 0x734
	Parameters: 2
	Flags: Linked
*/
function function_48f6761d(elephant, waittime = 0)
{
	wait(waittime);
	elephant detach(self.ai.armor, "tag_origin");
	if(elephant isattached(#"hash_4f282285ef50e3ee", "tag_origin"))
	{
		elephant detach(#"hash_4f282285ef50e3ee", "tag_origin");
	}
	if(elephant isattached(#"hash_4f282185ef50e23b", "tag_origin"))
	{
		elephant detach(#"hash_4f282185ef50e23b", "tag_origin");
	}
	if(elephant isattached(#"hash_4f282085ef50e088", "tag_origin"))
	{
		elephant detach(#"hash_4f282085ef50e088", "tag_origin");
	}
	if(elephant isattached(#"hash_4f282785ef50ec6d", "tag_origin"))
	{
		elephant detach(#"hash_4f282785ef50ec6d", "tag_origin");
	}
	if(elephant isattached(#"hash_4f282585ef50e907", "tag_origin"))
	{
		elephant detach(#"hash_4f282585ef50e907", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa8365b64e75008", "tag_origin"))
	{
		elephant detach(#"hash_4fa8365b64e75008", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa8395b64e75521", "tag_origin"))
	{
		elephant detach(#"hash_4fa8395b64e75521", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa8385b64e7536e", "tag_origin"))
	{
		elephant detach(#"hash_4fa8385b64e7536e", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa83b5b64e75887", "tag_origin"))
	{
		elephant detach(#"hash_4fa83b5b64e75887", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa83a5b64e756d4", "tag_origin"))
	{
		elephant detach(#"hash_4fa83a5b64e756d4", "tag_origin");
	}
	if(elephant isattached(#"hash_4fa83d5b64e75bed", "tag_origin"))
	{
		elephant detach(#"hash_4fa83d5b64e75bed", "tag_origin");
	}
	if(elephant isattached(#"hash_78fee920883d70c9", "tag_origin"))
	{
		elephant detach(#"hash_78fee920883d70c9", "tag_origin");
	}
	if(elephant isattached(#"hash_2de139921fda52d2", "tag_origin"))
	{
		elephant detach(#"hash_2de139921fda52d2", "tag_origin");
	}
	if(elephant isattached(#"hash_53571fb496a1baf7", "tag_origin"))
	{
		elephant detach(#"hash_53571fb496a1baf7", "tag_origin");
	}
	if(elephant isattached(#"hash_85f1a2ad4a8a800", "tag_origin"))
	{
		elephant detach(#"hash_85f1a2ad4a8a800", "tag_origin");
	}
	if(elephant isattached(#"hash_6594ef853a532da6", "tag_origin"))
	{
		elephant detach(#"hash_6594ef853a532da6", "tag_origin");
	}
	if(elephant isattached(#"hash_7dc07ccf4279d977", "tag_origin"))
	{
		elephant detach(#"hash_7dc07ccf4279d977", "tag_origin");
	}
	if(elephant isattached(#"hash_7d53be376158dffc", "tag_origin"))
	{
		elephant detach(#"hash_7d53be376158dffc", "tag_origin");
	}
	if(elephant isattached(#"hash_2368463b34158f49", "tag_origin"))
	{
		elephant detach(#"hash_2368463b34158f49", "tag_origin");
	}
	if(elephant isattached(#"hash_ffe4c9fe62b4c26", "tag_origin"))
	{
		elephant detach(#"hash_ffe4c9fe62b4c26", "tag_origin");
	}
	if(elephant isattached(#"hash_77bc0eb77181ba5b", "tag_origin"))
	{
		elephant detach(#"hash_77bc0eb77181ba5b", "tag_origin");
	}
	if(elephant isattached(#"hash_32c877458080c680", "tag_origin"))
	{
		elephant detach(#"hash_32c877458080c680", "tag_origin");
	}
}

/*
	Name: function_423390f2
	Namespace: namespace_d2f65e05
	Checksum: 0x8DB69855
	Offset: 0x30D8
	Size: 0x2CC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_423390f2()
{
	self endon(#"death");
	while(!isdefined(self.ai.phase))
	{
		waitframe(1);
	}
	if(self.ai.phase == #"hash_266f56fb994e6639")
	{
		self.ai.armor = #"hash_53ac5aa39c680a35";
	}
	else
	{
		self.ai.armor = #"hash_76c423ccbf246dc2";
	}
	self attach(self.ai.armor, "tag_origin");
	if(self.ai.phase == #"hash_266f53fb994e6120")
	{
		self attach(#"hash_4fa8365b64e75008", "tag_origin");
		self attach(#"hash_4fa8395b64e75521", "tag_origin");
		self attach(#"hash_4fa8385b64e7536e", "tag_origin");
		self attach(#"hash_4fa83b5b64e75887", "tag_origin");
		self attach(#"hash_4fa83a5b64e756d4", "tag_origin");
		self attach(#"hash_4fa83d5b64e75bed", "tag_origin");
	}
	else
	{
		self attach(#"hash_7dc07ccf4279d977", "tag_origin");
		self attach(#"hash_7d53be376158dffc", "tag_origin");
		self attach(#"hash_2368463b34158f49", "tag_origin");
		self attach(#"hash_ffe4c9fe62b4c26", "tag_origin");
		self attach(#"hash_77bc0eb77181ba5b", "tag_origin");
		self attach(#"hash_32c877458080c680", "tag_origin");
	}
}

/*
	Name: function_7427c937
	Namespace: namespace_d2f65e05
	Checksum: 0x889ED287
	Offset: 0x33B0
	Size: 0x11E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_7427c937(elephant, rider)
{
	if(!isdefined(elephant.closestenemy))
	{
		return 0;
	}
	if(gettime() < elephant.ai.var_4622f7a9)
	{
		return 0;
	}
	if(isdefined(elephant.ai.var_a504b9a3))
	{
		return 0;
	}
	distsq = distancesquared(elephant.origin, elephant.closestenemy.origin);
	if(distsq < 200 * 200)
	{
		return 0;
	}
	if(!util::within_fov(rider.origin + vectorscale((0, 0, -1), 40), rider.angles, elephant.closestenemy.origin, cos(70)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_67fbc3a3
	Namespace: namespace_d2f65e05
	Checksum: 0x875436CE
	Offset: 0x34D8
	Size: 0x132
	Parameters: 3
	Flags: Linked, Private
*/
private function function_67fbc3a3(elephant, rider, var_c3f91959)
{
	predictedpos = undefined;
	if(isdefined(elephant.closestenemy))
	{
		predictedpos = elephant lastknownpos(elephant.closestenemy);
	}
	else if(isdefined(var_c3f91959))
	{
		predictedpos = var_c3f91959.origin;
	}
	if(isdefined(predictedpos))
	{
		turnyaw = absangleclamp360(rider.angles[1] - vectortoangles(predictedpos - rider.origin)[1]);
		if(turnyaw >= 67.5 && turnyaw <= 180)
		{
			return "attack_right";
		}
		if(turnyaw >= 180 && turnyaw <= 292.5)
		{
			return "attack_left";
		}
	}
	return "attack_forward";
}

/*
	Name: function_978a4592
	Namespace: namespace_d2f65e05
	Checksum: 0x7F73EA5D
	Offset: 0x3618
	Size: 0x4A6
	Parameters: 2
	Flags: Linked, Private
*/
private function function_978a4592(elephant, rider)
{
	rider endon(#"death", #"hash_45ddc9393cf1b3e2");
	elephant endon(#"death");
	while(true)
	{
		if(isdefined(rider.ai.inpain) && rider.ai.inpain || (isdefined(rider.ai.ducking) && rider.ai.ducking))
		{
			waitframe(1);
			continue;
		}
		if(function_7427c937(elephant, rider))
		{
			rider.ai.attacking = 1;
			attackdirection = function_67fbc3a3(elephant, rider);
			aligntag = rider.ai.var_4f12fc77;
			rider.ai.var_c3f91959 = undefined;
			if(attackdirection == "attack_right")
			{
				rider animation::play(rider.ai.var_182e3181, elephant, aligntag, 1.5, 0.2, 0.1, undefined, undefined, undefined, 0);
			}
			else if(attackdirection == "attack_left")
			{
				rider animation::play(rider.ai.var_debedb6f, elephant, aligntag, 1.5, 0.2, 0.1, undefined, undefined, undefined, 0);
			}
			else
			{
				rider animation::play(rider.ai.var_9ca71a12, elephant, aligntag, 1.5, 0.2, 0.1, undefined, undefined, undefined, 0);
			}
			rider.ai.attacking = 0;
			wait(randomintrange(1, 2));
		}
		else if(isdefined(level.var_5feff7d0))
		{
			var_c3f91959 = [[level.var_5feff7d0]](elephant, rider);
			if(isdefined(var_c3f91959))
			{
				rider.ai.attacking = 1;
				attackdirection = function_67fbc3a3(elephant, rider, var_c3f91959);
				aligntag = rider.ai.var_4f12fc77;
				rider.ai.var_c3f91959 = var_c3f91959;
				if(attackdirection == "attack_right")
				{
					rider animation::play(rider.ai.var_182e3181, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
				}
				else if(attackdirection == "attack_left")
				{
					rider animation::play(rider.ai.var_debedb6f, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
				}
				else
				{
					rider animation::play(rider.ai.var_9ca71a12, elephant, aligntag, 1.2, 0.2, 0.1, undefined, undefined, undefined, 0);
				}
				rider.ai.attacking = 0;
				wait(randomintrange(1, 2));
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_202012ad
	Namespace: namespace_d2f65e05
	Checksum: 0x9C877AC0
	Offset: 0x3AC8
	Size: 0x68
	Parameters: 2
	Flags: Linked
*/
function function_202012ad(elephant, rider)
{
	currenttime = gettime();
	if(isdefined(rider.ai.var_37e9f736) && gettime() - rider.ai.var_37e9f736 <= 50)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_1cd7a6d7
	Namespace: namespace_d2f65e05
	Checksum: 0x6B50E223
	Offset: 0x3B38
	Size: 0x196
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1cd7a6d7(elephant, rider)
{
	rider endon(#"death", #"hash_45ddc9393cf1b3e2");
	elephant endon(#"death");
	while(true)
	{
		if(function_202012ad(elephant, rider))
		{
			rider.ai.inpain = 1;
			aligntag = rider.ai.var_4f12fc77;
			rider.ai.var_bd0ffccf = rider animmappingsearch(#"hash_2e52a646a71cee70");
			/#
				assert(isdefined(rider.ai.var_bd0ffccf));
			#/
			rider animation::play(rider.ai.var_bd0ffccf, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
			rider.ai.inpain = 0;
			wait(randomintrange(3, 4));
		}
		waitframe(1);
	}
}

/*
	Name: function_557c9c90
	Namespace: namespace_d2f65e05
	Checksum: 0xB8CF536E
	Offset: 0x3CD8
	Size: 0x2F4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_557c9c90(elephant, rider)
{
	rider endon(#"death", #"hash_45ddc9393cf1b3e2");
	elephant endon(#"death");
	aligntag = rider.ai.var_4f12fc77;
	rider.ai.var_62c039ab = rider animmappingsearch(#"hash_6a0be85d14df502a");
	rider.ai.var_b8d6c5a = rider animmappingsearch(#"hash_22d12a7d199608d0");
	rider.ai.var_1f6a68ae = rider animmappingsearch(#"hash_323636e22326da5f");
	while(true)
	{
		if(!(isdefined(rider.ai.ducking) && rider.ai.ducking))
		{
			waitframe(1);
			continue;
		}
		if(!(isdefined(rider.ai.var_44b45a81) && rider.ai.var_44b45a81))
		{
			rider animation::play(rider.ai.var_62c039ab, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
			rider.ai.var_44b45a81 = 1;
		}
		rider animation::play(rider.ai.var_b8d6c5a, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
		if(isdefined(rider.ai.var_34106895) && rider.ai.var_34106895)
		{
			rider animation::play(rider.ai.var_1f6a68ae, elephant, aligntag, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
			rider.ai.var_44b45a81 = 0;
			rider.ai.ducking = 0;
			rider.ai.var_34106895 = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_2798bb2
	Namespace: namespace_d2f65e05
	Checksum: 0x6F146D77
	Offset: 0x3FD8
	Size: 0x3E8
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2798bb2(elephant, rider)
{
	rider endon(#"death", #"hash_45ddc9393cf1b3e2");
	elephant endon(#"death");
	var_f662e4fa = struct::get("tag_align_boss_doors", "targetname");
	if(elephant.ai.phase == #"hash_266f56fb994e6639")
	{
		rider ghost();
		elephant waittill(#"hash_6537a2364ba9dcb3");
		rider show();
	}
	if(isdefined(rider.ai.var_61a678fe))
	{
		rider unlink();
		rider.takedamage = 0;
		rider animation::play(rider.ai.var_61a678fe, var_f662e4fa.origin, var_f662e4fa.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
		rider.takedamage = 1;
		/#
			assert(isdefined(rider.ai.var_4f12fc77));
		#/
		rider linkto(elephant, rider.ai.var_4f12fc77, (0, 0, 0), (0, 0, 0));
	}
	rider thread function_978a4592(elephant, rider);
	rider thread function_1cd7a6d7(elephant, rider);
	rider thread function_557c9c90(elephant, rider);
	target_set(rider);
	while(true)
	{
		if(isdefined(rider.ai.ducking) && rider.ai.ducking)
		{
			waitframe(1);
			continue;
		}
		if(isdefined(rider.ai.attacking) && rider.ai.attacking)
		{
			waitframe(1);
			continue;
		}
		if(isdefined(rider.ai.inpain) && rider.ai.inpain)
		{
			waitframe(1);
			continue;
		}
		rider.ai.var_6fe5490e = rider animmappingsearch(#"hash_3cfb620b1f6d2192");
		/#
			assert(isdefined(rider.ai.var_6fe5490e));
		#/
		rider animation::play(rider.ai.var_6fe5490e, elephant, rider.ai.var_4f12fc77, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	}
}

/*
	Name: function_e5f2ff53
	Namespace: namespace_d2f65e05
	Checksum: 0x2707AA3C
	Offset: 0x43C8
	Size: 0x4F8
	Parameters: 3
	Flags: Linked, Private
*/
private function function_e5f2ff53(elephant, var_a4946e52, targetname)
{
	if(!isdefined(elephant.ai.riders))
	{
		elephant.ai.riders = [];
	}
	var_a02578 = self gettagorigin(var_a4946e52);
	var_cfdbb182 = self gettagangles(var_a4946e52);
	rider = spawnactor(#"hash_46a05f54d289c9d7", var_a02578, var_cfdbb182, targetname, 1);
	/#
		assert(isdefined(rider));
	#/
	rider attach("p7_shr_weapon_spear_lrg", "tag_weapon_right");
	rider.var_c8ec4813 = 1;
	rider linkto(self, var_a4946e52, (0, 0, 0), (0, 0, 0));
	array::add(elephant.ai.riders, rider);
	rider.ai.var_ed782d5 = getweapon("rider_spear_projectile");
	rider.ai.elephant = elephant;
	/#
		recordent(rider);
	#/
	rider.ai.var_6fe5490e = rider animmappingsearch(#"hash_3cfb620b1f6d2192");
	/#
		assert(isdefined(rider.ai.var_6fe5490e));
	#/
	rider.ai.var_9ca71a12 = rider animmappingsearch(#"hash_52c3d7bee8eabebc");
	/#
		assert(isdefined(rider.ai.var_9ca71a12));
	#/
	rider.ai.var_182e3181 = rider animmappingsearch(#"hash_4950e0c9a2675981");
	/#
		assert(isdefined(rider.ai.var_182e3181));
	#/
	rider.ai.var_debedb6f = rider animmappingsearch(#"hash_37f92f1082115f74");
	/#
		assert(isdefined(rider.ai.var_debedb6f));
	#/
	n_health = 60000;
	for(i = 0; i < level.players.size - 1; i++)
	{
		n_health = n_health + 15000;
	}
	rider.maxhealth = n_health;
	rider.health = n_health;
	rider.goalradius = 24;
	rider.b_ignore_cleanup = 1;
	rider.ignore_nuke = 1;
	rider.lightning_chain_immune = 1;
	rider.var_dd6fe31f = 1;
	rider disableaimassist();
	rider attach("c_t8_zmb_dlc0_zombie_destroyer_le_arm1", "j_shoulder_le");
	rider attach("c_t8_zmb_dlc0_zombie_destroyer_ri_arm1", "j_clavicle_ri");
	rider attach("c_t8_zmb_dlc0_zombie_destroyer_helmet1", "j_head");
	rider attach("c_t8_zmb_dlc0_zombie_destroyer_le_pauldron1", "tag_pauldron_le");
	rider attach("c_t8_zmb_dlc0_zombie_destroyer_ri_pauldron1", "tag_pauldron_ri");
	aiutility::addaioverridedamagecallback(rider, &function_ee23b15d);
	return rider;
}

/*
	Name: function_d8c752e0
	Namespace: namespace_d2f65e05
	Checksum: 0x18705911
	Offset: 0x48C8
	Size: 0x3FC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d8c752e0()
{
	self endon(#"death");
	while(!isdefined(self.ai.phase))
	{
		waitframe(1);
	}
	rider = function_e5f2ff53(self, "tag_char_align_a", #"hash_6101964904e7d17b");
	rider.ai.var_758ed187 = #"hash_20cbd41b17321edc";
	rider.ai.var_4f12fc77 = "tag_char_align_a";
	rider.instakill_func = &function_707d0196;
	rider.allowdeath = 0;
	if(self.ai.phase == #"hash_266f53fb994e6120")
	{
		rider.ai.var_61a678fe = #"hash_561cf85af113ff1e";
	}
	else
	{
		rider.ai.var_61a678fe = #"hash_1447253275dbb643";
	}
	rider thread function_2798bb2(self, rider);
	rider = function_e5f2ff53(self, "tag_char_align_b", #"hash_2672ad69ba7c107");
	rider.ai.var_758ed187 = #"hash_20cbd71b173223f5";
	rider.ai.var_4f12fc77 = "tag_char_align_b";
	rider.instakill_func = &function_707d0196;
	if(self.ai.phase == #"hash_266f53fb994e6120")
	{
		rider.ai.var_61a678fe = #"hash_561cf75af113fd6b";
	}
	else
	{
		rider.ai.var_61a678fe = #"hash_1447263275dbb7f6";
	}
	rider thread function_2798bb2(self, rider);
	if(isdefined(level.var_a52a5487) && level.var_a52a5487)
	{
		rider = function_e5f2ff53(self, "tag_char_align_c", #"hash_6101964904e7d17b");
		rider.ai.var_758ed187 = #"hash_20cbd41b17321edc";
		rider.ai.var_4f12fc77 = "tag_char_align_c";
		rider.instakill_func = &function_707d0196;
		rider.ai.var_61a678fe = #"hash_1447273275dbb9a9";
		rider thread function_2798bb2(self, rider);
		rider = function_e5f2ff53(self, "tag_char_align_d", #"hash_2672ad69ba7c107");
		rider.ai.var_758ed187 = #"hash_20cbd71b173223f5";
		rider.ai.var_4f12fc77 = "tag_char_align_d";
		rider.instakill_func = &function_707d0196;
		rider.ai.var_61a678fe = #"hash_1447283275dbbb5c";
		rider thread function_2798bb2(self, rider);
	}
}

/*
	Name: function_670bff63
	Namespace: namespace_d2f65e05
	Checksum: 0xA8C1EE06
	Offset: 0x4CD0
	Size: 0xD6
	Parameters: 0
	Flags: Private
*/
private function function_670bff63()
{
	self endon(#"death");
	while(true)
	{
		if(isdefined(self.favoriteenemy))
		{
			dist = distance(self.origin, self.favoriteenemy.origin);
			/#
				record3dtext("" + dist, self.origin, (0, 1, 0), "");
				recordcircle(self.favoriteenemy.origin, 4, (0, 1, 1), "");
			#/
		}
		waitframe(1);
	}
}

/*
	Name: function_4c731a08
	Namespace: namespace_d2f65e05
	Checksum: 0x10226CD0
	Offset: 0x4DB0
	Size: 0x374
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4c731a08()
{
	self disableaimassist();
	self pushplayer(1);
	self setavoidancemask("avoid none");
	self.ai.var_5c1cc6e9 = gettime() + 3000;
	self.ai.var_c53cce81 = gettime() + randomintrange(3500, 4000);
	self.ai.var_a05929e4 = getweapon(#"hash_8a4d8f38ca65ff0");
	self.ai.var_4622f7a9 = gettime() + randomintrange(1500, 2000);
	self.b_ignore_cleanup = 1;
	self.ignore_nuke = 1;
	self.lightning_chain_immune = 1;
	self.maxhealth = self ai::function_9139c839().minhealth;
	for(i = 0; i < level.players.size - 1; i++)
	{
		self.maxhealth = self.maxhealth + int(self ai::function_9139c839().minhealth * self ai::function_9139c839().var_854eebd);
	}
	self.health = self.maxhealth;
	self setrepairpaths(0);
	self.targetname = "zombie_towers_boss";
	self.clamptonavmesh = 1;
	self.ai.var_a5dabb8b = 1;
	self.allowdeath = 0;
	self bloodimpact("none");
	namespace_81245006::function_b8cf6ebd(self, #"hash_13e16de0f170d841");
	aiutility::addaioverridedamagecallback(self, &function_cfe82365);
	function_2e4487f6(self, #"hash_8e173ae91589439");
	self thread function_f51431a9(self);
	self thread function_423390f2();
	self setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
	self thread function_d8c752e0();
	self clientfield::set("sndTowersBossArmor", 1);
	self thread function_4ccdadc3();
	/#
		self thread function_670bff63();
		self thread function_ad38f85c();
	#/
}

/*
	Name: function_4ccdadc3
	Namespace: namespace_d2f65e05
	Checksum: 0x1EEF959A
	Offset: 0x5130
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_4ccdadc3()
{
	self endon(#"death");
	while(!isdefined(self.ai.phase))
	{
		wait(0.1);
	}
	if(self.ai.phase == #"hash_266f56fb994e6639")
	{
		self clientfield::set("towers_boss_eye_fx_cf", 2);
	}
	else
	{
		self clientfield::set("towers_boss_eye_fx_cf", 1);
	}
}

/*
	Name: function_5db0f49a
	Namespace: namespace_d2f65e05
	Checksum: 0xEDFE5EFF
	Offset: 0x51E0
	Size: 0x26
	Parameters: 1
	Flags: Linked, Private
*/
private function function_5db0f49a(entity)
{
	entity.ai.isturning = 1;
	return 1;
}

/*
	Name: function_1c0db2ec
	Namespace: namespace_d2f65e05
	Checksum: 0x8A2FC72A
	Offset: 0x5210
	Size: 0x26
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1c0db2ec(entity)
{
	entity.ai.isturning = 0;
	return 1;
}

/*
	Name: function_9c076ff9
	Namespace: namespace_d2f65e05
	Checksum: 0x8D43803E
	Offset: 0x5240
	Size: 0x44
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9c076ff9(entity)
{
	entity setgoal(entity.origin);
	entity clearpath();
}

/*
	Name: function_1d65bc12
	Namespace: namespace_d2f65e05
	Checksum: 0x317F06D6
	Offset: 0x5290
	Size: 0x1A0
	Parameters: 3
	Flags: Linked, Private
*/
private function function_1d65bc12(enemy, elephant, var_60e4c6b7 = 1)
{
	if(isdefined(enemy.knockdown) && enemy.knockdown)
	{
		return 0;
	}
	if(gibserverutils::isgibbed(enemy, 384))
	{
		return 0;
	}
	if(distancesquared(enemy.origin, elephant.origin) > 250 * 250)
	{
		return 0;
	}
	var_f2fb414f = anglestoforward(elephant.angles);
	var_9349139f = enemy.origin - elephant.origin;
	var_3e3c8075 = (var_9349139f[0], var_9349139f[1], 0);
	var_c2ee8451 = (var_f2fb414f[0], var_f2fb414f[1], 0);
	var_3e3c8075 = vectornormalize(var_3e3c8075);
	var_c2ee8451 = vectornormalize(var_c2ee8451);
	if(var_60e4c6b7)
	{
		var_34e02165 = vectordot(var_c2ee8451, var_3e3c8075);
		if(var_34e02165 < 0)
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: function_8c203da0
	Namespace: namespace_d2f65e05
	Checksum: 0x65474F71
	Offset: 0x5438
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8c203da0(entity)
{
	if(!isdefined(self.ai.var_a504b9a3))
	{
		return 0;
	}
	var_a5a1f99c = getaiarchetypearray(#"zombie");
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"hash_1bab8a0ba811401e"), 0, 0);
	var_a5a1f99c = arraycombine(var_a5a1f99c, getaiarchetypearray(#"tiger"), 0, 0);
	var_a5a1f99c = array::filter(var_a5a1f99c, 0, &function_1d65bc12, entity);
	[[self.ai.var_64eb729e]](var_a5a1f99c, entity);
}

/*
	Name: function_ad38f85c
	Namespace: namespace_d2f65e05
	Checksum: 0xCD873622
	Offset: 0x5550
	Size: 0xD8
	Parameters: 0
	Flags: Private
*/
private function function_ad38f85c()
{
	self waittill(#"death");
	if(isdefined(self.ai.riders))
	{
		foreach(rider in self.ai.riders)
		{
			if(isdefined(rider))
			{
				aiutility::removeaioverridedamagecallback(rider, &function_ee23b15d);
				rider delete();
			}
		}
	}
}

/*
	Name: function_74fba881
	Namespace: namespace_d2f65e05
	Checksum: 0x4514FE19
	Offset: 0x5630
	Size: 0x76C
	Parameters: 1
	Flags: Linked
*/
function function_74fba881(elephant)
{
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_carriage_ws_le");
	if(!isdefined(var_dd54fdb1))
	{
		return;
	}
	if(var_dd54fdb1.health <= var_dd54fdb1.maxhealth * 0.1)
	{
		if(elephant isattached(#"hash_4fa83d5b64e75bed", "tag_origin"))
		{
			elephant detach(#"hash_4fa83d5b64e75bed", "tag_origin");
			elephant attach(#"hash_4f282585ef50e907", "tag_origin");
			elephant playsound(#"hash_9d86c1e08ca3809");
		}
		else if(elephant isattached(#"hash_32c877458080c680", "tag_origin"))
		{
			elephant detach(#"hash_32c877458080c680", "tag_origin");
			elephant attach(#"hash_6594ef853a532da6", "tag_origin");
			elephant playsound(#"hash_9d86c1e08ca3809");
		}
	}
	else if(var_dd54fdb1.health <= var_dd54fdb1.maxhealth * 0.25)
	{
		if(elephant isattached(#"hash_4fa83b5b64e75887", "tag_origin"))
		{
			elephant detach(#"hash_4fa83b5b64e75887", "tag_origin");
			elephant detach(#"hash_4fa83a5b64e756d4", "tag_origin");
			elephant attach(#"hash_4f282785ef50ec6d", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
		else if(elephant isattached(#"hash_ffe4c9fe62b4c26", "tag_origin"))
		{
			elephant detach(#"hash_ffe4c9fe62b4c26", "tag_origin");
			elephant detach(#"hash_77bc0eb77181ba5b", "tag_origin");
			elephant attach(#"hash_85f1a2ad4a8a800", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
	}
	else if(var_dd54fdb1.health <= var_dd54fdb1.maxhealth * 0.5)
	{
		if(elephant isattached(#"hash_4fa8385b64e7536e", "tag_origin"))
		{
			elephant detach(#"hash_4fa8385b64e7536e", "tag_origin");
			elephant attach(#"hash_4f282085ef50e088", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
		else if(elephant isattached(#"hash_2368463b34158f49", "tag_origin"))
		{
			elephant detach(#"hash_2368463b34158f49", "tag_origin");
			elephant attach(#"hash_53571fb496a1baf7", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
	}
	else if(var_dd54fdb1.health <= var_dd54fdb1.maxhealth * 0.75)
	{
		if(elephant isattached(#"hash_4fa8395b64e75521", "tag_origin"))
		{
			elephant detach(#"hash_4fa8395b64e75521", "tag_origin");
			elephant attach(#"hash_4f282185ef50e23b", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
		else if(elephant isattached(#"hash_7d53be376158dffc", "tag_origin"))
		{
			elephant detach(#"hash_7d53be376158dffc", "tag_origin");
			elephant attach(#"hash_2de139921fda52d2", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
	}
	else if(var_dd54fdb1.health <= var_dd54fdb1.maxhealth * 0.95)
	{
		if(elephant isattached(#"hash_4fa8365b64e75008", "tag_origin"))
		{
			elephant detach(#"hash_4fa8365b64e75008", "tag_origin");
			elephant attach(#"hash_4f282285ef50e3ee", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
		else if(elephant isattached(#"hash_7dc07ccf4279d977", "tag_origin"))
		{
			elephant detach(#"hash_7dc07ccf4279d977", "tag_origin");
			elephant attach(#"hash_78fee920883d70c9", "tag_origin");
			elephant playsound(#"hash_55bac56f7a46775c");
		}
	}
}

/*
	Name: function_c153d922
	Namespace: namespace_d2f65e05
	Checksum: 0xD6E7E5F9
	Offset: 0x5DA8
	Size: 0x186
	Parameters: 3
	Flags: Linked
*/
function function_c153d922(elephant, point, bonename)
{
	/#
		assert(isdefined(point) && isdefined(bonename));
	#/
	var_845efb9f = elephant gettagorigin(bonename);
	if(distancesquared(var_845efb9f, point) <= 40 * 40)
	{
		/#
			recordsphere(point, 4, (0, 1, 0), "");
		#/
		/#
			recordsphere(var_845efb9f, 4, (0, 0, 1), "");
		#/
		/#
			recordline(var_845efb9f, point, (0, 0, 1), "");
		#/
		return 1;
	}
	/#
		recordsphere(point, 4, (1, 0, 0), "");
	#/
	/#
		recordsphere(var_845efb9f, 4, (0, 0, 1), "");
	#/
	/#
		recordline(var_845efb9f, point, (0, 0, 1), "");
	#/
	return 0;
}

/*
	Name: function_498f147
	Namespace: namespace_d2f65e05
	Checksum: 0xF5320B86
	Offset: 0x5F38
	Size: 0x182
	Parameters: 3
	Flags: Linked
*/
function function_498f147(elephant, point, boneindex)
{
	if(!isdefined(point))
	{
		return 0;
	}
	if(isdefined(boneindex))
	{
		var_dd54fdb1 = namespace_81245006::function_37e3f011(self, boneindex);
		if(isdefined(var_dd54fdb1))
		{
			return getpartname(elephant, boneindex);
		}
	}
	if(self.ai.var_112ec817 == #"hash_8e173ae91589439")
	{
		if(function_c153d922(elephant, point, "tag_chest_armor_ws"))
		{
			return "tag_chest_armor_ws";
		}
		if(function_c153d922(elephant, point, "tag_carriage_ws_le"))
		{
			return "tag_carriage_ws_le";
		}
		if(function_c153d922(elephant, point, "tag_carriage_ws_ri"))
		{
			return "tag_carriage_ws_ri";
		}
	}
	else if(function_c153d922(elephant, point, "tag_head_ws"))
	{
		return "tag_head_ws";
	}
	if(function_c153d922(elephant, point, "tag_body_ws"))
	{
		return "tag_body_ws";
	}
	return undefined;
}

/*
	Name: function_e864f0da
	Namespace: namespace_d2f65e05
	Checksum: 0x68F72A25
	Offset: 0x60C8
	Size: 0x234
	Parameters: 6
	Flags: Linked
*/
function function_e864f0da(elephant, damage, attacker, point, dir, var_88cb1bf9)
{
	/#
		assert(isdefined(elephant));
	#/
	self.var_265cb589 = 1;
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_carriage_ws_le");
	if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 1)
	{
		attacker playhitmarker(undefined, 5, undefined, 1, 0);
		level notify(#"hash_3aa3137f1bf70773");
		namespace_81245006::function_ef87b7e8(var_dd54fdb1, damage);
		/#
			iprintlnbold("" + var_dd54fdb1.health);
		#/
		if(namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
		{
			/#
				iprintlnbold("");
			#/
		}
		function_74fba881(elephant);
		if(isdefined(var_88cb1bf9))
		{
			if(elephant.ai.phase == #"hash_266f56fb994e6639")
			{
				playfxontag("maps/zm_towers/fx8_boss_dmg_weakspot_gem_blue", elephant, var_88cb1bf9);
			}
			else
			{
				playfxontag("maps/zm_towers/fx8_boss_dmg_weakspot_gem_red", elephant, var_88cb1bf9);
			}
		}
	}
	else
	{
		playfx("maps/zm_towers/fx8_boss_dmg_flesh", point, dir * -1);
		attacker playhitmarker(undefined, 1, undefined, 0);
	}
}

/*
	Name: function_c62e8244
	Namespace: namespace_d2f65e05
	Checksum: 0x633DA4BA
	Offset: 0x6308
	Size: 0x72
	Parameters: 1
	Flags: Private
*/
private function function_c62e8244(damage)
{
	var_fc863ca1 = 1.5;
	for(i = 0; i < level.players.size; i++)
	{
		var_fc863ca1 = var_fc863ca1 - 0.07;
	}
	return int(damage * var_fc863ca1);
}

/*
	Name: function_a903e1eb
	Namespace: namespace_d2f65e05
	Checksum: 0x56A216D2
	Offset: 0x6388
	Size: 0x66
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a903e1eb(elephant)
{
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_carriage_ws_le");
	if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_ee23b15d
	Namespace: namespace_d2f65e05
	Checksum: 0xB2E95742
	Offset: 0x63F8
	Size: 0x1A4
	Parameters: 12
	Flags: Linked
*/
function function_ee23b15d(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(attacker === self)
	{
		return 0;
	}
	if(isdefined(attacker) && !isplayer(attacker))
	{
		return 0;
	}
	if(self.health - damage <= 0)
	{
		self.health = self.health + int(damage + 1);
		self.ai.var_37e9f736 = gettime();
	}
	/#
		assert(isdefined(self.ai.elephant));
	#/
	if(isdefined(level.var_b394f92f))
	{
		var_72c8f5ac = [[level.var_b394f92f]](attacker, weapon, boneindex, hitloc, point);
		damage = damage * var_72c8f5ac;
	}
	function_e864f0da(self.ai.elephant, damage, attacker, point, dir);
	level notify(#"hash_5588a95b63ca4e19");
	return damage;
}

/*
	Name: function_cfe82365
	Namespace: namespace_d2f65e05
	Checksum: 0x5CB78B3D
	Offset: 0x65A8
	Size: 0x92
	Parameters: 12
	Flags: Linked
*/
function function_cfe82365(inflictor, attacker, damage, idflags, meansofdeath, weapon, point, dir, hitloc, offsettime, boneindex, modelindex)
{
	if(isdefined(attacker) && !isplayer(attacker))
	{
		return 0;
	}
	return damage;
}

/*
	Name: function_e8525036
	Namespace: namespace_d2f65e05
	Checksum: 0x6846F74
	Offset: 0x6648
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e8525036()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_137a1ca8;
}

/*
	Name: function_137a1ca8
	Namespace: namespace_d2f65e05
	Checksum: 0xD23A2D3F
	Offset: 0x66A0
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_137a1ca8(entity)
{
	entity.__blackboard = undefined;
	entity function_e8525036();
}

/*
	Name: function_16096ca1
	Namespace: namespace_d2f65e05
	Checksum: 0x816ECD1D
	Offset: 0x66D8
	Size: 0x110
	Parameters: 1
	Flags: Linked, Private
*/
private function function_16096ca1(elephant)
{
	if(elephant.ai.var_112ec817 == #"hash_8e173ae91589439")
	{
		return 0;
	}
	var_9f6c27c5 = 0;
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_body_ws");
	if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
	{
		var_9f6c27c5 = 1;
	}
	headdestroyed = 0;
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_head_ws");
	if(isdefined(var_dd54fdb1) && namespace_81245006::function_f29756fe(var_dd54fdb1) === 3)
	{
		headdestroyed = 1;
	}
	if(var_9f6c27c5 || headdestroyed)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_d6ae999a
	Namespace: namespace_d2f65e05
	Checksum: 0x347BF9DC
	Offset: 0x67F0
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d6ae999a(elephant)
{
	if(elephant.ai.var_112ec817 != #"hash_8e173ae91589439")
	{
		return 1;
	}
	if(function_a903e1eb(elephant))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_26ce5914
	Namespace: namespace_d2f65e05
	Checksum: 0x19E68A24
	Offset: 0x6850
	Size: 0x104
	Parameters: 2
	Flags: Linked, Private
*/
private function function_26ce5914(rider, elephant)
{
	rider endon(#"death");
	rider notify(#"hash_45ddc9393cf1b3e2");
	rider animation::stop();
	rider animation::play(rider.ai.var_758ed187, elephant, rider.ai.var_4f12fc77, 1, 0.2, 0.1);
	aiutility::removeaioverridedamagecallback(rider, &function_ee23b15d);
	rider unlink();
	rider.allowdeath = 1;
	rider delete();
}

/*
	Name: function_91bee4fc
	Namespace: namespace_d2f65e05
	Checksum: 0x331E33F9
	Offset: 0x6960
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_91bee4fc()
{
	self clientfield::set("sndTowersBossArmor", 0);
	self thread function_48f6761d(self, 0.1);
	self.var_25f9fcf1 show();
	self.var_25f9fcf1 useanimtree("generic");
	self.var_25f9fcf1 animation::play("p8_fxanim_zm_towers_boss_armor_explode_anim", self.origin, self.angles, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	self.var_25f9fcf1 delete();
}

/*
	Name: function_cd989dbb
	Namespace: namespace_d2f65e05
	Checksum: 0xA48B4AF1
	Offset: 0x6A50
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_cd989dbb()
{
	self.var_25f9fcf1 = spawn("script_model", self.origin);
	if(self.ai.phase == #"hash_266f56fb994e6639")
	{
		self.var_25f9fcf1 setmodel("p8_fxanim_zm_towers_boss_armor_explode_02_mod");
	}
	else
	{
		self.var_25f9fcf1 setmodel("p8_fxanim_zm_towers_boss_armor_explode_mod");
	}
	self.var_25f9fcf1 hide();
}

/*
	Name: function_4d479d22
	Namespace: namespace_d2f65e05
	Checksum: 0xB34105F5
	Offset: 0x6B10
	Size: 0x374
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4d479d22(elephant)
{
	if(!isdefined(elephant.ai.riders))
	{
		return;
	}
	foreach(rider in elephant.ai.riders)
	{
		rider thread function_26ce5914(rider, elephant);
	}
	elephant function_cd989dbb();
	elephant.maxhealth = elephant ai::function_9139c839().minhealth;
	for(i = 0; i < level.players.size - 1; i++)
	{
		elephant.maxhealth = elephant.maxhealth + int(elephant ai::function_9139c839().minhealth * elephant ai::function_9139c839().var_854eebd);
	}
	elephant.health = elephant.maxhealth;
	elephant animation::play("ch_vign_tplt_inbtl_hllpht_evlve_2_stg_2_00_hllpht", undefined, undefined, 1, 0.2, 0.1, undefined, undefined, undefined, 0);
	level notify(#"hash_634700dd42db02d8");
	elephant setblackboardattribute("_locomotion_speed", "locomotion_speed_run");
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_carriage_ws_le");
	namespace_81245006::function_6c64ebd3(var_dd54fdb1, 2);
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_carriage_ws_ri");
	namespace_81245006::function_6c64ebd3(var_dd54fdb1, 2);
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_chest_armor_ws");
	namespace_81245006::function_6c64ebd3(var_dd54fdb1, 2);
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_body_ws");
	namespace_81245006::function_6c64ebd3(var_dd54fdb1, 1);
	var_dd54fdb1 = namespace_81245006::function_37e3f011(elephant, "tag_head_ws");
	namespace_81245006::function_6c64ebd3(var_dd54fdb1, 1);
	function_2e4487f6(elephant, #"hash_8e170ae91588f20");
}

/*
	Name: function_f51431a9
	Namespace: namespace_d2f65e05
	Checksum: 0x87820D89
	Offset: 0x6E90
	Size: 0x16C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f51431a9(elephant)
{
	elephant endon(#"death");
	while(true)
	{
		var_55fb74b2 = elephant.health <= elephant.maxhealth * 0.5;
		var_e8e6826f = elephant.health <= elephant.maxhealth * 0.2;
		currentstate = elephant.ai.var_112ec817;
		switch(currentstate)
		{
			case "hash_8e170ae91588f20":
			{
				if(function_16096ca1(elephant) || var_e8e6826f)
				{
					level thread function_42b6d3a3(elephant);
					return;
				}
				break;
			}
			case "hash_8e173ae91589439":
			{
				if(function_d6ae999a(elephant) || var_55fb74b2)
				{
					elephant function_4d479d22(elephant);
				}
				break;
			}
		}
		wait(1);
	}
}

/*
	Name: function_2e4487f6
	Namespace: namespace_d2f65e05
	Checksum: 0xB7BC4AF8
	Offset: 0x7008
	Size: 0xBA
	Parameters: 2
	Flags: Linked, Private
*/
private function function_2e4487f6(elephant, stage)
{
	/#
		assert(stage == #"hash_8e173ae91589439" || stage == #"hash_8e170ae91588f20");
	#/
	elephant.ai.var_112ec817 = stage;
	switch(stage)
	{
		case "hash_8e173ae91589439":
		{
			break;
		}
		case "hash_8e170ae91588f20":
		{
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_cd472d5
	Namespace: namespace_d2f65e05
	Checksum: 0xB6F5FDF0
	Offset: 0x70D0
	Size: 0x22C
	Parameters: 1
	Flags: Linked
*/
function function_cd472d5(entity)
{
	stage = entity.ai.var_112ec817;
	if(stage != #"hash_8e170ae91588f20")
	{
		return 0;
	}
	if(isdefined(self.var_b554dbf2) && self.var_b554dbf2)
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(isdefined(entity.ai.var_f2d193df) && gettime() < entity.ai.var_f2d193df)
	{
		return 0;
	}
	if(distancesquared(entity.favoriteenemy.origin, entity.origin) < 600 * 600)
	{
		return 0;
	}
	if(randomint(100) < 50)
	{
		return 0;
	}
	fov = cos(30);
	if(!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, fov))
	{
		return 0;
	}
	var_b21fc1a7 = blackboard::getblackboardevents("towersboss_head_proj");
	if(isdefined(var_b21fc1a7) && var_b21fc1a7.size)
	{
		foreach(var_358d39a3 in var_b21fc1a7)
		{
			if(var_358d39a3.enemy === entity.favoriteenemy)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_ce8fe2b0
	Namespace: namespace_d2f65e05
	Checksum: 0xE7C3C743
	Offset: 0x7308
	Size: 0x3C4
	Parameters: 2
	Flags: Linked
*/
function function_ce8fe2b0(entity, var_ab9f62ef)
{
	self endon(#"death");
	forwardvec = vectornormalize(anglestoforward(entity.angles));
	forwarddist = 200;
	if(isdefined(var_ab9f62ef))
	{
		var_6629fd0d = var_ab9f62ef;
	}
	else
	{
		var_6629fd0d = entity.origin + forwarddist * forwardvec;
	}
	var_cbdae441 = getclosestpointonnavmesh(var_6629fd0d, 500, 200);
	if(isdefined(var_cbdae441))
	{
		trace = groundtrace(var_cbdae441 + vectorscale((0, 0, 1), 200), var_cbdae441 + vectorscale((0, 0, -1), 200), 0, undefined);
		if(isdefined(trace[#"position"]))
		{
			newpos = trace[#"position"];
		}
		/#
			recordsphere(newpos, 15, (1, 0.5, 0), "");
		#/
		var_3f1f1429 = spawnvehicle(#"hash_6be593a62b8b87a5", newpos, entity.angles, "dynamic_spawn_ai");
		if(isdefined(var_3f1f1429))
		{
			var_3f1f1429.var_6353e3f1 = 1;
			entity.ai.var_f2d193df = gettime() + randomintrange(5000, 8000);
			if(isdefined(self.var_fe41477d) && self.var_fe41477d)
			{
				entity.ai.var_f2d193df = gettime() + 5000;
			}
		}
	}
	recordsphere(var_6629fd0d, 15, (0, 0, 0), "");
	wait(0.5);
	targets = getplayers();
	for(i = 0; i < targets.size; i++)
	{
		target = targets[i];
		if(!is_player_valid(target, 1, 1) || !function_71790b86(entity))
		{
			arrayremovevalue(targets, target);
			break;
		}
	}
	if(targets.size == 0)
	{
		return;
	}
	if(targets.size > 1 && self.ai.phase == #"hash_266f56fb994e6639" && isdefined(var_3f1f1429) && isalive(var_3f1f1429) && !isdefined(var_ab9f62ef))
	{
		function_ce8fe2b0(self, var_3f1f1429.origin);
	}
}

/*
	Name: function_69faa74
	Namespace: namespace_d2f65e05
	Checksum: 0x8F405AEF
	Offset: 0x76D8
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function function_69faa74(entity)
{
	stage = entity.ai.var_112ec817;
	if(stage != #"hash_8e170ae91588f20")
	{
		return 0;
	}
	if(isdefined(self.var_fe41477d) && self.var_fe41477d)
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(gettime() < entity.ai.var_c53cce81)
	{
		return 0;
	}
	if(distancesquared(entity.favoriteenemy.origin, entity.origin) < 600 * 600)
	{
		return 0;
	}
	fov = cos(20);
	if(!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, fov))
	{
		return 0;
	}
	var_b21fc1a7 = blackboard::getblackboardevents("towersboss_head_proj");
	if(isdefined(var_b21fc1a7) && var_b21fc1a7.size)
	{
		foreach(var_358d39a3 in var_b21fc1a7)
		{
			if(var_358d39a3.enemy === entity.favoriteenemy)
			{
				return 0;
			}
		}
	}
	return 1;
}

/*
	Name: function_2bfd3841
	Namespace: namespace_d2f65e05
	Checksum: 0x87C276F1
	Offset: 0x78D8
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_2bfd3841(entity)
{
	entity.ai.var_c53cce81 = gettime() + randomintrange(3500, 4000);
	var_51955401 = spawnstruct();
	var_51955401.enemy = entity.favoriteenemy;
	entity.var_f6ea2286 = entity.favoriteenemy.origin;
	blackboard::addblackboardevent("towersboss_head_proj", var_51955401, randomintrange(3500, 4000));
}

/*
	Name: function_18e1bf30
	Namespace: namespace_d2f65e05
	Checksum: 0xD6003E12
	Offset: 0x79B0
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_18e1bf30(entity)
{
	if(!function_e5afc75c(entity))
	{
		return 0;
	}
	if(!util::within_fov(entity.origin, entity.angles, entity.favoriteenemy.origin, cos(45)))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e5afc75c
	Namespace: namespace_d2f65e05
	Checksum: 0x445EA765
	Offset: 0x7A40
	Size: 0x156
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e5afc75c(entity)
{
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(entity asmistransitionrunning() || entity asmistransdecrunning())
	{
		return 0;
	}
	if(isdefined(entity.ai.isturning) && entity.ai.isturning)
	{
		return 0;
	}
	disttoenemysq = distancesquared(entity.favoriteenemy.origin, entity.origin);
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.favoriteenemy.origin - entity.origin)[1]);
	if(disttoenemysq <= 440 * 440 && abs(yawtoenemy) < 80)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_71790b86
	Namespace: namespace_d2f65e05
	Checksum: 0x1E9359DF
	Offset: 0x7BA0
	Size: 0x10
	Parameters: 1
	Flags: Linked, Private
*/
private function function_71790b86(entity)
{
	return 1;
}

/*
	Name: function_2ff17378
	Namespace: namespace_d2f65e05
	Checksum: 0xB435B13C
	Offset: 0x7BB8
	Size: 0x186
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2ff17378(entity)
{
	if(isdefined(entity.ai.var_ea8d826a) && entity.ai.var_ea8d826a)
	{
		return 0;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return 0;
	}
	if(entity.ai.var_5c1cc6e9 > gettime())
	{
		return 0;
	}
	if(isdefined(entity.ai.var_a504b9a3))
	{
		return 0;
	}
	if(entity asmistransitionrunning() || entity asmistransdecrunning())
	{
		return 0;
	}
	if(isdefined(entity.ai.isturning) && entity.ai.isturning)
	{
		return 0;
	}
	if(!function_71790b86(entity))
	{
		return 0;
	}
	disttoenemysq = distancesquared(entity.favoriteenemy.origin, entity.origin);
	if(disttoenemysq <= 850 * 850)
	{
		return 0;
	}
	if(function_e5afc75c(entity))
	{
		return 0;
	}
	return 1;
}

#namespace namespace_a504b9a3;

/*
	Name: __constructor
	Namespace: namespace_a504b9a3
	Checksum: 0xD63FC1A1
	Offset: 0x7D48
	Size: 0x32
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_9ab05afa = 0;
	self.var_6392c3a2 = 0;
	self.var_190509f3 = 0;
	self.var_9177748f = gettime();
}

/*
	Name: __destructor
	Namespace: namespace_a504b9a3
	Checksum: 0x80F724D1
	Offset: 0x7D88
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace namespace_d2f65e05;

/*
	Name: function_a504b9a3
	Namespace: namespace_d2f65e05
	Checksum: 0xFBF5E57A
	Offset: 0x7D98
	Size: 0x86
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_a504b9a3()
{
	classes.var_a504b9a3[0] = spawnstruct();
	classes.var_a504b9a3[0].__vtable[913321084] = &namespace_a504b9a3::__destructor;
	classes.var_a504b9a3[0].__vtable[674154906] = &namespace_a504b9a3::__constructor;
}

/*
	Name: function_10a75bb7
	Namespace: namespace_d2f65e05
	Checksum: 0x588C839B
	Offset: 0x7E28
	Size: 0x9C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_10a75bb7(entity)
{
	if(function_2ff17378(entity))
	{
		targetpos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, entity getpathfindingradius() * 1.2);
		if(isdefined(targetpos))
		{
			entity setgoal(targetpos);
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_f2c697c7
	Namespace: namespace_d2f65e05
	Checksum: 0x9F91F118
	Offset: 0x7ED0
	Size: 0x2D6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f2c697c7(entity)
{
	object = new var_a504b9a3();
	[[ object ]]->__constructor();
	entity.ai.var_a504b9a3 = object;
	entity.ai.var_a504b9a3.var_86d0fc5 = entity.goalpos;
	entity.ai.var_a504b9a3.var_9ab05afa = distancesquared(entity.origin, entity.goalpos);
	entity.ai.var_a504b9a3.startpos = entity.origin;
	stage = entity.ai.var_112ec817;
	if(isdefined(entity.ai.riders))
	{
		foreach(rider in entity.ai.riders)
		{
			if(isdefined(rider))
			{
				rider.ai.ducking = 1;
			}
		}
	}
	switch(stage)
	{
		case "hash_8e173ae91589439":
		{
			entity.ai.var_a504b9a3.var_6392c3a2 = gettime() + randomintrange(2500, 3000);
			entity.ai.var_a504b9a3.var_190509f3 = 250 * 250;
			entity.ai.var_a504b9a3.var_f84fafb2 = 400 * 400;
			break;
		}
		case "hash_8e170ae91588f20":
		{
			entity.ai.var_a504b9a3.var_6392c3a2 = gettime() + randomintrange(3500, 4000);
			entity.ai.var_a504b9a3.var_190509f3 = 250 * 250;
			entity.ai.var_a504b9a3.var_f84fafb2 = 400 * 400;
			break;
		}
		default:
		{
			break;
		}
	}
	return 1;
}

/*
	Name: function_f8145b00
	Namespace: namespace_d2f65e05
	Checksum: 0x44664E14
	Offset: 0x81B0
	Size: 0x5D2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_f8145b00(entity)
{
	if(isdefined(entity.favoriteenemy) && isalive(entity.favoriteenemy))
	{
		/#
			assert(isdefined(entity.ai.var_a504b9a3));
		#/
		/#
			assert(isdefined(entity.ai.var_a504b9a3.var_86d0fc5));
		#/
		/#
			assert(isdefined(entity.ai.var_a504b9a3.var_6392c3a2));
		#/
		/#
			recordsphere(entity.ai.var_a504b9a3.var_86d0fc5, 8, (1, 0, 0), "");
		#/
		if(entity asmistransitionrunning() || entity asmistransdecrunning())
		{
			return 1;
		}
		if(gettime() < entity.ai.var_a504b9a3.var_9177748f)
		{
			return 1;
		}
		if(gettime() <= entity.ai.var_a504b9a3.var_6392c3a2)
		{
			var_ba63d54d = distancesquared(entity.ai.var_a504b9a3.var_86d0fc5, entity.favoriteenemy.origin);
			var_3a73a0ae = distancesquared(entity.ai.var_a504b9a3.startpos, entity.favoriteenemy.origin) > entity.ai.var_a504b9a3.var_9ab05afa;
			threshold = entity.ai.var_a504b9a3.var_190509f3;
			if(var_3a73a0ae)
			{
				threshold = entity.ai.var_a504b9a3.var_f84fafb2;
			}
			if(var_ba63d54d <= threshold && sighttracepassed(entity.origin + vectorscale((0, 0, 1), 200), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 100), 0, entity, entity.favoriteenemy))
			{
				/#
					recordline(entity.origin + vectorscale((0, 0, 1), 200), entity.favoriteenemy.origin + vectorscale((0, 0, 1), 200), (0, 1, 0), "");
				#/
				targetpos = getclosestpointonnavmesh(entity.favoriteenemy.origin, 400, entity getpathfindingradius() * 1.2);
				if(isdefined(targetpos))
				{
					/#
						recordsphere(targetpos, 8, (0, 1, 1), "");
					#/
					dirtoenemy = vectornormalize(targetpos - self.origin);
					targetpos = targetpos + vectorscale(dirtoenemy * -1, 170);
					targetpos = getclosestpointonnavmesh(targetpos, 400, entity getpathfindingradius() * 1.2);
					if(isdefined(targetpos))
					{
						path = generatenavmeshpath(self.origin, targetpos, self);
						if(!isdefined(path) || !isdefined(path.pathpoints) || path.pathpoints.size == 0)
						{
							/#
								recordsphere(targetpos, 8, vectorscale((1, 1, 1), 0.1), "");
							#/
						}
						else
						{
							entity setgoal(targetpos);
							/#
								recordsphere(targetpos, 8, (0, 0, 1), "");
							#/
							/#
								recordline(entity.ai.var_a504b9a3.var_86d0fc5, targetpos, (1, 0, 0), "");
							#/
						}
					}
					recordsphere(targetpos, 8, vectorscale((1, 1, 1), 0.1), "");
				}
			}
		}
	}
	entity.ai.var_a504b9a3.var_9177748f = gettime() + 200;
	return 1;
}

/*
	Name: function_d3d560e9
	Namespace: namespace_d2f65e05
	Checksum: 0xB446D44C
	Offset: 0x8790
	Size: 0x1AE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d3d560e9(entity)
{
	entity aiutility::cleararrivalpos(entity);
	entity.ai.var_a504b9a3 = undefined;
	stage = entity.ai.var_112ec817;
	if(isdefined(entity.ai.riders))
	{
		foreach(rider in entity.ai.riders)
		{
			if(isdefined(rider))
			{
				rider.ai.var_34106895 = 1;
			}
		}
	}
	switch(stage)
	{
		case "hash_8e173ae91589439":
		{
			entity.ai.var_5c1cc6e9 = gettime() + randomintrange(8000, 10000);
			break;
		}
		case "hash_8e170ae91588f20":
		{
			entity.ai.var_5c1cc6e9 = gettime() + randomintrange(6500, 7500);
			break;
		}
		default:
		{
			break;
		}
	}
	return 1;
}

/*
	Name: is_player_valid
	Namespace: namespace_d2f65e05
	Checksum: 0xBB0610C0
	Offset: 0x8948
	Size: 0x190
	Parameters: 3
	Flags: Linked
*/
function is_player_valid(player, checkignoremeflag, ignore_laststand_players)
{
	if(!isdefined(player))
	{
		return 0;
	}
	if(!isalive(player))
	{
		return 0;
	}
	if(!isplayer(player))
	{
		return 0;
	}
	if(player isnotarget())
	{
		return 0;
	}
	if(isdefined(player.is_zombie) && player.is_zombie == 1)
	{
		return 0;
	}
	if(player.sessionstate == "spectator")
	{
		return 0;
	}
	if(player.sessionstate == "intermission")
	{
		return 0;
	}
	if(isdefined(player.intermission) && player.intermission)
	{
		return 0;
	}
	if(!(isdefined(ignore_laststand_players) && ignore_laststand_players))
	{
		if(player laststand::player_is_in_laststand())
		{
			return 0;
		}
	}
	if(player isnotarget())
	{
		return 0;
	}
	if(isdefined(checkignoremeflag) && checkignoremeflag && player.ignoreme)
	{
		return 0;
	}
	if(isdefined(level.is_player_valid_override))
	{
		return [[level.is_player_valid_override]](player);
	}
	return 1;
}

/*
	Name: function_ab5aea01
	Namespace: namespace_d2f65e05
	Checksum: 0xD3B3F1B4
	Offset: 0x8AE0
	Size: 0x166
	Parameters: 1
	Flags: Linked, Private
*/
private function function_ab5aea01(entity)
{
	if(isdefined(entity.ai.var_a504b9a3))
	{
		return 0;
	}
	targets = getplayers();
	for(i = 0; i < targets.size; i++)
	{
		target = targets[i];
		if(!is_player_valid(target, 1, 1) || !function_71790b86(entity))
		{
			arrayremovevalue(targets, target);
			break;
		}
	}
	if(targets.size == 0)
	{
		return 0;
	}
	sortedtargets = arraysort(targets, entity.origin, 0);
	entity.favoriteenemy = sortedtargets[0];
	sortedtargets = arraysortclosest(targets, entity.origin);
	entity.closestenemy = sortedtargets[0];
	return 1;
}

/*
	Name: function_2c58bc39
	Namespace: namespace_d2f65e05
	Checksum: 0xD93CFD5B
	Offset: 0x8C50
	Size: 0xAA
	Parameters: 1
	Flags: Linked, Private
*/
private function function_2c58bc39(entity)
{
	if(isdefined(entity.ignoreall) && entity.ignoreall)
	{
		return 0;
	}
	stage = self.ai.var_112ec817;
	switch(stage)
	{
		case "hash_8e170ae91588f20":
		case "hash_8e173ae91589439":
		{
			function_ab5aea01(entity);
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_5e17ac7a
	Namespace: namespace_d2f65e05
	Checksum: 0x11D1D49C
	Offset: 0x8D08
	Size: 0xA4
	Parameters: 5
	Flags: Linked, Private
*/
private function function_5e17ac7a(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity animmode("zonly_physics", 1);
	entity pathmode("dont move");
	entity clearpath();
	entity setgoal(entity.origin);
}

/*
	Name: function_e88518a1
	Namespace: namespace_d2f65e05
	Checksum: 0x65AD9A6F
	Offset: 0x8DB8
	Size: 0x2C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_e88518a1(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
}

/*
	Name: function_10296bfa
	Namespace: namespace_d2f65e05
	Checksum: 0x24420A49
	Offset: 0x8DF0
	Size: 0x6C
	Parameters: 5
	Flags: Linked, Private
*/
private function function_10296bfa(entity, mocompanim, mocompanimblendouttime, mocompanimflag, mocompduration)
{
	entity pathmode("move allowed");
	entity setgoal(entity.origin);
}

/*
	Name: function_707d0196
	Namespace: namespace_d2f65e05
	Checksum: 0x8CD84AB8
	Offset: 0x8E68
	Size: 0x20
	Parameters: 3
	Flags: Linked, Private
*/
private function function_707d0196(player, mod, shitloc)
{
	return 1;
}

/*
	Name: function_6c8289fe
	Namespace: namespace_d2f65e05
	Checksum: 0x3F13A92E
	Offset: 0x8E90
	Size: 0x178
	Parameters: 0
	Flags: None
*/
function function_6c8289fe()
{
	/#
		var_2d71c66f = getaiarchetypearray(#"elephant");
		foreach(elephant in var_2d71c66f)
		{
			if(isdefined(elephant.ai.riders))
			{
				foreach(rider in elephant.ai.riders)
				{
					if(isdefined(rider))
					{
						aiutility::removeaioverridedamagecallback(rider, &function_ee23b15d);
						rider delete();
					}
				}
			}
			level thread function_42b6d3a3(elephant);
		}
	#/
}

/*
	Name: function_963dfa11
	Namespace: namespace_d2f65e05
	Checksum: 0xE9F61C53
	Offset: 0x9010
	Size: 0x1FC
	Parameters: 1
	Flags: None
*/
function function_963dfa11(phase)
{
	/#
		player = level.players[0];
		direction = player getplayerangles();
		direction_vec = anglestoforward(direction);
		eye = player geteye();
		direction_vec = (direction_vec[0] * 8000, direction_vec[1] * 8000, direction_vec[2] * 8000);
		trace = bullettrace(eye, eye + direction_vec, 0, undefined);
		elephant = undefined;
		var_947e61ac = getspawnerarray("", "");
		if(var_947e61ac.size == 0)
		{
			iprintln("");
			return;
		}
		var_5def4a4b = array::random(var_947e61ac);
		elephant = zombie_utility::spawn_zombie(var_5def4a4b, undefined, var_5def4a4b);
		elephant.ai.phase = phase;
		if(isdefined(elephant))
		{
			wait(0.5);
			elephant forceteleport(trace[#"position"], player.angles + vectorscale((0, 1, 0), 180));
		}
	#/
}

/*
	Name: setup_devgui
	Namespace: namespace_d2f65e05
	Checksum: 0x5860953B
	Offset: 0x9218
	Size: 0xDAE
	Parameters: 0
	Flags: None
*/
function setup_devgui()
{
	/#
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		adddebugcommand("");
		while(true)
		{
			setdvar(#"hash_7a7fc216709f1aa4", "");
			wait(0.2);
			cmd = getdvarstring(#"hash_7a7fc216709f1aa4", "");
			if(cmd == "")
			{
				continue;
			}
			switch(cmd)
			{
				case "hash_3627a6cedc1f6dcb":
				{
					level thread function_963dfa11(#"hash_266f53fb994e6120");
					break;
				}
				case "hash_3627a7cedc1f6f7e":
				{
					level.var_a52a5487 = 1;
					level thread function_963dfa11(#"hash_266f56fb994e6639");
					break;
				}
				case "kill":
				{
					function_6c8289fe();
					break;
				}
				case "hash_6506d07f4110536c":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						stage = elephant.ai.var_112ec817;
						if(stage == #"hash_8e173ae91589439")
						{
							elephant function_4d479d22(elephant);
						}
					}
					break;
				}
				case "hash_490a8c840885559":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.ai.var_ea8d826a = 0;
					}
					break;
				}
				case "hash_3c1047155c4a19f2":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.ai.var_ea8d826a = 1;
					}
					break;
				}
				case "hash_483923806d45ea02":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant hidepart("");
					}
					break;
				}
				case "hash_2ef1eb1ceb31c08f":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant showpart("");
					}
					break;
				}
				case "hide_head":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant hidepart("");
					}
					break;
				}
				case "show_head":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant showpart("");
					}
					break;
				}
				case "hash_6f54f417f7b5ac51":
				{
					level flag::set(#"hash_37071af70fe7a9f2");
					setdvar(#"hash_3065419bcba97739", 1);
					break;
				}
				case "hash_484a268dfc6c97aa":
				{
					setdvar(#"zombie_default_max", 0);
					setdvar(#"hash_2b64162aa40fe2bb", 1);
					level flag::set(#"hash_37071af70fe7a9f2");
					setdvar(#"hash_3065419bcba97739", 1);
					break;
				}
				case "hash_1b7f90925f6498e3":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_e15d8b1f = 2;
					}
					break;
				}
				case "hash_503e90ea2aaf5f30":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_e15d8b1f = 1;
					}
					break;
				}
				case "hash_5e18a71c0cbda56a":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_e15d8b1f = 3;
					}
					break;
				}
				case "hash_28ef2ead2bec713f":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_fe41477d = 1;
						elephant.var_b554dbf2 = 0;
						elephant.ai.var_ea8d826a = 1;
					}
					break;
				}
				case "hash_618d48cfd9850a9a":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_fe41477d = 0;
						elephant.var_b554dbf2 = 0;
						elephant.ai.var_ea8d826a = 0;
					}
					break;
				}
				case "hash_3659cf300f60df4b":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_b554dbf2 = 1;
						elephant.var_fe41477d = 0;
						elephant.ai.var_ea8d826a = 1;
					}
					break;
				}
				case "hash_69cb3828846de716":
				{
					var_2d71c66f = getaiarchetypearray(#"elephant");
					foreach(elephant in var_2d71c66f)
					{
						elephant.var_b554dbf2 = 0;
						elephant.var_fe41477d = 0;
						elephant.ai.var_ea8d826a = 0;
					}
					break;
				}
				default:
				{
					break;
				}
			}
		}
	#/
}

