import 'package:flutter/material.dart';

class ListContainer extends StatelessWidget {
  const ListContainer({
    super.key,
    required this.bodyText,
    this.secondaryText,
    required this.rightSide,
    this.onTap,
  });
  final String bodyText;
  final String? secondaryText;
  final Widget rightSide;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          highlightColor: Colors.black12,
          splashColor: Colors.black12,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          bodyText,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        if (secondaryText != null)
                          Text(
                            secondaryText!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.hintColor.withOpacity(0.5),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                rightSide
              ],
            ),
          ),
        ),
      ),
    );
  }
}
