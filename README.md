# Positioning-assistent-for-vehicle
Dieses Modell besteht aus dem Simulink-Modell (Fahrzeugmodell)
und die function-Komponenten in m.file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n
List der m.file:
Fahrdynamik.m *
TestenBezier.m 
Bezier.m *
Bezier1.m
Bezier4Funktion.m
Beziercontrollpoint.m
UngleichKappa1.m
Bezier4Poly.m

Koor_Trans.m *
Koor_Trans1.m *
ZweiDFahranimation.m *
sfun.m *

die Bildern der Deckblättern der Subsysteme:
Deckblatt.png
Nissan Leaf.jpg
Volvo-testet-die-magnetische-Positionsbestimmung.jpg

Datei mit (*): müssen vorhanden sein, sie sind die notwendigen Bestandteile der Simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Bemerkung zu m.files:
TestenBezier.m:
ist ein Skript in statischen Fall zum Lauf der Bahnplanung bedient.
Es ist identischen umschreibbar um verschieden Arten der Bahnplanungsmethode zu 
implementieren. Beim Laufen des Modells kann man in Fahrzeugmodell.slx/Bahnplanung/Subsystem/Bezier4
den Aufruf der richtigen function der Variante ändern. Die richtige Einsetzung der 
Implementierung erfolgt wie in die TestenBezier.m darstellt.
Zum Laufen der TestenBezier.m ist mit Bezier4Funktion.m (oder controllpoint.m) und UngleichKappa.m 
(oder UngleichKappa1.m). Die Ausgabe von TestenBezier.m ist grafischen in Bezier4Poly.m umsetzbar.

Bezier.m und Bezier1.m:
die enthalten die Vorgehensweise zur Bahnplanung in verschiedenen Varianten. sie sind in dem Simulink-
Modell aufzurufen. sie können identisch aus TestenBezier.m übernommen werden.


%%%%% Simulationsprozedure %%%%%%%%%%%%%%%%%
Starten mit Fahrdynamik.m (Eingabe der Parameter)
Dann mit der Fahrzeugmodell.slx die Simulation anfangen.
