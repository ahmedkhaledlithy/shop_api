import 'package:dsc_shop/shared/colors.dart';
import 'package:flutter/material.dart';

class EditInfo extends StatelessWidget {
  final String titleInfo;
  final String dataInfo;
  final GestureTapCallback? onTap;
  const EditInfo({Key? key,required this.titleInfo,required this.dataInfo,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titleInfo,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryColor,
                fontSize: 16),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: whiteColor),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10),
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text(dataInfo,
                    style: TextStyle(
                      color: grey500Color,
                    ),
                  ),
                  InkWell(
                    onTap: onTap ,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10),
                        color: grey50Color,
                      ),
                      width: 35,
                      height: 35,
                      child: Icon(
                        Icons.edit,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
