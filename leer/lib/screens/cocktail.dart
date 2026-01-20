import 'dart:math';
import 'package:flutter/material.dart';

void main(){
}



class Cocktail{
  String name = '';
  String bild = '';
  String rezept = '';
  int alkoholgehalt = 0;
  int schwierigkeit = 0;
  List <Zutat> zutaten = [];
  List <String> zutatenMenge = [];
  int fehlendeZutaten = 0;
  static List<Cocktail> cocktails = [];

  Cocktail(String name, String bild, String rezept, int alkoholgehalt, int schwierigkeit, List <Zutat> zutaten, List <String> zutatenMenge){
    this.name = name;
    this.bild = bild;
    this.rezept = rezept;
    this.alkoholgehalt = alkoholgehalt;
    this.schwierigkeit = schwierigkeit;
    this.zutaten = zutaten;
    this.zutatenMenge = zutatenMenge;
    fehlendeZutaten = zutaten.length;
    Cocktail.cocktails.add(this);
  }

  List<String> getZutaten(){
    List<String> zutatenListe = [];
    for(var i=0;i< this.zutaten.length;i++){
      zutatenListe.add(this.zutaten[i].name);
    }
    return zutatenListe;
  }

  //Counter mit Wert = Anzahl der Zutaten des Cocktails
  //Jede Zutat des Cocktails wird überprüft, ob in zutaten. => wenn ja dann Counter =- 1

  static List<Cocktail> getRezepte(Set<int> zutatenid){
    List<Zutat>zutaten = Zutat.idToZutat(zutatenid);
    // print(zutaten);
    List<Cocktail> zutatenSortedList = [];
    for (var i = 0; i < Cocktail.cocktails.length; i++) {
      Cocktail.cocktails[i].fehlendeZutaten =
          Cocktail.cocktails[i].zutaten.length;
      zutatenSortedList.add(Cocktail.cocktails[i]);
      for (var k = 0; k < Cocktail.cocktails[i].zutaten.length; k++) {
        if (zutaten.contains(Cocktail.cocktails[i].zutaten[k])) {
          Cocktail.cocktails[i].fehlendeZutaten = Cocktail.cocktails[i].fehlendeZutaten-1;
        }
      }
    }
    zutatenSortedList.sort((a, b) =>
        a.fehlendeZutaten.compareTo(b.fehlendeZutaten));
    for(Cocktail c in zutatenSortedList){
      // print(c.name);
    }
    return zutatenSortedList;
  }
  static void initialize(){

    String platzhalterBild = "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small";
    Zutat rum = Zutat('Rum', platzhalterBild, 0, 40);
    Zutat wodka = Zutat('Wodka', platzhalterBild, 0, 40);
    Zutat gin = Zutat('Gin', platzhalterBild, 0, 43);
    Zutat tequila = Zutat('Tequila', platzhalterBild, 0, 38);
    Zutat wermut = Zutat('Wermut', platzhalterBild, 1, 17);
    Zutat campari = Zutat('Campari', platzhalterBild, 1, 25);
    Zutat orangenlikoer = Zutat('Orangenlikör', platzhalterBild, 1, 38);
    Zutat pfirsichlikoer = Zutat('Pfirsichlikör', platzhalterBild, 1, 15);
    Zutat grenadine = Zutat('Grenadine', platzhalterBild, 2, 0);
    Zutat orangensaft = Zutat('Orangensaft', platzhalterBild, 2, 0);
    Zutat cranberrysaft = Zutat('Cranberrysaft', platzhalterBild, 2, 0);
    Zutat zitronensaft = Zutat('Zitronensaft', platzhalterBild, 2, 0);
    Zutat ananassaft = Zutat('Ananassaft', platzhalterBild, 2, 0);
    Zutat tomatensaft = Zutat('Tomatensaft', platzhalterBild, 2, 0);
    Zutat cola = Zutat('Cola', platzhalterBild, 3, 0);
    Zutat tonic = Zutat('Tonic Water', platzhalterBild, 3, 0);
    Zutat rohrzucker = Zutat('Rohrzucker',platzhalterBild, 4, 0);
    Zutat limette = Zutat('Limette', platzhalterBild, 4, 0);
    Zutat minze = Zutat('Minze', platzhalterBild, 4, 0);
    Zutat worcester = Zutat('Worcestershiresauce', platzhalterBild, 4, 0);
    Zutat tabasco = Zutat('Tabasco', platzhalterBild, 4, 0);
    Zutat sahne = Zutat('Sahne', platzhalterBild, 4, 0);
    Zutat kokosmilch = Zutat('Kokosmilch',platzhalterBild, 4, 0);
    Zutat soda = Zutat('Soda', platzhalterBild, 4, 0);

    List <Zutat> tequilaSunriseZutaten = [tequila, orangensaft, zitronensaft, grenadine];
    List <String> tequilaSunriseMenge = ['5 cl', '12 cl', '1 cl', '1 cl'];
    Cocktail tequilaSunrise = Cocktail('Tequila Sunrise', platzhalterBild, 'rezept', 12, 2, tequilaSunriseZutaten, tequilaSunriseMenge);
    List <Zutat> cubaLibreZutaten = [rum, cola, limette];
    List <String> cubaLibreMenge = ['5 cl', '12 cl', '1'];
    Cocktail cubaLibre = Cocktail('Cuba Libre', platzhalterBild, 'rezept', 8, 1, cubaLibreZutaten, cubaLibreMenge);
    List<Zutat> longIslandIceTeaZutaten = [tequila, wodka, gin, rum, orangenlikoer, zitronensaft, cola];
    List <String> longIslandIceTeaMenge = ['1,5 cl', '1,5 cl', '1,5 cl', '1,5 cl', '1,5 cl', '2 cl', '14 cl'];
    Cocktail longIslandIceTea = Cocktail('Long Island Ice Tea', platzhalterBild, 'rezept', 17, 2, longIslandIceTeaZutaten, longIslandIceTeaMenge);
    List<Zutat> mojitoZutaten = [rum, limette, rohrzucker, minze, soda];
    List <String> mojitoMenge = ['6 cl', '1/2', '1 EL', '1 Zweig', '30 cl'];
    Cocktail mojito = Cocktail('Mojito', platzhalterBild, 'rezept', 12, 1, mojitoZutaten, mojitoMenge);
    List<Zutat> pinaColadaZutaten = [rum, ananassaft, sahne, kokosmilch];
    List <String> pinaColadaMenge = ['6 cl', '10 cl', '2 cl', '4 cl'];
    Cocktail pinaColada = Cocktail('Pina Colada', platzhalterBild, 'rezept', 10, 2, pinaColadaZutaten, pinaColadaMenge);
    List<Zutat> sexOnTheBeachZutaten = [wodka, pfirsichlikoer, cranberrysaft, ananassaft];
    List <String> sexOnTheBeachMenge = ['3 cl', '3 cl', '6 cl', '6 cl'];
    Cocktail sexOnTheBeach = Cocktail('Sex On The Beach', platzhalterBild, 'rezept', 13, 1, sexOnTheBeachZutaten, sexOnTheBeachMenge);
    List<Zutat> ginTonicZutaten = [gin, tonic];
    List <String> ginTonicMenge = ['4 cl', '20 cl'];
    Cocktail ginTonic = Cocktail('Gin Tonic', platzhalterBild, 'rezept', 13, 1, ginTonicZutaten, ginTonicMenge);
    List<Zutat> negroniZutaten = [gin, wermut, campari];
    List <String> negroniMenge = ['2 cl', '2 cl', '2 cl'];
    Cocktail negroni = Cocktail('Negroni', platzhalterBild, 'rezept', 28, 3, negroniZutaten, negroniMenge);
    List<Zutat> martiniZutaten = [gin, wermut];
    List <String> martiniMenge = ['5 cl', '1 cl'];
    Cocktail martini = Cocktail('Martini', platzhalterBild, 'rezept', 15, 2, martiniZutaten, martiniMenge);
    List<Zutat> bloodyMaryZutaten = [wodka, tomatensaft, zitronensaft, worcester, tabasco];
    List <String> bloodyMaryMenge = ['4 cl', '10 cl', '2 cl', '4 Spritzer', '2 Spritzer'];
    Cocktail bloodyMary = Cocktail('Bloody Mary', platzhalterBild, 'Dieser Cocktail wird geschüttelt und nicht gerührt. Für einen Bloody Mary einfach alle Zutaten im Shaker mit einigen Eiswürfeln kräftig mixen. In ein Longdrinkglas gießen (die zum Mixen verwendeten Eiswürfel bleiben im Shaker).', 11, 1, bloodyMaryZutaten, bloodyMaryMenge);

  }
}

class Zutat{
  String name = '';
  String bild = '';
  int kategorie = 0;
  int alkoholgehalt = 0;
  final int id;
  static var zutaten = Map<int, Zutat>();
  static int anzahl = 0;

  Zutat(String name, String bild, int kategorie, int alkoholgehalt)
  :id = Zutat.anzahl{
    this.name = name;
    this.bild = bild;
    this.kategorie = kategorie;
    this.alkoholgehalt = alkoholgehalt;
    Zutat.zutaten[anzahl++] = this;

  }

  static List <Zutat> idToZutat(Set<int> ids){
    List<Zutat> zutaten = [];
    for (var id in ids){
      // print(Zutat.zutaten[id]);
      zutaten.add(Zutat.zutaten[id]!);
      // print(Zutat.zutaten[id]);
    }
    return zutaten;
  }
}
