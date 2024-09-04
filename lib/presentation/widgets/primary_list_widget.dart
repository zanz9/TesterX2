import 'package:flutter/material.dart';

class PrimaryListWidget extends StatelessWidget {
  const PrimaryListWidget({
    super.key,
    required this.text,
    this.rightWidget = const Icon(
      Icons.chevron_right_rounded,
      color: Colors.black,
      size: 36,
    ),
    this.secondaryText,
    this.disabled = false,
  });
  final String text;
  final String? secondaryText;
  final Widget rightWidget;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: disabled ? SystemMouseCursors.noDrop : SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.white),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        height: secondaryText == null ? 54 : 72,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            secondaryText == null
                ? Flexible(
                    child: Text(
                      text,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      softWrap: false,
                      style: const TextStyle(fontSize: 18),
                    ),
                  )
                : Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          text,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style: TextStyle(
                            fontSize: 18,
                            color: disabled ? Colors.grey : Colors.black,
                          ),
                        ),
                        Text(
                          secondaryText!,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                          softWrap: false,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
            rightWidget,
          ],
        ),
      ),
    );
  }
}
