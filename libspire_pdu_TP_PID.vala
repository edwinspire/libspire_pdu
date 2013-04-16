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


public interface IProtocolIdentifier:Octet{
[CCode(notify = false)]
internal abstract bool decoding{get; set;}
[CCode(notify = false)]
internal abstract bool encoding{get; set;}

public static PID_GROUP DecodeGroup(string hex){

string bits = Miscellaneous.ConvertIntToBin(Miscellaneous.hex2number(hex), 8).substring(0, 2);

var Retorno = PID_GROUP.Group0;
//string bits = hex.substring(0, 2);
switch(bits){
case "00":
Retorno = PID_GROUP.Group0;
break;
case "01":
Retorno = PID_GROUP.Group1;
break;
case "10":
Retorno = PID_GROUP.Reserved;
break;
case "11":
Retorno = PID_GROUP.SCSpecificUse;
break;
}
return Retorno;
}

public void OnChangeProperty(string propertyname){
if(propertyname == "Bin" || propertyname == "Dec" || propertyname == "Hex"){
if(!encoding){
Decode();
}
}else{
if(!decoding){
Encode();
}
}
}

internal abstract void Encode();
internal abstract void Decode();
public abstract void print_values();

}


public class PID_SCSpecificUse:IProtocolIdentifier, Octet{
[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

internal void Encode(){
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.SCSpecificUse);
//var cadena = new StringBuilder("11");
this.Bin = "11000000";
}

internal void Decode(){
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.SCSpecificUse);
}

public void print_values(){
print("< PROTOCOL IDENTIFIER >\n");
print("SC Specific Use\n");
print("Hex: %s\n", this.Hex);
}

}

public class PID_Reserved:IProtocolIdentifier, Octet{

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

internal void Encode(){
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Reserved);
this.Bin = "10000000";
}

internal void Decode(){
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Reserved);
}

public void print_values(){
print("< PROTOCOL IDENTIFIER >\n");
print("Reserved\n");
print("Hex: %s\n", this.Hex);
}

}



public class PID_MessageType:IProtocolIdentifier, Octet{

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

private PID_SHORT_MESSAGE iMessage = PID_SHORT_MESSAGE.UNKNOW;

public PID_MessageType(){
decoding = false;
encoding = false;
this.notify.connect((s, p) => {
//print("%s\n", p.name);
OnChangeProperty(p.name);
});
}


public PID_SHORT_MESSAGE Message{
set{
iMessage = value;
}
get{
return iMessage;
}
}

public void print_values(){
print("< PROTOCOL IDENTIFIER >\n");
print("Hex: %s\n", this.Hex);
print("Message Type: %s\n", Message.to_string());
}


internal void Encode(){
encoding = true;
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Group1);
var cadena = new StringBuilder("01");
cadena.append(Miscellaneous.ConvertIntToBin((int)iMessage, 6));
this.Bin = cadena.str;
encoding = false;
}

internal void Decode(){
decoding = true;
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Group1);

if(DecodeGroup(this.Bin) == PID_GROUP.Group1){

int ShortSMS = Miscellaneous.ConvertBinToInt(Bin.substring(2, 6));

switch(ShortSMS){
	case 0:
	iMessage = PID_SHORT_MESSAGE.SHORT_MESSAGE_TYPE_0;
	break;
	case 1:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_1;
	break;
	case 2:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_2;
	break;
	case 3:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_3;
	break;
	case 4:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_4;
	break;
	case 5:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_5;
	break;
	case 6:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_6;
	break;
	case 7:
	iMessage = PID_SHORT_MESSAGE.REPLACE_SHORT_MESSAGE_TYPE_7;
	break;
	case 31:
	iMessage = PID_SHORT_MESSAGE.RETURN_CALL_MESSAGE;
	break;
		case 61:
	iMessage = PID_SHORT_MESSAGE.ME_DATA_DOWNLOAD;
	break;
		case 62:
	iMessage = PID_SHORT_MESSAGE.ME_DEPERSONALIZATION_SHORT_MESSAGE;
		break;
		case 63:
	iMessage = PID_SHORT_MESSAGE.SIM_DATA_DOWNLOAD;
	break;
	default:
	iMessage = PID_SHORT_MESSAGE.RESERVED;
	break;

}


}
decoding = false;
}

}


// if no interworking, SME-to-SME protocol
public class PID_InterWorking:IProtocolIdentifier, Octet{

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

private bool iTelematicInterWorking = false;
private PID_TYPE_TELEMATIC_DEVICE iInterworkingDevice =  PID_TYPE_TELEMATIC_DEVICE.UNKNOW;

public PID_InterWorking(){
decoding = false;
encoding = false;
this.notify.connect((s, p) => {
//print("%s\n", p.name);
OnChangeProperty(p.name);
});
}

public PID_TYPE_TELEMATIC_DEVICE InterworkingDevice{
get{
return iInterworkingDevice;
}
set{
iInterworkingDevice = value;
}
}


public bool TelematicInterWorking{
get{
return iTelematicInterWorking;
}
set{
iTelematicInterWorking = value;
}
}

public void print_values(){
print("< PROTOCOL IDENTIFIER (Interworking) >\n");
print("Hex: %s\n", this.Hex);
print("InterworkingDevice: %s\n", InterworkingDevice.to_string());
print("TelematicInterWorking: %s\n", TelematicInterWorking.to_string());
}

internal void Decode(){
decoding = true;
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Group0);

if(DecodeGroup(this.Bin) == PID_GROUP.Group0){

		if(Bin[2] == '1'){
iTelematicInterWorking = true;
}else{
iTelematicInterWorking = false;
}

int TelemaTic = Miscellaneous.ConvertBinToInt(Bin.substring(3, 2));

switch(TelemaTic){
	
	case 0:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.IMPLICIT;
	break;
	
	case 1:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELEX;
	break;

	case 2:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELEFAX_GROUP3;
	break;

	case 3:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELEFAX_GROUP4;
	break;

	case 4:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.VOICE_TELEPHONE;
	break;

	case 5:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.ERMES;
	break;

	case 6:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.NATIONAL_PAGING_SYSTEM;
	break;

	case 7:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.VIDEOTEX;
	break;

	case 8:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELETEX_CARRIER_UNSPECIFIED;
	break;

	case 9:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELETEX_PSPDN;
	break;

	case 10:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELETEX_CSPDN;
	break;
	
	case 11:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELETEX_PSTN;
	break;
		case 12:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.TELETEX_ISDN;
	break;
		case 13:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.UCI;
	break;
	
		case 16:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.MESSAGE_HANDLING_FACILITY;
	break;
		case 17:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.ANY_PUBLIC_X400_MESSAGE_HANDLING_SYSTEM;
	break;
		case 18:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.INTERNET_ELECTRONIC_MAIL;
	break;

		case 31:
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.A_GSM_MOBILE_STATION;
	break;

default:

if((TelemaTic>=19 && TelemaTic<=23) || TelemaTic==14 || TelemaTic==15){
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.RESERVED;
	
}else if(TelemaTic>=24 && TelemaTic<=30){
	
	iInterworkingDevice = PID_TYPE_TELEMATIC_DEVICE.VALUES_SPECIFIC_TO_EACH_SC;
}

break;	
}


}
decoding = false;
}

internal void Encode(){
encoding = true;
return_if_fail(DecodeGroup(this.Bin) == PID_GROUP.Group0);
var cadena = new StringBuilder("00");
if(iTelematicInterWorking){
cadena.append("1");
}else{
cadena.append("0");
}
cadena.append(iInterworkingDevice.ToBin());
this.Bin = cadena.str;
encoding = false;
}

}

}
