import 'package:flutter/material.dart';

class RadioButtonFormField<T> extends FormField<T> {
  /// Creates a [RadioButtonFormField] which extends a [FormField].
  ///
  /// When using without a Form ancestor, a [GlobalKey] is required.
  ///
  RadioButtonFormField(
      {Key? key,
      required this.data,
      required this.value,
      required this.display,
      this.onValueChanged,
      this.mouseCursor,
      this.toggleable = false,
      this.activeColor,
      this.focusColor,
      this.hoverColor,
      this.tileColor,
      this.selectedTileColor,
      this.materialTapTargetSize,
      this.visualDensity,
      this.focusNode,
      this.autoFocus = false,
      this.shape,
      this.padding,
      FormFieldSetter? onSaved,
      FormFieldValidator? validator,
      bool autoValidate = false,
      this.titleStyle})
      : super(
            key: key,
            validator: validator,
            onSaved: onSaved,
            builder: (FormFieldState<T> field) {
              final _RadioFormFieldState<T> state =
                  field as _RadioFormFieldState<T>;
              void onChangedHandler(T? value) {
                state.didChange(value);
              }

              return UnmanagedRestorationScope(
                bucket: state.bucket,
                child: Column(
                  children: [
                    ListView.builder(
                      padding: padding,
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Radio<T>(
                            value: data[index][value],
                            groupValue: state.value,
                            activeColor: activeColor,
                            autofocus: autoFocus,
                            focusColor: focusColor,
                            focusNode: focusNode,
                            hoverColor: hoverColor,
                            materialTapTargetSize: materialTapTargetSize,
                            mouseCursor: mouseCursor,
                            onChanged: onChangedHandler,
                            toggleable: toggleable,
                            visualDensity: visualDensity,
                          ),
                          title: Text(
                            data[index][display],
                            style: titleStyle ??
                                const TextStyle(color: Colors.black),
                          ),
                          onTap: () {
                            if (toggleable) {
                              if (state.value != data[index][value]) {
                                state.didChange(data[index][value]);
                              } else {
                                state.didChange(null);
                              }
                            } else {
                              state.didChange(data[index][value]);
                            }
                          },
                        );
                      },
                    ),
                    if (state.hasError && state.errorText != null)
                      Text(state.errorText!)
                  ],
                ),
              );
            });

  /// This is the data used to construct the [RadioButtonFormField].
  ///
  /// Each [Map] in the [List] must contain a value and for the [Radio] and a display for the title of the [ListTile].
  final List<Map> data;

  /// This is the function used to get the [RadioButtonFormField] value.
  final ValueChanged<T?>? onValueChanged;

  /// This is the key which corresponds to the value of the [Radio] widget.
  ///
  /// For example, if the Map contains "value": 1, then this would be "value"
  final String value;

  /// This is the key which corresponds to the title of the [ListTile] widget.
  ///
  /// For example, if the Map contains "display": "One", then this would be "display"
  final String display;

  /// The cursor for a mouse pointer when it enters or is hovering over a [Radio] widget.
  final MouseCursor? mouseCursor;

  /// Set to true if the radio buttons are allowed to be returned to an indeterminate state by selecting it again when selected.
  final bool toggleable;

  /// The color to use when a radio button is selected.
  final Color? activeColor;

  /// The color for the radio's [Material] when it has the input focus.
  final Color? focusColor;

  /// The color for the radio's [Material] when a pointer is hovering over it.
  final Color? hoverColor;

  /// Defines the background color of the [ListTile]s when selected is false.
  final Color? tileColor;

  /// Defines the background color of the [ListTile]s when selected is true.
  final Color? selectedTileColor;

  /// Configures the minimum size of the tap target.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// Defines how compact the radio's layout will be.
  final VisualDensity? visualDensity;

  /// An optional focus node to use as the focus node for this widget.
  final FocusNode? focusNode;

  /// True if this widget will be selected as the initial focus when no other node in its scope is currently focused.
  final bool autoFocus;

  /// The [TextStyle] of the title of each [ListTile].
  final TextStyle? titleStyle;

  /// The shape of the tile's [InkWell].
  final ShapeBorder? shape;

  /// The padding of the widgets.
  final EdgeInsetsGeometry? padding;

  @override
  FormFieldState<T> createState() => _RadioFormFieldState<T>();
}

class _RadioFormFieldState<T> extends FormFieldState<T> {
  @override
  RadioButtonFormField<T> get widget => super.widget as RadioButtonFormField<T>;

  @override
  void didChange(T? value) {
    super.didChange(value);
    if (widget.onValueChanged != null) {
      widget.onValueChanged!(value);
    }
  }
}
