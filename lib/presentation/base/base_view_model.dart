// shared variables and functions will be used through any view model
abstract class BaseViewModel extends BaseViewModelInputs with BaseViewModelOutputs{

}

// this class has two base values, first one BaseViewModel input
// inputs from View
abstract class BaseViewModelInputs {
  void start(); // will be called while init. of view model
  void dispose(); // will be called while view model dies -> navigate from one view to another view
}

// and the second one BaseViewModel output
abstract class BaseViewModelOutputs {}
