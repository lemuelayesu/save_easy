import 'package:flutter/material.dart';

class SavingSection extends StatefulWidget {
  const SavingSection({
    super.key,
    required this.itemLable,
    required this.priceLable,
    required this.progressValue,
    required this.progressColor,
  });

  final Color progressColor;
  final String itemLable;
  final String priceLable;
  final double progressValue;

  @override
  State<SavingSection> createState() => _SavingSectionState();
}

class _SavingSectionState extends State<SavingSection> {
  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Container(
      width: 156,
      height: 91,
      padding: const EdgeInsetsDirectional.all(10),
      decoration: BoxDecoration(
        color: color.surface,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.itemLable,
                style: TextStyle(
                  color: color.tertiary,
                  fontSize: 13,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.priceLable,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          LinearProgressIndicator(
            value: widget.progressValue,
            backgroundColor: color.surfaceDim,
            minHeight: 8,
            color: widget.progressColor,
            borderRadius: BorderRadius.circular(10),
          ),
        ],
      ),
    );
  }
}
