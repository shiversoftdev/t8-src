// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\clientfield_shared.csc;
#using script_63fbdc46fe0ddab1;

#namespace zm_red_util;

/*
	Name: init
	Namespace: zm_red_util
	Checksum: 0x26C1E05C
	Offset: 0xD0
	Size: 0x7E
	Parameters: 0
	Flags: Linked
*/
function init()
{
	clientfield::register("toplayer", "zm_red_timer", 16000, getminbitcountfornum(120), "int", &function_bb753058, 0, 1);
	level.var_d0d80ff8 = zm_red_challenges_hud::register("zm_red_challenges_hud");
}

/*
	Name: function_bb753058
	Namespace: zm_red_util
	Checksum: 0xD528E481
	Offset: 0x158
	Size: 0x124
	Parameters: 7
	Flags: Linked, Private
*/
function private function_bb753058(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!function_65b9eb0f(localclientnum))
	{
		timer_model = function_c8b7588d(localclientnum);
		end_time = undefined;
		if(!binitialsnap && newval == 0 && isdefined(level.var_79795e1))
		{
			end_time = level.var_79795e1;
		}
		else
		{
			duration_msec = newval * 1000;
			level.var_79795e1 = getservertime(localclientnum, 1) + duration_msec;
			end_time = level.var_79795e1;
		}
		if(isdefined(end_time))
		{
			setuimodelvalue(timer_model, end_time);
		}
	}
}

/*
	Name: function_c8b7588d
	Namespace: zm_red_util
	Checksum: 0xABAD58F4
	Offset: 0x288
	Size: 0x4A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_c8b7588d(localclientnum)
{
	controller_model = getuimodelforcontroller(localclientnum);
	return createuimodel(controller_model, "ZMHud.zmRedChallengeTimer");
}

