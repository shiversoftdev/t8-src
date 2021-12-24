// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\exploder_shared.gsc;
#using scripts\core_common\fx_shared.gsc;
#using scripts\core_common\sound_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\zm_common\util.gsc;

#namespace fx;

/*
	Name: print_org
	Namespace: fx
	Checksum: 0x68F5AC02
	Offset: 0x90
	Size: 0x17C
	Parameters: 4
	Flags: None
*/
function print_org(fxcommand, fxid, fxpos, waittime)
{
	/#
		if(getdvarint(#"debug", 0))
		{
			println("");
			println(((((("" + fxpos[0]) + "") + fxpos[1]) + "") + fxpos[2]) + "");
			println("");
			println("");
			println(("" + fxcommand) + "");
			println(("" + fxid) + "");
			println(("" + waittime) + "");
			println("");
		}
	#/
}

/*
	Name: gunfireloopfx
	Namespace: fx
	Checksum: 0x7AD557E9
	Offset: 0x218
	Size: 0x74
	Parameters: 8
	Flags: None
*/
function gunfireloopfx(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	thread gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

/*
	Name: gunfireloopfxthread
	Namespace: fx
	Checksum: 0xD4D646F5
	Offset: 0x298
	Size: 0x20A
	Parameters: 8
	Flags: None
*/
function gunfireloopfxthread(fxid, fxpos, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	level endon(#"hash_d5682445dd3d910");
	waitframe(1);
	if(betweensetsmax < betweensetsmin)
	{
		temp = betweensetsmax;
		betweensetsmax = betweensetsmin;
		betweensetsmin = temp;
	}
	betweensetsbase = betweensetsmin;
	betweensetsrange = betweensetsmax - betweensetsmin;
	if(shotdelaymax < shotdelaymin)
	{
		temp = shotdelaymax;
		shotdelaymax = shotdelaymin;
		shotdelaymin = temp;
	}
	shotdelaybase = shotdelaymin;
	shotdelayrange = shotdelaymax - shotdelaymin;
	if(shotsmax < shotsmin)
	{
		temp = shotsmax;
		shotsmax = shotsmin;
		shotsmin = temp;
	}
	shotsbase = shotsmin;
	shotsrange = shotsmax - shotsmin;
	fxent = spawnfx(level._effect[fxid], fxpos);
	for(;;)
	{
		shotnum = shotsbase + randomint(shotsrange);
		for(i = 0; i < shotnum; i++)
		{
			triggerfx(fxent);
			wait(shotdelaybase + randomfloat(shotdelayrange));
		}
		wait(betweensetsbase + randomfloat(betweensetsrange));
	}
}

/*
	Name: gunfireloopfxvec
	Namespace: fx
	Checksum: 0x5B777F62
	Offset: 0x4B0
	Size: 0x84
	Parameters: 9
	Flags: None
*/
function gunfireloopfxvec(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	thread gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax);
}

/*
	Name: gunfireloopfxvecthread
	Namespace: fx
	Checksum: 0xFD430526
	Offset: 0x540
	Size: 0x29A
	Parameters: 9
	Flags: None
*/
function gunfireloopfxvecthread(fxid, fxpos, fxpos2, shotsmin, shotsmax, shotdelaymin, shotdelaymax, betweensetsmin, betweensetsmax)
{
	level endon(#"hash_d5682445dd3d910");
	waitframe(1);
	if(betweensetsmax < betweensetsmin)
	{
		temp = betweensetsmax;
		betweensetsmax = betweensetsmin;
		betweensetsmin = temp;
	}
	betweensetsbase = betweensetsmin;
	betweensetsrange = betweensetsmax - betweensetsmin;
	if(shotdelaymax < shotdelaymin)
	{
		temp = shotdelaymax;
		shotdelaymax = shotdelaymin;
		shotdelaymin = temp;
	}
	shotdelaybase = shotdelaymin;
	shotdelayrange = shotdelaymax - shotdelaymin;
	if(shotsmax < shotsmin)
	{
		temp = shotsmax;
		shotsmax = shotsmin;
		shotsmin = temp;
	}
	shotsbase = shotsmin;
	shotsrange = shotsmax - shotsmin;
	fxpos2 = vectornormalize(fxpos2 - fxpos);
	fxent = spawnfx(level._effect[fxid], fxpos, fxpos2);
	for(;;)
	{
		shotnum = shotsbase + randomint(shotsrange);
		for(i = 0; i < int(shotnum / level.fxfireloopmod); i++)
		{
			triggerfx(fxent);
			delay = (shotdelaybase + randomfloat(shotdelayrange)) * level.fxfireloopmod;
			if(delay < 0.05)
			{
				delay = 0.05;
			}
			wait(delay);
		}
		wait(shotdelaybase + randomfloat(shotdelayrange));
		wait(betweensetsbase + randomfloat(betweensetsrange));
	}
}

/*
	Name: grenadeexplosionfx
	Namespace: fx
	Checksum: 0xA0FAABA4
	Offset: 0x7E8
	Size: 0x5C
	Parameters: 1
	Flags: None
*/
function grenadeexplosionfx(pos)
{
	playfx(level._effect[#"hash_38faf2be38a9b539"], pos);
	earthquake(0.15, 0.5, pos, 250);
}

