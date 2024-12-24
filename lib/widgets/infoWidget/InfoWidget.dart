import 'package:flutter/material.dart';
import 'InfoWidgetController.dart';
import '../../util/YOColors.dart';

class InfoCardWidget extends StatefulWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final Color borderColor;

  const InfoCardWidget({
    Key? key,
    required this.title,
    required this.description,
    this.icon = Icons.info_outline,
    this.backgroundColor = const Color(0xFFEFF8FE),
    this.borderColor = const Color(0xFF007AFF),
  }) : super(key: key);

  @override
  State<InfoCardWidget> createState() => _InfoCardWidgetState();
}

class _InfoCardWidgetState extends State<InfoCardWidget>
    with SingleTickerProviderStateMixin {
  final InfoCardController _controller = InfoCardController();
  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _sizeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    if (_controller.isExpanded.value) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }

    _controller.isExpanded.addListener(() {
      if (_controller.isExpanded.value) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        border: Border.all(color: widget.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                color: widget.borderColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  widget.title,
                  style: styleBlack14Bold,
                ),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _controller.isExpanded,
                builder: (context, isExpanded, child) {
                  return GestureDetector(
                    onTap: _controller.toggle,
                    child: Icon(
                      isExpanded ? Icons.expand_less : Icons.expand_more,
                      color: widget.borderColor,
                      size: 24,
                    ),
                  );
                },
              ),
            ],
          ),
          SizeTransition(
            sizeFactor: _sizeAnimation,
            axisAlignment: -1.0,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                widget.description,
                style: styleBlack12Regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}