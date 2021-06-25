import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'camera_image.dart';

final Color teal = Colors.teal;
final Color blue = Colors.lightBlueAccent;

class VaccineInfo extends StatelessWidget {
  final TextEditingController placeController = TextEditingController();
  final TextEditingController pharmacyController = TextEditingController();
  final TextEditingController vaccineController = TextEditingController();
  final TextEditingController dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50.0),
                      bottomRight: Radius.circular(50.0)),
                  gradient: LinearGradient(
                    colors: [blue, teal],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          "Vaccination Details",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 130),
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    children: [

                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            Flexible(
                              child: TextFormField(
                                controller: placeController,
                                decoration: InputDecoration(
                                  labelText: "Place",
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(width:10),
                            ElevatedButton(
                              onPressed: () {
                                showCountryPicker(
                                  context: context,
                                  //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                  exclude: <String>['KN', 'MF'],
                                  //Optional. Shows phone code before the country name.
                                  showPhoneCode: false,
                                  onSelect: (Country country) {
                                    print('Select country: ${country.displayName}');
                                    placeController.text=country.displayNameNoCountryCode;
                                  },
                                  // Optional. Sets the theme for the country list picker.
                                  countryListTheme: CountryListThemeData(
                                    // Optional. Sets the border radius for the bottomsheet.
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40.0),
                                      topRight: Radius.circular(40.0),
                                    ),
                                    // Optional. Styles the search field.
                                    inputDecoration: InputDecoration(
                                      labelText: 'Search',
                                      hintText: 'Start typing to search',
                                      prefixIcon: const Icon(Icons.search),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: const Text('Search'),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: pharmacyController,
                          decoration: InputDecoration(
                            labelText: "Pharmacy Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: vaccineController,
                          decoration: InputDecoration(
                            labelText: "Vaccine Name",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        child: TextFormField(
                          controller: dateController,
                          decoration: InputDecoration(
                            labelText: "Date",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Map <String,dynamic> data2 = {
                              "place": placeController.text.trim(),
                              "pharmacy": pharmacyController.text.trim(),
                              "vaccine": vaccineController.text.trim(),
                              "date": dateController.text.trim(),
                              "image": imageURL,
                            };
                            FirebaseFirestore.instance.collection("test2").add(data2);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            onPrimary: Colors.white,
                            textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 40,
                                fontStyle: FontStyle.italic),
                          ),
                          child: Text(
                            "Submit",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
