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
		
		static public const ERROR_FILE_EXISTS:String = "Ya existe este contenido en esta carpeta, por favor seleccione otra.";
		
		
		// DIALOG
		static public const DIALOG_SELECT_IMAGE_FILE:String = "Seleccione un archivo de image";
		
		static public const DIALOG_SELECT_FILES:String = "Seleccione los archivos que desea agregar";
		
		static public const DIALOG_SELECT_FOLDER:String = "Seleccione una carpeta que desea agregar";
		
		static public const DIALOG_SELECT_DEST_FOLDER:String = "Seleccione una carpeta de destino";
		
		// INFO
		static public const INFO_CONTENT_SAVE:String = "Contenido guardado en ";
	}

}