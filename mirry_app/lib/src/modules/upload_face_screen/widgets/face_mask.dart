import 'package:flutter/material.dart';
import 'package:mirry/src/config/theme/colors.dart';

class FaceMask extends StatelessWidget {
  const FaceMask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          bgColor.withOpacity(0.6),
          BlendMode.srcOut,
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black,
                backgroundBlendMode: BlendMode.dstOut,
              ), // This one will handle background + difference out
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                height: size.height * .6,
                width: size.width * .9,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(200)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
