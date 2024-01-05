// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\callbacks_shared.gsc;

#namespace visionset_mgr;

/*
	Name: __init__system__
	Namespace: visionset_mgr
	Checksum: 0xD3799D1B
	Offset: 0xE8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"visionset_mgr", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: visionset_mgr
	Checksum: 0xE1E7670D
	Offset: 0x130
	Size: 0xD4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.vsmgr_initializing = 1;
	level.vsmgr_default_info_name = "__none";
	level.var_7506365 = [];
	level.vsmgr = [];
	level thread register_type("visionset");
	level thread register_type("overlay");
	callback::on_finalize_initialization(&finalize_clientfields);
	level thread monitor();
	callback::on_connect(&on_player_connect);
}

/*
	Name: register_info
	Namespace: visionset_mgr
	Checksum: 0xDC3FA
	Offset: 0x210
	Size: 0x196
	Parameters: 8
	Flags: Linked
*/
function register_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread)
{
	/#
		assert(level.vsmgr_initializing, "");
	#/
	lower_name = tolower(name);
	validate_info(type, lower_name, priority);
	add_sorted_name_key(type, lower_name);
	add_sorted_priority_key(type, lower_name, priority);
	level.vsmgr[type].info[lower_name] = spawnstruct();
	level.vsmgr[type].info[lower_name] add_info(type, lower_name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread);
	if(level.vsmgr[type].highest_version < version)
	{
		level.vsmgr[type].highest_version = version;
	}
}

/*
	Name: activate
	Namespace: visionset_mgr
	Checksum: 0x8BE1EC0F
	Offset: 0x3B0
	Size: 0x18E
	Parameters: 6
	Flags: Linked
*/
function activate(type, name, player, opt_param_1, opt_param_2, opt_param_3)
{
	if(level.vsmgr[type].info[name].state.should_activate_per_player)
	{
		activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3);
		return;
	}
	state = level.vsmgr[type].info[name].state;
	if(state.ref_count_lerp_thread)
	{
		state.ref_count++;
		if(1 < state.ref_count)
		{
			return;
		}
	}
	if(isdefined(state.lerp_thread))
	{
		state thread lerp_thread_wrapper(state.lerp_thread, opt_param_1, opt_param_2, opt_param_3);
	}
	else
	{
		players = getplayers();
		for(player_index = 0; player_index < players.size; player_index++)
		{
			state set_state_active(players[player_index], 1);
		}
	}
}

/*
	Name: deactivate
	Namespace: visionset_mgr
	Checksum: 0x8AB82388
	Offset: 0x548
	Size: 0x138
	Parameters: 3
	Flags: Linked
*/
function deactivate(type, name, player)
{
	if(level.vsmgr[type].info[name].state.should_activate_per_player)
	{
		deactivate_per_player(type, name, player);
		return;
	}
	state = level.vsmgr[type].info[name].state;
	if(state.ref_count_lerp_thread)
	{
		state.ref_count--;
		if(0 < state.ref_count)
		{
			return;
		}
	}
	players = getplayers();
	for(player_index = 0; player_index < players.size; player_index++)
	{
		state set_state_inactive(players[player_index]);
	}
	state notify(#"visionset_mgr_deactivate_all");
}

/*
	Name: set_state_active
	Namespace: visionset_mgr
	Checksum: 0x60030716
	Offset: 0x688
	Size: 0xA2
	Parameters: 2
	Flags: Linked
*/
function set_state_active(player, lerp)
{
	if(!isdefined(player))
	{
		return;
	}
	player_entnum = player getentitynumber();
	if(!isdefined(self.players[player_entnum]))
	{
		return;
	}
	self.players[player_entnum].active = 1;
	self.players[player_entnum].lerp = lerp;
	level.var_7506365[player_entnum] = player;
}

/*
	Name: set_state_inactive
	Namespace: visionset_mgr
	Checksum: 0x55E5AD57
	Offset: 0x738
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function set_state_inactive(player)
{
	if(!isdefined(player))
	{
		return;
	}
	player_entnum = player getentitynumber();
	if(!isdefined(self.players[player_entnum]))
	{
		return;
	}
	self.players[player_entnum].active = 0;
	self.players[player_entnum].lerp = 0;
	level.var_7506365[player_entnum] = player;
}

/*
	Name: timeout_lerp_thread
	Namespace: visionset_mgr
	Checksum: 0x9988AE37
	Offset: 0x7D8
	Size: 0xA4
	Parameters: 3
	Flags: None
*/
function timeout_lerp_thread(timeout, opt_param_2, opt_param_3)
{
	players = getplayers();
	for(player_index = 0; player_index < players.size; player_index++)
	{
		self set_state_active(players[player_index], 1);
	}
	wait(timeout);
	deactivate(self.type, self.name);
}

/*
	Name: timeout_lerp_thread_per_player
	Namespace: visionset_mgr
	Checksum: 0xB336F48B
	Offset: 0x888
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function timeout_lerp_thread_per_player(player, timeout, opt_param_2, opt_param_3)
{
	self set_state_active(player, 1);
	wait(timeout);
	deactivate_per_player(self.type, self.name, player);
}

/*
	Name: duration_lerp_thread
	Namespace: visionset_mgr
	Checksum: 0x406C51AC
	Offset: 0x900
	Size: 0x154
	Parameters: 2
	Flags: None
*/
function duration_lerp_thread(duration, max_duration)
{
	start_time = gettime();
	end_time = start_time + (int(duration * 1000));
	if(isdefined(max_duration))
	{
		start_time = end_time - (int(max_duration * 1000));
	}
	while(true)
	{
		lerp = calc_remaining_duration_lerp(start_time, end_time);
		if(0 >= lerp)
		{
			break;
		}
		players = getplayers();
		for(player_index = 0; player_index < players.size; player_index++)
		{
			self set_state_active(players[player_index], lerp);
		}
		waitframe(1);
	}
	deactivate(self.type, self.name);
}

/*
	Name: duration_lerp_thread_per_player
	Namespace: visionset_mgr
	Checksum: 0xFE29A1F0
	Offset: 0xA60
	Size: 0x114
	Parameters: 3
	Flags: None
*/
function duration_lerp_thread_per_player(player, duration, max_duration)
{
	start_time = gettime();
	end_time = start_time + (int(duration * 1000));
	if(isdefined(max_duration))
	{
		start_time = end_time - (int(max_duration * 1000));
	}
	while(true)
	{
		lerp = calc_remaining_duration_lerp(start_time, end_time);
		if(0 >= lerp)
		{
			break;
		}
		self set_state_active(player, lerp);
		waitframe(1);
	}
	deactivate_per_player(self.type, self.name, player);
}

/*
	Name: ramp_in_thread_per_player
	Namespace: visionset_mgr
	Checksum: 0x965174EE
	Offset: 0xB80
	Size: 0xB6
	Parameters: 2
	Flags: None
*/
function ramp_in_thread_per_player(player, duration)
{
	start_time = gettime();
	end_time = start_time + (int(duration * 1000));
	while(true)
	{
		lerp = calc_ramp_in_lerp(start_time, end_time);
		if(1 <= lerp)
		{
			break;
		}
		self set_state_active(player, lerp);
		waitframe(1);
	}
}

/*
	Name: ramp_in_out_thread_hold_func
	Namespace: visionset_mgr
	Checksum: 0x82B34222
	Offset: 0xC40
	Size: 0x80
	Parameters: 0
	Flags: Linked
*/
function ramp_in_out_thread_hold_func()
{
	level endon(#"kill_ramp_in_out_thread_hold_func");
	while(true)
	{
		for(player_index = 0; player_index < level.players.size; player_index++)
		{
			self set_state_active(level.players[player_index], 1);
		}
		waitframe(1);
	}
}

/*
	Name: ramp_in_out_thread
	Namespace: visionset_mgr
	Checksum: 0xF4F23084
	Offset: 0xCC8
	Size: 0x24C
	Parameters: 3
	Flags: None
*/
function ramp_in_out_thread(ramp_in, full_period, ramp_out)
{
	start_time = gettime();
	end_time = start_time + (int(ramp_in * 1000));
	while(true)
	{
		lerp = calc_ramp_in_lerp(start_time, end_time);
		if(1 <= lerp)
		{
			break;
		}
		players = getplayers();
		for(player_index = 0; player_index < players.size; player_index++)
		{
			self set_state_active(players[player_index], lerp);
		}
		waitframe(1);
	}
	self thread ramp_in_out_thread_hold_func();
	if(isfunctionptr(full_period))
	{
		self [[full_period]]();
	}
	else
	{
		wait(full_period);
	}
	level notify(#"kill_ramp_in_out_thread_hold_func");
	start_time = gettime();
	end_time = start_time + (int(ramp_out * 1000));
	while(true)
	{
		lerp = calc_remaining_duration_lerp(start_time, end_time);
		if(0 >= lerp)
		{
			break;
		}
		players = getplayers();
		for(player_index = 0; player_index < players.size; player_index++)
		{
			self set_state_active(players[player_index], lerp);
		}
		waitframe(1);
	}
	deactivate(self.type, self.name);
}

/*
	Name: ramp_in_out_thread_per_player_internal
	Namespace: visionset_mgr
	Checksum: 0x465306B
	Offset: 0xF20
	Size: 0x1C4
	Parameters: 4
	Flags: Linked
*/
function ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out)
{
	start_time = gettime();
	end_time = start_time + (int(ramp_in * 1000));
	while(true)
	{
		lerp = calc_ramp_in_lerp(start_time, end_time);
		if(1 <= lerp)
		{
			break;
		}
		self set_state_active(player, lerp);
		waitframe(1);
	}
	self set_state_active(player, lerp);
	if(isfunctionptr(full_period))
	{
		player [[full_period]]();
	}
	else
	{
		wait(full_period);
	}
	start_time = gettime();
	end_time = start_time + (int(ramp_out * 1000));
	while(true)
	{
		lerp = calc_remaining_duration_lerp(start_time, end_time);
		if(0 >= lerp)
		{
			break;
		}
		self set_state_active(player, lerp);
		waitframe(1);
	}
	deactivate_per_player(self.type, self.name, player);
}

/*
	Name: ramp_in_out_thread_watch_player_shutdown
	Namespace: visionset_mgr
	Checksum: 0xC88F800
	Offset: 0x10F0
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function ramp_in_out_thread_watch_player_shutdown(player)
{
	player notify(#"ramp_in_out_thread_watch_player_shutdown");
	player endon(#"ramp_in_out_thread_watch_player_shutdown", #"disconnect");
	player waittill(#"death");
	if(player isremotecontrolling() == 0)
	{
		deactivate_per_player(self.type, self.name, player);
	}
}

/*
	Name: ramp_in_out_thread_per_player_death_shutdown
	Namespace: visionset_mgr
	Checksum: 0x765DA885
	Offset: 0x1198
	Size: 0x6C
	Parameters: 4
	Flags: None
*/
function ramp_in_out_thread_per_player_death_shutdown(player, ramp_in, full_period, ramp_out)
{
	player endon(#"death");
	thread ramp_in_out_thread_watch_player_shutdown(player);
	ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

/*
	Name: ramp_in_out_thread_per_player
	Namespace: visionset_mgr
	Checksum: 0xC0DD826F
	Offset: 0x1210
	Size: 0x44
	Parameters: 4
	Flags: Linked
*/
function ramp_in_out_thread_per_player(player, ramp_in, full_period, ramp_out)
{
	ramp_in_out_thread_per_player_internal(player, ramp_in, full_period, ramp_out);
}

/*
	Name: register_type
	Namespace: visionset_mgr
	Checksum: 0x37F3C4C1
	Offset: 0x1260
	Size: 0x154
	Parameters: 1
	Flags: Linked
*/
function register_type(type)
{
	level.vsmgr[type] = spawnstruct();
	level.vsmgr[type].type = type;
	level.vsmgr[type].in_use = 0;
	level.vsmgr[type].highest_version = 0;
	level.vsmgr[type].cf_slot_name = type + "_slot";
	level.vsmgr[type].cf_lerp_name = type + "_lerp";
	level.vsmgr[type].info = [];
	level.vsmgr[type].sorted_name_keys = [];
	level.vsmgr[type].sorted_prio_keys = [];
	register_info(type, level.vsmgr_default_info_name, 1, 0, 1, 0, undefined);
}

/*
	Name: finalize_clientfields
	Namespace: visionset_mgr
	Checksum: 0x6B722888
	Offset: 0x13C0
	Size: 0x8E
	Parameters: 0
	Flags: Linked
*/
function finalize_clientfields()
{
	foreach(v in level.vsmgr)
	{
		v thread finalize_type_clientfields();
	}
	level.vsmgr_initializing = 0;
}

/*
	Name: finalize_type_clientfields
	Namespace: visionset_mgr
	Checksum: 0x6081AB67
	Offset: 0x1458
	Size: 0x23C
	Parameters: 0
	Flags: Linked
*/
function finalize_type_clientfields()
{
	/#
		println(("" + self.type) + "");
	#/
	if(1 >= self.info.size)
	{
		return;
	}
	self.in_use = 1;
	self.cf_slot_bit_count = getminbitcountfornum(self.info.size - 1);
	self.cf_lerp_bit_count = self.info[self.sorted_name_keys[0]].lerp_bit_count;
	for(i = 0; i < self.sorted_name_keys.size; i++)
	{
		self.info[self.sorted_name_keys[i]].slot_index = i;
		if(self.info[self.sorted_name_keys[i]].lerp_bit_count > self.cf_lerp_bit_count)
		{
			self.cf_lerp_bit_count = self.info[self.sorted_name_keys[i]].lerp_bit_count;
		}
		/#
			println(((((("" + self.info[self.sorted_name_keys[i]].name) + "") + self.info[self.sorted_name_keys[i]].version) + "") + self.info[self.sorted_name_keys[i]].lerp_step_count) + "");
		#/
	}
	clientfield::register("toplayer", self.cf_slot_name, self.highest_version, self.cf_slot_bit_count, "int");
	if(1 < self.cf_lerp_bit_count)
	{
		clientfield::register("toplayer", self.cf_lerp_name, self.highest_version, self.cf_lerp_bit_count, "float");
	}
}

/*
	Name: validate_info
	Namespace: visionset_mgr
	Checksum: 0xE3AA3D31
	Offset: 0x16A0
	Size: 0x1E0
	Parameters: 3
	Flags: Linked
*/
function validate_info(type, name, priority)
{
	keys = getarraykeys(level.vsmgr);
	for(i = 0; i < keys.size; i++)
	{
		if(type == keys[i])
		{
			break;
		}
	}
	/#
		assert(i < keys.size, ("" + type) + "");
	#/
	foreach(v in level.vsmgr[type].info)
	{
		/#
			assert(v.name != name, ((("" + type) + "") + name) + "");
		#/
		/#
			assert(v.priority != priority, ((((((("" + type) + "") + priority) + "") + name) + "") + v.name) + "");
		#/
	}
}

/*
	Name: add_sorted_name_key
	Namespace: visionset_mgr
	Checksum: 0x27E7E24E
	Offset: 0x1888
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function add_sorted_name_key(type, name)
{
	for(i = 0; i < level.vsmgr[type].sorted_name_keys.size; i++)
	{
		if(name < level.vsmgr[type].sorted_name_keys[i])
		{
			break;
		}
	}
	arrayinsert(level.vsmgr[type].sorted_name_keys, name, i);
}

/*
	Name: add_sorted_priority_key
	Namespace: visionset_mgr
	Checksum: 0xB389820E
	Offset: 0x1930
	Size: 0xC4
	Parameters: 3
	Flags: Linked
*/
function add_sorted_priority_key(type, name, priority)
{
	for(i = 0; i < level.vsmgr[type].sorted_prio_keys.size; i++)
	{
		if(priority > level.vsmgr[type].info[level.vsmgr[type].sorted_prio_keys[i]].priority)
		{
			break;
		}
	}
	arrayinsert(level.vsmgr[type].sorted_prio_keys, name, i);
}

/*
	Name: add_info
	Namespace: visionset_mgr
	Checksum: 0xA4CF9FF7
	Offset: 0x1A00
	Size: 0x15A
	Parameters: 8
	Flags: Linked
*/
function add_info(type, name, version, priority, lerp_step_count, should_activate_per_player, lerp_thread, ref_count_lerp_thread)
{
	self.type = type;
	self.name = name;
	self.version = version;
	self.priority = priority;
	self.lerp_step_count = lerp_step_count;
	self.lerp_bit_count = getminbitcountfornum(lerp_step_count);
	if(!isdefined(ref_count_lerp_thread))
	{
		ref_count_lerp_thread = 0;
	}
	self.state = spawnstruct();
	self.state.type = type;
	self.state.name = name;
	self.state.should_activate_per_player = should_activate_per_player;
	self.state.lerp_thread = lerp_thread;
	self.state.ref_count_lerp_thread = ref_count_lerp_thread;
	self.state.players = [];
	if(ref_count_lerp_thread && !should_activate_per_player)
	{
		self.state.ref_count = 0;
	}
}

/*
	Name: on_player_connect
	Namespace: visionset_mgr
	Checksum: 0x1AF86982
	Offset: 0x1B68
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function on_player_connect()
{
	self player_setup();
}

/*
	Name: player_setup
	Namespace: visionset_mgr
	Checksum: 0x88EB180B
	Offset: 0x1B90
	Size: 0x238
	Parameters: 0
	Flags: Linked
*/
function player_setup()
{
	self.vsmgr_player_entnum = self getentitynumber();
	foreach(v in level.vsmgr)
	{
		if(!v.in_use)
		{
			continue;
		}
		for(name_index = 0; name_index < v.sorted_name_keys.size; name_index++)
		{
			name_key = v.sorted_name_keys[name_index];
			v.info[name_key].state.players[self.vsmgr_player_entnum] = spawnstruct();
			v.info[name_key].state.players[self.vsmgr_player_entnum].active = 0;
			v.info[name_key].state.players[self.vsmgr_player_entnum].lerp = 0;
			if(v.info[name_key].state.ref_count_lerp_thread && v.info[name_key].state.should_activate_per_player)
			{
				v.info[name_key].state.players[self.vsmgr_player_entnum].ref_count = 0;
			}
		}
		v.info[level.vsmgr_default_info_name].state set_state_active(self, 1);
	}
}

/*
	Name: player_shutdown
	Namespace: visionset_mgr
	Checksum: 0x784236BD
	Offset: 0x1DD0
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function player_shutdown()
{
	self.vsmgr_player_entnum = self getentitynumber();
	foreach(k, v in level.vsmgr)
	{
		if(!v.in_use)
		{
			continue;
		}
		foreach(name_key in v.sorted_name_keys)
		{
			deactivate_per_player(k, name_key, self);
		}
	}
}

/*
	Name: monitor
	Namespace: visionset_mgr
	Checksum: 0xDBDCF27A
	Offset: 0x1EF8
	Size: 0x188
	Parameters: 0
	Flags: Linked
*/
function monitor()
{
	self notify("48907f6028d1eaca");
	self endon("48907f6028d1eaca");
	while(level.vsmgr_initializing)
	{
		waitframe(1);
	}
	while(true)
	{
		waitframe(1);
		waittillframeend();
		foreach(player in level.var_7506365)
		{
			if(isdefined(player) && isplayer(player) && isalive(player))
			{
				foreach(v in level.vsmgr)
				{
					if(!v.in_use)
					{
						continue;
					}
					update_clientfields(player, v);
				}
			}
		}
		level.var_7506365 = [];
	}
}

/*
	Name: get_first_active_name
	Namespace: visionset_mgr
	Checksum: 0x83A128EC
	Offset: 0x2088
	Size: 0xC2
	Parameters: 1
	Flags: Linked
*/
function get_first_active_name(type_struct)
{
	size = type_struct.sorted_prio_keys.size;
	for(prio_index = 0; prio_index < size; prio_index++)
	{
		prio_key = type_struct.sorted_prio_keys[prio_index];
		if(!isdefined(prio_key))
		{
			continue;
		}
		if(isdefined(self.vsmgr_player_entnum) && type_struct.info[prio_key].state.players[self.vsmgr_player_entnum].active)
		{
			return prio_key;
		}
	}
	return level.vsmgr_default_info_name;
}

/*
	Name: update_clientfields
	Namespace: visionset_mgr
	Checksum: 0x5B7B0D97
	Offset: 0x2158
	Size: 0x10C
	Parameters: 2
	Flags: Linked
*/
function update_clientfields(player, type_struct)
{
	if(!isdefined(player))
	{
		return;
	}
	name = player get_first_active_name(type_struct);
	player clientfield::set_to_player(type_struct.cf_slot_name, type_struct.info[name].slot_index);
	if(1 < type_struct.cf_lerp_bit_count)
	{
		if(!isdefined(player.vsmgr_player_entnum))
		{
			player.vsmgr_player_entnum = player getentitynumber();
		}
		player clientfield::set_to_player(type_struct.cf_lerp_name, type_struct.info[name].state.players[player.vsmgr_player_entnum].lerp);
	}
}

/*
	Name: lerp_thread_wrapper
	Namespace: visionset_mgr
	Checksum: 0xA9DF945
	Offset: 0x2270
	Size: 0x60
	Parameters: 4
	Flags: Linked
*/
function lerp_thread_wrapper(func, opt_param_1, opt_param_2, opt_param_3)
{
	self notify(#"visionset_mgr_deactivate_all");
	self endon(#"visionset_mgr_deactivate_all");
	self [[func]](opt_param_1, opt_param_2, opt_param_3);
}

/*
	Name: lerp_thread_per_player_wrapper
	Namespace: visionset_mgr
	Checksum: 0xC005AA28
	Offset: 0x22D8
	Size: 0xC6
	Parameters: 5
	Flags: Linked
*/
function lerp_thread_per_player_wrapper(func, player, opt_param_1, opt_param_2, opt_param_3)
{
	if(!isdefined(player))
	{
		return;
	}
	player_entnum = player getentitynumber();
	self.players[player_entnum] notify(#"visionset_mgr_deactivate");
	self.players[player_entnum] endon(#"visionset_mgr_deactivate");
	player endon(#"disconnect");
	self [[func]](player, opt_param_1, opt_param_2, opt_param_3);
}

/*
	Name: activate_per_player
	Namespace: visionset_mgr
	Checksum: 0x3D2825B1
	Offset: 0x23A8
	Size: 0x134
	Parameters: 6
	Flags: Linked
*/
function activate_per_player(type, name, player, opt_param_1, opt_param_2, opt_param_3)
{
	if(!isdefined(player))
	{
		return;
	}
	player_entnum = player getentitynumber();
	state = level.vsmgr[type].info[name].state;
	if(state.ref_count_lerp_thread)
	{
		state.players[player_entnum].ref_count++;
		if(1 < state.players[player_entnum].ref_count)
		{
			return;
		}
	}
	if(isdefined(state.lerp_thread))
	{
		state thread lerp_thread_per_player_wrapper(state.lerp_thread, player, opt_param_1, opt_param_2, opt_param_3);
	}
	else
	{
		state set_state_active(player, 1);
	}
}

/*
	Name: deactivate_per_player
	Namespace: visionset_mgr
	Checksum: 0x6401C396
	Offset: 0x24E8
	Size: 0x10E
	Parameters: 3
	Flags: Linked
*/
function deactivate_per_player(type, name, player)
{
	if(!isdefined(player))
	{
		return;
	}
	player_entnum = player getentitynumber();
	state = level.vsmgr[type].info[name].state;
	if(state.players.size > 0)
	{
		if(state.ref_count_lerp_thread)
		{
			state.players[player_entnum].ref_count--;
			if(0 < state.players[player_entnum].ref_count)
			{
				return;
			}
		}
		state set_state_inactive(player);
		state.players[player_entnum] notify(#"visionset_mgr_deactivate");
	}
}

/*
	Name: calc_ramp_in_lerp
	Namespace: visionset_mgr
	Checksum: 0x602CCC8B
	Offset: 0x2600
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function calc_ramp_in_lerp(start_time, end_time)
{
	if(0 >= (end_time - start_time))
	{
		return 1;
	}
	now = gettime();
	frac = (float(now - start_time)) / (float(end_time - start_time));
	return math::clamp(frac, 0, 1);
}

/*
	Name: calc_remaining_duration_lerp
	Namespace: visionset_mgr
	Checksum: 0xB036EC0D
	Offset: 0x26A0
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function calc_remaining_duration_lerp(start_time, end_time)
{
	if(0 >= (end_time - start_time))
	{
		return 0;
	}
	now = gettime();
	frac = (float(end_time - now)) / (float(end_time - start_time));
	return math::clamp(frac, 0, 1);
}

