class Booking {
  final String name;
  final String contact;
  final String pickUpLocation;
  final String startDate;
  final String endDate;
  final int driverDays;

  Booking({
    required this.name,
    required this.contact,
    required this.pickUpLocation,
    required this.startDate,
    required this.endDate,
    required this.driverDays,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact,
      'pickUpLocation': pickUpLocation,
      'startDate': startDate,
      'endDate': endDate,
      'driverDays': driverDays,
    };
  }
}
