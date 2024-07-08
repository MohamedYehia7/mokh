part of 'invoice_cubit.dart';

@immutable
abstract class InvoiceState {}

final class InvoiceInitial extends InvoiceState {}

class InvoiceLoading extends InvoiceState {}

class InvoiceLoaded extends InvoiceState {
  final List<Product> invoices;

  InvoiceLoaded(this.invoices);

}

class InvoiceError extends InvoiceState {
  final String message;

  InvoiceError(this.message);

  
}
