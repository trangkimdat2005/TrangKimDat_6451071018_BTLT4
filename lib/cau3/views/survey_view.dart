import 'package:flutter/material.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});

  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  final Map<String, bool> _interests = {'Phim ảnh (Movies)': true, 'Thể thao (Sports)': false, 'Âm nhạc (Music)': true, 'Du lịch (Travel)': false};
  final Map<String, IconData> _interestIcons = {'Phim ảnh (Movies)': Icons.movie_creation_rounded, 'Thể thao (Sports)': Icons.sports_basketball_rounded, 'Âm nhạc (Music)': Icons.music_note_rounded, 'Du lịch (Travel)': Icons.flight_takeoff_rounded};
  String _satisfactionLevel = 'Bình thường (Neutral)';
  final TextEditingController _notesController = TextEditingController();
  final Color _primaryColor = const Color(0xFF7C3AED); 

  @override
  void dispose() { _notesController.dispose(); super.dispose(); }

  void _submitSurvey() {
    bool hasAtLeastOneInterest = _interests.values.any((isSelected) => isSelected);
    if (!hasAtLeastOneInterest) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Row(children: [Icon(Icons.error_outline_rounded, color: Colors.white, size: 28), SizedBox(width: 12), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [Text('Lỗi Validate', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)), Text('Bạn phải chọn ít nhất 1 sở thích', style: TextStyle(color: Colors.white70))]))]), backgroundColor: Colors.redAccent, behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), margin: const EdgeInsets.all(20)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cảm ơn bạn đã gửi khảo sát!'), backgroundColor: Colors.green));
    }
  }

  Widget _buildSectionTitle(String title, IconData icon) => Padding(padding: const EdgeInsets.only(bottom: 16.0), child: Row(children: [Icon(icon, color: _primaryColor, size: 22), const SizedBox(width: 8), Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87))]));
  Widget _buildCardContainer({required Widget child}) => Container(margin: const EdgeInsets.only(bottom: 24), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 5))]), padding: const EdgeInsets.all(20.0), child: child);
  Widget _buildSatisfactionRadio(String title) => RadioListTile<String>(title: Text(title, style: const TextStyle(fontSize: 15)), value: title, groupValue: _satisfactionLevel, activeColor: _primaryColor, contentPadding: EdgeInsets.zero, onChanged: (value) => setState(() => _satisfactionLevel = value!));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: const Text('Form Khảo Sát', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, foregroundColor: Colors.black87, elevation: 0, centerTitle: true),
      body: Column(
        children: [
          // THANH MSSV
          Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10),
            color: _primaryColor.withOpacity(0.1),
            child: Text('MSSV: 6451071018', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryColor, letterSpacing: 1.2)),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                _buildCardContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildSectionTitle('SỞ THÍCH', Icons.favorite_rounded), ..._interests.keys.map((key) => CheckboxListTile(title: Text(key, style: const TextStyle(fontSize: 15)), secondary: Icon(_interestIcons[key], color: _interests[key]! ? _primaryColor : Colors.grey[400]), value: _interests[key], activeColor: _primaryColor, checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)), contentPadding: EdgeInsets.zero, onChanged: (bool? value) => setState(() => _interests[key] = value ?? false)))])),
                _buildCardContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildSectionTitle('MỨC ĐỘ HÀI LÒNG', Icons.sentiment_satisfied_alt_rounded), _buildSatisfactionRadio('Hài lòng (Satisfied)'), _buildSatisfactionRadio('Bình thường (Neutral)'), _buildSatisfactionRadio('Chưa hài lòng (Unsatisfied)')])),
                _buildCardContainer(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [_buildSectionTitle('GHI CHÚ THÊM', Icons.notes_rounded), TextField(controller: _notesController, maxLines: 4, decoration: InputDecoration(hintText: 'Nhập ghi chú của bạn...', filled: true, fillColor: Colors.grey[50], border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none), enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)), focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: _primaryColor))))])),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _submitSurvey, style: ElevatedButton.styleFrom(backgroundColor: _primaryColor, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4), child: const Text('GỬI KHẢO SÁT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)))),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}