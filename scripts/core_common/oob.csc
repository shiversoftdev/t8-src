// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace oob;

/*
	Name: __init__system__
	Namespace: oob
	Checksum: 0x8E7A412A
	Offset: 0xF8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"out_of_bounds", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: oob
	Checksum: 0x3448B0B7
	Offset: 0x140
	Size: 0x20C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(sessionmodeismultiplayergame())
	{
		level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 3000);
		level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
	}
	else
	{
		if(sessionmodeiswarzonegame())
		{
			level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 10000);
			level.oob_timekeep_ms = getdvarint(#"oob_timekeep_ms", 3000);
		}
		else
		{
			level.oob_timelimit_ms = getdvarint(#"oob_timelimit_ms", 6000);
		}
	}
	clientfield::register("toplayer", "out_of_bounds", 1, 5, "int", &onoutofboundschange, 0, 1);
	clientfield::register("toplayer", "nonplayer_oob_usage", 1, 1, "int", &function_95c61f07, 0, 1);
	callback::on_localclient_connect(&on_localplayer_connect);
	callback::on_localplayer_spawned(&on_localplayer_spawned);
	callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

/*
	Name: on_localplayer_connect
	Namespace: oob
	Checksum: 0x652528F9
	Offset: 0x358
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_connect(localclientnum)
{
	oobmodel = getoobuimodel(localclientnum);
	setuimodelvalue(oobmodel, 0);
}

/*
	Name: on_localplayer_spawned
	Namespace: oob
	Checksum: 0xDE26E0D8
	Offset: 0x3A8
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_spawned(localclientnum)
{
	filter::disable_filter_oob(localclientnum, 0);
	self randomfade(0);
}

/*
	Name: on_localplayer_shutdown
	Namespace: oob
	Checksum: 0x14C79715
	Offset: 0x3F0
	Size: 0x3C
	Parameters: 1
	Flags: Linked
*/
function on_localplayer_shutdown(localclientnum)
{
	localplayer = self;
	if(isdefined(localplayer))
	{
		stopoutofboundseffects(localclientnum, localplayer);
	}
}

/*
	Name: function_95c61f07
	Namespace: oob
	Checksum: 0xDBBBE59D
	Offset: 0x438
	Size: 0x5E
	Parameters: 7
	Flags: Linked
*/
function function_95c61f07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(newval > 0)
	{
		self.nonplayeroobusage = 1;
	}
	else
	{
		self.nonplayeroobusage = undefined;
	}
}

/*
	Name: onoutofboundschange
	Namespace: oob
	Checksum: 0x5E07FE5A
	Offset: 0x4A0
	Size: 0x43C
	Parameters: 7
	Flags: Linked
*/
function onoutofboundschange(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!isdefined(level.oob_sound_ent))
	{
		level.oob_sound_ent = [];
	}
	if(!isdefined(level.oob_sound_ent[localclientnum]))
	{
		level.oob_sound_ent[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_origin");
	}
	localplayer = function_5c10bd79(localclientnum);
	if(function_3132f113(localplayer))
	{
		return;
	}
	self callback::entity_callback(#"oob", localclientnum, {#new_val:newval, #old_val:oldval});
	if(newval > 0)
	{
		if(!isdefined(localplayer.oob_effect_enabled))
		{
			filter::init_filter_oob(localplayer);
			filter::enable_filter_oob(localclientnum, 0);
			localplayer.oob_effect_enabled = 1;
			if(util::get_game_type() === #"zstandard")
			{
				level.oob_sound_ent[localclientnum] playloopsound(#"hash_6da7ae12f538ef5e", 0.5);
			}
			else
			{
				level.oob_sound_ent[localclientnum] playloopsound(#"uin_out_of_bounds_loop", 0.5);
			}
			oobmodel = getoobuimodel(localclientnum);
			if(isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time) && isdefined(self.oob_active_duration) && (getservertime(0) - self.oob_end_time) < level.oob_timekeep_ms)
			{
				setuimodelvalue(oobmodel, getservertime(0, 1) + (level.oob_timelimit_ms - self.oob_active_duration));
			}
			else
			{
				self.oob_active_duration = undefined;
				setuimodelvalue(oobmodel, getservertime(0, 1) + level.oob_timelimit_ms);
			}
			self.oob_start_time = getservertime(0, 1);
		}
		newvalf = newval / 31;
		if(newvalf > 0.5)
		{
			newvalf = 0.5;
		}
		localplayer randomfade(newvalf);
	}
	else
	{
		if(isdefined(level.oob_timekeep_ms) && isdefined(self.oob_start_time))
		{
			self.oob_end_time = getservertime(0, 1);
			if(!isdefined(self.oob_active_duration))
			{
				self.oob_active_duration = 0;
			}
			self.oob_active_duration = self.oob_active_duration + (self.oob_end_time - self.oob_start_time);
		}
		if(isdefined(self.nonplayeroobusage) && self.nonplayeroobusage)
		{
			self.oob_active_duration = undefined;
		}
		stopoutofboundseffects(localclientnum, localplayer);
	}
}

/*
	Name: stopoutofboundseffects
	Namespace: oob
	Checksum: 0x1D8F71B8
	Offset: 0x8E8
	Size: 0x10E
	Parameters: 2
	Flags: Linked
*/
function stopoutofboundseffects(localclientnum, localplayer)
{
	if(!isdefined(localplayer))
	{
		return;
	}
	filter::disable_filter_oob(localclientnum, 0);
	if(isdefined(localplayer))
	{
		localplayer randomfade(0);
	}
	if(isdefined(level.oob_sound_ent) && isdefined(level.oob_sound_ent[localclientnum]))
	{
		level.oob_sound_ent[localclientnum] stopallloopsounds(0.5);
	}
	oobmodel = getoobuimodel(localclientnum);
	setuimodelvalue(oobmodel, 0);
	if(isdefined(localplayer) && isdefined(localplayer.oob_effect_enabled))
	{
		localplayer.oob_effect_enabled = 0;
		localplayer.oob_effect_enabled = undefined;
	}
}

/*
	Name: getoobuimodel
	Namespace: oob
	Checksum: 0x4F4CDB7A
	Offset: 0xA00
	Size: 0x4A
	Parameters: 1
	Flags: Linked
*/
function getoobuimodel(localclientnum)
{
	controllermodel = getuimodelforcontroller(localclientnum);
	return createuimodel(controllermodel, "hudItems.outOfBoundsEndTime");
}

