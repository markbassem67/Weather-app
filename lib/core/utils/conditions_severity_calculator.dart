class ConditionsSeverityCalculator {
  String uvIntensity(int uv) {
    switch (uv) {
      case 0:
      case 1:
      case 2:
        return 'Minimal risk';
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
        return 'Moderate risk';
      case 8:
      case 9:
      case 10:
        return 'High risk';
      case 11:
      case 12:
        return 'Severe risk';
    }
    return '';
  }

  String getRainDescription(int rainPercent) {
    if (rainPercent <= 0) {
      return "No rain";
    } else if (rainPercent > 0 && rainPercent <= 20) {
      return "Very low chance";
    } else if (rainPercent > 20 && rainPercent <= 40) {
      return "Low chance";
    } else if (rainPercent > 40 && rainPercent <= 60) {
      return "Moderate chance";
    } else if (rainPercent > 60 && rainPercent <= 80) {
      return "High chance";
    } else {
      return "Very high chance";
    }
  }


  String getHumidityDescription(int humidityPercent) {
    if (humidityPercent <= 30) {
      return "Dry";
    } else if (humidityPercent > 30 && humidityPercent <= 50) {
      return "Comfortable";
    } else if (humidityPercent > 50 && humidityPercent <= 70) {
      return "Humid";
    } else {
      return "Very humid";
    }
  }

}
