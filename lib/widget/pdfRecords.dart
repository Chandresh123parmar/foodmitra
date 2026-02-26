import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PdfRecord {
  final String filePath;
  final String fileName;
  final String savedAt; // display date-time

  PdfRecord({
    required this.filePath,
    required this.fileName,
    required this.savedAt,
  });

  Map<String, dynamic> toJson() => {
    'filePath': filePath,
    'fileName': fileName,
    'savedAt': savedAt,
  };

  factory PdfRecord.fromJson(Map<String, dynamic> json) => PdfRecord(
    filePath: json['filePath'],
    fileName: json['fileName'],
    savedAt: json['savedAt'],
  );
}

class PdfHistoryService {
  static const _key = 'pdf_history';

  /// બધા saved PDF records load કરો
  static Future<List<PdfRecord>> loadAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return [];
    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => PdfRecord.fromJson(e)).toList();
  }

  /// નવો PDF record save કરો
  static Future<void> addRecord(PdfRecord record) async {
    final list = await loadAll();
    list.insert(0, record); // latest first
    await _saveAll(list);
  }

  /// બધા records delete કરો
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }

  static Future<void> _saveAll(List<PdfRecord> list) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(list.map((e) => e.toJson()).toList());
    await prefs.setString(_key, jsonString);
  }
}