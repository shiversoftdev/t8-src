// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_maptable.gsc;
#using scripts\core_common\player\player_role.gsc;
#using scripts\core_common\ai_shared.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\vehicle_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_devgui.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_characters;

/*
	Name: __init__system__
	Namespace: zm_characters
	Checksum: 0x635F0D11
	Offset: 0xB80
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_characters", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: zm_characters
	Checksum: 0x477AD0FF
	Offset: 0xBC8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!isdefined(level.var_e52a681))
	{
		level.var_e52a681 = 0;
	}
	level.precachecustomcharacters = &precachecustomcharacters;
	initcharacterstartindex();
	/#
		zm_devgui::add_custom_devgui_callback(&function_9436b105);
	#/
}

/*
	Name: zombie_force_char
	Namespace: zm_characters
	Checksum: 0xC57993AC
	Offset: 0xC50
	Size: 0x94
	Parameters: 1
	Flags: Private
*/
function private zombie_force_char(n_char)
{
	/#
		/#
			assert(isdefined(self));
		#/
		/#
			assert(isplayer(self));
		#/
		/#
			assert(isalive(self));
		#/
		set_character(n_char);
	#/
}

/*
	Name: function_9436b105
	Namespace: zm_characters
	Checksum: 0x486ABC27
	Offset: 0xCF0
	Size: 0x10C
	Parameters: 1
	Flags: Private
*/
function private function_9436b105(cmd)
{
	/#
		if(issubstr(cmd, ""))
		{
			tokens = strtok(cmd, "");
			player = int(getsubstr(tokens[0], "".size));
			character = int(tokens[tokens.size - 1]);
			players = getplayers();
			players[player - 1] thread zombie_force_char(character);
		}
	#/
}

/*
	Name: precachecustomcharacters
	Namespace: zm_characters
	Checksum: 0x80F724D1
	Offset: 0xE08
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function precachecustomcharacters()
{
}

/*
	Name: initcharacterstartindex
	Namespace: zm_characters
	Checksum: 0x2CCCB5C4
	Offset: 0xE18
	Size: 0x26
	Parameters: 0
	Flags: Linked
*/
function initcharacterstartindex()
{
	level.characterstartindex = randomint(4);
}

/*
	Name: selectcharacterindextouse
	Namespace: zm_characters
	Checksum: 0x118FEB99
	Offset: 0xE48
	Size: 0x4A
	Parameters: 0
	Flags: None
*/
function selectcharacterindextouse()
{
	if(level.characterstartindex >= 4)
	{
		level.characterstartindex = 0;
	}
	self.characterindex = level.characterstartindex;
	level.characterstartindex++;
	return self.characterindex;
}

/*
	Name: function_b04c6f1f
	Namespace: zm_characters
	Checksum: 0x89FFD1F4
	Offset: 0xEA0
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_b04c6f1f()
{
	if(!isdefined(level.var_6f14e9e1))
	{
		level.var_6f14e9e1 = [];
	}
	arrayremovevalue(level.var_6f14e9e1, undefined, 0);
	var_8e495b9e = function_36936eeb();
	foreach(player in level.var_6f14e9e1)
	{
		if(isdefined(player.characterindex))
		{
			var_7d1b4e26 = function_d35e4c92(player.characterindex);
			arrayremoveindex(var_8e495b9e, var_7d1b4e26, 1);
		}
	}
	if(var_8e495b9e.size > 0)
	{
		var_2d9ca68d = array::random(var_8e495b9e);
		n_character_index = array::random(var_2d9ca68d);
		return n_character_index;
	}
	return level.validcharacters[0];
}

/*
	Name: set_character
	Namespace: zm_characters
	Checksum: 0xBE096EF4
	Offset: 0x1020
	Size: 0x2D4
	Parameters: 1
	Flags: Linked
*/
function set_character(character)
{
	self detachall();
	function_36936eeb();
	if(isdefined(character))
	{
		if(isarray(character))
		{
			self.characterindex = function_9004475c(character);
		}
		else
		{
			self.characterindex = character;
		}
	}
	if(!isdefined(self.characterindex) || !player_role::is_valid(self.characterindex))
	{
		self.characterindex = self function_b3a116a1();
		/#
			if(self ishost() && getdvarstring(#"force_char") != "")
			{
				self.characterindex = getdvarint(#"force_char", 0);
			}
		#/
		if(self.characterindex == 0)
		{
			self.characterindex = function_b04c6f1f();
		}
		self.pers[#"characterindex"] = self.characterindex;
	}
	player_role::set(self.characterindex);
	self.favorite_wall_weapons_list = [];
	self.talks_in_danger = 0;
	self setcharacterbodytype(self.characterindex);
	self setcharacteroutfit(0);
	function_50b1ae32();
	if(!isdefined(level.var_6f14e9e1))
	{
		level.var_6f14e9e1 = [];
	}
	else if(!isarray(level.var_6f14e9e1))
	{
		level.var_6f14e9e1 = array(level.var_6f14e9e1);
	}
	if(!isinarray(level.var_6f14e9e1, self))
	{
		level.var_6f14e9e1[level.var_6f14e9e1.size] = self;
	}
	characterindex = function_dc232a80();
	if(isdefined(characterindex))
	{
		zm_audio::setexertvoice(characterindex);
	}
}

/*
	Name: setup_personality_character_exerts
	Namespace: zm_characters
	Checksum: 0x8795964A
	Offset: 0x1300
	Size: 0xAB2
	Parameters: 0
	Flags: None
*/
function setup_personality_character_exerts()
{
	level.exert_sounds[1][#"burp"][0] = "vox_plr_0_exert_burp_0";
	level.exert_sounds[1][#"burp"][1] = "vox_plr_0_exert_burp_1";
	level.exert_sounds[1][#"burp"][2] = "vox_plr_0_exert_burp_2";
	level.exert_sounds[1][#"burp"][3] = "vox_plr_0_exert_burp_3";
	level.exert_sounds[1][#"burp"][4] = "vox_plr_0_exert_burp_4";
	level.exert_sounds[1][#"burp"][5] = "vox_plr_0_exert_burp_5";
	level.exert_sounds[1][#"burp"][6] = "vox_plr_0_exert_burp_6";
	level.exert_sounds[2][#"burp"][0] = "vox_plr_1_exert_burp_0";
	level.exert_sounds[2][#"burp"][1] = "vox_plr_1_exert_burp_1";
	level.exert_sounds[2][#"burp"][2] = "vox_plr_1_exert_burp_2";
	level.exert_sounds[2][#"burp"][3] = "vox_plr_1_exert_burp_3";
	level.exert_sounds[3][#"burp"][0] = "vox_plr_2_exert_burp_0";
	level.exert_sounds[3][#"burp"][1] = "vox_plr_2_exert_burp_1";
	level.exert_sounds[3][#"burp"][2] = "vox_plr_2_exert_burp_2";
	level.exert_sounds[3][#"burp"][3] = "vox_plr_2_exert_burp_3";
	level.exert_sounds[3][#"burp"][4] = "vox_plr_2_exert_burp_4";
	level.exert_sounds[3][#"burp"][5] = "vox_plr_2_exert_burp_5";
	level.exert_sounds[3][#"burp"][6] = "vox_plr_2_exert_burp_6";
	level.exert_sounds[4][#"burp"][0] = "vox_plr_3_exert_burp_0";
	level.exert_sounds[4][#"burp"][1] = "vox_plr_3_exert_burp_1";
	level.exert_sounds[4][#"burp"][2] = "vox_plr_3_exert_burp_2";
	level.exert_sounds[4][#"burp"][3] = "vox_plr_3_exert_burp_3";
	level.exert_sounds[4][#"burp"][4] = "vox_plr_3_exert_burp_4";
	level.exert_sounds[4][#"burp"][5] = "vox_plr_3_exert_burp_5";
	level.exert_sounds[4][#"burp"][6] = "vox_plr_3_exert_burp_6";
	level.exert_sounds[1][#"hitmed"][0] = "vox_plr_0_exert_pain_medium_0";
	level.exert_sounds[1][#"hitmed"][1] = "vox_plr_0_exert_pain_medium_1";
	level.exert_sounds[1][#"hitmed"][2] = "vox_plr_0_exert_pain_medium_2";
	level.exert_sounds[1][#"hitmed"][3] = "vox_plr_0_exert_pain_medium_3";
	level.exert_sounds[2][#"hitmed"][0] = "vox_plr_1_exert_pain_medium_0";
	level.exert_sounds[2][#"hitmed"][1] = "vox_plr_1_exert_pain_medium_1";
	level.exert_sounds[2][#"hitmed"][2] = "vox_plr_1_exert_pain_medium_2";
	level.exert_sounds[2][#"hitmed"][3] = "vox_plr_1_exert_pain_medium_3";
	level.exert_sounds[3][#"hitmed"][0] = "vox_plr_2_exert_pain_medium_0";
	level.exert_sounds[3][#"hitmed"][1] = "vox_plr_2_exert_pain_medium_1";
	level.exert_sounds[3][#"hitmed"][2] = "vox_plr_2_exert_pain_medium_2";
	level.exert_sounds[3][#"hitmed"][3] = "vox_plr_2_exert_pain_medium_3";
	level.exert_sounds[4][#"hitmed"][0] = "vox_plr_3_exert_pain_medium_0";
	level.exert_sounds[4][#"hitmed"][1] = "vox_plr_3_exert_pain_medium_1";
	level.exert_sounds[4][#"hitmed"][2] = "vox_plr_3_exert_pain_medium_2";
	level.exert_sounds[4][#"hitmed"][3] = "vox_plr_3_exert_pain_medium_3";
	level.exert_sounds[1][#"hitlrg"][0] = "vox_plr_0_exert_pain_high_0";
	level.exert_sounds[1][#"hitlrg"][1] = "vox_plr_0_exert_pain_high_1";
	level.exert_sounds[1][#"hitlrg"][2] = "vox_plr_0_exert_pain_high_2";
	level.exert_sounds[1][#"hitlrg"][3] = "vox_plr_0_exert_pain_high_3";
	level.exert_sounds[2][#"hitlrg"][0] = "vox_plr_1_exert_pain_high_0";
	level.exert_sounds[2][#"hitlrg"][1] = "vox_plr_1_exert_pain_high_1";
	level.exert_sounds[2][#"hitlrg"][2] = "vox_plr_1_exert_pain_high_2";
	level.exert_sounds[2][#"hitlrg"][3] = "vox_plr_1_exert_pain_high_3";
	level.exert_sounds[3][#"hitlrg"][0] = "vox_plr_2_exert_pain_high_0";
	level.exert_sounds[3][#"hitlrg"][1] = "vox_plr_2_exert_pain_high_1";
	level.exert_sounds[3][#"hitlrg"][2] = "vox_plr_2_exert_pain_high_2";
	level.exert_sounds[3][#"hitlrg"][3] = "vox_plr_2_exert_pain_high_3";
	level.exert_sounds[4][#"hitlrg"][0] = "vox_plr_3_exert_pain_high_0";
	level.exert_sounds[4][#"hitlrg"][1] = "vox_plr_3_exert_pain_high_1";
	level.exert_sounds[4][#"hitlrg"][2] = "vox_plr_3_exert_pain_high_2";
	level.exert_sounds[4][#"hitlrg"][3] = "vox_plr_3_exert_pain_high_3";
}

/*
	Name: function_36936eeb
	Namespace: zm_characters
	Checksum: 0x57A9A01C
	Offset: 0x1DC0
	Size: 0x452
	Parameters: 0
	Flags: Linked
*/
function function_36936eeb()
{
	if(!isdefined(level.characters))
	{
		level.characters = [];
		level.validcharacters = [];
		fields = zm_maptable::function_10672567();
		/#
			if(!isdefined(fields) || !isdefined(fields.zmcharacters))
			{
				for(i = 1; i <= 4; i++)
				{
					fields = getplayerrolefields(i, currentsessionmode());
					var_2a42c5e0 = fields.var_2a42c5e0;
					level.characters[var_2a42c5e0] = [];
					if(!isdefined(level.characters[var_2a42c5e0]))
					{
						level.characters[var_2a42c5e0] = [];
					}
					else if(!isarray(level.characters[var_2a42c5e0]))
					{
						level.characters[var_2a42c5e0] = array(level.characters[var_2a42c5e0]);
					}
					level.characters[var_2a42c5e0][level.characters[var_2a42c5e0].size] = i;
					if(!isdefined(level.validcharacters))
					{
						level.validcharacters = [];
					}
					else if(!isarray(level.validcharacters))
					{
						level.validcharacters = array(level.validcharacters);
					}
					level.validcharacters[level.validcharacters.size] = i;
				}
				return arraycopy(level.characters);
			}
		#/
		/#
			assert(isdefined(fields));
		#/
		/#
			assert(isdefined(fields.zmcharacters));
		#/
		for(i = 0; i < fields.zmcharacters.size; i++)
		{
			var_2a42c5e0 = function_d35e4c92(fields.zmcharacters[i].characterindex, 1);
			if(!isdefined(level.characters[var_2a42c5e0]))
			{
				level.characters[var_2a42c5e0] = [];
			}
			if(!isdefined(level.validcharacters))
			{
				level.validcharacters = [];
			}
			else if(!isarray(level.validcharacters))
			{
				level.validcharacters = array(level.validcharacters);
			}
			level.validcharacters[level.validcharacters.size] = fields.zmcharacters[i].characterindex;
			if(!isdefined(level.characters[var_2a42c5e0]))
			{
				level.characters[var_2a42c5e0] = [];
			}
			else if(!isarray(level.characters[var_2a42c5e0]))
			{
				level.characters[var_2a42c5e0] = array(level.characters[var_2a42c5e0]);
			}
			level.characters[var_2a42c5e0][level.characters[var_2a42c5e0].size] = fields.zmcharacters[i].characterindex;
		}
	}
	return arraycopy(level.characters);
}

/*
	Name: function_9004475c
	Namespace: zm_characters
	Checksum: 0x353B70C1
	Offset: 0x2220
	Size: 0xD6
	Parameters: 1
	Flags: Linked
*/
function function_9004475c(character)
{
	fields = zm_maptable::function_10672567();
	foreach(var_c81b1496 in fields.zmcharacters)
	{
		if(isinarray(character, var_c81b1496.name))
		{
			return var_c81b1496.characterindex;
		}
	}
	/#
		assertmsg("");
	#/
	return 0;
}

/*
	Name: function_d35e4c92
	Namespace: zm_characters
	Checksum: 0x8CA45B6C
	Offset: 0x2300
	Size: 0x11E
	Parameters: 2
	Flags: Linked
*/
function function_d35e4c92(characterindex, var_fdf0f13d = 0)
{
	if(isdefined(characterindex))
	{
		if(var_fdf0f13d || player_role::is_valid(characterindex))
		{
			fields = getplayerrolefields(characterindex, currentsessionmode());
			return fields.var_2a42c5e0;
		}
	}
	else if(isdefined(self) && isplayer(self))
	{
		characterindex = player_role::get();
		if(player_role::is_valid(characterindex))
		{
			fields = getplayerrolefields(player_role::get(), currentsessionmode());
			return fields.var_2a42c5e0;
		}
	}
	return 0;
}

/*
	Name: function_dc232a80
	Namespace: zm_characters
	Checksum: 0x3F944057
	Offset: 0x2428
	Size: 0x1F6
	Parameters: 1
	Flags: Linked
*/
function function_dc232a80(character)
{
	if(isdefined(self) && isplayer(self))
	{
		characterindex = player_role::get();
		if(player_role::is_valid(characterindex))
		{
			fields = getplayerrolefields(player_role::get(), currentsessionmode());
			return fields.var_3e570307;
		}
		/#
			assertmsg("" + characterindex);
		#/
	}
	else if(isarray(character))
	{
		fields = zm_maptable::function_10672567();
		foreach(var_c81b1496 in fields.zmcharacters)
		{
			if(isinarray(character, var_c81b1496.name))
			{
				rolefields = getplayerrolefields(var_c81b1496.characterindex, currentsessionmode());
				return rolefields.var_3e570307;
			}
		}
		/#
			assertmsg("");
		#/
	}
	return 0;
}

/*
	Name: is_character
	Namespace: zm_characters
	Checksum: 0x9C882AE4
	Offset: 0x2628
	Size: 0xE6
	Parameters: 1
	Flags: Linked
*/
function is_character(character)
{
	/#
		assert(isplayer(self));
	#/
	if(isdefined(self) && isplayer(self))
	{
		characterindex = player_role::get();
		if(player_role::is_valid(characterindex))
		{
			name = function_b14806c6(player_role::get(), currentsessionmode());
			return isinarray(character, name);
		}
	}
	return 0;
}

/*
	Name: function_50b1ae32
	Namespace: zm_characters
	Checksum: 0xCC99C31E
	Offset: 0x2718
	Size: 0xBD6
	Parameters: 0
	Flags: Linked
*/
function function_50b1ae32()
{
	if(is_character(array(#"hash_68255d9ce2a09382", #"hash_1a427f842f175b3c")))
	{
		self.revivevox = "scar";
		self.var_ff5f8752 = "self";
		self.var_c107ed3 = "support_scar";
		self.var_d10fb794 = "surrounded_scar";
		self.var_eee02beb = "streak_scar";
		return;
	}
	else
	{
		if(is_character(array(#"hash_7180c6cf382f6010", #"hash_14e91ceb9a7b3eb6")))
		{
			self.talks_in_danger = 1;
			level.rich_sq_player = self;
			self.revivevox = "brun";
			self.var_ff5f8752 = "self";
			self.var_c107ed3 = "support_brun";
			self.var_d10fb794 = "surrounded_brun";
			self.var_eee02beb = "streak_brun";
			return;
		}
		else
		{
			if(is_character(array(#"hash_f531a8c2df891cc", #"hash_26072a3b34719d22")))
			{
				self.revivevox = "dieg";
				self.var_ff5f8752 = "self";
				self.var_c107ed3 = "support_dieg";
				self.var_d10fb794 = "surrounded_dieg";
				self.var_eee02beb = "streak_dieg";
				return;
			}
			else
			{
				if(is_character(array(#"hash_3e63362aea484e09", #"hash_5a906d7137467771")))
				{
					self.revivevox = "shaw";
					self.var_ff5f8752 = "self";
					self.var_c107ed3 = "support_shaw";
					self.var_d10fb794 = "surrounded_shaw";
					self.var_eee02beb = "streak_shaw";
					return;
				}
				else
				{
					if(is_character(array(#"hash_59f3598ad57dadd8", #"hash_2bcebdf1bef33311", #"hash_5a715cb0a6e071ae")))
					{
						self.revivevox = "rich";
						self.var_ff5f8752 = "self";
						self.var_c107ed3 = "support_rich";
						self.var_d10fb794 = "surrounded_rich";
						self.var_eee02beb = "streak_rich";
						return;
					}
					else
					{
						if(is_character(array(#"hash_1aa57ef704f24fa5", #"hash_36bc80636f0fdac4")))
						{
							self.talks_in_danger = 1;
							level.rich_sq_player = self;
							self.revivevox = "demp";
							self.var_ff5f8752 = "self";
							self.var_c107ed3 = "support_demp";
							self.var_d10fb794 = "surrounded_demp";
							self.var_eee02beb = "streak_demp";
							return;
						}
						else
						{
							if(is_character(array(#"hash_22e6f7e13c3a99ef", #"hash_46b92e1337b43236")))
							{
								self.revivevox = "niko";
								self.var_ff5f8752 = "self";
								self.var_c107ed3 = "support_niko";
								self.var_d10fb794 = "surrounded_niko";
								self.var_eee02beb = "streak_niko";
								return;
							}
							else
							{
								if(is_character(array(#"hash_305f156156d37e34", #"hash_6df0037e3f390b15")))
								{
									self.revivevox = "take";
									self.var_ff5f8752 = "self";
									self.var_c107ed3 = "support_take";
									self.var_d10fb794 = "surrounded_take";
									self.var_eee02beb = "streak_take";
									return;
								}
								else
								{
									if(is_character(array(#"hash_73d71ff1e886bbe9")))
									{
										self.revivevox = "uric";
										self.var_ff5f8752 = "self";
										self.var_c107ed3 = "support_uric";
										self.var_d10fb794 = "surrounded_uric";
										self.var_eee02beb = "streak_uric";
										return;
									}
									else
									{
										if(is_character(array(#"hash_4cb4663e341a940")))
										{
											self.talks_in_danger = 1;
											level.rich_sq_player = self;
											self.revivevox = "udem";
											self.var_ff5f8752 = "self";
											self.var_c107ed3 = "support_udem";
											self.var_d10fb794 = "surrounded_udem";
											self.var_eee02beb = "streak_udem";
											return;
										}
										else
										{
											if(is_character(array(#"hash_78aa6812c38263ba")))
											{
												self.revivevox = "unik";
												self.var_ff5f8752 = "self";
												self.var_c107ed3 = "support_unik";
												self.var_d10fb794 = "surrounded_unik";
												self.var_eee02beb = "streak_unik";
												return;
											}
											else
											{
												if(is_character(array(#"hash_1fd4157dcafc6e45")))
												{
													self.revivevox = "utak";
													self.var_ff5f8752 = "self";
													self.var_c107ed3 = "support_utak";
													self.var_d10fb794 = "surrounded_utak";
													self.var_eee02beb = "streak_utak";
													return;
												}
												else
												{
													if(is_character(array(#"hash_3c0932fa55ee6e5b")))
													{
														self.revivevox = "brig";
														self.var_ff5f8752 = "self";
														self.var_c107ed3 = "support_brig";
														self.var_d10fb794 = "surrounded_brig";
														self.var_eee02beb = "streak_brig";
													}
													else
													{
														if(is_character(array(#"hash_5ebf024e1559c04a")))
														{
															self.revivevox = "butl";
															self.var_ff5f8752 = "self";
															self.var_c107ed3 = "support_butl";
															self.var_d10fb794 = "surrounded_butl";
															self.var_eee02beb = "streak_butl";
														}
														else
														{
															if(is_character(array(#"hash_4e8f51ec275a4a38")))
															{
																self.revivevox = "guns";
																self.var_ff5f8752 = "self";
																self.var_c107ed3 = "support_guns";
																self.var_d10fb794 = "surrounded_guns";
																self.var_eee02beb = "streak_guns";
															}
															else
															{
																if(is_character(array(#"hash_515977e191d13967")))
																{
																	self.revivevox = "psyc";
																	self.var_ff5f8752 = "self";
																	self.var_c107ed3 = "support_psyc";
																	self.var_d10fb794 = "surrounded_psyc";
																	self.var_eee02beb = "streak_psyc";
																}
																else
																{
																	if(is_character(array(#"hash_8d5bc4a77c74f69")))
																	{
																		self.revivevox = "russ";
																		self.var_ff5f8752 = "self";
																		self.var_c107ed3 = "support_russ";
																		self.var_d10fb794 = "surrounded_russ";
																		self.var_eee02beb = "streak_russ";
																	}
																	else
																	{
																		if(is_character(array(#"hash_291943ac9ed00ebc")))
																		{
																			self.revivevox = "mist";
																			self.var_ff5f8752 = "self";
																			self.var_c107ed3 = "support_mist";
																			self.var_d10fb794 = "surrounded_mist";
																			self.var_eee02beb = "streak_mist";
																		}
																		else
																		{
																			if(is_character(array(#"hash_7ba62675ab75df69")))
																			{
																				self.revivevox = "marl";
																				self.var_ff5f8752 = "self";
																				self.var_c107ed3 = "support_marl";
																				self.var_d10fb794 = "surrounded_marl";
																				self.var_eee02beb = "streak_marl";
																			}
																			else if(is_character(array(#"hash_447b3c77b73aa2a9")))
																			{
																				self.revivevox = "stuh";
																				self.var_ff5f8752 = "self";
																				self.var_c107ed3 = "support_stuh";
																				self.var_d10fb794 = "surrounded_stuh";
																				self.var_eee02beb = "streak_stuh";
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
}

