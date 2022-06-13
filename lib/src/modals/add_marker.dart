import 'package:arcadi/components/modal_body.dart';
import 'package:arcadi/models/account.dart';
import 'package:arcadi/models/dictionary.dart';
import 'package:arcadi/models/search.dart';
import 'package:arcadi/src/localization/source.dart';
import 'package:arcadi/src/providers.dart';
import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../components/custom_input.dart';
import '../../components/loader_button.dart';

import '../theme.dart';

class AddMarker extends StatefulWidget {
  const AddMarker(this.marker, {this.isMarker = true, Key? key}) : super(key: key);
  final Recomended marker;
  final bool isMarker;

  @override
  State<AddMarker> createState() => _AddMarkerState();
}

class _AddMarkerState extends State<AddMarker> {
  TextEditingController _controller = TextEditingController();
  final FocusNode _focus = FocusNode();
  final FocusNode _focus2 = FocusNode();
  bool _enable = true;
  bool _autofocus = true;
  bool _search = true;
  bool _isMarker = true;

  @override
  void initState() {
    if (widget.marker.id != 0) {
      setState(() => _autofocus = false);
      setState(() => _enable = false);
      setState(() => _search = false);
      setState(() => _isMarker = widget.isMarker);

      _focus.requestFocus();
      _controller = TextEditingController(text: widget.marker.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final t = loc(context)!;

    return ModalBody(
      context,
      title: t.add_analysis,
      back: '',
      children: [
        CustomInput(
          icon: Icons.search,
          label: t.choose_analys,
          child: TextField(
            enabled: _enable,
            controller: _controller,
            autofocus: _autofocus,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(hintText: t.start_write),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            autocorrect: false,
            enableSuggestions: false,
            onChanged: (query) {
              final source = context.read(searchProvider).state;
              List<SearchResult> results = [];
              if (query.isNotEmpty) {
                for (final s in source) {
                  if (s.name.toLowerCase().contains(query.toLowerCase())) {
                    results.add(s);
                  }
                }
              } else {
                results = [];
              }
              context.read(currentSearchProvider).state = results;
            },
          ),
        ),
        const SizedBox(height: 16),
        Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomInput(
                  icon: Icons.edit,
                  label: t.value,
                  child: TextField(
                    focusNode: _focus,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(hintText: t.add_value),
                    textInputAction: TextInputAction.done,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(height: 16),
                CustomInput(
                  icon: Icons.calendar_today,
                  label: t.pass_date,
                  child: TextField(
                    focusNode: _focus2,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(hintText: t.hint_date),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputMask(mask: '99.99.9999', reverse: false),
                    ],
                  ),
                ),
              ],
            ),
            if (_search)
              SearchList(
                _controller.text,
                onTap: (res) {
                  setState(() => _autofocus = false);
                  setState(() => _enable = false);
                  setState(() => _search = false);
                  setState(() => _isMarker = res.isMarker);

                  _focus.requestFocus();
                  _controller = TextEditingController(text: res.name);
                },
              ),
            if (!_isMarker) AnalyzesList(),
          ],
        ),
        const SizedBox(height: 16),
        LoaderButton(
          child: Text(t.next),
          onPressed: () {},
        ),
      ],
    );
  }
}

final currentSearchProvider = StateProvider<List<SearchResult>>((_) => []);

class SearchList extends HookWidget {
  const SearchList(this.text, {required this.onTap, Key? key}) : super(key: key);
  final String text;
  final Function(SearchResult res) onTap;

  @override
  Widget build(BuildContext context) {
    final list = useProvider(currentSearchProvider).state;
    return Container(
      height: 145,
      decoration: BoxDecoration(color: bgGrey, borderRadius: BorderRadius.circular(8)),
      child: list.isEmpty
          ? Center(
              child: Text(
                text == "" ? 'Здесь будут\nрезультаты поиска' : 'По запросу "$text"\nничего не найдено',
                textAlign: TextAlign.center,
              ),
            )
          : ListView(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              children: List.generate(list.length, (index) {
                final l = list[index];
                return ListTile(
                  visualDensity: VisualDensity(horizontal: 0, vertical: -3.5),
                  title: Text(l.name),
                  onTap: () => onTap(l),
                );
              }),
            ),
    );
  }
}

final currentAnalysisProvider = StateProvider<List<Marker>>((ref) => []);

class AnalyzesList extends HookWidget {
  const AnalyzesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = useProvider(currentAnalysisProvider).state;
    final theme = Theme.of(context).textTheme;
    final t = loc(context)!;
    return Container(
      height: 145,
      decoration: BoxDecoration(color: bgGrey, borderRadius: BorderRadius.circular(8)),
      child: ListView(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        children: List.generate(list.length, (index) {
          final m = list[index];
          return ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -3.5),
            title: Text(m.name, style: theme.bodyText1),
            trailing: InkWell(
                child: Text(
                  m.value != 0 ? m.value.toString() : t.add,
                  style: theme.headline6!.copyWith(color: primaryBlue),
                ),
                onTap: () => showDialog(
                      context: context,
                      builder: (context) => AddPartAnalysis(m),
                    )),
          );
        }),
      ),
    );
  }
}

class AddPartAnalysis extends StatefulWidget {
  const AddPartAnalysis(this.m, {Key? key}) : super(key: key);
  final Marker m;

  @override
  State<AddPartAnalysis> createState() => _AddPartAnalysisState();
}

class _AddPartAnalysisState extends State<AddPartAnalysis> {
  TextEditingController val = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final t = loc(context)!;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      elevation: 0,
      backgroundColor: Colors.transparent,
      content: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.m.name, style: theme.bodyText1),
            const SizedBox(height: 16),
            CustomInput(
              icon: Icons.edit,
              label: t.value,
              child: TextField(
                controller: val,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(hintText: t.add_value),
                textInputAction: TextInputAction.done,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                autofocus: true,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 0, thickness: 1, color: Color(0xFFF7F7F7)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Text(t.cancel, style: theme.headline6!.copyWith(color: darkGrey)),
                  onTap: () => Navigator.pop(context),
                ),
                InkWell(
                  child: Text(t.add, style: theme.headline6!.copyWith(color: primaryBlue)),
                  onTap: () {
                    if (val.text != "") {
                      var list = context.read(currentAnalysisProvider).state;

                      List<Marker> newList = [];
                      for (var l in list) {
                        if (l.id == widget.m.id) {
                          l.value = int.parse(val.text);
                        }
                        newList.add(l);
                      }

                      context.read(currentAnalysisProvider).state = newList;
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
