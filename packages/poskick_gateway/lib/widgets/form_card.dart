import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class FormCard extends StatefulWidget {
  final void Function(BuildContext, Map<String, String>) checkout;
  final bool loading;

  const FormCard({
    Key? key,
    required this.checkout,
    this.loading = false,
  }) : super(key: key);

  @override
  State<FormCard> createState() => _FormCardState();
}

class _FormCardState extends State<FormCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cvvCode = '';
  String brandName = 'other-brand';

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cvvCode = creditCardModel.cvvCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(4, 0, 4, 20),
        child: Column(
          children: [
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cvvCode: cvvCode,
              cardHolderName: "",
              bankName: 'Name Bank',
              showBackView: false,
              obscureCardNumber: true,
              obscureCardCvv: true,
              isHolderNameVisible: false,
              cardBgColor: Color(0xFF57c2bb),
              isSwipeGestureEnabled: false,
              onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  late String textBrand;
                  switch (creditCardBrand.brandName) {
                    case CardType.americanExpress:
                      textBrand = "american-express";
                      break;
                    case CardType.discover:
                      textBrand = "discover";
                      break;
                    case CardType.elo:
                      textBrand = "elo";
                      break;
                    case CardType.hipercard:
                      textBrand = "hipercard";
                      break;
                    case CardType.mastercard:
                      textBrand = "mastercard";
                      break;
                    case CardType.rupay:
                      textBrand = "rupay";
                      break;
                    case CardType.unionpay:
                      textBrand = "unionpay";
                      break;
                    case CardType.visa:
                      textBrand = "visa";
                      break;
                    default:
                      textBrand = "other-brand";
                  }
                  if (textBrand != brandName) {
                    setState(() {
                      brandName = textBrand;
                    });
                  }
                });
              },
            ),
            CreditCardForm(
              formKey: formKey,
              obscureCvv: true,
              obscureNumber: false,
              cardNumber: cardNumber,
              cvvCode: cvvCode,
              cardHolderName: "",
              isHolderNameVisible: false,
              isCardNumberVisible: true,
              isExpiryDateVisible: true,
              expiryDate: expiryDate,
              themeColor: theme.primaryColor,
              textColor: theme.textTheme?.titleMedium?.color ?? Colors.black,
              cardNumberDecoration: InputDecoration(
                labelText: 'Card Number',
                hintText: 'XXXX XXXX XXXX XXXX',
              ),
              expiryDateDecoration: InputDecoration(
                labelText: 'Expired Date',
                hintText: 'XX/XX',
              ),
              cvvCodeDecoration: InputDecoration(
                labelText: 'CVV',
                hintText: 'XXX',
              ),
              onCreditCardModelChange: onCreditCardModelChange,
              cardNumberValidator: (String? value) {
                if (value?.isNotEmpty != true) {
                  return "Fill field";
                }
                if (value!.length < 16) {
                  return "Card Number is not valid";
                }
                return null;
              },
              expiryDateValidator: (String? value) {
                if (value!.isEmpty) {
                  return "Fill field";
                }
                final DateTime now = DateTime.now();
                final List<String> date = value.split(RegExp(r'/'));
                final int month = int.parse(date.first);
                final int year = int.parse('20${date.last}');
                final int lastDayOfMonth = month < 12 ? DateTime(year, month + 1, 0).day : DateTime(year + 1, 1, 0).day;
                final DateTime cardDate = DateTime(year, month, lastDayOfMonth, 23, 59, 59, 999);

                if (cardDate.isBefore(now) || month > 12 || month == 0) {
                  return "Expired Date is not valid";
                }
                return null;
              },
              cvvValidator: (String? value) {
                if (value?.isNotEmpty != true) {
                  return "Fill field";
                }
                if (value!.length < 3) {
                  return "CVV is not valid";
                }
                return null;
              },
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (!widget.loading && formKey.currentState!.validate()) {
                    List<String> arrDate = expiryDate.split("/");
                    widget.checkout(context, {
                      "number": cardNumber.replaceAll(" ", ""),
                      "expiration_month": arrDate.isNotEmpty ? arrDate[0] : "",
                      "expiration_year": arrDate.length > 1 ? "20${arrDate[1]}" : "",
                      "cvc": cvvCode,
                      "brand": brandName,
                    });
                  }
                },
                child: widget.loading ? CupertinoActivityIndicator(radius: 7, color: theme.colorScheme.onPrimary) : Text("Payment"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
