import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wager_app/models/bet_model.dart';

import '../../../styles/colors.dart';

class BetColumn extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController amountController;

  const BetColumn({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.amountController,
  });

  @override
  State<BetColumn> createState() => _BetColumnState();
}

class _BetColumnState extends State<BetColumn> {
  DateTime? _selectedDate;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Title',
          style: GoogleFonts.workSans(color: colorText, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: containerColor, borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: widget.titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Title',
              hintStyle: GoogleFonts.workSans(
                color: colorAccent,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Description',
          style: GoogleFonts.workSans(color: colorText, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: containerColor, borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: widget.descriptionController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'UCL Winner',
              hintStyle: GoogleFonts.workSans(
                color: colorAccent,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        Text(
          'Amount',
          style: GoogleFonts.workSans(color: colorText, fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: containerColor, borderRadius: BorderRadius.circular(12)),
          child: TextField(
            controller: widget.amountController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'R200',
              hintStyle: GoogleFonts.workSans(
                color: colorAccent,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _selectedDate == null
                  ? 'No Date selcted'
                  : formatter.format(_selectedDate!),
              style: GoogleFonts.workSans(color: colorText, fontSize: 18),
            ),
            IconButton(
                onPressed: _presentDatePicker,
                icon: Image.asset(
                  'lib/assets/calendar.png',
                  height: 30,
                  color: colorAccent,
                ))
          ],
        )
      ],
    );
  }
}
