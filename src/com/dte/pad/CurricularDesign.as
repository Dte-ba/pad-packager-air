package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class CurricularDesign 
	{
		
		[Embed(source="../../../data/data.json", mimeType="application/octet-stream")]
		private var _Data:Class;
		
		private var _design:Object = null;
		
		private static var _instance:CurricularDesign;
		
		public function CurricularDesign() 
		{
			if (_instance!=null) {
				throw new Error("Singleton - Can't Instanstiate");
			}
			
			_instance = this;
		}
		
		public static function getInstance() : CurricularDesign {
			if (_instance == null)
				_instance = new CurricularDesign();
			
			return _instance;
		}
		
		public function data() : Object {
			
			if (_design == null) {
				var  d:String = new _Data();
				_design = JSON.parse(d);
			}
			
			return _design;
		}
		
	}

}