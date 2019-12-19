void sendingclient() {
  if (keyCode==ENTER) {
    decalage = 0;
    if (input.length()>=130) {
      for (int i = 130; i < input.length()-1; i+=130) {
        input = input.substring(0, i) + input.substring(i+1);
      }
    }
    switch(input) {
      case("/quit"):
      deroulement.clear();
      for (int x = 0; x < 11; x+=1) {
        deroulement.append("");
      }
      c.write(idClient+"quit");
      chat = false;
      nomclient = false;
      nomserveur = false;
      c.stop();
      break;
      case ("/exit"):
      c.write(idClient+"quit");
      c.stop();
      exit();
      break;
      case ("/clear") :
      deroulement.clear();
      for (int x = 0; x < 11; x+=1) {
        deroulement.append("");
      }
      break;
      case ("$*1") :
      c.write(input);
      break;
      case ("$*2") :
      c.write(input);
      break;
      case ("$*3") :
      c.write(input);
      break;
    default :
      c.write(/*crypto*/(idClient+input));
      break;
    }
    input="";
    //fill(100);
    keyCode=0;
  }
}

void receivingclient() {
  if (c.available() > 0) {
    if (!nomserveur) {
      startClient(c.readString());
    } else {
      recup = c.readString();
      switch(recup) {
        case("quit") :
        deroulement.clear();
        for (int x = 0; x < 11; x+=1) {
          deroulement.append("");
        }
        chat = false;
        nomclient = false;
        nomserveur = false;
        break;
        case ("/reload") :
        deroulement.clear();
        for (int x = 0; x < 17; x+=1) {
          deroulement.append("");
        }
        nomserveur = false;
        antiboucle = false;
        c = null;
        break;
      default :
        //recup = decrypto(recup, cle)
        if (recup.substring(0, pseudoserveur.length()+1).equals(pseudoserveur + "$")) { //new client
          recup = recup.substring(pseudoserveur.length()+3, recup.length());
        }
        if (recup.substring(0, pseudoclient.length()).equals(pseudoclient)) { //cas du client emetteur
          recup = "You" + recup.substring(pseudoclient.length());
        }
        if (recup.length() >= 6 + pseudoclient.length() && recup.charAt(0) == '/') {
          if (recup.substring(0, 9+pseudoclient.length()).equals("/kill " + pseudoclient + " a ")) { //cas du /kill
            deroulement.clear();
            for (int x = 0; x < 11; x+=1) {
              deroulement.append("");
            }
            chat = false;
            nomclient = false;
            nomserveur = false;
            recup = "";
          } else if (recup.substring(0, 6).equals("/kill ")) {
            recup = recup.substring(6);
          }
        }
        deroulement.remove(0);
        deroulement.append(recup);
        break;
      }
    }
  }
}

void identification() {
  if (!antiboucle) {
    antiboucle = true;
    parametres = loadStrings("data/parametres_client.txt");
    pseudoclient = parametres[0];
    ip = parametres[1];
    port = int(parametres[2]);
  }

  //détails graphiques
  background(0);
  fill(255);
  textFont(param);
  textAlign(CENTER);
  rectMode(CENTER);
  text("Bienvenue, client", width/2, 50);
  textSize(13);
  text("Veuillez vous identifier :", width/2, 120);

  //pseudoclient
  text("Pseudo :", width/2, 150);
  if (choix==1) {
    stroke(250, 50, 50);
  }
  if (over == 1) {
    fill(150);
  } else {
    fill(100);
  }
  rect(width/2, 185, 300, 30, 10);
  fill(255);
  if (choix==1) {
    input();
    text(input+'|', width/2, 190);
    if (keyCode==ENTER || (mousePressed && !(mouseX>390&&mouseX<690&&mouseY>170&&mouseY<200))) {
      pseudoclient=input;
      text(pseudoclient, width/2, 190);
      keyCode=0;
      input="";
      choix=0;
    }
  } else {
    text(pseudoclient, width/2, 190);
  }
  noStroke();

  //ip du destinataire
  text("IP du host cible :", width/2, 250);
  if (choix==2) {
    stroke(250, 50, 50);
  }
  if (over == 2) {
    fill(150);
  } else {
    fill(100);
  }
  rect(width/2, 285, 300, 30, 10);
  fill(255);
  if (choix==2) {
    input();
    text(input+'|', width/2, 290);
    if (keyCode==ENTER || (mousePressed && !(mouseX>390&&mouseX<690&&mouseY>270&&mouseY<300))) {
      ip=input;
      text(ip, width/2, 290);
      keyCode=0;
      input="";
      choix=0;
    }
  } else {
    text(ip, width/2, 290);
  }
  noStroke();

  //port cible
  text("port du host cible :", width/2, 350);
  if (choix==3) {
    stroke(250, 50, 50);
  }
  if (over == 3) {
    fill(150);
  } else {
    fill(100);
  }
  rect(width/2, 385, 300, 30, 10);
  fill(255);
  if (choix==3) {
    input();
    text(input+'|', width/2, 390);
    if (keyCode==ENTER || (mousePressed && !(mouseX>390&&mouseX<690&&mouseY>370&&mouseY<400))) {
      port=int(input);
      text(port, width/2, 390);
      keyCode=0;
      input="";
      choix=0;
    }
  } else {
    text(port, width/2, 390);
  }

  if (noHost) {
    fill(255, 0, 0);
    text("Aucun host n'a été trouvé à cette adresse, veuillez réessayer ...", width/2, 450);
  }

  if (mouseX>390&&mouseX<690&&mouseY>170&&mouseY<200) {
    if (mousePressed) {
      choix=1;
      input = pseudoclient;
    }
    over = 1;
  }
  if (mouseX>390&&mouseX<690&&mouseY>270&&mouseY<300) {
    if (mousePressed) {
      choix=2;
      input = ip;
    }
    over = 2;
  }
  if (mouseX>390&&mouseX<690&&mouseY>370&&mouseY<400) {
    if (mousePressed) {
      choix=3;
      input = str(port);
    }
    over = 3;
  }
  if (((mouseX<390||mouseX>690)||mouseY<170||(mouseY>200&&mouseY<270)||(mouseY>300&&mouseY<370)||mouseY>400)) {
    if (mousePressed) {
      choix=0;
      input="";
    }
    over = 0;
  }

  //bouton de changement de profil
  stroke(255);
  strokeWeight(3);
  fill(50, 200, 50);
  rect(150, 50, 200, 50, 25);
  fill(255);
  text("Passer en mode \n \n host", 150, 45);
  noStroke();
  if (mousePressed&&mouseX>48&&mouseX<253&&mouseY>24&&mouseY<77&&anti_spam_profil) {
    profil = 0;
    anti_spam_profil = false;
  }

  //bouton connexion
  fill(0, 0, 255);
  rect(width/2, 530, 200, 60, 10);
  fill(255);
  text("Se connecter", width/2, 535);

  if (mousePressed&&mouseX>440&&mouseX<640&&mouseY>500&&mouseY<560) {
    c = new Client(this, ip, port);
    if (c.active()) {
      antiboucle = false;
      chat=true;
      parametres[0] = pseudoclient;
      parametres[1] = ip;
      parametres[2] = str(port);
      saveStrings("data/parametres_client.txt", parametres);
      c.write(pseudoclient);
      noHost = false;
    } else {
      c.stop();
      noHost = true;
    }
  }
}
