import 'package:flutter/material.dart';
import 'pages/book_detail_page.dart';

void main() {
  runApp(const EBookApp());
}

class EBookApp extends StatelessWidget {
  const EBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-Book Reader',
      theme: ThemeData(
        primaryColor: const Color(0xFF1E88E5),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E88E5),
          primary: const Color(0xFF1E88E5),
          secondary: const Color(0xFF64B5F6),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F9FF),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF1E88E5), width: 2),
          ),
        ),
      ),
      home: const ProfileSetupPage(),
    );
  }
}

class ProfileSetupPage extends StatefulWidget {
  const ProfileSetupPage({super.key});

  @override
  State<ProfileSetupPage> createState() => _ProfileSetupPageState();
}

class _ProfileSetupPageState extends State<ProfileSetupPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _schoolController = TextEditingController();
  String _selectedGrade = '1';

  final List<String> _grades = List.generate(11, (index) => '${index + 1}');

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            username: _usernameController.text,
            school: _schoolController.text,
            grade: _selectedGrade,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
              Theme.of(context).scaffoldBackgroundColor,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Welcome to Kelbet Til!',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(0, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Let\'s set up your profile',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person_outline),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: _schoolController,
                          decoration: const InputDecoration(
                            labelText: 'School',
                            prefixIcon: Icon(Icons.school_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your school';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedGrade,
                          decoration: const InputDecoration(
                            labelText: 'Grade',
                            prefixIcon: Icon(Icons.grade_outlined),
                          ),
                          items: _grades.map((grade) {
                            return DropdownMenuItem(
                              value: grade,
                              child: Text('Grade $grade'),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGrade = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final String username;
  final String school;
  final String grade;

  const HomeScreen({
    super.key,
    required this.username,
    required this.school,
    required this.grade,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedGrade = 'All';
  String _selectedLanguage = 'All';
  String _selectedTerm = 'All';
  bool _isFilterVisible = false;
  int _currentIndex = 1; // Start with main library page

  final List<String> _grades = [
    'All',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11'
  ];
  final List<String> _languages = ['All', 'Russian', 'Kazakh'];
  final List<String> _terms = ['All', '1', '2', '3', '4'];

  void _handleSearch(String value) {
    setState(() {
      // Implement search functionality
    });
  }

  Widget _buildBookCard(int index, {bool isSaved = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                'Book ${index + 1}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSaved
                      ? 'Saved Book ${index + 1}'
                      : 'Book Title ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Author ${index + 1}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                if (!isSaved) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.${index + 1}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 2
              ? 'Profile'
              : _currentIndex == 1
                  ? 'Hello, ${widget.username}!'
                  : 'Saved Books',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: _currentIndex == 1
            ? [
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    setState(() {
                      _isFilterVisible = !_isFilterVisible;
                    });
                  },
                ),
              ]
            : null,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          // Saved Books Page
          SavedBooksPage(),

          // Main Library Page (existing content)
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Search Bar
                      TextField(
                        controller: _searchController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Search books...',
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.7)),
                          prefixIcon:
                              const Icon(Icons.search, color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                        ),
                        onChanged: _handleSearch,
                      ),

                      // Filters
                      if (_isFilterVisible) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              // Grade Filter
                              DropdownButtonFormField<String>(
                                value: _selectedGrade,
                                decoration: const InputDecoration(
                                  labelText: 'Grade',
                                  prefixIcon: Icon(Icons.grade),
                                ),
                                items: _grades.map((grade) {
                                  return DropdownMenuItem(
                                    value: grade,
                                    child: Text(grade == 'All'
                                        ? 'All Grades'
                                        : 'Grade $grade'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedGrade = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Language Filter
                              DropdownButtonFormField<String>(
                                value: _selectedLanguage,
                                decoration: const InputDecoration(
                                  labelText: 'Language',
                                  prefixIcon: Icon(Icons.language),
                                ),
                                items: _languages.map((language) {
                                  return DropdownMenuItem(
                                    value: language,
                                    child: Text(language),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedLanguage = value!;
                                  });
                                },
                              ),
                              const SizedBox(height: 16),

                              // Term Filter
                              DropdownButtonFormField<String>(
                                value: _selectedTerm,
                                decoration: const InputDecoration(
                                  labelText: 'Term',
                                  prefixIcon: Icon(Icons.calendar_today),
                                ),
                                items: _terms.map((term) {
                                  return DropdownMenuItem(
                                    value: term,
                                    child: Text(term == 'All'
                                        ? 'All Terms'
                                        : 'Term $term'),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _selectedTerm = value!;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],

                      // Continue Reading Section
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Continue Reading',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  5,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BookDetailPage(
                                            title: 'Book Title ${index + 1}',
                                            author: 'Author ${index + 1}',
                                            grade: widget.grade,
                                            term: '${index % 4 + 1}',
                                            language: index % 2 == 0
                                                ? 'Russian'
                                                : 'Kazakh',
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 16),
                                      width: 120,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 180,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  blurRadius: 10,
                                                  offset: const Offset(0, 5),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Book ${index + 1}',
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Book Title ${index + 1}',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Popular Books',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailPage(
                              title: 'Book Title ${index + 1}',
                              author: 'Author ${index + 1}',
                              grade: _selectedGrade == 'All'
                                  ? '${index % 11 + 1}'
                                  : _selectedGrade,
                              term: _selectedTerm == 'All'
                                  ? '${index % 4 + 1}'
                                  : _selectedTerm,
                              language: _selectedLanguage == 'All'
                                  ? (index % 2 == 0 ? 'Russian' : 'Kazakh')
                                  : _selectedLanguage,
                            ),
                          ),
                        );
                      },
                      child: _buildBookCard(index),
                    );
                  },
                ),
              ],
            ),
          ),

          // Profile Page
          ProfilePage(
            username: widget.username,
            school: widget.school,
            grade: widget.grade,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: BottomNavigationBar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                elevation: 0,
                backgroundColor: Colors.transparent,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: Colors.grey[400],
                selectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 0
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.bookmark,
                        size: _currentIndex == 0 ? 28 : 24,
                      ),
                    ),
                    label: 'Saved',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 1
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.library_books,
                        size: _currentIndex == 1 ? 28 : 24,
                      ),
                    ),
                    label: 'Library',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: _currentIndex == 2
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.person,
                        size: _currentIndex == 2 ? 28 : 24,
                      ),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class SavedBooksPage extends StatefulWidget {
  const SavedBooksPage({super.key});

  @override
  State<SavedBooksPage> createState() => _SavedBooksPageState();
}

class _SavedBooksPageState extends State<SavedBooksPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Saved Books',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) =>
                _buildBookCard(index, isSaved: true),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(int index, {bool isSaved = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Theme.of(context).primaryColor.withOpacity(0.1),
            ),
            child: Center(
              child: Text(
                'Book ${index + 1}',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isSaved
                      ? 'Saved Book ${index + 1}'
                      : 'Book Title ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Author ${index + 1}',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
                if (!isSaved) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '4.${index + 1}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String username;
  final String school;
  final String grade;

  const ProfilePage({
    super.key,
    required this.username,
    required this.school,
    required this.grade,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late String _username;
  late String _school;
  late String _grade;

  @override
  void initState() {
    super.initState();
    _username = widget.username;
    _school = widget.school;
    _grade = widget.grade;
  }

  void _showEditDialog(BuildContext context) {
    final TextEditingController usernameController =
        TextEditingController(text: _username);
    final TextEditingController schoolController =
        TextEditingController(text: _school);
    String selectedGrade = _grade;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: schoolController,
                maxLength: 30,
                decoration: const InputDecoration(
                  labelText: 'School',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGrade,
                decoration: const InputDecoration(
                  labelText: 'Grade',
                  prefixIcon: Icon(Icons.grade_outlined),
                ),
                items: List.generate(11, (index) {
                  final grade = (index + 1).toString();
                  return DropdownMenuItem(
                    value: grade,
                    child: Text('Grade $grade'),
                  );
                }),
                onChanged: (value) {
                  selectedGrade = value!;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _username = usernameController.text;
                _school = schoolController.text;
                _grade = selectedGrade;
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully!'),
                  duration: Duration(seconds: 2),
                  backgroundColor: Color(0xFF1E88E5),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFF1E88E5),
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                  onPressed: () => _showEditDialog(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildProfileItem(Icons.person_outline, 'Username', _username),
                const Divider(),
                _buildProfileItem(Icons.school_outlined, 'School', _school),
                const Divider(),
                _buildProfileItem(
                    Icons.grade_outlined, 'Grade', 'Grade $_grade'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E88E5)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
