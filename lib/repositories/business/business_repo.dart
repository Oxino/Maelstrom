import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/repositories/business/base_business_repo.dart';

class BusinessRepo extends BaseBusinessRepo {
  final FirebaseFirestore _firebaseFirestore;
  final CollectionReference _businessCollectionReference =
      FirebaseFirestore.instance.collection("business_users");

  BusinessRepo({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<BusinessModel> getCurrentBusiness(idBusiness) {
    return _businessCollectionReference
        .doc(idBusiness)
        .snapshots()
        .map((snapshot) => BusinessModel.formSnapshot(snapshot));
  }

  Future getCurrentBusiness1(String id) async {
    try {
      var business = await _businessCollectionReference.doc(id).get();
      print(business);
      return BusinessModel.formSnapshot(business);
    } catch (e) {
      print("Echec de la récupération de l'utilisateur: $e");
    }
  }
}
