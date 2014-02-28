package com.dte.pad.UI 
{
	/*!
	 * This file is part of PAD packager.
	 *
	 * please see the LICENSE
	 */
	public class MessageRef 
	{
		
		public function MessageRef() 
		{
			throw new Error("Reference Class - Can't Instanstiate");
		}
		
		static public const ERROR_REQUIERED_FIELD:String = "Uno o mas campos son requeridos para continuar";
		
		static public const ERROR_AXIS_NOT_SELECTED:String = "Sleccione un Eje para continuar";
		
		static public const ERROR_BLOCK_NOT_SELECTED:String = "Sleccione un Bloque para continuar";
		
	}

}