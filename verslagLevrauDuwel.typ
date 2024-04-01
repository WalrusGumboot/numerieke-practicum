#set text(lang: "nl")

#show math.equation: it => box(it)
#set par(justify: true)
#set page(margin: 15mm)

#align(
  center,
  rect(
    width: 100%,
    inset: (y: 2em),
    fill: blue.lighten(85%),
    stroke: black,
    radius: 6pt,
    stack(
      spacing: 8pt,
      text("Verslag bij practicum Numerieke Wiskunde", 20pt, weight: "bold"),
      text(datetime.today().display(), 14pt),
      text("Mara Levrau, Simeon Duwel", 14pt),
    )
  )
)

= Opdracht 1

*Stelling.* Zij $n in NN_0$ en zijn $A, L, U in RR^(n times n)$ matrices. Veronderstel dat $L$ onderdriehoekig is, dat $U$ bovendriehoekig is en dat $forall i in {1, ..., n}: L_(i i) = 1$. Veronderstel bovendien dat $A = L U$. Dan geldt

#{
  set math.equation(numbering: "(1)", supplement: "vergelijking")
  [$ forall i in {1, ..., n}: cases(
    U_(i k) = A_(i k) - sum_(j = 1)^(i - 1) L_(i j) U_(j k) quad & forall k in {i, ..., n},
    L_(k i) = (A_(k i) - sum_(j = 1)^(i - 1) L_(k j) U_(j i)) / U_(i i) & forall k in {i + 1, ..., n}
  ) $ <bewijslast>]
}

*Bewijs.* We gebruiken een bewijs via inductie, over de dimensie van $A$, $L$ en $U$.

*Basisstap:* $n = 1$ \
De kwantor $forall i in {1, ..., n}$ kan vereenvoudigd worden tot $i = 1$. Zo kunnen we ook $forall k in {i, ..., n}$ vereenvoudigen tot $k = 1$. Ingevuld leidt dit tot de volgende bewijslast:

$ U_(1 1) = A_(1 1) - sum_(j = 1)^(0) L_(1 j) U_(j 1) and L_(1 1) = (A_(1 1) - sum_(j = 1)^(0) L_(1 j) U_(j 1))/U_(1 1) $

We gebruiken hier de conventie dat een som die itereert van een hogere naar een lagere index gelijk is aan nul -- immers zijn er geen termen in de som, aangezien geen enkel natuurlijk getal $j$ kan voldoen aan $j >= 1 and j <= 0$. Dus rest ons te bewijzen dat $ U_(1 1) = A_(1 1) and L_(1 1) = A_(1 1)/U_(1 1). $

Gegeven dat alle diagonaalelementen van $L$ gelijk zijn aan 1, weten we dat in het bijzonder $L_(1 1) = 1$. Aangezien $A = L U$ kunnen we over het element $A_(1 1)$ zeggen dat het gelijk moet zijn aan $sum_(j = 1)^(1) L_(1 j) U_(j 1) = L_(1 1) dot.op U_(1 1)$. Omdat $L_(1 1) = 1$, geldt $U_(1 1) = A_(1 1)$. Dus is ook $L_(1 1) = A_(1 1)/U_(1 1)$. Hiermee is de basisstap aangetoond.

*Inductiestap:* als @bewijslast geldt voor $n$, dan geldt ze ook voor $n + 1$. \
Zij $A in RR^((n + 1) times (n + 1))$ de matrix waarvoor we de bewijslast willen aantonen, en zij $A' in RR^(n times n) := A[1, 2, ..., n; 1, 2, ..., n]$ een submatrix van $A$ waarvoor @bewijslast al geldt, met $L'$ en $U'$ de desbetreffende decompositie. Zijn tenslotte $L$ en $U$ de resultaten van de LU-decompositie van $A$.

We definiëren een rijvector $R in RR^(1 times n)$ en een kolomvector $K in RR^(n times 1)$ als volgt: 
$ R = mat(A_(n+1, 1), A_(n+1, 2), dots.c, A_(n+1, n)) \ K = mat(A_(1, n+1), A_(2, n+1), dots.c, A_(n, n+1))^T $

Voor beide gebruiken we de notatie $R_n$ resp. $K_n$ om het $n$-de element van de vector aan te duiden.

/*
Dan kunnen we $A$ als blokmatrix noteren:
$ A = mat(
  #rect(width: 5em, height: 5em, align(horizon, [$A'$])), 
  #rect(            height: 5em, align(horizon, [$K$])) ; 
  #rect(width: 5em,              align(horizon, [$R$])), 
  A_(n+1, n+1)
) $
*/

Merk op dat we de propositie alleen nog moeten aantonen voor $i = n + 1$. Immers, wegens de inductiehypothese geldt de uitspraak al $forall i in {1, ..., n}$. De bewijslast valt dus te reduceren tot drie onderdelen:

+ $forall k in {1, ..., n}: U_(i+1, k) = R_k - sum_(j = 1)^(n + 1) L_(n+1, j) U_(j k)$

= Opdracht 4

Waar algoritme 5.1 een indexvariabele `k` gebruikt die van `n` tot `1` loopt, gebruiken we in de voorwaartse substitutie een variabele die van `1` tot `n` loopt, aangezien we bij de eerste rij beginnen.
Verder is het idee achter de oplossingsmethode identiek: omdat de matrices driehoekig kunnen we de rijen op zo'n manier doorlopen dat elke volgende rij extra informatie geeft over één variabele van het stelsel; we nemen dan een lineaire combinatie van de al gekende waarden om die nieuwe variabele te isoleren. Na een deling door het resterende element bekomen we de correcte waarde voor de variabele.