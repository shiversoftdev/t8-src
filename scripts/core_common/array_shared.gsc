// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
#using scripts\core_common\flag_shared.gsc;
#using scripts\core_common\flagsys_shared.gsc;
#using scripts\core_common\struct.gsc;
#using scripts\core_common\util_shared.gsc;

#namespace array;

/*
	Name: filter
	Namespace: array
	Checksum: 0xB31550F
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
	Checksum: 0x1FA12F72
	Offset: 0x240
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function remove_undefined(array, b_keep_keys)
{
	arrayremovevalue(array, undefined, b_keep_keys);
	return array;
}

/*
	Name: remove_dead
	Namespace: array
	Checksum: 0x205F7E32
	Offset: 0x278
	Size: 0x30
	Parameters: 2
	Flags: Linked
*/
function remove_dead(array, b_keep_keys)
{
	function_1eaaceab(array, b_keep_keys);
	return array;
}

/*
	Name: filter_classname
	Namespace: array
	Checksum: 0x239BFD92
	Offset: 0x2B0
	Size: 0x42
	Parameters: 3
	Flags: Linked
*/
function filter_classname(array, b_keep_keys, str_classname)
{
	return filter(array, b_keep_keys, &_filter_classname, str_classname);
}

/*
	Name: function_f23011ac
	Namespace: array
	Checksum: 0x6251A2AB
	Offset: 0x300
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
	Checksum: 0x2B881BCD
	Offset: 0x350
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
	Checksum: 0x52B36CB3
	Offset: 0x448
	Size: 0xDA
	Parameters: 3
	Flags: Linked
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
	Checksum: 0x1064D1AC
	Offset: 0x530
	Size: 0xF0
	Parameters: 1
	Flags: Linked
*/
function delete_all(array)
{
	foreach(ent in array)
	{
		if(isdefined(ent))
		{
			if(isstruct(ent))
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
	Checksum: 0xF4D332A7
	Offset: 0x628
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
	Checksum: 0xDFC5D02B
	Offset: 0x6B0
	Size: 0x164
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
	Checksum: 0x13ADB818
	Offset: 0x820
	Size: 0x154
	Parameters: 7
	Flags: Linked
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
	Checksum: 0x90D8E743
	Offset: 0x980
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
	Checksum: 0x939CAC6
	Offset: 0xAF0
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
	Checksum: 0x4F95C0DE
	Offset: 0xBD0
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
	Checksum: 0xD7082F47
	Offset: 0xC48
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
	Checksum: 0xEAC8226F
	Offset: 0xD88
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
	Checksum: 0x330206A8
	Offset: 0xEE8
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
	Checksum: 0x70053971
	Offset: 0x1088
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
	Checksum: 0x1F3FA023
	Offset: 0x10E8
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
	Checksum: 0xBE6DAC65
	Offset: 0x1128
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
	Checksum: 0xF57D41D
	Offset: 0x1170
	Size: 0x9E
	Parameters: 2
	Flags: None
*/
function flag_wait(array, str_flag)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(isdefined(ent) && !ent flag::get(str_flag))
		{
			ent util::waittill_either("death", str_flag);
			i = -1;
		}
	}
}

/*
	Name: flagsys_wait
	Namespace: array
	Checksum: 0x14300385
	Offset: 0x1218
	Size: 0x9E
	Parameters: 2
	Flags: None
*/
function flagsys_wait(array, str_flag)
{
	for(i = 0; i < array.size; i++)
	{
		ent = array[i];
		if(isdefined(ent) && !ent flagsys::get(str_flag))
		{
			ent util::waittill_either("death", str_flag);
			i = -1;
		}
	}
}

/*
	Name: flagsys_wait_any_flag
	Namespace: array
	Checksum: 0x6C6C7B5D
	Offset: 0x12C0
	Size: 0x106
	Parameters: 2
	Flags: Variadic
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
	Checksum: 0x3553499F
	Offset: 0x13D0
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
	Checksum: 0xB038C05B
	Offset: 0x1488
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
	Checksum: 0xFC080866
	Offset: 0x1510
	Size: 0xF6
	Parameters: 3
	Flags: Linked
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
	Checksum: 0x508B2EE9
	Offset: 0x1610
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
	Checksum: 0x4D81A85D
	Offset: 0x1770
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
	Checksum: 0x24F27D9A
	Offset: 0x17F8
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
	Checksum: 0x8382772B
	Offset: 0x18C8
	Size: 0x58
	Parameters: 1
	Flags: Linked
*/
function random(array)
{
	if(array.size > 0)
	{
		keys = getarraykeys(array);
		return array[keys[randomint(keys.size)]];
	}
}

/*
	Name: randomize
	Namespace: array
	Checksum: 0xF367DC79
	Offset: 0x1928
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
	Checksum: 0xC741A087
	Offset: 0x19C0
	Size: 0x64
	Parameters: 1
	Flags: Linked
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
	Checksum: 0xB0951F49
	Offset: 0x1A30
	Size: 0xD0
	Parameters: 4
	Flags: None
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
	Checksum: 0xB5BFFE30
	Offset: 0x1B08
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
	Checksum: 0xDDB14F09
	Offset: 0x1BA8
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
	Checksum: 0x8E423A42
	Offset: 0x1C58
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
			index = getlastarraykey(array);
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
	Name: pop_front
	Namespace: array
	Checksum: 0xA1B5B90
	Offset: 0x1D08
	Size: 0x62
	Parameters: 2
	Flags: Linked
*/
function pop_front(array, b_keep_keys = 1)
{
	index = getfirstarraykey(array);
	return pop(array, index, b_keep_keys);
}

/*
	Name: push
	Namespace: array
	Checksum: 0x4DA63223
	Offset: 0x1D78
	Size: 0x54
	Parameters: 3
	Flags: Linked
*/
function push(array, val, index = array.size + 1)
{
	arrayinsert(array, val, index);
}

/*
	Name: push_front
	Namespace: array
	Checksum: 0xF9995E8
	Offset: 0x1DD8
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
	Checksum: 0x30964933
	Offset: 0x1E18
	Size: 0x9C
	Parameters: 3
	Flags: Linked
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
	Checksum: 0xAB2A24E
	Offset: 0x1EC0
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
	Checksum: 0xA1E67D4C
	Offset: 0x1EE8
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
	Checksum: 0xF4B5E969
	Offset: 0x1F70
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
	Checksum: 0xBEEF50FB
	Offset: 0x1F98
	Size: 0x1E
	Parameters: 2
	Flags: None
*/
function fartherfunc(dist1, dist2)
{
	return dist1 <= dist2;
}

/*
	Name: get_all_farthest
	Namespace: array
	Checksum: 0x83AAE4F1
	Offset: 0x1FC0
	Size: 0xBA
	Parameters: 5
	Flags: None
*/
function get_all_farthest(org, array, a_exclude, n_max = array.size, n_maxdist)
{
	a_ret = exclude(array, a_exclude);
	if(isdefined(n_maxdist))
	{
		a_ret = arraysort(a_ret, org, 0, n_max, n_maxdist);
	}
	else
	{
		a_ret = arraysort(a_ret, org, 0, n_max);
	}
	return a_ret;
}

/*
	Name: get_all_closest
	Namespace: array
	Checksum: 0xF9FF38DD
	Offset: 0x2088
	Size: 0xBA
	Parameters: 5
	Flags: Linked
*/
function get_all_closest(org, array, a_exclude, n_max = array.size, n_maxdist)
{
	a_ret = exclude(array, a_exclude);
	if(isdefined(n_maxdist))
	{
		a_ret = arraysort(a_ret, org, 1, n_max, n_maxdist);
	}
	else
	{
		a_ret = arraysort(a_ret, org, 1, n_max);
	}
	return a_ret;
}

/*
	Name: alphabetize
	Namespace: array
	Checksum: 0xF0FA353C
	Offset: 0x2150
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
	Checksum: 0xAD92B592
	Offset: 0x2180
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
	Checksum: 0xC4811824
	Offset: 0x21D0
	Size: 0x42
	Parameters: 2
	Flags: Linked
*/
function sort_by_script_int(a_ents, b_lowest_first = 0)
{
	return merge_sort(a_ents, &_compare_script_int, b_lowest_first);
}

/*
	Name: merge_sort
	Namespace: array
	Checksum: 0x19A0E515
	Offset: 0x2220
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
	Checksum: 0xE1E9013E
	Offset: 0x23E8
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
	Checksum: 0x7D374CD4
	Offset: 0x2570
	Size: 0x196
	Parameters: 2
	Flags: Linked
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
	Checksum: 0xDDDAB2EA
	Offset: 0x2710
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
	Checksum: 0xCFF374A5
	Offset: 0x28B8
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
	Checksum: 0xC011E840
	Offset: 0x28F8
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
	Checksum: 0xD0B9C1AD
	Offset: 0x2998
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
	Name: function_460f3c24
	Namespace: array
	Checksum: 0xC51AB170
	Offset: 0x2A50
	Size: 0xDE
	Parameters: 2
	Flags: Linked
*/
function function_460f3c24(array1, array2)
{
	if(!isarray(array1) || !isarray(array2))
	{
		return 0;
	}
	if(array1.size != array2.size)
	{
		return 0;
	}
	foreach(key, v in array1)
	{
		if(v !== array2[key])
		{
			return 0;
		}
	}
	return 1;
}

/*
	Name: quick_sort
	Namespace: array
	Checksum: 0x84D34495
	Offset: 0x2B38
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
	Checksum: 0x226DB47B
	Offset: 0x2BA0
	Size: 0x14C
	Parameters: 4
	Flags: Linked
*/
function quick_sort_mid(array, start, end, compare_func)
{
	if((end - start) >= 1)
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
	Checksum: 0x9467495D
	Offset: 0x2CF8
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
	Checksum: 0xD512E6CC
	Offset: 0x2D50
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
	Checksum: 0x23F891F4
	Offset: 0x2D78
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
	Checksum: 0xF1D12BC6
	Offset: 0x2DF0
	Size: 0x10
	Parameters: 1
	Flags: None
*/
function _filter_undefined(val)
{
	return isdefined(val);
}

/*
	Name: _filter_dead
	Namespace: array
	Checksum: 0x791659BF
	Offset: 0x2E08
	Size: 0x22
	Parameters: 1
	Flags: None
*/
function _filter_dead(val)
{
	return isalive(val);
}

/*
	Name: _filter_classname
	Namespace: array
	Checksum: 0xD9969207
	Offset: 0x2E38
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
	Checksum: 0x4847EBA3
	Offset: 0x2E88
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
	Checksum: 0xE7F59342
	Offset: 0x2ED8
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
	Checksum: 0xDE16C409
	Offset: 0x2FA8
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
		println(((((("" + var_365f3054) + "") + minval) + "") + maxval) + "");
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
					assert(sorted_array[i] <= (sorted_array[i + 1]), "");
				#/
			}
		}
		else
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] >= (sorted_array[i + 1]), "");
				#/
			}
		}
		println("");
	#/
}

/*
	Name: function_81d0d595
	Namespace: array
	Checksum: 0xFD655ECF
	Offset: 0x3240
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
	Checksum: 0x11323D9E
	Offset: 0x3318
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
		println(((((("" + var_365f3054) + "") + minval) + "") + maxval) + "");
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
					assert(sorted_array[i] <= (sorted_array[i + 1]), "");
				#/
			}
		}
		else
		{
			for(i = 0; i < var_365f3054 - 1; i++)
			{
				/#
					assert(sorted_array[i] >= (sorted_array[i + 1]), "");
				#/
			}
		}
		println("");
	#/
}

