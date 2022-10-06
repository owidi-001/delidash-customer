import 'package:flutter/material.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/theme/app_theme.dart';

class OrderCard extends StatelessWidget {
  final Order order;
  OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: () => onTapCallback(),
      child: Card(
          color: AppTheme.lightColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "#Order number",
                          style: TextStyle(
                              color: AppTheme.secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          "Total: Sh. 200",
                          style: TextStyle(
                              color: AppTheme.darkColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    )),
                Flexible(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => {
                          // delete item from the order list
                          // orderProvider.items.remove(order);
                        },
                        child: const CircleAvatar(
                          backgroundColor: AppTheme.whiteColor,
                          radius: 20,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.delete,
                              color: AppTheme.redColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const Text(
                        "date: sep 02/22",
                        style: TextStyle(
                            color: AppTheme.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
