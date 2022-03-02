// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\system_shared.gsc;

#namespace namespace_8e41fc17;

/*
	Name: function_89f2df9
	Namespace: namespace_8e41fc17
	Checksum: 0xBEDB2F77
	Offset: 0x70
	Size: 0x3C
	Parameters: 0
	Flags: AutoExec
*/
function autoexec function_89f2df9()
{
	system::register(#"hash_61a4cd8ae6b0d4c7", &__init__, undefined, undefined);
}

/*
	Name: __init__
	Namespace: namespace_8e41fc17
	Checksum: 0x24302667
	Offset: 0xB8
	Size: 0x2A
	Parameters: 0
	Flags: Linked
*/
function __init__()
{
	level.var_d5d1ddd5 = [];
	level.var_a95b39fd = [];
	level.var_fde3243f = [];
}

/*
	Name: register_handler
	Namespace: namespace_8e41fc17
	Checksum: 0x86A24483
	Offset: 0xF0
	Size: 0xB8
	Parameters: 2
	Flags: None
*/
function register_handler(event, var_5f8125a9)
{
	/#
		assert(isdefined(event), "");
	#/
	/#
		assert(isfunctionptr(var_5f8125a9), "");
	#/
	funcs = level.var_d5d1ddd5[event];
	if(!isdefined(funcs))
	{
		funcs = [];
		level.var_d5d1ddd5[event] = funcs;
	}
	funcs[funcs.size] = var_5f8125a9;
}

/*
	Name: function_840acc1c
	Namespace: namespace_8e41fc17
	Checksum: 0xDA0726D8
	Offset: 0x1B0
	Size: 0x1AE
	Parameters: 4
	Flags: None
*/
function function_840acc1c(event, var_5f8125a9, priority = 0, var_c10e92a2 = undefined)
{
	/#
		assert(isdefined(event), "");
	#/
	/#
		assert(isfunctionptr(var_5f8125a9), "");
	#/
	/#
		assert(isint(priority) || isfloat(priority), "");
	#/
	/#
		assert(!isdefined(var_c10e92a2) || isfunctionptr(var_c10e92a2), "");
	#/
	/#
		assert(!isdefined(level.var_a95b39fd[event]), "" + event);
	#/
	handler = {#hash_c10e92a2:var_c10e92a2, #priority:priority, #hash_5f8125a9:var_5f8125a9};
	level.var_a95b39fd[event] = handler;
}

/*
	Name: function_a68ea306
	Namespace: namespace_8e41fc17
	Checksum: 0x63F2FE38
	Offset: 0x368
	Size: 0xC4
	Parameters: 1
	Flags: None
*/
function function_a68ea306(queuename)
{
	/#
		assert(isdefined(queuename), "");
	#/
	/#
		assert(!isdefined(level.var_fde3243f[queuename]), "" + queuename);
	#/
	if(!isdefined(queuename) || isdefined(level.var_fde3243f[queuename]))
	{
		return;
	}
	queue = [];
	level.var_fde3243f[queuename] = queue;
	level thread function_accf7a2e(queue);
}

/*
	Name: function_820f34b4
	Namespace: namespace_8e41fc17
	Checksum: 0xFCE1DE89
	Offset: 0x438
	Size: 0x28C
	Parameters: 5
	Flags: None
*/
function function_820f34b4(queuename, event, var_5f8125a9, priority = 0, params = undefined)
{
	/#
		assert(isdefined(queuename), "");
	#/
	/#
		assert(isdefined(level.var_fde3243f[queuename]), "" + queuename);
	#/
	/#
		assert(isdefined(event), "");
	#/
	/#
		assert(isfunctionptr(var_5f8125a9), "");
	#/
	/#
		assert(isint(priority) || isfloat(priority), "");
	#/
	/#
		assert(!isdefined(params) || isstruct(params), "");
	#/
	queue = level.var_fde3243f[queuename];
	if(!isdefined(queue) || !isdefined(event) || !isfunctionptr(var_5f8125a9))
	{
		return;
	}
	if(!isint(priority) && !isfloat(priority))
	{
		return;
	}
	item = spawnstruct();
	item.context = self;
	item.time = gettime();
	item.event = event;
	item.priority = priority;
	item.var_5f8125a9 = var_5f8125a9;
	item.params = params;
	function_2fa8afa4(queue, item);
}

/*
	Name: function_c710099c
	Namespace: namespace_8e41fc17
	Checksum: 0xFEBF4D4B
	Offset: 0x6D0
	Size: 0x230
	Parameters: 2
	Flags: Linked
*/
function function_c710099c(event, params)
{
	funcs = level.var_d5d1ddd5[event];
	if(isdefined(funcs))
	{
		foreach(func in funcs)
		{
			self thread [[func]](event, params);
		}
	}
	handler = level.var_a95b39fd[event];
	if(!isdefined(handler))
	{
		return;
	}
	var_c10e92a2 = handler.var_c10e92a2;
	foreach(name, queue in level.var_fde3243f)
	{
		item = spawnstruct();
		item.context = self;
		item.time = gettime();
		item.priority = handler.priority;
		item.event = event;
		item.var_5f8125a9 = handler.var_5f8125a9;
		if(isstruct(params))
		{
			item.params = function_2e532eed(params);
		}
		if(!isdefined(var_c10e92a2) || self [[var_c10e92a2]](name, queue, item))
		{
			function_2fa8afa4(queue, item);
		}
	}
}

/*
	Name: function_2fa8afa4
	Namespace: namespace_8e41fc17
	Checksum: 0x91382913
	Offset: 0x908
	Size: 0x7C
	Parameters: 2
	Flags: Linked, Private
*/
function private function_2fa8afa4(queue, item)
{
	for(i = 0; i < queue.size; i++)
	{
		if(queue[i].priority < item.priority)
		{
			break;
		}
	}
	arrayinsert(queue, item, i);
}

/*
	Name: function_accf7a2e
	Namespace: namespace_8e41fc17
	Checksum: 0xB666AEEA
	Offset: 0x990
	Size: 0xBA
	Parameters: 1
	Flags: Linked, Private
*/
function private function_accf7a2e(queue)
{
	level endon(#"game_ended");
	while(true)
	{
		while(queue.size > 0)
		{
			item = queue[0];
			arrayremoveindex(queue, 0);
			if(!isdefined(item.context))
			{
				continue;
			}
			item.context [[item.var_5f8125a9]](item.event, item.params);
		}
		waitframe(1);
	}
}

