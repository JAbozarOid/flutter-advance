import 'package:cleanarch/domain/model.dart';
import 'package:cleanarch/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:cleanarch/presentation/resources/color_manager.dart';
import 'package:cleanarch/presentation/resources/strings_manager.dart';
import 'package:cleanarch/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../resources/assets_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _onBoardingViewModel = OnBoardingViewModel();

  /// bind our view model to our view
  _bind() {
    _onBoardingViewModel.start(context);
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        // first listen to the output of the stream that we created in view model for outputing stream
        stream: _onBoardingViewModel.outputSliderViewObject,
        // snapshot contain data
        builder:
            (BuildContext context, AsyncSnapshot<SliderViewObject> snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          // the line on status bar of the device
          elevation: AppSize.s0,
          backgroundColor: ColorManager.white,
          // this apply to status bar
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark),
        ),
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderViewObject.numOfSlides,
            onPageChanged: (index) {
              /*setState(() {
                _currentPageIndex = index;
              });*/
              _onBoardingViewModel.onPagedChanged(index);
            },
            itemBuilder: (context, index) {
              // return onBoarding page
              return OnBoardingPage(sliderViewObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorManager.white,
          height: AppSize.s100,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        AppStrings.skip,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.subtitle2,
                      ).tr())),

              // add layout for indicator and arrows
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorManager.primary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                // go to the next slide
                /*_pageController.animateToPage(_getNextIndex(),
                    duration:
                    const Duration(milliseconds: DurationConstants.d300),
                    curve: Curves.bounceInOut);*/
                _onBoardingViewModel.goNext();
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIC),
              ),
            ),
          ),

          // circle indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircle(i, sliderViewObject.currentIndex),
                )
            ],
          ),

          // right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              onTap: () {
                // go to the previous slide
                /* _pageController.animateToPage(_getPreviousIndex(),
                    duration:
                    const Duration(milliseconds: DurationConstants.d300),
                    curve: Curves.bounceInOut);*/
                _onBoardingViewModel.goPrevious();
              },
              child: SizedBox(
                height: AppSize.s20,
                width: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIC),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircle(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.hollowCircleIC); // selected slider
    } else {
      return SvgPicture.asset(ImageAssets.solidCircleIC); // unselected slider
    }
  }

  @override
  void dispose() {
    _onBoardingViewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // because it start from top
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // create space at the top
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),

        // image widget
        SvgPicture.asset(_sliderObject.image)
      ],
    );
  }
}

