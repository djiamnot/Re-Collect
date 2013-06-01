int incomingByte = 0; // for incoming serial data
int led = 13;

void setup() {
  Serial.begin(9600);
  pinMode(led, OUTPUT);
}

void loop() {

  // send data only when you receive data:
  if (Serial.available() > 0) {
    // read the incoming byte:
    incomingByte = Serial.read();
    // LED intensity
    analogWrite(led, incomingByte);
    // echo back to serial (and print in PD)
    Serial.write(incomingByte);
  }
}

