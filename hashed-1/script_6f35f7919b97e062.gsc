// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3e5ec44cfab7a201;
#using script_3f9e0dc8454d98e1;
#using script_421e0a3702e22de;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using script_6ce38ab036223e6e;
#using script_ab862743b3070a;
#using script_db06eb511bd9b36;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_player.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_55999fe;

/*
	Name: preload
	Namespace: namespace_55999fe
	Checksum: 0x843DA4D5
	Offset: 0x3B0
	Size: 0x144
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	namespace_617a54f4::function_d8383812(#"little_bird_1", 24000, "little_bird_1", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"little_bird_2", 24000, "little_bird_2", &function_8598f0d4, &function_3bdbb583, 1);
	namespace_617a54f4::function_d8383812(#"little_bird_3", 24000, "little_bird_3", &function_8598f0d4, &function_3bdbb583, 1);
	clientfield::register("scriptmover", "elemental_shard_glow", 24000, 1, "int");
	level flag::init(#"hash_4923165da58bf5cf");
}

/*
	Name: main
	Namespace: namespace_55999fe
	Checksum: 0x723E7A27
	Offset: 0x500
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level init_transformers();
	level function_6bd2a719();
	level function_808135c6();
}

/*
	Name: function_808135c6
	Namespace: namespace_55999fe
	Checksum: 0x85F1D13F
	Offset: 0x558
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_808135c6()
{
	level.var_c1c9ddc = struct::get("tin_foil", "targetname");
	level.var_c1c9ddc.e_model = getent(level.var_c1c9ddc.target, "targetname");
	level.var_c1c9ddc.e_model hide();
}

/*
	Name: init_transformers
	Namespace: namespace_55999fe
	Checksum: 0xC8AA132A
	Offset: 0x5E8
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function init_transformers()
{
	level.var_d02bca0 = 2;
	level flag::init(#"hash_5630cdbbb58f1b1e");
	level.var_9d5b2598 = getent("big_bird_wing_n", "targetname");
	level.var_e48733ef = getent("big_bird_wing_s", "targetname");
}

/*
	Name: function_6bd2a719
	Namespace: namespace_55999fe
	Checksum: 0x6056D0D4
	Offset: 0x678
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_6bd2a719()
{
	level.var_6b43507a = 3;
	var_f6b31a0f = struct::get_array("little_bird", "targetname");
	for(i = 0; i < var_f6b31a0f.size; i++)
	{
		var_f6b31a0f[i].var_7944be4a = 0;
		var_f6b31a0f[i].var_b9989e12 = hash(var_f6b31a0f[i].script_noteworthy);
		var_f6b31a0f[i].e_vol = getent(var_f6b31a0f[i].target, "targetname");
	}
	level.var_f6b31a0f = var_f6b31a0f;
	var_ee92bf8c = getent("chicken_nugget", "targetname");
	var_ee92bf8c playloopsound(#"hash_52058ae478647502");
	var_ee92bf8c setscale(0.5);
	var_ee92bf8c clientfield::set("elemental_shard_glow", 1);
}

/*
	Name: function_742dfdb5
	Namespace: namespace_55999fe
	Checksum: 0x9FEE2EC5
	Offset: 0x7F8
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function function_742dfdb5(var_a276c861)
{
	if(!var_a276c861)
	{
		level function_95dff91b();
		level.var_c1c9ddc.e_model show();
		if(level.var_98138d6b > 1)
		{
			wait(2);
			level.var_1c53964e namespace_509a75d1::function_6a0d675d("vox_fuse_lighthouse", 0, 0, 1);
		}
		level.var_9d5b2598 setcandamage(1);
		level.var_9d5b2598 val::set("mq_fuse_step", "allowDeath", 0);
		level.var_9d5b2598 thread function_d6a4619a();
		level.var_e48733ef setcandamage(1);
		level.var_e48733ef val::set("mq_fuse_step", "allowDeath", 0);
		level.var_e48733ef thread function_d6a4619a();
		while(level.var_d02bca0 > 0)
		{
			wait(1);
		}
		if(level.var_98138d6b > 1)
		{
			level.var_1c53964e namespace_509a75d1::function_6a0d675d("vox_fuse_partial_charge", 0, 0, 1);
		}
	}
}

/*
	Name: function_95dff91b
	Namespace: namespace_55999fe
	Checksum: 0xE69D2AD4
	Offset: 0x9B0
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_95dff91b()
{
	s_unitrigger = level.var_c1c9ddc zm_unitrigger::create("", 96);
	level.var_c1c9ddc function_afa2f621();
	level.var_c1c9ddc zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_afa2f621
	Namespace: namespace_55999fe
	Checksum: 0x168A563E
	Offset: 0xA30
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_afa2f621()
{
	var_bd1bdc73 = undefined;
	var_bd1bdc73 = self waittill(#"trigger_activated");
	playsoundatposition(#"hash_fdb4c0b271c6e36", self.origin);
}

/*
	Name: function_b6ef150d
	Namespace: namespace_55999fe
	Checksum: 0xAFD8DB5C
	Offset: 0xA90
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_b6ef150d()
{
	s_unitrigger = level.var_c1c9ddc zm_unitrigger::create("", 96);
	level.var_c1c9ddc door_think();
	level.var_c1c9ddc zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: door_think
	Namespace: namespace_55999fe
	Checksum: 0x85D789C7
	Offset: 0xB10
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function door_think()
{
	var_bd1bdc73 = undefined;
	var_bd1bdc73 = self waittill(#"trigger_activated");
	level function_206702d8();
	if(level.var_98138d6b > 1)
	{
		level.var_1c53964e thread namespace_509a75d1::function_6a0d675d("vox_shard_reveal", 0, 0, 1);
	}
}

/*
	Name: function_206702d8
	Namespace: namespace_55999fe
	Checksum: 0x646E5964
	Offset: 0xB98
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_206702d8()
{
	level flag::set(#"hash_778a2b8282d704f");
	e_door = getent("grover", "targetname");
	playsoundatposition("zmb_lighthouse_double_door", (-472, 1172, 315));
	e_door rotateyaw(148, 0.5, 0.1, 0.1);
	var_cee2ebbb = getent(e_door.target, "targetname");
	if(isdefined(var_cee2ebbb))
	{
		var_cee2ebbb delete();
	}
}

/*
	Name: function_16386d70
	Namespace: namespace_55999fe
	Checksum: 0x28F3717D
	Offset: 0xCA0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function function_16386d70()
{
	var_ee92bf8c = getent("chicken_nugget", "targetname");
	s_unitrigger = var_ee92bf8c zm_unitrigger::create("", 96);
	var_ee92bf8c function_c303e169();
	var_ee92bf8c zm_unitrigger::unregister_unitrigger(s_unitrigger);
}

/*
	Name: function_c303e169
	Namespace: namespace_55999fe
	Checksum: 0x9B6EB719
	Offset: 0xD30
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_c303e169()
{
	var_bd1bdc73 = undefined;
	var_bd1bdc73 = self waittill(#"trigger_activated");
	playsoundatposition(#"hash_2e9ec816b70bb70e", self.origin);
	self delete();
	level function_7512675b(var_bd1bdc73.e_who);
}

/*
	Name: function_7512675b
	Namespace: namespace_55999fe
	Checksum: 0xF7A0805B
	Offset: 0xDC8
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function function_7512675b(e_who)
{
	e_who namespace_3263198e::function_51b752a9("vox_shard_place", -1, 1, 0);
}

/*
	Name: function_d6a4619a
	Namespace: namespace_55999fe
	Checksum: 0xBEE2765F
	Offset: 0xE08
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_d6a4619a()
{
	while(!var_e9e6d25a)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		if(var_88706ea7.weapon.name === #"ww_tesla_sniper_t8" || var_88706ea7.weapon.name === #"ww_tesla_sniper_upgraded_t8")
		{
			if(self.targetname == "big_bird_wing_n")
			{
				exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
			}
			else
			{
				exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
			}
			self playsound(#"hash_47433d730d8027ed");
			e_target = getent(self.target, "targetname");
			level.var_d02bca0 = level.var_d02bca0 - 1;
			e_target hide();
			self setcandamage(0);
			var_e9e6d25a = 1;
		}
	}
}

/*
	Name: function_9e34b0d4
	Namespace: namespace_55999fe
	Checksum: 0x3FD11495
	Offset: 0xF88
	Size: 0x134
	Parameters: 2
	Flags: Linked
*/
function function_9e34b0d4(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
		exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
		level.var_9d5b2598 setcandamage(0);
		level.var_9d5b2598 hide();
		level.var_e48733ef setcandamage(0);
		level.var_e48733ef hide();
		level.var_d02bca0 = 0;
		level.var_c1c9ddc.e_model show();
	}
	else
	{
		wait(3);
		exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_left");
		exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_right");
	}
}

/*
	Name: function_c723e684
	Namespace: namespace_55999fe
	Checksum: 0xF1097FD4
	Offset: 0x10C8
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_c723e684(var_a276c861)
{
	if(!var_a276c861)
	{
		foreach(var_b4602d24 in level.var_f6b31a0f)
		{
			level thread namespace_617a54f4::function_3f808d3d(var_b4602d24.var_b9989e12);
		}
		while(level.var_6b43507a > 0)
		{
			wait(1);
		}
		if(level.var_98138d6b > 1)
		{
			level.var_1c53964e thread namespace_509a75d1::function_6a0d675d("vox_fuse_complete_charge", 0, 0, 1);
		}
		wait(3);
		level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_1");
		level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_2");
		level exploder::stop_exploder("fxexp_electric_arcs_fx_to_lighthouse_base_3");
		level function_b6ef150d();
		level function_16386d70();
	}
}

/*
	Name: function_8598f0d4
	Namespace: namespace_55999fe
	Checksum: 0xB07D2C04
	Offset: 0x1258
	Size: 0xE0
	Parameters: 2
	Flags: Linked
*/
function function_8598f0d4(var_88206a50, ent)
{
	if(isdefined(ent) && ent.var_9fde8624 === #"hash_1c5b32be3f2c9b67")
	{
		b_killed_by_player = isdefined(ent.attacker) && isplayer(ent.attacker) || (isdefined(ent.damageinflictor) && isplayer(ent.damageinflictor));
		var_e93788f1 = var_88206a50.e_vol;
		return b_killed_by_player && ent istouching(var_e93788f1);
	}
	return 0;
}

/*
	Name: function_3bdbb583
	Namespace: namespace_55999fe
	Checksum: 0xB3ED4B54
	Offset: 0x1340
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function function_3bdbb583(var_f0e6c7a2, ent)
{
	n_souls_required = 1;
	var_f0e6c7a2.var_7944be4a++;
	/#
		if(level flag::get(#"hash_6dcc421d5fbf8d22"))
		{
			var_f0e6c7a2.var_7944be4a = n_souls_required;
		}
	#/
	if(var_f0e6c7a2.var_7944be4a >= n_souls_required)
	{
		var_f0e6c7a2 function_a66f0de2();
	}
}

/*
	Name: function_a66f0de2
	Namespace: namespace_55999fe
	Checksum: 0x2E3959B7
	Offset: 0x13E0
	Size: 0x116
	Parameters: 0
	Flags: Linked
*/
function function_a66f0de2()
{
	switch(self.script_noteworthy)
	{
		case "little_bird_1":
		{
			level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_2");
			break;
		}
		case "little_bird_2":
		{
			level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_3");
			break;
		}
		case "little_bird_3":
		{
			level exploder::exploder("fxexp_electric_arcs_fx_to_lighthouse_base_1");
			break;
		}
	}
	namespace_617a54f4::function_2a94055d(self.var_b9989e12);
	playsoundatposition(#"hash_7cef2cb8d950a50", self.origin);
	level.var_6b43507a = level.var_6b43507a - 1;
	self notify(#"hash_1f9b852104ab2c13");
}

/*
	Name: function_3d5a45fb
	Namespace: namespace_55999fe
	Checksum: 0x3A6E8032
	Offset: 0x1500
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function function_3d5a45fb(var_a276c861, var_19e802fa)
{
	if(var_a276c861 || var_19e802fa)
	{
		level.var_6b43507a = 0;
		level function_206702d8();
		getent("chicken_nugget", "targetname") delete();
	}
}

