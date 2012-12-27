//using edwinspire.Misc;

namespace edwinspire.PDU{



public interface IDataCodingScheme:Octet{

public abstract PDU_ALPHABET Alpha {get; set;}

[CCode(notify = false)]
internal abstract bool decoding{set; get;}
[CCode(notify = false)]
internal abstract bool encoding{set; get;}


public static Type DecodeGroup(string Bin){
Type Retorno = Type.INTERFACE;
string bits = Bin.substring(0, 4);

if(bits.has_prefix("00")){
Retorno = typeof(DCS_GeneralDataCodingIndication);
}else if(bits == "1100"){
Retorno = typeof(DCS_MessageWaitingIndicationGroup);
}else if(bits == "1101"){
Retorno = typeof(DCS_MessageWaitingIndicationGroup);
}else if(bits == "1110"){
Retorno = typeof(DCS_MessageWaitingIndicationGroup);
}else if(bits == "1111"){
Retorno = typeof(DCS_DataCodingMessageClass);
}else{
Retorno = typeof(DCS_Reserved);
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

public class DCS_GeneralDataCodingIndication:IDataCodingScheme,Octet{

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}


public bool TextIsCompressed = false;
public bool HaveAMessageClassMeaning = false;
public PDU_ALPHABET Alpha{get; set; default = PDU_ALPHABET.DEFAULT;}
public DCS_MESSAGE_CLASS MessageClass = DCS_MESSAGE_CLASS.TE_SPECIFIC;

public DCS_GeneralDataCodingIndication(){

Alpha = PDU_ALPHABET.DEFAULT;

decoding = false;
encoding = false;

this.Hex = "00";

this.notify.connect((s, p) => {
//print("%s\n", p.name);
OnChangeProperty(p.name);
});
}

internal void Encode(){
encoding = true;
var cadena = new StringBuilder("00");

if(TextIsCompressed){
cadena.append("1");
}else{
cadena.append("0");
}

if(HaveAMessageClassMeaning){
cadena.append("1");
}else{
cadena.append("0");
}

cadena.append(Alpha.ToBin());
cadena.append(MessageClass.ToBin());

this.Bin = cadena.str;
encoding = false;
}

internal void Decode(){
decoding = true;
if(this.Bin[4] == '0'){
TextIsCompressed = false;
}else{
TextIsCompressed = true;
}

	switch(this.Bin.substring(4,2)){
		case "00":
		Alpha = PDU_ALPHABET.DEFAULT;
		break;
		case "01":
		Alpha = PDU_ALPHABET.DATA8Bits;
		break;
		case "10":
		Alpha = PDU_ALPHABET.UCS2;
		break;
		case "11":
		Alpha = PDU_ALPHABET.RESERVED;
		break;
	}

if(this.Bin[5] == '0'){
HaveAMessageClassMeaning = false;
MessageClass = DCS_MESSAGE_CLASS.TE_SPECIFIC;
}else{
HaveAMessageClassMeaning = true;

	switch(this.Bin.substring(6, 2)){
		case "00":
		MessageClass = DCS_MESSAGE_CLASS.IMMEDIATE_DISPLAY;
		break;
		case "01":
		MessageClass = DCS_MESSAGE_CLASS.ME_SPECIFIC;
		break;
		case "10":
		MessageClass = DCS_MESSAGE_CLASS.SIM_SPECIFIC;
		break;
		case "11":
		MessageClass = DCS_MESSAGE_CLASS.TE_SPECIFIC;
		break;
	}

}

decoding = false;
}

public void print_values(){
GLib.stdout.printf("< DATA CODING SCHEME >\n");
GLib.stdout.printf("TextIsCompressed: %s\n", TextIsCompressed.to_string());
GLib.stdout.printf("HaveAMessageClassMeaning: %s\n", HaveAMessageClassMeaning.to_string());
GLib.stdout.printf("MessageClass: %s\n", MessageClass.to_string());
GLib.stdout.printf("Alpha: %s\n", Alpha.to_string());
}

}


public class DCS_MessageWaitingIndicationGroup:IDataCodingScheme,Octet{

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

public bool SetIndication = false;
public DCS_INDICATION_TYPE IndicationType = DCS_INDICATION_TYPE.UNKNOW;
public DCS_MESSAGE_WAITING_INDICATION_GROUP Group = DCS_MESSAGE_WAITING_INDICATION_GROUP.DiscardMessage;
private PDU_ALPHABET iAlpha = PDU_ALPHABET.DEFAULT;

public PDU_ALPHABET Alpha{
get{
return iAlpha;
}
set{
//iAlpha = value;
}
}

public DCS_MessageWaitingIndicationGroup(){
decoding = false;
encoding = false;
this.notify.connect((s, p) => {
print("%s\n", p.name);
OnChangeProperty(p.name);
});
}

internal void Encode(){
encoding = true;
var cadena = new StringBuilder();

cadena.append(Group.ToBin());

if(SetIndication){
cadena.append("1");
}else{
cadena.append("0");
}

cadena.append("0");
cadena.append(IndicationType.ToBin());

this.Bin = cadena.str;
encoding = false;
}


internal void Decode(){
decoding = true;
if((this.Bin.has_prefix("1100") && Group == DCS_MESSAGE_WAITING_INDICATION_GROUP.DiscardMessage) || (this.Bin.has_prefix("1101") && Group == DCS_MESSAGE_WAITING_INDICATION_GROUP.StoreMessage_DefaultAlphabet) || (this.Bin.has_prefix("1110") && Group == DCS_MESSAGE_WAITING_INDICATION_GROUP.StoreMessage_UCS2Alphabet) ){

switch(this.Bin.substring(0, 4)){
case "1100":
Group = DCS_MESSAGE_WAITING_INDICATION_GROUP.DiscardMessage;
iAlpha = PDU_ALPHABET.DEFAULT;
break;
case "1101":
Group = DCS_MESSAGE_WAITING_INDICATION_GROUP.StoreMessage_DefaultAlphabet;
iAlpha = PDU_ALPHABET.DEFAULT;
break;
case "1110":
Group = DCS_MESSAGE_WAITING_INDICATION_GROUP.StoreMessage_UCS2Alphabet;
iAlpha = PDU_ALPHABET.UCS2;
break;
}

if(this.Bin[5] == '0'){
SetIndication = false;
}else{
SetIndication = true;
}

switch(this.Bin.substring(6, 2)){
case "00":
IndicationType = DCS_INDICATION_TYPE.VOICE_MAIL_MESSAGE_WAITING;
break;
case "01":
IndicationType = DCS_INDICATION_TYPE.FAX_MESSAGE_WAITING;
break;
case "10":
IndicationType = DCS_INDICATION_TYPE.ELECTRONIC_MAIL_MESSAGE_WAITING;
break;
case "11":
IndicationType = DCS_INDICATION_TYPE.OTHER_MESSAGE_WAITING;
break;
}

}else{
warning("");
}
decoding = false;
}

public void print_values(){
GLib.stdout.printf("< DATA CODING SCHEME >\n");
GLib.stdout.printf("SetIndication: %s\n", SetIndication.to_string());
GLib.stdout.printf("IndicationType: %s\n", IndicationType.to_string());
GLib.stdout.printf("Group: %s\n", Group.to_string());
GLib.stdout.printf("Alpha: %s\n", Alpha.to_string());
}

}

public class DCS_DataCodingMessageClass:IDataCodingScheme,Octet{

public DCS_MessageCoding MessageCoding = DCS_MessageCoding.Default;
public DCS_MESSAGE_CLASS MessageClass = DCS_MESSAGE_CLASS.TE_SPECIFIC;
private PDU_ALPHABET iAlpha = PDU_ALPHABET.DEFAULT;

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

public DCS_DataCodingMessageClass(){
decoding = false;
encoding = false;
this.notify.connect((s, p) => {
//print("%s\n", p.name);
OnChangeProperty(p.name);
});
}

public PDU_ALPHABET Alpha{
get{

if(MessageCoding == DCS_MessageCoding.Default){
iAlpha = PDU_ALPHABET.DEFAULT;
}else{
iAlpha = PDU_ALPHABET.DATA8Bits;
}

return iAlpha;
}
set{

if(value == PDU_ALPHABET.DATA8Bits){
MessageCoding = DCS_MessageCoding.8BitData;
}else{
MessageCoding = DCS_MessageCoding.Default;
}

}
}

internal void Encode(){
encoding = true;
var cadena = new StringBuilder("11110");

if(MessageCoding == DCS_MessageCoding.Default){
cadena.append("0");
}else{
cadena.append("1");
}

cadena.append(MessageClass.ToBin());

this.Bin = cadena.str;
encoding = false;
}

internal void Decode(){
decoding = true;
if(this.Bin.has_prefix("1111")){

if(this.Bin[5] == '0'){
MessageCoding  = DCS_MessageCoding.Default;
}else{
MessageCoding  = DCS_MessageCoding.8BitData;
}

	switch(this.Bin.substring(6, 2)){
		case "00":
		MessageClass = DCS_MESSAGE_CLASS.IMMEDIATE_DISPLAY;
		break;
		case "01":
		MessageClass = DCS_MESSAGE_CLASS.ME_SPECIFIC;
		break;
		case "10":
		MessageClass = DCS_MESSAGE_CLASS.SIM_SPECIFIC;
		break;
		case "11":
		MessageClass = DCS_MESSAGE_CLASS.TE_SPECIFIC;
		break;
	}

}else{
warning("");
}
decoding = false;
}

public void print_values(){
GLib.stdout.printf("< DATA CODING SCHEME >\n");
GLib.stdout.printf("MessageCoding: %s\n", MessageCoding.to_string());
GLib.stdout.printf("MessageClass: %s\n", MessageClass.to_string());
GLib.stdout.printf("Alpha: %s\n", Alpha.to_string());
}

}

public class DCS_Reserved:IDataCodingScheme,Octet{

private PDU_ALPHABET iAlpha = PDU_ALPHABET.DEFAULT;

[CCode(notify = false)]
internal bool decoding{set; get;}
[CCode(notify = false)]
internal bool encoding{set; get;}

public PDU_ALPHABET Alpha{
get{
return iAlpha;
}
set{
iAlpha = value;
}
}

internal void Encode(){

}
internal void Decode(){
if(!this.Bin.has_prefix("00") || this.Bin.has_prefix("1100") || this.Bin.has_prefix("1101") || this.Bin.has_prefix("1110") || this.Bin.has_prefix("1111")){
warning("");
}
}
public void print_values(){
GLib.stdout.printf("< DATA CODING SCHEME RESERVED >\n");
//GLib.stdout.printf("Group: %s\n", Group.to_string());
GLib.stdout.printf("Alpha: %s\n", Alpha.to_string());
}

}

}
