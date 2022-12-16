import 'package:flutter/material.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/screens/profile/pages/order_detail.dart';
import 'package:greens_veges/theme/app_theme.dart';

class OrderCard extends StatefulWidget {
  final OrderItem item;
  OrderCard({super.key, required this.item});

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  Map<String, Color> statusColor = {
    "Fulfilled": AppTheme.primaryColor,
    "Cancelled": AppTheme.redColor,
    "Pending": Colors.yellow.shade700,
    "Processing": AppTheme.darkColor
  };

  @override
  Widget build(BuildContext context) {

    return Card(
      color: AppTheme.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: ((context) => OrderDetail(item: widget.item)),
          ),
        ),
        leading: Container(
          clipBehavior: Clip.antiAlias,
          height: 100,
          width: 80,
          decoration: const BoxDecoration(
              color: AppTheme.lightColor,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          alignment: Alignment.center,
          child: Image.asset(
            "assets/images/app_logo.png",
            fit: BoxFit.fill,
          ),
          // child: Image.network(
          //   "$baseURL${vendor.logo}",
          // ),
        ),
        title: Container(
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
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.item.quantity} items"),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: statusColor[widget.item.status]!,
                ),
                child: Text(
                  widget.item.status,
                  style: const TextStyle(color: AppTheme.lightColor),
                ))
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              convertDate(widget.item.orderDate),
              style: const TextStyle(color: AppTheme.secondaryColor),
            )
          ],
        ),
      ),
    );
  }
}

String convertDate(String date) {
  DateTime dateConverted = DateTime.parse(date);
  List months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  return "${months[dateConverted.month - 1]} ${dateConverted.day.toString()}/${dateConverted.year.toString()}";
}
