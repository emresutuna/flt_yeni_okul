import 'package:flutter/material.dart';

class PaymentBillList extends StatefulWidget {
  const PaymentBillList({super.key});

  @override
  State<PaymentBillList> createState() => _PaymentBillListState();
}

class _PaymentBillListState extends State<PaymentBillList> {
  List<String> bills = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Fatura Adresleri")),
      body: bills.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Lütfen bir fatura adresi ekleyin",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _addNewBill(),
              child: const Text("Yeni Fatura Adresi Ekle"),
            ),
          ],
        ),
      )
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: bills.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(bills[index]),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeBill(index),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () => _addNewBill(),
              child: const Text("Yeni Bir Fatura Adresi Ekle"),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewBill() {
    setState(() {
      bills.add("Yeni Fatura ${bills.length + 1}");
    });
  }

  void _removeBill(int index) {
    setState(() {
      bills.removeAt(index);
    });
  }
}
