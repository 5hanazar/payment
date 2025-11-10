import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

class PaymentPage extends StatefulWidget {
  final String title;
  const PaymentPage({super.key, required this.title});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _paymentAmount = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _contractNumber = TextEditingController();
  final TextEditingController _cardNumber = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade800))),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.only(top: 0, right: 24, bottom: 24, left: 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: Text("Bank kartyňyz bilen \"${widget.title}\" hasabyňyzy dolduryp bilersiňiz!", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: "Roboto"))),
                      Lottie.asset('assets/lottie_payment.json', width: MediaQuery.of(context).size.width / 2, frameRate: const FrameRate(60)),
                    ],
                  ),
                  widget.title.startsWith("TM CELL") ?
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _phoneNumber,
                    readOnly: _isLoading,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(8),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Telefon',
                      prefixText: "+993 ",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty || !RegExp(r'^\d{8}$').hasMatch(value)) {
                        return 'Dolduryň';
                      }
                      return null;
                    },
                  ) :
                  TextFormField(
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    controller: _contractNumber,
                    readOnly: _isLoading,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Şertnama №',
                      prefixText: "№ ",
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty || !RegExp(r'^\d{6}$').hasMatch(value)) {
                        return 'Dolduryň';
                      }
                      return null;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: TextFormField(
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      controller: _paymentAmount,
                      readOnly: _isLoading,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Möçberi',
                        suffixText: "TMT",
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Dolduryň';
                        }
                        return null;
                      },
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.black54,
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset('assets/chip_card.svg', height: 40),
                            const Expanded(child: Text("BANK KART", textAlign: TextAlign.end, style: TextStyle(fontSize: 24, fontFamily: "Roboto", color: Colors.black54))),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16, bottom: 16),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            controller: _cardNumber,
                            readOnly: _isLoading,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(16),
                            ],
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Nomeri',
                              hintText: "0000 0000 0000 0000"
                            ),
                            validator: (String? value) {
                              if (value == null || value.isEmpty || !RegExp(r'^\d{16}$').hasMatch(value)) {
                                return 'Dolduryň';
                              }
                              return null;
                            },
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 120,
                              child: TextFormField(
                                textInputAction: TextInputAction.next,
                                readOnly: _isLoading,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(5),
                                ],
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Möhleti',
                                    hintText: "00/00"
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Dolduryň';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              width: 120,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.next,
                                readOnly: _isLoading,
                                obscureText: true,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  LengthLimitingTextInputFormatter(3),
                                ],
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'CVC',
                                    hintText: "000",
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty || !RegExp(r'^\d{3}$').hasMatch(value)) {
                                    return 'Dolduryň';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 24),
                    child: TextFormField(
                      readOnly: _isLoading,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Kartyň eýesi',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Dolduryň';
                        }
                        return null;
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 180,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade400,
                            disabledBackgroundColor: Colors.blue.shade400,
                            foregroundColor: Colors.white,
                            disabledForegroundColor: Colors.white,
                          ),
                          onPressed: _isLoading
                              ? null
                              : () async {
                            if (_formKey.currentState?.validate() == false) return;
                            setState(() { _isLoading = true; });
                            await Future.delayed(const Duration(seconds: 2));
                            Fluttertoast.showToast(
                                msg: "Bank jogap bermedi.",
                                backgroundColor: Colors.red,
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.TOP);
                            setState(() { _isLoading = false; });
                          },
                          child: _isLoading
                              ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 3, color: Colors.white))
                              : const Text("Töleg geçir", style: TextStyle(fontSize: 16),)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
