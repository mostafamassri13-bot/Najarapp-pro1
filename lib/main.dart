import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const AlNajjarApp());
}

class AlNajjarApp extends StatelessWidget {
  const AlNajjarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تطبيق النجار',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.brown,
        textTheme: GoogleFonts.cairoTextTheme(), // خط عربي أنيق
      ),
      home: const Directionality(
        textDirection: TextDirection.rtl, // دعم اللغة العربية
        child: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const ServicesWidget(),
    const ContactWidget(),
    const AboutWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تطبيق النجار المحترف'),
        backgroundColor: Colors.brown[800],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.brown[800],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'خدماتنا'),
          BottomNavigationBarItem(icon: Icon(Icons.phone), label: 'اتصل بنا'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'عن النجار'),
        ],
      ),
    );
  }
}

// واجهة الخدمات
class ServicesWidget extends StatelessWidget {
  const ServicesWidget({super.key});

  final List<Map<String, dynamic>> services = const [
    {'title': 'تصميم غرف نوم', 'icon': Icons.bed, 'desc': 'تصميم وتصنيع أحدث غرف النوم المودرن والكلاسيك.'},
    {'title': 'تركيب مطابخ', 'icon': Icons.kitchen, 'desc': 'تركيب وصيانة جميع أنواع المطابخ الخشبية.'},
    {'title': 'إصلاح أثاث', 'icon': Icons.build, 'desc': 'تجديد وإصلاح الكراسي والطاولات المتضررة.'},
    {'title': 'أبواب وشبابيك', 'icon': Icons.door_front_door, 'desc': 'تركيب أبواب خشبية متينة بمختلف التصاميم.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown[100],
              child: Icon(services[index]['icon'], color: Colors.brown[800]),
            ),
            title: Text(services[index]['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(services[index]['desc']),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('تم اختيار خدمة: ${services[index]['title']}')),
              );
            },
          ),
        );
      },
    );
  }
}

// واجهة الاتصال
class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.contact_phone, size: 80, color: Colors.brown),
          const SizedBox(height: 20),
          const Text('تواصل مع النجار مباشرة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () => _launchURL('tel:+123456789'),
            icon: const Icon(Icons.phone),
            label: const Text('اتصال هاتفي'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15)),
          ),
          const SizedBox(height: 15),
          ElevatedButton.icon(
            onPressed: () => _launchURL('https://wa.me/123456789'),
            icon: const FaIcon(FontAwesomeIcons.whatsapp),
            label: const Text('واتساب'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.teal, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15)),
          ),
        ],
      ),
    );
  }
}

// واجهة "عن النجار"
class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage('https://via.placeholder.com/150'), // يمكنك استبدالها بصورة النجار
          ),
          const SizedBox(height: 20),
          const Text(
            'النجار أحمد محمد',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            'خبرة أكثر من 15 عاماً في أعمال النجارة والديكور الخشبي. نتميز بالدقة في المواعيد والجودة العالية في التنفيذ.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const Divider(height: 40),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [Text('500+', style: TextStyle(fontWeight: FontWeight.bold)), Text('عميل')]),
              Column(children: [Text('1200+', style: TextStyle(fontWeight: FontWeight.bold)), Text('مشروع')]),
              Column(children: [Text('15', style: TextStyle(fontWeight: FontWeight.bold)), Text('سنة خبرة')]),
            ],
          )
        ],
      ),
    );
  }
}
