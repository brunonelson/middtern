
const int buttonPin = 2;
const int potPin = A0;
const int ledPin = 13;

int buttonState = 0;
int potState = 0;

void setup() {
// initialize the LED pin as an output:
pinMode(ledPin, OUTPUT);
// initialize the pushbutton pin as an input:
//pinMode(buttonPin, INPUT);
pinMode(potPin, INPUT);
pinMode(buttonPin, INPUT);
Serial.begin(9600);
}

void loop() {
// read the state of the pushbutton value:
potState = analogRead(potPin);
// check if the pushbutton is pressed.
buttonState = digitalRead(buttonPin); //momentary button

//detect state change
//if (digitalRead(buttonPin) != buttonState && buttonState == 0){
//  buttonState = 1;
//}
//if (digitalRead(buttonPin) != buttonState && buttonState == 1){
//  buttonState = 0;
//}

Serial.print(potState);
Serial.print("&");
Serial.println(buttonState);
}
