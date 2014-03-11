package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	
	import com.dte.filesystem.FileProvider;
	import com.hurlant.crypto.hash.SHA1;
	import flash.filesystem.File;
	import flash.utils.ByteArray;
	import com.hurlant.util.Hex;
	import mx.collections.ArrayCollection;
	import com.dte.crypto.AESUtils;
		
	public class Package 
	{
		private var _uid:String = "";

		private var _version:String = "";
		
		// datasheet
		private var _datasheet:Datasheet = null;
		
		// credentials
		private var _token:SecurityToken = null;
		
		// files
		private var _imgThumb:File;
		
		private var _imgContent:File;
		
		private var _fileProvider:FileProvider;
		
		public function Package(version:String="0.1")  {
			
			this._uid = createUid();
			this.version = version;
		}
		
		public function get uid():String  {
			return _uid;
		}
		
		[Bindable]
		public function get version():String 
		{
			return _version;
		}
		
		public function set version(value:String):void 
		{
			_version = value;
		}
		
		[Bindable]
		public function get token():SecurityToken 
		{
			return _token;
		}
		
		public function set token(value:SecurityToken):void 
		{
			_token = value;
		}
		
		[Bindable]
		public function get imgThumb():File 
		{
			return _imgThumb;
		}
		
		public function set imgThumb(value:File):void 
		{
			_imgThumb = value;
		}
		
		[Bindable]
		public function get imgContent():File 
		{
			return _imgContent;
		}
		
		public function set imgContent(value:File):void 
		{
			_imgContent = value;
		}
		
		[Bindable]
		public function get datasheet():Datasheet 
		{
			return _datasheet;
		}
		
		public function set datasheet(value:Datasheet):void 
		{
			_datasheet = value;
		}
		
		[Bindable]
		public function get fileProvider():FileProvider 
		{
			return _fileProvider;
		}
		
		public function set fileProvider(value:FileProvider):void 
		{
			_fileProvider = value;
		}
				
		private static function createUid() : String {
			var toHash:String = (new Date()).getTime().toString() + Math.random().toString();
			
			var key:ByteArray = Hex.toArray(toHash);
			var hasher:SHA1 = new SHA1();
			
			var hashed:ByteArray = hasher.hash(key);
			
			var uid:String = Hex.fromArray(hashed);
						
			return uid;
		}
		
		public function serialize() : String 
		{
			var obj:* = { };
			
			obj.version = this.version;
			obj.uid = this.uid;
			
			// create the content
			if (this.datasheet == null)
			{
				throw new Error("The datasheet is null");
			}
			
			var content:* = this.datasheet.serializeToObject();
			
			content.images = [ ];
			
			if (this.imgThumb != null) {
				content.images.push( {
					type: 'front',
					src: "assets/" + "front." + this.imgThumb.extension
				});
			}
			
			if (this.imgContent != null) {
				content.images.push( {
					type: 'content',
					src: "assets/" + "content." + this.imgContent.extension
				});
			}
			
			content.files = this.fileProvider.serializeToObject();
			
			obj.content = content;
			
			// token
			obj.token = this.token.serializeToObject();
			
			return JSON.stringify(obj);
		}
		
	}

}
