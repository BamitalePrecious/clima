import '/services/location.dart';
import '/services/networking.dart';

const apiKey = 'eba902a15cc2b97634a69d27002bee67';
const defaultUnits = 'metric';
const openWeatherMapURL = '';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
      Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'q': cityName,
          'appid': apiKey,
          'units': defaultUnits,
        },
      ),
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
      Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'lat': location.latitude.toString(),
          'lon': location.longitude.toString(),
          'appid': apiKey,
          'units': defaultUnits,
        },
      ),
    );
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
