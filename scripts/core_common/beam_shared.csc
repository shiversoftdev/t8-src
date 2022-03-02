// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\util_shared.csc;

#namespace beam;

/*
	Name: launch
	Namespace: beam
	Checksum: 0x50537FBA
	Offset: 0x78
	Size: 0x1E0
	Parameters: 6
	Flags: Linked
*/
function launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type, var_ee0708f0)
{
	s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
	if(!isdefined(s_beam))
	{
		s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
	}
	if(self == level)
	{
		if(isdefined(level.localplayers))
		{
			foreach(player in level.localplayers)
			{
				if(isdefined(player))
				{
					beam_id = player launch(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
					if(!(isdefined(var_ee0708f0) && var_ee0708f0))
					{
						return beam_id;
					}
				}
			}
		}
	}
	else if(isdefined(s_beam))
	{
		s_beam.beam_id = beamlaunch(self.localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
		self thread _kill_on_ent_death(self.localclientnum, s_beam, ent_1, ent_2);
		return s_beam.beam_id;
	}
}

/*
	Name: function_cfb2f62a
	Namespace: beam
	Checksum: 0x5967648B
	Offset: 0x260
	Size: 0x104
	Parameters: 6
	Flags: Linked
*/
function function_cfb2f62a(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type)
{
	s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
	if(!isdefined(s_beam))
	{
		s_beam = _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
	}
	if(isdefined(s_beam))
	{
		s_beam.beam_id = beamlaunch(localclientnum, ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
		self thread _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2);
		return s_beam.beam_id;
	}
	return -1;
}

/*
	Name: kill
	Namespace: beam
	Checksum: 0xA909822
	Offset: 0x370
	Size: 0x17C
	Parameters: 5
	Flags: Linked
*/
function kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type)
{
	if(isdefined(self.active_beams))
	{
		s_beam = _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
		arrayremovevalue(self.active_beams, s_beam, 0);
	}
	if(self == level)
	{
		if(isdefined(level.localplayers))
		{
			foreach(player in level.localplayers)
			{
				if(isdefined(player))
				{
					player kill(ent_1, str_tag1, ent_2, str_tag2, str_beam_type);
				}
			}
		}
	}
	else if(isdefined(s_beam))
	{
		s_beam notify(#"kill");
		beamkill(self.localclientnum, s_beam.beam_id);
	}
}

/*
	Name: function_47deed80
	Namespace: beam
	Checksum: 0x7F600D1C
	Offset: 0x4F8
	Size: 0x9C
	Parameters: 2
	Flags: None
*/
function function_47deed80(localclientnum, beam_id)
{
	if(isdefined(level.active_beams))
	{
		s_beam = function_1c0feeb0(beam_id);
		arrayremovevalue(level.active_beams, s_beam, 0);
	}
	if(isdefined(s_beam))
	{
		s_beam notify(#"kill");
		beamkill(localclientnum, s_beam.beam_id);
	}
}

/*
	Name: _new_beam
	Namespace: beam
	Checksum: 0x479C43DE
	Offset: 0x5A0
	Size: 0x122
	Parameters: 5
	Flags: Linked, Private
*/
function private _new_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type)
{
	if(!isdefined(self.active_beams))
	{
		self.active_beams = [];
	}
	s_beam = spawnstruct();
	s_beam.ent_1 = ent_1;
	s_beam.str_tag1 = str_tag1;
	s_beam.ent_2 = ent_2;
	s_beam.str_tag2 = str_tag2;
	s_beam.str_beam_type = str_beam_type;
	if(!isdefined(self.active_beams))
	{
		self.active_beams = [];
	}
	else if(!isarray(self.active_beams))
	{
		self.active_beams = array(self.active_beams);
	}
	self.active_beams[self.active_beams.size] = s_beam;
	return s_beam;
}

/*
	Name: _get_beam
	Namespace: beam
	Checksum: 0x2B51E00F
	Offset: 0x6D0
	Size: 0x110
	Parameters: 5
	Flags: Linked, Private
*/
function private _get_beam(ent_1, str_tag1, ent_2, str_tag2, str_beam_type)
{
	if(isdefined(self.active_beams))
	{
		foreach(s_beam in self.active_beams)
		{
			if(s_beam.ent_1 === ent_1 && s_beam.str_tag1 === str_tag1 && s_beam.ent_2 === ent_2 && s_beam.str_tag2 === str_tag2 && s_beam.str_beam_type === str_beam_type)
			{
				return s_beam;
			}
		}
	}
}

/*
	Name: function_1c0feeb0
	Namespace: beam
	Checksum: 0x80EF9F88
	Offset: 0x7E8
	Size: 0x9A
	Parameters: 1
	Flags: Linked, Private
*/
function private function_1c0feeb0(beam_id)
{
	if(isdefined(level.active_beams))
	{
		foreach(s_beam in level.active_beams)
		{
			if(s_beam.beam_id === beam_id)
			{
				return s_beam;
			}
		}
	}
}

/*
	Name: _kill_on_ent_death
	Namespace: beam
	Checksum: 0xAF573AC1
	Offset: 0x890
	Size: 0xAC
	Parameters: 4
	Flags: Linked, Private
*/
function private _kill_on_ent_death(localclientnum, s_beam, ent_1, ent_2)
{
	s_beam endon(#"kill");
	util::waittill_any_ents(ent_1, "death", ent_2, "death");
	if(isdefined(self))
	{
		arrayremovevalue(self.active_beams, s_beam, 0);
		beamkill(localclientnum, s_beam.beam_id);
	}
}

