String input="";
char letter;
boolean write;

void keyReleased() {
  if (keyCode!=SHIFT&&keyCode!=BACKSPACE&&keyCode!=ENTER&&keyCode!=DELETE&&keyCode!=CONTROL&&keyCode!=20&&keyCode!=LEFT&&keyCode!=RIGHT&&keyCode!=UP&&keyCode!=DOWN) {
    letter=key;
    write=true;
  }
  if (keyCode==DELETE) {
    input="";
    decalage = 0;
  }
  if (keyCode==BACKSPACE&&input.length()>0) {
    input=input.substring(0, input.length()-1);
    if (input.length() % 121 == 0 && input.length()>0) {
      input=input.substring(0, input.length()-1);
      decalage--;
    }
  }
}

void input() {
  if (write) {
    if (input.length() % 120 == 0 && input.length()>0) {
      input+="\n";
      decalage++;
    }
    input+=letter;
    write=false;
  }
}
