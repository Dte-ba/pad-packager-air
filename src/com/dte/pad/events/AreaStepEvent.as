package com.dte.pad.events 
{
	import com.dte.pad.Area;
	import flash.events.Event;
	
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class AreaStepEvent extends Event 
	{
		static public const AREA_SELECTED:String = "areaSelected";
		
		private var _area:Area = null;
		
		public function AreaStepEvent(type:String, area:Area, bubbles:Boolean=false, cancelable:Boolean=false) 
		{
			super(type, bubbles, cancelable);
			
			this.area = area;
		}
		
		public function get area():Area 
		{
			return _area;
		}
		
		public function set area(value:Area):void 
		{
			_area = value;
		}
		
	}

}