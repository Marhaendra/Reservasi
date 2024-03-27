class LocationModel {
  String name;

  LocationModel({
    required this.name,
  });

  static List<LocationModel> getLocation() {
    return [
      LocationModel(name: 'Jakarta'),
      LocationModel(name: 'Yogyakarta'),
      LocationModel(name: 'Bekasi'),
      LocationModel(name: 'Surabaya'),
      LocationModel(name: 'Bandung'),
      LocationModel(name: 'Semarang'),
      LocationModel(name: 'Tangerang'),
      LocationModel(name: 'Bogor'),
      LocationModel(name: 'Malang'),
      LocationModel(name: 'Cirebon'),
    ];
  }
}
