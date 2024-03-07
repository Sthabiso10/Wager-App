import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/themes/colors.dart';
import 'package:wager_app/utils/bet_column.dart';

class MakeBetPage extends StatefulWidget {
  final Function(List<String>) onSaveBet;
  const MakeBetPage({Key? key, required this.onSaveBet}) : super(key: key);

  @override
  State<MakeBetPage> createState() => _MakeBetPageState();
}

class _MakeBetPageState extends State<MakeBetPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void newBetCreate(DateTime? selctedDate) {

if(_titleController.text.isEmpty || _descriptionController.text.isEmpty || _amountController.text.isEmpty || {_showDialog();})

    List<String> newBet = [
      _titleController.text,
      _descriptionController.text,
      _amountController.text,
    ];
    widget.onSaveBet(newBet); // Pass the new bet data to the callback
    Navigator.pop(context); // Close MakeBetPage after saving the bet
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Invalid Input'),
        content: const Text(
            'Please make sure a valid title, amount, date and category was entered to be able to save.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyAppColors.backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: MyAppColors.accentColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BetColumn(
                    titleController: _titleController,
                    descriptionController: _descriptionController,
                    amountController: _amountController,
                  ), // Assuming BetColumn is a widget that displays some content
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: newBetCreate,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 90, vertical: 15),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          'Save Bet',
                          style: GoogleFonts.workSans(
                              color: MyAppColors.textColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
