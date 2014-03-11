package com.dte.pad.events 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import flash.events.Event;
	
	public class FileSaveEvent extends Event 
	{
		static public const SAVED:String = "saved";
		
		private var _filename:String = "";
		
		public function FileSaveEvent(filename:String) 
		{
			super(FileSaveEvent.SAVED, false, false);
			this.filename = filename;
		}
		
		public function get filename():String 
		{
			return _filename;
		}
		
		public function set filename(value:String):void 
		{
			_filename = value;
		}
		
	}

}