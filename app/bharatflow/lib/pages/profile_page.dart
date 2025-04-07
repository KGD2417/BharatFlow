import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  final TextEditingController nameController = TextEditingController(text: 'John Doe');
  final TextEditingController phoneController = TextEditingController(text: '+91 9876543210');
  final TextEditingController emailController = TextEditingController(text: 'john@example.com');
  final TextEditingController licenseController = TextEditingController(text: 'DL1234567890123');
  final TextEditingController licenseExpiryController = TextEditingController(text: '2026-05-30');

  List<Map<String, String>> cars = [
    {'name': 'Maruti Swift', 'number': 'MH.43.CD.3452'}
  ];
  List<Map<String, String>> bikes = [
    {'name': 'Royal Enfield Classic 350', 'number': 'MH.01.AB.1234'}
  ];

  bool insuranceValid = true;
  bool pucValid = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: const Color(0xFF4A90E2),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.check : Icons.edit),
            onPressed: () {
              setState(() => isEditing = !isEditing);
            },
          )
        ],
      ),
      backgroundColor: const Color(0xFFF6F7FB),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildEditableTile('Name', nameController),
          _buildEditableTile('Phone Number', phoneController),
          _buildEditableTile('Email Address', emailController),
          _buildVehicleList('Cars', cars),
          _buildVehicleList('Motorcycles', bikes),
          _buildEditableTile('License Number', licenseController),
          _buildEditableTile('License Expiry Date', licenseExpiryController),
          _buildStatusTile('Insurance Status', insuranceValid),
          _buildStatusTile('PUC Certificate Status', pucValid),
          const Divider(height: 32),
          _buildSimpleTile(Icons.support_agent, 'Contact support', 'Call: +91 800-123-4567'),
          _buildRatingTile(),
        ],
      ),
    );
  }

  Widget _buildEditableTile(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
      ),
      child: ListTile(
        title: Text(label),
        subtitle: isEditing
            ? TextField(controller: controller)
            : Text(controller.text),
      ),
    );
  }

  Widget _buildVehicleList(String label, List<Map<String, String>> vehicles) {
    return ExpansionTile(
      title: Text(label),
      children: [
        ...vehicles.map((v) => ListTile(
          title: Text('${v['name']} (${v['number']})'),
          trailing: isEditing ? IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              setState(() {
                vehicles.remove(v);
              });
            },
          ) : null,
        )).toList(),
        if (isEditing)
          TextButton.icon(
            onPressed: () async {
              final nameController = TextEditingController();
              final numberController = TextEditingController();
              final result = await showDialog<Map<String, String>>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Add $label'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Vehicle Name')),
                      TextField(controller: numberController, decoration: const InputDecoration(labelText: 'Vehicle Number')),
                    ],
                  ),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                    TextButton(onPressed: () {
                      if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
                        Navigator.pop(context, {'name': nameController.text, 'number': numberController.text});
                      }
                    }, child: const Text('Add')),
                  ],
                ),
              );
              if (result != null) {
                setState(() {
                  if (label == 'Cars') {
                    cars.add(result);
                  } else {
                    bikes.add(result);
                  }
                });
              }
            },
            icon: const Icon(Icons.add),
            label: Text('Add $label'),
          ),
      ],
    );
  }

  Widget _buildStatusTile(String label, bool status) {
    return ListTile(
      title: Text(label),
      trailing: Icon(
        status ? Icons.check_circle : Icons.cancel,
        color: status ? Colors.green : Colors.red,
      ),
    );
  }

  Widget _buildSimpleTile(IconData icon, String label, String detail) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF4A90E2)),
      title: Text(label),
      subtitle: Text(detail),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildRatingTile() {
    return ListTile(
      leading: const Icon(Icons.star_rate, color: Color(0xFF4A90E2)),
      title: const Text('Rate the App'),
      trailing: RatingBar.builder(
        initialRating: 4.0,
        minRating: 1,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemSize: 24.0,
        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
        itemBuilder: (context, _) => const Icon(Icons.star, color: Colors.amber),
        onRatingUpdate: (rating) {
          // Handle rating logic here
          print(rating);
        },
      ),
    );
  }
}
