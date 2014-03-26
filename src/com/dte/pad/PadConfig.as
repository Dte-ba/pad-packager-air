package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	[Event(name = Event.COMPLETE, type = "flash.events.Event")]
	public class PadConfig  extends EventDispatcher
	{		
		
		static public const CONFIG_FILENAME:String = "pad-config.json";
		
		static private var _instance:PadConfig;
		
		private var _loaded:Boolean = false;
		
		public var docsDir:File = File.applicationStorageDirectory; 
		
		private var _configFile:String = "";
		
		private var _packagesPath:String = "";
		
		private var _filesPath:String = "";
		
		private var _imagesPath:String = "";
		
		private var _token:SecurityToken;
		
		public function PadConfig() 
		{
			if (_instance!=null) {
				throw new Error("Singleton - Can't Instanstiate");
			}
			_configFile = docsDir.resolvePath(PadConfig.CONFIG_FILENAME).nativePath;
			
			_instance = this;
		}
		
		static public function getInstance() : PadConfig {
			if (_instance == null)
				_instance = new PadConfig();
			
			return _instance;
		}
		
		[Bindable]
		public function get loaded():Boolean 
		{
			return _loaded;
		}
		
		public function set loaded(value:Boolean):void 
		{
			_loaded = value;
		}
		
		public function get packagesPath():String 
		{
			return _packagesPath;
		}
		
		public function set packagesPath(value:String):void 
		{
			_packagesPath = value;
		}
		
		public function get imagesPath():String 
		{
			return _imagesPath;
		}
		
		public function set imagesPath(value:String):void 
		{
			_imagesPath = value;
		}
		
		public function get token():SecurityToken 
		{
			return _token;
		}
		
		public function set token(value:SecurityToken):void 
		{
			_token = value;
		}
		
		public function get filesPath():String 
		{
			return _filesPath;
		}
		
		public function set filesPath(value:String):void 
		{
			_filesPath = value;
		}
		
		public function load(def:Boolean = true) :void {
			var file:File = new File(_configFile);
			if (!file.exists) {
				loadDefault();
				return;
			}
			
			loadFromFile(file);
		}
		
		public function loadFromFile(file:File):void 
		{
			var meta:* = readConfig(file);
			if (meta == null) {
				loadDefault();
				return;
			}
						
			// load
			this.imagesPath = meta.imagesPath;
			this.packagesPath = meta.packagesPath;
			this.filesPath = meta.filesPath;
			
			if (this.imagesPath == null || this.imagesPath == "") {
				this.imagesPath = File.desktopDirectory.nativePath;
			}
			
			if (this.packagesPath == null || this.packagesPath == "") {
				this.packagesPath = File.desktopDirectory.nativePath;
			}
			
			if (this.filesPath == null || this.filesPath == "") {
				this.filesPath = File.desktopDirectory.nativePath;
			}
			
			if (meta.token !== null) {
				var vec:Vector.<String> = SecurityToken.convertArray(meta.token as Array);
				this.token = new SecurityToken(vec);
			}
			
			this.loaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function loadDefault():void 
		{
			this.imagesPath = File.desktopDirectory.nativePath;
			this.packagesPath = File.desktopDirectory.nativePath;
			this.filesPath = File.desktopDirectory.nativePath;
			this.token = null;
			
			this.loaded = true;
			this.dispatchEvent(new Event(Event.COMPLETE));
		}
		
		public function save(def:Boolean = true) :void {
			
			var file:File = new File(_configFile);
			
			var obj:* = {
				imagesPath: this.imagesPath,
				packagesPath: this.packagesPath,
				filesPath: this.filesPath,
				token: this.token.token
			};
			
			var fs:FileStream = new FileStream();
			fs.open(file, FileMode.WRITE);
			fs.writeUTFBytes(JSON.stringify(obj));
		}
		
		private function readConfig(file:File) : *
		{
			try {
				var fs:FileStream = new FileStream();
				fs.open(file, FileMode.READ);
				var feedJson:String = fs.readUTFBytes(fs.bytesAvailable);
				
				return JSON.parse(feedJson);
			} catch (err:Error) {
				trace("Error reading config file");
				trace(err);
			}
			
			return null;
		}
		
	}

}