// import 'package:flutter/material.dart';
// import 'package:khalti_flutter/khalti_flutter.dart';

// void showPaymentResult(BuildContext context, String title,
//     {PaymentSuccessModel? successModel,
//     PaymentFailureModel? failureModel,
//     String? token,
//     int? productId,
//     String? productName,
//     String? khaltiId,
//     int? paidAmount}) {
//   showDialog(
//     context: context,
//     builder: (_) {
//       if (successModel != null) {
//         // var loginState = context.read<LoginBloc>().state;
//         // if (loginState is LoginLoaded) {
//         //   context.read<RenewSubscriptionBloc>().add(RenewSubscriptionHitEvent(
//         //       tier: tier!.id!,
//         //       methodOfPayment: 'Khalti',
//         //       transactionId: successModel.idx,
//         //       paidAmount: paidAmount.toString(),
//         //       paidTill: paidTill!,
//         //       token: loginState.successModel.token!));
//         // }
//       }
//       return AlertDialog(
//         title: Text(
//           title,
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Color(0xff32454D),
//           ),
//         ),
//         // CustomPoppinsText(
//         //   text: title,
//         //   fontSize: 16,
//         //   fontWeight: FontWeight.w500,
//         //   color: Color(0xff32454D),
//         // ),
//         actions: [
//           SimpleDialogOption(
//               padding: EdgeInsets.all(8),
//               child: Text("Ok",
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
//               onPressed: () {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text("Successfully Ordered")));
//                 Navigator.of(context).pushNamedAndRemoveUntil(
//                     '/home', (Route<dynamic> route) => false);
//               })
//         ],
//       );
//     },
//   );
// }

// void onCancel(BuildContext context) {
//   Navigator.popAndPushNamed(context, "/home");
//   ScaffoldMessenger.of(context)
//       .showSnackBar(const SnackBar(content: Text("Successfully Cancelled")));
// }

// void payWithKhaltiInApp(
//     {required BuildContext context,
//     required String token,
//     required int productId,
//     required String productName,
//     required String khaltiId,
//     required int paidAmount}) {
//   final config = PaymentConfig(
//     amount: 2000,
//     productIdentity: productId.toString(),
//     productName: productName,
//   );

//   KhaltiScope.of(context).pay(
//     config: config,
//     preferences: [PaymentPreference.khalti],
//     onSuccess: (successModel) => showPaymentResult(
//       paidAmount: paidAmount,
//       context,
//       token: token,
//       "Successfully Paid :)",
//       successModel: successModel,
//       khaltiId: khaltiId,
//       productId: productId,
//       productName: productName,
//     ),
//     onCancel: () => onCancel(context),
//     onFailure: (paymentFailure) => showPaymentResult(context, "Failed Bro"),
//   );
// }
