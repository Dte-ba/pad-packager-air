package com.dte.pad 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	import com.dte.crypto.AESUtils;
	 
	public class SecurityToken 
	{
		
		private var _name:String = "";
		
		private var _email:String = "";
		
		private var _token:Vector.<String> = null;
		
		// keys
		private var _key:String = "S1nP4ssw0rd";
		
		private var _keyIV:String = "321456987";
		
		public function SecurityToken(token:Vector.<String>=null) 
		{
			this.token = token;
		}
		
		[Bindable]
		public function get name():String 
		{
			return _name;
		}
		
		public function get email():String 
		{
			return _email;
		}
		
		[Bindable]
		public function set email(value:String):void 
		{
			_email = value;
			refeshToken();
		}
		
		public function set name(value:String):void 
		{
			_name = value;
			refeshToken();
		}
		
		private function refeshToken():void 
		{
			if (this.name == "" || this.email == "") {
				// set null the token
				this._token = null;
				return;
			}
			
			this._token = createToken();
		}
		
		private function createToken() : Vector.<String> {
			var toHash:String = this.name + " <" + this.email + ">"
			
			return AESUtils.encrypt(toHash, _key, _keyIV);
		}
		
		public function get token():Vector.<String> 
		{
			return _token;
		}
		
		public function set token(value:Vector.<String>):void 
		{
			_token = value;
			
			if (_token == null) return;
			
			loadFromToken();
		}
		
		private function loadFromToken():void 
		{
			try {
				var data:String = AESUtils.decrypt(this.token[1], _key, this.token[0]);
			
				var er:RegExp = /<[-._a-z0-9]+@[-._a-z0-9]+\.[a-z]{2,6}>$/ig;
				var e:String = er.exec(data).toString();
				
				var n:String = data.replace(" " + e, "");
				
				e = e.replace(/(<|>)/ig, "");
				
				this._name = n;
				this._email = e;
				
			} catch (err:Error) {
				this.name = "";
				this.email = "";
			}
		}
			
		public function serializeToObject() : *
		{
			return this.token;
		}
		
		public function createFrom(array:Array) : void 
		{
			this.token = SecurityToken.convertArray(array);
		}
		
		static public function convertArray(array:Array) : Vector.<String>
		{
			var res:Vector.<String> = new Vector.<String>();
			for (var i:int = 0; i < array.length; i++) 
			{
				res[i] = array[i];
			}
			return res;
		}
	}

}