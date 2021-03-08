import 'package:bloc/bloc.dart';
import 'package:frontend_apz/models/device_model.dart';
import 'package:frontend_apz/repositories/device_repository.dart';
import 'package:meta/meta.dart';

part 'device_state.dart';

class DeviceCubit extends Cubit<DeviceState> {
  final DeviceRepository _deviceRepository;

  DeviceCubit(this._deviceRepository) : super(DeviceEmptyState());

  Future<void> fetchUserDevices() async {
    try {
      emit(DeviceLoadingState());
      final List<DeviceModel> _deviceList =
          await _deviceRepository.getUserDevices();
      emit(DeviceLoadedState(deviceList: _deviceList));
    } catch (__) {
      emit(DeviceErrorState());
    }
  }

  Future<void> getDeviceInfo({String deviceId}) async {
    try {
      emit(DeviceLoadingState());
      final List<DeviceModel> _deviceList =
          await _deviceRepository.getDeviceInfo(deviceId: deviceId);
      emit(DeviceLoadedState(deviceList: _deviceList));
    } catch (__) {
      emit(DeviceErrorState());
    }
  }
}
