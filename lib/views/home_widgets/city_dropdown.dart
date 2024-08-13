import 'package:flutter/material.dart';
import 'package:weather_apps/models/wilayah.dart';

class CityDropdown extends StatelessWidget {
  final List<Wilayah> wilayahList;
  final Wilayah selectedProvince;
  final Wilayah? selectedCity;
  final ValueChanged<Wilayah?> onCitySelected;

  const CityDropdown({
    super.key,
    required this.wilayahList,
    required this.selectedProvince,
    required this.selectedCity,
    required this.onCitySelected,
  });

  @override
  Widget build(BuildContext context) {
    final cities = wilayahList
        .where((w) => w.propinsi == selectedProvince.propinsi)
        .toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<Wilayah>(
        decoration: InputDecoration(
          labelText: 'Pilih Kota',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: selectedCity,
        items: cities.map((Wilayah city) {
          return DropdownMenuItem<Wilayah>(
            value: city,
            child: Text(city.kota),
          );
        }).toList(),
        onChanged: onCitySelected,
      ),
    );
  }
}
