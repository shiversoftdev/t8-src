// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\callbacks_shared.gsc;
#using scripts\core_common\system_shared.gsc;

#namespace serverfaceanim;

/*
	Name: function_89f2df9
	Namespace: serverfaceanim
	Checksum: 0x91DC1210
	Offset: 0xC0
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"serverfaceanim", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: serverfaceanim
	Checksum: 0xA798255A
	Offset: 0x108
	Size: 0x44
	Parameters: 0
	Flags: None
*/
function __init__()
{
	if(!(isdefined(level._use_faceanim) && level._use_faceanim))
	{
		return;
	}
	callback::on_spawned(&init_serverfaceanim);
}

/*
	Name: init_serverfaceanim
	Namespace: serverfaceanim
	Checksum: 0xE7DF820E
	Offset: 0x158
	Size: 0x1D4
	Parameters: 0
	Flags: None
*/
function init_serverfaceanim()
{
	self.do_face_anims = 1;
	if(!isdefined(level.face_event_handler))
	{
		level.face_event_handler = spawnstruct();
		level.face_event_handler.events = [];
		level.face_event_handler.events[#"death"] = "face_death";
		level.face_event_handler.events[#"hash_70bb20cec150f744"] = "face_alert";
		level.face_event_handler.events[#"bulletwhizby"] = "face_alert";
		level.face_event_handler.events[#"projectile_impact"] = "face_alert";
		level.face_event_handler.events[#"explode"] = "face_alert";
		level.face_event_handler.events[#"alert"] = "face_alert";
		level.face_event_handler.events[#"shoot"] = "face_shoot_single";
		level.face_event_handler.events[#"melee"] = "face_melee";
		level.face_event_handler.events[#"damage"] = "face_pain";
		level thread wait_for_face_event();
	}
}

/*
	Name: wait_for_face_event
	Namespace: serverfaceanim
	Checksum: 0x41D0985E
	Offset: 0x338
	Size: 0xE0
	Parameters: 0
	Flags: None
*/
function wait_for_face_event()
{
	while(true)
	{
		waitresult = undefined;
		waitresult = level waittill(#"face");
		face_notify = waitresult.face_notify;
		ent = waitresult.entity;
		if(isdefined(ent) && isdefined(ent.do_face_anims) && ent.do_face_anims)
		{
			if(isdefined(level.face_event_handler.events[face_notify]))
			{
				ent sendfaceevent(level.face_event_handler.events[face_notify]);
			}
		}
	}
}

