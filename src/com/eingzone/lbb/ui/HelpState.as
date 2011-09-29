package com.eingzone.lbb.ui
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class HelpState extends BaseOtherState 
	{
		[Embed(source="../../../../../src/assets/textures/ui/4259064206_86afd57db2.jpg")]
		private var bgClass:Class;
		
		public function HelpState() 
		{
			super("Help", bgClass);
		}
	}
}