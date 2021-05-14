// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_2f9a68261f6a17be;
#using script_3f9e0dc8454d98e1;
#using script_6951ea86fdae9ae0;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_challenges.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_spawner.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a7cf6436;

/*
	Name: function_89f2df9
	Namespace: namespace_a7cf6436
	Checksum: 0x53692AE1
	Offset: 0x1C8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_2813a2fd40c93f23", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a7cf6436
	Checksum: 0xEEA25894
	Offset: 0x218
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_481123c();
}

/*
	Name: __main__
	Namespace: namespace_a7cf6436
	Checksum: 0x80F724D1
	Offset: 0x238
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_481123c
	Namespace: namespace_a7cf6436
	Checksum: 0xC5A07A75
	Offset: 0x248
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function function_481123c()
{
	if(function_8b1a219a())
	{
		zm_perks::register_perk_basic_info(#"specialty_phdflopper", #"hash_63e46074d37d524b", 4000, #"hash_1434e75516b9654c", getweapon("zombie_perk_bottle_slider"), getweapon("zombie_perk_totem_slider"), #"hash_402b9d6529500b72");
	}
	else
	{
		zm_perks::register_perk_basic_info(#"specialty_phdflopper", #"hash_63e46074d37d524b", 4000, #"hash_692a7dbdc35fb5e0", getweapon("zombie_perk_bottle_slider"), getweapon("zombie_perk_totem_slider"), #"hash_402b9d6529500b72");
	}
	zm_perks::register_perk_precache_func(#"specialty_phdflopper", &function_1781c013);
	zm_perks::register_perk_clientfields(#"specialty_phdflopper", &function_5ba17a72, &function_90f58801);
	zm_perks::register_perk_machine(#"specialty_phdflopper", &function_ef14badb, &function_15d03600);
	zm_perks::register_perk_host_migration_params(#"specialty_phdflopper", "p7_zm_vending_nuke", "divetonuke_light");
	zm_perks::register_perk_threads(#"specialty_phdflopper", &function_1d4d3034, &function_ae56fb1a, &function_1def7e);
	zm_perks::register_perk_damage_override_func(&function_9e712df);
}

/*
	Name: function_15d03600
	Namespace: namespace_a7cf6436
	Checksum: 0x80F724D1
	Offset: 0x4C0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_15d03600()
{
}

/*
	Name: function_1781c013
	Namespace: namespace_a7cf6436
	Checksum: 0xBD30E42A
	Offset: 0x4D0
	Size: 0xBE
	Parameters: 0
	Flags: Linked
*/
function function_1781c013()
{
	level.machine_assets[#"specialty_phdflopper"] = spawnstruct();
	level.machine_assets[#"specialty_phdflopper"].weapon = getweapon("zombie_perk_bottle_slider");
	level.machine_assets[#"specialty_phdflopper"].off_model = "p7_zm_vending_nuke";
	level.machine_assets[#"specialty_phdflopper"].on_model = "p7_zm_vending_nuke";
}

/*
	Name: function_5ba17a72
	Namespace: namespace_a7cf6436
	Checksum: 0xDDA411E5
	Offset: 0x598
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_5ba17a72()
{
	clientfield::register("allplayers", "" + #"hash_7b8ad0ed3ef67813", 1, 1, "counter");
}

/*
	Name: function_90f58801
	Namespace: namespace_a7cf6436
	Checksum: 0x16E9FF9
	Offset: 0x5E8
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function function_90f58801(state)
{
}

/*
	Name: function_ef14badb
	Namespace: namespace_a7cf6436
	Checksum: 0xBF01CA7C
	Offset: 0x600
	Size: 0xB6
	Parameters: 4
	Flags: Linked
*/
function function_ef14badb(use_trigger, perk_machine, bump_trigger, collision)
{
	use_trigger.script_sound = "mus_perks_phd_jingle";
	use_trigger.script_string = "divetonuke_perk";
	use_trigger.script_label = "mus_perks_phd_sting";
	use_trigger.target = "vending_divetonuke";
	perk_machine.script_string = "divetonuke_perk";
	perk_machine.targetname = "vending_divetonuke";
	if(isdefined(bump_trigger))
	{
		bump_trigger.script_string = "divetonuke_perk";
	}
}

/*
	Name: function_1d4d3034
	Namespace: namespace_a7cf6436
	Checksum: 0x628C4D52
	Offset: 0x6C0
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_1d4d3034()
{
	n_slot = zm_perks::function_c1efcc57(#"specialty_phdflopper");
	self zm_perks::function_f0ac059f(n_slot, 1, #"hash_63e46074d37d524b");
	self zm_perks::function_13880aa5(n_slot, 1, #"hash_63e46074d37d524b");
	self zm_perks::function_c8c7bc5(n_slot, 0, #"hash_63e46074d37d524b");
	self thread function_dc9a257a(n_slot);
}

/*
	Name: function_ae56fb1a
	Namespace: namespace_a7cf6436
	Checksum: 0xAEB9FD72
	Offset: 0x788
	Size: 0xAC
	Parameters: 4
	Flags: Linked
*/
function function_ae56fb1a(b_pause, str_perk, str_result, n_slot)
{
	self notify(#"hash_6939dd7af68cec");
	self zm_perks::function_f0ac059f(n_slot, 0, #"hash_63e46074d37d524b");
	self zm_perks::function_13880aa5(n_slot, 0, #"hash_63e46074d37d524b");
	self zm_perks::function_c8c7bc5(n_slot, 0, #"hash_63e46074d37d524b");
}

/*
	Name: function_dc9a257a
	Namespace: namespace_a7cf6436
	Checksum: 0x991A0269
	Offset: 0x840
	Size: 0x172
	Parameters: 1
	Flags: Linked
*/
function function_dc9a257a(n_slot)
{
	self notify(#"hash_6939dd7af68cec");
	self endon(#"disconnect", #"hash_6939dd7af68cec");
	self slide_explosion(n_slot);
	self.var_f354086e = 0;
	while(true)
	{
		self waittill(#"slide_begin");
		v_start_position = self.origin;
		self waittill(#"slide_end");
		n_distance = distance(v_start_position, self.origin);
		self.var_f354086e = self.var_f354086e + n_distance;
		self zm_perks::function_13880aa5(n_slot, min(1, self.var_f354086e / 550), #"hash_63e46074d37d524b");
		if(!function_2772480a())
		{
			continue;
		}
		if(self.var_f354086e >= 550)
		{
			self slide_explosion(n_slot);
			self.var_f354086e = 0;
		}
	}
}

/*
	Name: function_1def7e
	Namespace: namespace_a7cf6436
	Checksum: 0x6F7CC62
	Offset: 0x9C0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_1def7e()
{
	if(self hasperk(#"specialty_phdflopper"))
	{
		n_slot = zm_perks::function_c1efcc57(#"specialty_phdflopper");
		self zm_perks::function_13880aa5(n_slot, 1, #"hash_63e46074d37d524b");
		self thread function_dc9a257a(n_slot);
	}
}

/*
	Name: slide_explosion
	Namespace: namespace_a7cf6436
	Checksum: 0xABD3C17F
	Offset: 0xA58
	Size: 0x81A
	Parameters: 1
	Flags: Linked
*/
function slide_explosion(n_slot)
{
	self zm_perks::function_c8c7bc5(n_slot, 1, #"hash_63e46074d37d524b");
	while(true)
	{
		self waittill(#"slide_begin");
		if(!function_2772480a())
		{
			continue;
		}
		var_fd11502e = 1200;
		var_e9571d8b = self.var_e9571d8b;
		if(isdefined(var_e9571d8b))
		{
			var_fd11502e = var_fd11502e + var_e9571d8b * 6;
			var_fd11502e = int(var_fd11502e);
		}
		var_1574e1cf = [];
		while(self issliding())
		{
			var_fe40b467 = self function_bdda420f(self.origin, 80);
			var_a2bdc08a = vectornormalize(self getvelocity());
			var_1574e1cf = [];
			foreach(ai in var_fe40b467)
			{
				if(vectordot(var_a2bdc08a, vectornormalize(ai.origin - self.origin)) > 0.8)
				{
					if(!isdefined(var_1574e1cf))
					{
						var_1574e1cf = [];
					}
					else if(!isarray(var_1574e1cf))
					{
						var_1574e1cf = array(var_1574e1cf);
					}
					var_1574e1cf[var_1574e1cf.size] = ai;
				}
			}
			if(var_1574e1cf.size)
			{
				break;
			}
			waitframe(1);
		}
		if(isarray(var_1574e1cf) && var_1574e1cf.size)
		{
			a_ai = self function_bdda420f(self.origin, 256);
			a_ai = arraysortclosest(a_ai, self.origin);
			self clientfield::increment("" + #"hash_7b8ad0ed3ef67813");
			self zm_perks::function_13880aa5(n_slot, 0.05, #"hash_63e46074d37d524b");
			self zm_perks::function_c8c7bc5(n_slot, 0, #"hash_63e46074d37d524b");
			var_708c0444 = 0;
			n_kill_count = 0;
			foreach(ai in a_ai)
			{
				if(isdefined(ai.aioverridedamage))
				{
					for(index = 0; index < ai.aioverridedamage.size; index++)
					{
						damagecallback = ai.aioverridedamage[index];
						var_8b5b319c = ai [[damagecallback]](undefined, self, var_fd11502e, 0, "MOD_UNKNOWN", level.weaponnone, self.origin, undefined, "none");
					}
				}
				else
				{
					var_8b5b319c = var_fd11502e;
				}
				if(ai.health <= var_8b5b319c)
				{
					ai.marked_for_death = 1;
					var_c97aef2 = 1;
					if(isdefined(ai.fake_death) && ai.fake_death)
					{
						var_c97aef2 = 0;
					}
					if(var_708c0444 < 3 && var_c97aef2)
					{
						if(vectordot(anglestoforward(self.angles), vectornormalize(ai.origin - self.origin)) > 0.6)
						{
							n_kill_count++;
							var_708c0444++;
							ai.var_fc11268c = 1;
							v_fling = vectornormalize(ai.origin - self.origin) * 150;
							v_fling = (v_fling[0], v_fling[1], 75);
							ai zm_utility::function_ffc279(v_fling, self, var_fd11502e);
						}
					}
					/#
						self zm_challenges::debug_print("");
					#/
					self zm_stats::increment_challenge_stat(#"hash_76650a0cbe2993ad");
				}
			}
			foreach(ai in a_ai)
			{
				if(isalive(ai) && (!(isdefined(ai.var_fc11268c) && ai.var_fc11268c)))
				{
					ai dodamage(var_fd11502e, self.origin, self, undefined, "none", "MOD_UNKNOWN", 0, level.weaponnone);
					if(ai.health > 0)
					{
						if(ai.var_6f84b820 === #"heavy" || ai.var_6f84b820 === #"miniboss")
						{
							ai ai::stun();
						}
						else
						{
							ai zombie_utility::setup_zombie_knockdown(self);
						}
					}
					else if(ai.var_6f84b820 === #"basic" || ai.var_6f84b820 === #"enhanced")
					{
						n_kill_count++;
						ai zm_spawner::zombie_explodes_intopieces(0);
					}
					waitframe(1);
				}
			}
			if(isdefined(var_e9571d8b) && var_e9571d8b >= 120)
			{
				if(n_kill_count >= 10)
				{
					self zm_utility::giveachievement_wrapper("zm_trophy_doctor_is_in");
				}
			}
			return;
		}
	}
}

/*
	Name: function_2772480a
	Namespace: namespace_a7cf6436
	Checksum: 0xE8930744
	Offset: 0x1280
	Size: 0x90
	Parameters: 0
	Flags: Linked, Private
*/
private function function_2772480a()
{
	if(namespace_6b49f66b::is_active())
	{
		return 0;
	}
	if(namespace_fcd611c3::is_active() && level.var_e91491fb !== #"slide")
	{
		return 0;
	}
	if(namespace_b28d86fd::is_active())
	{
		return 0;
	}
	if(isdefined(level.var_8c018a0e) && level.var_8c018a0e)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_9e712df
	Namespace: namespace_a7cf6436
	Checksum: 0xE971F5B6
	Offset: 0x1318
	Size: 0xEC
	Parameters: 10
	Flags: Linked
*/
function function_9e712df(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime)
{
	if(self hasperk(#"specialty_phdflopper"))
	{
		if(zm_utility::is_explosive_damage(smeansofdeath))
		{
			if(isplayer(eattacker) || isplayer(einflictor))
			{
				return 0;
			}
			return int(idamage * 0.5);
		}
	}
}

