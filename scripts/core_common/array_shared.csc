// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.csc;
#using scripts\core_common\flagsys_shared.csc;
#using scripts\core_common\struct.csc;
#using scripts\core_common\util_shared.csc;

#namespace array;

/*
	Name: filter
	Namespace: array
	Checksum: 0x41CE9769
	Offset: 0xA0
	Size: 0x196
	Parameters: 4
	Flags: Linked, Variadic
*/
function filter(array, b_keep_keys, func_filter, vararg)
{
	a_new = [];
	foreach(key, val in array)
	{
		a_args = arraycombine(array(val), vararg, 1, 0);
		if(util::single_func_argarray(undefined, func_filter, a_args))
		{
			if(isstring(key) || isweapon(key))
			{
				if(isdefined(b_keep_keys) && !b_keep_keys)
				{
					a_new[a_new.size] = val;
				}
				else
				{
					a_new[key] = val;
				}
				continue;
			}
			if(isdefined(b_keep_keys) && b_keep_keys)
			{
				a_new[key] = val;
				continue;
			}
			a_new[a_new.size] = val;
		}
	}
	return a_new;
}

/*
	Name: remove_undefined
	Namespace: array
	Checksum: 0x484AF635
	Offset: 0x240
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function remove_undefined(array, b_keep_keys)
{
	return filter(array, b_keep_keys, &_filter_undefined);
}

/*
	Name: remove_dead
	Namespace: array
	Checksum: 0x8A6C46A7
	Offset: 0x288
	Size: 0x3A
	Parameters: 2
	Flags: Linked
*/
function remove_dead(array, b_keep_keys)
{
	return filter(array, b_keep_keys, &_filter_dead);
}

/*
	Name: filter_classname
	Namespace: array
	Checksum: 0x3B6665E7
	Offset: 0x2D0
	Size: 0x42
	Parameters: 3
	Flags: None
*/
function filter_classname(array, b_keep_keys, str_classname)
{
	return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

/*
	Name: function_f23011ac
	Namespace: array
	Checksum: 0x88DBD526
	Offset: 0x320
	Size: 0x42
	Parameters: 3
	Flags: None
*/
function function_f23011ac(array, b_keep_keys, str_classname)
{
	return filter(array, b_keep_keys, &function_e01a747e, str_classname);
}

/*
	Name: get_touching
	Namespace: array
	Checksum: 0xAD5F7547
	Offset: 0x370
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function get_touching(a_ents, e_volume)
{
	a_touching = undefined;
	foreach(e_ent in a_ents)
	{
		if(e_ent istouching(e_volume))
		{
			if(!isdefined(a_touching))
			{
				a_touching = [];
			}
			else if(!isarray(a_touching))
			{
				a_touching = array(a_touching);
			}
			a_touching[a_touching.size] = e_ent;
		}
	}
	return a_touching;
}

/*
	Name: remove_index
	Namespace: array
	Checksum: 0xD013E880
	Offset: 0x468
	Size: 0xDA
	Parameters: 3
	Flags: None
*/
function remove_index(array, index, b_keep_keys)
{
	a_new = [];
	foreach(key, val in array)
	{
		if(key == index)
		{
			continue;
			continue;
		}
		if(isdefined(b_keep_keys) && b_keep_keys)
		{
			a_new[key] = val;
			continue;
		}
		a_new[a_new.size] = val;
	}
	return a_new;
}

/*
	Name: delete_all
	Namespace: array
	Checksum: 0xF0A3E719
	Offset: 0x550
	Size: 0xF0
	Parameters: 2
	Flags: None
*/
function delete_all(array, is_struct)
{
	foreach(ent in array)
	{
		if(isdefined(ent))
		{
			if(isdefined(is_struct) && is_struct)
			{
				ent struct::delete();
				continue;
			}
			if(isdefined(ent.__vtable))
			{
				ent._deleted = 1;
				ent notify(#"death");
				ent = undefined;
				continue;
			}
			ent delete();
		}
	}
}

/*
	Name: notify_all
	Namespace: array
	Checksum: 0xEA168041
	Offset: 0x648
	Size: 0x7C
	Parameters: 2
	Flags: Linked
*/
function notify_all(array, str_notify)
{
	foreach(elem in array)
	{
		elem notify(str_notify);
	}
}

/*
	Name: thread_all
	Namespace: array
	Checksum: 0x1E007946
	Offset: 0x6D0
	Size: 0x16C
	Parameters: 8
	Flags: Linked
*/
function thread_all(entities, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	/#
		assert(isdefined(entities), "");
	#/
	/#
		assert(isdefined(func), "");
	#/
	if(isarray(entities))
	{
		foreach(ent in entities)
		{
			if(!isdefined(ent))
			{
				continue;
			}
			util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
		}
	}
	else
	{
		util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
	}
}

/*
	Name: thread_all_ents
	Namespace: array
	Checksum: 0x47376013
	Offset: 0x848
	Size: 0x154
	Parameters: 7
	Flags: None
*/
function thread_all_ents(entities, func, arg1, arg2, arg3, arg4, arg5)
{
	/#
		assert(isdefined(entities), "");
	#/
	/#
		assert(isdefined(func), "");
	#/
	if(isarray(entities))
	{
		foreach(v in entities)
		{
			util::single_thread(self, func, v, arg1, arg2, arg3, arg4, arg5);
		}
	}
	else
	{
		util::single_thread(self, func, entities, arg1, arg2, arg3, arg4, arg5);
	}
}

/*
	Name: run_all
	Namespace: array
	Checksum: 0xA4F19AD9
	Offset: 0x9A8
	Size: 0x164
	Parameters: 8
	Flags: Linked
*/
function run_all(entities, func, arg1, arg2, arg3, arg4, arg5, arg6)
{
	/#
		assert(isdefined(entities), "");
	#/
	/#
		assert(isdefined(func), "");
	#/
	if(isarray(entities))
	{
		foreach(ent in entities)
		{
			util::single_func(ent, func, arg1, arg2, arg3, arg4, arg5, arg6);
		}
	}
	else
	{
		util::single_func(entities, func, arg1, arg2, arg3, arg4, arg5, arg6);
	}
}

/*
	Name: exclude
	Namespace: array
	Checksum: 0xF7BDD174
	Offset: 0xB18
	Size: 0xD8
	Parameters: 2
	Flags: Linked
*/
function exclude(array, array_exclude)
{
	newarray = array;
	if(isarray(array_exclude))
	{
		foreach(exclude_item in array_exclude)
		{
			arrayremovevalue(newarray, exclude_item);
		}
	}
	else
	{
		arrayremovevalue(newarray, array_exclude);
	}
	return newarray;
}

/*
	Name: add
	Namespace: array
	Checksum: 0xB73BA5E6
	Offset: 0xBF8
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function add(array, item, allow_dupes = 1)
{
	if(isdefined(item))
	{
		if(allow_dupes || !isinarray(array, item))
		{
			array[array.size] = item;
		}
	}
}

/*
	Name: add_sorted
	Namespace: array
	Checksum: 0xFEF586D1
	Offset: 0xC70
	Size: 0x132
	Parameters: 5
	Flags: None
*/
function add_sorted(array, item, allow_dupes = 1, var_13d5adf2, var_e19f0739 = 0)
{
	if(isdefined(item))
	{
		if(allow_dupes || !isinarray(array, item))
		{
			for(i = 0; i <= array.size; i++)
			{
				if(i == array.size || (isdefined(var_13d5adf2) && ([[var_13d5adf2]](item, array[i]) || var_e19f0739)) || (!isdefined(var_13d5adf2) && (item <= array[i] || var_e19f0739)))
				{
					arrayinsert(array, item, i);
					break;
				}
			}
		}
	}
}

/*
	Name: wait_till
	Namespace: array
	Checksum: 0x5E0FA642
	Offset: 0xDB0
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function wait_till(array, notifies, n_timeout)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	s_tracker = spawnstruct();
	s_tracker._wait_count = 0;
	foreach(ent in array)
	{
		if(isdefined(ent))
		{
			ent thread util::timeout(n_timeout, &util::_waitlogic, s_tracker, notifies);
		}
	}
	if(s_tracker._wait_count > 0)
	{
		s_tracker waittill(#"waitlogic_finished");
	}
}

/*
	Name: wait_till_match
	Namespace: array
	Checksum: 0x5693E626
	Offset: 0xF10
	Size: 0x194
	Parameters: 4
	Flags: None
*/
function wait_till_match(array, str_notify, str_match, n_timeout)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	s_tracker = spawnstruct();
	s_tracker._array_wait_count = 0;
	foreach(ent in array)
	{
		if(isdefined(ent))
		{
			s_tracker._array_wait_count++;
			ent thread util::timeout(n_timeout, &_waitlogic_match, s_tracker, str_notify, str_match);
			ent thread util::timeout(n_timeout, &_waitlogic_death, s_tracker);
		}
	}
	if(s_tracker._array_wait_count > 0)
	{
		s_tracker waittill(#"array_wait");
	}
}

/*
	Name: _waitlogic_match
	Namespace: array
	Checksum: 0xDDFF4EAE
	Offset: 0x10B0
	Size: 0x54
	Parameters: 3
	Flags: Linked
*/
function _waitlogic_match(s_tracker, str_notify, str_match)
{
	self endon(#"death");
	self waittill_match(str_match, str_notify);
	update_waitlogic_tracker(s_tracker);
}

/*
	Name: _waitlogic_death
	Namespace: array
	Checksum: 0x685F90A7
	Offset: 0x1110
	Size: 0x34
	Parameters: 1
	Flags: Linked
*/
function _waitlogic_death(s_tracker)
{
	self waittill(#"death");
	update_waitlogic_tracker(s_tracker);
}

/*
	Name: update_waitlogic_tracker
	Namespace: array
	Checksum: 0x70EAA262
	Offset: 0x1150
	Size: 0x40
	Parameters: 1
	Flags: Linked
*/
function update_waitlogic_tracker(s_tracker)
{
	s_tracker._array_wait_count--;
	if(s_tracker._array_wait_count == 0)
	{
		s_tracker notify(#"array_wait");
	}
}

/*
	Name: flag_wait
	Namespace: array
	Checksum: 0x9584A3F1
	Offset: 0x1198
	Size: 0x7E
	Parameters: 2
	Flags: None
*/
function flag_wait(array, str_flag)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(!ent flag::get(str_flag))
		{
			ent waittill(str_flag);
			i = -1;
		}
	}
}

/*
	Name: flagsys_wait
	Namespace: array
	Checksum: 0x46ED9870
	Offset: 0x1220
	Size: 0x7E
	Parameters: 2
	Flags: Linked
*/
function flagsys_wait(array, str_flag)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(!ent flagsys::get(str_flag))
		{
			ent waittill(str_flag);
			i = -1;
		}
	}
}

/*
	Name: flagsys_wait_any_flag
	Namespace: array
	Checksum: 0x61DBA8A2
	Offset: 0x12A8
	Size: 0x106
	Parameters: 2
	Flags: Linked, Variadic
*/
function flagsys_wait_any_flag(array, vararg)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(isdefined(ent))
		{
			b_flag_set = 0;
			foreach(str_flag in vararg)
			{
				if(ent flagsys::get(str_flag))
				{
					b_flag_set = 1;
					break;
				}
			}
			if(!b_flag_set)
			{
				ent waittill(vararg);
				i = -1;
			}
		}
	}
}

/*
	Name: flagsys_wait_any
	Namespace: array
	Checksum: 0x5F9C4E62
	Offset: 0x13B8
	Size: 0xAC
	Parameters: 2
	Flags: None
*/
function flagsys_wait_any(array, str_flag)
{
	foreach(ent in array)
	{
		if(ent flagsys::get(str_flag))
		{
			return ent;
		}
	}
	wait_any(array, str_flag);
}

/*
	Name: flag_wait_clear
	Namespace: array
	Checksum: 0x953EC17D
	Offset: 0x1470
	Size: 0x7E
	Parameters: 2
	Flags: None
*/
function flag_wait_clear(array, str_flag)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(ent flag::get(str_flag))
		{
			ent waittill(str_flag);
			i = -1;
		}
	}
}

/*
	Name: flagsys_wait_clear
	Namespace: array
	Checksum: 0x88541FD2
	Offset: 0x14F8
	Size: 0xF6
	Parameters: 3
	Flags: None
*/
function flagsys_wait_clear(array, str_flag, n_timeout)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(isdefined(ent) && ent flagsys::get(str_flag))
		{
			ent util::waittill_either("death", str_flag);
			i = -1;
		}
	}
}

/*
	Name: wait_any
	Namespace: array
	Checksum: 0x5250B84A
	Offset: 0x15F8
	Size: 0x154
	Parameters: 3
	Flags: Linked
*/
function wait_any(array, msg, n_timeout)
{
	if(isdefined(n_timeout))
	{
		__s = spawnstruct();
		__s endon(#"timeout");
		__s util::delay_notify(n_timeout, "timeout");
	}
	s_tracker = spawnstruct();
	foreach(ent in array)
	{
		if(isdefined(ent))
		{
			level thread util::timeout(n_timeout, &_waitlogic2, s_tracker, ent, msg);
		}
	}
	s_tracker endon(#"array_wait");
	wait_till(array, "death");
}

/*
	Name: _waitlogic2
	Namespace: array
	Checksum: 0xBB2AF8D2
	Offset: 0x1758
	Size: 0x80
	Parameters: 3
	Flags: Linked
*/
function _waitlogic2(s_tracker, ent, msg)
{
	s_tracker endon(#"array_wait");
	if(msg != "death")
	{
		ent endon(#"death");
	}
	ent waittill(msg);
	s_tracker notify(#"array_wait");
}

/*
	Name: flag_wait_any
	Namespace: array
	Checksum: 0x2EB45C4A
	Offset: 0x17E0
	Size: 0xC4
	Parameters: 2
	Flags: None
*/
function flag_wait_any(array, str_flag)
{
	self endon(#"death");
	foreach(ent in array)
	{
		if(ent flag::get(str_flag))
		{
			return ent;
		}
	}
	wait_any(array, str_flag);
}

/*
	Name: random
	Namespace: array
	Checksum: 0xE05A21DE
	Offset: 0x18B0
	Size: 0x4E
	Parameters: 1
	Flags: Linked
*/
function random(array)
{
	keys = getarraykeys(array);
	return array[keys[randomint(keys.size)]];
}

/*
	Name: randomize
	Namespace: array
	Checksum: 0x20CA5DBB
	Offset: 0x1908
	Size: 0x90
	Parameters: 1
	Flags: Linked
*/
function randomize(array)
{
	for(i = 0; i < array.size; i++)
	{
		j = randomint(array.size);
		temp = array[i];
		array[i] = array[j];
		array[j] = temp;
	}
	return array;
}

/*
	Name: reverse
	Namespace: array
	Checksum: 0x63CA64E2
	Offset: 0x19A0
	Size: 0x64
	Parameters: 1
	Flags: None
*/
function reverse(array)
{
	a_array2 = [];
	for(i = array.size - 1; i >= 0; i--)
	{
		a_array2[a_array2.size] = array[i];
	}
	return a_array2;
}

/*
	Name: slice
	Namespace: array
	Checksum: 0x2245FB99
	Offset: 0x1A10
	Size: 0xD0
	Parameters: 4
	Flags: Linked
*/
function slice(array, var_12692bcf = 0, var_d88b3814 = 2147483647, n_increment = 1)
{
	var_d88b3814 = min(var_d88b3814, array.size - 1);
	a_ret = [];
	i = var_12692bcf;
	while(i <= var_d88b3814)
	{
		a_ret[a_ret.size] = array[i];
		i = i + n_increment;
	}
	return a_ret;
}

/*
	Name: remove_keys
	Namespace: array
	Checksum: 0xA556B1CF
	Offset: 0x1AE8
	Size: 0x96
	Parameters: 1
	Flags: None
*/
function remove_keys(array)
{
	a_new = [];
	foreach(val in array)
	{
		if(isdefined(val))
		{
			a_new[a_new.size] = val;
		}
	}
	return a_new;
}

/*
	Name: swap
	Namespace: array
	Checksum: 0x2152B044
	Offset: 0x1B88
	Size: 0xA8
	Parameters: 3
	Flags: Linked
*/
function swap(array, index1, index2)
{
	/#
		assert(index1 < array.size, "");
	#/
	/#
		assert(index2 < array.size, "");
	#/
	temp = array[index1];
	array[index1] = array[index2];
	array[index2] = temp;
}

/*
	Name: pop
	Namespace: array
	Checksum: 0x400E5A50
	Offset: 0x1C38
	Size: 0xA2
	Parameters: 3
	Flags: Linked
*/
function pop(array, index, b_keep_keys = 1)
{
	if(array.size > 0)
	{
		if(!isdefined(index))
		{
			index = getfirstarraykey(array);
		}
		if(isdefined(array[index]))
		{
			ret = array[index];
			arrayremoveindex(array, index, b_keep_keys);
			return ret;
		}
	}
}

/*
	Name: push
	Namespace: array
	Checksum: 0x6770CD71
	Offset: 0x1CE8
	Size: 0x64
	Parameters: 3
	Flags: Linked
*/
function push(array, val, index = getlastarraykey(array) + 1)
{
	arrayinsert(array, val, index);
}

/*
	Name: push_front
	Namespace: array
	Checksum: 0x3E81C04C
	Offset: 0x1D58
	Size: 0x34
	Parameters: 2
	Flags: Linked
*/
function push_front(array, val)
{
	push(array, val, 0);
}

/*
	Name: replace
	Namespace: array
	Checksum: 0xE9E33A63
	Offset: 0x1D98
	Size: 0x9C
	Parameters: 3
	Flags: None
*/
function replace(array, value, replacement)
{
	foreach(i, val in array)
	{
		if(val === value)
		{
			array[i] = replacement;
		}
	}
	return array;
}

/*
	Name: function_80fe1cb6
	Namespace: array
	Checksum: 0x63BEEF08
	Offset: 0x1E40
	Size: 0x1E
	Parameters: 2
	Flags: Linked, Private
*/
private function function_80fe1cb6(a, b)
{
	return a === b;
}

/*
	Name: find
	Namespace: array
	Checksum: 0x3D70A32A
	Offset: 0x1E68
	Size: 0x7C
	Parameters: 3
	Flags: Linked
*/
function find(array, ent, var_13d5adf2 = &function_80fe1cb6)
{
	for(i = 0; i < array.size; i++)
	{
		if([[var_13d5adf2]](array[i], ent))
		{
			return i;
		}
	}
}

/*
	Name: closerfunc
	Namespace: array
	Checksum: 0xB07EE430
	Offset: 0x1EF0
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function closerfunc(dist1, dist2)
{
	return dist1 >= dist2;
}

/*
	Name: fartherfunc
	Namespace: array
	Checksum: 0x984802C
	Offset: 0x1F18
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function fartherfunc(dist1, dist2)
{
	return dist1 <= dist2;
}

/*
	Name: get_all_closest
	Namespace: array
	Checksum: 0x1B2ACD02
	Offset: 0x1F40
	Size: 0x2F8
	Parameters: 5
	Flags: None
*/
function get_all_closest(org, array, excluders = [], max = array.size, maxdist)
{
	maxdists2rd = undefined;
	if(isdefined(maxdist))
	{
		maxdists2rd = maxdist * maxdist;
	}
	dist = [];
	index = [];
	for(i = 0; i < array.size; i++)
	{
		if(!isdefined(array[i]))
		{
			continue;
		}
		excluded = 0;
		for(p = 0; p < excluders.size; p++)
		{
			if(array[i] != excluders[p])
			{
				continue;
			}
			excluded = 1;
			break;
		}
		if(excluded)
		{
			continue;
		}
		length = distancesquared(org, array[i].origin);
		if(isdefined(maxdists2rd) && maxdists2rd < length)
		{
			continue;
		}
		dist[dist.size] = length;
		index[index.size] = i;
	}
	for(;;)
	{
		change = 0;
		for(i = 0; i < dist.size - 1; i++)
		{
			if(dist[i] <= dist[i + 1])
			{
				continue;
			}
			change = 1;
			temp = dist[i];
			dist[i] = dist[i + 1];
			dist[i + 1] = temp;
			temp = index[i];
			index[i] = index[i + 1];
			index[i + 1] = temp;
		}
		if(!change)
		{
			break;
		}
	}
	newarray = [];
	if(max > dist.size)
	{
		max = dist.size;
	}
	for(i = 0; i < max; i++)
	{
		newarray[i] = array[index[i]];
	}
	return newarray;
}

/*
	Name: alphabetize
	Namespace: array
	Checksum: 0x4504701A
	Offset: 0x2240
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function alphabetize(array)
{
	return sort_by_value(array, 1);
}

/*
	Name: sort_by_value
	Namespace: array
	Checksum: 0x67C6BB11
	Offset: 0x2270
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function sort_by_value(array, b_lowest_first = 0)
{
	return merge_sort(array, &_compare_value, b_lowest_first);
}

/*
	Name: sort_by_script_int
	Namespace: array
	Checksum: 0xC88EAB87
	Offset: 0x22C0
	Size: 0x42
	Parameters: 2
	Flags: None
*/
function sort_by_script_int(a_ents, b_lowest_first = 0)
{
	return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

/*
	Name: merge_sort
	Namespace: array
	Checksum: 0xF2B33062
	Offset: 0x2310
	Size: 0x1BA
	Parameters: 3
	Flags: Linked
*/
function merge_sort(current_list, func_sort, param)
{
	if(current_list.size <= 1)
	{
		return current_list;
	}
	left = [];
	right = [];
	middle = current_list.size / 2;
	for(x = 0; x < middle; x++)
	{
		if(!isdefined(left))
		{
			left = [];
		}
		else if(!isarray(left))
		{
			left = array(left);
		}
		left[left.size] = current_list[x];
	}
	while(x < current_list.size)
	{
		if(!isdefined(right))
		{
			right = [];
		}
		else if(!isarray(right))
		{
			right = array(right);
		}
		right[right.size] = current_list[x];
		x++;
	}
	left = merge_sort(left, func_sort, param);
	right = merge_sort(right, func_sort, param);
	result = merge(left, right, func_sort, param);
	return result;
}

/*
	Name: merge
	Namespace: array
	Checksum: 0x9DBD2BBE
	Offset: 0x24D8
	Size: 0x17E
	Parameters: 4
	Flags: Linked
*/
function merge(left, right, func_sort, param)
{
	result = [];
	li = 0;
	ri = 0;
	while(li < left.size && ri < right.size)
	{
		b_result = undefined;
		if(isdefined(param))
		{
			b_result = [[func_sort]](left[li], right[ri], param);
		}
		else
		{
			b_result = [[func_sort]](left[li], right[ri]);
		}
		if(b_result)
		{
			result[result.size] = left[li];
			li++;
		}
		else
		{
			result[result.size] = right[ri];
			ri++;
		}
	}
	while(li < left.size)
	{
		result[result.size] = left[li];
		li++;
	}
	while(ri < right.size)
	{
		result[result.size] = right[ri];
		ri++;
	}
	return result;
}

/*
	Name: function_b63fcb3
	Namespace: array
	Checksum: 0xC2F9394
	Offset: 0x2660
	Size: 0x196
	Parameters: 2
	Flags: None
*/
function function_b63fcb3(array, sort_func)
{
	start = 0;
	end = array.size;
	var_f9038db1 = 1;
	while(var_f9038db1 && start < end)
	{
		var_f9038db1 = 0;
		i = start;
		for(j = start + 1; j < end; j++)
		{
			if([[sort_func]](array[j], array[i]))
			{
				swap(array, j, i);
				var_f9038db1 = 1;
			}
			i++;
		}
		end--;
		if(var_f9038db1 && start < end)
		{
			var_f9038db1 = 0;
			i = end - 2;
			j = i + 1;
			while(i >= start)
			{
				if([[sort_func]](array[j], array[i]))
				{
					swap(array, j, i);
					var_f9038db1 = 1;
				}
				i--;
				j--;
			}
			start++;
		}
	}
}

/*
	Name: spread_all
	Namespace: array
	Checksum: 0xCED66052
	Offset: 0x2800
	Size: 0x19C
	Parameters: 7
	Flags: None
*/
function spread_all(entities, func, arg1, arg2, arg3, arg4, arg5)
{
	/#
		assert(isdefined(entities), "");
	#/
	/#
		assert(isdefined(func), "");
	#/
	if(isarray(entities))
	{
		foreach(ent in entities)
		{
			if(isdefined(ent))
			{
				util::single_thread(ent, func, arg1, arg2, arg3, arg4, arg5);
			}
			wait(randomfloatrange(0.06666666, 0.1333333));
		}
	}
	else
	{
		util::single_thread(entities, func, arg1, arg2, arg3, arg4, arg5);
		wait(randomfloatrange(0.06666666, 0.1333333));
	}
}

/*
	Name: wait_till_touching
	Namespace: array
	Checksum: 0x1D10423C
	Offset: 0x29A8
	Size: 0x38
	Parameters: 2
	Flags: None
*/
function wait_till_touching(a_ents, e_volume)
{
	while(!is_touching(a_ents, e_volume))
	{
		waitframe(1);
	}
}

/*
	Name: is_touching
	Namespace: array
	Checksum: 0xC2A4C9C
	Offset: 0x29E8
	Size: 0x92
	Parameters: 2
	Flags: Linked
*/
function is_touching(a_ents, e_volume)
{
	foreach(e_ent in a_ents)
	{
		if(!e_ent istouching(e_volume))
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: contains
	Namespace: array
	Checksum: 0x6C536386
	Offset: 0x2A88
	Size: 0xAE
	Parameters: 2
	Flags: Linked
*/
function contains(array_or_val, value)
{
	if(isarray(array_or_val))
	{
		foreach(element in array_or_val)
		{
			if(element === value)
			{
				return 1;
			}
		}
		return 0;
	}
	return array_or_val === value;
}

/*
	Name: quick_sort
	Namespace: array
	Checksum: 0x3C549428
	Offset: 0x2B40
	Size: 0x60
	Parameters: 2
	Flags: None
*/
function quick_sort(array, compare_func)
{
	sorted_array = arraycopy(array);
	quick_sort_mid(sorted_array, 0, sorted_array.size - 1, compare_func);
	return sorted_array;
}

/*
	Name: quick_sort_mid
	Namespace: array
	Checksum: 0x8666D7FD
	Offset: 0x2BA8
	Size: 0x14C
	Parameters: 4
	Flags: Linked
*/
function quick_sort_mid(array, start, end, compare_func)
{
	if(end - start >= 1)
	{
		if(!isdefined(compare_func))
		{
			compare_func = &_compare_value;
		}
		pivot = array[end];
		i = start;
		for(k = start; k < end; k++)
		{
			if([[compare_func]](array[k], pivot))
			{
				swap(array, i, k);
				i++;
			}
		}
		if(i != end)
		{
			swap(array, i, end);
		}
		quick_sort_mid(array, start, i - 1, compare_func);
		quick_sort_mid(array, i + 1, end, compare_func);
	}
}

/*
	Name: _compare_value
	Namespace: array
	Checksum: 0x5D51864A
	Offset: 0x2D00
	Size: 0x4E
	Parameters: 3
	Flags: Linked
*/
function _compare_value(val1, val2, b_lowest_first = 1)
{
	if(b_lowest_first)
	{
		return val1 <= val2;
	}
	return val1 > val2;
}

/*
	Name: function_5b554cb6
	Namespace: array
	Checksum: 0x1385B412
	Offset: 0x2D58
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function function_5b554cb6(val1, val2)
{
	return val1 > val2;
}

/*
	Name: _compare_script_int
	Namespace: array
	Checksum: 0x91CF62B3
	Offset: 0x2D80
	Size: 0x6C
	Parameters: 3
	Flags: Linked
*/
function _compare_script_int(e1, e2, b_lowest_first = 1)
{
	if(b_lowest_first)
	{
		return e1.script_int <= e2.script_int;
	}
	return e1.script_int > e2.script_int;
}

/*
	Name: _filter_undefined
	Namespace: array
	Checksum: 0x369DCB29
	Offset: 0x2DF8
	Size: 0x10
	Parameters: 1
	Flags: Linked
*/
function _filter_undefined(val)
{
	return isdefined(val);
}

/*
	Name: _filter_dead
	Namespace: array
	Checksum: 0x5282933C
	Offset: 0x2E10
	Size: 0x22
	Parameters: 1
	Flags: Linked
*/
function _filter_dead(val)
{
	return isalive(val);
}

/*
	Name: _filter_classname
	Namespace: array
	Checksum: 0x3EC60448
	Offset: 0x2E40
	Size: 0x44
	Parameters: 2
	Flags: Linked
*/
function _filter_classname(val, arg)
{
	return isdefined(val.classname) && issubstr(val.classname, arg);
}

/*
	Name: function_e01a747e
	Namespace: array
	Checksum: 0xBB900848
	Offset: 0x2E90
	Size: 0x46
	Parameters: 2
	Flags: Linked
*/
function function_e01a747e(val, arg)
{
	return !(isdefined(val.classname) && issubstr(val.classname, arg));
}

/*
	Name: function_f2d037b1
	Namespace: array
	Checksum: 0x819C3247
	Offset: 0x2EE0
	Size: 0xC6
	Parameters: 0
	Flags: None
*/
function function_f2d037b1()
{
	/#
		wait(5);
		for(maxval = 0; maxval < 100; maxval++)
		{
			for(i = 0; i < 100; i++)
			{
				minval = function_21a3a673(0, maxval);
				function_d1f43a84(undefined, minval, maxval);
				function_d1f43a84(undefined, minval, maxval, &function_5b554cb6, 0);
				waitframe(1);
			}
		}
	#/
}

/*
	Name: function_d1f43a84
	Namespace: array
	Checksum: 0x515D991
	Offset: 0x2FB0
	Size: 0x28C
	Parameters: 5
	Flags: None
*/
function function_d1f43a84(max_entries, minval, maxval, compare_func, var_c8e96eee)
{
	/#
		if(!isdefined(max_entries))
		{
			max_entries = 20;
		}
		if(!isdefined(minval))
		{
			minval = 0;
		}
		if(!isdefined(maxval))
		{
			maxval = 100;
		}
		if(!isdefined(compare_func))
		{
			compare_func = undefined;
		}
		if(!isdefined(var_c8e96eee))
		{
			var_c8e96eee = 1;
		}
		var_365f3054 = randomintrange(0, max_entries);
		println("" + var_365f3054 + "" + minval + "" + maxval + "");
		source_array = [];
		for(i = 0; i < var_365f3054; i++)
		{
			if(!isdefined(source_array))
			{
				source_array = [];
			}
			else if(!isarray(source_array))
			{
				source_array = array(source_array);
			}
			source_array[source_array.size] = function_21a3a673(minval, maxval);
		}
		test_array = arraycopy(source_array);
		sorted_array = quick_sort(test_array, compare_func);
		if(var_c8e96eee)
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] <= sorted_array[i + 1], "");
				#/
			}
		}
		else
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] >= sorted_array[i + 1], "");
				#/
			}
		}
		println("");
	#/
}

/*
	Name: function_81d0d595
	Namespace: array
	Checksum: 0x2B028563
	Offset: 0x3248
	Size: 0xCE
	Parameters: 0
	Flags: None
*/
function function_81d0d595()
{
	/#
		wait(5);
		for(maxval = 0; maxval < 100; maxval++)
		{
			for(i = 0; i < 100; i++)
			{
				minval = function_21a3a673(0, maxval);
				function_70daaa9d(undefined, minval, maxval, &_compare_value);
				function_70daaa9d(undefined, minval, maxval, &function_5b554cb6, 0);
				waitframe(1);
			}
		}
	#/
}

/*
	Name: function_70daaa9d
	Namespace: array
	Checksum: 0x32F64EDD
	Offset: 0x3320
	Size: 0x284
	Parameters: 5
	Flags: None
*/
function function_70daaa9d(max_entries, minval, maxval, compare_func, var_c8e96eee)
{
	/#
		if(!isdefined(max_entries))
		{
			max_entries = 50;
		}
		if(!isdefined(minval))
		{
			minval = 0;
		}
		if(!isdefined(maxval))
		{
			maxval = 100;
		}
		if(!isdefined(compare_func))
		{
			compare_func = undefined;
		}
		if(!isdefined(var_c8e96eee))
		{
			var_c8e96eee = 1;
		}
		var_365f3054 = randomintrange(0, max_entries);
		println("" + var_365f3054 + "" + minval + "" + maxval + "");
		source_array = [];
		for(i = 0; i < var_365f3054; i++)
		{
			if(!isdefined(source_array))
			{
				source_array = [];
			}
			else if(!isarray(source_array))
			{
				source_array = array(source_array);
			}
			source_array[source_array.size] = function_21a3a673(minval, maxval);
		}
		sorted_array = arraycopy(source_array);
		function_b63fcb3(sorted_array, compare_func);
		if(var_c8e96eee)
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] <= sorted_array[i + 1], "");
				#/
			}
		}
		else
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] >= sorted_array[i + 1], "");
				#/
			}
		}
		println("");
	#/
}

