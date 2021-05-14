// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3f9e0dc8454d98e1;
#using script_42ac4a2f5444022b;
#using script_52c6c2d1a2ef1b46;
#using script_5660bae5b402a1eb;
#using script_5bb072c3abf4652c;
#using script_6ce38ab036223e6e;
#using script_6e3c826b1814cab6;
#using script_ab890501c40b73c;
#using script_b52a163973f339f;
#using script_c54399dcca098ce;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\lui_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\throttle_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_mansion_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_score.gsc;
#using scripts\zm_common\zm_stats.gsc;
#using scripts\zm_common\zm_traps.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_a35b43eb;

/*
	Name: function_89f2df9
	Namespace: namespace_a35b43eb
	Checksum: 0x83328C83
	Offset: 0x348
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_267df84d20de616c", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_a35b43eb
	Checksum: 0xC44F1655
	Offset: 0x398
	Size: 0x94
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level thread function_85839afe();
	callback::on_finalize_initialization(&init);
	if(!isdefined(level.var_db63b33b))
	{
		object = new throttle();
		[[ object ]]->__constructor();
		level.var_db63b33b = object;
		[[ level.var_db63b33b ]]->initialize(2, 0.1);
	}
	init_clientfields();
}

/*
	Name: __main__
	Namespace: namespace_a35b43eb
	Checksum: 0x80F724D1
	Offset: 0x438
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: init_clientfields
	Namespace: namespace_a35b43eb
	Checksum: 0xE6F4DD8A
	Offset: 0x448
	Size: 0x84
	Parameters: 0
	Flags: Linked
*/
function init_clientfields()
{
	clientfield::register("scriptmover", "" + #"hash_1a4cf85bba32ee41", 8000, 2, "int");
	clientfield::register("scriptmover", "" + #"hash_17df66ef5f71c0de", 8000, 2, "int");
}

/*
	Name: init
	Namespace: namespace_a35b43eb
	Checksum: 0x92199037
	Offset: 0x4D8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	callback::on_connect(&function_96e29e5f);
}

/*
	Name: function_96e29e5f
	Namespace: namespace_a35b43eb
	Checksum: 0x80F724D1
	Offset: 0x508
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_96e29e5f()
{
}

/*
	Name: function_85839afe
	Namespace: namespace_a35b43eb
	Checksum: 0x1DA75408
	Offset: 0x518
	Size: 0x1D4
	Parameters: 0
	Flags: Linked
*/
function function_85839afe()
{
	var_9a2f8aa = getentarray("zombie_trap", "targetname");
	level.var_ba53c5c5 = array::filter(var_9a2f8aa, 0, &function_960a9a04);
	if(namespace_59ff1d6c::function_901b751c(#"hash_4b16b22d8a0d3301"))
	{
		level.var_940ee624 = 0;
		level.var_adc872f3 = 0;
		level.var_bdcd506f = 0;
		level thread function_a8f79714();
	}
	foreach(var_e2623858 in level.var_ba53c5c5)
	{
		var_e2623858 function_bd8eddac();
	}
	if(!namespace_59ff1d6c::function_901b751c(#"hash_4b16b22d8a0d3301"))
	{
		return;
	}
	zm_traps::register_trap_basic_info("firegate", &function_16746b30, &function_30db46c1);
	zm_traps::register_trap_damage("firegate", &function_26578bc6, &function_5ad19000);
}

/*
	Name: function_960a9a04
	Namespace: namespace_a35b43eb
	Checksum: 0x5001AB25
	Offset: 0x6F8
	Size: 0x20
	Parameters: 1
	Flags: Linked
*/
function function_960a9a04(e_ent)
{
	return e_ent.script_noteworthy === "firegate";
}

/*
	Name: function_bd8eddac
	Namespace: namespace_a35b43eb
	Checksum: 0x98839377
	Offset: 0x720
	Size: 0x2FC
	Parameters: 0
	Flags: Linked
*/
function function_bd8eddac()
{
	self flag::init(#"enabled");
	self flag::init(#"activated");
	self flag::init(#"friendly");
	self.var_a768e132 = [];
	self.var_3a2026c0 = [];
	self.var_3d6b88c4 = [];
	self.var_872ce8b7 = [];
	var_cc06b647 = getentarray(self.target, "targetname");
	foreach(var_a2f7fe95 in var_cc06b647)
	{
		if(var_a2f7fe95.script_noteworthy === "trap_console")
		{
			self.var_3d6b88c4[self.var_3d6b88c4.size] = var_a2f7fe95;
			continue;
		}
		if(var_a2f7fe95.script_noteworthy === "trap_lever")
		{
			self.var_872ce8b7[self.var_872ce8b7.size] = var_a2f7fe95;
			continue;
		}
		if(var_a2f7fe95.script_noteworthy === "bulletclip")
		{
			var_a2f7fe95 notsolid();
			self.bulletclip = var_a2f7fe95;
		}
	}
	var_b72aaabb = struct::get_array(self.target, "targetname");
	foreach(s_element in var_b72aaabb)
	{
		if(s_element.script_noteworthy === "source_trig_pos")
		{
			self.var_3a2026c0[self.var_3a2026c0.size] = s_element;
			continue;
		}
		if(s_element.script_noteworthy === "energy_source")
		{
			self.var_a768e132[self.var_a768e132.size] = s_element;
		}
	}
	array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "off");
	self thread function_aa539d7b();
}

/*
	Name: function_aa539d7b
	Namespace: namespace_a35b43eb
	Checksum: 0x58DAAA5B
	Offset: 0xA28
	Size: 0x4C8
	Parameters: 0
	Flags: Linked
*/
function function_aa539d7b()
{
	level flag::wait_till("all_players_spawned");
	self function_b97c8553();
	if(!namespace_59ff1d6c::function_901b751c(#"hash_4b16b22d8a0d3301"))
	{
		return;
	}
	if(!zm_utility::is_standard())
	{
		level flag::wait_till(self.var_78f643be);
	}
	self.var_23769a97 = [];
	foreach(var_d0ba86c2 in self.var_3a2026c0)
	{
		str_prompt = zm_utility::function_d6046228(#"hash_888d5fd1e90d685", #"hash_f1db4a15f0e12bb");
		var_47323b73 = namespace_c05f06c7::create_unitrigger(var_d0ba86c2, &function_5b8a557f, str_prompt, 0, 0, 0);
		var_47323b73.e_trap = self;
		var_47323b73.prompt_and_visibility_func = &function_9026cbcd;
		self.var_23769a97[self.var_23769a97.size] = var_47323b73;
	}
	if(zm_utility::is_standard())
	{
		self flag::set(#"enabled");
		level flag::set(self.script_flag_wait);
		array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "green");
		foreach(var_4a416ea9 in self.var_3d6b88c4)
		{
			var_fe316a03 = util::spawn_model(#"hash_739ab862899e9135", var_4a416ea9 gettagorigin("energy_core_tag"), var_4a416ea9 gettagangles("energy_core_tag"));
			var_fe316a03 linkto(var_4a416ea9, "energy_core_tag");
		}
		return;
	}
	self flag::wait_till(#"enabled");
	playsoundatposition(#"hash_277a6124c088ba6d", self.origin);
	sound_ent = spawn("script_origin", self.origin);
	sound_ent playloopsound(#"hash_39e79a32dcbea912");
	level flag::set(self.script_flag_wait);
	array::thread_all(self.var_3d6b88c4, &function_e714e3a8, "green");
	foreach(var_4a416ea9 in self.var_3d6b88c4)
	{
		var_fe316a03 = util::spawn_model(#"hash_739ab862899e9135", var_4a416ea9 gettagorigin("energy_core_tag"), var_4a416ea9 gettagangles("energy_core_tag"));
		var_fe316a03 linkto(var_4a416ea9, "energy_core_tag");
	}
}

/*
	Name: function_5b8a557f
	Namespace: namespace_a35b43eb
	Checksum: 0x81684D0B
	Offset: 0xEF8
	Size: 0x2A0
	Parameters: 0
	Flags: Linked
*/
function function_5b8a557f()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		e_trap = self.stub.e_trap;
		if(isdefined(e_trap.var_23aecef0) && e_trap.var_23aecef0 || zm_utility::is_standard())
		{
			if(!zm_utility::can_use(e_player))
			{
				continue;
			}
			if(isdefined(level.var_4f7df1ac) && level.var_4f7df1ac)
			{
				continue;
			}
			if(isdefined(e_trap.is_cooling) && e_trap.is_cooling || (isdefined(e_trap._trap_in_use) && e_trap._trap_in_use))
			{
				continue;
			}
			if(zm_utility::is_player_valid(e_player) && (!(isdefined(e_trap._trap_in_use) && e_trap._trap_in_use)))
			{
				b_purchased = self zm_traps::function_3f0a4c65(e_player, e_trap.zombie_cost);
				if(!b_purchased)
				{
					continue;
				}
				if(isdefined(e_trap) && isalive(e_player))
				{
					level thread zm_traps::trap_activate(e_trap, e_player);
				}
			}
		}
		else if(level.var_940ee624 > 0)
		{
			e_player thread function_1bcb6813();
			e_trap.var_23aecef0 = 1;
			var_db919ceb = arraygetclosest(self.stub.origin, level.var_ba53c5c5);
			var_db919ceb flag::set(#"enabled");
			level.var_940ee624--;
			level.var_bdcd506f++;
			level thread function_7b170638(level.var_bdcd506f, 0);
		}
	}
}

/*
	Name: function_1bcb6813
	Namespace: namespace_a35b43eb
	Checksum: 0xA2C4EF5A
	Offset: 0x11A0
	Size: 0x52
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1bcb6813()
{
	if(!(isdefined(self.var_72a21e82) && self.var_72a21e82))
	{
		self.var_72a21e82 = self zm_audio::create_and_play_dialog(#"fire_trap", #"set");
	}
}

/*
	Name: function_9026cbcd
	Namespace: namespace_a35b43eb
	Checksum: 0xFF9426BE
	Offset: 0x1200
	Size: 0x2E8
	Parameters: 1
	Flags: Linked
*/
function function_9026cbcd(player)
{
	self.hint_string = self.stub.hint_string;
	if(player zm_utility::is_drinking() || (isdefined(level.var_4f7df1ac) && level.var_4f7df1ac))
	{
		return 0;
	}
	if(isdefined(self.stub.e_trap._trap_in_use) && self.stub.e_trap._trap_in_use)
	{
		return 0;
	}
	if(isdefined(self.stub.e_trap.is_cooling) && self.stub.e_trap.is_cooling)
	{
		self sethintstring(#"hash_21db2780833a8bfd");
		return 1;
	}
	if(isdefined(self.stub.e_trap.var_23aecef0) && self.stub.e_trap.var_23aecef0 && !zm_utility::is_standard())
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_6e8ef1b690e98e51", self.stub.e_trap.zombie_cost);
			return 1;
		}
		self sethintstring(#"hash_23c1c09e94181fdb", self.stub.e_trap.zombie_cost);
		return 1;
	}
	if(zm_utility::is_standard())
	{
		if(function_8b1a219a())
		{
			self sethintstring(#"hash_61d85c966dd9e83f");
			return 1;
		}
		self sethintstring(#"hash_24a438482954901");
		return 1;
	}
	if(level.var_940ee624 > 0)
	{
		str_prompt = zm_utility::function_d6046228(#"hash_888d5fd1e90d685", #"hash_f1db4a15f0e12bb");
		self sethintstring(str_prompt);
		return 1;
	}
	self sethintstring(#"hash_5f05371ea87b812e");
	return 1;
}

/*
	Name: function_a8f79714
	Namespace: namespace_a35b43eb
	Checksum: 0xBB7F2CF5
	Offset: 0x14F8
	Size: 0x1AC
	Parameters: 0
	Flags: Linked
*/
function function_a8f79714()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	level.var_4f17d729 = [];
	if(math::cointoss())
	{
		array::add(level.var_4f17d729, function_2a5a929("mansion_downstairs"));
	}
	else
	{
		array::add(level.var_4f17d729, function_2a5a929("mansion_upstairs"));
	}
	if(math::cointoss())
	{
		array::add(level.var_4f17d729, function_2a5a929("cemetery"));
	}
	else
	{
		array::add(level.var_4f17d729, function_2a5a929("mausoleum"));
	}
	if(math::cointoss())
	{
		array::add(level.var_4f17d729, function_2a5a929("greenhouse"));
	}
	else
	{
		array::add(level.var_4f17d729, function_2a5a929("gardens"));
	}
}

/*
	Name: function_2a5a929
	Namespace: namespace_a35b43eb
	Checksum: 0xD314A96E
	Offset: 0x16B0
	Size: 0x1A6
	Parameters: 2
	Flags: Linked
*/
function function_2a5a929(str_location, var_b7eee573)
{
	a_s_locs = struct::get_array("s_firegate_energy_src_" + str_location, "targetname");
	var_d0ed2a4c = 0;
	while(!var_d0ed2a4c)
	{
		s_loc = array::random(a_s_locs);
		if(!isdefined(s_loc.b_occupied))
		{
			s_loc.b_occupied = 1;
			var_d0ed2a4c = 1;
		}
	}
	str_prompt = zm_utility::function_d6046228(#"hash_78bf6e69946b64ca", #"hash_7042b50d373a6fce");
	var_47323b73 = namespace_c05f06c7::create_unitrigger(s_loc, &function_b1bd4115, str_prompt, 0, undefined, 0);
	var_47323b73.mdl = util::spawn_model(#"hash_739ab862899e9135", s_loc.origin, s_loc.angles);
	var_47323b73.mdl notsolid();
	var_47323b73.mdl thread function_ab6f51d9();
	var_47323b73.str_location = str_location;
	return var_47323b73;
}

/*
	Name: function_b1bd4115
	Namespace: namespace_a35b43eb
	Checksum: 0x12E8E03B
	Offset: 0x1860
	Size: 0x178
	Parameters: 0
	Flags: Linked
*/
function function_b1bd4115()
{
	self endon(#"death");
	while(true)
	{
		waitresult = undefined;
		waitresult = self waittill(#"trigger");
		e_player = waitresult.activator;
		if(zm_utility::is_player_valid(e_player))
		{
			level.var_940ee624++;
			level.var_adc872f3++;
			level thread function_7b170638(level.var_adc872f3, 1);
			e_player thread zm_audio::create_and_play_dialog(#"hash_44b4edd3d705820d", #"generic");
			arrayremovevalue(level.var_4f17d729, self, 0);
			playsoundatposition(#"hash_7512ff4121bb5604", e_player.origin);
			if(isdefined(self.stub.mdl))
			{
				self.stub.mdl delete();
			}
			zm_unitrigger::unregister_unitrigger(self.stub);
		}
	}
}

/*
	Name: function_7b170638
	Namespace: namespace_a35b43eb
	Checksum: 0x6BD0B63A
	Offset: 0x19E0
	Size: 0xF4
	Parameters: 2
	Flags: Linked
*/
function function_7b170638(var_8163cc4, b_found)
{
	switch(var_8163cc4)
	{
		case 1:
		{
			var_7a0a29e3 = #"hash_379a0cb8e272c259";
			break;
		}
		case 2:
		{
			var_7a0a29e3 = #"hash_379a09b8e272bd40";
			break;
		}
		case 3:
		{
			var_7a0a29e3 = #"hash_379a0ab8e272bef3";
			break;
		}
	}
	if(isdefined(var_7a0a29e3))
	{
		if(b_found)
		{
			level namespace_6747c550::function_7df6bb60(var_7a0a29e3, 1);
		}
		else
		{
			level namespace_6747c550::function_7df6bb60(var_7a0a29e3, 2);
		}
	}
}

/*
	Name: function_ab6f51d9
	Namespace: namespace_a35b43eb
	Checksum: 0xCD0CF0A6
	Offset: 0x1AE0
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_ab6f51d9()
{
	self endon(#"death");
	self playloopsound(#"hash_3b9597774dea00d6");
	while(true)
	{
		self rotateyaw(180, 1);
		wait(1);
	}
}

/*
	Name: function_16746b30
	Namespace: namespace_a35b43eb
	Checksum: 0x5DFF4318
	Offset: 0x1B58
	Size: 0x1A4
	Parameters: 0
	Flags: Linked
*/
function function_16746b30()
{
	self._trap_duration = 30;
	self._trap_cooldown_time = 30;
	if(isdefined(level.sndtrapfunc))
	{
		level thread [[level.sndtrapfunc]](self, 1);
	}
	self.activated_by_player thread function_45a2294f(self.script_string);
	foreach(e_trap in level.var_ba53c5c5)
	{
		if(e_trap.script_string === self.script_string)
		{
			e_trap thread zm_traps::trap_damage();
		}
	}
	self waittill_timeout(self._trap_duration, #"trap_deactivate");
	foreach(e_trap in level.var_ba53c5c5)
	{
		if(e_trap.script_string === self.script_string)
		{
			e_trap notify(#"trap_done");
		}
	}
}

/*
	Name: function_30db46c1
	Namespace: namespace_a35b43eb
	Checksum: 0x80F724D1
	Offset: 0x1D08
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function function_30db46c1()
{
}

/*
	Name: function_45a2294f
	Namespace: namespace_a35b43eb
	Checksum: 0x867523E
	Offset: 0x1D18
	Size: 0x310
	Parameters: 1
	Flags: Linked
*/
function function_45a2294f(str_id)
{
	foreach(e_trap in level.var_ba53c5c5)
	{
		if(e_trap.script_string === str_id)
		{
			e_trap thread activate_trap(self);
			array::thread_all(e_trap.var_3d6b88c4, &function_e714e3a8, "red");
			array::run_all(e_trap.var_872ce8b7, &rotatepitch, 90, 0.5);
		}
	}
	level notify(#"traps_activated", {#hash_be3f58a:str_id});
	wait(30);
	level notify(#"hash_3c662e7b29cfc3dd", {#hash_be3f58a:str_id});
	n_cooldown = zm_traps::function_da13db45(30, self);
	foreach(e_trap in level.var_ba53c5c5)
	{
		if(e_trap.script_string === str_id)
		{
			e_trap.is_cooling = 1;
		}
	}
	wait(n_cooldown);
	level notify(#"traps_available", {#hash_be3f58a:str_id});
	foreach(e_trap in level.var_ba53c5c5)
	{
		if(e_trap.script_string === str_id)
		{
			e_trap.is_cooling = undefined;
			array::thread_all(e_trap.var_3d6b88c4, &function_e714e3a8, "green");
			array::run_all(e_trap.var_872ce8b7, &rotatepitch, -90, 0.5);
		}
	}
}

/*
	Name: activate_trap
	Namespace: namespace_a35b43eb
	Checksum: 0xBC41A44C
	Offset: 0x2030
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function activate_trap(e_player)
{
	if(!self flag::get(#"activated"))
	{
		self flag::set(#"activated");
		if(isdefined(e_player))
		{
			self.activated_by_player = e_player;
		}
		self function_7d9e84f9();
		self thread function_21fd7c39();
		wait(30);
		self function_b97c8553();
	}
}

/*
	Name: function_b97c8553
	Namespace: namespace_a35b43eb
	Checksum: 0xF4BA6DC
	Offset: 0x20E0
	Size: 0xA6
	Parameters: 0
	Flags: Linked
*/
function function_b97c8553()
{
	self function_5627d722();
	self thread function_7947b7ee();
	self flag::clear(#"activated");
	self flag::clear(#"friendly");
	self notify(#"deactivate");
	self notify(#"trap_deactivate");
	self notify(#"trap_done");
}

/*
	Name: function_7d9e84f9
	Namespace: namespace_a35b43eb
	Checksum: 0xC1EBCC06
	Offset: 0x2190
	Size: 0x1DC
	Parameters: 1
	Flags: Linked
*/
function function_7d9e84f9(str_color = "red")
{
	if(isdefined(self.str_exploder))
	{
		exploder::stop_exploder(self.str_exploder);
		self.str_exploder = undefined;
	}
	switch(self.script_string)
	{
		case "hash_1da63a56d335126d":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_mh";
			break;
		}
		case "hash_1eac9298079b93a8":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_clr";
			break;
		}
		case "hash_4ff91fde07ff6a11":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_br";
			break;
		}
		case "hash_fe1fc05e30fa5c6":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_lb";
			break;
		}
		case "hash_1fe78db53e6ed30f":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_msm";
			break;
		}
		case "hash_6403fa19e4d17902":
		{
			self.str_exploder = "fxexp_tf_" + str_color + "_gh";
			break;
		}
	}
	exploder::exploder(self.str_exploder);
	self playsound(#"hash_370460eab1a33ee6");
}

/*
	Name: function_5627d722
	Namespace: namespace_a35b43eb
	Checksum: 0x38C4BC0A
	Offset: 0x2378
	Size: 0x56
	Parameters: 0
	Flags: Linked
*/
function function_5627d722()
{
	if(isdefined(self.str_exploder))
	{
		exploder::stop_exploder(self.str_exploder);
		self playsound(#"hash_5d8ec72f0838594e");
		self.str_exploder = undefined;
	}
}

/*
	Name: function_5ad19000
	Namespace: namespace_a35b43eb
	Checksum: 0xE3CDD376
	Offset: 0x23D8
	Size: 0x31C
	Parameters: 1
	Flags: Linked
*/
function function_5ad19000(e_trap)
{
	self endon(#"death");
	if(self.var_6f84b820 === #"popcorn")
	{
		return;
	}
	if(self.var_9fde8624 === #"hash_5cfa99582cc66c59" && e_trap flag::get(#"friendly") == 0)
	{
		return;
	}
	if(self.team === #"allies")
	{
		return;
	}
	if(self.var_6f84b820 === #"miniboss" || self.var_6f84b820 === #"heavy" || self.var_6f84b820 === #"boss")
	{
		if(self.archetype === #"blight_father")
		{
			e_trap function_b97c8553();
		}
		if(e_trap flag::get(#"friendly") === 0)
		{
			if(!(isdefined(self.is_on_fire) && self.is_on_fire))
			{
				self thread zombie_death::flame_death_fx();
			}
			return;
		}
		self dodamage(self.health * 0.1, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
	}
	else
	{
		self thread zombie_death::flame_death_fx();
		if(isdefined(self.fire_damage_func))
		{
			self [[self.fire_damage_func]](e_trap);
		}
		else
		{
			[[ level.var_db63b33b ]]->waitinqueue(self);
			level notify(#"trap_kill", {#e_trap:e_trap, #e_victim:self});
			if(isdefined(e_trap.activated_by_player) && isplayer(e_trap.activated_by_player))
			{
				e_trap.activated_by_player zm_stats::increment_challenge_stat(#"zombie_hunter_kill_trap");
				e_trap.activated_by_player contracts::function_5b88297d(#"hash_1f11b620a6de486b");
			}
			self dodamage(20000, e_trap.origin, undefined, e_trap, undefined, "MOD_BURNED", 0, undefined);
		}
	}
}

/*
	Name: function_26578bc6
	Namespace: namespace_a35b43eb
	Checksum: 0xD5C6450
	Offset: 0x2700
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_26578bc6(t_damage)
{
	if(!t_damage flag::get(#"friendly") && self getstance() === "stand" && !self issliding())
	{
		self dodamage(50, t_damage.origin, undefined, t_damage, undefined, "MOD_BURNED", 0, undefined);
	}
}

/*
	Name: function_21fd7c39
	Namespace: namespace_a35b43eb
	Checksum: 0xDD602CE0
	Offset: 0x27B0
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function function_21fd7c39()
{
	self endon(#"trap_done");
	self.bulletclip solid();
	self.bulletclip.health = 100000;
	self.bulletclip setcandamage(1);
	b_friendly = 0;
	while(!b_friendly)
	{
		s_notify = undefined;
		s_notify = self.bulletclip waittill(#"damage");
		if(s_notify.weapon === level.var_74cf08b1 || s_notify.weapon === level.var_4b14202f)
		{
			b_friendly = 1;
		}
		else
		{
			self.bulletclip.health = 100000;
		}
	}
	self flag::set(#"friendly");
	if(s_notify.weapon === level.var_4b14202f)
	{
		self thread function_7d9e84f9("blue");
		self thread blue_fire();
		e_player = s_notify.attacker;
		if(isalive(e_player) && (!(isdefined(e_player.var_a46d8eee) && e_player.var_a46d8eee)))
		{
			e_player thread function_1eeda1e5();
		}
	}
	else if(s_notify.weapon === level.var_74cf08b1)
	{
		self thread function_7d9e84f9("green");
	}
}

/*
	Name: function_1eeda1e5
	Namespace: namespace_a35b43eb
	Checksum: 0xE79E73E9
	Offset: 0x29C8
	Size: 0xA4
	Parameters: 0
	Flags: Linked, Private
*/
private function function_1eeda1e5()
{
	self endon(#"disconnect");
	self.var_a46d8eee = 1;
	n_character_index = zm_characters::function_d35e4c92();
	str_vo = "vox_generic_responses_positive_plr_" + n_character_index + "_" + randomint(9);
	self thread zm_vo::function_8e0f4696(str_vo, 0, 1, 9999);
}

/*
	Name: function_7947b7ee
	Namespace: namespace_a35b43eb
	Checksum: 0x6D8FF046
	Offset: 0x2A78
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_7947b7ee()
{
	self.bulletclip setcandamage(0);
	self.bulletclip notsolid();
}

/*
	Name: blue_fire
	Namespace: namespace_a35b43eb
	Checksum: 0xFD696E93
	Offset: 0x2AB8
	Size: 0x4E
	Parameters: 0
	Flags: Linked
*/
function blue_fire()
{
	self thread namespace_7922d3d4::function_40e665ab();
	self flag::wait_till_clear(#"friendly");
	self notify(#"extinguish");
}

/*
	Name: function_e714e3a8
	Namespace: namespace_a35b43eb
	Checksum: 0xC8A53B0E
	Offset: 0x2B10
	Size: 0x1E2
	Parameters: 1
	Flags: Linked, Private
*/
private function function_e714e3a8(str_state = "off")
{
	switch(str_state)
	{
		case "off":
		{
			self hidepart("light_green");
			self hidepart("light_red");
			self showpart("light_off");
			break;
		}
		case "green":
		{
			self clientfield::set("" + #"hash_1a4cf85bba32ee41", 1);
			self hidepart("light_off");
			self hidepart("light_red");
			self showpart("light_green");
			break;
		}
		case "red":
		{
			self clientfield::set("" + #"hash_1a4cf85bba32ee41", 2);
			self hidepart("light_green");
			self hidepart("light_off");
			self showpart("light_red");
			break;
		}
	}
}

