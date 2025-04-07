import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:bharatflow/components/chart_container.dart';
import 'package:bharatflow/components/settings_card.dart';

enum MapViewType {
  default_map,
  satellite,
  heatmap,
}

class TrafficMap extends StatefulWidget {
  final bool isInteractive;
  final Function(int, int)? onZoneTap;
  final Function(MapViewType)? onViewTypeChanged;

  const TrafficMap({
    super.key,
    this.isInteractive = false,
    this.onZoneTap,
    this.onViewTypeChanged,
  });

  @override
  State<TrafficMap> createState() => _TrafficMapState();
}

class _TrafficMapState extends State<TrafficMap> {
  MapViewType _currentView = MapViewType.default_map;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        height: 400,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Traffic Map',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                if (widget.isInteractive)
                  ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Apply Manual Override'),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Manual override applied successfully'),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3243f5),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Stack(
                children: [
                  // Map container
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(_getMapBackground()),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: _currentView == MapViewType.heatmap
                        ? _buildHeatmapOverlay()
                        : const SizedBox.expand(),
                  ),

                  // Map type selector at bottom
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildMapTypeButton(
                              'Default',
                              Icons.map_outlined,
                              MapViewType.default_map,
                            ),
                            _buildMapTypeButton(
                              'Satellite',
                              Icons.satellite_alt,
                              MapViewType.satellite,
                            ),
                            _buildMapTypeButton(
                              'Heatmap',
                              Icons.local_fire_department,
                              MapViewType.heatmap,
                            ),
                          ],
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
    );
  }

  Widget _buildMapTypeButton(String label, IconData icon, MapViewType type) {
    final isSelected = _currentView == type;

    return InkWell(
      onTap: () {
        setState(() {
          _currentView = type;
        });
        widget.onViewTypeChanged?.call(type);
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF3243f5) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : Colors.black54,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.white : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getMapBackground() {
    switch (_currentView) {
      case MapViewType.default_map:
        return 'assets/default_map.png';
      case MapViewType.satellite:
        return 'assets/satellite_map.png';
      case MapViewType.heatmap:
        return 'assets/default_map.png'; // Base map for heatmap
    }
  }

  Widget _buildHeatmapOverlay() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: 36,
      itemBuilder: (context, index) {
        final row = index ~/ 6;
        final col = index % 6;

        // Generate random congestion levels for demo
        final congestionLevel = (index % 5) / 4;

        return GestureDetector(
          onTap: widget.isInteractive
              ? () => widget.onZoneTap?.call(row, col)
              : null,
          child: Container(
            decoration: BoxDecoration(
              color: _getCongestionColor(congestionLevel).withOpacity(0.6),
              borderRadius: BorderRadius.circular(4),
            ),
            child: widget.isInteractive
                ? Icon(
              Icons.add_circle_outline,
              color: Colors.white.withOpacity(0.7),
              size: 20,
            )
                : null,
          ),
        );
      },
    );
  }

  Color _getCongestionColor(double level) {
    if (level < 0.3) {
      return Colors.green;
    } else if (level < 0.7) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}

// Mock asset class to avoid actual asset loading in this example
// class AssetImage extends ImageProvider<AssetImage> {
//   final String assetName;
//
//   const AssetImage(this.assetName);
//
//   @override
//   Future<AssetImage> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<AssetImage>(this);
//   }
//
//   @override
//   ImageStreamCompleter load(AssetImage key, DecoderCallback decode) {
//     // You can throw or return an empty stream for mocking
//     return OneFrameImageStreamCompleter(
//       Future<ImageInfo>.value(
//         ImageInfo(image: _createDummyImage(), scale: 1.0),
//       ),
//     );
//   }
//
//   // Create a dummy image to avoid crashes
//   Image _createDummyImage() {
//     final recorder = PictureRecorder();
//     final canvas = Canvas(recorder);
//     canvas.drawRect(Rect.fromLTWH(0, 0, 10, 10), Paint()..color = Colors.grey);
//     final picture = recorder.endRecording();
//     return picture.toImageSync(10, 10);
//   }
// }
