package net.bauger.varvar.behavior;

/**
 * Behaviors are chained in a VarVar to change its value
 * @author Balthazar Auger
 */
class Behavior
{
	/**
	 * How long this behavior will last (in milliseconds)
	 */
	public var duration:Float;
	
	/**
	 * Beginning value for this behavior. Needs to be updated every time the VarVar is assigned a new value.
	 */
	public var beginVal:Float;
	
	/**
	 * Final value for this behavior
	 */
	public var endVal:Float;
	
	/**
	 * The function that realizes the behavior
	 */
	public var engine:Float->Float->Float->Float->Float;
	
	/**
	 * The behavior after this one
	 */
	public var next:Behavior;
	
	/**
	 * The behavior before this one
	 */
	public var previous:Behavior;
	
	public var diffVal(get,set):Float;
	
	public function new() 
	{
		
	}
	
	/**
	 * Calculate this behavior's value according to time. If time is larger than this 
	 * behavior's duration, pass the calculations onto the next behavior or return the final
	 * value if there is no next behavior
	 * @param	time The amount of time since the value was set
	 * @return
	 */
	public function apply(time:Float):Float
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
	public function chain(to:Behavior):Void
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
	public function setBounds(baseValue:Float, curValue:Float, setValue:Float):Void
	{
		
	}
	
	/**
	 * Difference between endVal and beginVal
	 */
	public function get_diffVal():Float
	{
		return endVal - beginVal;
	}
	
	public function set_diffVal(i):Float
	{
		return i;
	}

}