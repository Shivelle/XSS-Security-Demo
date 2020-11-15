# Code-Injection & XSS

## Definition
Im Allgemeinen versteht man unter Code Injection das Einschleusen von Scripts in den als vertrauenswürdig eingestuften Kontext einer Webanwendung. Im Bereich der Web Security gehören zu den Möglichkeiten von Code Injections unter anderem SQL Injection, CSS Injection, Textile Injection, Ajax Injection, Command Line Injection, Header Injection und Cross-Site-Scripting(XSS).

XSS ist dabei eine Art der Injection, die in dynamischen Bereichen von Webseiten zum Einsatz kommt. Also dort, wo Nutzer selbst Eintragungen vornehmen können.

Die Injection erfolgt im Allgemeinen in Form eines browserseitigen Skripts, das von der Website angenommen und ausgeführt wird.

OWASP(Open Web Application Security Project) gibt jedes Jahr eine Top-Ten-Liste mit den kritischsten Sicherheitsrisiken für Webanwendungen heraus. Incections belegen dabei den ersten und XSS immer noch den siebten Platz in 2020.

## Andwendung
Ein Angreifer kann XSS verwenden, um an sensible Daten Daten eines Nutzers zu gelangen und beispielsweise Benutzerkonten zu übernehmen (Session Hijacking), Phishing-Angriffe, Defacements/Verunstaltungen, wie auch für das Einstellen negativer Inhalte.

## XSS-Kategorien
Man unterscheidet verschiedene Kategorien von XSS-Angriffen. Dazu gehören: Reflektierendes XSS, persistentes XSS und lokales XSS.

Wir wollen diese Kategorien kurz erklären und mit kleinen Beispielen näher auf sie eingehen.

#### Reflektiertes XSS
Reflektiertes XSS tritt auf, wenn Benutzereingaben sofort von einer Webanwendung in einer Fehlermeldung, einem Suchergebnis oder einer anderen Antwort zurückgegeben werden, die einige oder alle vom Benutzer als Teil der Anfrage bereitgestellten Eingaben enthält, ohne dass die vom Benutzer bereitgestellten Daten dauerhaft gespeichert werden.

- Die Reflexion eines Suchbegriffs über der Ergebnisliste:
   "Sie suchten nach **Schaf**.”
- Das Auslösen einer Fehlermeldung bei der Registrierung:
   “Der Nutzername **Jolly** ist bereits vergeben.”

#### Persistentes XSS
Persistentes XSS tritt in der Regel auf, wenn Benutzereingaben auf dem Zielserver gespeichert werden, z.B. in einer Datenbank, in einem Nachrichtenforum, einem Besucherprotokoll, einem Kommentarfeld usw.
- Ein `@comment.content` wird mit `.html_safe` wieder ausgegeben. Ein Beispiel für eine Solche Lücke haben wir kürzlich in den Marketing-Seiten gefunden. Im Frontend wurde sanitized, im Backend `.html_safe` gesetzt. Das erlaubte das Einschleusen von Scripts in den Adminbereich.
[Blog42 - XSS-Issue](https://git.42he.com/42he/gems-for-marketing-pages/blog42/-/issues/4)

#### DOM-basiertes oder lokales XSS
DOM-basiertes XSS ist eine Form von XSS, bei der der gesamte schadhafte Datenfluss im Browser stattfindet, d.h. die Quelle der Daten befindet sich im DOM, der Ausführungsort ebenfalls im DOM, und der Datenfluss verlässt nie den Browser. Da hier die Webapplikation auf dem Server überhaupt nicht beteiligt ist, sind auch statische HTML-Seiten anfällig für diese Angriffsart.
- Direkt in der URL:
`bsp.com/foo.html?arg=<script>alert(‘XSS’)</script></p>`

## Angriffsvektoren
Dass Injektionen nicht nur in Script-Tags erfolgen können und es daher nicht ausreichend ist, Script-Tags zu blacklisten, zeigen folgende Beispiele einiger Angriffsvektoren:

- ``` html
  <b onmouseover=alert(‘XSS’)></b>
  ```
- ``` html
  <IMG SRC=x onload="alert(String.fromCharCode(88,83,83))">
  ```
- Wird ausgelöst, wenn sich der Subtitel ändert:
  ``` html
  <video controls>
    <source src=validvideo.mp4 type=video/mp4>
    <track default oncuechange=alert(1) src="data:text/vtt,WEBVTT FILE 1 00:00:00.000 --> 00:00:05.000 <b>XSS</b> ">
  </video>
  ```
- `%3cscript%3ealert('XSS')%3c/script%3e`

[1483 Vektoren](https://gist.github.com/kurobeats/9a613c9ab68914312cbb415134795b45)
[XSS-Security-Demo](https://github.com/Shivelle/XSS-Security-Demo)

## Verbreitung
XSS ist auch unter 'Big Playern' ein Thema. Nennenswerte Beispiele:

[XSS in Twitch Chat](https://www.youtube.com/watch?v=2GtbY1XWGlQ)
[XSS in Google Suche](https://www.youtube.com/watch?v=gVrdE6g_fa8)


## Escaping, Strings & SafeBuffer
#### Escaping
HTML-Escaping bedeutet einfach, Sonderzeichen durch Entities zu ersetzen, sodass HTML versteht, diese Zeichen zu als diese Zeichen auszugeben, anstatt sie nach ihren speziellen Bedeutungen auszuführen. Beispielsweise wird `<` mit `&lt;`, `>` mit `&gt;` und `&` mit `&amp;` maskiert.

#### SafeBuffer

#### Html_safe
Die Anwendung von `html_safe` auf einen `String` gibt ein Objekt zurück, das aussieht und sich verhält wie ein `String`, aber eigentlich ein `SafeBuffer` ist.

``` ruby
"foo".class
# => String
```
``` ruby
"foo".html_safe.class
# => ActiveSupport::SafeBuffer
```
Wenn man einen `String` einem `SafeBuffer` anfügt, dann wird der `String` vorher HTML-escaped.
``` ruby
"<foo>".html_safe + "<bar>"
# => "<foo>&lt;bar&gt;"
```
Wenn man einen `SafeBuffer` einem weiteren `SafeBuffer` anfügt, findet kein  Escaping statt:
```ruby
"<foo>".html_safe + "<bar>".html_safe
# => "<foo><bar>"
```

