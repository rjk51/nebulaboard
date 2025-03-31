import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nebulaboard/result.dart';
import 'package:nebulaboard/theme/theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _storyController = TextEditingController();
  bool _isInputFocused = false;
  int _imageCount = 3; // Default value

  @override
  void dispose() {
    _storyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nebula Board',
          style: TextStyle(
            fontFamily: GoogleFonts.chelseaMarket().fontFamily,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Animated GIF Placeholder
            Center(
              child: Image.asset(
                'assets/home.gif',
                width: 325,
              ),
            ),
            const SizedBox(height: 40),

            // Header Text
            Text(
              'Tell Your Story',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Describe your script or story below, and we\'ll turn it into a storyboard.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            // Animated Text Field (POI)
            Focus(
              onFocusChange: (hasFocus) {
                setState(() => _isInputFocused = hasFocus);
              },
              child: AnimatedContainer(
                duration: 500.ms,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: _isInputFocused
                      ? [
                          BoxShadow(
                            color: NebulaBoardTheme.primaryColor.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: TextField(
                  controller: _storyController,
                  maxLines: 7,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Once upon a time in a futuristic city...',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    filled: true,
                    fillColor: NebulaBoardTheme.surfaceColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: NebulaBoardTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            // Bottom Control Panel
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  // Generate Button (Expanded to fill available space)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_storyController.text.trim().isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ImageResultsScreen(
                                imageCount: _imageCount,
                                prompt: _storyController.text.trim(),
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please enter a story first!'),
                            ),
                          );
                        }
                      },
                      style: NebulaBoardTheme.primaryButtonStyle.copyWith(
                        minimumSize: WidgetStateProperty.all(
                          const Size(double.infinity, 50),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Generate Storyboard', style: TextStyle(fontSize: 16)),
                          SizedBox(width: 8),
                          Icon(Icons.auto_awesome, size: 20),
                        ],
                      ),
                    ).animate().fadeIn().slideY(
                          begin: 0.5,
                          end: 0,
                          curve: Curves.easeOutCubic,
                        ),
                  ),
                  
                  const SizedBox(width: 12),
                  
                  // Image Count Dropdown
                  Container(
                    decoration: BoxDecoration(
                      color: NebulaBoardTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: DropdownButton<int>(
                      value: _imageCount,
                      dropdownColor: NebulaBoardTheme.surfaceColor,
                      style: const TextStyle(color: Colors.white),
                      underline: const SizedBox(), // Remove default underline
                      icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                      items: List.generate(10, (i) => i + 1)
                          .map((count) => DropdownMenuItem(
                                value: count,
                                child: Text('$count'),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() => _imageCount = value!);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
