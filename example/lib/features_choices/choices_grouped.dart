import 'package:flutter/material.dart';
import 'package:smart_select/smart_select.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../options.dart' as options;

class FeaturesChoicesGrouped extends StatefulWidget {
  @override
  _FeaturesChoicesGroupedState createState() => _FeaturesChoicesGroupedState();
}

class _FeaturesChoicesGroupedState extends State<FeaturesChoicesGrouped> {

  String _smartphone = '';
  List<String> _car = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(height: 7),
        SmartSelect<String>.single(
          title: 'Smartphones',
          placeholder: 'Choose one',
          value: _smartphone,
          options: S2Option.listFrom<String, Map>(
            source: options.smartphones,
            value: (index, item) => item['id'],
            title: (index, item) => item['name'],
            group: (index, item) => item['brand'],
          ),
          modalType: S2ModalType.bottomSheet,
          choiceGrouped: true,
          onChange: (state) => setState(() => _smartphone = state.value),
          tileBuilder: (context, state) {
            return S2Tile(
              title: state.title,
              value: state.valueDisplay,
              onTap: state.showModal,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/xsGxhtAsfSA/100x100'),
              ),
            );
          }
        ),
        const Divider(indent: 20),
        SmartSelect<String>.multiple(
          title: 'Cars',
          placeholder: 'Choose one or more',
          value: _car,
          options: S2Option.listFrom<String, Map>(
            source: options.cars,
            value: (index, item) => item['value'],
            title: (index, item) => item['title'],
            group: (index, item) => item['body'],
          ),
          onChange: (state) => setState(() => _car = state.value),
          modalType: S2ModalType.bottomSheet,
          modalConfirmation: true,
          modalFilter: true,
          choiceGrouped: true,
          choiceStyle: const S2ChoiceStyle(
            activeColor: Colors.redAccent
          ),
          groupBuilder: (context, header, choices) {
            return StickyHeader(
              header: header,
              content: choices,
            );
          },
          groupHeaderBuilder: (context, group, searchText) {
            return Container(
              color: Colors.redAccent,
              padding: const EdgeInsets.all(15),
              alignment: Alignment.centerLeft,
              child: S2Text(
                text: group.name,
                highlight: searchText,
                highlightColor: Colors.teal,
                style: const TextStyle(
                  color: Colors.white
                ),
              ),
            );
          },
          tileBuilder: (context, state) {
            return S2Tile.fromState(
              state,
              isTwoLine: true,
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://source.unsplash.com/yeVtxxPxzbw/100x100'),
              ),
            );
          }
        ),
        const SizedBox(height: 7),
      ],
    );
  }
}