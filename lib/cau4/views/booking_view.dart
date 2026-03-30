import 'package:flutter/material.dart';

class BookingView extends StatefulWidget {
  const BookingView({super.key});

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String? _selectedService;
  DateTime? _selectedDate;
  final Color _primaryColor = const Color(0xFF4F46E5);

  InputDecoration _buildInputDecoration({required String label, required IconData icon}) {
    return InputDecoration(
      labelText: label, labelStyle: TextStyle(color: Colors.grey[600]), prefixIcon: Icon(icon, color: _primaryColor),
      filled: true, fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: _primaryColor, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      errorStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  void dispose() { _dateController.dispose(); _timeController.dispose(); super.dispose(); }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2100), builder: (context, child) => Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: _primaryColor, onPrimary: Colors.white, onSurface: Colors.black87)), child: child ?? const SizedBox()));
    if (picked != null) {
      setState(() { _selectedDate = picked; _dateController.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}"; });
      _formKey.currentState?.validate();
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: TimeOfDay.now(), builder: (context, child) => Theme(data: ThemeData.light().copyWith(colorScheme: ColorScheme.light(primary: _primaryColor)), child: child ?? const SizedBox()));
    if (picked != null) setState(() => _timeController.text = picked.format(context));
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: const Row(children: [Icon(Icons.check_circle, color: Colors.white), SizedBox(width: 8), Text('Đặt lịch thành công!', style: TextStyle(fontSize: 16))]), backgroundColor: const Color(0xFF10B981), behavior: SnackBarBehavior.floating, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], 
      appBar: AppBar(title: const Text('Đặt Lịch Hẹn', style: TextStyle(fontWeight: FontWeight.bold)), backgroundColor: Colors.transparent, foregroundColor: Colors.black87, elevation: 0, centerTitle: true),
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
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  const Padding(padding: EdgeInsets.only(bottom: 24.0), child: Text('Vui lòng điền thông tin bên dưới để lên lịch hẹn với chuyên gia.', textAlign: TextAlign.center, style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.5))),
                  Container(
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))]),
                    padding: const EdgeInsets.all(24.0),
                    child: Form(
                      key: _formKey, autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(controller: _dateController, readOnly: true, onTap: () => _selectDate(context), decoration: _buildInputDecoration(label: 'Chọn ngày hẹn', icon: Icons.calendar_month), validator: (value) { if (value == null || value.isEmpty) return 'Vui lòng chọn ngày'; if (_selectedDate != null) { final now = DateTime.now(); final today = DateTime(now.year, now.month, now.day); final pickedDate = DateTime(_selectedDate!.year, _selectedDate!.month, _selectedDate!.day); if (pickedDate.isBefore(today)) return 'Ngày hẹn không được trong quá khứ'; } return null; }),
                          const SizedBox(height: 20),
                          TextFormField(controller: _timeController, readOnly: true, onTap: () => _selectTime(context), decoration: _buildInputDecoration(label: 'Chọn giờ hẹn', icon: Icons.access_time), validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng chọn giờ' : null),
                          const SizedBox(height: 20),
                          DropdownButtonFormField<String>(value: _selectedService, icon: Icon(Icons.keyboard_arrow_down, color: _primaryColor), decoration: _buildInputDecoration(label: 'Dịch vụ mong muốn', icon: Icons.medical_services), items: ['Kiểm tra tổng quát', 'Tư vấn chuyên sâu', 'Tái khám định kỳ'].map((service) => DropdownMenuItem(value: service, child: Text(service))).toList(), onChanged: (value) => setState(() => _selectedService = value), validator: (value) => (value == null || value.isEmpty) ? 'Vui lòng chọn dịch vụ' : null),
                          const SizedBox(height: 32),
                          SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _submitForm, style: ElevatedButton.styleFrom(backgroundColor: _primaryColor, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 18), elevation: 4, shadowColor: _primaryColor.withOpacity(0.4), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))), child: const Text('Xác nhận Đặt lịch', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}