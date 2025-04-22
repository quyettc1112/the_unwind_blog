import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../domain/entities/blog_detail_entity.dart';

class TocBottomSheet extends StatelessWidget {
  final List<TableOfContents> tocList;
  final String? currentAnchorId;
  final void Function(String id) onAnchorTap;

  const TocBottomSheet({
    super.key,
    required this.tocList,
    required this.currentAnchorId,
    required this.onAnchorTap,
  });

  String _generateAnchorIdFromText(String text) {
    return text.toLowerCase().replaceAll(RegExp(r'[^\w]+'), '-');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Mục lục",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              itemCount: tocList.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, index) {
                final toc = tocList[index];
                final id = _generateAnchorIdFromText(toc.text ?? '');
                final isActive = id == currentAnchorId;

                String prefix = '';
                if (toc.level == 2) {
                  prefix = '';
                } else if (toc.level == 3) {
                  prefix = '- ';
                }

                double indent = 0;
                if (toc.level == 2) indent = 16;
                if (toc.level == 3) indent = 24;

                return GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    onAnchorTap(id);
                  },
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        width: 4,
                        height: 40,
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: isActive ? Colors.green : Colors.grey,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(left: indent),
                          child: Text(
                            "$prefix${toc.text ?? ''}",
                            style: TextStyle(
                              color: isActive ? Colors.green : Colors.black87,
                              fontWeight: (toc.level == 1 && isActive)
                                  ? FontWeight.bold
                                  : (toc.level == 1 ? FontWeight.w600 : FontWeight.normal),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}