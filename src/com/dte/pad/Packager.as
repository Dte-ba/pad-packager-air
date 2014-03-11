package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.pad.ui.MessageRef;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import com.dte.pad.Package;
	import deng.fzip.FZip;
	import flash.utils.ByteArray;
	 
	public class Packager extends EventDispatcher
	{
	
		private var _target:com.dte.pad.Package;
		
		public function Packager(pack:com.dte.pad.Package) 
		{
			super();
			_target = pack;
		}
		
		protected function addFileToZip(zip:FZip, f:File, filename:String) : void {
			var fs:FileStream = new FileStream();
			fs.open(f, FileMode.READ);
			var fileBytes:ByteArray = new ByteArray();
			fs.readBytes(fileBytes);
			fs.close();
			zip.addFile(filename, fileBytes);
		}
		
		public function createZip() : FZip {
			var zip:FZip = new FZip();
			
			// metadata
			zip.addFileFromString("package.json", this.target.serialize());
			
			// assets
			if (this.target.imgThumb != null) {
				this.addFileToZip(zip, this.target.imgThumb, "assets/" + "front." + this.target.imgThumb.extension);	
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
		
		public function get target():com.dte.pad.Package 
		{
			return _target;
		}
		
		public function set target(value:com.dte.pad.Package):void 
		{
			_target = value;
		}
		
	}

}