package net.bauger.varvar;

import net.bauger.varvar.behavior.Behavior;

/**
 * VarVars (Variable Variables) allow configurable attack, sustain and decay behaviors for float values.
 * @author Balthazar Auger
 */
class VarVar
{
	/**
	 * Current value
	 */
	@:isVar public var value(get, set):Float;
	private var _value:Float;
	
	/**
	 * The manually set value
	 */
	private var _setValue:Float;
	 
	/**
	 * Vector of behavior objects for value calculations
	 */
	private var _behaviors:Array<Behavior>;
	
	/**
	 * Cached value life
	 */
	private var _cacheDelay:Float;
	
	/**
	 * Cached value
	 */
	private var _cachedValue:Float;
	
	/**
	 * The last time a fresh value was calculated
	 */
	private var _lastCalc:Float;
	
	/**
	 * The last tile the value of the VarVar was modified
	 */
	private var _lastModify:Float;
	
	/**
	 * Equilibrium value for this varvar
	 */
	private var _baseValue:Float;
	
	/**
	 * Minimum value for this varvar
	 */
	private var _minValue:Dynamic;
	
	/**
	 * Maximum value for this varvar
	 */
	private var _maxValue:Dynamic;
	
	/*
	 * Timing function callback
	 */
	private var _timing:Void->Float;
	
	/**
	 * VarVars can have either one of attack, sustain and decay behaviors added to them
	 * @param	timingCallback a function which, when called, returns the current time in milliseconds
	 * @param	baseValue The value the varvar starts at and will try to return to (in case of decay)
	 * @param	maxValue The biggest value the varvar can have
	 * @param	minValue The smallest value the varvar can have
	 * @param	cacheDelay How long the cached value will last
	 */
	public function new(timingCB:Void->Float, baseValue:Float = 0, maxValue:Dynamic = null, minValue:Dynamic = null, cacheDelay:Float = 0) 
	{
		_cacheDelay = cacheDelay;
			
		_baseValue = _value = _setValue = _cachedValue = baseValue;
		
		_minValue = minValue;
		_maxValue = maxValue;
		
		_timing = timingCB;
		
		_lastCalc = _lastModify = _timing();
		
		_behaviors = new Array<Behavior>();
	}
	
	/**
		 * Adds a behavior to this VarVar's timeline. This function returns the 
		 * VarVar so you can chain calls like so:
			 * _myVarVar.add(new Attack(1000)).add(new Sustain(300)).add(new Decay(200));
		 * You can add just one Behavior if you like
		 * @param	behavior The Behavior object to add to the VarVar
		 * @return The current VarVar object
		 */
		public function add(behavior:Behavior):VarVar
		{
			if (_behaviors.length > 0)
			{
				_behaviors[_behaviors.length -1].chain(behavior);
			}
			
			_behaviors.push(behavior);
			
			refreshBehaviorBounds();
			
			return this;
		}
		
		private function refreshBehaviorBounds():Void 
		{
			for (i in  0..._behaviors.length) 
			{
				_behaviors[i].setBounds(_baseValue, _value, _setValue);
			}
		}
		
		/**
		 * Returns the current value of the VarVar
		 */
		public function get_value()
		{
		//determine time since last value refresh
		var curTime:Float = _timing();
		var tSinceLastCalc:Float = curTime - _lastCalc;
		
		//check cache
		var cacheHit:Bool = tSinceLastCalc < _cacheDelay;
		if (cacheHit)
		{
			//trace ("cache hit!");
			return _cachedValue;
		}
		
		//determine time since value set
		var tSinceValueSet:Float = curTime - _lastModify;
		
		//apply the corresponding behavior and update cache
		_cachedValue = _value = _behaviors[0].apply(tSinceValueSet);

		_lastCalc = curTime;
		
		//return the value
		return _value;
	}
	
	/**
	 * Sets the VarVar's setValue, resetting the VarVar's timeline
	 */
	public function set_value(newValue:Float):Float 
	{
		//Log the time of modification
		_lastModify = _timing();
		
		//Commit values while respecting minimum and maximum bounds
		if (_minValue != null) newValue = Math.max(newValue, _minValue);
		
		if (_maxValue != null) newValue = Math.min(newValue, _maxValue);
		
		_setValue = newValue;
		
		//Recalculate start-end values of behaviors
		refreshBehaviorBounds();
		
		return _value;
	}
		
}