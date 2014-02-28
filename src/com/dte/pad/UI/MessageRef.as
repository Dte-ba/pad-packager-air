package com.dte.pad.ui 
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
		
		// ERRORS
		static public const ERROR_REQUIERED_FIELD:String = "Uno o mas campos son requeridos para continuar";
		
		static public const ERROR_AXIS_NOT_SELECTED:String = "Sleccione un Eje para continuar";
		
		static public const ERROR_BLOCK_NOT_SELECTED:String = "Sleccione un Bloque para continuar";
		
		static public const ERROR_CONTENT_IMAGE_NOT_SELECTED:String = "Seleccione una imagen de contenido para continuar";
		
		static public const ERROR_ACCES_IMAGE_NOT_SELECTED:String = "Seleccione una imagen de acceso para continuar";
		
		// DIALOG
		static public const DIALOG_SELECT_IMAGE_FILE:String = "Seleccione un archivo de image";
	}

}