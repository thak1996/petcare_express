import 'package:flutter/material.dart';

class StepIndicatorWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;
  final List<IconData> icons;
  final Function(int) onStepTapped;

  const StepIndicatorWidget({
    super.key,
    required this.currentStep,
    required this.totalSteps,
    required this.icons,
    required this.onStepTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < totalSteps; i++) ...[
            Material(
              color: Colors.transparent,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () => onStepTapped(i),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color:
                        i <= currentStep
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icons[i],
                      color: i <= currentStep ? Colors.white : Colors.grey[600],
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
            if (i < totalSteps - 1)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Container(
                    height: 2,
                    color:
                        i < currentStep
                            ? Theme.of(context).primaryColor
                            : Colors.grey[300],
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }
}
