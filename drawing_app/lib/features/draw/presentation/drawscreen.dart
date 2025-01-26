import 'package:drawing_app/features/draw/models/stroke.dart';
import 'package:flutter/material.dart';

class Drawscreen extends StatefulWidget {
  const Drawscreen({super.key});

  @override
  State<Drawscreen> createState() => _DrawscreenState();
}

class _DrawscreenState extends State<Drawscreen> {
  List<Stroke> _strokes = [];
  List<Stroke> _redostrokes = [];
  List<Offset> _currentPoints = [];
  Color _selectedColor = Colors.red;
  double _brushSize = 8.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Draw Your Dream'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onPanStart: (details) {
                // print("Pan Start: ${details.localPosition}"); // Debugging
                setState(() {
                  _currentPoints = [details.localPosition];
                });
              },
              onPanUpdate: (details) {
                // print("Pan Update: ${details.localPosition}"); // Debugging
                setState(() {
                  _currentPoints.add(details.localPosition);
                });
              },
              onPanEnd: (details) {
                // print("Pan End");
                setState(() {
                  _strokes.add(Stroke(
                    points: List.from(_currentPoints),
                    color: _selectedColor,
                    brushSize: _brushSize,
                  ));
                  _currentPoints = [];
                  _redostrokes = [];
                });
              },
              child: SizedBox.expand(
                child: CustomPaint(
                  painter: DrawPainter(
                      strokes: _strokes,
                      currentPoints: _currentPoints,
                      currentColor: _selectedColor,
                      currentBrushSize: _brushSize),
                ),
              ),
            ),
          ),
          _buildToolBar(),
        ],
      ),
    );
  }

  Widget _buildToolBar() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Colors.grey[200],
      child: Row(
        children: [
          // Undo Button
          IconButton(
              onPressed: _strokes.isNotEmpty
                  ? () {
                      setState(() {
                        _redostrokes.add(_strokes.removeLast());
                      });
                    }
                  : null,
              icon: const Icon(Icons.undo)),
          // Redo Button
          IconButton(
              onPressed: _redostrokes.isNotEmpty
                  ? () {
                      setState(() {
                        _strokes.add(_redostrokes.removeLast());
                      });
                    }
                  : null,
              icon: const Icon(Icons.redo)),
        ],
      ),
    );
  }
}

class DrawPainter extends CustomPainter {
  final List<Stroke> strokes;
  final List<Offset> currentPoints;
  final Color currentColor;
  final double currentBrushSize;

  DrawPainter(
      {super.repaint,
      required this.strokes,
      required this.currentPoints,
      required this.currentColor,
      required this.currentBrushSize});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Draw completed strokes
    for (final stroke in strokes) {
      paint
        ..color = stroke.color
        ..strokeWidth = stroke.brushSize;
      for (int i = 0; i < stroke.points.length - 1; i++) {
        if (stroke.points[i] != Offset.zero &&
            stroke.points[i + 1] != Offset.zero) {
          canvas.drawLine(stroke.points[i], stroke.points[i + 1], paint);
        }
      }
    }
    // Draw the current stroke
    paint
      ..color = currentColor
      ..strokeWidth = currentBrushSize;
    for (int i = 0; i < currentPoints.length - 1; i++) {
      if (currentPoints[i] != Offset.zero &&
          currentPoints[i + 1] != Offset.zero) {
        canvas.drawLine(currentPoints[i], currentPoints[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
