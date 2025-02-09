import 'package:cirilla/models/models.dart';
import 'package:cirilla/screens/profile/widgets/icon_notification.dart';
import 'package:cirilla/store/store.dart';
import 'package:cirilla/utils/utils.dart';
import 'package:cirilla/widgets/builder/banner/banner.dart';
import 'package:cirilla/widgets/builder/text/text.dart';
import 'package:cirilla/widgets/widgets.dart';
// import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'data_banner_widget.dart';
import 'widgets/widgets.dart';

class AppBarCustom extends StatefulWidget {
  final WidgetConfig? widgetConfig;
  final bool isAppbar;
  const AppBarCustom({
    this.widgetConfig,
    this.isAppbar = true,
    Key? key,
  }) : super(key: key);

  @override
  State<AppBarCustom> createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  late AuthStore _authStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _authStore = Provider.of<AuthStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    double heightAppBar = widget.isAppbar ? 20 : AppBar().preferredSize.height;

    return Observer(
      builder: (_) {
        String? name =
            _authStore.isLogin ? _authStore.user?.displayName : 'Dislay Name';
        return Stack(
          children: [
            ClipPath(
              clipper: CurvedBottomClipper(),
              child: Container(
                height: 230.0 + heightAppBar,
                width: double.infinity,
                color: Colors.red,
                child: Image.asset(
                  'assets/images/appbar_background.png',
                  fit: BoxFit.cover,
                ),
                // child: const CirillaCacheImage(
                //   "https://toan.app-fly.com/wp-content/uploads/2024/12/Screenshot-2024-12-20-at-12.02.50.png",
                // ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: heightAppBar),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            widgetConfig: WidgetConfig.fromJson(dataTextWidget),
                          ),
                          Text(
                            '$name',
                            style: textTheme.titleLarge
                                ?.copyWith(color: theme.colorScheme.onPrimary),
                          ),
                          // TextWidget(
                          //   widgetConfig: WidgetConfig.fromJson(dataTextRewardWidget),
                          // ),
                        ],
                      ),
                      const IconNotification(
                        color: Colors.white,
                        padding: EdgeInsetsDirectional.zero,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    // child: Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Text('Total Amount Due',
                    //             style: textTheme.labelLarge),
                    //         // Text(
                    //         //   formatDate(
                    //         //       date: "2024-12-18T03:37:48",
                    //         //       locate: getLocate(context)),
                    //         //   style: textTheme.labelSmall,
                    //         // ),
                    //       ],
                    //     ),
                    //     Text(
                    //       formatCurrency(context,
                    //           currency: "MYR", price: "0.00", symbol: "RM"),
                    //       style: textTheme.labelLarge?.copyWith(
                    //         color: Colors.red,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ),
                  BannerWidget(widgetConfig: widget.widgetConfig),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
