import 'package:meta/meta.dart';

@immutable
class ProfileState {
  final bool isPhotoEmpty;
  final bool isNameEmpty;
  final bool isInfoEmpty;
  final bool isAgeEmpty;
  final bool isGenderEmpty;
  final bool isSubjectEmpty;
  final bool isLocationEmpty;
  final bool isFailure;
  final bool isSubmitting;
  final bool isSuccess;

  bool get isFormValid =>
      isPhotoEmpty &&
      isNameEmpty &&
      isInfoEmpty &&
      isAgeEmpty &&
      isGenderEmpty &&
      isSubjectEmpty;

  ProfileState({
    @required this.isPhotoEmpty,
    @required this.isNameEmpty,
    @required this.isInfoEmpty,
    @required this.isAgeEmpty,
    @required this.isGenderEmpty,
    @required this.isSubjectEmpty,
    @required this.isLocationEmpty,
    @required this.isFailure,
    @required this.isSubmitting,
    @required this.isSuccess,
  });

  factory ProfileState.empty() {
    return ProfileState(
      isPhotoEmpty: false,
      isFailure: false,
      isSuccess: false,
      isSubmitting: false,
      isNameEmpty: false,
      isInfoEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isSubjectEmpty: false,
      isLocationEmpty: false,
    );
  }

  factory ProfileState.loading() {
    return ProfileState(
      isPhotoEmpty: false,
      isFailure: false,
      isSuccess: false,
      isSubmitting: true,
      isNameEmpty: false,
      isInfoEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isSubjectEmpty: false,
      isLocationEmpty: false,
    );
  }

  factory ProfileState.failure() {
    return ProfileState(
      isPhotoEmpty: false,
      isFailure: true,
      isSuccess: false,
      isSubmitting: false,
      isNameEmpty: false,
      isInfoEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isSubjectEmpty: false,
      isLocationEmpty: false,
    );
  }

  factory ProfileState.success() {
    return ProfileState(
      isPhotoEmpty: false,
      isFailure: false,
      isSuccess: true,
      isSubmitting: false,
      isNameEmpty: false,
      isInfoEmpty: false,
      isAgeEmpty: false,
      isGenderEmpty: false,
      isSubjectEmpty: false,
      isLocationEmpty: false,
    );
  }

  ProfileState update({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isInfoEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty,
    bool isSubjectEmpty,
    bool isLocationEmpty,
  }) {
    return copyWith(
      isFailure: false,
      isSuccess: false,
      isSubmitting: false,
      isPhotoEmpty: isPhotoEmpty,
      isNameEmpty: isNameEmpty,
      isInfoEmpty: isInfoEmpty,
      isAgeEmpty: isAgeEmpty,
      isGenderEmpty: isGenderEmpty,
      isSubjectEmpty: isSubjectEmpty,
      isLocationEmpty: isLocationEmpty,
    );
  }

  ProfileState copyWith({
    bool isPhotoEmpty,
    bool isNameEmpty,
    bool isInfoEmpty,
    bool isAgeEmpty,
    bool isGenderEmpty, 
    bool isSubjectEmpty,
    bool isLocationEmpty,
    bool isSubmitting,
    bool isSuccess,
    bool isFailure,
  }) {
    return ProfileState(
      isPhotoEmpty: isPhotoEmpty ?? this.isPhotoEmpty,
      isNameEmpty: isNameEmpty ?? this.isNameEmpty,
      isInfoEmpty: isInfoEmpty ?? this.isInfoEmpty,
      isLocationEmpty: isLocationEmpty ?? this.isLocationEmpty,
      isGenderEmpty: isGenderEmpty ?? this.isGenderEmpty,
      isSubjectEmpty: isSubjectEmpty ?? this.isSubjectEmpty,
      isAgeEmpty: isAgeEmpty ?? this.isAgeEmpty,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }
}