class SpacesModel {
  String name;

  SpacesModel({
    required this.name,
  });

  static List<SpacesModel> getSpaces() {
    return [
      SpacesModel(name: 'Lab. Techno'),
      SpacesModel(name: 'Perpustakaan UGM'),
      SpacesModel(name: 'Perpustakaan Sekolah Vokasi UGM'),
      SpacesModel(name: 'Perpustakaan F. Kehutanan UGM'),
      SpacesModel(name: 'Perpustakaan F. Geogravi UGM'),
      SpacesModel(name: 'Perpustakaan F. Kedokteran UGM'),
      SpacesModel(name: 'Perpustakaan F. Pertanian UGM'),
      SpacesModel(name: 'Perpustakaan F. Farmasi UGM'),
    ];
  }
}
