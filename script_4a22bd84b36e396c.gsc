// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace behave;

/*
	Name: main
	Namespace: behave
	Checksum: 0x80F724D1
	Offset: 0x68
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function main()
{
}

/*
	Name: end_script
	Namespace: behave
	Checksum: 0x8E7C621E
	Offset: 0x78
	Size: 0x20
	Parameters: 0
	Flags: Linked
*/
function end_script()
{
	if(isdefined(self.___archetypeonanimscriptedcallback))
	{
		[[self.___archetypeonanimscriptedcallback]](self);
	}
}

