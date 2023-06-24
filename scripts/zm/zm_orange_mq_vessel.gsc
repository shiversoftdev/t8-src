// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm\zm_orange_ee_dynamite.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_mq_vessel;

/*
	Name: preload
	Namespace: zm_orange_mq_vessel
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
}

/*
	Name: main
	Namespace: zm_orange_mq_vessel
	Checksum: 0x7B107932
	Offset: 0x190
	Size: 0xA16
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"vessel_found");
	level flag::init(#"blood_hints");
	level.var_50e4c504 = [];
	var_bd588d2c = array::randomize(getentarray("mq_shubozzor", "targetname"));
	level.var_50e4c504 = arraycombine(level.var_50e4c504, var_bd588d2c, 0, 0);
	if(!isdefined(level.var_54d62431))
	{
		level.var_54d62431 = [];
	}
	else if(!isarray(level.var_54d62431))
	{
		level.var_54d62431 = array(level.var_54d62431);
	}
	level.var_54d62431[level.var_54d62431.size] = array::pop_front(var_bd588d2c);
	foreach(part in var_bd588d2c)
	{
		part hide();
	}
	var_6b7b4af3 = array::randomize(getentarray("mq_othna", "targetname"));
	level.var_50e4c504 = arraycombine(level.var_50e4c504, var_6b7b4af3, 0, 0);
	if(!isdefined(level.var_54d62431))
	{
		level.var_54d62431 = [];
	}
	else if(!isarray(level.var_54d62431))
	{
		level.var_54d62431 = array(level.var_54d62431);
	}
	level.var_54d62431[level.var_54d62431.size] = array::pop_front(var_6b7b4af3);
	foreach(part in var_6b7b4af3)
	{
		part hide();
	}
	var_3ca16bc7 = array::randomize(getentarray("mq_othnor", "targetname"));
	level.var_50e4c504 = arraycombine(level.var_50e4c504, var_3ca16bc7, 0, 0);
	if(!isdefined(level.var_54d62431))
	{
		level.var_54d62431 = [];
	}
	else if(!isarray(level.var_54d62431))
	{
		level.var_54d62431 = array(level.var_54d62431);
	}
	level.var_54d62431[level.var_54d62431.size] = array::pop_front(var_3ca16bc7);
	foreach(part in var_3ca16bc7)
	{
		part hide();
	}
	var_6e1e26c6 = array::randomize(getentarray("mq_arknar", "targetname"));
	level.var_50e4c504 = arraycombine(level.var_50e4c504, var_6e1e26c6, 0, 0);
	if(!isdefined(level.var_54d62431))
	{
		level.var_54d62431 = [];
	}
	else if(!isarray(level.var_54d62431))
	{
		level.var_54d62431 = array(level.var_54d62431);
	}
	level.var_54d62431[level.var_54d62431.size] = array::pop_front(var_6e1e26c6);
	foreach(part in var_6e1e26c6)
	{
		part hide();
	}
	var_8d21d8c4 = array::randomize(getentarray("mq_asteth", "targetname"));
	level.var_50e4c504 = arraycombine(level.var_50e4c504, var_8d21d8c4, 0, 0);
	if(!isdefined(level.var_54d62431))
	{
		level.var_54d62431 = [];
	}
	else if(!isarray(level.var_54d62431))
	{
		level.var_54d62431 = array(level.var_54d62431);
	}
	level.var_54d62431[level.var_54d62431.size] = array::pop_front(var_8d21d8c4);
	foreach(part in var_8d21d8c4)
	{
		part hide();
	}
	level.var_54d62431 = array::randomize(level.var_54d62431);
	for(i = 0; i < 2; i++)
	{
		part = array::pop_front(level.var_54d62431);
		part hide();
	}
	foreach(hint in level.var_54d62431)
	{
		hint hide();
	}
	var_8f36abbb = struct::get_array("mq_vessel_loc", "targetname");
	level.var_d6513b72 = array::random(var_8f36abbb);
	level.var_d6513b72.var_8ac20606 = getent(level.var_d6513b72.target, "targetname");
	level.var_d6513b72.var_8ac20606 hide();
	level.var_d6513b72.e_cover = getent(level.var_d6513b72.target2, "targetname");
	level.var_d6513b72.e_safe = getent(level.var_d6513b72.target3, "targetname");
	for(i = 0; i < var_8f36abbb.size; i++)
	{
		if(var_8f36abbb[i] != level.var_d6513b72)
		{
			var_8ac20606 = getent(var_8f36abbb[i].target, "targetname");
			var_8ac20606 delete();
		}
	}
}

/*
	Name: function_a5254494
	Namespace: zm_orange_mq_vessel
	Checksum: 0xC301AE82
	Offset: 0xBB0
	Size: 0x1D4
	Parameters: 1
	Flags: Linked
*/
function function_a5254494(var_5ea5c94d)
{
	zm_ui_inventory::function_7df6bb60(#"hash_2fbec633e5118bab", 2);
	if(!var_5ea5c94d)
	{
		level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_13b606b34fa64ed5", 0, 0, 1);
		level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_13b606b34fa64ed5", 1, 0, 1);
		level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_13b606b34fa64ed5", 2, 0, 1);
		level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_13b606b34fa64ed5", 3, 0, 1);
		level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_13b606b34fa64ed5", 4, 0, 1);
		foreach(hint in level.var_54d62431)
		{
			hint function_ede90521();
		}
		level thread function_a5fa6428();
		level waittill(#"vessel_found");
	}
}

/*
	Name: function_77e4073b
	Namespace: zm_orange_mq_vessel
	Checksum: 0xE78EF3B1
	Offset: 0xD90
	Size: 0x8C
	Parameters: 2
	Flags: Linked
*/
function function_77e4073b(var_5ea5c94d, ended_early)
{
	level flag::set(#"vessel_found");
	if(var_5ea5c94d || ended_early)
	{
		level.var_d6513b72.var_8ac20606 delete();
		level.var_d6513b72.e_cover delete();
	}
}

/*
	Name: function_ede90521
	Namespace: zm_orange_mq_vessel
	Checksum: 0x6173AA0
	Offset: 0xE28
	Size: 0x28C
	Parameters: 0
	Flags: Linked
*/
function function_ede90521()
{
	wait(2);
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("" + self.script_string);
				println("" + self.script_string);
			}
		}
	#/
	level.var_60b08c24.var_489c2917 = self.var_d1f4d20d;
	level.var_60b08c24 thread zm_audio::do_player_or_npc_playvox(self.script_string + "_apot_0");
	level flag::set(#"blood_hints");
	self clientfield::set("" + #"hash_60a7e5b79e8064a5", 1);
	self show();
	self zm_unitrigger::function_fac87205();
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold((("" + self.targetname) + "") + self.script_int);
				println((("" + self.targetname) + "") + self.script_int);
			}
		}
	#/
	self playsound("zmb_bodypart_pickup");
	level flag::clear(#"blood_hints");
	self util::delayed_delete(0.1);
}

/*
	Name: function_a5fa6428
	Namespace: zm_orange_mq_vessel
	Checksum: 0x4F8C8EF1
	Offset: 0x10C0
	Size: 0x1F4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_a5fa6428()
{
	level endon(#"end_game", #"vessel_found");
	wait(2);
	zm_hms_util::function_3c173d37();
	level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_33c988fee37ea6da", 0, 0, 1);
	level.var_60b08c24 zm_hms_util::function_6a0d675d(#"hash_33c988fee37ea6da", 1, 0, 1);
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("" + level.var_d6513b72.script_noteworthy);
				println("" + level.var_d6513b72.script_noteworthy);
			}
		}
	#/
	level.var_60b08c24 thread zm_hms_util::function_6a0d675d(level.var_d6513b72.script_noteworthy, -1, 0, 1);
	level.var_d6513b72.e_cover cover_think();
	level.var_d6513b72 zm_unitrigger::create(&zm_orange_ee_dynamite::function_2a27ccb9, 64);
	level.var_d6513b72 thread function_9c223c27();
}

/*
	Name: cover_think
	Namespace: zm_orange_mq_vessel
	Checksum: 0x37B92F97
	Offset: 0x12C0
	Size: 0x1B4
	Parameters: 0
	Flags: Linked, Private
*/
function private cover_think()
{
	level endon(#"end_game", #"vessel_found");
	self endon(#"death");
	trigger = getent(self.target, "targetname");
	while(true)
	{
		s_result = undefined;
		s_result = trigger waittill(#"damage");
		if(isplayer(s_result.attacker) && s_result.mod == "MOD_MELEE")
		{
			break;
		}
	}
	v_force = anglestoforward(self.angles);
	v_force = v_force * 0.2;
	self hide();
	if(isdefined(self.dyn) && !isdefined(self.var_f0d6ee1f))
	{
		self.var_f0d6ee1f = 1;
		createdynentandlaunch(self.dyn, self.origin, self.angles, self.origin, v_force);
		playsoundatposition(#"hash_1ff16e6eb6a9dfed", self.origin);
	}
}

/*
	Name: function_9c223c27
	Namespace: zm_orange_mq_vessel
	Checksum: 0x8FDAE675
	Offset: 0x1480
	Size: 0x1B4
	Parameters: 0
	Flags: Linked, Private
*/
function private function_9c223c27()
{
	level endon(#"end_game", #"vessel_found");
	self endon(#"death");
	self.var_8ac20606 show();
	self zm_orange_ee_dynamite::function_170afe2c(1);
	self waittill(#"hash_126c823a82e09010");
	self.e_safe hide();
	if(level.var_98138d6b > 1)
	{
		level.var_1c53964e zm_hms_util::function_6a0d675d(#"hash_497ec7e9ca9ca204", -1, 0, 1);
	}
	player = self zm_unitrigger::function_fac87205(zm_utility::function_d6046228(#"hash_3be823a04b5cca2d", #"hash_25cb84d1af883c53"), 64);
	player thread zm_orange_util::function_51b752a9(#"hash_4323f85521955dd7");
	self.var_8ac20606 hide();
	self.var_8ac20606 playsound("zmb_vessel_pickup");
	level flag::set(#"vessel_found");
}

