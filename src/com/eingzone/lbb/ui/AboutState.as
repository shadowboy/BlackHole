package com.eingzone.lbb.ui 
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class AboutState extends BaseOtherState
	{
		[Embed(source="../../../../../src/assets/textures/ui/4345441923_305fbde3a7.jpg")]
		private var bgClass:Class;
		
		public function AboutState() 
		{
			super("I'm about~",bgClass);
		}
	}
}