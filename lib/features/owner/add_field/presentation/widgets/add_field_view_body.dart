import 'dart:developer';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/app_text_form_field.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/add_field/data/models/add_field_req.dart';
import 'package:book_and_play/features/owner/add_field/presentation/manager/add_field_cubit/add_field_cubit.dart';
import 'package:book_and_play/features/owner/add_field/presentation/manager/add_field_cubit/add_field_state.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

class AddFieldViewBody extends StatefulWidget {
  const AddFieldViewBody({super.key});

  @override
  State<AddFieldViewBody> createState() => _AddFieldViewBodyState();
}

class _AddFieldViewBodyState extends State<AddFieldViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? countryName;
  String? capacityValue, fieldName, cityName;
  double? longtiude, latitude;
  bool isCountrySelected = false;
  File? image;
  int? capacityNumber;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    ); // or ImageSource.camera

    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final screenWidth = MediaQuery.sizeOf(context).width;
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.13),
              Text(
                'Fill Your Football Field Information',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: screenHeight * 0.04),
              AppTextFormField(
                hintText: 'Football field name',
                onSaved: (data) {
                  fieldName = data;
                },
                hintStyle: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    height: 50,
                    minWidth: screenWidth * 0.30,
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) async {
                          log('Select country: ${country.name}');
                          countryName = country.name;
                          countryName != null
                              ? isCountrySelected = true
                              : isCountrySelected = false;
                        },
                        onClosed: () {
                          countryName ??= '';
                        },
                      );
                    },
                    color: ColorManager.primaryColor,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    child: Text('Select Country'),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  SizedBox(
                    width: screenWidth * 0.55,
                    child: AppTextFormField(
                      hintText: 'Football field city',
                      onSaved: (data) {
                        cityName = data;
                      },
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: DropdownButton<String>(
                  isExpanded: true,
                  menuWidth: screenWidth * 0.50,
                  hint: Text("Capacity of the field"),
                  value: capacityValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      capacityValue = newValue;
                      String numberToSend = capacityValue!
                          .split(' ')
                          .first; // '10'
                      capacityNumber = int.parse(numberToSend); // 10 as integer
                    });
                  },
                  items: <String>['10 x 10', '5 x 5', '7 x 7']
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      })
                      .toList(),
                ),
              ),
              AppButton(
                onPressed: () async {
                  formKey.currentState!.save();
                  final pickedLocation = await Navigator.pushNamed<LatLng>(
                    context,
                    Routes.pickLocationView,
                  );
                  if (pickedLocation != null) {
                    log('at previous screen : ${pickedLocation}');
                    latitude = pickedLocation.latitude;
                    longtiude = pickedLocation.longitude;
                    //context.read<LocationCubit>().locationPicked(pickedLocation);
                  }
                  //Navigator.pushNamed(context, Routes.pickLocationView);
                },
                text: 'Choose Location',
                height: 40,
                textColor: Colors.black,
                textStyle: TextStyle(fontSize: 17),
                buttonWidth: screenWidth * 0.86,
              ),

              SizedBox(height: 10),
              MaterialButton(
                height: 45,
                minWidth: screenWidth * 0.80,
                color: ColorManager.textColor,
                onPressed: _pickImage,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                child: Text(
                  'pick an image of the field',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.30),
              BlocConsumer<AddFieldCubit, AddFieldState>(
                listener: (context, state) {
                  if (state is AddFieldSuccessState) {
                    Navigator.pop(context);
                    TopSnackBar.show(
                      context,
                      title: 'Done1',
                      message: 'Your field is now added successfully',
                      contentType: ContentType.success,
                      color: ColorManager.primaryColor,
                    );
                  }
                },
                builder: (context, state) {
                  return AppButton(
                    onPressed: () {
                      log(
                        ' data at ui => $countryName , $capacityNumber , $fieldName , $cityName , $longtiude , $latitude',
                      );
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (image != null &&
                            countryName != null &&
                            capacityNumber != null) {
                          context.read<AddFieldCubit>().addField(
                            AddFieldRequest(
                              name: fieldName!,
                              imageFile: image!,
                              country: countryName!,
                              city: cityName!,
                              capacity: capacityNumber!,
                              isPaid: 'false',
                              pricePerHour: 0,
                              location: Location(
                                coordinates: [latitude!, longtiude!],
                              ),
                              locationInfo: 'near to mostorad bridge',
                            ),
                          );
                        }
                      }
                    },
                    text: 'Add Football Field',
                    textStyle: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                    ),
                    height: 50,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
