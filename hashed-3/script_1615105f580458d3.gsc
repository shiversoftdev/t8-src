// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_2dc48f46bfeac894;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_268fc37c;

/*
	Name: function_89f2df9
	Namespace: namespace_268fc37c
	Checksum: 0xAB003B72
	Offset: 0x268
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_39775c4aaea6051b", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_268fc37c
	Checksum: 0x37BEEC0F
	Offset: 0x2B8
	Size: 0x332
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("toplayer", "tomahawk_in_use", 1, 2, "int");
	clientfield::register("toplayer", "" + #"upgraded_tomahawk_in_use", 1, 1, "int");
	clientfield::register("scriptmover", "play_tomahawk_fx", 1, 2, "int");
	clientfield::register("actor", "play_tomahawk_hit_sound", 1, 1, "int");
	clientfield::register("toplayer", "tomahawk_rumble", 1, 2, "counter");
	clientfield::register("actor", "tomahawk_impact_fx", 1, 2, "int");
	clientfield::register("allplayers", "tomahawk_charge_up_fx", 1, 2, "counter");
	var_92c56e8d = getminbitcountfornum(3);
	clientfield::register("scriptmover", "tomahawk_trail_fx", 1, var_92c56e8d, "int");
	clientfield::register("missile", "tomahawk_trail_fx", 1, var_92c56e8d, "int");
	callback::on_connect(&tomahawk_on_player_connect);
	level.a_tomahawk_pickup_funcs = [];
	zm_loadout::register_lethal_grenade_for_level(#"tomahawk_t8");
	zm_loadout::register_lethal_grenade_for_level(#"tomahawk_t8_upgraded");
	zm::function_84d343d(#"tomahawk_t8", &function_c34db78);
	zm::function_84d343d(#"tomahawk_t8_upgraded", &function_c34db78);
	level.var_6d0e2c1b[getweapon(#"tomahawk_t8")] = &function_932e24b;
	level.var_6d0e2c1b[getweapon(#"tomahawk_t8_upgraded")] = &function_932e24b;
}

/*
	Name: __main__
	Namespace: namespace_268fc37c
	Checksum: 0x80F724D1
	Offset: 0x5F8
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: tomahawk_on_player_connect
	Namespace: namespace_268fc37c
	Checksum: 0xE6356102
	Offset: 0x608
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function tomahawk_on_player_connect()
{
	self.var_4f8fb07f = #"tomahawk_t8";
	self thread watch_for_tomahawk_throw();
	self thread watch_for_tomahawk_charge();
}

/*
	Name: watch_for_tomahawk_throw
	Namespace: namespace_268fc37c
	Checksum: 0x37D030C0
	Offset: 0x658
	Size: 0x21E
	Parameters: 0
	Flags: Linked, Private
*/
private function watch_for_tomahawk_throw()
{
	self endon(#"disconnect");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"grenade_fire");
		e_grenade = s_result.projectile;
		w_weapon = s_result.weapon;
		var_f92d6c6e = getweapon(#"tomahawk_t8");
		var_91bb47aa = getweapon(#"tomahawk_t8_upgraded");
		if(w_weapon == var_f92d6c6e || w_weapon == var_91bb47aa)
		{
			self thread tomahawk_rumble(2);
			self ability_player::function_c22f319e(w_weapon);
			e_grenade.use_grenade_special_bookmark = 1;
			e_grenade.grenade_multiattack_bookmark_count = 1;
			e_grenade.low_level_instant_kill_charge = 1;
			e_grenade.owner = self;
			self notify(#"throwing_tomahawk", {#w_weapon:w_weapon, #e_grenade:e_grenade});
			self thread function_932e24b(w_weapon);
			if(isdefined(self.n_tomahawk_cooking_time))
			{
				e_grenade.n_cookedtime = e_grenade.birthtime - self.n_tomahawk_cooking_time;
			}
			else
			{
				e_grenade.n_cookedtime = 0;
			}
			self thread check_for_time_out(e_grenade);
			self thread tomahawk_thrown(e_grenade);
			self waittill(#"hash_6145d2b6c756e7cb");
		}
	}
}

/*
	Name: function_932e24b
	Namespace: namespace_268fc37c
	Checksum: 0x5348C734
	Offset: 0x880
	Size: 0x14C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_932e24b(w_weapon)
{
	self endon(#"disconnect", #"hash_3d73720d4588203c");
	self waittill(#"hash_1a7714f0d7e25f27");
	self ability_player::function_f2250880(w_weapon);
	var_eec22f7e = 100 / 8 / 0.25;
	n_start_time = gettime();
	n_total_time = 0;
	n_power = 0;
	while(n_total_time < 8)
	{
		n_power = n_power + var_eec22f7e;
		self gadgetpowerset(self gadgetgetslot(w_weapon), n_power);
		wait(0.25);
		n_current_time = gettime();
		n_total_time = n_current_time - n_start_time / 1000;
	}
	self gadgetpowerset(self gadgetgetslot(w_weapon), 100);
}

/*
	Name: watch_for_tomahawk_charge
	Namespace: namespace_268fc37c
	Checksum: 0x3D023803
	Offset: 0x9D8
	Size: 0x142
	Parameters: 0
	Flags: Linked, Private
*/
private function watch_for_tomahawk_charge()
{
	self endon(#"disconnect");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"grenade_pullback");
		w_grenade = s_result.weapon;
		var_f92d6c6e = getweapon(#"tomahawk_t8");
		var_91bb47aa = getweapon(#"tomahawk_t8_upgraded");
		if(w_grenade == var_f92d6c6e || w_grenade == var_91bb47aa)
		{
			self.n_tomahawk_cooking_time = gettime();
			self thread play_charge_fx(w_grenade);
			self thread function_9310fcc0(w_grenade);
			self waittill(#"grenade_fire", #"grenade_throw_cancelled");
			wait(0.1);
			self.n_tomahawk_cooking_time = undefined;
		}
	}
}

/*
	Name: play_charge_fx
	Namespace: namespace_268fc37c
	Checksum: 0x1C27CD1
	Offset: 0xB28
	Size: 0x17A
	Parameters: 1
	Flags: Linked, Private
*/
private function play_charge_fx(w_grenade)
{
	self endon(#"death", #"disconnect", #"grenade_fire", #"grenade_throw_cancelled");
	waittillframeend();
	var_673471b1 = 1000;
	while(true)
	{
		time = gettime() - self.n_tomahawk_cooking_time;
		self.var_4f8fb07f = w_grenade.name;
		if(time >= var_673471b1)
		{
			if(self.var_4f8fb07f == #"tomahawk_t8_upgraded")
			{
				self clientfield::increment("tomahawk_charge_up_fx", 2);
			}
			else
			{
				self clientfield::increment("tomahawk_charge_up_fx", 1);
			}
			var_673471b1 = var_673471b1 + 1000;
			self playrumbleonentity("reload_small");
		}
		if(var_673471b1 > 2400 && self.var_4f8fb07f != #"tomahawk_t8_upgraded")
		{
			break;
		}
		if(var_673471b1 >= 3400)
		{
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_9310fcc0
	Namespace: namespace_268fc37c
	Checksum: 0x1841A79B
	Offset: 0xCB0
	Size: 0xB0
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9310fcc0(w_grenade)
{
	self endon(#"death", #"disconnect", #"grenade_fire", #"grenade_throw_cancelled");
	self thread tomahawk_rumble(3);
	wait(1);
	while(true)
	{
		self playrumbleonentity("damage_light");
		wait(0.3);
	}
}

/*
	Name: get_grenade_charge_power
	Namespace: namespace_268fc37c
	Checksum: 0xB268E54A
	Offset: 0xD68
	Size: 0x12E
	Parameters: 1
	Flags: Linked, Private
*/
private function get_grenade_charge_power(player)
{
	player endon(#"disconnect");
	if(!isdefined(self))
	{
		return 1;
	}
	if(self.n_cookedtime > 1000 && self.n_cookedtime < 2000)
	{
		if(player.var_4f8fb07f == #"tomahawk_t8_upgraded")
		{
			return 4.5;
		}
		return 1.5;
	}
	if(self.n_cookedtime > 2000 && self.n_cookedtime < 3000)
	{
		if(player.var_4f8fb07f == #"tomahawk_t8_upgraded")
		{
			return 6;
		}
		return 2;
	}
	if(self.n_cookedtime >= 3000 && player.var_4f8fb07f != #"tomahawk_t8_upgraded")
	{
		return 2;
	}
	if(self.n_cookedtime >= 3000)
	{
		return 3;
	}
	return 1;
}

/*
	Name: tomahawk_thrown
	Namespace: namespace_268fc37c
	Checksum: 0x9597EC0E
	Offset: 0xEA0
	Size: 0x774
	Parameters: 1
	Flags: Linked, Private
*/
private function tomahawk_thrown(e_grenade)
{
	self endon(#"disconnect");
	grenade_owner = undefined;
	if(!isdefined(e_grenade))
	{
		return;
	}
	if(isdefined(e_grenade.owner))
	{
		grenade_owner = e_grenade.owner;
	}
	var_65f2e452 = 0;
	var_643ef1e3 = 0;
	e_grenade clientfield::set("tomahawk_trail_fx", 3);
	self clientfield::set_to_player("tomahawk_in_use", 2);
	e_grenade waittill(#"death", #"time_out");
	n_grenade_charge_power = e_grenade get_grenade_charge_power(self);
	if(isdefined(level.a_tomahawk_pickup_funcs))
	{
		foreach(tomahawk_func in level.a_tomahawk_pickup_funcs)
		{
			if([[tomahawk_func]](e_grenade, n_grenade_charge_power))
			{
				return;
			}
		}
	}
	a_powerups = [];
	eyepos = self geteye();
	if(level.active_powerups.size && isdefined(e_grenade))
	{
		foreach(var_7d81025 in level.active_powerups)
		{
			if(self util::is_looking_at(var_7d81025))
			{
				v_dir = vectornormalize(e_grenade.origin - eyepos);
				if(isdefined(var_7d81025 sightconetrace(eyepos, self, v_dir, 4)) && var_7d81025 sightconetrace(eyepos, self, v_dir, 4))
				{
					if(!isdefined(a_powerups))
					{
						a_powerups = [];
					}
					else if(!isarray(a_powerups))
					{
						a_powerups = array(a_powerups);
					}
					if(!isinarray(a_powerups, var_7d81025))
					{
						a_powerups[a_powerups.size] = var_7d81025;
					}
				}
			}
		}
	}
	if(a_powerups.size)
	{
		var_6e6ec518 = tomahawk_spawn(e_grenade.origin, n_grenade_charge_power);
		var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
		var_6e6ec518.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
		if(isdefined(e_grenade))
		{
			e_grenade delete();
		}
		foreach(powerup in a_powerups)
		{
			powerup.origin = var_6e6ec518.origin;
			powerup linkto(var_6e6ec518);
			var_6e6ec518.a_has_powerup = a_powerups;
		}
		self thread tomahawk_return_player(var_6e6ec518, 0);
		return;
	}
	if(!isdefined(e_grenade))
	{
		return;
	}
	a_ai_zombies = util::get_array_of_closest(e_grenade.origin, getaiteamarray(level.zombie_team), undefined, undefined, 64);
	if(a_ai_zombies.size)
	{
		while(a_ai_zombies.size)
		{
			if(isalive(a_ai_zombies[0]))
			{
				var_94b59fd = a_ai_zombies[0];
				arrayremovevalue(a_ai_zombies, var_94b59fd);
				var_94b59fd clientfield::set("play_tomahawk_hit_sound", 1);
				n_tomahawk_damage = calculate_tomahawk_damage(var_94b59fd, n_grenade_charge_power, e_grenade);
				var_94b59fd dodamage(n_tomahawk_damage, e_grenade.origin, self, self, "none", "MOD_GRENADE", 0, getweapon(#"tomahawk_t8"));
				if(var_94b59fd.health < 0)
				{
					var_643ef1e3++;
					var_94b59fd namespace_6b49f66b::function_bb33631e(#"spoon");
				}
				var_94b59fd.hit_by_tomahawk = 1;
				var_26defc9d = var_94b59fd;
				var_65f2e452++;
				self zm_score::add_to_player_score(10, undefined, undefined, var_94b59fd.var_12745932);
				if(var_65f2e452 >= 5)
				{
					if(var_643ef1e3 >= 5)
					{
						self notify(#"hash_3669499a148a6d6e", {#weapon:e_grenade.weapon});
					}
					var_6e6ec518 = tomahawk_spawn(e_grenade.origin, n_grenade_charge_power);
					var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
					var_6e6ec518.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
					if(isdefined(e_grenade))
					{
						e_grenade delete();
					}
					self thread tomahawk_return_player(var_6e6ec518, var_65f2e452);
					return;
				}
			}
			a_ai_zombies = array::remove_undefined(a_ai_zombies);
		}
		self thread tomahawk_ricochet_attack(var_65f2e452, e_grenade, n_grenade_charge_power, var_26defc9d);
	}
	else
	{
		self thread tomahawk_ricochet_attack(var_65f2e452, e_grenade, n_grenade_charge_power, var_26defc9d);
	}
}

/*
	Name: check_for_time_out
	Namespace: namespace_268fc37c
	Checksum: 0x4CDE8390
	Offset: 0x1620
	Size: 0x50
	Parameters: 1
	Flags: Linked, Private
*/
private function check_for_time_out(e_grenade)
{
	self endon(#"disconnect");
	e_grenade endon(#"death");
	wait(0.5);
	e_grenade notify(#"time_out");
}

/*
	Name: tomahawk_ricochet_attack
	Namespace: namespace_268fc37c
	Checksum: 0x324D4EC9
	Offset: 0x1678
	Size: 0x64C
	Parameters: 4
	Flags: Linked, Private
*/
private function tomahawk_ricochet_attack(var_65f2e452, e_grenade, var_bc201c9e, e_ignore)
{
	self endon(#"disconnect");
	var_6e6ec518 = tomahawk_spawn(e_grenade.origin, var_bc201c9e);
	var_6e6ec518.n_grenade_charge_power = var_bc201c9e;
	var_6e6ec518.low_level_instant_kill_charge = e_grenade.low_level_instant_kill_charge;
	var_6e6ec518 endon(#"death");
	if(isdefined(e_grenade))
	{
		e_grenade delete();
	}
	if(var_65f2e452 >= 5)
	{
		self thread tomahawk_return_player(var_6e6ec518, var_65f2e452);
		return;
	}
	a_ai_zombies = util::get_array_of_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 900);
	if(!a_ai_zombies.size)
	{
		self thread tomahawk_return_player(var_6e6ec518, var_65f2e452);
		return;
	}
	var_f500f73e = [];
	var_939f6f02 = 5 - var_65f2e452;
	v_start_pos = self.origin + vectorscale((0, 0, 1), 50);
	e_ignore = self;
	do
	{
		s_trace = bullettrace(v_start_pos, v_start_pos + anglestoforward(self getplayerangles()) * 900, 1, e_ignore);
		if(isdefined(s_trace[#"entity"]) && isinarray(getaiteamarray(level.zombie_team), s_trace[#"entity"]))
		{
			if(!(isdefined(s_trace[#"entity"].hit_by_tomahawk) && s_trace[#"entity"].hit_by_tomahawk))
			{
				if(!isdefined(var_f500f73e))
				{
					var_f500f73e = [];
				}
				else if(!isarray(var_f500f73e))
				{
					var_f500f73e = array(var_f500f73e);
				}
				if(!isinarray(var_f500f73e, s_trace[#"entity"]))
				{
					var_f500f73e[var_f500f73e.size] = s_trace[#"entity"];
				}
			}
			v_start_pos = s_trace[#"entity"].origin + vectorscale((0, 0, 1), 50);
			e_ignore = s_trace[#"entity"];
		}
		if(var_f500f73e.size >= var_939f6f02)
		{
			break;
		}
		waitframe(1);
	}
	while(isdefined(s_trace[#"entity"]) && isinarray(a_ai_zombies, s_trace[#"entity"]));
	var_f500f73e = array::remove_undefined(var_f500f73e, 0);
	a_ai_zombies = array::remove_undefined(a_ai_zombies, 0);
	v_start_pos = self.origin + vectorscale((0, 0, 1), 50);
	e_ignore = self;
	foreach(ai_zombie in a_ai_zombies)
	{
		if(var_f500f73e.size >= var_939f6f02)
		{
			break;
		}
		if(isdefined(ai_zombie sightconetrace(v_start_pos, e_ignore, vectornormalize(self getplayerangles()), 5)) && ai_zombie sightconetrace(v_start_pos, e_ignore, vectornormalize(self getplayerangles()), 5))
		{
			if(!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk))
			{
				if(!isdefined(var_f500f73e))
				{
					var_f500f73e = [];
				}
				else if(!isarray(var_f500f73e))
				{
					var_f500f73e = array(var_f500f73e);
				}
				if(!isinarray(var_f500f73e, ai_zombie))
				{
					var_f500f73e[var_f500f73e.size] = ai_zombie;
				}
			}
			v_start_pos = ai_zombie.origin + vectorscale((0, 0, 1), 50);
			e_ignore = ai_zombie;
		}
	}
	if(var_f500f73e.size)
	{
		var_f500f73e = arraysortclosest(var_f500f73e, self.origin);
		var_65f2e452 = self function_e865484a(var_6e6ec518, var_f500f73e, var_65f2e452);
	}
	if(var_65f2e452 >= 5)
	{
		self thread tomahawk_return_player(var_6e6ec518, var_65f2e452);
		return;
	}
	self thread function_d81951f5(var_6e6ec518, var_65f2e452);
}

/*
	Name: function_d81951f5
	Namespace: namespace_268fc37c
	Checksum: 0xF4DE7E7A
	Offset: 0x1CD0
	Size: 0x284
	Parameters: 2
	Flags: Linked, Private
*/
private function function_d81951f5(var_6e6ec518, var_65f2e452)
{
	var_f500f73e = [];
	a_ai_zombies = util::get_array_of_closest(self.origin, getaiteamarray(level.zombie_team), undefined, undefined, 900);
	foreach(ai_zombie in a_ai_zombies)
	{
		if(isdefined(ai_zombie sightconetrace(self geteye(), self, vectornormalize(self getplayerangles()), 17)) && ai_zombie sightconetrace(self geteye(), self, vectornormalize(self getplayerangles()), 17) && (!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)))
		{
			if(!isdefined(var_f500f73e))
			{
				var_f500f73e = [];
			}
			else if(!isarray(var_f500f73e))
			{
				var_f500f73e = array(var_f500f73e);
			}
			if(!isinarray(var_f500f73e, ai_zombie))
			{
				var_f500f73e[var_f500f73e.size] = ai_zombie;
			}
		}
	}
	if(var_f500f73e.size)
	{
		var_f500f73e = arraysortclosest(var_f500f73e, self.origin);
		var_f500f73e = array::reverse(var_f500f73e);
		var_65f2e452 = self function_e865484a(var_6e6ec518, var_f500f73e, var_65f2e452);
	}
	self thread tomahawk_return_player(var_6e6ec518, var_65f2e452);
}

/*
	Name: function_e865484a
	Namespace: namespace_268fc37c
	Checksum: 0x3109D833
	Offset: 0x1F60
	Size: 0x21C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_e865484a(var_6e6ec518, a_ai_zombie, var_65f2e452)
{
	self endon(#"disconnect");
	while(true)
	{
		ai_zombie = undefined;
		for(i = 0; i < a_ai_zombie.size; i++)
		{
			if(isalive(a_ai_zombie[i]) && (!(isdefined(a_ai_zombie[i].hit_by_tomahawk) && a_ai_zombie[i].hit_by_tomahawk)))
			{
				if(isdefined(bullettracepassed(var_6e6ec518.origin, a_ai_zombie[i] geteye(), 0, var_6e6ec518)) && bullettracepassed(var_6e6ec518.origin, a_ai_zombie[i] geteye(), 0, var_6e6ec518))
				{
					ai_zombie = a_ai_zombie[i];
					break;
				}
			}
		}
		if(!isdefined(ai_zombie))
		{
			return var_65f2e452;
		}
		n_dist = distance(var_6e6ec518.origin, ai_zombie gettagorigin("j_head"));
		var_bfed4a7 = n_dist / 1600;
		var_bfed4a7 = (var_bfed4a7 > 0.05 ? var_bfed4a7 : 0.05);
		self thread function_c7ddedb2(var_6e6ec518, ai_zombie, var_bfed4a7);
		wait(var_bfed4a7);
		var_65f2e452++;
		if(var_65f2e452 >= 5)
		{
			return var_65f2e452;
		}
	}
	return var_65f2e452;
}

/*
	Name: function_c7ddedb2
	Namespace: namespace_268fc37c
	Checksum: 0x5BEAD4F1
	Offset: 0x2188
	Size: 0x24C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_c7ddedb2(var_6e6ec518, ai_zombie, var_bfed4a7 = 0.25)
{
	self endon(#"disconnect");
	if(isalive(ai_zombie) && (!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk)))
	{
		v_target = ai_zombie gettagorigin("J_Head");
		var_6e6ec518 moveto(v_target, var_bfed4a7);
		wait(var_bfed4a7);
		if(isalive(ai_zombie))
		{
			ai_zombie.hit_by_tomahawk = 1;
			if(self.var_4f8fb07f == #"tomahawk_t8_upgraded")
			{
				ai_zombie clientfield::set("tomahawk_impact_fx", 2);
			}
			else
			{
				ai_zombie clientfield::set("tomahawk_impact_fx", 1);
			}
			ai_zombie clientfield::set("play_tomahawk_hit_sound", 1);
			n_tomahawk_damage = calculate_tomahawk_damage(ai_zombie, var_6e6ec518.n_grenade_charge_power, var_6e6ec518);
			ai_zombie dodamage(n_tomahawk_damage, var_6e6ec518.origin, self, var_6e6ec518, "none", "MOD_GRENADE", 0, getweapon(self.var_4f8fb07f));
			if(ai_zombie.health < 0)
			{
				ai_zombie namespace_6b49f66b::function_bb33631e(#"spoon");
			}
			self zm_score::add_to_player_score(10, undefined, undefined, ai_zombie.var_12745932);
		}
	}
}

/*
	Name: tomahawk_return_player
	Namespace: namespace_268fc37c
	Checksum: 0x16C08AB4
	Offset: 0x23E0
	Size: 0x42E
	Parameters: 3
	Flags: Linked
*/
function tomahawk_return_player(var_6e6ec518, var_65f2e452, n_move_speed = 1600)
{
	self endon(#"disconnect");
	if(isdefined(var_6e6ec518))
	{
		n_dist = distance(var_6e6ec518.origin, self geteye());
		var_e65ebf4 = n_dist / n_move_speed;
		var_e65ebf4 = (var_e65ebf4 > 0.05 ? var_e65ebf4 : 0.05);
		n_total_time = undefined;
		n_dist_sq = distance2dsquared(var_6e6ec518.origin, self geteye());
		if(!isdefined(var_65f2e452))
		{
			var_65f2e452 = 5;
		}
		while(n_dist_sq > 1600)
		{
			var_6e6ec518 moveto(self geteye(), var_e65ebf4);
			if(var_65f2e452 < 5)
			{
				self function_723cb8bd(var_6e6ec518);
				var_65f2e452++;
				wait(0.1);
			}
			else if(!isdefined(n_total_time))
			{
				n_start_time = gettime();
				n_total_time = 0;
			}
			wait(0.1);
			n_current_time = gettime();
			n_total_time = n_current_time - n_start_time / 1000;
			var_e65ebf4 = self function_e2c00ed6(var_6e6ec518, n_move_speed, n_total_time);
			n_dist_sq = distance2dsquared(var_6e6ec518.origin, self geteye());
		}
		if(isdefined(var_6e6ec518.a_has_powerup))
		{
			foreach(powerup in var_6e6ec518.a_has_powerup)
			{
				if(isdefined(powerup))
				{
					powerup.origin = self.origin;
				}
			}
		}
		var_6e6ec518 delete();
	}
	self thread tomahawk_rumble(1);
	self playsound("wpn_tomahawk_return");
	self notify(#"hash_1a7714f0d7e25f27");
	self waittill_timeout(8, #"hash_3d73720d4588203c");
	self playsoundtoplayer(#"hash_5651c152f44645d1", self);
	self givemaxammo(getweapon(self.var_4f8fb07f));
	a_zombies = getaispeciesarray(level.zombie_team, "all");
	foreach(ai_zombie in a_zombies)
	{
		ai_zombie.hit_by_tomahawk = undefined;
	}
	self clientfield::set_to_player("tomahawk_in_use", 3);
	self notify(#"hash_6145d2b6c756e7cb");
}

/*
	Name: function_e2c00ed6
	Namespace: namespace_268fc37c
	Checksum: 0x38C3E8C1
	Offset: 0x2818
	Size: 0x11C
	Parameters: 3
	Flags: Linked, Private
*/
private function function_e2c00ed6(var_6e6ec518, n_move_speed, n_total_time)
{
	if(n_total_time < 0.05)
	{
		var_e89ec7fd = 0.05 - n_total_time;
		var_e89ec7fd = (var_e89ec7fd > 0.05 ? var_e89ec7fd : 0.05);
	}
	else
	{
		var_e89ec7fd = 0.05;
	}
	var_a6693654 = n_total_time * 0.25;
	var_5100df85 = n_move_speed + n_move_speed * var_a6693654;
	n_dist = distance(var_6e6ec518.origin, self geteye());
	var_e65ebf4 = n_dist / var_5100df85;
	var_e65ebf4 = (var_e65ebf4 > var_e89ec7fd ? var_e65ebf4 : var_e89ec7fd);
	return var_e65ebf4;
}

/*
	Name: function_723cb8bd
	Namespace: namespace_268fc37c
	Checksum: 0xC4E0EC39
	Offset: 0x2940
	Size: 0x10C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_723cb8bd(var_6e6ec518)
{
	self endon(#"disconnect");
	var_6e6ec518 endon(#"death");
	a_ai_zombies = getaiteamarray(level.zombie_team);
	if(a_ai_zombies.size)
	{
		ai_zombie = arraygetclosest(var_6e6ec518.origin, a_ai_zombies);
		if(isalive(ai_zombie) && distance2dsquared(var_6e6ec518.origin, ai_zombie.origin) <= 10000)
		{
			if(!(isdefined(ai_zombie.hit_by_tomahawk) && ai_zombie.hit_by_tomahawk))
			{
				self function_c7ddedb2(var_6e6ec518, ai_zombie);
			}
		}
	}
}

/*
	Name: tomahawk_spawn
	Namespace: namespace_268fc37c
	Checksum: 0x21374DE3
	Offset: 0x2A58
	Size: 0x166
	Parameters: 2
	Flags: Linked
*/
function tomahawk_spawn(grenade_origin, charged)
{
	var_6e6ec518 = util::spawn_model("wpn_t8_zm_tomahawk_world", grenade_origin);
	var_6e6ec518 thread tomahawk_spin();
	if(self.var_4f8fb07f == #"tomahawk_t8_upgraded" || (isdefined(self.var_67ea42af) && self.var_67ea42af))
	{
		var_6e6ec518 clientfield::set("tomahawk_trail_fx", 2);
	}
	else
	{
		var_6e6ec518 clientfield::set("tomahawk_trail_fx", 1);
	}
	if(isdefined(charged) && charged > 1 && isdefined(self.var_67ea42af))
	{
		var_6e6ec518 clientfield::set("tomahawk_trail_fx", 4);
	}
	else if(isdefined(charged) && charged > 1)
	{
		var_6e6ec518 clientfield::set("tomahawk_trail_fx", 3);
	}
	var_6e6ec518.low_level_instant_kill_charge = 1;
	return var_6e6ec518;
}

/*
	Name: tomahawk_spin
	Namespace: namespace_268fc37c
	Checksum: 0xD5FB8C5D
	Offset: 0x2BC8
	Size: 0x50
	Parameters: 0
	Flags: Linked, Private
*/
private function tomahawk_spin()
{
	self endon(#"death");
	while(isdefined(self))
	{
		self rotatepitch(90, 0.2);
		wait(0.15);
	}
}

/*
	Name: calculate_tomahawk_damage
	Namespace: namespace_268fc37c
	Checksum: 0xEFB10034
	Offset: 0x2C20
	Size: 0x130
	Parameters: 3
	Flags: Linked, Private
*/
private function calculate_tomahawk_damage(var_79cffd1e, n_tomahawk_power, tomahawk)
{
	if(n_tomahawk_power > 2)
	{
		return var_79cffd1e.health + 1;
	}
	if(level.round_number >= 10 && level.round_number < 13 && tomahawk.low_level_instant_kill_charge <= 3)
	{
		tomahawk.low_level_instant_kill_charge = tomahawk.low_level_instant_kill_charge + 1;
		return var_79cffd1e.health + 1;
	}
	if(level.round_number >= 13 && level.round_number < 15 && tomahawk.low_level_instant_kill_charge <= 2)
	{
		tomahawk.low_level_instant_kill_charge = tomahawk.low_level_instant_kill_charge + 1;
		return var_79cffd1e.health + 1;
	}
	return 1000 * n_tomahawk_power;
}

/*
	Name: function_c34db78
	Namespace: namespace_268fc37c
	Checksum: 0xB0D79F5C
	Offset: 0x2D60
	Size: 0xCA
	Parameters: 12
	Flags: Linked
*/
function function_c34db78(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(namespace_6b49f66b::is_active() && namespace_6b49f66b::function_937e218c() === #"spoon" && isplayer(eattacker))
	{
		self.var_12745932 = 1;
	}
	return idamage;
}

/*
	Name: tomahawk_rumble
	Namespace: namespace_268fc37c
	Checksum: 0x64E8349E
	Offset: 0x2E38
	Size: 0xCA
	Parameters: 1
	Flags: Linked, Private
*/
private function tomahawk_rumble(var_b2e05bae)
{
	if(var_b2e05bae)
	{
		switch(var_b2e05bae)
		{
			case 3:
			{
				self playrumbleonentity("zm_weap_special_activate_rumble");
				break;
			}
			case 1:
			{
				self clientfield::increment_to_player("tomahawk_rumble", 1);
				break;
			}
			case 2:
			{
				self clientfield::increment_to_player("tomahawk_rumble", 2);
				break;
			}
		}
	}
}

