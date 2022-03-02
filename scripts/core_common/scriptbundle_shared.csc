// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
class cscriptbundleobjectbase 
{
	var _e_array;
	var _o_scene;
	var _s;
	var _n_clientnum;

	/*
		Name: constructor
		Namespace: cscriptbundleobjectbase
		Checksum: 0x80F724D1
		Offset: 0x80
		Size: 0x4
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
	}

	/*
		Name: destructor
		Namespace: cscriptbundleobjectbase
		Checksum: 0x80F724D1
		Offset: 0x90
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16
	*/
	destructor()
	{
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
		return _e_array[localclientnum];
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
			if([[ _o_scene ]]->is_testing())
			{
				scriptbundle::error_on_screen(str_msg);
			}
			else
			{
				/#
					assertmsg((((([[ _o_scene ]]->get_type()) + "") + function_9e72a96(_o_scene._str_name) + "") + (isdefined(_s.name) ? "" + _s.name : (isdefined("") ? "" + "" : "")) + "") + str_msg);
				#/
				/#
				#/
			}
			thread [[ _o_scene ]]->on_error();
			return true;
		}
		return false;
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
			println((((([[ _o_scene ]]->get_type()) + "") + function_9e72a96(_o_scene._str_name) + "") + (isdefined(_s.name) ? "" + _s.name : (isdefined("") ? "" + "" : "")) + "") + str_msg);
		#/
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
			self._e_array[_n_clientnum] = e_ent;
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

}

class cscriptbundlebase 
{
	var _testing;
	var _s;
	var _str_name;
	var _a_objects;

	/*
		Name: constructor
		Namespace: cscriptbundlebase
		Checksum: 0xD109E373
		Offset: 0x508
		Size: 0x1A
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self._a_objects = [];
		self._testing = 0;
	}

	/*
		Name: destructor
		Namespace: cscriptbundlebase
		Checksum: 0x80F724D1
		Offset: 0x530
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16
	*/
	destructor()
	{
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
			if(_testing)
			{
			}
			else
			{
				/#
					assertmsg(((_s.type + "") + function_9e72a96(_str_name) + "") + str_msg);
				#/
				/#
				#/
			}
			thread [[ self ]]->on_error();
			return true;
		}
		return false;
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
			println((((_s.type + "") + _str_name) + "") + str_msg);
		#/
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
		arrayremovevalue(_a_objects, o_object);
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
		if(!isdefined(_a_objects))
		{
			self._a_objects = [];
		}
		else if(!isarray(_a_objects))
		{
			self._a_objects = array(_a_objects);
		}
		self._a_objects[_a_objects.size] = o_object;
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
		return _testing;
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
		return _s.objects;
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
		return _s.vmtype;
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
		return _s.type;
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

}

#namespace scriptbundle;

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
	self waittilltimeout(5, #"stopped");
	closeluimenu(0, level.scene_error_hud);
	level.scene_error_hud = undefined;
}

