import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';

void main(){
  initialize();
}

void initialize(){

  Zutat rum = Zutat('Rum', 0, 40);
  Zutat wodka = Zutat('Wodka', 0, 40);
  Zutat gin = Zutat('Gin', 0, 43);
  Zutat tequila = Zutat('Tequila', 0, 38);
  Zutat wermut = Zutat('Wermut', 1, 17);
  Zutat campari = Zutat('Campari', 1, 25);
  Zutat orangenlikoer = Zutat('Orangenlikör', 1, 38);
  Zutat pfirsichlikoer = Zutat('Pfirsichlikör', 1, 15);
  Zutat grenadine = Zutat('Grenadine', 2, 0);
  Zutat orangensaft = Zutat('Orangensaft', 2, 0);
  Zutat cranberrysaft = Zutat('Cranberrysaft', 2, 0);
  Zutat zitronensaft = Zutat('Zitronensaft', 2, 0);
  Zutat ananassaft = Zutat('Ananassaft', 2, 0);
  Zutat tomatensaft = Zutat('Tomatensaft', 2, 0);
  Zutat cola = Zutat('Cola', 3, 0);
  Zutat tonic = Zutat('Tonic Water', 3, 0);
  Zutat rohrzucker = Zutat('Rohrzucker', 4, 0);
  Zutat zuckersirup = Zutat('Zuckersirup', 4, 0);
  Zutat limette = Zutat('Limette', 4, 0);
  Zutat minze = Zutat('Minze', 4, 0);
  Zutat worcester = Zutat('Worcestershiresauce', 4, 0);
  Zutat tabasco = Zutat('Tabasco', 4, 0);
  Zutat sahne = Zutat('Sahne', 4, 0);
  Zutat kokosmilch = Zutat('Kokosmilch', 4, 0);
  Zutat soda = Zutat('Soda', 4, 0);

  // List <Zutat> tequilaSunriseZutaten = [tequila, orangensaft, zitronensaft, grenadine];
  // Cocktail tequilaSunrise = Cocktail('Tequila Sunrise', 12, 2, tequilaSunriseZutaten);
  // Cocktail.cocktails.add(tequilaSunrise);
  // List <Zutat> cubaLibreZutaten = [rum, cola, limette, rohrzucker];
  // Cocktail cubaLibre = Cocktail('Cuba Libre', 8, 1, cubaLibreZutaten);
  // Cocktail.cocktails.add(cubaLibre);
  // List<Zutat> longIslandIceTeaZutaten = [tequila, wodka, gin, rum, orangenlikoer, zitronensaft, zuckersirup, cola];
  // Cocktail longIslandIceTea = Cocktail('Long Island Ice Tea', 17, 2, longIslandIceTeaZutaten);
  // Cocktail.cocktails.add(longIslandIceTea);
  // List<Zutat> mojitoZutaten = [rum, limette, zuckersirup, minze, soda];
  // Cocktail mojito = Cocktail('Mojito', 12, 1, mojitoZutaten);
  // Cocktail.cocktails.add(mojito);
  // List<Zutat> pinaColadaZutaten = [rum, ananassaft, sahne, kokosmilch];
  // Cocktail pinaColada = Cocktail('Pina Colada', 10, 2, pinaColadaZutaten);
  // Cocktail.cocktails.add(pinaColada);
  // List<Zutat> sexOnTheBeachZutaten = [wodka, pfirsichlikoer, cranberrysaft, ananassaft];
  // Cocktail sexOnTheBeach = Cocktail('Sex On The Beach', 13, 1, sexOnTheBeachZutaten);
  // Cocktail.cocktails.add(sexOnTheBeach);
  // List<Zutat> ginTonicZutaten = [gin, tonic];
  // Cocktail ginTonic = Cocktail('Gin Tonic', 13, 1, ginTonicZutaten);
  // Cocktail.cocktails.add(ginTonic);
  // List<Zutat> negroniZutaten = [gin, wermut, campari];
  // Cocktail negroni = Cocktail('Negroni', 28, 3, negroniZutaten);
  // Cocktail.cocktails.add(negroni);
  // List<Zutat> martiniZutaten = [gin, wermut];
  // Cocktail martini = Cocktail('Martini', 15, 2, martiniZutaten);
  // Cocktail.cocktails.add(martini);
  // List<Zutat> bloodyMaryZutaten = [wodka, tomatensaft, zitronensaft, worcester, tabasco];
  // Cocktail bloodyMary = Cocktail('Bloody Mary', 11, 1, bloodyMaryZutaten);
  // Cocktail.cocktails.add(bloodyMary);
  const String defaultBeschreibung = 'Keine Beschreibung vorhanden.';
  const String defaultImg =
      'https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small';

  List<Zutat> tequilaSunriseZutaten = [
    tequila, orangensaft, zitronensaft, grenadine
  ];
  Cocktail tequilaSunrise = Cocktail(
    'Tequila Sunrise',
    defaultBeschreibung,
    12,
    2,
    tequilaSunriseZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(tequilaSunrise);

  List<Zutat> cubaLibreZutaten = [rum, cola, limette, rohrzucker];
  Cocktail cubaLibre = Cocktail(
    'Cuba Libre',
    defaultBeschreibung,
    8,
    1,
    cubaLibreZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(cubaLibre);

  List<Zutat> longIslandIceTeaZutaten = [
    tequila, wodka, gin, rum, orangenlikoer,
    zitronensaft, zuckersirup, cola
  ];
  Cocktail longIslandIceTea = Cocktail(
    'Long Island Ice Tea',
    defaultBeschreibung,
    17,
    2,
    longIslandIceTeaZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(longIslandIceTea);

  List<Zutat> mojitoZutaten = [rum, limette, zuckersirup, minze, soda];
  Cocktail mojito = Cocktail(
    'Mojito',
    defaultBeschreibung,
    12,
    1,
    mojitoZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(mojito);

  List<Zutat> pinaColadaZutaten = [rum, ananassaft, sahne, kokosmilch];
  Cocktail pinaColada = Cocktail(
    'Pina Colada',
    defaultBeschreibung,
    10,
    2,
    pinaColadaZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(pinaColada);

  List<Zutat> sexOnTheBeachZutaten = [
    wodka, pfirsichlikoer, cranberrysaft, ananassaft
  ];
  Cocktail sexOnTheBeach = Cocktail(
    'Sex On The Beach',
    defaultBeschreibung,
    13,
    1,
    sexOnTheBeachZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(sexOnTheBeach);

  List<Zutat> ginTonicZutaten = [gin, tonic];
  Cocktail ginTonic = Cocktail(
    'Gin Tonic',
    defaultBeschreibung,
    13,
    1,
    ginTonicZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(ginTonic);

  List<Zutat> negroniZutaten = [gin, wermut, campari];
  Cocktail negroni = Cocktail(
    'Negroni',
    defaultBeschreibung,
    28,
    3,
    negroniZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(negroni);

  List<Zutat> martiniZutaten = [gin, wermut];
  Cocktail martini = Cocktail(
    'Martini',
    defaultBeschreibung,
    15,
    2,
    martiniZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(martini);

  List<Zutat> bloodyMaryZutaten = [
    wodka, tomatensaft, zitronensaft, worcester, tabasco
  ];
  Cocktail bloodyMary = Cocktail(
    'Bloody Mary',
    defaultBeschreibung,
    11,
    1,
    bloodyMaryZutaten,
    defaultImg,
  );
  Cocktail.cocktails.add(bloodyMary);



}

class Cocktail{
  String name = "";
  int alkoholgehalt = 0;
  int schwierigkeit = 0;
  List <Zutat> zutaten = [];
  int fehlendeZutaten = 0;
  String img = "";
  String beschreibung = "";
  static List<Cocktail> cocktails =[];

  Cocktail(this.name,this.beschreibung, this.alkoholgehalt, this.schwierigkeit, this.zutaten,this.img){
    // fehlendeZutaten = zutaten.length;
    fehlendeZutaten = 0;
  }

  //Counter mit Wert = Anzahl der Zutaten des Cocktails
//Jede Zutat des Cocktails wird überprüft, ob in zutaten. => wenn ja dann Counter =- 1

  static List<Cocktail> rezepte(Set<int> ids){
    initialize();
    print(ids);
    List<Cocktail> rezepte = [];
    List<Zutat> zutaten =  [];
    for (var id in ids) {
      zutaten.add(Zutat("senf",0,12));
    }
    print(zutaten);
    print("cocktail liste${Cocktail.cocktails}");


    for(var i=0;i< Cocktail.cocktails.length;i++){
      Cocktail.cocktails[i].fehlendeZutaten = Cocktail.cocktails[i].zutaten.length;
      rezepte.add(Cocktail.cocktails[i]);
      for(var k=0;k<Cocktail.cocktails[i].zutaten.length;k++){
        if(zutaten.contains(Cocktail.cocktails[i].zutaten[k])){
          Cocktail.cocktails[i].fehlendeZutaten =- 1;
        }
      }
    }
    rezepte.sort((a,b) => a.fehlendeZutaten.compareTo(b.fehlendeZutaten));
    print(rezepte);
    return rezepte;
  }
}

class Zutat{
  String name = "";
  int kategorie = 0;
  int alkoholgehalt = 0;

  Zutat(this.name, this.kategorie, this.alkoholgehalt);

}



