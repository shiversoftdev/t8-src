// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_35598499769dbb3d;
#using script_460f2e04fb3cff8a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_d7d6f390;

/*
	Name: function_89f2df9
	Namespace: namespace_d7d6f390
	Checksum: 0xB88A1691
	Offset: 0x1B0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_72db755dcbd0602c", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_d7d6f390
	Checksum: 0xCC0CD54B
	Offset: 0x1F8
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(getdvarint(#"hash_49ef5478510b5af3", 0))
	{
		function_37c0d395();
		namespace_9ff9f642::register_slowdown(#"hash_5d9e1ae933ad6f87", 0.7, 3);
		namespace_9ff9f642::register_slowdown(#"hash_63a208b609d3fa87", 0.8, 3);
	}
}

/*
	Name: function_37c0d395
	Namespace: namespace_d7d6f390
	Checksum: 0xB3D848C6
	Offset: 0x2A0
	Size: 0x254
	Parameters: 0
	Flags: Linked
*/
function function_37c0d395()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"hash_36b9957a693185ea", #"hash_6fac30b31b5bec64", 4000, #"hash_3d4a42f8dbfe314f", getweapon("zombie_perk_bottle_zombshell"), getweapon("zombie_perk_totem_zombshell"), #"hash_49c28f0b2a623fa5");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"hash_36b9957a693185ea", #"hash_6fac30b31b5bec64", 4000, #"hash_4232a40e928b8f51", getweapon("zombie_perk_bottle_zombshell"), getweapon("zombie_perk_totem_zombshell"), #"hash_49c28f0b2a623fa5");
	}
	zm_perks::register_perk_clientfields(#"hash_36b9957a693185ea", &function_137d1be7, &function_1ab3592a);
	zm_perks::register_perk_threads(#"hash_36b9957a693185ea", &function_a639586f, &function_7328ce94, &function_9227a4d8);
	zm_perks::function_430970f6(#"hash_36b9957a693185ea", &function_65a90069);
	if(isdefined(level.var_241ad22d) && level.var_241ad22d)
	{
		level thread [[level.var_241ad22d]]();
	}
	callback::on_ai_killed(&on_ai_killed);
	callback::function_74872db6(&function_74872db6);
}

/*
	Name: function_137d1be7
	Namespace: namespace_d7d6f390
	Checksum: 0x8FD61BDD
	Offset: 0x500
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_137d1be7()
{
	clientfield::register("scriptmover", "" + #"hash_7199d465a80b4f59", 15000, 1, "int");
	clientfield::register("toplayer", "" + #"hash_5f545b88ba3e2938", 15000, 1, "int");
	clientfield::register("actor", "" + #"zombshell_explosion", 15000, 1, "counter");
}

/*
	Name: function_1ab3592a
	Namespace: namespace_d7d6f390
	Checksum: 0xD62CCB6
	Offset: 0x5D0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_1ab3592a(state)
{
}

/*
	Name: function_a639586f
	Namespace: namespace_d7d6f390
	Checksum: 0xD7E72E0D
	Offset: 0x5E8
	Size: 0x102
	Parameters: 0
	Flags: Linked
*/
function function_a639586f()
{
	self endon(#"disconnect", #"hash_36b9957a693185ea" + "_take");
	self.var_849c3bcf = zm_perks::function_c1efcc57(#"hash_36b9957a693185ea");
	if(isdefined(self.var_69604b18) && self.var_69604b18 && isdefined(self.var_849c3bcf))
	{
		self zm_perks::function_2ac7579(self.var_849c3bcf, 2, #"hash_6fac30b31b5bec64");
	}
	if(!isdefined(self.var_69604b18))
	{
		self.var_69604b18 = 0;
	}
	if(!isdefined(self.var_491bd66d))
	{
		self.var_491bd66d = 1;
	}
	if(!isdefined(self.var_c0832831))
	{
		self.var_c0832831 = 15;
	}
}

/*
	Name: function_7328ce94
	Namespace: namespace_d7d6f390
	Checksum: 0xA06AED49
	Offset: 0x6F8
	Size: 0xE6
	Parameters: 4
	Flags: Linked
*/
function function_7328ce94(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_36b9957a693185ea" + "_take");
	self function_993d228c();
	if(isdefined(self.var_c153f587))
	{
		self.var_c153f587 delete();
	}
	/#
		assert(isdefined(self.var_849c3bcf), "");
	#/
	if(isdefined(self.var_849c3bcf))
	{
		self zm_perks::function_13880aa5(self.var_849c3bcf, 0, #"hash_6fac30b31b5bec64");
		self.var_849c3bcf = undefined;
	}
}

/*
	Name: on_ai_killed
	Namespace: namespace_d7d6f390
	Checksum: 0xDB283418
	Offset: 0x7E8
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function on_ai_killed(s_params)
{
	player = s_params.eattacker;
	if(isplayer(player) && player hasperk(#"hash_36b9957a693185ea") && s_params.shitloc !== "none")
	{
		n_chance = (player hasperk(#"hash_4c14ed37c4038671") ? 20 : 15);
		if(!isdefined(player.var_c153f587) && !player.var_69604b18 && math::cointoss(n_chance) && (isdefined(self.completed_emerging_into_playable_area) && self.completed_emerging_into_playable_area))
		{
			self.no_powerups = 1;
			self shell_explosion(player, s_params.weapon);
		}
	}
}

/*
	Name: shell_explosion
	Namespace: namespace_d7d6f390
	Checksum: 0x38030131
	Offset: 0x930
	Size: 0x38C
	Parameters: 2
	Flags: Linked
*/
function shell_explosion(e_attacker, w_weapon)
{
	e_attacker endon(#"disconnect", #"hash_36b9957a693185ea" + "_take");
	if(!isdefined(self))
	{
		e_attacker function_993d228c();
		return;
	}
	v_origin = self.origin + vectorscale((0, 0, 1), 20);
	self clientfield::increment("" + #"zombshell_explosion");
	if(!isdefined(e_attacker.var_c153f587))
	{
		e_attacker.var_c153f587 = util::spawn_model("tag_origin", v_origin);
	}
	e_attacker.var_c153f587.origin = v_origin;
	e_attacker.var_c153f587 clientfield::set("" + #"hash_7199d465a80b4f59", 1);
	a_enemies = getaiteamarray(#"axis");
	if(isdefined(self))
	{
		arrayremovevalue(a_enemies, self);
	}
	a_e_blasted_zombies = arraysortclosest(a_enemies, v_origin, 3, undefined, 128);
	foreach(zombie in a_e_blasted_zombies)
	{
		zombie zombie_death_gib(e_attacker, w_weapon);
		util::wait_network_frame();
	}
	physicsexplosionsphere(v_origin, 128, 0, 5, 500, 500);
	e_attacker thread function_4e547cfd(e_attacker.var_c153f587.origin);
	if(e_attacker hasperk(#"hash_4c14ed37c4038671"))
	{
		wait(8);
	}
	else
	{
		wait(8);
	}
	e_attacker.var_c153f587 clientfield::set("" + #"hash_7199d465a80b4f59", 0);
	e_attacker notify(#"hash_7199d465a80b4f59");
	e_attacker function_993d228c();
	e_attacker thread function_f32db45b(e_attacker.var_c0832831);
	e_attacker.var_491bd66d++;
	e_attacker.var_c0832831 = e_attacker.var_c0832831 + 15;
	wait(0.1);
	if(isdefined(e_attacker.var_c153f587))
	{
		e_attacker.var_c153f587 delete();
	}
}

/*
	Name: zombie_death_gib
	Namespace: namespace_d7d6f390
	Checksum: 0x86DAC6E8
	Offset: 0xCC8
	Size: 0x114
	Parameters: 2
	Flags: Linked
*/
function zombie_death_gib(e_attacker, w_weapon)
{
	if(!isalive(self) || (isdefined(level.headshots_only) && level.headshots_only) || namespace_25f0796c::is_active())
	{
		return;
	}
	gibserverutils::gibhead(self);
	if(math::cointoss())
	{
		gibserverutils::gibleftarm(self);
	}
	else
	{
		gibserverutils::gibrightarm(self);
	}
	gibserverutils::giblegs(self);
	self dodamage(self.health, self.origin, e_attacker, e_attacker, "none", "MOD_EXPLOSIVE", 0, w_weapon);
}

/*
	Name: function_4e547cfd
	Namespace: namespace_d7d6f390
	Checksum: 0xD6745B94
	Offset: 0xDE8
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_4e547cfd(var_4eaa1f4c)
{
	self endon(#"death", #"hash_7199d465a80b4f59", #"scene_ready", #"hash_36b9957a693185ea" + "_take");
	while(true)
	{
		array::thread_all(level.activeplayers, &function_279e31b8, self);
		n_frame = self function_6b9dcec(var_4eaa1f4c);
		var_adaf2ccb = math::clamp(0.25 - n_frame * 0.05, 0.05, 0.25);
		if(!isdefined(var_adaf2ccb))
		{
			var_adaf2ccb = 0.25;
		}
		wait(var_adaf2ccb);
	}
}

/*
	Name: function_6b9dcec
	Namespace: namespace_d7d6f390
	Checksum: 0xD1902069
	Offset: 0xF08
	Size: 0x18A
	Parameters: 1
	Flags: Linked
*/
function function_6b9dcec(var_fc7bb684)
{
	self endon(#"death", #"hash_7199d465a80b4f59", #"hash_36b9957a693185ea" + "_take");
	a_enemies = getaiteamarray(#"axis");
	a_ai_zombies = arraysortclosest(a_enemies, var_fc7bb684, undefined, undefined, 128);
	a_ai_zombies = array::filter(a_ai_zombies, 0, &function_c3af2a78);
	n_count = 0;
	n_frames = 0;
	foreach(zombie in a_ai_zombies)
	{
		zombie function_17a24d7f(self);
		n_count++;
		if(n_count == 4)
		{
			waitframe(1);
			n_count = 0;
			n_frames++;
		}
	}
	return n_frames;
}

/*
	Name: function_c3af2a78
	Namespace: namespace_d7d6f390
	Checksum: 0x9DC9B410
	Offset: 0x10A0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function function_c3af2a78(ai_enemy)
{
	b_callback_result = 1;
	if(isdefined(level.var_35b2b6d3))
	{
		b_callback_result = [[level.var_35b2b6d3]](ai_enemy);
	}
	return b_callback_result;
}

/*
	Name: function_17a24d7f
	Namespace: namespace_d7d6f390
	Checksum: 0x6751E10B
	Offset: 0x10F0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function function_17a24d7f(e_player)
{
	e_player endon(#"death", #"hash_7199d465a80b4f59");
	if(isalive(self) && isdefined(self.var_6f84b820))
	{
		if(isalive(self) && isactor(self) && (!(isdefined(self.var_36c260a2) && self.var_36c260a2)) && !self function_dd070839())
		{
			self thread function_a8e6f773();
		}
	}
}

/*
	Name: function_a8e6f773
	Namespace: namespace_d7d6f390
	Checksum: 0xB92A9AC
	Offset: 0x11D0
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_a8e6f773(n_time = 3)
{
	self endon(#"death");
	self notify("1d4b84eee4e87828");
	self endon("1d4b84eee4e87828");
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	self.var_36c260a2 = 1;
	if(self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"miniboss")
	{
		self thread namespace_9ff9f642::slowdown(#"hash_63a208b609d3fa87");
	}
	else
	{
		self thread namespace_9ff9f642::slowdown(#"hash_5d9e1ae933ad6f87");
	}
	wait(n_time);
	self.var_36c260a2 = undefined;
}

/*
	Name: function_65a90069
	Namespace: namespace_d7d6f390
	Checksum: 0x33BD6860
	Offset: 0x12E0
	Size: 0xB0
	Parameters: 12
	Flags: Linked
*/
function function_65a90069(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(isdefined(self.var_36c260a2) && self.var_36c260a2)
	{
		n_damage = int(damage * 1.25);
		return n_damage;
	}
	return damage;
}

/*
	Name: function_279e31b8
	Namespace: namespace_d7d6f390
	Checksum: 0xA5BAB504
	Offset: 0x1398
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function function_279e31b8(e_owner)
{
	self notify("b24e157aae48642");
	self endon("b24e157aae48642");
	self endon_callback(&function_26c2620, #"death", #"hash_7199d465a80b4f59", #"scene_ready", #"hash_36b9957a693185ea" + "_take");
	var_bbf6e7fd = 16384;
	var_fc7bb684 = e_owner.var_c153f587.origin;
	while(isdefined(e_owner.var_c153f587) && distancesquared(self.origin, var_fc7bb684) < var_bbf6e7fd && self hasperk(#"hash_4c14ed37c4038671"))
	{
		if(!isdefined(self.var_9c1c5b59))
		{
			self val::set(#"hash_6fac30b31b5bec64", "ignoreme");
			self clientfield::set_to_player("" + #"hash_5f545b88ba3e2938", 1);
			self.var_9c1c5b59 = 1;
		}
		wait(0.5);
	}
	if(isdefined(self.var_9c1c5b59) && self.var_9c1c5b59)
	{
		self function_993d228c();
	}
}

/*
	Name: function_993d228c
	Namespace: namespace_d7d6f390
	Checksum: 0x99FAD648
	Offset: 0x1558
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function function_993d228c()
{
	self val::reset(#"hash_6fac30b31b5bec64", "ignoreme");
	self clientfield::set_to_player("" + #"hash_5f545b88ba3e2938", 0);
	self.var_9c1c5b59 = undefined;
}

/*
	Name: function_26c2620
	Namespace: namespace_d7d6f390
	Checksum: 0xF79C69E9
	Offset: 0x15C0
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_26c2620(str_notify)
{
	if(str_notify === "scene_ready")
	{
		self function_993d228c();
	}
}

/*
	Name: function_f32db45b
	Namespace: namespace_d7d6f390
	Checksum: 0x30DD518C
	Offset: 0x1600
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function function_f32db45b(var_85dcb56c)
{
	self endon(#"hash_4aaf55c36b37725e", #"disconnect");
	self.var_69604b18 = 1;
	if(self hasperk(#"hash_36b9957a693185ea") && isdefined(self.var_849c3bcf))
	{
		self zm_perks::function_2ac7579(self.var_849c3bcf, 2, #"hash_6fac30b31b5bec64");
	}
	self thread function_7d72c6f9(var_85dcb56c);
	wait(var_85dcb56c);
	self thread function_9227a4d8();
}

/*
	Name: function_7d72c6f9
	Namespace: namespace_d7d6f390
	Checksum: 0xBF56AA91
	Offset: 0x16D8
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_7d72c6f9(var_85dcb56c)
{
	self endon(#"disconnect", #"hash_4aaf55c36b37725e");
	self.var_fc63c7bc = var_85dcb56c;
	self zm_perks::function_13880aa5(self.var_849c3bcf, 0, #"hash_6fac30b31b5bec64");
	while(true)
	{
		wait(0.1);
		self.var_fc63c7bc = self.var_fc63c7bc - 0.1;
		self.var_fc63c7bc = math::clamp(self.var_fc63c7bc, 0, var_85dcb56c);
		n_percentage = 1 - self.var_fc63c7bc / var_85dcb56c;
		n_percentage = math::clamp(n_percentage, 0.02, var_85dcb56c);
		if(self hasperk(#"hash_36b9957a693185ea") && isdefined(self.var_849c3bcf))
		{
			self zm_perks::function_13880aa5(self.var_849c3bcf, n_percentage, #"hash_6fac30b31b5bec64");
		}
	}
}

/*
	Name: function_9227a4d8
	Namespace: namespace_d7d6f390
	Checksum: 0x9CF717AE
	Offset: 0x1840
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_9227a4d8()
{
	self notify(#"hash_4aaf55c36b37725e");
	self.var_69604b18 = 0;
	if(self hasperk(#"hash_36b9957a693185ea"))
	{
		/#
			assert(isdefined(self.var_849c3bcf), "");
		#/
		if(isdefined(self.var_849c3bcf))
		{
			self zm_perks::function_2ac7579(self.var_849c3bcf, 1, #"hash_6fac30b31b5bec64");
			self zm_perks::function_13880aa5(self.var_849c3bcf, 1, #"hash_6fac30b31b5bec64");
		}
	}
}

/*
	Name: function_74872db6
	Namespace: namespace_d7d6f390
	Checksum: 0xABCAFB3D
	Offset: 0x1928
	Size: 0x8A
	Parameters: 0
	Flags: Linked
*/
function function_74872db6()
{
	a_players = getplayers();
	foreach(player in a_players)
	{
		player.var_c0832831 = 15;
	}
}

