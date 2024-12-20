import 'package:baykurs/ui/filter/model/PriceModel.dart';

abstract class FilterState {}

class FilterStateLoading extends FilterState {}

class FilterStateSuccess extends FilterState {
  final PriceModel priceModel;

  FilterStateSuccess(this.priceModel);
}

class FilterStateError extends FilterState {
  final String error;

  FilterStateError(this.error);
}
