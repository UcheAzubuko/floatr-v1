import 'package:flutter/material.dart';

class OrderedList extends StatelessWidget {
  const OrderedList(this.texts, {super.key});
  final List<dynamic> texts;

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    int counter = 0;
    for (var text in texts) {
      // Adds list item
      counter++;
      widgetList.add(OrderedListItem(counter, text));
      // Adds space between list items
      widgetList.add(const SizedBox(height: 5.0));
    }

    return Column(children: widgetList);
  }
}

class OrderedListItem extends StatelessWidget {
  const OrderedListItem(this.counter, this.text, {super.key});
  final int counter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$counter. "),
        Expanded(
          child: Text(text),
        ),
      ],
    );
  }
}
