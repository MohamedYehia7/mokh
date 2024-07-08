import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mokh/invoice_cubit.dart';
import 'package:mokh/product.dart';
import 'package:mokh/unit.dart';
import 'package:mokh/unit_cubit.dart';


class InvoiceDetailPage extends StatefulWidget {
  final Product? invoiceDetail;

  const InvoiceDetailPage({super.key, this.invoiceDetail});

  @override
  _InvoiceDetailPageState createState() => _InvoiceDetailPageState();
}

class _InvoiceDetailPageState extends State<InvoiceDetailPage> {
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _unitNoController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _expiryDateController = TextEditingController();
  Unit? _selectedUnit;

  @override
  void initState() {
    super.initState();
    if (widget.invoiceDetail != null) {
      _productNameController.text = widget.invoiceDetail!.productName!;
      _unitNoController.text = widget.invoiceDetail!.unitNo.toString();
      _priceController.text = widget.invoiceDetail!.price.toString();
      _quantityController.text = widget.invoiceDetail!.quantity.toString();
      _expiryDateController.text = widget.invoiceDetail!.expiryDate!.toString();
      _selectedUnit = widget.invoiceDetail!.unit;
    }
    context.read<UnitCubit>().fetchUnits();
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _unitNoController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _expiryDateController.dispose();
    super.dispose();
  }

  void _saveInvoiceDetail() {
    if (_formKey.currentState!.validate()) {
      final invoiceDetail = Product(
        lineNo: widget.invoiceDetail?.lineNo ?? 0,
        productName: _productNameController.text,
        unit: _selectedUnit!,
        unitNo: int.parse(_unitNoController.text),
        price: int.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        total: int.parse(_priceController.text) * int.parse(_quantityController.text),
        expiryDate: _expiryDateController.text,
      );

      if (widget.invoiceDetail == null) {
        context.read<InvoiceCubit>().saveInvoiceDetail(invoiceDetail);
      } else {
        context.read<InvoiceCubit>().updateInvoiceDetail(invoiceDetail);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.invoiceDetail == null ? 'Add Invoice Detail' : 'Edit Invoice Detail'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _productNameController,
                decoration: const InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              BlocBuilder<UnitCubit, UnitState>(
                builder: (context, state) {
                  if (state is UnitLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is UnitError) {
                    return Text(state.message);
                  } else if (state is UnitLoaded) {

                    return state.units.isEmpty ? const Text('No units found') : DropdownButtonFormField<Unit>(
                      value: _selectedUnit,
                      items: state.units.map((unit) {
                        return DropdownMenuItem<Unit>(
                          value: unit,
                          child: Text(unit.name ?? ''),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value!;
                        });
                      },
                      decoration: const InputDecoration(labelText: 'Unit'),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a unit';
                        }
                        return null;
                      },
                    );
                  }
                  return Container();
                },
              ),
              TextFormField(
                controller: _unitNoController,
                decoration: const InputDecoration(labelText: 'Unit No'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration: const InputDecoration(labelText: 'Expiry Date'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an expiry date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveInvoiceDetail,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
