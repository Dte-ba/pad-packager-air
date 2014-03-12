package com.dte.filesystem 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.formatters.StringFormatter;
	import com.dte.pad.ui.MessageRef;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	import mx.collections.ArrayCollection;
	import mx.collections.IList;
	import mx.events.CollectionEvent;
	import mx.binding.utils.BindingUtils;
	
	public class FileProvider 
	{
		
		[Bindable]private var _files:ArrayCollection;
		
		private var inputFile:File;
		
		private var _relativePath:String;
	    
		private var stringFormatter:StringFormatter;
		
		private var _totalSize:Number = 0;
		
		public function FileProvider() 
		{
			this.files = new ArrayCollection();
			this.stringFormatter = new StringFormatter();
			this.inputFile = File.desktopDirectory;
			this.stringFormatter = new StringFormatter();
			
			this.inputFile.addEventListener(FileListEvent.SELECT_MULTIPLE, onInputFilesSelected);
		    this.inputFile.addEventListener(Event.SELECT, onInputDirectorySelected);
			
			//this.files.addEventListener(CollectionEvent.COLLECTION_CHANGE, filesChange);
			BindingUtils.bindSetter(filesChange, this, "files");
		}
				
		// handlers
		private function onInputFilesSelected(e:FileListEvent):void {
			this.processIncomingFiles(e.files);
		}
		
		private function onInputDirectorySelected(e:Event):void {
			this.processIncomingFiles([this.inputFile]);
		}
		
		private function filesChange(val:ArrayCollection):void  {
			var newSize:Number = 0;
			for each(var f:File in val) {
				newSize += f.size;
			}
			this.totalSize = newSize;
		}
		
		// functions
		public function processIncomingFiles(files:Array):void {
			var allFiles:Array = new Array();
			this.findRelativePath(files);
			this.flattenDirectoryStructure(files, allFiles);
			this.files = new ArrayCollection(allFiles);
		}
		
		private function findRelativePath(files:Array):void {
			var depth:int = -1;
			var thisDepth:int = -1;
			for each (var f:File in files)
			{
				thisDepth = f.nativePath.split(File.separator).length;
				if (thisDepth < depth || depth == -1)
				{
					depth = thisDepth;
					this.relativePath = f.parent.nativePath;
				}
			}
		}
		
		private function flattenDirectoryStructure(files:Array, flatFiles:Array):void {
			for each (var f:File in files)
			{
				if (f.isDirectory) {
					this.flattenDirectoryStructure(f.getDirectoryListing(), flatFiles);
				} else {
					flatFiles.push(f);
				}
			}
		}
		
		// public functions
		public function getRelativeFileName(f:File):String {
			return f.nativePath.substring(this.relativePath.length + 1, f.nativePath.length);
		}
		
		public function addDialog(multiple:Boolean=false) : void {
			if ( !multiple ) {
				this.inputFile.browseForOpenMultiple(MessageRef.DIALOG_SELECT_FILES); //TODO: move the ref dialog
			} else { 
				this.inputFile.browseForDirectory(MessageRef.DIALOG_SELECT_FOLDER); //TODO: move the ref dialog
			}
		}
		
		public function reset() : void {
		   
		   this.files.removeAll();
		   this.totalSize = 0;
	   
	    }
		
		public function deleteFiles(list:IList) : void {
			var ds:Number = 0;
			
			for each(var f:File in list) {
				var idx:int = this.files.getItemIndex(f);
				this.files.removeItemAt(idx);
				ds += f.size;
				trace(f);
			}
			
			this.totalSize -= ds;
		}
		
		[Bindable]
		public function get files():ArrayCollection 
		{
			return _files;
		}
		
		public function set files(value:ArrayCollection):void 
		{
			_files = value;
		}
				
		[Bindable]
		public function get relativePath():String 
		{
			return _relativePath;
		}
		
		public function set relativePath(value:String):void 
		{
			_relativePath = value;
		}
		
		[Bindable]
		public function get totalSize():Number 
		{
			return _totalSize;
		}
		
		public function set totalSize(value:Number):void 
		{
			_totalSize = value;
			trace(_totalSize);
		}
		
		public function serializeToObject() : * 
		{
			var fs:Array = new Array();
			
			for each(var f:File in this.files) {
				fs.push( { filename: "files/" + this.getRelativeFileName(f), type: f.type } );
			}
			
			return fs;
		}
		
	}

}