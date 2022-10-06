import 'package:flutter/material.dart';
import 'package:greens_veges/widgets/shimmer_animation.dart';
import 'package:greens_veges/widgets/skeleton.dart';

class VendorCardSkeleton extends StatelessWidget {
  const VendorCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerLoading(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
                flex: 1,
                child: Skeleton(
                  width: 80,
                  height: 80,
                )),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [Skeleton(
                    width: 80,
                    height: 12,
                  ),
                  SizedBox(width: 8,)
                  ,Skeleton(
                    width: 80,
                    height: 12,
                  ),],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: const [Skeleton(
                    width: 60,
                    height: 12,
                  ),
                  SizedBox(width: 8,)
                  ,Skeleton(
                    width: 40,
                    height: 12,
                  ),],
                  ),
                  const SizedBox(height: 8,),
                  const Skeleton(
                    width: 40,
                    height: 12,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
