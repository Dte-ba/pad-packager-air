package com.dte.components 
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import mx.events.FlexEvent;
	import spark.components.DropDownList;
	import spark.components.VGroup;
	
	/**
	 * ...
	 * @author Delmo
	 */
	public class CascadeDropDownList extends VGroup 
	{
		
		[Embed(source="../../../data/categories.json", mimeType="application/octet-stream")]
		private var _Categories:Class;
					
		private var _categories:Object = null;
		
		private var _ddlPrincipal:QueueDropDownList = new QueueDropDownList();
		
		public function CascadeDropDownList() 
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
			
			// create the data
			var  d:String = new _Categories();
			
			_categories = JSON.parse(d);
			
			_ddlPrincipal.addEventListener("needRefresh", ddlNeedRefresh);
			_ddlPrincipal.labelField = "name";
			_ddlPrincipal.dataProvider = new ArrayCollection(_categories.categories);
		}
		
		private function ddlNeedRefresh(e:Event):void 
		{
			_refreshUI();
		}
		
		private function onCreationComplete(e:FlexEvent):void 
		{
			_refreshUI();
		}
		
		private function _refreshUI() : void {
			
			this.removeAllElements();
			
			var c:QueueDropDownList = _ddlPrincipal;
			
			while (c != null) {
				c.percentWidth = 100;
				this.addElement(c);
				c = c.nextDropDown;
			}
		}
		
		public function hasErrors() : Boolean {
			
			var c:QueueDropDownList = _ddlPrincipal;
			
			while (c != null) {
				if (c.selectedItem != null) {
					c = c.nextDropDown;
				} else {
					c = null;
					return true;
				}
			}
			
			return false;
		}
		
		public function getSlectedCategory() : Array {
			var res:Array = new Array();
			
			var c:QueueDropDownList = _ddlPrincipal;
			
			while (c != null) {
				if (c.selectedItem != null) {
					res.push(c.selectedItem.name);
					c = c.nextDropDown;
				} else {
					c = null;
				}
			}
			
			return res;
		}
	}

}