enum Branches {
  Mathematics,
  Turkish,
  Physics,
  Chemistry,
  Biology,
  Geometry,
  History,
  Geography,
}

extension BranchesExtension on Branches {
  String get value {
    switch (this) {
      case Branches.Mathematics:
        return "Matematik";
      case Branches.Turkish:
        return "Türkçe";
      case Branches.Physics:
        return "Fizik";
      case Branches.Chemistry:
        return "Kimya";
      case Branches.Biology:
        return "Biyoloji";
      case Branches.Geometry:
        return "Geometri";
      case Branches.History:
        return "Tarih";
      case Branches.Geography:
        return "Coğrafya";
    }
  }

  List<BranchTopic> get topics {
    switch (this) {
      case Branches.Mathematics:
        return [
          BranchTopic(id: 1, name: "Cebir"),
          BranchTopic(id: 2, name: "Geometri"),
          BranchTopic(id: 3, name: "Fonksiyonlar"),
          BranchTopic(id: 4, name: "Denklemler"),
          BranchTopic(id: 5, name: "İstatistik"),
        ];
      case Branches.Turkish:
        return [
          BranchTopic(id: 1, name: "Okuma ve Anlama"),
          BranchTopic(id: 2, name: "Yazılı Anlatım"),
          BranchTopic(id: 3, name: "Türk Edebiyatı"),
          BranchTopic(id: 4, name: "Gramer"),
          BranchTopic(id: 5, name: "Sözcük Türleri"),
        ];
      case Branches.Physics:
        return [
          BranchTopic(id: 1, name: "Kuvvet ve Hareket"),
          BranchTopic(id: 2, name: "Elektrik ve Manyetizma"),
          BranchTopic(id: 3, name: "Optik"),
          BranchTopic(id: 4, name: "Işık ve Ses"),
          BranchTopic(id: 5, name: "Termodinamik"),
        ];
      case Branches.Chemistry:
        return [
          BranchTopic(id: 1, name: "Atom ve Periyodik Tablo"),
          BranchTopic(id: 2, name: "Kimyasal Tepkimeler"),
          BranchTopic(id: 3, name: "Asitler ve Bazlar"),
          BranchTopic(id: 4, name: "Karbon Kimyası"),
          BranchTopic(id: 5, name: "Organik Kimya"),
        ];
      case Branches.Biology:
        return [
          BranchTopic(id: 1, name: "Hücre ve Organeller"),
          BranchTopic(id: 2, name: "Genetik"),
          BranchTopic(id: 3, name: "Ekosistemler"),
          BranchTopic(id: 4, name: "Fizyoloji"),
          BranchTopic(id: 5, name: "Evrim"),
        ];
      case Branches.Geometry:
        return [
          BranchTopic(id: 1, name: "Düzlem Geometri"),
          BranchTopic(id: 2, name: "Çokgenler"),
          BranchTopic(id: 3, name: "Dönme ve Çevirme"),
          BranchTopic(id: 4, name: "Vektörler"),
          BranchTopic(id: 5, name: "Analitik Geometri"),
        ];
      case Branches.History:
        return [
          BranchTopic(id: 1, name: "Türk Tarihi"),
          BranchTopic(id: 2, name: "Osmanlı İmparatorluğu"),
          BranchTopic(id: 3, name: "Cumhuriyet Tarihi"),
          BranchTopic(id: 4, name: "Dünya Tarihi"),
          BranchTopic(id: 5, name: "İnkılap Tarihi"),
        ];
      case Branches.Geography:
        return [
          BranchTopic(id: 1, name: "Fiziki Coğrafya"),
          BranchTopic(id: 2, name: "Nüfus ve Yerleşim"),
          BranchTopic(id: 3, name: "İklim ve Hava Olayları"),
          BranchTopic(id: 4, name: "Doğal Kaynaklar"),
          BranchTopic(id: 5, name: "Harita Okuma"),
        ];
    }
  }

  static List<Branch> getAllBranches() {
    return Branches.values.map((branch) {
      return Branch(
        id: branch.index + 1,
        name: branch.value,
        topics: branch.topics,
      );
    }).toList();
  }
}

class Branch {
  final String name;
  final int id;
  final List<BranchTopic> topics;

  Branch({required this.name, required this.id, required this.topics});

  // Override == and hashCode to ensure uniqueness
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Branch && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

class BranchTopic {
  final String name;
  final int id;

  BranchTopic({required this.name, required this.id});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BranchTopic && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
