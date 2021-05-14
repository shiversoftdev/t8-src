// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_72d4466ce2e2cc7b;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace util;

/*
	Name: function_89f2df9
	Namespace: util
	Checksum: 0x8883E8A7
	Offset: 0x180
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"util_shared", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: util
	Checksum: 0x7A494189
	Offset: 0x1C8
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	function_73fab74d();
	register_clientfields();
	namespace_1e38a8f6::init();
}

/*
	Name: register_clientfields
	Namespace: util
	Checksum: 0xC307AE88
	Offset: 0x208
	Size: 0x124
	Parameters: 0
	Flags: Linked
*/
function register_clientfields()
{
	clientfield::register("world", "cf_team_mapping", 1, 1, "int", &cf_team_mapping, 0, 0);
	clientfield::register("world", "preload_frontend", 1, 1, "int", &preload_frontend, 0, 0);
	clientfield::register("allplayers", "ClearStreamerLoadingHints", 1, 1, "int", &function_7d955209, 0, 0);
	clientfield::register("allplayers", "StreamerSetSpawnHintIndex", 1, 4, "int", &function_4fdf4063, 1, 0);
}

/*
	Name: function_7d955209
	Namespace: util
	Checksum: 0x24CAFC00
	Offset: 0x338
	Size: 0x74
	Parameters: 7
	Flags: Linked
*/
function function_7d955209(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	if(newval)
	{
		clearstreamerloadinghints();
	}
}

/*
	Name: function_4fdf4063
	Namespace: util
	Checksum: 0x9A333604
	Offset: 0x3B8
	Size: 0x6C
	Parameters: 7
	Flags: Linked
*/
function function_4fdf4063(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!self function_21c0fa55())
	{
		return;
	}
	streamersetspawnhintindex(newval);
}

/*
	Name: empty
	Namespace: util
	Checksum: 0x8BEE5F57
	Offset: 0x430
	Size: 0x2C
	Parameters: 5
	Flags: None
*/
function empty(a, b, c, d, e)
{
}

/*
	Name: waitforallclients
	Namespace: util
	Checksum: 0x88E46073
	Offset: 0x468
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function waitforallclients()
{
	localclient = 0;
	if(!isdefined(level.localplayers))
	{
		while(!isdefined(level.localplayers))
		{
			waitframe(1);
		}
	}
	while(level.localplayers.size <= 0)
	{
		waitframe(1);
	}
	while(localclient < level.localplayers.size)
	{
		waitforclient(localclient);
		localclient++;
	}
}

/*
	Name: function_89a98f85
	Namespace: util
	Checksum: 0x19B7CB13
	Offset: 0x4F8
	Size: 0x86
	Parameters: 0
	Flags: Linked
*/
function function_89a98f85()
{
	num = getdvarint(#"splitscreen_playercount", 0);
	if(num < 1)
	{
		num = 1;
	}
	num = 1;
	for(localclient = 0; localclient < num; localclient++)
	{
		waitforclient(localclient);
	}
}

/*
	Name: waitforclient
	Namespace: util
	Checksum: 0x24D7D44D
	Offset: 0x588
	Size: 0x30
	Parameters: 1
	Flags: Linked
*/
function waitforclient(client)
{
	while(!clienthassnapshot(client))
	{
		waitframe(1);
	}
}

/*
	Name: get_dvar_float_default
	Namespace: util
	Checksum: 0xD182709F
	Offset: 0x5C0
	Size: 0x62
	Parameters: 2
	Flags: None
*/
function get_dvar_float_default(str_dvar, default_val)
{
	value = getdvarstring(str_dvar);
	return (value != "" ? float(value) : default_val);
}

/*
	Name: get_dvar_int_default
	Namespace: util
	Checksum: 0x7A2333B8
	Offset: 0x630
	Size: 0x62
	Parameters: 2
	Flags: None
*/
function get_dvar_int_default(str_dvar, default_val)
{
	value = getdvarstring(str_dvar);
	return (value != "" ? int(value) : default_val);
}

/*
	Name: spawn_model
	Namespace: util
	Checksum: 0x5358DCE2
	Offset: 0x6A0
	Size: 0x9E
	Parameters: 4
	Flags: Linked
*/
function spawn_model(n_client, str_model, origin = (0, 0, 0), angles = (0, 0, 0))
{
	model = spawn(n_client, origin, "script_model");
	if(isdefined(model))
	{
		model setmodel(str_model);
		model.angles = angles;
	}
	return model;
}

/*
	Name: spawn_anim_model
	Namespace: util
	Checksum: 0xD45C1AD4
	Offset: 0x748
	Size: 0x8A
	Parameters: 4
	Flags: Linked
*/
function spawn_anim_model(n_client, model_name, origin, angles)
{
	model = spawn_model(n_client, model_name, origin, angles);
	if(isdefined(model))
	{
		model useanimtree("generic");
		model.animtree = "generic";
	}
	return model;
}

/*
	Name: waittill_string
	Namespace: util
	Checksum: 0xC4821C09
	Offset: 0x7E0
	Size: 0x80
	Parameters: 2
	Flags: None
*/
function waittill_string(msg, ent)
{
	if(msg != "death")
	{
		self endon(#"death");
	}
	ent endon(#"die");
	self waittill(msg);
	ent notify(#"returned", {#msg:msg});
}

/*
	Name: waittill_multiple
	Namespace: util
	Checksum: 0xDCED80E1
	Offset: 0x868
	Size: 0x9C
	Parameters: 1
	Flags: Variadic
*/
function waittill_multiple(vararg)
{
	s_tracker = spawnstruct();
	s_tracker._wait_count = 0;
	for(i = 0; i < vararg.size; i++)
	{
		self thread _waitlogic(s_tracker, vararg[i]);
	}
	if(s_tracker._wait_count > 0)
	{
		s_tracker waittill(#"waitlogic_finished");
	}
}

/*
	Name: waittill_either
	Namespace: util
	Checksum: 0x6E59A47B
	Offset: 0x910
	Size: 0x2A
	Parameters: 2
	Flags: Linked
*/
function waittill_either(msg1, msg2)
{
	self endon(msg1);
	self waittill(msg2);
}

/*
	Name: waittill_multiple_ents
	Namespace: util
	Checksum: 0xCC5573D9
	Offset: 0x948
	Size: 0x1C4
	Parameters: 1
	Flags: Variadic
*/
function waittill_multiple_ents(vararg)
{
	a_ents = [];
	a_notifies = [];
	for(i = 0; i < vararg.size; i++)
	{
		if(i % 2)
		{
			if(!isdefined(a_notifies))
			{
				a_notifies = [];
			}
			else if(!isarray(a_notifies))
			{
				a_notifies = array(a_notifies);
			}
			a_notifies[a_notifies.size] = vararg[i];
			continue;
		}
		if(!isdefined(a_ents))
		{
			a_ents = [];
		}
		else if(!isarray(a_ents))
		{
			a_ents = array(a_ents);
		}
		a_ents[a_ents.size] = vararg[i];
	}
	s_tracker = spawnstruct();
	s_tracker._wait_count = 0;
	for(i = 0; i < a_ents.size; i++)
	{
		ent = a_ents[i];
		if(isdefined(ent))
		{
			ent thread _waitlogic(s_tracker, a_notifies[i]);
		}
	}
	if(s_tracker._wait_count > 0)
	{
		s_tracker waittill(#"waitlogic_finished");
	}
}

/*
	Name: _waitlogic
	Namespace: util
	Checksum: 0xA1F3CACA
	Offset: 0xB18
	Size: 0xB0
	Parameters: 2
	Flags: Linked
*/
function _waitlogic(s_tracker, notifies)
{
	s_tracker._wait_count++;
	if(!isdefined(notifies))
	{
		notifies = [];
	}
	else if(!isarray(notifies))
	{
		notifies = array(notifies);
	}
	notifies[notifies.size] = "death";
	self waittill(notifies);
	s_tracker._wait_count--;
	if(s_tracker._wait_count == 0)
	{
		s_tracker notify(#"waitlogic_finished");
	}
}

/*
	Name: waittill_any_ents
	Namespace: util
	Checksum: 0xB6392DFF
	Offset: 0xBD0
	Size: 0x166
	Parameters: 14
	Flags: Linked
*/
function waittill_any_ents(ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5, ent6, string6, ent7, string7)
{
	/#
		assert(isdefined(ent1));
	#/
	/#
		assert(isdefined(string1));
	#/
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}
	if(isdefined(ent3) && isdefined(string3))
	{
		ent3 endon(string3);
	}
	if(isdefined(ent4) && isdefined(string4))
	{
		ent4 endon(string4);
	}
	if(isdefined(ent5) && isdefined(string5))
	{
		ent5 endon(string5);
	}
	if(isdefined(ent6) && isdefined(string6))
	{
		ent6 endon(string6);
	}
	if(isdefined(ent7) && isdefined(string7))
	{
		ent7 endon(string7);
	}
	ent1 waittill(string1);
}

/*
	Name: function_e532f5da
	Namespace: util
	Checksum: 0xD0F2B581
	Offset: 0xD40
	Size: 0x12E
	Parameters: 11
	Flags: Linked
*/
function function_e532f5da(n_timeout, ent1, string1, ent2, string2, ent3, string3, ent4, string4, ent5, string5)
{
	/#
		assert(isdefined(n_timeout));
	#/
	/#
		assert(isdefined(ent1));
	#/
	/#
		assert(isdefined(string1));
	#/
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}
	if(isdefined(ent3) && isdefined(string3))
	{
		ent3 endon(string3);
	}
	if(isdefined(ent4) && isdefined(string4))
	{
		ent4 endon(string4);
	}
	if(isdefined(ent5) && isdefined(string5))
	{
		ent5 endon(string5);
	}
	ent1 waittill_timeout(n_timeout, string1);
}

/*
	Name: waittill_any_ents_two
	Namespace: util
	Checksum: 0xB6C232BF
	Offset: 0xE78
	Size: 0x80
	Parameters: 4
	Flags: None
*/
function waittill_any_ents_two(ent1, string1, ent2, string2)
{
	/#
		assert(isdefined(ent1));
	#/
	/#
		assert(isdefined(string1));
	#/
	if(isdefined(ent2) && isdefined(string2))
	{
		ent2 endon(string2);
	}
	ent1 waittill(string1);
}

/*
	Name: single_func
	Namespace: util
	Checksum: 0x844E9B0F
	Offset: 0xF00
	Size: 0x3A
	Parameters: 3
	Flags: Linked, Variadic
*/
function single_func(entity, func, vararg)
{
	return _single_func(entity, func, vararg);
}

/*
	Name: single_func_argarray
	Namespace: util
	Checksum: 0x59303815
	Offset: 0xF48
	Size: 0x3A
	Parameters: 3
	Flags: Linked
*/
function single_func_argarray(entity, func, a_vars)
{
	return _single_func(entity, func, a_vars);
}

/*
	Name: _single_func
	Namespace: util
	Checksum: 0x4F21F77F
	Offset: 0xF90
	Size: 0x53A
	Parameters: 3
	Flags: Linked
*/
function _single_func(entity, func, a_vars)
{
	_clean_up_arg_array(a_vars);
	switch(a_vars.size)
	{
		case 8:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6], a_vars[7]);
			}
			break;
		}
		case 7:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5], a_vars[6]);
			}
			break;
		}
		case 6:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4], a_vars[5]);
			}
			break;
		}
		case 5:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3], a_vars[4]);
			}
			break;
		}
		case 4:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2], a_vars[3]);
			}
			break;
		}
		case 3:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1], a_vars[2]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1], a_vars[2]);
			}
			break;
		}
		case 2:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0], a_vars[1]);
			}
			else
			{
				return [[func]](a_vars[0], a_vars[1]);
			}
			break;
		}
		case 1:
		{
			if(isdefined(entity))
			{
				return entity [[func]](a_vars[0]);
			}
			else
			{
				return [[func]](a_vars[0]);
			}
			break;
		}
		case 0:
		{
			if(isdefined(entity))
			{
				return entity [[func]]();
			}
			else
			{
				return [[func]]();
			}
			break;
		}
		default:
		{
			/#
				assertmsg("");
			#/
		}
	}
}

/*
	Name: _clean_up_arg_array
	Namespace: util
	Checksum: 0xB3246877
	Offset: 0x14D8
	Size: 0x6E
	Parameters: 1
	Flags: Linked
*/
function _clean_up_arg_array(a_vars)
{
	for(i = a_vars.size - 1; i >= 0; i--)
	{
		if(a_vars[i] === undefined)
		{
			arrayremoveindex(a_vars, i, 0);
			continue;
		}
		break;
	}
}

/*
	Name: new_func
	Namespace: util
	Checksum: 0x28BB6D69
	Offset: 0x1550
	Size: 0xCA
	Parameters: 7
	Flags: None
*/
function new_func(func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	s_func = spawnstruct();
	s_func.func = func;
	s_func.arg1 = arg1;
	s_func.arg2 = arg2;
	s_func.arg3 = arg3;
	s_func.arg4 = arg4;
	s_func.arg5 = arg5;
	s_func.arg6 = arg6;
	return s_func;
}

/*
	Name: call_func
	Namespace: util
	Checksum: 0x9D339D9
	Offset: 0x1628
	Size: 0x72
	Parameters: 1
	Flags: None
*/
function call_func(s_func)
{
	return single_func(self, s_func.func, s_func.arg1, s_func.arg2, s_func.arg3, s_func.arg4, s_func.arg5, s_func.arg6);
}

/*
	Name: array_ent_thread
	Namespace: util
	Checksum: 0xD95E78B9
	Offset: 0x16A8
	Size: 0x164
	Parameters: 7
	Flags: None
*/
function array_ent_thread(entities, func, arg1, arg2, arg3, arg4, arg5)
{
	/#
		assert(isdefined(entities), "");
	#/
	/#
		assert(isdefined(func), "");
	#/
	if(isarray(entities))
	{
		if(entities.size)
		{
			foreach(entity in entities)
			{
				single_thread(self, func, entity, arg1, arg2, arg3, arg4, arg5);
			}
		}
	}
	else
	{
		single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
	}
}

/*
	Name: single_thread
	Namespace: util
	Checksum: 0x616B1008
	Offset: 0x1818
	Size: 0x162
	Parameters: 8
	Flags: Linked
*/
function single_thread(entity, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	/#
		assert(isdefined(entity), "");
	#/
	if(isdefined(arg6))
	{
		entity thread [[func]](arg1, arg2, arg3, arg4, arg5, arg6);
	}
	else if(isdefined(arg5))
	{
		entity thread [[func]](arg1, arg2, arg3, arg4, arg5);
	}
	else if(isdefined(arg4))
	{
		entity thread [[func]](arg1, arg2, arg3, arg4);
	}
	else if(isdefined(arg3))
	{
		entity thread [[func]](arg1, arg2, arg3);
	}
	else if(isdefined(arg2))
	{
		entity thread [[func]](arg1, arg2);
	}
	else if(isdefined(arg1))
	{
		entity thread [[func]](arg1);
	}
	else
	{
		entity thread [[func]]();
	}
}

/*
	Name: add_listen_thread
	Namespace: util
	Checksum: 0xA48FBDD
	Offset: 0x1988
	Size: 0x6C
	Parameters: 7
	Flags: None
*/
function add_listen_thread(wait_till, func, param1, param2, param3, param4, param5)
{
	level thread add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5);
}

/*
	Name: add_listen_thread_internal
	Namespace: util
	Checksum: 0x997C351
	Offset: 0x1A00
	Size: 0x78
	Parameters: 7
	Flags: Linked
*/
function add_listen_thread_internal(wait_till, func, param1, param2, param3, param4, param5)
{
	for(;;)
	{
		level waittill(wait_till);
		single_thread(level, func, param1, param2, param3, param4, param5);
	}
}

/*
	Name: timeout
	Namespace: util
	Checksum: 0x1CA0D811
	Offset: 0x1A80
	Size: 0xE4
	Parameters: 8
	Flags: Linked
*/
function timeout(n_time, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self endon(#"death");
	if(isdefined(n_time))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s delay_notify(n_time, "timeout");
	}
	single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: delay
	Namespace: util
	Checksum: 0xE96D36A5
	Offset: 0x1B70
	Size: 0x84
	Parameters: 9
	Flags: Linked
*/
function delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self thread _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: _delay
	Namespace: util
	Checksum: 0x8E7C531E
	Offset: 0x1C00
	Size: 0xE4
	Parameters: 9
	Flags: Linked
*/
function _delay(time_or_notify, str_endon, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	self endon(#"death");
	if(isdefined(str_endon))
	{
		self endon(str_endon);
	}
	if(function_7a600918(time_or_notify) || isstring(time_or_notify))
	{
		self waittill(time_or_notify);
	}
	else
	{
		wait(time_or_notify);
	}
	single_func(self, func, arg1, arg2, arg3, arg4, arg5, arg6);
}

/*
	Name: delay_notify
	Namespace: util
	Checksum: 0x3594FE03
	Offset: 0x1CF0
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function delay_notify(time_or_notify, str_notify, str_endon)
{
	self thread _delay_notify(time_or_notify, str_notify, str_endon);
}

/*
	Name: _delay_notify
	Namespace: util
	Checksum: 0xAE147CAB
	Offset: 0x1D38
	Size: 0x8E
	Parameters: 3
	Flags: Linked
*/
function _delay_notify(time_or_notify, str_notify, str_endon)
{
	self endon(#"death");
	if(isdefined(str_endon))
	{
		self endon(str_endon);
	}
	if(function_7a600918(time_or_notify) || isstring(time_or_notify))
	{
		self waittill(time_or_notify);
	}
	else
	{
		wait(time_or_notify);
	}
	self notify(str_notify);
}

/*
	Name: new_timer
	Namespace: util
	Checksum: 0xD78E84BE
	Offset: 0x1DD0
	Size: 0x46
	Parameters: 1
	Flags: Linked
*/
function new_timer(n_timer_length)
{
	s_timer = spawnstruct();
	s_timer.n_time_created = gettime();
	s_timer.n_length = n_timer_length;
	return s_timer;
}

/*
	Name: get_time
	Namespace: util
	Checksum: 0xE77C5B
	Offset: 0x1E20
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function get_time()
{
	t_now = gettime();
	return t_now - self.n_time_created;
}

/*
	Name: get_time_in_seconds
	Namespace: util
	Checksum: 0x73DF9C7D
	Offset: 0x1E48
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function get_time_in_seconds()
{
	return float(get_time()) / 1000;
}

/*
	Name: get_time_frac
	Namespace: util
	Checksum: 0x6A9EC4F6
	Offset: 0x1E88
	Size: 0x4A
	Parameters: 1
	Flags: None
*/
function get_time_frac(n_end_time = self.n_length)
{
	return lerpfloat(0, 1, get_time_in_seconds() / n_end_time);
}

/*
	Name: get_time_left
	Namespace: util
	Checksum: 0xC0A6215E
	Offset: 0x1EE0
	Size: 0x58
	Parameters: 0
	Flags: Linked
*/
function get_time_left()
{
	if(isdefined(self.n_length))
	{
		n_current_time = get_time_in_seconds();
		return max(self.n_length - n_current_time, 0);
	}
	return -1;
}

/*
	Name: is_time_left
	Namespace: util
	Checksum: 0xE77B5CB0
	Offset: 0x1F40
	Size: 0x16
	Parameters: 0
	Flags: None
*/
function is_time_left()
{
	return get_time_left() != 0;
}

/*
	Name: timer_wait
	Namespace: util
	Checksum: 0xBAD04A46
	Offset: 0x1F60
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function timer_wait(n_wait)
{
	if(isdefined(self.n_length))
	{
		n_wait = min(n_wait, get_time_left());
	}
	wait(n_wait);
	n_current_time = get_time_in_seconds();
	return n_current_time;
}

/*
	Name: add_remove_list
	Namespace: util
	Checksum: 0x9E21DAF0
	Offset: 0x1FD0
	Size: 0x84
	Parameters: 2
	Flags: Linked
*/
function add_remove_list(a = [], on_off)
{
	if(on_off)
	{
		if(!isinarray(a, self))
		{
			arrayinsert(a, self, a.size);
		}
	}
	else
	{
		arrayremovevalue(a, self, 0);
	}
}

/*
	Name: clean_deleted
	Namespace: util
	Checksum: 0xAF63C87E
	Offset: 0x2060
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function clean_deleted(array)
{
	arrayremovevalue(array, undefined);
}

/*
	Name: get_eye
	Namespace: util
	Checksum: 0x91B771CE
	Offset: 0x2090
	Size: 0xE2
	Parameters: 0
	Flags: None
*/
function get_eye()
{
	if(sessionmodeiscampaigngame())
	{
		if(isplayer(self))
		{
			linked_ent = self getlinkedent();
			if(isdefined(linked_ent) && getdvarint(#"cg_camerausetagcamera", 0) > 0)
			{
				camera = linked_ent gettagorigin("tag_camera");
				if(isdefined(camera))
				{
					return camera;
				}
			}
		}
	}
	pos = self geteye();
	return pos;
}

/*
	Name: spawn_player_arms
	Namespace: util
	Checksum: 0x1515CCC2
	Offset: 0x2180
	Size: 0xB0
	Parameters: 0
	Flags: None
*/
function spawn_player_arms()
{
	arms = spawn(self getlocalclientnumber(), self.origin + vectorscale((0, 0, -1), 1000), "script_model");
	if(isdefined(level.player_viewmodel))
	{
		arms setmodel(level.player_viewmodel);
	}
	else
	{
		arms setmodel(#"c_usa_cia_masonjr_viewhands");
	}
	return arms;
}

/*
	Name: lerp_dvar
	Namespace: util
	Checksum: 0x6559679A
	Offset: 0x2238
	Size: 0x142
	Parameters: 7
	Flags: None
*/
function lerp_dvar(str_dvar, n_start_val = getdvarfloat(str_dvar, 0), n_end_val, n_lerp_time, b_saved_dvar, b_client_dvar, n_client = 0)
{
	s_timer = new_timer();
	do
	{
		n_time_delta = s_timer timer_wait(0.01666);
		n_curr_val = lerpfloat(n_start_val, n_end_val, n_time_delta / n_lerp_time);
		if(isdefined(b_saved_dvar) && b_saved_dvar)
		{
			setsaveddvar(str_dvar, n_curr_val);
		}
		else
		{
			setdvar(str_dvar, n_curr_val);
		}
	}
	while(n_time_delta < n_lerp_time);
}

/*
	Name: is_valid_type_for_callback
	Namespace: util
	Checksum: 0xFEEF3FFD
	Offset: 0x2388
	Size: 0xEA
	Parameters: 1
	Flags: None
*/
function is_valid_type_for_callback(type)
{
	switch(type)
	{
		case "scriptmover":
		case "na":
		case "missile":
		case "general":
		case "player":
		case "turret":
		case "actor":
		case "helicopter":
		case "trigger":
		case "vehicle":
		case "plane":
		{
			return 1;
		}
		default:
		{
			return 0;
		}
	}
}

/*
	Name: wait_till_not_touching
	Namespace: util
	Checksum: 0x26FD6EB2
	Offset: 0x2480
	Size: 0xA8
	Parameters: 2
	Flags: None
*/
function wait_till_not_touching(e_to_check, e_to_touch)
{
	/#
		assert(isdefined(e_to_check), "");
	#/
	/#
		assert(isdefined(e_to_touch), "");
	#/
	e_to_check endon(#"death");
	e_to_touch endon(#"death");
	while(e_to_check istouching(e_to_touch))
	{
		waitframe(1);
	}
}

/*
	Name: error
	Namespace: util
	Checksum: 0xA6E4EC1D
	Offset: 0x2530
	Size: 0x32
	Parameters: 1
	Flags: None
*/
function error(message)
{
	/#
		println("", message);
		waitframe(1);
	#/
}

/*
	Name: register_system
	Namespace: util
	Checksum: 0x7380BCD4
	Offset: 0x2570
	Size: 0xE2
	Parameters: 2
	Flags: Linked
*/
function register_system(ssysname, cbfunc)
{
	if(!isdefined(level._systemstates))
	{
		level._systemstates = [];
	}
	if(level._systemstates.size >= 32)
	{
		/#
			error("");
		#/
		return;
	}
	if(isdefined(level._systemstates[ssysname]))
	{
		/#
			error("" + ssysname);
		#/
		return;
	}
	level._systemstates[ssysname] = spawnstruct();
	level._systemstates[ssysname].callback = cbfunc;
}

/*
	Name: field_set_lighting_ent
	Namespace: util
	Checksum: 0x9C2ED3A9
	Offset: 0x2660
	Size: 0x4A
	Parameters: 7
	Flags: Linked
*/
function field_set_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	level.light_entity = self;
}

/*
	Name: field_use_lighting_ent
	Namespace: util
	Checksum: 0x52F9A85B
	Offset: 0x26B8
	Size: 0x3C
	Parameters: 7
	Flags: Linked
*/
function field_use_lighting_ent(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
}

/*
	Name: waittill_dobj
	Namespace: util
	Checksum: 0xD54DDF1F
	Offset: 0x2700
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function waittill_dobj(localclientnum)
{
	while(isdefined(self) && !self hasdobj(localclientnum))
	{
		waitframe(1);
	}
}

/*
	Name: playfxontag
	Namespace: util
	Checksum: 0xBD7BB5C3
	Offset: 0x2748
	Size: 0x6E
	Parameters: 4
	Flags: Linked
*/
function playfxontag(localclientnum, effect, entity, tagname)
{
	if(isdefined(entity) && entity hasdobj(localclientnum))
	{
		return function_239993de(localclientnum, effect, entity, tagname);
	}
	return undefined;
}

/*
	Name: function_6d0694af
	Namespace: util
	Checksum: 0x42E9E73E
	Offset: 0x27C0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_6d0694af()
{
	while(isdefined(self) && !self function_700ca4f5())
	{
		waitframe(1);
	}
}

/*
	Name: server_wait
	Namespace: util
	Checksum: 0xE9A1765E
	Offset: 0x2800
	Size: 0x174
	Parameters: 4
	Flags: Linked
*/
function server_wait(localclientnum, seconds, waitbetweenchecks, level_endon)
{
	if(isdefined(level_endon))
	{
		level endon(level_endon);
	}
	if(seconds != 0 && isdemoplaying())
	{
		if(!isdefined(waitbetweenchecks))
		{
			waitbetweenchecks = 0.2;
		}
		waitcompletedsuccessfully = 0;
		starttime = getservertime(0);
		lasttime = starttime;
		endtime = starttime + int(seconds * 1000);
		while(getservertime(0) < endtime && getservertime(0) >= lasttime)
		{
			lasttime = getservertime(0);
			wait(waitbetweenchecks);
		}
		if(lasttime < getservertime(0))
		{
			waitcompletedsuccessfully = 1;
		}
	}
	else
	{
		wait(seconds);
		waitcompletedsuccessfully = 1;
	}
	return waitcompletedsuccessfully;
}

/*
	Name: get_other_team
	Namespace: util
	Checksum: 0xAFD07E2D
	Offset: 0x2980
	Size: 0x62
	Parameters: 1
	Flags: None
*/
function get_other_team(str_team)
{
	if(str_team == #"allies")
	{
		return #"axis";
	}
	if(str_team == #"axis")
	{
		return #"allies";
	}
	return #"allies";
}

/*
	Name: function_fbce7263
	Namespace: util
	Checksum: 0xC244D7E3
	Offset: 0x2A18
	Size: 0x66
	Parameters: 2
	Flags: Linked
*/
function function_fbce7263(team_a, team_b)
{
	if(team_a === team_b)
	{
		return 0;
	}
	if(!isdefined(team_a) || !isdefined(team_b))
	{
		return 1;
	}
	if(function_b37afded(team_a, team_b))
	{
		return 0;
	}
	return 1;
}

/*
	Name: isenemyteam
	Namespace: util
	Checksum: 0xE790F3D
	Offset: 0x2A88
	Size: 0x2A
	Parameters: 1
	Flags: None
*/
function isenemyteam(team)
{
	return function_fbce7263(team, self.team);
}

/*
	Name: isenemyplayer
	Namespace: util
	Checksum: 0x341A2899
	Offset: 0x2AC0
	Size: 0xBA
	Parameters: 1
	Flags: None
*/
function isenemyplayer(player)
{
	/#
		assert(isdefined(player));
	#/
	if(!isplayer(player))
	{
		return 0;
	}
	if(player.team != "free")
	{
		if(player.team === self.team)
		{
			return 0;
		}
		if(function_b37afded(player.team, self.team))
		{
			return 0;
		}
	}
	else if(player == self)
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_50ed1561
	Namespace: util
	Checksum: 0x37A30443
	Offset: 0x2B88
	Size: 0xD2
	Parameters: 1
	Flags: Linked
*/
function function_50ed1561(localclientnum)
{
	function_89a98f85();
	if(!isdefined(self))
	{
		return 0;
	}
	if(!self function_21c0fa55())
	{
		return 0;
	}
	if(function_65b9eb0f(localclientnum))
	{
		return 0;
	}
	if(localclientnum !== self getlocalclientnumber())
	{
		return 0;
	}
	if(isdefined(level.localplayers[localclientnum]) && self getentitynumber() != level.localplayers[localclientnum] getentitynumber())
	{
		return 0;
	}
	return 1;
}

/*
	Name: is_player_view_linked_to_entity
	Namespace: util
	Checksum: 0x74435EE6
	Offset: 0x2C68
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function is_player_view_linked_to_entity(localclientnum)
{
	if(function_fd3d58c7(localclientnum))
	{
		return 1;
	}
	if(function_e75c64a4(localclientnum))
	{
		return 1;
	}
	return 0;
}

/*
	Name: get_start_time
	Namespace: util
	Checksum: 0x93096822
	Offset: 0x2CC0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_start_time()
{
	return getmicrosecondsraw();
}

/*
	Name: note_elapsed_time
	Namespace: util
	Checksum: 0x2EAAB399
	Offset: 0x2CE0
	Size: 0x12C
	Parameters: 2
	Flags: None
*/
function note_elapsed_time(start_time, label = "unspecified")
{
	/#
		elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
		if(!isdefined(start_time))
		{
			return;
		}
		elapsed_time = elapsed_time * 0.001;
		if(!isdefined(level.orbis))
		{
			level.orbis = getdvarstring(#"orbisgame") == "";
		}
		if(!level.orbis)
		{
			elapsed_time = int(elapsed_time);
		}
		msg = label + "" + elapsed_time + "";
		profileprintln(msg);
		iprintlnbold(msg);
	#/
}

/*
	Name: record_elapsed_time
	Namespace: util
	Checksum: 0xEC9C5D7C
	Offset: 0x2E18
	Size: 0x98
	Parameters: 2
	Flags: Linked
*/
function record_elapsed_time(start_time, elapsed_time_array)
{
	elapsed_time = get_elapsed_time(start_time, getmicrosecondsraw());
	if(!isdefined(elapsed_time_array))
	{
		elapsed_time_array = [];
	}
	else if(!isarray(elapsed_time_array))
	{
		elapsed_time_array = array(elapsed_time_array);
	}
	elapsed_time_array[elapsed_time_array.size] = elapsed_time;
}

/*
	Name: note_elapsed_times
	Namespace: util
	Checksum: 0xA5F501EE
	Offset: 0x2EB8
	Size: 0x2C4
	Parameters: 2
	Flags: Linked
*/
function note_elapsed_times(elapsed_time_array, label = "unspecified")
{
	/#
		if(!isarray(elapsed_time_array))
		{
			return;
		}
		msg = label + "" + elapsed_time_array.size;
		profileprintln(msg);
		if(elapsed_time_array.size == 0)
		{
			return;
		}
		if(!isdefined(level.orbis))
		{
			level.orbis = getdvarstring(#"orbisgame") == "";
		}
		total_elapsed_time = 0;
		smallest_elapsed_time = 2147483647;
		largest_elapsed_time = 0;
		foreach(elapsed_time in elapsed_time_array)
		{
			elapsed_time = elapsed_time * 0.001;
			total_elapsed_time = total_elapsed_time + elapsed_time;
			if(elapsed_time < smallest_elapsed_time)
			{
				smallest_elapsed_time = elapsed_time;
			}
			if(elapsed_time > largest_elapsed_time)
			{
				largest_elapsed_time = elapsed_time;
			}
			if(!level.orbis)
			{
				elapsed_time = int(elapsed_time);
			}
			msg = label + "" + elapsed_time + "";
			profileprintln(msg);
		}
		average_elapsed_time = total_elapsed_time / elapsed_time_array.size;
		msg = label + "" + average_elapsed_time + "";
		profileprintln(msg);
		iprintlnbold(msg);
		msg = label + "" + largest_elapsed_time + "";
		profileprintln(msg);
		msg = label + "" + smallest_elapsed_time + "";
		profileprintln(msg);
	#/
}

/*
	Name: get_elapsed_time
	Namespace: util
	Checksum: 0x3CCA13C1
	Offset: 0x3188
	Size: 0x70
	Parameters: 2
	Flags: Linked
*/
function get_elapsed_time(start_time, end_time = getmicrosecondsraw())
{
	if(!isdefined(start_time))
	{
		return undefined;
	}
	elapsed_time = end_time - start_time;
	if(elapsed_time < 0)
	{
		elapsed_time = elapsed_time + -2147483648;
	}
	return elapsed_time;
}

/*
	Name: init_utility
	Namespace: util
	Checksum: 0x97581336
	Offset: 0x3200
	Size: 0xDE
	Parameters: 0
	Flags: Linked
*/
function init_utility()
{
	level.isdemoplaying = isdemoplaying();
	level.localplayers = [];
	level.numgametypereservedobjectives = [];
	level.releasedobjectives = [];
	maxlocalclients = getmaxlocalclients();
	for(localclientnum = 0; localclientnum < maxlocalclients; localclientnum++)
	{
		level.releasedobjectives[localclientnum] = [];
		level.numgametypereservedobjectives[localclientnum] = 0;
	}
	waitforclient(0);
	level.localplayers = getlocalplayers();
}

/*
	Name: within_fov
	Namespace: util
	Checksum: 0x9F2AD62
	Offset: 0x32E8
	Size: 0x90
	Parameters: 4
	Flags: None
*/
function within_fov(start_origin, start_angles, end_origin, fov)
{
	normal = vectornormalize(end_origin - start_origin);
	forward = anglestoforward(start_angles);
	dot = vectordot(forward, normal);
	return dot >= fov;
}

/*
	Name: is_mature
	Namespace: util
	Checksum: 0xFADC46AF
	Offset: 0x3380
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function is_mature()
{
	return ismaturecontentenabled();
}

/*
	Name: function_fa1da5cb
	Namespace: util
	Checksum: 0xD84E1550
	Offset: 0x33A0
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function function_fa1da5cb()
{
	return isshowbloodenabled();
}

/*
	Name: function_2c435484
	Namespace: util
	Checksum: 0xB13A98EE
	Offset: 0x33C0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function function_2c435484()
{
	return function_4e803413();
}

/*
	Name: is_gib_restricted_build
	Namespace: util
	Checksum: 0xE00B12FB
	Offset: 0x33E0
	Size: 0x38
	Parameters: 0
	Flags: Linked
*/
function is_gib_restricted_build()
{
	if(!(ismaturecontentenabled() && isshowgibsenabled()))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_cd6c95db
	Namespace: util
	Checksum: 0x5A5C94F7
	Offset: 0x3420
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_cd6c95db(localclientnum)
{
	return function_d6e37bb1(localclientnum);
}

/*
	Name: function_a0819fe3
	Namespace: util
	Checksum: 0x685B82C8
	Offset: 0x3450
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function function_a0819fe3(localclientnum)
{
	return colorblindmode(localclientnum);
}

/*
	Name: registersystem
	Namespace: util
	Checksum: 0xCB47E023
	Offset: 0x3480
	Size: 0xE2
	Parameters: 2
	Flags: None
*/
function registersystem(ssysname, cbfunc)
{
	if(!isdefined(level._systemstates))
	{
		level._systemstates = [];
	}
	if(level._systemstates.size >= 32)
	{
		/#
			error("");
		#/
		return;
	}
	if(isdefined(level._systemstates[ssysname]))
	{
		/#
			error("" + ssysname);
		#/
		return;
	}
	level._systemstates[ssysname] = spawnstruct();
	level._systemstates[ssysname].callback = cbfunc;
}

/*
	Name: add_trigger_to_ent
	Namespace: util
	Checksum: 0x53A0F42E
	Offset: 0x3570
	Size: 0x5A
	Parameters: 2
	Flags: Linked
*/
function add_trigger_to_ent(ent, trig)
{
	if(!isdefined(ent._triggers))
	{
		ent._triggers = [];
	}
	ent._triggers[trig getentitynumber()] = 1;
}

/*
	Name: remove_trigger_from_ent
	Namespace: util
	Checksum: 0xF7BB8947
	Offset: 0x35D8
	Size: 0x72
	Parameters: 2
	Flags: Linked
*/
function remove_trigger_from_ent(ent, trig)
{
	if(!isdefined(ent._triggers))
	{
		return;
	}
	if(!isdefined(ent._triggers[trig getentitynumber()]))
	{
		return;
	}
	ent._triggers[trig getentitynumber()] = 0;
}

/*
	Name: ent_already_in_trigger
	Namespace: util
	Checksum: 0x76F3FB4B
	Offset: 0x3658
	Size: 0x70
	Parameters: 1
	Flags: Linked
*/
function ent_already_in_trigger(trig)
{
	if(!isdefined(self._triggers))
	{
		return 0;
	}
	if(!isdefined(self._triggers[trig getentitynumber()]))
	{
		return 0;
	}
	if(!self._triggers[trig getentitynumber()])
	{
		return 0;
	}
	return 1;
}

/*
	Name: trigger_thread
	Namespace: util
	Checksum: 0x96182BCF
	Offset: 0x36D0
	Size: 0xF4
	Parameters: 3
	Flags: None
*/
function trigger_thread(ent, on_enter_payload, on_exit_payload)
{
	ent endon(#"death");
	if(ent ent_already_in_trigger(self))
	{
		return;
	}
	add_trigger_to_ent(ent, self);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && ent istouching(self))
	{
		waitframe(1);
	}
	if(isdefined(ent) && isdefined(on_exit_payload))
	{
		[[on_exit_payload]](ent);
	}
	if(isdefined(ent))
	{
		remove_trigger_from_ent(ent, self);
	}
}

/*
	Name: local_player_trigger_thread_always_exit
	Namespace: util
	Checksum: 0x3B2F9249
	Offset: 0x37D0
	Size: 0xEC
	Parameters: 3
	Flags: None
*/
function local_player_trigger_thread_always_exit(ent, on_enter_payload, on_exit_payload)
{
	if(ent ent_already_in_trigger(self))
	{
		return;
	}
	add_trigger_to_ent(ent, self);
	if(isdefined(on_enter_payload))
	{
		[[on_enter_payload]](ent);
	}
	while(isdefined(ent) && ent istouching(self) && ent issplitscreenhost())
	{
		waitframe(1);
	}
	if(isdefined(on_exit_payload))
	{
		[[on_exit_payload]](ent);
	}
	if(isdefined(ent))
	{
		remove_trigger_from_ent(ent, self);
	}
}

/*
	Name: local_player_entity_thread
	Namespace: util
	Checksum: 0xAB8218F
	Offset: 0x38C8
	Size: 0x9C
	Parameters: 7
	Flags: Linked
*/
function local_player_entity_thread(localclientnum, entity, func, arg1, arg2, arg3, arg4)
{
	entity endon(#"death");
	entity waittill_dobj(localclientnum);
	single_thread(entity, func, localclientnum, arg1, arg2, arg3, arg4);
}

/*
	Name: local_players_entity_thread
	Namespace: util
	Checksum: 0xA1EC6C6D
	Offset: 0x3970
	Size: 0xA6
	Parameters: 6
	Flags: None
*/
function local_players_entity_thread(entity, func, arg1, arg2, arg3, arg4)
{
	players = level.localplayers;
	for(i = 0; i < players.size; i++)
	{
		players[i] thread local_player_entity_thread(i, entity, func, arg1, arg2, arg3, arg4);
	}
}

/*
	Name: debug_line
	Namespace: util
	Checksum: 0x3A2D0D2
	Offset: 0x3A20
	Size: 0xB4
	Parameters: 4
	Flags: None
*/
function debug_line(from, to, color, time)
{
	/#
		level.debug_line = getdvarint(#"scr_debug_line", 0);
		if(isdefined(level.debug_line) && level.debug_line == 1)
		{
			if(!isdefined(time))
			{
				time = 1000;
			}
			line(from, to, color, 1, 1, time);
		}
	#/
}

/*
	Name: debug_star
	Namespace: util
	Checksum: 0xA778DA05
	Offset: 0x3AE0
	Size: 0xB4
	Parameters: 3
	Flags: None
*/
function debug_star(origin, color, time)
{
	/#
		level.debug_star = getdvarint(#"scr_debug_star", 0);
		if(isdefined(level.debug_star) && level.debug_star == 1)
		{
			if(!isdefined(time))
			{
				time = 1000;
			}
			if(!isdefined(color))
			{
				color = (1, 1, 1);
			}
			debugstar(origin, time, color);
		}
	#/
}

/*
	Name: getnextobjid
	Namespace: util
	Checksum: 0x33FDDA38
	Offset: 0x3BA0
	Size: 0x10C
	Parameters: 1
	Flags: None
*/
function getnextobjid(localclientnum)
{
	nextid = 0;
	if(level.releasedobjectives[localclientnum].size > 0)
	{
		nextid = level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1];
		level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size - 1] = undefined;
	}
	else
	{
		nextid = level.numgametypereservedobjectives[localclientnum];
		level.numgametypereservedobjectives[localclientnum]++;
	}
	/#
		if(nextid > 31)
		{
			println("");
		}
		/#
			assert(nextid < 32);
		#/
	#/
	if(nextid > 31)
	{
		nextid = 31;
	}
	return nextid;
}

/*
	Name: releaseobjid
	Namespace: util
	Checksum: 0x5E918B78
	Offset: 0x3CB8
	Size: 0xB8
	Parameters: 2
	Flags: None
*/
function releaseobjid(localclientnum, objid)
{
	/#
		assert(objid < level.numgametypereservedobjectives[localclientnum]);
	#/
	for(i = 0; i < level.releasedobjectives[localclientnum].size; i++)
	{
		if(objid == level.releasedobjectives[localclientnum][i])
		{
			return;
		}
	}
	level.releasedobjectives[localclientnum][level.releasedobjectives[localclientnum].size] = objid;
}

/*
	Name: is_safehouse
	Namespace: util
	Checksum: 0x1AC01AF1
	Offset: 0x3D78
	Size: 0x28
	Parameters: 1
	Flags: None
*/
function is_safehouse(str_next_map = function_53bbf9d2())
{
	return 0;
}

/*
	Name: button_held_think
	Namespace: util
	Checksum: 0xFEF668F7
	Offset: 0x3DA8
	Size: 0x11A
	Parameters: 1
	Flags: None
*/
function button_held_think(which_button)
{
	/#
		self endon(#"disconnect");
		if(!isdefined(self._holding_button))
		{
			self._holding_button = [];
		}
		self._holding_button[which_button] = 0;
		time_started = 0;
		while(true)
		{
			if(self._holding_button[which_button])
			{
				if(!self [[level._button_funcs[which_button]]]())
				{
					self._holding_button[which_button] = 0;
				}
			}
			else if(self [[level._button_funcs[which_button]]]())
			{
				if(time_started == 0)
				{
					time_started = gettime();
				}
				if(gettime() - time_started > 250)
				{
					self._holding_button[which_button] = 1;
				}
			}
			else if(time_started != 0)
			{
				time_started = 0;
			}
			waitframe(1);
		}
	#/
}

/*
	Name: init_button_wrappers
	Namespace: util
	Checksum: 0xC81906AD
	Offset: 0x3ED0
	Size: 0x56
	Parameters: 0
	Flags: None
*/
function init_button_wrappers()
{
	/#
		if(!isdefined(level._button_funcs))
		{
			level._button_funcs[4] = &up_button_pressed;
			level._button_funcs[5] = &down_button_pressed;
		}
	#/
}

/*
	Name: up_button_held
	Namespace: util
	Checksum: 0x7840351E
	Offset: 0x3F30
	Size: 0x60
	Parameters: 0
	Flags: None
*/
function up_button_held()
{
	/#
		init_button_wrappers();
		if(!isdefined(self._up_button_think_threaded))
		{
			self thread button_held_think(4);
			self._up_button_think_threaded = 1;
		}
		return self._holding_button[4];
	#/
}

/*
	Name: down_button_held
	Namespace: util
	Checksum: 0x3885B8AA
	Offset: 0x3FA0
	Size: 0x60
	Parameters: 0
	Flags: None
*/
function down_button_held()
{
	/#
		init_button_wrappers();
		if(!isdefined(self._down_button_think_threaded))
		{
			self thread button_held_think(5);
			self._down_button_think_threaded = 1;
		}
		return self._holding_button[5];
	#/
}

/*
	Name: up_button_pressed
	Namespace: util
	Checksum: 0x5C8E3B58
	Offset: 0x4010
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function up_button_pressed()
{
	/#
		return self buttonpressed("") || self buttonpressed("");
	#/
}

/*
	Name: waittill_up_button_pressed
	Namespace: util
	Checksum: 0xD5E23911
	Offset: 0x4060
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_up_button_pressed()
{
	/#
		while(!self up_button_pressed())
		{
			waitframe(1);
		}
	#/
}

/*
	Name: down_button_pressed
	Namespace: util
	Checksum: 0xE7FC8D90
	Offset: 0x4090
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function down_button_pressed()
{
	/#
		return self buttonpressed("") || self buttonpressed("");
	#/
}

/*
	Name: waittill_down_button_pressed
	Namespace: util
	Checksum: 0x8B7950DC
	Offset: 0x40E0
	Size: 0x28
	Parameters: 0
	Flags: None
*/
function waittill_down_button_pressed()
{
	/#
		while(!self down_button_pressed())
		{
			waitframe(1);
		}
	#/
}

/*
	Name: function_4c1656d5
	Namespace: util
	Checksum: 0xACAE7C1B
	Offset: 0x4110
	Size: 0x6A
	Parameters: 0
	Flags: None
*/
function function_4c1656d5()
{
	if(function_f99d2668())
	{
		return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
	}
	return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

/*
	Name: function_16fb0a3b
	Namespace: util
	Checksum: 0x1229F819
	Offset: 0x4188
	Size: 0x122
	Parameters: 0
	Flags: None
*/
function function_16fb0a3b()
{
	if(function_f99d2668())
	{
		if(getdvarint(#"hash_23a1d3a9139af42b", 0) > 0)
		{
			return getdvarfloat(#"hash_608e7bb0e9517884", 250);
		}
		return getdvarfloat(#"hash_4e7a02edee964bf9", 250);
	}
	if(getdvarint(#"hash_23fac9a913e70c03", 0) > 0)
	{
		return getdvarfloat(#"hash_606c79b0e9348eb8", 250);
	}
	return getdvarfloat(#"hash_4ec50cedeed64871", 250);
}

/*
	Name: lerp_generic
	Namespace: util
	Checksum: 0x3D618388
	Offset: 0x42B8
	Size: 0x17C
	Parameters: 4
	Flags: Linked, Variadic
*/
function lerp_generic(localclientnum, duration, callback, vararg)
{
	starttime = getservertime(localclientnum);
	currenttime = starttime;
	elapsedtime = 0;
	defaultargs = array(currenttime, elapsedtime, localclientnum, duration);
	args = arraycombine(defaultargs, vararg, 1, 0);
	while(elapsedtime < duration)
	{
		if(isdefined(callback))
		{
			args[0] = currenttime;
			args[1] = elapsedtime;
			_single_func(undefined, callback, args);
		}
		waitframe(1);
		currenttime = getservertime(localclientnum);
		if(currenttime < starttime)
		{
			return;
		}
		elapsedtime = currenttime - starttime;
	}
	if(isdefined(callback))
	{
		args[0] = currenttime;
		args[1] = duration;
		_single_func(undefined, callback, args);
	}
}

/*
	Name: function_c16f65a3
	Namespace: util
	Checksum: 0x6D6E50B6
	Offset: 0x4440
	Size: 0x6A
	Parameters: 2
	Flags: Linked
*/
function function_c16f65a3(enemy_a, enemy_b)
{
	/#
		assert(enemy_a != enemy_b, "");
	#/
	level.var_766875b1[enemy_a] = enemy_b;
	level.var_766875b1[enemy_b] = enemy_a;
}

/*
	Name: function_73fab74d
	Namespace: util
	Checksum: 0xBC753075
	Offset: 0x44B8
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function function_73fab74d()
{
	if(isdefined(level.var_1bbf77be))
	{
		return;
	}
	level.var_1bbf77be = 1;
	function_c16f65a3(#"allies", #"axis");
	function_c16f65a3(#"team3", #"any");
	set_team_mapping(#"allies", #"axis");
}

/*
	Name: cf_team_mapping
	Namespace: util
	Checksum: 0x4E1B25B3
	Offset: 0x4578
	Size: 0x122
	Parameters: 7
	Flags: Linked
*/
function cf_team_mapping(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			set_team_mapping(#"axis", #"allies");
			break;
		}
		case 1:
		{
			set_team_mapping(#"allies", #"axis");
			break;
		}
		default:
		{
			set_team_mapping(#"allies", #"axis");
			break;
		}
	}
}

/*
	Name: preload_frontend
	Namespace: util
	Checksum: 0x4AF7D58B
	Offset: 0x46A8
	Size: 0x5C
	Parameters: 7
	Flags: Linked
*/
function preload_frontend(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval == 1)
	{
		function_223e25d3();
	}
}

/*
	Name: set_team_mapping
	Namespace: util
	Checksum: 0x3F804329
	Offset: 0x4710
	Size: 0x292
	Parameters: 2
	Flags: Linked
*/
function set_team_mapping(str_team_for_sidea, str_team_for_sideb)
{
	if(str_team_for_sidea == #"allies")
	{
		str_team_for_sidea = #"allies";
	}
	else if(str_team_for_sidea == #"axis")
	{
		str_team_for_sidea = #"axis";
	}
	if(str_team_for_sideb == #"axis")
	{
		str_team_for_sideb = #"axis";
	}
	else if(str_team_for_sideb == #"allies")
	{
		str_team_for_sideb = #"allies";
	}
	/#
		assert(str_team_for_sidea != str_team_for_sideb, "");
	#/
	level.team_mapping[#"sidea"] = str_team_for_sidea;
	level.team_mapping[#"sideb"] = str_team_for_sideb;
	level.team_mapping[#"attacker"] = str_team_for_sidea;
	level.team_mapping[#"defender"] = str_team_for_sideb;
	level.team_mapping[#"attackers"] = str_team_for_sidea;
	level.team_mapping[#"defenders"] = str_team_for_sideb;
	level.team_mapping[#"wun"] = #"allies";
	level.team_mapping[#"fpa"] = #"axis";
	level.team_mapping[#"teama"] = level.team_mapping[#"sidea"];
	level.team_mapping[#"teamb"] = level.team_mapping[#"sideb"];
	level.team_mapping[#"side3"] = #"team3";
}

/*
	Name: get_team_mapping
	Namespace: util
	Checksum: 0x36D0B874
	Offset: 0x49B0
	Size: 0x62
	Parameters: 1
	Flags: Linked
*/
function get_team_mapping(str_team)
{
	/#
		assert(isdefined(str_team));
	#/
	if(isdefined(level.team_mapping))
	{
		result = level.team_mapping[str_team];
		if(isdefined(result))
		{
			return result;
		}
	}
	return str_team;
}

/*
	Name: get_enemy_team
	Namespace: util
	Checksum: 0x72D1BDB6
	Offset: 0x4A20
	Size: 0x7A
	Parameters: 1
	Flags: None
*/
function get_enemy_team(team)
{
	team = get_team_mapping(team);
	if(!isdefined(team))
	{
		return undefined;
	}
	if(isdefined(level.var_766875b1) && isdefined(level.var_766875b1[team]))
	{
		return level.var_766875b1[team];
	}
	return #"none";
}

/*
	Name: function_35aed314
	Namespace: util
	Checksum: 0x2CDB38FD
	Offset: 0x4AA8
	Size: 0x13E
	Parameters: 2
	Flags: None
*/
function function_35aed314(teama, teamb)
{
	teama = get_team_mapping(teama);
	teamb = get_team_mapping(teamb);
	if(!isdefined(teama) || !isdefined(teamb))
	{
		return 0;
	}
	if(teama == teamb)
	{
		return 0;
	}
	if(isdefined(level.var_766875b1))
	{
		if(isdefined(level.var_766875b1[teama]))
		{
			if(#"any" == level.var_766875b1[teama])
			{
				return 1;
			}
			if(teamb == level.var_766875b1[teama])
			{
				return 1;
			}
		}
		if(isdefined(level.var_766875b1[teamb]))
		{
			if(#"any" == level.var_766875b1[teamb])
			{
				return 1;
			}
			if(teama == level.var_766875b1[teamb])
			{
				return 1;
			}
		}
	}
	return 0;
}

/*
	Name: is_on_side
	Namespace: util
	Checksum: 0xBA87DB86
	Offset: 0x4BF0
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function is_on_side(str_team)
{
	return self.team === get_team_mapping(str_team);
}

/*
	Name: function_5df4294
	Namespace: util
	Checksum: 0x48C206BC
	Offset: 0x4C20
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_5df4294()
{
	return tolower(getdvarstring(#"g_gametype"));
}

/*
	Name: function_53bbf9d2
	Namespace: util
	Checksum: 0x1A5EF152
	Offset: 0x4C60
	Size: 0x32
	Parameters: 0
	Flags: Linked
*/
function function_53bbf9d2()
{
	return tolower(getdvarstring(#"hash_3b7b241b78207c96"));
}

/*
	Name: function_3f165ee8
	Namespace: util
	Checksum: 0x637A394C
	Offset: 0x4CA0
	Size: 0x1C
	Parameters: 0
	Flags: Linked
*/
function function_3f165ee8()
{
	return function_53bbf9d2() === "core_frontend";
}

/*
	Name: function_26489405
	Namespace: util
	Checksum: 0xBBEEF6A2
	Offset: 0x4CC8
	Size: 0x96
	Parameters: 0
	Flags: Linked
*/
function function_26489405()
{
	isnightmap = 0;
	mapname = function_53bbf9d2();
	switch(mapname)
	{
		case "hash_623073ec102c587a":
		{
			isnightmap = 1;
			break;
		}
		case "hash_5a24b2b75032fad0":
		{
			isnightmap = 1;
			break;
		}
		default:
		{
			break;
		}
	}
	return isnightmap;
}

/*
	Name: function_8570168d
	Namespace: util
	Checksum: 0xCA020CC2
	Offset: 0x4D68
	Size: 0x7C
	Parameters: 0
	Flags: None
*/
function function_8570168d()
{
	/#
		if(getdvar(#"hash_49e94b7aefac4f49", 0))
		{
			return 1;
		}
	#/
	if(sessionmodeismultiplayergame())
	{
		mode = function_bea73b01();
		if(mode == 4)
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: function_bca268b3
	Namespace: util
	Checksum: 0x230D820C
	Offset: 0x4DF0
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function function_bca268b3()
{
	mode = function_bea73b01();
	if(mode == 3)
	{
		return 1;
	}
	return 0;
}

/*
	Name: script_wait
	Namespace: util
	Checksum: 0x91E05915
	Offset: 0x4E30
	Size: 0x15A
	Parameters: 0
	Flags: None
*/
function script_wait()
{
	n_time = gettime();
	if(isdefined(self.script_wait))
	{
		wait(self.script_wait);
		if(isdefined(self.script_wait_add))
		{
			self.script_wait = self.script_wait + self.script_wait_add;
		}
	}
	n_min = (isdefined(self.script_wait_min) ? self.script_wait_min : 0);
	n_max = (isdefined(self.script_wait_max) ? self.script_wait_max : 0);
	if(n_max > n_min)
	{
		wait(randomfloatrange(n_min, n_max));
		self.script_wait_min = self.script_wait_min + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
		self.script_wait_max = self.script_wait_max + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
	}
	else if(n_min > 0)
	{
		wait(n_min);
		self.script_wait_min = self.script_wait_min + (isdefined(self.script_wait_add) ? self.script_wait_add : 0);
	}
	return gettime() - n_time;
}

/*
	Name: lock_model
	Namespace: util
	Checksum: 0x9CF5EADF
	Offset: 0x4F98
	Size: 0x96
	Parameters: 1
	Flags: Linked
*/
function lock_model(model)
{
	if(isdefined(model))
	{
		if(!isdefined(level.model_locks))
		{
			level.model_locks = [];
		}
		if(!isdefined(level.model_locks[model]))
		{
			level.model_locks[model] = 0;
		}
		if(level.model_locks[model] < 1)
		{
			forcestreamxmodel(model);
		}
		level.model_locks[model]++;
	}
}

/*
	Name: unlock_model
	Namespace: util
	Checksum: 0x2A8EF3CE
	Offset: 0x5038
	Size: 0x9C
	Parameters: 1
	Flags: Linked
*/
function unlock_model(model)
{
	if(!isdefined(level.model_locks))
	{
		level.model_locks = [];
	}
	if(isdefined(model) && isdefined(level.model_locks[model]))
	{
		if(level.model_locks[model] > 0)
		{
			level.model_locks[model]--;
			if(level.model_locks[model] < 1)
			{
				stopforcestreamingxmodel(model);
			}
		}
	}
}

/*
	Name: function_48e57e36
	Namespace: util
	Checksum: 0xD7AD60C5
	Offset: 0x50E0
	Size: 0x1F4
	Parameters: 1
	Flags: Linked
*/
function function_48e57e36(var_1f1d12d8)
{
	base = 1;
	decimal = 0;
	for(i = var_1f1d12d8.size - 1; i >= 0; i--)
	{
		if(var_1f1d12d8[i] >= "0" && var_1f1d12d8[i] <= "9")
		{
			decimal = decimal + int(var_1f1d12d8[i]) * base;
			base = base * 16;
			continue;
		}
		if(var_1f1d12d8[i] >= "a" && var_1f1d12d8[i] <= "f")
		{
			if(var_1f1d12d8[i] == "a")
			{
				number = 10;
			}
			else if(var_1f1d12d8[i] == "b")
			{
				number = 11;
			}
			else if(var_1f1d12d8[i] == "c")
			{
				number = 12;
			}
			else if(var_1f1d12d8[i] == "d")
			{
				number = 13;
			}
			else if(var_1f1d12d8[i] == "e")
			{
				number = 14;
			}
			else if(var_1f1d12d8[i] == "f")
			{
				number = 15;
			}
			decimal = decimal + number * base;
			base = base * 16;
		}
	}
	return decimal;
}

/*
	Name: function_e2e9d901
	Namespace: util
	Checksum: 0xF9D0BD1C
	Offset: 0x52E0
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function function_e2e9d901(localclientnum, menu_path, commands)
{
	/#
		adddebugcommand(localclientnum, "" + menu_path + "" + commands + "");
	#/
}

/*
	Name: function_d84da933
	Namespace: util
	Checksum: 0xA50D1339
	Offset: 0x5348
	Size: 0x44
	Parameters: 2
	Flags: None
*/
function function_d84da933(localclientnum, menu_path)
{
	/#
		adddebugcommand(localclientnum, "" + menu_path + "");
	#/
}

