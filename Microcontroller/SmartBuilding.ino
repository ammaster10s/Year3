//  Author Pawaris Panyasombat 6522780376
//  Date: 26-4-2025

// Descriptions: My idea is to create a smart building system using the equipment that are in the box
// and the Arduino board. The equipment that I have used are
// 1. Pincode 
// 2. Buzzer
// 3. Ultrasonic sensor
// 4. Temperature/ Humidity sensor
// 5. LEDs



#include <Keypad.h>

const byte ROWS =4;
const byte COLS  =4;
char Layout[ROWS][COLS] = {
    {'1','2','3','A'},
    {'4','5','6','B'},
    {'7','8','9','C'},
    {'*','0','#','D'},
};

byte rowPins[ROWS] = {9,8,7,6};
byte colPins[COLS] = {5,4,3,2};

Keypad customKeypad = Keypad(makeKeymap(Layout),rowPins,colPins,ROWS,COLS);

//  Pin setup 

const int buzzerPin = 10;
const int ledArmed = 11;
const int ledAlarm = 12;
const int switchPin = A0;
const int tempSensorPin = A1;
const int moistureSensorPin = A2;
const int trigPin = A3;
const int echoPin = A4;


//  Config the system enable code 
String inputCode = "";
const String correctCode = "0095";
bool systemArmed = false;
bool alarmTriggered = false;
int wrongAttempts = 0; 

//  Ultrasonic sensor at the windows to check whether the intruder is moving at the windows or not.

long readUltrasonicDistance() {
  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  long duration = pulseIn(echoPin, HIGH);
  return duration * 0.034 / 2; // Convert to cm
}

void setup(){
    Serial.begin(9600);
    pinMode(buzzerPin, OUTPUT);
    pinMode(ledArmed, OUTPUT);
    pinMode(ledAlarm, OUTPUT);
    pinMode(switchPin, INPUT);
    pinMode(trigPin, OUTPUT);
    pinMode(echoPin, INPUT);

    digitalWrite(ledArmed, LOW);
    digitalWrite(ledAlarm, LOW);

}

void handleKeypad(char key) {
        if (key == '#') { // Confirm key
            if (inputCode == correctCode) {
                if (!systemArmed) {
                    armSystem();
                } else {
                    disarmSystem();
                }
                wrongAttempts = 0; 
            } else {
                wrongAttempts++;
                Serial.println("Wrong PIN!");
                if (wrongAttempts >= 3) {
                    triggerAlarm();
                }
            }
            inputCode = "";
        } else if (key == '*') { 
            inputCode = "";
        } else {
            inputCode += key;
            Serial.print("Entered: ");
            Serial.println(inputCode);
        }    
}

void loop(){

    if (digitalRead(switchPin) == LOW) {
    disarmSystem();
    Serial.println("System manually disarmed!");
}

    char key = customKeypad.getKey();
    if (key){
        handleKeypad(key);
    }
    if (systemArmed && !alarmTriggered) {
        monitorSensors();
        }
}
    

    

void armSystem() {
    systemArmed = true;
    digitalWrite(ledArmed, HIGH);
    Serial.println("System Armed");
}
void disarmSystem() {
    systemArmed = false;
    alarmTriggered = false;
    digitalWrite(ledArmed, LOW);
    digitalWrite(ledAlarm, LOW);
    noTone(buzzerPin);
    Serial.println("System Disarmed");
}

void monitorSensors(){
    int tempValue = analogRead(tempSensorPin);
    float voltage = tempValue * (5.0 / 1023.0);
    float temperature = (voltage - 0.5) * 100; 
    //  Temperature set to 60 incase of the fire.
    if (temperature > 60) { 
        Serial.println("High Temperature Detected!");
        Serial.print("Temperature: ");
        Serial.println(temperature);
        triggerAlarm();
    }

    long distance = readUltrasonicDistance();
    if (distance < 30 && distance > 0) { 
        Serial.println("Intruder Detected!");
        Serial.print("Distance: ");
        Serial.println(distance);
        triggerAlarm();
    }
}
void triggerAlarm() {
    alarmTriggered = true;
    digitalWrite(ledAlarm, HIGH);
    tone(buzzerPin, 1000); 
    Serial.println("Alarm Triggered!");
}