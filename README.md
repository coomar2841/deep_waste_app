# Deep Waste Management App


## Summary

An app that use [waste classification machine learning model](https://colab.research.google.com/drive/1yWqc8TRS0I21RdfHLPRTQIs37ANOx-Uq) to classify the waste and manage it effectively. It a standalone app and works without internet.

## Background
Waste identification is a crucial step in the waste management process that enables facilities to properly handle, recycle, and reduce their waste, while also ensuring compliance with regulations and tracking their progress over time. The integration of machine learning models with mobile devices can enhance the precision, ease, and effectiveness of waste management endeavors, as well as furnish valuable information for monitoring and decreasing waste.

In this app,  we have prepared a substantial collection of waste images and trained a machine learning model. The trained model is then installed on a mobile device, enabling real-time waste identification. By simply capturing an image of the waste with their mobile device, users can receive an instant classification of the waste into categories such as paper, plastic, glass, metal, and more, via the machine learning model.

## Features 
Here are some of its features:
- Snap or upload a picture of a waste <br>
- Install the app on your Android or iPhone for easy access <br>
- Keep track of how many waste items you've recycled<br>
- Help to make our earth cleaner <br>

## Getting started
1. Install Flutter. See https://docs.flutter.dev/get-started/install
2. Clone this repository.
3. Move to `deep-waste-app` directory.
4. Run `flutter run` command.

## Structure
The main classes are under `lib` directory.

    Directory                        Description
    ─────────                        ────────────

    assets
    ├── model                        # waste classification model
    lib
    ├── ...
    ├── constants                    # constants used in project
    ├── models                       # data structure to define the shape of data
    ├── screens                      # different view used in the app
        ├── components               # reusable components
    ├── controller                   # an intermidiate between view and model responsible for updating model and manupluates the view of the app    
    ├── test                         # Test files (alternatively `spec` or `tests`)
    └── ...


## License
```
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
