import 'package:arcadi/models/account.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:arcadi/src/providers.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../components/custom_appbar.dart';
import '../../../components/custom_input.dart';
import '../../../components/loader_button.dart';

import '../../localization/source.dart';
import '../../theme.dart';

import 'auth_controller.dart';
import 'auth_service.dart';

class Auth extends StatefulWidget {
  const Auth({this.change = false, Key? key}) : super(key: key);
  final bool change;

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> with TickerProviderStateMixin {
  TabController? _controller;
  String _phone = '';

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return Scaffold(
      appBar: appbar(context, widget.change ? t.change_phone : t.auth, shadow: false),
      body: TabBarView(
        controller: _controller,
        children: [
          PhoneInput(
            _controller!,
            phone: (p) async {
              if (mounted) setState(() => _phone = p);
              await AuthController.requestSMSCode(context, _phone, _controller!);
            },
          ),
          SMSrequest(_controller!, phone: _phone),
          CallRequest(phone: _phone),
        ],
      ),
    );
  }
}

class PhoneInput extends StatefulWidget {
  const PhoneInput(this.controller, {required this.phone, Key? key}) : super(key: key);
  final TabController controller;
  final Function(String) phone;

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  FocusNode focus = FocusNode();
  TextEditingController phone = TextEditingController();
  @override
  void initState() {
    focus.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final text = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(flex: 2),
          Text(t.auth_desc, style: text.bodyText1),
          const SizedBox(height: 16),
          CustomInput(
            icon: Icons.phone_android,
            label: t.input_phone,
            child: TextField(
              controller: phone,
              focusNode: focus,
              textAlignVertical: TextAlignVertical.bottom,
              keyboardType: TextInputType.number,
              inputFormatters: [TextInputMask(mask: '(999) 999 99 99')],
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(top: 25, left: 16),
                  child: Text(' + 7 ', style: text.subtitle1!.copyWith(letterSpacing: 0.3)),
                ),
                hintText: '(---) --- -- --',
              ),
            ),
          ),
          const Spacer(),
          LoaderButton(
            child: Text(t.next),
            onPressed: () async => await widget.phone(phone.text),
          ),
          const SizedBox(height: 24)
        ],
      ),
    );
  }
}

class SMSrequest extends StatefulWidget {
  const SMSrequest(this.controller, {required this.phone, Key? key}) : super(key: key);
  final TabController controller;
  final String phone;

  @override
  State<SMSrequest> createState() => _SMSrequestState();
}

class _SMSrequestState extends State<SMSrequest> {
  TextEditingController code = TextEditingController();
  FocusNode focus = FocusNode();

  bool isSMSdelayed = false;
  bool isSMSinprogress = false;
  int seconds = 30;
  Stream<String> _countDownTimer(int sec) async* {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      seconds--;
      final String twoDigitSeconds = twoDigits(Duration(seconds: seconds).inSeconds.remainder(60));
      yield twoDigitSeconds;
      if (seconds == 0 && mounted) {
        setState(() => isSMSdelayed = true);
        break;
      }
    }
  }

  @override
  void initState() {
    focus.requestFocus();
    code.addListener(() async {
      if (code.text.length == 4) {
        if (mounted) setState(() => isSMSinprogress = true);

        final res = await AuthService.checkCode(widget.phone, code.text, false);
        if (res.statusCode == 200) {
          final prof = await AuthService.getUser();
          final acc = Account.fromJson(prof.data);

          context.read(accountProvider).state = acc;
          for (final u in acc.relatives) {
            if (u.id == acc.currentUserId) {
              context.read(currentUserProvider).state = u;
            }
          }

          Navigator.pushNamed(context, '/tabs');
        } else {
          // Alert
        }
        code.clear();
        if (mounted) setState(() => isSMSinprogress = false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;
    final text = Theme.of(context).textTheme;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: bgGrey,
      borderRadius: BorderRadius.circular(12),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.enter_sms, style: text.subtitle1),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(t.code_sent),
              Text(' +7 ${widget.phone}', style: text.bodyText1),
            ],
          ),
          const SizedBox(height: 8),
          InkWell(
            child: Text(t.change_phone, style: text.subtitle1!.copyWith(color: primaryBlue)),
            onTap: () => widget.controller.animateTo(0),
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              SizedBox(
                width: 194,
                child: Theme(
                  data: ThemeData(inputDecorationTheme: const InputDecorationTheme(filled: false)),
                  child: PinPut(
                    focusNode: focus,
                    controller: code,
                    useNativeKeyboard: true,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    withCursor: true,
                    fieldsCount: 4,
                    fieldsAlignment: MainAxisAlignment.spaceBetween,
                    textStyle: const TextStyle(fontSize: 18, color: Color(0xFF666666)),
                    eachFieldWidth: 41,
                    eachFieldHeight: 48,
                    pinAnimationType: PinAnimationType.scale,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              if (isSMSinprogress)
                Theme(
                  data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.light)),
                  child: const CupertinoActivityIndicator(),
                )
            ],
          ),
          const SizedBox(height: 16),
          isSMSdelayed ? Text(t.sms_delay) : Text(t.sms_wait),
          const SizedBox(height: 4),
          !isSMSdelayed
              ? StreamBuilder<String>(
                  stream: _countDownTimer(30),
                  builder: (context, snapshot) {
                    var sec = '30';
                    if (snapshot.hasData) sec = snapshot.data.toString();
                    return Text('0:$sec', style: text.subtitle1);
                  })
              : InkWell(
                  child: Text(t.request_call, style: text.subtitle1!.copyWith(color: primaryBlue)),
                  onTap: () async {
                    await AuthController.requestPhoneCode(context, widget.phone, widget.controller);
                  },
                ),
        ],
      ),
    );
  }
}

class CallRequest extends StatefulWidget {
  const CallRequest({required this.phone, Key? key}) : super(key: key);
  final String phone;

  @override
  State<CallRequest> createState() => _CallRequestState();
}

class _CallRequestState extends State<CallRequest> {
  TextEditingController code = TextEditingController();
  FocusNode focus = FocusNode();

  bool isCallInprogress = false;

  @override
  void initState() {
    focus.requestFocus();
    code.addListener(() async {
      if (code.text.length == 4) {
        setState(() => isCallInprogress = true);
        await AuthController.checkCode(context, widget.phone, code.text, true);
        code.clear();
        setState(() => isCallInprogress = false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final text = Theme.of(context).textTheme;
    final BoxDecoration pinPutDecoration = BoxDecoration(
      color: bgGrey,
      borderRadius: BorderRadius.circular(12),
    );
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.enter_phone_code, style: text.subtitle1),
          const SizedBox(height: 16),
          Row(children: [Text(t.we_call), Text(' +7 ${widget.phone}', style: text.bodyText1)]),
          const SizedBox(height: 16),
          Row(
            children: [
              SizedBox(
                width: 194,
                child: Theme(
                  data: ThemeData(inputDecorationTheme: const InputDecorationTheme(filled: false)),
                  child: PinPut(
                    focusNode: focus,
                    controller: code,
                    useNativeKeyboard: true,
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    withCursor: true,
                    fieldsCount: 4,
                    fieldsAlignment: MainAxisAlignment.spaceBetween,
                    textStyle: const TextStyle(fontSize: 18, color: Color(0xFF666666)),
                    eachFieldWidth: 41,
                    eachFieldHeight: 48,
                    pinAnimationType: PinAnimationType.scale,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              if (isCallInprogress)
                Theme(
                  data: ThemeData(cupertinoOverrideTheme: const CupertinoThemeData(brightness: Brightness.light)),
                  child: const CupertinoActivityIndicator(),
                )
            ],
          ),
        ],
      ),
    );
  }
}
