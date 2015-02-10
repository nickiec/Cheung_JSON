import processing.serial.*;

import oscP5.*;
import netP5.*;

import org.firmata.*;
import cc.arduino.*;

//create json object, which will store the json file
JSONObject json;
String myURL = "https://www.kimonolabs.com/api/2pxs1g32?apikey=uqK4VItMU6SmZtCoVfbDUrRMnEYnjLBa";

int bigPin = 6;
int lilPin = 5;


float depFlt = 0;
Arduino arduino;


void setup() {
  json = loadJSONObject(myURL);
  size( 500, 500 );

  arduino = new Arduino( this, "COM3", 57600 );
}

void draw() {
  loadData();
}



void loadData() {
  JSONObject results = json.getJSONObject("results");
  JSONArray collection1 = results.getJSONArray("collection1");

  int value = 0;
  int sizeOfCollection = collection1.size();
  for ( int i = 0; i<sizeOfCollection; i++)
  {
    JSONObject quake = collection1.getJSONObject(i);
    float mag = quake.getFloat("mag");
    JSONObject location = quake.getJSONObject("location");
    String loc = location.getString("text");
    String dep = quake.getString("depth");
    int spacing = width/sizeOfCollection;
    int x = i * spacing;
    println(mag);

    String depVal = dep.substring(0, 3);



    //using the data retrieved
    if (dep.length() == 11 ) {
      depVal = dep.substring( 0, 3 );
      depFlt = float(depVal);
    } else if (dep.length() == 12 ) {
      depVal = dep.substring( 0, 4 );
      depFlt = float(depVal);
    } else if (dep.length() == 13 ) {
      depVal = dep.substring( 0, 5 );
      depFlt = float(depVal);
    }
    
    if( depFlt >= 50 );
    
    arduino.analogWrite( i, int(mag) );
    line( x, mag, x, height );
  }
}

//a few things to re}member --> it's not your computer retrieving data, it is the server that will retrieve data

