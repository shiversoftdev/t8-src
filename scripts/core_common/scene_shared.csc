// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using script_64914218f744517b;
#using scripts\core_common\animation_shared.csc;
#using scripts\core_common\array_shared.csc;
#using scripts\core_common\callbacks_shared.csc;
#using scripts\core_common\clientfield_shared.csc;
#using scripts\core_common\filter_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\lui_shared.csc;
#using scripts\core_common\postfx_shared.csc;
#using scripts\core_common\scene_debug_shared.csc;
#using scripts\core_common\scene_shared.csc;
#using scripts\core_common\scriptbundle_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\system_shared.csc;
#using scripts\core_common\util_shared.csc;

#namespace scene;

/*
	Name: player_scene_animation_skip
	Namespace: scene
	Checksum: 0xCBDEAC87
	Offset: 0x6F8
	Size: 0x11C
	Parameters: 7
	Flags: Linked
*/
function player_scene_animation_skip(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	anim_name = self getcurrentanimscriptedname();
	if(isdefined(anim_name) && anim_name != "")
	{
		if(!isanimlooping(localclientnum, anim_name))
		{
			/#
				if(getdvarint(#"debug_scene_skip", 0) > 0)
				{
					printtoprightln("" + anim_name + "" + gettime(), vectorscale((1, 1, 1), 0.6));
				}
			#/
			self setanimtimebyname(anim_name, 1, 1);
		}
	}
}

/*
	Name: player_scene_skip_completed
	Namespace: scene
	Checksum: 0xE4829CFB
	Offset: 0x820
	Size: 0x94
	Parameters: 7
	Flags: Linked
*/
function player_scene_skip_completed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	flushsubtitles(localclientnum);
	setdvar(#"r_graphiccontentblur", 0);
	setdvar(#"r_makedark_enable", 0);
}

#namespace csceneplayer;

/*
	Name: initialize
	Namespace: csceneplayer
	Checksum: 0x57694AF9
	Offset: 0x8C0
	Size: 0xC4
	Parameters: 0
	Flags: Linked
*/
function initialize()
{
	flagsys::clear(#"ready");
	flagsys::clear(#"done");
	flagsys::clear(#"main_done");
	self notify(#"new_state");
	self endon(#"new_state");
	self notify(#"init");
	waittillframeend();
	if(isdefined(self._n_clientnum))
	{
		_spawn(self._n_clientnum);
	}
}

/*
	Name: _spawn
	Namespace: csceneplayer
	Checksum: 0x9AECE918
	Offset: 0x990
	Size: 0x6C
	Parameters: 2
	Flags: Linked
*/
function _spawn(clientnum, b_hide = 1)
{
	self._e_array[clientnum] = function_5c10bd79(clientnum);
	flagsys::set(#"ready");
}

/*
	Name: function_35a524cf
	Namespace: csceneplayer
	Checksum: 0xEFE5E5B3
	Offset: 0xA08
	Size: 0x2B0
	Parameters: 3
	Flags: Linked
*/
function function_35a524cf(clientnum, animation, n_start_time = 0)
{
	var_8395d6f1 = (isdefined(self._s.lerptime) ? self._s.lerptime : 0);
	align = csceneobject::get_align_ent(clientnum);
	tag = csceneobject::get_align_tag();
	if(align == level)
	{
		v_pos = (0, 0, 0);
		v_ang = (0, 0, 0);
	}
	else if(isstring(tag))
	{
		/#
			assert(isdefined(align.model), "" + animation + "" + tag + "");
		#/
		v_pos = align gettagorigin(tag);
		v_ang = align gettagangles(tag);
	}
	else
	{
		v_pos = align.origin;
		v_ang = align.angles;
	}
	var_380af598 = (isdefined(self.var_55b4f21e.var_d2b98fd2) ? self.var_55b4f21e.var_d2b98fd2 : "");
	var_57949b2d = n_start_time * getcamanimtime(animation);
	var_473877de = getservertime(clientnum) - var_57949b2d;
	if(isdefined(self.var_55b4f21e.var_ffc10b65))
	{
		var_94f3822c = getent(clientnum, self.var_55b4f21e.var_ffc10b65, "targetname");
	}
	playmaincamxcam(clientnum, animation, var_8395d6f1, var_380af598, "", v_pos, v_ang, var_94f3822c, undefined, undefined, int(var_473877de));
	[[ self ]]->wait_for_camera(animation, var_57949b2d);
}

/*
	Name: wait_for_camera
	Namespace: csceneplayer
	Checksum: 0xE25CC588
	Offset: 0xCC0
	Size: 0x104
	Parameters: 2
	Flags: Linked
*/
function wait_for_camera(animation, var_57949b2d = 0)
{
	self endon(#"skip_camera_anims");
	flagsys::set(#"camera_playing");
	if(iscamanimlooping(animation))
	{
		self waittill(#"new_state");
	}
	else
	{
		n_cam_time = getcamanimtime(animation) - var_57949b2d;
		self waittill_timeout(float(n_cam_time) / 1000, #"new_state");
	}
	flagsys::clear(#"camera_playing");
}

/*
	Name: __constructor
	Namespace: csceneplayer
	Checksum: 0x3747CC76
	Offset: 0xDD0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 8, 128
*/
function __constructor()
{
	csceneobject::__constructor();
}

/*
	Name: __destructor
	Namespace: csceneplayer
	Checksum: 0x584933ED
	Offset: 0xDF0
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16, 128
*/
function __destructor()
{
	csceneobject::__destructor();
}

#namespace scene;

/*
	Name: csceneplayer
	Namespace: scene
	Checksum: 0x3917AABF
	Offset: 0xE10
	Size: 0x9E6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function csceneplayer()
{
	classes.csceneplayer[0] = spawnstruct();
	classes.csceneplayer[0].__vtable[1839071698] = &cscriptbundleobjectbase::get_ent;
	classes.csceneplayer[0].__vtable[365768300] = &cscriptbundleobjectbase::error;
	classes.csceneplayer[0].__vtable[766440049] = &cscriptbundleobjectbase::log;
	classes.csceneplayer[0].__vtable[1836838051] = &cscriptbundleobjectbase::init;
	classes.csceneplayer[0].__vtable[913321084] = &cscriptbundleobjectbase::__destructor;
	classes.csceneplayer[0].__vtable[674154906] = &cscriptbundleobjectbase::__constructor;
	classes.csceneplayer[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.csceneplayer[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.csceneplayer[0].__vtable[1343842804] = &csceneobject::has_init_state;
	classes.csceneplayer[0].__vtable[1582596] = &csceneobject::wait_till_shot_ready;
	classes.csceneplayer[0].__vtable[1411803940] = &csceneobject::function_54266b24;
	classes.csceneplayer[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.csceneplayer[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.csceneplayer[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.csceneplayer[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.csceneplayer[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.csceneplayer[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.csceneplayer[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.csceneplayer[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.csceneplayer[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.csceneplayer[0].__vtable[921351730] = &csceneobject::get_name;
	classes.csceneplayer[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.csceneplayer[0].__vtable[2085193114] = &csceneobject::scene;
	classes.csceneplayer[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.csceneplayer[0].__vtable[1544229797] = &csceneobject::finish_per_client;
	classes.csceneplayer[0].__vtable[693640918] = &csceneobject::finish;
	classes.csceneplayer[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.csceneplayer[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.csceneplayer[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.csceneplayer[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.csceneplayer[0].__vtable[1548900053] = &csceneobject::play_per_client;
	classes.csceneplayer[0].__vtable[881215179] = &csceneobject::play;
	classes.csceneplayer[0].__vtable[1970232926] = &csceneobject::initialize_per_client;
	classes.csceneplayer[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.csceneplayer[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.csceneplayer[0].__vtable[308479578] = &csceneobject::function_1263065a;
	classes.csceneplayer[0].__vtable[593821111] = &csceneobject::function_dc9b0249;
	classes.csceneplayer[0].__vtable[1051055431] = &csceneobject::get_entry;
	classes.csceneplayer[0].__vtable[1907386484] = &csceneobject::function_71b06874;
	classes.csceneplayer[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.csceneplayer[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.csceneplayer[0].__vtable[1128083910] = &csceneobject::initialize;
	classes.csceneplayer[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.csceneplayer[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.csceneplayer[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.csceneplayer[0].__vtable[674154906] = &csceneobject::__constructor;
	classes.csceneplayer[0].__vtable[913321084] = &csceneplayer::__destructor;
	classes.csceneplayer[0].__vtable[674154906] = &csceneplayer::__constructor;
	classes.csceneplayer[0].__vtable[1569471078] = &csceneplayer::wait_for_camera;
	classes.csceneplayer[0].__vtable[900015311] = &csceneplayer::function_35a524cf;
	classes.csceneplayer[0].__vtable[362767597] = &csceneplayer::_spawn;
	classes.csceneplayer[0].__vtable[1128083910] = &csceneplayer::initialize;
}

#namespace csceneobject;

/*
	Name: __constructor
	Namespace: csceneobject
	Checksum: 0x89663C2E
	Offset: 0x1800
	Size: 0x42
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	cscriptbundleobjectbase::__constructor();
	self._b_spawnonce_used = 0;
	self._is_valid = 1;
	self._b_first_frame = 0;
	self._n_blend = 0;
}

/*
	Name: __destructor
	Namespace: csceneobject
	Checksum: 0x816AD5C4
	Offset: 0x1850
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
	cscriptbundleobjectbase::__destructor();
}

/*
	Name: first_init
	Namespace: csceneobject
	Checksum: 0xA797C675
	Offset: 0x1870
	Size: 0x56
	Parameters: 4
	Flags: Linked
*/
function first_init(s_objdef, o_scene, e_ent, localclientnum)
{
	cscriptbundleobjectbase::init(s_objdef, o_scene, e_ent, localclientnum);
	_assign_unique_name();
	return self;
}

/*
	Name: restore_saved_ent
	Namespace: csceneobject
	Checksum: 0x1261AD37
	Offset: 0x18D0
	Size: 0xC6
	Parameters: 1
	Flags: Linked
*/
function restore_saved_ent(clientnum)
{
	if(isdefined(self._o_scene._e_root) && isdefined(self._o_scene._e_root.scene_ents) && isdefined(self._o_scene._e_root.scene_ents[clientnum]))
	{
		if(isdefined(self._o_scene._e_root.scene_ents[clientnum][self._str_name]))
		{
			self._e_array[clientnum] = self._o_scene._e_root.scene_ents[clientnum][self._str_name];
		}
	}
}

/*
	Name: initialize
	Namespace: csceneobject
	Checksum: 0x9403942E
	Offset: 0x19A0
	Size: 0x374
	Parameters: 0
	Flags: Linked
*/
function initialize()
{
	flagsys::clear(#"ready");
	flagsys::clear(#"done");
	flagsys::clear(#"main_done");
	self notify(#"new_state");
	self endon(#"new_state");
	self notify(#"init");
	waittillframeend();
	self._str_shot = scene::function_de6a7579(self._o_scene._str_name, "init", self._o_scene._e_root);
	self.var_55b4f21e = function_730a4c60(self._str_shot);
	cscriptbundleobjectbase::error(!isdefined(self.var_55b4f21e), "Shot struct is not defined for this object. Check and make sure that \"" + self._str_shot + "\" is a valid shot name for this scene bundle");
	if(isdefined(self._n_clientnum))
	{
		_spawn(self._n_clientnum, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
	}
	else
	{
		_spawn(0, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
		var_2d560016 = getmaxlocalclients();
		for(clientnum = 1; clientnum < var_2d560016; clientnum++)
		{
			if(isdefined(function_5c10bd79(clientnum)))
			{
				_spawn(clientnum, isdefined(self._s.firstframe) && self._s.firstframe || isdefined(self._s.initanim) || isdefined(self._s.initanimloop));
			}
		}
	}
	if(isdefined(self._n_clientnum))
	{
		thread initialize_per_client(self._n_clientnum);
	}
	else
	{
		for(clientnum = 1; clientnum < getmaxlocalclients(); clientnum++)
		{
			if(isdefined(function_5c10bd79(clientnum)))
			{
				thread initialize_per_client(clientnum);
			}
		}
		initialize_per_client(0);
	}
}

/*
	Name: get_shot
	Namespace: csceneobject
	Checksum: 0x45CAE61A
	Offset: 0x1D20
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function get_shot(str_shot)
{
	foreach(n_shot, s_shot in self._s.shots)
	{
		if(str_shot === s_shot.name)
		{
			return n_shot;
		}
	}
	return undefined;
}

/*
	Name: function_730a4c60
	Namespace: csceneobject
	Checksum: 0x58381AB5
	Offset: 0x1DB8
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function function_730a4c60(str_shot)
{
	foreach(s_shot in self._s.shots)
	{
		if(str_shot === s_shot.name)
		{
			return s_shot;
		}
	}
	return undefined;
}

/*
	Name: function_71b06874
	Namespace: csceneobject
	Checksum: 0x95784002
	Offset: 0x1E50
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function function_71b06874(n_shot)
{
	if(isdefined(self._s.shots[n_shot].var_51093f2d) && self._s.shots[n_shot].var_51093f2d)
	{
		return 0;
	}
	return 1;
}

/*
	Name: get_entry
	Namespace: csceneobject
	Checksum: 0x1AC1AEBF
	Offset: 0x1EB0
	Size: 0xFE
	Parameters: 3
	Flags: Linked
*/
function get_entry(n_shot = 0, n_entry, str_entry_type)
{
	if(isdefined(self._s.shots[n_shot]) && isdefined(self._s.shots[n_shot].entry) && isdefined(self._s.shots[n_shot].entry[n_entry]))
	{
		if(isdefined(self._s.shots[n_shot].entry[n_entry].(str_entry_type)))
		{
			entry = self._s.shots[n_shot].entry[n_entry].(str_entry_type);
		}
	}
	return entry;
}

/*
	Name: function_dc9b0249
	Namespace: csceneobject
	Checksum: 0xB794EA6F
	Offset: 0x1FB8
	Size: 0x10A
	Parameters: 2
	Flags: Linked
*/
function function_dc9b0249(n_shot = 0, str_entry_type)
{
	if(isdefined(self._s.shots[n_shot]) && isdefined(self._s.shots[n_shot].entry))
	{
		foreach(s_entry in self._s.shots[n_shot].entry)
		{
			if(isdefined(s_entry.(str_entry_type)))
			{
				entry = s_entry.(str_entry_type);
				break;
			}
		}
	}
	return entry;
}

/*
	Name: function_1263065a
	Namespace: csceneobject
	Checksum: 0xFEB224A9
	Offset: 0x20D0
	Size: 0xBA
	Parameters: 1
	Flags: Linked
*/
function function_1263065a(n_shot = 0)
{
	var_5e0d27b8 = [];
	if(isdefined(self._s.shots[n_shot]) && isdefined(self._s.shots[n_shot].entry))
	{
		var_5e0d27b8 = getarraykeys(self._s.shots[n_shot].entry);
		var_5e0d27b8 = array::sort_by_value(var_5e0d27b8, 1);
	}
	return var_5e0d27b8;
}

/*
	Name: run_wait
	Namespace: csceneobject
	Checksum: 0xACD90A9B
	Offset: 0x2198
	Size: 0x5E
	Parameters: 1
	Flags: Linked
*/
function run_wait(wait_time)
{
	wait_start_time = 0;
	while(wait_start_time < wait_time && !is_skipping_scene())
	{
		wait_start_time = wait_start_time + 0.016;
		waitframe(1);
	}
}

/*
	Name: is_skipping_scene
	Namespace: csceneobject
	Checksum: 0x9445DF53
	Offset: 0x2200
	Size: 0x30
	Parameters: 0
	Flags: Linked
*/
function is_skipping_scene()
{
	return isdefined([[ self._o_scene ]]->is_skipping_scene()) && [[ self._o_scene ]]->is_skipping_scene();
}

/*
	Name: initialize_per_client
	Namespace: csceneobject
	Checksum: 0x600B2005
	Offset: 0x2238
	Size: 0x26C
	Parameters: 1
	Flags: Linked
*/
function initialize_per_client(clientnum)
{
	self endon(#"new_state");
	util::waitforclient(clientnum);
	n_shot = get_shot(self._str_shot);
	self._e_array[clientnum] show();
	function_ee94f77(clientnum);
	if(isdefined(self._s.shots) && isdefined(self._s.shots[n_shot]) && isarray(self._s.shots[n_shot].entry))
	{
		foreach(s_entry in self._s.shots[n_shot].entry)
		{
			if(isdefined(s_entry.("anim")))
			{
				var_ad4f5efa = s_entry.("anim");
				if(self._b_first_frame)
				{
					_play_anim(clientnum, var_ad4f5efa, 0, undefined, self._s.mainshot);
					break;
					continue;
				}
				if(isanimlooping(clientnum, var_ad4f5efa))
				{
					thread _play_anim(clientnum, var_ad4f5efa, 1, undefined, self._s.mainshot);
					continue;
				}
				_play_anim(clientnum, var_ad4f5efa, 1, undefined, self._s.mainshot);
			}
		}
	}
	flagsys::set(#"ready");
}

/*
	Name: play
	Namespace: csceneobject
	Checksum: 0x57E120E5
	Offset: 0x24B0
	Size: 0x1FC
	Parameters: 3
	Flags: Linked
*/
function play(str_shot = "play", n_start_time, b_looping = undefined)
{
	flagsys::clear(#"ready");
	flagsys::clear(#"done");
	flagsys::clear(#"main_done");
	self notify(#"new_state");
	self endon(#"new_state");
	self notify(#"play");
	waittillframeend();
	[[ self._o_scene ]]->function_7a1288f1(str_shot);
	self._str_shot = str_shot;
	self.var_55b4f21e = function_730a4c60(self._str_shot);
	cscriptbundleobjectbase::error(!isdefined(self.var_55b4f21e), "Shot struct is not defined for this object. Check and make sure that \"" + self._str_shot + "\" is a valid shot name for this scene bundle");
	if(isdefined(self._n_clientnum))
	{
		play_per_client(self._n_clientnum, n_start_time, b_looping);
	}
	else
	{
		for(clientnum = 1; clientnum < getmaxlocalclients(); clientnum++)
		{
			if(isdefined(function_5c10bd79(clientnum)))
			{
				thread play_per_client(clientnum, n_start_time, b_looping);
			}
		}
		play_per_client(0, n_start_time, b_looping);
	}
}

/*
	Name: play_per_client
	Namespace: csceneobject
	Checksum: 0xEC6A4008
	Offset: 0x26B8
	Size: 0x314
	Parameters: 3
	Flags: Linked
*/
function play_per_client(clientnum, n_start_time, b_looping = undefined)
{
	self endon(#"new_state");
	util::waitforclient(clientnum);
	[[ self ]]->_spawn(clientnum);
	n_shot = get_shot(self._str_shot);
	var_5e0d27b8 = function_1263065a(n_shot);
	function_ee94f77(clientnum);
	var_3f83c458 = array("blend", "cameraswitcher", "anim");
	foreach(str_entry_type in var_3f83c458)
	{
		if(!is_alive(clientnum))
		{
			break;
		}
		foreach(n_entry in var_5e0d27b8)
		{
			entry = get_entry(n_shot, n_entry, str_entry_type);
			if(isdefined(entry))
			{
				switch(str_entry_type)
				{
					case "cameraswitcher":
					{
						thread [[ self ]]->function_35a524cf(clientnum, entry, n_start_time);
						break;
					}
					case "anim":
					{
						_play_anim(clientnum, entry, 1, self._n_blend, self._s.mainshot, b_looping, n_start_time);
						break;
					}
					case "blend":
					{
						self._n_blend = entry;
						break;
					}
					default:
					{
						cscriptbundleobjectbase::error(1, "Bad timeline entry type '" + str_entry_type + "'.");
					}
				}
			}
		}
	}
	function_54266b24();
	thread finish_per_client(clientnum, 0, 1);
}

/*
	Name: function_ee94f77
	Namespace: csceneobject
	Checksum: 0xAE65E076
	Offset: 0x29D8
	Size: 0x44
	Parameters: 1
	Flags: Linked
*/
function function_ee94f77(clientnum)
{
	function_dd4f74e1(clientnum);
	function_587971b6();
	function_ebbbd00d();
}

/*
	Name: function_dd4f74e1
	Namespace: csceneobject
	Checksum: 0xB0F378A9
	Offset: 0x2A28
	Size: 0x86
	Parameters: 1
	Flags: Linked
*/
function function_dd4f74e1(clientnum)
{
	if(isdefined(self._s.firstframe) && self._s.firstframe && self._o_scene._str_mode == "init" && isdefined(self._e_array[clientnum]))
	{
		self._b_first_frame = 1;
	}
	else
	{
		self._b_first_frame = 0;
	}
}

/*
	Name: function_587971b6
	Namespace: csceneobject
	Checksum: 0x3704994A
	Offset: 0x2AB8
	Size: 0x36
	Parameters: 0
	Flags: Linked
*/
function function_587971b6()
{
	self._n_blend = (isdefined(self.var_55b4f21e.blend) ? self.var_55b4f21e.blend : 0);
}

/*
	Name: function_ebbbd00d
	Namespace: csceneobject
	Checksum: 0x3FA10D0
	Offset: 0x2AF8
	Size: 0x11C
	Parameters: 0
	Flags: Linked
*/
function function_ebbbd00d()
{
	if(self._b_first_frame)
	{
		return;
	}
	n_spacer_min = self.var_55b4f21e.spacermin;
	n_spacer_max = self.var_55b4f21e.spacermax;
	if(!is_skipping_scene() && (isdefined(n_spacer_min) || isdefined(n_spacer_max)))
	{
		if(isdefined(n_spacer_min) && isdefined(n_spacer_max))
		{
			if(!cscriptbundleobjectbase::error(n_spacer_min >= n_spacer_max, "Spacer Min value must be less than Spacer Max value!"))
			{
				run_wait(randomfloatrange(n_spacer_min, n_spacer_max));
			}
		}
		else if(isdefined(n_spacer_min))
		{
			run_wait(n_spacer_min);
		}
		else if(isdefined(n_spacer_max))
		{
			run_wait(n_spacer_max);
		}
	}
}

/*
	Name: finish
	Namespace: csceneobject
	Checksum: 0xA90F8E0D
	Offset: 0x2C20
	Size: 0xFC
	Parameters: 2
	Flags: Linked
*/
function finish(b_clear = 0, b_finished = 0)
{
	self notify(#"new_state");
	if(isdefined(self._n_clientnum))
	{
		finish_per_client(self._n_clientnum, b_clear, b_finished);
	}
	else
	{
		for(clientnum = 1; clientnum < getmaxlocalclients(); clientnum++)
		{
			if(isdefined(function_5c10bd79(clientnum)))
			{
				finish_per_client(clientnum, b_clear, b_finished);
			}
		}
		finish_per_client(0, b_clear, b_finished);
	}
}

/*
	Name: finish_per_client
	Namespace: csceneobject
	Checksum: 0x779932D5
	Offset: 0x2D28
	Size: 0x334
	Parameters: 3
	Flags: Linked
*/
function finish_per_client(clientnum, b_clear = 0, b_finished = 0)
{
	if(!is_alive(clientnum))
	{
		_cleanup(clientnum);
		self._e_array[clientnum] = undefined;
		self._is_valid = 0;
	}
	flagsys::set(#"ready");
	flagsys::set(#"done");
	if(isdefined(self._e_array[clientnum]))
	{
		if(!b_finished)
		{
			self._e_array[clientnum] stopsounds();
		}
		if(isplayer(self._e_array[clientnum]) || self._s.type === "sharedplayer" || self._s.type === "player")
		{
			if(scene::function_b260bdcc(self._o_scene._str_name, self._str_shot, self._o_scene._e_root) || b_clear)
			{
				stopmaincamxcam(clientnum);
			}
		}
		else if(is_alive(clientnum) && (b_finished && (isdefined(self._s.deletewhenfinished) && self._s.deletewhenfinished) || b_clear))
		{
			self._e_array[clientnum] delete();
		}
	}
	else if(self._s.type === "sharedplayer" || self._s.type === "player")
	{
		result = 0;
		if(isdefined(self._o_scene) && isdefined(self._o_scene._str_name) && isdefined(self._o_scene._e_root) && isdefined(self._str_shot))
		{
			result = scene::function_b260bdcc(self._o_scene._str_name, self._str_shot, self._o_scene._e_root);
		}
		if(result || b_clear)
		{
			stopmaincamxcam(clientnum);
		}
	}
	_cleanup(clientnum);
}

/*
	Name: get_align_ent
	Namespace: csceneobject
	Checksum: 0x934FA303
	Offset: 0x3068
	Size: 0x1D2
	Parameters: 1
	Flags: Linked
*/
function get_align_ent(clientnum)
{
	e_align = undefined;
	n_shot = get_shot(self._str_shot);
	if(isdefined(n_shot) && isdefined(self._s.shots[n_shot].aligntarget))
	{
		var_690ec5fb = self._s.shots[n_shot].aligntarget;
	}
	else if(isdefined(self._s.aligntarget) && !self._s.aligntarget === self._o_scene._s.aligntarget)
	{
		var_690ec5fb = self._s.aligntarget;
	}
	if(isdefined(var_690ec5fb))
	{
		a_scene_ents = [[ self._o_scene ]]->get_ents();
		if(isdefined(a_scene_ents[clientnum][var_690ec5fb]))
		{
			e_align = a_scene_ents[clientnum][var_690ec5fb];
		}
		else
		{
			e_align = scene::get_existing_ent(clientnum, var_690ec5fb);
		}
		cscriptbundleobjectbase::error(!isdefined(e_align), "Align target '" + (isdefined(var_690ec5fb) ? "" + var_690ec5fb : "") + "' doesn't exist for scene object.");
	}
	if(!isdefined(e_align))
	{
		e_align = [[ scene() ]]->get_align_ent(clientnum);
	}
	return e_align;
}

/*
	Name: scene
	Namespace: csceneobject
	Checksum: 0x16748A86
	Offset: 0x3248
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function scene()
{
	return self._o_scene;
}

/*
	Name: _assign_unique_name
	Namespace: csceneobject
	Checksum: 0xBED0CA52
	Offset: 0x3260
	Size: 0x76
	Parameters: 0
	Flags: Linked
*/
function _assign_unique_name()
{
	if(isdefined(self._s.name))
	{
		self._str_name = self._s.name;
	}
	else
	{
		self._str_name = self._o_scene._str_name + "_noname" + [[ scene() ]]->get_object_id();
	}
}

/*
	Name: get_name
	Namespace: csceneobject
	Checksum: 0xCD64227A
	Offset: 0x32E0
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_name()
{
	return self._str_name;
}

/*
	Name: get_orig_name
	Namespace: csceneobject
	Checksum: 0xE6E23FEE
	Offset: 0x32F8
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_orig_name()
{
	return self._s.name;
}

/*
	Name: _spawn
	Namespace: csceneobject
	Checksum: 0x3AEEF457
	Offset: 0x3318
	Size: 0x3BC
	Parameters: 2
	Flags: Linked
*/
function _spawn(clientnum, b_hide = 1)
{
	restore_saved_ent(clientnum);
	if(!isdefined(self._e_array[clientnum]))
	{
		b_allows_multiple = [[ scene() ]]->allows_multiple();
		self._e_array[clientnum] = scene::get_existing_ent(clientnum, self._str_name);
		if(!isdefined(self._e_array[clientnum]) && isdefined(self._s.name) && !b_allows_multiple)
		{
			self._e_array[clientnum] = scene::get_existing_ent(clientnum, self._s.name);
		}
		if(!isdefined(self._e_array[clientnum]) && (!(isdefined(self._s.nospawn) && self._s.nospawn)) && !self._b_spawnonce_used && isdefined(self._s.model))
		{
			_e_align = get_align_ent(clientnum);
			self._e_array[clientnum] = util::spawn_anim_model(clientnum, self._s.model, _e_align.origin, _e_align.angles);
			cscriptbundleobjectbase::error(!isdefined(self._e_array[clientnum]), "util::spawn_anim_model returned undefined");
			if(self._s.type === "fakeplayer")
			{
				self._e_array[clientnum] useanimtree("all_player");
				self._e_array[clientnum].animtree = "all_player";
			}
			if(isdefined(self._e_array[clientnum]))
			{
				if(b_hide && (!(isdefined(self._e_array[clientnum].var_463f8196) && self._e_array[clientnum].var_463f8196)))
				{
					self._e_array[clientnum] hide();
				}
				self._e_array[clientnum].scene_spawned = self._o_scene._s.name;
			}
			else
			{
				cscriptbundleobjectbase::error(!(isdefined(self._s.nospawn) && self._s.nospawn), "No entity exists with matching name of scene object.");
			}
		}
	}
	if(isdefined(self._e_array[clientnum]))
	{
		[[ self._o_scene ]]->assign_ent(self, self._e_array[clientnum], clientnum);
		_prepare(clientnum);
	}
	flagsys::set(#"ready");
}

/*
	Name: _prepare
	Namespace: csceneobject
	Checksum: 0xB424A8A5
	Offset: 0x36E0
	Size: 0x1BA
	Parameters: 1
	Flags: Linked
*/
function _prepare(clientnum)
{
	self.var_55b4f21e = function_730a4c60(self._str_shot);
	if(!(isdefined(self._s.issiege) && self._s.issiege))
	{
		if(!self._e_array[clientnum] hasanimtree())
		{
			self._e_array[clientnum] useanimtree("generic");
		}
	}
	self._e_array[clientnum].anim_debug_name = self._s.name;
	function_4b3d4226(clientnum);
	if(self._o_scene._s scene::is_igc())
	{
		self._e_array[clientnum] sethighdetail(1);
	}
	self._e_array[clientnum] flagsys::set(#"scene");
	self._e_array[clientnum] flagsys::set(self._o_scene._str_name);
	self._e_array[clientnum].current_scene = self._o_scene._str_name;
	self._e_array[clientnum].finished_scene = undefined;
}

/*
	Name: function_4b3d4226
	Namespace: csceneobject
	Checksum: 0x8B152391
	Offset: 0x38A8
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function function_4b3d4226(clientnum)
{
	if(!isdefined(self._e_array[clientnum]) || !isdefined(self.var_55b4f21e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_a4b8685d) && self.var_55b4f21e.var_a4b8685d)
	{
		self._e_array[clientnum] delete();
		return;
	}
	if(isdefined(self.var_55b4f21e.var_3cd248f5))
	{
		a_ents = getentarray(clientnum, self.var_55b4f21e.var_3cd248f5, "targetname");
		array::run_all(a_ents, &hide);
	}
	else if(isdefined(self.var_55b4f21e.var_b94164e))
	{
		a_ents = getentarray(clientnum, self.var_55b4f21e.var_b94164e, "targetname");
		array::run_all(a_ents, &show);
	}
	if(!(isdefined(self._e_array[clientnum].var_463f8196) && self._e_array[clientnum].var_463f8196))
	{
		if(isdefined(self.var_55b4f21e.var_562f4281) && self.var_55b4f21e.var_562f4281)
		{
			self._e_array[clientnum] hide();
		}
		else if(isdefined(self.var_55b4f21e.var_4f4c4730) && self.var_55b4f21e.var_4f4c4730)
		{
			self._e_array[clientnum] show();
		}
	}
}

/*
	Name: _cleanup
	Namespace: csceneobject
	Checksum: 0x2227DC1E
	Offset: 0x3AC8
	Size: 0x196
	Parameters: 1
	Flags: Linked
*/
function _cleanup(clientnum)
{
	if(isdefined(self._e_array[clientnum]) && isdefined(self._e_array[clientnum].current_scene))
	{
		self._e_array[clientnum] flagsys::clear(self._o_scene._str_name);
		self._e_array[clientnum] sethighdetail(0);
		if(self._e_array[clientnum].current_scene == self._o_scene._str_name)
		{
			self._e_array[clientnum] flagsys::clear(#"scene");
			self._e_array[clientnum].finished_scene = self._o_scene._str_name;
			self._e_array[clientnum].current_scene = undefined;
		}
		function_fda037ff(clientnum);
	}
	if(clientnum === self._n_clientnum || clientnum == 0)
	{
		if(isdefined(self._o_scene) && (isdefined(self._o_scene.scene_stopped) && self._o_scene.scene_stopped))
		{
			self._o_scene = undefined;
		}
	}
}

/*
	Name: function_fda037ff
	Namespace: csceneobject
	Checksum: 0xBC10D7A1
	Offset: 0x3C68
	Size: 0x214
	Parameters: 1
	Flags: Linked
*/
function function_fda037ff(clientnum)
{
	if(!isdefined(self._e_array[clientnum]) || !isdefined(self.var_55b4f21e))
	{
		return;
	}
	if(isdefined(self.var_55b4f21e.var_71ce74a1) && self.var_55b4f21e.var_71ce74a1)
	{
		self._e_array[clientnum] delete();
		return;
	}
	if(isdefined(self.var_55b4f21e.var_39fd697b))
	{
		a_ents = getentarray(clientnum, self.var_55b4f21e.var_39fd697b, "targetname");
		array::run_all(a_ents, &hide);
	}
	else if(isdefined(self.var_55b4f21e.var_4ceff7a6))
	{
		a_ents = getentarray(clientnum, self.var_55b4f21e.var_4ceff7a6, "targetname");
		array::run_all(a_ents, &show);
	}
	if(!(isdefined(self._e_array[clientnum].var_463f8196) && self._e_array[clientnum].var_463f8196))
	{
		if(isdefined(self.var_55b4f21e.var_6d848d4b) && self.var_55b4f21e.var_6d848d4b)
		{
			self._e_array[clientnum] hide();
		}
		else if(isdefined(self.var_55b4f21e.var_78089fee) && self.var_55b4f21e.var_78089fee)
		{
			self._e_array[clientnum] show();
		}
	}
}

/*
	Name: _play_anim
	Namespace: csceneobject
	Checksum: 0x53717D18
	Offset: 0x3E88
	Size: 0x2BA
	Parameters: 7
	Flags: Linked
*/
function _play_anim(clientnum, animation, n_rate = 1, n_blend, str_siege_shot, loop, n_start_time)
{
	_spawn(clientnum);
	if(is_alive(clientnum))
	{
		if(!(isdefined(self._e_array[clientnum].var_463f8196) && self._e_array[clientnum].var_463f8196))
		{
			self._e_array[clientnum] show();
		}
		if(isdefined(self._s.issiege) && self._s.issiege)
		{
			self._e_array[clientnum] animation::play_siege(animation, str_siege_shot, n_rate, loop);
		}
		else if(isdefined(loop) && loop && (isdefined(self._s.var_69db1665) && self._s.var_69db1665))
		{
			n_start_time = undefined;
		}
		util::waitforclient(clientnum);
		if(isdefined(loop) && loop && (isdefined(self._s.var_9de1f44c) && self._s.var_9de1f44c))
		{
			self._e_array[clientnum] animation::play(animation, self._e_array[clientnum], self.m_tag, n_rate, n_blend, undefined, undefined, undefined, n_start_time);
		}
		else
		{
			update_alignment(clientnum);
			self._e_array[clientnum] animation::play(animation, self.m_align, self.m_tag, n_rate, n_blend, undefined, undefined, undefined, n_start_time);
		}
	}
	cscriptbundleobjectbase::log("" + animation + "");
	self._is_valid = is_alive(clientnum);
}

/*
	Name: update_alignment
	Namespace: csceneobject
	Checksum: 0xD1D958EA
	Offset: 0x4150
	Size: 0x5DE
	Parameters: 1
	Flags: Linked
*/
function update_alignment(clientnum)
{
	self.m_align = get_align_ent(clientnum);
	self.m_tag = get_align_tag();
	var_cd4673f4 = isdefined(self._s.var_132e5621) && self._s.var_132e5621;
	var_2dd2901f = ((isdefined(self._o_scene._s.var_922b4fc5) ? self._o_scene._s.var_922b4fc5 : 0), (isdefined(self._o_scene._s.var_3e692842) ? self._o_scene._s.var_3e692842 : 0), (isdefined(self._o_scene._s.var_be60a82b) ? self._o_scene._s.var_be60a82b : 0));
	var_acf1be3a = ((isdefined(self._o_scene._s.var_16999a5d) ? self._o_scene._s.var_16999a5d : 0), (isdefined(self._o_scene._s.var_29563fd6) ? self._o_scene._s.var_29563fd6 : 0), (isdefined(self._o_scene._s.var_eb00c330) ? self._o_scene._s.var_eb00c330 : 0));
	var_24a7cd13 = ((isdefined(self._s.var_922b4fc5) ? self._s.var_922b4fc5 : 0), (isdefined(self._s.var_3e692842) ? self._s.var_3e692842 : 0), (isdefined(self._s.var_be60a82b) ? self._s.var_be60a82b : 0));
	var_75cdf4bd = ((isdefined(self._s.var_16999a5d) ? self._s.var_16999a5d : 0), (isdefined(self._s.var_29563fd6) ? self._s.var_29563fd6 : 0), (isdefined(self._s.var_eb00c330) ? self._s.var_eb00c330 : 0));
	var_2a3b0294 = ((isdefined(self.var_55b4f21e.var_922b4fc5) ? self.var_55b4f21e.var_922b4fc5 : 0), (isdefined(self.var_55b4f21e.var_3e692842) ? self.var_55b4f21e.var_3e692842 : 0), (isdefined(self.var_55b4f21e.var_be60a82b) ? self.var_55b4f21e.var_be60a82b : 0));
	var_f3bd6699 = ((isdefined(self.var_55b4f21e.var_16999a5d) ? self.var_55b4f21e.var_16999a5d : 0), (isdefined(self.var_55b4f21e.var_29563fd6) ? self.var_55b4f21e.var_29563fd6 : 0), (isdefined(self.var_55b4f21e.var_eb00c330) ? self.var_55b4f21e.var_eb00c330 : 0));
	if(var_2a3b0294 != (0, 0, 0))
	{
		var_d3c21d73 = var_2a3b0294;
	}
	else if(var_24a7cd13 != (0, 0, 0))
	{
		var_d3c21d73 = var_24a7cd13;
	}
	else
	{
		var_d3c21d73 = var_2dd2901f;
	}
	if(var_f3bd6699 != (0, 0, 0))
	{
		v_ang_offset = var_f3bd6699;
	}
	else if(var_75cdf4bd != (0, 0, 0))
	{
		v_ang_offset = var_75cdf4bd;
	}
	else
	{
		v_ang_offset = var_acf1be3a;
	}
	if(self.m_align == level)
	{
		self.m_align = (0, 0, 0) + var_d3c21d73;
		self.m_tag = (0, 0, 0) + v_ang_offset;
	}
	else if(var_d3c21d73 != (0, 0, 0) || v_ang_offset != (0, 0, 0))
	{
		v_pos = self.m_align.origin + var_d3c21d73;
		if(var_cd4673f4)
		{
			v_ang = self._e_array[clientnum].angles;
		}
		else
		{
			v_ang = self.m_align.angles + v_ang_offset;
		}
		self.m_align = {#angles:v_ang, #origin:v_pos};
	}
	else if(var_cd4673f4)
	{
		v_pos = self.m_align.origin;
		v_ang = self._e_array[clientnum].angles;
		self.m_align = {#angles:v_ang, #origin:v_pos};
	}
}

/*
	Name: get_align_tag
	Namespace: csceneobject
	Checksum: 0x32B9B49E
	Offset: 0x4738
	Size: 0x6A
	Parameters: 0
	Flags: Linked
*/
function get_align_tag()
{
	if(isdefined(self.var_55b4f21e.aligntargettag))
	{
		return self.var_55b4f21e.aligntargettag;
	}
	if(isdefined(self._s.aligntargettag))
	{
		return self._s.aligntargettag;
	}
	return self._o_scene._s.aligntargettag;
}

/*
	Name: function_54266b24
	Namespace: csceneobject
	Checksum: 0x314E0AC1
	Offset: 0x47B0
	Size: 0x88
	Parameters: 0
	Flags: Linked
*/
function function_54266b24()
{
	foreach(obj in self._o_scene._a_objects)
	{
		obj flagsys::wait_till_clear("camera_playing");
	}
}

/*
	Name: wait_till_shot_ready
	Namespace: csceneobject
	Checksum: 0x5203AE1A
	Offset: 0x4840
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function wait_till_shot_ready()
{
	[[ scene() ]]->wait_till_shot_ready();
}

/*
	Name: has_init_state
	Namespace: csceneobject
	Checksum: 0x2A1D27E0
	Offset: 0x4870
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function has_init_state(str_scenedef)
{
	return self._s scene::_has_init_state(str_scenedef);
}

/*
	Name: is_alive
	Namespace: csceneobject
	Checksum: 0x74C9C19F
	Offset: 0x48A0
	Size: 0x1A
	Parameters: 1
	Flags: Linked
*/
function is_alive(clientnum)
{
	return isdefined(self._e_array[clientnum]);
}

/*
	Name: in_a_different_scene
	Namespace: csceneobject
	Checksum: 0xB0D66D7F
	Offset: 0x48C8
	Size: 0xDA
	Parameters: 0
	Flags: Linked
*/
function in_a_different_scene()
{
	if(isdefined(self._n_clientnum))
	{
		if(isdefined(self._e_array[self._n_clientnum]) && isdefined(self._e_array[self._n_clientnum].current_scene) && self._e_array[self._n_clientnum].current_scene != self._o_scene._str_name)
		{
			return 1;
		}
	}
	else if(isdefined(self._e_array[0]) && isdefined(self._e_array[0].current_scene) && self._e_array[0].current_scene != self._o_scene._str_name)
	{
		return 1;
	}
	return 0;
}

#namespace scene;

/*
	Name: csceneobject
	Namespace: scene
	Checksum: 0x748BA95A
	Offset: 0x49B0
	Size: 0x8C6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function csceneobject()
{
	classes.csceneobject[0] = spawnstruct();
	classes.csceneobject[0].__vtable[1839071698] = &cscriptbundleobjectbase::get_ent;
	classes.csceneobject[0].__vtable[365768300] = &cscriptbundleobjectbase::error;
	classes.csceneobject[0].__vtable[766440049] = &cscriptbundleobjectbase::log;
	classes.csceneobject[0].__vtable[1836838051] = &cscriptbundleobjectbase::init;
	classes.csceneobject[0].__vtable[913321084] = &cscriptbundleobjectbase::__destructor;
	classes.csceneobject[0].__vtable[674154906] = &cscriptbundleobjectbase::__constructor;
	classes.csceneobject[0].__vtable[98152468] = &csceneobject::in_a_different_scene;
	classes.csceneobject[0].__vtable[777981796] = &csceneobject::is_alive;
	classes.csceneobject[0].__vtable[1343842804] = &csceneobject::has_init_state;
	classes.csceneobject[0].__vtable[1582596] = &csceneobject::wait_till_shot_ready;
	classes.csceneobject[0].__vtable[1411803940] = &csceneobject::function_54266b24;
	classes.csceneobject[0].__vtable[103181182] = &csceneobject::get_align_tag;
	classes.csceneobject[0].__vtable[1819411100] = &csceneobject::update_alignment;
	classes.csceneobject[0].__vtable[568517411] = &csceneobject::_play_anim;
	classes.csceneobject[0].__vtable[39831553] = &csceneobject::function_fda037ff;
	classes.csceneobject[0].__vtable[549459069] = &csceneobject::_cleanup;
	classes.csceneobject[0].__vtable[1262305830] = &csceneobject::function_4b3d4226;
	classes.csceneobject[0].__vtable[1985603041] = &csceneobject::_prepare;
	classes.csceneobject[0].__vtable[362767597] = &csceneobject::_spawn;
	classes.csceneobject[0].__vtable[50249939] = &csceneobject::get_orig_name;
	classes.csceneobject[0].__vtable[921351730] = &csceneobject::get_name;
	classes.csceneobject[0].__vtable[277737316] = &csceneobject::_assign_unique_name;
	classes.csceneobject[0].__vtable[2085193114] = &csceneobject::scene;
	classes.csceneobject[0].__vtable[1997194878] = &csceneobject::get_align_ent;
	classes.csceneobject[0].__vtable[1544229797] = &csceneobject::finish_per_client;
	classes.csceneobject[0].__vtable[693640918] = &csceneobject::finish;
	classes.csceneobject[0].__vtable[340013043] = &csceneobject::function_ebbbd00d;
	classes.csceneobject[0].__vtable[1484353974] = &csceneobject::function_587971b6;
	classes.csceneobject[0].__vtable[581995295] = &csceneobject::function_dd4f74e1;
	classes.csceneobject[0].__vtable[250171255] = &csceneobject::function_ee94f77;
	classes.csceneobject[0].__vtable[1548900053] = &csceneobject::play_per_client;
	classes.csceneobject[0].__vtable[881215179] = &csceneobject::play;
	classes.csceneobject[0].__vtable[1970232926] = &csceneobject::initialize_per_client;
	classes.csceneobject[0].__vtable[20115966] = &csceneobject::is_skipping_scene;
	classes.csceneobject[0].__vtable[761382055] = &csceneobject::run_wait;
	classes.csceneobject[0].__vtable[308479578] = &csceneobject::function_1263065a;
	classes.csceneobject[0].__vtable[593821111] = &csceneobject::function_dc9b0249;
	classes.csceneobject[0].__vtable[1051055431] = &csceneobject::get_entry;
	classes.csceneobject[0].__vtable[1907386484] = &csceneobject::function_71b06874;
	classes.csceneobject[0].__vtable[1930054752] = &csceneobject::function_730a4c60;
	classes.csceneobject[0].__vtable[1619355989] = &csceneobject::get_shot;
	classes.csceneobject[0].__vtable[1128083910] = &csceneobject::initialize;
	classes.csceneobject[0].__vtable[599814849] = &csceneobject::restore_saved_ent;
	classes.csceneobject[0].__vtable[1771795120] = &csceneobject::first_init;
	classes.csceneobject[0].__vtable[913321084] = &csceneobject::__destructor;
	classes.csceneobject[0].__vtable[674154906] = &csceneobject::__constructor;
}

#namespace cscene;

/*
	Name: __constructor
	Namespace: cscene
	Checksum: 0xA6F1C335
	Offset: 0x5280
	Size: 0x3A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	cscriptbundlebase::__constructor();
	self._n_object_id = 0;
	self._str_mode = "";
	self._a_active_shots = [];
}

/*
	Name: __destructor
	Namespace: cscene
	Checksum: 0xCE9B679F
	Offset: 0x52C8
	Size: 0x14
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
	cscriptbundlebase::__destructor();
}

/*
	Name: new_object
	Namespace: cscene
	Checksum: 0x27F43E4A
	Offset: 0x52E8
	Size: 0x1E2
	Parameters: 1
	Flags: Linked
*/
function new_object(str_type)
{
	switch(str_type)
	{
		case "prop":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "model":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "vehicle":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "actor":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "fakeactor":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "player":
		{
			object = new csceneplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "sharedplayer":
		{
			object = new csceneplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "fakeplayer":
		{
			object = new csceneobject();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "companion":
		{
			object = new csceneplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		case "sharedcompanion":
		{
			object = new csceneplayer();
			[[ object ]]->__constructor();
			return object;
			break;
		}
		default:
		{
			cscriptbundlebase::error(0, "Unsupported object type '" + str_type + "'.");
		}
	}
}

/*
	Name: init
	Namespace: cscene
	Checksum: 0xB2DA5F9F
	Offset: 0x54D8
	Size: 0x4BC
	Parameters: 5
	Flags: Linked
*/
function init(str_scenedef, s_scenedef, e_align, a_ents, b_test_run)
{
	cscriptbundlebase::init(str_scenedef, s_scenedef, b_test_run);
	if(!isdefined(a_ents))
	{
		a_ents = [];
	}
	else if(!isarray(a_ents))
	{
		a_ents = array(a_ents);
	}
	if(!cscriptbundlebase::error(a_ents.size > self._s.objects.size, "Trying to use more entities than scene supports."))
	{
		self._e_root = e_align;
		if(!isdefined(level.inactive_scenes))
		{
			level.inactive_scenes = [];
		}
		if(!isdefined(level.active_scenes[self._str_name]))
		{
			level.active_scenes[self._str_name] = [];
		}
		else if(!isarray(level.active_scenes[self._str_name]))
		{
			level.active_scenes[self._str_name] = array(level.active_scenes[self._str_name]);
		}
		level.active_scenes[self._str_name][level.active_scenes[self._str_name].size] = self._e_root;
		if(!isdefined(self._e_root.scenes))
		{
			self._e_root.scenes = [];
		}
		else if(!isarray(self._e_root.scenes))
		{
			self._e_root.scenes = array(self._e_root.scenes);
		}
		self._e_root.scenes[self._e_root.scenes.size] = self;
		a_objs = get_valid_object_defs();
		foreach(str_name, e_ent in arraycopy(a_ents))
		{
			foreach(i, s_obj in arraycopy(a_objs))
			{
				if(s_obj.name === (isdefined(str_name) ? "" + str_name : ""))
				{
					cscriptbundlebase::add_object([[ [[ self ]]->new_object(s_obj.type) ]]->first_init(s_obj, self, e_ent, self._e_root.localclientnum));
					arrayremoveindex(a_ents, str_name);
					arrayremoveindex(a_objs, i);
					break;
				}
			}
		}
		foreach(s_obj in a_objs)
		{
			cscriptbundlebase::add_object([[ [[ self ]]->new_object(s_obj.type) ]]->first_init(s_obj, self, array::pop(a_ents), self._e_root.localclientnum));
		}
		self thread initialize();
	}
}

/*
	Name: assign_ent
	Namespace: cscene
	Checksum: 0xC777889B
	Offset: 0x59A0
	Size: 0xA0
	Parameters: 3
	Flags: Linked
*/
function assign_ent(o_obj, ent, clientnum)
{
	if(!isdefined(self._e_root.scene_ents))
	{
		self._e_root.scene_ents = [];
	}
	if(!isdefined(self._e_root.scene_ents[clientnum]))
	{
		self._e_root.scene_ents[clientnum] = [];
	}
	self._e_root.scene_ents[clientnum][o_obj._str_name] = ent;
}

/*
	Name: get_valid_object_defs
	Namespace: cscene
	Checksum: 0x913C37E3
	Offset: 0x5A48
	Size: 0x1A0
	Parameters: 0
	Flags: Linked
*/
function get_valid_object_defs()
{
	a_obj_defs = [];
	foreach(s_obj in self._s.objects)
	{
		if(self._s.vmtype === "client" || s_obj.vmtype === "client")
		{
			if(isdefined(s_obj.name) || isdefined(s_obj.model) || isdefined(s_obj.initanim) || isdefined(s_obj.mainanim))
			{
				if(!(isdefined(s_obj.disabled) && s_obj.disabled) && scene::function_6f382548(s_obj, self._s.name))
				{
					if(!isdefined(a_obj_defs))
					{
						a_obj_defs = [];
					}
					else if(!isarray(a_obj_defs))
					{
						a_obj_defs = array(a_obj_defs);
					}
					a_obj_defs[a_obj_defs.size] = s_obj;
				}
			}
		}
	}
	return a_obj_defs;
}

/*
	Name: initialize
	Namespace: cscene
	Checksum: 0x1C984FAA
	Offset: 0x5BF0
	Size: 0x13C
	Parameters: 1
	Flags: Linked
*/
function initialize(b_playing = 0)
{
	self notify(#"new_state");
	self endon(#"new_state");
	self._s scene::function_585fb738();
	if(get_valid_objects().size > 0)
	{
		level flagsys::set(self._str_name + "_initialized");
		self._str_mode = "init";
		foreach(o_obj in self._a_objects)
		{
			thread [[ o_obj ]]->initialize();
		}
		if(!b_playing)
		{
			thread _call_state_funcs("init");
		}
	}
}

/*
	Name: get_object_id
	Namespace: cscene
	Checksum: 0x47C2F4B
	Offset: 0x5D38
	Size: 0x16
	Parameters: 0
	Flags: Linked
*/
function get_object_id()
{
	self._n_object_id++;
	return self._n_object_id;
}

/*
	Name: function_1013fc5b
	Namespace: cscene
	Checksum: 0xE4F5A6B2
	Offset: 0x5D58
	Size: 0x2C8
	Parameters: 0
	Flags: Linked
*/
function function_1013fc5b()
{
	if(isstring(self._s.cameraswitcher) || function_7a600918(self._s.cameraswitcher))
	{
		a_players = getlocalplayers();
		foreach(player in a_players)
		{
			clientnum = player getlocalclientnumber();
			e_align = get_align_ent(clientnum);
			v_pos = (isdefined(e_align.origin) ? e_align.origin : (0, 0, 0));
			v_ang = (isdefined(e_align.angles) ? e_align.angles : (0, 0, 0));
			playmaincamxcam(clientnum, self._s.cameraswitcher, 0, "", "", v_pos, v_ang);
		}
		if(iscamanimlooping(self._s.cameraswitcher))
		{
			self waittill(#"new_state");
		}
		else
		{
			n_cam_time = getcamanimtime(self._s.cameraswitcher);
			self waittill_timeout(float(n_cam_time) / 1000, #"new_state");
		}
		a_players = getlocalplayers();
		foreach(player in a_players)
		{
			clientnum = player getlocalclientnumber();
			stopmaincamxcam(clientnum);
		}
	}
}

/*
	Name: play
	Namespace: cscene
	Checksum: 0x285C4C7F
	Offset: 0x6028
	Size: 0x524
	Parameters: 4
	Flags: Linked
*/
function play(str_shot = "play", b_testing = 0, str_mode = "", b_looping = undefined)
{
	level endon(#"demo_jump");
	self notify(str_shot + "start");
	self endon_callback(&function_99159b0c, str_shot + "start", #"new_state");
	if(issubstr(str_mode, "play_from_time"))
	{
		args = strtok(str_mode, ":");
		if(isdefined(args[1]))
		{
			var_79584e08 = float(args[1]);
		}
	}
	self._testing = b_testing;
	self._str_mode = str_mode;
	self._str_shot = str_shot;
	if(get_valid_objects().size > 0)
	{
		foreach(o_obj in self._a_objects)
		{
			thread [[ o_obj ]]->play(str_shot, var_79584e08, b_looping);
		}
		self.n_start_time = undefined;
		level flagsys::set(self._str_name + "_playing");
		if(!strendswith(self._str_mode, "single"))
		{
			self._str_mode = "play";
		}
		wait_till_shot_ready();
		function_7a1288f1(str_shot);
		thread function_1013fc5b();
		thread _call_state_funcs(str_shot);
		function_6a55f153();
		array::flagsys_wait_any_flag(self._a_objects, "done", "main_done");
		if(scene::function_b260bdcc(self._str_name, str_shot))
		{
			if(isdefined(self._e_root))
			{
				self._e_root notify(#"scene_done", {#scenedef:self._str_name});
			}
			thread _call_state_funcs("done");
			self.var_b0ff34ce = 1;
		}
		if(is_looping() || self._str_mode == "loop" && (isdefined(self.var_b0ff34ce) && self.var_b0ff34ce))
		{
			self.var_b0ff34ce = undefined;
			if(has_init_state())
			{
				level flagsys::clear(self._str_name + "_playing");
				thread initialize();
			}
			else
			{
				level flagsys::clear(self._str_name + "_initialized");
				var_689ecfec = scene::function_de6a7579(self._str_name, str_mode, self._e_root);
				thread play(var_689ecfec, b_testing, str_mode, 1);
			}
		}
		else if(!strendswith(self._str_mode, "single"))
		{
			thread run_next(str_shot);
		}
		else
		{
			thread stop(0, 1);
		}
	}
	else
	{
		thread stop(0, 1);
	}
	function_ea4a6812(str_shot);
}

/*
	Name: function_99159b0c
	Namespace: cscene
	Checksum: 0x3EE4FFEF
	Offset: 0x6558
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function function_99159b0c(var_a27f7ab4)
{
	function_ea4a6812(self._str_shot);
}

/*
	Name: run_next
	Namespace: cscene
	Checksum: 0xC8EA6287
	Offset: 0x6588
	Size: 0x2FC
	Parameters: 1
	Flags: Linked
*/
function run_next(str_current_shot)
{
	if(isdefined(self._s.nextscenebundle) && self._s.vmtype !== "both")
	{
		waitresult = undefined;
		waitresult = self waittill(#"stopped");
		if(waitresult.is_finished)
		{
			if(self._s.scenetype == "fxanim" && self._s.nextscenemode === "init")
			{
				if(!cscriptbundlebase::error(!has_init_state(), "Scene can't init next scene '" + self._s.nextscenebundle + "' because it doesn't have an init state."))
				{
					if(allows_multiple())
					{
						self._e_root thread scene::init(self._s.nextscenebundle, get_ents());
					}
					else
					{
						self._e_root thread scene::init(self._s.nextscenebundle);
					}
				}
			}
			else if(allows_multiple())
			{
				self._e_root thread scene::play(self._s.nextscenebundle, get_ents());
			}
			else
			{
				self._e_root thread scene::play(self._s.nextscenebundle);
			}
		}
		thread stop(0, 1);
	}
	else
	{
		var_1a15e649 = function_c9f40212();
		function_ea4a6812(str_current_shot);
		if(isdefined(var_1a15e649))
		{
			switch(self._s.scenetype)
			{
				case "scene":
				{
					thread [[ self ]]->play(var_1a15e649, self._testing, self._str_mode);
					break;
				}
				default:
				{
					thread [[ self ]]->play(var_1a15e649, self._testing, self._str_mode);
				}
			}
		}
		else
		{
			thread stop(0, 1);
		}
	}
}

/*
	Name: function_7a1288f1
	Namespace: cscene
	Checksum: 0xB689803D
	Offset: 0x6890
	Size: 0x114
	Parameters: 1
	Flags: Linked
*/
function function_7a1288f1(str_shot)
{
	if(!isdefined(self._a_active_shots))
	{
		self._a_active_shots = [];
	}
	else if(!isarray(self._a_active_shots))
	{
		self._a_active_shots = array(self._a_active_shots);
	}
	if(!isinarray(self._a_active_shots, str_shot))
	{
		self._a_active_shots[self._a_active_shots.size] = str_shot;
	}
	if(isarray(level.inactive_scenes[self._str_name]))
	{
		arrayremovevalue(level.inactive_scenes[self._str_name], self._e_root);
		if(level.inactive_scenes[self._str_name].size == 0)
		{
			level.inactive_scenes[self._str_name] = undefined;
		}
	}
}

/*
	Name: function_ea4a6812
	Namespace: cscene
	Checksum: 0xFA272CF
	Offset: 0x69B0
	Size: 0x174
	Parameters: 1
	Flags: Linked
*/
function function_ea4a6812(str_shot)
{
	arrayremovevalue(self._a_active_shots, str_shot);
	if(self._a_active_shots.size == 0)
	{
		if(!isdefined(level.inactive_scenes[self._str_name]))
		{
			level.inactive_scenes[self._str_name] = [];
		}
		else if(!isarray(level.inactive_scenes[self._str_name]))
		{
			level.inactive_scenes[self._str_name] = array(level.inactive_scenes[self._str_name]);
		}
		if(!isinarray(level.inactive_scenes[self._str_name], self._e_root))
		{
			level.inactive_scenes[self._str_name][level.inactive_scenes[self._str_name].size] = self._e_root;
		}
		arrayremovevalue(level.inactive_scenes[self._str_name], undefined);
		arrayremovevalue(level.inactive_scenes, undefined, 1);
	}
}

/*
	Name: function_2ba44cd0
	Namespace: cscene
	Checksum: 0xDF32B210
	Offset: 0x6B30
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function function_2ba44cd0()
{
	return self._str_shot;
}

/*
	Name: function_c9f40212
	Namespace: cscene
	Checksum: 0xE30369DB
	Offset: 0x6B48
	Size: 0x13C
	Parameters: 0
	Flags: Linked
*/
function function_c9f40212()
{
	if(self._s.scenetype === "scene")
	{
		if(isdefined(self.var_2e9fdf35))
		{
			var_1a15e649 = self.var_2e9fdf35;
			self.var_2e9fdf35 = undefined;
			return var_1a15e649;
		}
		a_shots = scene::get_all_shot_names(self._str_name, self._e_root);
		foreach(i, str_shot in a_shots)
		{
			if(str_shot === self._a_active_shots[0] && isdefined(a_shots[i + 1]))
			{
				return a_shots[i + 1];
			}
		}
	}
	else
	{
	}
}

/*
	Name: stop
	Namespace: cscene
	Checksum: 0x42E074BC
	Offset: 0x6C90
	Size: 0x34E
	Parameters: 2
	Flags: Linked
*/
function stop(b_clear = 0, b_finished = 0)
{
	self notify(#"new_state");
	level flagsys::clear(self._str_name + "_playing");
	level flagsys::clear(self._str_name + "_initialized");
	self._str_mode = "";
	thread _call_state_funcs("stop");
	self.scene_stopped = 1;
	foreach(o_obj in self._a_objects)
	{
		if(isdefined(o_obj) && !([[ o_obj ]]->in_a_different_scene()))
		{
			thread [[ o_obj ]]->finish(b_clear, b_finished);
		}
	}
	self notify(#"stopped", {#is_finished:b_finished});
	if(isdefined(level.active_scenes[self._str_name]))
	{
		arrayremovevalue(level.active_scenes[self._str_name], self._e_root);
		if(level.active_scenes[self._str_name].size == 0)
		{
			level.active_scenes[self._str_name] = undefined;
		}
	}
	if(isdefined(self._e_root) && isdefined(self._e_root.scenes))
	{
		arrayremovevalue(self._e_root.scenes, self);
		if(self._e_root.scenes.size == 0)
		{
			self._e_root.scenes = undefined;
		}
		self._e_root notify(#"scene_done", {#scenedef:self._str_name});
		if(isdefined(self._e_root.scene_played))
		{
			foreach(var_74f5d118 in self._e_root.scene_played)
			{
				var_74f5d118 = 1;
			}
		}
	}
	self notify(#"scene_done", {#scenedef:self._str_name});
}

/*
	Name: has_init_state
	Namespace: cscene
	Checksum: 0x135122E7
	Offset: 0x6FE8
	Size: 0x9E
	Parameters: 0
	Flags: Linked
*/
function has_init_state()
{
	b_has_init_state = 0;
	foreach(o_scene_object in self._a_objects)
	{
		if([[ o_scene_object ]]->has_init_state(self._str_name))
		{
			b_has_init_state = 1;
			break;
		}
	}
	return b_has_init_state;
}

/*
	Name: _call_state_funcs
	Namespace: cscene
	Checksum: 0x57E34526
	Offset: 0x7090
	Size: 0x40A
	Parameters: 1
	Flags: Linked
*/
function _call_state_funcs(str_state)
{
	self endon(#"stopped");
	wait_till_shot_ready();
	if(str_state == "play")
	{
		waittillframeend();
	}
	level notify(self._str_name + "_" + str_state);
	if(isdefined(level.scene_funcs) && isdefined(level.scene_funcs[self._str_name]) && isdefined(level.scene_funcs[self._str_name][str_state]))
	{
		a_all_ents = get_ents();
		foreach(clientnum, a_ents in a_all_ents)
		{
			foreach(handler in level.scene_funcs[self._str_name][str_state])
			{
				func = handler[0];
				args = handler[1];
				switch(args.size)
				{
					case 6:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0], args[1], args[2], args[3], args[4], args[5]);
						break;
					}
					case 5:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0], args[1], args[2], args[3], args[4]);
						break;
					}
					case 4:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0], args[1], args[2], args[3]);
						break;
					}
					case 3:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0], args[1], args[2]);
						break;
					}
					case 2:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0], args[1]);
						break;
					}
					case 1:
					{
						self._e_root thread [[func]](clientnum, a_ents, args[0]);
						break;
					}
					case 0:
					{
						self._e_root thread [[func]](clientnum, a_ents);
						break;
					}
					default:
					{
						/#
							assertmsg("");
						#/
					}
				}
			}
		}
	}
}

/*
	Name: get_ents
	Namespace: cscene
	Checksum: 0xB2D76D49
	Offset: 0x74A8
	Size: 0x182
	Parameters: 0
	Flags: Linked
*/
function get_ents()
{
	a_ents = [];
	for(clientnum = 0; clientnum < getmaxlocalclients(); clientnum++)
	{
		if(isdefined(function_5c10bd79(clientnum)))
		{
			a_ents[clientnum] = [];
			foreach(o_obj in self._a_objects)
			{
				ent = [[ o_obj ]]->get_ent(clientnum);
				if(isdefined(o_obj._s.name))
				{
					a_ents[clientnum][o_obj._s.name] = ent;
					continue;
				}
				if(!isdefined(a_ents))
				{
					a_ents = [];
				}
				else if(!isarray(a_ents))
				{
					a_ents = array(a_ents);
				}
				a_ents[a_ents.size] = ent;
			}
		}
	}
	return a_ents;
}

/*
	Name: get_root
	Namespace: cscene
	Checksum: 0xDCD2FD26
	Offset: 0x7638
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function get_root()
{
	return self._e_root;
}

/*
	Name: get_align_ent
	Namespace: cscene
	Checksum: 0xC14907F2
	Offset: 0x7650
	Size: 0x7A
	Parameters: 1
	Flags: Linked
*/
function get_align_ent(clientnum)
{
	e_align = self._e_root;
	if(isdefined(self._s.aligntarget))
	{
		e_gdt_align = scene::get_existing_ent(clientnum, self._s.aligntarget);
		if(isdefined(e_gdt_align))
		{
			e_align = e_gdt_align;
		}
	}
	return e_align;
}

/*
	Name: allows_multiple
	Namespace: cscene
	Checksum: 0x3D099D63
	Offset: 0x76D8
	Size: 0x8
	Parameters: 0
	Flags: Linked
*/
function allows_multiple()
{
	return 1;
}

/*
	Name: is_looping
	Namespace: cscene
	Checksum: 0x5973015D
	Offset: 0x76E8
	Size: 0x28
	Parameters: 0
	Flags: Linked
*/
function is_looping()
{
	return isdefined(self._s.looping) && self._s.looping;
}

/*
	Name: is_skipping_scene
	Namespace: cscene
	Checksum: 0xEA96CA23
	Offset: 0x7718
	Size: 0x46
	Parameters: 0
	Flags: Linked
*/
function is_skipping_scene()
{
	return isdefined(self.skipping_scene) && self.skipping_scene || self._str_mode == "skip_scene" || self._str_mode == "skip_scene_player";
}

/*
	Name: wait_till_shot_ready
	Namespace: cscene
	Checksum: 0xFC5FD6DF
	Offset: 0x7768
	Size: 0x34
	Parameters: 0
	Flags: Linked
*/
function wait_till_shot_ready()
{
	if(isdefined(self._a_objects))
	{
		array::flagsys_wait(self._a_objects, "ready");
	}
}

/*
	Name: function_6a55f153
	Namespace: cscene
	Checksum: 0x463E7C49
	Offset: 0x77A8
	Size: 0x24
	Parameters: 0
	Flags: Linked
*/
function function_6a55f153()
{
	array::flagsys_wait(self._a_objects, "done");
}

/*
	Name: get_valid_objects
	Namespace: cscene
	Checksum: 0xC6373601
	Offset: 0x77D8
	Size: 0xF0
	Parameters: 0
	Flags: Linked
*/
function get_valid_objects()
{
	a_obj = [];
	foreach(obj in self._a_objects)
	{
		if(obj._is_valid && !([[ obj ]]->in_a_different_scene()))
		{
			if(!isdefined(a_obj))
			{
				a_obj = [];
			}
			else if(!isarray(a_obj))
			{
				a_obj = array(a_obj);
			}
			a_obj[a_obj.size] = obj;
		}
	}
	return a_obj;
}

/*
	Name: on_error
	Namespace: cscene
	Checksum: 0xB30FCD16
	Offset: 0x78D0
	Size: 0x14
	Parameters: 0
	Flags: Linked
*/
function on_error()
{
	stop();
}

#namespace scene;

/*
	Name: cscene
	Namespace: scene
	Checksum: 0x7B5ED6D5
	Offset: 0x78F0
	Size: 0x7D6
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscene()
{
	classes.cscene[0] = spawnstruct();
	classes.cscene[0].__vtable[365768300] = &cscriptbundlebase::error;
	classes.cscene[0].__vtable[766440049] = &cscriptbundlebase::log;
	classes.cscene[0].__vtable[1946041604] = &cscriptbundlebase::remove_object;
	classes.cscene[0].__vtable[1475690061] = &cscriptbundlebase::add_object;
	classes.cscene[0].__vtable[1595793979] = &cscriptbundlebase::is_testing;
	classes.cscene[0].__vtable[1297640942] = &cscriptbundlebase::get_objects;
	classes.cscene[0].__vtable[419606637] = &cscriptbundlebase::get_vm;
	classes.cscene[0].__vtable[1434708725] = &cscriptbundlebase::get_type;
	classes.cscene[0].__vtable[1836838051] = &cscriptbundlebase::init;
	classes.cscene[0].__vtable[913321084] = &cscriptbundlebase::__destructor;
	classes.cscene[0].__vtable[674154906] = &cscriptbundlebase::__constructor;
	classes.cscene[0].__vtable[1570676452] = &cscriptbundlebase::on_error;
	classes.cscene[0].__vtable[1570676452] = &cscene::on_error;
	classes.cscene[0].__vtable[1533509286] = &cscene::get_valid_objects;
	classes.cscene[0].__vtable[1784017235] = &cscene::function_6a55f153;
	classes.cscene[0].__vtable[1582596] = &cscene::wait_till_shot_ready;
	classes.cscene[0].__vtable[20115966] = &cscene::is_skipping_scene;
	classes.cscene[0].__vtable[2103736659] = &cscene::is_looping;
	classes.cscene[0].__vtable[1534550429] = &cscene::allows_multiple;
	classes.cscene[0].__vtable[1997194878] = &cscene::get_align_ent;
	classes.cscene[0].__vtable[1722290389] = &cscene::get_root;
	classes.cscene[0].__vtable[215327320] = &cscene::get_ents;
	classes.cscene[0].__vtable[1221085858] = &cscene::_call_state_funcs;
	classes.cscene[0].__vtable[1343842804] = &cscene::has_init_state;
	classes.cscene[0].__vtable[1959331961] = &cscene::stop;
	classes.cscene[0].__vtable[906755566] = &cscene::function_c9f40212;
	classes.cscene[0].__vtable[732187856] = &cscene::function_2ba44cd0;
	classes.cscene[0].__vtable[364222446] = &cscene::function_ea4a6812;
	classes.cscene[0].__vtable[2048035057] = &cscene::function_7a1288f1;
	classes.cscene[0].__vtable[782090682] = &cscene::run_next;
	classes.cscene[0].__vtable[1726637300] = &cscene::function_99159b0c;
	classes.cscene[0].__vtable[881215179] = &cscene::play;
	classes.cscene[0].__vtable[269745243] = &cscene::function_1013fc5b;
	classes.cscene[0].__vtable[1226873752] = &cscene::get_object_id;
	classes.cscene[0].__vtable[1128083910] = &cscene::initialize;
	classes.cscene[0].__vtable[1299358145] = &cscene::get_valid_object_defs;
	classes.cscene[0].__vtable[327919019] = &cscene::assign_ent;
	classes.cscene[0].__vtable[1836838051] = &cscene::init;
	classes.cscene[0].__vtable[648642868] = &cscene::new_object;
	classes.cscene[0].__vtable[913321084] = &cscene::__destructor;
	classes.cscene[0].__vtable[674154906] = &cscene::__constructor;
}

/*
	Name: get_existing_ent
	Namespace: scene
	Checksum: 0xB4916AB3
	Offset: 0x80D0
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function get_existing_ent(clientnum, str_name)
{
	e = getent(clientnum, str_name, "animname");
	if(!isdefined(e))
	{
		e = getent(clientnum, str_name, "script_animname");
		if(!isdefined(e))
		{
			e = getent(clientnum, str_name, "targetname");
			if(!isdefined(e))
			{
				e = struct::get(str_name, "targetname");
			}
		}
	}
	return e;
}

/*
	Name: function_89f2df9
	Namespace: scene
	Checksum: 0x10B23919
	Offset: 0x8198
	Size: 0x44
	Parameters: 0
	Flags: AutoExec
*/
autoexec function function_89f2df9()
{
	system::register(#"scene", &__init__, &__main__, undefined);
}

/*
	Name: __init__
	Namespace: scene
	Checksum: 0xB1C9121F
	Offset: 0x81E8
	Size: 0x4A4
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.scenedefs = getscriptbundlenames("scene");
	level.active_scenes = [];
	level.var_1e798f4c = [];
	cp_skip_scene_menu::register("cp_skip_scene_menu");
	level.server_scenes = [];
	foreach(str_scenename in level.scenedefs)
	{
		s_scenedef = getscriptbundle(str_scenename);
		if(s_scenedef.vmtype === "server")
		{
			continue;
		}
		s_scenedef.editaction = undefined;
		s_scenedef.newobject = undefined;
		if(s_scenedef is_igc())
		{
			level.server_scenes[s_scenedef.name] = s_scenedef;
			continue;
		}
		if(s_scenedef.vmtype === "both")
		{
			n_clientbits = getminbitcountfornum(3);
			/#
				n_clientbits = getminbitcountfornum(6);
			#/
			clientfield::register("world", s_scenedef.name, 1, n_clientbits, "int", &cf_server_sync, 0, 0);
		}
	}
	clientfield::register("toplayer", "postfx_igc", 1, 2, "counter", &postfx_igc, 0, 0);
	clientfield::register("world", "in_igc", 1, 4, "int", &in_igc, 0, 0);
	clientfield::register("toplayer", "postfx_cateye", 1, 1, "int", &postfx_cateye, 0, 0);
	clientfield::register("toplayer", "player_scene_skip_completed", 1, 2, "counter", &player_scene_skip_completed, 0, 0);
	clientfield::register("toplayer", "player_pbg_bank_scene_system", 1, getminbitcountfornum(3), "int", &player_pbg_bank_scene_system, 0, 0);
	clientfield::register("allplayers", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
	clientfield::register("actor", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
	clientfield::register("vehicle", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
	clientfield::register("scriptmover", "player_scene_animation_skip", 1, 2, "counter", &player_scene_animation_skip, 0, 0);
	callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

/*
	Name: player_pbg_bank_scene_system
	Namespace: scene
	Checksum: 0xA53137F
	Offset: 0x8698
	Size: 0x112
	Parameters: 7
	Flags: Linked
*/
function player_pbg_bank_scene_system(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			setpbgactivebank(localclientnum, 1);
			break;
		}
		case 1:
		{
			setpbgactivebank(localclientnum, 2);
			break;
		}
		case 2:
		{
			setpbgactivebank(localclientnum, 4);
			break;
		}
		case 3:
		{
			setpbgactivebank(localclientnum, 8);
			break;
		}
	}
}

/*
	Name: in_igc
	Namespace: scene
	Checksum: 0x62309C44
	Offset: 0x87B8
	Size: 0x272
	Parameters: 7
	Flags: Linked
*/
function in_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_5c10bd79(localclientnum);
	n_entnum = player getentitynumber();
	b_igc_active = 0;
	if(newval & 1 << n_entnum)
	{
		b_igc_active = 1;
	}
	if(b_igc_active)
	{
		setsoundcontext("igc", "on");
		flushsubtitles(localclientnum);
	}
	else
	{
		setsoundcontext("igc", "");
	}
	igcactive(localclientnum, b_igc_active);
	level notify(#"igc_activated", {#b_active:b_igc_active});
	if(isarray(level.var_25e5c959))
	{
		foreach(var_ed8205c6 in level.var_25e5c959)
		{
			a_players = getplayers(localclientnum);
			foreach(player in a_players)
			{
				if(isdefined(player))
				{
					player thread [[var_ed8205c6]](localclientnum, b_igc_active);
				}
			}
		}
	}
	/#
	#/
}

/*
	Name: function_2e58158b
	Namespace: scene
	Checksum: 0x93E33A87
	Offset: 0x8A38
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function function_2e58158b(var_bc148fe3)
{
	if(!isdefined(level.var_25e5c959))
	{
		level.var_25e5c959 = [];
	}
	else if(!isarray(level.var_25e5c959))
	{
		level.var_25e5c959 = array(level.var_25e5c959);
	}
	level.var_25e5c959[level.var_25e5c959.size] = var_bc148fe3;
}

/*
	Name: function_e78401d1
	Namespace: scene
	Checksum: 0xA7559F14
	Offset: 0x8AD8
	Size: 0x2C
	Parameters: 1
	Flags: None
*/
function function_e78401d1(var_bc148fe3)
{
	arrayremovevalue(level.var_25e5c959, var_bc148fe3);
}

/*
	Name: function_f9036ea7
	Namespace: scene
	Checksum: 0x68E80371
	Offset: 0x8B10
	Size: 0xAC
	Parameters: 1
	Flags: Linked
*/
function function_f9036ea7(b_enable)
{
	if(!sessionmodeiscampaigngame())
	{
		return;
	}
	if(b_enable)
	{
		if(!(isdefined(self.var_c7329df1) && self.var_c7329df1))
		{
			self.var_c7329df1 = 1;
			self postfx::playpostfxbundle("pstfx_catseye_cinematic");
		}
	}
	else if(isdefined(self.var_c7329df1) && self.var_c7329df1)
	{
		self.var_c7329df1 = undefined;
		self postfx::stoppostfxbundle("pstfx_catseye_cinematic");
	}
}

/*
	Name: postfx_cateye
	Namespace: scene
	Checksum: 0x6EC55F28
	Offset: 0x8BC8
	Size: 0xB4
	Parameters: 7
	Flags: Linked
*/
function postfx_cateye(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	player = function_5c10bd79(localclientnum);
	level notify(#"sndlevelstartduck_shutoff");
	if(newval)
	{
		player function_f9036ea7(1);
	}
	else
	{
		player function_f9036ea7(0);
	}
}

/*
	Name: on_localplayer_shutdown
	Namespace: scene
	Checksum: 0x8542EF33
	Offset: 0x8C88
	Size: 0xD2
	Parameters: 1
	Flags: Linked, Private
*/
private function on_localplayer_shutdown(localclientnum)
{
	localplayer = self;
	codelocalplayer = function_5c10bd79(localclientnum);
	if(isdefined(localplayer) && isplayer(localplayer))
	{
		if(isdefined(codelocalplayer))
		{
			if(localplayer == codelocalplayer)
			{
				filter::disable_filter_base_frame_transition(localplayer, 5);
				filter::disable_filter_sprite_transition(localplayer, 5);
				filter::disable_filter_frame_transition(localplayer, 5);
				localplayer.postfx_igc_on = undefined;
				localplayer.pstfx_world_construction = 0;
			}
		}
	}
}

/*
	Name: postfx_igc
	Namespace: scene
	Checksum: 0x6EB6FE89
	Offset: 0x8D68
	Size: 0x10F6
	Parameters: 7
	Flags: Linked
*/
function postfx_igc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	if(isdefined(self.postfx_igc_on) && self.postfx_igc_on)
	{
		return;
	}
	if(sessionmodeiszombiesgame())
	{
		postfx_igc_zombies(localclientnum);
		return;
	}
	if(newval == 3)
	{
		self thread postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
		return;
	}
	self.postfx_igc_on = 1;
	codeimagename = "postfx_igc_image" + localclientnum;
	createscenecodeimage(localclientnum, codeimagename);
	captureframe(localclientnum, codeimagename);
	filter::init_filter_base_frame_transition(self);
	filter::init_filter_sprite_transition(self);
	filter::init_filter_frame_transition(self);
	setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
	setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
	setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
	filter::enable_filter_base_frame_transition(self, 5);
	filter::enable_filter_sprite_transition(self, 5);
	filter::enable_filter_frame_transition(self, 5);
	filter::set_filter_base_frame_transition_warp(self, 5, 1);
	filter::set_filter_base_frame_transition_boost(self, 5, 0.5);
	filter::set_filter_base_frame_transition_durden(self, 5, 1);
	filter::set_filter_base_frame_transition_durden_blur(self, 5, 1);
	filter::set_filter_sprite_transition_elapsed(self, 5, 0);
	filter::set_filter_sprite_transition_octogons(self, 5, 1);
	filter::set_filter_sprite_transition_blur(self, 5, 0);
	filter::set_filter_sprite_transition_boost(self, 5, 0);
	filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
	filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
	filter::set_filter_frame_transition_flare(self, 5, 0);
	filter::set_filter_frame_transition_blur(self, 5, 0);
	filter::set_filter_frame_transition_iris(self, 5, 0);
	filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 0);
	filter::set_filter_frame_transition_warp(self, 5, 0);
	filter::set_filter_sprite_transition_move_radii(self, 5, 0, 0);
	filter::set_filter_base_frame_transition_warp(self, 5, 1);
	filter::set_filter_base_frame_transition_boost(self, 5, 1);
	n_hex = 0;
	b_streamer_wait = 1;
	i = 0;
	while(i < 2000)
	{
		st = float(i) / 1000;
		if(b_streamer_wait && st >= 0.65)
		{
			n_streamer_time_total = 0;
			while(!isstreamerready() && n_streamer_time_total < 5000)
			{
				n_streamer_time = gettime();
				j = int(0.65 * 1000);
				while(j < 1150)
				{
					jt = float(j) / 1000;
					filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
					waitframe(1);
					j = j + int(0.016 * 1000);
				}
				j = int(1.15 * 1000);
				while(j < 650)
				{
					jt = float(j) / 1000;
					filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, jt));
					waitframe(1);
					j = j - int(0.016 * 1000);
				}
				n_streamer_time_total = n_streamer_time_total + gettime() - n_streamer_time;
			}
			b_streamer_wait = 0;
		}
		if(st <= 0.5)
		{
			filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
		}
		else if(st > 0.5 && st <= 0.85)
		{
			filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
		}
		else
		{
			filter::set_filter_frame_transition_iris(self, 5, 0);
		}
		if(newval == 2)
		{
			if(st > 1 && (!(isdefined(self.pstfx_world_construction) && self.pstfx_world_construction)))
			{
				self thread postfx::playpostfxbundle(#"pstfx_world_construction");
				self.pstfx_world_construction = 1;
			}
		}
		if(st > 0.5 && st <= 1)
		{
			n_hex = mapfloat(0.5, 1, 0, 1, st);
			filter::set_filter_frame_transition_light_hexagons(self, 5, n_hex);
			if(st >= 0.8)
			{
				filter::set_filter_frame_transition_flare(self, 5, mapfloat(0.8, 1, 0, 1, st));
			}
		}
		else if(st > 1 && st < 1.5)
		{
			filter::set_filter_frame_transition_light_hexagons(self, 5, 1);
			filter::set_filter_frame_transition_flare(self, 5, 1);
		}
		else
		{
			filter::set_filter_frame_transition_light_hexagons(self, 5, 0);
			filter::set_filter_frame_transition_flare(self, 5, 0);
		}
		if(st > 0.65 && st <= 1.15)
		{
			filter::set_filter_frame_transition_heavy_hexagons(self, 5, mapfloat(0.65, 1.15, 0, 1, st));
		}
		else if(st > 1.21 && st < 1.5)
		{
			filter::set_filter_frame_transition_heavy_hexagons(self, 5, 1);
		}
		else
		{
			filter::set_filter_frame_transition_heavy_hexagons(self, 5, 0);
		}
		if(st > 1.21 && st <= 1.5)
		{
			filter::set_filter_frame_transition_blur(self, 5, mapfloat(1, 1.5, 0, 1, st));
			filter::set_filter_sprite_transition_boost(self, 5, mapfloat(1, 1.5, 0, 1, st));
			filter::set_filter_frame_transition_saved_frame_reveal(self, 5, mapfloat(1, 1.5, 0, 1, st));
			filter::set_filter_base_frame_transition_durden_blur(self, 5, 1 - mapfloat(1, 1.5, 0, 1, st));
			filter::set_filter_sprite_transition_blur(self, 5, mapfloat(1, 1.5, 0, 0.1, st));
		}
		else if(st > 1.5)
		{
			filter::set_filter_frame_transition_blur(self, 5, 1);
			filter::set_filter_sprite_transition_boost(self, 5, 1);
			filter::set_filter_frame_transition_saved_frame_reveal(self, 5, 1);
			filter::set_filter_base_frame_transition_durden_blur(self, 5, 0);
			filter::set_filter_sprite_transition_blur(self, 5, 0.1);
		}
		if(st > 1 && st <= 1.45)
		{
			filter::set_filter_base_frame_transition_boost(self, 5, mapfloat(1, 1.45, 0.5, 1, st));
		}
		else if(st > 1.45 && st < 1.75)
		{
			filter::set_filter_base_frame_transition_boost(self, 5, 1);
		}
		else if(st >= 1.75)
		{
			filter::set_filter_base_frame_transition_boost(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
		}
		if(st >= 1.75)
		{
			val = 1 - mapfloat(1.75, 2, 0, 1, st);
			filter::set_filter_frame_transition_blur(self, 5, val);
			filter::set_filter_base_frame_transition_warp(self, 5, val);
		}
		if(st >= 1.25)
		{
			val = 1 - mapfloat(1.25, 1.75, 0, 1, st);
			filter::set_filter_sprite_transition_octogons(self, 5, val);
		}
		if(st >= 1.75 && st < 2)
		{
			filter::set_filter_base_frame_transition_durden(self, 5, 1 - mapfloat(1.75, 2, 0, 1, st));
		}
		if(st > 1)
		{
			filter::set_filter_sprite_transition_elapsed(self, 5, i - 1000);
			outer_radii = mapfloat(1, 1.5, 0, 2000, st);
			filter::set_filter_sprite_transition_move_radii(self, 5, outer_radii - 256, outer_radii);
		}
		if(st > 1.15 && st < 1.85)
		{
			filter::set_filter_frame_transition_warp(self, 5, -1 * mapfloat(1.15, 1.85, 0, 1, st));
		}
		else if(st >= 1.85)
		{
			filter::set_filter_frame_transition_warp(self, 5, -1 * 1 - mapfloat(1.85, 2, 0, 1, st));
		}
		waitframe(1);
		i = i + int(0.016 * 1000);
	}
	filter::disable_filter_base_frame_transition(self, 5);
	filter::disable_filter_sprite_transition(self, 5);
	filter::disable_filter_frame_transition(self, 5);
	self.pstfx_world_construction = 0;
	freecodeimage(localclientnum, codeimagename);
	self.postfx_igc_on = undefined;
}

/*
	Name: postfx_igc_zombies
	Namespace: scene
	Checksum: 0x42846844
	Offset: 0x9E68
	Size: 0x56
	Parameters: 1
	Flags: Linked
*/
function postfx_igc_zombies(localclientnum)
{
	self lui::screen_fade_out(0, "black");
	waitframe(1);
	self lui::screen_fade_in(0.3);
	self.postfx_igc_on = undefined;
}

/*
	Name: postfx_igc_short
	Namespace: scene
	Checksum: 0x65B7497A
	Offset: 0x9EC8
	Size: 0x396
	Parameters: 7
	Flags: Linked
*/
function postfx_igc_short(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	self endon(#"death");
	self.postfx_igc_on = 1;
	codeimagename = "postfx_igc_image" + localclientnum;
	createscenecodeimage(localclientnum, codeimagename);
	captureframe(localclientnum, codeimagename);
	filter::init_filter_base_frame_transition(self);
	filter::init_filter_sprite_transition(self);
	filter::init_filter_frame_transition(self);
	setfilterpasscodetexture(localclientnum, 5, 0, 0, codeimagename);
	setfilterpasscodetexture(localclientnum, 5, 1, 0, codeimagename);
	setfilterpasscodetexture(localclientnum, 5, 2, 0, codeimagename);
	filter::enable_filter_base_frame_transition(self, 5);
	filter::enable_filter_sprite_transition(self, 5);
	filter::enable_filter_frame_transition(self, 5);
	filter::set_filter_frame_transition_iris(self, 5, 0);
	b_streamer_wait = 1;
	i = 0;
	while(i < 850)
	{
		st = float(i) / 1000;
		if(st <= 0.5)
		{
			filter::set_filter_frame_transition_iris(self, 5, mapfloat(0, 0.5, 0, 1, st));
		}
		else if(st > 0.5 && st <= 0.85)
		{
			filter::set_filter_frame_transition_iris(self, 5, 1 - mapfloat(0.5, 0.85, 0, 1, st));
		}
		else
		{
			filter::set_filter_frame_transition_iris(self, 5, 0);
		}
		waitframe(1);
		i = i + int(0.016 * 1000);
	}
	filter::disable_filter_base_frame_transition(self, 5);
	filter::disable_filter_sprite_transition(self, 5);
	filter::disable_filter_frame_transition(self, 5);
	freecodeimage(localclientnum, codeimagename);
	self.postfx_igc_on = undefined;
}

/*
	Name: cf_server_sync
	Namespace: scene
	Checksum: 0x159EAB14
	Offset: 0xA268
	Size: 0x1CA
	Parameters: 7
	Flags: Linked
*/
function cf_server_sync(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump)
{
	switch(newval)
	{
		case 0:
		{
			if(is_active(fieldname))
			{
				level thread stop(fieldname);
			}
			break;
		}
		case 1:
		{
			level thread init(fieldname);
			break;
		}
		case 2:
		{
			level thread play(fieldname);
			break;
		}
	}
	/#
		switch(newval)
		{
			case 3:
			{
				if(is_active(fieldname))
				{
					level thread stop(fieldname, 1, undefined, undefined, 1);
				}
				break;
			}
			case 4:
			{
				level thread init(fieldname, undefined, undefined, 1);
				break;
			}
			case 5:
			{
				level thread play(fieldname, undefined, undefined, 1);
				break;
			}
		}
	#/
}

/*
	Name: remove_invalid_scene_objects
	Namespace: scene
	Checksum: 0x54AEE2DC
	Offset: 0xA440
	Size: 0x15A
	Parameters: 1
	Flags: Linked
*/
function remove_invalid_scene_objects(s_scenedef)
{
	a_invalid_object_indexes = [];
	if(isdefined(s_scenedef.objects))
	{
		foreach(i, s_object in s_scenedef.objects)
		{
			if(!isdefined(s_object.name) && !isdefined(s_object.model))
			{
				if(!isdefined(a_invalid_object_indexes))
				{
					a_invalid_object_indexes = [];
				}
				else if(!isarray(a_invalid_object_indexes))
				{
					a_invalid_object_indexes = array(a_invalid_object_indexes);
				}
				a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
			}
		}
	}
	for(i = a_invalid_object_indexes.size - 1; i >= 0; i--)
	{
		arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
	}
	return s_scenedef;
}

/*
	Name: function_585fb738
	Namespace: scene
	Checksum: 0xBC17192B
	Offset: 0xA5A8
	Size: 0xCA
	Parameters: 2
	Flags: Linked
*/
function function_585fb738(str_scene, var_79fe29db)
{
	if(isdefined(str_scene))
	{
		s_bundle = getscriptbundle(str_scene);
	}
	else
	{
		s_bundle = self;
		str_scene = s_bundle.name;
	}
	if(isdefined(s_bundle.igc) && s_bundle.igc)
	{
		return;
	}
	if(function_7aa3d2c6(str_scene) || get_player_count(str_scene) || (isdefined(var_79fe29db) && var_79fe29db))
	{
		s_bundle.igc = 1;
	}
}

/*
	Name: is_igc
	Namespace: scene
	Checksum: 0x2B001936
	Offset: 0xA680
	Size: 0x18
	Parameters: 0
	Flags: Linked
*/
function is_igc()
{
	return isdefined(self.igc) && self.igc;
}

/*
	Name: __main__
	Namespace: scene
	Checksum: 0xA91CC9D4
	Offset: 0xA6A0
	Size: 0x4E0
	Parameters: 0
	Flags: Linked
*/
function __main__()
{
	waitframe(1);
	if(isdefined(level.disablefxaniminsplitscreencount))
	{
		if(isdefined(level.localplayers))
		{
			if(level.localplayers.size >= level.disablefxaniminsplitscreencount)
			{
				return;
			}
		}
	}
	a_instances = arraycombine(struct::get_array("scriptbundle_scene", "classname"), struct::get_array("scriptbundle_fxanim", "classname"), 0, 0);
	foreach(s_instance in a_instances)
	{
		s_scenedef = getscriptbundle(s_instance.scriptbundlename);
		if(s_scenedef.vmtype !== "client")
		{
			continue;
		}
		if(isdefined(s_instance.scriptgroup_initscenes))
		{
			trigs = getentarray(0, s_instance.scriptgroup_initscenes, "scriptgroup_initscenes");
			if(isdefined(trigs))
			{
				foreach(trig in trigs)
				{
					s_instance thread _trigger_init(trig);
				}
			}
		}
		if(isdefined(s_instance.scriptgroup_playscenes))
		{
			trigs = getentarray(0, s_instance.scriptgroup_playscenes, "scriptgroup_playscenes");
			if(isdefined(trigs))
			{
				foreach(trig in trigs)
				{
					s_instance thread _trigger_play(trig);
				}
			}
		}
		if(isdefined(s_instance.scriptgroup_stopscenes))
		{
			trigs = getentarray(0, s_instance.scriptgroup_stopscenes, "scriptgroup_stopscenes");
			if(isdefined(trigs))
			{
				foreach(trig in trigs)
				{
					s_instance thread _trigger_stop(trig);
				}
			}
		}
	}
	foreach(s_instance in a_instances)
	{
		s_scenedef = get_scenedef(s_instance.scriptbundlename);
		/#
			assert(isdefined(s_scenedef), "" + s_instance.origin + "" + s_instance.scriptbundlename + "");
		#/
		if(s_scenedef.vmtype === "client")
		{
			if(isdefined(s_instance.spawnflags) && s_instance.spawnflags & 2 == 2)
			{
				s_instance thread play();
				continue;
			}
			if(isdefined(s_instance.spawnflags) && s_instance.spawnflags & 1 == 1)
			{
				s_instance thread init();
			}
		}
	}
}

/*
	Name: _trigger_init
	Namespace: scene
	Checksum: 0x637DB7CC
	Offset: 0xAB88
	Size: 0xBC
	Parameters: 1
	Flags: Linked
*/
function _trigger_init(trig)
{
	trig endon(#"death");
	var_be17187b = undefined;
	var_be17187b = trig waittill(#"trigger");
	a_ents = [];
	if(get_player_count(self.scriptbundlename) > 0)
	{
		if(isplayer(var_be17187b.activator))
		{
			a_ents[0] = var_be17187b.activator;
		}
	}
	self thread init(a_ents);
}

/*
	Name: _trigger_play
	Namespace: scene
	Checksum: 0x1ECCEC55
	Offset: 0xAC50
	Size: 0x108
	Parameters: 1
	Flags: Linked
*/
function _trigger_play(trig)
{
	trig endon(#"death");
	do
	{
		var_be17187b = undefined;
		var_be17187b = trig waittill(#"trigger");
		a_ents = [];
		if(get_player_count(self.scriptbundlename) > 0)
		{
			if(isplayer(var_be17187b.activator))
			{
				a_ents[0] = var_be17187b.activator;
			}
		}
		self thread play(a_ents);
	}
	while(isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping);
}

/*
	Name: _trigger_stop
	Namespace: scene
	Checksum: 0xBFF58968
	Offset: 0xAD60
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function _trigger_stop(trig)
{
	trig endon(#"death");
	trig waittill(#"trigger");
	self thread stop();
}

/*
	Name: add_scene_func
	Namespace: scene
	Checksum: 0xE27CE2D4
	Offset: 0xADC0
	Size: 0x184
	Parameters: 4
	Flags: Linked, Variadic
*/
function add_scene_func(str_scenedef, func, var_e21c4c4c = "play", vararg)
{
	/#
		/#
			assert(isdefined(getscriptbundle(str_scenedef)), "" + function_9e72a96(str_scenedef) + "");
		#/
	#/
	var_e21c4c4c = tolower(var_e21c4c4c);
	if(!isdefined(level.scene_funcs))
	{
		level.scene_funcs = [];
	}
	if(!isdefined(level.scene_funcs[str_scenedef]))
	{
		level.scene_funcs[str_scenedef] = [];
	}
	str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
	if(!isdefined(level.scene_funcs[str_scenedef][str_shot]))
	{
		level.scene_funcs[str_scenedef][str_shot] = [];
	}
	array::add(level.scene_funcs[str_scenedef][str_shot], array(func, vararg), 0);
}

/*
	Name: remove_scene_func
	Namespace: scene
	Checksum: 0xFA1E6887
	Offset: 0xAF50
	Size: 0x18E
	Parameters: 3
	Flags: None
*/
function remove_scene_func(str_scenedef, func, var_e21c4c4c = "play")
{
	/#
		/#
			assert(isdefined(getscriptbundle(str_scenedef)), "" + str_scenedef + "");
		#/
	#/
	var_e21c4c4c = tolower(var_e21c4c4c);
	if(!isdefined(level.scene_funcs))
	{
		level.scene_funcs = [];
	}
	str_shot = function_c776e5bd(str_scenedef, var_e21c4c4c);
	if(isdefined(level.scene_funcs[str_scenedef]) && isdefined(level.scene_funcs[str_scenedef][str_shot]))
	{
		for(i = level.scene_funcs[str_scenedef][str_shot].size - 1; i >= 0; i--)
		{
			if(level.scene_funcs[str_scenedef][str_shot][i][0] == func)
			{
				arrayremoveindex(level.scene_funcs[str_scenedef][str_shot], i);
			}
		}
	}
}

/*
	Name: function_c776e5bd
	Namespace: scene
	Checksum: 0x77E4E9E6
	Offset: 0xB0E8
	Size: 0x92
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c776e5bd(str_scenedef, str_state)
{
	str_shot = str_state;
	if(str_state == "init")
	{
		str_shot = function_de6a7579(str_scenedef, "init");
	}
	else if(str_state == "play")
	{
		str_shot = function_de6a7579(str_scenedef, "play");
	}
	return str_shot;
}

/*
	Name: spawn
	Namespace: scene
	Checksum: 0xBA1D4990
	Offset: 0xB188
	Size: 0x178
	Parameters: 5
	Flags: None
*/
function spawn(arg1, arg2, arg3, arg4, b_test_run)
{
	str_scenedef = arg1;
	/#
		assert(isdefined(str_scenedef), "");
	#/
	if(isvec(arg2))
	{
		v_origin = arg2;
		v_angles = arg3;
		a_ents = arg4;
	}
	else
	{
		a_ents = arg2;
		v_origin = arg3;
		v_angles = arg4;
	}
	s_instance = spawnstruct();
	s_instance.origin = (isdefined(v_origin) ? v_origin : (0, 0, 0));
	s_instance.angles = (isdefined(v_angles) ? v_angles : (0, 0, 0));
	s_instance.classname = "scriptbundle_scene";
	s_instance.scriptbundlename = str_scenedef;
	s_instance struct::init();
	s_instance init(str_scenedef, a_ents, undefined, b_test_run);
	return s_instance;
}

/*
	Name: init
	Namespace: scene
	Checksum: 0x38C9E4F5
	Offset: 0xB308
	Size: 0x54
	Parameters: 4
	Flags: Linked
*/
function init(arg1, arg2, arg3, b_test_run)
{
	self thread play(arg1, arg2, arg3, b_test_run, "init");
}

/*
	Name: get_scenedef
	Namespace: scene
	Checksum: 0x1EB0311A
	Offset: 0xB368
	Size: 0xA2
	Parameters: 1
	Flags: Linked
*/
function get_scenedef(str_scenedef)
{
	s_scriptbundle = getscriptbundle(str_scenedef);
	/#
		/#
			assert(isdefined(s_scriptbundle) && isdefined(s_scriptbundle.objects), "" + function_9e72a96(str_scenedef) + "");
		#/
	#/
	s_scriptbundle = fixup_scenedef(s_scriptbundle);
	return s_scriptbundle;
}

/*
	Name: get_scenedefs
	Namespace: scene
	Checksum: 0x93E305A7
	Offset: 0xB418
	Size: 0x150
	Parameters: 1
	Flags: None
*/
function get_scenedefs(str_type = "scene")
{
	a_scenedefs = [];
	foreach(str_scenedef in level.scenedefs)
	{
		s_scenedef = getscriptbundle(str_scenedef);
		if(s_scenedef.scenetype === str_type && s_scenedef.vmtype === "client")
		{
			s_scenedef = fixup_scenedef(s_scenedef);
			if(!isdefined(a_scenedefs))
			{
				a_scenedefs = [];
			}
			else if(!isarray(a_scenedefs))
			{
				a_scenedefs = array(a_scenedefs);
			}
			a_scenedefs[a_scenedefs.size] = s_scenedef;
		}
	}
	return a_scenedefs;
}

/*
	Name: fixup_scenedef
	Namespace: scene
	Checksum: 0x4B16E107
	Offset: 0xB570
	Size: 0x860
	Parameters: 1
	Flags: Linked
*/
function fixup_scenedef(s_scenedef)
{
	/#
		assert(isdefined(s_scenedef.objects), "");
	#/
	if(isdefined(s_scenedef.objects[0]) && isdefined(s_scenedef.objects[0].shots))
	{
		return s_scenedef;
	}
	if(!isdefined(s_scenedef.ready_to_use))
	{
		s_scenedef.ready_to_use = 1;
	}
	else
	{
		return s_scenedef;
	}
	a_invalid_object_indexes = [];
	foreach(i, s_object in s_scenedef.objects)
	{
		if(!isdefined(s_object.name) && !isdefined(s_object.model) && !s_object.type === "player")
		{
			if(!isdefined(a_invalid_object_indexes))
			{
				a_invalid_object_indexes = [];
			}
			else if(!isarray(a_invalid_object_indexes))
			{
				a_invalid_object_indexes = array(a_invalid_object_indexes);
			}
			a_invalid_object_indexes[a_invalid_object_indexes.size] = i;
		}
	}
	for(i = a_invalid_object_indexes.size - 1; i >= 0; i--)
	{
		arrayremoveindex(s_scenedef.objects, a_invalid_object_indexes[i]);
	}
	s_scenedef.editaction = undefined;
	s_scenedef.newobject = undefined;
	if(isstring(s_scenedef.femalebundle) || function_7a600918(s_scenedef.femalebundle))
	{
		s_female_bundle = struct::get_script_bundle("scene", s_scenedef.femalebundle);
		s_female_bundle.malebundle = s_scenedef.name;
		s_scenedef.s_female_bundle = s_female_bundle;
		s_female_bundle.s_male_bundle = s_scenedef;
	}
	if(isdefined(level.scene_sequence_names) && !isdefined(level.scene_sequence_names[s_scenedef.name]))
	{
		s_next_bundle = s_scenedef;
		while(isdefined(s_next_bundle))
		{
			level.scene_sequence_names[s_next_bundle.name] = s_scenedef.name;
			if(isdefined(s_next_bundle.nextscenebundle))
			{
				s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
			}
			else
			{
				s_next_bundle = undefined;
			}
		}
	}
	else
	{
		level.scene_streamer_ignore[s_scenedef.name] = 1;
	}
	if(isstring(s_scenedef.nextscenebundle) || function_7a600918(s_scenedef.nextscenebundle))
	{
		s_next_bundle = s_scenedef;
		while(isdefined(s_next_bundle))
		{
			if(isdefined(s_next_bundle.nextscenebundle))
			{
				s_next_bundle = getscriptbundle(s_next_bundle.nextscenebundle);
			}
			else
			{
				s_next_bundle = undefined;
			}
			if(isdefined(s_next_bundle))
			{
				s_scenedef.str_final_bundle = s_next_bundle.name;
			}
		}
		foreach(s_object in s_scenedef.objects)
		{
			if(s_object.type === "player")
			{
				s_object.disabletransitionout = 1;
			}
		}
		s_next_bundle = struct::get_script_bundle("scene", s_scenedef.nextscenebundle);
		s_scenedef.next_bundle = s_next_bundle;
		s_next_bundle.dontsync = 1;
		s_next_bundle.dontthrottle = 1;
		foreach(s_object in s_next_bundle.objects)
		{
			if(s_object.type === "player")
			{
				s_object.disabletransitionin = 1;
			}
			s_object.iscutscene = 1;
		}
		if(isdefined(s_next_bundle.femalebundle))
		{
			s_next_female_bundle = struct::get_script_bundle("scene", s_next_bundle.femalebundle);
			if(isdefined(s_next_female_bundle))
			{
				s_next_female_bundle.dontsync = 1;
				s_next_female_bundle.dontthrottle = 1;
				foreach(s_object in s_next_female_bundle.objects)
				{
					if(s_object.type === "player")
					{
						s_object.disabletransitionin = 1;
					}
					s_object.iscutscene = 1;
				}
			}
		}
	}
	foreach(s_object in s_scenedef.objects)
	{
		if(s_object.type === "player")
		{
			if(!isdefined(s_object.cameratween))
			{
				s_object.cameratween = 0;
			}
			s_object.newplayermethod = 1;
			if(isdefined(s_object.sharedigc) && s_object.sharedigc)
			{
				s_object.type = "sharedplayer";
			}
		}
		if(s_object.type !== "player" && s_object.type !== "sharedplayer")
		{
			s_object.cameraswitcher = undefined;
		}
		s_object.player = undefined;
		if(s_object.type === "player model")
		{
			s_object.type = "fakeplayer";
		}
	}
	if(isstring(s_scenedef.cameraswitcher) || isstring(s_scenedef.extracamswitcher1) || isstring(s_scenedef.extracamswitcher2) || isstring(s_scenedef.extracamswitcher3) || isstring(s_scenedef.extracamswitcher4))
	{
		s_scenedef.igc = 1;
	}
	convert_to_new_format(s_scenedef);
	return s_scenedef;
}

/*
	Name: function_ceb43448
	Namespace: scene
	Checksum: 0xA5BD15F6
	Offset: 0xBDD8
	Size: 0x1E4
	Parameters: 4
	Flags: Linked
*/
function function_ceb43448(var_5e3936e3, var_651e3856, str_field, var_8e9b7b3d)
{
	var_5e3936e3--;
	var_651e3856--;
	if(!isdefined(self.shots))
	{
		self.shots = [];
	}
	if(!isdefined(self.shots[0]))
	{
		self.shots[0] = spawnstruct();
	}
	if(!isdefined(self.shots[0].entry))
	{
		self.shots[0].entry = [];
	}
	if(!isdefined(self.shots[0].entry[0]))
	{
		self.shots[0].entry[0] = spawnstruct();
	}
	if(!isdefined(self.shots[var_5e3936e3]))
	{
		self.shots[var_5e3936e3] = spawnstruct();
		self.shots[var_5e3936e3].entry = [];
		self.shots[var_5e3936e3].entry[0] = spawnstruct();
	}
	if(!isdefined(self.shots[var_5e3936e3].entry[var_651e3856]))
	{
		self.shots[var_5e3936e3].entry[var_651e3856] = spawnstruct();
	}
	self.shots[var_5e3936e3].entry[var_651e3856].(str_field) = var_8e9b7b3d;
}

/*
	Name: function_de24d5c1
	Namespace: scene
	Checksum: 0xF414106A
	Offset: 0xBFC8
	Size: 0x4A
	Parameters: 2
	Flags: Linked
*/
function function_de24d5c1(n_shot, str_shot_name)
{
	n_shot--;
	if(isdefined(self.shots[n_shot]))
	{
		self.shots[n_shot].name = str_shot_name;
	}
}

/*
	Name: function_77e159df
	Namespace: scene
	Checksum: 0xD001BA
	Offset: 0xC020
	Size: 0xF0
	Parameters: 3
	Flags: Linked
*/
function function_77e159df(var_9b4eba84, str_field, var_8e9b7b3d)
{
	if(isstruct(var_9b4eba84))
	{
		var_9b4eba84.(str_field) = var_8e9b7b3d;
	}
	else
	{
		var_9b4eba84--;
		if(!isdefined(self.shots))
		{
			self.shots = [];
		}
		if(!isdefined(self.shots[0]))
		{
			self.shots[0] = spawnstruct();
		}
		if(!isdefined(self.shots[var_9b4eba84]))
		{
			self.shots[var_9b4eba84] = spawnstruct();
		}
		self.shots[var_9b4eba84].(str_field) = var_8e9b7b3d;
	}
}

/*
	Name: convert_to_new_format
	Namespace: scene
	Checksum: 0x39057EC4
	Offset: 0xC118
	Size: 0x802
	Parameters: 1
	Flags: Linked
*/
function convert_to_new_format(s_scenedef)
{
	foreach(s_object in s_scenedef.objects)
	{
		s_object.old_scene_version = 1;
		b_has_init = 0;
		b_has_main = 0;
		b_has_camera = 0;
		if(isdefined(s_object.firstframe) && s_object.firstframe)
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 1, "anim", s_object.mainanim);
		}
		else if(isdefined(s_object.initanim))
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 1, "anim", s_object.initanim);
		}
		if(isdefined(s_object.initanimloop))
		{
			b_has_init = 1;
			s_object function_ceb43448(1, 2, "anim", s_object.initanimloop);
		}
		if(isdefined(s_object.spawnoninit) && s_object.spawnoninit)
		{
			b_has_init = 1;
		}
		if(isdefined(s_object.cameraswitcher))
		{
			b_has_main = 1;
			b_has_camera = 1;
			s_scenedef.igc = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 1, "cameraswitcher", s_object.cameraswitcher);
			}
			else
			{
				s_object function_ceb43448(1, 1, "cameraswitcher", s_object.cameraswitcher);
			}
		}
		if(!isdefined(s_object.mainblend))
		{
			s_object.mainblend = 0.02;
		}
		b_has_main = 1;
		if(b_has_init)
		{
			if(b_has_camera)
			{
				s_object function_ceb43448(2, 2, "blend", s_object.mainblend);
			}
			else
			{
				s_object function_ceb43448(2, 1, "blend", s_object.mainblend);
			}
		}
		else if(b_has_camera)
		{
			s_object function_ceb43448(1, 2, "blend", s_object.mainblend);
		}
		else
		{
			s_object function_ceb43448(1, 1, "blend", s_object.mainblend);
		}
		if(isdefined(s_object.mainanim))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				if(b_has_camera)
				{
					s_object function_ceb43448(2, 3, "anim", s_object.mainanim);
				}
				else
				{
					s_object function_ceb43448(2, 2, "anim", s_object.mainanim);
				}
			}
			else if(b_has_camera)
			{
				s_object function_ceb43448(1, 3, "anim", s_object.mainanim);
			}
			else
			{
				s_object function_ceb43448(1, 2, "anim", s_object.mainanim);
			}
		}
		if(isdefined(s_object.endblend))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 3, "blend", s_object.endblend);
			}
			else
			{
				s_object function_ceb43448(1, 3, "blend", s_object.endblend);
			}
		}
		if(isdefined(s_object.endanim))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 4, "anim", s_object.endanim);
			}
			else
			{
				s_object function_ceb43448(1, 4, "anim", s_object.endanim);
			}
		}
		if(isdefined(s_object.endanimloop))
		{
			b_has_main = 1;
			if(b_has_init)
			{
				s_object function_ceb43448(2, 5, "anim", s_object.endanimloop);
			}
			else
			{
				s_object function_ceb43448(1, 5, "anim", s_object.endanimloop);
			}
		}
		if(b_has_init)
		{
			s_object function_de24d5c1(1, "init");
			var_88263c0e = s_object.shots[0];
			if(isdefined(s_object.initdelaymin))
			{
				s_object function_77e159df(var_88263c0e, "SpacerMin", s_object.initdelaymin);
			}
			if(isdefined(s_object.initdelaymax))
			{
				s_object function_77e159df(var_88263c0e, "SpacerMax", s_object.initdelaymax);
			}
		}
		if(b_has_main)
		{
			if(b_has_init)
			{
				s_object function_de24d5c1(2, "play");
				var_992efde = s_object.shots[1];
			}
			else
			{
				s_object function_de24d5c1(1, "play");
				var_992efde = s_object.shots[0];
			}
			if(isdefined(s_object.maindelaymin))
			{
				s_object function_77e159df(var_992efde, "SpacerMin", s_object.maindelaymin);
			}
			if(isdefined(s_object.maindelaymax))
			{
				s_object function_77e159df(var_992efde, "SpacerMax", s_object.maindelaymax);
			}
		}
		s_object.initanim = undefined;
		s_object.initanimloop = undefined;
		s_object.mainblend = undefined;
		s_object.mainanim = undefined;
		s_object.endblend = undefined;
		s_object.endanim = undefined;
		s_object.endanimloop = undefined;
		s_object.initdelaymin = undefined;
		s_object.initdelaymax = undefined;
		s_object.maindelaymin = undefined;
		s_object.maindelaymax = undefined;
	}
	s_scenedef.old_scene_version = 1;
}

/*
	Name: function_8d8ec9b5
	Namespace: scene
	Checksum: 0xC9C8220A
	Offset: 0xC928
	Size: 0xB2
	Parameters: 3
	Flags: None
*/
function function_8d8ec9b5(str_scenedef, var_b5d05f70, s_instance)
{
	if(isdefined(s_instance))
	{
		s_instance.var_b5d05f70 = var_b5d05f70;
		s_instance.var_418c40ac = var_b5d05f70[var_b5d05f70.size - 1];
	}
	else
	{
		s_scenedef = get_scenedef(str_scenedef);
		s_scenedef.var_b5d05f70 = var_b5d05f70;
		level.var_1e798f4c[str_scenedef] = var_b5d05f70;
		s_scenedef.var_418c40ac = var_b5d05f70[var_b5d05f70.size - 1];
	}
}

/*
	Name: get_all_shot_names
	Namespace: scene
	Checksum: 0x7D9C4A94
	Offset: 0xC9E8
	Size: 0x330
	Parameters: 3
	Flags: Linked
*/
function get_all_shot_names(str_scenedef, s_instance, var_8c4d2266 = 0)
{
	if(isdefined(s_instance) && isdefined(s_instance.var_b5d05f70))
	{
		a_shots = s_instance.var_b5d05f70;
		if(var_8c4d2266)
		{
			arrayremovevalue(a_shots, "init");
		}
		return a_shots;
	}
	if(isdefined(level.var_1e798f4c) && isdefined(level.var_1e798f4c[str_scenedef]))
	{
		a_shots = level.var_1e798f4c[str_scenedef];
		if(var_8c4d2266)
		{
			arrayremovevalue(a_shots, "init");
		}
		return a_shots;
	}
	s_scenedef = get_scenedef(str_scenedef);
	if(isdefined(s_scenedef.var_b5d05f70))
	{
		a_shots = s_scenedef.var_b5d05f70;
		if(var_8c4d2266)
		{
			arrayremovevalue(a_shots, "init");
		}
		return s_scenedef.var_b5d05f70;
	}
	a_shots = [];
	foreach(s_object in s_scenedef.objects)
	{
		if(!(isdefined(s_object.disabled) && s_object.disabled) && isdefined(s_object.shots))
		{
			foreach(s_shot in s_object.shots)
			{
				if(!isdefined(a_shots))
				{
					a_shots = [];
				}
				else if(!isarray(a_shots))
				{
					a_shots = array(a_shots);
				}
				if(!isinarray(a_shots, s_shot.name))
				{
					a_shots[a_shots.size] = s_shot.name;
				}
			}
		}
	}
	s_scenedef.var_b5d05f70 = a_shots;
	s_scenedef.var_418c40ac = a_shots[a_shots.size - 1];
	if(var_8c4d2266)
	{
		arrayremovevalue(a_shots, "init");
	}
	return a_shots;
}

/*
	Name: function_b260bdcc
	Namespace: scene
	Checksum: 0xA7182B39
	Offset: 0xCD20
	Size: 0xBE
	Parameters: 3
	Flags: Linked
*/
function function_b260bdcc(str_scenedef, str_shot, s_instance)
{
	var_418c40ac = function_c9770402(str_scenedef, s_instance);
	s_scenedef = get_scenedef(str_scenedef);
	if(str_shot !== "init" && (str_shot === var_418c40ac || (isdefined(s_scenedef.old_scene_version) && s_scenedef.old_scene_version && str_shot === "play")))
	{
		return 1;
	}
	return 0;
}

/*
	Name: function_c9770402
	Namespace: scene
	Checksum: 0x8105A530
	Offset: 0xCDE8
	Size: 0x13C
	Parameters: 2
	Flags: Linked
*/
function function_c9770402(str_scenedef, s_instance)
{
	if(isdefined(s_instance) && isdefined(s_instance.var_418c40ac))
	{
		return s_instance.var_418c40ac;
	}
	if(isdefined(level.var_1e798f4c) && isdefined(level.var_1e798f4c[str_scenedef]))
	{
		a_shots = level.var_1e798f4c[str_scenedef];
		return a_shots[a_shots.size - 1];
	}
	s_scenedef = get_scenedef(str_scenedef);
	if(isdefined(s_scenedef.str_final_bundle))
	{
		return s_scenedef.str_final_bundle;
	}
	if(isdefined(s_scenedef.var_418c40ac))
	{
		return s_scenedef.var_418c40ac;
	}
	a_shots = get_all_shot_names(str_scenedef, s_instance);
	s_scenedef.var_418c40ac = a_shots[a_shots.size - 1];
	return a_shots[a_shots.size - 1];
}

/*
	Name: _init_instance
	Namespace: scene
	Checksum: 0xA009FDE9
	Offset: 0xCF30
	Size: 0x1D8
	Parameters: 3
	Flags: Linked
*/
function _init_instance(str_scenedef = self.scriptbundlename, a_ents, b_test_run = 0)
{
	s_bundle = get_scenedef(str_scenedef);
	if(!isdefined(s_bundle) || !function_6f382548(s_bundle, str_scenedef))
	{
		return;
	}
	/#
		/#
			assert(isdefined(str_scenedef), "" + (isdefined(self.origin) ? self.origin : "") + "");
		#/
		/#
			assert(isdefined(s_bundle), "" + (isdefined(self.origin) ? self.origin : "") + "" + str_scenedef + "");
		#/
	#/
	o_scene = get_active_scene(str_scenedef);
	if(isdefined(o_scene))
	{
		if(isdefined(self.scriptbundlename) && !b_test_run)
		{
			return o_scene;
		}
		thread [[ o_scene ]]->initialize(1);
	}
	else
	{
		object = new cscene();
		[[ object ]]->__constructor();
		o_scene = object;
		[[ o_scene ]]->init(str_scenedef, s_bundle, self, a_ents, b_test_run);
	}
	return o_scene;
}

/*
	Name: function_6f382548
	Namespace: scene
	Checksum: 0xB1CF6B68
	Offset: 0xD110
	Size: 0x1DC
	Parameters: 2
	Flags: Linked
*/
function function_6f382548(struct, str_scene_name)
{
	if(!isdefined(struct.var_87403372) || !(getdvarint(#"splitscreen_playercount", 1) > 1))
	{
		return 1;
	}
	if(struct.var_87403372 == 2 && getdvarint(#"splitscreen_playercount", 1) > 1 || (struct.var_87403372 == 3 && getdvarint(#"splitscreen_playercount", 1) > 2) || (struct.var_87403372 == 4 && getdvarint(#"splitscreen_playercount", 1) > 3))
	{
		/#
			if(struct.type === "")
			{
				str_debug = "" + function_9e72a96(str_scene_name) + "";
			}
			else
			{
				str_debug = "" + function_9e72a96(struct.name) + "" + str_scene_name + "";
			}
			println(str_debug);
		#/
		return 0;
	}
	return 1;
}

/*
	Name: function_de6a7579
	Namespace: scene
	Checksum: 0x73FE8973
	Offset: 0xD2F8
	Size: 0x11A
	Parameters: 3
	Flags: Linked
*/
function function_de6a7579(str_scenedef, str_mode, s_instance)
{
	a_shots = get_all_shot_names(str_scenedef, s_instance);
	if(a_shots.size == 0)
	{
		return "play";
	}
	if(str_mode !== "init")
	{
		if(a_shots[0] !== "init")
		{
			str_shot = a_shots[0];
		}
		else if(a_shots.size > 1)
		{
			str_shot = a_shots[1];
		}
	}
	else if(str_mode === "init")
	{
		if(isinarray(a_shots, "init"))
		{
			str_shot = "init";
		}
		else
		{
			str_shot = a_shots[0];
		}
	}
	if(!isdefined(str_shot))
	{
		str_shot = "play";
	}
	return str_shot;
}

/*
	Name: play_from_time
	Namespace: scene
	Checksum: 0x5B3A8F07
	Offset: 0xD420
	Size: 0x8C
	Parameters: 5
	Flags: None
*/
function play_from_time(arg1, arg2, arg3, n_time, var_c9d6bbb = 1)
{
	if(var_c9d6bbb)
	{
		str_mode = "play_from_time_normalized";
	}
	else
	{
		str_mode = "play_from_time_elapsed";
	}
	play(arg1, arg2, arg3, 0, str_mode, n_time);
}

/*
	Name: function_d1abba8b
	Namespace: scene
	Checksum: 0x7094F2A3
	Offset: 0xD4B8
	Size: 0xB2
	Parameters: 3
	Flags: Linked
*/
function function_d1abba8b(str_scenedef, str_mode, n_time)
{
	if(issubstr(str_mode, "play_from_time_normalized"))
	{
		var_f3f679dd = float(n_time) * function_12479eba(str_scenedef);
	}
	else
	{
		var_f3f679dd = float(n_time);
	}
	var_8b21886e = function_dde5f483(str_scenedef, var_f3f679dd);
	return var_8b21886e;
}

/*
	Name: function_1eab8670
	Namespace: scene
	Checksum: 0x4DF6B17
	Offset: 0xD578
	Size: 0x1F2
	Parameters: 2
	Flags: Linked
*/
function function_1eab8670(obj, str_shot)
{
	var_5a162d58 = 0;
	n_anim_length = 0;
	if(isdefined(obj.shots))
	{
		foreach(s_shot in obj.shots)
		{
			if(s_shot.name === str_shot && isdefined(s_shot.entry))
			{
				foreach(s_entry in s_shot.entry)
				{
					if(isdefined(s_entry.cameraswitcher))
					{
						var_5a162d58 = var_5a162d58 + float(getcamanimtime(s_entry.cameraswitcher)) / 1000;
						continue;
					}
					if(isdefined(s_entry.("anim")))
					{
						n_anim_length = n_anim_length + getanimlength(s_entry.("anim"));
					}
				}
				break;
			}
		}
	}
	n_length = max(var_5a162d58, n_anim_length);
	return n_length;
}

/*
	Name: function_dde5f483
	Namespace: scene
	Checksum: 0x90E16776
	Offset: 0xD778
	Size: 0x24A
	Parameters: 2
	Flags: Linked
*/
function function_dde5f483(str_scenedef, n_elapsed_time)
{
	s_scenedef = get_scenedef(str_scenedef);
	a_shots = get_all_shot_names(str_scenedef, undefined, 1);
	var_7a2504a = 0;
	var_8b21886e = spawnstruct();
	foreach(str_shot in a_shots)
	{
		var_958bccd3 = 0;
		foreach(obj in s_scenedef.objects)
		{
			var_657b76cc = function_1eab8670(obj, str_shot);
			if(var_657b76cc > var_958bccd3)
			{
				var_958bccd3 = var_657b76cc;
			}
		}
		var_219aac3f = var_7a2504a;
		var_68790830 = var_219aac3f + var_958bccd3;
		if(n_elapsed_time >= var_219aac3f && n_elapsed_time < var_68790830)
		{
			var_8b21886e.var_ef711d04 = str_shot;
			var_8b21886e.var_3486c904 = n_elapsed_time - var_219aac3f / var_958bccd3;
			return var_8b21886e;
		}
		var_7a2504a = var_7a2504a + var_958bccd3;
	}
	var_8b21886e.var_ef711d04 = a_shots[a_shots.size - 1];
	var_8b21886e.var_3486c904 = 0.9;
	return var_8b21886e;
}

/*
	Name: function_8582657c
	Namespace: scene
	Checksum: 0x2BE270B3
	Offset: 0xD9D0
	Size: 0x122
	Parameters: 2
	Flags: Linked
*/
function function_8582657c(var_b9a72490, str_shot)
{
	if(isstring(var_b9a72490) || function_7a600918(var_b9a72490))
	{
		s_scenedef = get_scenedef(var_b9a72490);
	}
	else
	{
		s_scenedef = var_b9a72490;
	}
	var_a0c66830 = 0;
	foreach(obj in s_scenedef.objects)
	{
		var_657b76cc = function_1eab8670(obj, str_shot);
		if(var_657b76cc > var_a0c66830)
		{
			var_a0c66830 = var_657b76cc;
		}
	}
	return var_a0c66830;
}

/*
	Name: function_12479eba
	Namespace: scene
	Checksum: 0x93D61814
	Offset: 0xDB00
	Size: 0xE8
	Parameters: 1
	Flags: Linked
*/
function function_12479eba(str_scenedef)
{
	s_scenedef = get_scenedef(str_scenedef);
	a_shots = get_all_shot_names(str_scenedef, undefined, 1);
	var_9d90ef8b = 0;
	foreach(str_shot in a_shots)
	{
		var_9d90ef8b = var_9d90ef8b + function_8582657c(s_scenedef, str_shot);
	}
	return var_9d90ef8b;
}

/*
	Name: function_67e52759
	Namespace: scene
	Checksum: 0x2B445064
	Offset: 0xDBF0
	Size: 0xD2
	Parameters: 5
	Flags: Linked
*/
function function_67e52759(str_scenedef, s_instance, var_8c4d2266, var_47f77330, var_62e8e2f0)
{
	a_shots = get_all_shot_names(str_scenedef, s_instance, var_8c4d2266);
	if(isdefined(var_47f77330) || isdefined(var_62e8e2f0))
	{
		a_shots = array::slice(a_shots, (isdefined(var_47f77330) ? var_47f77330 : 0), (isdefined(var_62e8e2f0) ? var_62e8e2f0 : 2147483647));
	}
	s_shot = array::random(a_shots);
	return s_shot;
}

/*
	Name: play
	Namespace: scene
	Checksum: 0xCE8587C1
	Offset: 0xDCD0
	Size: 0x47C
	Parameters: 6
	Flags: Linked
*/
function play(arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time)
{
	s_tracker = spawnstruct();
	s_tracker.n_scene_count = 1;
	if(self == level)
	{
		a_instances = [];
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg1) && issubstr(arg1, ","))
			{
				a_toks = strtok(arg1, ",");
				str_value = a_toks[0];
				str_key = a_toks[1];
				if(isstring(arg2))
				{
					str_shot = tolower(arg2);
					a_ents = arg3;
					var_5b51581a = 1;
				}
				else
				{
					a_ents = arg2;
				}
			}
			else if(isinarray(level.scenedefs, hash(arg1)))
			{
				str_scenedef = arg1;
				var_583db6f0 = 1;
			}
			else
			{
				str_value = arg1;
				str_key = "targetname";
			}
			if(isstring(arg2))
			{
				if(isinarray(array("targetname", "script_noteworthy"), arg2))
				{
					str_key = arg2;
				}
				else
				{
					str_shot = tolower(arg2);
					var_5b51581a = 1;
				}
				a_ents = arg3;
			}
			else
			{
				a_ents = arg2;
			}
			a_instances = _get_scene_instances(str_value, str_key, str_scenedef);
			if(a_instances.size)
			{
				s_tracker.n_scene_count = a_instances.size;
				foreach(s_instance in a_instances)
				{
					if(isdefined(s_instance))
					{
						if(!(isdefined(var_583db6f0) && var_583db6f0))
						{
							str_scenedef = s_instance.scriptbundlename;
						}
						if(!(isdefined(var_5b51581a) && var_5b51581a))
						{
							str_shot = function_de6a7579(str_scenedef, str_mode, s_instance);
						}
						else if(!issubstr(str_mode, "play_from_time"))
						{
							str_mode = "single";
						}
						s_instance thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time);
					}
				}
			}
			else
			{
				_play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
			}
		}
	}
	else
	{
		_play_on_self(s_tracker, arg1, arg2, arg3, b_test_run, str_mode, n_time);
	}
	function_c802b491(s_tracker, str_mode);
}

/*
	Name: function_c802b491
	Namespace: scene
	Checksum: 0xB453AE4B
	Offset: 0xE158
	Size: 0x8C
	Parameters: 2
	Flags: Linked, Private
*/
private function function_c802b491(s_tracker, str_mode)
{
	level endon(#"demo_jump");
	if(s_tracker.n_scene_count > 0 && (!(isdefined(s_tracker.var_93ec5dde) && s_tracker.var_93ec5dde)) && str_mode !== "init")
	{
		s_tracker waittill(#"scene_done");
	}
}

/*
	Name: function_46546b5c
	Namespace: scene
	Checksum: 0x22963BE0
	Offset: 0xE1F0
	Size: 0xBA
	Parameters: 2
	Flags: Linked
*/
function function_46546b5c(s_tracker, str_scenedef)
{
	if(getdvarint(#"hash_862358d532e674c", 0) === 1)
	{
		var_41c1a1b7 = getscriptbundle(str_scenedef);
		if(isdefined(var_41c1a1b7.var_2af733c9) && var_41c1a1b7.var_2af733c9)
		{
			/#
				iprintlnbold("" + str_scenedef);
			#/
			s_tracker.var_93ec5dde = 1;
			return 1;
		}
	}
	return 0;
}

/*
	Name: _play_on_self
	Namespace: scene
	Checksum: 0xFEFCD2FE
	Offset: 0xE2B8
	Size: 0x22C
	Parameters: 7
	Flags: Linked
*/
function _play_on_self(s_tracker, arg1, arg2, arg3, b_test_run = 0, str_mode = "", n_time)
{
	if(isstring(arg1) || function_7a600918(arg1))
	{
		if(isinarray(level.scenedefs, hash(arg1)))
		{
			str_scenedef = arg1;
			if(isstring(arg2))
			{
				str_shot = arg2;
				a_ents = arg3;
			}
			else
			{
				a_ents = arg2;
			}
		}
		else
		{
			str_shot = arg1;
			a_ents = arg2;
		}
	}
	else if(isarray(arg1))
	{
		str_scenedef = self.scriptbundlename;
		a_ents = arg1;
	}
	else
	{
		str_scenedef = self.scriptbundlename;
		if(isstring(arg2))
		{
			str_shot = arg2;
			a_ents = arg3;
		}
	}
	s_tracker.n_scene_count = 1;
	if(!isdefined(str_shot) && isdefined(str_scenedef))
	{
		str_shot = function_de6a7579(str_scenedef, str_mode, self);
	}
	else if(isdefined(str_shot) && !issubstr(str_mode, "play_from_time"))
	{
		str_mode = "single";
	}
	self thread _play_instance(s_tracker, str_scenedef, a_ents, b_test_run, str_shot, str_mode, n_time);
}

/*
	Name: _play_instance
	Namespace: scene
	Checksum: 0xE145E3A6
	Offset: 0xE4F0
	Size: 0x3F0
	Parameters: 7
	Flags: Linked
*/
function _play_instance(s_tracker, str_scenedef = self.scriptbundlename, a_ents, b_test_run, str_shot = "play", str_mode, n_time)
{
	if(isdefined(n_time) && issubstr(str_mode, "play_from_time"))
	{
		var_8b21886e = function_d1abba8b(str_scenedef, str_mode, n_time);
		str_shot = var_8b21886e.var_ef711d04;
		var_dd2b75b = var_8b21886e.var_3486c904;
		str_mode = str_mode + ":" + var_dd2b75b;
	}
	if(str_mode === "init")
	{
		str_shot = function_de6a7579(str_scenedef, str_mode, self);
	}
	if(function_46546b5c(s_tracker, str_scenedef))
	{
		waitframe(1);
		self notify(#"scene_done");
		return;
	}
	if(self.scriptbundlename === str_scenedef)
	{
		str_scenedef = self.scriptbundlename;
		if(!(isdefined(self.script_play_multiple) && self.script_play_multiple))
		{
			if(!isdefined(self.scene_played))
			{
				self.scene_played = [];
			}
			if(isdefined(self.scene_played[str_shot]) && self.scene_played[str_shot] && !b_test_run)
			{
				waittillframeend();
				while(is_playing(str_scenedef))
				{
					waitframe(1);
				}
				/#
					println("" + str_scenedef + "");
				#/
				s_tracker notify(#"scene_done");
				return;
			}
		}
		if(str_mode == "init")
		{
			self.scene_played[str_shot] = 0;
		}
		else
		{
			self.scene_played[str_shot] = 1;
		}
	}
	o_scene = _init_instance(str_scenedef, a_ents, b_test_run);
	/#
		function_8ee42bf(o_scene);
	#/
	if(str_mode != "init")
	{
		if(isdefined(self.script_delay) && self.script_delay > 0)
		{
			wait(self.script_delay);
		}
		if(isdefined(o_scene))
		{
			thread [[ o_scene ]]->play(str_shot, b_test_run, str_mode);
			if(isdefined(o_scene._a_objects) && o_scene._a_objects.size)
			{
				o_scene waittill_instance_scene_done(str_scenedef);
			}
		}
		if(isdefined(self))
		{
			if(isdefined(self.scriptbundlename) && (isdefined(get_scenedef(self.scriptbundlename).looping) && get_scenedef(self.scriptbundlename).looping))
			{
				self.scene_played[str_shot] = 0;
			}
		}
	}
	/#
		function_8ee42bf(o_scene);
	#/
	s_tracker.n_scene_count--;
	s_tracker notify(#"scene_done");
}

/*
	Name: waittill_instance_scene_done
	Namespace: scene
	Checksum: 0xBB53B49E
	Offset: 0xE8E8
	Size: 0x3A
	Parameters: 1
	Flags: Linked, Private
*/
private function waittill_instance_scene_done(str_scenedef)
{
	level endon(#"demo_jump");
	self waittill(#"scene_done");
}

/*
	Name: stop
	Namespace: scene
	Checksum: 0xA3C856AF
	Offset: 0xE930
	Size: 0x2AC
	Parameters: 5
	Flags: Linked
*/
function stop(arg1, arg2, arg3, b_cancel, b_no_assert = 0)
{
	if(self == level)
	{
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg2))
			{
				str_value = arg1;
				str_key = arg2;
				b_clear = arg3;
			}
			else
			{
				str_value = arg1;
				b_clear = arg2;
			}
			if(isdefined(str_key))
			{
				a_instances = struct::get_array(str_value, str_key);
				/#
					/#
						assert(b_no_assert || a_instances.size, "" + str_key + "" + str_value + "");
					#/
				#/
				str_value = undefined;
			}
			else
			{
				a_instances = struct::get_array(str_value, "targetname");
				if(!a_instances.size)
				{
					a_instances = get_active_scenes(str_value);
				}
				else
				{
					str_value = undefined;
				}
			}
			foreach(s_instance in arraycopy(a_instances))
			{
				if(isdefined(s_instance))
				{
					s_instance _stop_instance(b_clear, str_value, b_cancel);
				}
			}
		}
	}
	else if(isstring(arg1) || function_7a600918(arg1))
	{
		_stop_instance(arg2, arg1, b_cancel);
	}
	else
	{
		_stop_instance(arg1, arg2, b_cancel);
	}
}

/*
	Name: _stop_instance
	Namespace: scene
	Checksum: 0x1FE9FD3E
	Offset: 0xEBE8
	Size: 0xFC
	Parameters: 3
	Flags: Linked
*/
function _stop_instance(b_clear = 0, str_scenedef, b_cancel = 0)
{
	if(isdefined(self.scenes))
	{
		foreach(o_scene in arraycopy(self.scenes))
		{
			str_scene_name = o_scene._str_name;
			if(!isdefined(str_scenedef) || str_scene_name == str_scenedef)
			{
				thread [[ o_scene ]]->stop(b_clear, b_cancel);
			}
		}
	}
}

/*
	Name: cancel
	Namespace: scene
	Checksum: 0x9669456C
	Offset: 0xECF0
	Size: 0x3C
	Parameters: 3
	Flags: Linked
*/
function cancel(arg1, arg2, arg3)
{
	stop(arg1, arg2, arg3, 1);
}

/*
	Name: delete_scene_spawned_ents
	Namespace: scene
	Checksum: 0xF5F6B25B
	Offset: 0xED38
	Size: 0x24C
	Parameters: 2
	Flags: Linked
*/
function delete_scene_spawned_ents(localclientnum, arg1)
{
	if(self == level)
	{
		a_instances = [];
		if(isstring(arg1) || function_7a600918(arg1))
		{
			if(isstring(arg1) && issubstr(arg1, ","))
			{
				a_toks = strtok(arg1, ",");
				str_value = a_toks[0];
				str_key = a_toks[1];
			}
			else if(isinarray(level.scenedefs, hash(arg1)))
			{
				str_scenedef = arg1;
			}
			else
			{
				str_value = arg1;
				str_key = "targetname";
			}
			a_instances = _get_scene_instances(str_value, str_key, str_scenedef, 1);
			if(a_instances.size)
			{
				foreach(instance in a_instances)
				{
					instance _delete_scene_spawned_ents(localclientnum, str_scenedef);
				}
			}
		}
	}
	else if(isstring(arg1) || function_7a600918(arg1))
	{
		str_scenedef = arg1;
	}
	self _delete_scene_spawned_ents(localclientnum, str_scenedef);
}

/*
	Name: _delete_scene_spawned_ents
	Namespace: scene
	Checksum: 0xE28AC930
	Offset: 0xEF90
	Size: 0xE8
	Parameters: 2
	Flags: Linked
*/
function _delete_scene_spawned_ents(localclientnum, str_scene)
{
	if(isarray(self.scene_ents) && isarray(self.scene_ents[localclientnum]))
	{
		foreach(ent in self.scene_ents[localclientnum])
		{
			if(isdefined(ent) && isdefined(ent.scene_spawned))
			{
				ent delete();
			}
		}
	}
}

/*
	Name: has_init_state
	Namespace: scene
	Checksum: 0xED8F6FEB
	Offset: 0xF080
	Size: 0xDC
	Parameters: 1
	Flags: None
*/
function has_init_state(str_scenedef)
{
	s_scenedef = get_scenedef(str_scenedef);
	foreach(s_obj in s_scenedef.objects)
	{
		if(!(isdefined(s_obj.disabled) && s_obj.disabled) && s_obj _has_init_state(str_scenedef))
		{
			return 1;
		}
	}
	return 0;
}

/*
	Name: _has_init_state
	Namespace: scene
	Checksum: 0xDCE83B75
	Offset: 0xF168
	Size: 0x92
	Parameters: 1
	Flags: Linked
*/
function _has_init_state(str_scenedef)
{
	return isinarray(get_all_shot_names(str_scenedef), "init") || (isdefined(self.spawnoninit) && self.spawnoninit) || isdefined(self.initanim) || isdefined(self.initanimloop) || (isdefined(self.firstframe) && self.firstframe);
}

/*
	Name: get_prop_count
	Namespace: scene
	Checksum: 0xC4B00E09
	Offset: 0xF208
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_prop_count(str_scenedef)
{
	return _get_type_count("prop", str_scenedef);
}

/*
	Name: get_vehicle_count
	Namespace: scene
	Checksum: 0x50AA0CB
	Offset: 0xF238
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_vehicle_count(str_scenedef)
{
	return _get_type_count("vehicle", str_scenedef);
}

/*
	Name: get_actor_count
	Namespace: scene
	Checksum: 0x2743BC32
	Offset: 0xF268
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function get_actor_count(str_scenedef)
{
	return _get_type_count("actor", str_scenedef);
}

/*
	Name: function_7aa3d2c6
	Namespace: scene
	Checksum: 0xD56A337F
	Offset: 0xF298
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function function_7aa3d2c6(str_scenedef)
{
	return _get_type_count("sharedplayer", str_scenedef);
}

/*
	Name: get_player_count
	Namespace: scene
	Checksum: 0x26EB2043
	Offset: 0xF2C8
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function get_player_count(str_scenedef)
{
	return _get_type_count("player", str_scenedef);
}

/*
	Name: _get_type_count
	Namespace: scene
	Checksum: 0x2BC1FFAC
	Offset: 0xF2F8
	Size: 0x10E
	Parameters: 2
	Flags: Linked
*/
function _get_type_count(str_type, str_scenedef)
{
	s_scenedef = (isdefined(str_scenedef) ? get_scenedef(str_scenedef) : get_scenedef(self.scriptbundlename));
	n_count = 0;
	foreach(s_obj in s_scenedef.objects)
	{
		if(isdefined(s_obj.type))
		{
			if(tolower(s_obj.type) == tolower(str_type))
			{
				n_count++;
			}
		}
	}
	return n_count;
}

/*
	Name: is_active
	Namespace: scene
	Checksum: 0x4F1ECB1
	Offset: 0xF410
	Size: 0x4C
	Parameters: 1
	Flags: Linked
*/
function is_active(str_scenedef)
{
	if(self == level)
	{
		return get_active_scenes(str_scenedef).size > 0;
	}
	return isdefined(get_active_scene(str_scenedef));
}

/*
	Name: is_playing
	Namespace: scene
	Checksum: 0x4458DAF5
	Offset: 0xF468
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function is_playing(str_scenedef)
{
	if(self == level)
	{
		return level flagsys::get(str_scenedef + "_playing");
	}
	if(!isdefined(str_scenedef))
	{
		str_scenedef = self.scriptbundlename;
	}
	o_scene = get_active_scene(str_scenedef);
	if(isdefined(o_scene))
	{
		return o_scene._str_mode === "play";
	}
	return 0;
}

/*
	Name: get_active_scenes
	Namespace: scene
	Checksum: 0xE667CFF5
	Offset: 0xF500
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function get_active_scenes(str_scenedef)
{
	if(!isdefined(level.active_scenes))
	{
		level.active_scenes = [];
	}
	if(isdefined(str_scenedef))
	{
		return (isdefined(level.active_scenes[str_scenedef]) ? level.active_scenes[str_scenedef] : []);
	}
	a_active_scenes = [];
	foreach(str_scenedef, _ in level.active_scenes)
	{
		a_active_scenes = arraycombine(a_active_scenes, level.active_scenes[str_scenedef], 0, 0);
	}
	return a_active_scenes;
}

/*
	Name: get_active_scene
	Namespace: scene
	Checksum: 0xFF2E4766
	Offset: 0xF600
	Size: 0x9E
	Parameters: 1
	Flags: Linked
*/
function get_active_scene(str_scenedef)
{
	if(isdefined(str_scenedef) && isdefined(self.scenes))
	{
		foreach(o_scene in self.scenes)
		{
			if(o_scene._str_name == str_scenedef)
			{
				return o_scene;
			}
		}
	}
}

/*
	Name: is_capture_mode
	Namespace: scene
	Checksum: 0x89530F2F
	Offset: 0xF6A8
	Size: 0x62
	Parameters: 0
	Flags: None
*/
function is_capture_mode()
{
	str_mode = getdvarstring(#"scene_menu_mode", "default");
	if(issubstr(str_mode, "capture"))
	{
		return 1;
	}
	return 0;
}

/*
	Name: _get_scene_instances
	Namespace: scene
	Checksum: 0xB75EFA3
	Offset: 0xF718
	Size: 0x19A
	Parameters: 4
	Flags: Linked
*/
function _get_scene_instances(str_value, str_key = "targetname", str_scenedef, b_include_inactive = 0)
{
	a_instances = [];
	if(isdefined(str_value))
	{
		a_instances = struct::get_array(str_value, str_key);
		/#
			/#
				assert(a_instances.size, "" + str_key + "" + str_value + "");
			#/
		#/
	}
	if(isdefined(str_scenedef))
	{
		a_instances_by_scenedef = struct::get_array(str_scenedef, "scriptbundlename");
		a_instances = arraycombine(a_instances_by_scenedef, a_instances, 0, 0);
		a_active_instances = get_active_scenes(str_scenedef);
		a_instances = arraycombine(a_active_instances, a_instances, 0, 0);
		if(b_include_inactive)
		{
			a_inactive_instances = get_inactive_scenes(str_scenedef);
			a_instances = arraycombine(a_inactive_instances, a_instances, 0, 0);
		}
	}
	return a_instances;
}

/*
	Name: get_inactive_scenes
	Namespace: scene
	Checksum: 0x32285A79
	Offset: 0xF8C0
	Size: 0xF6
	Parameters: 1
	Flags: Linked
*/
function get_inactive_scenes(str_scenedef)
{
	if(!isdefined(level.inactive_scenes))
	{
		level.inactive_scenes = [];
	}
	if(isdefined(str_scenedef))
	{
		return (isdefined(level.inactive_scenes[str_scenedef]) ? level.inactive_scenes[str_scenedef] : []);
	}
	a_scenes = [];
	foreach(str_scenedef, _ in level.inactive_scenes)
	{
		a_scenes = arraycombine(a_scenes, level.inactive_scenes[str_scenedef], 0, 0);
	}
	return a_scenes;
}

/*
	Name: function_9730988a
	Namespace: scene
	Checksum: 0x258437AA
	Offset: 0xF9C0
	Size: 0x3A
	Parameters: 2
	Flags: None
*/
function function_9730988a(str_scenedef, var_6a688dba)
{
	return isinarray(get_all_shot_names(str_scenedef), var_6a688dba);
}

