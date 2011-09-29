package com.eingzone.lbb.ui
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * ...
	 * @author GameCloudStudio
	 */
	public class OptionState extends BaseOtherState 
	{
		[Embed(source="../../../../../src/assets/textures/ui/avatar_75941_1312123907.png")]
		private var bgClass:Class;
		
		public function OptionState() 
		{
			super("This is potion",bgClass);
		}
	}
}