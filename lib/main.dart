import 'package:flutter/material.dart';
import 'database_helper.dart';

void main() {
  runApp(const StockApp());
}

final ValueNotifier<bool> appThemeNotifier = ValueNotifier<bool>(false);

class AppColors {
  static const cream = Color(0xffF8F5F0);
  static const softGrey = Color(0xffE8E6E1);
  static const darkGrey = Color(0xff2E2E2E);
  static const black = Color(0xff111111);
  static const white = Color(0xffFFFFFF);
  static const danger = Color(0xffB00020);
}

class StockApp extends StatefulWidget {
  const StockApp({super.key});

  @override
  State<StockApp> createState() => _StockAppState();
}

class _StockAppState extends State<StockApp> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    appThemeNotifier.addListener(_themeListener);
  }

  void _themeListener() {
    setState(() {
      isDarkMode = appThemeNotifier.value;
    });
  }

  @override
  void dispose() {
    appThemeNotifier.removeListener(_themeListener);
    super.dispose();
  }

  void changeTheme(bool value) {
    appThemeNotifier.value = value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "STOREX",
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.black,
          primary: AppColors.black,
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.cream,
          foregroundColor: AppColors.black,
          elevation: 0,
          centerTitle: true,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: const Color(0xff1E1E1E),
        colorScheme: ColorScheme.fromSeed(
          seedColor:  const Color(0xffEDEDED),
          primary:  const Color(0xffEDEDED),
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor:  Color(0xff1E1E1E),
          foregroundColor:  Color(0xffF5F5F5),
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xff2A2A2A),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xff333333),
    labelStyle: const TextStyle(color: Color(0xffDADADA)),
  ),

  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
  ),
        useMaterial3: true,
      ),
      home: SplashPage(
        isDarkMode: isDarkMode,
        onThemeChanged: changeTheme,
      ),
    );
  }
}

class Product {
  String name;
  String category;
  int stock;
  int critical;
  double price;

  Product(this.name, this.category, this.stock, this.critical, this.price);
}

class CategoryInfo {
  String name;
  IconData icon;

  CategoryInfo(this.name, this.icon);
}

class Customer {
  String name;
  String email;
  String phone;
  String password;

  Customer(this.name, this.email, this.phone, this.password);
}

class CartItem {
  Product product;
  int quantity;

  CartItem(this.product, this.quantity);
}

final List<CartItem> cart = [];

final List<CategoryInfo> categories = [
  CategoryInfo("Teknoloji", Icons.devices),
  CategoryInfo("Beyaz Eşya", Icons.kitchen),
  CategoryInfo("Küçük Ev Aletleri", Icons.blender),
  CategoryInfo("Ev & Mobilya", Icons.chair),
  CategoryInfo("Aksesuar", Icons.cable),
];

final List<Product> products = [
  Product("Laptop", "Teknoloji", 8, 5, 32999),
  Product("Mouse", "Teknoloji", 25, 10, 499),
  Product("Klavye", "Teknoloji", 18, 8, 899),
  Product("Monitör", "Teknoloji", 10, 4, 4999),
  Product("Telefon", "Teknoloji", 9, 4, 24999),
  Product("Tablet", "Teknoloji", 13, 5, 18999),
  Product("Kulaklık", "Teknoloji", 30, 10, 1299),
  Product("USB Bellek", "Teknoloji", 40, 15, 399),
  Product("SSD", "Teknoloji", 14, 5, 1899),
  Product("RAM", "Teknoloji", 16, 6, 1499),
  Product("Buzdolabı", "Beyaz Eşya", 6, 2, 28999),
  Product("Çamaşır Makinesi", "Beyaz Eşya", 5, 2, 21999),
  Product("Bulaşık Makinesi", "Beyaz Eşya", 4, 2, 19999),
  Product("Televizyon", "Beyaz Eşya", 8, 3, 22999),
  Product("Klima", "Beyaz Eşya", 7, 3, 26999),
  Product("Blender", "Küçük Ev Aletleri", 18, 6, 1499),
  Product("Kettle", "Küçük Ev Aletleri", 20, 8, 799),
  Product("Tost Makinesi", "Küçük Ev Aletleri", 11, 4, 1799),
  Product("Air Fryer", "Küçük Ev Aletleri", 13, 5, 3999),
  Product("Ütü", "Küçük Ev Aletleri", 14, 5, 1299),
  Product("Çalışma Masası", "Ev & Mobilya", 9, 3, 5999),
  Product("Ofis Sandalyesi", "Ev & Mobilya", 12, 5, 4499),
  Product("Kitaplık", "Ev & Mobilya", 8, 3, 2999),
  Product("Halı", "Ev & Mobilya", 10, 4, 1999),
  Product("Masa Lambası", "Ev & Mobilya", 25, 10, 699),
  Product("Şarj Aleti", "Aksesuar", 35, 12, 399),
  Product("Type-C Kablo", "Aksesuar", 50, 20, 249),
  Product("HDMI Kablo", "Aksesuar", 28, 10, 299),
  Product("Powerbank", "Aksesuar", 22, 8, 999),
  Product("Telefon Kılıfı", "Aksesuar", 45, 15, 199),
];

class SplashPage extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SplashPage({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => RoleSelectionPage(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 62,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(Icons.storefront, size: 64, color: AppColors.black),
            ),
            SizedBox(height: 26),
            Text(
              "STOREX",
              style: TextStyle(
                color: AppColors.white,
                fontSize: 44,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Stock • Shopping • Control",
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            SizedBox(height: 35),
            CircularProgressIndicator(color: AppColors.cream),
          ],
        ),
      ),
    );
  }
}

class RoleSelectionPage extends StatelessWidget {
  final bool? isDarkMode;
  final Function(bool)? onThemeChanged;

  const RoleSelectionPage({
    super.key,
    this.isDarkMode,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: appThemeNotifier,
      builder: (context, currentDarkMode, child) {
        return Scaffold(
          backgroundColor: currentDarkMode
              ? const Color(0xff121212)
              : AppColors.cream,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        currentDarkMode ? Icons.dark_mode : Icons.light_mode,
                        color: currentDarkMode ? AppColors.white : AppColors.black,
                      ),
                      Switch(
                        value: currentDarkMode,
                        activeColor: AppColors.white,
                        activeTrackColor: Colors.white38,
                        inactiveThumbColor: AppColors.white,
                        inactiveTrackColor: Colors.black26,
                        onChanged: (value) {
                          appThemeNotifier.value = value;
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Icon(
                    Icons.storefront,
                    size: 88,
                    color: currentDarkMode ? AppColors.white : AppColors.black,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    "STOREX",
                    style: TextStyle(
                      color: currentDarkMode ? AppColors.white : AppColors.black,
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Mağaza ürün, stok ve alışveriş yönetimi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: currentDarkMode ? Colors.white70 : Colors.black54,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 45),

                  roleCard(
                    context,
                    title: "Müşteri Girişi",
                    subtitle: "Kayıt ol, giriş yap ve alışverişe başla",
                    icon: Icons.shopping_bag,
                    page: const CustomerLoginPage(),
                    isDark: currentDarkMode,
                  ),

                  const SizedBox(height: 18),

                  roleCard(
                    context,
                    title: "Admin Girişi",
                    subtitle: "Stokları ve ürünleri yönet",
                    icon: Icons.admin_panel_settings,
                    page: const AdminLoginPage(),
                    isDark: currentDarkMode,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget roleCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
    required bool isDark,
  }) {
    return TapScale(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
      child: Card(
        color: isDark ? const Color(0xff2A2A2A) : const Color(0xffE8E8E8),
        elevation: 10,
        shadowColor: isDark ? Colors.black87 : Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(22),
          child: Row(
            children: [
              CircleAvatar(
                radius: 31,
                backgroundColor: isDark ? AppColors.white : AppColors.black,
                child: Icon(
                  Icons.arrow_forward,
                  color: isDark ? AppColors.black : AppColors.white,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDark ? AppColors.white : AppColors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: isDark ? Colors.white70 : Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                icon,
                color: isDark ? Colors.white70 : AppColors.darkGrey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomerLoginPage extends StatefulWidget {
  const CustomerLoginPage({super.key});

  @override
  State<CustomerLoginPage> createState() => _CustomerLoginPageState();
}

class _CustomerLoginPageState extends State<CustomerLoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  Future<void> login() async {
    final result = await DatabaseHelper.instance.loginCustomer(
      email: email.text.trim(),
      password: password.text.trim(),
    );

    if (!mounted) return;

    if (result != null) {
      final customer = Customer(
        result["name"],
        result["email"],
        result["phone"] ?? "",
        result["password"],
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => CustomerHomePage(customer: customer),
        ),
      );
    } else {
      showAppSnackBar(context, "Bilgiler hatalı veya kayıt bulunamadı.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return authPage(
      context: context,
      title: "Müşteri Girişi",
      icon: Icons.person,
      children: [
        appTextField(
          email,
          "E-posta",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        appTextField(password, "Şifre", obscure: true),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: login,
            child: const Text("Giriş Yap"),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomerRegisterPage()),
            );
          },
          child: const Text("Hesabın yok mu? Kayıt ol"),
        ),
      ],
    );
  }
}

class CustomerRegisterPage extends StatefulWidget {
  const CustomerRegisterPage({super.key});

  @override
  State<CustomerRegisterPage> createState() => _CustomerRegisterPageState();
}

class _CustomerRegisterPageState extends State<CustomerRegisterPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();

  Future<void> register() async {
    if (name.text.isEmpty || email.text.isEmpty || password.text.isEmpty) {
      showAppSnackBar(context, "Lütfen gerekli alanları doldurun.");
      return;
    }

    try {
      await DatabaseHelper.instance.insertCustomer(
        name: name.text.trim(),
        email: email.text.trim(),
        phone: phone.text.trim(),
        password: password.text.trim(),
      );

      if (!mounted) return;

      showAppSnackBar(context, "Kayıt başarılı. Giriş yapabilirsiniz.");
      Navigator.pop(context);
    } catch (e) {
      showAppSnackBar(context, "Bu e-posta ile kayıtlı kullanıcı olabilir.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return authPage(
      context: context,
      title: "Müşteri Kayıt",
      icon: Icons.person_add,
      children: [
        appTextField(name, "Ad Soyad"),
        const SizedBox(height: 12),
        appTextField(
          email,
          "E-posta",
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        appTextField(phone, "Telefon", keyboardType: TextInputType.phone),
        const SizedBox(height: 12),
        appTextField(password, "Şifre", obscure: true),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: register,
            child: const Text("Kayıt Ol"),
          ),
        ),
      ],
    );
  }
}

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final user = TextEditingController();
  final pass = TextEditingController();

  void login() {
    if (user.text.trim() == "admin" && pass.text.trim() == "1234") {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminHomePage()),
      );
    } else {
      showAppSnackBar(context, "Admin bilgileri hatalı");
    }
  }

  @override
  Widget build(BuildContext context) {
    return authPage(
      context: context,
      title: "Admin Girişi",
      icon: Icons.lock,
      children: [
        appTextField(user, "Kullanıcı Adı"),
        const SizedBox(height: 12),
        appTextField(pass, "Şifre", obscure: true),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: login,
            child: const Text("Giriş Yap"),
          ),
        ),
        const SizedBox(height: 8),
        const Text("Demo: admin / 1234"),
      ],
    );
  }
}

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int totalStock() => products.fold(0, (sum, p) => sum + p.stock);

  int criticalCount() {
    return products.where((p) => p.stock <= p.critical).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin Stok Paneli"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminSettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const RoleSelectionPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                infoCard("Ürün", products.length.toString(), AppColors.black),
                infoCard("Stok", totalStock().toString(), AppColors.darkGrey),
                infoCard(
                  "Riskli",
                  criticalCount().toString(),
                  AppColors.danger,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Kategoriler",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: categoryGrid(
              context: context,
              isAdmin: true,
              refresh: () => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }
}

class CustomerHomePage extends StatefulWidget {
  final Customer customer;

  const CustomerHomePage({super.key, required this.customer});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  Future<int> orderCount() async {
    final data =
        await DatabaseHelper.instance.getOrdersByCustomer(widget.customer.email);
    return data.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Hoş geldin, ${widget.customer.name}"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const RoleSelectionPage()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: ListTile(
              leading: const Icon(Icons.shopping_cart, color: AppColors.black),
              title: const Text(
                "Sepetim",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text("${cart.length} farklı ürün sepette"),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CartPage(customer: widget.customer),
                    ),
                  ).then((_) => setState(() {}));
                },
                child: const Text("Aç"),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: AppColors.black),
              title: const Text(
                "Sipariş Geçmişim",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: FutureBuilder<int>(
                future: orderCount(),
                builder: (context, snapshot) {
                  return Text("${snapshot.data ?? 0} sipariş");
                },
              ),
              trailing: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderHistoryPage(
                        customer: widget.customer,
                      ),
                    ),
                  ).then((_) => setState(() {}));
                },
                child: const Text("Gör"),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Alışveriş Kategorileri",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: categoryGrid(
              context: context,
              isAdmin: false,
              refresh: () => setState(() {}),
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPage extends StatefulWidget {
  final CategoryInfo category;
  final bool isAdmin;

  const CategoryPage({
    super.key,
    required this.category,
    required this.isAdmin,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Product> get list {
    return products.where((p) => p.category == widget.category.name).toList();
  }

  void addToCart(Product p) {
    if (p.stock <= 0) return;

    final found = cart.where((c) => c.product.name == p.name);

    if (found.isNotEmpty) {
      found.first.quantity++;
    } else {
      cart.add(CartItem(p, 1));
    }

    showAppSnackBar(context, "${p.name} sepete eklendi");
  }

  @override
  Widget build(BuildContext context) {
    final totalStock = list.fold(0, (sum, p) => sum + p.stock);
    final criticalCount = list.where((p) => p.stock <= p.critical).length;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(widget.category.name)),
      body: Column(
        children: [
          if (widget.isAdmin)
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  infoCard("Ürün", list.length.toString(), AppColors.black),
                  infoCard("Stok", totalStock.toString(), AppColors.darkGrey),
                  infoCard(
                    "Riskli",
                    criticalCount.toString(),
                    AppColors.danger,
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, i) {
                final p = list[i];
                final danger = p.stock <= p.critical;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  color: danger ? const Color(0xffffeeee) : AppColors.white,
                  child: ListTile(
                    leading: Icon(
                      danger ? Icons.warning : Icons.check_circle,
                      color: danger ? AppColors.danger : AppColors.darkGrey,
                    ),
                    title: Text(
                      p.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                   subtitle: Text(
  widget.isAdmin
      ? "Stok: ${p.stock} | Kritik: ${p.critical}\nFiyat: ${p.price.toStringAsFixed(0)} TL"
      : "Fiyat: ${p.price.toStringAsFixed(0)} TL",
),
                    isThreeLine: true,
                    trailing: widget.isAdmin
                        ? Wrap(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (p.stock > 0) {
                                      p.stock--;
                                    }
                                  });
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    p.stock++;
                                  });
                                },
                                icon: const Icon(Icons.add),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    products.remove(p);
                                  });
                                },
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          )
                        : FilledButton(
                            onPressed: p.stock > 0 ? () => addToCart(p) : null,
                            child: const Text("Sepete Ekle"),
                          ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final Customer customer;

  const CartPage({super.key, required this.customer});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  String? selectedPaymentMethod;
  bool acceptedTerms = false;

  final List<String> paymentMethods = [
    "Kredi Kartı",
    "Banka Kartı",
    "Kapıda Ödeme",
    "Havale / EFT",
  ];

  double total() {
    double sum = 0;

    for (var item in cart) {
      sum += item.product.price * item.quantity;
    }

    return sum;
  }

  Future<void> buy() async {
    if (selectedPaymentMethod == null) {
      showAppSnackBar(context, "Lütfen ödeme yöntemi seçiniz.");
      return;
    }

    if (!acceptedTerms) {
      showAppSnackBar(
        context,
        "Ön bilgilendirme koşullarını kabul etmeden satın alma tamamlanamaz.",
      );
      return;
    }

    for (var item in cart) {
      if (item.product.stock < item.quantity) {
        showAppSnackBar(
          context,
          "${item.product.name} için yeterli stok yok.",
        );
        return;
      }
    }

    final items = cart.map((item) {
      return {
        "productName": item.product.name,
        "quantity": item.quantity,
        "price": item.product.price,
      };
    }).toList();

    await DatabaseHelper.instance.insertOrder(
      customerEmail: widget.customer.email,
      customerName: widget.customer.name,
      totalPrice: total(),
      paymentMethod: selectedPaymentMethod!,
      date: DateTime.now().toIso8601String(),
      items: items,
    );

    for (var item in cart) {
      item.product.stock -= item.quantity;
    }

    cart.clear();

    if (!mounted) return;

    showAppSnackBar(context, "Satın alma başarılı. Sipariş geçmişine eklendi.");

    setState(() {
      selectedPaymentMethod = null;
      acceptedTerms = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Sepetim")),
      body: cart.isEmpty
          ? const Center(child: Text("Sepet boş"))
          : Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: cart.length,
                        itemBuilder: (_, i) {
                          final item = cart[i];

                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: ListTile(
                              title: Text(
                                item.product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "${item.quantity} x ${item.product.price.toStringAsFixed(0)} TL",
                              ),
                              trailing: Text(
                                "${(item.quantity * item.product.price).toStringAsFixed(0)} TL",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Card(
                        margin: const EdgeInsets.all(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Ödeme Yöntemi",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ...paymentMethods.map((method) {
                                return RadioListTile<String>(
                                  title: Text(method),
                                  value: method,
                                  groupValue: selectedPaymentMethod,
                                  activeColor: AppColors.black,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedPaymentMethod = value;
                                    });
                                  },
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        child: CheckboxListTile(
                          activeColor: AppColors.black,
                          value: acceptedTerms,
                          onChanged: (value) {
                            setState(() {
                              acceptedTerms = value ?? false;
                            });
                          },
                          title: const Text(
                            "Ön bilgilendirme koşullarını okudum ve kabul ediyorum.",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: const Text(
                            "Bu kutucuk işaretlenmeden satın alma işlemi tamamlanamaz.",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  color: AppColors.white,
                  child: Column(
                    children: [
                      Text(
                        "Toplam: ${total().toStringAsFixed(0)} TL",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: FilledButton(
                          onPressed: buy,
                          child: const Text("Satın Al"),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class OrderHistoryPage extends StatefulWidget {
  final Customer customer;

  const OrderHistoryPage({super.key, required this.customer});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  late Future<List<Map<String, dynamic>>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture =
        DatabaseHelper.instance.getOrdersByCustomer(widget.customer.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Sipariş Geçmişim")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ordersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final customerOrders = snapshot.data ?? [];

          if (customerOrders.isEmpty) {
            return const Center(child: Text("Henüz siparişiniz yok."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: customerOrders.length,
            itemBuilder: (_, index) {
              final order = customerOrders[index];
              final orderId = order["id"] as int;

              return FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper.instance.getOrderItems(orderId),
                builder: (context, itemSnapshot) {
                  final items = itemSnapshot.data ?? [];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sipariş #$orderId",
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            "Tarih: ${formatDate(DateTime.parse(order["date"]))}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          Text(
                            "Ödeme: ${order["paymentMethod"]}",
                            style: const TextStyle(color: Colors.black54),
                          ),
                          const Divider(height: 24),
                          ...items.map((item) {
                            final quantity = item["quantity"] as int;
                            final price = item["price"] as double;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["productName"]} x$quantity",
                                    ),
                                  ),
                                  Text(
                                    "${(price * quantity).toStringAsFixed(0)} TL",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Divider(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Toplam: ${(order["totalPrice"] as double).toStringAsFixed(0)} TL",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AdminSettingsPage extends StatelessWidget {
  const AdminSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Admin Ayarları"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [

          // KAYITLI MÜŞTERİLER
          Card(
            child: ListTile(
              leading: const Icon(Icons.people, color: AppColors.black),
              title: const Text(
                "Kayıtlı Müşteriler",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Uygulamaya kayıt olan müşterileri gör"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisteredCustomersPage(),
                  ),
                );
              },
            ),
          ),

          // SİPARİŞ YÖNETİMİ
          Card(
            child: ListTile(
              leading: const Icon(Icons.receipt_long, color: AppColors.black),
              title: const Text(
                "Sipariş Yönetimi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Tüm siparişleri görüntüle"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminOrdersPage(),
                  ),
                );
              },
            ),
          ),

          // STOK AYARLARI
          Card(
            child: ListTile(
              leading: const Icon(Icons.inventory, color: AppColors.black),
              title: const Text(
                "Stok Ayarları",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("Kritik stok ve ürün ayarları"),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminStockSettingsPage(),
                  ),
                );
              },
            ),
          ),

          // VERİTABANI
          Card(
            child: ListTile(
              leading: const Icon(Icons.storage, color: AppColors.black),
              title: const Text(
                "Veritabanı Bilgisi",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text("SQLite yerel veritabanı kullanılıyor"),
            ),
          ),
        ],
      ),
    );
  }
}
class RegisteredCustomersPage extends StatefulWidget {
  const RegisteredCustomersPage({super.key});

  @override
  State<RegisteredCustomersPage> createState() =>
      _RegisteredCustomersPageState();
}

class _RegisteredCustomersPageState extends State<RegisteredCustomersPage> {
  late Future<List<Map<String, dynamic>>> customersFuture;

  final searchController = TextEditingController();
  String searchText = "";

  @override
  void initState() {
    super.initState();
    customersFuture = DatabaseHelper.instance.getAllCustomers();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Kayıtlı Müşteriler"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: customersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final allCustomers = snapshot.data ?? [];

          final filteredCustomers = allCustomers.where((customer) {
            final name = (customer["name"] ?? "").toString().toLowerCase();
            final email = (customer["email"] ?? "").toString().toLowerCase();
            final phone = (customer["phone"] ?? "").toString().toLowerCase();

            return name.contains(searchText) ||
                email.contains(searchText) ||
                phone.contains(searchText);
          }).toList();

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchText = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Müşteri ara...",
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: filteredCustomers.isEmpty
                    ? const Center(
                        child: Text("Müşteri bulunamadı."),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: filteredCustomers.length,
                        itemBuilder: (_, index) {
                          final customer = filteredCustomers[index];

                          return Card(
                            child: ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: AppColors.black,
                                child: Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                ),
                              ),
                              title: Text(
                                customer["name"] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                "E-posta: ${customer["email"] ?? ""}\nTelefon: ${customer["phone"] ?? ""}",
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}

Widget categoryGrid({
  required BuildContext context,
  required bool isAdmin,
  required VoidCallback refresh,
}) {
  return GridView.builder(
    padding: const EdgeInsets.all(12),
    itemCount: categories.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.95,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
    ),
    itemBuilder: (_, i) {
      final c = categories[i];
      final count = products.where((p) => p.category == c.name).length;
      final critical = products
          .where((p) => p.category == c.name && p.stock <= p.critical)
          .length;

      return TapScale(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryPage(category: c, isAdmin: isAdmin),
            ),
          ).then((_) => refresh());
        },
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.softGrey,
                  child: Icon(c.icon, size: 30, color: AppColors.black),
                ),
                const SizedBox(height: 12),
                Text(
                  c.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "$count ürün",
                  style: const TextStyle(color: Colors.black54),
                ),
                if (isAdmin)
                  Text(
                    "$critical riskli",
                    style: const TextStyle(color: Colors.black45),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget infoCard(String title, String value, Color color) {
  return Expanded(
    child: Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white70),
            ),
            Text(
              value,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget authPage({
  required BuildContext context,
  required String title,
  required IconData icon,
  required List<Widget> children,
}) {
  return Scaffold(
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    appBar: AppBar(title: Text(title)),
    body: Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
            Container(
  height: 130,
  width: double.infinity,
  decoration: BoxDecoration(
    color: AppColors.black,
    borderRadius: BorderRadius.circular(18),
  ),
  child: Icon(
    icon,
    size: 72,
    color: AppColors.white,
  ),
),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ...children,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget appTextField(
  TextEditingController controller,
  String label, {
  bool obscure = false,
  TextInputType keyboardType = TextInputType.text,
}) {
  final bool isDark = appThemeNotifier.value;

  return TextField(
    controller: controller,
    obscureText: obscure,
    keyboardType: keyboardType,

    // Kullanıcının yazdığı yazı rengi
    style: TextStyle(
      color: isDark ? Colors.black : Colors.black,
      fontWeight: FontWeight.w500,
    ),

    // İmleç rengi
    cursorColor: AppColors.black,

    decoration: InputDecoration(
      labelText: label,

      // E-posta / Şifre yazısı
      labelStyle: TextStyle(
        color: isDark ? Colors.black87 : Colors.black54,
      ),

      // Kutunun iç rengi
      filled: true,
      fillColor: isDark ? const Color(0xffF1F1F1) : AppColors.white,

      // Kutunun kenarlığı
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: isDark ? Colors.white24 : Colors.black26,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: AppColors.black,
          width: 2,
        ),
      ),
    ),
  );
}

void showAppSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 110,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}

String formatDate(DateTime date) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");

  final day = twoDigits(date.day);
  final month = twoDigits(date.month);
  final year = date.year;
  final hour = twoDigits(date.hour);
  final minute = twoDigits(date.minute);

  return "$day.$month.$year $hour:$minute";
}
class AdminOrdersPage extends StatefulWidget {
  const AdminOrdersPage({super.key});

  @override
  State<AdminOrdersPage> createState() => _AdminOrdersPageState();
}

class _AdminOrdersPageState extends State<AdminOrdersPage> {
  late Future<List<Map<String, dynamic>>> ordersFuture;

  @override
  void initState() {
    super.initState();
    ordersFuture = DatabaseHelper.instance.getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Sipariş Yönetimi")),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: ordersFuture,
        builder: (context, snapshot) {
          final orders = snapshot.data ?? [];

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (orders.isEmpty) {
            return const Center(child: Text("Henüz sipariş yok."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: orders.length,
            itemBuilder: (_, index) {
              final order = orders[index];
              final orderId = order["id"] as int;

              return FutureBuilder<List<Map<String, dynamic>>>(
                future: DatabaseHelper.instance.getOrderItems(orderId),
                builder: (context, itemSnapshot) {
                  final items = itemSnapshot.data ?? [];

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sipariş #$orderId",
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text("Müşteri: ${order["customerName"]}"),
                          Text("E-posta: ${order["customerEmail"]}"),
                          Text("Ödeme: ${order["paymentMethod"]}"),
                          Text(
                            "Tarih: ${formatDate(DateTime.parse(order["date"]))}",
                          ),
                          const Divider(height: 24),
                          ...items.map((item) {
                            final quantity = item["quantity"] as int;
                            final price = item["price"] as double;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "${item["productName"]} x$quantity",
                                    ),
                                  ),
                                  Text(
                                    "${(price * quantity).toStringAsFixed(0)} TL",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Divider(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Toplam: ${(order["totalPrice"] as double).toStringAsFixed(0)} TL",
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class AdminStockSettingsPage extends StatefulWidget {
  const AdminStockSettingsPage({super.key});

  @override
  State<AdminStockSettingsPage> createState() => _AdminStockSettingsPageState();
}

class _AdminStockSettingsPageState extends State<AdminStockSettingsPage> {
  @override
  Widget build(BuildContext context) {
    final criticalProducts =
        products.where((p) => p.stock <= p.critical).toList();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: const Text("Stok Ayarları")),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          Card(
            color: AppColors.black,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Text(
                    "Stok Özeti",
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Toplam Ürün: ${products.length}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "Riskli Ürün: ${criticalProducts.length}",
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Riskli Stok Ürünleri",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (criticalProducts.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.check_circle),
                title: Text("Riskli stokta ürün yok."),
              ),
            )
          else
            ...criticalProducts.map((p) {
              return Card(
                color: const Color(0xffffeeee),
                child: ListTile(
                  leading: const Icon(
                    Icons.warning,
                    color: AppColors.danger,
                  ),
                  title: Text(
                    p.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Kategori: ${p.category}\nStok: ${p.stock} | Kritik sınır: ${p.critical}",
                  ),
                  isThreeLine: true,
                ),
              );
            }),
        ],
      ),
    );
  }
}
class TapScale extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const TapScale({
    super.key,
    required this.child,
    required this.onTap,
  });

  @override
  State<TapScale> createState() => _TapScaleState();
}

class _TapScaleState extends State<TapScale> {
  double scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          scale = 0.96;
        });
      },
      onTapUp: (_) {
        setState(() {
          scale = 1.0;
        });

        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          scale = 1.0;
        });
      },
      child: AnimatedScale(
        scale: scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}