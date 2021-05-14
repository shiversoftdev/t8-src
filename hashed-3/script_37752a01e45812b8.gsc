// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_3110b4b6b21db11f;
#using script_58c342edd81589fb;
#using script_6a3f43063dfd1bdc;
#using script_6c5b51f98cd04fa3;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\laststand_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_equipment.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_565e073b;

/*
	Name: preload
	Namespace: namespace_565e073b
	Checksum: 0x80F724D1
	Offset: 0x180
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function preload()
{
}

/*
	Name: main
	Namespace: namespace_565e073b
	Checksum: 0xA7A1FD36
	Offset: 0x190
	Size: 0x294
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"hash_507adabe6ce05360");
	level flag::init(#"hash_7c577b936ff3fe7e");
	zm_audio::sndannouncervoxadd(#"hash_507adabe6ce05360", #"hash_2df47a99f054462e");
	level.var_50c3a25b = getentarray("freeze_mode_ice", "targetname");
	foreach(ice in level.var_50c3a25b)
	{
		ice hide();
		ice notsolid();
	}
	level.var_c422a9ae = getentarray("freeze_mode_blockers", "targetname");
	foreach(barrier in level.var_c422a9ae)
	{
		barrier notsolid();
	}
	namespace_ee206246::register(#"hash_507adabe6ce05360", #"step_1", #"hash_fca1aaee837b77", &function_b0cb0de5, &function_b5fd797c);
	namespace_ee206246::start(#"hash_507adabe6ce05360", zm_utility::function_e51dc2d8());
	callback::on_spawned(&function_1bb74851);
}

/*
	Name: function_b0cb0de5
	Namespace: namespace_565e073b
	Checksum: 0x33AB9BC8
	Offset: 0x430
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_b0cb0de5(var_a276c861)
{
	level flag::wait_till_any(array(#"hash_7c577b936ff3fe7e", #"hash_9cfd45106ac760d", #"hash_198bc172b5af7f25"));
}

/*
	Name: function_b5fd797c
	Namespace: namespace_565e073b
	Checksum: 0xEFFDEEE9
	Offset: 0x498
	Size: 0x52C
	Parameters: 2
	Flags: Linked
*/
function function_b5fd797c(var_a276c861, var_19e802fa)
{
	if(var_a276c861)
	{
		level flag::set(#"hash_7c577b936ff3fe7e");
	}
	if(level flag::get(#"hash_9cfd45106ac760d") || level flag::get(#"hash_198bc172b5af7f25"))
	{
		return;
	}
	var_e08890fb = getent("freeze_mode_button", "targetname");
	var_e08890fb movez(var_e08890fb.script_int, 2, 0.2, 0.2);
	wait(1.5);
	var_57e06cb = struct::get("freeze_mode_struct", "targetname");
	var_57e06cb namespace_509a75d1::function_6099877a(72, "end_game", #"hash_6001ebf204288bf8", #"hash_3fe9eae6f03accce");
	var_898a45da = level.var_45827161[level.round_number + 1];
	if(isdefined(var_898a45da))
	{
		namespace_c3287616::function_43aed0ca(level.round_number + 1);
	}
	level flag::clear(#"hash_7d9f8ec3cb9af87e");
	level.func_get_delay_between_rounds = &function_f85d3d98;
	namespace_509a75d1::function_2ba419ee(1, int(max(199, level.round_number)));
	level flag::clear(#"break_freeze_faster");
	foreach(zone in level.zones)
	{
		if(zone.name != "docks_1" && zone.name != "docks_2")
		{
			zone.is_enabled = 0;
		}
	}
	foreach(ice in level.var_50c3a25b)
	{
		ice show();
		ice solid();
	}
	foreach(barrier in level.var_c422a9ae)
	{
		barrier solid();
		barrier disconnectpaths();
	}
	zm_audio::sndannouncerplayvox(#"hash_507adabe6ce05360");
	level zm_utility::function_e64ac3b6(18, #"hash_552f81c78340aeb3");
	foreach(player in getplayers())
	{
		player thread function_1aab918f();
	}
	callback::on_spawned(&function_1aab918f);
	level waittill(#"start_of_round");
	level flag::set(#"infinite_round_spawning");
}

/*
	Name: function_1aab918f
	Namespace: namespace_565e073b
	Checksum: 0xB242D78C
	Offset: 0x9D0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_1aab918f()
{
	self thread function_e42e358e();
}

/*
	Name: function_1bb74851
	Namespace: namespace_565e073b
	Checksum: 0xE4E0E56C
	Offset: 0x9F8
	Size: 0x10E
	Parameters: 0
	Flags: Linked
*/
function function_1bb74851()
{
	self.var_e1257157 = 0;
	self.var_adf5d9b4 = [];
	self.var_adf5d9b4[#"hash_2fb0927a65d8a9e"] = 0;
	self.var_adf5d9b4[#"hash_75f05448c75c06f"] = 0;
	self.var_adf5d9b4[#"hash_335d7ee067ac0e68"] = 0;
	self.var_adf5d9b4[#"hash_63f7af429c316620"] = 0;
	self.var_adf5d9b4[#"hash_1e6b498a976cdcb5"] = 0;
	self.var_adf5d9b4[#"hash_3a98581b802c0296"] = 0;
	self.var_adf5d9b4[#"hash_3461ddd73c20a747"] = 0;
	self.var_adf5d9b4[#"hash_99011c41f3d5380"] = 0;
	self.var_adf5d9b4[#"hash_381e2912fb0376dc"] = 0;
	self.var_adf5d9b4[#"hash_18aaabdeba54214a"] = 0;
}

/*
	Name: function_3931c78
	Namespace: namespace_565e073b
	Checksum: 0x119AB6D1
	Offset: 0xB10
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function function_3931c78()
{
	if(isdefined(self.var_adf5d9b4[self.var_5417136]) && !self.var_adf5d9b4[self.var_5417136])
	{
		self.var_adf5d9b4[self.var_5417136] = 1;
		self.var_e1257157++;
		if(self.var_e1257157 >= self.var_adf5d9b4.size)
		{
			level flag::set(#"hash_7c577b936ff3fe7e");
		}
	}
}

/*
	Name: function_f85d3d98
	Namespace: namespace_565e073b
	Checksum: 0xCC036198
	Offset: 0xBA8
	Size: 0x6
	Parameters: 0
	Flags: Linked
*/
function function_f85d3d98()
{
	return 0;
}

/*
	Name: function_e42e358e
	Namespace: namespace_565e073b
	Checksum: 0xA4815732
	Offset: 0xBB8
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_e42e358e()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	while(true)
	{
		wait(0.1);
		if(!self issprinting() && !self laststand::player_is_in_laststand())
		{
			self function_f0bdc5df();
			return;
		}
	}
}

/*
	Name: function_f0bdc5df
	Namespace: namespace_565e073b
	Checksum: 0x53E63A2C
	Offset: 0xC60
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_f0bdc5df()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	self thread function_6577cacc();
	self notify(#"hash_42fcb8fa7aec0734");
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
	self allowslide(0);
	self thread function_1b305413();
}

/*
	Name: function_1b305413
	Namespace: namespace_565e073b
	Checksum: 0xAC675F8C
	Offset: 0xD30
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function function_1b305413()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	while(true)
	{
		wait(0.1);
		if(self issprinting() || self laststand::player_is_in_laststand())
		{
			self player_sprinting();
			return;
		}
	}
}

/*
	Name: player_sprinting
	Namespace: namespace_565e073b
	Checksum: 0x99B7B905
	Offset: 0xDD8
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function player_sprinting()
{
	level endon(#"end_game");
	self endon(#"death", #"player_frozen");
	self notify(#"hash_668824b34b3076bc");
	self allowslide(1);
	self thread namespace_18db89ed::function_d2dd1f2b();
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	self thread function_e42e358e();
}

/*
	Name: function_6577cacc
	Namespace: namespace_565e073b
	Checksum: 0x30462EE3
	Offset: 0xEA8
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function function_6577cacc()
{
	level endon(#"end_game");
	self endon(#"death", #"hash_668824b34b3076bc");
	if(!isdefined(self.var_36a93d1))
	{
		self.var_36a93d1 = 0;
	}
	while(true)
	{
		wait(1);
		self.var_36a93d1++;
		var_24e0e73d = 15;
		if(self.var_36a93d1 >= var_24e0e73d)
		{
			waitframe(1);
			self thread function_9364acc1();
			self.var_36a93d1 = 0;
			return;
		}
	}
}

/*
	Name: function_9364acc1
	Namespace: namespace_565e073b
	Checksum: 0x7FF8F4D7
	Offset: 0xF70
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function function_9364acc1()
{
	self endon_callback(&namespace_18db89ed::function_c64292f, #"death");
	self.var_7dc2d507 = 1;
	self notify(#"player_frozen");
	self namespace_18db89ed::function_bad6907c();
	self clientfield::set("" + #"hash_55543319943057f1", 1);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 1);
	var_1d3683e1 = spawn("trigger_damage", self.origin, 0, 15, 72);
	var_1d3683e1 enablelinkto();
	var_1d3683e1 linkto(self);
	self.var_1d3683e1 = var_1d3683e1;
	self thread namespace_18db89ed::function_872ec0b2(var_1d3683e1);
	self thread namespace_18db89ed::function_6cadbaff();
	if(self.var_d844486 !== 1)
	{
		self thread zm_equipment::show_hint_text(#"hash_4b6950ec49c7e04c", 3);
		self.var_d844486 = 1;
	}
	self waittill(#"hash_53bfad7081c69dee");
	self playsound(#"hash_2f8c9575cb36a298");
	self.var_7dc2d507 = 0;
	self namespace_18db89ed::function_46c3bbf7();
	self clientfield::set("" + #"hash_55543319943057f1", 0);
	self clientfield::set_to_player("" + #"hash_5160727729fd57a2", 0);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
	waitframe(2);
	self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);
	if(isdefined(var_1d3683e1))
	{
		var_1d3683e1 delete();
		self.var_1d3683e1 = undefined;
	}
	self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
	waitframe(2);
	self thread function_e42e358e();
}

