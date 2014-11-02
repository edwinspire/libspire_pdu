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
//using edwinspire.Misc;
namespace edwinspire.PDU {
	public struct StringPDU7Bits {
		public int Length;
		public string PDU;
		public StringPDU7Bits() {
			this.Length = 0;
			this.PDU = "";
		}
	}
	public class Datetime:GLib.Object {
		private DateTime internalDateTime = new DateTime.now_local();
		public Datetime.now (TimeZone tz) {
			internalDateTime = new DateTime.now(tz);
		}
		public Datetime.now_local () {
			internalDateTime = new DateTime.now_local();
		}
		public Datetime.now_utc () {
			internalDateTime = new DateTime.now_utc();
		}
		public Datetime.from_unix_local (int64 t) {
			internalDateTime = new DateTime.from_unix_local(t);
		}
		public Datetime.from_unix_utc (int64 t) {
			internalDateTime = new DateTime.from_unix_utc(t);
		}
		public Datetime.from_timeval_local (TimeVal tv) {
			internalDateTime = new DateTime.from_timeval_local(tv);
		}
		public Datetime.from_timeval_utc (TimeVal tv) {
			internalDateTime = new DateTime.from_timeval_utc(tv);
		}
		public Datetime (TimeZone tz, int year, int month, int day, int hour, int minute, double seconds) {
			internalDateTime = new DateTime(tz, year, month, day, hour, minute, seconds);
		}
		public Datetime.from_values(int year, int month, int day, int hour = 0, int minute = 0, double seconds = 0, int gmt = 0) {
			internalDateTime = new DateTime(TzFromGmt(gmt), year, month, day, hour, minute, seconds);
		}
		public void set_values(int year, int month, int day, int hour = 0, int minute = 0, double seconds = 0, int gmt = 0) {
			internalDateTime = new DateTime(TzFromGmt(gmt), year, month, day, hour, minute, seconds);
		}
		private static TimeZone TzFromGmt(int gmt) {
			if(gmt>13) {
				gmt = 13;
			} else if(gmt<-12) {
				gmt = -12;
			}
			var CadenaGmt = new StringBuilder(gmt.abs().to_string());
			while(CadenaGmt.len<2) {
				CadenaGmt.prepend("0");
			}
			if(gmt>=0) {
				CadenaGmt.prepend("+");
			} else {
				CadenaGmt.prepend("-");
			}
			CadenaGmt.append(":00");
			return new TimeZone(CadenaGmt.str);
		}
		public Datetime.local (int year, int month, int day, int hour, int minute, double seconds) {
			internalDateTime = new DateTime.local (year, month, day, hour, minute, seconds);
		}
		public Datetime.utc (int year, int month, int day, int hour, int minute, double seconds) {
			internalDateTime = new DateTime.utc (year, month, day, hour, minute, seconds);
		}
		/*
public void add (TimeSpan timespan){
internalDateTime = internalDateTime.add(timespan);
}
*/
		public void add_years (int years) {
			internalDateTime = internalDateTime.add_years(years);
		}
		public void add_months (int months) {
			internalDateTime = internalDateTime.add_months(months);
		}
		public void add_weeks (int weeks) {
			internalDateTime = internalDateTime.add_weeks(weeks);
		}
		public void add_days (int days) {
			internalDateTime = internalDateTime.add_days(days);
		}
		public void add_hours (int hours) {
			internalDateTime = internalDateTime.add_hours(hours);
		}
		/*
public void add_milliseconds (int milli_seconds){
internalDateTime = internalDateTime.add_milliseconds(milli_seconds);
}
*/
		public void add_minutes (int Minutes) {
			internalDateTime = internalDateTime.add_minutes(Minutes);
		}
		public void add_seconds (double Seconds) {
			internalDateTime = internalDateTime.add_seconds(Seconds);
		}
		public void add_full (int years, int months, int days, int hours = 0, int minutes = 0, double seconds = 0) {
			internalDateTime = internalDateTime.add_full(years, months, days, hours, minutes, seconds);
		}
		public int compare (DateTime dt) {
			return internalDateTime.compare(dt);
		}
		/*
private void ChangeProperties(){
internalDateTime = new DateTime(TzFromGmt(gmt), year, month, day, hour, minute, seconds);
}
	*/
		/*
public TimeSpan difference (DateTime begin){
return internalDateTime.difference(begin);
}
*/
		public uint hash () {
			return internalDateTime.hash();
		}
		/*
public bool equal (DateTime dt){
return internalDateTime.equal(dt);
}
*/
		public int Gmt {
			get {
				return int.parse(internalDateTime.get_timezone_abbreviation ());
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(value), this.year, this.month, this.day_of_month, this.hour, this.minute, this.seconds);
			}
		}
		public void get_ymd (out int year, out int month, out int day) {
			internalDateTime.get_ymd(out year, out month, out day);
		}
		public int year {
			get {
				return internalDateTime.get_year();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), value, this.month, this.day_of_month, this.hour, this.minute, this.seconds);
			}
		}
		public int month {
			get {
				return internalDateTime.get_month();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), this.year, value, this.day_of_month, this.hour, this.minute, this.seconds);
			}
		}
		public int day_of_month {
			get {
				return internalDateTime.get_day_of_month();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), this.year, this.month, value, this.hour, this.minute, this.seconds);
			}
		}
		public int week_numbering_year {
			get {
				return internalDateTime.get_week_numbering_year();
			}
		}
		public int week_of_year {
			get {
				return internalDateTime.get_week_of_year();
			}
		}
		public int day_of_week {
			get {
				return internalDateTime.get_day_of_week();
			}
		}
		public int day_of_year {
			get {
				return internalDateTime.get_day_of_year();
			}
		}
		public int hour {
			get {
				return internalDateTime.get_hour();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), this.year, this.month, this.day_of_month, value, this.minute, this.seconds);
			}
		}
		public int minute {
			get {
				return internalDateTime.get_minute();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), this.year, this.month, this.day_of_month, this.hour, value, this.seconds);
			}
		}
		public int second {
			get {
				return internalDateTime.get_second();
			}
			set {
				internalDateTime = new DateTime(TzFromGmt(this.Gmt), this.year, this.month, this.day_of_month, this.hour, this.minute, value);
			}
		}
		public int microsecond {
			get {
				return internalDateTime.get_microsecond();
			}
		}
		public double seconds {
			get {
				return internalDateTime.get_seconds();
			}
		}
		public int64 to_unix () {
			return internalDateTime.to_unix();
		}
		public bool to_timeval (out TimeVal tv) {
			return internalDateTime.to_timeval(out tv);
		}
		/*
public TimeSpan utc_offset{
get {
return internalDateTime.get_utc_offset();
}
}
*/
		public string timezone_abbreviation {
			get {
				return internalDateTime.get_timezone_abbreviation();
			}
		}
		public bool is_daylight_savings {
			get {
				return internalDateTime.is_daylight_savings();
			}
		}
		public void to_timezone (TimeZone tz) {
			internalDateTime = internalDateTime.to_timezone(tz);
		}
		public void to_local () {
			internalDateTime =  internalDateTime.to_local();
		}
		public void to_utc () {
			internalDateTime =  internalDateTime.to_utc();
		}
		public string format (string format) {
			return internalDateTime.format(format);
		}
		public string to_string () {
			return internalDateTime.to_string();
		}
	}
	/// <summary>
	/// Funciones Miscelaneous
	/// </summary>
	public class TextConvert: GLib.Object {
		public static string trim(string value) {
			return Miscellaneous.StringTrim(value);
		}
		/*
private static char CharToSevenBitExtension(char c){
char Retorno = c;
			char c2 = c;
			if (c2 <= '^'){
				if (c2 == '\f')
				{
					Retorno = 10;
				}
				switch (c2)
				{
					case '[':
						Retorno = 60;
					break;
					case '\\':
						Retorno = 47;
					break;
					case ']':
						Retorno = 62;
					break;
					case '^':
						Retorno = 20;
					break;
				}
			}else{
				switch (c2)
				{
					case '{':
						Retorno = 40;
					break;
					case '|':
						Retorno = 64;
					break;
					case '}':
						Retorno = 41;
					break;
					case '~':
						Retorno = 61;
					break;
					default:
						if (c2 == '€')
						{
							Retorno = 101;
						}
						break;
				}
			}
		return Retorno;
		}
*/
		public static ArrayList<char> TextToArrayChar7Bit(string text) {
			var Retorno = new ArrayList<char>();
			// Lista de todos los caracteres validos en PDU de 7 bits y los reemplazos para los caracteres equivalente, ejemplo reemplaza á por a
			HashMap<unichar, char> ListCharsSimple = new HashMap<unichar, char>();
			//HashMap<unichar, int> ListCharsComplex = new HashMap<unichar, int>();
			ListCharsSimple[64] = 0;
			//  @
			ListCharsSimple[163] = 1;
			//  £ // NOTA: Este caracter deberia devolver 1, pero se lo cambia a 63 porque falla al codificar a pdu
			ListCharsSimple[36] = 2;
			//  $
			ListCharsSimple[165] = 3;
			//  ¥
			ListCharsSimple[232] = 4;
			//  è
			ListCharsSimple[233] = 5;
			//  é
			ListCharsSimple[249] = 6;
			//  ù
			ListCharsSimple[236] = 7;
			//  ì
			ListCharsSimple[242] = 8;
			//  ò
			ListCharsSimple[199] = 9;
			//  Ç
			ListCharsSimple[10] = 10;
			//  
			ListCharsSimple[216] = 11;
			//  Ø
			ListCharsSimple[248] = 12;
			//  ø
			ListCharsSimple[13] = 13;
			// \r  
			ListCharsSimple[197] = 14;
			//  Å
			ListCharsSimple[229] = 15;
			//  å
			ListCharsSimple[8710] = 16;
			//  ∆
			ListCharsSimple[95] = 17;
			//  _
			ListCharsSimple[934] = 18;
			//  Φ
			ListCharsSimple[915] = 19;
			//  Γ
			ListCharsSimple[923] = 20;
			//  Λ
			ListCharsSimple[937] = 21;
			//  Ω
			ListCharsSimple[928] = 22;
			//  Π
			ListCharsSimple[936] = 23;
			//  Ψ
			ListCharsSimple[931] = 24;
			//  Σ
			ListCharsSimple[920] = 25;
			//  Θ
			ListCharsSimple[926] = 26;
			//  Ξ
			//ListCharsSimple[-1] = -1;  //  ESCAPE TO EXTENSION TABLE TODO
			//ListCharsSimple[2710] = 10;  //  Form feed TODO
			/*
ListCharsComplex[94] = 1;  //  ^
ListCharsComplex[123] = 2;  //  {
ListCharsComplex[125] = 3;  //  }
ListCharsComplex[92] = 4;  //  \
ListCharsComplex[91] = 5;  //  [
ListCharsComplex[126] = 6;  //  ~
ListCharsComplex[93] = 7;  //  ]
ListCharsComplex[124] = 8;  //  |
ListCharsComplex[8364] = 9;  //  €
*/
			ListCharsSimple[198] = 28;
			//  Æ
			ListCharsSimple[230] = 29;
			//  æ
			ListCharsSimple[223] = 30;
			//  ß
			ListCharsSimple[201] = 31;
			//  É
			ListCharsSimple[32] = 32;
			//   
			ListCharsSimple[33] = 33;
			//  !
			ListCharsSimple[34] = 34;
			//  "
			ListCharsSimple[35] = 35;
			//  #
			ListCharsSimple[164] = 36;
			//  ¤
			ListCharsSimple[37] = 37;
			//  %
			ListCharsSimple[38] = 38;
			//  &
			ListCharsSimple[39] = 39;
			//  '
			ListCharsSimple[40] = 40;
			//  (
			ListCharsSimple[41] = 41;
			//  )
			ListCharsSimple[42] = 42;
			//  *
			ListCharsSimple[43] = 43;
			//  +
			ListCharsSimple[44] = 44;
			//  ,
			ListCharsSimple[45] = 45;
			//  -
			ListCharsSimple[46] = 46;
			//  .
			ListCharsSimple[47] = 47;
			//  /
			ListCharsSimple[48] = 48;
			//  0
			ListCharsSimple[49] = 49;
			//  1
			ListCharsSimple[50] = 50;
			//  2
			ListCharsSimple[51] = 51;
			//  3
			ListCharsSimple[52] = 52;
			//  4
			ListCharsSimple[53] = 53;
			//  5
			ListCharsSimple[54] = 54;
			//  6
			ListCharsSimple[55] = 55;
			//  7
			ListCharsSimple[56] = 56;
			//  8
			ListCharsSimple[57] = 57;
			//  9
			ListCharsSimple[58] = 58;
			//  :
			ListCharsSimple[59] = 59;
			//  ;
			ListCharsSimple[60] = 60;
			//  <
			ListCharsSimple[61] = 61;
			//  =
			ListCharsSimple[62] = 62;
			//  >
			ListCharsSimple[63] = 63;
			//  ?
			ListCharsSimple[161] = 64;
			//  ¡
			ListCharsSimple[65] = 65;
			//  A
			ListCharsSimple[66] = 66;
			//  B
			ListCharsSimple[67] = 67;
			//  C
			ListCharsSimple[68] = 68;
			//  D
			ListCharsSimple[69] = 69;
			//  E
			ListCharsSimple[70] = 70;
			//  F
			ListCharsSimple[71] = 71;
			//  G
			ListCharsSimple[72] = 72;
			//  H
			ListCharsSimple[73] = 73;
			//  I
			ListCharsSimple[74] = 74;
			//  J
			ListCharsSimple[75] = 75;
			//  K
			ListCharsSimple[76] = 76;
			//  L
			ListCharsSimple[77] = 77;
			//  M
			ListCharsSimple[78] = 78;
			//  N
			ListCharsSimple[79] = 79;
			//  O
			ListCharsSimple[80] = 80;
			//  P
			ListCharsSimple[81] = 81;
			//  Q
			ListCharsSimple[82] = 82;
			//  R
			ListCharsSimple[83] = 83;
			//  S
			ListCharsSimple[84] = 84;
			//  T
			ListCharsSimple[85] = 85;
			//  U
			ListCharsSimple[86] = 86;
			//  V
			ListCharsSimple[87] = 87;
			//  W
			ListCharsSimple[88] = 88;
			//  X
			ListCharsSimple[89] = 89;
			//  Y
			ListCharsSimple[90] = 90;
			//  Z
			ListCharsSimple[196] = 91;
			//  Ä
			ListCharsSimple[214] = 92;
			//  Ö
			ListCharsSimple[209] = 93;
			//  Ñ
			ListCharsSimple[220] = 94;
			//  Ü
			ListCharsSimple[167] = 95;
			//  §
			ListCharsSimple[191] = 96;
			//  ¿
			ListCharsSimple[97] = 97;
			//  a
			ListCharsSimple[98] = 98;
			//  b
			ListCharsSimple[99] = 99;
			//  c
			ListCharsSimple[100] = 100;
			//  d
			ListCharsSimple[101] = 101;
			//  e
			ListCharsSimple[102] = 102;
			//  f
			ListCharsSimple[103] = 103;
			//  g
			ListCharsSimple[104] = 104;
			//  h
			ListCharsSimple[105] = 105;
			//  i
			ListCharsSimple[106] = 106;
			//  j
			ListCharsSimple[107] = 107;
			//  k
			ListCharsSimple[108] = 108;
			//  l
			ListCharsSimple[109] = 109;
			//  m
			ListCharsSimple[110] = 110;
			//  n
			ListCharsSimple[111] = 111;
			//  o
			ListCharsSimple[112] = 112;
			//  p
			ListCharsSimple[113] = 113;
			//  q
			ListCharsSimple[114] = 114;
			//  r
			ListCharsSimple[115] = 115;
			//  s
			ListCharsSimple[116] = 116;
			//  t
			ListCharsSimple[117] = 117;
			//  u
			ListCharsSimple[118] = 118;
			//  v
			ListCharsSimple[119] = 119;
			//  w
			ListCharsSimple[120] = 120;
			//  x
			ListCharsSimple[121] = 121;
			//  y
			ListCharsSimple[122] = 122;
			//  z
			ListCharsSimple[228] = 123;
			//  ä
			ListCharsSimple[246] = 124;
			//  ö
			ListCharsSimple[241] = 125;
			//  ñ
			ListCharsSimple[252] = 126;
			//  ü
			ListCharsSimple[224] = 127;
			//  à
			ListCharsSimple[193] = 65;
			//  Á
			ListCharsSimple[262] = 67;
			//  Ć
			ListCharsSimple[201] = 69;
			//  É
			ListCharsSimple[500] = 71;
			//  Ǵ
			ListCharsSimple[205] = 73;
			//  Í
			ListCharsSimple[7728] = 75;
			//  Ḱ
			ListCharsSimple[313] = 76;
			//  Ĺ
			ListCharsSimple[7742] = 77;
			//  Ḿ
			ListCharsSimple[323] = 78;
			//  Ń
			ListCharsSimple[211] = 79;
			//  Ó
			ListCharsSimple[7764] = 80;
			//  Ṕ
			ListCharsSimple[340] = 81;
			//  Ŕ
			ListCharsSimple[346] = 82;
			//  Ś
			ListCharsSimple[218] = 85;
			//  Ú
			ListCharsSimple[471] = 86;
			//  Ǘ
			ListCharsSimple[7810] = 87;
			//  Ẃ
			ListCharsSimple[221] = 89;
			//  Ý
			ListCharsSimple[377] = 90;
			//  Ź
			ListCharsSimple[225] = 97;
			//  á
			ListCharsSimple[263] = 99;
			//  ć
			ListCharsSimple[233] = 101;
			//  é
			ListCharsSimple[501] = 103;
			//  ǵ
			ListCharsSimple[237] = 105;
			//  í
			ListCharsSimple[7729] = 107;
			//  ḱ
			ListCharsSimple[314] = 108;
			//  ĺ
			ListCharsSimple[7743] = 109;
			//  ḿ
			ListCharsSimple[324] = 110;
			//  ń
			ListCharsSimple[243] = 111;
			//  ó
			ListCharsSimple[7765] = 112;
			//  ṕ
			ListCharsSimple[341] = 114;
			//  ŕ
			ListCharsSimple[347] = 115;
			//  ś
			ListCharsSimple[250] = 117;
			//  ú
			ListCharsSimple[472] = 118;
			//  ǘ
			ListCharsSimple[7811] = 119;
			//  ẃ
			ListCharsSimple[253] = 121;
			//  ý
			ListCharsSimple[378] = 122;
			//  ź
			unichar Uchar;
			for (int i = 0; text.get_next_char(ref i, out Uchar);) {
				if(ListCharsSimple.has_key(Uchar)) {
					//print("%s => Caracter simple %i\n", Uchar.to_string(), (int)ListCharsSimple[Uchar]);
					Retorno.add(ListCharsSimple[Uchar]);
				} else if(Uchar == 12) {
					// TODO: FORM FEED Verificar
					Retorno.add(27);
					Retorno.add(10);
				} else if(Uchar == 94) {
					Retorno.add(27);
					Retorno.add(20);
				} else if(Uchar == 123) {
					Retorno.add(27);
					Retorno.add(40);
				} else if(Uchar == 125) {
					Retorno.add(27);
					Retorno.add(41);
				} else if(Uchar == 92) {
					Retorno.add(27);
					Retorno.add(47);
				} else if(Uchar == 91) {
					Retorno.add(27);
					Retorno.add(60);
				} else if(Uchar == 126) {
					Retorno.add(27);
					Retorno.add(61);
				} else if(Uchar == 93) {
					Retorno.add(27);
					Retorno.add(62);
				} else if(Uchar == 124) {
					Retorno.add(27);
					Retorno.add(64);
				} else if(Uchar == 8364) {
					Retorno.add(27);
					Retorno.add(101);
					/*
ListCharsComplex[94] = 1;  //  ^
ListCharsComplex[123] = 2;  //  {
ListCharsComplex[125] = 3;  //  }
ListCharsComplex[92] = 4;  //  \
ListCharsComplex[91] = 5;  //  [
ListCharsComplex[126] = 6;  //  ~
ListCharsComplex[93] = 7;  //  ]
ListCharsComplex[124] = 8;  //  |
ListCharsComplex[8364] = 9;  //  €
*/
				} else {
					Retorno.add(63);
				}
			}
			return Retorno;
		}
		/// <summary>
		/// Convierte caracter PDU con su correspondiente caracter en ascci ISO8859_1
		/// </summary>
		/// <param name="PDUValue">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.Int32"/>
		/// </returns>
		public static int  ConvertCharPDUToASCII(int PDUValue) {
			int Retorno = '?';
			HashMap<int, int> ListPDUChars =  Alphabet7bit_ASCII();
			if(ListPDUChars.has_key(PDUValue)) {
				Retorno = ListPDUChars[PDUValue];
			} else {
				Retorno = PDUValue;
			}
			return Retorno;
		}
		/// <summary>
		/// Convierte una cadena PDU 7 bits hexadecimal  a ascii
		/// </summary>
		/// <param name="Pdu">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static string ConvertPDU7toASCII(string Pdu) {
			//GLib.stdout.printf"ConvertPDU7toASCII: %s", Pdu);
			StringBuilder Temp = new StringBuilder(Pdu);
			ArrayList<string> Binarios = new ArrayList<string>();
			ArrayList<string> BinariosFin = new ArrayList<string>();
			long BitsSobrantes = 0;
			Octet TemporalOcteto = new Octet();
			while(Temp.len>0) {
				if(Temp.len>=2) {
					TemporalOcteto.Hex = Temp.str.substring(0, 2);
					//		 Binarios.add( Miscellaneous.ConvertIntToBin(Miscellaneous.hex2number(Temp.str.substring(0, 2)), 8));
					Binarios.add(TemporalOcteto.Bin);
					Temp.erase(0, 2);
				} else {
					TemporalOcteto.Hex = Temp.str;
					Binarios.add(TemporalOcteto.Bin);
					//		 Binarios.add(  Miscellaneous.ConvertIntToBin(Miscellaneous.hex2number(Temp.str), 8));
					Temp.erase(0, Temp.len);
				}
			}
			int i = 0;
			while(i<Binarios.size) {
				if(i<Binarios.size) {
					BitsSobrantes = Binarios[i].length-7;
					if(BitsSobrantes>0) {
						Temp.erase(0, Temp.len);
						Temp.append(Binarios[i]);
						Temp.erase(0, BitsSobrantes);
						BinariosFin.add(Temp.str);
						if(BitsSobrantes==7) {
							BinariosFin.add(Binarios[i].substring(0, BitsSobrantes));
						} else {
							if((i+1)<Binarios.size) {
								Temp.erase(0, Temp.len);
								Temp.append(Binarios[i+1]);
								Temp.append(Binarios[i].substring(0, BitsSobrantes));
								Binarios[i+1] = Temp.str;
							} else {
								Binarios.add(Binarios[i].substring(0, BitsSobrantes));
							}
						}
					}
				}
				i++;
			}
			Temp.erase(0, Temp.len);
			foreach(string H in BinariosFin) {
				//	GLib.stdout.printfMiscellaneous.ConvertBinToInt(H));
				Temp.append_unichar(ConvertCharPDUToASCII(Miscellaneous.ConvertBinToInt(H)));
			}
			return Temp.str;
		}
		/// <summary>
		/// Convierte una cadena en UCS2 a texto ASCII.
		/// </summary>
		/// <param name="UCS2">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// Cadena en ASCII
		/// </returns>
		public static string ConvertUCS2ToASCII(string UCS2) {
			StringBuilder TextoUCS2 = new StringBuilder(trim(UCS2));
			StringBuilder TextoFinal = new StringBuilder();
			Octet CaracterHexa = new Octet();
			if (TextoUCS2.len>=4) {
				//stdout.printf("UCS2 = %s\n", UCS2);
				while(TextoUCS2.len>0) {
					if (TextoUCS2.len>=4) {
						CaracterHexa.Hex = TextoUCS2.str.substring(0, 4);
						TextoFinal.append_unichar(CaracterHexa.Dec);
						//        stdout.printf ("%s >> [%i]\n", TextoFinal.str, CaracterHexa.Dec);
						TextoUCS2.erase(0, 4);
					} else {
						//CaracterHexa = Convert.ToInt32(TextoUCS2.str.substring(0, TextoUCS2.len), 16);
						CaracterHexa.Hex = TextoUCS2.str.substring(0, TextoUCS2.len);
						TextoFinal.append_unichar(CaracterHexa.Dec);
						TextoUCS2.erase(0, TextoUCS2.len);
					}
				}
			} else {
				TextoFinal.append(TextoUCS2.str);
			}
			return TextoFinal.str;
		}
		//********************************************
		//>> Convierte texto a UCS2.
		//	PARAMETROS: 
		//	string Texto: Texto a convertir
		/// <summary>
		/// Convierte una cadena en ASCII ISO8859_1 a UCS2
		/// </summary>
		/// <param name="Text">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// Cadena en UCS2
		/// </returns>
		public static string ConvertASCIIToUCS2(string Text) {
			string Retorno = "0000";
			//char[] MatrizCaracteres = Text.to_utf8();
			StringBuilder TextoConvertido = new StringBuilder();
			Octet hexOutput = new Octet();
			hexOutput.DigitHex = 4;
			unichar c;
			for (int i = 0; Text.get_next_char(ref i, out c);) {
				hexOutput.Dec = (int)c;
				TextoConvertido.append(hexOutput.Hex);
				//        stdout.printf ("%s is [%i]\n", c.to_string (), CharHex.Dec);
			}
			Retorno = TextoConvertido.str;
			return Retorno;
		}
		/// <summary>
		/// Selecciona el PDU ALPHABET mas adecuado segun el texto ingresado como parametro
		/// </summary>
		/// <param name="Text">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="PDU_ALPHABET"/>
		/// </returns>
		//TODO// Mejorar este metodo para seleccionar tambien segun el set de caracterres que contenga el mensaje
		public static PDU_ALPHABET AutoPDUAlphabet(string Text) {
			PDU_ALPHABET Alpha = PDU_ALPHABET.DEFAULT;
			if(Text.length<=70) {
				Alpha = PDU_ALPHABET.UCS2;
			} else if(Text.length<=140) {
				//TODO: Se ha probado este tipo de mensaje y se ha comprobado que no son soportados por la varios telefonos
				//Alpha = PDU_ALPHABET.DATA8Bits;
			}
			return Alpha;
		}
		/*
/// <summary>
/// Convierte caracter ascci ISO8859_1 con su correspondiente caracter en PDU
/// </summary>
/// <param name="ASCIIValue">
/// A <see cref="System.Int32"/>
/// </param>
/// <returns>
/// A <see cref="System.Int32"/>
/// </returns>
 private static int ConvertASCIIToPDU(int ASCIIValue){	 
	 int Retorno = '?';
foreach(var entry in Alphabet7bit_ASCII().entries){
	if(entry.value == ASCIIValue){
		Retorno = entry.key;
		break;
	}
}
//print("ConvertASCIIToPDU [%i] => [%i]\n", ASCIIValue, Retorno);
	 return Retorno;
 }
*/
		/// <summary>
		/// Convierte de Ascci a PDU en Hexadecimal 8 bits
		/// </summary>
		/// <param name="Ascii">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static string ConvertASCIIToPDU8(string Ascii) {
			StringBuilder Retorno = new StringBuilder();
			Octet CharHex = new Octet();
			unichar c;
			for (int i = 0; Ascii.get_next_char(ref i, out c);) {
				CharHex.Dec = (int)c;
				Retorno.append(CharHex.Hex);
				//        stdout.printf ("%s is [%i]\n", c.to_string (), CharHex.Dec);
			}
			return Retorno.str;
		}
		//TODO// Confimar que este metodo funcione correctamente
		public static string ConvertPDU8toASCII(string Pdu8) {
			StringBuilder Temp = new StringBuilder(trim(Pdu8));
			StringBuilder Retorno = new StringBuilder();
			Octet CharHex = new Octet();
			while(Temp.len>0) {
				if(Temp.len>=2) {
					CharHex.Hex = Temp.str.substring(0, 2);
					Retorno.append(CharHex.Dec.to_string());
					//Retorno.append(Miscellaneous.hex2number(Temp.str.substring(0, 2)).to_string());
					Temp.erase(0, 2);
				}
			}
			return Retorno.str;
		}
		/// <summary>
		/// Convierte una cadena desde ISO 8859-1 al set de caracteres GSM 7 bits
		/// </summary>
		/// <param name="Ascii">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static StringPDU7Bits StringToSevenBits(string Ascii) {
			// NOTA: Limita automaticamente a maximo 160 caracteres
			//print("StringToSevenBits Entrada: %s\n", Ascii);
			StringPDU7Bits Retorno = StringPDU7Bits();
			HashMap<int, string> ListaCaracteresIni = new HashMap<int, string>();
			ArrayList<string> ListaCaracteresFin = new ArrayList<string>();
			Octet CharHex = new Octet();
			CharHex.DigitBin = 7;
			int i = 0;
			foreach(var c in TextToArrayChar7Bit(Ascii)) {
				CharHex.Dec = c;
				ListaCaracteresIni[i] = CharHex.Bin;
				//print("%c => %i\n", c, CharHex.Dec);
				i++;
				if(i>=160) {
					break;
				}
			}
			Retorno.Length = i;
			/*
unichar c;
    for (int xi = 0; Ascii.get_next_char(ref xi, out c);) {
CharHex.Dec = ReplaceSpecialUnicharToChar(c);  
    }
int i = 0;
*/
			/*
	int i = 0;
	while(i<Ascii.length){
		//Convertimos cada caracter a binario y lo agregamos al string Builder
 CharHex.Dec = ConvertASCIIToPDU((int)Ascii[i]);  //ORIGINAL
		ListaCaracteresIni[i] = CharHex.Bin;
		i++;
	}
*/
			StringBuilder Temp = new StringBuilder();
			long BitsFaltantes = 0;
			i = 0;
			//	GLib.stdout.printf ("ListaCaracteresIni %i\n", ListaCaracteresIni.size);
			int x = ListaCaracteresIni.size;
			while(i<x) {
				Temp.truncate(0);
				BitsFaltantes = 0;
				BitsFaltantes = 8-(ListaCaracteresIni[i].length);
				if(BitsFaltantes<8) {
					if(ListaCaracteresIni.has_key(i+1)) {
						//Agrega el nuevo octeto
						Temp.truncate(0);
						Temp.append(ListaCaracteresIni[i+1]);
						Temp.erase(0, ListaCaracteresIni[i+1].length-BitsFaltantes);
						Temp.append(ListaCaracteresIni[i]);
						ListaCaracteresFin.add(Temp.str);
						//GLib.stdout.printf ("Octeto: %s\n",   ListaCaracteresFin[i]);	
						Temp.truncate(0);
						Temp.append(ListaCaracteresIni[i+1]);
						Temp.truncate(7-BitsFaltantes);
						ListaCaracteresIni[i+1] = Temp.str;
					} else {
						ListaCaracteresFin.add(ListaCaracteresIni[i]);
						//GLib.stdout.printf ("*Octeto: %s\n",  ListaCaracteresFin[i]);
					}
				}
				i++;
			}
			Temp.truncate(0);
			foreach(string S in ListaCaracteresFin) {
				CharHex.Bin = S;
				Temp.append(CharHex.Hex);
				//		Temp.append(Miscellaneous.number2hex(Miscellaneous.ConvertBinToInt(S), 2));
			}
			Retorno.PDU = Temp.str;
			return Retorno;
		}
		/// <summary>
		/// Tabla de caracter PDU y su correspondiente ascii
		/// </summary>
		/// <returns>
		/// un Dictionary
		/// </returns>
		public static HashMap<int, int> Alphabet7bit_ASCII() {
			HashMap<int, int> ListPDUChars = new HashMap<int, int>();
			//La llave es el valor PDU y el valor es el ISO8859-1
			ListPDUChars[0] = 64;
			/*  1      £  POUND SIGN                              */
			ListPDUChars[1] = 163;
			/*  2      $  DOLLAR SIGN                             */
			ListPDUChars[2] = 36;
			/*  3      ¥  YEN SIGN                                */
			ListPDUChars[3] = 165;
			/*  4      è  LATIN SMALL LETTER E WITH GRAVE         */
			ListPDUChars[4] = 232;
			/*  5      é  LATIN SMALL LETTER E WITH ACUTE         */
			ListPDUChars[5] = 233;
			/*  6      ù  LATIN SMALL LETTER U WITH GRAVE         */
			ListPDUChars[6] = 249;
			/*  7      ì  LATIN SMALL LETTER I WITH GRAVE         */
			ListPDUChars[7] = 236;
			/*  8      ò  LATIN SMALL LETTER O WITH GRAVE         */
			ListPDUChars[8] = 242;
			/*  9      Ç  LATIN CAPITAL LETTER C WITH CEDILLA     */
			ListPDUChars[9] = 199;
			/*  11     Ø  LATIN CAPITAL LETTER O WITH STROKE      */
			ListPDUChars[11] = 216;
			/*  12     ø  LATIN SMALL LETTER O WITH STROKE        */
			ListPDUChars[12] = 248;
			/*  14     Å  LATIN CAPITAL LETTER A WITH RING ABOVE  */
			ListPDUChars[14] = 197;
			/*  15     å  LATIN SMALL LETTER A WITH RING ABOVE    */
			ListPDUChars[15] = 229;
			/*  16        GREEK CAPITAL LETTER DELTA              */
			ListPDUChars[16] = '?';
			/*  17     _  LOW LINE                                */
			ListPDUChars[17] = 95;
			/*  18        GREEK CAPITAL LETTER PHI                */
			/*  19        GREEK CAPITAL LETTER GAMMA              */
			/*  20        GREEK CAPITAL LETTER LAMBDA             */
			/*  21        GREEK CAPITAL LETTER OMEGA              */
			/*  22        GREEK CAPITAL LETTER PI                 */
			/*  23        GREEK CAPITAL LETTER PSI                */
			/*  24        GREEK CAPITAL LETTER SIGMA              */
			/*  25        GREEK CAPITAL LETTER THETA              */
			/*  26        GREEK CAPITAL LETTER XI                 */
			int x = 18;
			while(x<27) {
				ListPDUChars[x] = '?';
				x++;
			}
			/*  28     Æ  LATIN CAPITAL LETTER AE                 */
			ListPDUChars[28] = 198;
			/*  29     æ  LATIN SMALL LETTER AE                   */
			ListPDUChars[29] = 230;
			/*  30     ß  LATIN SMALL LETTER SHARP S (German)     */
			ListPDUChars[30] = 223;
			/*  31     É  LATIN CAPITAL LETTER E WITH ACUTE       */
			ListPDUChars[31] = 201;
			/*  36     €  CURRENCY SIGN                           */
			ListPDUChars[36] = 164;
			x = 37;
			while(x<64) {
				ListPDUChars[x] = x;
				x++;
			}
			/*  64     ¡  INVERTED EXCLAMATION MARK               */
			ListPDUChars[64] = 161;
			x = 65;
			while(x<91) {
				ListPDUChars[x] = x;
				x++;
			}
			/*  91     Ä  LATIN CAPITAL LETTER A WITH DIAERESIS   */
			ListPDUChars[91] = 196;
			/*  92     Ö  LATIN CAPITAL LETTER O WITH DIAERESIS   */
			ListPDUChars[92] = 214;
			/*  93     Ñ  LATIN CAPITAL LETTER N WITH TILDE       */
			ListPDUChars[93] = 209;
			/*  94     Ü  LATIN CAPITAL LETTER U WITH DIAERESIS   */
			ListPDUChars[94] = 220;
			/*  95     §  SECTION SIGN                            */
			ListPDUChars[95] = 167;
			/*  96     ¿  INVERTED QUESTION MARK                  */
			ListPDUChars[96] = 191;
			x = 97;
			while(x<123) {
				ListPDUChars[x] = x;
				x++;
			}
			/*  123    ä  LATIN SMALL LETTER A WITH DIAERESIS     */
			ListPDUChars[123] = 228;
			/*  124    ö  LATIN SMALL LETTER O WITH DIAERESIS     */
			ListPDUChars[124] = 246;
			/*  125    ñ  LATIN SMALL LETTER N WITH TILDE         */
			ListPDUChars[125] = 241;
			/*  126    ü  LATIN SMALL LETTER U WITH DIAERESIS     */
			ListPDUChars[126] = 252;
			/*  127    à  LATIN SMALL LETTER A WITH GRAVE         */
			ListPDUChars[127] = 224;
			/*  The double chars below must be handled separately after the
    table lookup.
    12             27 10      FORM FEED                                       
    94             27 20   ^  CIRCUMFLEX ACCENT                               
    123            27 40   {  LEFT CURLY BRACKET                              
    125            27 41   }  RIGHT CURLY BRACKET                             
    92             27 47   \  REVERSE SOLIDUS (BACKSLASH)                     
    91             27 60   [  LEFT SQUARE BRACKET                             
    126            27 61   ~  TILDE                                           
    93             27 62   ]  RIGHT SQUARE BRACKET                            
    124            27 64   |  VERTICAL BAR                             */
			return ListPDUChars;
		}
	}
	/// <summary>
	/// Clase con metodos de uso general
	/// </summary>
	public class Miscellaneous: GLib.Object {
		public static string StringTrim(string value) {
			return value.strip();
		}
		
		public static string text_as_unicode(string text){
			
			var msg = new StringBuilder();
			
			int CLength = text.length;
			unichar caracter;
			if(CLength > 0) {
				for (int i = 0; text.get_next_char(ref i, out caracter);) {
					if(i>CLength) {
						break;
					}
					if(caracter.validate()) {
						msg.append_unichar(caracter);
					}
				}
			}
			return msg.str;
		}		
		
		/// <summary>
		/// Convierte una cadena que representa una fecha en formato iso8601 a DateTime
		/// </summary>
		public static DateTime DateTimeFromStringISO8601(string iso8601format) {
			DateTime Fecha =  new DateTime.now_local();
			TimeVal TiempoVal =  TimeVal();
			if(TiempoVal.from_iso8601 (iso8601format)) {
				Fecha =  new DateTime.from_timeval_utc(TiempoVal);
			}
			return Fecha;
		}
		/// <summary>
		/// Convierte una cadena que representa un valor hexadecimal a int
		/// </summary>
		/// <param name="buffer">
		/// </param>
		/// <returns>
		/// un valor int
		/// </returns>
		public static  int hex2number(string buffer) {
			int result = -1;
			buffer.scanf("%x", &result);
			return result;
		}
		/// <summary>
		/// Convierte una cadena que representa un valor binario a int
		/// </summary>
		/// <param name="Binary">
		/// A <see cref="System.String"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.Int32"/>
		/// </returns>
		public static int ConvertBinToInt(string Binary) {
			int i = 0;
			int Resultado = 0;
			string Invert = Binary.reverse(-1);
			while(i<Invert.length) {
				if(Invert[i] == '1') {
					Resultado = Resultado+ (int)Math.ldexp(2, i-1);
				}
				i++;
			}
			return Resultado;
		}
		/// <summary>
		/// Convierte un valor int a una cadena que representa su valor en binario
		/// Length es la longitud de la cadena resultante o longitud de bits
		/// </summary>
		/// <param name="Number">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <param name="Length">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static string ConvertIntToBin(int Number, uint Length) {
			StringBuilder CadenaBin = new StringBuilder();
			while(Number>0) {
				CadenaBin.append_printf("%u", Number % 2);
				Number/=2;
			}
			while(CadenaBin.len<Length) {
				CadenaBin.append("0");
			}
			return (CadenaBin.str).reverse(-1);
		}
		/// <summary>
		/// Determina si un valor es par.
		/// </summary>
		/// <param name="Num">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.Boolean"/>
		/// </returns>
		public static bool IsPair(int Num) {
			bool Retorno = false;
			string Binario  = ConvertIntToBin((int)Num, 8);
			if(Binario[7]=='0') {
				Retorno = true;
			}
			return Retorno;
		}
		/// <summary>
		/// Convierte un valor decimal a una cadena que representa su equivalente en Hexadecimal.
		/// Digits es la longitud de la cadena o numero de digitos del valor Hexadecimal.
		/// </summary>
		/// <param name="Decimal">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <param name="Digits">
		/// A <see cref="System.Int32"/>
		/// </param>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static  string number2hex(int Decimal, uint Digits) {
			//string Retorno = "00000000000000000000";
			StringBuilder Cadena = new StringBuilder();
			Cadena.append_printf("%x", Decimal);
			while(Cadena.len<Digits) {
				Cadena.prepend("0");
			}
			return Cadena.str;
		}
		/// <summary>
		/// Obtiene al path donde actualmente esta ubicado este ensamblado
		/// </summary>
		/// <returns>
		/// A <see cref="System.String"/>
		/// </returns>
		public static string PathRun() {
			StringBuilder Retorno = new StringBuilder(Environment.get_current_dir());
			return Retorno.str;
		}
	}
}
