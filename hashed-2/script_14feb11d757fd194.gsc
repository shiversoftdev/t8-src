// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace voice;

/*
	Name: function_89f2df9
	Namespace: voice
	Checksum: 0xAC688999
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"voice", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: voice
	Checksum: 0xAF50B7E8
	Offset: 0x130
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	callback::on_connect(&on_player_connect);
	level.var_3e8bd5c = [];
	if(!isdefined(level.scr_sound))
	{
		level.scr_sound = [];
	}
	/#
		if(!isprofilebuild())
		{
			setdvar(#"hash_5a4f3b089c68658f", 1);
		}
	#/
}

/*
	Name: on_player_connect
	Namespace: voice
	Checksum: 0x72CAC1BB
	Offset: 0x1C8
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self init_character(undefined, "J_Head");
	if(isdefined(level.var_151fd2ac))
	{
		self thread [[level.var_151fd2ac]]();
	}
}

/*
	Name: function_4c866f3d
	Namespace: voice
	Checksum: 0x754ECBE6
	Offset: 0x218
	Size: 0xC
	Parameters: 1
	Flags: None
*/
function function_4c866f3d(table)
{
}

/*
	Name: add
	Namespace: voice
	Checksum: 0xFCEA91A9
	Offset: 0x230
	Size: 0x1C
	Parameters: 3
	Flags: None
*/
function add(chrname, scriptkey, alias)
{
}

/*
	Name: add_igc
	Namespace: voice
	Checksum: 0xAAD548B9
	Offset: 0x258
	Size: 0x14
	Parameters: 2
	Flags: None
*/
function add_igc(scriptid, alias)
{
}

/*
	Name: init_character
	Namespace: voice
	Checksum: 0x4A79CFE0
	Offset: 0x278
	Size: 0xDA
	Parameters: 3
	Flags: Linked
*/
function init_character(chrname, var_bd68a08e, var_f4aa7514 = 0)
{
	/#
		assert(isentity(self), "");
	#/
	/#
		assert(isplayer(self) || isdefined(chrname), "");
	#/
	if(isdefined(self))
	{
		self.var_3975c22 = chrname;
		self.var_bd68a08e = var_bd68a08e;
		self.var_556f910a = [];
		self.var_78566c82 = 0;
		self.var_46b25f4f = var_f4aa7514;
	}
}

/*
	Name: set_portrait
	Namespace: voice
	Checksum: 0x60D4DEBD
	Offset: 0x360
	Size: 0x1A
	Parameters: 1
	Flags: None
*/
function set_portrait(portraitid)
{
	self.var_54d07407 = portraitid;
}

/*
	Name: playing
	Namespace: voice
	Checksum: 0x26D2D9A6
	Offset: 0x388
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function playing()
{
	if(!isdefined(self.var_556f910a))
	{
		return 0;
	}
	return isdefined(self.var_47282775);
}

/*
	Name: pending
	Namespace: voice
	Checksum: 0x1EE43CD2
	Offset: 0x3B0
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function pending()
{
	if(!isdefined(self.var_556f910a))
	{
		return 0;
	}
	return self.var_556f910a.size > 0;
}

/*
	Name: stop
	Namespace: voice
	Checksum: 0x515C9A57
	Offset: 0x3D8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function stop()
{
	if(self playing())
	{
		self notify(#"hash_5335c8b16b1bd8aa");
	}
}

/*
	Name: stop_all
	Namespace: voice
	Checksum: 0x76CD5C54
	Offset: 0x410
	Size: 0x138
	Parameters: 1
	Flags: None
*/
function stop_all(team)
{
	stop = [];
	foreach(speaker in level.var_3e8bd5c)
	{
		if(isdefined(team) && team != #"any" && team != speaker.team)
		{
			continue;
		}
		stop[stop.size] = speaker;
	}
	foreach(speaker in stop)
	{
		speaker stop();
	}
}

/*
	Name: play
	Namespace: voice
	Checksum: 0xC6EB6C86
	Offset: 0x550
	Size: 0x308
	Parameters: 3
	Flags: None
*/
function play(scriptkey, var_17ee4803 = undefined, var_7f436309 = 0)
{
	if(!isdefined(self) || (issentient(self) && !isalive(self)))
	{
		return 0;
	}
	/#
		assert(isdefined(self.var_556f910a), "");
	#/
	if(isstring(scriptkey))
	{
		scriptkey = tolower(scriptkey);
	}
	alias = undefined;
	if(var_7f436309)
	{
		/#
			assert(isdefined(self.var_46b25f4f) && self.var_46b25f4f, "");
		#/
		var_344157f3 = self function_5f8e1b94(scriptkey);
		if(isdefined(self.var_6946d662))
		{
			var_ae215d05 = var_344157f3.size == 1 && var_344157f3[0] == self.var_6946d662;
			if(var_ae215d05)
			{
				alias = self.var_6946d662;
			}
			else
			{
				var_344157f3 = array::exclude(var_344157f3, self.var_6946d662);
				alias = array::random(var_344157f3);
			}
		}
		else
		{
			alias = array::random(var_344157f3);
		}
	}
	else
	{
		alias = self get_chr_alias(scriptkey);
	}
	voice = spawnstruct();
	voice.scriptkey = scriptkey;
	voice.params = function_73613736(scriptkey);
	voice.alias = alias;
	voice.var_17ee4803 = var_17ee4803;
	if(isdefined(self.var_46b25f4f) && self.var_46b25f4f && isdefined(alias))
	{
		self.var_6946d662 = alias;
	}
	if(!playing() && !pending())
	{
		self thread function_6df99cfa();
	}
	function_93932552(voice);
	return isdefined(alias);
}

/*
	Name: function_6df99cfa
	Namespace: voice
	Checksum: 0x3196F2F4
	Offset: 0x860
	Size: 0xCC
	Parameters: 0
	Flags: Linked, Private
*/
private function function_6df99cfa()
{
	self endon_callback(&function_9db28e7, #"death", #"entering_last_stand", #"disconnect", #"hash_5335c8b16b1bd8aa");
	level endon(#"game_ended");
	while(isdefined(self.var_78566c82) && self.var_78566c82)
	{
		waitframe(1);
	}
	waittillframeend();
	if(isdefined(self))
	{
		self thread play_next();
	}
}

/*
	Name: play_next
	Namespace: voice
	Checksum: 0x40526A4F
	Offset: 0x938
	Size: 0x51C
	Parameters: 0
	Flags: Linked, Private
*/
private function play_next()
{
	self endon_callback(&end_play_next, #"death", #"entering_last_stand", #"disconnect", #"hash_5335c8b16b1bd8aa");
	level endon(#"game_ended");
	voice = function_777704ce();
	if(!isdefined(voice))
	{
		self end_play_next();
		return;
	}
	self function_7924f3ca();
	self.var_47282775 = voice;
	if(isdefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"human_riotshield" || self.archetype == #"human_rpg" || self.archetype == #"civilian"))
	{
		self clientfield::set("facial_dial", 1);
	}
	if(isdefined(voice.alias) && getdvarint(#"hash_49f50ad33517adfd", 1) == 1)
	{
		soundent = self playsoundwithnotify(voice.alias, "voice_done", self.var_bd68a08e);
		self mask_sound(soundent, voice.params, voice.var_17ee4803);
		self waittill(#"voice_done");
		self notify(voice.scriptkey);
	}
	else if(isdefined(voice.alias))
	{
		self notify(#"voice_done");
		self notify(voice.scriptkey);
	}
	if(!isdefined(voice.alias) && getdvarint(#"hash_5a4f3b089c68658f", 0) == 1 || getdvarint(#"hash_71fefd466102ebff", 0) == 1)
	{
		tempname = self.var_3975c22;
		if(!isdefined(tempname) && isplayer(self))
		{
			tempname = self getchrname();
		}
		if(!isdefined(tempname))
		{
			tempname = "Unknown";
		}
		str_line = tempname + ": " + voice.scriptkey;
		n_wait_time = strtok(voice.scriptkey, " ").size - 1 / 2;
		n_wait_time = math::clamp(n_wait_time, 2, 5);
		if(isdefined(voice.var_17ee4803) && isentity(voice.var_17ee4803))
		{
			voice.var_17ee4803 thread function_9b502d8d(str_line, n_wait_time);
		}
		else
		{
			var_bdd612e1 = getplayers(self.team);
			foreach(e_player in var_bdd612e1)
			{
				if(isbot(e_player))
				{
					continue;
				}
				e_player thread function_9b502d8d(str_line, n_wait_time);
			}
		}
		self notify(#"voice_done");
		self notify(voice.scriptkey);
	}
	self end_play_next();
}

/*
	Name: function_9b502d8d
	Namespace: voice
	Checksum: 0xD9439F03
	Offset: 0xE60
	Size: 0xF4
	Parameters: 2
	Flags: Linked, Private
*/
private function function_9b502d8d(str_line, n_wait_time)
{
	self endon(#"disconnect");
	self notify(#"hash_3a2cea55af16657f");
	self endon(#"hash_3a2cea55af16657f");
	if(!isdefined(self getluimenu("TempDialog")))
	{
		self openluimenu("TempDialog");
	}
	self waittill_timeout(n_wait_time, #"death");
	if(isdefined(self getluimenu("TempDialog")))
	{
		self closeluimenu(self getluimenu("TempDialog"));
	}
}

/*
	Name: function_9db28e7
	Namespace: voice
	Checksum: 0x69BA2172
	Offset: 0xF60
	Size: 0x5C
	Parameters: 1
	Flags: Linked, Private
*/
private function function_9db28e7(notifyhash)
{
	if(isdefined(notifyhash))
	{
		self function_7924f3ca();
		self notify(#"voice_done");
	}
	arrayremovevalue(level.var_3e8bd5c, self);
}

/*
	Name: end_play_next
	Namespace: voice
	Checksum: 0xE0BC2E99
	Offset: 0xFC8
	Size: 0x1AE
	Parameters: 1
	Flags: Linked, Private
*/
private function end_play_next(notifyhash)
{
	self function_9db28e7();
	if(isdefined(notifyhash))
	{
		self thread stop_playing();
		self notify(#"voice_done");
		if(isdefined(self.var_47282775) && isstring(self.var_47282775.scriptkey))
		{
			self notify(self.var_47282775.scriptkey);
		}
	}
	self.var_47282775 = undefined;
	if(isactor(self) && (isdefined(self.archetype) && (self.archetype == #"human" || self.archetype == #"human_riotshield" || self.archetype == #"human_rpg" || self.archetype == #"civilian")))
	{
		self clientfield::set("facial_dial", 0);
	}
	if(isdefined(self.var_556f910a) && self.var_556f910a.size > 0)
	{
		play_next();
	}
	else
	{
		self notify(#"hash_296a16c4cf068a53");
	}
}

/*
	Name: stop_playing
	Namespace: voice
	Checksum: 0x4584D1A6
	Offset: 0x1180
	Size: 0x66
	Parameters: 0
	Flags: Linked, Private
*/
private function stop_playing()
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	self.var_78566c82 = 1;
	self stopsounds();
	waitframe(1);
	if(isdefined(self))
	{
		self.var_78566c82 = 0;
	}
}

/*
	Name: clear_queue
	Namespace: voice
	Checksum: 0x337850E2
	Offset: 0x11F0
	Size: 0x26
	Parameters: 0
	Flags: Private
*/
private function clear_queue()
{
	array::delete_all(self.var_556f910a);
	self.var_556f910a = [];
}

/*
	Name: function_7924f3ca
	Namespace: voice
	Checksum: 0x84240F84
	Offset: 0x1220
	Size: 0xFA
	Parameters: 0
	Flags: Linked, Private
*/
private function function_7924f3ca()
{
	self endon(#"death", #"disconnect");
	if(isdefined(self.var_556f910a))
	{
		while(i < self.var_556f910a.size)
		{
			if(isdefined(self.var_556f910a[i]) && isdefined(self.var_556f910a[i].scriptkey))
			{
				var_cad1783b = (isdefined(self.var_556f910a[i].params) ? self.var_556f910a[i].params.queue : 0);
				if(!var_cad1783b)
				{
					arrayremoveindex(self.var_556f910a, i);
				}
				else
				{
					i++;
				}
			}
		}
	}
}

/*
	Name: mask_sound
	Namespace: voice
	Checksum: 0xF48AB7C0
	Offset: 0x1328
	Size: 0x2EC
	Parameters: 3
	Flags: Linked, Private
*/
private function mask_sound(soundent, params, var_17ee4803)
{
	mask = (isdefined(params) ? params.mask : #"all");
	if(mask == #"all")
	{
		if(isdefined(self.var_54d07407))
		{
			foreach(player in getplayers())
			{
				self show_portrait_to(player);
			}
		}
		return;
	}
	soundent hide();
	if(mask == #"friendly")
	{
		foreach(player in getplayers())
		{
			if(player.team == self.team)
			{
				self play_to(soundent, player);
			}
		}
	}
	else if(mask == #"enemy")
	{
		foreach(player in getplayers())
		{
			if(player.team != self.team)
			{
				self play_to(soundent, player);
			}
		}
	}
	else if(mask == #"self")
	{
		if(isplayer(self))
		{
			self play_to(soundent, player);
		}
	}
	if(isdefined(var_17ee4803) && isplayer(var_17ee4803))
	{
		self play_to(soundent, var_17ee4803);
	}
}

/*
	Name: play_to
	Namespace: voice
	Checksum: 0x55B48499
	Offset: 0x1620
	Size: 0x54
	Parameters: 2
	Flags: Linked, Private
*/
private function play_to(soundent, player)
{
	if(isdefined(soundent))
	{
		soundent showtoplayer(player);
	}
	if(isdefined(self.var_54d07407))
	{
		self show_portrait_to(player);
	}
}

/*
	Name: show_portrait_to
	Namespace: voice
	Checksum: 0xF93F724F
	Offset: 0x1680
	Size: 0x54
	Parameters: 1
	Flags: Linked, Private
*/
private function show_portrait_to(player)
{
	player luinotifyevent(#"offsite_comms_message", 1, self.var_54d07407);
	player thread close_portrait(self);
}

/*
	Name: close_portrait
	Namespace: voice
	Checksum: 0xAF459E7F
	Offset: 0x16E0
	Size: 0xAC
	Parameters: 1
	Flags: Linked, Private
*/
private function close_portrait(speaker)
{
	self endon(#"disconnect");
	level endon(#"game_ended");
	speaker waittill(#"death", #"entering_last_stand", #"disconnect", #"hash_5335c8b16b1bd8aa", #"voice_done");
	self luinotifyevent(#"offsite_comms_complete");
}

/*
	Name: play_notetrack
	Namespace: voice
	Checksum: 0x730D258C
	Offset: 0x1798
	Size: 0x3B8
	Parameters: 1
	Flags: None
*/
function play_notetrack(scriptid)
{
	alias = function_7897846a(scriptid);
	if(!isdefined(alias))
	{
		return;
	}
	if(isdefined(self gettagorigin("J_Head")))
	{
		soundent = self playsoundwithnotify(alias, "voice_done", "J_Head");
	}
	else
	{
		soundent = self playsoundwithnotify(alias, "voice_done");
	}
	if(!self flagsys::get(#"scene"))
	{
		return;
	}
	if(isdefined(self._scene_object) && isdefined(self._scene_object._o_scene) && isdefined(self._scene_object._o_scene._str_team))
	{
		str_team = self._scene_object._o_scene._str_team;
	}
	else
	{
		str_team = self._scene_object._str_team;
	}
	if(isdefined(str_team) && str_team != #"any")
	{
		soundent hide();
		foreach(player in getplayers())
		{
			if(isdefined(player._scene_object) && isdefined(player._scene_object._o_scene) && isdefined(self._scene_object._o_scene) && player._scene_object._o_scene == self._scene_object._o_scene)
			{
				self play_to(soundent, player);
				continue;
			}
			if(!isdefined(player._scene_object) && isdefined(player.var_e3d6d713) && isdefined(self._scene_object._o_scene) && player.var_e3d6d713 == self._scene_object._o_scene._str_name)
			{
				self play_to(soundent, player);
				continue;
			}
			if(self flagsys::get(#"hash_e2ce599b208682a") && self util::is_on_side(player.team) || (self flagsys::get(#"hash_f21f320f68c0457") && !self util::is_on_side(player.team)))
			{
				self play_to(soundent, player);
			}
		}
	}
}

/*
	Name: function_29b858dc
	Namespace: voice
	Checksum: 0x50505A7A
	Offset: 0x1B58
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function function_29b858dc()
{
	chrname = self.var_3975c22;
	if(!isdefined(chrname) && isplayer(self))
	{
		chrname = self getchrname();
	}
	return chrname;
}

/*
	Name: get_chr_alias
	Namespace: voice
	Checksum: 0x7BAA5213
	Offset: 0x1BB8
	Size: 0x82
	Parameters: 1
	Flags: Linked
*/
function get_chr_alias(scriptkey)
{
	chrname = self function_29b858dc();
	if(!isdefined(chrname))
	{
		return undefined;
	}
	aliases = function_b7854c63(chrname, scriptkey);
	if(aliases.size == 0)
	{
		return undefined;
	}
	return array::random(aliases);
}

/*
	Name: function_5f8e1b94
	Namespace: voice
	Checksum: 0x560D350B
	Offset: 0x1C48
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_5f8e1b94(scriptkey)
{
	chrname = self function_29b858dc();
	if(!isdefined(chrname))
	{
		return undefined;
	}
	return function_b7854c63(chrname, scriptkey);
}

/*
	Name: function_e2a07e55
	Namespace: voice
	Checksum: 0xD4991F8F
	Offset: 0x1CA8
	Size: 0x50
	Parameters: 0
	Flags: None
*/
function function_e2a07e55()
{
	return isdefined(level.handlers) && isdefined(level.handlers[#"allies"]) && isdefined(level.handlers[#"axis"]);
}

/*
	Name: function_42a109b9
	Namespace: voice
	Checksum: 0x3A6FB080
	Offset: 0x1D00
	Size: 0x50
	Parameters: 0
	Flags: None
*/
function function_42a109b9()
{
	return isdefined(level.commanders) && isdefined(level.commanders[#"allies"]) && isdefined(level.commanders[#"axis"]);
}

/*
	Name: function_a36ee9b7
	Namespace: voice
	Checksum: 0xFAC5D9AF
	Offset: 0x1D58
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function function_a36ee9b7()
{
	if(isdefined(self.var_556f910a) && self.var_556f910a.size > 0)
	{
		return self.var_556f910a[0];
	}
	return undefined;
}

/*
	Name: function_17945809
	Namespace: voice
	Checksum: 0xA6F3C50B
	Offset: 0x1D90
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function function_17945809()
{
	if(isdefined(self.var_556f910a) && self.var_556f910a.size > 0)
	{
		return self.var_556f910a[self.var_556f910a.size - 1];
	}
	return undefined;
}

/*
	Name: function_93932552
	Namespace: voice
	Checksum: 0x2F33068D
	Offset: 0x1DD8
	Size: 0x252
	Parameters: 1
	Flags: Linked
*/
function function_93932552(var_e8d98eb1)
{
	if(isdefined(self.var_556f910a))
	{
		interrupt = (isdefined(var_e8d98eb1.params) ? var_e8d98eb1.params.interrupt : 0);
		priority = function_8e0c80fb(var_e8d98eb1);
		if(isdefined(interrupt) && interrupt && isdefined(self.var_47282775))
		{
			if(priority > function_8e0c80fb(self.var_47282775))
			{
				self stop();
				arrayinsert(self.var_556f910a, var_e8d98eb1, 0);
				return;
			}
		}
		if(self.var_556f910a.size == 0)
		{
			arrayinsert(self.var_556f910a, var_e8d98eb1, 0);
			return;
		}
		if(priority > function_8e0c80fb(function_a36ee9b7()))
		{
			arrayinsert(self.var_556f910a, var_e8d98eb1, 0);
			return;
		}
		if(priority <= function_8e0c80fb(function_17945809()))
		{
			arrayinsert(self.var_556f910a, var_e8d98eb1, self.var_556f910a.size);
			return;
		}
		for(i = 0; i < self.var_556f910a.size; i++)
		{
			if(priority <= function_8e0c80fb(self.var_556f910a[i]) && priority > function_8e0c80fb(self.var_556f910a[i + 1]))
			{
				arrayinsert(self.var_556f910a, var_e8d98eb1, i + 1);
				break;
			}
		}
	}
}

/*
	Name: function_777704ce
	Namespace: voice
	Checksum: 0x1AF46C1A
	Offset: 0x2038
	Size: 0x68
	Parameters: 0
	Flags: Linked
*/
function function_777704ce()
{
	voice = undefined;
	if(isdefined(self.var_556f910a) && self.var_556f910a.size > 0)
	{
		voice = function_a36ee9b7();
		arrayremoveindex(self.var_556f910a, 0);
	}
	return voice;
}

/*
	Name: function_8e0c80fb
	Namespace: voice
	Checksum: 0x30C67C61
	Offset: 0x20A8
	Size: 0x52
	Parameters: 1
	Flags: Linked
*/
function function_8e0c80fb(var_e8d98eb1)
{
	if(!isdefined(var_e8d98eb1.params) || !isdefined(var_e8d98eb1.params.priority))
	{
		return 0;
	}
	return var_e8d98eb1.params.priority;
}

