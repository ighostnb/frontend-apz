import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_apz/blocs/device/device_cubit.dart';

class DevicePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, DeviceState>(
      builder: (context, state) {
        if (state is DeviceEmptyState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is DeviceLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state is DeviceLoadedState) {
          if (state.deviceList == null || state.deviceList.isEmpty) {
            return Center(
              child: Text('Devices are empty'),
            );
          }

          return ListView.builder(
            itemCount: state.deviceList.length,
            itemBuilder: (context, index) {
              return Container(
                height: 100,
                child: Column(
                  children: [
                    Text(state.deviceList[index].deviceName),
                  ],
                ),
              );
            },
          );
        }

        if (state is DeviceErrorState) {
          return Center(
            child: Text('Network error'),
          );
        }

        return Container();
      },
    );
  }
}
