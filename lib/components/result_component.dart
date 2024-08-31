import 'package:flutter/material.dart';

import '../models/candidat.dart';

class ResultComponent extends StatelessWidget {
  const ResultComponent(
      {super.key,
      required this.title,
      required this.candidats,
      required this.electors});
  final String title;
  final List<Candidat> candidats;
  final int electors;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        constraints: BoxConstraints(
          minHeight: 64,
          // maxHeight: candidats.isEmpty ? 100 : 220,
          minWidth: double.infinity,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    const Text("Candidats"),
                    Text("${candidats.length}")
                  ],
                ),
                const SizedBox(
                  width: 24,
                ),
                Column(
                  children: [const Text("Electeurs"), Text("$electors")],
                )
              ],
            ),
            Divider(),
            candidats.isEmpty
                ? Container()
                : Column(
                    children: candidats.map((c) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(c.number),
                            Text(
                              c.name,
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text("${c.vote}/$electors"),
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                    color: Colors.orange.shade100,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                    "${((c.vote * 100) / electors).toStringAsFixed(1)} %"))
                          ],
                        ),
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
