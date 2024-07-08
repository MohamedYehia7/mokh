import 'package:flutter/material.dart';
import 'package:mokh/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokh/invoice_cubit.dart';
import 'package:mokh/invoice_list.dart';
import 'package:mokh/unit_cubit.dart';

import 'dio_helper.dart';


void main() {
  final invoiceRepository = DioHelper();

  runApp(MyApp(invoiceRepository: invoiceRepository));

}

class MyApp extends StatelessWidget {
  final DioHelper invoiceRepository;

  const MyApp({super.key, required this.invoiceRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UnitCubit(DioHelper()),
        ),
        BlocProvider(
          create: (context) => InvoiceCubit(DioHelper()),
        ),
      ],
      child: const MaterialApp(

        home: InvoiceList(),
      ),
    );
  }
}


