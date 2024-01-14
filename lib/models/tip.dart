import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  final String number;
  final String title;
  final String goal;
  final String tipp;
  final String description;
  final String image;
  final String a;
  final String b;
  final String c1;
  final String c2;
  final String alltag;
  final String beiDerArbeit;
  final String hilfeHolen;
  final String kommunikation;
  final String reisen;
  final String unterhaltung;
  final String unterwegs;
  final String zuHause;

  const Tip({
    required this.number,
    required this.title,
    required this.goal,
    required this.tipp,
    required this.description,
    required this.image,
    required this.a,
    required this.b,
    required this.c1,
    required this.c2,
    required this.alltag,
    required this.beiDerArbeit,
    required this.hilfeHolen,
    required this.kommunikation,
    required this.reisen,
    required this.unterhaltung,
    required this.unterwegs,
    required this.zuHause,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
      number: json['number'],
      title: json['title'],
      goal: json['goal'],
      tipp: json['tipp'],
      description: json['description'],
      image: json['image'],
      a: json['a'],
      b: json['b'],
      c1: json['c1'],
      c2: json['c2'],
      alltag: json['alltag'],
      beiDerArbeit: json['bei_der_arbeit'],
      hilfeHolen: json['hilfe_holen'],
      kommunikation: json['kommuikation'],
      reisen: json['reisen'],
      unterhaltung: json['unterhaltung'],
      unterwegs: json['unterwegs'],
      zuHause: json['zu_hause'],
    );
  }

  factory Tip.fromDocumentSnapshot(QueryDocumentSnapshot documentSnapshot) {
    final data = documentSnapshot.data() as Map<String, dynamic>;

    return Tip(
      number: data['number'].toString(),
      title: data['title'].toString(),
      goal: data['goal'].toString(),
      tipp: data['tipp'].toString(),
      description: data['description'].toString(),
      image: data['image'].toString(),
      a: data['a'].toString(),
      b: data['b'].toString(),
      c1: data['c1'].toString(),
      c2: data['c2'].toString(),
      alltag: data['alltag'].toString(),
      beiDerArbeit: data['bei_der_arbeit'].toString(),
      hilfeHolen: data['hilfe_holen'].toString(),
      kommunikation: data['kommunikation'].toString(),
      reisen: data['reisen'].toString(),
      unterhaltung: data['unterhaltung'].toString(),
      unterwegs: data['unterwegs'].toString(),
      zuHause: data['zu_hause'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'number': number,
        'title': title,
        'goal': goal,
        'tipp': tipp,
        'description': description,
        'image': image,
        'a': a,
        'b': b,
        'c1': c1,
        'c2': c2,
        'alltag': alltag,
        'bei_der_arbeit': beiDerArbeit,
        'hilfe_holen': hilfeHolen,
        'kommunikation': kommunikation,
        'reisen': reisen,
        'unterhaltung': unterhaltung,
        'unterwegs': unterwegs,
        'zu_hause': zuHause,
      };
}
