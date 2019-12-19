import processing.net.*; //<>//

PImage tuturu, nico, fuck, icon;
PFont text, param;
Server s;
Client c;
String recup, pseudoclient, pseudoserveur, ip, message;
int decalage, clients, port, choix, profil, over, idClient, clientState;
boolean chat, antiboucle, nomclient, nomserveur, anti_spam_son, anti_spam_profil, noHost;
char cle;
StringList deroulement, pseudoclients;
String[] parametres;

void setup() {
  size(1080, 620);
  smooth();
  //surface.setResizable(true);
  background(0);
  text=loadFont("ComicSansMS-15.vlw");
  param=loadFont("Gunship.vlw");
  pseudoclient="client";
  pseudoserveur="server";
  profil=0;
  over = 0;
  parametres = new String[3];
  clientState = 0;
  decalage = 0;

  //initialisation des images
  tuturu = loadImage("tuturu.jpg");
  nico = loadImage("nico.jpg");
  fuck = loadImage("fuck you.jpg");
  icon = loadImage("icone appli.png");
  surface.setIcon(icon);

  //clé de chiffrage
  cle='s';

  //génération de la liste des messages
  deroulement = new StringList();
  for (int x = 0; x < 11; x++) {
    deroulement.append("");
  }

  pseudoclients = new StringList();
}

void draw() {
  //println(mouseX, mouseY);
  background(0);
  if (!chat) {
    if (profil==0) {
      parametres();
    } else {
      identification();
    }
  } else {
    if (!antiboucle) {
      background(0);
      noStroke();
      antiboucle=true;
    }

    textFont(text);

    //partie décorative
    fill(0);
    rect(width/2, 35, width, 70);
    textSize(20);
    fill(255);
    textAlign(CENTER);
    if (profil==0) {
      text("Hello "+pseudoserveur+" !!!", width/2, 50);
      textSize(15);
      text(clients+" connecté au serveur "+s.ip(), width/2, 70);
    } else {
      text("Hello "+pseudoclient+" !!!", width/2, 50);
      textSize(15);
      text("Vous êtes connecté avec "+pseudoserveur, width/2, 70);
    }

    if (profil==0) {
      sendinghost();
      receivinghost();
    } else {
      sendingclient();
      receivingclient();
    }
    afficheText();

    //repères graphiques pour les sons
    /*image(fuck, width-80, height-240, 65, 65);
    image(tuturu, width-80, height-160, 65, 65); //régler le x en height-80 et recalculer la hauteyr 
    image(nico, width-80, height-80, 65, 65);*/

    input();  //fonction d'entrée texte   

    fill(100);
    rectMode(CORNER); 
    rect(45, height-50-19*decalage, 940, 30+decalage*19, 10);
    textAlign(LEFT, BASELINE);
    fill(255);
    text(input+'|', 60, height-30-19*decalage);

    if (mousePressed&&anti_spam_son) {
      son();
      anti_spam_son=false;
    }
  }
}

void serverEvent(Server s, Client c) {
  clients++;
  clientState = 1;
  nomclient = false;
}

void son() {
  if (profil == 0) {
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-240&&mouseY<height+175) {
      s.write("$*1");
    }
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-160&&mouseY<height+95) {
      s.write("$*2");
    }
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-80&&mouseY<height+15) {
      s.write("$*3");
    }
  } else {
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-240&&mouseY<height+175) {
      c.write("$*1");
    }
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-160&&mouseY<height+95) {
      c.write("$*2");
    }
    if (mousePressed&&mouseX>width-80&&mouseX<width-15&&mouseY>height-80&&mouseY<height+15) {
      c.write("$*3");
    }
  }
}

void afficheText() {
  String lastConv = "";
  //50, 65, 990, 550
  for (int x = 0; x<11; x++) {
    lastConv += deroulement.get(x) + "\n\n";
  }
  textSize(15);
  fill(255);
  textAlign(LEFT, BOTTOM);
  text(lastConv, 50, 80, 910, 460);
}

void mouseReleased() {
  anti_spam_son=true;
  anti_spam_profil=true;
}

String incrementIP(String ip) {
  int i = ip.length()-1;
  int ordrePoint;
  String debutIP;
  int finIP;

  while (true)
  { 
    if (ip.charAt(i)=='.') {
      ordrePoint = i;
      break;
    }
    i--;
  }

  debutIP = ip.substring(0, ordrePoint+1);
  finIP = int(ip.substring(ordrePoint+1))+1;

  ip = debutIP+finIP;
  return ip;
}

void startClient(String reception) {
  int i = reception.length()-1;
  int ordreDollar = 0;

  while (true)
  {
    if (reception.charAt(i)=='$') {
      ordreDollar = i;
      break;
    }
    i--;
  }

  pseudoserveur = reception.substring(0, ordreDollar);
  idClient = int(reception.substring(ordreDollar+1));
  nomserveur = true;
}

void exit() {
  if (chat) {
    if (profil == 0) {
      s.write("quit");
    } else {
      c.write(idClient+"quit");
    }
  }
  System.exit(0);
}

/*
générer une string avec le contenu de deroulement*/
