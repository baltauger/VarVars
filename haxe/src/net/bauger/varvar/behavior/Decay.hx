package net.bauger.varvar.behavior;

/**
 * Decay varvar behavior
 * @author Balthazar Auger
 */
class Decay extends Behavior
{
	/**
	 * Brings back the VarVar's value to its specified baseValue
	 * @param	duration The duration (in ms) that the varvar will decay for
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
		this.beginVal = setValue;
		this.endVal = baseValue;
	}
	
}