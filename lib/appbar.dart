import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class CustomAppB extends StatelessWidget implements PreferredSizeWidget {
  final String? title;

  CustomAppB({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 16,
      ),
      padding: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null)
            Container(
              width: 200,
              child: Text(
                title!,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Container(
                width: 100,
                height: 4,
              ),
              SizedBox(width: 4),
              Container(
                width: 10,
                height: 4,
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(136);
}
