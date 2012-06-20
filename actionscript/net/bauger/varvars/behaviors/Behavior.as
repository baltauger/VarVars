package net.bauger.varvars.behaviors 
{
	/**
	 * Behaviors are chained in a VarVar to change its value
	 * @author Balthazar Auger
	 */
	public class Behavior 
	{
		/**
		 * How long this behavior will last (in milliseconds)
		 */
		public var duration:Number;
		
		/**
		 * Beginning value for this behavior. Needs to be updated every time the VarVar is assigned a new value.
		 */
		public var beginVal:Number
		
		/**
		 * Final value for this behavior
		 */
		public var endVal:Number;
		
		/**
		 * The function that realizes the behavior
		 */
		public var engine:Function;
		
		/**
		 * The behavior after this one
		 */
		public var next:Behavior;
		
		/**
		 * The behavior before this one
		 */
		public var previous:Behavior;
		
		public function Behavior() 
		{
			
		}
		
		/**
		 * Calculate this behavior's value according to time. If time is larger than this 
		 * behavior's duration, pass the calculations onto the next behavior or return the final
		 * value if there is no next behavior
		 * @param	time The amount of time since the value was set
		 * @return
		 */
		public function apply(time:Number):Number
		{
			if (time <= duration)
			{
				return engine(time, beginVal, diffVal, duration);
			}
			else if (next != null)
			{
				return next.apply(time - duration);
			}
			else
			{
				return endVal;
			}
		}
		
		/**
		 * Make this behavior the specified behavior's predecessor
		 * @param	to the Behavior that comes after this one
		 */
		public function chain(to:Behavior):void
		{
			to.previous = this;
			next = to;
		}
		
		/**
		 * Update bounds of this behavior
		 * @param	baseValue the VarVar's base value
		 * @param	curValue the VarVar's current value
		 * @param	setValue the VarVar's user-set value
		 */
		public function setBounds(baseValue:Number, curValue:Number, setValue:Number):void
		{
			
		}
		
		/**
		 * Difference between endVal and beginVal
		 */
		public function get diffVal():Number
		{
			return endVal - beginVal;
		}

	}

}