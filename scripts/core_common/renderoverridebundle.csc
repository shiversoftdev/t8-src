// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\shoutcaster.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace renderoverridebundle;

/*
	Name: function_89f2df9
	Namespace: renderoverridebundle
	Checksum: 0x60A63078
	Offset: 0xF8
	Size: 0x34
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register("renderoverridebundle", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: renderoverridebundle
	Checksum: 0xDCC57D58
	Offset: 0x138
	Size: 0xEC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.renderoverridebundle = {#hash_383fe4d6:[], #hash_275d5e63:[]};
	callback::on_localclient_connect(&function_d7ae6bbb);
	function_f72f089c(#"hash_ebb37dab2ee0ae3", (sessionmodeiscampaigngame() ? #"hash_461520942fd1154d" : #"rob_sonar_set_friendlyequip_mp"), &function_6803f977);
	function_f72f089c(#"hash_16bdbd0b3de5c91a", #"hash_71fbf1094f57b910", &function_fac25f84);
}

/*
	Name: function_d7ae6bbb
	Namespace: renderoverridebundle
	Checksum: 0xAE919FAF
	Offset: 0x230
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function function_d7ae6bbb(clientnum)
{
	if(!isdefined(level.renderoverridebundle.var_275d5e63[clientnum]))
	{
		level.renderoverridebundle.var_275d5e63[clientnum] = {#hash_e04728e4:[]};
	}
	thread function_e04728e4(clientnum);
}

/*
	Name: function_25996839
	Namespace: renderoverridebundle
	Checksum: 0x1C4F7001
	Offset: 0x2A8
	Size: 0xAC
	Parameters: 4
	Flags: Private
*/
private function function_25996839(var_166900a8, bundle, validity_func, var_35a2c593)
{
	/#
		var_3a009b84 = level.renderoverridebundle.var_383fe4d6[var_166900a8];
		if(!isdefined(var_3a009b84))
		{
			return 0;
		}
		if(var_3a009b84.bundle != bundle)
		{
			return 1;
		}
		if(var_3a009b84.validity_func != validity_func)
		{
			return 1;
		}
		if(var_3a009b84.var_35a2c593 != var_35a2c593)
		{
			return 1;
		}
		return 0;
	#/
}

/*
	Name: function_f72f089c
	Namespace: renderoverridebundle
	Checksum: 0x99F9671B
	Offset: 0x360
	Size: 0x13E
	Parameters: 6
	Flags: Linked
*/
function function_f72f089c(var_166900a8, bundle, validity_func, var_35a2c593, default_bundle, var_e156fd4)
{
	/#
		assert(isdefined(level.renderoverridebundle));
	#/
	if(!isdefined(level.renderoverridebundle.var_383fe4d6))
	{
		level.renderoverridebundle.var_383fe4d6 = [];
	}
	/#
		/#
			assert(!function_25996839(var_166900a8, bundle, validity_func, var_35a2c593));
		#/
	#/
	level.renderoverridebundle.var_383fe4d6[var_166900a8] = {#hash_e156fd4:var_e156fd4, #default_bundle:default_bundle, #hash_1a5b7293:0, #hash_35a2c593:var_35a2c593, #validity_func:validity_func, #bundle:bundle};
}

/*
	Name: function_2dbeddb5
	Namespace: renderoverridebundle
	Checksum: 0x7DFC27AA
	Offset: 0x4A8
	Size: 0x5C
	Parameters: 2
	Flags: Linked
*/
function function_2dbeddb5(local_client_num, var_166900a8)
{
	/#
		assert(isdefined(level.renderoverridebundle.var_383fe4d6[var_166900a8]));
	#/
	return level.renderoverridebundle.var_383fe4d6[var_166900a8];
}

/*
	Name: function_e04728e4
	Namespace: renderoverridebundle
	Checksum: 0x968D3B45
	Offset: 0x510
	Size: 0x26E
	Parameters: 1
	Flags: Linked
*/
function function_e04728e4(local_client_num)
{
	while(true)
	{
		result = undefined;
		result = level waittill(#"demo_jump", #"killcam_begin", #"killcam_end", #"player_switch", #"joined_team", #"localplayer_spawned", #"hash_7f642789ed08aae0", #"hash_2452fc0a6548ed2d");
		if(result._notify == "killcam_end")
		{
			function_9129cbe3(local_client_num);
		}
		foreach(entity_num, var_29e36786 in level.renderoverridebundle.var_275d5e63[local_client_num].var_e04728e4)
		{
			entity = getentbynum(local_client_num, entity_num);
			if(isalive(entity))
			{
				foreach(flag, var_166900a8 in var_29e36786)
				{
					if(shoutcaster::is_shoutcaster(local_client_num) && (var_166900a8 == #"hash_2f86d28434166be7" || var_166900a8 == #"hash_16bdbd0b3de5c91a"))
					{
						continue;
					}
					entity thread function_c8d97b8e(local_client_num, flag, var_166900a8);
				}
			}
		}
		waitframe(1);
	}
}

/*
	Name: function_9129cbe3
	Namespace: renderoverridebundle
	Checksum: 0x4EFF8073
	Offset: 0x788
	Size: 0x144
	Parameters: 1
	Flags: Linked
*/
function function_9129cbe3(local_client_num)
{
	foreach(entity_num, var_29e36786 in level.renderoverridebundle.var_275d5e63[local_client_num].var_e04728e4)
	{
		entity = getentbynum(local_client_num, entity_num);
		if(!isdefined(entity))
		{
			continue;
		}
		foreach(flag, var_3a009b84 in var_29e36786)
		{
			if(entity flag::exists(flag))
			{
				entity flag::clear(flag);
			}
		}
	}
}

/*
	Name: start_bundle
	Namespace: renderoverridebundle
	Checksum: 0x7362613D
	Offset: 0x8D8
	Size: 0x96
	Parameters: 2
	Flags: Linked
*/
function start_bundle(flag, bundle)
{
	is_set = flag::get(flag);
	if(!flag::get(flag))
	{
		self flag::toggle(flag);
		self function_bf9d3071(bundle);
		self notify("kill" + flag + bundle);
	}
}

/*
	Name: stop_bundle
	Namespace: renderoverridebundle
	Checksum: 0xA0663A59
	Offset: 0x978
	Size: 0xA4
	Parameters: 3
	Flags: Linked
*/
function stop_bundle(flag, bundle, var_e156fd4)
{
	self notify("kill" + flag + bundle);
	if(flag::get(flag))
	{
		self flag::toggle(flag);
		if(var_e156fd4 === 1)
		{
			self function_f6e99a8d(bundle);
		}
		else
		{
			self function_5d482e78(bundle);
		}
	}
}

/*
	Name: fade_bundle
	Namespace: renderoverridebundle
	Checksum: 0x71026D37
	Offset: 0xA28
	Size: 0xBC
	Parameters: 4
	Flags: None
*/
function fade_bundle(localclientnum, flag, bundle, fadeduration)
{
	self endon(#"death");
	if(flag::get(flag))
	{
		util::lerp_generic(localclientnum, fadeduration, &function_9e7290f5, 1, 0, bundle);
	}
	wait(float(fadeduration) / 1000);
	stop_bundle(flag, bundle, 0);
}

/*
	Name: function_9e7290f5
	Namespace: renderoverridebundle
	Checksum: 0x7CF5DE5D
	Offset: 0xAF0
	Size: 0xAC
	Parameters: 7
	Flags: Linked
*/
function function_9e7290f5(currenttime, elapsedtime, localclientnum, fadeduration, from, to, bundle)
{
	percent = elapsedtime / fadeduration;
	amount = to * percent + from * 1 - percent;
	self function_78233d29(bundle, "", #"alpha", amount);
}

/*
	Name: function_318de8bd
	Namespace: renderoverridebundle
	Checksum: 0x9C4199DB
	Offset: 0xBA8
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function function_318de8bd(local_client_num, var_80292ef8)
{
	if(!isdefined(var_80292ef8.validity_func) && isdefined(var_80292ef8.var_35a2c593))
	{
		return 1;
	}
	if(isdefined(var_80292ef8.var_35a2c593))
	{
		if(!isdefined(var_80292ef8.validity_func))
		{
			return var_80292ef8.var_35a2c593;
		}
		return [[var_80292ef8.validity_func]](local_client_num, var_80292ef8.bundle, var_80292ef8.var_35a2c593);
	}
	return [[var_80292ef8.validity_func]](local_client_num, var_80292ef8);
}

/*
	Name: function_c8d97b8e
	Namespace: renderoverridebundle
	Checksum: 0xF5576EC2
	Offset: 0xC60
	Size: 0x34C
	Parameters: 3
	Flags: Linked
*/
function function_c8d97b8e(local_client_num, flag, var_166900a8)
{
	if(!self flag::exists(flag))
	{
		self flag::init(flag);
	}
	if(function_f99d2668())
	{
		if(self.type === "actor_corpse" || self.type === "player_corpse")
		{
			return;
		}
	}
	else if(self.type === "actor_corpse" || self.type === "vehicle_corpse" || self.type === "player_corpse")
	{
		return;
	}
	var_80292ef8 = function_2dbeddb5(local_client_num, var_166900a8);
	if(function_318de8bd(local_client_num, var_80292ef8))
	{
		if(isdefined(var_80292ef8.default_bundle))
		{
			self stop_bundle(flag, var_80292ef8.default_bundle, 1);
		}
		self start_bundle(flag, var_80292ef8.bundle);
	}
	else if(var_80292ef8.var_1a5b7293 && isdefined(var_80292ef8.default_bundle))
	{
		self stop_bundle(flag, var_80292ef8.bundle, 1);
		self start_bundle(flag, var_80292ef8.default_bundle);
		var_80292ef8.var_1a5b7293 = 0;
	}
	else
	{
		self stop_bundle(flag, var_80292ef8.bundle, var_80292ef8.var_e156fd4);
		if(isdefined(var_80292ef8.default_bundle))
		{
			self stop_bundle(flag, var_80292ef8.default_bundle, var_80292ef8.var_e156fd4);
		}
	}
	entity_num = self getentitynumber();
	if(!isdefined(level.renderoverridebundle.var_275d5e63[local_client_num]))
	{
		level.renderoverridebundle.var_275d5e63[local_client_num] = {#hash_e04728e4:[]};
	}
	if(!isdefined(level.renderoverridebundle.var_275d5e63[local_client_num].var_e04728e4[entity_num]))
	{
		level.renderoverridebundle.var_275d5e63[local_client_num].var_e04728e4[entity_num] = [];
	}
	level.renderoverridebundle.var_275d5e63[local_client_num].var_e04728e4[entity_num][flag] = var_166900a8;
}

/*
	Name: function_6803f977
	Namespace: renderoverridebundle
	Checksum: 0x8926E050
	Offset: 0xFB8
	Size: 0xDA
	Parameters: 2
	Flags: Linked
*/
function function_6803f977(local_client_num, bundle)
{
	if(!self function_4e0ca360() || self.team === #"free")
	{
		return 0;
	}
	if(isdefined(level.vision_pulse) && (isdefined(level.vision_pulse[local_client_num]) && level.vision_pulse[local_client_num]))
	{
		return 0;
	}
	player = function_5c10bd79(local_client_num);
	if(player.var_33b61b6f === 1)
	{
		bundle.var_e156fd4 = 1;
		return 0;
	}
	return 1;
}

/*
	Name: function_ce7fd1b9
	Namespace: renderoverridebundle
	Checksum: 0x5517CD2
	Offset: 0x10A0
	Size: 0xB2
	Parameters: 2
	Flags: None
*/
function function_ce7fd1b9(local_client_num, bundle)
{
	if(self function_21c0fa55())
	{
		return 0;
	}
	if(self function_4e0ca360() && self.team !== #"free")
	{
		return 0;
	}
	player = function_5c10bd79(local_client_num);
	if(player.var_33b61b6f === 1)
	{
		bundle.var_e156fd4 = 1;
		return 0;
	}
	return 1;
}

/*
	Name: function_fac25f84
	Namespace: renderoverridebundle
	Checksum: 0x88B77A5E
	Offset: 0x1160
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function function_fac25f84(local_client_num, bundle)
{
	if(level.gameended)
	{
		return 0;
	}
	if(!shoutcaster::is_shoutcaster(local_client_num))
	{
		return 0;
	}
	return 1;
}

/*
	Name: function_ee77bff9
	Namespace: renderoverridebundle
	Checksum: 0xCC74F491
	Offset: 0x11B0
	Size: 0x94
	Parameters: 4
	Flags: None
*/
function function_ee77bff9(local_client_num, field_name, bundle, var_d9c61b9c)
{
	local_player = function_5c10bd79(local_client_num);
	var_657eb40b = (isdefined(local_player) ? local_player clientfield::get_to_player(field_name) : 0);
	self function_f4eab437(local_client_num, var_657eb40b, bundle, var_d9c61b9c);
}

/*
	Name: function_f4eab437
	Namespace: renderoverridebundle
	Checksum: 0x1CC3F3DF
	Offset: 0x1250
	Size: 0xAC
	Parameters: 4
	Flags: Linked
*/
function function_f4eab437(local_client_num, var_657eb40b, bundle, var_d9c61b9c)
{
	if(isdefined(var_d9c61b9c))
	{
		var_657eb40b = self [[var_d9c61b9c]](local_client_num, var_657eb40b);
	}
	is_playing = self function_d2503806(bundle);
	if(var_657eb40b)
	{
		if(!is_playing)
		{
			self function_bf9d3071(bundle);
		}
	}
	else if(is_playing)
	{
		self function_5d482e78(bundle);
	}
}

