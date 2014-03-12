package com.dte.pad 
{
	import mx.collections.ArrayCollection;
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	
	public class MetadataContent 
	{
		private var _tags:String = "";
		
		private var _images:Array;
		
		private var _content:String = "";
		
		private var _area:String = "";
		
		private var _axis:String = "";
		
		private var _block:String = "";
		
		private var _title:String = "";
		
		private var _files:Array;
		
		private var _observations:String = "";
		
		private var _autor:String = "";
		
		private var _source:String = "";
		
		public function MetadataContent(obj:*) 
		{
			this.tags = obj.tags;
			this.images = obj.images as Array;
			this.content = obj.content;
			this.area = obj.area;
			this.axis = obj.axis;
			this.block = obj.block;
			this.title = obj.title;
			this.files = obj.files as Array;
			this.observations = obj.observations;
			this.autor = obj.autor;
			this.source = obj.source;
		}
				
		public function get tags():String 
		{
			return _tags;
		}
		
		public function set tags(value:String):void 
		{
			_tags = value;
		}
		
		public function get images():Array
		{
			return _images;
		}
		
		public function set images(value:Array):void 
		{
			_images = value;
		}
		
		public function get content():String 
		{
			return _content;
		}
		
		public function set content(value:String):void 
		{
			_content = value;
		}
		
		public function get area():String 
		{
			return _area;
		}
		
		public function set area(value:String):void 
		{
			_area = value;
		}
		
		public function get axis():String 
		{
			return _axis;
		}
		
		public function set axis(value:String):void 
		{
			_axis = value;
		}
		
		public function get block():String 
		{
			return _block;
		}
		
		public function set block(value:String):void 
		{
			_block = value;
		}
		
		public function get title():String 
		{
			return _title;
		}
		
		public function set title(value:String):void 
		{
			_title = value;
		}
		
		public function get files():Array 
		{
			return _files;
		}
		
		public function set files(value:Array):void 
		{
			_files = value;
		}
		
		public function get observations():String 
		{
			return _observations;
		}
		
		public function set observations(value:String):void 
		{
			_observations = value;
		}
		
		public function get autor():String 
		{
			return _autor;
		}
		
		public function set autor(value:String):void 
		{
			_autor = value;
		}
		
		public function get source():String 
		{
			return _source;
		}
		
		public function set source(value:String):void 
		{
			_source = value;
		}
				
		public function fillDatasheet(ds:Datasheet):void 
		{
			ds.tags = this.tags;
			ds.content = this.content;
			ds.title = this.title;
			ds.description = this.observations;
			ds.contentAutor = this.autor;
			ds.contentSource = this.source;
			
			ds.area =  CurricularDesign.getInstance().getAreaByName(this.area);
			ds.axis = ds.area.getAxisByName(this.axis);
			ds.block = ds.axis.getBlockByName(this.block);
		}
		
		private function getImgByType(type:String) : *
		{
			if (this.images == null || this.images.length == 0)
			{
				return null;
			}
			
			for each(var i:* in this.images)
			{
				if (i.type == type) return i;
			}
			
			return null;
		}
		
		public function getImgFront():* 
		{
			return this.getImgByType("front");
		}
		
		public function getImgContent():* 
		{
			return this.getImgByType("content");
		}
		
	}

}