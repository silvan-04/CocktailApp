import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'start_seite.dart';

class Cocktails extends StatefulWidget {
  final List<Cocktail> cocktails;
  Cocktails(this.cocktails,{super.key});


  @override
  State<Cocktails> createState() => _Cocktails();
}
class _Cocktails extends State<Cocktails>{
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
    return Scaffold(
      body: Column(
          children: [
            // Text('Cocktails'),
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
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: 20),
                children: [
                  for (var c in widget.cocktails)
                    CocktailButton(c),
                ],
              )
            )
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child:
            //     Wrap(
            //       spacing:16,
            //       runSpacing: 16,
            //
            //       children: [
            //
            //         for (var c in widget.cocktails)
            //           CocktailButton(c),
            //         CocktailButton(Cocktail("Mojito","du dsdfdsfdsfsdfdslfkslödafksdf"
            //             ,1,3,[Zutat("Grenadine",3,0),Zutat("Cola",4,0)],
            //             "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small")),
            //         CocktailButton(Cocktail("Mojito","du dsdfdsfdsfsdfdslfkslödafksdf"
            //             ,2,3,[Zutat("Grenadine",3,0),Zutat("Cola",4,0)],
            //             "https://www.thecocktaildb.com/images/media/drink/vrwquq1478252802.jpg/small")),
            //       ],
            //     ),
            // )

          ]
      ),
      floatingActionButton:
      Padding(
        padding: const EdgeInsetsGeometry.only(top: 10),
        child:IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.blue,),
          iconSize: 40,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Start()),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}


class CocktailButton extends StatefulWidget{
  final Cocktail cocktail;
  final double ecken;


  const CocktailButton(this.cocktail, {super.key,this.ecken = 20});
  @override
  State<CocktailButton> createState() => _CocktailButtonState();

}

class _CocktailButtonState extends State<CocktailButton> {

  @override
  Widget build(BuildContext context) {
    return Container (
      margin: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      height: 200,
      constraints: const BoxConstraints(maxWidth: 400),
      child:
      InkWell(
        onTap: () {
          // hier link zu Rezeptseite
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
              color: Colors.transparent,
              width: 4,
            ),
          ),
          padding: EdgeInsets.all(widget.ecken),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Column( children: [ClipRRect( borderRadius: BorderRadius.circular(widget.ecken),child: Image.network(widget.cocktail.bild,width: 150,height: 150, cacheWidth: 200,fit: BoxFit.contain)),
              ]),
              SizedBox(width:30),
              Column(
                children: [
                  SizedBox(height: 50, width: 140,child: AutoSizeText(widget.cocktail.name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),maxLines: 1,textAlign: TextAlign.center,softWrap: true,),
                  ),
                  SizedBox(width: 140, child: Text("Schwierigkeit:",textAlign: TextAlign.start,),)
                  ,
                  SizedBox(
                      width: 140,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for(int i=0; i < widget.cocktail.schwierigkeit;i++)
                            if(i<5)
                              const Icon(Icons.star, color: Colors.amber),
                          for(int i=5; i>widget.cocktail.schwierigkeit;i--)
                            const Icon(Icons.star,color: Colors.black,)
                        ],
                      )
                  ),
                  SizedBox(width: 140, child: Text("Stärke: ${widget.cocktail.alkoholgehalt} %",textAlign: TextAlign.start,),),
                  if(widget.cocktail.fehlendeZutaten!=0)
                    SizedBox(width: 140, child: Text("Fehlend: ${widget.cocktail.fehlendeZutaten} ",textAlign: TextAlign.start,),)

                ],)
              // Text(,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), maxLines: 1,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}
