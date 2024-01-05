// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_fasttravel.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace zm_red_fasttravel;

/*
	Name: init
	Namespace: zm_red_fasttravel
	Checksum: 0x4BA69CEB
	Offset: 0x480
	Size: 0x3D4
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("toplayer", "column_to_park", 16000, 2, "int");
	clientfield::register("toplayer", "column_to_fountain", 16000, 2, "int");
	clientfield::register("toplayer", "fountain_to_park", 16000, 2, "int");
	clientfield::register("toplayer", "fountain_to_column", 16000, 2, "int");
	clientfield::register("toplayer", "park_to_column", 16000, 2, "int");
	clientfield::register("toplayer", "park_to_fountain", 16000, 2, "int");
	clientfield::register("allplayers", "" + #"hash_52693a3ba1bbc7ea", 16000, 1, "counter");
	clientfield::register("scriptmover", "" + #"forcestream_crafted_item", 16000, 1, "int");
	clientfield::register("world", "" + #"hash_761511e09cb8324e", 16000, 1, "int");
	level.var_5bfd847e = #"zm_red_fasttravel_open";
	level.var_91f96fcd = struct::get_array("fasttravel_trigger", "targetname");
	level.var_352c9e03 = &function_af65fe93;
	level.var_35d6e654 = &function_d69c301b;
	if(!isdefined(level.var_3958c9ff))
	{
		level.var_3958c9ff = [];
	}
	else if(!isarray(level.var_3958c9ff))
	{
		level.var_3958c9ff = array(level.var_3958c9ff);
	}
	foreach(s_fasttravel in level.var_91f96fcd)
	{
		if(s_fasttravel.script_noteworthy === "traverse")
		{
			level.var_3958c9ff[s_fasttravel.script_string] = s_fasttravel;
		}
	}
	callback::on_spawned(&on_player_spawned);
	level thread forcestream_crafted_item("mdl_zhield_zpear", -61);
	level thread forcestream_crafted_item("eq_red_strike", -29);
	level thread function_e49ceeb9("forcestream_shrub");
}

/*
	Name: main
	Namespace: zm_red_fasttravel
	Checksum: 0x4625A761
	Offset: 0x860
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function main()
{
	zm_fasttravel::function_44a82004(#"zm_red_fasttravel_open");
	level thread function_706b7928();
	level thread function_63cbb9f();
	level thread function_7ebbc601();
	level thread function_b3bfd869();
}

/*
	Name: on_player_spawned
	Namespace: zm_red_fasttravel
	Checksum: 0x9EEF15F5
	Offset: 0x8F0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
	self endon(#"death");
	self thread function_25f97da0();
	self thread function_e968fd4f();
}

/*
	Name: function_e49ceeb9
	Namespace: zm_red_fasttravel
	Checksum: 0x34B9050A
	Offset: 0x940
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_e49ceeb9(str_targetname)
{
	mdl_item = getent(str_targetname, "targetname");
	var_5c7b8d71 = spawn("trigger_radius_new", mdl_item.origin, 0, 614);
	var_5c7b8d71 thread function_91fabcb(mdl_item);
}

/*
	Name: function_d69c301b
	Namespace: zm_red_fasttravel
	Checksum: 0x5029653E
	Offset: 0x9D0
	Size: 0x9C
	Parameters: 0
	Flags: Linked
*/
function function_d69c301b()
{
	self endon(#"death");
	n_z_diff = 0;
	if(isdefined(self.z_diff))
	{
		n_z_diff = self.z_diff;
	}
	var_5c7b8d71 = spawn("trigger_radius_new", self.origin + (0, 0, n_z_diff), 0, 614);
	var_5c7b8d71 thread function_91fabcb(self.var_6522085c, 1);
}

/*
	Name: forcestream_crafted_item
	Namespace: zm_red_fasttravel
	Checksum: 0xC565A67E
	Offset: 0xA78
	Size: 0xAC
	Parameters: 2
	Flags: Linked
*/
function forcestream_crafted_item(str_model, n_z_diff)
{
	level waittill(#"blueprint_completed");
	mdl_item = getent(str_model, "targetname");
	var_5c7b8d71 = spawn("trigger_radius_new", mdl_item.origin + (0, 0, n_z_diff), 0, 614);
	var_5c7b8d71 thread function_91fabcb(mdl_item);
}

/*
	Name: function_91fabcb
	Namespace: zm_red_fasttravel
	Checksum: 0x53818AB8
	Offset: 0xB30
	Size: 0x13E
	Parameters: 2
	Flags: Linked
*/
function function_91fabcb(mdl_item, b_clean_up = 0)
{
	self endon(#"death");
	if(b_clean_up)
	{
		self thread function_9aec1610(mdl_item);
	}
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"trigger");
		mdl_item clientfield::set("" + #"forcestream_crafted_item", 1);
		wait(3);
		mdl_item clientfield::set("" + #"forcestream_crafted_item", 0);
		while(isdefined(s_result.activator) && s_result.activator istouching(self))
		{
			wait(1.6);
		}
		wait(16);
	}
}

/*
	Name: function_9aec1610
	Namespace: zm_red_fasttravel
	Checksum: 0xF6571F86
	Offset: 0xC78
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function function_9aec1610(mdl_item)
{
	mdl_item waittill(#"death");
	self delete();
}

/*
	Name: function_25f97da0
	Namespace: zm_red_fasttravel
	Checksum: 0x5AE3A2FD
	Offset: 0xCC0
	Size: 0xE0
	Parameters: 0
	Flags: Linked
*/
function function_25f97da0()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"hash_1c35eb15aa210d6");
		if(isdefined(s_result.var_9fa6220c) && isdefined(s_result.var_9fa6220c.script_string) && s_result.var_9fa6220c.script_string == "spartan_monument")
		{
			self forcestreambundle(#"hash_4703db4679985a0a");
			wait(3);
			self function_66b6e720(#"hash_4703db4679985a0a");
		}
	}
}

/*
	Name: function_e968fd4f
	Namespace: zm_red_fasttravel
	Checksum: 0x46D31F03
	Offset: 0xDA8
	Size: 0x100
	Parameters: 0
	Flags: Linked
*/
function function_e968fd4f()
{
	self endon(#"death");
	while(true)
	{
		s_result = undefined;
		s_result = self waittill(#"hash_1c35eb15aa210d6");
		if(isdefined(s_result.var_9fa6220c) && isdefined(s_result.var_9fa6220c.script_string) && s_result.var_9fa6220c.script_string == "center_of_the_world")
		{
			level clientfield::set("" + #"hash_761511e09cb8324e", 1);
			wait(3);
			level clientfield::set("" + #"hash_761511e09cb8324e", 0);
		}
	}
}

/*
	Name: function_a5689564
	Namespace: zm_red_fasttravel
	Checksum: 0xF8F3A325
	Offset: 0xEB0
	Size: 0x2AA
	Parameters: 1
	Flags: Linked
*/
function function_a5689564(s_loc)
{
	zm_fasttravel::function_2d4bda34(s_loc);
	if(s_loc.script_noteworthy === "traverse")
	{
		if(isdefined(s_loc.var_85e825a7))
		{
			s_loc.unitrigger_stub.var_85e825a7 = s_loc.var_85e825a7;
			level flag::init(s_loc.var_85e825a7);
		}
		s_loc.unitrigger_stub.s_loc = s_loc;
		s_loc.unitrigger_stub.var_638d9008 = 1;
		s_loc.unitrigger_stub.var_694cbc6f = 1;
		s_loc.unitrigger_stub.var_cafe149c = "" + #"hash_52693a3ba1bbc7ea";
		s_loc.unitrigger_stub.var_a4134e51 = s_loc.var_a4134e51;
		if(!isdefined(level.var_4775015b))
		{
			level.var_4775015b = [];
		}
		else if(!isarray(level.var_4775015b))
		{
			level.var_4775015b = array(level.var_4775015b);
		}
		level.var_4775015b[level.var_4775015b.size] = s_loc;
		var_42b23772 = getent(s_loc.target, "targetname");
		var_42b23772 hidepart("tag_symbol_blue");
		var_42b23772 hidepart("tag_symbol_red");
		var_42b23772.var_3925cac9 = [];
		s_loc.var_42b23772 = var_42b23772;
		var_2a2d0b17 = getent(var_42b23772.target, "targetname");
		var_2a2d0b17 hidepart("tag_symbol_blue");
		var_2a2d0b17 hide();
		var_2a2d0b17.var_3925cac9 = [];
		s_loc.var_2a2d0b17 = var_2a2d0b17;
	}
}

/*
	Name: function_ae5d684b
	Namespace: zm_red_fasttravel
	Checksum: 0xEE19F957
	Offset: 0x1168
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function function_ae5d684b()
{
	switch(self.unitrigger_stub.script_string)
	{
		case "fountain_to_column":
		case "column_to_fountain":
		{
			self.unitrigger_stub.var_8d5d092c = "fountain_to_column_jump_pad";
			break;
		}
		case "column_to_park":
		case "park_to_column":
		{
			self.unitrigger_stub.var_8d5d092c = "column_to_park_jump_pad";
			break;
		}
		case "fountain_to_park":
		case "park_to_fountain":
		{
			self.unitrigger_stub.var_8d5d092c = "fountain_to_park_jump_pad";
			break;
		}
	}
}

/*
	Name: function_c52e8ba
	Namespace: zm_red_fasttravel
	Checksum: 0x1F9FC7ED
	Offset: 0x1250
	Size: 0x906
	Parameters: 2
	Flags: Linked
*/
function function_c52e8ba(e_player, var_8d5d092c)
{
	b_result = 0;
	if(!isdefined(self.hint_string))
	{
		self.hint_string = [];
	}
	n_player_index = e_player getentitynumber();
	if(!self zm_fasttravel::function_d06e636b(e_player))
	{
		self.hint_string[n_player_index] = #"";
	}
	else
	{
		if(isdefined(self.stub.var_a4134e51) && !level flag::get(self.stub.var_a4134e51))
		{
			switch(self.stub.var_a4134e51)
			{
				case "hash_4083e9da0ba41dec":
				{
					self.hint_string[n_player_index] = #"hash_5455a9d3a45a75ab";
					break;
				}
				case "hash_718fe784e4ddaa70":
				{
					if(!level flag::get(#"hash_4083e9da0ba41dec"))
					{
						self.hint_string[n_player_index] = #"hash_5455a9d3a45a75ab";
					}
					else
					{
						self.hint_string[n_player_index] = #"hash_5aabbca03c1acbc8";
					}
					break;
				}
				case "hash_42322632a02d834d":
				{
					if(!level flag::get(#"hash_4083e9da0ba41dec"))
					{
						self.hint_string[n_player_index] = #"hash_5455a9d3a45a75ab";
					}
					else
					{
						self.hint_string[n_player_index] = #"hash_7f2b5399434a7ec9";
					}
					break;
				}
				case "hash_6a9e3d8abf194ccc":
				{
					if(!level flag::get(#"zm_red_fasttravel_open"))
					{
						self.hint_string[n_player_index] = #"hash_1f91f960f0f25452";
					}
					else
					{
						self.hint_string[n_player_index] = #"hash_7c485270314bcf34";
					}
					break;
				}
				case "hash_594bc19e3aca5c49":
				{
					if(!level flag::get(#"zm_red_fasttravel_open"))
					{
						self.hint_string[n_player_index] = #"hash_1f91f960f0f25452";
					}
					else
					{
						self.hint_string[n_player_index] = #"hash_2e207b569060b129";
					}
					break;
				}
				default:
				{
					self.hint_string[n_player_index] = #"hash_222289639943b061";
					break;
				}
			}
			b_result = 1;
		}
		else
		{
			if(isdefined(e_player.var_9c7b96ed[var_8d5d092c]) && e_player.var_9c7b96ed[var_8d5d092c])
			{
				if(self.stub.script_noteworthy === "traverse")
				{
					if(isdefined(self.stub.s_loc.var_5a099a2d) && self.stub.s_loc.var_5a099a2d)
					{
						return 0;
					}
					self.hint_string[n_player_index] = #"hash_2f3ffd00c724e116";
				}
				else
				{
					self.hint_string[n_player_index] = #"hash_7667bd0f83307360";
				}
				b_result = 1;
			}
			else
			{
				if(isdefined(self.stub.delay) && !self.stub flag::get("delayed"))
				{
					self.hint_string[n_player_index] = #"hash_4be7c1bbfe9f5d86";
					b_result = 1;
				}
				else
				{
					switch(self.stub.script_string)
					{
						case "spartan_monument":
						{
							if(zm_utility::is_standard())
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_42da633feb35d41e", #"hash_2033d0fbd99966ca");
							}
							else
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_19ac89c0660faf6f", #"hash_36b6ed710419054d");
							}
							break;
						}
						case "amphitheater":
						{
							if(zm_utility::is_standard())
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_b24be5d98c741f5", #"hash_10c94d259f6ba46b");
							}
							else
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_2fa0e740320682d2", #"hash_4559e7775ede2f66");
							}
							break;
						}
						case "center_of_the_world":
						{
							if(zm_utility::is_standard())
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_6e9395b99bf2f2a1", #"hash_7569a626e8c1a1f");
							}
							else
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_1516f25ae34907a6", #"hash_5a2c2b30f6dc5c82");
							}
							break;
						}
						case "hash_598ac0d50abb3300":
						{
							if(zm_utility::is_standard())
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_114c77bb7d6a22e4", #"hash_56698a0a66eec888");
							}
							else
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_714bd85760d8eafd", #"hash_143e92a6b341b2e3");
							}
							break;
						}
						case "river_of_sorrow":
						{
							if(zm_utility::is_standard())
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_3d19d8c1006c9a52", #"hash_5818d2dcee06ede6");
							}
							else
							{
								self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_659a9e3b2599c48b", #"hash_45b295f718835a41");
							}
							break;
						}
						case "column_to_park":
						case "fountain_to_park":
						case "park_to_column":
						case "park_to_fountain":
						case "fountain_to_column":
						case "column_to_fountain":
						{
							if(isdefined(self.stub.s_loc.var_5a099a2d) && self.stub.s_loc.var_5a099a2d)
							{
								return 0;
							}
							self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_746e33772cb75300", #"hash_67f9ed805de4782c");
							break;
						}
						default:
						{
							self.hint_string[n_player_index] = zm_utility::function_d6046228(#"hash_2731cc5c1208e2e4", #"hash_47b20f457b370888");
							break;
						}
					}
					b_result = 1;
				}
			}
		}
	}
	return b_result;
}

/*
	Name: function_706b7928
	Namespace: zm_red_fasttravel
	Checksum: 0xDDD554F7
	Offset: 0x1B60
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_706b7928()
{
	level endon(#"end_game");
	level flag::init(#"hash_718fe784e4ddaa70");
	level flag::wait_till("start_zombie_round_logic");
	level flag::wait_till_any(array("connect_river_acheron_to_serpents_pass", "connect_serpents_pass_to_drakaina_arena"));
	level flag::set(#"hash_718fe784e4ddaa70");
}

/*
	Name: function_63cbb9f
	Namespace: zm_red_fasttravel
	Checksum: 0x21DC50CE
	Offset: 0x1C18
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_63cbb9f()
{
	level endon(#"end_game");
	level flag::init(#"hash_42322632a02d834d");
	level flag::wait_till("start_zombie_round_logic");
	level flag::wait_till_any(array("connect_river_acheron_to_cliff_tombs", "connect_cliff_tombs_to_drakaina_arena"));
	level flag::set(#"hash_42322632a02d834d");
}

/*
	Name: function_7ebbc601
	Namespace: zm_red_fasttravel
	Checksum: 0x40DFE3C3
	Offset: 0x1CD0
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_7ebbc601()
{
	level endon(#"end_game");
	level flag::init(#"hash_6a9e3d8abf194ccc");
	level flag::wait_till("start_zombie_round_logic");
	level flag::wait_till_any(array("connect_apollo_temple_to_western_plaza", "connect_western_plaza_to_monument_of_craterus", "connect_western_plaza_to_bathhouse_upper"));
	level flag::set(#"hash_6a9e3d8abf194ccc");
}

/*
	Name: function_b3bfd869
	Namespace: zm_red_fasttravel
	Checksum: 0x251EAC65
	Offset: 0x1D90
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_b3bfd869()
{
	level endon(#"end_game");
	level flag::init(#"hash_594bc19e3aca5c49");
	level flag::wait_till("start_zombie_round_logic");
	level flag::wait_till_any(array("connect_apollo_temple_to_eastern_plaza", "connect_eastern_plaza_to_upper_road", "connect_eastern_plaza_to_temple_terrace"));
	level flag::set(#"hash_594bc19e3aca5c49");
}

/*
	Name: function_28deccf1
	Namespace: zm_red_fasttravel
	Checksum: 0x23800D91
	Offset: 0x1E50
	Size: 0x448
	Parameters: 2
	Flags: Linked
*/
function function_28deccf1(var_de3a312c, var_d53c9600 = 1)
{
	self endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	if(isdefined(var_de3a312c.var_a4134e51))
	{
		var_6761ef1c = var_de3a312c.var_a4134e51;
	}
	while(!level flag::exists(var_6761ef1c))
	{
		waitframe(1);
	}
	if(!level flag::get(var_6761ef1c))
	{
		var_de3a312c thread function_f8655c9();
	}
	else
	{
		self clientfield::set_to_player(var_de3a312c.script_string, var_d53c9600);
		switch(var_d53c9600)
		{
			case 1:
			{
				var_de3a312c.var_42b23772.var_3925cac9[self getentitynumber()] = 1;
				var_de3a312c.var_2a2d0b17.var_3925cac9[self getentitynumber()] = 0;
				break;
			}
			case 2:
			{
				var_de3a312c.var_42b23772.var_3925cac9[self getentitynumber()] = 0;
				var_de3a312c.var_2a2d0b17.var_3925cac9[self getentitynumber()] = 1;
				break;
			}
			case 0:
			{
				var_de3a312c.var_42b23772 hidepart("tag_symbol_blue");
				var_de3a312c.var_42b23772 hidepart("tag_symbol_red");
				var_de3a312c.var_42b23772 show();
				var_de3a312c.var_2a2d0b17 hide();
				break;
			}
		}
		if(var_d53c9600 == 1 || var_d53c9600 == 2)
		{
			var_de3a312c.var_42b23772 hide();
			var_de3a312c.var_2a2d0b17 hide();
			a_players = util::get_players(#"allies");
			foreach(e_player in a_players)
			{
				if(isdefined(var_de3a312c.var_42b23772.var_3925cac9[e_player getentitynumber()]) && var_de3a312c.var_42b23772.var_3925cac9[e_player getentitynumber()])
				{
					var_de3a312c.var_42b23772 showtoplayer(e_player);
				}
				if(isdefined(var_de3a312c.var_2a2d0b17.var_3925cac9[e_player getentitynumber()]) && var_de3a312c.var_2a2d0b17.var_3925cac9[e_player getentitynumber()])
				{
					var_de3a312c.var_2a2d0b17 showtoplayer(e_player);
				}
			}
		}
	}
}

/*
	Name: function_f8655c9
	Namespace: zm_red_fasttravel
	Checksum: 0x38A662E5
	Offset: 0x22A0
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_f8655c9()
{
	self notify("64b5770ecbe57f8f");
	self endon("64b5770ecbe57f8f");
	level flag::wait_till(self.var_a4134e51);
	self.var_42b23772 showpart("tag_symbol_blue");
	array::thread_all(util::get_players(#"allies"), &function_28deccf1, self, 1);
}

/*
	Name: function_af65fe93
	Namespace: zm_red_fasttravel
	Checksum: 0x28D6BAED
	Offset: 0x2350
	Size: 0xF4
	Parameters: 1
	Flags: Linked
*/
function function_af65fe93(var_79bf62e6)
{
	if(!isplayer(self) || !isdefined(var_79bf62e6))
	{
		return;
	}
	str_loc = var_79bf62e6.stub.script_string;
	s_loc = struct::get((str_loc + "_end_") + self getentitynumber());
	self util::create_streamer_hint(s_loc.origin, s_loc.angles, 5);
	self util::delay("fasttravel_over", "disconnect", &util::clear_streamer_hint);
}

