package com.dte.pad 
{
	import mx.collections.ArrayCollection;
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class Area 
	{
		
		private var _name:String = CurricularDesign.UNDEFINED;
		
		private var _axis:ArrayCollection;
		
		public function Area(obj:*=null) 
		{
			try {
				this.name = obj.area;
				
				for each(var axis:* in obj.axis) {
					this.axis.addItem( new Axis(axis) );
				}
				
			} catch (e:Error) { }
		}
		
		[Bindable]
		public function get axis():ArrayCollection 
		{
			if (_axis == null) {
				_axis = new ArrayCollection();
			}
			
			return _axis;
		}
		
		public function set axis(value:ArrayCollection):void 
		{
			_axis = value;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
	}

}