// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart' as auth;
// import 'package:phone_auth_demo/models/user_model.dart';
// import 'package:phone_auth_demo/repo/base_user_repo.dart';

// class DatabaseRepository extends BaseUserRepository {
//   final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

//   // @override
//   // Stream<User> getUser(String userId) {
//   //   print('Getting user images from DB');
//   //   return _firebaseFirestore
//   //       .collection('users')
//   //       .doc(userId)
//   //       .snapshots()
//   //       .map((snap) => User.fromSnapshot(snap));
//   // }

//   @override
//   Future<void> createUser(User user) async {
//     await _firebaseFirestore
//         .collection('users')
//         .doc(user.uid)
//         .set(user.toMap());
//   }

//   @override
//   Future<void> updateUser(User user) async {
//     return _firebaseFirestore
//         .collection('users')
//         .doc(user.uid)
//         .update(user.toMap())
//         .then(
//           (value) => print('User document updated.'),
//         );
//   }
// }
