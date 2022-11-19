// data class for sliders
import 'package:cleanarch/presentation/resources/language_manager.dart';

class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class LocalizationModel {
  final LanguageType languageType;

  const LocalizationModel({required this.languageType});
}