import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'sumo_payment_plan_store.g.dart';

class SumoPaymentPlanStore = _SumoPaymentPlanStore with _$SumoPaymentPlanStore;

abstract class _SumoPaymentPlanStore with Store {
  final String apiUrl =
      "https://shop.bsvtech.com.my/wp-json/wc/v3/sumo-payment-plans";

  @observable
  ObservableList<Map<String, dynamic>> plans =
      ObservableList<Map<String, dynamic>>();

  @observable
  bool isLoading = false;

  @observable
  String errorMessage = '';

  @action
  Future<void> fetchPaymentPlans() async {
    isLoading = true;
    errorMessage = '';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        plans = ObservableList.of(data
            .map((plan) => {
                  "id": plan['ID'],
                  "title": plan["title"],
                  "description": plan["description"],
                  "installments": plan["installments"],
                  "initial_payment": plan["initial_payment"],
                  "fixed_payment_amount": plan["fixed_payment_amount"],
                })
            .toList());
      } else {
        errorMessage = "Gagal mengambil data cicilan.";
      }
    } catch (e) {
      errorMessage = "Terjadi kesalahan: $e";
    }

    isLoading = false;
    @action
    Future<void> fetchPaymentPlans() async {
      isLoading = true;
      errorMessage = '';

      try {
        print("🔍 Fetching SUMO Payment Plans...");
        final response = await http.get(Uri.parse(apiUrl));

        print("📩 Response Status Code: ${response.statusCode}");
        print("📩 Response Body: ${response.body}");

        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body);
          if (data.isNotEmpty) {
            print("✅ Data Cicilan Diterima: $data");
            plans = ObservableList.of(data
                .map((plan) => {
                      "id": plan['ID'],
                      "title": plan["title"],
                      "description": plan["description"],
                      "installments": plan["installments"],
                      "initial_payment": plan["initial_payment"],
                      "fixed_payment_amount": plan["fixed_payment_amount"],
                    })
                .toList());
          } else {
            print("⚠️ Tidak ada cicilan yang tersedia.");
            errorMessage = "Tidak ada cicilan tersedia.";
          }
        } else {
          print("❌ Gagal mengambil data: ${response.body}");
          errorMessage = "Gagal mengambil data cicilan.";
        }
      } catch (e) {
        print("❌ Error: $e");
        errorMessage = "Terjadi kesalahan: $e";
      }

      isLoading = false;
    }
  }
}
