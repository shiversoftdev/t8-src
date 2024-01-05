// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace scripted;

/*
	Name: main
	Namespace: scripted
	Checksum: 0x5B15146
	Offset: 0x80
	Size: 0x9A
	Parameters: 0
	Flags: Linked
*/
function main()
{
	self endon(#"death");
	self notify(#"killanimscript");
	self notify(#"clearsuppressionattack");
	self.codescripted[#"root"] = "body";
	self endon(#"end_sequence");
	self.a.script = "scripted";
	self waittill(#"killanimscript");
}

/*
	Name: init
	Namespace: scripted
	Checksum: 0x80072302
	Offset: 0x128
	Size: 0x4C
	Parameters: 9
	Flags: None
*/
function init(notifyname, origin, angles, theanim, animmode, root, rate, goaltime, lerptime)
{
}

/*
	Name: end_script
	Namespace: scripted
	Checksum: 0x1CC19653
	Offset: 0x180
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function end_script()
{
	if(isdefined(self.___archetypeonbehavecallback))
	{
		[[self.___archetypeonbehavecallback]](self);
	}
}

