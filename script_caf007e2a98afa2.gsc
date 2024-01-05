// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace animationstatenetworkutility;

/*
	Name: requeststate
	Namespace: animationstatenetworkutility
	Checksum: 0xDB88AAB9
	Offset: 0x68
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function requeststate(entity, statename)
{
	/#
		assert(isdefined(entity));
	#/
	entity asmrequestsubstate(statename);
}

/*
	Name: searchanimationmap
	Namespace: animationstatenetworkutility
	Checksum: 0xCCC38065
	Offset: 0xB8
	Size: 0x4C
	Parameters: 2
	Flags: Linked
*/
function searchanimationmap(entity, aliasname)
{
	if(isdefined(entity) && isdefined(aliasname))
	{
		animationname = entity animmappingsearch(aliasname);
		return animationname;
	}
}

