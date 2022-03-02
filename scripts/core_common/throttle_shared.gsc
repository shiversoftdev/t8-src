// Decompiled by Serious. Credits to Scoba for his original tool, Cerberus, which I heavily upgraded to support remaining features, other games, and other platforms.
class throttle 
{
	var queue_;
	var processed_;
	var processlimit_;
	var var_3cd6b18f;
	var updaterate_;

	/*
		Name: constructor
		Namespace: throttle
		Checksum: 0xCF965234
		Offset: 0xA8
		Size: 0x66
		Parameters: 0
		Flags: Linked, 8
	*/
	constructor()
	{
		self.queue_ = [];
		self.processed_ = 0;
		self.processlimit_ = 1;
		self.var_3cd6b18f = [];
		self.updaterate_ = float(function_60d95f53()) / 1000;
	}

	/*
		Name: destructor
		Namespace: throttle
		Checksum: 0x80F724D1
		Offset: 0x118
		Size: 0x4
		Parameters: 0
		Flags: Linked, 16
	*/
	destructor()
	{
	}

	/*
		Name: function_5ef47bb4
		Namespace: throttle
		Checksum: 0x269F96D9
		Offset: 0x498
		Size: 0x24
		Parameters: 1
		Flags: Linked
	*/
	function function_5ef47bb4(entity)
	{
		arrayremovevalue(queue_, entity);
	}

	/*
		Name: wm_ht_posidlestart
		Namespace: throttle
		Checksum: 0xBA410401
		Offset: 0x468
		Size: 0x22
		Parameters: 1
		Flags: Linked
	*/
	function wm_ht_posidlestart(entity)
	{
		return isinarray(queue_, entity);
	}

	/*
		Name: waitinqueue
		Namespace: throttle
		Checksum: 0x2D25EE26
		Offset: 0x308
		Size: 0x154
		Parameters: 1
		Flags: Linked
	*/
	function waitinqueue(entity = randomint(2147483647))
	{
		if(processed_ >= processlimit_)
		{
			nextqueueindex = (queue_.size > 0 ? getlastarraykey(queue_) + 1 : 0);
			self.queue_[nextqueueindex] = entity;
			firstinqueue = 0;
			while(!firstinqueue)
			{
				if(!isdefined(entity))
				{
					return;
				}
				firstqueueindex = getfirstarraykey(queue_);
				if(processed_ < processlimit_ && queue_[firstqueueindex] === entity)
				{
					firstinqueue = 1;
					self.queue_[firstqueueindex] = undefined;
				}
				else
				{
					self.var_3cd6b18f[var_3cd6b18f.size] = entity;
					wait(updaterate_);
				}
			}
		}
		self.processed_++;
	}

	/*
		Name: initialize
		Namespace: throttle
		Checksum: 0xADAC57EE
		Offset: 0x268
		Size: 0x94
		Parameters: 2
		Flags: Linked
	*/
	function initialize(processlimit = 1, updaterate = float(function_60d95f53()) / 1000)
	{
		self.processlimit_ = processlimit;
		self.updaterate_ = updaterate;
		self thread _updatethrottlethread(self);
	}

	/*
		Name: _updatethrottle
		Namespace: throttle
		Checksum: 0x6910F927
		Offset: 0x128
		Size: 0x132
		Parameters: 0
		Flags: Linked, Private
	*/
	function private _updatethrottle()
	{
		self.processed_ = 0;
		currentqueue = queue_;
		self.queue_ = [];
		foreach(item in currentqueue)
		{
			if(!isdefined(item))
			{
				continue;
			}
			foreach(var_fe3b6341 in var_3cd6b18f)
			{
				if(item === var_fe3b6341)
				{
					self.queue_[queue_.size] = item;
					break;
				}
			}
		}
		self.var_3cd6b18f = [];
	}

	/*
		Name: _updatethrottlethread
		Namespace: throttle
		Checksum: 0x2C744361
		Offset: 0x68
		Size: 0x34
		Parameters: 1
		Flags: Linked, Private
	*/
	function private _updatethrottlethread(throttle)
	{
		while(isdefined(throttle))
		{
			[[ throttle ]]->_updatethrottle();
			wait(throttle.updaterate_);
		}
	}

}

