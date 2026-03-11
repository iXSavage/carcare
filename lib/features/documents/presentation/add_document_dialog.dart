import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/document_reminder.dart';
import 'documents_controller.dart';

class AddDocumentDialog extends ConsumerStatefulWidget {
  final DocumentReminder? existing; // Pass to pre-fill for editing

  const AddDocumentDialog({super.key, this.existing});

  @override
  ConsumerState<AddDocumentDialog> createState() => _AddDocumentDialogState();
}

class _AddDocumentDialogState extends ConsumerState<AddDocumentDialog> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _typeController;
  late final TextEditingController _titleController;
  late final TextEditingController _authorityController;
  late final TextEditingController _notesController;

  DateTime? _expiryDate;
  DateTime? _issueDate;
  List<bool> _offsetsSelected = [true, true, true]; // 30d, 7d, 0d
  static const _offsetValues = [30, 7, 0];
  static const _offsetLabels = ['30 days', '7 days', 'Same day'];

  bool get _isEditing => widget.existing != null;

  @override
  void initState() {
    super.initState();
    final doc = widget.existing;
    _typeController = TextEditingController(text: doc?.documentType ?? '');
    _titleController = TextEditingController(text: doc?.documentTitle ?? '');
    _authorityController = TextEditingController(
      text: doc?.issuingAuthority ?? '',
    );
    _notesController = TextEditingController(text: doc?.notes ?? '');
    _expiryDate = doc?.expiryDate;
    _issueDate = doc?.issueDate;
    if (doc != null) {
      _offsetsSelected = _offsetValues
          .map((v) => doc.reminderOffsets.contains(v))
          .toList();
    }
  }

  @override
  void dispose() {
    _typeController.dispose();
    _titleController.dispose();
    _authorityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context, {required bool isExpiry}) async {
    final initial = isExpiry
        ? (_expiryDate ?? DateTime.now().add(const Duration(days: 365)))
        : (_issueDate ?? DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isExpiry) {
          _expiryDate = picked;
        } else {
          _issueDate = picked;
        }
      });
    }
  }

  String _fmtDate(DateTime? d) {
    if (d == null) return 'Select date';
    return '${d.month.toString().padLeft(2, '0')}/${d.day.toString().padLeft(2, '0')}/${d.year}';
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    if (_expiryDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an expiry date')),
      );
      return;
    }

    final selectedOffsets = <int>[];
    for (int i = 0; i < _offsetValues.length; i++) {
      if (_offsetsSelected[i]) selectedOffsets.add(_offsetValues[i]);
    }

    await ref
        .read(documentsControllerProvider.notifier)
        .saveDocument(
          id: widget.existing?.id,
          documentType: _typeController.text.trim(),
          documentTitle: _titleController.text.trim(),
          expiryDate: _expiryDate!,
          issueDate: _issueDate,
          issuingAuthority: _authorityController.text.trim().isEmpty
              ? null
              : _authorityController.text.trim(),
          notes: _notesController.text.trim().isEmpty
              ? null
              : _notesController.text.trim(),
          reminderOffsets: selectedOffsets.isEmpty ? [7] : selectedOffsets,
        );

    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Document' : 'Add Document'),
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: SizedBox(
        width: 480, // Comfortable on tablets
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // — Document type
                TextFormField(
                  controller: _typeController,
                  decoration: const InputDecoration(
                    labelText: 'Document Type *',
                    hintText: 'e.g. Insurance, Registration, MOT',
                    prefixIcon: Icon(Icons.folder_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                // — Document title
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Document Title *',
                    hintText: 'e.g. Geico Auto Policy 2026',
                    prefixIcon: Icon(Icons.label_outlined),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 12),
                // — Issuing Authority
                TextFormField(
                  controller: _authorityController,
                  decoration: const InputDecoration(
                    labelText: 'Issuing Authority',
                    hintText: 'e.g. DMV, Geico',
                    prefixIcon: Icon(Icons.account_balance_outlined),
                  ),
                  textCapitalization: TextCapitalization.words,
                ),
                const SizedBox(height: 16),
                // — Dates row
                Row(
                  children: [
                    Expanded(
                      child: _DatePickerField(
                        label: 'Issue Date',
                        value: _fmtDate(_issueDate),
                        onTap: () => _pickDate(context, isExpiry: false),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _DatePickerField(
                        label: 'Expiry Date *',
                        value: _fmtDate(_expiryDate),
                        onTap: () => _pickDate(context, isExpiry: true),
                        isRequired: _expiryDate == null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // — Reminder Offsets
                Text(
                  'Remind me before expiry',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                ToggleButtons(
                  isSelected: _offsetsSelected,
                  onPressed: (i) => setState(
                    () => _offsetsSelected[i] = !_offsetsSelected[i],
                  ),
                  borderRadius: BorderRadius.circular(8),
                  children: _offsetLabels
                      .map(
                        (l) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(l),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                // — Notes
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    hintText: 'Policy number, contact info…',
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
          onPressed: _submit,
          child: Text(_isEditing ? 'Save Changes' : 'Add Document'),
        ),
      ],
    );
  }
}

// --- Helper widget ---
class _DatePickerField extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback onTap;
  final bool isRequired;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onTap,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final unset = value == 'Select date';
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            Icons.calendar_month_outlined,
            color: isRequired ? theme.colorScheme.error : null,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isRequired
                  ? theme.colorScheme.error
                  : theme.colorScheme.outline,
            ),
          ),
        ),
        child: Text(
          value,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: unset ? theme.colorScheme.onSurfaceVariant : null,
          ),
        ),
      ),
    );
  }
}
