import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/FoodText.dart';
import '../widget/CartItem.dart';
import '../widget/pdfRecords.dart';
import 'BottomBarNavigatorScreen.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class CartScreen extends StatefulWidget {
  final String categoryName;
  final List<String> subItems;
  const CartScreen({super.key, required this.categoryName, required this.subItems});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _peopleCtrl = TextEditingController();
  final _dateCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _priceCtrl = TextEditingController();
  final _shiftCtrl = TextEditingController();

  Map<String, List<CartItem>> get _groupedItems {
    final map = <String, List<CartItem>>{};
    for (var item in CartData.cartItems) {
      map.putIfAbsent(item.categoryName, () => []).add(item);
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: CartData.cartItems.isEmpty
          ? _buildEmptyState()
          : _buildCartContent(width),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              size: 50,
              color: Color(0xFFFFB347),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'ઓર્ડર ખાલી છે',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2D1600),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Home screen પર જઈ items ઉમેરો',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const Bottombarnavigatorscreen()),
              );
            },
            icon: const Icon(Icons.home_outlined),
            label: const Text('Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C42),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent(double width) {
    final grouped = _groupedItems;
    final totalItems = CartData.cartItems.length;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Order summary card
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF8C42), Color(0xFFFFB347)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8C42).withOpacity(0.35),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Icon(Icons.receipt_long, color: Colors.white, size: 32),
                const SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Selected Items',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      '$totalItems items • ${grouped.length} categories',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Invoice preview card
          _buildInvoicePreview(width),

          const SizedBox(height: 16),

          // Items grouped by category
          ...grouped.entries.map((entry) => _buildCategoryCard(entry.key, entry.value)),

          const SizedBox(height: 16),

          // Fill details button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showDetailsBottomSheet(),
              icon: const Icon(Icons.edit_note),
              label: const Text('Details ભરો & PDF બનાવો'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D1600),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                elevation: 2,
              ),
            ),
          ),

          const SizedBox(height: 10),

          // Clear cart
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    title: const Text('Cart Clear કરો?'),
                    content: const Text('બધા selected items remove થશે.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () async{
                          await CartData.clearCart();
                          setState(() {});
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        child: const Text('Clear', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              label: const Text('Cart Clear કરો', style: TextStyle(color: Colors.red)),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 13),
                side: const BorderSide(color: Colors.red, width: 1.2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvoicePreview(double width) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0B2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.store, color: Color(0xFFFF8C42), size: 20),
              const SizedBox(width: 8),
              const Text(
                title,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF2D1600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            phone_NO,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          const Divider(height: 16, color: Color(0xFFFFE0B2)),

          _previewRow('Name', _nameCtrl.text),
          _previewRow('Date', _dateCtrl.text),
          _previewRow('Phone', _phoneCtrl.text),
          _previewRow('People No', _peopleCtrl.text),
          _previewRow('Shift', _shiftCtrl.text),
          _previewRow('Price', _priceCtrl.text),
          _previewRow('Address', _addressCtrl.text),
        ],
      ),
    );
  }

  Widget _previewRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label :',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Text(
            value.isEmpty ? '—' : value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: value.isEmpty ? Colors.grey.shade300 : const Color(0xFF2D1600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(String category, List<CartItem> items) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFFE0B2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF3E0),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.restaurant_menu, size: 16, color: Color(0xFFFF8C42)),
                const SizedBox(width: 8),
                Text(
                  category,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: Color(0xFF2D1600),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF8C42),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${items.length}',
                    style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),

          // Items
          ...items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            child: Row(
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF4CAF50),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  item.subItem,
                  style: const TextStyle(fontSize: 13, color: Color(0xFF2D1600)),
                ),
              ],
            ),
          )),

          const SizedBox(height: 4),
        ],
      ),
    );
  }

  void _showDetailsBottomSheet() {
    String? errorMessage;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.88,
              decoration: const BoxDecoration(
                color: Color(0xFFFAF7F2),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                children: [
                  // Handle
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  // Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        const Text(
                          'Order Details',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF2D1600),
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),

                  if (errorMessage != null)
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFEBEE),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 16),
                          const SizedBox(width: 8),
                          Text(errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 13)),
                        ],
                      ),
                    ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _buildField(_nameCtrl, 'Name', Icons.person_outline),
                          _buildField(_phoneCtrl, 'Phone Number', Icons.phone_outlined,
                              keyboardType: TextInputType.phone),
                          _buildField(_dateCtrl, 'Date', Icons.calendar_today_outlined),
                          _buildField(_peopleCtrl, 'Number of People', Icons.groups_outlined,
                              keyboardType: TextInputType.number),
                          _buildField(_shiftCtrl, 'Shift', Icons.access_time_outlined),
                          _buildField(_priceCtrl, 'Price (₹)', Icons.currency_rupee,
                              keyboardType: TextInputType.number),
                          _buildField(_addressCtrl, 'Address', Icons.location_on_outlined,
                              maxLines: 2),
                        ],
                      ),
                    ),
                  ),

                  // Save button
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        20, 10, 20, MediaQuery.of(context).viewInsets.bottom + 20),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_nameCtrl.text.isEmpty ||
                              _phoneCtrl.text.isEmpty ||
                              _addressCtrl.text.isEmpty ||
                              _peopleCtrl.text.isEmpty ||
                              _dateCtrl.text.isEmpty ||
                              _priceCtrl.text.isEmpty ||
                              _shiftCtrl.text.isEmpty) {
                            setModalState(() => errorMessage = '* બધા fields ભરવા જરૂરી છે!');
                            return;
                          }
                          setState(() {}); // refresh preview
                          Navigator.pop(context);
                          _showPdfDialog();
                        },
                        icon: const Icon(Icons.picture_as_pdf),
                        label: const Text('PDF Download કરો'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8C42),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildField(
      TextEditingController ctrl,
      String label,
      IconData icon, {
        TextInputType? keyboardType,
        int maxLines = 1,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: ctrl,
        keyboardType: keyboardType,
        maxLines: maxLines,
        style: const TextStyle(fontSize: 14, color: Color(0xFF2D1600)),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 13, color: Colors.grey),
          prefixIcon: Icon(icon, color: const Color(0xFFFF8C42), size: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFE0B2)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFFE0B2)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFFF8C42), width: 1.8),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        ),
      ),
    );
  }

  void _showPdfDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.picture_as_pdf, color: Color(0xFFFF8C42)),
            SizedBox(width: 8),
            Text('PDF Download'),
          ],
        ),
        content: const Text('Invoice PDF download કરવો છો?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final file = await generateCartPdf(
                name: _nameCtrl.text,
                phone: _phoneCtrl.text,
                people: _peopleCtrl.text,
                date: _dateCtrl.text,
                address: _addressCtrl.text,
                price: _priceCtrl.text,
                shift: _shiftCtrl.text,
                groupedItems: _groupedItems,
              );
              if (context.mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('PDF saved: ${file.path}'),
                    backgroundColor: const Color(0xFF2E7D32),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C42),
              foregroundColor: Colors.white,
            ),
            child: const Text('Download'),
          ),
        ],
      ),
    );
  }

  Future<File> generateCartPdf({
    required String name, required String phone, required String people,
    required String date, required String address, required String price,
    required String shift, required Map<String, List<CartItem>> groupedItems,
  }) async {
    final pdf = pw.Document();
    final fontData = await rootBundle.load('assets/text/NotoSansGujarati-Regular.ttf');
    final gujaratiFont = pw.Font.ttf(fontData);
    final gujaratiStyle = pw.TextStyle(font: gujaratiFont, fontSize: 12);
    final gujaratiBold = pw.TextStyle(font: gujaratiFont, fontSize: 13, fontWeight: pw.FontWeight.bold);

    pdf.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(border: pw.Border.all()),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Container(
                  padding: const pw.EdgeInsets.all(10),
                  decoration: pw.BoxDecoration(border: pw.Border.all()),
                  child: pw.Column(
                    children: [
                      pw.Text(title, style: pw.TextStyle(font: gujaratiFont, fontSize: 18, fontWeight: pw.FontWeight.bold)),
                      pw.Text(phone_NO, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 5),
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        pw.Text("Name: $name", style: pw.TextStyle(fontSize: 12)),
                        pw.Text("Date: $date", style: pw.TextStyle(fontSize: 12)),
                      ]),
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        pw.Text("Phone: $phone", style: pw.TextStyle(fontSize: 12)),
                        pw.Text("People No: $people", style: pw.TextStyle(fontSize: 12)),
                      ]),
                      pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
                        pw.Text("Shift: $shift", style: pw.TextStyle(fontSize: 12)),
                        pw.Text("Price: $price", style: pw.TextStyle(fontSize: 12)),
                      ]),
                      pw.Text("Address: $address", style: pw.TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                pw.SizedBox(height: 10),
                ...groupedItems.entries.map((entry) => pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      decoration: pw.BoxDecoration(
                        border: pw.Border.all(color: PdfColors.orange),
                        color: PdfColors.orange50,
                        borderRadius: pw.BorderRadius.circular(4),
                      ),
                      padding: const pw.EdgeInsets.all(5),
                      margin: const pw.EdgeInsets.symmetric(vertical: 4),
                      child: pw.Text(entry.key, style: gujaratiBold),
                    ),
                    ...entry.value.map((item) => pw.Padding(
                      padding: const pw.EdgeInsets.only(left: 10, bottom: 2),
                      child: pw.Text('• ${item.subItem}', style: gujaratiStyle),
                    )),
                    pw.Divider(),
                  ],
                )),
              ],
            ),
          ),
        ],
      ),
    );

    Directory? downloadsDir;
    if (Platform.isAndroid) {
      downloadsDir = Directory("/storage/emulated/0/Download");
    } else {
      downloadsDir = await getApplicationDocumentsDirectory();
    }

    final now = DateTime.now();
    final timestamp = DateFormat('dd-MM-yyyy').format(now);
    final fileName = 'Menu_List_$timestamp.pdf';
    final file = File('${downloadsDir.path}/$fileName');
    await file.writeAsBytes(await pdf.save());

    // ✅ Download history માં save કરો
    await PdfHistoryService.addRecord(
      PdfRecord(
        filePath: file.path,
        fileName: fileName,
        savedAt: DateFormat('dd MMM yyyy').format(now),
      ),
    );

    return file;
  }
}