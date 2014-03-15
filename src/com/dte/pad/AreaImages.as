package com.dte.pad 
{
	import flash.utils.Dictionary;
	
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class AreaImages 
	{
		[Embed('/assets/img/cn-thumb.png')]
		private var imgCN:Class;
		
		[Embed('/assets/img/cs-thumb.png')]
		private var imgCS:Class;
		
		[Embed('/assets/img/ma-thumb.png')]
		private var imgMA:Class;
		
		[Embed('/assets/img/pdl-thumb.png')]
		private var imgPL:Class;
		
		[Embed('/assets/img/ea-thumb.png')]
		private var imgEA:Class;
		
		[Embed('/assets/img/ing-thumb.png')]
		private var imgING:Class;
		
		[Embed('/assets/img/ef-thumb.png')]
		private var imgEF:Class;
		
		[Embed('/assets/img/eap-thumb.png')]
		private var imgEAP:Class;

		[Embed('/assets/img/eam-thumb.png')]
		private var imgEAM:Class;

		[Embed('/assets/img/ead-thumb.png')]
		private var imgEAD:Class;

		[Embed('/assets/img/eat-thumb.png')]
		private var imgEAT:Class;	
		
		static private var _instance:AreaImages=null;
		
		private var _images:Dictionary;
		
		public function AreaImages() 
		{
			if (_instance!=null) {
				throw new Error("Singleton - Can't Instanstiate");
			}
			
			_instance = this;
			createImagesArray();
		}
		
		static public function getInstance() : AreaImages {
			if (_instance == null)
				_instance = new AreaImages();
			
			return _instance;
		}
		
		private function createImagesArray():void 
		{
			_images = new Dictionary();
			_images["Ciencias Naturales"] = new imgCN();
			_images["Ciencias Sociales"] = new imgCS();
			_images["Matemática"] = new imgMA();
			_images["Prácticas del Lenguaje"] = new imgPL();
			_images["Educación Artística"] = new imgEA();
			_images["Inglés"] = new imgING();
			_images["Educación Física"] = new imgEF();
			_images["Ed. Artística - Plástica"] = new imgEAP();
			_images["Ed. Artística - Música"] = new imgEAM();
			_images["Ed. Artística - Danza"] = new imgEAD();
			_images["Ed. Artística - Teatro"] = new imgEAT();
		}
		
		public function getImage(area:String) : * {
			return _images[area];
		}
		
	}

}