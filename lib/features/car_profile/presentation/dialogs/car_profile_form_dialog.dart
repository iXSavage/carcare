import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/car_providers.dart';
import '../../data/models/car.dart';
import '../../data/repositories/car_repository.dart';

/// Shows the car profile add/edit dialog. Can be called from any screen.
void showCarProfileFormDialog(BuildContext context, {Car? car}) {
  showDialog(
    context: context,
    builder: (_) => CarProfileFormDialog(car: car),
  );
}

class CarProfileFormDialog extends ConsumerStatefulWidget {
  final Car? car;

  const CarProfileFormDialog({super.key, this.car});

  @override
  ConsumerState<CarProfileFormDialog> createState() =>
      _CarProfileFormDialogState();
}

class _CarProfileFormDialogState extends ConsumerState<CarProfileFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late String _make;
  late String _model;
  late int _year;
  late int _mileage;
  String? _licensePlate;
  String? _vin;

  @override
  void initState() {
    super.initState();
    _make = widget.car?.make ?? '';
    _model = widget.car?.model ?? '';
    _year = widget.car?.year ?? DateTime.now().year;
    _mileage = widget.car?.currentMileage ?? 0;
    _licensePlate = widget.car?.licensePlate;
    _vin = widget.car?.vin;
  }

  void _save(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final repo = ref.read(carRepositoryProvider);

      try {
        if (widget.car == null) {
          final newCar = Car()
            ..make = _make
            ..model = _model
            ..year = _year
            ..currentMileage = _mileage
            ..licensePlate = _licensePlate
            ..vin = _vin;

          await repo.saveCar(newCar);
        } else {
          final updatedCar = widget.car!
            ..make = _make
            ..model = _model
            ..year = _year
            ..currentMileage = _mileage
            ..licensePlate = _licensePlate
            ..vin = _vin;
          await repo.saveCar(updatedCar);
        }

        ref.invalidate(currentCarProvider);

        if (context.mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(milliseconds: 500),
              content: Text(
                widget.car == null
                    ? 'Car added successfully'
                    : 'Car updated successfully',
              ),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error saving car: ${e.toString()}')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.car == null ? 'Add Car' : 'Edit Car'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: _make,
                autofocus: widget.car == null,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Make * (e.g., Toyota)',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => _make = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _model,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Model * (e.g., Camry)',
                ),
                validator: (val) =>
                    val == null || val.isEmpty ? 'Required' : null,
                onSaved: (val) => _model = val!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _year.toString(),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'Year *'),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  final parsed = int.tryParse(val);
                  if (parsed == null ||
                      parsed < 1900 ||
                      parsed > DateTime.now().year + 1) {
                    return 'Invalid year';
                  }
                  return null;
                },
                onSaved: (val) => _year = int.parse(val!),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _mileage.toString(),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Current Mileage *',
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (int.tryParse(val) == null) return 'Must be a number';
                  return null;
                },
                onSaved: (val) => _mileage = int.parse(val!),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Text('Optional', style: Theme.of(context).textTheme.labelSmall),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: _licensePlate,
                decoration: const InputDecoration(labelText: 'License Plate'),
                onSaved: (val) =>
                    _licensePlate = val?.isEmpty == true ? null : val,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _vin,
                decoration: const InputDecoration(labelText: 'VIN'),
                onSaved: (val) => _vin = val?.isEmpty == true ? null : val,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => _save(context),
          child: const Text('Save'),
        ),
      ],
    );
  }
}
