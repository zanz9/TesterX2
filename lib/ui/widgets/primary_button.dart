import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final Function() onTap;
  final bool isLoading;
  final Function()? onTapOutside;
  final Widget child;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final double? height;
  final bool outlined;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.isLoading,
    this.onTapOutside,
    required this.child,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.symmetric(vertical: 20),
    this.height,
    this.outlined = false,
    this.margin,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool isHovering = false;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    Color getColorFromOutlinedOrNo() {
      if (widget.outlined) {
        if (isHovering) return Colors.white;
        return theme.scaffoldBackgroundColor;
      } else {
        if (isHovering) return Colors.grey[850]!;
        return Colors.black;
      }
    }

    Color color = widget.isLoading ? Colors.grey : getColorFromOutlinedOrNo();

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) {
        setState(() {
          isHovering = true;
        });
      },
      onExit: (event) {
        setState(() {
          isHovering = false;
        });
      },
      child: TapRegion(
        onTapInside: (event) {
          widget.onTap();
        },
        onTapOutside: (event) {
          if (widget.onTapOutside != null) widget.onTapOutside!();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: widget.padding,
          margin: widget.margin,
          height: widget.height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: widget.outlined ? Colors.black : Colors.transparent,
            ),
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
