import 'package:flutter/material.dart';
import 'package:flutter_crud_api_sample_app/source/api/api_service.dart';
import 'package:flutter_crud_api_sample_app/source/model/profile.dart';
import 'package:flutter_crud_api_sample_app/source/ui/formAdd/form_add_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BuildContext context;
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = ApiService();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        future: apiService.getProfiles(),
        builder: (BuildContext context, AsyncSnapshot<List<Profile>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                  "Terdapat kesalahan pada pesan: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Profile> profiles = snapshot.data;
            return _buildListView(profiles);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildListView(List<Profile> profiles) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Profile profile = profiles[index];
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Data ke-'+profile.id.toString(),
                      style: Theme.of(context).textTheme.title,
                    ),
                    Text(
                      'Nama : '+profile.name, style: Theme.of(context).textTheme.subtitle,
                    ),
                    Text('Email  : '+profile.email, style: Theme.of(context).textTheme.subtitle,),
                    Text('Umur  : '+profile.age.toString()+' tahun', style: Theme.of(context).textTheme.subtitle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlineButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Peringatan!!!"),
                                    content: Text(
                                        "Apakah anda yakin menghapus data ${profile.name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Ya"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService
                                              .deleteProfile(profile.id)
                                              .then((isSuccess) {
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Sukses menghapus data")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(
                                                      content: Text(
                                                          "Gagal menghapus data")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("Tidak"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Hapus",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        OutlineButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return FormAddScreen(profile: profile);
                            }));
                          },
                          child: Text(
                            "Ubah",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: profiles.length,
      ),
    );
  }
}