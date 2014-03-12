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
		
		private var _img:* = null;
		
		private var _axis:ArrayCollection;
		
		public function Area(obj:*=null) 
		{
			if (obj == null)  { return; }
			
			try {
				this.name = obj.area;
				
				for each(var axis:* in obj.axis) {
					this.axis.addItem( new Axis(axis) );
				}
				
				this.img = AreaImages.getInstance().getImage(this.name);
				
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
		
		[Bindable]
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		[Bindable]
		public function get img():* 
		{
			return _img;
		}
		
		public function set img(value:*):void 
		{
			_img = value;
		}
		
		public function getAxisByName(aName:String) : Axis 
		{
			
			if (this.axis == null || this.axis.length == 0)
			{
				return new Axis();
			}
			
			for each(var a:Axis in this.axis)
			{
				if (a.name == aName)
				{
					return a;
				}
			}
			
			return new Axis();
		}
		
	}

}