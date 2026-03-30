import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

class _UploadViewState extends State<UploadView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  
  String? _fileName;
  bool _isConfirmed = false;
  final Color _primaryColor = const Color(0xFF0F766E); // Teal sậm giống màu đề bài

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  // Hàm xử lý chọn file
  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
      });
      // Validate lại form ngay khi chọn xong file để tắt thông báo lỗi đỏ (nếu có)
      _formKey.currentState?.validate();
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (!_isConfirmed) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Vui lòng xác nhận thông tin!'), backgroundColor: Colors.redAccent),
        );
        return;
      }
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle, color: Colors.white),
              const SizedBox(width: 8),
              Text('Nộp hồ sơ thành công!\nFile: $_fileName', style: const TextStyle(fontSize: 14)),
            ],
          ),
          backgroundColor: const Color(0xFF10B981),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
    }
  }

  InputDecoration _buildInputDecoration({required String label, required String hint, required IconData icon}) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: _primaryColor),
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: _primaryColor, width: 2)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: const BorderSide(color: Colors.redAccent, width: 1.5)),
      errorStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Bài 5: Form upload hồ sơ', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          // THANH MSSV
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: _primaryColor.withOpacity(0.1),
            child: Text(
              'MSSV: 6451071018',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: _primaryColor, letterSpacing: 1.2),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Họ và tên
                      TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration(label: 'Họ và tên', hint: 'Nguyen Lan Huong', icon: Icons.person),
                        validator: (value) => (value == null || value.trim().isEmpty) ? 'Vui lòng nhập họ và tên' : null,
                      ),
                      const SizedBox(height: 20),

                      // 2. Email
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(label: 'Email', hint: 'lanhuong.nguyen@example.com', icon: Icons.email),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) return 'Vui lòng nhập email';
                          if (!_isValidEmail(value)) return 'Email không hợp lệ';
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // 3. Upload File Picker (Sử dụng FormField để có thể validate trực tiếp)
                      const Text('File Picker', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                      const SizedBox(height: 4),
                      const Text('CV (Định dạng: PDF, DOCX)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                      const SizedBox(height: 8),
                      
                      FormField<String>(
                        validator: (value) {
                          if (_fileName == null) {
                            return 'Vui lòng upload CV của bạn!'; // Báo lỗi đỏ như hình
                          }
                          return null;
                        },
                        builder: (FormFieldState<String> state) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[50],
                                  border: Border.all(
                                    color: state.hasError ? Colors.redAccent : Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: _pickFile,
                                      icon: const Icon(Icons.upload_file, color: Colors.black87),
                                      label: const Text('Chọn Tệp CV', style: TextStyle(color: Colors.black87)),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey[300],
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: _fileName != null
                                          ? Row(
                                              children: [
                                                const Icon(Icons.picture_as_pdf, color: Colors.redAccent, size: 20),
                                                const SizedBox(width: 4),
                                                Expanded(child: Text(_fileName!, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold))),
                                              ],
                                            )
                                          : const Text('Chưa chọn file', style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic)),
                                    ),
                                  ],
                                ),
                              ),
                              if (state.hasError)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8.0, left: 12.0),
                                  child: Text(
                                    state.errorText!,
                                    style: const TextStyle(color: Colors.redAccent, fontSize: 12, fontWeight: FontWeight.w500),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),

                      // 4. Checkbox Xác nhận
                      CheckboxListTile(
                        value: _isConfirmed,
                        title: const Text('Tôi xác nhận thông tin là chính xác.', style: TextStyle(fontSize: 14)),
                        activeColor: _primaryColor,
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        onChanged: (value) {
                          setState(() => _isConfirmed = value ?? false);
                        },
                      ),
                      const SizedBox(height: 32),

                      // Nút Nộp Hồ Sơ
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFF4A261), // Màu cam giống đề bài
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: 4,
                            shadowColor: const Color(0xFFF4A261).withOpacity(0.4),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text('Nộp Hồ Sơ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, letterSpacing: 1)),
                        ),
                      ),
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