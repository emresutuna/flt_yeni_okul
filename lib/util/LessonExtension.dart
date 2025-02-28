enum Branches {
  Mathematics,
  Turkish,
  TurkishLanguageAndLiterature,
  ScienceAndTechnology,
  Physics,
  SocialStudies,
  HistoryOfRevolutionAndKemalism,
  History,
  English,
  Chemistry,
  Biology,
  Geography,
  Geometry
}

enum ClassTypes {
  FifthGrade(5),
  SixthGrade(6),
  SeventhGrade(7),
  EighthGrade(8),
  NinthGrade(9),
  TenthGrade(10),
  EleventhGrade(11),
  TwelfthGrade(12),
  Grade(13);

  final int gradeValue;

  const ClassTypes(this.gradeValue);
}

List<Branches> getBranchesForClassType(ClassTypes classType) {
  switch (classType) {
    case ClassTypes.FifthGrade:
    case ClassTypes.SixthGrade:
    case ClassTypes.SeventhGrade:
      return [
        Branches.Turkish,
        Branches.Mathematics,
        Branches.ScienceAndTechnology,
        Branches.SocialStudies,
        Branches.English,
      ];
    case ClassTypes.EighthGrade:
      return [
        Branches.Turkish,
        Branches.Mathematics,
        Branches.ScienceAndTechnology,
        Branches.HistoryOfRevolutionAndKemalism,
        Branches.English,
      ];
    case ClassTypes.NinthGrade:
      return [
        Branches.TurkishLanguageAndLiterature,
        Branches.Mathematics,
        Branches.Physics,
        Branches.Chemistry,
        Branches.Biology,
        Branches.History,
        Branches.Geography,
      ];
    case ClassTypes.TenthGrade:
      return [
        Branches.TurkishLanguageAndLiterature,
        Branches.Mathematics,
        Branches.Physics,
        Branches.Chemistry,
        Branches.Biology,
        Branches.History,
        Branches.Geography,
      ];
    case ClassTypes.EleventhGrade:
      return [
        Branches.TurkishLanguageAndLiterature,
        Branches.Mathematics,
        Branches.Physics,
        Branches.Chemistry,
        Branches.Biology,
        Branches.Geometry,
        Branches.History,
        Branches.Geography,
      ];
    case ClassTypes.TwelfthGrade:
      return [
        Branches.TurkishLanguageAndLiterature,
        Branches.Mathematics,
        Branches.Physics,
        Branches.Chemistry,
        Branches.Biology,
        Branches.Geometry,
        Branches.History,
        Branches.Geography,
      ];
    case ClassTypes.Grade:
      return {
        ...getBranchesForClassType(ClassTypes.NinthGrade),
        ...getBranchesForClassType(ClassTypes.TenthGrade),
        ...getBranchesForClassType(ClassTypes.EleventhGrade),
        ...getBranchesForClassType(ClassTypes.TwelfthGrade),
      }.toList();
    default:
      return [];
  }
}

extension ClassTypesExtension on ClassTypes {
  String get value {
    switch (this) {
      case ClassTypes.FifthGrade:
        return "5. Sınıf";
      case ClassTypes.SixthGrade:
        return "6. Sınıf";
      case ClassTypes.SeventhGrade:
        return "7. Sınıf";
      case ClassTypes.EighthGrade:
        return "8. Sınıf";
      case ClassTypes.NinthGrade:
        return "9. Sınıf";
      case ClassTypes.TenthGrade:
        return "10. Sınıf";
      case ClassTypes.EleventhGrade:
        return "11. Sınıf";
      case ClassTypes.TwelfthGrade:
        return "12. Sınıf";
      case ClassTypes.Grade:
        return "Mezun";
    }
  }

  static ClassTypes? fromDisplay(String displayValue) {
    for (var grade in ClassTypes.values) {
      if (grade.value == displayValue) {
        return grade;
      }
    }
    return null; // Eşleşme yoksa null döner
  }

  /// Sayısal değerden enum'a dönüşüm
  static ClassTypes? fromGradeValue(int gradeValue) {
    try {
      return ClassTypes.values.firstWhere(
        (grade) => grade.gradeValue == gradeValue,
      );
    } catch (e) {
      return null;
    }
  }

  static int? getGradeValueFromDisplay(String displayValue) {
    for (var grade in ClassTypes.values) {
      if (grade.value == displayValue) {
        return grade.gradeValue;
      }
    }
    return null;
  }
}

class ClassLevelBranch {
  final String classLevel;
  final Branches branch;
  final List<BranchTopic> topics;

  ClassLevelBranch(
      {required this.classLevel, required this.branch, required this.topics});
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
      case Branches.TurkishLanguageAndLiterature:
        return "Türk Dili ve Edebiyatı";
      case Branches.ScienceAndTechnology:
        return "Fen ve Teknoloji";
      case Branches.SocialStudies:
        return "Sosyal Bilgiler";
      case Branches.HistoryOfRevolutionAndKemalism:
        return "İnkılap Tarihi ve Atatürkçülük";
      case Branches.English:
        return "İngilizce";
    }
  }

  static List<Branches> get allBranches {
    return Branches.values;
  }

  static String getBranchNameByLessonId(int? lessonId) {
    if (lessonId == null) return "Bilinmeyen Ders";

    Map<int, String> lessonIdToBranchName = {
      1: "Matematik",
      2: "Türkçe",
      3: "Fizik",
      4: "Kimya",
      5: "Biyoloji",
      6: "Geometri",
      7: "Tarih",
      8: "Coğrafya",
      9: "Türk Dili ve Edebiyatı",
      10: "Fen ve Teknoloji",
      11: "Sosyal Bilgiler",
      12: "İnkılap Tarihi ve Atatürkçülük",
      13: "İngilizce",
    };

    return lessonIdToBranchName[lessonId] ?? "Bilinmeyen Ders";
  }

  static const Map<String, String> branchColors = {
    "Matematik": "#4A90E2",
    "Türkçe": "#FFA500",
    "Fizik": "#FFD700",
    "Kimya": "#48C9B0",
    "Biyoloji": "#A9DFBF",
    "Geometri": "#97819F",
    "Tarih": "#FF6F61",
    "Coğrafya": "#58D68D",
    "Türk Dili ve Edebiyatı": "#A88F61",
    "Fen ve Teknoloji": "#E94E77",
    "Sosyal Bilgiler": "#8E44AD",
    "İnkılap Tarihi ve Atatürkçülük": "#C0392B",
    "İngilizce": "#F364D0",
    "Eğitim Koçu": "#413F42",
  };

  static String? getColorForBranch(String branchName) {
    return branchColors[branchName];
  }

  static Branches? fromTurkishName(String turkishName) {
    Map<String, Branches> nameToBranchMap = {
      "Matematik": Branches.Mathematics,
      "Türkçe": Branches.Turkish,
      "Fizik": Branches.Physics,
      "Kimya": Branches.Chemistry,
      "Biyoloji": Branches.Biology,
      "Geometri": Branches.Geometry,
      "Tarih": Branches.History,
      "Coğrafya": Branches.Geography,
      "Türk Dili ve Edebiyatı": Branches.TurkishLanguageAndLiterature,
      "Fen ve Teknoloji": Branches.ScienceAndTechnology,
      "Sosyal Bilgiler": Branches.SocialStudies,
      "İnkılap Tarihi ve Atatürkçülük": Branches.HistoryOfRevolutionAndKemalism,
      "İngilizce": Branches.English,
    };

    return nameToBranchMap[turkishName];
  }
}

List<BranchTopic> returnFilterByBranches(
    List<ClassLevelBranch> branches, Branches branch) {
  return branches
      .where((branch) => branch.branch.value == branch.branch.value)
      .expand((branch) => branch.topics)
      .toList();
}

List<BranchTopic> filterBranchTopicsByBranch(
    List<ClassLevelBranch> branches, Branches branch) {
  return branches
      .where((b) => b.branch == branch)
      .expand((b) => b.topics)
      .toList();
}

List<BranchTopic> filterBranchTopicsByBranchId(
    List<ClassLevelBranch> branches, int branchId) {
  return branches
      .where((b) => b.branch.index == branchId)
      .expand((b) => b.topics)
      .toList();
}

List<ClassLevelBranch> classLevelBranches = [
  ClassLevelBranch(
    classLevel: ClassTypes.FifthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 1,
        name: "Dikdörtgenler",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 2,
        name: "Geometrik Şekiller",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 3,
        name: "Olasılık",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 4,
        name: "Kesirler",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 5,
        name: "İşlemlerle Cebirsel Düşünme",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 6,
        name: "İstatiksel Araştırma Süreci",
        className: ClassTypes.FifthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.SixthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 7,
        name: "Doğal Sayılarla İşlemler",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 8,
        name: "Çarpanlar ve Katlar",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 9,
        name: "Kümeler",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 10,
        name: "Tam Sayılar",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 11,
        name: "Kesirlerde İşlemler",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 12,
        name: "Ondalık Gösterimler",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 13,
        name: "Oran",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 14,
        name: "Cebirsel İfadeler",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 15,
        name: "Veri Analizi",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 16,
        name: "Açılar",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 17,
        name: "Alan Ölçme",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 18,
        name: "Çember",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 19,
        name: "Geometrik Cisimler ve Hacim Ölçme",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 20,
        name: "Sıvıları Ölçme",
        className: ClassTypes.SixthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.SeventhGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 21,
        name: "Tam Sayılarla İşlemler",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 22,
        name: "Rasyonel Sayılar",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 23,
        name: "Cebirsel İfadeler ve Denklem",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 24,
        name: "Oran Orantı",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 25,
        name: "Yüzdeler",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 26,
        name: "Doğrular ve Açılar",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 27,
        name: "Çokgenler",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 28,
        name: "Çember ve Daire",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 29,
        name: "Veri İşleme",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 30,
        name: "Cisimlerin Farklı Yönlerden Görünümleri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.EighthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 31,
        name: "Çarpanlar ve Katlar",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 32,
        name: "Üslü İfadeler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 33,
        name: "Kareköklü İfadeler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 34,
        name: "Veri Analizi",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 35,
        name: "Olasılık",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 36,
        name: "Cebirsel İfadeler ve Özdeşlikler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 37,
        name: "Doğrusal Denklemler ve Eşitsizlikler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 38,
        name: "Üçgenler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 39,
        name: "Dönüşüm Geometrisi",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 40,
        name: "Geometrik Cisimler",
        className: ClassTypes.EighthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.NinthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 41,
        name: "Algoritma ve Bilişim",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 42,
        name: "Eşlik ve Benzerlik",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 43,
        name: "Geometrik Şekiller",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 44,
        name: "İstatistiksel Araştırma Süreci",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 45,
        name: "Nicelikler ve Değişimler",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 46,
        name: "Sayılar",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 47,
        name: "Veriden Olasılığa",
        className: ClassTypes.NinthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.TenthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 48,
        name: "Veri – Sayma – Olasılık",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 49,
        name: "Fonksiyon",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 50,
        name: "Polinomlar",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 51,
        name: "II. Dereceden Denklemler",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 52,
        name: "Çokgen Dörtgen",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 53,
        name: "Özel Dörtgenler",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 54,
        name: "Katı Cisim",
        className: ClassTypes.TenthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.EleventhGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 55,
        name: "Trigonometri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 56,
        name: "Fonksiyon Uygulamaları",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 57,
        name: "Denklem ve Eşitsizlik Sistemleri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 58,
        name: "Veri – Sayma – Olasılık",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 59,
        name: "Analitik Geometri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 60,
        name: "Çember ve Daire",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 61,
        name: "Katı Cisim",
        className: ClassTypes.EleventhGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: ClassTypes.TwelfthGrade.value,
    branch: Branches.Mathematics,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 62,
        name: "Sayılar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 63,
        name: "Üslü Sayılar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 64,
        name: "Köklü Sayılar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 65,
        name: "I. Dereceden Denklem ve Eşitsizlikler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 66,
        name: "Oran ve Orantı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 67,
        name: "Denklem Kurma Problemleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 68,
        name: "Kümeler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 69,
        name: "Polinomlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 70,
        name: "Permütasyon – Kombinasyon Binom – Olasılık",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 71,
        name: "Veri İstatistik",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 72,
        name: "Önermeler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 73,
        name: "Çarpanlara Ayırma ve Özdeşlikler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 74,
        name: "II. Dereceden Denklemler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 75,
        name: "Fonksiyon",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 76,
        name: "II. Dereceden Eşitsizlikler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 77,
        name: "Logaritma",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 78,
        name: "Diziler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 79,
        name: "Limit – Süreklilik",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 80,
        name: "Türev",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 81,
        name: "İntegral",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 1,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "5.Sınıf",
    branch: Branches.Turkish,
    topics: [
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 82,
        name: "Atatürk’ü Tanımak",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 83,
        name: "Duyularımı Tanıyorum",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 84,
        name: "Geleneklerimiz",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 85,
        name: "İletişim Ve Sosyal İlişkiler",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 86,
        name: "Oyun Dünyası",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 87,
        name: "Sağlıklı Yaşıyorum",
        className: ClassTypes.FifthGrade.value,
        parentId: 2,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "6. Sınıf",
    branch: Branches.Turkish,
    topics: [
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 88,
        name: "Sözcükte Anlam",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 89,
        name: "Sözcük Türleri",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 90,
        name: "Cümlede Anlam",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 91,
        name: "Sözcükte Yapı",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 92,
        name: "Paragrafta Anlam",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 93,
        name: "Yazım Kuralları",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 94,
        name: "Noktalama İşaretleri",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 95,
        name: "Metin Türleri",
        className: ClassTypes.SixthGrade.value,
        parentId: 2,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "7. Sınıf",
    branch: Branches.Turkish,
    topics: [
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 96,
        name: "Fiiller",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 97,
        name: "Sözcükte Anlam",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 98,
        name: "Zarflar",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 99,
        name: "Ek Fiiller",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 100,
        name: "Cümlede Anlam",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 101,
        name: "Paragrafta Anlam",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 102,
        name: "Anlatım Biçimleri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 103,
        name: "Fiilde Yapı",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 104,
        name: "Deyim ve Atasözü",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 105,
        name: "Söz Sanatları ve Yazı Türleri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 106,
        name: "Yazım Kuralları",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 107,
        name: "Anlatım Bozuklukları",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 108,
        name: "Noktalama İşaretleri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 2,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "8. Sınıf",
    branch: Branches.Turkish,
    topics: [
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 109,
        name: "Fiilimsiler",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 110,
        name: "Sözcükte Anlam",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 111,
        name: "Paragrafta Anlam",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 112,
        name: "Anlatım Biçimleri",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 113,
        name: "Yazım Kuralları",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 114,
        name: "Noktalama İşaretleri",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 115,
        name: "Cümlenin Ögeleri",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 116,
        name: "Metin Türleri ve Söz Sanatları",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 117,
        name: "Fiilde Çatı",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 118,
        name: "Cümle Türleri",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 119,
        name: "Anlatım Bozuklukları",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 120,
        name: "Sözel Mantık ve Muhakeme",
        className: ClassTypes.EighthGrade.value,
        parentId: 2,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.TurkishLanguageAndLiterature,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 121,
        name: "Edebiyata Giriş",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 122,
        name: "Tiyatro",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 123,
        name: "Masal / Fabl",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 124,
        name: "Günlük/Blog",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 125,
        name: "Mektup/E-Posta",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 126,
        name: "Biyografi/Otobiyografi",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 127,
        name: "Şiir",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 128,
        name: "Hikaye (Öykü)",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 129,
        name: "Roman",
        className: ClassTypes.NinthGrade.value,
        parentId: 3,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.TurkishLanguageAndLiterature,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 130,
        name: "Yazım Kuralları",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 131,
        name: "Noktalama İşaretleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 132,
        name: "Edebiyatın Bilim Dallarıyla İlişkisi",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 133,
        name: "Halk Hikayeleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 134,
        name: "İslamiyet Etkisinde Edebiyat (Geçiş Dönemi)",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 135,
        name: "Divan Edebiyatı Nazım Biçimleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 136,
        name: "Anlatmaya Bağlı Metinler",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 137,
        name: "Sözcük Türleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 138,
        name: "İslamiyet Öncesi Türk Edebiyatı",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 139,
        name: "Halk Edebiyatı Nazım Biçimleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 140,
        name: "Tanzimat Edebiyatı",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 141,
        name: "Servetifünun Edebiyatı",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 142,
        name: "Milli Edebiyat",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 143,
        name: "Cümle Türleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 3,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.TurkishLanguageAndLiterature,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 144,
        name: "Edebiyat ve Toplum",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 145,
        name: "Edebi Akımlar",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 146,
        name: "Cumhuriyet Edebiyatı",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 147,
        name: "Cümlenin Ögeleri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 148,
        name: "Tanzimat Edebiyatı",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 149,
        name: "Servetifünun Edebiyatı",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 150,
        name: "Fecriati Edebiyatı",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 151,
        name: "Milli Edebiyat",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 152,
        name: "Öğretici Metinler",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 153,
        name: "Anlatım Bozuklukları",
        className: ClassTypes.EleventhGrade.value,
        parentId: 3,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.TurkishLanguageAndLiterature,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 154,
        name: "Sözcükte Anlam",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 155,
        name: "Cümlede Anlam",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 156,
        name: "Paragraf",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 157,
        name: "Sözcük Türleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 158,
        name: "Şekil Bilgisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 159,
        name: "Cümlenin Ögeleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 160,
        name: "Fiilde Çatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 161,
        name: "Cümle Türleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 162,
        name: "Anlatım Bozuklukları",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 163,
        name: "Ses Bilgisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 164,
        name: "Yazım (İmla Kuralları)",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 165,
        name: "Noktalama İşaretleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 166,
        name: "Coşku ve Heyecanı Dile Getiren Metinler (Şiir)",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 167,
        name: "Öğretici Metinler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 168,
        name: "Edebi Sanatlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 169,
        name: "İslamiyet Öncesi Türk Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 170,
        name: "İslamiyet Etkisinde Türk Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 171,
        name: "Divan Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 172,
        name: "Halk Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 173,
        name: "Edebi Akımlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 174,
        name: "Tanzimat Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 175,
        name: "Servetifünun Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 176,
        name: "Fecriati Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 177,
        name: "Milli Edebiyat",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 178,
        name: "Cumhuriyet Edebiyatı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 3,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "5. Sınıf",
    branch: Branches.ScienceAndTechnology,
    topics: [
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 179,
        name: "Gökyüzündeki Komşularımız Ve Biz",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 180,
        name: "Kuvveti Tanıyalım",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 181,
        name: "Canlılar Yapısına Yolculuk",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 182,
        name: "Işığın Dünyası",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 183,
        name: "Maddenin Doğası",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 184,
        name: "Sürdürülebilir Yaşam Ve Geri Dönüşüm",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 185,
        name: "Yaşamımızdaki Elektrik",
        className: ClassTypes.FifthGrade.value,
        parentId: 4,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "6. Sınıf",
    branch: Branches.ScienceAndTechnology,
    topics: [
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 186,
        name: "Güneş Sistemi ve Tutulmalar",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 187,
        name: "Vücudumuzdaki Sistemler",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 188,
        name: "Kuvvet ve Hareket",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 189,
        name: "Madde ve Isı",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 190,
        name: "Ses ve Özellikleri",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 191,
        name: "Vücudumuzdaki Sistemler ve Sağlığı",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 192,
        name: "Elektriğin İletimi",
        className: ClassTypes.SixthGrade.value,
        parentId: 4,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "7. Sınıf",
    branch: Branches.ScienceAndTechnology,
    topics: [
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 193,
        name: "Güneş Sistemi ve Ötesi",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 194,
        name: "Kuvvet ve Enerji",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 195,
        name: "Hücre ve Bölünmeler",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 196,
        name: "Işığın Madde ile Etkileşimi",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 197,
        name: "Saf Madde ve Karışımlar",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 198,
        name: "Canlılarda Üreme, Büyüme ve Gelişme",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 199,
        name: "Elektrik Devreleri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 4,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "8. Sınıf",
    branch: Branches.ScienceAndTechnology,
    topics: [
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 200,
        name: "Mevsimler ve İklim",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 201,
        name: "DNA ve Genetik Kod",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 202,
        name: "Basınç",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 203,
        name: "Madde ve Isı",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 204,
        name: "Basit Makineler",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 205,
        name: "Enerji Dönüşümleri ve Çevre Bilimi",
        className: ClassTypes.EighthGrade.value,
        parentId: 4,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.Physics,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 206,
        name: "Enerji",
        className: ClassTypes.NinthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 207,
        name: "Fizik Bilimi ve Kariyer Keşfi",
        className: ClassTypes.NinthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 208,
        name: "Akışkanlar",
        className: ClassTypes.NinthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 209,
        name: "Kuvvet ve Hareket",
        className: ClassTypes.NinthGrade.value,
        parentId: 5,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.Physics,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 210,
        name: "Elektrik ve Manyetizma",
        className: ClassTypes.TenthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 211,
        name: "Basınç ve Kaldırma Kuvveti",
        className: ClassTypes.TenthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 212,
        name: "Dalgalar",
        className: ClassTypes.TenthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 213,
        name: "Optik",
        className: ClassTypes.TenthGrade.value,
        parentId: 5,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.Physics,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 214,
        name: "Vektörler",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 215,
        name: "Bağıl Hareket",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 216,
        name: "Newton Hareket Yasaları",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 217,
        name: "Bir Boyutta Sabit İvmeli Hareket",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 218,
        name: "İki Boyutta Sabit İvmeli Hareket",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 219,
        name: "Enerji ve Hareket",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 220,
        name: "İtme ve Çizgisel Momentum",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 221,
        name: "Tork ve Denge",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 222,
        name: "Elektrik ve Manyetizma",
        className: ClassTypes.EleventhGrade.value,
        parentId: 5,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.Physics,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 223,
        name: "Fizik Bilimine Giriş",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 224,
        name: "Madde ve Özellikleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 225,
        name: "Basınç",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 226,
        name: "Kaldırma Kuvveti",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 227,
        name: "Isı – Sıcaklık ve Genleşme",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 228,
        name: "Optik",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 229,
        name: "Dalgalar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 230,
        name: "Elektrik ve Manyetizma",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 231,
        name: "Vektörler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 232,
        name: "Hareket",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 233,
        name: "Dinamik",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 234,
        name: "Atış Hareketleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 235,
        name: "İtme ve Momentum",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 236,
        name: "Çembersel Hareket",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 237,
        name: "Kütle – Çekim",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 238,
        name: "Basit Harmonik Hareket",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 239,
        name: "Dalga Mekaniği",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 240,
        name: "Atom Fiziği",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 5,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "5. Sınıf",
    branch: Branches.SocialStudies,
    topics: [
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 241,
        name: "Birlikte Yaşamak",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 242,
        name: "Hayatımızdaki Ekonomi",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 243,
        name: "Evimiz Dünya",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 244,
        name: "Teknoloji ve Sosyal Bilimler",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 245,
        name: "Yaşayan Demokrasimiz",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 246,
        name: "Ortak Mirasımız",
        className: ClassTypes.FifthGrade.value,
        parentId: 6,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "6. Sınıf",
    branch: Branches.SocialStudies,
    topics: [
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 247,
        name: "Birey ve Toplum",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 248,
        name: "Kültür ve Miras",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 249,
        name: "İnsanlar, Yerler ve Çevreler",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 250,
        name: "Bilim, Teknoloji ve Toplum",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 251,
        name: "Üretim, Dağıtım ve Tüketim",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 252,
        name: "Etkin Vatandaşlık",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 253,
        name: "Küresel Bağlantılar",
        className: ClassTypes.SixthGrade.value,
        parentId: 6,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "7. Sınıf",
    branch: Branches.SocialStudies,
    topics: [
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 254,
        name: "İletişim ve İnsan İlişkileri",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 255,
        name: "Türk Tarihine Yolculuk",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 256,
        name: "Ülkemizde Nüfus",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 257,
        name: "Zaman İçinde Bilim",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 258,
        name: "Ekonomik ve Sosyal Hayat",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 259,
        name: "Yaşayan Demokrasi",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 260,
        name: "Ülkeler Arası Köprüler",
        className: ClassTypes.SeventhGrade.value,
        parentId: 6,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "8. Sınıf",
    branch: Branches.HistoryOfRevolutionAndKemalism,
    topics: [
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 261,
        name: "Bir Kahraman Doğuyor",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 262,
        name: "Milli Uyanış",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 263,
        name: "Milli Destan",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 264,
        name: "Çağdaşlaşan Türkiye",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 265,
        name: "Demokratikleşme Çabaları",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 266,
        name: "Atatürk Dönemi Dış Politika",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 267,
        name: "Atatürk’ün Ölümü ve Sonrası",
        className: ClassTypes.EighthGrade.value,
        parentId: 7,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.History,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 268,
        name: "Eski Çağ Medeniyetleri",
        className: ClassTypes.NinthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 269,
        name: "Geçmişin İnşa Sürecinde Tarih",
        className: ClassTypes.NinthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 270,
        name: "Orta Çağ Medeniyetleri",
        className: ClassTypes.NinthGrade.value,
        parentId: 8,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.History,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 271,
        name: "Yerleşme ve Devletleşme Sürecinde Selçuklu Türkiyesi",
        className: ClassTypes.TenthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 272,
        name: "Beylikten Devlete Osmanlı Siyaseti",
        className: ClassTypes.TenthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 273,
        name: "Dünya Gücü Osmanlı",
        className: ClassTypes.TenthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 274,
        name: "Osmanlı Devleti Kültür ve Uygarlığı",
        className: ClassTypes.TenthGrade.value,
        parentId: 8,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.History,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 275,
        name: "Değişen Dünya Dengeleri Karşısında Osmanlı Siyaseti",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 276,
        name: "Değişim Çağında Avrupa ve Osmanlı",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 277,
        name: "Yeni ve Yakın Çağ’da Avrupa ve Amerika",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 278,
        name: "Uluslar Arası İlişkilerde Denge Stratejisi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 279,
        name: "Devrimler Çağında Değişen Devlet ve Toplum İlişkileri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 280,
        name: "20. Yüzyıl Başlarında Osmanlı Devleti",
        className: ClassTypes.EleventhGrade.value,
        parentId: 8,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.History,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 281,
        name: "Tarih ve Zaman",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 282,
        name: "İnsanlığın İlk Dönemleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 283,
        name: "İlk ve Orta Çağlarda Türk Dünyası",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 284,
        name: "İslam Medeniyetinin Doğuşu",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 285,
        name: "İlk Türk – İslam Devletleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 286,
        name: "Yerleşme ve Devletleşme Sürecinde Selçuklu Türkiyesi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 287,
        name: "Beylikten Devlete Osmanlı Siyaseti",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 288,
        name: "Dünya Gücü Osmanlı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 289,
        name: "Osmanlı Devleti Kültür ve Uygarlığı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 290,
        name: "Değişen Dünya Dengeleri Karşısında Osmanlı Siyaseti",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 291,
        name: "Değişim Çağında Avrupa ve Osmanlı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 292,
        name: "Yeni ve Yakın Çağ’da Avrupa ve Amerika",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 293,
        name: "Uluslar Arası İlişkilerde Denge Stratejisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 294,
        name: "Devrimler Çağında Değişen Devlet ve Toplum İlişkileri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 295,
        name: "20. Yüzyıl Başlarında Osmanlı Devleti",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 296,
        name: "İnkılap Tarihine Giriş",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 297,
        name: "I. Dünya Savaşı ve Sonuçları",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 298,
        name: "Milli Mücadeleye Hazırlık Dönemi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 299,
        name: "I. TBMM’nin Açılması ve Ayaklanmalar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 300,
        name: "Kurtuluş Savaşı Muharebeler Dönemi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 301,
        name: "Lozan Antlaşması",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 302,
        name: "Cumhuriyet Devri ve İnkılaplar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 303,
        name: "Atatürk’ün Hayatı ve İlkeleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 304,
        name: "İki Savaş Arasındaki Dönemde Türkiye ve Dünya",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 305,
        name: "II. Dünya Savaşı Sürecinde Türkiye ve Dünya",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 306,
        name: "II. Dünya Savaşı Sonrasında Türkiye ve Dünya",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 307,
        name: "Toplumsal Devrim Çağında Dünya ve Türkiye",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 308,
        name: "21. Yüzyılın Eşiğinde Türkiye ve Dünya",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 8,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "5. Sınıf",
    branch: Branches.English,
    topics: [
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 309,
        name: "Fitness",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 310,
        name: "Games And Hobbies",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 311,
        name: "Hello",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 312,
        name: "Health",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 313,
        name: "My Daily Routine",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 314,
        name: "My Town",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 315,
        name: "Movies",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 316,
        name: "Party Time",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 317,
        name: "The Animal Shelter",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.FifthGrade.index,
        id: 318,
        name: "Festivals",
        className: ClassTypes.FifthGrade.value,
        parentId: 9,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "6. Sınıf",
    branch: Branches.English,
    topics: [
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 319,
        name: "Describing What People Do Regularly (Making Simple Inquiries)",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 320,
        name: "Telling The Time and Dates",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 321,
        name: "Accepting and Refusing",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 322,
        name: "Describing What People Do Regularly",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 323,
        name: "Expressing Likes and Dislikes",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 324,
        name: "Describing Places (Making Comparisons)",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 325,
        name: "Describing What People Are Doing Now (Making Simple Inquiries)",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 326,
        name: "Describing The Weather",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 327,
        name: "Expressing Emotions",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 328,
        name: "Stating Personal Opinions",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 329,
        name: "Describing Places",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 330,
        name: "Talking About Occupations",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 331,
        name: "Asking Personal Questions",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 332,
        name: "Telling The Time, Days and Dates",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 333,
        name: "Talking About Past Events (Making Simple Inquiries)",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 334,
        name: "Talking About Past Events",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 335,
        name: "Talking About The Locations of Things and People",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 336,
        name: "Giving and Responding to Simple Suggestions",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 337,
        name: "Talking About Stages of a Procedure",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SixthGrade.index,
        id: 338,
        name: "Making Simple Inquiries",
        className: ClassTypes.SixthGrade.value,
        parentId: 9,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "7. Sınıf",
    branch: Branches.English,
    topics: [
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 339,
        name: "Describing Characters/People",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 340,
        name: "Describing Characters/People (Making Simple Inquiries)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 341,
        name: "Making Simple Comparisons (Giving Explanations/Reasons)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 342,
        name: "Talking About Routines and Daily Activities",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 343,
        name:
            "Describing What People Do Regularly (Giving Explanations and Reasons)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 344,
        name: "Talking About Past Events",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 345,
        name: "Talking About Past Events (Making Simple Inquiries)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 346,
        name: "Telling The Time, Days and Dates",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 347,
        name: "Describing The Frequency of Actions",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 348,
        name: "Making Simple Inquiries",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 349,
        name: "Making Simple Suggestions",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 350,
        name: "Talking About Past Events (Giving Explanations/Reasons)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 351,
        name: "Describing What People Do Regularly",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 352,
        name: "Expressing Preferences",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 353,
        name: "Stating Personal Opinions",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 354,
        name: "Making Simple Suggestions (Accepting and Refusing)",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 355,
        name: "Expressing Needs and Quantity",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 356,
        name: "Making Arrangements and Sequencing The Actions",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 357,
        name: "Making Predictions",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 358,
        name: "Giving Explanations/Reasons",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 359,
        name: "Describing Simple Processes",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 360,
        name: "Expressing Obligation",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.SeventhGrade.index,
        id: 361,
        name: "Making Simple Comparisons",
        className: ClassTypes.SeventhGrade.value,
        parentId: 9,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "8. Sınıf",
    branch: Branches.English,
    topics: [
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 362,
        name:
            "Accepting and Refusing/Apologizing/Giving Explanations and Reasons",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 363,
        name: "Making Simple Inquiries",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 364,
        name: "Expressing Likes and Dislikes",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 365,
        name: "Stating Personal Opinions",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 366,
        name: "Describing Simple Processes",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 367,
        name: "Expressing Preferences",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 368,
        name: "Following Phone Conversations",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 369,
        name: "Stating Decisions Taken At The Time of Speaking",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 370,
        name: "Asking For Clarification",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 371,
        name: "Accepting and Refusing/Making Excuses",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 372,
        name: "Describing Internet Habits",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 373,
        name: "Expressing Preferences/Giving Explanations and Reasons",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 374,
        name: "Making Comparisons",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 375,
        name: "Describing Places",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 376,
        name: "Expressing Obligation",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 377,
        name: "Expressing Responsibilities",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 378,
        name: "Describing The Actions Happening Currently",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 379,
        name: "Talking About Past Events",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 380,
        name: "Making Predictions About The Future",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
      BranchTopic(
        classType: ClassTypes.EighthGrade.index,
        id: 381,
        name:
            "Making Predictions About The Future (Giving Reasons and Results)",
        className: ClassTypes.EighthGrade.value,
        parentId: 9,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.Chemistry,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 382,
        name: "Atomdan Periyodik Tabloya",
        className: ClassTypes.NinthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 383,
        name: "Etkileşimden Maddeye",
        className: ClassTypes.NinthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 384,
        name: "Etkileşimler",
        className: ClassTypes.NinthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 385,
        name: "Kimya Hayattır",
        className: ClassTypes.NinthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 386,
        name: "Sürdürülebilirlik",
        className: ClassTypes.NinthGrade.value,
        parentId: 10,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.Chemistry,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 387,
        name: "Kimyanın Temel Kanunları",
        className: ClassTypes.TenthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 388,
        name: "Mol Kavramı",
        className: ClassTypes.TenthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 389,
        name: "Kimyasal Hesaplamalar",
        className: ClassTypes.TenthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 390,
        name: "Karışımlar",
        className: ClassTypes.TenthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 391,
        name: "Asit-Baz-Tuz",
        className: ClassTypes.TenthGrade.value,
        parentId: 10,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.Chemistry,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 392,
        name: "Atomun Yapısı – Modern Atom Teorisi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 393,
        name: "Periyodik Sistem",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 394,
        name: "Gazlar",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 395,
        name: "Sıvı Çözeltiler",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 396,
        name: "Kimyasal Tepkimelerde Enerji",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 397,
        name: "Tepkimelerde Hız",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 398,
        name: "Kimyasal Tepkimelerde Denge",
        className: ClassTypes.EleventhGrade.value,
        parentId: 10,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.Chemistry,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 399,
        name: "Kimya Bilimi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 400,
        name: "Atom Yapısı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 401,
        name: "Periyodik Sistem",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 402,
        name: "Periyodik Özellikler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 403,
        name: "Kimyasal Türler ve Etkileşimler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 404,
        name: "Maddenin Halleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 405,
        name: "Kimyanın Temel Kanunları",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 406,
        name: "Mol Kavramı",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 407,
        name: "Kimyasal Hesaplamalar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 408,
        name: "Karışımlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 409,
        name: "Asit-Baz-Tuz",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 410,
        name: "Atomun Yapısı – Modern Atom Teorisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 411,
        name: "Gazlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 412,
        name: "Sıvı Çözeltiler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 413,
        name: "Kimyasal Tepkimelerde Enerji",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 414,
        name: "Tepkimelerde Hız",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 415,
        name: "Kimyasal Tepkimelerde Denge",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 416,
        name: "Kimya ve Elektrik",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 417,
        name: "Karbon Kimyasına Giriş",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 418,
        name: "Hidrokarbonlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 419,
        name: "Aromatik Bileşikler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 420,
        name: "Alkoller ve Eterler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 421,
        name: "Aldehit ve Ketonlar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 422,
        name: "Karboksilik Asit ve Esterler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 423,
        name: "Enerji Kaynakları ve Bilimsel Gelişmeler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 10,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.Biology,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 424,
        name: "Hücrenin Organizasyonu",
        className: ClassTypes.NinthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 425,
        name: "İnorganik Moleküller",
        className: ClassTypes.NinthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 426,
        name: "Organik Moleküller",
        className: ClassTypes.NinthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 427,
        name: "Sınıflandırma ve Biyoçeşitlilik",
        className: ClassTypes.NinthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 428,
        name: "Yaşam",
        className: ClassTypes.NinthGrade.value,
        parentId: 11,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.Biology,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 429,
        name: "Hücre Bölünmeleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 430,
        name: "Kalıtımın Genel İlkeleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 431,
        name: "Ekosistem Ekolojisi",
        className: ClassTypes.TenthGrade.value,
        parentId: 11,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.Biology,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 432,
        name: "İnsan Fizyolojisi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 433,
        name: "Komünite ve Populasyon Ekolojisi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 11,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.Biology,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 434,
        name: "Yaşam Bilimi Biyoloji",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 435,
        name: "Hücre",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 436,
        name: "Canlılar Dünyası",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 437,
        name: "Hücre Bölünmeleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 438,
        name: "Kalıtım",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 439,
        name: "Ekoloji",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 440,
        name: "İnsan Fizyolojisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 441,
        name: "Genden Proteine",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 442,
        name: "Canlılarda Enerji Dönüşümleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 443,
        name: "Bitki Biyolojisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 444,
        name: "Canlılar ve Çevre",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 11,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "9. Sınıf",
    branch: Branches.Geography,
    topics: [
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 445,
        name: "Coğrafyanın Doğası",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 446,
        name: "Ekonomik Faaliyetler Ve Etkileri",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 447,
        name: "Afetler Ve Sürdürülebilir Çevre",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 448,
        name: "Beşeri Sistemler Ve Süreçler",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 449,
        name: "Bölgeler, Ülkeler Ve Küresel Bağlantılar",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 450,
        name: "Doğal Sistemleri Ve Süreçleri",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.NinthGrade.index,
        id: 451,
        name: "Mekansal Bilgi Teknolojileri",
        className: ClassTypes.NinthGrade.value,
        parentId: 12,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "10. Sınıf",
    branch: Branches.Geography,
    topics: [
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 452,
        name: "Yerin Şekillenmeleri",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 453,
        name: "Türkiye’nin Oluşumu",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 454,
        name: "Türkiye’deki Su, Toprak ve Bitki Varlığı",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 455,
        name: "Beşeri Sistemler",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 456,
        name: "Türkiye Nüfusu",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 457,
        name: "Göç",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 458,
        name: "Ekonomik Faaliyetler",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 459,
        name: "Bölgeler ve Ülkeler",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TenthGrade.index,
        id: 460,
        name: "Çevre ve Toplum",
        className: ClassTypes.TenthGrade.value,
        parentId: 12,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "11. Sınıf",
    branch: Branches.Geography,
    topics: [
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 461,
        name: "Ekosistemlerin Özellikleri ve İşleyişi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 462,
        name: "Nüfus Politikaları",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 463,
        name: "Yerleşmelerin Özellikleri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 464,
        name: "Ekonomik Faaliyetler ve Doğal Kaynaklar",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 465,
        name: "Türkiye’de Ekonomi",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 466,
        name: "Kültür Bölgeleri",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 467,
        name: "Küreselleşen Dünya",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.EleventhGrade.index,
        id: 468,
        name: "Çevre Sorunları",
        className: ClassTypes.EleventhGrade.value,
        parentId: 12,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.Geography,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 469,
        name: "İnsan ve Doğa",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 470,
        name: "Dünya’nın Şekli ve Hareketleri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 471,
        name: "Koordinat Sistemi ve Konum",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 472,
        name: "Coğrafi Rehberim: Haritalar",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 473,
        name: "Atmosfer ve İklim",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 474,
        name: "Yer’in Şekillenmesi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 475,
        name: "Doğadaki Üç Unsur",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 476,
        name: "Yerleşmeler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 477,
        name: "İnsan ve Çevre",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 478,
        name: "Doğal Sistemler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 479,
        name: "Şehir ve Ekonomi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 480,
        name: "İşlevsel Bölge",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 481,
        name: "Hizmet Sektörü",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 482,
        name: "Ticaret",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 483,
        name: "Türkiye’de Turizm",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 484,
        name: "Kültür",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 485,
        name: "Jeopolitik Konum",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 486,
        name: "Ülkelerarası Etkileşim",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 487,
        name: "Ekosistemler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 12,
      ),
    ],
  ),
  ClassLevelBranch(
    classLevel: "12. Sınıf",
    branch: Branches.Geometry,
    topics: [
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 488,
        name: "Üçgenler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 489,
        name: "Trigonometri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 490,
        name: "Çokgenler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 491,
        name: "Çember ve Daire",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 492,
        name: "Katı Cisimler",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 493,
        name: "Analitik Geometri",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 494,
        name: "Dönüşümler Geometrisi",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
      BranchTopic(
        classType: ClassTypes.TwelfthGrade.index,
        id: 495,
        name: "Çemberin Analitiği",
        className: ClassTypes.TwelfthGrade.value,
        parentId: 13,
      ),
    ],
  ),
];

Map<String, List<BranchTopic>> filterByBranch(Branches branchEnum) {
  Map<String, List<BranchTopic>> branchMap = {};

  for (var clb in classLevelBranches) {
    String branch = clb.branch.name;

    if (!branchMap.containsKey(branch)) {
      branchMap[branch] = [];
    }

    branchMap[branch]!.addAll(clb.topics);
  }

  return branchMap;
}

List<BranchTopic> filterBranchTopics(
  List<ClassLevelBranch> branches, {
  required Branches branch,
  required ClassTypes classLevel,
}) {
  List<String> classLevelsToFilter;

  if (classLevel == ClassTypes.Grade) {
    classLevelsToFilter = [
      ClassTypes.NinthGrade.value,
      ClassTypes.TenthGrade.value,
      ClassTypes.EleventhGrade.value,
      ClassTypes.TwelfthGrade.value
    ];
  } else {
    classLevelsToFilter = [classLevel.value];
  }

  var filteredBranches = branches.where((b) {
    bool branchMatch = b.branch == branch;
    bool classMatch = classLevelsToFilter.contains(b.classLevel);

    return branchMatch && classMatch;
  }).toList();

  var result = filteredBranches
      .expand((b) => b.topics.map((topic) => BranchTopic(
            id: topic.id,
            name: "${topic.name} - ${b.classLevel}",
            classType: int.tryParse(b.classLevel) ?? 0,
            className: b.classLevel,
            parentId: topic.parentId,
          )))
      .toList();

  return result;
}

Map<String, Map<String, List<BranchTopic>>> filterByClassAndBranch(
    List<ClassLevelBranch> classLevelBranches) {
  Map<String, Map<String, List<BranchTopic>>> classAndBranchMap = {};

  for (var clb in classLevelBranches) {
    String classLevel = clb.classLevel;
    String branch = clb.branch.name;

    if (!classAndBranchMap.containsKey(classLevel)) {
      classAndBranchMap[classLevel] = {};
    }

    if (!classAndBranchMap[classLevel]!.containsKey(branch)) {
      classAndBranchMap[classLevel]![branch] = [];
    }

    classAndBranchMap[classLevel]![branch]!.addAll(clb.topics);
  }

  return classAndBranchMap;
}

class Branch {
  final String name;
  final int id;
  final List<BranchTopic> topics;

  Branch({required this.name, required this.id, required this.topics});

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
  final int parentId;
  final int classType;
  final String className;

  BranchTopic(
      {required this.name,
      required this.id,
      required this.classType,
      required this.className,
      required this.parentId});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BranchTopic && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

const DEFAULT_LESSON_COLOR = "#4A90E2";
