// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\ai_shared.csc;

#namespace notetracks;

/*
	Name: main
	Namespace: notetracks
	Checksum: 0x2FD4D341
	Offset: 0xE8
	Size: 0x6C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	if(sessionmodeiszombiesgame() && getdvarint(#"splitscreen_playercount", 0) > 2)
	{
		return;
	}
	ai::add_ai_spawn_function(&initializenotetrackhandlers);
}

/*
	Name: initializenotetrackhandlers
	Namespace: notetracks
	Checksum: 0x7CCB7DA7
	Offset: 0x160
	Size: 0x84
	Parameters: 1
	Flags: Linked, Private
*/
function private initializenotetrackhandlers(localclientnum)
{
	addsurfacenotetrackfxhandler(localclientnum, "jumping", "surfacefxtable_jumping");
	addsurfacenotetrackfxhandler(localclientnum, "landing", "surfacefxtable_landing");
	addsurfacenotetrackfxhandler(localclientnum, "vtol_landing", "surfacefxtable_vtollanding");
}

/*
	Name: addsurfacenotetrackfxhandler
	Namespace: notetracks
	Checksum: 0x3493D56E
	Offset: 0x1F0
	Size: 0x4C
	Parameters: 3
	Flags: Linked, Private
*/
function private addsurfacenotetrackfxhandler(localclientnum, notetrack, surfacetable)
{
	entity = self;
	entity thread handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable);
}

/*
	Name: handlesurfacenotetrackfx
	Namespace: notetracks
	Checksum: 0xDDB39AF1
	Offset: 0x248
	Size: 0xB0
	Parameters: 3
	Flags: Linked, Private
*/
function private handlesurfacenotetrackfx(localclientnum, notetrack, surfacetable)
{
	entity = self;
	entity endon(#"death");
	while(true)
	{
		entity waittill(notetrack);
		fxname = entity getaifxname(localclientnum, surfacetable);
		if(isdefined(fxname))
		{
			playfx(localclientnum, fxname, entity.origin);
		}
	}
}

