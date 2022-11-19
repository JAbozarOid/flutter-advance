import 'dart:async';

import 'package:cleanarch/app/app_prefs.dart';
import 'package:cleanarch/app/di.dart';
import 'package:cleanarch/domain/model.dart';
import 'package:cleanarch/presentation/base/base_view_model.dart';
import 'package:cleanarch/presentation/resources/assets_manager.dart';
import 'package:cleanarch/presentation/resources/language_manager.dart';
import 'package:cleanarch/presentation/resources/strings_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  /// with stream controller our view model can communicate with our view
  final StreamController _sliderStreamController =
      StreamController<SliderViewObject>();

  late final List<SliderObject> _sliderList;
  int _currentSlidePageIndex = 0;

  final StreamController _localizationStreamController =
      StreamController<LocalizationObject>();
  late final List<LocalizationModel> _langList;
  int _currentLangIndex = 0;

  late final BuildContext _context;
  late final AppPreferences _appPreferences;


  // inputs BaseViewModel
  @override
  void dispose() {
    _sliderStreamController.close();
  }

  // inputs BaseViewModel
  @override
  void start(BuildContext context) {
    _context = context;
    _appPreferences = instance<AppPreferences>();

    getAppLanguageIndex();

    _sliderList = _getSliderData();
    _langList = _getLangData();

    // send this slider data to our view
    _postDataToView();

    _postLangDataToView();
  }

  void getAppLanguageIndex() async {
    _currentLangIndex = await _appPreferences.getAppLanguageIndex();
  }

  @override
  void goNext() {
    int nextIndex = _currentSlidePageIndex++; // -1
    if (nextIndex >= _sliderList.length) {
      _currentSlidePageIndex =
          0; // infinite loop to go to first inside the slider
    }
    _postDataToView();
  }

  @override
  void goPrevious() {
    int previousIndex = _currentSlidePageIndex--; // -1
    if (previousIndex == -1) {
      _currentSlidePageIndex = _sliderList.length -
          1; // infinite loop to go to the length of slider list
    }
    _postDataToView();
  }

  @override
  void onPagedChanged(int index) {
    // first update the index
    _currentSlidePageIndex = index;

    // second
    _postDataToView();
  }

  void _changeLanguage() {
    _appPreferences.setLanguageChanged();
    Phoenix.rebirth(_context);
  }

  @override
  Sink get inputSliderViewObject => _sliderStreamController.sink;

  // outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _sliderStreamController.stream.map((slideViewObject) => slideViewObject);

  @override
  Sink get inputLocalizationObject => _localizationStreamController.sink;

  @override
  Stream<LocalizationObject> get outputLocalizationObject =>
      _localizationStreamController.stream
          .map((localizationObj) => localizationObj);

  // private function
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1.tr(),
            AppStrings.onBoardingSubTitle1.tr(), ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2.tr(),
            AppStrings.onBoardingSubTitle2.tr(), ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3.tr(),
            AppStrings.onBoardingSubTitle3.tr(), ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4.tr(),
            AppStrings.onBoardingSubTitle4.tr(), ImageAssets.onBoardingLogo4)
      ];
  
  List<LocalizationModel> _getLangData() => [
    const LocalizationModel(languageType: LanguageType.ENGLISH),
    const LocalizationModel(languageType: LanguageType.ARABIC),
  ];

  _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(
        _sliderList[_currentSlidePageIndex],
        _sliderList.length,
        _currentSlidePageIndex));
  }

  _postLangDataToView() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
      inputLocalizationObject.add(LocalizationObject(
          _langList[_currentLangIndex], _langList.length, _currentLangIndex));
      if(_currentLangIndex == 0) {
        _currentLangIndex++;
        _appPreferences.setAppLanguageIndex(_currentLangIndex);
      }else{
        _currentLangIndex--;
        _appPreferences.setAppLanguageIndex(_currentLangIndex);
      }
      _changeLanguage();
      if (_currentLangIndex == _langList.length - 1) timer.cancel();
    });
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left
  void goPrevious(); // when user clicks on left arrow or swipe right
  void onPagedChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to the stream .. stream input

  Sink get inputLocalizationObject;
}

// outputs mean data or results that will be send from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SliderViewObject> get outputSliderViewObject;

  Stream<LocalizationObject> get outputLocalizationObject;
}

class SliderViewObject {
  SliderObject sliderObject;

  // how many slide should be showed
  int numOfSlides;

  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

class LocalizationObject {
  LocalizationModel localizationModel;
  int numOfLang;
  int currentIndex;

  LocalizationObject(this.localizationModel, this.numOfLang, this.currentIndex);
}
