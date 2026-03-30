import 'package:flutter/material.dart';

class PersonalInfoView extends StatefulWidget {
  const PersonalInfoView({super.key});

  @override
  State<PersonalInfoView> createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _selectedGender = 'Nam';
  String _maritalStatus = 'Kết hôn';
  double _incomeLevel = 15.0;
  final Color _primaryColor = const Color(0xFF2563EB); 

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label, labelStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: _primaryColor), filled: true, fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: _primaryColor, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Thông Tin Cá Nhân', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, foregroundColor: Colors.black87, elevation: 0, centerTitle: true,
      ),
      body: Column(
        children: [
          // THANH MSSV
          Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 10),
            color: _primaryColor.withOpacity(0.1),
            child: Text('MSSV: 6451071018', textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryColor, letterSpacing: 1.2)),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))]),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(controller: _nameController, decoration: _buildInputDecoration(label: 'Họ và tên', icon: Icons.person_rounded), validator: (value) => (value == null || value.trim().isEmpty) ? 'Vui lòng nhập họ và tên' : null),
                      const SizedBox(height: 16),
                      TextFormField(controller: _ageController, keyboardType: TextInputType.number, decoration: _buildInputDecoration(label: 'Tuổi', icon: Icons.cake_rounded), validator: (value) { if (value == null || value.trim().isEmpty) return 'Vui lòng nhập tuổi'; if ((int.tryParse(value) ?? 0) <= 0) return 'Tuổi phải lớn hơn 0'; return null; }),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(value: _selectedGender, icon: Icon(Icons.keyboard_arrow_down_rounded, color: _primaryColor), decoration: _buildInputDecoration(label: 'Giới tính', icon: Icons.wc_rounded), items: ['Nam', 'Nữ', 'Khác'].map((label) => DropdownMenuItem(value: label, child: Text(label))).toList(), onChanged: (value) => setState(() => _selectedGender = value!)),
                      const SizedBox(height: 24),
                      Text('Tình trạng hôn nhân', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 15)),
                      const SizedBox(height: 8),
                      Wrap(spacing: 12, children: ['Độc thân', 'Kết hôn', 'Ly hôn'].map((status) { return ChoiceChip(label: Text(status), selected: _maritalStatus == status, selectedColor: _primaryColor.withOpacity(0.1), labelStyle: TextStyle(color: _maritalStatus == status ? _primaryColor : Colors.black87, fontWeight: _maritalStatus == status ? FontWeight.bold : FontWeight.normal), side: BorderSide(color: _maritalStatus == status ? _primaryColor : Colors.grey.shade300), onSelected: (selected) { if (selected) setState(() => _maritalStatus = status); }); }).toList()),
                      const SizedBox(height: 24),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Mức thu nhập', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 15)), Text('${_incomeLevel.toInt()} tr VND', style: TextStyle(color: _primaryColor, fontWeight: FontWeight.bold, fontSize: 16))]),
                      Slider(value: _incomeLevel, min: 0, max: 20, divisions: 20, activeColor: _primaryColor, inactiveColor: _primaryColor.withOpacity(0.2), onChanged: (value) => setState(() => _incomeLevel = value)),
                      const SizedBox(height: 32),
                      SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: () { if (_formKey.currentState!.validate()) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Đã lưu thông tin!'), backgroundColor: Colors.green)); } }, icon: const Icon(Icons.save_rounded, color: Colors.white), label: const Text('LƯU HỒ SƠ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)), style: ElevatedButton.styleFrom(backgroundColor: _primaryColor, padding: const EdgeInsets.symmetric(vertical: 18), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)), elevation: 4))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}