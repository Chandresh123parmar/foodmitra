import 'dart:io';
import 'package:flutter/material.dart';
import '../widget/pdfRecords.dart';
import 'package:open_filex/open_filex.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  List<PdfRecord> _records = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  Future<void> _loadRecords() async {
    final list = await PdfHistoryService.loadAll();
    setState(() {
      _records = list;
      _isLoading = false;
    });
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('બધી Files Delete કરો?'),
        content: const Text('બધી downloaded PDFs delete થઈ જશે.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Delete All'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    // સૌ files delete
    for (final r in _records) {
      final f = File(r.filePath);
      if (await f.exists()) await f.delete();
    }
    await PdfHistoryService.clearAll();
    setState(() => _records.clear());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: Column(
          children: [
            const Text(
              'Downloads',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: Color(0xFF2D1600),
              ),
            ),
            if (_records.isNotEmpty)
              Text(
                '${_records.length} PDF files',
                style: const TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.normal),
              ),
          ],
        ),
        actions: [
          if (_records.isNotEmpty)
            PopupMenuButton(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
              onSelected: (value) {
                if (value == 'DeleteAll') _clearAll();
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'DeleteAll',
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep, color: Color(0xFFE53935), size: 20),
                      SizedBox(width: 8),
                      Text('Clear all', style: TextStyle(color: Color(0xFFE53935))),
                    ],
                  ),
                ),
              ],
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFFFE0B2)),
        ),
      ),
      body: _isLoading
          ? const Center(
        child: CircularProgressIndicator(color: Color(0xFFFF8C42)),
      )
          : _records.isEmpty
          ? _buildEmptyState()
          : _buildList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFFFF3E0),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.folder_open_outlined, size: 48, color: Color(0xFFFFB347)),
          ),
          const SizedBox(height: 16),
          const Text(
            'કોઈ PDF નથી',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF2D1600)),
          ),
          const SizedBox(height: 6),
          Text(
            'Cart screen માંથી PDF generate કરો',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  Widget _buildList() {
    return ListView.separated(
      padding: const EdgeInsets.all(14),
      itemCount: _records.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final record = _records[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFFFE0B2), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            onTap: () async {
              final file = File(record.filePath);

              if (await file.exists()) {
                await OpenFilex.open(record.filePath);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('File મળતી નથી'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            leading: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFFFF3E0),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.picture_as_pdf, color: Color(0xFFFF8C42), size: 26),
            ),
            title: Text(
              record.fileName,
              style: const TextStyle(
                fontSize: 13.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2D1600),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                record.savedAt,
                style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
              ),
            ),
          ),
        );
      },
    );
  }
}