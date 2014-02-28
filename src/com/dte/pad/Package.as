package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class Package 
	{
		private var _uid:String = "";
		
		private var _area:String = "";
		
		private var _axis:String = "";
		
		private var _block:String = "";
	   
	    private var _title:String = "";
	   
	    private var _description:String = "";
		
		private var _datasheet:String = "";
		
		private var _tags:String = "";
		
		private var _version:String = "";
		
		// content
		private var _contentAutor:String = "";
		
		private var _contentSource:String = "";
		
		private var _files:ArrayCollection = new ArrayCollection();
		
		// credentials
		private var _tokenName:String = "";
		
		private var _tokenEmail:String = "";
		
		// covers
		private var _imgThumb:File;
		
		private var _imgContent:File;
		
		public function Package(area:String=CurricularDesign.UNDEFINED, version:String="0.1")  {
			
			this.area = area;
			this.axis = CurricularDesign.UNDEFINED;
			this.block = CurricularDesign.UNDEFINED;
			
			this.uid = createUid();
			this.version = version;
		}
		
		public function get uid():String  {
			return _uid;
		}
		
		[Bindable]
		public function get area():String  {
			return _area;
		}
		
		public function set area(value:String):void  {
			_area = value;
		}
		
		[Bindable]
		public function get title():String  {
			return _title;
		}
		
		public function set title(value:String):void  {
			_title = value;
		}
		
		[Bindable]
		public function get description():String  {
			return _description;
		}
		
		public function set description(value:String):void  {
			_description = value;
		}
				
		[Bindable]
		public function get files():ArrayCollection  {
			return _files;
		}
		
		public function set files(value:ArrayCollection):void  {
			_files = value;
		}
			
		[Bindable]
		public function get version():String  {
			return _version;
		}
		
		public function set version(value:String):void {
			_version = value;
		}
		
		[Bindable]
		public function get axis():String  {
			return _axis;
		}
		
		public function set axis(value:String):void {
			_axis = value;
		}
		
		[Bindable]
		public function get block():String {
			return _block;
		}
		
		public function set block(value:String):void  {
			_block = value;
		}
		
		[Bindable]
		public function get tags():String  {
			return _tags;
		}
		
		public function set tags(value:String):void  {
			_tags = value;
		}
		
		[Bindable]
		public function get contentAutor():String  {
			return _contentAutor;
		}
		
		public function set contentAutor(value:String):void  {
			_contentAutor = value;
		}
		
		[Bindable]
		public function get contentSource():String  {
			return _contentSource;
		}
		
		public function set contentSource(value:String):void  {
			_contentSource = value;
		}
		
		[Bindable]
		public function get datasheet():String  {
			return _datasheet;
		}
		
		public function set datasheet(value:String):void  {
			_datasheet = value;
		}
		
		[Bindable]
		public function get tokenName():String {
			return _tokenName;
		}
		
		public function set tokenName(value:String):void {
			_tokenName = value;
		}
		
		[Bindable]
		public function get tokenEmail():String {
			return _tokenEmail;
		}
		
		public function set tokenEmail(value:String):void {
			_tokenEmail = value;
		}
		
		[Bindable]
		public function get imgThumb():File  {
			return _imgThumb;
		}
		
		public function set imgThumb(value:File):void  {
			_imgThumb = value;
		}
		
		[Bindable]
		public function get imgContent():File  {
			return _imgContent;
		}
		
		public function set imgContent(value:File):void  {
			_imgContent = value;
		}
		
		private function createToken() : Vector.<String> {
			var pwd:String = "S1nP4ssw0rd";
			var toHash:String = this.tokenName + " <" + this.tokenEmail + ">"
			
			return AESUtils.encrypt(toHash, pwd, "321456987");
		}
		
	}

}