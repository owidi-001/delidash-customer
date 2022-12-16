import 'package:flutter/material.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/screens/profile/pages/order_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:greens_veges/utility/date_converter.dart';
import 'package:greens_veges/utility/time_converter.dart';

class OrderCard extends StatefulWidget {
  final OrderItem item;
  OrderCard({super.key, required this.item});

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
                builder: (((context) => OrderDetail(item: widget.item))),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          "$baseURL${widget.item.product.image}",
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
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Text(
                              widget.item.product.label,
                              maxLines: 1,
                              style: const TextStyle(
                                  overflow: TextOverflow.clip,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.secondaryColor),
                            ),
                          ),
                          Text("${widget.item.quantity} items"),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: statusColor[widget.item.status]!,
                              ),
                              child: Text(
                                widget.item.status,
                                style:
                                    const TextStyle(color: AppTheme.lightColor),
                              ))
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          convertDate(widget.item.date),
                          style:
                              const TextStyle(color: AppTheme.secondaryColor),
                        ),
                        Text(
                          convertTime(widget.item.time),
                          style:
                              const TextStyle(color: AppTheme.secondaryColor),
                        )
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
