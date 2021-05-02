// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_1615105f580458d3;
#using script_2694b388c90e575;
#using script_6e3c826b1814cab6;
#using script_b00fcbc28051f15;
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\scene_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\util_shared.gsc;
#using scripts\zm_common\zm.gsc;
#using scripts\zm_common\zm_audio.gsc;
#using scripts\zm_common\zm_net.gsc;
#using scripts\zm_common\zm_utility.gsc;

#namespace namespace_2411052e;

/*
	Name: function_89f2df9
	Namespace: namespace_2411052e
	Checksum: 0x177FACED
	Offset: 0x1C0
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"hash_604502ae18a3644f", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: namespace_2411052e
	Checksum: 0x8D1F97D6
	Offset: 0x210
	Size: 0x52
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level flag::init(#"warden_blundergat_obtained");
	level._effect[#"ee_skull_shot"] = #"electric/fx_elec_sparks_burst_sm_omni_blue_os";
}

/*
	Name: __main__
	Namespace: namespace_2411052e
	Checksum: 0x7F4CB73E
	Offset: 0x270
	Size: 0x2C
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	if(zm_utility::is_standard())
	{
		return;
	}
	level thread wait_for_initial_conditions();
}

/*
	Name: wait_for_initial_conditions
	Namespace: namespace_2411052e
	Checksum: 0xCA1083C8
	Offset: 0x2A8
	Size: 0x3BC
	Parameters: 0
	Flags: Linked
*/
function wait_for_initial_conditions()
{
	level.sq_bg_macguffins = [];
	a_s_mcguffin = struct::get_array("struct_sq_bg_macguffin", "targetname");
	foreach(struct in a_s_mcguffin)
	{
		var_a2a0a44e = util::spawn_model("p8_zm_esc_skull_afterlife_glass", struct.origin, struct.angles);
		var_a2a0a44e.targetname = "sq_bg_macguffin";
		if(!isdefined(level.sq_bg_macguffins))
		{
			level.sq_bg_macguffins = [];
		}
		else if(!isarray(level.sq_bg_macguffins))
		{
			level.sq_bg_macguffins = array(level.sq_bg_macguffins);
		}
		if(!isinarray(level.sq_bg_macguffins, var_a2a0a44e))
		{
			level.sq_bg_macguffins[level.sq_bg_macguffins.size] = var_a2a0a44e;
		}
	}
	array::thread_all(level.sq_bg_macguffins, &sq_bg_macguffin_think);
	array::thread_all(level.sq_bg_macguffins, &namespace_b4a066ff::function_16dd8932);
	if(!isdefined(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = [];
	}
	else if(!isarray(level.a_tomahawk_pickup_funcs))
	{
		level.a_tomahawk_pickup_funcs = array(level.a_tomahawk_pickup_funcs);
	}
	level.a_tomahawk_pickup_funcs[level.a_tomahawk_pickup_funcs.size] = &tomahawk_the_macguffin;
	level thread check_sq_bg_progress();
	level waittill(#"all_macguffins_acquired");
	var_dd7441ab = struct::get("sq_bg_reward_pickup", "targetname");
	t_reward_pickup = spawn("trigger_radius_use", var_dd7441ab.origin, 0, 96, 64);
	if(function_8b1a219a())
	{
		t_reward_pickup sethintstring(#"hash_13148440ddb20104");
	}
	else
	{
		t_reward_pickup sethintstring(#"hash_3d510922bc950f08");
	}
	t_reward_pickup setcursorhint("HINT_NOICON");
	t_reward_pickup triggerignoreteam();
	t_reward_pickup setvisibletoall();
	t_reward_pickup thread give_sq_bg_reward(var_dd7441ab);
}

/*
	Name: sq_bg_macguffin_think
	Namespace: namespace_2411052e
	Checksum: 0xFDB19118
	Offset: 0x670
	Size: 0x168
	Parameters: 0
	Flags: Linked
*/
function sq_bg_macguffin_think()
{
	level endon(#"hash_6a6919e3cb8ef81");
	self endon(#"sq_bg_macguffin_received_by_player");
	self.health = 10000;
	self setcandamage(1);
	self setforcenocull();
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"damage");
		if(isplayer(var_88706ea7.attacker) && (var_88706ea7.weapon == getweapon(#"tomahawk_t8") || var_88706ea7.weapon == getweapon(#"tomahawk_t8_upgraded")))
		{
			playfx(level._effect[#"ee_skull_shot"], self.origin);
			self thread wait_and_hide_sq_bg_macguffin();
		}
	}
}

/*
	Name: wait_and_hide_sq_bg_macguffin
	Namespace: namespace_2411052e
	Checksum: 0x7C72E59D
	Offset: 0x7E0
	Size: 0x7C
	Parameters: 0
	Flags: Linked
*/
function wait_and_hide_sq_bg_macguffin()
{
	self notify(#"restart_show_timer");
	self endon(#"restart_show_timer", #"caught_by_tomahawk", #"sq_bg_macguffin_received_by_player", #"death");
	wait(1.6);
	if(isdefined(self))
	{
		self ghost();
	}
}

/*
	Name: tomahawk_the_macguffin
	Namespace: namespace_2411052e
	Checksum: 0xA1179B7F
	Offset: 0x868
	Size: 0x210
	Parameters: 2
	Flags: Linked
*/
function tomahawk_the_macguffin(e_grenade, n_grenade_charge_power)
{
	if(!isdefined(level.sq_bg_macguffins) || level.sq_bg_macguffins.size <= 0)
	{
		return 0;
	}
	if(!isdefined(e_grenade))
	{
		return 0;
	}
	foreach(var_a2a0a44e in level.sq_bg_macguffins)
	{
		if(!isdefined(var_a2a0a44e))
		{
			continue;
		}
		if(!(isdefined(var_a2a0a44e.var_410930d5) && var_a2a0a44e.var_410930d5) && distancesquared(var_a2a0a44e.origin, e_grenade.origin) < 100 * 100)
		{
			var_a2a0a44e.var_410930d5 = 1;
			var_6e6ec518 = namespace_268fc37c::tomahawk_spawn(e_grenade.origin);
			var_6e6ec518.n_grenade_charge_power = n_grenade_charge_power;
			var_a2a0a44e notify(#"caught_by_tomahawk");
			var_a2a0a44e.origin = e_grenade.origin;
			var_a2a0a44e linkto(var_6e6ec518);
			var_a2a0a44e clientfield::set("" + #"hash_3c8cd47650fbb324", 2);
			self thread namespace_268fc37c::tomahawk_return_player(var_6e6ec518, undefined, 800);
			self thread give_player_macguffin_upon_receipt(var_6e6ec518, var_a2a0a44e);
			return 1;
		}
	}
	return 0;
}

/*
	Name: give_player_macguffin_upon_receipt
	Namespace: namespace_2411052e
	Checksum: 0xA92AD890
	Offset: 0xA80
	Size: 0xC8
	Parameters: 2
	Flags: Linked
*/
function give_player_macguffin_upon_receipt(var_6e6ec518, var_a2a0a44e)
{
	v_org = self.origin;
	while(isdefined(var_6e6ec518))
	{
		waitframe(1);
	}
	var_a2a0a44e notify(#"sq_bg_macguffin_received_by_player");
	arrayremovevalue(level.sq_bg_macguffins, var_a2a0a44e);
	var_a2a0a44e delete();
	zm_utility::play_sound_at_pos("purchase", v_org);
	level notify(#"sq_bg_macguffin_collected", {#e_player:self});
}

/*
	Name: check_sq_bg_progress
	Namespace: namespace_2411052e
	Checksum: 0x373AF8BA
	Offset: 0xB50
	Size: 0x10C
	Parameters: 0
	Flags: Linked
*/
function check_sq_bg_progress()
{
	n_macguffins_total = level.sq_bg_macguffins.size;
	n_macguffins_collected = 0;
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = level waittill(#"sq_bg_macguffin_collected");
		e_player = var_88706ea7.e_player;
		n_macguffins_collected++;
		if(n_macguffins_collected >= n_macguffins_total)
		{
			level notify(#"all_macguffins_acquired");
			break;
		}
		else if(isplayer(e_player))
		{
			e_player thread play_sq_bg_collected_vo();
		}
	}
	wait(1);
	if(isplayer(e_player))
	{
		e_player playsound(#"zmb_easteregg_laugh");
	}
}

/*
	Name: play_sq_bg_collected_vo
	Namespace: namespace_2411052e
	Checksum: 0xD02440A0
	Offset: 0xC68
	Size: 0x44
	Parameters: 0
	Flags: Linked
*/
function play_sq_bg_collected_vo()
{
	self endon(#"disconnect");
	wait(1);
	self thread zm_utility::do_player_general_vox("quest", "pick_up_easter_egg");
}

/*
	Name: give_sq_bg_reward
	Namespace: namespace_2411052e
	Checksum: 0x81FAD9AF
	Offset: 0xCB8
	Size: 0x51C
	Parameters: 1
	Flags: Linked
*/
function give_sq_bg_reward(var_dd7441ab)
{
	t_near = spawn("trigger_radius", var_dd7441ab.origin, 0, 196, 64);
	t_near thread sq_bg_spawn_rumble();
	var_4d0b3b87 = zm_utility::spawn_weapon_model(getweapon(#"hash_19c157f2230454ad"), undefined, var_dd7441ab.origin + vectorscale((0, 0, 1), 6), var_dd7441ab.angles);
	var_4d0b3b87 clientfield::set("" + #"hash_f03061885875815", 1);
	var_4d0b3b87 thread scene::play(#"hash_2fe3067b201e6610", var_4d0b3b87);
	while(isdefined(self))
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		e_player = var_88706ea7.activator;
		if(zm_utility::can_use(e_player, 1) && e_player.currentweapon.name != "none")
		{
			if(e_player hasweapon(getweapon(#"hash_19c157f2230454ad")) || e_player hasweapon(getweapon(#"hash_cb1cdb5b47f0226")) || e_player hasweapon(getweapon(#"hash_25a13b6f6232a985")) || e_player hasweapon(getweapon(#"hash_4c157b1aeefae09e")) || e_player hasweapon(getweapon(#"hash_23882a5729dceca")) || e_player hasweapon(getweapon(#"hash_1b5092cccdb3d65b")) || e_player hasweapon(getweapon(#"hash_617dcc39334959ce")))
			{
				self sethintstringforplayer(e_player, #"hash_e8fb80933bfb033");
				foreach(var_7653f3d0 in level.activeplayers)
				{
					if(var_7653f3d0 != e_player)
					{
						self setinvisibletoplayer(var_7653f3d0, 1);
					}
				}
				wait(3);
				foreach(var_7653f3d0 in level.activeplayers)
				{
					self setvisibletoplayer(var_7653f3d0);
					if(function_8b1a219a())
					{
						self sethintstringforplayer(e_player, #"hash_13148440ddb20104");
						continue;
					}
					self sethintstringforplayer(e_player, #"hash_3d510922bc950f08");
				}
				continue;
			}
			else
			{
				var_4d0b3b87 thread function_d61275a7();
				e_player take_old_weapon_and_give_reward();
				self delete();
			}
		}
	}
	t_near delete();
}

/*
	Name: function_d61275a7
	Namespace: namespace_2411052e
	Checksum: 0x7C6C2B0E
	Offset: 0x11E0
	Size: 0x64
	Parameters: 0
	Flags: Linked, Private
*/
private function function_d61275a7()
{
	self clientfield::set("" + #"hash_f03061885875815", 0);
	self ghost();
	wait(5);
	self delete();
}

/*
	Name: sq_bg_spawn_rumble
	Namespace: namespace_2411052e
	Checksum: 0x3DFE838B
	Offset: 0x1250
	Size: 0x6C
	Parameters: 0
	Flags: Linked
*/
function sq_bg_spawn_rumble()
{
	self endon(#"death");
	while(true)
	{
		var_88706ea7 = undefined;
		var_88706ea7 = self waittill(#"trigger");
		wait(0.1);
	}
}

/*
	Name: take_old_weapon_and_give_reward
	Namespace: namespace_2411052e
	Checksum: 0xC44B85D3
	Offset: 0x12C8
	Size: 0x12C
	Parameters: 0
	Flags: Linked
*/
function take_old_weapon_and_give_reward()
{
	var_287a8343 = zm_utility::get_player_weapon_limit(self);
	var_4f33a328 = self getweaponslistprimaries();
	if(isdefined(var_4f33a328) && var_4f33a328.size >= var_287a8343)
	{
		self takeweapon(self.currentweapon);
	}
	self giveweapon(getweapon(#"hash_19c157f2230454ad"));
	self switchtoweapon(getweapon(#"hash_19c157f2230454ad"));
	level flag::set(#"warden_blundergat_obtained");
	self thread zm_audio::create_and_play_dialog(#"magicbox", #"wonder");
}

