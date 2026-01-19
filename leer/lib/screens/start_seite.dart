
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../screens/cocktails.dart';
import 'cocktail.dart';

class Start extends StatefulWidget {
  const Start({super.key});

  @override
  State<Start> createState() => _StartState();
}
final List<Zutat> drinks = [];
/// Der "State" ist der Teil, der Daten hält, die sich ändern können (z.B. query)
class _StartState extends State<Start> {
  /// Scrollen/Automatisch
  final ScrollController _scrollController = ScrollController();
  late final Map<int, GlobalKey> _katKeys;
  _StartState();


  @override
  void initState() {
    super.initState();
    _katKeys = { for (final k in kategorien) k.id: GlobalKey()};
    if(Zutat.anzahl == 0){
      Cocktail.initialize();
      for(final z in Zutat.zutaten.values){
        drinks.add(z);
      };
    }

  }

  /// Selektierte Getränke
  final Set<int> selectedDrinksIds = {};

  /// Controller für das TextField:
  /// für auslesen / Inhalt löchen
  final TextEditingController _controller = TextEditingController();

  /// Suchtext speichern
  String query = '';

  @override
  void dispose() {
    _scrollController.dispose();
    /// Wichtig: Controller wieder freigeben
    _controller.dispose();
    super.dispose();
  }

  /// Für Kategorien Überschriften
  final Map<int, String> katTitel = {
    for (final k in kategorien) k.id: k.title,
  };



  /// Für Kategorie-Überschrift + Scrollen
  Widget kategorieMitUeberschrift(double screenHeight,double screenWidth,int katId) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        key: _katKeys[katId],
        padding:EdgeInsets.only(top: screenHeight*0.005),
        child: Text(
          katTitel[katId] ?? 'Kategorie $katId',
          style:TextStyle(fontSize: screenWidth*0.07, fontWeight: FontWeight.bold),
        ),
      ),
      kategorie(context,katId, query),
      SizedBox(height: screenHeight * 0.01),
    ],
  );

  @override
  Widget build(BuildContext context) {
    /// AppBar
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      /// später vlt. Logo oder so... jz Platzhalter
      /// appBar: AppBar(title: const Text('Cocktail-App') ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(screenWidth*0.0225,screenHeight*0.03, screenWidth*0.0225,0),

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
            SizedBox(height: screenHeight*0.015),


            SizedBox(
              height: screenHeight*0.05,
              child:
              /// Kategoiren-Leiste
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final k in kategorien) ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03, vertical: screenHeight*0.01),
                          minimumSize: Size(screenWidth*0.15,screenHeight*0.03),
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          final ziel = _katKeys[k.id]?.currentContext;
                          if (ziel != null) {
                            Scrollable.ensureVisible(
                              ziel,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                              alignment: 0,
                            );
                          }
                        },
                        child: Text(
                          k.title,
                          style: TextStyle(
                            fontSize: screenWidth*0.04,
                            color: Colors.white,

                          ),),
                      ),
                      SizedBox(width: screenWidth*0.02),
                    ],
                  ],
                ),
              ),
            ),
            SizedBox(height:screenHeight*0.005),



            /// Expanded: nimmt den restlichen Platz ein -> NUR dieser Bereich scrollt
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  for ( int i = 0; i<kategorien.length;i++)
                    kategorieMitUeberschrift(screenHeight,screenWidth,i)
                ],
              ),
            ),
          ],
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth*0.02),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: screenHeight*0.02, offset: Offset(0, screenHeight*0.01))
          ],
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding:EdgeInsets.symmetric(horizontal: screenWidth*0.1, vertical: screenHeight*0.02),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth*0.03)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) =>  Cocktails(Cocktail.getRezepte(PanelButton.zutatenIds))),
          ),
          child: Text(
            'Cocktails',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
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




class Kategorie {
  final int id;
  final String title;
  const Kategorie(this.id, this.title);
}
final kategorien = <Kategorie>[
  Kategorie(0, 'Spirituosen'),
  Kategorie(1, 'Liköre'),
  Kategorie(2, 'Säfte'),
  Kategorie(3, 'Softdrinks'),
  Kategorie(4, 'Sonstiges'),
];



/// Baut ein Grid (ohne daten)
Widget kategorie(BuildContext context,int catId, String query) {
  final q = query.trim().toLowerCase();
  double screenWidth = MediaQuery.of(context).size.width;
  double screenHeight = MediaQuery.of(context).size.height;
  final list = drinks.where((d) =>
  d.kategorie == catId &&
      (q.isEmpty || d.name.toLowerCase().contains(q))

  ).toList();


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
    itemBuilder: (_, i) => PanelButton(
        list[i].name,
        list[i].id,
        Image.network(
            "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small",
            width: screenWidth*0.2225,
            height: screenWidth*0.2225,
            cacheWidth: (screenWidth*0.2225).toInt(),
            fit: BoxFit.contain
        )
    ),
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
  late bool selected;

  @override
  void initState() {
    super.initState();
    // Prüfe beim Starten des Widgets, ob die ID bereits in der Liste ist
    selected = PanelButton.zutatenIds.contains(widget.id);
  }

  // Diese Methode hilft, wenn sich die Liste von außen ändert (z.B. durch Reset)
  @override
  void didUpdateWidget(covariant PanelButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      selected = PanelButton.zutatenIds.contains(widget.id);
    });
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    selected = PanelButton.zutatenIds.contains(widget.id);
    return Container (
      margin: EdgeInsets.symmetric(vertical: screenHeight*0.02,horizontal: screenWidth*0.04),
      height: screenHeight*0.2,
      child:
      InkWell(
        onTap: () {
          setState(() {
            // selected = PanelButton.zutatenIds.contains(widget.id);
            selected = !selected;
            if(selected){
              PanelButton.zutatenIds.add(widget.id);
            }else{
              PanelButton.zutatenIds.remove(widget.id);
            }
            print(PanelButton.zutatenIds);
            ///hier zutat in die selected liste einfügen widget.name
          });
        },
        borderRadius: BorderRadius.circular(screenHeight*0.02),
        child:
        Container(
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.circular(screenHeight*0.02),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: screenHeight*0.01,
                offset: Offset(0,screenHeight*0.005),
              )
            ],
            border: Border.all(
              color: selected ? Colors.blue : Colors.transparent,
              width: ((screenHeight+screenWidth)/2) * 0.005,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: screenHeight*0.025,horizontal: screenWidth*0.025),
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              AutoSizeText(widget.name,style: TextStyle(fontSize: screenWidth*0.05,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,softWrap: true,),
              SizedBox(height:screenHeight*0.02),
              ClipRRect( borderRadius: BorderRadius.circular(screenHeight*0.02),child: widget.image,),
            ],
          ),
        ),
      ),
    );
  }

}
