package com.dte.crypto 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	
	// Uses AS3Crypto
    import com.hurlant.crypto.Crypto;
    import com.hurlant.crypto.symmetric.ICipher;
    import com.hurlant.crypto.symmetric.IPad;
    import com.hurlant.crypto.symmetric.IVMode;
    import com.hurlant.crypto.symmetric.NullPad;
    import com.hurlant.crypto.symmetric.PKCS5;
    import com.hurlant.util.Base64;
    import com.hurlant.util.Hex;
    
    import flash.utils.ByteArray;
	
	public class AESUtils
    {
        
		public function AESUtils() 
		{
			throw new Error("Util Class - Can't Instanstiate");
		}
		
        /**
         * For Encryption:
            Input is expected to be plain, normal human readable text.
            The key is expected to be plain, normal human readable text.
            The IV is expected to be in plain, normal human readable text.
            
            Output data is base64. Why base64?  Base64 is a form of encoding that can be sent over
            the wire so to speak, so typically you see output and input of cryptographic operations
            as b64 so it can travel across networks, between technologies.
            
            Output IV is also base64.
            If you are using an IV, it's common practice to send the IV along with the encrypted data.
         */
        public static function encrypt(_InPlainData:String, _InPlainKey:String, _InPlainIV:String):Vector.<String> {
            var kdata:ByteArray = Hex.toArray(Hex.fromString(_InPlainKey));
            var data:ByteArray = Hex.toArray(Hex.fromString(_InPlainData));
            var pad:IPad = new PKCS5;
            // as3crypto determines the size based on the key. Look inside the Crypto class if you don't believe me.
            var mode:ICipher = Crypto.getCipher("aes-256-cbc", kdata, pad);
            
            var b64_IV:String = "";
            if (mode is IVMode) {
                var ivmode:IVMode = mode as IVMode;
                // Just remember this is just a cast. The IV is still being set on the mode variable.
                ivmode.IV = Hex.toArray( Hex.fromString( _InPlainIV ) );
                b64_IV = Base64.encode( _InPlainIV );
            }
            pad.setBlockSize(mode.getBlockSize());
            mode.encrypt(data);
            
            var returnIVandData:Vector.<String> = new Vector.<String>();
            returnIVandData.push( b64_IV );
            returnIVandData.push( Base64.encodeByteArray(data) );
            return returnIVandData;
        }
        
        /**
            For Decryption:
            Input is expected to be base 64 encoded.
            The key is expected to be plain, normal human readable text.
            The IV is expected to be base 64 encoded.
            
            Decrypted output is plain, normal human readable text.
         */
        public static function decrypt(_InB64Data:String, _InPlainKey:String, _InB64IV:String):String {
            var kdata:ByteArray = Hex.toArray(Hex.fromString(_InPlainKey));
            var data:ByteArray = Base64.decodeToByteArray(_InB64Data);
            var pad:IPad = new PKCS5;
            var mode:ICipher = Crypto.getCipher("aes-256-cbc", kdata, pad);
            if (mode is IVMode) {
                var ivmode:IVMode = mode as IVMode;
                // Just remember this is just a cast. The IV is still being set on the mode variable.
                ivmode.IV = Base64.decodeToByteArray( _InB64IV );
            }
            pad.setBlockSize(mode.getBlockSize());
            mode.decrypt(data);
            
            return Hex.toString(Hex.fromArray(data));
        }
    }

}