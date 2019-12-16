int chelou, ordrecle, ordrecara, ordrecrypt;
char crypt, decrypt;
String cryptage, decryptage;

int ordre(char lettre) {          
  chelou = int(lettre);           //renvoie l'ordre alphabétique de la lettre en entrée
  return(chelou-97);              
}


char resti(int chiffre) {         
  chelou = chiffre+97;            //renvoie la lettre de l'alphabet à l'ordre en entrée
  return(char(chelou));           
}

char crypte(char cara, char cle) {//renvoie le caractère crypté en fonction de la clé choisie
  ordrecle = ordre(cle);          //on récupère l'ordre de la clé
  ordrecara = ordre(cara);        //on récupère l'ordre du caractère à chiffrer
  switch(ordrecara){              //si le caractère ne fait pas partie de la liste ...
    case(-65):
      crypt=' ';
      break;
    case(-34):
      crypt='?';
    break;
    case(-64):
      crypt='!';
    break;
    case(-53):
      crypt=',';
    break;
    case(135):
      crypt='è';
    break;
    case(136):
      crypt='é';
    break;
    case(137) :
      crypt='ê';
    break;
    case(127) :
      crypt='à';
    break;
    case(-58) :
      crypt='\'';
    break;
    case(-57) :
      crypt='(';
    break;
    case(-56) :
      crypt=')';
    break;
    case(-63) :
      crypt='"';
    break;
    case(-52) :
      crypt='-';
    break;
    case(-51):
      crypt='.';
    break;
    default :
      crypt=resti((ordrecara+ordrecle)%26);//... on le chiffre
    break;
  }
  return (crypt);
}

char decrypte(char crypt, char cle) {//pareil mais dans l'autre sens
  ordrecle = ordre(cle);
  ordrecrypt = ordre(crypt);
  switch(ordrecrypt){
    case(-65) :
      decrypt=' ';
    break;
    case(-34):
      decrypt='?';
    break;
    case(-64):
      decrypt='!';
    break;
    case(-53):
      decrypt=',';
    break;
    case(135):
      decrypt='è';
    break;
    case(136):
      decrypt='é';
    break;
    case(137) :
      decrypt='ê';
    break;
    case(127) :
      decrypt='à';
    break;
    case(-58) :
      decrypt='\'';
    break;
    case(-57) :
      decrypt='(';
    break;
    case(-56) :
      decrypt=')';
    break;
    case(-63) :
      decrypt='"';
    break;
    case(-52) :
      decrypt='-';
    break;
    case(-51):
      decrypt='.';
    break;
    default :
      if (ordrecrypt-ordrecle<0){
        decrypt=resti(26+((ordrecrypt-ordrecle)%26));
      }
      else {
        decrypt=resti((ordrecrypt-ordrecle)%26);
      }
      break;
  }
  return(decrypt);
}

String crypto(String texte, char cle) {//renvoie un texte entier chiffré grâce aux fonctions précédentes
  cryptage = "";
  for (int i=0; i<texte.length(); i++) {
    cryptage+=crypte(texte.charAt(i), cle);
  }
  return (cryptage);
}

String decrypto(String texte, char cle) {//renvoie un texte entier déchiffré grâce aux fonctions précédentes
  decryptage="";
  for (int i=0; i<texte.length(); i++) {
    decryptage+=decrypte(texte.charAt(i), cle);
  }
  return (decryptage);
}
