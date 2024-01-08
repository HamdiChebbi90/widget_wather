// ignore_for_file: dead_code

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget getWeatherIcon(int code) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset('1.png');
      case > 300 && <= 400:
        return Image.asset('2.png');
        break;

      case > 500 && <= 600:
        return Image.asset('3.png');
        break;
      case > 600 && <= 700:
        return Image.asset('4.png');
        break;
      case > 700 && <= 800:
        return Image.asset('5.png');
        break;
      case == 800:
        return Image.asset('6.png');
        break;
      case > 800 && <= 900:
        return Image.asset('7.png');
        break;
      default:
        return Image.asset('7.png');
    }
  }

  //function to get the message good morning good afternoon good evening good night based on the actual time of the day
  String getMessage() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    }
    if (hour < 17) {
      return 'Good Afternoon';
    }
    return 'Good Evening';
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Align(
                alignment: const AlignmentDirectional(3, -0.3),
                child: Container(
                  width: 350,
                  height: 300,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.purple,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(-3, -0.3),
                child: Container(
                  width: 350,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1.2),
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: Colors.yellow,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.0),
                    ),
                  )),
              BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
                builder: (context, state) {
                  if (state is WeatherBlocSuccess) {
                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '📌 ${state.weather.areaName}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              // invoke the getMessage() function
                              getMessage(),

                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 280,
                              child: getWeatherIcon(
                                  state.weather.weatherConditionCode ?? 0),
                            ),
                            Center(
                                child: Text(
                              '${state.weather.temperature?.celsius?.toStringAsFixed(0)}°',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 35,
                                color: Colors.white,
                              ),
                            )),
                            Center(
                                child: Text(
                              '${state.weather.weatherMain}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 45,
                                color: Colors.white,
                              ),
                            )),
                            Center(
                                child: Text(
                              DateFormat('EEEE dd,')
                                  .add_jm()
                                  .format(state.weather.date!),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      '11.png',
                                      scale: 12,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'sunrise',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('jm')
                                              .format(state.weather.sunrise!),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Image.asset(
                                    '12.png',
                                    scale: 12,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'sunset',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        DateFormat('jm')
                                            .format(state.weather.sunset!),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      '13.png',
                                      scale: 12,
                                    ),
                                    Column(
                                      children: [
                                        const Text(
                                          'wind',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          '${state.weather.windSpeed?.toStringAsFixed(0)} km/h',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(children: [
                                  Image.asset(
                                    '14.png',
                                    scale: 12,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'humidity',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${state.weather.humidity?.toStringAsFixed(0)} %',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 10,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                              ],
                            ),
                          ]),
                    );
                  } else if (state is WeatherBlocLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WeatherBlocFailure) {
                    return const Center(
                      child: Text('Error'),
                    );
                  } else {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                },
              ),
            ]),
          ),
        ));
  }
}
