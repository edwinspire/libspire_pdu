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



///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// <summary>
/// Telefono en PDU
/// </summary>
[Description(nick = "Phone PDU format", blurb = "Numero telefonico en formato PDU, codifica y decodifica")]
public class PDU_PHONE: GLib.Object{
	
//public string Phone{get; set;}
private string Telefono = "00000000000000000000";
private string TempPDU = "00";
private Octet ilength = new Octet();
		/// <summary>
		/// Constructor
		/// </summary>
	public PDU_PHONE(){
	Telefono = "";
	//	Telef.truncate(0);
		
	}


		/// <summary>
		/// Obtiene o Codifica un telefono en formato PDU
		/// </summary>
		/// <returns>
		///  Un string
		/// </returns>
public  string PDU{

 get{

TempPDU = PhoneToPDU(Telefono);

return TempPDU;
}
set{
Telefono = PDUToPhone(value); 
}

}

		/// <summary>
		/// Obtiene o Codifica un telefono en formato Texto
		/// </summary>
		/// <returns>
		///  Un string
		/// </returns>
public  string TXT{

get{
return Telefono;
}
set{
Telefono = value;
}

}

		/// <summary>
		/// Longitud del Numero telefonico
		/// </summary>
public Octet length{
	get{
	ilength.Dec = len(PhoneToPDU(Telefono));
return ilength;
	}
}

		/// <summary>
		/// Muestra en pantalla los valores
		/// </summary>
public void print_values(){
GLib.stdout.printf("PDU_PHONE\n");
GLib.stdout.printf("Phone: %s\n", Telefono);
GLib.stdout.printf("PDU: %s\n", PhoneToPDU(Telefono));
GLib.stdout.printf("PDU len HEXA: %s\n", this.length.Hex);
}
		/// <summary>
		/// Decodifica un telefono en PDU
		/// </summary>
		/// <param name="PhonePDU">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
	public static string PDUToPhone(string PhonePDU){
	 StringBuilder Telef = new StringBuilder();
StringBuilder CadenaTelf = new StringBuilder(TextConvert.trim(PhonePDU));
	
while(CadenaTelf.len>0){
	
	if(CadenaTelf.len>1){

string temp = (CadenaTelf.str.substring(0,2)).reverse();

Telef.append(temp.replace("F", ""));
CadenaTelf.erase(0, 2);
		
	}else{
		
Telef.append(CadenaTelf.str);
		CadenaTelf.erase(0, CadenaTelf.len);
	}
	
	
}	

return (Telef.str).replace("+", "");
}
		/// <summary>
		/// Longitud de un Numero telefonico obtenido desde un numero codificado en PDU.
		/// </summary>
		/// <param name="PhonePDU">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.Int32"/>
		/// </returns>
public static int len(string Phonepdu){
int Retorno = 0;
string phone = TextConvert.trim(Phonepdu);
if((phone).length>0){
Retorno = (int)PDUToPhone(phone).length;
}
//GLib.stdout.printf("length PDU Phone: %i\n", Retorno);
return Retorno;
}
		/// <summary>
		/// Codifica un numero telefonico a formato PDU
		/// </summary>
		/// <param name="Phone">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
public static  string PhoneToPDU(string Phone){
	//stringPhone = Phone.replace("+", "");
StringBuilder CadenaTelfone = new StringBuilder();
CadenaTelfone.append(Phone.replace("+", ""));
StringBuilder CadenaRetorno_pdu = new StringBuilder();
	
while(CadenaTelfone.len>0){
	
	if(CadenaTelfone.len>1){
		
CadenaRetorno_pdu.append(CadenaTelfone.str.substring(0,2).reverse());
CadenaTelfone.erase(0, 2);
		
	}else if(CadenaTelfone.len==1){
		
CadenaRetorno_pdu.append("F");
CadenaRetorno_pdu.append(CadenaTelfone.str);
CadenaTelfone.erase(0, CadenaTelfone.len);
		
	}

}
string Retorno = CadenaRetorno_pdu.str;
	return Retorno;
}
	
	
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// Informacion del nbumero telefonico
// TODO: Implementar alguna forma para que cuando se ingrese un numero en formato internacional (con + al inicia) eso sea detectado y se modifique el ADDRESS TYPE
[Description(nick = "Phone PDU information", blurb = "Informacion acerca del numero telefonico: Type address, numero telefonico, codifica y decodifica en PDU")]
public class PHONE_INFORMATION:PDU_PHONE{

public TYPE_ADDRESS TA{set; get;}
private string PdUFormato = "";

public PHONE_INFORMATION(){
TA = new TYPE_ADDRESS();
}

public string PDU_Format{
get{
var Retorno = new StringBuilder();
Retorno.append(length.Hex);
if(length.Dec>0){
Retorno.append(TA.Hex);
Retorno.append(this.PDU);
}
PdUFormato = Retorno.str;
return PdUFormato;
}
}

public void print(){
GLib.stdout.printf("PHONE INFORMATION\n");
GLib.stdout.printf("length: %s\n", this.length.Hex);
GLib.stdout.printf("PDU_Format: %s\n", this.PDU_Format);
this.print_values();
TA.print_values();
}

}


}
