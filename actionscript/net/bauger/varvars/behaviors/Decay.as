package net.bauger.varvars.behaviors 
{
	/**
	 * Decay VarVar Behavior
	 * @author Balthazar Auger
	 */
	public class Decay extends Behavior 
	{
		/**
		 * Brings back the VarVar's value to its specified baseValue
		 * @param	duration The duration (in ms) that the varvar will decay for
		 * @param	engine The type of curve this behavior will describe
		 */
		public function Decay(duration:int, engine:String = "quadInOut" ) 
		{
			super();
			this.duration = duration;
			this.engine = Engines.retrieve(engine);
		}
		
		override public function setBounds(baseValue:Number, curValue:Number, setValue:Number):void 
		{
			beginVal = setValue;
			endVal = baseValue;
		}
		
	}

}