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
	import flash.events.Event;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.filesystem.File;
	
	[Event(name="saved", type="com.dte.pad.events.FileSaveEvent")]
	public class PackagerDesktop extends Packager
	{
		
		private var outputFile:File;
		
		private var alert:NativeAlert = new NativeAlert();
		
		public function PackagerDesktop(target:com.dte.pad.Package) 
		{
			super(target);
			this.outputFile = File.desktopDirectory;
			this.outputFile.addEventListener(Event.SELECT, onOutputDirectorySelected);
		}
		
		private function onOutputDirectorySelected(e:Event):void {
			var outFile:String = this.outputFile.nativePath + "\\" + this.target.uid + ".zip";
			save(outFile);
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