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

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.cocktail.name)),
      body: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),

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
                    child: SingleChildScrollView(
                      child: Text(
                        widget.cocktail.rezept,
                        style: const TextStyle(fontSize: 16),
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
