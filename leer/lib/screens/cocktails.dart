import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'cocktail.dart';
import 'start_seite.dart';
import 'rezept_seite.dart';

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
    final q = query.trim().toLowerCase();
    final filtered = widget.cocktails.where((c) =>
    q.isEmpty || c.name.toLowerCase().contains(q)).toList();

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        // SafeArea verhindert, dass die Leiste oben in die Statusbar rutscht
        top: true,
        bottom: false,
        left: false,
        right: false,
        child: Column(
            children: [
              Padding(
                padding:  EdgeInsets.fromLTRB(screenWidth*0.05,screenHeight*0.01,screenWidth*0.05,0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.blue),
                      iconSize: screenHeight *0.05,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),

                    SizedBox(width: screenWidth * 0.01), // Kleiner Abstand zwischen Button und Suche

                    // 2. Das TextField muss in ein Expanded, um den restlichen Platz zu füllen
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Cocktail suchen…',
                          prefixIcon: const Icon(Icons.search),
                          suffixIcon: query.isEmpty
                              ? null
                              : IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                              setState(() => query = '');
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (value) => setState(() => query = value),
                      ),
                    ),
                  ],
                ),
              ),
              /// Abstand nach unten
              SizedBox(height: screenHeight*0.005),
              Expanded(
                child: ListView(
                  children: [
                    for (var c in filtered)
                      CocktailButton(c),
                  ],
                )
              )
            ]
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => rezept_seite(widget.cocktail),
              ),
          );
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
