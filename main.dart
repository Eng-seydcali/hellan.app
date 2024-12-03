import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
// create homescreen
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign up",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            // Logo Section
            Image.asset(
            'assets/helan logo-03.png', // Path to your logo
            height: 100, // Adjust the size as needed
          ),
          SizedBox(height: 20),



            Text(
              "Welcome To Helan!",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "Ka jira Isdiiwaal Walaal Lambarka Dhaqanka Aad Rabto "
                  "Adigoo Gurigaaga Jooga",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateAccountScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFF6BE00),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Sign up",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have An Account? "),
                GestureDetector(
                  onTap: () {
                    // Future login functionality
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
// create accountscreen
// Import Twilio


class CreateAccountScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top:10, left: 10, right: 10,bottom: 50,),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Section
            Image.asset(
              'assets/helan logo-03.png', // Path to your logo
              height: 100, // Adjust the size as needed
            ),
            SizedBox(height: 7),
            Text(
              "Create Your Account",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Enter Your Name",
                filled: true,
                fillColor: Color(0xFFD8D5B8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Phone Number",
                filled: true,
                fillColor: Color(0xFFD8D5B8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_validateInput(context)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPVerificationScreen(),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF6BE00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

  }

  bool _validateInput(BuildContext context) {
    String name = nameController.text.trim();
    String phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      _showErrorDialog(context, "Both fields are required.");
      return false;
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
      _showErrorDialog(context, "Name can only contain letters.");
      return false;
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(phone)) {
      _showErrorDialog(context, "Phone number must contain only digits.");
      return false;
    }
    return true;
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }
}

// create OTP verificationscreen
class OTPVerificationScreen extends StatefulWidget {


  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}



class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());

  @override
  void initState() {
    super.initState();
    // Add listeners to the text fields
    _controllers.forEach((controller) {
      controller.addListener(_checkOTPComplete);
    });
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is destroyed
    _controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _checkOTPComplete() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      // Navigate to DashboardScreen when all 4 digits are entered
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => DashboardScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Enter the 4-digit code",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return SizedBox(
                  width: 50,
                  child: TextField(
                    controller: _controllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    decoration: const InputDecoration(counterText: ""),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 3) {
                        FocusScope.of(context).nextFocus(); // Move to next field
                      }
                      if (value.isEmpty && index > 0) {
                        FocusScope.of(context).previousFocus(); // Move to previous field
                      }
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// create Dashpoard screen
class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top:0,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile & Search Section
              Container(
                height: 280,
                padding: const EdgeInsets.only(top:40, left: 8, right: 8,),
                decoration: BoxDecoration(
                  color: Colors.blue[400],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8,left:0),
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage('assets/home.png'),
                            ),
                          ),
                          const SizedBox(width: 0,),

                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Good Morning...",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "cali bashiir",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0,left: 10,right: 0),
                      child: const SizedBox(height: 16),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Search...",
                        filled: true,
                        fillColor: Colors.yellow[700],
                        prefixIcon: const Icon(Icons.search, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              // Top Hospitals Section
              Padding(
                padding: const EdgeInsets.only(left: 8,),
                child: const Text(
                  "Top Hospitals",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildHospitalLogo('assets/Digfeer.png'),
                  _buildHospitalLogo('assets/Banaadir.png'),
                  _buildHospitalLogo('assets/Kalkaal.png'),
                  _buildHospitalLogo('assets/Samakaal.png'),
                  _buildHospitalLogo('assets/Al ixsaan.png'),
                ],
              ),
              const SizedBox(height: 20),

              // Image Section
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                    image: AssetImage('assets/medical.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Service Packages Section (Only Images)
              Padding(
                padding: const EdgeInsets.only(left:8),
                child: const Text(
                  "Service Packages",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(top:8,left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HospitalListPage()),
                        );
                      },
                      child: _buildServicePackageCard('assets/helan logo-03.png'),
                    ),
                    _buildServicePackageCard('assets/Newappointment.png'),
                    _buildServicePackageCard('assets/home.png'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalListPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.airplane_ticket), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointment'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Helper for Hospital Logo
  Widget _buildHospitalLogo(String imagePath) {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.grey[300],
      child: ClipOval(
        child: Image.asset(imagePath, fit: BoxFit.cover, width: 70, height: 70),
      ),
    );
  }

  // Helper for Service Package Cards (Only Image)
  Widget _buildServicePackageCard(String imagePath) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
      ),
    );
  }
}


// Hospital Lists screen
class HospitalListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Background color for page.
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Our Hospitals',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search Hospital...',
                filled: true,
                fillColor: Colors.white,
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // List of Hospitals
            Expanded(
              child: ListView(
                children: [
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Somali Turkish Hospital',
                    imagePath: 'assets/Digfeer.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'AL-Ihsaan Specialist Hospital',
                    imagePath: 'assets/Al ixsaan.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Kalkaal Hospital',
                    imagePath: 'assets/Kalkaal.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Banaadir Hospital',
                    imagePath: 'assets/Banaadir.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Banaadir Hospital',
                    imagePath: 'assets/Xamar.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Banaadir Hospital',
                    imagePath: 'assets/Shaafi.png',
                  ),
                  _buildHospitalCard(
                    context,
                    hospitalName: 'Samaakaal Hospital',
                    imagePath: 'assets/Samakaal.png',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HospitalListPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Appointment'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // Function to create a hospital card
  Widget _buildHospitalCard(BuildContext context,
      {required String hospitalName, required String imagePath}) {
    return GestureDetector(
      onTap: () {
        // Navigate to appointment page on tap
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AppointmentPage()),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(imagePath), // Hospital logo
            backgroundColor: Colors.white,
            radius: 30,
          ),
          title: Text(
            hospitalName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: const [
              Icon(Icons.star, color: Colors.amber, size: 20),
              SizedBox(width: 4),
              Text('4.8 (23 reviews)', style: TextStyle(fontSize: 12)),
            ],
          ),
          trailing: const Icon(Icons.favorite_border),
        ),
      ),
    );
  }
}

// Hoapital profile
class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
    appBar: AppBar(
    title: Text('Hospital Profile'),
    leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () {
    Navigator.of(context).pop();
    },
    ),
    ),
    body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
    CircleAvatar(
    radius: 50,
    backgroundImage: AssetImage('assets/Digfeer.png'),
    ),
    SizedBox(height: 8),
    Text(
    'Somali Turkish Hospital Profile',
    style: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    textAlign: TextAlign.center,
    ),
    SizedBox(height: 4),
    Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Icon(Icons.star, color: Colors.yellow),
    SizedBox(width: 4),
    Text(
    '4.8 (23 reviews)',
    style: TextStyle(fontSize: 16, color: Colors.grey),
    ),
    ],
    ),
    SizedBox(height: 16),
    ContactDetailRow(
    icon: Icons.phone,
    text: '+91-8546652338',
    ),
    ContactDetailRow(
    icon: Icons.email,
    text: 'somturkhospital@gmail.com',
    ),
    ContactDetailRow(
    icon: Icons.location_on,
    text: '28V3+7G6, Digfer Rd, Mogadishu',
    ),
    SizedBox(height: 16),
    Container(
    height: 200,
    width: double.infinity,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(8),
    image: DecorationImage(
    image: AssetImage('assets/Digfeer lo.jpg'),
    fit: BoxFit.cover,
    ),
    ),
    ),
    SizedBox(height: 16),
    ElevatedButton(
    onPressed: () => goToNewPage(context), // Calling the function
    style: ElevatedButton.styleFrom(
    padding: EdgeInsets.all(16),
    backgroundColor: Colors.blue,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    ),
    ),
    child: Text(
    'Lambar Jarasho',
    style: TextStyle(fontSize: 20, color: Colors.white),
    ),
    ),
    ],
    ),
    ),
    );
    }

    // Function that handles button press and navigates to the new page
    void goToNewPage(BuildContext context) {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => PatientForm()),
    );
    }
    }

    class ContactDetailRow extends StatelessWidget {
    final IconData icon;
    final String text;

    const ContactDetailRow({
    required this.icon,
    required this.text,
    });

    @override
    Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
    children: [
    Icon(icon, color: Colors.blue),
    SizedBox(width: 8),
    Text(
    text,
    style: TextStyle(fontSize: 16),
    ),
    ],
    ),
    );
    }
    }

// Pationt form screen
class PatientForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'PatientForm ',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.30),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/Digfeer.png', // Bedel sawirka path-ka saxda ah.
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Somali Turkish Hospital',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const Text('⭐ 4.8 (2.3 reviews)',
                        style: TextStyle(fontSize: 14)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Patient Form',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(value: 'Male', child: Text('Male')),
                  DropdownMenuItem(value: 'Female', child: Text('Female')),
                ],
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Gender'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Age'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Date'),
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                items: const [
                  DropdownMenuItem(value: 'Dr. Ahmed', child: Text('Dr. Ahmed')),
                  DropdownMenuItem(
                      value: 'Dr. Cali', child: Text('Dr. Cali')),
                  DropdownMenuItem(
                      value: 'Dr. Cumar', child: Text('Dr. Cumar')),
                  DropdownMenuItem(
                      value: 'Dr. Xasan', child: Text('Dr. Xasan')),
                  DropdownMenuItem(
                      value: 'Dr. Ayuub', child: Text('Dr. Ayuub')),
                ],
                onChanged: (value) {},
                decoration: const InputDecoration(labelText: 'Select Doctor'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SuccessPage()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: const EdgeInsets.all(8),
                ),
                child: const Text(
                  'Supmit',
                  style: TextStyle(fontSize: 28, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 // AppointmentTucket  screen
class SuccessPage extends StatelessWidget {
  const SuccessPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ticket'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hospital Logo and Name
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/Digfeer.png'), // Placeholder for logo
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Somali Turkish Hospital',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star, color: Colors.yellow, size: 16),
                      SizedBox(width: 4),
                      Text('4.8 (23 reviews)', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Divider(thickness: 1),
            // Receipt Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('RECEIPT', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('QUEUE NO:12', style: TextStyle(fontWeight: FontWeight.bold)),
                Icon(Icons.qr_code, size: 24),
              ],
            ),
            Divider(thickness: 1),
            SizedBox(height: 8),
            // Ticket Information
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('BEING: TICKET'),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('PRINT DATE: 21/10/2024'),
                    Text('ISSUE DATE: 21/10/2024'),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Divider(thickness: 1),
            // Patient and Doctor Information
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Patient ID: P35629'),
                  Text('Name: Xasan Axmed Xaashi'),
                  Text('Doctor: Cali C/rashiid Axmed'),
                  Text('Description:'),
                ],
              ),
            ),
            Divider(thickness: 1),
            SizedBox(height: 16),
            // Billing Summary
            Table(
              border: TableBorder.all(color: Colors.grey, width: 0.5),
              columnWidths: {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1),
              },
              children: [
                _buildTableRow('AMOUNT', '\$10.00'),
                _buildTableRow('DISCOUNT', '\$0.00'),
                _buildTableRow('TAX (5%)', '\$0.50'),
                _buildTableRow('TOTAL', '\$10.50'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, textAlign: TextAlign.right),
        ),
      ],
    );
  }
}