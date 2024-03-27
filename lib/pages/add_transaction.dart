import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moneymanger_app/controller/helper_db.dart';

// import 'package:moneymanger_app/controller/helper_db.dart';

import '../static.dart' as Static;

class AddTransaction extends StatefulWidget {
  const AddTransaction({super.key});

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
//
  int? amount;
  String note = "some Expense";
  String type = "Income";
  DateTime selectedDate = DateTime.now();

  List<String> months = [
    'Jan',
    'Feb',
    'March',
    'April',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec',
  ];

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2021, 1),
        lastDate: DateTime(2035, 12));

    if (picked != null && selectedDate != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0.0,
        ),
        backgroundColor: Color(0xffe2e7ef),
        body: ListView(
          children: [
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            const Padding(
              padding: EdgeInsets.all(12),
            ),
            const Text(
              'Add Transaction',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            //
            const SizedBox(
              height: 20,
            ),
            //
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Static.PrimaryColor),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.attach_money,
                      size: 24.0,
                      color: Colors.white,
                    )),
                //
                const SizedBox(
                  width: 12.0,
                ),
                //
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '0',
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24.0),
                    onChanged: (value) {
                      try {
                        amount = int.parse(value);
                      } catch (e) {
                        // Fluttertoast.showToast(
                        //   msg: 'Some Thing Went Wrong !!',
                        //   toastLength: Toast.LENGTH_SHORT,
                        //   gravity: ToastGravity.CENTER,
                        //   backgroundColor: Static.PrimaryColor,
                        //   fontSize: 12,
                        // );
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            //
            const SizedBox(
              height: 20,
            ),
            //
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Static.PrimaryColor),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.description,
                      size: 24.0,
                      color: Colors.white,
                    )),
                //
                const SizedBox(
                  width: 12.0,
                ),
                //
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Note On Transaction',
                      border: InputBorder.none,
                    ),
                    style: TextStyle(fontSize: 24.0),
                    onChanged: (val) {
                      note = val;
                    },
                  ),
                ),
              ],
            ),
            //
            const SizedBox(
              height: 20,
            ),
            //
            Row(
              children: [
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        color: Static.PrimaryColor),
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.moving_sharp,
                      size: 24.0,
                      color: Colors.white,
                    )),
                //
                const SizedBox(
                  width: 12.0,
                ),
                //
                ChoiceChip(
                  label: Text(
                    'Income',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: type == 'Income' ? Colors.white : Colors.black),
                  ),
                  selectedColor: Static.PrimaryColor,
                  selected: type == 'Income' ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Income";
                      });
                    }
                  },
                ),
                //
                const SizedBox(
                  width: 12.0,
                ),
                //
                ChoiceChip(
                  label: Text(
                    'Expense',
                    style: TextStyle(
                        fontSize: 16.0,
                        color: type == 'Expense' ? Colors.white : Colors.black),
                  ),
                  selectedColor: Static.PrimaryColor,
                  selected: type == 'Expense' ? true : false,
                  onSelected: (val) {
                    if (val) {
                      setState(() {
                        type = "Expense";
                      });
                    }
                  },
                ),
              ],
            ),
            //
            const SizedBox(
              height: 20,
            ),
            //
            SizedBox(
              height: 50.0,
              child: TextButton(
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                  ),
                  onPressed: () {
                    _selectedDate(context);
                  },
                  child: Row(
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0),
                              color: Static.PrimaryColor),
                          padding: const EdgeInsets.all(12.0),
                          child: const Icon(
                            Icons.moving_sharp,
                            size: 24.0,
                            color: Colors.white,
                          )),
                      //
                      const SizedBox(
                        width: 12.0,
                      ),
                      //
                      Text(
                        '${selectedDate.day} ${months[selectedDate.month - 1]}',
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ],
                  )),
            ),
            //
            const SizedBox(
              height: 20.0,
            ),
            //
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50.0,
                child: ElevatedButton(
                    onPressed: () async {
                      if (amount != null && note.isNotEmpty) {
                        DbHelper dbHelper = DbHelper();
                        await dbHelper.addData(
                            amount!, note, type, selectedDate);
                        Navigator.of(context).pop();
                      } else {
                        print('all data is not provided !');
                      }
                      // Navigator.of(context).pop();
                      //  // ignore: avoid_print
                      //  print(amount);
                      //    // ignore: avoid_print
                      //  print(note);
                      //    // ignore: avoid_print
                      // print(type);
                      //   // ignore: avoid_print
                      // print(selectedDate);
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )),
              ),
            ),
          ],
        ));
  }
}
