package net.bauger.varvars 
{
	import flash.utils.getTimer;
	import net.bauger.varvars.behaviors.*;
	/**
	 * VarVars (Variable Variables) allow configurable increase, sustain and decay behaviors.
	 * @author Balthazar Auger
	 */
	public class VarVar extends Object 
	{
		/**
		 * Current value
		 */
		protected var _value:Number;
		
		/**
		 * The manually set value
		 */
		protected var _setValue:Number;
		 
		/**
		 * Vector of behavior objects for value calculations
		 */
		protected var _behaviors:Vector.<Behavior>;
		
		/**
		 * Cached value life
		 */
		protected var _cacheDelay:Number;
		
		/**
		 * Cached value
		 */
		protected var _cachedValue:Number;
		
		/**
		 * The last time a fresh value was calculated
		 */
		protected var _lastCalc:Number;
		
		/**
		 * The last tile the value of the VarVar was modified
		 */
		protected var _lastModify:Number;
		
		/**
		 * Equilibrium value for this varvar
		 */
		protected var _baseValue:Number;
		
		/**
		 * VarVars can have either one of attack, sustain and decay behaviors added to them
		 * @param	baseValue The value the varvar starts at and will try to return to (in case of decay)
		 * @param	cacheDelay How long the cached value will last
		 */
		public function VarVar(baseValue:Number = 0, cacheDelay:Number = 0)
		{
			super();
			
			_cacheDelay = cacheDelay;
			
			_baseValue = _value = _setValue = _cachedValue = baseValue;
			
			_lastCalc = _lastModify = getTimer();
			
			_behaviors = new Vector.<Behavior>;
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
			
			return this;
		}
		
		private function refreshBehaviorBounds():void 
		{
			for (var i:int = 0; i < _behaviors.length; i++) 
			{
				_behaviors[i].setBounds(_baseValue, _value, _setValue);
			}
		}
		
		/**
		 * Returns the current value of the VarVar
		 */
		public function get value():Number 
		{
			//determine time since last value refresh
			var curTime:Number = getTimer();
			var tSinceLastCalc:Number = curTime - _lastCalc;
			
			//check cache
			var cacheHit:Boolean = tSinceLastCalc < _cacheDelay;
			if (cacheHit)
			{
				//trace ("cache hit!");
				return _cachedValue;
			}
			
			//determine time since value set
			var tSinceValueSet:Number = curTime - _lastModify;
			
			//apply the corresponding behavior and update cache
			_cachedValue = _value = _behaviors[0].apply(tSinceValueSet);

			_lastCalc = curTime;
			
			//return the value
			return _value;
		}
		
		/**
		 * Sets the VarVar's setValue, resetting the VarVar's timeline
		 */
		public function set value(value:Number):void 
		{
			//Log the time of modification
			_lastModify = getTimer();
			
			//Commit values
			_setValue = value;
			
			//Recalculate start-end values of behaviors
			refreshBehaviorBounds();
		}
		
	}

}