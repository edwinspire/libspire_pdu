namespace edwinspire.PDU{

	

/// <summary>
/// Tipo de Numero
/// </summary>
public enum TYPE_OF_NUMBER{
		/// <summary>
		/// Desconocido
		/// </summary>
UNKNOW = 0,
		/// <summary>
		/// Internacional
		/// </summary>
INTERNATIONAL = 1,
		/// <summary>
		/// Nacional
		/// </summary>
NATIONAL = 2,
		/// <summary>
		/// Especifico de la red
		/// </summary>
NETWORK_SPECIFIC = 3,
		/// <summary>
		/// Subscriptor
		/// </summary>
SUBSCRIBER = 4,
		/// <summary>
		/// Alfanumerico
		/// </summary>
ALPHANUMERIC = 5,
		/// <summary>
		/// Abreviado
		/// </summary>
ABBREVIATED = 6,
		/// <summary>
		/// Reservado
		/// </summary>
RESERVED = 7;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 3);
}	
}	
	/// <summary>
	/// Plan de numeracion
	/// </summary>
public enum NUMBERING_PLAN_IDENTIFICATION{
	/// <summary>
	/// Desconocido
	/// </summary>
	UNKNOW = 0,
		/// <summary>
		/// ISDN
		/// </summary>
	ISDN = 1,
		/// <summary>
		/// Datos
		/// </summary>
	DATA = 3,
		/// <summary>
		/// Telex
		/// </summary>
	TELEX = 4,
		/// <summary>
		/// Nacional
		/// </summary>
	NATIONAL = 8,
		/// <summary>
		/// Privado
		/// </summary>
	PRIVATE = 9,
		/// <summary>
		/// Ermes
		/// </summary>
	ERMES = 10,
		/// <summary>
		/// Reservado
		/// </summary>
	RESERVED = 15;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 4);
}
	
}
	/// <summary>
	/// Formato de periodo de validacion
	/// </summary>
public enum VALIDITY_PERIOD_FORMAT{
		/// <summary>
		/// No presente
		/// </summary>
	NO_PRESENT,
		/// <summary>
		/// Expandido
		/// </summary>
	ENHANCED,
		/// <summary>
		/// Relative
		/// </summary>
		RELATIVE,
		/// <summary>
		/// Absolute
		/// </summary>
	ABSOLUTE;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 2);
}
/*
public VALIDITY_PERIOD_FORMAT FromBin(string bin){
var este = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
		switch(bin){
		
		case "00":
		este = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
		break;
		case "10":
		este = VALIDITY_PERIOD_FORMAT.RELATIVE;
		break;
		case "01":
		este = VALIDITY_PERIOD_FORMAT.ENHANCED;
		break;
		case "11":
		este = VALIDITY_PERIOD_FORMAT.ABSOLUTE;
		break;
		
	}
return este;
}
*/
}
/*
	/// <summary>
	/// INTERWORKING of Protocol Identifier
	/// </summary>
public enum PID_INTERWORKINGx{
		/// <summary>
		/// No
		/// </summary>
	NO_INTERWORKING,
		/// <summary>
		/// Telematic
		/// </summary>
	TELEMATIC_INTERWORKING,
		/// <summary>
		/// Desconocido
		/// </summary>
	UNKNOW
}
*/

/// <summary>
/// Tipo de dispositivo telematico
/// </summary>
public enum PID_TYPE_TELEMATIC_DEVICE{
	/// <summary>
	/// Implicito (device type is specific to this SC, or can be concluded on the)
	/// </summary>
	        IMPLICIT = 0,
		/// <summary>
		/// Telex (or teletex reduced to telex format)
		/// </summary>
TELEX = 1, //00001
		/// <summary>
		/// Group 3 telefax
		/// </summary>
TELEFAX_GROUP3 = 2, //00010
		/// <summary>
		/// Group 4 telefax
		/// </summary>
TELEFAX_GROUP4 = 3, //00011
		/// <summary>
		/// Voice telephone (i.e. conversion to speech)
		/// </summary>
VOICE_TELEPHONE = 4, //00100
		/// <summary>
		/// ERMES (European Radio Messaging System)
		/// </summary>
ERMES = 5, //00101
		/// <summary>
		/// National Paging System (known to the SC)
		/// </summary>
NATIONAL_PAGING_SYSTEM = 6, //00110
		/// <summary>
		/// Videotex (T.100/T.101)
		/// </summary>
VIDEOTEX = 7, //00111
		/// <summary>
		/// Teletex, carrier unspecified
		/// </summary>
TELETEX_CARRIER_UNSPECIFIED = 8, //01000
		/// <summary>
		/// Teletex, in PSPDN
		/// </summary>
TELETEX_PSPDN = 9, //01001
		/// <summary>
		/// Teletex, in CSPDN
		/// </summary>
TELETEX_CSPDN = 10, //01010
		/// <summary>
		/// Teletex, in analog PSTN
		/// </summary>
TELETEX_PSTN = 11, //01011
		/// <summary>
		/// Teletex, in digital ISDN
		/// </summary>
TELETEX_ISDN = 12, //01100
		/// <summary>
		/// UCI (Universal Computer Interface, ETSI DE/PS 3 01-3)
		/// </summary>
UCI = 13, //01101
		/// <summary>
		/// Reservado, 2 combinaciones
		/// </summary>
//RESERVED_2_COMBINATIONS,
RESERVED = 14,
		/// <summary>
		/// A message handling facility (known to the SC)
		/// </summary>
MESSAGE_HANDLING_FACILITY = 16, //10000
		/// <summary>
		/// Any public X.400-based message handling system
		/// </summary>
ANY_PUBLIC_X400_MESSAGE_HANDLING_SYSTEM = 17, //10001
		/// <summary>
		/// Internet Electronic Mail
		/// </summary>
INTERNET_ELECTRONIC_MAIL = 18, //10010
		/// <summary>
		/// Reservado 5 combinaciones
		/// </summary>
//RESERVED_5_COMBINATIONS,
		/// <summary>
		/// Valor especifico de cada SC
		/// </summary>
     VALUES_SPECIFIC_TO_EACH_SC = 24,
		/// <summary>
		/// Una estacion mobil GSM
		/// </summary>
     A_GSM_MOBILE_STATION = 31,
		/// <summary>
		/// Desconocido
		/// </summary>
UNKNOW = 32;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 5);
}
	
}

	/// <summary>
	/// Incicador del tipo de Mensaje
	/// </summary>
	public enum MESSAGE_TYPE_INDICATOR{
		/// <summary>
		/// Entrante
		/// </summary>
		SMS_DELIVER,
		/// <summary>
		/// Saliente
		/// </summary>
		SMS_SUBMIT,
		/// <summary>
		/// STATUS REPORT (in the direction SC to MS)
		/// SMS COMMAND (in the direction MS to SC)
		/// </summary>
	SMS_STATUS_REPORT_COMMAND, //
		/// <summary>
		/// Reservado

		/// </summary>
	RESERVED;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 2);
}
	}


	/// <summary>
	///
	/// </summary>
public enum PID_SHORT_MESSAGE{
	/// <summary>
	///
	/// </summary>
	SHORT_MESSAGE_TYPE_0 = 0,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_1 = 1,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_2 = 2,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_3 = 3,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_4 = 4,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_5 = 5,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_6 = 6,
		/// <summary>
		///
		/// </summary>
	REPLACE_SHORT_MESSAGE_TYPE_7 = 7,
		/// <summary>
		/// Reservado
		/// </summary>
	RESERVED = 8,
		/// <summary>
		///
		/// </summary>
	RETURN_CALL_MESSAGE = 31,
		/// <summary>
		///
		/// </summary>
	ME_DATA_DOWNLOAD = 32,
		/// <summary>
		///
		/// </summary>
	ME_DEPERSONALIZATION_SHORT_MESSAGE = 62,
		/// <summary>
		///
		/// </summary>
	SIM_DATA_DOWNLOAD = 63,
		/// <summary>
		/// Desconocido
		/// </summary>
	UNKNOW = 64;

public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 6);
}
}



/// <summary>
/// Protocol Identifier Group
/// </summary>
public enum PID_GROUP{
		/// <summary>
		/// 0
		/// </summary>
Group0,
		/// <summary>
		/// 1
		/// </summary>
Group1,
		/// <summary>
		/// Reservado
		/// </summary>
Reserved,
		/// <summary>
		/// Para uso especifico del SC
		/// </summary>
SCSpecificUse
}



/// <summary>
/// Alfabeto usado en PDU
/// </summary>
public	enum PDU_ALPHABET{
		/// <summary>
		/// Default. 7 Bits
		/// </summary>
					DEFAULT,
		/// <summary>
		/// 8 Bits
		/// </summary>
					DATA8Bits,
		/// <summary>
		/// UCS2. 16 Bits
		/// Valor hexadecimal de 4 digitos
		/// </summary>
					UCS2,
		/// <summary>
		/// Reservado
		/// </summary>
					RESERVED,
		/// <summary>
		/// Desconocido
		/// </summary>
					UNKNOW;
public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 2);
}
				
	}	


	/// <summary>
	/// Data Coding Schema - Message Class
	/// </summary>
public enum DCS_MESSAGE_CLASS{
		/// <summary>
		/// Mensaje Flash. Muestra inmediatamente en pantalla
		/// </summary>
	IMMEDIATE_DISPLAY,
		/// <summary>
		/// Especifico del ME
		/// </summary>
	ME_SPECIFIC,
		/// <summary>
		/// Especifico de la SIM
		/// </summary>
	SIM_SPECIFIC,
		/// <summary>
		/// Especifico del TE
		/// </summary>
	TE_SPECIFIC;
		/// <summary>
		/// Ninguno
		/// </summary>
public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 2);
}
}


public enum DCS_MessageCoding{
Default,
@8BitData
}

public enum DCS_MESSAGE_WAITING_INDICATION_GROUP{
DiscardMessage = 12,
StoreMessage_DefaultAlphabet = 13,
StoreMessage_UCS2Alphabet = 14;
public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 4);
}
}


/// <summary>
/// Data Coding Schema - Tipo de identificacion
/// </summary>
public enum DCS_INDICATION_TYPE{
		/// <summary>
		/// Mensaje en el correo de voz en espera
		/// </summary>
	VOICE_MAIL_MESSAGE_WAITING = 0,
		/// <summary>
		/// Mensaje de fax en espera
		/// </summary>
	FAX_MESSAGE_WAITING = 1,
		/// <summary>
		/// Correo electronico en espera
		/// </summary>
	ELECTRONIC_MAIL_MESSAGE_WAITING = 2,
		/// <summary>
		/// Otros mensajes en espera
		/// </summary>
	OTHER_MESSAGE_WAITING = 3,
		/// <summary>
		/// Desconocido
		/// </summary>
	UNKNOW;
public string ToBin(){
return Miscellaneous.ConvertIntToBin((int)this, 2);
}
	
}




/// <summary>
/// Grupo de Bits de DCS
/// </summary>
public enum DCS_CODING_GROUP_BITS{
	/// <summary>
	/// General
	/// </summary>
	GENERAL_DATA_CODING,
		/// <summary>
		/// Reservado
		/// </summary>
	RESERVED,
		/// <summary>
		/// Mensaje de espera (Descarta el mensaje)
		/// </summary>
	MESSAGE_WAIT_DISCARD_MESSAGE,
		/// <summary>
		/// Mensaje en espera (Guarda mensaje con alfabeto de fábrica)
		/// </summary>
	MESSAGE_WAIT_STORE_MESSAGE_DEFAULT,
		/// <summary>
		/// Mensaje de espera (Guarda mensaje con alfabeto UCS2)
		/// </summary>
	MESSAGE_WAIT_STORE_MESSAGE_UCS2,
		/// <summary>
		/// Datos Codificados
		/// </summary>
	DATA_CODING

}














}
