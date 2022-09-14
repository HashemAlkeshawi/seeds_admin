import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:seeds_admin/data/dio_helper.dart';
import 'package:seeds_admin/modules/category.dart';
import 'package:seeds_admin/modules/customer.dart';
import 'package:seeds_admin/modules/meal.dart';
import 'package:seeds_admin/modules/reservatoinTemplate.dart';

import 'package:seeds_admin/widgets/categories_list_items.dart';

class SeedsProvider extends ChangeNotifier {
  SeedsProvider() {
    getSummery();
    getAllCategories();
    getPopularMeals();
  }
  List<Category> categories = [];
  List<Customer> customers = [];
  List<ReservationTemplate> reservtionRequists = [];
  List<Meal> meals = [];
  List<Meal> popularMeals = [];
  int? summeryReservations;
  int? summeryGuests;
  getAllCategories() async {
    categories = await DioHelper.dioHelper.getAllCategories();
    notifyListeners();
  }

  getMeals(String categoryId) async {
    meals = await DioHelper.dioHelper.getMeals(categoryId);
    getPopularMeals();
    notifyListeners();
  }

  getPopularMeals() async {
    popularMeals = await DioHelper.dioHelper.getPopularMeals();
    notifyListeners();
  }

  getSummery() async {
    Map<String, dynamic> map = await DioHelper.dioHelper.getSummery();
    await Future.delayed(const Duration(seconds: 3));
    summeryGuests = int.parse(map['guests'] ?? '0');
    summeryReservations = int.parse(map['reservationsCount'] ?? '0');
    notifyListeners();
  }

  unPopular(String mealId) async {
    await DioHelper.dioHelper.unPopular(mealId);
    getPopularMeals();
  }

  deleteMeal(String mealId, String categoryId) async {
    await DioHelper.dioHelper.deleteMeal(mealId);
    getMeals(categoryId);
  }

  /// category provider///
  ///

  late Category category;
  String selectedIcon = icons.last;
  createCategory() async {
    category = Category(
      imagePath: selectedIcon,
      title: categoryTitleController.text,
    );
  }

  addCategory() async {
    await createCategory();
    await DioHelper.dioHelper.addCategory(category);
    notifyListeners();
  }

  setSelectedIcon(String icon) {
    selectedIcon = icon;
    notifyListeners();
  }

  TextEditingController categoryTitleController = TextEditingController();

////// meal provider ///
  ///
  String? mealId;
  late Meal meal;

  createMeal({bool? isEdit, String? mealImagePath}) async {
    log('in CreateMeal and isEdit is: $isEdit');
    String imagePath;
    if (isEdit == null) {
      imagePath = await DioHelper.dioHelper.uploadImage(mealImage ?? File(''));
    } else if (isEdit) {
      imagePath = await DioHelper.dioHelper.uploadImage(mealImage ?? File(''));
    } else {
      imagePath = mealImagePath!;
    }

    log('in create meal imagePath is $imagePath ');
    meal = Meal(
        id: mealId,
        saleDays: selectedDays ?? '',
        categoryId: selectedMealCategory!.id,
        imagePath: imagePath,
        price: int.parse(mealPriceController.text.isNotEmpty
            ? mealPriceController.text
            : '0'),
        rating: 4,
        title: mealTitleController.text,
        descreption: mealDescController.text,
        hasSale: hasSale,
        isPopular: isPopularMeal,
        salePrice: int.parse(mealPriceInSaleController.text.isNotEmpty
            ? mealPriceInSaleController.text
            : '0'));
    log('in CreateMeal and meal.id is: ${meal.id}');
  }

  String? selectedDays;

  File? mealImage;
  selectImage(ImageSource source) async {
    XFile? image;
    image = await ImagePicker().pickImage(source: source);
    mealImage = File(image!.path);
    notifyListeners();
  }

  validateMeal() {
    return mealTitleController.text.isNotEmpty &&
            mealDescController.text.isNotEmpty &&
            selectedMealCategory != null &&
            mealPriceController.text.isNotEmpty
        ? true
        : false;
  }

  addMeal() async {
    await createMeal();
    await DioHelper.dioHelper.addMeal(meal);
    notifyListeners();
  }

  editMeal(bool isEdit, String imagePath) async {
    await createMeal(isEdit: isEdit, mealImagePath: imagePath);

    await DioHelper.dioHelper.editMeal(meal);
    notifyListeners();
  }

  setSelectedCategory(Category category) {
    selectedMealCategory = category;
    notifyListeners();
  }

  Category? selectedMealCategory;
  TextEditingController mealTitleController = TextEditingController();
  TextEditingController mealDescController = TextEditingController();
  TextEditingController mealPriceController = TextEditingController();
  TextEditingController mealPriceInSaleController = TextEditingController();

  increasePrice(bool inSale) {
    if (inSale) {
      mealPriceInSaleController.text = mealPriceInSaleController.text == ''
          ? '1'
          : (int.parse(mealPriceInSaleController.text) + 1).toString();
    } else {
      mealPriceController.text = mealPriceController.text == ''
          ? '1'
          : (int.parse(mealPriceController.text) + 1).toString();
    }
    notifyListeners();
  }

  decreasePrice(bool inSale) {
    if (inSale) {
      mealPriceInSaleController.text = mealPriceInSaleController.text != '0'
          ? (int.parse(mealPriceInSaleController.text) - 1).toString()
          : '0';
    } else {
      mealPriceController.text = mealPriceController.text != '0'
          ? (int.parse(mealPriceController.text) - 1).toString()
          : '0';
    }
    notifyListeners();
  }

  bool isPopularMeal = false;
  setPopular() {
    isPopularMeal = !isPopularMeal;
    notifyListeners();
  }

  bool hasSale = false;
  addSalePrice() {
    hasSale = !hasSale;
    notifyListeners();
  }

  getActivationRequists() async {
    customers = await DioHelper.dioHelper.getActivationRequists();
    notifyListeners();
  }

  getReservationRequists() async {
    reservtionRequists = await DioHelper.dioHelper.getReservationRequists();

    notifyListeners();
  }

  upDateCustomer(Customer customer, int setStatus) async {
    customer.status = setStatus;
    await DioHelper.dioHelper.upDateCustomer(customer);
    await getActivationRequists();
  }

  // String? mealImagePath;

  editMealPrepareProvider(Meal meal) async {
    selectedDays = meal.saleDays;
    hasSale = meal.hasSale;
    isPopularMeal = meal.isPopular;
    mealPriceInSaleController.text = meal.salePrice.toString();
    mealPriceController.text = meal.price.toString();
    mealDescController.text = meal.descreption.toString();
    mealTitleController.text = meal.title.toString();
    selectedMealCategory =
        categories.where((element) => element.id == meal.categoryId).first;
    mealId = meal.id;
  }

  deleteReservation(String reservationId) async {
    await DioHelper.dioHelper.deleteReservation(reservationId);
    await getReservationRequists();
  }

  acceptReservation(String reservationId) async {
    await DioHelper.dioHelper.acceptReservation(reservationId);
    await getActivationRequists();
  }
}
