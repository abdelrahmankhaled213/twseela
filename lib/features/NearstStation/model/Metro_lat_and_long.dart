 import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twseela/core/constants/MetroConstants.dart';

class Stations {

  String stationName;
  double lat;
  double long;
  double? distance;
  String whichLine;

  Stations(
            this.stationName,
      this.lat,
      this.long,
      this.whichLine,
      [this.distance]

      );

  static var stationList =
  <Stations>[

    Stations(MetroConstants.helwan,29.848889, 31.334167, "line1"),

    Stations(MetroConstants.ainHelwan,29.862778, 31.325000,
        "line1"),

    Stations(
        MetroConstants.helwanUniversity, 29.868889, 31.320278,
        "line1"),

    Stations(MetroConstants.wadiHof, 29.879444, 31.313333, "line1"),

    Stations(
        MetroConstants.hadayeqHelwan, 29.897222, 31.304167,
        "line1"),
    Stations(MetroConstants.el_maasara, 29.906111, 31.299722,
        "line1"),
    Stations(MetroConstants.toraElAsmant, 29.925833, 31.287778, "line1"),
    Stations(MetroConstants.kozzika, 29.936111, 31.281667, "line1"),
    Stations(
        MetroConstants.toraElBalad, 29.946389, 31.273611, "line1"),
    Stations(
        MetroConstants.thakanatElMaadi, 29.952778, 31.263333, "line1"),

    Stations(MetroConstants.maadi, 29.959722, 31.258056, "line1"),

    Stations(
        MetroConstants.hadayeqElMaadi,29.970000, 31.250556, "line1"),
    Stations(MetroConstants.darElSalam,29.981944, 31.242222, "line1"),
    Stations(MetroConstants.elZahraa, 29.995278, 31.231667, "line1"),
    Stations(MetroConstants.marGirgis, 30.005833, 31.229444,
        "line1"),
    Stations(MetroConstants.elMalekElSaleh, 30.016944, 31.230833, "line1"),
    Stations(MetroConstants.alSayyedaZeinab, 30.029167, 31.235278
        , "line1"),
    Stations(
        MetroConstants.saadZaghloul, 30.036667, 31.238056, "line1"),
    Stations(MetroConstants.sadat, 30.044444, 31.235556, "line1"),
    Stations(MetroConstants.nasser,30.053611, 31.238889, "line1"),
    Stations(MetroConstants.urabi, 30.057500, 31.242500, "line1"),
    Stations(
        MetroConstants.alShohadaa, 30.061944, 31.246111, "line1"),

    Stations(MetroConstants.ghamra, 30.068889, 31.264722, "line1"),

    Stations(MetroConstants.elDemerdash, 30.077222, 31.277778, "line1"),

    Stations(
        MetroConstants.manshietElSadr, 30.082222, 31.287778,
        "line1"),

    Stations(
        MetroConstants.kobriElQobba, 30.086944, 31.293889, "line1"),
    Stations(MetroConstants.hammamatElQobba, 330.090278, 31.298056,
        "line1"),
    Stations(
        MetroConstants.sarayElQobba, 30.098056, 31.304722, "line1"),
    Stations(MetroConstants.hadayeqElZaitoun, 30.105278, 31.310000, "line1"),

    Stations(MetroConstants.helmeyetElZaitoun, 30.114444, 31.313889, "line1"),

    Stations(
        MetroConstants.elMatareyya, 30.121389, 31.313889, "line1"),

    Stations(MetroConstants.ainShams, 30.131111, 31.319167,
        "line1"),

    Stations(
        MetroConstants.ezbetElNakhl, 30.139167, 31.324444,
        "line1"),

    Stations(
        MetroConstants.elMarg, 30.152222, 31.335556, "line1"),

    Stations(MetroConstants.newElMarg, 30.163333, 31.338333, "line1"),

    Stations(MetroConstants.Monib,29.981389, 31.211944, "line2"),

    Stations(MetroConstants.SakiatMekki, 29.995556, 31.208611,
        "line2"),
    Stations(
        MetroConstants.OmmElMisryeen, 30.005278, 31.208056,
        "line2"),
    Stations(MetroConstants.Giza, 30.010556, 31.206944, "line2"),
    Stations(
        MetroConstants.Faisal,30.017222, 31.203889, "line2"),

    Stations(MetroConstants.CairoUniversity, 30.026111, 31.201111,
        "line2"),
    Stations(MetroConstants.Bohooth, 30.035833, 31.200278,
        "line2"),
    Stations(
        MetroConstants.Dokki,30.038333, 31.211944, "line2"),
    Stations(MetroConstants.Opera, 30.041944, 31.225278, "line2"),
    Stations(
        MetroConstants.MohamedNaguib,30.045278, 31.244167,
        "line2"),

    Stations(MetroConstants.Ataba, 30.052500, 31.246944, "line2"),

    Stations(MetroConstants.ElMassara, 30.071111, 31.245000, "line2"),

    Stations(MetroConstants.roadAlFarag, 30.080556, 31.245556, "line2"),
    Stations(
        MetroConstants.SainteTerez, 30.088333, 31.245556, "line2"),
    Stations(MetroConstants.Khalafawy, 30.098056, 31.245278, "line2"),
    Stations(MetroConstants.Mezallat2, 30.105000, 31.246667, "line2"),
    Stations(MetroConstants.KolietElZeraa, 30.113889, 31.248611, "line2"),
    Stations(
        MetroConstants.ShobraElKheima, 30.122500, 31.244722, "line2"),

    Stations(MetroConstants.AdlyMansour, 30.146944, 31.421389, "line3"),
    Stations(MetroConstants.HuckStep, 30.143889, 31.404722, "line3"),
    Stations(
      MetroConstants.OmarIbnAlKhattab,30.140556, 31.394167, "line3"),
    Stations(MetroConstants.Qubaa, 30.134722, 31.383889, "line3"),

    Stations(MetroConstants.HeshamBarak, 30.131111, 31.372778, "line3"),
    Stations(MetroConstants.AlNozha, 30.128333, 31.360000, "line3"),

    Stations(MetroConstants.ShamsClub, 30.122222, 31.343889, "line3"),
    Stations(MetroConstants.AlfMaskan, 30.118056, 31.339722, "line3"),
    Stations(MetroConstants.heliopolis, 30.108056, 31.338056, "line3"),
    Stations(
        MetroConstants.haroun, 30.101111, 31.332778, "line3"),
    Stations(MetroConstants.alharam,30.091389, 31.326389, "line3"),
    Stations(
        MetroConstants.kolyetElBanat,30.083611, 31.328889, "line3"),
    Stations(
        MetroConstants.cairoStadium, 30.073056, 31.317500, "line3"),
    Stations(MetroConstants.abbassiya, 30.069722, 31.280833, "line3"),
    Stations(MetroConstants.fairZone, 30.073333, 31.301111, "line3"),
    Stations(MetroConstants.abdouPasha, 30.064722, 31.274722, "line3"),
    Stations(MetroConstants.elGeish, 30.061944, 31.266944, "line3"),
    Stations(
        MetroConstants.babElsh3ria, 30.053889, 31.256111, "line3"),

    Stations(MetroConstants.Maspeerou,30.055556, 31.232222, "line3"),
    Stations(
        MetroConstants.safaaHegazy, 30.062500, 31.222500, "line3"),
    Stations(MetroConstants.kitkat, 30.066667, 31.213056, "line3"),
    Stations(MetroConstants.sudanSt,30.069722, 31.205278, "line3"),
    Stations(MetroConstants.imbaba, 30.075833, 31.207500, "line3"),
    Stations(MetroConstants.elBohy, 30.082222, 31.210556, "line3"),
    Stations(MetroConstants.qaumiya, 30.093333, 31.208889, "line3"),
    Stations(MetroConstants.ringRoad,30.096389, 31.199722, "line3"),
    Stations(MetroConstants.roadAlFarag, 30.101944, 31.184167, "line3"),
    Stations(MetroConstants.elTawfikeya, 30.065278, 31.202500, "line3"),
    Stations(MetroConstants.wdiElNil, 30.587313, 31.2009005, "line3"),
    Stations(MetroConstants.universityOfTheArabLeague, 30.050833, 31.199722,
        "line3"),
    Stations(MetroConstants.bolaqElDakror, 30.036111, 31.196389, "line3"),

  ];



}