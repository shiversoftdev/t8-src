// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6c5b51f98cd04fa3;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;

#namespace namespace_a35b0e2;

/*
	Name: function_89f2df9
	Namespace: namespace_a35b0e2
	Checksum: 0x1EC98DAC
	Offset: 0x1E0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_4fac8791c22b4bd7", &init, undefined, undefined);
}

/*
	Name: init
	Namespace: namespace_a35b0e2
	Checksum: 0x8CEDA820
	Offset: 0x228
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.var_143be9f3 = 0;
	level.var_4850c7c6 = 0;
	level.var_db90b274 = 2;
	level.var_cf5d426a = array("oscar_prelim_1", "oscar_prelim_2", "oscar_prelim_3", "oscar_prelim_4", "oscar_prelim_5");
	level.var_41770f71 = [];
	foreach(var_4f61dc22 in level.var_cf5d426a)
	{
		function_7a7d15c8(var_4f61dc22);
	}
	level.var_d5fff1a7 = getent("jfk_room_oscar_left_0", "targetname");
	level.var_a83c1620 = getent("jfk_room_oscar_left_1", "targetname");
	level.var_3830a0d3 = getent("jfk_room_oscar_right_0", "targetname");
	level.var_2a66053e = getent("jfk_room_oscar_right_1", "targetname");
	level.var_a83c1620 hide();
	level.var_2a66053e hide();
	level.var_3830a0d3.angles = level.var_3830a0d3.angles + vectorscale((1, 0, 0), 20);
	level flag::init(#"hash_7b1fd4fc459e497c");
	namespace_ee206246::register(#"hash_6039fc2dd130edf5", #"step_1", #"hash_5873576264199a27", &function_4ac6cf37, &function_cb27a665);
	namespace_ee206246::start(#"hash_6039fc2dd130edf5");
	namespace_ee206246::register(#"hash_6039fc2dd130edf5", #"step_2", #"hash_5873586264199bda", &function_955fffb1, &function_fabb1fba);
	namespace_ee206246::start(#"hash_6039fc2dd130edf5");
}

/*
	Name: function_4ac6cf37
	Namespace: namespace_a35b0e2
	Checksum: 0x776C0240
	Offset: 0x550
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_4ac6cf37(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		function_2d023c13();
		while(level.var_4850c7c6 < level.var_143be9f3)
		{
			waitframe(1);
		}
		playsoundatposition(#"hash_4ff9e8e25196f463", (0, 0, 0));
		/#
			iprintlnbold("");
		#/
	}
}

/*
	Name: function_cb27a665
	Namespace: namespace_a35b0e2
	Checksum: 0x27799125
	Offset: 0x5E8
	Size: 0xA0
	Parameters: 2
	Flags: Linked
*/
function function_cb27a665(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		foreach(var_637c224f in level.var_41770f71)
		{
			var_637c224f.e_trigger delete();
		}
	}
}

/*
	Name: function_7a7d15c8
	Namespace: namespace_a35b0e2
	Checksum: 0xDA25E29C
	Offset: 0x690
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_7a7d15c8(var_4f61dc22)
{
	level.var_143be9f3++;
	var_637c224f = getent(var_4f61dc22, "targetname");
	array::add(level.var_41770f71, var_637c224f);
	var_637c224f.angles = var_637c224f.angles + vectorscale((1, 0, 0), 20);
	var_637c224f.e_trigger = getent(var_4f61dc22 + "_trigger", "targetname");
}

/*
	Name: function_2d023c13
	Namespace: namespace_a35b0e2
	Checksum: 0xAB5F13D2
	Offset: 0x750
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function function_2d023c13()
{
	foreach(var_637c224f in level.var_41770f71)
	{
		var_637c224f.e_trigger thread function_d10bef80();
	}
}

/*
	Name: function_d10bef80
	Namespace: namespace_a35b0e2
	Checksum: 0x2CB058D7
	Offset: 0x7D8
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_d10bef80()
{
	self endon(#"death");
	var_b45fe0b3 = 0;
	while(!var_b45fe0b3)
	{
		waitresult = undefined;
		waitresult = self waittill(#"damage");
		if(waitresult.weapon == getweapon(#"bowie_knife_story_1"))
		{
			var_637c224f = getent(self.target, "targetname");
			var_637c224f rotateto(var_637c224f.angles - vectorscale((1, 0, 0), 20), 0.15);
			var_b45fe0b3 = 1;
			level.var_4850c7c6++;
		}
	}
}

/*
	Name: function_955fffb1
	Namespace: namespace_a35b0e2
	Checksum: 0xCC5AE09
	Offset: 0x8E0
	Size: 0x12C
	Parameters: 1
	Flags: Linked
*/
function function_955fffb1(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		var_52020ab3 = struct::get("jfk_room_oscar_left_trigger");
		var_52020ab3.var_47323b73 = var_52020ab3 zm_unitrigger::create("", 64, &function_715c9476, 1, 0);
		var_2d8940a6 = struct::get("jfk_room_oscar_right_trigger");
		var_2d8940a6.var_47323b73 = var_2d8940a6 zm_unitrigger::create("", 64, &function_63f29ee9, 1, 0);
		level.var_a83c1620 hide();
		level.var_2a66053e hide();
		level flag::wait_till(#"hash_7b1fd4fc459e497c");
	}
}

/*
	Name: function_fabb1fba
	Namespace: namespace_a35b0e2
	Checksum: 0x1639E575
	Offset: 0xA18
	Size: 0xE4
	Parameters: 2
	Flags: Linked
*/
function function_fabb1fba(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level flag::set(#"hash_7b1fd4fc459e497c");
	}
	var_52020ab3 = struct::get("jfk_room_oscar_left_trigger");
	if(isdefined(var_52020ab3.var_47323b73))
	{
		zm_unitrigger::unregister_unitrigger(var_52020ab3.var_47323b73);
	}
	var_2d8940a6 = struct::get("jfk_room_oscar_right_trigger");
	if(isdefined(var_2d8940a6.var_47323b73))
	{
		zm_unitrigger::unregister_unitrigger(var_2d8940a6.var_47323b73);
	}
}

/*
	Name: function_715c9476
	Namespace: namespace_a35b0e2
	Checksum: 0x462CBCEF
	Offset: 0xB08
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_715c9476()
{
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	level.var_db90b274--;
	self playsound(#"hash_5104efdd2ef71e39");
	/#
		iprintlnbold("");
	#/
	level thread function_bd81f4e2(waitresult.activator);
}

/*
	Name: function_63f29ee9
	Namespace: namespace_a35b0e2
	Checksum: 0x48F1BBB4
	Offset: 0xBB0
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_63f29ee9()
{
	var_c4cb303c = getent("jfk_room_oscar_right_0", "targetname");
	var_c4cb303c rotateto(var_c4cb303c.angles - vectorscale((1, 0, 0), 20), 0.15);
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	level.var_db90b274--;
	self playsound(#"hash_5104efdd2ef71e39");
	/#
		iprintlnbold("");
	#/
	level thread function_bd81f4e2(waitresult.activator);
}

/*
	Name: function_bd81f4e2
	Namespace: namespace_a35b0e2
	Checksum: 0xF385AB46
	Offset: 0xCB8
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function function_bd81f4e2(user)
{
	if(level.var_db90b274 <= 0)
	{
		level.var_a83c1620 show();
		level.var_2a66053e show();
		wait(0.1);
		level.var_d5fff1a7 hide();
		level.var_3830a0d3 hide();
		playsoundatposition(#"hash_4b169927b4789180", (0, 0, 0));
		/#
			iprintlnbold("");
		#/
		if(user zm_characters::is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4")))
		{
			user thread zm_vo::function_8e0f4696("vox_mcnamara_log_repair_plr_6_0");
		}
		level flag::set(#"hash_7b1fd4fc459e497c");
	}
}

