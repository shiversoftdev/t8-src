// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4194df57536e11ed;
#using script_50719ad9bcd4b183;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;

#namespace lui;

/*
	Name: function_89f2df9
	Namespace: lui
	Checksum: 0x291F4A5E
	Offset: 0x258
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"lui_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: lui
	Checksum: 0x7EF7082
	Offset: 0x2A0
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_spawned(&refresh_menu_values);
	function_b95a3ba5("FullScreenBlack", &full_screen_black::register, "full_screen_black");
	function_b95a3ba5("InitialBlack", &initial_black::register, "initial_black");
}

/*
	Name: function_b95a3ba5
	Namespace: lui
	Checksum: 0x3CDAD5E4
	Offset: 0x330
	Size: 0x66
	Parameters: 3
	Flags: Linked
*/
function function_b95a3ba5(alias, var_dd4bada5, uid)
{
	if(!isdefined(level.luimenus))
	{
		level.luimenus = array();
	}
	level.luimenus[alias] = [[var_dd4bada5]](uid);
}

/*
	Name: function_e810a527
	Namespace: lui
	Checksum: 0x34FD4BAF
	Offset: 0x3A0
	Size: 0x1C
	Parameters: 1
	Flags: Linked
*/
function function_e810a527(alias)
{
	return level.luimenus[alias];
}

/*
	Name: refresh_menu_values
	Namespace: lui
	Checksum: 0xF6CF65BE
	Offset: 0x3C8
	Size: 0xF4
	Parameters: 0
	Flags: Linked, Private
*/
private function refresh_menu_values()
{
	if(!isdefined(level.lui_script_globals))
	{
		return;
	}
	foreach(k, v in level.lui_script_globals)
	{
		foreach(k2, v2 in v)
		{
			self set_value_for_player(k, k2, v2);
		}
	}
}

/*
	Name: play_animation
	Namespace: lui
	Checksum: 0x2F8B83E3
	Offset: 0x4C8
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function play_animation(menu, str_anim)
{
	str_curr_anim = self getluimenudata(menu, "current_animation");
	str_new_anim = str_anim;
	if(isdefined(str_curr_anim) && str_curr_anim == str_anim)
	{
		str_new_anim = "";
	}
	self setluimenudata(menu, #"current_animation", str_new_anim);
}

/*
	Name: set_color
	Namespace: lui
	Checksum: 0xDA550A3
	Offset: 0x570
	Size: 0x80
	Parameters: 2
	Flags: Linked
*/
function set_color(menu, color)
{
	if(!isint(menu))
	{
		[[ menu ]]->function_eccc151d(self, color[0]);
		[[ menu ]]->function_2208b8db(self, color[1]);
		[[ menu ]]->function_7420df0a(self, color[2]);
	}
}

/*
	Name: set_value_for_player
	Namespace: lui
	Checksum: 0xA2591322
	Offset: 0x5F8
	Size: 0x94
	Parameters: 3
	Flags: Linked
*/
function set_value_for_player(str_menu_id, str_variable_id, value)
{
	if(!isdefined(self.lui_script_menus))
	{
		self.lui_script_menus = [];
	}
	if(!isdefined(self.lui_script_menus[str_menu_id]))
	{
		self.lui_script_menus[str_menu_id] = self openluimenu(str_menu_id);
	}
	self setluimenudata(self.lui_script_menus[str_menu_id], str_variable_id, value);
}

/*
	Name: set_global
	Namespace: lui
	Checksum: 0xB2DC56B0
	Offset: 0x698
	Size: 0x118
	Parameters: 3
	Flags: None
*/
function set_global(str_menu_id, str_variable_id, value)
{
	if(!isdefined(level.lui_script_globals))
	{
		level.lui_script_globals = [];
	}
	if(!isdefined(level.lui_script_globals[str_menu_id]))
	{
		level.lui_script_globals[str_menu_id] = [];
	}
	level.lui_script_globals[str_menu_id][str_variable_id] = value;
	if(isdefined(level.players))
	{
		foreach(player in level.players)
		{
			player set_value_for_player(str_menu_id, str_variable_id, value);
		}
	}
}

/*
	Name: timer
	Namespace: lui
	Checksum: 0x1222C8A3
	Offset: 0x7B8
	Size: 0x184
	Parameters: 5
	Flags: None
*/
function timer(n_time, str_endon, x = 1080, y = 200, height = 60)
{
	lui = self openluimenu("HudElementTimer");
	self setluimenudata(lui, #"x", x);
	self setluimenudata(lui, #"y", y);
	self setluimenudata(lui, #"height", height);
	self setluimenudata(lui, #"time", gettime() + int(n_time * 1000));
	if(isdefined(str_endon))
	{
		self waittill_timeout(n_time, str_endon);
	}
	else
	{
		wait(n_time);
	}
	self closeluimenu(lui);
}

/*
	Name: prime_movie
	Namespace: lui
	Checksum: 0xE28F31DC
	Offset: 0x948
	Size: 0x18C
	Parameters: 3
	Flags: Linked
*/
function prime_movie(str_movie, b_looping = 0, str_key = #"")
{
	if(isarray(self))
	{
		foreach(player in self)
		{
			player primemovie(str_movie, b_looping, str_key);
		}
	}
	else if(self == level)
	{
		foreach(player in level.players)
		{
			player primemovie(str_movie, b_looping, str_key);
		}
	}
	else
	{
		self primemovie(str_movie, b_looping, str_key);
	}
}

/*
	Name: function_2fb8927b
	Namespace: lui
	Checksum: 0xF0019F7B
	Offset: 0xAE0
	Size: 0x108
	Parameters: 4
	Flags: None
*/
function function_2fb8927b(str_team, str_movie, b_looping = 0, str_key = #"")
{
	callback::on_connect(&function_67373791, undefined, str_team, str_movie, b_looping, str_key);
	foreach(player in util::get_human_players(str_team))
	{
		player prime_movie(str_movie);
	}
}

/*
	Name: function_67373791
	Namespace: lui
	Checksum: 0xE4F0399C
	Offset: 0xBF0
	Size: 0x6C
	Parameters: 4
	Flags: Linked, Private
*/
private function function_67373791(str_team, str_movie, b_looping, str_key)
{
	if(util::is_on_side(str_team))
	{
		if(util::function_8e89351(self))
		{
			prime_movie(str_movie);
		}
	}
}

/*
	Name: function_c6d1cb5d
	Namespace: lui
	Checksum: 0x6F8117DB
	Offset: 0xC68
	Size: 0x148
	Parameters: 8
	Flags: None
*/
function function_c6d1cb5d(str_team, str_movie, str_type, show_black_screen = 0, b_looping = 0, var_d687a9b7 = 0, str_key = #"", n_timeout)
{
	callback::remove_on_connect(&function_67373791);
	foreach(player in util::get_human_players(str_team))
	{
		player thread play_movie(str_movie, str_type, show_black_screen, b_looping, var_d687a9b7, str_key, n_timeout);
	}
}

/*
	Name: play_movie
	Namespace: lui
	Checksum: 0x7CF3F843
	Offset: 0xDB8
	Size: 0x458
	Parameters: 8
	Flags: Linked
*/
function play_movie(str_movie, str_type, show_black_screen = 0, b_looping = 0, var_d687a9b7 = 0, str_key = #"", n_timeout, var_c16d0253 = 1)
{
	if(str_type === "fullscreen" || str_type === "fullscreen_additive")
	{
		b_hide_hud = 1;
	}
	if(isarray(self))
	{
		a_players = self;
	}
	else if(self == level)
	{
		a_players = level.players;
	}
	if(isarray(a_players))
	{
		var_7e05b6e9 = [];
		foreach(player in a_players)
		{
			if(isbot(player) || (var_c16d0253 && player issplitscreen()))
			{
				array::add(var_7e05b6e9, player);
			}
		}
		foreach(bot in var_7e05b6e9)
		{
			arrayremovevalue(a_players, bot);
		}
		foreach(player in a_players)
		{
			if(isdefined(b_hide_hud))
			{
				player thread function_6c2457a9(1);
			}
			player thread _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, var_d687a9b7, str_key, n_timeout);
		}
		if(a_players.size)
		{
			array::wait_till(a_players, "movie_done", n_timeout);
		}
		else
		{
			waitframe(1);
		}
		if(isdefined(b_hide_hud))
		{
			foreach(player in a_players)
			{
				if(!isdefined(player))
				{
					continue;
				}
				player thread function_6c2457a9(0);
			}
		}
	}
	else if(isdefined(b_hide_hud))
	{
		self thread function_6c2457a9(1);
	}
	_play_movie_for_player(str_movie, str_type, 0, b_looping, var_d687a9b7, str_key, n_timeout);
	if(isdefined(b_hide_hud) && isdefined(self))
	{
		self thread function_6c2457a9(0);
	}
	level notify(#"movie_done", {#type:str_type});
}

/*
	Name: _play_movie_for_player
	Namespace: lui
	Checksum: 0xBB78445E
	Offset: 0x1218
	Size: 0x36E
	Parameters: 7
	Flags: Linked, Private
*/
private function _play_movie_for_player(str_movie, str_type, show_black_screen, b_looping, var_d687a9b7, str_key, n_timeout)
{
	self endon(#"disconnect");
	str_menu = undefined;
	switch(str_type)
	{
		case "fullscreen_additive":
		case "fullscreen":
		{
			str_menu = "full_screen_movie";
			break;
		}
		default:
		{
			/#
				assertmsg("" + str_type + "");
			#/
		}
	}
	if(str_type == "pip")
	{
		self playsoundtoplayer(#"uin_pip_open", self);
	}
	lui_menu = function_e810a527(str_menu);
	[[ lui_menu ]]->open(self);
	if(isdefined(lui_menu))
	{
		[[ lui_menu ]]->function_87bb24(self, str_movie);
		[[ lui_menu ]]->function_251fc818(self, str_key);
		[[ lui_menu ]]->function_8f7a8b9c(self, show_black_screen);
		[[ lui_menu ]]->function_5caa21cb(self, b_looping);
		[[ lui_menu ]]->function_5e22e9d6(self, var_d687a9b7);
		[[ lui_menu ]]->function_493305af(self, 0);
		if(issubstr(str_type, "additive"))
		{
			[[ lui_menu ]]->function_493305af(self, 1);
		}
		while(true)
		{
			n_start_time = gettime();
			if(isdefined(n_timeout))
			{
				waitresult = undefined;
				waitresult = self waittill_timeout(n_timeout, #"menuresponse");
			}
			else
			{
				waitresult = undefined;
				waitresult = self waittill(#"menuresponse");
			}
			n_total_time = float(gettime() - n_start_time) / 1000;
			menu = waitresult.menu;
			response = waitresult.response;
			if(waitresult._notify == "timeout" || (menu === hash(str_menu) && response === #"finished_movie_playback"))
			{
				if(str_type == "pip")
				{
					self playsoundtoplayer(#"uin_pip_close", self);
				}
				[[ lui_menu ]]->close(self);
				self notify(#"movie_done");
				break;
			}
		}
	}
}

/*
	Name: function_6c2457a9
	Namespace: lui
	Checksum: 0x68B1921
	Offset: 0x1590
	Size: 0x17C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_6c2457a9(b_disable = 1)
{
	if(b_disable)
	{
		self flagsys::set(#"playing_movie_hide_hud");
		self val::set(#"play_movie", "show_hud", 0);
		self val::set(#"play_movie", "takedamage", 0);
		self scene::set_igc_active(1);
		self thread scene::scene_disable_player_stuff();
		self notify(#"delete_weapon_objects");
	}
	else
	{
		self flagsys::clear(#"playing_movie_hide_hud");
		self val::reset(#"play_movie", "show_hud");
		self val::reset(#"play_movie", "takedamage");
		self scene::set_igc_active(0);
		self thread scene::scene_enable_player_stuff();
	}
}

/*
	Name: function_6bbde8ac
	Namespace: lui
	Checksum: 0x4F2CD00F
	Offset: 0x1718
	Size: 0x318
	Parameters: 1
	Flags: None
*/
function function_6bbde8ac(show_black_screen = 1)
{
	var_bca36789 = getmapoutromovie();
	if(!isdefined(var_bca36789) || var_bca36789 == #"")
	{
		return;
	}
	if(isarray(self))
	{
		a_players = self;
	}
	else if(self == level)
	{
		a_players = level.players;
	}
	level flagsys::set("playing_outro_movie");
	if(isarray(a_players))
	{
		foreach(player in a_players)
		{
			player flagsys::set("playing_movie_hide_hud");
			player val::set(#"play_movie", "show_hud", 0);
		}
		array::wait_till(a_players, "movie_done");
		foreach(player in a_players)
		{
			player flagsys::clear("playing_movie_hide_hud");
			player val::reset(#"play_movie", "show_hud");
		}
	}
	else
	{
		self flagsys::set("playing_movie_hide_hud");
		self val::set(#"play_movie", "show_hud", 0);
		if(isdefined(self))
		{
			self flagsys::clear("playing_movie_hide_hud");
			self val::reset(#"play_movie", "show_hud");
		}
	}
	level flagsys::clear("playing_outro_movie");
	level notify(#"movie_done", {#type:"outro"});
}

/*
	Name: function_1bc580af
	Namespace: lui
	Checksum: 0xB94396A0
	Offset: 0x1A38
	Size: 0x17C
	Parameters: 0
	Flags: Private
*/
private function function_1bc580af()
{
	lui_menu = function_e810a527("full_screen_movie");
	[[ lui_menu ]]->open(self);
	if(isdefined(lui_menu))
	{
		[[ lui_menu ]]->function_3a81612d(self, 1);
		[[ lui_menu ]]->function_8f7a8b9c(self, 1);
		while(true)
		{
			waitresult = undefined;
			waitresult = self waittill(#"menuresponse");
			menu = waitresult.menu;
			response = waitresult.response;
			value = waitresult.value;
			if(menu === #"full_screen_movie")
			{
				if(response === #"finished_movie_playback")
				{
					[[ lui_menu ]]->close(self);
					self notify(#"movie_done");
					break;
				}
				else if(response === #"skippable" && isdefined(value))
				{
					[[ lui_menu ]]->function_5e22e9d6(self, value);
				}
			}
		}
	}
}

/*
	Name: screen_flash
	Namespace: lui
	Checksum: 0x3FB251A9
	Offset: 0x1BC0
	Size: 0x18C
	Parameters: 7
	Flags: Linked
*/
function screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha = 1, v_color, b_force_close_menu = 0, var_4db66001 = 0)
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			player thread screen_flash(n_fadein_time, n_hold_time, n_fadeout_time, n_target_alpha, v_color, b_force_close_menu, var_4db66001);
		}
	}
	else
	{
		self endon(#"disconnect");
		if(var_4db66001 && self scene::is_igc_active())
		{
			return;
		}
		self _screen_fade(n_fadein_time, n_target_alpha, 0, v_color, b_force_close_menu);
		wait(n_hold_time);
		self _screen_fade(n_fadeout_time, 0, n_target_alpha, v_color, b_force_close_menu);
	}
}

/*
	Name: screen_fade
	Namespace: lui
	Checksum: 0x3AB350D4
	Offset: 0x1D58
	Size: 0x13C
	Parameters: 7
	Flags: Linked
*/
function screen_fade(n_time, n_target_alpha = 1, n_start_alpha = 0, v_color, b_force_close_menu = 0, str_menu_id, var_b675738a)
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			player thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id, var_b675738a);
		}
	}
	else
	{
		self thread _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id, var_b675738a);
	}
}

/*
	Name: screen_fade_out
	Namespace: lui
	Checksum: 0x838E6ACE
	Offset: 0x1EA0
	Size: 0x52
	Parameters: 4
	Flags: Linked
*/
function screen_fade_out(n_time, v_color, str_menu_id, var_b675738a)
{
	screen_fade(n_time, 1, 0, v_color, 0, str_menu_id, var_b675738a);
	wait(n_time);
}

/*
	Name: screen_fade_in
	Namespace: lui
	Checksum: 0x91765E9A
	Offset: 0x1F00
	Size: 0x52
	Parameters: 4
	Flags: Linked
*/
function screen_fade_in(n_time, v_color, str_menu_id, var_b675738a)
{
	screen_fade(n_time, 0, 1, v_color, 1, str_menu_id, var_b675738a);
	wait(n_time);
}

/*
	Name: screen_close_menu
	Namespace: lui
	Checksum: 0xBFDEDEA
	Offset: 0x1F60
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function screen_close_menu()
{
	if(self == level)
	{
		foreach(player in level.players)
		{
			player thread _screen_close_menu();
		}
	}
	else
	{
		self thread _screen_close_menu();
	}
}

/*
	Name: _screen_close_menu
	Namespace: lui
	Checksum: 0x9355EF5D
	Offset: 0x2010
	Size: 0x10C
	Parameters: 0
	Flags: Linked, Private
*/
private function _screen_close_menu()
{
	self notify(#"_screen_fade");
	self endon(#"_screen_fade", #"disconnect");
	if(isdefined(self.screen_fade_menus))
	{
		foreach(str_menu_id, lui_menu in self.screen_fade_menus)
		{
			if(isint(lui_menu.lui_menu))
			{
				self closeluimenu(lui_menu.lui_menu);
			}
			else
			{
				[[ lui_menu.lui_menu ]]->close(self);
			}
			self.screen_fade_menus[str_menu_id] = undefined;
		}
	}
}

/*
	Name: _screen_fade
	Namespace: lui
	Checksum: 0xFC52C3BF
	Offset: 0x2128
	Size: 0x5F2
	Parameters: 7
	Flags: Linked, Private
*/
private function _screen_fade(n_time, n_target_alpha, n_start_alpha, v_color, b_force_close_menu, str_menu_id = "default", var_b675738a = 0)
{
	self notify("_screen_fade_" + str_menu_id);
	self endon("_screen_fade_" + str_menu_id, #"disconnect");
	if(!isdefined(self.screen_fade_menus))
	{
		self.screen_fade_menus = [];
	}
	if(!isdefined(level.screen_fade_network_frame))
	{
		level.screen_fade_network_frame = 0;
	}
	if(!isdefined(v_color))
	{
		v_color = (0, 0, 0);
	}
	n_time_ms = int(int(n_time * 1000));
	str_menu = "FullScreenBlack";
	if(isstring(v_color))
	{
		switch(v_color)
		{
			case "black":
			{
				v_color = (0, 0, 0);
				break;
			}
			case "white":
			{
				v_color = (1, 1, 1);
				break;
			}
		}
	}
	lui_menu = 0;
	if(isdefined(self.screen_fade_menus[str_menu_id]))
	{
		s_menu = self.screen_fade_menus[str_menu_id];
		lui_menu = s_menu.lui_menu;
		_one_screen_fade_per_network_frame(s_menu);
		n_start_alpha = lerpfloat(s_menu.n_start_alpha, s_menu.n_target_alpha, gettime() - s_menu.n_start_time);
	}
	else if(isdefined(function_e810a527(str_menu)))
	{
		lui_menu = function_e810a527(str_menu);
		[[ lui_menu ]]->open(self);
	}
	else
	{
		lui_menu = self openluimenu(str_menu);
	}
	self.screen_fade_menus[str_menu_id] = spawnstruct();
	self.screen_fade_menus[str_menu_id].lui_menu = lui_menu;
	self.screen_fade_menus[str_menu_id].n_start_alpha = n_start_alpha;
	self.screen_fade_menus[str_menu_id].n_target_alpha = n_target_alpha;
	self.screen_fade_menus[str_menu_id].n_target_time = n_time_ms;
	self.screen_fade_menus[str_menu_id].n_start_time = gettime();
	self set_color(lui_menu, v_color);
	drawhud = (var_b675738a ? 1 : 0);
	if(isint(lui_menu))
	{
		self setluimenudata(lui_menu, #"startalpha", n_start_alpha);
		self setluimenudata(lui_menu, #"endalpha", n_target_alpha);
		self setluimenudata(lui_menu, #"fadeovertime", n_time_ms);
		self setluimenudata(lui_menu, #"drawhud", drawhud);
	}
	else
	{
		[[ lui_menu ]]->function_9cd54463(self, n_start_alpha);
		[[ lui_menu ]]->function_331f9dd(self, n_target_alpha);
		[[ lui_menu ]]->function_237ff433(self, n_time_ms);
		[[ lui_menu ]]->function_ae1277a0(self, drawhud);
	}
	/#
		if(!isdefined(level.n_fade_debug_time))
		{
			level.n_fade_debug_time = 0;
		}
		n_debug_time = gettime();
		if(n_debug_time - level.n_fade_debug_time > 5000)
		{
			printtoprightln("");
		}
		level.n_fade_debug_time = n_debug_time;
	#/
	if(n_time > 0)
	{
		wait(n_time);
	}
	if(isint(lui_menu))
	{
		self setluimenudata(lui_menu, #"fadeovertime", 0);
	}
	else
	{
		[[ lui_menu ]]->function_237ff433(self, 0);
	}
	if(isdefined(self.screen_fade_menus) && (b_force_close_menu || n_target_alpha == 0))
	{
		if(isdefined(self.screen_fade_menus[str_menu_id]))
		{
			if(isint(lui_menu))
			{
				self closeluimenu(self.screen_fade_menus[str_menu_id].lui_menu);
			}
			else
			{
				[[ lui_menu ]]->close(self);
			}
		}
		self.screen_fade_menus[str_menu_id] = undefined;
		if(!self.screen_fade_menus.size)
		{
			self.screen_fade_menus = undefined;
		}
	}
}

/*
	Name: _one_screen_fade_per_network_frame
	Namespace: lui
	Checksum: 0xD49CBE3B
	Offset: 0x2728
	Size: 0x4E
	Parameters: 1
	Flags: Linked, Private
*/
private function _one_screen_fade_per_network_frame(s_menu)
{
	while(s_menu.screen_fade_network_frame === level.network_frame)
	{
		util::wait_network_frame();
	}
	s_menu.screen_fade_network_frame = level.network_frame;
}

/*
	Name: open_generic_script_dialog
	Namespace: lui
	Checksum: 0x2F90EA8B
	Offset: 0x2780
	Size: 0x166
	Parameters: 2
	Flags: None
*/
function open_generic_script_dialog(title, description)
{
	self endon_callback(&function_5ce0a623, #"close_generic_script_dialog", #"disconnect");
	dialog = self openluimenu("ScriptMessageDialog_Compact");
	self setluimenudata(dialog, #"title", title);
	self setluimenudata(dialog, #"description", description);
	self.var_520fb18c = dialog;
	do
	{
		waitresult = undefined;
		waitresult = self waittill(#"menuresponse");
		menu = waitresult.menu;
		response = waitresult.response;
	}
	while(menu != "ScriptMessageDialog_Compact" || response != "close");
	self closeluimenu(dialog);
	self.var_520fb18c = undefined;
}

/*
	Name: function_5ce0a623
	Namespace: lui
	Checksum: 0xFA7505BC
	Offset: 0x28F0
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_5ce0a623(str_notify)
{
	if(str_notify == "close_generic_script_dialog")
	{
		if(isdefined(self.var_520fb18c))
		{
			self closeluimenu(self.var_520fb18c);
		}
	}
}

/*
	Name: close_generic_script_dialog
	Namespace: lui
	Checksum: 0x3BE807F7
	Offset: 0x2940
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function close_generic_script_dialog()
{
	self notify(#"close_generic_script_dialog");
}

/*
	Name: open_script_dialog
	Namespace: lui
	Checksum: 0x3C661CDA
	Offset: 0x2960
	Size: 0xCC
	Parameters: 1
	Flags: None
*/
function open_script_dialog(dialog_name)
{
	self endon(#"disconnect");
	dialog = self openluimenu(dialog_name);
	do
	{
		waitresult = undefined;
		waitresult = self waittill(#"menuresponse");
		menu = waitresult.menu;
		response = waitresult.response;
	}
	while(menu != dialog_name || response != "close");
	self closeluimenu(dialog);
}

#namespace namespace_6aaccc24;

/*
	Name: __constructor
	Namespace: namespace_6aaccc24
	Checksum: 0x387822F2
	Offset: 0x2A38
	Size: 0x12
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self.var_47e79fc = "";
}

/*
	Name: setup_clientfields
	Namespace: namespace_6aaccc24
	Checksum: 0x22DFD7AC
	Offset: 0x2A58
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function setup_clientfields(uid)
{
	self.var_47e79fc = uid;
}

/*
	Name: function_da693cbe
	Namespace: namespace_6aaccc24
	Checksum: 0x1FAE6DB3
	Offset: 0x2A80
	Size: 0x64
	Parameters: 5
	Flags: Linked
*/
function function_da693cbe(field_name, var_948bda55, bits, type, var_59f69872 = 1)
{
	clientfield::function_346f95ba(self.var_47e79fc, field_name, var_948bda55, bits, type, var_59f69872);
}

/*
	Name: function_dcb34c80
	Namespace: namespace_6aaccc24
	Checksum: 0xE2AC1EFF
	Offset: 0x2AF0
	Size: 0x74
	Parameters: 4
	Flags: Linked
*/
function function_dcb34c80(var_2a0de052, field_name, var_948bda55, var_59f69872 = 1)
{
	clientfield::function_78175813("clientuimodel", var_2a0de052, "luielement." + self.var_47e79fc + "." + field_name, var_948bda55, var_59f69872);
}

/*
	Name: function_b0c4e363
	Namespace: namespace_6aaccc24
	Checksum: 0xF0B4C8ED
	Offset: 0x2B70
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_b0c4e363(player, field_name, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, field_name, value);
}

/*
	Name: function_d6203429
	Namespace: namespace_6aaccc24
	Checksum: 0xD149A308
	Offset: 0x2BB8
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function function_d6203429(player, field_name, value)
{
	player clientfield::function_9bf78ef8(self.var_47e79fc, field_name, value);
}

/*
	Name: function_8b8089ba
	Namespace: namespace_6aaccc24
	Checksum: 0xAABD2700
	Offset: 0x2C00
	Size: 0x4C
	Parameters: 3
	Flags: Linked
*/
function function_8b8089ba(player, menu_name, persistent = 0)
{
	player function_5686f5cd(menu_name, self.var_47e79fc, persistent);
}

/*
	Name: function_7bfd10e6
	Namespace: namespace_6aaccc24
	Checksum: 0x37FC4B61
	Offset: 0x2C58
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_7bfd10e6(player)
{
	return player function_3fc81484(self.var_47e79fc);
}

/*
	Name: function_a68f6e20
	Namespace: namespace_6aaccc24
	Checksum: 0xA6BAE91C
	Offset: 0x2C90
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_a68f6e20(player)
{
	if(isplayer(player))
	{
		player function_43d5b973(self.var_47e79fc);
	}
}

/*
	Name: __destructor
	Namespace: namespace_6aaccc24
	Checksum: 0x80F724D1
	Offset: 0x2CE0
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
}

#namespace lui;

/*
	Name: function_6aaccc24
	Namespace: lui
	Checksum: 0x7CD1D26C
	Offset: 0x2CF0
	Size: 0x206
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function function_6aaccc24()
{
	classes.var_6aaccc24[0] = spawnstruct();
	classes.var_6aaccc24[0].__vtable[913321084] = &namespace_6aaccc24::__destructor;
	classes.var_6aaccc24[0].__vtable[1500549600] = &namespace_6aaccc24::function_a68f6e20;
	classes.var_6aaccc24[0].__vtable[2080182502] = &namespace_6aaccc24::function_7bfd10e6;
	classes.var_6aaccc24[0].__vtable[1954510406] = &namespace_6aaccc24::function_8b8089ba;
	classes.var_6aaccc24[0].__vtable[702532567] = &namespace_6aaccc24::function_d6203429;
	classes.var_6aaccc24[0].__vtable[1329274013] = &namespace_6aaccc24::function_b0c4e363;
	classes.var_6aaccc24[0].__vtable[592229248] = &namespace_6aaccc24::function_dcb34c80;
	classes.var_6aaccc24[0].__vtable[630637378] = &namespace_6aaccc24::function_da693cbe;
	classes.var_6aaccc24[0].__vtable[1855416484] = &namespace_6aaccc24::setup_clientfields;
	classes.var_6aaccc24[0].__vtable[674154906] = &namespace_6aaccc24::__constructor;
}

