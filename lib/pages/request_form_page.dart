import 'package:flutter/material.dart';
import 'package:citizen_request/models/citizen_request.dart';
import 'package:citizen_request/widgets/request_priority_chip.dart';

class RequestFormPage extends StatefulWidget {
  const RequestFormPage({super.key, this.request});

  final CitizenRequest? request;

  @override
  State<RequestFormPage> createState() => _RequestFormPageState();
}

class _RequestFormPageState extends State<RequestFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();

  String? _category;
  String? _priority;

  final _categories = const ['عمرانی', 'خدمات شهری', 'فضای سبز', 'سایر'];
  final _priorities = const ['کم', 'متوسط', 'زیاد'];

  @override
  void initState() {
    super.initState();
    final request = widget.request;
    if (request != null) {
      _titleController.text = request.title;
      _descriptionController.text = request.description;
      _addressController.text = request.address;
      _category = request.category;
      _priority = request.priority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    if (_category == null || _priority == null) return;

    final request = CitizenRequest(
      id: widget.request?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      category: _category!,
      description: _descriptionController.text.trim(),
      address: _addressController.text.trim(),
      priority: _priority!,
      status: widget.request?.status ?? 'ثبت شده',
    );

    Navigator.pop(context, request);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ثبت درخواست'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 18),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Text(
                      'برای رسیدگی سریع‌تر، عنوان و نشانی را دقیق وارد کنید و مشکل را در بخش توضیحات شرح دهید.',
                    ),
                  ),
                ],
              ),
            ),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'عنوان',
                border: OutlineInputBorder(),
              ),
              validator: (value) =>
                  value == null || value.trim().isEmpty ? 'عنوان را وارد کنید' : null,
            ),

            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'دسته‌بندی',
                border: OutlineInputBorder(),
              ),
              items: _categories
                  .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                  .toList(),
              onChanged: (value) => setState(() => _category = value),
              validator: (value) => value == null ? 'دسته‌بندی را انتخاب کنید' : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'توضیحات',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'توضیحات را وارد کنید'
                  : null,
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(
                labelText: 'نشانی متنی',
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.trim().isEmpty
                  ? 'نشانی را وارد کنید'
                  : null,
            ),

            const SizedBox(height: 16),

            FormField<String>(
              initialValue: _priority,
              validator: (value) => value == null ? 'اولویت را انتخاب کنید' : null,
              builder: (field) => InputDecorator(
                decoration: InputDecoration(
                  labelText: 'اولویت',
                  errorText: field.errorText,
                ),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: _priorities.map((priority) {
                    return RequestPriorityChip(
                      label: priority,
                      isSelected: _priority == priority,
                      onTap: () {
                        setState(() => _priority = priority);
                        field.didChange(priority);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: _submit,
              style: FilledButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
              ),
              child: const Text('ثبت درخواست'),
            ),

          ],
        ),
      ),
    );
  }
}
