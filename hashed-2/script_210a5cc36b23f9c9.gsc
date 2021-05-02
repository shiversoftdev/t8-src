// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_14d2d89964cae0b1;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace destructclientutils;

/*
	Name: function_89f2df9
	Namespace: destructclientutils
	Checksum: 0x7D958756
	Offset: 0x190
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"destructible_character", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: destructclientutils
	Checksum: 0x7DF6EE6
	Offset: 0x1D8
	Size: 0x5E6
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "destructible_character_state", 1, 21, "int", &_destructhandler, 0, 0);
	destructibles = struct::get_script_bundles("destructiblecharacterdef");
	processedbundles = [];
	foreach(destructible in destructibles)
	{
		destructbundle = spawnstruct();
		destructbundle.piececount = destructible.piececount;
		destructbundle.pieces = [];
		destructbundle.name = destructible.name;
		for(index = 1; index <= destructbundle.piececount; index++)
		{
			piecestruct = spawnstruct();
			piecestruct.gibmodel = destructible.("piece" + index + "_gibmodel");
			piecestruct.gibtag = destructible.("piece" + index + "_gibtag");
			piecestruct.gibfx = destructible.("piece" + index + "_gibfx");
			piecestruct.gibfxtag = destructible.("piece" + index + "_gibeffecttag");
			if(isdefined(destructible.("piece" + index + "_gibdirX")) || isdefined(destructible.("piece" + index + "_gibdirY")) || isdefined(destructible.("piece" + index + "_gibdirZ")))
			{
				loc_000004B8:
				loc_00000500:
				piecestruct.gibdir = ((isdefined(destructible.("piece" + index + "_gibdirX")) ? destructible.("piece" + index + "_gibdirX") : 0), (isdefined(destructible.("piece" + index + "_gibdirY")) ? destructible.("piece" + index + "_gibdirY") : 0), (isdefined(destructible.("piece" + index + "_gibdirZ")) ? destructible.("piece" + index + "_gibdirZ") : 0));
			}
			piecestruct.var_8e57b530 = destructible.("piece" + index + "_gibdirscale");
			piecestruct.gibdynentfx = destructible.("piece" + index + "_gibdynentfx");
			piecestruct.gibsound = destructible.("piece" + index + "_gibsound");
			piecestruct.hitlocation = destructible.("piece" + index + "_hitlocation");
			piecestruct.hidetag = destructible.("piece" + index + "_hidetag");
			piecestruct.detachmodel = destructible.("piece" + index + "_detachmodel");
			if(isdefined(destructible.("piece" + index + "_hittags")))
			{
				piecestruct.var_d8fa3d82 = [];
				foreach(var_5440c126 in destructible.("piece" + index + "_hittags"))
				{
					if(!isdefined(piecestruct.var_d8fa3d82))
					{
						piecestruct.var_d8fa3d82 = [];
					}
					else if(!isarray(piecestruct.var_d8fa3d82))
					{
						piecestruct.var_d8fa3d82 = array(piecestruct.var_d8fa3d82);
					}
					piecestruct.var_d8fa3d82[piecestruct.var_d8fa3d82.size] = var_5440c126.var_f16c2276;
				}
			}
			destructbundle.pieces[destructbundle.pieces.size] = piecestruct;
		}
		processedbundles[destructible.name] = destructbundle;
	}
	level.destructiblecharacterdefs = processedbundles;
}

/*
	Name: _getdestructibledef
	Namespace: destructclientutils
	Checksum: 0xDFC01CD2
	Offset: 0x7C8
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
private function _getdestructibledef(entity)
{
	return level.destructiblecharacterdefs[entity.destructibledef];
}

/*
	Name: _destructhandler
	Namespace: destructclientutils
	Checksum: 0x34C99393
	Offset: 0x7F0
	Size: 0x14A
	Parameters: 7
	Flags: Linked, Private
*/
private function _destructhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump)
{
	if(!util::is_mature() || util::is_gib_restricted_build())
	{
		return;
	}
	entity = self;
	destructflags = oldvalue ^ newvalue;
	shouldspawngibs = newvalue & 1;
	if(bnewent)
	{
		destructflags = 0 ^ newvalue;
	}
	if(!isdefined(entity.destructibledef))
	{
		return;
	}
	currentdestructflag = 2;
	piecenumber = 1;
	while(destructflags >= currentdestructflag)
	{
		if(destructflags & currentdestructflag)
		{
			_destructpiece(localclientnum, entity, piecenumber, shouldspawngibs);
		}
		currentdestructflag = currentdestructflag << 1;
		piecenumber++;
	}
	entity._destruct_state = newvalue;
}

/*
	Name: _destructpiece
	Namespace: destructclientutils
	Checksum: 0xC3560F21
	Offset: 0x948
	Size: 0x1BC
	Parameters: 4
	Flags: Linked, Private
*/
private function _destructpiece(localclientnum, entity, piecenumber, shouldspawngibs)
{
	if(!isdefined(entity.destructibledef))
	{
		return;
	}
	destructbundle = _getdestructibledef(entity);
	piece = destructbundle.pieces[piecenumber - 1];
	if(isdefined(piece))
	{
		if(shouldspawngibs)
		{
			gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
			entity thread gibclientutils::_gibpiece(localclientnum, entity, piece.gibmodel, piece.gibtag, piece.gibdynentfx, piece.gibdir, piece.var_8e57b530, 1 | 2 | 4);
			gibclientutils::_playgibsound(localclientnum, entity, piece.gibsound);
		}
		else if(isdefined(piece.gibfx) && function_9229eb67(piece.gibfx))
		{
			gibclientutils::_playgibfx(localclientnum, entity, piece.gibfx, piece.gibfxtag);
		}
		_handledestructcallbacks(localclientnum, entity, piecenumber);
	}
}

/*
	Name: _getdestructstate
	Namespace: destructclientutils
	Checksum: 0x891330C4
	Offset: 0xB10
	Size: 0x32
	Parameters: 2
	Flags: Linked, Private
*/
private function _getdestructstate(localclientnum, entity)
{
	if(isdefined(entity._destruct_state))
	{
		return entity._destruct_state;
	}
	return 0;
}

/*
	Name: _handledestructcallbacks
	Namespace: destructclientutils
	Checksum: 0x7EA628B8
	Offset: 0xB50
	Size: 0xD8
	Parameters: 3
	Flags: Linked, Private
*/
private function _handledestructcallbacks(localclientnum, entity, piecenumber)
{
	if(isdefined(entity._destructcallbacks) && isdefined(entity._destructcallbacks[piecenumber]))
	{
		foreach(callback in entity._destructcallbacks[piecenumber])
		{
			if(isfunctionptr(callback))
			{
				[[callback]](localclientnum, entity, piecenumber);
			}
		}
	}
}

/*
	Name: adddestructpiececallback
	Namespace: destructclientutils
	Checksum: 0x311F091F
	Offset: 0xC30
	Size: 0xDE
	Parameters: 4
	Flags: Linked
*/
function adddestructpiececallback(localclientnum, entity, piecenumber, callbackfunction)
{
	/#
		assert(isfunctionptr(callbackfunction));
	#/
	if(!isdefined(entity._destructcallbacks))
	{
		entity._destructcallbacks = [];
	}
	if(!isdefined(entity._destructcallbacks[piecenumber]))
	{
		entity._destructcallbacks[piecenumber] = [];
	}
	destructcallbacks = entity._destructcallbacks[piecenumber];
	destructcallbacks[destructcallbacks.size] = callbackfunction;
	entity._destructcallbacks[piecenumber] = destructcallbacks;
}

/*
	Name: ispiecedestructed
	Namespace: destructclientutils
	Checksum: 0xA7C142CA
	Offset: 0xD18
	Size: 0x3E
	Parameters: 3
	Flags: Linked
*/
function ispiecedestructed(localclientnum, entity, piecenumber)
{
	return _getdestructstate(localclientnum, entity) & 1 << piecenumber;
}

