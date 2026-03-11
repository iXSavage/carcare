import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/extensions.dart';
import '../data/models/maintenance_task.dart';
import 'maintenance_controller.dart';

class AddMaintenanceDialog extends ConsumerStatefulWidget {
  // Fix #3: Accept existing task for edit mode
  final MaintenanceTask? existing;

  const AddMaintenanceDialog({super.key, this.existing});

  @override
  ConsumerState<AddMaintenanceDialog> createState() =>
      _AddMaintenanceDialogState();
}

class _AddMaintenanceDialogState extends ConsumerState<AddMaintenanceDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _mileageIntervalController;
  late final TextEditingController _monthsIntervalController;
  late final TextEditingController _lastServiceMileageController;

  DateTime? _lastServiceDate;

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final e = widget.existing;
    _nameController = TextEditingController(text: e?.taskName ?? '');
    _mileageIntervalController = TextEditingController(
      text: e?.mileageInterval?.toString() ?? '',
    );
    _monthsIntervalController = TextEditingController(
      text: e?.timeIntervalMonths?.toString() ?? '',
    );
    _lastServiceMileageController = TextEditingController(
      text: e?.lastServiceMileage?.toString() ?? '',
    );
    _lastServiceDate = e?.lastServiceDate;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mileageIntervalController.dispose();
    _monthsIntervalController.dispose();
    _lastServiceMileageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _lastServiceDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _lastServiceDate) {
      setState(() => _lastServiceDate = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    if (_mileageIntervalController.text.isEmpty &&
        _monthsIntervalController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please provide at least one interval trigger (mileage or time)',
          ),
        ),
      );
      return;
    }

    ref
        .read(maintenanceControllerProvider.notifier)
        .saveTask(
          id: widget.existing?.id,
          taskName: _nameController.text.trim(),
          lastServiceDate: _lastServiceDate,
          lastServiceMileage: int.tryParse(
            _lastServiceMileageController.text.trim(),
          ),
          mileageInterval: int.tryParse(_mileageIntervalController.text.trim()),
          timeIntervalMonths: int.tryParse(
            _monthsIntervalController.text.trim(),
          ),
        );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      // Fix #3: Title changes based on edit/add mode
      title: Text(_isEditing ? 'Edit Task' : 'New Maintenance Task'),
      content: SizedBox(
        width: 480,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Task Name *',
                    hintText: 'e.g. Oil Change',
                    prefixIcon: Icon(Icons.build_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),
                Text(
                  'Intervals (When is it due?)',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _mileageIntervalController,
                        decoration: const InputDecoration(
                          labelText: 'Every X Miles',
                          hintText: '5000',
                          prefixIcon: Icon(Icons.speed_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: _monthsIntervalController,
                        decoration: const InputDecoration(
                          labelText: 'Every X Months',
                          hintText: '6',
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Last Performed (Optional)',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _lastServiceMileageController,
                        decoration: const InputDecoration(
                          labelText: 'At Mileage',
                          prefixIcon: Icon(Icons.speed_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        borderRadius: BorderRadius.circular(12),
                        child: InputDecorator(
                          decoration: const InputDecoration(
                            labelText: 'On Date',
                            prefixIcon: Icon(Icons.calendar_month_outlined),
                          ),
                          child: Text(
                            // Fix #4: Use .toShortDate() extension
                            _lastServiceDate != null
                                ? _lastServiceDate!.toShortDate()
                                : 'Select Date',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _lastServiceDate == null
                                  ? theme.colorScheme.onSurfaceVariant
                                  : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
          onPressed: _submit,
          child: Text(_isEditing ? 'Save Changes' : 'Save'),
        ),
      ],
    );
  }
}
