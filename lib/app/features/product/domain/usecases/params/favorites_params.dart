import '../../../../../core/usecase/params.dart';
import '../../entities/product.dart';

final class FavoritesParams extends BaseParams {
  final Product product;

  const FavoritesParams(this.product);

  @override
  List<Object?> get props => [product];
}
