import 'package:flutter/material.dart';
import 'package:test/features/number_trivia/presentation/widgets/category_icon.dart';

import '../components/tabs/home_tab.dart';

class CategoryIcons extends StatelessWidget {
  const CategoryIcons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (var category in categories)
          CategoryIcon(
            icon: category['icon'],
            text: category['text'],
          ),
      ],
    );
  }
}