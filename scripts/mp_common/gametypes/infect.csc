// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_4029012c9af5b12a;
#using script_5978de81803f618a;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\renderoverridebundle.csc;
#using scripts\core_common\struct.csc;

#namespace infect;

/*
	Name: main
	Namespace: infect
	Checksum: 0x94B6240B
	Offset: 0xD8
	Size: 0x74
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	level.var_13361577 = mp_infect_timer::register("InfectTimer");
	clientfield::register("allplayers", "Infected.player_infected", 15000, 1, "int", &function_fd78da38, 0, 0);
}

/*
	Name: function_fd78da38
	Namespace: infect
	Checksum: 0xC07F80A
	Offset: 0x158
	Size: 0x1FC
	Parameters: 7
	Flags: None
*/
function function_fd78da38(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump)
{
	if(newval == 1)
	{
		if(self getlocalclientnumber() === localclientnum)
		{
			foreach(player in getplayers(localclientnum))
			{
				if(player.team !== self.team && !player function_21c0fa55())
				{
					if(player flag::exists(#"friendly"))
					{
						player renderoverridebundle::function_40d0d1e0(#"friendly", (sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9"), 0);
					}
				}
			}
		}
		else if(self flag::exists(#"friendly"))
		{
			self renderoverridebundle::function_40d0d1e0(#"friendly", (sessionmodeiscampaigngame() ? #"hash_1cbf6d26721c59a7" : #"hash_1c90592671f4c6e9"), 0);
		}
	}
}

/*
	Name: onprecachegametype
	Namespace: infect
	Checksum: 0x80F724D1
	Offset: 0x360
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function onprecachegametype()
{
}

/*
	Name: onstartgametype
	Namespace: infect
	Checksum: 0x80F724D1
	Offset: 0x370
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
}

