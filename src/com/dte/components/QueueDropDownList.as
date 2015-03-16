package com.dte.components 
{
	import flash.events.Event;
	import mx.collections.ArrayCollection;
	import spark.components.DropDownList;
	import spark.events.IndexChangeEvent;
	
	/**
	 * ...
	 * @author Delmo
	 */
	[Event(name="needRefresh", type="flash.events.Event")]
	public class QueueDropDownList extends DropDownList 
	{
		
		private var _nextDropDown:QueueDropDownList;
		
		private var _prevDropDown:QueueDropDownList;
		
		public function QueueDropDownList() 
		{
			super();
			
			this.addEventListener(IndexChangeEvent.CHANGE, onChange);
		}
		
		private function onChange(e:IndexChangeEvent):void 
		{
			var current:* = this.selectedItem;
			
			if (current == null) {
				if (this.nextDropDown != null) {
					this.nextDropDown = null;
				}
				this.dispatchEvent(new Event("needRefresh"));
				if (this.prevDropDown != null) {
					this.prevDropDown.nextHasChange();
				}
				return;
			}
			
			if (current.hasCategories == true) {
				this.nextDropDown = new QueueDropDownList();
				this.nextDropDown.prevDropDown = this;
				this.nextDropDown.labelField = "name";
				this.nextDropDown.dataProvider = new ArrayCollection(current.categories);
			} else {
				this.nextDropDown = null;
			}
			
			this.dispatchEvent(new Event("needRefresh"));
			if (this.prevDropDown != null) {
				this.prevDropDown.nextHasChange();
			}
		}
		
		protected function nextHasChange() : void {
			if (this.prevDropDown == null) {
				this.dispatchEvent(new Event("needRefresh"));
				return;
			}
			
			this.prevDropDown.nextHasChange();
		}
		
		public function get nextDropDown():QueueDropDownList 
		{
			return _nextDropDown;
		}
		
		public function set nextDropDown(value:QueueDropDownList):void 
		{
			_nextDropDown = value;
		}
		
		public function get prevDropDown():QueueDropDownList 
		{
			return _prevDropDown;
		}
		
		public function set prevDropDown(value:QueueDropDownList):void 
		{
			_prevDropDown = value;
		}
		
	}

}
