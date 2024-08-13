import 'package:flutter/material.dart';
import 'package:weather_apps/models/wilayah.dart';

class ProvinceDropdown extends StatelessWidget {
  final List<Wilayah> wilayahList;
  final Wilayah? selectedProvince;
  final ValueChanged<Wilayah?> onProvinceSelected;

  const ProvinceDropdown({
    super.key,
    required this.wilayahList,
    required this.selectedProvince,
    required this.onProvinceSelected,
  });

  @override
  Widget build(BuildContext context) {
    final provinces = wilayahList.map((w) => w.propinsi).toSet().toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: 'Pilih Provinsi',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
        value: selectedProvince?.propinsi,
        items: provinces.map((String province) {
          return DropdownMenuItem<String>(
            value: province,
            child: Text(province),
          );
        }).toList(),
        onChanged: (String? newValue) {
          final selectedWilayah = wilayahList.firstWhere(
            (w) => w.propinsi == newValue,
          );
          onProvinceSelected(selectedWilayah);
        },
      ),
    );
  }
}
