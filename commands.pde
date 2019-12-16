void commands(String input) {
  //connected
  if (input.equals("/connected")) {
    deroulement.remove(0);
    deroulement.append("=== Liste des connectés ===");
    if (pseudoclients.size() == 0) {
      deroulement.remove(0);
      deroulement.append("    Personne n'est connecté :/");
    } else {
      for (int i = 0; i<pseudoclients.size(); i++) {
        deroulement.remove(0);
        deroulement.append("    " + pseudoclients.get(i));
      }
    }
  }

  //disconnect
  if (input.length() >= 6  && input.substring(0, 6).equals("/kick ")) {
    pseudoclient = input.substring(6);
    s.write("/kill " + pseudoclient + " a été déconnecté de la conversation");
    deroulement.remove(0);
    deroulement.append(pseudoclient + " a été déconnecté de la conversation");
    clients--;
    idClient = 0;
    while (!pseudoclients.get(idClient).equals(pseudoclient)) {
      idClient++;
    }
    pseudoclients.remove(idClient);
  }

  //sendip
  if (input.equals("/sendip")) {
    s.write((pseudoserveur + " : mon adresse IP : " + s.ip()));
  }

  //reload
  if (input.equals("/reload")) {
    clients = 0;
    deroulement.clear();
    for (int x = 0; x < 11; x+=1) {
      deroulement.append("");
    }
    s.write("/reload");
    idClient = 0;
    pseudoclients.clear();
  }

  if (input.equals("/quit")) {
    s.write("quit");
    chat = false;
    deroulement.clear();
    for (int x = 0; x < 11; x++) {
      deroulement.append("");
    }
    s.stop();
    clients = 0;
    idClient = 0;
    pseudoclients.clear();
  }

  if (input.equals("/exit")) {
    s.write("quit");
    s.stop();
    exit();
  }
  //clear
  if (input.equals("/clear")) {
    for (int x = 0; x < 11; x++) {
      deroulement.append("");
    }
  }

  if (input.contentEquals("/help")) {
    deroulement.remove(0);
    deroulement.append("=====Liste des commandes =====");
    deroulement.remove(0);
    deroulement.append("    /connected");
    deroulement.remove(0);
    deroulement.append("    /kick");
    deroulement.remove(0);
    deroulement.append("    /sendip");
    deroulement.remove(0);
    deroulement.append("    /reload");
    deroulement.remove(0);
    deroulement.append("    /quit");
    deroulement.remove(0);
    deroulement.append("    /exit");
    deroulement.remove(0);
    deroulement.append("    /clear");
  }
}
/*
commandes à ajouter :
 -/connected
 -/disconnect [pseudoclient]
 /disconnect :
 serveur : envoie "kill [idClient]"
 clients : reçoivent "kill[idClient]" et l'ignorent si idClient != le leur
 client concerné : se fait rekt XD
 -/sendip
 -/reload
 -/quit et /exit
 */
