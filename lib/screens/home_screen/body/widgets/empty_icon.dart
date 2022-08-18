import "package:flutter/material.dart";
import 'package:for21day/variables/text_styles.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EmptyIcon extends StatelessWidget {
  const EmptyIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30.h,
              child: Image.asset(
                "assets/images/leaf.png",
              ),
            ),
            Text(
              'You haven\'t added any items yet',
              style: TextStyles.infoTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
