package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.filesystem.FileProvider;
	import com.dte.pad.events.FileImportEvent;
	import com.dte.pad.ui.MessageRef;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import com.dte.pad.Package;
	import deng.fzip.FZip;
	import flash.utils.ByteArray;
	 
	[Event(name = "imported", type = "com.dte.pad.events.FileImportEvent")]
	public class Packager extends EventDispatcher
	{
		static public const METADATA_FILENAME:String = "package.json";
		
		private var _target:com.dte.pad.Package;
		
		private var _appVersion:String = "";
		
		public function Packager(pack:com.dte.pad.Package=null,version:String="0.1") 
		{
			super();
			_target = pack;
			this.appVersion = version;
		}
		
		public function get target():com.dte.pad.Package 
		{
			return _target;
		}
		
		public function set target(value:com.dte.pad.Package):void 
		{
			_target = value;
		}
		
		public function get appVersion():String 
		{
			return _appVersion;
		}
		
		public function set appVersion(value:String):void 
		{
			_appVersion = value;
		}
		
		protected function addFileToZip(zip:FZip, f:File, filename:String) : void 
		{
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var fileBytes:ByteArray = new ByteArray();
			fs.readBytes(fileBytes);
			fs.close();
			zip.addFile(filename, fileBytes);
		}
		
		public function createZip() : FZip 
		{
			var zip:FZip = new FZip();
			
			// metadata
			zip.addFileFromString(Packager.METADATA_FILENAME, this.target.serialize());
			
			// assets
			if (this.target.imgThumb != null) {
				this.addFileToZip(zip, this.target.imgThumb , "assets/" + "front." + this.target.imgThumb.extension);	
			}
			
			if (this.target.imgContent != null) {
				this.addFileToZip(zip, this.target.imgContent, "assets/" + "content." + this.target.imgContent.extension);	
			}
			
			// contenido
			for each (var f:File in this.target.fileProvider.files) {
				this.addFileToZip(zip, f, "files/" + this.target.fileProvider.getRelativeFileName(f));
			}
			
			return zip;
		}
		
		protected function processInputiFile(nativePath:String):void 
		{
			// check if the extracted zip is a package
			checkZipFolder(nativePath);
			
			var mainJson:String = nativePath + "\\" + Packager.METADATA_FILENAME;
			
			// load metadata from the main json file
			var metadata:Metadata = readMetadata(mainJson);
						
			// create the package
			// only non metadata properties
			this.target = new com.dte.pad.Package(this.appVersion);
			this.target.fileProvider = new FileProvider();
			// fill the package from metadata
			metadata.fill(this.target);
			
			// set covers
			var iFront:* = metadata.getImgFront();
			var iContent:* = metadata.getImgFront();
			this.target.imgThumb = new File(nativePath + "\\" + iFront.src);
			this.target.imgContent = new File(nativePath + "\\" + iContent.src);

			var arr:Array = new Array();
			
			for each (var objF:* in metadata.content.files) 
			{
				arr.push(new File(nativePath + "\\" + objF.filename));
			}
			
			this.target.fileProvider.processIncomingFiles(arr);
			
			this.dispatchEvent(new FileImportEvent(this.target));
		}
		
		static public function createPackage(version:String="") : com.dte.pad.Package
		{
			var p:com.dte.pad.Package;
						
			p = new com.dte.pad.Package(version);
			p.datasheet = new Datasheet();
			p.token = new SecurityToken();
			p.fileProvider = new FileProvider();
			
			return p;
		}
		
		private function checkZipFolder(nativePath:String):void 
		{
			var fc:File = new File(nativePath + "\\" + Packager.METADATA_FILENAME);
			
			if (!fc.exists) 
			{
				throw new Error("The zip is not a package");
			}
		}
		
		private function readMetadata(filename:String) : Metadata
		{
			var fs:FileStream = new FileStream();
			fs.open(new File(filename), FileMode.READ);
			var feedJson:String = fs.readUTFBytes(fs.bytesAvailable);
			
			return new Metadata(JSON.parse(feedJson));
		}
		
	}

}