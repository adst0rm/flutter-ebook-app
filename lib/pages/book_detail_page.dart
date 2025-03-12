import 'package:flutter/material.dart';
import 'package:test_1_app/pages/reading_page.dart';

class BookDetailPage extends StatelessWidget {
  final String title;
  final String author;
  final String grade;
  final String term;
  final String language;

  const BookDetailPage({
    super.key,
    required this.title,
    required this.author,
    required this.grade,
    required this.term,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                pinned: true,
                backgroundColor: Theme.of(context).primaryColor,
                actions: [
                  IconButton(
                    icon:
                        const Icon(Icons.bookmark_border, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                  title: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: Offset(0, 2),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'By $author',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 85),
                          child: Hero(
                            tag: 'book-$title',
                            child: Container(
                              width: 150,
                              height: 200,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.book,
                                  size: 50,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 80),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.1),
                                  Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.05),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildInfoItem(context, Icons.grade_outlined,
                                    'Grade', grade),
                                _buildDivider(),
                                _buildInfoItem(context, Icons.calendar_today,
                                    'Term', term),
                                _buildDivider(),
                                _buildInfoItem(context, Icons.language,
                                    'Language', language),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Description',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'This is a sample description for $title. Add your actual book description here.',
                            style: TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReadingPage(
                              title: title,
                              content:
                                  '''"Metamorphosis" by Franz Kafka is a novella written during the late 19th century. The book explores themes of alienation and identity through the strange and tragic transformation of its main character, Gregor Samsa, who wakes up one morning to find himself turned into a grotesque insect. The story grapples with Gregor's struggle to adapt to his new physical form and its implications for his family, shedding light on societal expectations and familial responsibilities. The opening of "Metamorphosis" presents an unsettling scene as Gregor Samsa discovers his shocking metamorphosis. Initially confused and in discomfort, he reflects on his life as a travelling salesman and the burdens of his job, all while grappling with the absurdity of his situation. As he struggles to get out of bed, the concern of his family begins to stir. His mother knocks on his door, anxious about his tardiness for work, and this prompts a cascade of worry for Gregor about how his family will react to his transformation. Despite his efforts to communicate and reassure them, the fear and misunderstanding stemming from his condition quickly become apparent. This launch into the bizarre and tragic sets the tone for the exploration of alienation and familial dynamics that unfolds throughout the novella. (This is an automatically generated summary.)''',
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.book, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Read',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.2),
                          Theme.of(context).primaryColor.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.chat_outlined),
                      onPressed: () {},
                      tooltip: 'Chat with AI about this book',
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
      BuildContext context, IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: Theme.of(context).primaryColor,
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey.withOpacity(0.3),
    );
  }
}
