import 'package:flutter/material.dart';
import 'package:greens_veges/constants/app_theme.dart';

Widget orderCardHorizontal() {
  return InkWell(
    // onTap: () => onTapCallback(),
    child: Card(
        color: AppTheme.lightColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("#Oder number",style: TextStyle(color: AppTheme.darkColor,fontSize: 18,fontWeight: FontWeight.bold),),
                      SizedBox(height: 16.0,),
                      Text("date: sep 02/22",style: TextStyle(color: AppTheme.secondaryColor,fontSize: 14,fontWeight: FontWeight.normal),),
                    ],
                  )),
              Flexible(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Icon(Icons.edit,color: AppTheme.secondaryColor,),
                    Icon(Icons.replay_circle_filled_outlined,color: AppTheme.primaryColor,),
                    Icon(Icons.delete,color: AppTheme.redColor,),
                  ],
                ),
              ),
            ],
          ),
        )),
  );
}
