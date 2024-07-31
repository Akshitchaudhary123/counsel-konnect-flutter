import 'dart:io';

import 'package:counsil_konnect/Utils/textStyle.dart';
import 'package:counsil_konnect/view/pages/Event/Event%20Controller/eventController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/customButton.dart';

class Online extends StatefulWidget {
   Online({super.key});

  @override
  State<Online> createState() => _OnlineState();
}

class _OnlineState extends State<Online> {
  EventController eventController=Get.put(EventController());
  final bool isIos=Platform.isIOS;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: [

          Row(
            children: [
              Container(
                height:63.h,
                width: 157.52.w,
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(15.r)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [


                    InkWell(
                      onTap: () {
                        if (isIos) {
                          showModalBottomSheet(
                            context: context,


                            builder: (BuildContext context) {
                              return Column(
                                children: [
                                  Container(
                                    width: Get.width,
                                    height: 250.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r)
                                    ),
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,

                                      initialDateTime: DateTime.now(),
                                      onDateTimeChanged: (DateTime newDateTime) {
                                        // Handle the selected date
                                        eventController.setSelectedDate(newDateTime);
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding:  EdgeInsets.symmetric(horizontal: 32.w,vertical: 10.h),
                                    child: CustomButton(text: 'Set', onTap: (){
Get.back();                                    }, padding: EdgeInsets.symmetric(vertical: 10.h)),
                                  )
                                ],
                              );
                            },
                          );
                        }else{
                          showDialog(

                            context: context,
                            builder: (context) {
                              return DatePickerDialog(

                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().add(Duration(days: 365)), // One year from now
                                initialDate: DateTime.now(),
                              );
                            },
                          ).then((selectedDate){
                            if(selectedDate!=null){
                              eventController.setSelectedDate(selectedDate);

                            }
                          });
                        }

                      },
                      child: Container(
                        height: 38.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: Color(0xffE7E7E7),
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/date.png', height: 15.0, width: 13.5),
                          ],
                        ),
                      ),
                    ),

                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //
                    //     Text('Day',style: CustomTextStyle.bodyTextStyle.copyWith(
                    //         color: Color(0xff65656A),
                    //         fontWeight: FontWeight.w700,
                    //         fontSize: 12.sp
                    //     ),),
                    //     Text(eventController.dateOnline.text.isNotEmpty
                    //         ? eventController.dateOnline.text
                    //         : 'No Date Selected',style: CustomTextStyle.bodyTextStyle.copyWith(
                    //         fontSize: 8.sp,
                    //         fontWeight: FontWeight.w500,
                    //         color: Color(0xffA7A7AC)
                    //     ),)
                    //
                    //   ],
                    // ),
                    Obx(
                          () => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Day',
                            style: CustomTextStyle.bodyTextStyle.copyWith(
                              color: Color(0xff65656A),
                              fontWeight: FontWeight.w700,
                              fontSize: 12.sp,
                            ),
                          ),
                          Text(
                            eventController.dateOnline.value.isNotEmpty
                                ? eventController.dateOnline.value
                                : 'No Date Selected',
                            style: CustomTextStyle.bodyTextStyle.copyWith(
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffA7A7AC),
                            ),
                          ),
                        ],)),

                    Padding(
                      padding:  EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap:(){
                              eventController.incrementDate();
                            },
                            child: Container(
                              height: 6.h,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/up.png'),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          InkWell(
                            onTap: (){
                              eventController.decrementDate();
                            },
                            child: Container(
                              height: 6.h,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/dropdown.png'),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
              SizedBox(width: 9.w,),
              Container(
                height:63.h,
                width: 157.52.w,
                decoration: BoxDecoration(
                    color: Color(0xffF3F3F3),
                    borderRadius: BorderRadius.circular(15.r)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (context){
                          return   TimePickerDialog(initialTime: TimeOfDay.now());

                        }).then((selectedTime){
                          if(selectedTime!=null){
                            eventController.setSelectedTime(selectedTime);
                          }
                        });
                      },
                      child: Container(
                        height:38.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color: Color(0xffE7E7E7),
                            borderRadius: BorderRadius.circular(9.sp)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/clock.png',height:15.h,width:13.5.w ,),
                          ],
                        ),
                      ),
                    ),
                    Obx(()=> Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Time',style: CustomTextStyle.bodyTextStyle.copyWith(
                            color: Color(0xff65656A),
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp
                        ),),
                        Text(    eventController.time.value.isNotEmpty
                            ? eventController.time.value
                            : 'No Date Selected',style: CustomTextStyle.bodyTextStyle.copyWith(
                            fontSize: 8.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xffA7A7AC)
                        ),),
                        // '13:00 - 14:00'
                      ],
                    ),),

                    Padding(
                      padding:  EdgeInsets.only(top: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              eventController.incrementTime();
                            },
                            child: Container(
                              height: 6.h,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/up.png'),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 5.h,),
                          InkWell(
                            onTap: (){
                              eventController.decrementTime();
                            },
                            child: Container(
                              height: 6.h,
                              width: 9.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage('assets/images/dropdown.png'),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ],
          ),

          SizedBox(height:15.h),
          TextFormField(
            controller: eventController.eventNameOnline,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              contentPadding:  EdgeInsets.only(
                  left: 20.w,
                  top: 20.h,
                  bottom: 20.h
              ),

              filled: true,
              fillColor: Color(0xffF3F3F3),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              hintText: 'Give your event a name',
              hintStyle: CustomTextStyle.h1TextStyle.copyWith(
                color: Color(0xff65656A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,

              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              // labelText: title,
              // labelStyle: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 14,
              //     fontWeight: FontWeight.normal
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,

                ),
              ),
            ),
          ),
          SizedBox(height:15.h),
          TextFormField(
            maxLines: 5,
            // maxLength: 5,
            controller: eventController.descriptionOnline,
            decoration: InputDecoration(
              alignLabelWithHint: true,

              contentPadding:  EdgeInsets.only(
                  left: 20.w,
                  top: 12.h
              ),

              filled: true,
              fillColor: Color(0xffF3F3F3),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              hintText: 'Add description...',
              hintStyle: CustomTextStyle.h1TextStyle.copyWith(
                color: Color(0xff65656A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,

              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              // labelText: title,
              // labelStyle: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 14,
              //     fontWeight: FontWeight.normal
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,

                ),
              ),
            ),
          ),
          SizedBox(height:15.h),

          TextFormField(
            controller: eventController.eventLinkOnline,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              contentPadding:  EdgeInsets.only(
                  left: 20.w,
                  top: 20.h,
                  bottom: 20.h
              ),

              filled: true,
              fillColor: Color(0xffF3F3F3),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              hintText: 'Event Link',
              hintStyle: CustomTextStyle.h1TextStyle.copyWith(
                color: Color(0xff65656A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,

              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              // labelText: title,
              // labelStyle: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 14,
              //     fontWeight: FontWeight.normal
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,

                ),
              ),
            ),
          ),

          SizedBox(height:15.h),
          TextFormField(
            controller: eventController.speakerOnline,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              contentPadding:  EdgeInsets.only(
                  left: 20.w,
                  top: 20.h,
                  bottom: 20.h
              ),

              filled: true,
              fillColor: Color(0xffF3F3F3),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              hintText: 'Speaker',
              hintStyle: CustomTextStyle.h1TextStyle.copyWith(
                color: Color(0xff65656A),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,

              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15.r),
              ),
              // labelText: title,
              // labelStyle: TextStyle(
              //     color: Colors.grey[700],
              //     fontSize: 14,
              //     fontWeight: FontWeight.normal
              // ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.transparent,

                ),
              ),
            ),
          ),


          Padding(
            padding:  EdgeInsets.symmetric(vertical: 39.h),
            child: CustomButton(text: 'Post', onTap: ()async{
              final String eventTime = eventController.combineDateAndTime(eventController.selectedDate.value, eventController.selectedTime.value);

              await eventController.onlinePost(
                  imagesPath: [eventController.containerBack.value!],
                  photosName: ['image'],
                  eventLink: eventController.eventLinkOnline.text,
                  eventName: eventController.eventNameOnline.text,
                  eventTime: eventTime,
                  description: eventController.descriptionOnline.text,
                  speaker: eventController.speakerOnline.text);
            }, padding: EdgeInsets.symmetric(vertical: 15.h)),
          )

        ],
      ),


    );
  }
}
