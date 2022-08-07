import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SidebarTile extends StatefulWidget {
  final Widget leading;
  final String title;
  const SidebarTile({Key? key, required this.leading, required this.title})
      : super(key: key);

  @override
  State<SidebarTile> createState() => _SidebarTileState();
}

class _SidebarTileState extends State<SidebarTile> {
  bool isHovered = false;

  void setIsHovered(bool value) {
    setState(() {
      isHovered = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setIsHovered(true),
      onExit: (event) => setIsHovered(false),
      child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              color: isHovered ? Colors.grey[200] : null,
              borderRadius: BorderRadius.circular(30)),
          child: ListTile(
            leading: widget.leading,
            title: Text(widget.title),
          )),
    );
  }
}

class DesktopSidebar extends StatelessWidget {
  final double width;
  const DesktopSidebar({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: width,
        child: Column(
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      FaIcon(FontAwesomeIcons.twitter,
                          color: Colors.blue,
                          size: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.fontSize),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Yeeter',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                    ],
                  ),
                )),
            const SidebarTile(leading: Icon(Icons.home), title: 'Home'),
            const SidebarTile(leading: Icon(Icons.mail), title: 'Messages'),
            const SidebarTile(leading: Icon(Icons.person), title: 'Profile'),
            InkWell(
              onTap: () {},
              hoverColor: Colors.transparent,
              borderRadius: BorderRadius.circular(60),
              child: Container(
                  margin: const EdgeInsets.all(8),
                  height: width / 4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: Center(
                      child: Text('Yeet',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: Colors.white)))),
            ),
          ],
        ));
  }
}
