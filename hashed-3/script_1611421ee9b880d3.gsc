// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;
#using scripts\zm_common\zm_utility.csc;
#using scripts\zm_common\zm_weapons.csc;

#namespace zm_wallbuy;

/*
	Name: function_89f2df9
	Namespace: zm_wallbuy
	Checksum: 0x8CAEA17B
	Offset: 0x210
	Size: 0x54
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"zm_wallbuy", &__init__, &__main__, #"zm");
}

/*
	Name: __init__
	Namespace: zm_wallbuy
	Checksum: 0x7284D37C
	Offset: 0x270
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!getgametypesetting(#"hash_51a2cf319e12d9ae"))
	{
		return;
	}
	level flag::init("weapon_wallbuys_created");
	level._effect[#"wallbuy_ambient_fx"] = "zombie/fx8_wallbuy_amb";
	level._effect[#"hash_6928ec90dff78e0c"] = "zombie/fx8_wallbuy_amb_reverse";
	level._effect[#"wallbuy_reveal_fx"] = "zombie/fx8_wallbuy_reveal";
	clientfield::register("scriptmover", "wallbuy_ambient_fx", 1, 1, "int", &function_51f5fb94, 0, 0);
	clientfield::register("scriptmover", "wallbuy_reveal_fx", 1, 1, "int", &function_5ed44212, 0, 0);
	init();
}

/*
	Name: __main__
	Namespace: zm_wallbuy
	Checksum: 0xF8D9598F
	Offset: 0x3D0
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(!getgametypesetting(#"hash_51a2cf319e12d9ae"))
	{
		return;
	}
}

/*
	Name: init
	Namespace: zm_wallbuy
	Checksum: 0x539EDF87
	Offset: 0x400
	Size: 0x85C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	spawn_list = [];
	spawnable_weapon_spawns = struct::get_array("weapon_upgrade", "targetname");
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("bowie_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("sickle_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("tazer_upgrade", "targetname"), 1, 0);
	spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("buildable_wallbuy", "targetname"), 1, 0);
	if(isdefined(level.use_autofill_wallbuy) && level.use_autofill_wallbuy)
	{
		spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, level.active_autofill_wallbuys, 1, 0);
	}
	if(!(isdefined(level.headshots_only) && level.headshots_only))
	{
		spawnable_weapon_spawns = arraycombine(spawnable_weapon_spawns, struct::get_array("claymore_purchase", "targetname"), 1, 0);
	}
	location = level.scr_zm_map_start_location;
	if(location == "default" || location == "" && isdefined(level.default_start_location))
	{
		location = level.default_start_location;
	}
	match_string = level.scr_zm_ui_gametype;
	if("" != location)
	{
		match_string = (match_string + "_") + location;
	}
	match_string_plus_space = " " + match_string;
	for(i = 0; i < spawnable_weapon_spawns.size; i++)
	{
		spawnable_weapon = spawnable_weapon_spawns[i];
		spawnable_weapon.weapon = getweapon(spawnable_weapon.zombie_weapon_upgrade);
		weapon_group = function_e2703c27(spawnable_weapon.weapon);
		if(weapon_group == #"weapon_pistol" && !getgametypesetting(#"hash_6f1440098d849316") || (weapon_group == #"weapon_cqb" && !getgametypesetting(#"hash_edfb07f798aaab5")) || (weapon_group == #"weapon_smg" && !getgametypesetting(#"hash_1f6665b5581f6b6e")) || (weapon_group == #"weapon_assault" && !getgametypesetting(#"hash_1d5c8e6f0e20201a")) || (weapon_group == #"weapon_tactical" && !getgametypesetting(#"hash_1d88786f0e4535a3")) || (weapon_group == #"weapon_lmg" && !getgametypesetting(#"hash_2f6740b518dbeb8f")) || (weapon_group == #"weapon_sniper" && !getgametypesetting(#"hash_5bfd047c58816496")) || (weapon_group == #"weapon_knife" && !getgametypesetting(#"hash_26f3528e8457207a")))
		{
			continue;
		}
		if(isdefined(spawnable_weapon.zombie_weapon_upgrade) && spawnable_weapon.weapon.isgrenadeweapon && (isdefined(level.headshots_only) && level.headshots_only))
		{
			continue;
		}
		if(!isdefined(spawnable_weapon.script_noteworthy) || spawnable_weapon.script_noteworthy == "")
		{
			spawn_list[spawn_list.size] = spawnable_weapon;
			continue;
		}
		matches = strtok(spawnable_weapon.script_noteworthy, ",");
		for(j = 0; j < matches.size; j++)
		{
			if(matches[j] == match_string || matches[j] == match_string_plus_space)
			{
				spawn_list[spawn_list.size] = spawnable_weapon;
			}
		}
	}
	level._active_wallbuys = [];
	for(i = 0; i < spawn_list.size; i++)
	{
		spawn_list[i].script_label = (spawn_list[i].zombie_weapon_upgrade + "_") + spawn_list[i].origin;
		level._active_wallbuys[spawn_list[i].script_label] = spawn_list[i];
		numbits = 2;
		if(isdefined(level._wallbuy_override_num_bits))
		{
			numbits = level._wallbuy_override_num_bits;
		}
		clientfield::register("world", spawn_list[i].script_label, 1, numbits, "int", &wallbuy_callback, 0, 1);
		target_struct = struct::get(spawn_list[i].target, "targetname");
		if(spawn_list[i].targetname == "buildable_wallbuy")
		{
			bits = 4;
			if(isdefined(level.buildable_wallbuy_weapons))
			{
				bits = getminbitcountfornum(level.buildable_wallbuy_weapons.size + 1);
			}
			clientfield::register("world", spawn_list[i].script_label + "_idx", 1, bits, "int", &wallbuy_callback_idx, 0, 1);
		}
	}
	level flag::set("weapon_wallbuys_created");
	callback::on_localclient_connect(&wallbuy_player_connect);
}

/*
	Name: is_wallbuy
	Namespace: zm_wallbuy
	Checksum: 0xD9ACD2C2
	Offset: 0xC68
	Size: 0xFE
	Parameters: 1
	Flags: Linked
*/
function is_wallbuy(w_to_check)
{
	w_base = zm_weapons::function_386dacbc(w_to_check);
	if(!isdefined(level._active_wallbuys))
	{
		level._active_wallbuys = [];
	}
	foreach(s_wallbuy in level._active_wallbuys)
	{
		if(s_wallbuy.weapon == w_base)
		{
			return true;
		}
	}
	if(isdefined(level._additional_wallbuy_weapons))
	{
		if(isinarray(level._additional_wallbuy_weapons, w_base))
		{
			return true;
		}
	}
	return false;
}

/*
	Name: wallbuy_player_connect
	Namespace: zm_wallbuy
	Checksum: 0xADFA9CFE
	Offset: 0xD70
	Size: 0x1B4
	Parameters: 1
	Flags: Linked
*/
function wallbuy_player_connect(localclientnum)
{
	keys = getarraykeys(level._active_wallbuys);
	/#
		println("" + localclientnum);
	#/
	for(i = 0; i < keys.size; i++)
	{
		wallbuy = level._active_wallbuys[keys[i]];
		fx = level._effect[#"870mcs_zm_fx"];
		if(isdefined(level._effect[wallbuy.zombie_weapon_upgrade + "_fx"]))
		{
			fx = level._effect[wallbuy.zombie_weapon_upgrade + "_fx"];
		}
		target_struct = struct::get(wallbuy.target, "targetname");
		target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, wallbuy.weapon, undefined, target_struct.origin, target_struct.angles);
		target_model hide();
		target_model.parent_struct = target_struct;
		wallbuy.models[localclientnum] = target_model;
	}
}

/*
	Name: wallbuy_callback
	Namespace: zm_wallbuy
	Checksum: 0xE4A0E8F0
	Offset: 0xF30
	Size: 0x46A
	Parameters: 7
	Flags: Linked
*/
function wallbuy_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(binitialsnap)
	{
		while(!isdefined(level._active_wallbuys) || !isdefined(level._active_wallbuys[fieldname]))
		{
			waitframe(1);
		}
	}
	struct = level._active_wallbuys[fieldname];
	/#
		println("" + localclientnum);
	#/
	if(!isdefined(struct) || !isdefined(struct.models[localclientnum]) || !isdefined(struct.models[localclientnum].parent_struct))
	{
		/#
			/#
				assertmsg("" + fieldname);
			#/
		#/
		return;
	}
	switch(newval)
	{
		case 0:
		{
			struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
			struct.models[localclientnum].angles = struct.models[localclientnum].parent_struct.angles;
			struct.models[localclientnum] hide();
			break;
		}
		case 1:
		{
			if(binitialsnap)
			{
				if(!isdefined(struct.models))
				{
					while(!isdefined(struct.models))
					{
						waitframe(1);
					}
					while(!isdefined(struct.models[localclientnum]))
					{
						waitframe(1);
					}
				}
				struct.models[localclientnum] show();
				struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin;
			}
			else
			{
				waitframe(1);
				if(localclientnum == 0)
				{
					playsound(0, #"zmb_weap_wall", struct.origin);
				}
				vec_offset = (0, 0, 0);
				if(isdefined(struct.models[localclientnum].parent_struct.script_vector))
				{
					vec_offset = struct.models[localclientnum].parent_struct.script_vector;
				}
				struct.models[localclientnum].origin = struct.models[localclientnum].parent_struct.origin + ((anglestoright(struct.models[localclientnum].angles + vec_offset)) * 8);
				struct.models[localclientnum] show();
				struct.models[localclientnum] moveto(struct.models[localclientnum].parent_struct.origin, 1);
			}
			break;
		}
		case 2:
		{
			if(isdefined(level.wallbuy_callback_hack_override))
			{
				struct.models[localclientnum] [[level.wallbuy_callback_hack_override]]();
			}
			break;
		}
	}
}

/*
	Name: wallbuy_callback_idx
	Namespace: zm_wallbuy
	Checksum: 0xEB69DD7F
	Offset: 0x13A8
	Size: 0x470
	Parameters: 7
	Flags: Linked
*/
function wallbuy_callback_idx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	basefield = getsubstr(fieldname, 0, fieldname.size - 4);
	struct = level._active_wallbuys[basefield];
	if(newval == 0)
	{
		if(isdefined(struct.models[localclientnum]))
		{
			struct.models[localclientnum] hide();
		}
	}
	else if(newval > 0)
	{
		weaponname = level.buildable_wallbuy_weapons[newval - 1];
		weapon = getweapon(weaponname);
		if(!isdefined(struct.models))
		{
			struct.models = [];
		}
		if(!isdefined(struct.models[localclientnum]))
		{
			target_struct = struct::get(struct.target, "targetname");
			model = undefined;
			if(isdefined(level.buildable_wallbuy_weapon_models[weaponname]))
			{
				model = level.buildable_wallbuy_weapon_models[weaponname];
			}
			angles = target_struct.angles;
			if(isdefined(level.buildable_wallbuy_weapon_angles[weaponname]))
			{
				switch(level.buildable_wallbuy_weapon_angles[weaponname])
				{
					case 90:
					{
						angles = vectortoangles(anglestoright(angles));
						break;
					}
					case 180:
					{
						angles = vectortoangles(anglestoforward(angles) * -1);
						break;
					}
					case 270:
					{
						angles = vectortoangles(anglestoright(angles) * -1);
						break;
					}
				}
			}
			target_model = zm_utility::spawn_buildkit_weapon_model(localclientnum, weapon, undefined, target_struct.origin, angles);
			target_model hide();
			target_model.parent_struct = target_struct;
			struct.models[localclientnum] = target_model;
			if(isdefined(struct.fx[localclientnum]))
			{
				stopfx(localclientnum, struct.fx[localclientnum]);
				struct.fx[localclientnum] = undefined;
			}
			fx = level._effect[#"870mcs_zm_fx"];
			if(isdefined(level._effect[weaponname + "_fx"]))
			{
				fx = level._effect[weaponname + "_fx"];
			}
			struct.fx[localclientnum] = playfx(localclientnum, fx, struct.origin, anglestoforward(struct.angles), anglestoup(struct.angles), 0.1);
			level notify(#"wallbuy_updated");
		}
	}
}

/*
	Name: function_51f5fb94
	Namespace: zm_wallbuy
	Checksum: 0x25496B14
	Offset: 0x1820
	Size: 0x14A
	Parameters: 7
	Flags: Linked
*/
function function_51f5fb94(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.var_e51fbce7))
		{
			stopfx(localclientnum, self.var_e51fbce7);
			self.var_e51fbce7 = undefined;
		}
		if(!isdefined(self.var_907b36d0))
		{
			self.var_907b36d0 = util::playfxontag(localclientnum, level._effect[#"wallbuy_ambient_fx"], self, "tag_fx_wall_buy");
		}
	}
	else
	{
		if(isdefined(self.var_907b36d0))
		{
			stopfx(localclientnum, self.var_907b36d0);
			self.var_907b36d0 = undefined;
		}
		if(!isdefined(self.var_e51fbce7))
		{
			self.var_e51fbce7 = util::playfxontag(localclientnum, level._effect[#"hash_6928ec90dff78e0c"], self, "tag_fx_wall_buy");
		}
	}
}

/*
	Name: function_5ed44212
	Namespace: zm_wallbuy
	Checksum: 0xDEB08AF3
	Offset: 0x1978
	Size: 0x7C
	Parameters: 7
	Flags: Linked
*/
function function_5ed44212(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		util::playfxontag(localclientnum, level._effect[#"wallbuy_reveal_fx"], self, "tag_fx_wall_buy");
	}
}

