import 'package:maelstrom/models/business_model.dart';

abstract class BaseBusinessRepo {
  Stream<BusinessModel> getCurrentBusiness(idBusiness);
}

abstract class BaseBusinessRepo1 {
  Future getCurrentBusiness(String idBusiness);
}
