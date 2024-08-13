import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_apps/models/wilayah.dart';
import 'package:weather_apps/viewmodels/weather_vm.dart';
import 'home_widgets/weather_header.dart';
import 'home_widgets/province_dropdown.dart';
import 'home_widgets/city_dropdown.dart';
import 'home_widgets/forecast_tabs.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  Wilayah? _selectedProvince;
  Wilayah? _selectedCity;
  bool _showToday = true;
  bool _isLoading = false;

  void _switchDay(bool showToday) {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _showToday = showToday;
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wilayahAsyncValue = ref.watch(wilayahProvider);

    return Scaffold(
      body: wilayahAsyncValue.when(
        data: (wilayahList) {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                flexibleSpace: FlexibleSpaceBar(
                  background: WeatherHeader(
                    selectedCity: _selectedCity,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ProvinceDropdown(
                      wilayahList: wilayahList,
                      selectedProvince: _selectedProvince,
                      onProvinceSelected: (Wilayah? province) {
                        setState(() {
                          _selectedProvince = province;
                          _selectedCity = null;
                        });
                      },
                    ),
                    if (_selectedProvince != null)
                      CityDropdown(
                        wilayahList: wilayahList,
                        selectedProvince: _selectedProvince!,
                        selectedCity: _selectedCity,
                        onCitySelected: (Wilayah? city) {
                          setState(() {
                            _selectedCity = city;
                          });
                        },
                      ),
                    if (_selectedCity != null)
                      ForecastTabs(
                        showToday: _showToday,
                        isLoading: _isLoading,
                        onTabSelected: _switchDay,
                        selectedCity: _selectedCity!,
                      ),
                  ],
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
