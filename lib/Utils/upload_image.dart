import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/controller/image/image_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateImageWidget extends StatelessWidget {
  const UpdateImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ImageController>(builder: (context, viewController, child) {
      // void test(id) {
      //   // print(imagekey);
      //   // viewController.updateImage(context, id);
      // }

      return Column(
        children: [
          TextFormField(
            onTap: () async {
              await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return CupertinoActionSheet(
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: Text(
                            "Camera",
                            // style: AppFont.helvBold(16,
                            //     color: AppColors.appBlack()),
                          ),
                          onPressed: () async {
                            // Navigator.pop(context);

                            await viewController.pickImageFromCamera(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: Text("Gallery"
                              // Utils.getTranslated(
                              //     context, "report_gallery"),
                              // style: AppFont.helvBold(16,
                              //     color: AppColors.appBlack()),
                              ),
                          onPressed: () async {
                            await viewController.pickImageFromGallery(context);
                          },
                        ),
                      ],
                    );
                  });
            },
            controller: TextEditingController(text: "Tap to upload"),
            maxLines: null,
            readOnly: true,
            decoration: InputDecoration(
                suffixIcon: Icon(
                  Icons.upload,
                  size: 20,
                  //color: AppColor.wordingColorBlack),
                ),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12))),
          ),
          viewController.getImageList.isEmpty
              ? SizedBox.shrink()
              : FadeInSlide(
                  duration: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        height: 120,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(10.0),
                          scrollDirection: Axis.horizontal,
                          // gridDelegate:
                          //     const SliverGridDelegateWithFixedCrossAxisCount(
                          //   crossAxisCount: 3,
                          //   crossAxisSpacing: 5,
                          //   mainAxisSpacing: 5,
                          // ),
                          itemCount: viewController.getImageList.length,
                          itemBuilder: (context, index) {
                            return Container(
                              height: 120,
                              // padding:
                              //     EdgeInsets.all(2),
                              // color: Colors.white,
                              margin: EdgeInsets.only(right: 15),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    // onTap: () => _viewImage(context, _imageFiles[index]),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      padding: EdgeInsets.all(2),
                                      margin: const EdgeInsets.only(
                                          right: 13, top: 12),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: Image.file(
                                          viewController.getImageList[index],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                      onTap: () =>
                                          viewController.removeImage(index),
                                      child: Container(
                                        padding: EdgeInsets.all(1),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      );
    });
  }
}
