import 'package:flutter/material.dart';
import 'package:light_quiz/features/quiz/data/models/result.dart';
import 'package:light_quiz/features/quiz/ui/views/widgets/result_card.dart';

class QuizResultsDisplay extends StatefulWidget {
  final List<Result> resultsList;
  const QuizResultsDisplay({super.key, required this.resultsList});

  @override
  State<QuizResultsDisplay> createState() => _QuizResultsDisplayState();
}

class _QuizResultsDisplayState extends State<QuizResultsDisplay> {
  int currentPage = 0;
  final int itemsPerPage = 6;

  @override
  Widget build(BuildContext context) {
    final results = widget.resultsList;
    int totalPages = (results.length / itemsPerPage).ceil();
    int startIndex = currentPage * itemsPerPage;
    int endIndex = (startIndex + itemsPerPage).clamp(0, results.length);
    List<Result> currentItems = results.sublist(startIndex, endIndex);

    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          color: Theme.of(context).textTheme.bodyMedium!.color,
          width: double.infinity,
          child: Text(
            "Your Results",
            style: TextStyle(
              fontSize: 19,
              color: Theme.of(context).textTheme.bodySmall!.color,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            itemCount: currentItems.length,
            itemBuilder: (context, index) {
              final result = currentItems[index];
              final isPassed = result.grade >= result.possiblePoints / 2;
              return ResultCard(isPassed: isPassed, result: result);
            },
          ),
        ),

        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: currentPage > 0 ? Colors.blue : Colors.grey,
              onPressed:
                  currentPage > 0
                      ? () {
                        setState(() {
                          currentPage--;
                        });
                      }
                      : null,
            ),

            ...List.generate(totalPages, (index) {
              final isCurrent = index == currentPage;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCurrent ? Colors.blue : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue),
                    ),
                    child: Text(
                      "${index + 1}",
                      style: TextStyle(
                        color: isCurrent ? Colors.white : Colors.blue,
                        fontWeight:
                            isCurrent ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              );
            }),

            IconButton(
              icon: Icon(Icons.arrow_forward),
              color: currentPage < totalPages - 1 ? Colors.blue : Colors.grey,
              onPressed:
                  currentPage < totalPages - 1
                      ? () {
                        setState(() {
                          currentPage++;
                        });
                      }
                      : null,
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
