import 'package:flutter/material.dart';

class BasicRegisterView extends StatefulWidget {
  const BasicRegisterView({super.key});

  @override
  State<BasicRegisterView> createState() => _BasicRegisterViewState();
}

class _BasicRegisterViewState extends State<BasicRegisterView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isFormValid = false; // Trạng thái để bật/tắt nút Submit

  final Color _primaryColor = const Color(0xFFE11D48); // Màu Rose hiện đại

  @override
  void initState() {
    super.initState();
    // Lắng nghe từng nhịp gõ phím để check valid realtime cho nút Submit
    _nameController.addListener(_checkFormValidity);
    _emailController.addListener(_checkFormValidity);
    _passwordController.addListener(_checkFormValidity);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm Regex check chuẩn format Email
  bool _isValidEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }

  // Hàm kiểm tra tổng thể Form để disable/enable nút Submit
  void _checkFormValidity() {
    final isNameValid = _nameController.text.trim().isNotEmpty;
    final isEmailValid = _isValidEmail(_emailController.text);
    final isPassValid = _passwordController.text.length >= 6;

    final isNowValid = isNameValid && isEmailValid && isPassValid;

    // Chỉ build lại UI khi trạng thái valid thực sự thay đổi để tối ưu hiệu năng
    if (_isFormValid != isNowValid) {
      setState(() {
        _isFormValid = isNowValid;
      });
    }
  }

  // Hàm tạo style chung cho các Input để code gọn hơn
  InputDecoration _buildInputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Colors.grey[600]),
      prefixIcon: Icon(icon, color: _primaryColor),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.grey[50],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: _primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
      errorStyle: const TextStyle(fontWeight: FontWeight.w500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Bài 10: Form Đăng Ký',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: _primaryColor,
                letterSpacing: 1.2,
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode
                      .onUserInteraction, // Tự động show lỗi dưới field khi user gõ sai
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: _primaryColor.withOpacity(0.1),
                          child: Icon(
                            Icons.app_registration_rounded,
                            size: 40,
                            color: _primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 1. INPUT HỌ TÊN
                      TextFormField(
                        controller: _nameController,
                        decoration: _buildInputDecoration(
                          label: 'Họ và tên',
                          icon: Icons.badge_rounded,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Họ tên không được để trống';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // 2. INPUT EMAIL
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          label: 'Email',
                          icon: Icons.email_rounded,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email không được để trống';
                          }
                          if (!_isValidEmail(value)) {
                            return 'Email không đúng định dạng (VD: abc@gmail.com)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // 3. INPUT MẬT KHẨU
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: _buildInputDecoration(
                          label: 'Mật khẩu',
                          icon: Icons.lock_rounded,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                              color: Colors.grey,
                            ),
                            onPressed: () => setState(
                              () => _obscurePassword = !_obscurePassword,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Mật khẩu không được để trống';
                          }
                          if (value.length < 6) {
                            return 'Mật khẩu phải từ 6 ký tự trở lên';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),

                      // NÚT SUBMIT
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // Nút sẽ tự động mờ đi (disabled) nếu _isFormValid == false
                          onPressed: _isFormValid
                              ? () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: [
                                          const Icon(
                                            Icons.check_circle,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Đăng ký thành công!\nChào mừng ${_nameController.text}',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      backgroundColor: const Color(
                                        0xFF10B981,
                                      ), // Xanh lá mạ
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  );
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryColor,
                            disabledBackgroundColor:
                                Colors.grey[300], // Màu khi nút bị disable
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            elevation: _isFormValid ? 4 : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'ĐĂNG KÝ',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1,
                            ),
                          ),
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
