class Tipp {
  final int? nr;
  final int? a;
  final int? b;
  final int? c;
  final int? d;
  final int? alltag;
  final int? beiDerArbeit;
  final int? hilfeHolen;
  final int? kommunikation;
  final int? reisen;
  final String? tipp;
  final int? unterhaltungKultur;
  final int? unterwegs;
  final int? zuHause;

  const Tipp({
    required this.nr,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.alltag,
    required this.beiDerArbeit,
    required this.hilfeHolen,
    required this.kommunikation,
    required this.reisen,
    required this.tipp,
    required this.unterhaltungKultur,
    required this.unterwegs,
    required this.zuHause,
  });

// Factory Methode um die JSON Daten in ein Tipp Objekt umzuwandeln
  factory Tipp.fromJson(Map<String, dynamic> json) {
    return Tipp(
      nr: json['Nr'],
      a: json['A'],
      b: json['B'],
      c: json['C'],
      d: json['D'],
      alltag: json['Alltag'],
      beiDerArbeit: json['Bei der Arbeit'],
      hilfeHolen: json['Hilfe holen'],
      kommunikation: json['Kommuikation'],
      reisen: json['Reisen'],
      tipp: json['Tipps'],
      unterhaltungKultur: json['Unterhaltung_Kultur'],
      unterwegs: json['Unterwegs'],
      zuHause: json['Zu Hause'],
    );
  }
}
