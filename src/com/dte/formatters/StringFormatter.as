package com.dte.formatters 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import mx.formatters.DateFormatter;
	import mx.formatters.NumberFormatter;

	public class StringFormatter
	{
		private var dateFormatter:DateFormatter;
		private var numberFormatter:NumberFormatter;

		public function StringFormatter()
		{
			this.dateFormatter = new DateFormatter();
			this.dateFormatter.formatString = "MMM D, YYYY L:NN A";
			this.numberFormatter = new NumberFormatter();
		}
		
		public function getFormattedFileSize(fileSize:Number):String
		{
			var units:String;
			var test:Number = 1024;
			if (fileSize < test) units = "B";
			else if (fileSize < (test *= 1024)) units = "KB";
			else if (fileSize < (test *= 1024)) units = "MB";
			else if (fileSize < (test *= 1024)) units = "GB";
			return (this.numberFormatter.format(Math.round(fileSize/(test/1024))) + units);
		}
		
		public function getFormattedDate(d:Date):String
		{
			return this.dateFormatter.format(d);
		}
	}

}