import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:wheeloop/features/car/data/repository/car_repo.dart';
import 'package:wheeloop/features/car/domain/entity/car_entity.dart';
import 'package:wheeloop/features/car/domain/use_case/car_usecaes.dart';

// Create a mock class for CarRepository
class MockCarRepository extends Mock implements CarRepository {}

void main() {
  group('GetCars Use Case', () {
    late MockCarRepository mockCarRepository;
    late GetCars getCars;

    setUp(() {
      mockCarRepository = MockCarRepository();
      getCars = GetCars(mockCarRepository);
    });

    test('should return a list of cars when the repository call is successful',
        () async {
      // Arrange
      final cars = [
        Car(id: '1', name: 'Car A', price: 100.0, imageUrl: 'http://carA.jpg'),
        Car(id: '2', name: 'Car B', price: 200.0, imageUrl: 'http://carB.jpg')
      ];
      when(() => mockCarRepository.getCars()).thenAnswer((_) async => cars);

      // Act
      final result = await getCars.call();

      // Assert
      expect(result, cars);
      verify(() => mockCarRepository.getCars()).called(1);
    });

    test('should throw an exception if repository call fails', () async {
      // Arrange
      when(() => mockCarRepository.getCars())
          .thenThrow(Exception('Failed to fetch cars'));

      // Act & Assert
      expect(() => getCars.call(), throwsA(isA<Exception>()));
    });
  });

  group('GetCarDetails Use Case', () {
    late MockCarRepository mockCarRepository;
    late GetCarDetails getCarDetails;

    setUp(() {
      mockCarRepository = MockCarRepository();
      getCarDetails = GetCarDetails(mockCarRepository);
    });

    test('should return car details when the repository call is successful',
        () async {
      // Arrange
      final car = Car(
          id: '1', name: 'Car A', price: 100.0, imageUrl: 'http://carA.jpg');
      when(() => mockCarRepository.getCarDetails('1'))
          .thenAnswer((_) async => car);

      // Act
      final result = await getCarDetails.call('1');

      // Assert
      expect(result, car);
      verify(() => mockCarRepository.getCarDetails('1')).called(1);
    });

    test('should throw an exception if repository call fails', () async {
      // Arrange
      when(() => mockCarRepository.getCarDetails('1'))
          .thenThrow(Exception('Failed to fetch car details'));

      // Act & Assert
      expect(() => getCarDetails.call('1'), throwsA(isA<Exception>()));
    });
  });
}
