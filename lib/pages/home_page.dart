import 'package:flutter/material.dart';
import 'package:trilhaapp/pages/card_page.dart';
import 'package:trilhaapp/pages/image_assets.dart';
import 'package:trilhaapp/pages/list_view.dart';
import 'package:trilhaapp/pages/list_view_h.dart';
import 'package:trilhaapp/pages/tarefas/tarefa_hive_page.dart';
import 'package:trilhaapp/pages/tarefas/tarefa_sqlite_page.dart';
import 'package:trilhaapp/shared/widgets/custon_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  PageController controller = PageController(initialPage: 0);
  int posicaoPagina = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
        ),
        drawer: const CustonDrawer(),
        body: Column(
          children: [
            Expanded(
              child: PageView(
                controller: controller,
                onPageChanged: (value) {
                  setState(() {
                    posicaoPagina = value;
                  });
                },
                children: const [
                  CardPage(),
                  ImageAssetPage(),
                  // ListViewPage(),
                  ListViewPage(),
                  ListViewH(),
                  TarefaSQLitePage(),
                ],
              ),
            ),
            BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: (value) {
                  controller.jumpToPage(value);
                },
                currentIndex: posicaoPagina,
                items: const [
                  BottomNavigationBarItem(
                      label: "Pag1", icon: Icon(Icons.home)),
                  BottomNavigationBarItem(label: "Pag2", icon: Icon(Icons.add)),
                  BottomNavigationBarItem(
                      label: "Pag3", icon: Icon(Icons.person)),
                  BottomNavigationBarItem(
                      label: "pag4", icon: Icon(Icons.image)),
                  BottomNavigationBarItem(
                      label: "tarefas", icon: Icon(Icons.list))
                ])
          ],
        ),
      ),
    );
  }
}
