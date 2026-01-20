import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'cocktail.dart';


class rezept_seite extends StatefulWidget {
  final Cocktail cocktail;

  const rezept_seite(this.cocktail, {super.key});

  @override
  State<rezept_seite> createState() => _rezept_seiteState();
}

class _rezept_seiteState extends State<rezept_seite> {
  late YoutubePlayerController _controller;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    )..addListener(_listener);
  }

  void _listener(){
    if (_controller.value.isFullScreen != isFullScreen){
      setState((){
        isFullScreen = _controller.value.isFullScreen;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
        ? null
      : AppBar(title: Text(widget.cocktail.name, style: TextStyle(fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
      body: isFullScreen
          ? MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      )
          : Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          if (!isFullScreen)
          Expanded(
            child: Row(
              children: [
                /// Zutaten
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.grey.shade200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Zutaten',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: ListView.builder(
                            itemCount: widget.cocktail.zutaten.length,
                            itemBuilder: (context, index) {
                              return Text('• ${widget.cocktail.zutatenMenge[index]} ${widget.cocktail.zutaten[index].name}');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// Rezept Beschreibung
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.topLeft,
                    child: SingleChildScrollView(
                      child: Text(
                        widget.cocktail.rezept,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
    );
  }
}
