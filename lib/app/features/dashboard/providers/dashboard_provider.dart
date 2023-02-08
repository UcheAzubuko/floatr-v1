import 'package:floatr/app/features/dashboard/data/model/response/activities_response.dart';
import 'package:floatr/app/features/dashboard/data/repositories/activities_repository.dart';
import 'package:floatr/core/providers/base_provider.dart';

class DashboardProvider extends BaseProvider {
  final ActivitiesRepository _activitieRepository;

  DashboardProvider({required ActivitiesRepository activitieRepository})
      : _activitieRepository = activitieRepository;

  LoadingState _loadingState = LoadingState.idle;
  String _errorMsg = 'An unknown error occured';

  @override
  LoadingState get loadingState => _loadingState;

  @override
  String get errorMsg => _errorMsg;

  ActivitiesResponse? _activitiesResponse;

  ActivitiesResponse? get activiesResponse => _activitiesResponse;

  @override
  updateLoadingState(LoadingState loadingState) {
    _loadingState = loadingState;
    notifyListeners();
  }

  @override
  updateErrorMsgState(String errorMsg) {
    _errorMsg = errorMsg;
    notifyListeners();
  }

  updateActivies(ActivitiesResponse activitiesResponse) {
    _activitiesResponse = activitiesResponse;
    notifyListeners();
  }

  Future<void> getMyActivies() async {
    updateLoadingState(LoadingState.busy);

    final repsonse = await _activitieRepository.getMyActivies();

    repsonse.fold((onError) {
      updateLoadingState(LoadingState.error);
      updateErrorMsgState(onError.message ?? ' Could not get activities');
    }, (onSuccess) {
      updateLoadingState(LoadingState.loaded);
      updateActivies(onSuccess);
    });
  }
}
