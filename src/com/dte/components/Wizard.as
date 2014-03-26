package com.dte.components 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import flash.events.MouseEvent;
	import flash.events.Event;
	import mx.containers.ViewStack;
	import mx.core.IUIComponent;
	import mx.events.ChildExistenceChangedEvent;
	import mx.events.FlexEvent;
	import mx.events.IndexChangedEvent;
	import spark.components.Button;
	
	[Event(name="end", type="flash.events.Event")]
	public class Wizard extends ViewStack
	{
		
		private var _toolBar:IUIComponent;
		
		private var _nextButton:Button;
		
		private var _backButton:Button;
		
		private var _endButton:Button;
		
		private var _caption:String = "Cargando";
		
		private var _debbug:Boolean = true;
		
		private var _enableCheck:Boolean = true;
		
		public function Wizard() 
		{
			super();
			this.addEventListener(FlexEvent.CREATION_COMPLETE, onCreationComplete);
		}
		
		private function onCreationComplete(e:FlexEvent):void 
		{
			refreshUI();
			this.addEventListener(IndexChangedEvent.CHANGE, onIndexChange);
			this.addEventListener(ChildExistenceChangedEvent.CHILD_ADD, onChildAdded);
		}
		
		private function onChildAdded(e:ChildExistenceChangedEvent):void 
		{
			if ( !(e.relatedObject is Step) )
			{
				throw new Error("The child is not a Step");
			}
			
			refreshUI();
		}
		
		private function onIndexChange(e:IndexChangedEvent):void 
		{
			var c:* = this.selectedIndex < 0 ? null : this.getChildAt(this.selectedIndex);
			var from:String = e.oldIndex < e.newIndex ? "back" : "next";
			
			if (c !== null) {
				var cs:Step = c as Step;
				cs.activate(from);
			}
			
			refreshUI();
		}
		
		public function canNext() : Boolean
		{
			// TODO: deletme on release
			if (_debbug) return true;
			
			if (!_enableCheck) return true;
			
			if ((this.numChildren - 1 == this.selectedIndex)) return false;
			
			var c:* = this.selectedIndex < 0 ? null : this.getChildAt(this.selectedIndex);
			if (c !== null) {
				var cs:Step = c as Step;
				return cs.isValid();
			}
			
			return true;
		}
		
		public function canBack() : Boolean
		{
			if (this.selectedIndex == 0) return false;
			
			return true;
		}
		
		public function next() : void 
		{
			if (!canNext()) return;
			
			this.selectedIndex++;
		}
		
		public function prev() : void 
		{
			if (!canBack()) return;
			
			this.selectedIndex--;
		}
		
		protected function refreshUI() : void
		{
			if (_nextButton !== null) {
				_nextButton.enabled = this.selectedIndex < (this.numChildren - 1);
			}
			
			if (_backButton !== null) {
				_backButton.enabled = this.selectedIndex > 0;
			}
			
			
			try {
				var c:* = this.selectedIndex < 0 ? null : this.getChildAt(this.selectedIndex);
				if (c !== null) {
					var cs:Step = c as Step;
					this.caption = cs.caption;
					this.toolBarEnable = cs.enableToolBar;
					this.backButtonEnabled = cs.enableBack;
					this.nextButtonEnabled = cs.enableNext;
				}
			} catch (e:Event) { }
			
		}
		
		public function get nextButton():Button 
		{
			return _nextButton;
		}
		
		public function set nextButton(value:Button):void 
		{
			_nextButton = value;
			if (_nextButton) {
				_nextButton.addEventListener(MouseEvent.CLICK, nextButtonClick);
				refreshUI();
			}
		}
		
		private function nextButtonClick(e:MouseEvent):void 
		{
			next();
		}
		
		public function get backButton():Button 
		{
			return _backButton;
		}
		
		public function set backButton(value:Button):void 
		{
			_backButton = value;
			if (_backButton) {
				_backButton.addEventListener(MouseEvent.CLICK, backButtonClick);
				refreshUI();
			}
		}
		
		public function get endButton():Button 
		{
			return _endButton;
		}
		
		public function set endButton(value:Button):void 
		{
			_endButton = value;
			if (_endButton) {
				_endButton.addEventListener(MouseEvent.CLICK, endButtonClick);
				refreshUI();
			}
		}
		
		[Bindable]
		public function get caption():String 
		{
			return _caption;
		}
		
		public function set caption(value:String):void 
		{
			_caption = value;
		}
		
		[Bindable]
		public function get toolBar():IUIComponent 
		{
			return _toolBar;
		}
		
		public function set toolBar(value:IUIComponent):void 
		{
			_toolBar = value;
		}
		
		public function get toolBarEnable():Boolean 
		{
			if (_toolBar !== null) {
				return _toolBar.enabled;
			}
			
			return false;
		}
		
		public function set toolBarEnable(value:Boolean):void 
		{
			if (_toolBar !== null) {
				_toolBar.enabled = value;
			}
		}
		
		public function get backButtonEnabled():Boolean 
		{
			if (_backButton !== null) {
				return _backButton.enabled;
			}
			
			return false;
		}
		
		public function set backButtonEnabled(value:Boolean):void 
		{
			if (_backButton !== null) {
				_backButton.enabled = value;
			}
		}
		
		public function get nextButtonEnabled():Boolean 
		{
			if (_nextButton !== null) {
				return _nextButton.enabled;
			}
			
			return false;
		}
		
		public function set nextButtonEnabled(value:Boolean):void 
		{
			if (_nextButton !== null) {
				_nextButton.enabled = value;
			}
		}
		
		private function endButtonClick(e:MouseEvent):void 
		{
			this.dispatchEvent(new Event("end"));
		}
		
		private function backButtonClick(e:MouseEvent):void 
		{
			prev();
		}
		
		public function restart() : void 
		{
			_enableCheck = true;
			this.selectedIndex = 0;
			
			for (var i:int = 0; i < this.numChildren; i++) 
			{
				var cs:Step = this.getChildAt(i) as Step;
				cs.reset();
			}
			_enableCheck = false;
		}
		
	}

}