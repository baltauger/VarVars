package net.bauger.varvars.behaviors 
{
	/**
	 * Provider of engines for behaviors to use. Engines are based on Robert Penner's 
	 * easing equations http://www.robertpenner.com/easing/
	 * @author Balthazar Auger
	 */
	public class Engines 
	{
		public static const LINEAR:String = "linear";
		protected static function linear(t:Number, b:Number, c:Number, d:Number):Number 
		{
			return c*t/d + b;
		};
		
		public static const QUAD_IN:String = "quadIn";
		protected static function quadIn(t:Number, b:Number, c:Number, d:Number):Number 
		{
			return c*(t/=d)*t + b;
		};
		
		public static const QUAD_OUT:String = "quadOut";
		protected static function quadOut(t:Number, b:Number, c:Number, d:Number):Number 
		{
			return -c * (t/=d)*(t-2) + b;
		};
		
		public static const QUAD_INOUT:String = "quadInOut";
		protected static function quadInOut(t:Number, b:Number, c:Number, d:Number):Number 
		{
			if ((t/=d/2) < 1) return c/2*t*t + b;
			return -c/2 * ((--t)*(t-2) - 1) + b;
		};
		
		/**
		 * Returns the requested behavior engine function
		 * @param	engine
		 * @return a static easing function to be applied inside the behavior
		 */
		public static function retrieve(engine:String):Function
		{
			return Engines[engine];
		}
	}

}