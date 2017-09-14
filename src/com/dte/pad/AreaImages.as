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
		/*[Embed('/assets/img/pea-thumb.png')]
		private var imgPEA:Class;
		
		[Embed('/assets/img/hd-thumb.png')]
		private var imgHD:Class;
		
		[Embed('/assets/img/cn-thumb.png')]
		private var imgCN:Class;
		
		[Embed('/assets/img/cs-thumb.png')]
		private var imgCS:Class;
		
		[Embed('/assets/img/ma-thumb.png')]
		private var imgMA:Class;
		
		[Embed('/assets/img/pdl-thumb.png')]
		private var imgPL:Class;
		
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
		
		[Embed('/assets/img/eoe-thumb.png')]
		private var imgEOE:Class;
		
		[Embed('/assets/img/cec-thumb.png')]
		private var imgCEC:Class;

		[Embed('/assets/img/ori-thumb.png')]
		private var imgORI:Class;

		[Embed('/assets/img/esp-thumb.png')]
		private var imgESP:Class;*/
		
		// Escuelas del Futuro
		[Embed('/assets/img/emp_ef_1.png')]
		private var imgEf1:Class;

		[Embed('/assets/img/emp_ef_2.png')]
		private var imgEf2:Class;

		[Embed('/assets/img/emp_ef_3.png')]
		private var imgEf3:Class;

		[Embed('/assets/img/emp_ef_4.png')]
		private var imgEf4:Class;

		[Embed('/assets/img/emp_ef_5.png')]
		private var imgEf5:Class;

		[Embed('/assets/img/emp_ef_6.png')]
		private var imgEf6:Class;

		[Embed('/assets/img/emp_ef_7.png')]
		private var imgEf7:Class;

		[Embed('/assets/img/emp_ef_8.png')]
		private var imgEf8:Class;

		[Embed('/assets/img/emp_ef_9.png')]
		private var imgEf9:Class;

		[Embed('/assets/img/emp_ef_10.png')]
		private var imgEf10:Class;

		[Embed('/assets/img/emp_ef_11.png')]
		private var imgEf11:Class;

		[Embed('/assets/img/emp_ef_12.png')]
		private var imgEf12:Class;
		
		[Embed('/assets/img/emp_ef_generico.png')]
		private var imgEfGenerico:Class;


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
			/*
			_images["Ciencias Naturales"] = new imgCN();
			_images["Ciencias Sociales"] = new imgCS();
			_images["Matemática"] = new imgMA();
			_images["Prácticas del Lenguaje"] = new imgPL();
			_images["Inglés"] = new imgING();
			_images["Educación Física"] = new imgEF();
			_images["Ed. Artística - Plástica"] = new imgEAP();
			_images["Ed. Artística - Música"] = new imgEAM();
			_images["Ed. Artística - Danza"] = new imgEAD();
			_images["Ed. Artística - Teatro"] = new imgEAT();
			_images["Equipos de Orientación Escolar"] = new imgEOE();
			_images["Centros Educativos Complementarios"] = new imgCEC();
			_images["Orientación PAD"] = new imgORI();
			_images["Temas Transversales"] = new imgESP();
			_images["PAD en acción"] = new imgPEA();
			_images["Herramientas Digitales"] = new imgHD();
			*/
			// Escuelas del Futuro
			_images["1 - Programación + laboratorio virtual (Matemática)"] = new imgEf1();
			_images["2 - Programación"] = new imgEf2();
			_images["3 - Robótica"] = new imgEf3();
			_images["4 - Robótica"] = new imgEf4();
			_images["5 - Laboratorio virtual (Ciencias)"] = new imgEf5();
			_images["6 - Idiomas a distancia (inglés) y formación continua"] = new imgEf6();
			_images["7 - Laboratorio virtual (Ciencias)"] = new imgEf7();
			_images["8 - Programación"] = new imgEf8();
			_images["9 - Robótica"] = new imgEf9();
			_images["10 - Robótica"] = new imgEf10();
			_images["11 - Idiomas a distancia (Inglés)"] = new imgEf11();
			_images["12 - Formación continua"] = new imgEf12();
			_images["Varios"] = new imgEfGenerico();
		}
		
		public function getImage(area:String) : * {
			return _images[area];
		}
		
	}

}