package net.bauger.varvars.behaviors 
{
	/**
	 * Attack VarVar Behavior
	 * @author Balthazar Auger
	 */
	public class Attack extends Behavior 
	{
		/**
		 * Brings the VarVar's value to the value set by the user
		 * @param	duration The duration (in ms) that the varvar will take to get to the set value
		 * @param	engine The type of curve this behavior will describe
		 */
		public function Attack(duration:int, engine:String = "quadInOut") 
		{
			super();
			
			this.duration = duration;
			this.engine = Engines.retrieve(engine);
		}
		
		override public function setBounds(baseValue:Number, curValue:Number, setValue:Number):void 
		{
			beginVal = curValue;
			endVal = setValue;
		}
	}

}