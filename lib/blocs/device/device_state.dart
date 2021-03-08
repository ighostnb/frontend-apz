part of 'device_cubit.dart';

@immutable
abstract class DeviceState {}

class DeviceEmptyState extends DeviceState {}

class DeviceLoadingState extends DeviceState {}

class DeviceLoadedState extends DeviceState {
  final List<DeviceModel> deviceList;

  DeviceLoadedState({@required this.deviceList}) : assert(deviceList != null);
}

class DeviceErrorState extends DeviceState {}
