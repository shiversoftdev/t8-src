// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_421e0a3702e22de;
#using script_52c6c2d1a2ef1b46;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_45e52e8a;

/*
	Name: preload
	Namespace: namespace_45e52e8a
	Checksum: 0x80F724D1
	Offset: 0x1E0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
}

/*
	Name: main
	Namespace: namespace_45e52e8a
	Checksum: 0x83B40FF8
	Offset: 0x1F0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"hash_40324afbf4440a0c");
	level flag::init(#"hash_117279bc435c1c9");
	level.var_62bfa1a6 = [];
	level.var_4cf6900e = [];
	level.var_4cf6900e[#"orange"] = struct::get("orange", "script_noteworthy");
	level.var_4cf6900e[#"blue"] = struct::get("blue", "script_noteworthy");
	level.var_4cf6900e[#"yellow"] = struct::get("yellow", "script_noteworthy");
	level.var_4cf6900e[#"violet"] = struct::get("violet", "script_noteworthy");
	foreach(var_c808386b in level.var_4cf6900e)
	{
		var_c808386b.var_e5f66b29 = 0;
		var_c808386b.var_3cae7377 = 0;
		var_c808386b.n_value = 0;
		var_c808386b.var_7bb4ff56 = function_21a3a673(1, 9);
		var_c808386b.var_5820f7cc = getent(var_c808386b.target, "targetname");
		var_c808386b.var_5820f7cc hide();
	}
	function_5f228e90();
}

/*
	Name: function_77ed3bab
	Namespace: namespace_45e52e8a
	Checksum: 0x6F47AB51
	Offset: 0x468
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function function_77ed3bab(var_5ea5c94d)
{
	namespace_6747c550::function_7df6bb60(#"hash_2fbec633e5118bab", 1);
	if(!var_5ea5c94d)
	{
		/#
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
			if(getdvarint(#"hash_11ad6a9695943217", 0))
			{
				if(getdvarint(#"hash_11ad6a9695943217", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
		#/
		namespace_85e029d3::function_3f9e02b8(6, #"hash_2934f352bd60d6d6", #"hash_68fc56c1fbf3b972", &function_bd605daa);
		namespace_85e029d3::function_d83490c5(6);
		level flag::wait_till(#"hash_40324afbf4440a0c");
		foreach(var_c808386b in level.var_4cf6900e)
		{
			var_c808386b zm_unitrigger::create("", 32);
			var_c808386b thread function_1e5c0d3b();
		}
		while(!function_5a73ee80())
		{
			wait(1);
		}
	}
}

/*
	Name: function_51ecc801
	Namespace: namespace_45e52e8a
	Checksum: 0xFEC00162
	Offset: 0x6E0
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function function_51ecc801(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		namespace_85e029d3::function_6aaeff92(6);
		foreach(var_c808386b in level.var_4cf6900e)
		{
			var_c808386b.var_e5f66b29 = 1;
			var_c808386b.var_3cae7377 = 1;
			var_c808386b.var_5820f7cc show();
		}
	}
	level flag::set(#"hash_117279bc435c1c9");
}

/*
	Name: function_bd605daa
	Namespace: namespace_45e52e8a
	Checksum: 0x374A2B0D
	Offset: 0x7E8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_bd605daa()
{
	level flag::set(#"hash_40324afbf4440a0c");
}

/*
	Name: function_5a73ee80
	Namespace: namespace_45e52e8a
	Checksum: 0xC5CB5C6C
	Offset: 0x818
	Size: 0x90
	Parameters: 0
	Flags: Linked
*/
function function_5a73ee80()
{
	b_done = 1;
	foreach(dial in level.var_4cf6900e)
	{
		if(!dial.var_3cae7377)
		{
			b_done = 0;
		}
	}
	return b_done;
}

/*
	Name: function_1e5c0d3b
	Namespace: namespace_45e52e8a
	Checksum: 0x90EAA58B
	Offset: 0x8B0
	Size: 0x33E
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1e5c0d3b()
{
	level endon(#"end_game");
	while(!level flag::get(#"hash_117279bc435c1c9"))
	{
		var_adea2587 = undefined;
		var_adea2587 = self waittill(#"trigger_activated", #"hash_117279bc435c1c9");
		if(var_adea2587._notify == #"hash_117279bc435c1c9")
		{
			return;
		}
		e_who = var_adea2587.e_who;
		if(!self.var_e5f66b29)
		{
			self.var_e5f66b29 = 1;
			self.var_5820f7cc show();
			self.var_5820f7cc playsound("zmb_vessel_drop");
			wait(0.2);
		}
		else
		{
			self.var_5820f7cc playsound("zmb_quest_dial_turn");
			var_146d9ed3 = e_who function_c4946c8f(self.var_5820f7cc);
			if(var_146d9ed3)
			{
				self.var_5820f7cc rotatepitch(36, 0.2, 0.03, 0.06);
				wait(0.2);
				self.n_value++;
			}
			else
			{
				self.var_5820f7cc rotatepitch(-36, 0.2, 0.03, 0.06);
				wait(0.2);
				self.n_value--;
			}
			wait(0.2);
			if(self.n_value > 9)
			{
				self.n_value = 0;
			}
			if(self.n_value < 0)
			{
				self.n_value = 9;
			}
			if(self.n_value == self.var_7bb4ff56)
			{
				/#
					if(getdvarint(#"hash_11ad6a9695943217", 0))
					{
						if(getdvarint(#"hash_11ad6a9695943217", 0))
						{
							iprintlnbold("" + self.script_noteworthy + "");
							println("" + self.script_noteworthy + "");
						}
					}
				#/
				self.var_3cae7377 = 1;
				self.var_5820f7cc playsound("zmb_quest_dial_success");
			}
			else
			{
				self.var_3cae7377 = 0;
			}
		}
	}
}

/*
	Name: function_c4946c8f
	Namespace: namespace_45e52e8a
	Checksum: 0xEA409397
	Offset: 0xBF8
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_c4946c8f(object)
{
	v_origin = object.origin;
	if(isdefined(object.var_eb397f67))
	{
		v_origin = object.var_eb397f67;
	}
	v_delta = vectornormalize(self geteye() - v_origin);
	v_angles = self getplayerangles();
	v_view = anglestoforward(v_angles);
	v_cross = vectorcross(v_view, v_delta);
	var_35b81369 = vectordot(v_cross, anglestoup(v_angles));
	if(var_35b81369 >= 0)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_a02dfba
	Namespace: namespace_45e52e8a
	Checksum: 0xBA2F7338
	Offset: 0xD30
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_a02dfba()
{
	var_aff5104e = getentarray("mq_dial_number", "targetname");
	foreach(var_f0c3a84d in var_aff5104e)
	{
		var_f0c3a84d function_eb2835af();
	}
}

/*
	Name: function_eb2835af
	Namespace: namespace_45e52e8a
	Checksum: 0x237F2AFD
	Offset: 0xDD8
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_eb2835af()
{
	var_880b9c97 = [3:"tag_yellow_", 2:"tag_violet_", 1:"tag_orange_", 0:"tag_blue_"];
	foreach(str_tag in var_880b9c97)
	{
		for(i = 0; i < 10; i++)
		{
			self hidepart(str_tag + i);
		}
	}
}

/*
	Name: function_66365668
	Namespace: namespace_45e52e8a
	Checksum: 0x226FA7BA
	Offset: 0xED8
	Size: 0x102
	Parameters: 1
	Flags: Linked
*/
function function_66365668(n_code)
{
	switch(self.script_noteworthy)
	{
		case "orange_code":
		{
			self showpart("tag_orange_" + n_code);
			break;
		}
		case "blue_code":
		{
			self showpart("tag_blue_" + n_code);
			break;
		}
		case "yellow_code":
		{
			self showpart("tag_yellow_" + n_code);
			break;
		}
		case "violet_code":
		{
			self showpart("tag_violet_" + n_code);
			break;
		}
	}
}

/*
	Name: function_5f228e90
	Namespace: namespace_45e52e8a
	Checksum: 0xD5A784D2
	Offset: 0xFE8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_5f228e90()
{
	level function_a02dfba();
	if(zm_utility::function_e51dc2d8())
	{
		function_ca3efcd8(level.var_c205c941, "orange_code", level.var_4cf6900e[#"orange"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "blue_code", level.var_4cf6900e[#"blue"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "yellow_code", level.var_4cf6900e[#"yellow"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "violet_code", level.var_4cf6900e[#"violet"].var_7bb4ff56);
	}
}

/*
	Name: function_ca3efcd8
	Namespace: namespace_45e52e8a
	Checksum: 0x652B52D8
	Offset: 0x1120
	Size: 0x104
	Parameters: 3
	Flags: Linked
*/
function function_ca3efcd8(var_f0c3a84d, str_noteworthy, n_code)
{
	var_127789d1 = randomint(3);
	var_52ed9cd6 = namespace_509a75d1::function_bffcedde(str_noteworthy, "script_noteworthy", "script_int");
	level.var_c205c941[str_noteworthy] = var_52ed9cd6[var_127789d1];
	level.var_c205c941[str_noteworthy] function_66365668(n_code);
	for(i = 0; i < var_52ed9cd6.size; i++)
	{
		if(i != var_127789d1)
		{
			var_52ed9cd6[i] delete();
		}
	}
	waitframe(1);
}

