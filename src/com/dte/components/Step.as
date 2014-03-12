package com.dte.components 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import spark.components.NavigatorContent;
	
	public class Step extends NavigatorContent 
	{
		
		private var _caption:String = "";
		
		private var _enableToolBar:Boolean = true;
		
		private var _enableBack:Boolean = true;
		
		private var _enableNext:Boolean = true;
		
		public function Step() 
		{
			super();
		}
		
		public function isValid() : Boolean
		{
			return true;
		}
		
		public function activate(from:String="") : void
		{
			
		}
		
		[Bindable]
		public function get caption():String 
		{
			return _caption;
		}
		
		public function set caption(value:String):void 
		{
			_caption = value;
		}
		
		[Bindable]
		public function get enableToolBar():Boolean 
		{
			return _enableToolBar;
		}
		
		public function set enableToolBar(value:Boolean):void 
		{
			_enableToolBar = value;
		}
		
		public function get enableBack():Boolean 
		{
			return _enableBack;
		}
		
		public function set enableBack(value:Boolean):void 
		{
			_enableBack = value;
		}
		
		public function get enableNext():Boolean 
		{
			return _enableNext;
		}
		
		public function set enableNext(value:Boolean):void 
		{
			_enableNext = value;
		}
		
		public function reset() : void 
		{
			
		}
		
	}

}