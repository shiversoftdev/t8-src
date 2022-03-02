// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\dialog_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\trigger_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace audio;

/*
	Name: function_89f2df9
	Namespace: audio
	Checksum: 0x1E5E14F4
	Offset: 0x540
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"audio", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: audio
	Checksum: 0x6734EC47
	Offset: 0x588
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	snd_snapshot_init();
	callback::on_localclient_connect(&player_init);
	callback::on_localplayer_spawned(&local_player_spawn);
	callback::on_localplayer_spawned(&sndsprintbreath);
	level thread register_clientfields();
	level thread sndkillcam();
	setsoundcontext("foley", "normal");
	setsoundcontext("plr_impact", "");
}

/*
	Name: register_clientfields
	Namespace: audio
	Checksum: 0xF665BE11
	Offset: 0x678
	Size: 0x43C
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("world", "sndMatchSnapshot", 1, 2, "int", &sndmatchsnapshot, 1, 0);
	clientfield::register("world", "sndFoleyContext", 1, 1, "int", &sndfoleycontext, 0, 0);
	clientfield::register("scriptmover", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
	clientfield::register("allplayers", "sndRattle", 1, 1, "counter", &sndrattle_server, 1, 0);
	clientfield::register("toplayer", "sndMelee", 1, 1, "int", &weapon_butt_sounds, 1, 1);
	clientfield::register("vehicle", "sndSwitchVehicleContext", 1, 3, "int", &sndswitchvehiclecontext, 0, 0);
	clientfield::register("toplayer", "sndCCHacking", 1, 2, "int", &sndcchacking, 1, 1);
	clientfield::register("toplayer", "sndTacRig", 1, 1, "int", &sndtacrig, 0, 1);
	clientfield::register("toplayer", "sndLevelStartSnapOff", 1, 1, "int", &sndlevelstartsnapoff, 0, 1);
	clientfield::register("world", "sndIGCsnapshot", 1, 4, "int", &sndigcsnapshot, 1, 0);
	clientfield::register("world", "sndChyronLoop", 1, 1, "int", &sndchyronloop, 0, 0);
	clientfield::register("world", "sndZMBFadeIn", 1, 1, "int", &sndzmbfadein, 1, 0);
	clientfield::register("toplayer", "sndVehicleDamageAlarm", 1, 1, "counter", &sndvehicledamagealarm, 0, 0);
	clientfield::register("toplayer", "sndCriticalHealth", 1, 1, "int", &sndcriticalhealth, 0, 1);
	clientfield::register("toplayer", "sndLastStand", 1, 1, "int", &sndlaststand, 0, 0);
}

/*
	Name: local_player_spawn
	Namespace: audio
	Checksum: 0xB7A80BDB
	Offset: 0xAC0
	Size: 0xD4
	Parameters: 1
	Flags: Linked
*/
function local_player_spawn(localclientnum)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	setsoundcontext("foley", "normal");
	if(!sessionmodeismultiplayergame() && !function_f99d2668())
	{
		self thread sndmusicdeathwatcher();
	}
	self thread isplayerinfected();
	self thread snd_underwater(localclientnum);
	self thread clientvoicesetup(localclientnum);
}

/*
	Name: player_init
	Namespace: audio
	Checksum: 0x225E1FF1
	Offset: 0xBA0
	Size: 0xB4
	Parameters: 1
	Flags: Linked
*/
function player_init(localclientnum)
{
	if(issplitscreenhost(localclientnum))
	{
		level thread bump_trigger_start(localclientnum);
		level thread init_audio_triggers(localclientnum);
		level thread sndrattle_grenade_client();
		startsoundrandoms(localclientnum);
		startsoundloops();
		startlineemitters();
		startrattles();
	}
}

/*
	Name: snddoublejump_watcher
	Namespace: audio
	Checksum: 0xEC43CC1A
	Offset: 0xC60
	Size: 0x108
	Parameters: 0
	Flags: None
*/
function snddoublejump_watcher()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"doublejump_start");
		trace = tracepoint(self.origin, self.origin - vectorscale((0, 0, 1), 100000));
		trace_surface_type = trace[#"surfacetype"];
		trace_origin = trace[#"position"];
		if(!isdefined(trace) || !isdefined(trace_origin))
		{
			continue;
		}
		if(!isdefined(trace_surface_type))
		{
			trace_surface_type = "default";
		}
		playsound(0, #"veh_jetpack_surface_" + trace_surface_type, trace_origin);
	}
}

/*
	Name: clientvoicesetup
	Namespace: audio
	Checksum: 0xBC668590
	Offset: 0xD70
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function clientvoicesetup(localclientnum)
{
	self endon(#"death");
	if(isdefined(level.clientvoicesetup))
	{
		[[level.clientvoicesetup]](localclientnum);
		return;
	}
	self.teamclientprefix = "vox_gen";
	self thread sndvonotify("playerbreathinsound", "sniper_hold");
	self thread sndvonotify("playerbreathoutsound", "sniper_exhale");
	self thread sndvonotify("playerbreathgaspsound", "sniper_gasp");
}

/*
	Name: sndvonotify
	Namespace: audio
	Checksum: 0x2E5B44BC
	Offset: 0xE48
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function sndvonotify(notifystring, dialog)
{
	self endon(#"death");
	for(;;)
	{
		self waittill(notifystring);
		soundalias = (self.teamclientprefix + "_") + dialog;
		self playsound(0, soundalias);
	}
}

/*
	Name: snd_snapshot_init
	Namespace: audio
	Checksum: 0x818B8FC1
	Offset: 0xEC0
	Size: 0x134
	Parameters: 0
	Flags: Linked
*/
function snd_snapshot_init()
{
	level._sndactivesnapshot = "default";
	level._sndnextsnapshot = "default";
	if(!util::function_3f165ee8())
	{
		if(sessionmodeiscampaigngame() && !function_22a92b8b() && !function_c9705ad4())
		{
			level._sndactivesnapshot = "cmn_level_start";
			level._sndnextsnapshot = "cmn_level_start";
			level thread sndlevelstartduck_shutoff();
		}
		if(sessionmodeiszombiesgame())
		{
			level._sndactivesnapshot = "zmb_game_start_nofade";
			level._sndnextsnapshot = "zmb_game_start_nofade";
		}
	}
	setgroupsnapshot(level._sndactivesnapshot);
	thread snd_snapshot_think();
}

/*
	Name: sndlevelstartduck_shutoff
	Namespace: audio
	Checksum: 0xADDEEEF0
	Offset: 0x1000
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function sndlevelstartduck_shutoff()
{
	level waittill(#"sndlevelstartduck_shutoff");
	snd_set_snapshot("default");
}

/*
	Name: function_22a92b8b
	Namespace: audio
	Checksum: 0xBB66A005
	Offset: 0x1040
	Size: 0xFE
	Parameters: 0
	Flags: Linked
*/
function function_22a92b8b()
{
	ignore = 1;
	mapname = util::function_53bbf9d2();
	switch(mapname)
	{
		case "hash_15642edd0e4376f1":
		case "hash_5562580f1b903614":
		case "hash_65a6e39408662d48":
		case "hash_68bac554964f4148":
		case "hash_7bdf016123a0147b":
		{
			ignore = 0;
			break;
		}
	}
	gametype = hash(util::function_5df4294());
	switch(gametype)
	{
		case "download":
		{
			ignore = 1;
			break;
		}
	}
	return ignore;
}

/*
	Name: function_c9705ad4
	Namespace: audio
	Checksum: 0xB7E6F84E
	Offset: 0x1148
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_c9705ad4()
{
	ignore = 1;
	gametype = hash(util::function_5df4294());
	switch(gametype)
	{
		case "coop":
		case "pvp":
		{
			ignore = 0;
			break;
		}
	}
	return ignore;
}

/*
	Name: snd_set_snapshot
	Namespace: audio
	Checksum: 0x94A6263A
	Offset: 0x11D8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function snd_set_snapshot(state)
{
	level._sndnextsnapshot = state;
	/#
		println(("" + state) + "");
	#/
	level notify(#"new_bus");
}

/*
	Name: snd_snapshot_think
	Namespace: audio
	Checksum: 0x9C584213
	Offset: 0x1238
	Size: 0xC6
	Parameters: 0
	Flags: Linked
*/
function snd_snapshot_think()
{
	for(;;)
	{
		if(level._sndactivesnapshot == level._sndnextsnapshot)
		{
			level waittill(#"new_bus");
		}
		if(level._sndactivesnapshot == level._sndnextsnapshot)
		{
			continue;
		}
		/#
			assert(isdefined(level._sndnextsnapshot));
		#/
		/#
			assert(isdefined(level._sndactivesnapshot));
		#/
		setgroupsnapshot(level._sndnextsnapshot);
		level._sndactivesnapshot = level._sndnextsnapshot;
	}
}

/*
	Name: soundrandom_thread
	Namespace: audio
	Checksum: 0xFFBE8518
	Offset: 0x1308
	Size: 0x210
	Parameters: 2
	Flags: Linked
*/
function soundrandom_thread(localclientnum, randsound)
{
	if(!isdefined(randsound.script_wait_min))
	{
		randsound.script_wait_min = 1;
	}
	if(!isdefined(randsound.script_wait_max))
	{
		randsound.script_wait_max = 3;
	}
	notify_name = undefined;
	if(isdefined(randsound.script_string))
	{
		notify_name = randsound.script_string;
	}
	if(!isdefined(notify_name) && isdefined(randsound.script_sound))
	{
		createsoundrandom(randsound.origin, randsound.script_sound, randsound.script_wait_min, randsound.script_wait_max);
		return;
	}
	randsound.playing = 1;
	level thread soundrandom_notifywait(notify_name, randsound);
	while(true)
	{
		wait(randomfloatrange(randsound.script_wait_min, randsound.script_wait_max));
		if(isdefined(randsound.script_sound) && (isdefined(randsound.playing) && randsound.playing))
		{
			playsound(localclientnum, randsound.script_sound, randsound.origin);
		}
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				print3d(randsound.origin, randsound.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 45);
			}
		#/
	}
}

/*
	Name: soundrandom_notifywait
	Namespace: audio
	Checksum: 0x9C6FC328
	Offset: 0x1520
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function soundrandom_notifywait(notify_name, randsound)
{
	while(true)
	{
		level waittill(notify_name);
		if(isdefined(randsound.playing) && randsound.playing)
		{
			randsound.playing = 0;
		}
		else
		{
			randsound.playing = 1;
		}
	}
}

/*
	Name: startsoundrandoms
	Namespace: audio
	Checksum: 0x88603052
	Offset: 0x15A0
	Size: 0x10E
	Parameters: 1
	Flags: Linked
*/
function startsoundrandoms(localclientnum)
{
	randoms = struct::get_array("random", "script_label");
	if(isdefined(randoms) && randoms.size > 0)
	{
		nscriptthreadedrandoms = 0;
		for(i = 0; i < randoms.size; i++)
		{
			if(isdefined(randoms[i].script_scripted))
			{
				nscriptthreadedrandoms++;
			}
		}
		allocatesoundrandoms(randoms.size - nscriptthreadedrandoms);
		for(i = 0; i < randoms.size; i++)
		{
			randoms[i].angles = undefined;
			thread soundrandom_thread(localclientnum, randoms[i]);
		}
	}
}

/*
	Name: soundloopthink
	Namespace: audio
	Checksum: 0xD2E51C0A
	Offset: 0x16B8
	Size: 0x16A
	Parameters: 0
	Flags: Linked
*/
function soundloopthink()
{
	if(!isdefined(self.script_sound))
	{
		return;
	}
	if(!isdefined(self.origin))
	{
		return;
	}
	notifyname = "";
	/#
		assert(isdefined(notifyname));
	#/
	if(isdefined(self.script_string))
	{
		notifyname = self.script_string;
	}
	/#
		assert(isdefined(notifyname));
	#/
	started = 1;
	if(isdefined(self.script_int))
	{
		started = self.script_int != 0;
	}
	if(started)
	{
		soundloopemitter(self.script_sound, self.origin);
	}
	if(notifyname != "")
	{
		for(;;)
		{
			level waittill(notifyname);
			if(started)
			{
				soundstoploopemitter(self.script_sound, self.origin);
				self thread soundloopcheckpointrestore();
			}
			else
			{
				soundloopemitter(self.script_sound, self.origin);
			}
			started = !started;
		}
	}
}

/*
	Name: soundloopcheckpointrestore
	Namespace: audio
	Checksum: 0xF4543EF6
	Offset: 0x1830
	Size: 0x3C
	Parameters: 0
	Flags: Linked
*/
function soundloopcheckpointrestore()
{
	level waittill(#"save_restore");
	soundloopemitter(self.script_sound, self.origin);
}

/*
	Name: soundlinethink
	Namespace: audio
	Checksum: 0x39A89963
	Offset: 0x1878
	Size: 0x17A
	Parameters: 0
	Flags: Linked
*/
function soundlinethink()
{
	if(!isdefined(self.target))
	{
		return;
	}
	target = struct::get(self.target, "targetname");
	if(!isdefined(target))
	{
		return;
	}
	notifyname = "";
	if(isdefined(self.script_string))
	{
		notifyname = self.script_string;
	}
	started = 1;
	if(isdefined(self.script_int))
	{
		started = self.script_int != 0;
	}
	if(started)
	{
		soundlineemitter(self.script_sound, self.origin, target.origin);
	}
	if(notifyname != "")
	{
		for(;;)
		{
			level waittill(notifyname);
			if(started)
			{
				soundstoplineemitter(self.script_sound, self.origin, target.origin);
				self thread soundlinecheckpointrestore(target);
			}
			else
			{
				soundlineemitter(self.script_sound, self.origin, target.origin);
			}
			started = !started;
		}
	}
}

/*
	Name: soundlinecheckpointrestore
	Namespace: audio
	Checksum: 0x3E24E2AE
	Offset: 0x1A00
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function soundlinecheckpointrestore(target)
{
	level waittill(#"save_restore");
	soundlineemitter(self.script_sound, self.origin, target.origin);
}

/*
	Name: startsoundloops
	Namespace: audio
	Checksum: 0xA1D84FB8
	Offset: 0x1A58
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function startsoundloops()
{
	loopers = struct::get_array("looper", "script_label");
	if(isdefined(loopers) && loopers.size > 0)
	{
		delay = 0;
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println(("" + loopers.size) + "");
			}
		#/
		for(i = 0; i < loopers.size; i++)
		{
			loopers[i].angles = undefined;
			loopers[i].script_label = undefined;
			loopers[i] thread soundloopthink();
			delay = delay + 1;
			if((delay % 20) == 0)
			{
				waitframe(1);
			}
		}
	}
	else
	{
		/#
			println("");
		#/
		if(getdvarint(#"debug_audio", 0) > 0)
		{
		}
	}
}

/*
	Name: startlineemitters
	Namespace: audio
	Checksum: 0x1276776F
	Offset: 0x1BE8
	Size: 0x184
	Parameters: 0
	Flags: Linked
*/
function startlineemitters()
{
	lineemitters = struct::get_array("line_emitter", "script_label");
	if(isdefined(lineemitters) && lineemitters.size > 0)
	{
		delay = 0;
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				println(("" + lineemitters.size) + "");
			}
		#/
		for(i = 0; i < lineemitters.size; i++)
		{
			lineemitters[i].angles = undefined;
			lineemitters[i].script_label = undefined;
			lineemitters[i] thread soundlinethink();
			delay = delay + 1;
			if((delay % 20) == 0)
			{
				waitframe(1);
			}
		}
	}
	else
	{
		/#
			println("");
		#/
		if(getdvarint(#"debug_audio", 0) > 0)
		{
		}
	}
}

/*
	Name: startrattles
	Namespace: audio
	Checksum: 0x28BD4A14
	Offset: 0x1D78
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function startrattles()
{
	rattles = struct::get_array("sound_rattle", "script_label");
	if(isdefined(rattles))
	{
		/#
			println(("" + rattles.size) + "");
		#/
		delay = 0;
		for(i = 0; i < rattles.size; i++)
		{
			soundrattlesetup(rattles[i].script_sound, rattles[i].origin);
			delay = delay + 1;
			if((delay % 20) == 0)
			{
				waitframe(1);
			}
		}
	}
	foreach(rattle in rattles)
	{
		arrayremovevalue(level.struct, rattle, 1);
	}
	arrayremovevalue(level.struct, undefined, 0);
}

/*
	Name: init_audio_triggers
	Namespace: audio
	Checksum: 0x626A4860
	Offset: 0x1F10
	Size: 0x14C
	Parameters: 1
	Flags: Linked
*/
function init_audio_triggers(localclientnum)
{
	util::waitforclient(localclientnum);
	steptrigs = getentarray(localclientnum, "audio_step_trigger", "targetname");
	materialtrigs = getentarray(localclientnum, "audio_material_trigger", "targetname");
	/#
		if(getdvarint(#"debug_audio", 0) > 0)
		{
			println(("" + steptrigs.size) + "");
			println(("" + materialtrigs.size) + "");
		}
	#/
	array::thread_all(steptrigs, &audio_step_trigger, localclientnum);
	array::thread_all(materialtrigs, &audio_material_trigger, localclientnum);
}

/*
	Name: function_a3010aae
	Namespace: audio
	Checksum: 0xF083F145
	Offset: 0x2068
	Size: 0x14C
	Parameters: 3
	Flags: Linked
*/
function function_a3010aae(ent, on_enter_payload, on_exit_payload)
{
	ent endon(#"death");
	if(!isdefined(self))
	{
		return;
	}
	var_f911c758 = self getentitynumber();
	wait_time = getdvarfloat(#"hash_497642044cfae073", 1);
	if(ent trigger::ent_already_in(var_f911c758))
	{
		return;
	}
	trigger::add_to_ent(ent, var_f911c758);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && isdefined(self) && ent istouching(self))
	{
		wait(wait_time);
	}
	if(isdefined(ent))
	{
		if(isdefined(on_exit_payload))
		{
			[[on_exit_payload]](ent);
		}
		trigger::remove_from_ent(ent, var_f911c758);
	}
}

/*
	Name: audio_step_trigger
	Namespace: audio
	Checksum: 0x8342884F
	Offset: 0x21C0
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function audio_step_trigger(localclientnum)
{
	var_887fc615 = self getentitynumber();
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		if(!waitresult.activator trigger::ent_already_in(var_887fc615))
		{
			self thread function_a3010aae(waitresult.activator, &trig_enter_audio_step_trigger, &trig_leave_audio_step_trigger);
		}
		waitframe(1);
	}
}

/*
	Name: audio_material_trigger
	Namespace: audio
	Checksum: 0xDA52EADE
	Offset: 0x2290
	Size: 0x78
	Parameters: 1
	Flags: Linked
*/
function audio_material_trigger(trig)
{
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		self thread function_a3010aae(waitresult.activator, &trig_enter_audio_material_trigger, &trig_leave_audio_material_trigger);
	}
}

/*
	Name: trig_enter_audio_material_trigger
	Namespace: audio
	Checksum: 0x12944E49
	Offset: 0x2310
	Size: 0x74
	Parameters: 1
	Flags: Linked
*/
function trig_enter_audio_material_trigger(player)
{
	if(!isdefined(player.inmaterialoverridetrigger))
	{
		player.inmaterialoverridetrigger = 0;
	}
	if(isdefined(self.script_label))
	{
		player.inmaterialoverridetrigger++;
		player.audiomaterialoverride = self.script_label;
		player setmaterialoverride(self.script_label);
	}
}

/*
	Name: trig_leave_audio_material_trigger
	Namespace: audio
	Checksum: 0x41A7E50
	Offset: 0x2390
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function trig_leave_audio_material_trigger(player)
{
	if(isdefined(self.script_label))
	{
		player.inmaterialoverridetrigger--;
		/#
			/#
				assert(player.inmaterialoverridetrigger >= 0);
			#/
		#/
		if(player.inmaterialoverridetrigger <= 0)
		{
			player.audiomaterialoverride = undefined;
			player.inmaterialoverridetrigger = 0;
			player clearmaterialoverride();
		}
	}
}

/*
	Name: trig_enter_audio_step_trigger
	Namespace: audio
	Checksum: 0x41B88527
	Offset: 0x2428
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function trig_enter_audio_step_trigger(trigplayer)
{
	localclientnum = self._localclientnum;
	if(!isdefined(trigplayer.insteptrigger))
	{
		trigplayer.insteptrigger = 0;
	}
	suffix = "_npc";
	if(trigplayer function_21c0fa55())
	{
		suffix = "_plr";
	}
	if(isdefined(self.script_step_alias))
	{
		trigplayer.step_sound = self.script_step_alias;
		trigplayer.insteptrigger = trigplayer.insteptrigger + 1;
		trigplayer setsteptriggersound(self.script_step_alias + suffix);
	}
	if(isdefined(self.script_step_alias_enter) && trigplayer getmovementtype() == "sprint")
	{
		volume = get_vol_from_speed(trigplayer);
		trigplayer playsound(localclientnum, self.script_step_alias_enter + suffix, self.origin, volume);
	}
}

/*
	Name: trig_leave_audio_step_trigger
	Namespace: audio
	Checksum: 0x178E957F
	Offset: 0x2588
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function trig_leave_audio_step_trigger(trigplayer)
{
	localclientnum = self._localclientnum;
	suffix = "_npc";
	if(trigplayer function_21c0fa55())
	{
		suffix = "_plr";
	}
	if(isdefined(self.script_step_alias_exit) && trigplayer getmovementtype() == "sprint")
	{
		volume = get_vol_from_speed(trigplayer);
		trigplayer playsound(localclientnum, self.script_step_alias_exit + suffix, self.origin, volume);
	}
	if(isdefined(self.script_step_alias))
	{
		trigplayer.insteptrigger = trigplayer.insteptrigger - 1;
	}
	if(trigplayer.insteptrigger < 0)
	{
		/#
			println("");
		#/
		trigplayer.insteptrigger = 0;
	}
	if(trigplayer.insteptrigger == 0)
	{
		trigplayer.step_sound = "none";
		trigplayer clearsteptriggersound();
	}
}

/*
	Name: bump_trigger_start
	Namespace: audio
	Checksum: 0x6B837264
	Offset: 0x2708
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function bump_trigger_start(localclientnum)
{
	bump_trigs = getentarray(localclientnum, "audio_bump_trigger", "targetname");
	for(i = 0; i < bump_trigs.size; i++)
	{
		bump_trigs[i] thread thread_bump_trigger(localclientnum);
	}
}

/*
	Name: thread_bump_trigger
	Namespace: audio
	Checksum: 0x671D0A72
	Offset: 0x2798
	Size: 0xB0
	Parameters: 1
	Flags: Linked
*/
function thread_bump_trigger(localclientnum)
{
	self thread bump_trigger_listener();
	if(!isdefined(self.script_activated))
	{
		self.script_activated = 1;
	}
	self._localclientnum = localclientnum;
	for(;;)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		self thread trigger::function_521edc64(waitresult.activator, &trig_enter_bump, &trig_leave_bump);
	}
}

/*
	Name: trig_enter_bump
	Namespace: audio
	Checksum: 0xE6FC63A6
	Offset: 0x2850
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function trig_enter_bump(ent)
{
	if(!isdefined(ent))
	{
		return;
	}
	if(!isdefined(self.script_bump_volume_threshold))
	{
		self.script_bump_volume_threshold = 0.75;
	}
	localclientnum = self._localclientnum;
	volume = get_vol_from_speed(ent);
	if(!sessionmodeiszombiesgame())
	{
		if(isplayer(ent) && ent hasperk(localclientnum, "specialty_quieter"))
		{
			volume = volume / 2;
		}
	}
	if(isdefined(self.script_bump_alias) && self.script_activated)
	{
		self playsound(localclientnum, self.script_bump_alias, self.origin, volume);
	}
	if(isdefined(self.script_bump_alias_soft) && self.script_bump_volume_threshold > volume && self.script_activated)
	{
		self playsound(localclientnum, self.script_bump_alias_soft, self.origin, volume);
	}
	if(isdefined(self.script_bump_alias_hard) && self.script_bump_volume_threshold <= volume && self.script_activated)
	{
		self playsound(localclientnum, self.script_bump_alias_hard, self.origin, volume);
	}
	if(isdefined(self.script_mantle_alias) && self.script_activated)
	{
		ent thread mantle_wait(self.script_mantle_alias, localclientnum);
	}
}

/*
	Name: mantle_wait
	Namespace: audio
	Checksum: 0xF1F37169
	Offset: 0x2A50
	Size: 0x74
	Parameters: 2
	Flags: Linked
*/
function mantle_wait(alias, localclientnum)
{
	self endon(#"death");
	self endon(#"left_mantle");
	self waittill(#"traversesound");
	self playsound(localclientnum, alias, self.origin, 1);
}

/*
	Name: trig_leave_bump
	Namespace: audio
	Checksum: 0x2F435F25
	Offset: 0x2AD0
	Size: 0x28
	Parameters: 1
	Flags: Linked
*/
function trig_leave_bump(ent)
{
	wait(1);
	ent notify(#"left_mantle");
}

/*
	Name: bump_trigger_listener
	Namespace: audio
	Checksum: 0x63AD388
	Offset: 0x2B00
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function bump_trigger_listener()
{
	if(isdefined(self.script_label))
	{
		level waittill(self.script_label);
		self.script_activated = 0;
	}
}

/*
	Name: scale_speed
	Namespace: audio
	Checksum: 0xFDCAB30D
	Offset: 0x2B38
	Size: 0xBC
	Parameters: 5
	Flags: Linked
*/
function scale_speed(x1, x2, y1, y2, z)
{
	if(z < x1)
	{
		z = x1;
	}
	if(z > x2)
	{
		z = x2;
	}
	dx = x2 - x1;
	n = (z - x1) / dx;
	dy = y2 - y1;
	w = (n * dy) + y1;
	return w;
}

/*
	Name: get_vol_from_speed
	Namespace: audio
	Checksum: 0x5C70D2E6
	Offset: 0x2C00
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function get_vol_from_speed(player)
{
	min_speed = 20;
	max_speed = 200;
	max_vol = 1;
	min_vol = 0.1;
	speed = player getspeed();
	abs_speed = absolute_value(int(speed));
	volume = scale_speed(min_speed, max_speed, min_vol, max_vol, abs_speed);
	return volume;
}

/*
	Name: absolute_value
	Namespace: audio
	Checksum: 0xA8B2735F
	Offset: 0x2CE0
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function absolute_value(fowd)
{
	if(fowd < 0)
	{
		return fowd * -1;
	}
	return fowd;
}

/*
	Name: closest_point_on_line_to_point
	Namespace: audio
	Checksum: 0x2EA87427
	Offset: 0x2D18
	Size: 0x1DA
	Parameters: 3
	Flags: Linked
*/
function closest_point_on_line_to_point(point, linestart, lineend)
{
	self endon(#"hash_66fcfbe39e07bd83");
	linemagsqrd = lengthsquared(lineend - linestart);
	t = (point[0] - linestart[0]) * (lineend[0] - linestart[0]) + (point[1] - linestart[1]) * (lineend[1] - linestart[1]) + (point[2] - linestart[2]) * (lineend[2] - linestart[2]) / linemagsqrd;
	if(t < 0)
	{
		self.origin = linestart;
	}
	else
	{
		if(t > 1)
		{
			self.origin = lineend;
		}
		else
		{
			start_x = linestart[0] + (t * (lineend[0] - linestart[0]));
			start_y = linestart[1] + (t * (lineend[1] - linestart[1]));
			start_z = linestart[2] + (t * (lineend[2] - linestart[2]));
			self.origin = (start_x, start_y, start_z);
		}
	}
}

/*
	Name: snd_play_auto_fx
	Namespace: audio
	Checksum: 0x1A246713
	Offset: 0x2F00
	Size: 0x84
	Parameters: 9
	Flags: None
*/
function snd_play_auto_fx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override)
{
	soundplayautofx(fxid, alias, offsetx, offsety, offsetz, onground, area, threshold, alias_override);
}

/*
	Name: snd_print_fx_id
	Namespace: audio
	Checksum: 0xCE3AD03C
	Offset: 0x2F90
	Size: 0x74
	Parameters: 3
	Flags: None
*/
function snd_print_fx_id(fxid, type, ent)
{
	/#
		if(getdvarint(#"debug_audio", 0) > 0)
		{
			println((("" + fxid) + "") + type);
		}
	#/
}

/*
	Name: debug_line_emitter
	Namespace: audio
	Checksum: 0x4CB73F09
	Offset: 0x3010
	Size: 0x10E
	Parameters: 0
	Flags: None
*/
function debug_line_emitter()
{
	while(true)
	{
		/#
			if(getdvarint(#"debug_audio", 0) > 0)
			{
				line(self.start, self.end, (0, 1, 0));
				print3d(self.start, "", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
				print3d(self.end, "", vectorscale((0, 1, 0), 0.8), 1, 3, 1);
				print3d(self.origin, self.script_sound, vectorscale((0, 1, 0), 0.8), 1, 3, 1);
			}
			waitframe(1);
		#/
	}
}

/*
	Name: move_sound_along_line
	Namespace: audio
	Checksum: 0x54CE4F92
	Offset: 0x3128
	Size: 0x100
	Parameters: 0
	Flags: None
*/
function move_sound_along_line()
{
	closest_dist = undefined;
	/#
		self thread debug_line_emitter();
	#/
	while(true)
	{
		self closest_point_on_line_to_point(getlocalclientpos(0), self.start, self.end);
		if(isdefined(self.fake_ent))
		{
			self.fake_ent.origin = self.origin;
		}
		closest_dist = distancesquared(getlocalclientpos(0), self.origin);
		if(closest_dist > 1048576)
		{
			wait(2);
		}
		else
		{
			if(closest_dist > 262144)
			{
				wait(0.2);
			}
			else
			{
				wait(0.05);
			}
		}
	}
}

/*
	Name: playloopat
	Namespace: audio
	Checksum: 0xA94D44E4
	Offset: 0x3230
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function playloopat(aliasname, origin)
{
	soundloopemitter(aliasname, origin);
}

/*
	Name: stoploopat
	Namespace: audio
	Checksum: 0xD901650E
	Offset: 0x3268
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function stoploopat(aliasname, origin)
{
	soundstoploopemitter(aliasname, origin);
}

/*
	Name: soundwait
	Namespace: audio
	Checksum: 0x72F5F7AA
	Offset: 0x32A0
	Size: 0x34
	Parameters: 1
	Flags: None
*/
function soundwait(id)
{
	while(soundplaying(id))
	{
		wait(0.1);
	}
}

/*
	Name: snd_underwater
	Namespace: audio
	Checksum: 0x7CADAB7
	Offset: 0x32E0
	Size: 0x378
	Parameters: 1
	Flags: Linked
*/
function snd_underwater(localclientnum)
{
	level endon(#"demo_jump");
	self endon(#"death");
	level endon("killcam_begin" + localclientnum);
	level endon("killcam_end" + localclientnum);
	self endon(#"sndenduwwatcher");
	if(!isdefined(level.audiosharedswimming))
	{
		level.audiosharedswimming = 0;
	}
	if(!isdefined(level.audiosharedunderwater))
	{
		level.audiosharedunderwater = 0;
	}
	setsoundcontext("water_global", "over");
	if(level.audiosharedswimming != isswimming(localclientnum))
	{
		level.audiosharedswimming = isswimming(localclientnum);
		if(level.audiosharedswimming)
		{
			swimbegin();
		}
		else
		{
			swimcancel(localclientnum);
		}
	}
	if(level.audiosharedunderwater != isunderwater(localclientnum))
	{
		level.audiosharedunderwater = isunderwater(localclientnum);
		if(level.audiosharedunderwater)
		{
			self underwaterbegin();
		}
		else
		{
			self underwaterend();
		}
	}
	while(true)
	{
		underwaternotify = undefined;
		underwaternotify = self waittill(#"underwater_begin", #"underwater_end", #"swimming_begin", #"swimming_end", #"death", #"sndenduwwatcher");
		if(underwaternotify._notify == "death")
		{
			self underwaterend();
			self swimend(localclientnum);
		}
		if(underwaternotify._notify == "underwater_begin")
		{
			self underwaterbegin();
		}
		else
		{
			if(underwaternotify._notify == "underwater_end")
			{
				self underwaterend();
			}
			else
			{
				if(underwaternotify._notify == "swimming_begin")
				{
					self swimbegin();
				}
				else if(underwaternotify._notify == "swimming_end" && isplayer(self) && isalive(self))
				{
					self swimend(localclientnum);
				}
			}
		}
	}
}

/*
	Name: underwaterbegin
	Namespace: audio
	Checksum: 0xB701483E
	Offset: 0x3660
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function underwaterbegin()
{
	level.audiosharedunderwater = 1;
	setsoundcontext("water_global", "under");
}

/*
	Name: underwaterend
	Namespace: audio
	Checksum: 0xC7CC574E
	Offset: 0x36A0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function underwaterend()
{
	level.audiosharedunderwater = 0;
	setsoundcontext("water_global", "over");
}

/*
	Name: swimbegin
	Namespace: audio
	Checksum: 0xB1B19535
	Offset: 0x36E0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function swimbegin()
{
	self.audiosharedswimming = 1;
}

/*
	Name: swimend
	Namespace: audio
	Checksum: 0x979B77FF
	Offset: 0x3700
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function swimend(localclientnum)
{
	self.audiosharedswimming = 0;
}

/*
	Name: swimcancel
	Namespace: audio
	Checksum: 0xDAF71915
	Offset: 0x3720
	Size: 0x16
	Parameters: 1
	Flags: Linked
*/
function swimcancel(localclientnum)
{
	self.audiosharedswimming = 0;
}

/*
	Name: soundplayuidecodeloop
	Namespace: audio
	Checksum: 0x5C46F64B
	Offset: 0x3740
	Size: 0xD6
	Parameters: 2
	Flags: Linked
*/
function soundplayuidecodeloop(decodestring, playtimems)
{
	if(!isdefined(level.playinguidecodeloop) || !level.playinguidecodeloop)
	{
		level.playinguidecodeloop = 1;
		fake_ent = spawn(0, (0, 0, 0), "script_origin");
		if(isdefined(fake_ent))
		{
			fake_ent playloopsound(#"uin_notify_data_loop");
			wait(float(playtimems) / 1000);
			fake_ent stopallloopsounds(0);
		}
		level.playinguidecodeloop = undefined;
	}
}

/*
	Name: setcurrentambientstate
	Namespace: audio
	Checksum: 0x4D346761
	Offset: 0x3820
	Size: 0x2C
	Parameters: 5
	Flags: Linked
*/
function setcurrentambientstate(ambientroom, ambientpackage, roomcollidercent, packagecollidercent, defaultroom)
{
}

/*
	Name: isplayerinfected
	Namespace: audio
	Checksum: 0x9E4D87E0
	Offset: 0x3858
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function isplayerinfected()
{
	self endon(#"death");
	self.isinfected = 0;
	setsoundcontext("healthstate", "human");
}

/*
	Name: sndcriticalhealth
	Namespace: audio
	Checksum: 0xA9177623
	Offset: 0x38A8
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function sndcriticalhealth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::function_89a98f85();
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(!isdefined(self))
	{
		return;
	}
	if(!self function_21c0fa55())
	{
		return;
	}
	if(!isdefined(self.var_2f6077ac))
	{
		self.var_2f6077ac = self.origin;
	}
	if(newval)
	{
		playsound(localclientnum, #"chr_health_lowhealth_enter", (0, 0, 0));
		playloopat("chr_health_lowhealth_loop", self.var_2f6077ac);
	}
	else
	{
		stoploopat("chr_health_lowhealth_loop", self.var_2f6077ac);
		self.var_2f6077ac = undefined;
	}
}

/*
	Name: sndlaststand
	Namespace: audio
	Checksum: 0x77F675BC
	Offset: 0x39D0
	Size: 0x11E
	Parameters: 7
	Flags: Linked
*/
function sndlaststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	util::function_89a98f85();
	if(function_65b9eb0f(localclientnum))
	{
		return;
	}
	if(!isdefined(self))
	{
		return;
	}
	if(!self function_21c0fa55())
	{
		return;
	}
	if(!isdefined(self.sndlaststand))
	{
		self.sndlaststand = self.origin;
	}
	if(newval)
	{
		playsound(localclientnum, #"chr_health_laststand_enter", (0, 0, 0));
		playloopat("chr_health_laststand_loop", self.sndlaststand);
	}
	else
	{
		stoploopat("chr_health_laststand_loop", self.sndlaststand);
		self.sndlaststand = undefined;
	}
}

/*
	Name: sndtacrig
	Namespace: audio
	Checksum: 0x3B65BF99
	Offset: 0x3AF8
	Size: 0x62
	Parameters: 7
	Flags: Linked
*/
function sndtacrig(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.sndtacrigemergencyreserve = 1;
	}
	else
	{
		self.sndtacrigemergencyreserve = 0;
	}
}

/*
	Name: dorattle
	Namespace: audio
	Checksum: 0x3C5513F2
	Offset: 0x3B68
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function dorattle(origin, min, max)
{
	if(isdefined(min) && min > 0)
	{
		if(isdefined(max) && max <= 0)
		{
			max = undefined;
		}
		soundrattle(origin, min, max);
	}
}

/*
	Name: sndrattle_server
	Namespace: audio
	Checksum: 0x413BA638
	Offset: 0x3BE0
	Size: 0xF4
	Parameters: 7
	Flags: Linked
*/
function sndrattle_server(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(isdefined(self.model) && self.model == #"wpn_t7_bouncing_betty_world")
		{
			betty = getweapon(#"bouncingbetty");
			level thread dorattle(self.origin, betty.soundrattlerangemin, betty.soundrattlerangemax);
		}
		else
		{
			level thread dorattle(self.origin, 25, 600);
		}
	}
}

/*
	Name: sndrattle_grenade_client
	Namespace: audio
	Checksum: 0x28F24A1
	Offset: 0x3CE0
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function sndrattle_grenade_client()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"explode");
		level thread dorattle(waitresult.position, waitresult.weapon.soundrattlerangemin, waitresult.weapon.soundrattlerangemax);
	}
}

/*
	Name: weapon_butt_sounds
	Namespace: audio
	Checksum: 0x9DA52E27
	Offset: 0x3D68
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function weapon_butt_sounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		self.meleed = 1;
		level.mysnd = playsound(localclientnum, #"chr_melee_tinitus", (0, 0, 0));
	}
	else
	{
		self.meleed = 0;
		if(isdefined(level.mysnd))
		{
			stopsound(level.mysnd);
		}
	}
}

/*
	Name: set_sound_context_defaults
	Namespace: audio
	Checksum: 0x557243BA
	Offset: 0x3E28
	Size: 0x2C
	Parameters: 0
	Flags: None
*/
function set_sound_context_defaults()
{
	wait(2);
	setsoundcontext("foley", "normal");
}

/*
	Name: sndmatchsnapshot
	Namespace: audio
	Checksum: 0x2B7FB746
	Offset: 0x3E60
	Size: 0x114
	Parameters: 7
	Flags: Linked
*/
function sndmatchsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(function_f99d2668())
	{
		return;
	}
	if(newval)
	{
		switch(newval)
		{
			case 1:
			{
				snd_set_snapshot("mpl_prematch");
				break;
			}
			case 2:
			{
				snd_set_snapshot("mpl_postmatch");
				break;
			}
			case 3:
			{
				snd_set_snapshot("mpl_endmatch");
				break;
			}
		}
	}
	else
	{
		snd_set_snapshot("default");
	}
}

/*
	Name: sndfoleycontext
	Namespace: audio
	Checksum: 0x7D56FDD1
	Offset: 0x3F80
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function sndfoleycontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	setsoundcontext("foley", "normal");
}

/*
	Name: sndkillcam
	Namespace: audio
	Checksum: 0xEA308A90
	Offset: 0x3FE8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function sndkillcam()
{
	level thread sndfinalkillcam_slowdown();
	level thread sndfinalkillcam_deactivate();
}

/*
	Name: snddeath_activate
	Namespace: audio
	Checksum: 0xC4CF332D
	Offset: 0x4028
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function snddeath_activate()
{
	while(true)
	{
		level waittill(#"sndded");
		snd_set_snapshot("mpl_death");
	}
}

/*
	Name: snddeath_deactivate
	Namespace: audio
	Checksum: 0x17298893
	Offset: 0x4070
	Size: 0x40
	Parameters: 0
	Flags: None
*/
function snddeath_deactivate()
{
	while(true)
	{
		level waittill(#"snddede");
		snd_set_snapshot("default");
	}
}

/*
	Name: sndfinalkillcam_activate
	Namespace: audio
	Checksum: 0xF095C01F
	Offset: 0x40B8
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function sndfinalkillcam_activate()
{
	while(true)
	{
		level waittill(#"sndfks");
	}
}

/*
	Name: sndfinalkillcam_slowdown
	Namespace: audio
	Checksum: 0x2B630AD4
	Offset: 0x40E8
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function sndfinalkillcam_slowdown()
{
	while(true)
	{
		level waittill(#"sndfksl");
	}
}

/*
	Name: sndfinalkillcam_deactivate
	Namespace: audio
	Checksum: 0x5BD3F2B3
	Offset: 0x4118
	Size: 0x40
	Parameters: 0
	Flags: Linked
*/
function sndfinalkillcam_deactivate()
{
	while(true)
	{
		level waittill(#"sndfke");
		snd_set_snapshot("default");
	}
}

/*
	Name: sndswitchvehiclecontext
	Namespace: audio
	Checksum: 0x14A73E2B
	Offset: 0x4160
	Size: 0xC4
	Parameters: 7
	Flags: Linked
*/
function sndswitchvehiclecontext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(self))
	{
		return;
	}
	if(self isvehicle() && self function_4add50a7())
	{
		setsoundcontext("plr_impact", "veh");
	}
	else
	{
		setsoundcontext("plr_impact", "");
	}
}

/*
	Name: sndmusicdeathwatcher
	Namespace: audio
	Checksum: 0x2BE6CF85
	Offset: 0x4230
	Size: 0x1A
	Parameters: 0
	Flags: Linked
*/
function sndmusicdeathwatcher()
{
	self waittill(#"death");
}

/*
	Name: sndcchacking
	Namespace: audio
	Checksum: 0xF9D54E17
	Offset: 0x4258
	Size: 0x1CC
	Parameters: 7
	Flags: Linked
*/
function sndcchacking(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		switch(newval)
		{
			case 1:
			{
				playsound(0, #"gdt_cybercore_hack_start_plr", (0, 0, 0));
				self.hsnd = self playloopsound(#"gdt_cybercore_hack_lp_plr", 0.5);
				break;
			}
			case 2:
			{
				playsound(0, #"gdt_cybercore_prime_upg_plr", (0, 0, 0));
				self.hsnd = self playloopsound(#"gdt_cybercore_prime_loop_plr", 0.5);
				break;
			}
		}
	}
	else
	{
		if(isdefined(self.hsnd))
		{
			self stoploopsound(self.hsnd, 0.5);
		}
		if(oldval == 1)
		{
			playsound(0, #"gdt_cybercore_hack_success_plr", (0, 0, 0));
		}
		else if(oldval == 2)
		{
			playsound(0, #"gdt_cybercore_activate_fail_plr", (0, 0, 0));
		}
	}
}

/*
	Name: sndigcsnapshot
	Namespace: audio
	Checksum: 0xFAF63152
	Offset: 0x4430
	Size: 0x182
	Parameters: 7
	Flags: Linked
*/
function sndigcsnapshot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		switch(newval)
		{
			case 1:
			{
				snd_set_snapshot("cmn_igc_bg_lower");
				level.sndigcsnapshotoverride = 0;
				break;
			}
			case 2:
			{
				snd_set_snapshot("cmn_igc_amb_silent");
				level.sndigcsnapshotoverride = 1;
				break;
			}
			case 3:
			{
				snd_set_snapshot("cmn_igc_foley_lower");
				level.sndigcsnapshotoverride = 0;
				break;
			}
			case 4:
			{
				snd_set_snapshot("cmn_level_fadeout");
				level.sndigcsnapshotoverride = 0;
				break;
			}
			case 5:
			{
				snd_set_snapshot("cmn_level_fade_immediate");
				level.sndigcsnapshotoverride = 0;
				break;
			}
		}
	}
	else
	{
		level.sndigcsnapshotoverride = 0;
	}
}

/*
	Name: sndlevelstartsnapoff
	Namespace: audio
	Checksum: 0xA34155BC
	Offset: 0x45C0
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function sndlevelstartsnapoff(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
	}
}

/*
	Name: sndzmbfadein
	Namespace: audio
	Checksum: 0xEAA640A
	Offset: 0x4630
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function sndzmbfadein(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		snd_set_snapshot("default");
	}
}

/*
	Name: sndchyronloop
	Namespace: audio
	Checksum: 0x459F8366
	Offset: 0x4698
	Size: 0xD4
	Parameters: 7
	Flags: Linked
*/
function sndchyronloop(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval)
	{
		if(!isdefined(level.chyronloop))
		{
			level.chyronloop = spawn(0, (0, 0, 0), "script_origin");
			level.chyronloop playloopsound(#"uin_chyron_loop");
		}
	}
	else if(isdefined(level.chyronloop))
	{
		level.chyronloop delete();
	}
}

/*
	Name: sndsprintbreath
	Namespace: audio
	Checksum: 0x9E3326A2
	Offset: 0x4778
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function sndsprintbreath(localclientnum)
{
	self endon(#"death");
	if(sessionmodeismultiplayergame() || function_f99d2668())
	{
		self.var_29054134 = 0;
		var_63112f76 = self dialog_shared::get_player_dialog_alias("exertBreatheSprinting");
		var_dfb6f570 = self dialog_shared::get_player_dialog_alias("exertBreatheSprintingEnd");
		if(!isdefined(var_63112f76) || !isdefined(var_dfb6f570))
		{
			return;
		}
		while(true)
		{
			if(isdefined(self))
			{
				if(self isplayersprinting())
				{
					self thread sndbreathstart(var_63112f76);
					self thread function_ee6d1a7f(var_dfb6f570);
					waitresult = undefined;
					waitresult = self waittill(#"hash_4e899fa9b2775b4d", #"death");
					if(waitresult._notify == "death")
					{
						return;
					}
				}
			}
			wait(0.1);
		}
	}
}

/*
	Name: sndbreathstart
	Namespace: audio
	Checksum: 0x622C2C94
	Offset: 0x48F8
	Size: 0x64
	Parameters: 1
	Flags: Linked
*/
function sndbreathstart(sound)
{
	self endon(#"hash_4e899fa9b2775b4d");
	self endon(#"death");
	self waittill(#"hash_1d827c5a5cd4a607");
	if(isdefined(self))
	{
		self thread function_d6bc7279(sound);
	}
}

/*
	Name: function_d6bc7279
	Namespace: audio
	Checksum: 0x68863EA6
	Offset: 0x4968
	Size: 0x68
	Parameters: 1
	Flags: Linked
*/
function function_d6bc7279(sound)
{
	self endon(#"death");
	self endon(#"hash_4e899fa9b2775b4d");
	self.var_29054134 = 1;
	while(true)
	{
		self playsound(0, sound);
		wait(2.5);
	}
}

/*
	Name: function_ee6d1a7f
	Namespace: audio
	Checksum: 0x61352AD2
	Offset: 0x49D8
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function function_ee6d1a7f(sound)
{
	self endon(#"death");
	self waittill(#"hash_4e899fa9b2775b4d");
	if(self.var_29054134)
	{
		self playsound(0, sound);
		self.var_29054134 = 0;
	}
}

/*
	Name: function_5da61577
	Namespace: audio
	Checksum: 0x190F473F
	Offset: 0x4A40
	Size: 0x3C
	Parameters: 1
	Flags: None
*/
function function_5da61577(localclientnum)
{
	self endon(#"death");
	if(isdefined(self))
	{
		self thread function_bd07593a();
	}
}

/*
	Name: function_bd07593a
	Namespace: audio
	Checksum: 0x1477DE41
	Offset: 0x4A88
	Size: 0xB8
	Parameters: 0
	Flags: Linked
*/
function function_bd07593a()
{
	self endon(#"death");
	while(true)
	{
		if(self util::is_on_side(#"allies"))
		{
			if(self isplayersprinting())
			{
				self playsound(0, #"hash_2dc9c76844261d06");
				wait(1);
			}
			else
			{
				self playsound(0, #"hash_70b507d0e243536d");
				wait(2.5);
			}
		}
		wait(0.1);
	}
}

/*
	Name: sndvehicledamagealarm
	Namespace: audio
	Checksum: 0x253BF248
	Offset: 0x4B48
	Size: 0x64
	Parameters: 7
	Flags: Linked
*/
function sndvehicledamagealarm(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self notify(#"sndvehicledamagealarm");
	self thread function_350920b9();
}

/*
	Name: function_350920b9
	Namespace: audio
	Checksum: 0xC39D473C
	Offset: 0x4BB8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_350920b9()
{
	self endon(#"death");
	self endon(#"disconnect");
	self endon(#"sndvehicledamagealarm");
	if(!isdefined(self.var_5730fa36))
	{
		self.var_5730fa36 = self playloopsound(#"hash_7a6b427867364957");
	}
	wait(2);
	if(isdefined(self.var_5730fa36))
	{
		self stoploopsound(self.var_5730fa36);
		self.var_5730fa36 = undefined;
	}
	self playsound(0, #"hash_26a4334032c725cb");
}

