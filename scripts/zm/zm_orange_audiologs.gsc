// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1c72973fb240f263;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_audiologs;

/*
	Name: preload
	Namespace: zm_orange_audiologs
	Checksum: 0x3FE52FCF
	Offset: 0x1A0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function preload()
{
	clientfield::register("scriptmover", "" + #"hash_4a18e1ea1950215d", 24000, 1, "int");
}

/*
	Name: init
	Namespace: zm_orange_audiologs
	Checksum: 0xBD1E043C
	Offset: 0x1F0
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.s_audiologs = spawnstruct();
	if(zm_utility::function_e51dc2d8())
	{
		function_79c97f32();
		function_d6fec498();
		function_ecba80df();
		function_922ff46a();
		function_71ecfbb2();
	}
}

/*
	Name: function_79c97f32
	Namespace: zm_orange_audiologs
	Checksum: 0xD22B8EAC
	Offset: 0x288
	Size: 0x244
	Parameters: 0
	Flags: Linked
*/
function function_79c97f32()
{
	level.s_audiologs.var_c9f26594 = spawnstruct();
	level.s_audiologs.var_c9f26594.n_collected = 0;
	level.s_audiologs.var_c9f26594.n_played = 0;
	level.s_audiologs.var_c9f26594.var_7f4f65e6 = array(#"hash_30b1f52eee1181a1", #"hash_30b1f22eee117c88", #"hash_30b1f32eee117e3b", #"hash_30b1f82eee1186ba", #"hash_15353a598abe2499");
	var_f9d547ec = getentarray("audiolog_record", "targetname");
	array::run_all(var_f9d547ec, &namespace_2e9c09b3::function_f1827cc6, &pickup_record, "", undefined, 96);
	level.s_audiologs.var_c9f26594.s_playback = struct::get("audiolog_record_player");
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 = getent(level.s_audiologs.var_c9f26594.s_playback.target, "targetname");
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 hide();
	level.s_audiologs.var_c9f26594.s_playback zm_unitrigger::create(&function_4164ac1d);
	level.s_audiologs.var_c9f26594.s_playback thread function_aef698f1();
}

/*
	Name: pickup_record
	Namespace: zm_orange_audiologs
	Checksum: 0x4EF37F4C
	Offset: 0x4D8
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function pickup_record(e_item, e_player)
{
	/#
		iprintln("" + level.s_audiologs.var_c9f26594.n_collected);
	#/
	e_item playsound(#"hash_760800881cd94dd1");
	level.s_audiologs.var_c9f26594.n_collected++;
}

/*
	Name: function_6ad87fb1
	Namespace: zm_orange_audiologs
	Checksum: 0xBE327BB
	Offset: 0x568
	Size: 0x18C
	Parameters: 0
	Flags: Linked
*/
function function_6ad87fb1()
{
	self endon(#"death");
	n_id = level.s_audiologs.var_c9f26594.n_played;
	level.s_audiologs.var_c9f26594.n_played++;
	/#
		iprintln("" + n_id);
	#/
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 show();
	wait(1);
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 rotatevelocity(vectorscale((0, 1, 0), 200), 600);
	zm_hms_util::function_e308175e(level.s_audiologs.var_c9f26594.var_7f4f65e6[n_id], self.origin);
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 rotatevelocity(vectorscale((0, 1, 0), 200), 1);
	wait(2);
	level.s_audiologs.var_c9f26594.var_d9a8e3e4 hide();
}

/*
	Name: function_4164ac1d
	Namespace: zm_orange_audiologs
	Checksum: 0xE7631ADC
	Offset: 0x700
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_4164ac1d(e_player)
{
	return level.s_audiologs.var_c9f26594.n_collected > level.s_audiologs.var_c9f26594.n_played;
}

/*
	Name: function_aef698f1
	Namespace: zm_orange_audiologs
	Checksum: 0x862F04BF
	Offset: 0x748
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_aef698f1()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger_activated");
		self function_6ad87fb1();
	}
}

/*
	Name: function_d6fec498
	Namespace: zm_orange_audiologs
	Checksum: 0x8E371CA5
	Offset: 0x798
	Size: 0x1DC
	Parameters: 0
	Flags: Linked
*/
function function_d6fec498()
{
	level.s_audiologs.s_reels = spawnstruct();
	level.s_audiologs.s_reels.n_collected = 0;
	level.s_audiologs.s_reels.n_played = 0;
	level.s_audiologs.s_reels.var_7f4f65e6 = array(#"hash_6fce75e5c4fe6210", #"hash_172aa60779a37741", #"hash_2388426b6c075d62", #"hash_1a1854072d6b2453", #"hash_23883c6b6c075330", #"hash_23883f6b6c075849");
	var_d1c55c66 = getentarray("audiolog_reel", "targetname");
	array::run_all(var_d1c55c66, &namespace_2e9c09b3::function_f1827cc6, &function_4a7ac7a6, "", undefined, 96);
	level.s_audiologs.s_reels.s_playback = struct::get("audiolog_reel_player");
	level.s_audiologs.s_reels.s_playback zm_unitrigger::create(&function_90b10d7);
	level.s_audiologs.s_reels.s_playback thread function_62fea2fe();
}

/*
	Name: function_4a7ac7a6
	Namespace: zm_orange_audiologs
	Checksum: 0xB4FE3EA6
	Offset: 0x980
	Size: 0x88
	Parameters: 2
	Flags: Linked
*/
function function_4a7ac7a6(e_item, e_player)
{
	/#
		iprintln("" + level.s_audiologs.s_reels.n_collected);
	#/
	e_item playsound(#"hash_760800881cd94dd1");
	level.s_audiologs.s_reels.n_collected++;
}

/*
	Name: doa_streak_udem
	Namespace: zm_orange_audiologs
	Checksum: 0x85841818
	Offset: 0xA10
	Size: 0x114
	Parameters: 0
	Flags: Linked
*/
function doa_streak_udem()
{
	self endon(#"death");
	n_id = level.s_audiologs.s_reels.n_played;
	level.s_audiologs.s_reels.n_played++;
	/#
		iprintln("" + n_id);
	#/
	exploder::exploder("fxexp_script_projector_off");
	exploder::exploder("fxexp_script_projector_on");
	zm_hms_util::function_e308175e(level.s_audiologs.s_reels.var_7f4f65e6[n_id], self.origin);
	exploder::stop_exploder("fxexp_script_projector_off");
	exploder::stop_exploder("fxexp_script_projector_on");
}

/*
	Name: function_90b10d7
	Namespace: zm_orange_audiologs
	Checksum: 0x12E12F5D
	Offset: 0xB30
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function function_90b10d7(e_player)
{
	return level.s_audiologs.s_reels.n_collected > level.s_audiologs.s_reels.n_played;
}

/*
	Name: function_62fea2fe
	Namespace: zm_orange_audiologs
	Checksum: 0x5447CB96
	Offset: 0xB78
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_62fea2fe()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger_activated");
		self doa_streak_udem();
	}
}

/*
	Name: function_ecba80df
	Namespace: zm_orange_audiologs
	Checksum: 0x207E232D
	Offset: 0xBC8
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_ecba80df()
{
	level.s_audiologs.var_29f70993 = array(#"hash_4e502bf48420789b", #"hash_36a4134f1eed7a5e", #"hash_36a4144f1eed7c11", #"hash_3b6e2bba7d44fa78", #"hash_45a63a79ad46af7");
	var_311159c3 = getentarray("audiolog_russian", "targetname");
	array::run_all(var_311159c3, &zm_unitrigger::create, "", 96);
	array::thread_all(var_311159c3, &function_4a547e41);
}

/*
	Name: function_4a547e41
	Namespace: zm_orange_audiologs
	Checksum: 0x9AAA5468
	Offset: 0xCC0
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_4a547e41()
{
	self endon(#"death");
	self hidepart("tag_light");
	self waittill(#"trigger_activated");
	/#
		iprintln("" + self.script_int);
	#/
	self showpart("tag_light");
	self zm_hms_util::function_e308175e(level.s_audiologs.var_29f70993[self.script_int], self.origin);
	self hidepart("tag_light");
}

/*
	Name: function_922ff46a
	Namespace: zm_orange_audiologs
	Checksum: 0x4E997C16
	Offset: 0xDB8
	Size: 0xE4
	Parameters: 0
	Flags: Linked
*/
function function_922ff46a()
{
	level.s_audiologs.var_bc136840 = array(#"hash_5f4b3985abc17212", #"hash_5f4b3885abc1705f", #"hash_5f4b3785abc16eac", #"hash_5f4b3685abc16cf9", #"hash_5f4b3585abc16b46");
	var_b41e84c = struct::get_array("audiolog_pablo");
	array::run_all(var_b41e84c, &zm_unitrigger::create, "", 96);
	array::thread_all(var_b41e84c, &function_a8be9b98);
}

/*
	Name: function_a8be9b98
	Namespace: zm_orange_audiologs
	Checksum: 0x18528F9
	Offset: 0xEA8
	Size: 0xDC
	Parameters: 0
	Flags: Linked
*/
function function_a8be9b98()
{
	self endon(#"death");
	self waittill(#"trigger_activated");
	/#
		iprintln("" + self.script_int);
	#/
	s_scene = struct::get(self.target);
	s_scene thread scene::play();
	self zm_hms_util::function_e308175e(level.s_audiologs.var_bc136840[self.script_int], self.origin);
	s_scene thread scene::stop();
}

/*
	Name: function_71ecfbb2
	Namespace: zm_orange_audiologs
	Checksum: 0xAE4ECC96
	Offset: 0xF90
	Size: 0xAC
	Parameters: 0
	Flags: Linked
*/
function function_71ecfbb2()
{
	level.s_audiologs.var_7ab3422d = array(#"hash_60d74e6165b011e6", #"hash_60d74d6165b01033", #"hash_60d74c6165b00e80", #"hash_60d7536165b01a65");
	var_b682d2ea = getentarray("audiolog_orb", "targetname");
	array::run_all(var_b682d2ea, &setup_orb);
}

/*
	Name: setup_orb
	Namespace: zm_orange_audiologs
	Checksum: 0x3BA99C8A
	Offset: 0x1048
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function setup_orb()
{
	self setcandamage(1);
	self.allowdeath = 0;
	self thread function_530a6195();
	self clientfield::set("" + #"hash_4a18e1ea1950215d", 1);
}

/*
	Name: function_530a6195
	Namespace: zm_orange_audiologs
	Checksum: 0xBFBA48F3
	Offset: 0x10C0
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_530a6195()
{
	self endon(#"death");
	self waittill(#"damage");
	self setcandamage(0);
	self.allowdeath = 1;
	/#
		iprintln("" + self.script_int);
	#/
	self zm_hms_util::function_e308175e(level.s_audiologs.var_7ab3422d[self.script_int], self.origin);
	self delete();
}

