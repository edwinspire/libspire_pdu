//using edwinspire.Misc;

		namespace edwinspire.PDU{


public class TP_SCTS: Datetime{

public TP_SCTS (TimeZone tz, int year, int month, int day, int hour, int minute, double seconds){
base(tz, year, month, day, hour, minute, seconds);
}

public TP_SCTS.from_octets(string octets){
base.now_local();
this.Octets = octets;
}

public TP_SCTS.now_local(){
base.now_local();
}

public TP_SCTS.from_values(int year, int month, int day, int hour = 0, int minute = 0, double seconds = 0, int gmt = 0){
base.from_values(year, month, day, hour, minute, seconds, gmt);
}

// 7 Octetos de longitud
// TODO // Crear una exepnion si lo tiene la longitud de 14 caracteres
internal void DECODE(string octet){

//print("<<<<<<<<<<<<<<TP_SCTS Octeto>>>>>>>>>>>>>>>>>: %s\n", octet);

			try{
Regex RegExp = new Regex("""(?<Year>[0-9][0-9])(?<Month>[0-9][0-9])(?<Day>[0-9][0-9])(?<Hour>[0-9][0-9])(?<Minutes>[0-9][0-9])(?<Seconds>[0-9][0-9])(?<GMT>[0-9\w][0-9\w])""");

MatchInfo match;
if(RegExp.match(octet, RegexMatchFlags.ANCHORED, out match)){
int Year_ = int.parse(match.fetch_named("Year").reverse(-1))+2000;
int Month_ = int.parse(match.fetch_named("Month").reverse(-1));
int Day_ = int.parse(match.fetch_named("Day").reverse(-1));
int Hour_ = int.parse(match.fetch_named("Hour").reverse(-1));
int Minute_ = int.parse(match.fetch_named("Minutes").reverse(-1));
int Second_ = int.parse(match.fetch_named("Seconds").reverse(-1));

//Timezone Relation to GMT. One unit is 15min. If MSB=1, value is  negative.
var GMTint = new Octet.from_hex(match.fetch_named("GMT").reverse(-1));

//int GMTx = int.parse(match.fetch_named("GMT").reverse(-1));
int GMTx = GMTint.Dec;

if(GMTx>63){
// El GMT es negativo
GMTx = (GMTx-64)*-1;
}
GMTx = (GMTx*15)/60; 

this.set_values(Year_, Month_, Day_, Hour_, Minute_, Second_, GMTx);

}else{
warning("TP_SCTS no tiene el formato correct\n");
}
			
	}
catch (RegexError err) {
                warning (err.message);
		}
}

public string Octets{
get{
return ENCODE();
}
set{
DECODE(value);
}

}

internal unowned string ENCODE(){
var Retorno = new StringBuilder();

Retorno.append(((this.year-1900).to_string()).reverse(-1));
Retorno.append(((this.month).to_string()).reverse(-1));
Retorno.append(((this.day_of_month).to_string()).reverse(-1));
Retorno.append(((this.hour).to_string()).reverse(-1));
Retorno.append(((this.minute).to_string()).reverse(-1));
Retorno.append(((this.second).to_string()).reverse(-1));

if(this.Gmt<0){
this.Gmt = (this.Gmt*-1)+64;
}
Retorno.append((Miscellaneous.number2hex((this.Gmt*60)/15, 2)).reverse(-1));
return Retorno.str;
}

public void print_values(){
GLib.stdout.printf("[Service Centre TimeStamp]\n");
GLib.stdout.printf("Date: = %s\n", this.to_string());
GLib.stdout.printf("GMT: = %s\n", this.Gmt.to_string());
}

}



}
