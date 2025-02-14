import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:cirilla/store/auth/auth_store.dart';
import 'package:cirilla/store/order/order_store.dart';
import 'package:cirilla/models/order/order.dart';

class SumoPaymentPlansScreen extends StatefulWidget {
  static const String routeName = "/sumo-payment-plans";

  const SumoPaymentPlansScreen({Key? key}) : super(key: key);

  @override
  _SumoPaymentPlansScreenState createState() => _SumoPaymentPlansScreenState();
}

class _SumoPaymentPlansScreenState extends State<SumoPaymentPlansScreen> {
  late OrderStore _orderStore;
  late AuthStore _authStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _authStore = Provider.of<AuthStore>(context);
    _orderStore = Provider.of<OrderStore>(context);

    if (_authStore.isLogin) {
      _orderStore.getOrders();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Daftar Cicilan")),
      body: Observer(
        builder: (_) {
          if (_orderStore.loading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_orderStore.orders.isEmpty) {
            return Center(child: Text("Tidak ada cicilan tersedia."));
          }

          // Ambil hanya order yang menggunakan SUMO Payment Plan
          List<OrderData> sumoOrders = _orderStore.orders.where((order) {
            if (order.metaData == null)
              return false; // Pastikan metaData tidak null
            return order.metaData!.any((meta) =>
                meta.keys == "is_sumo_pp_order" &&
                meta.values.toString() == "yes");
          }).toList();

          if (sumoOrders.isEmpty) {
            return Center(child: Text("Tidak ada cicilan aktif."));
          }

          return ListView.builder(
            itemCount: sumoOrders.length,
            itemBuilder: (context, index) {
              final order = sumoOrders[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text("Order ID: #${order.id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Status: ${order.status}"),
                      Text("Total: RM${order.total}"),
                      Text("Tanggal Order: ${order.dateCreated}"),
                    ],
                  ),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    // Bisa tambahkan navigasi ke detail cicilan
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
