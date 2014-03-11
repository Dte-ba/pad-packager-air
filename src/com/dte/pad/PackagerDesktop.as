package com.dte.pad 
{
	
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.html.NativeAlert;
	import com.dte.pad.events.FileSaveEvent;
	import com.dte.pad.ui.MessageRef;
	import deng.fzip.FZip;
	import deng.fzip.FZipEvent;
	import deng.fzip.FZipFile;
	import flash.events.Event;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import flash.net.URLRequest;
	
	[Event(name = "saved", type = "com.dte.pad.events.FileSaveEvent")]
	[Event(name = "imported", type = "com.dte.pad.events.FileImportEvent")]
	public class PackagerDesktop extends Packager
	{
		
		private var outputFile:File;
		
		private var inputFile:File;
		
		private var packageFilter:FileFilter = new FileFilter("Tangible", "*.zip");
		
		private var alert:NativeAlert = new NativeAlert();
		
		public function PackagerDesktop(target:com.dte.pad.Package) 
		{
			super(target);
			this.outputFile = File.desktopDirectory;
			this.inputFile = File.desktopDirectory;
			this.outputFile.addEventListener(Event.SELECT, onOutputDirectorySelected);
			this.inputFile.addEventListener(Event.SELECT, onInputFileSelected);
			
		}
		
		private function onOutputDirectorySelected(e:Event):void {
			var outFile:String = this.outputFile.nativePath + "\\" + this.target.uid + ".zip";
			save(outFile);
		}
		
		private function onInputFileSelected(e:Event):void 
		{
			var tmp:File = File.createTempDirectory();
			
			trace(tmp.nativePath);
		
			var zip:FZip = new FZip();
			var request:URLRequest = new URLRequest(inputFile.nativePath);
			
			zip.addEventListener(Event.COMPLETE, function(ec:Event) : void { 
				var fc:uint = zip.getFileCount();
				for (var i:int = 0; i < fc; i++) 
				{
					var f:FZipFile = zip.getFileAt(i);
					var tfn:String = tmp.nativePath + "\\" + f.filename;
					
					var fs:FileStream = new FileStream();
					fs.open(new File(tfn), FileMode.WRITE);
					fs.writeBytes(f.content);
					fs.close();
				}
			} );
			zip.load(request);
		}
		
		public function importDialog() : void 
		{
			this.inputFile.browseForOpen(MessageRef.DIALOG_IMPORT_PACKAGE, [ packageFilter ]);
		}
		
		public function saveDialog() : void 
		{
			this.outputFile.browseForDirectory(MessageRef.DIALOG_SELECT_DEST_FOLDER);
		}
		
		public function save(filename:String) : void 
		{
			var saveFile:File = new File(filename);
			
			if (saveFile.exists) {
				
				alert.alert(MessageRef.ERROR_FILE_EXISTS);
				return;
			}
			
			var zip:FZip = this.createZip();

			var outFS:FileStream = new FileStream();
			outFS.open(saveFile, FileMode.WRITE);
			zip.serialize(outFS);
			outFS.close();
			
			this.dispatchEvent(new FileSaveEvent(filename));
		}
		
	}

}