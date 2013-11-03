package net.bauger.varvar.behavior;

/**
 * Sustain varvar behavior
 * @author Balthazar Auger
 */
class Sustain extends Behavior
{

	public function new(p_duration:Float)
	{
		super();
		this.duration = p_duration;
		this.engine = Engines.linear;
	}
	
	override public function setBounds(baseValue:Float, curValue:Float, setValue:Float):Void 
	{
		this.beginVal = this.endVal = setValue;
	}
	
}