package com.dte.pad.events 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.pad.Package;
	import flash.events.Event;
	
	public class PackageEvent extends Event 
	{
		static public const PACKAGE_CREATED:String = "packageCreated";
		
		private var _targetPackage:com.dte.pad.Package = null;
		
		private var _status:String = "";
		
		public function PackageEvent(type:String, p:com.dte.pad.Package, status:String="new") 
		{
			super(type, false, false);
			this._targetPackage = p;
			this._status = status;
		}
		
		public function get targetPackage():com.dte.pad.Package 
		{
			return _targetPackage;
		}
		
		public function get status():String 
		{
			return _status;
		}
		
	}

}