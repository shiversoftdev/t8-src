// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_13ba67412d79c7f;
#using script_151cd5772fe546db;
#using script_2f226180773b89b9;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\zm_common\zm_powerups.csc;

#namespace zstandard;

/*
	Name: main
	Namespace: zstandard
	Checksum: 0xD54553ED
	Offset: 0x1A8
	Size: 0x236
	Parameters: 1
	Flags: Event
*/
event main(eventstruct)
{
	createuimodel(getglobaluimodel(), "ZMHudGlobal.trials.gameStartTime");
	callback::on_localclient_connect(&on_localplayer_connect);
	callback::on_finalize_initialization(&finalize_clientfields);
	level.var_f5682bb8 = zm_arcade_timer::register("zm_arcade_timer");
	level.var_f995ece6 = zm_trial_timer::register("zm_trial_timer");
	level.var_b9f167ba = self_revive_visuals_rush::register("self_revive_visuals_rush");
	level._zombie_gamemodeprecache = &onprecachegametype;
	level._zombie_gamemodemain = &onstartgametype;
	for(i = 0; i < 4; i++)
	{
		clientfield::register("worlduimodel", ("PlayerList.client" + i) + ".playerIsDowned", 1, 1, "int", undefined, 0, 0);
		clientfield::register("worlduimodel", ("PlayerList.client" + i) + ".multiplier_count", 1, 12, "int", undefined, 0, 0);
		clientfield::register("worlduimodel", ("PlayerList.client" + i) + ".multiplier_blink", 1, 1, "int", undefined, 0, 0);
		clientfield::register("worlduimodel", ("PlayerList.client" + i) + ".self_revives", 1, 8, "int", undefined, 0, 0);
	}
}

/*
	Name: finalize_clientfields
	Namespace: zstandard
	Checksum: 0x78BFF701
	Offset: 0x3E8
	Size: 0x9C
	Parameters: 1
	Flags: Private
*/
private function finalize_clientfields(localclientnum)
{
	clientfield::register("toplayer", "zm_trials_timer", 1, getminbitcountfornum(540), "int", &function_bb753058, 0, 1);
	clientfield::register("worlduimodel", "ZMHudGlobal.trials.gameStartTime", 1, 31, "int", undefined, 0, 0);
}

/*
	Name: onprecachegametype
	Namespace: zstandard
	Checksum: 0x80F724D1
	Offset: 0x490
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function onprecachegametype()
{
}

/*
	Name: onstartgametype
	Namespace: zstandard
	Checksum: 0x80F724D1
	Offset: 0x4A0
	Size: 0x4
	Parameters: 0
	Flags: None
*/
function onstartgametype()
{
}

/*
	Name: on_localplayer_connect
	Namespace: zstandard
	Checksum: 0xA23995E7
	Offset: 0x4B0
	Size: 0x44
	Parameters: 1
	Flags: Private
*/
private function on_localplayer_connect(localclientnum)
{
	timer_model = function_c8b7588d(localclientnum);
	setuimodelvalue(timer_model, 0);
}

/*
	Name: function_c8b7588d
	Namespace: zstandard
	Checksum: 0xA93E0768
	Offset: 0x500
	Size: 0x4A
	Parameters: 1
	Flags: Private
*/
private function function_c8b7588d(localclientnum)
{
	controller_model = getuimodelforcontroller(localclientnum);
	return createuimodel(controller_model, "ZMHud.trialsTimer");
}

/*
	Name: function_bb753058
	Namespace: zstandard
	Checksum: 0x662B7CE5
	Offset: 0x558
	Size: 0xC4
	Parameters: 7
	Flags: Private
*/
private function function_bb753058(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	if(!function_65b9eb0f(localclientnum))
	{
		timer_model = function_c8b7588d(localclientnum);
		duration_msec = newval * 1000;
		setuimodelvalue(timer_model, getservertime(localclientnum, 1) + duration_msec);
	}
}

