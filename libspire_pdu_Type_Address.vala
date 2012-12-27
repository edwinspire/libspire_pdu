//using edwinspire.Misc;

namespace edwinspire.PDU{


		
/// <summary>
/// Tipo de Direccion
/// </summary>
public class TYPE_ADDRESS: Octet{
	/// <summary>
	/// Number Plan Identification
	/// </summary>
		public NUMBERING_PLAN_IDENTIFICATION NPI{get; set;}
		/// <summary>
		/// Tipo de Numero
		/// </summary>
	public TYPE_OF_NUMBER TON{get; set;}

private bool decoding = false;
private bool encoding = false;

		/// <summary>
		/// Constructor
		/// </summary>
	public TYPE_ADDRESS(){
	
	NPI = NUMBERING_PLAN_IDENTIFICATION.UNKNOW;
	TON = TYPE_OF_NUMBER.UNKNOW;

this.notify.connect((s, p) => {
if(p.name == "Bin" || p.name == "Dec" || p.name == "Hex"){
if(!encoding){
DECODE();
}
}else{
if(!decoding){
ENCODE();
}
}

});
		
	}
		/// <summary>
		/// Imprime los valores
		/// </summary>
	public void print_values(){
GLib.stdout.printf("TYPE OF ADDRESS OCTET VALUES\n");
GLib.stdout.printf("HEXA:  %s\n", this.Hex);
GLib.stdout.printf("NUMBERING_PLAN_IDENTIFICATION:  %s\n", NPI.to_string());
GLib.stdout.printf("TYPE_OF_NUMBER: %s\n", TON.to_string());
	}
		/// <summary>
		/// Obtiene un octeto segun los parametros actuales
		/// </summary>
		/// <returns>
		/// A <see cref="System.Int32"/>
		/// Devuelve un octeto en decimal
		/// </returns>
internal void ENCODE(){
encoding = true;
	StringBuilder Binario = new StringBuilder("1");
			Binario.append(TON.ToBin());

	//Numbering plan identification
 Binario.append(NPI.ToBin());
	
	this.Bin = Binario.str;
///	return  Miscellaneous.ConvertBinToInt(Binario.str);
encoding = false;
}


		/// <summary>
		/// Decodifica los parametros desde el octeto pasado como parametro
		/// </summary>
		/// <param name="Octect">
		/// A <see cref="System.Int32"/>
		/// </param>
internal void DECODE(){
decoding = true;

	//    Meaning of the Type-of-number bits (6, 5 and 4)
	switch(this.Bin.substring(1,3)){
		case "001":
		TON = TYPE_OF_NUMBER.INTERNATIONAL;
		break;
			case "010":
		TON = TYPE_OF_NUMBER.NATIONAL;
		break;
			case "011":
		TON = TYPE_OF_NUMBER.NETWORK_SPECIFIC;
		break;
			case "100":
		TON = TYPE_OF_NUMBER.SUBSCRIBER;
		break;
			case "101":
		TON = TYPE_OF_NUMBER.ALPHANUMERIC;
		break;
			case "110":
		TON = TYPE_OF_NUMBER.ABBREVIATED;
		break;
			case "111":
		TON = TYPE_OF_NUMBER.RESERVED;
		break;
		default:
		TON = TYPE_OF_NUMBER.UNKNOW;
		break;
	}
	
	//Numbering plan identification
	switch(this.Bin.substring(4, 4)){

case "0000":
NPI = NUMBERING_PLAN_IDENTIFICATION.UNKNOW;
break;				
case "0011":
NPI = NUMBERING_PLAN_IDENTIFICATION.DATA;
break;
case "0001":
NPI = NUMBERING_PLAN_IDENTIFICATION.ISDN;
break;
case "0100":
NPI = NUMBERING_PLAN_IDENTIFICATION.TELEX;
break;
case "1000":
NPI = NUMBERING_PLAN_IDENTIFICATION.NATIONAL;
break;
case "1001":
NPI = NUMBERING_PLAN_IDENTIFICATION.PRIVATE;
break;
case "1010":
NPI = NUMBERING_PLAN_IDENTIFICATION.ERMES;
break;

default:
NPI = NUMBERING_PLAN_IDENTIFICATION.RESERVED;
break;		
		
	}
decoding = false;
}

}


}
