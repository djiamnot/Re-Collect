// Yep, this is actually -*- c++ -*-

#define PIR_START_PIN 2
#define NUM_PIR_SENSORS 6

bool buffer[NUM_PIR_SENSORS];

void setval(uint8_t idx, bool val)
{
  buffer[idx] = val;
  Serial.print(idx);
  Serial.print(" ");
  Serial.println(val);
}

void setup()
{
  Serial.begin(57600);

  for (uint8_t i=0; i<NUM_PIR_SENSORS; i++) {
    pinMode(PIR_START_PIN + i, INPUT);
    digitalWrite(PIR_START_PIN + i, 1); // Enable internal pull-up
    setval(i, false);
  }
}

void loop()
{
  for (uint8_t i=0; i<NUM_PIR_SENSORS; i++) {
    bool val = !digitalRead(PIR_START_PIN + i);
    if (buffer[i] != val) setval(i, val);
  }
}
