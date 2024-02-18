import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_uts/layout/detailview.dart';
import './bloc/listproduct_bloc.dart';
import 'layout/katalogpagestate.dart';

// ignore: must_be_immutable
class ListInfoView extends StatelessWidget {
  final List info;
  String searchText;

  ListInfoView({super.key, required this.info, this.searchText = ""});

  @override
  Widget build(BuildContext context) {
    TextEditingController search0 = TextEditingController(text: searchText);

    return Scaffold(
      appBar: AppBar(title: const Text("List Information")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: search0,
              decoration: const InputDecoration(labelText: 'Cari informasi'),
            ),
            ElevatedButton(
              onPressed: () {
                final search = search0.text;

                context
                    .read<ListproductBloc>()
                    .add(LoadListProductEvent(keyword: search));
              },
              child: const Text('Cari'),
            ),
            SizedBox(
                height:
                    16.0), // Add some spacing between the search bar and the grid of cards
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(left: 20, right: 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Number of columns in the grid
                  crossAxisSpacing: 5, // Spacing between columns
                  mainAxisSpacing: 8,
                  childAspectRatio: 1, // Spacing between rows
                ),
                itemCount: info.length,
                itemBuilder: (context, index) {
                  final Map infoItem = info[index];
                  return Card(
                    margin: EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Image.network(
                          infoItem['img'],
                          width: 100.0,
                          height: 100.0,
                          fit: BoxFit.cover,
                        ),
                        ListTile(
                          title: Text(infoItem['title']),
                          subtitle: Text('Rp.' + infoItem['date']),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailInfo(
                                  infoId: infoItem['id'].toString(),
                                ),
                              ),
                            ).then((search) {
                              final search = search0.text;

                              context
                                  .read<ListproductBloc>()
                                  .add(LoadListProductEvent(keyword: search));
                            });
                          },
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
    );
  }
}
