import 'package:dio/dio.dart';
import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> checkSession(String sessionToken) async {
      try {
        // Get session token from SharedPreferences
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String sessionToken = prefs.getString('session') ?? "";

        // Prepare data for the POST request
        final Map<String, dynamic> fdataMap = {'session_token': sessionToken};
        final FormData fdata = FormData.fromMap(fdataMap);

        // Make a POST request
        final Dio dio = Dio();
        final Response response = await dio.post(
          'https://me-dis.000webhostapp.com/session-api.php',
          data: fdata,
        );

        // Log response for debugging
        print("Check session response: $response");

        // Check if the session is successful
        if (response.statusCode == 200) {
          final Map<String, dynamic> data = json.decode(response.data);
          return data['status'] == 'success';
        }
      } catch (error) {
        // Handle error if needed
        print('Error during session check: $error');
      }

      return false; // Return false by default if there's an error
    }

    
}