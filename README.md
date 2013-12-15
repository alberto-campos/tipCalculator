tipCalculator
=============

TipCalculatoriOS

A simple tip calculator that accepts the bill amount as an input.

By default the app will return the recommended tip amount for an individual for "Good" service.

The app allows modifying the number of guests and the tip percentage based on the quality of the service expected.

For visual purposes, the first time that the user loads the app we set a red background and start the initial values from factory defaults.

TO DO list:
- Vadalite numeric values
- Fix bug when slider is close to zero but the button to reduce the amount does not become disabled until the slider moves all the way out
- Add a utils.h file
- Use of global variables (singletons)
- Clear and release variables when terminating abruptly
- Add a "round tip or round total" check mark
- Save the calculator values into plists for future reference
