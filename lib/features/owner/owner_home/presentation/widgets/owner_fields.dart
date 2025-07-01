import 'package:book_and_play/core/theme/color_manager.dart';
import 'package:flutter/material.dart';

class OwnerFields extends StatelessWidget {
  const OwnerFields({
    super.key,
    this.image,
    required this.title,
    required this.capacity,
    this.rateNum,
    required this.location,
    this.onTap,
  });
  final String title, location, capacity;
  final String? image;
  final void Function()? onTap;
  final String? rateNum;
  @override
  Widget build(BuildContext context) {
    final imageProvider = (image != null && image!.isNotEmpty)
        ? NetworkImage(image!)
        : AssetImage('assets/images/football_stadium_demo.jpg')
              as ImageProvider;
    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: SizedBox(
          height: 250,
          width: 300,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 150, // screenHeight * 0.19,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: imageProvider,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 120,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 7, vertical: 6),
                  height: 100,
                  width: 180,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        offset: Offset(0, 3),
                        blurRadius: 8,
                        spreadRadius: 0,
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 5),
                      rateNum != null
                          ? Row(
                              children: [
                                ImageIcon(
                                  AssetImage('assets/icons/star_icon.png'),
                                  color: ColorManager.primaryColor,
                                  size: 17,
                                ),
                                Text(
                                  rateNum!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),
                      SizedBox(height: 3),
                      Text(
                        capacity,
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                      SizedBox(height: 3),
                      Text(
                        location,
                        style: TextStyle(color: Colors.grey[700], fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
class RecommendedGridView extends StatelessWidget {
  const RecommendedGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final spacing = screenWidth * 0.07; // 5% of screen width
    final List<String> listOfNames = ['Red Meadows', 'Shuttles Fly'];
    final List<String> listOfLocations = ['Cairo , Egypt', 'Badminton'];

    //final screenHeight = MediaQuery.sizeOf(context).height;
    return SizedBox(
      height: 250, // screenHeight * 0.19,
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.5,
          crossAxisSpacing: spacing,
        ),
        itemCount: listOfImage.length, // list.length,
        itemBuilder: (context, index) {
          return OwnerFields(
            capacity: '',
            title: listOfNames[index],
            location: listOfLocations[index],

            image: listOfImage[index],
          );
        },
      ),
    );
  }
}
*/