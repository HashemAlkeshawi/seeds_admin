import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import 'package:dio/dio.dart';
import 'package:seeds_admin/modules/category.dart';
import 'package:seeds_admin/modules/customer.dart';
import 'package:seeds_admin/modules/meal.dart';
import 'package:seeds_admin/modules/reservation.dart';
import 'package:seeds_admin/modules/reservatoinTemplate.dart';

class DioHelper {
  DioHelper._();
  static DioHelper dioHelper = DioHelper._();

  String backEndApiLink = "http://seedsrestaurant.000webhostapp.com/";
  String localHostLink = "https://192.168.0.138/api_SeedsRestaurant/";

  getAllCategories() async {
    List responsList = [];
    try {
      Dio dio = Dio();

      Response response = await dio.get('${backEndApiLink}categories.php');
      // '${backEndApiLink}categories.php');

      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Category> categories = responsList.map((e) {
      return Category.fromMap(e);
    }).toList();

    return categories;
  }

  getMeals(String categoryId) async {
    List responsList = [];
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}meals.php?catId=$categoryId',
      );

      responsList = response.data;
    } catch (e) {
      log(e.toString());
    }
    List<Meal> meals = responsList.map((e) {
      return Meal.fromMap(e);
    }).toList();

    return meals;
  }

  getPopularMeals() async {
    List responsList = [];
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}popularMeals.php',
      );

      ///
      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Meal> meals = responsList.map((e) {
      return Meal.fromMap(e);
    }).toList();

    return meals;
  }

  addCategory(Category category) async {
    // try {
    Dio dio = Dio();
    FormData formData = FormData.fromMap({'data': category.toMap()});

    Response<String> response = await dio.post(
      '${backEndApiLink}admin_fun/category.php',
      data: formData,
      options: Options(method: 'POST', headers: {
        HttpHeaders.contentTypeHeader: "application/json",
      }),
      //
    );
    // '${backEndApiLink}categories.php');

    log(response.toString());
  }
  //  catch (e) {
  //   log('(\'${category.title}\', \'${category.imagePath}\')');
  //   log(e.toString());
  // }
  // }

  addMeal(Meal meal) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': meal.toMap()});

      log('in add meal formdata is ${meal.toMap()}');

      Response<String> response = await dio.post(
        '${backEndApiLink}admin_fun/meal.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      // '${backEndApiLink}categories.php');

      log('respons is ${response.toString()}');
    } catch (e) {
      log(e.toString());
    }
  }

  editMeal(Meal meal) async {
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': meal.toMap()});
      log('formdata is ${formData.fields}');

      Response<String> response = await dio.post(
        '${backEndApiLink}admin_fun/editmeal.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      // '${backEndApiLink}categories.php');

      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  unPopular(String mealId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.put(
        '${backEndApiLink}admin_fun/meal.php?mealId=$mealId',
      );
    } catch (e) {
      log(e.toString());
    }
  }

  deleteMeal(String mealId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.delete(
        '${backEndApiLink}admin_fun/meal.php?mealId=$mealId',
      );
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> uploadImage(File file) async {
    Dio dio = Dio();
    String fileName = file.path.split('/').last;
    log(fileName);
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path,
          filename: fileName, contentType: MediaType('image', 'jpg'))
    });
// await
    Response response =
        await dio.post("${backEndApiLink}admin_fun/uploadImage.php",
            data: formData,
            options: Options(method: 'POST', headers: {
              HttpHeaders.contentTypeHeader: 'multipart/form-data',
            }));
    log(response.toString());
    return response.toString();
  }

  getActivationRequists() async {
    List responsList = [];
    try {
      Dio dio = Dio();

      Response response =
          await dio.get('${backEndApiLink}admin_fun/actiQuists.php');
      // '${backEndApiLink}categories.php');

      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Customer> customers = responsList.map((e) {
      return Customer.fromMap(e);
    }).toList();

    return customers;
  }

  upDateCustomer(Customer customer) async {
    log('entered update');
    try {
      Dio dio = Dio();
      FormData formData = FormData.fromMap({'data': customer.toMap()});
      log('tried to create formDate!!');
      Response<String> response = await dio.post(
        '${backEndApiLink}updateCustomerStatus.php',
        data: formData,
        options: Options(method: 'POST', headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        //
      );
      log(customer.toMap().toString());
      // '${backEndApiLink}categories.php');
      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }

  getReservationRequists() async {
    List responsList = [];
    try {
      Dio dio = Dio();

      Response response = await dio.get('${backEndApiLink}getReservations.php');
      // '${backEndApiLink}categories.php');

      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log('getReservationRequists error: ${e.toString()}');
    }
    List<ReservationTemplate> customers = responsList.map((e) {
      return ReservationTemplate.fromMap(e);
    }).toList();

    return customers;
  }

  getCustomersReservations() async {
    List responsList = [];
    try {
      Dio dio = Dio();

      Response response =
          await dio.get('${backEndApiLink}admin_fun/actiQuists.php');
      // '${backEndApiLink}categories.php');

      responsList = response.data;
      log(responsList.toString());
    } catch (e) {
      log(e.toString());
    }
    List<Customer> customers = responsList.map((e) {
      return Customer.fromMap(e);
    }).toList();

    return customers;
  }

  acceptReservation(String reservationId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}admin_fun/acceptReservation.php?reservationId=$reservationId',
      );

      log(response.toString());
    } catch (e) {
      log(e.toString());
      log('an error  checkCustomer');
    }
  }

  deleteReservation(String reservationId) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}deleteReseration.php?reservationId=$reservationId',
      );

      log(response.toString());
    } catch (e) {
      log(e.toString());
      log('an error  checkCustomer');
    }
  }

  getSummery() async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(
        '${backEndApiLink}admin_fun/getSummery.php',
      );

      log(response.toString());
      return response.data.first;
    } catch (e) {
      log(e.toString());
      log('an error  checkCustomer');
    }
  }
}
