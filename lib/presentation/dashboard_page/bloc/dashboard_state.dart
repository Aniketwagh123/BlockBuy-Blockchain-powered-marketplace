// ignore_for_file: must_be_immutable

part of 'dashboard_bloc.dart';

// ignore_for_file: must_be_immutable

// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import '../models/dashboard_model.dart';

// part of 'dashboard_bloc.dart';

/// Represents the state of Dashboard in the application.
class DashboardState extends Equatable {
  DashboardState({
    this.sliderIndex = 0,
    this.dashboardModelObj,
  });

  DashboardModel? dashboardModelObj;
  int sliderIndex;

  @override
  List<Object?> get props => [
        sliderIndex,
        dashboardModelObj,
      ];

  DashboardState copyWith({
    int? sliderIndex,
    DashboardModel? dashboardModelObj,
    Map<String, dynamic>? productData,
  }) {
    return DashboardState(
      sliderIndex: sliderIndex ?? this.sliderIndex,
      dashboardModelObj: dashboardModelObj ?? this.dashboardModelObj,
    );
  }
}

/// Represents the loading state of Dashboard in the application.
/// Represents the loading state of Dashboard in the application.
class DashboardLoadingState extends DashboardState {
  DashboardLoadingState({int sliderIndex = 0, DashboardModel? dashboardModelObj})
      : super(sliderIndex: sliderIndex, dashboardModelObj: dashboardModelObj);
}


