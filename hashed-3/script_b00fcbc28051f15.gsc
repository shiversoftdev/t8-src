// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_24c32478acf44108;
#using script_256b8879317373de;
#using script_3f9e0dc8454d98e1;
#using script_42ac6fc8b2ff0f3e;
#using script_4d000493c57bb851;
#using script_5660bae5b402a1eb;
#using script_6951ea86fdae9ae0;
#using script_6e3c826b1814cab6;
#using script_fb16bd158a3e3e7;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_hero_weapon.gsc;
#using scripts\zm_common\zm_laststand.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_weapons.gsc;

#namespace namespace_b4a066ff;

/*
	Name: function_89f2df9
	Namespace: namespace_b4a066ff
	Checksum: 0xF693F008
	Offset: 0x398
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_725ce960f13b96e7", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_b4a066ff
	Checksum: 0xA2BE2F49
	Offset: 0x3E8
	Size: 0x74C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_4e845c84 = getweapon(#"hash_185abc5c82e9d849");
	level.var_d7e67022 = getweapon(#"hash_42a45d43be3dba42");
	level.var_58e17ce3 = getweapon(#"hash_158041aab1e14f3a");
	level.var_637136f3 = getweapon(#"hash_78e66b21aa05c753");
	level.var_70f7eb75 = level.var_637136f3;
	level.var_ecfcf864 = &function_4173ee30;
	level.var_1177ae05 = &function_401e4768;
	level.riotshield_melee_power = &function_c531046b;
	level.var_fe5b96fb = &zombie_knockdown;
	level.var_a6a70655 = [];
	level.var_a6a70655[level.var_a6a70655.size] = "guts";
	level.var_a6a70655[level.var_a6a70655.size] = "right_arm";
	level.var_a6a70655[level.var_a6a70655.size] = "left_arm";
	if(zm_utility::function_e51dc2d8())
	{
		level.var_f7d93c4e = &function_df8ce6e2;
		level.var_932a1afb = &function_9693e041;
	}
	level.var_c7626f2a = [];
	clientfield::register("allplayers", "" + #"hash_184a34e85c29399f", 1, 1, "int");
	clientfield::register("toplayer", "" + #"hash_3538d219b7eb5ba0", 1, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_3c8cd47650fbb324", 1, 2, "int");
	clientfield::register("allplayers", "" + #"hash_e9b9b677ff2b8e2", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_1efc6bf68f09d02c", 1, 2, "int");
	n_bits = getminbitcountfornum(4);
	clientfield::register("actor", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int");
	clientfield::register("vehicle", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int");
	clientfield::register("scriptmover", "" + #"hash_1b02e77fdbc51a4d", 1, n_bits, "int");
	clientfield::register("scriptmover", "" + #"hash_7a8b6df890ccc630", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_7663ae2eb866d2eb", 1, 1, "counter");
	clientfield::register("allplayers", "" + #"hash_e0f652f4a9ad8d5", 1, 2, "int");
	clientfield::register("allplayers", "" + #"hash_5fc4ff8f1017bd0a", 1, 1, "counter");
	clientfield::register("scriptmover", "" + #"hash_6a04c04eae77e006", 1, 1, "counter");
	clientfield::register("actor", "" + #"hash_3abdd4f4d64241e5", 1, 1, "int");
	clientfield::register("allplayers", "" + #"hash_65fcbf0b7e534d0b", 1, 1, "counter");
	namespace_9ff9f642::register_slowdown(#"hash_119644e9a557f4e9", 0.5, 1);
	callback::on_ai_killed(&function_90a37da4);
	callback::on_connect(&function_70072647);
	zm::function_84d343d(#"hash_185abc5c82e9d849", &function_a8b4c2a7);
	zm::function_84d343d(#"hash_42a45d43be3dba42", &function_a8b4c2a7);
	zm::function_84d343d(#"hash_158041aab1e14f3a", &function_a8b4c2a7);
	zm::function_84d343d(#"hash_78e66b21aa05c753", &function_a8b4c2a7);
	if(!isdefined(level.var_dbfca4ee))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_dbfca4ee = object;
		[[ level.var_dbfca4ee ]]->initialize(6, 0.1);
	}
	/#
		level thread function_3a6ee2ea();
	#/
}

/*
	Name: __main__
	Namespace: namespace_b4a066ff
	Checksum: 0xE500CA9
	Offset: 0xB40
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	level thread function_b84d0267();
}

/*
	Name: function_70072647
	Namespace: namespace_b4a066ff
	Checksum: 0xD152CB5D
	Offset: 0xB68
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_70072647()
{
	self.var_9fd623ed = 0;
	self callback::function_33f0ddd3(&function_33f0ddd3);
}

/*
	Name: function_98890cd8
	Namespace: namespace_b4a066ff
	Checksum: 0xBB4A4BE8
	Offset: 0xBA0
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function function_98890cd8(w_current)
{
	if(w_current === level.var_d7e67022 || w_current === level.var_637136f3)
	{
		return 1;
	}
	if(w_current === level.var_4e845c84 || w_current === level.var_58e17ce3)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_33f0ddd3
	Namespace: namespace_b4a066ff
	Checksum: 0x2E6D782B
	Offset: 0xC18
	Size: 0x1DE
	Parameters: 1
	Flags: Linked, Private
*/
private function function_33f0ddd3(eventstruct)
{
	if(eventstruct.weapon === level.var_d7e67022 || eventstruct.weapon === level.var_637136f3)
	{
		if(eventstruct.event === "give_weapon")
		{
			if(eventstruct.weapon === level.var_d7e67022)
			{
				self.var_9fd623ed = 0;
			}
			if(eventstruct.weapon === level.var_d7e67022 && self hasweapon(level.var_4e845c84))
			{
				self setweaponammoclip(level.var_4e845c84, 0);
				self.var_f7c822b5 = 2;
			}
			else if(self hasweapon(level.var_58e17ce3))
			{
				self.var_5ba94c1e = 1;
				self setweaponammoclip(level.var_58e17ce3, 0);
				self.var_f7c822b5 = 4;
			}
			self thread function_5f950378();
		}
		else if(eventstruct.event === "take_weapon")
		{
			if(eventstruct.weapon === level.var_637136f3)
			{
				self.var_9fd623ed = 0;
			}
			if(function_98890cd8(eventstruct.weapon))
			{
				self thread function_cb1c46b8(0);
			}
			self notify(#"hash_1a22e1dd781f58d6");
		}
	}
}

/*
	Name: function_4173ee30
	Namespace: namespace_b4a066ff
	Checksum: 0xBD4445D7
	Offset: 0xE00
	Size: 0x2A4
	Parameters: 0
	Flags: Linked
*/
function function_4173ee30()
{
	w_current = self getcurrentweapon();
	if(!function_98890cd8(w_current))
	{
		return;
	}
	if(w_current == level.var_637136f3 || w_current == level.var_d7e67022)
	{
		if(!(isdefined(self.var_8d49716e) && self.var_8d49716e))
		{
			self thread function_1b33fb6d(w_current);
			self thread function_ebe5f74b();
		}
		self.var_8d49716e = 1;
		if(self.var_1d838ee9 == level.var_637136f3 || self.var_1d838ee9 == level.var_d7e67022)
		{
			return;
		}
		zm_hero_weapon::show_hint(w_current, #"hash_1656aebadea29360");
		self playsoundtoplayer(#"hash_6a9b5c781d4019b2", self);
		if(w_current == level.var_637136f3)
		{
			self.var_f7c822b5 = 4;
		}
		else if(w_current == level.var_d7e67022)
		{
			self.var_f7c822b5 = 2;
		}
	}
	if(!self clientfield::get_to_player("" + #"hash_3538d219b7eb5ba0"))
	{
		self clientfield::set_to_player("" + #"hash_3538d219b7eb5ba0", 1);
	}
	if(w_current == level.var_4e845c84 || w_current == level.var_58e17ce3)
	{
		if(self.var_1d838ee9 == level.var_4e845c84 || self.var_1d838ee9 == level.var_58e17ce3)
		{
			return;
		}
		if(self clientfield::get("" + #"hash_e0f652f4a9ad8d5"))
		{
			zm_hero_weapon::show_hint(w_current, #"hash_7c3a1b7b56c4fac1");
		}
		self thread function_cb1c46b8(1);
	}
	else
	{
		self thread function_cb1c46b8(0);
	}
}

/*
	Name: function_ebe5f74b
	Namespace: namespace_b4a066ff
	Checksum: 0x5B2C104B
	Offset: 0x10B0
	Size: 0xF8
	Parameters: 0
	Flags: Linked, Private
*/
private function function_ebe5f74b()
{
	self endon(#"bled_out", #"disconnect", #"hash_1b7c4bada7fa6175");
	self notify("4c9754f8548fd6a6");
	self endon("4c9754f8548fd6a6");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"destroy_riotshield", #"weapon_change");
		if(s_result._notify == "destroy_riotshield" || (isdefined(s_result.weapon) && !function_98890cd8(s_result.weapon)))
		{
			self thread function_401e4768();
		}
	}
}

/*
	Name: function_401e4768
	Namespace: namespace_b4a066ff
	Checksum: 0xA74E580E
	Offset: 0x11B0
	Size: 0xFC
	Parameters: 0
	Flags: Linked
*/
function function_401e4768()
{
	if(isdefined(self.var_8d49716e) && self.var_8d49716e)
	{
		self.var_8d49716e = undefined;
	}
	if(self clientfield::get_to_player("" + #"hash_3538d219b7eb5ba0"))
	{
		self clientfield::set_to_player("" + #"hash_3538d219b7eb5ba0", 0);
	}
	self notify(#"hash_1b7c4bada7fa6175");
	if(function_98890cd8(self.var_1d838ee9))
	{
		self playsoundtoplayer(#"hash_6632e419b4028fc4", self);
	}
	self thread function_cb1c46b8(0);
	self thread function_804309c(1);
}

/*
	Name: function_90a37da4
	Namespace: namespace_b4a066ff
	Checksum: 0xA5D02FB2
	Offset: 0x12B8
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_90a37da4(s_params)
{
	if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
	{
		self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
	}
	if(isplayer(s_params.eattacker) && (s_params.weapon == level.var_d7e67022 || s_params.weapon == level.var_637136f3 || s_params.weapon == level.var_4e845c84 || s_params.weapon == level.var_58e17ce3))
	{
		self namespace_6b49f66b::function_bb33631e(#"spoon");
	}
	if(isplayer(s_params.eattacker) && (s_params.weapon == level.var_d7e67022 || s_params.weapon == level.var_637136f3) && s_params.smeansofdeath === "MOD_ELECTROCUTED")
	{
		s_params.eattacker thread function_b952c1b(self);
	}
}

/*
	Name: function_a8b4c2a7
	Namespace: namespace_b4a066ff
	Checksum: 0x7B1C783A
	Offset: 0x1458
	Size: 0x258
	Parameters: 12
	Flags: Linked
*/
function function_a8b4c2a7(einflictor, eattacker, idamage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype)
{
	if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d") && meansofdeath !== "MOD_ELECTROCUTED")
	{
		return 0;
	}
	if(meansofdeath !== "MOD_IMPACT" && meansofdeath !== "MOD_ELECTROCUTED" && (!(isdefined(self.var_cbfc5f6e) && self.var_cbfc5f6e)))
	{
		return 0;
	}
	if(namespace_6b49f66b::is_active() && namespace_6b49f66b::function_937e218c() === #"spoon" && isplayer(eattacker))
	{
		self.var_12745932 = 1;
	}
	if(isplayer(eattacker))
	{
		if(self.animname === "zombie_eaten" && (!(isdefined(self.allowdeath) && self.allowdeath)) && self.health <= 1)
		{
			if(weapon == level.var_d7e67022 || weapon == level.var_637136f3 && meansofdeath === "MOD_ELECTROCUTED")
			{
				if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
				{
					self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
				}
				eattacker thread function_b952c1b(self);
			}
		}
	}
	return idamage;
}

/*
	Name: function_b952c1b
	Namespace: namespace_b4a066ff
	Checksum: 0x1198039E
	Offset: 0x16B8
	Size: 0x37E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_b952c1b(ai_zombie)
{
	self endon(#"disconnect");
	v_pos = ai_zombie getcentroid();
	var_88f24b00 = util::spawn_model("tag_origin", v_pos + vectorscale((0, 0, 1), 12), ai_zombie.angles);
	var_88f24b00 clientfield::set("" + #"hash_7a8b6df890ccc630", 1);
	var_88f24b00 playsound(#"zmb_sq_souls_release");
	n_dist = distance(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
	n_move_time = n_dist / 1200;
	n_dist_sq = distance2dsquared(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
	n_start_time = gettime();
	n_total_time = 0;
	while(n_dist_sq > 256 && isalive(self))
	{
		var_88f24b00 moveto(self function_7eae6d92(var_88f24b00), n_move_time);
		wait(0.1);
		if(isalive(self))
		{
			n_current_time = gettime();
			n_total_time = n_current_time - n_start_time / 1000;
			n_move_time = self function_f40aa0ef(var_88f24b00, n_total_time);
			if(n_move_time == 0)
			{
				break;
			}
			n_dist_sq = distance2dsquared(var_88f24b00.origin, self function_7eae6d92(var_88f24b00));
		}
	}
	var_88f24b00 clientfield::set("" + #"hash_7a8b6df890ccc630", 0);
	util::wait_network_frame();
	var_88f24b00 delete();
	wait(0.1);
	self playsoundontag(#"zmb_sq_souls_impact", "tag_weapon_right");
	self clientfield::increment("" + #"hash_7663ae2eb866d2eb");
	self.var_9fd623ed = math::clamp(self.var_9fd623ed + 1, 0, self.var_f7c822b5 * 3);
	self thread function_804309c();
	self notify(#"hash_22a49f7903e394a5");
}

/*
	Name: function_7eae6d92
	Namespace: namespace_b4a066ff
	Checksum: 0xA07C1F16
	Offset: 0x1A40
	Size: 0x72
	Parameters: 1
	Flags: Linked, Private
*/
private function function_7eae6d92(var_88f24b00)
{
	n_pos = self.origin + vectorscale((0, 0, 1), 46) + anglestoright(self.angles) * 24 + anglestoforward(self.angles) * 70;
	return n_pos;
}

/*
	Name: function_1e981d89
	Namespace: namespace_b4a066ff
	Checksum: 0x95E02625
	Offset: 0x1AC0
	Size: 0x6E
	Parameters: 1
	Flags: Private
*/
private function function_1e981d89(n_pos)
{
	/#
		self endon(#"death");
		self notify("");
		self endon("");
		while(true)
		{
			debugstar(n_pos, 5, (0, 1, 0));
			waitframe(5);
		}
	#/
}

/*
	Name: function_f40aa0ef
	Namespace: namespace_b4a066ff
	Checksum: 0x99FE42C6
	Offset: 0x1B38
	Size: 0x12C
	Parameters: 2
	Flags: Linked
*/
function function_f40aa0ef(var_88f24b00, n_total_time)
{
	if(n_total_time >= 2.5)
	{
		return 0;
	}
	if(n_total_time < 0.25)
	{
		var_e89ec7fd = 0.25 - n_total_time;
		var_e89ec7fd = (var_e89ec7fd > 0.05 ? var_e89ec7fd : 0.05);
	}
	else
	{
		var_e89ec7fd = 0.05;
	}
	var_a6693654 = n_total_time * 0.25;
	var_5100df85 = 1200 + 1200 * var_a6693654;
	n_dist = distance(var_88f24b00.origin, self geteye());
	n_move_time = n_dist / var_5100df85;
	n_move_time = (n_move_time > var_e89ec7fd ? n_move_time : var_e89ec7fd);
	return n_move_time;
}

/*
	Name: function_5f950378
	Namespace: namespace_b4a066ff
	Checksum: 0x6CF1FBCD
	Offset: 0x1C70
	Size: 0x2BE
	Parameters: 0
	Flags: Linked
*/
function function_5f950378()
{
	self endon(#"disconnect");
	if(!isdefined(self.var_f7c822b5))
	{
		self.var_f7c822b5 = 2;
	}
	var_18138fac = self.var_f7c822b5 * 3;
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"hash_22a49f7903e394a5", #"hash_1a22e1dd781f58d6", #"weapon_change", #"weapon_change_complete");
		var_74e62fc6 = self clientfield::get("" + #"hash_e0f652f4a9ad8d5");
		if(s_result._notify == "weapon_change" || s_result._notify == "weapon_change_complete" && (!(isdefined(function_98890cd8(s_result.weapon)) && function_98890cd8(s_result.weapon))))
		{
			if(var_74e62fc6 != 0)
			{
				self clientfield::set("" + #"hash_e0f652f4a9ad8d5", 0);
			}
			continue;
		}
		if(self.var_9fd623ed >= var_18138fac)
		{
			if(var_74e62fc6 != 2)
			{
				self clientfield::set("" + #"hash_e0f652f4a9ad8d5", 2);
				self thread zm_audio::create_and_play_dialog(#"shield", #"charged", undefined, 1);
			}
		}
		else if(self.var_9fd623ed >= 3)
		{
			if(var_74e62fc6 != 1)
			{
				self clientfield::set("" + #"hash_e0f652f4a9ad8d5", 1);
			}
		}
		else if(var_74e62fc6 != 0)
		{
			self clientfield::set("" + #"hash_e0f652f4a9ad8d5", 0);
		}
		if(s_result._notify === #"hash_1a22e1dd781f58d6")
		{
			return;
		}
	}
}

/*
	Name: function_cb1c46b8
	Namespace: namespace_b4a066ff
	Checksum: 0x21452575
	Offset: 0x1F38
	Size: 0x194
	Parameters: 1
	Flags: Linked
*/
function function_cb1c46b8(b_enabled)
{
	self endon(#"death");
	if(isdefined(b_enabled) && b_enabled)
	{
		if(!self clientfield::get("" + #"hash_184a34e85c29399f"))
		{
			self clientfield::set("" + #"hash_184a34e85c29399f", 1);
			self.snd_ent = spawn("script_origin", self.origin);
			self.snd_ent linkto(self);
			self.snd_ent playloopsound(#"hash_197dd6d18afad004");
		}
	}
	else if(self clientfield::get("" + #"hash_184a34e85c29399f"))
	{
		self clientfield::set("" + #"hash_184a34e85c29399f", 0);
	}
	if(isdefined(self.snd_ent))
	{
		self.snd_ent stoploopsound();
		self.snd_ent delete();
	}
}

/*
	Name: function_16dd8932
	Namespace: namespace_b4a066ff
	Checksum: 0x920C2D64
	Offset: 0x20D8
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_16dd8932()
{
	level flag::wait_till("start_zombie_round_logic");
	self clientfield::set("" + #"hash_3c8cd47650fbb324", 1);
}

/*
	Name: function_c531046b
	Namespace: namespace_b4a066ff
	Checksum: 0x830D7726
	Offset: 0x2138
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function function_c531046b(weapon)
{
	if(self.var_9fd623ed >= 3 && (weapon == level.var_4e845c84 || weapon == level.var_58e17ce3))
	{
		self clientfield::increment("" + #"hash_5fc4ff8f1017bd0a", 1);
		self playsound(#"hash_4fa7a7bff648310f");
		self.var_9fd623ed = math::clamp(self.var_9fd623ed - 3, 0, self.var_f7c822b5 * 3);
		self thread function_804309c();
		self notify(#"hash_22a49f7903e394a5");
		self thread function_92a54dac();
		self thread function_b18688c9();
		self function_d1cb7257();
	}
	else
	{
		riotshield::riotshield_melee(weapon);
	}
}

/*
	Name: function_92a54dac
	Namespace: namespace_b4a066ff
	Checksum: 0x37E2086E
	Offset: 0x2290
	Size: 0x1AC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_92a54dac()
{
	self endon(#"death");
	var_392095cb = getentarray("blast_attack_interactables", "script_noteworthy");
	foreach(var_afdaa400 in var_392095cb)
	{
		n_dist_sq = distancesquared(var_afdaa400.origin, self.origin);
		if(n_dist_sq < 262144)
		{
			var_2ed6f142 = self getweaponmuzzlepoint();
			v_normal = vectornormalize(var_afdaa400.origin - var_2ed6f142);
			var_ee5864e0 = self getweaponforwarddir();
			n_dot = vectordot(var_ee5864e0, v_normal);
			if(n_dot > 0.61)
			{
				var_afdaa400 notify(#"hash_6fd7f8e1f00deffe", {#e_player:self});
			}
		}
	}
}

/*
	Name: function_b18688c9
	Namespace: namespace_b4a066ff
	Checksum: 0x92FB34DD
	Offset: 0x2448
	Size: 0x240
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b18688c9()
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	var_a993e05e = self getweaponforwarddir();
	if(level.players.size == 1)
	{
		return;
	}
	foreach(e_player in level.players)
	{
		if(e_player == self)
		{
			continue;
		}
		n_dist_sq = distancesquared(e_player.origin, self.origin);
		if(n_dist_sq < 262144 && (isdefined(e_player sightconetrace(var_2ed6f142, self, var_a993e05e, 25)) && e_player sightconetrace(var_2ed6f142, self, var_a993e05e, 25)))
		{
			if(e_player laststand::player_is_in_laststand())
			{
				if(self zm_laststand::can_revive(e_player, 1, 1))
				{
					if(isdefined(e_player.revivetrigger) && isdefined(e_player.revivetrigger.beingrevived))
					{
						e_player.revivetrigger setinvisibletoall();
						e_player.revivetrigger.beingrevived = 0;
					}
					e_player zm_laststand::auto_revive(self);
					self notify(#"hash_6db9af45fe6345fc");
				}
				continue;
			}
			e_player function_745fe17c();
		}
	}
}

/*
	Name: function_745fe17c
	Namespace: namespace_b4a066ff
	Checksum: 0xBDD12871
	Offset: 0x2690
	Size: 0x54
	Parameters: 0
	Flags: Linked, Private
*/
private function function_745fe17c()
{
	if(self.health < self.var_66cb03ad)
	{
		self.health = self.var_66cb03ad;
		self clientfield::increment("" + #"hash_65fcbf0b7e534d0b", 1);
	}
}

/*
	Name: function_d1cb7257
	Namespace: namespace_b4a066ff
	Checksum: 0xE7974297
	Offset: 0x26F0
	Size: 0x1F6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_d1cb7257(n_clientfield)
{
	self endon(#"disconnect");
	if(!isdefined(level.var_e386af8))
	{
		level.var_e386af8 = [];
		level.var_7a867055 = [];
		level.var_2f7aae6c = [];
		level.var_8cd4a995 = [];
	}
	self function_750abd36();
	self.var_6c8b52a7 = 0;
	for(i = 0; i < level.var_2f7aae6c.size; i++)
	{
		[[ level.var_dbfca4ee ]]->waitinqueue(level.var_2f7aae6c[i]);
		if(!isdefined(level.var_2f7aae6c[i]))
		{
			continue;
		}
		level.var_2f7aae6c[i] thread function_a9521272(self, level.var_8cd4a995[i], i);
	}
	for(i = 0; i < level.var_e386af8.size; i++)
	{
		[[ level.var_dbfca4ee ]]->waitinqueue(level.var_e386af8[i]);
		if(!isdefined(level.var_e386af8[i]))
		{
			continue;
		}
		level.var_e386af8[i] thread function_c3eaccb8(self, level.var_7a867055[i]);
	}
	self notify(#"hash_5ac00f85b943ba5f", self.var_6c8b52a7);
	level.var_e386af8 = [];
	level.var_7a867055 = [];
	level.var_2f7aae6c = [];
	level.var_8cd4a995 = [];
}

/*
	Name: function_750abd36
	Namespace: namespace_b4a066ff
	Checksum: 0x5EF04934
	Offset: 0x28F0
	Size: 0x618
	Parameters: 0
	Flags: Linked
*/
function function_750abd36()
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	a_zombies = array::get_all_closest(var_2ed6f142, getaiteamarray(level.zombie_team), undefined, undefined, 1200);
	if(!a_zombies.size)
	{
		return;
	}
	var_c57defd6 = 1440000;
	var_a1a810b8 = 1048576;
	n_fling_range_sq = 262144;
	var_74238e2c = 32400;
	var_60f35d29 = 9216;
	var_d6b10e11 = 9216;
	var_ee5864e0 = self getweaponforwarddir();
	v_end_pos = var_2ed6f142 + vectorscale(var_ee5864e0, 1200);
	for(i = 0; i < a_zombies.size; i++)
	{
		if(!isalive(a_zombies[i]))
		{
			continue;
		}
		v_zombie_origin = a_zombies[i] getcentroid();
		var_a155935 = distancesquared(var_2ed6f142, v_zombie_origin);
		if(var_a155935 > var_c57defd6)
		{
			return;
		}
		normal = vectornormalize(v_zombie_origin - var_2ed6f142);
		dot = vectordot(var_ee5864e0, normal);
		if(var_a155935 < var_d6b10e11)
		{
			level.var_2f7aae6c[level.var_2f7aae6c.size] = a_zombies[i];
			dist_mult = 1;
			fling_vec = vectornormalize(v_zombie_origin - var_2ed6f142);
			fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
			fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
			level.var_8cd4a995[level.var_8cd4a995.size] = fling_vec;
			continue;
		}
		else if(var_a155935 < var_60f35d29 && 0 > dot)
		{
			if(!isdefined(a_zombies[i].var_ae25f0b5))
			{
				a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
			}
			level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
			level.var_7a867055[level.var_7a867055.size] = 0;
			continue;
		}
		if(0 > dot)
		{
			continue;
		}
		radial_origin = pointonsegmentnearesttopoint(var_2ed6f142, v_end_pos, v_zombie_origin);
		if(distancesquared(v_zombie_origin, radial_origin) > var_74238e2c)
		{
			continue;
		}
		if(0 == a_zombies[i] damageconetrace(var_2ed6f142, self))
		{
			continue;
		}
		a_zombies[i].var_45233b = 1.1 * sqrt(var_a155935) / 1200;
		if(var_a155935 < n_fling_range_sq)
		{
			level.var_2f7aae6c[level.var_2f7aae6c.size] = a_zombies[i];
			dist_mult = n_fling_range_sq - var_a155935 / n_fling_range_sq;
			fling_vec = vectornormalize(v_zombie_origin - var_2ed6f142);
			if(5000 < var_a155935)
			{
				fling_vec = fling_vec + vectornormalize(v_zombie_origin - radial_origin);
			}
			fling_vec = (fling_vec[0], fling_vec[1], abs(fling_vec[2]));
			fling_vec = vectorscale(fling_vec, 50 + 50 * dist_mult);
			level.var_8cd4a995[level.var_8cd4a995.size] = fling_vec;
			continue;
		}
		if(var_a155935 < var_a1a810b8)
		{
			if(!isdefined(a_zombies[i].var_ae25f0b5))
			{
				a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
			}
			level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
			level.var_7a867055[level.var_7a867055.size] = 1;
			continue;
		}
		if(!isdefined(a_zombies[i].var_ae25f0b5))
		{
			a_zombies[i].var_ae25f0b5 = level.var_fe5b96fb;
		}
		level.var_e386af8[level.var_e386af8.size] = a_zombies[i];
		level.var_7a867055[level.var_7a867055.size] = 0;
	}
}

/*
	Name: function_a9521272
	Namespace: namespace_b4a066ff
	Checksum: 0xB1A3FB09
	Offset: 0x2F10
	Size: 0x1AC
	Parameters: 3
	Flags: Linked
*/
function function_a9521272(player, fling_vec, index)
{
	delay = self.var_45233b;
	if(isdefined(delay) && delay > 0.05)
	{
		wait(delay);
	}
	if(!isalive(self))
	{
		return;
	}
	if(isdefined(self.var_3b188a21))
	{
		self [[self.var_3b188a21]](player);
		return;
	}
	if(self.var_6f84b820 === #"basic" || self.var_6f84b820 === #"enhanced")
	{
		if(!(isdefined(self.gibbed) && self.gibbed) && (!(isdefined(self.no_gib) && self.no_gib)))
		{
			self zombie_utility::gib_random_parts();
		}
		self zombie_utility::setup_zombie_knockdown(player);
	}
	self function_68871817(player);
	if(self.health <= 0)
	{
		if(!(isdefined(self.no_damage_points) && self.no_damage_points))
		{
			points = 10;
			if(1 == index)
			{
				points = 30;
			}
		}
		self.var_91ea09e0 = 1;
		player.var_6c8b52a7++;
	}
}

/*
	Name: zombie_knockdown
	Namespace: namespace_b4a066ff
	Checksum: 0xE0782AE0
	Offset: 0x30C8
	Size: 0x1D0
	Parameters: 2
	Flags: Linked
*/
function zombie_knockdown(player, gib)
{
	delay = self.var_45233b;
	if(isdefined(delay) && delay > 0.05)
	{
		wait(delay);
	}
	if(!isalive(self))
	{
		return;
	}
	if(!isvehicle(self))
	{
		if(gib && (!(isdefined(self.gibbed) && self.gibbed)))
		{
			self.a.gib_ref = array::random(level.var_a6a70655);
			self thread zombie_death::do_gib();
		}
		else
		{
			self zombie_utility::setup_zombie_knockdown(player);
		}
	}
	if(isdefined(level.var_6e9f8dbd))
	{
		self [[level.var_6e9f8dbd]](player, gib);
	}
	else if(self.health < 15 && self.var_6f84b820 !== #"popcorn")
	{
		self clientfield::set("" + #"hash_3abdd4f4d64241e5", 1);
	}
	self dodamage(15, player.origin, player, player, undefined, "MOD_IMPACT", 0, player getcurrentweapon());
	if(self.health <= 0)
	{
		player.var_6c8b52a7++;
	}
}

/*
	Name: function_68871817
	Namespace: namespace_b4a066ff
	Checksum: 0xDD3361B7
	Offset: 0x32A0
	Size: 0x184
	Parameters: 1
	Flags: Linked
*/
function function_68871817(e_attacker)
{
	if(isdefined(self))
	{
		if(isplayer(e_attacker))
		{
			w_damage = e_attacker getcurrentweapon();
		}
		else
		{
			w_damage = undefined;
		}
		if(self.var_6f84b820 == #"miniboss" || self.var_6f84b820 == #"boss")
		{
			self thread namespace_9ff9f642::slowdown(#"hash_119644e9a557f4e9");
			self dodamage(self.maxhealth * 0.1, e_attacker.origin, e_attacker, e_attacker, "torso_lower", "MOD_IMPACT", 0, w_damage);
		}
		else if(self.var_6f84b820 !== #"popcorn")
		{
			self clientfield::set("" + #"hash_3abdd4f4d64241e5", 1);
		}
		self dodamage(self.health + 666, e_attacker.origin, e_attacker, e_attacker, undefined, "MOD_IMPACT", 0, w_damage);
	}
}

/*
	Name: function_c3eaccb8
	Namespace: namespace_b4a066ff
	Checksum: 0x94FB20D4
	Offset: 0x3430
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_c3eaccb8(player, gib)
{
	self endon(#"death");
	if(!isalive(self))
	{
		return;
	}
	if(isdefined(self.var_ae25f0b5))
	{
		self [[self.var_ae25f0b5]](player, gib);
	}
}

/*
	Name: function_1b33fb6d
	Namespace: namespace_b4a066ff
	Checksum: 0x397169A8
	Offset: 0x34A0
	Size: 0x31E
	Parameters: 1
	Flags: Linked, Private
*/
private function function_1b33fb6d(var_155e1cdd)
{
	self endon_callback(&function_dc44932e, #"bled_out", #"disconnect", #"hash_1b7c4bada7fa6175");
	self notify("76bebc69db039874");
	self endon("76bebc69db039874");
	self thread function_804309c();
	while(true)
	{
		self waittill(#"weapon_fired");
		if(self zm_utility::is_drinking())
		{
			continue;
		}
		self clientfield::set("" + #"hash_e9b9b677ff2b8e2", 1);
		self clientfield::set("" + #"hash_1efc6bf68f09d02c", 1);
		self thread function_d1a7390b(var_155e1cdd);
		self thread function_423e10ee();
		while(zm_utility::is_player_valid(self) && self attackbuttonpressed() && !self fragbuttonpressed() && !self adsbuttonpressed() && !self zm_utility::is_drinking() && (!(isdefined(self.var_4154aa8f) && self.var_4154aa8f)))
		{
			if(self function_635f9c02(var_155e1cdd) || (namespace_fcd611c3::is_active() && !self namespace_fcd611c3::function_26f124d8()))
			{
				break;
			}
			waitframe(1);
		}
		self.var_f1b20bef = undefined;
		self clientfield::set("" + #"hash_e9b9b677ff2b8e2", 0);
		self clientfield::set("" + #"hash_1efc6bf68f09d02c", 0);
		self notify(#"hash_7a5ea8904c04f16b");
		self thread function_804309c();
		while(isdefined(self.var_4154aa8f) && self.var_4154aa8f && zm_utility::is_player_valid(self) && self attackbuttonpressed())
		{
			waitframe(1);
		}
		self.var_4154aa8f = undefined;
	}
}

/*
	Name: function_dc44932e
	Namespace: namespace_b4a066ff
	Checksum: 0xDB075F1C
	Offset: 0x37C8
	Size: 0xA6
	Parameters: 1
	Flags: Linked, Private
*/
private function function_dc44932e(var_c34665fc)
{
	if(var_c34665fc == #"hash_1b7c4bada7fa6175" || var_c34665fc == "weapon_change")
	{
		self.var_f1b20bef = undefined;
		self.var_4154aa8f = undefined;
		self clientfield::set("" + #"hash_e9b9b677ff2b8e2", 0);
		self clientfield::set("" + #"hash_1efc6bf68f09d02c", 0);
		self notify(#"hash_7a5ea8904c04f16b");
	}
}

/*
	Name: function_423e10ee
	Namespace: namespace_b4a066ff
	Checksum: 0xBF45059B
	Offset: 0x3878
	Size: 0x4A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_423e10ee()
{
	self endon(#"death", #"hash_1b7c4bada7fa6175", #"hash_7a5ea8904c04f16b");
	wait(180);
	self.var_4154aa8f = 1;
}

/*
	Name: function_d1a7390b
	Namespace: namespace_b4a066ff
	Checksum: 0xFF5FFB8E
	Offset: 0x38D0
	Size: 0x7C4
	Parameters: 1
	Flags: Linked
*/
function function_d1a7390b(var_f2a06582)
{
	self endon(#"disconnect", #"hash_7a5ea8904c04f16b");
	n_dist_sq_max = 173056;
	while(true)
	{
		var_24bae834 = 0;
		v_position = self getweaponmuzzlepoint();
		v_forward = self getweaponforwarddir();
		a_trace = beamtrace(v_position, v_position + v_forward * 416, 1, self);
		if(isdefined(a_trace[#"position"]))
		{
			n_dist_sq = distancesquared(self.origin, a_trace[#"position"]);
			if(n_dist_sq > n_dist_sq_max)
			{
				a_trace[#"entity"] = undefined;
			}
		}
		var_4ff501e0 = self function_f0b16c98(var_f2a06582, n_dist_sq_max);
		if(isdefined(a_trace[#"entity"]) || isdefined(var_4ff501e0))
		{
			if(isdefined(var_4ff501e0))
			{
				self.var_f1b20bef = var_4ff501e0;
			}
			else if(isdefined(a_trace[#"entity"]))
			{
				self.var_f1b20bef = a_trace[#"entity"];
			}
			e_last_target = self.var_f1b20bef;
			if(isai(e_last_target))
			{
				self notify(#"hash_6ce63d9afba84f4c");
				if(!isdefined(e_last_target.maxhealth))
				{
					e_last_target.maxhealth = e_last_target.health;
				}
				if(isdefined(e_last_target.var_77858b62))
				{
					if(!(isdefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e))
					{
						e_last_target thread [[e_last_target.var_77858b62]](self);
					}
				}
				else if(isdefined(e_last_target.var_6f84b820))
				{
					switch(e_last_target.var_6f84b820)
					{
						case "basic":
						case "enhanced":
						{
							if(!isdefined(e_last_target.var_455d573e))
							{
								e_last_target.var_455d573e = e_last_target function_81947c70();
							}
							if(!(isdefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e))
							{
								e_last_target thread function_35d74d73(self);
								waitframe(1);
							}
							if(isdefined(e_last_target))
							{
								if(e_last_target.health <= e_last_target.var_455d573e)
								{
									if(isdefined(e_last_target.var_9a51bdab))
									{
										n_current_time = gettime();
										n_total_time = float(n_current_time - e_last_target.var_9a51bdab) / 1000;
										if(n_total_time < 2)
										{
											break;
										}
									}
								}
								e_last_target dodamage(e_last_target.var_455d573e, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");
							}
							break;
						}
						case "heavy":
						case "miniboss":
						case "boss":
						{
							e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target getcentroid(), self, self, "torso_lower", "MOD_ELECTROCUTED");
							if(!(isdefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e))
							{
								e_last_target thread function_986701ac(self);
							}
							break;
						}
						case "popcorn":
						{
							if(!isdefined(e_last_target.var_455d573e))
							{
								e_last_target.var_455d573e = e_last_target function_81947c70();
							}
							if(!(isdefined(e_last_target.var_5bf7575e) && e_last_target.var_5bf7575e))
							{
								e_last_target thread function_a370d183(self);
							}
							e_last_target dodamage(e_last_target.var_455d573e, e_last_target getcentroid(), self, self, undefined, "MOD_ELECTROCUTED");
							break;
						}
						default:
						{
							e_last_target dodamage(e_last_target.maxhealth * 0.01, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
							break;
						}
					}
				}
			}
			else if(function_ffa5b184(e_last_target))
			{
				self notify(#"hash_6ce63d9afba84f4c");
				e_last_target dodamage(10, e_last_target.origin, self, self, undefined, "MOD_ELECTROCUTED");
			}
			else if(isdefined(level.var_c7626f2a))
			{
				foreach(key_func in level.var_c7626f2a)
				{
					if(!isdefined(e_last_target.var_2b6afc3c))
					{
						self thread [[key_func]](e_last_target);
						continue;
					}
					e_last_target notify(#"hash_2afc3e42ad78d30e");
				}
			}
		}
		else
		{
			self.var_f1b20bef = undefined;
			var_24bae834 = 0;
			switch(a_trace[#"surfacetype"])
			{
				case "glasscar":
				case "rock":
				case "metal":
				case "metalcar":
				case "glass":
				{
					var_24bae834 = 1;
					var_7a585212 = "reflective_geo";
					break;
				}
			}
		}
		e_last_target = undefined;
		wait(0.1);
	}
}

/*
	Name: function_81947c70
	Namespace: namespace_b4a066ff
	Checksum: 0xEA5C1F86
	Offset: 0x40A0
	Size: 0x126
	Parameters: 0
	Flags: Linked, Private
*/
private function function_81947c70()
{
	if(self.var_6f84b820 == #"popcorn")
	{
		var_f71f411b = 10;
	}
	else if(level.round_number < 16)
	{
		var_4e32983f = 1.3 / 16;
		var_15239c92 = level.round_number - 1 * var_4e32983f + 2;
		var_f71f411b = var_15239c92 / 0.1;
	}
	else
	{
		var_f71f411b = 33;
	}
	if(!isdefined(self.maxhealth))
	{
		self.maxhealth = self.health;
	}
	n_damage = int(math::clamp(self.maxhealth / var_f71f411b, 1, 1100));
	self.var_9a51bdab = gettime();
	return n_damage;
}

/*
	Name: function_f0b16c98
	Namespace: namespace_b4a066ff
	Checksum: 0x17D3B1A2
	Offset: 0x41D0
	Size: 0x300
	Parameters: 2
	Flags: Linked
*/
function function_f0b16c98(var_f2a06582, n_dist_sq_max)
{
	var_2ed6f142 = self getweaponmuzzlepoint();
	var_a993e05e = self getweaponforwarddir();
	if(isalive(self.var_f1b20bef) && (isdefined(self.var_f1b20bef sightconetrace(var_2ed6f142, self, var_a993e05e, 25)) && self.var_f1b20bef sightconetrace(var_2ed6f142, self, var_a993e05e, 25)))
	{
		return self.var_f1b20bef;
	}
	if(isdefined(level.var_68fa1bc))
	{
		n_dist_sq = distancesquared(self.origin, level.var_68fa1bc.origin);
		if(n_dist_sq < n_dist_sq_max)
		{
			if(isdefined(level.var_68fa1bc sightconetrace(var_2ed6f142, self, var_a993e05e, 25)) && level.var_68fa1bc sightconetrace(var_2ed6f142, self, var_a993e05e, 25))
			{
				return level.var_68fa1bc;
			}
		}
	}
	var_c581a3b2 = getaiteamarray(level.zombie_team);
	a_ai_zombies = arraysortclosest(var_c581a3b2, var_2ed6f142, 12);
	for(i = 0; i < a_ai_zombies.size; i++)
	{
		n_dist_sq = distancesquared(self.origin, a_ai_zombies[i].origin);
		if(n_dist_sq < n_dist_sq_max)
		{
			if(isdefined(a_ai_zombies[i] sightconetrace(var_2ed6f142, self, var_a993e05e, 25) && (isdefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath)) && a_ai_zombies[i] sightconetrace(var_2ed6f142, self, var_a993e05e, 25) && (isdefined(a_ai_zombies[i].allowdeath) && a_ai_zombies[i].allowdeath))
			{
				return a_ai_zombies[i];
			}
		}
	}
}

/*
	Name: function_35d74d73
	Namespace: namespace_b4a066ff
	Checksum: 0x7E5FA5C7
	Offset: 0x44D8
	Size: 0x3CE
	Parameters: 1
	Flags: Linked
*/
function function_35d74d73(e_attacker)
{
	self notify(#"hash_3f91506396266ee6");
	self endon(#"hash_3f91506396266ee6");
	e_attacker endon(#"disconnect");
	if(isdefined(self.aat_turned) && self.aat_turned || !isalive(self))
	{
		return;
	}
	self.var_5bf7575e = 1;
	self ai::stun();
	self.instakill_func = &function_6472c628;
	if(!self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
	{
		var_21c1ba1 = e_attacker getentitynumber();
		self clientfield::set("" + #"hash_1b02e77fdbc51a4d", var_21c1ba1 + 1);
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 2);
		if(self.var_6f84b820 == #"basic" || self.var_6f84b820 == #"enhanced")
		{
			function_6eac4ca1(self, "electrocute");
		}
	}
	while(e_attacker.var_f1b20bef === self && isalive(self))
	{
		if(self.health <= self.maxhealth * 0.5 && (!(isdefined(self.is_floating) && self.is_floating)))
		{
			self thread scene::play(#"hash_39dbc8cee7057640", self);
			self.is_floating = 1;
		}
		waitframe(1);
	}
	if(isdefined(self) && (isdefined(self.is_floating) && self.is_floating))
	{
		self thread scene::stop(#"hash_39dbc8cee7057640");
		self.is_floating = undefined;
	}
	var_d64818ae = e_attacker clientfield::get("" + #"hash_1efc6bf68f09d02c");
	if(e_attacker attackbuttonpressed() && var_d64818ae === 2)
	{
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 1);
	}
	if(isalive(self))
	{
		if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
		{
			self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
		}
		self.var_5bf7575e = 0;
		self ai::function_62795e55();
		self.instakill_func = undefined;
	}
}

/*
	Name: function_6472c628
	Namespace: namespace_b4a066ff
	Checksum: 0x2FB82DD8
	Offset: 0x48B0
	Size: 0x5E
	Parameters: 3
	Flags: Linked, Private
*/
private function function_6472c628(e_player, mod, shitloc)
{
	w_current = e_player getcurrentweapon();
	if(function_98890cd8(w_current))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_986701ac
	Namespace: namespace_b4a066ff
	Checksum: 0xA1D81D6E
	Offset: 0x4918
	Size: 0x24E
	Parameters: 1
	Flags: Linked
*/
function function_986701ac(e_attacker)
{
	self notify(#"hash_3c2776b4262d3359");
	self endon(#"hash_3c2776b4262d3359", #"death");
	if(isdefined(self.aat_turned) && self.aat_turned)
	{
		return;
	}
	self.var_5bf7575e = 1;
	if(!self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
	{
		var_21c1ba1 = e_attacker getentitynumber();
		self clientfield::set("" + #"hash_1b02e77fdbc51a4d", var_21c1ba1 + 1);
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 2);
	}
	while(e_attacker.var_f1b20bef === self && isalive(self))
	{
		waitframe(1);
	}
	var_d64818ae = e_attacker clientfield::get("" + #"hash_1efc6bf68f09d02c");
	if(e_attacker attackbuttonpressed() && var_d64818ae === 2)
	{
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 1);
	}
	if(isdefined(self))
	{
		if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
		{
			self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
		}
		self.var_5bf7575e = 0;
	}
}

/*
	Name: function_8103698
	Namespace: namespace_b4a066ff
	Checksum: 0x3A80A9DB
	Offset: 0x4B70
	Size: 0x74
	Parameters: 0
	Flags: Private
*/
private function function_8103698()
{
	if(isdefined(self.var_aef7bb46) && self.var_aef7bb46)
	{
		return;
	}
	self.var_aef7bb46 = 1;
	self thread function_da5e7ec0();
	self ai::stun();
	wait(1);
	self ai::function_62795e55();
}

/*
	Name: function_da5e7ec0
	Namespace: namespace_b4a066ff
	Checksum: 0xC8A284FB
	Offset: 0x4BF0
	Size: 0x2A
	Parameters: 0
	Flags: Linked, Private
*/
private function function_da5e7ec0()
{
	self endon(#"death");
	wait(12.5);
	self.var_aef7bb46 = undefined;
}

/*
	Name: function_a370d183
	Namespace: namespace_b4a066ff
	Checksum: 0xD049BD6
	Offset: 0x4C28
	Size: 0x274
	Parameters: 1
	Flags: Linked, Private
*/
private function function_a370d183(e_attacker)
{
	self notify(#"hash_3c2776b4262d3359");
	self endon(#"hash_3c2776b4262d3359", #"death");
	e_attacker endon(#"disconnect");
	self.var_5bf7575e = 1;
	self ai::stun();
	if(!self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
	{
		var_21c1ba1 = e_attacker getentitynumber();
		self clientfield::set("" + #"hash_1b02e77fdbc51a4d", var_21c1ba1 + 1);
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 2);
	}
	while(e_attacker.var_f1b20bef === self && isalive(self))
	{
		waitframe(1);
	}
	var_d64818ae = e_attacker clientfield::get("" + #"hash_1efc6bf68f09d02c");
	if(e_attacker attackbuttonpressed() && var_d64818ae === 2)
	{
		e_attacker clientfield::set("" + #"hash_1efc6bf68f09d02c", 1);
	}
	if(isdefined(self))
	{
		if(self clientfield::get("" + #"hash_1b02e77fdbc51a4d"))
		{
			self clientfield::set("" + #"hash_1b02e77fdbc51a4d", 0);
		}
		self.var_5bf7575e = undefined;
		self ai::function_62795e55();
	}
}

/*
	Name: function_804309c
	Namespace: namespace_b4a066ff
	Checksum: 0xB9C006E
	Offset: 0x4EA8
	Size: 0x41C
	Parameters: 1
	Flags: Linked
*/
function function_804309c(var_4c6ec31d = 0)
{
	if(self hasweapon(level.var_637136f3))
	{
		if(self.var_9fd623ed < 3 || (isdefined(var_4c6ec31d) && var_4c6ec31d))
		{
			if(self getweaponammoclip(level.var_637136f3) !== 0)
			{
				self setweaponammoclip(level.var_637136f3, 0);
				self setweaponammoclip(level.var_58e17ce3, 0);
				self setweaponammoclip(getweapon(#"hash_2182349b1e42e1a4"), 0);
			}
		}
		else if(self.var_9fd623ed >= 3)
		{
			if(self getweaponammoclip(level.var_d7e67022) !== int(self.var_9fd623ed / 3))
			{
				self setweaponammoclip(level.var_637136f3, int(self.var_9fd623ed / 3));
				self setweaponammoclip(level.var_58e17ce3, int(self.var_9fd623ed / 3));
				self setweaponammoclip(getweapon(#"hash_2182349b1e42e1a4"), int(self.var_9fd623ed / 3));
			}
		}
	}
	else if(self hasweapon(level.var_d7e67022))
	{
		if(self.var_9fd623ed < 3 || (isdefined(var_4c6ec31d) && var_4c6ec31d))
		{
			if(self getweaponammoclip(level.var_d7e67022) !== 0)
			{
				self setweaponammoclip(level.var_d7e67022, 0);
				self setweaponammoclip(level.var_4e845c84, 0);
				self setweaponammoclip(getweapon(#"hash_42895043be26dc73"), 0);
			}
		}
		else if(self.var_9fd623ed >= 3)
		{
			if(self getweaponammoclip(level.var_d7e67022) !== int(self.var_9fd623ed / 3))
			{
				self setweaponammoclip(level.var_d7e67022, int(self.var_9fd623ed / 3));
				self setweaponammoclip(level.var_4e845c84, int(self.var_9fd623ed / 3));
				self setweaponammoclip(getweapon(#"hash_42895043be26dc73"), int(self.var_9fd623ed / 3));
			}
		}
	}
}

/*
	Name: function_b84d0267
	Namespace: namespace_b4a066ff
	Checksum: 0x9768D38B
	Offset: 0x52D0
	Size: 0x128
	Parameters: 0
	Flags: Linked, Private
*/
private function function_b84d0267()
{
	level flag::wait_till("start_zombie_round_logic");
	var_a24f293e = getentarray("shield_model", "script_noteworthy");
	foreach(var_e9e88745 in var_a24f293e)
	{
		var_e9e88745 hidepart("tag_hellbox_lock");
	}
	while(true)
	{
		s_result = undefined;
		s_result = level waittill(#"hash_356be6a8a0b0668d");
		if(isdefined(s_result.unitrigger))
		{
			s_result.unitrigger thread function_d0b3a2c6();
		}
	}
}

/*
	Name: function_d0b3a2c6
	Namespace: namespace_b4a066ff
	Checksum: 0x8BE87163
	Offset: 0x5400
	Size: 0x104
	Parameters: 0
	Flags: Linked
*/
function function_d0b3a2c6()
{
	self endon(#"death");
	if(isdefined(self.stub.blueprint) && isdefined(self.stub.blueprint.var_54a97edd) && self.stub.blueprint.var_54a97edd === level.var_d7e67022)
	{
		if(isdefined(self.stub.model))
		{
			s_progress = undefined;
			s_progress = self waittill(#"hash_6db03c91467a21f5");
			if(isdefined(s_progress.b_completed) && s_progress.b_completed)
			{
				self.stub.model clientfield::increment("" + #"hash_6a04c04eae77e006");
			}
		}
	}
}

/*
	Name: function_9693e041
	Namespace: namespace_b4a066ff
	Checksum: 0xC72D2158
	Offset: 0x5510
	Size: 0x200
	Parameters: 1
	Flags: Linked
*/
function function_9693e041(player)
{
	if(!player hasweapon(level.var_637136f3) && (isdefined(player.var_5ba94c1e) && player.var_5ba94c1e))
	{
		self.hint_string = zm_utility::function_d6046228(#"hash_5eaa3c1a4110ddc9", #"hash_33cd9a34111d6257");
		if(isdefined(player.talisman_shield_price))
		{
			var_a185bd91 = player.talisman_shield_price;
		}
		else
		{
			var_a185bd91 = 0;
		}
		self.cost = self zm_crafting::function_ceac3bf9(player);
	}
	if(player hasweapon(level.var_637136f3))
	{
		if(isdefined(self.blueprint.var_54a97edd.isriotshield) && self.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			self.cost = self zm_crafting::function_ceac3bf9(player, 1);
			self.hint_string = zm_utility::function_d6046228(#"hash_35387f35bd87b96b", #"hash_3ee2e0100fefb461");
			_shad_turret_debug_server = 1;
		}
		else
		{
			self.hint_string = #"hash_53fd856df9288be7";
			self.cost = undefined;
			return 1;
		}
	}
}

/*
	Name: function_df8ce6e2
	Namespace: namespace_b4a066ff
	Checksum: 0x54DBCB4
	Offset: 0x5718
	Size: 0x4CA
	Parameters: 1
	Flags: Linked
*/
function function_df8ce6e2(player)
{
	player.var_54a51968 = self.target;
	player thread function_e5ca1c8d();
	if(!(isdefined(player.var_5ba94c1e) && player.var_5ba94c1e))
	{
		return 1;
	}
	var_54cae2d8 = getweapon(#"hash_42a45d43be3dba42");
	var_710873d9 = getweapon(#"hash_78e66b21aa05c753");
	if(player != self.parent_player)
	{
		return 0;
	}
	if(!zm_utility::is_player_valid(player))
	{
		player thread zm_utility::ignore_triggers(0.5);
		return 0;
	}
	if(player hasweapon(var_54cae2d8))
	{
		player zm_weapons::weapon_take(var_54cae2d8);
		player thread zm_weapons::weapon_give(var_710873d9);
		player.weaponriotshield = var_710873d9;
		return 0;
	}
	if(player zm_crafting::function_2d53738e(var_710873d9))
	{
		if(isdefined(self.stub.blueprint.var_54a97edd.isriotshield) && self.stub.blueprint.var_54a97edd.isriotshield && isdefined(player.player_shield_reset_health) && (isdefined(player.var_d3345483) && player.var_d3345483))
		{
			var_d97673ff = 1;
		}
		else
		{
			return 0;
		}
	}
	if(isdefined(var_d97673ff) && var_d97673ff)
	{
		var_f66d1847 = self.stub zm_crafting::function_ceac3bf9(player, 1);
		if(isdefined(var_f66d1847) && var_f66d1847 > 0)
		{
			if(player zm_score::can_player_purchase(var_f66d1847))
			{
				player thread zm_crafting::function_fccf9f0d();
				player zm_score::minus_to_player_score(var_f66d1847);
				player zm_utility::play_sound_on_ent("purchase");
			}
			else
			{
				zm_utility::play_sound_on_ent("no_purchase");
				player thread zm_audio::create_and_play_dialog("general", "outofmoney");
				return 0;
			}
		}
		player [[player.player_shield_reset_health]](var_710873d9, 0);
	}
	else
	{
		var_f66d1847 = self.stub zm_crafting::function_ceac3bf9(player);
		if(isdefined(var_f66d1847) && var_f66d1847 > 0)
		{
			if(player zm_score::can_player_purchase(var_f66d1847))
			{
				player thread zm_crafting::function_fccf9f0d();
				player zm_score::minus_to_player_score(var_f66d1847);
				player zm_utility::play_sound_on_ent("purchase");
			}
			else
			{
				zm_utility::play_sound_on_ent("no_purchase");
				player thread zm_audio::create_and_play_dialog("general", "outofmoney");
				return 0;
			}
		}
		if(isdefined(player.hasriotshield) && player.hasriotshield && isdefined(player.weaponriotshield))
		{
			player zm_weapons::weapon_take(player.weaponriotshield);
		}
		player thread zm_weapons::weapon_give(var_710873d9);
	}
	player notify(#"hash_77d44943fb143b18", {#weapon:self.stub.blueprint.var_54a97edd});
	return 0;
}

/*
	Name: function_e5ca1c8d
	Namespace: namespace_b4a066ff
	Checksum: 0x936B260D
	Offset: 0x5BF0
	Size: 0xAC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_e5ca1c8d()
{
	self notify("29615d74ce832e90");
	self endon("29615d74ce832e90");
	self endon(#"death");
	s_result = undefined;
	s_result = self waittill_timeout(5, #"hash_77d44943fb143b18");
	if(s_result._notify == #"hash_77d44943fb143b18" && function_98890cd8(s_result.weapon))
	{
		self thread function_804309c();
	}
}

/*
	Name: function_265e517c
	Namespace: namespace_b4a066ff
	Checksum: 0x554CA160
	Offset: 0x5CA8
	Size: 0x29C
	Parameters: 1
	Flags: Linked
*/
function function_265e517c(e_player)
{
	var_d399d194 = getentarray("shield_model", "script_noteworthy");
	var_824b5a74 = getentarray("shield_upgraded_model", "script_noteworthy");
	if(var_824b5a74.size == 0)
	{
		foreach(var_e9e88745 in var_d399d194)
		{
			var_ca89c8f9 = util::spawn_model(var_e9e88745.model, var_e9e88745.origin, var_e9e88745.angles);
			var_ca89c8f9.script_noteworthy = "shield_upgraded_model";
			var_ca89c8f9 setinvisibletoall();
			var_ca89c8f9.var_54a51968 = var_e9e88745.targetname;
		}
		var_7c26f4d0 = 1;
	}
	if(isdefined(var_7c26f4d0) && var_7c26f4d0)
	{
		var_824b5a74 = getentarray("shield_upgraded_model", "script_noteworthy");
	}
	if(isdefined(e_player))
	{
		foreach(var_e9e88745 in var_d399d194)
		{
			var_e9e88745 setinvisibletoplayer(e_player);
		}
		foreach(var_ca89c8f9 in var_824b5a74)
		{
			if(e_player.var_54a51968 === var_ca89c8f9.var_54a51968)
			{
				var_ca89c8f9 setvisibletoplayer(e_player);
				break;
			}
		}
	}
}

/*
	Name: render_debug_sphere
	Namespace: namespace_b4a066ff
	Checksum: 0x780BAA41
	Offset: 0x5F50
	Size: 0x6C
	Parameters: 2
	Flags: None
*/
function render_debug_sphere(origin, color)
{
	if(getdvarint(#"turret_debug_server", 0))
	{
		/#
			sphere(origin, 2, color, 0.75, 1, 10, 100);
		#/
	}
}

/*
	Name: function_7067b673
	Namespace: namespace_b4a066ff
	Checksum: 0x38325B97
	Offset: 0x5FC8
	Size: 0x6C
	Parameters: 3
	Flags: None
*/
function function_7067b673(origin1, origin2, color)
{
	if(getdvarint(#"turret_debug_server", 0))
	{
		/#
			line(origin1, origin2, color, 0.75, 1, 100);
		#/
	}
}

/*
	Name: function_3a6ee2ea
	Namespace: namespace_b4a066ff
	Checksum: 0x24EFFBB8
	Offset: 0x6040
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_3a6ee2ea()
{
	/#
		if(!getdvarint(#"hash_11ad6a9695943217", 0))
		{
			return;
		}
		zm_devgui::add_custom_devgui_callback(&function_6da92963);
		adddebugcommand("");
		adddebugcommand("");
	#/
}

/*
	Name: function_6da92963
	Namespace: namespace_b4a066ff
	Checksum: 0x81D23258
	Offset: 0x60D0
	Size: 0x3D2
	Parameters: 1
	Flags: None
*/
function function_6da92963(cmd)
{
	/#
		switch(cmd)
		{
			case "hash_2346833eb7280698":
			{
				foreach(e_player in level.players)
				{
					if(e_player hasweapon(level.var_4e845c84))
					{
						e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
						e_player setweaponammoclip(level.var_4e845c84, e_player.var_9fd623ed);
						e_player notify(#"hash_22a49f7903e394a5");
						e_player thread function_804309c();
						continue;
					}
					if(e_player hasweapon(level.var_58e17ce3))
					{
						e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
						e_player setweaponammoclip(level.var_58e17ce3, e_player.var_9fd623ed);
						e_player notify(#"hash_22a49f7903e394a5");
						e_player thread function_804309c();
					}
				}
				break;
			}
			case "hash_5a13ac5a96bb700c":
			{
				foreach(e_player in level.players)
				{
					if(e_player hasweapon(level.var_4e845c84))
					{
						e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
						e_player setweaponammoclip(level.var_4e845c84, e_player.var_f7c822b5);
						e_player notify(#"hash_22a49f7903e394a5");
						e_player thread function_4df187a9(level.var_4e845c84);
						continue;
					}
					if(e_player hasweapon(level.var_58e17ce3))
					{
						e_player.var_9fd623ed = math::clamp(e_player.var_f7c822b5 * 3, 0, e_player.var_f7c822b5 * 3);
						e_player setweaponammoclip(level.var_58e17ce3, e_player.var_f7c822b5);
						e_player notify(#"hash_22a49f7903e394a5");
						e_player thread function_4df187a9(level.var_58e17ce3);
					}
				}
				break;
			}
		}
	#/
}

/*
	Name: function_4df187a9
	Namespace: namespace_b4a066ff
	Checksum: 0x88E61D1A
	Offset: 0x64B0
	Size: 0x12A
	Parameters: 1
	Flags: None
*/
function function_4df187a9(var_54cae2d8)
{
	/#
		self notify(#"hash_1f37709e96e62bf2");
		self endon(#"disconnect", #"hash_1f37709e96e62bf2");
		while(true)
		{
			self thread function_804309c();
			s_result = undefined;
			s_result = self waittill(#"hash_5ac00f85b943ba5f", #"take_weapon");
			if(!self hasweapon(var_54cae2d8))
			{
				return;
			}
			self.var_9fd623ed = math::clamp(self.var_f7c822b5 * 3, 0, self.var_f7c822b5 * 3);
			self setweaponammoclip(var_54cae2d8, self.var_f7c822b5);
			self notify(#"hash_22a49f7903e394a5");
		}
	#/
}

