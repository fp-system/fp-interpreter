(draw eff io)� (2;121;4;) spirale (rad�'_30) turnto pendown�(240;_270;) moveto penup�'turtle new

coreimport == "library\turtlegraphics.txt";

spirale == ((#seite<'500)->
	(((#seite+#zunahme),#winkel,#zunahme,) spirale (rad�neg�#winkel) turn #seite move #t)|#t)
	�(id<-t;seite;winkel;zunahme;)�([1],[0])�ee

	
// (cc-by-sa-3.0) 2020 Fpstefan