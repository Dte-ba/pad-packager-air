package com.dte.pad.events 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.pad.Package;
	import flash.events.Event;
	
	public class FileImportEvent extends Event 
	{
		static public const IMPORTED:String = "imported";
		
		private var _targetPackage:com.dte.pad.Package;
		
		public function FileImportEvent(pack:com.dte.pad.Package) 
		{
			super(FileImportEvent.IMPORTED, false, false);
			this.targetPackage = pack;
		}
		
		public function get targetPackage():com.dte.pad.Package 
		{
			return _targetPackage;
		}
		
		public function set targetPackage(value:com.dte.pad.Package):void 
		{
			_targetPackage = value;
		}
		
	}

}