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
import 'modal_controller.dart';

class AddRelative extends StatefulWidget {
  const AddRelative({Key? key}) : super(key: key);

  @override
  State<AddRelative> createState() => _AddRelativeState();
}

class _AddRelativeState extends State<AddRelative> {
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
  Widget build(BuildContext context) {
    final t = loc(context)!;
    return ModalBody(
      context,
      title: t.add_your_data,
      back: '',
      children: [
        ListView(
          shrinkWrap: true,
          children: [
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
                      var currentUser = User();
                      currentUser.birthday = birthday.text;
                      currentUser.age = calcAgeReverse(birthday.text);
                      currentUser.height = int.parse(height.text);
                      currentUser.weight = int.parse(weight.text);
                      currentUser.name = fullname.text;

                      currentUser.gender = context.read(genderProvider).state;
                      await ModalController.saveUser(context, currentUser, addToList: true);
                    }
                  : null,
            ),
          ],
        ),
      ],
    );
  }
}
