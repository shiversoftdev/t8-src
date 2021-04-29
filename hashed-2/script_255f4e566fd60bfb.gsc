// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_39c61335d85620af;

#namespace namespace_7095eb0c;

/*
	Name: function_2c38e191
	Namespace: namespace_7095eb0c
	Checksum: 0x7A013708
	Offset: 0x70
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_2c38e191(team)
{
	switch(team)
	{
		case "allies":
		{
			if(isdefined(level.var_6e68e2a4))
			{
				plannercommanderutility::function_2974807c(level.var_6e68e2a4);
			}
			break;
		}
		case "axis":
		{
			if(isdefined(level.var_c2ba4b3d))
			{
				plannercommanderutility::function_2974807c(level.var_c2ba4b3d);
			}
			break;
		}
	}
}

/*
	Name: function_a36c087f
	Namespace: namespace_7095eb0c
	Checksum: 0x93CBAE75
	Offset: 0x118
	Size: 0x9A
	Parameters: 1
	Flags: Linked
*/
function function_a36c087f(team)
{
	switch(team)
	{
		case "allies":
		{
			if(isdefined(level.var_6e68e2a4))
			{
				plannercommanderutility::function_b822982(level.var_6e68e2a4);
			}
			break;
		}
		case "axis":
		{
			if(isdefined(level.var_c2ba4b3d))
			{
				plannercommanderutility::function_b822982(level.var_c2ba4b3d);
			}
			break;
		}
	}
}

