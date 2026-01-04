import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../screens/cocktails.dart';
import 'cocktail.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}

/// Der "State" ist der Teil, der Daten hält, die sich ändern können (z.B. query)
class _StartState extends State<Start> {
  /// Selektierte Getränke
   Set<int> selectedDrinksIds = {};
  
  /// Controller für das TextField:
  /// für auslesen / Inhalt löchen
  final TextEditingController _controller = TextEditingController();

  /// Suchtext speichern
  String query = '';

  @override
  void dispose() {
    /// Wichtig: Controller wieder freigeben
    _controller.dispose();
    super.dispose();
  }

@override
Widget build(BuildContext context) {
  /// AppBar
  return Scaffold(
    /// später vlt. Logo oder so... jz Platzhalter
    /// appBar: AppBar(title: const Text('Cocktail-App') ),

    body: Padding(
      padding: const EdgeInsets.all(12),

      /// Column: oben fixe Suchleiste, darunter scrollbarer Inhalt
      child: Column(
        children: [
          /// TextField = Eingabefeld (hier: Suchleiste) -> bleibt oben stehen (scrollt NICHT mit)
          TextField(
            /// Verbindet das TextField mit Controller
            controller: _controller,

            /// decoration = Aussehen/Icons/Border/Hinweistext der Suchleiste
            decoration: InputDecoration(
              /// grauer Hinweistext, wenn noch nichts eingegeben wurde
              hintText: 'Zutat suchen…',

              /// Icon in Suchleiste
              prefixIcon: const Icon(Icons.search),

              /// Icon rechts (X), aber nur wenn query nicht leer ist
              suffixIcon: query.isEmpty
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.clear),

                      /// Beim Klick: Textfeld leeren + query zurücksetzen
                      onPressed: () {
                        _controller.clear();
                        setState(() => query = '');
                      },
                    ),

              /// Rahmen um das Textfeld
              border: const OutlineInputBorder(),
            ),

            /// speichern den neuen Text in query + direkt neu laden
            onChanged: (value) => setState(() => query = value),
          ),

          /// Abstand nach unten
          const SizedBox(height: 12),

          /// Expanded: nimmt den restlichen Platz ein -> NUR dieser Bereich scrollt
          Expanded(
            child: ListView(
              /// Padding unten, damit der schwebende Button nichts verdeckt
              padding: const EdgeInsets.only(bottom: 110),
              children: [
                Text(
                  'Bierchen',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                kategorie(0),

                const SizedBox(height: 12),

                Text(
                  'nicht Bierchen',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                kategorie(1),
              ],
            ),
          ),
        ],
      ),
    ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 12, offset: Offset(0, 6))
        ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          // onPressed: (){
          //
          // print(Cocktail.rezepte(selectedDrinksIds));
          // print(selectedDrinksIds);},
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => Cocktails(Cocktail.rezepte(PanelButton.zutatenIds))),
          ),
          child: const Text(
            'Cocktails',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }



}
class Drink {
  final int id, categoryId;
  final String title;
  final IconData icon;
  const Drink(this.id, this.categoryId, this.title, this.icon);
}

// Beispiel-Daten nur für jze
final drinks = <Drink>[

  Drink(101, 0, 'Pils', Icons.sports_bar),
  Drink(102, 0, 'Weizen', Icons.sports_bar),
  Drink(201, 1, 'Cola', Icons.water_drop),
  Drink(202, 1, 'Wasser', Icons.water_drop),
  Drink(103, 0, 'Pils', Icons.sports_bar),
  Drink(104, 0, 'Weizen', Icons.sports_bar),
  Drink(205, 1, 'Cola', Icons.water_drop),
  Drink(206, 1, 'Wasser', Icons.water_drop),
  Drink(107, 0, 'Pils', Icons.sports_bar),
  Drink(108, 0, 'Weizen', Icons.sports_bar),
  Drink(209, 1, 'Cola', Icons.water_drop),
  Drink(210, 1, 'Wasser', Icons.water_drop),
  Drink(111, 0, 'Pils', Icons.sports_bar),
  Drink(112, 0, 'Weizen', Icons.sports_bar),
  Drink(213, 1, 'Cola', Icons.water_drop),
  Drink(214, 1, 'Wasser', Icons.water_drop),
];







/// Baut ein Grid (ohne daten)
Widget kategorie(int catId) {
  final list = drinks.where((d) => d.categoryId == catId).toList();

  return GridView.builder(
    shrinkWrap: true, // wichtig: Grid passt sich in der ListView der Höhe an
    physics: const NeverScrollableScrollPhysics(), // nur die äußere ListView scrollt
    itemCount: list.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 0,
      mainAxisSpacing: 0,
      childAspectRatio: 0.85,
    ),
    itemBuilder: (_, i) => PanelButton(list[i].title,list[i].id,Image.network("https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small",width: 90,height: 90, cacheWidth: 200,fit: BoxFit.contain)),
    // itemBuilder: (_, i) => Card(
    //   child: Padding(
    //     padding: const EdgeInsets.all(12),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Icon(list[i].icon, size: 34),
    //         const SizedBox(height: 8),
    //         Text(list[i].title, textAlign: TextAlign.center),
    //       ],
    //     ),
    //   ),
    // ),
  );
}


class PanelButton extends StatefulWidget{
  final String name;
  final double ecken;
  final Image image;
  final int id;
  static final Set<int> zutatenIds = {};


  PanelButton(this.name,this.id,this.image ,{super.key,this.ecken = 20});
  @override
  State<PanelButton> createState() => _PanelButtonState();

}

class _PanelButtonState extends State<PanelButton> {
  bool selected = false;

  Widget build(BuildContext context) {
    
    return Container (
        margin: EdgeInsets.all(20),
        height: 400,
        child:
        InkWell(
          onTap: () {
            setState(() {
              selected = !selected;
              if(selected){
                PanelButton.zutatenIds.add(widget.id);
              }else{
                PanelButton.zutatenIds.remove(widget.id);
              }
              print(PanelButton.zutatenIds);
              


              ///hier zutat in die selected liste einfügen widget.name 
              print(selected);
            });
          },
          borderRadius: BorderRadius.circular(widget.ecken),
          child:
            Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(widget.ecken),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0,4),
                    )
                  ],
                  border: Border.all(
                    color: selected ? Colors.black38 : Colors.transparent,
                    width: 4,
                  ),
                ),
                padding: EdgeInsets.all(widget.ecken),
                child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget> [
                      AutoSizeText(widget.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,softWrap: true,),
                      // Text(,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), maxLines: 1,overflow: TextOverflow.ellipsis,),
                      SizedBox(height:8),
                      ClipRRect( borderRadius: BorderRadius.circular(widget.ecken),child: widget.image,),
                    ],
                  ),
            ),
        ),
    );
  }

}