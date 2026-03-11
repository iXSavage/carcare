import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/extensions.dart';
import '../../../core/settings/app_settings.dart';
import '../../../core/settings/settings_provider.dart';
import '../data/models/service_log.dart';
import 'service_history_controller.dart';

class AddServiceLogDialog extends ConsumerStatefulWidget {
  final ServiceLog? existing;

  const AddServiceLogDialog({super.key, this.existing});

  @override
  ConsumerState<AddServiceLogDialog> createState() =>
      _AddServiceLogDialogState();
}

class _AddServiceLogDialogState extends ConsumerState<AddServiceLogDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _providerController;
  late final TextEditingController _costController;
  late final TextEditingController _mileageController;
  late final TextEditingController _notesController;

  DateTime _serviceDate = DateTime.now();
  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameController = TextEditingController(text: e?.serviceName ?? '');
    _providerController = TextEditingController(text: e?.provider ?? '');
    _costController = TextEditingController(
      text: e?.cost?.toStringAsFixed(2) ?? '',
    );
    _mileageController = TextEditingController(
      text: e?.mileageAtService?.toString() ?? '',
    );
    _notesController = TextEditingController(text: e?.notes ?? '');
    if (e != null) _serviceDate = e.serviceDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _providerController.dispose();
    _costController.dispose();
    _mileageController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _serviceDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _serviceDate = picked);
  }

  // Date formatting handled by DateFormatting extension (core/utils/extensions.dart)

  bool _saving = false;

  Future<void> _submit() async {
    if (_saving) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    await ref
        .read(serviceHistoryControllerProvider.notifier)
        .saveLog(
          id: widget.existing?.id,
          serviceName: _nameController.text.trim(),
          serviceDate: _serviceDate,
          mileageAtService: int.tryParse(_mileageController.text.trim()),
          provider: _providerController.text.trim().isEmpty
              ? null
              : _providerController.text.trim(),
          cost: double.tryParse(_costController.text.trim()),
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings =
        ref.watch(settingsNotifierProvider).valueOrNull ?? const AppSettings();
    final currencySymbol = settings.currencySymbol;
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Service Record' : 'Log Service'),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Service name
                TextFormField(
                  controller: _nameController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Service Name *',
                    hintText: 'e.g. Oil Change, Brake Pads',
                    prefixIcon: Icon(Icons.build_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                // Provider
                TextFormField(
                  controller: _providerController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Provider',
                    hintText: "e.g. Bob's Auto, DIY",
                    prefixIcon: Icon(Icons.store_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                // Date + Mileage row
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => _pickDate(context),
                        borderRadius: BorderRadius.circular(12),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'Date',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                          ),
                          child: Text(
                            _serviceDate.toShortDate(),
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _mileageController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          labelText: 'Mileage',
                          prefixIcon: Icon(Icons.speed_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Cost
                TextFormField(
                  controller: _costController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Cost',
                    hintText: '0.00',
                    prefixText: currencySymbol,
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                  ],
                  validator: (v) {
                    if (v != null &&
                        v.isNotEmpty &&
                        double.tryParse(v) == null) {
                      return 'Enter a valid number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                // Notes
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Parts, warranty info, next steps…',
                    prefixIcon: Icon(Icons.notes_outlined),
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _saving ? null : _submit,
          child: _saving
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(_isEditing ? 'Save Changes' : 'Log Service'),
        ),
      ],
    );
  }
}
