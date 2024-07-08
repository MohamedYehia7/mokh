import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokh/dio_helper.dart';
import 'package:mokh/product.dart';

part 'invoice_state.dart';

class InvoiceCubit extends Cubit<InvoiceState> {
  final DioHelper invoiceRepository;
  InvoiceCubit(this.invoiceRepository) : super(InvoiceInitial());


  Future<void> fetchInvoiceDetails() async {
    try {
      emit(InvoiceLoading());
      final invoices = await invoiceRepository.fetchProduct();
      emit(InvoiceLoaded(invoices));
    } catch (e) {
      emit(InvoiceError('Failed to fetch invoice details'));
    }
  }

  Future<void> saveInvoiceDetail(Product invoiceDetail) async {
    try {
      await invoiceRepository.saveProduct(invoiceDetail);
      fetchInvoiceDetails();
    } catch (e) {
      emit(InvoiceError('Failed to save invoice detail'));
    }
  }
  Future<void> updateInvoiceDetail(Product invoiceDetail) async {
    try {
      await invoiceRepository.updateProduct(invoiceDetail);
      fetchInvoiceDetails();
    } catch (e) {
      emit(InvoiceError('Failed to update invoice detail'));
    }
  }




}
