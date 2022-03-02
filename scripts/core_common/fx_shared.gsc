// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.gsc;

#namespace fx;

/*
	Name: set_forward_and_up_vectors
	Namespace: fx
	Checksum: 0x4464C63D
	Offset: 0xA8
	Size: 0x86
	Parameters: 0
	Flags: None
*/
function set_forward_and_up_vectors()
{
	self.v[#"up"] = anglestoup(self.v[#"angles"]);
	self.v[#"forward"] = anglestoforward(self.v[#"angles"]);
}

/*
	Name: get
	Namespace: fx
	Checksum: 0x2874A5B6
	Offset: 0x138
	Size: 0x36
	Parameters: 1
	Flags: Linked
*/
function get(fx)
{
	if(isdefined(level._effect[fx]))
	{
		return level._effect[fx];
	}
	return fx;
}

/*
	Name: create_effect
	Namespace: fx
	Checksum: 0xBAF8D44F
	Offset: 0x178
	Size: 0x15E
	Parameters: 2
	Flags: Linked
*/
function create_effect(type, fxid)
{
	ent = undefined;
	if(!isdefined(level.createfxent))
	{
		level.createfxent = [];
	}
	if(type == "exploder")
	{
		ent = spawnstruct();
	}
	else
	{
		if(!isdefined(level._fake_createfx_struct))
		{
			level._fake_createfx_struct = spawnstruct();
		}
		ent = level._fake_createfx_struct;
	}
	level.createfxent[level.createfxent.size] = ent;
	ent.v = [];
	ent.v[#"type"] = type;
	ent.v[#"fxid"] = fxid;
	ent.v[#"angles"] = (0, 0, 0);
	ent.v[#"origin"] = (0, 0, 0);
	ent.drawn = 1;
	return ent;
}

/*
	Name: create_loop_effect
	Namespace: fx
	Checksum: 0xB70EE1BB
	Offset: 0x2E0
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function create_loop_effect(fxid)
{
	ent = create_effect("loopfx", fxid);
	ent.v[#"delay"] = 0.5;
	return ent;
}

/*
	Name: create_oneshot_effect
	Namespace: fx
	Checksum: 0xC6B6A8F1
	Offset: 0x340
	Size: 0x56
	Parameters: 1
	Flags: None
*/
function create_oneshot_effect(fxid)
{
	ent = create_effect("oneshotfx", fxid);
	ent.v[#"delay"] = -15;
	return ent;
}

/*
	Name: play
	Namespace: fx
	Checksum: 0x8A9391BA
	Offset: 0x3A0
	Size: 0x27C
	Parameters: 8
	Flags: Linked
*/
function play(str_fx, v_origin = (0, 0, 0), v_angles = (0, 0, 0), time_to_delete_or_notify, b_link_to_self = 0, str_tag, b_no_cull, b_ignore_pause_world)
{
	self notify(str_fx);
	if(!isdefined(time_to_delete_or_notify) || (!isstring(time_to_delete_or_notify) && !function_7a600918(time_to_delete_or_notify) && time_to_delete_or_notify == -1) && (isdefined(b_link_to_self) && b_link_to_self) && isdefined(str_tag))
	{
		playfxontag(get(str_fx), self, str_tag, b_ignore_pause_world);
		return self;
	}
	if(isdefined(time_to_delete_or_notify))
	{
		m_fx = util::spawn_model("tag_origin", v_origin, v_angles);
		if(isdefined(b_link_to_self) && b_link_to_self)
		{
			if(isdefined(str_tag))
			{
				m_fx linkto(self, str_tag, (0, 0, 0), (0, 0, 0));
			}
			else
			{
				m_fx linkto(self);
			}
		}
		if(isdefined(b_no_cull) && b_no_cull)
		{
			m_fx setforcenocull();
		}
		playfxontag(get(str_fx), m_fx, "tag_origin", b_ignore_pause_world);
		m_fx thread _play_fx_delete(self, time_to_delete_or_notify);
		return m_fx;
	}
	playfx(get(str_fx), v_origin, anglestoforward(v_angles), anglestoup(v_angles), b_ignore_pause_world);
}

/*
	Name: _play_fx_delete
	Namespace: fx
	Checksum: 0x222182DC
	Offset: 0x628
	Size: 0xDC
	Parameters: 2
	Flags: Linked
*/
function _play_fx_delete(ent, time_to_delete_or_notify = -1)
{
	if(isstring(time_to_delete_or_notify) || function_7a600918(time_to_delete_or_notify))
	{
		ent util::waittill_either("death", time_to_delete_or_notify);
	}
	else
	{
		if(time_to_delete_or_notify > 0)
		{
			ent waittilltimeout(time_to_delete_or_notify, #"death");
		}
		else
		{
			ent waittill(#"death");
		}
	}
	if(isdefined(self))
	{
		self delete();
	}
}

