// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\system_shared.csc;

#namespace dynent_world;

/*
	Name: __init__system__
	Namespace: dynent_world
	Checksum: 0x6F8946D5
	Offset: 0xB8
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"dynent_world", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: dynent_world
	Checksum: 0xB4888501
	Offset: 0x100
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	if(!(isdefined(getgametypesetting(#"usabledynents")) ? getgametypesetting(#"usabledynents") : 0))
	{
		return;
	}
	clientfield::register("clientuimodel", "hudItems.dynentUseHoldProgress", 13000, 5, "float", undefined, 0, 0);
}

/*
	Name: function_3981d015
	Namespace: dynent_world
	Checksum: 0x2FACDA2C
	Offset: 0x198
	Size: 0x724
	Parameters: 1
	Flags: Event
*/
event function_3981d015(eventstruct)
{
	dynent = eventstruct.ent;
	var_16a4afdc = eventstruct.state;
	bundle = function_489009c1(dynent);
	if(isdefined(bundle) && isdefined(bundle.dynentstates) && isdefined(bundle.dynentstates[var_16a4afdc]))
	{
		newstate = bundle.dynentstates[var_16a4afdc];
		var_eb7c2031 = isdefined(bundle.var_eb7c2031) && bundle.var_eb7c2031;
		var_59102aec = (isdefined(bundle.vehicledestroyed) ? bundle.vehicledestroyed : 0);
		if(var_16a4afdc == var_59102aec)
		{
			if(var_eb7c2031 && !function_8a8a409b(dynent))
			{
				if(isdefined(newstate.var_55c3fa1))
				{
					playsound(0, newstate.var_55c3fa1, dynent.origin);
				}
				return;
			}
		}
		teleport = eventstruct.teleport;
		var_718063b0 = eventstruct.var_f29ec684;
		var_c286a1ae = eventstruct.var_f2f9b257;
		if(!(isdefined(bundle.var_f710132b) && bundle.var_f710132b))
		{
			loc_000003DE:
			loc_000003FE:
			pos = ((isdefined(newstate.pos_x) ? newstate.pos_x : 0), (isdefined(newstate.pos_y) ? newstate.pos_y : 0), (isdefined(newstate.pos_z) ? newstate.pos_z : 0));
			pos = rotatepoint(pos, var_c286a1ae);
			neworigin = var_718063b0 + pos;
			pitch = var_c286a1ae[0] + (isdefined(newstate.var_9d1a4684) ? newstate.var_9d1a4684 : 0);
			yaw = var_c286a1ae[1] + (isdefined(newstate.var_d81008de) ? newstate.var_d81008de : 0);
			roll = var_c286a1ae[2] + (isdefined(newstate.var_774f5d57) ? newstate.var_774f5d57 : 0);
			newangles = (absangleclamp360(pitch), absangleclamp360(yaw), absangleclamp360(roll));
			var_a852a7dd = (isdefined(bundle.var_a852a7dd) ? bundle.var_a852a7dd : 0);
			if(!teleport && var_a852a7dd > 0)
			{
				dynent function_49ed8678(neworigin, var_a852a7dd);
				dynent function_7622f013(newangles, var_a852a7dd);
			}
			else
			{
				dynent.origin = neworigin;
				dynent.angles = newangles;
			}
		}
		if(!teleport && isdefined(newstate.var_55c3fa1))
		{
			playsound(0, newstate.var_55c3fa1, dynent.origin);
		}
		if(isdefined(newstate.var_c7ae60e8))
		{
			function_b562a1b4(dynent, newstate.var_c7ae60e8);
		}
		if(isdefined(newstate.var_879eb2ff))
		{
			starttime = 0;
			rate = (isdefined(newstate.animrate) ? newstate.animrate : 0);
			if(isdefined(newstate.var_8725802) && newstate.var_8725802)
			{
				gametime = gettime();
				if(isdefined(newstate.var_e23400ad) && newstate.var_e23400ad)
				{
					gametime = gametime + (abs((dynent.origin[0] + dynent.origin[1]) + dynent.origin[2]));
				}
				animlength = int(getanimlength(newstate.var_879eb2ff) * 1000);
				starttime = gametime / (animlength / rate);
				starttime = starttime - int(starttime);
			}
			else if(teleport && !isanimlooping(0, newstate.var_879eb2ff))
			{
				starttime = 1;
			}
			function_1e23c01f(dynent, newstate.var_879eb2ff, starttime, rate);
		}
		else
		{
			function_27b5ddff(dynent);
		}
		if(isdefined(newstate.statefx) && isdefined(eventstruct.localclientnum))
		{
			if(isdefined(dynent.fx))
			{
				stopfx(eventstruct.localclientnum, dynent.fx);
				dynent.fx = undefined;
			}
			if(newstate.statefx !== #"hash_633319dd8957ddbb")
			{
				dynent.fx = playfxondynent(newstate.statefx, dynent);
			}
		}
		setdynentenabled(dynent, isdefined(newstate.enable) && newstate.enable);
	}
}

