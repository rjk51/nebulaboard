import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ImageResultsScreen extends StatefulWidget {
  final int imageCount;
  final String prompt;
  
  const ImageResultsScreen({
    super.key, 
    required this.imageCount,
    required this.prompt,
  });

  @override
  State<ImageResultsScreen> createState() => _ImageResultsScreenState();
}

class _ImageResultsScreenState extends State<ImageResultsScreen> {
  bool _isLoading = true;
  List<String> _images = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _generateImages();
  }

  Future<void> _generateImages() async {
    try {
      final response = await http.post(
        Uri.parse('https://nebulaboard.onrender.com/generateImage'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'text': widget.prompt,
          'images': widget.imageCount,
        }),
      );

      if (response.statusCode == 200) {
        // Inside the _generateImages method, just after getting the response
        print('API Response: ${response.body}');    
        final data = jsonDecode(response.body);
        setState(() {
          _isLoading = false;
          
          // Extract base64 images from the response
          if (data['images'] != null && data['images'] is List) {
            _images = [];
            for (var img in data['images']) {
              // Parse the image string as JSON to get to the b64_json field
              final imgData = jsonDecode(img);
              if (imgData['data'] != null && imgData['data'] is List && imgData['data'].isNotEmpty) {
                _images.add(imgData['data'][0]['b64_json']);
              }
            }
          }
        });
      } else {
        setState(() {
          _isLoading = false;
          _error = 'Failed to generate images: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error = 'Error: $e';
      });
      print('Exception details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Storyboard')),
      body: _isLoading 
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Generating ${widget.imageCount} AI-powered storyboard frames...',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const CircularProgressIndicator(),
                ],
              ),
            )
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      _error!,
                      style: TextStyle(color: Colors.red[800]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : _images.isEmpty
                  ? const Center(child: Text('No images were generated.'))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Story Visualization',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: GridView.builder(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: _images.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 4,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.memory(
                                      base64Decode(_images[index]),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
    );
  }
}
