// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\mp_common\laststand_warzone.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using script_cb32d07c95e5628;
#using scripts\core_common\player\player_stats.gsc;
#using scripts\mp_common\item_world.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace wz_fishing;

/*
	Name: __init__system__
	Namespace: wz_fishing
	Checksum: 0x7F67F6DB
	Offset: 0x2D8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"wz_fishing", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: wz_fishing
	Checksum: 0x19DE4338
	Offset: 0x320
	Size: 0x378
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_99ca6467 = (isdefined(getgametypesetting(#"hash_697d65a68cc6c6f1")) ? getgametypesetting(#"hash_697d65a68cc6c6f1") : 0) || (isdefined(getgametypesetting(#"hash_473fee16f796c84e")) ? getgametypesetting(#"hash_473fee16f796c84e") : 0);
	clientfield::register("scriptmover", "fishing_splash", 21000, 1, "int");
	clientfield::register("scriptmover", "fishing_buoy_splash", 21000, 1, "int");
	clientfield::register("toplayer", "player_fishing", 21000, 1, "int");
	fishing_rocks = getdynentarray("fishing_rock");
	if(level.var_99ca6467)
	{
		callback::on_downed(&function_7bf61c45);
		callback::on_weapon_change(&function_e2877ac6);
		callback::on_item_drop(&function_57232538);
		foreach(rock in fishing_rocks)
		{
			rock.onuse = &function_4cfd3896;
			rock.dropping_item = 0;
			rock.var_fb09ad1c = 0;
			rock.isfishing = 0;
			if(isdefined(rock.target))
			{
				buoy = getent(rock.target, "targetname");
				if(isdefined(buoy))
				{
					rock.var_87de0f0d = buoy.origin;
					rock.buoy = buoy;
					buoy hide();
				}
			}
		}
		level thread function_c0cfa434();
	}
	else
	{
		foreach(rock in fishing_rocks)
		{
			function_e2a06860(rock, 2);
		}
	}
}

/*
	Name: function_57232538
	Namespace: wz_fishing
	Checksum: 0x19A03978
	Offset: 0x6A0
	Size: 0x110
	Parameters: 1
	Flags: Linked
*/
function function_57232538(s_item)
{
	fishing_rocks = getdynentarray("fishing_rock");
	foreach(rock in fishing_rocks)
	{
		if(isplayer(rock.fisherman) && rock.fisherman == self && (isdefined(rock.isfishing) && rock.isfishing))
		{
			self function_7c685040();
			self function_ed446f40(rock);
		}
	}
}

/*
	Name: function_7bf61c45
	Namespace: wz_fishing
	Checksum: 0x2B792490
	Offset: 0x7B8
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_7bf61c45()
{
	fishing_rocks = getdynentarray("fishing_rock");
	foreach(rock in fishing_rocks)
	{
		if(rock.isfishing && isplayer(rock.fisherman) && rock.fisherman === self)
		{
			self function_7c685040();
			self function_ed446f40(rock);
		}
	}
}

/*
	Name: function_e2877ac6
	Namespace: wz_fishing
	Checksum: 0x3A12BCBD
	Offset: 0x8B8
	Size: 0xF8
	Parameters: 0
	Flags: Linked
*/
function function_e2877ac6()
{
	fishing_rocks = getdynentarray("fishing_rock");
	foreach(rock in fishing_rocks)
	{
		if(rock.isfishing && isplayer(rock.fisherman) && rock.fisherman === self)
		{
			self function_7c685040();
			self function_ed446f40(rock);
		}
	}
}

/*
	Name: function_c0cfa434
	Namespace: wz_fishing
	Checksum: 0x61376529
	Offset: 0x9B8
	Size: 0x148
	Parameters: 0
	Flags: Linked
*/
function function_c0cfa434()
{
	level endon(#"game_ended");
	flagsys::wait_till(#"hash_507a4486c4a79f1d");
	fishing_rocks = getdynentarray("fishing_rock");
	foreach(rock in fishing_rocks)
	{
		if(rock.isfishing && isplayer(rock.fisherman))
		{
			rock.fisherman notify(#"hash_61bb9580151c93d5");
			rock.fisherman function_7c685040();
			rock.fisherman function_ed446f40(rock);
		}
	}
}

/*
	Name: function_12747006
	Namespace: wz_fishing
	Checksum: 0x83917D63
	Offset: 0xB08
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_12747006(boast)
{
	if(self util::is_female())
	{
		self function_c6775cf9("f_" + boast);
	}
	else
	{
		self function_c6775cf9("m_" + boast);
	}
}

/*
	Name: function_e1cd5954
	Namespace: wz_fishing
	Checksum: 0x10737295
	Offset: 0xB80
	Size: 0xB6
	Parameters: 1
	Flags: Linked
*/
function function_e1cd5954(v_origin)
{
	self notify("58ed1cc25dba79a1");
	self endon("58ed1cc25dba79a1");
	trace = bullettrace(v_origin + vectorscale((0, 0, 1), 40), v_origin + (vectorscale((0, 0, -1), 150)), 0, undefined);
	if(trace[#"fraction"] < 1)
	{
		v_origin = trace[#"position"];
	}
	return v_origin + vectorscale((0, 0, 1), 3);
}

/*
	Name: fake_physicslaunch
	Namespace: wz_fishing
	Checksum: 0xDC6276B9
	Offset: 0xC40
	Size: 0xE0
	Parameters: 4
	Flags: Linked
*/
function fake_physicslaunch(start_pos, target_pos, power, var_b37bfb00)
{
	self notify("734213b674966fed");
	self endon("734213b674966fed");
	dist = distance(start_pos, target_pos);
	time = dist / power;
	delta = target_pos - start_pos;
	up = (0, 0, dist);
	velocity = delta + up;
	self movegravity(velocity, time);
	return time;
}

/*
	Name: fishing_buoy_splash
	Namespace: wz_fishing
	Checksum: 0xFC99367
	Offset: 0xD28
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function fishing_buoy_splash()
{
	self notify("affb149f13915ab");
	self endon("affb149f13915ab");
	self clientfield::set("fishing_buoy_splash", 1);
	wait(0.5);
	self clientfield::set("fishing_buoy_splash", 0);
}

/*
	Name: fishing_splash
	Namespace: wz_fishing
	Checksum: 0x9E6BAC40
	Offset: 0xDA0
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function fishing_splash()
{
	self notify("23dba81fc67053dc");
	self endon("23dba81fc67053dc");
	self clientfield::set("fishing_splash", 1);
	wait(1);
	self clientfield::set("fishing_splash", 0);
}

/*
	Name: function_7a1e21a9
	Namespace: wz_fishing
	Checksum: 0x38D5C07B
	Offset: 0xE18
	Size: 0x166
	Parameters: 3
	Flags: Linked
*/
function function_7a1e21a9(fishing_rock, v_origin, player)
{
	self notify("47f64769ffeb67ce");
	self endon("47f64769ffeb67ce");
	self endon(#"delete");
	self.origin = v_origin + vectorscale((0, 0, 1), 10);
	height_offset = 16;
	final_origin = fishing_rock.origin + (0, 0, height_offset);
	dest_origin = function_e1cd5954(final_origin);
	if(isdefined(fishing_rock.target))
	{
		buoy = getent(fishing_rock.target, "targetname");
	}
	buoy thread fishing_splash();
	time = self fake_physicslaunch(buoy.origin, final_origin, 200, height_offset);
	wait(time);
	fishing_rock.dropping_item = 0;
	if(isdefined(self))
	{
		self.origin = final_origin;
	}
}

/*
	Name: function_e8c63c15
	Namespace: wz_fishing
	Checksum: 0x581037E9
	Offset: 0xF88
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function function_e8c63c15(player)
{
	self notify("148aaf4bd55078f9");
	self endon("148aaf4bd55078f9");
	if(isdefined(self.target))
	{
		buoy = getent(self.target, "targetname");
	}
	if(isdefined(buoy))
	{
		v_origin = buoy.origin;
		items = buoy namespace_65181344::function_fd87c780("fishing_hole_items", 1);
	}
	else
	{
		v_origin = self.origin;
		items = self namespace_65181344::function_fd87c780("fishing_hole_items", 1);
	}
	for(i = 0; i < items.size; i++)
	{
		item = items[i];
		if(isdefined(item))
		{
			item thread function_7a1e21a9(self, v_origin, player);
		}
		waitframe(1);
	}
}

/*
	Name: function_4cfd3896
	Namespace: wz_fishing
	Checksum: 0xA277D15
	Offset: 0x10D0
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function function_4cfd3896(activator, laststate, state)
{
	if(isdefined(self.isfishing) && self.isfishing)
	{
		return;
	}
	if(!isplayer(activator))
	{
		return;
	}
	if(!activator isonground())
	{
		return;
	}
	self.isfishing = 1;
	if(isdefined(self.buoy))
	{
		self.buoy show();
	}
	else
	{
		/#
			assert(isdefined(self.buoy), "");
		#/
	}
	self.fisherman = activator;
	self.dropping_item = 0;
	activator thread function_6c71782a(self);
}

/*
	Name: function_ee4ce537
	Namespace: wz_fishing
	Checksum: 0xBD93013D
	Offset: 0x11D8
	Size: 0xA4
	Parameters: 1
	Flags: Linked
*/
function function_ee4ce537(dynent)
{
	self endon(#"death", #"hash_21d06dbd3684fc31");
	while(true)
	{
		if(isdefined(dynent.isfishing) && dynent.isfishing)
		{
			if(!self function_15049d95())
			{
				self function_ed446f40(dynent);
				self notify(#"hash_21d06dbd3684fc31");
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_6c71782a
	Namespace: wz_fishing
	Checksum: 0x8F909138
	Offset: 0x1288
	Size: 0x394
	Parameters: 1
	Flags: Linked
*/
function function_6c71782a(dynent)
{
	self notify("48d65f5f22c36da2");
	self endon("48d65f5f22c36da2");
	self endon(#"death", #"hash_61bb9580151c93d5", #"hash_667fd08050e0942b");
	if(!isplayer(self))
	{
		return;
	}
	if(!isdefined(dynent))
	{
		return;
	}
	self disableweaponcycling();
	self disableusability();
	self disableoffhandweapons();
	self val::set(#"fishing", "freezecontrols_allowlook", 1);
	self val::set(#"fishing", "disablegadgets", 1);
	if(dynent.var_fb09ad1c == 1 || dynent.var_fb09ad1c == 2)
	{
		return;
	}
	dynent.var_fb09ad1c = 1;
	var_9f816ad8 = dynent.var_87de0f0d - dynent.origin;
	var_9f816ad8 = vectortoangles(var_9f816ad8);
	self setplayerangles(var_9f816ad8);
	dynent.buoy.origin = self.origin;
	self function_7c685040();
	self function_12747006("fishing_in");
	self clientfield::set_to_player("player_fishing", 1);
	self thread function_ee4ce537(dynent);
	self waittill(#"hash_7e9761139bebb10f");
	time = dynent.buoy fake_physicslaunch(self.origin, dynent.var_87de0f0d, 200);
	dynent.buoy thread function_8e8c4fef(time, dynent.var_87de0f0d);
	self waittill(#"hash_7cb51cb463b76708");
	if(dynent.var_fb09ad1c === 2)
	{
		return;
	}
	dynent.var_fb09ad1c = 2;
	self function_12747006("fishing_loop");
	dynent.buoy.origin = dynent.var_87de0f0d;
	dynent.var_be4b82e0 = dynent.var_87de0f0d;
	dynent.buoy thread function_b828bd39(self, dynent);
	self thread function_16e4e507(dynent);
	self thread function_176e516(dynent);
}

/*
	Name: function_8e8c4fef
	Namespace: wz_fishing
	Checksum: 0x3B63F3D1
	Offset: 0x1628
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function function_8e8c4fef(time, pos)
{
	self notify("230f045151c08d1e");
	self endon("230f045151c08d1e");
	self endon(#"death", #"fishing_done");
	wait(time);
	self.origin = pos;
}

/*
	Name: function_b828bd39
	Namespace: wz_fishing
	Checksum: 0x2927F175
	Offset: 0x1698
	Size: 0x208
	Parameters: 2
	Flags: Linked
*/
function function_b828bd39(player, dynent)
{
	self notify("1fa6d3899117f2a");
	self endon("1fa6d3899117f2a");
	if(!isplayer(player))
	{
		return;
	}
	if(!isdefined(dynent))
	{
		return;
	}
	if(!isdefined(dynent.var_be4b82e0))
	{
		return;
	}
	self endon(#"fishing_done");
	player endon(#"death", #"hash_61bb9580151c93d5");
	dynent.var_3fa8a746 = 0;
	self.origin = dynent.var_be4b82e0;
	while(dynent.var_fb09ad1c == 2 && !dynent.dropping_item)
	{
		time = randomintrange(5, 7);
		wait(time);
		dynent.var_3fa8a746 = 1;
		player playrumbleonentity("fishing_rumble");
		self thread fishing_buoy_splash();
		new_pos = self.origin + (vectorscale((0, 0, -1), 5));
		self moveto(new_pos, 0.5);
		self waittill(#"movedone");
		new_pos = self.origin + vectorscale((0, 0, 1), 5);
		self moveto(new_pos, 0.5);
		self waittill(#"movedone");
		dynent.var_3fa8a746 = 0;
		waitframe(1);
	}
}

/*
	Name: function_16e4e507
	Namespace: wz_fishing
	Checksum: 0x5B3E4389
	Offset: 0x18A8
	Size: 0x152
	Parameters: 1
	Flags: Linked
*/
function function_16e4e507(dynent)
{
	self notify("651631a8d4cdd907");
	self endon("651631a8d4cdd907");
	self endoncallback(&function_73532e4f, #"death", #"hash_61bb9580151c93d5");
	if(!isplayer(self))
	{
		return;
	}
	if(!isdefined(dynent))
	{
		return;
	}
	while(dynent.var_fb09ad1c != 3)
	{
		if(self attackbuttonpressed() && dynent.var_fb09ad1c != 3)
		{
			dynent.var_fb09ad1c = 3;
			if(isdefined(dynent.buoy))
			{
				self function_12747006("fishing_out");
				self thread function_54a3ec41(dynent);
				self waittill(#"hash_48fcb6dc25306e9");
				self thread function_ed446f40(dynent);
				break;
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_ed446f40
	Namespace: wz_fishing
	Checksum: 0xFD29411D
	Offset: 0x1A08
	Size: 0x1A2
	Parameters: 1
	Flags: Linked
*/
function function_ed446f40(dynent)
{
	self notify("694f2b46b5345051");
	self endon("694f2b46b5345051");
	if(isplayer(self))
	{
		self enableweaponcycling();
		self enableusability();
		self enableoffhandweapons();
		self val::set(#"fishing", "freezecontrols_allowlook", 0);
		self val::set(#"fishing", "disablegadgets", 0);
		self clientfield::set_to_player("player_fishing", 0);
	}
	dynent.dropping_item = 0;
	dynent.var_fb09ad1c = 0;
	if(isdefined(dynent.buoy))
	{
		dynent.buoy notify(#"fishing_done");
		dynent.buoy moveto(dynent.var_87de0f0d, 1);
		dynent.buoy hide();
	}
	wait(2);
	dynent.fisherman = undefined;
	dynent.isfishing = 0;
}

/*
	Name: function_176e516
	Namespace: wz_fishing
	Checksum: 0xCE77FDAA
	Offset: 0x1BB8
	Size: 0x142
	Parameters: 1
	Flags: Linked
*/
function function_176e516(dynent)
{
	self notify("110650c21bf60e88");
	self endon("110650c21bf60e88");
	if(!isdefined(dynent) || !isplayer(self))
	{
		return;
	}
	self endoncallback(&function_73532e4f, #"death", #"hash_61bb9580151c93d5");
	while(dynent.var_fb09ad1c != 3)
	{
		if(dynent.var_fb09ad1c != 3 && (self jumpbuttonpressed() || self stancebuttonpressed()))
		{
			dynent.var_fb09ad1c = 3;
			self function_12747006("fishing_cancel");
			self waittill(#"hash_48fcb6dc25306e9");
			self function_ed446f40(dynent);
			break;
		}
		waitframe(1);
	}
}

/*
	Name: function_54a3ec41
	Namespace: wz_fishing
	Checksum: 0xE19D8359
	Offset: 0x1D08
	Size: 0xD8
	Parameters: 1
	Flags: Linked
*/
function function_54a3ec41(dynent)
{
	self notify("28b87437c2b95c62");
	self endon("28b87437c2b95c62");
	self endon(#"death");
	if(isdefined(dynent.var_3fa8a746) && dynent.var_3fa8a746)
	{
		self waittill(#"hash_f330683a277a932");
		if(dynent.dropping_item === 0)
		{
			dynent.dropping_item = 1;
			dynent function_e8c63c15(self);
		}
	}
	else if(isdefined(dynent.buoy))
	{
		dynent.buoy notify(#"fishing_done");
	}
}

/*
	Name: function_73532e4f
	Namespace: wz_fishing
	Checksum: 0xA19AB3CB
	Offset: 0x1DE8
	Size: 0x220
	Parameters: 0
	Flags: Linked
*/
function function_73532e4f()
{
	self notify("76a99663ad9702eb");
	self endon("76a99663ad9702eb");
	if(isplayer(self))
	{
		self enableweaponcycling();
		self enableusability();
		self enableoffhandweapons();
		self val::set(#"fishing", "freezecontrols_allowlook", 0);
		self val::set(#"fishing", "disablegadgets", 0);
		self clientfield::set_to_player("player_fishing", 0);
	}
	fishing_rocks = getdynentarray("fishing_rock");
	foreach(rock in fishing_rocks)
	{
		rock.dropping_item = 0;
		rock.var_fb09ad1c = 0;
		rock.isfishing = 0;
		if(isdefined(rock.buoy) && isdefined(rock.var_87de0f0d))
		{
			rock.buoy notify(#"fishing_done");
			rock.buoy moveto(rock.var_87de0f0d, 0.1);
			rock.buoy hide();
		}
	}
}

