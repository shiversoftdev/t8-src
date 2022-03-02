// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using script_210a5cc36b23f9c9;
#using scripts\core_common\struct.csc;

#namespace fx_character;

/*
	Name: main
	Namespace: fx_character
	Checksum: 0xD2FAE3C5
	Offset: 0xD8
	Size: 0x262
	Parameters: 0
	Flags: AutoExec
*/
function autoexec main()
{
	fxbundles = struct::get_script_bundles("fxcharacterdef");
	processedfxbundles = [];
	foreach(fxbundle in fxbundles)
	{
		processedfxbundle = spawnstruct();
		processedfxbundle.effectcount = fxbundle.effectcount;
		processedfxbundle.fx = [];
		processedfxbundle.name = fxbundle.name;
		for(index = 1; index <= fxbundle.effectcount; index++)
		{
			fx = fxbundle.(("effect" + index) + "_fx");
			if(isdefined(fx))
			{
				fxstruct = spawnstruct();
				fxstruct.attachtag = fxbundle.(("effect" + index) + "_attachtag");
				fxstruct.fx = fxbundle.(("effect" + index) + "_fx");
				fxstruct.stopongib = fxclientutils::_gibpartnametogibflag(fxbundle.(("effect" + index) + "_stopongib"));
				fxstruct.stoponpiecedestroyed = fxbundle.(("effect" + index) + "_stoponpiecedestroyed");
				processedfxbundle.fx[processedfxbundle.fx.size] = fxstruct;
			}
		}
		processedfxbundles[fxbundle.name] = processedfxbundle;
	}
	level.fxcharacterdefs = processedfxbundles;
}

#namespace fxclientutils;

/*
	Name: _getfxbundle
	Namespace: fxclientutils
	Checksum: 0x6CEAACFD
	Offset: 0x348
	Size: 0x1C
	Parameters: 1
	Flags: Linked, Private
*/
function private _getfxbundle(name)
{
	return level.fxcharacterdefs[name];
}

/*
	Name: _configentity
	Namespace: fxclientutils
	Checksum: 0x984F35B3
	Offset: 0x370
	Size: 0x13E
	Parameters: 2
	Flags: Linked, Private
*/
function private _configentity(localclientnum, entity)
{
	if(!isdefined(entity._fxcharacter))
	{
		entity._fxcharacter = [];
		handledgibs = array(8, 16, 32, 128, 256);
		foreach(gibflag in handledgibs)
		{
			gibclientutils::addgibcallback(localclientnum, entity, gibflag, &_gibhandler);
		}
		for(index = 1; index <= 20; index++)
		{
			destructclientutils::adddestructpiececallback(localclientnum, entity, index, &_destructhandler);
		}
	}
}

/*
	Name: _destructhandler
	Namespace: fxclientutils
	Checksum: 0xC1286E00
	Offset: 0x4B8
	Size: 0x13C
	Parameters: 3
	Flags: Linked, Private
*/
function private _destructhandler(localclientnum, entity, piecenumber)
{
	if(!isdefined(entity._fxcharacter))
	{
		return;
	}
	foreach(fxbundlename, fxbundleinst in entity._fxcharacter)
	{
		fxbundle = _getfxbundle(fxbundlename);
		for(index = 0; index < fxbundle.fx.size; index++)
		{
			if(isdefined(fxbundleinst[index]) && fxbundle.fx[index].stoponpiecedestroyed === piecenumber)
			{
				stopfx(localclientnum, fxbundleinst[index]);
				fxbundleinst[index] = undefined;
			}
		}
	}
}

/*
	Name: _gibhandler
	Namespace: fxclientutils
	Checksum: 0x7E7BF27A
	Offset: 0x600
	Size: 0x13C
	Parameters: 3
	Flags: Linked, Private
*/
function private _gibhandler(localclientnum, entity, gibflag)
{
	if(!isdefined(entity._fxcharacter))
	{
		return;
	}
	foreach(fxbundlename, fxbundleinst in entity._fxcharacter)
	{
		fxbundle = _getfxbundle(fxbundlename);
		for(index = 0; index < fxbundle.fx.size; index++)
		{
			if(isdefined(fxbundleinst[index]) && fxbundle.fx[index].stopongib === gibflag)
			{
				stopfx(localclientnum, fxbundleinst[index]);
				fxbundleinst[index] = undefined;
			}
		}
	}
}

/*
	Name: _gibpartnametogibflag
	Namespace: fxclientutils
	Checksum: 0x8D4F59BB
	Offset: 0x748
	Size: 0x92
	Parameters: 1
	Flags: Linked, Private
*/
function private _gibpartnametogibflag(gibpartname)
{
	if(isdefined(gibpartname))
	{
		switch(gibpartname)
		{
			case "head":
			{
				return 8;
			}
			case "hash_78c0283c2cb9beaf":
			{
				return 16;
			}
			case "hash_49764046b58adc0a":
			{
				return 32;
			}
			case "hash_1a993f3bf7b816d9":
			{
				return 128;
			}
			case "hash_27aaf946ea986fac":
			{
				return 256;
			}
		}
	}
}

/*
	Name: _isgibbed
	Namespace: fxclientutils
	Checksum: 0x8353B5DB
	Offset: 0x7E8
	Size: 0x42
	Parameters: 3
	Flags: Linked, Private
*/
function private _isgibbed(localclientnum, entity, stopongibflag)
{
	if(!isdefined(stopongibflag))
	{
		return 0;
	}
	return gibclientutils::isgibbed(localclientnum, entity, stopongibflag);
}

/*
	Name: _ispiecedestructed
	Namespace: fxclientutils
	Checksum: 0x1D9B8899
	Offset: 0x838
	Size: 0x42
	Parameters: 3
	Flags: Linked, Private
*/
function private _ispiecedestructed(localclientnum, entity, stoponpiecedestroyed)
{
	if(!isdefined(stoponpiecedestroyed))
	{
		return 0;
	}
	return destructclientutils::ispiecedestructed(localclientnum, entity, stoponpiecedestroyed);
}

/*
	Name: _shouldplayfx
	Namespace: fxclientutils
	Checksum: 0xDC423E9C
	Offset: 0x888
	Size: 0x6E
	Parameters: 3
	Flags: Linked, Private
*/
function private _shouldplayfx(localclientnum, entity, fxstruct)
{
	if(_isgibbed(localclientnum, entity, fxstruct.stopongib))
	{
		return false;
	}
	if(_ispiecedestructed(localclientnum, entity, fxstruct.stoponpiecedestroyed))
	{
		return false;
	}
	return true;
}

/*
	Name: playfxbundle
	Namespace: fxclientutils
	Checksum: 0x3C1D0CE1
	Offset: 0x900
	Size: 0x162
	Parameters: 3
	Flags: Linked
*/
function playfxbundle(localclientnum, entity, fxscriptbundle)
{
	if(!isdefined(fxscriptbundle))
	{
		return;
	}
	_configentity(localclientnum, entity);
	fxbundle = _getfxbundle(fxscriptbundle);
	if(isdefined(entity._fxcharacter[fxbundle.name]))
	{
		return;
	}
	if(isdefined(fxbundle))
	{
		playingfx = [];
		for(index = 0; index < fxbundle.fx.size; index++)
		{
			fxstruct = fxbundle.fx[index];
			if(_shouldplayfx(localclientnum, entity, fxstruct))
			{
				playingfx[index] = gibclientutils::_playgibfx(localclientnum, entity, fxstruct.fx, fxstruct.attachtag);
			}
		}
		if(playingfx.size > 0)
		{
			entity._fxcharacter[fxbundle.name] = playingfx;
		}
	}
}

/*
	Name: stopallfxbundles
	Namespace: fxclientutils
	Checksum: 0xC73D9195
	Offset: 0xA70
	Size: 0x128
	Parameters: 2
	Flags: None
*/
function stopallfxbundles(localclientnum, entity)
{
	_configentity(localclientnum, entity);
	fxbundlenames = [];
	foreach(fxbundlename, fxbundle in entity._fxcharacter)
	{
		fxbundlenames[fxbundlenames.size] = fxbundlename;
	}
	foreach(fxbundlename in fxbundlenames)
	{
		stopfxbundle(localclientnum, entity, fxbundlename);
	}
}

/*
	Name: stopfxbundle
	Namespace: fxclientutils
	Checksum: 0x1BF37B19
	Offset: 0xBA0
	Size: 0x128
	Parameters: 3
	Flags: Linked
*/
function stopfxbundle(localclientnum, entity, fxscriptbundle)
{
	if(!isdefined(fxscriptbundle))
	{
		return;
	}
	_configentity(localclientnum, entity);
	fxbundle = _getfxbundle(fxscriptbundle);
	if(isdefined(entity._fxcharacter[fxbundle.name]))
	{
		foreach(fx in entity._fxcharacter[fxbundle.name])
		{
			if(isdefined(fx))
			{
				stopfx(localclientnum, fx);
			}
		}
		entity._fxcharacter[fxbundle.name] = undefined;
	}
}

/*
	Name: function_ae92446
	Namespace: fxclientutils
	Checksum: 0xA8CA9A66
	Offset: 0xCD0
	Size: 0x128
	Parameters: 3
	Flags: Linked
*/
function function_ae92446(localclientnum, entity, fxscriptbundle)
{
	if(!isdefined(fxscriptbundle))
	{
		return;
	}
	_configentity(localclientnum, entity);
	fxbundle = _getfxbundle(fxscriptbundle);
	if(isdefined(entity._fxcharacter[fxbundle.name]))
	{
		foreach(fx in entity._fxcharacter[fxbundle.name])
		{
			if(isdefined(fx))
			{
				killfx(localclientnum, fx);
			}
		}
		entity._fxcharacter[fxbundle.name] = undefined;
	}
}

