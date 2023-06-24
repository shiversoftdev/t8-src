// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3aa0f32b70d4f7cb;
#using scripts\core_common\ai\zombie_utility.gsc;
#using script_4d85e8de54b02198;
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\ai\archetype_nova_crawler.gsc;
#using scripts\zm\ai\zm_ai_nova_crawler.gsc;
#using script_caf007e2a98afa2;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_behavior.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace zm_ai_white_nova_crawler;

/*
	Name: __init__system__
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xEF359061
	Offset: 0x4A0
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_ai_white_nova_crawler", &__init__, &__main__, #"zm_ai_nova_crawler");
}

/*
	Name: __init__
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x25914F6F
	Offset: 0x500
	Size: 0xD72
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_7efe7cea();
	/#
		assert(isscriptfunctionptr(&function_20ff9616));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_7263cdcd4718301", &function_20ff9616);
	/#
		assert(isscriptfunctionptr(&function_8261512d));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1a314f5acde8baa1", &function_8261512d);
	/#
		assert(isscriptfunctionptr(&function_8b694c31));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5fbc8804a8a15bd5", &function_8b694c31);
	/#
		assert(isscriptfunctionptr(&function_48aba0aa));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_383a0954f0b27e24", &function_48aba0aa);
	/#
		assert(isscriptfunctionptr(&function_1ded4b3e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_16995abde3a3d069", &function_1ded4b3e);
	/#
		assert(isscriptfunctionptr(&function_6e16f65f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_45ddcfb4be875c5c", &function_6e16f65f);
	/#
		assert(isscriptfunctionptr(&function_12aaa2f7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6dad997b42434d2b", &function_12aaa2f7);
	/#
		assert(isscriptfunctionptr(&function_f89eddf1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4945b1ee9080ca23", &function_f89eddf1);
	/#
		assert(isscriptfunctionptr(&function_c21c2cf7));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6aa0f71f46cc11e2", &function_c21c2cf7);
	/#
		assert(isscriptfunctionptr(&function_5b7e50b0));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_29ec8f4e038a8fd6", &function_5b7e50b0);
	/#
		assert(isscriptfunctionptr(&function_4c2972f1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_57b68575535e3417", &function_4c2972f1);
	/#
		assert(isscriptfunctionptr(&function_90388f5b));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5a621a5df6ec80c2", &function_90388f5b);
	/#
		assert(isscriptfunctionptr(&function_fc9e257f));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_349daa17bc587fc4", &function_fc9e257f);
	/#
		assert(isscriptfunctionptr(&function_f0eb1b7e));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_5f37165a6a364df0", &function_f0eb1b7e);
	/#
		assert(isscriptfunctionptr(&function_c708afa4));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_39d5538a04bc1a69", &function_c708afa4);
	/#
		assert(isscriptfunctionptr(&function_d7aebbd6));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_760fe53dc320cc37", &function_d7aebbd6);
	/#
		assert(isscriptfunctionptr(&function_80c8bbd3));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_63678c7c76fd4eb9", &function_80c8bbd3, 1);
	/#
		assert(isscriptfunctionptr(&function_677d42d1));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_1eae14f47f78c61e", &function_677d42d1, 1);
	/#
		assert(!isdefined(&function_82777ad1) || isscriptfunctionptr(&function_82777ad1));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_c44757b4) || isscriptfunctionptr(&function_c44757b4));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2d128ce6a4a5097f", &function_82777ad1, undefined, &function_c44757b4);
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	/#
		assert(!isdefined(&function_6b950494) || isscriptfunctionptr(&function_6b950494));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_250e8c7b6d2e0855", undefined, undefined, &function_6b950494);
	/#
		assert(!isdefined(&function_ae4a399b) || isscriptfunctionptr(&function_ae4a399b));
	#/
	/#
		assert(!isdefined(&function_9fcedb9c) || isscriptfunctionptr(&function_9fcedb9c));
	#/
	/#
		assert(!isdefined(undefined) || isscriptfunctionptr(undefined));
	#/
	behaviortreenetworkutility::registerbehaviortreeaction(#"hash_2e4e4b981dde7ba6", &function_ae4a399b, &function_9fcedb9c, undefined);
	animationstatenetwork::registernotetrackhandlerfunction("projectile_attack", &function_270b3dee);
	animationstatenetwork::registernotetrackhandlerfunction("spore_attack", &function_13d38964);
	animationstatenetwork::registernotetrackhandlerfunction("phase_start", &function_3bd2bba5);
	spawner::add_archetype_spawn_function(#"nova_crawler", &function_582a3075);
	/#
		zm_devgui::function_c7dd7a17("", "");
		zm_devgui::function_c7dd7a17("", "");
		zm_devgui::function_c7dd7a17("", "");
		adddebugcommand("");
		adddebugcommand("");
	#/
	clientfield::register("actor", "nova_buff_aura_clientfield", 8000, 1, "int");
	clientfield::register("actor", "white_nova_crawler_phase_end_clientfield", 8000, 1, "counter");
	clientfield::register("actor", "nova_gas_cloud_fx_clientfield", 8000, 1, "counter");
	clientfield::register("actor", "white_nova_crawler_spore_impact_clientfield", 8000, 1, "counter");
	clientfield::register("scriptmover", "white_nova_crawler_spore_clientfield", 8000, 1, "int");
	zm::function_84d343d(#"white_nova_crawler_projectile", &function_51ab2a44);
	zm::register_actor_damage_callback(&function_ac651298);
	level.white_nova_crawler_sniper_locations = struct::get_array("white_nova_crawler_sniper_location", "script_noteworthy");
	level.white_nova_crawler_sniper_escape_locations = struct::get_array("white_nova_crawler_sniper_escape_location", "script_noteworthy");
	level.var_e6cea2c0 = 0;
}

/*
	Name: __main__
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x80F724D1
	Offset: 0x1280
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_7efe7cea
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x178EF84E
	Offset: 0x1290
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_7efe7cea()
{
	level.var_bb3415b1 = [];
	for(i = 0; i < 6; i++)
	{
		spore = spawn("script_model", (0, 0, 0));
		spore setmodel("tag_origin");
		if(!isdefined(level.var_bb3415b1))
		{
			level.var_bb3415b1 = [];
		}
		else if(!isarray(level.var_bb3415b1))
		{
			level.var_bb3415b1 = array(level.var_bb3415b1);
		}
		level.var_bb3415b1[level.var_bb3415b1.size] = spore;
	}
}

/*
	Name: function_582a3075
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x54CFC36D
	Offset: 0x13A0
	Size: 0x184
	Parameters: 0
	Flags: Linked, Private
*/
function private function_582a3075()
{
	self zm_ai_nova_crawler::function_1d34f2b6();
	self.actor_killed_override = &function_b1676105;
	self.var_71841cf9 = -1;
	self.var_2208281f = -1;
	self.var_34b2e48 = 0;
	self.var_c858954a = 1;
	self.var_442eb649 = 0;
	function_ba6a44f();
	function_3df69749();
	function_8eb7fbb7();
	function_349ae23d();
	function_41d1cdd5();
	if(function_2e8ceddd())
	{
		function_605e733f();
	}
	else
	{
		if(function_b06bbbba())
		{
			function_ee3e7dc8();
		}
		else
		{
			self.var_97a22974 = 0;
			self.can_shoot = 0;
			self.var_349e111e = 0;
			self.var_f1f44412 = 1;
			self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_aura";
		}
	}
	/#
		self thread function_536a70c5();
	#/
}

/*
	Name: function_2e8ceddd
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x5180AA99
	Offset: 0x1530
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private function_2e8ceddd()
{
	return isdefined(self.var_9fde8624) && self.var_9fde8624 == #"blue_nova_crawler";
}

/*
	Name: function_b06bbbba
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x61C5E94A
	Offset: 0x1560
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b06bbbba()
{
	return isdefined(self.var_9fde8624) && self.var_9fde8624 == #"ranged_nova_crawler";
}

/*
	Name: function_605e733f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA7FC4141
	Offset: 0x1590
	Size: 0x7E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_605e733f()
{
	self.can_shoot = 1;
	self.var_97a22974 = 0;
	self.var_349e111e = 0;
	self.var_f1f44412 = 0;
	self.b_ignore_cleanup = 1;
	self.ignore_nuke = 1;
	self.ignoreme = 1;
	self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_mq_aura";
}

/*
	Name: function_ee3e7dc8
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x6B97F9C2
	Offset: 0x1618
	Size: 0xC4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ee3e7dc8()
{
	self.can_shoot = 1;
	self.var_b421bafe = 0;
	self.var_97a22974 = 1;
	self.var_349e111e = 0;
	self.var_f1f44412 = 0;
	self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_elec_aura";
	self._effect[#"hash_571a3bab8b805854"] = "zm_ai/fx8_nova_crawler_elec_teleport_flash";
	self._effect[#"nova_crawler_phase_teleport_end_fx"] = "zm_ai/fx8_nova_crawler_elec_teleport_appear";
	self playsound(#"hash_27b6a39054ad63ec");
}

/*
	Name: function_dc0238e4
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x78F322E
	Offset: 0x16E8
	Size: 0x22
	Parameters: 0
	Flags: Linked
*/
function function_dc0238e4()
{
	if(function_b06bbbba())
	{
		self.var_b421bafe = 1;
	}
}

/*
	Name: function_536a70c5
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xC5348675
	Offset: 0x1718
	Size: 0x128
	Parameters: 0
	Flags: Private
*/
function private function_536a70c5()
{
	self endon(#"death");
	while(true)
	{
		waitframe(1);
		/#
			enabled = getdvarint(#"hash_6f365f1cee0a5d80", 0);
			if(enabled)
			{
				centroid = self getcentroid();
				color = (1, 0, 0);
				if(function_561b76c5())
				{
					color = (0, 1, 0);
				}
				if(isdefined(self.favoriteenemy))
				{
					self thread function_e5ffb77c(self.favoriteenemy.origin, self.origin, 0.1);
				}
				sphere(centroid, 10, color, 0.5, 0, 8, 1);
			}
		#/
	}
}

/*
	Name: function_b1676105
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x3B57F971
	Offset: 0x1848
	Size: 0x84
	Parameters: 8
	Flags: Linked, Private
*/
function private function_b1676105(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	function_c33d4387();
	zm_ai_nova_crawler::function_c5b157a6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

/*
	Name: function_e5ffb77c
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xF32C19BD
	Offset: 0x18D8
	Size: 0x10E
	Parameters: 3
	Flags: Private
*/
function private function_e5ffb77c(start, end, duration)
{
	current_time = duration * 20;
	/#
		while(current_time > 0)
		{
			waitframe(1);
			line(start, end, (1, 0, 0), 1, 1);
			sphere(end, 2, (1, 0, 0), 1, 0, 4, 1);
			distance = distance(start, end);
			print3d(end + vectorscale((0, 0, 1), 30), "" + distance, (1, 0, 0), 1, 1, 1);
			current_time = current_time - 1;
		}
	#/
}

/*
	Name: function_debf98ad
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x2BFE8131
	Offset: 0x19F0
	Size: 0x86
	Parameters: 3
	Flags: Private
*/
function private function_debf98ad(location, radius, duration)
{
	current_time = duration * 20;
	/#
		while(current_time > 0)
		{
			waitframe(1);
			sphere(location, radius, (0, 1, 0), 0.1, 0, 8, 1);
			current_time = current_time - 1;
		}
	#/
}

/*
	Name: function_80c8bbd3
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x38C964F9
	Offset: 0x1A80
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_80c8bbd3(entity)
{
	if(entity function_b06bbbba())
	{
		function_f2ce2a46(entity);
	}
	else
	{
		entity zm_behavior::zombiefindflesh(entity);
	}
}

/*
	Name: function_f2ce2a46
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xAD2CE2B6
	Offset: 0x1AE8
	Size: 0x134
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f2ce2a46(entity)
{
	var_5e1a56a9 = 0;
	if(isdefined(entity.favoriteenemy))
	{
		var_5e1a56a9 = distance2d(entity.origin, entity.favoriteenemy.origin);
	}
	var_46503089 = 700 / 2;
	if(var_5e1a56a9 < 200 || var_5e1a56a9 > 500 || (var_5e1a56a9 > var_46503089 && !entity isingoal(entity.origin)) || !entity can_see_enemy() || entity function_68469a59())
	{
		entity zm_behavior::zombiefindflesh(entity);
	}
	else
	{
		entity setgoal(entity.origin);
	}
}

/*
	Name: function_4ee74b24
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x329A61A0
	Offset: 0x1C28
	Size: 0x15A
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4ee74b24()
{
	if(!isdefined(self.var_4ee74b24))
	{
		self.var_4ee74b24 = 0;
	}
	if(!isdefined(self.var_6d5a7a2d))
	{
		self.var_6d5a7a2d = 0;
	}
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
	Name: can_see_enemy
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x1F5BAD95
	Offset: 0x1D90
	Size: 0x8A
	Parameters: 0
	Flags: Linked, Private
*/
function private can_see_enemy()
{
	if(!isdefined(self.can_see_enemy))
	{
		self.can_see_enemy = 0;
	}
	if(!isdefined(self.var_6ed00311))
	{
		self.var_6ed00311 = 0;
	}
	if(isdefined(self.favoriteenemy) && self.var_6ed00311 < gettime())
	{
		self.can_see_enemy = self cansee(self.favoriteenemy);
		self.var_6ed00311 = gettime() + 50;
	}
	return self.can_see_enemy;
}

/*
	Name: function_68469a59
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x50C6C9DF
	Offset: 0x1E28
	Size: 0xA2
	Parameters: 0
	Flags: Linked, Private
*/
function private function_68469a59()
{
	if(!isdefined(self.var_68469a59))
	{
		self.var_68469a59 = 0;
	}
	if(!isdefined(self.var_8127535))
	{
		self.var_8127535 = 0;
	}
	if(self.var_8127535 < gettime())
	{
		zombie_poi = self zm_utility::get_zombie_point_of_interest(self.origin);
		if(isdefined(zombie_poi))
		{
			self.var_68469a59 = 1;
		}
		else
		{
			self.var_68469a59 = 0;
		}
		self.var_8127535 = gettime() + 50;
	}
	return self.var_68469a59;
}

/*
	Name: function_20ff9616
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x1D8CCF48
	Offset: 0x1ED8
	Size: 0x1A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_20ff9616(entity)
{
	return function_68469a59();
}

/*
	Name: function_561b76c5
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA1825A5E
	Offset: 0x1F00
	Size: 0xAA
	Parameters: 0
	Flags: Linked, Private
*/
function private function_561b76c5()
{
	if(!isdefined(self.var_561b76c5))
	{
		self.var_561b76c5 = 0;
	}
	if(!isdefined(self.var_463fafcf))
	{
		self.var_463fafcf = 0;
	}
	if(isdefined(self.favoriteenemy) && isplayer(self.favoriteenemy) && self.var_463fafcf < gettime())
	{
		self.var_561b76c5 = self.favoriteenemy islookingat(self);
		self.var_463fafcf = gettime() + 50;
	}
	return self.var_561b76c5;
}

/*
	Name: function_8ae62d74
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x193893F8
	Offset: 0x1FB8
	Size: 0x254
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8ae62d74(entity)
{
	var_3ac99fac = "NONE";
	navmeshpoint = undefined;
	if(isdefined(self.favoriteenemy))
	{
		var_6fb2b27e = distancesquared(self.origin, self.favoriteenemy.origin);
		if(var_6fb2b27e >= 22500)
		{
			navmeshpoint = getclosestpointonnavmesh(entity.origin, 64, 15);
		}
	}
	if(isdefined(navmeshpoint))
	{
		forward = anglestoforward(entity.angles);
		left = rotatepointaroundaxis(forward, (0, 0, 1), 60);
		right = rotatepointaroundaxis(forward, (0, 0, 1), -60);
		var_f53c23cf = checknavmeshdirection(navmeshpoint, left, 100, 0);
		var_379116fa = checknavmeshdirection(navmeshpoint, right, 100, 0);
		var_cfa253f9 = [];
		var_d3c9cafc = 1;
		if((distance(navmeshpoint, var_f53c23cf) + var_d3c9cafc) >= 100)
		{
			var_cfa253f9[var_cfa253f9.size] = "LEFT";
		}
		if((distance(navmeshpoint, var_379116fa) + var_d3c9cafc) >= 100)
		{
			var_cfa253f9[var_cfa253f9.size] = "RIGHT";
		}
		if(var_cfa253f9.size > 0)
		{
			var_3ac99fac = array::random(var_cfa253f9);
		}
	}
	entity setblackboardattribute("_phase_direction", var_3ac99fac);
}

/*
	Name: function_488ba9cc
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x4D656D0A
	Offset: 0x2218
	Size: 0xC8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_488ba9cc()
{
	result = 0;
	navmeshpoint = getclosestpointonnavmesh(self.origin, 64, 15);
	if(isdefined(navmeshpoint))
	{
		forward = anglestoforward(self.angles);
		var_6296423e = checknavmeshdirection(navmeshpoint, forward, 150, 0);
		var_cfa253f9 = [];
		if(distance(navmeshpoint, var_6296423e) >= 150)
		{
			result = 1;
		}
	}
	return result;
}

/*
	Name: function_6e16f65f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x28210E7
	Offset: 0x22E8
	Size: 0x11C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_6e16f65f(entity)
{
	result = 0;
	if(isdefined(self.var_97a22974) && self.var_97a22974 && gettime() > entity.var_95a46290 && isdefined(entity.favoriteenemy) && distance2dsquared(entity.origin, entity.favoriteenemy.origin) > 250000 && entity can_see_enemy() && entity function_488ba9cc() && !entity function_68469a59())
	{
		phase_direction = entity getblackboardattribute("_phase_direction");
		result = phase_direction != "NONE";
	}
	return result;
}

/*
	Name: function_3df69749
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA1CDAF4A
	Offset: 0x2410
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
function private function_3df69749()
{
	self.var_95a46290 = gettime() + (randomfloatrange(2, 4) * 1000);
}

/*
	Name: function_12aaa2f7
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xDAA5AF09
	Offset: 0x2450
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_12aaa2f7(entity)
{
	function_3df69749();
	self.var_a89d0c1a = gettime() + (randomfloatrange(3, 4) * 1000);
}

/*
	Name: function_f89eddf1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xE2419B16
	Offset: 0x24A8
	Size: 0x104
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f89eddf1(entity)
{
	result = 0;
	if(isdefined(self.var_97a22974) && self.var_97a22974 && (gettime() > entity.var_a89d0c1a || (gettime() > entity.var_5b8bf6ba && entity function_561b76c5())) && entity can_see_enemy() && !entity function_68469a59())
	{
		function_8ae62d74(entity);
		phase_direction = entity getblackboardattribute("_phase_direction");
		result = phase_direction != "NONE";
	}
	return result;
}

/*
	Name: function_c21c2cf7
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x86D944DF
	Offset: 0x25B8
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c21c2cf7(entity)
{
	function_ba6a44f();
}

/*
	Name: function_ba6a44f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xB8FB6611
	Offset: 0x25E0
	Size: 0x62
	Parameters: 0
	Flags: Linked, Private
*/
function private function_ba6a44f()
{
	self.var_a89d0c1a = gettime() + (randomfloatrange(3, 4) * 1000);
	self.var_5b8bf6ba = gettime() + (randomfloatrange(0, 1.5) * 1000);
}

/*
	Name: function_3bd2bba5
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x9E80E8E6
	Offset: 0x2650
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_3bd2bba5(entity)
{
	function_46660930();
}

/*
	Name: function_46660930
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xCCD49B6D
	Offset: 0x2678
	Size: 0x184
	Parameters: 0
	Flags: Linked, Private
*/
function private function_46660930()
{
	self endon(#"death");
	origin = self gettagorigin("j_spine4");
	playfx(self._effect[#"hash_571a3bab8b805854"], origin);
	self hide();
	self collidewithactors(0);
	self waittilltimeout(1, #"phase_end");
	self show();
	self collidewithactors(1);
	if(self.health > 0)
	{
		zm_net::network_safe_play_fx_on_tag("nova_crawler_aura", 2, self._effect[#"nova_crawler_aura_fx"], self, "j_spine4");
		zm_net::network_safe_play_fx_on_tag("nova_crawler_phase_teleport_end_fx", 2, self._effect[#"nova_crawler_phase_teleport_end_fx"], self, "j_spine4");
		playrumbleonposition("zm_nova_phase_exit_rumble", self.origin);
	}
}

/*
	Name: function_d7aebbd6
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x8D2D9C37
	Offset: 0x2808
	Size: 0x6E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_d7aebbd6(entity)
{
	result = 0;
	if(!function_b06bbbba() || (entity function_dd070839() || entity isonground()))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_ae4a399b
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA74D9940
	Offset: 0x2880
	Size: 0x48
	Parameters: 2
	Flags: Linked, Private
*/
function private function_ae4a399b(entity, asmstatename)
{
	if(!entity isonground())
	{
		animationstatenetworkutility::requeststate(entity, asmstatename);
	}
	return 5;
}

/*
	Name: function_9fcedb9c
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xC63105C8
	Offset: 0x28D0
	Size: 0x4A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_9fcedb9c(entity, asmstatename)
{
	result = 5;
	if(entity isonground())
	{
		result = 4;
	}
	return result;
}

/*
	Name: function_ac651298
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xCD9160FE
	Offset: 0x2928
	Size: 0x142
	Parameters: 12
	Flags: Linked, Private
*/
function private function_ac651298(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self.archetype == #"nova_crawler" && isdefined(self.var_b421bafe) && self.var_b421bafe && self.var_71841cf9 == -1)
	{
		self.var_71841cf9 = gettime() + (randomfloatrange(1, 3) * 1000);
	}
	else if(self.archetype == #"nova_crawler" && isdefined(self.var_9fde8624) && self.var_9fde8624 == #"blue_nova_crawler" && !isplayer(attacker))
	{
		return 0;
	}
	return -1;
}

/*
	Name: function_677d42d1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x10137F66
	Offset: 0x2A78
	Size: 0x22
	Parameters: 1
	Flags: Linked, Private
*/
function private function_677d42d1(entity)
{
	entity.favoriteenemy = entity.var_93a62fe;
}

/*
	Name: function_5b7e50b0
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x5AADA0C6
	Offset: 0x2AA8
	Size: 0xB2
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5b7e50b0(entity)
{
	result = 0;
	if(isdefined(entity.var_b421bafe) && entity.var_b421bafe && (isdefined(entity.can_shoot) && entity.can_shoot) && isdefined(level.white_nova_crawler_sniper_locations) && level.white_nova_crawler_sniper_locations.size > 0 && isdefined(level.white_nova_crawler_sniper_escape_locations) && level.white_nova_crawler_sniper_escape_locations.size > 0)
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_4c2972f1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x34FE1FD2
	Offset: 0x2B68
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_4c2972f1(entity)
{
	result = 0;
	if(isdefined(entity.var_b421bafe) && entity.var_b421bafe && !isdefined(entity.var_3fc4c097))
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_51e81aba
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x7F1487B7
	Offset: 0x2BD0
	Size: 0x11A
	Parameters: 1
	Flags: Linked
*/
function function_51e81aba(locations)
{
	var_f37b8acb = [];
	var_764cc1f9 = undefined;
	foreach(location in locations)
	{
		if(!(isdefined(location.is_claimed) && location.is_claimed) && isdefined(location.zone_name) && level.zones[location.zone_name].is_occupied)
		{
			var_f37b8acb[var_f37b8acb.size] = location;
		}
	}
	if(var_f37b8acb.size > 0)
	{
		var_764cc1f9 = array::random(var_f37b8acb);
	}
	return var_764cc1f9;
}

/*
	Name: function_c33d4387
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xCF1CB29B
	Offset: 0x2CF8
	Size: 0x36
	Parameters: 0
	Flags: Linked, Private
*/
function private function_c33d4387()
{
	if(isdefined(self.var_3fc4c097))
	{
		self.var_3fc4c097 thread function_46aa5dda();
		self.var_3fc4c097 = undefined;
	}
}

/*
	Name: function_46aa5dda
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xC813E909
	Offset: 0x2D38
	Size: 0x26
	Parameters: 0
	Flags: Linked, Private
*/
function private function_46aa5dda()
{
	wait(randomfloatrange(4, 5));
	self.is_claimed = undefined;
}

/*
	Name: function_90388f5b
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x52116792
	Offset: 0x2D68
	Size: 0xBE
	Parameters: 1
	Flags: Linked, Private
*/
function private function_90388f5b(entity)
{
	minigun_climb_up_tank_anim = function_51e81aba(level.white_nova_crawler_sniper_locations);
	if(isdefined(minigun_climb_up_tank_anim))
	{
		entity forceteleport(minigun_climb_up_tank_anim.origin, minigun_climb_up_tank_anim.angles);
		entity.var_3fc4c097 = minigun_climb_up_tank_anim;
		minigun_climb_up_tank_anim.is_claimed = 1;
		entity clientfield::increment("white_nova_crawler_phase_end_clientfield");
		entity.var_2208281f = gettime() + 30000;
		entity.no_powerups = 1;
	}
}

/*
	Name: function_fc9e257f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xFBE0325B
	Offset: 0x2E30
	Size: 0x198
	Parameters: 1
	Flags: Linked, Private
*/
function private function_fc9e257f(entity)
{
	result = 0;
	if(entity.var_71841cf9 < 0 && isdefined(entity.var_3fc4c097) && isdefined(entity.favoriteenemy) && distancesquared(entity.origin, entity.favoriteenemy.origin) > (1024 * 1024))
	{
		entity.var_71841cf9 = gettime() + (randomfloatrange(1, 3) * 1000);
	}
	if(entity.var_71841cf9 < 0 && entity.var_2208281f > 0 && gettime() > entity.var_2208281f)
	{
		entity.var_71841cf9 = gettime() + (randomfloatrange(1, 3) * 1000);
	}
	if(isdefined(entity.var_b421bafe) && entity.var_b421bafe && isdefined(entity.var_3fc4c097) && entity.var_71841cf9 > 0)
	{
		result = gettime() > entity.var_71841cf9;
	}
	return result;
}

/*
	Name: function_c708afa4
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x1550050E
	Offset: 0x2FD0
	Size: 0xDA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c708afa4(entity)
{
	var_96820b80 = function_51e81aba(level.white_nova_crawler_sniper_escape_locations);
	if(isdefined(var_96820b80))
	{
		playfx(self._effect[#"hash_571a3bab8b805854"], entity.origin);
		entity forceteleport(var_96820b80.origin, var_96820b80.angles);
		function_c33d4387();
		entity.var_b421bafe = 0;
		entity clientfield::increment("white_nova_crawler_phase_end_clientfield");
		entity.no_powerups = 0;
	}
}

/*
	Name: function_f0eb1b7e
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x15452372
	Offset: 0x30B8
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_f0eb1b7e(entity)
{
	self.var_15aa1ae0 = gettime() + (randomfloatrange(3, 5) * 1000);
	function_349ae23d();
	function_8eb7fbb7();
}

/*
	Name: function_8261512d
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x812E6A44
	Offset: 0x3120
	Size: 0x11E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8261512d(entity)
{
	result = 0;
	if(isdefined(entity.can_shoot) && entity.can_shoot && level.var_e6cea2c0 < gettime() && gettime() > entity.var_42ecd9f3 && isdefined(entity.favoriteenemy))
	{
		var_eab3f54a = distance2dsquared(entity.origin, entity.favoriteenemy.origin);
		if(var_eab3f54a > (200 * 200) && entity function_4ee74b24() && entity can_see_enemy() && !entity function_68469a59())
		{
			result = 1;
		}
	}
	return result;
}

/*
	Name: function_82777ad1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x9DB4F60E
	Offset: 0x3248
	Size: 0x52
	Parameters: 2
	Flags: Linked, Private
*/
function private function_82777ad1(entity, asmstatename)
{
	animationstatenetworkutility::requeststate(entity, asmstatename);
	level.var_e6cea2c0 = gettime() + 100;
	entity.var_67faa700 = 1;
	return 5;
}

/*
	Name: function_c44757b4
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x1F44D038
	Offset: 0x32A8
	Size: 0x38
	Parameters: 2
	Flags: Linked, Private
*/
function private function_c44757b4(entity, asmstatename)
{
	entity.var_67faa700 = undefined;
	function_8eb7fbb7();
	return 4;
}

/*
	Name: function_8eb7fbb7
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x5015459F
	Offset: 0x32E8
	Size: 0x86
	Parameters: 0
	Flags: Linked, Private
*/
function private function_8eb7fbb7()
{
	random_delay = 0;
	if(isdefined(self.var_b421bafe) && self.var_b421bafe)
	{
		random_delay = randomfloatrange(2, 3) * 1000;
	}
	else
	{
		random_delay = randomfloatrange(2, 3) * 1000;
	}
	self.var_42ecd9f3 = gettime() + random_delay;
}

/*
	Name: function_51ab2a44
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xD2BFC470
	Offset: 0x3378
	Size: 0xA0
	Parameters: 12
	Flags: Linked, Private
*/
function private function_51ab2a44(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	var_7aa37d9f = damage;
	if(isdefined(inflictor) && inflictor.team == self.team)
	{
		var_7aa37d9f = 0;
	}
	return var_7aa37d9f;
}

/*
	Name: function_270b3dee
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x876818F9
	Offset: 0x3420
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
function private function_270b3dee(entity)
{
	if(isactor(entity) && isdefined(entity.favoriteenemy))
	{
		start_location = entity gettagorigin("tag_tongue_3");
		target_location = entity.favoriteenemy getcentroid();
		if(isdefined(start_location))
		{
			function_91582c6(entity, start_location, target_location);
		}
	}
}

/*
	Name: function_91582c6
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x66DD31D4
	Offset: 0x34D8
	Size: 0xC6
	Parameters: 3
	Flags: Linked, Private
*/
function private function_91582c6(entity, start_location, target_location)
{
	weapon_name = "white_nova_crawler_projectile";
	if(isdefined(entity.var_9fde8624) && entity.var_9fde8624 == #"blue_nova_crawler")
	{
		weapon_name = "blue_nova_crawler_projectile";
	}
	projectile_weapon = getweapon(weapon_name);
	projectile = magicbullet(projectile_weapon, start_location, target_location, entity, entity.favoriteenemy);
}

/*
	Name: function_7d162bd0
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x8127650E
	Offset: 0x35A8
	Size: 0x7C
	Parameters: 2
	Flags: Private
*/
function private function_7d162bd0(projectile, entity)
{
	result = undefined;
	result = projectile waittill(#"projectile_impact_player", #"death");
	if(isdefined(projectile.origin))
	{
		level thread function_5c3c88fe(projectile.origin);
	}
}

/*
	Name: function_c36cef22
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x8F486E6D
	Offset: 0x3630
	Size: 0x1DC
	Parameters: 1
	Flags: None
*/
function function_c36cef22(origin)
{
	players = getplayers();
	zombies = getaiteamarray(level.zombie_team);
	foreach(zombie in zombies)
	{
		if(zombie != #"nova_crawler" && distancesquared(origin, zombie.origin) <= 6400)
		{
			zombie thread function_850768d1();
		}
	}
	foreach(player in players)
	{
		if(distancesquared(origin, player.origin) <= 6400)
		{
			player status_effect::status_effect_apply(getstatuseffect(#"hash_1b824ff143d6ba43"), undefined, player, 0);
		}
	}
	playrumbleonposition("zm_nova_explosion_rumble", origin);
}

/*
	Name: function_5c3c88fe
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x183BF239
	Offset: 0x3818
	Size: 0xB4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_5c3c88fe(location)
{
	var_d0feb0fe = spawn("trigger_radius", location, 0, 80, 100);
	n_gas_time = 0;
	var_d0feb0fe thread function_6d9aeb0f();
	var_d0feb0fe thread function_3ec863f5();
	while(n_gas_time <= 7)
	{
		wait(1);
		n_gas_time = n_gas_time + 1;
	}
	var_d0feb0fe delete();
}

/*
	Name: function_6d9aeb0f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xFFCF9986
	Offset: 0x38D8
	Size: 0xE2
	Parameters: 0
	Flags: Linked
*/
function function_6d9aeb0f()
{
	self endon(#"death");
	while(true)
	{
		zombies = getaiteamarray(level.zombie_team);
		foreach(zombie in zombies)
		{
			if(zombie istouching(self))
			{
				zombie thread function_850768d1();
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_3ec863f5
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xA063BD08
	Offset: 0x39C8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_3ec863f5()
{
	self endon(#"death");
	while(true)
	{
		players = getplayers();
		foreach(player in players)
		{
			if(player istouching(self))
			{
				player status_effect::status_effect_apply(getstatuseffect(#"hash_1b824ff143d6ba43"), undefined, player, 1);
			}
		}
		wait(0.15);
	}
}

/*
	Name: function_850768d1
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xE73C7E78
	Offset: 0x3AD8
	Size: 0x284
	Parameters: 1
	Flags: Linked
*/
function function_850768d1(b_respawn = 0)
{
	self notify("4757156a6fd357df");
	self endon("4757156a6fd357df");
	if(!isdefined(self.var_6e2628f7) && self.archetype == #"zombie")
	{
		if(!b_respawn)
		{
			self.health = int(self.health * 2);
		}
		self.var_6e2628f7 = 1;
		level notify(#"buffed", {#ai:self});
		self.var_bd2c55ef = 1;
		if(!isdefined(self.var_e0d660f6))
		{
			self.var_e0d660f6 = [];
		}
		else if(!isarray(self.var_e0d660f6))
		{
			self.var_e0d660f6 = array(self.var_e0d660f6);
		}
		if(!isinarray(self.var_e0d660f6, &function_4018ef0d))
		{
			self.var_e0d660f6[self.var_e0d660f6.size] = &function_4018ef0d;
		}
		self clientfield::set("nova_buff_aura_clientfield", 1);
		self.voiceprefix = "zombie_buff";
		wait(0.5);
		if(isdefined(self) && isalive(self))
		{
			s_movespeed = self zombie_utility::function_33da7a07();
			if(s_movespeed == "sprint")
			{
				self zombie_utility::set_zombie_run_cycle("super_sprint");
			}
			else
			{
				self zombie_utility::set_zombie_run_cycle("sprint");
			}
			self waittill(#"death");
			if(isdefined(self))
			{
				self clientfield::set("nova_buff_aura_clientfield", 0);
			}
		}
	}
}

/*
	Name: function_4018ef0d
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x462E5D67
	Offset: 0x3D68
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_4018ef0d()
{
	self thread function_850768d1(1);
}

/*
	Name: function_8b694c31
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x38889468
	Offset: 0x3D90
	Size: 0x7E
	Parameters: 1
	Flags: Linked, Private
*/
function private function_8b694c31(entity)
{
	result = 0;
	if(isdefined(entity.var_349e111e) && entity.var_349e111e && function_aaf0b660(entity) && !entity function_68469a59())
	{
		result = 1;
	}
	return result;
}

/*
	Name: function_aaf0b660
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x6D45DB3D
	Offset: 0x3E18
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_aaf0b660(entity)
{
	return gettime() > entity.var_926f011e;
}

/*
	Name: function_349ae23d
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x95C56B0
	Offset: 0x3E40
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
function private function_349ae23d()
{
	self.var_926f011e = gettime() + (randomfloatrange(5, 8) * 1000);
}

/*
	Name: function_e4d675eb
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x96B6E05A
	Offset: 0x3E80
	Size: 0x8C
	Parameters: 1
	Flags: Private
*/
function private function_e4d675eb(entity)
{
	if(isactor(entity))
	{
		var_d9016f6f = entity gettagorigin("j_mainroot");
		if(isdefined(var_d9016f6f))
		{
			entity clientfield::increment("nova_gas_cloud_fx_clientfield");
			level thread function_5c3c88fe(var_d9016f6f);
		}
	}
}

/*
	Name: function_48aba0aa
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x82C1E87D
	Offset: 0x3F18
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private function_48aba0aa(entity)
{
	function_349ae23d();
}

/*
	Name: function_1ded4b3e
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x16A60D0A
	Offset: 0x3F40
	Size: 0x180
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1ded4b3e(entity)
{
	result = 0;
	if(isdefined(entity.var_f1f44412) && entity.var_f1f44412 && gettime() > entity.var_ce83fefe && !entity function_68469a59())
	{
		ai_zombies = array::get_all_closest(entity.origin, getaiteamarray(entity.team), undefined, undefined, 300);
		if(ai_zombies.size > 0)
		{
			foreach(zombie in ai_zombies)
			{
				if(zombie.archetype == #"zombie" && isalive(zombie) && (!(isdefined(zombie.var_6e2628f7) && zombie.var_6e2628f7)))
				{
					result = 1;
					break;
				}
			}
		}
	}
	return result;
}

/*
	Name: function_41d1cdd5
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x65E226E0
	Offset: 0x40C8
	Size: 0x32
	Parameters: 0
	Flags: Linked, Private
*/
function private function_41d1cdd5()
{
	self.var_ce83fefe = gettime() + (randomfloatrange(5, 8) * 1000);
}

/*
	Name: function_13d38964
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x43066E1F
	Offset: 0x4108
	Size: 0x1A8
	Parameters: 1
	Flags: Linked, Private
*/
function private function_13d38964(entity)
{
	if(isdefined(entity) && isalive(entity) && isdefined(entity.favoriteenemy))
	{
		ai_zombies = array::get_all_closest(entity.origin, getaiteamarray(entity.team), undefined, undefined, 300);
		if(ai_zombies.size > 0)
		{
			foreach(zombie in ai_zombies)
			{
				if(zombie.archetype == #"zombie" && isalive(zombie) && (!(isdefined(zombie.var_6e2628f7) && zombie.var_6e2628f7)))
				{
					spore = function_d24f01d4();
					if(isdefined(spore))
					{
						function_a7cc9606(entity, spore);
						entity thread shoot_spore(spore, zombie);
						continue;
					}
					break;
				}
			}
		}
	}
}

/*
	Name: function_6b950494
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x65B4E554
	Offset: 0x42B8
	Size: 0x28
	Parameters: 2
	Flags: Linked, Private
*/
function private function_6b950494(entity, asmstatename)
{
	function_41d1cdd5();
	return 4;
}

/*
	Name: function_d24f01d4
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0x9F77E92B
	Offset: 0x42E8
	Size: 0xB6
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d24f01d4()
{
	foreach(spore in level.var_bb3415b1)
	{
		if(isalive(spore.owner) || spore clientfield::get("white_nova_crawler_spore_clientfield") == 1)
		{
			continue;
		}
		return spore;
	}
	return undefined;
}

/*
	Name: function_a7cc9606
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xE0E58182
	Offset: 0x43A8
	Size: 0x5A
	Parameters: 2
	Flags: Linked, Private
*/
function private function_a7cc9606(entity, spore)
{
	/#
		/#
			assert(!isalive(spore.owner));
		#/
	#/
	spore.owner = entity;
}

/*
	Name: function_c2ca573f
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xB7BA4E0C
	Offset: 0x4410
	Size: 0x16
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c2ca573f(spore)
{
	spore.owner = undefined;
}

/*
	Name: function_b262d632
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xFE8B28DA
	Offset: 0x4430
	Size: 0xAE
	Parameters: 3
	Flags: Private
*/
function private function_b262d632(start, end, duration)
{
	current_time = duration * 20;
	/#
		while(current_time > 0)
		{
			waitframe(1);
			line(start, end, (0, 1, 0), 1, 1);
			sphere(self.origin, 3, (1, 1, 0), 1, 0, 8, 1);
			current_time = current_time - 1;
		}
	#/
}

/*
	Name: shoot_spore
	Namespace: zm_ai_white_nova_crawler
	Checksum: 0xBF7F829F
	Offset: 0x44E8
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function shoot_spore(spore, target)
{
	spore endon(#"death");
	start_location = self gettagorigin("j_spine4");
	target_velocity = target getvelocity();
	target_location = target getcentroid() + (target_velocity * 0.5);
	spore.origin = start_location;
	wait(0.1);
	spore clientfield::set("white_nova_crawler_spore_clientfield", 1);
	spore moveto(target_location, 0.5);
	spore waittill(#"movedone");
	if(isdefined(target) && isalive(target))
	{
		target clientfield::increment("white_nova_crawler_spore_impact_clientfield");
		target thread function_850768d1();
	}
	spore clientfield::set("white_nova_crawler_spore_clientfield", 0);
	if(isdefined(spore.owner))
	{
		function_c2ca573f(spore);
	}
}

