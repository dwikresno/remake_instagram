import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ComplexModal extends StatelessWidget {
  final ScrollController scrollController;

  const ComplexModal({Key key, this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WillPopScope(
        onWillPop: () async {
          bool shouldClose = true;
          await showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Should Close?'),
                    actions: <Widget>[
                      CupertinoButton(
                        child: Text('Yes'),
                        onPressed: () {
                          shouldClose = true;
                          Navigator.of(context).pop();
                        },
                      ),
                      CupertinoButton(
                        child: Text('No'),
                        onPressed: () {
                          shouldClose = false;
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          print('hello');
          return shouldClose;
        },
        child: Navigator(
          onGenerateRoute: (_) => MaterialPageRoute(
            builder: (context) => Builder(
              builder: (context) => CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    leading: Container(), middle: Text('Modal Page')),
                child: SafeArea(
                  bottom: false,
                  child: ListView(
                    shrinkWrap: true,
                    controller: scrollController,
                    children: ListTile.divideTiles(
                      context: context,
                      tiles: List.generate(
                          100,
                          (index) => ListTile(
                                title: Text('Item'),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          CupertinoPageScaffold(
                                              navigationBar:
                                                  CupertinoNavigationBar(
                                                middle: Text('New Page'),
                                              ),
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: <Widget>[],
                                              ))));
                                },
                              )),
                    ).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
