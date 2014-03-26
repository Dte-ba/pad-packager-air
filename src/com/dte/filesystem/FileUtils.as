package com.dte.filesystem 
{
	import flash.filesystem.File;
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class FileUtils 
	{
		
		public function FileUtils() 
		{
			throw new Error("Utils Class - Can't Instanstiate");
		}
		
		static public function getFolderName(file:*) : String {
			var f:File;
			
			if (file is String) {
				f = new File(file);
			} else {
				f = File(file);
			}

			if (f == null) return null;
			
			if (f.isDirectory) return f.nativePath;
			
			var nt:String = f.nativePath;
			var lt:int = nt.lastIndexOf("\\");
			
			if (lt == -1) {
				lt = nt.lastIndexOf("/");
			}
			
			if (lt == -1) {
				return nt;
			}
			
			return nt.substring(0, nt.lastIndexOf("\\"));
			
		}
		
	}

}