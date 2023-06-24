// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\player\player_damage.gsc;
#using scripts\core_common\ai\archetype_mocomps_utility.gsc;
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_41fe08c37d53a635;
#using script_489b835a247c990e;
#using script_4bf952f6ba31bb17;
#using script_4d85e8de54b02198;
#using script_522aeb6ae906391e;
#using scripts\core_common\ai\zombie_death.gsc;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using script_59f07c660e6710a5;
#using scripts\wz_common\wz_ai_utils.gsc;
#using scripts\core_common\ai\archetype_utility.gsc;
#using script_71dfbfdfba4489a0;
#using scripts\wz_common\wz_ai_zombie.gsc;
#using script_7b7ed6e4bc963a51;
#using scripts\core_common\ai\zombie.gsc;
#using script_caf007e2a98afa2;
#using scripts\core_common\aat_shared.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\infection.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace wz_ai_brutus;

/*
	Name: __init__system__
	Namespace: wz_ai_brutus
	Checksum: 0x236A5EBC
	Offset: 0x370
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_ai_brutus", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: wz_ai_brutus
	Checksum: 0xA9F0A957
	Offset: 0x3C0
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	registerbehaviorscriptfunctions();
	spawner::add_archetype_spawn_function(#"brutus", &function_debbd9da);
	spawner::function_89a2cd87(#"brutus", &function_6090f71a);
	clientfield::register("actor", "brutus_shock_attack", 15000, 1, "counter");
	clientfield::register("actor", "brutus_spawn_clientfield", 15000, 1, "int");
	clientfield::register("toplayer", "brutus_shock_attack_player", 15000, 1, "counter");
	callback::on_actor_killed(&function_fc5aa54d);
}

/*
	Name: __main__
	Namespace: wz_ai_brutus
	Checksum: 0x80F724D1
	Offset: 0x4F0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_517fd069
	Namespace: wz_ai_brutus
	Checksum: 0x29963147
	Offset: 0x500
	Size: 0x62
	Parameters: 0
	Flags: Linked, Private
*/
function private function_517fd069()
{
	blackboard::createblackboardforentity(self);
	ai::createinterfaceforentity(self);
	self.___archetypeonanimscriptedcallback = &function_666b2409;
	self.___archetypeonbehavecallback = &function_3cdbfffd;
}

/*
	Name: function_3cdbfffd
	Namespace: wz_ai_brutus
	Checksum: 0xE100268A
	Offset: 0x570
	Size: 0xC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3cdbfffd(entity)
{
}

/*
	Name: function_666b2409
	Namespace: wz_ai_brutus
	Checksum: 0x44D175CC
	Offset: 0x588
	Size: 0x2C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_666b2409(entity)
{
	self.__blackboard = undefined;
	self function_517fd069();
}

/*
	Name: function_debbd9da
	Namespace: wz_ai_brutus
	Checksum: 0x1CDE46C6
	Offset: 0x5C0
	Size: 0x27E
	Parameters: 0
	Flags: Linked
*/
function function_debbd9da()
{
	self function_517fd069();
	self wz_ai_utils::function_9758722("walk");
	aiutility::addaioverridedamagecallback(self, &function_83a6d3ae);
	self callback::function_d8abfc3d(#"hash_11aa32ad6d527054", &wz_ai_zombie::function_b8eb5dea);
	self callback::function_d8abfc3d(#"on_ai_killed", &function_fc5aa54d);
	self callback::function_d8abfc3d(#"hash_4e449871617e2c25", &function_6a482c74);
	self callback::function_d8abfc3d(#"hash_3bb51ce51020d0eb", &wz_ai_utils::function_16e2f075);
	self function_bad305c7();
	self.var_65e57a10 = 1;
	self.health = 6000;
	self.hashelmet = 1;
	self.helmethits = 0;
	self.var_96b5e3f1 = 0;
	self.var_71ab4927 = 0;
	self.var_905e4ce2 = self ai::function_9139c839().var_267bc182;
	self.meleedamage = 150;
	self.var_f46fbf3f = 1;
	self.var_e38eaee5 = 0;
	self.var_a0193213 = 500;
	self.var_12ec333b = 1;
	self.var_6501ffdf = 1;
	self.var_737e8510 = 96;
	self thread wz_ai_zombie::function_6c308e81();
	self setavoidancemask("avoid none");
	self.cant_move_cb = &wz_ai_zombie::function_9c573bc6;
	self.ignorepathenemyfightdist = 1;
	self.var_31a789c0 = 1;
	self.var_872e52b0 = &wz_ai_zombie::function_833ce8c8;
	self.var_721a3dbd = 1;
}

/*
	Name: function_6a482c74
	Namespace: wz_ai_brutus
	Checksum: 0xBDDB3034
	Offset: 0x848
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_6a482c74(params)
{
	switch(params.state)
	{
		case 3:
		{
			self wz_ai_utils::function_9758722("run");
			break;
		}
		default:
		{
			break;
		}
	}
}

/*
	Name: function_bad305c7
	Namespace: wz_ai_brutus
	Checksum: 0x5D1B1ED
	Offset: 0x8C0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_bad305c7()
{
	self.var_2cee3556 = [];
	self.var_2cee3556[#"hash_4699e07e76afa302"] = 15;
}

/*
	Name: function_6090f71a
	Namespace: wz_ai_brutus
	Checksum: 0x540C7477
	Offset: 0x8F8
	Size: 0x19A
	Parameters: 0
	Flags: Linked
*/
function function_6090f71a()
{
	self.explosive_dmg_req = 50;
	if(!getdvarint(#"survival_prototype", 0))
	{
		self thread wz_ai_zombie::function_e261b81d();
	}
	else
	{
		self callback::function_d8abfc3d(#"hash_10ab46b52df7967a", &wz_ai_zombie::function_bb3c1175);
		self wz_ai_zombie::function_b670d610();
	}
	self clientfield::set("brutus_spawn_clientfield", 1);
	var_7dd9d338 = "c_t8_zmb_mob_brutus_baton";
	if(self.var_9fde8624 === #"brutus_special")
	{
		var_7dd9d338 = "c_t8_zmb_mob_brutus_boss_baton";
	}
	self attach(var_7dd9d338, "tag_weapon_right");
	if(isdefined(self.ai_zone))
	{
		node = getnode(self.ai_zone.zone_name + "_patrol", "targetname");
		if(isdefined(node))
		{
			self.patrol_path = wz_ai_utils::function_35eac38d(node);
			self.var_5d58d4c0 = &function_b510a832;
		}
	}
}

/*
	Name: function_ea3e1b6c
	Namespace: wz_ai_brutus
	Checksum: 0xFB848AC7
	Offset: 0xAA0
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function function_ea3e1b6c(entity)
{
	entity.fovcosine = 0.5;
	entity.maxsightdistsqrd = 900 * 900;
}

/*
	Name: function_fc5aa54d
	Namespace: wz_ai_brutus
	Checksum: 0x582B366
	Offset: 0xAE0
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_fc5aa54d(params)
{
	self clientfield::set("brutus_spawn_clientfield", 0);
	playsoundatposition(#"zmb_ai_brutus_death", self.origin);
	self destructserverutils::togglespawngibs(self, 1);
	self destructserverutils::function_629a8d54(self, "tag_weapon_right");
}

/*
	Name: registerbehaviorscriptfunctions
	Namespace: wz_ai_brutus
	Checksum: 0xEA2F83EF
	Offset: 0xB78
	Size: 0x36C
	Parameters: 0
	Flags: Linked, Private
*/
function private registerbehaviorscriptfunctions()
{
	/#
		assert(isscriptfunctionptr(&function_3006441d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_df1d28cebbb75f6", &function_3006441d);
	/#
		assert(isscriptfunctionptr(&function_3bda3c55));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_d8653062b32a601", &function_3bda3c55);
	/#
		assert(isscriptfunctionptr(&function_4ec678fe));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_643443bf9243e4ff", &function_4ec678fe);
	/#
		assert(isscriptfunctionptr(&function_f4a61e6a));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5800441474109ca6", &function_f4a61e6a);
	/#
		assert(isscriptfunctionptr(&function_5ca455a0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_31bfd48e9c8557f0", &function_5ca455a0);
	/#
		assert(isscriptfunctionptr(&function_d996f07c));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4fe62c9a1dbe75d3", &function_d996f07c);
	/#
		assert(isscriptfunctionptr(&function_e2ab1df7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_14196abc66fc78ee", &function_e2ab1df7);
	/#
		assert(isscriptfunctionptr(&function_1bd1ebe7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6df8ee94ab700109", &function_1bd1ebe7);
	animationstatenetwork::registernotetrackhandlerfunction("hit_ground", &function_85e8940a);
}

/*
	Name: function_5ca455a0
	Namespace: wz_ai_brutus
	Checksum: 0x5236A16D
	Offset: 0xEF0
	Size: 0x56
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5ca455a0(entity)
{
	entity val::set(#"brutus_cleanup", "blockingpain", 1);
	entity.var_8a96267d = undefined;
	entity.var_bc0e449a = 1;
}

/*
	Name: function_d996f07c
	Namespace: wz_ai_brutus
	Checksum: 0x7D9A753
	Offset: 0xF50
	Size: 0x2A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d996f07c(entity)
{
	entity notify(#"is_underground");
	entity.var_bc0e449a = undefined;
}

/*
	Name: function_9d76e96c
	Namespace: wz_ai_brutus
	Checksum: 0x6809116D
	Offset: 0xF88
	Size: 0xE4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9d76e96c(entity)
{
	entity val::set(#"brutus_cleanup", "allowoffnavmesh", 0);
	entity val::reset(#"brutus_cleanup", "blockingpain");
	entity ghost();
	entity notsolid();
	entity pathmode("dont move", 1);
	entity function_d4c687c9();
	entity clientfield::set("brutus_spawn_clientfield", 0);
}

/*
	Name: function_e2ab1df7
	Namespace: wz_ai_brutus
	Checksum: 0x6A07FCEE
	Offset: 0x1078
	Size: 0x2E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_e2ab1df7(entity)
{
	entity solid();
	entity.var_8ba6ede3 = undefined;
}

/*
	Name: function_1bd1ebe7
	Namespace: wz_ai_brutus
	Checksum: 0xA12A3B72
	Offset: 0x10B0
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1bd1ebe7(entity)
{
	entity val::reset(#"brutus_cleanup", "allowoffnavmesh");
	entity show();
	entity clientfield::set("brutus_spawn_clientfield", 1);
	entity pathmode("move allowed");
	entity notify(#"not_underground");
}

/*
	Name: function_3006441d
	Namespace: wz_ai_brutus
	Checksum: 0x68AAED6D
	Offset: 0x1158
	Size: 0x74
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3006441d(entity)
{
	if(!isdefined(entity.var_722a34a3) || !isdefined(entity.var_52e3b294) || distancesquared(entity.var_52e3b294, entity.origin) > (10 * 10))
	{
		return false;
	}
	return true;
}

/*
	Name: function_4ec678fe
	Namespace: wz_ai_brutus
	Checksum: 0xACF41E31
	Offset: 0x11D8
	Size: 0xD4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4ec678fe(entity)
{
	if(!isdefined(entity.var_722a34a3))
	{
		return;
	}
	monkeybomb = entity.var_722a34a3;
	level notify(#"hash_79c0225ea09cd215", {#hash_569d804d:monkeybomb.angles, #hash_cee6bd0b:monkeybomb.origin, #brutus:self});
	if(isdefined(monkeybomb.damagearea))
	{
		monkeybomb.damagearea delete();
	}
	monkeybomb delete();
}

/*
	Name: function_3bda3c55
	Namespace: wz_ai_brutus
	Checksum: 0xA110C3FA
	Offset: 0x12B8
	Size: 0x140
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3bda3c55(entity)
{
	if(entity.var_96b5e3f1 > gettime())
	{
		return false;
	}
	if(!isdefined(entity.favoriteenemy))
	{
		return false;
	}
	if(!wz_ai_utils::is_player_valid(entity.favoriteenemy))
	{
		return false;
	}
	if(abs(entity.origin[2] - entity.favoriteenemy.origin[2]) > 72)
	{
		return false;
	}
	if(distance2dsquared(entity.origin, entity.favoriteenemy.origin) > entity ai::function_9139c839().var_b4c77cfb * entity ai::function_9139c839().var_b4c77cfb)
	{
		return false;
	}
	if(lengthsquared(entity.favoriteenemy getvelocity()) > 90 * 90)
	{
		return false;
	}
	return true;
}

/*
	Name: function_f4a61e6a
	Namespace: wz_ai_brutus
	Checksum: 0xE2CCF279
	Offset: 0x1400
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f4a61e6a(entity)
{
	entity.var_96b5e3f1 = gettime() + (int(entity ai::function_9139c839().var_d5427206 * 1000));
}

/*
	Name: function_85e8940a
	Namespace: wz_ai_brutus
	Checksum: 0xE25210FB
	Offset: 0x1458
	Size: 0x358
	Parameters: 1
	Flags: Linked, Private
*/
function private function_85e8940a(entity)
{
	if(isdefined(entity.var_bc0e449a) && entity.var_bc0e449a)
	{
		function_9d76e96c(entity);
		return;
	}
	var_aa6baab8 = entity ai::function_9139c839().var_1709a39;
	players = getplayers(#"all", entity.origin, var_aa6baab8);
	shock_status_effect = getstatuseffect(#"hash_19533caf858a9f3b");
	entity clientfield::increment("brutus_shock_attack", 1);
	foreach(player in players)
	{
		if(!wz_ai_utils::is_player_valid(player))
		{
			continue;
		}
		if(player.origin[2] - entity.origin[2] < -32)
		{
			continue;
		}
		if(player.origin[2] - entity.origin[2] > 200)
		{
			continue;
		}
		if(!bullettracepassed(entity.origin, player gettagorigin("j_spine4"), 0, entity, player))
		{
			continue;
		}
		damage = mapfloat(entity getpathfindingradius() + 15, entity ai::function_9139c839().var_1709a39, entity ai::function_9139c839().var_7ea758e1, 0, distance(entity.origin, player.origin));
		damage = int(max(10, damage));
		player dodamage(damage, entity.origin, entity, entity, "none", "MOD_PROJECTILE_SPLASH");
		player status_effect::status_effect_apply(shock_status_effect, undefined, self, 0);
		player clientfield::increment_to_player("brutus_shock_attack_player", 1);
	}
}

/*
	Name: function_97f51aa3
	Namespace: wz_ai_brutus
	Checksum: 0xAB84CB7F
	Offset: 0x17B8
	Size: 0x62
	Parameters: 1
	Flags: Private
*/
function private function_97f51aa3(v_org)
{
	grenade = self magicgrenadetype(getweapon(#"willy_pete"), v_org, (0, 0, 0), 0.4);
	grenade.owner = self;
}

/*
	Name: function_530c54e3
	Namespace: wz_ai_brutus
	Checksum: 0xCA1111DC
	Offset: 0x1828
	Size: 0x66
	Parameters: 0
	Flags: Linked
*/
function function_530c54e3()
{
	self.hashelmet = 0;
	destructserverutils::function_9885f550(self, "helmet");
	self playsound(#"evt_brutus_helmet");
}

/*
	Name: function_55bb9c72
	Namespace: wz_ai_brutus
	Checksum: 0x17DA0B99
	Offset: 0x1898
	Size: 0x96
	Parameters: 5
	Flags: Linked, Private
*/
function private function_55bb9c72(attacker, damage, weapon, var_81dcad68, damagemultiplier)
{
	if(!(isdefined(self.hashelmet) && self.hashelmet))
	{
		return damage * var_81dcad68;
	}
	self.helmethits++;
	if(self.helmethits >= self.var_905e4ce2)
	{
		self function_530c54e3();
	}
	return damage * damagemultiplier;
}

/*
	Name: function_83a6d3ae
	Namespace: wz_ai_brutus
	Checksum: 0xDA48C67A
	Offset: 0x1938
	Size: 0x45C
	Parameters: 11
	Flags: Linked, Private
*/
function private function_83a6d3ae(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, poffsettime, boneindex)
{
	var_9000ab2 = (isdefined(level.brutus_damage_percent) ? level.brutus_damage_percent : 0.5);
	var_81dcad68 = 1.5;
	if(isplayer(attacker) && attacker infection::is_infected())
	{
		return 0;
	}
	if(self.var_71ab4927 > gettime())
	{
		if(isplayer(attacker))
		{
			attacker util::show_hit_marker();
		}
		return 0;
	}
	self player::function_74a5d514(attacker, damage, meansofdeath, weapon, shitloc);
	if(isdefined(weapon) && meansofdeath !== "MOD_DOT")
	{
		var_9a429025 = function_f74d2943(weapon, 7);
		if(isdefined(var_9a429025))
		{
			status_effect::status_effect_apply(var_9a429025, weapon, inflictor);
		}
	}
	if(isdefined(inflictor) && !isdefined(self.attackable) && isdefined(inflictor.var_b79a8ac7) && isarray(inflictor.var_b79a8ac7.slots) && isarray(level.var_7fc48a1a) && isinarray(level.var_7fc48a1a, weapon))
	{
		if(inflictor wz_ai_utils::get_attackable_slot(self))
		{
			self.attackable = inflictor;
		}
	}
	if(isdefined(weapon) && weapon.weapclass == "spread")
	{
		var_9000ab2 = var_9000ab2 * 1.2;
		var_81dcad68 = var_81dcad68 * 1.2;
	}
	final_damage = 0;
	if(isdefined(meansofdeath) && (meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE"))
	{
		if(!isdefined(self.explosivedmgtaken))
		{
			self.explosivedmgtaken = 0;
		}
		self.explosivedmgtaken = self.explosivedmgtaken + damage;
		scaler = var_9000ab2;
		if(self.explosivedmgtaken >= self.explosive_dmg_req && (isdefined(self.hashelmet) && self.hashelmet))
		{
			self function_530c54e3();
		}
		final_damage = damage * scaler;
	}
	else
	{
		if(shitloc !== "head" && shitloc !== "helmet")
		{
			final_damage = damage * var_9000ab2;
		}
		else
		{
			final_damage = int(self function_55bb9c72(attacker, damage, weapon, var_81dcad68, var_9000ab2));
		}
	}
	/#
		if(isdefined(level.var_85a39c96) && level.var_85a39c96)
		{
			final_damage = self.health + 1;
		}
	#/
	return final_damage;
}

/*
	Name: getclosestnode
	Namespace: wz_ai_brutus
	Checksum: 0x16118778
	Offset: 0x1DA0
	Size: 0x1DA
	Parameters: 2
	Flags: Linked, Private
*/
function private getclosestnode(entity, nodes)
{
	if(nodes.size > 16)
	{
		var_f122ea68 = arraysortclosest(nodes, entity.origin, 16);
	}
	else
	{
		var_f122ea68 = nodes;
	}
	origins = [];
	foreach(node in var_f122ea68)
	{
		if(!isdefined(origins))
		{
			origins = [];
		}
		else if(!isarray(origins))
		{
			origins = array(origins);
		}
		origins[origins.size] = node.origin;
	}
	pathdata = generatenavmeshpath(entity.origin, origins, entity);
	if(isdefined(pathdata) && pathdata.status === "succeeded")
	{
		goalpos = pathdata.pathpoints[pathdata.pathpoints.size - 1];
		return arraygetclosest(goalpos, var_f122ea68);
	}
	return arraygetclosest(entity.origin, var_f122ea68);
}

/*
	Name: function_b510a832
	Namespace: wz_ai_brutus
	Checksum: 0xE2246578
	Offset: 0x1F88
	Size: 0x282
	Parameters: 0
	Flags: Linked
*/
function function_b510a832()
{
	level endon(#"game_ended");
	self endon(#"death", #"state_changed");
	start_node = getclosestnode(self, self.patrol_path.path);
	start_index = 0;
	foreach(index, node in self.patrol_path.path)
	{
		if(node == start_node)
		{
			start_index = index;
			break;
		}
	}
	while(true)
	{
		for(i = 0; i < self.patrol_path.path.size; i++)
		{
			var_cf88d3eb = self.patrol_path.path[(start_index + i) % self.patrol_path.path.size];
			next_goal = getclosestpointonnavmesh(var_cf88d3eb.origin, 100, self getpathfindingradius());
			if(!isdefined(next_goal))
			{
				break;
			}
			self.var_80780af2 = next_goal;
			self.var_9a79d89d = next_goal;
			waitresult = undefined;
			waitresult = self waittilltimeout(30, #"goal");
			if(isdefined(self.var_50826790) && self.var_50826790)
			{
				self.var_ef59b90 = 5;
				self.var_50826790 = 0;
			}
			if(waitresult._notify !== "timeout")
			{
				idle_time = randomfloatrange(3, 5);
				wait(idle_time);
			}
		}
	}
}

