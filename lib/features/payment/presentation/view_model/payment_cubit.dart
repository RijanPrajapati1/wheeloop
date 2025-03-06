// payment_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:wheeloop/app/constants/api_endpoints.dart';
import 'package:wheeloop/features/payment/presentation/view_model/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  final Dio dio;

  PaymentCubit(this.dio) : super(PaymentInitial());

  // Method to handle the payment process
  Future<void> processPayment(Map<String, String> paymentData) async {
    emit(PaymentLoading());

    try {
      final response =
          await dio.post(ApiEndpoints.processPayment, data: paymentData);

      if (response.statusCode == 200) {
        emit(PaymentSuccess());
      } else {
        emit(PaymentError("Payment failed. Please try again."));
      }
    } catch (e) {
      emit(PaymentError("Error: $e"));
    }
  }
}
