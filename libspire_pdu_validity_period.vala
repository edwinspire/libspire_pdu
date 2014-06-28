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



//////////////////////////////////////////////////////////////////////////////////////////////////////////
	/// <summary>
	/// Periodo de Validez de un SMS saliente
	/// </summary>
[Description(nick = "Validity Period", blurb = "Periodo de valides de un sms saliente")]
public class VALIDITY_PERIOD: GLib.Object{

private Octet OctetoRelativo = new Octet();

		/// <summary>
		/// Formato del periodo de validez
		/// </summary>
public VALIDITY_PERIOD_FORMAT VPF{set; get;}
private int Minuttos = 0;
public TP_SCTS SCTS{get; private set; default =  new TP_SCTS.now_local();}

		/// <summary>
		/// Constructor
		/// </summary>
public VALIDITY_PERIOD(){
 VPF = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
this.SCTS =  new TP_SCTS.now_local();
}


		/// <summary>
		/// Setea los parametros
		/// </summary>
		/// <param name="_SCTS_">
		/// A <see cref="TP_SCTS"/>
		/// </param>
		/// <param name="VPF_">
		/// A <see cref="VALIDITY_PERIOD_FORMAT"/>
		/// </param>
public void Set_SCTS(TP_SCTS _SCTS_, VALIDITY_PERIOD_FORMAT VPF_){
//return_if_fail(VPF == VALIDITY_PERIOD_FORMAT.ABSOLUTE || VPF != VALIDITY_PERIOD_FORMAT.NO_PRESENT);
VPF = VPF_;
SCTS = _SCTS_;
}

		/// <summary>
		/// Obtiene la validez en Minutos
		/// </summary>
		/// <returns>
		/// A <see cref="System.Int32"/>
		/// </returns>
public int Get_MINUTES(){
return Minuttos;
}

/// <summary>
/// Setea la validez en minutos
/// </summary>
/// <param name="Minutes">
/// A <see cref="System.Int32"/>
/// </param>
/// <param name="VPF_">
/// A <see cref="VALIDITY_PERIOD_FORMAT"/>
/// </param>
public void Set_MINUTES(int Minutes, VALIDITY_PERIOD_FORMAT VPF_){
//return_if_fail(VPF == VALIDITY_PERIOD_FORMAT.RELATIVE || VPF == VALIDITY_PERIOD_FORMAT.NO_PRESENT);
VPF = VPF_;
Minuttos = Minutes;
}
		/// <summary>
		/// Decodifica los octetos
		/// </summary>
		/// <param name="Octets">
		/// A <see cref="System.String"/>
		/// </param>
		/// <param name="VPF_">
		/// A <see cref="VALIDITY_PERIOD_FORMAT"/>
		/// </param>
public void DECODE(string Octets, VALIDITY_PERIOD_FORMAT VPF_){
VPF = VPF_;
//GLib.stdout.printf("VALIDITY_PERIOD_FORMAT: %s\n", VPF_.str);
switch(VPF){
case VALIDITY_PERIOD_FORMAT.RELATIVE:
//return_if_fail(Octets.len == 2);
Minuttos = DECODE_Relative(Octets);
break;
case VALIDITY_PERIOD_FORMAT.ABSOLUTE:
//return_if_fail(Octets.len == 14);
SCTS.Octets = Octets;
break;
case VALIDITY_PERIOD_FORMAT.ENHANCED:
//return_if_fail(Octets.len == 14);
SCTS =  new TP_SCTS.now_local();
GLib.stdout.printf("<NOT SUPPORTED> \n");
break;
default:
GLib.stdout.printf("NOT ****> \n");
//Valor = new Object();
break;
}
}

//Devuelve el valor en minutos
internal static int DECODE_Relative(string Octet){
//return_if_fail(Octet.len == 2);
int Retorno = 0;
int Valor = Miscellaneous.hex2number(Octet);
//GLib.stdout.printf(">>>>>>>DECODE_Relative: VALOR %i\n", Valor);
if(Valor<=143){
Retorno = Valor;
}else if(Valor <= 167){
Retorno = 720+((Valor-143)*30);
}else if(Valor <= 196){
Retorno = (Valor-166)*24*60;
}else if(Valor <= 255){
Retorno = (Valor-192)*24*60*7;
}else{
Retorno = (255-192)*7*24*60;
}
//GLib.stdout.printf("DECODE_Relative: %i\n", Retorno);
return Retorno;
}


// Convierte el octeto a minutos cuando esta en formato relativo
private static int ConvertOctetToMinutes(Octet Valor){
int Retorno = 0;
if(Valor.Dec<=143){
Retorno = Valor.Dec;
}else if(Valor.Dec <= 167){
Retorno = 720+((Valor.Dec-143)*30);
}else if(Valor.Dec <= 196){
Retorno = (Valor.Dec-166)*24*60;
}else if(Valor.Dec <= 255){
Retorno = (Valor.Dec-192)*24*60*7;
}else{
Retorno = (255-192)*7*24*60;
}
return Retorno;
}


// Convierte los minutos a octeto cuando esta en formato relativo
private static Octet ConvertMinutesToOctet(int minutes){
Octet Retorno = new Octet(0);
if(minutes<=720){
Retorno.Dec = (minutes/5)-1;
}else if(minutes<=1440){
Retorno.Dec = ((minutes-720)/30)+143;
}else if(minutes<=43200){
Retorno.Dec = ((minutes/60)/24)+166;
}else{
Retorno.Dec = (((minutes/60)/24)/7)+192;
}
if(Retorno.Dec>255){
Retorno.Dec = 255;
}
return Retorno;
}

[Description(nick="Set / Get Minutes validity", blurb="Tiempo de valides en minutos, setea automaticamente a formato relativo")]
public int Minutes{
get{
// Seteamos a 2880 si los minutos son 0 y el formato es ralativo, ya que caso contrario el valor relativo 00 es invalido. 2880 minutos = 2 dias
if(Minuttos == 0 && (VPF == VALIDITY_PERIOD_FORMAT.RELATIVE)){
Minuttos = 2880;
}else{
VPF = VALIDITY_PERIOD_FORMAT.NO_PRESENT;
}
return Minuttos;
}
set{
Minuttos = value;
}
}



[Description(nick="Set / Get Reltive Format", blurb="Octeto en relative format")]
public Octet Relative{
set{
//VPF = VALIDITY_PERIOD_FORMAT.RELATIVE;
Minuttos = ConvertOctetToMinutes(value);
OctetoRelativo = value;
}
get{
//VPF = VALIDITY_PERIOD_FORMAT.RELATIVE;
OctetoRelativo = ConvertMinutesToOctet(Minuttos);
return OctetoRelativo;
}
}

[Description(nick="Set / Get absolute Format", blurb="Octetos en absolute format en string")]
public string AbsoluteOctet{
set{
SCTS.Octets = value;
}
get{
return SCTS.Octets;
}
}


[Description(nick="Set / Get Absolute Format", blurb="Octetos en absolute format en TP_SCTS")]
public TP_SCTS Absolute{
set{
//VPF = VALIDITY_PERIOD_FORMAT.ABSOLUTE;
SCTS = value;
}
get{
//VPF = VALIDITY_PERIOD_FORMAT.ABSOLUTE;
//TP_SCTS defaultvalor = new TP_SCTS();


return SCTS;
}
}

[Description(nick="Set / Get ENHANCED Format", blurb="Octetos en formato ENHANCED TP_SCTS")]
public TP_SCTS Enhanced{
set{
//VPF = VALIDITY_PERIOD_FORMAT.ENHANCED;
SCTS = value;
}
get{
//VPF = VALIDITY_PERIOD_FORMAT.ENHANCED;
return SCTS;
}
}


private int ENCODE_Relative(){
//int Minutos = (int)Valor;
int Retorno = 0;

if(Minuttos>0){
if(Minuttos<=720){
//Retorno = ENCODE_RelativeFormat_Minutes(Minutos);

Retorno = (Minuttos/5)-1;

}else if(Minuttos<=1440){
//Retorno = ENCODE_RelativeFormat_Hour(Minutos/60);
Retorno = ((Minuttos-720)/30)+143;
}else if(Minuttos<=43200){
//Retorno = ENCODE_RelativeFormat_Day((Minutos/60)/24);
Retorno = ((Minuttos/60)/24)+166;
}else{
//Retorno = ENCODE_RelativeFormat_Week(((Minutos/60)/24)/7);
Retorno = (((Minuttos/60)/24)/7)+192;
}
if(Retorno>255){
Retorno = 255;
}
}
return Retorno;
}
		/// <summary>
		/// Setea la validez
		/// </summary>
		/// <param name="Octets">
		/// A <see cref="System.String"/>
		/// </param>
		/// <param name="VPF_">
		/// A <see cref="VALIDITY_PERIOD_FORMAT"/>
		/// </param>
public void Octets_set(string Octets, VALIDITY_PERIOD_FORMAT VPF_){
DECODE(Octets, VPF_);
}
		/// <summary>
		/// Obtiene los octetos que representan el tiempo de validez.
		/// </summary>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
public string ENCODE(){
StringBuilder Retorno = new StringBuilder();

switch(VPF){
case VALIDITY_PERIOD_FORMAT.RELATIVE:
Retorno.append(Miscellaneous.number2hex(ENCODE_Relative(), 2));
break;
case VALIDITY_PERIOD_FORMAT.ABSOLUTE:
Retorno.append(SCTS.Octets);
break;
case VALIDITY_PERIOD_FORMAT.ENHANCED:
//TODO// Completar est opcion
Retorno.append("00000000000000");
GLib.stdout.printf("<NOT SUPPORTED get VALIDITY_PERIOD_FORMAT.ENHANCED> \n");
break;
default:
Retorno.erase(0, Retorno.len);
break;
}
return Retorno.str;
}
		/// <summary>
		///  Muestra en pantalla los valores
		/// </summary>
public void print_values(){
GLib.stdout.printf("** VALIDITY_PERIOD **\n");
GLib.stdout.printf("VALIDITY_PERIOD_FORMAT: %s\n", VPF.to_string());
switch(VPF){
case VALIDITY_PERIOD_FORMAT.RELATIVE:
GLib.stdout.printf("Minutos de validez: %i\n", Minuttos);
break;
case VALIDITY_PERIOD_FORMAT.ABSOLUTE:
//ServiceCentreTimeStamp TempDate = new ServiceCentreTimeStamp();
//TempDate.SCTS = SCTS_;
SCTS.print_values();
break;
case VALIDITY_PERIOD_FORMAT.ENHANCED:
//Retorno.append("00000000000000");
GLib.stdout.printf("<NOT SUPPORTED VALIDITY_PERIOD_FORMAT.ENHANCED> \n");

break;
}
GLib.stdout.printf("PDU: %s\n", ENCODE());
}

}



}
