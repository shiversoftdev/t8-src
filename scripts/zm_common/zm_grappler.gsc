// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\hud_util_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace zm_grappler;

/*
	Name: __init__system__
	Namespace: zm_grappler
	Checksum: 0xD3BED0D4
	Offset: 0x120
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"zm_grappler", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: zm_grappler
	Checksum: 0x5FDA0865
	Offset: 0x170
	Size: 0xCC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("scriptmover", "grappler_beam_source", 1, getminbitcountfornum(5), "int");
	clientfield::register("scriptmover", "grappler_beam_target", 1, getminbitcountfornum(5), "int");
	level.grapple_ids = [];
	for(id = 1; id < 5; id++)
	{
		level.grapple_ids[id] = 0;
	}
}

/*
	Name: __main__
	Namespace: zm_grappler
	Checksum: 0x80F724D1
	Offset: 0x248
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
}

/*
	Name: function_5f5a3405
	Namespace: zm_grappler
	Checksum: 0x5CACA2A8
	Offset: 0x258
	Size: 0x92
	Parameters: 0
	Flags: Linked, Private
*/
function private function_5f5a3405()
{
	foreach(key, value in level.grapple_ids)
	{
		if(value === 0)
		{
			level.grapple_ids[key] = 1;
			return key;
		}
	}
	return undefined;
}

/*
	Name: function_56813755
	Namespace: zm_grappler
	Checksum: 0x80AABABE
	Offset: 0x2F8
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function function_56813755()
{
	foreach(value in level.grapple_ids)
	{
		if(value === 0)
		{
			return false;
		}
	}
	return true;
}

/*
	Name: function_2772f623
	Namespace: zm_grappler
	Checksum: 0xD0CB1186
	Offset: 0x380
	Size: 0x62
	Parameters: 1
	Flags: Linked, Private
*/
function private function_2772f623(id)
{
	/#
		assert(isdefined(level.grapple_ids[id]) && level.grapple_ids[id] === 1);
	#/
	level.grapple_ids[id] = 0;
}

/*
	Name: start_grapple
	Namespace: zm_grappler
	Checksum: 0xC0CF91A7
	Offset: 0x3F0
	Size: 0x3AC
	Parameters: 4
	Flags: None
*/
function start_grapple(prone_2_run_roll, e_grapplee, n_type, n_speed = 1800)
{
	/#
		assert(n_type == 2);
	#/
	e_source = function_6be863a(prone_2_run_roll function_f21c3519(), prone_2_run_roll.angles);
	var_28ac1348 = function_6be863a(prone_2_run_roll function_f21c3519(), prone_2_run_roll.angles * -1);
	thread function_30a5f5c1(e_source, var_28ac1348);
	if(isdefined(var_28ac1348))
	{
		e_grapplee function_a60cb756(1, 1);
		util::wait_network_frame();
		n_time = function_b9937e84(prone_2_run_roll, e_grapplee, n_speed);
		var_28ac1348.origin = prone_2_run_roll function_f21c3519();
		var_5f04bf66 = e_grapplee function_f21c3519();
		var_28ac1348 playsound(#"zmb_grapple_start");
		var_28ac1348 moveto(var_5f04bf66, n_time);
		var_28ac1348 waittill(#"movedone");
		var_7fdf7771 = var_5f04bf66 - e_grapplee.origin;
		var_28ac1348.origin = e_grapplee.origin;
		if(isplayer(e_grapplee))
		{
			e_grapplee playerlinkto(var_28ac1348, "tag_origin");
		}
		else
		{
			e_grapplee linkto(var_28ac1348);
		}
		e_grapplee playsound(#"zmb_grapple_grab");
		var_b7f19309 = prone_2_run_roll function_f21c3519() - var_7fdf7771;
		var_28ac1348 moveto(var_b7f19309, n_time);
		var_28ac1348 playsound(#"zmb_grapple_pull");
		var_28ac1348 waittill(#"movedone");
		function_c43e7cab();
		var_28ac1348 clientfield::set("grappler_beam_target", 0);
		e_grapplee unlink();
		e_grapplee function_a60cb756(0, 1);
		util::wait_network_frame();
		function_a8e7b940(var_28ac1348);
		function_a8e7b940(e_source);
	}
}

/*
	Name: function_c43e7cab
	Namespace: zm_grappler
	Checksum: 0xE092D991
	Offset: 0x7A8
	Size: 0x2E
	Parameters: 0
	Flags: Linked
*/
function function_c43e7cab()
{
	while(isdefined(level.var_acec7a44) && level.var_acec7a44)
	{
		waitframe(1);
	}
}

/*
	Name: function_1b905efa
	Namespace: zm_grappler
	Checksum: 0x215D2AC8
	Offset: 0x7E0
	Size: 0xBC
	Parameters: 3
	Flags: Linked, Private
*/
function private function_1b905efa(e_source, e_target, id)
{
	if(isdefined(e_source) && isdefined(e_target))
	{
		util::waittill_any_ents_two(e_source, "death", e_target, "death");
	}
	else
	{
		if(isdefined(e_source))
		{
			e_source waittill(#"death");
		}
		else if(isdefined(e_target))
		{
			e_target waittill(#"death");
		}
	}
	util::wait_network_frame();
	function_2772f623(id);
}

/*
	Name: function_30a5f5c1
	Namespace: zm_grappler
	Checksum: 0x77B4FF71
	Offset: 0x8A8
	Size: 0xEA
	Parameters: 2
	Flags: Linked
*/
function function_30a5f5c1(e_source, e_target)
{
	function_c43e7cab();
	level.var_acec7a44 = 1;
	grapple_id = function_5f5a3405();
	if(isdefined(e_source))
	{
		e_source clientfield::set("grappler_beam_source", grapple_id);
	}
	util::wait_network_frame();
	if(isdefined(e_target))
	{
		e_target clientfield::set("grappler_beam_target", grapple_id);
	}
	thread function_1b905efa(e_source, e_target, grapple_id);
	util::wait_network_frame();
	level.var_acec7a44 = 0;
}

/*
	Name: function_b9937e84
	Namespace: zm_grappler
	Checksum: 0x2057F273
	Offset: 0x9A0
	Size: 0x68
	Parameters: 3
	Flags: Linked, Private
*/
function private function_b9937e84(e_from, e_to, n_speed)
{
	n_distance = distance(e_from function_f21c3519(), e_to function_f21c3519());
	return n_distance / n_speed;
}

/*
	Name: function_a60cb756
	Namespace: zm_grappler
	Checksum: 0xDB6D3E90
	Offset: 0xA10
	Size: 0x194
	Parameters: 2
	Flags: Linked
*/
function function_a60cb756(var_b4666218, var_e9f8c8f3)
{
	if(!isdefined(self))
	{
		return;
	}
	if(var_b4666218 != (isdefined(self.var_564dec14) && self.var_564dec14))
	{
		if(isdefined(var_b4666218) && var_b4666218)
		{
			self notify(#"hash_3219c34bb024ffb7");
		}
		else
		{
			self notify(#"hash_5d85f16cb4fd5a32");
		}
		self.var_564dec14 = var_b4666218;
		if(isplayer(self))
		{
			self freezecontrols(var_b4666218);
			self setplayercollision(!var_b4666218);
			if(var_b4666218)
			{
				self val::set(#"zm_grappler", "ignoreme");
				if(isdefined(var_e9f8c8f3) && var_e9f8c8f3)
				{
					self.var_d6723cbc = self enableinvulnerability();
				}
			}
			else
			{
				self val::reset(#"zm_grappler", "ignoreme");
				if(!(isdefined(self.var_d6723cbc) && self.var_d6723cbc) && (isdefined(var_e9f8c8f3) && var_e9f8c8f3))
				{
					self disableinvulnerability();
				}
			}
		}
	}
}

/*
	Name: function_f21c3519
	Namespace: zm_grappler
	Checksum: 0xAC5E7AE0
	Offset: 0xBB0
	Size: 0x42
	Parameters: 0
	Flags: Linked
*/
function function_f21c3519()
{
	if(isdefined(self.grapple_tag))
	{
		v_origin = self gettagorigin(self.grapple_tag);
		return v_origin;
	}
	return self.origin;
}

/*
	Name: function_6be863a
	Namespace: zm_grappler
	Checksum: 0x34FBB2B3
	Offset: 0xC00
	Size: 0x52
	Parameters: 2
	Flags: Linked
*/
function function_6be863a(v_origin, v_angles)
{
	model = "tag_origin";
	e_ent = util::spawn_model(model, v_origin, v_angles);
	return e_ent;
}

/*
	Name: function_a8e7b940
	Namespace: zm_grappler
	Checksum: 0x8EB65F1A
	Offset: 0xC60
	Size: 0x2C
	Parameters: 1
	Flags: Linked
*/
function function_a8e7b940(var_28ac1348)
{
	if(isdefined(var_28ac1348))
	{
		var_28ac1348 delete();
	}
}

