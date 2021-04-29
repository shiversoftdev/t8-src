// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace raps;

/*
	Name: function_89f2df9
	Namespace: raps
	Checksum: 0x1EE616C1
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"raps", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: raps
	Checksum: 0x4ACAD8CF
	Offset: 0x118
	Size: 0x4C
	Parameters: 0
	Flags: None
*/
function __init__()
{
	clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int", &do_side_death_fx, 0, 0);
}

/*
	Name: adjust_side_death_dir_if_trace_fail
	Namespace: raps
	Checksum: 0xBB355B35
	Offset: 0x170
	Size: 0x118
	Parameters: 4
	Flags: None
*/
function adjust_side_death_dir_if_trace_fail(origin, side_dir, fxlength, up_dir)
{
	end = origin + side_dir * fxlength;
	trace = bullettrace(origin, end, 0, self);
	if(trace[#"fraction"] < 1)
	{
		new_side_dir = vectornormalize(side_dir + up_dir);
		end = origin + new_side_dir * fxlength;
		new_trace = bullettrace(origin, end, 0, self);
		if(new_trace[#"fraction"] > trace[#"fraction"])
		{
			side_dir = new_side_dir;
		}
	}
	return side_dir;
}

/*
	Name: do_side_death_fx
	Namespace: raps
	Checksum: 0xF4C77EF9
	Offset: 0x290
	Size: 0x354
	Parameters: 7
	Flags: None
*/
function do_side_death_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	util::waittill_dobj(localclientnum);
	radius = 1;
	fxlength = 40;
	fxtag = "tag_body";
	if(newval && !binitialsnap)
	{
		if(!isdefined(self.settings))
		{
			self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
		}
		forward_direction = anglestoforward(self.angles);
		up_direction = anglestoup(self.angles);
		origin = self gettagorigin(fxtag);
		if(!isdefined(origin))
		{
			origin = self.origin + vectorscale((0, 0, 1), 15);
		}
		right_direction = vectorcross(forward_direction, up_direction);
		right_direction = vectornormalize(right_direction);
		right_start = origin + right_direction * radius;
		right_direction = adjust_side_death_dir_if_trace_fail(right_start, right_direction, fxlength, up_direction);
		left_direction = right_direction * -1;
		left_start = origin + left_direction * radius;
		left_direction = adjust_side_death_dir_if_trace_fail(left_start, left_direction, fxlength, up_direction);
		if(isdefined(self.settings.sideexplosionfx))
		{
			playfx(localclientnum, self.settings.sideexplosionfx, right_start, right_direction);
			playfx(localclientnum, self.settings.sideexplosionfx, left_start, left_direction);
		}
		if(isdefined(self.settings.killedexplosionfx))
		{
			playfx(localclientnum, self.settings.killedexplosionfx, origin, (0, 0, 1));
		}
		self playsound(localclientnum, self.deathfxsound);
		if(isdefined(self.deathquakescale) && self.deathquakescale > 0)
		{
			earthquake(localclientnum, self.deathquakescale, self.deathquakeduration, origin, self.deathquakeradius);
		}
	}
}

