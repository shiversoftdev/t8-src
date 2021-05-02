// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_35598499769dbb3d;
#using script_3819e7a1427df6d2;
#using script_3aa0f32b70d4f7cb;
#using script_3f9e0dc8454d98e1;
#using script_41fe08c37d53a635;
#using script_4d85e8de54b02198;
#using script_5dbd8e79a9aa7b75;
#using script_6809bf766eba194a;
#using script_7e59d7bba853fe4b;
#using script_bd2b8aaa388dcce;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_312634d1;

/*
	Name: function_89f2df9
	Namespace: namespace_312634d1
	Checksum: 0x41433C11
	Offset: 0x278
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_26aeac851e7602d1", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_312634d1
	Checksum: 0x7DB28002
	Offset: 0x2C8
	Size: 0x29C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	/#
		assert(isscriptfunctionptr(&function_29c22852));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_4ead7642034f30f7", &function_29c22852);
	/#
		assert(isscriptfunctionptr(&function_33b29495));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_3d7ced75f59bb519", &function_33b29495);
	/#
		assert(isscriptfunctionptr(&function_27a1a846));
	#/
	behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_6e9be4be56cd06d3", &function_27a1a846);
	animationstatenetwork::registernotetrackhandlerfunction("nova_crawler_melee", &function_99ac548f);
	animationstatenetwork::registernotetrackhandlerfunction("nova_crawler_explosion", &function_272fa9b5);
	spawner::add_archetype_spawn_function(#"nova_crawler", &function_1d34f2b6);
	spawner::function_89a2cd87(#"nova_crawler", &function_1dc9be26);
	/#
		zm_devgui::function_c7dd7a17("");
	#/
	clientfield::register("actor", "nova_crawler_burst_clientfield", 1, 1, "int");
	clientfield::register("toplayer", "nova_crawler_burst_postfx_clientfield", 1, 1, "int");
	clientfield::register("toplayer", "nova_crawler_gas_cloud_postfx_clientfield", 1, 1, "int");
}

/*
	Name: __main__
	Namespace: namespace_312634d1
	Checksum: 0x80F724D1
	Offset: 0x570
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_1d34f2b6
	Namespace: namespace_312634d1
	Checksum: 0xAA436D5C
	Offset: 0x580
	Size: 0x1B6
	Parameters: 0
	Flags: Linked
*/
function function_1d34f2b6()
{
	var_626a6a36 = namespace_e0710ee6::function_8d44707e(1);
	var_626a6a36 = var_626a6a36 * (isdefined(level.var_1eb98fb1) ? level.var_1eb98fb1 : 1);
	self.maxhealth = int(var_626a6a36);
	self.health = self.maxhealth;
	self.meleedamage = ai::function_9139c839().var_f2367046;
	self.var_1731eda3 = 1;
	self.var_2c628c0f = 1;
	self.canbetargetedbyturnedzombies = 1;
	self.is_zombie = 1;
	self.var_34b2e48 = 1;
	self.var_442eb649 = 1;
	self.actor_killed_override = &function_c5b157a6;
	self zm_score::function_82732ced();
	self zm_utility::init_zombie_run_cycle();
	self thread zm_audio::zmbaivox_notifyconvert();
	self thread zm_audio::play_ambient_zombie_vocals();
	self thread zm_audio::zmbaivox_playvox(self, "spawn", 1, 3);
	if(!isdefined(self._effect))
	{
		self._effect = [];
		self._effect[#"nova_crawler_aura_fx"] = "zm_ai/fx8_nova_crawler_gas_trail";
	}
}

/*
	Name: function_1dc9be26
	Namespace: namespace_312634d1
	Checksum: 0x88EF688D
	Offset: 0x740
	Size: 0x1C
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1dc9be26()
{
	self thread function_488c1ac2();
}

/*
	Name: function_edb72673
	Namespace: namespace_312634d1
	Checksum: 0xF9AB2584
	Offset: 0x768
	Size: 0x76
	Parameters: 1
	Flags: Private
*/
private function function_edb72673(origin)
{
	goal_pos = getclosestpointonnavmesh(origin, 200, 24);
	if(isdefined(goal_pos))
	{
		self function_a57c34b7(goal_pos);
		return 1;
	}
	self function_a57c34b7(self.origin);
	return 0;
}

/*
	Name: function_29c22852
	Namespace: namespace_312634d1
	Checksum: 0xCC1E5D5C
	Offset: 0x7E8
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function function_29c22852(entity)
{
	if(!isdefined(entity.enemy))
	{
		return 0;
	}
	if(isdefined(entity.marked_for_death))
	{
		return 0;
	}
	if(isdefined(entity.ignoremelee) && entity.ignoremelee)
	{
		return 0;
	}
	if(abs(entity.origin[2] - entity.enemy.origin[2]) > 64)
	{
		return 0;
	}
	if(isdefined(entity.meleeweapon) && entity.meleeweapon !== level.weaponnone)
	{
		meleedistsq = entity.meleeweapon.var_d3cafde6 * entity.meleeweapon.var_d3cafde6;
	}
	if(!isdefined(meleedistsq))
	{
		return 0;
	}
	if(distancesquared(entity.origin, entity.enemy.origin) > meleedistsq)
	{
		return 0;
	}
	yawtoenemy = angleclamp180(entity.angles[1] - vectortoangles(entity.enemy.origin - entity.origin)[1]);
	if(abs(yawtoenemy) > 60)
	{
		return 0;
	}
	if(!entity cansee(entity.enemy))
	{
		return 0;
	}
	if(!tracepassedonnavmesh(entity.origin, (isdefined(entity.enemy.enemy.last_valid_position) ? entity.enemy.last_valid_position : entity.enemy.origin), entity getpathfindingradius()))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_33b29495
	Namespace: namespace_312634d1
	Checksum: 0x3C8AF241
	Offset: 0xA60
	Size: 0xA0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_33b29495(entity)
{
	var_711090a2 = 0;
	var_b77044e1 = lerpfloat(0.2, 0.8, math::clamp(level.round_number - 1 / 30, 0, 1));
	if(randomfloat(1) <= var_b77044e1)
	{
		var_711090a2 = 1;
	}
	return var_711090a2;
}

/*
	Name: function_27a1a846
	Namespace: namespace_312634d1
	Checksum: 0x7A0D10CB
	Offset: 0xB08
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
private function function_27a1a846(entity)
{
	var_62d41d8f = 0;
	if(isdefined(self.killed_enemy_player) && self.killed_enemy_player)
	{
		var_62d41d8f = 1;
		self.killed_enemy_player = 0;
	}
	return var_62d41d8f;
}

/*
	Name: function_99ac548f
	Namespace: namespace_312634d1
	Checksum: 0x3085F77A
	Offset: 0xB60
	Size: 0x96
	Parameters: 1
	Flags: Linked, Private
*/
private function function_99ac548f(entity)
{
	var_75aa8513 = 0;
	if(isdefined(entity.enemy) && zm_utility::is_player_valid(entity.enemy))
	{
		var_75aa8513 = 1;
	}
	zombiebehavior::zombienotetrackmeleefire(entity);
	if(var_75aa8513 && !zm_utility::is_player_valid(entity.enemy))
	{
		self.killed_enemy_player = 1;
	}
}

/*
	Name: function_488c1ac2
	Namespace: namespace_312634d1
	Checksum: 0x5A4F21B0
	Offset: 0xC00
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_488c1ac2()
{
	self endon(#"death");
	self waittill_timeout(1, #"spawn_complete");
	zm_net::network_safe_play_fx_on_tag("quad_trail", 2, self._effect[#"nova_crawler_aura_fx"], self, "j_spine4");
}

/*
	Name: function_d79b3357
	Namespace: namespace_312634d1
	Checksum: 0x97996592
	Offset: 0xC70
	Size: 0x276
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d79b3357(entity, origin)
{
	playsoundatposition(#"zmb_quad_explo", origin);
	entity clientfield::set("nova_crawler_burst_clientfield", 1);
	players = getplayers();
	zombies = getaiteamarray(level.zombie_team);
	for(i = 0; i < zombies.size; i++)
	{
		if(zombies[i].archetype != #"nova_crawler" && distance(origin, zombies[i].origin) <= 96)
		{
			zombies[i] dodamage(zombies[i].maxhealth * 1.05, origin, entity);
			if(zombies[i].health <= 0)
			{
				zombies[i] startragdoll();
				zombies[i] launchragdoll(zombies[i].origin - origin);
			}
		}
	}
	if(isdefined(self.var_442eb649) && self.var_442eb649)
	{
		for(i = 0; i < players.size; i++)
		{
			if(distance(origin, players[i].origin) <= 96)
			{
				players[i] shellshock(#"explosion", 2.5);
				players[i] clientfield::set_to_player("nova_crawler_burst_postfx_clientfield", 1);
			}
		}
	}
}

/*
	Name: function_4632879c
	Namespace: namespace_312634d1
	Checksum: 0x8A657E9C
	Offset: 0xEF0
	Size: 0x1CC
	Parameters: 1
	Flags: Linked, Private
*/
private function function_4632879c(entity)
{
	effectarea = spawn("trigger_radius", entity.origin, 0, 125, 100);
	gas_time = 0;
	while(gas_time <= 7)
	{
		players = getplayers();
		for(i = 0; i < players.size; i++)
		{
			if(players[i] istouching(effectarea))
			{
				players[i] clientfield::set_to_player("nova_crawler_gas_cloud_postfx_clientfield", 1);
				continue;
			}
			players[i] clientfield::set_to_player("nova_crawler_gas_cloud_postfx_clientfield", 0);
		}
		wait(1);
		gas_time = gas_time + 1;
	}
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		players[i] clientfield::set_to_player("nova_crawler_burst_postfx_clientfield", 0);
		players[i] clientfield::set_to_player("nova_crawler_gas_cloud_postfx_clientfield", 0);
	}
	effectarea delete();
}

/*
	Name: function_272fa9b5
	Namespace: namespace_312634d1
	Checksum: 0x9386A97D
	Offset: 0x10C8
	Size: 0x8C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_272fa9b5(entity)
{
	if(isdefined(self.can_explode) && self.can_explode)
	{
		self thread function_d79b3357(self, self.origin);
		if(isdefined(self.var_34b2e48) && self.var_34b2e48)
		{
			level thread function_4632879c(self);
		}
		gibserverutils::annihilate(self);
	}
}

/*
	Name: function_c5b157a6
	Namespace: namespace_312634d1
	Checksum: 0x926974B5
	Offset: 0x1160
	Size: 0x1A4
	Parameters: 8
	Flags: Linked
*/
function function_c5b157a6(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime)
{
	if(self.archetype == #"nova_crawler")
	{
		self destructserverutils::togglespawngibs(self, 1);
		self destructserverutils::function_629a8d54(self, "tag_weapon_right");
	}
	self thread zombie_utility::zombie_gib(idamage, attacker, vdir, self gettagorigin("j_spine4"), smeansofdeath, shitloc, undefined, undefined, weapon);
	if(isdefined(self.var_c858954a) && self.var_c858954a && zm_utility::is_explosive_damage(smeansofdeath))
	{
		gibserverutils::annihilate(self);
	}
	else if(smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_RIFLE_BULLET")
	{
		self.can_explode = 1;
	}
	else
	{
		self.can_explode = 0;
	}
	zm_spawner::zombie_death_animscript(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

