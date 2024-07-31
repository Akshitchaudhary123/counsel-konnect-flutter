import 'package:counsil_konnect/Routes/routes_name.dart';
import 'package:counsil_konnect/view/pages/Ask%20AQuestion/formCategoryModel/formCategoryModel.dart';
import 'package:counsil_konnect/view/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';


import '../../../Utils/constant/constant.dart';
import '../../../Utils/textStyle.dart';
import '../../widgets/appBarLeading.dart';
import 'Ask Question Cotroller/askQuestionController.dart';

class AskQuestion extends StatefulWidget {
   AskQuestion({super.key});

  @override
  State<AskQuestion> createState() => _AskQuestionState();
}

class _AskQuestionState extends State<AskQuestion> {
  final AskQuestionController askQuestionController = Get.put(AskQuestionController());
  GlobalKey<FormState>_key=GlobalKey<FormState>();
@override
void initState(){
  askQuestionController.getFormCategory();
  super.initState();
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.scaffoldColor,

      appBar: AppBar(
        backgroundColor: AppConstant.scaffoldColor,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        leading: CustomAppBarLeading(),
        iconTheme: const IconThemeData(color: Color(0xff056E60)),

        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Color(0xffE1DDDD),
            height: 1.0,
          ),
        ),
        title: Text(
          'Ask a Question',
          style: CustomTextStyle.h1TextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: Color(0xff65656A),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 32.w,vertical:20.h ),
            child: Column(
              children: [
                TextFormField(
                  controller: askQuestionController.Title,
                  validator: (value){
                    if(value!.isEmpty){
                      return 'Provide some title';
                    }
                    return null;
                  },
                 decoration:  InputDecoration(
                    alignLabelWithHint: true,
                    contentPadding:  EdgeInsets.only(
                      left: 20.w,
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
                    hintText: 'Title',
                    hintStyle: CustomTextStyle.bodyTextStyle.copyWith(
                        color: Color(0xff65656A),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500
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
                  cursorColor:  Color(0xff056E60),
                ),
                SizedBox(height:14.h ,),
                // Obx(
                //       () => DropdownButtonFormField<String>(
                //     value: askQuestionController.selectedOption.value.isEmpty ? null : askQuestionController.selectedOption.value,
                //     onChanged: (String? newValue) {
                //       askQuestionController.selectedOption.value = newValue!;
                //     },
                //     items: <String>['Select Category','Image', 'File']
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem<String>(
                //         value: value,
                //         child: Text(
                //           value,
                //           style: CustomTextStyle.bodyTextStyle.copyWith(
                //             fontSize: 12.sp,
                //             fontWeight: FontWeight.w500,
                //             color: Color(0xff65656A),
                //           ),
                //         ),
                //       );
                //     }).toList(),
                //         icon: Icon(Icons.keyboard_arrow_down),
                //     decoration: InputDecoration(
                //       contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                //       filled: true,
                //       fillColor: Color(0xffF3F3F3),
                //       focusedBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(
                //           color: Colors.transparent,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(15.r),
                //       ),
                //       enabledBorder: OutlineInputBorder(
                //         borderSide: const BorderSide(
                //           color: Colors.transparent,
                //           width: 1,
                //         ),
                //         borderRadius: BorderRadius.circular(15.r),
                //       ),
                //       border: OutlineInputBorder(
                //         borderRadius: BorderRadius.circular(15.r),
                //         borderSide: const BorderSide(
                //           color: Colors.transparent,
                //         ),
                //       ),
                //     ),
                //     hint: Text(
                //       'Select Category',
                //       style: CustomTextStyle.bodyTextStyle.copyWith(
                //         fontSize: 12.sp,
                //         fontWeight: FontWeight.w500,
                //         color: Color(0xff65656A),
                //       ),
                //     ),
                //   ),
                // ),
                Obx(
                      () => DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Select the Category';
                      }
                      return null;
                    },
                    value: askQuestionController.selectedOption.value == 'Select Category'
                        ? null
                        : askQuestionController.selectedOption.value,
                    onTap: () async {
                      if (askQuestionController.categoryList.isEmpty) {
                        bool success = await askQuestionController.getFormCategory();
                        if (!success) {
                          Get.snackbar('Error', 'Failed to load categories');
                        }
                      }
                    },
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        var selectedCategory = askQuestionController.categoryList
                            .firstWhere((category) => category.name == newValue);

                        // Set the selected name and ID in the controller
                        askQuestionController.selectedOption.value = newValue;
                        askQuestionController.selectedCategoryId = selectedCategory.id;
                      }
                    },
                    items: askQuestionController.categoryList.map((category) {
                      return DropdownMenuItem<String>(
                        value: category.name,
                        child: Text(
                          category.name,
                          style: CustomTextStyle.bodyTextStyle.copyWith(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff65656A),
                          ),
                        ),
                      );
                    }).toList(),
                    icon: Icon(Icons.keyboard_arrow_down),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      filled: true,
                      fillColor: Color(0xffF3F3F3),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                        borderSide: const BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    hint: Text(
                      'Select Category',
                      style: CustomTextStyle.bodyTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff65656A),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                GestureDetector(
                  onTap: askQuestionController.pickFile,
                  child: Container(
                    height: 177.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    child: Obx(
                          () => askQuestionController.selectedFile.value == null
                          ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
          Image.asset('assets/images/fileSelect.png',height:42.h ,width:31.w ,)      ,

                            SizedBox(height: 13.h,),
                            Text(
                              'Upload a File',
                              style: CustomTextStyle.bodyTextStyle.copyWith(
                                color: Color(0xff96A3AD),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,

                              ),
                            ),
                          ],
                        ),
                      )
                          : askQuestionController.filePath.value.endsWith('.pdf')
                          ? Center(
                        child: Text(
                          'PDF Selected: ${askQuestionController.filePath.value.split('/').last}',
                          textAlign: TextAlign.center,
                          style: CustomTextStyle.bodyTextStyle.copyWith(
                            color: Color(0xff65656A),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                          : Image.file(
                            askQuestionController.selectedFile.value!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 39.h),
                  child: CustomButton(
                    text: 'Post',
                    onTap: () async {
                      if (_key.currentState!.validate()) {
                        bool success = await askQuestionController.uploadAskQuestion(
                          askQuestionController.Title.text,
                          askQuestionController.selectedCategoryId.toString(),
                          askQuestionController.selectedFile.value!.path,
                        );
                        if (success) {
                          // Clear the fields only if the upload was successful
                          askQuestionController.Title.clear();
                          askQuestionController.selectedFile.value = null;
                          askQuestionController.filePath.value = '';
                          askQuestionController.selectedOption.value = 'Select Category';
                          askQuestionController.selectedCategoryId = 0;
                        }
                      }
                    },
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                  ),
                )

                // Padding(
                //   padding:  EdgeInsets.symmetric(vertical: 39.h),
                //   child: CustomButton(text: 'Post', onTap: ()async{
                //
                //
                //   },
                //
                //       padding: EdgeInsets.symmetric(vertical: 15.h,)),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
