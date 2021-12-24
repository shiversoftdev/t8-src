// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_35598499769dbb3d;
#using script_3f9e0dc8454d98e1;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_10f9f462;

/*
	Name: function_89f2df9
	Namespace: namespace_10f9f462
	Checksum: 0x338CEC80
	Offset: 0x2D0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_1324e72460f62df9", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_10f9f462
	Checksum: 0x17149F33
	Offset: 0x318
	Size: 0x54C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_3891e803 = getweapon(#"hash_4ae11871b1233211");
	level.var_d7f4cb84 = getweapon(#"hash_5f8f734c5dd02242");
	level.var_29cce7eb = getweapon(#"hash_5aa162d2872d2bac");
	level.var_bc26d00c = getweapon(#"hash_eeac880dffb5d95");
	level.var_7cfd8159 = [];
	clientfield::register("missile", "" + #"hash_6308b5ed3cbd99e3", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_37c2ef99d645cf87", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_37c2ef99d645cf87", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_690509b9a2ec2ef3", 1, 2, "int");
	clientfield::register("allplayers", "" + #"hash_290836b72f987780", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_faa2f4808c12f8d", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_6c3560ab45e186ec", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_b38c687db71dae", 1, 1, "int");
	callback::on_ai_damage(&function_615d8c38);
	callback::on_connect(&function_39ffd9fc);
	callback::on_connect(&function_89ec3604);
	callback::function_f77ced93(&function_16be57e6);
	callback::function_34dea974(level.var_3891e803, &function_62d37304);
	callback::function_34dea974(level.var_d7f4cb84, &function_62d37304);
	callback::function_34dea974(level.var_29cce7eb, &function_62d37304);
	callback::function_34dea974(level.var_bc26d00c, &function_62d37304);
	namespace_9ff9f642::register_slowdown(#"hash_664a130410d3fd9a", 0.75, 5);
	namespace_9ff9f642::register_slowdown(#"hash_2607a6ffde83b4a7", 0.5, 5);
	namespace_9ff9f642::register_slowdown(#"hash_3a067a5eb7a19857", 0.75, 5);
	namespace_9ff9f642::register_slowdown(#"hash_280fa271c70412cd", 0.75, 5);
	zm_score::register_score_event("crossbow_capture_hold", &function_9eed975c);
	zm_score::register_score_event("crossbow_crawler", &function_9d9c8bc2);
	zm::register_actor_damage_callback(&function_51f76fdb);
	if(!isdefined(level.var_2e1c9680))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_2e1c9680 = object;
		[[ level.var_2e1c9680 ]]->initialize(6, 0.1);
	}
}

/*
	Name: function_89ec3604
	Namespace: namespace_10f9f462
	Checksum: 0x4A923440
	Offset: 0x870
	Size: 0x280
	Parameters: 0
	Flags: Linked, Private
*/
private function function_89ec3604()
{
	self endon(#"disconnect");
	self.var_bcc8f4f0 = 0;
	while(true)
	{
		w_current = self getcurrentweapon();
		if(is_crossbow(w_current) && self function_8426ad52(w_current) && self attackbuttonpressed() && !self ismeleeing())
		{
			if(self.var_bcc8f4f0)
			{
				self.var_bcc8f4f0 = 0;
			}
			self clientfield::set("" + #"hash_290836b72f987780", 1);
			b_charged = 0;
			while(self attackbuttonpressed() && is_crossbow(w_current) && !self meleebuttonpressed() && !self laststand::player_is_in_laststand())
			{
				if(!b_charged && function_c6da1395(w_current, self))
				{
					self clientfield::set("" + #"hash_290836b72f987780", 0);
					b_charged = 1;
				}
				w_current = self getcurrentweapon();
				waitframe(1);
			}
			self clientfield::set("" + #"hash_290836b72f987780", 0);
		}
		else if(is_crossbow(w_current) && !self isreloading() && !self function_8426ad52(w_current) && !self.var_bcc8f4f0)
		{
			self.var_bcc8f4f0 = 1;
		}
		waitframe(1);
	}
}

/*
	Name: function_51f76fdb
	Namespace: namespace_10f9f462
	Checksum: 0x76E26674
	Offset: 0xAF8
	Size: 0x1FE
	Parameters: 12
	Flags: Linked
*/
function function_51f76fdb(inflictor, attacker, damage, flags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isplayer(attacker) && is_crossbow(weapon) && function_c6da1395(weapon, attacker) && attacker zm_powerups::is_insta_kill_active())
	{
		if(!isactor(self) || !isdefined(inflictor) || smeansofdeath !== "MOD_PROJECTILE")
		{
			return -1;
		}
		if(isdefined(inflictor.var_99100b64) && inflictor.var_99100b64 || (isdefined(self.var_1df64653) && self.var_1df64653) || (isdefined(self.var_427e5396) && self.var_427e5396))
		{
			return -1;
		}
		if(isdefined(self.var_2c2980d3) && self.var_2c2980d3 || self.archetype == #"hash_165d4f75a46540bb" || self.archetype == #"hash_3b41c3299f47fb7f")
		{
			return -1;
		}
		self.instakill_func = &function_b0477b86;
	}
	else if(self.instakill_func === (&function_b0477b86))
	{
		self.instakill_func = undefined;
	}
	return -1;
}

/*
	Name: function_8426ad52
	Namespace: namespace_10f9f462
	Checksum: 0x598B49F2
	Offset: 0xD00
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_8426ad52(weapon)
{
	if(!is_crossbow(weapon))
	{
		return 0;
	}
	var_57b07826 = function_d8effeda(weapon);
	var_510d7f2b = self getweaponammostock(var_57b07826);
	n_ammo_clip = self getweaponammoclip(var_57b07826);
	if(var_510d7f2b >= 4 && n_ammo_clip > 0 || n_ammo_clip > 5)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_16be57e6
	Namespace: namespace_10f9f462
	Checksum: 0xA148B0BC
	Offset: 0xDC8
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function function_16be57e6(params)
{
	if(is_crossbow(params.weapon) && !function_c6da1395(params.weapon))
	{
		self clientfield::set("" + #"hash_b38c687db71dae", 1);
		self thread function_7157628d();
	}
	else
	{
		self notify(#"hash_72be12bd6b55fdab");
	}
}

/*
	Name: function_7157628d
	Namespace: namespace_10f9f462
	Checksum: 0x7A4ED718
	Offset: 0xE78
	Size: 0x2E8
	Parameters: 0
	Flags: Linked
*/
function function_7157628d()
{
	self notify("6e0a9e3b0455824");
	self endon("6e0a9e3b0455824");
	self endon_callback(&function_a4d47b95, #"death", #"disconnect", #"hash_72be12bd6b55fdab");
	self.var_5e9be59f = 0;
	while(true)
	{
		w_current = self getcurrentweapon();
		if(is_crossbow(w_current) && self ismeleeing())
		{
			self clientfield::set("" + #"hash_b38c687db71dae", 0);
			while(self ismeleeing())
			{
				waitframe(1);
			}
			w_current = self getcurrentweapon();
			if(is_crossbow(w_current))
			{
				self clientfield::set("" + #"hash_b38c687db71dae", 1);
			}
		}
		else if(is_crossbow(w_current) && function_8426ad52(w_current) && self.chargeshotlevel > 1 && !self.var_5e9be59f && self attackbuttonpressed())
		{
			self clientfield::set("" + #"hash_faa2f4808c12f8d", 1);
			self clientfield::set("" + #"hash_b38c687db71dae", 0);
			self.var_5e9be59f = 1;
		}
		else if(self.var_5e9be59f && (self.chargeshotlevel <= 1 || !self attackbuttonpressed()))
		{
			self clientfield::set("" + #"hash_faa2f4808c12f8d", 0);
			self clientfield::set("" + #"hash_b38c687db71dae", 1);
			self.var_5e9be59f = 0;
		}
		waitframe(1);
	}
}

/*
	Name: function_a4d47b95
	Namespace: namespace_10f9f462
	Checksum: 0x10D48245
	Offset: 0x1168
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_a4d47b95(str_notify)
{
	self clientfield::set("" + #"hash_b38c687db71dae", 0);
}

/*
	Name: function_39ffd9fc
	Namespace: namespace_10f9f462
	Checksum: 0xE55371F4
	Offset: 0x11A8
	Size: 0x92
	Parameters: 0
	Flags: Linked, Private
*/
private function function_39ffd9fc()
{
	self endon(#"disconnect");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"weapon_change");
		w_current = var_be17187b.weapon;
		if(is_crossbow(w_current))
		{
			self thread zm_equipment::show_hint_text(#"hash_781f9cab14f565c8");
			return;
		}
	}
}

/*
	Name: function_74106de1
	Namespace: namespace_10f9f462
	Checksum: 0x3DBB6ABB
	Offset: 0x1248
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_74106de1()
{
	self endon(#"death");
	self delete();
}

/*
	Name: function_615d8c38
	Namespace: namespace_10f9f462
	Checksum: 0x5815240C
	Offset: 0x1280
	Size: 0x3AA
	Parameters: 1
	Flags: Linked
*/
function function_615d8c38(params)
{
	if(!is_crossbow(params.weapon))
	{
		return;
	}
	if(isdefined(self.var_a05119b7) && self.var_a05119b7)
	{
		return;
	}
	if(!isplayer(params.eattacker))
	{
		return;
	}
	self notify(#"hash_2fb2eddfa6a0ef3f");
	var_59d5af75 = self gettagorigin("j_knee_le");
	if(isdefined(params.einflictor) && params.shitloc === "none" && isdefined(var_59d5af75))
	{
		var_47208148 = params.einflictor.origin[2] - var_59d5af75[2];
		if(params.einflictor.origin[2] < var_59d5af75[2] || abs(var_47208148) <= 16)
		{
			params.shitloc = "left_foot";
		}
	}
	switch(params.shitloc)
	{
		case "right_leg_upper":
		case "left_leg_lower":
		case "right_leg_lower":
		case "left_foot":
		case "right_foot":
		case "left_leg_upper":
		{
			if(isalive(self))
			{
				if(self.archetype == #"zombie")
				{
					if(function_c6da1395(params.weapon) || (self.missinglegs && (!(isdefined(self.var_410503e) && self.var_410503e))))
					{
						self thread function_c805f2f9(params);
					}
					else
					{
						params.eattacker zm_score::player_add_points("crossbow_crawler", 20);
						self zombie_utility::makezombiecrawler(1);
						level notify(#"hash_5198ca6a3343ece8", {#weapon:params.weapon, #player:params.eattacker, #zombie:self});
						self thread function_6119da66();
					}
				}
				else
				{
					self thread function_c805f2f9(params);
				}
			}
			break;
		}
		default:
		{
			if(isalive(self) && (!(isdefined(self.var_410503e) && self.var_410503e)))
			{
				self thread function_c805f2f9(params);
			}
		}
	}
}

/*
	Name: function_6119da66
	Namespace: namespace_10f9f462
	Checksum: 0xC4EEDC1F
	Offset: 0x1638
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_6119da66()
{
	self endon(#"death");
	self.var_410503e = 1;
	wait(1);
	self.var_410503e = undefined;
}

/*
	Name: function_6d8527c2
	Namespace: namespace_10f9f462
	Checksum: 0xDD45F972
	Offset: 0x1678
	Size: 0x1DC
	Parameters: 3
	Flags: Linked
*/
function function_6d8527c2(var_37fa9b04, str_scene, str_shot)
{
	self endon(#"death");
	params = {#shitloc:"none", #smeansofdeath:var_37fa9b04.mod, #weapon:var_37fa9b04.weapon, #einflictor:var_37fa9b04.inflictor, #eattacker:var_37fa9b04.attacker};
	self.var_2c2980d3 = 1;
	self clientfield::set("" + #"hash_37c2ef99d645cf87", 1);
	if(isdefined(str_scene))
	{
		if(isdefined(str_shot))
		{
			self thread scene::play(str_scene, str_shot, self);
		}
		else
		{
			self thread scene::play(str_scene, self);
		}
	}
	else
	{
		self thread function_8194ec6(function_a2c527e5(params.weapon));
	}
	self function_e1c4ab06(params);
	self clientfield::set("" + #"hash_37c2ef99d645cf87", 0);
	self.var_2c2980d3 = undefined;
	if(isdefined(str_scene))
	{
		self thread scene::stop(str_scene);
	}
}

/*
	Name: function_8194ec6
	Namespace: namespace_10f9f462
	Checksum: 0xEFFAC9B1
	Offset: 0x1860
	Size: 0xBE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_8194ec6(var_5824ff75 = 0)
{
	self endon(#"death");
	if(var_5824ff75)
	{
		var_a0edda8b = 3;
	}
	else
	{
		var_a0edda8b = 1.5;
	}
	while(isdefined(self.var_2c2980d3) && self.var_2c2980d3)
	{
		self rotateyaw(var_a0edda8b, float(function_60d95f53()) / 1000);
		waitframe(1);
	}
}

/*
	Name: function_c805f2f9
	Namespace: namespace_10f9f462
	Checksum: 0xB38952A
	Offset: 0x1928
	Size: 0x9AE
	Parameters: 1
	Flags: Linked
*/
function function_c805f2f9(params)
{
	self endon(#"death");
	player = params.eattacker;
	var_3891e803 = params.weapon;
	var_5ff12d5f = params.einflictor;
	if(!isactor(self) || !isplayer(player) || !isdefined(var_5ff12d5f))
	{
		return;
	}
	if(!isdefined(player.var_7cfd8159))
	{
		player.var_7cfd8159 = [];
	}
	player.var_7cfd8159 = array::remove_dead(player.var_7cfd8159);
	if(isdefined(var_5ff12d5f.var_99100b64) && var_5ff12d5f.var_99100b64 || !function_c6da1395(var_3891e803) || (isdefined(self.var_1df64653) && self.var_1df64653) || (isdefined(self.var_427e5396) && self.var_427e5396) || (isdefined(self.var_2c2980d3) && self.var_2c2980d3) || params.smeansofdeath === "MOD_MELEE" || self.archetype == #"hash_165d4f75a46540bb" || self.archetype == #"hash_3b41c3299f47fb7f")
	{
		if(isdefined(self.var_427e5396) && self.var_427e5396 || (isdefined(self.var_2c2980d3) && self.var_2c2980d3))
		{
			return;
		}
		self.var_a05119b7 = 1;
		n_damage = self function_b3ac0cab(params);
		self function_b261e2a0(n_damage, player, self.origin, params);
		if(isdefined(params.vdir) && self.health <= 0)
		{
			if(params.shitloc === "head" || params.shitloc === "helmet")
			{
				gibserverutils::gibhead(self);
			}
			else if(self.archetype === #"zombie")
			{
				self zombie_utility::derive_damage_refs(params.vpoint);
			}
			var_eb0d0f20 = 75 * vectornormalize(params.vdir);
			var_eb0d0f20 = (var_eb0d0f20[0], var_eb0d0f20[1], 20);
			self startragdoll();
			self launchragdoll(var_eb0d0f20);
		}
		self.var_a05119b7 = undefined;
		return;
	}
	if(player.var_7cfd8159.size >= 2)
	{
		var_f0aeb173 = (player.var_7cfd8159.size - 2) + 1;
		for(i = 0; i < var_f0aeb173; i++)
		{
			ai_zombie = player.var_7cfd8159[i];
			if(isalive(ai_zombie))
			{
				player.var_7cfd8159[i].var_2c2980d3 = undefined;
			}
		}
	}
	var_5ff12d5f.var_99100b64 = 1;
	self.var_2c2980d3 = 1;
	self.instakill_func = &function_b0477b86;
	level.var_7cfd8159 = array::remove_dead(level.var_7cfd8159);
	if(!isdefined(level.var_7cfd8159))
	{
		level.var_7cfd8159 = [];
	}
	else if(!isarray(level.var_7cfd8159))
	{
		level.var_7cfd8159 = array(level.var_7cfd8159);
	}
	level.var_7cfd8159[level.var_7cfd8159.size] = self;
	if(!isdefined(player.var_7cfd8159))
	{
		player.var_7cfd8159 = [];
	}
	else if(!isarray(player.var_7cfd8159))
	{
		player.var_7cfd8159 = array(player.var_7cfd8159);
	}
	player.var_7cfd8159[player.var_7cfd8159.size] = self;
	self clientfield::set("" + #"hash_37c2ef99d645cf87", 1);
	str_scene = self function_e43d1b24();
	if(isdefined(str_scene) && isalive(self))
	{
		self thread scene::play(str_scene, self);
	}
	else if(function_a2c527e5(var_3891e803))
	{
		self function_9fa5e527(10);
	}
	else
	{
		self function_9fa5e527(5);
	}
	self function_e1c4ab06(params);
	if(isdefined(player))
	{
		player zm_score::player_add_points("crossbow_capture_hold", 50);
	}
	if(isalive(self))
	{
		if(isdefined(str_scene))
		{
			if(scene::function_9730988a(str_scene, "outro"))
			{
				self thread scene::play(str_scene, "outro", self);
			}
			else
			{
				self scene::stop(str_scene);
			}
		}
		else
		{
			self function_43f61cad();
		}
		self.dont_die_on_me = undefined;
		arrayremovevalue(level.var_7cfd8159, self);
		if(isdefined(player))
		{
			arrayremovevalue(player.var_7cfd8159, self);
		}
		n_damage = self function_b3ac0cab(params);
		self function_b261e2a0(n_damage, player, self.origin, params);
		self.var_2c2980d3 = undefined;
		self.var_427e5396 = undefined;
		self.instakill_func = undefined;
		self clientfield::set("" + #"hash_37c2ef99d645cf87", 0);
		if(self.health <= 0 && self.archetype !== #"elephant")
		{
			self playsound("wpn_scorpion_zombie_explode");
			gibserverutils::annihilate(self);
			v_origin = self.origin;
			a_zombies = array::exclude(getaiteamarray(level.zombie_team), self);
			foreach(ai in a_zombies)
			{
				if(isalive(ai) && ai function_8a514a61(v_origin, var_3891e803))
				{
					n_damage = ai function_b3ac0cab(params);
					ai thread function_b261e2a0(n_damage, player, v_origin, params);
					waitframe(1);
				}
			}
		}
	}
}

/*
	Name: function_8a514a61
	Namespace: namespace_10f9f462
	Checksum: 0xBA82A2C3
	Offset: 0x22E0
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_8a514a61(v_origin, weapon)
{
	if(function_a2c527e5(weapon))
	{
		if(distancesquared(self.origin, v_origin) <= 44100)
		{
			return 1;
		}
	}
	else if(distancesquared(self.origin, v_origin) <= 25600)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b261e2a0
	Namespace: namespace_10f9f462
	Checksum: 0x56200F65
	Offset: 0x2378
	Size: 0xC4
	Parameters: 4
	Flags: Linked
*/
function function_b261e2a0(n_amount, player, v_origin, params)
{
	self endon(#"death");
	[[ level.var_2e1c9680 ]]->waitinqueue(self);
	if(isdefined(player))
	{
		self dodamage(n_amount, v_origin, player, params.einflictor, params.shitloc, params.smeansofdeath, 0, params.weapon);
	}
	else
	{
		self dodamage(n_amount, v_origin);
	}
}

/*
	Name: function_d8effeda
	Namespace: namespace_10f9f462
	Checksum: 0x892C17C4
	Offset: 0x2448
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_d8effeda(weapon)
{
	if(function_a2c527e5(weapon))
	{
		return level.var_d7f4cb84;
	}
	return level.var_3891e803;
}

/*
	Name: is_crossbow
	Namespace: namespace_10f9f462
	Checksum: 0xEFDC7681
	Offset: 0x2490
	Size: 0x66
	Parameters: 1
	Flags: Linked
*/
function is_crossbow(weapon)
{
	if(weapon === level.var_3891e803 || weapon === level.var_d7f4cb84 || weapon === level.var_29cce7eb || weapon === level.var_bc26d00c)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c6da1395
	Namespace: namespace_10f9f462
	Checksum: 0xA21ABF36
	Offset: 0x2500
	Size: 0x132
	Parameters: 2
	Flags: Linked
*/
function function_c6da1395(weapon, player)
{
	if(isdefined(player))
	{
		var_57b07826 = function_d8effeda(weapon);
		var_510d7f2b = player getweaponammostock(var_57b07826);
		n_ammo_clip = player getweaponammoclip(var_57b07826);
		if(n_ammo_clip >= 5 || var_510d7f2b >= 4 && (weapon === level.var_29cce7eb || weapon === level.var_bc26d00c))
		{
			return 1;
		}
		if(isdefined(player.chargeshotlevel) && player.chargeshotlevel > 1)
		{
			return 1;
		}
	}
	else if(weapon === level.var_29cce7eb || weapon === level.var_bc26d00c)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a2c527e5
	Namespace: namespace_10f9f462
	Checksum: 0x1A03EC7C
	Offset: 0x2640
	Size: 0x3E
	Parameters: 1
	Flags: Linked
*/
function function_a2c527e5(weapon)
{
	if(weapon === level.var_d7f4cb84 || weapon === level.var_bc26d00c)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_e1c4ab06
	Namespace: namespace_10f9f462
	Checksum: 0x602C34F
	Offset: 0x2688
	Size: 0x748
	Parameters: 1
	Flags: Linked
*/
function function_e1c4ab06(params)
{
	v_origin = self.origin;
	player = params.eattacker;
	e_inflictor = params.einflictor;
	var_3891e803 = params.weapon;
	params.smeansofdeath = "MOD_ELECTROCUTED";
	if(function_a2c527e5(var_3891e803))
	{
		var_832a6071 = 1;
		n_time = 10;
	}
	else
	{
		var_832a6071 = 0;
		n_time = 5;
	}
	wait(0.5);
	while(n_time > 0 && isalive(self) && (isdefined(self.var_2c2980d3) && self.var_2c2980d3))
	{
		level.var_7cfd8159 = array::remove_dead(level.var_7cfd8159);
		a_zombies = array::exclude(getaiteamarray(level.zombie_team), level.var_7cfd8159);
		if(self.archetype === #"elephant" && isdefined(self.ai) && isdefined(self.ai.riders))
		{
			a_zombies = array::exclude(a_zombies, self.ai.riders);
		}
		foreach(ai in a_zombies)
		{
			if(isalive(ai) && ai function_8a514a61(v_origin, var_3891e803) && ai.archetype !== #"hash_3b41c3299f47fb7f")
			{
				if(!(isdefined(ai.var_427e5396) && ai.var_427e5396))
				{
					if(isdefined(player))
					{
						if(!isdefined(player.var_d382ba7a))
						{
							player.var_d382ba7a = [];
						}
						else if(!isarray(player.var_d382ba7a))
						{
							player.var_d382ba7a = array(player.var_d382ba7a);
						}
						player.var_d382ba7a[player.var_d382ba7a.size] = ai;
						player.var_d382ba7a = array::remove_dead(player.var_d382ba7a);
					}
					ai.var_427e5396 = 1;
					if(function_a2c527e5(var_3891e803))
					{
						ai clientfield::set("" + #"hash_690509b9a2ec2ef3", 2);
						ai function_9fa5e527(10);
					}
					else
					{
						ai clientfield::set("" + #"hash_690509b9a2ec2ef3", 1);
						ai function_9fa5e527(5);
					}
					wait(0.05);
				}
				/#
					if(isalive(ai) && !isdefined(ai.maxhealth) && isdefined(ai.archetype))
					{
						iprintlnbold(("" + function_9e72a96(ai.archetype)) + "");
					}
				#/
				if(isalive(ai) && isdefined(ai.maxhealth))
				{
					if(var_832a6071)
					{
						ai function_b261e2a0(int(ai.maxhealth * 0.2), player, v_origin, params);
					}
					else
					{
						ai function_b261e2a0(int(ai.maxhealth * 0.1), player, v_origin, params);
					}
					waitframe(1);
					continue;
				}
				continue;
			}
		}
		if(!isalive(self) || (!(isdefined(self.var_2c2980d3) && self.var_2c2980d3)))
		{
			break;
		}
		wait(1);
		n_time = n_time - 1;
	}
	a_zombies = array::exclude(getaiteamarray(level.zombie_team), level.var_7cfd8159);
	foreach(ai in a_zombies)
	{
		if(isalive(ai) && (isdefined(ai.var_427e5396) && ai.var_427e5396))
		{
			if(isdefined(player) && isarray(player.var_d382ba7a))
			{
				arrayremovevalue(player.var_d382ba7a, ai);
			}
			ai.var_427e5396 = undefined;
			ai clientfield::set("" + #"hash_690509b9a2ec2ef3", 0);
			ai function_43f61cad();
			util::wait_network_frame();
		}
	}
}

/*
	Name: function_144a052b
	Namespace: namespace_10f9f462
	Checksum: 0xBBAB2685
	Offset: 0x2DD8
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_144a052b(archetype)
{
	switch(archetype)
	{
		case "catalyst":
		case "zombie":
		{
			return #"hash_664a130410d3fd9a";
		}
		case "tiger":
		{
			return #"hash_2607a6ffde83b4a7";
		}
		case "stoker":
		case "gladiator":
		{
			return #"hash_3a067a5eb7a19857";
		}
		case "blight_father":
		{
			return #"hash_280fa271c70412cd";
		}
	}
}

/*
	Name: function_9fa5e527
	Namespace: namespace_10f9f462
	Checksum: 0xB476EC16
	Offset: 0x2EA0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_9fa5e527(var_ad86fdba = 5)
{
	var_bef9c0f = function_144a052b(self.archetype);
	switch(self.archetype)
	{
		case "catalyst":
		case "zombie":
		{
			self zombie_utility::set_zombie_run_cycle_override_value("walk");
			break;
		}
	}
	if(isdefined(var_bef9c0f))
	{
		self thread namespace_9ff9f642::slowdown(var_bef9c0f);
	}
	self ai::stun(var_ad86fdba);
}

/*
	Name: function_43f61cad
	Namespace: namespace_10f9f462
	Checksum: 0xCE738DE6
	Offset: 0x2F80
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_43f61cad()
{
	switch(self.archetype)
	{
		case "zombie":
		{
			self zombie_utility::set_zombie_run_cycle_restore_from_override();
			break;
		}
		case "catalyst":
		case "tiger":
		{
			self zombie_utility::set_zombie_run_cycle_restore_from_override();
			break;
		}
		case "gladiator":
		case "blight_father":
		case "elephant":
		{
		}
	}
	var_45ba344f = function_144a052b(self.archetype);
	self namespace_9ff9f642::function_520f4da5(var_45ba344f);
	self ai::function_62795e55();
}

/*
	Name: function_e43d1b24
	Namespace: namespace_10f9f462
	Checksum: 0x67CB818F
	Offset: 0x3088
	Size: 0x11E
	Parameters: 0
	Flags: Linked
*/
function function_e43d1b24()
{
	switch(self.archetype)
	{
		case "zombie":
		{
			str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
			break;
		}
		case "tiger":
		{
			str_scene = "aib_t8_zm_tiger_dth_ww_xbow";
			break;
		}
		case "catalyst":
		{
			str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
			break;
		}
		case "stoker":
		{
			str_scene = "aib_t8_zm_stoker_dth_ww_xbow";
			break;
		}
		case "gladiator":
		{
			str_scene = "aib_t8_zm_gladiator_dth_ww_xbow";
			break;
		}
		case "blight_father":
		{
			str_scene = "aib_t8_zm_blightfather_dth_ww_xbow";
			break;
		}
		case "elephant":
		{
			str_scene = undefined;
			break;
		}
		default:
		{
			str_scene = "aib_t8_zm_zombie_base_dth_ww_xbow";
			break;
		}
	}
	return str_scene;
}

/*
	Name: function_b3ac0cab
	Namespace: namespace_10f9f462
	Checksum: 0x9F57CCDA
	Offset: 0x31B0
	Size: 0x3D2
	Parameters: 1
	Flags: Linked
*/
function function_b3ac0cab(params)
{
	if(!function_a2c527e5(params.weapon))
	{
		switch(self.archetype)
		{
			case "zombie":
			{
				var_a3abe438 = 1;
				var_a7727af5 = 2;
				break;
			}
			case "tiger":
			{
				var_a3abe438 = 1;
				var_a7727af5 = 2;
				break;
			}
			case "catalyst":
			{
				var_a3abe438 = 0.5;
				var_a7727af5 = 1;
				break;
			}
			case "stoker":
			case "gladiator":
			{
				var_a3abe438 = 0.25;
				var_a7727af5 = 1;
				break;
			}
			case "blight_father":
			{
				var_a3abe438 = 0.2;
				var_a7727af5 = 1;
				break;
			}
			case "elephant":
			{
				var_a3abe438 = 0.1;
				var_a7727af5 = 1;
				break;
			}
			default:
			{
				var_a3abe438 = 1;
				var_a7727af5 = 1;
				break;
			}
		}
	}
	else
	{
		switch(self.archetype)
		{
			case "zombie":
			{
				var_a3abe438 = 1;
				var_a7727af5 = 2;
				break;
			}
			case "tiger":
			{
				var_a3abe438 = 1;
				var_a7727af5 = 2;
				break;
			}
			case "catalyst":
			{
				var_a3abe438 = 1;
				var_a7727af5 = 2;
				break;
			}
			case "stoker":
			case "gladiator":
			{
				var_a3abe438 = 0.25;
				var_a7727af5 = 1;
				break;
			}
			case "blight_father":
			{
				var_a3abe438 = 0.25;
				var_a7727af5 = 1;
				break;
			}
			case "elephant":
			{
				var_a3abe438 = 0.2;
				var_a7727af5 = 1;
				break;
			}
			default:
			{
				var_a3abe438 = 1;
				var_a7727af5 = 1;
				break;
			}
		}
	}
	/#
		if(!isdefined(self.maxhealth) && isdefined(self.archetype))
		{
			iprintlnbold(("" + function_9e72a96(self.archetype)) + "");
		}
	#/
	n_damage = 0;
	if(level.round_number <= 23 && isdefined(self.maxhealth))
	{
		n_damage = int(self.maxhealth * var_a3abe438);
	}
	else if(isdefined(self.maxhealth))
	{
		var_56334cba = var_a3abe438 - (((level.round_number - 23) * var_a7727af5) / 100);
		var_56334cba = math::clamp(var_56334cba, 0.01, 1);
		n_damage = int(self.maxhealth * var_56334cba);
	}
	return n_damage;
}

/*
	Name: function_62d37304
	Namespace: namespace_10f9f462
	Checksum: 0xC760D5A4
	Offset: 0x3590
	Size: 0x2F4
	Parameters: 1
	Flags: Linked
*/
function function_62d37304(weapon)
{
	self notify("49b4d856fccf9e75");
	self endon("49b4d856fccf9e75");
	self endon(#"disconnect");
	if(function_c6da1395(weapon, self))
	{
		self clientfield::increment("" + #"hash_6c3560ab45e186ec");
	}
	if(level flagsys::get(#"hash_cad6742c753621"))
	{
		v_start = self getweaponmuzzlepoint();
		v_end = v_start + (self getweaponforwarddir() * 1000);
		s_trace = bullettrace(v_start, v_end, 0, self);
		level notify(#"hash_1720dddfc9bf0b2f", {#position:s_trace[#"position"], #player:self});
	}
	if(isarray(self.weaponobjectwatcherarray))
	{
		foreach(var_5f7ab57f in self.weaponobjectwatcherarray)
		{
			if(!is_crossbow(var_5f7ab57f.weapon))
			{
				continue;
			}
			if(var_5f7ab57f.onfizzleout === (&function_74106de1))
			{
				continue;
			}
			var_5f7ab57f.onfizzleout = &function_74106de1;
		}
	}
	if(function_c6da1395(weapon, self))
	{
		var_57b07826 = function_d8effeda(weapon);
		var_510d7f2b = self getweaponammostock(var_57b07826) - 4;
		var_510d7f2b = math::clamp(var_510d7f2b, 0, var_57b07826.maxammo);
		n_ammo_clip = self getweaponammoclip(var_57b07826);
		self setweaponammostock(var_57b07826, var_510d7f2b);
	}
}

/*
	Name: function_b0477b86
	Namespace: namespace_10f9f462
	Checksum: 0x47BE5566
	Offset: 0x3890
	Size: 0x5E
	Parameters: 3
	Flags: Linked
*/
function function_b0477b86(player, mod, shitloc)
{
	var_fb9dfd01 = player getcurrentweapon();
	if(is_crossbow(var_fb9dfd01))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_9eed975c
	Namespace: namespace_10f9f462
	Checksum: 0xE10EF1E3
	Offset: 0x38F8
	Size: 0x30
	Parameters: 5
	Flags: Linked
*/
function function_9eed975c(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 50;
}

/*
	Name: function_9d9c8bc2
	Namespace: namespace_10f9f462
	Checksum: 0xAA86FC84
	Offset: 0x3930
	Size: 0x30
	Parameters: 5
	Flags: Linked
*/
function function_9d9c8bc2(event, mod, hit_location, zombie_team, damage_weapon)
{
	return 20;
}

