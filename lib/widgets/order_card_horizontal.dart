import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/order.model.dart';
import 'package:greens_veges/providers/order.provider.dart';
import 'package:greens_veges/routes/app_router.dart';
import 'package:greens_veges/theme/app_theme.dart';
import 'package:provider/provider.dart';

class OrderCard extends StatefulWidget {
  final Order order;
  OrderCard({super.key, required this.order});

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

  // order detail view
  void _showModalSheet(List<OrderItem> items) {
    if (kDebugMode) {
      print(items.length);
    }
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return Container(
            color: AppTheme.gradientColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    color: AppTheme.whiteColor,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.center,
                    child: const Text(
                      "Order Items",
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: items.length,
                      itemBuilder: ((context, index) {
                        return Card(
                          color: AppTheme.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          elevation: 0,
                          child: ListTile(
                            leading: Image.network(
                              "$baseURL${items[index].product.image}",
                            ),
                            title: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                items[index].product.label,
                                maxLines: 1,
                                style: const TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.secondaryColor),
                              ),
                            ),
                            trailing: Text(
                              "@ ${items[index].quantity * items[index].product.unitPrice}",
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.secondaryColor),
                            ),
                            selectedTileColor: AppTheme.primaryColor,
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var orders = Provider.of<OrderProvider>(context);
    List<OrderItem> _items = [];
    if (orders.status == ServiceStatus.loadingSuccess &&
        orders.getOrders().isNotEmpty) {
      _items = orders.getOrderItems(widget.order);
    }

    return Card(
      color: AppTheme.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 0,
      child: ListTile(
        onTap: () => _showModalSheet(_items),
        leading: Text(
          "# ${widget.order.id}:",
          style: const TextStyle(
              color: AppTheme.primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        ),
        title: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            widget.order.location != null
                ? "To: ${widget.order.location!.name}"
                : "Unamed",
            maxLines: 1,
            style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppTheme.secondaryColor),
          ),
        ),
        subtitle: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "On: ${convertDate(widget.order.dateOrdered)}",
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppTheme.secondaryColor),
          ),
        ),
        trailing: Container(
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border:
                Border.all(color: statusColor[widget.order.status]!, width: 2),
          ),
          child: Icon(
            Icons.circle,
            color: statusColor[widget.order.status],
            size: 15,
          ),
        ),
        selectedTileColor: AppTheme.primaryColor,
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
  return "${months[dateConverted.month + 1]} ${dateConverted.day.toString()}/${dateConverted.year.toString()}";
}
