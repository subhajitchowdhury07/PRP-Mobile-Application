import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class AfterLoginScreen extends StatefulWidget {
  const AfterLoginScreen({Key? key}) : super(key: key);

  @override
  _AfterLoginScreenState createState() => _AfterLoginScreenState();
}

class _AfterLoginScreenState extends State<AfterLoginScreen> {
  late TextEditingController _dateController;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        const SizedBox(height: 60.0),
                        const Text(
                          "Provisional Receipt",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Fill up the form and proceed to Payment",
                          style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                        )
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        _buildDateField("Date", Icons.calendar_today),
                        _buildFormField("Office/Lane", Icons.location_on),
                        _buildAmountField("Cash amount", Icons.attach_money),
                        _buildAmountField("Check amount", Icons.attach_money),
                        _buildAmountField("Total amount", Icons.attach_money),
                        _buildFormField("Customer name", Icons.person),
                        _buildFormField("Customer code", Icons.person),
                        _buildFormField("Legal Entity / First and Last Names", Icons.person),
                        _buildDepositDetailsField("Deposit details"),
                        _buildSignatureField("Signature (Delivered)"),
                        _buildSignatureField("Signature (Received)"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // SwipeButton replacement
                    SwipeButton.expand(
                      thumb: Icon(
                        Icons.double_arrow_rounded,
                        color: Colors.white,
                      ),
                      child: Text(
                        "Swipe to Proceed Payment...",
                        style: TextStyle(
                          color: Colors.blue[800],
                        ),
                      ),
                      activeThumbColor: Colors.green,
                      activeTrackColor: Colors.grey.shade300,
                      onSwipe: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Swiped"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        // Navigate to payment page
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Form',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
          selectedItemColor: Colors.purple,
          onTap: (int index) {
            // Handle navigation to form or payment history
          },
        ),
      ),
    );
  }

  Widget _buildDateField(String hintText, IconData prefixIcon) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        TextField(
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              String formattedDate = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
              setState(() {
                _dateController.text = formattedDate;
              });
            }
          },
          readOnly: true,
          controller: _dateController,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(prefixIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildFormField(String hintText, IconData prefixIcon) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        TextField(
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(prefixIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField(String hintText, IconData prefixIcon) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 20),
        TextField(
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.purple.withOpacity(0.1),
            filled: true,
            prefixIcon: Icon(prefixIcon),
          ),
        ),
      ],
    );
  }

  Widget _buildDepositDetailsField(String headingText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(
          headingText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        _buildFormField("Bank", Icons.account_balance),
        _buildFormField("Drawer Name", Icons.person),
        _buildFormField("Ch/. No.", Icons.label),
        _buildAmountField("Amount USD", Icons.attach_money),
      ],
    );
  }

  Widget _buildSignatureField(String headingText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SizedBox(height: 20),
        Text(
          headingText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          height: 150, // Adjust height as needed
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          // Placeholder for digital signature field
        ),
      ],
    );
  }
}
