import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';


class BirthdayWidget extends StatefulWidget {

  final DateTime birthday;
  final ValueChanged<DateTime> onChangedBirthday;

 const BirthdayWidget({
    Key? key,
    required this.birthday,
    required this.onChangedBirthday,
}): super(key: key);


 @override
  State<StatefulWidget> createState() => _BirthdayWidgetState();

}



class _BirthdayWidgetState  extends State<BirthdayWidget> {
      final controller = TextEditingController();
      final focusNode = FocusNode();

      @override
  void initState() {
    super.initState();
    setDate();
  }

  void setDate() => setState(() {
      controller.text = widget.birthday == null
          ? ''
          : DateFormat?.yMd().format(widget.birthday);
  });

  @override
  void didUpdateWidget(covariant BirthdayWidget oldWidget) {

    super.didUpdateWidget(oldWidget);
    setDate();
  }

  @override
  Widget build(BuildContext context) {
    return FocusBuilder(
        focusNode: focusNode,
        builder: (hasFocus) => TextFormField(
          controller: controller,
          validator: (value) => value!.isEmpty ? 'Is Required': null,
          decoration: const InputDecoration(
              prefixText: ' ',
            hintText: 'Your birthday',
            prefixIcon: Icon(Icons.calendar_today_rounded),
            border: OutlineInputBorder(),
          ),
        ),
        onChangedVisibility: (isVisible) {
          if(isVisible) {
            selectDate(context);

          } else {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        }
    );
  }

  Future selectDate(BuildContext context) async{
        final birthday = await showDatePicker(
            context: context,
            initialDate: widget.birthday,
            firstDate: DateTime(1950),
            lastDate: DateTime(2100));

        if(birthday == null) return;

        widget.onChangedBirthday(birthday);

  }

}

class FocusBuilder extends StatefulWidget {
    final FocusNode focusNode;
    final Widget Function(bool hasFocus) builder;
    final ValueChanged<bool> onChangedVisibility;

    const FocusBuilder({
      required this.focusNode,
      required this.builder,
      required this.onChangedVisibility,
      Key? key,
}): super(key: key);



  @override
  State<StatefulWidget> createState() => _FocusBuilderState();


}


class _FocusBuilderState extends State<FocusBuilder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => widget.onChangedVisibility(true),
      child: Focus(
        focusNode: widget.focusNode,
      onFocusChange: widget.onChangedVisibility,
      child: widget.builder(widget.focusNode.hasFocus),
      )
    );
  }


}