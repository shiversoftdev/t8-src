// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace namespace_72c1550b;

/*
	Name: function_ea0556fc
	Namespace: namespace_72c1550b
	Checksum: 0xB8F48EBE
	Offset: 0x88
	Size: 0xB8
	Parameters: 1
	Flags: Linked
*/
function function_ea0556fc(targetname)
{
	targets = getdynentarray(targetname);
	foreach(target in targets)
	{
		if(target init_target())
		{
			target thread follow_path();
		}
	}
}

/*
	Name: init_target
	Namespace: namespace_72c1550b
	Checksum: 0x134EA81B
	Offset: 0x148
	Size: 0x162
	Parameters: 0
	Flags: Linked, Private
*/
function private init_target()
{
	self.hitindex = 1;
	if(!isdefined(self.target))
	{
		return false;
	}
	structs = [];
	var_3dc92b90 = 0;
	var_dc0e8c88 = struct::get(self.target, "targetname");
	struct = var_dc0e8c88;
	do
	{
		if(!isdefined(struct) || !isint(struct.script_int) || struct.script_int <= 0)
		{
			return false;
		}
		structs[structs.size] = struct;
		var_3dc92b90 = var_3dc92b90 + struct.script_int;
		struct = struct::get(struct.target, "targetname");
	}
	while(struct != var_dc0e8c88);
	/#
		assert(structs.size == 2);
	#/
	self.structs = structs;
	self.var_3dc92b90 = var_3dc92b90;
	return true;
}

/*
	Name: function_5bab934a
	Namespace: namespace_72c1550b
	Checksum: 0xBC9B85E1
	Offset: 0x2B8
	Size: 0x84
	Parameters: 2
	Flags: Linked, Private
*/
function private function_5bab934a(struct, var_d1d733b4)
{
	var_32c844bb = var_d1d733b4 - gettime();
	if(var_32c844bb <= 0)
	{
		var_32c844bb = int(1 * 1000);
	}
	movetime = float(var_32c844bb) / 1000;
	return movetime;
}

/*
	Name: follow_path
	Namespace: namespace_72c1550b
	Checksum: 0x3A533AA
	Offset: 0x348
	Size: 0x166
	Parameters: 0
	Flags: Linked, Private
*/
function private follow_path()
{
	starttime = int(((floor(gettime() / self.var_3dc92b90)) * self.var_3dc92b90) + self.var_3dc92b90);
	while(gettime() < starttime)
	{
		waitframe(1);
	}
	endtime = starttime;
	while(true)
	{
		endtime = endtime + self.structs[0].script_int;
		movetime = function_5bab934a(self.structs[0], endtime);
		self function_49ed8678(self.structs[1].origin, movetime);
		wait(movetime);
		endtime = endtime + self.structs[1].script_int;
		movetime = function_5bab934a(self.structs[1], endtime);
		self function_49ed8678(self.structs[0].origin, movetime);
		wait(movetime);
	}
}

/*
	Name: function_209450ae
	Namespace: namespace_72c1550b
	Checksum: 0xAC4A61C7
	Offset: 0x4B8
	Size: 0x1E6
	Parameters: 1
	Flags: Private, Event
*/
event private function_209450ae(eventstruct)
{
	dynent = eventstruct.ent;
	if(!isdefined(dynent.hitindex))
	{
		return;
	}
	dynent.health = 50;
	if(function_ffdbe8c2(dynent) != 0)
	{
		return;
	}
	angles = dynent.angles - vectorscale((0, 1, 0), 270);
	fwd = anglestoforward(angles);
	if((vectordot((0, 0, 0) - eventstruct.dir, fwd)) <= 0)
	{
		return;
	}
	bundle = function_489009c1(dynent);
	if(isstruct(bundle) && isarray(bundle.var_c14aa186))
	{
		var_daedea1b = bundle.var_c14aa186[dynent.hitindex];
		if(isdefined(var_daedea1b.var_879eb2ff))
		{
			function_e2a06860(dynent, dynent.hitindex);
			animlength = getanimlength(var_daedea1b.var_879eb2ff);
			wait(animlength);
			function_e2a06860(dynent, 0);
			dynent.hitindex = 1 + (dynent.hitindex % 2);
		}
	}
}

