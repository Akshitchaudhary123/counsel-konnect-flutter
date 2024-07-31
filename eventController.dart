import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../Utils/Image Picker/imagePicker.dart';
import '../../../../Utils/sharedPrefrences/utilis.dart';
import '../../../../Utils/toast_utils.dart';
import '../../../../services/ApiServices/api_services.dart';
import '../../../../services/base_controller.dart';

class EventController extends GetxController{
  TextEditingController eventNameOnline=TextEditingController();
  TextEditingController descriptionOnline=TextEditingController();
  TextEditingController DateOnline=TextEditingController();
  TextEditingController TimeOnline=TextEditingController();
  TextEditingController eventNameOffline=TextEditingController();
  TextEditingController descriptionOffline=TextEditingController();
  TextEditingController DateOffline=TextEditingController();
  TextEditingController TimeOffline=TextEditingController();
  TextEditingController addressOffline=TextEditingController();
  TextEditingController eventLink=TextEditingController();
  TextEditingController eventLinkOnline=TextEditingController();

  TextEditingController speakerOnline=TextEditingController();
  TextEditingController speakerOffline=TextEditingController();
  // TextEditingController dateOnline = TextEditingController();
  TextEditingController timeOnline = TextEditingController();

  var containerBack = Rx<XFile?>(null);
  var isImagePickerActive = false.obs;

  Future<void> pickContainerImage() async {
    if (isImagePickerActive.value) return;

    isImagePickerActive.value = true; // Set flag to active
    ChooseImage imagePicker = ChooseImage(ImageSource.gallery);
    XFile? image = await imagePicker.getImage();

    if (image != null) {
      containerBack.value = image;
    }

    isImagePickerActive.value = false; // Reset flag
  }
  var selectedDate = DateTime.now().obs;
  var dateOnline = ''.obs;
  var time=''.obs;
  var selectedTime = TimeOfDay.now().obs;
  @override
  void onInit() {
    super.onInit();
    updateDateOnline();
    updateTimeOnline();
  }

  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    updateDateOnline();
  }

  void incrementDate() {
    selectedDate.value = selectedDate.value.add(Duration(days: 1));
    updateDateOnline();
  }

  void decrementDate() {
    selectedDate.value = selectedDate.value.subtract(Duration(days: 1));
    updateDateOnline();
  }

  void updateDateOnline() {
    dateOnline.value = DateFormat('dd MMMM, yyyy').format(selectedDate.value) ;
  }
  void setSelectedTime(TimeOfDay time) {
    selectedTime.value = time;
    updateTimeOnline();
  }

  void incrementTime() {
    final minutes = selectedTime.value.minute + 30;
    final newTime = TimeOfDay(hour: selectedTime.value.hour + minutes ~/ 60, minute: minutes % 60);
    setSelectedTime(newTime);
  }

  void decrementTime() {
    final minutes = selectedTime.value.minute - 30;
    final newTime = TimeOfDay(hour: selectedTime.value.hour + (minutes < 0 ? -1 : 0), minute: (minutes + 60) % 60);
    setSelectedTime(newTime);
  }

  void updateTimeOnline() {
    final hour = selectedTime.value.hour.toString().padLeft(2, '0');
    final minute = selectedTime.value.minute.toString().padLeft(2, '0');
    time.value = '$hour:$minute';
  }


  Future<bool> onlinePost({
    required List<XFile> imagesPath,
    required List<String> photosName,
    required String eventLink,
    required String eventName,
    required String eventTime,
    required String description,
    required String speaker

  }) async {
    Map<String, String> requestBody = <String, String>{
      'image': "",
      'event_link': eventLink,
      'event_name': eventName,
      'event_date_time': eventTime,
      'description': description,
      'speakers':speaker
    };
    BaseController().showLoading();
    var apiResponse = await ApiServices()
        .postFormDataWithImage(
      endPoint: "user/forum-online-event-post/store",
      payloadObj: requestBody,
      isTokened: true,
      photosNames: photosName,
      photosFile: imagesPath,
    )
        .catchError((error) {
      BaseController().hideLoading();
      BaseController().handleError(error);
      kLogger.e(error);
    });
    if (apiResponse == null) false;
    BaseController().hideLoading();
    kLogger.i(apiResponse);
    final data = jsonDecode(apiResponse);
    if (data["responseCode"] == "200") {
      BaseController().hideLoading();
      ToastUtils.showToast(data["responseMessage"].toString());
      return true;
    } else {
      ToastUtils.showToast(data["responseMessage"].toString());
      return false;
    }
  }
  String combineDateAndTime(DateTime date, TimeOfDay time) {
    final DateTime combined = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(combined);
  }



  Future<bool> offlinePost({
    required List<XFile> imagesPath,
    required List<String> photosName,
    required String eventLink,
    required String eventName,
    required String eventTime,
    required String description,
    required String speaker,
    required String venue_address,

  }) async {
    Map<String, String> requestBody = <String, String>{
      'image': "",
      'event_link': eventLink,
      'event_name': eventName,
      'event_date_time': eventTime,
      'description': description,
      'speakers':speaker,
      'venue_address':venue_address
    };
    BaseController().showLoading();
    var apiResponse = await ApiServices()
        .postFormDataWithImage(
      endPoint: "user/forum-offline-event-post/store",
      payloadObj: requestBody,
      isTokened: true,
      photosNames: photosName,
      photosFile: imagesPath,
    )
        .catchError((error) {
      BaseController().hideLoading();
      BaseController().handleError(error);
      kLogger.e(error);
    });
    if (apiResponse == null) false;
    BaseController().hideLoading();
    kLogger.i(apiResponse);
    final data = jsonDecode(apiResponse);
    if (data["responseCode"] == "200") {
      BaseController().hideLoading();
      ToastUtils.showToast(data["responseMessage"].toString());
      return true;
    } else {
      ToastUtils.showToast(data["responseMessage"].toString());
      return false;
    }
  }
}