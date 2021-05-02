// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;

#namespace ir_strobe;

/*
	Name: init_shared
	Namespace: ir_strobe
	Checksum: 0x4EDA1AFF
	Offset: 0x130
	Size: 0xB4
	Parameters: 0
	Flags: Linked
*/
function init_shared()
{
	if(!isdefined(level.var_90058911))
	{
		level.var_90058911 = {};
		clientfield::register("toplayer", "marker_state", 1, 2, "int", &marker_state_changed, 0, 0);
		level.var_9c4cdb79 = [];
	}
	forcestreamxmodel(#"hash_5f05548d8aa53dc1");
	forcestreamxmodel(#"hash_5770a33506bee5a4");
}

/*
	Name: updatemarkerthread
	Namespace: ir_strobe
	Checksum: 0xD36FCFDE
	Offset: 0x1F0
	Size: 0x15C
	Parameters: 1
	Flags: None
*/
function updatemarkerthread(localclientnum)
{
	self endon(#"death");
	player = self;
	localplayer = function_27673a7(localclientnum);
	if(player != localplayer)
	{
		return;
	}
	killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
	while(isdefined(player.markerobj))
	{
		viewangles = getlocalclientangles(localclientnum);
		forwardvector = vectorscale(anglestoforward(viewangles), killstreakcorebundle.ksmaxairdroptargetrange);
		results = bullettrace(player geteye(), player geteye() + forwardvector, 0, player);
		player.markerobj.origin = results[#"position"];
		waitframe(1);
	}
}

/*
	Name: marker_state_changed
	Namespace: ir_strobe
	Checksum: 0x4793F45
	Offset: 0x358
	Size: 0x13C
	Parameters: 7
	Flags: Linked
*/
function marker_state_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	player = self;
	killstreakcorebundle = struct::get_script_bundle("killstreak", "killstreak_core");
	if(newval > 0)
	{
		if(!isdefined(level.var_9c4cdb79[localclientnum]))
		{
			function_af2eb2da(localclientnum);
		}
	}
	if(newval > 0)
	{
		player thread previs(localclientnum, newval - 1);
	}
	else
	{
		player notify(#"hash_72e5eda620e4157");
	}
	if(isdefined(player.markerobj) && !player.markerobj hasdobj(localclientnum))
	{
		return;
	}
}

/*
	Name: function_6f798989
	Namespace: ir_strobe
	Checksum: 0x38D22DAF
	Offset: 0x4A0
	Size: 0x94
	Parameters: 1
	Flags: Linked
*/
function function_6f798989(var_a27f7ab4)
{
	if(function_9d295a8c(self.localclientnum))
	{
		localclientnum = self.localclientnum;
	}
	else
	{
		localclientnum = self getlocalclientnumber();
	}
	if(isdefined(localclientnum) && isdefined(level.var_9c4cdb79[localclientnum]))
	{
		level.var_9c4cdb79[localclientnum] hide();
	}
}

/*
	Name: previs
	Namespace: ir_strobe
	Checksum: 0x91C6E7A3
	Offset: 0x540
	Size: 0xCE
	Parameters: 2
	Flags: Linked
*/
function previs(localclientnum, invalid)
{
	self notify(#"hash_72e5eda620e4157");
	self endon_callback(&function_6f798989, #"death", #"weapon_change", #"hash_72e5eda620e4157");
	level.var_9c4cdb79[localclientnum] show();
	function_3e8d9b27(!invalid, localclientnum);
	while(true)
	{
		function_82a8db78(localclientnum, invalid);
		waitframe(1);
	}
}

/*
	Name: function_af2eb2da
	Namespace: ir_strobe
	Checksum: 0xB7039DC4
	Offset: 0x618
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function function_af2eb2da(localclientnum)
{
	localplayer = function_5c10bd79(localclientnum);
	level.var_9c4cdb79[localclientnum] = spawn(localclientnum, (0, 0, 0), "script_model", localplayer getentitynumber());
}

/*
	Name: function_82a8db78
	Namespace: ir_strobe
	Checksum: 0x6E1917C7
	Offset: 0x698
	Size: 0x30C
	Parameters: 2
	Flags: Linked
*/
function function_82a8db78(localclientnum, invalid)
{
	player = self;
	facing_angles = getlocalclientangles(localclientnum);
	forward = anglestoforward(facing_angles);
	up = anglestoup(facing_angles);
	weapon = getweapon("ir_strobe");
	velocity = function_711c258(forward, up, weapon);
	eye_pos = getlocalclienteyepos(localclientnum);
	if(isdefined(level.var_4970b0af) && level.var_4970b0af)
	{
		radius = 10;
		trace1 = bullettrace(eye_pos, eye_pos + vectorscale(forward, 300), 0, player, 1);
		if(trace1[#"fraction"] >= 1)
		{
			trace1 = bullettrace(trace1[#"position"], trace1[#"position"] + vectorscale((0, 0, -1), 1000), 0, player, 1);
		}
	}
	else
	{
		trace1 = function_e6ba3ec9(eye_pos, velocity, 0, weapon);
	}
	level.var_9c4cdb79[localclientnum].origin = trace1[#"position"] + vectorscale(trace1[#"normal"], 7);
	level.var_9c4cdb79[localclientnum].angles = (0, vectortoangles(forward)[1] + 90, 0);
	level.var_9c4cdb79[localclientnum].hitent = trace1[#"entity"];
	if(invalid)
	{
		player function_bf191832(0, (0, 0, 0), (0, 0, 0));
	}
	else
	{
		player function_bf191832(1, level.var_9c4cdb79[localclientnum].origin, level.var_9c4cdb79[localclientnum].angles);
	}
}

/*
	Name: function_3e8d9b27
	Namespace: ir_strobe
	Checksum: 0x36A72133
	Offset: 0x9B0
	Size: 0x174
	Parameters: 2
	Flags: Linked
*/
function function_3e8d9b27(var_120d5014, localclientnum)
{
	if(var_120d5014)
	{
		level.var_9c4cdb79[localclientnum] setmodel(#"hash_5f05548d8aa53dc1");
		if(isdefined(level.var_5af693e8))
		{
			stopfx(localclientnum, level.var_5af693e8);
		}
		level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_valid", level.var_9c4cdb79[localclientnum], "tag_fx");
	}
	else
	{
		level.var_9c4cdb79[localclientnum] setmodel(#"hash_5770a33506bee5a4");
		if(isdefined(level.var_5af693e8))
		{
			stopfx(localclientnum, level.var_5af693e8);
		}
		level.var_5af693e8 = function_239993de(localclientnum, "killstreaks/fx8_tankrobot_previs_invalid", level.var_9c4cdb79[localclientnum], "tag_fx");
	}
	level.var_9c4cdb79[localclientnum] notsolid();
}

