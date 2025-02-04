import 'package:flutter/material.dart';

const Color kMainColor = Color(0xff0659FD),
    kBackgroundColor = Color(0xfffdfdfd),
    toastTextColor = Color(0xff141414);
const Duration kNavDuration = Duration(milliseconds: 300);

const double kHorizontal = 28;
const String coachNumber = "+20 111 911 1789";
const String kFormatDate = 'yyyy/MM/dd';
const String welcomeMessage = "Hello , I need to talk to you about ....";

const String kSubTitleDialog =
    "The moment you open the workout It will be open for 24 hours only before closing automatically and opening the workout for the next day. Are you still sure you want to start the workout now? ";
const String defultCoachImage =
    "https://i.pinimg.com/564x/72/64/ef/7264ef408a0f88d00a454f3d836f3f80.jpg";
const List<String> kGoals = [
  "Burn Fat",
  "Increase Endurance",
  "Relieve Stress",
  "Improve Fitness",
  "Gain Muscle"
];

String kMealTitle(String title) {
  Map<String, String> titleMap = {
    "Breakfast": "breakfast",
    "MidMorning": "midMorning",
    "Lunch": "lunch",
    "EveningSnacks": "eveningSnacks",
    "Dinner": "dinner",
  };
  return titleMap[title] ?? "";
}
