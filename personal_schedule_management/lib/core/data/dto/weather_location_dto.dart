class WeatherLocationDTO {
  late String name;
  late String region;
  late String country;
  late double lat, lon;
  late String tz_id;
  late DateTime localTime;

  WeatherLocationDTO(this.name, this.region, this.country, this.lat, this.lon,
      this.tz_id, this.localTime);
  factory WeatherLocationDTO.fromJson(Map<String, dynamic> json) {
    return WeatherLocationDTO(
        json['name'],
        json['region'],
        json['country'],
        json['lat'],
        json['lon'],
        json['tz_id'],
        DateTime.parse(json['localtime'].toString().split(' ').first));
  }
}
