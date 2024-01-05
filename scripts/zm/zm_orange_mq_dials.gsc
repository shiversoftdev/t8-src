// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_orange_pablo.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\flag_shared.gsc;

#namespace zm_orange_mq_dials;

/*
	Name: preload
	Namespace: zm_orange_mq_dials
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
	Namespace: zm_orange_mq_dials
	Checksum: 0x83B40FF8
	Offset: 0x1F0
	Size: 0x26C
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"dials_aquired");
	level flag::init(#"dials_done");
	level.var_62bfa1a6 = [];
	level.var_4cf6900e = [];
	level.var_4cf6900e[#"orange"] = struct::get("orange", "script_noteworthy");
	level.var_4cf6900e[#"blue"] = struct::get("blue", "script_noteworthy");
	level.var_4cf6900e[#"yellow"] = struct::get("yellow", "script_noteworthy");
	level.var_4cf6900e[#"violet"] = struct::get("violet", "script_noteworthy");
	foreach(s_dial in level.var_4cf6900e)
	{
		s_dial.var_e5f66b29 = 0;
		s_dial.b_correct = 0;
		s_dial.n_value = 0;
		s_dial.var_7bb4ff56 = function_21a3a673(1, 9);
		s_dial.dial_model = getent(s_dial.target, "targetname");
		s_dial.dial_model hide();
	}
	function_5f228e90();
}

/*
	Name: function_77ed3bab
	Namespace: zm_orange_mq_dials
	Checksum: 0x6F47AB51
	Offset: 0x468
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function function_77ed3bab(var_5ea5c94d)
{
	zm_ui_inventory::function_7df6bb60(#"zm_orange_objective_progress", 1);
	if(!var_5ea5c94d)
	{
		/#
			if(getdvarint(#"zm_debug_ee", 0))
			{
				if(getdvarint(#"zm_debug_ee", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
			if(getdvarint(#"zm_debug_ee", 0))
			{
				if(getdvarint(#"zm_debug_ee", 0))
				{
					iprintlnbold("");
					println("");
				}
			}
		#/
		zm_orange_pablo::function_3f9e02b8(6, #"hash_2934f352bd60d6d6", #"hash_68fc56c1fbf3b972", &function_bd605daa);
		zm_orange_pablo::function_d83490c5(6);
		level flag::wait_till(#"dials_aquired");
		foreach(s_dial in level.var_4cf6900e)
		{
			s_dial zm_unitrigger::create("", 32);
			s_dial thread function_1e5c0d3b();
		}
		while(!function_5a73ee80())
		{
			wait(1);
		}
	}
}

/*
	Name: function_51ecc801
	Namespace: zm_orange_mq_dials
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
		zm_orange_pablo::function_6aaeff92(6);
		foreach(s_dial in level.var_4cf6900e)
		{
			s_dial.var_e5f66b29 = 1;
			s_dial.b_correct = 1;
			s_dial.dial_model show();
		}
	}
	level flag::set(#"dials_done");
}

/*
	Name: function_bd605daa
	Namespace: zm_orange_mq_dials
	Checksum: 0x374A2B0D
	Offset: 0x7E8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_bd605daa()
{
	level flag::set(#"dials_aquired");
}

/*
	Name: function_5a73ee80
	Namespace: zm_orange_mq_dials
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
		if(!dial.b_correct)
		{
			b_done = 0;
		}
	}
	return b_done;
}

/*
	Name: function_1e5c0d3b
	Namespace: zm_orange_mq_dials
	Checksum: 0x90EAA58B
	Offset: 0x8B0
	Size: 0x33E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1e5c0d3b()
{
	level endon(#"end_game");
	while(!level flag::get(#"dials_done"))
	{
		s_results = undefined;
		s_results = self waittill(#"trigger_activated", #"dials_done");
		if(s_results._notify == #"dials_done")
		{
			return;
		}
		e_who = s_results.e_who;
		if(!self.var_e5f66b29)
		{
			self.var_e5f66b29 = 1;
			self.dial_model show();
			self.dial_model playsound("zmb_vessel_drop");
			wait(0.2);
		}
		else
		{
			self.dial_model playsound("zmb_quest_dial_turn");
			b_left = e_who lavapit_breach_(self.dial_model);
			if(b_left)
			{
				self.dial_model rotatepitch(36, 0.2, 0.03, 0.06);
				wait(0.2);
				self.n_value++;
			}
			else
			{
				self.dial_model rotatepitch(-36, 0.2, 0.03, 0.06);
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
					if(getdvarint(#"zm_debug_ee", 0))
					{
						if(getdvarint(#"zm_debug_ee", 0))
						{
							iprintlnbold(("" + self.script_noteworthy) + "");
							println(("" + self.script_noteworthy) + "");
						}
					}
				#/
				self.b_correct = 1;
				self.dial_model playsound("zmb_quest_dial_success");
			}
			else
			{
				self.b_correct = 0;
			}
		}
	}
}

/*
	Name: lavapit_breach_
	Namespace: zm_orange_mq_dials
	Checksum: 0xEA409397
	Offset: 0xBF8
	Size: 0x12C
	Parameters: 1
	Flags: Linked, Private
*/
function private lavapit_breach_(object)
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
		return true;
	}
	return false;
}

/*
	Name: function_a02dfba
	Namespace: zm_orange_mq_dials
	Checksum: 0xBA2F7338
	Offset: 0xD30
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_a02dfba()
{
	var_aff5104e = getentarray("mq_dial_number", "targetname");
	foreach(e_code in var_aff5104e)
	{
		e_code function_eb2835af();
	}
}

/*
	Name: function_eb2835af
	Namespace: zm_orange_mq_dials
	Checksum: 0x237F2AFD
	Offset: 0xDD8
	Size: 0xF2
	Parameters: 0
	Flags: Linked
*/
function function_eb2835af()
{
	a_str_tag_name = [3:"tag_yellow_", 2:"tag_violet_", 1:"tag_orange_", 0:"tag_blue_"];
	foreach(str_tag in a_str_tag_name)
	{
		for(i = 0; i < 10; i++)
		{
			self hidepart(str_tag + i);
		}
	}
}

/*
	Name: function_66365668
	Namespace: zm_orange_mq_dials
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
	Namespace: zm_orange_mq_dials
	Checksum: 0xD5A784D2
	Offset: 0xFE8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function function_5f228e90()
{
	level function_a02dfba();
	if(zm_utility::is_ee_enabled())
	{
		function_ca3efcd8(level.var_c205c941, "orange_code", level.var_4cf6900e[#"orange"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "blue_code", level.var_4cf6900e[#"blue"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "yellow_code", level.var_4cf6900e[#"yellow"].var_7bb4ff56);
		function_ca3efcd8(level.var_c205c941, "violet_code", level.var_4cf6900e[#"violet"].var_7bb4ff56);
	}
}

/*
	Name: function_ca3efcd8
	Namespace: zm_orange_mq_dials
	Checksum: 0x652B52D8
	Offset: 0x1120
	Size: 0x104
	Parameters: 3
	Flags: Linked
*/
function function_ca3efcd8(e_code, str_noteworthy, n_code)
{
	var_127789d1 = randomint(3);
	a_e_codes = zm_hms_util::function_bffcedde(str_noteworthy, "script_noteworthy", "script_int");
	level.var_c205c941[str_noteworthy] = a_e_codes[var_127789d1];
	level.var_c205c941[str_noteworthy] function_66365668(n_code);
	for(i = 0; i < a_e_codes.size; i++)
	{
		if(i != var_127789d1)
		{
			a_e_codes[i] delete();
		}
	}
	waitframe(1);
}

