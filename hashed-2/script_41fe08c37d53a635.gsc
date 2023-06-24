// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\array_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\math_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace destructserverutils;

/*
	Name: __init__system__
	Namespace: destructserverutils
	Checksum: 0xE670CD45
	Offset: 0x230
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"destructible_character", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: destructserverutils
	Checksum: 0x53F80344
	Offset: 0x278
	Size: 0x47E
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	clientfield::register("actor", "destructible_character_state", 1, 21, "int");
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
			piecestruct.gibmodel = destructible.(("piece" + index) + "_gibmodel");
			piecestruct.gibtag = destructible.(("piece" + index) + "_gibtag");
			piecestruct.gibfx = destructible.(("piece" + index) + "_gibfx");
			piecestruct.gibfxtag = destructible.(("piece" + index) + "_gibeffecttag");
			piecestruct.gibdynentfx = destructible.(("piece" + index) + "_gibdynentfx");
			piecestruct.gibsound = destructible.(("piece" + index) + "_gibsound");
			piecestruct.hitlocation = destructible.(("piece" + index) + "_hitlocation");
			piecestruct.hidetag = destructible.(("piece" + index) + "_hidetag");
			piecestruct.detachmodel = destructible.(("piece" + index) + "_detachmodel");
			piecestruct.detachtag = destructible.(("piece" + index) + "_detachtag");
			if(isdefined(destructible.(("piece" + index) + "_hittags")))
			{
				piecestruct.hittags = [];
				foreach(var_5440c126 in destructible.(("piece" + index) + "_hittags"))
				{
					if(!isdefined(piecestruct.hittags))
					{
						piecestruct.hittags = [];
					}
					else if(!isarray(piecestruct.hittags))
					{
						piecestruct.hittags = array(piecestruct.hittags);
					}
					piecestruct.hittags[piecestruct.hittags.size] = var_5440c126.hittag;
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
	Namespace: destructserverutils
	Checksum: 0x6D8F085C
	Offset: 0x700
	Size: 0x20
	Parameters: 1
	Flags: Linked, Private
*/
function private _getdestructibledef(entity)
{
	return level.destructiblecharacterdefs[entity.destructibledef];
}

/*
	Name: function_b9568365
	Namespace: destructserverutils
	Checksum: 0x3BA6B459
	Offset: 0x728
	Size: 0x2A
	Parameters: 1
	Flags: Linked
*/
function function_b9568365(entity)
{
	if(isdefined(entity._destruct_state))
	{
		return entity._destruct_state;
	}
	return 0;
}

/*
	Name: function_f865501b
	Namespace: destructserverutils
	Checksum: 0x7C52E446
	Offset: 0x760
	Size: 0x5C
	Parameters: 3
	Flags: None
*/
function function_f865501b(entity, destruct_state, spawn_gibs)
{
	entity._destruct_state = destruct_state;
	togglespawngibs(entity, spawn_gibs);
	reapplydestructedpieces(entity);
}

/*
	Name: _setdestructed
	Namespace: destructserverutils
	Checksum: 0xE66A4BC5
	Offset: 0x7C8
	Size: 0x64
	Parameters: 2
	Flags: Linked, Private
*/
function private _setdestructed(entity, destructflag)
{
	entity._destruct_state = function_b9568365(entity) | destructflag;
	entity clientfield::set("destructible_character_state", entity._destruct_state);
}

/*
	Name: copydestructstate
	Namespace: destructserverutils
	Checksum: 0xB5F16D13
	Offset: 0x838
	Size: 0x64
	Parameters: 2
	Flags: Linked
*/
function copydestructstate(originalentity, newentity)
{
	newentity._destruct_state = function_b9568365(originalentity);
	togglespawngibs(newentity, 0);
	reapplydestructedpieces(newentity);
}

/*
	Name: destructhitlocpieces
	Namespace: destructserverutils
	Checksum: 0x890B8D2F
	Offset: 0x8A8
	Size: 0xD6
	Parameters: 2
	Flags: Linked
*/
function destructhitlocpieces(entity, hitloc)
{
	if(isdefined(entity.destructibledef))
	{
		destructbundle = _getdestructibledef(entity);
		for(index = 1; index <= destructbundle.pieces.size; index++)
		{
			piece = destructbundle.pieces[index - 1];
			if(isdefined(piece.hitlocation) && piece.hitlocation == hitloc)
			{
				destructpiece(entity, index);
			}
		}
	}
}

/*
	Name: function_629a8d54
	Namespace: destructserverutils
	Checksum: 0x4B190092
	Offset: 0x988
	Size: 0xEE
	Parameters: 2
	Flags: Linked
*/
function function_629a8d54(entity, hittag)
{
	if(isdefined(hittag) && isdefined(entity.destructibledef))
	{
		destructbundle = _getdestructibledef(entity);
		for(index = 1; index <= destructbundle.pieces.size; index++)
		{
			piece = destructbundle.pieces[index - 1];
			if(isdefined(piece.hittags) && isinarray(piece.hittags, hittag))
			{
				destructpiece(entity, index);
			}
		}
	}
}

/*
	Name: destructleftarmpieces
	Namespace: destructserverutils
	Checksum: 0xE4B9A5C9
	Offset: 0xA80
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function destructleftarmpieces(entity)
{
	destructhitlocpieces(entity, "left_arm_upper");
	destructhitlocpieces(entity, "left_arm_lower");
	destructhitlocpieces(entity, "left_hand");
}

/*
	Name: destructleftlegpieces
	Namespace: destructserverutils
	Checksum: 0xEE083DB2
	Offset: 0xAF8
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function destructleftlegpieces(entity)
{
	destructhitlocpieces(entity, "left_leg_upper");
	destructhitlocpieces(entity, "left_leg_lower");
	destructhitlocpieces(entity, "left_foot");
}

/*
	Name: destructpiece
	Namespace: destructserverutils
	Checksum: 0xD399F97A
	Offset: 0xB70
	Size: 0x1B4
	Parameters: 2
	Flags: Linked
*/
function destructpiece(entity, piecenumber)
{
	/#
		/#
			assert(1 <= piecenumber && piecenumber <= 20);
		#/
	#/
	if(isdestructed(entity, piecenumber))
	{
		return;
	}
	_setdestructed(entity, 1 << piecenumber);
	if(!isdefined(entity.destructibledef))
	{
		return;
	}
	destructbundle = _getdestructibledef(entity);
	piece = destructbundle.pieces[piecenumber - 1];
	if(isdefined(piece.hidetag) && entity haspart(piece.hidetag))
	{
		entity hidepart(piece.hidetag);
	}
	if(isdefined(piece.detachmodel) && entity isattached(piece.detachmodel))
	{
		detachtag = "";
		if(isdefined(piece.detachtag))
		{
			detachtag = piece.detachtag;
		}
		entity detach(piece.detachmodel, detachtag);
	}
}

/*
	Name: destructnumberrandompieces
	Namespace: destructserverutils
	Checksum: 0x2D31ABB5
	Offset: 0xD30
	Size: 0x15E
	Parameters: 2
	Flags: None
*/
function destructnumberrandompieces(entity, num_pieces_to_destruct = 0)
{
	destructible_pieces_list = [];
	destructablepieces = getpiececount(entity);
	if(num_pieces_to_destruct == 0)
	{
		num_pieces_to_destruct = destructablepieces;
	}
	for(i = 0; i < destructablepieces; i++)
	{
		destructible_pieces_list[i] = i + 1;
	}
	destructible_pieces_list = array::randomize(destructible_pieces_list);
	foreach(piece in destructible_pieces_list)
	{
		if(!isdestructed(entity, piece))
		{
			destructpiece(entity, piece);
			num_pieces_to_destruct--;
			if(num_pieces_to_destruct == 0)
			{
				break;
			}
		}
	}
}

/*
	Name: destructrandompieces
	Namespace: destructserverutils
	Checksum: 0x5D68415B
	Offset: 0xE98
	Size: 0x86
	Parameters: 1
	Flags: None
*/
function destructrandompieces(entity)
{
	destructpieces = getpiececount(entity);
	for(index = 0; index < destructpieces; index++)
	{
		if(math::cointoss())
		{
			destructpiece(entity, index + 1);
		}
	}
}

/*
	Name: destructrightarmpieces
	Namespace: destructserverutils
	Checksum: 0xDB362DA0
	Offset: 0xF28
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function destructrightarmpieces(entity)
{
	destructhitlocpieces(entity, "right_arm_upper");
	destructhitlocpieces(entity, "right_arm_lower");
	destructhitlocpieces(entity, "right_hand");
}

/*
	Name: destructrightlegpieces
	Namespace: destructserverutils
	Checksum: 0x1B82AFF
	Offset: 0xFA0
	Size: 0x6C
	Parameters: 1
	Flags: Linked
*/
function destructrightlegpieces(entity)
{
	destructhitlocpieces(entity, "right_leg_upper");
	destructhitlocpieces(entity, "right_leg_lower");
	destructhitlocpieces(entity, "right_foot");
}

/*
	Name: getpiececount
	Namespace: destructserverutils
	Checksum: 0xDAF05B87
	Offset: 0x1018
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function getpiececount(entity)
{
	if(isdefined(entity.destructibledef))
	{
		destructbundle = _getdestructibledef(entity);
		if(isdefined(destructbundle))
		{
			return destructbundle.piececount;
		}
	}
	return 0;
}

/*
	Name: handledamage
	Namespace: destructserverutils
	Checksum: 0x56E629C8
	Offset: 0x1078
	Size: 0x138
	Parameters: 12
	Flags: Linked
*/
function handledamage(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, psoffsettime, var_a9e3f040, modelindex)
{
	entity = self;
	if(isdefined(entity.skipdeath) && entity.skipdeath)
	{
		return idamage;
	}
	togglespawngibs(entity, 1);
	destructhitlocpieces(entity, shitloc);
	if(isdefined(var_a9e3f040))
	{
		bonename = var_a9e3f040;
		if(!isstring(var_a9e3f040))
		{
			bonename = getpartname(entity, var_a9e3f040);
		}
		if(isdefined(bonename))
		{
			function_629a8d54(entity, bonename);
		}
	}
	return idamage;
}

/*
	Name: function_9885f550
	Namespace: destructserverutils
	Checksum: 0xEA502B01
	Offset: 0x11B8
	Size: 0xB4
	Parameters: 3
	Flags: Linked
*/
function function_9885f550(entity, hitloc, var_a9e3f040)
{
	togglespawngibs(entity, 1);
	destructhitlocpieces(entity, hitloc);
	if(isdefined(var_a9e3f040))
	{
		bonename = var_a9e3f040;
		if(!isstring(var_a9e3f040))
		{
			bonename = getpartname(entity, var_a9e3f040);
		}
		if(isdefined(bonename))
		{
			function_629a8d54(entity, bonename);
		}
	}
}

/*
	Name: isdestructed
	Namespace: destructserverutils
	Checksum: 0x517DB03
	Offset: 0x1278
	Size: 0x6E
	Parameters: 2
	Flags: Linked
*/
function isdestructed(entity, piecenumber)
{
	/#
		/#
			assert(1 <= piecenumber && piecenumber <= 20);
		#/
	#/
	return function_b9568365(entity) & (1 << piecenumber);
}

/*
	Name: reapplydestructedpieces
	Namespace: destructserverutils
	Checksum: 0x48816865
	Offset: 0x12F0
	Size: 0x18E
	Parameters: 1
	Flags: Linked
*/
function reapplydestructedpieces(entity)
{
	if(!isdefined(entity.destructibledef))
	{
		return;
	}
	destructbundle = _getdestructibledef(entity);
	for(index = 1; index <= destructbundle.pieces.size; index++)
	{
		if(!isdestructed(entity, index))
		{
			continue;
		}
		piece = destructbundle.pieces[index - 1];
		if(isdefined(piece.hidetag) && entity haspart(piece.hidetag))
		{
			entity hidepart(piece.hidetag);
		}
		if(isdefined(piece.detachmodel))
		{
			detachtag = "";
			if(isdefined(piece.detachtag))
			{
				detachtag = piece.detachtag;
			}
			if(entity isattached(piece.detachmodel, detachtag))
			{
				entity detach(piece.detachmodel, detachtag);
			}
		}
	}
}

/*
	Name: showdestructedpieces
	Namespace: destructserverutils
	Checksum: 0x5AC18BF7
	Offset: 0x1488
	Size: 0xDE
	Parameters: 1
	Flags: Linked
*/
function showdestructedpieces(entity)
{
	if(!isdefined(entity.destructibledef))
	{
		return;
	}
	destructbundle = _getdestructibledef(entity);
	for(index = 1; index <= destructbundle.pieces.size; index++)
	{
		piece = destructbundle.pieces[index - 1];
		if(isdefined(piece.hidetag) && entity haspart(piece.hidetag))
		{
			entity showpart(piece.hidetag);
		}
	}
}

/*
	Name: togglespawngibs
	Namespace: destructserverutils
	Checksum: 0xB2E9AB0B
	Offset: 0x1570
	Size: 0x94
	Parameters: 2
	Flags: Linked
*/
function togglespawngibs(entity, shouldspawngibs)
{
	if(shouldspawngibs)
	{
		entity._destruct_state = function_b9568365(entity) | 1;
	}
	else
	{
		entity._destruct_state = function_b9568365(entity) & -2;
	}
	entity clientfield::set("destructible_character_state", entity._destruct_state);
}

