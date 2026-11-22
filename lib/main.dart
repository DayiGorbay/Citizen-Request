import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'models/citizen_request.dart';
import 'pages/request_form_page.dart';
import 'pages/request_details_page.dart';
import 'services/request_storage.dart';
import 'widgets/request_status_badge.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'درخواست شهروندی',
      locale: const Locale('fa'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('fa')],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B91A3),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
        ),
        cardTheme: const CardThemeData(color: Colors.white),
        fontFamily: 'Vazirmatn',
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<CitizenRequest> _requests = [];
  final RequestStorage _storage = RequestStorage();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    final savedRequests = await _storage.loadRequests();
    if (!mounted) return;
    setState(() {
      _requests
        ..clear()
        ..addAll(savedRequests);
      _isLoading = false;
    });
  }

  Future<void> _openRequestForm() async {
    final request = await Navigator.push<CitizenRequest>(
      context,
      MaterialPageRoute(builder: (_) => const RequestFormPage()),
    );
    if (!mounted || request == null) return;

    setState(() => _requests.insert(0, request));
    await _storage.saveRequests(_requests);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('درخواست با شناسهٔ ${request.id} ثبت شد')),
    );
  }

  Future<void> _editRequest(int index) async {
    final updatedRequest = await Navigator.push<CitizenRequest>(
      context,
      MaterialPageRoute(
        builder: (_) => RequestFormPage(request: _requests[index]),
      ),
    );
    if (!mounted || updatedRequest == null) return;
    setState(() => _requests[index] = updatedRequest);
    await _storage.saveRequests(_requests);
  }

  Future<void> _confirmDelete(int index) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('حذف درخواست'),
        content: Text('درخواست «${_requests[index].title}» حذف شود؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('انصراف'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
    if (!mounted || shouldDelete != true) return;
    setState(() => _requests.removeAt(index));
    await _storage.saveRequests(_requests);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.people,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 15),
            Text(
              'درخواست شهروندی',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _requests.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.archive_outlined, size: 100),
                  SizedBox(height: 20),
                  Text('شما درخواستی ندارید.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _requests.length,
              itemBuilder: (context, index) {
                final request = _requests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    onTap: () {
                      Navigator.push<void>(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RequestDetailsPage(request: request),
                        ),
                      );
                    },
                    leading: const Icon(Icons.assignment_outlined),
                    title: Text(request.title),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Align(
                        alignment: AlignmentDirectional.centerStart,
                        widthFactor: 1,
                        child: RequestStatusBadge(status: request.status),
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          tooltip: 'ویرایش درخواست',
                          onPressed: () => _editRequest(index),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                        SizedBox(width: 15),
                        IconButton(
                          tooltip: 'حذف درخواست',
                          onPressed: () => _confirmDelete(index),
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openRequestForm,
        tooltip: 'ثبت درخواست',
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}
