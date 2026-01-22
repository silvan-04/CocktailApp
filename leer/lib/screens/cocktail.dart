import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

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
  String video = '';
  static List<Cocktail> cocktails = [];

  Cocktail(String name, String bild, String rezept, int alkoholgehalt, int schwierigkeit, List <Zutat> zutaten, List <String> zutatenMenge, String video){
    this.name = name;
    this.bild = bild;
    this.rezept = rezept;
    this.alkoholgehalt = alkoholgehalt;
    this.schwierigkeit = schwierigkeit;
    this.zutaten = zutaten;
    this.zutatenMenge = zutatenMenge;
    this.video = video;
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

    Zutat rum = Zutat('Rum', 'assets/bild/zutaten/Rum.jpg', 0, 40);
    Zutat wodka = Zutat('Wodka', 'assets/bild/zutaten/Wodka.jpg', 0, 40);
    Zutat gin = Zutat('Gin', 'assets/bild/zutaten/Gin.jpg', 0, 43);
    Zutat tequila = Zutat('Tequila', 'assets/bild/zutaten/Tequila.jpg', 0, 38);
    Zutat wermut = Zutat('Wermut', 'assets/bild/zutaten/Wermut.jpg', 1, 17);
    Zutat campari = Zutat('Campari', 'assets/bild/zutaten/Campari.jpg', 1, 25);
    Zutat orangenlikoer = Zutat('Orangenlikör', 'assets/bild/zutaten/Orangenlikoer.jpg', 1, 38);
    Zutat pfirsichlikoer = Zutat('Pfirsichlikör', 'assets/bild/zutaten/Pfirsichlikoer.jpg', 1, 15);
    Zutat grenadine = Zutat('Grenadine', 'assets/bild/zutaten/Grenadine.jpg', 2, 0);
    Zutat orangensaft = Zutat('Orangensaft', 'assets/bild/zutaten/Orangensaft.jpg', 2, 0);
    Zutat cranberrysaft = Zutat('Cranberrysaft', 'assets/bild/zutaten/Cranberrysaft.jpg', 2, 0);
    Zutat zitronensaft = Zutat('Zitronensaft', 'assets/bild/zutaten/Zitronensaft.jpg', 2, 0);
    Zutat ananassaft = Zutat('Ananassaft', 'assets/bild/zutaten/Ananassaft.jpg', 2, 0);
    Zutat tomatensaft = Zutat('Tomatensaft', 'assets/bild/zutaten/Tomatensaft.jpg', 2, 0);
    Zutat cola = Zutat('Cola', 'assets/bild/zutaten/Cola.jpg', 3, 0);
    Zutat tonic = Zutat('Tonic Water', 'assets/bild/zutaten/Tonic_Water.jpg', 3, 0);
    Zutat rohrzucker = Zutat('Rohrzucker', 'assets/bild/zutaten/Rohrzucker.jpg', 4, 0);
    Zutat limette = Zutat('Limette', 'assets/bild/zutaten/Limetten.jpg', 4, 0);
    Zutat minze = Zutat('Minze', 'assets/bild/zutaten/Minze.jpg', 4, 0);
    Zutat worcester = Zutat('Worcestershiresauce', 'assets/bild/zutaten/Worcester.jpg', 4, 0);
    Zutat tabasco = Zutat('Tabasco', 'assets/bild/zutaten/Tabasco.jpg', 4, 0);
    Zutat sahne = Zutat('Sahne', 'assets/bild/zutaten/Sahne.jpg', 4, 0);
    Zutat kokosmilch = Zutat('Kokosmilch', 'assets/bild/zutaten/Kokosmilch.jpg', 4, 0);
    Zutat soda = Zutat('Soda', 'assets/bild/zutaten/Soda.jpg', 4, 0);

    List <Zutat> tequilaSunriseZutaten = [tequila, orangensaft, grenadine];
    List <String> tequilaSunriseMenge = ['3 cl', '9 cl', '1 cl'];
    Cocktail tequilaSunrise = Cocktail('Tequila Sunrise', 'assets/bild/Tequila_Sunrise.png', 'assets/rezept/tequilaSunrise.txt', 12, 2, tequilaSunriseZutaten, tequilaSunriseMenge, 'https://www.youtube.com/watch?v=_8gXKNqU9Mc');
    List <Zutat> cubaLibreZutaten = [rum, cola, limette];
    List <String> cubaLibreMenge = ['6 cl', 'n. B.', '1/2'];
    Cocktail cubaLibre = Cocktail('Cuba Libre', 'assets/bild/Cuba_Libre.png', 'assets/rezept/cubaLibre.txt', 8, 1, cubaLibreZutaten, cubaLibreMenge, 'https://www.youtube.com/watch?v=-IIGrxI5wIU&list=PLShbP7V_mr23bXsm2GyqB_iVgELNeZ2E9&index=14');
    List<Zutat> longIslandIceTeaZutaten = [tequila, wodka, gin, rum, orangenlikoer, zitronensaft, cola];
    List <String> longIslandIceTeaMenge = ['2 cl', '2 cl', '2 cl', '2 cl', '2 cl', '2 cl', 'n. B.'];
    Cocktail longIslandIceTea = Cocktail('Long Island Ice Tea', 'assets/bild/Long_Island_Icetea.png', 'assets/rezept/longIslandIceTea.txt', 17, 2, longIslandIceTeaZutaten, longIslandIceTeaMenge, 'https://www.youtube.com/watch?v=SofMF_nXfoQ');
    List<Zutat> mojitoZutaten = [rum, limette, rohrzucker, minze, soda];
    List <String> mojitoMenge = ['5 cl', '1', '1 EL', 'ca. 10 Blätter', 'ca. 6 cl'];
    Cocktail mojito = Cocktail('Mojito', 'assets/bild/Mojito.png', 'assets/rezept/mojito.txt', 12, 2, mojitoZutaten, mojitoMenge, 'https://www.youtube.com/watch?v=pdMBKucOAhA');
    List<Zutat> pinaColadaZutaten = [rum, ananassaft, sahne, kokosmilch];
    List <String> pinaColadaMenge = ['6 cl', '10 cl', '2 cl', '4 cl'];
    Cocktail pinaColada = Cocktail('Pina Colada', 'assets/bild/Pina_Colada.png', 'assets/rezept/pinaColada.txt', 10, 2, pinaColadaZutaten, pinaColadaMenge, 'https://www.youtube.com/watch?v=oWtKsI3eMGU');
    List<Zutat> sexOnTheBeachZutaten = [wodka, pfirsichlikoer, cranberrysaft, orangensaft, zitronensaft];
    List <String> sexOnTheBeachMenge = ['3 cl', '3 cl', '6 cl', '6 cl'];
    Cocktail sexOnTheBeach = Cocktail('Sex On The Beach', 'assets/bild/Sex_on_the_Beach.png', 'rezept', 13, 1, sexOnTheBeachZutaten, sexOnTheBeachMenge, 'https://www.youtube.com/watch?v=JoL4n1gDHss');
    List<Zutat> ginTonicZutaten = [gin, tonic];
    List <String> ginTonicMenge = ['4 cl', '20 cl'];
    Cocktail ginTonic = Cocktail('Gin Tonic', 'assets/bild/Gin_Tonic.png', 'rezept', 13, 1, ginTonicZutaten, ginTonicMenge, 'https://www.youtube.com/watch?v=joPbaVplsxI');
    List<Zutat> negroniZutaten = [gin, wermut, campari];
    List <String> negroniMenge = ['2 cl', '2 cl', '2 cl'];
    Cocktail negroni = Cocktail('Negroni', 'assets/bild/Negroni.png', 'rezept', 28, 3, negroniZutaten, negroniMenge, 'https://www.youtube.com/watch?v=8XqRkA0FRq4');
    List<Zutat> martiniZutaten = [gin, wermut];
    List <String> martiniMenge = ['5 cl', '1 cl'];
    Cocktail martini = Cocktail('Martini', 'assets/bild/Martini.png', 'rezept', 15, 2, martiniZutaten, martiniMenge, 'https://www.youtube.com/watch?v=C09Y4kTfXxs');
    List<Zutat> bloodyMaryZutaten = [wodka, tomatensaft, zitronensaft, worcester, tabasco];
    List <String> bloodyMaryMenge = ['4 cl', '10 cl', '2 cl', '4 Spritzer', '2 Spritzer'];
    Cocktail bloodyMary = Cocktail('Bloody Mary', 'assets/bild/Bloody_Mary.png', 'assets/rezept/bloodyMary.txt', 11, 1, bloodyMaryZutaten, bloodyMaryMenge, 'https://www.youtube.com/watch?v=TNE41-RPA0U');

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
