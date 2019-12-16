void sendingserver() {
  if (keyCode==ENTER) {
    decalage = 0;
    if (input.length()>=130) {
      for (int i = 130; i < input.length()-1; i+=130) {
        input = input.substring(0, i) + input.substring(i+1);
      }
    }
    if (input != "" && input.charAt(0) != '/') {
      switch(input) {
        case ("$*1") :
        s.write(input);
        break;
        case ("$*2") :
        s.write(input);
        break;
        case ("$*3") :
        s.write(input);
        break;
      default :
        s.write((pseudoserveur + " : " + input));
        deroulement.remove(0);
        deroulement.append("You : "+input);
        break;
      }
    } else {
      commands(input);
    }
    input="";
    keyCode=0;
  }
}

void receivingserver() {
  if (c != null) {
    if (!nomclient) {
      pseudoclients.append(c.readString());
      pseudoclient = pseudoclients.get(pseudoclients.size()-1);
      deroulement.remove(0);
      deroulement.append(pseudoclient + " s'est connecté ");
      s.write(pseudoserveur + "$" + str(pseudoclients.size()-1) + "." + pseudoclient + " s'est connecté");
      nomclient=true;
    } else {
      recup = c.readString();
      //gestion des sons
      switch(recup) {
      default :
        //recup = decrypto(recup, cle); //déchiffrage du message
        message = recup.substring(1);
        idClient = int(recup.substring(0, 1));
        if (message.equals("quit")) {
          pseudoclient = pseudoclients.get(idClient);
          s.write(pseudoclient + " s'est déconnecté");
          deroulement.remove(0);
          deroulement.append(pseudoclient + " s'est déconnecté ");
          clients--;
          pseudoclients.remove(idClient);
          break;
        }
        textSize(15);
        fill(255);
        deroulement.remove(0);
        deroulement.append(pseudoclients.get(idClient) + " : " + message);
        s.write(/*crypto*/(pseudoclients.get(idClient) + " : " + message));
        break;
      }
    }
  }
}

void parametres() {
  if (!antiboucle) {
    antiboucle = true;
    parametres = loadStrings("data/parametres_serveur.txt");
    pseudoserveur = parametres[0];
    port = int(parametres[1]);
  }

  background(0);
  fill(255);
  textFont(param);
  textAlign(CENTER);
  rectMode(CENTER);
  text("Bienvenue, serveur", width/2, 50);
  textSize(13);
  text("Veuillez définir les paramètres du serveur :", width/2, 120);

  //identifiant
  text("nom du serveur :", width/2, 150);
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
    text(input, width/2, 190);
    if (keyCode==ENTER || (mousePressed && !(mouseX>390&&mouseX<690&&mouseY>170&&mouseY<200))) {
      pseudoserveur=input;
      text(pseudoserveur, width/2, 190);
      keyCode=0;
      input="";
      choix=0;
    }
  } else {
    text(pseudoserveur, width/2, 190);
  }
  noStroke();

  //choix du port
  text("Port à utiliser (à communiquer aux clients) :", width/2, 250);
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
    text(input, width/2, 290);
    if (keyCode==ENTER || (mousePressed && !(mouseX>390&&mouseX<690&&mouseY>270&&mouseY<300))) {
      port=int(input);
      text(port, width/2, 290);
      keyCode=0;
      input="";
      choix=0;
    }
  } else {
    text(port, width/2, 290);
  }
  noStroke();

  if (mouseX>390&&mouseX<690&&mouseY>170&&mouseY<200) {
    if (mousePressed) {
      choix=1;
      input = pseudoserveur;
    }
    over = 1;
  }
  if (mouseX>390&&mouseX<690&&mouseY>270&&mouseY<300) {
    if (mousePressed) {
      choix=2;
      input = str(port);
    }
    over = 2;
  }
  if (((mouseX<390||mouseX>690)||mouseY<170||(mouseY>200&&mouseY<270)||mouseY>300)) {
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
  text("Passer en mode \n \n client", 150, 45);
  noStroke();
  if (mousePressed&&mouseX>48&&mouseX<253&&mouseY>24&&mouseY<77&&anti_spam_profil) {
    profil = 1;
    antiboucle = false;
    anti_spam_profil = false;
  }

  //bouton connexion
  fill(0, 0, 255);
  rect(width/2, 530, 200, 60, 10);
  fill(255);
  text("Se connecter", width/2, 535);
  if (mousePressed&&mouseX>440&&mouseX<640&&mouseY>500&&mouseY<560) {
    chat=true;
    parametres[0] = pseudoserveur;
    parametres[1] = str(port);
    saveStrings("data/parametres_serveur.txt", parametres);
    antiboucle = false;
  }
}
