// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14f4a3c583c77d4b;
#using script_1b10fdf0addd52e;
#using script_30ba61ad5559c51d;
#using script_35598499769dbb3d;
#using script_387eab232fe22983;
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_467027ea7017462b;
#using script_4d000493c57bb851;
#using script_52c6c2d1a2ef1b46;
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_6e3c826b1814cab6;
#using script_79c9122f9058e8ba;
#using script_ab862743b3070a;
#using script_b761c44ab2e5b46;
#using script_c17220bc4d57fdd;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm\zm_mansion.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_bgb.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_melee_weapon.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_power.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_59d4913f;

/*
	Name: init
	Namespace: namespace_59d4913f
	Checksum: 0xE6E2E8E1
	Offset: 0x430
	Size: 0x3A4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("world", "" + #"hash_3b4f11e825b1f62b", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_300ef0a8a2afdab9", 8000, 3, "int");
	clientfield::register("world", "" + #"hash_300eefa8a2afd906", 8000, 3, "int");
	clientfield::register("world", "" + #"hash_300eeea8a2afd753", 8000, 3, "int");
	clientfield::register("world", "" + #"hash_300eeda8a2afd5a0", 8000, 3, "int");
	clientfield::register("world", "" + #"hash_155407a9010f2b23", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_70b438bea0135fc8", 8000, 3, "int");
	clientfield::register("scriptmover", "" + #"hash_693891d7b7f47419", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_c2169a9806df05e", 8000, 1, "int");
	clientfield::register("vehicle", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int");
	clientfield::register("actor", "" + #"hash_7a260c02e8c345c2", 8000, 1, "int");
	clientfield::register("world", "" + #"hash_5f0c4b68b2a6a75d", 16000, 1, "int");
	namespace_617a54f4::function_d8383812("ee_asf_altar", 8000, #"a_skeet_fink_charge", &function_123eb361, &function_9bb74431, 1);
	function_c739f755();
	level.var_6d66c4ba = getweapon(#"hash_19a4271a5452dc0b");
	level thread function_93bd3e32();
}

/*
	Name: function_c739f755
	Namespace: namespace_59d4913f
	Checksum: 0xF4C4BCDF
	Offset: 0x7E0
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function function_c739f755()
{
	namespace_ee206246::register(#"hash_331f9ba64e2c2478", #"step_1", #"hash_6be882382480789d", &function_ff75fde6, &function_ff3b1efd);
	namespace_ee206246::register(#"hash_331f9ba64e2c2478", #"step_2", #"hash_6be87f3824807384", &function_39e0636, &function_4fccc01f);
	namespace_ee206246::register(#"hash_331f9ba64e2c2478", #"step_3", #"hash_6be8803824807537", &function_15c82a8a, &function_62856590);
	namespace_ee206246::register(#"hash_331f9ba64e2c2478", #"step_4", #"hash_6be87d382480701e", &function_2879cfed, &function_354f0b24);
}

/*
	Name: function_93bd3e32
	Namespace: namespace_59d4913f
	Checksum: 0x251BDE7D
	Offset: 0x970
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_93bd3e32()
{
	level flagsys::wait_till("start_zombie_round_logic");
	clientfield::set("" + #"hash_3b4f11e825b1f62b", 1);
	foreach(s_unitrigger_stub in level.var_4fe2f84d[#"zblueprint_mansion_a_skeet_fink"])
	{
		s_unitrigger_stub.locked = 1;
	}
	level.var_5e01899a = array(1, 2, 3, 4);
	level.var_5e01899a = array::randomize(level.var_5e01899a);
	function_f2971bfd();
	level flag::wait_till(#"open_pap");
	namespace_ee206246::start(#"hash_331f9ba64e2c2478", 1);
}

/*
	Name: function_f2971bfd
	Namespace: namespace_59d4913f
	Checksum: 0x86BF7145
	Offset: 0xB08
	Size: 0x208
	Parameters: 1
	Flags: Linked
*/
function function_f2971bfd(var_2df73abb = 0)
{
	level.var_6d3c8378 = struct::get_array(#"hash_63f3e730a983218c", "targetname");
	if(!var_2df73abb)
	{
		level.var_6d3c8378 = array::randomize(level.var_6d3c8378);
	}
	foreach(n_index, var_d3018aec in level.var_6d3c8378)
	{
		switch(level.var_5e01899a[n_index])
		{
			case 1:
			{
				var_ca5e3125 = "p8_zm_man_carving_symbols_rock_03";
				break;
			}
			case 2:
			{
				var_ca5e3125 = "p8_zm_man_carving_symbols_rock_04";
				break;
			}
			case 3:
			{
				var_ca5e3125 = "p8_zm_man_carving_symbols_rock_01";
				break;
			}
			case 4:
			{
				var_ca5e3125 = "p8_zm_man_carving_symbols_rock_02";
				break;
			}
		}
		var_d3018aec.var_740e1e0e = util::spawn_model(var_ca5e3125, var_d3018aec.origin, var_d3018aec.angles);
		var_d3018aec.script_int = n_index;
		if(var_2df73abb)
		{
			var_d3018aec.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 2);
		}
	}
}

/*
	Name: function_ff75fde6
	Namespace: namespace_59d4913f
	Checksum: 0x2CBC6EE5
	Offset: 0xD18
	Size: 0x3F4
	Parameters: 1
	Flags: Linked
*/
function function_ff75fde6(var_a276c861)
{
	zm_melee_weapon::init(#"hash_19a4271a5452dc0b", #"hash_5e3608222071b688", undefined, "", undefined, "bowie", undefined);
	namespace_2ba51478::register_melee_weapon_for_level(#"hash_19a4271a5452dc0b");
	clientfield::set("" + #"hash_300ef0a8a2afdab9", level.var_5e01899a[0]);
	clientfield::set("" + #"hash_300eefa8a2afd906", level.var_5e01899a[1]);
	clientfield::set("" + #"hash_300eeea8a2afd753", level.var_5e01899a[2]);
	clientfield::set("" + #"hash_300eeda8a2afd5a0", level.var_5e01899a[3]);
	level.var_d5f74526 = util::spawn_model(#"tag_origin");
	level.var_6d3c8378 = array::sort_by_script_int(level.var_6d3c8378, 1);
	array::thread_all(level.var_6d3c8378, &function_abf0bf8c);
	if(!var_a276c861)
	{
		if(zm_utility::function_3bff983f())
		{
			while(true)
			{
				b_success = level.var_d5f74526 function_29a3aca4();
				wait(1);
				if(b_success)
				{
					break;
				}
				else
				{
					function_834e6f7();
					function_f2971bfd(1);
					level clientfield::set("" + #"hash_300ef0a8a2afdab9", level.var_5e01899a[0]);
					level clientfield::set("" + #"hash_300eefa8a2afd906", level.var_5e01899a[1]);
					level clientfield::set("" + #"hash_300eeea8a2afd753", level.var_5e01899a[2]);
					level clientfield::set("" + #"hash_300eeda8a2afd5a0", level.var_5e01899a[3]);
					level.var_6d3c8378 = array::sort_by_script_int(level.var_6d3c8378, 1);
					array::thread_all(level.var_6d3c8378, &function_abf0bf8c);
				}
			}
		}
		else
		{
			b_success = level.var_d5f74526 function_29a3aca4();
			wait(1);
			if(!b_success)
			{
				function_834e6f7();
				level waittill(#"forever");
			}
		}
	}
}

/*
	Name: function_ff3b1efd
	Namespace: namespace_59d4913f
	Checksum: 0x43C30968
	Offset: 0x1118
	Size: 0x24
	Parameters: 2
	Flags: Linked
*/
function function_ff3b1efd(var_a276c861, ended_early)
{
	function_834e6f7();
}

/*
	Name: function_abf0bf8c
	Namespace: namespace_59d4913f
	Checksum: 0xFDCC0692
	Offset: 0x1148
	Size: 0x1D6
	Parameters: 0
	Flags: Linked
*/
function function_abf0bf8c()
{
	self.var_740e1e0e endon(#"death");
	self.var_740e1e0e setcandamage(1);
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self.var_740e1e0e waittill(#"damage");
		if(isplayer(var_be17187b.attacker) && !namespace_2ba51478::is_offhand_weapon(var_be17187b.weapon))
		{
			if(isdefined(var_be17187b.position) && distancesquared(var_be17187b.position, self.origin) < 100)
			{
				level.var_d5f74526 notify(#"hash_5a5c7c802e5f3037", {#attacker:var_be17187b.attacker, #hash_740e1e0e:self.var_740e1e0e, #hash_c8407ea2:self.script_int});
				self.var_740e1e0e ghost();
				wait(1);
				if(isdefined(self.var_740e1e0e))
				{
					self.var_740e1e0e delete();
				}
				return;
			}
		}
		self.var_740e1e0e.health = 9999;
	}
}

/*
	Name: function_29a3aca4
	Namespace: namespace_59d4913f
	Checksum: 0xB7D520DF
	Offset: 0x1328
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function function_29a3aca4()
{
	self endon(#"death");
	for(var_1fc5672 = 0; var_1fc5672 < level.var_6d3c8378.size; var_1fc5672++)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_5a5c7c802e5f3037");
		if(var_be17187b.var_c8407ea2 !== var_1fc5672)
		{
			var_be17187b.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 2);
			playsoundatposition("zmb_sk_stones_dest", var_be17187b.var_740e1e0e.origin);
			return 0;
		}
		var_be17187b.var_740e1e0e clientfield::set("" + #"hash_693891d7b7f47419", 1);
		playsoundatposition("zmb_sk_stones_dest_correct", var_be17187b.var_740e1e0e.origin);
	}
	var_be17187b.attacker thread namespace_891c9bac::function_a2bd5a0c(#"hash_307199a2e20f6edc", 1);
	return 1;
}

/*
	Name: function_834e6f7
	Namespace: namespace_59d4913f
	Checksum: 0xE36451AF
	Offset: 0x1498
	Size: 0x158
	Parameters: 0
	Flags: Linked
*/
function function_834e6f7()
{
	clientfield::set("" + #"hash_300ef0a8a2afdab9", 0);
	clientfield::set("" + #"hash_300eefa8a2afd906", 0);
	clientfield::set("" + #"hash_300eeea8a2afd753", 0);
	clientfield::set("" + #"hash_300eeda8a2afd5a0", 0);
	foreach(var_d3018aec in level.var_6d3c8378)
	{
		if(isdefined(var_d3018aec.var_740e1e0e))
		{
			var_d3018aec.var_740e1e0e delete();
		}
		if(isdefined(var_d3018aec.t_damage))
		{
			var_d3018aec.t_damage delete();
		}
	}
}

/*
	Name: function_39e0636
	Namespace: namespace_59d4913f
	Checksum: 0xDD889A0
	Offset: 0x15F8
	Size: 0x424
	Parameters: 1
	Flags: Linked
*/
function function_39e0636(var_a276c861)
{
	level flag::init(#"hash_6df692c4073d421b");
	level clientfield::set("" + #"hash_155407a9010f2b23", 1);
	var_5378b24c = struct::get_array(#"hash_775ec130d95ad426", "targetname");
	var_5378b24c = array::sort_by_script_int(var_5378b24c, 1);
	foreach(var_293aacbe in var_5378b24c)
	{
		var_293aacbe thread function_6941c919();
	}
	if(!var_a276c861)
	{
		b_result = level.var_d5f74526 function_1dc8ad86();
		if(isdefined(b_result) && b_result)
		{
			var_f2dc13a0 = struct::get("a_skeet_fink_chunk_start", "targetname");
			var_ae18fb21 = struct::get("a_skeet_fink_chunk", "targetname");
			var_5901d1c9 = struct::get(var_ae18fb21.target, "targetname");
			var_d9d9f59c = util::spawn_model(#"hash_1a8e66a7966f8086", var_f2dc13a0.origin, var_f2dc13a0.angles);
			var_d9d9f59c moveto(var_ae18fb21.origin, 3.6, 3.6);
			var_d9d9f59c rotateto(var_ae18fb21.angles, 3.6, 3.6);
			wait(3.6 * 0.7);
			var_d9d9f59c playsound("zmb_sk_tree_branch_fall");
			wait(3.6 * 0.3);
			var_d9d9f59c clientfield::set("" + #"hash_486960f190957256", 1);
			playrumbleonposition("grenade_rumble", var_ae18fb21.origin);
			earthquake(0.5, 0.8, var_ae18fb21.origin, 512);
			var_ae18fb21.var_bbd0b2fb = spawn("trigger_radius_use", var_5901d1c9.origin, 0, 64, 72);
			var_ae18fb21.var_bbd0b2fb setcursorhint("HINT_NOICON");
			var_ae18fb21.var_bbd0b2fb triggerignoreteam();
			var_ae18fb21.var_bbd0b2fb setvisibletoall();
			var_ae18fb21.var_bbd0b2fb.var_d9d9f59c = var_d9d9f59c;
			if(!var_a276c861)
			{
				function_c4542a0c(var_ae18fb21.var_bbd0b2fb);
			}
		}
	}
}

/*
	Name: function_4fccc01f
	Namespace: namespace_59d4913f
	Checksum: 0xF3ABEA17
	Offset: 0x1A28
	Size: 0x1D4
	Parameters: 2
	Flags: Linked
*/
function function_4fccc01f(var_a276c861, ended_early)
{
	level clientfield::set("" + #"hash_155407a9010f2b23", 0);
	var_5378b24c = struct::get_array(#"hash_775ec130d95ad426", "targetname");
	foreach(var_293aacbe in var_5378b24c)
	{
		if(isdefined(var_293aacbe.t_damage))
		{
			var_293aacbe.t_damage delete();
		}
	}
	var_ae18fb21 = struct::get("a_skeet_fink_chunk", "targetname");
	if(isdefined(var_ae18fb21.var_bbd0b2fb))
	{
		if(isdefined(var_ae18fb21.var_bbd0b2fb.var_d9d9f59c))
		{
			var_ae18fb21.var_bbd0b2fb.var_d9d9f59c delete();
		}
	}
	if(isdefined(var_ae18fb21.var_bbd0b2fb))
	{
		var_ae18fb21.var_bbd0b2fb delete();
	}
	if(var_a276c861 || ended_early)
	{
		level flag::set(#"hash_6df692c4073d421b");
	}
}

/*
	Name: function_6941c919
	Namespace: namespace_59d4913f
	Checksum: 0x2C3574AF
	Offset: 0x1C08
	Size: 0x1D0
	Parameters: 0
	Flags: Linked
*/
function function_6941c919()
{
	self.t_damage = spawn("trigger_damage_new", self.origin, 0, 8, 8);
	self.t_damage endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self.t_damage waittill(#"damage");
		var_2af07147 = zm_weapons::get_base_weapon(var_be17187b.weapon);
		if(isplayer(var_be17187b.attacker))
		{
			if(var_2af07147 === level.var_1c0d76f8)
			{
				level.var_d5f74526 notify(#"hash_15ccd1fdda38284a", {#attacker:var_be17187b.attacker, #hash_c8407ea2:self.script_int});
			}
			else if(var_be17187b.weapon === var_54cae2d8 && var_be17187b.mod === "MOD_MELEE")
			{
				level.var_d5f74526 notify(#"hash_5f436e1bb5dc641d", {#attacker:var_be17187b.attacker, #hash_c8407ea2:self.script_int});
			}
		}
	}
}

/*
	Name: function_1dc8ad86
	Namespace: namespace_59d4913f
	Checksum: 0x871A1D92
	Offset: 0x1DE0
	Size: 0x186
	Parameters: 0
	Flags: Linked
*/
function function_1dc8ad86()
{
	self endon(#"death");
	var_1fc5672 = 0;
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"hash_15ccd1fdda38284a", #"hash_5f436e1bb5dc641d");
		if(var_be17187b._notify == #"hash_15ccd1fdda38284a")
		{
			if(var_be17187b.var_c8407ea2 == var_1fc5672)
			{
				var_1fc5672++;
				level clientfield::set("" + #"hash_70b438bea0135fc8", var_1fc5672);
				playsoundatposition("zmb_sk_tree_hit_knife", (-440, 4200, -415));
			}
		}
		else if(var_be17187b._notify == #"hash_5f436e1bb5dc641d")
		{
			if(var_be17187b.var_c8407ea2 == 0 && var_1fc5672 == 4)
			{
				playsoundatposition("zmb_sk_tree_hit_shield", (-440, 4200, -415));
				return 1;
			}
		}
	}
}

/*
	Name: function_c4542a0c
	Namespace: namespace_59d4913f
	Checksum: 0x5F745308
	Offset: 0x1F70
	Size: 0x124
	Parameters: 1
	Flags: Linked
*/
function function_c4542a0c(t_trig)
{
	level endon(#"end_game");
	t_trig endon(#"death");
	waitresult = undefined;
	waitresult = t_trig waittill(#"trigger");
	e_player = waitresult.activator;
	e_player playsound("zmb_sk_tree_pickup");
	level flag::set(#"hash_6df692c4073d421b");
	e_player thread namespace_891c9bac::function_a2bd5a0c(#"hash_191dec8da1ad1b1f", 1);
	if(isdefined(t_trig.var_d9d9f59c))
	{
		t_trig.var_d9d9f59c delete();
	}
	if(isdefined(t_trig))
	{
		t_trig delete();
	}
}

/*
	Name: function_15c82a8a
	Namespace: namespace_59d4913f
	Checksum: 0x85CC1CD
	Offset: 0x20A0
	Size: 0x39C
	Parameters: 1
	Flags: Linked
*/
function function_15c82a8a(var_a276c861)
{
	if(level flag::get(#"hash_6df692c4073d421b"))
	{
		var_4b9c76d7 = struct::get(#"a_skeet_fink_charge", "targetname");
		var_4b9c76d7.var_d9d9f59c = util::spawn_model(#"hash_1a8e66a7966f8086", var_4b9c76d7.origin, var_4b9c76d7.angles);
		var_4b9c76d7.var_d9d9f59c notsolid();
		var_4b9c76d7.var_d9d9f59c hide();
		var_fb11d383 = struct::get(var_4b9c76d7.target, "targetname");
		var_4b9c76d7.var_360ebd9f = spawn("trigger_radius_use", var_fb11d383.origin, 0, 64, 72);
		var_4b9c76d7.var_360ebd9f setcursorhint("HINT_NOICON");
		var_4b9c76d7.var_360ebd9f triggerignoreteam();
		var_4b9c76d7.var_360ebd9f setvisibletoall();
		level clientfield::set("" + #"hash_5f0c4b68b2a6a75d", 1);
		if(!var_a276c861)
		{
			waitresult = undefined;
			waitresult = var_4b9c76d7.var_360ebd9f waittill(#"trigger");
		}
		var_4b9c76d7.var_d9d9f59c show();
		playsoundatposition("zmb_sk_tree_branch_place", var_4b9c76d7.var_d9d9f59c.origin);
		level clientfield::set("" + #"hash_5f0c4b68b2a6a75d", 0);
		if(!var_a276c861)
		{
			level.var_f8babb50 = 0;
			namespace_617a54f4::function_3f808d3d("ee_asf_altar");
			if(zm_utility::function_3bff983f())
			{
				var_4b9c76d7 thread function_eb6f728f();
			}
			var_4b9c76d7 waittill(#"hash_20911f4af4e75472");
			var_4b9c76d7.var_d9d9f59c clientfield::set("" + #"hash_c2169a9806df05e", 1);
			waitresult = undefined;
			waitresult = var_4b9c76d7.var_360ebd9f waittill(#"trigger");
			var_4b9c76d7.var_d9d9f59c hide();
			var_4b9c76d7.var_d9d9f59c clientfield::set("" + #"hash_c2169a9806df05e", 0);
		}
	}
}

/*
	Name: function_eb6f728f
	Namespace: namespace_59d4913f
	Checksum: 0x3DB1E16C
	Offset: 0x2448
	Size: 0x12E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_eb6f728f()
{
	self endon(#"hash_20911f4af4e75472");
	while(true)
	{
		if(level flag::get("round_reset"))
		{
			level flag::wait_till_clear("round_reset");
			wait(7);
		}
		else if(namespace_11abec5a::is_active(var_6d66c4ba))
		{
			var_4205d575 = namespace_2fa8319f::function_853b43e8();
			if(var_4205d575 < 10)
			{
				ai = namespace_2fa8319f::function_74f25f8a(1);
				if(isdefined(ai))
				{
					ai zm_score::function_acaab828();
				}
			}
		}
		wait(1);
	}
}

/*
	Name: function_62856590
	Namespace: namespace_59d4913f
	Checksum: 0xADE1D65F
	Offset: 0x2580
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function function_62856590(var_a276c861, ended_early)
{
	var_4b9c76d7 = struct::get("a_skeet_fink_charge", "targetname");
	if(isdefined(var_4b9c76d7.var_d9d9f59c))
	{
		var_4b9c76d7.var_d9d9f59c delete();
	}
	if(isdefined(var_4b9c76d7.var_360ebd9f))
	{
		var_4b9c76d7.var_360ebd9f delete();
	}
	level thread function_ed59d8e4();
}

/*
	Name: function_123eb361
	Namespace: namespace_59d4913f
	Checksum: 0x204E4126
	Offset: 0x2638
	Size: 0x11C
	Parameters: 2
	Flags: Linked
*/
function function_123eb361(var_88206a50, ent)
{
	if(ent.archetype !== #"bat" && ent.archetype !== #"hash_50f4e0eea9f4e4a4")
	{
		return 0;
	}
	var_29d714d9 = struct::get(var_88206a50.target, "targetname");
	var_51e4bd8d = getent(var_29d714d9.target, "targetname");
	return isdefined(ent) && (isplayer(ent.attacker) || isplayer(ent.damageinflictor)) && ent istouching(var_51e4bd8d);
}

/*
	Name: function_9bb74431
	Namespace: namespace_59d4913f
	Checksum: 0x4F511198
	Offset: 0x2760
	Size: 0x60
	Parameters: 2
	Flags: Linked
*/
function function_9bb74431(var_f0e6c7a2, ent)
{
	level.var_f8babb50++;
	if(level.var_f8babb50 >= 10)
	{
		namespace_617a54f4::function_2a94055d("ee_asf_altar");
		var_f0e6c7a2 notify(#"hash_20911f4af4e75472");
	}
}

/*
	Name: function_ed59d8e4
	Namespace: namespace_59d4913f
	Checksum: 0x151AEA71
	Offset: 0x27C8
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_ed59d8e4()
{
	while(!isdefined(var_d9d51621))
	{
		a_players = util::get_active_players(#"allies");
		foreach(e_player in a_players)
		{
			if(zm_utility::can_use(e_player))
			{
				var_d9d51621 = e_player;
				break;
			}
		}
		waitframe(1);
	}
	namespace_93829f86::function_cf4e3354(var_d9d51621, getweapon(#"hash_4aa70c9036cc210e"));
}

/*
	Name: function_2879cfed
	Namespace: namespace_59d4913f
	Checksum: 0x8759E2A5
	Offset: 0x28D8
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_2879cfed(var_a276c861)
{
	if(level flag::get(#"hash_6df692c4073d421b"))
	{
		foreach(s_unitrigger_stub in level.var_4fe2f84d[#"zblueprint_mansion_a_skeet_fink"])
		{
			s_unitrigger_stub.locked = undefined;
		}
		zm::function_84d343d(#"hash_19a4271a5452dc0b", &namespace_60895c83::function_78f60fd5);
		zm::register_vehicle_damage_callback(&namespace_60895c83::function_293e7d89);
		namespace_a1d9b01d::function_d1f16587(#"zblueprint_mansion_a_skeet_fink", &function_36194a5f);
	}
}

/*
	Name: function_354f0b24
	Namespace: namespace_59d4913f
	Checksum: 0x400CD60E
	Offset: 0x2A10
	Size: 0x14
	Parameters: 2
	Flags: Linked
*/
function function_354f0b24(var_a276c861, ended_early)
{
}

/*
	Name: function_36194a5f
	Namespace: namespace_59d4913f
	Checksum: 0xD580754C
	Offset: 0x2A30
	Size: 0xC4
	Parameters: 1
	Flags: Linked
*/
function function_36194a5f(e_player)
{
	unitrigger_stub = self.stub;
	unitrigger_stub.model setmodel(#"hash_2bea3ece67482937");
	unitrigger_stub.model show();
	zm_unitrigger::unregister_unitrigger(unitrigger_stub);
	e_player thread function_db526700();
	unitrigger_stub.prompt_and_visibility_func = &function_7aa50bb7;
	zm_unitrigger::register_static_unitrigger(unitrigger_stub, &function_422acb4c);
}

/*
	Name: function_422acb4c
	Namespace: namespace_59d4913f
	Checksum: 0x9FDE5A8E
	Offset: 0x2B00
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_422acb4c()
{
	self endon(#"death");
	while(true)
	{
		var_be17187b = undefined;
		var_be17187b = self waittill(#"trigger");
		e_player = var_be17187b.activator;
		if(!e_player hasweapon(level.var_6d66c4ba))
		{
			e_player thread function_db526700();
		}
	}
}

/*
	Name: function_7aa50bb7
	Namespace: namespace_59d4913f
	Checksum: 0xF6A0B4B3
	Offset: 0x2BA0
	Size: 0xC0
	Parameters: 1
	Flags: Linked
*/
function function_7aa50bb7(e_player)
{
	self endon(#"death");
	can_use = zm_utility::can_use(e_player);
	can_use = can_use & !e_player hasweapon(level.var_6d66c4ba);
	if(can_use)
	{
		self sethintstring(self.stub.blueprint.var_391591d0);
	}
	else
	{
		self sethintstring("");
	}
	return can_use;
}

/*
	Name: function_db526700
	Namespace: namespace_59d4913f
	Checksum: 0x4ABCFC47
	Offset: 0x2C68
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_db526700()
{
	self thread namespace_891c9bac::function_a2bd5a0c(#"hash_445d4e233806a7cf", 1);
	self zm_melee_weapon::award_melee_weapon(#"hash_19a4271a5452dc0b");
}

