import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mokh/dio_helper.dart';
import 'package:mokh/unit.dart';

part 'unit_state.dart';

class UnitCubit extends Cubit<UnitState> {
  final DioHelper invoiceRepository;

  UnitCubit(this.invoiceRepository) : super(UnitInitial());

  Future<void> fetchUnits() async {
    try {
      emit(UnitLoading());
      final units = await invoiceRepository.fetchUnits();
      emit(UnitLoaded(units));
    } catch (e) {
      emit(UnitError('Failed to fetch units'));
    }
  }
}

