package com.dte.images 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import com.adobe.images.BitString;
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	import flash.display.Bitmap;
	import flash.display.PixelSnapping;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import com.dte.images.ImageEvent
	
	[Event(name = ImageEvent.CONVERTED, type = "com.dte.images.ImageEvent")]
	public class ImageConverter extends EventDispatcher 
	{
		
		private static const IDEAL_RESIZE_PERCENT:Number = .5;
		
		private var _width:uint;
		
		private var _height:uint;
		
		public var quality:int = 100;
		
		public function ImageConverter() 
		{
			super();
		}
		
		public static function resizeImage_HQ(source:BitmapData, width:uint, height:uint, constrainProportions:Boolean = true):BitmapData
		{
			var scaleX:Number = width/source.width;
			var scaleY:Number = height/source.height;
			if (constrainProportions) {
				if (scaleX > scaleY) scaleX = scaleY;
				else scaleY = scaleX;
			}

			var bitmapData:BitmapData = source;

			if (scaleX >= 1 && scaleY >= 1) {
				bitmapData = new BitmapData(Math.ceil(source.width*scaleX), Math.ceil(source.height*scaleY), true, 0);
				bitmapData.draw(source, new Matrix(scaleX, 0, 0, scaleY), null, null, null, true);
				return bitmapData;
			}

			// scale it by the IDEAL for best quality
			var nextScaleX:Number = scaleX;
			var nextScaleY:Number = scaleY;
			while (nextScaleX < 1) nextScaleX /= IDEAL_RESIZE_PERCENT;
			while (nextScaleY < 1) nextScaleY /= IDEAL_RESIZE_PERCENT;

			if (scaleX < IDEAL_RESIZE_PERCENT) nextScaleX *= IDEAL_RESIZE_PERCENT;
			if (scaleY < IDEAL_RESIZE_PERCENT) nextScaleY *= IDEAL_RESIZE_PERCENT;

			var temp:BitmapData = new BitmapData(bitmapData.width*nextScaleX, bitmapData.height*nextScaleY, true, 0);
			temp.draw(bitmapData, new Matrix(nextScaleX, 0, 0, nextScaleY), null, null, null, true);
			bitmapData = temp;

			nextScaleX *= IDEAL_RESIZE_PERCENT;
			nextScaleY *= IDEAL_RESIZE_PERCENT;

			while (nextScaleX >= scaleX || nextScaleY >= scaleY) {
				var actualScaleX:Number = nextScaleX >= scaleX ? IDEAL_RESIZE_PERCENT : 1;
				var actualScaleY:Number = nextScaleY >= scaleY ? IDEAL_RESIZE_PERCENT : 1;
				temp = new BitmapData(bitmapData.width*actualScaleX, bitmapData.height*actualScaleY, true, 0);
				temp.draw(bitmapData, new Matrix(actualScaleX, 0, 0, actualScaleY), null, null, null, true);
				bitmapData.dispose();
				nextScaleX *= IDEAL_RESIZE_PERCENT;
				nextScaleY *= IDEAL_RESIZE_PERCENT;
				bitmapData = temp;
			}

			return bitmapData;
		}
		
		public function handleImageComplete(event:Event):void 
		{
			var loader:Loader = Loader(event.target.loader); 
						
			var jpgSource:BitmapData = new BitmapData (loader.width, loader.height);
			jpgSource.draw(loader.content);
			
			var originalimgwidth:Number= loader.width; 
			var originalimgheight:Number = loader.height; 

			var scaled:BitmapData = resizeImage_HQ(jpgSource, this._width, this._height);

			var jpgEncoder:JPGEncoder = new JPGEncoder(this.quality);
			var jpgStream:ByteArray = jpgEncoder.encode(scaled);

			var newimagefile:File=new File(); 
			// T = Thumbnail 
			// 1 = next id in the db 
			// for now we use a random number 
			var random:Number= Math.random(); 
			random = Math.ceil(random*100);// to get a positive number 

			var tmp:File = File.createTempDirectory();
			var filenameForSave:String="T"+random; //new filename; 
			newimagefile = tmp.resolvePath(filenameForSave + ".jpg"); //image path 
			
			// TODO: delete me
			trace(newimagefile.nativePath);

			var stream:FileStream = new FileStream; // create new filestream 
			stream.open(newimagefile, FileMode.WRITE); // open filestream 

			stream.writeBytes(jpgStream, 0, jpgStream.length); // writing the image 
			stream.close(); 
			// show the saved thumb 
			trace(newimagefile.nativePath);
			//jpgSource=null; 
			//jpgStream=null; 
			var e:ImageEvent = new ImageEvent(ImageEvent.CONVERTED, new File(newimagefile.nativePath));
			this.dispatchEvent(e);
		}
		
		public function convert(file:*, width:uint, height:uint) : void {
			var f:File;
			
			if (file is String) {
				f = new File(file);
			} else {
				f = File(file);	
			}
			
			this._height = height;
			this._width = width;

			var loader:Loader = new Loader(); 
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handleImageComplete); 
			loader.load(new URLRequest(f.nativePath)); 
			
		}
		
	}

}