package com.dte.images 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class ImageEvent extends Event 
	{
		static public const CONVERTED:String = "converted";
		
		private var _file:File;
		
		public function ImageEvent(type:String, f:File) 
		{
			super(type, false, false);
			this.file = f;
		}
		
		public function get file():File 
		{
			return _file;
		}
		
		public function set file(value:File):void 
		{
			_file = value;
		}
		
	}

}