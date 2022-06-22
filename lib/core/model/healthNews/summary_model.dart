class SummaryModel {
  String? iD;
  String? message;
  Global? global;
  List<Countries>? countries;
  String? date;

  SummaryModel({this.iD, this.message, this.global, this.countries, this.date});

  SummaryModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    message = json['Message'];
    global =
    json['Global'] != null ? new Global.fromJson(json['Global']) : null;
    if (json['Countries'] != null) {
      countries = <Countries>[];
      json['Countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Message'] = this.message;
    if (this.global != null) {
      data['Global'] = this.global!.toJson();
    }
    if (this.countries != null) {
      data['Countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    data['Date'] = this.date;
    return data;
  }
}

class Global {
  var newConfirmed;
  var totalConfirmed;
  var newDeaths;
  var totalDeaths;
  var newRecovered;
  var totalRecovered;
  String? date;

  Global(
      {this.newConfirmed,
        this.totalConfirmed,
        this.newDeaths,
        this.totalDeaths,
        this.newRecovered,
        this.totalRecovered,
        this.date});

  Global.fromJson(Map<String, dynamic> json) {
    newConfirmed = json['NewConfirmed'];
    totalConfirmed = json['TotalConfirmed'];
    newDeaths = json['NewDeaths'];
    totalDeaths = json['TotalDeaths'];
    newRecovered = json['NewRecovered'];
    totalRecovered = json['TotalRecovered'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NewConfirmed'] = this.newConfirmed;
    data['TotalConfirmed'] = this.totalConfirmed;
    data['NewDeaths'] = this.newDeaths;
    data['TotalDeaths'] = this.totalDeaths;
    data['NewRecovered'] = this.newRecovered;
    data['TotalRecovered'] = this.totalRecovered;
    data['Date'] = this.date;
    return data;
  }
}

class Countries {
  String? iD;
  String? country;
  String? countryCode;
  String? slug;
  var newConfirmed;
  var totalConfirmed;
  var newDeaths;
  var totalDeaths;
  var newRecovered;
  var totalRecovered;
  String? date;
  Premium? premium;

  Countries(
      {this.iD,
        this.country,
        this.countryCode,
        this.slug,
        this.newConfirmed,
        this.totalConfirmed,
        this.newDeaths,
        this.totalDeaths,
        this.newRecovered,
        this.totalRecovered,
        this.date,
        this.premium});

  Countries.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    country = json['Country'];
    countryCode = json['CountryCode'];
    slug = json['Slug'];
    newConfirmed = json['NewConfirmed'];
    totalConfirmed = json['TotalConfirmed'];
    newDeaths = json['NewDeaths'];
    totalDeaths = json['TotalDeaths'];
    newRecovered = json['NewRecovered'];
    totalRecovered = json['TotalRecovered'];
    date = json['Date'];
    premium =
    json['Premium'] != null ? new Premium.fromJson(json['Premium']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Country'] = this.country;
    data['CountryCode'] = this.countryCode;
    data['Slug'] = this.slug;
    data['NewConfirmed'] = this.newConfirmed;
    data['TotalConfirmed'] = this.totalConfirmed;
    data['NewDeaths'] = this.newDeaths;
    data['TotalDeaths'] = this.totalDeaths;
    data['NewRecovered'] = this.newRecovered;
    data['TotalRecovered'] = this.totalRecovered;
    data['Date'] = this.date;
    if (this.premium != null) {
      data['Premium'] = this.premium!.toJson();
    }
    return data;
  }
}

class Premium {
  CountryStats? countryStats;

  Premium({this.countryStats});

  Premium.fromJson(Map<String, dynamic> json) {
    countryStats = json['CountryStats'] != null
        ? new CountryStats.fromJson(json['CountryStats'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countryStats != null) {
      data['CountryStats'] = this.countryStats!.toJson();
    }
    return data;
  }
}

class CountryStats {
  String? iD;
  String? countryISO;
  String? country;
  String? continent;
  var population;
  var populationDensity;
  var medianAge;
  var aged65Older;
  var aged70Older;
  var extremePoverty;
  var gdpPerCapita;
  var cvdDeathRate;
  var diabetesPrevalence;
  var handwashingFacilities;
  var hospitalBedsPerThousand;
  var lifeExpectancy;
  var femaleSmokers;
  var maleSmokers;

  CountryStats(
      {this.iD,
        this.countryISO,
        this.country,
        this.continent,
        this.population,
        this.populationDensity,
        this.medianAge,
        this.aged65Older,
        this.aged70Older,
        this.extremePoverty,
        this.gdpPerCapita,
        this.cvdDeathRate,
        this.diabetesPrevalence,
        this.handwashingFacilities,
        this.hospitalBedsPerThousand,
        this.lifeExpectancy,
        this.femaleSmokers,
        this.maleSmokers});

  CountryStats.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    countryISO = json['CountryISO'];
    country = json['Country'];
    continent = json['Continent'];
    population = json['Population'];
    populationDensity = json['PopulationDensity'];
    medianAge = json['MedianAge'];
    aged65Older = json['Aged65Older'];
    aged70Older = json['Aged70Older'];
    extremePoverty = json['ExtremePoverty'];
    gdpPerCapita = json['GdpPerCapita'];
    cvdDeathRate = json['CvdDeathRate'];
    diabetesPrevalence = json['DiabetesPrevalence'];
    handwashingFacilities = json['HandwashingFacilities'];
    hospitalBedsPerThousand = json['HospitalBedsPerThousand'];
    lifeExpectancy = json['LifeExpectancy'];
    femaleSmokers = json['FemaleSmokers'];
    maleSmokers = json['MaleSmokers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CountryISO'] = this.countryISO;
    data['Country'] = this.country;
    data['Continent'] = this.continent;
    data['Population'] = this.population;
    data['PopulationDensity'] = this.populationDensity;
    data['MedianAge'] = this.medianAge;
    data['Aged65Older'] = this.aged65Older;
    data['Aged70Older'] = this.aged70Older;
    data['ExtremePoverty'] = this.extremePoverty;
    data['GdpPerCapita'] = this.gdpPerCapita;
    data['CvdDeathRate'] = this.cvdDeathRate;
    data['DiabetesPrevalence'] = this.diabetesPrevalence;
    data['HandwashingFacilities'] = this.handwashingFacilities;
    data['HospitalBedsPerThousand'] = this.hospitalBedsPerThousand;
    data['LifeExpectancy'] = this.lifeExpectancy;
    data['FemaleSmokers'] = this.femaleSmokers;
    data['MaleSmokers'] = this.maleSmokers;
    return data;
  }
}
