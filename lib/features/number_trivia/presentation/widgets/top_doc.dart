import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/provider_file.dart';

class TopDoc extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final text = ref.watch(boxProvider);

    return Column(
      children: [Text(text.value.toString())],
    );
  }
}
