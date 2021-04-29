// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\math_shared.csc;

#namespace gfx;

/*
	Name: setstage
	Namespace: gfx
	Checksum: 0x6327B2C3
	Offset: 0x118
	Size: 0x5E0
	Parameters: 8
	Flags: None
*/
function setstage(localclientnum, bundle, filterid, stageprefix, stagelength, accumtime, totalaccumtime, setconstants)
{
	num_consts = getstructfieldorzero(bundle, stageprefix + "num_consts");
	for(constidx = 0; constidx < num_consts; constidx++)
	{
		constprefix = stageprefix + "c";
		if(constidx < 10)
		{
			constprefix = constprefix + "0";
		}
		constprefix = constprefix + constidx + "_";
		startvalue = getshaderconstantvalue(bundle, constprefix, "start", 0);
		endvalue = getshaderconstantvalue(bundle, constprefix, "end", 0);
		delays = getshaderconstantvalue(bundle, constprefix, "delay", 1);
		channels = bundle.(constprefix + "channels");
		iscolor = isstring(channels) && (channels == "color" || channels == "color+alpha");
		animname = bundle.(constprefix + "anm");
		values = [];
		for(i = 0; i < 4; i++)
		{
			values[i] = 0;
		}
		for(chanidx = 0; chanidx < startvalue.size; chanidx++)
		{
			delaytime = int(delays[(iscolor ? 0 : chanidx)] * 1000);
			if(accumtime > delaytime && stagelength > delaytime)
			{
				timeratio = accumtime - delaytime / stagelength - delaytime;
				timeratio = math::clamp(timeratio, 0, 1);
				lerpratio = 0;
				delta = endvalue[chanidx] - startvalue[chanidx];
				switch(animname)
				{
					case "linear":
					{
						lerpratio = timeratio;
						break;
					}
					case "step":
					{
						lerpratio = 1;
						break;
					}
					case "hash_6bfc507c11820d06":
					{
						lerpratio = timeratio * timeratio;
						break;
					}
					case "hash_6debf0d1b5b68767":
					{
						lerpratio = timeratio * -1 * timeratio - 2;
						break;
					}
					case "hash_275b09ce780d184a":
					{
						timeratio = timeratio * 2;
						if(timeratio < 1)
						{
							lerpratio = 0.5 * lerpratio * lerpratio;
						}
						else
						{
							timeratio = timeratio - 1;
							lerpratio = -0.5 * lerpratio * lerpratio - 2 - 1;
						}
						break;
					}
					case "hash_5556c5be08049c8f":
					{
						lerpratio = timeratio;
						break;
					}
					case "hash_a46103968b51983":
					{
						if(timeratio > 0.5)
						{
							lerpratio = 1 - timeratio;
						}
						else
						{
							lerpratio = timeratio;
						}
						break;
					}
					case "sin":
					{
						lerpratio = 0.5 - 0.5 * cos(360 * timeratio);
						break;
					}
					default:
					{
						break;
					}
				}
				lerpratio = math::clamp(lerpratio, 0, 1);
				values[chanidx] = startvalue[chanidx] + lerpratio * delta;
				continue;
			}
			values[chanidx] = startvalue[chanidx];
		}
		[[setconstants]](localclientnum, bundle.(constprefix + "name"), filterid, values);
	}
	stageconstants = [];
	stageconstants[0] = totalaccumtime;
	stageconstants[1] = accumtime;
	stageconstants[2] = stagelength;
	stageconstants[3] = 0;
	[[setconstants]](localclientnum, "scriptvector7", filterid, stageconstants);
}

/*
	Name: getshaderconstantvalue
	Namespace: gfx
	Checksum: 0xD7E121A2
	Offset: 0x700
	Size: 0x4B6
	Parameters: 4
	Flags: None
*/
function getshaderconstantvalue(bundle, constprefix, constname, delay)
{
	channels = bundle.(constprefix + "channels");
	if(delay && isstring(channels) && (channels == "color" || channels == "color+alpha"))
	{
		channels = 1;
	}
	vals = [];
	switch(channels)
	{
		case 1:
		case "1":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
			break;
		}
		case 2:
		case "2":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
			vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
			break;
		}
		case 3:
		case "3":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
			vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
			vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_z");
			break;
		}
		case 4:
		case "4":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_x");
			vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_y");
			vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_z");
			vals[3] = getstructfieldorzero(bundle, constprefix + constname + "_w");
			break;
		}
		case "color":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_clr_r");
			vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_clr_g");
			vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_clr_b");
			break;
		}
		case "color+alpha":
		{
			vals[0] = getstructfieldorzero(bundle, constprefix + constname + "_clr_r");
			vals[1] = getstructfieldorzero(bundle, constprefix + constname + "_clr_g");
			vals[2] = getstructfieldorzero(bundle, constprefix + constname + "_clr_b");
			vals[3] = getstructfieldorzero(bundle, constprefix + constname + "_clr_a");
			break;
		}
	}
	return vals;
}

/*
	Name: getstructfieldorzero
	Namespace: gfx
	Checksum: 0xAEB8434
	Offset: 0xBC0
	Size: 0x3E
	Parameters: 2
	Flags: None
*/
function getstructfieldorzero(bundle, field)
{
	ret = bundle.(field);
	if(!isdefined(ret))
	{
		ret = 0;
	}
	return ret;
}

/*
	Name: getshaderconstantindex
	Namespace: gfx
	Checksum: 0xC3A8B9C1
	Offset: 0xC08
	Size: 0xCE
	Parameters: 1
	Flags: None
*/
function getshaderconstantindex(codeconstname)
{
	switch(codeconstname)
	{
		case "scriptvector0":
		{
			return 0;
		}
		case "scriptvector1":
		{
			return 4;
		}
		case "scriptvector2":
		{
			return 8;
		}
		case "scriptvector3":
		{
			return 12;
		}
		case "scriptvector4":
		{
			return 16;
		}
		case "scriptvector5":
		{
			return 20;
		}
		case "scriptvector6":
		{
			return 24;
		}
		case "scriptvector7":
		{
			return 28;
		}
	}
	return -1;
}

