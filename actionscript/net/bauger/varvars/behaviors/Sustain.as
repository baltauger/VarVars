package net.bauger.varvars.behaviors 
{
	/**
	 * Sustain VarVar Behavior
	 * @author Balthazar Auger
	 */
	public class Sustain extends Behavior 
	{
		/**
		 * Hold the VarVar value for a specified amount of time
		 * @param	duration The amount of time (in ms) the VarVar will hold at the set value
		 */
		public function Sustain(duration:int) 
		{
			super();
			this.duration = duration;
			this.engine = Engines.retrieve(Engines.LINEAR);
		}
		
		override public function setBounds(baseValue:Number, curValue:Number, setValue:Number):void 
		{
			beginVal = endVal = setValue;
		}
	}

}