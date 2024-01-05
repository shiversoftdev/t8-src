// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_loadout.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\array_shared.gsc;

#namespace music_box;

/*
	Name: __init__system__
	Namespace: music_box
	Checksum: 0xBA50A0D2
	Offset: 0x188
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"music_box", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: music_box
	Checksum: 0xC772539C
	Offset: 0x1D0
	Size: 0x1CE
	Parameters: 0
	Flags: None
*/
function __init__()
{
	level.w_music_box = getweapon(#"music_box");
	clientfield::register("scriptmover", "" + #"hash_136e9d44e7e2e888", 24000, 1, "int");
	clientfield::register("scriptmover", "" + #"hash_77a1a7cd8eb3e86c", 1, 1, "int");
	clientfield::register("actor", "" + #"hash_4881cb6bc59fdc49", 24000, 1, "int");
	callback::on_grenade_fired(&on_grenade_fired);
	zm_loadout::register_lethal_grenade_for_level(#"music_box");
	if(!isdefined(level.var_14160fb0))
	{
		level.var_14160fb0 = new throttle();
		[[ level.var_14160fb0 ]]->initialize(4, 0.05);
	}
	level flag::init(#"hash_621d31a87bd6d05b");
	level thread callback::on_ai_killed(&function_da6a44df);
	level.gravityspikes_target_filter_callback = &function_cdb0d1e;
}

/*
	Name: on_grenade_fired
	Namespace: music_box
	Checksum: 0x4C17517A
	Offset: 0x3A8
	Size: 0x1CC
	Parameters: 1
	Flags: None
*/
function on_grenade_fired(s_params)
{
	if(s_params.weapon === level.w_music_box && isdefined(s_params.projectile))
	{
		s_params.projectile endon(#"death");
		level endon(#"end_game");
		e_grenade = s_params.projectile;
		e_grenade ghost();
		e_grenade.var_1a61db89 = util::spawn_model(e_grenade.model, e_grenade.origin, (0, self.angles[1] - 75, 0));
		e_grenade.var_1a61db89 linkto(e_grenade);
		e_grenade.var_1a61db89 clientfield::set("" + #"hash_136e9d44e7e2e888", 1);
		e_grenade.weapon = s_params.weapon;
		s_waitresult = undefined;
		s_waitresult = s_params.projectile waittill(#"stationary");
		if(e_grenade _second_compass_map_mp_ruins(self))
		{
			e_grenade thread function_9d9bff80(s_waitresult.position, self);
		}
		else
		{
			e_grenade thread function_9a83be2b();
		}
	}
}

/*
	Name: function_9d9bff80
	Namespace: music_box
	Checksum: 0x89B9129E
	Offset: 0x580
	Size: 0x91C
	Parameters: 2
	Flags: None
*/
function function_9d9bff80(var_2fe3186e, attacker)
{
	self endon(#"death");
	level endon(#"end_game");
	var_b7fc8c3e = var_2fe3186e + vectorscale((0, 0, 1), 64);
	self playsound("vox_musicbox_start_sama_" + randomint(3));
	wait(1);
	e_sam = util::spawn_model("p8_zm_music_box_samantha_trap", self.var_1a61db89.origin, (0, self.angles[1] + 180, 0));
	a_zombies = getaiteamarray(level.zombie_team);
	a_zombies = arraysortclosest(a_zombies, var_2fe3186e, 25, 0, 350);
	a_zombies = array::filter(a_zombies, 0, &function_3adb94b4);
	foreach(e_zombie in a_zombies)
	{
		if(isalive(e_zombie) && e_zombie.marked_for_death !== 1 && e_zombie.var_46d39f48 !== 1 && e_zombie.no_gib !== 1)
		{
			if(e_zombie.var_6f84b820 === #"popcorn")
			{
				[[ level.var_14160fb0 ]]->waitinqueue(e_zombie);
				e_zombie dodamage(e_zombie.maxhealth, e_zombie.origin, attacker, self, 0, "MOD_GRENADE", 0, self.weapon);
				continue;
			}
			e_zombie.var_42d5176d = 1;
			e_zombie.marked_for_death = 1;
			e_floater = util::spawn_model("tag_origin", e_zombie getcentroid(), e_zombie.angles);
			e_zombie linkto(e_floater);
			e_zombie.e_floater = e_floater;
			e_zombie thread util::delete_on_death(e_zombie.e_floater);
			e_floater moveto(e_floater.origin + (0, 0, randomfloatrange(16, 64)), 0.5);
			if(e_zombie.archetype === #"zombie")
			{
				e_floater thread function_3710157f(e_zombie);
			}
		}
	}
	e_sam thread scene::play(#"hash_67030b23e27f4303", "one_shot", e_sam);
	wait(0.5);
	self.var_1a61db89 hide();
	self.var_1a61db89 clientfield::set("" + #"hash_136e9d44e7e2e888", 0);
	wait(1);
	foreach(e_zombie in a_zombies)
	{
		if(isalive(e_zombie))
		{
			var_c0225146 = var_b7fc8c3e + ((vectornormalize(e_zombie getcentroid() - var_b7fc8c3e)) * 80);
			n_distance = distance(e_zombie getcentroid(), var_b7fc8c3e);
			e_zombie.e_floater moveto(var_c0225146, n_distance / 100);
			var_358047f1 = vectortoangles(e_zombie getcentroid() - var_b7fc8c3e);
			e_zombie.e_floater rotateto(var_358047f1, 1);
			continue;
		}
		if(isdefined(e_zombie) && isdefined(e_zombie.e_floater))
		{
			e_zombie function_4ada560e();
		}
	}
	wait(2);
	foreach(e_zombie in a_zombies)
	{
		if(isalive(e_zombie))
		{
			e_zombie function_4ada560e();
		}
	}
	waitframe(1);
	foreach(e_zombie in a_zombies)
	{
		if(isalive(e_zombie))
		{
			[[ level.var_14160fb0 ]]->waitinqueue(e_zombie);
			e_zombie startragdoll(1);
			var_23ef51ef = (vectornormalize(e_zombie getcentroid() - var_b7fc8c3e)) * randomfloatrange(150, 250);
			e_zombie launchragdoll(var_23ef51ef + vectorscale((0, 0, 1), 32));
			e_zombie dodamage(e_zombie.maxhealth, e_zombie.origin, attacker, self, 0, "MOD_GRENADE", 0, self.weapon);
			e_zombie clientfield::set("" + #"hash_4881cb6bc59fdc49", 1);
		}
	}
	self playrumbleonentity("talon_spike");
	dist = distance(level.var_f1907c72.origin, var_b7fc8c3e);
	if(isdefined(level.var_f1907c72) && dist <= 160)
	{
		level.var_f1907c72 notify(#"music_box");
	}
	e_sam playsound("vox_musicbox_end_sama_" + randomint(3));
	wait(1.5);
	e_sam thread scene::stop();
	e_sam delete();
	self.var_1a61db89 delete();
	level thread function_6b8c9160();
}

/*
	Name: function_6b8c9160
	Namespace: music_box
	Checksum: 0xCC4AAAE5
	Offset: 0xEA8
	Size: 0x84
	Parameters: 0
	Flags: None
*/
function function_6b8c9160()
{
	wait(4);
	if(!level flag::get(#"hash_621d31a87bd6d05b") && level.var_98138d6b >= 2)
	{
		level.var_1c53964e thread zm_hms_util::function_6a0d675d("vox_musicbox_first");
	}
	level flag::set(#"hash_621d31a87bd6d05b");
}

/*
	Name: function_3adb94b4
	Namespace: music_box
	Checksum: 0x19BE8FCC
	Offset: 0xF38
	Size: 0x90
	Parameters: 1
	Flags: None
*/
function function_3adb94b4(e_zombie)
{
	if(isdefined(e_zombie.var_42d5176d) && e_zombie.var_42d5176d || e_zombie.marked_for_death === 1 || e_zombie.var_46d39f48 === 1 || e_zombie.no_gib === 1)
	{
		return false;
	}
	if(isdefined(e_zombie.mdl_trap_mover))
	{
		return false;
	}
	return true;
}

/*
	Name: function_3710157f
	Namespace: music_box
	Checksum: 0x97DEFDF
	Offset: 0xFD0
	Size: 0xBE
	Parameters: 1
	Flags: Private
*/
function private function_3710157f(e_zombie)
{
	level endon(#"end_game");
	self endon(#"death");
	e_zombie endon(#"death");
	if(isdefined(e_zombie))
	{
		while(true)
		{
			if(!isdefined(e_zombie) || !isalive(e_zombie))
			{
				break;
			}
			self scene::play(#"hash_2f9776927eb5d181", "rise", e_zombie);
			waitframe(1);
		}
	}
}

/*
	Name: function_da6a44df
	Namespace: music_box
	Checksum: 0x48BD6D4A
	Offset: 0x1098
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_da6a44df(s_result)
{
	if(isdefined(self.var_42d5176d))
	{
		self scene::delete_scene_spawned_ents(#"hash_2f9776927eb5d181");
	}
}

/*
	Name: function_4ada560e
	Namespace: music_box
	Checksum: 0x832140C8
	Offset: 0x10E0
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_4ada560e()
{
	if(isdefined(self))
	{
		self unlink();
	}
	if(isdefined(self.e_floater))
	{
		self.e_floater thread scene::stop();
		self.e_floater delete();
	}
}

/*
	Name: _second_compass_map_mp_ruins
	Namespace: music_box
	Checksum: 0x81B7F9B2
	Offset: 0x1150
	Size: 0x12C
	Parameters: 1
	Flags: None
*/
function _second_compass_map_mp_ruins(e_owner)
{
	if(ispointonnavmesh(self.origin, 60))
	{
		return true;
	}
	v_dir = vectornormalize(e_owner.origin - self.origin);
	v_pos = self.origin + (v_dir * 32);
	v_valid_point = getclosestpointonnavmesh(self.origin, 150);
	if(isdefined(v_valid_point))
	{
		var_3fb36683 = zm_utility::check_point_in_enabled_zone(v_valid_point, undefined, undefined);
		if(var_3fb36683)
		{
			self.origin = v_valid_point;
			self.var_1a61db89 clientfield::set("" + #"hash_60a7e5b79e8064a5", 1);
			return true;
		}
	}
	return false;
}

/*
	Name: function_9a83be2b
	Namespace: music_box
	Checksum: 0x3F5D659
	Offset: 0x1288
	Size: 0x194
	Parameters: 0
	Flags: None
*/
function function_9a83be2b()
{
	players = getplayers();
	for(i = 0; i < players.size; i++)
	{
		if(isalive(players[i]))
		{
			players[i] playlocalsound(level.zmb_laugh_alias);
		}
	}
	playfxontag(level._effect[#"grenade_samantha_steal"], self.var_1a61db89, "tag_origin");
	self.var_1a61db89 unlink();
	self.var_1a61db89 movez(60, 1, 0.25, 0.25);
	self.var_1a61db89 vibrate((0, 0, 0), 1.5, 2.5, 1);
	self.var_1a61db89 waittill(#"movedone");
	self.var_1a61db89 delete();
	self delete();
}

/*
	Name: function_cdb0d1e
	Namespace: music_box
	Checksum: 0xE0CEFC1F
	Offset: 0x1428
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_cdb0d1e(e_zombie)
{
	if(e_zombie.var_42d5176d === 1)
	{
		return false;
	}
	return true;
}

