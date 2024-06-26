import 'dart:collection';

import 'package:buecherteam_2023_desktop/UI/add_book_student_detail_dialog/student_detail_add_book_card.dart';

import 'package:flutter/material.dart';

import '../../Data/bookLite.dart';

class AddBookStudentDetailList extends StatefulWidget {
  const AddBookStudentDetailList({
    super.key,
    required this.books,
    required this.onAddSelectedBook,
    required this.onRemoveSelectedBook,
  });

  final List<BookLite> books;
  final Function(BookLite bookLite) onAddSelectedBook;
  final Function(BookLite bookLite) onRemoveSelectedBook;

  @override
  State<AddBookStudentDetailList> createState() =>
      _AddBookStudentDetailListState();
}

class _AddBookStudentDetailListState extends State<AddBookStudentDetailList> {
  HashSet<BookLite> selectedBooks = HashSet(); //maintain UI State

  @override
  Widget build(BuildContext context) {
    widget.books.sort(
        orderBySelectedBooks); //show the checked/selected books at the top
    return ListView.builder(
      itemCount: widget.books.length,
      itemBuilder: (context, index) {
        return StudentDetailAddBookCard(
          onCheckChanged: (book) {
            //onCheckChanged is called when the checkbox is clicked
            /*
                  * 1. Check if the book is already in the selectedBooks
                  * 2. If it is not in the selectedBooks, add it
                  * 3. If it is in the selectedBooks, remove it
                  * */
            if (!selectedBooks.contains(book)) {
              addToSelectedBooks(book);
              widget.onAddSelectedBook(book);
            } else {
              removeFromSelectedBooks(book);
              widget.onRemoveSelectedBook(book);
            }
          },
          bookLite: widget.books[index], //bookLite to display
          isChecked: selectedBooks.contains(widget.books[index]),
        );
      },
    );
  }

  void addToSelectedBooks(BookLite book) {
    setState(() {
      selectedBooks.add(book);
    });
  }

  void removeFromSelectedBooks(BookLite book) {
    setState(() {
      selectedBooks.remove(book);
    });
  }

  int orderBySelectedBooks(BookLite a, BookLite b) {
    // Check if a is in selectedBooks
    bool aIsSelected = selectedBooks.contains(a);

    // Check if b is in selectedBooks
    bool bIsSelected = selectedBooks.contains(b);

    // Compare based on whether the books are selected or not
    if (aIsSelected && !bIsSelected) {
      return -1; // a comes first
    } else if (!aIsSelected && bIsSelected) {
      return 1; // b comes first
    } else {
      return 0; // Maintain the original order for non-selected books
    }
  }
}
