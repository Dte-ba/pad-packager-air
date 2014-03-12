package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class Block 
	{
		private var _name:String = CurricularDesign.UNDEFINED;
		
		public function Block(name:String="") 
		{
			if (name == "") { return; }
			
			this.name = name;
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