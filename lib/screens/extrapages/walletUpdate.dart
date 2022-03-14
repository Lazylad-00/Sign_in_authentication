import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sign_in_system/models/user_model.dart';
import 'package:sign_in_system/screens/extrapages/droplist.dart';

class WalletUpdate {
  DropList dropList = DropList();
  final Query<UserModel> userRef = FirebaseFirestore.instance
      .collection('Users')
      .where('Name', isEqualTo: DropList().initValue)
      .withConverter<UserModel>(
        fromFirestore: (snapshots, _) => UserModel.fromJson(snapshots.data()!),
        toFirestore: (userModel, _) => userModel.toJson(),
      );
}
