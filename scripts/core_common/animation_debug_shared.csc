// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\flagsys_shared.csc;

#namespace animation;

/*
	Name: function_c3c9d0e5
	Namespace: animation
	Checksum: 0x5183A476
	Offset: 0x78
	Size: 0x2C6
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_c3c9d0e5()
{
	/#
		setdvar(#"anim_debug", 0);
		setdvar(#"anim_debug_pause", 0);
		while(true)
		{
			b_anim_debug = getdvarint(#"anim_debug", 0) || getdvarint(#"anim_debug_pause", 0);
			if(b_anim_debug && !level flagsys::get(""))
			{
				level flagsys::set("");
				a_players = getlocalplayers();
				foreach(player in a_players)
				{
					var_16f8cca9 = player getlocalclientnumber();
					a_ents = getentarray(var_16f8cca9, "", "");
					foreach(ent in a_ents)
					{
						ent thread anim_info_render_thread(ent.var_6c4bb19.animation, ent.var_6c4bb19.v_origin_or_ent, ent.var_6c4bb19.v_angles_or_tag);
					}
				}
			}
			else if(!b_anim_debug && level flagsys::get(""))
			{
				level notify(#"kill_anim_debug");
				level flagsys::clear("");
			}
			waitframe(1);
		}
	#/
}

/*
	Name: anim_info_render_thread
	Namespace: animation
	Checksum: 0xBC31E13
	Offset: 0x348
	Size: 0x526
	Parameters: 3
	Flags: None
*/
function anim_info_render_thread(animation, v_origin_or_ent, v_angles_or_tag)
{
	/#
		self notify(#"_anim_info_render_thread_");
		self endon(#"_anim_info_render_thread_", #"death", #"scriptedanim");
		level endon(#"kill_anim_debug");
		while(true)
		{
			level flagsys::wait_till("");
			_init_frame();
			str_extra_info = "";
			color = (0, 1, 1);
			if(flagsys::get(#"firstframe"))
			{
				str_extra_info = str_extra_info + "";
			}
			var_958054e5 = getanimlength(animation);
			var_f667af2f = self getanimtime(animation) * var_958054e5;
			str_extra_info = str_extra_info + (((("" + var_f667af2f) + "") + var_958054e5) + "");
			s_pos = _get_align_pos(v_origin_or_ent, v_angles_or_tag);
			self anim_origin_render(s_pos.origin, s_pos.angles);
			line(self.origin, s_pos.origin, color, 0.5, 1);
			sphere(s_pos.origin, 2, vectorscale((1, 1, 1), 0.3), 0.5, 1);
			if(!isvec(v_origin_or_ent) && (v_origin_or_ent != self && v_origin_or_ent != level))
			{
				str_name = "";
				if(isdefined(v_origin_or_ent.animname))
				{
					str_name = v_origin_or_ent.animname;
				}
				else if(isdefined(v_origin_or_ent.targetname))
				{
					str_name = v_origin_or_ent.targetname;
				}
				print3d(v_origin_or_ent.origin + vectorscale((0, 0, 1), 5), str_name, vectorscale((1, 1, 1), 0.3), 1, 0.15);
			}
			self anim_origin_render(self.origin, self.angles);
			str_name = "";
			if(isdefined(self.anim_debug_name))
			{
				str_name = self.anim_debug_name;
			}
			else if(isdefined(self.animname))
			{
				str_name = self.animname;
			}
			else if(isdefined(self.targetname))
			{
				str_name = self.targetname;
			}
			print3d(self.origin, ((self getentnum() + get_ent_type()) + "") + str_name, color, 0.8, 0.3);
			print3d(self.origin - vectorscale((0, 0, 1), 5), "" + function_9e72a96(animation), color, 0.8, 0.3);
			print3d(self.origin - vectorscale((0, 0, 1), 7), str_extra_info, color, 0.8, 0.15);
			render_tag("", "");
			render_tag("", "");
			render_tag("", "");
			render_tag("", "");
			_reset_frame();
			waitframe(1);
		}
	#/
}

/*
	Name: get_ent_type
	Namespace: animation
	Checksum: 0x9A87F946
	Offset: 0x878
	Size: 0x70
	Parameters: 0
	Flags: None
*/
function get_ent_type()
{
	/#
		return ("" + (isdefined((isdefined(self.classname) ? self.classname : self.type)) ? "" + (isdefined(self.classname) ? self.classname : self.type) : "")) + "";
	#/
}

/*
	Name: _init_frame
	Namespace: animation
	Checksum: 0x8D2C6AC7
	Offset: 0x8F8
	Size: 0x8
	Parameters: 0
	Flags: None
*/
function _init_frame()
{
	/#
	#/
}

/*
	Name: _reset_frame
	Namespace: animation
	Checksum: 0x261CA61D
	Offset: 0x908
	Size: 0x12
	Parameters: 0
	Flags: None
*/
function _reset_frame()
{
	/#
		self.v_centroid = undefined;
	#/
}

/*
	Name: render_tag
	Namespace: animation
	Checksum: 0x89257FA2
	Offset: 0x928
	Size: 0xCC
	Parameters: 2
	Flags: None
*/
function render_tag(str_tag, str_label)
{
	/#
		if(!isdefined(str_label))
		{
			str_label = str_tag;
		}
		v_tag_org = self gettagorigin(str_tag);
		if(isdefined(v_tag_org))
		{
			v_tag_ang = self gettagangles(str_tag);
			anim_origin_render(v_tag_org, v_tag_ang, 2, str_label);
			if(isdefined(self.v_centroid))
			{
				line(self.v_centroid, v_tag_org, vectorscale((1, 1, 1), 0.3), 0.5, 1);
			}
		}
	#/
}

/*
	Name: anim_origin_render
	Namespace: animation
	Checksum: 0x77D3E336
	Offset: 0xA00
	Size: 0x174
	Parameters: 4
	Flags: None
*/
function anim_origin_render(org, angles, line_length, str_label)
{
	/#
		if(!isdefined(line_length))
		{
			line_length = 6;
		}
		if(isdefined(org) && isdefined(angles))
		{
			originendpoint = org + vectorscale(anglestoforward(angles), line_length);
			originrightpoint = org + (vectorscale(anglestoright(angles), -1 * line_length));
			originuppoint = org + vectorscale(anglestoup(angles), line_length);
			line(org, originendpoint, (1, 0, 0));
			line(org, originrightpoint, (0, 1, 0));
			line(org, originuppoint, (0, 0, 1));
			if(isdefined(str_label))
			{
				print3d(org, str_label, (1, 0.7529412, 0.7960784), 1, 0.05);
			}
		}
	#/
}

