// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\status_effects\status_effect_util.gsc;
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\clientfield_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace status_effect_pulse;

/*
	Name: __init__system__
	Namespace: status_effect_pulse
	Checksum: 0xC71AFA0F
	Offset: 0xD0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec __init__system__()
{
	system::register(#"status_effect_pulse", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: status_effect_pulse
	Checksum: 0xAE49137E
	Offset: 0x118
	Size: 0xBC
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	status_effect::register_status_effect_callback_apply(9, &pulse_apply);
	status_effect::function_5bae5120(9, &pulse_end);
	status_effect::function_6f4eaf88(getstatuseffect("pulse"));
	clientfield::register("toplayer", "pulsed", 1, 1, "int");
	callback::on_spawned(&on_player_spawned);
}

/*
	Name: on_player_spawned
	Namespace: status_effect_pulse
	Checksum: 0x80F724D1
	Offset: 0x1E0
	Size: 0x4
	Parameters: 0
	Flags: Linked
*/
function on_player_spawned()
{
}

/*
	Name: pulse_apply
	Namespace: status_effect_pulse
	Checksum: 0x948A8DA8
	Offset: 0x1F0
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function pulse_apply(var_756fda07, weapon, var_84171a6c)
{
	self.owner clientfield::set_to_player("pulsed", 1);
	shutdownpulserebootindicatormenu();
	pulserebootmenu = self.owner openluimenu("EmpRebootIndicator");
	self.owner setluimenudata(pulserebootmenu, #"endtime", int(self.endtime));
	self.owner setluimenudata(pulserebootmenu, #"starttime", int(self.endtime - self.duration));
	self thread pulse_rumble_loop(0.75);
	self.owner setempjammed(1);
}

/*
	Name: pulse_rumble_loop
	Namespace: status_effect_pulse
	Checksum: 0xCBB2537F
	Offset: 0x350
	Size: 0xAE
	Parameters: 1
	Flags: Linked, Private
*/
function private pulse_rumble_loop(duration)
{
	self endon(#"pulse_rumble_loop");
	self notify(#"pulse_rumble_loop");
	self endon(#"endstatuseffect");
	goaltime = gettime() + (int(duration * 1000));
	while(gettime() < goaltime)
	{
		self.owner playrumbleonentity("damage_heavy");
		waitframe(1);
	}
}

/*
	Name: pulse_end
	Namespace: status_effect_pulse
	Checksum: 0x3E550D39
	Offset: 0x408
	Size: 0x8C
	Parameters: 0
	Flags: Linked
*/
function pulse_end()
{
	if(isdefined(self))
	{
		shutdownpulserebootindicatormenu();
		if(isdefined(level.emp_shared.enemyempactivefunc))
		{
			if(self [[level.emp_shared.enemyempactivefunc]]())
			{
				return;
			}
		}
		self.owner setempjammed(0);
		self.owner clientfield::set_to_player("pulsed", 0);
	}
}

/*
	Name: shutdownpulserebootindicatormenu
	Namespace: status_effect_pulse
	Checksum: 0xF3B97D0F
	Offset: 0x4A0
	Size: 0x54
	Parameters: 0
	Flags: Linked
*/
function shutdownpulserebootindicatormenu()
{
	emprebootmenu = self.owner getluimenu("EmpRebootIndicator");
	if(isdefined(emprebootmenu))
	{
		self.owner closeluimenu(emprebootmenu);
	}
}

