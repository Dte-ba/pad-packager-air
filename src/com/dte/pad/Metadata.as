package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	
	 
	public class Metadata 
	{
		
		private var _uid:String = "";
		
		private var _version:String = "";
		
		private var _token:Vector.<String> = null;
		
		private var _content:MetadataContent;
		
		public function Metadata(obj:Object) 
		{
			
			this.uid = obj.uid;
			this.version = obj.version;
			this.token = SecurityToken.convertArray(obj.token as Array);
			this.content = new MetadataContent(obj.content);
		}
		
		public function get uid():String 
		{
			return _uid;
		}
		
		public function set uid(value:String):void 
		{
			_uid = value;
		}
		
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(value:String):void 
		{
			_version = value;
		}
		
		public function get token():Vector.<String> 
		{
			return _token;
		}
		
		public function set token(value:Vector.<String>):void 
		{
			_token = value;
		}
		
		public function get content():MetadataContent 
		{
			return _content;
		}
		
		public function set content(value:MetadataContent):void 
		{
			_content = value;
		}
		
		public function fill(p:com.dte.pad.Package) : void 
		{
			p.version = this.version;
			p.token = new SecurityToken(this.token);
			p.oldUid = this.uid;
			p.datasheet = new Datasheet();
			this.content.fillDatasheet(p.datasheet);
		}
		
		public function getImgFront() : * 
		{
			return this.content.getImgFront();
		}
		
		public function getImgContent() : * 
		{
			return this.content.getImgContent();
		}
		
	}

}