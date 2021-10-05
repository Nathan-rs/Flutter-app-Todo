import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.inColor,
    required this.time,
    required this.check,
    required this.iconBgColor
  })
      : super(key: key);

  final String title;
  final IconData iconData;
  final Color inColor;
  final String time;
  final bool check;
  final Color iconBgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Theme(
            child: Transform.scale(
              scale:1.5,
              child: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                activeColor: Color(0xff6cf8a9),
                checkColor: Color(0xff0e3e26),
                value: check,
                onChanged: (value){}
              ),
            ),
            data: ThemeData(
              primarySwatch: Colors.blue,
              unselectedWidgetColor: Color(0xff5e6)
            ),
          ),
          Expanded(
            child: Container(
              height: 75,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Color(0xff2a2e3d),
                child: Row(
                  children: [
                    SizedBox(width: 15,),
                    Container(
                      width: 33,
                      height: 36,
                      decoration: BoxDecoration(
                        color: iconBgColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(iconData, color: inColor,),
                    ),
                    SizedBox(width: 20,),
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20,),
                  ],
                ),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
