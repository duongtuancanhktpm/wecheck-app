import 'package:wecheck/theme/theme.dart';
import 'package:wecheck/utils/dialog_helper.dart';
import 'package:flutter/material.dart';

class DropdownField<T> extends StatefulWidget {
  late final DropdownController<T> controller;
  final List<T> options;
  final bool require;
  final String? hint;
  final String? error;

  DropdownField({
    Key? key,
    DropdownController<T>? controller,
    this.options = const [],
    this.require = false,
    this.hint,
    this.error,
  })  : this.controller = controller ?? DropdownController(),
        super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState<T> extends State<DropdownField<T>> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<DropdownValue<T>?>(
      valueListenable: widget.controller,
      builder: (_, value, __) => GestureDetector(
        onTap: onTap,
        child: InputDecorator(
          decoration: InputDecoration(
            suffixIcon: const IconButton(
              onPressed: null,
              icon: Icon(Icons.keyboard_arrow_down_rounded),
            ),
            errorText: value?.error,
          ),
          child: content(value?.value),
        ),
      ),
    );
  }

  Widget content(T? value) {
    if (value == null) return hint;

    return Text(value.toString(), style: AppTextStyle.t14w400());
  }

  Widget get hint {
    return Text(
      widget.hint ?? '',
      style: AppTextStyle.t14w400(AppColors.black),
    );
  }

  void onTap() async {
    var result = await DialogHelper.bottomList(
      options: widget.options,
      selected: widget.controller.selected,
    );

    if (widget.controller.selected == result) {
      widget.controller.selected = null;
    } else {
      widget.controller.selected = result;
    }
  }
}

class DropdownController<T> extends ValueNotifier<DropdownValue<T>?> {
  T? get selected => value?.value;

  set selected(T? value) => super.value = DropdownValue(value);

  String? get error => value?.error;

  set error(String? error) => super.value = super.value?.copyWith(error: error);

  DropdownController([DropdownValue<T>? value]) : super(value);

  bool validate(bool Function(T? value) validator) {
    return validator(selected);
  }
}

class DropdownValue<T> {
  final T? value;
  final String? error;

  DropdownValue(this.value, {this.error});

  DropdownValue<T> copyWith({T? value, String? error}) {
    return DropdownValue(value ?? this.value, error: error);
  }
}
