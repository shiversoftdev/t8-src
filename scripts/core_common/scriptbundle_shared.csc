// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#namespace cscriptbundleobjectbase;

/*
	Name: __constructor
	Namespace: cscriptbundleobjectbase
	Checksum: 0x80F724D1
	Offset: 0x80
	Size: 0x4
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
}

/*
	Name: __destructor
	Namespace: cscriptbundleobjectbase
	Checksum: 0x80F724D1
	Offset: 0x90
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

/*
	Name: init
	Namespace: cscriptbundleobjectbase
	Checksum: 0x983671E9
	Offset: 0xA0
	Size: 0xCA
	Parameters: 4
	Flags: Linked
*/
function init(s_objdef, o_bundle, e_ent, localclientnum)
{
	self._s = s_objdef;
	self._o_scene = o_bundle;
	if(isdefined(e_ent))
	{
		/#
			assert(!isdefined(localclientnum) || e_ent.localclientnum == localclientnum, "");
		#/
		self._n_clientnum = e_ent.localclientnum;
		self._e_array[self._n_clientnum] = e_ent;
	}
	else
	{
		self._e_array = [];
		if(isdefined(localclientnum))
		{
			self._n_clientnum = localclientnum;
		}
	}
}

/*
	Name: log
	Namespace: cscriptbundleobjectbase
	Checksum: 0x39078910
	Offset: 0x178
	Size: 0xCC
	Parameters: 1
	Flags: Linked
*/
function log(str_msg)
{
	/#
		println((((([[ self._o_scene ]]->get_type()) + "") + function_9e72a96(self._o_scene._str_name) + "") + (isdefined(self._s.name) ? "" + self._s.name : (isdefined("") ? "" + "" : "")) + "") + str_msg);
	#/
}

/*
	Name: error
	Namespace: cscriptbundleobjectbase
	Checksum: 0x6AFAAB6A
	Offset: 0x250
	Size: 0x128
	Parameters: 2
	Flags: Linked
*/
function error(condition, str_msg)
{
	if(condition)
	{
		if([[ self._o_scene ]]->is_testing())
		{
			scriptbundle::error_on_screen(str_msg);
		}
		assertmsg((((([[ self._o_scene ]]->get_type()) + "") + function_9e72a96(self._o_scene._str_name) + "") + (isdefined(self._s.name) ? "" + self._s.name : (isdefined("") ? "" + "" : "")) + "") + str_msg);
		thread [[ self._o_scene ]]->on_error();
		return 1;
	}
	return 0;
}

/*
	Name: get_ent
	Namespace: cscriptbundleobjectbase
	Checksum: 0x32A5CF5D
	Offset: 0x380
	Size: 0x18
	Parameters: 1
	Flags: Linked
*/
function get_ent(localclientnum)
{
	return self._e_array[localclientnum];
}

#namespace scriptbundle;

/*
	Name: cscriptbundleobjectbase
	Namespace: scriptbundle
	Checksum: 0xB62783A8
	Offset: 0x3A0
	Size: 0x146
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscriptbundleobjectbase()
{
	classes.cscriptbundleobjectbase[0] = spawnstruct();
	classes.cscriptbundleobjectbase[0].__vtable[1839071698] = &cscriptbundleobjectbase::get_ent;
	classes.cscriptbundleobjectbase[0].__vtable[365768300] = &cscriptbundleobjectbase::error;
	classes.cscriptbundleobjectbase[0].__vtable[766440049] = &cscriptbundleobjectbase::log;
	classes.cscriptbundleobjectbase[0].__vtable[1836838051] = &cscriptbundleobjectbase::init;
	classes.cscriptbundleobjectbase[0].__vtable[913321084] = &cscriptbundleobjectbase::__destructor;
	classes.cscriptbundleobjectbase[0].__vtable[674154906] = &cscriptbundleobjectbase::__constructor;
}

#namespace cscriptbundlebase;

/*
	Name: on_error
	Namespace: cscriptbundlebase
	Checksum: 0x9410C193
	Offset: 0x4F0
	Size: 0xC
	Parameters: 1
	Flags: Linked
*/
function on_error(e)
{
}

/*
	Name: __constructor
	Namespace: cscriptbundlebase
	Checksum: 0xD109E373
	Offset: 0x508
	Size: 0x1A
	Parameters: 0
	Flags: Linked, 8
*/
function __constructor()
{
	self._a_objects = [];
	self._testing = 0;
}

/*
	Name: __destructor
	Namespace: cscriptbundlebase
	Checksum: 0x80F724D1
	Offset: 0x530
	Size: 0x4
	Parameters: 0
	Flags: Linked, 16
*/
function __destructor()
{
}

/*
	Name: init
	Namespace: cscriptbundlebase
	Checksum: 0x85E15D4F
	Offset: 0x540
	Size: 0x42
	Parameters: 3
	Flags: Linked
*/
function init(str_name, s, b_testing)
{
	self._s = s;
	self._str_name = str_name;
	self._testing = b_testing;
}

/*
	Name: get_type
	Namespace: cscriptbundlebase
	Checksum: 0xE95C94E9
	Offset: 0x590
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_type()
{
	return self._s.type;
}

/*
	Name: get_vm
	Namespace: cscriptbundlebase
	Checksum: 0x10C5F25E
	Offset: 0x5B0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_vm()
{
	return self._s.vmtype;
}

/*
	Name: get_objects
	Namespace: cscriptbundlebase
	Checksum: 0xC9A2DDF2
	Offset: 0x5D0
	Size: 0x12
	Parameters: 0
	Flags: Linked
*/
function get_objects()
{
	return self._s.objects;
}

/*
	Name: is_testing
	Namespace: cscriptbundlebase
	Checksum: 0x51CF9D44
	Offset: 0x5F0
	Size: 0xA
	Parameters: 0
	Flags: Linked
*/
function is_testing()
{
	return self._testing;
}

/*
	Name: add_object
	Namespace: cscriptbundlebase
	Checksum: 0xFDF7769A
	Offset: 0x608
	Size: 0x76
	Parameters: 1
	Flags: Linked
*/
function add_object(o_object)
{
	if(!isdefined(self._a_objects))
	{
		self._a_objects = [];
	}
	else if(!isarray(self._a_objects))
	{
		self._a_objects = array(self._a_objects);
	}
	self._a_objects[self._a_objects.size] = o_object;
}

/*
	Name: remove_object
	Namespace: cscriptbundlebase
	Checksum: 0x68410BC2
	Offset: 0x688
	Size: 0x24
	Parameters: 1
	Flags: Linked
*/
function remove_object(o_object)
{
	arrayremovevalue(self._a_objects, o_object);
}

/*
	Name: log
	Namespace: cscriptbundlebase
	Checksum: 0x2574F772
	Offset: 0x6B8
	Size: 0x54
	Parameters: 1
	Flags: Linked
*/
function log(str_msg)
{
	/#
		println((((self._s.type + "") + self._str_name) + "") + str_msg);
	#/
}

/*
	Name: error
	Namespace: cscriptbundlebase
	Checksum: 0xC345E24E
	Offset: 0x718
	Size: 0x9C
	Parameters: 2
	Flags: Linked
*/
function error(condition, str_msg)
{
	if(condition)
	{
		if(self._testing)
		{
		}
		assertmsg(((self._s.type + "") + function_9e72a96(self._str_name) + "") + str_msg);
		thread [[ self ]]->on_error();
		return 1;
	}
	return 0;
}

#namespace scriptbundle;

/*
	Name: cscriptbundlebase
	Namespace: scriptbundle
	Checksum: 0xEFC97C44
	Offset: 0x7C0
	Size: 0x266
	Parameters: 0
	Flags: AutoExec, Private, 128
*/
private autoexec function cscriptbundlebase()
{
	classes.cscriptbundlebase[0] = spawnstruct();
	classes.cscriptbundlebase[0].__vtable[365768300] = &cscriptbundlebase::error;
	classes.cscriptbundlebase[0].__vtable[766440049] = &cscriptbundlebase::log;
	classes.cscriptbundlebase[0].__vtable[1946041604] = &cscriptbundlebase::remove_object;
	classes.cscriptbundlebase[0].__vtable[1475690061] = &cscriptbundlebase::add_object;
	classes.cscriptbundlebase[0].__vtable[1595793979] = &cscriptbundlebase::is_testing;
	classes.cscriptbundlebase[0].__vtable[1297640942] = &cscriptbundlebase::get_objects;
	classes.cscriptbundlebase[0].__vtable[419606637] = &cscriptbundlebase::get_vm;
	classes.cscriptbundlebase[0].__vtable[1434708725] = &cscriptbundlebase::get_type;
	classes.cscriptbundlebase[0].__vtable[1836838051] = &cscriptbundlebase::init;
	classes.cscriptbundlebase[0].__vtable[913321084] = &cscriptbundlebase::__destructor;
	classes.cscriptbundlebase[0].__vtable[674154906] = &cscriptbundlebase::__constructor;
	classes.cscriptbundlebase[0].__vtable[1570676452] = &cscriptbundlebase::on_error;
}

/*
	Name: error_on_screen
	Namespace: scriptbundle
	Checksum: 0x1F5C66D0
	Offset: 0xA30
	Size: 0x16C
	Parameters: 1
	Flags: Linked
*/
function error_on_screen(str_msg)
{
	if(str_msg != "")
	{
		if(!isdefined(level.scene_error_hud))
		{
			level.scene_error_hud = createluimenu(0, "HudElementText");
			setluimenudata(0, level.scene_error_hud, #"alignment", 1);
			setluimenudata(0, level.scene_error_hud, #"x", 0);
			setluimenudata(0, level.scene_error_hud, #"y", 10);
			setluimenudata(0, level.scene_error_hud, #"width", 1920);
			openluimenu(0, level.scene_error_hud);
		}
		setluimenudata(0, level.scene_error_hud, #"text", str_msg);
		self thread _destroy_error_on_screen();
	}
}

/*
	Name: _destroy_error_on_screen
	Namespace: scriptbundle
	Checksum: 0xCEA829E8
	Offset: 0xBA8
	Size: 0x6E
	Parameters: 0
	Flags: Linked
*/
function _destroy_error_on_screen()
{
	level notify(#"_destroy_error_on_screen");
	level endon(#"_destroy_error_on_screen");
	self waittill_timeout(5, #"stopped");
	closeluimenu(0, level.scene_error_hud);
	level.scene_error_hud = undefined;
}

