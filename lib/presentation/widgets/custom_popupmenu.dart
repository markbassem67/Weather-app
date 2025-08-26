import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu {
  Widget customPopupMenuWidget() {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      itemBuilder: (context) => [
        const PopupMenuItem(value: 'item1', child: SizedBox(width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Celsius'),
              Text('°C'),
            ],
          ),
        )),
        const PopupMenuItem(value: 'item2', child: SizedBox(width: 110,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Fahrenheit'),
              Text('°F'),
            ],
          ),
        )),
        //const PopupMenuItem(value: 'item3', child: Text('Item 3')),
      ],
      icon: const Icon(CupertinoIcons.bars, color: Colors.white),
      offset: const Offset(0, 45), // 👈 shift menu 50px down
    );
  }
}
