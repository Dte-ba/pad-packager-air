package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	
    
	public class Datasheet 
	{
		
		private var _area:Area = null;
		
		private var _axis:Axis = null;
		
		private var _block:Block = null;
		
		private var _category:Array = null;
		
		private var _title:String = "";
		
		private var _tags:String = "";
		
		private var _description:String = "";
		
		// content
		private var _content:String = "";
		
		private var _contentAutor:String = "";
		
		private var _contentSource:String = "";
		
		public function Datasheet() 
		{
			
		}
		
		[Bindable]
		public function get area():Area 
		{			
			return _area;
		}
		
		public function set area(value:Area):void 
		{
			_area = value;
		}
		
		[Bindable]
		public function get axis():Axis 
		{
			return _axis;
		}
		
		public function set axis(value:Axis):void 
		{
			_axis = value;
		}
		
		[Bindable]
		public function get block():Block 
		{
			return _block;
		}
		
		public function set block(value:Block):void 
		{
			_block = value;
		}
		
		[Bindable]
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
		[Bindable]
		public function get content():String 
		{
			return _content;
		}
		
		public function set content(value:String):void 
		{
			_content = value;
		}
		
		[Bindable]
		public function get contentAutor():String 
		{
			return _contentAutor;
		}
		
		public function set contentAutor(value:String):void 
		{
			_contentAutor = value;
		}
		
		[Bindable]
		public function get contentSource():String 
		{
			return _contentSource;
		}
		
		public function set contentSource(value:String):void 
		{
			_contentSource = value;
		}
		
		[Bindable]
		public function get tags():String 
		{
			return _tags;
		}
		
		public function set tags(value:String):void 
		{
			_tags = value;
		}
		
		[Bindable]
		public function get description():String 
		{
			return _description;
		}
		
		public function set description(value:String):void 
		{
			_description = value;
		}
		
		[Bindable]
		public function get category():Array 
		{
			return _category;
		}
		
		public function set category(value:Array):void 
		{
			_category = value;
		}
		
		public function serializeToObject() : * 
		{
			var strArea:String = this.area != null ? this.area.name : CurricularDesign.UNDEFINED;
			var strAxis:String = this.axis != null ? this.axis.name : CurricularDesign.UNDEFINED;
			var strBlock:String = this.block != null ? this.block.name : CurricularDesign.UNDEFINED;
			
			var obj:* = {
				title: this.title,
				area: strArea,
				tags: this.tags,
				category: this.category,
				autor: this.contentAutor,
				source: this.contentSource,
				content: this.content,
				observations: this.description
			};
			
			return obj;
		}
		
	}

}