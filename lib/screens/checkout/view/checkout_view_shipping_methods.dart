import 'package:cirilla/mixins/mixins.dart';
import 'package:cirilla/screens/cart/widgets/cart_shipping.dart';
import 'package:cirilla/store/cart/cart_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CheckoutViewShippingMethods extends StatelessWidget with LoadingMixin {
  final CartStore cartStore;
  final bool isDivider;

  const CheckoutViewShippingMethods({Key? key, required this.cartStore, this.isDivider = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        children: [
          CartShipping(
            cartStore: cartStore,
            cartData: cartStore.cartData,
            changeAddress: false,
            isDivider: isDivider,
          ),
          if (cartStore.loadingShipping)
            Align(
              alignment: FractionalOffset.center,
              child: buildLoadingOverlay(context),
            ),
        ],
      ),
    );
  }
}
