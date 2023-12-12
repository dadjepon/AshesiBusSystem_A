import 'package:ashesi_bus/helper/widgets/text.dart';
import 'package:flutter/material.dart';


class RegularAppBar extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String title;

  final BuildContext prevContext;

  const RegularAppBar(
    {
      super.key, 
      required this.prevContext,
      required this.title,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText(
        text: title,
      ),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 15,
        ),
        onPressed: () {
          Navigator.of(prevContext).pop(); 
        },
        iconSize: 15,
      ),
      backgroundColor: Colors.white,
    );
  }
}

class RegularAppBarNoBack extends StatelessWidget implements PreferredSizeWidget {
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
  final String title;

  const RegularAppBarNoBack(
    {
      super.key, 
      required this.title,
    }
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: HeaderText(
        text: title,
      ),
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }
}


class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {

  const HomeAppBar(
    {
      super.key
    }
  );

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      toolbarHeight: 100,
      title: Container(
        margin: const EdgeInsets.only(top: 10),
        child: Image.asset(
          'assets/images/ashesi_bus.png', 
          width: 150,
          height: 70,
        )
      ),
      backgroundColor: Colors.white
    );
  }
}