import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'actions/navigation.dart';

class SweeperAppBar extends StatelessWidget implements PreferredSizeWidget{
  const SweeperAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:Colors.transparent,
      leading: BackButton(
        color: Colors.white,
        onPressed: (){

        },
      ),
      title: Column(
        children: [
          Text(
            "经典扫雷",
            style: TextStyle(fontSize: 18, color:Colors.white,fontWeight: FontWeight.bold),
          ),    Text(
            "v1.0.1",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
      centerTitle: true,
      actions: [

        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: (){
              // jumpUrl('https://github.com/toly1994328/toly_game');
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SvgPicture.asset(
                'assets/images/github.svg',
                package: 'sweeper',
                color: Colors.white,
                width: 24,
                height: 24,
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize =>const Size.fromHeight(kToolbarHeight);
}
