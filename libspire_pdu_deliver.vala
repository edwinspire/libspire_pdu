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
namespace edwinspire.PDU {
	[Description(nick = "FIRST OCTET DELIVER", blurb = "")]
	public class FIRST_OCTET_DELIVER: Octet {
		[Description(nick = "TP_RP", blurb = "Reply path. Parameter indicating that reply path exists.")]
		public bool TP_RP {
			private set;
			get;
			default = false;
		}
		[Description(nick = "TP_UDHI", blurb = "User data header indicator. This bit is set to 1 if the User Data field starts with a header")]
		public bool TP_UDHI {
			get;
			private set;
			default = false;
		}
		[Description(nick = "TP_SRI", blurb = "Status report indication. This bit is set to 1 if a status report is going to be returned to the")]
		public bool TP_SRI {
			get;
			private set;
			default = false;
		}
		[Description(nick = "TP_MMS", blurb = "More messages to send. This bit is set to 0 if there are more messages to send")]
		public bool TP_MMS {
			get;
			private set;
			default = false;
		}
		[Description(nick = "TP_MTI", blurb = "Message type indicator. Bits no 1 and 0 are both set to 0 to indicate that this PDU is an")]
		public MESSAGE_TYPE_INDICATOR TP_MTI {
			get;
			private set;
			default = MESSAGE_TYPE_INDICATOR.RESERVED;
		}
		private bool decoding = false;
		private bool encoding = false;
		public  FIRST_OCTET_DELIVER() {
			this.notify.connect((s, p) => {
				//print("%s\n", p.name);
				if(p.name == "Bin" || p.name == "Dec" || p.name == "Hex") {
					if(!encoding) {
						DECODE();
					}
				} else {
					if(!decoding) {
						ENCODE();
					}
				}
			}
			);
		}
		[Description(nick = "print_values", blurb = "Imprime los valores obtenidos")]
		public void print_values() {
			GLib.stdout.printf("< FIRST_OCTET_DELIVER >\n");
			//GLib.stdout.printf("HEXA:  %s\n", Miscellaneous.number2hex(ENCODE(), 2));
			GLib.stdout.printf("HEXA:  %s\n", this.Hex);
			GLib.stdout.printf("TP_RP: %s\n", TP_RP.to_string());
			GLib.stdout.printf("TP_UDHI: %s\n", TP_UDHI.to_string());
			GLib.stdout.printf("TP_SRI: %s\n", TP_SRI.to_string());
			GLib.stdout.printf("TP_MMS: %s\n", TP_MMS.to_string());
			GLib.stdout.printf("TP_MTI: %s\n", TP_MTI.to_string());
		}
		internal void DECODE() {
			decoding = true;
			//	string Binario = Miscellaneous.ConvertIntToBin(Octet, 8);
			if(this.Bin[0]=='1') {
				TP_RP = true;
			}
			if(this.Bin[1]=='1') {
				TP_UDHI = true;
			}
			if(this.Bin[2]=='1') {
				TP_SRI = true;
			}
			if(this.Bin[5]=='1') {
				TP_MMS = true;
			}
			switch(this.Bin.substring(6,2)) {
				case "00":
						TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_DELIVER;
				break;
				case "01":
						TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_STATUS_REPORT_COMMAND;
				break;
				case "10":
						TP_MTI = MESSAGE_TYPE_INDICATOR.SMS_SUBMIT;
				break;
				case "11":
						TP_MTI = MESSAGE_TYPE_INDICATOR.RESERVED;
				break;
			}
			decoding = false;
		}
		internal void ENCODE() {
			encoding = true;
			StringBuilder Binario = new StringBuilder();
			if(TP_RP) {
				Binario.append("1");
			} else {
				Binario.append("0");
			}
			if(TP_UDHI) {
				Binario.append("1");
			} else {
				Binario.append("0");
			}
			if(TP_SRI) {
				Binario.append("1");
			} else {
				Binario.append("0");
			}
			Binario.append("00");
			if(TP_MMS) {
				Binario.append("1");
			} else {
				Binario.append("0");
			}
			// Binario.append(Miscellaneous.ConvertIntToBin(TP_MTI, 2));
			Binario.append(TP_MTI.ToBin());
			this.Bin = Binario.str;
			encoding = false;
		}
	}
	[Description(nick = "DELIVER", blurb = "SMS entrantes")]
	public class DELIVER: GLib.Object {
		[Description(nick = "SMSC", blurb = "Informacion del SMSC")]
		public PHONE_INFORMATION SMSC {
			get;
			private set;
		}
		[Description(nick = "First Octet", blurb = "Primer Octeto")]
		public FIRST_OCTET_DELIVER FO {
			get;
			private set;
		}
		[Description(nick = "Sender", blurb = "Informacion del Sender")]
		public PHONE_INFORMATION Sender {
			get;
			internal set;
		}
		[Description(nick = "PID", blurb = "Protocol Identifier")]
			public IProtocolIdentifier PID {
			get;
			private set;
		}
		[Description(nick = "DCS", blurb = "Data coding scheme")]
			public IDataCodingScheme DCS {
			get;
			private set;
		}
		// = new DATA_CODING_SCHEME();
		/// <summary>
		/// Service Centre TimeStamp
		/// </summary>
		public TP_SCTS SCTS {
			get;
			internal set;
			default = new TP_SCTS.from_values(1990, 1, 1);
		}
		/// <summary>
		/// Longitud de los datos del usuario
		/// </summary>
		public Octet UDL {
			private set;
			get;
			default = new Octet();
		}
		/// <summary>
		/// Mensaje de texto
		/// </summary>
		private string MESSAGE_a  = "";
		/// <summary>
		/// Constructor
		/// </summary>
		public  DELIVER() {
			this.SMSC = new PHONE_INFORMATION();
			this.Sender = new PHONE_INFORMATION();
			this.PID = new PID_InterWorking();
			this.FO = new FIRST_OCTET_DELIVER();
			this.DCS = new DCS_GeneralDataCodingIndication();
			this.SCTS = new TP_SCTS.from_values(1990, 1, 1);
		}
		public string Message {
			get {
				return MESSAGE_a;
			}
			internal set {
				MESSAGE_a = value;
			}
		}
		/// <summary>
		/// Muestra en pantalla los valores
		/// </summary>
		public void print_values() {
			SMSC.print_values();
			FO.print_values();
			Sender.print_values();
			PID.print_values();
			DCS.print_values();
			SCTS.print_values();
			GLib.stdout.printf("Message: = %s\n", MESSAGE_a);
		}
		/// <summary>
		/// Decodifica una cadena que representa un sms entrante en formato PDU
		/// </summary>
		/// <param name="PDU">
		/// A <see cref="System.String"/>
		/// </param>
		public void DECODE(string PDU) {
			StringBuilder CadenaPDU = new StringBuilder(TextConvert.trim(PDU));
			//print("DECODE PDU => %s\n", CadenaPDU.str);
			StringBuilder TempNUmber = new StringBuilder();
			int lenSMSCInfor = 0;
			int lenSender = 0;
			//Obtenemos la longitud de la informacion del SMSC
			if(CadenaPDU.len>2) {
				lenSMSCInfor = Miscellaneous.hex2number(CadenaPDU.str.substring(0,2));
				CadenaPDU.erase(0, 2);
			}
			//TA_SMSC.DECODE(Miscellaneous.hex2number(CadenaPDU.str.substring(0,2)));
			SMSC.TA.Hex = CadenaPDU.str.substring(0,2);
			//TA_SMSC.Octet = Miscellaneous.hex2number(CadenaPDU.str[0:2]);
			CadenaPDU.erase(0, 2);
			//Telefono.PhonePDU = CadenaPDU.str[0: (lenSMSCInfor-1)*2];
			//SMSC_a.PDU_Format = CadenaPDU.str.substring(0, (lenSMSCInfor-1)*2);
			SMSC.PDU = CadenaPDU.str.substring(0, (lenSMSCInfor-1)*2);
			CadenaPDU.erase(0, (lenSMSCInfor-1)*2);
			if(SMSC.TA.TON == TYPE_OF_NUMBER.INTERNATIONAL) {
				TempNUmber.erase(0, TempNUmber.len);
				//TODO: Ver la posibilidad de agregar el + en este caso
				//TempNUmber.append("+");
				TempNUmber.append(SMSC.TXT);
				SMSC.TXT = TempNUmber.str;
			}
			//--
			//string FirstOctetSMS = "00";	
			if(CadenaPDU.len>2) {
				//FO.DECODE(Miscellaneous.hex2number(CadenaPDU.str.substring(0,2)));
				FO.Hex = CadenaPDU.str.substring(0,2);
				CadenaPDU.erase(0, 2);
			}
			//GLib.stdout.printf("FirstOctetSMS: %s\n", FirstOctetSMS);
			//--
			//int LengSMSNum = 0;	
			if(CadenaPDU.len>2) {
				lenSender = Miscellaneous.hex2number(CadenaPDU.str.substring(0,2));
				CadenaPDU.erase(0, 2);
			}
			//GLib.stdout.printf("LengSMSNum: %i\n", LengSMSNum);
			//--
			//string TypeAddSMSSender = "00";
			if(CadenaPDU.len>2) {
				//TA_Sender.DECODE(Miscellaneous.hex2number(CadenaPDU.str.substring(0,2)));
				Sender.TA.Hex = CadenaPDU.str.substring(0,2);
				CadenaPDU.erase(0, 2);
			}
			//GLib.stdout.printf("TypeAddSMSSender: %s\n", TypeAddSMSSender);
			//--
			//string SMSSender = "000000000000";
			//int LongReal = 0;
			if(!Miscellaneous.IsPair(lenSender)) {
				//Telefono.PhonePDU = CadenaPDU.str[0:lenSender+1];
				Sender.PDU = CadenaPDU.str.substring(0,lenSender+1);
				//Retorno.SENDER = CadenaPDU.str[0:Retorno.SENDER_len+1];
				CadenaPDU.erase(0, lenSender+1);
			} else {
				//Telefono.PhonePDU = CadenaPDU.str[0:lenSender];
				Sender.PDU = CadenaPDU.str.substring(0,lenSender);
				//Retorno.SENDER = CadenaPDU.str[0:lenSender];
				CadenaPDU.erase(0, lenSender);
			}
			if(Sender.TA.TON == TYPE_OF_NUMBER.INTERNATIONAL) {
				TempNUmber.erase(0, TempNUmber.len);
				// TODO: Tomar en cuenta si se debe o no agregar este + en formato intercacional
				//TempNUmber.append("+");
				TempNUmber.append(Sender.TXT);
				Sender.TXT = TempNUmber.str;
			}
			//GLib.stdout.printf("SMSSender: %s\n", SMSSender);
			//--
			//string TPPID = "00";
			if(CadenaPDU.len>2) {
				var ClasseDePID = IProtocolIdentifier.DecodeGroup(CadenaPDU.str.substring(0,2));
				switch(ClasseDePID) {
					case PID_GROUP.Group0:
					this.PID = new PID_InterWorking();
					//this.PID_a.Hex = CadenaPDU.str.substring(0,2);
					break;
					case PID_GROUP.Group1:
					this.PID = new PID_MessageType();
					//this.PID_a.Hex = CadenaPDU.str.substring(0,2);
					break;
					case PID_GROUP.SCSpecificUse:
					this.PID = new PID_SCSpecificUse();
					//this.PID_a.Hex = CadenaPDU.str.substring(0,2);
					break;
					default:
					this.PID = new PID_Reserved();
					//this.PID_a.Hex = CadenaPDU.str.substring(0,2);
					break;
				}
				this.PID.Hex = CadenaPDU.str.substring(0,2);
				CadenaPDU.erase(0, 2);
			}
			//--
			//string TPDCS = "00";
			if(CadenaPDU.len>2) {
				DCS.Hex = CadenaPDU.str.substring(0,2);
				CadenaPDU.erase(0, 2);
			}
			if(CadenaPDU.len>14) {
				//SCTS_a = ServiceCentreTimeStamp.DECODE_(CadenaPDU.str.substring(0,14));
				SCTS.Octets = CadenaPDU.str.substring(0,14);
				CadenaPDU.erase(0, 14);
			}
			//GLib.stdout.printf("CadenaPDU: %s\n", CadenaPDU.str);
			if(CadenaPDU.len>2) {
				//UDL.Hex = Miscellaneous.hex2number(CadenaPDU.str.substring(0,2));
				UDL.Hex = CadenaPDU.str.substring(0,2);
				CadenaPDU.erase(0, 2);
			}
			//PDU_MESSAGE TextPDU = new PDU_MESSAGE();
			//TextPDU.PDU = CadenaPDU.str;
			MESSAGE_a = TextPDUText.DECODE(CadenaPDU.str, DCS.Alpha);
		}
	}
}
