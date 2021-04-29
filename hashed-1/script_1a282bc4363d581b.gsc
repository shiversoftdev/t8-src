// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;

#namespace archetype_human;

/*
	Name: precache
	Namespace: archetype_human
	Checksum: 0x80F724D1
	Offset: 0x90
	Size: 0x4
	Parameters: 0
	Flags: AutoExec
*/
autoexec function precache()
{
}

/*
	Name: main
	Namespace: archetype_human
	Checksum: 0xA3A30B1F
	Offset: 0xA0
	Size: 0x4C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function main()
{
	clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

/*
	Name: facialdialoguehandler
	Namespace: humanclientutils
	Checksum: 0xA6B5609A
	Offset: 0xF8
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(newvalue)
	{
		self.facialdialogueactive = 1;
	}
	else if(isdefined(self.facialdialogueactive) && self.facialdialogueactive)
	{
		self clearanim(#"faces", 0);
	}
}

