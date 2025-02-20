import 'package:equatable/equatable.dart';

class AdminCarState extends Equatable {
  final bool isLoading;
  final bool isUploadingImage;
  final bool isSuccess;
  final String? imageUrl;
  final String? uploadError;
  final String? errorMessage;

  const AdminCarState({
    required this.isLoading,
    required this.isUploadingImage,
    required this.isSuccess,
    this.imageUrl,
    this.uploadError,
    this.errorMessage,
  });

  factory AdminCarState.initial() => const AdminCarState(
        isLoading: false,
        isUploadingImage: false,
        isSuccess: false,
      );

  AdminCarState copyWith({
    bool? isLoading,
    bool? isUploadingImage,
    bool? isSuccess,
    String? imageUrl,
    String? uploadError,
    String? errorMessage,
  }) {
    return AdminCarState(
      isLoading: isLoading ?? this.isLoading,
      isUploadingImage: isUploadingImage ?? this.isUploadingImage,
      isSuccess: isSuccess ?? this.isSuccess,
      imageUrl: imageUrl ?? this.imageUrl,
      uploadError: uploadError,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isUploadingImage,
        isSuccess,
        imageUrl,
        uploadError,
        errorMessage
      ];
}
