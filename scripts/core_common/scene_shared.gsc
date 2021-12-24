// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_439e9618e516580f;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\animation_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\music_shared.gsc;
#using scripts\core_common\oob.gsc;
#using scripts\core_common\scene_debug_shared.gsc;
#using scripts\core_common\scene_objects_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\teleport_shared.gsc;
#using scripts\core_common\trigger_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace scene;

/*
	Name: function_89f2df9
	Namespace: scene
	Checksum: 0xD71819AB
	Offset: 0x5B0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"scene", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: scene
	Checksum: 0x5332F6D8
	Offset: 0x600
	Size: 0x42C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.scene_sequence_names))
	{
		level.scene_sequence_names = [];
	}
	if(!isdefined(level.scene_streamer_ignore))
	{
		level.scene_streamer_ignore = [];
	}
	level.scenedefs = getscriptbundlenames("scene");
	level.active_scenes = [];
	level.inactive_scenes = [];
	level.active_scenes = [];
	level.sceneskippedcount = 0;
	lui::function_b95a3ba5("cp_skip_scene_menu", &cp_skip_scene_menu::register, "cp_skip_scene_menu");
	streamerrequest("clear");
	foreach(s_scenedef in getscriptbundles("scene"))
	{
		var_50477704 = s_scenedef.name + "_scene_done";
		level flag::init(var_50477704);
		if(s_scenedef.vmtype === "client")
		{
			continue;
		}
		if(s_scenedef.vmtype === "both" && !s_scenedef is_igc())
		{
			n_clientbits = getminbitcountfornum(3);
			/#
				n_clientbits = getminbitcountfornum(6);
			#/
			clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int");
		}
	}
	clientfield::register("toplayer", "postfx_igc", 1, 2, "counter");
	clientfield::register("world", "in_igc", 1, 4, "int");
	clientfield::register("toplayer", "postfx_cateye", 1, 1, "int");
	clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter");
	clientfield::register("toplayer", "player_pbg_bank_scene_system", 1, getminbitcountfornum(3), "int");
	clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter");
	clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter");
	clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter");
	clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter");
	callback::on_disconnect(&on_player_disconnect);
}

/*
	Name: function_c8fb67e5
	Namespace: scene
	Checksum: 0x303A1073
	Offset: 0xA38
	Size: 0x3E8
	Parameters: 1
	Flags: Linked
*/
function function_c8fb67e5(var_dfd8c930)
{
	if(isarray(var_dfd8c930.var_9c542279) && var_dfd8c930.var_9c542279.size)
	{
		var_41b6320 = [];
		if(!isdefined(level.heroes))
		{
			level.heroes = [];
		}
		foreach(specialist in level.heroes)
		{
			str_name = specialist.animname;
			if(!isdefined(var_41b6320))
			{
				var_41b6320 = [];
			}
			else if(!isarray(var_41b6320))
			{
				var_41b6320 = array(var_41b6320);
			}
			var_41b6320[var_41b6320.size] = str_name;
		}
		var_87439bc3 = [];
		foreach(var_cc4b944f in var_dfd8c930.var_9c542279)
		{
			str_scenedef = var_cc4b944f.var_bdf9f114;
			if(!isdefined(str_scenedef))
			{
				continue;
			}
			var_cdd7dee0 = getscriptbundle(str_scenedef);
			var_4d96eb1b = [];
			foreach(var_90acec35 in var_cdd7dee0.objects)
			{
				if(isdefined(var_90acec35.specialistname))
				{
					if(!isdefined(var_4d96eb1b))
					{
						var_4d96eb1b = [];
					}
					else if(!isarray(var_4d96eb1b))
					{
						var_4d96eb1b = array(var_4d96eb1b);
					}
					if(!isinarray(var_4d96eb1b, var_90acec35.specialistname))
					{
						var_4d96eb1b[var_4d96eb1b.size] = var_90acec35.specialistname;
					}
				}
			}
			if(isarray(var_4d96eb1b))
			{
				foreach(str_name in var_41b6320)
				{
					if(isinarray(var_4d96eb1b, str_name))
					{
						if(!isdefined(var_87439bc3))
						{
							var_87439bc3 = [];
						}
						else if(!isarray(var_87439bc3))
						{
							var_87439bc3 = array(var_87439bc3);
						}
						if(!isinarray(var_87439bc3, var_cdd7dee0))
						{
							var_87439bc3[var_87439bc3.size] = var_cdd7dee0;
						}
					}
				}
			}
		}
		return var_87439bc3;
	}
	return undefined;
}

/*
	Name: function_f9d052da
	Namespace: scene
	Checksum: 0xA8C97F8C
	Offset: 0xE28
	Size: 0xAE
	Parameters: 2
	Flags: None
*/
function function_f9d052da(var_a65cecda, var_cdd7dee0)
{
	foreach(var_a736dfcf in var_cdd7dee0.objects)
	{
		if(isdefined(var_a736dfcf.specialistname) && var_a736dfcf.specialistname != var_a65cecda)
		{
			return var_a736dfcf.specialistname;
		}
	}
	return undefined;
}

/*
	Name: function_585fb738
	Namespace: scene
	Checksum: 0x7D9837E7
	Offset: 0xEE0
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_585fb738()
{
	if(function_7aa3d2c6(self.name))
	{
		self.igc = 1;
		return;
	}
	foreach(s_object in self.objects)
	{
		if(!(isdefined(s_object.disabled) && s_object.disabled) && (!(isdefined(s_object.showhud) && s_object.showhud)))
		{
			if(isdefined(s_object.shots))
			{
				foreach(s_shot in s_object.shots)
				{
					if(isdefined(s_shot.entry))
					{
						foreach(s_entry in s_shot.entry)
						{
							if(isdefined(s_entry.cameraswitcher))
							{
								self.igc = 1;
								return;
							}
						}
					}
				}
			}
		}
	}
}

/*
	Name: fixup_scenedef
	Namespace: scene
	Checksum: 0x78C6D475
	Offset: 0x10C8
	Size: 0x7D0
	Parameters: 1
	Flags: Linked
*/
function fixup_scenedef(s_scenedef)
{
	if(isdefined(s_scenedef.objects[0]) && isdefined(s_scenedef.objects[0].shots))
	{
		return s_scenedef;
	}
	if(!isdefined(s_scenedef.ready_to_use))
	{
		s_scenedef.ready_to_use = 1;
	}
	else
	{
		return s_scenedef;
	}
	a_invalid_object_indexes = [];
	foreach(i, s_object in s_scenedef.objects)
	{
		if(!isdefined(s_object.name) && !isdefined(s_object.model) && !s_object.type === "player")
		{
			if(!isdefined(a_invalid_object_indexes))
			{
				a_invalid_object_indexes = [];
			}
			else if(!isarray(a_invalid_object_indexes))
			{
				a_invalid_object_indexes = array(a_invalid_object_indexes);
			}
			a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
		}
	}
	for(i = a_invalid_object_indexes.size - 1; i >= 0; i--)
	{
		arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
	}
	s_scenedef.editaction = undefined;
	s_scenedef.newobject = undefined;
	if(isstring(s_scenedef.femalebundle) || function_7a600918(s_scenedef.femalebundle))
	{
		s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
		s_female_bundle.malebundle = s_scenedef.name;
		s_scenedef.s_female_bundle = s_female_bundle;
		s_female_bundle.s_male_bundle = s_scenedef;
	}
	if(isdefined(level.scene_sequence_names) && !isdefined(level.scene_sequence_names[s_scenedef.name]))
	{
		s_next_bundle = s_scenedef;
		while(isdefined(s_next_bundle))
		{
			level.scene_sequence_names[s_next_bundle.name] = s_scenedef.name;
			if(isdefined(s_next_bundle.nextscenebundle))
			{
				s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
			}
			else
			{
				s_next_bundle = undefined;
			}
		}
	}
	else
	{
		level.scene_streamer_ignore[s_scenedef.name] = 1;
	}
	if(isstring(s_scenedef.nextscenebundle) || function_7a600918(s_scenedef.nextscenebundle))
	{
		s_next_bundle = s_scenedef;
		while(isdefined(s_next_bundle))
		{
			if(isdefined(s_next_bundle.nextscenebundle))
			{
				s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
			}
			else
			{
				s_next_bundle = undefined;
			}
			if(isdefined(s_next_bundle))
			{
				s_scenedef.str_final_bundle = s_next_bundle.name;
			}
		}
		foreach(s_object in s_scenedef.objects)
		{
			if(s_object.type === "player")
			{
				s_object.disabletransitionout = 1;
			}
		}
		s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
		s_scenedef.next_bundle = s_next_bundle;
		s_next_bundle.dontsync = 1;
		s_next_bundle.dontthrottle = 1;
		foreach(s_object in s_next_bundle.objects)
		{
			if(s_object.type === "player")
			{
				s_object.disabletransitionin = 1;
			}
			s_object.iscutscene = 1;
		}
		if(isdefined(s_next_bundle.femalebundle))
		{
			s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
			if(isdefined(s_next_female_bundle))
			{
				s_next_female_bundle.dontsync = 1;
				s_next_female_bundle.dontthrottle = 1;
				foreach(s_object in s_next_female_bundle.objects)
				{
					if(s_object.type === "player")
					{
						s_object.disabletransitionin = 1;
					}
					s_object.iscutscene = 1;
				}
			}
		}
	}
	foreach(s_object in s_scenedef.objects)
	{
		if(s_object.type === "player")
		{
			if(!isdefined(s_object.cameratween))
			{
				s_object.cameratween = 0;
			}
			s_object.newplayermethod = 1;
			if(isdefined(s_object.sharedigc) && s_object.sharedigc)
			{
				s_object.type = "sharedplayer";
			}
		}
		if(s_object.type != "player" && s_object.type != "sharedplayer")
		{
			s_object.cameraswitcher = undefined;
		}
		s_object.player = undefined;
		if(s_object.type === "player model")
		{
			s_object.type = "fakeplayer";
		}
	}
	if(isstring(s_scenedef.cameraswitcher) || function_7a600918(s_scenedef.cameraswitcher))
	{
		s_scenedef.igc = 1;
	}
	convert_to_new_format(s_scenedef);
	return s_scenedef;
}

/*
	Name: function_ceb43448
	Namespace: scene
	Checksum: 0xBEEA2192
	Offset: 0x18A0
	Size: 0x1E4
	Parameters: 4
	Flags: Linked
*/
function function_ceb43448(var_5e3936e3, var_651e3856, str_field, var_8e9b7b3d)
{
	var_5e3936e3--;
	var_651e3856--;
	if(!isdefined(self.shots))
	{
		self.shots = [];
	}
	if(!isdefined(self.shots[0]))
	{
		self.shots[0] = spawnstruct();
	}
	if(!isdefined(self.shots[0].entry))
	{
		self.shots[0].entry = [];
	}
	if(!isdefined(self.shots[0].entry[0]))
	{
		self.shots[0].entry[0] = spawnstruct();
	}
	if(!isdefined(self.shots[var_5e3936e3]))
	{
		self.shots[var_5e3936e3] = spawnstruct();
		self.shots[var_5e3936e3].entry = [];
		self.shots[var_5e3936e3].entry[0] = spawnstruct();
	}
	if(!isdefined(self.shots[var_5e3936e3].entry[var_651e3856]))
	{
		self.shots[var_5e3936e3].entry[var_651e3856] = spawnstruct();
	}
	self.shots[var_5e3936e3].entry[var_651e3856].(str_field) = var_8e9b7b3d;
}

/*
	Name: function_de24d5c1
	Namespace: scene
	Checksum: 0x895AAF24
	Offset: 0x1A90
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_de24d5c1(n_shot, str_shot_name)
{
	n_shot--;
	if(isdefined(self.shots[n_shot]))
	{
		self.shots[n_shot].name = str_shot_name;
	}
}

/*
	Name: function_77e159df
	Namespace: scene
	Checksum: 0x4E85BC0C
	Offset: 0x1AE8
	Size: 0xF0
	Parameters: 3
	Flags: Linked
*/
function function_77e159df(var_9b4eba84, str_field, var_8e9b7b3d)
{
	if(isstruct(var_9b4eba84))
	{
		var_9b4eba84.(str_field) = var_8e9b7b3d;
	}
	else
	{
		var_9b4eba84--;
		if(!isdefined(self.shots))
		{
			self.shots = [];
		}
		if(!isdefined(self.shots[0]))
		{
			self.shots[0] = spawnstruct();
		}
		if(!isdefined(self.shots[var_9b4eba84]))
		{
			self.shots[var_9b4eba84] = spawnstruct();
		}
		self.shots[var_9b4eba84].(str_field) = var_8e9b7b3d;
	}
}

/*
	Name: convert_to_new_format
	Namespace: scene
	Checksum: 0xAD4F7255
	Offset: 0x1BE0
	Size: 0x802
	Parameters: 1
	Flags: Linked
*/
function convert_to_new_format(s_scenedef)
{
	foreach(s_object in s_scenedef.objects)
	{
		s_object.old_scene_version = 1;
		b_has_init = 0;
		b_has_main = 0;
		b_has_camera = 0;
		if(isdefined(s_object.firstframe) && s_object.firstframe)
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 1, "anim", s_object.mainanim);
		}
		else if(isdefined(s_object.initanim))
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 1, "anim", s_object.initanim);
		}
		if(isdefined(s_object.initanimloop))
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 2, "anim", s_object.initanimloop);
		}
		if(isdefined(s_object.spawnoninit) && s_object.spawnoninit)
		{
			b_has_init = 1;
		}
		if(isdefined(s_object.cameraswitcher))
		{
			b_has_main = 1;
			b_has_camera = 1;
			s_scenedef.igc = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 1, "cameraswitcher", s_object.cameraswitcher);
			}
			else
			{
				s_object function_ceb43448(1, 1, "cameraswitcher", s_object.cameraswitcher);
			}
		}
		if(!isdefined(s_object.mainblend))
		{
			s_object.mainblend = 0.02;
		}
		b_has_main = 1;
		if(b_has_init)
		{
			if(b_has_camera)
			{
				s_object function_ceb43448(2, 2, "blend", s_object.mainblend);
			}
			else
			{
				s_object function_ceb43448(2, 1, "blend", s_object.mainblend);
			}
		}
		else if(b_has_camera)
		{
			s_object function_ceb43448(1, 2, "blend", s_object.mainblend);
		}
		else
		{
			s_object function_ceb43448(1, 1, "blend", s_object.mainblend);
		}
		if(isdefined(s_object.mainanim))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				if(b_has_camera)
				{
					s_object function_ceb43448(2, 3, "anim", s_object.mainanim);
				}
				else
				{
					s_object function_ceb43448(2, 2, "anim", s_object.mainanim);
				}
			}
			else if(b_has_camera)
			{
				s_object function_ceb43448(1, 3, "anim", s_object.mainanim);
			}
			else
			{
				s_object function_ceb43448(1, 2, "anim", s_object.mainanim);
			}
		}
		if(isdefined(s_object.endblend))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 3, "blend", s_object.endblend);
			}
			else
			{
				s_object function_ceb43448(1, 3, "blend", s_object.endblend);
			}
		}
		if(isdefined(s_object.endanim))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 4, "anim", s_object.endanim);
			}
			else
			{
				s_object function_ceb43448(1, 4, "anim", s_object.endanim);
			}
		}
		if(isdefined(s_object.endanimloop))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 5, "anim", s_object.endanimloop);
			}
			else
			{
				s_object function_ceb43448(1, 5, "anim", s_object.endanimloop);
			}
		}
		if(b_has_init)
		{
			s_object function_de24d5c1(1, "init");
			var_88263c0e = s_object.shots[0];
			if(isdefined(s_object.initdelaymin))
			{
				s_object function_77e159df(var_88263c0e, "SpacerMin", s_object.initdelaymin);
			}
			if(isdefined(s_object.initdelaymax))
			{
				s_object function_77e159df(var_88263c0e, "SpacerMax", s_object.initdelaymax);
			}
		}
		if(b_has_main)
		{
			if(b_has_init)
			{
				s_object function_de24d5c1(2, "play");
				var_992efde = s_object.shots[1];
			}
			else
			{
				s_object function_de24d5c1(1, "play");
				var_992efde = s_object.shots[0];
			}
			if(isdefined(s_object.maindelaymin))
			{
				s_object function_77e159df(var_992efde, "SpacerMin", s_object.maindelaymin);
			}
			if(isdefined(s_object.maindelaymax))
			{
				s_object function_77e159df(var_992efde, "SpacerMax", s_object.maindelaymax);
			}
		}
		s_object.initanim = undefined;
		s_object.initanimloop = undefined;
		s_object.mainblend = undefined;
		s_object.mainanim = undefined;
		s_object.endblend = undefined;
		s_object.endanim = undefined;
		s_object.endanimloop = undefined;
		s_object.initdelaymin = undefined;
		s_object.initdelaymax = undefined;
		s_object.maindelaymin = undefined;
		s_object.maindelaymax = undefined;
	}
	s_scenedef.old_scene_version = 1;
}

/*
	Name: get_all_shot_names
	Namespace: scene
	Checksum: 0x9D5B0BB2
	Offset: 0x23F0
	Size: 0x240
	Parameters: 2
	Flags: Linked
*/
function get_all_shot_names(str_scenedef, var_8c4d2266 = 0)
{
	s_scenedef = get_scenedef(str_scenedef);
	if(isdefined(s_scenedef.var_b5d05f70))
	{
		a_shots = arraycopy(s_scenedef.var_b5d05f70);
		if(var_8c4d2266)
		{
			arrayremovevalue(a_shots, "init");
		}
		return a_shots;
	}
	a_shots = [];
	foreach(s_object in s_scenedef.objects)
	{
		if(!(isdefined(s_object.disabled) && s_object.disabled))
		{
			foreach(s_shot in s_object.shots)
			{
				if(!isdefined(a_shots))
				{
					a_shots = [];
				}
				else if(!isarray(a_shots))
				{
					a_shots = array(a_shots);
				}
				if(!isinarray(a_shots, s_shot.name))
				{
					a_shots[a_shots.size] = s_shot.name;
				}
			}
		}
	}
	s_scenedef.var_b5d05f70 = a_shots;
	if(var_8c4d2266)
	{
		arrayremovevalue(a_shots, "init");
	}
	return a_shots;
}

/*
	Name: function_c3a1b36a
	Namespace: scene
	Checksum: 0xA5581C32
	Offset: 0x2638
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function function_c3a1b36a(str_scenedef)
{
	a_shots = arraycopy(get_all_shot_names(str_scenedef));
	arrayremovevalue(a_shots, "init");
	return a_shots[0];
}

/*
	Name: function_c9770402
	Namespace: scene
	Checksum: 0xA0AC76CB
	Offset: 0x26A8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_c9770402(str_scenedef)
{
	s_scenedef = get_scenedef(str_scenedef);
	if(isdefined(s_scenedef.str_final_bundle))
	{
		return s_scenedef.str_final_bundle;
	}
	if(isdefined(s_scenedef.var_418c40ac))
	{
		return s_scenedef.var_418c40ac;
	}
	a_shots = get_all_shot_names(str_scenedef);
	return a_shots[a_shots.size - 1];
}

/*
	Name: function_24f8cfb5
	Namespace: scene
	Checksum: 0xC49717E9
	Offset: 0x2748
	Size: 0x86
	Parameters: 2
	Flags: None
*/
function function_24f8cfb5(str_scenedef, str_shot)
{
	a_shots = get_all_shot_names(str_scenedef);
	if(str_shot == "init")
	{
		return 0;
	}
	arrayremovevalue(a_shots, "init");
	if(a_shots[0] === str_shot)
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_b260bdcc
	Namespace: scene
	Checksum: 0xD594A8E3
	Offset: 0x27D8
	Size: 0xB6
	Parameters: 2
	Flags: Linked
*/
function function_b260bdcc(str_scenedef, str_shot)
{
	var_418c40ac = function_c9770402(str_scenedef);
	s_scenedef = get_scenedef(str_scenedef);
	if(str_shot !== "init" && (str_shot === var_418c40ac || (isdefined(s_scenedef.old_scene_version) && s_scenedef.old_scene_version && str_shot === "play")))
	{
		return 1;
	}
	return 0;
}

/*
	Name: __main__
	Namespace: scene
	Checksum: 0x5ED17276
	Offset: 0x2898
	Size: 0x494
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
	function_d4c74ab3();
	foreach(s_instance in a_instances)
	{
		s_scenedef = getscriptbundle(s_instance.scriptbundlename);
		/#
			/#
				assert(isdefined(s_scenedef), ("" + function_9e72a96(s_instance.scriptbundlename)) + "");
			#/
		#/
		if(s_scenedef.vmtype === "client")
		{
			continue;
		}
		if(isdefined(s_instance.linkto))
		{
			s_instance thread _scene_link();
		}
		if(isdefined(s_instance.script_flag_set))
		{
			level flag::init(s_instance.script_flag_set);
		}
		if(isdefined(s_instance.scriptgroup_initscenes))
		{
			foreach(trig in getentarray(s_instance.scriptgroup_initscenes, "scriptgroup_initscenes"))
			{
				s_instance thread _trigger_init(trig);
			}
		}
		if(isdefined(s_instance.scriptgroup_playscenes))
		{
			foreach(trig in getentarray(s_instance.scriptgroup_playscenes, "scriptgroup_playscenes"))
			{
				s_instance thread _trigger_play(trig);
			}
		}
		if(isdefined(s_instance.scriptgroup_stopscenes))
		{
			foreach(trig in getentarray(s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes"))
			{
				s_instance thread _trigger_stop(trig);
			}
		}
		s_instance function_846ffeda();
		/#
			if(!isdefined(level.scene_roots))
			{
				level.scene_roots = [];
			}
			else if(!isarray(level.scene_roots))
			{
				level.scene_roots = array(level.scene_roots);
			}
			if(!isinarray(level.scene_roots, s_instance))
			{
				level.scene_roots[level.scene_roots.size] = s_instance;
			}
		#/
	}
	level thread on_load_wait();
	level thread run_instances();
}

/*
	Name: function_6f9a9e07
	Namespace: scene
	Checksum: 0xB6FB5014
	Offset: 0x2D38
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_6f9a9e07()
{
	if(isdefined(self.script_scene_nodes))
	{
		self.var_bf4dc147 = getnodearray(self.script_scene_nodes, "script_scene_nodes");
		foreach(node in self.var_bf4dc147)
		{
			setenablenode(node, 1);
		}
	}
}

/*
	Name: function_846ffeda
	Namespace: scene
	Checksum: 0x414B15D1
	Offset: 0x2DF8
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_846ffeda()
{
	if(isdefined(self.script_scene_nodes))
	{
		self.var_bf4dc147 = getnodearray(self.script_scene_nodes, "script_scene_nodes");
		foreach(node in self.var_bf4dc147)
		{
			setenablenode(node, 0);
		}
	}
}

/*
	Name: function_7cda7776
	Namespace: scene
	Checksum: 0xF1F92BA7
	Offset: 0x2EB8
	Size: 0x21E
	Parameters: 1
	Flags: Linked
*/
function function_7cda7776(var_faa74cb)
{
	if(self.classname === "scriptbundle_scene" && isdefined(self.script_scene_entities) && !isdefined(self get_active_scene(self.scriptbundlename)))
	{
		if(!isdefined(var_faa74cb))
		{
			var_faa74cb = [];
		}
		else if(!isarray(var_faa74cb))
		{
			var_faa74cb = array(var_faa74cb);
		}
		var_d3e0f43e = [];
		if(!isdefined(self.scene_ents))
		{
			var_d3e0f43e = getentarray(self.script_scene_entities, "script_scene_entities");
			var_d3e0f43e = array::remove_undefined(var_d3e0f43e);
			foreach(ent in arraycopy(var_d3e0f43e))
			{
				if(isspawner(ent) && ent.count === 0 || isactor(ent) || isvehicle(ent))
				{
					ent.script_scene_entities = undefined;
					arrayremovevalue(var_d3e0f43e, ent, 1);
				}
			}
		}
		a_ents = arraycombine(var_faa74cb, var_d3e0f43e, 0, 0);
	}
	else
	{
		a_ents = var_faa74cb;
	}
	return a_ents;
}

/*
	Name: function_d4c74ab3
	Namespace: scene
	Checksum: 0xF26A3953
	Offset: 0x30E0
	Size: 0x250
	Parameters: 0
	Flags: Linked
*/
function function_d4c74ab3()
{
	/#
		a_triggers = trigger::get_all();
		foreach(trig in a_triggers)
		{
			if(isdefined(trig.targetname))
			{
				str_trig_name = ("" + trig.targetname) + "";
			}
			else
			{
				str_trig_name = ("" + trig getentitynumber()) + "";
			}
			if(isdefined(trig.scriptgroup_initscenes))
			{
				a_instances = struct::get_array(trig.scriptgroup_initscenes, "");
				/#
					assert(a_instances.size, (("" + str_trig_name) + "") + trig.scriptgroup_initscenes);
				#/
			}
			if(isdefined(trig.scriptgroup_playscenes))
			{
				a_instances = struct::get_array(trig.scriptgroup_playscenes, "");
				/#
					assert(a_instances.size, (("" + str_trig_name) + "") + trig.scriptgroup_playscenes);
				#/
			}
			if(isdefined(trig.scriptgroup_stopscenes))
			{
				a_instances = struct::get_array(trig.scriptgroup_stopscenes, "");
				/#
					assert(a_instances.size, (("" + str_trig_name) + "") + trig.scriptgroup_stopscenes);
				#/
			}
		}
	#/
}

/*
	Name: _scene_link
	Namespace: scene
	Checksum: 0x2C29374F
	Offset: 0x3338
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function _scene_link()
{
	self.e_scene_link = util::spawn_model("tag_origin", self.origin, self.angles);
	e_linkto = getent(self.linkto, "linkname");
	self.e_scene_link linkto(e_linkto);
	util::waittill_any_ents_two(self, "death", e_linkto, "death");
	self.e_scene_link delete();
}

/*
	Name: on_load_wait
	Namespace: scene
	Checksum: 0x2EF619CE
	Offset: 0x3400
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function on_load_wait()
{
	util::wait_network_frame();
	util::wait_network_frame();
	level flagsys::set(#"scene_on_load_wait");
}

/*
	Name: run_instances
	Namespace: scene
	Checksum: 0x8715FC28
	Offset: 0x3450
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function run_instances()
{
	foreach(s_instance in struct::get_script_bundle_instances("scene"))
	{
		if(getscriptbundle(s_instance.scriptbundlename).vmtype === "client")
		{
			s_instance struct::delete();
			continue;
		}
		if(isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 2) == 2)
		{
			s_instance thread play();
			continue;
		}
		if(isdefined(s_instance.spawnflags) && (s_instance.spawnflags & 1) == 1)
		{
			s_instance thread init();
		}
	}
}

/*
	Name: _trigger_init
	Namespace: scene
	Checksum: 0x889437CB
	Offset: 0x35A0
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function _trigger_init(trig)
{
	trig endon(#"death");
	trig trigger::wait_till();
	a_ents = [];
	if(get_player_count(self.scriptbundlename) > 0)
	{
		if(isplayer(trig.who))
		{
			a_ents[0] = trig.who;
		}
	}
	self thread init(a_ents);
}

/*
	Name: _trigger_play
	Namespace: scene
	Checksum: 0x725065B6
	Offset: 0x3658
	Size: 0xF8
	Parameters: 1
	Flags: Linked
*/
function _trigger_play(trig)
{
	trig endon(#"death");
	do
	{
		trig trigger::wait_till();
		a_ents = [];
		if(get_player_count(self.scriptbundlename) > 0)
		{
			if(isplayer(trig.who))
			{
				a_ents[0] = trig.who;
			}
		}
		self thread play(a_ents);
	}
	while(isdefined(getscriptbundle(self.scriptbundlename).looping) && getscriptbundle(self.scriptbundlename).looping);
}

/*
	Name: _trigger_stop
	Namespace: scene
	Checksum: 0x3B1B9E39
	Offset: 0x3758
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function _trigger_stop(trig)
{
	trig endon(#"death");
	trig trigger::wait_till();
	self thread stop();
}

/*
	Name: add_scene_func
	Namespace: scene
	Checksum: 0xD0AAF22
	Offset: 0x37B0
	Size: 0x1E4
	Parameters: 4
	Flags: Linked, Variadic
*/
function add_scene_func(str_scenedef, func, var_e21c4c4c = "play", vararg)
{
	/#
		/#
			assert(isdefined(getscriptbundle(str_scenedef)), ("" + function_9e72a96(str_scenedef)) + "");
		#/
	#/
	if(!isdefined(level.scene_funcs))
	{
		level.scene_funcs = [];
	}
	if(!isdefined(level.scene_funcs[str_scenedef]))
	{
		level.scene_funcs[str_scenedef] = [];
	}
	var_e21c4c4c = tolower(var_e21c4c4c);
	str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
	if(!isdefined(level.scene_funcs[str_scenedef][str_shot]))
	{
		level.scene_funcs[str_scenedef][str_shot] = [];
	}
	if(var_e21c4c4c === "play" && str_shot !== "play")
	{
		array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg, 1), 0);
	}
	else
	{
		array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg), 0);
	}
}

/*
	Name: function_d8a83a50
	Namespace: scene
	Checksum: 0x4CFEA210
	Offset: 0x39A0
	Size: 0x1E4
	Parameters: 4
	Flags: Linked, Variadic
*/
function function_d8a83a50(str_scenedef, func, var_e21c4c4c = "play", vararg)
{
	/#
		/#
			assert(isdefined(getscriptbundle(str_scenedef)), ("" + function_9e72a96(str_scenedef)) + "");
		#/
	#/
	if(!isdefined(level.var_4247a0d6))
	{
		level.var_4247a0d6 = [];
	}
	if(!isdefined(level.var_4247a0d6[str_scenedef]))
	{
		level.var_4247a0d6[str_scenedef] = [];
	}
	var_e21c4c4c = tolower(var_e21c4c4c);
	str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
	if(!isdefined(level.var_4247a0d6[str_scenedef][str_shot]))
	{
		level.var_4247a0d6[str_scenedef][str_shot] = [];
	}
	if(var_e21c4c4c === "play" && str_shot !== "play")
	{
		array::add(level.var_4247a0d6[str_scenedef][str_shot], array(func, vararg, 1), 0);
	}
	else
	{
		array::add(level.var_4247a0d6[str_scenedef][str_shot], array(func, vararg), 0);
	}
}

/*
	Name: remove_scene_func
	Namespace: scene
	Checksum: 0xEAD819D1
	Offset: 0x3B90
	Size: 0x25E
	Parameters: 3
	Flags: Linked
*/
function remove_scene_func(str_scenedef, func, var_e21c4c4c = "play")
{
	/#
		/#
			assert(isdefined(getscriptbundle(str_scenedef)), ("" + str_scenedef) + "");
		#/
	#/
	if(!isdefined(level.scene_funcs))
	{
		level.scene_funcs = [];
	}
	if(!isdefined(level.var_4247a0d6))
	{
		level.var_4247a0d6 = [];
	}
	var_e21c4c4c = tolower(var_e21c4c4c);
	str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
	if(isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_shot]))
	{
		for(i = level.scene_funcs[str_scenedef][str_shot].size - 1; i >= 0; i--)
		{
			if(level.scene_funcs[str_scenedef][str_shot][i][0] == func)
			{
				arrayremoveindex(level.scene_funcs[str_scenedef][str_shot], i);
			}
		}
	}
	if(isdefined(level.var_4247a0d6[str_scenedef]) && isdefined(level.var_4247a0d6[str_scenedef][str_shot]))
	{
		for(i = level.var_4247a0d6[str_scenedef][str_shot].size - 1; i >= 0; i--)
		{
			if(level.var_4247a0d6[str_scenedef][str_shot][i][0] == func)
			{
				arrayremoveindex(level.var_4247a0d6[str_scenedef][str_shot], i);
			}
		}
	}
}

/*
	Name: function_c776e5bd
	Namespace: scene
	Checksum: 0x92DA4319
	Offset: 0x3DF8
	Size: 0x92
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c776e5bd(str_scenedef, str_state)
{
	str_shot = str_state;
	if(str_state == "init")
	{
		str_shot = function_de6a7579(str_scenedef, "init");
	}
	else if(str_state == "play")
	{
		str_shot = function_de6a7579(str_scenedef, "play");
	}
	return str_shot;
}

/*
	Name: get_scenedef
	Namespace: scene
	Checksum: 0x65520E86
	Offset: 0x3E98
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function get_scenedef(str_scenedef)
{
	s_scriptbundle = getscriptbundle(str_scenedef);
	/#
		/#
			assert(isdefined(s_scriptbundle) && isdefined(s_scriptbundle.objects), ("" + function_9e72a96(str_scenedef)) + "");
		#/
	#/
	s_scriptbundle = fixup_scenedef(s_scriptbundle);
	return s_scriptbundle;
}

/*
	Name: get_scenedefs
	Namespace: scene
	Checksum: 0xC30AADDD
	Offset: 0x3F48
	Size: 0x138
	Parameters: 1
	Flags: None
*/
function get_scenedefs(str_type = "scene")
{
	a_scenedefs = [];
	foreach(s_scenedef in getscriptbundles("scene"))
	{
		if(s_scenedef.scenetype === str_type && s_scenedef.vmtype !== "client")
		{
			s_scenedef = fixup_scenedef(s_scenedef);
			if(!isdefined(a_scenedefs))
			{
				a_scenedefs = [];
			}
			else if(!isarray(a_scenedefs))
			{
				a_scenedefs = array(a_scenedefs);
			}
			a_scenedefs[a_scenedefs.size] = s_scenedef;
		}
	}
	return a_scenedefs;
}

/*
	Name: spawn
	Namespace: scene
	Checksum: 0x93E13261
	Offset: 0x4088
	Size: 0x178
	Parameters: 5
	Flags: None
*/
function spawn(arg1, arg2, arg3, arg4, b_test_run)
{
	str_scenedef = arg1;
	/#
		assert(isdefined(str_scenedef), "");
	#/
	if(isvec(arg2))
	{
		v_origin = arg2;
		v_angles = arg3;
		a_ents = arg4;
	}
	else
	{
		a_ents = arg2;
		v_origin = arg3;
		v_angles = arg4;
	}
	s_instance = spawnstruct();
	s_instance.origin = (isdefined(v_origin) ? v_origin : (0, 0, 0));
	s_instance.angles = (isdefined(v_angles) ? v_angles : (0, 0, 0));
	s_instance.classname = "scriptbundle_scene";
	s_instance.scriptbundlename = str_scenedef;
	s_instance struct::init();
	s_instance init(str_scenedef, a_ents, undefined, b_test_run);
	return s_instance;
}

/*
	Name: init
	Namespace: scene
	Checksum: 0x72A8E47B
	Offset: 0x4208
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function init(arg1, arg2, arg3, b_test_run)
{
	self thread play(arg1, arg2, arg3, b_test_run, "init");
}

/*
	Name: function_27f5972e
	Namespace: scene
	Checksum: 0x79E6529F
	Offset: 0x4268
	Size: 0x102
	Parameters: 3
	Flags: Linked
*/
function function_27f5972e(str_scenedef, var_a068ac72, var_cdab6c2c)
{
	if(self == level)
	{
		array::run_all(level.players, &forcestreambundle, str_scenedef, var_a068ac72, var_cdab6c2c);
	}
	else
	{
		self forcestreambundle(str_scenedef, var_a068ac72, var_cdab6c2c);
	}
	if(!isdefined(self.var_cb8ed5f0))
	{
		self.var_cb8ed5f0 = [];
	}
	else if(!isarray(self.var_cb8ed5f0))
	{
		self.var_cb8ed5f0 = array(self.var_cb8ed5f0);
	}
	if(!isinarray(self.var_cb8ed5f0, str_scenedef))
	{
		self.var_cb8ed5f0[self.var_cb8ed5f0.size] = str_scenedef;
	}
}

/*
	Name: function_f81475ae
	Namespace: scene
	Checksum: 0x7FFFFC7D
	Offset: 0x4378
	Size: 0x9C
	Parameters: 3
	Flags: Linked
*/
function function_f81475ae(str_scenedef, var_a068ac72, var_cdab6c2c)
{
	if(!isdefined(self.var_cb8ed5f0))
	{
		self.var_cb8ed5f0 = [];
	}
	if(self == level)
	{
		array::run_all(level.players, &function_66b6e720, str_scenedef);
	}
	else
	{
		self function_66b6e720(str_scenedef);
	}
	arrayremovevalue(self.var_cb8ed5f0, str_scenedef);
}

/*
	Name: function_cef06dcb
	Namespace: scene
	Checksum: 0x7F4C79D8
	Offset: 0x4420
	Size: 0x98
	Parameters: 0
	Flags: Linked
*/
function function_cef06dcb()
{
	if(!isdefined(self.var_cb8ed5f0))
	{
		self.var_cb8ed5f0 = [];
	}
	foreach(str_scenedef in self.var_cb8ed5f0)
	{
		level function_f81475ae(str_scenedef);
	}
}

/*
	Name: init_streamer
	Namespace: scene
	Checksum: 0xAF90927A
	Offset: 0x44C0
	Size: 0x4D4
	Parameters: 4
	Flags: Linked
*/
function init_streamer(str_scenedef, var_1b38cf1d, var_b6213032 = 0, b_invulnerable = 1)
{
	s_scenedef = get_scenedef(str_scenedef);
	if(isstring(var_1b38cf1d) || function_7a600918(var_1b38cf1d))
	{
		var_1b38cf1d = util::get_team_mapping(var_1b38cf1d);
	}
	level flag::wait_till("all_players_spawned");
	if(isarray(var_1b38cf1d))
	{
		a_players = var_1b38cf1d;
		if(!a_players.size)
		{
			return;
		}
		foreach(player in a_players)
		{
			if(player.team === #"allies")
			{
				player thread function_1f9e783e(s_scenedef.var_a6da2039, str_scenedef);
				continue;
			}
			if(player.team === #"axis")
			{
				player thread function_1f9e783e(s_scenedef.var_991a84ba, str_scenedef);
			}
		}
	}
	else if(var_1b38cf1d == #"allies" && isdefined(s_scenedef.var_a6da2039))
	{
		a_players = util::get_players(#"allies");
		array::thread_all(a_players, &function_1f9e783e, s_scenedef.var_a6da2039, str_scenedef);
	}
	else if(var_1b38cf1d == #"axis" && isdefined(s_scenedef.var_991a84ba))
	{
		a_players = util::get_players(#"axis");
		array::thread_all(a_players, &function_1f9e783e, s_scenedef.var_991a84ba, str_scenedef);
	}
	else
	{
		return;
	}
	if(level flag::exists("draft_complete"))
	{
		level flag::wait_till("draft_complete");
	}
	/#
		iprintln("" + function_9e72a96(str_scenedef));
	#/
	if(var_b6213032)
	{
		array::thread_all(a_players, &val::set, "init_streamer", "freezecontrols", 1);
		array::thread_all(a_players, &lui::screen_fade_out, 0, undefined, "init_streamer");
	}
	if(b_invulnerable)
	{
		array::thread_all(a_players, &val::set, "init_streamer", "takedamage", 0);
	}
	array::wait_till(a_players, "init_streamer_done", 10);
	if(var_b6213032)
	{
		array::thread_all(a_players, &val::reset, "init_streamer", "freezecontrols");
		array::thread_all(a_players, &util::delay, 0.2, "disconnect", &lui::screen_fade_in, 1, undefined, "init_streamer");
	}
	if(b_invulnerable)
	{
		array::thread_all(a_players, &val::reset, "init_streamer", "takedamage");
	}
}

/*
	Name: function_1f9e783e
	Namespace: scene
	Checksum: 0xE0D45F79
	Offset: 0x49A0
	Size: 0x156
	Parameters: 2
	Flags: Linked, Private
*/
private function function_1f9e783e(var_5c8c4fbc, str_scenedef)
{
	self endon(#"disconnect");
	self flagsys::set(#"player_streamer_loading");
	if(level flag::exists("draft_complete"))
	{
		level flag::wait_till("draft_complete");
	}
	if(!isdefined(self.var_231881b1))
	{
		self.var_231881b1 = [];
	}
	if(!isdefined(self.var_16672042))
	{
		self.var_16672042 = [];
	}
	self.var_231881b1[str_scenedef] = var_5c8c4fbc;
	self.var_16672042[str_scenedef] = self playerstreamerrequest("set", var_5c8c4fbc);
	self util::streamer_wait(self.var_16672042[str_scenedef], undefined, 10);
	self flagsys::clear(#"player_streamer_loading");
	self notify(#"init_streamer_done");
}

/*
	Name: _init_instance
	Namespace: scene
	Checksum: 0xACF58CAA
	Offset: 0x4B00
	Size: 0x220
	Parameters: 3
	Flags: Linked
*/
function _init_instance(str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0)
{
	level flagsys::wait_till("scene_on_load_wait");
	/#
		if(array().size && !isinarray(array(), str_scenedef))
		{
			return;
		}
	#/
	s_bundle = get_scenedef((isdefined(self.var_e87a94f3) ? self.var_e87a94f3 : str_scenedef));
	if(!function_6f382548(s_bundle, str_scenedef))
	{
		return;
	}
	/#
		/#
			assert(isdefined(str_scenedef), ("" + (isdefined(self.origin) ? self.origin : "")) + "");
		#/
		/#
			assert(isdefined(s_bundle), ((("" + (isdefined(self.origin) ? self.origin : "")) + "") + str_scenedef) + "");
		#/
	#/
	if(!(isdefined(self.var_146935c1) && self.var_146935c1))
	{
		o_scene = get_active_scene(str_scenedef);
	}
	if(!isdefined(o_scene))
	{
		object = new cscene();
		[[ object ]]->__constructor();
		o_scene = object;
		[[ o_scene ]]->init(str_scenedef, s_bundle, self, a_ents, b_test_run);
	}
	return o_scene;
}

/*
	Name: function_6f382548
	Namespace: scene
	Checksum: 0x99F6CEA6
	Offset: 0x4D28
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function function_6f382548(struct, str_scene_name)
{
	if(!isdefined(struct.var_87403372) || !(getdvarint(#"splitscreen_playercount", 1) > 1))
	{
		return 1;
	}
	if(struct.var_87403372 == 2 && getdvarint(#"splitscreen_playercount", 1) > 1 || (struct.var_87403372 == 3 && getdvarint(#"splitscreen_playercount", 1) > 2) || (struct.var_87403372 == 4 && getdvarint(#"splitscreen_playercount", 1) > 3))
	{
		/#
			if(struct.type === "")
			{
				str_debug = ("" + function_9e72a96(str_scene_name)) + "";
			}
			else
			{
				str_debug = ((("" + function_9e72a96(struct.name)) + "") + str_scene_name) + "";
			}
			println(str_debug);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: _load_female_scene
	Namespace: scene
	Checksum: 0x8C2FB7A8
	Offset: 0x4F10
	Size: 0x238
	Parameters: 2
	Flags: None
*/
function _load_female_scene(s_bundle, a_ents)
{
	b_has_player = 0;
	foreach(s_object in s_bundle.objects)
	{
		if(!isdefined(s_object))
		{
			continue;
		}
		if(s_object.type === "player")
		{
			b_has_player = 1;
			break;
		}
	}
	if(b_has_player)
	{
		e_player = undefined;
		if(isplayer(a_ents))
		{
			e_player = a_ents;
		}
		else if(isarray(a_ents))
		{
			foreach(ent in a_ents)
			{
				if(isplayer(ent))
				{
					e_player = ent;
					break;
				}
			}
		}
		if(!isdefined(e_player) && isdefined(level.activeplayers))
		{
			e_player = level.activeplayers[0];
		}
		if(isplayer(e_player) && e_player util::is_female())
		{
			if(isdefined(s_bundle.femalebundle))
			{
				s_female_bundle = struct::get_script_bundle("scene", s_bundle.femalebundle);
				if(isdefined(s_female_bundle))
				{
					return s_female_bundle;
				}
			}
		}
	}
	return s_bundle;
}

/*
	Name: function_de6a7579
	Namespace: scene
	Checksum: 0x4D476C46
	Offset: 0x5150
	Size: 0x112
	Parameters: 2
	Flags: Linked
*/
function function_de6a7579(str_scenedef, str_mode)
{
	a_shots = get_all_shot_names(str_scenedef);
	if(a_shots.size == 0)
	{
		return "play";
	}
	if(str_mode !== "init")
	{
		if(a_shots[0] !== "init")
		{
			str_shot = a_shots[0];
		}
		else if(a_shots.size > 1)
		{
			str_shot = a_shots[1];
		}
	}
	else if(str_mode === "init")
	{
		if(isinarray(a_shots, "init"))
		{
			str_shot = "init";
		}
		else
		{
			str_shot = a_shots[0];
		}
	}
	if(!isdefined(str_shot))
	{
		str_shot = "play";
	}
	return str_shot;
}

/*
	Name: play
	Namespace: scene
	Checksum: 0xEDBBFA4D
	Offset: 0x5270
	Size: 0x7CC
	Parameters: 7
	Flags: Linked
*/
function play(arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time, var_f7d56e76)
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			if(isdefined(arg1) && (isstring(arg1) || function_7a600918(arg1)))
			{
				printtoprightln("" + function_9e72a96(arg1));
			}
			else
			{
				printtoprightln("");
			}
		}
	#/
	s_tracker = spawnstruct();
	s_tracker.n_scene_count = 0;
	if(self == level)
	{
		a_instances = [];
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg1) && issubstr(arg1, ","))
			{
				a_toks = strtok(arg1, ",");
				str_value = a_toks[0];
				str_key = a_toks[1];
				if(isstring(arg2))
				{
					str_shot = tolower(arg2);
					a_ents = arg3;
				}
				else
				{
					a_ents = arg2;
				}
			}
			else if(isinarray(level.scenedefs, hash(arg1)))
			{
				str_scenedef = arg1;
				var_583db6f0 = 1;
			}
			else
			{
				str_value = arg1;
				str_key = "targetname";
			}
			if(isstring(arg2))
			{
				if(isinarray(array("targetname", "script_noteworthy"), arg2))
				{
					str_key = arg2;
				}
				else
				{
					str_shot = tolower(arg2);
					var_5b51581a = 1;
				}
				a_ents = arg3;
			}
			else
			{
				a_ents = arg2;
			}
			a_instances = _get_scene_instances(str_value, str_key, str_scenedef);
			if(a_instances.size)
			{
				s_tracker.n_scene_count = a_instances.size;
				foreach(s_instance in a_instances)
				{
					if(isdefined(s_instance))
					{
						if(str_mode !== "init" && s_instance function_c8dd0fee())
						{
							s_instance.var_538fcf13 = 1;
							loc_000056CC:
							s_instance function_845e67f0((isdefined(s_instance.script_notify) ? s_instance.script_notify : s_instance.script_wait), (isdefined(s_instance.script_waittill) ? s_instance.script_waittill : s_instance.script_timer), var_f7d56e76);
							return;
						}
						if(!(isdefined(var_583db6f0) && var_583db6f0))
						{
							str_scenedef = s_instance.scriptbundlename;
						}
						if(!(isdefined(var_5b51581a) && var_5b51581a))
						{
							str_shot = function_de6a7579(str_scenedef, str_mode);
						}
						else
						{
							/#
								if(str_mode === "")
								{
									iprintlnbold("");
									println("");
								}
							#/
							if(str_mode === "loop")
							{
								str_mode = "single_loop";
							}
							else if(str_mode !== "init" && !issubstr(str_mode, "play_from_time") && !strstartswith(str_mode, "capture"))
							{
								str_mode = "single";
							}
						}
						var_a810addd = s_instance function_7cda7776(a_ents);
						s_instance thread _play_instance(s_tracker, str_scenedef, var_a810addd, b_test_run, str_shot, str_mode, n_time);
					}
				}
			}
			else if(str_mode !== "init" && self function_c8dd0fee())
			{
				self.var_538fcf13 = 1;
				self function_845e67f0((isdefined(self.script_notify) ? self.script_notify : self.script_wait), (isdefined(self.script_waittill) ? self.script_waittill : self.script_timer), var_f7d56e76);
				return;
			}
			_play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
		}
	}
	else if(str_mode !== "init" && self function_c8dd0fee())
	{
		self.var_538fcf13 = 1;
		self function_845e67f0((isdefined(self.script_notify) ? self.script_notify : self.script_wait), (isdefined(self.script_waittill) ? self.script_waittill : self.script_timer), var_f7d56e76);
		return;
	}
	_play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
	if(s_tracker.n_scene_count > 0)
	{
		s_tracker waittill(#"scenes_done", #"death");
	}
}

/*
	Name: function_c8dd0fee
	Namespace: scene
	Checksum: 0x8D8A107C
	Offset: 0x5A48
	Size: 0xA0
	Parameters: 0
	Flags: Linked
*/
function function_c8dd0fee()
{
	if(!isdefined(self))
	{
		return 0;
	}
	if(self.classname === "scriptbundle_scene" && isdefined(self.scriptbundlename))
	{
		if(!(isdefined(self.var_538fcf13) && self.var_538fcf13) && function_9730988a(self.scriptbundlename, "breach_init") && function_9730988a(self.scriptbundlename, "breach_play"))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_1d2f3816
	Namespace: scene
	Checksum: 0x738EEAE5
	Offset: 0x5AF0
	Size: 0x4C
	Parameters: 4
	Flags: None
*/
function function_1d2f3816(arg1, arg2, arg3, var_f7d56e76)
{
	self play(arg1, arg2, arg3, undefined, undefined, undefined, var_f7d56e76);
}

/*
	Name: function_845e67f0
	Namespace: scene
	Checksum: 0x1B1FE922
	Offset: 0x5B48
	Size: 0x26E
	Parameters: 3
	Flags: Linked
*/
function function_845e67f0(var_b93683c = 0, var_3667c53d = 4, var_f7d56e76 = array())
{
	self thread play("breach_init");
	if(isstring(var_b93683c) || function_7a600918(var_b93683c))
	{
		level waittill(var_b93683c);
	}
	else
	{
		wait(var_b93683c);
	}
	a_ai = [];
	foreach(ent in self.scene_ents)
	{
		if(isai(ent) && !ent util::is_on_side(#"allies"))
		{
			array::add(a_ai, ent, 0);
		}
	}
	a_ai = arraycombine(a_ai, var_f7d56e76, 0, 0);
	self thread function_9bf1aeb9(a_ai);
	self thread breach_slow_time(var_3667c53d);
	self play("breach_play");
	self waittill(#"breach_done");
	if(function_9730988a(self.scriptbundlename, "breach_end"))
	{
		self play("breach_end");
	}
	if(isdefined(self.script_play_multiple) && self.script_play_multiple)
	{
		self.var_538fcf13 = undefined;
	}
}

/*
	Name: breach_slow_time
	Namespace: scene
	Checksum: 0xCD5AE6D1
	Offset: 0x5DC0
	Size: 0x1FE
	Parameters: 1
	Flags: Linked
*/
function breach_slow_time(var_3667c53d)
{
	setslowmotion(1, 0.3, 0.3);
	foreach(e_player in util::get_players())
	{
		e_player setmovespeedscale(0.3);
	}
	wait(0.3);
	if(isstring(var_3667c53d) || function_7a600918(var_3667c53d))
	{
		util::waittill_any_ents(self, "breach_cleared", level, var_3667c53d);
	}
	else
	{
		var_a1288aec = var_3667c53d * 0.3;
		self waittill_timeout(var_a1288aec, #"breach_cleared");
	}
	setslowmotion(0.3, 1, 0.3);
	foreach(e_player in util::get_players())
	{
		e_player setmovespeedscale(1);
	}
	self notify(#"breach_done");
}

/*
	Name: function_9bf1aeb9
	Namespace: scene
	Checksum: 0x1523EF09
	Offset: 0x5FC8
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function function_9bf1aeb9(a_ai)
{
	self endon(#"breach_done");
	a_ai = array::remove_dead(a_ai);
	if(a_ai.size > 0)
	{
		ai::waittill_dead(a_ai);
	}
	else
	{
		wait(0.5);
	}
	self notify(#"breach_cleared");
}

/*
	Name: play_pair
	Namespace: scene
	Checksum: 0x916437AB
	Offset: 0x6048
	Size: 0x3D0
	Parameters: 4
	Flags: None
*/
function play_pair(var_a33156af, var_6a5164f0, var_b6213032 = 0, var_d8b95786 = 0)
{
	if(var_b6213032)
	{
		var_487b41e7 = getscriptbundle(var_a33156af);
		if(var_487b41e7.team === "wun")
		{
			function_d8a83a50(var_a33156af, &function_cae579da, "done", #"allies");
		}
		else if(var_487b41e7.team === "fpa")
		{
			function_d8a83a50(var_a33156af, &function_cae579da, "done", #"axis");
		}
		var_64d57a9b = getscriptbundle(var_6a5164f0);
		if(var_64d57a9b.team === "wun")
		{
			function_d8a83a50(var_6a5164f0, &function_cae579da, "done", #"allies");
		}
		else if(var_64d57a9b.team === "fpa")
		{
			function_d8a83a50(var_6a5164f0, &function_cae579da, "done", #"axis");
		}
		var_487b41e7 = undefined;
		var_64d57a9b = undefined;
		if(var_d8b95786)
		{
			level.var_7ddd2b02 = 0;
		}
	}
	self thread play(var_a33156af);
	self thread play(var_6a5164f0);
	a_flags = array(var_a33156af + "_scene_done", var_6a5164f0 + "_scene_done");
	level flag::wait_till_all(a_flags);
	if(var_b6213032)
	{
		util::wait_network_frame();
		remove_scene_func(var_a33156af, &function_cae579da, "done");
		remove_scene_func(var_6a5164f0, &function_cae579da, "done");
		a_players = util::get_players();
		foreach(player in a_players)
		{
			player val::set(#"hash_588e644c65309ea3", "freezecontrols", 1);
			if(!var_d8b95786)
			{
				player util::delay(0.1, "disconnect", &lui::screen_fade_in, 1, undefined, "scene_system");
			}
		}
	}
}

/*
	Name: function_cae579da
	Namespace: scene
	Checksum: 0x42520B6E
	Offset: 0x6420
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_cae579da(str_team)
{
	a_players = util::get_players(str_team);
	foreach(player in a_players)
	{
		player val::set(#"hash_588e644c65309ea3", "freezecontrols", 1);
		player thread lui::screen_fade_out(0, undefined, "scene_system");
	}
}

/*
	Name: _play_on_self
	Namespace: scene
	Checksum: 0x5110C86D
	Offset: 0x6500
	Size: 0x2BC
	Parameters: 7
	Flags: Linked
*/
function _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time)
{
	if(isstring(arg1) || function_7a600918(arg1))
	{
		if(isinarray(level.scenedefs, hash(arg1)))
		{
			str_scenedef = arg1;
			if(isstring(arg2))
			{
				str_shot = tolower(arg2);
				a_ents = arg3;
			}
			else
			{
				a_ents = arg2;
			}
		}
		else
		{
			str_shot = tolower(arg1);
			a_ents = arg2;
		}
	}
	else if(isarray(arg1) || isentity(arg1))
	{
		str_scenedef = self.scriptbundlename;
		a_ents = arg1;
	}
	else
	{
		str_scenedef = self.scriptbundlename;
	}
	s_tracker.n_scene_count = 1;
	if(!isdefined(str_shot) && isdefined(str_scenedef))
	{
		str_shot = function_de6a7579(str_scenedef, str_mode);
	}
	else if(isdefined(str_shot))
	{
		/#
			if(str_mode === "")
			{
				iprintlnbold("");
				println("");
			}
		#/
		if(str_mode !== "init" && !issubstr(str_mode, "play_from_time"))
		{
			str_mode = "single";
		}
	}
	var_a810addd = self function_7cda7776(a_ents);
	self thread _play_instance(s_tracker, str_scenedef, var_a810addd, b_test_run, str_shot, str_mode, n_time);
}

/*
	Name: _play_instance
	Namespace: scene
	Checksum: 0xABB56B3E
	Offset: 0x67C8
	Size: 0x76E
	Parameters: 7
	Flags: Linked
*/
function _play_instance(s_tracker, str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0, str_shot = "play", str_mode, n_time)
{
	if(isdefined(n_time) && issubstr(str_mode, "play_from_time"))
	{
		var_8b21886e = function_d1abba8b(str_scenedef, str_mode, n_time);
		str_shot = var_8b21886e.var_ef711d04;
		var_dd2b75b = var_8b21886e.var_3486c904;
		str_mode = str_mode + (":" + var_dd2b75b);
	}
	if(str_mode === "init")
	{
		str_shot = function_de6a7579(str_scenedef, str_mode);
	}
	/#
		if(array().size && !isinarray(array(), str_scenedef))
		{
			return;
		}
	#/
	if(level flag::get(str_scenedef + "_scene_done"))
	{
		level flag::clear(str_scenedef + "_scene_done");
		var_d43c0257 = getscriptbundle(str_scenedef);
		while(isdefined(var_d43c0257.nextscenebundle))
		{
			var_d43c0257 = getscriptbundle(var_d43c0257.nextscenebundle);
			level flag::clear(var_d43c0257.name + "_scene_done");
		}
	}
	b_play = 1;
	if(str_mode !== "init" && isdefined(self.script_delay) && self.script_delay > 0)
	{
		wait(self.script_delay);
	}
	if(self.scriptbundlename === str_scenedef)
	{
		if(!(isdefined(self.script_play_multiple) && self.script_play_multiple))
		{
			if(!isdefined(self.scene_played))
			{
				self.scene_played = [];
			}
			if(isdefined(self.scene_played[str_shot]) && self.scene_played[str_shot] && !b_test_run)
			{
				waittillframeend();
				while(is_playing(str_scenedef, str_shot))
				{
					waitframe(1);
				}
				b_play = 0;
				/#
					println(("" + str_scenedef) + "");
				#/
			}
		}
		if(str_mode == "init")
		{
			self.scene_played[str_shot] = 0;
		}
		else
		{
			self.scene_played[str_shot] = 1;
		}
	}
	if(b_play)
	{
		if(isdefined(self.script_teleport_location))
		{
			self teleport::function_ff8a7a3();
		}
		o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
		/#
			function_8ee42bf(o_scene);
		#/
		if(isdefined(o_scene))
		{
			thread [[ o_scene ]]->play(str_shot, a_ents, b_test_run, str_mode);
			if(isdefined(o_scene._a_objects) && o_scene._a_objects.size)
			{
				o_scene waittill(str_shot, #"hash_27297a73bc597607");
			}
		}
		if(isdefined(self))
		{
			if(isdefined(self.scriptbundlename) && (isdefined(getscriptbundle(self.scriptbundlename).looping) && getscriptbundle(self.scriptbundlename).looping))
			{
				self.scene_played[str_shot] = 0;
			}
		}
	}
	var_f62e21cb = function_c9770402(str_scenedef);
	if(isdefined(var_f62e21cb) && str_shot != "init" && str_mode != "single" && str_mode != "init")
	{
		var_41c1a1b7 = getscriptbundle(str_scenedef);
		var_8701de52 = getscriptbundle(var_f62e21cb);
		if(isdefined(var_8701de52) && var_8701de52.type === "scene" && var_8701de52 !== var_41c1a1b7)
		{
			var_8c2eecb3 = var_41c1a1b7.name;
			level waittill(var_41c1a1b7.str_final_bundle + "_done");
			if(str_shot == "play")
			{
				level flag::set(var_8c2eecb3 + "_scene_done");
			}
		}
		else if(!function_b260bdcc(str_scenedef, str_shot))
		{
			if(isdefined(o_scene) && (!(isdefined(o_scene.scene_stopping) && o_scene.scene_stopping)))
			{
				o_scene waittill(#"scene_done", #"scene_stop", #"scene_skip_completed");
			}
		}
	}
	s_tracker.n_scene_count--;
	if(s_tracker.n_scene_count == 0)
	{
		level flag::set(str_scenedef + "_scene_done");
		if(isdefined(self) && isdefined(self.script_flag_set) && str_mode !== "init")
		{
			level flag::set(self.script_flag_set);
		}
		/#
			function_8ee42bf(o_scene);
		#/
		s_tracker notify(#"scenes_done");
		if(isdefined(self))
		{
			self notify(#"scenes_done");
		}
	}
}

/*
	Name: delete_scene_spawned_ents
	Namespace: scene
	Checksum: 0xCA928234
	Offset: 0x6F40
	Size: 0x23C
	Parameters: 1
	Flags: None
*/
function delete_scene_spawned_ents(arg1)
{
	if(self == level)
	{
		a_instances = [];
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg1) && issubstr(arg1, ","))
			{
				a_toks = strtok(arg1, ",");
				str_value = a_toks[0];
				str_key = a_toks[1];
			}
			else if(isinarray(level.scenedefs, hash(arg1)))
			{
				str_scenedef = arg1;
			}
			else
			{
				str_value = arg1;
				str_key = "targetname";
			}
			a_instances = _get_scene_instances(str_value, str_key, str_scenedef, 1);
			if(a_instances.size)
			{
				foreach(instance in a_instances)
				{
					instance _delete_scene_spawned_ents(str_scenedef);
				}
			}
		}
	}
	else if(isstring(arg1) || function_7a600918(arg1))
	{
		str_scenedef = arg1;
	}
	self _delete_scene_spawned_ents(str_scenedef);
}

/*
	Name: _delete_scene_spawned_ents
	Namespace: scene
	Checksum: 0x57631972
	Offset: 0x7188
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function _delete_scene_spawned_ents(str_scene)
{
	if(isdefined(self.scene_ents))
	{
		foreach(ent in self.scene_ents)
		{
			if(isdefined(ent) && isdefined(ent.scene_spawned))
			{
				ent delete();
			}
		}
		/#
			if(isdefined(str_scene))
			{
				update_debug_state(str_scene, "");
			}
		#/
	}
}

/*
	Name: update_debug_state
	Namespace: scene
	Checksum: 0x5FA70136
	Offset: 0x7268
	Size: 0x92
	Parameters: 2
	Flags: None
*/
function update_debug_state(str_scene, str_state)
{
	if(!strendswith(self.last_scene_state_instance[str_scene], str_state))
	{
		level.last_scene_state[str_scene] = level.last_scene_state[str_scene] + ("," + str_state);
		self.last_scene_state_instance[str_scene] = self.last_scene_state_instance[str_scene] + ("," + str_state);
	}
}

/*
	Name: _get_scene_instances
	Namespace: scene
	Checksum: 0xDE9D627C
	Offset: 0x7308
	Size: 0x19A
	Parameters: 4
	Flags: Linked
*/
function _get_scene_instances(str_value, str_key = "targetname", str_scenedef, b_include_inactive = 0)
{
	a_instances = [];
	if(isdefined(str_value))
	{
		a_instances = struct::get_array(str_value, str_key);
		/#
			/#
				assert(a_instances.size, ((("" + str_key) + "") + str_value) + "");
			#/
		#/
	}
	if(isdefined(str_scenedef))
	{
		a_instances_by_scenedef = struct::get_array(str_scenedef, "scriptbundlename");
		a_instances = arraycombine(a_instances_by_scenedef, a_instances, 0, 0);
		a_active_instances = get_active_scenes(str_scenedef);
		a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
		if(b_include_inactive)
		{
			a_inactive_instances = get_inactive_scenes(str_scenedef);
			a_instances = arraycombine(a_inactive_instances, a_instances, 0, 0);
		}
	}
	return a_instances;
}

/*
	Name: skipto_end
	Namespace: scene
	Checksum: 0xBD259CB8
	Offset: 0x74B0
	Size: 0x7C
	Parameters: 5
	Flags: None
*/
function skipto_end(arg1, arg2, arg3, n_time, b_include_players = 1)
{
	n_time = (isdefined(n_time) ? n_time : 1);
	play_from_time(arg1, arg2, arg3, n_time, 1, b_include_players);
}

/*
	Name: play_from_time
	Namespace: scene
	Checksum: 0x63A1ABD3
	Offset: 0x7538
	Size: 0xEC
	Parameters: 7
	Flags: Linked
*/
function play_from_time(arg1, arg2, arg3, n_time, var_c9d6bbb = 1, b_include_players = 1, var_2250555 = 1)
{
	if(var_c9d6bbb)
	{
		str_mode = "play_from_time_normalized";
	}
	else
	{
		str_mode = "play_from_time_elapsed";
	}
	if(!b_include_players)
	{
		str_mode = str_mode + "_noplayers";
	}
	if(!var_2250555)
	{
		str_mode = str_mode + "_noai";
	}
	play(arg1, arg2, arg3, 0, str_mode, n_time);
}

/*
	Name: function_d1abba8b
	Namespace: scene
	Checksum: 0x68763E23
	Offset: 0x7630
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function function_d1abba8b(str_scenedef, str_mode, n_time)
{
	if(issubstr(str_mode, "play_from_time_normalized"))
	{
		var_f3f679dd = float(n_time) * function_12479eba(str_scenedef);
	}
	else
	{
		var_f3f679dd = float(n_time);
	}
	var_8b21886e = function_dde5f483(str_scenedef, var_f3f679dd);
	return var_8b21886e;
}

/*
	Name: function_1eab8670
	Namespace: scene
	Checksum: 0x6DD8D15F
	Offset: 0x76F0
	Size: 0x1FA
	Parameters: 2
	Flags: Linked
*/
function function_1eab8670(obj, str_shot)
{
	var_5a162d58 = 0;
	n_anim_length = 0;
	if(isdefined(obj.shots))
	{
		foreach(s_shot in obj.shots)
		{
			if(s_shot.name === tolower(str_shot) && isdefined(s_shot.entry))
			{
				foreach(s_entry in s_shot.entry)
				{
					if(isdefined(s_entry.cameraswitcher))
					{
						var_5a162d58 = var_5a162d58 + (float(getcamanimtime(s_entry.cameraswitcher)) / 1000);
						continue;
					}
					if(isdefined(s_entry.("anim")))
					{
						n_anim_length = n_anim_length + getanimlength(s_entry.("anim"));
					}
				}
				break;
			}
		}
	}
	n_length = max(var_5a162d58, n_anim_length);
	return n_length;
}

/*
	Name: function_dde5f483
	Namespace: scene
	Checksum: 0x5430E483
	Offset: 0x78F8
	Size: 0x24A
	Parameters: 2
	Flags: Linked
*/
function function_dde5f483(str_scenedef, n_elapsed_time)
{
	s_scenedef = get_scenedef(str_scenedef);
	a_shots = get_all_shot_names(str_scenedef, 1);
	var_7a2504a = 0;
	var_8b21886e = spawnstruct();
	foreach(str_shot in a_shots)
	{
		var_958bccd3 = 0;
		foreach(obj in s_scenedef.objects)
		{
			var_657b76cc = function_1eab8670(obj, str_shot);
			if(var_657b76cc > var_958bccd3)
			{
				var_958bccd3 = var_657b76cc;
			}
		}
		var_219aac3f = var_7a2504a;
		var_68790830 = var_219aac3f + var_958bccd3;
		if(n_elapsed_time >= var_219aac3f && n_elapsed_time < var_68790830)
		{
			var_8b21886e.var_ef711d04 = str_shot;
			var_8b21886e.var_3486c904 = (n_elapsed_time - var_219aac3f) / var_958bccd3;
			return var_8b21886e;
		}
		var_7a2504a = var_7a2504a + var_958bccd3;
	}
	var_8b21886e.var_ef711d04 = a_shots[a_shots.size - 1];
	var_8b21886e.var_3486c904 = 0.99;
	return var_8b21886e;
}

/*
	Name: function_8582657c
	Namespace: scene
	Checksum: 0xAC544540
	Offset: 0x7B50
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function function_8582657c(var_b9a72490, str_shot)
{
	if(isstring(var_b9a72490) || function_7a600918(var_b9a72490))
	{
		s_scenedef = get_scenedef(var_b9a72490);
	}
	else
	{
		s_scenedef = var_b9a72490;
	}
	var_a0c66830 = 0;
	foreach(obj in s_scenedef.objects)
	{
		var_657b76cc = function_1eab8670(obj, str_shot);
		if(var_657b76cc > var_a0c66830)
		{
			var_a0c66830 = var_657b76cc;
		}
	}
	return var_a0c66830;
}

/*
	Name: function_12479eba
	Namespace: scene
	Checksum: 0xD4F96AF4
	Offset: 0x7C80
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_12479eba(str_scenedef)
{
	s_scenedef = get_scenedef(str_scenedef);
	a_shots = get_all_shot_names(str_scenedef, 1);
	var_9d90ef8b = 0;
	foreach(str_shot in a_shots)
	{
		var_9d90ef8b = var_9d90ef8b + function_8582657c(s_scenedef, str_shot);
	}
	return var_9d90ef8b;
}

/*
	Name: skipto_end_noai
	Namespace: scene
	Checksum: 0xF1EB53E2
	Offset: 0x7D70
	Size: 0x64
	Parameters: 4
	Flags: None
*/
function skipto_end_noai(arg1, arg2, arg3, n_time)
{
	n_time = (isdefined(n_time) ? n_time : 1);
	play_from_time(arg1, arg2, arg3, n_time, 1, 0, 0);
}

/*
	Name: stop
	Namespace: scene
	Checksum: 0x630ECF4D
	Offset: 0x7DE0
	Size: 0x274
	Parameters: 3
	Flags: Linked
*/
function stop(arg1, arg2, arg3)
{
	if(self == level)
	{
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg2))
			{
				str_value = arg1;
				str_key = arg2;
				b_clear = arg3;
			}
			else
			{
				str_value = arg1;
				b_clear = arg2;
			}
			if(isdefined(str_key))
			{
				a_instances = struct::get_array(str_value, str_key);
				/#
					/#
						assert(a_instances.size, ((("" + str_key) + "") + str_value) + "");
					#/
				#/
				str_value = undefined;
			}
			else
			{
				a_instances = struct::get_array(str_value, "targetname");
				if(!a_instances.size)
				{
					a_instances = get_active_scenes(str_value);
				}
				else
				{
					str_value = undefined;
				}
			}
			foreach(s_instance in arraycopy(a_instances))
			{
				if(isdefined(s_instance))
				{
					s_instance _stop_instance(b_clear, str_value);
				}
			}
		}
	}
	else if(isstring(arg1) || function_7a600918(arg1))
	{
		_stop_instance(arg2, arg1);
	}
	else
	{
		_stop_instance(arg1);
	}
}

/*
	Name: _stop_instance
	Namespace: scene
	Checksum: 0x6304AF74
	Offset: 0x8060
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function _stop_instance(b_clear = 0, str_scenedef)
{
	if(isdefined(self.scenes))
	{
		foreach(o_scene in arraycopy(self.scenes))
		{
			str_scene_name = o_scene._str_name;
			if(!isdefined(str_scenedef) || str_scene_name == str_scenedef)
			{
				thread [[ o_scene ]]->stop(b_clear);
			}
		}
	}
}

/*
	Name: has_init_state
	Namespace: scene
	Checksum: 0x3EB8DC0B
	Offset: 0x8150
	Size: 0x3A
	Parameters: 1
	Flags: Linked
*/
function has_init_state(str_scenedef)
{
	return isinarray(get_all_shot_names(str_scenedef), "init");
}

/*
	Name: function_9730988a
	Namespace: scene
	Checksum: 0xD69BF5B1
	Offset: 0x8198
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function function_9730988a(str_scenedef, var_6a688dba)
{
	return isinarray(get_all_shot_names(str_scenedef), var_6a688dba);
}

/*
	Name: get_prop_count
	Namespace: scene
	Checksum: 0x5E4F1E94
	Offset: 0x81E0
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_prop_count(str_scenedef)
{
	return _get_type_count("prop", str_scenedef);
}

/*
	Name: get_vehicle_count
	Namespace: scene
	Checksum: 0xA0D5E029
	Offset: 0x8210
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_vehicle_count(str_scenedef)
{
	return _get_type_count("vehicle", str_scenedef);
}

/*
	Name: get_actor_count
	Namespace: scene
	Checksum: 0x7066D224
	Offset: 0x8240
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_actor_count(str_scenedef)
{
	return _get_type_count("actor", str_scenedef);
}

/*
	Name: function_7aa3d2c6
	Namespace: scene
	Checksum: 0x464BF6F1
	Offset: 0x8270
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_7aa3d2c6(str_scenedef)
{
	return _get_type_count("sharedplayer", str_scenedef);
}

/*
	Name: get_player_count
	Namespace: scene
	Checksum: 0xE39FB8A9
	Offset: 0x82A0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_player_count(str_scenedef)
{
	return _get_type_count("player", str_scenedef);
}

/*
	Name: function_d1dd6e60
	Namespace: scene
	Checksum: 0xDAC25E96
	Offset: 0x82D0
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_d1dd6e60(str_scenedef)
{
	return _get_type_count("companion", str_scenedef);
}

/*
	Name: function_afb927e7
	Namespace: scene
	Checksum: 0xAEA9FD37
	Offset: 0x8300
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_afb927e7(str_scenedef)
{
	return _get_type_count(undefined, str_scenedef);
}

/*
	Name: _get_type_count
	Namespace: scene
	Checksum: 0x1EE209E6
	Offset: 0x8330
	Size: 0x126
	Parameters: 2
	Flags: Linked
*/
function _get_type_count(str_type, str_scenedef)
{
	s_scenedef = (isdefined(str_scenedef) ? getscriptbundle(str_scenedef) : getscriptbundle(self.scriptbundlename));
	if(!isdefined(str_type))
	{
		return s_scenedef.objects.size;
	}
	n_count = 0;
	foreach(s_obj in s_scenedef.objects)
	{
		if(isdefined(s_obj.type))
		{
			if(tolower(s_obj.type) == tolower(str_type))
			{
				n_count++;
			}
		}
	}
	return n_count;
}

/*
	Name: function_128f0294
	Namespace: scene
	Checksum: 0x38B53ABD
	Offset: 0x8460
	Size: 0x126
	Parameters: 1
	Flags: None
*/
function function_128f0294(var_37fa9b04)
{
	if(!isdefined(self._scene_object) || !isdefined(self.var_5b7900ec))
	{
		return 1;
	}
	foreach(s_shot in self._scene_object._s.shots)
	{
		if(isdefined(self.var_5b7900ec[s_shot.name]) && self.var_5b7900ec[s_shot.name])
		{
			continue;
		}
		if(self._scene_object csceneobject::function_f12c5e67(s_shot) && !self._scene_object csceneobject::function_128f0294(s_shot, var_37fa9b04))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: is_active
	Namespace: scene
	Checksum: 0x37B830D1
	Offset: 0x8590
	Size: 0x4C
	Parameters: 1
	Flags: None
*/
function is_active(str_scenedef)
{
	if(self == level)
	{
		return get_active_scenes(str_scenedef).size > 0;
	}
	return isdefined(get_active_scene(str_scenedef));
}

/*
	Name: is_playing
	Namespace: scene
	Checksum: 0x3635455E
	Offset: 0x85E8
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function is_playing(str_scenedef = self.scriptbundlename, str_shot = "play")
{
	o_scene = get_active_scene(str_scenedef);
	if(isdefined(o_scene))
	{
		return o_scene._str_shot === str_shot;
	}
	return 0;
}

/*
	Name: is_ready
	Namespace: scene
	Checksum: 0xC222C378
	Offset: 0x8668
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function is_ready(str_scenedef)
{
	if(self == level)
	{
		return level flagsys::get(str_scenedef + "_ready");
	}
	if(!isdefined(str_scenedef))
	{
		str_scenedef = self.scriptbundlename;
	}
	o_scene = get_active_scene(str_scenedef);
	if(isdefined(o_scene))
	{
		return o_scene flagsys::get(#"ready");
	}
	return 0;
}

/*
	Name: get_active_scenes
	Namespace: scene
	Checksum: 0xB19B9DD2
	Offset: 0x8708
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function get_active_scenes(str_scenedef)
{
	if(isdefined(str_scenedef))
	{
		return (isdefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
	}
	a_scenes = [];
	foreach(str_scenedef, _ in level.active_scenes)
	{
		a_scenes = arraycombine(a_scenes, level.active_scenes[str_scenedef], 0, 0);
	}
	return a_scenes;
}

/*
	Name: get_inactive_scenes
	Namespace: scene
	Checksum: 0x996F9709
	Offset: 0x87F0
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function get_inactive_scenes(str_scenedef)
{
	if(!isdefined(level.inactive_scenes))
	{
		level.inactive_scenes = [];
	}
	if(isdefined(str_scenedef))
	{
		return (isdefined(level.inactive_scenes[str_scenedef]) ? level.inactive_scenes[str_scenedef] : []);
	}
	a_scenes = [];
	foreach(str_scenedef, _ in level.inactive_scenes)
	{
		a_scenes = arraycombine(a_scenes, level.inactive_scenes[str_scenedef], 0, 0);
	}
	return a_scenes;
}

/*
	Name: get_active_scene
	Namespace: scene
	Checksum: 0x9FD9C567
	Offset: 0x88F0
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function get_active_scene(str_scenedef)
{
	if(isdefined(str_scenedef) && isdefined(self.scenes))
	{
		foreach(o_scene in self.scenes)
		{
			if(o_scene._str_name == str_scenedef)
			{
				return o_scene;
			}
		}
	}
}

/*
	Name: delete_scene_data
	Namespace: scene
	Checksum: 0xDA33AADB
	Offset: 0x8998
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function delete_scene_data(str_scenename)
{
}

/*
	Name: is_igc
	Namespace: scene
	Checksum: 0x8D9BD3AE
	Offset: 0x89B0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function is_igc()
{
	return isdefined(self.igc) && self.igc || isstring(self.cameraswitcher) || function_7a600918(self.cameraswitcher);
}

/*
	Name: scene_disable_player_stuff
	Namespace: scene
	Checksum: 0xC1BE8891
	Offset: 0x8A10
	Size: 0x1D6
	Parameters: 2
	Flags: Linked
*/
function scene_disable_player_stuff(s_scenedef, s_objectdef)
{
	self endon(#"disconnect");
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("");
		}
	#/
	self notify(#"scene_disable_player_stuff");
	self notify(#"kill_hint_text");
	self disableoffhandweapons();
	self disableoffhandspecial();
	self val::set(#"scene_system", "disable_oob", 1);
	self val::set(#"scene_system", "freezecontrols", 1);
	self allowjump(0);
	if(isdefined(s_objectdef))
	{
		if(!(isdefined(s_objectdef.showhud) && s_objectdef.showhud))
		{
			level notify(#"disable_cybercom", {#player:self});
			self val::set(#"scene", "show_hud", 0);
			util::wait_network_frame();
			self notify(#"delete_weapon_objects");
		}
	}
}

/*
	Name: scene_enable_player_stuff
	Namespace: scene
	Checksum: 0x3C735D21
	Offset: 0x8BF0
	Size: 0x1EC
	Parameters: 3
	Flags: Linked
*/
function scene_enable_player_stuff(s_scenedef, s_objectdef, e_scene_root)
{
	/#
		if(getdvarint(#"debug_scene", 0) > 0)
		{
			printtoprightln("");
		}
	#/
	self endon(#"scene_disable_player_stuff", #"disconnect");
	waitframe(0);
	if(isdefined(s_scenedef) && !isdefined(s_scenedef.nextscenebundle))
	{
		self function_777f32c4(e_scene_root, s_scenedef);
	}
	waitframe(10);
	self enableoffhandweapons();
	self enableoffhandspecial();
	self val::reset(#"scene_system", "disable_oob");
	self val::reset(#"scene_system", "freezecontrols");
	self allowjump(1);
	if(isdefined(s_objectdef))
	{
		if(!(isdefined(s_objectdef.showhud) && s_objectdef.showhud))
		{
			level notify(#"enable_cybercom", {#player:self});
			self notify(#"scene_enable_cybercom");
			self val::reset(#"scene", "show_hud");
		}
	}
}

/*
	Name: function_777f32c4
	Namespace: scene
	Checksum: 0x1464A2B8
	Offset: 0x8DE8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_777f32c4(e_scene_root, s_scenedef)
{
	self endon(#"disconnect");
	if(isdefined(e_scene_root) && isdefined(e_scene_root.script_teleport_location))
	{
		e_scene_root teleport::player(self);
	}
}

/*
	Name: function_37592f67
	Namespace: scene
	Checksum: 0x66A3CFEB
	Offset: 0x8E50
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function function_37592f67(e_scene_root, s_scenedef)
{
	waitframe(0);
	if(isdefined(s_scenedef) && !isdefined(s_scenedef.nextscenebundle))
	{
		if(isdefined(e_scene_root) && isdefined(e_scene_root.script_teleport_location))
		{
			e_scene_root teleport::hero(self);
		}
	}
}

/*
	Name: updateigcviewtime
	Namespace: scene
	Checksum: 0x6CDC654C
	Offset: 0x8EC0
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function updateigcviewtime(b_in_igc)
{
	if(b_in_igc && !isdefined(level.igcstarttime))
	{
		level.igcstarttime = gettime();
	}
	else if(!b_in_igc && isdefined(level.igcstarttime))
	{
		igcviewtimesec = gettime() - level.igcstarttime;
		level.igcstarttime = undefined;
		foreach(player in level.players)
		{
			if(!isdefined(player.totaligcviewtime))
			{
				player.totaligcviewtime = 0;
			}
			player.totaligcviewtime = player.totaligcviewtime + (int(float(igcviewtimesec) / 1000));
		}
	}
}

/*
	Name: set_igc_active
	Namespace: scene
	Checksum: 0xEB708EB2
	Offset: 0x9010
	Size: 0x120
	Parameters: 2
	Flags: Linked
*/
function set_igc_active(b_in_igc, str_scene_name)
{
	n_ent_num = self getentitynumber();
	n_players_in_igc_field = level clientfield::get("in_igc");
	if(b_in_igc)
	{
		n_players_in_igc_field = n_players_in_igc_field | (1 << n_ent_num);
		self notify(#"hash_57d4f53c12705eac", {#str_scene:str_scene_name});
	}
	else
	{
		n_players_in_igc_field = n_players_in_igc_field & (~(1 << n_ent_num));
		self notify(#"hash_684b272680aa2ed", {#str_scene:str_scene_name});
	}
	updateigcviewtime(b_in_igc);
	level clientfield::set("in_igc", n_players_in_igc_field);
	/#
	#/
}

/*
	Name: is_igc_active
	Namespace: scene
	Checksum: 0xDFC5B149
	Offset: 0x9138
	Size: 0x5E
	Parameters: 0
	Flags: Linked
*/
function is_igc_active()
{
	n_players_in_igc = level clientfield::get("in_igc");
	n_entnum = self getentitynumber();
	return n_players_in_igc & (1 << n_entnum);
}

/*
	Name: function_871087b6
	Namespace: scene
	Checksum: 0x7AC3129D
	Offset: 0x91A0
	Size: 0x18
	Parameters: 0
	Flags: None
*/
function function_871087b6()
{
	return isdefined(self.var_7136e83) && self.var_7136e83;
}

/*
	Name: get_scene_shot
	Namespace: scene
	Checksum: 0x1D2C8FB1
	Offset: 0x91C0
	Size: 0xBC
	Parameters: 1
	Flags: None
*/
function get_scene_shot(str_scene)
{
	foreach(o_scene in self.scenes)
	{
		if(o_scene._str_name === str_scene)
		{
			return o_scene._str_shot;
		}
	}
	/#
		assert(("" + str_scene) + "");
	#/
}

/*
	Name: is_capture_mode
	Namespace: scene
	Checksum: 0xD693B7B
	Offset: 0x9288
	Size: 0x80
	Parameters: 1
	Flags: None
*/
function is_capture_mode(str_mode = getdvarstring(#"scene_menu_mode", "default"))
{
	if(issubstr(str_mode, "capture") || function_a4dedc63(1))
	{
		return 1;
	}
	return 0;
}

/*
	Name: should_spectate_on_join
	Namespace: scene
	Checksum: 0xF0636A1D
	Offset: 0x9310
	Size: 0x20
	Parameters: 0
	Flags: None
*/
function should_spectate_on_join()
{
	return isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join;
}

/*
	Name: wait_until_spectate_on_join_completes
	Namespace: scene
	Checksum: 0xBB355E39
	Offset: 0x9338
	Size: 0x2E
	Parameters: 0
	Flags: None
*/
function wait_until_spectate_on_join_completes()
{
	while(isdefined(level.scene_should_spectate_on_hot_join) && level.scene_should_spectate_on_hot_join)
	{
		waitframe(1);
	}
}

/*
	Name: function_a4dedc63
	Namespace: scene
	Checksum: 0xEEB1A08C
	Offset: 0x9370
	Size: 0xA8
	Parameters: 1
	Flags: Linked
*/
function function_a4dedc63(var_2875c7e7 = 0)
{
	if(var_2875c7e7)
	{
		if(getdvarint(#"hash_6a54249f0cc48945", 0))
		{
			return 1;
		}
	}
	else if(getdvarint(#"hash_1ac735c6e28a2f7a", 0) || getdvarint(#"hash_6a54249f0cc48945", 0))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_46546b5c
	Namespace: scene
	Checksum: 0xA07BBD59
	Offset: 0x9420
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function function_46546b5c(str_scenedef)
{
	if(!sessionmodeiscampaigngame())
	{
		return 0;
	}
	if(function_a4dedc63())
	{
		return 0;
	}
	if(getdvarint(#"hash_862358d532e674c", 0) === 1)
	{
		var_41c1a1b7 = getscriptbundle(str_scenedef);
		if(isdefined(var_41c1a1b7.var_2af733c9) && var_41c1a1b7.var_2af733c9)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a63b9bca
	Namespace: scene
	Checksum: 0x8DBADE7A
	Offset: 0x94D8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_a63b9bca(str_scenedef)
{
	if(!sessionmodeiscampaigngame())
	{
		return 0;
	}
	if(getdvarint(#"hash_862358d532e674c", 0) === 2)
	{
		var_41c1a1b7 = getscriptbundle(str_scenedef);
		if(isdefined(var_41c1a1b7.var_2af733c9) && var_41c1a1b7.var_2af733c9)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_a4ad0308
	Namespace: scene
	Checksum: 0xB57EAA9E
	Offset: 0x9578
	Size: 0x9F0
	Parameters: 1
	Flags: Linked
*/
function function_a4ad0308(o_scene)
{
	if(getdvarint(#"hash_12bb279f3cc30d88", 1) == 0 || (isdefined(o_scene._s.disablesceneskipping) && o_scene._s.disablesceneskipping) && !function_46546b5c(o_scene._str_name))
	{
		return;
	}
	self notify(#"hash_f7c1e0e8fb935d5");
	self endon_callback(&function_63033fc3, #"hash_f7c1e0e8fb935d5", #"disconnect");
	o_scene endon_callback(&function_63033fc3, #"scene_done", #"scene_stop", #"scene_skip_completed", #"hash_63783193d9ac5bfc");
	level endon_callback(&function_63033fc3, #"hash_7a8cd7f6a20dde3e");
	b_skip_scene = 0;
	self clear_scene_skipping_ui();
	waitframe(1);
	if(function_46546b5c(o_scene._str_name))
	{
		var_6b859e8c = 1;
		var_d60120 = 0;
	}
	else
	{
		var_6b859e8c = 0;
		var_d60120 = 2500;
	}
	self.skip_scene_menu_handle = lui::function_e810a527("cp_skip_scene_menu");
	self.skip_scene_menu_handle cp_skip_scene_menu::open(self);
	self.skip_scene_menu_handle cp_skip_scene_menu::function_6c680730(self, 0);
	self.skip_scene_menu_handle cp_skip_scene_menu::function_300eba00(self, 0);
	self.skip_scene_menu_handle cp_skip_scene_menu::function_5d0d17fd(self, 0);
	self.skip_scene_menu_handle cp_skip_scene_menu::function_dad9a8ef(self, 0);
	while(true)
	{
		if(isdefined(self.var_fc92900f) && self.var_fc92900f && isdefined(self.skip_scene_menu_handle))
		{
			self.skip_scene_menu_handle cp_skip_scene_menu::function_5d0d17fd(self, 1);
			self.skip_scene_menu_handle cp_skip_scene_menu::function_6c680730(self, 2);
			self.scene_skip_timer = undefined;
			p_host = util::gethostplayer();
			if(isdefined(p_host) && isdefined(p_host.skip_scene_menu_handle))
			{
				p_host.skip_scene_menu_handle cp_skip_scene_menu::function_5d0d17fd(p_host, 1);
			}
		}
		else if(self any_button_pressed() && function_1c87e68f())
		{
			if(!isdefined(self.scene_skip_timer) && isdefined(self.skip_scene_menu_handle))
			{
				self.skip_scene_menu_handle cp_skip_scene_menu::function_6c680730(self, 1);
			}
			self.scene_skip_timer = gettime();
		}
		else if(isdefined(self.scene_skip_timer) && isdefined(self.skip_scene_menu_handle))
		{
			if(gettime() - self.scene_skip_timer > var_d60120)
			{
				self.skip_scene_menu_handle cp_skip_scene_menu::function_6c680730(self, 2);
				self.scene_skip_timer = undefined;
			}
		}
		var_8133fe2b = 0;
		if(var_6b859e8c || self primarybuttonpressedlocal() || (ispc() ? self attackbuttonpressed() : self jumpbuttonpressed()))
		{
			var_8133fe2b = 1;
		}
		if(var_8133fe2b && function_1c87e68f())
		{
			if(!isdefined(self.scene_skip_start_time) && isdefined(self.skip_scene_menu_handle))
			{
				self.skip_scene_menu_handle cp_skip_scene_menu::function_dad9a8ef(self, gettime() + var_d60120);
				self.scene_skip_start_time = gettime();
				if(self ishost())
				{
					foreach(player in getplayers())
					{
						if(isdefined(player.skip_scene_menu_handle) && !player ishost())
						{
							player.skip_scene_menu_handle cp_skip_scene_menu::function_300eba00(player, 1);
						}
					}
				}
			}
			else if(isdefined(self.scene_skip_start_time) && (gettime() - self.scene_skip_start_time) > var_d60120)
			{
				if(self ishost())
				{
					b_skip_scene = 1;
					break;
				}
				else
				{
					self.var_fc92900f = 1;
					var_4ca048a2 = 0;
					foreach(player in getplayers())
					{
						if(isdefined(player.var_fc92900f) && player.var_fc92900f)
						{
							var_4ca048a2++;
						}
					}
					if(var_4ca048a2 > 1)
					{
						b_skip_scene = 1;
						break;
					}
				}
			}
		}
		else if(isdefined(self.scene_skip_start_time) && isdefined(self.skip_scene_menu_handle))
		{
			self.skip_scene_menu_handle cp_skip_scene_menu::function_dad9a8ef(self, 0);
			self.scene_skip_start_time = undefined;
			if(self ishost())
			{
				foreach(player in getplayers())
				{
					if(isdefined(player.skip_scene_menu_handle) && !player ishost())
					{
						player.skip_scene_menu_handle cp_skip_scene_menu::function_300eba00(player, 0);
					}
				}
			}
		}
		if(isdefined(level.chyron_text_active) && level.chyron_text_active)
		{
			while(isdefined(level.chyron_text_active) && level.chyron_text_active)
			{
				waitframe(1);
			}
			wait(3);
		}
		waitframe(1);
	}
	if(b_skip_scene)
	{
		self clear_scene_skipping_ui();
		self playsound(#"uin_igc_skip");
		self notify(#"scene_being_skipped");
		music::setmusicstatebyteam("death", self.team);
		start_scene_skip(o_scene);
		foreach(player in getplayers())
		{
			if(isdefined(player._scene_object) && isdefined(player._scene_object._o_scene) && player._scene_object._o_scene != o_scene)
			{
				var_bf6b1ad2 = player._scene_object._o_scene;
				if(var_bf6b1ad2._s is_igc())
				{
					start_scene_skip(var_bf6b1ad2);
					break;
				}
			}
		}
		level notify(#"hash_7a8cd7f6a20dde3e");
	}
}

/*
	Name: start_scene_skip
	Namespace: scene
	Checksum: 0xA1195A48
	Offset: 0x9F70
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function start_scene_skip(o_scene)
{
	o_scene.skipping_scene = 1;
	o_scene.b_player_scene = 1;
	thread [[ o_scene ]]->skip_scene(0);
}

/*
	Name: function_1c87e68f
	Namespace: scene
	Checksum: 0xEF388F5B
	Offset: 0x9FB8
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function function_1c87e68f()
{
	if(isdefined(level.chyron_text_active) && level.chyron_text_active)
	{
		return 0;
	}
	if(isdefined(level.var_d89799d7) && level.var_d89799d7 && (level flag::exists("switchmap_preload_finished") && !level flag::get("switchmap_preload_finished")))
	{
		return 0;
	}
	return 1;
}

/*
	Name: clear_scene_skipping_ui
	Namespace: scene
	Checksum: 0x879BB668
	Offset: 0xA058
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function clear_scene_skipping_ui()
{
	if(isdefined(self.scene_skip_timer))
	{
		self.scene_skip_timer = undefined;
	}
	if(isdefined(self.scene_skip_start_time))
	{
		self.scene_skip_start_time = undefined;
	}
	if(isdefined(self.skip_scene_menu_handle))
	{
		self.skip_scene_menu_handle cp_skip_scene_menu::close(self);
		self.skip_scene_menu_handle = undefined;
	}
	self.var_fc92900f = undefined;
}

/*
	Name: function_63033fc3
	Namespace: scene
	Checksum: 0x4C085914
	Offset: 0xA0D0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_63033fc3(str_notify)
{
	if(isclass(self) || self == level)
	{
		array::thread_all(getplayers(), &clear_scene_skipping_ui);
	}
	else if(isplayer(self))
	{
		self clear_scene_skipping_ui();
	}
}

/*
	Name: any_button_pressed
	Namespace: scene
	Checksum: 0xD8B22217
	Offset: 0xA170
	Size: 0x1A6
	Parameters: 0
	Flags: Linked
*/
function any_button_pressed()
{
	if(self actionslotonebuttonpressed())
	{
		return 1;
	}
	if(self actionslottwobuttonpressed())
	{
		return 1;
	}
	if(self actionslotthreebuttonpressed())
	{
		return 1;
	}
	if(self actionslotfourbuttonpressed())
	{
		return 1;
	}
	if(self jumpbuttonpressed())
	{
		return 1;
	}
	if(self stancebuttonpressed())
	{
		return 1;
	}
	if(self weaponswitchbuttonpressed())
	{
		return 1;
	}
	if(self reloadbuttonpressed())
	{
		return 1;
	}
	if(self fragbuttonpressed())
	{
		return 1;
	}
	if(self throwbuttonpressed())
	{
		return 1;
	}
	if(self attackbuttonpressed())
	{
		return 1;
	}
	if(self secondaryoffhandbuttonpressed())
	{
		return 1;
	}
	if(self meleebuttonpressed())
	{
		return 1;
	}
	return 0;
}

/*
	Name: on_player_disconnect
	Namespace: scene
	Checksum: 0x833BB815
	Offset: 0xA320
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function on_player_disconnect()
{
	if(isdefined(level.gameended) && !level.gameended)
	{
		self set_igc_active(0);
	}
}

/*
	Name: add_scene_ordered_notetrack
	Namespace: scene
	Checksum: 0xB3B79D86
	Offset: 0xA368
	Size: 0xD4
	Parameters: 2
	Flags: None
*/
function add_scene_ordered_notetrack(group_name, str_note)
{
	if(!isdefined(level.scene_ordered_notetracks))
	{
		level.scene_ordered_notetracks = [];
	}
	group_obj = level.scene_ordered_notetracks[group_name];
	if(!isdefined(group_obj))
	{
		group_obj = spawnstruct();
		group_obj.count = 0;
		group_obj.current_count = 0;
		level.scene_ordered_notetracks[group_name] = group_obj;
	}
	group_obj.count++;
	self thread _wait_for_ordered_notify(group_obj.count - 1, group_obj, group_name, str_note);
}

/*
	Name: _wait_for_ordered_notify
	Namespace: scene
	Checksum: 0xB9CA83D7
	Offset: 0xA448
	Size: 0x224
	Parameters: 4
	Flags: Linked
*/
function _wait_for_ordered_notify(id, group_obj, group_name, str_note)
{
	self waittill(str_note);
	if(group_obj.current_count == id)
	{
		group_obj.current_count++;
		self notify("scene_" + str_note);
		waitframe(1);
		if(group_obj.current_count == group_obj.count)
		{
			group_obj.pending_notifies = undefined;
			level.scene_ordered_notetracks[group_name] = undefined;
		}
		else if(isdefined(group_obj.pending_notifies) && (group_obj.current_count + group_obj.pending_notifies.size) == group_obj.count)
		{
			self thread _fire_ordered_notitifes(group_obj, group_name);
		}
	}
	else if(!isdefined(group_obj.pending_notifies))
	{
		group_obj.pending_notifies = [];
	}
	notetrack = spawnstruct();
	notetrack.id = id;
	notetrack.str_note = str_note;
	for(i = 0; i < group_obj.pending_notifies.size && group_obj.pending_notifies[i].id < id; i++)
	{
	}
	arrayinsert(group_obj.pending_notifies, notetrack, i);
	if((group_obj.current_count + group_obj.pending_notifies.size) == group_obj.count)
	{
		self thread _fire_ordered_notitifes(group_obj, group_name);
	}
}

/*
	Name: _fire_ordered_notitifes
	Namespace: scene
	Checksum: 0x3310401E
	Offset: 0xA678
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function _fire_ordered_notitifes(group_obj, group_name)
{
	if(isdefined(group_obj.pending_notifies))
	{
		while(group_obj.pending_notifies.size > 0)
		{
			self notify("scene_" + group_obj.pending_notifies[0].str_note);
			arrayremoveindex(group_obj.pending_notifies, 0);
			waitframe(1);
		}
	}
	group_obj.pending_notifies = undefined;
	level.scene_ordered_notetracks[group_name] = undefined;
}

/*
	Name: add_wait_for_streamer_hint_scene
	Namespace: scene
	Checksum: 0x414EECF5
	Offset: 0xA720
	Size: 0x44
	Parameters: 1
	Flags: None
*/
function add_wait_for_streamer_hint_scene(str_scene_name)
{
	if(!isdefined(level.wait_for_streamer_hint_scenes))
	{
		level.wait_for_streamer_hint_scenes = [];
	}
	array::add(level.wait_for_streamer_hint_scenes, str_scene_name);
}

/*
	Name: get_existing_ent
	Namespace: scene
	Checksum: 0xCFFD00B7
	Offset: 0xA770
	Size: 0x204
	Parameters: 4
	Flags: Linked
*/
function get_existing_ent(str_name, b_spawner_only = 0, b_nodes_and_structs = 0, str_scene)
{
	e = undefined;
	if(b_spawner_only)
	{
		e_array = getspawnerarray(str_name, "script_animname");
		if(e_array.size == 0)
		{
			e_array = getspawnerarray(str_name, "targetname");
		}
		/#
			assert(e_array.size <= 1, "");
		#/
		foreach(ent in e_array)
		{
			if(!isdefined(ent.isdying))
			{
				e = ent;
				break;
			}
		}
	}
	else
	{
		e = get_existing_ent_by_targetname(str_name, str_scene);
		if(!is_valid_ent(e) && b_nodes_and_structs)
		{
			e = getnode(str_name, "targetname");
			if(!is_valid_ent(e))
			{
				e = struct::get(str_name, "targetname");
			}
		}
	}
	if(is_valid_ent(e))
	{
		return e;
	}
}

/*
	Name: get_existing_ent_by_targetname
	Namespace: scene
	Checksum: 0x7E5688F8
	Offset: 0xA980
	Size: 0x7A
	Parameters: 2
	Flags: Linked
*/
function get_existing_ent_by_targetname(str_name, str_scene)
{
	e = _get_existing_ent(str_name, "targetname", 1, str_scene);
	if(!is_valid_ent(e))
	{
		e = _get_existing_ent(str_name, "targetname", undefined, str_scene);
	}
	return e;
}

/*
	Name: _get_existing_ent
	Namespace: scene
	Checksum: 0xE1B64E03
	Offset: 0xAA08
	Size: 0xDC
	Parameters: 4
	Flags: Linked
*/
function _get_existing_ent(val, key, b_ignore_spawners = 0, str_scene)
{
	a_ents = getentarray(val, key, b_ignore_spawners);
	/#
		if(!isdefined(str_scene))
		{
			str_scene = "";
		}
		/#
			assert(a_ents.size <= 1, (("" + function_9e72a96(val)) + "") + function_9e72a96(str_scene) + "");
		#/
	#/
	return a_ents[0];
}

/*
	Name: is_valid_ent
	Namespace: scene
	Checksum: 0x92C0B1A6
	Offset: 0xAAF0
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function is_valid_ent(ent)
{
	return isdefined(ent) && (!isdefined(ent.isdying) && !ent ai::is_dead_sentient() || self._s.ignorealivecheck === 1);
}

/*
	Name: synced_delete
	Namespace: scene
	Checksum: 0xF6E2FB14
	Offset: 0xAB58
	Size: 0x1AC
	Parameters: 1
	Flags: Linked
*/
function synced_delete(str_scene)
{
	self endon(#"death");
	self.isdying = 1;
	self.var_a6ddd958 = str_scene;
	if(!isplayer(self))
	{
		sethideonclientwhenscriptedanimcompleted(self);
		self animation::stop(0);
		waitframe(1);
		self val::set(#"synced_delete", "hide");
	}
	else
	{
		waitframe(1);
		self val::set(#"synced_delete", "hide", 2);
	}
	self notsolid();
	if(isalive(self))
	{
		if(issentient(self))
		{
			self val::set(#"synced_delete", "ignoreall", 1);
		}
		if(isactor(self))
		{
			self pathmode("dont move");
		}
	}
	wait(1);
	self delete();
}

/*
	Name: error_on_screen
	Namespace: scene
	Checksum: 0x94A1CE47
	Offset: 0xAD10
	Size: 0x11C
	Parameters: 1
	Flags: None
*/
function error_on_screen(str_msg)
{
	/#
		str_msg = function_9e72a96(str_msg);
		if(str_msg != "")
		{
			if(!isdefined(level.scene_error_hud))
			{
				level.scene_error_hud = newdebughudelem();
			}
			level.scene_error_hud.alignx = "";
			level.scene_error_hud.aligny = "";
			level.scene_error_hud.horzalign = "";
			level.scene_error_hud.y = 30;
			level.scene_error_hud.fontscale = 1;
			level.scene_error_hud.color = (1, 0, 0);
			level.scene_error_hud settext(str_msg);
			self thread _destroy_error_on_screen();
		}
	#/
}

/*
	Name: _destroy_error_on_screen
	Namespace: scene
	Checksum: 0x7E29908B
	Offset: 0xAE38
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function _destroy_error_on_screen()
{
	/#
		level notify(#"_destroy_error_on_screen");
		level endon(#"_destroy_error_on_screen");
		self waittill_timeout(5, #"scene_stop", #"scene_done");
		level.scene_error_hud destroy();
		level.scene_error_hud = undefined;
	#/
}

/*
	Name: warning_on_screen
	Namespace: scene
	Checksum: 0x6AAA4D6B
	Offset: 0xAEC8
	Size: 0x11C
	Parameters: 1
	Flags: None
*/
function warning_on_screen(str_msg)
{
	/#
		str_msg = function_9e72a96(str_msg);
		if(str_msg != "")
		{
			if(!isdefined(level.scene_warning_hud))
			{
				level.scene_warning_hud = newdebughudelem();
			}
			level.scene_warning_hud.alignx = "";
			level.scene_warning_hud.aligny = "";
			level.scene_warning_hud.horzalign = "";
			level.scene_warning_hud.y = 70;
			level.scene_warning_hud.fontscale = 1;
			level.scene_warning_hud.color = (1, 1, 0);
			level.scene_warning_hud settext(str_msg);
			self thread _destroy_warning_on_screen();
		}
	#/
}

/*
	Name: _destroy_warning_on_screen
	Namespace: scene
	Checksum: 0x8911B043
	Offset: 0xAFF0
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function _destroy_warning_on_screen()
{
	/#
		level notify(#"_destroy_warning_on_screen");
		level endon(#"_destroy_warning_on_screen");
		self waittill_timeout(5, #"scene_stop", #"scene_done");
		level.scene_warning_hud destroy();
		level.scene_warning_hud = undefined;
	#/
}

/*
	Name: wait_server_time
	Namespace: scene
	Checksum: 0x38F1FC9F
	Offset: 0xB080
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function wait_server_time(n_time, n_start_time = 0)
{
	n_len = n_time - (n_time * n_start_time);
	n_len = n_len / (float(function_60d95f53()) / 1000);
	n_len_int = int(n_len);
	if(n_len_int != n_len)
	{
		n_len = floor(n_len);
	}
	waitframe(int(n_len));
}

/*
	Name: check_team
	Namespace: scene
	Checksum: 0xFF6C00C6
	Offset: 0xB158
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function check_team(str_team1 = #"any", str_team2 = #"any")
{
	str_team1 = util::get_team_mapping(str_team1);
	str_team2 = util::get_team_mapping(str_team2);
	if(str_team1 == #"any" || str_team2 == #"any")
	{
		return 1;
	}
	return str_team1 == str_team2;
}

/*
	Name: function_c935c42
	Namespace: scene
	Checksum: 0x79C6C89E
	Offset: 0xB220
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function function_c935c42()
{
	if(isdefined(self._scene_object))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_787434e2
	Namespace: scene
	Checksum: 0x35C1EE28
	Offset: 0xB240
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_787434e2()
{
	self flagsys::clear(#"hash_2d4a7625f4fde7eb");
}

/*
	Name: function_4f5268c8
	Namespace: scene
	Checksum: 0x6682AF53
	Offset: 0xB270
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_4f5268c8()
{
	self flagsys::set(#"hash_2d4a7625f4fde7eb");
}

/*
	Name: function_268bfc72
	Namespace: scene
	Checksum: 0xDFCFB85F
	Offset: 0xB2A0
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_268bfc72()
{
	if(self flagsys::get(#"hash_2d4a7625f4fde7eb"))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_e96379a5
	Namespace: scene
	Checksum: 0x7C296794
	Offset: 0xB2D8
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_e96379a5()
{
	self flagsys::set(#"hash_960b6b7a9f62393");
}

/*
	Name: function_2987f9bd
	Namespace: scene
	Checksum: 0x94EF891
	Offset: 0xB308
	Size: 0x24
	Parameters: 0
	Flags: None
*/
function function_2987f9bd()
{
	self flagsys::clear(#"hash_960b6b7a9f62393");
}

/*
	Name: function_6d361d2d
	Namespace: scene
	Checksum: 0x323B56C6
	Offset: 0xB338
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_6d361d2d()
{
	if(self flagsys::get(#"hash_960b6b7a9f62393"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_84b01fa4
	Namespace: scene
	Checksum: 0xC285B647
	Offset: 0xB370
	Size: 0x3E
	Parameters: 2
	Flags: None
*/
function function_84b01fa4(var_9e9be14d, var_2bd02bb5)
{
	if(!isdefined(self.var_9b882ef5))
	{
		self.var_9b882ef5 = [];
	}
	self.var_9b882ef5[var_9e9be14d] = var_2bd02bb5;
}

/*
	Name: function_1a1f1be7
	Namespace: scene
	Checksum: 0x4D630FC9
	Offset: 0xB3B8
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function function_1a1f1be7(var_8826a030)
{
	if(!isdefined(self.var_8826a030))
	{
		self.var_8826a030 = [];
	}
	if(!isdefined(var_8826a030))
	{
		var_8826a030 = [];
	}
	else if(!isarray(var_8826a030))
	{
		var_8826a030 = array(var_8826a030);
	}
	self.var_8826a030 = var_8826a030;
}

/*
	Name: function_61635c87
	Namespace: scene
	Checksum: 0x10E795BE
	Offset: 0xB438
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function function_61635c87(b_enable)
{
	if(b_enable)
	{
		self flagsys::set(#"hash_6ce14241f77af1e7");
	}
	else
	{
		self flagsys::clear(#"hash_6ce14241f77af1e7");
	}
}

/*
	Name: function_3d35d3ca
	Namespace: scene
	Checksum: 0xBCA75A1
	Offset: 0xB4A0
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_3d35d3ca(str_team)
{
	var_36db66e0 = [];
	a_players = util::get_players(str_team);
	foreach(player in a_players)
	{
		if(isarray(player.registerlodscalerigid_init) && isdefined(self._o_scene) && isinarray(player.registerlodscalerigid_init, hash(self._o_scene._str_name)))
		{
			continue;
		}
		if(!isdefined(var_36db66e0))
		{
			var_36db66e0 = [];
		}
		else if(!isarray(var_36db66e0))
		{
			var_36db66e0 = array(var_36db66e0);
		}
		var_36db66e0[var_36db66e0.size] = player;
	}
	return var_36db66e0;
}

/*
	Name: function_e941ea66
	Namespace: scene
	Checksum: 0xB16FD72C
	Offset: 0xB608
	Size: 0x160
	Parameters: 1
	Flags: Linked
*/
function function_e941ea66(str_team)
{
	var_36db66e0 = [];
	a_players = util::get_active_players(str_team);
	foreach(player in a_players)
	{
		if(isarray(player.registerlodscalerigid_init) && isdefined(self._o_scene) && isinarray(player.registerlodscalerigid_init, hash(self._o_scene._str_name)))
		{
			continue;
		}
		if(!isdefined(var_36db66e0))
		{
			var_36db66e0 = [];
		}
		else if(!isarray(var_36db66e0))
		{
			var_36db66e0 = array(var_36db66e0);
		}
		var_36db66e0[var_36db66e0.size] = player;
	}
	return var_36db66e0;
}

/*
	Name: function_8b06792
	Namespace: scene
	Checksum: 0x16E8178F
	Offset: 0xB770
	Size: 0x15E
	Parameters: 1
	Flags: None
*/
function function_8b06792(var_18835bcc)
{
	if(!isdefined(var_18835bcc))
	{
		var_18835bcc = [];
	}
	else if(!isarray(var_18835bcc))
	{
		var_18835bcc = array(var_18835bcc);
	}
	foreach(str_scene in var_18835bcc)
	{
		if(!isdefined(self.registerlodscalerigid_init))
		{
			self.registerlodscalerigid_init = [];
		}
		else if(!isarray(self.registerlodscalerigid_init))
		{
			self.registerlodscalerigid_init = array(self.registerlodscalerigid_init);
		}
		if(!isinarray(self.registerlodscalerigid_init, hash(str_scene)))
		{
			self.registerlodscalerigid_init[self.registerlodscalerigid_init.size] = hash(str_scene);
		}
	}
}

