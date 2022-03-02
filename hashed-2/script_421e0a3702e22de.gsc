// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_5bb072c3abf4652c;
#using script_6a3f43063dfd1bdc;
#using script_b52a163973f339f;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\spawner_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\core_common\values_shared.gsc;
#using scripts\zm\zm_orange_util.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_unitrigger.gsc;
#using scripts\zm_common\zm_utility.gsc;
#using scripts\zm_common\zm_zonemgr.gsc;

#namespace namespace_85e029d3;

/*
	Name: init
	Namespace: namespace_85e029d3
	Checksum: 0xAA155675
	Offset: 0x208
	Size: 0xC54
	Parameters: 0
	Flags: Linked
*/
function init()
{
	level.pablo_npc = getent("pablo_npc", "targetname");
	level.pablo_npc.name = "herm";
	level.pablo_npc.isspeaking = 0;
	level.pablo_npc.var_5b6ebfd0 = 0;
	level.pablo_npc flag::init(#"hash_5945cee69b029018");
	level flag::init(#"hash_1c52b843cb50942c");
	level flag::init(#"hash_641f14d0b2fd57d7");
	level flag::init(#"hash_6e81da82129193f6");
	level flag::init(#"hash_6a7b24db9087b2eb");
	level.pablo_npc.var_3e21d491 = struct::get("s_pap_rock_dropoff");
	level.pablo_npc.var_f75b1f16 = [];
	level.pablo_npc.var_cb3ed98f = [];
	level.pablo_npc.var_cb3ed98f[2] = {#n_obj:2, #hash_23d421c1:#"", #hash_c67e664c:1, #hash_e7b75754:#"hash_22abfa5a48ecff33", #hash_fcab5f41:#"hash_22abfa5a48ecff33"};
	level.pablo_npc.var_cb3ed98f[3] = {#n_obj:1, #hash_23d421c1:#"hash_5ec5a17bd8bad06c", #hash_e7b75754:#"hash_6eb46d1457a1406a", #hash_fcab5f41:#""};
	level.pablo_npc.var_cb3ed98f[6] = {#n_obj:7, #hash_23d421c1:#"hash_254c37174dfe3cd2", #hash_c67e664c:4, #hash_e7b75754:#"hash_37b261e51a21c0cc", #hash_44dd0e20:1, #hash_fcab5f41:#"hash_37b261e51a21c0cc"};
	level.pablo_npc.var_cb3ed98f[8] = {#n_obj:5, #hash_23d421c1:#"hash_5d845c0d267bd2a5", #hash_c67e664c:1, #hash_e7b75754:#"hash_170341e08a9cda92", #hash_44dd0e20:0, #hash_fcab5f41:#"hash_170341e08a9cda92"};
	level.pablo_npc.var_cb3ed98f[7] = {#n_obj:6, #hash_23d421c1:#"", #hash_c67e664c:1, #hash_e7b75754:#"vox_soap_stones_get", #hash_44dd0e20:1, #hash_fcab5f41:#"vox_soap_stones_get"};
	level.pablo_npc.var_cb3ed98f[5] = {#n_obj:3, #hash_23d421c1:#"hash_5e981943f6b25ff", #hash_e7b75754:#"hash_754cd427015598bc", #hash_fcab5f41:#""};
	level.pablo_npc.var_cb3ed98f[4] = {#n_obj:3, #hash_23d421c1:#"hash_5e981943f6b25ff", #hash_e7b75754:#"hash_754cd427015598bc", #hash_fcab5f41:#""};
	level.pablo_npc.var_cb3ed98f[0] = {#n_obj:10, #hash_23d421c1:#"hash_5d845c0d267bd2a5", #hash_e7b75754:#"", #hash_fcab5f41:#"hash_4af110e6753e70c2"};
	level.pablo_npc.var_cb3ed98f[1] = {#n_obj:11, #hash_23d421c1:#"hash_5d845c0d267bd2a5", #hash_e7b75754:#"", #hash_fcab5f41:#""};
	level.pablo_npc.var_cb3ed98f[11] = {#n_obj:0, #hash_23d421c1:undefined, #hash_6e67b4c4:1, #hash_c67e664c:3, #hash_e7b75754:#"hash_644ae453b377363", #hash_fcab5f41:#"hash_644ae453b377363"};
	level.pablo_npc.var_cb3ed98f[10] = {#n_obj:4, #hash_23d421c1:undefined, #hash_e7b75754:#"", #hash_fcab5f41:#"hash_1856b015429225fa"};
	level.pablo_npc.var_cb3ed98f[15] = {#n_obj:5, #hash_f26e362:0, #hash_23d421c1:#"hash_1859b2eb556cbe1c", #hash_6e67b4c4:1, #hash_c67e664c:1, #hash_e7b75754:#"hash_1859b2eb556cbe1c", #hash_fcab5f41:#""};
	level.pablo_npc.var_cb3ed98f[16] = {#n_obj:5, #hash_23d421c1:undefined, #hash_c67e664c:1, #hash_e7b75754:#"hash_18d17175b6700e47", #hash_44dd0e20:0, #hash_fcab5f41:#"hash_18d17175b6700e47"};
	level.pablo_npc.var_cb3ed98f[12] = {#n_obj:9, #hash_23d421c1:undefined, #hash_e7b75754:#"", #hash_fcab5f41:#"hash_14448cae6cbf526"};
	level.pablo_npc.var_cb3ed98f[13] = {#n_obj:3, #hash_23d421c1:undefined, #hash_e7b75754:#"", #hash_fcab5f41:#"hash_38aad0b1eae4093a"};
	level.pablo_npc.var_cb3ed98f[14] = {#n_obj:3, #hash_23d421c1:undefined, #hash_e7b75754:#"", #hash_fcab5f41:#"hash_38aad0b1eae4093a"};
	level.var_d827e909 = spawner::simple_spawn_single(getent("pablo_spawner", "targetname"));
	while(!isdefined(level.var_d827e909))
	{
		waitframe(1);
		level.var_d827e909 = spawner::simple_spawn_single(getent("pablo_spawner", "targetname"));
	}
	level.var_d827e909 val::set(#"hash_48ce7f436d6e49e6", "takedamage", 0);
	if(zm_utility::is_classic())
	{
		level thread function_b85344d1();
		level thread pablo_lift_init();
	}
	if(zm_utility::is_trials())
	{
		level pablo_lift_init();
		level flag::set(#"hash_641f14d0b2fd57d7");
		level.pablo_npc thread function_1dc9b29a();
		level.pablo_npc thread function_57c115a8();
	}
}

/*
	Name: function_e44c7c0c
	Namespace: namespace_85e029d3
	Checksum: 0x802574FC
	Offset: 0xE68
	Size: 0xCC
	Parameters: 2
	Flags: Linked
*/
function function_e44c7c0c(str_alias, n_variant)
{
	level.pablo_npc zm_vo::function_57b8cd17();
	level.pablo_npc namespace_509a75d1::function_6a0d675d(str_alias, n_variant, 0, 1);
	if(str_alias == #"hash_18d17175b6700e47" && n_variant === 1)
	{
		namespace_3263198e::function_fd24e47f(#"hash_35b42e4ca5afd6da", -1, 1);
		level.var_1c53964e thread namespace_509a75d1::function_6a0d675d(#"hash_35b42e4ca5afd6da");
	}
}

/*
	Name: function_b9e15919
	Namespace: namespace_85e029d3
	Checksum: 0x437D1327
	Offset: 0xF40
	Size: 0x7C
	Parameters: 1
	Flags: Linked
*/
function function_b9e15919(b_crouch = 1)
{
	if(b_crouch)
	{
		level.var_d827e909 setblackboardattribute("_stance", "crouch");
	}
	else
	{
		level.var_d827e909 setblackboardattribute("_stance", "stand");
	}
}

/*
	Name: function_b85344d1
	Namespace: namespace_85e029d3
	Checksum: 0x32460D87
	Offset: 0xFC8
	Size: 0x344
	Parameters: 0
	Flags: Linked, Private
*/
function private function_b85344d1()
{
	var_de23a374 = array("lighthouse_level_1", "lighthouse_level_2", "lighthouse_level_3");
	while(true)
	{
		if(namespace_509a75d1::any_player_in_zone(var_de23a374) && level.pablo_npc zm_audio::function_65e5c19a())
		{
			level function_e44c7c0c(#"hash_2a582565ea3add7e");
			a_players = [];
			foreach(zone in var_de23a374)
			{
				a_players = arraycombine(a_players, zm_zonemgr::get_players_in_zone(zone, 1), 0, 0);
			}
			player = namespace_509a75d1::function_3815943c(a_players);
			if(isdefined(player))
			{
				player namespace_3263198e::function_51b752a9(#"hash_2a582565ea3add7e", -1, 0, 1);
			}
			break;
		}
		wait(1);
	}
	level flag::set(#"hash_1c52b843cb50942c");
	while(true)
	{
		if(namespace_509a75d1::any_player_in_zone("lighthouse_level_4") && level.pablo_npc zm_audio::function_65e5c19a())
		{
			str_alias = #"hash_61f15b67b89a32a7";
			if(level flag::get(#"hash_3310bb35ce396e49"))
			{
				str_alias = #"hash_921478d69bafc7c";
			}
			level function_e44c7c0c(str_alias);
			if(!level flag::get(#"hash_3310bb35ce396e49"))
			{
				a_players = zm_zonemgr::get_players_in_zone("lighthouse_level_4", 1);
				player = namespace_509a75d1::function_3815943c(a_players);
				if(isdefined(player))
				{
					player namespace_3263198e::function_51b752a9(str_alias, -1, 0, 1);
				}
			}
			level flag::set(#"hash_641f14d0b2fd57d7");
			break;
		}
		wait(1);
	}
	level.pablo_npc thread function_1dc9b29a();
	level.pablo_npc thread function_57c115a8();
}

/*
	Name: function_57c115a8
	Namespace: namespace_85e029d3
	Checksum: 0xDE1A0191
	Offset: 0x1318
	Size: 0x1C8
	Parameters: 0
	Flags: Linked, Private
*/
function private function_57c115a8()
{
	level endon(#"hash_7b1d7041d240c3da");
	self endon(#"death");
	i = 0;
	var_8be6334f = array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9);
	var_de23a374 = array("lighthouse_level_1");
	while(true)
	{
		if(self.isspeaking == 0 && self.var_f75b1f16.size > 0 && namespace_509a75d1::any_player_in_zone(var_de23a374) && !namespace_509a75d1::any_player_in_zone("lighthouse_level_4"))
		{
			str_nag = self function_e81ee0e3();
			if(str_nag === #"hash_75f4c63702dc54e")
			{
				var_93843138 = var_8be6334f[i];
				i++;
				if(i > var_8be6334f.size)
				{
					i = 0;
					var_8be6334f = array::randomize(var_8be6334f);
				}
			}
			else
			{
				var_93843138 = self function_17440011();
			}
			level thread function_e44c7c0c(str_nag, var_93843138);
			wait(60);
		}
		else
		{
			wait(1);
		}
	}
}

/*
	Name: function_e81ee0e3
	Namespace: namespace_85e029d3
	Checksum: 0xE71920BC
	Offset: 0x14E8
	Size: 0x82
	Parameters: 0
	Flags: Linked, Private
*/
function private function_e81ee0e3()
{
	for(i = 0; i < self.var_f75b1f16.size; i++)
	{
		var_4ad2924d = self.var_f75b1f16[i];
		if(isdefined(self.var_cb3ed98f[var_4ad2924d].var_23d421c1))
		{
			return self.var_cb3ed98f[var_4ad2924d].var_23d421c1;
		}
	}
	return #"hash_75f4c63702dc54e";
}

/*
	Name: function_17440011
	Namespace: namespace_85e029d3
	Checksum: 0xEAAF8A53
	Offset: 0x1578
	Size: 0x74
	Parameters: 0
	Flags: Linked, Private
*/
function private function_17440011()
{
	for(i = 0; i < self.var_f75b1f16.size; i++)
	{
		var_4ad2924d = self.var_f75b1f16[i];
		if(isdefined(self.var_cb3ed98f[var_4ad2924d].var_f26e362))
		{
			return self.var_cb3ed98f[var_4ad2924d].var_f26e362;
		}
	}
	return undefined;
}

/*
	Name: register_drop_off
	Namespace: namespace_85e029d3
	Checksum: 0x51CBF0B1
	Offset: 0x15F8
	Size: 0xAA
	Parameters: 5
	Flags: Linked
*/
function register_drop_off(var_e303e136, str_hint, var_306b9dd6, func_interact, func_hint = undefined)
{
	s_interact = level.pablo_npc.var_cb3ed98f[var_e303e136];
	s_interact.str_hint = str_hint;
	s_interact.var_306b9dd6 = var_306b9dd6;
	s_interact.func_interact = func_interact;
	s_interact.func_hint = func_hint;
	s_interact.var_f6856302 = 1;
}

/*
	Name: function_3f9e02b8
	Namespace: namespace_85e029d3
	Checksum: 0x616D9065
	Offset: 0x16B0
	Size: 0xA6
	Parameters: 5
	Flags: Linked
*/
function function_3f9e02b8(n_pick_up, str_hint, var_306b9dd6, func_interact, func_hint = undefined)
{
	s_interact = level.pablo_npc.var_cb3ed98f[n_pick_up];
	s_interact.str_hint = str_hint;
	s_interact.var_306b9dd6 = var_306b9dd6;
	s_interact.func_interact = func_interact;
	s_interact.func_hint = func_hint;
	s_interact.var_f6856302 = 0;
}

/*
	Name: function_d83490c5
	Namespace: namespace_85e029d3
	Checksum: 0xBBDBF996
	Offset: 0x1760
	Size: 0xF2
	Parameters: 1
	Flags: Linked
*/
function function_d83490c5(n_quest)
{
	if(!isdefined(level.pablo_npc.var_f75b1f16))
	{
		level.pablo_npc.var_f75b1f16 = [];
	}
	else if(!isarray(level.pablo_npc.var_f75b1f16))
	{
		level.pablo_npc.var_f75b1f16 = array(level.pablo_npc.var_f75b1f16);
	}
	level.pablo_npc.var_f75b1f16[level.pablo_npc.var_f75b1f16.size] = n_quest;
	level.pablo_npc.var_f75b1f16 = array::sort_by_value(level.pablo_npc.var_f75b1f16, 1);
}

/*
	Name: function_6aaeff92
	Namespace: namespace_85e029d3
	Checksum: 0x66AF67AD
	Offset: 0x1860
	Size: 0x6A
	Parameters: 1
	Flags: Linked
*/
function function_6aaeff92(n_quest)
{
	arrayremovevalue(level.pablo_npc.var_f75b1f16, n_quest);
	level.pablo_npc.var_f75b1f16 = array::sort_by_value(level.pablo_npc.var_f75b1f16, 1);
}

/*
	Name: pablo_lift_init
	Namespace: namespace_85e029d3
	Checksum: 0x285EFA78
	Offset: 0x18D8
	Size: 0xEE
	Parameters: 0
	Flags: Linked
*/
function pablo_lift_init()
{
	level.var_f45a0bfd = struct::get("pablo_lift", "targetname");
	level.var_f45a0bfd flagsys::wait_till(#"scene_ents_ready");
	level.var_f45a0bfd.var_e205fbb = level.var_f45a0bfd.scene_ents[#"hash_7aff0ee60ddd937b"];
	level.var_f45a0bfd.is_moving = 0;
	for(i = 0; i < 12; i++)
	{
		level.var_f45a0bfd.var_e205fbb hidepart("tag_item_" + i);
	}
}

/*
	Name: function_a61b8406
	Namespace: namespace_85e029d3
	Checksum: 0xDCFAFCB1
	Offset: 0x19D0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_a61b8406()
{
	function_b9e15919(1);
	level.var_f45a0bfd scene::play("lower");
	function_b9e15919(0);
}

/*
	Name: function_6c49e9aa
	Namespace: namespace_85e029d3
	Checksum: 0xC9E5CEA1
	Offset: 0x1A30
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function function_6c49e9aa()
{
	function_b9e15919(1);
	level.var_f45a0bfd scene::play("raise");
	function_b9e15919(0);
}

/*
	Name: function_5ff0d681
	Namespace: namespace_85e029d3
	Checksum: 0x4F7BCD19
	Offset: 0x1A90
	Size: 0x8C
	Parameters: 1
	Flags: Linked
*/
function function_5ff0d681(index)
{
	level.var_f45a0bfd.var_e205fbb showpart("tag_item_" + index);
	if(index === 5)
	{
		level.var_f45a0bfd.var_e205fbb clientfield::set("" + #"hash_1b72c208f2964e24", level.var_ed1e7d4d);
	}
}

/*
	Name: function_d9161909
	Namespace: namespace_85e029d3
	Checksum: 0x89D53897
	Offset: 0x1B28
	Size: 0x84
	Parameters: 1
	Flags: Linked
*/
function function_d9161909(index)
{
	level.var_f45a0bfd.var_e205fbb hidepart("tag_item_" + index);
	if(index === 5)
	{
		level.var_f45a0bfd.var_e205fbb clientfield::set("" + #"hash_1b72c208f2964e24", 0);
	}
}

/*
	Name: function_12d23d57
	Namespace: namespace_85e029d3
	Checksum: 0x5FDAEE11
	Offset: 0x1BB8
	Size: 0xB6
	Parameters: 0
	Flags: Private
*/
function private function_12d23d57()
{
	while(true)
	{
		function_a61b8406();
		wait(1);
		for(i = 0; i < 12; i++)
		{
			function_5ff0d681(i);
			wait(1);
			function_d9161909(i);
			wait(0.5);
		}
		wait(3);
		function_6c49e9aa();
		function_d9161909(0);
		wait(3);
	}
}

/*
	Name: function_39614d4b
	Namespace: namespace_85e029d3
	Checksum: 0x8A73BC6E
	Offset: 0x1C78
	Size: 0x23E
	Parameters: 0
	Flags: Linked, Private
*/
function private function_39614d4b()
{
	arrayremovevalue(self.var_f75b1f16, self.var_df3d62aa);
	s_info = level.pablo_npc.var_cb3ed98f[level.pablo_npc.var_df3d62aa];
	level.var_f45a0bfd.is_moving = 1;
	/#
		iprintlnbold("");
	#/
	if(!s_info.var_f6856302)
	{
		function_d9161909(s_info.n_obj);
		level thread [[s_info.func_interact]]();
	}
	else
	{
		function_5ff0d681(s_info.n_obj);
		if(isdefined(s_info.var_80080852) && s_info.var_80080852)
		{
			level thread [[s_info.func_interact]]();
		}
	}
	wait(1);
	self thread function_9f77ef2(s_info);
	function_6c49e9aa();
	/#
		iprintlnbold("");
	#/
	if(s_info.var_f6856302)
	{
		function_d9161909(s_info.n_obj);
		if(!(isdefined(s_info.var_80080852) && s_info.var_80080852))
		{
			level thread [[s_info.func_interact]]();
		}
	}
	self flag::wait_till(#"hash_5945cee69b029018");
	self flag::clear(#"hash_5945cee69b029018");
	self.var_df3d62aa = undefined;
	level.var_f45a0bfd.is_moving = 0;
	self notify(#"hash_688d0bffbc9f5888");
}

/*
	Name: function_9f77ef2
	Namespace: namespace_85e029d3
	Checksum: 0xA9BE44AB
	Offset: 0x1EC0
	Size: 0xF4
	Parameters: 1
	Flags: Linked, Private
*/
function private function_9f77ef2(s_info)
{
	level endon(#"end_game");
	var_d2d60dc4 = 0;
	if(isdefined(level.var_d1206a2b))
	{
		var_d2d60dc4 = level.var_d1206a2b namespace_3263198e::function_51b752a9(s_info.var_e7b75754, -1, 0, 0);
	}
	if(isdefined(s_info.var_6e67b4c4) && s_info.var_6e67b4c4)
	{
		var_d2d60dc4 = 1;
	}
	if(isdefined(var_d2d60dc4) && var_d2d60dc4)
	{
		level function_e44c7c0c(s_info.var_e7b75754, s_info.var_c67e664c);
	}
	self flag::set(#"hash_5945cee69b029018");
}

/*
	Name: function_1dc9b29a
	Namespace: namespace_85e029d3
	Checksum: 0x6F137A0E
	Offset: 0x1FC0
	Size: 0x504
	Parameters: 0
	Flags: Linked, Private
*/
function private function_1dc9b29a()
{
	level endon(#"hash_7b1d7041d240c3da");
	self endon(#"death");
	while(true)
	{
		if(self.var_f75b1f16.size > 0 && namespace_509a75d1::any_player_in_zone("lighthouse_level_4"))
		{
			self.var_df3d62aa = self.var_f75b1f16[getfirstarraykey(self.var_f75b1f16)];
			s_info = self.var_cb3ed98f[self.var_df3d62aa];
			self.var_3e21d491.s_info = s_info;
			if(s_info.var_fcab5f41 === #"hash_37b261e51a21c0cc" && !level flag::get(#"hash_6e81da82129193f6"))
			{
				level function_e44c7c0c(s_info.var_fcab5f41, 0);
				level flag::set(#"hash_6e81da82129193f6");
			}
			else
			{
				if(s_info.var_fcab5f41 === #"vox_soap_stones_get")
				{
					level function_e44c7c0c("vox_vessel_pablo", 0);
					if(level.var_98138d6b > 1)
					{
						level.var_1c53964e namespace_509a75d1::function_6a0d675d("vox_vessel_pablo", 0, 0, 1);
						level function_e44c7c0c("vox_soap_stones_get", 0);
					}
				}
				else
				{
					if(s_info.var_fcab5f41 == #"hash_1856b015429225fa")
					{
						level thread function_e44c7c0c(s_info.var_fcab5f41, 0);
						wait(0.5);
						self.var_cb3ed98f[10].var_fcab5f41 = #"";
					}
					else if(s_info.var_fcab5f41 === #"hash_38aad0b1eae4093a" && !level flag::get(#"hash_59d5ba61f4b8f405") && !level flag::get(#"hash_6a7b24db9087b2eb"))
					{
						level flag::set(#"hash_6a7b24db9087b2eb");
						level thread function_e44c7c0c(s_info.var_fcab5f41, s_info.var_44dd0e20);
					}
				}
			}
			if(s_info.var_fcab5f41 !== #"hash_38aad0b1eae4093a")
			{
				level thread function_e44c7c0c(s_info.var_fcab5f41, s_info.var_44dd0e20);
			}
			level.var_f45a0bfd.is_moving = 1;
			/#
				iprintlnbold("");
			#/
			if(!s_info.var_f6856302)
			{
				function_5ff0d681(s_info.n_obj);
			}
			wait(1);
			function_a61b8406();
			/#
				iprintlnbold("");
			#/
			level.var_f45a0bfd.is_moving = 0;
			if(isdefined(s_info.var_80080852) && s_info.var_80080852)
			{
				self.var_3e21d491 namespace_509a75d1::function_6099877a(64, #"hash_688d0bffbc9f5888", s_info.str_hint, s_info.var_306b9dd6);
				self.var_3e21d491 function_30a02731();
			}
			else
			{
				self.var_3e21d491 zm_unitrigger::create(&function_6248ba90, 64);
				self.var_3e21d491 thread function_d7e79438();
				self thread function_e435077();
			}
			self waittill(#"hash_688d0bffbc9f5888");
		}
		wait(1);
	}
}

/*
	Name: function_e435077
	Namespace: namespace_85e029d3
	Checksum: 0x500780DF
	Offset: 0x24D0
	Size: 0x276
	Parameters: 0
	Flags: Linked
*/
function function_e435077()
{
	self endon(#"hash_276524e7f5657e50");
	s_info = self.var_cb3ed98f[self.var_df3d62aa];
	var_a3992d9c = 0;
	while(var_a3992d9c < 10)
	{
		var_a10acf3c = zm_zonemgr::get_players_in_zone("lighthouse_level_4", 1);
		var_23cd9374 = 0;
		if(self.var_f75b1f16.size > 0 && var_a10acf3c.size > 0)
		{
			if(isdefined(s_info.func_hint))
			{
				foreach(e_player in var_a10acf3c)
				{
					if(level [[s_info.func_hint]](e_player))
					{
						var_23cd9374 = 1;
					}
				}
			}
			else
			{
				var_23cd9374 = 1;
			}
		}
		if(var_23cd9374)
		{
			var_a3992d9c = 0;
		}
		else
		{
			var_a3992d9c = var_a3992d9c + 1;
		}
		wait(1);
	}
	level.pablo_npc notify(#"hash_ed7147b69728896");
	level.var_f45a0bfd.is_moving = 1;
	/#
		iprintlnbold("");
	#/
	function_6c49e9aa();
	/#
		iprintlnbold("");
	#/
	wait(1);
	if(!s_info.var_f6856302)
	{
		function_d9161909(s_info.n_obj);
	}
	zm_unitrigger::unregister_unitrigger(self.var_3e21d491.s_unitrigger);
	self.var_3e21d491.s_unitrigger = undefined;
	self.var_df3d62aa = undefined;
	level.var_f45a0bfd.is_moving = 0;
	self notify(#"hash_688d0bffbc9f5888");
}

/*
	Name: function_6248ba90
	Namespace: namespace_85e029d3
	Checksum: 0x9408DE2C
	Offset: 0x2750
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_6248ba90(e_player)
{
	s_info = self.stub.related_parent.s_info;
	var_832ffcd4 = 1;
	if(isdefined(s_info.func_hint))
	{
		var_832ffcd4 = level [[s_info.func_hint]](e_player);
	}
	if(var_832ffcd4)
	{
		self sethintstring(zm_utility::function_d6046228(s_info.str_hint, s_info.var_306b9dd6));
		return true;
	}
	return false;
}

/*
	Name: function_d7e79438
	Namespace: namespace_85e029d3
	Checksum: 0x417DB4BA
	Offset: 0x2818
	Size: 0x1B6
	Parameters: 0
	Flags: Linked, Private
*/
function private function_d7e79438()
{
	self endon(#"death");
	level.pablo_npc endon(#"hash_ed7147b69728896");
	s_activation = undefined;
	s_activation = self waittill(#"trigger_activated");
	level.var_d1206a2b = s_activation.e_who;
	s_info = level.pablo_npc.var_cb3ed98f[level.pablo_npc.var_df3d62aa];
	if(s_info.var_fcab5f41 === #"hash_38aad0b1eae4093a" && !level flag::get(#"hash_59d5ba61f4b8f405") && !level flag::get(#"hash_6a7b24db9087b2eb"))
	{
		level.var_d1206a2b thread namespace_3263198e::function_51b752a9(s_info.var_fcab5f41, -1, 1, 0);
	}
	level.pablo_npc notify(#"hash_276524e7f5657e50");
	playsoundatposition(#"hash_512bec1d554e89f1", self.origin);
	level.pablo_npc thread function_39614d4b();
	zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
	self.s_unitrigger = undefined;
}

/*
	Name: function_30a02731
	Namespace: namespace_85e029d3
	Checksum: 0x38BC0851
	Offset: 0x29D8
	Size: 0x5C
	Parameters: 0
	Flags: Linked, Private
*/
function private function_30a02731()
{
	self endon(#"death");
	playsoundatposition(#"hash_512bec1d554e89f1", self.origin);
	level.pablo_npc thread function_39614d4b();
}

