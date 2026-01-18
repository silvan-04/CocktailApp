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
                          hintText: 'Zutat suchen…',
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
                    for (var c in widget.cocktails)
                      CocktailButton(c),
                  ],
                )
              )
            ]
        ),
      ),
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container (
      margin: EdgeInsets.symmetric(vertical: screenHeight*0.015,horizontal: screenWidth*0.05),
      height: screenHeight*0.225,
      constraints: BoxConstraints(maxWidth: screenWidth*0.8),
      child:
      InkWell(
        // onTap: () => Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (_) =>  // hier neue Rezeptseite,
        //   ),)
        // ,
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
              color: Colors.transparent,
              width: ((screenHeight+screenWidth)/2) * 0.005,
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: screenHeight*0.032,horizontal: screenWidth*0.05),
          child:
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget> [
              Column( children: [ClipRRect( borderRadius: BorderRadius.circular(screenHeight*0.02),child: Image.network(widget.cocktail.bild,width: screenWidth *0.35> screenHeight*0.15 ? screenHeight*0.15 :screenWidth *0.35,height:screenWidth *0.35> screenHeight*0.15 ? screenHeight*0.15 :screenWidth *0.35, cacheWidth: (screenWidth *0.35>screenHeight*0.15? screenHeight*0.15 :screenWidth *0.35).toInt(),fit: BoxFit.contain)),
              ]),
              SizedBox(width:screenWidth*0.07225),
              Column(
                children: [
                  SizedBox(height: screenHeight*0.05, width: screenWidth*0.3,child: AutoSizeText(widget.cocktail.name,style: TextStyle(fontSize: screenHeight*0.03,fontWeight: FontWeight.bold),maxLines: 2,textAlign: TextAlign.center,softWrap: true,),
                  ),
                  SizedBox(width: screenWidth*0.3,height: screenHeight*0.025 ,child: AutoSizeText("Schwierigkeit:" ,textAlign: TextAlign.start,maxLines: 1),)
                  ,
                  SizedBox(
                      width: screenWidth*0.3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          for(int i=0; i < widget.cocktail.schwierigkeit;i++)
                            if(i<5)
                              Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.05,),
                          for(int i=5; i>widget.cocktail.schwierigkeit;i--)
                            Icon(Icons.star,color: Colors.black,size: screenWidth * 0.05,)
                        ],
                      )
                  ),
                  SizedBox(width: screenWidth*0.3, height: screenHeight*0.025,child: AutoSizeText("Stärke: ${widget.cocktail.alkoholgehalt} %",textAlign: TextAlign.start,maxLines:1),),
                  if(widget.cocktail.fehlendeZutaten!=0)
                    SizedBox(width: screenWidth*0.3,height: screenHeight*0.025, child: AutoSizeText("Fehlend: ${widget.cocktail.fehlendeZutaten} ",textAlign: TextAlign.start,maxLines:1,),)

                ],)
              // Text(,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold), maxLines: 1,overflow: TextOverflow.ellipsis,),
            ],
          ),
        ),
      ),
    );
  }
}
