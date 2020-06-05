'
'# LCD-Signalanzeige #
'
$Regfile="m16def.dat"
$Crystal=8000000
$hwstack=40
$swstack=16
$framesize=32

dim a as byte
dim b as byte
dim c as byte
dim d as byte
dim e as bit
dim f as bit
dim i as integer
dim j as integer
dim x as word
dim y as word

config portd=input
config portb.0=output
config portb.1=output
config portb.2=output
config portb.3=output
config portb.4=output
config portb.5=output
config portb.6=output
config portc.6=input
config portc.7=input

portc.7=1

res alias portb.0
latch alias portb.1
kanal11 alias portb.2
kanal12 alias portb.3
kanal21 alias portb.4
kanal22 alias portb.5
stp alias portb.6
over alias pinc.6
tast alias pinc.7

config lcd =16X2
config lcdpin=pin,rs=porta.0,e=porta.1,db4=porta.2,db5=porta.3,db6=porta.4,db7=porta.5
cursor off
cls

locate 1,1
lcd " # 2 Channel #"
locate 2,1
lcd " # LCD Scope #"

Deflcdchar 1,32,31,32,32,32,32,32,32' replace [x] with number (0-7)  H-Pegel
Deflcdchar 0,32,32,32,32,32,32,32,31' replace [x] with number (0-7)  L-Pegel

'-> Ports initialisieren
res=0
latch=0
kanal11=1
kanal12=1
kanal21=1
kanal22=1
stp=0

'-> Hauptprogramm Start
do

bitwait tast,reset '-> Taster startet Messung
cls
res=1
latch=0
stp=1
bitwait over,reset '-> 16 Werte = Überlauf
stp=0
waitms 200
cls
'-> Werte einlesen
latch=1
kanal11=0
a=pind
waitms 50
kanal11=1
kanal12=0
b=pind
waitms 50
kanal12=1
kanal21=0
c=pind
waitms 50
kanal21=1
kanal22=0
d=pind
waitms 50
kanal22=1
res=0
'-> Werte ausgeben Kanal 1
x=makeint(a,b)
for i=0 to 15
e=x.i
locate 1,i+1
if e=0 then
lcd chr(0)
else
lcd chr(1)
end if
next i
'-> Werte ausgeben Kanal 2
y=makeint(c,d)
for j=0 to 15
f=y.j
locate 2,j+1
if f=0 then
lcd chr(0)
else
lcd chr(1)
end if
next j

loop

end