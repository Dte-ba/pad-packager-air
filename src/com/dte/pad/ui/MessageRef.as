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
		
		static public const ERROR_AXIS_NOT_SELECTED:String = "Sleccioná un Eje para continuar";
		
		static public const ERROR_BLOCK_NOT_SELECTED:String = "Sleccioná un Bloque para continuar";
		
		static public const ERROR_CONTENT_IMAGE_NOT_SELECTED:String = "Seleccione la imagen de la Ficha Técnica para continuar";
		
		static public const ERROR_ACCES_IMAGE_NOT_SELECTED:String = "Seleccione la imagen de Portada para continuar";
		
		static public const ERROR_NOT_FILES_SELECTED:String = "Seleccione uno o mas archivos para continuar";
		
		static public const ERROR_FILES_SIZE:String = "El tamaño del/los archivos excede lo permitido (100 Mb)";
		
		static public const ERROR_FILE_EXISTS:String = "Ya existe este contenido en esta carpeta, por favor seleccione otra.";
		
		
		// DIALOG
		static public const DIALOG_SELECT_IMAGE_FILE:String = "Seleccioná archivo de imágen";
		
		static public const DIALOG_SELECT_FILES:String = "Seleccioná uno o más archivos";
		
		static public const DIALOG_SELECT_FOLDER:String = "Seleccioná una carpeta";
		
		static public const DIALOG_SELECT_DEST_FOLDER:String = "Seleccioná una carpeta de destino";
		
		static public const DIALOG_IMPORT_PACKAGE:String = "Seleccioná el paquete para importar";
		
		// INFO
		static public const INFO_CONTENT_SAVE:String = "Contenido guardado en ";
	}

}