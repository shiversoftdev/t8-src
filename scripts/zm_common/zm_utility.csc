// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_158d50d476435605;
#using script_18a9e529264a3d29;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_powerups.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_utility;

/*
	Name: function_89f2df9
	Namespace: zm_utility
	Checksum: 0x7D99F724
	Offset: 0x1D8
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"zm_utility", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_utility
	Checksum: 0xDFC7CCB0
	Offset: 0x228
	Size: 0x16C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level._effect[#"hash_7dc0459342cedaa4"] = #"hash_3002526b7ff53cbf";
	clientfield::register("scriptmover", "zm_zone_edge_marker_count", 1, getminbitcountfornum(15), "int", &zm_zone_edge_marker_count, 0, 0);
	clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int", &zm_zone_out_of_bounds, 0, 0);
	clientfield::register("actor", "flame_corpse_fx", 1, 1, "int", &flame_corpse_fx, 0, 0);
	clientfield::register("actor", "zombie_eye_glow", 1, 1, "int", &zombie_eye_glow, 0, 0);
	function_c599ed65();
}

/*
	Name: __main__
	Namespace: zm_utility
	Checksum: 0x80F724D1
	Offset: 0x3A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: ignore_triggers
	Namespace: zm_utility
	Checksum: 0x7799CBEC
	Offset: 0x3B0
	Size: 0x5A
	Parameters: 1
	Flags: None
*/
function ignore_triggers(timer)
{
	if(!isdefined(self))
	{
		return;
	}
	self endon(#"death");
	self.ignoretriggers = 1;
	if(isdefined(timer))
	{
		wait(timer);
	}
	else
	{
		wait(0.5);
	}
	self.ignoretriggers = 0;
}

/*
	Name: is_encounter
	Namespace: zm_utility
	Checksum: 0x68C16BA
	Offset: 0x418
	Size: 0x6
	Parameters: 0
	Flags: None
*/
function is_encounter()
{
	return 0;
}

/*
	Name: round_up_to_ten
	Namespace: zm_utility
	Checksum: 0xEBD8BDCF
	Offset: 0x428
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function round_up_to_ten(score)
{
	new_score = score - score % 10;
	if(new_score < score)
	{
		new_score = new_score + 10;
	}
	return new_score;
}

/*
	Name: round_up_score
	Namespace: zm_utility
	Checksum: 0x74D840AB
	Offset: 0x478
	Size: 0x68
	Parameters: 2
	Flags: Linked
*/
function round_up_score(score, value)
{
	score = int(score);
	new_score = score - score % value;
	if(new_score < score)
	{
		new_score = new_score + value;
	}
	return new_score;
}

/*
	Name: halve_score
	Namespace: zm_utility
	Checksum: 0x6868C432
	Offset: 0x4E8
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function halve_score(n_score)
{
	n_score = n_score / 2;
	n_score = round_up_score(n_score, 10);
	return n_score;
}

/*
	Name: spawn_weapon_model
	Namespace: zm_utility
	Checksum: 0x5CC564DD
	Offset: 0x530
	Size: 0xD8
	Parameters: 6
	Flags: None
*/
function spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, options)
{
	weapon_model = spawn(localclientnum, origin, "script_model");
	if(isdefined(angles))
	{
		weapon_model.angles = angles;
	}
	if(isdefined(options))
	{
		weapon_model useweaponmodel(weapon, model, options);
	}
	else
	{
		weapon_model useweaponmodel(weapon, model);
	}
	return weapon_model;
}

/*
	Name: spawn_buildkit_weapon_model
	Namespace: zm_utility
	Checksum: 0x73339125
	Offset: 0x610
	Size: 0xA8
	Parameters: 5
	Flags: Linked
*/
function spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles)
{
	weapon_model = spawn(localclientnum, origin, "script_model");
	if(isdefined(angles))
	{
		weapon_model.angles = angles;
	}
	weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo);
	weapon_model activecamo::function_e40c785a(localclientnum);
	return weapon_model;
}

/*
	Name: is_classic
	Namespace: zm_utility
	Checksum: 0xB0ACDB63
	Offset: 0x6C0
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function is_classic()
{
	str_gametype = util::function_5df4294();
	if(str_gametype == #"zclassic")
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_standard
	Namespace: zm_utility
	Checksum: 0x89142E3B
	Offset: 0x708
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function is_standard()
{
	str_gametype = util::function_5df4294();
	if(str_gametype == #"zstandard")
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_trials
	Namespace: zm_utility
	Checksum: 0xAC020891
	Offset: 0x750
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function is_trials()
{
	str_gametype = util::function_5df4294();
	if(str_gametype == #"ztrials" || level flag::exists(#"ztrial"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_tutorial
	Namespace: zm_utility
	Checksum: 0xEF4D0E7B
	Offset: 0x7C0
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function is_tutorial()
{
	str_gametype = util::function_5df4294();
	if(str_gametype == #"ztutorial")
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_grief
	Namespace: zm_utility
	Checksum: 0x51DCEE30
	Offset: 0x808
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function is_grief()
{
	str_gametype = util::function_5df4294();
	if(str_gametype == #"zgrief")
	{
		return 1;
	}
	return 0;
}

/*
	Name: is_gametype_active
	Namespace: zm_utility
	Checksum: 0x6E713F2
	Offset: 0x850
	Size: 0x98
	Parameters: 1
	Flags: None
*/
function is_gametype_active(a_gametypes)
{
	b_is_gametype_active = 0;
	if(!isarray(a_gametypes))
	{
		a_gametypes = array(a_gametypes);
	}
	for(i = 0; i < a_gametypes.size; i++)
	{
		if(util::function_5df4294() == a_gametypes[i])
		{
			b_is_gametype_active = 1;
		}
	}
	return b_is_gametype_active;
}

/*
	Name: function_e51dc2d8
	Namespace: zm_utility
	Checksum: 0x14757BC2
	Offset: 0x8F0
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_e51dc2d8()
{
	if(!getdvarint(#"hash_2992299f853b2039", 0))
	{
		return 0;
	}
	if(level.gamedifficulty == 0)
	{
		return 0;
	}
	return 1;
}

/*
	Name: setinventoryuimodels
	Namespace: zm_utility
	Checksum: 0xBBBEE910
	Offset: 0x940
	Size: 0xA4
	Parameters: 7
	Flags: None
*/
function setinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

/*
	Name: setsharedinventoryuimodels
	Namespace: zm_utility
	Checksum: 0xC284562B
	Offset: 0x9F0
	Size: 0x84
	Parameters: 7
	Flags: None
*/
function setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory." + fieldname), newval);
}

/*
	Name: zm_ui_infotext
	Namespace: zm_utility
	Checksum: 0x45509752
	Offset: 0xA80
	Size: 0xCC
	Parameters: 7
	Flags: None
*/
function zm_ui_infotext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), fieldname);
	}
	else
	{
		setuimodelvalue(createuimodel(getuimodelforcontroller(localclientnum), "zmInventory.infoText"), "");
	}
}

/*
	Name: drawcylinder
	Namespace: zm_utility
	Checksum: 0xCC815170
	Offset: 0xB58
	Size: 0x296
	Parameters: 4
	Flags: None
*/
function drawcylinder(pos, rad, height, color)
{
	/#
		currad = rad;
		curheight = height;
		debugstar(pos, 1, color);
		for(r = 0; r < 20; r++)
		{
			theta = r / 20 * 360;
			theta2 = r + 1 / 20 * 360;
			line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
			line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
			line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
		}
	#/
}

/*
	Name: umbra_fix_logic
	Namespace: zm_utility
	Checksum: 0x26F9D6F1
	Offset: 0xDF8
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function umbra_fix_logic(localclientnum)
{
	self endon(#"disconnect");
	self endon(#"death");
	umbra_settometrigger(localclientnum, "");
	while(true)
	{
		in_fix_area = 0;
		if(isdefined(level.custom_umbra_hotfix))
		{
			in_fix_area = self thread [[level.custom_umbra_hotfix]](localclientnum);
		}
		if(in_fix_area == 0)
		{
			umbra_settometrigger(localclientnum, "");
		}
		waitframe(1);
	}
}

/*
	Name: umbra_fix_trigger
	Namespace: zm_utility
	Checksum: 0xF75624C3
	Offset: 0xEB8
	Size: 0x12E
	Parameters: 5
	Flags: None
*/
function umbra_fix_trigger(localclientnum, pos, height, radius, umbra_name)
{
	bottomy = pos[2];
	topy = pos[2] + height;
	if(self.origin[2] > bottomy && self.origin[2] < topy)
	{
		if(distance2dsquared(self.origin, pos) < radius * radius)
		{
			umbra_settometrigger(localclientnum, umbra_name);
			/#
				drawcylinder(pos, radius, height, (0, 1, 0));
			#/
			return 1;
		}
	}
	/#
		drawcylinder(pos, radius, height, (1, 0, 0));
	#/
	return 0;
}

/*
	Name: function_f8796df3
	Namespace: zm_utility
	Checksum: 0x468F7AD2
	Offset: 0xFF0
	Size: 0xA6
	Parameters: 1
	Flags: Linked
*/
function function_f8796df3(localclientnum)
{
	b_first = 0;
	if(isplayer(self) && self function_21c0fa55() && !isdemoplaying())
	{
		if(!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber())
		{
			b_first = 1;
		}
	}
	return b_first;
}

/*
	Name: function_5d8fd5f3
	Namespace: zm_utility
	Checksum: 0x59DBACF1
	Offset: 0x10A0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_5d8fd5f3(localclientnum)
{
	b_first = 0;
	if(isplayer(self) && self function_21c0fa55() && !isdemoplaying())
	{
		if(!isdefined(self getlocalclientnumber()) || localclientnum == self getlocalclientnumber())
		{
			if(!isthirdperson(localclientnum))
			{
				b_first = 1;
			}
		}
	}
	return b_first;
}

/*
	Name: function_467efa7b
	Namespace: zm_utility
	Checksum: 0xF2CAF4A9
	Offset: 0x1168
	Size: 0x14E
	Parameters: 1
	Flags: Linked
*/
function function_467efa7b(var_9f3fb329 = 0)
{
	if(!isdefined(self.archetype))
	{
		return "tag_origin";
	}
	switch(self.archetype)
	{
		case "stoker":
		case "catalyst":
		case "gladiator":
		case "nova_crawler":
		case "zombie":
		case "ghost":
		case "brutus":
		{
			if(var_9f3fb329)
			{
				str_tag = "j_spine4";
			}
			else
			{
				str_tag = "j_spineupper";
			}
			break;
		}
		case "blight_father":
		case "tiger":
		case "elephant":
		{
			str_tag = "j_head";
			break;
		}
		default:
		{
			str_tag = "tag_origin";
			break;
		}
	}
	return str_tag;
}

/*
	Name: function_bb54a31f
	Namespace: zm_utility
	Checksum: 0xE03ACFD7
	Offset: 0x12C0
	Size: 0x100
	Parameters: 3
	Flags: Linked
*/
function function_bb54a31f(localclientnum, var_20804e3b, var_3ab46b9)
{
	self endon(var_3ab46b9);
	s_result = undefined;
	s_result = level waittill(#"respawn");
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(e_player postfx::function_556665f2(var_20804e3b))
		{
			e_player postfx::exitpostfxbundle(var_20804e3b);
		}
	}
}

/*
	Name: function_ae3780f1
	Namespace: zm_utility
	Checksum: 0xAD7199EF
	Offset: 0x13C8
	Size: 0xF6
	Parameters: 3
	Flags: Linked
*/
function function_ae3780f1(localclientnum, n_fx_id, var_3ab46b9)
{
	self endon(var_3ab46b9);
	s_result = undefined;
	s_result = level waittill(#"respawn");
	a_e_players = getlocalplayers();
	foreach(e_player in a_e_players)
	{
		if(isdefined(n_fx_id))
		{
			deletefx(localclientnum, n_fx_id);
			n_fx_id = undefined;
		}
	}
}

/*
	Name: function_90500af5
	Namespace: zm_utility
	Checksum: 0xDD376061
	Offset: 0x14C8
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_90500af5()
{
	return namespace_cb7cafc3::function_90500af5();
}

/*
	Name: function_166646a6
	Namespace: zm_utility
	Checksum: 0x442E838A
	Offset: 0x14E8
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_166646a6()
{
	return namespace_cb7cafc3::function_166646a6();
}

/*
	Name: zm_zone_edge_marker_count
	Namespace: zm_utility
	Checksum: 0x163C018F
	Offset: 0x1508
	Size: 0x248
	Parameters: 7
	Flags: Linked
*/
function zm_zone_edge_marker_count(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		v_forward = anglestoforward(self.angles);
		v_right = anglestoright(self.angles);
		v_spacing = (0, 0, 0);
		self.origin = self.origin + v_right * 6;
		for(i = 1; i <= newval; i++)
		{
			var_a05a609b = playfx(localclientnum, level._effect[#"hash_7dc0459342cedaa4"], self.origin + v_spacing, v_forward);
			if(!isdefined(self.var_dd1709dd))
			{
				self.var_dd1709dd = [];
			}
			else if(!isarray(self.var_dd1709dd))
			{
				self.var_dd1709dd = array(self.var_dd1709dd);
			}
			self.var_dd1709dd[self.var_dd1709dd.size] = var_a05a609b;
			v_spacing = v_right * 32 * i;
		}
	}
	else if(isarray(self.var_dd1709dd))
	{
		foreach(var_a05a609b in self.var_dd1709dd)
		{
			stopfx(localclientnum, var_a05a609b);
		}
	}
}

/*
	Name: zm_zone_out_of_bounds
	Namespace: zm_utility
	Checksum: 0x6DFE9B18
	Offset: 0x1758
	Size: 0x14C
	Parameters: 7
	Flags: Linked
*/
function zm_zone_out_of_bounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.var_20861007))
	{
		level.var_20861007 = [];
	}
	if(!isdefined(level.var_20861007[localclientnum]))
	{
		level.var_20861007[localclientnum] = util::spawn_model(localclientnum, "tag_origin");
	}
	if(newval)
	{
		level.var_20861007[localclientnum] playloopsound(#"hash_6da7ae12f538ef5e", 0.5);
		self postfx::playpostfxbundle(#"hash_798237aa1bad3d7d");
	}
	else
	{
		level.var_20861007[localclientnum] stopallloopsounds(0.5);
		self postfx::exitpostfxbundle(#"hash_798237aa1bad3d7d");
	}
}

/*
	Name: flame_corpse_fx
	Namespace: zm_utility
	Checksum: 0x22C6F8E3
	Offset: 0x18B0
	Size: 0x14E
	Parameters: 7
	Flags: Linked
*/
function flame_corpse_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(isdefined(self.var_71a7fc1c))
		{
			stopfx(localclientnum, self.var_71a7fc1c);
		}
		str_tag = "j_spineupper";
		if(!isdefined(self gettagorigin(str_tag)))
		{
			str_tag = "tag_origin";
		}
		if(isdefined(level._effect) && isdefined(level._effect[#"character_fire_death_torso"]))
		{
			self.var_71a7fc1c = util::playfxontag(localclientnum, level._effect[#"character_fire_death_torso"], self, str_tag);
		}
	}
	else if(isdefined(self.var_71a7fc1c))
	{
		stopfx(localclientnum, self.var_71a7fc1c);
		self.var_71a7fc1c = undefined;
	}
}

/*
	Name: function_c599ed65
	Namespace: zm_utility
	Checksum: 0xD9FADEFC
	Offset: 0x1A08
	Size: 0xA2
	Parameters: 0
	Flags: Linked
*/
function function_c599ed65()
{
	if(function_166646a6() == 1)
	{
		level.var_12b59dee = "rob_zm_eyes_yellow";
		level._effect[#"eye_glow"] = #"hash_760112479afe6e2";
	}
	else
	{
		level.var_12b59dee = "rob_zm_eyes_orange";
		level._effect[#"eye_glow"] = #"zm_ai/fx8_zombie_eye_glow_orange";
	}
}

/*
	Name: function_beed5764
	Namespace: zm_utility
	Checksum: 0xE8A1999C
	Offset: 0x1AB8
	Size: 0x52
	Parameters: 2
	Flags: None
*/
function function_beed5764(var_ee6bcd51, str_fx)
{
	if(isdefined(var_ee6bcd51))
	{
		level.var_12b59dee = var_ee6bcd51;
	}
	if(isdefined(str_fx))
	{
		level._effect[#"eye_glow"] = str_fx;
	}
}

/*
	Name: function_704f7c0e
	Namespace: zm_utility
	Checksum: 0x16DABBEF
	Offset: 0x1B18
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_704f7c0e(localclientnum)
{
	self good_barricade_damaged(localclientnum);
	if(isdefined(self.var_3234aaa4))
	{
		var_ee6bcd51 = self.var_3234aaa4;
	}
	else
	{
		var_ee6bcd51 = level.var_12b59dee;
	}
	if(isdefined(self.var_3ec34470))
	{
		str_fx = self.var_3ec34470;
	}
	else
	{
		str_fx = level._effect[#"eye_glow"];
	}
	self function_fe127aaf(localclientnum, var_ee6bcd51, str_fx);
}

/*
	Name: function_3a020b0f
	Namespace: zm_utility
	Checksum: 0x435E07E1
	Offset: 0x1BD0
	Size: 0x54
	Parameters: 3
	Flags: Linked
*/
function function_3a020b0f(localclientnum, var_ee6bcd51, str_fx)
{
	self good_barricade_damaged(localclientnum);
	self function_fe127aaf(localclientnum, var_ee6bcd51, str_fx);
}

/*
	Name: good_barricade_damaged
	Namespace: zm_utility
	Checksum: 0xFED7536D
	Offset: 0x1C30
	Size: 0x7E
	Parameters: 1
	Flags: Linked
*/
function good_barricade_damaged(localclientnum)
{
	if(isdefined(self.var_12b59dee))
	{
		self function_5d482e78(self.var_12b59dee, "j_head");
		self.var_12b59dee = undefined;
	}
	if(isdefined(self.var_3231a850))
	{
		stopfx(localclientnum, self.var_3231a850);
		self.var_3231a850 = undefined;
	}
}

/*
	Name: function_fe127aaf
	Namespace: zm_utility
	Checksum: 0xC347ABF8
	Offset: 0x1CB8
	Size: 0xC2
	Parameters: 3
	Flags: Linked, Private
*/
private function function_fe127aaf(localclientnum, var_ee6bcd51, str_fx)
{
	if(isdefined(var_ee6bcd51))
	{
		self function_bf9d3071(var_ee6bcd51, "j_head");
		self.var_12b59dee = var_ee6bcd51;
	}
	if(isdefined(str_fx))
	{
		if(isdefined(self.var_f87f8fa0))
		{
			self.var_3231a850 = util::playfxontag(localclientnum, str_fx, self, self.var_f87f8fa0);
		}
		else
		{
			self.var_3231a850 = util::playfxontag(localclientnum, str_fx, self, "j_eyeball_le");
		}
	}
}

/*
	Name: zombie_eye_glow
	Namespace: zm_utility
	Checksum: 0xD60594DE
	Offset: 0x1D88
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function zombie_eye_glow(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self function_704f7c0e(localclientnum);
	}
	else
	{
		self good_barricade_damaged(localclientnum);
	}
}

