import 'dart:async';

import 'package:cleanarch/domain/model.dart';
import 'package:cleanarch/presentation/base/base_view_model.dart';
import 'package:cleanarch/presentation/resources/assets_manager.dart';
import 'package:cleanarch/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  /// with stream controller our view model can communicate with our view
  final StreamController _streamController =
      StreamController<SlideViewObject>();

  late final List<SliderObject> _list;
  int _currentPageIndex = 0;

  // inputs BaseViewModel
  @override
  void dispose() {
    _streamController.close();
  }

  // inputs BaseViewModel
  @override
  void start() {
    _list = _getSliderData();

    // send this slider data to our view
    _postDataToView();
  }

  @override
  void goNext() {
    int nextIndex = _currentPageIndex++; // -1
    if (nextIndex >= _list.length) {
      _currentPageIndex = 0; // infinite loop to go to first inside the slider
    }
    _postDataToView();
  }

  @override
  void goPrevious() {
    int previousIndex = _currentPageIndex--; // -1
    if (previousIndex == -1) {
      _currentPageIndex =
          _list.length - 1; // infinite loop to go to the length of slider list
    }
    _postDataToView();
  }

  @override
  void onPagedChanged(int index) {
    // first update the index
    _currentPageIndex = index;

    // second
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  // outputs
  @override
  Stream<SlideViewObject> get outputSliderViewObject =>
      _streamController.stream.map((slideViewObject) => slideViewObject);

  // private function
  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubTitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubTitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubTitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubTitle4, ImageAssets.onBoardingLogo4)
      ];

  _postDataToView() {
    inputSliderViewObject.add(SlideViewObject(
        _list[_currentPageIndex], _list.length, _currentPageIndex));
  }
}

// inputs mean the orders that our view model will receive from our view
abstract class OnBoardingViewModelInputs {
  void goNext(); // when user clicks on right arrow or swipe left
  void goPrevious(); // when user clicks on left arrow or swipe right
  void onPagedChanged(int index);

  Sink
      get inputSliderViewObject; // this is the way to add data to the stream .. stream input
}

// outputs mean data or results that will be send from our view model to our view
abstract class OnBoardingViewModelOutputs {
  Stream<SlideViewObject> get outputSliderViewObject;
}

class SlideViewObject {
  SliderObject sliderObject;

  // how many slide should be showed
  int numOfSlides;

  int currentIndex;

  SlideViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
