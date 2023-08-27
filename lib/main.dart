import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() {
  runApp(const PictureStoryApp());
}

class PictureStoryApp extends StatelessWidget {
  const PictureStoryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StoryLibraryScreen(),
    );
  }
}

class StoryLibraryScreen extends StatelessWidget {
  const StoryLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add New Story'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Title'),
                  Text('Image'),
                  Text('Content'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Story Library'),
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Image.asset(
                    storyList[index].coverImage,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 16.0),
                  Text(
                    storyList[index].title,
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showMyDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ignore: must_be_immutable
class StoryViewerScreen extends StatefulWidget {
  StoryViewerScreen({super.key, required this.story});
  final Story story;

  FlutterTts flutterTts = FlutterTts();

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreen();
}

class _StoryViewerScreen extends State<StoryViewerScreen> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.story.coverImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.story.content,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implement interactive elements or read-aloud functionality
                if (playing) {
                  await widget.flutterTts.pause();
                } else {
                  await widget.flutterTts.speak(widget.story.content);
                }
                setState(() {
                  playing = !playing;
                });
              },
              child: Text(playing ? 'Pause' : 'Read Aloud'),
            ),
          ],
        ),
      ),
    );
  }
}

class Story {
  final String title;
  final String coverImage;
  final String content;

  Story({required this.title, required this.coverImage, required this.content});
}

// Dummy data
List<Story> storyList = [
  Story(
    title: 'The Magical Adventures of Sparkle and Shine',
    coverImage: 'assets/sparkle_and_shine.jpg',
    content:
        "In the heart of the Enchanted Forest, two inseparable friends, Sparkle the mischievous fairy and Shine the curious elf, embarked on their magical adventures. One sunny morning, they discovered an old map that led to the Hidden Glitter Grotto. "
        "With excitement in their hearts, they followed the map's trail through shimmering meadows and enchanted waterfalls. Along the way, they met talking animals and helped them with kind gestures, earning them magical tokens of friendship. "
        "At last, they reached the Hidden Glitter Grotto, a cavern aglow with sparkling gems. But a tricky riddle guarded the grotto's greatest treasure. With their combined wit, they solved the riddle, revealing a dazzling crystal that granted wishes. "
        "Sparkle wished for harmony in the Enchanted Forest, while Shine wished for all creatures to have endless curiosity. Suddenly, the forest burst with colors and melodies, and every being felt a surge of wonder. "
        "Their adventure had not only brought them treasures but also brought the forest to life. Sparkle and Shine's friendship and the magic they shared turned the ordinary into the extraordinary, proving that kindness and imagination could make the world sparkle and shine in the most enchanting ways.",
  ),
  Story(
    title: "The Curious Case of Clara's Secret Garden",
    coverImage: 'assets/secret_garden.jpg',
    content:
        "In the bustling heart of the city, lived Clara, a girl with an unyielding curiosity. Behind her house lay a mysterious iron gate, concealing Clara's secret haven. One day, her inquisitive nature led her to find an old, dusty key that happened"
        "to fit the lock. As the gate creaked open, she entered a breathtaking world of vibrant flowers and magical creatures. Clara spent her days exploring the hidden corners, befriending talking birds and mischievous fairies. Yet, the garden was fading,"
        "and a gentle gnome revealed that its magic was waning. Determined, Clara embarked on a quest, gathering rare seeds and bringing back the garden's luster. As the first flower bloomed anew, the garden regained its enchantment, surprising Clara with a"
        "colorful spectacle. News of Clara's secret garden spread, attracting people from all around, turning the once-bustling city into a community that celebrated nature's wonders. Clara's curiosity had not only saved her secret garden but also transformed"
        "her world into a place of awe and inspiration for everyone to share.",
  ),
  Story(
    title: 'The Enchanted Forest Friends',
    coverImage: 'assets/forest_friends.png',
    content:
        "In the heart of the Enchanted Forest, a group of unlikely animal friends formed an unbreakable bond. There was Oliver the wise owl, Ella the graceful deer, Benny the playful squirrel, and Luna the adventurous fox. Each possessed a unique gift bestowed"
        "upon them by the forest's ancient magic. One day, a deep shadow began to creep over the forest, draining it of its life. The friends embarked on a daring journey to find the source of the darkness and save their home. Guided by their strengths, they"
        "overcame treacherous obstacles, discovering that the dark magic was fueled by negativity and fear. With unity and determination, they used their gifts to create a radiant barrier of positivity, dispelling the darkness and restoring the forest's vitality. "
        "Their triumph showcased the power of friendship and the magic that lay within them. As the forest bloomed anew, their legend spread far and wide, reminding all that a united heart can conquer even the darkest of shadows, and that true friendship is a force as enchanting as the forest itself.",
  ),
  // Add more stories here
];
