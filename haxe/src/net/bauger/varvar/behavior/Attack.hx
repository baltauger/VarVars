package net.bauger.varvar.behavior;

/**
 * Attack VarVar Behavior
 * @author Balthazar Auger
 */
class Attack extends Behavior
{
	/**
	 * Brings the VarVar's value to the value set by the user
	 * @param	duration The duration (in ms) that the varvar will take to get to the set value
	 * @param	engine The type of curve this behavior will describe
	 */
	public function new(p_duration:Float, p_engine:Float->Float->Float->Float->Float) 
	{
		super();
		this.duration = p_duration;
		this.engine = p_engine;
	}
	
	override public function setBounds(baseValue:Float, curValue:Float, setValue:Float):Void 
	{
		this.beginVal = curValue;
		this.endVal = setValue;
	}
	
}