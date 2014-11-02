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
using GLib;
using Gee;
namespace edwinspire.PDU {
	public class Octet:GLib.Object {
		private string iHex {
			get;
			private set;
			default = "";
		}
		private int iDec {
			get;
			private set;
			default = 0;
		}
		private string iBin {
			get;
			private set;
			default = "";
		}
		[Description(nick = "DigitHex", blurb = "Setear o cambiar este campo antes de setear el valor del octeto")]
		public uint DigitHex = 2;
		[Description(nick = "DigitBin", blurb = "Setear o cambiar este campo antes de setear el valor del octeto")]
		public uint DigitBin = 8;
		public string Hex {
			set {
				setFromHex(value);
			}
			get {
				return iHex;
			}
		}
		public int Dec {
			get {
				return iDec;
			}
			set {
				setFromDec(value);
			}
		}
		public string Bin {
			get {
				return iBin;
			}
			set {
				setFromBin(value);
			}
		}
		public Octet(int dec = 0) {
			this.Dec = dec;
			setFromDec(dec);
		}
		private void setFromDec(int dec) {
			this.iDec = dec;
			this.iHex = Miscellaneous.number2hex(dec, DigitHex);
			this.iBin = Miscellaneous.ConvertIntToBin(dec, DigitBin);
		}
		public Octet.from_hex(string hex) {
			this.Dec = 0;
			setFromHex(hex);
		}
		private void setFromHex(string hex) {
			this.iDec = Miscellaneous.hex2number(hex);
			this.iHex = hex;
			this.iBin = Miscellaneous.ConvertIntToBin(iDec, DigitBin);
		}
		public Octet.from_Bin(string bin) {
			this.Dec = 0;
			setFromBin(bin);
		}
		private void setFromBin(string bin) {
			this.iBin = bin;
			this.iDec = Miscellaneous.ConvertBinToInt(bin);
			this.iHex = Miscellaneous.number2hex(iDec, DigitHex);
		}
	}
	/// <summary>
	/// Clase para Codificar y Decodificar mensajes de texto desde y hacia formato PDU
	/// </summary>
	public class TextPDUText: GLib.Object {
		private string pdumsg = "";
		private string txtmsg = "";
		private Octet iUDL = new Octet();
		public PDU_ALPHABET Alphabet {
			get;
			set;
		}
		/// <summary>
		/// Construido
		/// </summary>
		public TextPDUText() {
			Alphabet = PDU_ALPHABET.DEFAULT;
		}
		public void print_values() {
			print("<<<< DATA TEXT >>>>\n");
			print("PDU: %s\n", this.PDU);
			print("UDL: %i\n", this.UDL.Dec);
			print("TXT: %s\n", this.TXT);
			print("PDU: %s\n", this.Alphabet.to_string());
		}
		public string TXT {
			get {
				return txtmsg;
			}
			set {
				//print(">>>>>>>>>>>> TXT Entrada: %s\n", value);
				Alphabet = TextConvert.AutoPDUAlphabet(value);
				txtmsg = value;
			}
		}
		public string PDU {
			get {
				int longitud;
				pdumsg = ENCODE(txtmsg, Alphabet, out longitud);
				this.iUDL.Dec =  longitud;
				return pdumsg;
			}
			set {
				txtmsg = DECODE(value, Alphabet);
			}
		}
		public string ToTXT(string pdu, PDU_ALPHABET Alp) {
			Alphabet = Alp;
			txtmsg = DECODE(pdu, Alphabet);
			return txtmsg;
		}
		public string ToPDU(string txt, PDU_ALPHABET Alp = PDU_ALPHABET.DEFAULT) {
			Alphabet = Alp;
			int longitud;
			pdumsg = ENCODE(txt, Alphabet, out longitud);
			return pdumsg;
		}
		/*
// User Data length
public Octet UDL{
get{
iUDL.Dec = (int)txtmsg.length;
switch(Alphabet){
case PDU_ALPHABET.UCS2:
iUDL.Dec = iUDL.Dec*2;
break;
default:
iUDL.Dec = iUDL.Dec;
break;
}
return iUDL;
}
}
*/
		// User Data length
		public Octet UDL {
			get {
				int longitud;
				pdumsg = ENCODE(txtmsg, Alphabet, out longitud);
				this.iUDL.Dec =  longitud;
				return iUDL;
			}
		}
		public static int CountUnichars(string text) {
			unichar c;
			int l = 0;
			for (int i = 0; text.get_next_char(ref i, out c);) {
				l++;
			}
			return l;
		}
		internal static string ENCODE(string MessageTxT, PDU_ALPHABET Alphabet, out int Length) {
			StringBuilder MessageSMS = new StringBuilder();
			string msg = Miscellaneous.text_as_unicode(MessageTxT);
			switch(Alphabet) {
				case PDU_ALPHABET.DATA8Bits:
					//Implementar
				//Limitar a 140 caracteres
				//TODO: La limitacion deberia hacerse en la funcion y no aqui
				if(msg.length>140) {
					MessageSMS.append(TextConvert.ConvertASCIIToPDU8(msg.substring(0,140)));
				} else {
					MessageSMS.append(TextConvert.ConvertASCIIToPDU8(msg));
				}
				Length = CountUnichars(msg);
				break;
				case PDU_ALPHABET.UCS2:
					//Limitar a 70 caracteres
				//TODO: La limitacion deberia hacerse en la funcion y no aqui
				if(msg.length>70) {
					MessageSMS.append(TextConvert.ConvertASCIIToUCS2(msg.substring(0,70)));
				} else {
					MessageSMS.append(TextConvert.ConvertASCIIToUCS2(msg));
				}
				//Length = MessageSMS.str.length*2;
				Length = CountUnichars(msg)*2;
				break;
				default:
				StringPDU7Bits DatosPDU = TextConvert.StringToSevenBits(msg);
				MessageSMS.append(DatosPDU.PDU);
				Length = DatosPDU.Length;
				/*
if(MessageTxT.length>160){
MessageSMS.append(TextConvert.StringToSevenBits(MessageTxT.substring(0,160)));
	}else{
MessageSMS.append(TextConvert.StringToSevenBits(MessageTxT));
}
*/
				break;
			}
			//GLib.stdout.printf("RECIBIDO: = %s\n", MessageSMS.str);
			return MessageSMS.str;
		}
		/// <summary>
		/// Decodifica //TODO// Implementar correctamente
		/// </summary>
		/// <param name="TextPDU">
		/// A <see cref="System.String"/>
		/// </param>
		/// <param name="Alphabet">
		/// A <see cref="PDU_ALPHABET"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		internal static string DECODE(string TextPDU, PDU_ALPHABET Alphabet) {
			StringBuilder InTXT = new StringBuilder();
			switch(Alphabet) {
				case PDU_ALPHABET.DATA8Bits:
				InTXT.append(TextConvert.ConvertPDU8toASCII(TextPDU));
				break;
				case PDU_ALPHABET.UCS2:
					InTXT.append(TextConvert.ConvertUCS2ToASCII(TextPDU));
				break;
				default:
					InTXT.append(TextConvert.ConvertPDU7toASCII(TextPDU));
				break;
			}
			return InTXT.str;
		}
	}
}
