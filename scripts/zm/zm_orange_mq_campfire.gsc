// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_orange_mq_campfire;

/*
	Name: preload
	Namespace: zm_orange_mq_campfire
	Checksum: 0x80F724D1
	Offset: 0x1A0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function preload()
{
}

/*
	Name: main
	Namespace: zm_orange_mq_campfire
	Checksum: 0x9CD7167E
	Offset: 0x1B0
	Size: 0x15A
	Parameters: 0
	Flags: Linked
*/
function main()
{
	level flag::init(#"hash_e8247a060147428");
	level flag::init(#"hash_43c116bdb3a96e16");
	exploder::exploder("fxexp_narr_campfire");
	level.var_f1907c72 = struct::get("mq_narrative_campfire_loc", "targetname");
	level.var_f1907c72.vessel = getent(level.var_f1907c72.target2, "targetname");
	level.var_f1907c72.fire = getent(level.var_f1907c72.target3, "targetname");
	level.var_f1907c72.vessel hide();
	level.var_f1907c72 zm_unitrigger::create("", 64);
	level.var_96eedc2a = 1;
	level.var_80c25d0a = 1;
}

/*
	Name: function_13dda28a
	Namespace: zm_orange_mq_campfire
	Checksum: 0x7DF324
	Offset: 0x318
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_13dda28a(var_5ea5c94d)
{
	if(!var_5ea5c94d)
	{
		level notify(#"hash_50b21267cdd893be");
		level flag::clear(#"hash_43c116bdb3a96e16");
		level.var_f1907c72 thread function_561d9cff();
		level waittill(#"hash_e8247a060147428");
		level waittill(#"hash_43c116bdb3a96e16");
	}
}

/*
	Name: function_a874e5d0
	Namespace: zm_orange_mq_campfire
	Checksum: 0x41D83BD9
	Offset: 0x3B8
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function function_a874e5d0(var_5ea5c94d, ended_early)
{
	if(var_5ea5c94d || ended_early)
	{
		level notify(#"hash_18c97556779d2ace");
		level.var_f1907c72.vessel hide();
		level.var_f1907c72.vessel clientfield::set("" + #"hash_1b72c208f2964e24", 0);
	}
	level notify(#"hash_1f0238cda598f6e9");
	level.var_96eedc2a++;
	if(level.var_96eedc2a >= 4)
	{
		level flag::set(#"hash_18b94410e3b6b0bf");
	}
	level.var_f1907c72 thread function_1ad84248();
}

/*
	Name: function_1ad84248
	Namespace: zm_orange_mq_campfire
	Checksum: 0xB6B28BBA
	Offset: 0x4C8
	Size: 0x436
	Parameters: 0
	Flags: Linked
*/
function function_1ad84248()
{
	level endon(#"end_game", #"hash_50b21267cdd893be");
	switch(level.var_96eedc2a)
	{
		case 3:
		{
			level.var_80c25d0a = 3;
			break;
		}
		case 4:
		{
			level.var_80c25d0a = 5;
			break;
		}
	}
	while(true)
	{
		self waittill(#"trigger_activated");
		story = #"";
		switch(level.var_80c25d0a)
		{
			case 1:
			{
				story = #"hash_416ddb9315ab3501";
				break;
			}
			case 2:
			{
				story = #"hash_413ddfbab7b3a95a";
				break;
			}
			case 3:
			{
				story = #"hash_53a36973514df1fd";
				break;
			}
			case 4:
			{
				story = #"hash_39fc90dd61a2e104";
				break;
			}
			case 5:
			{
				story = #"hash_1470aa1d4389dd44";
				break;
			}
			case 6:
			{
				story = #"hash_261241a6b2301317";
				break;
			}
		}
		if(level.var_80c25d0a < 7)
		{
			/#
				if(getdvarint(#"zm_debug_ee", 0))
				{
					if(getdvarint(#"zm_debug_ee", 0))
					{
						iprintlnbold("" + function_9e72a96(story));
						println("" + function_9e72a96(story));
					}
				}
			#/
			n_wait = float(soundgetplaybacktime(story)) / 1000;
			self.vessel.story = story;
			self.vessel playsound(story);
			wait(n_wait);
			if(level.var_80c25d0a === 2 || level.var_80c25d0a === 4 || level.var_80c25d0a === 6)
			{
				level.var_80c25d0a = 115;
			}
			level.var_80c25d0a++;
		}
		else if(level.var_96eedc2a >= 4 && level.var_80c25d0a >= 115 && level flag::get(#"hash_18b94410e3b6b0bf"))
		{
			var_76f4999d = "mus_campfire_sing_for_my_supper";
			n_wait = float(soundgetplaybacktime(var_76f4999d)) / 1000;
			self.vessel.story = var_76f4999d;
			self.vessel playsound(var_76f4999d);
			wait(n_wait);
			level.var_80c25d0a = 99;
		}
	}
}

/*
	Name: function_561d9cff
	Namespace: zm_orange_mq_campfire
	Checksum: 0x8CA7C505
	Offset: 0x908
	Size: 0x5DC
	Parameters: 0
	Flags: Linked
*/
function function_561d9cff()
{
	level endon(#"end_game", #"hash_18c97556779d2ace");
	if(level.var_96eedc2a > 1)
	{
		self.vessel setmodel("p8_zm_ora_elemental_vessel");
	}
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("");
				println("");
			}
		}
	#/
	self waittill(#"trigger_activated");
	self.vessel show();
	if(isdefined(self.vessel.story))
	{
		self.vessel stopsound(self.vessel.story);
	}
	self.vessel playsound("zmb_vessel_drop");
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", level.var_ed1e7d4d);
	self.vessel thread function_af39e9d5();
	self waittill(#"music_box");
	level flag::set(#"hash_621d31a87bd6d05b");
	level flag::set(#"hash_e8247a060147428");
	exploder::stop_exploder("fxexp_narr_campfire");
	exploder::exploder("fxexp_narr_campfire_blue");
	zm_hms_util::function_314447b(1, 1);
	level flag::set(#"hold_round_end");
	level.sndvoxoverride = 1;
	wait(5);
	story = #"";
	switch(level.var_96eedc2a)
	{
		case 1:
		{
			story = #"hash_11249122ea4664c1";
			break;
		}
		case 2:
		{
			story = #"hash_8cd5544966d910";
			break;
		}
		case 3:
		{
			story = #"hash_375451a6e54ce91";
			break;
		}
	}
	/#
		if(getdvarint(#"zm_debug_ee", 0))
		{
			if(getdvarint(#"zm_debug_ee", 0))
			{
				iprintlnbold("" + function_9e72a96(story));
				println("" + function_9e72a96(story));
			}
		}
	#/
	n_wait = float(soundgetplaybacktime(story)) / 1000;
	self.vessel playsound(story);
	wait(n_wait);
	level.sndvoxoverride = undefined;
	level flag::clear(#"hold_round_end");
	zm_hms_util::function_314447b(0);
	exploder::stop_exploder("fxexp_narr_campfire_blue");
	exploder::exploder("fxexp_narr_campfire");
	level flag::clear(#"hash_e8247a060147428");
	s_result = undefined;
	s_result = self waittill(#"trigger_activated");
	e_who = s_result.e_who;
	if(level.var_96eedc2a === 2)
	{
		e_who thread zm_orange_util::function_51b752a9(#"hash_6f774fe92d5d01b6", -1, 1, 0);
	}
	self.vessel hide();
	self.vessel playsound("zmb_vessel_pickup");
	self.vessel clientfield::set("" + #"hash_1b72c208f2964e24", 0);
	level flag::set(#"hash_43c116bdb3a96e16");
}

/*
	Name: function_af39e9d5
	Namespace: zm_orange_mq_campfire
	Checksum: 0xA1D434F
	Offset: 0xEF0
	Size: 0x170
	Parameters: 0
	Flags: Linked
*/
function function_af39e9d5()
{
	level endon(#"end_game", #"hash_18c97556779d2ace");
	var_a28e7c1f = self.origin + vectorscale((0, 0, 1), 2);
	var_ae661658 = self.origin - vectorscale((0, 0, 1), 2);
	var_4814cac6 = 1;
	while(!level flag::get(#"hash_43c116bdb3a96e16"))
	{
		if(var_4814cac6)
		{
			self moveto(var_a28e7c1f, 2, 1, 1);
		}
		else
		{
			self moveto(var_ae661658, 2, 1, 1);
		}
		self rotatevelocity(vectorscale((0, 1, 0), 8), 4);
		self waittill(#"movedone");
		var_4814cac6 = !var_4814cac6;
	}
}

