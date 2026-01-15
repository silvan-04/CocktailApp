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
  Widget kategorieMitUeberschrift(int katId) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        key: _katKeys[katId],
        padding: const EdgeInsets.only(top: 6),
        child: Text(
          katTitel[katId] ?? 'Kategorie $katId',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      kategorie(katId, query),
      const SizedBox(height: 12),
    ],
  );

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
            const SizedBox(height: 10),


            SizedBox(
              height: 55,
              child:
            /// Kategoiren-Leiste
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final k in kategorien) ...[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          minimumSize: const Size(10, 32),
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
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
  
                          ),),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            ),



            /// Expanded: nimmt den restlichen Platz ein -> NUR dieser Bereich scrollt
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  for ( int i = 0; i<kategorien.length;i++)
                    kategorieMitUeberschrift(i)
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
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) =>  Cocktails(Cocktail.getRezepte(PanelButton.zutatenIds))),
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
Widget kategorie(int catId, String query) {
  final q = query.trim().toLowerCase();
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
            width: 90,
            height: 90,
            cacheWidth: 90,
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
              SizedBox(height:8),
              ClipRRect( borderRadius: BorderRadius.circular(widget.ecken),child: widget.image,),
            ],
          ),
        ),
      ),
    );
  }

}