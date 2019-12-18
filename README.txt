# Discat
A LAN chatting app

This app allows you to chat with other people in a LAN

L'appli possède 2 modes : hôte (pour l'instant nommé serveur) et client
L'écran d'accueil permet de choisir le mode de connexion. Pour l'hôte, il faut renseigner un pseudo et le port à utiliser (1111 par défaut et il n'est pas nécessaire de le modifier, pensez à le communiquer à vos clients si vous le modifiez). Pour le client, il faut en plus l'adresse IP de l'hôte à qui vous voulez vous connecter (elle est affichée sur l'interface de l'hôte).

-L'hôte est celui qui gère la conversation, il a accès à certaines commandes :
      -/connected : liste les personnes connectées à la conversation
      -/kick <pseudo> : déconnecte quelqu'un de force de la conversation (réaction inconnue si <pseudo> = le pseudo du serveur
      -/sendip : renvoie l'adresse IP du serveur aux clients
      -/clear : qui efface toute la conversation à l'écran (seulement côté serveur)
      -/reload : remet tout à 0 : la conversation est effacée pour tout le monde, les clients sont déconnectés et se reconnectent automatiquement
      -/quit : ferme la conversation, mais pas l'application, retour sur l'écran de choix du mode
      -/exit : ferme la conversation et l'application
      -/help : liste les commandes disponibles
-Le client a aussi accès aux commandes /quit, /exit et /clear.

Pour le report de bugs, vous pouvez le faire sur discord (そかわいい ^^#8186) ou par mail à ahornec@univ-pau.fr. Sur ce, je vous souhaite d'excellentes discussions pendant les cours de Chakib sur le Discat ;) !
