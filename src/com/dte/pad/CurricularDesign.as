package com.dte.pad 
{
	import mx.collections.ArrayCollection;
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class CurricularDesign 
	{
		
		[Embed(source="../../../data/data.json", mimeType="application/octet-stream")]
		private var _Data:Class;
		
		static private var _instance:CurricularDesign;
		
		static public const UNDEFINED:String = "Sin Especificar";
		
		private var _design:Object = null;
				
		private var _areas:ArrayCollection;
		
		public function CurricularDesign() 
		{
			if (_instance!=null) {
				throw new Error("Singleton - Can't Instanstiate");
			}
			
			_instance = this;
			this.areas = this.createStructure();
		}
		
		static public function getInstance() : CurricularDesign {
			if (_instance == null)
				_instance = new CurricularDesign();
			
			return _instance;
		}
		
		protected function getData() : Object {
			
			if (_design == null) {
				var  d:String = new _Data();
				_design = JSON.parse(d);
			}
			
			return _design;
		}
		
		[Bindable]
		public function get areas():ArrayCollection 
		{
			return _areas;
		}
		
		public function set areas(value:ArrayCollection) : void 
		{
			_areas = value;
		}
		
		private function createStructure() : ArrayCollection 
		{
			var res:ArrayCollection = new ArrayCollection();
			
			try {
				var areas:* = this.getData().areas;
				for each(var area:* in areas) {
					res.addItem( new Area(area) );
				}
			} catch (e:Error) { 
				trace(e);
			}
			
			return res;
		}
		
	}

}