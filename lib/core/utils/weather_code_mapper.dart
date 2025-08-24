class CodeMapper {
  fetchCode<String>(int? code) {
    switch (code) {
      case 0:
        return 'clear sky';
      case 1:
        return 'mainly clear';
      case 2:
        return 'partly cloudy';
      case 3:
        return 'overcast';
      case 61:
        return 'slight rain';
      case 63:
        return 'moderate rain';
      case 65:
        return 'heavy rain';
      case 71:
        return 'slight snow fall';
      case 73:
        return 'moderate snow fall';
      case 75:
        return 'intense snow fall';
      case 80:
        return 'slight rain showers';
      case 81:
        return 'moderate rain showers';
      case 82:
        return 'slight rain showers';
      case 85:
        return 'slight snow showers';
      case 86:
        return 'moderate snow showers';

      default:
        return '';
    }
  }
}
