// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace namespace_fc4416da;

/*
	Name: function_3981d015
	Namespace: namespace_fc4416da
	Checksum: 0x47A33732
	Offset: 0x100
	Size: 0x1D4
	Parameters: 1
	Flags: Event
*/
event function_3981d015(eventstruct)
{
	dynent = eventstruct.ent;
	if(isdefined(dynent))
	{
		if(dynent.targetname === "spring_event_homunculus" || dynent.targetname === "zombie_apoc_homunculus")
		{
			localclientnum = eventstruct.localclientnum;
			if(isdefined(localclientnum))
			{
				if(eventstruct.state === 1)
				{
					level thread function_5aaf5515(localclientnum, dynent);
				}
				else if(eventstruct.state === 3)
				{
					if(dynent.targetname == "spring_event_homunculus")
					{
						playfx(localclientnum, "player/fx8_plyr_emote_homunc_green_end", dynent.origin + vectorscale((0, 0, 1), 40), anglestoforward(dynent.angles));
					}
					else if(dynent.targetname == "zombie_apoc_homunculus")
					{
						playfx(localclientnum, "player/fx8_plyr_emote_homunc_end", dynent.origin + vectorscale((0, 0, 1), 40), anglestoforward(dynent.angles));
					}
					if(isdefined(dynent.var_46e47933))
					{
						stopsound(dynent.var_46e47933);
					}
				}
			}
		}
	}
}

/*
	Name: function_5aaf5515
	Namespace: namespace_fc4416da
	Checksum: 0x7BD53231
	Offset: 0x2E0
	Size: 0xB4
	Parameters: 2
	Flags: Linked
*/
function function_5aaf5515(localclientnum, dynent)
{
	dynent notify(#"hash_178cf342d49af85f");
	dynent endon(#"hash_178cf342d49af85f");
	while(isdefined(dynent) & function_8a8a409b(dynent) && function_ffdbe8c2(dynent) !== 2)
	{
		dynent.var_46e47933 = playsound(localclientnum, "mus_homunculus_dance", dynent.origin);
		wait(7.5);
	}
}

