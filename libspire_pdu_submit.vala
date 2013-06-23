//
//
//  Author:
//       Edwin De La Cruz <admin@edwinspire.com>
//
//  Copyright (c) 2013 edwinspire
//  Web Site http://edwinspire.com
//
//  Quito - Ecuador
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
//
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

namespace edwinspire.PDU{



//////////////////////////////////////////////
/// <summary>
/// Primer octeto de un SMS SUBMIT
/// </summary>
[Description(nick = "First Octet Submit", blurb = "Datos correspondientes al primer octeto de un sms para enviar")]
public class FIRST_OCTET_SUBMIT: Octet{
		/// <summary>
		/// Reply path. Parameter indicating that reply path exists.
		/// </summary>
	public bool TP_RP{set; get;}
		/// <summary>
		/// User data header indicator. This bit is set to 1 if the User Data field starts with a header
		/// </summary>
public bool TP_UDHI{set; get;}
		/// <summary>
		/// Status report request. This bit is set to 1 if a status report is requested
		/// </summary>
public bool TP_SRR{set; get;}
		/// <summary>
		/// Validity Period Format. Bit4 and Bit3 specify the TP-VP field
		/// </summary>
public VALIDITY_PERIOD_FORMAT TP_VPF{set; get;}

		/// <summary>
		/// Reject duplicates. Parameter indicating whether or not the SC shall accept an
		/// SMS-SUBMIT for an SM still held in the SC which has the same TP-MR and the same
		/// TP-DA as a previously submitted SM from the same OA.
		/// </summary>
public bool TP_RD{set; get;}
		/// <summary>
		/// Message type indicator. Bits no 1 and 0 are set to 0 and 1 respectively to indicate that this
		/// </summary>
public MESSAGE_TYPE_INDICATOR TP_MTI{set; get;}

private bool decoding = false;
private bool encoding = false;

/// <summary>
/// Constructor
/// </summary>
public FIRST_OCTET_SUBMIT(){
this.notify.connect((s, p) => {
if(p.name == "Bin" || p.name == "Dec" || p.name == "Hex"){
if(!encoding){
DECODE();
}
}else{
if(!decoding){
//print("%s\n", p.name);
ENCODE();
}
}

});
this.Hex = "11";
}
		/// <summary>
		/// Muestra en pantalla los valores
		/// </summary>
	public void print_values(){
GLib.stdout.printf("< FIRST OCTET SUBMIT VALUES >\n");
//GLib.stdout.printf("HEXA:  %s\n", Miscellaneous.number2hex(ENCODE(), 2));
GLib.stdout.printf("HEXA:  %s\n", this.Hex);
GLib.stdout.printf("TP_RP:  %s\n", TP_RP.to_string());
GLib.stdout.printf("TP_UDHI: %s\n", TP_UDHI.to_string());
GLib.stdout.printf("TP_SRR: %s\n", TP_SRR.to_string());
GLib.stdout.printf("TP_VPF: %s\n", TP_VPF.to_string());
GLib.stdout.printf("TP_RD: %s\n", TP_RD.to_string());
GLib.stdout.printf("TP_MTI: %s\n", TP_MTI.to_string());
//ENCODE();
//GLib.stdout.printf("HEXA:  %s\n", this.Hex);
	}

/// <summary>
/// Decodifica un octeto pasado como parametro
/// </summary>
/// <param name="Octet">
/// A <see cref="System.Int32"/>
/// </param>
internal  void DECODE(){
//return_if_fail(Octet<256);
decoding = true;

// this.Hex, this.Bin);

if(this.Bin[0]=='1'){
	TP_RP = true;
	}else{
TP_RP = false;
	}
	if(this.Bin[1]=='1'){
	TP_UDHI = true;
	}else{
TP_UDHI = false;
	}

	if(this.Bin[2]=='1'){
	TP_SRR = true;
	}else{
TP_SRR = false;
	}

		switch(this.Bin.substring(3,2)){
		
		case "00":
		TP_VPF = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
		break;
		case "10":
		TP_VPF = VALIDITY_PERIOD_FORMAT.RELATIVE;
		break;
		case "01":
		TP_VPF = VALIDITY_PERIOD_FORMAT.ENHANCED;
		break;
		case "11":
		TP_VPF = VALIDITY_PERIOD_FORMAT.ABSOLUTE;
		break;
		
	}
	
	if(this.Bin[5]=='1'){
	TP_RD = true;
	}else{
TP_RD = false;
	}

			switch(this.Bin.substring(6, 2)){

		case "00":
		TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_DELIVER;
		break;
		case "10":
		TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_STATUS_REPORT_COMMAND;
		break;
		case "01":
		TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_SUBMIT;
		break;
		case "11":
		TP_MTI = MESSAGE_TYPE_INDICATOR.RESERVED;
		break;
		
	}

decoding = false;
}
/// <summary>
/// Codifica los parametros actuales a un octeto
/// </summary>
/// <returns>
/// A <see cref="System.Int32"/>
/// Octeto en decimal
/// </returns>
internal void ENCODE(){
encoding = true;
StringBuilder Binariof = new StringBuilder();

		if(TP_RP){
		Binariof.append("1");
		}else{
Binariof.append("0");
		}
		
if(TP_UDHI){
		Binariof.append("1");
		}else{
Binariof.append("0");
		}

if(TP_SRR){
		Binariof.append("1");
		}else{
Binariof.append("0");
		}
		
Binariof.append(TP_VPF.ToBin());
 
 if(TP_RD){
		Binariof.append("1");
		}else{
Binariof.append("0");
		}       
 
 Binariof.append(TP_MTI.ToBin());
this.Bin = Binariof.str;

encoding = false;
}
	
}



//////////////////////////////////////////////////////////////////////////////////
	/// <summary>
	/// Mensaje SUBMIT
	/// </summary>
public class SUBMIT: GLib.Object{

		/// <summary>
		/// SMSC Information 
		/// </summary>
public PHONE_INFORMATION SMSC{get; set;}

		/// <summary>
		/// Primer octeto
		/// </summary>
//	private FIRST_OCTET_SUBMIT FO_i = new FIRST_OCTET_SUBMIT();
public FIRST_OCTET_SUBMIT FO{get; set; default = new FIRST_OCTET_SUBMIT();}
		/// <summary>
		/// Referencia del mensaje
		/// </summary>
	public Octet TP_MR{get; set; default = new Octet();}

public PHONE_INFORMATION PHONE{get; set;}


	/// <summary>
	/// Protocol Identifier
	/// </summary>
	public IProtocolIdentifier PID{get; set;} // = new PROTOCOL_IDENTIFIER();
	/// <summary>
	/// Data Coding Schema
	/// </summary>
	public IDataCodingScheme DCS{get; set; } // = new DATA_CODING_SCHEME();
	/// <summary>
	/// Periodo de validez
	/// </summary>
	public VALIDITY_PERIOD TP_VP{private set; get;}


public TextPDUText Message{get; set;}

		/// <summary>
		/// Constructor
		/// </summary>
	public  SUBMIT(){
FO.notify.connect(FO_changed);

TP_VP = new VALIDITY_PERIOD();
SMSC = new PHONE_INFORMATION();
PHONE = new PHONE_INFORMATION();
Message = new TextPDUText();
this.DCS = new DCS_GeneralDataCodingIndication();
//this.FO = new FIRST_OCTET_DELIVER();

// Valores normales para envio de sms
this.FO.Hex = "11";
this.TP_MR = new Octet();
this.PHONE.TA.Dec = 145;
this.PID = new PID_InterWorking();
this.PID.Dec = 0;

this.Minutes_Validity = 120;


	}


public void FO_changed(ParamSpec pspec){
if(pspec.name == "TP-VPF"){
TP_VP.VPF = FO.TP_VPF;
}


}


public int Minutes_Validity{
set{
TP_VP.Minutes = value;
if(value>0){
FO.TP_VPF = VALIDITY_PERIOD_FORMAT.RELATIVE;
}else{
FO.TP_VPF = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
}
}
get{
if(TP_VP.Minutes>0){
FO.TP_VPF = VALIDITY_PERIOD_FORMAT.RELATIVE;
}else{
FO.TP_VPF = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
}
return TP_VP.Minutes;
}
}



	/// <summary>
		/// Muestra en pantalla los valores
		/// </summary>
	public void print_values(){
GLib.stdout.printf("< SUBMIT SMS>\n");
GLib.stdout.printf("SMSC\n");
SMSC.print();
FO.print_values();
GLib.stdout.printf("TP_MR: %s\n", TP_MR.Hex);
PHONE.print();
PID.print_values();
DCS.print_values();
TP_VP.print_values();
GLib.stdout.printf("Message in PDU: %s\n", ENCODE());
Message.print_values();
//GLib.stdout.printf("UDL: %i\n", Message.UDL.Dec);
//GLib.stdout.printf("Message: %s\n", Message.TXT);
//GLib.stdout.printf("lenOctets for send: %i\n", this.length);


	}


	/// <summary>
	/// Longitud en octetos del mensaje codificado en PDU
	/// </summary>
public int length{
	get{
int Retorno = ((int)(ENCODE().length)/2)-1;
return 	Retorno;
	}

}
		/// <summary>
		/// Codifica los parametros actuales en una cadena PDU
		/// </summary>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
	public string ENCODE(){


// Primero seteamos el alfabeto
Message.Alphabet = DCS.Alpha;

	StringBuilder CAdenaPDU = new StringBuilder();

CAdenaPDU.append(SMSC.PDU_Format);
	CAdenaPDU.append(FO.Hex);
	CAdenaPDU.append(TP_MR.Hex);
	CAdenaPDU.append(PHONE.PDU_Format);
	 	CAdenaPDU.append(PID.Hex);
		CAdenaPDU.append(DCS.Hex);
		CAdenaPDU.append(TP_VP.ENCODE());
CAdenaPDU.append(Message.UDL.Hex);
		CAdenaPDU.append(Message.PDU);


		return TextConvert.trim(CAdenaPDU.str);
	}

		/// <summary>
		/// Decodifica una cadena PDU y obtiene los parametros.
		/// </summary>
		/// <param name="PDU">
		/// A <see cref="System.String"/>
		/// </param>
	public void DECODE(string PDU){

StringBuilder CadenaPDU = new StringBuilder(TextConvert.trim(PDU));
//StringBuilder TempNUmber = new StringBuilder("+");
StringBuilder TempNUmber = new StringBuilder();


int lenSMSCInfor = 0;
int lenSender = 0;

//Obtenemos la longitud de la informacion del SMSC
if(CadenaPDU.len>2){
lenSMSCInfor = Miscellaneous.hex2number(CadenaPDU.str.substring(0,2));
	CadenaPDU.erase(0, 2);
}

if(lenSMSCInfor>0){

SMSC.TA.Hex = CadenaPDU.str.substring(0,2);
	CadenaPDU.erase(0, 2);

if(SMSC.TA.TON == TYPE_OF_NUMBER.INTERNATIONAL){
TempNUmber.erase(0, TempNUmber.len);
// TODO Verificar si es necesario agregar el + al inicio del numero
//TempNUmber.append("+");
TempNUmber.append(CadenaPDU.str.substring(0, (lenSMSCInfor-1)*2));
SMSC.PDU = TempNUmber.str;
}else{
SMSC.PDU = CadenaPDU.str.substring(0, (lenSMSCInfor-1)*2);
}

CadenaPDU.erase(0, (lenSMSCInfor-1)*2);
}

if(CadenaPDU.len>2){

FO.Hex = CadenaPDU.str.substring(0,2);
	CadenaPDU.erase(0, 2);
}
if(CadenaPDU.len>2){
TP_MR.Hex = CadenaPDU.str.substring(0,2);
	CadenaPDU.erase(0, 2);
}
if(CadenaPDU.len>2){
lenSender = Miscellaneous.hex2number(CadenaPDU.str.substring(0,2));
	CadenaPDU.erase(0, 2);
}

PHONE.TA.Hex = CadenaPDU.str.substring(0,2);

	CadenaPDU.erase(0, 2);

if(!Miscellaneous.IsPair(lenSender)){

PHONE.PDU = CadenaPDU.str.substring(0,lenSender+1);

	CadenaPDU.erase(0, lenSender+1);
}else{
PHONE.PDU = CadenaPDU.str.substring(0,lenSender);
	CadenaPDU.erase(0, lenSender);

}

// TODO // Verificar si es corrrecto
// Insertamos + al inicio para indicar que es numero internacional
if(PHONE.TA.TON == TYPE_OF_NUMBER.INTERNATIONAL){
TempNUmber.erase(0, TempNUmber.len);
//TempNUmber.append("+");
TempNUmber.append(PHONE.TXT);
PHONE.TXT = TempNUmber.str;
	}

if(CadenaPDU.len>2){

var ClasseDePID = IProtocolIdentifier.DecodeGroup(CadenaPDU.str.substring(0,2));

switch(ClasseDePID){

case PID_GROUP.Group0:
this.PID = new PID_InterWorking();
break;
case PID_GROUP.Group1:
this.PID = new PID_MessageType();
break;
case PID_GROUP.SCSpecificUse:
this.PID = new PID_SCSpecificUse();
break;
default:
this.PID = new PID_Reserved();
break;

}
this.PID.Hex = CadenaPDU.str.substring(0,2);


	CadenaPDU.erase(0, 2);
}

if(CadenaPDU.len>2){

DCS.Hex = CadenaPDU.str.substring(0,2);
	CadenaPDU.erase(0, 2);
}

switch(FO.TP_VPF){
case VALIDITY_PERIOD_FORMAT.RELATIVE:
//TODO// decodificar el valor relativo
TP_VP.Relative.Hex = CadenaPDU.str.substring(0,2);

	CadenaPDU.erase(0, 2);
break;
case VALIDITY_PERIOD_FORMAT.ABSOLUTE:
TP_VP.AbsoluteOctet = CadenaPDU.str.substring(0,15);
	CadenaPDU.erase(0, 15);
break;
}

if(CadenaPDU.len>2){
// TODO // Solo ojo que la linea de abajo no se setea porque debe ser automatico al ingresar el mensaje pdu
	CadenaPDU.erase(0, 2);
}

Message.ToTXT(CadenaPDU.str, DCS.Alpha);
	}

}



public class SUBMITwithDCSGeneralDataCodingIndication: SUBMIT{

public SUBMITwithDCSGeneralDataCodingIndication(string phone, string message = "", bool statusreport = false, bool EnableMsgClass = false, DCS_MESSAGE_CLASS msgclass =  DCS_MESSAGE_CLASS.TE_SPECIFIC){
var DCSi = new DCS_GeneralDataCodingIndication();
DCSi.MessageClass = msgclass;
DCSi.HaveAMessageClassMeaning = EnableMsgClass;
this.DCS = DCSi;
this.PHONE.TXT = phone;
this.Message.TXT = message;
this.FO.TP_SRR = statusreport;
DCSi.Alpha = this.Message.Alphabet;

}


}


}
