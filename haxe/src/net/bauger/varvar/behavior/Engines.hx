package net.bauger.varvar.behavior;

/**
 * Provider of engines for behaviors to use. Engines are based on Robert Penner's 
 * easing equations http://www.robertpenner.com/easing/
 * @author Balthazar Auger
 */
class Engines
{
	public static function linear(t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*t/d + b;
	}
	
	public static function quadIn(t:Float, b:Float, c:Float, d:Float):Float 
	{
		return c*(t/=d)*t + b;
	}
	
	public static function quadOut(t:Float, b:Float, c:Float, d:Float):Float 
	{
		return -c * (t/=d)*(t-2) + b;
	}
	
	public static function quadInOut(t:Float, b:Float, c:Float, d:Float):Float 
	{
		if ((t/=d/2) < 1) return c/2*t*t + b;
		return -c/2 * ((--t)*(t-2) - 1) + b;
	}
}
	
