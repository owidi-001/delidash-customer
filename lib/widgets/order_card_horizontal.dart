import 'package:flutter/material.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/profile/pages/order_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/utility/date_converter.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  OrderCard({super.key, required this.order});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Map<String, Color> statusColor = {
    "Completed": AppTheme.primaryColor,
    "Cancelled": AppTheme.redColor,
    "Pending": Colors.yellow.shade700,
    "On Transit": AppTheme.darkColor
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: InkWell(
        onTap: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (((context) => OrderDetail(order: widget.order))),
              ));
        }),
        child: Card(
            color: AppTheme.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                  color: AppTheme.whiteColor,
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: AppTheme.lightColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        padding: const EdgeInsets.all(8.0),
                        width: 100,
                        height: 100,
                        child: Image.network(
                          "$baseURL${widget.order.item.image}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            width: 100,
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.order.item.name,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.secondaryColor),
                            ),
                          ),
                          Text("${widget.order.quantity} items"),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: statusColor[widget.order.status]!,
                              ),
                              child: Text(
                                widget.order.status,
                                style:
                                    const TextStyle(color: AppTheme.lightColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          convertDate(widget.order.dateOrdered),
                          style:
                              const TextStyle(color: AppTheme.secondaryColor),
                        ),
                        // Text(
                        //   convertTime(widget.order.time),
                        //   style:
                        //       const TextStyle(color: AppTheme.secondaryColor),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
