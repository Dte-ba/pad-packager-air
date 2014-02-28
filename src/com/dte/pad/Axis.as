package com.dte.pad 
{
	import mx.collections.ArrayCollection;
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class Axis 
	{
		private var _name:String = CurricularDesign.UNDEFINED;
		
		private var _blocks:ArrayCollection;
		
		public function Axis(obj:*=null) 
		{
			try {
				this.name = obj.name;
				
				for each(var block:* in obj.blocks) {
					this.blocks.addItem( new Block(block) );
				}
				
			} catch (e:Error) { }
		}
		
		[Bindable]
		public function get blocks():ArrayCollection 
		{
			if (_blocks == null) {
				_blocks = new ArrayCollection();
			}
			return _blocks;
		}
		
		public function set blocks(value:ArrayCollection):void 
		{
			_blocks = value;
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