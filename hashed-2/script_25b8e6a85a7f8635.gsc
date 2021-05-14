// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_white_util.gsc;
#using scripts\zm_common\zm_pack_a_punch.gsc;
#using scripts\zm_common\zm_pack_a_punch_util.gsc;
#using scripts\zm_common\zm_perks.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;

#namespace namespace_9efb8d22;

/*
	Name: init
	Namespace: namespace_9efb8d22
	Checksum: 0xC3B510A
	Offset: 0x248
	Size: 0xFC
	Parameters: 0
	Flags: None
*/
function init()
{
	init_fx();
	level._no_vending_machine_auto_collision = 1;
	level thread function_68792ab6();
	level.zombiemode_reusing_pack_a_punch = 1;
	level.var_ef785c4c = 0;
	level.pack_a_punch.custom_power_think = &function_9b917fd5;
	zm_pap_util::function_11fdb083(32);
	clientfield::register("scriptmover", "" + #"hash_28b770e7e782837", 1, 1, "int");
	level thread function_834ab8cc();
	level thread function_ee662714();
}

/*
	Name: init_fx
	Namespace: namespace_9efb8d22
	Checksum: 0xC44B7F2C
	Offset: 0x350
	Size: 0x92
	Parameters: 0
	Flags: Linked
*/
function init_fx()
{
	level._effect[#"hash_7866a63fde6b972d"] = #"hash_2edb406c045a5b80";
	level._effect[#"hash_774d000cf6ac79ec"] = #"hash_2eb17822848d1484";
	level._effect[#"hash_498a1ea189a3ea3b"] = #"hash_4d4ecfd7d55314e9";
}

/*
	Name: function_48acb6ed
	Namespace: namespace_9efb8d22
	Checksum: 0x39AC8012
	Offset: 0x3F0
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function function_48acb6ed(position)
{
	playrumbleonposition(#"zm_white_perk_impact", position);
	playrumbleonposition(#"zm_white_perk_aftershock", position);
}

/*
	Name: function_9b917fd5
	Namespace: namespace_9efb8d22
	Checksum: 0xDBD7ADDE
	Offset: 0x448
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_9b917fd5(is_powered)
{
	level flag::wait_till("power_on5");
	self zm_pack_a_punch::function_bb629351(1);
	exploder::exploder("fxexp_script_pap_lgt");
}

/*
	Name: function_68792ab6
	Namespace: namespace_9efb8d22
	Checksum: 0x451E6EBF
	Offset: 0x4B0
	Size: 0x1DE
	Parameters: 0
	Flags: Linked
*/
function function_68792ab6()
{
	level.var_1594a906 = array(0, 1, 2, 3, 4);
	function_cb235436();
	var_c43b94a8 = [];
	var_c43b94a8[0] = randomintrange(3, 5);
	var_c43b94a8[1] = randomintrange(6, 9);
	var_c43b94a8[2] = randomintrange(10, 14);
	var_c43b94a8[3] = randomintrange(15, 19);
	var_c43b94a8[4] = randomintrange(20, 25);
	level waittill(#"all_players_spawned");
	/#
		level.var_e8d9c0d1 = 0;
	#/
	for(i = 0; i < 5; i++)
	{
		while(level.round_number < var_c43b94a8[i])
		{
			/#
				if(level.var_e8d9c0d1)
				{
					break;
				}
			#/
			wait(1);
		}
		if(level.round_number == var_c43b94a8[i])
		{
			wait(randomintrange(10, 15));
		}
		function_99d6f707();
	}
}

/*
	Name: function_99d6f707
	Namespace: namespace_9efb8d22
	Checksum: 0xE5CDB8A4
	Offset: 0x698
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_99d6f707()
{
	/#
		iprintlnbold("");
	#/
	if(level.var_1594a906.size > 0)
	{
		function_22bf8bd4(level.var_1594a906[0]);
		level flag::set("power_on" + level.var_1594a906[0] + 1);
		arrayremoveindex(level.var_1594a906, 0);
	}
}

/*
	Name: function_834ab8cc
	Namespace: namespace_9efb8d22
	Checksum: 0x4DDAF676
	Offset: 0x750
	Size: 0x140
	Parameters: 0
	Flags: Linked
*/
function function_834ab8cc()
{
	level flag::wait_till("all_players_spawned");
	var_b80f0510 = getentarray("zm_pack_a_punch", "targetname");
	foreach(var_a84febff in var_b80f0510)
	{
		var_a84febff zm_pack_a_punch::set_state_hidden();
	}
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		var_5baafbb2 zm_perks::function_59fb56ff(0);
	}
}

/*
	Name: function_ee662714
	Namespace: namespace_9efb8d22
	Checksum: 0x131A4047
	Offset: 0x898
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_ee662714()
{
	level.var_9912ef7a = "p8_fxanim_zm_white_perk_machine_dummy_fly_in";
	level.var_dcd1e798 = getent("perk_machine_mover", "targetname");
	level.var_dcd1e798 useanimtree("generic");
}

/*
	Name: function_22bf8bd4
	Namespace: namespace_9efb8d22
	Checksum: 0x85074839
	Offset: 0x900
	Size: 0x278
	Parameters: 1
	Flags: Linked
*/
function function_22bf8bd4(var_3e311473)
{
	/#
		assert(isdefined(var_3e311473) && var_3e311473 > -1 && var_3e311473 < 5, "");
	#/
	if(var_3e311473 == 4)
	{
		var_5e879929 = getent("zm_pack_a_punch", "targetname");
		var_fc50707f = getentarray("zm_random_machine_blocker", "script_noteworthy");
		var_46d6340f = arraygetclosest(var_5e879929.origin, var_fc50707f);
		var_46d6340f thread function_da95f7();
		var_5e879929 function_71461330();
		var_90b2dbdd = "exp_lgt_pap_loc_" + var_5e879929.script_noteworthy;
		exploder::exploder(var_90b2dbdd);
		return;
	}
	foreach(var_5baafbb2 in level.var_76a7ad28)
	{
		/#
			assert(isdefined(var_5baafbb2.var_3468124), "");
		#/
		if(var_5baafbb2.var_3468124.script_int == var_3e311473)
		{
			var_fc50707f = getentarray("zm_random_machine_blocker", "script_noteworthy");
			var_46d6340f = arraygetclosest(var_5baafbb2.origin, var_fc50707f);
			var_46d6340f thread function_da95f7();
			exploder::exploder("fxexp_script_perk_lgt");
			var_5baafbb2 function_4204dba2();
		}
	}
}

/*
	Name: function_cb235436
	Namespace: namespace_9efb8d22
	Checksum: 0x71A19234
	Offset: 0xB80
	Size: 0xE6
	Parameters: 0
	Flags: Linked
*/
function function_cb235436()
{
	level.var_1594a906 = array::randomize(level.var_1594a906);
	var_f6f7a368 = 0;
	for(i = 0; i < level.var_1594a906.size; i++)
	{
		if(level.var_1594a906[i] == 4)
		{
			var_f6f7a368 = i;
		}
	}
	var_a09b22a8 = 2;
	if(var_f6f7a368 > var_a09b22a8)
	{
		var_16117a3d = level.var_1594a906[var_a09b22a8];
		level.var_1594a906[var_a09b22a8] = 4;
		level.var_1594a906[var_f6f7a368] = var_16117a3d;
	}
}

/*
	Name: function_da95f7
	Namespace: namespace_9efb8d22
	Checksum: 0x98357C30
	Offset: 0xC70
	Size: 0x5C
	Parameters: 0
	Flags: Linked
*/
function function_da95f7()
{
	wait(0.5);
	self clientfield::set("" + #"hash_28b770e7e782837", 1);
	wait(0.8);
	self delete();
}

/*
	Name: function_71461330
	Namespace: namespace_9efb8d22
	Checksum: 0x3F7F620C
	Offset: 0xCD8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_71461330()
{
	var_ebfeac73 = spawn("script_model", self.origin);
	var_ebfeac73.angles = self.angles;
	var_ebfeac73 setmodel("p7_zm_vending_packapunch");
	var_ebfeac73 hide();
	level.var_dcd1e798.origin = var_ebfeac73.origin;
	var_ebfeac73 linkto(level.var_dcd1e798, "tag_animate_origin");
	level.var_dcd1e798 thread animation::play(level.var_9912ef7a);
	waitframe(2);
	var_ebfeac73 show();
	wait(2);
	level thread function_48acb6ed(self.origin);
	var_ebfeac73 delete();
}

/*
	Name: function_4204dba2
	Namespace: namespace_9efb8d22
	Checksum: 0xEA8942ED
	Offset: 0xE08
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function function_4204dba2()
{
	var_b8055433 = self.var_3468124.var_73bd396b;
	var_2379bb0e = spawn("script_model", var_b8055433.origin);
	var_2379bb0e.angles = var_b8055433.angles;
	var_2379bb0e setmodel(var_b8055433.model);
	var_2379bb0e hide();
	level.var_dcd1e798.origin = var_2379bb0e.origin;
	var_2379bb0e linkto(level.var_dcd1e798, "tag_animate_origin");
	level.var_dcd1e798 thread animation::play(level.var_9912ef7a);
	waitframe(2);
	var_2379bb0e show();
	wait(2);
	level thread function_48acb6ed(var_b8055433.origin);
	self zm_perks::function_59fb56ff(1);
	var_2379bb0e delete();
}

