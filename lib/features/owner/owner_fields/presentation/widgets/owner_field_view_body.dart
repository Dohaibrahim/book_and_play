import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:book_and_play/core/theme/text_styles.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/delete_field_cubit/delete_field_cubit.dart';
import 'package:book_and_play/features/owner/owner_fields/presentation/manager/delete_field_cubit/delete_field_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerFieldViewBody extends StatelessWidget {
  const OwnerFieldViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final OwnerField args =
        ModalRoute.of(context)!.settings.arguments as OwnerField;
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: screenHeight * 0.50,
          child: args.image == null
              ? Image.asset(
                  'assets/images/football_stadium_demo.jpg',
                  fit: BoxFit.fill,
                )
              : Image.network(args.image!),
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                args.name,
                style: TextStyles.font32BlockBold.copyWith(fontSize: 26),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Image.asset(
                    'assets/icons/maps_marker_icon.png',
                    width: 20,
                    height: 20,
                  ),
                  Text(
                    '${args.city} , ${args.country}',
                    style: TextStyles.font14BlackMedium.copyWith(
                      color: ColorManager.primaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Text(
                '${args.capacity} x ${args.capacity} Football Field',
                style: TextStyles.font14BlackMedium,
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
        Expanded(child: SizedBox()),
        /*Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(onPressed: () {}, text: 'Edit Field'),
        ),*/
        SizedBox(height: 6),
        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20),
          child: AppButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => BlocProvider(
                  create: (context) => DeleteFieldCubit(),
                  child: BlocConsumer<DeleteFieldCubit, DeleteFieldState>(
                    listener: (context, state) {
                      if (state is DeleteFieldSuccessState) {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        TopSnackBar.show(
                          context,
                          title: 'Success',
                          message: 'your field has been removed successfully!',
                          contentType: ContentType.success,
                          color: ColorManager.primaryColor,
                        );
                      }
                      if (state is DeleteFieldFailureState) {
                        TopSnackBar.show(
                          context,
                          title: 'Error',
                          message: state
                              .errorMessage, //'there are an error happened trying delete your field',
                          contentType: ContentType.failure,
                          color: Colors.red,
                        );
                      }
                    },
                    builder: (context, state) {
                      return AlertDialog(
                        title: SizedBox(),
                        content: Text(
                          'Are you sure you want to permanently delete your account?',
                          textAlign: TextAlign.center,
                          style: TextStyles.font24BlackBold.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              context.read<DeleteFieldCubit>().deleteField(
                                args.id,
                              );
                            },
                            child: const Text(
                              'Confirm',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              );
            },
            text: 'Delete Field',
            textStyle: TextStyle(fontSize: 20),
            buttonColor: Colors.red[700],
          ),
        ),
        SizedBox(height: 40),
      ],
    );
  }
}
