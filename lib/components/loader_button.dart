import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoaderButton extends StatefulWidget {
  const LoaderButton({this.onPressed, required this.child, Key? key}) : super(key: key);
  final Function()? onPressed;
  final Widget child;
  @override
  _LoaderButtonState createState() => _LoaderButtonState();
}

class _LoaderButtonState extends State<LoaderButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading || widget.onPressed == null
          ? null
          : () async {
              if (mounted) setState(() => loading = true);
              await widget.onPressed!();
              if (mounted) setState(() => loading = false);
            },
      child: loading ? const CupertinoActivityIndicator() : widget.child,
    );
  }
}
