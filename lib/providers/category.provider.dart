import 'package:flutter/foundation.dart';
import 'package:greens_veges/constants/status.dart';
import 'package:greens_veges/domain/product.model.dart';
import 'package:greens_veges/services/app.service.dart';

class CategoryProvider with ChangeNotifier {
  List<ProductCategory> data = [ProductCategory.empty()];
  ServiceStatus status = ServiceStatus.initial;

  CategoryProvider() {
    status = ServiceStatus.initial;
    _init();
  }

  Future<void> _init() async {
    final res = await AppService().fetchCategories();

    res.when(error: (error) {
      /// pass
      status = ServiceStatus.loadingFailure;
    }, success: (data) {
      this.data += data;
      status = ServiceStatus.loadingSuccess;
    });
    notifyListeners();
  }
}
