import 'package:arcadi/components/modal_body.dart';
import 'package:arcadi/models/account.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/custom_input.dart';
import '../../components/gender_switch.dart';
import '../../components/loader_button.dart';
import '../icons.dart';
import '../localization/source.dart';
import '../providers.dart';
import 'modal_controller.dart';

class AddSelf extends StatefulWidget {
  const AddSelf({Key? key}) : super(key: key);

  @override
  State<AddSelf> createState() => _AddSelfState();
}

class _AddSelfState extends State<AddSelf> {
  TextEditingController fullname = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController birthday = TextEditingController();
  bool allowedToSave = false;

  bool isEmpty() {
    if (fullname.text == "") return true;
    if (height.text == "") return true;
    if (weight.text == "") return true;
    if (birthday.text == "") return true;
    return false;
  }

  @override
  void initState() {
    final currentUser = context.read(currentUserProvider).state;
    fullname.text = currentUser.name;
    weight.text = currentUser.weight != 0 ? currentUser.weight.toString() : '';
    height.text = currentUser.height != 0 ? currentUser.height.toString() : '';
    birthday.text = currentUser.birthday;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;

    return ModalBody(
      context,
      title: t.add_your_data,
      back: t.back,
      children: [
        ListView(
          shrinkWrap: true,
          children: [
            Text(t.we_need_data, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 16),
            CustomInput(
                icon: Icons.person,
                label: t.fullname,
                child: TextField(
                  autofocus: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  textAlignVertical: TextAlignVertical.bottom,
                  controller: fullname,
                  onChanged: (_) => setState(() => allowedToSave = !isEmpty()),
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: CustomInput(
                        icon: CustomIcons.height,
                        label: t.height,
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: height,
                          onChanged: (_) => setState(() => allowedToSave = !isEmpty()),
                        ))),
                const SizedBox(width: 8),
                Expanded(
                    child: CustomInput(
                        icon: CustomIcons.scale,
                        label: t.weight,
                        child: TextField(
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          textAlignVertical: TextAlignVertical.bottom,
                          controller: weight,
                          onChanged: (_) => setState(() => allowedToSave = !isEmpty()),
                        ))),
              ],
            ),
            const SizedBox(height: 8),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                CustomInput(
                  icon: CustomIcons.cake,
                  label: t.birthday,
                  child: TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.bottom,
                    inputFormatters: [TextInputMask(mask: '99.99.9999')],
                    controller: birthday,
                    onChanged: (_) => setState(() => allowedToSave = !isEmpty()),
                  ),
                ),
                const GenderSwitch()
              ],
            ),
            const SizedBox(height: 18),
            LoaderButton(
              child: Text(t.next),
              onPressed: allowedToSave
                  ? () async {
                      var currentUser = context.read(currentUserProvider).state;
                      currentUser.birthday = birthday.text;
                      currentUser.age = calcAgeReverse(birthday.text);
                      currentUser.height = int.parse(height.text);
                      currentUser.weight = int.parse(weight.text);
                      currentUser.name = fullname.text;
                      currentUser.gender = context.read(genderProvider).state;
                      await ModalController.saveUser(context, currentUser);
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
