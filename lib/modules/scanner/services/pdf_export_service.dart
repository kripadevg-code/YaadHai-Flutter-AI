import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yaad_hai/core/ai/ai_models.dart';
import 'package:yaad_hai/shared/resources/app_colors.dart';
import 'package:yaad_hai/shared/resources/app_strings.dart';
import 'package:yaad_hai/shared/resources/dimens.dart';

/// Industry-standard PDF generation service using native PDF widgets
/// Benefits: Small file size, text-selectable, searchable, accessible
class PdfExportService {
  /// Helper to convert Flutter Color to PdfColor
  static PdfColor _toPdfColor(Color color) {
    return PdfColor(
      (color.r * 255.0).round().clamp(0, 255) / 255,
      (color.g * 255.0).round().clamp(0, 255) / 255,
      (color.b * 255.0).round().clamp(0, 255) / 255,
    );
  }

  /// Downloads the study pack as a PDF
  Future<void> downloadPdf({required StudyPackResult pack, required String title}) async {
    try {
      final pdfFile = await _generatePdf(pack: pack, title: title);
      await Printing.sharePdf(bytes: await pdfFile.readAsBytes(), filename: '${_sanitizeFilename(title)}.pdf');
    } catch (e) {
      debugPrint('Error downloading PDF: $e');
      rethrow;
    }
  }

  /// Shares the study pack as a PDF via the native share sheet
  Future<void> sharePdf({required StudyPackResult pack, required String title}) async {
    try {
      final pdfFile = await _generatePdf(pack: pack, title: title);
      await SharePlus.instance.share(ShareParams(files: [XFile(pdfFile.path)], subject: title, text: 'Check out my study pack: $title'));
    } catch (e) {
      debugPrint('Error sharing PDF: $e');
      rethrow;
    }
  }

  /// Generates a PDF using native PDF widgets (industry standard approach)
  Future<File> _generatePdf({required StudyPackResult pack, required String title}) async {
    final pdf = pw.Document();

    // Load Google Fonts for better typography
    final font = await PdfGoogleFonts.interRegular();
    final fontBold = await PdfGoogleFonts.interBold();
    final fontMedium = await PdfGoogleFonts.interMedium();

    final theme = pw.ThemeData.withFont(base: font, bold: fontBold);

    // Page 1: Cover & Summary
    pdf.addPage(
      pw.Page(pageFormat: PdfPageFormat.a4, theme: theme, build: (context) => _buildCoverPage(pack, title, fontBold, fontMedium)),
    );

    // Page 2+: Concepts
    pdf.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, theme: theme, build: (context) => _buildConceptsPages(pack, fontBold, font)));

    // Page N: Flashcards
    pdf.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, theme: theme, build: (context) => _buildFlashcardsPages(pack, fontBold, font)));

    // Page N+1: Quiz
    pdf.addPage(pw.MultiPage(pageFormat: PdfPageFormat.a4, theme: theme, build: (context) => _buildQuizPages(pack, fontBold, font)));

    // Save to temporary directory
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${_sanitizeFilename(title)}.pdf');
    await file.writeAsBytes(await pdf.save());

    return file;
  }

  // ─── Cover Page ──────────────────────────────────────────────────────────

  pw.Widget _buildCoverPage(StudyPackResult pack, String title, pw.Font fontBold, pw.Font fontMedium) {
    final pdfPrimary = _toPdfColor(AppColors.pdfPrimary);

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Header
        pw.Container(
          padding: pw.EdgeInsets.all(Dimens.pdfPadding20),
          decoration: pw.BoxDecoration(color: pdfPrimary, borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius12))),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                AppStrings.pdfYaadHaiStudyPack,
                style: pw.TextStyle(font: fontMedium, fontSize: Dimens.pdfFontSize12, color: PdfColors.white),
              ),
              pw.SizedBox(height: Dimens.pdfSpacing8),
              pw.Text(title, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize24, color: PdfColors.white)),
            ],
          ),
        ),

        pw.SizedBox(height: Dimens.pdfSpacing30),

        // Stats
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            _buildStatCard(AppStrings.pdfStatConceptsLabel, pack.concepts.length.toString(), fontBold),
            _buildStatCard(AppStrings.pdfStatFlashcardsLabel, pack.flashcards.length.toString(), fontBold),
            _buildStatCard(AppStrings.pdfStatQuizLabel, pack.quizQuestions.length.toString(), fontBold),
          ],
        ),

        pw.SizedBox(height: Dimens.pdfSpacing30),

        // Summary Section
        pw.Header(
          level: 0,
          text: AppStrings.pdfExecutiveSummaryTitle,
          textStyle: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize18),
        ),
        pw.SizedBox(height: Dimens.pdfSpacing12),
        pw.Text(
          pack.summary,
          style: pw.TextStyle(fontSize: Dimens.pdfFontSize11, lineSpacing: Dimens.pdfLineSpacing1_5),
          textAlign: pw.TextAlign.justify,
        ),

        pw.SizedBox(height: Dimens.pdfSpacing24),

        // Key Points
        if (pack.keyPoints.isNotEmpty) ...[
          pw.Header(level: 1, text: AppStrings.pdfKeyPointsTitle, textStyle: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize16)),
          pw.SizedBox(height: Dimens.pdfSpacing8),
          ...pack.keyPoints.map(
            (point) => pw.Padding(
              padding: pw.EdgeInsets.only(bottom: Dimens.pdfPadding6),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Container(
                    width: Dimens.pdfBulletSize,
                    height: Dimens.pdfBulletSize,
                    margin: pw.EdgeInsets.only(top: Dimens.pdfPadding6, right: Dimens.pdfPadding10),
                    decoration: pw.BoxDecoration(color: pdfPrimary, shape: pw.BoxShape.circle),
                  ),
                  pw.Expanded(
                    child: pw.Text(point, style: pw.TextStyle(fontSize: Dimens.pdfFontSize10, lineSpacing: Dimens.pdfLineSpacing1_4)),
                  ),
                ],
              ),
            ),
          ),
        ],

        pw.Spacer(),

        // Footer
        pw.Divider(color: PdfColors.grey300),
        pw.SizedBox(height: Dimens.pdfSpacing8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Text(
              AppStrings.pdfGeneratedBy,
              style: pw.TextStyle(fontSize: Dimens.pdfFontSize9, color: PdfColors.grey600, font: fontMedium),
            ),
            pw.Text(
              DateTime.now().toString().substring(0, 10),
              style: pw.TextStyle(fontSize: Dimens.pdfFontSize9, color: PdfColors.grey600),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _buildStatCard(String label, String value, pw.Font fontBold) {
    final pdfPrimary = _toPdfColor(AppColors.pdfPrimary);

    return pw.Container(
      width: Dimens.pdfStatCardWidth,
      padding: pw.EdgeInsets.all(Dimens.pdfPadding16),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius8)),
      ),
      child: pw.Column(
        children: [
          pw.Text(value, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize28, color: pdfPrimary)),
          pw.SizedBox(height: Dimens.pdfSpacing4),
          pw.Text(label, style: pw.TextStyle(fontSize: Dimens.pdfFontSize10, color: PdfColors.grey700)),
        ],
      ),
    );
  }

  // ─── Concepts Pages ──────────────────────────────────────────────────────

  List<pw.Widget> _buildConceptsPages(StudyPackResult pack, pw.Font fontBold, pw.Font font) {
    final widgets = <pw.Widget>[
      pw.Header(level: 0, text: AppStrings.pdfConceptsTitle, textStyle: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize20)),
      pw.SizedBox(height: Dimens.pdfSpacing16),
    ];

    for (var i = 0; i < pack.concepts.length; i++) {
      final concept = pack.concepts[i];
      widgets.add(_buildConceptCard(concept, i + 1, fontBold, font));
      widgets.add(pw.SizedBox(height: Dimens.pdfSpacing16));
    }

    return widgets;
  }

  pw.Widget _buildConceptCard(ConceptData concept, int index, pw.Font fontBold, pw.Font font) {
    final pdfPrimary = _toPdfColor(AppColors.pdfPrimary);
    final pdfPrimaryLight = _toPdfColor(AppColors.pdfPrimaryLight);

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius8)),
      ),
      padding: pw.EdgeInsets.all(Dimens.pdfPadding16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Title with number
          pw.Row(
            children: [
              pw.Container(
                width: Dimens.pdfNumberBoxSize,
                height: Dimens.pdfNumberBoxSize,
                alignment: pw.Alignment.center,
                decoration: pw.BoxDecoration(
                  color: pdfPrimaryLight,
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius8)),
                ),
                child: pw.Text(index.toString(), style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize14, color: pdfPrimary)),
              ),
              pw.SizedBox(width: Dimens.pdfSpacing12),
              pw.Expanded(child: pw.Text(concept.title, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize14))),
            ],
          ),

          pw.SizedBox(height: Dimens.pdfSpacing12),

          // Summary
          pw.Text(concept.summary, style: pw.TextStyle(fontSize: Dimens.pdfFontSize10, lineSpacing: Dimens.pdfLineSpacing1_4)),

          // Explanation
          if (concept.detailedExplanation != null && concept.detailedExplanation!.isNotEmpty) ...[
            pw.SizedBox(height: Dimens.pdfSpacing10),
            pw.Text(AppStrings.pdfDetailedExplanation, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize10)),
            pw.SizedBox(height: Dimens.pdfSpacing4),
            pw.Text(
              concept.detailedExplanation!,
              style: pw.TextStyle(fontSize: Dimens.pdfFontSize9, lineSpacing: Dimens.pdfLineSpacing1_4, color: PdfColors.grey800),
            ),
          ],

          // Key Points
          if (concept.keyPoints.isNotEmpty) ...[
            pw.SizedBox(height: Dimens.pdfSpacing10),
            pw.Text(AppStrings.pdfKeyPointsTitle, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize10)),
            pw.SizedBox(height: Dimens.pdfSpacing4),
            ...concept.keyPoints.map(
              (point) => pw.Padding(
                padding: pw.EdgeInsets.only(left: Dimens.pdfPadding8, bottom: Dimens.pdfPadding3),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text('• ', style: pw.TextStyle(fontSize: Dimens.pdfFontSize9)),
                    pw.Expanded(child: pw.Text(point, style: pw.TextStyle(fontSize: Dimens.pdfFontSize9))),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─── Flashcards Pages ────────────────────────────────────────────────────

  List<pw.Widget> _buildFlashcardsPages(StudyPackResult pack, pw.Font fontBold, pw.Font font) {
    final widgets = <pw.Widget>[
      pw.Header(level: 0, text: AppStrings.pdfFlashcardsTitle, textStyle: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize20)),
      pw.SizedBox(height: Dimens.pdfSpacing16),
    ];

    for (var i = 0; i < pack.flashcards.length; i++) {
      final flashcard = pack.flashcards[i];
      widgets.add(_buildFlashcard(flashcard, i + 1, fontBold));
      if (i < pack.flashcards.length - 1) {
        widgets.add(pw.SizedBox(height: Dimens.pdfSpacing12));
      }
    }

    return widgets;
  }

  pw.Widget _buildFlashcard(FlashcardData flashcard, int index, pw.Font fontBold) {
    final pdfPrimary = _toPdfColor(AppColors.pdfPrimary);
    final pdfPrimaryLighter = _toPdfColor(AppColors.pdfPrimaryLighter);

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius8)),
      ),
      child: pw.Column(
        children: [
          // Question side
          pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.all(Dimens.pdfPadding16),
            decoration: pw.BoxDecoration(
              color: pdfPrimaryLighter,
              borderRadius: pw.BorderRadius.only(
                topLeft: pw.Radius.circular(Dimens.pdfRadius8),
                topRight: pw.Radius.circular(Dimens.pdfRadius8),
              ),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Row(
                  children: [
                    pw.Text('Q$index', style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize10, color: pdfPrimary)),
                    pw.SizedBox(width: Dimens.pdfSpacing8),
                    pw.Expanded(
                      child: pw.Text(
                        AppStrings.pdfQuestionLabel,
                        style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize8, color: PdfColors.grey600),
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: Dimens.pdfSpacing8),
                pw.Text(flashcard.question, style: pw.TextStyle(fontSize: Dimens.pdfFontSize11, lineSpacing: Dimens.pdfLineSpacing1_4)),
              ],
            ),
          ),

          // Answer side
          pw.Container(
            width: double.infinity,
            padding: pw.EdgeInsets.all(Dimens.pdfPadding16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  AppStrings.pdfAnswerLabel,
                  style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize8, color: PdfColors.grey600),
                ),
                pw.SizedBox(height: Dimens.pdfPadding6),
                pw.Text(flashcard.answer, style: pw.TextStyle(fontSize: Dimens.pdfFontSize10, lineSpacing: Dimens.pdfLineSpacing1_4)),
                if (flashcard.hint?.isNotEmpty ?? false) ...[
                  pw.SizedBox(height: Dimens.pdfSpacing8),
                  pw.Container(
                    padding: pw.EdgeInsets.all(Dimens.pdfPadding8),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.amber50,
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius6)),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(AppStrings.pdfHintPrefix, style: pw.TextStyle(fontSize: Dimens.pdfFontSize9)),
                        pw.Expanded(child: pw.Text(flashcard.hint!, style: pw.TextStyle(fontSize: Dimens.pdfFontSize9))),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── Quiz Pages ──────────────────────────────────────────────────────────

  List<pw.Widget> _buildQuizPages(StudyPackResult pack, pw.Font fontBold, pw.Font font) {
    final widgets = <pw.Widget>[
      pw.Header(level: 0, text: AppStrings.pdfQuizTitle, textStyle: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize20)),
      pw.SizedBox(height: Dimens.pdfSpacing16),
    ];

    for (var i = 0; i < pack.quizQuestions.length; i++) {
      final question = pack.quizQuestions[i];
      widgets.add(_buildQuizQuestion(question, i + 1, fontBold));
      if (i < pack.quizQuestions.length - 1) {
        widgets.add(pw.SizedBox(height: Dimens.pdfSpacing16));
      }
    }

    return widgets;
  }

  pw.Widget _buildQuizQuestion(QuizQuestionData question, int index, pw.Font fontBold) {
    final pdfPrimary = _toPdfColor(AppColors.pdfPrimary);

    // Build options list
    final options = [question.optionA, question.optionB, question.optionC, question.optionD];

    // Determine correct index (A=0, B=1, C=2, D=3)
    final correctIndex = ['A', 'B', 'C', 'D'].indexOf(question.correctOption.toUpperCase());

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: PdfColors.grey300),
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius8)),
      ),
      padding: pw.EdgeInsets.all(Dimens.pdfPadding16),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          // Question
          pw.Text(
            '${AppStrings.pdfQuestionPrefix}$index',
            style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize10, color: pdfPrimary),
          ),
          pw.SizedBox(height: Dimens.pdfSpacing8),
          pw.Text(
            question.question,
            style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize12, lineSpacing: Dimens.pdfLineSpacing1_4),
          ),

          pw.SizedBox(height: Dimens.pdfSpacing12),

          // Options
          ...options.asMap().entries.map((entry) {
            final optionIndex = entry.key;
            final option = entry.value;
            final isCorrect = optionIndex == correctIndex;
            final optionLetter = String.fromCharCode(65 + optionIndex);

            return pw.Padding(
              padding: pw.EdgeInsets.only(bottom: Dimens.pdfPadding8),
              child: pw.Container(
                padding: pw.EdgeInsets.all(Dimens.pdfPadding10),
                decoration: pw.BoxDecoration(
                  color: isCorrect ? PdfColors.green50 : PdfColors.grey50,
                  border: pw.Border.all(
                    color: isCorrect ? PdfColors.green : PdfColors.grey300,
                    width: isCorrect ? Dimens.pdfBorderWidth2 : Dimens.pdfBorderWidth1,
                  ),
                  borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius6)),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: Dimens.pdfOptionCircleSize,
                      height: Dimens.pdfOptionCircleSize,
                      alignment: pw.Alignment.center,
                      decoration: pw.BoxDecoration(color: isCorrect ? PdfColors.green : PdfColors.grey200, shape: pw.BoxShape.circle),
                      child: pw.Text(
                        optionLetter,
                        style: pw.TextStyle(
                          font: fontBold,
                          fontSize: Dimens.pdfFontSize10,
                          color: isCorrect ? PdfColors.white : PdfColors.grey700,
                        ),
                      ),
                    ),
                    pw.SizedBox(width: Dimens.pdfPadding10),
                    pw.Expanded(child: pw.Text(option, style: pw.TextStyle(fontSize: Dimens.pdfFontSize10))),
                    if (isCorrect)
                      pw.Text(
                        AppStrings.pdfCorrectLabel,
                        style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize9, color: PdfColors.green),
                      ),
                  ],
                ),
              ),
            );
          }),

          // Explanation
          if (question.explanation != null && question.explanation!.isNotEmpty) ...[
            pw.SizedBox(height: Dimens.pdfSpacing10),
            pw.Container(
              padding: pw.EdgeInsets.all(Dimens.pdfPadding12),
              decoration: pw.BoxDecoration(
                color: PdfColors.blue50,
                borderRadius: pw.BorderRadius.all(pw.Radius.circular(Dimens.pdfRadius6)),
              ),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(AppStrings.pdfExplanationTitle, style: pw.TextStyle(font: fontBold, fontSize: Dimens.pdfFontSize9)),
                  pw.SizedBox(height: Dimens.pdfSpacing4),
                  pw.Text(question.explanation!, style: pw.TextStyle(fontSize: Dimens.pdfFontSize9, lineSpacing: Dimens.pdfLineSpacing1_4)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Sanitizes filename by removing invalid characters
  String _sanitizeFilename(String filename) {
    return filename
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .substring(0, filename.length > 50 ? 50 : filename.length);
  }
}
