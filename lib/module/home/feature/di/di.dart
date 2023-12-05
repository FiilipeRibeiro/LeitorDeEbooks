import '../../../../config/network_client_dio.dart';
import '../network/ebook_network_client.dart';
import '../viewModel/home_view_model.dart';

final homeViewModelBuilder = HomeViewModelImpl(
  ebookNetwork: EbookNetworkClient(
    NetworkClientDio(),
  ),
);
