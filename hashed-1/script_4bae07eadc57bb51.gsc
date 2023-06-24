// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\zm\zm_office_teleporters.gsc;
#using scripts\zm\zm_office_defcon.gsc;
#using script_1c72973fb240f263;
#using scripts\core_common\ai\zombie_utility.gsc;
#using scripts\zm_common\zm_items.gsc;
#using scripts\zm_common\zm_crafting.gsc;
#using scripts\zm_common\zm_ui_inventory.gsc;
#using script_59a783d756554a80;
#using scripts\zm_common\zm_vo.gsc;
#using scripts\zm\zm_hms_util.gsc;
#using scripts\zm_common\zm_sq.gsc;
#using scripts\zm_common\zm_customgame.gsc;
#using scripts\zm\zm_office_floors.gsc;
#using script_ab862743b3070a;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm\zm_office_zones.gsc;
#using scripts\zm_common\callbacks.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_blockers.gsc;
#using scripts\zm_common\zm_powerups.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_a5657ff1;

/*
	Name: init
	Namespace: namespace_a5657ff1
	Checksum: 0x494FFF0A
	Offset: 0x340
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function init()
{
	init_flags();
	function_ec9e5cf2();
}

/*
	Name: init_flags
	Namespace: namespace_a5657ff1
	Checksum: 0xC7BEFB70
	Offset: 0x370
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function init_flags()
{
	level flag::init(#"hash_774b069a64b060b");
	level flag::init(#"hash_381e771ed6c80ccb");
	level flag::init(#"hash_38f45c699c5d5d63");
	level flag::init(#"hash_26e9fe6561459de3");
	level flag::init(#"hash_537cc10c9deca9da");
}

/*
	Name: function_ec9e5cf2
	Namespace: namespace_a5657ff1
	Checksum: 0xFE802127
	Offset: 0x420
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_ec9e5cf2()
{
	level thread function_b540b576();
	function_46d6aa5a();
	if(zm_utility::function_e51dc2d8())
	{
		function_71112c33();
	}
}

/*
	Name: function_b540b576
	Namespace: namespace_a5657ff1
	Checksum: 0x2C7841A7
	Offset: 0x480
	Size: 0x494
	Parameters: 0
	Flags: Linked
*/
function function_b540b576()
{
	level.var_5849269a = [];
	var_1c8e90b4 = array(#"hash_7d77026116381bc8");
	var_ab6a16ff = array(#"hash_2511d5011d40cbd2");
	var_e6c1fe70 = array(#"hash_85c1a5d874f4cca", #"hash_6ba76f0dae639fda", #"hash_3cf4fec50390cfc4", #"hash_7dedea74983affc4", #"hash_1c38fdc40339b86e", #"hash_704a6e82a159cc1e", #"hash_3b5addc029eb24b8", #"hash_5f090d187dae1178", #"hash_75901c4c2a6309e2");
	var_51ba7b4a = array(#"hash_79fe2d0224018f5c");
	var_68e586cf = array(#"hash_2b4e25f8eaed9341");
	level.var_5849269a[0] = {#vo_line:var_1c8e90b4, #hash_85f707f6:0};
	level.var_5849269a[1] = {#vo_line:var_ab6a16ff, #hash_85f707f6:0};
	level.var_5849269a[2] = {#hash_46db68fd:1, #vo_line:var_e6c1fe70, #hash_85f707f6:0};
	level.var_5849269a[3] = {#vo_line:var_51ba7b4a, #hash_85f707f6:0};
	level.var_5849269a[4] = {#vo_line:var_68e586cf, #hash_85f707f6:0};
	level.var_e046b238 = struct::get(#"hash_5201d44a6f57e32a");
	level.var_94b00cff = spawn("script_model", level.var_e046b238.origin);
	level.var_ba07f1de = zm_hms_util::function_bffcedde("office_audio_reel", "targetname", "script_int");
	level.var_804a56e3 = 0;
	foreach(var_2e2b46e8 in level.var_ba07f1de)
	{
		var_2e2b46e8 namespace_2e9c09b3::function_e8661563(&function_1792ae3, 1);
	}
	screen_a = getent("projecter_screen_a", "targetname");
	screen_b = getent("projecter_screen_b", "targetname");
	screen_a show();
	screen_b hide();
	if(zm_utility::function_e51dc2d8())
	{
		s_unitrigger = level.var_e046b238 zm_unitrigger::create(&function_6fb01110, 64, &function_aa07edab);
		s_unitrigger thread function_8352562a();
	}
}

/*
	Name: function_1792ae3
	Namespace: namespace_a5657ff1
	Checksum: 0xC2207F42
	Offset: 0x920
	Size: 0xD0
	Parameters: 1
	Flags: Linked
*/
function function_1792ae3(e_item)
{
	s_reel = level.var_5849269a[level.var_804a56e3];
	if(isdefined(s_reel))
	{
		s_reel.var_85f707f6 = 1;
		str_alias = (#"hash_3b57b74e2c90aee5" + (level.var_804a56e3 + 1)) + "_pickup";
		self thread zm_vo::function_a2bd5a0c(str_alias);
		if(isdefined(e_item))
		{
			e_item playsound(#"hash_760800881cd94dd1");
		}
		function_f370d99();
		level.var_804a56e3++;
	}
}

/*
	Name: function_6fb01110
	Namespace: namespace_a5657ff1
	Checksum: 0xAA676689
	Offset: 0x9F8
	Size: 0x98
	Parameters: 1
	Flags: Linked
*/
function function_6fb01110(player)
{
	if(self.stub.in_use === 1)
	{
		return false;
	}
	if(!isdefined(level.var_b63bccb7))
	{
		return false;
	}
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_6d85deef99bf45a0");
	}
	else
	{
		self sethintstring(#"hash_3d0bedfa0fcd62c");
	}
	return true;
}

/*
	Name: function_f370d99
	Namespace: namespace_a5657ff1
	Checksum: 0x57D30129
	Offset: 0xA98
	Size: 0x70
	Parameters: 0
	Flags: Linked
*/
function function_f370d99()
{
	level.var_b63bccb7 = undefined;
	for(i = 0; i < level.var_5849269a.size; i++)
	{
		if(level.var_5849269a[i].var_85f707f6)
		{
			level.var_b63bccb7 = level.var_5849269a[i];
			break;
		}
	}
}

/*
	Name: function_aa07edab
	Namespace: namespace_a5657ff1
	Checksum: 0x4578C96
	Offset: 0xB10
	Size: 0x50
	Parameters: 0
	Flags: Linked
*/
function function_aa07edab()
{
	self endon(#"death");
	while(true)
	{
		self waittill(#"trigger");
		self.stub notify(#"play_audio");
	}
}

/*
	Name: function_8352562a
	Namespace: namespace_a5657ff1
	Checksum: 0xF19E4F47
	Offset: 0xB68
	Size: 0x31C
	Parameters: 0
	Flags: Linked
*/
function function_8352562a()
{
	self endon(#"death");
	var_e578920c = 0;
	screen_a = getent("projecter_screen_a", "targetname");
	screen_b = getent("projecter_screen_b", "targetname");
	while(true)
	{
		self waittill(#"play_audio");
		screen_b show();
		screen_a hide();
		exploder::stop_exploder("fxexp_script_projector_off");
		exploder::exploder("fxexp_script_projector_on");
		level.var_94b00cff playsound(#"hash_7f70f5f71963f7f2");
		if(isdefined(level.var_b63bccb7))
		{
			s_log = level.var_b63bccb7;
			self.in_use = 1;
			s_log.var_85f707f6 = 0;
			function_f370d99();
			level.var_94b00cff playsound(#"hash_50cae5e74f332b7c");
			if(s_log.var_46db68fd === 1)
			{
				level.var_94b00cff playloopsound(#"hash_1e451b58f18190b4");
			}
			else
			{
				level.var_94b00cff playloopsound(#"hash_48cebe2e9cc70ddc");
			}
			wait(2);
			zm_hms_util::function_52c3fe8d(s_log.vo_line, level.var_94b00cff.origin);
			var_e578920c++;
			level.var_94b00cff stoploopsound();
			level.var_94b00cff playsound(#"hash_1f5fc24563134758");
			screen_a show();
			screen_b hide();
			exploder::stop_exploder("fxexp_script_projector_on");
			exploder::exploder("fxexp_script_projector_off");
			if(var_e578920c < 5)
			{
				self.in_use = 0;
			}
			else
			{
				wait(0.1);
				break;
			}
		}
	}
	zm_unitrigger::unregister_unitrigger(self);
}

/*
	Name: function_71112c33
	Namespace: namespace_a5657ff1
	Checksum: 0xEF4800F4
	Offset: 0xE90
	Size: 0x678
	Parameters: 0
	Flags: Linked
*/
function function_71112c33()
{
	if(!isdefined(level.var_a89ec78a))
	{
		level.var_a89ec78a = [];
	}
	else if(!isarray(level.var_a89ec78a))
	{
		level.var_a89ec78a = array(level.var_a89ec78a);
	}
	level.var_a89ec78a[0] = array(#"hash_3d769c51f11a9278", #"hash_56f29442af55b640", #"hash_4eb7fdbc14c64d1e", #"hash_6a21b655a9690f06", #"hash_5c5b79ae0ba780c4", #"hash_31dd3a7abba4958c", #"hash_4a14fe4721d020da", #"hash_4435895a61014e42", #"hash_b358ff92f1fe829", #"hash_4f74d3b147409498", #"hash_1a259c1374b5f0a9", #"hash_27ae8f0ca01852cd", #"hash_4770bcb4bbb1fa3f", #"hash_52836d886c361423", #"hash_3c74f83cf8a7f59d", #"hash_69da22c03d3d1a61", #"hash_3c3acd34d062973");
	level.var_a89ec78a[1] = array(#"hash_46fcc94bcfb7182", #"hash_3d408140af3fd8eb", #"hash_2a86fa4707c787c", #"hash_5c89d1aa1c19997c", #"hash_58a04294582d6486", #"hash_7ec022aa16693c7f", #"hash_4e0da1847e272730", #"hash_7d3cca6491ddb5f0", #"hash_69f48fd3ebcfccea", #"hash_6b5b10deb16896d3", #"hash_5ffe592dfadd3935", #"hash_5dd6f186381e2cc", #"hash_188c5a17ec6e49ab", #"hash_3dfb3e8f02923a8f", #"hash_7576ea091143ce69", #"hash_d15a50c27c8442d", #"hash_a4a0dc4b6285407", #"hash_ebf2cf7a6addac3", #"hash_1224c2b6d473fe95");
	level.var_a89ec78a[2] = array(#"hash_57f8e51889f743c3", #"hash_57816dfd94b9b352", #"hash_439e7d7396867bd4", #"hash_632ef10ed2354e49", #"hash_25292058dbedb657", #"hash_3464e1361c110c93", #"hash_16da5f7943762301", #"hash_5bef1a64d1005f3d", #"hash_5fc94d78acba95c2", #"hash_bc708021d5ffe2a", #"hash_3d9e6aff21ee8707", #"hash_5b99d9fe629c6292", #"hash_74429c6a98d817f1", #"hash_45733118d0ab49fc");
	level.var_a89ec78a[3] = array(#"hash_3c81348483747d36", #"hash_38037405482765a2", #"hash_4ffb0e1f3887178c", #"hash_1f23829ad8824dcc", #"hash_226fa7aac29cddb2", #"hash_646ede7a45b7ca66", #"hash_2638b34fdd2f6c68", #"hash_595af4b9ed084900", #"hash_3c8a7ff5d0522b5e", #"hash_58fb7cdd31cf54a", #"hash_45f2c29e23ffdd2f", #"hash_179a327c774fcc09", #"hash_6ccfc362521493f1", #"hash_5e72cb2fb4e0d39f", #"hash_70badcef86b372ab");
	level.var_a89ec78a[4] = array(#"hash_62840ebed9c7874f", #"hash_5902360292a8f3da", #"hash_2d78d5727436aadc", #"hash_6b48b1697c8053c4", #"hash_1c27ba67437c3b83", #"hash_4c80779f08dfcd9a", #"hash_420b3ad6e53509ed", #"hash_4c63d40d61f36578", #"hash_ac02f6a2481256f", #"hash_25fd913716475ef2", #"hash_6fdb1c84726adddc", #"hash_4c2efd8466c4d0d1");
	level.var_62d5b9c9 = struct::get_array("office_audio_log");
	foreach(var_ac8ede2d in level.var_62d5b9c9)
	{
		var_ac8ede2d function_488e39dc();
	}
}

/*
	Name: function_488e39dc
	Namespace: namespace_a5657ff1
	Checksum: 0x5E5DD27B
	Offset: 0x1510
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function function_488e39dc()
{
	if(self.var_614bfc5c == 2)
	{
		self.var_47323b73 = self zm_unitrigger::create("", (32, 32, 64), &function_6ef57d1f);
		zm_unitrigger::function_89380dda(self.var_47323b73, 1);
	}
	else
	{
		self.var_47323b73 = self zm_unitrigger::create("", vectorscale((1, 1, 1), 32), &function_6ef57d1f);
		zm_unitrigger::function_89380dda(self.var_47323b73, 1);
	}
}

/*
	Name: function_6ef57d1f
	Namespace: namespace_a5657ff1
	Checksum: 0xDC15B5D3
	Offset: 0x15E8
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_6ef57d1f()
{
	self endon(#"death");
	self waittill(#"trigger");
	self.stub.related_parent thread function_8c80503();
}

/*
	Name: function_ed9142aa
	Namespace: namespace_a5657ff1
	Checksum: 0x19BE164E
	Offset: 0x1640
	Size: 0x68
	Parameters: 1
	Flags: None
*/
function function_ed9142aa(player)
{
	self usetriggerrequirelookat();
	self setcursorhint("HINT_NOICON");
	self sethintstring("");
	return true;
}

/*
	Name: function_8c80503
	Namespace: namespace_a5657ff1
	Checksum: 0xC3FBBBAF
	Offset: 0x16B0
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function function_8c80503()
{
	zm_unitrigger::unregister_unitrigger(self.var_47323b73);
	self thread function_d4c6dc0d();
	wait(2);
	self function_43ef7a9a(level.var_a89ec78a[self.var_614bfc5c], self.origin);
	self.is_playing_audio = 0;
}

/*
	Name: function_43ef7a9a
	Namespace: namespace_a5657ff1
	Checksum: 0xC5910661
	Offset: 0x1728
	Size: 0x146
	Parameters: 2
	Flags: Linked
*/
function function_43ef7a9a(a_audio, v_pos)
{
	for(i = 0; i < a_audio.size; i++)
	{
		var_d34b6d2b = function_b116e882(self.var_614bfc5c, i, 1);
		if(isdefined(var_d34b6d2b))
		{
			playsoundatposition(var_d34b6d2b, v_pos);
		}
		playsoundatposition(a_audio[i], v_pos);
		n_wait_time = float(soundgetplaybacktime(a_audio[i])) / 1000;
		wait(n_wait_time);
		var_d34b6d2b = function_b116e882(self.var_614bfc5c, i, 0);
		if(isdefined(var_d34b6d2b))
		{
			playsoundatposition(var_d34b6d2b, v_pos);
		}
		function_cfb5afb3(self.var_614bfc5c, i);
	}
}

/*
	Name: function_cfb5afb3
	Namespace: namespace_a5657ff1
	Checksum: 0x3DC0760
	Offset: 0x1878
	Size: 0x2E2
	Parameters: 2
	Flags: Linked
*/
function function_cfb5afb3(var_237f80b0, var_54bb7f87)
{
	n_waittime = undefined;
	switch(var_237f80b0)
	{
		case 0:
		{
			if(var_54bb7f87 == 4)
			{
				n_waittime = 0.4;
			}
			if(var_54bb7f87 == 5)
			{
				n_waittime = 2.2;
			}
			if(var_54bb7f87 == 6)
			{
				n_waittime = 0.6;
			}
			if(var_54bb7f87 == 7)
			{
				n_waittime = 1.4;
			}
			if(var_54bb7f87 == 9)
			{
				n_waittime = 2.8;
			}
			break;
		}
		case 1:
		{
			if(var_54bb7f87 == 14)
			{
				n_waittime = 5.2;
			}
			if(var_54bb7f87 == 17)
			{
				n_waittime = 5.1;
			}
			break;
		}
		case 2:
		{
			if(var_54bb7f87 == 1)
			{
				n_waittime = 4.6;
			}
			if(var_54bb7f87 == 2)
			{
				n_waittime = 0.6;
			}
			if(var_54bb7f87 == 6)
			{
				n_waittime = 3.15;
			}
			if(var_54bb7f87 == 9)
			{
				n_waittime = 0.2;
			}
			if(var_54bb7f87 == 10)
			{
				n_waittime = 0.8;
			}
			if(var_54bb7f87 == 12)
			{
				n_waittime = 0.45;
			}
			break;
		}
		case 4:
		{
			if(var_54bb7f87 == 0)
			{
				n_waittime = 0.7;
			}
			if(var_54bb7f87 == 1)
			{
				n_waittime = 0.43;
			}
			if(var_54bb7f87 == 2)
			{
				n_waittime = 0.36;
			}
			if(var_54bb7f87 == 3)
			{
				n_waittime = 13.15;
			}
			if(var_54bb7f87 == 4)
			{
				n_waittime = 2;
			}
			if(var_54bb7f87 == 5)
			{
				n_waittime = 0.37;
			}
			if(var_54bb7f87 == 6)
			{
				n_waittime = 1;
			}
			if(var_54bb7f87 == 7)
			{
				n_waittime = 0.1;
			}
			if(var_54bb7f87 == 8)
			{
				n_waittime = 0.1;
			}
			if(var_54bb7f87 == 9)
			{
				n_waittime = 9;
			}
			if(var_54bb7f87 == 10)
			{
				n_waittime = 0.62;
			}
			break;
		}
	}
	if(isdefined(n_waittime))
	{
		wait(n_waittime);
	}
	else
	{
		waitframe(1);
	}
}

/*
	Name: function_b116e882
	Namespace: namespace_a5657ff1
	Checksum: 0xB9D4D7D4
	Offset: 0x1B68
	Size: 0x2B6
	Parameters: 3
	Flags: Linked
*/
function function_b116e882(var_237f80b0, var_54bb7f87, var_5876458)
{
	var_d34b6d2b = undefined;
	if(var_5876458)
	{
		switch(var_237f80b0)
		{
			case 0:
			{
				if(var_54bb7f87 == 7)
				{
					var_d34b6d2b = #"hash_176589c86eb7168d";
				}
				if(var_54bb7f87 == 8)
				{
					var_d34b6d2b = #"hash_176588c86eb714da";
				}
				if(var_54bb7f87 == 9)
				{
					var_d34b6d2b = #"hash_176583c86eb70c5b";
				}
				break;
			}
			case 2:
			{
				if(var_54bb7f87 == 1)
				{
					var_d34b6d2b = #"hash_57ed5c4232271772";
				}
				if(var_54bb7f87 == 12)
				{
					var_d34b6d2b = #"hash_57ed594232271259";
				}
				break;
			}
			case 4:
			{
				if(var_54bb7f87 == 6)
				{
					var_d34b6d2b = #"hash_53a3ee7f09c3cdca";
				}
				break;
			}
		}
	}
	else
	{
		switch(var_237f80b0)
		{
			case 0:
			{
				if(var_54bb7f87 == 5)
				{
					var_d34b6d2b = #"hash_176586c86eb71174";
				}
				break;
			}
			case 1:
			{
				if(var_54bb7f87 == 14)
				{
					var_d34b6d2b = #"hash_74fa51b8f89d1cc1";
				}
				if(var_54bb7f87 == 17)
				{
					var_d34b6d2b = #"hash_74fa4eb8f89d17a8";
				}
				break;
			}
			case 2:
			{
				if(var_54bb7f87 == 6)
				{
					var_d34b6d2b = #"hash_57ed5b42322715bf";
				}
				if(var_54bb7f87 == 9)
				{
					var_d34b6d2b = #"hash_57ed5a423227140c";
				}
				break;
			}
			case 4:
			{
				if(var_54bb7f87 == 3)
				{
					var_d34b6d2b = #"hash_53a3eb7f09c3c8b1";
				}
				if(var_54bb7f87 == 4)
				{
					var_d34b6d2b = #"hash_53a3e87f09c3c398";
				}
				if(var_54bb7f87 == 6)
				{
					var_d34b6d2b = #"hash_53a3e97f09c3c54b";
				}
				if(var_54bb7f87 == 9)
				{
					var_d34b6d2b = #"hash_53a3ef7f09c3cf7d";
				}
				break;
			}
		}
	}
	return var_d34b6d2b;
}

/*
	Name: function_d4c6dc0d
	Namespace: namespace_a5657ff1
	Checksum: 0xADAA9E26
	Offset: 0x1E28
	Size: 0x154
	Parameters: 0
	Flags: Linked
*/
function function_d4c6dc0d()
{
	self.is_playing_audio = 1;
	var_df4e73a7 = getentarray(self.target2, "targetname");
	var_df4e73a7[0] playsound(#"hash_3cca3c060dacc7de");
	var_df4e73a7[0] playloopsound(#"hash_14cf26f9ee5a9962");
	while(self.is_playing_audio && var_df4e73a7.size > 0)
	{
		var_df4e73a7[0] rotatepitch(45, 1);
		wait(0.1);
		var_df4e73a7[1] rotatepitch(60, 1);
		wait(0.9);
	}
	var_df4e73a7[0] stoploopsound(0.5);
	playsoundatposition(#"hash_1f7edbf8f3a60766", self.origin);
}

/*
	Name: function_46d6aa5a
	Namespace: namespace_a5657ff1
	Checksum: 0x2CFE419E
	Offset: 0x1F88
	Size: 0x14C
	Parameters: 0
	Flags: Linked
*/
function function_46d6aa5a()
{
	zm_crafting::function_d1f16587(#"hash_58657b32591bdb79", &function_2767c5d7);
	level.var_2de08508 = getent("trigger_modify_teleporter_use", "targetname");
	level.var_2de08508 thread function_a27356f6();
	if(!zm_utility::is_standard())
	{
		zm_items::function_4d230236(getweapon(#"hash_46a10de5f2b5c030"), &function_2cfc0c77);
		zm_items::function_4d230236(getweapon(#"hash_46a110e5f2b5c549"), &function_2cfc0c77);
		zm_items::function_4d230236(getweapon(#"hash_46a10fe5f2b5c396"), &function_2cfc0c77);
	}
}

/*
	Name: function_2767c5d7
	Namespace: namespace_a5657ff1
	Checksum: 0xFF1D294D
	Offset: 0x20E0
	Size: 0x146
	Parameters: 1
	Flags: Linked
*/
function function_2767c5d7(e_player)
{
	if(isdefined(self.stub) && isdefined(self.stub.blueprint))
	{
		t_crafting = self.stub;
	}
	else if(isdefined(self.blueprint))
	{
		t_crafting = self;
	}
	if(t_crafting.blueprint.name == #"hash_6ab8e8ea32e97a22")
	{
		t_crafting.var_4f749ffe show();
		if(function_8b1a219a())
		{
			level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_36ff79a9f968a5ee", 64, &function_73e06b11);
		}
		else
		{
			level.var_279a11a3 = self.stub.var_4f749ffe zm_unitrigger::create(#"hash_7103e08d3e6bf1aa", 64, &function_73e06b11);
		}
	}
}

/*
	Name: function_73e06b11
	Namespace: namespace_a5657ff1
	Checksum: 0xB9D5B752
	Offset: 0x2230
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function function_73e06b11()
{
	self waittill(#"trigger");
	function_80df67ff();
}

/*
	Name: function_80df67ff
	Namespace: namespace_a5657ff1
	Checksum: 0x8CF1588D
	Offset: 0x2268
	Size: 0x74
	Parameters: 0
	Flags: Linked
*/
function function_80df67ff()
{
	level notify(#"modifier_acquired");
	self playsound(#"hash_104670ec9247d6c");
	level.var_279a11a3.related_parent setinvisibletoall();
	zm_unitrigger::unregister_unitrigger(level.var_279a11a3);
}

/*
	Name: function_a27356f6
	Namespace: namespace_a5657ff1
	Checksum: 0x4E045E9E
	Offset: 0x22E8
	Size: 0x174
	Parameters: 0
	Flags: Linked
*/
function function_a27356f6()
{
	self triggerenable(0);
	level waittill(#"modifier_acquired");
	self triggerenable(1);
	self usetriggerrequirelookat();
	self setcursorhint("HINT_NOICON");
	if(function_8b1a219a())
	{
		self sethintstring(#"hash_6ff8d3f3a8d96c2a");
	}
	else
	{
		self sethintstring(#"hash_4f0f148274f0dd3e");
	}
	waitresult = undefined;
	waitresult = self waittill(#"trigger");
	waitresult.activator thread zm_vo::function_a2bd5a0c(#"hash_7e0df5eda50fd3f3");
	self sethintstring("");
	self triggerenable(0);
	function_d1cfd44();
}

/*
	Name: function_d1cfd44
	Namespace: namespace_a5657ff1
	Checksum: 0xC66A0554
	Offset: 0x2468
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_d1cfd44()
{
	thread function_7f4bdad3();
	enable_groom_lake();
}

/*
	Name: function_7f4bdad3
	Namespace: namespace_a5657ff1
	Checksum: 0xFF4D5D0B
	Offset: 0x2498
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_7f4bdad3()
{
	thread zm_office_teleporters::function_884a609e();
	s_org = struct::get("telporter_modifier_model_org", "targetname");
	var_81479e04 = spawn("script_model", s_org.origin);
	var_81479e04 setmodel("p8_zm_off_teleporter_together");
	playsoundatposition(#"hash_4490540f4d90c6dd", var_81479e04.origin);
}

/*
	Name: enable_groom_lake
	Namespace: namespace_a5657ff1
	Checksum: 0xE491C634
	Offset: 0x2558
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function enable_groom_lake()
{
	level flag::set(#"hash_381e771ed6c80ccb");
	level flag::set(#"hash_38f45c699c5d5d63");
	level thread zm_office_teleporters::function_bb3f9afd();
	level thread function_8213feb8();
	function_5e893125();
	/#
		iprintlnbold("");
	#/
}

/*
	Name: function_8213feb8
	Namespace: namespace_a5657ff1
	Checksum: 0x986D65F2
	Offset: 0x2608
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_8213feb8()
{
	level waittill(#"hash_15a9f7117b9637b");
	if(level flag::get(#"hash_537cc10c9deca9da"))
	{
		zm_office_zones::function_cada51b5(1);
	}
	else
	{
		level flag::set(#"hash_537cc10c9deca9da");
	}
	while(zm_office_floors::function_df2506d3(4).size < 1)
	{
		wait(1);
	}
	level thread zm_office_defcon::start_defcon_countdown();
	callback::on_ai_spawned(&function_db17af3a);
	level notify(#"hash_253a424c838fcd19");
	function_22537270();
	wait(30);
	zm_office_teleporters::enable_cage_portal(1);
	level thread function_43d7897e();
}

/*
	Name: function_43d7897e
	Namespace: namespace_a5657ff1
	Checksum: 0x9B05B7FC
	Offset: 0x2750
	Size: 0x224
	Parameters: 0
	Flags: Linked
*/
function function_43d7897e()
{
	level endon(#"hash_4a19fd40add44b83");
	b_waiting = 1;
	while(b_waiting)
	{
		foreach(e_player in level.activeplayers)
		{
			if(zm_utility::is_player_valid(e_player, 0, 1) && zm_office_floors::function_35babccd(e_player) != 4)
			{
				b_waiting = 0;
				break;
			}
		}
		if(b_waiting)
		{
			wait(1);
		}
	}
	level thread function_9209d032();
	exploder::exploder("fx_exp_teleporter_hangar_warmup");
	wait(30);
	exploder::stop_exploder("fx_exp_teleporter_hangar_warmup");
	exploder::exploder("fx_exp_teleporter_hangar_shockwave");
	zm_office_teleporters::enable_cage_portal(0);
	a_e_players = zm_office_floors::function_df2506d3(4);
	foreach(e_player in a_e_players)
	{
		e_player thread zm_office_teleporters::function_1bf7bc9e();
	}
	wait(3);
	if(a_e_players.size > 0)
	{
		level thread namespace_8f53e87b::function_8cbb1711();
	}
}

/*
	Name: function_9209d032
	Namespace: namespace_a5657ff1
	Checksum: 0x21A6ACBA
	Offset: 0x2980
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function function_9209d032()
{
	while(zm_office_floors::function_df2506d3(4).size > 0)
	{
		wait(1);
	}
	level notify(#"hash_4a19fd40add44b83");
	zm_office_zones::function_cada51b5(0);
	zm_office_teleporters::enable_cage_portal(0);
	exploder::stop_exploder("fx_exp_teleporter_hangar_warmup");
	level.var_a23b5c5.origin = level.var_a23b5c5.v_start_pos;
	callback::remove_on_ai_spawned(&function_db17af3a);
	function_275db54d();
	level thread function_8213feb8();
}

/*
	Name: function_db17af3a
	Namespace: namespace_a5657ff1
	Checksum: 0x105D0BD8
	Offset: 0x2A78
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function function_db17af3a()
{
	self endon(#"death");
	n_timer = 0;
	while(n_timer < 1)
	{
		if(zm_office_floors::function_9dd97963(self))
		{
			var_8c6394e3 = self zombie_utility::function_33da7a07();
			if(var_8c6394e3 == "walk" || var_8c6394e3 == "run")
			{
				self zombie_utility::set_zombie_run_cycle("sprint");
			}
			break;
		}
		wait(0.1);
		n_timer = n_timer + 0.1;
	}
}

/*
	Name: function_1abaab3d
	Namespace: namespace_a5657ff1
	Checksum: 0x3DF3A1AC
	Offset: 0x2B48
	Size: 0x264
	Parameters: 0
	Flags: Linked
*/
function function_1abaab3d()
{
	if(level.var_15747fb1 === 1)
	{
		return;
	}
	level endoncallback(&function_da973002, #"round_reset");
	if(math::cointoss(10))
	{
		return;
	}
	hold_round_end(1);
	wait(randomfloatrange(3, 15));
	var_a9e4d1ee = randomintrange(3, 6);
	while(var_a9e4d1ee > 0)
	{
		var_c6bd50df = self zm_zonemgr::get_player_zone();
		var_4974e492 = [];
		foreach(loc in level.zm_loc_types[#"dog_location"])
		{
			if(!isdefined(var_c6bd50df))
			{
				util::wait_network_frame();
				continue;
			}
			if(loc.zone_name == var_c6bd50df)
			{
				if(!isdefined(var_4974e492))
				{
					var_4974e492 = [];
				}
				else if(!isarray(var_4974e492))
				{
					var_4974e492 = array(var_4974e492);
				}
				var_4974e492[var_4974e492.size] = loc;
			}
		}
		e_dog = zombie_dog_util::function_62db7b1c(0, array::random(var_4974e492));
		if(isdefined(e_dog))
		{
			var_a9e4d1ee--;
			wait(randomfloatrange(1, 2));
		}
		else
		{
			util::wait_network_frame();
		}
	}
	hold_round_end(0);
}

/*
	Name: function_da973002
	Namespace: namespace_a5657ff1
	Checksum: 0x83CC8327
	Offset: 0x2DB8
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_da973002(var_c34665fc)
{
	hold_round_end(0);
}

/*
	Name: function_2cfc0c77
	Namespace: namespace_a5657ff1
	Checksum: 0xBD69E1BE
	Offset: 0x2DE8
	Size: 0x2C
	Parameters: 2
	Flags: Linked
*/
function function_2cfc0c77(e_holder, w_item)
{
	self thread function_1abaab3d();
}

/*
	Name: hold_round_end
	Namespace: namespace_a5657ff1
	Checksum: 0x8056D76A
	Offset: 0x2E20
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function hold_round_end(b_hold)
{
	if(b_hold)
	{
		if(!isdefined(level.var_4a1bd51b))
		{
			level.var_4a1bd51b = 1;
			level flag::set(#"hold_round_end");
		}
		else
		{
			level.var_4a1bd51b++;
		}
	}
	else
	{
		if(!isdefined(level.var_4a1bd51b))
		{
			return;
		}
		level.var_4a1bd51b--;
		if(level.var_4a1bd51b < 1)
		{
			level flag::clear(#"hold_round_end");
			level.var_4a1bd51b = undefined;
		}
	}
}

/*
	Name: function_5e893125
	Namespace: namespace_a5657ff1
	Checksum: 0xA7E08490
	Offset: 0x2EF0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function function_5e893125()
{
	level.var_dc235a55 = zm_hms_util::function_2719d4c0("cage_debris", "targetname", "script_int");
	level.var_24629e70 = 1;
	array::run_all(level.var_dc235a55, &function_3290d759);
}

/*
	Name: function_3290d759
	Namespace: namespace_a5657ff1
	Checksum: 0x61AF3E80
	Offset: 0x2F68
	Size: 0x284
	Parameters: 0
	Flags: Linked
*/
function function_3290d759()
{
	if(!isdefined(self.a_e_clip))
	{
		self.a_e_clip = [];
	}
	else if(!isarray(self.a_e_clip))
	{
		self.a_e_clip = array(self.a_e_clip);
	}
	if(!isdefined(self.var_ddcda303))
	{
		self.var_ddcda303 = [];
	}
	else if(!isarray(self.var_ddcda303))
	{
		self.var_ddcda303 = array(self.var_ddcda303);
	}
	var_2b975c1a = getentarray(self.target, "targetname");
	foreach(var_28dbd41f in var_2b975c1a)
	{
		if(var_28dbd41f iszbarrier())
		{
			if(!isdefined(self.var_ddcda303))
			{
				self.var_ddcda303 = [];
			}
			else if(!isarray(self.var_ddcda303))
			{
				self.var_ddcda303 = array(self.var_ddcda303);
			}
			self.var_ddcda303[self.var_ddcda303.size] = var_28dbd41f;
			continue;
		}
		if(!isdefined(self.a_e_clip))
		{
			self.a_e_clip = [];
		}
		else if(!isarray(self.a_e_clip))
		{
			self.a_e_clip = array(self.a_e_clip);
		}
		self.a_e_clip[self.a_e_clip.size] = var_28dbd41f;
		var_28dbd41f disconnectpaths();
	}
	self.var_ceff30c0 = struct::get_array(self.target);
	if(self.target == "cage_debris_start")
	{
		self thread function_8039854f();
	}
}

/*
	Name: function_8039854f
	Namespace: namespace_a5657ff1
	Checksum: 0x1E9C3807
	Offset: 0x31F8
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function function_8039854f()
{
	level waittill(#"hash_253a424c838fcd19");
	level flag::clear("spawn_zombies");
	wait(3);
	a_valid = zm_vo::function_347f7d34();
	a_floor = zm_office_floors::function_df2506d3(4);
	a_players = arrayintersect(a_valid, a_floor);
	if(a_players.size > 0)
	{
		e_player = array::random(a_players);
		e_player thread zm_vo::function_a2bd5a0c(#"hash_52de71efb1e8de2b", undefined, 1);
	}
	self function_55ca39d8();
	level flag::set("spawn_zombies");
}

/*
	Name: function_55ca39d8
	Namespace: namespace_a5657ff1
	Checksum: 0x9168FFD3
	Offset: 0x3328
	Size: 0x280
	Parameters: 0
	Flags: Linked
*/
function function_55ca39d8()
{
	arrayremovevalue(level.var_dc235a55, self, 1);
	array::thread_all(self.var_ddcda303, &zm_blockers::debris_zbarrier_move);
	var_19400951 = spawn("script_origin", self.origin);
	var_19400951 playloopsound(#"hash_5fcc4dd87aec52c7", 0.5);
	if(util::get_game_type() != #"zstandard")
	{
		wait(3);
	}
	playsoundatposition(#"hash_4bddd546f43487cf", self.origin);
	var_19400951 stoploopsound(0.5);
	var_19400951 delete();
	array::run_all(self.a_e_clip, &delete);
	if(util::get_game_type() != #"zstandard")
	{
		if(self.var_ceff30c0.size > 1)
		{
			zm_powerups::specific_powerup_drop("full_ammo", self.var_ceff30c0[0].origin);
			if(level.var_ff6ae478 === 1)
			{
				zm_powerups::specific_powerup_drop("bonfire_sale", self.var_ceff30c0[1].origin);
				callback::function_ec6dfc37(&function_17e0771a);
			}
		}
	}
	foreach(var_cad23390 in self.var_ddcda303)
	{
		var_cad23390 thread function_fa3de51f();
	}
}

/*
	Name: function_fa3de51f
	Namespace: namespace_a5657ff1
	Checksum: 0x500832D
	Offset: 0x35B0
	Size: 0x4C
	Parameters: 0
	Flags: Linked
*/
function function_fa3de51f()
{
	self.origin = self.origin + vectorscale((0, 0, 1), 1000);
	self waittill(#"movedone");
	self delete();
}

/*
	Name: function_231d0b19
	Namespace: namespace_a5657ff1
	Checksum: 0xD852B55C
	Offset: 0x3608
	Size: 0x48
	Parameters: 0
	Flags: Linked
*/
function function_231d0b19()
{
	var_f0a1a909 = level.var_dc235a55[level.var_24629e70];
	var_f0a1a909 thread function_55ca39d8();
	level.var_24629e70++;
}

/*
	Name: function_22537270
	Namespace: namespace_a5657ff1
	Checksum: 0x802417E9
	Offset: 0x3658
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_22537270()
{
	if(level.var_dc235a55.size > 0)
	{
		level.var_9aa7f03e = 4;
		callback::on_round_end(&function_17e0771a);
	}
}

/*
	Name: function_17e0771a
	Namespace: namespace_a5657ff1
	Checksum: 0x6CB24BCD
	Offset: 0x36A8
	Size: 0xA4
	Parameters: 0
	Flags: Linked
*/
function function_17e0771a()
{
	level.var_9aa7f03e--;
	if(level.var_9aa7f03e < 1)
	{
		function_231d0b19();
		callback::function_ec6dfc37(&function_17e0771a);
	}
	else if(level.var_9aa7f03e < 2)
	{
		level.var_ff6ae478 = 1;
		level.var_b117297e = 0;
		callback::on_player_damage(&function_f7544800);
	}
}

/*
	Name: function_f7544800
	Namespace: namespace_a5657ff1
	Checksum: 0x2DACEC18
	Offset: 0x3758
	Size: 0x5C
	Parameters: 1
	Flags: Linked
*/
function function_f7544800(params)
{
	level.var_b117297e++;
	if(level.var_b117297e > level.round_number)
	{
		level.var_ff6ae478 = 0;
		callback::remove_on_player_damage(&function_f7544800);
	}
}

/*
	Name: function_275db54d
	Namespace: namespace_a5657ff1
	Checksum: 0xC520E7F5
	Offset: 0x37C0
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function function_275db54d()
{
	callback::function_ec6dfc37(&function_17e0771a);
	callback::remove_on_player_damage(&function_f7544800);
}

/*
	Name: function_5642f347
	Namespace: namespace_a5657ff1
	Checksum: 0xB12C928F
	Offset: 0x3810
	Size: 0x5C
	Parameters: 0
	Flags: None
*/
function function_5642f347()
{
	/#
		if(!level flag::get(""))
		{
			level flag::set("");
			wait(1);
		}
		function_d1cfd44();
	#/
}

/*
	Name: function_f33d3ab5
	Namespace: namespace_a5657ff1
	Checksum: 0x14E9A2AC
	Offset: 0x3878
	Size: 0x64
	Parameters: 0
	Flags: None
*/
function function_f33d3ab5()
{
	/#
		if(!isdefined(level.var_dc235a55) || level.var_dc235a55.size < 1)
		{
			return;
		}
		level.var_9aa7f03e = 1;
		function_17e0771a();
		function_22537270();
	#/
}

