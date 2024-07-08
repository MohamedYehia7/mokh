import 'package:flutter/material.dart';
import 'package:mokh/invoice_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokh/invoice_details.dart';

class InvoiceList extends StatelessWidget {
  const InvoiceList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InvoiceDetailPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<InvoiceCubit, InvoiceState>(
              builder: (context, state) {

                if (state is InvoiceLoaded) {
                  return ListView.builder(
                    itemCount: state.invoices.length,
                    itemBuilder: (context, index) {
                      final invoiceDetail = state.invoices[index];
                      return Card(
                        margin: EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(invoiceDetail.productName!),
                          subtitle: Text('Total: \$${invoiceDetail.total}'),
                          trailing: IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      InvoiceDetailPage(
                                        invoiceDetail: invoiceDetail,
                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();

              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.first_page),
                  onPressed: () {
                    // Navigate to the first page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    // Navigate to the previous page
                  },
                ),
                Text('Page 1 of 1'),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    // Navigate to the next page
                  },
                ),
                IconButton(
                  icon: Icon(Icons.last_page),
                  onPressed: () {
                    // Navigate to the last page
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
